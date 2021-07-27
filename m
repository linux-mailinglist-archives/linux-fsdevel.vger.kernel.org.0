Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1B73D82A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhG0W1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:27:33 -0400
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com ([40.107.223.81]:35201
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233173AbhG0W1W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1ZfklWMso68pQAEGO+R+ng0kwzSvjo4GYE1msxjHM9gi2E+4HOQ8a6DOZW9s6F+8f3Md6EU2+loIaJcKUZH6LkMT41rzY31lLCBuL00Eg2dgDo8qdMMVewrAkcqp7Ph4BntOPI7XSlEXGAZJOF/X8DxpahxLYv7dsdxtK6mLCRul+GrFfweAH3pIpZkTNe++4jwHaAeWzh9rVT42PIkiseKzzJjKNEKxAuRZYexNQgawr/HUrtQWuzsx/HK0d98+M9Qm6TaqjlcYQ+YyfgWalFyQlK/U0t1qPjclzHQG+eXlEvvZsvC80swsU8+iALxi7HxiIHctlytsRnZ3euIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp1ywvXrR0SvVXwM+PxiNC1HtAn9Msivi6X8gLkFCWg=;
 b=mT34yJrAvyFpA00JjWtxNYNyHJJtJDv54AZSxG6UHpIbH0tEQiZp83fLrmBqPiXC082hwp28+AMeYmfPQloyeg8Ec85V1gXsF2dFnDVQAmzko0vzjWEioc0BFxsi+i0Mxnr42lRjClCoL/HJ8GUiOBLqxUugpaf6jMq/2f5asYWGz6SZhGPrJmGV1oBHwBZIeBCTjVGfK19mFEk4EX/ILfQ2SnHP6BJuFqf8daGQ/9lMfnjhfGjOVetBHfjPYeApPqzM0+g03pnA6wyLL69hNohDGEyC6eOeL+w4PNqRMXzDL4Q0MUjdnoH+edpDAjzt4YGA2ERyQlIKJRshYQ8C0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp1ywvXrR0SvVXwM+PxiNC1HtAn9Msivi6X8gLkFCWg=;
 b=k0E9khWwI8FLrqV2oyCKEOxFa9yGvyD2Ay2nTCQbm4LvX/6X585VIOLeV4iM9+/wDqVWpd3Jfiuhx34xUzOLO2O0LdoZZkMcG0H7Lj/H/4om394P7quVNoQttGEbMQmVAyU7W9pOjLxpzhB7ZupkMnsWeAr9xbIFgW6XXj76U1U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:27:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:27:20 +0000
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
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 04/11] x86/sme: Replace occurrences of sme_active() with prot_guest_has()
Date:   Tue, 27 Jul 2021 17:26:07 -0500
Message-Id: <1a5604f8fb84702f4ae0787428356d7e3e1d3a99.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:806:130::34) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:130::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.14 via Frontend Transport; Tue, 27 Jul 2021 22:27:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c876891-08b6-416c-f597-08d9514db276
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB535788A19665337F00E00A00ECE99@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lluPEDAoAwzwYFK+/GX2lFMqKhMBJqxAr9f2kKcoh61BRy7GqonDwYZ/K/uXwojmS5j7O+2kwFdUofQ+h/y3QVLQXYG6RApLpwZQUckhz07WAXAzHqm8DTtH0CxprCt3xw1AeZ67KqV2Db0XwjLwcYGkkpM3mGZivCdgDsqGu90BSSqtXudRAwOAZy9iJX3OZAYNYs4nxQgcEtbmIt6mHT4HcsHdip8Pv91Rf5CS0KLWjmKHPo//q3k5YJQFUxXGNZe8pt416L+h1BHXxCAp3BGT+KyjoHm4fkwZjTBg79N5LQh6wuNANx3VnBg7/QC7RsLJC45mD3wPOcrpa8jS0s35FRiTcb4JOaR0ih37sBZ/4Vq8T8fCj62c/WveokTRKd2dZzbYL4MkU+yxxGwsepqJHGrV14q22jydnykYKCE4N0x3xW4Q1h3fDusEgHMRLwmxOy1wKeb12rd+JyO1Ut7k2gH7I9FZN+vZrNj4J5vrSph0EeLrJgjLj03055X+RMe/5b9IysfAvEZcgBmqDUsQYzljE8NrY5W4RXF/iAuOsp5NgcT5bOm3/K5zToyoezqadmGZSF1b3eA1FGiuU9B0HBn9VijjUUgBFwb2XEMv0HPT3aqayZltY8UgXATjhfpgRVGoYCOvS55PwcexqNUFSMBUUdGnV86vaOCpUTJXR4YIy5eUYChb09suqcHIIdHKv7JV8uCPuzU9VkRTVrztdCSTg/dgoEjhaV+VDVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(5660300002)(36756003)(54906003)(83380400001)(956004)(66556008)(4326008)(316002)(86362001)(8676002)(921005)(2616005)(66946007)(38350700002)(38100700002)(66476007)(7696005)(2906002)(6486002)(7416002)(478600001)(26005)(6666004)(52116002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pifZO7Buy5dvZM/7Yjt9FnS0e6PuLA3LAzHzk7tRlPQ/LnSlVzAmBqH0Hlyy?=
 =?us-ascii?Q?FvJhgpHtv7fgEvUrDH5vItMh2SZTDaQgIFQ0rg/rs+P8WRc69dIf1A95Sy7x?=
 =?us-ascii?Q?ag/A0PUtIP2UE4Agl2HROqXwgBMc9mHUUMb5Y5ym2pcTmEFwR/D5rrQ5tVgx?=
 =?us-ascii?Q?G6gVVpa7iJsNJzXM6tV24PAkOed1cvE/8rCG0WYt2XIe79sN1e3pKPfGxX8n?=
 =?us-ascii?Q?M4woMLveQ8e+8YQrQBd5lmuqYgypGuoBCL4IrDgBGvHlEA7AfTI6W2ELQK1V?=
 =?us-ascii?Q?B8Z2cwsMLXox9nHUSZGq8uFBNM8wUNriJacbIS79ojVYE4TVm121ddOmy+zD?=
 =?us-ascii?Q?AA25Q2zdNQjcOBtMmrYER/qYzDDYBJLxu7lvFZilGv+bN/MVB0eDoCrTew0E?=
 =?us-ascii?Q?WyavjPfB+gbFh73z2D9GyI6Jlsxj7JYAJJzILxDnj4+wRtnQvdBECKos2jr3?=
 =?us-ascii?Q?V0mHbk+EFkxORW8hTXR8ygemiOolBRijTYLEVQXT8+KLoh8TqanUbJCipDLP?=
 =?us-ascii?Q?9LCAzETCPeDlnATzvLEPipSydIf/KTXU5yQxKv22LWtZzdc9A2c2Dj+8iWhO?=
 =?us-ascii?Q?63TK4wEEg+pRV6J5avfJvHD3RG9Dm6IuRePburxwFHwnwjSeOAKMnUSaJ9lJ?=
 =?us-ascii?Q?rNaSIGjceW+IhpGntiKohuJ+b+Vx4TnRvhCJD/SW76NLz2JB5bEWQKRx9Ptt?=
 =?us-ascii?Q?CazkLB5c/qWZyXb6MSWPG/2i7MyTneE0iYoTmeUT0ptLgh3tX4FxC5ejg7RV?=
 =?us-ascii?Q?36KwGtqo2A+ebosS4/JLQ0NyR8pxP3G1F+WLjCl1GutsMR/bumuND+7NhQ+4?=
 =?us-ascii?Q?+kZ0BfSrbaUCrnkYFg9pnFX4SAjFpX1jl+sWjLKISHWyqr3aaWFXN2RRLuEZ?=
 =?us-ascii?Q?rtngURLuzevJHOZCPuDZlyQPXnQfFXoHrAsGPzyVo7Ei6rdf1YQfmQ/q3tBP?=
 =?us-ascii?Q?GoWikO5OYA2mx9dtbSCuA87VEplyaii2OzOxtfW/bLpJy0luQyDnOFhx9lvd?=
 =?us-ascii?Q?Y0DuclZ1eT49poXjfjM9oSzUShxnnDLo/T8eu0vZzyAJa5BHwXSLMd1mRCtk?=
 =?us-ascii?Q?LRg6W5fDfIuxCLMHjwp4Z6F+OgAXQvzTi5yE+OwzN9wd7aHCj4pUCirsa6mm?=
 =?us-ascii?Q?wq7gFFbnf6pmH/l6SYhN7TlLh4CiA2eU9eAlJqd5e38uuRaRqyMrnOtgpw3Q?=
 =?us-ascii?Q?hfP3KsbOTaZsAPhIPCkx+rMelvMb3Oa++hnCPhj6mREH/8qaDDYF/04Gse/c?=
 =?us-ascii?Q?UdDhhixbZJjqJxH7yvVuDItwhFO7Tg7G73coFHaUsKkpTUB2ABciq710F5n8?=
 =?us-ascii?Q?Mofu17hQKSeOstQ++3QVYBRF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c876891-08b6-416c-f597-08d9514db276
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:27:20.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhbKVcjf8PvM6dQsnZpCnMXmWcx9bUgfcFCng7ESD0wbJY14/IKqsuJOGkOcEmDrVgx/DhkJ9+AZj60TYtNZvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace occurrences of sme_active() with the more generic prot_guest_has()
using PATTR_HOST_MEM_ENCRYPT, except for in arch/x86/mm/mem_encrypt*.c
where PATTR_SME will be used. If future support is added for other memory
encryption technologies, the use of PATTR_HOST_MEM_ENCRYPT can be
updated, as required, to use PATTR_SME.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/include/asm/mem_encrypt.h   |  2 --
 arch/x86/kernel/machine_kexec_64.c   |  3 ++-
 arch/x86/kernel/pci-swiotlb.c        |  9 ++++-----
 arch/x86/kernel/relocate_kernel_64.S |  2 +-
 arch/x86/mm/ioremap.c                |  6 +++---
 arch/x86/mm/mem_encrypt.c            | 10 +++++-----
 arch/x86/mm/mem_encrypt_identity.c   |  3 ++-
 arch/x86/realmode/init.c             |  5 +++--
 drivers/iommu/amd/init.c             |  7 ++++---
 10 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 0a6e34b07017..11b7c06e2828 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -129,7 +129,7 @@ relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
 		unsigned int preserve_context,
