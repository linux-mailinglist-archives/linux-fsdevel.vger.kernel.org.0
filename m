Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CABF404187
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 01:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348117AbhIHXCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 19:02:14 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:61792
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236793AbhIHXBI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:01:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHt5JFVfCk4HCM3m823U3zmQONYZPzyqPRl5CiOFiOgEzg6jZutbLi/e68jcfp14h1OSmbGmvZacycLVB1mHNFnD9l9qReEcXNRvcdYoaUFjc6+Vklm89ASykdywlIWmIDYPE8WlmCwx4iEHIA/QlaPiTA/5e6hgIwHhunOICvH4o/ucJXKNOZhX/fLrfPkc0UeHuAwos2tGfYHVnSTBqSpACz4LQ+bLcO7/E0r9CdpWEUU/caPd1GdDZ5djE84OUb21Ae1edTs53l6w/sKs+f1w7EaORk6WGFD6VsBY/L7gJRneHrGntitm3Ar/fRxg7DLgDcl88De0rBfsPcldCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pAbXSnzMVH0GK/CW2FXN5UhmlkTk0+/+WVuMc/5XJUo=;
 b=CnbzFg9so8OTmPgYqfQe6NFUIE4B2aEjt+NDIKU2Zxzciet8a16R8PeL3hwjV0Y8y034uou90UXWVKMK4v8Nec3IU1frlemIf8QGO+x1dzDJR/CSEMRQ+7AzzLneDIotygdvVOJvfY5SjcFVUr2gBZ4O1wReXhD5s0DM3LW4xvlUvm3TZJYjQSdeyRbxRXxxxCuYAk6FCuBFZsL/pU91yY8uhAsvJ4fBEWNOuIMNDiBUj0+TTVcHgrJtaMBCTXmpmON33fNHqLPtfu25TF+cxzoKIitQqnisCdnc+tEg7jPZ6FhixZ5cNY2F+3XFAx34Ig5hDqc6ygF0QGTxHrx+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAbXSnzMVH0GK/CW2FXN5UhmlkTk0+/+WVuMc/5XJUo=;
 b=sVjHVH0tf1/WuGYOC09ygULECOPOkdVfjmBbgDEVBlaw3wH94xzKMCVrduBVsmQw8Hen8BH1GJ9V7mjizTdamdKFU2cVe36nIhUp48LIfQaU1fwQUpWogcU+HtKK/CQ7HJ5MZOkSqiBjBMLxY+Er6JzixQX7AdljgqxW0DRJw50=
Received: from DS7PR03CA0105.namprd03.prod.outlook.com (2603:10b6:5:3b7::20)
 by DM5PR12MB1595.namprd12.prod.outlook.com (2603:10b6:4:3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Wed, 8 Sep 2021 22:59:57 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::7b) by DS7PR03CA0105.outlook.office365.com
 (2603:10b6:5:3b7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Wed, 8 Sep 2021 22:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:59:56 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:59:54 -0500
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
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>,
        "Dave Young" <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 8/8] treewide: Replace the use of mem_encrypt_active() with cc_platform_has()
Date:   Wed, 8 Sep 2021 17:58:39 -0500
Message-ID: <46a18427dc4e9dda985b10e472965e3e4c769f1d.1631141919.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ed1e8dc2-5c5f-4917-df34-08d9731c60d9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1595:
X-Microsoft-Antispam-PRVS: <DM5PR12MB159500FF0F7985FD6E628D55ECD49@DM5PR12MB1595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVIPqPJSnCCaQ0M9Sp+ZGaflD02NrnyqEFsJFbWGbBZaaJ8VLhyUokqFcAKhxqthB0GQPXG02EPQEOMivaq+S3GHkv/75meekhTVoHODAMfwFqIS2CVysoJpMHyNjYyP+amZ8+Bs+bbg0AsjtO9GXZ5g4QiEnaFBfD+qlA+48UChnUSkPfoYdaF91NHZVYI+r51FNrafWcpRB6wHH5dGtk4VppCauexh7gwp3aOsfewXq4kqwbuCrxjnfe/DyfhIXwt3PKb0KTB15fuzl4hNLBOixCiOarx2FTi55IEybw2sQEnv1OtquaFZec9QmGBmP+7QvvrKD2vFkwMEJSSrdnAYZBkRFZK1xDNPQhYg/GG3rI2CdK6CKysXbXaB0XxayIkPi4azytga6Izpmyp9zaRs+BEgf4PYHcBy5Sivnuj5U/Wq8wkUEWtd2elOaZiyqw0qNRE9P/O9Mcy7Gq3G+FpRTJnpaqDoe1EsAPVvL7VfgyFH5ZC3EF8No71+HGGGZW8se7wixaveWRL1YYiEaehgALdvNOPCVXtupOl00MOPs8xvGnuBLfdi/XQbpXcDCkarjs7HVhdLFUp5T9RqT5X13I+M4X9BOqfYW1bqlZ6PhQnpHtn9XVLu6UUg726VtVY8Ct5aQ55+g9nxexvs/lrjwk9cZ/AhNObDQRZ6UvioKpN+Ijoa47SLHH9FMUkSjzI1FhxAm8IkdAaetUZV4nzJ/SkJ3WZLBIeUKv+xCcfq0x624LEtRefEGOHbY0fmIBc2uwWxTaQUJIj4Dqz0yMLUmjFlDYXqz6wmXDYTdlc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(82310400003)(316002)(110136005)(426003)(54906003)(30864003)(356005)(7696005)(8936002)(5660300002)(921005)(81166007)(36756003)(36860700001)(70206006)(186003)(26005)(16526019)(2616005)(86362001)(4326008)(70586007)(2906002)(47076005)(7416002)(7406005)(6666004)(336012)(83380400001)(478600001)(82740400003)(8676002)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:59:56.9876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1e8dc2-5c5f-4917-df34-08d9731c60d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1595
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace uses of mem_encrypt_active() with calls to cc_platform_has() with
the CC_ATTR_MEM_ENCRYPT attribute.

