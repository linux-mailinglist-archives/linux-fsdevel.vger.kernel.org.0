Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F64602ABE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJRL6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiJRL5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:57:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D68AEA34;
        Tue, 18 Oct 2022 04:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3FBDB81D8C;
        Tue, 18 Oct 2022 11:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FE8C43470;
        Tue, 18 Oct 2022 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094262;
        bh=4OOmQnsCaeDP4fJEoDyIU04D/CDt7fJnSyahyBjuyFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMXHU5Rhi4tlKNm6UJ6pKiTQmfIBp7WYeXhNNBe6tS+AfqnkL9vj9cE6+Yu5W38Uu
         I0a17RzWenC5tiZa1eCynXPtDbXwWPi00skblBOipb8Yj96IqFzMK03P83JdDpXqYT
         reREtm2zxHS3DEaoqFPp6zQNPwG6e6ygx3Isx5uumUbxRHx+gER98rOfnvPw3Z3oDV
         90Mp5rSwSRLRmLJ7qn17PKSxYbC/XV4lx3jup3KXk4P2HlHEfBs13oCJ2ByCeCqnKr
         JumDtpuJChnAwQ7ok/we1ZK/dTmu6PyF4iWDxSvMC1wYiaLnRnQWjhTWYNtscCsaFa
         amHiEF0KktOcA==
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
Subject: [PATCH v5 09/30] security: add get, remove and set acl hook
Date:   Tue, 18 Oct 2022 13:56:39 +0200
Message-Id: <20221018115700.166010-10-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7160; i=brauner@kernel.org; h=from:subject; bh=4OOmQnsCaeDP4fJEoDyIU04D/CDt7fJnSyahyBjuyFA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TVE7oC3f6q1pV9KaKbYmZpIX15sLMRxTEuKzZ4ryex1Z eGdpRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQElzIyHKvvs3s1QTHXhO1reFg+T5 juV0uvP0d1b0i+/iexal7vfUaGw8U2vzb6mv234o4/NG2nwrQpkbbMgkotTCaWr/rabKM4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    Paul Moore <paul@paul-moore.com>:
    - Add get, and remove acl hook
    
    /* v4 */
    unchanged
    
    /* v5 */
    unchanged

 include/linux/lsm_hook_defs.h |  6 ++++++
 include/linux/lsm_hooks.h     | 12 ++++++++++++
 include/linux/security.h      | 29 +++++++++++++++++++++++++++++
 security/security.c           | 25 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ec119da1d89b..7f4aaddce298 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -145,6 +145,12 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_removexattr, struct user_namespace *mnt_userns,
 	 struct dentry *dentry, const char *name)
+LSM_HOOK(int, 0, inode_set_acl, struct user_namespace *mnt_userns,
+	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
+LSM_HOOK(int, 0, inode_get_acl, struct user_namespace *mnt_userns,
+	 struct dentry *dentry, const char *acl_name)
+LSM_HOOK(int, 0, inode_remove_acl, struct user_namespace *mnt_userns,
+	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_killpriv, struct user_namespace *mnt_userns,
 	 struct dentry *dentry)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4ec80b96c22e..1d02d1170e21 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -435,6 +435,18 @@
  *	Check permission before removing the extended attribute
  *	identified by @name for @dentry.
  *	Return 0 if permission is granted.
+ * @inode_set_acl:
+ *	Check permission before setting posix acls
+ *	The posix acls in @kacl are identified by @acl_name.
+ *	Return 0 if permission is granted.
+ * @inode_get_acl:
+ *	Check permission before getting osix acls
+ *	The posix acls are identified by @acl_name.
+ *	Return 0 if permission is granted.
+ * @inode_remove_acl:
+ *	Check permission before removing posix acls
+ *	The posix acls are identified by @acl_name.
+ *	Return 0 if permission is granted.
  * @inode_getsecurity:
  *	Retrieve a copy of the extended attribute representation of the
  *	security label associated with @name for @inode via @buffer.  Note that
diff --git a/include/linux/security.h b/include/linux/security.h
index ca1b7109c0db..2bfc2e1ce51f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -361,6 +361,13 @@ int security_inode_getattr(const struct path *path);
 int security_inode_setxattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags);
+int security_inode_set_acl(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, const char *acl_name,
+			   struct posix_acl *kacl);
+int security_inode_get_acl(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, const char *acl_name);
+int security_inode_remove_acl(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, const char *acl_name);
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags);
 int security_inode_getxattr(struct dentry *dentry, const char *name);
@@ -872,6 +879,28 @@ static inline int security_inode_setxattr(struct user_namespace *mnt_userns,
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
+static inline int security_inode_get_acl(struct user_namespace *mnt_userns,
+					 struct dentry *dentry,
+					 const char *acl_name)
+{
+	return 0;
+}
+
+static inline int security_inode_remove_acl(struct user_namespace *mnt_userns,
+					    struct dentry *dentry,
+					    const char *acl_name)
+{
+	return 0;
+}
+
 static inline void security_inode_post_setxattr(struct dentry *dentry,
 		const char *name, const void *value, size_t size, int flags)
 { }
diff --git a/security/security.c b/security/security.c
index 79d82cb6e469..f972ee1f10eb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1372,6 +1372,31 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
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
+int security_inode_get_acl(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, const char *acl_name)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+	return call_int_hook(inode_get_acl, 0, mnt_userns, dentry, acl_name);
+}
+
+int security_inode_remove_acl(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, const char *acl_name)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+	return call_int_hook(inode_remove_acl, 0, mnt_userns, dentry, acl_name);
+}
+
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
-- 
2.34.1

