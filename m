Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CC332EE72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 16:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCEPUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 10:20:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2625 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCEPUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:20:04 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DsWV848kcz67vwn;
        Fri,  5 Mar 2021 23:14:08 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 16:19:55 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 02/11] evm: Load EVM key in ima_load_x509() to avoid appraisal
Date:   Fri, 5 Mar 2021 16:19:14 +0100
Message-ID: <20210305151923.29039-3-roberto.sassu@huawei.com>
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

The public builtin keys do not need to be appraised by IMA as the
restriction on the IMA/EVM trusted keyrings ensures that a key can be
loaded only if it is signed with a key on the builtin or secondary
keyrings.

However, when evm_load_x509() is called, appraisal is already enabled and
a valid IMA signature must be added to the EVM key to pass verification.

Since the restriction is applied on both IMA and EVM trusted keyrings, it
is safe to disable appraisal also when the EVM key is loaded. This patch
calls evm_load_x509() inside ima_load_x509() if CONFIG_IMA_LOAD_X509 is
enabled, which crosses the normal IMA and EVM boundary.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/iint.c         | 4 +++-
 security/integrity/ima/ima_init.c | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 1d20003243c3..c487e74a35fb 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -200,7 +200,9 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 void __init integrity_load_keys(void)
 {
 	ima_load_x509();
-	evm_load_x509();
+
+	if (!IS_ENABLED(CONFIG_IMA_LOAD_X509))
+		evm_load_x509();
 }
 
 static int __init integrity_fs_init(void)
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 6e8742916d1d..5076a7d9d23e 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -108,6 +108,10 @@ void __init ima_load_x509(void)
 
 	ima_policy_flag &= ~unset_flags;
 	integrity_load_x509(INTEGRITY_KEYRING_IMA, CONFIG_IMA_X509_PATH);
+
+	/* load also EVM key to avoid appraisal */
+	evm_load_x509();
+
 	ima_policy_flag |= unset_flags;
 }
 #endif
-- 
2.26.2

