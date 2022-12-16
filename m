Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C17A64EDEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiLPP1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiLPP1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F062EA0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 731E95D11E;
        Fri, 16 Dec 2022 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZa3zaPgcj+Xhi/UnZC8CnueYrlqFAzZ7u6nPo/CcUM=;
        b=jkRPS0Jo5BmcrwfHA71ITM95ARRW2guBmfjpN46znLpi8IXBRrAWKX9X4vtNxK98VeFqwM
        d5mYSZ2EqHUjILbaTKYZBDyx0n3zCA53+xPHOFy/O1slyMLVnZ+ZPho+9y70A6K0y+NS1s
        YpKksc+/PbMaBc23SDAreHdaCLg/NEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZa3zaPgcj+Xhi/UnZC8CnueYrlqFAzZ7u6nPo/CcUM=;
        b=Tn6cN1m9HQpJrz6t5Iu9dyQOqBLDfpdtpjLvQ9ei4FHrnvbPzMVhkR0CeQ8Me7zHHxeXTU
        rDVOzrcr6qFEG/AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D05D13909;
        Fri, 16 Dec 2022 15:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AdvMEkeOnGP6CAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D2C8BA0776; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+0eaad3590d65102b9391@syzkaller.appspotmail.com,
        syzbot+b7fc73213bc2361ab650@syzkaller.appspotmail.com
Subject: [PATCH 17/20] udf: Convert udf_rename() to new directory iteration code
Date:   Fri, 16 Dec 2022 16:24:21 +0100
Message-Id: <20221216152656.6236-17-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6961; i=jack@suse.cz; h=from:subject; bh=UJI/WKHac1Hq1Eg4LMyFk/YdsZEgXD8AWYevznWlOXE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2kxBS7ot0Ci6kuZ3Z26Hnfr+hRtK18JG1OIVR/ tsuJw6OJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNpAAKCRCcnaoHP2RA2QSDB/ 9R9wfZNovN5PK88WI3x2cdNoYdcVI+PwGh6oI2hHNPJw3YLdiNbbzgk0NxuP9QurFdzP4f4PwbA384 CdoiLB2ant7xnRLAiEL++cGbDTxergMc7GQdc/+0VVelrXzmi4ha5JMF0bK6c+k7Y63eQrKJMBlDem HVFRhZZlebc+yShei9DQgcwI4Hqw48smW3sQCWtW2hMjLwbxf9ycJkB3sYfxpa6LrEUifF0BvF28NH vzkCovoz0AzL9r0M0EZ1OC4/gSjosk8avSsW6DP3xdZhNBnT6m6CY2PH2/5n5d6+7rjtAaiiCgcDTs BYogLKAsF2H8DGAC/H1v08mvhgELWh
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

Convert udf_rename() to use new directory iteration code.

Reported-by: syzbot+0eaad3590d65102b9391@syzkaller.appspotmail.com
Reported-by: syzbot+b7fc73213bc2361ab650@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 165 +++++++++++++++++++++++--------------------------
 1 file changed, 78 insertions(+), 87 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7871f7763a9b..81a7197c2109 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1253,78 +1253,68 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
-	struct udf_fileident_bh ofibh, nfibh;
-	struct fileIdentDesc *ofi = NULL, *nfi = NULL, *dir_fi = NULL;
-	struct fileIdentDesc ocfi, ncfi;
-	struct buffer_head *dir_bh = NULL;
-	int retval = -ENOENT;
+	struct udf_fileident_iter oiter, niter, diriter;
+	bool has_diriter = false;
+	int retval;
 	struct kernel_lb_addr tloc;
-	struct udf_inode_info *old_iinfo = UDF_I(old_inode);
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
-	if (!ofi || IS_ERR(ofi)) {
-		if (IS_ERR(ofi))
-			retval = PTR_ERR(ofi);
-		goto end_rename;
-	}
-
-	if (ofibh.sbh != ofibh.ebh)
-		brelse(ofibh.ebh);
-
-	brelse(ofibh.sbh);
-	tloc = lelb_to_cpu(ocfi.icb.extLocation);
-	if (udf_get_lb_pblock(old_dir->i_sb, &tloc, 0) != old_inode->i_ino)
-		goto end_rename;
+	retval = udf_fiiter_find_entry(old_dir, &old_dentry->d_name, &oiter);
+	if (retval)
+		return retval;
 
