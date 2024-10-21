Return-Path: <linux-fsdevel+bounces-32535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686919A92C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E73B22E0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430020110D;
	Mon, 21 Oct 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="C7wf5cZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA239200C8C;
	Mon, 21 Oct 2024 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547983; cv=fail; b=QJEK/48QreXNqiD/Di4miZriNi6+D91cRzEM3+8akWiwY/odDdn/1xI5e0bs7qQyLpnqYs5HnTHTaD207Po15zBymcM4twq0cxl0CcqohizUauBUtIQhcbFpAxhdyQagcyBc8Lm2bfUQKPVwapQg7K50t4xjpRQu9YL0ASPUqxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547983; c=relaxed/simple;
	bh=2aVgHO6e2ffeK21NnxaoFTQm7n0pQspgDtcP9of8t68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojMJDIMAUQ2Ns8nlEnuNqYEQRw3i3w3F2s8zoeNnvBjK53Z5pD8cYpI3CMYGuWR+lJtScUeBbPx9jcrn6CzqIAck+xdUMq42yH1qDpKRCmCsuQDw6l9KM9105ekMbeTA6H7LRXlT5O5GvMel+AYFdIm2P9/hOfAkz/ixMpTjW4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=C7wf5cZO; arc=fail smtp.client-ip=40.107.103.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4QnUnFIuwKlrV9nu+GOdcrPcK3BtwenfMcOpWr4uvGbz9LqJHDc9sJC0MqspZrl3QKDXVc37fWygJStYAMeRikq97k7Jix8NDwhDJ84WDalQqyUf8y8djnZiUQQVN98gh65Dzkx8DpKfPbQ6vOe5iuZJRKVZmWyLTflwi7JvDJJYXEu0jiCo+DlM6aJRTF9NCpw8lINKObswjSvmrcoGShP7fBWmHZFKrn9gGMwVjzQYC/VDapVNRA/IJRLvSe/3UzowOGM3UFL+7BR58/hGzYuebtuLh8+tyRIv74nFopWcrAP3S5TUK8ykRhwtf03e497D1Z4n6VQDSJp2xTCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvbkjnKkQWt039ALXqDtPQSLxUPIshp0cwz25EYtHmc=;
 b=rYoeNNmQrp2jyV6SUyrbZaDS3yQ9ymvIo64b87KJJaUf3g+AaMv/Lb1zrtNaYqAxq20kmGoMLEUI4zAmZPMAdIQm0VwMdtN/yZ451z+WjHqpneKFGJWI+CNj/lIdU2GFE3fD3JimY/YCeLBJYvt1Fq1yoNFOevR43gNYX/ZXcxiZao0LiUYRADXFYeVPTcExIj7e/AtHbyO8k3ylp29C8b4wu3O33YAstELHq9Bgjk09ughMq2Qe4VClEsCNISfKWWFnIlhdw86hXzyeayS05DdAvflXBeIz6Nc/KdkzoMZu4Y7auOI0qridOobphmBxUxv+h4xuSsBEAeydTYXsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvbkjnKkQWt039ALXqDtPQSLxUPIshp0cwz25EYtHmc=;
 b=C7wf5cZOCUl+9VG9xZbk8tOPqelC21Losp5zpLqkhLJO9/xzWCDRdpuKUKTCZN7k9V1mCu1S/QU7NjB5yyY0WDyribX+70rTGHkY5mXdXjKHF2AqEYwX5Lgi7oPRRU8jO4OlSeq0UQQdtmBBhCCpTJKg8eUW3+nV9MDDTVgezhZq8K75uwz3UNMR2h+WxaGqB5nRlVrrsaFLviWb3eveqW6wqVSqZRoxjqrF+OMpDLx1SHKNiTdxMhzQhgboa9ulDq7lN8YXoio81n4XOjCQXyI0Azo50w+J+dzSj4s6pwIu5ePuvOAcxxIMu4/3S+pSwc5+KgOLZIY4t/QjDPfwcA==
