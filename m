Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C094036C565
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbhD0Lju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 07:39:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2931 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbhD0Ljs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:39:48 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FTzzM0BFqz77b7N;
        Tue, 27 Apr 2021 19:28:31 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 13:39:02 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jmorris@namei.org>, <paul@paul-moore.com>,
        <casey@schaufler-ca.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <reiserfs-devel@vger.kernel.org>, <selinux@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 6/6] evm: Support multiple LSMs providing an xattr
Date:   Tue, 27 Apr 2021 13:37:32 +0200
Message-ID: <20210427113732.471066-7-roberto.sassu@huawei.com>
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

Currently, evm_inode_init_security() processes a single LSM xattr from
the array passed by security_inode_init_security(), and calculates the
HMAC on it and other inode metadata.

Given that initxattrs(), called by security_inode_init_security(), expects
that this array is terminated when the xattr name is set to NULL, this
patch reuses the same assumption for to scan all xattrs and to calculate
the HMAC on all of them.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm.h        |  2 ++
 security/integrity/evm/evm_crypto.c |  9 ++++++++-
 security/integrity/evm/evm_main.c   | 15 +++++++++++----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index ae590f71ce7d..24eac42b9f32 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -49,6 +49,8 @@ struct evm_digest {
 	char digest[IMA_MAX_DIGEST_SIZE];
 } __packed;
 
+int evm_protected_xattr(const char *req_xattr_name);
+
 int evm_init_key(void);
 int __init evm_init_crypto(void);
 int evm_update_evmxattr(struct dentry *dentry,
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b66264b53d5d..35c5eec0517d 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -358,6 +358,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 		  char *hmac_val)
 {
 	struct shash_desc *desc;
+	const struct xattr *xattr;
 
 	desc = init_desc(EVM_XATTR_HMAC, evm_hash_algo);
 	if (IS_ERR(desc)) {
@@ -365,7 +366,13 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 		return PTR_ERR(desc);
 	}
 
-	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
+	for (xattr = lsm_xattr; xattr->name != NULL; xattr++) {
+		if (!evm_protected_xattr(xattr->name))
+			continue;
+
+		crypto_shash_update(desc, xattr->value, xattr->value_len);
+	}
+
 	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
 	kfree(desc);
 	return 0;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index d647bfd0adcd..cd2f46770646 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -261,7 +261,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	return evm_status;
 }
 
-static int evm_protected_xattr(const char *req_xattr_name)
+int evm_protected_xattr(const char *req_xattr_name)
 {
 	int namelen;
 	int found = 0;
@@ -713,15 +713,22 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    void *fs_data)
 {
 	struct evm_xattr *xattr_data;
+	struct xattr *xattr;
 	struct xattr *evm_xattr = lsm_find_xattr_slot(xattrs, base_slot,
 						      *base_slot + 1);
-	int rc;
+	int rc, evm_protected_xattrs = 0;
 
 	if (!xattrs || !xattrs->name)
 		return 0;
 
-	if (!(evm_initialized & EVM_INIT_HMAC) ||
-	    !evm_protected_xattr(xattrs->name))
+	if (!(evm_initialized & EVM_INIT_HMAC))
+		return -EOPNOTSUPP;
+
+	for (xattr = xattrs; xattr->name != NULL && xattr < evm_xattr; xattr++)
+		if (evm_protected_xattr(xattr->name))
+			evm_protected_xattrs++;
+
+	if (!evm_protected_xattrs)
 		return -EOPNOTSUPP;
 
 	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
-- 
2.25.1

