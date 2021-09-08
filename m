Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2940415A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 00:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347980AbhIHXAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 19:00:37 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:6240
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348147AbhIHXAg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx2jDPfbPnWygVwslF1uk/0iW2o2RU2yLBPj+2ArSqHdzEegNPvNNgoHi5QzcMXHgBx3K6pHC/xwJ3KuxlY7J3aPc43znxh6AuJUOiKTsoeK1MvN4UsTUfvzpbhYWZsTYsjGE/S34Cj5pptfzHubWkva+z3WkxuirqJg2iL2b+b8sIr1Jij+n8iGKizFEYkICq1OqxH5mD2LELl+O95oHB99hMpmthHDooUqtOkHX7SQqYzdu6RqACzy9r06/OJhAZJ+hFJ8dzVaagJjaGh+qxjft9RVwo9R/xKPtKz2/4qm3C/0ofCqzDjv1xW+WaLHpm9M780mtyXntG1zEQn7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=u++cUN1Qd6RISwRJLRiS9b1AxjGiFOjFxkgnOKEIZvU=;
 b=nrOF2oYLZs44l9c3rbzgKANyVusSf/Zuyw2d+aDQb0E33t6gUN8ZcFLjxcj41VK7wqRfBYZ0kAvmvoJZB5+EVxwy1T09az1+nTTNCqQH3zAFYzFL5mMCovCjb9VIBf4b/DutzUZ2peh66x36r1F4m7vMxBz/SfKWIGhv2b1x+D0f6hw164fJH1M4nOA3ume1t3LVyz1YFc/W4/FNzkPN/xOoHbZHCif0uNKf8n3Uus8Jqvn49DUkH4BsnPP0fpmvFeLVpaKO2qlsMea9SDmmPf+RF6xU8z5FKcRbIVlLxvwpc1O/yZPy/4Gka1Y5WxpnjpK7dSKX6n/WSHBIdMeoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u++cUN1Qd6RISwRJLRiS9b1AxjGiFOjFxkgnOKEIZvU=;
 b=B/pWcf8vQ3Ts+/dBayO4wdN17XeXbq6Rosk8RtaW6diFKrsXbcshfTQGID+9L2ZbTS7HJbndiNHvWXcyB3NCdEkZqQTteO/knDvL/qF75V0URiFHWtq99Ivmx+ru9+zaHwcVn3FU/u0HX3JXtWykr4OZHaUFvdVrRyNsIN1BDgk=
Received: from DM6PR07CA0066.namprd07.prod.outlook.com (2603:10b6:5:74::43) by
 DM6PR12MB3049.namprd12.prod.outlook.com (2603:10b6:5:11d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19; Wed, 8 Sep 2021 22:59:25 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::d) by DM6PR07CA0066.outlook.office365.com
 (2603:10b6:5:74::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 22:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:59:25 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:59:23 -0500
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
Date:   Wed, 8 Sep 2021 17:58:35 -0500
Message-ID: <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c909acf-36f4-4664-b9de-08d9731c4ddb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3049:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3049AEF3D365AFEF21300D9EECD49@DM6PR12MB3049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsNHF/5Po3+zCYcFBwai44JpS7svEgjUpj7QcDh3pEMdo0rvrM2g7+GVoHgKdnIu7TdrODcCygWl3t35y1fWdGoDzSdXlsN+xMrYe5unAEseP8VhiYYuhHw4TkJYXy7Mo2ju46AVsc+OTlK/0xrjs/Oh5rjRMjClDPsZxvRuA4et2D48ZRgnsrvDSMNrrZ2oEfM8aOQXMNLs4HaJ7XGtn94xxozX9e91B/rwtchnrIptYNvd/vNxQgkdLJdjNpfY2vY2L2QRd+mJ+WLeMaeMdBl7juqiyMocLYI/oscfbp9wF3t2wzdDjyxErL1wLTodXpKww3YNwZc6k8kKQ+IbpuJ60gJa0M1AGFQCcXCoF4SQis5Eh8EdP1NsaHG96S5p1exLHbV3mHAI8mzJFMdqGIMtwd/FMA0hpPiOK3dtloTGSViiYwA7+Ybgx+MFB2LdOuDVI22/pInCKlw0IWx7Ca0rTnw7+B/ibmV4v9UFcptwIpKKIamnMuzY69HsqE9c8J+ZNF8n84reMotNRpCAj/HhclgK6V97sdJ2XRh4Ok8dGe63Zw4tiG7Qh4k6XSer0pAxJMnyhUOCnDAGmgS2luxVpCRbr60Bc0g7Z1u7NKFSKMJ2ctv+AM8v1WdHw4Rue+QvQlzI6MfzjbvpGeF0hUlRlcU269W6Tlvd21OdbtPJGzegvGYzZj4zDXrhEqFCmmemVCMzM8O6uchjfnbxdWnvpy0vo7q6eClip+23/GwtKSkfyBOJkdWYRYOhhv4AgXtzKtxZg9Uk8hgCw4mN0zki0MZBHmrlk8j4Vppfd1I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(16526019)(336012)(426003)(5660300002)(7416002)(316002)(2616005)(26005)(478600001)(921005)(186003)(86362001)(83380400001)(8936002)(70206006)(82310400003)(36860700001)(7696005)(81166007)(54906003)(2906002)(6666004)(110136005)(356005)(36756003)(4326008)(47076005)(82740400003)(8676002)(70586007)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:59:25.1160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c909acf-36f4-4664-b9de-08d9731c4ddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3049
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a powerpc version of the cc_platform_has() function. This will
be used to replace the powerpc mem_encrypt_active() implementation, so
the implementation will initially only support the CC_ATTR_MEM_ENCRYPT
attribute.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/powerpc/platforms/pseries/Kconfig       |  1 +
 arch/powerpc/platforms/pseries/Makefile      |  2 ++
 arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 5e037df2a3a1..2e57391e0778 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -159,6 +159,7 @@ config PPC_SVM
 	select SWIOTLB
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select ARCH_HAS_CC_PLATFORM
 	help
 	 There are certain POWER platforms which support secure guests using
 	 the Protected Execution Facility, with the help of an Ultravisor
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 4cda0ef87be0..41d8aee98da4 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -31,3 +31,5 @@ obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
 
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o
+
+obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
diff --git a/arch/powerpc/platforms/pseries/cc_platform.c b/arch/powerpc/platforms/pseries/cc_platform.c
new file mode 100644
index 000000000000..e8021af83a19
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/cc_platform.c
@@ -0,0 +1,26 @@
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
+
+#include <asm/machdep.h>
+#include <asm/svm.h>
+
+bool cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return is_secure_guest();
+
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
-- 
2.33.0

