Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4343B356A81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351658AbhDGKyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 06:54:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2792 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhDGKyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:54:33 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFgyD0XNdz686tC;
        Wed,  7 Apr 2021 18:44:52 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 12:54:21 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 08/12] evm: Pass user namespace to set/remove xattr hooks
Date:   Wed, 7 Apr 2021 12:52:48 +0200
Message-ID: <20210407105252.30721-9-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210407105252.30721-1-roberto.sassu@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for 'evm: Allow setxattr() and setattr() for unmodified
metadata', this patch passes mnt_userns to the inode set/remove xattr hooks
so that the GID of the inode on an idmapped mount is correctly determined
by posix_acl_update_mode().

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/evm.h               | 12 ++++++++----
 security/integrity/evm/evm_main.c | 17 +++++++++++------
 security/security.c               |  4 ++--
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index e5b7bcb152b9..8cad46bcec9d 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -23,13 +23,15 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     struct integrity_iint_cache *iint);
 extern int evm_inode_setattr(struct dentry *dentry, struct iattr *attr);
 extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
-extern int evm_inode_setxattr(struct dentry *dentry, const char *name,
+extern int evm_inode_setxattr(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, const char *name,
 			      const void *value, size_t size);
 extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
 				    size_t xattr_value_len);
-extern int evm_inode_removexattr(struct dentry *dentry, const char *xattr_name);
+extern int evm_inode_removexattr(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name);
 extern int evm_inode_init_security(struct inode *inode,
@@ -72,7 +74,8 @@ static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 	return;
 }
 
-static inline int evm_inode_setxattr(struct dentry *dentry, const char *name,
+static inline int evm_inode_setxattr(struct user_namespace *mnt_userns,
+				     struct dentry *dentry, const char *name,
 				     const void *value, size_t size)
 {
 	return 0;
@@ -86,7 +89,8 @@ static inline void evm_inode_post_setxattr(struct dentry *dentry,
 	return;
 }
 
-static inline int evm_inode_removexattr(struct dentry *dentry,
+static inline int evm_inode_removexattr(struct user_namespace *mnt_userns,
+					struct dentry *dentry,
 					const char *xattr_name)
 {
 	return 0;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index eab536fa260f..74f9f3a2ae53 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -340,7 +340,8 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
  * For posix xattr acls only, permit security.evm, even if it currently
  * doesn't exist, to be updated unless the EVM signature is immutable.
  */
-static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
+static int evm_protect_xattr(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, const char *xattr_name,
 			     const void *xattr_value, size_t xattr_value_len)
 {
 	enum integrity_status evm_status;
@@ -398,6 +399,7 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 
 /**
  * evm_inode_setxattr - protect the EVM extended attribute
+ * @mnt_userns: user namespace of the idmapped mount
  * @dentry: pointer to the affected dentry
  * @xattr_name: pointer to the affected extended attribute name
  * @xattr_value: pointer to the new extended attribute value
@@ -409,8 +411,9 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
  * userspace from writing HMAC value.  Writing 'security.evm' requires
  * requires CAP_SYS_ADMIN privileges.
  */
-int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
-		       const void *xattr_value, size_t xattr_value_len)
+int evm_inode_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		       const char *xattr_name, const void *xattr_value,
+		       size_t xattr_value_len)
 {
 	const struct evm_ima_xattr_data *xattr_data = xattr_value;
 
@@ -427,19 +430,21 @@ int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
 			return -EPERM;
 	}
-	return evm_protect_xattr(dentry, xattr_name, xattr_value,
+	return evm_protect_xattr(mnt_userns, dentry, xattr_name, xattr_value,
 				 xattr_value_len);
 }
 
 /**
  * evm_inode_removexattr - protect the EVM extended attribute
+ * @mnt_userns: user namespace of the idmapped mount
  * @dentry: pointer to the affected dentry
  * @xattr_name: pointer to the affected extended attribute name
  *
  * Removing 'security.evm' requires CAP_SYS_ADMIN privileges and that
  * the current value is valid.
  */
-int evm_inode_removexattr(struct dentry *dentry, const char *xattr_name)
+int evm_inode_removexattr(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, const char *xattr_name)
 {
 	/* Policy permits modification of the protected xattrs even though
 	 * there's no HMAC key loaded
@@ -447,7 +452,7 @@ int evm_inode_removexattr(struct dentry *dentry, const char *xattr_name)
 	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
 		return 0;
 
-	return evm_protect_xattr(dentry, xattr_name, NULL, 0);
+	return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
 }
 
 static void evm_reset_status(struct inode *inode)
diff --git a/security/security.c b/security/security.c
index efb1f874dc41..7f14e59c4f8e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1310,7 +1310,7 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
 	ret = ima_inode_setxattr(dentry, name, value, size);
 	if (ret)
 		return ret;
-	return evm_inode_setxattr(dentry, name, value, size);
+	return evm_inode_setxattr(mnt_userns, dentry, name, value, size);
 }
 
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
@@ -1356,7 +1356,7 @@ int security_inode_removexattr(struct user_namespace *mnt_userns,
 	ret = ima_inode_removexattr(dentry, name);
 	if (ret)
 		return ret;
-	return evm_inode_removexattr(dentry, name);
+	return evm_inode_removexattr(mnt_userns, dentry, name);
 }
 
 int security_inode_need_killpriv(struct dentry *dentry)
-- 
2.26.2

