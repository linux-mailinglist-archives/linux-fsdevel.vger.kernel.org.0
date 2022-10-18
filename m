Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F7602ACB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJRL7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJRL6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:58:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E487BCBBB;
        Tue, 18 Oct 2022 04:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6FC8ACE1D2B;
        Tue, 18 Oct 2022 11:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB88C433D6;
        Tue, 18 Oct 2022 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094270;
        bh=zxEBeoNpcJ52F56qGFE68pwFXRvUhT9+M0PGMy9rgEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxpbv8lbxXalhuEPbU400UcefvDj3qrqmgKfI0sy15srU8NPBGcdXpMMI7TVHKF6W
         PddzcVeq1KBJM29NE0hd1lweWL4EZbOyUkt0qWM1PNWOZ7xNt6SRDcxSyNibI0Xqtf
         F+v2xoS0XpYurBqo9BxW3uhs/U7eyrH7LEqY63bR2OdYmYfGDLiuQ6WJGrPH3HVVIZ
         ADJe9o2s42sMMmLEwCPqWjIYCI+hc5scU54QsS5l47U2NQUjI/M8A3tGijev0RF9on
         YF2gdm/y1cRTBj4maYZf7SVU8kTsi93zHapWkZVBjaT6TZL2Iw/8klpZyCU4n/mOOv
         bl3ZnctHm2RYQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 12/30] integrity: implement get and set acl hook
Date:   Tue, 18 Oct 2022 13:56:42 +0200
Message-Id: <20221018115700.166010-13-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11599; i=brauner@kernel.org; h=from:subject; bh=zxEBeoNpcJ52F56qGFE68pwFXRvUhT9+M0PGMy9rgEY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TVFn3cfrE1Q8e9qN/IhjMw+uuPF8wpe/23y9fkw/s/fD 4iuMFh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT2azL8L/4SgyreaBjxCruDWWikp Kmso4xqf6XPq55epG1+OqMuniG/56r1giZZW2zfcll8bZiKzv3/Ua9TOM307ra9l9bafhwCxcA
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

I spent considerate time in the security module and integrity
infrastructure and audited all codepaths. EVM is the only part that
really has restrictions based on the actual posix acl values passed
through it (e.g., i_mode). Before this dedicated hook EVM used to translate
from the uapi posix acl format sent to it in the form of a void pointer
into the vfs format. This is not a good thing. Instead of hacking around in
the uapi struct give EVM the posix acls in the appropriate vfs format and
perform sane permissions checks that mirror what it used to to in the
generic xattr hook.

IMA doesn't have any restrictions on posix acls. When posix acls are
changed it just wants to update its appraisal status to trigger an EVM
revalidation.

The removal of posix acls is equivalent to passing NULL to the posix set
acl hooks. This is the same as before through the generic xattr api.

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
    
    /* v5 */
    Paul Moore <paul@paul-moore.com>:
    - Move ifdef out of function body.
    
    Mimi Zohar <zohar@linux.ibm.com>:
    - Fix details in commit message.
    - Add more details to kernel-doc for evm_inode_set_acl().

 include/linux/evm.h                   | 23 ++++++++
 include/linux/ima.h                   | 24 ++++++++
 security/integrity/evm/evm_main.c     | 83 ++++++++++++++++++++++++++-
 security/integrity/ima/ima_appraise.c |  9 +++
 security/security.c                   | 21 ++++++-
 5 files changed, 157 insertions(+), 3 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index aa63e0b3c0a2..86139be48992 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -35,6 +35,15 @@ extern int evm_inode_removexattr(struct user_namespace *mnt_userns,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name);
+extern int evm_inode_set_acl(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, const char *acl_name,
+			     struct posix_acl *kacl);
+static inline int evm_inode_remove_acl(struct user_namespace *mnt_userns,
+				       struct dentry *dentry,
+				       const char *acl_name)
+{
+	return evm_inode_set_acl(mnt_userns, dentry, acl_name, NULL);
+}
 extern int evm_inode_init_security(struct inode *inode,
 				   const struct xattr *xattr_array,
 				   struct xattr *evm);
@@ -108,6 +117,20 @@ static inline void evm_inode_post_removexattr(struct dentry *dentry,
 	return;
 }
 
