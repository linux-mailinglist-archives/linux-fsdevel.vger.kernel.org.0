Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659B667978E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjAXMS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjAXMSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B07442F2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2121021891;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YQgsjE0joQXQSCH/IOIe0asDKQRYrNFJhj6ja/et2g=;
        b=FHqI9OZWQdPDfZ+WXdsWmyZ3UjA/mGDeejwT6jNtXTAOLjyNDcNcv32gIS/Pd8CuZpYHTm
        BVaPiYu2dTblfreUCCOmB9N6KUYEzwrlA8bclp+aSm0sYbn5Jw4NPCmX4cw5e/Be9Pwc2r
        m7BL8JGsqfbDpNMRaenNEN5Mi/dK9tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YQgsjE0joQXQSCH/IOIe0asDKQRYrNFJhj6ja/et2g=;
        b=K+5IrFAdIs9MM66PdT1ubKFSW59ucX28L6ps8I6cBa3wjY2fr9vuOP2vfto4pocawKXoIH
        UmUBXrPLsnoKF0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11F10139FF;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /5ZfBIfMz2PmNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3A1E4A06D7; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 10/22] udf: Pass mapping request into inode_getblk()
Date:   Tue, 24 Jan 2023 13:17:56 +0100
Message-Id: <20230124121814.25951-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6182; i=jack@suse.cz; h=from:subject; bh=PaEjSgtpfsCF7D2IprD2LXa6jSEMi5MEez8mF7aNvTA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x1nxG+ayOnzj1hQF/4o3ErFfVYjyZjXYUXRA/8 WIKFp3CJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MdQAKCRCcnaoHP2RA2czDB/ 9fqq5ruShR8H23QqVcBqodoQQwdO+iSurTBNv9+6eekAULXHo6rCMxYo0XNibeZ43IlwsM3IGdwhV7 oOtjV1YBrbOj0ThpON344uwJled64y7jW3R+mObXcBhevS6BDuaf/fdJl4/HJYh2nP6sFuZVKtqd2n itG2zYXSUVGfwFYO52HYOcjFYrovmSbBIwNzJ/+7++HZ8Y97GtVLmGC3C2s/IcvzW44YxGcFYl8+86 eMZSw9FX3U+yUOwAcm2hmjhyENfFQ5LN1lcebaYAnDFMd1qha/eDAKsW3SfMYYl6urPJRob3zC75uU ERGuvxJ0aMPwCMCJnc4Yn/mthKenIv
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

Pass struct udf_map_rq into inode_getblk() instead of unfolding it and
the putting the results back.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 60 ++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index e098d69991d0..5c6725a5bb88 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -58,7 +58,7 @@ static umode_t udf_convert_permissions(struct fileEntry *);
 static int udf_update_inode(struct inode *, int);
 static int udf_sync_inode(struct inode *inode);
 static int udf_alloc_i_data(struct inode *inode, size_t size);
