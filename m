Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE06240416E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 00:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348324AbhIHXA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 19:00:58 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:4672
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348227AbhIHXAw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK+uq5UNPaGTXNz6UE1tiT3oak56dtHi5e914fB/K/3fdLqSzgJN0Ji4LmayArUKxLqyGgmf9eWgQgHcihXUxP2C8f4dipBpxCINhv3E5HA3D7Ip5dhHOOmF3/E4UfX4xLyX9rEuXUQDen94fH4FdsjyzAjf7RtpYl+Uo3J/GZ61U/mzyLzQPVodF2tNco4ws65mK4/iDVrIVaOA9FyDBjoPrq/Htg2uxPmNx9YzVwTbwXHw0n1AstRq/uD4NJv+eIvGEBhkmp9Wr3nRmR7LkPmgtdvZAxBCJDeb3SBj69W3UOti/NAPjPgLL9m4ymBFL4UdPVDaYm0rab4vCh7bOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcYjtjS6Lun9L7G9/pzKuTBmSrMUa9j0IajUfCrj0LA=;
 b=BWpe2D958oLWZpJ6ypf1uNmBj5Qdax5sEs+Q99RV2CdzSPkyikgDsH4FTWXKSZFFtsPY+XO+nIwQqb5DmDcrF422RpKhLQH6djLQrGLeUu2EgQkkXUmqpcApwjF55yKTIST+wdk6LQ0ajnJAnMVHkSrFh47oLjhnnIUEybumddv0GHjcrM7rcjyd+8ypaT9A7zavCVdyTcEnOKCDv88Yc8fLSRlaCTbqcsx1sE0h2Yg/nxNU5UdXleIt/gOzL1NgR8Q/hE4SgLGhp36ttk83swdBY0+MpiI98pzsDSW420VKDku3bFOSXu/PyCiR4KUA9vbxRBO6CEozqyYObLUJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcYjtjS6Lun9L7G9/pzKuTBmSrMUa9j0IajUfCrj0LA=;
 b=QvCwtZOf8fIEfH456F82EjKoKsGsZKHn4imk5xUlV3kgDBPnn1FckBv0b8jbxb9wRmadXVX5pCSbTR8IUeloqDZ4ul7BBAjLHVjaPfIcIyc2BWS30y7521z44gOi4VimygiAP4sgeOnVd/0ClcpV2xn8gynnnnhHlaBQaxJ5VG8=
