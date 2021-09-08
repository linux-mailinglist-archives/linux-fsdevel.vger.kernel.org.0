Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455BF404150
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 00:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348100AbhIHXA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 19:00:29 -0400
Received: from mail-dm3nam07on2064.outbound.protection.outlook.com ([40.107.95.64]:26401
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347756AbhIHXA2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:00:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLgb/s3ZJxgzt0Mx1WgqWEZMusXn4s2LILg2+hvzfglzWfLRsPMOUv8mEHPjNtq5Gmo2vrfDt5WguYD6RigcxpDU9U7QTAdwOPwQESDDAFNu9w6K0l1HjJzuUfVRSnnddqptG2ZAB+saBU6lRLp8bNz0AjEH6hFOmTj8QgyXnAirsj0V5b2gL8lP5vvu475UFq0psjLfiz58a666ZKv1h9/Z0PnPaJjPY5RREz5Z9X2hRyK9lPWo6Z6OCa34mi/1hk9Hj134hJu0Z2qEVFSg1Sn/FapxBLXKM6OcvtEsXkn2FMQBil/vlHvXOvC7sHH3NpvaU9RbtUc/ubZfGmwTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PkHOOjZ5XwLPGXYBfaJ6+CT1G6w0aI8Oj/Og6FSB+Tw=;
 b=QI5bCGtdXaZosz75px9FvAzfPwvQp0VEOlmZEIXn2HInOJgZyDyOmDkPT2ObK8Clgo+KE1Mv1zmtmHEW8Zzl16iOXXLQRlsCPx7mhTtjHCjsiB9sRuZbLteWuqb2tvQlfwHER53BumMkulkjW8HPTRPGWY8r/Ze/up3e9VGTvaZfGEt29KzwoBI5sV7YszqAlDuuwCrKiMJfMApT33BYUfaycpjl6IVcJceq0tALvyC7wJOzKBCD61wbdAj8vKPVsOJz8nR36oYCwO9scRDVnAMnTxyg6+gM1tc7zom4QU96ayAC7r5416EIWtVMuP1Y+0J1OrHmgiYKUn4do5laMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkHOOjZ5XwLPGXYBfaJ6+CT1G6w0aI8Oj/Og6FSB+Tw=;
 b=RMYHxEZNBkd62HBTvqOgEs71Idh/l8SFGBwpv0vj36zxy5tbE1T9bPpN+irz1P2SkZh9ESnbw2k6rZNiQ+gqkR4WHTqayixpDUbfJoq2lnxKyusFWqv6JUacKceNuzZjQnUVukBLu659qma1cDL7v1jfVMMDmM9Ku76D9FqLs8Q=
Received: from DM6PR18CA0003.namprd18.prod.outlook.com (2603:10b6:5:15b::16)
 by MN2PR12MB3453.namprd12.prod.outlook.com (2603:10b6:208:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 22:59:17 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::d1) by DM6PR18CA0003.outlook.office365.com
 (2603:10b6:5:15b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 22:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:59:17 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:59:15 -0500
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
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 3/8] x86/sev: Add an x86 version of cc_platform_has()
Date:   Wed, 8 Sep 2021 17:58:34 -0500
Message-ID: <f9951644147e27772bf4512325e8ba6472e363b7.1631141919.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ab09aa9-ebcc-4f5d-ccfd-08d9731c4914
X-MS-TrafficTypeDiagnostic: MN2PR12MB3453:
X-Microsoft-Antispam-PRVS: <MN2PR12MB345397D64B1CBD2C98E948A2ECD49@MN2PR12MB3453.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+z77jWY3o8AoUGCL4bculuISBwUOUfXI2hfz/nKwHmZlmaQcZd7S3bOc7Rjg98lxU6+OOp/Xb1+TZ9SgfG/5VyflgddHTNr19FmiqBvB6d/+n0j6V9fAWcwx+t6IF/t7N6gxf0t5bx3qNWwN6DV+vtVA+ulWHEVj+xKkH44sBBtOqYg9jEbVHmvD8ukr3OWuJvljA7Saoe8wHtNpKhIn89j+ho7RSNssQXtcClpLYcouPQO103M0z420yG+NwzKl/BsJJsjuDSvgN/nz4/wvbzSWt0Yz5XK9odChvsQawPjjIegcgTIPgCTQuDsbSJx5Gkrl+XNBA23bPIR+g04K8ZhP2RIlWj5Ba/jVXdfY8u41rD5MQDpXnEL2t5l0d8+N7bwE/K9CsWwq06sMBClSXUzW+REMlEJQ2GOuvJ98AsRBvJvgNOsUoEv5F3YXPgF896i6WVxgfrGi1Bq7OOlz0w8LEqQFsNTEW0yBatJxDFVPAzUGebhcRBIC5T/NvIS4Sk8hbcEtbTOAZbxPXk07mGt+iuu1sCol/qkW9BdiL1Lc4Ihx9ZO1e5dRqyRWuYuX+wNGkiJKeinr95VTnU3+V0twzLVNHR/auI2dL0gHJNFxRMR8ARB3eg5t4a5unUCArEuG2lvxmn4F0KXJOanXFQs0gKY8gccnc1egsK05IGYGzbcGy9UUpEm3wecjNKjipw9Mei5lg1gCcjyQsdMOmVVQMG7HEdQ2ns8VDoMgQCXhB/ZR2gkw86AuNE0nLXBLnGmyH0LzH07MxT0FqDag9XEDFERTMm6C6AoR58xeH4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(70586007)(70206006)(83380400001)(7416002)(110136005)(36860700001)(86362001)(54906003)(921005)(316002)(336012)(2616005)(5660300002)(426003)(16526019)(186003)(82310400003)(4326008)(7696005)(8676002)(8936002)(6666004)(47076005)(26005)(36756003)(2906002)(356005)(82740400003)(478600001)(81166007)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:59:17.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab09aa9-ebcc-4f5d-ccfd-08d9731c4914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3453
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce an x86 version of the cc_platform_has() function. This will be
used to replace vendor specific calls like sme_active(), sev_active(),
etc.

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
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/mem_encrypt.h |  3 +++
 arch/x86/kernel/Makefile           |  3 +++
 arch/x86/kernel/cc_platform.c      | 21 +++++++++++++++++++++
 arch/x86/mm/mem_encrypt.c          | 21 +++++++++++++++++++++
 5 files changed, 49 insertions(+)
 create mode 100644 arch/x86/kernel/cc_platform.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e001bbbb425..2b2a9639d8ae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1513,6 +1513,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9c80c68d75b5..3d8a5e8b2e3f 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -13,6 +13,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/init.h>
+#include <linux/cc_platform.h>
 
 #include <asm/bootparam.h>
 
@@ -53,6 +54,7 @@ void __init sev_es_init_vc_handling(void);
 bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
+bool amd_cc_platform_has(enum cc_attr attr);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
@@ -78,6 +80,7 @@ static inline void sev_es_init_vc_handling(void) { }
 static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
+static inline bool amd_cc_platform_has(enum cc_attr attr) { return false; }
 
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8f4e8fa6ed75..f91403a78594 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -147,6 +147,9 @@ obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
+
+obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
new file mode 100644
index 000000000000..3c9bacd3c3f3
--- /dev/null
+++ b/arch/x86/kernel/cc_platform.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#include <linux/export.h>
+#include <linux/cc_platform.h>
+#include <linux/mem_encrypt.h>
+
+bool cc_platform_has(enum cc_attr attr)
+{
+	if (sme_me_mask)
+		return amd_cc_platform_has(attr);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ff08dc463634..18fe19916bc3 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/virtio_config.h>
+#include <linux/cc_platform.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -389,6 +390,26 @@ bool noinstr sev_es_active(void)
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
 
+bool amd_cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return sme_me_mask != 0;
+
+	case CC_ATTR_HOST_MEM_ENCRYPT:
+		return sme_active();
+
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
+		return sev_active();
+
+	case CC_ATTR_GUEST_STATE_ENCRYPT:
+		return sev_es_active();
+
+	default:
+		return false;
+	}
+}
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
-- 
2.33.0

