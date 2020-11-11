Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6432AED90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 10:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgKKJZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 04:25:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2090 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgKKJZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:25:17 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CWK630vF5z67JkG;
        Wed, 11 Nov 2020 17:23:23 +0800 (CST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.161)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 11 Nov 2020 10:25:15 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 09/11] ima: Allow imasig requirement to be satisfied by EVM portable signatures
Date:   Wed, 11 Nov 2020 10:23:00 +0100
Message-ID: <20201111092302.1589-10-roberto.sassu@huawei.com>
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

System administrators can require that all accessed files have a signature
by specifying appraise_type=imasig in a policy rule.

Currently, IMA signatures satisfy this requirement. Appended signatures may
also satisfy this requirement, but are not applicable as IMA signatures.
IMA/appended signatures ensure data source authentication for file content
and prevent any change. EVM signatures instead ensure data source
authentication for file metadata. Given that the digest or signature of the
file content must be included in the metadata, EVM signatures provide the
same file data guarantees of IMA signatures, as well as providing file
metadata guarantees.

This patch lets systems protected with EVM signatures pass appraisal
verification if the appraise_type=imasig requirement is specified in the
policy. This facilitates deployment in the scenarios where only EVM
signatures are available.

The patch makes the following changes:

file xattr types:
security.ima: IMA_XATTR_DIGEST/IMA_XATTR_DIGEST_NG
security.evm: EVM_XATTR_PORTABLE_DIGSIG

execve(), mmap(), open() behavior (with appraise_type=imasig):
before: denied (file without IMA signature, imasig requirement not met)
after: allowed (file with EVM portable signature, imasig requirement met)

open(O_WRONLY) behavior (without appraise_type=imasig):
before: allowed (file without IMA signature, not immutable)
after: denied (file with EVM portable signature, immutable)

In addition, similarly to IMA signatures, this patch temporarily allows
new files without or with incomplete metadata to be opened so that content
can be written.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 57a252f8c724..00b038941a10 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -241,12 +241,16 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
 		hash_start = 1;
 		fallthrough;
 	case IMA_XATTR_DIGEST:
-		if (iint->flags & IMA_DIGSIG_REQUIRED) {
-			*cause = "IMA-signature-required";
-			*status = INTEGRITY_FAIL;
-			break;
+		if (*status != INTEGRITY_PASS_IMMUTABLE) {
+			if (iint->flags & IMA_DIGSIG_REQUIRED) {
+				*cause = "IMA-signature-required";
+				*status = INTEGRITY_FAIL;
+				break;
+			}
+			clear_bit(IMA_DIGSIG, &iint->atomic_flags);
+		} else {
+			set_bit(IMA_DIGSIG, &iint->atomic_flags);
 		}
-		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
 				iint->ima_hash->length)
 			/*
@@ -416,6 +420,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 		cause = "missing-HMAC";
 		goto out;
 	case INTEGRITY_FAIL_IMMUTABLE:
+		set_bit(IMA_DIGSIG, &iint->atomic_flags);
 		fallthrough;
 	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
 		cause = "invalid-HMAC";
@@ -460,9 +465,12 @@ int ima_appraise_measurement(enum ima_hooks func,
 				status = INTEGRITY_PASS;
 		}
 
-		/* Permit new files with file signatures, but without data. */
+		/*
+		 * Permit new files with file/EVM portable signatures, but
+		 * without data.
+		 */
 		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
-		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
+		    test_bit(IMA_DIGSIG, &iint->atomic_flags)) {
 			status = INTEGRITY_PASS;
 		}
 
@@ -592,6 +600,8 @@ void ima_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 				   xattr_value_len);
 	if (result == 1)
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
+	if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0)
+		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
 	if (result == 1 || evm_status_revalidate(xattr_name))
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 }
-- 
2.27.GIT

