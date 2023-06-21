Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133DC7379EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 05:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjFUDvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 23:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFUDvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:51:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E57B4;
        Tue, 20 Jun 2023 20:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd4VcUr5hd00HBIhIdCJQvcR1Ql3qu5PtzVNgS+ptULAhXexkNnhklD4wYjhsE4MNMVoy6P+t1FfYFVZkLN4OpfWRYmwUa5zeWnebhb6UFvqq4c12slN28bwXy8EgjZNhXAlWuJKpkq/dU0rE4JiqW8QeKf+7BKJuqWJGuCoC9D250z39Q57DUv2guvr7GvECpJzAUh12y/dcxYnyZZhhHVPxmp33ccRNRwiE95XODi+hGTrwmNnOEYzcAbBfu+zzJLZwo/ahII5NmwEAisWHoOKe5xl10Qq6xxQpgL9wy5umlGKKQNDWIsGv+YrmmvmyaJDalhODTwvxPvLI7cjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA3Y6jGCoRGvIpIYfOWMFchg/cw5lcr9kqodQe2gV4Y=;
 b=JgsLOLaANBr+G5mgb5mJZbiP514mmKSUuR35pdmDyIIYnywtT7F+/nLIPJwtXBlZQLCnetnP9U7xMBcfQFk9VmPOSNhvgG3yyhDkub3VSR06MaE0sYvzLbaaEL4XV2Wq9lTc2gvfB5p+n9McpsmfEtXmu8OrP1FpWxUziJ80a4Yd3ZHSnFs19Yui+t+RLofEY2m9XktIz4Rov6c7De/Mz1Z0m1BvD0YuniFTNhSrQDbf8LyWK4NIzfmV0sLd6M0x5sK1ZnN57U6MRowHE8leHixe0QuY+4hXzV41PUxLZP15X5Zf4GlMomKvkxlLkVFDC5wQzQZXT6rJDyBn7VJaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA3Y6jGCoRGvIpIYfOWMFchg/cw5lcr9kqodQe2gV4Y=;
 b=PKYj61TANSrHdddcAHVn1yED9UyURN8a8uoghbVs96wMJ9cNrR6k3Je+lAedoM5cCPQk/Ktx7KpfQRyD8huSTfi7kGDH0A3OVdghqWztCqVGcKrqaLonM4jKbDoxUwBv7vwYCtV0xMCqa777DeXUSDAPBzd6HTutDylRSdjF5zo=
Received: from CY8PR10CA0039.namprd10.prod.outlook.com (2603:10b6:930:4b::26)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 03:51:40 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::d7) by CY8PR10CA0039.outlook.office365.com
 (2603:10b6:930:4b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 03:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 03:51:40 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 22:51:39 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <yazen.ghannam@amd.com>, <alexey.kardashevskiy@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v4 1/4] ACPI: APEI: EINJ: Refactor available_error_type_show()
Date:   Wed, 21 Jun 2023 03:50:59 +0000
Message-ID: <20230621035102.13463-2-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b4a8a9-6576-4c1e-f106-08db720ad24a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjXHUD6bsFEgiv8OmRPym5r/qVjvilI0oMunBtX0/Mzeb7H116ipuS49iIMaK9ymqe4wC3naaH16fwM/snW1gT88/YwkwYOJy/f2lSCoGNVogPx3036CqFG+WkNFNdPPokidaHgkBn2NGDXEavy0by/2rt9jNI9TkdvAqqave+oQ6FOirTBOrMrFdWftbny+r/rq3TO8Y+WRa26TGCizDi6rjdsJ2du5kBQ43ynXXpK48sHX7+Ummf7Rmq3vFwtyhggBRor9ZtbTELLr+MdT1aYBN4Bmr16yeg6o5OMtXhWjbweHlx3F1JNkXCAR+DK8u8o7zNZY03ao0LtC+EdmW118Xky6bkCO8AilTTq2ZBzQjwg6Qg4bEVr2TVrJv19+HUCQbbnDS187sB+wTvQGZhYrOYHIrVIgWKZs+1pg3y0KC06lGsHxdDvLTLWmWkPeCA+WfkxX6udJH//KBZAc4tXPOByvmuMdyclBpQb+S/YE5Qw/Uvwb0DE0OV1u9e2+4+J2qtlu4d/WZPjB7cjheth1AIbMh7JS7yxADMhaqqFAFwLRgAMU5sBWdSIXRCwZ9H42XCBCa7W1srzsMpCJImwPMAfdSiBTy34r9/9y+gUWadaH6Yf/cXBRquEu9IQGwDtTMb3BzvaCOSH+oqz5IYS6xjfZUlt/mMj1mzJs2ATgMM2Uaeuzig0i+istCnvT9+ZFEdLXb9NFQMjC43ZGVQH+16zOyZINFVpX8sERDViegoimt+auYQIfA4/ECUpcYwyqJmv/w2QQ3DMo/amMZhSNnVYY1Rfqe+lIl7Z033c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(44832011)(36860700001)(86362001)(40480700001)(2616005)(40460700003)(5660300002)(8936002)(1076003)(8676002)(54906003)(26005)(16526019)(6666004)(110136005)(186003)(36756003)(7696005)(478600001)(2906002)(47076005)(81166007)(356005)(82740400003)(83380400001)(336012)(426003)(70586007)(4326008)(316002)(70206006)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 03:51:40.5329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b4a8a9-6576-4c1e-f106-08db720ad24a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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

