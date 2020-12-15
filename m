Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C232DB341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 19:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgLOSHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 13:07:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:58454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbgLOSHV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:07:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE9E5AE4B;
        Tue, 15 Dec 2020 18:06:39 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     darrick.wong@oracle.com, hch@infradead.org, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/2] iomap: Separate out generic_write_sync() from iomap_dio_complete()
Date:   Tue, 15 Dec 2020 12:06:35 -0600
Message-Id: <f52d649dd35c616786b54ff7d76c6bcf95f9197e.1608053602.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608053602.git.rgoldwyn@suse.com>
References: <cover.1608053602.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This introduces a separate function __iomap_dio_complte() which
completes the Direct I/O without performing the write sync.

Filesystems such as btrfs which require an inode_lock for sync can call
__iomap_dio_complete() and must perform sync on their own after unlock.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/direct-io.c  | 16 +++++++++++++---
 include/linux/iomap.h |  2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..11a108f39fd9 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -76,7 +76,7 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 		dio->submit.cookie = submit_bio(bio);
 }
 
-ssize_t iomap_dio_complete(struct iomap_dio *dio)
+ssize_t __iomap_dio_complete(struct iomap_dio *dio)
 {
 	const struct iomap_dio_ops *dops = dio->dops;
 	struct kiocb *iocb = dio->iocb;
@@ -119,18 +119,28 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	}
 
 	inode_dio_end(file_inode(iocb->ki_filp));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__iomap_dio_complete);
+
+ssize_t iomap_dio_complete(struct iomap_dio *dio)
+{
+	ssize_t ret;
+
+	ret = __iomap_dio_complete(dio);
 	/*
 	 * If this is a DSYNC write, make sure we push it to stable storage now
 	 * that we've written data.
 	 */
 	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
-		ret = generic_write_sync(iocb, ret);
+		ret = generic_write_sync(dio->iocb, ret);
 
 	kfree(dio);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iomap_dio_complete);
+
 
 static void iomap_dio_complete_work(struct work_struct *work)
 {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5bd3cac4df9c..5785dc0b8ec5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -262,7 +262,7 @@ ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		bool wait_for_completion);
-ssize_t iomap_dio_complete(struct iomap_dio *dio);
+ssize_t __iomap_dio_complete(struct iomap_dio *dio);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
-- 
2.29.2