-		unsigned int sme_active);
+		unsigned int host_mem_enc_active);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index a46d47662772..956338406cec 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,7 +50,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
 bool amd_prot_guest_has(unsigned int attr);
@@ -76,7 +75,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
 static inline bool amd_prot_guest_has(unsigned int attr) { return false; }
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 131f30fdcfbd..8e7b517ad738 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
 #include <linux/efi.h>
+#include <linux/protected_guest.h>
 
 #include <asm/init.h>
 #include <asm/tlbflush.h>
@@ -358,7 +359,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       sme_active());
+				       prot_guest_has(PATTR_HOST_MEM_ENCRYPT));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index c2cfa5e7c152..bd9a9cfbc9a2 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -6,7 +6,7 @@
 #include <linux/swiotlb.h>
 #include <linux/memblock.h>
 #include <linux/dma-direct.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 
 #include <asm/iommu.h>
 #include <asm/swiotlb.h>
@@ -45,11 +45,10 @@ int __init pci_swiotlb_detect_4gb(void)
 		swiotlb = 1;
 
 	/*
-	 * If SME is active then swiotlb will be set to 1 so that bounce
-	 * buffers are allocated and used for devices that do not support
-	 * the addressing range required for the encryption mask.
+	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
+	 * devices that can't support DMA to encrypted memory.
 	 */
