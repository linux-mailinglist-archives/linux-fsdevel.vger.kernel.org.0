Return-Path: <linux-fsdevel+bounces-32529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818299A92A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA4B1C21B86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91773200109;
	Mon, 21 Oct 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aKxAd4AV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A701FF602;
	Mon, 21 Oct 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547975; cv=fail; b=TFL2k9UVAQXUztiV+zHw4bwcdmg+B75Cp83EDVz2P9cRKE7ShJEG4PcrWvQRwUAJ6a11edecxnBptlWDLJ30hMxWITIKLzu9hSDs8C2Rb5QFm5wD3AaAQB4kLifGy0bLXtUJwCAVdL1maTvbJ05lLqLz04fqfPh+TcJ1bwVlMPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547975; c=relaxed/simple;
	bh=leNo0xCGv0TXQfy4qiO/qvKzRlLq9lg72vGgsiq8lzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmeDg9Rqo63dohSIUewflfY9eryGg1Tu0rFxqv1ZNlbsDQwYzF9gU+joGiTMrzutAIoJ6ASLw1nKRSqHTJC5+xKuMuIMNp17PqZ1SEb1m81I3uADFn4kjapmXalgsnE0gPz9x9kCixBWHwgpMJNEtdmLkC0/AJ4NRlG7bwkwpEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aKxAd4AV; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufJbRzg2vgfW9/kS8HzZmU9t6XaHrfTORPgXO6pVSmcI0c8rPE4x0pi2W13a8NIqu8iZsKXQit/LOFV87G1beuLCoiMgywOFR28HzDgzhEtDLamR8qmUoqtqpiUGZi/VpGGo6hoYXuT8dK756vZ6UQu2YRMX+D+D8MOpKs/2bM9DGazyirQRMYM3Z5HywNPb5F43xcci/PdJ52r3GjEkTqXweI0tAaze6xZ/bNjLHxm2Y7ZQUqWCLNQxZFdDeGjJYNaxWsy83vPoBvecsc4buVsHEr7mju+9VdttVVrWHO6IBk/5G1bp4/wp4OEt3L2OVJyiUZpPtxWf3GmEAxJQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+js0Oahjt/6qHyBm7lGS43gfhHYb0NanOSfmUdzE98=;
 b=G0sA/wh50BySDtEhnBCjfUiyWrT4kuoB2kRmMijCha9iOc8mLAbsPbvAaaQqRs8JkUNCiWGSW0CaftU8czP0CWxntx2d+GnZv+c93in0AqVo/I5JZkhRFRoV/r9gfSNTIoXje7XeSp9iaMNXpyG2JVbABGwjtOOOX1gw8yBmz//zRyRkZfeFXfmuzCnnZ7AsgeacsUC7OOBsiFI8KC//E4HK5XjMfUevgr1lHcQv1X22DalZtMY1FcNvRYkQfJr+/WV59I6SqTvy1Mtj8mom5G3fkD2Hd5tlJU1ppJpw8VrCacrekFcP0LY3t8xxaGA/OdbxKfJGNOmka+76N5egYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+js0Oahjt/6qHyBm7lGS43gfhHYb0NanOSfmUdzE98=;
 b=aKxAd4AVsFZWlaG9SYgYDqVuyKVgk1qXMeMPPdS1Hk7wxlgtBL3YcK41PHggMcQ6npYWv4rYAgWTYVZt78HD6QEEO2OIeRU/NJlm3ubJxTFmwkX70UP2t3S/7u5+FUW5E7pz1TMGEuWk6oEKt+gNVJUlH/5Gchk53qucrmLW80R4gC4u8DwL0bADO4IOqtwh/uckzNwC0KQwrTyq7nArDtLCDuZCeHu4ITy01vZGnNQrgBJ5iH9DhKYT8ZQgsNae1nabsWKzUvBlFEvt3Cf8jjwyfvO5rhj16+W9MyEN1BgOIPL1exPEv0gDE0zyPZaMztDuXvr475W8VvCaS3qR6Q==
