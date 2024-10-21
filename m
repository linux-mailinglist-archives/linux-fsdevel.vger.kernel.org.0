Return-Path: <linux-fsdevel+bounces-32533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC7C9A92B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDE81F232F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379CF1FE114;
	Mon, 21 Oct 2024 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pm3UHxrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE8B20012E;
	Mon, 21 Oct 2024 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547980; cv=fail; b=Ky3Grtc7bNTaqP/3t0dPDxAnKi9oneXxJEw21OUcF8dOxJ+ABjSfX1dZWif0x2vew0zl0uH/Z8EuzakTysOO7Mx8LDygYSI7VBuY6HD64aXB/rnYdaRRiPqMtptvdw2y8xAy1G9vGXC+9KrquPW0/tvYPH1bKCmDuu5VcsyLSyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547980; c=relaxed/simple;
	bh=V+Yvya7OgHAA5sU7QnJqQ9VHeO+e4BHT9mmnvwVfQ8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPkcMNhcYuBzLOLDHqZIONXkD6++McVjHPOkO2y3H0HGXWc4HZHvFom//TJ2vS6sQ2nSt+ioYICNmBvDR1oCPMvuqRvepmCFMRtuZ7jIq0nD9wQXO7zjas5FAjCTiegezaACR1IDsb5dVw5BkyH1oNiMSNlZC+ii6om0J968u50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pm3UHxrr; arc=fail smtp.client-ip=40.107.103.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyER0O0QFqwQRrhf3FqVvQQASSSSpwyjOxwTBI+KwF23ra3v9/okSkL/YwnCuBRw21i8RDVySVVZ81q5Brc9LYqQAkHparVfr7rle1zVUh9bs0b5Ti/y5+d4NjDJ122hN2FAdb+0KbV5rk7VRBd+GiORgcz+w6W+1RM4QB6CKi09B3Idtr08zJ16oTlI0qb9jgPK4Ve0hpUWuWFtfmdhydaNjXSIuyvWPGrYYNmTnSFwc4cEYJespZYELGA6WNTy+mEriVL7zYMpBQYkaJedxSNtv0qdIgXz719WcLDnqrBDX6EQMbCOV8P9Gm6AyGvH9eFnQyRzzDuJE6/DZ9p0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfd88KmR3vDR2D6iM9TKzXENTIX9qft+iiHkzKQjoC4=;
 b=tLH6k+OR1mwfj7NFlGMZbya1Wes2XeBvMFGlbECtSvtlZqviZ4UjV5gdeAk/LCJ8dcL4uWghNJil0yOXg06Yc11Im4Zq7kHwfQhRaZKk/fS6nzxGHpieQSaHD543AJyG689lfd9095N67YfZQtW7/K5mfEwn2a17zLN0RrB2wSkED2YEjtaksUmhFKFwQsRx4bT+qm8op9+Lhdet95UdYL8QdqpKBYharuCl2HUrI2OyophOodducQTHg8+aNJPvqezsm7yFC6p0c8cZ9/WR5DBrL1O0SGMWfFC03lHCHL5oeh6KGwqTC8F+IMr9hZNSpwkVvHkFR9tBYngXP21vCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfd88KmR3vDR2D6iM9TKzXENTIX9qft+iiHkzKQjoC4=;
 b=pm3UHxrr9KkckGT1s8jUiPPHmiDvbEIV/kyxxTj1r0tWEVnsZ17LbZJXJa1wCWgbdtOuQMQ/rkYXiMenladWIpxGPSHYXc6hhSgjjUDUwy0egcgDbvDficg8m7lYn36qQ3uK2gL229iNtyrTtrt7FJxg3R299gUyKtl43dIMEGFliNf0MUTH67jIfVDweokviCi8fzgRwa4rQwEWhDRgbMgbNMe/62O6BE3mxIu3ne+sTcvy4Oer2qzkQQBHT/QXv97uEeIw4vEu2iqaOMmiCHR8qrP2aEqaxQmu+kqzQOy7n88hydYu6i30/W55OqH3TKhQJv1yhxEG2w6Sa/lAQg==
