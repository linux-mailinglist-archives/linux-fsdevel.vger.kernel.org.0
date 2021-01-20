Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521CC2FD883
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391850AbhATSdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404417AbhATS3s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:29:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 864AD2342C;
        Wed, 20 Jan 2021 18:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167331;
        bh=ZPy7MsX3VP8mNVh0Wc4o/iMp/H7aNB3koRbPlYWauRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ru2hGep58ZTWV1ml83eSbhzQdoy4hbTv3CSB0er10n4F3QyOJx27P8YPZ7sT7Q2Mo
         7ttjz/TOw+zn6S7yhYmRiFDncyakiwbgr2uJaJCgFSdaNoCUV/SAAyiykMvB68q+Xs
         JjTCqQ1dovoDMU8f6w5QmAisqSjuXzuIkbEqmKptr/MzDuTC0x7v52SxAeQapuyrWo
         Mzs3NH4vybDg27s30j71kTjabpW4DZEft2WsGmyu4ZaUcbDxJluTQ9yUEXsmodmB/2
         Cl93gNZ/VNzRTpM9aKLHo3zX4PpDSEUxzQBxiqVRnKrc0QPen6Rf/pWOjMWaAUlyyA
         LYBjZvw/E+6Tg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v4 04/17] fscrypt: add fscrypt_context_for_new_inode
Date:   Wed, 20 Jan 2021 13:28:34 -0500
Message-Id: <20210120182847.644850-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120182847.644850-1-jlayton@kernel.org>
References: <20210120182847.644850-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CephFS will need to be able to generate a context for a new "prepared"
inode. Add a new routine for getting the context out of an in-core
inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/policy.c      | 34 ++++++++++++++++++++++++++++------
 include/linux/fscrypt.h |  1 +
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index a51cef6bd27f..44b4236427ba 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -664,6 +664,31 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
 	return fscrypt_get_dummy_policy(dir->i_sb);
 }
 
+/**
+ * fscrypt_context_for_new_inode() - create an encryption context for a new inode
+ * @ctx: where context should be written
+ * @inode: inode from which to fetch policy and nonce
+ *
+ * Given an in-core "prepared" (via fscrypt_prepare_new_inode) inode,
+ * generate a new context and write it to ctx. ctx _must_ be at least
+ * FSCRYPT_SET_CONTEXT_MAX_SIZE bytes.
+ *
+ * Returns size of the resulting context or a negative error code.
+ */
+int fscrypt_context_for_new_inode(void *ctx, struct inode *inode)
+{
+	struct fscrypt_info *ci = inode->i_crypt_info;
+
+	BUILD_BUG_ON(sizeof(union fscrypt_context) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
+
+	/* fscrypt_prepare_new_inode() should have set up the key already. */
+	if (WARN_ON_ONCE(!ci))
+		return -ENOKEY;
+
+	return fscrypt_new_context(ctx, &ci->ci_policy, ci->ci_nonce);
+}
+EXPORT_SYMBOL_GPL(fscrypt_context_for_new_inode);
+
 /**
  * fscrypt_set_context() - Set the fscrypt context of a new inode
  * @inode: a new inode
@@ -680,12 +705,9 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
 	union fscrypt_context ctx;
 	int ctxsize;
 
-	/* fscrypt_prepare_new_inode() should have set up the key already. */
-	if (WARN_ON_ONCE(!ci))
-		return -ENOKEY;
-
-	BUILD_BUG_ON(sizeof(ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
-	ctxsize = fscrypt_new_context(&ctx, &ci->ci_policy, ci->ci_nonce);
+	ctxsize = fscrypt_context_for_new_inode(&ctx, inode);
+	if (ctxsize < 0)
+		return ctxsize;
 
 	/*
 	 * This may be the first time the inode number is available, so do any
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index b5c31baaa8bf..087fa87bca0b 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -178,6 +178,7 @@ int fscrypt_ioctl_get_policy(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_policy_ex(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_nonce(struct file *filp, void __user *arg);
 int fscrypt_has_permitted_context(struct inode *parent, struct inode *child);
+int fscrypt_context_for_new_inode(void *ctx, struct inode *inode);
 int fscrypt_set_context(struct inode *inode, void *fs_data);
 
 struct fscrypt_dummy_policy {
-- 
2.29.2

