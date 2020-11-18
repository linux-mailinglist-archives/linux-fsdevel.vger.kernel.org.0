Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E799C2B77BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgKRH5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 02:57:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbgKRH5m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:57:42 -0500
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72022246B2;
        Wed, 18 Nov 2020 07:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605686261;
        bh=FaJPS+4AhsPK9Hjqvyuvxb/1dnxymbnVlmZfAPn5gcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETs/fepezweXiR3RVvD/V08ZO2J+3w+axT1045ZXG0ySoHoOPkv8KQGhsYkhLcqGs
         xVfQzJxdV+6XoMxfSSp/QZ/D0rjuhBJeN1gE+7S7o11NaQpjRy4O4ZLCXloc3aUcTV
         L4jkljPJYdapxPjojPTtKPw+RVYI5VVc0BNtD4bQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] fscrypt: remove unnecessary calls to fscrypt_require_key()
Date:   Tue, 17 Nov 2020 23:56:09 -0800
Message-Id: <20201118075609.120337-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118075609.120337-1-ebiggers@kernel.org>
References: <20201118075609.120337-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In an encrypted directory, a regular dentry (one that doesn't have the
no-key name flag) can only be created if the directory's encryption key
is available.

Therefore the calls to fscrypt_require_key() in __fscrypt_prepare_link()
and __fscrypt_prepare_rename() are unnecessary, as these functions
already check that the dentries they're given aren't no-key names.

Remove these unnecessary calls to fscrypt_require_key().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/hooks.c       | 26 ++++++++------------------
 include/linux/fscrypt.h |  3 +--
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 061418be4b08..c582e2ddb39c 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -54,15 +54,12 @@ EXPORT_SYMBOL_GPL(fscrypt_file_open);
 int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 			   struct dentry *dentry)
 {
-	int err;
-
-	err = fscrypt_require_key(dir);
-	if (err)
-		return err;
-
-	/* ... in case we looked up no-key name before key was added */
 	if (fscrypt_is_nokey_name(dentry))
 		return -ENOKEY;
+	/*
+	 * We don't need to separately check that the directory inode's key is
+	 * available, as it's implied by the dentry not being a no-key name.
+	 */
 
 	if (!fscrypt_has_permitted_context(dir, inode))
 		return -EXDEV;
@@ -75,20 +72,13 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 			     struct inode *new_dir, struct dentry *new_dentry,
 			     unsigned int flags)
 {
-	int err;
-
-	err = fscrypt_require_key(old_dir);
-	if (err)
-		return err;
-
-	err = fscrypt_require_key(new_dir);
-	if (err)
-		return err;
-
-	/* ... in case we looked up no-key name(s) before key was added */
 	if (fscrypt_is_nokey_name(old_dentry) ||
 	    fscrypt_is_nokey_name(new_dentry))
 		return -ENOKEY;
+	/*
+	 * We don't need to separately check that the directory inodes' keys are
+	 * available, as it's implied by the dentries not being no-key names.
+	 */
 
 	if (old_dir != new_dir) {
 		if (IS_ENCRYPTED(new_dir) &&
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 8e1d31c959bf..0c9e64969b73 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -710,8 +710,7 @@ static inline int fscrypt_require_key(struct inode *inode)
  *
  * A new link can only be added to an encrypted directory if the directory's
  * encryption key is available --- since otherwise we'd have no way to encrypt
- * the filename.  Therefore, we first set up the directory's encryption key (if
- * not already done) and return an error if it's unavailable.
+ * the filename.
  *
  * We also verify that the link will not violate the constraint that all files
  * in an encrypted directory tree use the same encryption policy.
-- 
2.29.2

