Return-Path: <linux-fsdevel+bounces-2324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B87E4ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74549B21087
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7A84177C;
	Tue,  7 Nov 2023 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JADJ5aoY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209B2A1D7;
	Tue,  7 Nov 2023 21:37:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5931730;
	Tue,  7 Nov 2023 13:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePVnnpVqaoyQD8XpCkcBhTuLyVmSHDp+NeXxt3Rue4+izDylLxYhooKcFcS2AVi3/CqAiid0sjI3xFTlDHyfuTY0LwSb4XT1ennx/eOgkbSLKYtbCt39uhZQWmM4WXAQ7RI/9pCfggngOps449t2FHgs9Nh9Yoqdri8MhmCzqUkzzCUc+dAMlBiqhVUph92v3fYRMejRcChICzEqdUuZQrNDLVEDgIVv5ZNEp+1g3vaaeWk2yGc4kUETxjTXS+wfjqsiRUUCzUUgOVYklf2Crd2FJTTVkFW+V2HaPjfhgidRikUmSTzKDxSPCarCP901WYkRSvdAMQgR/Sm9fTmxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW9E13aA31yMQD1NqrpPthdXuHaL2Ck8ZMW2yFpJIMo=;
 b=ljURXlfZrmIluZRIL4+dlAJgMXAhFORUJNmn0YTNwFX3wFTQEPdjlmtJnxJlufweLrTtSpW7m1WPoRkhHEdpecgqjQ9xKhIm50yua/X9yQSm4TxtTMWsuB3UXf/pBTq0j4sxBLFicmTIlaiADpVUaGDcqyzCphWiGYmiQKXxWD66qPQyYiJ5vZJth2+OrS8rpHbC67FJojKvCULRyfCcreXJQmFHKb+9M3dsK9/v5VrX2yO2qEeShZAa3ts6OLFZXNg+zPhL87W5RVn8R/o3LRl+vO3jYdXUzrvuPrJGERZAGh9jKbVMyA5evUxb3vTQG+fLLukAJF6VW1b/FHSRYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW9E13aA31yMQD1NqrpPthdXuHaL2Ck8ZMW2yFpJIMo=;
 b=JADJ5aoY2bM8/Drf/e3nY/aI09a5XD5qxiWZv/ijcSP9k5Y/jOKfKs3n+H8VmCtNbqk7kUh6Manza8m0FAGOtfWSwFUdj6oZv018o6etbt31yx/R15Wm3pgEuNTw/pZGjeXw29xKD7qTGJ86AlXz+mVzZUGr/Vwcpl2JynPQdQ4=
Received: from PH8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:510:2d2::19)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Tue, 7 Nov 2023 21:37:44 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::bf) by PH8PR15CA0022.outlook.office365.com
 (2603:10b6:510:2d2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 21:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 21:37:41 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 7 Nov 2023 15:37:40 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <gregkh@linuxfoundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alexey.kardashevskiy@amd.com>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [RESEND v5 3/4] platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
Date: Tue, 7 Nov 2023 15:36:46 -0600
Message-ID: <20231107213647.1405493-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107213647.1405493-1-avadhut.naik@amd.com>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dabdbc8-1e80-4fdc-17c8-08dbdfd9c539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6S3elY9idh0VAZtAj+3x0/suW0zLKKpZHV2WchHKHjqzfwfmSMky3A8267UBnTzSZUgIeIiBKXfcjw+gNvUlH9xaF41vh0U+89tlDJycvvyWIKXmZ16iqQA4GPVSDUYHFbkB4vKeOLRwUhnUstfympacSr3BBBLuQYX6bhVqcTwsDpuOcxo68exs2DY8K3rhmjkPk9jqmKSNn1wXNBVvfUgQB5TSeKJ+yiOTEFGIo9h0UCHKvRK2pml23yM00aaN0hU21r4SqLq+a/+Dx5VDS0yI+BPQ2bZ973awlbuZmFNaIcynlwvyL6NrwB+zpCUpF1rXzLvHerdAzUaFa/JYAzAT8Xx89T+KFlrenxXqBD9+1MEbO6dgvmYZEL0I2Vn2a9ormonesw3IUBS7SoWs2mg8tib2XNqeFggRzhiYlywEX5WPjTgao9u6UK9MYvF2k13zQwv3QtttTY6vkPZaAyvEevSkiTKJRUlF82grZXK/KTvcBJLV7nBkFckYYITckqt2+Oz/2B/XWdlZIuhHbPRX3PvDZiPI5Je9oWsXRzpBr7eZLh4oGB4OFsuFqzC7V1ngz4vMbUGj0iQayHYn2vvPROS8EMaKbbT+yl6FutIs+vFgZX5Fa0W/Z+lKXcrJsFVai937TBkYErVqJqy+0Ih8f5tpSzwguFc+dDw+zXGLBXx+ra08g374kAxGSqTEQK0bj7XuODL1o/obdIgOeS0v+4f6kpPg4TPCqIsz0op/GSUNE+/r7l0zrWRlqzLlPSetXHxzCjPAigRdvNy7TQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(86362001)(1076003)(44832011)(2616005)(40460700003)(336012)(426003)(70206006)(70586007)(82740400003)(26005)(36756003)(478600001)(16526019)(7696005)(6916009)(54906003)(316002)(8936002)(5660300002)(4326008)(40480700001)(2906002)(36860700001)(47076005)(41300700001)(8676002)(81166007)(356005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:37:41.2182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dabdbc8-1e80-4fdc-17c8-08dbdfd9c539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232

From: Avadhut Naik <Avadhut.Naik@amd.com>

The debugfs_create_blob() function has been used to create read-only binary
blobs in debugfs. The function filters out permissions, other than S_IRUSR,
S_IRGRP and S_IROTH, provided while creating the blobs.

The very behavior though is being changed through previous patch in the
series (fs: debugfs: Add write functionality to debugfs blobs) which makes
the binary blobs writable.

As such, rectify the permissions of panicinfo file to ensure it remains
read-only.

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 091fdc154d79..6bf6f0e7b597 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -454,7 +454,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	debug_info->panicinfo_blob.data = data;
 	debug_info->panicinfo_blob.size = ret;
 
-	debugfs_create_blob("panicinfo", S_IFREG | 0444, debug_info->dir,
+	debugfs_create_blob("panicinfo", 0444, debug_info->dir,
 			    &debug_info->panicinfo_blob);
 
 	return 0;
-- 
2.34.1


