Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595C667978A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjAXMS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjAXMSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960037F0D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8AA7B2188D;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NrTzcsfeVSPhQW4+qHyxmsmg9W/1UUS0Rh80tO0reIE=;
        b=gnbd1krrrNydf5atCF8CaDAeU/l3xJA7pqOVc0UxlKdknVkvlUaR75KlWLIiw0NUaKePSf
        l0PkNX/mMMuPjmBAj8ll9p7hkkbs/NKdu0ekqaiTbKG7q5wMEnlmmTZi0e1ZgsFGkDXg3j
        7Ot6Di6dyC4yc854QBGQb3l/re61vJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NrTzcsfeVSPhQW4+qHyxmsmg9W/1UUS0Rh80tO0reIE=;
        b=9dE7RHTDnGBvZMWCjOtStwuZ8rpew1M6OYUXvQwlSSX4/qRgYojixAr4JzaQnJh6U6PKlk
        TUWZdfp6rLjVglCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76CC1139FF;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wcD4HIbMz2PJNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0CEF8A06B9; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 02/22] udf: Drop VARCONV support
Date:   Tue, 24 Jan 2023 13:17:48 +0100
Message-Id: <20230124121814.25951-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10655; i=jack@suse.cz; h=from:subject; bh=X7SvJp8qryRXT2VYhNSSebNhMWTQtYVZuXIh3NOB+Ro=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8xuG5rW51uktuSIsv9OO6nAV2AFoc/mtuv3qYoM d6cU5XiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MbgAKCRCcnaoHP2RA2co4B/ 9la0IYhk22P/0tajAe+dsdSIlwRRik9xnNa6Wpwz7rHns+5MgOjrwbFQQBwp1pTFpTkJMFMQBUxW4T Jw1IVZJkc1MG1Y6nf9t/C29v0qbRNQ1n9PitL2bBPHkW0yqEXT0n3JmWtWmfmLQONXYRQJHEDgYG2U qaVra7sTNmD9c6chyJNWZfTEVFrVD2ajT1l79mowai/+BE0xRF1NMRcKiZLuM+Lk9iuhL2q4HWDmIh KI8tb+7IrtUhkmQpYyNqHxl2o/hPAM8EOB2C5AhOLMcwyIPPrQ1k5D0rpgQGz5X561+Hh0AI0ZFdxT ZROWFKME5L/XGx4b+zwYk4lkAzAOCX
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UDF was supporting a strange mode where the media was containing 7
blocks of unknown data for every 32 blocks of the filesystem. I have yet
to see the media that would need such conversion (maybe it comes from
packet writing times) and the conversions have been inconsistent in the
code. In particular any write will write to a wrong block and corrupt
the media. This is an indication and no user actually needs this so
let's just drop the support instead of trying to fix it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/balloc.c    |  2 +-
 fs/udf/directory.c |  4 ++--
 fs/udf/inode.c     | 11 ++++------
 fs/udf/misc.c      | 18 +----------------
 fs/udf/namei.c     |  4 ++--
 fs/udf/super.c     | 50 +++-------------------------------------------
 fs/udf/truncate.c  |  2 +-
 fs/udf/udf_sb.h    |  1 -
 fs/udf/udfdecl.h   |  6 ------
 9 files changed, 14 insertions(+), 84 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 8e597db4d971..cdf90928b7f2 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -42,7 +42,7 @@ static int read_block_bitmap(struct super_block *sb,
 	loc.logicalBlockNum = bitmap->s_extPosition;
 	loc.partitionReferenceNum = UDF_SB(sb)->s_partition;
 
-	bh = udf_tread(sb, udf_get_lb_pblock(sb, &loc, block));
+	bh = sb_bread(sb, udf_get_lb_pblock(sb, &loc, block));
 	if (!bh)
 		retval = -EIO;
 
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 0f3cc095b2a3..ae61814c195b 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -141,7 +141,7 @@ static void udf_readahead_dir(struct udf_fileident_iter *iter)
 	for (i = 0; i < ralen; i++) {
 		blk = udf_get_lb_pblock(iter->dir->i_sb, &iter->eloc,
 					iter->loffset + i);
-		tmp = udf_tgetblk(iter->dir->i_sb, blk);
+		tmp = sb_getblk(iter->dir->i_sb, blk);
 		if (tmp && !buffer_uptodate(tmp) && !buffer_locked(tmp))
 			bha[num++] = tmp;
 		else
@@ -160,7 +160,7 @@ static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
 
 	udf_readahead_dir(iter);
 	blk = udf_get_lb_pblock(iter->dir->i_sb, &iter->eloc, iter->loffset);
-	return udf_tread(iter->dir->i_sb, blk);
+	return sb_bread(iter->dir->i_sb, blk);
 }
 
 /*
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index a504c7650551..2b3fc897d1b3 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1594,7 +1594,7 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
-	bh = udf_tgetblk(inode->i_sb,
+	bh = sb_getblk(inode->i_sb,
 			udf_get_lb_pblock(inode->i_sb, &iinfo->i_location, 0));
 	if (!bh) {
 		udf_debug("getblk failure\n");
@@ -1854,7 +1854,7 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	neloc.logicalBlockNum = block;
 	neloc.partitionReferenceNum = epos->block.partitionReferenceNum;
 
-	bh = udf_tgetblk(sb, udf_get_lb_pblock(sb, &neloc, 0));
+	bh = sb_getblk(sb, udf_get_lb_pblock(sb, &neloc, 0));
 	if (!bh)
 		return -EIO;
 	lock_buffer(bh);
@@ -2071,7 +2071,7 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 		epos->offset = sizeof(struct allocExtDesc);
 		brelse(epos->bh);
 		block = udf_get_lb_pblock(inode->i_sb, &epos->block, 0);
-		epos->bh = udf_tread(inode->i_sb, block);
+		epos->bh = sb_bread(inode->i_sb, block);
 		if (!epos->bh) {
 			udf_debug("reading block %u failed!\n", block);
 			return -1;
@@ -2292,8 +2292,5 @@ udf_pblk_t udf_block_map(struct inode *inode, sector_t block)
 	up_read(&UDF_I(inode)->i_data_sem);
 	brelse(epos.bh);
 
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_VARCONV))
-		return udf_fixed_to_variable(ret);
-	else
-		return ret;
+	return ret;
 }
diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 1614d308d0f0..3777468d06ce 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -28,22 +28,6 @@
 #include "udf_i.h"
 #include "udf_sb.h"
 
-struct buffer_head *udf_tgetblk(struct super_block *sb, udf_pblk_t block)
-{
-	if (UDF_QUERY_FLAG(sb, UDF_FLAG_VARCONV))
-		return sb_getblk(sb, udf_fixed_to_variable(block));
-	else
-		return sb_getblk(sb, block);
-}
-
-struct buffer_head *udf_tread(struct super_block *sb, udf_pblk_t block)
-{
-	if (UDF_QUERY_FLAG(sb, UDF_FLAG_VARCONV))
-		return sb_bread(sb, udf_fixed_to_variable(block));
-	else
-		return sb_bread(sb, block);
-}
-
 struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
 					   uint32_t type, uint8_t loc)
 {
@@ -216,7 +200,7 @@ struct buffer_head *udf_read_tagged(struct super_block *sb, uint32_t block,
 	if (block == 0xFFFFFFFF)
 		return NULL;
 
-	bh = udf_tread(sb, block);
+	bh = sb_bread(sb, block);
 	if (!bh) {
 		udf_err(sb, "read failed, block=%u, location=%u\n",
 			block, location);
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index f8091aa22fcd..49fab30afff3 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -171,7 +171,7 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 				0);
 	if (!newblock)
 		return NULL;
-	dbh = udf_tgetblk(inode->i_sb, newblock);
+	dbh = sb_getblk(inode->i_sb, newblock);
 	if (!dbh)
 		return NULL;
 	lock_buffer(dbh);
@@ -619,7 +619,7 @@ static int udf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		block = udf_get_pblock(sb, block,
 				iinfo->i_location.partitionReferenceNum,
 				0);
-		epos.bh = udf_tgetblk(sb, block);
+		epos.bh = sb_getblk(sb, block);
 		if (unlikely(!epos.bh)) {
 			err = -ENOMEM;
 			udf_free_blocks(sb, inode, &eloc, 0, 1);
diff --git a/fs/udf/super.c b/fs/udf/super.c
index c756d903a862..58a3148173ac 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -734,7 +734,7 @@ static int udf_check_vsd(struct super_block *sb)
 	 * added */
 	for (; !nsr && sector < VSD_MAX_SECTOR_OFFSET; sector += sectorsize) {
 		/* Read a block */
-		bh = udf_tread(sb, sector >> sb->s_blocksize_bits);
+		bh = sb_bread(sb, sector >> sb->s_blocksize_bits);
 		if (!bh)
 			break;
 
@@ -1839,10 +1839,6 @@ static int udf_check_anchor_block(struct super_block *sb, sector_t block,
 	uint16_t ident;
 	int ret;
 
-	if (UDF_QUERY_FLAG(sb, UDF_FLAG_VARCONV) &&
-	    udf_fixed_to_variable(block) >= sb_bdev_nr_blocks(sb))
-		return -EAGAIN;
-
 	bh = udf_read_tagged(sb, block, block, &ident);
 	if (!bh)
 		return -EAGAIN;
@@ -1924,46 +1920,6 @@ static int udf_scan_anchors(struct super_block *sb, udf_pblk_t *lastblock,
 	return udf_check_anchor_block(sb, sbi->s_session + 512, fileset);
 }
 
-/*
- * Find an anchor volume descriptor and load Volume Descriptor Sequence from
- * area specified by it. The function expects sbi->s_lastblock to be the last
- * block on the media.
- *
- * Return <0 on error, 0 if anchor found. -EAGAIN is special meaning anchor
- * was not found.
- */
-static int udf_find_anchor(struct super_block *sb,
-			   struct kernel_lb_addr *fileset)
-{
-	struct udf_sb_info *sbi = UDF_SB(sb);
-	sector_t lastblock = sbi->s_last_block;
-	int ret;
-
-	ret = udf_scan_anchors(sb, &lastblock, fileset);
-	if (ret != -EAGAIN)
-		goto out;
-
-	/* No anchor found? Try VARCONV conversion of block numbers */
-	UDF_SET_FLAG(sb, UDF_FLAG_VARCONV);
-	lastblock = udf_variable_to_fixed(sbi->s_last_block);
-	/* Firstly, we try to not convert number of the last block */
-	ret = udf_scan_anchors(sb, &lastblock, fileset);
-	if (ret != -EAGAIN)
-		goto out;
-
-	lastblock = sbi->s_last_block;
-	/* Secondly, we try with converted number of the last block */
-	ret = udf_scan_anchors(sb, &lastblock, fileset);
-	if (ret < 0) {
-		/* VARCONV didn't help. Clear it. */
-		UDF_CLEAR_FLAG(sb, UDF_FLAG_VARCONV);
-	}
-out:
-	if (ret == 0)
-		sbi->s_last_block = lastblock;
-	return ret;
-}
-
 /*
  * Check Volume Structure Descriptor, find Anchor block and load Volume
  * Descriptor Sequence.
@@ -2004,7 +1960,7 @@ static int udf_load_vrs(struct super_block *sb, struct udf_options *uopt,
 
 	/* Look for anchor block and load Volume Descriptor Sequence */
 	sbi->s_anchor = uopt->anchor;
-	ret = udf_find_anchor(sb, fileset);
+	ret = udf_scan_anchors(sb, &sbi->s_last_block, fileset);
 	if (ret < 0) {
 		if (!silent && ret == -EAGAIN)
 			udf_warn(sb, "No anchor found\n");
@@ -2455,7 +2411,7 @@ static unsigned int udf_count_free_bitmap(struct super_block *sb,
 		if (bytes) {
 			brelse(bh);
 			newblock = udf_get_lb_pblock(sb, &loc, ++block);
-			bh = udf_tread(sb, newblock);
+			bh = sb_bread(sb, newblock);
 			if (!bh) {
 				udf_debug("read failed\n");
 				goto out;
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 036ebd892b85..3d2cfc7a1449 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -240,7 +240,7 @@ int udf_truncate_extents(struct inode *inode)
 			brelse(epos.bh);
 			epos.offset = sizeof(struct allocExtDesc);
 			epos.block = eloc;
-			epos.bh = udf_tread(sb,
+			epos.bh = sb_bread(sb,
 					udf_get_lb_pblock(sb, &eloc, 0));
 			/* Error reading indirect block? */
 			if (!epos.bh)
diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 6bccff3c70f5..9af6ff7f9747 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -23,7 +23,6 @@
 #define UDF_FLAG_STRICT			5
 #define UDF_FLAG_UNDELETE		6
 #define UDF_FLAG_UNHIDE			7
-#define UDF_FLAG_VARCONV		8
 #define UDF_FLAG_UID_FORGET     11    /* save -1 for uid to disk */
 #define UDF_FLAG_GID_FORGET     12
 #define UDF_FLAG_UID_SET	13
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index eaf9e6fd201e..88667a80795d 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -34,9 +34,6 @@ extern __printf(3, 4) void _udf_warn(struct super_block *sb,
 #define udf_debug(fmt, ...)					\
 	pr_debug("%s:%d:%s: " fmt, __FILE__, __LINE__, __func__, ##__VA_ARGS__)
 
-#define udf_fixed_to_variable(x) ( ( ( (x) >> 5 ) * 39 ) + ( (x) & 0x0000001F ) )
-#define udf_variable_to_fixed(x) ( ( ( (x) / 39 ) << 5 ) + ( (x) % 39 ) )
-
 #define UDF_EXTENT_LENGTH_MASK	0x3FFFFFFF
 #define UDF_EXTENT_FLAG_MASK	0xC0000000
 
@@ -179,9 +176,6 @@ extern int8_t udf_current_aext(struct inode *, struct extent_position *,
 extern void udf_update_extra_perms(struct inode *inode, umode_t mode);
 
 /* misc.c */
-extern struct buffer_head *udf_tgetblk(struct super_block *sb,
-					udf_pblk_t block);
-extern struct buffer_head *udf_tread(struct super_block *sb, udf_pblk_t block);
 extern struct genericFormat *udf_add_extendedattr(struct inode *, uint32_t,
 						  uint32_t, uint8_t);
 extern struct genericFormat *udf_get_extendedattr(struct inode *, uint32_t,
-- 
2.35.3

