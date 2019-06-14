Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE58B46714
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFNSFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:05:33 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33021 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFNSFc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:05:32 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 3A3DEB1CAA55972F7324;
        Fri, 14 Jun 2019 19:05:31 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:05:22 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 13/14] ima: introduce new policies initrd and appraise_initrd
Date:   Fri, 14 Jun 2019 19:55:12 +0200
Message-ID: <20190614175513.27097-14-roberto.sassu@huawei.com>
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

This patch introduces the new policies 'initrd' and 'appraise_initrd' to
measure/appraise files in the initial ram disk.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++-
 security/integrity/ima/ima_policy.c           | 26 +++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 765682b4187d..47311cdf63d9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1619,7 +1619,7 @@
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
 			Format: "tcb | appraise_tcb | secure_boot |
-				 fail_securely"
+				 fail_securely | initrd | appraise_initrd"
 
 			The "tcb" policy measures all programs exec'd, files
 			mmap'd for exec, and all files opened with the read
@@ -1638,6 +1638,9 @@
 			filesystems with the SB_I_UNVERIFIABLE_SIGNATURE
 			flag.
 
+			The "initrd" and "appraise_initrd" policies include
+			rootfs among the filesystems to be measured/appraised.
+
 	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
 			Load a policy which meets the needs of the Trusted
 			Computing Base.  This means IMA will measure all
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5537b91272f0..70412df07718 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -165,6 +165,14 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 #endif
 };
 
+static struct ima_rule_entry initrd_measure_rule __ro_after_init = {
+	.action = MEASURE, .fsname = "rootfs", .flags = IMA_FSNAME
+};
+
+static struct ima_rule_entry initrd_appraise_rule __ro_after_init = {
+	.action = APPRAISE, .fsname = "rootfs", .flags = IMA_FSNAME
+};
+
 static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
 #ifdef CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS
 	{.action = APPRAISE, .func = MODULE_CHECK,
@@ -218,6 +226,8 @@ __setup("ima_tcb", default_measure_policy_setup);
 static bool ima_use_appraise_tcb __initdata;
 static bool ima_use_secure_boot __initdata;
 static bool ima_fail_unverifiable_sigs __ro_after_init;
+static bool ima_measure_initrd __initdata;
+static bool ima_appraise_initrd __initdata;
 static int __init policy_setup(char *str)
 {
 	char *p;
@@ -233,6 +243,10 @@ static int __init policy_setup(char *str)
 			ima_use_secure_boot = true;
 		else if (strcmp(p, "fail_securely") == 0)
 			ima_fail_unverifiable_sigs = true;
+		else if (strcmp(p, "initrd") == 0)
+			ima_measure_initrd = true;
+		else if (strcmp(p, "appraise_initrd") == 0)
+			ima_appraise_initrd = true;
 	}
 
 	return 1;
@@ -640,9 +654,13 @@ void __init ima_init_policy(void)
 	int build_appraise_entries, arch_entries;
 
 	/* if !ima_policy, we load NO default rules */
-	if (ima_policy)
+	if (ima_policy) {
+		if (ima_measure_initrd)
+			add_rules(&initrd_measure_rule, 1, IMA_DEFAULT_POLICY);
+
 		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
 			  IMA_DEFAULT_POLICY);
+	}
 
 	switch (ima_policy) {
 	case ORIGINAL_TCB:
@@ -695,10 +713,14 @@ void __init ima_init_policy(void)
 				  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 	}
 
-	if (ima_use_appraise_tcb)
+	if (ima_use_appraise_tcb) {
+		if (ima_appraise_initrd)
+			add_rules(&initrd_appraise_rule, 1, IMA_DEFAULT_POLICY);
+
 		add_rules(default_appraise_rules,
 			  ARRAY_SIZE(default_appraise_rules),
 			  IMA_DEFAULT_POLICY);
+	}
 
 	ima_rules = &ima_default_rules;
 	ima_update_policy_flag();
-- 
2.17.1

