Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4523131DA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 03:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgAGCdj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 21:33:39 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:57003 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgAGCdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:33:38 -0500
Received: by mail-pf1-f201.google.com with SMTP id h16so20012301pfn.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 18:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y/HXwTMWbePLkX7jf55rAi5wOsdmr84mYc7PuSsZxzo=;
        b=Kno/qnE91qjrVqc5lgWjRzkPJxNZe86Tn3KM88Jxgm+YgNcMchtZFjdT1hnlqjg8dg
         gjL6ly2Ww2cCXSjUnq8Q3k+25zvwXddlG+3CzSoGZENA5cua5aS7c7/WtiUuF8362Ajb
         tovKHGJNsrsnvFwiDZVX+1EKweo3MURM1LnHDNjL1MZ6+K7jz5yI6dUbltVGM3r1PGU1
         XTQl6wqZLramzVsdYAWHGQgZ0wlLwCUXAd02w8dnBOs9Uu6IWYFdyBuM2djR6GZQk06/
         TYsZUwcx6sDcbYH24QCp95OXARO88cjY6o+VgPz2ZiA/E+/4qFOZ38euSbaDFY0T0PQB
         2mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y/HXwTMWbePLkX7jf55rAi5wOsdmr84mYc7PuSsZxzo=;
        b=httuxzqTBJaYU0M821dUa1W9L/LC/6XCaPz/VsaqB426ltYhLsXz9d2iJ3+3YSO/BQ
         /IM8Uix3ddaNilggpKB6dzNQ7oD13+Ey7Qmnfc0GWPZS5Gl4gdj+yul+70ONyUdxwrby
         eKY8Td6KMWeZFiV96bVYAsmJwIiBF+g2xgzrxrv1jO2+/OaOCEY5e1l13R67svplQFmM
         OOCKpRWllJOSUmF0wOo2QGbBn7hLM8QgdwCqfcYv8EBvKCGEiyXglrQ59xNWzFYB+ad7
         xprtlIg6c5kIMf22Pj3lTqCKD+OKCbLvvWkVLAtzE4/pwx0ukbIZJZ933e9+W/WnUoeN
         zeQw==
X-Gm-Message-State: APjAAAXXFNh8WywubSYd2BqXxd/l7eaCpZYI7XSUcUgufO2DcsMMwzdv
        tR6F1c874iw8OEZE39+DR1bSKXULdpw=
X-Google-Smtp-Source: APXvYqzT8o+MCBh0hwXs0xehf21X+dEs8KvQG4CohubKCyRtCzjxjyv3W2bcq7oKgKihB/dPEQR2KZR1Ge8=
X-Received: by 2002:a63:1953:: with SMTP id 19mr112379139pgz.157.1578364417939;
 Mon, 06 Jan 2020 18:33:37 -0800 (PST)
Date:   Mon,  6 Jan 2020 18:33:21 -0800
In-Reply-To: <20200107023323.38394-1-drosen@google.com>
Message-Id: <20200107023323.38394-2-drosen@google.com>
Mime-Version: 1.0
References: <20200107023323.38394-1-drosen@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 1/3] fscrypt: Add siphash and hash key for policy v2
From:   Daniel Rosenberg <drosen@google.com>
To:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With encryption and casefolding, we cannot simply take the hash of the
ciphertext because of case insensitivity, and we can't take the hash of
the unencrypted name since that would leak information about the
encrypted name. Instead we can use siphash to compute a keyed hash of
the file names.

When a v2 policy is used on a directory, we derive a key for use with
siphash.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/crypto/fname.c           | 22 ++++++++++++++++++++++
 fs/crypto/fscrypt_private.h |  9 +++++++++
 fs/crypto/keysetup.c        | 32 +++++++++++++++++++++++---------
 include/linux/fscrypt.h     |  9 +++++++++
 4 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 3fd27e14ebdd..371e8f01d1c8 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -402,6 +402,28 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 }
 EXPORT_SYMBOL(fscrypt_setup_filename);
 
