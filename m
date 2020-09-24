Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFCB2767DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 06:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIXE3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 00:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIXE3C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:29:02 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FAA238E4;
        Thu, 24 Sep 2020 04:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600921741;
        bh=zkbK3kc+vjesm/oo0BR3v4YFB7mgYl6/SjNVtaJC49I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf+3f9n9whDLE3nRQBGBiXSBPyJBU5+wbl0Pzxy1oCesqnjN+hwcu1TZ3Crt7oe8w
         +VrERYCOeGY6zv1gmE8R4l1E5n4V+56OUhJTmCp+u35lAl+nOOoxMwnY0FVDRfpiKR
         lmE8PryChQoOaSxuK9i2Ja8Q4GUSoNu1QyPdPDhE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 2/2] fscrypt: rename DCACHE_ENCRYPTED_NAME to DCACHE_NOKEY_NAME
Date:   Wed, 23 Sep 2020 21:26:24 -0700
Message-Id: <20200924042624.98439-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924042624.98439-1-ebiggers@kernel.org>
References: <20200924042624.98439-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Originally we used the term "encrypted name" or "ciphertext name" to
mean the encoded filename that is shown when an encrypted directory is
listed without its key.  But these terms are ambiguous since they also
mean the filename stored on-disk.  "Encrypted name" is especially
ambiguous since it could also be understood to mean "this filename is
encrypted on-disk", similar to "encrypted file".

So we've started calling these encoded names "no-key names" instead.

Therefore, rename DCACHE_ENCRYPTED_NAME to DCACHE_NOKEY_NAME to avoid
confusion about what this flag means.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fname.c       |  2 +-
 fs/crypto/hooks.c       |  7 +++----
 include/linux/dcache.h  |  2 +-
 include/linux/fscrypt.h | 12 ++++++------
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 391acea4bc96..c65979452844 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -541,7 +541,7 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 	 * reverting to no-key names without evicting the directory's inode
 	 * -- which implies eviction of the dentries in the directory.
 	 */
-	if (!(dentry->d_flags & DCACHE_ENCRYPTED_NAME))
+	if (!(dentry->d_flags & DCACHE_NOKEY_NAME))
 		return 1;
 
 	/*
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index ca996e1c92d9..20b0df47fe6a 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -61,7 +61,7 @@ int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 		return err;
 
 	/* ... in case we looked up no-key name before key was added */
-	if (dentry->d_flags & DCACHE_ENCRYPTED_NAME)
+	if (dentry->d_flags & DCACHE_NOKEY_NAME)
 		return -ENOKEY;
 
 	if (!fscrypt_has_permitted_context(dir, inode))
@@ -86,8 +86,7 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return err;
 
 	/* ... in case we looked up no-key name(s) before key was added */
-	if ((old_dentry->d_flags | new_dentry->d_flags) &
-	    DCACHE_ENCRYPTED_NAME)
+	if ((old_dentry->d_flags | new_dentry->d_flags) & DCACHE_NOKEY_NAME)
 		return -ENOKEY;
 
 	if (old_dir != new_dir) {
@@ -116,7 +115,7 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 
 	if (fname->is_nokey_name) {
 		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_ENCRYPTED_NAME;
+		dentry->d_flags |= DCACHE_NOKEY_NAME;
 		spin_unlock(&dentry->d_lock);
 		d_set_d_op(dentry, &fscrypt_d_ops);
 	}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 65d975bf9390..6f95c3300cbb 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -213,7 +213,7 @@ struct dentry_operations {
 
 #define DCACHE_MAY_FREE			0x00800000
 #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
-#define DCACHE_ENCRYPTED_NAME		0x02000000 /* Encrypted name (dir key was unavailable) */
+#define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			0x04000000
 
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index bc9ec727e993..f1757e73162d 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -100,15 +100,15 @@ static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
 }
 
 /*
- * When d_splice_alias() moves a directory's encrypted alias to its decrypted
- * alias as a result of the encryption key being added, DCACHE_ENCRYPTED_NAME
- * must be cleared.  Note that we don't have to support arbitrary moves of this
- * flag because fscrypt doesn't allow encrypted aliases to be the source or
- * target of a rename().
+ * When d_splice_alias() moves a directory's no-key alias to its plaintext alias
+ * as a result of the encryption key being added, DCACHE_NOKEY_NAME must be
+ * cleared.  Note that we don't have to support arbitrary moves of this flag
+ * because fscrypt doesn't allow no-key names to be the source or target of a
+ * rename().
  */
 static inline void fscrypt_handle_d_move(struct dentry *dentry)
 {
-	dentry->d_flags &= ~DCACHE_ENCRYPTED_NAME;
+	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
 }
 
 /* crypto.c */
-- 
2.28.0

