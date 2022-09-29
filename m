Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEEC5EF8D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiI2Pcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiI2Pbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:31:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F959E12B;
        Thu, 29 Sep 2022 08:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43908618D7;
        Thu, 29 Sep 2022 15:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B35C43470;
        Thu, 29 Sep 2022 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465477;
        bh=3tmqMtDgsN+ovzKO78lMyP3Qqi7CkzX4In4A7ZVKkhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9crareObMkgOgNwRaR6uId/nv3O4PDbaCRXfRK8k2YWbQFAJNhjPcS2W/n8yLvPw
         XMcQ2RuCOi06zAIE14uYr7ATFHsqUnDYKv15Ex7LZ74IrW1mhAH4CxSol+HP4cKXFj
         QyTPDXIp1hNxTvFdFCdMfIfj2gppGYtX4DY82s5w6kAzSPXJ1AJn1DPAVt+ZTYhBy9
         gcl1TKe7fJoP1PkpA5u5zEJOTKYeXBEYFCfCrH36NaeEO2+6Qrrxm4SM+Z7WB1txAP
         6TmUu4PKXeMNMLrB3k5DkNUl51BVbTIrhQDm2WOmFPlv5+AuW6CHhBc4cUEXs2HdIp
         jqvDNLgs+by3Q==
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
Subject: [PATCH v4 09/30] security: add get, remove and set acl hook
Date:   Thu, 29 Sep 2022 17:30:19 +0200
Message-Id: <20220929153041.500115-10-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7081; i=brauner@kernel.org; h=from:subject; bh=3tmqMtDgsN+ovzKO78lMyP3Qqi7CkzX4In4A7ZVKkhs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hI2+lZ4y/TMde3Mxe/mVp/V37uAy0pgl6PzFI//BTqy 73+d7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI3A6Gv+LLeGfmLU09FuV6PoDnnE vFXZ7tE86/edtsdH71HikX2TuMDKs3Zdcq3Zx4qt3qVSV3Xqx0nd8ZXu8V6lKvpxfwsnItZgAA
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
    
    /* v3 */
    Paul Moore <paul@paul-moore.com>:
    - Add get, and remove acl hook
    
    /* v4 */
    unchanged

 include/linux/lsm_hook_defs.h |  6 ++++++
 include/linux/lsm_hooks.h     | 12 ++++++++++++
 include/linux/security.h      | 29 +++++++++++++++++++++++++++++
 security/security.c           | 25 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 806448173033..dd388f968ba2 100644
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
index 84a0d7e02176..5a1502ee54ea 100644
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
index 1bc362cb413f..d9a6ae49f349 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -359,6 +359,13 @@ int security_inode_getattr(const struct path *path);
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
@@ -869,6 +876,28 @@ static inline int security_inode_setxattr(struct user_namespace *mnt_userns,
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
index 14d30fec8a00..0fc9aff39f63 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1370,6 +1370,31 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
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

