Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4667248B6A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346070AbiAKTQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346195AbiAKTQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08FEC06173F;
        Tue, 11 Jan 2022 11:16:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D8861786;
        Tue, 11 Jan 2022 19:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8C1C36AF3;
        Tue, 11 Jan 2022 19:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928573;
        bh=jalGUt9ZafDs2GuYKK8aDfW3xF3Fml9KLI7Z387tWcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNjEvGmTIb319/vOej7Os7bs50I+26SK7d5YgouJsveduJtBKECykQ8OJZBR7330E
         BWfvxlS8nfoGx5LZn2I42JkFED70I8C/XRiqsUks4h2eOzXjMlibgwjfdAI/enPu5Y
         k7/kr/43f/inBvZCFCH2KncUajcU6kHGa+HpnVTekAVSIqjCavGRId+337JJAMRhww
         gednPRS6qzWRo2PXa3wji3BMzLnYd0ECQ7HoW9PoZDgYRWDketFbgyoKbiOQD50sqA
         81KbWJMQi/pzW02tZzMINrEW+x7Hm2Bttp2a9TMHXQ/vDOawxhVtc6eKrUCwOtUpCC
         W+X/XdBc/n2mA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com,
        Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH v10 04/48] fscrypt: add fscrypt_context_for_new_inode
Date:   Tue, 11 Jan 2022 14:15:24 -0500
Message-Id: <20220111191608.88762-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
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

Acked-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/policy.c      | 35 +++++++++++++++++++++++++++++------
 include/linux/fscrypt.h |  1 +
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index ed3d623724cd..ec861af96252 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -664,6 +664,32 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
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
+	BUILD_BUG_ON(sizeof(union fscrypt_context) !=
+			FSCRYPT_SET_CONTEXT_MAX_SIZE);
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
@@ -680,12 +706,9 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
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
index c90e176b5843..530433098f82 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -276,6 +276,7 @@ int fscrypt_ioctl_get_policy(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_policy_ex(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_nonce(struct file *filp, void __user *arg);
 int fscrypt_has_permitted_context(struct inode *parent, struct inode *child);
+int fscrypt_context_for_new_inode(void *ctx, struct inode *inode);
 int fscrypt_set_context(struct inode *inode, void *fs_data);
 
 struct fscrypt_dummy_policy {
-- 
2.34.1

