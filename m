Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664BA705603
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjEPScs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEPScr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 14:32:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24C155BD;
        Tue, 16 May 2023 11:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8vELFlnsNDbahn3qOgBATEOyL4+kJfi1PUf5IQNIF107Uj4BfphetHhqZQpUc215xEr0Fg3NVqZcxAamRn0fCUlsdYzi1NNBjHt0WGOWw604DpQ03ZVFa1hceapZnl/F4EO5Xq9U2z+9eslg9WnpXM8ZAYqeQQ7nZdsuCA6EPmE3IF5m3X9inCqqeitB2NTCI4EwJVl5d7CsjAceDo/ER4V650SWF+sdTSM7nyi7mJMiueODyYex7xDIJAzj62mbKhUjns6v7vUokY2PRevfhOssBN4X4c5SwlK01gxxVHKVAjbWanvGjS82HIk4rGg/KB5qUqQ5wq1Qxu7F2mTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZctYU2ScxGiV3VuJa/y87S7yJ44bKk7wVuA73/Arkb4=;
 b=ibgYQNL9jvezH5VCd4mCVVz590ff+igBAIWzHAZoJkxUheALGRKSjU4KyRTV9bFncQQl7k1S1Jua41OCw/ZRUkBvUBQZqshUSiPQ+2kE6YwlSCXsapTKUS0KAI1zPDrjkTRt53OtFter+eOUSCjvYfyfguGYo0f/At7glqB1gr18WZzdfp5P2uEqqtcjLJM7QhMf1ANWM/d3DRNyarT+RG9XFqdNEVkfuwECVIXpfngqR3y0NbEgoFU42JIHYfewB6evRm/Sw5cZOqotRFfV16kvt0DX4h1dTJgCoZU7XD6yPwJPa1h0AYwcKyPLzrbS0B57Wd8ZOn8P4ElNJ4zI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZctYU2ScxGiV3VuJa/y87S7yJ44bKk7wVuA73/Arkb4=;
 b=FlokkGwhyB9v5r1k4C8Mlai1etcTmWv25sW48oe1dcB9VIDkcDWz50PvEgEtG5y2qKdPKGUlpZCOfwzF9eJCHYGGL4/sPesHwvgiGFZJd6R7oqtkFJV4ejDfaU86++kVUS2SFs+CKTV2+RwAIObtNtKkPyyg71Nz7LYAOZR/RGw=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Tue, 16 May
 2023 18:32:42 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::49) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 18:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Tue, 16 May 2023 18:32:42 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 13:32:40 -0500
From:   Avadhut Naik <Avadhut.Naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <Avadhut.Naik@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1] ACPI: APEI: EINJ: Add support for vendor defined error types
Date:   Tue, 16 May 2023 18:32:28 +0000
Message-ID: <20230516183228.3736-1-Avadhut.Naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 62898160-7ab3-48e7-5c42-08db563bef82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGjwFpToBp98IX+55Yaz1Rd4ipt5Rz5NTWZ9pkZaEJJTpBcp2X734TR3864Eg9BHQPWQeXQ/J/Qi4Tdntbere3CJTKzFOHu4F8YL6MTKchrEgQP+oj7rmJKHVs9kBiH6GTOZtqSFxj2g0XxzzlgpT0H0pWCadxf/Ly+YCRSmfUbVqAZFvAfi3UuDRdzmZConvmypWbQ50Fwb1XgFupS/G3O+ISg7b+hD8PNSf/MpfA/HeMeP6r4PqeYinaRp7uZxuFp7lDCUJTEDywkuRu/3Ee8I2DbUsAYabVEKh8EJ/i9BiKLcysYp1XR/3JMTy/Hjhm/6y3HelJu2gLJeSUInvnszlLF/1zBeCoDuGU7K65B/IxHYBiTH0fMCWATAL7EvMHpfTpWYxuGYpZd2BwflIa7yvKS2cTiWxBAowr3tr3alnHOMy/DI1d+NHJjNlxPRst5Yqui0HeCI1vKZ2JzAW7pafxS20m3Xmx1E0ePVmFUHwDw73jPEXjwecoNJ0AdlqbTBtpIAmchSxyjP1d4xZd0ojMJZGjjYg3C/6tOVwaaAA9yRaHRMToVXMYXHnf87n2zeNup4FvmQGdI3UU3rTynY8OSZjAWx3YQmyDdgQssUjSLRYF0GUrc958TVMGWd+C+Cgq2W2gvoQA0wz/YA3EkA2VVzkve2vP/exf63mXKU2n0j8eYW+5iX5TqyiFRLeXR5brsmM1EeJXZ8LTdgl1+RAvQ6GH/I+iPBchBjZ3uapQ5c2/zL8hjqtdzW45VhUR6Di0eofAW99UmXhERtomXcOpsmbFW4an+I5EhDKKA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(110136005)(356005)(40460700003)(41300700001)(54906003)(316002)(6666004)(478600001)(82740400003)(70586007)(86362001)(7696005)(70206006)(2616005)(36756003)(40480700001)(16526019)(1076003)(26005)(426003)(81166007)(336012)(186003)(47076005)(8936002)(8676002)(4326008)(5660300002)(2906002)(36860700001)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 18:32:42.2851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62898160-7ab3-48e7-5c42-08db563bef82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
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

