Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC774E40A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiCVOPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbiCVOPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A417E095;
        Tue, 22 Mar 2022 07:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A44CE615C7;
        Tue, 22 Mar 2022 14:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503B8C340EE;
        Tue, 22 Mar 2022 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958403;
        bh=/2A2k4sWEd7IyWPle/TZYZqgjUZDsDQ1CyNMqfDq1zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bykfwKHV/ZX94pknTW/itFhIgQ2rt+odpgr1wd3rNYNva6LJVYF0z3lknag4u4QUa
         Cvzbr1WghtbYcaSr2+9HHEczf6b1oKE5eetgO+tYl6Jjwz2abolkBHvYrDrbY6zbZj
         zN031jBW/G27622qZ7gFnuFxmGbH+KwaDbbQblfa9kLki3L8jUnqvGrXoXaw218rPC
         fJ7wqI3PCMoupX0/BxtiITY1F9X62ndtbF2BcAG2xvQKHC+nmtNpFP9/WOVILneQRW
         9Mnc24ysg1l44XFHiMsY2Qfw/e05Zyw8365XIn6SbWBDzgoQ4n1rqRNMNkxVeZZN+I
         IaCdFgKUqQpGw==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de, Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH v11 04/51] fscrypt: add fscrypt_context_for_new_inode
Date:   Tue, 22 Mar 2022 10:12:29 -0400
Message-Id: <20220322141316.41325-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

