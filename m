Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0180764EDEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiLPP1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiLPP1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F84654E9
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69E89343E9;
        Fri, 16 Dec 2022 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWvzbvq8C22i5Uhqiahy2zfBsncLvA57QLVvdtd/oq8=;
        b=UXH5zTRX1TmpYVB8ieczswuDuvIZPyFV8TgU80niNxECgKyDSRCm74he67h8klOuf5tnY/
        D3h9EhcLbFFpNC5hgkkPeShOry7RhGhLpRqS6taXSTHH/FixRxo9IznFu4UsFy82OOLTS3
        9Mg0KIMLt09jw7Fy3VO5MBEVwGb/SBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWvzbvq8C22i5Uhqiahy2zfBsncLvA57QLVvdtd/oq8=;
        b=R2rN6DSmRnhh069RQgzXcH7Wj5uKTATxCrya8baQQLXU4pg68zHh167cNryHiByJFm2T1I
        VG1d3lfO0hmZtODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A09313905;
        Fri, 16 Dec 2022 15:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UjEqDkeOnGP4CAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DA2D3A0778; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 18/20] udf: Remove old directory iteration code
Date:   Fri, 16 Dec 2022 16:24:22 +0100
Message-Id: <20221216152656.6236-18-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23762; i=jack@suse.cz; h=from:subject; bh=XWnesePJXkkdtycT6C90l3mGZFi8ru1X9BeUXZ3R9kQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2lClrI1uXpbGXUlSb+T2I6ax5+9iBLQuPTH6hC YVtYEJ+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNpQAKCRCcnaoHP2RA2XbbB/ 98T/9q4Avjj7gb9M7f+DJDQ+EQmk4SSaVlauTRTvT1UFBUKa0wuKkaaApPeofSh6FiKjYT8L3yZisF gbHIWGOVjr2zmPuqT0t5hvjx6wAS/sYWa8IapdAGcCsrDqKOxQMJZYZh/kaWvShacusQhMGGwInC4N GDsZtpkbO6HDYCKc46wzdz6jNEasxBBUbnZ5KG0WnzvoaoNlVAIab/+zooLY7t0o6dAKfncChI17aq FUNjAahVYn5TXeKFnZVp2iiLeB724gCd/w6swZ4k+bAu3jsm+NxHeGxC5iYS1rlxFO+AfS16JnfvBS 7+HC8EakkNmIevLlIuldGAr5402XP+
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

Remove old directory iteration code that is now unused.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/directory.c | 178 ----------------
 fs/udf/namei.c     | 505 ---------------------------------------------
 fs/udf/udfdecl.h   |  22 --
 3 files changed, 705 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 9b5e4f6a9dd1..9e6a54445f90 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -470,184 +470,6 @@ int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
 	return 0;
 }
 
-struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
-					 struct udf_fileident_bh *fibh,
-					 struct fileIdentDesc *cfi,
-					 struct extent_position *epos,
-					 struct kernel_lb_addr *eloc, uint32_t *elen,
-					 sector_t *offset)
-{
-	struct fileIdentDesc *fi;
-	int i, num;
-	udf_pblk_t block;
-	struct buffer_head *tmp, *bha[16];
-	struct udf_inode_info *iinfo = UDF_I(dir);
-
-	fibh->soffset = fibh->eoffset;
-
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-		fi = udf_get_fileident(iinfo->i_data -
-				       (iinfo->i_efe ?
-					sizeof(struct extendedFileEntry) :
-					sizeof(struct fileEntry)),
-				       dir->i_sb->s_blocksize,
-				       &(fibh->eoffset));
-		if (!fi)
-			return NULL;
-
-		*nf_pos += fibh->eoffset - fibh->soffset;
-
-		memcpy((uint8_t *)cfi, (uint8_t *)fi,
-		       sizeof(struct fileIdentDesc));
-
-		return fi;
-	}
-
-	if (fibh->eoffset == dir->i_sb->s_blocksize) {
-		uint32_t lextoffset = epos->offset;
-		unsigned char blocksize_bits = dir->i_sb->s_blocksize_bits;
-
-		if (udf_next_aext(dir, epos, eloc, elen, 1) !=
-		    (EXT_RECORDED_ALLOCATED >> 30))
-			return NULL;
-
-		block = udf_get_lb_pblock(dir->i_sb, eloc, *offset);
-
-		(*offset)++;
-
-		if ((*offset << blocksize_bits) >= *elen)
-			*offset = 0;
-		else
-			epos->offset = lextoffset;
-
-		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh = udf_tread(dir->i_sb, block);
-		if (!fibh->sbh)
-			return NULL;
-		fibh->soffset = fibh->eoffset = 0;
-
-		if (!(*offset & ((16 >> (blocksize_bits - 9)) - 1))) {
-			i = 16 >> (blocksize_bits - 9);
-			if (i + *offset > (*elen >> blocksize_bits))
-				i = (*elen >> blocksize_bits)-*offset;
-			for (num = 0; i > 0; i--) {
-				block = udf_get_lb_pblock(dir->i_sb, eloc,
-							  *offset + i);
-				tmp = udf_tgetblk(dir->i_sb, block);
-				if (tmp && !buffer_uptodate(tmp) &&
-						!buffer_locked(tmp))
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
-	} else if (fibh->sbh != fibh->ebh) {
-		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh;
-	}
-
-	fi = udf_get_fileident(fibh->sbh->b_data, dir->i_sb->s_blocksize,
-			       &(fibh->eoffset));
-
-	if (!fi)
-		return NULL;
-
-	*nf_pos += fibh->eoffset - fibh->soffset;
-
-	if (fibh->eoffset <= dir->i_sb->s_blocksize) {
-		memcpy((uint8_t *)cfi, (uint8_t *)fi,
-		       sizeof(struct fileIdentDesc));
-	} else if (fibh->eoffset > dir->i_sb->s_blocksize) {
-		uint32_t lextoffset = epos->offset;
-
-		if (udf_next_aext(dir, epos, eloc, elen, 1) !=
-		    (EXT_RECORDED_ALLOCATED >> 30))
-			return NULL;
-
-		block = udf_get_lb_pblock(dir->i_sb, eloc, *offset);
-
-		(*offset)++;
-
-		if ((*offset << dir->i_sb->s_blocksize_bits) >= *elen)
-			*offset = 0;
-		else
-			epos->offset = lextoffset;
-
-		fibh->soffset -= dir->i_sb->s_blocksize;
-		fibh->eoffset -= dir->i_sb->s_blocksize;
-
-		fibh->ebh = udf_tread(dir->i_sb, block);
-		if (!fibh->ebh)
-			return NULL;
-
-		if (sizeof(struct fileIdentDesc) > -fibh->soffset) {
-			int fi_len;
-
-			memcpy((uint8_t *)cfi, (uint8_t *)fi, -fibh->soffset);
-			memcpy((uint8_t *)cfi - fibh->soffset,
-			       fibh->ebh->b_data,
-			       sizeof(struct fileIdentDesc) + fibh->soffset);
-
-			fi_len = udf_dir_entry_len(cfi);
-			*nf_pos += fi_len - (fibh->eoffset - fibh->soffset);
-			fibh->eoffset = fibh->soffset + fi_len;
-		} else {
-			memcpy((uint8_t *)cfi, (uint8_t *)fi,
-			       sizeof(struct fileIdentDesc));
-		}
-	}
-	/* Got last entry outside of dir size - fs is corrupted! */
-	if (*nf_pos > dir->i_size)
-		return NULL;
-	return fi;
-}
-
-struct fileIdentDesc *udf_get_fileident(void *buffer, int bufsize, int *offset)
-{
-	struct fileIdentDesc *fi;
-	int lengthThisIdent;
-	uint8_t *ptr;
-	int padlen;
-
-	if ((!buffer) || (!offset)) {
-		udf_debug("invalidparms, buffer=%p, offset=%p\n",
-			  buffer, offset);
-		return NULL;
-	}
-
-	ptr = buffer;
-
-	if ((*offset > 0) && (*offset < bufsize))
-		ptr += *offset;
-	fi = (struct fileIdentDesc *)ptr;
-	if (fi->descTag.tagIdent != cpu_to_le16(TAG_IDENT_FID)) {
-		udf_debug("0x%x != TAG_IDENT_FID\n",
-			  le16_to_cpu(fi->descTag.tagIdent));
-		udf_debug("offset: %d sizeof: %lu bufsize: %d\n",
-			  *offset, (unsigned long)sizeof(struct fileIdentDesc),
-			  bufsize);
-		return NULL;
-	}
-	if ((*offset + sizeof(struct fileIdentDesc)) > bufsize)
-		lengthThisIdent = sizeof(struct fileIdentDesc);
-	else
-		lengthThisIdent = sizeof(struct fileIdentDesc) +
-			fi->lengthFileIdent + le16_to_cpu(fi->lengthOfImpUse);
-
-	/* we need to figure padding, too! */
-	padlen = lengthThisIdent % UDF_NAME_PAD;
-	if (padlen)
-		lengthThisIdent += (UDF_NAME_PAD - padlen);
-	*offset = *offset + lengthThisIdent;
-
-	return fi;
-}
-
 struct short_ad *udf_get_fileshortad(uint8_t *ptr, int maxoffset, uint32_t *offset,
 			      int inc)
 {
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 81a7197c2109..800271b00f84 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -41,105 +41,6 @@ static inline int udf_match(int len1, const unsigned char *name1, int len2,
 	return !memcmp(name1, name2, len1);
 }
 
-int udf_write_fi(struct inode *inode, struct fileIdentDesc *cfi,
-		 struct fileIdentDesc *sfi, struct udf_fileident_bh *fibh,
-		 uint8_t *impuse, uint8_t *fileident)
-{
-	uint16_t crclen = fibh->eoffset - fibh->soffset - sizeof(struct tag);
-	uint16_t crc;
-	int offset;
-	uint16_t liu = le16_to_cpu(cfi->lengthOfImpUse);
-	uint8_t lfi = cfi->lengthFileIdent;
-	int padlen = fibh->eoffset - fibh->soffset - liu - lfi -
-		sizeof(struct fileIdentDesc);
-	int adinicb = 0;
-
-	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		adinicb = 1;
-
-	offset = fibh->soffset + sizeof(struct fileIdentDesc);
-
-	if (impuse) {
-		if (adinicb || (offset + liu < 0)) {
-			memcpy((uint8_t *)sfi->impUse, impuse, liu);
-		} else if (offset >= 0) {
-			memcpy(fibh->ebh->b_data + offset, impuse, liu);
-		} else {
-			memcpy((uint8_t *)sfi->impUse, impuse, -offset);
-			memcpy(fibh->ebh->b_data, impuse - offset,
-				liu + offset);
-		}
-	}
-
-	offset += liu;
-
-	if (fileident) {
-		if (adinicb || (offset + lfi < 0)) {
-			memcpy(sfi->impUse + liu, fileident, lfi);
-		} else if (offset >= 0) {
-			memcpy(fibh->ebh->b_data + offset, fileident, lfi);
-		} else {
-			memcpy(sfi->impUse + liu, fileident, -offset);
-			memcpy(fibh->ebh->b_data, fileident - offset,
-				lfi + offset);
-		}
-	}
-
-	offset += lfi;
-
-	if (adinicb || (offset + padlen < 0)) {
-		memset(sfi->impUse + liu + lfi, 0x00, padlen);
-	} else if (offset >= 0) {
-		memset(fibh->ebh->b_data + offset, 0x00, padlen);
-	} else {
-		memset(sfi->impUse + liu + lfi, 0x00, -offset);
-		memset(fibh->ebh->b_data, 0x00, padlen + offset);
-	}
-
-	crc = crc_itu_t(0, (uint8_t *)cfi + sizeof(struct tag),
-		      sizeof(struct fileIdentDesc) - sizeof(struct tag));
-
-	if (fibh->sbh == fibh->ebh) {
-		crc = crc_itu_t(crc, (uint8_t *)sfi->impUse,
-			      crclen + sizeof(struct tag) -
-			      sizeof(struct fileIdentDesc));
-	} else if (sizeof(struct fileIdentDesc) >= -fibh->soffset) {
-		crc = crc_itu_t(crc, fibh->ebh->b_data +
-					sizeof(struct fileIdentDesc) +
-					fibh->soffset,
-			      crclen + sizeof(struct tag) -
-					sizeof(struct fileIdentDesc));
-	} else {
-		crc = crc_itu_t(crc, (uint8_t *)sfi->impUse,
-			      -fibh->soffset - sizeof(struct fileIdentDesc));
-		crc = crc_itu_t(crc, fibh->ebh->b_data, fibh->eoffset);
-	}
-
-	cfi->descTag.descCRC = cpu_to_le16(crc);
-	cfi->descTag.descCRCLength = cpu_to_le16(crclen);
-	cfi->descTag.tagChecksum = udf_tag_checksum(&cfi->descTag);
-
-	if (adinicb || (sizeof(struct fileIdentDesc) <= -fibh->soffset)) {
-		memcpy((uint8_t *)sfi, (uint8_t *)cfi,
-			sizeof(struct fileIdentDesc));
-	} else {
-		memcpy((uint8_t *)sfi, (uint8_t *)cfi, -fibh->soffset);
-		memcpy(fibh->ebh->b_data, (uint8_t *)cfi - fibh->soffset,
-		       sizeof(struct fileIdentDesc) + fibh->soffset);
-	}
-
-	if (adinicb) {
-		mark_inode_dirty(inode);
-	} else {
-		if (fibh->sbh != fibh->ebh)
-			mark_buffer_dirty_inode(fibh->ebh, inode);
-		mark_buffer_dirty_inode(fibh->sbh, inode);
-	}
-	inode_inc_iversion(inode);
-
-	return 0;
-}
-
 /**
  * udf_fiiter_find_entry - find entry in given directory.
  *
@@ -207,161 +108,6 @@ static int udf_fiiter_find_entry(struct inode *dir, const struct qstr *child,
 	return ret;
 }
 
-/**
- * udf_find_entry - find entry in given directory.
- *
- * @dir:	directory inode to search in
- * @child:	qstr of the name
- * @fibh:	buffer head / inode with file identifier descriptor we found
- * @cfi:	found file identifier descriptor with given name
- *
- * This function searches in the directory @dir for a file name @child. When
- * found, @fibh points to the buffer head(s) (bh is NULL for in ICB
- * directories) containing the file identifier descriptor (FID). In that case
- * the function returns pointer to the FID in the buffer or inode - but note
- * that FID may be split among two buffers (blocks) so accessing it via that
- * pointer isn't easily possible. This pointer can be used only as an iterator
- * for other directory manipulation functions. For inspection of the FID @cfi
- * can be used - the found FID is copied there.
- *
- * Returns pointer to FID, NULL when nothing found, or error code.
- */
-static struct fileIdentDesc *udf_find_entry(struct inode *dir,
-					    const struct qstr *child,
-					    struct udf_fileident_bh *fibh,
-					    struct fileIdentDesc *cfi)
-{
-	struct fileIdentDesc *fi = NULL;
-	loff_t f_pos;
-	udf_pblk_t block;
-	int flen;
-	unsigned char *fname = NULL, *copy_name = NULL;
-	unsigned char *nameptr;
-	uint8_t lfi;
-	uint16_t liu;
-	loff_t size;
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	struct extent_position epos = {};
-	struct udf_inode_info *dinfo = UDF_I(dir);
-	int isdotdot = child->len == 2 &&
-		child->name[0] == '.' && child->name[1] == '.';
-	struct super_block *sb = dir->i_sb;
-
-	size = udf_ext0_offset(dir) + dir->i_size;
-	f_pos = udf_ext0_offset(dir);
-
-	fibh->sbh = fibh->ebh = NULL;
-	fibh->soffset = fibh->eoffset = f_pos & (sb->s_blocksize - 1);
-	if (dinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, f_pos >> sb->s_blocksize_bits, &epos,
-		    &eloc, &elen, &offset) != (EXT_RECORDED_ALLOCATED >> 30)) {
-			fi = ERR_PTR(-EIO);
-			goto out_err;
-		}
-
-		block = udf_get_lb_pblock(sb, &eloc, offset);
-		if ((++offset << sb->s_blocksize_bits) < elen) {
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else
-			offset = 0;
-
-		fibh->sbh = fibh->ebh = udf_tread(sb, block);
-		if (!fibh->sbh) {
-			fi = ERR_PTR(-EIO);
-			goto out_err;
-		}
-	}
-
-	fname = kmalloc(UDF_NAME_LEN, GFP_NOFS);
-	if (!fname) {
-		fi = ERR_PTR(-ENOMEM);
-		goto out_err;
-	}
-
-	while (f_pos < size) {
-		fi = udf_fileident_read(dir, &f_pos, fibh, cfi, &epos, &eloc,
-					&elen, &offset);
-		if (!fi) {
-			fi = ERR_PTR(-EIO);
-			goto out_err;
-		}
-
-		liu = le16_to_cpu(cfi->lengthOfImpUse);
-		lfi = cfi->lengthFileIdent;
-
-		if (fibh->sbh == fibh->ebh) {
-			nameptr = udf_get_fi_ident(fi);
-		} else {
-			int poffset;	/* Unpaded ending offset */
-
-			poffset = fibh->soffset + sizeof(struct fileIdentDesc) +
-					liu + lfi;
-
-			if (poffset >= lfi)
-				nameptr = (uint8_t *)(fibh->ebh->b_data +
-						      poffset - lfi);
-			else {
-				if (!copy_name) {
-					copy_name = kmalloc(UDF_NAME_LEN_CS0,
-							    GFP_NOFS);
-					if (!copy_name) {
-						fi = ERR_PTR(-ENOMEM);
-						goto out_err;
-					}
-				}
-				nameptr = copy_name;
-				memcpy(nameptr, udf_get_fi_ident(fi),
-					lfi - poffset);
-				memcpy(nameptr + lfi - poffset,
-					fibh->ebh->b_data, poffset);
-			}
-		}
-
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_DELETED) != 0) {
-			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNDELETE))
-				continue;
-		}
-
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_HIDDEN) != 0) {
-			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNHIDE))
-				continue;
-		}
-
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_PARENT) &&
-		    isdotdot)
-			goto out_ok;
-
-		if (!lfi)
-			continue;
-
-		flen = udf_get_filename(sb, nameptr, lfi, fname, UDF_NAME_LEN);
-		if (flen < 0) {
-			fi = ERR_PTR(flen);
-			goto out_err;
-		}
-
-		if (udf_match(flen, fname, child->len, child->name))
-			goto out_ok;
-	}
-
-	fi = NULL;
-out_err:
-	if (fibh->sbh != fibh->ebh)
-		brelse(fibh->ebh);
-	brelse(fibh->sbh);
-out_ok:
-	brelse(epos.bh);
-	kfree(fname);
-	kfree(copy_name);
-
-	return fi;
-}
-
 static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags)
 {
@@ -578,245 +324,6 @@ static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
 	return 0;
 }
 
