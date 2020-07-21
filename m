Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC8228C5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 01:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbgGUXBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 19:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbgGUXBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:01:00 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D762077D;
        Tue, 21 Jul 2020 23:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595372459;
        bh=+JzszfrnukA7rp34K4rJ987oveUxD8x6PQPTeTcR6H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UD7wGV6o8j/007/nURLRwUgh3FtROGYfwXlRmz2E+hWc/ErhCaZg7QhEk0J6rE/0G
         BJHPNkKnY4vns9lZKCHYAn0AyRVj/MdMod0spy99kT4HspV3dOEXWcfNm82loSvY4+
         Kl/7BHiom0gFkPFuluRnlrqwmYTBIXRPyd2QkAtk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH 2/5] fscrypt: use smp_load_acquire() for fscrypt_prepared_key
Date:   Tue, 21 Jul 2020 15:59:17 -0700
Message-Id: <20200721225920.114347-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721225920.114347-1-ebiggers@kernel.org>
References: <20200721225920.114347-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Normally smp_store_release() or cmpxchg_release() is paired with
smp_load_acquire().  Sometimes smp_load_acquire() can be replaced with
the more lightweight READ_ONCE().  However, for this to be safe, all the
published memory must only be accessed in a way that involves the
pointer itself.  This may not be the case if allocating the object also
involves initializing a static or global variable, for example.

fscrypt_prepared_key includes a pointer to a crypto_skcipher object,
which is internal to and is allocated by the crypto subsystem.  By using
READ_ONCE() for it, we're relying on internal implementation details of
the crypto subsystem.

Remove this fragile assumption by using smp_load_acquire() instead.

(Note: I haven't seen any real-world problems here.  This change is just
fixing the code to be guaranteed correct and less fragile.)

Fixes: 5fee36095cda ("fscrypt: add inline encryption support")
Cc: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h | 15 +++++++++------
 fs/crypto/inline_crypt.c    |  6 ++++--
 fs/crypto/keysetup.c        |  6 ++++--
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index bc1a3fcd45ed..8117a61b6f55 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -351,13 +351,16 @@ fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
 			const struct fscrypt_info *ci)
 {
 	/*
-	 * The READ_ONCE() here pairs with the smp_store_release() in
-	 * fscrypt_prepare_key().  (This only matters for the per-mode keys,
-	 * which are shared by multiple inodes.)
+	 * The two smp_load_acquire()'s here pair with the smp_store_release()'s
+	 * in fscrypt_prepare_inline_crypt_key() and fscrypt_prepare_key().
+	 * I.e., in some cases (namely, if this prep_key is a per-mode
+	 * encryption key) another task can publish blk_key or tfm concurrently,
+	 * executing a RELEASE barrier.  We need to use smp_load_acquire() here
+	 * to safely ACQUIRE the memory the other task published.
 	 */
 	if (fscrypt_using_inline_encryption(ci))
-		return READ_ONCE(prep_key->blk_key) != NULL;
-	return READ_ONCE(prep_key->tfm) != NULL;
+		return smp_load_acquire(&prep_key->blk_key) != NULL;
+	return smp_load_acquire(&prep_key->tfm) != NULL;
 }
 
 #else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
@@ -391,7 +394,7 @@ static inline bool
 fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
 			const struct fscrypt_info *ci)
 {
-	return READ_ONCE(prep_key->tfm) != NULL;
+	return smp_load_acquire(&prep_key->tfm) != NULL;
 }
 #endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index d7aecadf33c1..dfb06375099a 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -176,8 +176,10 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 		}
 	}
 	/*
-	 * Pairs with READ_ONCE() in fscrypt_is_key_prepared().  (Only matters
-	 * for the per-mode keys, which are shared by multiple inodes.)
+	 * Pairs with the smp_load_acquire() in fscrypt_is_key_prepared().
+	 * I.e., here we publish ->blk_key with a RELEASE barrier so that
+	 * concurrent tasks can ACQUIRE it.  Note that this concurrency is only
+	 * possible for per-mode keys, not for per-file keys.
 	 */
 	smp_store_release(&prep_key->blk_key, blk_key);
 	return 0;
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 22a94b18fe70..7f85fc645602 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -129,8 +129,10 @@ int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 	/*
-	 * Pairs with READ_ONCE() in fscrypt_is_key_prepared().  (Only matters
-	 * for the per-mode keys, which are shared by multiple inodes.)
+	 * Pairs with the smp_load_acquire() in fscrypt_is_key_prepared().
+	 * I.e., here we publish ->tfm with a RELEASE barrier so that
+	 * concurrent tasks can ACQUIRE it.  Note that this concurrency is only
+	 * possible for per-mode keys, not for per-file keys.
 	 */
 	smp_store_release(&prep_key->tfm, tfm);
 	return 0;
-- 
2.27.0

