Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9BE64EDDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiLPP1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiLPP1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98F260374
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 981BE343E3;
        Fri, 16 Dec 2022 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snuDeHHcHgtI8OCe0wF4NjrXc/xa5XPfZ1tsWS+PIeA=;
        b=TRDmaDVowHMNlRK8kpLGtEB4elt/lFZH5+98xdnHN1Rio/7zCrQ3twWo9oVdm1VqlSg/BN
        kdbeELEcYgNF3Hp9+Ou4DKT25Z5BVoJkeyc7gzOfJGUBCYfpWzezQKgtqBAw2WjrWg6f2r
        bUrzVGNkV7gc0MwPTHcF/Nd12vH168w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snuDeHHcHgtI8OCe0wF4NjrXc/xa5XPfZ1tsWS+PIeA=;
        b=FNKkkso26QvE2b3OqfstFlmie3DYqdHdk8+oU7hslolKKFVAKxWKRoyCuGKwK2BzFxPwPP
        Aq1VEg/uUf6ZA7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDD801390A;
        Fri, 16 Dec 2022 15:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XUmPOUOOnGPBCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:26:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 78D35A0764; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 02/20] udf: New directory iteration code
Date:   Fri, 16 Dec 2022 16:24:06 +0100
Message-Id: <20221216152656.6236-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14099; i=jack@suse.cz; h=from:subject; bh=HZogkvSCWTQv418G4y+KTgyvrs0B0OnTedds6QtlZAQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2XabSWvU80ARKCWwS8tFla3EoJkV7VeJlpc+v1 azjoFaqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNlwAKCRCcnaoHP2RA2dMcB/ 9us8l18M1uhJDSoY7s+Gvq83IOm5jq3LoH6+35fZ3Gkgo10HVDuX/InJ0FNQZ4a/JnxeD8fsiaNNqe I2agnZEOUFf6EbXUZd3fRIptCbcd/SW4YyGM3tNOtU/RaO2KCpfkLHkv4keLWAGW2NkPBGHw5F2N0U 1tzIxvVdUtEbS/5w6nxWa9BsoI4KieBns4x5C2iVCBPcF/ZNduA7rjbWKVRd7wJauImBeO46GYuTZY AfZ2zAj/rCh/gU6Vce7FwmNZXo7j7OrsVdVWdF0Zt/cvREIXsmVEg4tmSGfbqOmE385UV/XC4ON1Bc vNY063vMVBlDuMsE4/pnzCeLqxrgEB
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

Add new support code for iterating directory entries. The code is also
more carefully verifying validity of on-disk directory entries to avoid
crashes on malicious media.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/directory.c | 395 +++++++++++++++++++++++++++++++++++++++++++++
 fs/udf/udfdecl.h   |  23 +++
 2 files changed, 418 insertions(+)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 16bcf2c6b8b3..66117e834e29 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -17,6 +17,401 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/bio.h>
