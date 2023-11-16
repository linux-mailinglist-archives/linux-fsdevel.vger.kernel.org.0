Return-Path: <linux-fsdevel+bounces-3001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABECD7EE980
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 23:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADE51C20A82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D3012E6A;
	Thu, 16 Nov 2023 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jc/Ddzra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1855D50;
	Thu, 16 Nov 2023 14:48:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojbzmea4aEXxI/HsiJGFCqbRHa1Zemme9tClKHienE30F+gjLg+bKsMUNf8E9GIPh40RvXofjvK8NhEC2e09R62GQ5bFKReFpK+ARNepD0Xu++zLijQns7/oRPWfcqOUl/k+Yy/vg5XKh5NWmsQTtEWEroQGZixp+vig8ZjVBIupZ/sxOek7qQ4LiXcTtD8bttmcyWorpBXMP/rWF2oZrOKZ2s2UOWckD/uGI5IutJuOfwYnriRpEw0R0YpsQNkA8Q1frE7etY6Nw6a4IKaDv30EMzkqS4DfT+tg+A6ONLreI+PHgOlVwprq9ycMTLmFgOmu+RlCOO0wen00OAwhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOX5RPISYjppAYQvIxxGqk3Qer6gDi88WVzjLe0j7KA=;
 b=BpR6v6l8B0eWDWQJTywgt+OR6TyQiXCgIqH5v1152dNWhu73syC+fsGzBFmkJOLp8OCg+iQLef+ZZPl+ek/iVdrSfgSnBwGqfoIPwmH8Uyn6ScQcd5vThFL0d01HuVxYENW/jHJ5ZpjTomAez/rNL3P7ZG5vxzIWxKlsGGvIJge6IHB4VsV72mJpRmeHKOjF0OrtKkUBPziz0bHLi3sW9K3NPR8JpOcDJwzAHoPgU1hph5d91MJj1xTO4ksmWgxJsONVeHhJxiRznMIwa54JIzDUI09SFv8axmrKJc1OEHFoxE3ZpFM+4E9LBTHyCvHoajafxli+H51n6TLF5VP5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOX5RPISYjppAYQvIxxGqk3Qer6gDi88WVzjLe0j7KA=;
 b=Jc/Ddzra48pO8IFeogSvm7DU2huxz9uOqJQlq2H4SyN6o2Vgb5JzSlfYf6NhQW+/37O9b7wKf2xQcPlXcnBhCrUiSBZ0gFWOf4+Hn61xi35YIT6Onf2lnR3cZsdrrFJOn1RyxklKkJr2ztYBDQtziY6ujzFeHudX/LPvZRQ05BY=
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Thu, 16 Nov
 2023 22:48:16 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::44) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 22:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 22:48:16 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 16 Nov 2023 16:48:15 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <rafael@kernel.org>, <gregkh@linuxfoundation.org>, <lenb@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<linux-kernel@vger.kernel.org>, <alexey.kardashevskiy@amd.com>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v6 3/4] platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
Date: Thu, 16 Nov 2023 16:47:24 -0600
Message-ID: <20231116224725.3695952-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116224725.3695952-1-avadhut.naik@amd.com>
References: <20231116224725.3695952-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbae639-fb9c-4fca-6b72-08dbe6f61f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w1nfrFkF992WjjJ2ZUOVkjd5AnFH1AG5rlQbg15A+zQt4DnMGjvuQQDCK/yReXR81pEXdyog6+F+DuPBkJ8sTa5lq2JTB9h40PFjlLSUGjnwfTbhh+tx5CMixJsFNNByYHMM9YMGudRhJBG9TfKV2YihLcWJYLhBaxyegabWpViULhSqcseZn2v4j5T4Z3eQQWTDBibuT2ZwgVgWQNElaDvqvAUStBD0ymqcCYF++lki9xHYHWxzC3MCnt8BF5IqLWc1Y4geZ/vZiv1SHAJhu0kPcEKbDXjQa8lEISRIh5kpcSRyCrbKBpyzHOrRn/BZXiRCDoyy3Gmq+iX2uDAdy2XOLvkvlQ268OHhRq+z5/cr2Z5qrdCslvqYvZMgMyPdxVAGQiKiv2+vKtbl21fLs8Of/+ibCHZhIsqEfoEPYy7aTJC1rhLh9txDZ0ILlVsuxPyPfclnprewKdPcTK3xrZTYoVxc1oe7RayFs5Q7YhfdC//1IVXIw9ke+zSyn7XfZ7+h1j3UsjgJMfS3Y8IBycibB5rFkSy0pDnZmI9rloyu4WCxGCKrpp2xqxFPhAN18ZshFtd7pkqD0lY5AZfLIXlHNYzWS7bttzFEOOM9E0c0vcs+qhxNU9KuUD8qruSP/sVF4ZltedCj0LpMTw5aYOQRqeSza61IRp04HTVd6beFyVtspo90PP9GtHdDFmBGx9oRyL3B+9RaNURaV9NgyzfXiJwXlqyExWNi1PMSG5bc2qDpyjHs3qxf9ob1IKJTrqbAyx+SVEj4454wE60sIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(36756003)(41300700001)(2906002)(356005)(47076005)(81166007)(83380400001)(86362001)(5660300002)(82740400003)(336012)(426003)(26005)(16526019)(40480700001)(2616005)(1076003)(316002)(44832011)(54906003)(7696005)(70586007)(6666004)(36860700001)(70206006)(110136005)(4326008)(40460700003)(8936002)(8676002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:48:16.3968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbae639-fb9c-4fca-6b72-08dbe6f61f4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490

From: Avadhut Naik <Avadhut.Naik@amd.com>

The debugfs_create_blob() function has been used to create read-only binary
blobs in debugfs. The function filters out permissions, other than S_IRUSR,
S_IRGRP and S_IROTH, provided while creating the blobs.

The very behavior though is being changed through previous patch in the
series (fs: debugfs: Add write functionality to debugfs blobs) which makes
the binary blobs writable by owners. Thus, all permissions provided while
creating the blobs, except S_IRUSR,S_IWUSR, S_IRGRP, S_IROTH, will be
filtered by debugfs_create_blob().

As such, rectify the permissions of panicinfo file since the S_IFREG flag
was anyways being filtered out by debugfs_create_blob(). Moreover, the
very flag will always be set be set for the panicinfo file through
__debugfs_create_file().

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
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