-static struct fileIdentDesc *udf_add_entry(struct inode *dir,
-					   struct dentry *dentry,
-					   struct udf_fileident_bh *fibh,
-					   struct fileIdentDesc *cfi, int *err)
-{
-	struct super_block *sb = dir->i_sb;
-	struct fileIdentDesc *fi = NULL;
-	unsigned char *name = NULL;
-	int namelen;
-	loff_t f_pos;
-	loff_t size = udf_ext0_offset(dir) + dir->i_size;
-	int nfidlen;
-	udf_pblk_t block;
-	struct kernel_lb_addr eloc;
-	uint32_t elen = 0;
-	sector_t offset;
-	struct extent_position epos = {};
-	struct udf_inode_info *dinfo;
-
-	fibh->sbh = fibh->ebh = NULL;
-	name = kmalloc(UDF_NAME_LEN_CS0, GFP_NOFS);
-	if (!name) {
-		*err = -ENOMEM;
-		goto out_err;
-	}
-
-	if (dentry) {
-		if (!dentry->d_name.len) {
-			*err = -EINVAL;
-			goto out_err;
-		}
-		namelen = udf_put_filename(sb, dentry->d_name.name,
-					   dentry->d_name.len,
-					   name, UDF_NAME_LEN_CS0);
-		if (!namelen) {
-			*err = -ENAMETOOLONG;
-			goto out_err;
-		}
-	} else {
-		namelen = 0;
-	}
-
-	nfidlen = ALIGN(sizeof(struct fileIdentDesc) + namelen, UDF_NAME_PAD);
-
-	f_pos = udf_ext0_offset(dir);
-
-	fibh->soffset = fibh->eoffset = f_pos & (dir->i_sb->s_blocksize - 1);
-	dinfo = UDF_I(dir);
-	if (dinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, f_pos >> dir->i_sb->s_blocksize_bits, &epos,
-		    &eloc, &elen, &offset) != (EXT_RECORDED_ALLOCATED >> 30)) {
-			block = udf_get_lb_pblock(dir->i_sb,
-					&dinfo->i_location, 0);
-			fibh->soffset = fibh->eoffset = sb->s_blocksize;
-			goto add;
-		}
-		block = udf_get_lb_pblock(dir->i_sb, &eloc, offset);
-		if ((++offset << dir->i_sb->s_blocksize_bits) < elen) {
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else
-			offset = 0;
-
-		fibh->sbh = fibh->ebh = udf_tread(dir->i_sb, block);
-		if (!fibh->sbh) {
-			*err = -EIO;
-			goto out_err;
-		}
-
-		block = dinfo->i_location.logicalBlockNum;
-	}
-
-	while (f_pos < size) {
-		fi = udf_fileident_read(dir, &f_pos, fibh, cfi, &epos, &eloc,
-					&elen, &offset);
-
-		if (!fi) {
-			*err = -EIO;
-			goto out_err;
-		}
-
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_DELETED) != 0) {
-			if (udf_dir_entry_len(cfi) == nfidlen) {
-				cfi->descTag.tagSerialNum = cpu_to_le16(1);
-				cfi->fileVersionNum = cpu_to_le16(1);
-				cfi->fileCharacteristics = 0;
-				cfi->lengthFileIdent = namelen;
-				cfi->lengthOfImpUse = cpu_to_le16(0);
-				if (!udf_write_fi(dir, cfi, fi, fibh, NULL,
-						  name))
-					goto out_ok;
-				else {
-					*err = -EIO;
-					goto out_err;
-				}
-			}
-		}
-	}
-
-add:
-	f_pos += nfidlen;
-
-	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
-	    sb->s_blocksize - fibh->eoffset < nfidlen) {
-		brelse(epos.bh);
-		epos.bh = NULL;
-		fibh->soffset -= udf_ext0_offset(dir);
-		fibh->eoffset -= udf_ext0_offset(dir);
-		f_pos -= udf_ext0_offset(dir);
-		if (fibh->sbh != fibh->ebh)
-			brelse(fibh->ebh);
-		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh =
-				udf_expand_dir_adinicb(dir, &block, err);
-		if (!fibh->sbh)
-			goto out_err;
-		epos.block = dinfo->i_location;
-		epos.offset = udf_file_entry_alloc_offset(dir);
-		/* Load extent udf_expand_dir_adinicb() has created */
-		udf_current_aext(dir, &epos, &eloc, &elen, 1);
-	}
-
-	/* Entry fits into current block? */
-	if (sb->s_blocksize - fibh->eoffset >= nfidlen) {
-		fibh->soffset = fibh->eoffset;
-		fibh->eoffset += nfidlen;
-		if (fibh->sbh != fibh->ebh) {
-			brelse(fibh->sbh);
-			fibh->sbh = fibh->ebh;
-		}
-
-		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-			block = dinfo->i_location.logicalBlockNum;
-			fi = (struct fileIdentDesc *)
-					(dinfo->i_data + fibh->soffset -
-					 udf_ext0_offset(dir) +
-					 dinfo->i_lenEAttr);
-		} else {
-			block = eloc.logicalBlockNum +
-					((elen - 1) >>
-						dir->i_sb->s_blocksize_bits);
-			fi = (struct fileIdentDesc *)
-				(fibh->sbh->b_data + fibh->soffset);
-		}
-	} else {
-		/* Round up last extent in the file */
-		elen = (elen + sb->s_blocksize - 1) & ~(sb->s_blocksize - 1);
-		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-			epos.offset -= sizeof(struct short_ad);
-		else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-			epos.offset -= sizeof(struct long_ad);
-		udf_write_aext(dir, &epos, &eloc, elen, 1);
-		dinfo->i_lenExtents = (dinfo->i_lenExtents + sb->s_blocksize
-					- 1) & ~(sb->s_blocksize - 1);
-
-		fibh->soffset = fibh->eoffset - sb->s_blocksize;
-		fibh->eoffset += nfidlen - sb->s_blocksize;
-		if (fibh->sbh != fibh->ebh) {
-			brelse(fibh->sbh);
-			fibh->sbh = fibh->ebh;
-		}
-
-		block = eloc.logicalBlockNum + ((elen - 1) >>
-						dir->i_sb->s_blocksize_bits);
-		fibh->ebh = udf_bread(dir,
-				f_pos >> dir->i_sb->s_blocksize_bits, 1, err);
-		if (!fibh->ebh)
-			goto out_err;
-		/* Extents could have been merged, invalidate our position */
-		brelse(epos.bh);
-		epos.bh = NULL;
-		epos.block = dinfo->i_location;
-		epos.offset = udf_file_entry_alloc_offset(dir);
-
-		if (!fibh->soffset) {
-			/* Find the freshly allocated block */
-			while (udf_next_aext(dir, &epos, &eloc, &elen, 1) ==
-				(EXT_RECORDED_ALLOCATED >> 30))
-				;
-			block = eloc.logicalBlockNum + ((elen - 1) >>
-					dir->i_sb->s_blocksize_bits);
-			brelse(fibh->sbh);
-			fibh->sbh = fibh->ebh;
-			fi = (struct fileIdentDesc *)(fibh->sbh->b_data);
-		} else {
-			fi = (struct fileIdentDesc *)
-				(fibh->sbh->b_data + sb->s_blocksize +
-					fibh->soffset);
-		}
-	}
-
-	memset(cfi, 0, sizeof(struct fileIdentDesc));
-	if (UDF_SB(sb)->s_udfrev >= 0x0200)
-		udf_new_tag((char *)cfi, TAG_IDENT_FID, 3, 1, block,
-			    sizeof(struct tag));
-	else
-		udf_new_tag((char *)cfi, TAG_IDENT_FID, 2, 1, block,
-			    sizeof(struct tag));
-	cfi->fileVersionNum = cpu_to_le16(1);
-	cfi->lengthFileIdent = namelen;
-	cfi->lengthOfImpUse = cpu_to_le16(0);
-	if (!udf_write_fi(dir, cfi, fi, fibh, NULL, name)) {
-		dir->i_size += nfidlen;
-		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-			dinfo->i_lenAlloc += nfidlen;
-		else {
-			/* Find the last extent and truncate it to proper size */
-			while (udf_next_aext(dir, &epos, &eloc, &elen, 1) ==
-				(EXT_RECORDED_ALLOCATED >> 30))
-				;
-			elen -= dinfo->i_lenExtents - dir->i_size;
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-			udf_write_aext(dir, &epos, &eloc, elen, 1);
-			dinfo->i_lenExtents = dir->i_size;
-		}
-
-		mark_inode_dirty(dir);
-		goto out_ok;
-	} else {
-		*err = -EIO;
-		goto out_err;
-	}
-
-out_err:
-	fi = NULL;
-	if (fibh->sbh != fibh->ebh)
-		brelse(fibh->ebh);
-	brelse(fibh->sbh);
-out_ok:
-	brelse(epos.bh);
-	kfree(name);
-	return fi;
-}
-
 static void udf_fiiter_delete_entry(struct udf_fileident_iter *iter)
 {
 	iter->fi.fileCharacteristics |= FID_FILE_CHAR_DELETED;
@@ -827,18 +334,6 @@ static void udf_fiiter_delete_entry(struct udf_fileident_iter *iter)
 	udf_fiiter_write_fi(iter, NULL);
 }
 
