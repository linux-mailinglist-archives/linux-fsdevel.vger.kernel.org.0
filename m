Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179332AED74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 10:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKKJYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 04:24:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2085 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgKKJYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:24:03 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CWK4y3z4Nz67KC3;
        Wed, 11 Nov 2020 17:22:26 +0800 (CST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.161)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 11 Nov 2020 10:24:01 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 04/11] ima: Move ima_reset_appraise_flags() call to post hooks
Date:   Wed, 11 Nov 2020 10:22:55 +0100
Message-ID: <20201111092302.1589-5-roberto.sassu@huawei.com>
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

ima_inode_setxattr() and ima_inode_removexattr() hooks are called before an
operation is performed. Thus, ima_reset_appraise_flags() should not be
called there, as flags might be unnecessarily reset if the operation is
denied.

This patch introduces the post hooks ima_inode_post_setxattr() and
ima_inode_post_removexattr(), removes ima_inode_removexattr() and adds the
call to ima_reset_appraise_flags() in the new functions.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/xattr.c                            |  2 ++
 include/linux/ima.h                   | 19 +++++++++++++++----
 security/integrity/ima/ima_appraise.c | 22 +++++++++++++++-------
 security/security.c                   |  4 +---
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index cd7a563e8bcd..149b8cf5f99f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -16,6 +16,7 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/evm.h>
+#include <linux/ima.h>
 #include <linux/syscalls.h>
 #include <linux/export.h>
 #include <linux/fsnotify.h>
@@ -474,6 +475,7 @@ __vfs_removexattr_locked(struct dentry *dentry, const char *name,
 
 	if (!error) {
 		fsnotify_xattr(dentry);
+		ima_inode_post_removexattr(dentry, name);
 		evm_inode_post_removexattr(dentry, name);
 	}
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index ac3d82f962f2..19a775fa2ba5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -150,7 +150,12 @@ extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
-extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
+extern void ima_inode_post_setxattr(struct dentry *dentry,
+				    const char *xattr_name,
+				    const void *xattr_value,
+				    size_t xattr_value_len);
+extern void ima_inode_post_removexattr(struct dentry *dentry,
+				       const char *xattr_name);
 #else
 static inline bool is_ima_appraise_enabled(void)
 {
@@ -170,10 +175,16 @@ static inline int ima_inode_setxattr(struct dentry *dentry,
 	return 0;
 }
 
-static inline int ima_inode_removexattr(struct dentry *dentry,
-					const char *xattr_name)
+static inline void ima_inode_post_setxattr(struct dentry *dentry,
+					   const char *xattr_name,
+					   const void *xattr_value,
+					   size_t xattr_value_len)
+{
+}
+
+static inline void ima_inode_post_removexattr(struct dentry *dentry,
+					      const char *xattr_name)
 {
-	return 0;
 }
 #endif /* CONFIG_IMA_APPRAISE */
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8361941ee0a1..77c01f50425e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -574,21 +574,29 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 	if (result == 1) {
 		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
 			return -EINVAL;
-		ima_reset_appraise_flags(d_backing_inode(dentry),
-			xvalue->type == EVM_IMA_XATTR_DIGSIG);
 		result = 0;
 	}
 	return result;
 }
 
-int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
+void ima_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
+			     const void *xattr_value, size_t xattr_value_len)
+{
+	const struct evm_ima_xattr_data *xvalue = xattr_value;
+	int result;
+
+	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
+				   xattr_value_len);
+	if (result == 1)
+		ima_reset_appraise_flags(d_backing_inode(dentry),
+			xvalue->type == EVM_IMA_XATTR_DIGSIG);
+}
+
+void ima_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 {
 	int result;
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
-	if (result == 1) {
+	if (result == 1)
 		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
-		result = 0;
-	}
-	return result;
 }
diff --git a/security/security.c b/security/security.c
index a28045dc9e7f..fc43f45938b4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1309,6 +1309,7 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return;
 	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
+	ima_inode_post_setxattr(dentry, name, value, size);
 	evm_inode_post_setxattr(dentry, name, value, size);
 }
 
@@ -1339,9 +1340,6 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
 	ret = call_int_hook(inode_removexattr, 1, dentry, name);
 	if (ret == 1)
 		ret = cap_inode_removexattr(dentry, name);
-	if (ret)
-		return ret;
-	ret = ima_inode_removexattr(dentry, name);
 	if (ret)
 		return ret;
 	return evm_inode_removexattr(dentry, name);
-- 
2.27.GIT

