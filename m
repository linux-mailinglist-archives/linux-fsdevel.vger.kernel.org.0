Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F48C36C55E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhD0Ljs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 07:39:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2930 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhD0Ljr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:39:47 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FV05203t2z6yhmp;
        Tue, 27 Apr 2021 19:33:26 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 13:39:01 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jmorris@namei.org>, <paul@paul-moore.com>,
        <casey@schaufler-ca.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <reiserfs-devel@vger.kernel.org>, <selinux@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 5/6] evm: Align evm_inode_init_security() definition with LSM infrastructure
Date:   Tue, 27 Apr 2021 13:37:31 +0200
Message-ID: <20210427113732.471066-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427113732.471066-1-roberto.sassu@huawei.com>
References: <20210427113732.471066-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch changes the evm_inode_init_security() definition to align with
the LSM infrastructure, in preparation for moving IMA and EVM to that
infrastructure.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/evm.h               | 19 ++++++++++++-------
 security/integrity/evm/evm_main.c | 19 +++++++++++++------
 security/security.c               |  6 +++---
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 8cad46bcec9d..8b1c36c19e97 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -34,9 +34,10 @@ extern int evm_inode_removexattr(struct user_namespace *mnt_userns,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name);
-extern int evm_inode_init_security(struct inode *inode,
-				   const struct xattr *xattr_array,
-				   struct xattr *evm);
+extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
+				   const struct qstr *qstr,
+				   struct xattr *xattrs, int *base_slot,
+				   void *fs_data);
 extern bool evm_status_revalidate(const char *xattr_name);
 #ifdef CONFIG_FS_POSIX_ACL
 extern int posix_xattr_acl(const char *xattrname);
@@ -102,11 +103,15 @@ static inline void evm_inode_post_removexattr(struct dentry *dentry,
 	return;
 }
 
-static inline int evm_inode_init_security(struct inode *inode,
-					  const struct xattr *xattr_array,
-					  struct xattr *evm)
+static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
+					  const struct qstr *qstr,
+					  struct xattr *xattrs, int *base_slot,
+					  void *fs_data)
 {
-	return 0;
+	if (!xattrs || !xattrs->name)
+		return 0;
+
+	return -EOPNOTSUPP;
 }
 
 static inline bool evm_status_revalidate(const char *xattr_name)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 84a9b7a69b1f..d647bfd0adcd 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -17,6 +17,7 @@
 #include <linux/xattr.h>
 #include <linux/integrity.h>
 #include <linux/evm.h>
+#include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 #include <linux/posix_acl_xattr.h>
 
@@ -706,23 +707,29 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 /*
  * evm_inode_init_security - initializes security.evm HMAC value
  */
-int evm_inode_init_security(struct inode *inode,
-				 const struct xattr *lsm_xattr,
-				 struct xattr *evm_xattr)
+int evm_inode_init_security(struct inode *inode, struct inode *dir,
+			    const struct qstr *qstr,
+			    struct xattr *xattrs, int *base_slot,
+			    void *fs_data)
 {
 	struct evm_xattr *xattr_data;
+	struct xattr *evm_xattr = lsm_find_xattr_slot(xattrs, base_slot,
+						      *base_slot + 1);
 	int rc;
 
-	if (!(evm_initialized & EVM_INIT_HMAC) ||
-	    !evm_protected_xattr(lsm_xattr->name))
+	if (!xattrs || !xattrs->name)
 		return 0;
 
+	if (!(evm_initialized & EVM_INIT_HMAC) ||
+	    !evm_protected_xattr(xattrs->name))
+		return -EOPNOTSUPP;
+
 	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
 	if (!xattr_data)
 		return -ENOMEM;
 
 	xattr_data->data.type = EVM_XATTR_HMAC;
-	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
+	rc = evm_init_hmac(inode, xattrs, xattr_data->digest);
 	if (rc < 0)
 		goto out;
 
diff --git a/security/security.c b/security/security.c
index 91675003a5cf..f090362550fa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1103,9 +1103,9 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		goto out;
 	}
 
-	ret = evm_inode_init_security(inode, new_xattrs,
-				      new_xattrs + base_slot);
-	if (ret)
+	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs, &base_slot,
+				      fs_data);
+	if (ret && ret != -EOPNOTSUPP)
 		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
 out:
-- 
2.25.1

