Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4522264EDEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiLPP1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiLPP1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0064A6034A
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 586FF5D11D;
        Fri, 16 Dec 2022 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HcGD4F59pKkgR7B/VRR2elKZY30bNNlE4rd3JLiMBLQ=;
        b=TLr/hFH5io2fc8Xrnc4oozMRjZHedqVxINJbevmWH9TNbBIGxpwdnVmjerpYgf3IlfenOC
        BzlATvuu99cjo0rODjzQbQEBizneWBQecDlg0iRtnVzEiyKyYmdozAT3ah1aux6NqonaVU
        diK27dyDoT7ndmnV31AP8Z5JuinW2/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HcGD4F59pKkgR7B/VRR2elKZY30bNNlE4rd3JLiMBLQ=;
        b=8v6NIy12fejiZqCdrG3up94Zl69Wk68l1sA9nFPrwcmIzFdjmHJM5FRofBgXaHBHGQYvQv
        jG8cT2gDWRphE/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39D1E13904;
        Fri, 16 Dec 2022 15:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oQkcDkeOnGP3CAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C60DDA0774; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 15/20] udf: Convert udf_mkdir() to new directory iteration code
Date:   Fri, 16 Dec 2022 16:24:19 +0100
Message-Id: <20221216152656.6236-15-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; i=jack@suse.cz; h=from:subject; bh=mFtp62RBI1MfkCiKoekfPtOGZcfOLwBrMd7CXu70+Rs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2jYDZZiuhEte2zC0zN5c0sahISEGEBLTRprzhL 33xh7/+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNowAKCRCcnaoHP2RA2VahCA CrlYFp01Crxbeokmho9cN489aPmQXna4HUpy6X2I+CgnMXKMynR//mLkjPQ/2yET6FJIT+p0Qi49IZ ktDeQOS98rHvVf8v6PfVBYGiEMCuNoTvZ33VSK4jnTUtmM2rMspTd7XyIhlD/VXx+9HfqYJj8UwhfK wkbqnV5HTWntYsE0ELZJU3MyYGqt0y16C21kHi3yVWlDONHrkjtod/cXzBXYjGsffEKZVMLmxf9Ozd 46nIGLppan0efcwmn6Rx/xErSeuAFHTOl/yiZ6pZRLUJwBXVO12H9biMvqDL6Er4aG1PdJ32kGHdx2 Z67QbB/qYVJiEb4DBI/F/Kgk/Hi/RV
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

Convert udf_mkdir() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 038066caa4f5..6973f9956d32 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -924,8 +924,7 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 	struct udf_inode_info *dinfo = UDF_I(dir);
 	struct udf_inode_info *iinfo;
@@ -937,47 +936,42 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	iinfo = UDF_I(inode);
 	inode->i_op = &udf_dir_inode_operations;
 	inode->i_fop = &udf_dir_operations;
-	fi = udf_add_entry(inode, NULL, &fibh, &cfi, &err);
-	if (!fi) {
-		inode_dec_link_count(inode);
+	err = udf_fiiter_add_entry(inode, NULL, &iter);
+	if (err) {
+		clear_nlink(inode);
 		discard_new_inode(inode);
-		goto out;
+		return err;
 	}
 	set_nlink(inode, 2);
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(dinfo->i_unique & 0x00000000FFFFFFFFUL);
-	cfi.fileCharacteristics =
+	iter.fi.fileCharacteristics =
 			FID_FILE_CHAR_DIRECTORY | FID_FILE_CHAR_PARENT;
-	udf_write_fi(inode, &cfi, fi, &fibh, NULL, NULL);
-	brelse(fibh.sbh);
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 	mark_inode_dirty(inode);
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err) {
 		clear_nlink(inode);
-		mark_inode_dirty(inode);
 		discard_new_inode(inode);
-		goto out;
+		return err;
 	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
-	cfi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
+	iter.fi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 	inc_nlink(dir);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	mark_inode_dirty(dir);
 	d_instantiate_new(dentry, inode);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	err = 0;
 
-out:
-	return err;
+	return 0;
 }
 
 static int empty_dir(struct inode *dir)
-- 
2.35.3

