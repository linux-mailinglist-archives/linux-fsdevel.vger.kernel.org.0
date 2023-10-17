Return-Path: <linux-fsdevel+bounces-553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC757CCB16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3D2B2130C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1284447A;
	Tue, 17 Oct 2023 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2jMTBn3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7E42BFF;
	Tue, 17 Oct 2023 18:49:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B390;
	Tue, 17 Oct 2023 11:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+axALL/8pLGjCCWd3WyP+8oZ+Hhy8HhaOp6hJjhCiDiis5cL2SzgCI/qW2CTewFD17tZVweY1+aOm6NcJbkavQMUzI93qLTAehRsNiZC8XvT2Owqt2TMVteT2vIaK34mT+PWLvhgaMwxnfy8+EjUD2Nz3vmLcm5Y9nB2sCEkWXV11hBxmPJWiDFXMKSRasBn4pIG9Mo29HoSbhccrZh3C4oC0Xa9zhDf3ejYuKG/DoNSB4eIDywV3omh7AwupL3QEszpHliu6ydkgtul/e92PXNQKx5dC8mMYgipLjRBDfozmeaJlZuUc9b6G65ymZ3bCRC/XwzXsKwSJr0k6mUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA3Y6jGCoRGvIpIYfOWMFchg/cw5lcr9kqodQe2gV4Y=;
 b=Pgs4KyD6KRmTcp6qbl8YdhJKz2+oRH76cUl5mwWULODJ0ss9Dqww/IZykKIEa14ysgKRiMaIJlT+bUO0K3piBIM2QHiUSjIbvkx3LDkpBQP4vnOzJMSawfcceQXmGJxv/vzhpUblowFM4YneUP+P/811SLv6ELaUFe1gyg5trJrL+z0HX9fgjbYQeWSPx/R4PBFik2c0GuOkqq0NpEOiri2ngzM8DeaTT6GrzIQBjZGsrM4eqkP/F+/wuFTzDenh1/GkcJk0uR0erNF3EHM7dS66QGss/HN8Ve+e3myYDxhvLSreAmZnMzbEMB260PAGOtxUfDRXdTxLiRYNs4VlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA3Y6jGCoRGvIpIYfOWMFchg/cw5lcr9kqodQe2gV4Y=;
 b=2jMTBn3Ts4432BOPEGQAT41G8R9JgTtu02UEtCy5SKZOOozIEPS+fZVGQGEM7djG2sino/DGXNU2UOk5tCndrNSh0bQcdK8QYv5nD74aISVKx/83enUGaOJTkc8/Cp4VPZ4qdiK0OLMDTdGvdPdjFakr+gQDrOyjgBhgxN/SG2k=
Received: from MN2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:208:e8::15)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 18:49:07 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::de) by MN2PR20CA0002.outlook.office365.com
 (2603:10b6:208:e8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 18:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 18:49:06 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 17 Oct 2023 13:49:06 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
CC: <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
	<gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v5 1/4] ACPI: APEI: EINJ: Refactor available_error_type_show()
Date: Tue, 17 Oct 2023 13:48:41 -0500
Message-ID: <20231017184844.2350750-2-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 01509a4a-77bb-407a-81c1-08dbcf41bddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j2wK+p8fCKbFrLMi5UVRinC8KzbGV5MU+P3NIc7K595OzNELyfGMnHv5jELbRP5tvu29Tc1ZJWP6SFs9wdMIGJgBkYZNzjsQmCB4+BeS8+cK38wjY4AAdOIcJNUX3mCGpSHtpL79rKJ0D1+qO/u9xfJdMiVdUQwnZZQ+ujR6haASkB5Oa0UlPnA8clMTz1gSK9gOD0dM74wXZXoQ2hyRg0cP4D2W/xWk0/77fE2SSc5nFyVqL5+4hrXCZZQtkdX1q18NTEF2DMsUPFgHZNTtUoYG0dpdCLypoTxBN9ncg2lPQIeeJg0reuaZ61D1t8ydiRXZs9lgNgXVKdng7cmxZP5wXYIoXuaf8GvMo9/jmwWPiZW3T3CrAoY928F5rQvC7+jW8NYR+ASkPdFTjsfUPSG/5hrK7iTuu44XMKvfsMg0+8Q/e5BAq8JeZVgmGENQv9XOpEl9SYYv5VV4MzbDX++9pxUBXfFdOZ4wmjkgy9HieR/biUsyu47B2s6ICqSXrPqNxpFi8SaxM/2ch+2bEvSE+l/DRqkmn4UY0yvQMAma7tnyCy/jM6pxRapE/RLOWAM236A+rI1WbaMo1GJMBjl+jKsqU33ZOpnf12jo1/uz4S7JL4J1PKUUbKSsR5I99bdl5p4M7cnCPTxaEsmhEtwG1k+Hah//pxx+i95tZ0rQ4tTrLH8adejOKuLPPLbhmHOON7qNE3wrCeEoc+wxkJz3CAnHKpFV+mDKynshYaN+oFB6r4On2W9MBZVkYrtjq1dJWFu3fmgQ2JKqoYphDDh3TXCfqbj1I+vkkqwwBJE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(7696005)(40460700003)(40480700001)(54906003)(478600001)(70206006)(110136005)(70586007)(6666004)(41300700001)(83380400001)(356005)(36860700001)(86362001)(47076005)(82740400003)(316002)(2616005)(336012)(1076003)(26005)(16526019)(426003)(44832011)(36756003)(8676002)(4326008)(2906002)(81166007)(5660300002)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:49:06.7953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01509a4a-77bb-407a-81c1-08dbcf41bddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


