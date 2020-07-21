Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9943E228C57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 01:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgGUXBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 19:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731328AbgGUXBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:01:00 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00EE207DD;
        Tue, 21 Jul 2020 23:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595372460;
        bh=8CFq23ApT2mi7bzagu5otAQAJtf6QR9J0mMn4N8FXeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SR6ircD6vFmclMJka0AoeoQ9p3CzMhFXM0C/JTPKEDNRmpvX+YWX2C6WaCXWupSs0
         887U4yLW+4Zwi3HLY0Smlz3Zc0Kmv4SmZz4fMM8qfuia9S23AKRjvGCGfVKjsAMXWK
         kaW5huWBgPPHacSfH1KGUwxg9hb9Wg0y3Bc0t6pE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 4/5] fscrypt: use smp_load_acquire() for ->i_crypt_info
Date:   Tue, 21 Jul 2020 15:59:19 -0700
Message-Id: <20200721225920.114347-5-ebiggers@kernel.org>
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

fscrypt_info includes various sub-objects which are internal to and are
allocated by other kernel subsystems such as keyrings and crypto.  So by
using READ_ONCE() for ->i_crypt_info, we're relying on internal
implementation details of these other kernel subsystems.

Remove this fragile assumption by using smp_load_acquire() instead.

(Note: I haven't seen any real-world problems here.  This change is just
fixing the code to be guaranteed correct and less fragile.)

Fixes: e37a784d8b6a ("fscrypt: use READ_ONCE() to access ->i_crypt_info")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keysetup.c    | 12 +++++++++++-
 fs/crypto/policy.c      |  4 ++--
 include/linux/fscrypt.h | 29 ++++++++++++++++++++++++-----
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 7f85fc645602..fea6226afc2b 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -518,7 +518,17 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	if (res)
 		goto out;
 
+	/*
+	 * Multiple tasks may race to set ->i_crypt_info, so use
+	 * cmpxchg_release().  This pairs with the smp_load_acquire() in
+	 * fscrypt_get_info().  I.e., here we publish ->i_crypt_info with a
+	 * RELEASE barrier so that other tasks can ACQUIRE it.
+	 */
 	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) == NULL) {
+		/*
+		 * We won the race and set ->i_crypt_info to our crypt_info.
+		 * Now link it into the master key's inode list.
+		 */
 		if (master_key) {
 			struct fscrypt_master_key *mk =
 				master_key->payload.data[0];
@@ -589,7 +599,7 @@ EXPORT_SYMBOL(fscrypt_free_inode);
  */
 int fscrypt_drop_inode(struct inode *inode)
 {
-	const struct fscrypt_info *ci = READ_ONCE(inode->i_crypt_info);
+	const struct fscrypt_info *ci = fscrypt_get_info(inode);
 	const struct fscrypt_master_key *mk;
 
 	/*
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 8a8ad0e44bb8..2a2d0c06147b 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -338,7 +338,7 @@ static int fscrypt_get_policy(struct inode *inode, union fscrypt_policy *policy)
 	union fscrypt_context ctx;
 	int ret;
 
-	ci = READ_ONCE(inode->i_crypt_info);
+	ci = fscrypt_get_info(inode);
 	if (ci) {
 		/* key available, use the cached policy */
 		*policy = ci->ci_policy;
@@ -627,7 +627,7 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 	if (res < 0)
 		return res;
 
-	ci = READ_ONCE(parent->i_crypt_info);
+	ci = fscrypt_get_info(parent);
 	if (ci == NULL)
 		return -ENOKEY;
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index bb257411365f..991ff8575d0e 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -74,10 +74,15 @@ struct fscrypt_operations {
 			    struct request_queue **devs);
 };
 
-static inline bool fscrypt_has_encryption_key(const struct inode *inode)
+static inline struct fscrypt_info *fscrypt_get_info(const struct inode *inode)
 {
-	/* pairs with cmpxchg_release() in fscrypt_get_encryption_info() */
-	return READ_ONCE(inode->i_crypt_info) != NULL;
+	/*
+	 * Pairs with the cmpxchg_release() in fscrypt_get_encryption_info().
+	 * I.e., another task may publish ->i_crypt_info concurrently, executing
+	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
+	 * ACQUIRE the memory the other task published.
+	 */
+	return smp_load_acquire(&inode->i_crypt_info);
 }
 
 /**
@@ -234,9 +239,9 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 }
 #else  /* !CONFIG_FS_ENCRYPTION */
 
-static inline bool fscrypt_has_encryption_key(const struct inode *inode)
+static inline struct fscrypt_info *fscrypt_get_info(const struct inode *inode)
 {
-	return false;
+	return NULL;
 }
 
 static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
@@ -619,6 +624,20 @@ static inline bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
 	       !__fscrypt_inode_uses_inline_crypto(inode);
 }
 
+/**
+ * fscrypt_has_encryption_key() - check whether an inode has had its key set up
+ * @inode: the inode to check
+ *
+ * Return: %true if the inode has had its encryption key set up, else %false.
+ *
+ * Usually this should be preceded by fscrypt_get_encryption_info() to try to
+ * set up the key first.
+ */
+static inline bool fscrypt_has_encryption_key(const struct inode *inode)
+{
+	return fscrypt_get_info(inode) != NULL;
+}
+
 /**
  * fscrypt_require_key() - require an inode's encryption key
  * @inode: the inode we need the key for
-- 
2.27.0

