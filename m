Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E9D7121D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242441AbjEZIHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEZIHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:07:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339BA3;
        Fri, 26 May 2023 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DAqGFJ28glJE4ZP3/Vn+DHN/P/C6GAqumynKOxNDeSk=; b=a6cT2qqWdXXLmvoaraOfyw/kp/
        wO2Ux6i3iGYwDAhCjfC5XV0OxJAeH0lzK0O9Dp6jSObJykoaF4Ofc0jhNY+sQLdSQo10Vj02L+khf
        3oeWWL1OE/AG5Kuo7BiqKdJBxfMbaiPKstv2hFXJFGAfjs/gt4Yf46acq7Kb6IgCMt2xg915Nygvs
        10EXC35fWpRdmAq26Sz8ohRDv3NJxy+JnOjBtSb4X0zy223fcyPi/IKLhiW7G6ySTsPnyYxBJxN9o
        MozjKOb8s2OmwRSYFch+gJE3Er8ZHmKRQR+kr90JcV8rxHLzissr/WdkXQLJ4BTUbYJ9S68GrsEiV
        LGWU13+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2STw-001YTx-2K;
        Fri, 26 May 2023 08:07:28 +0000
Date:   Fri, 26 May 2023 01:07:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org, hare@suse.de,
        kbusch@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 0/8] add support for blocksize > PAGE_SIZE
Message-ID: <ZHBowMEDfyrAAOWH@bombadil.infradead.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526075552.363524-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 12:55:44AM -0700, Luis Chamberlain wrote:
> Future work:
> 
>   o shmem_file_read_iter()

And as for this, this is what I'm up to, but for the life of me I can't
figure out why I end up with an empty new line at the end of my test
with this, the same simple test as described in the patch "shmem: add
support to customize block size order".

I end up with:

root@iomap ~ # ./run.sh 
2dcc06b7ca3b7dd8b5626af83c1be3cb08ddc76c  /root/ordered.txt
a0466a798f2d967c143f0f716c344660dc360f78  /data-tmpfs/ordered.txt
  File: /data-tmpfs/ordered.txt
    Size: 6888896         Blocks: 16384      IO Block: 4194304 regular
    file
    Device: 0,44    Inode: 2           Links: 1
    Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/
    root)
    Access: 2023-05-26 01:06:15.566330524 -0700
    Modify: 2023-05-26 01:06:15.554330477 -0700
    Change: 2023-05-26 01:06:15.554330477 -0700
     Birth: 2023-05-26 01:06:15.534330399 -0700

root@iomap ~ # diff -u /root/ordered.txt /data-tmpfs/ordered.txt 
--- /root/ordered.txt   2023-05-25 16:50:53.755019418 -0700
+++ /data-tmpfs/ordered.txt     2023-05-26 01:06:15.554330477 -0700
@@ -999998,3 +999998,4 @@
 999998
 999999
 1000000
+
\ No newline at end of file

root@iomap ~ # cat run.sh 
#!/bin/bash

# time for i in $(seq 1 1000000); do echo $i >>
# /root/ordered.txt; done

sha1sum /root/ordered.txt
mount -t tmpfs            -o size=8M,border=22 -o noswap tmpfs
/data-tmpfs/
cp /root/ordered.txt /data-tmpfs/
sha1sum /data-tmpfs/ordered.txt
stat /data-tmpfs/ordered.txt

From 61008f03217b1524da317928885ef68a67abc773 Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Wed, 19 Apr 2023 20:42:54 -0700
Subject: [PATCH] shmem: convert shmem_file_read_iter() to folios

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 74 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 18 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 777e953df62e..2d3512f6dd30 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2431,6 +2431,10 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 		inode->i_ino = ino;
 		inode_init_owner(idmap, inode, dir, mode);
 		inode->i_blocks = 0;
+		if (sb->s_flags & SB_KERNMOUNT)
+			inode->i_blkbits = PAGE_SHIFT;
+		else
+			inode->i_blkbits = sb->s_blocksize_bits;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_generation = get_random_u32();
 		info = SHMEM_I(inode);
@@ -2676,19 +2680,42 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
+	struct super_block *sb = inode->i_sb;
+	u64 bsize = i_blocksize(inode);
 	pgoff_t index;
 	unsigned long offset;
 	int error = 0;
 	ssize_t retval = 0;
 	loff_t *ppos = &iocb->ki_pos;
 
+	/*
+	 * Although our index is page specific, we can read a blocksize at a
+	 * time as we use a folio per block.
+	 */
 	index = *ppos >> PAGE_SHIFT;