-static sector_t inode_getblk(struct inode *, sector_t, int *, int *);
+static int inode_getblk(struct inode *inode, struct udf_map_rq *map);
 static int udf_insert_aext(struct inode *, struct extent_position,
 			   struct kernel_lb_addr, uint32_t);
 static void udf_split_extents(struct inode *, int *, int, udf_pblk_t,
@@ -336,7 +336,7 @@ struct udf_map_rq {
 
 static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 {
-	int err, new;
+	int err;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
 	map->oflags = 0;
@@ -367,14 +367,9 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 	if (((loff_t)map->lblk) << inode->i_blkbits > iinfo->i_lenExtents)
 		udf_discard_prealloc(inode);
 	udf_clear_extent_cache(inode);
-	map->pblk = inode_getblk(inode, map->lblk, &err, &new);
+	err = inode_getblk(inode, map);
 	up_write(&iinfo->i_data_sem);
-	if (err)
-		return err;
-	map->oflags |= UDF_BLK_MAPPED;
-	if (new)
-		map->oflags |= UDF_BLK_NEW;
-	return 0;
+	return err;
 }
 
 static int udf_get_block(struct inode *inode, sector_t block,
@@ -627,8 +622,7 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	return err;
 }
 
-static sector_t inode_getblk(struct inode *inode, sector_t block,
-			     int *err, int *new)
+static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 {
 	struct kernel_long_ad laarr[EXTENT_MERGE_SIZE];
 	struct extent_position prev_epos, cur_epos, next_epos;
@@ -637,21 +631,20 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	struct kernel_lb_addr eloc, tmpeloc;
 	int c = 1;
 	loff_t lbcount = 0, b_off = 0;
-	udf_pblk_t newblocknum, newblock;
+	udf_pblk_t newblocknum;
 	sector_t offset = 0;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	udf_pblk_t goal = 0, pgoal = iinfo->i_location.logicalBlockNum;
 	int lastblock = 0;
 	bool isBeyondEOF;
+	int ret = 0;
 
-	*err = 0;
-	*new = 0;
 	prev_epos.offset = udf_file_entry_alloc_offset(inode);
 	prev_epos.block = iinfo->i_location;
 	prev_epos.bh = NULL;
 	cur_epos = next_epos = prev_epos;
-	b_off = (loff_t)block << inode->i_sb->s_blocksize_bits;
+	b_off = (loff_t)map->lblk << inode->i_sb->s_blocksize_bits;
 
 	/* find the extent which contains the block we are looking for.
 	   alternate between laarr[0] and laarr[1] for locations of the
@@ -715,13 +708,13 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 				      inode->i_sb->s_blocksize);
 			udf_write_aext(inode, &cur_epos, &eloc, elen, 1);
 		}
-		newblock = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
+		map->oflags = UDF_BLK_MAPPED;
+		map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
 		goto out_free;
 	}
 
 	/* Are we beyond EOF and preallocated extent? */
 	if (etype == -1) {
-		int ret;
 		loff_t hole_len;
 
 		isBeyondEOF = true;
@@ -741,11 +734,8 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 		/* Create extents for the hole between EOF and offset */
 		hole_len = (loff_t)offset << inode->i_blkbits;
 		ret = udf_do_extend_file(inode, &prev_epos, laarr, hole_len);
-		if (ret < 0) {
-			*err = ret;
-			newblock = 0;
+		if (ret < 0)
 			goto out_free;
-		}
 		c = 0;
 		offset = 0;
 		count += ret;
@@ -795,7 +785,7 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	if ((laarr[c].extLength >> 30) == (EXT_NOT_RECORDED_ALLOCATED >> 30))
 		newblocknum = laarr[c].extLocation.logicalBlockNum + offset;
 	else { /* otherwise, allocate a new block */
-		if (iinfo->i_next_alloc_block == block)
+		if (iinfo->i_next_alloc_block == map->lblk)
 			goal = iinfo->i_next_alloc_goal;
 
 		if (!goal) {
@@ -805,12 +795,9 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 
 		newblocknum = udf_new_block(inode->i_sb, inode,
 				iinfo->i_location.partitionReferenceNum,
-				goal, err);
-		if (!newblocknum) {
-			*err = -ENOSPC;
-			newblock = 0;
+				goal, &ret);
+		if (!newblocknum)
 			goto out_free;
-		}
 		if (isBeyondEOF)
 			iinfo->i_lenExtents += inode->i_sb->s_blocksize;
 	}
@@ -834,30 +821,31 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	/* write back the new extents, inserting new extents if the new number
 	 * of extents is greater than the old number, and deleting extents if
 	 * the new number of extents is less than the old number */
-	*err = udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
-	if (*err < 0)
+	ret = udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
+	if (ret < 0)
 		goto out_free;
 
-	newblock = udf_get_pblock(inode->i_sb, newblocknum,
+	map->pblk = udf_get_pblock(inode->i_sb, newblocknum,
 				iinfo->i_location.partitionReferenceNum, 0);
-	if (!newblock) {
-		*err = -EIO;
+	if (!map->pblk) {
+		ret = -EFSCORRUPTED;
 		goto out_free;
 	}
-	*new = 1;
-	iinfo->i_next_alloc_block = block + 1;
-	iinfo->i_next_alloc_goal = newblocknum + 1;
+	map->oflags = UDF_BLK_NEW | UDF_BLK_MAPPED;
+	iinfo->i_next_alloc_block = map->lblk + 1;
+	iinfo->i_next_alloc_goal = map->pblk + 1;
 	inode->i_ctime = current_time(inode);
 
 	if (IS_SYNC(inode))
 		udf_sync_inode(inode);
 	else
 		mark_inode_dirty(inode);
+	ret = 0;
 out_free:
 	brelse(prev_epos.bh);
 	brelse(cur_epos.bh);
 	brelse(next_epos.bh);
-	return newblock;
+	return ret;
 }
 
 static void udf_split_extents(struct inode *inode, int *c, int offset,
-- 
2.35.3

