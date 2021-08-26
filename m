Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC173F8BC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbhHZQVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243092AbhHZQVH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9195610CD;
        Thu, 26 Aug 2021 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994820;
        bh=EaO34IKhsu37UUuPbmywah+9vjsTfXP/e4WoLngrQdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1thB8OynThmPF4tnKH29zuTnHWE/2SS9wP761kGzWkP7ugPWbPzXG4gIaX+IhoFB
         Gkax6GOqhkxgA1SXxiK7Lvanjth7c2iwyAOIFLB2pZ52Di9zX3CI35tglgA9C0QV3I
         aRzzj/39YZfpcsEPjfd6iCGCk1FAAbCvL8diE/g19GA6oXYfzdfSa59GzjSRs/4urW
         TpG1ebvt/8oRYaN4A01TAsvVUoVFx/QL8fLhIa2pjm4DEhw6MFrBgnE/opGoecKgNu
         Y1HkE7bti1X9fGXRKsaEUpAUe295tQjscy6A74kyOfb14HiUpObHwNKQAl5IWFxR8g
         VwCCR5h1xOffw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 04/24] fscrypt: add fscrypt_context_for_new_inode
Date:   Thu, 26 Aug 2021 12:19:54 -0400
Message-Id: <20210826162014.73464-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most filesystems just call fscrypt_set_context on new inodes, which
usually causes a setxattr. That's a bit late for ceph, which can send
along a full set of attributes with the create request.

Doing so allows it to avoid race windows that where the new inode could
be seen by other clients without the crypto context attached. It also
avoids the separate round trip to the server.

Refactor the fscrypt code a bit to allow us to create a new crypto
context, attach it to the inode, and write it to the buffer, but without
calling set_context on it. ceph can later use this to marshal the
context into the attributes we send along with the create request.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/policy.c      | 34 ++++++++++++++++++++++++++++------
 include/linux/fscrypt.h |  1 +
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index ed3d623724cd..fdcdbde5d57b 100644
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
+ * Return: size of the resulting context or a negative error code.
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
index 64281ba4be2b..a7f2cb7fcf0b 100644
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
2.31.1

