Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9905E66DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiIVPT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiIVPSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168B1EFA57;
        Thu, 22 Sep 2022 08:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C3C363612;
        Thu, 22 Sep 2022 15:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F647C43470;
        Thu, 22 Sep 2022 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663859895;
        bh=ujPB5s/Do8hrW678Ebss/hT/avh823uI3RKvBVKupd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6XEFLJ9cZxDhFAmP1cf/wmnPrH7Oyj0g7nOduYhrq1hEIfSWPj61J8UOYTczsrLq
         w/RYwhSx7lFED2CGJ1IgF7LFGAayDCydmSM9bDg5e7T6HQRJtmAPCQAE1+u9d6C6lt
         JBvwf5jo5e921DExT8wYHpHA+tUXxl4QHYASvNK2W2Vfu4OAQfeoDI+LItp4ch8B4+
         geWHP5fj0Bs52FdNBS1lxBk33ppN/Mw7DeC0y/j4uZe+VoDDTkAbC9K3vJj3Sd17Hr
         KGU0YOkOIo4rG9UFysboP77XKW0f23Pm1pJuZsHPNJJ0LjixkhoAPSyDahb1jIDAbQ
         0dHj1ZZNxd4TQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 12/29] evm: implement set acl hook
Date:   Thu, 22 Sep 2022 17:17:10 +0200
Message-Id: <20220922151728.1557914-13-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6822; i=brauner@kernel.org; h=from:subject; bh=ujPB5s/Do8hrW678Ebss/hT/avh823uI3RKvBVKupd4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTr1FT+vHayTPVTmvm+3xzS+ku2bvM9LfHg+G2d4LMSnItT Ow4odJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkbRcjw/VTzm/fRxxSrXBK968vnZ j//e08W5ZtscwbryyzMJUP02ZkaKw78cR9z9YJ4hHyx/7843FRL9wWYfEnoe9RZKfMrhvf2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

I spent considerate time in the security module and integrity
infrastructure and audited all codepaths. EVM is the only part that
really has restrictions based on the actual posix acl values passed
through it. Before this dedicated hook EVM used to translate from the
uapi posix acl format sent to it in the form of a void pointer into the
vfs format. This is not a good thing. Instead of hacking around in the
uapi struct give EVM the posix acls in the appropriate vfs format and
perform sane permissions checks that mirror what it used to to in the
generic xattr hook.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 include/linux/evm.h               | 10 +++++
 security/integrity/evm/evm_main.c | 66 ++++++++++++++++++++++++++++++-
 security/security.c               |  9 ++++-
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index aa63e0b3c0a2..aebcfd47d496 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -35,6 +35,9 @@ extern int evm_inode_removexattr(struct user_namespace *mnt_userns,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name);
+extern int evm_inode_set_acl(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, const char *acl_name,
+			     struct posix_acl *kacl);
 extern int evm_inode_init_security(struct inode *inode,
 				   const struct xattr *xattr_array,
 				   struct xattr *evm);
@@ -108,6 +111,13 @@ static inline void evm_inode_post_removexattr(struct dentry *dentry,
 	return;
 }
 
+static inline int evm_inode_set_acl(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, const char *acl_name,
+				    struct posix_acl *kacl)
+{
+	return 0;
+}
+
 static inline int evm_inode_init_security(struct inode *inode,
 					  const struct xattr *xattr_array,
 					  struct xattr *evm)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 23d484e05e6f..15aa5995fff4 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -8,7 +8,7 @@
  *
  * File: evm_main.c
  *	implements evm_inode_setxattr, evm_inode_post_setxattr,
- *	evm_inode_removexattr, and evm_verifyxattr
+ *	evm_inode_removexattr, evm_verifyxattr, and evm_inode_set_acl.
  */
 
 #define pr_fmt(fmt) "EVM: "fmt
@@ -670,6 +670,70 @@ int evm_inode_removexattr(struct user_namespace *mnt_userns,
 	return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
 }
 
+static int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, const char *name,
+				    struct posix_acl *kacl)
+{
+#ifdef CONFIG_FS_POSIX_ACL
+	int rc;
+	umode_t mode;
+	struct inode *inode = d_backing_inode(dentry);
+
+	rc = posix_acl_update_mode(mnt_userns, inode, &mode, &kacl);
+	if (rc || (inode->i_mode != mode))
+		return 1;
+#endif
+	return 0;
+}
+
+/**
+ * evm_inode_set_acl - protect the EVM extended attribute for posix acls
+ * @mnt_userns: user namespace of the idmapped mount
+ * @dentry: pointer to the affected dentry
+ * @acl_name: name of the posix acl
+ * @kacl: pointer to the posix acls
+ */
+int evm_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		      const char *acl_name, struct posix_acl *kacl)
+{
+	enum integrity_status evm_status;
+
+	/* Policy permits modification of the protected xattrs even though
+	 * there's no HMAC key loaded
+	 */
+	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
+		return 0;
+
+	evm_status = evm_verify_current_integrity(dentry);
+	if ((evm_status == INTEGRITY_PASS) ||
+	    (evm_status == INTEGRITY_NOXATTRS))
+		return 0;
+
+	/* Exception if the HMAC is not going to be calculated. */
+	if (evm_hmac_disabled() && (evm_status == INTEGRITY_NOLABEL ||
+	    evm_status == INTEGRITY_UNKNOWN))
+		return 0;
+
+	/*
+	 * Writing other xattrs is safe for portable signatures, as portable
+	 * signatures are immutable and can never be updated.
+	 */
+	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
+		return 0;
+
+	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
+	    !evm_inode_set_acl_change(mnt_userns, dentry, acl_name, kacl))
+		return 0;
+
+	if (evm_status != INTEGRITY_PASS &&
+	    evm_status != INTEGRITY_PASS_IMMUTABLE)
+		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
+				    dentry->d_name.name, "appraise_metadata",
+				    integrity_status_msg[evm_status],
+				    -EPERM, 0);
+	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
+}
+
 static void evm_reset_status(struct inode *inode)
 {
 	struct integrity_iint_cache *iint;
diff --git a/security/security.c b/security/security.c
index 56d48e7254d6..a12a26a4494e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1374,9 +1374,16 @@ int security_inode_set_acl(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl)
 {
+	int ret;
+
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_set_acl, 0, mnt_userns, dentry, acl_name, kacl);
+
+	ret = call_int_hook(inode_set_acl, 0, mnt_userns, dentry, acl_name, kacl);
+	if (ret)
+		return ret;
+
+	return evm_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
 }
 
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
-- 
2.34.1

