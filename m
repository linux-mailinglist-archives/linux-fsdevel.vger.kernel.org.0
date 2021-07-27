Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6953D82AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhG0W1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:27:50 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:52929
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232986AbhG0W1d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3Tq7m0hcJsYbUjOytYfs98KwUJKY4+LVDftxFSt+nevjbnJgz4GzVwP3SjV9JoSUXQRv9znNfLWm5WsdRJwgKHMvlh7E9vvW0ft2Lm9EqkPX/PO6wEiE9bqkX/SEraX+ARhy18Kzv+YvtII3A/tBQiVbgjfffcL3lPiUeyiPBRdaLntUI0Wu3UMAJNjUVSTV6fcZZ2pRt88aMDZUG//WVRTdWVEql6IzPq+PtbqSQ6JKSCiey0ke164tKXtjUhADIIzFrtqtGY+kcnJO7Aj0Ao3+ialb8QK1AEMklW3IqDbk1O1GvAb6ZLXbev743HRYUcsWdE/NpoVyZ7MRfLUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXAOkDwkQQkoBcwS72J/e05C3mxTd2Dw4JPIfWabwro=;
 b=aZ76JMVyisy2kc08QlrbycXol3Mvq4tKlFGg5Miw7wV7KNsyuwRgYehq7KcDmdPH8xmWde2LxYoCYAyDP7knb0PLSOuhBx0BUFYhsqBGaHRGqmVoHqVL//mCOIy/4G52vUzeRLIAGoGmKTv1oXSqhyhXH694RpdaoJhoeDAVLop15vjCoGgxTixwYRBKn8rOtZcyf23DK/8VArOl3PC3K6cG3p4evSBDDHUXoaBwIPOgSelyPDdccqexyT+HGshCrukFAkWBeSipjKTKPMA7jZajzkbD7eCUy+gH5cKBqVoZyj0rzNslvktus2FlgAQKR2yOYmied5QbdnbNCbxqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXAOkDwkQQkoBcwS72J/e05C3mxTd2Dw4JPIfWabwro=;
 b=PCvHyW3pPea0+ROur7cwg2ygwtB4W74zV3QUORlgoZA4p4/g/NP1VEBa84nMFXLXqrFx+Q+4Sa4kRF0U9FGjk6l6fAn/prjvaghBNY+XMA/dQIT5nioEGcbRIGzEU5HAgCffV3dXoaGQf9fqdCn6ooASYd2NKW1CqwBHVTYaOcU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:27:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:27:30 +0000
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
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 05/11] x86/sev: Replace occurrences of sev_active() with prot_guest_has()
Date:   Tue, 27 Jul 2021 17:26:08 -0500
Message-Id: <fa4cdba858e5cb20da2bcd31acf6959ae391bded.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:806:27::7) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR13CA0122.namprd13.prod.outlook.com (2603:10b6:806:27::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Tue, 27 Jul 2021 22:27:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69bef4ba-7f7c-4c1f-e2b0-08d9514db882
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB535725F877A179D81C6FC34FECE99@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2612Ts+D0lrPAoDkVUq9elTETr5p+ybLpJpYvKl14q/i/tjLpyC3qpfihWDyqfHhma067fSalnyfT1Xc9J/8dKcokKk5EsOGGCSAJxacKVIREkI3YrYwQytNFCH7CcyaiEbudgnF5btORiim5nuqO0xtzdMISfLVscAzGrTD7FSqwijh/9iChP2N+QoxugGiKsaea4nBhwN3910h9FIFuzbk/a9DzNkwV4HfUWL72PKWvMzve9bfmBkZ7X/DsNbPR32NIOED2n5Akf8L3wE5B4zyO6awbDyu1MVsMrKzmII2wqvdYpI3cwr2tQnvBeSjr/YGfOTR7Sn+3F7V8bx4xz4t3Wz09IhoM8v570losQASFu0fg35OteBInO04nRggutBmHcXMLjHb4FcKgtLocoIia8Rr/3cqT7Uvi0gYOC+vE1bqq34Ff11b6cRYy+6pw0Zo1ETxFmkSX0vYuZoCtMh1Nq68VNLaJVC4kty3ObGC0ogxNeEqawPQDa/zNpjoW/cGJ7O6VFVhDw3IB/AtJ2b93mm6xJjvNjzfWngPUNmXb0zcyFl/Bav0vCMea9WGjdcfqMoLCKvfAGy/4s9lUvKxnp0SnJbFZQgAzeeYpbMom8AHWFLqJ0k0jibDfLzfPJIApYzrpYEF/nyXNhZGJTemy4VGzhzc+maF/6jtlRCs3yZS9QBQGFNWTQ+ALoVfAwzGbm8dxN9d9jnT84qBiBXrcPEaIxmu3RUK1ffrkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(5660300002)(36756003)(54906003)(83380400001)(956004)(66556008)(4326008)(316002)(86362001)(8676002)(921005)(2616005)(66946007)(38350700002)(38100700002)(66476007)(30864003)(7696005)(2906002)(6486002)(7416002)(478600001)(26005)(6666004)(52116002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nuQUfJ0oDlGQ8A7GxUPpr3iuNSwaT5V0nkz3PLynMRaiA/pibu2IG9C0MvjO?=
 =?us-ascii?Q?JcVypIaD5mB6ur+za4lY0uPqPhyDZgqhFo5B6z67b7Q4OMHK7OuFFW8vxImK?=
 =?us-ascii?Q?tCOdcJe7Vhhsb4N29zlBs3012Nw3xyLw5mJlhhAE4Cwte/CfCvvmasJpai6H?=
 =?us-ascii?Q?W3EAcAqgcSYdeTKKQzf/ByDW++r2TBDllqyUJDvtwb/cDx20QsqWafvf6oAV?=
 =?us-ascii?Q?evKNtgq87eORx5bz+MJfDhx1k4qlBnXZ3A1Mc+ouUBPx22Ec2QUM7A0J/OiQ?=
 =?us-ascii?Q?/wUllaoO4RdSMIUTKU+1vzILbo+MMXHWwlRQ0ZkSHgwevsgv7PjmIQgdoQIF?=
 =?us-ascii?Q?ozLKv7I+4n9t0Rld063Mu9oxuR8lH1zLWStQSyBRjvig4RMM8sjRNmHL5d0b?=
 =?us-ascii?Q?yTcGaQJRhKcy8sEgDaUSZub8X5bx8peR3MdG3ah54puw0f+SCo8CcR3D/l62?=
 =?us-ascii?Q?oZ+AM8/u5B6pOFX3EdF9hnOddB9XmgDsVpFM6i/7dvQaRcpH+Vlqat9FgwRb?=
 =?us-ascii?Q?AJsbrnAR4gJtCXOi6k39jzams7bYcmwvOwW4GP9fgp+7QqgL0PiqAQdL3maX?=
 =?us-ascii?Q?Aew3Y73rdUI/vdoch2mXm3+T0+0IRSEmCgCfkbjHzghH7+PCn5bu7imOUc54?=
 =?us-ascii?Q?2BX8AG00BemY/bXE0m5cuu8skI9vJmUD00SNv0kcO93AMGfCMy/CndaFAyxN?=
 =?us-ascii?Q?HZrXt1Ar8ZAG757ymm82WWrpsMtApzgyDFNGEaG/c4+mLLxs2jEfQeoK+OJ3?=
 =?us-ascii?Q?1CNa4JYDoMtZlfsRrvEUyG8Bhr9kxk01NyzntOBNoizyJXbddyd0pJ5v2jjj?=
 =?us-ascii?Q?MouFR6DSMZBBpu8czTDIcWmgS+VsvNKjZgNfIPR8qEahBv/MUAS+yc2K0te/?=
 =?us-ascii?Q?Z3ejHcPo03yfZNVVv5+uVQXEwL/Rku7CShBzSotuf0+nC+i80R0l4yoLFtbJ?=
 =?us-ascii?Q?ANMWMyH3FrZC6nJgINU/0LzxQiQZzBhC7HVVVbzBUYSEQzVJVxRbcz7dhV2c?=
 =?us-ascii?Q?aN4s/7Prd12B5FxNSlgm/HTVlYkXkSiIW9GpRmV0lG7LVHlsKPQ4m0EDgqcd?=
 =?us-ascii?Q?s/mfDICsadbGpe6ehokX8Af7+Sa4vhYjKrJqHyjOLTjT9zNNMkW0nKsMkHQ9?=
 =?us-ascii?Q?GStJiIp2ALBRxJjPzSU64Qf/ks/XcCmpNFBtgilsWrykYiUvHiIreQgL2ObJ?=
 =?us-ascii?Q?URoI+Usi9b0RiuGa8VN/f5DJd52gzS9fHz6hdqquT1B8zR+ViVOxW936CFxY?=
 =?us-ascii?Q?xVZ1sHvOmTDqQfR9wFnPwBowtdVjhzEDoeq0rnw7BQZJX2+Oep7mLEg6hjGz?=
 =?us-ascii?Q?lwYfjf+ISyUC54tcqvVzrYHP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bef4ba-7f7c-4c1f-e2b0-08d9514db882
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:27:30.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFlhdAfNgZz13TM5KewlG9iVq4ZoLyz31DgoIvkvxKgI7xR9rgN/2Tbg1dVtBDG41d5qGcKGHLOV+MWZ3v8jtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace occurrences of sev_active() with the more generic prot_guest_has()
using PATTR_GUEST_MEM_ENCRYPT, except for in arch/x86/mm/mem_encrypt*.c
where PATTR_SEV will be used. If future support is added for other memory
encryption technologies, the use of PATTR_GUEST_MEM_ENCRYPT can be
updated, as required, to use PATTR_SEV.

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
 arch/x86/kernel/machine_kexec_64.c | 16 ++++++++--------
 arch/x86/kvm/svm/svm.c             |  3 ++-
 arch/x86/mm/ioremap.c              |  6 +++---
 arch/x86/mm/mem_encrypt.c          | 15 +++++++--------
 arch/x86/platform/efi/efi_64.c     |  9 +++++----
 9 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 956338406cec..7e25de37c148 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,7 +50,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sev_active(void);
 bool sev_es_active(void);
 bool amd_prot_guest_has(unsigned int attr);
 
@@ -75,7 +74,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
 static inline bool amd_prot_guest_has(unsigned int attr) { return false; }
 
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 045e82e8945b..0cfe35f03e67 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -10,6 +10,7 @@
 #include <linux/crash_dump.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/protected_guest.h>
 
 static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 				  unsigned long offset, int userbuf,
@@ -73,5 +74,6 @@ ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sev_active());
+	return read_from_oldmem(buf, count, ppos, 0,
+				prot_guest_has(PATTR_GUEST_MEM_ENCRYPT));
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a26643dc6bd6..9d08ad2f3faa 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -27,6 +27,7 @@
 #include <linux/nmi.h>
 #include <linux/swait.h>
 #include <linux/syscore_ops.h>
+#include <linux/protected_guest.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -418,7 +419,7 @@ static void __init sev_map_percpu_data(void)
 {
 	int cpu;
 
-	if (!sev_active())
+	if (!prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ad273e5861c1..f7ba78a23dcd 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -16,9 +16,9 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
+#include <linux/protected_guest.h>
 
 #include <asm/hypervisor.h>
-#include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
 #include <asm/kvmclock.h>
 
@@ -232,7 +232,7 @@ static void __init kvmclock_init_mem(void)
 	 * hvclock is shared between the guest and the hypervisor, must
 	 * be mapped decrypted.
 	 */
-	if (sev_active()) {
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT)) {
 		r = set_memory_decrypted((unsigned long) hvclock_mem,
 					 1UL << order);
 		if (r) {
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 8e7b517ad738..66ff788b79c9 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -167,7 +167,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
 
-	if (sev_active())
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		prot = PAGE_KERNEL_EXEC;
 
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
@@ -207,7 +207,7 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	level4p = (pgd_t *)__va(start_pgtable);
 	clear_page(level4p);
 
-	if (sev_active()) {
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT)) {
 		info.page_flag   |= _PAGE_ENC;
 		info.kernpg_flag |= _PAGE_ENC;
 	}
@@ -570,12 +570,12 @@ void arch_kexec_unprotect_crashkres(void)
  */
 int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 {
-	if (sev_active())
+	if (!prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		return 0;
 
 	/*
-	 * If SME is active we need to be sure that kexec pages are
-	 * not encrypted because when we boot to the new kernel the
+	 * If host memory encryption is active we need to be sure that kexec
+	 * pages are not encrypted because when we boot to the new kernel the
 	 * pages won't be accessed encrypted (initially).
 	 */
 	return set_memory_decrypted((unsigned long)vaddr, pages);
@@ -583,12 +583,12 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
-	if (sev_active())
+	if (!prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/*
-	 * If SME is active we need to reset the pages back to being
-	 * an encrypted mapping before freeing them.
+	 * If host memory encryption is active we need to reset the pages back
+	 * to being an encrypted mapping before freeing them.
 	 */
 	set_memory_encrypted((unsigned long)vaddr, pages);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 664d20f0689c..48c906f6593a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -25,6 +25,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/rwsem.h>
+#include <linux/protected_guest.h>
 
 #include <asm/apic.h>
 #include <asm/perf_event.h>
@@ -457,7 +458,7 @@ static int has_svm(void)
 		return 0;
 	}
 
-	if (sev_active()) {
+	if (prot_guest_has(PATTR_SEV)) {
 		pr_info("KVM is unsupported when running as an SEV guest\n");
 		return 0;
 	}
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index f899f02c0241..0f2d5ace5986 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -92,7 +92,7 @@ static unsigned int __ioremap_check_ram(struct resource *res)
  */
 static unsigned int __ioremap_check_encrypted(struct resource *res)
 {
-	if (!sev_active())
+	if (!prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		return 0;
 
 	switch (res->desc) {
@@ -112,7 +112,7 @@ static unsigned int __ioremap_check_encrypted(struct resource *res)
  */
 static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *desc)
 {
-	if (!sev_active())
+	if (!prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	if (!IS_ENABLED(CONFIG_EFI))
@@ -555,7 +555,7 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
 	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
 		/* For SEV, these areas are encrypted */
-		if (sev_active())
+		if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 			break;
 		fallthrough;
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index d246a630feb9..eb5cae93b238 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -194,7 +194,7 @@ void __init sme_early_init(void)
 	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
 		protection_map[i] = pgprot_encrypted(protection_map[i]);
 
-	if (sev_active())
+	if (amd_prot_guest_has(PATTR_SEV))
 		swiotlb_force = SWIOTLB_FORCE;
 }
 
@@ -203,7 +203,7 @@ void __init sev_setup_arch(void)
 	phys_addr_t total_mem = memblock_phys_mem_size();
 	unsigned long size;
 
-	if (!sev_active())
+	if (!amd_prot_guest_has(PATTR_SEV))
 		return;
 
 	/*
@@ -373,7 +373,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
  * up under SME the trampoline area cannot be encrypted, whereas under SEV
  * the trampoline area must be encrypted.
  */
-bool sev_active(void)
+static bool sev_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
@@ -382,7 +382,6 @@ static bool sme_active(void)
 {
 	return sme_me_mask && !sev_active();
 }
-EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
 bool noinstr sev_es_active(void)
@@ -420,7 +419,7 @@ bool force_dma_unencrypted(struct device *dev)
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
 	 */
-	if (sev_active())
+	if (amd_prot_guest_has(PATTR_SEV))
 		return true;
 
 	/*
@@ -479,7 +478,7 @@ static void print_mem_encrypt_feature_info(void)
 	}
 
 	/* Secure Encrypted Virtualization */
-	if (sev_active())
+	if (amd_prot_guest_has(PATTR_SEV))
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
@@ -502,7 +501,7 @@ void __init mem_encrypt_init(void)
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (sev_active() && !sev_es_active())
+	if (amd_prot_guest_has(PATTR_SEV) && !sev_es_active())
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
@@ -510,6 +509,6 @@ void __init mem_encrypt_init(void)
 
 int arch_has_restricted_virtio_memory_access(void)
 {
-	return sev_active();
+	return amd_prot_guest_has(PATTR_SEV);
 }
 EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 7515e78ef898..94737fcc1e21 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -33,7 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/ucs2_string.h>
-#include <linux/mem_encrypt.h>
+#include <linux/protected_guest.h>
 #include <linux/sched/task.h>
 
 #include <asm/setup.h>
@@ -284,7 +284,8 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-	if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT) &&
+	    md->type != EFI_MEMORY_MAPPED_IO)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
@@ -390,7 +391,7 @@ static int __init efi_update_mem_attr(struct mm_struct *mm, efi_memory_desc_t *m
 	if (!(md->attribute & EFI_MEMORY_RO))
 		pf |= _PAGE_RW;
 
-	if (sev_active())
+	if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 		pf |= _PAGE_ENC;
 
 	return efi_update_mappings(md, pf);
@@ -438,7 +439,7 @@ void __init efi_runtime_update_mappings(void)
 			(md->type != EFI_RUNTIME_SERVICES_CODE))
 			pf |= _PAGE_RW;
 
-		if (sev_active())
+		if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 			pf |= _PAGE_ENC;
 
 		efi_update_mappings(md, pf);
-- 
2.32.0

