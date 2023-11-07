Return-Path: <linux-fsdevel+bounces-2323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC697E4ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97775B20EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A9C4177C;
	Tue,  7 Nov 2023 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U1gW+cxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A72A1D7;
	Tue,  7 Nov 2023 21:37:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62AC1700;
	Tue,  7 Nov 2023 13:37:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgWA5iLuJh3x9I1Jpn8/D40X/wU/QSFozcJKeOJM/SkYBVTnA56gWBudzheI5bnUcU3ITf4pNVuqPilScWf5fGDZ56L44PQpwctIXQuy8SPutmNiCLQ1/x2uD8d0VXvq+rzFvr0J96c/I5O1rjbcqY/aL+lCI+R0jJcqKRGFQIsqehf8W7kE7uy9ZubnXJVd4GgfvlfX88yYgL0jisN4mtju5QrC+QsQtw3J9DXKLcf10FUT5CV8Bub+iCous1ahcdCiGVx6hIWmYBIpVsCm0cZjYEQAjnfGFiB7fJsu0zV7ILgcqRFHoxy8sCnF5O1zI0GcBhHU9Qbyga3T5ko9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzTktEFdcwv/5VgXiTNBHKocFlFlxVO5ZUECMKyR/GA=;
 b=lrUI/wjV0t/HvVnb0FYm5CK3IpX7GVy+iWXqPc7JncKibXTlMMJKtQZImVUT8AeGMNl1QLKoyIuDbVWZVU+f8kQVNLYviptwPQ996pn341LR0VEsSzjRojJt7+gzyqFS9aO9HjZUmsrtiiureshkS8i/HwHkqD5z7TDWBSLcx9fvJdCbA8ZP8TQumH3BeHVijfvAfVsEnOFSDsDu/hWXVIl9HJJ+59fUoL1AdxVsBMc+Eh8KWiFAEdApb4rqZhlHFj0oUNw3brWb2L8JjES07DgnkBazr/3/oFXV7q1t3pD/Au8LXEYcGUX33IR9EKqqplvkX8LkBJo5Bx17aCqe7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzTktEFdcwv/5VgXiTNBHKocFlFlxVO5ZUECMKyR/GA=;
 b=U1gW+cxUUQnEzV8AkV6Wef9TJkwK0SvhwBz8PUcR+IHeSA5rsIzbF+IlgpXDX2WGOxleAsNdEBbC6bWkJ7aXkJadeUu3lah8NwMvPJHbJMIXOcyHAqFNPUzHqN2WJS1iptaPZQhnEZOK6hP+MtZJJ2+m6c4nEFRV0XwC/kYo4xE=
