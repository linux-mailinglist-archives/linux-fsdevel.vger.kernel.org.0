Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1C5EAAAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiIZPYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiIZPXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3FE895CE;
        Mon, 26 Sep 2022 07:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF6960DCB;
        Mon, 26 Sep 2022 14:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC11C433D6;
        Mon, 26 Sep 2022 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201357;
        bh=nl1i991MblUNHLpQmd0aXp6JekgwWKpVmd622eCnFik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqxXRB7fLSPf/LhYaBYCSE2whhM4B9vvdNp14rWfX+71fkbscxq1YZ4XaJPxWLQFq
         xELRekmTiSerxdZnRgrJF/9ItSQarCmtqHrHBiFq+nc9nuuP6sD3LTrm9YELIT6cKz
         PEbZB8RpSsWQkKmSJUA9K6lxTc/cG4L0eYnoeLKkKOACQ15SFPosry/Ql0gMynmf/D
         wqWemRlFLiQ3wSYcVEBeclWqKX0UVbla6Gx06Md2o17+matr8Dz7GEVGkqwnLRyq9r
         BluHbUgrz6celIc9dGgrHy2v1aLrdvYqo76OAREhZ8za35lM7fW2I8mZShW3cTSQ81
         ZeOEE+qNH5JcQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 13/30] evm: implement set acl hook
Date:   Mon, 26 Sep 2022 16:08:10 +0200
Message-Id: <20220926140827.142806-14-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6863; i=brauner@kernel.org; h=from:subject; bh=nl1i991MblUNHLpQmd0aXp6JekgwWKpVmd622eCnFik=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnJgs2X5sCN51oGV0neL7MRSpvw8tfSK2Zk/C6yL4tXn LM553FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRjRMYGRrWGt+/INq4tcU4XbTNUO FX3orm6UWLr9zfrCC0jK8u/RDDfxe+6jvNc4uFTr8z+bnSL50tS6Otzcix6t/S7A//TyUF8QIA
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

Notes:
    /* v2 */
    unchanged

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

