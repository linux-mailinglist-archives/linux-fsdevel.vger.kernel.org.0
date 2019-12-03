Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69A510F6AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfLCFLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:11:22 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53889 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfLCFLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:11:21 -0500
Received: by mail-pg1-f201.google.com with SMTP id u11so1070370pgm.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 21:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X28bmit6Be5wFiUFdwriYdO4L8/Cn/Z12Z6gifJOjMo=;
        b=GeQWV+Hew/MeVg47Uuz8+iKIcCNgCTGqrULNjSd2AOgRyQdM21/0tJjtCou0yKGVnk
         VdNMfs4hIpZggMPbQmkwXYt7o52uE2kG6iyZK+beerTnQuywpiFFaBX7VsPFkjs4krus
         WOa0Bf54YOjdZFMJNg4LYBzCzBa5O79c1ni892XDm+iQP/Jc/SNJzZDRQzV1cO+t4xP2
         qgHtRbdkJuBDtL9489Wy//Z0yO18nFo2ztPmg7fAdq5zkm4brRLHitdjJPbFEzFuEBMS
         aBrY8+h1A+VjMRK4TaLOxHFJ1EVlxFF2WZ0aLY40wj7/CDF3S8x6mxFPHjrxfZJ7g1Ka
         vPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X28bmit6Be5wFiUFdwriYdO4L8/Cn/Z12Z6gifJOjMo=;
        b=qmzJqWlPpjspPXk79DPcfA4PYfbxKm3549mhMiLLNFBtKiRCkKcvBEV+67KwY0+tEu
         Or4QSce+1kcQAv0cAnaiAWLnDRbrzp7Ins0CNSBRavWZlH+gG6sp3AGexR1XlppMt0Sw
         OsJ1QERltLFWMTtOiU1oXt8pWu5H03To0lg8slvUrPHsSwNF+xU9Ws71qX+mgxcd4iTc
         YpsYuV5I5wvxYU3kyCerirXmJSMllz3TbyKY8QhAzUylxP4VqVkierr6lWevk4OoxjA2
         fPaUGimsQnPQdeJ4ojcPuEJWyHYOfoG1YvosXN/4vzyABH4e5HYp/+jwgcShK1V5ZZoo
         1knQ==
X-Gm-Message-State: APjAAAXzD8RfmfHMV6LXc/hkl+pP3pgbvrZu0WSK8lbcQ7spa2H2C/Xe
        47b7nZW82G7ZxBpQeaYVzJTwrcoW0Js=
X-Google-Smtp-Source: APXvYqz49G120pKr37YRflHcPM7os/XBxfAQfpuY8yX9OSMFUZRcod/ZVumGfhaJZhB2fZ7weRrm88eVT2c=
X-Received: by 2002:a63:d153:: with SMTP id c19mr3375088pgj.78.1575349880315;
 Mon, 02 Dec 2019 21:11:20 -0800 (PST)
Date:   Mon,  2 Dec 2019 21:10:42 -0800
In-Reply-To: <20191203051049.44573-1-drosen@google.com>
Message-Id: <20191203051049.44573-2-drosen@google.com>
Mime-Version: 1.0
References: <20191203051049.44573-1-drosen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 1/8] fscrypt: Add siphash and hash key for policy v2
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When using casefolding along with encryption, we need to use a
cryptographic hash to allow fast filesystem operations while not knowing
the case of the name stored on disk while not revealing extra
information about the name if the key is not present.

When a v2 policy is used on a directory, we derive a key for use with
siphash.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/crypto/fname.c           | 22 ++++++++++++++++++++++
 fs/crypto/fscrypt_private.h |  9 +++++++++
 fs/crypto/keysetup.c        | 29 ++++++++++++++++++++---------
 include/linux/fscrypt.h     |  8 ++++++++
 4 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 3da3707c10e3..b33f03b9f892 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/scatterlist.h>
+#include <linux/siphash.h>
 #include <crypto/skcipher.h>
 #include "fscrypt_private.h"
 
@@ -400,3 +401,24 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	return ret;
 }
 EXPORT_SYMBOL(fscrypt_setup_filename);
