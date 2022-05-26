Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3565353EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 21:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348076AbiEZT31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343822AbiEZT30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 15:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4A04BB83
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7+9Omejagtyb1cWwupsBNwVl4CjZDgx5NNVeSD7Uzo4=; b=MLK0kR6Z+lHced1doT0nm+rzK1
        IlE5uRtI0zx6KCYxbhqYInvjP/THjKbn+D6p4dJWIRvBWD3QLA0BJekY4STi9rZ4vT3DQ4qMvuSTt
        UhkmDZkjivc3aTI+YI1+B6PF2h2nVMZXIicY+zJ7QZoqZVofn/Zx+2wX13CxdqOHuchF4/0WbBeCx
        Pi3LTFyq2PKXMrAkrFu6S01H2jBwCKYmJfQemWEUXKIcrupNv0GthX2FhsDeGMi9EDior5ic7dhfi
        HPZG2UOQBR0cIw3XkDpu3Y5ZJu6xNyeKxW2nYdHO8RHEben4HViBqeejePG8qPvqXRAB3nim8KLD1
        44Yb97tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJAa-001UuZ-VG; Thu, 26 May 2022 19:29:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 5/9] jfs: Remove old direct_IO support
Date:   Thu, 26 May 2022 20:29:06 +0100
Message-Id: <20220526192910.357055-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220526192910.357055-1-willy@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that reads and writes both use iomap for O_DIRECT, this code has
no more callers and can be removed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/inode.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 22e8a5612fdc..63690020cc46 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -368,31 +368,6 @@ static sector_t jfs_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
 
-static ssize_t jfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = file->f_mapping->host;
-	size_t count = iov_iter_count(iter);
-	ssize_t ret;
-
-	ret = blockdev_direct_IO(iocb, inode, iter, jfs_get_block);
-
-	/*
-	 * In case of error extending write may have instantiated a few
-	 * blocks outside i_size. Trim these off again.
-	 */
-	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
-		loff_t isize = i_size_read(inode);
-		loff_t end = iocb->ki_pos + count;
-
-		if (end > isize)
-			jfs_write_failed(mapping, end);
-	}
-
-	return ret;
-}
-
 const struct address_space_operations jfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
@@ -403,7 +378,7 @@ const struct address_space_operations jfs_aops = {
 	.write_begin	= jfs_write_begin,
 	.write_end	= nobh_write_end,
 	.bmap		= jfs_bmap,
-	.direct_IO	= jfs_direct_IO,
+	.direct_IO	= noop_direct_IO,
 };
 
 /*
-- 
2.34.1

