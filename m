Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824281698AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 17:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgBWQss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 11:48:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWQss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 11:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZXVM1obNIPvyOdoY+8zuEA19LNNCiJ70ytgbN6LmRpY=; b=qfUeoVX7tWQMM6jixv4fxqARfj
        mAzlwDyOG+ZUeJEY7ZL/jPco7Fqu/mWGYNl5ADaNtYByRrahYWM76/sNyv5l/ZJ7yGZUbTSTvfzQu
        BOVXSWHKFQoyZTLD2zJVGT6i04MEw05o6heLHfU67ocBtWK9skCqHbVOKC1WyXVd7bsqSmhueslWt
        9bYNCWjQtIld42EvM9+ckfSOjG5i/g7LBsg7Z2ofoKRBWN8ExK8TAoMQEfjB79brU5bm6WJN4RyOs
        JPWA4Q0cDG+bPIllZhvTwkGpgBTkV9Dm9UcjdVj3flLEobF3vHInvERFQjVnnaWM8pfc86R0t1Kf5
        2QcLkhZA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5uQy-0003X3-Fu
        for linux-fsdevel@vger.kernel.org; Sun, 23 Feb 2020 16:48:48 +0000
Date:   Sun, 23 Feb 2020 08:48:48 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Subject: [RFC] isofs iomap conversion
Message-ID: <20200223164848.GK24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is just a toy, not intended for inclusion.  A real conversion would
strip buffer_heads entirely from isofs, and convert zisofs.

I decided I wanted to know more about how iomap works, and the easiest
way to do that is to convert a filesystem.  isofs recommended itself to
me as being read-only and pretty simple.

I like how it worked out; it's simpler than the isofs_get_blocks()
routine that it mostly replaces.  It's probably buggy; it compiles, but
I haven't tried it against an actual iso9660 filesystem.  I'd probably
want to copy some of the error printks over from isofs_get_blocks()
if this were anything other than a toy.

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 95b1f377ad09..61b14f359804 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -26,6 +26,7 @@
 #include <linux/user_namespace.h>
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
+#include <linux/iomap.h>
 
 #include "isofs.h"
 #include "zisofs.h"
@@ -1142,31 +1143,63 @@ int isofs_get_blocks(struct inode *inode, sector_t iblock,
 	return rv != 0 ? rv : error;
 }
 
-/*
- * Used by the standard interfaces.
- */
-static int isofs_get_block(struct inode *inode, sector_t iblock,
-		    struct buffer_head *bh_result, int create)
+static int isofs_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
-	int ret;
+	struct inode *ninode = inode;
+	int section = 0;
+	loff_t start = 0;
+	int err = -EIO;
+	struct iso_inode_info *ei;
 
-	if (create) {
-		printk(KERN_DEBUG "%s: Kernel tries to allocate a block\n", __func__);
-		return -EROFS;
+	for (;;) {
+		unsigned long nextblk, nextoff;
+
+		ei = ISOFS_I(ninode);
+		if (pos < start + ei->i_section_size)
+			break;
+		start += ei->i_section_size;
+		if (++section > 100)
+			goto abort;
+		nextblk = ei->i_next_section_block;
+		if (!nextblk)
+			goto abort;
+		nextoff = ei->i_next_section_offset;
+		if (ninode != inode)
+			iput(ninode);
+		ninode = isofs_iget(inode->i_sb, nextblk, nextoff);
+		if (IS_ERR(ninode)) {
+			err = PTR_ERR(ninode);
+			goto abort;
+		}
 	}
 
-	ret = isofs_get_blocks(inode, iblock, &bh_result, 1);
-	return ret < 0 ? ret : 0;
+	iomap->addr = (u64)ei->i_first_extent << inode->i_blkbits;
+	iomap->offset = start;
+	iomap->length = ei->i_section_size;
+	iomap->type = IOMAP_MAPPED;
+	iomap->flags = 0;
+	iomap->bdev = inode->i_bdev;
+	err = 0;
+abort:
+	if (ninode != inode)
+		iput(ninode);
+	return err;
 }
 
+const struct iomap_ops isofs_iomap_ops = {
+	.iomap_begin		= isofs_iomap_begin,
+};
+
 static int isofs_bmap(struct inode *inode, sector_t block)
 {
 	struct buffer_head dummy;
+	struct buffer_head *bhp = &dummy;
 	int error;
 
 	dummy.b_state = 0;
 	dummy.b_blocknr = -1000;
-	error = isofs_get_block(inode, block, &dummy, 0);
+	error = isofs_get_blocks(inode, block, &bhp, 1);
 	if (!error)
 		return dummy.b_blocknr;
 	return 0;
@@ -1182,17 +1215,17 @@ struct buffer_head *isofs_bread(struct inode *inode, sector_t block)
 
 static int isofs_readpage(struct file *file, struct page *page)
 {
-	return mpage_readpage(page, isofs_get_block);
+	return iomap_readpage(page, &isofs_iomap_ops);
 }
 
 static void isofs_readahead(struct readahead_control *rac)
 {
-	mpage_readahead(rac, isofs_get_block);
+	iomap_readahead(rac, &isofs_iomap_ops);
 }
 
 static sector_t _isofs_bmap(struct address_space *mapping, sector_t block)
 {
-	return generic_block_bmap(mapping,block,isofs_get_block);
+	return iomap_bmap(mapping, block, &isofs_iomap_ops);
 }
 
 static const struct address_space_operations isofs_aops = {
