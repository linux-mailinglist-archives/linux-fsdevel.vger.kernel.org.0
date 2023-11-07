Return-Path: <linux-fsdevel+bounces-2325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB87E4AD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3222B21072
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA8D450D1;
	Tue,  7 Nov 2023 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4xZ9aEFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5A2A1DF;
	Tue,  7 Nov 2023 21:38:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A2410E7;
	Tue,  7 Nov 2023 13:38:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBSmyCmA03wr06uiNhmG0ILBsGPaD0X8FdXQPQIHV+KJjX/GJcXqL9AqFaZ7XMvzZ/heQE6MhsIvjvvq95pgNESOVhmJS1FJKSVpLju+uLkYomtoeffegOItnkx8oNtS8Y3VDN2Ht8rXu/YKdjxwYIVCnM5G17AlfYAbApbdXZA+r2ibESQkua3r4wRyxgiOSDBu1irib27bq8oumf1jh6oVY5IzKy00b4N/gMzvOKxF6D3eVfPP9J873zTBLn+hhoYOXtzQYb7IFkzaycHdtsP/kX3HVnegCwP0k6QU+SziSQ2ATXgLJh921372ndCCTyJtKvQE5jqd5+Br971H2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ajLRiirW4aqqh+xlefXmu/Lkw6G0s3Kq+tJ1yQQWnI=;
 b=KDiVR1cAnOYFd9kcFSpAc01oblYkc+IKzAqP1PaFf1XMdqlsJVsgt9960JPmR7ozXHs9iiNZZw9uSr1zpf8W8uH3COqfmlCOqUGPGbRdGN0axf9FhZ0ch85AlVVhE74V1AfeeTyIqQ7Hwyuc5CucDooH8Ta24Qi5t9T9+Mu1NxYf2McO8VUImI728xWZhayw13G4WvElzDzaTWvuPfhmSBM/S/Vqp0D8FSvidDO8Tm5wU30SgGDi+z8AasdgCzi8aj9ugYsq1ZrTzjSJ3pjOU35HGCqDqeofLrl7sac3xMBksaqsHu6u8OC3WevVtCssp2pkmLEBtQlqF+4W3nB67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ajLRiirW4aqqh+xlefXmu/Lkw6G0s3Kq+tJ1yQQWnI=;
 b=4xZ9aEFssimNqaHkJBpDKVZK1mUDN2im+1bV/bWxxhEByUeMvyJnylgBcB9eRif6pXwK4UaoMDiVITCyhIw7Gbdu4UqVlJ/vEW87rb5gBSZM4r5iy8RM3d3s6qKly8riKWjLsuvwJ8W9iXkBY11FKYfiZewGsgaSiLMtbENsyuQ=
Received: from DM6PR05CA0053.namprd05.prod.outlook.com (2603:10b6:5:335::22)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:38:10 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::d7) by DM6PR05CA0053.outlook.office365.com
 (2603:10b6:5:335::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Tue, 7 Nov 2023 21:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 21:38:09 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 7 Nov 2023 15:38:07 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <gregkh@linuxfoundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alexey.kardashevskiy@amd.com>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [RESEND v5 4/4] ACPI: APEI: EINJ: Add support for vendor defined error types
Date: Tue, 7 Nov 2023 15:36:47 -0600
Message-ID: <20231107213647.1405493-5-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a3b54a-778d-42da-463c-08dbdfd9d62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lI+wCletE7KUSzZWkk7Z3dLasYml2AhOLyQYvU6S0jGLGavWJUEQfLy+CGRBRSDbAadyNrL+YOue5Fb8jfewUCEgaYILlO+ZABY+8zm1HhlR9YBCtzoDXQi+S2knVpmYZShcWcsaS1yrXOT++edgiB9ADdsbLk/40Zr0MhCOFrtbAfIKX69An/maOheHpaZruRozaK7LBHYp4CyhcFI0tPYc9FnmzqzjwqmqlQFGqTHpga1gDu4MDLet1W4S/4Y8wFlm6OGd0oNnKhwnwgYTGSx/3hKpuGLJ2gSDt+/JmBxcIwhJ/amVAC6cFcLjc7WUcbDiUUm7dKZL1WqOHgCR6e5ohvOGVSuVZbjT9C5mhJ1qqOGkUM6QU9HEcUzjY7jQ9gmbdgODNNRs6DlLiTitm1D0csAqs93AQaoKPjJJ/EZfV0d1JG9mOH7wE2GQ54sour9ysyPy7pmBgHkxyDP9n1Fvp7TUUGNJhHRandzBavYydk5/LA1rUka+BLHCnjnGVer19zs6c2hoGoqZDMW8fjBOthwmEsPUaA3xA0Kqp4zvIChdYEDaOAWD2rNm9Bb2GmzxIorCWQ0SH1AkHs9AkOlxtWKHMIs9yyfWEYFzBURsMygAwRJTXSfGjalcDQGVy43zlU1CxoAtEO3RXEVedmbTj92ptp0KHinccggTCgCJckBdiFdg/T0Kcb1IppQLS+xkTDQX2xFqEjbtDcB0sTjPYJus6z7aXv7ooDH3a1EjfqGTZggJCVsRmnZ4Ezh+VaFNK3J+uUuhrAIDid2xmg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(70206006)(70586007)(1076003)(2616005)(26005)(336012)(478600001)(426003)(7696005)(16526019)(40480700001)(8936002)(8676002)(4326008)(316002)(54906003)(6916009)(47076005)(6666004)(44832011)(5660300002)(36860700001)(40460700003)(41300700001)(81166007)(82740400003)(356005)(86362001)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:38:09.6333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a3b54a-778d-42da-463c-08dbdfd9d62b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802

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
write to the file as part of injecting Vendor-defined Errors. Similarly,
the tools can also read from the file if the system firmware provides some
information through the OEM defined structure after error injection.

[1] ACPI specification 6.5, section 18.6.4
[2] ACPI specification 6.5, Table 18.31
[3] ACPI specification 6.5, Table 18.32

Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
---
 drivers/acpi/apei/einj.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ee360fcb1618..e2c5afdd42f2 100644
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
+		debugfs_create_blob("oem_error", 0600, einj_debug_dir,
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


