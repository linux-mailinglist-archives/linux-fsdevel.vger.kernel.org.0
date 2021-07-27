Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690253D82BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhG0W17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:27:59 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:52929
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232992AbhG0W1t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:27:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFk63pUovvsfTly4mfNKSrWlPYd69Huu1RLwYNQ5Gh4LB+o0UYFJmM417bjNi4CzrmCR13B6B4R3V6Y3FKoZtjmrIrkIcQ1ICcvVJQgEzd1HYQcYhsOEHeous9C0SCuiItEcVxtmSmAeYR17U1qZKNJQQzHPgysoY65/R+m5VDUL63zTX6b6sNIOqvtwLed2dxt3+dBjgayCPSsrpn8/osthBT1hxQ3vrO7ZQFWhGi+kwkWGnDz1TasC08EvupxMnD1z1Yd/1kwg4Y9Ov/Z3WQe80ukMmOIPhBm0ic2P3xVk0KBOPHwB93QOqVl9kUC9Gc30zmJs1Qtkt9cYe3BcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0jCJGrJYBzUq2OOyibfYsm8X/ntg7WuQP5qdSVMeCs=;
 b=nKQIWLCuOtldr/fFMhlz1SOkM3OecOkcmhVK+q3JfjRO47kLNeqElbH/MjO6RyfXR1fMcMdwJDEgpkyKQBAMSsw3zP10qEHv7p3X0zYzcVaX5XPVw/0fV6Ymvsvt6viFx3N2j5xLi71Ffikj7ABt5SAb9jevmVV4tFm7sMfjbpKA0DJSEwWU0bL6+JoReT/Nuia7WMs3y73OQRhVyWYrBiv6VkaNjszd4ysD8oJBNh/hVcCe7ntBVN3wZa3F0DV7rvYdCC+n+O5hrbV/1H7kxN9lHjfIOpO2c8d+TDrCC6PRqGImzP0IdwZ9H+ulU2K/oCqGt64xaN5TX3/3fv1bOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0jCJGrJYBzUq2OOyibfYsm8X/ntg7WuQP5qdSVMeCs=;
 b=ILjQpeH+2EkofVWRFiZZRLzfGco99H+GwW8DEyqf/lCHL1Ld5m+BAlXPNmM6pDCi+eoijyedBDR6oXlGF70S9abZWxfwj37EAIBxDHbUbv1QMz+PquKgKgDPf9tOcJkxQMZenvF8cAYlvbxLYZaAqw+v04zht8D4nfVNGaJEujE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:27:40 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:27:40 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 06/11] x86/sev: Replace occurrences of sev_es_active() with prot_guest_has()