+/**
+ * fscrypt_fname_siphash() - Calculate the siphash for a file name
+ * @dir: the parent directory
+ * @name: the name of the file to get the siphash of
+ *
+ * Given a user-provided filename @name, this function calculates the siphash of
+ * that name using the directory's hash key.
+ *
+ * This assumes the directory uses a v2 policy, and the key is available.
+ *
+ * Return: the siphash of @name using the hash key of @dir
+ */
+u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
+{
+	struct fscrypt_info *ci = dir->i_crypt_info;
+
+	WARN_ON(!ci->ci_hash_key_initialized);
+
+	return siphash(name->name, name->len, &ci->ci_hash_key);
+}
+EXPORT_SYMBOL(fscrypt_fname_siphash);
+
 /*
  * Validate dentries in encrypted directories to make sure we aren't potentially
  * caching stale dentries after a key has been added.
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index b22e8decebed..8b37a5eebb57 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -12,6 +12,7 @@
 #define _FSCRYPT_PRIVATE_H
 
 #include <linux/fscrypt.h>
+#include <linux/siphash.h>
 #include <crypto/hash.h>
 
 #define CONST_STRLEN(str)	(sizeof(str) - 1)
@@ -188,6 +189,13 @@ struct fscrypt_info {
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
 
@@ -262,6 +270,7 @@ extern int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 #define HKDF_CONTEXT_PER_FILE_KEY	2
 #define HKDF_CONTEXT_DIRECT_KEY		3
 #define HKDF_CONTEXT_IV_INO_LBLK_64_KEY	4
+#define HKDF_CONTEXT_FNAME_HASH_KEY     5
 
 extern int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 			       const u8 *info, unsigned int infolen,
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 96074054bdbc..c1bd897c9310 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -189,7 +189,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * This ensures that the master key is consistently used only
 		 * for HKDF, avoiding key reuse issues.
 		 */
-		return setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
+		err = setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
 					  HKDF_CONTEXT_DIRECT_KEY, false);
 	} else if (ci->ci_policy.v2.flags &
 		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
@@ -199,20 +199,34 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * the IVs.  This format is optimized for use with inline
 		 * encryption hardware compliant with the UFS or eMMC standards.
 		 */
-		return setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
+		err = setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
 					  HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
 					  true);
+	} else {
+		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+					  HKDF_CONTEXT_PER_FILE_KEY,
+					  ci->ci_nonce,
+					  FS_KEY_DERIVATION_NONCE_SIZE,
+					  derived_key, ci->ci_mode->keysize);
+		if (err)
+			return err;
+
+		err = fscrypt_set_derived_key(ci, derived_key);
+		memzero_explicit(derived_key, ci->ci_mode->keysize);
 	}
-
-	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
-				  HKDF_CONTEXT_PER_FILE_KEY,
-				  ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE,
-				  derived_key, ci->ci_mode->keysize);
 	if (err)
 		return err;
 
-	err = fscrypt_set_derived_key(ci, derived_key);
-	memzero_explicit(derived_key, ci->ci_mode->keysize);
+	if (S_ISDIR(ci->ci_inode->i_mode)) {
+		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+					  HKDF_CONTEXT_FNAME_HASH_KEY,
+					  ci->ci_nonce,
+					  FS_KEY_DERIVATION_NONCE_SIZE,
+					  (u8 *)&ci->ci_hash_key,
+					  sizeof(ci->ci_hash_key));
+		if (!err)
+			ci->ci_hash_key_initialized = true;
+	}
 	return err;
 }
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 6fe8d0f96a4a..1dfbed855bee 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -172,6 +172,8 @@ extern int fscrypt_fname_disk_to_usr(const struct inode *inode,
 				     u32 hash, u32 minor_hash,
 				     const struct fscrypt_str *iname,
 				     struct fscrypt_str *oname);
+extern u64 fscrypt_fname_siphash(const struct inode *dir,
+				 const struct qstr *name);
 
 #define FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE	32
 
@@ -468,6 +470,13 @@ static inline int fscrypt_fname_disk_to_usr(const struct inode *inode,
 	return -EOPNOTSUPP;
 }
 
+static inline u64 fscrypt_fname_siphash(const struct inode *dir,
+					const struct qstr *name)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
 static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
 				      const u8 *de_name, u32 de_name_len)
 {
-- 
2.24.1.735.g03f4e72817-goog