Received: from AM6P193CA0051.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::28)
 by DU0PR07MB8945.eurprd07.prod.outlook.com (2603:10a6:10:413::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:59:30 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:209:8e:cafe::9c) by AM6P193CA0051.outlook.office365.com
 (2603:10a6:209:8e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENN032273;
	Mon, 21 Oct 2024 21:59:28 GMT
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
Subject: [PATCH v4 net-next 06/14] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
Date: Mon, 21 Oct 2024 23:59:02 +0200
Message-Id: <20241021215910.59767-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|DU0PR07MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 62baf3cd-3777-41ee-72f4-08dcf21ba375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGFmTEl4Rzl5M1JYNjliQk1yREI0QWhSWTZaZDRKVXpoKzdSOHhDQUw1T0Vs?=
 =?utf-8?B?ZnNBWkRlUHlJekNiWHM0aXlJdUF6YVRkbWVkRWpZT252K1VNVjd0ankzTjll?=
 =?utf-8?B?WlFNeVl6MWVwT1lLWWdyTUtVMDhzTUEwcjZoYXE3V3NtWEhqVFJiOUMvT241?=
 =?utf-8?B?YkNZazdUak9mbzZPbVlPOUQyS3ZDQ1ViUU1LRW9sSVhnZDVhZjZ0SG5MQXM1?=
 =?utf-8?B?T3k3cUNRam9hWWdRanB6U2o0R3A4Q1JhYlRzZE1PYmNrSHJRMGliaXhkdG9B?=
 =?utf-8?B?ZTFhWnVVRnJ0aVc3ckNaNWZnUGlxUkI4NVg0UzJkYXE4bU9MZTZDa2U0SHht?=
 =?utf-8?B?dzRtdmxnMVY5SnJPSGRsODllSWxibTVYYWgydHFJVFpCSEpjNnRIUEd5SlZz?=
 =?utf-8?B?bzBVTVNBMlpra2w5UDZDOTAxMS9oS0NpbGdEaXYxWklZV2I1M08vMUlRcnBq?=
 =?utf-8?B?OTM1NHAyR3VvSFQ5emRSbjYrd1g1a1NydTI2NERiYlg2QzRFaVFjNXI3MU1o?=
 =?utf-8?B?dnRsa2p3VWNBU2pRWmh6SGxxQ3FMRjNjdEZ0NWNENUtJMC8xSkNMKy9vUElz?=
 =?utf-8?B?OUg0OVFpZzBLcS9lNkxKZVpQaDY3dGlzU3AxeEdxT3dZbGlIY0diWmV1VzIw?=
 =?utf-8?B?MlFuSnlDSllUTGNuY01KVXFRWjh1VUNqMzBtVGFDbG1XMHVPa3dPcGZpc2Iv?=
 =?utf-8?B?RlhzY20wTHhtUXRRRTVvcHZxa0Y4UDZlVFMwTlpxaHRWbnlma3BmZk4rbWYx?=
 =?utf-8?B?dEpNZ21vbnJKZStCaElyR3BhbXVRSEd2UWJwRi9xU0x5TnBIVkY1OENSOGpz?=
 =?utf-8?B?KysrQUVNc0ZqUENCRThjU0w3cXBlMlFDVzhlRjVjeEhGcVRJY1M3Skx6eHZT?=
 =?utf-8?B?T3UxYjhoZktnOE4ralZqUFFhTk9DdGpRc0tvYzFFcFdpUTRNQ045Q0Z6YlE5?=
 =?utf-8?B?OHo5ekNXSUJ1d090VnBjVFpUUHVuTVBkNXVNNXZrbTdra2FpaXJWY3owakta?=
 =?utf-8?B?cHl6dkg1bjRsc2dCdEp6enMxOXVTWjhpdE01TWQxb1prdFd1SHprQ0F4QnBk?=
 =?utf-8?B?WFpPVGxRSTRDVkpCUjdoMlN3MU00TklwdHhUd1BuT2tvcldBbG1CenNWazdR?=
 =?utf-8?B?MmtwcUJWeVZmdS80U0NWNFFqSm1TL0VZL1ZGaUZmbGtDRHUwSVBTZjNWbG9T?=
 =?utf-8?B?bi95N05zN1JleHhKS09VV0g1cHo4TGtKT2RxcHlCVDQ5bC8vOVcyM0V5b1Zh?=
 =?utf-8?B?bzdSZU9MUnJwTGp2dE0yblRnZm5qMGdLd1JrNFo5N09IQU9LdUxJZEJqYnA0?=
 =?utf-8?B?MTBCODZSMzVuWDRrdjJqNmlyeUxiSFREYjNwTFZ0bkplNkFoaHQ3dkxnM0NT?=
 =?utf-8?B?Kzc2Q2xoSG12N21VOXNlUlZEbFBoQXRrd0hCWjFJWFhxbi90MzZNZER2di9l?=
 =?utf-8?B?M3I2SW9JTHRtb2lLQ3JzSkM3UXFUMkdGV2l4UTIvQ1FxZk13endXQlBMeTQ3?=
 =?utf-8?B?M3VIKzk4b1FEN2dmV0RzNjVZM2xMd3plOTQwYmErTlF3VUZIVDRaQWVsR2NG?=
 =?utf-8?B?Zk0raTdyd1BhNjRvSzZpYWRrN0pJUU5sOXFUczdPeWhhWWI1ZW5icXJrNVUr?=
 =?utf-8?B?ajZnMndyZUV0UGtMcW9pL1FMQUp4YzloVXdZZzhpNzZnbnFqMG53MmJnUEsw?=
 =?utf-8?B?SWFQc1J0RmFGVVc3Tis3YlVyNTVsV2dSekZQK2JFUjdvWnBZVWh2MGcwS3BZ?=
 =?utf-8?B?ckE2dlRlS0xpYk43TW94dmZqUjlKaWRJVXVsZTVYSTk4Rmc0UmM5NEpDQjZq?=
 =?utf-8?B?MjhSZEtHbVA0R2FDVGhMWjU2b3Z6SUI0UkREWTRzcy9udFUwdW5CM1lSVnMv?=
 =?utf-8?B?ZlAxZmVURFdxcFFaVkJneHIxVzN1R1o1aGdMSGZlOUREUFVwOTN2VGdmL1FT?=
 =?utf-8?Q?QCq455hN0cI=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:29.9096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62baf3cd-3777-41ee-72f4-08dcf21ba375
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8945

From: Ilpo Järvinen <ij@kernel.org>

Rename tcp_ecn_check_ce to tcp_data_ecn_check as it is
called only for data segments, not for ACKs (with AccECN,
also ACKs may get ECN bits).

The extra "layer" in tcp_ecn_check_ce() function just
checks for ECN being enabled, that can be moved into
tcp_ecn_field_check rather than having the __ variant.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3295ad329aef..6d4abd452a36 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -357,10 +357,13 @@ static void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
-static void __tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
+static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
+	if (!(tcp_sk(sk)->ecn_flags & TCP_ECN_OK))
+		return;
+
 	switch (TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK) {
 	case INET_ECN_NOT_ECT:
 		/* Funny extension: if ECT is not set on a segment,
@@ -389,12 +392,6 @@ static void __tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
-static void tcp_ecn_check_ce(struct sock *sk, const struct sk_buff *skb)
-{
-	if (tcp_sk(sk)->ecn_flags & TCP_ECN_OK)
-		__tcp_ecn_check_ce(sk, skb);
-}
-
 static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
 {
 	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || th->cwr))
@@ -866,7 +863,7 @@ static void tcp_event_data_recv(struct sock *sk, struct sk_buff *skb)
 	icsk->icsk_ack.lrcvtime = now;
 	tcp_save_lrcv_flowlabel(sk, skb);
 
-	tcp_ecn_check_ce(sk, skb);
+	tcp_data_ecn_check(sk, skb);
 
 	if (skb->len >= 128)
 		tcp_grow_window(sk, skb, true);
@@ -5028,7 +5025,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	bool fragstolen;
 
 	tcp_save_lrcv_flowlabel(sk, skb);
-	tcp_ecn_check_ce(sk, skb);
+	tcp_data_ecn_check(sk, skb);
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
-- 
2.34.1


