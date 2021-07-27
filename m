Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069F83D8288
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhG0W1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:27:07 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:39520
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232571AbhG0W04 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:26:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWpmIXFfZFjlBwOabATYwwJnuOXd75mvssDL/+/jCKES8f7p9TqRm4ssX5zcjO29HJg8ZS1ZkryJQvtx70Dsvo73pfRYc4T7Fr9c5sHoKgv0je2yUMz6eEyi55h1Jxbupt0aMoGfpIshdJaIqN25zXBHWwyNITPHTzHbDAnx+t6VoctpwoSQBa5iMzS3Wjmiv/qo3Tp49d+1s3J9RVbOfs8SJqFpj5LEQCvYWdjDqeb32xG9jstTzVHwQ8JlD2BK6wVflvKkgc5aTgQ0o1nsUocCnlyXRZPzjXFvbpezQcxOp3/DJDNItz6pJnk+DoKjB6uWTIi3MINg+PSEsZxW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D94tUDv6KePt80sethbOGHdYxlwwYHbtwKspSl/dixo=;
 b=g0HABxWuyEBgPro7+l0ZdMACIon90sR258k0X9RFXeFxv+IN9VJPApFR73UAYrnD661FWynZ+dPTVbLKXOa2i1rqDbI6G7tRZaf2K2wF/YKovFfnoJJYc0tb1fT/j1YR4Y3w+d5dHViubHDHs4pgvgsZx/+fBJgDox3Ouo2Fnm5PHqz7dugDSEm3ul4P6oBNUYLf1CdQPdKL8VXVZ/Da8DT5ruqNF2IX3PGj6Qyhe72kY+45WGubPaFBTLVSevExgX/f9rI5LnVyWQUaHoPigdeQ28xLzT6iJbfa20hy45bPPYqvWfz0sxNwrSDC+4jmCsqKcyFib9W+V7g9FD/L7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D94tUDv6KePt80sethbOGHdYxlwwYHbtwKspSl/dixo=;
 b=AbRSqNdZs9JUj6YgpzkTt/M46cfbeZBJQTQCoTkM9l/DZ+gfptA/WxVaqyrHVV4WKQzVVXNZyS8mXEjZeY3quh7Z+LOiK1K3u4WNHIxDGrE0fdwSWIMr90ImckeLmqwXHivRJw3qyD7AVhvbgUZC3ppngTDRlxwks6yw2pHBl7s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 22:26:49 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:26:49 +0000
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
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: [PATCH 01/11] mm: Introduce a function to check for virtualization protection features
Date:   Tue, 27 Jul 2021 17:26:04 -0500
Message-Id: <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:806:126::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN7PR04CA0187.namprd04.prod.outlook.com (2603:10b6:806:126::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 22:26:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 717f060a-ce09-4bfd-6ed3-08d9514da04b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5462E1D71C4524EFBC495C44ECE99@DM8PR12MB5462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHO+mLE4VdSGkVexmSJilen55jEjTS8GTaqInU8OCZJURUEKKiH6wLoIaBCotonFjYINFSfaDlFQsSnYW9I0GZ9KCHxBtvawV2kGIRLXevyuVYvWux9s3yOTcAiL092P3H+pwGl4BkXVE6tWtDvuiiuKoeogEAkME1G1SyC9lRSp3fk3YQz6fEMEzZsZkKAwttUpxV884TtjkpRBa87KDNb4o/c7sIP14a//tq4j7+XfhvBR3XeVlf97W3RqgwGDK0/PNpwIDhXPvx86QukFSO1PjRKUuCtQVD4719YcZB9WQ+Ywp4j0PF3GgSnfP5G+ksuCBJtw7Z2d+9HA3FoPqqjRWygDEAUOBPPkLgXgokMs6HKEPZncr3OoenxA1fbTrBTkecjQ4/uP39kjFdWu2R1q31+GO0PBI28xL/H5QAnJpd1ukcjMwG4+xJneLFYwuY/cbB6mjWJW3r0jz+zMEyfd+wy229lY6Ivz5WxP9CLKGiZ7nPHnUdDV4gGk0ecKY7BKpQsgz9zwr4Tf3ru7w1/cfMwcR7XC4LhGcXNgj9x9F02gFpBt5Cds8oFNsgLmYsL+jejPlzV8ukZgyRBICMOlzxpwyxZ7dG3jKnvcxSqmzcfKBTVLZklUtNBJhA7UXqtlXbLVLKS015MpVdm2fcvsK6O3/rsnk4w80R1B8s/ipKGPdc1WDhzGUPaDpUZfCPIUT634UBZp4SIjAyT9T8kxaB00RsXYqngdvLitifE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(86362001)(6666004)(26005)(186003)(478600001)(8936002)(2616005)(2906002)(52116002)(7416002)(4326008)(66476007)(8676002)(7696005)(54906003)(66946007)(5660300002)(316002)(6486002)(66556008)(921005)(38100700002)(38350700002)(36756003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/PxRIthfUgjSvOzOXFVDfetP3FE+cMWPbcDgoqdodIwAFD2ob5hvbVOx+p7U?=
 =?us-ascii?Q?GodRCOoEAypKQlcTEXj4nDUYsUQUyVceFkfzyCSZiDyCyyVbO9vyKRChEUak?=
 =?us-ascii?Q?Vje+poSD35i+VB+IIlDXzqIaa2k2R1GgNEtjqAXm8ApVTXTIGCFxHRSglGka?=
 =?us-ascii?Q?Mk2P1QMka5F9dxvWsDxCsXXh5I6XdoGlONEDNjqcRMENWKtBb7k/31zaaU+8?=
 =?us-ascii?Q?CFjVLIRmFBty7j3lZBQ3NmMmbcXoD2ZsJUCfVy1J99mB8DtN6hJWaVdK/sdP?=
 =?us-ascii?Q?d0WfS+FggVs+1aZrY28fpxF1LMtVCEOZK7JLOtgUudji5y7YfzAbJWjCD+Bi?=
 =?us-ascii?Q?08SI7OOFCzvMsxVGEyoupsIJGCLQ4Kic2W9Z/kXZYu5JcHPWKD3HHdLW1MS8?=
 =?us-ascii?Q?nhYE1mTQuMbqWfHDrFB+stZfD9iQwy7OnYNrZN/4b48/ZobEmrNMsnz6xzCr?=
 =?us-ascii?Q?rtV03rquzdDacDywnjREO2dg61X9+ljzOKG3lojbpQqh7vGgDD5AiWAHsJJ7?=
 =?us-ascii?Q?8sZsJvSKkD2HnzqGX/mL915cMocrAIZkzS4HbRPITBHpC9k42r3yGMUlWIyi?=
 =?us-ascii?Q?DeU+soKlXDakAzITsFTn2ddN3llWzbMazDwI908yE4Escazz8y9knSjJSi+3?=
 =?us-ascii?Q?D3VlkgWasR2rJDWAX5kWQcVDuM0vu0n4e7KLb6eL9hpMkRTaTr31j8xRevP6?=
 =?us-ascii?Q?hwD4O1uhoAMyuaPnjmEXerRozpP+/KuVsNgnLHDsCzI1A0Zpe+fwduX8CGfV?=
 =?us-ascii?Q?fXKeIxrEfAG7sgClLwyV8HVTt4oId035LtyR1XH73EZSK8SbGdu56nQLL9K+?=
 =?us-ascii?Q?Qe2eRkoQx7ShwNjLpuacHxVCXndXguia1T8yQ1hhtHu5Gm8gVT1YIE81GvxH?=
 =?us-ascii?Q?PxFmWFcxmH+mPn2UliCeD6mLcRc3XfTqvjTwiEsdrFyvuheGxc0abf4jgPoq?=
 =?us-ascii?Q?1rmvOCXTQucovzVuNnk18cF9LPBXZgeDkBKPtoSpunWipLP5VzYnTIGRglZg?=
 =?us-ascii?Q?KWUSoyHxBhqtS3YT89beN8wYlzprbW+QmPmwJ1wls6ih/0lgjjdomED4MEE/?=
 =?us-ascii?Q?dU1bF44pbLDV9RHW94GAiVzINOtGVnwqrnUrUSNz/SHo8v1RpadyW46sUJ1C?=
 =?us-ascii?Q?mHR2zPDAmyiXwQaaptwEh5LUhfx3HbYz/OLjkNaFAaaLVUgRPSacd/kcfz64?=
 =?us-ascii?Q?MjCQuzYRG8qPlJ5BKR/Je3rMlOgmKR1gNfNK+v2Y9oUeyeIR/ulGtUsUqthO?=
 =?us-ascii?Q?CNUIdaMHX2a3U1cOFtFNzqy+qMwbkXiSMF9E7dhuGl7EMXTsDR/4jqla+2Xt?=
 =?us-ascii?Q?V9nQ1yMMceQNr0lMKl++Z/wt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717f060a-ce09-4bfd-6ed3-08d9514da04b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:26:49.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAqqFm7MIdcu88eQAlOLDfwrloJneekLcMxN0JUEE1djlRNIG90oeAP9CYDEi2s/1Mvut8ee/ZKd0eCSw5uEow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In prep for other protected virtualization technologies, introduce a
generic helper function, prot_guest_has(), that can be used to check
for specific protection attributes, like memory encryption. This is
intended to eliminate having to add multiple technology-specific checks
to the code (e.g. if (sev_active() || tdx_active())).

Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/Kconfig                    |  3 +++
 include/linux/protected_guest.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 include/linux/protected_guest.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 129df498a8e1..a47cf283f2ff 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1231,6 +1231,9 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config ARCH_HAS_PROTECTED_GUEST
+	bool
+
 config HAVE_SPARSE_SYSCALL_NR
        bool
        help
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
new file mode 100644
index 000000000000..f8ed7b72967b
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Protected Guest (and Host) Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _PROTECTED_GUEST_H
+#define _PROTECTED_GUEST_H
+
+#ifndef __ASSEMBLY__
+
+#define PATTR_MEM_ENCRYPT		0	/* Encrypted memory */
+#define PATTR_HOST_MEM_ENCRYPT		1	/* Host encrypted memory */
+#define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
+#define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
+
+#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
+
+#include <asm/protected_guest.h>
+
+#else	/* !CONFIG_ARCH_HAS_PROTECTED_GUEST */
+
+static inline bool prot_guest_has(unsigned int attr) { return false; }
+
+#endif	/* CONFIG_ARCH_HAS_PROTECTED_GUEST */
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* _PROTECTED_GUEST_H */
-- 
2.32.0

