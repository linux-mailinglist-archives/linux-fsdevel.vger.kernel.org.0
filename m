Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1166B2CCC8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbgLCCYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgLCCYJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:24:09 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v2 7/9] fscrypt: move fscrypt_require_key() to fscrypt_private.h
Date:   Wed,  2 Dec 2020 18:20:39 -0800
Message-Id: <20201203022041.230976-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203022041.230976-1-ebiggers@kernel.org>
References: <20201203022041.230976-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

fscrypt_require_key() is now only used by files in fs/crypto/.  So
reduce its visibility to fscrypt_private.h.  This is also a prerequsite
for unexporting fscrypt_get_encryption_info().

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h | 26 ++++++++++++++++++++++++++
 include/linux/fscrypt.h     | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index a61d4dbf0a0b0..16dd55080127a 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -571,6 +571,32 @@ int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
 void fscrypt_hash_inode_number(struct fscrypt_info *ci,
 			       const struct fscrypt_master_key *mk);
 
+/**
+ * fscrypt_require_key() - require an inode's encryption key
+ * @inode: the inode we need the key for
+ *
+ * If the inode is encrypted, set up its encryption key if not already done.
+ * Then require that the key be present and return -ENOKEY otherwise.
+ *
+ * No locks are needed, and the key will live as long as the struct inode --- so
+ * it won't go away from under you.
+ *
+ * Return: 0 on success, -ENOKEY if the key is missing, or another -errno code
+ * if a problem occurred while setting up the encryption key.
+ */
+static inline int fscrypt_require_key(struct inode *inode)
+{
+	if (IS_ENCRYPTED(inode)) {
+		int err = fscrypt_get_encryption_info(inode);
+
+		if (err)
+			return err;
+		if (!fscrypt_has_encryption_key(inode))
+			return -ENOKEY;
+	}
+	return 0;
+}
+
 /* keysetup_v1.c */
 
 void fscrypt_put_direct_key(struct fscrypt_direct_key *dk);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index b20900bb829fc..a07610f279266 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -688,32 +688,6 @@ static inline bool fscrypt_has_encryption_key(const struct inode *inode)
 	return fscrypt_get_info(inode) != NULL;
 }
 
-/**
- * fscrypt_require_key() - require an inode's encryption key
- * @inode: the inode we need the key for
- *
- * If the inode is encrypted, set up its encryption key if not already done.
- * Then require that the key be present and return -ENOKEY otherwise.
- *
- * No locks are needed, and the key will live as long as the struct inode --- so
- * it won't go away from under you.
- *
- * Return: 0 on success, -ENOKEY if the key is missing, or another -errno code
- * if a problem occurred while setting up the encryption key.
- */
-static inline int fscrypt_require_key(struct inode *inode)
-{
-	if (IS_ENCRYPTED(inode)) {
-		int err = fscrypt_get_encryption_info(inode);
-
-		if (err)
-			return err;
-		if (!fscrypt_has_encryption_key(inode))
-			return -ENOKEY;
-	}
-	return 0;
-}
-
 /**
  * fscrypt_prepare_link() - prepare to link an inode into a possibly-encrypted
  *			    directory
-- 
2.29.2

