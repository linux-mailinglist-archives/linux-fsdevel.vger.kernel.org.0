Return-Path: <linux-fsdevel+bounces-552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E57CCB13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD1F1C20CC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FE444469;
	Tue, 17 Oct 2023 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TkYU+1sU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2959CA47;
	Tue, 17 Oct 2023 18:49:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B519F;
	Tue, 17 Oct 2023 11:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8TCXvehqk3Rv1uf1TQhTUZGpP+Q4+3Ip5EB2OLffCIRW9725oXK1u1CAr+eCOhcQNEWJ7cNxghMFIgF/Zs9zTvmfkDzj8NXIFpQQ0To5W46hUtD+cJGnuNnuTqG+eN30W1l4y5ms/yxVHR19mdk+3REduUrMjM7m1T2lZ4HT4/b6A5V4R9BVcYHg8AEfGPJgkdvHDrSS0FehER7hImf3R0OUM1/6Gc2tYgRPex6/T3ERACiZVm3R/7L3A09nnLV5whY7+9GOcuBJ2zK13v8ZLy688Q37hRiodHubBCcg3p/vHVWZnI4nGE3DwuTAvTHvqGRMXrIjB224UX/F8lfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o80P3JyfOmMN27SuigrR0uFnbUE3zC6ROmHfKue3NrM=;
 b=GThBdh54DZglKHc9bQdLNz1Rcu2kUVd4Md6MEchZ6MGPcHijZB6E5lWr/kJNNlVLGma6Z7ZsMYTe6FQNW81w7j1n8YLuwhO0lrBa/VZ09JlDplA/xYAtSn6ESI4C6xNkat9jISbqrV4/JRbqeMwuCJGPKdy3qhFS23D3y63sAMx86icGsyaO+Ik9iKlAM8h+tHscgW1XVGgBUi00pY4CHEe3c/O5qAVlTwoaPdx0/zIKEijmcJc0cz1LTDrIvn9tDZ6/olsYJnrEz6cSZBIhaF5vnB0j9dZqWRMYB5GHUZtrpyFDFOUthP8bb/JQP5WITHJG0JaMtNgL31sI/79bsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o80P3JyfOmMN27SuigrR0uFnbUE3zC6ROmHfKue3NrM=;
 b=TkYU+1sUQASfAR7lheK9ix9EMIQYcwZ2lU9YiY7c/V+XTJKDOGqewVhOXxC3E+a9FLaUFX7ZE3I5JgjboKy8NwG5EGrIuVFsg+UO4zDyAuz1FccA9l/xBmfsFdSK2ZtpGJPyKnYdnWA0soJEkWKOxpXDZCWRsL/kjyMng4GhYhw=
Received: from BL0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:91::36)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 18:48:55 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::92) by BL0PR05CA0026.outlook.office365.com
 (2603:10b6:208:91::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.17 via Frontend
 Transport; Tue, 17 Oct 2023 18:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 18:48:55 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 17 Oct 2023 13:48:54 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
CC: <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
	<gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v5 0/4] Add support for Vendor Defined Error Types in Einj Module
Date: Tue, 17 Oct 2023 13:48:40 -0500
Message-ID: <20231017184844.2350750-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH0PR12MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 223e974f-90fa-49dc-7663-08dbcf41b729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S/cN8jtqrzNp3OT4y3bgJmLApVENZCcIDN2oq9wPeSV3SaPB3hJYwKFfJG7dKgF/p1brgNwk8CA0lNfLpmQV3tASw0Z02tNLU/57ycEwIe6nG8MeXC9A//rOMUwavmVB1EwAft4ml56MiTvp1zJegmX6jmaR4+Zjar4uQkOgA2AFGxfRBQ8qsOmb9evNfBMiyhERSbj0OJ7563vG6MaHu3PFMrR/X2qoOte0qmT8w3kmBLISz5VjY5l97n8bkKtS1T1EZ4Xcrts5OMhXrDK8yegkCOnxQEJGEcbUhpL+mEHsrvyrh1uQ9tC9AhLtOgeW6stP+obxK8XJ/i0qU2gGfG44O15nMGJ7jCZS/cY6OWWvsKjdDJ8pNISDAYs0QcS1XDAfxafa3LEdORuiXwOuWzHSZUDQyCp2w5dKnZIIXuN+wVMJf5csANFJ2tepWxRY0KPR6kyFL//RHGylHBUhGsBHFemjN4b+3qGnWbg/O3EAIXi7qZGSGTDxnkSZ5F8YPpa3x1bZLGcfUdsr/HSbzyWuNDyQA/pNkD4xuUaD+ItcSljzaA8nTTTUrAxVPnRTb0i9YNpa6FXAZC9LLN+A4DgFHjmnnCkOCHxfTyDHwmFH1GZ4pSlzUvnAXiJ1+Lkz16zoqenjfrFTdi/lH5PVPqdRRkMeJ6unQBzOPMUmB50rWNm69m9dLLPfZhEakdgm+vRqOqhAYwihTlDpMkJogyQ3fj6/kjMS1UTMrxxAioofq5hev9uDP0vawb8kbW1qaxYMf26MIFX/TaJC+3X8ST1aKdKENDj79OHGGx/7gCY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(36756003)(40480700001)(336012)(2906002)(478600001)(7696005)(5660300002)(41300700001)(6666004)(44832011)(81166007)(82740400003)(356005)(36860700001)(40460700003)(2616005)(1076003)(26005)(70206006)(426003)(316002)(8936002)(8676002)(110136005)(70586007)(4326008)(16526019)(54906003)(83380400001)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:48:55.5360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223e974f-90fa-49dc-7663-08dbcf41b729
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset adds support for Vendor Defined Error types in the einj
module by exporting a binary blob file in module's debugfs directory.
Userspace tools can write OEM Defined Structures into the blob file as
part of injecting Vendor defined errors. Similarly, the very tools can
also read from the blob file for information, if any, provided by the
firmware after error injection.

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

Changes in v5:
 - Change permissions of the "oem_error" file, being created in einj
   module's debugfs directory, from "w" to "rw" since system firmware
   in some cases might provide some information through OEM-defined
   structure for tools to consume.
 - Remove Reviewed-by: Alexey Kardashevskiy <aik@amd.com> from the
   fourth patch since permissions of the oem_error file have changed.
 - Add Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> for
   second and third patch.
 - Rebase on top of tip master.

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


