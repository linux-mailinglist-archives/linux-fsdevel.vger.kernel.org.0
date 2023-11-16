Return-Path: <linux-fsdevel+bounces-2999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A17EE97C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 23:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671C61F2571F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F235A12E4F;
	Thu, 16 Nov 2023 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0KwR39s1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FD4120;
	Thu, 16 Nov 2023 14:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ens6hYKL+fwKYDEsULwbtBWrArAczL6jPAyewFiaGpWkrPds0txPLHZPuY0N6cNoYqJq6sgCQqmVA2lLp7/tIRY2IuS9bSbJd/puC16+W9TDgJVKBnpgGc2FE9uZlZeXMFAlhCkMZOFZSj6Q5AEgDvKqaNzktm3afdYrnKdlR4yX+5TXE1AJQbgo2XTIjdGepToq9rB2E77M2GnwJjFU2Xr8rAsU6vGgYntkQd+iF25z/h+r31lX2UJLsyGLzJ0Bsca47BSMMPuh+nNaynq/TYesRwbMzBsB1omkNGKlWWksTj3biVkQIqhCYkXIF6/QV0GXKVK5/erZLKqwtPWcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHRqq6WgoIFpJOd5l9r4Re2Q9EZwlN1X+/P2QpybI3k=;
 b=Vv5z5yUZeEF4xLN57hovWra7aYewYG9NEnDQKYE7s/Lloq8/9pB/X7fxdG+GleiWYCIZd6T4xpj67YF+FYxLbtOIfJb/lxaq55bMVaFA591NcAqRCEJqbXT+7hFmX7/Hc0GRWC5qY9KnHIBLg6rfBsdAwI6tL7Rhqk4+nfHdd/vOhT/YhazfdIzcvk6KU+3uzs4d3kcpBiztd4Z5fkHjAE/iEGbR4RimapuuISrdFbgMzU6YobhmkOI10Ja0fokoI5hPl/49cXqdhig+ZB03fMOxgE7RMk+5PhirUUx7npCSai+cGKJCWM8VDby4EzsRZK3paBJW7D+tGJtNnuNqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHRqq6WgoIFpJOd5l9r4Re2Q9EZwlN1X+/P2QpybI3k=;
 b=0KwR39s1KwEouxDcUVIMPjScjkq/aSwFQdLexiv9M/jFnGSBPiotwLK39XTg3XCI493IFmyZgwIU5uC+Jj7YslKbT6m9xpmDkGOvjHZVsPlNbGxhLiVKwM2awL1SOZ77ZWc3VcJ28BKq+YPZqEGcvDY5sUANQ7Wgrf8uBUV7HJk=
Received: from SA0PR11CA0182.namprd11.prod.outlook.com (2603:10b6:806:1bc::7)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 22:47:53 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::a3) by SA0PR11CA0182.outlook.office365.com
 (2603:10b6:806:1bc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 22:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 22:47:53 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 16 Nov 2023 16:47:52 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <rafael@kernel.org>, <gregkh@linuxfoundation.org>, <lenb@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<linux-kernel@vger.kernel.org>, <alexey.kardashevskiy@amd.com>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v6 1/4] ACPI: APEI: EINJ: Refactor available_error_type_show()
Date: Thu, 16 Nov 2023 16:47:22 -0600
Message-ID: <20231116224725.3695952-2-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: f54cde80-c24a-4c00-c6c7-08dbe6f611b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t3U2odHAVS5UOiZJ7fCX4WIOVeF4MrxCrKqorO4qcSNsMO8CZj5Z9toLpYbZHDM06ak4MytUoIyhTasp572xraOkPvVNAUS+wipHo7luuiRXSPyF6VSoLeXzcuaNcD8N2qCjtskatDFVr+u5DsoGYciegaTc53SwBI8alPgUg4YX+TCX7T8vEZuowldrVnNmZDb4TFcD8mU6MBkRjNOnqDJ7B5w00vSu568bbqQJHSWktFQK84yc7eCjbhMQm4Ig2DQIFev/vyWsxAt5ys5eCwKjwgio6hVDMB0cLrBwDUlCVFayr9Og1JVLQlz7aH4GcD2SCLerkUvkP9QhcIBBetOh8+Gj516TXzO09oGx+KeJc5YyylljFwTr1d5iggR8Vs0aS5OI9asY+iYsRFTg3OXhVKTCowiLu5x/a41hLkYiDqIr/qNrRl+t3v9Y3SkAgd/G7wZUl3798yanI/ESqBeIfSLnXEqsdx5AoTjR6Z8Xypj8igATU4qjDRRWJXVAU1eiL8FwTGSCDVImMOlWoLUA7s4LlXff3Ky7H/U7mmM+mvAWHXeBb/eY2xqHioA5p8fUwNixJV3bB6UyVWAQcEaQt/U8iLJ2gZzwRglaCB8qvzkWfEEOfkS6m7/J7PesT88mMdG+87aChAMDBC6KvIO9cuKXONU7ofAnx+Wr2h+VNQMNTJwtWEwK4e2cb4D/+V8/4noWKcmeNbmgBhO8NDzwg6HJXwXNRoHtyH5+55EMXD+cwhRmGjZi+tJP8GW41ffp6C85x3kzDHVkgCdWZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(316002)(47076005)(7696005)(478600001)(6666004)(54906003)(44832011)(5660300002)(1076003)(16526019)(2906002)(336012)(426003)(83380400001)(8936002)(26005)(2616005)(70206006)(110136005)(82740400003)(70586007)(41300700001)(36860700001)(8676002)(4326008)(40480700001)(356005)(81166007)(86362001)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:47:53.6032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f54cde80-c24a-4c00-c6c7-08dbe6f611b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

