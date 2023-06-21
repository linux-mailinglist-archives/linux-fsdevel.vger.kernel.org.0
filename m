Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F117379F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 05:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjFUDxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 23:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFUDwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:52:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5D19C;
        Tue, 20 Jun 2023 20:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUp+BIPzzfmMaS/U+jzqnDDY12GzXNsIi57BkIr4t+uINDH0UWHfqX8w4rGYAZTyHDFOvG4Ls3UjmNQrhMUwElJlvhnN791YPUPT2MYGwC/0rKmgoUwyWaGnqOGCKXXSkHItyc+xKFJoJjOeVoJHa5hU6t3NiY/nr3c/33qZD7PPDuuC6FndQMtYrpTqJpoENBjTg7ibhXugKo8enO2ClacDXZbJ0ulLeSTYNw09rWgd5afIekoeBYsVlAGckVHQlUoGr1jnKcQqeMvo/GLc95GEo9BusthcQei4GNWwPSIG5pgwtiPrId+nia4QfcCD+VdoTb+T5bEwvVWbZqIFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4W6Bg0HaS2Dows5MPE7yWaN1Bd89L+tiBlnI0Q6rPI=;
 b=GckO464xn8Rh6DilpKOILeU0Xs6mb9kY+rtLTedex99kN8q7sm7/zFzLa8JAppS4KDcQcIVRniXORk8xSQ0b3BeD7p45eHvOkClDb/fkmfn4VZWal0m0Zu7Y4rfh/dVzwvj9KwBKnLbNAmvjVc2JKyRvMTxTHl4CXGKWzVDN0jz/ZW2Nmvoq/8LghxXJfvb+EHDomtFQOjNeW6jWlbtqKg2qjkCvyph4mUsDo5WvB8Qgtbe+yA1zEyzccMxIEXNFE856qsllM7FJZ+Z7yD1F+EyJ2Bl4Ej0zlBKDGbj93XxWb8Ed0pd5qYAq5R4q0PKXTAQ1f4uJ94IXSP3MVdH9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4W6Bg0HaS2Dows5MPE7yWaN1Bd89L+tiBlnI0Q6rPI=;
 b=QkpDS0mpvbvG4Rw05bFR0G9Sw47qQxlMXUSS0Nkjn4oktpAFqUdMKOgVXGIgqgQfzVk8XQVcdsjxk9BVgLIe0pgwbhFd4ItjDkZ6wjq1A4WSMwJ86UjHpQnfBbqEw1f3wpfm6DaRqrNUxu4xsLgmvD6wMp4lbPKJSF6GflU6XQQ=
Received: from CY5PR10CA0021.namprd10.prod.outlook.com (2603:10b6:930:1c::25)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 03:52:34 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::8a) by CY5PR10CA0021.outlook.office365.com
 (2603:10b6:930:1c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 03:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 03:52:34 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 22:52:32 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v4 4/4] ACPI: APEI: EINJ: Add support for vendor defined error types
