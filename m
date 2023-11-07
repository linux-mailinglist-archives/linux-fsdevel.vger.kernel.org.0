Return-Path: <linux-fsdevel+bounces-2322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547567E4AC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B0C1C20D5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719763C6AE;
	Tue,  7 Nov 2023 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jff+/X4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35AF2A1D2;
	Tue,  7 Nov 2023 21:37:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E0010E5;
	Tue,  7 Nov 2023 13:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJfGzpaOYgWv6790Rw4gm3y+MT13xsQa5dnMUd1IW8O01r/vQusby9GAPZHER+m+9k8dEP78ZLp5TChcLN+nYXhMhjjFdznFYOfJz56TJzkHtnVljYXSjHSHaIihrf5QJGKgo0wHLLwT26IukaNOd0J/j7Iojmc/88A2SBEexPU8cVib6/lrbvHUy0syl2n45aPHsk3tSUA469DBsbC1t/D0NRczDpcJzIqIBx0SJUqI+IO7zNd3rBUVgNat+wybj5smJY1MZMYyk0678f+9Sa2nn0228ryxvhBy/Z+kdBK7G6jo16mskf3Jrvc27ImQd+NCPxqHAqIcVcWc6XlBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA3Y6jGCoRGvIpIYfOWMFchg/cw5lcr9kqodQe2gV4Y=;
 b=J8XUdFoZh6YQwggPnHLpOMwF0sEw+MlbKOpdzdqy7yACgvJlm4NnrZJuirsXMOC2YkKf7yU3VCJ36+uejfQV5HM/wC+MLkNB5ler/1+ZMKP1hpB+27O7AIFK4fCbK80hs9Buk3+Y8a7DRLggfrDaN2i9aBlH0yqhR/mZ3UoW6ceajj6OcHYUZ/7hwjs3+kcI4lly1SuyWoPMgaOZOjGvFIxqETn9SgGXyyn5jWQvBwAS3/q46jLeZ15ca/p4i8OOThYvG2bRpndODS56q0OKRHwfOmdG9C8RcNrximeJ1Rc24xbMsgg2D/GVAMzUH69lUanmp9MRB9M7+hd86RT0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA3Y6jGCoRGvIpIYfOWMFchg/cw5lcr9kqodQe2gV4Y=;
 b=jff+/X4ReraECz1IYjk/IiPtjO2uKTpYNL2F/UPU3u8V6Xo4h8GyNw+FpGAfFr+5Ig+fNN9rUcayDBd0bC8b/Qkm5HiqwhLyPeuH+z7dEKXAbuAAftSsOnAJBtMl1stW8YEzzOFZrSa+GtFtSzL/XQK3EIqjARzW3KqYT9XwK9w=
Received: from PH8PR15CA0011.namprd15.prod.outlook.com (2603:10b6:510:2d2::28)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Tue, 7 Nov
 2023 21:37:23 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::9f) by PH8PR15CA0011.outlook.office365.com
 (2603:10b6:510:2d2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 21:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 21:37:22 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 7 Nov 2023 15:37:17 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <gregkh@linuxfoundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alexey.kardashevskiy@amd.com>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [RESEND v5 1/4] ACPI: APEI: EINJ: Refactor available_error_type_show()
Date: Tue, 7 Nov 2023 15:36:44 -0600
Message-ID: <20231107213647.1405493-2-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|BL1PR12MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b50c076-8c3f-4496-20b6-08dbdfd9ba1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rDrpkK2N/IseuOR+fQOtBFYFV/etIAB9gkecgsiGAkgSi87h0vyCXq0DkEuRxhgKOFBcRk7Bab7sAx6l22avHQgAndaW1UrotKzwWDu/mdStG3+X+FGg4FpJ+Wswl1L7zj+l/uo2N0CuU5gMm3+jNdVUSj8D4ZhHFYCwzUIdVBGEyO1y84rJqGj5L/UX3IdQQYI4U0p5+IFABWjsJZ9LPJLRwfS0aXK4CUGbGdF+0FtOmSX2GgjRAIyRF4VlRcOKp19HTRe/53t+TJTYiUwJiVlMrtB3jGfNHouKrz7q2xsw+DxCFmDT1HZkLzyOiTdP95Ej0576/6kaXWi54SkEjNvQ8+LM7J+Cm3aTCpsJRpkd+a/pBAPHnf7dpS19FHJi/v2ou8fQuNMhwMd8QqYAyXMQo9CamnRg9JnHFMAtxLe/U3QiCrIOc+f2ZeatZdqCZVPZedt/FsBjQQHe4kRB+db+As0Ay+KH4Yb/+tySOGtEPvbWr+IRwwcvGFtrNpfO5JRp2Cwq4ZVohVK3X7Q2KnBFDIes8QmzY9GN72Y9jumJ8aShfxvEAiIf8lJutlfjtd0oVfbEZI0qh6JzqH8dY1iCl+aGoXVx+jWPsucU2tAuk10NTc51t269xn/kS3m3BGRPbHIkGELDbubxS9wdj9NREWRf0H+IuXPhlPqUQTD1IRI5XYbB3tox5kw7vMn0EbZ7MPcKTtPBs1l3pmsaAm9KmgOhwO/p+Cd4MdiXlKZpPEqGy2flGTbYU278BrOJKSDv6ljZ1Rw0/7T04icmbw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(478600001)(7696005)(36756003)(86362001)(356005)(81166007)(83380400001)(36860700001)(82740400003)(47076005)(2616005)(1076003)(70586007)(70206006)(6666004)(26005)(16526019)(426003)(336012)(54906003)(5660300002)(41300700001)(44832011)(6916009)(2906002)(316002)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:37:22.5775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b50c076-8c3f-4496-20b6-08dbdfd9ba1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237

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
---
 drivers/acpi/apei/einj.c | 43 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..ee360fcb1618 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -577,25 +577,25 @@ static u64 error_param2;
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
+	{BIT(0), "Processor Correctable"},
+	{BIT(1), "Processor Uncorrectable non-fatal"},
+	{BIT(2), "Processor Uncorrectable fatal"},
+	{BIT(3), "Memory Correctable"},
+	{BIT(4), "Memory Uncorrectable non-fatal"},
+	{BIT(5), "Memory Uncorrectable fatal"},
+	{BIT(6), "PCI Express Correctable"},
+	{BIT(7), "PCI Express Uncorrectable non-fatal"},
+	{BIT(8), "PCI Express Uncorrectable fatal"},
+	{BIT(9), "Platform Correctable"},
+	{BIT(10), "Platform Uncorrectable non-fatal"},
+	{BIT(11), "Platform Uncorrectable fatal"},
+	{BIT(12), "CXL.cache Protocol Correctable"},
+	{BIT(13), "CXL.cache Protocol Uncorrectable non-fatal"},
+	{BIT(14), "CXL.cache Protocol Uncorrectable fatal"},
+	{BIT(15), "CXL.mem Protocol Correctable"},
+	{BIT(16), "CXL.mem Protocol Uncorrectable non-fatal"},
+	{BIT(17), "CXL.mem Protocol Uncorrectable fatal"},
 };
 
 static int available_error_type_show(struct seq_file *m, void *v)
@@ -607,8 +607,9 @@ static int available_error_type_show(struct seq_file *m, void *v)
 	if (rc)
 		return rc;
 	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
-		if (available_error_type & BIT(pos))
-			seq_puts(m, einj_error_type_string[pos]);
+		if (available_error_type & einj_error_type_string[pos].mask)
+			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
+				   einj_error_type_string[pos].str);
 
 	return 0;
 }
-- 
2.34.1


