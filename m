Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E2404165
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 00:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348223AbhIHXAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 19:00:51 -0400
Received: from mail-sn1anam02on2071.outbound.protection.outlook.com ([40.107.96.71]:62062
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348269AbhIHXAo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftBiG0CV+Zaz/O1o56c3CqEuB4U9vDrxC+gaiG90CAtj6+ORz4nmP4+uCoCpHaM7cz5t8t4vWvMs1jvCc2jMTjO3OinohyLXL1yJL3+aMy52OvUZAuReaIzn0P0K99tlMubKWVJLGGT7fzIjrDC5EcOoEIsR7HV+F/GgjcXjy5ctEtDhCyRWdEf4UkuRRfX7ssXBKb/Pmjdo5fQGdOHUgYMIYe99g7b2w15a8SAkf7v3yti6k055AGDkroSXI3FMZpLBE0LftGis1/UTrxnZJVm2C7K4zhRmK2m1xm1efrk+UfgyfCgkrU/hlN/yQuST4wuCXvRHyXwrFzBdFBhspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nFfA0Sluea6dqGfKUWijQjLsU3PV2cWEiUGt3KY8Q6I=;
 b=YHd/tofoQWchlbzD3P8Iw5kiTjy25eiH+Q9GLiLZ8Efg2sWEmNSnpWP549D3BBJZuq4T9C7/jOquA8E1ea6PQN2pu5euNI3iG2Dwr7N+bOj8LOtH3VBLgseJmmGHpqfvE/xg6Kl6/1iZOrUsmAZsfBS1jh71k0sWnO7hkrxasu0xYNbH0/aQU1Tks/BocAhC3AqQtr5GZ1/enRgA3VeNnj+m7bXz8fwgM9dh5dnx7nTZ3QHL3rnjafALA+cmG9pzy0RuU74zP33iKyYjFHDf1RmqL2kmTSLvxg48zz46WLEPF2e1rnFvUo+H1oYifW8pcBP+9dNDv/F8FoBTUUYdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFfA0Sluea6dqGfKUWijQjLsU3PV2cWEiUGt3KY8Q6I=;
 b=R7fkTD5+ddO3OkxATKGtvxHPWMlCKH3VimK5UHWkVdZRQ5j86M0UsGicwBRkxdLyvj8EEYPwT2MHJlsKGbc5IVJY37m4pnGbc8SMOIkEf7hYdjnwRcXPdgHrb/AmIy5U8tX61UvTyxEd46A/MkoGxK4a4QHJzugTfWe9yQ93Lb8=
Received: from DS7PR03CA0112.namprd03.prod.outlook.com (2603:10b6:5:3b7::27)
 by BY5PR12MB5559.namprd12.prod.outlook.com (2603:10b6:a03:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 8 Sep
 2021 22:59:33 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::29) by DS7PR03CA0112.outlook.office365.com
 (2603:10b6:5:3b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 22:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:59:33 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:59:31 -0500
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
        Ingo Molnar <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with cc_platform_has()
Date:   Wed, 8 Sep 2021 17:58:36 -0500
Message-ID: <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bfa385cc-a30f-43fb-6921-08d9731c5295
X-MS-TrafficTypeDiagnostic: BY5PR12MB5559:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5559649D8B6BCDA2A846A439ECD49@BY5PR12MB5559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3GiEYwnaGy5XsOmXC8LXhvI4RWai15guAFP1kfIFDZRKKZt8y61gXmdFETRTokcUqdNjGSmYigoYGv4CCTj+y+yTQyW1Yi+3NbSdhgMj0jsniRL1D0Z/LZbLn1KA/WGRk9B8zaCYhsduRIca2Tw80HkqmvgkY8mSqfgc9gSINZLogu5Yis2OdHfXq6qfpNktVKPgjrzpXTQOZ/CFc2EuLEuUDSQYlSUD58YZW35NLQEuyFqrVesoapy5m9uUbAx7Gg76iUXxXdP7vRASrOe18EI9eW7dIKWp2LNG3gt5V2l3xwe+1PIEdE7Qhuiw49D4yvXTQjOZrhjlBnZ6rI5Jg4C/vPU4g0n7HqPP8alDkujh2SG0Sf3NuGCt36LrB+9e/Z7sdaWvg8+ty7aiHAtpKNPKN6j6g7xqeIMUgJXXBn12vKrvffLVGa47KX+Iy/jMQKjzq54nIkT784YBippIiz/XZ1XWJKxpHW6ji8ROmBAW7Fu2YSZCAo3K84+wEQR/7L/6liA3Z9X6dIRJknLxPZpZGa9r26NaUxS6oYZEfMHYIwgKNCgEMCgoYn3qyG4wRskNIoHJUfeJt3lSTM7V6/gdMt6nFDkMCObgXxjST6kcZ/u/TXOrkg0JG1dCy+U3O/OdooEtkAPNz3q3O4EHRpzOdy9p4OQjQuNOnkIF+VdHfsHfW3DLOZOiAKfAOyi0fCYBs5hMjIx6b+oW8WrPR8uCuRfmfKg2aM1MJO2r8WgE++mMAc83lTr4JXF5Ebdhr7I0smZtoUXJYgOTmNh2ubA5vs+ybojZ0lEe/jml30=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(81166007)(82740400003)(5660300002)(36860700001)(8676002)(316002)(30864003)(110136005)(16526019)(186003)(356005)(82310400003)(83380400001)(478600001)(36756003)(70206006)(70586007)(26005)(86362001)(47076005)(426003)(7416002)(8936002)(921005)(54906003)(2906002)(336012)(2616005)(4326008)(7696005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:59:33.0448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa385cc-a30f-43fb-6921-08d9731c5295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5559
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace uses of sme_active() with the more generic cc_platform_has()
using CC_ATTR_HOST_MEM_ENCRYPT. If future support is added for other
memory encryption technologies, the use of CC_ATTR_HOST_MEM_ENCRYPT
can be updated, as required.

This also replaces two usages of sev_active() that are really geared
towards detecting if SME is active.

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
 arch/x86/kernel/machine_kexec_64.c   | 15 ++++++++-------
 arch/x86/kernel/pci-swiotlb.c        |  9 ++++-----
 arch/x86/kernel/relocate_kernel_64.S |  2 +-
 arch/x86/mm/ioremap.c                |  6 +++---
 arch/x86/mm/mem_encrypt.c            | 15 +++++----------
 arch/x86/mm/mem_encrypt_identity.c   |  3 ++-
 arch/x86/realmode/init.c             |  5 +++--
 drivers/iommu/amd/init.c             |  7 ++++---
 10 files changed, 31 insertions(+), 35 deletions(-)

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
index 3d8a5e8b2e3f..8c4f0dfe63f9 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,7 +51,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
 bool amd_cc_platform_has(enum cc_attr attr);
@@ -77,7 +76,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
 static inline bool amd_cc_platform_has(enum cc_attr attr) { return false; }
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 131f30fdcfbd..7040c0fa921c 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
 #include <linux/efi.h>
+#include <linux/cc_platform.h>
 
 #include <asm/init.h>
 #include <asm/tlbflush.h>
@@ -358,7 +359,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       sme_active());
+				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
@@ -569,12 +570,12 @@ void arch_kexec_unprotect_crashkres(void)
  */
 int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 {
-	if (sev_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return 0;
 
 	/*
-	 * If SME is active we need to be sure that kexec pages are
-	 * not encrypted because when we boot to the new kernel the
+	 * If host memory encryption is active we need to be sure that kexec
+	 * pages are not encrypted because when we boot to the new kernel the
 	 * pages won't be accessed encrypted (initially).
 	 */
 	return set_memory_decrypted((unsigned long)vaddr, pages);
@@ -582,12 +583,12 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
-	if (sev_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/*
-	 * If SME is active we need to reset the pages back to being
-	 * an encrypted mapping before freeing them.
+	 * If host memory encryption is active we need to reset the pages back
+	 * to being an encrypted mapping before freeing them.
 	 */
 	set_memory_encrypted((unsigned long)vaddr, pages);
 }
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index c2cfa5e7c152..814ab46a0dad 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -6,7 +6,7 @@
 #include <linux/swiotlb.h>
 #include <linux/memblock.h>
 #include <linux/dma-direct.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
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
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
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
index ccff76cedd8f..a7250fa3d45f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
 
@@ -703,7 +703,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 	if (flags & MEMREMAP_DEC)
 		return false;
 
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		if (memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			return false;
@@ -729,7 +729,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 
 	encrypted_prot = true;
 
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		if (early_memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			encrypted_prot = false;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 18fe19916bc3..4b54a2377821 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -144,7 +144,7 @@ void __init sme_unmap_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/* Get the command line address before unmapping the real_mode_data */
@@ -164,7 +164,7 @@ void __init sme_map_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
@@ -377,11 +377,6 @@ bool sev_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
-
-bool sme_active(void)
-{
-	return sme_me_mask && !sev_active();
-}
 EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
@@ -397,7 +392,7 @@ bool amd_cc_platform_has(enum cc_attr attr)
 		return sme_me_mask != 0;
 
 	case CC_ATTR_HOST_MEM_ENCRYPT:
-		return sme_active();
+		return sme_me_mask && !sev_active();
 
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return sev_active();
@@ -424,7 +419,7 @@ bool force_dma_unencrypted(struct device *dev)
 	 * device does not support DMA to addresses that include the
 	 * encryption mask.
 	 */
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
@@ -465,7 +460,7 @@ static void print_mem_encrypt_feature_info(void)
 	pr_info("AMD Memory Encryption Features active:");
 
 	/* Secure Memory Encryption */
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		/*
 		 * SME is mutually exclusive with any of the SEV
 		 * features below.
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 470b20208430..eff4d19f9cb4 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
 #include <asm/setup.h>
 #include <asm/sections.h>
@@ -287,7 +288,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
 
-	if (!sme_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/*
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 31b5856010cb..c878c5ee5a4c 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/pgtable.h>
 
 #include <asm/set_memory.h>
@@ -44,7 +45,7 @@ void __init reserve_real_mode(void)
 static void sme_sev_setup_real_mode(struct trampoline_header *th)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	if (sme_active())
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
 	if (sev_es_active()) {
@@ -81,7 +82,7 @@ static void __init setup_real_mode(void)
 	 * decrypted memory in order to bring up other processors
 	 * successfully. This is not needed for SEV.
 	 */
-	if (sme_active())
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		set_memory_decrypted((unsigned long)base, size >> PAGE_SHIFT);
 
 	memcpy(base, real_mode_blob, size);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index bdcf167b4afe..07504f67ec9c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -20,7 +20,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/kmemleak.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
@@ -964,7 +964,7 @@ static bool copy_device_table(void)
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = (sme_active() && is_kdump_kernel())
+	old_devtb = (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && is_kdump_kernel())
 		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
 							dev_table_size)
 		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
@@ -3024,7 +3024,8 @@ static int __init amd_iommu_init(void)
 
 static bool amd_iommu_sme_check(void)
 {
-	if (!sme_active() || (boot_cpu_data.x86 != 0x17))
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) ||
+	    (boot_cpu_data.x86 != 0x17))
 		return true;
 
 	/* For Fam17h, a specific level of support is required */
-- 
2.33.0