Received: from AM6P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::17)
 by PA4PR07MB9634.eurprd07.prod.outlook.com (2603:10a6:102:267::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 21:59:36 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:209:8b:cafe::c0) by AM6P191CA0004.outlook.office365.com
 (2603:10a6:209:8b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENS032273;
	Mon, 21 Oct 2024 21:59:34 GMT
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
Subject: [PATCH v4 net-next 11/14] tcp: allow ECN bits in TOS/traffic class
Date: Mon, 21 Oct 2024 23:59:07 +0200
Message-Id: <20241021215910.59767-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|PA4PR07MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da0be08-a68d-4eba-314d-08dcf21ba740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXlzaVkwMko2bmRGTGRiU0cwMHlTdGhWbVFnWlR2bjVCN3lyc2t5Z3BhUmdP?=
 =?utf-8?B?dS91RUZEd0FMSGV4T3U1Vlk5ZE9IQko3N1B4bzdkMzh1d1VNQzJNZ1prQlJD?=
 =?utf-8?B?WTA5bmVFWFRobUZUSE5wdURGUUF6eDQwcDBLa01aOUhqZExmVllLSHVkVlR1?=
 =?utf-8?B?S1U4bkdCbE5OVmZyOE1Md0hHRE10ZGhmR2dKSjc5QlN3VlVDVzRETlBXM1JQ?=
 =?utf-8?B?cnRLQU11OUdnSXVsR041L3Y5eDI0NWhkckFCVWdwT0lUZVZodTlnM3V1a1dP?=
 =?utf-8?B?SkRjelJhN1Z1SlIrL0p3LzBRVWJkaFQzMmxWdCtrb3QrL2dqcUJkM2kvTloz?=
 =?utf-8?B?VTR6NGxIbFNTeTh0K0luZkZZS05UQnRReWlnT2ZPL0pCWTQ1QU1NTXNSVWFH?=
 =?utf-8?B?eFFVdmV1UE9udjlTYTRURUQ3TVdSQXd5YUpaeXp5LzNnNndWUHBIbGYyVTlB?=
 =?utf-8?B?NnNzU2Vua3E5alY1RHRIMFU3MFkxVzh2SlUzbUtFMTNESHpqTjY2d25UN0hB?=
 =?utf-8?B?cVV6aTlCTVhiYTZvVGhPbnZzdFgxTWVLM3hiUGt3QWxDSHh4TTdrWTRYUnZB?=
 =?utf-8?B?a3E5MElJL1ozQ3EzK2UxRHpOdEwxMXN6Nm51MDRHS3p5QnVQaHRzbU9PSEFQ?=
 =?utf-8?B?ZmhJcGppSGUrZjQxTTh5R1U5UXJPaThtNEU0bXdNT2VyTXg4QlZZZXc3VW9n?=
 =?utf-8?B?Y2xJa3ZReUdlaDVDcVZyWlpaQ2ZHazcraFRJTnRpZnQvNHpISUpDMWlXbHVv?=
 =?utf-8?B?MkNTbDVWVlE1akNGSitFejhUV2VrUzlkcXZkcEtsbi85TlZuNkE2R2YvUW1D?=
 =?utf-8?B?ZDdzcUJJQmRaT1NKZVYrOW9mVTRRZTExTlJUZXFIV2N5K2RlUkpDMWF0Umdo?=
 =?utf-8?B?V3N4aVFmemFpMmJpeWNwdTZxVEZoVnoyaHFEa2lPeGZueUtmblovbG9NaWJt?=
 =?utf-8?B?VWdsZm56WWlQaUVXeU91VWZJdWNuR29MNUEzbGkrTHppNWdOdFp3YUVPTlFu?=
 =?utf-8?B?V1NsWnF1TldjcWNaUWdmWmkvSmZXZXRYeHdlV1NQWEtjVnJodm1kaHU4Qjg3?=
 =?utf-8?B?bm0ycGhESGhSeEQxeDFCRWlkRjhpbTE1U3dSSThSSnVNVUlQekt3MTl6S2xY?=
 =?utf-8?B?K0xHY29SQmZ4WGdQVFo1T050c0NvUjNhTUZEcDk3QzhMRWtjV0xpNTRuMndC?=
 =?utf-8?B?T05USlBoREo1M3JLbWNxS3U1RTE2QXZ4bDJGMlhtaC9lYnl3Y2ppM2VhNVhq?=
 =?utf-8?B?U3h5YVpaZ3JodHJJS3VCQ1k2QitFWjREN3Q2VDZLMDJ2THZ3VE1TN3c0MGhZ?=
 =?utf-8?B?QWpXY2NuNnhidkhORmNZaWYrN0tOeDVLU2FOZXVKaVFkbHF0bHFuaE1ucVRU?=
 =?utf-8?B?dGlaQUlmMW40ZFdpczRoNFY3dExKK2FPQXczL0h0OWFTM2xQdDhoV3ZWaUgz?=
 =?utf-8?B?RVpMQkY1dy93djlhb1MvT2hEUGlsSkphaUNKbXVkc2ZJM1A1UzV3U1R2YTM2?=
 =?utf-8?B?ZnBjSG1SdDJaeTEvMVZhbHp0TGM5RXVMcEZteWdjQWV3blU0dU5sNy9ja01o?=
 =?utf-8?B?eWxPbGphZTE2TWErRGdBVzBCWlN3bVdkbUNTUFA5WVdOUzBuSGNyeU5kSWhN?=
 =?utf-8?B?OTJQazE5TENIbXM5SDhpUkJiVUkyZGtYZ29kdjRNbDZpM2gwNVZLa3YzaDd4?=
 =?utf-8?B?NzQ1Y003aStjWDVoTldjZFJuWEFDeWlacmVwdzUybWFId2JzUC9LZjJzd2tQ?=
 =?utf-8?B?dE1ISURjRTNka2ozTHo0MG1BWVNjVG9iMVMrUXMyV1ljbUFoa3FES1lqYVAw?=
 =?utf-8?B?K29EY2NYeVRQVHlQR2ZwNU5wVVJybVd1LzlxeE9mNzBYc0tGenZIV05CMHdI?=
 =?utf-8?B?aFFSQUVzYmNka2txclBlSGRoTFBLQWNJMnY4Z3dhZEo3ZnlOdG1UVG1qWGRY?=
 =?utf-8?Q?WRh/mKqx69I=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:36.2558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da0be08-a68d-4eba-314d-08dcf21ba740
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB9634

From: Ilpo Järvinen <ij@kernel.org>

AccECN connection's last ACK cannot retain ECT(1) as the bits
are always cleared causing the packet to switch into another
service queue.

This effectively adds a finer-grained filtering for ECN bits
so that acceptable TW ACKs can retain the bits.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h        |  3 ++-
 net/ipv4/ip_output.c     |  3 +--
 net/ipv4/tcp_ipv4.c      | 23 +++++++++++++++++------
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv6/tcp_ipv6.c      | 24 +++++++++++++++++-------
 5 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b6a4e0124280..d348ea9be172 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -417,7 +417,8 @@ enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
 	TCP_TW_ACK = 2,
-	TCP_TW_SYN = 3
+	TCP_TW_SYN = 3,
+	TCP_TW_ACK_OOW = 4
 };
 
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0065b1996c94..2fe7b1df3b90 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -75,7 +75,6 @@
 #include <net/checksum.h>
 #include <net/gso.h>
 #include <net/inetpeer.h>