Received: from DM6PR18CA0009.namprd18.prod.outlook.com (2603:10b6:5:15b::22)
 by DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Wed, 8 Sep
 2021 22:59:41 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::e8) by DM6PR18CA0009.outlook.office365.com
 (2603:10b6:5:15b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 22:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:59:41 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:59:39 -0500
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
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 6/8] x86/sev: Replace occurrences of sev_active() with cc_platform_has()
Date:   Wed, 8 Sep 2021 17:58:37 -0500
Message-ID: <bcc39c8b469aeab871e12f8a6c1d3484a95f615c.1631141919.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7abcee76-9506-4867-dcc7-08d9731c5753
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3002528AC0C8E2CBDD714650ECD49@DM6PR12MB3002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuHKXyw07yXpJ0pFACxm70x+E/jgkTUdxcdTcfdmTUrYS18SqMHzO+UKIWFg7Ff7xzLXgzoAKKX+Ltbmd8z4NV2ErkcZlvI/CJO9G2n/C6bT7CVCR3C2vnJeIKk7GVBNST/pYXekk52f4XtuLTrC5dfeMQbnNboHst+gg/TpeD/iPkRHvjagXxAO7OYuBRqdg12wsKCBScCgUYLyvDNF9mHLWCuXGgUHvbJ5LrY6TNvBmSfTo1hbawNU980vkAM2uWlWq2rBvv4y9eqOVjAYbVJVTBcGYlJWzbHJuqFpoEguQnr22nppnOvmgC9hSxnC2BPke+/mRlWX28nLOblX/kGogPJOv/m0ARoTp6cOkiGD11FxiHCHD2S03CHntyieTqulHDvHuUIGE1mgHxkwdCPYP3JunY4jkTVAMUWLIppJx7hOld4Llg7vR8Zm2SscfeloCM6u6b6kBVCG2MrXko+Fjk47JoFWIzPPSNusRRXT81fOwXWs7UMWSXpKbAV6p6I5DLjYUgaBrxtu/jj4qS8gu3jBK933s3jrr4YNQhsj594EIt74Yhn9RP9bzSUZDqRSJfyPr0JZdc/DbLpr7RC7Wl6t84hhE/TFWxm41/vDe9ZmZf8CmLVde8SNGd0u/h1ga+P9dpA5oh21QxYEjMjyNCU7A5VBqW1mJyvQqumH9RqCI/LKZcbGPRt7e+Mv1v52mVk9f4Mz5f7gbfUpMptiMA5SMS+1BlHZrwcnfZqsN2rhX7G8WNu7ptxZtdwSfK6o0zY3aZqPYT8OaK/yi1o0rCVhjfLwCfTY8vfQOic=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(26005)(186003)(86362001)(336012)(8936002)(5660300002)(82740400003)(7696005)(356005)(16526019)(110136005)(70586007)(7416002)(2906002)(30864003)(47076005)(921005)(54906003)(478600001)(426003)(2616005)(81166007)(36756003)(70206006)(82310400003)(4326008)(83380400001)(36860700001)(316002)(8676002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:59:41.0028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abcee76-9506-4867-dcc7-08d9731c5753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace uses of sev_active() with the more generic cc_platform_has()
using CC_ATTR_GUEST_MEM_ENCRYPT. If future support is added for other
memory encryption technologies, the use of CC_ATTR_GUEST_MEM_ENCRYPT
can be updated, as required.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |  2 --
 arch/x86/kernel/crash_dump_64.c    |  4 +++-
 arch/x86/kernel/kvm.c              |  3 ++-
 arch/x86/kernel/kvmclock.c         |  4 ++--
 arch/x86/kernel/machine_kexec_64.c |  4 ++--
 arch/x86/kvm/svm/svm.c             |  3 ++-
 arch/x86/mm/ioremap.c              |  6 +++---
 arch/x86/mm/mem_encrypt.c          | 25 ++++++++++---------------
 arch/x86/platform/efi/efi_64.c     |  9 +++++----
 9 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 8c4f0dfe63f9..f440eebeeb2c 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,7 +51,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sev_active(void);
 bool sev_es_active(void);
 bool amd_cc_platform_has(enum cc_attr attr);
 
@@ -76,7 +75,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
 static inline bool amd_cc_platform_has(enum cc_attr attr) { return false; }
 
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 045e82e8945b..a7f617a3981d 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -10,6 +10,7 @@
 #include <linux/crash_dump.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/cc_platform.h>
 
 static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 				  unsigned long offset, int userbuf,
@@ -73,5 +74,6 @@ ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sev_active());
+	return read_from_oldmem(buf, count, ppos, 0,
+				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a26643dc6bd6..509a578f56a0 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -27,6 +27,7 @@
 #include <linux/nmi.h>
 #include <linux/swait.h>
 #include <linux/syscore_ops.h>
+#include <linux/cc_platform.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -418,7 +419,7 @@ static void __init sev_map_percpu_data(void)
 {
 	int cpu;
 
-	if (!sev_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ad273e5861c1..fc3930c5db1b 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -16,9 +16,9 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
+#include <linux/cc_platform.h>
 
 #include <asm/hypervisor.h>
-#include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
 #include <asm/kvmclock.h>
 
@@ -232,7 +232,7 @@ static void __init kvmclock_init_mem(void)
 	 * hvclock is shared between the guest and the hypervisor, must
 	 * be mapped decrypted.
 	 */
-	if (sev_active()) {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		r = set_memory_decrypted((unsigned long) hvclock_mem,
 					 1UL << order);
 		if (r) {
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 7040c0fa921c..f5da4a18070a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -167,7 +167,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
 
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		prot = PAGE_KERNEL_EXEC;
 
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
@@ -207,7 +207,7 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	level4p = (pgd_t *)__va(start_pgtable);
 	clear_page(level4p);
 
-	if (sev_active()) {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		info.page_flag   |= _PAGE_ENC;
 		info.kernpg_flag |= _PAGE_ENC;
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 69639f9624f5..eb3669154b48 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -25,6 +25,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/rwsem.h>
+#include <linux/cc_platform.h>
 
 #include <asm/apic.h>
 #include <asm/perf_event.h>
@@ -457,7 +458,7 @@ static int has_svm(void)
 		return 0;
 	}
 
-	if (sev_active()) {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		pr_info("KVM is unsupported when running as an SEV guest\n");
 		return 0;
 	}
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index a7250fa3d45f..b59a5cbc6bc5 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -92,7 +92,7 @@ static unsigned int __ioremap_check_ram(struct resource *res)
  */
 static unsigned int __ioremap_check_encrypted(struct resource *res)
 {
-	if (!sev_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return 0;
 
 	switch (res->desc) {
@@ -112,7 +112,7 @@ static unsigned int __ioremap_check_encrypted(struct resource *res)
  */
 static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *desc)
 {
-	if (!sev_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	if (!IS_ENABLED(CONFIG_EFI))
@@ -556,7 +556,7 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
 	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
 		/* For SEV, these areas are encrypted */
-		if (sev_active())
+		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 			break;
 		fallthrough;
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 4b54a2377821..22d4e152a6de 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -194,7 +194,7 @@ void __init sme_early_init(void)
 	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
 		protection_map[i] = pgprot_encrypted(protection_map[i]);
 
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		swiotlb_force = SWIOTLB_FORCE;
 }
 
@@ -203,7 +203,7 @@ void __init sev_setup_arch(void)
 	phys_addr_t total_mem = memblock_phys_mem_size();
 	unsigned long size;
 
-	if (!sev_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	/*
@@ -364,8 +364,8 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 /*
  * SME and SEV are very similar but they are not the same, so there are
  * times that the kernel will need to distinguish between SME and SEV. The
- * sme_active() and sev_active() functions are used for this.  When a
- * distinction isn't needed, the mem_encrypt_active() function can be used.
+ * cc_platform_has() function is used for this.  When a distinction isn't
+ * needed, the CC_ATTR_MEM_ENCRYPT attribute can be used.
  *
  * The trampoline code is a good example for this requirement.  Before
  * paging is activated, SME will access all memory as decrypted, but SEV
@@ -373,11 +373,6 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
  * up under SME the trampoline area cannot be encrypted, whereas under SEV
  * the trampoline area must be encrypted.
  */
-bool sev_active(void)
-{
-	return sev_status & MSR_AMD64_SEV_ENABLED;
-}
-EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
 bool noinstr sev_es_active(void)
@@ -392,10 +387,10 @@ bool amd_cc_platform_has(enum cc_attr attr)
 		return sme_me_mask != 0;
 
 	case CC_ATTR_HOST_MEM_ENCRYPT:
-		return sme_me_mask && !sev_active();
+		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
 
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
-		return sev_active();
+		return sev_status & MSR_AMD64_SEV_ENABLED;
 
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
 		return sev_es_active();
@@ -411,7 +406,7 @@ bool force_dma_unencrypted(struct device *dev)
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
 	 */
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return true;
 
 	/*
@@ -470,7 +465,7 @@ static void print_mem_encrypt_feature_info(void)
 	}
 
 	/* Secure Encrypted Virtualization */
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
@@ -493,7 +488,7 @@ void __init mem_encrypt_init(void)
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (sev_active() && !sev_es_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && !sev_es_active())
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
@@ -501,6 +496,6 @@ void __init mem_encrypt_init(void)
 
 int arch_has_restricted_virtio_memory_access(void)
 {
-	return sev_active();
+	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
 }
 EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 7515e78ef898..1f3675453a57 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -33,7 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/ucs2_string.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/sched/task.h>
 
 #include <asm/setup.h>
@@ -284,7 +284,8 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-	if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    md->type != EFI_MEMORY_MAPPED_IO)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
@@ -390,7 +391,7 @@ static int __init efi_update_mem_attr(struct mm_struct *mm, efi_memory_desc_t *m
 	if (!(md->attribute & EFI_MEMORY_RO))
 		pf |= _PAGE_RW;
 
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		pf |= _PAGE_ENC;
 
 	return efi_update_mappings(md, pf);
@@ -438,7 +439,7 @@ void __init efi_runtime_update_mappings(void)
 			(md->type != EFI_RUNTIME_SERVICES_CODE))
 			pf |= _PAGE_RW;
 
-		if (sev_active())
+		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 			pf |= _PAGE_ENC;
 
 		efi_update_mappings(md, pf);
-- 
2.33.0

