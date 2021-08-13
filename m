Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15CA3EBABB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhHMRBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:01:14 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:54872
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232486AbhHMRBI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:01:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ57b0Zs/YQyAQ44f/9YQ91xT55B35yTxyzL39GBXgb9RHTb7KU4DnatiHdhIU2TiBRuJt3oEVIOozZV86pKwcUbVGiPVrYm3fmTZP3opU2rbvfkO6ObEuQL1gvwSy2985X7WFniJKkCDLjurvdvOLX1OhQdQF0lBFIKj9yvHJISU2738JtaJdWZ3fOsJcNCPnbrnWWuW5rTCRmgDok06e8BwJbWNmf29ZVeDj1036qcsOYbaJ6htaSrqu9h0ENRCyzNChMcFrgUb/q+zvHAq4ZVNlr9DxLliCeP/VoeNM7Bt3MtNdNCTFj3mBZhNE4TfyPJ6MapO0gG5oTwNA4eoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bglYJAU5kdRJsPU3fQ8SkVOjVO0szeaoVN3Z9O7T20=;
 b=iWLKOoeQox97GjC/ZiVR05EF+prZ6XeqWcBR+2r/BqpqX2+0JbYzKKSH9r3rshpM+xZq2CxcwGmJJshPfd/t6XUd+VVrWnyaOYOt4QFoI3v/sDt4m8enZdKL1dizb5d5SKYVzmAL+sP293D59ZkJgz/OoZMKfhHQ/6QePMSogPBgm5TKCheg55HKbI1OaA1nCOxX71/EUCRzWZBgyuVWb3aZ8cFO45TPI2XUIhbMHAGhrw4SVhP5DBysWahrFHc9w1M1nBeugxw1sBbWCXfo6jxXHnTxXQSfyBs5flUNPEq7nNHh3PKiej3Wt2zKgfR9O4RygzFaK47RBZ5fdtEFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bglYJAU5kdRJsPU3fQ8SkVOjVO0szeaoVN3Z9O7T20=;
 b=kQ9sh/AhK9+1/4HOLDTBgdAJtriHO04EIuFuSbROl77MUP1LFoIWu28g4Cidpg1oOF/Ixk5beTrs+66NLxsOxxdttQ/2M7MO2jVjHSA33vZ5HN2Jk3jnBwP061L4ahhRbZi5p+ObOLKqJ+eZEuOTczlRjJNRnX2oHDZvnD26PZI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 17:00:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:00:38 +0000
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
        Ard Biesheuvel <ardb@kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 06/12] x86/sev: Replace occurrences of sev_active() with prot_guest_has()
