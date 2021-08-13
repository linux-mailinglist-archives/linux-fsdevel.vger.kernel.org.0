Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285ED3EBAA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhHMRA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:00:57 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:34945
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232179AbhHMRAu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:00:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oK/2Ut8+AGCxUJx0W5zycF1x+1t2XqAU92mfds1VP60UjNDCnHUNw8cedHlTpjai+brFHkbEwAFiDbnfrPmWQHrewRLtO0HhI+6nl5fyQnobsge5ggCM6laOfBMk0s5uI5Wxh7pUu9VJob15xl+bH4s9BO+5rTMHCYsy3zZsr/w1Ni8G95rHPbMQROFDT6hIODSeb0K2U9U/5lfV12gxzs/WVIlJrLAFtS19OIT+sGqYnkYMsT8kibIJBeFJhLLR4FdrRdkr9UApazqpmp6mOC8oL0EZSRXvBMSoezpMD5W8z5im0gs6jISYwsV+FICiinCpDxym0sfV1BVb2b4KgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rBYhxwUFw8fcyx0fuQ206NyJJMRUZngGck8eTaViKU=;
 b=ixPBh0cVUClx3XazcvSoLSGIhzRwzxGV48OibUA7sLo06G7Ai5zul/+fkl/TKOBM6RGbChtxv9TzxM3iQMrvNX+JgSeyuw7kLr4/ZgzKO7TeQO5OiIMZjJEEGxkErwjXAxfkHrf4EMJrQmiNm1B1RlyqSGOmd1/TtV1I8OWpxh+qpWAvMYSDiHnfnZUclaA3/cGpQYXSNIyFzRMjLZhcCEQpW66mizS8CPdzCpN/pA1Hu45+vr1rXOy7HSyuGuw2vKHXkih2dYZkvcxihBraQLcJF0XoWX9X7PTTv6+FPh8XltQIbIRsltJ6o46qJ58EZjaNDo+PIqc+LHWebNyuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rBYhxwUFw8fcyx0fuQ206NyJJMRUZngGck8eTaViKU=;
 b=GVgMojjDS175NnefMN+kjwSgsWvicHKrgnLflWnzkYu1E+ihwWIVwsZi6W1puvRbBZP6enC6s28BGlg24IjQ4moo/RnwC6K0QStCVdRfJjgBrE+hQBzY3t/SMrEO+BIdlV8gnvGyGnvggOo3zLQAF0otdFhgrvscggqXzgUstww=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5535.namprd12.prod.outlook.com (2603:10b6:5:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 17:00:21 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:00:21 +0000
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2 04/12] powerpc/pseries/svm: Add a powerpc version of prot_guest_has()
Date:   Fri, 13 Aug 2021 11:59:23 -0500
Message-Id: <000f627ce20c6504dd8d118d85bd69e7717b752f.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:806:d1::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA0PR11CA0100.namprd11.prod.outlook.com (2603:10b6:806:d1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend Transport; Fri, 13 Aug 2021 17:00:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bce5eff-be55-45d7-dbbb-08d95e7bd5e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB5535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5535B0BB4578B276D6273727ECFA9@DM6PR12MB5535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5HTomtymFVTmu4fZ5h4REqZZbJsO/VgEfAZoc7RxxTHii4xYzMYghE2G/djmL6z5ncpMekJtllsReLXD1Opx8ikmjHftat8V8SIdoFn70Aoy2Tx3jl0FWB4QBPBKVvK85S6exN363NEeD3mTZJS9eN+DWq0H4lcICxm9mfY5G+RWYIZ1qp3Pg3P/VO2UQPJOueymH7j+vnedPE+xIkvyqv2u47av/2QYafashGp+EJx0Ht1aAUKQubBxIiGvvr9ocsdoDbv3OM4j+lqHKGn3gpvy6U5BDb19QvrseLsa4hWXeuv/S/p0erTYoMMPEHkKhT8MmcbiymegA5mUZMinlCltm80Je/N1YAG7c2ln3yhxe82FECa5zBeu30KXWPagB3WbLfwXEFjNTGBmRcU2oaqsqyCmGWsAwayed8/k6PlWwZqqqmM3sfQV5yCqJ+X8GN9OJmRnDu7/5XBtLGIUhSlO9eyP+4Dw6Ov15Ydd0DIsCToOw0QbXNGqnHyM0uf9TxLJGGUHpQhLaKbu2vgPVosntgRnu/2kg200hx/QEIl0sVGBLhkc5a3H2pyJxTpLUdeXNzGLS1IeLF2IWGGqGlpUIS+jcujpF0KinNCqSyOYhXMmCRWz58pBxyO3az7Ph/+u9s8lTDj8OVHgBYuBbkbbzaKOZbuX/RvSdKByqjcJlNGeKX5pjmk6oWEzGjWq4qUA+8wDZvsjiI8kLikUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(66556008)(66476007)(921005)(52116002)(66946007)(4326008)(36756003)(38350700002)(38100700002)(7416002)(7696005)(2616005)(956004)(186003)(5660300002)(2906002)(26005)(8676002)(316002)(6486002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?co/jy0FU9OZZPjQPiXPlHdwTIioZtB+0e7VWEGI9UYLUnE+4eh4wtxWPA1mG?=
 =?us-ascii?Q?UXQIMesbYMFDDWCSgdc3l0pXWhKMTSrG4ocP9WWIFufkSnGNCJzZ/k9WYEG5?=
 =?us-ascii?Q?PM04wTK7rPo0aqOuSJLZn/A5gSJcR1AO6gte755ENRmi6bn+NoTgDAntoVf1?=
 =?us-ascii?Q?Y0O+xK1UT5sD8HQnKwq0BICObSKjcThZ1xnNHy5mZQUaqlL1XMkZ6aI8FJBz?=
 =?us-ascii?Q?+of5XGXGWxmrV2MKxat4ySeKdyhNe4d/qJRJlLGaOElGmN5jiaF4JRcT2kus?=
 =?us-ascii?Q?GpjbwfFaxMzz9akJxIbia4KdIC8MH3XTwny1g48OTmN0THOwxHiP1eyUx0yq?=
 =?us-ascii?Q?cN+Z+xgsWKmeVoe96PzPvR6ez0V6vNJiFWVmdrzTmDKRMRATAaTDxGNfLBGP?=
 =?us-ascii?Q?atac91jE6ux1wt9b/BE32r3y1KVnf2zi1F4DnJG4Is4AbXM8L0itrplb8fVB?=
 =?us-ascii?Q?VamWiG0Re6LD9OpOdnC2fLAo6cU8BdN72xQY0V/bxKtK6EdW6fKXY3gGrBSc?=
 =?us-ascii?Q?cbJWizA/tB/JlZKH4LT1LZsf6Qu1OP15MKDdRihy8jpfdAwY4/ZA9yZBZ2uK?=
 =?us-ascii?Q?i1HvEt2TlXpWWAs2EMaPJASFsHQme9KPDDw7l4vWE5D8EAEwxmGSkpjnXFWd?=
 =?us-ascii?Q?CErEggUaB67A8z+PFbrfD7VjZr76R7nTdQESla+MiW+4yG2Feca/oQi4IyZ+?=
 =?us-ascii?Q?vW17Q/6fVXKmPSunLfPvA3TnUn55UKZGHhn0iXqweP6y1dkSG8eK0ca533bx?=
 =?us-ascii?Q?z90vtx8x7mrrD2MSpxvHVm8Kr4bN7v/tgQ1ECbZJ+y8wJVYy4QlHefwcFaTO?=
 =?us-ascii?Q?J4Kw2TFuCj3vBUVZ6CfxRXlFoJHXYzmkYm7qyU2sqmtpeVZKlwyK/hZnV9jr?=
 =?us-ascii?Q?6q8IRlSxM4UKhhNL/1Y3JJOAwK6BInMInBGDc2/UwThZVWLj6UrCQpP19LuD?=
 =?us-ascii?Q?kfP3PSapX2SqoffFbtTneOopIBtW5vp6oBd8OdyNxFW4c1PKG37t+5q10ZiU?=
 =?us-ascii?Q?Om4572FByc77RCbdnyQUGWjrT8g6I7WFmORWQxfDiOHMiS+E8DDFm4nh8hLV?=
 =?us-ascii?Q?GuiSruQ83IJj9XEHd6nWQaklUvnsPTWTcdaH0Bl48UTzwzOOCfJitN8sKAYq?=
 =?us-ascii?Q?UZbF1IeETSLVbOdRHdts6Q8AzDJxg6fVFs1DsMeHWUoj/ErnXF5B7nHqZhNf?=
 =?us-ascii?Q?wB/BEG16+r/GGDm5UabMJ8TNEcr0mpLl8xX6GYABOhNUSZ8SLnBnaFPkHRKR?=
 =?us-ascii?Q?JUlm5KWezfEJanVgyLCRZKPIsQIOLPpLSw3uAns76i+NOhAiwKfoks2jj8yN?=
 =?us-ascii?Q?ePnJb5peZWngkO+Bm1KiuiXj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bce5eff-be55-45d7-dbbb-08d95e7bd5e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:00:21.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqOAYCkbdSu6ytyOLP1tIRY5qvQs3lxBTGCT65o9ueikarKZb5dV+FsMz+OhuldzCP+naJUQwedpRL3RGpKHHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5535
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a powerpc version of the prot_guest_has() function. This will
be used to replace the powerpc mem_encrypt_active() implementation, so
the implementation will initially only support the PATTR_MEM_ENCRYPT
attribute.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/powerpc/include/asm/protected_guest.h | 30 ++++++++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig     |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 arch/powerpc/include/asm/protected_guest.h

diff --git a/arch/powerpc/include/asm/protected_guest.h b/arch/powerpc/include/asm/protected_guest.h
new file mode 100644
index 000000000000..ce55c2c7e534
--- /dev/null
+++ b/arch/powerpc/include/asm/protected_guest.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Protected Guest (and Host) Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _POWERPC_PROTECTED_GUEST_H
+#define _POWERPC_PROTECTED_GUEST_H
+
+#include <asm/svm.h>
+
+#ifndef __ASSEMBLY__
+
+static inline bool prot_guest_has(unsigned int attr)
+{
+	switch (attr) {
+	case PATTR_MEM_ENCRYPT:
+		return is_secure_guest();
+
+	default:
+		return false;
+	}
+}
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* _POWERPC_PROTECTED_GUEST_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 5e037df2a3a1..8ce5417d6feb 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -159,6 +159,7 @@ config PPC_SVM
 	select SWIOTLB
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	 There are certain POWER platforms which support secure guests using
 	 the Protected Execution Facility, with the help of an Ultravisor
-- 
2.32.0

