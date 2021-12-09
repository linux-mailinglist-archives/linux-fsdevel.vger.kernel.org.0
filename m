Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ED546EB89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbhLIPkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbhLIPka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6A2C0617A1;
        Thu,  9 Dec 2021 07:36:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 92AAECE2689;
        Thu,  9 Dec 2021 15:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F4CC341C7;
        Thu,  9 Dec 2021 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064212;
        bh=NG1st52YEYAGAm8qyNZ6r+/8xroElHqCS5fIfjXfDnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLgUjxST8J58NnGwPqPeeej7XKQobZeDGCaauRamdi8tqwqChOHFapktfRby0yiGr
         JWJQHuaKOrddabCMUaWdFCHUZzOV6+IYcFfzma3hCojMKYXOdLa2WsECf0YLjZJcPK
         b30dTyXggGbRakTOZkAmLK1ivMN6CwQOjslJto4y1T2aMwa9DzasZ3La1abvZbtW9Y
         YgbkkbYeR/M/wvzuE1CrL6gxg2KWCcKrWHqbHTUvAlOa15q5jvQkYofDN6Eoo7n7+R
         aANaoRpUBH7UYofWsFhQ4l+VGRCzI8HPi2mjzOaYYLahHYwOS/h+b9KFDOzhLILNJj
         9BLMBQ68Zlvfw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/36] fscrypt: uninline and export fscrypt_require_key
Date:   Thu,  9 Dec 2021 10:36:16 -0500
Message-Id: <20211209153647.58953-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ceph_atomic_open needs to be able to call this.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fscrypt_private.h | 26 --------------------------
 fs/crypto/keysetup.c        | 27 +++++++++++++++++++++++++++
 include/linux/fscrypt.h     |  5 +++++
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 51e42767dbd6..89d5d85afdd5 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -579,32 +579,6 @@ void fscrypt_hash_inode_number(struct fscrypt_info *ci,
 
 int fscrypt_get_encryption_info(struct inode *inode, bool allow_unsupported);
 
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
-		int err = fscrypt_get_encryption_info(inode, false);
-
-		if (err)
-			return err;
-		if (!fscrypt_has_encryption_key(inode))
-			return -ENOKEY;
-	}
-	return 0;
-}
-
 /* keysetup_v1.c */
 
 void fscrypt_put_direct_key(struct fscrypt_direct_key *dk);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index eede186b04ce..7aeb0047d03d 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -792,3 +792,30 @@ int fscrypt_drop_inode(struct inode *inode)
 	return !is_master_key_secret_present(&mk->mk_secret);
 }
 EXPORT_SYMBOL_GPL(fscrypt_drop_inode);
+
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
+int fscrypt_require_key(struct inode *inode)
+{
+	if (IS_ENCRYPTED(inode)) {
+		int err = fscrypt_get_encryption_info(inode, false);
+
+		if (err)
+			return err;
+		if (!fscrypt_has_encryption_key(inode))
+			return -ENOKEY;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fscrypt_require_key);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 530433098f82..7d3c670d0c6d 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -334,6 +334,7 @@ bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
 int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
+int fscrypt_require_key(struct inode *inode);
 
 /* bio.c */
 void fscrypt_decrypt_bio(struct bio *bio);
@@ -601,6 +602,10 @@ static inline int fscrypt_d_revalidate(struct dentry *dentry,
 	return 1;
 }
 
+static inline int fscrypt_require_key(struct inode *inode)
+{
+	return 0;
+}
 /* bio.c */
 static inline void fscrypt_decrypt_bio(struct bio *bio)
 {
-- 
2.33.1