Received: from AM0PR07CA0023.eurprd07.prod.outlook.com (2603:10a6:208:ac::36)
 by AS8PR07MB7127.eurprd07.prod.outlook.com (2603:10a6:20b:259::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:59:35 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:208:ac:cafe::16) by AM0PR07CA0023.outlook.office365.com
 (2603:10a6:208:ac::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENR032273;
	Mon, 21 Oct 2024 21:59:33 GMT
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
Subject: [PATCH v4 net-next 10/14] tcp: AccECN support to tcp_add_backlog
Date: Mon, 21 Oct 2024 23:59:06 +0200
Message-Id: <20241021215910.59767-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|AS8PR07MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b910a2c-6b92-4ec0-f75d-08dcf21ba67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWovNTdKa2hrdkFteFAxei9ZWFlELzVpLzFxSjlmalRFaVZoblUyZ05JSWtx?=
 =?utf-8?B?cDE5c3FrdXJDc3lwaisvTXFMUWdGY0t3RXhkdytCLzQ1ZVFJblllQ2RmSXpv?=
 =?utf-8?B?RFhjQ0lCem1rUUxJUlF6bDJzMXFCcGRyU3IvN0tDQUNTTHdWN1ZEeHF4aFpz?=
 =?utf-8?B?d2NhM1BqNzdFR2IralRwWW5FRGh5V0dzaExpMmxpMXBhVHU2WU9wOUhlbE1V?=
 =?utf-8?B?SWdXb3pMYUMzc0pIdlR1S1lnNGxJTTlhVTRBMXBpSFZKVXhtajNqbXUxQ0pB?=
 =?utf-8?B?Y3VoUW92aWVKL085WUVwMjVVYTFJRmQyRnlJc0psb1FyQm1QNUZXRm81dklv?=
 =?utf-8?B?cU96cTVPeE84RmpWc1BpWURxOTY1MTNqb2FnNHdEaEdmTlZTeHJ2WElOb1pr?=
 =?utf-8?B?Zmlxdnk5RDFzT2FiQkw1ejZnV28vQmp3RHQ5RVAzSG5UYVJ1TU95MEZXSjdj?=
 =?utf-8?B?MCtGZWJubm5uUWFQdWJCd0JQK0lTSTUyQ2NnMWlUREhWKy91aW41M3YvTmwx?=
 =?utf-8?B?NVFuVURFTGFmVmRnWjhuSVpZbUZIdVdmcjdGL2pIZzJaZEF3SDlPUGVESFMr?=
 =?utf-8?B?MWRmR0Z6UzhQWTZxVkF5bW1abGV1eXAxSnlvWXZ5blJtbVUyT2FKbUJrb0Iv?=
 =?utf-8?B?YmlVV1gyZm13NStvcHZqUTYwYi9MYi8remhkRTZZeTdBekVieTFQY1BocDRi?=
 =?utf-8?B?ZXlxQ3hmdnZoRHRROHBYV0MyVFFHR2Q2UGZ3ODBaYkpVOW1semZ0QnZJY0FC?=
 =?utf-8?B?RHJ6RjMxZlREOXk5RG1XeU9zNGVDWGtCc29tSDRtTzcrL05tMSs3VUFoV2dJ?=
 =?utf-8?B?VzhvbXBBejdXY0dCMVdxLzBHTW9UTmkxbUUzY1pLMkc5UG5FS0cwbWlRcWsy?=
 =?utf-8?B?dGlzVSt1V3FlSm15bDJramRsd1AvQS9jeU9vWWU5U3c4WTdsUzhPamhGWjYr?=
 =?utf-8?B?eGE0NmNEYnBqQldRZVp1a3FTcVRhUFhISjRFMHkvUHJxSnJCU3FYS3VxNThJ?=
 =?utf-8?B?KzRvRlRnajR5UjdpV1haLzVUNm11NWhZbTJUTWw4TURBMUlnckJHS3NXbWhF?=
 =?utf-8?B?NVo2NjdXcEdFSm5pWkhPWUZIbnJRQWFQNE1MU0s1MUJjRGRhOUFpcGF2TGtI?=
 =?utf-8?B?Y3BjTWNST0gwUEFDbld2V2hmejRja0Y1YmJOSzFlWnVGaU9DdkVBdGprOU1T?=
 =?utf-8?B?cmhMRVc2YnFzRjZybXA3YmxOTGtYdFlzZTlLTWMzQnNyUEJhaUp1K3ZvU0cr?=
 =?utf-8?B?bk9SYzRwQ0RzMU9ibGRiaDNyS3hjRXRhUWxjejV6Nk9GSmNxSFZnQll2NkM0?=
 =?utf-8?B?NVRGWjRTSjgxNkNpbE9GUVJEV0NaNFFxNU9aOGt5cWJkSlFobVUxYms2bm5l?=
 =?utf-8?B?TDJoMktaaFhNbmhpSGlpQUpYRUxpcHFDenE4Sy9Jd24vSisrV1RmM0NOWlNI?=
 =?utf-8?B?QU1memk0a3VGM3ZhbVBub2x4MDNqc3ZhYk5kOXMvQUhUZnFPaml5Rm9uK0pC?=
 =?utf-8?B?cUhnTU84MVEwbzQ4K21PU1NNKzYwditSSnRzY0FTUGJnUWswc2huc0NFSFAv?=
 =?utf-8?B?ZVZYaFAwTDVQSmcvNnRvWUxaZ0xvZGlZci8vYkxUemZkbUk3eXRlT0drVmE1?=
 =?utf-8?B?U3ZxVGV5dlRZeU04R1VjN0RSVDYvcjZtRy9ib2FDcnBqQ05ZSzQ0M05oY1pN?=
 =?utf-8?B?MU5UZTVNMXNUUFUzWWNMS1BXM3A1OWRWell3WmgxSXRGb1dmYnovQWR4NUNE?=
 =?utf-8?B?ZWRiekRWNm5ldnNOYmRBRnpSams3cXNmNWQxcDAwaXZzTGdoOGpJY1FOUmhZ?=
 =?utf-8?B?NHQyb2NJTnMvRmZGdDJVaFVKRkZ6ZURGVUU2L3l6YmFJTWlEMlFQMGdBeVI5?=
 =?utf-8?B?ZXE3WXdEbGlDZkhUbjJtOUU4TVpTUkZXWU1sVEd6RkZSaW9hYUl1clJhL2lP?=
 =?utf-8?Q?hPCmkXOlcBI=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:34.9829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b910a2c-6b92-4ec0-f75d-08dcf21ba67d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7127

From: Ilpo Järvinen <ij@kernel.org>

AE flag needs to be preserved for AccECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9fe314a59240..540fe14bdc32 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2054,7 +2054,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	    !((TCP_SKB_CB(tail)->tcp_flags &
 	      TCP_SKB_CB(skb)->tcp_flags) & TCPHDR_ACK) ||
 	    ((TCP_SKB_CB(tail)->tcp_flags ^
-	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR)) ||
+	      TCP_SKB_CB(skb)->tcp_flags) &
+	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
-- 
2.34.1


