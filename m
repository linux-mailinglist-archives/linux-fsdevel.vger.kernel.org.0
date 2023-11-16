Return-Path: <linux-fsdevel+bounces-3000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFD57EE97E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 23:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DB01C20A01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EB212E51;
	Thu, 16 Nov 2023 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0SwmjTai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B1C195;
	Thu, 16 Nov 2023 14:48:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuHylthg9/cD5DdAnC12TBCxel6SM+x3Qq3n6TF+0TPSpj11WD7Unu5IT3vrFovCvGLbQQF1Adz9+SJaw+feJb5b+Joy2PYorcwotnZXLQIjviDrTzQGQQMGr9IVS4qhs+3GWuhbOxExbyoBaMIH8tM8dX5i/tXNg1UzzSxrkALixrLqUeopnN67C/DjVBLxhxKUJ1XJSBfJ5P8UQ0CAlbN2FgNQftF4Vy04GnBTj2I4uzSwUSm6g37P4D5kFZAPfiYpuUdfqPpT5WWJNOO9fV+7UfEpWBUvEI6Dh0qG5/RxGsunsEn3I1UEmbuVXlEHW/JKYarcNWC7HtmVQ8veSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO0hxm6JvxciEvPr809e/3EMnrolHbBct1qGifI9wYI=;
 b=cwIVSo2gLM+Sgm6Uhghy9yJh7IGCzM62syCgMYjVcjrMAD8mtmf0J9zwQp7dbpYEJJxNEdYqndRhItvr5sM/HoCBLJojL/ncmMpb2wJ42DI6j6lAN/A9VxGlSC+8LprTKqC/uilfPAXzkE7GI7RsE3sd7dc2v9quqEXn9w25fVY2dbSS8WOIdnN9EFS7nElnEMyYBjG96rQVrh94g0J6hzlV/HvgiL8aAO31i953eI6ChNgzRYmxnS+lC45PAmR5BDonvIUzp4OA+7qwhDXdJkMWHg5303ZmW0Og9JEcxsP+s6TCqp/hs/DxTC/DUl1Q1BI/vrjg2DvBJLBkwAChAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO0hxm6JvxciEvPr809e/3EMnrolHbBct1qGifI9wYI=;
 b=0SwmjTaiR/UwVBdLyzSZVr8mK27VbFzhwFeIW2jR9T1XqX1xcxdf5L5CwpJbReeDVZsUF66SzP/WuZcChFR62UCfLKojz51q4FqEPgLyCdLNEqEdnb3N+NSHk2ou/1CbXO5rzgX47b3gdMnEQTjMD+sncPLXhTLsI71S55WMNVA=
Received: from SN1PR12CA0052.namprd12.prod.outlook.com (2603:10b6:802:20::23)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 22:48:05 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::7b) by SN1PR12CA0052.outlook.office365.com
 (2603:10b6:802:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Thu, 16 Nov 2023 22:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 22:48:05 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 16 Nov 2023 16:48:03 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <rafael@kernel.org>, <gregkh@linuxfoundation.org>, <lenb@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<linux-kernel@vger.kernel.org>, <alexey.kardashevskiy@amd.com>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v6 2/4] fs: debugfs: Add write functionality to debugfs blobs
Date: Thu, 16 Nov 2023 16:47:23 -0600
Message-ID: <20231116224725.3695952-3-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f46e63-b25b-466c-a4fb-08dbe6f61888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	61QcDDScPJy84LmFuZ+v+n1FIgVMKNl0mKB0A4tYGh5w25OioomVIXv1aym7r6jGogi1KzdG7VGPmf1npPsN8jMEVZDcbyN2d59ZhaZOI6nhkmfie4aEvdk44UXASl0zocfRxc4JWXkgPE77cRW8lAwbtWUa4LGymmXB3BCzVVEflPtOIQNsl29tM9DzviCrUEutvNPXHns1dh7eeuM1/cggDdyI4DxM0BYrdbX5j5JfvJLDuv7VLAlW/htVoOBitqnJu8MGADkxAPw+lNL4tKfn7TNsFGYGWEd56RCJqsWsZ0rMoBnYQHR7p1NhAL5bDAeLXJeRH/G06IDrYxj3LHxvqPy1Zg6hg0jt9FwiH9xgWWJwmS86r9xauNVn66yX9vuXQ7Rlbgpxv2oaL0BBEXFxY0z0sh80qJwAmtOvxUX/s01nlFDVrB3SJAGvIat5I+KlLuLZU0U0PfO1ZIxjyeoSQjXGT0c/HgBWA0vJCcATXkxHvNv0iuPb469NvhaOvm0cAk8teqRiX4B3tG/Rxhrg1Yvq735kGE5ZnlU+YlI44hdt+VAn6SlgmFLR3m/3U0DUB/zaLVXJsMlG5wCXN//QmDrK56hy0lnX7HCHuehouVu9n6Ih+IBBpovqyIiuijx4RE1uGiIMNUgiTiO4byucqYdv/V6TW1d0q2XFmIoxAsB3M+lho3/2FlrhcPOGAKN0Gz4n6Dr+KS/3jlzId8e6kGrZfUMNPEUlliaW8S+ou+CpCuh4Gb0eyQCuRvOU1T9fwlijgYRqHNIxQeuXrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(7696005)(4326008)(2616005)(316002)(1076003)(5660300002)(83380400001)(6666004)(86362001)(2906002)(426003)(336012)(26005)(110136005)(70206006)(70586007)(16526019)(8676002)(82740400003)(54906003)(478600001)(44832011)(8936002)(47076005)(356005)(41300700001)(36756003)(40460700003)(36860700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:48:05.0383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f46e63-b25b-466c-a4fb-08dbe6f61888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162

From: Avadhut Naik <Avadhut.Naik@amd.com>

Currently, debugfs_create_blob() creates read-only debugfs binary blob
files.

In some cases, however, userspace tools need to write variable length
data structures into predetermined memory addresses. An example is when
injecting Vendor-defined error types through the einj module. In such
cases, the functionality to write to these blob files in debugfs would
be desired since the mapping aspect can be handled within the modules
with userspace tools only needing to write into the blob files.

Implement a write callback to enable writing to these blob files, created
in debugfs, by owners only.

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 fs/debugfs/file.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index c45e8c2d62e1..00b834269aad 100644
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
+	return debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_blob);
 
-- 
2.34.1


