Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082D13EBA99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhHMRAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:00:43 -0400
Received: from mail-bn1nam07on2053.outbound.protection.outlook.com ([40.107.212.53]:7758
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232124AbhHMRAm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUqzTUNKgDJTbc+3czmmRG/ouMQXddukoPIQarYuSl5EP+e5NqHL4u/DK+LkiTBExMzevaHth/1m7P0OoY5OHPHVhCTI2eR2QalkZZCvf2ARgAi0zele/ij+yHuqDMh1rjcDwfhNwN1B/ktPthkVcWpK8x9Xwbj6hFHlhCcWDhmTsoGUehu+bpOHsuIAw2FDcLXCrOwbcem3XSm0Ku/71xFJ8kPby3+fJeQdReifwnnMBVkBmy6fSzeb9mPYmW8ZivLhF5dJwHpjHCtwvssY2eMWoWeK+VUSF1uVbkr6lCYkiy6pf3D8Wbg5V8JBM3QndL2xhhUYK3frxSJKml4qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuLcJW+E15YGcvv29k84VPEZb+rr27P9muWMmGZdDk4=;
 b=hgyJWL4yNVx20DPg/YcChMSewOd3/1O+GeByG3JNlu1CBQdKGHeU1iRF6RS5Lk7fWm3GZsjgpqQ7qDnHTKXmiSzdDxldlwylPmBcvi6yUC359UFXAlstwB4SdNmEfgLpFNJNZgrP2dWUzlHrDPnxjF/lKAXjuQP9j6A+t8F+NNfGueUIqCt7WldRMhAnMgLATz+EPY61TkeR4Yfxwgw/T27vzGA2O+6rzZf3P0PY1hvu6R88vkCSfuq5ZlNgr9SdSrNbw24ljRm+f1wRTx6KqCgTrq7dl5n6K9G8QGHQxCCIU5lLo3hdE6LN8WvC2pM27mIrMCxaEeHgLo5bnn1NKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuLcJW+E15YGcvv29k84VPEZb+rr27P9muWMmGZdDk4=;
 b=h74Ok9b75CY/+Fx8CnJDKHkZvmfLwPiDkEFCY4nPjqzNpDY7IY3Phmy/PvKurpvcxozwBAfvsJyf+6GcWQMwrYpYjCBk2Fd+tlSL6/v6DcJ3pGa+FlAkNkZGPGhPGAQMNiapWAjh2v1HroCoiFMb9FOqOo80NQLbhX+7CmAKO9E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 17:00:13 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:00:12 +0000
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
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Date:   Fri, 13 Aug 2021 11:59:22 -0500
Message-Id: <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:806:120::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN7PR04CA0057.namprd04.prod.outlook.com (2603:10b6:806:120::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 17:00:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5f97b9c-957b-4214-04ff-08d95e7bd0d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB551868AB9343F3147317D64EECFA9@DM6PR12MB5518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/NUz6w5jJM7GGJ6YvdsS40louMSqdi7c8uC58YY1Kh3jc/VmXGyw3v1JkzukbEImPndFQ0/8V/LuhziWw64AHwpNYw9NA4nueDozLzhHrhnJhFy7y0MxIMCEI7IGftw1nI93hfRoQDHf0k147Cjid/T1o/t3ioR6Sz8XgdNbFCVc5OOaf6MY7cpcqhLK5riAbGtwS+bdnoEX9y5uLvGyDMntJvDe3sYEEwHXWVP96lHjvc/6SjY60j3nul1+v1ljPpJ4WpLoVGIFW1r9m2onPoJYdwg9SV/xg0Yjug/WuQCpdJ/2k7f6oCQx2SVqjLt1goF9hfuZGRNKIlWBJss/Nbdu/ZtStoS0x1EmtL+FpCI1R8hNpS44JMMLFKu5J7TXStd1J3PYcRXHjwEzIGsnj+clk2F6f2C/ciVia8ovtxBYwrmjtpXcjo85tBbkTGrAsm7nc/zkVOGXC/osq5tUk3DUWo5vGQpxl3XefRoqi36irbhZCqiMkqE8VQVT2P0v/MMMo5IQJXA+U/pFx1Hyr9SVIFA1E6R68O1TwtuNsKxdrU6GOozOhQtU71g4SmVQIGUIkhD0+G7tkyc+7CWLPN6rRbOsRonDDewRIcfWKRC99tG9HcH78DADrEXmUM+Nnp+CztxoI2qgKDA/ImhO3NjghS9HsQEqujbBduT0CPtyZeC1QGa/QuNRS3xjdb3G2ipYtLYvRbJlWysal59yp9Zm2oDctPLlfxlin27AQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(136003)(346002)(396003)(376002)(66946007)(66476007)(66556008)(478600001)(921005)(7696005)(8936002)(8676002)(26005)(52116002)(6666004)(36756003)(186003)(86362001)(2906002)(7416002)(83380400001)(2616005)(38100700002)(956004)(38350700002)(5660300002)(4326008)(6486002)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxFT9aBqUdOzsjtqL3L6GpbGsQF1fa1ZZn+lzWo0PKEIfs0BfMV0QiHItHPZ?=
 =?us-ascii?Q?8P5lGuGGM8DiVTZ2CnvwumPXgag6Y1yYTevBrBwcEe0lansLUVNnnydIj7BN?=
 =?us-ascii?Q?dgf3huF3VaL4bQ6+E7U0/o7lcNTVvR8Yqdw6J3VJjfv4arXmnfoHtQSl/dWq?=
 =?us-ascii?Q?3TLWQopKu007OmFFtq984BEG28+4IiMFbNGy01p5QMwsA9XY9Xb3DInKHwPv?=
 =?us-ascii?Q?Mlo8SWN4kD1a97WlbOFbUVxGjNFXEgI7EENGrMsVlxSJTEBlOJ64/tyNRr+w?=
 =?us-ascii?Q?U+z9ZMYcVaVOzHUYsGL5XUNUeqqu3eyGQbG/7vc0T4g7Zp5DQ1Zw7IQx6Llz?=
 =?us-ascii?Q?qGjyTGVx1bFD9Ak+DJ46docHjkjafJif40JL+c0dbOZ+srTY42xRi+c6h250?=
 =?us-ascii?Q?IwqJWco53Cc+WSs15BdzJuw2rFOEAwjA/D6wwfstOq2dczZRg8/vO1513gXy?=
 =?us-ascii?Q?v4FVtvFSs25L6bLXNgEnghp5f3oRVB9qz6k/Djv+JTlMgDZr6uncrYjqxFKk?=
 =?us-ascii?Q?l4rwihCF4hsKNY8dXTC0qeanFK2CGH+Gwc5Sbzf+EVUeXjI0vZ9VV6AiIM+Z?=
 =?us-ascii?Q?I34ZN4IFr+DCNTOIwKcUaaKPOcM/svQKOBi7dOleHBj2ApkyqTxjW1q3sApp?=
 =?us-ascii?Q?E1cuyZdON/yqGWPczZ3+8Hj7hXlKl+bCoNRwkpH015SNhMeYSuvOw6uvdtPH?=
 =?us-ascii?Q?O8jPMN1fJKHbgyNAWZGdmdvsr3+b1JnwGbRpBMElfuN6phyniCod0TUcbbAU?=
 =?us-ascii?Q?f540Ni9NsDPUheILUaQCXh0bxni4NZJpCR9lfyOVf5rV3MXYUOPdCV3BRZo+?=
 =?us-ascii?Q?fRhPpzVvRFetXGiO7nkIdymSNmmrN1GpzTicVXryHqJtTbk0+IyhEdOdtQVy?=
 =?us-ascii?Q?W8lWSNfh5MsJS5qwzEn28M9VcOQ5gdjPk7SkpiHWneEYb78zrB5EIzlqaE4e?=
 =?us-ascii?Q?Qc9MgO0fb1Xwsl716ojivbCjSe9olaHRfHWrXge66CSqOdxO7dm23qp1FrPH?=
 =?us-ascii?Q?3xCqrVRaQwtnAOyx4zbgxjh3PTL+K4pph/Y6xWV11GBq8m6j0HsvudCTOqig?=
 =?us-ascii?Q?rvGenZbIEXvV2ytn6xfHtvtpMlx9E5HttWdhvaqKhKkTwGEIS3T4yPC0moLg?=
 =?us-ascii?Q?FGRyTmYMpELfpxq+4dNQH8Gv/65v4fqEenhZpKivDecLVIuvRg372Rmt1KrR?=
 =?us-ascii?Q?syptJ6/djbeaVOiT3JHgs9GHH5bp5dlGqLBy6tDwjDX4mOxfgmcqZZyDJfNU?=
 =?us-ascii?Q?EBTE1r2OF6bc1+KP1RiK4SgpStrPvJkobuSbhRvPgXsrGWy9bK+1bT7uS+S7?=
 =?us-ascii?Q?7rx/tRAHEPJAC8JPNUX5KnUj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f97b9c-957b-4214-04ff-08d95e7bd0d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:00:12.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgJH5nvaD3AfbaqDT83Kpjzld6tRalsn09ncBpTYhmmh66wJ4mCI4bJ3NWpLx/lLSYTIc0J0vq6YzFW8Jv5GOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce an x86 version of the prot_guest_has() function. This will be
used in the more generic x86 code to replace vendor specific calls like
sev_active(), etc.

While the name suggests this is intended mainly for guests, it will
also be used for host memory encryption checks in place of sme_active().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/Kconfig                       |  1 +
 arch/x86/include/asm/mem_encrypt.h     |  2 ++
 arch/x86/include/asm/protected_guest.h | 29 ++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c              | 25 ++++++++++++++++++++++
 include/linux/protected_guest.h        |  5 +++++
 5 files changed, 62 insertions(+)
 create mode 100644 arch/x86/include/asm/protected_guest.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 421fa9e38c60..82e5fb713261 100644
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
index 000000000000..51e4eefd9542
--- /dev/null
+++ b/arch/x86/include/asm/protected_guest.h
@@ -0,0 +1,29 @@
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
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	if (sme_me_mask)
+		return amd_prot_guest_has(attr);
+#endif
+
+	return false;
+}
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* _X86_PROTECTED_GUEST_H */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ff08dc463634..edc67ddf065d 100644
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
+EXPORT_SYMBOL_GPL(amd_prot_guest_has);
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
index 43d4dde94793..5ddef1b6a2ea 100644
--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -20,6 +20,11 @@
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