Received: from SN4PR0501CA0034.namprd05.prod.outlook.com
 (2603:10b6:803:40::47) by DS7PR12MB5720.namprd12.prod.outlook.com
 (2603:10b6:8:73::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:37:30 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::c2) by SN4PR0501CA0034.outlook.office365.com
 (2603:10b6:803:40::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17 via Frontend
 Transport; Tue, 7 Nov 2023 21:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 21:37:30 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 7 Nov 2023 15:37:28 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <gregkh@linuxfoundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alexey.kardashevskiy@amd.com>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [RESEND v5 2/4] fs: debugfs: Add write functionality to debugfs blobs
Date: Tue, 7 Nov 2023 15:36:45 -0600
Message-ID: <20231107213647.1405493-3-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 46245511-c702-4e41-65bd-08dbdfd9be9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e2VgscXowLA+BKuOHz/2Swm3dd5PmMC8z9N4hRoyP3oHniaghV7zh59aAEzHFLht/UMxYLkiYuQLbYKxl07w7LhgCzzIfJ+GLHVEGkUK7updSR2/uCQLPO3+wP8fQHXUerCLpkHjQrBqu24MjSvr+8eFXStI+EdHia9dHwAeW66Rbvgh4r7mZQkXf5jBI8pxSNa7seMO5WlnDNKhQewNPZr/V1NV61t1Lx/QtM+B8iSZNgMvYwi/lGvcs4O9/5fmEK4iRN8lHa4EF5XZ/v6A88MYASLoj/4UZsbblmm0VZon6Q9h7uhZyrXkOZf30uyXcEWzJ0DvFD0z+3ql4SEi8Y3kQkbJVstUvBIzph+V2NzlFpZfyI2cHzTYHtajlp6sajy4vdjwLZgNaiueJ+jcQEzDEcPb0n0Ru37AFcHHCUM8VqDetC4xTbg9B+sXJdPhs3zZ9lfjDkt57/JxjKubls2w55Lyw6FNYzNy40DAv6Sx2/ASAEzOPNH+EgzZ3UoStMIVw1KES/4pQjnsCqB6YONR9jRWfv+rAdsQSHPCg5MrrEfNERXk9k6DOmouAoaQMHNRi8HracAPBdARonKlPVrWdkZ2oZt3bDQq6St1LWtTJoifB0orBxSPZGpIGMkSBKyOZSpzdAw8IASugdklHUYnbtRhhnwOZmLibvGlbIfRPtjBKL+UXXm+BqQVW3ZWhmycuYrJBV3ci/OQFkLe5WhRHPNYs0GBWK6h3qByTImrWN8ULvDYcY3j1oxW6RJtTwBTzsCugKl6s19q5Qt8cw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(6666004)(478600001)(70206006)(1076003)(54906003)(7696005)(426003)(336012)(26005)(2616005)(6916009)(41300700001)(8676002)(8936002)(4326008)(316002)(5660300002)(70586007)(44832011)(2906002)(36860700001)(36756003)(82740400003)(86362001)(47076005)(81166007)(83380400001)(356005)(40480700001)(16526019)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:37:30.1275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46245511-c702-4e41-65bd-08dbdfd9be9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720

From: Avadhut Naik <Avadhut.Naik@amd.com>

Currently, debugfs_create_blob() creates read-only debugfs binary blob
files.

In some cases, however, userspace tools need to write variable length
data structures into predetermined memory addresses. An example is when
injecting Vendor-defined error types through the einj module. In such
cases, the functionality to write to these blob files in debugfs would
be desired since the mapping aspect can be handled within the modules
with userspace tools only needing to write into the blob files.

Implement a write callback to enable writing to these blob files in
debugfs.

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/file.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index c45e8c2d62e1..dde1f5f30fb3 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1008,17 +1008,35 @@ static ssize_t read_file_blob(struct file *file, char __user *user_buf,
 	return r;
 }
 
+static ssize_t write_file_blob(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct debugfs_blob_wrapper *blob = file->private_data;
+	struct dentry *dentry = F_DENTRY(file);
+	ssize_t r;
+
+	r = debugfs_file_get(dentry);
+	if (unlikely(r))
+		return r;
+	r = simple_write_to_buffer(blob->data, blob->size, ppos, user_buf,
+				   count);
+
+	debugfs_file_put(dentry);
+	return r;
+}
+
 static const struct file_operations fops_blob = {
 	.read =		read_file_blob,
+	.write =	write_file_blob,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
 
 /**
- * debugfs_create_blob - create a debugfs file that is used to read a binary blob
+ * debugfs_create_blob - create a debugfs file that is used to read and write
+ * a binary blob
  * @name: a pointer to a string containing the name of the file to create.
- * @mode: the read permission that the file should have (other permissions are
- *	  masked out)
+ * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
  *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
@@ -1027,7 +1045,7 @@ static const struct file_operations fops_blob = {
  *
  * This function creates a file in debugfs with the given name that exports
  * @blob->data as a binary blob. If the @mode variable is so set it can be
- * read from. Writing is not supported.
+ * read from and written to.
  *
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
@@ -1042,7 +1060,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				   struct dentry *parent,
 				   struct debugfs_blob_wrapper *blob)
 {
-	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
+	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_blob);
 
-- 
2.34.1


