Return-Path: <linux-fsdevel+bounces-555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD47CCB1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39201C20CAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D562C450D2;
	Tue, 17 Oct 2023 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EGyq3s+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07034369E;
	Tue, 17 Oct 2023 18:49:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD9F100;
	Tue, 17 Oct 2023 11:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi7eCSi9hNMSJWsLJ0zysEzN+NVE4k9sVXXbGnwcC/26mY2MpXVjIQZmrs0yHTjKEEkNYOWwlcEAow6kwlCV71INT66v7ix8rwN1/wVU/FB7y9J9iQaJckQvk1q2+PBuOTMMF8GP+l3omAZsxxdSLoG+n9Tvy+9pPaPTG709WRpovSkyas9DIb6pShgNWw2bZCfKSjtjGaVof5DA36tZUDSSEm2dDsHMxJFqmQBBtAKzMbEdMfbIrCMJ2gG4tmBT9qMRim64JeomN2OhZIeL6TcjNy85l/S5+nBFGhINcuMOy1ucJZn9GUR3/JArocBMnrAUoCAEW0NDik+I9nes6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnj7fbXuK9tAUS4oWbDKZFPJ0elh6qu7EaXXL3Yw6Gc=;
 b=j9mWjrZpKdQ/CZQb44OEANyTCnKtWHjyJ7RtpB0xiYd3JW7LiSsTvH8ULC51xHDBLjN3prMcoAbWRpNe2jZ84G/eMe/KSqzznCGYzTSHsjnLi3Dgx6S8yv5n7T9Ty/xmw6WrNZ73G2ZFXKGqmbAgi5+lEImIDjtq3yepsjIYlJVaf3veUXetRYIf7H8fYnUSKbmXow1o+R3/5RiOFFMfSnRubJODhKN+BqAh5JCxiYoiMoWPB8yhdVe0z38yg/zH1fhQwybKKNhKFcadDH+8ThTk8BXNaijmIU8t9ivi8YChvhS/amqfWLZh2yb4DY7zuODAeyWdFsmd9xxAhwZFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnj7fbXuK9tAUS4oWbDKZFPJ0elh6qu7EaXXL3Yw6Gc=;
 b=EGyq3s+Fwz2tgTr4crVbHC2+phI6VOGkMLEW1ZuGgveiDNgCwncnaZ9xHl9kBDC/llHktu/hNKPBg80miHn+zhekP7FISeMCU2h8i3FSZudEOi7jbTepEN9tcWtmhltbL7wJIHrFXlz2hwJtAj2ZTEKJaP34OpO5RCHialZxmTM=
Received: from MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) by
 MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 18:49:30 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::b0) by MN2PR01CA0051.outlook.office365.com
 (2603:10b6:208:23f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 18:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 18:49:30 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 17 Oct 2023 13:49:28 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
CC: <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
	<gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v5 3/4] platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
Date: Tue, 17 Oct 2023 13:48:43 -0500
Message-ID: <20231017184844.2350750-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017184844.2350750-1-avadhut.naik@amd.com>
References: <20231017184844.2350750-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fca939-d066-413c-e87b-08dbcf41cc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z9uYsLpUvWmZQZW9LyIbHyaYAqHkRLRdmASt3KYvu1uKmfOVwZ6KMRaJg4rfz8TiM5YbTHueHmf9BIgDG45OJNp1nuTSrw3ASwVi088W+Hw5LmzspSQF8WmKwlUlTnn6wT5ny9gTmcszfCu7ZdipsD3G2TU53pxjJZNhbhbB9skIMnzye6efyc3B5oVJ0La0zU3LPy7gJHx0yHkRCh2SWeNK57TWPHvs6n2UkWNOir9JmoZ+1JsmOHUdqUngpZo+VcMv88SAhR+2WtkNHQTOz7CPSOHnoaUetH+5vm0eyQ9uhOVcitPWA71xX5r6rzxq75tI/63HBN0KivLs3g8NepIRbl6LwLKtIPPg9518/EX9Y+6OPfUkOMY2SRCAYpGypk0Ib7IT0mw66MsViX8ZkQECYTZmehBAGUKO8Bi7UCf9YXAcSHkgen8XdtHYTgdb9ZmHAjEGhDdrv4mSVTeeunwslsb56b8iHGSyxE3XeORqB9F1XdwEbJfx1AE7d+bfapjSk2Tvl1JKn3CHAiJVFkMlKvltAAWxQRWKQUU/cZ4+k5uneZGgLGkDCRSeysXWXf0z2VGSE4zVJS0XzYAXM36ds1oaAe3jP2GcCRbwtC+FKt3TXRYueQ2aySPp8KJJw/3jLIeUPuFSsP3/crxm38fIKWDCqPApoR2G91qzS6spftSnsJVIgpBMTorYB+zWZ943mDW4AW7HNBoARzBWK5C1RV9ZtitMjPUouwrlpFDAnxPJWxmawN6Ftwy+F8hRaFRJ+GzGbfnOuf7gDkMXU53Swj1ne8y9ytqpYAibTh4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(426003)(1076003)(54906003)(316002)(478600001)(41300700001)(336012)(110136005)(81166007)(16526019)(26005)(7696005)(6666004)(36756003)(70586007)(70206006)(5660300002)(8936002)(44832011)(2906002)(86362001)(4326008)(8676002)(356005)(82740400003)(36860700001)(47076005)(83380400001)(2616005)(40480700001)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:49:30.5023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fca939-d066-413c-e87b-08dbcf41cc00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index c876120e0ebc..4428dcbd2a68 100644
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


