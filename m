Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0E711864
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 22:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbjEYUpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241876AbjEYUpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 16:45:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC2194;
        Thu, 25 May 2023 13:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obAQL5hQdy+gRy5xuXayX9/itowch6FQnBbbyBwj1B+WLGvsIFvUAQrLkfGaPqu847qqNLbH1YECYK38HfLytXOmGyylxu/982W/KNs5gEGB1Wf5KJjoyPPuThW+xaqu+EB8vFW6ILUjtCtXwgJb7y9MJpoXS8un2JBZtYu+zU+0pN7fuenuprs3yOKITyOxgkh87eIGgf8qU3T9nsxprXGygAbKu/jl9iifaMCtTULBAyDXyIluRST/I+0BgRoPQQEXTRvA6sLfdKVAnzndNNtnsQlFmHb4BkDAjMm8kAJfkjI25G9HApehktOVF619d6SFW7JXXuStv5ABRg1Rxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W32bL/ksI1szNMOCYcQEZO0otnTfwPc32Ft5tbZTKJU=;
 b=K8+5XCh1sz96XM7k1uobGoHHOIxaX4csftPnSUK6ZZ8CuRWDO0sqz2njN+gXaLkN4n5+5AURMXBik0wBbHzfeWbNbA8WQNGUVG/erE1pz4z6MrcjLDt6ePW+Ii/3Xp8U4xBgAZOr/FI2e6SPJppJqmVUkBhSkvM0L2n1NwnYFxvqcebCPjwQcJMeklkCEhGxnQEOg3NY7GRWmupBtadkLp2EGB+8C8XSe91eWq9vfZV4/q1nSDq0+/LtPAQOd2fB8UMUAak57lcWlSPLZHEyfQ3wFG8/ReHawIIN6NOeczCE0VNUzLIqxpJJUgmxBNcCyqbVaL57fgr9ixZamYma7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W32bL/ksI1szNMOCYcQEZO0otnTfwPc32Ft5tbZTKJU=;
 b=EkrHST3D3JTBxS47puKfYE/b3Q8lRr+YNbUtpu7KbPAt9j39mL/8plDdRG5JIipZJPWBfD6F+Xmj2bYKFD8OXaUPZL94vjYkZyp57iMqYoWMemimVbjJ15Qtfnuh842cptdylwpscd4G/lcvCaT2zskTfRcEHTigywQUkL87AXc=
Received: from CY5PR15CA0082.namprd15.prod.outlook.com (2603:10b6:930:18::11)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 20:45:15 +0000
Received: from CY4PEPF0000C978.namprd02.prod.outlook.com
 (2603:10b6:930:18:cafe::b3) by CY5PR15CA0082.outlook.office365.com
 (2603:10b6:930:18::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16 via Frontend
 Transport; Thu, 25 May 2023 20:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C978.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Thu, 25 May 2023 20:45:14 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 15:45:13 -0500
From:   Avadhut Naik <Avadhut.Naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <avadnaik@amd.com>, <yazen.ghannam@amd.com>,
        <alexey.kardashevskiy@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 3/3] ACPI: APEI: EINJ: Add support for vendor defined error types
