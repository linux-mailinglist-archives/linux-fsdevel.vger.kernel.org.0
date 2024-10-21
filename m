Return-Path: <linux-fsdevel+bounces-32536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B283F9A92C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A661C21C22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162C202F6C;
	Mon, 21 Oct 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SjjHFaHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93E1FE116;
	Mon, 21 Oct 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547986; cv=fail; b=iQNMDORBg4cr14r6NtrjFz2vOpW7MX8EHHwtDjh1w876nheiiX93+cLYH6ligR4g2LlsxHl30SKzNBesFMnYQLYZrqjea3AjYX/l5vL/1GAeEcsCnpA0tvh49bTg9nuOrG/YSd24J3K2+QjV3qduXDaL07uqq2PyhtS4Ia3bfjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547986; c=relaxed/simple;
	bh=zwbe4lW9pU5EeZsP72nneaESkytMyQhk2vv7hKnmVW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9ik4tlXf5KTOJy2z5EDsAvQHPcmyfBM3QDN6Z3b8WEbdC8sGJ8N2CFELv1jFJ8nnGs9eX+XFnhaR6MTwkVCHR2M+rSU37FQpWi4Mmf2Oq0fOO1wkZNM5UrQ9tvYQGAK4np047bTWqZx8Xqs0a3EDZiVUGsDToQlqPm8DMvRdWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SjjHFaHi; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXn1jLtgzuQY+OP5N9k12rH70tp7VunTe/oIdpklF+i33whVsgLpXz2n4YLJNMQB6Yo7n7fBCptH/SQ7vo6uJgYnj2AwbAFGUTyXNsDcDi7qsLoDRAmwMwsRP83GI6OK3nmrdZXsxaPubqGuyQ7I2aSfE8pzrCOC4lbavB4C7M9hi0Srqs8v69UHHXa2515hAmO9hhoNanhTEr/ZQNNrlVWjLUUyUJXYfMbXBTt8RphP7SCD7cdyiOszWQiM95myMPbXcDKB2BfqvzjPx3eh2dA8xxY424rKq45qikEco14Byexb09NeCG2/11eJ7xnJmImBaEHs9NDCSF9sVSG2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JENV3spbOLrAWm9hyeATZILr8aJP1JSqWBvGKpX/K0=;
 b=aKaUatXZm7jvVu1Kg51QZbnDM67Ytma23TVsQkUNnsQdv2CwiiKS5z/6NjbemGNOuTIeghxAD+xjk2VsgQ0EjMfpXvWXiW+MVhfgsEWK0w7u3pZ6h1WeF6fGw9UP55asM4hiBbPyWgHk1Mt3XUISBwXUZniMp1V18d6sZysyvY8bwGW9VIoQ5Gr9Qu8IyYUO0Q7xZ7R5BnWBdzzouRQ4kLDXL2wEbmH2TYmnJ+jHiuHSQQOneoriQCkLfFEyysHKwQbHIbeU6Ht/vizOGI4M7LoATc1IIl1T04iUifNMh91c3y4h8u+hmi8N7ProKBzKQWOYKonvxBcPVye6Y4jbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JENV3spbOLrAWm9hyeATZILr8aJP1JSqWBvGKpX/K0=;
 b=SjjHFaHidWK+YvRsEJ0buEnW5fWnEQeCCwh2jAzlUfQUCTNw4KU/2SbewqlLz7IdRLxnbsV67DWkf216TFvabNTx/bcjNVQpHGfcIrOBGZqPzvzh/59FgDtIceMx6ENF3pX04wG09WWX0lHLx6ZiRrEtZgkcS4HhA9bXfS4aQIMV3Pn0D/mbgbec/z32ILK42QzZkQaJzeL91XMKWPa75NtMXMvOLdwvASxsdhHlqgG4GXe85y7QIMtNaZ3fE8oQAkJ3La6wN4fo2IYmVOyuisjnx/raWdxM4wLtKg5tps/QqnlriGs/2QNdx81xBN6XV12pT1sUyahsbgAbNGt9oQ==
Received: from AS8PR04CA0037.eurprd04.prod.outlook.com (2603:10a6:20b:312::12)
 by AS8PR07MB7110.eurprd07.prod.outlook.com (2603:10a6:20b:255::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 21:59:40 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:312:cafe::49) by AS8PR04CA0037.outlook.office365.com
 (2603:10a6:20b:312::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENV032273;
	Mon, 21 Oct 2024 21:59:38 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
        netfilter-devel@vger.kernel.org, kadlec@netfilter.org,
        coreteam@netfilter.org, pablo@netfilter.org, bpf@vger.kernel.org,
        joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
        kees@kernel.org, mcgrof@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v4 net-next 14/14] net: sysctl: introduce sysctl SYSCTL_FIVE
