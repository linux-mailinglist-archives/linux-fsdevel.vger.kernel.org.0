Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB2A404148
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 00:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348007AbhIHXAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 19:00:23 -0400
Received: from mail-mw2nam08on2064.outbound.protection.outlook.com ([40.107.101.64]:52193
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347607AbhIHXAW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:00:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4nRibuF58rgCsJfRBv76wF4EI1MUP4dUgDnD6U9Fi1ILZxB5fHN00GPTRm74yr78FkU4vNFrp8IipJq7gPWK1Mc5uAjbfFntFTgAWl/XDoEx44bdx+U7ITM7dy5NKzT0L4XP7Et1U9S5kObXxBEAyfO2HCGK2KVsdTCwcln8JTgTM0pAyJF7waa+SKUcqlLEMYhhjLk/DRmG8z7O35BWyEMjOU++9cyiWn1uFsLENCKQOR3czjUYFAk6nRkgnt3MSgxBnDxpGzzY7K+oh+iRbH7CwNmbLnZpVlamJhaKbfh0vwKzZWi6VgfVOVfXFsuawFM+U80C/ew0fZ6UiI74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SHft1xeMLhkBPYDzYQt8LaIvbeLOAmhTGlhraPgkBIY=;
 b=dMvOs05b7NiYSMsx5eSUd4Jplx+iQEq1Ysz5wQBGCAFjEFbYk1Rviut7sk+2X9bdEPWG4rVFZYiYIikurakc/lG/g7vAguTXuIB0ebisrFCXZtuzAtqtR1y5jrKMcL4QGk3Rl1di7bg2NEt/yOrcOF38KzeJY9B4b0M2MjSVTtRGSPTMQ8E64xxelr3hN9wX+ThsClOUHw5cMT/NfIM2bYhxzEOypRhr4ua740CCsskTr4zFbdvOFbC03UGRn50N/BrvLsT//L0o0TahznbdYItJh5ruH3yNPvBNEq7LhNj2wWFl6SS3IX0gdwGrCUUxCjJvTHtZPkXqgBXxkCXYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHft1xeMLhkBPYDzYQt8LaIvbeLOAmhTGlhraPgkBIY=;
 b=Gitot9eQ8Rj1LNdG4PgLOWNalhBn5T8ewnVfxRY9p+UfgN1j+//B6z9LQxgb9C5P/eMqwt+L++bYbtUW6RLI7tefHhe2PUpcSrpzZH0CwWZ/vzLm/oCRGUJsghqJ3xLbph70y1yPNrG6IUscx4qPoK3GUfYDAm+pFmNBmaYzXuQ=
Received: from DM6PR03CA0058.namprd03.prod.outlook.com (2603:10b6:5:100::35)
 by BN6PR12MB1332.namprd12.prod.outlook.com (2603:10b6:404:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 22:59:09 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::99) by DM6PR03CA0058.outlook.office365.com
 (2603:10b6:5:100::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 22:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:59:09 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:59:07 -0500
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
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 2/8] mm: Introduce a function to check for confidential computing features
Date:   Wed, 8 Sep 2021 17:58:33 -0500
Message-ID: <0a7618d54e7e954ee56c22ad1b94af2ffe69543a.1631141919.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66d45662-8a16-4741-b832-08d9731c4478
X-MS-TrafficTypeDiagnostic: BN6PR12MB1332:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1332CAF32444BF581BFFC56EECD49@BN6PR12MB1332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: me1ISZsQ9Q/ZTy9AcUK/cEFHVLwQh0tIjmGXIgWFCAEjrStdEI4h7+mBgZvBgqhiaqcwmzjwAgLd45ztzGxCQhw0QpNEHVIpiVGBFDMYiPc8yLs96/fcOuHR1nKE7Yf0GP11gvAuY36ozQrM6D9/BvcyyjoirO4ohYha5qDorqVSWEOL7Ez6r0lVVBUKIqc7FBP6YIh2sKVYnNNMgTQWxXkaXkS2paL6os2xvaIE9dXqFq/xElrkRB52vwJsLLNK2ILJbEv/1m0Qoo+UBgFLiTCcfrAzrmPiZwNMaVunb2K2bmhD2E67AyFWuuf1aXajoY+i794Gnfbxds3NmJVnnAe5TXyUMpB1gkk/3rq4hKkqjrF3HnV48cETGMHWJJ691VzxFPRihwMfkRTIDc4y7S07Yd2GVfIFn+9PoNiLbXftQKDzz/UbgenVpLoDVn6qnoLgjQTFgM2CXVAJ79qQ9xYhYuXf/5NuGqpBdcAXfI1liqKi5Zhq66BOeFpPIEe7FhuMfO3Wh08Sx3+ENPR1YIga4yKIPJX7yNIysySqpOwbV2bJJiCyalGTda/Py+quF0k9dPc7bxZna+rIjOLsVSt6JnGIl4P51c7vjoI1YA9TPybeKWVUi3/PwrauZfvf/GwBFsn1keq5WJEn/OFN7HnRzK7lunaNps6BlouTt+RHdVuJync/Qj/4HnpnQlbV10j9n0EiajL0SCvrq156q1Z9CkEzv9HrKij3oVmefBtzlNfhM76JuXVsMhaT46T3ini+znIj3Q0HZvU02R+cYHhZgbSXojT32L46c0KfuIw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(426003)(2616005)(478600001)(70586007)(921005)(36756003)(336012)(47076005)(4326008)(82740400003)(316002)(7416002)(54906003)(110136005)(8676002)(356005)(2906002)(81166007)(8936002)(7696005)(186003)(86362001)(5660300002)(36860700001)(82310400003)(26005)(6666004)(70206006)(16526019)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:59:09.3747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d45662-8a16-4741-b832-08d9731c4478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1332
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In prep for other confidential computing technologies, introduce a generic
helper function, cc_platform_has(), that can be used to check for specific
active confidential computing attributes, like memory encryption. This is
intended to eliminate having to add multiple technology-specific checks to
the code (e.g. if (sev_active() || tdx_active())).

Co-developed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/Kconfig                |  3 ++
 include/linux/cc_platform.h | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 include/linux/cc_platform.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 3743174da870..ca7c359e5da8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1234,6 +1234,9 @@ config RELR
 config ARCH_HAS_MEM_ENCRYPT
 	bool
 
+config ARCH_HAS_CC_PLATFORM
+	bool
+
 config HAVE_SPARSE_SYSCALL_NR
        bool
        help
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
new file mode 100644
index 000000000000..253f3ea66cd8
--- /dev/null
+++ b/include/linux/cc_platform.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef _CC_PLATFORM_H
+#define _CC_PLATFORM_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+
+/**
+ * enum cc_attr - Confidential computing attributes
+ *
+ * These attributes represent confidential computing features that are
+ * currently active.
+ */
+enum cc_attr {
+	/**
+	 * @CC_ATTR_MEM_ENCRYPT: Memory encryption is active
+	 *
+	 * The platform/OS is running with active memory encryption. This
+	 * includes running either as a bare-metal system or a hypervisor
+	 * and actively using memory encryption or as a guest/virtual machine
+	 * and actively using memory encryption.
+	 *
+	 * Examples include SME, SEV and SEV-ES.
+	 */
+	CC_ATTR_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_HOST_MEM_ENCRYPT: Host memory encryption is active
+	 *
+	 * The platform/OS is running as a bare-metal system or a hypervisor
+	 * and actively using memory encryption.
+	 *
+	 * Examples include SME.
+	 */
+	CC_ATTR_HOST_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_MEM_ENCRYPT: Guest memory encryption is active
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using memory encryption.
+	 *
+	 * Examples include SEV and SEV-ES.
+	 */
+	CC_ATTR_GUEST_MEM_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_STATE_ENCRYPT: Guest state encryption is active
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using memory encryption and register state encryption.
+	 *
+	 * Examples include SEV-ES.
+	 */
+	CC_ATTR_GUEST_STATE_ENCRYPT,
+};
+
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+
+/**
+ * cc_platform_has() - Checks if the specified cc_attr attribute is active
+ * @attr: Confidential computing attribute to check
+ *
+ * The cc_platform_has() function will return an indicator as to whether the
+ * specified Confidential Computing attribute is currently active.
+ *
+ * Context: Any context
+ * Return:
+ * * TRUE  - Specified Confidential Computing attribute is active
+ * * FALSE - Specified Confidential Computing attribute is not active
+ */
+bool cc_platform_has(enum cc_attr attr);
+
+#else	/* !CONFIG_ARCH_HAS_CC_PLATFORM */
+
+static inline bool cc_platform_has(enum cc_attr attr) { return false; }
+
+#endif	/* CONFIG_ARCH_HAS_CC_PLATFORM */
+
+#endif	/* _CC_PLATFORM_H */
-- 
2.33.0

