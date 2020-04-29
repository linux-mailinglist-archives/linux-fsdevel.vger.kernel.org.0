Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B336F1BD64C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 09:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgD2HmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 03:42:14 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbgD2HmM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:42:12 -0400
Received: from lhreml708-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 779649403968A3C98473;
        Wed, 29 Apr 2020 08:42:10 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml708-chm.china.huawei.com (10.201.108.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 29 Apr 2020 08:42:10 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Wed, 29 Apr 2020 09:42:09 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <david.safford@gmail.com>,
        <viro@zeniv.linux.org.uk>, <jmorris@namei.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 2/3] evm: Extend API of post hooks to pass the result of pre hooks
Date:   Wed, 29 Apr 2020 09:39:34 +0200
Message-ID: <20200429073935.11913-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429073935.11913-1-roberto.sassu@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch extends the API of post hooks to pass the result returned by the
pre hooks. Given that now this information is available, post hooks can
stop before updating the HMAC if the result of the pre hook is not zero.

They still reset the result of the last verification, stored in the
integrity_iint_cache, to ensure that file metadata are re-evaluated after
update.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/attr.c                         |  2 +-
 fs/xattr.c                        | 49 ++++++++++++++++++-------------
 include/linux/evm.h               | 18 ++++++++----
 security/integrity/evm/evm_main.c | 21 +++++++++++--
 4 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 8f26d7d2e3b4..6ce60e1eba34 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -343,7 +343,7 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
 		ima_inode_post_setattr(dentry);
-		evm_inode_post_setattr(dentry, ia_valid);
+		evm_inode_post_setattr(dentry, ia_valid, evm_error);
 	}
 
 	return error;
diff --git a/fs/xattr.c b/fs/xattr.c
index 3b323b75b741..b1fd2aa481a8 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -151,24 +151,8 @@ __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 }
 EXPORT_SYMBOL(__vfs_setxattr);
 
-/**
- *  __vfs_setxattr_noperm - perform setxattr operation without performing
- *  permission checks.
- *
- *  @dentry - object to perform setxattr on
- *  @name - xattr name to set
- *  @value - value to set @name to
- *  @size - size of @value
- *  @flags - flags to pass into filesystem operations
- *
- *  returns the result of the internal setxattr or setsecurity operations.
- *
- *  This function requires the caller to lock the inode's i_mutex before it
- *  is executed. It also assumes that the caller will make the appropriate
- *  permission checks.
- */
-int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags)
+static int __vfs_setxattr_noperm_evm(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags, int evm_error)
 {
 	struct inode *inode = dentry->d_inode;
 	int error = -EAGAIN;
@@ -183,7 +167,8 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 			fsnotify_xattr(dentry);
 			security_inode_post_setxattr(dentry, name, value,
 						     size, flags);
-			evm_inode_post_setxattr(dentry, name, value, size);
+			evm_inode_post_setxattr(dentry, name, value, size,
+						evm_error);
 		}
 	} else {
 		if (unlikely(is_bad_inode(inode)))
@@ -205,6 +190,27 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	return error;
 }
 
+/**
+ *  __vfs_setxattr_noperm - perform setxattr operation without performing
+ *  permission checks.
+ *
+ *  @dentry - object to perform setxattr on
+ *  @name - xattr name to set
+ *  @value - value to set @name to
+ *  @size - size of @value
+ *  @flags - flags to pass into filesystem operations
+ *
+ *  returns the result of the internal setxattr or setsecurity operations.
+ *
+ *  This function requires the caller to lock the inode's i_mutex before it
+ *  is executed. It also assumes that the caller will make the appropriate
+ *  permission checks.
+ */
+int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags)
+{
+	return __vfs_setxattr_noperm_evm(dentry, name, value, size, flags, 0);
+}
 
 int
 vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
@@ -228,7 +234,8 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		goto out;
 	}
 
-	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
+	error = __vfs_setxattr_noperm_evm(dentry, name, value, size, flags,
+					  evm_error);
 
 out:
 	inode_unlock(inode);