-	nfi = udf_find_entry(new_dir, &new_dentry->d_name, &nfibh, &ncfi);
-	if (IS_ERR(nfi)) {
-		retval = PTR_ERR(nfi);
-		goto end_rename;
+	tloc = lelb_to_cpu(oiter.fi.icb.extLocation);
+	if (udf_get_lb_pblock(old_dir->i_sb, &tloc, 0) != old_inode->i_ino) {
+ 		retval = -ENOENT;
+		goto out_oiter;
 	}
-	if (nfi && !new_inode) {
-		if (nfibh.sbh != nfibh.ebh)
-			brelse(nfibh.ebh);
-		brelse(nfibh.sbh);
-		nfi = NULL;
-	}
-	if (S_ISDIR(old_inode->i_mode)) {
-		int offset = udf_ext0_offset(old_inode);
 
+	if (S_ISDIR(old_inode->i_mode)) {
 		if (new_inode) {
 			retval = -ENOTEMPTY;
 			if (!empty_dir(new_inode))
-				goto end_rename;
+				goto out_oiter;
 		}
-		retval = -EIO;
-		if (old_iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-			dir_fi = udf_get_fileident(
-					old_iinfo->i_data -
-					  (old_iinfo->i_efe ?
-					   sizeof(struct extendedFileEntry) :
-					   sizeof(struct fileEntry)),
-					old_inode->i_sb->s_blocksize, &offset);
-		} else {
-			dir_bh = udf_bread(old_inode, 0, 0, &retval);
-			if (!dir_bh)
-				goto end_rename;
-			dir_fi = udf_get_fileident(dir_bh->b_data,
-					old_inode->i_sb->s_blocksize, &offset);
+		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
+					       &diriter);
+		if (retval == -ENOENT) {
+			udf_err(old_inode->i_sb,
+				"directory (ino %lu) has no '..' entry\n",
+				old_inode->i_ino);
+			retval = -EFSCORRUPTED;
 		}
-		if (!dir_fi)
-			goto end_rename;
-		tloc = lelb_to_cpu(dir_fi->icb.extLocation);
+		if (retval)
+			goto out_oiter;
+		has_diriter = true;
+		tloc = lelb_to_cpu(diriter.fi.icb.extLocation);
 		if (udf_get_lb_pblock(old_inode->i_sb, &tloc, 0) !=
-				old_dir->i_ino)
-			goto end_rename;
+				old_dir->i_ino) {
+			retval = -EFSCORRUPTED;
+			udf_err(old_inode->i_sb,
+				"directory (ino %lu) has parent entry pointing to another inode (%lu != %u)\n",
+				old_inode->i_ino, old_dir->i_ino,
+				udf_get_lb_pblock(old_inode->i_sb, &tloc, 0));
+			goto out_oiter;
+		}
 	}
-	if (!nfi) {
-		nfi = udf_add_entry(new_dir, new_dentry, &nfibh, &ncfi,
-				    &retval);
-		if (!nfi)
-			goto end_rename;
+
+	retval = udf_fiiter_find_entry(new_dir, &new_dentry->d_name, &niter);
+	if (retval && retval != -ENOENT)
+		goto out_oiter;
+	/* Entry found but not passed by VFS? */
+	if (WARN_ON_ONCE(!retval && !new_inode)) {
+		retval = -EFSCORRUPTED;
+		udf_fiiter_release(&niter);
+		goto out_oiter;
+	}
+	/* Entry not found? Need to add one... */
+	if (retval) {
+		udf_fiiter_release(&niter);
+		retval = udf_fiiter_add_entry(new_dir, new_dentry, &niter);
+		if (retval)
+			goto out_oiter;
 	}
 
 	/*
@@ -1337,14 +1327,26 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	/*
 	 * ok, that's it
 	 */
-	ncfi.fileVersionNum = ocfi.fileVersionNum;
-	ncfi.fileCharacteristics = ocfi.fileCharacteristics;
-	memcpy(&(ncfi.icb), &(ocfi.icb), sizeof(ocfi.icb));
-	udf_write_fi(new_dir, &ncfi, nfi, &nfibh, NULL, NULL);
+	niter.fi.fileVersionNum = oiter.fi.fileVersionNum;
+	niter.fi.fileCharacteristics = oiter.fi.fileCharacteristics;
+	memcpy(&(niter.fi.icb), &(oiter.fi.icb), sizeof(oiter.fi.icb));
+	udf_fiiter_write_fi(&niter, NULL);
+	udf_fiiter_release(&niter);
 
-	/* The old fid may have moved - find it again */
-	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
-	udf_delete_entry(old_dir, ofi, &ofibh, &ocfi);
+	/*
+	 * The old entry may have moved due to new entry allocation. Find it
+ 	 * again.
+	 */
+	udf_fiiter_release(&oiter);
+	retval = udf_fiiter_find_entry(old_dir, &old_dentry->d_name, &oiter);
+	if (retval) {
+		udf_err(old_dir->i_sb,
+			"failed to find renamed entry again in directory (ino %lu)\n",
+			old_dir->i_ino);
+	} else {
+		udf_fiiter_delete_entry(&oiter);
+		udf_fiiter_release(&oiter);
+	}
 
 	if (new_inode) {
 		new_inode->i_ctime = current_time(new_inode);
@@ -1355,13 +1357,13 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	mark_inode_dirty(old_dir);
 	mark_inode_dirty(new_dir);
 
-	if (dir_fi) {
-		dir_fi->icb.extLocation = cpu_to_lelb(UDF_I(new_dir)->i_location);
-		udf_update_tag((char *)dir_fi, udf_dir_entry_len(dir_fi));
-		if (old_iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-			mark_inode_dirty(old_inode);
-		else
-			mark_buffer_dirty_inode(dir_bh, old_inode);
+	if (has_diriter) {
+		diriter.fi.icb.extLocation =
+					cpu_to_lelb(UDF_I(new_dir)->i_location);
+		udf_update_tag((char *)&diriter.fi,
+			       udf_dir_entry_len(&diriter.fi));
+		udf_fiiter_write_fi(&diriter, NULL);
+		udf_fiiter_release(&diriter);
 
 		inode_dec_link_count(old_dir);
 		if (new_inode)
@@ -1371,22 +1373,11 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			mark_inode_dirty(new_dir);
 		}
 	}
-
-	if (ofi) {
-		if (ofibh.sbh != ofibh.ebh)
-			brelse(ofibh.ebh);
-		brelse(ofibh.sbh);
-	}
-
-	retval = 0;
-
-end_rename:
-	brelse(dir_bh);
-	if (nfi) {
-		if (nfibh.sbh != nfibh.ebh)
-			brelse(nfibh.ebh);
-		brelse(nfibh.sbh);
-	}
+	return 0;
+out_oiter:
+	if (has_diriter)
+		udf_fiiter_release(&diriter);
+	udf_fiiter_release(&oiter);
 
 	return retval;
 }
-- 
2.35.3

