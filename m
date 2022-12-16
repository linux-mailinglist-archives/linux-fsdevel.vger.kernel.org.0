Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54164EDE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLPP1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiLPP1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610AA554DB
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 794F1343E6;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GO2T/CkIA419AOsTsgc01VBwlnCrnxa0mZrBr5UQyXI=;
        b=FCe9NosenWBpZYif0+pFhI97YQ2ej442tPiB0IrXPaCmCmdanRROlVljrhzVEe5sMZcs59
        QXFWl1stNzTHR6cPsoqlZnK0fr1BrQDDmqtQB75JkqZjBZJUFZ1F14nVeNeqqAImO6IKir
        UsZM84npgPa+Cj5EvwFuGzkDPysFZ7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GO2T/CkIA419AOsTsgc01VBwlnCrnxa0mZrBr5UQyXI=;
        b=mH08JVv9E5JZlC7VyCymtcUV69Ym5SMmHiP1LCCgCpY2azbtz/zZOg83tgZ0G+N3itenc5
        9SKSbd637qs/o6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54C10138FD;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RCYbFEaOnGPhCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BAD7AA0770; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 13/20] udf: Implement adding of dir entries using new iteration code
Date:   Fri, 16 Dec 2022 16:24:17 +0100
Message-Id: <20221216152656.6236-13-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7051; i=jack@suse.cz; h=from:subject; bh=iLV5a5SARggYBVbIuSwWJaIsZIwtqJL4FoD0Ki03kCI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2h6pmq0igu7DCT2snLxWGBXXBg8uvUzX/BjIm6 5xI82pqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNoQAKCRCcnaoHP2RA2d4TB/ 0RbZOnE2Cy4Yf+XgrqVEegDgVV5aFBjkm+/SNZOkpwgR47iCg/kfZ22/4XyYwzAaJHuXLkd+IhOgG/ 17v+tpOpptOolF+JNReKh3ikIDSN4DTMf4jvJz+FvkExPaf6QBmSmD4m8tbxaVu81ib71JfPfFKu6U boabcGD5vzdOvARxFhNA7E8J1bk2ZOSpgNfSalPXNfUVi3O+kAeHmfyYao+TOpfIHw7qg1x4Kv2hug PwRDj9TGUopHCg4ZA5HGnOtRNqeWcPr6iH0ufLL9GvXkVjw29nyk1wU741KVCmGadRwotakp0QJQmJ KhvvLiWvZB6/wQ4SgxYt3RYxJZxGZG
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

Implement function udf_fiiter_add_entry() adding new directory entries
using new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/directory.c |  57 ++++++++++++++++++++++++
 fs/udf/namei.c     | 106 +++++++++++++++++++++++++++++++++++++++++++++
 fs/udf/udfdecl.h   |   2 +
 3 files changed, 165 insertions(+)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 66117e834e29..9b5e4f6a9dd1 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -413,6 +413,63 @@ void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse)
 	inode_inc_iversion(iter->dir);
 }
 
+void udf_fiiter_update_elen(struct udf_fileident_iter *iter, uint32_t new_elen)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	int diff = new_elen - iter->elen;
+
+	/* Skip update when we already went past the last extent */
+	if (!iter->elen)
+		return;
+	iter->elen = new_elen;
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
+		iter->epos.offset -= sizeof(struct short_ad);
+	else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
+		iter->epos.offset -= sizeof(struct long_ad);
+	udf_write_aext(iter->dir, &iter->epos, &iter->eloc, iter->elen, 1);
+	iinfo->i_lenExtents += diff;
+	mark_inode_dirty(iter->dir);
+}
+
+/* Append new block to directory. @iter is expected to point at EOF */
+int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	int blksize = 1 << iter->dir->i_blkbits;
+	struct buffer_head *bh;
+	sector_t block;
+	uint32_t old_elen = iter->elen;
+	int err;
+
+	if (WARN_ON_ONCE(iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB))
+		return -EINVAL;
+
+	/* Round up last extent in the file */
+	udf_fiiter_update_elen(iter, ALIGN(iter->elen, blksize));
+
+	/* Allocate new block and refresh mapping information */
+	block = iinfo->i_lenExtents >> iter->dir->i_blkbits;
+	bh = udf_bread(iter->dir, block, 1, &err);
+	if (!bh) {
+		udf_fiiter_update_elen(iter, old_elen);
+		return err;
+	}
+	if (inode_bmap(iter->dir, block, &iter->epos, &iter->eloc, &iter->elen,
+		       &iter->loffset) != (EXT_RECORDED_ALLOCATED >> 30)) {
+		udf_err(iter->dir->i_sb,
+			"block %llu not allocated in directory (ino %lu)\n",
+			(unsigned long long)block, iter->dir->i_ino);
+		return -EFSCORRUPTED;
+	}
+	if (!(iter->pos & (blksize - 1))) {
+		brelse(iter->bh[0]);
+		iter->bh[0] = bh;
+	} else {
+		iter->bh[1] = bh;
+	}
+	return 0;
+}
+
 struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 					 struct udf_fileident_bh *fibh,
 					 struct fileIdentDesc *cfi,
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index d0ffd2083519..cfcdc9ec8fe3 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -472,6 +472,112 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	return dbh;
 }
 