Date:   Wed, 21 Jun 2023 03:51:02 +0000
Message-ID: <20230621035102.13463-5-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621035102.13463-1-avadhut.naik@amd.com>
References: <20230621035102.13463-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: b94abac9-9686-4b8f-777c-08db720af298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7wAuJlhex+fQ33TE2ZAUbSWnfUFJ5/4+igp2i2e4teRR4lO2GhpgLTa/XDeiVS+eOhft3V+7/lcl5Se690IVrVBG41JpxsSGp6/VqQwakukbr9OlaFLR3BwpoyUMT0kAolr8rJQhQQAUOn3Dd3wdTU0SF3w/AydKZ6ioNfkXcgNY8d1atVojjmieY8AkGkRpEyQCsNLIAKeRf5vRxp2E3YUbQyWc+Uck0qc253ZeAHdG15NR7rQhdwccVZGamvsgeRKlsQSRzwGQnO73Dp8qTOg2oGiQWbUAISD3fIAxLi9faQby1pibp2fo4Y1MLe/O2EMRMrIIRPLCey++oJaJy9hJJpnI31o80w3INfgsm3SbQZ95m9uqNYnvge5Oia3yExxIrTg6B3vSbWm8RpwGpMBBJzpzrDvz21tSg+xWt0TsA1vLzUMKzdTcW3J65RNdqW76iL/I/ZMOse84iuP/Q1eJgFYQhGkpTr/VU43q+2YPWOTsExb9WE0FbLpqB7AICSdppKhOS4MURGV3QmntLvzSlbx3NuBapxnkrWcoZqQRjnRkcO7qOl5rqTePIjebKECFoQhiBgWxoNyfPjdVTRuRMDMAgKiXsThXGUL4eBBDqlpxlzsh5PxelhVe3Wq1GVHD4w3NR7Ipj+1K+fXj0vIdUNtYoVUr3GLrYAY0jjYh64RDjlldoateBWCbMcJpUzguLLABb7By2m9f7tE7zEI8uxBwoWu2B93PLVcGy0/6puH3P302tML3nu5MyU+UgF0Cq5c1LjT96SihCtBCXd5scO3T6qvGbZ4/40RcSI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(40480700001)(356005)(81166007)(82740400003)(40460700003)(36756003)(86362001)(16526019)(6666004)(7696005)(186003)(26005)(8936002)(8676002)(5660300002)(44832011)(478600001)(110136005)(54906003)(316002)(4326008)(41300700001)(70586007)(70206006)(2906002)(1076003)(36860700001)(2616005)(336012)(426003)(47076005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 03:52:34.7281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94abac9-9686-4b8f-777c-08db720af298
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
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

From: Avadhut Naik <Avadhut.Naik@amd.com>

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
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/acpi/apei/einj.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ee360fcb1618..0ae2cd325da0 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -73,6 +73,7 @@ static u32 notrigger;
 
 static u32 vendor_flags;
 static struct debugfs_blob_wrapper vendor_blob;
+static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
 /*
@@ -182,6 +183,21 @@ static int einj_timedout(u64 *t)
 	return 0;
 }
 
+static void get_oem_vendor_struct(u64 paddr, int offset,
+				  struct vendor_error_type_extension *v)
+{
+	unsigned long vendor_size;
+	u64 target_pa = paddr + offset + sizeof(struct vendor_error_type_extension);
+
+	vendor_size = v->length - sizeof(struct vendor_error_type_extension);
+
+	if (vendor_size)
+		vendor_errors.data = acpi_os_map_memory(target_pa, vendor_size);
+
+	if (vendor_errors.data)
+		vendor_errors.size = vendor_size;
+}
+
 static void check_vendor_extension(u64 paddr,
 				   struct set_error_type_with_address *v5param)
 {
@@ -194,6 +210,7 @@ static void check_vendor_extension(u64 paddr,
 	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
 	if (!v)
 		return;
+	get_oem_vendor_struct(paddr, offset, v);
 	sbdf = v->pcie_sbdf;
 	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
 		sbdf >> 24, (sbdf >> 16) & 0xff,
@@ -596,6 +613,7 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{BIT(15), "CXL.mem Protocol Correctable"},
 	{BIT(16), "CXL.mem Protocol Uncorrectable non-fatal"},
 	{BIT(17), "CXL.mem Protocol Uncorrectable fatal"},
+	{BIT(31), "Vendor Defined Error Types"},
 };
 
 static int available_error_type_show(struct seq_file *m, void *v)
@@ -768,6 +786,10 @@ static int __init einj_init(void)
 				   einj_debug_dir, &vendor_flags);
 	}
 
+	if (vendor_errors.size)
+		debugfs_create_blob("oem_error", 0200, einj_debug_dir,
+				    &vendor_errors);
+
 	pr_info("Error INJection is initialized.\n");
 
 	return 0;
@@ -793,6 +815,8 @@ static void __exit einj_exit(void)
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
+		if (vendor_errors.size)
+			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
 	einj_exec_ctx_init(&ctx);
 	apei_exec_post_unmap_gars(&ctx);
-- 
2.34.1

