Return-Path: <linux-fsdevel+bounces-10686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADE684D5FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C791F23A5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1717E1C6A8;
	Wed,  7 Feb 2024 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSBsNC1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA51CFA8
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345987; cv=fail; b=HutLJnAq/CUeKs1c9Lzs91EIcgwEtUctWdqjXMYoKTBj8bifbE8UijyidjgMCfitPtVi4MP2yjAE8OoPWMWGvKCXFTpniRYEOHo5fIbo7o1vy+paaotuNFhNgTsrTBiHNbH+TaMpooorYYOHFHUSiqgPirfAuVglWI/claONHPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345987; c=relaxed/simple;
	bh=3f70PU0c34mEdqdecYkGCKKz5IEdiHmA3b5psOAaOK0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BCGPgGZlgt2pdmy+RLEaCWIiuqjOVpHZFPXa4RiXSYtJSoTYOGOTaPYZEc2ZOQeMnJOMQGQI0D+76WbvsxZwDy6SLGDotuUtGz0iNzePb0aTWAz59e29YqIHHluGjr2CkCFRMA7g4TJgboq3N3MHOPTNUNOgiGzhGTvAmM0g+8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JSBsNC1u; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJXg4d3dFmfNFSug5+XlmPsz9aAuTJYfp172Sir1DHBJzqQB2mYNEVg3Jf7k5z2orbbFJhsQUWZu2yx/+vPGlntAm7MOvl4SJZW6dP38BN5NdXb0qJDduAmYyYGrdPChyKoTa5me9Hq3C/77Dke7zZawzRdJhWWUAJellRXC20pLVEEc79KPauAg9lf1jQ6oSxN3LNvYmbCEAVyMxOxnYXGKVc5U0KrPMM9OnUGVUsGLiJFVciZyi7eVkNh7ICEQVKCkaZMStOlHzA5mZ9CpE6KEMjiuPnjb/bKjLpTFZVXuMxBsz8Eb6TIOqEhtnfBJmIQz17X1OsDDRAvJGmkxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujWF7Akw3WlxW0mad1Fs6S+i6qkqOU10FLSmXsUFc2c=;
 b=MHn+uRM2IdFMMmBtFr+ivVlE4kukahr8rPseaIoBWbiDF8C1G4ZuhWgD2iP5eZb3CB/+0H8sqpDn17WMYcUjDN9nVD0hais8oN/WB7WBlzxs9lZIW3WWxi46IOu3aJL7zyFfWnEKCZ8dCKAyUnnpcLT4/aftL7Lyqt1yvJ7WgwuS8/ADiS4W5Ru5v/nIg9bsAnJxni8zv36xZlRQwed/xf4RNLYjU0P0UKWhMET6H7lqg1zdQeUePMYHo4zCGJkYgCDhSMdlVeohr/SAHAwb0skYLsxANl0+c9CqbLryH5F5YhltNUwF4B4JdyIkezP5A5S/uQqMUWSIouiMjucSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujWF7Akw3WlxW0mad1Fs6S+i6qkqOU10FLSmXsUFc2c=;
 b=JSBsNC1uS3SJDLvS5nXFs0tczOEhk22yJM5HZKlM0fP76W6g/+akKRA2GAJ9jj7gz0XafeP9a/LpQ4Hrv82sAidC+FKdB8WgAAa7LDJGjkRCbTZGk6O0780K32+dKQEoS21LRZyhn5p3GEWPBIvzmnlEU1IqU1Eo4ZbEEaH0o+OH6G6sdYiWn+4WI3n7EBYKi62lgmm8mXE0Crx1OylwR9OZoQSgvuF1w+6fShEr/GHPodiwGiOzCO6f2t8Sml/zFyDze6S5UG0z+Plve7nmtCgagtDMQW4xKlixdOOvyBjm7qYVocz2pZSL2GARZkkvmI6S//K10J6qtdH1Vy1k/w==
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 22:46:23 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::72) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 22:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.0 via Frontend Transport; Wed, 7 Feb 2024 22:46:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 14:46:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 7 Feb 2024 14:46:09 -0800
Received: from ttabi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 7 Feb 2024 14:46:08 -0800
From: Timur Tabi <ttabi@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Michael Ellerman <michael@ellerman.id.au>,
	<david@fromorbit.com>, <djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] [v2] debufgs: debugfs_create_blob can set the file size
Date: Wed, 7 Feb 2024 16:46:07 -0600
Message-ID: <20240207224607.3451276-1-ttabi@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 616318e3-6b52-4448-59f7-08dc282e9bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QsB9BF1WDwTWQt6kNwNzQHU4MPQJtlr8mNx9J4Dg32J5dGhgj00ojoXeX3HwiIQojwdnehooqc//O5PdoRZZsexCbchRAJNE3rtC+jdjPjFLmD8inwQUcWpohveJbRkuY1W84zXtvsuqT8sJvv0UYD+RYYZjjLPXhD7KY+ekYwL5uAFFw3y8XJ9pXbTxaiIAH7iRq6UAu9AWm3WG7du3V8sz7YfYEnEXliM8rbMAlhkCBbHwpImLuQGxNTT/9ivpTaOH4gwydnkqQqzXZ/ZcE88nYG1iKH6jQcQuqxlxOQh1j3N/xVk7XLb4M3+/xNtAdZFkJyEYH9NyqeAIgJiMwbmJluq6ySNpFrKD9vyJqIpJ7I6YbkQiCaV5dggRR+k//AZO0FiilDMTzVRaOq8QWEcYfZvb7G17Imqjl2/87vGS4GuGB7CNv9ZGE7FRbIhW4AX2fP7nXTvf/V/Sp6JquHg+4JzhwcBsIDjvNjLo48E2BJUwIEmRKQUhmz43GyGSc3B6sPulHl2eL0cBqZrmr7NY+AoLzZZMNf0wba0UDETpu02kD3RCEJxLs6uPhOoN/tif/fe3EvikZmAG1gHNO2u2ghBwdZBcqgrSHtiMyds=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(86362001)(316002)(478600001)(36756003)(2616005)(426003)(1076003)(26005)(2906002)(7636003)(356005)(82740400003)(83380400001)(5660300002)(110136005)(8676002)(336012)(70206006)(7696005)(8936002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:46:22.8193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 616318e3-6b52-4448-59f7-08dc282e9bfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763

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
index c6f4a9a98b85..848deff11b7e 100644
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
+		i_size_write(d_inode(dentry), blob->size);
+
+	return dentry;
+
 }
 EXPORT_SYMBOL_GPL(debugfs_create_blob);
 
-- 
2.34.1


