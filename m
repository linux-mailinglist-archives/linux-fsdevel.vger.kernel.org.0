Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B052CCC89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbgLCCYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgLCCYI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:24:08 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v2 6/9] fscrypt: move body of fscrypt_prepare_setattr() out-of-line
Date:   Wed,  2 Dec 2020 18:20:38 -0800
Message-Id: <20201203022041.230976-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203022041.230976-1-ebiggers@kernel.org>
References: <20201203022041.230976-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In preparation for reducing the visibility of fscrypt_require_key() by
moving it to fscrypt_private.h, move the call to it from
fscrypt_prepare_setattr() to an out-of-line function.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/hooks.c       |  8 ++++++++
 include/linux/fscrypt.h | 11 +++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 82f351d3113ac..1c16dba222d95 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -120,6 +120,14 @@ int __fscrypt_prepare_readdir(struct inode *dir)
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_readdir);
 
+int __fscrypt_prepare_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	if (attr->ia_valid & ATTR_SIZE)
+		return fscrypt_require_key(d_inode(dentry));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
+
 /**
  * fscrypt_prepare_setflags() - prepare to change flags with FS_IOC_SETFLAGS
  * @inode: the inode on which flags are being changed
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 8cbb26f556952..b20900bb829fc 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -243,6 +243,7 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 			     struct fscrypt_name *fname);
 int __fscrypt_prepare_readdir(struct inode *dir);
+int __fscrypt_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 int fscrypt_prepare_setflags(struct inode *inode,
 			     unsigned int oldflags, unsigned int flags);
 int fscrypt_prepare_symlink(struct inode *dir, const char *target,
@@ -543,6 +544,12 @@ static inline int __fscrypt_prepare_readdir(struct inode *dir)
 	return -EOPNOTSUPP;
 }
 
+static inline int __fscrypt_prepare_setattr(struct dentry *dentry,
+					    struct iattr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int fscrypt_prepare_setflags(struct inode *inode,
 					   unsigned int oldflags,
 					   unsigned int flags)
@@ -840,8 +847,8 @@ static inline int fscrypt_prepare_readdir(struct inode *dir)
 static inline int fscrypt_prepare_setattr(struct dentry *dentry,
 					  struct iattr *attr)
 {
-	if (attr->ia_valid & ATTR_SIZE)
-		return fscrypt_require_key(d_inode(dentry));
+	if (IS_ENCRYPTED(d_inode(dentry)))
+		return __fscrypt_prepare_setattr(dentry, attr);
 	return 0;
 }
 
-- 
2.29.2