Date:   Thu, 25 May 2023 20:44:22 +0000
Message-ID: <20230525204422.4754-4-Avadhut.Naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C978:EE_|CH0PR12MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fb1f42-3917-42bd-3e51-08db5d60f13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nK6L3u5ZlNB4G3Om+zw9qqGHufTCXVDtbYx3LR8C8rRF3nPmguvFJCVBwiJg4meLphqSM6kDCKlEmKRp/4D+LeK4zOTu0DwYaasL7Ky/z/jLakhWvZ+1JxzgOophIAvH2wQMDHjBNlLi2v6fvo0GF/7yMMndyfiaTB0tagXWwbvL4CV4YBk8d9t3CcvoAnpSQA8evTOr60UJdorWoCiW1jmBBZklBReB80F62g8Gcx6FzbwiSDb9oZSwrh65wpWAHWSW5lvhi3unSDiMnlQWXbT2pdcO4eL6CReI9fe9PKKZxibdOXgShc0myXjLBuKvbiBSyd1mocdnqAnQnkqHUfFDSjhVhUuJ+KIObcbf/P34pkxl/PxdZwnt9NsW1lxHpo+Yj1rcGPgh07z1MnyWk5YezP3W1e2jNhssh/YBXHILYvWFP5Qq9hGPDvPUo8//WjzZXe/Y56+NwbT3+KnkVe0n2/aqf6aECCtZodLF/hB1pfA7sNsKW6RBZB0ks1V4TKuKnHbJvJVjpnDl78F6sYH+Gzgo4JUzHYjc1UXvGpE/Vzm/s8I73fI08wKDGtMwE88SIcKByE1eNHdXHHF1BN4xg1FSIG2XWwUgGeaDOjVpPN0RW3qORFhNqn0Zq5AtvXqDnHmyuAZk0OzrLFuldTgBBEB3WSwheMnEsJvpT/6FkKDoRu1KtBWl9ugIROS962jSYsXZMPghFHib8u+E7g9A8OquuxKwcRdSpYtG+c3iTER/xgeFB5KJbW0DxfOao0jxVGSpEd3gVhwD2Nt5pnMqMMGG8HG1enf8Rd6j9s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(16526019)(356005)(26005)(82740400003)(40460700003)(81166007)(1076003)(186003)(36860700001)(2616005)(47076005)(36756003)(336012)(426003)(2906002)(40480700001)(6666004)(316002)(70206006)(70586007)(4326008)(7696005)(41300700001)(86362001)(54906003)(110136005)(478600001)(82310400005)(8936002)(8676002)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 20:45:14.7463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fb1f42-3917-42bd-3e51-08db5d60f13c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C978.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
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

Vendor-Defined Error types are supported by the platform apart from
standard error types if bit 31 is set in the output of GET_ERROR_TYPE
Error Injection Action.[1] While the errors themselves and the length
of their associated "OEM Defined data structure" might vary between
vendors, the physical address of this structure can be computed through
vendor_extension and length fields of "SET_ERROR_TYPE_WITH_ADDRESS" and
"Vendor Error Type Extension" Structures respectively.[2][3]

Currently, however, the einj module only computes the physical address of
Vendor Error Type Extension Structure. Neither does it compute the physical
address of OEM Defined structure nor does it establish the memory mapping
required for injecting Vendor-defined errors. Consequently, userspace
tools have to establish the very mapping through /dev/mem, nopat kernel
parameter and system calls like mmap/munmap initially before injecting
Vendor-defined errors.

Circumvent the issue by computing the physical address of OEM Defined data
structure and establishing the required mapping with the structure. Create
a new file "oem_error", if the system supports Vendor-defined errors, to
export this mapping, through debugfs_create_blob(). Userspace tools can
then populate their respective OEM Defined structure instances and just
write to the file as part of injecting Vendor-defined Errors.

[1] ACPI specification 6.5, section 18.6.4
[2] ACPI specification 6.5, Table 18.31
[3] ACPI specification 6.5, Table 18.32

Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
---
 drivers/acpi/apei/einj.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index d5f8dc4df7a5..9f23b6955cf0 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -73,6 +73,7 @@ static u32 notrigger;
 
 static u32 vendor_flags;
 static struct debugfs_blob_wrapper vendor_blob;
+static struct debugfs_blob_wrapper vendor_errors;
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
+	vendor_errors.size = v->length - sizeof(struct vendor_error_type_extension);
+	if (vendor_errors.size)
+		vendor_errors.data = acpi_os_map_iomem(target_pa, vendor_errors.size);
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
@@ -596,6 +608,7 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{0x00008000, "CXL.mem Protocol Correctable"},
 	{0x00010000, "CXL.mem Protocol Uncorrectable non-fatal"},
 	{0x00020000, "CXL.mem Protocol Uncorrectable fatal"},
+	{0x80000000, "Vendor Defined Error Types"},
 };
 
 static int available_error_type_show(struct seq_file *m, void *v)
@@ -768,6 +781,10 @@ static int __init einj_init(void)
 				   einj_debug_dir, &vendor_flags);
 	}
 
+	if (vendor_errors.size)
+		debugfs_create_blob("oem_error", 0200, einj_debug_dir,
+				    &vendor_errors);
+
 	pr_info("Error INJection is initialized.\n");
 
 	return 0;
@@ -793,6 +810,8 @@ static void __exit einj_exit(void)
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
+		if (vendor_errors.size)
+			acpi_os_unmap_iomem(vendor_errors.data, vendor_errors.size);
 	}
 	einj_exec_ctx_init(&ctx);
 	apei_exec_post_unmap_gars(&ctx);
-- 
2.34.1

