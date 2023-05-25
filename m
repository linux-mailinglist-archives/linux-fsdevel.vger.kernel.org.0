Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7771185E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 22:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjEYUpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbjEYUoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 16:44:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8E71A4;
        Thu, 25 May 2023 13:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsQaplyCwlAs/IEK6Dkr8w3ctnib9EWlrq6SEuIxcW0b9X1kwapOtFHg704WjHZwY+MkTw0qig57YyPlThn4J/9mzylEtPdL1d4k+TQV2wyroYA+HXt++gA7e90PYyLsuJh+enyUI+97te9UB/PFXFmDQIlhvFcyqWvEHATqmnkUTMT+LMgd2dunJ1jNU7FQxDqbALZAL9DcFZk7tjKzeUYD7tJxwKRWwtSk7M5CCu07XSRHTznPRnsYlSMvm7dtpGelZQr+haG/u3WqIdUwAerYs+wxH7tHfpvroivJONo+M/Pvl8gfe4Oc8mrX4XOXbw8y5WL4j+qNkpmZljHEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es2be2BOKi8lHmb8LDh/dIJOfrNDfR9xrq+CallGJws=;
 b=TzVmeEyv6cZg+piTeCFQexbPN/GmjUqCn4TjiuMoSsC/xJJQjYl+qGO7FNjtTvn548hinetTnjGNmdeuw9MYhK5Y34TdLSHXXAh4OvPpymQpQISwQtfdVlfqBuIz6uO9cqm8h5qGMr16vvC3EK4K+zQyaFWz/6JfK/MvtvT8dBNnvO0bIflZ551mKrRRZc4V+NNW/FjAYjXbKqSdWtgFQX4eQktQ9evp7dAzlE82nu0Kib3XBBsQWMmyljimKKU64fCDmv/AYg9HDRVHxvcYF2joKkGJplnFwQafUKHOhykcOeO7MndoX4FKE/ntNn1VOvcbdUwT8r9BdrkgrZWL1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es2be2BOKi8lHmb8LDh/dIJOfrNDfR9xrq+CallGJws=;
 b=KIcrtytzTAvmurVRgSaYEp+Bmb154GnAbPSw+dB4TEzG55U+2mzRMiOzdeuRkb9Wc+LBwHJs/H65NBqYSn+oLWJrjxKU+5+BwsaXmplGz3AXaURKEPnqKEkDIjfz72wH4gUUzMOdUZEAAgw4KL+cookgW1Ua63DaTYpkuRi5N28=
Received: from CY8PR12CA0009.namprd12.prod.outlook.com (2603:10b6:930:4e::29)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 20:44:49 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:4e:cafe::7) by CY8PR12CA0009.outlook.office365.com
 (2603:10b6:930:4e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 20:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.8 via Frontend Transport; Thu, 25 May 2023 20:44:48 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 15:44:47 -0500
From:   Avadhut Naik <Avadhut.Naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <avadnaik@amd.com>, <yazen.ghannam@amd.com>,
        <alexey.kardashevskiy@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/3] ACPI: APEI: EINJ: Refactor available_error_type_show()
Date:   Thu, 25 May 2023 20:44:20 +0000
Message-ID: <20230525204422.4754-2-Avadhut.Naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: e59713b2-3d74-47b2-6aac-08db5d60e1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKg/K2of3C4SyaOTrc4GzmpRx2kk/m8X0ble51oGT4vNEo+Zu5dVJLF1SaeAun0Zj0KyrR0ha/8sccZZg1XoWCOJl9GpfEFJUCtfWaPQ5tjicCaAqaxBvXB5/38NjLRqkLz76T+5bklZE2BLN8DmFpEgUBqSG0wL7SDpriKfKDl/Rwe/Rgj7ys+hFOEGMoCe3hgJGc+7KE7A4CUvC+znCTQGgHm5JbsilPRhLwWxKpH8jIbqFXjF0ZKh+2uUp/XhIBKIqpO82/Q1KJelyWjRQVHH6/EX9zzlGDS3tL5m48xo6jidrrqOhgR2vLK3cgrdCmNl/P+RxklSC/HuBHAHTiweIl5LvN9ead+OxRjfBx3q5mZcaGYr9E4o4hHuakv5REjo5GW9BeqKPDeNvz1+km/700e5+5DnRWnJ/kiRotGDH5vPjJ0Zp9YMTjuQigeZz2fbE5ZY4rgw5GMkACu2K9VJdzZslQ2tLGUHxkoCm/S2HkQYbAOcPIvLEIXC4cBAp3zjx0QHS7TR6n6pxaz/zq18Ys0Ze7hvcXB6A2OcWRphm8P64mK5k6y2p7PvgMuYu5Lt8tSi81goB6HF1kKLdy37HJi4UoVQ7ag35kJFVg8BAHoL8wYyHFp/TLV7/a65QIdxWPXE4mWEPnt6M0cyONUO2og3ob1Af2x+0z6urpy45tijAU2B7gymAcfPjj1gA4TkWPjmWwKbq1C3b+8inMF4+iEUvUmxqyUz9wxH6Y+teMCayNYnYuhxMtFegO9WmxjyiSwVnLZf3ovxVfjOERZCgYmIFr0QF3IbHU80zP8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(6666004)(40460700003)(478600001)(83380400001)(47076005)(186003)(36756003)(16526019)(1076003)(26005)(426003)(336012)(2616005)(82740400003)(356005)(40480700001)(81166007)(86362001)(82310400005)(36860700001)(41300700001)(316002)(70586007)(70206006)(4326008)(2906002)(5660300002)(8936002)(8676002)(54906003)(110136005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 20:44:48.9158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59713b2-3d74-47b2-6aac-08db5d60e1d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
index 013eb621dc92..d5f8dc4df7a5 100644
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
+	{0x00000001, "Processor Correctable"},
+	{0x00000002, "Processor Uncorrectable non-fatal"},
+	{0x00000004, "Processor Uncorrectable fatal"},
+	{0x00000008, "Memory Correctable"},
+	{0x00000010, "Memory Uncorrectable non-fatal"},
+	{0x00000020, "Memory Uncorrectable fatal"},
+	{0x00000040, "PCI Express Correctable"},
+	{0x00000080, "PCI Express Uncorrectable non-fatal"},
+	{0x00000100, "PCI Express Uncorrectable fatal"},
+	{0x00000200, "Platform Correctable"},
+	{0x00000400, "Platform Uncorrectable non-fatal"},
+	{0x00000800, "Platform Uncorrectable fatal"},
+	{0x00001000, "CXL.cache Protocol Correctable"},
+	{0x00002000, "CXL.cache Protocol Uncorrectable non-fatal"},
+	{0x00004000, "CXL.cache Protocol Uncorrectable fatal"},
+	{0x00008000, "CXL.mem Protocol Correctable"},
+	{0x00010000, "CXL.mem Protocol Uncorrectable non-fatal"},
+	{0x00020000, "CXL.mem Protocol Uncorrectable fatal"},
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