+
+/**
+ * fscrypt_fname_siphash() - Calculate the siphash for a file name
+ * @dir: the parent directory
+ * @name: the name of the file to get the siphash of
+ *
+ * Given a user-provided filename @name, this function calculates the siphash of
+ * that name using the hash key stored with the directory's policy.
+ *
+ *
+ * Return: the siphash of @name using the hash key of @dir
+ */
+u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
+{
+	struct fscrypt_info *ci = dir->i_crypt_info;
+
+	WARN_ON(!ci || !ci->ci_hash_key_initialized);
+
+	return siphash(name->name, name->len, &ci->ci_hash_key);
+}
+EXPORT_SYMBOL(fscrypt_fname_siphash);
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 130b50e5a011..f0dfef9921de 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -12,6 +12,7 @@
 #define _FSCRYPT_PRIVATE_H
 
 #include <linux/fscrypt.h>
+#include <linux/siphash.h>
 #include <crypto/hash.h>
 
 #define CONST_STRLEN(str)	(sizeof(str) - 1)
@@ -194,6 +195,13 @@ struct fscrypt_info {
 	 */
 	struct fscrypt_direct_key *ci_direct_key;
 
+	/*
+	 * With v2 policies, this can be used with siphash
+	 * When the key has been set, ci_hash_key_initialized is set to true
+	 */
+	siphash_key_t ci_hash_key;
+	bool ci_hash_key_initialized;
+
 	/* The encryption policy used by this inode */
 	union fscrypt_policy ci_policy;
 
@@ -286,6 +294,7 @@ extern int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 #define HKDF_CONTEXT_PER_FILE_KEY	2
 #define HKDF_CONTEXT_DIRECT_KEY		3
 #define HKDF_CONTEXT_IV_INO_LBLK_64_KEY	4
+#define HKDF_CONTEXT_FNAME_HASH_KEY     5
 
 extern int fscrypt_hkdf_expand(struct fscrypt_hkdf *hkdf, u8 context,
 			       const u8 *info, unsigned int infolen,
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index f577bb6613f9..e6c7ec04cd25 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -192,7 +192,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 				     ci->ci_mode->friendly_name);
 			return -EINVAL;
 		}
-		return setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
+		err = setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
 					  HKDF_CONTEXT_DIRECT_KEY, false);
 	} else if (ci->ci_policy.v2.flags &
 		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
@@ -202,20 +202,31 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * the IVs.  This format is optimized for use with inline
 		 * encryption hardware compliant with the UFS or eMMC standards.
 		 */
-		return setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
+		err = setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
 					  HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
 					  true);
-	}
-
-	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+	} else {
+		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
 				  HKDF_CONTEXT_PER_FILE_KEY,
 				  ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE,
 				  derived_key, ci->ci_mode->keysize);
-	if (err)
-		return err;
+		if (err)
+			return err;
+
+		err = fscrypt_set_derived_key(ci, derived_key);
+		memzero_explicit(derived_key, ci->ci_mode->keysize);
+		if (err)
+			return err;
+	}
 
-	err = fscrypt_set_derived_key(ci, derived_key);
-	memzero_explicit(derived_key, ci->ci_mode->keysize);
+	if (S_ISDIR(ci->ci_inode->i_mode)) {
+		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+			  HKDF_CONTEXT_FNAME_HASH_KEY,
+			  ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE,
+			  (u8 *)&ci->ci_hash_key, sizeof(ci->ci_hash_key));
+		if (!err)
+			ci->ci_hash_key_initialized = true;
+	}
 	return err;
 }
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 1a7bffe78ed5..e13ff68a99f0 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -155,6 +155,8 @@ extern int fscrypt_fname_alloc_buffer(const struct inode *, u32,
 extern void fscrypt_fname_free_buffer(struct fscrypt_str *);
 extern int fscrypt_fname_disk_to_usr(struct inode *, u32, u32,
 			const struct fscrypt_str *, struct fscrypt_str *);
+extern u64 fscrypt_fname_siphash(const struct inode *dir,
+					const struct qstr *name);
 
 #define FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE	32
 
@@ -446,6 +448,12 @@ static inline int fscrypt_fname_disk_to_usr(struct inode *inode,
 	return -EOPNOTSUPP;
 }
 
+static inline u64 fscrypt_fname_siphash(const struct inode *inode,
+					const struct qstr *name)
+{
+	return 0;
+}
+
 static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
 				      const u8 *de_name, u32 de_name_len)
 {
-- 
2.24.0.393.g34dc348eaf-goog

