Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673A140417F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 01:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348354AbhIHXBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 19:01:47 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:15424
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348351AbhIHXBB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rucm0QybWJkoiSdkDmF52M8eLCegYqwz1r5bWpvDlug51FwN6vAG+Dn5AvXsIl4/q/oagXHn3NpxGP2fudhTivk1PvlG7xh9z7S3Ztzr0N1VZsG5GFWcjQgmr+2TfahK9dMclragIB8qerJs1P7Q+Ho2ulV8R6N7d4IsObB74zwp4YzU38raOedK2Scb6jt+LBK11M+sj0vefVBZPAXOsUq2uyvXRf99+lcVZ6MdVUfn/vLKSIrk2MoFV+lziN3wRF/UEqSohBRUDYQgOWA0uqMp629Sr/L4brtprnFS6J96oq+dImSdwO4DILUrgGuozNFORD2UiKm8EdV+0beOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iP4gdPz2H4V+6Rx63Too6pyiVhWIasL/sar8rmR9aF0=;
 b=GsomL9N/6z8tVFT8PP28k0jq9krzHK84grjLC2thDjQN0VjYqWuxlOfwdIqmeTCwYKjiTejwfR7zaN0DZkyEB6t/xsLr3BGpoeS9L4LGqocDQC6rZgUr0LB8/U0FscDX8huyeCYcfRMXg7DPVpbzcqJ/LROnMeKl8t6n2LbOJoOjlg4N8c97AaUifaB09Ut6L9NhLBtpTrHtCZJRuxGnGltk8/IWsXeQl28Hrvs1pmwsOSk5PHgrQ0f7SoJ7563WuCAhSy76yRW6tmtx3CxVGf+ph+zy5Th7GX3ilcHmHXKQi7OOf1BTRDuqKv7g3xGMUJ4zUAx7u49XRuyRpIETAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP4gdPz2H4V+6Rx63Too6pyiVhWIasL/sar8rmR9aF0=;
 b=XLUiA+wCTjeZwvIiiND7195h2tlgHz4x9obeVbLKx5e8zJnv9dFwVqMSKKaQjCQAdRwhN0FKDWU6viTOREGd+ah11sE+yk5OkX+qNfkheliRAJcsa2BJQak7DrSFTOlgoex6l99GKyluftBNJG2QTn92jPIjyGkArAQcLxmTHiY=
Received: from DM3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:0:50::24) by
 DM6PR12MB3482.namprd12.prod.outlook.com (2603:10b6:5:3d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 8 Sep 2021 22:59:49 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::18) by DM3PR03CA0014.outlook.office365.com
 (2603:10b6:0:50::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Wed, 8 Sep 2021 22:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:59:49 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:59:46 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-graphics-maintainer@vmware.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 7/8] x86/sev: Replace occurrences of sev_es_active() with cc_platform_has()
