Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5833D828B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhG0W1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:27:09 -0400
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:13632
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232750AbhG0W1D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:27:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC0ZNrb2jRTDkxRej/GlYzG88GmGVZDivSNuU0698AMTV2hC2p4ojFPLGxIg6+rY8kLqpbDgfAqfH1PFDYFRMzxN60hBraWKVNTWF8VcAFKaFKEeh5ZL3wPEigKwIFU3X5lmVrI8Lhbqz78bIkpilRVn+Nw4T6EZhyQHGMLXrLsP52QDABtQL5+pkAc2G7ziEcVtwC6LNip1fUfsSD7ptKY7kRJc9BIEf24frnRK9pB+DYmVbetf+we4TYirVfoZBNbciatgAv9Oo7q8nUoxIVXnLE5OC41ee1SgWRLVNl+GtP1Pj/qQSVJtkPJZDUbUagDSRYDXQDK64fsCel//jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf1olkGlcKRwlvMXiHj5kceZynZjwhldQoJOEiq8a94=;
 b=D8m2yvF1f4rQ8y9o749hlwRP1HOu+A5XNUXh8qT8C4Ap1eT3Ud8dXQTTgdaG4/awmXL40mBcmLSK8+e83duA1yMPlBPniiR/6HUDLDql8DP/3LH4LAUzLfBmQqy80hYOL36asbWNEsvAglet9fb3Rte1chMkzS4ZieJJpwUf92N5cs+TiaOhRBMWT/aiIT4N7PY6PGScrNS/ZfuiCPI0qTv3DI1N96PpKSDCv91f3XO1f+gjBeH42YsnYMbbkECon9HtVqwRuA/PnE2RqtrfFMnZYN4CqAFYSylG10113QY+5nqP5M/Ls7ZYTU7ceEhfV4kWTPw8urqryMmirvdnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf1olkGlcKRwlvMXiHj5kceZynZjwhldQoJOEiq8a94=;
 b=g1v77TfCtUkuCGnSXaOfW6OwSTgpsQ/V5NPpRGiTQhZIURlpgkqdM/NHoPuiDXWIyThKhOvu76+o5AuRv5UCHaTAnNylw9kLIW7F1YMYiRujHtBQRKzOsZPQZ2mRHTCVLiFcw7teNddFPGUrVNai9JPLazVREJ+u8KZqMsXLBBE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 22:26:59 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:26:59 +0000
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
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 02/11] x86/sev: Add an x86 version of prot_guest_has()
Date:   Tue, 27 Jul 2021 17:26:05 -0500
Message-Id: <b3e929a77303dd47fd2adc2a1011009d3bfcee20.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:806:20::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR03CA0027.namprd03.prod.outlook.com (2603:10b6:806:20::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 27 Jul 2021 22:26:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aba2817-c7a1-4d37-85cf-08d9514da650
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB541699487AD8396CFF97AD20ECE99@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRBaHi+gHT2WthBI+LejMaaSBGW4H0URuxPG5ADvh109ntJuCLHcw1aAECFqIFSrdgPZbO2frhncm9YxSKLbNLAEkmF5i7e+hgHrN4oij6cN+6gGEi0AK7YZHcxZoijCS4Hkc21Hxu6/WSOHhTicEbYpyXgh8vEHDbz+mT+bTPQDQldzCiVTe+1jAV8yyVghq9iDQvItLgtgwfJntZzcibcHY7ewXvIkR5XTV/KsVRK9SQiD09cq5MizqgZa0NGZ7chqVREYdxZuB8M6YW32IDsr3nKy0ARU7qcPOWN/vZ1My1Cu98liKlcpkG0xt6ont8MpJFLCXOrRzFf2gnrv91zeblGsxhaMqvqT0ItKxTosxrKLfXuNualkL8EISVxI2zMw9XSoRTzRRDoHo+1IulpZ7+e5bAgYvQNIptWgoVxU5bSme3Mc1UEBU2/OcOwnXuOdRL85jZoAK/rZwOU3jSkmx8MWf7+H4CxpQWG4xi++jwA4RcJtS0hSa4J0wIyJd9gZ+vuDJ7Hbn+14giRHMhuf50LE8k2j5zBUpxGEzv3vwD2cKxhKcSL+CuWU31+7UuD43ZK3LgsgrxWFTEOmY2GFDypGy1XauB65nDRbLtU555DKnJpBHTVT/atIUG3rXRfhIqjTjXRd0uotG2Mvil1CRBNgqzl8sz+Jg6gPHj066EETPqVAEZrTg+y2NYmW+2jcMxD7bsySFYzGEydw0WEz6uQNmNhHB2sGKv7AMOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(66556008)(508600001)(5660300002)(2906002)(6486002)(83380400001)(7416002)(316002)(54906003)(956004)(2616005)(26005)(7696005)(52116002)(8676002)(921005)(36756003)(186003)(86362001)(6666004)(38100700002)(38350700002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Itl0ACVwnZlfNjsEvbpnsL5N4uPkvGHtCEwiKSKVMUTT85ghSYraLXLHsdWa?=
 =?us-ascii?Q?JlLli57vKh90wqWUPVqSo4KyQV2Pi15XeqWsSblydsfkcxtdyUwz13cXmnEX?=
 =?us-ascii?Q?DP6oO7ZSagXJwS2X7qRKt5t68q4el10SV8uXvnmVvdketJRALmCtuhWsQnoI?=
 =?us-ascii?Q?ZDpdzXF3b+KpnFpqfeVdhXbcg4Zya6ii9tkfiXPtfbm5Z3rzQwKgVUu+CiEh?=
 =?us-ascii?Q?lS/R+L3PVt7vaANNkoQuwfenuftItqoZDMmNI4GrCde0Ggs578eIIVS+7mvH?=
 =?us-ascii?Q?N+3UzCC+9CVZN2vngkWFx4vrfe/3yFNABhYtRTOF6d8Flg0E/JImyB0+vycQ?=
 =?us-ascii?Q?KavQSS3/qKrygz2aPmBJUNk1qkOsbui1AfQFMuylSZQGeQy+uq7LM8HNoPe9?=
 =?us-ascii?Q?+RQd/L/33BryNrJDHRnrf2HfF8VDG8N9MjsyS0h/x0p/JCQQJNtnOOGSfNfU?=
 =?us-ascii?Q?q64JfhLWVyYuf+Rp9sxnqORu6bHG2o4ppAZmtd5vGyBp1TbGG4JIIbsrQtZl?=
 =?us-ascii?Q?DhVOvNV2moCAoP7OrOSK+gKRz/J+xwVOVcghaiYiO+E+jcRzIu5EcZhjS+7b?=
 =?us-ascii?Q?dnrtgqGDmeFtfl0+pavUMbw0IT8ZhYOxW9s7WUQNle/au1cbHkombJqUF5c6?=
 =?us-ascii?Q?ahWKNQrohwPGmW7a7mzypPDK/P2PntnCXBvpu/tpL60eoJoL+00qnQJwUC7F?=
 =?us-ascii?Q?+J5yqd7bp0j2eNAmTosXE5hvebmv7KHEKHRG50M7Z7Sb5nRbjmkr3NJE+2H8?=
 =?us-ascii?Q?WKsDm+atPhkIj/SAh7bOvhou4ozA34OAL7n4JZsUcNaJrNO52HKkRvt0NPAG?=
 =?us-ascii?Q?or1ZbmQ6zJcqhykiCC8rq8xNSsg5+c3x+E+B8HXgLr9w5H+ScNl4B8MAUKh6?=
 =?us-ascii?Q?+SBsQQXXk4qRbwM5lbzvpDmv75fU5kXYmw6Yyu4VLdrn8tlM4eQvT3mJKer/?=
 =?us-ascii?Q?dnZQ0fT0X5aBK8IEl8kpetGFKMbJc9aOXHidm5GlB341pqU/tUfuH1LfEazD?=
 =?us-ascii?Q?7tzrhUPbl4peyoneAIXbYbK3HQDzeuNBhEOrWRxdUvyg/psZq/CjtDjmOEcI?=
 =?us-ascii?Q?U4WYSlmDNtaFL+RAhY7SgnwoaDbjaljobVhoBQRp7MfOmZpouh6sJauHRbnR?=
 =?us-ascii?Q?7XPLQCTppt3Mz4SZKvjQji3ghIo++JeyN/MRfthvejtX8UxT92GNR3tGqfPu?=
 =?us-ascii?Q?ETIH34w+nK07t1L064YeNplnLMNQ8VLoBgwB2qwPkRybc7Stqn9y//vhTi73?=
 =?us-ascii?Q?8V1Qod1q21+VzVM6GR/KQrqalZDUG/mmOb8aTzJiVTqM3Bq+zhAbAIAMMmrA?=
 =?us-ascii?Q?BYdaWr/8P+suSv1T2QCbCo/n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aba2817-c7a1-4d37-85cf-08d9514da650
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:26:59.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjNjgKJHyJ+bu48aW6JzyGZJoNqbbs7iH1NNjXVAYABtQMOEmpXyMrS/5hzZ2DrBrba410jUbAC5Z0nKavXbfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce an x86 version of the prot_guest_has() function. This will be
used in the more generic x86 code to replace vendor specific calls like
sev_active(), etc.

While the name suggests this is intended mainly for guests, it will
also be used for host memory encryption checks in place of sme_active().

The amd_prot_guest_has() function does not use EXPORT_SYMBOL_GPL for the
same reasons previously stated when changing sme_active(), sev_active and
sme_me_mask to EXPORT_SYBMOL:
  commit 87df26175e67 ("x86/mm: Unbreak modules that rely on external PAGE_KERNEL availability")
  commit 9d5f38ba6c82 ("x86/mm: Unbreak modules that use the DMA API")

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/Kconfig                       |  1 +
 arch/x86/include/asm/mem_encrypt.h     |  2 ++
 arch/x86/include/asm/protected_guest.h | 27 ++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c              | 25 ++++++++++++++++++++++++
 include/linux/protected_guest.h        |  5 +++++
 5 files changed, 60 insertions(+)
 create mode 100644 arch/x86/include/asm/protected_guest.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 49270655e827..e47213cbfc55 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1514,6 +1514,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9c80c68d75b5..a46d47662772 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -53,6 +53,7 @@ void __init sev_es_init_vc_handling(void);
 bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
+bool amd_prot_guest_has(unsigned int attr);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
@@ -78,6 +79,7 @@ static inline void sev_es_init_vc_handling(void) { }
 static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
+static inline bool amd_prot_guest_has(unsigned int attr) { return false; }
 
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
new file mode 100644
index 000000000000..b4a267dddf93
--- /dev/null
+++ b/arch/x86/include/asm/protected_guest.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Protected Guest (and Host) Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _X86_PROTECTED_GUEST_H
+#define _X86_PROTECTED_GUEST_H
+
+#include <linux/mem_encrypt.h>
+
+#ifndef __ASSEMBLY__
+
+static inline bool prot_guest_has(unsigned int attr)
+{
+	if (sme_me_mask)
+		return amd_prot_guest_has(attr);
+
+	return false;
+}
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* _X86_PROTECTED_GUEST_H */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ff08dc463634..7d3b2c6f5f88 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/virtio_config.h>
+#include <linux/protected_guest.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -389,6 +390,30 @@ bool noinstr sev_es_active(void)
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
 
+bool amd_prot_guest_has(unsigned int attr)
+{
+	switch (attr) {
+	case PATTR_MEM_ENCRYPT:
+		return sme_me_mask != 0;
+
+	case PATTR_SME:
+	case PATTR_HOST_MEM_ENCRYPT:
+		return sme_active();
+
+	case PATTR_SEV:
+	case PATTR_GUEST_MEM_ENCRYPT:
+		return sev_active();
+
+	case PATTR_SEV_ES:
+	case PATTR_GUEST_PROT_STATE:
+		return sev_es_active();
+
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL(amd_prot_guest_has);
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
index f8ed7b72967b..7a7120abbb62 100644
--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -17,6 +17,11 @@
 #define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
 #define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
 
+/* 0x800 - 0x8ff reserved for AMD */
+#define PATTR_SME			0x800
+#define PATTR_SEV			0x801
+#define PATTR_SEV_ES			0x802
+
 #ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
 
 #include <asm/protected_guest.h>
-- 
2.32.0

