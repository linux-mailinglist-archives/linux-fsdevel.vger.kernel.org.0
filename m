Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938364EDDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLPP1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiLPP1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC10654D9
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28389343E2;
        Fri, 16 Dec 2022 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMY0HGpS8G1A1bbJdZZukEUWulV42B9MAk8oEJsNTCA=;
        b=Faeaeqh6wylmrJCp0ExV/bniPhS8Z6T32pqBfxIUkcAH2j/+2DUafpC/qsEpPuECYPkbW5
        ukjg5glmr5VrdtG18JL8djWLL90uvPYUCCej/jWjrorMXuM62MGkIlR8rJ1swoG9GRUPM8
        Ie2SCperjVZp+vLeQB+ma2Q0vl4KIhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMY0HGpS8G1A1bbJdZZukEUWulV42B9MAk8oEJsNTCA=;
        b=XmeqwsC0fSKsnbE7qNvj0vomRtMJj2d7QuZnlo5T3V/V9lWvkwOGH6rs6/Q6nw0gsF+js+
        dhB0dl3Jcw7ePnCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E476B13905;
        Fri, 16 Dec 2022 15:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XNlAN0OOnGO9CAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:26:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 85AB0A0766; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 04/20] udf: Convert udf_expand_dir_adinicb() to new directory iteration
Date:   Fri, 16 Dec 2022 16:24:08 +0100
Message-Id: <20221216152656.6236-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3509; i=jack@suse.cz; h=from:subject; bh=qXZYwvfK49gCecSGZAYjkCdZpAR9XN9oSWNuj2ZLwVM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2ZvhSZyKeDpcXMjKdWnuAM358wMcBMrmLZuEQH uy1HQUGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNmQAKCRCcnaoHP2RA2SGgB/ 9m+ecn7J6fTqSemCM/kv1Rrg+zg8C1iZ6nng+bbvkXPe3JQwETfKmicPVXWN/7iMAg8gzHhqzpv4kS ObHCDTC0MUGyPe6nbikTNPg9rgfX9xgYJIdn7+EC2emsz17T1GLrNsh2aWEjo19YTcGvq3/oL8BYWt jTwNCSMIlMmuUrkUIL1fntVCaWHs8JPgsL6b0qwBGfcMU71ncThA4Tth7buGDwqB0VJQQ3KZhX0G5m PTCUx9N0nGj3jsS5p4MOgxCqaoasGXURK+P6/twTuqjT5W2LHOFqn7GD2TJUkSvGNlystlKM5JK7Ol guQBrU6YVvR8mgTPL/q5PG3GSzm0KR
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert udf_expand_dir_adinicb() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 66 ++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 1d7c2a812fc1..fba828578208 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -326,14 +326,12 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	udf_pblk_t newblock;
 	struct buffer_head *dbh = NULL;
 	struct kernel_lb_addr eloc;
-	uint8_t alloctype;
 	struct extent_position epos;
-
-	struct udf_fileident_bh sfibh, dfibh;
-	loff_t f_pos = udf_ext0_offset(inode);
-	int size = udf_ext0_offset(inode) + inode->i_size;
-	struct fileIdentDesc cfi, *sfi, *dfi;
+	uint8_t alloctype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_fileident_iter iter;
+	uint8_t *impuse;
+	int ret;
 
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
 		alloctype = ICBTAG_FLAG_AD_SHORT;
@@ -361,38 +359,14 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	if (!dbh)
 		return NULL;
 	lock_buffer(dbh);
-	memset(dbh->b_data, 0x00, inode->i_sb->s_blocksize);
+	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
+	memset(dbh->b_data + inode->i_size, 0,
+	       inode->i_sb->s_blocksize - inode->i_size);
 	set_buffer_uptodate(dbh);
 	unlock_buffer(dbh);
-	mark_buffer_dirty_inode(dbh, inode);
-
-	sfibh.soffset = sfibh.eoffset =
-			f_pos & (inode->i_sb->s_blocksize - 1);
-	sfibh.sbh = sfibh.ebh = NULL;
-	dfibh.soffset = dfibh.eoffset = 0;
-	dfibh.sbh = dfibh.ebh = dbh;
-	while (f_pos < size) {
-		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-		sfi = udf_fileident_read(inode, &f_pos, &sfibh, &cfi, NULL,
-					 NULL, NULL, NULL);
-		if (!sfi) {
-			brelse(dbh);
-			return NULL;
-		}
-		iinfo->i_alloc_type = alloctype;
-		sfi->descTag.tagLocation = cpu_to_le32(*block);
-		dfibh.soffset = dfibh.eoffset;
-		dfibh.eoffset += (sfibh.eoffset - sfibh.soffset);
-		dfi = (struct fileIdentDesc *)(dbh->b_data + dfibh.soffset);
-		if (udf_write_fi(inode, sfi, dfi, &dfibh, sfi->impUse,
-				 udf_get_fi_ident(sfi))) {
-			iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-			brelse(dbh);
-			return NULL;
-		}
-	}
-	mark_buffer_dirty_inode(dbh, inode);
 
+	/* Drop inline data, add block instead */
+	iinfo->i_alloc_type = alloctype;
 	memset(iinfo->i_data + iinfo->i_lenEAttr, 0, iinfo->i_lenAlloc);
 	iinfo->i_lenAlloc = 0;
 	eloc.logicalBlockNum = *block;
@@ -403,10 +377,28 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	epos.block = iinfo->i_location;
 	epos.offset = udf_file_entry_alloc_offset(inode);
 	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
-	/* UniqueID stuff */
-
 	brelse(epos.bh);
 	mark_inode_dirty(inode);
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
 	return dbh;
 }
 
-- 
2.35.3

