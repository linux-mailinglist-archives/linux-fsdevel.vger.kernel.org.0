Return-Path: <linux-fsdevel+bounces-8329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4A3832F17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F02B22445
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5163B5645B;
	Fri, 19 Jan 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="To0xez01";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Xdgo0td";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="To0xez01";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1Xdgo0td"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42401E4A4;
	Fri, 19 Jan 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690084; cv=none; b=M2M0jqZ/syjL9AgHcglru9vtVdCG3NZ+z00tzX4eTaX7lDWJJLOKS/4/3tjpbYwoDzFqztVIeyfKBCDeq4L59Bd1nzFvlZvgOdkXYcJ1lePcxtmutLm8tqbRhOwHn5dMSt2jtor0WxBuvCJukrwx69Fryge/iC0w9mUptKVVIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690084; c=relaxed/simple;
	bh=p4sgbbNmh2KyBkIBSob+sE6BhK1rQhiZB0zZmKR8os4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfOLn+Hb2rnn0r9znymdf9PHD3dmitg8L+we5RsLfruVZLCXz2uS0NWl0lqloIPIR/lwfCiunfRQRwth9CK8im4FIKXnPZKmlCryJBKnHf0hzapl/gIRZndlPk34Gk3eGfaEUgBAuUFQc4SHJ5kfyBAu8zozgowWLB7uoJU9g4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=To0xez01; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Xdgo0td; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=To0xez01; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1Xdgo0td; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9757821FB3;
	Fri, 19 Jan 2024 18:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2QPSkguP3TJ/9OXXk7UjvrT0AFnjUupiXPinkoZssY=;
	b=To0xez01WDgTBmneNcvO5ActZju493MB7pilBnLs3etGikCktcPi9OuXFdi4WFaFHxxqDu
	KRNgN6HdBUTgNrAtEfhr3CxjUPwS/1XRf2uJlWoqyEr2neIv3pPeFH0DER8Q6c7JvbcQEb
	zRgxfFMVxvFT3Cq9p8PnWq7ezfgKM0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2QPSkguP3TJ/9OXXk7UjvrT0AFnjUupiXPinkoZssY=;
	b=1Xdgo0tdPOn72qlEjJ/tTeGR/jUkPMnPH9qnPYz4g8pN8GvgbMXHHodGId7mAe6wZbkLSj
	AFo2uPPZSk1JG0CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705690078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2QPSkguP3TJ/9OXXk7UjvrT0AFnjUupiXPinkoZssY=;
	b=To0xez01WDgTBmneNcvO5ActZju493MB7pilBnLs3etGikCktcPi9OuXFdi4WFaFHxxqDu
	KRNgN6HdBUTgNrAtEfhr3CxjUPwS/1XRf2uJlWoqyEr2neIv3pPeFH0DER8Q6c7JvbcQEb
	zRgxfFMVxvFT3Cq9p8PnWq7ezfgKM0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705690078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2QPSkguP3TJ/9OXXk7UjvrT0AFnjUupiXPinkoZssY=;
	b=1Xdgo0tdPOn72qlEjJ/tTeGR/jUkPMnPH9qnPYz4g8pN8GvgbMXHHodGId7mAe6wZbkLSj
	AFo2uPPZSk1JG0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFAE0136F5;
	Fri, 19 Jan 2024 18:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BjUDKt3DqmVADAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 18:47:57 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v3 02/10] fscrypt: Share code between functions that prepare lookup
Date: Fri, 19 Jan 2024 15:47:34 -0300
Message-ID: <20240119184742.31088-3-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119184742.31088-1-krisman@suse.de>
References: <20240119184742.31088-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Right now, we have two functions that can be called by the filesystem
during lookup to set up fscrypt internal state for the dentry and
inode under lookup:

  1) fscrypt_prepare_lookup_dentry_partial: used only by ceph. It sets
  encryption information in the inode and sets the dentry flag if the
  key is not available.

  2) fscrypt_prepare_lookup: used by everything else. Does all the
  above, plus also sets struct fname.

This patch refactors the code to implement the later using the former.
This way, we'll have a single place where we set DCACHE_NOKEY_NAME, in
preparation to add more churn to that condition in the following patch.

To make the patch simpler, we now call fscrypt_get_encryption_info twice
for fscrypt_prepare_lookup, once inside fscrypt_setup_filename and once
inside fscrypt_prepare_lookup_dentry.  It seems safe to do, and
considering it will bail early in the second lookup and most lookups
should go to the dcache anyway, it doesn't seem problematic for
performance.  In addition, we add a function call for the unencrypted
case, also during lookup.

Apart from the above, it should have no behavior change.

I tested ext4/f2fs manually and with fstests, which yielded no regressions.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/ceph/dir.c           |  2 +-
 fs/ceph/file.c          |  2 +-
 fs/crypto/hooks.c       | 53 ++++++++++++++++++-----------------------
 include/linux/fscrypt.h | 40 +++++++++++++++++--------------
 4 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 91709934c8b1..835421e2845d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -813,7 +813,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	if (IS_ENCRYPTED(dir)) {
 		bool had_key = fscrypt_has_encryption_key(dir);
 
-		err = fscrypt_prepare_lookup_partial(dir, dentry);
+		err = fscrypt_prepare_lookup_dentry(dir, dentry);
 		if (err < 0)
 			return ERR_PTR(err);
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3b5aae29e944..5c9206670533 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -812,7 +812,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	ihold(dir);
 	if (IS_ENCRYPTED(dir)) {
 		set_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags);
-		err = fscrypt_prepare_lookup_partial(dir, dentry);
+		err = fscrypt_prepare_lookup_dentry(dir, dentry);
 		if (err < 0)
 			goto out_req;
 	}
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 52504dd478d3..41df986d1230 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -94,52 +94,45 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_rename);
 