+static inline int evm_inode_set_acl(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, const char *acl_name,
+				    struct posix_acl *kacl)
+{
+	return 0;
+}
+
+static inline int evm_inode_remove_acl(struct user_namespace *mnt_userns,
+				       struct dentry *dentry,
+				       const char *acl_name)
+{
+	return 0;
+}
+
 static inline int evm_inode_init_security(struct inode *inode,
 					  const struct xattr *xattr_array,
 					  struct xattr *evm)
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 81708ca0ebc7..5a0b2a285a18 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -187,6 +187,15 @@ extern void ima_inode_post_setattr(struct user_namespace *mnt_userns,
 				   struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
+extern int ima_inode_set_acl(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, const char *acl_name,
+			     struct posix_acl *kacl);
+static inline int ima_inode_remove_acl(struct user_namespace *mnt_userns,
+				       struct dentry *dentry,
+				       const char *acl_name)
+{
+	return ima_inode_set_acl(mnt_userns, dentry, acl_name, NULL);
+}
 extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
 #else
 static inline bool is_ima_appraise_enabled(void)
@@ -208,11 +217,26 @@ static inline int ima_inode_setxattr(struct dentry *dentry,
 	return 0;
 }
 
+static inline int ima_inode_set_acl(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, const char *acl_name,
+				    struct posix_acl *kacl)
+{
+
+	return 0;
+}
+
 static inline int ima_inode_removexattr(struct dentry *dentry,
 					const char *xattr_name)
 {
 	return 0;
 }
+
+static inline int ima_inode_remove_acl(struct user_namespace *mnt_userns,
+				       struct dentry *dentry,
+				       const char *acl_name)
+{
+	return 0;
+}
 #endif /* CONFIG_IMA_APPRAISE */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 23d484e05e6f..dcc5e704ef70 100644
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
@@ -670,6 +670,87 @@ int evm_inode_removexattr(struct user_namespace *mnt_userns,
 	return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
 }
 
+#ifdef CONFIG_FS_POSIX_ACL
+static int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, const char *name,
+				    struct posix_acl *kacl)
+{
+	int rc;
+
+	umode_t mode;
+	struct inode *inode = d_backing_inode(dentry);
+
+	if (!kacl)
+		return 1;
+
+	rc = posix_acl_update_mode(mnt_userns, inode, &mode, &kacl);
+	if (rc || (inode->i_mode != mode))
+		return 1;
+
+	return 0;
+}
+#else
+static inline int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
+					   struct dentry *dentry,
+					   const char *name,
+					   struct posix_acl *kacl)
+{
+	return 0;
+}
+#endif
+
+/**
+ * evm_inode_set_acl - protect the EVM extended attribute from posix acls
+ * @mnt_userns: user namespace of the idmapped mount
+ * @dentry: pointer to the affected dentry
+ * @acl_name: name of the posix acl
+ * @kacl: pointer to the posix acls
+ *
+ * Prevent modifying posix acls causing the EVM HMAC to be re-calculated
+ * and 'security.evm' xattr updated, unless the existing 'security.evm' is
+ * valid.
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
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3e0fbbd99534..3c9af3dc0713 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -774,6 +774,15 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 	return result;
 }
 
+int ima_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		      const char *acl_name, struct posix_acl *kacl)
+{
+	if (evm_revalidate_status(acl_name))
+		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+
+	return 0;
+}
+
 int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
 {
 	int result;
diff --git a/security/security.c b/security/security.c
index f972ee1f10eb..bdc295ad5fba 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1376,9 +1376,18 @@ int security_inode_set_acl(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl)
 {
+	int ret;
+
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_set_acl, 0, mnt_userns, dentry, acl_name, kacl);
+	ret = call_int_hook(inode_set_acl, 0, mnt_userns, dentry, acl_name,
+			    kacl);
+	if (ret)
+		return ret;
+	ret = ima_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
+	if (ret)
+		return ret;
+	return evm_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
 }
 
 int security_inode_get_acl(struct user_namespace *mnt_userns,
@@ -1392,9 +1401,17 @@ int security_inode_get_acl(struct user_namespace *mnt_userns,
 int security_inode_remove_acl(struct user_namespace *mnt_userns,
 			      struct dentry *dentry, const char *acl_name)
 {
+	int ret;
+
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_remove_acl, 0, mnt_userns, dentry, acl_name);
+	ret = call_int_hook(inode_remove_acl, 0, mnt_userns, dentry, acl_name);
+	if (ret)
+		return ret;
+	ret = ima_inode_remove_acl(mnt_userns, dentry, acl_name);
+	if (ret)
+		return ret;
+	return evm_inode_remove_acl(mnt_userns, dentry, acl_name);
 }
 
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
-- 
2.34.1

