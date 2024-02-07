Return-Path: <linux-fsdevel+bounces-10662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F155684D298
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 21:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CEF28B655
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B567126F15;
	Wed,  7 Feb 2024 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMtoNCQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622C126F14
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336437; cv=fail; b=PaVXbVxvB8YVXI++Xzjjt6Do8zSvaRRjgZxAkDMvIKGsK+HPdQs8QwHzQ59G2WfzVY3GV5zFdiUcjc3nYAGUvTc5K7aCMYl+4CwhzZqlyePDmm380lIu/+CEgGL3rTqcom9v4dPvr+DvaGCBlwkz61O7ytBZ1aosbZcrk6ZSTj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336437; c=relaxed/simple;
	bh=E0nHd160TDh+YEnNBKkdUcfoyaJ106Tsn4Sz31y7RPk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BdTuOXc7LjxIZCgycp1lC0P18p8+wXAJYE3c+sMGRMSP9oVRoBlv6VLfXCAFTtbzyzQDScvAfzRZwAKtnKcRzouvm0E50hf4wbKGHjxdBl0B2yCEF3vr+U6cxgOfr1xbqjuCxFqk0LpT9anY6nInPiFcyE6nakuzt5Rpr0CKX3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GMtoNCQj; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuKUQJrgZ9IA43Ow4CnK57Zi0qWqHf7ix2MMIgL1pW+kMuzTYtijJvehuPWHdrGKSWZBVfsokjyTjHMs7Eqbk5d4z04vGUk7MDo7SSqA7yi6PBss+6VQiDmCvd1Q1qRTWqP27uar/TPDJFSTqeNgD+l5Wwv8tJgUDSGfuavJwAer9JycGcP4YxrcRFKUOdelkUPIGA2zq985Ml77lYD49Xytno2we/peg8E7E/9YGWoVZs+6WruXDeqbbE8+yrE1eDfb9FRNXfqcglbSvpGP0VYzSz3hJwOKvFHe4e1OHzyXXqp+EspAabUdyOhUFKHFthr/UON1PD0857sCB11AeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3R+L+KTNkVXtfz8wLSkq7GPNT5PyQFGn/oxL/MFd2M=;
 b=Ar0TV2dF2gdo4VlsvpgJ0fRHMg9BBZeR7POWC6vxCBFG50xeWSvESRpABNhgRlA77o7wEpxu+r3HjwlUJht0xh7jQW8qKqMZjA6yTDCTRuzZNZrMspjlS/6C9Pu9Bf45YnlN92tuwaxrDR7TV6MJfE/HH5ZQvOm5aEiGdZ6563sCt55L1CIFHI8xSFTUBQfzZyVl6PehOMduEo5zUOS11GxMIxcUiVkLmxZ0e1tKx1JnRRxQF4bCjY0fYFNfOxlKXhaMrjhdVTKXy1Occy3Yu3k1T5P0nf2MuqJ03/XQTDhvZS3ayHfCjQcgAqIAgOBQfdiJZOmC4UfSOdjoSoI8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3R+L+KTNkVXtfz8wLSkq7GPNT5PyQFGn/oxL/MFd2M=;
 b=GMtoNCQjVIFbtM3NaFTrxqg5/jWqgeAIeI17apsXTKWlUTe5OrZBnAitB7dP51LDut6Eh2lHhRLZtJP0VSSCBbVHqt6cur+aD5N3G0rlGOQvslZ+GP6qm5quVeG2cVygWybrrT+CqFKybKOhDLU26zSMkGqJO4u2U82hFmPMPGlG66kO+gdTuLlE6nNW5ALapnxOL4q1jWA3iowgHMnjijYQ7qlRJE4SMAeB7sk3pY5pWfMD6Ol2iihRsIvYRNDO/lZIPFu+KNYyaNUtw0S7bgRSAPl2z8RP/UIGeuZelmyGeW0DfuYtGO7xZlFtMGB72sYAHM0AeTzUPmBkJtmG1g==