@@ -410,7 +417,7 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 
 	if (!error) {
 		fsnotify_xattr(dentry);
-		evm_inode_post_removexattr(dentry, name);
+		evm_inode_post_removexattr(dentry, name, evm_error);
 	}
 
 out:
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 8302bc29bb35..cc23d2248d3e 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -22,16 +22,19 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     size_t xattr_value_len,
 					     struct integrity_iint_cache *iint);
 extern int evm_inode_setattr(struct dentry *dentry, struct iattr *attr);
-extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
+extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid,
+				   int evm_pre_error);
 extern int evm_inode_setxattr(struct dentry *dentry, const char *name,
 			      const void *value, size_t size);
 extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
-				    size_t xattr_value_len);
+				    size_t xattr_value_len,
+				    int evm_pre_error);
 extern int evm_inode_removexattr(struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
-				       const char *xattr_name);
+				       const char *xattr_name,
+				       int evm_pre_error);
 extern int evm_inode_init_security(struct inode *inode,
 				   const struct xattr *xattr_array,
 				   struct xattr *evm);
@@ -66,7 +69,8 @@ static inline int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	return 0;
 }
 
-static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
+static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid,
+					  int evm_pre_error)
 {
 	return;
 }
@@ -80,7 +84,8 @@ static inline int evm_inode_setxattr(struct dentry *dentry, const char *name,
 static inline void evm_inode_post_setxattr(struct dentry *dentry,
 					   const char *xattr_name,
 					   const void *xattr_value,
-					   size_t xattr_value_len)
+					   size_t xattr_value_len,
+					   int evm_pre_error)
 {
 	return;
 }
@@ -92,7 +97,8 @@ static inline int evm_inode_removexattr(struct dentry *dentry,
 }
 
 static inline void evm_inode_post_removexattr(struct dentry *dentry,
-					      const char *xattr_name)
+					      const char *xattr_name,
+					      int evm_pre_error)
 {
 	return;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index d361d7fdafc4..ca9eaef7058b 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -422,6 +422,7 @@ static void evm_reset_status(struct inode *inode)
  * @xattr_name: pointer to the affected extended attribute name
  * @xattr_value: pointer to the new extended attribute value
  * @xattr_value_len: pointer to the new extended attribute value length
+ * @evm_pre_error: error returned by evm_inode_setxattr()
  *
  * Update the HMAC stored in 'security.evm' to reflect the change.
  *
@@ -430,7 +431,8 @@ static void evm_reset_status(struct inode *inode)
  * i_mutex lock.
  */
 void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
-			     const void *xattr_value, size_t xattr_value_len)
+			     const void *xattr_value, size_t xattr_value_len,
+			     int evm_pre_error)
 {
 	if (!evm_key_loaded() || (!evm_protected_xattr(xattr_name)
 				  && !posix_xattr_acl(xattr_name)))
@@ -438,6 +440,9 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 
 	evm_reset_status(dentry->d_inode);
 
+	if (evm_pre_error)
+		return;
+
 	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
 }
 
@@ -445,19 +450,24 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
  * evm_inode_post_removexattr - update 'security.evm' after removing the xattr
  * @dentry: pointer to the affected dentry
  * @xattr_name: pointer to the affected extended attribute name
+ * @evm_pre_error: error returned by evm_inode_removexattr()
  *
  * Update the HMAC stored in 'security.evm' to reflect removal of the xattr.
  *
  * No need to take the i_mutex lock here, as this function is called from
  * vfs_removexattr() which takes the i_mutex.
  */
-void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
+void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name,
+				int evm_pre_error)
 {
 	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
 		return;
 
 	evm_reset_status(dentry->d_inode);
 
+	if (evm_pre_error)
+		return;
+
 	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
 }
 
@@ -495,6 +505,7 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
  * evm_inode_post_setattr - update 'security.evm' after modifying metadata
  * @dentry: pointer to the affected dentry
  * @ia_valid: for the UID and GID status
+ * @evm_pre_error: error returned by evm_inode_setattr()
  *
  * For now, update the HMAC stored in 'security.evm' to reflect UID/GID
  * changes.
@@ -502,11 +513,15 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
+void evm_inode_post_setattr(struct dentry *dentry, int ia_valid,
+			    int evm_pre_error)
 {
 	if (!evm_key_loaded())
 		return;
 
+	if (evm_pre_error)
+		return;
+
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
 		evm_update_evmxattr(dentry, NULL, NULL, 0);
 }
-- 
2.17.1

