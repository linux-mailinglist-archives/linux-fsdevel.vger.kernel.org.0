Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F83711861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 22:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbjEYUpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 16:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbjEYUpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 16:45:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020EA1B6;
        Thu, 25 May 2023 13:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM3QreBtGFmllBSWnCPIM9uemfOxW766Hf8FfPKiEJAwo9cdpZ50GIizKXG6RsFYs5qm6DNTzxJOqc96GNC1gIS/DHMrjU8+aBT0HpQ+evuWc9AUQamutv7I0RTXoOxmGb8BbAo6KU7+94cCGs/qftw7qGDUWdCuI1Hho/mZymknEYijDq0Z8B1jqqpxqRuv9d2bN86ikQprVQrfIXqL8+zGAhNSZjpbFzh1zMCymi+STTvgj9klJ/p99/tdDppmR6TqYT8p6WDkKs6/XECAiKN6RKSR2ANKV6pb8hHPiCmRqitShh1UfOyFKQD1R1sLBSyx5BZvC3XlrMZFT0+p1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXYVMUyjlaVoz/P8NyTIr4/LQVpSnCp8FmaNUFZ1Imo=;
 b=VQQGr/GN0wPmq+VaHHIFA1xL3y6uEWFqpeDalN8WjHl8UbRfXUNsqe23A4TIlPyvjglkxymCVWu9M3dh+zpO/6EROlS3tAoj5iZX2VxSqHoUjO81AWnqnEqn4aQVQhhekXRBvQAo+XsCj+QPA286w2aQKeabJzIeSGOQYV6KzxXzzDWdY0nhw2Fl3rh180lP0ZhzupwUUYVQMzH/bOVaUQsVSZr2qVtG67e80rPu1m8+wWp5zjHkoKvZWukhuxl3/tdJqGwX0a/sDPi3ihw/aXP5szLeMUib+2sK5zezYZvHSK9qNGKXSmyjxjVmRwQ786rAt5ggPaYQNpk98AYF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXYVMUyjlaVoz/P8NyTIr4/LQVpSnCp8FmaNUFZ1Imo=;
 b=r9/ndGKlXCQrCjdexFuaBcUH2kWy9z5TsUit8LAYOuzVeR9dS4rsYtkBygSQwMyY5+zrw1OqIOpit58f/9afUfTkNbB01zAScYeDqEXaY6/RhtPQPkO5Ug5SjcueHUpT7ESn1rzB6kVN1rjYPXFLDmFWvWQOzjzKorkw2rtZJIw=
Received: from CY5PR15CA0080.namprd15.prod.outlook.com (2603:10b6:930:18::32)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 20:45:02 +0000
Received: from CY4PEPF0000C978.namprd02.prod.outlook.com
 (2603:10b6:930:18:cafe::dd) by CY5PR15CA0080.outlook.office365.com
 (2603:10b6:930:18::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 20:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C978.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Thu, 25 May 2023 20:45:01 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 15:45:00 -0500
From:   Avadhut Naik <Avadhut.Naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <avadnaik@amd.com>, <yazen.ghannam@amd.com>,
        <alexey.kardashevskiy@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 2/3] fs: debugfs: Add write functionality to debugfs blobs
Date:   Thu, 25 May 2023 20:44:21 +0000
Message-ID: <20230525204422.4754-3-Avadhut.Naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525204422.4754-1-Avadhut.Naik@amd.com>
References: <20230525204422.4754-1-Avadhut.Naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C978:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 438affbb-6c99-4259-a4af-08db5d60e970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwydB9HTH0YNNjtHk0fsWkwv0Lza9FcmMUmbjDx5ehgmUvcbwNeasSQ0PEt3Rv+tsk9K8e1R5sSGelYttCNQIiyR6gxB6rrK0xKSM+QcaWIcSW8qS+qRaCPNURh2xVdj+90AhpvGNYZWb/+xyVNqH1IRfBh+y8A1cUtFKC3y5CEPBPZDtCYzL4ulAiEhXdoDj/QmhyHm+bEWYzwB3PcT5aCg6a7dpAGCQB5i1KNfIIu8+e3FXF+r32bInCaxwSjhh9JhbEid5s5hKOB8rKXfyEd/zCcvZZoyVGnibhybf/YXCdv633Maa0jkkVsA2BXQSih5S2r+bMDSFHTJOH0SoIrAqcBzPRpxawZq2aL6jQs/spW/emx3iPcA1MIPc8AIYwXYa+kEjY8xszJVHNXsZngyrmPik8V4qclPD4xZbFxaA3OoNYBnhpEQKdbkkc2isgFnDzfd25v6Mk5D8Sb4wHhp+rMdsdptLQ8tTR0V7kT0jkHVnVNGk9Mcfy+Ov7mMOCN4VskWGLLcwYfX7u/WEoDvKfwdDrMaIpVq0i0ogyXNcDlId0HM0hvzWNBsTJKatpk92XSJDVpZSCfbD1C8OK+c4sRBhBEIjvjxt6HzAHZRFCeYS7Z5W1UBBlCo6qdTy+Tpn1FC5lgZVpCoD+95Fu/K5Z3smuGXBiFFAricZ78ljSWgnTkdudBccLXHshoZNdJcdtXCkfWkFq0U4+BZF23ATpoNjHXBvl3sqpMUGtaI3Qy7sW6e53suT/oWBxjfiSgTxsbFfeK4fE4k19qvznChPb+kQNZEfO2mhyVHbhc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(82310400005)(40480700001)(41300700001)(8936002)(186003)(8676002)(426003)(2616005)(1076003)(26005)(336012)(86362001)(4326008)(36756003)(47076005)(36860700001)(2906002)(6666004)(70206006)(5660300002)(16526019)(110136005)(54906003)(70586007)(316002)(83380400001)(7696005)(82740400003)(478600001)(356005)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 20:45:01.6681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438affbb-6c99-4259-a4af-08db5d60e970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C978.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
---
 fs/debugfs/file.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..fab5a562b57c 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -973,17 +973,35 @@ static ssize_t read_file_blob(struct file *file, char __user *user_buf,
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
@@ -992,7 +1010,7 @@ static const struct file_operations fops_blob = {
  *
  * This function creates a file in debugfs with the given name that exports
  * @blob->data as a binary blob. If the @mode variable is so set it can be
- * read from. Writing is not supported.
+ * read from and written to.
  *
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
@@ -1007,7 +1025,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				   struct dentry *parent,
 				   struct debugfs_blob_wrapper *blob)
 {
-	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
+	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_blob);
 
-- 
2.34.1

