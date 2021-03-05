Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F85032EE8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhCEPVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 10:21:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2628 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCEPVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:21:13 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DsWWc34G4z67vDP;
        Fri,  5 Mar 2021 23:15:24 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 16:21:11 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 09/11] ima: Allow imasig requirement to be satisfied by EVM portable signatures
Date:   Fri, 5 Mar 2021 16:19:21 +0100
Message-ID: <20210305151923.29039-10-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210305151923.29039-1-roberto.sassu@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
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
index 24d59893aab0..538ccbf972c8 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -242,12 +242,16 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
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
@@ -417,6 +421,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 		cause = "missing-HMAC";
 		goto out;
 	case INTEGRITY_FAIL_IMMUTABLE:
+		set_bit(IMA_DIGSIG, &iint->atomic_flags);
 		fallthrough;
 	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
 		cause = "invalid-HMAC";
@@ -461,9 +466,12 @@ int ima_appraise_measurement(enum ima_hooks func,
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
 
@@ -595,6 +603,8 @@ void ima_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 				   xattr_value_len);
 	if (result == 1)
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
+	if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0)
+		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
 	if (result == 1 || evm_status_revalidate(xattr_name))
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 }
-- 
2.26.2

