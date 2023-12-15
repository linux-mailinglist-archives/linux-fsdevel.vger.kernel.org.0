Return-Path: <linux-fsdevel+bounces-6237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4A8151D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B342286F65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A24B15F;
	Fri, 15 Dec 2023 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YYl9BpAw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+pnCH31v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YYl9BpAw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+pnCH31v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB24AF8C;
	Fri, 15 Dec 2023 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D07CF22031;
	Fri, 15 Dec 2023 21:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKukKkTTBPbOQf8nO7GMzkTpBiJ/Q2Wc38Wb/akI5Dc=;
	b=YYl9BpAwPQ7tXCEEsnUiYDP7sa+TMbl+2NQBLH28B5cWRXwa0QUGtWTwlXnlRZ/3cFJMu/
	vxK5JI6n/1qUbMDEjkJ0vv534IMCVeJCkQ4A3175nj6t58SGkJ7K29dh6FBwucV29OR4Dm
	F8lw/ApWzFZk/Pc7wAzgdtCiaHBlmrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKukKkTTBPbOQf8nO7GMzkTpBiJ/Q2Wc38Wb/akI5Dc=;
	b=+pnCH31vV7628YdaMFTbm/bI3p61wNSVfFG0udp0AudaZA6wCFh96hm8FqelTBv0ahH/rB
	s2dGb/682mGyIMBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702674993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKukKkTTBPbOQf8nO7GMzkTpBiJ/Q2Wc38Wb/akI5Dc=;
	b=YYl9BpAwPQ7tXCEEsnUiYDP7sa+TMbl+2NQBLH28B5cWRXwa0QUGtWTwlXnlRZ/3cFJMu/
	vxK5JI6n/1qUbMDEjkJ0vv534IMCVeJCkQ4A3175nj6t58SGkJ7K29dh6FBwucV29OR4Dm
	F8lw/ApWzFZk/Pc7wAzgdtCiaHBlmrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702674993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKukKkTTBPbOQf8nO7GMzkTpBiJ/Q2Wc38Wb/akI5Dc=;
	b=+pnCH31vV7628YdaMFTbm/bI3p61wNSVfFG0udp0AudaZA6wCFh96hm8FqelTBv0ahH/rB
	s2dGb/682mGyIMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D9EA137D4;
	Fri, 15 Dec 2023 21:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gINRGzHCfGWkOQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 15 Dec 2023 21:16:33 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v2 8/8] fscrypt: Move d_revalidate configuration back into fscrypt
Date: Fri, 15 Dec 2023 16:16:08 -0500
Message-ID: <20231215211608.6449-9-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215211608.6449-1-krisman@suse.de>
References: <20231215211608.6449-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

This partially reverts commit bb9cd9106b22 ("fscrypt: Have filesystems
handle their d_ops"), which moved this handler out of fscrypt and into
the filesystems, in preparation to support casefold and fscrypt
combinations.  Now that we set casefolding operations through
->s_d_op, move this back into fscrypt, where it belongs, but take care
to handle filesystems that set their own sb->s_d_op.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
changes since v1:
  - Fix unused definition warning (lkp)
---
 fs/crypto/hooks.c       |  8 ++++++++
 fs/ext4/namei.c         |  5 -----
 fs/f2fs/namei.c         |  5 -----
 fs/libfs.c              | 25 -------------------------
 fs/ubifs/dir.c          |  1 -
 include/linux/fs.h      |  1 -
 include/linux/fscrypt.h | 10 +++++-----
 7 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 52504dd478d3..166837d5af29 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -94,6 +94,10 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_rename);
 
+static const struct dentry_operations fscrypt_dentry_ops = {
+	.d_revalidate = fscrypt_d_revalidate,
+};
+
 int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 			     struct fscrypt_name *fname)
 {
@@ -106,6 +110,10 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_NOKEY_NAME;
 		spin_unlock(&dentry->d_lock);
+
+		/* Give preference to the filesystem hooks, if any. */
+		if (!dentry->d_op)
+			d_set_d_op(dentry, &fscrypt_dentry_ops);
 	}
 	return err;
 }
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 463e73fb5bf0..3f0b853a371e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1762,11 +1762,6 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	struct buffer_head *bh;
 
 	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
-
-	/* Case-insensitive volumes set dentry ops through sb->s_d_op. */
-	if (!dir->i_sb->s_d_op)
-		generic_set_encrypted_ci_d_ops(dentry);
-
 	if (err == -ENOENT)
 		return NULL;
 	if (err)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6aec21f0b5d6..b40c6c393bd6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -532,11 +532,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	err = f2fs_prepare_lookup(dir, dentry, &fname);
-
-	/* Case-insensitive volumes set dentry ops through sb->s_d_op. */
-	if (!dir->i_sb->s_d_op)
-		generic_set_encrypted_ci_d_ops(dentry);
-
 	if (err == -ENOENT)
 		goto out_splice;
 	if (err)
diff --git a/fs/libfs.c b/fs/libfs.c
index 41c02c003265..a04d6c1ad77a 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1774,31 +1774,6 @@ const struct dentry_operations generic_ci_dentry_ops = {
 };
 #endif
 
-#ifdef CONFIG_FS_ENCRYPTION
-static const struct dentry_operations generic_encrypted_dentry_ops = {
-	.d_revalidate = fscrypt_d_revalidate,
-};
-#endif
-
-/**
- * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
- * @dentry:	dentry to set ops on
- *
- * Encryption works differently in that the only dentry operation it needs is
- * d_revalidate, which it only needs on dentries that have the no-key name flag.
- * The no-key flag can't be set "later", so we don't have to worry about that.
- */
-void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
-{
-#ifdef CONFIG_FS_ENCRYPTION
-	if (dentry->d_flags & DCACHE_NOKEY_NAME) {
-		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
-		return;
-	}
-#endif
-}
-EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
-
 /**
  * inode_maybe_inc_iversion - increments i_version
  * @inode: inode with the i_version that should be updated
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 3b13c648d490..51b9a10a9851 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -205,7 +205,6 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	dbg_gen("'%pd' in dir ino %lu", dentry, dir->i_ino);
 
 	err = fscrypt_prepare_lookup(dir, dentry, &nm);
-	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		return d_splice_alias(NULL, dentry);
 	if (err)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 887a27d07f96..e5ae21f9f637 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3201,7 +3201,6 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
-extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 extern const struct dentry_operations generic_ci_dentry_ops;
 
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 12f9e455d569..97a11280c2bd 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -961,11 +961,11 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
  * key is available, then the lookup is assumed to be by plaintext name;
  * otherwise, it is assumed to be by no-key name.
  *
- * This will set DCACHE_NOKEY_NAME on the dentry if the lookup is by no-key
- * name.  In this case the filesystem must assign the dentry a dentry_operations
- * which contains fscrypt_d_revalidate (or contains a d_revalidate method that
- * calls fscrypt_d_revalidate), so that the dentry will be invalidated if the
- * directory's encryption key is later added.
+ * This also optionally installs a custom ->d_revalidate() method which will
+ * invalidate the dentry if it was created without the key and the key is later
+ * added.  If the filesystem provides its own ->d_op hooks, they will be used
+ * instead, but then the filesystem must make sure to call fscrypt_d_revalidate
+ * in its d_revalidate hook, to check if fscrypt considers the dentry stale.
  *
  * Return: 0 on success; -ENOENT if the directory's key is unavailable but the
  * filename isn't a valid no-key name, so a negative dentry should be created;
-- 
2.43.0