Received: from DM6PR13CA0007.namprd13.prod.outlook.com (2603:10b6:5:bc::20) by
 DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.16; Wed, 7 Feb 2024 20:07:13 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::9) by DM6PR13CA0007.outlook.office365.com
 (2603:10b6:5:bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.8 via Frontend
 Transport; Wed, 7 Feb 2024 20:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:07:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 12:06:59 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 12:06:59 -0800
Received: from ttabi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Wed, 7 Feb
 2024 12:06:58 -0800
From: Timur Tabi <ttabi@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, <linux-fsdevel@vger.kernel.org>, Michael Ellerman
	<michael@ellerman.id.au>
Subject: [PATCH] debufgs: debugfs_create_blob can set the file size
Date: Wed, 7 Feb 2024 14:06:19 -0600
Message-ID: <20240207200619.3354549-1-ttabi@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3a08d2-88d8-4199-234b-08dc28185fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fgwzlB63rR28mCfxx9T7u3JUcsp7kmZlUiYEysJ9bVa7Ef0YbW8GhO+g9g6MHnMXkCF8ilaA4tfL7dCqshP9qtWc8qFjmoi484t4BnXpCzf0ej+pW632Vb56rSHrOjZoSf8eopbXZe21UxlSlcwP404FxISASpG3zO4rCdrGMltj3R4YCrGxJXpL0C9SHaF5fC1no+VCu8Ap47YQml+m4lH3hDLg65UV+rQbrn3OZ5yhepPy7hszTrRuQEbxyc2fXYucXBpGJdvvQseU2w/SxqeF4LdlefkVGz3JtrHHyxjL+xEOSgWzaEt6Uc7vUJrpId+MXue28mdAw6bsHkR0ji9xCIZIOuoJTjEQi1FPSw0ssJflU9nn744yqKzsQsI8YSNtmEvvnvWTpkEJww982UwYl2tkC7mSfmRJ3m9nTV0+/xUYyLCVcMpjaAhHKvBf37Cv6aviWWuUugrCjGUUH1vgtL3ZLE80n4T5LMInXYskNEHwy/qopJrFr07IkDY7m4s0dpZSJsNgV2XnQk6yQYC8Q8nMrLsTPrZBFiXtOx4FxzqClV2yE8cIxjfuxB6wIKqGcIv3N3MU6dC2WBUbK7r1dj/VmrwpqUsGahYg+89dUmCbvdkV1ZPMRzdJi2MMeqQFYLlQZYj81f+J2qpQ6LvKybbNvpTAstQr17o7b0JW/FGGRIC2kOS2lCzYesh/usp6KcR1EIao++zwC+IeuSg+hLmRFvKmj2sjp7XRuEMw6ri+uN9gwogIGu+bE/jH
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(7636003)(1076003)(26005)(426003)(47076005)(82740400003)(356005)(83380400001)(8676002)(70586007)(110136005)(8936002)(336012)(36860700001)(5660300002)(316002)(7696005)(70206006)(2616005)(6666004)(478600001)(86362001)(36756003)(41300700001)(40480700001)(2906002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:07:13.0491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3a08d2-88d8-4199-234b-08dc28185fd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413

debugfs_create_blob() is given the size of the blob, so use it to
also set the size of the dentry.  For example, efi=debug previously
showed

-r-------- 1 root root 0 Feb  7 13:30 boot_services_code0
-r-------- 1 root root 0 Feb  7 13:30 boot_services_code1
-r-------- 1 root root 0 Feb  7 13:30 boot_services_data0
-r-------- 1 root root 0 Feb  7 13:30 boot_services_data1
-r-------- 1 root root 0 Feb  7 13:30 boot_services_data2
-r-------- 1 root root 0 Feb  7 13:30 boot_services_data3
-r-------- 1 root root 0 Feb  7 13:30 boot_services_data4

but with this patch it shows

-r-------- 1 root root  12783616 Feb  7 13:26 boot_services_code0
-r-------- 1 root root    262144 Feb  7 13:26 boot_services_code1
-r-------- 1 root root  41705472 Feb  7 13:26 boot_services_data0
-r-------- 1 root root  23187456 Feb  7 13:26 boot_services_data1
-r-------- 1 root root 110645248 Feb  7 13:26 boot_services_data2
-r-------- 1 root root   1048576 Feb  7 13:26 boot_services_data3
-r-------- 1 root root      4096 Feb  7 13:26 boot_services_data4

Signed-off-by: Timur Tabi <ttabi@nvidia.com>
---
 fs/debugfs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index c6f4a9a98b85..d97800603a8f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1152,7 +1152,14 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				   struct dentry *parent,
 				   struct debugfs_blob_wrapper *blob)
 {
-	return debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
+	struct dentry *dentry;
+
+	dentry = debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
+	if (!IS_ERR(dentry))
+		d_inode(dentry)->i_size = blob->size;
+
+	return dentry;
+
 }
 EXPORT_SYMBOL_GPL(debugfs_create_blob);
 
-- 
2.34.1


