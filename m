Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7973356A7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351650AbhDGKyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 06:54:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2791 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhDGKyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:54:32 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFgyC3XNLz686kT;
        Wed,  7 Apr 2021 18:44:51 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 12:54:21 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 07/12] evm: Allow xattr/attr operations for portable signatures
Date:   Wed, 7 Apr 2021 12:52:47 +0200
Message-ID: <20210407105252.30721-8-roberto.sassu@huawei.com>
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

If files with portable signatures are copied from one location to another
or are extracted from an archive, verification can temporarily fail until
all xattrs/attrs are set in the destination. Only portable signatures may
be moved or copied from one file to another, as they don't depend on
system-specific information such as the inode generation. Instead portable
signatures must include security.ima.

Unlike other security.evm types, EVM portable signatures are also
immutable. Thus, it wouldn't be a problem to allow xattr/attr operations
when verification fails, as portable signatures will never be replaced with
the HMAC on possibly corrupted xattrs/attrs.

This patch first introduces a new integrity status called
INTEGRITY_FAIL_IMMUTABLE, that allows callers of
evm_verify_current_integrity() to detect that a portable signature didn't
pass verification and then adds an exception in evm_protect_xattr() and
evm_inode_setattr() for this status and returns 0 instead of -EPERM.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/integrity.h             |  1 +
 security/integrity/evm/evm_main.c     | 31 +++++++++++++++++++++------
 security/integrity/ima/ima_appraise.c |  2 ++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2271939c5c31..2ea0f2f65ab6 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -13,6 +13,7 @@ enum integrity_status {
 	INTEGRITY_PASS = 0,
 	INTEGRITY_PASS_IMMUTABLE,
 	INTEGRITY_FAIL,
+	INTEGRITY_FAIL_IMMUTABLE,
 	INTEGRITY_NOLABEL,
 	INTEGRITY_NOXATTRS,
 	INTEGRITY_UNKNOWN,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 6556e8c22da9..eab536fa260f 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -27,7 +27,8 @@
 int evm_initialized;
 
 static const char * const integrity_status_msg[] = {
-	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
+	"pass", "pass_immutable", "fail", "fail_immutable", "no_label",
+	"no_xattrs", "unknown"
 };
 int evm_hmac_attrs;
 
@@ -155,7 +156,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	struct evm_digest digest;
 	struct inode *inode;
-	int rc, xattr_len;
+	int rc, xattr_len, evm_immutable = 0;
 
 	if (iint && (iint->evm_status == INTEGRITY_PASS ||
 		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
@@ -200,8 +201,10 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		if (rc)
 			rc = -EINVAL;
 		break;
-	case EVM_IMA_XATTR_DIGSIG:
 	case EVM_XATTR_PORTABLE_DIGSIG:
+		evm_immutable = 1;
+		fallthrough;
+	case EVM_IMA_XATTR_DIGSIG:
 		/* accept xattr with non-empty signature field */
 		if (xattr_len <= sizeof(struct signature_v2_hdr)) {
 			evm_status = INTEGRITY_FAIL;
@@ -238,9 +241,12 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		break;
 	}
 
-	if (rc)
-		evm_status = (rc == -ENODATA) ?
-				INTEGRITY_NOXATTRS : INTEGRITY_FAIL;
+	if (rc) {
+		evm_status = INTEGRITY_NOXATTRS;
+		if (rc != -ENODATA)
+			evm_status = evm_immutable ?
+				     INTEGRITY_FAIL_IMMUTABLE : INTEGRITY_FAIL;
+	}
 out:
 	if (iint)
 		iint->evm_status = evm_status;
@@ -374,6 +380,14 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 out:
 	if (evm_ignore_error_safe(evm_status))
 		return 0;
+
+	/*
+	 * Writing other xattrs is safe for portable signatures, as portable
+	 * signatures are immutable and can never be updated.
+	 */
+	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
+		return 0;
+
 	if (evm_status != INTEGRITY_PASS)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
@@ -534,8 +548,13 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
 		return 0;
 	evm_status = evm_verify_current_integrity(dentry);
+	/*
+	 * Writing attrs is safe for portable signatures, as portable signatures
+	 * are immutable and can never be updated.
+	 */
 	if ((evm_status == INTEGRITY_PASS) ||
 	    (evm_status == INTEGRITY_NOXATTRS) ||
+	    (evm_status == INTEGRITY_FAIL_IMMUTABLE) ||
 	    (evm_ignore_error_safe(evm_status)))
 		return 0;
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index d4b8db1acadd..24d59893aab0 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -416,6 +416,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
 		cause = "missing-HMAC";
 		goto out;
+	case INTEGRITY_FAIL_IMMUTABLE:
+		fallthrough;
 	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
 		cause = "invalid-HMAC";
 		goto out;
-- 
2.26.2

