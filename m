Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D58055415A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356711AbiFVEP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354898AbiFVEP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:56 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D169FB71
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7lD6VdCM50uacW9sJatiXz/xAyinAw9nJvdvluAi4MM=; b=OUok2TU3aN4EsMFe9veVlfvE/P
        DNA2p8rTzhttKjXgs+yAdFQ3V7fmdJCzxDVSi3suo5Od0NGbnCPFFewyHIYU26DD3wjVOkJcAbEPt
        HiZAEW+XWDlP6G28nXT9U6FHR5T3DPEBxdEZLTAWddd2qEWrPIsh9ebdEhaNbX8MLojzQytIHdp7P
        g9s4YW8m/a/zgTyuXJDaTgdTisU17uIhqRt1s69ejOvbekuwvmlBWSYmVeBXfkOt0aUTbrrsacVFz
        0aYrAoog7a0W6gmjbqePS9xBlFxQpEup8tJw/5At8hA4TFTPb0JYsluXrSxWO4iH4D71xdo1NrmUu
        hik2QSAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmT-0035vT-3W;
        Wed, 22 Jun 2022 04:15:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 04/44] btrfs: use IOMAP_DIO_NOSYNC
Date:   Wed, 22 Jun 2022 05:15:12 +0100
Message-Id: <20220622041552.737754-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... instead of messing with iocb flags

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
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