-#include <net/inet_ecn.h>
 #include <net/lwtunnel.h>
 #include <net/inet_dscp.h>
 #include <linux/bpf-cgroup.h>
@@ -1643,7 +1642,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 	if (IS_ERR(rt))
 		return;
 
-	inet_sk(sk)->tos = arg->tos & ~INET_ECN_MASK;
+	inet_sk(sk)->tos = arg->tos;
 
 	sk->sk_protocol = ip_hdr(skb)->protocol;
 	sk->sk_bound_dev_if = arg->bound_dev_if;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 540fe14bdc32..3d836e0f099a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -66,6 +66,7 @@
 #include <net/transp_v6.h>
 #include <net/ipv6.h>
 #include <net/inet_common.h>
+#include <net/inet_ecn.h>
 #include <net/timewait_sock.h>
 #include <net/xfrm.h>
 #include <net/secure_seq.h>
@@ -887,7 +888,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
 
-	arg.tos = ip_hdr(skb)->tos;
+	arg.tos = ip_hdr(skb)->tos & ~INET_ECN_MASK;
 	arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
 	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
@@ -1033,11 +1034,17 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	local_bh_enable();
 }
 
-static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
+static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb,
+				enum tcp_tw_status tw_status)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
 	struct tcp_key key = {};
+	u8 tos = tw->tw_tos;
+
+	if (tw_status == TCP_TW_ACK_OOW)
+		tos &= ~INET_ECN_MASK;
+
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
@@ -1080,7 +1087,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			READ_ONCE(tcptw->tw_ts_recent),
 			tw->tw_bound_dev_if, &key,
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			tw->tw_tos,
+			tos,
 			tw->tw_txhash);
 
 	inet_twsk_put(tw);