-	if (sme_active())
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		swiotlb = 1;
 
 	return swiotlb;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c53271aebb64..c8fe74a28143 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -47,7 +47,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rsi page_list
 	 * %rdx start address
 	 * %rcx preserve_context
-	 * %r8  sme_active
+	 * %r8  host_mem_enc_active
 	 */
 
 	/* Save the CPU context, used for jumping back */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7dd71bd..f899f02c0241 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
 
@@ -702,7 +702,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 	if (flags & MEMREMAP_DEC)
 		return false;
 
-	if (sme_active()) {
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT)) {
 		if (memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			return false;
@@ -728,7 +728,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 
 	encrypted_prot = true;
 
-	if (sme_active()) {
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT)) {
 		if (early_memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			encrypted_prot = false;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 7d3b2c6f5f88..d246a630feb9 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -144,7 +144,7 @@ void __init sme_unmap_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!amd_prot_guest_has(PATTR_SME))
 		return;
 
 	/* Get the command line address before unmapping the real_mode_data */
@@ -164,7 +164,7 @@ void __init sme_map_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!amd_prot_guest_has(PATTR_SME))
 		return;
 
 	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
@@ -378,7 +378,7 @@ bool sev_active(void)
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
 
-bool sme_active(void)
+static bool sme_active(void)
 {
 	return sme_me_mask && !sev_active();
 }
@@ -428,7 +428,7 @@ bool force_dma_unencrypted(struct device *dev)
 	 * device does not support DMA to addresses that include the
 	 * encryption mask.
 	 */
-	if (sme_active()) {
+	if (amd_prot_guest_has(PATTR_SME)) {
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
@@ -469,7 +469,7 @@ static void print_mem_encrypt_feature_info(void)
 	pr_info("AMD Memory Encryption Features active:");
 
 	/* Secure Memory Encryption */
-	if (sme_active()) {
+	if (amd_prot_guest_has(PATTR_SME)) {
 		/*
 		 * SME is mutually exclusive with any of the SEV
 		 * features below.
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 470b20208430..088c8ab7dcc1 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 
 #include <asm/setup.h>
 #include <asm/sections.h>
@@ -287,7 +288,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
 
-	if (!sme_active())
+	if (!prot_guest_has(PATTR_SME))
 		return;
 
 	/*
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 6534c92d0f83..2109ae569c67 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/pgtable.h>
 
 #include <asm/set_memory.h>
@@ -44,7 +45,7 @@ void __init reserve_real_mode(void)
 static void sme_sev_setup_real_mode(struct trampoline_header *th)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	if (sme_active())
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
 	if (sev_es_active()) {
@@ -81,7 +82,7 @@ static void __init setup_real_mode(void)
 	 * decrypted memory in order to bring up other processors
 	 * successfully. This is not needed for SEV.
 	 */
-	if (sme_active())
+	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		set_memory_decrypted((unsigned long)base, size >> PAGE_SHIFT);
 
 	memcpy(base, real_mode_blob, size);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..05e770e3e631 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -20,7 +20,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/kmemleak.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
@@ -965,7 +965,7 @@ static bool copy_device_table(void)
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = (sme_active() && is_kdump_kernel())
+	old_devtb = (prot_guest_has(PATTR_HOST_MEM_ENCRYPT) && is_kdump_kernel())
 		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
 							dev_table_size)
 		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
@@ -3022,7 +3022,8 @@ static int __init amd_iommu_init(void)
 
 static bool amd_iommu_sme_check(void)
 {
-	if (!sme_active() || (boot_cpu_data.x86 != 0x17))
+	if (!prot_guest_has(PATTR_HOST_MEM_ENCRYPT) ||
+	    (boot_cpu_data.x86 != 0x17))
 		return true;
 
 	/* For Fam17h, a specific level of support is required */
-- 
2.32.0

