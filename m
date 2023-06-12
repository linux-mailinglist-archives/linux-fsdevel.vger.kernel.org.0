Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E24A72D38B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjFLVwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbjFLVwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:52:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF110F3;
        Mon, 12 Jun 2023 14:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZtu1bpB1RWqhGX+sYQVSHhNDWDpE99ByaaGgPBatIvFm7gUIdMMnzY3a7nn8J1TgQf9F9eAj7/kbU4Z9d/XF50gdlg53mRnBY0/LN5Mj4yM5CbwYIT+qc6Bx6Z+dwxS30vdcRFj3fKMRBEKcfdPXQplizPP4iKtk7wNGN1Jmm2Kr4I2C1mGGt0mgbigsC6ptsAeHVW6dIHRPTx1crA5pPOUytPYD2vcAyiH1pi5CrQ6jsihCyHi+VsiDBSbdq00F0w9tgDp+Lc3pGuPAddUqKNr2YOLMPrjB6LS2XVf7BMRnQ6scAiUWmSI+IALPFD8vsJZCIMYhrsmktfcXW+Avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCQmKw5MbrFFiqbnJKW9xzYzac3xAvBPmjQ+XzJ3zAI=;
 b=VkM5dcLSgxzT5mDGymQt/V5CaTq6ESZo3GEP9TjHlnkkvGFgU/W3L7b3lsqGUPufp4P4wwm7p29otkXum+a82AS+JQzXc7p+AiUH9ZMmipMEOUHFn77rLee7Cey+UxvRaVT3GPufwdEFya2j8p4O8iyiopP3siefcuAvHIaNKlLu3LB7yGJFvm1Cpca4ywblOozPjHLkwmtQM2NqfeMS9ppEqT5V+grlN6BoF10B43tIq7Ajm3DEzB8poD2+krRjAk2nu0GjfFC56r9ABL1VJi7rewm+u3rx7lxMWCCdIwmsZy4uEcom4MOX4rMn1HPU5IDRxKWLf7tsmUQx7hR7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCQmKw5MbrFFiqbnJKW9xzYzac3xAvBPmjQ+XzJ3zAI=;
 b=vHbBgKqSuj2CAEjF28xHGrmQnbcg506ZvveHIcelGl3a1gegLvO7zRoML+cuvjZn6qXdNwQTYdQksHZnBKd2g07LvHwvizWMdieSjZmh9YB7ojHeMZ81/ib0a6WsewomG4wDcHkJQnK5Vg2B4ejqdj2of5LK6mbawF5vMydSRdg=
Received: from MW4PR03CA0255.namprd03.prod.outlook.com (2603:10b6:303:b4::20)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:52:00 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::d) by MW4PR03CA0255.outlook.office365.com
 (2603:10b6:303:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 21:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.4 via Frontend Transport; Mon, 12 Jun 2023 21:51:59 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 16:51:58 -0500
From:   Avadhut Naik <Avadhut.Naik@amd.com>
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <avadnaik@amd.com>, <yazen.ghannam@amd.com>,
        <alexey.kardashevskiy@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 1/3] ACPI: APEI: EINJ: Refactor available_error_type_show()
Date:   Mon, 12 Jun 2023 21:51:37 +0000
Message-ID: <20230612215139.5132-2-Avadhut.Naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e42f8c-4432-4e56-0848-08db6b8f3fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tR7fAjku33pMYBhzEu/+vODoh2FFBJE1c3aJJxwv85dF3US73fUbFOTZK6r5Sg4/gkFHQ5xC2vq/9xC0mxPKnA2YgcXchxygX6MCLdZTBvVmae7/0BHb4qg4isJnEfNoO9SD4jMQvIGUErta2kVWsnfRxlaS4tK/yR0A5+XKEKolvPWuPu/W5qWhaXHWYKhyr0h/6z5xQuBOYfsvABK8qrfLgWdLQr97Jh6XDfJEt/3f7++blnNx1G4jmPd8TtAJM3gaL/YXBqy4n3G/iIpGqdIip4ASCyRj13NZq4oFGg2wgbLtXq9xvZQcflTxxR/dQFOmxlXA+Z/aSQeKnCnVkoCHPnHgMa//EbdNhEvIhbWj/4I9JC/Jx+E5DGvnmW1VpY4qr//96oRYTjvDAzOqNUE1tw5m4lqwrU995MEJIQnAxW3Jad//THE6AtCYPhCbzThnzFSGUacb1mM1zdJsiPR0ZaCIhyCfBjtx7r3F90XnBJB9uCvmoLhBGwKQYJdRnSvQmySnqTdDgqSgcixpPjvMA5wLN0tNvYrnvi4VpvhD3f5RCHesshMogQOuGiPFw2idTEc2O9392MQJZONJK1lIuIv3Kvw5reSQzKpjo9MHgpQqpX1T1TN3sIb8cd9UmAXw2GmfRwfGkEyhCDcNmZPVBryG8wlThZahrWybp4OGAVpWvlB+apqG0rp1I5HMsDroYq95wzRzwrLPkvrU0Ox1LCNLxJ+CtbQbEVt4Xt6ZQDRN8E/R2lnrLoV4CqqdeCsxi2I0CbRoqdEFHvaOSUBU7S2P/1BM+rpG1Jjrp0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(70206006)(70586007)(316002)(110136005)(4326008)(54906003)(478600001)(86362001)(36756003)(47076005)(36860700001)(1076003)(26005)(336012)(426003)(83380400001)(16526019)(186003)(5660300002)(8936002)(82310400005)(40480700001)(8676002)(2906002)(7696005)(356005)(41300700001)(2616005)(81166007)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:51:59.6351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e42f8c-4432-4e56-0848-08db6b8f3fca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

