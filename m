Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2732C72D390
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbjFLVwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbjFLVw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:52:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E110CC;
        Mon, 12 Jun 2023 14:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1D4RSjFtkStWamAnnprgTm+J53pSP1AhSOZwOmRxqePpDTJCGNE1Rci55E5IlDzaCtvNKhqF1sqcflSjG5KwoJukWIOjRvLXw9dw5yCRg4qTOmSquGkJVP6ZHX+e+2D+TnjPkmW61cps7QcYJfYnsffyY1eLFdz0GTFOidugf1/g4v0JTAqc7Vs0/5NM1eGdPxXe1C3VHPT7y4qgvGCusvWCVN1mo2ukWcqkPqnci1tJCpPO/tJ/vVlptlhhZ+IThlbaTKzgG3LjzZzc7cVMXzArzSnp/Z70ehWixDG1O8JoCE2ZXa8Hf5fm9ZmGpTXG2OeNu9VtFCnPT/shCejrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhzr12iAfX7o0oegtTi3+RnBb0S6bBGxFqh0obObEdY=;
 b=ObyHkUzzipXHhoFhvagHxdwE2eRAmYbXzmBj75gnDIaQgl5lbwbnPWzOKqr6bB9zgFKgJpbEHqtJZDP2QUURzEB3+NpLi2Ua47Dqai/AsIyQOYe3tE28EBYVp0PSFsivVIYB0sPekM9+bTE+vyeYoK94uETK+Du/uuQDg98RCvrahRHs8z4z0U5yOo21B48Qo8CLCEp+ZxZ+QVeiBSUpaOqFe80ACReuAheyYkxsGmu0U7QmmpMGcgPnXS7/SfRITPDcWVYearQszxQlPuiX2J1A5Iu9Ax/RVf3z0qk8ILwXMmmcD6wRTjF/umNtJsVubZNvdEwLx769c/6+3drbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhzr12iAfX7o0oegtTi3+RnBb0S6bBGxFqh0obObEdY=;
 b=NSl64GcRwzM0lvamefWVOIrvUQ4CXsjqmsNwPs8MBoxPyxKD8Ox50WI+sjWkVxo/fgRJkffRgPozn/GgwuZy5xhOBfpjgsmR3v/hO376SCZShJYwrfh0BTDfI/KhavhPL7iykeOI8chi7n6kBCInpx4kEVnOUox8E8d+Ereb3ik=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Mon, 12 Jun
 2023 21:52:12 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::b0) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 21:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.0 via Frontend Transport; Mon, 12 Jun 2023 21:52:11 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 16:52:10 -0500
From:   Avadhut Naik <Avadhut.Naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <avadnaik@amd.com>, <yazen.ghannam@amd.com>,
        <alexey.kardashevskiy@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 2/3] fs: debugfs: Add write functionality to debugfs blobs
Date:   Mon, 12 Jun 2023 21:51:38 +0000
Message-ID: <20230612215139.5132-3-Avadhut.Naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612215139.5132-1-Avadhut.Naik@amd.com>
References: <20230612215139.5132-1-Avadhut.Naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: ad76d6f4-4d5c-47a7-8dad-08db6b8f46de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEviCnkQr1SzK9mEimgRVtMsAGBCet7a5O/7/ocPfCvORV8G2yuiOhmkhGNDgwuxyFZgU6XmFdBqCoD+DuFTgelV3UuRuHtIRU51WIfcmtQF4o5Waii0Ac1KReiixZ0b75tyzV0vtdiNjS+msK5ie+kDJO4o2ow58UUiJSAa8/lB/Ro4EdkeqT7Q92LQUY+xuLc7wLkJALp2WJ9tDP6sNZX2Q5qYz2H5xs9UU1tc5Yi3sXhV0HmQ+qPdamZrbf/RlN6yepeIVVSmRndnO/1KD2xf6GvuOokgyviaH1yG4qICp161ukcWWro8uVKaAyd2wyQxaZVnc93Ej4T/d/a9CYew5av3v2Hz1Iy5RcUJK6AciAthVn0Pd9rsPgpkpsE/vRen3iI6+krGwl6RETiWOe2aJ+r+RskQpY7VdQpv4k63K5horv2TQSl/MWQlxSZ5HgMARsiuA4ka6t94VO53pzrseGKF7GkZ6kmXk7MdraOqXlkT4Zf3bwY7+GRYr1pOrtCe5l77Uh2f1RPp5l3DRfLYubfvjPnO1HtYK9m+79I42/32P30HRs/hN5DXxsER7b0YDtHNmF0BG8eq//1b6ynmk7xMtZS1eJVA0fENXJhyTESZbh2cdCIcSEGaH86Y73Z5hp6qmjvdk6Lp7jis6HbqGcXqI4jBouDziM33F/h7WK/FuUyYPk21yQPgHGFa35OA87LXkT0yt1bXCJ7cEO1qGdrhS/l35/dEz71QDnDXX6ND7dGbQtALIuSnXLhlNxPxUQhdTkCqhJ5RsbJqfzZ7A73NTRrz3zQ8wZS8/1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(70586007)(70206006)(8676002)(8936002)(36756003)(5660300002)(4326008)(478600001)(110136005)(54906003)(6666004)(41300700001)(40460700003)(7696005)(316002)(40480700001)(81166007)(356005)(82740400003)(86362001)(16526019)(26005)(47076005)(186003)(1076003)(2616005)(36860700001)(426003)(336012)(2906002)(82310400005)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:52:11.5136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad76d6f4-4d5c-47a7-8dad-08db6b8f46de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
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

