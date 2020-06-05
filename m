Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A501F012E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 22:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFEUst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 16:48:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgFEUst (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:48:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C4770AC51;
        Fri,  5 Jun 2020 20:48:50 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     darrick.wong@oracle.com
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com,
        linux-fsdevel@vger.kernel.org, hch@lst.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/3] iomap: dio Return zero in case of unsuccessful pagecache invalidation
Date:   Fri,  5 Jun 2020 15:48:36 -0500
Message-Id: <20200605204838.10765-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200605204838.10765-1-rgoldwyn@suse.de>
References: <20200605204838.10765-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Filesystems such as btrfs are unable to guarantee page invalidation
because extents could be locked because of an ongoing I/O. This happens
even though a filemap_write_and_wait() has been called because
btrfs locks extents in a separate cleanup thread until all ordered
extents in range have performed the tree changes.

Return zero in case a page cache invalidation is unsuccessful so
filesystems can fallback to buffered I/O.

This takes care of the following invalidation warning during btrfs
mixed buffered and direct I/O using iomap_dio_rw():

Page cache invalidation failure on direct I/O.  Possible data
corruption due to collision with buffered I/O!

This is similar to the behavior of generic_file_direct_write().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/direct-io.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e4addfc58107..215315be6233 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 */
 	ret = invalidate_inode_pages2_range(mapping,
 			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
-	if (ret)
-		dio_warn_stale_pagecache(iocb->ki_filp);
-	ret = 0;
+	/*
+	 * If a page can not be invalidated, return 0 to fall back
+	 * to buffered write.
+	 */
+	if (ret) {
+		if (ret == -EBUSY)
+			ret = 0;
+		goto out_free_dio;
+	}
 
 	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
 	    !inode->i_sb->s_dio_done_wq) {
-- 
2.25.0