+static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
+				struct udf_fileident_iter *iter)
+{
+	struct udf_inode_info *dinfo = UDF_I(dir);
+	int nfidlen, namelen = 0;
+	int ret;
+	int off, blksize = 1 << dir->i_blkbits;
+	udf_pblk_t block;
+	char name[UDF_NAME_LEN_CS0];
+
+	if (dentry) {
+		if (!dentry->d_name.len)
+			return -EINVAL;
+		namelen = udf_put_filename(dir->i_sb, dentry->d_name.name,
+					   dentry->d_name.len,
+					   name, UDF_NAME_LEN_CS0);
+		if (!namelen)
+			return -ENAMETOOLONG;
+	}
+	nfidlen = ALIGN(sizeof(struct fileIdentDesc) + namelen, UDF_NAME_PAD);
+
+	for (ret = udf_fiiter_init(iter, dir, 0);
+	     !ret && iter->pos < dir->i_size;
+	     ret = udf_fiiter_advance(iter)) {
+		if (iter->fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
+			if (udf_dir_entry_len(&iter->fi) == nfidlen) {
+				iter->fi.descTag.tagSerialNum = cpu_to_le16(1);
+				iter->fi.fileVersionNum = cpu_to_le16(1);
+				iter->fi.fileCharacteristics = 0;
+				iter->fi.lengthFileIdent = namelen;
+				iter->fi.lengthOfImpUse = cpu_to_le16(0);
+				memcpy(iter->namebuf, name, namelen);
+				iter->name = iter->namebuf;
+				return 0;
+			}
+		}
+	}
+	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
+	    blksize - udf_ext0_offset(dir) - iter->pos < nfidlen) {
+		struct buffer_head *retbh;
+
+		udf_fiiter_release(iter);
+		/*
+		 * FIXME: udf_expand_dir_adinicb does not need to return bh
+		 * once other users are gone
+		 */
+		retbh = udf_expand_dir_adinicb(dir, &block, &ret);
+		if (!retbh)
+			return ret;
+		brelse(retbh);
+		ret = udf_fiiter_init(iter, dir, dir->i_size);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Get blocknumber to use for entry tag */
+	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		block = dinfo->i_location.logicalBlockNum;
+	} else {
+		block = iter->eloc.logicalBlockNum +
+				((iter->elen - 1) >> dir->i_blkbits);
+	}
+	off = iter->pos & (blksize - 1);
+	if (!off)
+		off = blksize;
+	/* Entry fits into current block? */
+	if (blksize - udf_ext0_offset(dir) - off >= nfidlen)
+		goto store_fi;
+
+	ret = udf_fiiter_append_blk(iter);
+	if (ret) {
+		udf_fiiter_release(iter);
+		return ret;
+	}
+
+	/* Entry will be completely in the new block? Update tag location... */
+	if (!(iter->pos & (blksize - 1)))
+		block = iter->eloc.logicalBlockNum +
+				((iter->elen - 1) >> dir->i_blkbits);
+store_fi:
+	memset(&iter->fi, 0, sizeof(struct fileIdentDesc));
+	if (UDF_SB(dir->i_sb)->s_udfrev >= 0x0200)
+		udf_new_tag((char *)(&iter->fi), TAG_IDENT_FID, 3, 1, block,
+			    sizeof(struct tag));
+	else
+		udf_new_tag((char *)(&iter->fi), TAG_IDENT_FID, 2, 1, block,
+			    sizeof(struct tag));
+	iter->fi.fileVersionNum = cpu_to_le16(1);
+	iter->fi.lengthFileIdent = namelen;
+	iter->fi.lengthOfImpUse = cpu_to_le16(0);
+	memcpy(iter->namebuf, name, namelen);
+	iter->name = iter->namebuf;
+
+	dir->i_size += nfidlen;
+	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		dinfo->i_lenAlloc += nfidlen;
+	} else {
+		/* Truncate last extent to proper size */
+		udf_fiiter_update_elen(iter, iter->elen -
+					(dinfo->i_lenExtents - dir->i_size));
+	}
+	mark_inode_dirty(dir);
+
+	return 0;
+}
+
 static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 					   struct dentry *dentry,
 					   struct udf_fileident_bh *fibh,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 676fa2996ffe..e47b2f0c3e05 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -264,6 +264,8 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 int udf_fiiter_advance(struct udf_fileident_iter *iter);
 void udf_fiiter_release(struct udf_fileident_iter *iter);
 void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse);
+void udf_fiiter_update_elen(struct udf_fileident_iter *iter, uint32_t new_elen);
+int udf_fiiter_append_blk(struct udf_fileident_iter *iter);
 extern struct fileIdentDesc *udf_fileident_read(struct inode *, loff_t *,
 						struct udf_fileident_bh *,
 						struct fileIdentDesc *,
-- 
2.35.3