-int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
-			     struct fscrypt_name *fname)
-{
-	int err = fscrypt_setup_filename(dir, &dentry->d_name, 1, fname);
-
-	if (err && err != -ENOENT)
-		return err;
-
-	if (fname->is_nokey_name) {
-		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_NOKEY_NAME;
-		spin_unlock(&dentry->d_lock);
-	}
-	return err;
-}
-EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
-
 /**
- * fscrypt_prepare_lookup_partial() - prepare lookup without filename setup
+ * fscrypt_prepare_lookup_dentry() - prepare lookup without filename setup
  * @dir: the encrypted directory being searched
  * @dentry: the dentry being looked up in @dir
  *
- * This function should be used by the ->lookup and ->atomic_open methods of
- * filesystems that handle filename encryption and no-key name encoding
- * themselves and thus can't use fscrypt_prepare_lookup().  Like
- * fscrypt_prepare_lookup(), this will try to set up the directory's encryption
- * key and will set DCACHE_NOKEY_NAME on the dentry if the key is unavailable.
- * However, this function doesn't set up a struct fscrypt_name for the filename.
+ * This function should be used by the ->lookup and ->atomic_open
+ * methods of filesystems that handle filename encryption and no-key
+ * name encoding themselves and thus can't use fscrypt_prepare_lookup()
+ * directly.  This will try to set up the directory's encryption key and
+ * will set DCACHE_NOKEY_NAME on the dentry if the key is unavailable.
+ * However, this function doesn't set up a struct fscrypt_name for the
+ * filename.
  *
  * Return: 0 on success; -errno on error.  Note that the encryption key being
  *	   unavailable is not considered an error.  It is also not an error if
  *	   the encryption policy is unsupported by this kernel; that is treated
  *	   like the key being unavailable, so that files can still be deleted.
  */
-int fscrypt_prepare_lookup_partial(struct inode *dir, struct dentry *dentry)
+int fscrypt_prepare_lookup_dentry(struct inode *dir,
+				  struct dentry *dentry)
 {
-	int err = fscrypt_get_encryption_info(dir, true);
+	bool nokey_name = false;
+	int err = 0;
 
-	if (!err && !fscrypt_has_encryption_key(dir)) {
-		spin_lock(&dentry->d_lock);
+	if (IS_ENCRYPTED(dir)) {
+		err = fscrypt_get_encryption_info(dir, true);
+		if (!err && !fscrypt_has_encryption_key(dir))
+			nokey_name = true;
+	}
+
+	spin_lock(&dentry->d_lock);
+	if (nokey_name) {
 		dentry->d_flags |= DCACHE_NOKEY_NAME;
-		spin_unlock(&dentry->d_lock);
 	}
+	spin_unlock(&dentry->d_lock);
+
 	return err;
 }
-EXPORT_SYMBOL_GPL(fscrypt_prepare_lookup_partial);
+EXPORT_SYMBOL_GPL(fscrypt_prepare_lookup_dentry);
 
 int __fscrypt_prepare_readdir(struct inode *dir)
 {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 12f9e455d569..3801c5c94fb6 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -382,9 +382,7 @@ int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 			     struct inode *new_dir, struct dentry *new_dentry,
 			     unsigned int flags);
-int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
-			     struct fscrypt_name *fname);
-int fscrypt_prepare_lookup_partial(struct inode *dir, struct dentry *dentry);
+int fscrypt_prepare_lookup_dentry(struct inode *dir, struct dentry *dentry);
 int __fscrypt_prepare_readdir(struct inode *dir);
 int __fscrypt_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 int fscrypt_prepare_setflags(struct inode *inode,
@@ -704,14 +702,7 @@ static inline int __fscrypt_prepare_rename(struct inode *old_dir,
 	return -EOPNOTSUPP;
 }
 
-static inline int __fscrypt_prepare_lookup(struct inode *dir,
-					   struct dentry *dentry,
-					   struct fscrypt_name *fname)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int fscrypt_prepare_lookup_partial(struct inode *dir,
+static inline int fscrypt_prepare_lookup_dentry(struct inode *dir,
 						 struct dentry *dentry)
 {
 	return -EOPNOTSUPP;
@@ -975,14 +966,27 @@ static inline int fscrypt_prepare_lookup(struct inode *dir,
 					 struct dentry *dentry,
 					 struct fscrypt_name *fname)
 {
-	if (IS_ENCRYPTED(dir))
-		return __fscrypt_prepare_lookup(dir, dentry, fname);
+	int ret, err = 0;
+
+	if (IS_ENCRYPTED(dir)) {
+		err = fscrypt_setup_filename(dir, &dentry->d_name, 1, fname);
+		if (err && err != -ENOENT)
+			return err;
+	} else {
+		memset(fname, 0, sizeof(*fname));
+		fname->usr_fname = &dentry->d_name;
+		fname->disk_name.name = (unsigned char *)dentry->d_name.name;
+		fname->disk_name.len = dentry->d_name.len;
+	}
 
-	memset(fname, 0, sizeof(*fname));
-	fname->usr_fname = &dentry->d_name;
-	fname->disk_name.name = (unsigned char *)dentry->d_name.name;
-	fname->disk_name.len = dentry->d_name.len;
-	return 0;
+	/*
+	 * fscrypt_prepare_lookup_dentry will succeed even if the
+	 * directory key is unavailable but the filename isn't a valid
+	 * no-key name (-ENOENT). Thus, propagate the previous
+	 * error, if any.
+	 */
+	ret = fscrypt_prepare_lookup_dentry(dir, dentry);
+	return err ? err : ret;
 }
 
 /**
-- 
2.43.0