According to ACPI specification 6.5, section 18.6.4, Vendor-Defined Error
types are supported by the system apart from standard error types if bit
31 is set in the output of GET_ERROR_TYPE Error Injection Action. While
the errors themselves and the length of their associated OEM Vendor data
structure might vary between vendors, the physical address of this very
structure can be computed through vendor_extension and length fields of
SET_ERROR_TYPE_WITH_ADDRESS Data Structure and Vendor Error Type Extension
Structure respectively (ACPI Spec 6.5, Table 18.31 and 18.32).

Currently, however, the einj module only computes the physical address of
Vendor Error Type Extension Structure. Neither does it compute the physical
address of OEM Vendor structure nor does it establish the memory mapping
required for injecting Vendor-defined errors. Consequently, userspace
tools have to establish the very mapping through /dev/mem, nopat kernel
parameter and system calls like mmap/munmap initially before injecting
Vendor-defined errors.

Circumvent the issue by computing the physical address of OEM Vendor data
structure and establishing the required mapping with the structure. Create
a new file "oem_error", if the system supports Vendor-defined errors, to
export this mapping, through debugfs_create_blob API. Userspace tools can
then populate their respective OEM Vendor structure instances and just
write to the file as part of injecting Vendor-defined Errors.

Additionally, since the debugfs files created through debugfs_create_blob
API are read-only, introduce a write callback to enable userspace tools to
write OEM Vendor structures into the oem_error file.

Note: Some checkpatch warnings are ignored to maintain coding style.

Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
---
 drivers/acpi/apei/einj.c | 25 ++++++++++++++++++++++++-
 fs/debugfs/file.c        | 27 ++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..99f6d495b627 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -73,6 +73,7 @@ static u32 notrigger;
 
 static u32 vendor_flags;
 static struct debugfs_blob_wrapper vendor_blob;
+static struct debugfs_blob_wrapper oem_err;
 static char vendor_dev[64];
 
 /*
@@ -182,6 +183,16 @@ static int einj_timedout(u64 *t)
 	return 0;
 }
 
+static void get_oem_vendor_struct(u64 paddr, int offset,
+				  struct vendor_error_type_extension *v)
+{
+	u64 target_pa = paddr + offset + sizeof(struct vendor_error_type_extension);
+
+	oem_err.size = v->length - sizeof(struct vendor_error_type_extension);
+	if (oem_err.size)
+		oem_err.data = acpi_os_map_iomem(target_pa, oem_err.size);
+}
+
 static void check_vendor_extension(u64 paddr,
 				   struct set_error_type_with_address *v5param)
 {
@@ -194,6 +205,7 @@ static void check_vendor_extension(u64 paddr,
 	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
 	if (!v)
 		return;
+	get_oem_vendor_struct(paddr, offset, v);
 	sbdf = v->pcie_sbdf;
 	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
 		sbdf >> 24, (sbdf >> 16) & 0xff,
@@ -596,20 +608,25 @@ static const char * const einj_error_type_string[] = {
 	"0x00008000\tCXL.mem Protocol Correctable\n",
 	"0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
 	"0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
+	"0x80000000\tVendor Defined Error Types\n",
 };
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
 	int rc;
+	int pos = 0;
 	u32 available_error_type = 0;
 
 	rc = einj_get_available_error_type(&available_error_type);
 	if (rc)
 		return rc;
-	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
+	for (; pos < ARRAY_SIZE(einj_error_type_string); pos++)
 		if (available_error_type & BIT(pos))
 			seq_puts(m, einj_error_type_string[pos]);
 
+	if (available_error_type & BIT(31))
+		seq_puts(m, einj_error_type_string[--pos]);
+
 	return 0;
 }
 
@@ -767,6 +784,10 @@ static int __init einj_init(void)
 				   einj_debug_dir, &vendor_flags);
 	}
 
+	if (oem_err.size)
+		debugfs_create_blob("oem_error", S_IWUSR, einj_debug_dir,
+				    &oem_err);
+
 	pr_info("Error INJection is initialized.\n");
 
 	return 0;
@@ -792,6 +813,8 @@ static void __exit einj_exit(void)
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
+		if (oem_err.size)
+			acpi_os_unmap_iomem(oem_err.data, oem_err.size);
 	}
 	einj_exec_ctx_init(&ctx);
 	apei_exec_post_unmap_gars(&ctx);
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..6570745d2836 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -973,17 +973,34 @@ static ssize_t read_file_blob(struct file *file, char __user *user_buf,
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
+ * debugfs_create_blob - create a debugfs file that is used to read and write a binary blob
  * @name: a pointer to a string containing the name of the file to create.
- * @mode: the read permission that the file should have (other permissions are
- *	  masked out)
+ * @mode: the permission that the file should have
  * @parent: a pointer to the parent dentry for this file.  This should be a
  *          directory dentry if set.  If this parameter is %NULL, then the
  *          file will be created in the root of the debugfs filesystem.
@@ -992,7 +1009,7 @@ static const struct file_operations fops_blob = {
  *
  * This function creates a file in debugfs with the given name that exports
  * @blob->data as a binary blob. If the @mode variable is so set it can be
- * read from. Writing is not supported.
+ * read from, and written to.
  *
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
@@ -1007,7 +1024,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				   struct dentry *parent,
 				   struct debugfs_blob_wrapper *blob)
 {
-	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
+	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_blob);
 
-- 
2.34.1

