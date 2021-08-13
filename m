Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296B33EBACB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhHMRBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:01:38 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:31040
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232353AbhHMRB0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:01:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biy3/f84eFwEuRGCmKjUUDAdKa5EG9tnFFMeZJacuzmcam6jmshxAShh5jcdAlAYhOGgaNI6XiaAUnBZc8ulVJgYPDFQCj8c+RgYID4lbxGIvSpZADMYjzis8OyWN0iS7mvn/FhLy+wcisKwuYP58Xbzmg5kbpZ5lezMT+edqpakkILjEkWcV4fUD5fE2LCXQ+h/rn5kDx+OUXvRmJv2VxY/VVP7QFPiCNxo21yitysjmhULuBM3OinEWaAmkU3+K9J+StOB3R60LVzevhZyjMNngu0ar/uACy6g7ErUgAGib8T5OgUBwRos+FonE03LM0mufcotEgPhSumJOaOd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS89hcqMwe7EoxI5TduLuxWOvUcTVrJpMGl7N4hehBg=;
 b=RHAwjxsPbEV0SGAyxUaUmxndDi9Tj1xj3QOntJJavewWt1gYFuov5PeNG72n4Lz0Hu/u/xxkdMLmfmSNHjxaV8kS706tgMEptqm5BAKWlhyDHOtPj6yEtN72/TDBn1cX+72cTyK7oNu63+4xapwG2Dqm5iQeIdsQQizxwkWnhhhPblFPV+ClemSjpCK5XWKyn2RmAWxkDWSuxwgWGV9kWzibZx0ImiAsc/JPyHqolgtVfNOuzgN+DwADeiwZpKPHFsdMppW4nERedIyJvG8E/VGPzSnwDxjvLitMjO60jP5NjQj5bitcg3h062SSkMt/OHHBF3c+oZoubC8XBvxOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS89hcqMwe7EoxI5TduLuxWOvUcTVrJpMGl7N4hehBg=;
 b=gvXiKcovFpK+dImwW8LzEhBIb5GWgA787VwzGUj84eDUBtE3tDXyJkkRaGnxeNzizk31QzUblGNz76YIwBzzPPB9O54e48P9a2ruRslEOo8Et4lc8nErh6LfGBWVN67iJ6b+WBYdfwfJBGPRdwkKOiHWX6NNSOGtHgZgSMRZXQA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 17:00:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:00:56 +0000
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
Subject: [PATCH v2 08/12] treewide: Replace the use of mem_encrypt_active() with prot_guest_has()
Date:   Fri, 13 Aug 2021 11:59:27 -0500
Message-Id: <c277c4dff8f4da9d56472cdbe552c0f1f2705875.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:806:23::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR13CA0084.namprd13.prod.outlook.com (2603:10b6:806:23::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Fri, 13 Aug 2021 17:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22e4e42c-e99c-4aa9-7ef4-08d95e7beafd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5247:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5247F27421B4BBCC2949B99DECFA9@DM4PR12MB5247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJovpUeenkaYK/gzqNnCjSuaDjP8K0LliQz2RtrUzEx2zuTeUuX+Qxj5p5tIwzEZOY91L3vLLLythssLihLbIbZY4it1r5qKuoTcXYThJCdAmehvEkZEvsWQTNGfrUD8p9HQgSjQscA0Tu5Zp0J4MSBJOvvsyiw0pXsg3Ig0zgUagfrZV4EYuOUFtpP4+YuXW3nP6NyyTCEIB/nklNNGOBj1gaPvZn1sRBCimGyl6cNjM+zsI3iADUkm62yt+L/PuvRwTm3+WBiF/t33dyNvP2Dbs8dkTjHY78dAeBQ9ExAL2G6suOnCnoSmoPu7TGeQnAMSOcaxAJYEu1FaW5PKEeY1hWFdctJXBIZqjfSW7Nly3v8LoGD/mNU6V3uW8tFMJmq7Oi9C4P1DwFK+kznQsSx5A2dhlbyJsrg/eQjYfoZDCWBdETvdCtDpVYd1YBTk8+TNXH//9hT7BzFEhADJgJWK3WbHW2XJ27kQaAzEcktbGua/GVi8FzwS4fP0GYBqgIhmwkei1qaxM/F1eDEQNXrOJt+8pes3Qbh3gLnnyJDJDrllh36xkfI4Ywx4mpDBaM7MtbMD3iI8dLGdpi2ud35LoxLjckxP9zuZgzERkuN9w7Gp9d+dKkI15ET2CZAKPIoZqack0UGa6A2OXXcjkxPs0FEh2PrigLDQfEisxDztH0NADx9BQFOeea9U0NUA4eqtrNQt/zxmGt0T/IK2Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(30864003)(186003)(956004)(83380400001)(2616005)(86362001)(921005)(2906002)(66476007)(5660300002)(7696005)(6486002)(478600001)(8676002)(8936002)(66946007)(7416002)(4326008)(52116002)(66556008)(7406005)(54906003)(316002)(38350700002)(36756003)(6666004)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q3/sC8I5EunXCVECJ2Bar9gLYh0NZC7rcWs9hjvbfQQtr84IgIt8uDq/SGNS?=
 =?us-ascii?Q?XbW2vXX4IDXr3B13aOM/CoNCcfOb+LFkJGmu5uV07yMBYNCnMIg98ELkHJPI?=
 =?us-ascii?Q?lUv1DZ9nZyHe2os2OagsdUfqeiSogE3/QGdoTpaFELotUp1VgKqDjPDvi0wO?=
 =?us-ascii?Q?FXc4eY3JodaKj8WJE/1TZduKhVeNQd3Hg20Ik4ZcaXa7rW6UsqenA+/VYM6g?=
 =?us-ascii?Q?AgH7BT05afOKpl2YX9k6KbDqVhtntgZ/L/6fEKOWrwZmoSB2GjDd/UIN/yOn?=
 =?us-ascii?Q?O78q3vpWN276BLQbNl0PVf9CTI/fPTg97+ElPCzo9ZFRJ5DYtl3mjMuhKhm8?=
 =?us-ascii?Q?Kc4Dl19N3qr+dCUzze90xToy5t9YOLQF0Dvxx/BnZ2PgmDIVdlmnrLUMM+GJ?=
 =?us-ascii?Q?c+htAbEVUEXtyGXaLlClhoB+0z6WD++QtdqoQtRr4UTTGq5+BPV/nCE0Yz9h?=
 =?us-ascii?Q?5Sy7HI9JScY7V3Mw1hJ0ebjlBMEsDqbandDg+UIBBCuKtQSrzDQyAonNemF2?=
 =?us-ascii?Q?H4CtvqATmIVdgrQogRY5fh6X5qLdgcALmS6tuI1rapbyru7faRJasHg9mPwM?=
 =?us-ascii?Q?majuZ+Y5XCLLlEnjTbS8Ac6ctolPT4fnzwYJXKva/QeMubJPfexBwSM1CdYv?=
 =?us-ascii?Q?PavRpqr7pi8mpICOIuNZO8yud6lQzenV/YLACGBWRyPEZr3e8Rojp4/sGiyR?=
 =?us-ascii?Q?HvNJCs1AIgScY+ehToEBH+c+B4EAp16IDjIKSd7QQuJW/omALiZbSVrxyMIV?=
 =?us-ascii?Q?rca/TxbiTFSqGdRuAUuyiw4POkJHPmbZGYLBCW0RfCFLFKfIP3nwjPrgZU44?=
 =?us-ascii?Q?OCK1gsThPK22zTCMpZWXquETirR11fL1rNFsnY+eQTThAN+O870/KXVU4Gyi?=
 =?us-ascii?Q?rGkqLzC6/lM8n85YAnAyqFLoe1uwQngvCP9E/UQUVjw0P/GNR4tLGJ8poglZ?=
 =?us-ascii?Q?Mf12nw66+1gcZhB7/5L0z4gM9MNMclHARIBaIWraZe3AblgMou6dEl8qvu8C?=
 =?us-ascii?Q?N50UKRsYH245yM4UjwLVH/SP2Hnv3btBH/VPlEUsUa2KLhMlZXfOwWBGrSII?=
 =?us-ascii?Q?hmdE4xVxfaN4SzJS31d6z+Q6NmD0+N4LYh/uWFdEqkUgefkYuNAH0J/R6JbH?=
 =?us-ascii?Q?7nuqU5ZHWrFqXVv36oYdmjBYrAdA5v7l43VF4rpVvWHiXGYwkLNcjZV+espM?=
 =?us-ascii?Q?gw6qoXVPFeFdMskvOu0tgQzYEp+igD3ywLvoqXiJCVSRP5JYw0YCpFMwQEJM?=
 =?us-ascii?Q?4NXQvIUHhzqth7OCUqkTqydgC6Gm90b04XcwgC4QnmIXVC1bzhZmcSFkA0wt?=
 =?us-ascii?Q?nBIlNszjPFYnVKhs05dydWYb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e4e42c-e99c-4aa9-7ef4-08d95e7beafd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:00:56.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfhKWp/BVVTVNPSxPqgT9l1GCuVDlUniZcN1NoRdgkOS8M67DkuhcMJAZDxTa6QepDBEb9gMwN3jBUVn8F5K6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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
index 3ed0f28f12af..7f012fc1b600 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -694,7 +694,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 				 unsigned long flags)
 {
-	if (!mem_encrypt_active())
+	if (!prot_guest_has(PATTR_MEM_ENCRYPT))
 		return true;
 
 	if (flags & MEMREMAP_ENC)
@@ -724,7 +724,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 {
 	bool encrypted_prot;
 
-	if (!mem_encrypt_active())
+	if (!prot_guest_has(PATTR_MEM_ENCRYPT))
 		return prot;
 
 	encrypted_prot = true;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 38dfa84b77a1..69aed9935b5e 100644
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
+	if (amd_prot_guest_has(PATTR_MEM_ENCRYPT)) {
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
index 971c5b8e75dc..21c1e3056070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -38,6 +38,7 @@
 #include <drm/drm_probe_helper.h>
 #include <linux/mmu_notifier.h>
 #include <linux/suspend.h>
+#include <linux/protected_guest.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -1250,7 +1251,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
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
index 45aeeca9b8f6..498f52ba08ea 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -29,7 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_drv.h>
@@ -633,7 +633,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
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

