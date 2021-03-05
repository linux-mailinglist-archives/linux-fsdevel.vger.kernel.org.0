Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048B232EE88
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEPVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 10:21:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2631 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCEPVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:21:13 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DsWTH3WgTz67wDF;
        Fri,  5 Mar 2021 23:13:23 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 16:21:09 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 06/11] evm: Ignore INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS if conditions are safe
Date:   Fri, 5 Mar 2021 16:19:18 +0100
Message-ID: <20210305151923.29039-7-roberto.sassu@huawei.com>
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

When a file is being created, LSMs can set the initial label with the
inode_init_security hook. If no HMAC key is loaded, the new file will have
LSM xattrs but not the HMAC. It is also possible that the file remains
without protected xattrs after creation if no active LSM provided it.

Unfortunately, EVM will deny any further metadata operation on new files,
as evm_protect_xattr() will always return the INTEGRITY_NOLABEL error, or
INTEGRITY_NOXATTRS if no protected xattrs exist. This would limit the
usability of EVM when only a public key is loaded, as commands such as cp
or tar with the option to preserve xattrs won't work.

This patch ignores these errors when they won't be an issue, if no HMAC key
is loaded and cannot be loaded in the future (which can be enforced by
setting the EVM_SETUP_COMPLETE initialization flag).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_main.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 998818283fda..6556e8c22da9 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -90,6 +90,24 @@ static bool evm_key_loaded(void)
 	return (bool)(evm_initialized & EVM_KEY_MASK);
 }
 
+/*
+ * Ignoring INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS is safe if no HMAC key
+ * is loaded and the EVM_SETUP_COMPLETE initialization flag is set.
+ */
+static bool evm_ignore_error_safe(enum integrity_status evm_status)
+{
+	if (evm_initialized & EVM_INIT_HMAC)
+		return false;
+
+	if (!(evm_initialized & EVM_SETUP_COMPLETE))
+		return false;
+
+	if (evm_status != INTEGRITY_NOLABEL && evm_status != INTEGRITY_NOXATTRS)
+		return false;
+
+	return true;
+}
+
 static int evm_find_protected_xattrs(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
@@ -354,6 +372,8 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 				    -EPERM, 0);
 	}
 out:
+	if (evm_ignore_error_safe(evm_status))
+		return 0;
 	if (evm_status != INTEGRITY_PASS)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
@@ -515,7 +535,8 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 		return 0;
 	evm_status = evm_verify_current_integrity(dentry);
 	if ((evm_status == INTEGRITY_PASS) ||
-	    (evm_status == INTEGRITY_NOXATTRS))
+	    (evm_status == INTEGRITY_NOXATTRS) ||
+	    (evm_ignore_error_safe(evm_status)))
 		return 0;
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
-- 
2.26.2

