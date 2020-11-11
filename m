Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13512AED89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKKJZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 04:25:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2087 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgKKJZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:25:15 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CWK6Y4jxYz67KnD;
        Wed, 11 Nov 2020 17:23:49 +0800 (CST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.161)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 11 Nov 2020 10:25:12 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 06/11] evm: Ignore INTEGRITY_NOLABEL if no HMAC key is loaded
Date:   Wed, 11 Nov 2020 10:22:57 +0100
Message-ID: <20201111092302.1589-7-roberto.sassu@huawei.com>
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

When a file is being created, LSMs can set the initial label with the
inode_init_security hook. If no HMAC key is loaded, the new file will have
LSM xattrs but not the HMAC.

Unfortunately, EVM will deny any further metadata operation on new files,
as evm_protect_xattr() will always return the INTEGRITY_NOLABEL error. This
would limit the usability of EVM when only a public key is loaded, as
commands such as cp or tar with the option to preserve xattrs won't work.

Ignoring this error won't be an issue if no HMAC key is loaded, as the
inode is locked until the post hook, and EVM won't calculate the HMAC on
metadata that wasn't previously verified. Thus this patch checks if an
HMAC key is loaded and if not, ignores INTEGRITY_NOLABEL.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b38ffa39faa8..4f4404a12bbd 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -354,6 +354,14 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 				    -EPERM, 0);
 	}
 out:
+	/*
+	 * Ignoring INTEGRITY_NOLABEL is safe if no HMAC key is loaded, as
+	 * EVM won't calculate the HMAC of metadata that wasn't previously
+	 * verified.
+	 */
+	if (evm_status == INTEGRITY_NOLABEL &&
+	    !(evm_initialized & EVM_INIT_HMAC))
+		return 0;
 	if (evm_status != INTEGRITY_PASS)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
@@ -514,8 +522,15 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
 		return 0;
 	evm_status = evm_verify_current_integrity(dentry);
+	/*
+	 * Ignoring INTEGRITY_NOLABEL is safe if no HMAC key is loaded, as
+	 * EVM won't calculate the HMAC of metadata that wasn't previously
+	 * verified.
+	 */
 	if ((evm_status == INTEGRITY_PASS) ||
-	    (evm_status == INTEGRITY_NOXATTRS))
+	    (evm_status == INTEGRITY_NOXATTRS) ||
+	    (evm_status == INTEGRITY_NOLABEL &&
+	     !(evm_initialized & EVM_INIT_HMAC)))
 		return 0;
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
-- 
2.27.GIT

