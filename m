Return-Path: <linux-fsdevel+bounces-2321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D54EB7E4AC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DB6B21037
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015192D798;
	Tue,  7 Nov 2023 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DIlP1ByP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6FE2A1D2;
	Tue,  7 Nov 2023 21:37:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254E10E5;
	Tue,  7 Nov 2023 13:37:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hs+5BELWO4lcPoz50RnTuYmZWeOmIbKgaWZh5I8brnTseH9vI7ssv1qBEoj3sJTRNxjMZt7eJ6otoE6ext6IEybJPAHQmobrH4N+x8auweefRtNVJAaegiv7z1do7711heQCOSixgrQvgTOv/h97RQWCmBk+5NIwMKQsVKIaG528Z/d0ib3LUZVCWtxc5goEmvKkkk37u2m8PfahL7UG3FJ+MIGg7v+uMh37JsXj6ajOI9/zqHUXR3HLv0ebsH3guwRkGFR4RVBMIQRsXmgPmkc3iuOi4HbkzsUgqi+nexynDOXRag1pnHQ1ru5yVQoosZtBFHaalr8amWqLRRZMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o80P3JyfOmMN27SuigrR0uFnbUE3zC6ROmHfKue3NrM=;
 b=dj5xna0QnWU4EVUW5cskdTOJ9yDDrxZ//6x5ZOUt+PjoTe0/YA5k6TPPQxoUQ2NoWQmM5LHoaSNQoN/ZNWQTyOi8pwjj2ZlPtlUVJ0zv545NDitzh8DrdYJZEanLRPn9Brqc/yhoZskYxhnl8zg+HCuaKR2I93KG/SDGPudjQiBQUeZm+XRGVeTbf/Yp7ALkdwH6hvaO6W1jwL4B92iixU/NInpqQ9OvzEoKABQczISJpl6gpzOs0BtEZ4elWf5WuPf0TQnRqsaiuHQFTZAksS7kzqHeFJVUYjKbducJv7P0UdTPCUavNf4bOBae7NPJ2gJftcShMD0FatHJ7QYPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o80P3JyfOmMN27SuigrR0uFnbUE3zC6ROmHfKue3NrM=;
 b=DIlP1ByPa6kZxELNTdEHtqcmoGpGN1drQWdtmb5qwedZFccugeq4cr+rzP/0jNstq0GynVk3p22YMvMP44ieTp0iurhxbuRvYg6V6ICidTRgbcCwlNkkkcMA89m0yisLtGkA97rSNbFoH2nflrMYRHA9JenpimKRocpL+CxO2pk=
Received: from SN4PR0501CA0114.namprd05.prod.outlook.com
 (2603:10b6:803:42::31) by BL1PR12MB5852.namprd12.prod.outlook.com
 (2603:10b6:208:397::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:37:16 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::5f) by SN4PR0501CA0114.outlook.office365.com
 (2603:10b6:803:42::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Tue, 7 Nov 2023 21:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 21:37:16 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 7 Nov 2023 15:37:06 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <gregkh@linuxfoundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alexey.kardashevskiy@amd.com>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [RESEND v5 0/4] Add support for Vendor Defined Error Types in Einj Module
Date: Tue, 7 Nov 2023 15:36:43 -0600
Message-ID: <20231107213647.1405493-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: d13d7f90-b884-459a-abf9-08dbdfd9b681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mI4AAL+t2sb2m+ySj7vjWgVY3YCp/oEu3qzCsPfzj+YeSJfcvGn73skUAUHR4qoGb3GPTLzqQk46/JZYCQMraCbfhUyvEqsKgAiUp/TSANhFX0tymkHaDus4/r8ri1VpJWHT9gHzs97SRd62g8AyAUBRckKyXAXzDe5k7ZRbtxFCKamIT/OY+p9fNo/PdVTjTmookFw5fmzxQenf0IS/cCe8V2K4d5WjZnR8dIENaCXOTGo/S7gmUPaqY8Nx3uTeiuayec0jOb23iPAtEufI7ckJDuLvupG1ONyBqxFDAl9GICjq+JhrOzhS3niSGPtzoOYHlNMoFKiaIQ+xdreP4k4VzU0gwQ9wJpQ7YXTMh6bljratf308FIr/C7PgLjQsr8cYNS++4KehtSyCvxIrpc8SP3CE5dUptKRg1y/eXCln/CShRe81sPuW8ee2q8sheQX4iLIZDMc4ofv/iWcwxMIPcCyA4nwcPmH3FNNrNCiSP7C1SQyVb65Hm84BwL5obrdNOTnanWVnRsGU7cAi6e5uw+FyhTsgRI7yJ3YzK3JDpATspwlRe2Ao5weN2V9j7rUdW7csL8QoMUFpjhz/l8u5g62bwabXOw82jLyxLTMjCD6yhsYnUxvUiqYQHyrwd9SUyl3gY09Mr0nTJAzFjx9ZqZvrPeZzwjarfsp7xs5a/5oPlswhinNjWV8D7/ZMGFGmf7RaJhSrvnmDm1tSLxghirDSD17vHYjgQsaDyT8TdSeIkLSm1/sWOuPb8vldM6ghflq+gw+51D1t+p5kTf8JSRrWiHcRXCkqoxa+RFlaCXFtxsBxOysX1wX/10/J
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230273577357003)(230922051799003)(230173577357003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(36840700001)(40470700004)(46966006)(82740400003)(1076003)(2616005)(336012)(40460700003)(70206006)(70586007)(83380400001)(16526019)(26005)(6666004)(478600001)(7696005)(426003)(47076005)(2906002)(6916009)(8936002)(8676002)(316002)(40480700001)(36756003)(41300700001)(4326008)(36860700001)(5660300002)(86362001)(81166007)(44832011)(54906003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:37:16.5437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13d7f90-b884-459a-abf9-08dbdfd9b681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

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