@@ -1157,7 +1164,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			READ_ONCE(req->ts_recent),
 			0, &key,
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
-			ip_hdr(skb)->tos,
+			ip_hdr(skb)->tos & ~INET_ECN_MASK,
 			READ_ONCE(tcp_rsk(req)->txhash));
 	if (tcp_key_is_ao(&key))
 		kfree(key.traffic_key);
@@ -2178,6 +2185,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 int tcp_v4_rcv(struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb->dev);
+	enum tcp_tw_status tw_status;
 	enum skb_drop_reason drop_reason;
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
@@ -2405,7 +2413,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		inet_twsk_put(inet_twsk(sk));
 		goto csum_error;
 	}
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	switch (tw_status) {
 	case TCP_TW_SYN: {
 		struct sock *sk2 = inet_lookup_listener(net,
 							net->ipv4.tcp_death_row.hashinfo,
@@ -2426,7 +2436,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		/* to ACK */
 		fallthrough;
 	case TCP_TW_ACK:
-		tcp_v4_timewait_ack(sk, skb);
+	case TCP_TW_ACK_OOW:
+		tcp_v4_timewait_ack(sk, skb, tw_status);
 		break;
 	case TCP_TW_RST:
 		tcp_v4_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd6515ab660f..8fb9f550fdeb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -44,7 +44,7 @@ tcp_timewait_check_oow_rate_limit(struct inet_timewait_sock *tw,
 		/* Send ACK. Note, we do not put the bucket,
 		 * it will be released by caller.
 		 */
-		return TCP_TW_ACK;
+		return TCP_TW_ACK_OOW;
 	}
 
 	/* We are rate-limiting, so just release the tw sock and drop skb. */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 252d3dac3a09..9beba4dc2f42 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -997,7 +997,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (!IS_ERR(dst)) {
 		skb_dst_set(buff, dst);
 		ip6_xmit(ctl_sk, buff, &fl6, fl6.flowi6_mark, NULL,
-			 tclass & ~INET_ECN_MASK, priority);
+			 tclass, priority);
 		TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 		if (rst)
 			TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
@@ -1133,7 +1133,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	trace_tcp_send_reset(sk, skb, reason);
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
-			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
+			     ipv6_get_dsfield(ipv6h) & ~INET_ECN_MASK,
+			     label, priority, txhash,
 			     &key);
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
@@ -1153,11 +1154,16 @@ static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
 			     tclass, label, priority, txhash, key);
 }
 
-static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
+static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb,
+				enum tcp_tw_status tw_status)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
 	struct tcp_key key = {};
+	u8 tclass = tw->tw_tclass;
+
+	if (tw_status == TCP_TW_ACK_OOW)
+		tclass &= ~INET_ECN_MASK;
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
@@ -1201,7 +1207,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_tw_tsval(tcptw),
 			READ_ONCE(tcptw->tw_ts_recent), tw->tw_bound_dev_if,
-			&key, tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel),
+			&key, tclass, cpu_to_be32(tw->tw_flowlabel),
 			tw->tw_priority, tw->tw_txhash);
 
 #ifdef CONFIG_TCP_AO
@@ -1278,7 +1284,8 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_synack_window(req) >> inet_rsk(req)->rcv_wscale,
 			tcp_rsk_tsval(tcp_rsk(req)),
 			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
-			&key, ipv6_get_dsfield(ipv6_hdr(skb)), 0,
+			&key, ipv6_get_dsfield(ipv6_hdr(skb)) & ~INET_ECN_MASK,
+			0,
 			READ_ONCE(sk->sk_priority),
 			READ_ONCE(tcp_rsk(req)->txhash));
 	if (tcp_key_is_ao(&key))
@@ -1747,6 +1754,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 
 INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 {
+	enum tcp_tw_status tw_status;
 	enum skb_drop_reason drop_reason;
 	int sdif = inet6_sdif(skb);
 	int dif = inet6_iif(skb);
@@ -1968,7 +1976,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	switch (tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn)) {
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	switch (tw_status) {
 	case TCP_TW_SYN:
 	{
 		struct sock *sk2;
@@ -1993,7 +2002,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		/* to ACK */
 		fallthrough;
 	case TCP_TW_ACK:
-		tcp_v6_timewait_ack(sk, skb);
+	case TCP_TW_ACK_OOW:
+		tcp_v6_timewait_ack(sk, skb, tw_status);
 		break;
 	case TCP_TW_RST:
 		tcp_v6_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
-- 
2.34.1