Date: Mon, 21 Oct 2024 23:59:10 +0200
Message-Id: <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|AS8PR07MB7110:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ce91da09-c0fa-4889-fb7a-08dcf21ba98c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?khs1JpTroN7kA0CkqoMZ5w4zRbq8nExqIUAXgUXDoDE1/2HqC2SuIpLFs3aP?=
 =?us-ascii?Q?ewbaxvF7DpP7U0wJjnKjS6ZRuqafZ5GvUFLe7SvBwW4hV41Fv/GpDV6rLHai?=
 =?us-ascii?Q?/to17J3ytP3N79RNYQu0KfAaREO4jh6/HE+uVY86G3ywwLWW2yd4DWhDpWdg?=
 =?us-ascii?Q?rDlVsMcbvzmNMBzf/qqnz0C4GOSvNaNcd2Ta0cvq1Fu30+byLd+Q6W4RCAVP?=
 =?us-ascii?Q?E/bBxlmlMJMUZ3yoGLWPA0cYVneyCZ4HKkgUIyvHD5ZvMJAOJy3jDcotn7QW?=
 =?us-ascii?Q?G+kTMTsRUX5H1899DfH/Na8yWZ2FCgTfHO1LiEdIZ3bNnEhRH93NTHCqEOHr?=
 =?us-ascii?Q?nMdzLCVzg3hsB1aY370A2P39b/JmpFXnPMfCc4CwGuB+fKwcpF/a6aPBZVvC?=
 =?us-ascii?Q?vHqfYGvfPZRFvXuQPWwwqoBv4H2bvEERWVQAyRxiAgPRjYJISTffamkS9e5+?=
 =?us-ascii?Q?FrzXqkR3wcZTqkLzUESel9zZumLVbu/hR9Fx3unXIN2ZMoMFu42vUfjAuBtc?=
 =?us-ascii?Q?cNWt19D6LOEeiXQll73kC7OxF7DnG5mtN7TnX276mjJF58MtDOM/fClj+GDt?=
 =?us-ascii?Q?iK5wdfBUgAq9aORtYeXB8GvAcEK0z+A0t4/F3bNPQWCWZiPIQLT7Lsx1HC0K?=
 =?us-ascii?Q?MdhiVM4hPvNOO6V/lOpEQlov048W7lpnsOgmQaUJgf5MRcnI/ykfPtcI+gev?=
 =?us-ascii?Q?cqqDgOEnz/OGaC8UUUATIyaX0JBPAQQFBHyoRcspQZlIzwHNHWGz6PyaJkJD?=
 =?us-ascii?Q?U3HAfRq6ggwFwa1GoLJh0+2bpp9ZSLBR7HIj0p0FObHVOF6U+PemZzx1Lpkb?=
 =?us-ascii?Q?3jSfx0IYatEhmLb/hQn/6yyOZ2QQEgQhrAM48lA4YpjhRZVFOg9erPaE1nCw?=
 =?us-ascii?Q?XWDXbxNKe/y0mWxdKJ7rdnzYBtVNPeRCFZ/1MzVGKFYkrtk+XsA4jg24OWjH?=
 =?us-ascii?Q?+hPSUXLEmga9JVjrLoSAy0njJY3I9qeKDBrq6lAiuvQ54m4gWMBUfmzLDcsp?=
 =?us-ascii?Q?r7i1cv2CZEwGn97E/Y7QMnc+GpH19CXzOdS9q6xoVpnKMT5KB1Xs1T3yFez5?=
 =?us-ascii?Q?MJTldYwzD1twmz7qmQpCU3/oMcuk+RYWN5imzENOia/tVTvA7epTgTXR0c5F?=
 =?us-ascii?Q?qUkSoLAvjmk6oIWD2PbZYfrF6cuX+sDTN+JzNSnksR2fOpMtCAcPaepYnQ0r?=
 =?us-ascii?Q?FhJ+TfoeT9YF3F5W1vtgFqhaCOj+kEm/+6HZZVi9D5o2NwZsahrSDGLMVDgG?=
 =?us-ascii?Q?Cuw+Hs7418Yh+RFvimPbh2Wf6EV93WL7l1C8ch+AtPmWrBOa+PExzHJAQ8gM?=
 =?us-ascii?Q?RGs9dh12otfYJpo0x7XFgseYDfdtmQ+iVFQ+6bYZQv4ObqFaYeH738iakJJ+?=
 =?us-ascii?Q?Ml9InQGumNkyposyWePq4E+MEwG1wdRjAj2vQ445UUkpAyzo5S7WidhNy5ud?=
 =?us-ascii?Q?ajv8FuniHF0=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:40.1301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce91da09-c0fa-4889-fb7a-08dcf21ba98c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7110

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Add SYSCTL_FIVE for new AccECN feedback modes of net.ipv4.tcp_ecn.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/sysctl.h | 17 +++++++++--------
 kernel/sysctl.c        |  3 ++-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index aa4c6d44aaa0..37c95a70c10e 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -37,21 +37,22 @@ struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
 
-/* Keep the same order as in fs/proc/proc_sysctl.c */
+/* Keep the same order as in kernel/sysctl.c */
 #define SYSCTL_ZERO			((void *)&sysctl_vals[0])
 #define SYSCTL_ONE			((void *)&sysctl_vals[1])
 #define SYSCTL_TWO			((void *)&sysctl_vals[2])
 #define SYSCTL_THREE			((void *)&sysctl_vals[3])
 #define SYSCTL_FOUR			((void *)&sysctl_vals[4])
-#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
-#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
-#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
-#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
-#define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
+#define SYSCTL_FIVE			((void *)&sysctl_vals[5])
+#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[6])
+#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[7])
+#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[8])
+#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[9])
+#define SYSCTL_INT_MAX			((void *)&sysctl_vals[10])
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
-#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
-#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[11])
+#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[11])
+#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[12])
 
 extern const int sysctl_vals[];
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..68b6ca67a0c6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -82,7 +82,8 @@
 #endif
 
 /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
+const int sysctl_vals[] = { 0, 1, 2, 3, 4, 5, 100, 200, 1000, 3000, INT_MAX,
+			   65535, -1 };
 EXPORT_SYMBOL(sysctl_vals);
 
 const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
-- 
2.34.1


