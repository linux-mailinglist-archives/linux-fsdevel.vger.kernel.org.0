Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DC7379EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 05:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFUDvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 23:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFUDvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:51:38 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E9B4;
        Tue, 20 Jun 2023 20:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxPaM2jCTfQeYFdIUl2hClsO3PBZoCOlCmWAAbaxwd4gjxo6UmEM6HjWCiO3QsPTzJpl64nF03prWAqvLi1HwdHPkcvIH835arW6zbkCrFjfQLgEhGzPBeqt8XvngHJcJLmfnY/wHGkEnhDoArCl/fJH8FOfn4FcmMU/UtSnOgPLJcLBFvVie6HpeW5BQDp9OszCRgXQaLczyv4olsVZnZvD4PR0jtfN+s7ufBLf8JavZqE/3SbguPB0M4WwKUZP2WtlGVh/5xkDhfAbYYC8HWxwltDS3Rh6Swd4aUuAl1gkaagBnFgz8qvycIl57jFedOuRu1JYtXxP7gU7a//c7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf3zBP/5V7VE6JujARpu8Qoubot3mBWPCsiRWZz12fk=;
 b=fPGgvNNWYR95E/MFhRcvQ2OxmXBZ1MiqIv5RXs0hIbXYZGnI9pnc/VcTFu8qnEUWaTSe0SUg+cIc+SWsWjLW72brCQiqu5gFeteBNRgItH+oYrh/JXLBW9VGwRu/9kH4f7S0gAVnsOatFPPhN8bBRbjq8FG67D5GxWqjefxHSvv4S0NGz6TXR0ISGS6ojh2KzIIUqhYR9AbMfcTbRtahZf3qV9b3HW29zEz+6SKvz6O5Q+5y5wjdduIxGDx0f9ki78ThSkf/WWOrePijOkU1e3WDkIqgNJsyYBQOtPowVYDudrGS8JPaWyrznYOfhIOX05JqPDtxEhNk83t1ONKLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf3zBP/5V7VE6JujARpu8Qoubot3mBWPCsiRWZz12fk=;
 b=5O/lP9D3Ayui1p/GlANNHQdvfDiQlVAqErn9/IRkKpss69FNxuCxHm5w+3boztdnEpImHbudYA3n9zHDNFAxRmo0g3vgoZLY8Yqc6GuZWAxePBqHa53c94/xtEkHSRcA3tDj7+mRucbIy6SbsLlHom/e94TK1phcHy9EN2a++sk=
Received: from CYXPR02CA0024.namprd02.prod.outlook.com (2603:10b6:930:cf::22)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 03:51:32 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::c3) by CYXPR02CA0024.outlook.office365.com
 (2603:10b6:930:cf::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 03:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 03:51:32 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 22:51:27 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v4 0/4] Add support for Vendor Defined Error Types in Einj Module
Date:   Wed, 21 Jun 2023 03:50:58 +0000
Message-ID: <20230621035102.13463-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: b5cec050-75b8-417f-f9b4-08db720acd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXjWeOiaqj5fVY2mvMVG7sqkO71WOsRuBXwJtEGsDLFAdCcJOZVPkewMlHN0+yNwWHNIkTU8ZrYJlcC6KtA9WmF6exE7bOETsYdfLsKNwPzky1JuEaAryWkjUUFqmKHiwCxXtNp/+LAPjiSOTWOxA/LPf8N35CGFCn6R32IWLhN6bHvBCwvc7wwLT6h2b7AFaNv8GDiv1VpWCyLwrKKsJVfW2+ToUFTxycLEsVxL8Ov8zdLhQ42XhpCC4WN0J5gp6BxLakERLG53cyEXL6pJHSM4eu4wFzt/GpySGJBlfY75iJH+MmOp4HDgPbZeHcj2LVVq/TtnjQiy2KAIfAZTPj4K93czP+T7ZivMlyaTujktIqRwdUSMRy0qakQsUXba3gs5Wi9qJx9HTkIVrg57FATREBBp6CSXhOxJtgctpm2LQkJC2DwLkkFsOMdWlXupmUKpt20lyEc4LIMXjEXi6dCvDExhV2YJeLsT0F8hCHZEcmizoDB9Vx30UoMpGYsy/Sp61qsdosfii7/XUKcj/Dss2bJ6ZqC3vNp8MSZwgQ1LA20qsN63cikwpDXS6P5ZiV4/G5Ef/o3gyeYh3u8NQrwEl0qb+I3rmvPEFGfodNg1p7eW57m7ySFoZ9aPaLPo4IGCCRNXR5dYAbyxPBDlzaqjcBSReUj5uFyN6T1fT8ZHhFOd+cHoWwoEiKmpcNdpLVit2d+ptlZpwHc+Q/v3u0vjHfX2dUYakIym+T04FJeI6OirHS4CjrVtvyij/W8kC2Cxi1Fpejq7+8HV/5ja6tNLCTpbINc8cn1QZX392pc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(81166007)(356005)(82740400003)(426003)(336012)(47076005)(26005)(1076003)(83380400001)(186003)(2616005)(16526019)(40480700001)(36860700001)(44832011)(2906002)(5660300002)(41300700001)(8676002)(8936002)(36756003)(6666004)(7696005)(478600001)(4326008)(70206006)(70586007)(40460700003)(316002)(54906003)(110136005)(86362001)(82310400005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 03:51:32.4591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cec050-75b8-417f-f9b4-08db720acd7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

This patchset adds support for Vendor Defined Error types in the einj
module by exporting a binary blob file in module's debugfs directory.
Userspace tools can write OEM Defined Structures into the blob file as
part of injecting Vendor defined errors.

The first patch refactors available_error_type_show() function to ensure
all errors supported by the platform are output through einj module's
available_error_type file in debugfs.

The second patch adds a write callback for binary blobs created through
debugfs_create_blob() API.

The third patch fixes the permissions of panicinfo file in debugfs to
ensure it remains read-only

The fourth patch adds the required support i.e. establishing the memory
mapping and exporting it through debugfs blob file for Vendor-defined
Error types.

Changes in v2:
 - Split the v1 patch, as was recommended, to have a separate patch for
changes in debugfs.
 - Refactored available_error_type_show() function into a separate patch.
 - Changed file permissions to octal format to remove checkpatch warnings.

Changes in v3:
 - Use BIT macro for generating error masks instead of hex values since
ACPI spec uses bit numbers.
 - Handle the corner case of acpi_os_map_iomem() returning NULL through
a local variable to a store the size of OEM defined data structure.

Changes in v4:
 - Fix permissions for panicinfo file in debugfs.
 - Replace acpi_os_map_iomem() and acpi_os_unmap_iomem() calls with
   acpi_os_map_memory() and acpi_os_unmap_memory() respectively to avert
   sparse warnings as suggested by Alexey.

Avadhut Naik (4):
  ACPI: APEI: EINJ: Refactor available_error_type_show()
  fs: debugfs: Add write functionality to debugfs blobs
  platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
  ACPI: APEI: EINJ: Add support for vendor defined error types

 drivers/acpi/apei/einj.c                  | 67 ++++++++++++++++-------
 drivers/platform/chrome/cros_ec_debugfs.c |  2 +-
 fs/debugfs/file.c                         | 28 ++++++++--
 3 files changed, 70 insertions(+), 27 deletions(-)

-- 
2.34.1