Date:   Fri, 13 Aug 2021 11:59:25 -0500
Message-Id: <2b3a8fc4659f2e7617399cecdcca549e0fa1dcb7.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:806:28::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR13CA0177.namprd13.prod.outlook.com (2603:10b6:806:28::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Fri, 13 Aug 2021 17:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4058df91-3bab-4a75-feca-08d95e7be029
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53412AD7A443BD93F5991E28ECFA9@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cw1iwQu1HZv6pKRt9Ei9u8O/5q6Q/w7J73OlPNzB+qayK10EpbSJaYfWwwMpa81HFkUX4PiLLyCjNDHxUSzZ91ji8EHrH3ZM3rimojaqi5roDj99VXPL+1tmTmTSM5XLQVGvBuAYcDM4OLzwIVnSIaFiK+NJ6JQo2sPci2lqhy/MCP/wIECQ0SjhuV0nTW53cE55EQlsJHFjfGYU8MnPJMb1wlosaVVdoY9TodHnTlg1iFWEx8/PcL2SU8ESdgcsd/3EHpKANynJj/fJrxomTyvkS7U0RKiEIX0YjftroQ778BgTJGRoq3bqC7p7FFoAelUEVP/m82U8OY+TVYVIX7/uGC7Sbq/m3b07GM7A9RkG8kjcoPZaghjV/KB+ThjA7kpgClRX0xRxbVZTx/nfjSisEVE5nbHbX2GA0nwU8i/PVhZ26xKXj9BIxNCp/x2O2v6Q6ibgVhrsioHM5EH762rWSGTc97LZ/pjjKlbiSA8S/uqmVtVE6z8dkV4e9SuAJuA79FZxtGkYz4hhHY+HvsHANqRXWNbEzHH27H04RCndAE+uwU/p7D2eFjtS3oKg/oeSnvW6QbJdk+FDY339dvWNeRv+Da9ib9MA1dRpDo2cRQlT6UeAsEkGRvx0lSW+V4RlOOEqlZnvuTQ7UxqdG17dVg7KBkEbM/rI4LDiTo2hfXEpP9SLGnUEHLylHyYyfRIuQKOcTdbHU7jF9yrIreesn+Wqa23MQCb6uOZDlzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(86362001)(8676002)(2616005)(5660300002)(6666004)(54906003)(36756003)(38100700002)(7696005)(38350700002)(921005)(52116002)(8936002)(30864003)(2906002)(478600001)(83380400001)(4326008)(186003)(6486002)(7416002)(26005)(956004)(66476007)(66556008)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nkPUED4PQem939rIfYt9QKmg4GV8cGqwY5gzWD5abGADfoMkQxGaxMH2AJK1?=
 =?us-ascii?Q?T5vnNIvm5FgXQyMhlvYAth35o4VkIlL1+AfJm42jlctnBquLfJjJw3DwMgt4?=
 =?us-ascii?Q?gvND+frYIg99cxJJxanSXhKG2s/REaOOhT/LbZjTaLemy68fHhQXv0A+BXRR?=
 =?us-ascii?Q?AYdPdjnsc/gJTXQFKITSi6YZ+BGdGPhliGSPT3LuWMQE7Y9lO+he0yrVPUQZ?=
 =?us-ascii?Q?kZch8PLRJW+Env7BQspt2xwWpdynwPIQvOo6RWKu5RxaqiyvkwC8RQYbOJzN?=
 =?us-ascii?Q?zXbzJ7a35i+q5rg3honOLgndUuEdMtF79dqRNmwpbkEv8o6aYqYoOMpo2nj3?=
 =?us-ascii?Q?6N3HkCHXU7eyhfErxP0hw6nMFee5eA8PHyUoiCEm5PligJnkDUaGnPHQdO0k?=
 =?us-ascii?Q?cAlJAOVONSG5EVsMLDOC4AyoLZcnDrxsasXRKKkthGYliZ++w2k68I4kM0xS?=
 =?us-ascii?Q?wiFJ56dSBdrVRVkSpfYSH4Daa0gFbAmoa6f3jWu9fzHQR5tIM48wpNFEnNNR?=
 =?us-ascii?Q?uah4aB+HrstekQuDABXHri6SnLUbQQFxunIxSYPzPllbZUEoqe+LlZES0VhC?=
 =?us-ascii?Q?FNaFcp1YMmjInWU0DD+6y937eJ6AEBspeQtssAl24q5TDx4zr72xP7xv+ezK?=
 =?us-ascii?Q?9IP75DL/3hVTm91P4yffkzlV0r+VPNQJh0MvA0dC+gdrz7vrqy8yrt+n0SYp?=
 =?us-ascii?Q?E4FOFC0nwCfOQN9HuYp+az7YDzjtgC93u8pQ5TCHK94wdhhj6ISRm9vN39cx?=
 =?us-ascii?Q?iRmQvJdHp3DtV4aC9Pqh3Sf4DmCkduTGPC1+DZb1dV/N4kRnh798U1SlaLcO?=
 =?us-ascii?Q?KSKEprK9AVapdesLkxkRLGZCBv6dtf9K3emig1h/s56j9Y5lZNsl07rsQxlO?=
 =?us-ascii?Q?rXFIO43Y4MZmdA0zn0AIOGRduxovyooLmpGNeFepE1NshD/rpoZGY6FKw3IS?=
 =?us-ascii?Q?rnuZSz/U2AdGW0jT22Zda3gZzAiwNh+rcdhlJzSnuYGF29ONxP44Ps7Itu9T?=
 =?us-ascii?Q?k9PN2ePRJjPyoJixxn1v4NwASm83GhebeaIPP9OwbgncMPZye/Jex25PeaCg?=
 =?us-ascii?Q?L71t+tikHwcGeKgwD/k3eQavvijPQwp8HFqDJY2EBWjbAqxWROlui/lKOFKC?=
 =?us-ascii?Q?c7p1xmQhez5Xkb5IhhJEDBxajMIvU4a05LHj+YStMHHYCpivhaEK9oefRdsy?=
 =?us-ascii?Q?iRLup7EWgS4XiowywGLoUzBrlPrJ1O/mwj5VZVFm8UrByQSFOjRKDfeQyqgm?=
 =?us-ascii?Q?dUVDoSsr0f9rnGov8UWN1+iynuOn7jZthotvgBg9ItNTuBqkupMjNW1b7r34?=
 =?us-ascii?Q?cIcBRLCjQYebMStExVBxA4F3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4058df91-3bab-4a75-feca-08d95e7be029
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:00:38.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdLd9GZpSesJTAsGb59ka5bBnNQvB8c5gDpYx7d34y1FtOJWswZLuEFvcZun+AhxjPtS4aVxBQlM5hfTAxywZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
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
Reviewed-by: Joerg Roedel <jroedel@suse.de>
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
index e8ccab50ebf6..b69f5ac622d5 100644
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
index 583afd54c7e1..3ed0f28f12af 100644
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
@@ -556,7 +556,7 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
 	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
 		/* For SEV, these areas are encrypted */
-		if (sev_active())
+		if (prot_guest_has(PATTR_GUEST_MEM_ENCRYPT))
 			break;
 		fallthrough;
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 5635ca9a1fbe..83bc928f529e 100644
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