From: Avadhut Naik <Avadhut.Naik@amd.com>

OSPM can discover the error injection capabilities of the platform by
executing GET_ERROR_TYPE error injection action.[1] The action returns
a DWORD representing a bitmap of platform supported error injections.[2]

The available_error_type_show() function determines the bits set within
this DWORD and provides a verbose output, from einj_error_type_string
array, through /sys/kernel/debug/apei/einj/available_error_type file.

The function however, assumes one to one correspondence between an error's
position in the bitmap and its array entry offset. Consequently, some
errors like Vendor Defined Error Type fail this assumption and will
incorrectly be shown as not supported, even if their corresponding bit is
set in the bitmap and they have an entry in the array.

Navigate around the issue by converting einj_error_type_string into an
array of structures with a predetermined mask for all error types
corresponding to their bit position in the DWORD returned by GET_ERROR_TYPE
action. The same breaks the aforementioned assumption resulting in all
supported error types by a platform being outputted through the above
available_error_type file.

[1] ACPI specification 6.5, Table 18.25
[2] ACPI specification 6.5, Table 18.30

Suggested-by: Alexey Kardashevskiy <alexey.kardashevskiy@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/acpi/apei/einj.c | 47 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..506fe319379f 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -577,38 +577,39 @@ static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
-static const char * const einj_error_type_string[] = {
-	"0x00000001\tProcessor Correctable\n",
-	"0x00000002\tProcessor Uncorrectable non-fatal\n",
-	"0x00000004\tProcessor Uncorrectable fatal\n",
-	"0x00000008\tMemory Correctable\n",
-	"0x00000010\tMemory Uncorrectable non-fatal\n",
-	"0x00000020\tMemory Uncorrectable fatal\n",
-	"0x00000040\tPCI Express Correctable\n",
-	"0x00000080\tPCI Express Uncorrectable non-fatal\n",
-	"0x00000100\tPCI Express Uncorrectable fatal\n",
-	"0x00000200\tPlatform Correctable\n",
-	"0x00000400\tPlatform Uncorrectable non-fatal\n",
-	"0x00000800\tPlatform Uncorrectable fatal\n",
-	"0x00001000\tCXL.cache Protocol Correctable\n",
-	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
-	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
-	"0x00008000\tCXL.mem Protocol Correctable\n",
-	"0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
-	"0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
+static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
+	{ BIT(0), "Processor Correctable" },
+	{ BIT(1), "Processor Uncorrectable non-fatal" },
+	{ BIT(2), "Processor Uncorrectable fatal" },
+	{ BIT(3), "Memory Correctable" },
+	{ BIT(4), "Memory Uncorrectable non-fatal" },
+	{ BIT(5), "Memory Uncorrectable fatal" },
+	{ BIT(6), "PCI Express Correctable" },
+	{ BIT(7), "PCI Express Uncorrectable non-fatal" },
+	{ BIT(8), "PCI Express Uncorrectable fatal" },
+	{ BIT(9), "Platform Correctable" },
+	{ BIT(10), "Platform Uncorrectable non-fatal" },
+	{ BIT(11), "Platform Uncorrectable fatal"},
+	{ BIT(12), "CXL.cache Protocol Correctable" },
+	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
+	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
+	{ BIT(15), "CXL.mem Protocol Correctable" },
+	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
+	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
 };
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
 	int rc;
-	u32 available_error_type = 0;
+	u32 error_type = 0;
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&error_type);
 	if (rc)
 		return rc;
 	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
-		if (available_error_type & BIT(pos))
-			seq_puts(m, einj_error_type_string[pos]);
+		if (error_type & einj_error_type_string[pos].mask)
+			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
+				   einj_error_type_string[pos].str);
 
 	return 0;
 }
-- 
2.34.1


