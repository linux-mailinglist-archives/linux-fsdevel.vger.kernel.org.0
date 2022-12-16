Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A536664EDDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiLPP1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiLPP1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2AF654D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D5C55D114;
        Fri, 16 Dec 2022 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8UwxbFjsuL6vvLg3oZaYLBVsUEYcSXkKCMWa/009se4=;
        b=aXgWZbFYuznjEDAbAr7FgJHbElPSZ1KjjQuczfWGICzEnw1fZcZErJceidnRzPfYF5t5kN
        G0nItpTJzuiGNSGxXcdMul6KkhjfHmKJAGR7iSRqyiS8HZfyWPXC/MkVwsuFb1m7g3wC07
        6roJ3WDB13wKObKXB+R6C35VdszN8tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8UwxbFjsuL6vvLg3oZaYLBVsUEYcSXkKCMWa/009se4=;
        b=+pdm2W82C/8Rin4ZB3zZ1V5SjA3gSd3nZdBof4LWnrxGAxnfeHR4co20AvKNXVJ9hk9jOI
        JPSwtpTDCQSMKJCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E994913909;
        Fri, 16 Dec 2022 15:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f4h+OEOOnGO/CAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:26:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7F409A0765; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 03/20] udf: Convert udf_readdir() to new directory iteration
Date:   Fri, 16 Dec 2022 16:24:07 +0100
Message-Id: <20221216152656.6236-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6087; i=jack@suse.cz; h=from:subject; bh=QeetFQsnLUPNyGx2eZiYYtWPpBxk54L/faIWvYP+L/M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2Y5Ycug/0xL1ttqdcIeo35vbkPZCbb4eaH9O1n n6FBTemJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNmAAKCRCcnaoHP2RA2bftB/ 0S7Fh3LxrRCVB6XkM2vJ2P2FiuvldXAy1iwXtELO8rFxv3tLXvEHi6k+ajSe/ZR6KNXCDg3n25zyAS biuQD1XwKM1gpiguUOyivoxX7+nRm7U+Pi2W4vAE0dIcepECFnVqlUqni20sghObQz9CNuNujKnIHh sIY4D3zMSHDPjzvtLMQzL5PWuZqFlOttI65v6dlzKpH6uF2cRmULN4mCq61ha0n9UZ0Wrv90nVkjHG aXCnQGhTBrr+bxPUdsqdHWu50+1nL6rlaZby7TtyP55wU6KUFSRetijDuIg6c6DpZOILAahazHzpI+ GFzux/dKgQgKG1RGEx301z34wQVLQS
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

Convert udf_readdir() to new directory iteration functions.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/dir.c | 148 ++++++++++-----------------------------------------
 1 file changed, 27 insertions(+), 121 deletions(-)

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index be640f4b2f2c..212393b12c22 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -39,26 +39,13 @@
 static int udf_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *dir = file_inode(file);
-	struct udf_inode_info *iinfo = UDF_I(dir);
-	struct udf_fileident_bh fibh = { .sbh = NULL, .ebh = NULL};
-	struct fileIdentDesc *fi = NULL;
-	struct fileIdentDesc cfi;
-	udf_pblk_t block, iblock;
 	loff_t nf_pos, emit_pos = 0;
 	int flen;
-	unsigned char *fname = NULL, *copy_name = NULL;
-	unsigned char *nameptr;
-	uint16_t liu;
-	uint8_t lfi;
-	loff_t size = udf_ext0_offset(dir) + dir->i_size;
-	struct buffer_head *tmp, *bha[16];
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	int i, num, ret = 0;
-	struct extent_position epos = { NULL, 0, {0, 0} };
+	unsigned char *fname = NULL;
+	int ret = 0;
 	struct super_block *sb = dir->i_sb;
 	bool pos_valid = false;
+	struct udf_fileident_iter iter;
 
 	if (ctx->pos == 0) {
 		if (!dir_emit_dot(file, ctx))
@@ -66,7 +53,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = 1;
 	}
 	nf_pos = (ctx->pos - 1) << 2;
