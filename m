Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51335EAAB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiIZPYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiIZPXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:23:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CA8883CD;
        Mon, 26 Sep 2022 07:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B7015CE115A;
        Mon, 26 Sep 2022 14:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6234C43140;
        Mon, 26 Sep 2022 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201350;
        bh=laSeBp0G43DR1R7V9v9q91dvN+Md/8RLCnc3BwGKbvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nl7zY4DQ9GziS+/EQA/f0RjHHeL/Nl7CrsD8n09KAMegBerKEAwDSn62M89QDVqCu
         bi9xkKI9mJ8qOB0c1xYSGhNZufqBNAiyfOr5BylePJFAN4DI1UTZ1q7HKOKGh3SVDj
         JuGwHjnZJGOmhlHgR1sgTzCohAQqsgwR35hsqAenRgLILHoj8RHyw1DZUDlhhnwHUL
         fKUnugIkQnQtvkqlCEyt5gX+EagsF6oIZfDz2inWqO9Yru1QSHB+4cSs/8FMDFN4kk
         WRHYgRFe5IWWNg7nAlRv1SY+sDMsoVHeMQlqNAUWu1bLCkhvChpKK8VF4C3VxqIRBL
         NRgawripikWew==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 10/30] security: add set acl hook
Date:   Mon, 26 Sep 2022 16:08:07 +0200
Message-Id: <20220926140827.142806-11-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5225; i=brauner@kernel.org; h=from:subject; bh=laSeBp0G43DR1R7V9v9q91dvN+Md/8RLCnc3BwGKbvo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbrJ//+R23Tf9G+v+B6kULZ65V/67Aeeqzux/8h/ZjU4f X/kvuaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAii+MYGc7UrjPxTUi8vWElh8Z+vj nmtwqMM68EnXZi5FnWMqcskovhfwFDROiFTKOVR4P/fs97oeFw/Nj7bd8sNXYoW0QeknjYxwoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

So far posix acls were passed as a void blob to the security and
integrity modules. Some of them like evm then proceed to interpret the
void pointer and convert it into the kernel internal struct posix acl
representation to perform their integrity checking magic. This is
obviously pretty problematic as that requires knowledge that only the
vfs is guaranteed to have and has lead to various bugs. Add a proper
security hook for setting posix acls and pass down the posix acls in
their appropriate vfs format instead of hacking it through a void
pointer stored in the uapi format.

In the next patches we implement the hooks for the few security modules
that do actually have restrictions on posix acls.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/lsm_hooks.h     |  4 ++++
 include/linux/security.h      | 11 +++++++++++
 security/security.c           |  9 +++++++++
 4 files changed, 26 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 806448173033..9f7bce6927b1 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -145,6 +145,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_removexattr, struct user_namespace *mnt_userns,
 	 struct dentry *dentry, const char *name)
+LSM_HOOK(int, 0, inode_set_acl, struct user_namespace *mnt_userns,
+	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_killpriv, struct user_namespace *mnt_userns,
 	 struct dentry *dentry)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 84a0d7e02176..28246c5d190c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -435,6 +435,10 @@
  *	Check permission before removing the extended attribute
  *	identified by @name for @dentry.
  *	Return 0 if permission is granted.
+ * @inode_set_acl:
+ *	Check permission before setting the posix acls
+ *	The posix acls in @kacl are identified by @acl_name.
+ *	Return 0 if permission is granted.
  * @inode_getsecurity:
  *	Retrieve a copy of the extended attribute representation of the
  *	security label associated with @name for @inode via @buffer.  Note that
diff --git a/include/linux/security.h b/include/linux/security.h
index 1bc362cb413f..db9b97786075 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -359,6 +359,9 @@ int security_inode_getattr(const struct path *path);
 int security_inode_setxattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags);
+int security_inode_set_acl(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, const char *acl_name,
+			   struct posix_acl *kacl);
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags);
 int security_inode_getxattr(struct dentry *dentry, const char *name);
@@ -869,6 +872,14 @@ static inline int security_inode_setxattr(struct user_namespace *mnt_userns,
 	return cap_inode_setxattr(dentry, name, value, size, flags);
 }
 
+static inline int security_inode_set_acl(struct user_namespace *mnt_userns,
+					 struct dentry *dentry,
+					 const char *acl_name,
+					 struct posix_acl *kacl)
+{
+	return 0;
+}
+
 static inline void security_inode_post_setxattr(struct dentry *dentry,
 		const char *name, const void *value, size_t size, int flags)
 { }
diff --git a/security/security.c b/security/security.c
index 14d30fec8a00..56d48e7254d6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1370,6 +1370,15 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
 	return evm_inode_setxattr(mnt_userns, dentry, name, value, size);
 }
 
+int security_inode_set_acl(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, const char *acl_name,
+			   struct posix_acl *kacl)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+	return call_int_hook(inode_set_acl, 0, mnt_userns, dentry, acl_name, kacl);
+}
+
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
-- 
2.34.1

