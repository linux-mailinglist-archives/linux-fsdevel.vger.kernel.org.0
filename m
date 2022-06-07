Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09FA54202A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiFHASe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835781AbiFGX47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:56:59 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A96FCEE7
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GXw3AYhWJWX3Hvmoi6F+MxF6hJQUiYuM5qPkHcPGjWI=; b=KeshvNaht/piCnPJihvJ+vG72C
        6+9TTnElJ4xZDsoJBoPrhVMmPtMFeUXDmMIXAi07ZHLCrMd2quuBIGVmxQa7HdlmDJszax2w2SypN
        JFr4F3qowzTs87fVGhyTBzkiOwdtlAoCPmUmdVtohilW3xDih0UovuWbD0WKOYD5QOtTz32mA0a8b
        gn8uoa58sFLoRXCGh8AEYmPs7oFDmkXbYD96aYBgTJZ8IXr1Stiab6D0jNb5Shv6F9qdNRA+lQQln
        O7zMeN3gPyXNPQgC2SNV2s6uL0ncCpRjecxq1zXdHvi8jS9a8Q9Dx/mTMe54KjF4OdaXbW6kbFCim
        hqVAih8A==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyifn-004ttL-Ne; Tue, 07 Jun 2022 23:31:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 03/10] btrfs: use IOMAP_DIO_NOSYNC
Date:   Tue,  7 Jun 2022 23:31:36 +0000
Message-Id: <20220607233143.1168114-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
 <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... instead of messing with iocb flags

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/file.c  | 17 -----------------
 fs/btrfs/inode.c |  3 ++-
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1fd827b99c1b..98f81e304eb1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1848,7 +1848,6 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 
 static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -1901,15 +1900,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto buffered;
 	}
 
-	/*
-	 * We remove IOCB_DSYNC so that we don't deadlock when iomap_dio_rw()
-	 * calls generic_write_sync() (through iomap_dio_complete()), because
-	 * that results in calling fsync (btrfs_sync_file()) which will try to
-	 * lock the inode in exclusive/write mode.
-	 */
-	if (is_sync_write)
-		iocb->ki_flags &= ~IOCB_DSYNC;
-
 	/*
 	 * The iov_iter can be mapped to the same file range we are writing to.
 	 * If that's the case, then we will deadlock in the iomap code, because
@@ -1964,13 +1954,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	btrfs_inode_unlock(inode, ilock_flags);
 
-	/*
-	 * Add back IOCB_DSYNC. Our caller, btrfs_file_write_iter(), will do
-	 * the fsync (call generic_write_sync()).
-	 */
-	if (is_sync_write)
-		iocb->ki_flags |= IOCB_DSYNC;
-
 	/* If 'err' is -ENOTBLK then it means we must fallback to buffered IO. */
 	if ((err < 0 && err != -ENOTBLK) || !iov_iter_count(from))
 		goto out;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 81737eff92f3..fbf0aee7d66a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8152,7 +8152,8 @@ ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_befo
 	struct btrfs_dio_data data;
 
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
+			    IOMAP_DIO_PARTIAL | IOMAP_DIO_NOSYNC,
+			    &data, done_before);
 }
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.30.2

