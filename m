Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD4E3EBA92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhHMRAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:00:39 -0400
Received: from mail-bn1nam07on2064.outbound.protection.outlook.com ([40.107.212.64]:1622
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229528AbhHMRAd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:00:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By1S6b2t+C6GuySHIujw+UCwazL4Zh8BYNvwWxeinfM5bml8H1jwQa/mVDUzRU6z150pguR0a49SR5clgJWcZD1AlrzDffxnwziTd1WNb9HftchbnsxlsG/dKCyCezmgD2XxpuINKkfb7RsklUbC8Wtj9osNx/dhCd8cZ7lL/tu/gO7YgIZCOBbd4x0hNG5q74ywUD2PHZcx3XfxucWx9ledPisLVEJRsDlXPkTAGNQ7klp0jPKzhXx0B7EINICMdmJpfZbZhtoeZs+V9e0m1oCRR5ZtWUmoU9/1TPWHf6w9PsDK2ZSE9eK1OfFIQnmAaA2czLNAaO9ZPQfWStfdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00Q2fjJJ/6vok9IspBpmlVulXhi5VqfUNQviROdL1Z4=;
 b=AiQFe1jrmVOArYtZo8Mzlojcg1TQs43A41G4W295oDDROn4Gd/Q111Qh1+fkUl2vsXSbwJ2nykh9R2Nzw8Jz/ke5flsGOC6bil/0uQwJsWLW82lH3sQ0Tu+PYTJzYiwMbSO57LaReDgO9EEXz8AKPj5SH3uyu8tXas6pF9SJVev8VpPTyrP4RB5k2/eM+VmN6UpfsDXcBIK2xhCvy/CHL3nJceHXsxHlA/GCiK9gdzWNZQjwFRMzRpJnhEdSQBwAY3iWdeLmx5MgHG2AtgV3TDC0rp4mkj3YoHj83CkaahF1P1c+bfgdxHFB4xHEmSs5Jl6SJ9cIdYxxOGSEVUxZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00Q2fjJJ/6vok9IspBpmlVulXhi5VqfUNQviROdL1Z4=;
 b=LVejQMSFsp4d5gxxnWSyMnEOFNdW2cLFPh0q8a2r7Wr/dzoK/QvuwkNiTqnIAXBwgCh0bFH/HqrOvXtXU9SCGl22Nwty6noTtVHCJwVnvCMH6X0+zvEwy8mgsMFHPt/suqrVWrgD60RFBWzG7Kn2bD0UX/TiqTW7mPu4sza1eJ4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 17:00:04 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:00:04 +0000
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
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 02/12] mm: Introduce a function to check for virtualization protection features
Date:   Fri, 13 Aug 2021 11:59:21 -0500
Message-Id: <482fe51f1671c1cd081039801b03db7ec0036332.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0201CA0071.namprd02.prod.outlook.com
 (2603:10b6:803:20::33) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN4PR0201CA0071.namprd02.prod.outlook.com (2603:10b6:803:20::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 17:00:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2fa8f5f-8482-4797-61f9-08d95e7bcbbe
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB551813422E5943BA46922952ECFA9@DM6PR12MB5518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqPpLjptCS1EeeWFfaUU0HoaSPthfCx+h4fNTD/x3KbKXPjT5FKSy/1COkyMpmdDGttxGcBxadYhGSOhU8LvwAELh59P7dhVECukP6UHKnvwkvUY+Vd1mWfVhSUeB7d12BS/HJ6+p/65g1292ccn39l5t7IEOFQk6oCqZaG5c1wh7CkYQGuxADctDzNvkOIIlojL2Hf0KgBYjuolcFY75zbgBp1y807SqNpDlantJ199pcXT9+yLkbt+KWkEhcBHTFsqXI8vamb6MkMNLuCh/PixOhQGDGhSLr9l42pJl6Q1AIjMgNJc1wuer6/b8bFwmwXAQSYwkD7r81HddbECZSyRJd8SeI6sdWoWCh7rYxfVXGCXVK+P/SZ2NwIG8EcAFu/eZxm40JhEs8rHYGGFxVsqsqoTyg6emp+crYCUanPV98Y6Y78G2vlzU6J4VYbAKzLrIFM8g7N+cihmrbwGZpOzPHUxu8erb6IQPXWwysW49MG4rOlu2FNheBY/o/6vs6kQNoQYfELbZPaRDAzcQVkoxZFrvU8sbHm/ZsscXA/mptx4ixltfHvP3kVaH0PXNHCGAOoZ6g1XIggww71dAbwKPy7U5RQAVwlO5boMC0aMaQn1HjEnzHxWLtNJrVVIp4NUEHOBPdeg/piHnQuc1LHDGQrX6kNvb4TJJgOMD6iNlmcNMzjTpUcgm2hScfU8yoMHpwbfIZpptgKOLYAgOs4UIWqM3hM3LBpGpcy2PQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(136003)(346002)(396003)(376002)(66946007)(66476007)(66556008)(478600001)(921005)(7696005)(8936002)(8676002)(26005)(52116002)(6666004)(36756003)(186003)(86362001)(2906002)(7416002)(2616005)(38100700002)(956004)(38350700002)(5660300002)(4326008)(6486002)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QSiiEMt0H/c7gMmp/6TvvoJgJwt3VKzqTO+Sz1e0KiqUiNoozOTK9rG7xuRK?=
 =?us-ascii?Q?xFlSR5DkfcvRWFQawNUCx1/lNi1GHwvbMQV2K+CwRgBMTwcJAiFwjvqAPu1Y?=
 =?us-ascii?Q?9ff/dd/zgpN36ofslpUgImr08FB+QreRwQV/PXZQTw01uiZoWTwEjRgBFZBl?=
 =?us-ascii?Q?LCv4QujCe4KQ+YFV86eEPA9hJ8o6h3cfBRATclBxdZr5dNZJxE2lE/MXFpPh?=
 =?us-ascii?Q?s4LAbymOJPf2k+GAIwmZhKhkTqZgOOKO+v0G4wk5BHUrESd+nUqjuoDMveLj?=
 =?us-ascii?Q?UNWwUxoZSLKOf8Hombp9Rv0jABl5r3v1iUG8TCW7b8s/DV3FdojviDzvUgma?=
 =?us-ascii?Q?tDwrLZa5jQswXL5kyML98K4SItsbDQBL3OupK0u+43lCiyIjcU2ow9CerddY?=
 =?us-ascii?Q?Hv5IfF+LceImHmQHS73rvxfxK5wu3agoynhFMMAWdfBCOr2qgEldxPVCyAYI?=
 =?us-ascii?Q?4Fk32bGmf6mMYlB0edf/RuDB1adgU3hlefKWimIo4XOClRcmLTUuM8YYrJRY?=
 =?us-ascii?Q?TBZLqBRBoErFlFAdVroDEEgVB5WGjgLJiMPT7GhJZcXKmBZRNk5vSgHUiYXT?=
 =?us-ascii?Q?Qlx53xg2SV5FCd+NJaN46uhiw+iPdFHsVcQiHvIGfAjltexx5rq4pV9zS/Wq?=
 =?us-ascii?Q?UrZfrI6vJnUY2UmZoBkrxLUNqZtWHE+9Swsi0yIj+BDGX2K7D988g8zAbDym?=
 =?us-ascii?Q?5qhbVcS7biJDV6ubKATPI3UdGaHHVPMhaaBbpjElfa8ntfyApYplAw7MwD31?=
 =?us-ascii?Q?9uG8ccY5d3YcmG7qz5wB/utxaY7KSpz6tsbMeFt+wlTPF+wHx8BqIK1P7x53?=
 =?us-ascii?Q?tQHil/0aQFlPxJrRgSTBVg0STIO184nXeoArV2IzM0uiNeh+L8VnKWibBIMZ?=
 =?us-ascii?Q?Oa//mwRwbhu4+fT2E5jK3Tzulo80aLTaYwxGYRc7ws90mSOnFwW8z1f0+urK?=
 =?us-ascii?Q?DovQ6cf81XIaPSmiZRoBDw6AqO62nrWH8OizyMnQaUMwo7Dy99R/XO77xQJZ?=
 =?us-ascii?Q?m0CIZyDwZ72+i6E466R3Xy0rtf9ualnc1qgdhtmW95dwoKMGLc+VuHvWKv65?=
 =?us-ascii?Q?5M3liKMdAusWgUkL5DO/vvn36riUhZIJxXDR9tjIV5ZEoG8lnvlJxEaEAymB?=
 =?us-ascii?Q?dH7xHjW0F6jBHBPY7kfi/8gyIzo9xlozRgUuPyGvONR6eWI2jO5P60fm6vM1?=
 =?us-ascii?Q?UysOLEbw9rYADNWZVGUanIzio0sSAItSNYsMo1uxwqxw0dF4I9WmOefnGh5I?=
 =?us-ascii?Q?xDni5Wf0Oq0H0oSc5V1wMxI12M9swR73c7/ulxqx4EuA6Tl3SSvlAMRvbHvL?=
 =?us-ascii?Q?0HLI2et/HTZX8Puq44lCicL9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fa8f5f-8482-4797-61f9-08d95e7bcbbe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:00:04.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Txupxb2+5R9WAVgwG22f1MQTDZ0epN+V2Tn5+tv+USGJFMK/9UpQr/RBjl1dyp3WoYm44TWBlTZbZGAbsLUokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In prep for other protected virtualization technologies, introduce a
generic helper function, prot_guest_has(), that can be used to check
for specific protection attributes, like memory encryption. This is
intended to eliminate having to add multiple technology-specific checks
to the code (e.g. if (sev_active() || tdx_active())).

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/Kconfig                    |  3 +++
 include/linux/protected_guest.h | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 include/linux/protected_guest.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 98db63496bab..bd4f60c581f1 100644
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
index 000000000000..43d4dde94793
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,35 @@
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
+#include <linux/types.h>
+#include <linux/stddef.h>
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

