Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D328164EDE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiLPP11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiLPP1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F0E62EB2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5813E5D116;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bLSeYzzY8KC7c145u9yY7DEDzPG/x2tmkap0b4nIpk=;
        b=KkAxnMg6C0Tye+Nt24mKMIzSE8TWgl5y62qn1W/hQyLPZTsitc2gDgkcLXY6UKbib1VuKH
        YpM0sbhpA9vH6cHtulJ/6CNWGIuNX/wizzKiP0OowNGTpFQvjcL6shv3s68vZqzTZAWcXt
        U4oQVV7GgPllIC3nykJKH5y3EdgLXbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bLSeYzzY8KC7c145u9yY7DEDzPG/x2tmkap0b4nIpk=;
        b=TE0nYdyXoTm1TCYHOC6uFNnp5nv789qmn/98g3mqPHua3oA+K+atK0lM6s/rFSjKzHoHLI
        kacpEk1hed2hm/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2ADB613904;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zLN0CkaOnGPRCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8B640A0767; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 05/20] udf: Move udf_expand_dir_adinicb() to its callsite
Date:   Fri, 16 Dec 2022 16:24:09 +0100
Message-Id: <20221216152656.6236-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6777; i=jack@suse.cz; h=from:subject; bh=rK0qeUVr/Q7UNyNbN8fLYHguuTfWJst9TEWT2wg+9mc=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJLn9M7qL214ZHj6vy5vjHDLepFJM7w6ee8UvzsQ+OH+K33r o8dYOxmNWRgYORhkxRRZVkde1L42z6hra6iGDMwgViaQKQxcnAIwkQvv2P97GtjdNClIrbjwNavZIt VWjrlytn4y64Uvka//evjFptmEyV84v9N6f63y2Uvibqdu2vYmfy8PKG0rXeAUeiWWKfvif9d975cm KrBLJesmm5/e48l69Hr/JcGMRzG/c1TrrgVmzlSNY3Tk9i3r35HauMz4xpd/s15JJJSe4Cm4dtTEfG vJz0+ns/XePJVXYV57aWlpjKDdS8ULooFaGfFsEnuXSNjU1Cx+u5uRc7fIhaArZyaEFPgt7LzEXzNT eZV29uJD/fdk3dkmhiw1efdZcCHXxPK60gcKpv+M+mPyrd+qnOkusqiKNJl2JnCZaOeK8up/N6Z6tR gcYMtMXGEW5nlqvV+8Ycd5Tbb/AA==
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

There is just one caller of udf_expand_dir_adinicb(). Move the function
to its caller into namei.c as it is more about directory handling than
anything else anyway.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c   | 82 ------------------------------------------------
 fs/udf/namei.c   | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/udf/udfdecl.h |  2 --
 3 files changed, 82 insertions(+), 84 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index fba828578208..787e6a7b355e 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -320,88 +320,6 @@ int udf_expand_file_adinicb(struct inode *inode)
 	return err;
 }
 
-struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
-					    udf_pblk_t *block, int *err)
-{
-	udf_pblk_t newblock;
-	struct buffer_head *dbh = NULL;
-	struct kernel_lb_addr eloc;
-	struct extent_position epos;
-	uint8_t alloctype;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-	struct udf_fileident_iter iter;
-	uint8_t *impuse;
-	int ret;
-
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
-		alloctype = ICBTAG_FLAG_AD_SHORT;
-	else
-		alloctype = ICBTAG_FLAG_AD_LONG;
-
-	if (!inode->i_size) {
-		iinfo->i_alloc_type = alloctype;
-		mark_inode_dirty(inode);
-		return NULL;
-	}
-
-	/* alloc block, and copy data to it */
-	*block = udf_new_block(inode->i_sb, inode,
-			       iinfo->i_location.partitionReferenceNum,
-			       iinfo->i_location.logicalBlockNum, err);
-	if (!(*block))
-		return NULL;
-	newblock = udf_get_pblock(inode->i_sb, *block,
-				  iinfo->i_location.partitionReferenceNum,
-				0);
-	if (!newblock)
-		return NULL;
-	dbh = udf_tgetblk(inode->i_sb, newblock);
-	if (!dbh)
-		return NULL;
-	lock_buffer(dbh);
-	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
-	memset(dbh->b_data + inode->i_size, 0,
-	       inode->i_sb->s_blocksize - inode->i_size);
-	set_buffer_uptodate(dbh);
-	unlock_buffer(dbh);
-
-	/* Drop inline data, add block instead */
-	iinfo->i_alloc_type = alloctype;
-	memset(iinfo->i_data + iinfo->i_lenEAttr, 0, iinfo->i_lenAlloc);
-	iinfo->i_lenAlloc = 0;
-	eloc.logicalBlockNum = *block;
-	eloc.partitionReferenceNum =
-				iinfo->i_location.partitionReferenceNum;
-	iinfo->i_lenExtents = inode->i_size;
-	epos.bh = NULL;
-	epos.block = iinfo->i_location;
-	epos.offset = udf_file_entry_alloc_offset(inode);
-	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
-	brelse(epos.bh);
-	mark_inode_dirty(inode);
-
-	/* Now fixup tags in moved directory entries */
-	for (ret = udf_fiiter_init(&iter, inode, 0);
-	     !ret && iter.pos < inode->i_size;
-	     ret = udf_fiiter_advance(&iter)) {
-		iter.fi.descTag.tagLocation = cpu_to_le32(*block);
-		if (iter.fi.lengthOfImpUse != cpu_to_le16(0))
-			impuse = dbh->b_data + iter.pos +
-						sizeof(struct fileIdentDesc);
-		else
-			impuse = NULL;
-		udf_fiiter_write_fi(&iter, impuse);
-	}
-	/*
-	 * We don't expect the iteration to fail as the directory has been
-	 * already verified to be correct
-	 */
-	WARN_ON_ONCE(ret);
-	udf_fiiter_release(&iter);
-
-	return dbh;
-}
-
 static int udf_get_block(struct inode *inode, sector_t block,
 			 struct buffer_head *bh_result, int create)
 {
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7c95c549dd64..78bc4bbb7c54 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -326,6 +326,88 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
+static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
+					udf_pblk_t *block, int *err)
+{
+	udf_pblk_t newblock;
+	struct buffer_head *dbh = NULL;
+	struct kernel_lb_addr eloc;
+	struct extent_position epos;
+	uint8_t alloctype;
+	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_fileident_iter iter;
+	uint8_t *impuse;
+	int ret;
+
+	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+		alloctype = ICBTAG_FLAG_AD_SHORT;
+	else
+		alloctype = ICBTAG_FLAG_AD_LONG;
+
+	if (!inode->i_size) {
+		iinfo->i_alloc_type = alloctype;
+		mark_inode_dirty(inode);
+		return NULL;
+	}
+
+	/* alloc block, and copy data to it */
+	*block = udf_new_block(inode->i_sb, inode,
+			       iinfo->i_location.partitionReferenceNum,
+			       iinfo->i_location.logicalBlockNum, err);
+	if (!(*block))
+		return NULL;
+	newblock = udf_get_pblock(inode->i_sb, *block,
+				  iinfo->i_location.partitionReferenceNum,
+				0);
+	if (!newblock)
+		return NULL;
+	dbh = udf_tgetblk(inode->i_sb, newblock);
+	if (!dbh)
+		return NULL;
+	lock_buffer(dbh);
+	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
+	memset(dbh->b_data + inode->i_size, 0,
+	       inode->i_sb->s_blocksize - inode->i_size);
+	set_buffer_uptodate(dbh);
+	unlock_buffer(dbh);
+
+	/* Drop inline data, add block instead */
+	iinfo->i_alloc_type = alloctype;
+	memset(iinfo->i_data + iinfo->i_lenEAttr, 0, iinfo->i_lenAlloc);
+	iinfo->i_lenAlloc = 0;
+	eloc.logicalBlockNum = *block;
+	eloc.partitionReferenceNum =
+				iinfo->i_location.partitionReferenceNum;
+	iinfo->i_lenExtents = inode->i_size;
+	epos.bh = NULL;
+	epos.block = iinfo->i_location;
+	epos.offset = udf_file_entry_alloc_offset(inode);
+	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
+	brelse(epos.bh);
+	mark_inode_dirty(inode);
+
+	/* Now fixup tags in moved directory entries */
+	for (ret = udf_fiiter_init(&iter, inode, 0);
+	     !ret && iter.pos < inode->i_size;
+	     ret = udf_fiiter_advance(&iter)) {
+		iter.fi.descTag.tagLocation = cpu_to_le32(*block);
+		if (iter.fi.lengthOfImpUse != cpu_to_le16(0))
+			impuse = dbh->b_data + iter.pos +
+						sizeof(struct fileIdentDesc);
+		else
+			impuse = NULL;
+		udf_fiiter_write_fi(&iter, impuse);
+	}
+	/*
+	 * We don't expect the iteration to fail as the directory has been
+	 * already verified to be correct
+	 */
+	WARN_ON_ONCE(ret);
+	udf_fiiter_release(&iter);
+
+	return dbh;
+}
+
 static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 					   struct dentry *dentry,
 					   struct udf_fileident_bh *fibh,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 22a8466e335c..676fa2996ffe 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -169,8 +169,6 @@ static inline struct inode *udf_iget(struct super_block *sb,
 	return __udf_iget(sb, ino, false);
 }
 extern int udf_expand_file_adinicb(struct inode *);
-extern struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
-						  udf_pblk_t *block, int *err);
 extern struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 				      int create, int *err);
 extern int udf_setsize(struct inode *, loff_t);
-- 
2.35.3