-	offset = *ppos & ~PAGE_MASK;
+
+	/*
+	 * We're going to read a folio at a time of size blocksize.
+	 *
+	 * The offset represents the position in the folio where we are
+	 * currently doing reads on. It starts off by the offset position in the
+	 * first folio where we were asked to start our read. It later gets
+	 * incremented by the number of bytes we read per folio.  After the
+	 * first folio is read offset would be 0 as we are starting to read the
+	 * next folio at offset 0. We'd then read a full blocksize at a time
+	 * until we're done.
+	 */
+	offset = *ppos & (bsize - 1);
 
 	for (;;) {
 		struct folio *folio = NULL;
-		struct page *page = NULL;
 		pgoff_t end_index;
+		/*
+		 * nr represents the number of bytes we can read per folio,
+		 * and this will depend on the blocksize set. On the last
+		 * folio nr represents how much data on the last folio is
+		 * valid to be read on the inode.
+		 */
 		unsigned long nr, ret;
 		loff_t i_size = i_size_read(inode);
 
@@ -2696,7 +2723,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (index > end_index)
 			break;
 		if (index == end_index) {
-			nr = i_size & ~PAGE_MASK;
+			nr = i_size & (bsize - 1);
 			if (nr <= offset)
 				break;
 		}
@@ -2709,9 +2736,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 		if (folio) {
 			folio_unlock(folio);
-
-			page = folio_file_page(folio, index);
-			if (PageHWPoison(page)) {
+			if (is_folio_hwpoison(folio)) {
 				folio_put(folio);
 				error = -EIO;
 				break;
@@ -2722,49 +2747,56 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		 * We must evaluate after, since reads (unlike writes)
 		 * are called without i_rwsem protection against truncate
 		 */
-		nr = PAGE_SIZE;
+		nr = bsize;
+		WARN_ON(!(sb->s_flags & SB_KERNMOUNT) && folio && bsize != folio_size(folio));
 		i_size = i_size_read(inode);
 		end_index = i_size >> PAGE_SHIFT;
 		if (index == end_index) {
-			nr = i_size & ~PAGE_MASK;
+			nr = i_size & (bsize - 1);
 			if (nr <= offset) {
 				if (folio)
 					folio_put(folio);
 				break;
 			}
 		}
+
+		/*
+		 * On the first folio read the number of bytes we can read
+		 * will be blocksize - offset. On subsequent reads we can read
+		 * blocksize at time until iov_iter_count(to) == 0.
+		 */
 		nr -= offset;
 
 		if (folio) {
 			/*
-			 * If users can be writing to this page using arbitrary
+			 * If users can be writing to this folio using arbitrary
 			 * virtual addresses, take care about potential aliasing
-			 * before reading the page on the kernel side.
+			 * before reading the folio on the kernel side.
 			 */
 			if (mapping_writably_mapped(mapping))
-				flush_dcache_page(page);
+				flush_dcache_folio(folio);
 			/*
-			 * Mark the page accessed if we read the beginning.
+			 * Mark the folio accessed if we read the beginning.
 			 */
 			if (!offset)
 				folio_mark_accessed(folio);
 			/*
-			 * Ok, we have the page, and it's up-to-date, so
+			 * Ok, we have the folio, and it's up-to-date, so
 			 * now we can copy it to user space...
 			 */
-			ret = copy_page_to_iter(page, offset, nr, to);
+			ret = copy_folio_to_iter(folio, offset, nr, to);
 			folio_put(folio);
 
 		} else if (user_backed_iter(to)) {
 			/*
 			 * Copy to user tends to be so well optimized, but
 			 * clear_user() not so much, that it is noticeably
-			 * faster to copy the zero page instead of clearing.
+			 * faster to copy the zero folio instead of clearing.
 			 */
-			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
+			ret = copy_folio_to_iter(page_folio(ZERO_PAGE(0)), offset, nr, to);
 		} else {
 			/*
-			 * But submitting the same page twice in a row to
+			 * But submitting the same folio twice in a row to
 			 * splice() - or others? - can result in confusion:
 			 * so don't attempt that optimization on pipes etc.
 			 */
@@ -2773,8 +2805,14 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		retval += ret;
 		offset += ret;
+
+		/*
+		 * Due to usage of folios per blocksize we know this will
+		 * actually read blocksize at a time after the first block read
+		 * at offset.
+		 */
 		index += offset >> PAGE_SHIFT;
-		offset &= ~PAGE_MASK;
+		offset &= (bsize - 1);
 
 		if (!iov_iter_count(to))
 			break;
-- 
2.39.2

