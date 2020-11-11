Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA062AED83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 10:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgKKJZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 04:25:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2086 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgKKJZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:25:14 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CWK602vCQz67DcY;
        Wed, 11 Nov 2020 17:23:20 +0800 (CST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.161)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 11 Nov 2020 10:25:12 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 05/11] evm: Introduce evm_status_revalidate()
Date:   Wed, 11 Nov 2020 10:22:56 +0100
Message-ID: <20201111092302.1589-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
In-Reply-To: <20201111092302.1589-1-roberto.sassu@huawei.com>
References: <20201111092302.1589-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.161]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When EVM_ALLOW_METADATA_WRITES is set, EVM allows any operation on
metadata. Its main purpose is to allow users to freely set metadata when it
is protected by a portable signature, until an HMAC key is loaded.

However, callers of evm_verifyxattr() are not notified about metadata
changes and continue to rely on the last status returned by the function.
For example IMA, since it caches the appraisal result, will not call again
evm_verifyxattr() until the appraisal flags are cleared, and will grant
access to the file even if there was a metadata operation that made the
portable signature invalid.

This patch introduces evm_status_revalidate(), which callers of
evm_verifyxattr() can use in their xattr post hooks to determine whether
re-validation is necessary and to do the proper actions. IMA calls it in
its xattr post hooks to reset the appraisal flags, so that the EVM status
is re-evaluated after a metadata operation.

Lastly, this patch also adds a call to evm_reset_status() in
evm_inode_post_setattr() to invalidate the cached EVM status after a
setattr operation.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/evm.h                   |  6 +++++
 security/integrity/evm/evm_main.c     | 33 +++++++++++++++++++++++----
 security/integrity/ima/ima_appraise.c |  8 ++++---
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 8302bc29bb35..e5b7bcb152b9 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -35,6 +35,7 @@ extern void evm_inode_post_removexattr(struct dentry *dentry,
 extern int evm_inode_init_security(struct inode *inode,
 				   const struct xattr *xattr_array,
 				   struct xattr *evm);
+extern bool evm_status_revalidate(const char *xattr_name);
 #ifdef CONFIG_FS_POSIX_ACL
 extern int posix_xattr_acl(const char *xattrname);
 #else
@@ -104,5 +105,10 @@ static inline int evm_inode_init_security(struct inode *inode,
 	return 0;
 }
 
+static inline bool evm_status_revalidate(const char *xattr_name)
+{
+	return false;
+}
+
 #endif /* CONFIG_EVM */
 #endif /* LINUX_EVM_H */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 001e001eae01..b38ffa39faa8 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -425,6 +425,30 @@ static void evm_reset_status(struct inode *inode)
 		iint->evm_status = INTEGRITY_UNKNOWN;
 }
 
+/**
+ * evm_status_revalidate - report whether EVM status re-validation is necessary
+ * @xattr_name: pointer to the affected extended attribute name
+ *
+ * Report whether callers of evm_verifyxattr() should re-validate the
+ * EVM status.
+ *
+ * Return true if re-validation is necessary, false otherwise.
+ */
+bool evm_status_revalidate(const char *xattr_name)
+{
+	if (!evm_key_loaded())
+		return false;
+
+	/* evm_inode_post_setattr() passes NULL */
+	if (!xattr_name)
+		return true;
+
+	if (!evm_protected_xattr(xattr_name) && !posix_xattr_acl(xattr_name))
+		return false;
+
+	return true;
+}
+
 /**
  * evm_inode_post_setxattr - update 'security.evm' to reflect the changes
  * @dentry: pointer to the affected dentry
@@ -441,8 +465,7 @@ static void evm_reset_status(struct inode *inode)
 void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 			     const void *xattr_value, size_t xattr_value_len)
 {
-	if (!evm_key_loaded() || (!evm_protected_xattr(xattr_name)
-				  && !posix_xattr_acl(xattr_name)))
+	if (!evm_status_revalidate(xattr_name))
 		return;
 
 	evm_reset_status(dentry->d_inode);
@@ -462,7 +485,7 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
  */
 void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 {
-	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
+	if (!evm_status_revalidate(xattr_name))
 		return;
 
 	evm_reset_status(dentry->d_inode);
@@ -513,9 +536,11 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
  */
 void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 {
-	if (!evm_key_loaded())
+	if (!evm_status_revalidate(NULL))
 		return;
 
+	evm_reset_status(dentry->d_inode);
+
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
 		evm_update_evmxattr(dentry, NULL, NULL, 0);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 77c01f50425e..7b13ba543873 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -583,13 +583,15 @@ void ima_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 			     const void *xattr_value, size_t xattr_value_len)
 {
 	const struct evm_ima_xattr_data *xvalue = xattr_value;
+	int digsig = 0;
 	int result;
 
 	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
 				   xattr_value_len);
 	if (result == 1)
-		ima_reset_appraise_flags(d_backing_inode(dentry),
-			xvalue->type == EVM_IMA_XATTR_DIGSIG);
+		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
+	if (result == 1 || evm_status_revalidate(xattr_name))
+		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 }
 
 void ima_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
@@ -597,6 +599,6 @@ void ima_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 	int result;
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
-	if (result == 1)
+	if (result == 1 || evm_status_revalidate(xattr_name))
 		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
 }
-- 
2.27.GIT

