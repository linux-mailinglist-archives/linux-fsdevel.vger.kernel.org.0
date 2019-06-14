Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4570D4670F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfFNSFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:05:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFNSFW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:05:22 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EBA94436CA58B7C17C62;
        Fri, 14 Jun 2019 19:05:20 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:05:12 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 12/14] ima: add support for appraisal with digest lists
Date:   Fri, 14 Jun 2019 19:55:11 +0200
Message-ID: <20190614175513.27097-13-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614175513.27097-1-roberto.sassu@huawei.com>
References: <20190614175513.27097-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IMA-Appraise grants access to files with a valid signature or with actual
file digest equal to the digest included in security.ima.

This patch adds support for appraisal based on digest lists. Instead of
using the reference value from security.ima, this patch checks if the
calculated file digest is included in the uploaded digest lists.

This functionality must be explicitly enabled by providing one of the
following values for the ima_appraise= kernel option:

- digest: this mode enables appraisal verification with digest lists until
  EVM is initialized; after that, access to files without signature/HMAC
  will be denied; this mode would be used for systems that perform HMAC
  verification and rely on digest lists for the system initialization until
  the HMAC key is unsealed;

- digest-nometadata: this mode enables appraisal verification with digest
  lists even after EVM has been initialized; access will be granted if
  a file does not have IMA/EVM xattrs but its digest is found in the digest
  lists; after update, mutable files will have a new security.ima type, so
  that they can be made inaccessible unless this mode is specified; this
  mode would be used for systems that perform appraisal verification
  exclusively based on digest lists.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 include/linux/evm.h                           |  6 +++
 security/integrity/evm/evm_main.c             |  2 +-
 security/integrity/ima/ima.h                  |  5 ++-
 security/integrity/ima/ima_appraise.c         | 37 ++++++++++++++++++-
 security/integrity/ima/ima_main.c             |  4 +-
 security/integrity/integrity.h                |  2 +
 7 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 05862a0c402d..765682b4187d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1588,7 +1588,8 @@
 
 	ima_appraise=	[IMA] appraise integrity measurements
 			Format: { "off" | "enforce" | "fix" | "log" |
-				  "enforce-evm" | "log-evm" }
+				  "enforce-evm" | "log-evm" | "digest" |
+				  "digest-nometadata" }
 			default: "enforce"
 
 	ima_appraise_tcb [IMA] Deprecated.  Use ima_policy= instead.
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 8302bc29bb35..6e89d046b716 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -15,6 +15,7 @@
 struct integrity_iint_cache;
 
 #ifdef CONFIG_EVM
+extern bool evm_key_loaded(void);
 extern int evm_set_key(void *key, size_t keylen);
 extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     const char *xattr_name,
@@ -45,6 +46,11 @@ static inline int posix_xattr_acl(const char *xattrname)
 #endif
 #else
 
+static inline bool evm_key_loaded(void)
+{
+	return false;
+}
+
 static inline int evm_set_key(void *key, size_t keylen)
 {
 	return -EOPNOTSUPP;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index abb5ce3fd942..fbe0bb5cd7c4 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -86,7 +86,7 @@ static void __init evm_init_config(void)
 	pr_info("HMAC attrs: 0x%x\n", evm_hmac_attrs);
 }
 
-static bool evm_key_loaded(void)
+bool evm_key_loaded(void)
 {
 	return (bool)(evm_initialized & EVM_KEY_MASK);
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 42e4f2b64cd1..16952df04cb6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -248,7 +248,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len);
+			     int xattr_len, struct ima_digest *found_digest);
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
@@ -260,7 +260,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   struct file *file,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
-					   int xattr_len)
+					   int xattr_len,
+					   struct ima_digest *found_digest)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 2566dbfd2464..01210a265f1f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -14,8 +14,10 @@
 #include <linux/evm.h>
 
 #include "ima.h"
+#include "ima_digest_list.h"
 
 static bool ima_appraise_req_evm __ro_after_init;
+static bool ima_appraise_no_metadata __ro_after_init;
 static int __init default_appraise_setup(char *str)
 {
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
@@ -29,6 +31,14 @@ static int __init default_appraise_setup(char *str)
 	if (strcmp(str, "enforce-evm") == 0 ||
 	    strcmp(str, "log-evm") == 0)
 		ima_appraise_req_evm = true;
+#ifdef CONFIG_IMA_DIGEST_LIST
+	if (!strncmp(str, "digest", 6)) {
+		ima_digest_list_actions |= IMA_APPRAISE;
+
+		if (!strcmp(str + 6, "-nometadata"))
+			ima_appraise_no_metadata = true;
+	}
+#endif
 	return 1;
 }
 
@@ -73,6 +83,8 @@ static int ima_fix_xattr(struct dentry *dentry,
 	} else {
 		offset = 0;
 		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
+		if (iint->flags & IMA_DIGEST_LISTS)
+			iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_LIST;
 		iint->ima_hash->xattr.ng.algo = algo;
 	}
 	rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_IMA,
@@ -163,7 +175,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len)
+			     int xattr_len, struct ima_digest *found_digest)
 {
 	static const char op[] = "appraise_data";
 	const char *cause = "unknown";
@@ -192,6 +204,22 @@ int ima_appraise_measurement(enum ima_hooks func,
 		    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
 		     (inode->i_size == 0)))
 			status = INTEGRITY_PASS;
+		if (found_digest) {
+			if (!evm_key_loaded() || ima_appraise_no_metadata)
+				status = INTEGRITY_PASS;
+
+			if (!ima_digest_is_immutable(found_digest)) {
+				if ((iint->flags & IMA_DIGSIG_REQUIRED)) {
+					cause = "IMA-signature-required";
+					status = INTEGRITY_FAIL;
+					goto out;
+				}
+				clear_bit(IMA_DIGSIG, &iint->atomic_flags);
+				iint->flags |= IMA_DIGEST_LISTS;
+			} else {
+				set_bit(IMA_DIGSIG, &iint->atomic_flags);
+			}
+		}
 		goto out;
 	}
 
@@ -217,6 +245,13 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	switch (xattr_value->type) {
+	case IMA_XATTR_DIGEST_LIST:
+		if (!ima_appraise_no_metadata) {
+			cause = "IMA-xattr-untrusted";
+			status = INTEGRITY_FAIL;
+			break;
+		}
+		iint->flags |= IMA_DIGEST_LISTS;
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
 		hash_start = 1;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index eca55e788c28..53c6b2eeaec0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -395,7 +395,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		inode_lock(inode);
 		rc = ima_appraise_measurement(func, iint, file, pathname,
-					      xattr_value, xattr_len);
+					      xattr_value, xattr_len,
+					      ima_digest_allow(found_digest,
+							       IMA_APPRAISE));
 		inode_unlock(inode);
 		if (!rc)
 			rc = mmap_violation_check(func, file, &pathbuf,
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 8c4cf5127a8b..f695b70feb1a 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -32,6 +32,7 @@
 #define IMA_NEW_FILE		0x04000000
 #define EVM_IMMUTABLE_DIGSIG	0x08000000
 #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
+#define IMA_DIGEST_LISTS	0x20000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
@@ -71,6 +72,7 @@ enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST_NG,
 	EVM_XATTR_PORTABLE_DIGSIG,
 	EVM_XATTR_HMAC_RND_KEY,
+	IMA_XATTR_DIGEST_LIST,
 	IMA_XATTR_LAST
 };
 
-- 
2.17.1

