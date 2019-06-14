Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B1D466B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfFNR7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 13:59:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33009 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbfFNR7m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:59:42 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 01142FA5D678E3CBCF56;
        Fri, 14 Jun 2019 18:59:41 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 18:59:34 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 01/14] ima: read hash algorithm from security.ima even if appraisal is not enabled
Date:   Fri, 14 Jun 2019 19:55:00 +0200
Message-ID: <20190614175513.27097-2-roberto.sassu@huawei.com>
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

IMA reads the hash algorithm from security.ima, if exists, so that a
signature can be verified even if the algorithm used for the signature
differs from IMA algorithm.

This patch moves ima_read_xattr() and ima_get_hash_algo() to ima_main.c, to
retrieve the algorithm even if appraisal is not enabled. Knowing the
algorithm in advance would be useful also for measurement. The new Digest
Lists extension does not add a new entry to the measurement list if the
actual file digest is found in a loaded list. It might be possible that the
algorithm used for the digest lists differs from IMA algorithm.

This patch also changes the requirement that security.ima must contain a
signature, if the type is EVM_IMA_XATTR_DIGSIG. A signature with length
zero is accepted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          | 16 --------
 security/integrity/ima/ima_appraise.c | 55 ++-------------------------
 security/integrity/ima/ima_main.c     | 51 +++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 67 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ee509c68fe14..b4a0d2a02ff2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -248,10 +248,6 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 					   enum ima_hooks func);
-enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
-				 int xattr_len);
-int ima_read_xattr(struct dentry *dentry,
-		   struct evm_ima_xattr_data **xattr_value);
 
 #else
 static inline int ima_appraise_measurement(enum ima_hooks func,
@@ -282,18 +278,6 @@ static inline enum integrity_status ima_get_cache_status(struct integrity_iint_c
 	return INTEGRITY_UNKNOWN;
 }
 
-static inline enum hash_algo
-ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value, int xattr_len)
-{
-	return ima_hash_algo;
-}
-
-static inline int ima_read_xattr(struct dentry *dentry,
-				 struct evm_ima_xattr_data **xattr_value)
-{
-	return 0;
-}
-
 #endif /* CONFIG_IMA_APPRAISE */
 
 /* LSM based policy rules require audit */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 9b3b172f9748..2566dbfd2464 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -151,57 +151,6 @@ static void ima_cache_flags(struct integrity_iint_cache *iint,
 	}
 }
 
-enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
-				 int xattr_len)
-{
-	struct signature_v2_hdr *sig;
-	enum hash_algo ret;
-
-	if (!xattr_value || xattr_len < 2)
-		/* return default hash algo */
-		return ima_hash_algo;
-
-	switch (xattr_value->type) {
-	case EVM_IMA_XATTR_DIGSIG:
-		sig = (typeof(sig))xattr_value;
-		if (sig->version != 2 || xattr_len <= sizeof(*sig))
-			return ima_hash_algo;
-		return sig->hash_algo;
-		break;
-	case IMA_XATTR_DIGEST_NG:
-		ret = xattr_value->digest[0];
-		if (ret < HASH_ALGO__LAST)
-			return ret;
-		break;
-	case IMA_XATTR_DIGEST:
-		/* this is for backward compatibility */
-		if (xattr_len == 21) {
-			unsigned int zero = 0;
-			if (!memcmp(&xattr_value->digest[16], &zero, 4))
-				return HASH_ALGO_MD5;
-			else
-				return HASH_ALGO_SHA1;
-		} else if (xattr_len == 17)
-			return HASH_ALGO_MD5;
-		break;
-	}
-
-	/* return default hash algo */
-	return ima_hash_algo;
-}
-
-int ima_read_xattr(struct dentry *dentry,
-		   struct evm_ima_xattr_data **xattr_value)
-{
-	ssize_t ret;
-
-	ret = vfs_getxattr_alloc(dentry, XATTR_NAME_IMA, (char **)xattr_value,
-				 0, GFP_NOFS);
-	if (ret == -EOPNOTSUPP)
-		ret = 0;
-	return ret;
-}
-
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -226,6 +175,10 @@ int ima_appraise_measurement(enum ima_hooks func,
 	if (!(inode->i_opflags & IOP_XATTR))
 		return INTEGRITY_UNKNOWN;
 
+	if (xattr_len == sizeof(struct signature_v2_hdr) &&
+	    xattr_value->type == EVM_IMA_XATTR_DIGSIG)
+		rc = -ENODATA;
+
 	if (rc <= 0) {
 		if (rc && rc != -ENODATA)
 			goto out;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 0c49cf6470a4..dc53ed8b0dd0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -143,6 +143,57 @@ static void ima_rdwr_violation_check(struct file *file,
 				  "invalid_pcr", "open_writers");
 }
 
+static enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
+					int xattr_len)
+{
+	struct signature_v2_hdr *sig;
+	enum hash_algo ret;
+
+	if (!xattr_value || xattr_len < 2)
+		/* return default hash algo */
+		return ima_hash_algo;
+
+	switch (xattr_value->type) {
+	case EVM_IMA_XATTR_DIGSIG:
+		sig = (typeof(sig))xattr_value;
+		if (sig->version != 2 || xattr_len < sizeof(*sig))
+			return ima_hash_algo;
+		return sig->hash_algo;
+	case IMA_XATTR_DIGEST_NG:
+		ret = xattr_value->digest[0];
+		if (ret < HASH_ALGO__LAST)
+			return ret;
+		break;
+	case IMA_XATTR_DIGEST:
+		/* this is for backward compatibility */
+		if (xattr_len == 21) {
+			unsigned int zero = 0;
+
+			if (!memcmp(&xattr_value->digest[16], &zero, 4))
+				return HASH_ALGO_MD5;
+			else
+				return HASH_ALGO_SHA1;
+		} else if (xattr_len == 17)
+			return HASH_ALGO_MD5;
+		break;
+	}
+
+	/* return default hash algo */
+	return ima_hash_algo;
+}
+
+static int ima_read_xattr(struct dentry *dentry,
+			  struct evm_ima_xattr_data **xattr_value)
+{
+	ssize_t ret;
+
+	ret = vfs_getxattr_alloc(dentry, XATTR_NAME_IMA, (char **)xattr_value,
+				 0, GFP_NOFS);
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+	return ret;
+}
+
 static void ima_check_last_writer(struct integrity_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
-- 
2.17.1

