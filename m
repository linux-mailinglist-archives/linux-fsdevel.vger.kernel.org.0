Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6535EE164
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiI1QNj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiI1QNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:13:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C6396FF1;
        Wed, 28 Sep 2022 09:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0D3461F29;
        Wed, 28 Sep 2022 16:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7DDC433D7;
        Wed, 28 Sep 2022 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381601;
        bh=4rZdwFtSQG2QKwWsuW858MHTw3Eht5G7s1fQQA7XZVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bG5xkaMQ/r/nt/Hms/V2iduapj/W6chicOPo+Wd1UCJdGRwMSq0k2NLsqgUfAGCW0
         /jkefnbjQE/JUooycXcqaQAxVw0nA8GAHXwOUrIvCCPZb7Mtir0I9RUKYGUk8p0zlc
         5XD7H1LJi1UUXvKua5Wc7Oa+bz8SuvkA6LHoKgFF4W8BwkQiHONOjGsqQ0Q/YA1kxV
         rJ+wb1DCPuvx6qnspOancPPiRVh1pl/Xi5aj26QjpOKRlkh2LXuuiMgsgRaEio8mgK
         ymkd3o4L6UKSWlaNjY7ANA2/4pQzB08tZJSm11LAgWRLbBFBBs+60Dv9U0gLXGOeCh
         42mvdT0b6H8ZQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 12/29] integrity: implement get and set acl hook
Date:   Wed, 28 Sep 2022 18:08:26 +0200
Message-Id: <20220928160843.382601-13-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928160843.382601-1-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10861; i=brauner@kernel.org; h=from:subject; bh=4rZdwFtSQG2QKwWsuW858MHTw3Eht5G7s1fQQA7XZVM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSbFNZsVGSakyl/6LyNcd2RKbObahy1r3Aeexx8667axH31 Sls0OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay+iQjw3wGIZ3aDkd5w7SF7WZJXN 0+RTo1PpZhLi9s/tsdZQ7QZ2T4xLDfxc6TYctDo0spt6wOrvze+7np6b7JxzadX2XU/caNHQA=
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

IMA doesn't have any restrictions on posix acls. When posix acls are
changed it just wants to update its appraisal status.

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

 include/linux/evm.h                   | 23 +++++++++
 include/linux/ima.h                   | 21 ++++++++
 security/integrity/evm/evm_main.c     | 70 ++++++++++++++++++++++++++-
 security/integrity/ima/ima_appraise.c |  9 ++++
 security/security.c                   | 21 +++++++-
 5 files changed, 141 insertions(+), 3 deletions(-)

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
index 81708ca0ebc7..ad4353947cdf 100644
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
@@ -208,11 +217,23 @@ static inline int ima_inode_setxattr(struct dentry *dentry,
 	return 0;
 }
 
+static inline int ima_inode_set_acl(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, const char *acl_name,
+				    struct posix_acl *kacl)
+{
+}
+
 static inline int ima_inode_removexattr(struct dentry *dentry,
 					const char *xattr_name)
 {
 	return 0;
 }
+
+static inline ima_inode_remove_acl(struct user_namespace *mnt_userns,
+				   struct dentry *dentry, const char *acl_name)
+{
+	return 0;
+}
 #endif /* CONFIG_IMA_APPRAISE */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 23d484e05e6f..7904786b610f 100644
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
@@ -670,6 +670,74 @@ int evm_inode_removexattr(struct user_namespace *mnt_userns,
 	return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
 }
 
+static int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
+				    struct dentry *dentry, const char *name,
+				    struct posix_acl *kacl)
+{
+#ifdef CONFIG_FS_POSIX_ACL
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
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index bde74fcecee3..698a8ae2fe3e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -770,6 +770,15 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
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
index 0fc9aff39f63..f28725a06f94 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1374,9 +1374,18 @@ int security_inode_set_acl(struct user_namespace *mnt_userns,
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
@@ -1390,9 +1399,17 @@ int security_inode_get_acl(struct user_namespace *mnt_userns,
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

