Return-Path: <linux-fsdevel+bounces-556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21CD7CCB1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DACE1C20BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C72F45F4C;
	Tue, 17 Oct 2023 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="otwKbeD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17732D78F;
	Tue, 17 Oct 2023 18:49:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA83D113;
	Tue, 17 Oct 2023 11:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrrraz8Nq8hbsq8soDkxrZv20Ppk1EzSwSq/WkvAoJLSLIlQeMFhJupLrT1+YGoe+BQw+EzTuDF2Vcns6sphWcabDHl0fnoBP5bqhG+/1SVZJguXn5VxuW636wmV5dT27VjA/lufwOjXlAjsUKuoNWnXa/xlKPhLdLEyll193/pSy5Agu6OK4rD6aue2l0Z9De2cws3Rd4pNGRI1zOOc9OX1AfTJyMQK9iIikDwZEknxSGPKH/GLGlfKU7sWr8h5TPcUQ7xd7lx41S719Kuo+ZnW+pplSqHMermMEUmQO2rQ5z8F1GoCdyAZXedh2pQfzySljp62E8wAC1vz32Tcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ajLRiirW4aqqh+xlefXmu/Lkw6G0s3Kq+tJ1yQQWnI=;
 b=g7fzkRtPkeZrmFI6kAfvx8+a41kMEJerztMzZIdS04LKM1IEUAeY1D/VqE1p7rRP0MzBFvgkOT8SELZgto2AhR52VKxhifIloZz5nDgzK7p5jSGzgQNZaEAmwLbLwvGBWfOtvxSzY+MFVBPPiSszBrb7RgeZYg4AZ5xfZ/TftX2I6RSjaW78Eq0AUJhtgTcZTIFhyfrHM+dEeVu1jTM/ylOTjlS7oGa7aEiI/LJo2qzOBTsfDb+y2Hbn4P8lK+V9xXZmZuPq+dx2gRoGvjt2fuIglhj1x/Lo8GEEJqb8CRvOC6xxyA8wkvfIJI9mUwwoePIPXeeyKhneGbE4+esXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ajLRiirW4aqqh+xlefXmu/Lkw6G0s3Kq+tJ1yQQWnI=;
 b=otwKbeD/GpHAUD5Be01w//Ot/EheFcJK0rG1Lm0lkkKCIySCwhrKntEtRMmlbdFcqDzsMRdWf0AD6I/A2odGVC0b5BEwqTbHP4BFwLfEetKk6IZOnXPQFXdIbltk+7sWkG61M95VejqvWC3p1lApb68tCNhCZaHVR7/Lgh1kUHc=
Received: from MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21) by
 CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 18:49:40 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::be) by MN2PR01CA0052.outlook.office365.com
 (2603:10b6:208:23f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 18:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 18:49:40 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 17 Oct 2023 13:49:39 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
CC: <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
	<gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v5 4/4] ACPI: APEI: EINJ: Add support for vendor defined error types
Date: Tue, 17 Oct 2023 13:48:44 -0500
Message-ID: <20231017184844.2350750-5-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017184844.2350750-1-avadhut.naik@amd.com>
References: <20231017184844.2350750-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f09c71-3ebe-40a3-0194-08dbcf41d211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tlUUl7LAH4FAIzud5b0IBjlrhgVimOqhMmGKlIY6V+HLbBQpF7+EG3tV1zboLQ4vdDr96zWJyagkJgwVY/5SXZaItjBp4Rzvkin3EgW8QhmosWLh7eY/fw9oESIsC0/2bAKacFkvii46V9NTMRJYRu4i2Iizx+t8Gcku4S7SWZ9N5lCJJcRNQrwvez5ivDPJr31zRYHUOSMK7Ar0AEj29p8hMLmMvMfV0rc6tc93DuE40Q3OneSrXSsqKF9fxE8ZNu4tjNbWz9TdPWK8uRwfJSEX9XbhO+QWf7U410LR3k4Yj+KI2e7qS3nAi0Gi5tzEB4iL9go/JfB5nwjnmq9mKuUleO73nb+4n8TeU0fOsXbNjbZCSVARdKIMYBG7KpE2sd0x6K7Emt+Lx/DKEN7RCtfM4AoYMQAVlbZ1jeNgX+x6QT56tRMaX62GTbI5NvXVlx2X3f7jaa/FHy9jmU9c5yQjZzDxfLAaFeQEpI6K7ayq062o1tHUzZpvxi18Y9LyQeaynRKnSYpe/10i/dBYx/zR9oMu2TLSa2BYcYPxTPbGhSinVnEWxDMYIdMN9OYCVAXmx0tZbKssDPYrO46gZLhEmOFyBqZwampm0B9iraAQ79+rHVkN+kcQMunxOBPfys9FkPv3s8Pfv4GwOrk7Lpe4r2CTHEGATmsouOsD72BVgrqC3IZwDw+TGeO7LVsb5PwuCVuagF6uYIvU5+ZYC2lYIgJzprO5zdMC0MCiV3UYFF5ZnopTkuXyR2/xGEssIYSY5u+fkk4P/PmnmBH3tL9SN53I6ilrTVpDO0N0CJk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(6666004)(40460700003)(426003)(36756003)(5660300002)(86362001)(41300700001)(44832011)(2906002)(40480700001)(336012)(4326008)(70586007)(316002)(356005)(70206006)(110136005)(54906003)(36860700001)(8676002)(47076005)(8936002)(1076003)(2616005)(16526019)(478600001)(82740400003)(26005)(81166007)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:49:40.6742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f09c71-3ebe-40a3-0194-08dbcf41d211
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


