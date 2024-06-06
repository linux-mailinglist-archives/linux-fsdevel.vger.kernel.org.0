Return-Path: <linux-fsdevel+bounces-21095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218068FDFE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 09:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977BF1F23797
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66A413F00C;
	Thu,  6 Jun 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gtn1sEAP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614713B28F;
	Thu,  6 Jun 2024 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659285; cv=none; b=ZenCSMbfLia9FGH1q4X4xjkmIRgrnA1028QOEFyaLEBiKbbSM7lKaOpW8L06fhOWAbRo44sajthbl6DA8Z/CUtL7ixP51XdIApCG154pQ2VqWJZM2qx5GY/+3gERhLn6+9/yi6Sh4Sz5SZO9kwIa/YQRE7N7EWM8htCZNK8H2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659285; c=relaxed/simple;
	bh=7MXCNIfbhOHe7WuXF+nvpbNl5SCDeGsd3fUVla5hgUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXGqrIEougrnTREcHBHB8MLFZS8Cj6xO/2aSplOl9j0ehlWSPORj29BWBzK/90pxH5itTwVQ4VMbW4VDjHs94Fx2Lhnqts6+fLMDcJrzT12k5//LsK3zTisK/ygnPd7toS4gOuNaOQpw5yZkoM7eHIsiYVujIrosULx9A3Z2pC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gtn1sEAP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717659282;
	bh=7MXCNIfbhOHe7WuXF+nvpbNl5SCDeGsd3fUVla5hgUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtn1sEAP3bzQJnQTgYb0KBb7QkSr+LCpLQmBzfIpQHK4kAjEaJxWQBrnBh/C4sf0y
	 gVXeny5hAk9eP9hNFyVEEeQvuTOpCUMQmFIIi5uy53g/Va1Yz0QeAdlbPsO3R78exP
	 +lguXn5UAFwKhZJROLWpq6uE7Ik7vMjw/l0SvFmb4y/6pQWA5H6/JOswlyr9fR1i+D
	 pZwM2BfC1/Imdieb3Yc5wjPXo4O8lTaKlb2ifkJ/t3gw3LPhRROydVx7w2keV1A9nm
	 7PtZKeellt3vLuMKXDfjiQ/BgriFbPIKft9+ebmFvNK1Rii0uG/SaBV0yCc3Ql5Ww8
	 5Gw0OI/Wi0frQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0690037821DD;
	Thu,  6 Jun 2024 07:34:40 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	adilger.kernel@dilger.ca,
	tytso@mit.edu
Cc: chao@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ebiggers@google.com,
	krisman@suse.de,
	kernel@collabora.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v18 6/7] ext4: Move CONFIG_UNICODE defguards into the code flow
Date: Thu,  6 Jun 2024 10:33:52 +0300
Message-Id: <20240606073353.47130-7-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606073353.47130-1-eugen.hristev@collabora.com>
References: <20240606073353.47130-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Instead of a bunch of ifdefs, make the unicode built checks part of the
code flow where possible, as requested by Torvalds.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: port to 6.10-rc1]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/crypto.c | 10 ++--------
 fs/ext4/ext4.h   | 33 +++++++++++++++++++++------------
 fs/ext4/namei.c  | 14 +++++---------
 fs/ext4/super.c  |  4 +---
 4 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 7ae0b61258a7..0a056d97e640 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -31,11 +31,10 @@ int ext4_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 	if (err)
 		ext4_fname_free_filename(fname);
-#endif
+
 	return err;
 }
 
@@ -51,11 +50,9 @@ int ext4_fname_prepare_lookup(struct inode *dir, struct dentry *dentry,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
 	if (err)
 		ext4_fname_free_filename(fname);
-#endif
 	return err;
 }
 
@@ -70,10 +67,7 @@ void ext4_fname_free_filename(struct ext4_filename *fname)
 	fname->usr_fname = NULL;
 	fname->disk_name.name = NULL;
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	kfree(fname->cf_name.name);
-	fname->cf_name.name = NULL;
-#endif
+	ext4_fname_free_ci_filename(fname);
 }
 
 static bool uuid_is_zero(__u8 u[16])
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index deffd7431c8b..8007abd4972d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2745,8 +2745,25 @@ ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
 #if IS_ENABLED(CONFIG_UNICODE)
 extern int ext4_fname_setup_ci_filename(struct inode *dir,
-					 const struct qstr *iname,
-					 struct ext4_filename *fname);
+					const struct qstr *iname,
+					struct ext4_filename *fname);
+
+static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
+{
+	kfree(fname->cf_name.name);
+	fname->cf_name.name = NULL;
+}
+#else
+static inline int ext4_fname_setup_ci_filename(struct inode *dir,
+					       const struct qstr *iname,
+					       struct ext4_filename *fname)
+{
+	return 0;
+}
+
+static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
+{
+}
 #endif
 
 /* ext4 encryption related stuff goes here crypto.c */
@@ -2769,16 +2786,11 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 					    int lookup,
 					    struct ext4_filename *fname)
 {
-	int err = 0;
 	fname->usr_fname = iname;
 	fname->disk_name.name = (unsigned char *) iname->name;
 	fname->disk_name.len = iname->len;
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	err = ext4_fname_setup_ci_filename(dir, iname, fname);
-#endif
-
-	return err;
+	return ext4_fname_setup_ci_filename(dir, iname, fname);
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
@@ -2790,10 +2802,7 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 
 static inline void ext4_fname_free_filename(struct ext4_filename *fname)
 {
-#if IS_ENABLED(CONFIG_UNICODE)
-	kfree(fname->cf_name.name);
-	fname->cf_name.name = NULL;
-#endif
+	ext4_fname_free_ci_filename(fname);
 }
 
 static inline int ext4_ioctl_get_encryption_pwsalt(struct file *filp,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d10ea0f3f64d..e6769b97a970 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1825,8 +1825,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		}
 	}
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
+	if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
 		 * well.  For now, prevent the negative dentry
@@ -1834,7 +1833,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		 */
 		return NULL;
 	}
-#endif
+
 	return d_splice_alias(inode, dentry);
 }
 
@@ -3164,16 +3163,14 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	ext4_fc_track_unlink(handle, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at ext4_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
 
 end_rmdir:
 	brelse(bh);
@@ -3275,16 +3272,15 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		goto out_trace;
 
 	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry), dentry);
-#if IS_ENABLED(CONFIG_UNICODE)
+
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at ext4_lookup(), when it is  better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
 
 out_trace:
 	trace_ext4_unlink_exit(dentry, retval);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c682fb927b64..d2d2254a9ded 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3586,14 +3586,12 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 		return 0;
 	}
 
-#if !IS_ENABLED(CONFIG_UNICODE)
-	if (ext4_has_feature_casefold(sb)) {
+	if (!IS_ENABLED(CONFIG_UNICODE) && ext4_has_feature_casefold(sb)) {
 		ext4_msg(sb, KERN_ERR,
 			 "Filesystem with casefold feature cannot be "
 			 "mounted without CONFIG_UNICODE");
 		return 0;
 	}
-#endif
 
 	if (readonly)
 		return 1;
-- 
2.34.1


