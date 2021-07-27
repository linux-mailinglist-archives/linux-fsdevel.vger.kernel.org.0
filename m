Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E727E3D82B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhG0W1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:27:54 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:18473
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233452AbhG0W1x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:27:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxzWBhreMMwJPX9lE72++1lM3L7PG9RHGRHN03FMY8qX1fpkojVjf3LnHVA8ZF0fErxnpEbT7LxhNdfgBPV1tAhlQrmb8Nv882eaYg0Rpvv2+5KH81ZTDmr+N+hjGTTooyyaOuUO+ojnGE99Yo0WqXgjq3wwG1bR91Sxoi0A+t5JE9H6wwHcC5ptDQL5HThNIe2bC8XhcYxS8nyIjKDSiYVjYlr/IyPDNzKAvuMNaHsAiPcGaLYm8FK+ElcJjmwYqPLzFuGDa/Y+hKX2MqbsVWpwFW+l6ZlVfw86YF8lOWOD74pMWQQsmY16Q1e2Rjvn4IXHDn0FbRaBrMMSl5Vg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yloAMUO+RwdsU4/084NnOlABsXs5acuME6BK0MxSSDU=;
 b=FrKoL7WbW6EuyDHC23LTVg+MrzAbxzXpEl32FgIfljvyKBH2Nl6mP16+SBO7VYbJTwmOB/84KhUJRhCcFaAZS3NXCmYpUSybF+fpwbqYstPorwH+cJPYJGgfR57tdhKeLrD52WmzT8ai7gNuYbjfI4ymm1V1W0f23QleLZcTrYJNcJMuNEkiN0PIHJStP97uc6tWI/CBvo8F/W2aZbQZgyFjt2YLr+3VNRbmzIgC3zpM9oUrPWBEvMNf8CqgOy8Vrh8pUGy6HDler96hylO2+zK64EABf2S7USdEcpRvKhe1lTdLvHMJmC8rZVDPi9DFmNog1GL6ubLivW12Q/bmIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yloAMUO+RwdsU4/084NnOlABsXs5acuME6BK0MxSSDU=;
 b=lCVDf7uAbHz/pSg6ZO8hIW6ZBxvqhNvtjydpz9+agV30hdMcO9dKkpmDiKg3VI768thVVldBWga5PmMoRIFxqUa+RXP71iFH+cwKS6QbJC4YSmSQ0rgvygxBI+VIZIE9l6HeEJEbZa0mbh6A5/6dIBzcdiuxNSrMKYyhTSyx1sg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:27:50 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:27:50 +0000
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
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active() with prot_guest_has()
Date:   Tue, 27 Jul 2021 17:26:10 -0500
Message-Id: <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:806:d2::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA0PR11CA0067.namprd11.prod.outlook.com (2603:10b6:806:d2::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Tue, 27 Jul 2021 22:27:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0b4bccc-6e99-4649-744b-08d9514dc4cf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53577FC107BBC605CA44D521ECE99@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jyPEzYYetNfS/96tbOpz6UY2+9HOCXb15TwsckxIW6jaEHLtZrOLpPgVlrqFCvb3wZzh2F22PtWY7gZ+JlIg4EeCnRJ7BO8fLFOv9xtPYGtwTROzSG9ncGLqBt0D9TAiY0uGqzElvHJZiEl7CxIt9GSXPZEHdZWs/GBWmrUtupiILRWdNIoHwoZOSlDCH/9fpC93nDh12o/l8U8VPvENtUqhG3PirES7frPHW7aap12ovhjajfB+WLIceSUEl88HtF+638TuMWYbg0nGyFWy0jB8jfbruAgUD87S81nr4t1iojW3QBtvCTEjTPeFN2fos2mnpCyfX/RwJs3lHZ4pggGAcVFlD77CCtupw2bNUYtP/k2o+C6cjFyg/EK+6gU5JHKoc5C5FRRQcznC1LTspIphGEymFRQ+1qom9Y9SG381Jkl1G1PiPUKrlunesFJ78VDcCPPluhKgWGiVVs8z3j+rw1Twjz2WsCkMXXxEW9xiWSGjT7uw8Q1K5LQWhGRUvMFiRb3pQJLggV9OglGG5zHrSJKfEiwDJD9G9ZEM+88d6GajwpUKcXh10bv6fxdNQMPlJLVO35dpaRJeMaDY3I6sj6ahaBSJOt8p3xcYvTOheyrfW4b8wmtmcev8iYB1dX35rQX+WPSSWmHp3eXY3jT6iFbdfOvPC68rc8Pp4x3pSrG2eqyHTlCJi2I9cnJkAIFCwVXWG2DCztFPTAE5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(5660300002)(36756003)(54906003)(83380400001)(956004)(66556008)(4326008)(316002)(86362001)(8676002)(921005)(2616005)(66946007)(38350700002)(38100700002)(66476007)(30864003)(7696005)(2906002)(6486002)(7416002)(7406005)(478600001)(26005)(6666004)(52116002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJISa5zeWLWfc4W3JhiFpSpziGzZXqgFFU+3GkQZuGEZLkaoWVtWZizk61TC?=
 =?us-ascii?Q?KmApzYkGSSlORaeyxYskejU+UER5iQyP7peB92LwnLJNwa+GS//WLO5mgdz3?=
 =?us-ascii?Q?IOmhR+ttpw6/7y0ubAZsGwPe0Tncp+vXVqiTuEuWb2nyAwCBOGRCKCSolG4v?=
 =?us-ascii?Q?ORhske6NuqKbMBCAYMkfWNg/OoWUMQZbTbbSK5oTSOGpIUD1HEzCGA4c4k95?=
 =?us-ascii?Q?SA+NtBi0edmtqiQvmeBaGZ6hBrwyM9Wd3OiIR1BT+juJzV+re7GhzYetmoJW?=
 =?us-ascii?Q?OYsP83KTDb1z4ab+1UCatLrMNkcs0X12qkhyapd0EveN2rEghim2xMNwsTfg?=
 =?us-ascii?Q?k/AopH1ne24NWNspYrpg1mqKcOeAEvIEhBP43JUnzwwsANHcb2CjhZRmpKa2?=
 =?us-ascii?Q?CRtvYjbo/fr6Wd5HNvcFU8ML2t6tXozyKGNI65otZKr6sLXB5MJbmtE8WK04?=
 =?us-ascii?Q?rAFITD6jmulPq7J6as2D9rESbqg7uwkjYyhGluQj3f+ZZbA7c84x/svzVNvb?=
 =?us-ascii?Q?M+LlLtXMHSGWfg5SKY7OWBasmshseO8gfS1563PDsVdXz46tsp7DvzYuj48F?=
 =?us-ascii?Q?O6F19dDfKJTtMOPWkfQ+txrNLSue1aVPUcHuCgZ/aXmH/c8/Nd3YxTgnYkaG?=
 =?us-ascii?Q?hlpGZnMyWOXfDgpQp8OjkuwpzmFOGK61Eaz4L+i2SbbAcaz8/Dgc7DM6qv7O?=
 =?us-ascii?Q?160hpP8KMGgsQ1hHC1ZiljRH9xBoXSL17sAN1wM6xNp6cRCwxLtgvb2ViGrU?=
 =?us-ascii?Q?1UzBTxyDpWzRhu4Js9aMXf6oOf42XukFZeZ3xUfEgHI3N39wlZbtQOwShWdq?=
 =?us-ascii?Q?W2lC9t9WBBro7NqnUdWXx8DQ9T4RNImxduWp4uFqALOBEmc1RaSlCvMB0/NC?=
 =?us-ascii?Q?FuscRG0BKeEXxxR5pBj0cHDY8OkpL9/C0VitBmkj9cXIZaDe5jqvl5J7xTR6?=
 =?us-ascii?Q?DP55iZO1lhAdKNvJxhzV60Hygyr33HVX8yX7UxKEqe+6saJ/9gSy1iV+9qXy?=
 =?us-ascii?Q?Gj/mEVwcnteDxsH9p3ANAoy/QtY9XjVLvnMo88zr1C6wie6jlW9PvxyYkLUP?=
 =?us-ascii?Q?s4uqyg2VhXFRsrzVZtsHC4mXObPMmrLztdU+MsX1XpM46jQl1g1gxJySmkv7?=
 =?us-ascii?Q?3lxIvWTrQKggtZ6D1pydkqEfMiKHeDvgVx9NEYjlhUUW9+2oj6BpG8diY9B4?=
 =?us-ascii?Q?0At2UjKrj285G/7bN/BysXSB000D9w0hWPlzT6xBuHUjIns+ylc7iZOoE9Ks?=
 =?us-ascii?Q?Kx6yJ4kiQ+XlMzftX7UDKb5mB3kcgvhZdiIoBZ3BUHJT+kjADlgx78szqQTl?=
 =?us-ascii?Q?DEf6q8haHys1MkffpMfUelLr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b4bccc-6e99-4649-744b-08d9514dc4cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:27:50.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT0JkKyc9yzPTtmXWr5koQhEZg/joSuXTk+YSF1SO1wjtu9zvHm24d98DLwy9GC+cDegCx9t3YwHFLLTN+KwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace occurrences of mem_encrypt_active() with calls to prot_guest_has()
with the PATTR_MEM_ENCRYPT attribute.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/head64.c                | 4 ++--
 arch/x86/mm/ioremap.c                   | 4 ++--
 arch/x86/mm/mem_encrypt.c               | 5 ++---
 arch/x86/mm/pat/set_memory.c            | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 drivers/gpu/drm/drm_cache.c             | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c     | 6 +++---
 drivers/iommu/amd/iommu.c               | 3 ++-
 drivers/iommu/amd/iommu_v2.c            | 3 ++-
 drivers/iommu/iommu.c                   | 3 ++-
 fs/proc/vmcore.c                        | 6 +++---
 kernel/dma/swiotlb.c                    | 4 ++--
 13 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de01903c3735..cafed6456d45 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -19,7 +19,7 @@
 #include <linux/start_kernel.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/pgtable.h>
 
 #include <asm/processor.h>
@@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * there is no need to zero it after changing the memory encryption
 	 * attribute.
 	 */
-	if (mem_encrypt_active()) {
+	if (prot_guest_has(PATTR_MEM_ENCRYPT)) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 0f2d5ace5986..5e1c1f5cbbe8 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -693,7 +693,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 				 unsigned long flags)
 {
-	if (!mem_encrypt_active())
+	if (!prot_guest_has(PATTR_MEM_ENCRYPT))
 		return true;
 
 	if (flags & MEMREMAP_ENC)
@@ -723,7 +723,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 {
 	bool encrypted_prot;
 
-	if (!mem_encrypt_active())
+	if (!prot_guest_has(PATTR_MEM_ENCRYPT))
 		return prot;
 
 	encrypted_prot = true;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 451de8e84fce..0f1533dbe81c 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -364,8 +364,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 /*
  * SME and SEV are very similar but they are not the same, so there are
  * times that the kernel will need to distinguish between SME and SEV. The
- * sme_active() and sev_active() functions are used for this.  When a
- * distinction isn't needed, the mem_encrypt_active() function can be used.
+ * sme_active() and sev_active() functions are used for this.
  *
  * The trampoline code is a good example for this requirement.  Before
  * paging is activated, SME will access all memory as decrypted, but SEV
@@ -451,7 +450,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
 	 * The unused memory range was mapped decrypted, change the encryption
 	 * attribute from decrypted to encrypted before freeing it.
 	 */
-	if (mem_encrypt_active()) {
+	if (sme_me_mask) {
 		r = set_memory_encrypted(vaddr, npages);
 		if (r) {
 			pr_warn("failed to free unused decrypted pages\n");
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ad8a5c586a35..6925f2bb4be1 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -18,6 +18,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/vmstat.h>
 #include <linux/kernel.h>
+#include <linux/protected_guest.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -1986,7 +1987,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	int ret;
 
 	/* Nothing to do if memory encryption is not active */
-	if (!mem_encrypt_active())
+	if (!prot_guest_has(PATTR_MEM_ENCRYPT))
 		return 0;
 
 	/* Should not be working on unaligned addresses */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index abb928894eac..8407224717df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -38,6 +38,7 @@
 #include <drm/drm_probe_helper.h>
 #include <linux/mmu_notifier.h>
 #include <linux/suspend.h>
+#include <linux/protected_guest.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -1239,7 +1240,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	 * however, SME requires an indirect IOMMU mapping because the encryption
 	 * bit is beyond the DMA mask of the chip.
 	 */
-	if (mem_encrypt_active() && ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
+	if (prot_guest_has(PATTR_MEM_ENCRYPT) &&
+	    ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
 		dev_info(&pdev->dev,
 			 "SME is not compatible with RAVEN\n");
 		return -ENOTSUPP;
diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 546599f19a93..4d01d44012fd 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -31,7 +31,7 @@
 #include <linux/dma-buf-map.h>
 #include <linux/export.h>
 #include <linux/highmem.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <xen/xen.h>
 
 #include <drm/drm_cache.h>
@@ -204,7 +204,7 @@ bool drm_need_swiotlb(int dma_bits)
 	 * Enforce dma_alloc_coherent when memory encryption is active as well
 	 * for the same reasons as for Xen paravirtual hosts.
 	 */
-	if (mem_encrypt_active())
+	if (prot_guest_has(PATTR_MEM_ENCRYPT))
 		return true;
 
 	for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index dde8b35bb950..06ec95a650ba 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -29,7 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 
 #include <drm/ttm/ttm_range_manager.h>
 #include <drm/drm_aperture.h>
@@ -634,7 +634,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
 
 	/* TTM currently doesn't fully support SEV encryption. */
-	if (mem_encrypt_active())
+	if (prot_guest_has(PATTR_MEM_ENCRYPT))
 		return -EINVAL;
 
 	if (vmw_force_coherent)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 3d08f5700bdb..0c70573d3dce 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -28,7 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 
 #include <asm/hypervisor.h>
 
@@ -153,7 +153,7 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 	unsigned long msg_len = strlen(msg);
 
 	/* HB port can't access encrypted memory. */
-	if (hb && !mem_encrypt_active()) {
+	if (hb && !prot_guest_has(PATTR_MEM_ENCRYPT)) {
 		unsigned long bp = channel->cookie_high;
 
 		si = (uintptr_t) msg;
@@ -208,7 +208,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 	unsigned long si, di, eax, ebx, ecx, edx;
 
 	/* HB port can't access encrypted memory */
-	if (hb && !mem_encrypt_active()) {
+	if (hb && !prot_guest_has(PATTR_MEM_ENCRYPT)) {
 		unsigned long bp = channel->cookie_low;
 
 		si = channel->cookie_high;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 811a49a95d04..def63a8deab4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -31,6 +31,7 @@
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/io-pgtable.h>
+#include <linux/protected_guest.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -2178,7 +2179,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	 * active, because some of those devices (AMD GPUs) don't have the
 	 * encryption bit in their DMA-mask and require remapping.
 	 */
-	if (!mem_encrypt_active() && dev_data->iommu_v2)
+	if (!prot_guest_has(PATTR_MEM_ENCRYPT) && dev_data->iommu_v2)
 		return IOMMU_DOMAIN_IDENTITY;
 
 	return 0;
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index f8d4ad421e07..ac359bc98523 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/pci.h>
 #include <linux/gfp.h>
+#include <linux/protected_guest.h>
 
 #include "amd_iommu.h"
 
@@ -741,7 +742,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	 * When memory encryption is active the device is likely not in a
 	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
 	 */
-	if (mem_encrypt_active())
+	if (prot_guest_has(PATTR_MEM_ENCRYPT))
 		return -ENODEV;
 
 	if (!amd_iommu_v2_supported())
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5419c4b9f27a..ddbedb1b5b6b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
+#include <linux/protected_guest.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -127,7 +128,7 @@ static int __init iommu_subsys_init(void)
 		else
 			iommu_set_default_translated(false);
 
-		if (iommu_default_passthrough() && mem_encrypt_active()) {
+		if (iommu_default_passthrough() && prot_guest_has(PATTR_MEM_ENCRYPT)) {
 			pr_info("Memory encryption detected - Disabling default IOMMU Passthrough\n");
 			iommu_set_default_translated(false);
 		}
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9a15334da208..b466f543dc00 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -26,7 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <asm/io.h>
 #include "internal.h"
 
@@ -177,7 +177,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, mem_encrypt_active());
+	return read_from_oldmem(buf, count, ppos, 0, prot_guest_has(PATTR_MEM_ENCRYPT));
 }
 
 /*
@@ -378,7 +378,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, mem_encrypt_active());
+					       userbuf, prot_guest_has(PATTR_MEM_ENCRYPT));
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e50df8d8f87e..2e8dee23a624 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -34,7 +34,7 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/scatterlist.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/set_memory.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -515,7 +515,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (!mem)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
-	if (mem_encrypt_active())
+	if (prot_guest_has(PATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
 	if (mapping_size > alloc_size) {
-- 
2.32.0

