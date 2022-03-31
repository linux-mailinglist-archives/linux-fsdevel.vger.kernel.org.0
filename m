Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54D44EDCDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbiCaPd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiCaPdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF221C71C;
        Thu, 31 Mar 2022 08:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD4561AE4;
        Thu, 31 Mar 2022 15:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0078AC3410F;
        Thu, 31 Mar 2022 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740696;
        bh=/2A2k4sWEd7IyWPle/TZYZqgjUZDsDQ1CyNMqfDq1zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScTHYhQmcvxtgLq/fYOCwhHHl+h4+imZ/xTWZuoti3xog+JRPdKUxwRyeyXOjaDU5
         ha0Iz6AHwG0D02vD2jvaFyAiYAdBsAZfi/NkL2fcj34HOzBG5bOCBYDNSw0QyRg9J/
         5VrsS/S82bnGWQ0fHosXVQ1n4GozVK8AThCYCr3cmJTR1HlLOb7MJt76O21AotqaHa
         kmhMMctUfNr4gZCEbbgvJr0caW/qAKDRrCRZ9qTGuQGnzpJJc0dZSV55RSES1npv9/
         7zrkClEW2eP0qlGICrCUZ30O5zA7b0N3kVMJ25IjpyMktTAJeXFGk8OVxkmjrnucZA
         OY64dKdJHPRzA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v12 04/54] fscrypt: add fscrypt_context_for_new_inode
Date:   Thu, 31 Mar 2022 11:30:40 -0400
Message-Id: <20220331153130.41287-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.35.1