Date:   Tue, 27 Jul 2021 17:26:09 -0500
Message-Id: <ba565128b88661a656fc3972f01bb2e295158a15.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:806:122::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN7PR04CA0109.namprd04.prod.outlook.com (2603:10b6:806:122::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 27 Jul 2021 22:27:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fbe3e98-2c64-4712-feaa-08d9514dbe61
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB535710CD5A52CFBC064513D3ECE99@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4zO/6tLSL94W7yJHFCiYB3S0UIr0BGCVJiOU2jex3VKdsSVFC8xaWiaL7aclCkn8yJInjiy2nw5GH7vzSzLaUc5TnGk4ULGWG5wMLF6V4qP7YDe4Xk8oYAPs3YKl4Llf5Ahgvb8Sy0V7T4xuGl1GPJT9TpRdTb3z4AfHAgQ4vS6nvZg7WrnoLbh2+jIDkRVRAYLRvO2HfQO/xeomcnqx+iPepmIo0Kwbraz54f62w1WA6f0n8hIsvB+6FMGNDI4NHNmnfRBm2Ph1tj3k9nBGnP8c997TLcaTLjf/T9B5OYLCxC8XfA/VrfsznlwHpXZ689hZ4rW8+9MEd2SSetOzxrhvZIY3f4VcWV/Pd9vdITJPe/ssXUbmkz6J/gKQ/9F4RS30oj/WMY3NOox+QdMjgaV8cAd5w3R4IwTErs9f4d7+ZIVTvUZZg3O4q+VM5IvvOrBuqHP2VgJaYr+AtDuZGjOMVT46LEsRp4YKeqoijC9IQ4nkew4vNUtILVxF/LKDjbTkt3xOUxNWaAtXeSEfTqdnriP2IgK7fOT8AdegSe1XB4ve8u75bdzTzroZgF+17z9dzRBSCAK63gxdmZknRVdTnJPv1ZwHPbORAeYKWpWIYYfIGzLxUBnvT+SJqhrIZliOBvvquGPtpIstgoe5P5odsq3iIOx0gvW+VAN00Q3xI6XsSLDT1guYRZk2JTrsL/I0huPTISPbVyDrMvpnE7V3x7CMhBPrB0iyQgLar0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(5660300002)(36756003)(54906003)(83380400001)(956004)(66556008)(4326008)(316002)(86362001)(8676002)(921005)(2616005)(66946007)(38350700002)(38100700002)(66476007)(7696005)(2906002)(6486002)(7416002)(478600001)(26005)(6666004)(52116002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4733/4SnnaH3hIDMl+IP9BB/Ydbysg/Wt82S2jred9GxdDMz6lGdacjD/bW3?=
 =?us-ascii?Q?UgfxZF13xlSFAII7KpC7Tt0DP009eAvpMeScFpGnpM8ZRgAsHdd6BDIufxSq?=
 =?us-ascii?Q?TtiF79EVoRrT7ca29hecwFS8w2qtR6KnhwHY1VdNC++cW4ofWCLIIuBCJG9O?=
 =?us-ascii?Q?aYKjkuUnnDqX7Cc3Yuh/Yxdcfrn0tlykBOq4oY1kbb32GNhqGcXcyJK7QEvj?=
 =?us-ascii?Q?vsHK1HkUoCIdN1EqCnFzoRH0xLIXsf53iz13Kwiymb4kWiD/10vTO4Y+qOdr?=
 =?us-ascii?Q?J31rfWG+KauKrMpURIDjROgB2Sndz6IMdFt7aWZ7kVDEgeyy4uVkH0SnV2QO?=
 =?us-ascii?Q?OeYhfkcf1w5FRFJOvogW1/OEwgLP2P65FZiqCfyxhT6a6+iTLZUoy1/7qyvm?=
 =?us-ascii?Q?K2jtymgYceyk758hYXDEJL9lfASzBQxWuG7OAaODkBGd9HJElQStiGnDD8ai?=
 =?us-ascii?Q?x8potUs4hERxJfAbUxMzkzmmMVWmxhJs7LnTjuyUL5/mNEsMPyC9Ax2YtOuS?=
 =?us-ascii?Q?R0CZAzO8opsiaOPTiQRTkuP0z06Sec7RrskjhVwytvAUUVxYg+GkX2RMSErC?=
 =?us-ascii?Q?wwEkufhXgWXQph6jb6qNCP3PmZenlVMyRKjGjGOag7bLrl7/inIKRIF93ev7?=
 =?us-ascii?Q?wWZfTLjoJFY3wS8hM55knBhc9Ul9kDeQEjAzvvHS+kJbIqTjPnJHvUEaiIos?=
 =?us-ascii?Q?6SSUikL7s9Ger0GVBv4bVmXQxEfR5B1ybZqwRR3dXWyP5uIVs3ie69HdDKoU?=
 =?us-ascii?Q?py1J8g81ZAbeZMrhWmbYxHvr4qTxYt+B1VDCk6yAtSErEd1y1bJsNRujnq+f?=
 =?us-ascii?Q?XV4BNwH+PEuyaY1PIp00xz/b3Rfix01NneWPfy+1YfuwbyD7N9Qm5pGbxygG?=
 =?us-ascii?Q?5AOeSWJ9xZUVnk2dML4Jz9/kd5Ny8Sgx6k1zvgwLVjljShsyzEpG7di0Adgw?=
 =?us-ascii?Q?swXVqFawcIqB2iMnsyRJ6xmy2SxNUmtRB6+2Hg/abfshH1alDfJk/BQ6B3jy?=
 =?us-ascii?Q?HHDeexHvwe7XaS/zF/t0p0j0bCu/cYw7D56f7fibLg3trvN34QDyc5bLO1Ub?=
 =?us-ascii?Q?8N/8Vd9wVzPbUBOqo3QyTFBg1YV2MgW80WNU0jH6VLWU74aTs66VzUcLWhLv?=
 =?us-ascii?Q?caMuX2p+xQ4rOcCtLu7nviCR6dDi1al33zYwVY14bwt0z8Wl32PlRiP2SkOR?=
 =?us-ascii?Q?M8inlxZrBcsJtgXxcKii2MvTTYXbqug6GuF32jggOPlCAgj0ESMlJpz4k5QH?=
 =?us-ascii?Q?nHKuf+mkxy0Vz1SZPGpM2zEj/mgIHUoMNRqigD+R0opR1zDLrDILj/6rbyG4?=
 =?us-ascii?Q?6zlsYOkHHh96TOQxEXBgRnvG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbe3e98-2c64-4712-feaa-08d9514dbe61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:27:40.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPPtQwjc6dQFRISYxOJdnZkEwUSi0pyffUeV6q4sEF9GRIUHvOXYsoRtTt4Up0BmlSjOx8M1RDWTY8I0okpBaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace occurrences of sev_es_active() with the more generic
prot_guest_has() using PATTR_GUEST_PROT_STATE, except for in
arch/x86/kernel/sev*.c and arch/x86/mm/mem_encrypt*.c where PATTR_SEV_ES
will be used. If future support is added for other memory encyrption
techonologies, the use of PATTR_GUEST_PROT_STATE can be updated, as
required, to specifically use PATTR_SEV_ES.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h | 2 --
 arch/x86/kernel/sev.c              | 6 +++---
 arch/x86/mm/mem_encrypt.c          | 7 +++----
 arch/x86/realmode/init.c           | 3 +--
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 7e25de37c148..797146e0cd6b 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,7 +50,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sev_es_active(void);
 bool amd_prot_guest_has(unsigned int attr);
 
 #define __bss_decrypted __section(".bss..decrypted")
@@ -74,7 +73,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sev_es_active(void) { return false; }
 static inline bool amd_prot_guest_has(unsigned int attr) { return false; }
 
 static inline int __init
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..66a4ab9d95d7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -11,7 +11,7 @@
 
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/printk.h>
 #include <linux/mm_types.h>
 #include <linux/set_memory.h>
@@ -615,7 +615,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	int cpu;
 	u64 pfn;
 
-	if (!sev_es_active())
+	if (!prot_guest_has(PATTR_SEV_ES))
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
@@ -774,7 +774,7 @@ void __init sev_es_init_vc_handling(void)
 
 	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
 
-	if (!sev_es_active())
+	if (!prot_guest_has(PATTR_SEV_ES))
 		return;
 
 	if (!sev_es_check_cpu_features())
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index eb5cae93b238..451de8e84fce 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -383,8 +383,7 @@ static bool sme_active(void)
 	return sme_me_mask && !sev_active();
 }
 
-/* Needs to be called from non-instrumentable code */
-bool noinstr sev_es_active(void)
+static bool sev_es_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
@@ -482,7 +481,7 @@ static void print_mem_encrypt_feature_info(void)
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
-	if (sev_es_active())
+	if (amd_prot_guest_has(PATTR_SEV_ES))
 		pr_cont(" SEV-ES");
 
 	pr_cont("\n");
@@ -501,7 +500,7 @@ void __init mem_encrypt_init(void)
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (amd_prot_guest_has(PATTR_SEV) && !sev_es_active())
+	if (amd_prot_guest_has(PATTR_SEV) && !amd_prot_guest_has(PATTR_SEV_ES))
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 2109ae569c67..7711d0071f41 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -2,7 +2,6 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
-#include <linux/mem_encrypt.h>
 #include <linux/protected_guest.h>
 #include <linux/pgtable.h>
 
@@ -48,7 +47,7 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
 	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
-	if (sev_es_active()) {
+	if (prot_guest_has(PATTR_GUEST_PROT_STATE)) {
 		/*
 		 * Skip the call to verify_cpu() in secondary_startup_64 as it
 		 * will cause #VC exceptions when the AP can't handle them yet.
-- 
2.32.0