+#include <linux/crc-itu-t.h>
+#include <linux/iversion.h>
+
+static int udf_verify_fi(struct udf_fileident_iter *iter)
+{
+	unsigned int len;
+
+	if (iter->fi.descTag.tagIdent != cpu_to_le16(TAG_IDENT_FID)) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry at pos %llu with incorrect tag %x\n",
+			iter->dir->i_ino, (unsigned long long)iter->pos,
+			le16_to_cpu(iter->fi.descTag.tagIdent));
+		return -EFSCORRUPTED;
+	}
+	len = udf_dir_entry_len(&iter->fi);
+	if (iter->fi.lengthOfImpUse & 3) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry at pos %llu with unaligned lenght of impUse field\n",
+			iter->dir->i_ino, (unsigned long long)iter->pos);
+		return -EFSCORRUPTED;
+	}
+	/*
+	 * This is in fact allowed by the spec due to long impUse field but
+	 * we don't support it. If there is real media with this large impUse
+	 * field, support can be added.
+	 */
+	if (len > 1 << iter->dir->i_blkbits) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has too big (%u) entry at pos %llu\n",
+			iter->dir->i_ino, len, (unsigned long long)iter->pos);
+		return -EFSCORRUPTED;
+	}
+	if (iter->pos + len > iter->dir->i_size) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry past directory size at pos %llu\n",
+			iter->dir->i_ino, (unsigned long long)iter->pos);
+		return -EFSCORRUPTED;
+	}
+	if (udf_dir_entry_len(&iter->fi) !=
+	    sizeof(struct tag) + le16_to_cpu(iter->fi.descTag.descCRCLength)) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry where CRC length (%u) does not match entry length (%u)\n",
+			iter->dir->i_ino,
+			(unsigned)le16_to_cpu(iter->fi.descTag.descCRCLength),
+			(unsigned)(udf_dir_entry_len(&iter->fi) -
+							sizeof(struct tag)));
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
+static int udf_copy_fi(struct udf_fileident_iter *iter)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	int blksize = 1 << iter->dir->i_blkbits;
+	int err, off, len, nameoff;
+
+	/* Skip copying when we are at EOF */
+	if (iter->pos >= iter->dir->i_size) {
+		iter->name = NULL;
+		return 0;
+	}
+	if (iter->dir->i_size < iter->pos + sizeof(struct fileIdentDesc)) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry straddling EOF\n",
+			iter->dir->i_ino);
+		return -EFSCORRUPTED;
+	}
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		memcpy(&iter->fi, iinfo->i_data + iinfo->i_lenEAttr + iter->pos,
+		       sizeof(struct fileIdentDesc));
+		err = udf_verify_fi(iter);
+		if (err < 0)
+			return err;
+		iter->name = iinfo->i_data + iinfo->i_lenEAttr + iter->pos +
+			sizeof(struct fileIdentDesc) +
+			le16_to_cpu(iter->fi.lengthOfImpUse);
+		return 0;
+	}
+
+	off = iter->pos & (blksize - 1);
+	len = min_t(int, sizeof(struct fileIdentDesc), blksize - off);
+	memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
+	if (len < sizeof(struct fileIdentDesc))
+		memcpy((char *)(&iter->fi) + len, iter->bh[1]->b_data,
+		       sizeof(struct fileIdentDesc) - len);
+	err = udf_verify_fi(iter);
+	if (err < 0)
+		return err;
+
+	/* Handle directory entry name */
+	nameoff = off + sizeof(struct fileIdentDesc) +
+				le16_to_cpu(iter->fi.lengthOfImpUse);
+	if (off + udf_dir_entry_len(&iter->fi) <= blksize) {
+		iter->name = iter->bh[0]->b_data + nameoff;
+	} else if (nameoff >= blksize) {
+		iter->name = iter->bh[1]->b_data + (nameoff - blksize);
+	} else {
+		iter->name = iter->namebuf;
+		len = blksize - nameoff;
+		memcpy(iter->name, iter->bh[0]->b_data + nameoff, len);
+		memcpy(iter->name + len, iter->bh[1]->b_data,
+		       iter->fi.lengthFileIdent - len);
+	}
+	return 0;
+}
+
+/* Readahead 8k once we are at 8k boundary */
+static void udf_readahead_dir(struct udf_fileident_iter *iter)
+{
+	unsigned int ralen = 16 >> (iter->dir->i_blkbits - 9);
+	struct buffer_head *tmp, *bha[16];
+	int i, num;
+	udf_pblk_t blk;
+
+	if (iter->loffset & (ralen - 1))
+		return;
+
+	if (iter->loffset + ralen > (iter->elen >> iter->dir->i_blkbits))
+		ralen = (iter->elen >> iter->dir->i_blkbits) - iter->loffset;
+	num = 0;
+	for (i = 0; i < ralen; i++) {
+		blk = udf_get_lb_pblock(iter->dir->i_sb, &iter->eloc,
+					iter->loffset + i);
+		tmp = udf_tgetblk(iter->dir->i_sb, blk);
+		if (tmp && !buffer_uptodate(tmp) && !buffer_locked(tmp))
+			bha[num++] = tmp;
+		else
+			brelse(tmp);
+	}
+	if (num) {
+		bh_readahead_batch(num, bha, REQ_RAHEAD);
+		for (i = 0; i < num; i++)
+			brelse(bha[i]);
+	}
+}
+
+static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
+{
+	udf_pblk_t blk;
+
+	udf_readahead_dir(iter);
+	blk = udf_get_lb_pblock(iter->dir->i_sb, &iter->eloc, iter->loffset);
+	return udf_tread(iter->dir->i_sb, blk);
+}
+
+/*
+ * Updates loffset to point to next directory block; eloc, elen & epos are
+ * updated if we need to traverse to the next extent as well.
+ */
+static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
+{
+	iter->loffset++;
+	if (iter->loffset < iter->elen >> iter->dir->i_blkbits)
+		return 0;
+
+	iter->loffset = 0;
+	if (udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen, 1)
+			!= (EXT_RECORDED_ALLOCATED >> 30)) {
+		if (iter->pos == iter->dir->i_size) {
+			iter->elen = 0;
+			return 0;
+		}
+		udf_err(iter->dir->i_sb,
+			"extent after position %llu not allocated in directory (ino %lu)\n",
+			(unsigned long long)iter->pos, iter->dir->i_ino);
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
+static int udf_fiiter_load_bhs(struct udf_fileident_iter *iter)
+{
+	int blksize = 1 << iter->dir->i_blkbits;
+	int off = iter->pos & (blksize - 1);
+	int err;
+	struct fileIdentDesc *fi;
+
+	/* Is there any further extent we can map from? */
+	if (!iter->bh[0] && iter->elen) {
+		iter->bh[0] = udf_fiiter_bread_blk(iter);
+		if (!iter->bh[0]) {
+			err = -ENOMEM;
+			goto out_brelse;
+		}
+		if (!buffer_uptodate(iter->bh[0])) {
+			err = -EIO;
+			goto out_brelse;
+		}
+	}
+	/* There's no next block so we are done */
+	if (iter->pos >= iter->dir->i_size)
+		return 0;
+	/* Need to fetch next block as well? */
+	if (off + sizeof(struct fileIdentDesc) > blksize)
+		goto fetch_next;
+	fi = (struct fileIdentDesc *)(iter->bh[0]->b_data + off);
+	/* Need to fetch next block to get name? */
+	if (off + udf_dir_entry_len(fi) > blksize) {
+fetch_next:
+		udf_fiiter_advance_blk(iter);
+		iter->bh[1] = udf_fiiter_bread_blk(iter);
+		if (!iter->bh[1]) {
+			err = -ENOMEM;
+			goto out_brelse;
+		}
+		if (!buffer_uptodate(iter->bh[1])) {
+			err = -EIO;
+			goto out_brelse;
+		}
+	}
+	return 0;
+out_brelse:
+	brelse(iter->bh[0]);
+	brelse(iter->bh[1]);
+	iter->bh[0] = iter->bh[1] = NULL;
+	return err;
+}
+
+int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
+		    loff_t pos)
+{
+	struct udf_inode_info *iinfo = UDF_I(dir);
+	int err = 0;
+
+	iter->dir = dir;
+	iter->bh[0] = iter->bh[1] = NULL;
+	iter->pos = pos;
+	iter->elen = 0;
+	iter->epos.bh = NULL;
+	iter->name = NULL;
+
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		return udf_copy_fi(iter);
+
+	if (inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
+		       &iter->eloc, &iter->elen, &iter->loffset) !=
+	    (EXT_RECORDED_ALLOCATED >> 30)) {
+		if (pos == dir->i_size)
+			return 0;
+		udf_err(dir->i_sb,
+			"position %llu not allocated in directory (ino %lu)\n",
+			(unsigned long long)pos, dir->i_ino);
+		return -EFSCORRUPTED;
+	}
+	err = udf_fiiter_load_bhs(iter);
+	if (err < 0)
+		return err;
+	err = udf_copy_fi(iter);
+	if (err < 0) {
+		udf_fiiter_release(iter);
+		return err;
+	}
+	return 0;
+}
+
+int udf_fiiter_advance(struct udf_fileident_iter *iter)
+{
+	unsigned int oldoff, len;
+	int blksize = 1 << iter->dir->i_blkbits;
+	int err;
+
+	oldoff = iter->pos & (blksize - 1);
+	len = udf_dir_entry_len(&iter->fi);
+	iter->pos += len;
+	if (UDF_I(iter->dir)->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+		if (oldoff + len >= blksize) {
+			brelse(iter->bh[0]);
+			iter->bh[0] = NULL;
+			/* Next block already loaded? */
+			if (iter->bh[1]) {
+				iter->bh[0] = iter->bh[1];
+				iter->bh[1] = NULL;
+			} else {
+				udf_fiiter_advance_blk(iter);
+			}
+		}
+		err = udf_fiiter_load_bhs(iter);
+		if (err < 0)
+			return err;
+	}
+	return udf_copy_fi(iter);
+}
+
+void udf_fiiter_release(struct udf_fileident_iter *iter)
+{
+	iter->dir = NULL;
+	brelse(iter->bh[0]);
+	brelse(iter->bh[1]);
+	iter->bh[0] = iter->bh[1] = NULL;
+}
+
+static void udf_copy_to_bufs(void *buf1, int len1, void *buf2, int len2,
+			     int off, void *src, int len)
+{
+	int copy;
+
+	if (off >= len1) {
+		off -= len1;
+	} else {
+		copy = min(off + len, len1) - off;
+		memcpy(buf1 + off, src, copy);
+		src += copy;
+		len -= copy;
+		off = 0;
+	}
+	if (len > 0) {
+		if (WARN_ON_ONCE(off + len > len2 || !buf2))
+			return;
+		memcpy(buf2 + off, src, len);
+	}
+}
+
+static uint16_t udf_crc_fi_bufs(void *buf1, int len1, void *buf2, int len2,
+				int off, int len)
+{
+	int copy;
+	uint16_t crc = 0;
+
+	if (off >= len1) {
+		off -= len1;
+	} else {
+		copy = min(off + len, len1) - off;
+		crc = crc_itu_t(crc, buf1 + off, copy);
+		len -= copy;
+		off = 0;
+	}
+	if (len > 0) {
+		if (WARN_ON_ONCE(off + len > len2 || !buf2))
+			return 0;
+		crc = crc_itu_t(crc, buf2 + off, len);
+	}
+	return crc;
+}
+
+static void udf_copy_fi_to_bufs(char *buf1, int len1, char *buf2, int len2,
+				int off, struct fileIdentDesc *fi,
+				uint8_t *impuse, uint8_t *name)
+{
+	uint16_t crc;
+	int fioff = off;
+	int crcoff = off + sizeof(struct tag);
+	unsigned int crclen = udf_dir_entry_len(fi) - sizeof(struct tag);
+
+	udf_copy_to_bufs(buf1, len1, buf2, len2, off, fi,
+			 sizeof(struct fileIdentDesc));
+	off += sizeof(struct fileIdentDesc);
+	if (impuse)
+		udf_copy_to_bufs(buf1, len1, buf2, len2, off, impuse,
+				 le16_to_cpu(fi->lengthOfImpUse));
+	off += le16_to_cpu(fi->lengthOfImpUse);
+	if (name)
+		udf_copy_to_bufs(buf1, len1, buf2, len2, off, name,
+				 fi->lengthFileIdent);
+
+	crc = udf_crc_fi_bufs(buf1, len1, buf2, len2, crcoff, crclen);
+	fi->descTag.descCRC = cpu_to_le16(crc);
+	fi->descTag.descCRCLength = cpu_to_le16(crclen);
+	fi->descTag.tagChecksum = udf_tag_checksum(&fi->descTag);
+
+	udf_copy_to_bufs(buf1, len1, buf2, len2, fioff, fi, sizeof(struct tag));
+}
+
+void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	void *buf1, *buf2 = NULL;
+	int len1, len2 = 0, off;
+	int blksize = 1 << iter->dir->i_blkbits;
+
+	off = iter->pos & (blksize - 1);
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		buf1 = iinfo->i_data + iinfo->i_lenEAttr;
+		len1 = iter->dir->i_size;
+	} else {
+		buf1 = iter->bh[0]->b_data;
+		len1 = blksize;
+		if (iter->bh[1]) {
+			buf2 = iter->bh[1]->b_data;
+			len2 = blksize;
+		}
+	}
+
+	udf_copy_fi_to_bufs(buf1, len1, buf2, len2, off, &iter->fi, impuse,
+			    iter->name == iter->namebuf ? iter->name : NULL);
+
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		mark_inode_dirty(iter->dir);
+	} else {
+		mark_buffer_dirty_inode(iter->bh[0], iter->dir);
+		if (iter->bh[1])
+			mark_buffer_dirty_inode(iter->bh[1], iter->dir);
+	}
+	inode_inc_iversion(iter->dir);
+}
 
 struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 					 struct udf_fileident_bh *fibh,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 7e258f15b8ef..22a8466e335c 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -86,6 +86,24 @@ extern const struct address_space_operations udf_aops;
 extern const struct address_space_operations udf_adinicb_aops;
 extern const struct address_space_operations udf_symlink_aops;
 
