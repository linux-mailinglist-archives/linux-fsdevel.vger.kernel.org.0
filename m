Return-Path: <linux-fsdevel+bounces-3002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6F7EE982
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 23:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CA61C20A72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F812E6F;
	Thu, 16 Nov 2023 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r1Ga0GcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90DD67;
	Thu, 16 Nov 2023 14:48:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtaehLBqPOiwavEvCkKEn1b1lLY6MG9j0tjTtUZqFsA65x5pB4pzywbX4q4I10H2rwUzLu+E7+LiDS8Ew0eMn49x/34sE0eRaLtOaWf9ulNfkUaWAq43Hra637CulHP+Rg2uAyy2KQshSN8C0oWYsc13ZqFmXkylFsXb1usr25rTh2sJxkJZGiCxBpXdqQuptZWWKpZ5jtsYvlVI46LUiA9p0XEA9PYkf2dzptcyums6cHG+6AkITBnFBSNKDWmH7p/+F36ZtGbeDaP0XEH0PAKUFWAtlOT+uASS6w7eJxZ0QE2PBdbw9JmMdLXVZuXuVg5NycwDMJfvyJ79lkc+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omJlRKVfpieNt846Bar2DR6ki/tbXKN+YptVuZleYX0=;
 b=iDt02Fl4RYmdgj6NH6F1mzYLc9KNKRkjoeQaG10mHuxK3b69HoiECETvYz9I2cEPShNKNzgquBCgt/AeQStVICtTP1T/bg31XEDkGwa2TJB8ydW1uQQCIXZcBQQ+jKQtW9MckwcComjKfE8JCMgB9GOKDXHykoUluvNQJxnisq/1w4C/5mi4F3JhH6eX81TTDB959Y31rG5pGq6GK+kNY8AGQxk+I3pmTl9VcrSKxnfRlGPyNmYtnoCLhYYwSjuEhCwzgJ0k453CG9L6FJ5+vFWhAqEgDgwGjkboqdUshOdss8NO1WlwE2IX/8J+jpiIzQqmQuogN8a9fKVP7yMHDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omJlRKVfpieNt846Bar2DR6ki/tbXKN+YptVuZleYX0=;
 b=r1Ga0GcJOspXEh7PVcA3SEL6VXOJfrqK0BFbZMZYNyMWDJ30XkwTUjXKxIVSSckuGxw8f9jVeoOcpq38Ml+sAirX5Uc1nFgY62tbVEVuo0sKQ9WraSRFzYGXbIFI0/TlyVftOA+PqtqwoM9m+2EfhrLdpJw165IFrVp9z6qAq3Q=
Received: from SN7PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:f2::21)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 22:48:28 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::66) by SN7PR04CA0016.outlook.office365.com
 (2603:10b6:806:f2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 22:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 22:48:28 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 16 Nov 2023 16:48:26 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <rafael@kernel.org>, <gregkh@linuxfoundation.org>, <lenb@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<linux-kernel@vger.kernel.org>, <alexey.kardashevskiy@amd.com>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v6 4/4] ACPI: APEI: EINJ: Add support for vendor defined error types
Date: Thu, 16 Nov 2023 16:47:25 -0600
Message-ID: <20231116224725.3695952-5-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 35063208-6ac0-4c8e-ede7-08dbe6f62659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YiPJzN9+0S3RT6wKR17wkIlzkVv54xebIoAVbb7AG7ySJdvGIzd6LShWJXJLh1DwMzc6zgZmn1HMWtelTRJ1c93G2Pb0GPK49AhfVijC+CfHneUQ0L7IJoCsagafpo4Z3Mrwxk+pqEjDWBmTd9u7y33Xg0u+jO3qT5Admf6JOFhmfKVEXtZgBK6sXozuQFhN3bmGJGYEvoUs3sMHz6C3iLKSMsDX5aAYiLZHAzvwaaXz1Z2INsSmebOCY5n/YyqlC/1cVCwhAfdDy50MLayIM7dO7HDsTtVtRfE/AibQRM1H35PDXUByBByMudo4550hjPsl/6/EEfwihPtR3unrcrmosj6Kq+NE1erOTVX8iN/pwPerQJDt/q2BTrteEMcJKV1pzamvqhkddVzA30eH9tpoGdzkpaMvMl9ytu3gOwhFxfJj0z+6D4Lkdu5AuaXGVM13mX8i+3C9WJMiRUNBJNjPBaCol3yO9PEKbyaDPkI6/5GH+IkxhQ8oHNaEfFTEM7BoJrAIqtzrFjynqLYuaBNWhCcY389K5kbQ9B01XinjYiv1i/h9Yoxrf2XyhctHbrgvez/2j/ICk72L7C1wD6L9FIGWVfSpR3sQ7Wq0DLBXqIT0wlGf4bSnmxjplfr8PRUcIMFh+b6YHlqbzmzeEgmN/zX5EYbOXBZZxICD6ctE5KS9aiOav2ZhtqMtNoR/01t7NneaN+RmE9WE628+aI+BRNFdg5tBLNi/p5TmRD0X4C4lXFdcXNDb6ORT2wDKcVvWmpgL1j3KD5qDI7K13w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(2616005)(426003)(336012)(40460700003)(1076003)(82740400003)(8936002)(26005)(16526019)(478600001)(4326008)(36756003)(44832011)(8676002)(86362001)(41300700001)(5660300002)(110136005)(70586007)(70206006)(54906003)(316002)(2906002)(36860700001)(7696005)(47076005)(40480700001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:48:28.2203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35063208-6ac0-4c8e-ede7-08dbe6f62659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

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
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/acpi/apei/einj.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 506fe319379f..89fb9331c611 100644
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
 	{ BIT(15), "CXL.mem Protocol Correctable" },
 	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
 	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
+	{ BIT(31), "Vendor Defined Error Types" },
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


