Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3451BD64F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 09:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD2HmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 03:42:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2127 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbgD2HmN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:42:13 -0400
Received: from lhreml707-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 4A1DB5F8236ABC6C97AB;
        Wed, 29 Apr 2020 08:42:11 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml707-chm.china.huawei.com (10.201.108.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 29 Apr 2020 08:42:10 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Wed, 29 Apr 2020 09:42:10 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <david.safford@gmail.com>,
        <viro@zeniv.linux.org.uk>, <jmorris@namei.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 3/3] evm: Return -EAGAIN to ignore verification failures
Date:   Wed, 29 Apr 2020 09:39:35 +0200
Message-ID: <20200429073935.11913-3-roberto.sassu@huawei.com>
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

By default, EVM maintains the same behavior as before hooks were moved
outside the LSM infrastructure. When EVM returns -EPERM, callers stop their
execution and return the error to user space.

This patch introduces a new mode, called ignore, that changes the return
value of the pre hooks from -EPERM to -EAGAIN. It also modifies the callers
of pre and post hooks to continue the execution if -EAGAIN is returned. The
error is then handled by the post hooks.

The only error that is not ignored is when user space is trying to modify a
portable signature. Once that signature has been validated with the current
values of metadata, there is no valid reason to change them.

From user space perspective, operations on corrupted metadata are
successfully performed but post hooks didn't update the HMAC. At the next
IMA verification, when evm_verifyxattr() is called, corruption will be
detected and access will be denied.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/attr.c                         |  2 +-
 fs/xattr.c                        |  4 ++--
 security/integrity/evm/evm_main.c | 23 +++++++++++++++++------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 6ce60e1eba34..6370e2f3704d 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -329,7 +329,7 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	if (error)
 		return error;
 	evm_error = evm_inode_setattr(dentry, attr);
-	if (evm_error)
+	if (evm_error && evm_error != -EAGAIN)
 		return evm_error;
 	error = try_break_deleg(inode, delegated_inode);
 	if (error)
diff --git a/fs/xattr.c b/fs/xattr.c
index b1fd2aa481a8..73f0f3cd6c45 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -229,7 +229,7 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		goto out;
 
 	evm_error = evm_inode_setxattr(dentry, name, value, size);
-	if (evm_error) {
+	if (evm_error && evm_error != -EAGAIN) {
 		error = evm_error;
 		goto out;
 	}
@@ -408,7 +408,7 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 		goto out;
 
 	evm_error = evm_inode_removexattr(dentry, name);
-	if (evm_error) {
+	if (evm_error && evm_error != -EAGAIN) {
 		error = evm_error;
 		goto out;
 	}
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ca9eaef7058b..ef09caa3bbcf 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -54,11 +54,13 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 
 LIST_HEAD(evm_config_xattrnames);
 
-static int evm_fixmode;
+static int evm_fixmode, evm_ignoremode __ro_after_init;
 static int __init evm_set_fixmode(char *str)
 {
 	if (strncmp(str, "fix", 3) == 0)
 		evm_fixmode = 1;
+	if (strncmp(str, "ignore", 6) == 0)
+		evm_ignoremode = 1;
 	return 0;
 }
 __setup("evm=", evm_set_fixmode);
@@ -311,6 +313,7 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 			     const void *xattr_value, size_t xattr_value_len)
 {
 	enum integrity_status evm_status;
+	int rc = -EPERM;
 
 	if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
 		if (!capable(CAP_SYS_ADMIN))
@@ -345,12 +348,17 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 				    -EPERM, 0);
 	}
 out:
-	if (evm_status != INTEGRITY_PASS)
+	if (evm_status != INTEGRITY_PASS) {
+		if (evm_ignoremode && evm_status != INTEGRITY_PASS_IMMUTABLE)
+			rc = -EAGAIN;
+
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
 				    integrity_status_msg[evm_status],
-				    -EPERM, 0);
-	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
+				    rc, 0);
+	}
+
+	return evm_status == INTEGRITY_PASS ? 0 : rc;
 }
 
 /**
@@ -482,6 +490,7 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
 	enum integrity_status evm_status;
+	int rc = -EPERM;
 
 	/* Policy permits modification of the protected attrs even though
 	 * there's no HMAC key loaded
@@ -495,10 +504,12 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	if ((evm_status == INTEGRITY_PASS) ||
 	    (evm_status == INTEGRITY_NOXATTRS))
 		return 0;
+	if (evm_ignoremode && evm_status != INTEGRITY_PASS_IMMUTABLE)
+		rc = -EAGAIN;
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
-			    integrity_status_msg[evm_status], -EPERM, 0);
-	return -EPERM;
+			    integrity_status_msg[evm_status], rc, 0);
+	return rc;
 }
 
 /**
-- 
2.17.1

