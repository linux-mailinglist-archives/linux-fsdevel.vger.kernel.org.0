Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6D82235
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfHEQ3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:29:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbfHEQ2e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:28:34 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8ADD21872;
        Mon,  5 Aug 2019 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565022514;
        bh=ysbdRDp4t6yR1/mnrxfjF5Thy72larG2YRdxScNw3NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IkaekEVWEZv6P2zLxKDfAFH2Rc6UZEkYYApZq0mdc1+4uY1/CZV13/7sak9dAfvi5
         TVTcBTb9vnNLTJjQihbmUmF9b9Grh8tR04GSku4ZTqZC2Tv2iYxol8vBleANB+5qTD
         Ft4OIaHcgSEFShuge2qtieXLdDjlceCu/wpmEpHw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v8 08/20] fscrypt: rename keyinfo.c to keysetup.c
Date:   Mon,  5 Aug 2019 09:25:09 -0700
Message-Id: <20190805162521.90882-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805162521.90882-1-ebiggers@kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Rename keyinfo.c to keysetup.c since this better describes what the file
does (sets up the key), and it matches the new file keysetup_v1.c.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/Makefile                  | 2 +-
 fs/crypto/fscrypt_private.h         | 2 +-
 fs/crypto/{keyinfo.c => keysetup.c} | 0
 include/linux/fscrypt.h             | 4 ++--
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename fs/crypto/{keyinfo.c => keysetup.c} (100%)

diff --git a/fs/crypto/Makefile b/fs/crypto/Makefile
index 1fba255c34ca56..ad14d4c29784a6 100644
--- a/fs/crypto/Makefile
+++ b/fs/crypto/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_FS_ENCRYPTION)	+= fscrypto.o
 fscrypto-y := crypto.o \
 	      fname.o \
 	      hooks.o \
-	      keyinfo.o \
+	      keysetup.o \
 	      keysetup_v1.o \
 	      policy.o
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 387b44b255f6ab..794dcba25ca826 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -156,7 +156,7 @@ extern bool fscrypt_fname_encrypted_size(const struct inode *inode,
 					 u32 orig_len, u32 max_len,
 					 u32 *encrypted_len_ret);
 
-/* keyinfo.c */
+/* keysetup.c */
 
 struct fscrypt_mode {
 	const char *friendly_name;
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keysetup.c
similarity index 100%
rename from fs/crypto/keyinfo.c
rename to fs/crypto/keysetup.c
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 81c0c754f8b21b..583802cb2e35d0 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -138,7 +138,7 @@ extern int fscrypt_ioctl_get_policy(struct file *, void __user *);
 extern int fscrypt_has_permitted_context(struct inode *, struct inode *);
 extern int fscrypt_inherit_context(struct inode *, struct inode *,
 					void *, bool);
-/* keyinfo.c */
+/* keysetup.c */
 extern int fscrypt_get_encryption_info(struct inode *);
 extern void fscrypt_put_encryption_info(struct inode *);
 extern void fscrypt_free_inode(struct inode *);
@@ -367,7 +367,7 @@ static inline int fscrypt_inherit_context(struct inode *parent,
 	return -EOPNOTSUPP;
 }
 
-/* keyinfo.c */
+/* keysetup.c */
 static inline int fscrypt_get_encryption_info(struct inode *inode)
 {
 	return -EOPNOTSUPP;
-- 
2.22.0.770.g0f2c4a37fd-goog

