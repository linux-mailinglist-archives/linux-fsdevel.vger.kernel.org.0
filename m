Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C1B277701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgIXQkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:40:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbgIXQkP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:40:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C0C8B296;
        Thu, 24 Sep 2020 16:40:13 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 13/14] btrfs: Call iomap_dio_complete() without inode_lock
Date:   Thu, 24 Sep 2020 11:39:20 -0500
Message-Id: <20200924163922.2547-14-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924163922.2547-1-rgoldwyn@suse.de>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

If direct writes are called with O_DIRECT | O_DSYNC, it will result in a
deadlock because iomap_dio_rw() is called under i_rwsem which calls
iomap_dio_complete()
  generic_write_sync()
    btrfs_sync_file().

btrfs_sync_file() requires i_rwsem, so call __iomap_dio_rw() with the
i_rwsem locked, and call iomap_dio_complete() after unlocking i_rwsem.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6854bf78d677..e28bd3134efd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1982,6 +1982,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	loff_t endbyte;
 	int err;
 	int ilock_flags = 0;
+	struct iomap_dio *dio = NULL;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -2021,22 +2022,19 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto buffered;
 	}
 
-	/*
-	 * We have are actually a sync iocb, so we need our fancy endio to know
-	 * if we need to sync.
-	 */
-	if (current->journal_info)
-		written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
-				&btrfs_sync_dops, is_sync_kiocb(iocb));
-	else
-		written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
-				&btrfs_dio_ops, is_sync_kiocb(iocb));
-
-	if (written == -ENOTBLK)
-		written = 0;
+	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
+			&btrfs_dio_ops, is_sync_kiocb(iocb));
 
 	btrfs_inode_unlock(inode, ilock_flags);
 
+	if (IS_ERR_OR_NULL(dio)) {
+		err = PTR_ERR_OR_ZERO(dio);
+		if (err < 0 && err != -ENOTBLK)
+			goto out;
+	} else {
+		written = iomap_dio_complete(dio);
+	}
+
 	if (written < 0 || !iov_iter_count(from)) {
 		err = written;
 		goto out;
-- 
2.26.2