Remove the implementation of mem_encrypt_active() across all arches.

For s390, since the default implementation of the cc_platform_has()
matches the s390 implementation of mem_encrypt_active(), cc_platform_has()
does not need to be implemented in s390 (the config option
ARCH_HAS_CC_PLATFORM is not set).

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
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/powerpc/include/asm/mem_encrypt.h  | 5 -----
 arch/powerpc/platforms/pseries/svm.c    | 5 +++--
 arch/s390/include/asm/mem_encrypt.h     | 2 --
 arch/x86/include/asm/mem_encrypt.h      | 5 -----
 arch/x86/kernel/head64.c                | 4 ++--
 arch/x86/mm/ioremap.c                   | 4 ++--
 arch/x86/mm/mem_encrypt.c               | 2 +-
 arch/x86/mm/pat/set_memory.c            | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 drivers/gpu/drm/drm_cache.c             | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c     | 6 +++---
 drivers/iommu/amd/iommu.c               | 3 ++-
 drivers/iommu/amd/iommu_v2.c            | 3 ++-
 drivers/iommu/iommu.c                   | 3 ++-
 fs/proc/vmcore.c                        | 6 +++---
 include/linux/mem_encrypt.h             | 4 ----
 kernel/dma/swiotlb.c                    | 4 ++--
 18 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
index ba9dab07c1be..2f26b8fc8d29 100644
--- a/arch/powerpc/include/asm/mem_encrypt.h
+++ b/arch/powerpc/include/asm/mem_encrypt.h
@@ -10,11 +10,6 @@
 
 #include <asm/svm.h>
 