+struct udf_fileident_iter {
+	struct inode *dir;		/* Directory we are working with */
+	loff_t pos;			/* Logical position in a dir */
+	struct buffer_head *bh[2];	/* Buffer containing 'pos' and possibly
+					 * next buffer if entry straddles
+					 * blocks */
+	struct kernel_lb_addr eloc;	/* Start of extent containing 'pos' */
+	uint32_t elen;			/* Length of extent containing 'pos' */
+	sector_t loffset;		/* Block offset of 'pos' within above
+					 * extent */
+	struct extent_position epos;	/* Position after the above extent */
+	struct fileIdentDesc fi;	/* Copied directory entry */
+	uint8_t *name;			/* Pointer to entry name */
+	uint8_t namebuf[UDF_NAME_LEN_CS0]; /* Storage for entry name in case
+					 * the name is split between two blocks
+					 */
+};
+
 struct udf_fileident_bh {
 	struct buffer_head *sbh;
 	struct buffer_head *ebh;
@@ -243,6 +261,11 @@ extern udf_pblk_t udf_new_block(struct super_block *sb, struct inode *inode,
 				 uint16_t partition, uint32_t goal, int *err);
 
 /* directory.c */
+int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
+		    loff_t pos);
+int udf_fiiter_advance(struct udf_fileident_iter *iter);
+void udf_fiiter_release(struct udf_fileident_iter *iter);
+void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse);
 extern struct fileIdentDesc *udf_fileident_read(struct inode *, loff_t *,
 						struct udf_fileident_bh *,
 						struct fileIdentDesc *,
-- 
2.35.3

