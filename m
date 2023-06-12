Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B885D72D394
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbjFLVwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbjFLVwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:52:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036CE53;
        Mon, 12 Jun 2023 14:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq666t3W0mekr4844OS/1m1nx2nHg7cauqhU3BJqDE/yPbRoMZfffOrZ+YWeFw2b5K8q8EF66kYMgyXEuJCcs/CoGHXA+oTX7Na0K6ouuiI06CzPBAO1MWc3VrXoIe+KP+kfLVViuyPdly8BJBZYrwHqPQwMkxu4+oT4d+vh+TR4odgfytRxPtygma85twc5ctF0z8BYxeWsON7b6NOGjeRb05XL8ecl1boIjJMExMTR2jsr9YGL5ZHK3JaAI+x5N6IE5ewRwAtcARXHJHZgdGHTWtKhGzk1jlZNFxn6ZQKr+NOGlDx7h70r28lxqQBOJnZF+rADfzIzDv1akim4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drjmXGR0uevHsHUEc4WrNSZN9mgeD1hvbACzX4EAKls=;
 b=JV2rPRTBiAfIAOjwlCGAhoNv53s64qJSo/NzxtP90ot4Zv2c5r5d1k6oFWAih4icdtY4QqAcv+mUMqvvDQQFqEGnseOJMbjQjldqW1oarEBdMIJzD8ZjC7cdhkG9Yy2BDorx42tXvoYa2R1TjkoG2CLDduT88K5LWlDfvXG4WLcv0DrtG82hbNPgPJtCgVnxeK94fMq+ZZtT3hTICWXPT+hQzFb7mNW+7QInjVLmq1VEO1FWluxalS4EmS53M703kf8V8f3HkwC+5okDv6/vkp/p9bdyU7vy+9/9SezPHfM6lqElwH1XclK7SzWzX9K/AmCHqnidco3+rK08t1fRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drjmXGR0uevHsHUEc4WrNSZN9mgeD1hvbACzX4EAKls=;
 b=Q6LSNukugQ0HuDZ92mO1w2BSZwC9cG+mwEksd1EfrYh9tEtHGfG3kNhVoIv513aFb1yNbddLZSTSYbFFzMkfaNcPvdqf6cnQ2WJrkh+GrxwWJ/HYo0T24YAiQ5Vxvvnq0B/4CJQuoDW9Vdyd0fOMF0m2KDrXYRmuB96N0MRr74Y=
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 21:52:23 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::58) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 21:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.4 via Frontend Transport; Mon, 12 Jun 2023 21:52:23 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 16:52:22 -0500
From:   Avadhut Naik <Avadhut.Naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <avadnaik@amd.com>, <yazen.ghannam@amd.com>,
        <alexey.kardashevskiy@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 3/3] ACPI: APEI: EINJ: Add support for vendor defined error types
Date:   Mon, 12 Jun 2023 21:51:39 +0000
Message-ID: <20230612215139.5132-4-Avadhut.Naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 2717fff1-0d60-4514-270f-08db6b8f4e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2z+EVIh2EXfQicGlr76exHm6KjYYqjY5MmETUJypFJCteScXDxmkEw+odnB/5E+fD9XGw8Q5S2tUprHpD7Ad0/eXzlzy1BcreL9fDX5XgrK8WB+FYWQ3Gf3ZjBz9BETlZVwGvT7CIFWIhLCvLTTF+yyu9ybiaZA05yEvVFzL0cmf0JH6F+syAdPYBNGJVuzvuxW4J5ORvE8nEwb1r50TdqaXL1K4It6PtktkSG/tmdThobZpWqdW+GKDj/2tVv7o5QLP4LTzk8IZCV7NTPOb9Ya9CVNT/yXA0fZYIoNt6qd5fL4rAXsYKBGSmlNmb/AUDi3x48OImYsRdPXFJfXyMYlih2GViK6xA3DIy8rrIs2Ghw3b8pf/2WqY2bzai+AxsH6FFyO9HRGyxuvcSnFvnPaRRijk+VWfGRmrmQGD0gdc1Etl5phla+PcRqtM8a7zNs3cgwUE+qGGCdd3BDtumo+8Ol5w6KT2x4hME3GIbmDDfO829O/sIL8YrWXWq1QKM+jGy9RfCm8C+jLNECrrCQImj7OBTSpdEPozpZMxY/jg3eAdKGxQ6EiGWbXAgonHnMNyhAG5TsJsk7xsxPMiJ1yBaPLDKPRftfcOCq/oiFmROgiXLkPNek3cN3OhnaUFMGb31LmNP7uL7GXEFXLsByQORj+qe5C0izsIjzm30PGwX3RyQ0KNQAGbF/39Lrt9WLOq75KG7TPZyK2Rq3GSNpq8qRQ+6zstKoYj8XUAEB0Nx9qv+FOhmTMSYaEgckHtyUfA3cACCFvQ1qkAPQ8yEr/gMss5ZvI+tLstpi99vJA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(336012)(82740400003)(426003)(40480700001)(110136005)(478600001)(8936002)(8676002)(356005)(4326008)(86362001)(70206006)(70586007)(81166007)(5660300002)(41300700001)(316002)(36756003)(7696005)(6666004)(82310400005)(36860700001)(54906003)(2906002)(40460700003)(16526019)(26005)(186003)(1076003)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:52:23.5409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2717fff1-0d60-4514-270f-08db6b8f4e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
---
 drivers/acpi/apei/einj.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ee360fcb1618..292dd252cf65 100644
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
+		vendor_errors.data = acpi_os_map_iomem(target_pa, vendor_size);
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
+			acpi_os_unmap_iomem(vendor_errors.data, vendor_errors.size);
 	}
 	einj_exec_ctx_init(&ctx);
 	apei_exec_post_unmap_gars(&ctx);
-- 
2.34.1