-static inline bool mem_encrypt_active(void)
-{
-	return is_secure_guest();
-}
-
 static inline bool force_dma_unencrypted(struct device *dev)
 {
 	return is_secure_guest();
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 87f001b4c4e4..c083ecbbae4d 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -8,6 +8,7 @@
 
 #include <linux/mm.h>
 #include <linux/memblock.h>
+#include <linux/cc_platform.h>
 #include <asm/machdep.h>
 #include <asm/svm.h>
 #include <asm/swiotlb.h>
@@ -63,7 +64,7 @@ void __init svm_swiotlb_init(void)
 
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return 0;
 
 	if (!PAGE_ALIGNED(addr))
@@ -76,7 +77,7 @@ int set_memory_encrypted(unsigned long addr, int numpages)
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return 0;
 
 	if (!PAGE_ALIGNED(addr))
diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index 2542cbf7e2d1..08a8b96606d7 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -4,8 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-static inline bool mem_encrypt_active(void) { return false; }
-
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 499440781b39..ed954aa5c448 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -98,11 +98,6 @@ static inline void mem_encrypt_free_decrypted_mem(void) { }
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-static inline bool mem_encrypt_active(void)
-{
-	return sme_me_mask;
-}
-
 static inline u64 sme_get_me_mask(void)
 {
 	return sme_me_mask;
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de01903c3735..f98c76a1d16c 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -19,7 +19,7 @@
 #include <linux/start_kernel.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/pgtable.h>
 
 #include <asm/processor.h>
@@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * there is no need to zero it after changing the memory encryption
 	 * attribute.
 	 */
-	if (mem_encrypt_active()) {
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index b59a5cbc6bc5..026031b3b782 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -694,7 +694,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 				 unsigned long flags)
 {
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return true;
 
 	if (flags & MEMREMAP_ENC)
@@ -724,7 +724,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 {
 	bool encrypted_prot;
 
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return prot;
 
 	encrypted_prot = true;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 47d571a2cd28..7f09b86d2467 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -432,7 +432,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
 	 * The unused memory range was mapped decrypted, change the encryption
 	 * attribute from decrypted to encrypted before freeing it.
 	 */
-	if (mem_encrypt_active()) {
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 		r = set_memory_encrypted(vaddr, npages);
 		if (r) {
 			pr_warn("failed to free unused decrypted pages\n");
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ad8a5c586a35..527957586f3c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -18,6 +18,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/vmstat.h>
 #include <linux/kernel.h>
+#include <linux/cc_platform.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -1986,7 +1987,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	int ret;
 
 	/* Nothing to do if memory encryption is not active */
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return 0;
 
 	/* Should not be working on unaligned addresses */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b6640291f980..c8973bbb7d3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -38,6 +38,7 @@
 #include <drm/drm_probe_helper.h>
 #include <linux/mmu_notifier.h>
 #include <linux/suspend.h>
+#include <linux/cc_platform.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -1252,7 +1253,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	 * however, SME requires an indirect IOMMU mapping because the encryption
 	 * bit is beyond the DMA mask of the chip.
 	 */
-	if (mem_encrypt_active() && ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
+	    ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
 		dev_info(&pdev->dev,
 			 "SME is not compatible with RAVEN\n");
 		return -ENOTSUPP;
diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 30cc59fe6ef7..f19d9acbe959 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -31,7 +31,7 @@
 #include <linux/dma-buf-map.h>
 #include <linux/export.h>
 #include <linux/highmem.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <xen/xen.h>
 
 #include <drm/drm_cache.h>
@@ -204,7 +204,7 @@ bool drm_need_swiotlb(int dma_bits)
 	 * Enforce dma_alloc_coherent when memory encryption is active as well
 	 * for the same reasons as for Xen paravirtual hosts.
 	 */
-	if (mem_encrypt_active())
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return true;
 
 	for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index ab9a1750e1df..bfd71c86faa5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -29,7 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_drv.h>
@@ -666,7 +666,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
 
 	/* TTM currently doesn't fully support SEV encryption. */
-	if (mem_encrypt_active())
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return -EINVAL;
 
 	if (vmw_force_coherent)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index e50fb82a3030..2aceac7856e2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -28,7 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
 #include <asm/hypervisor.h>
 #include <drm/drm_ioctl.h>
@@ -160,7 +160,7 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 	unsigned long msg_len = strlen(msg);
 
 	/* HB port can't access encrypted memory. */
-	if (hb && !mem_encrypt_active()) {
+	if (hb && !cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 		unsigned long bp = channel->cookie_high;
 		u32 channel_id = (channel->channel_id << 16);
 
@@ -216,7 +216,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 	unsigned long si, di, eax, ebx, ecx, edx;
 
 	/* HB port can't access encrypted memory */
-	if (hb && !mem_encrypt_active()) {
+	if (hb && !cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 		unsigned long bp = channel->cookie_low;
 		u32 channel_id = (channel->channel_id << 16);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1722bb161841..9e5da037d949 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -31,6 +31,7 @@
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/io-pgtable.h>
+#include <linux/cc_platform.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -2238,7 +2239,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	 * active, because some of those devices (AMD GPUs) don't have the
 	 * encryption bit in their DMA-mask and require remapping.
 	 */
-	if (!mem_encrypt_active() && dev_data->iommu_v2)
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && dev_data->iommu_v2)
 		return IOMMU_DOMAIN_IDENTITY;
 
 	return 0;
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index a9e568276c99..13cbeb997cc1 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -17,6 +17,7 @@
 #include <linux/wait.h>
 #include <linux/pci.h>
 #include <linux/gfp.h>
+#include <linux/cc_platform.h>
 
 #include "amd_iommu.h"
 
@@ -742,7 +743,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	 * When memory encryption is active the device is likely not in a
 	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
 	 */
-	if (mem_encrypt_active())
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return -ENODEV;
 
 	if (!amd_iommu_v2_supported())
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3303d707bab4..e80261d17a49 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -25,6 +25,7 @@
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
+#include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -130,7 +131,7 @@ static int __init iommu_subsys_init(void)
 		else
 			iommu_set_default_translated(false);
 
-		if (iommu_default_passthrough() && mem_encrypt_active()) {
+		if (iommu_default_passthrough() && cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 			pr_info("Memory encryption detected - Disabling default IOMMU Passthrough\n");
 			iommu_set_default_translated(false);
 		}
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9a15334da208..cdbbf819d2d6 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -26,7 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <asm/io.h>
 #include "internal.h"
 
@@ -177,7 +177,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, mem_encrypt_active());
+	return read_from_oldmem(buf, count, ppos, 0, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 }
 
 /*
@@ -378,7 +378,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, mem_encrypt_active());
+					       userbuf, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 5c4a18a91f89..ae4526389261 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -16,10 +16,6 @@
 
 #include <asm/mem_encrypt.h>
 
-#else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
-
-static inline bool mem_encrypt_active(void) { return false; }
-
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 87c40517e822..c4ca040fdb05 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -34,7 +34,7 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/scatterlist.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -552,7 +552,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (!mem)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
-	if (mem_encrypt_active())
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
 	if (mapping_size > alloc_size) {
-- 
2.33.0