Date:   Wed, 8 Sep 2021 17:58:38 -0500
Message-ID: <702338e6122d189cf9c322133bed5da2f42114c7.1631141919.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1631141919.git.thomas.lendacky@amd.com>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28f2f61d-1b70-4301-3a85-08d9731c5c7a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3482:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34822622559BAAF40C0C7DDCECD49@DM6PR12MB3482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRjyroriEBbLvyYAwYyCsbncLpa+qDqRUBa+iNZOpaYi3QMOid6drgYXkgPIPWCVZ+aIYC9Cz26B3H/wIBuNa2Lka878pFsIlJKzs1VtvhZRLLiq33VN0kwpkL+4PHjWRWJRYFbdkwR6UMmRF1hLi6XR4r4Khp9Ja9S02ezLsPDfNeji+sr/07me4H3F5qFU5XrfFDExiCZxlVj1cEjYE1+0tmLOrHgUTUf7+FlAXWUFu5OpPcgetbwOt5K6ftHfpsQMhWfzrnjRQ62OK/xF362c28noHQsUj0X+kIdrdL7IVeHCALM6fdW809jugAeRJ/VvCnyAhOvuVHDLKCjvmPp1XdO61B8wV5xwWtemKSO5UhS8vcLsIhv69nS6HqYe7tcL19r/lP0hlxFcGNGqECmV6cq+b2XQ8j1afC1BU58Ktjj9jgmfDRognh4CHWuKublvWIAVFkiAntpc7rizpCR9cqGCG2ru4FZmHCP3CP8xFp4vxQCQ062fNvcGhbpc3TzkxQBMeT73uH/Pcwc8Cix0gUIFHOhZjzNszQmFD/wmDvxMK0Y9H750IIzX7biMj7d6SeMHqajncUaijWmroT1Ta5n0PSJW6ZN8DV0wdA3nCyVXgoxb5W+4tb/AQK/JvCVGrKc6CooDFGCLk7vDd7750D+EACMRFMi7BOF/XUHbTQgUJDqhVdHhLSnsBtIJHukLt+bjtJWTrQaECA9hhtaQtMpBTKcOv+ytoE4SuhoI6bq5e8STIM8cKFHf7kdgkCKZeu0oF6SJUO9bW35oMrLoS4z9y7iCG3codHt9cug=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(26005)(4326008)(921005)(83380400001)(8676002)(8936002)(6666004)(426003)(16526019)(2616005)(36756003)(186003)(36860700001)(86362001)(82740400003)(81166007)(336012)(356005)(5660300002)(7416002)(47076005)(54906003)(478600001)(82310400003)(316002)(7696005)(110136005)(70586007)(2906002)(70206006)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:59:49.6489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f2f61d-1b70-4301-3a85-08d9731c5c7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace uses of sev_es_active() with the more generic cc_platform_has()
using CC_ATTR_GUEST_STATE_ENCRYPT. If future support is added for other
memory encyrption techonologies, the use of CC_ATTR_GUEST_STATE_ENCRYPT
can be updated, as required.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |  2 --
 arch/x86/kernel/sev.c              |  6 +++---
 arch/x86/mm/mem_encrypt.c          | 14 ++++----------
 arch/x86/realmode/init.c           |  3 +--
 4 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index f440eebeeb2c..499440781b39 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,7 +51,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sev_es_active(void);
 bool amd_cc_platform_has(enum cc_attr attr);
 
 #define __bss_decrypted __section(".bss..decrypted")
@@ -75,7 +74,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sev_es_active(void) { return false; }
 static inline bool amd_cc_platform_has(enum cc_attr attr) { return false; }
 
 static inline int __init
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..53a6837d354b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -11,7 +11,7 @@
 
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/printk.h>
 #include <linux/mm_types.h>
 #include <linux/set_memory.h>
@@ -615,7 +615,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	int cpu;
 	u64 pfn;
 
-	if (!sev_es_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
@@ -774,7 +774,7 @@ void __init sev_es_init_vc_handling(void)
 
 	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
 
-	if (!sev_es_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return;
 
 	if (!sev_es_check_cpu_features())
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 22d4e152a6de..47d571a2cd28 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -373,13 +373,6 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
  * up under SME the trampoline area cannot be encrypted, whereas under SEV
  * the trampoline area must be encrypted.
  */
-
-/* Needs to be called from non-instrumentable code */
-bool noinstr sev_es_active(void)
-{
-	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
-}
-
 bool amd_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
@@ -393,7 +386,7 @@ bool amd_cc_platform_has(enum cc_attr attr)
 		return sev_status & MSR_AMD64_SEV_ENABLED;
 
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
-		return sev_es_active();
+		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 
 	default:
 		return false;
@@ -469,7 +462,7 @@ static void print_mem_encrypt_feature_info(void)
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
-	if (sev_es_active())
+	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		pr_cont(" SEV-ES");
 
 	pr_cont("\n");
@@ -488,7 +481,8 @@ void __init mem_encrypt_init(void)
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && !sev_es_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index c878c5ee5a4c..4a3da7592b99 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -2,7 +2,6 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
-#include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
 
@@ -48,7 +47,7 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
-	if (sev_es_active()) {
+	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
 		/*
 		 * Skip the call to verify_cpu() in secondary_startup_64 as it
 		 * will cause #VC exceptions when the AP can't handle them yet.
-- 
2.33.0

