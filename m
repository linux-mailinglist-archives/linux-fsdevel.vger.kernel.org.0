Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5993D8294
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhG0W1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:27:16 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:42049
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232571AbhG0W1L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:27:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai1UQTOIwf/KXrk+Ua5QCpoK4sY+emn8rG4THDjxdDvb3tyGUee31bCK2gJVeZMwX9PJqbQO4xHhqVTPqzDxBcCfcFn1QZVBFWGCxk2d1SaUb+kDwGVIW0LWEcBm2aFM0FATjFdjZqiI/wp37tbC1qU+XAElaajd1fiAG6qJ4/DmXvtjeown9iMK/3UtVomXvBsPcl6IzFio1LbjQz05IMVYBKjue5IkWnI3GOdT/a2kkqzEPOXfhotGUi2f96HHGFBi+56hukoASOxUJp1EFuCxfHdpRN+NXxRJiIM+8uFPCLVHxZzHUC6DzNL1M8qDCrhqoHcipHPIK9Lqi3aBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rBYhxwUFw8fcyx0fuQ206NyJJMRUZngGck8eTaViKU=;
 b=E5ej607xPfpPPO51/1pKN4g4pWiGRiPct/UxaqpHZu0mb6H0YsGT8w/xrtWT4cESCV9TME9SgBJQaeb2Pck4s2Rx0JK1B+PgdLbHMP3kMN9eCG3iLjIoOPdHPX3uhDCCWVc5CL+4as2UnS4ROFViSzQQiX0eSALUeoJTImqNurImO2RZqHkyFyI6jeho0geNnd98Sdaj+5f1AL5ulxpEgNPm9C4CPmgxx9ssQAEu6oCLVH88skMVYbJ5UCttU4hhg1vmBG/Rn4Z85/rT3eVMUTksMCxNgLOsL4qci50kERoc9IzwIsNc05Kg9JqjsnRLUzMtgnzD9DIlgCMqu/84wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rBYhxwUFw8fcyx0fuQ206NyJJMRUZngGck8eTaViKU=;
 b=4JNGme4WyKZeEVBRd4wuMKiOM+j1chWIXrWAkn2h5i0AO4O3/ld8WZcWtC62e+Ur6i92qFCUdop52l7pgf8UrU02IpRwjqCVwpxTNqCX4aFWOi5tzovzlF9JIzrJ070DY9d/LHxvhAbnTCLsAtFHqC1QT4zAn88AHtFlx0YeEW0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:27:09 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:27:09 +0000
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
Subject: [PATCH 03/11] powerpc/pseries/svm: Add a powerpc version of prot_guest_has()
Date:   Tue, 27 Jul 2021 17:26:06 -0500
Message-Id: <19f7eefdc98e091fbfae9db0db575422f18f0543.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:806:21::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR13CA0001.namprd13.prod.outlook.com (2603:10b6:806:21::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Tue, 27 Jul 2021 22:27:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f293814-4a4b-4e53-7f3f-08d9514dac4c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5357FFC67710513F4427516CECE99@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAbHVrjzIYpjzq53UexUtPS4Mqj3/v17JOVKeJ1nk0z7aeEtELuC1CKLeBIsW95qO88RTTuIcs4aebvcZc3B6nCzcSN82Npu/UH69rG/Pxlcwc4HDdX48/BTJ7QNGhs/gmSzWpqbhTo/5aIks8fOBv0UJG/ImnMdbIbDsDURfgkx67Ya7Y7KJXfAqt1j1kUnTwP+u6n4CyBybiwQyOcwIJUSab4NSCucsPZMVl8Mp6Rfe0puH5nZnyXVJWiedHxGFNA30PccDFQ2NaLWk//PkDiCS5bPdIKNVG/ijQstBKnbNSPoLxBkXU79qF3szQeKYL0wGbZpwgtqiwdeZ14Ri3+kmd6VdY3feLm6NojfUxE0QrY/qz6u5lWgTfnMgpGVWbBrVxikvYEspGmwsW87T/yUkvly2qy19LKaIfwti0zvK/3XBS7cwhmnaDAYYVopkQPOip9kdII/WNIOQySYZ6kX4FcR1o7NVGElNXbyrECmxbJ9bC7/I0tuJ+ubXfQNo1Ro8ZoE3GCU4GpisgiWlnWZyWWO2E/N5SzwMRXIJLrYlYAc5lIx/BXlLpzMLNkipOp3JUKS3oXinyVifjuagAmf4hzkcxPDuSuzf9dMj9mfDoO0SXpWqhruUglfvh4+uup1VFXrbLOOaB560m+iEcvZykIcqryZCirgkV2dbiYOuW4L/eN44QUQHYey9ZCebmCC1JYSEXWCIcQB1YU5OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(5660300002)(36756003)(54906003)(956004)(66556008)(4326008)(316002)(86362001)(8676002)(921005)(2616005)(66946007)(38350700002)(38100700002)(66476007)(7696005)(2906002)(6486002)(7416002)(478600001)(26005)(52116002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kc7iz37gigN3u+7RGOhMMt7PioywRpKQ+A+3saV+wOhLSSKgZDhPLONaxLer?=
 =?us-ascii?Q?+tbc4SMj4dV6uHS6XyQwSM1Lh7VzGU3j6YnLCVUeqSqdREewhTgUyIsjaGVa?=
 =?us-ascii?Q?7IZskbey1kKo81/fw4bKE5fDpGUnqw/1Ryodw2FHScckh0cajaepUI518bHj?=
 =?us-ascii?Q?FJiH8Nh5GR8QOEQYzGwdeyHbfscZEqvG0rbSmmUTzOocsZxNRkfWzu0Td9EL?=
 =?us-ascii?Q?iu8lTRZaYclf8NAd9/XJctPbxW2niGR8/tJf6ca8+QIw9Wr41E42VrddgyZ3?=
 =?us-ascii?Q?7mVPyELznu+YVPH65U7E1LhAcq9Ag9feNiqYxYRWnrXc+DnLMUPnzI2Ac4EC?=
 =?us-ascii?Q?1QkzKEe9CKg9/0XKT2BIPINlqaUq1MNadW7U5MqobXx9JrkccwyAl2nR7ReE?=
 =?us-ascii?Q?M5gOK9G8KBltrwNXLbQOQbdsVuLtU01dvC6/INfwHk7dNk74E2EyjcPuUJ8K?=
 =?us-ascii?Q?bedVun5IqVFAxZaVrVCYEBGgeM/3TyqO6lUapt2ZB6Nx37HEbhgw6kPrCGpx?=
 =?us-ascii?Q?8rXdk4KVD36lx231hPbzzebz3JU3FM7z+y75QRV2xImlBb0QMWJcw6oGMueZ?=
 =?us-ascii?Q?5oUXCJGtDwhCKuMfjB3/Pulbp3xZYvwdxRX+7XeMcQE5vwhEYxjjGEITuORZ?=
 =?us-ascii?Q?qMzs/f1sYn4rdcsltu0iQQwRuTsw1SUJVixwluMUzsyicwxIprUbhKerbjQE?=
 =?us-ascii?Q?L4gm3V+PLDHVl1dBGeC3wLu0UlxjNq4hXWvZCQFNCGWztVGRiW+iL4CDEOCX?=
 =?us-ascii?Q?yoKY8d2R5wU6EHcQBQgegb7itpVKY0dClL8oKNlS5w7OonkK35K2smdue+uA?=
 =?us-ascii?Q?KO1mSVyXBroN51AAWADf4WS46pQgBrx0fcTY+hXhEJZ/CkpwMO3PgkpTalCV?=
 =?us-ascii?Q?jL16H8hUiceiOLyGDdNcZ/b3B9yg+YjhmCX9Wk5ZMetfAOIlf4cMHYmzJ2Vg?=
 =?us-ascii?Q?51hWnGOq3NzwMxf2pHlgr745Gut+mb8E+sFo7OdOZ94KvcZ4xS0gNsUR2xfy?=
 =?us-ascii?Q?WSOni8FRE5Bp9WP/KGlKrb7LhE8C+nD6lZom3hxiOeUMKnP9z8Do0MBSdKdJ?=
 =?us-ascii?Q?KkwYdfZP/hP1bf55Mkxiyf0HgKa5oiU0RhH9SXrh79Fic+ouRc+0iOpq2K1w?=
 =?us-ascii?Q?+iELD1u/KH2zBTsGpgR84ATwMfXVS/wm6KNMDr6y3AeyrvS2KfGPJXla0QZr?=
 =?us-ascii?Q?me6/D8OTm3NQDy5qYX/ps5t/4xwjcGEAORb9oSKU4J0ULDIsiMIFj8Okkh+R?=
 =?us-ascii?Q?ozTDg5pqkMGcq7Mr81kqAxKQFcZwzVXbO1CwaWHLG+r+RshD+d0suNgfuqYX?=
 =?us-ascii?Q?pX1x7N+gKLc0jz+QVTd0376Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f293814-4a4b-4e53-7f3f-08d9514dac4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:27:09.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3g9RhCcbhfP0KRAR+GITdr3ah14k0zwHJB6A4wX1eUIvHbQ1wBo7wlIiqoOaJZqZEByf2FPZxawQyr3ZydedA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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