-static int udf_delete_entry(struct inode *inode, struct fileIdentDesc *fi,
-			    struct udf_fileident_bh *fibh,
-			    struct fileIdentDesc *cfi)
-{
-	cfi->fileCharacteristics |= FID_FILE_CHAR_DELETED;
-
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_STRICT))
-		memset(&(cfi->icb), 0x00, sizeof(struct long_ad));
-
-	return udf_write_fi(inode, cfi, fi, fibh, NULL, NULL);
-}
-
 static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 {
 	struct udf_inode_info *iinfo = UDF_I(inode);
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index e47b2f0c3e05..f764b4d15094 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -104,13 +104,6 @@ struct udf_fileident_iter {
 					 */
 };
 
-struct udf_fileident_bh {
-	struct buffer_head *sbh;
-	struct buffer_head *ebh;
-	int soffset;
-	int eoffset;
-};
-
 struct udf_vds_record {
 	uint32_t block;
 	uint32_t volDescSeqNum;
@@ -139,19 +132,12 @@ struct inode *udf_find_metadata_inode_efe(struct super_block *sb,
 					u32 meta_file_loc, u32 partition_num);
 
 /* namei.c */
-extern int udf_write_fi(struct inode *inode, struct fileIdentDesc *,
-			struct fileIdentDesc *, struct udf_fileident_bh *,
-			uint8_t *, uint8_t *);
 static inline unsigned int udf_dir_entry_len(struct fileIdentDesc *cfi)
 {
 	return ALIGN(sizeof(struct fileIdentDesc) +
 		le16_to_cpu(cfi->lengthOfImpUse) + cfi->lengthFileIdent,
 		UDF_NAME_PAD);
 }
-static inline uint8_t *udf_get_fi_ident(struct fileIdentDesc *fi)
-{
-	return ((uint8_t *)(fi + 1)) + le16_to_cpu(fi->lengthOfImpUse);
-}
 
 /* file.c */
 extern long udf_ioctl(struct file *, unsigned int, unsigned long);
@@ -266,14 +252,6 @@ void udf_fiiter_release(struct udf_fileident_iter *iter);
 void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse);
 void udf_fiiter_update_elen(struct udf_fileident_iter *iter, uint32_t new_elen);
 int udf_fiiter_append_blk(struct udf_fileident_iter *iter);
-extern struct fileIdentDesc *udf_fileident_read(struct inode *, loff_t *,
-						struct udf_fileident_bh *,
-						struct fileIdentDesc *,
-						struct extent_position *,
-						struct kernel_lb_addr *, uint32_t *,
-						sector_t *);
-extern struct fileIdentDesc *udf_get_fileident(void *buffer, int bufsize,
-					       int *offset);
 extern struct long_ad *udf_get_filelongad(uint8_t *, int, uint32_t *, int);
 extern struct short_ad *udf_get_fileshortad(uint8_t *, int, uint32_t *, int);
 
-- 
2.35.3