-	if (nf_pos >= size)
+	if (nf_pos >= dir->i_size)
 		goto out;
 
 	/*
@@ -90,138 +77,57 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 		goto out;
 	}
 
-	if (nf_pos == 0)
-		nf_pos = udf_ext0_offset(dir);
-
-	fibh.soffset = fibh.eoffset = nf_pos & (sb->s_blocksize - 1);
-	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, nf_pos >> sb->s_blocksize_bits,
-		    &epos, &eloc, &elen, &offset)
-		    != (EXT_RECORDED_ALLOCATED >> 30)) {
-			ret = -ENOENT;
-			goto out;
-		}
-		block = udf_get_lb_pblock(sb, &eloc, offset);
-		if ((++offset << sb->s_blocksize_bits) < elen) {
-			if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (iinfo->i_alloc_type ==
-					ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else {
-			offset = 0;
-		}
-
-		if (!(fibh.sbh = fibh.ebh = udf_tread(sb, block))) {
-			ret = -EIO;
-			goto out;
-		}
-
-		if (!(offset & ((16 >> (sb->s_blocksize_bits - 9)) - 1))) {
-			i = 16 >> (sb->s_blocksize_bits - 9);
-			if (i + offset > (elen >> sb->s_blocksize_bits))
-				i = (elen >> sb->s_blocksize_bits) - offset;
-			for (num = 0; i > 0; i--) {
-				block = udf_get_lb_pblock(sb, &eloc, offset + i);
-				tmp = udf_tgetblk(sb, block);
-				if (tmp && !buffer_uptodate(tmp) && !buffer_locked(tmp))
-					bha[num++] = tmp;
-				else
-					brelse(tmp);
-			}
-			if (num) {
-				bh_readahead_batch(num, bha, REQ_RAHEAD);
-				for (i = 0; i < num; i++)
-					brelse(bha[i]);
-			}
-		}
-	}
-
-	while (nf_pos < size) {
+	for (ret = udf_fiiter_init(&iter, dir, nf_pos);
+	     !ret && iter.pos < dir->i_size;
+	     ret = udf_fiiter_advance(&iter)) {
 		struct kernel_lb_addr tloc;
-		loff_t cur_pos = nf_pos;
+		udf_pblk_t iblock;
 
-		/* Update file position only if we got past the current one */
-		if (nf_pos >= emit_pos) {
-			ctx->pos = (nf_pos >> 2) + 1;
-			pos_valid = true;
-		}
-
-		fi = udf_fileident_read(dir, &nf_pos, &fibh, &cfi, &epos, &eloc,
-					&elen, &offset);
-		if (!fi)
-			goto out;
 		/* Still not at offset where user asked us to read from? */
-		if (cur_pos < emit_pos)
+		if (iter.pos < emit_pos)
 			continue;
 
-		liu = le16_to_cpu(cfi.lengthOfImpUse);
-		lfi = cfi.lengthFileIdent;
-
-		if (fibh.sbh == fibh.ebh) {
-			nameptr = udf_get_fi_ident(fi);
-		} else {
-			int poffset;	/* Unpaded ending offset */
-
-			poffset = fibh.soffset + sizeof(struct fileIdentDesc) + liu + lfi;
-
-			if (poffset >= lfi) {
-				nameptr = (char *)(fibh.ebh->b_data + poffset - lfi);
-			} else {
-				if (!copy_name) {
-					copy_name = kmalloc(UDF_NAME_LEN,
-							    GFP_NOFS);
-					if (!copy_name) {
-						ret = -ENOMEM;
-						goto out;
-					}
-				}
-				nameptr = copy_name;
-				memcpy(nameptr, udf_get_fi_ident(fi),
-				       lfi - poffset);
-				memcpy(nameptr + lfi - poffset,
-				       fibh.ebh->b_data, poffset);
-			}
-		}
+		/* Update file position only if we got past the current one */
+		pos_valid = true;
+		ctx->pos = (iter.pos >> 2) + 1;
 
-		if ((cfi.fileCharacteristics & FID_FILE_CHAR_DELETED) != 0) {
+		if (iter.fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
 			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNDELETE))
 				continue;
 		}
 
-		if ((cfi.fileCharacteristics & FID_FILE_CHAR_HIDDEN) != 0) {
+		if (iter.fi.fileCharacteristics & FID_FILE_CHAR_HIDDEN) {
 			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNHIDE))
 				continue;
 		}
 
-		if (cfi.fileCharacteristics & FID_FILE_CHAR_PARENT) {
+		if (iter.fi.fileCharacteristics & FID_FILE_CHAR_PARENT) {
 			if (!dir_emit_dotdot(file, ctx))
-				goto out;
+				goto out_iter;
 			continue;
 		}
 
-		flen = udf_get_filename(sb, nameptr, lfi, fname, UDF_NAME_LEN);
+		flen = udf_get_filename(sb, iter.name,
+				iter.fi.lengthFileIdent, fname, UDF_NAME_LEN);
 		if (flen < 0)
 			continue;
 
-		tloc = lelb_to_cpu(cfi.icb.extLocation);
+		tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 		iblock = udf_get_lb_pblock(sb, &tloc, 0);
 		if (!dir_emit(ctx, fname, flen, iblock, DT_UNKNOWN))
-			goto out;
-	} /* end while */
-
-	ctx->pos = (nf_pos >> 2) + 1;
-	pos_valid = true;
+			goto out_iter;
+	}
 
+	if (!ret) {
+		ctx->pos = (iter.pos >> 2) + 1;
+		pos_valid = true;
+	}
+out_iter:
+	udf_fiiter_release(&iter);
 out:
 	if (pos_valid)
 		file->f_version = inode_query_iversion(dir);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	brelse(epos.bh);
 	kfree(fname);
-	kfree(copy_name);
 
 	return ret;
 }
-- 
2.35.3

