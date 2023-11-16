Return-Path: <linux-fsdevel+bounces-2998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91E7EE97A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 23:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C08028109B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8D12E49;
	Thu, 16 Nov 2023 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mzx3Exc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4C8130;
	Thu, 16 Nov 2023 14:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQF1N6iMUVJrZibZju5+wtmifwsxtsS7+0joK4o+hQlz7Ov0hxRQ8kNzJ2GSlhUdQqQ/2ZjS5pwKT+XG7xnlxRzu0WJG5LF0zgE1jltgDAwQCEhL7Ax1HYhMPLUSldybKacbHHoQ76Tl+Ejl9MhAB63INUhzrzuYxnePR+gK+s5zTTU1SUE37q8i6FlL9harVZnI4iHneeUgSQczChFhgo9nUCoCsPpGYkoOq/pooibinDvUiSN8K2zgWnXjcKnN7pn2H8A7Mu4tgcF0D9G+DfZ8OS4BYj7ZzeTY86hvHauSSi0AnxbEhW1CtTxQbjTKl85IpGQ40B0jeEk3xGPwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hEhOdhCPIRt7wo/PNs5gKMU8+R95dCjgQm+4eo0Pvk=;
 b=G/0RqGk4yKvx2zUyenu6vMv2dnqKACYd9gNm5kRN3MMs0DHVSodljJ/CJ1ux3tAtcKiDJQ+/QdIi8ZXPJSSmEnQozANq86l4Qpv6zu+7SW9SLHQ9SzgGCgw5IH3nr4TjGD5PuhN0OfmxD4PICmgi3+RXJe+AC/R/w24Fn0JWmh4IeZEVYOtJLAQFyD3jXmYxxsfOY6jLUVUDFVKu7GNu6TxCuWOyHFYJVtEXpO0xlRKs/X9+rHt/yyeChJEQpHXOmy7TNmzH+lm3/kNJxNERLke+1ocrPN/HADTMnbbGTjZwvXGQQFhL6fg3ahOIutupnXi98Z55x0OtF+y/ofWg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hEhOdhCPIRt7wo/PNs5gKMU8+R95dCjgQm+4eo0Pvk=;
 b=mzx3Exc2RbB2ECpa+LdZV81bi9q65bV22BCOBoWFA6xW+d5XxeJnskEfgfH7TAKPc89SveTQZa6RP8c1Bc3a3+AmTXp9EFOQVNEcZHx7cJBUFR4kdHjKWUtrtasi8nEIauBiq/jyMg5P3jx/BEIrLfKMiXrr9sr6PgaD1hA02tk=
Received: from SN6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:805:66::44)
 by CH0PR12MB5155.namprd12.prod.outlook.com (2603:10b6:610:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 22:47:37 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::57) by SN6PR08CA0031.outlook.office365.com
 (2603:10b6:805:66::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 22:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Thu, 16 Nov 2023 22:47:37 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 16 Nov 2023 16:47:36 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <rafael@kernel.org>, <gregkh@linuxfoundation.org>, <lenb@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<linux-kernel@vger.kernel.org>, <alexey.kardashevskiy@amd.com>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v6 0/4] Add support for Vendor Defined Error Types in Einj Module
Date: Thu, 16 Nov 2023 16:47:21 -0600
Message-ID: <20231116224725.3695952-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH0PR12MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b173c2-f0f4-46d4-a239-08dbe6f6080a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KlWgkhpwg5DwI8zZ7NdaZUvqITCGzKXyjj9iQNc4w1L6sD07CXA7E412S7yYEwhUuKhlHjIXVVF4YHMoVtskNfgm2RXAzW1ZNAVk+q7pQAEMdMKFFdGGYM75pxjLSm9AEgrKhvsX3CPjswsH6X7+MlkZXbrVK/+IvfGUeLu4UGIXxir/ynhdjHmVsO9ibBE6VdDjs7+zevT3qrAQjf4VL7LJ6uWvDhN7jXAS0JVYrUgggokxditU6hMTHvKMUnmkTKwEYQAQsckLdZb6YvNKhikNqwewLiv6ycux+pdqZvuBreNAspuArSYuD+ZItHykjtJsWpzSz7F3HLCCgIP96CdbYaUfP1KIyQ6hWVnu/fImQQs6yRFch3XVEvRj/tStZXn0W1rVslI7zFl2sqk+Wb63vqZA4nCiPP9NmmCQRW7hSGPQ23AdHwNhCquWgsdlZLk63pP9E24BTABRVAAgQlwmN3kFOte02GBDkJJcQBWCpveq3BiXo7pcVhJFBdt7MU3MyoECYPCqTFcdCuP5h4jdYZOUivGEU9dFBZcKvpxWmo8i++8hq1ergEIJZd44m1kV7+b4CZRsvsiaAOY/5QWTNrHoemxTz17m0dEbqvhxhxoi0eQqg5jSUc4l82mlu6t9pWjXQNAVzc83V1xyPIGklNFTYTRsnmSvDsXRLfmtY/1TNBA5uy4KXNM5aW0uTSR3HUw8lpGGNmDWqrFNr2r7JzHoyGSDsrI9suc1/5Nva9hWzzO3SLhjq2UQ57f+lpHjI365TOrwMDj2UEQyCgppVmqgF+3yDnhiuzMjyuJUQ3TjHQOp0L5BO4g4h4Kk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(356005)(83380400001)(81166007)(426003)(336012)(1076003)(16526019)(26005)(2616005)(6666004)(7696005)(86362001)(44832011)(110136005)(70586007)(4326008)(70206006)(478600001)(316002)(82740400003)(8676002)(8936002)(54906003)(2906002)(5660300002)(40480700001)(41300700001)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:47:37.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b173c2-f0f4-46d4-a239-08dbe6f6080a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5155

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

Changes in v6:
 - Minor formatting undertaken in the first and fourth patch per v5
   feedback by Boris.
 - Added check in the second patch to ensure that only owners can write
   into the binary blob files. Mentioned the same in commit description.
 - Modified commit description of the third patch per recommendations
   provided by Tony.
 - Add Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de> for first and
   fourth patch.
 - Add Reviewed-by: Tony Luck <tony.luck@intel.com> for second, third and
   fourth patch.


[NOTE:

 - The second patch already had the below tags for v5:
    Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

   Since the changes to the patch for v6 are very minimal i.e. addition of
   a check to ensure that only owners write into the blobs, have retained
   the tags for v6 as well.

 - Similarly, the third patch already had the below tag for v5:
    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

   Since only the commit description was slightly changed for this patch
   in v6, have retained the tag for v6 too.

   Having said so, if advised, will attempt to reacquire the tags.]


Avadhut Naik (4):
  ACPI: APEI: EINJ: Refactor available_error_type_show()
  fs: debugfs: Add write functionality to debugfs blobs
  platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
  ACPI: APEI: EINJ: Add support for vendor defined error types

 drivers/acpi/apei/einj.c                  | 71 +++++++++++++++--------
 drivers/platform/chrome/cros_ec_debugfs.c |  2 +-
 fs/debugfs/file.c                         | 28 +++++++--
 3 files changed, 72 insertions(+), 29 deletions(-)


base-commit: a1cc6ec03d1e56b795607fce8442222b37d1dd99
-- 
2.34.1


