Return-Path: <linux-fsdevel+bounces-32525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C79A928C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14101F23196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997AF1FF035;
	Mon, 21 Oct 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qGuxgolk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2060.outbound.protection.outlook.com [40.107.247.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07021FEFA6;
	Mon, 21 Oct 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547970; cv=fail; b=utfEFO1drDNOH0XroBfvwdWwyGtxbmfroGi6AS+9xISU4lWe1D2p6F4Z51f5NyPhxZcWRUu4TKZ/+vZSY6WqPWbIWRybo+Df7+eGhjEA+YmODwr8Whfm+2UuYYZjspLHgcMTNnSPmweYKU4LCk9KiZovuR0S2J4kDhFAhdS5iPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547970; c=relaxed/simple;
	bh=2l+0M08yMRIC83lTUd/86nAvpRigHplf/lP3QuzUlvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKEHrlY377HEOn4KPiXjDBhMI41R1dlTNb+PzrjwiTTt+VuSzDQ5JVL8BH9cFHOQxxj9y41Za1j/+Oyaq4SZzi5nTxnMxSfUMiY5+8VVXcS9w3rXz/gUCUv3NOZdxhSZ10nHnqTmcfpcQO8Lz4tsewUyU4wIMOAsOQH2loRtUfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qGuxgolk; arc=fail smtp.client-ip=40.107.247.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHG2Mq+zASJrjlUq5YGryhv5VaTygSzVb2JMgoUqC4ZHjnlYvCUTfRzRY2xulRbaFzMf45qbbkxiCUS3CJycobddBY2uVhLJFvid7V0nOL4pyNMyBS4vgA+1FZvYRWEv7PPGDz9yZJH43xMn1fBCexdYEnfmeLP1q33/OMBAVsSjTGMYMk6eQYbqFuvu4vTRV8+qGcS+bn/rpFl8ziT+RfQRZ477YvDXmElGm1o2QEUOL1jFSLcmFParxUCRqxtEWdE74geG6wAt7NLzPqdeZBxSoxeUXPH8yEtbiad2pxfo9b8lLtvsieOwlcQM4el0MMnNMjjvXyEJ5hzmw8hE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKTmCLaruA7YxU3//jgcaHnUAmhqvJ/CfHbis01G520=;
 b=cc4CMMzZqBqa0NWWchEszKKDJMWtM2iUcI9KFDgwpFM7QO3PG9h431AWSJlpgxsPrRM1VwsuLihhR4YB6KIe4f1I4PRMU1bdR3HBMRT38bETKtI2OkZ3ma0MYCQTu6QrVWhMOXiUObPkcGz3NmYRkYEXcwlHHIohRXxJADTOI7+gcYnPxL6Yk33W+WTEG8MM20qSc/+3WluD/QX3Gkreeb8Z4usO6MM8GZ8d4lMtNlHxoaPFtyqfxHaOITeYljxG/yjwgwCWQC1lhlKJwq0AdhLDH3vSNzEDoWhVrD21bqAMEm6pJXsf+PGsbr1tsfhSOYk9WR8qg+72VeU1utuZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKTmCLaruA7YxU3//jgcaHnUAmhqvJ/CfHbis01G520=;
 b=qGuxgolkuOuOSzlEaCkPcAf8Arwc2fu1IuLjMaMfO49jy43dLJFAfr0gtiXGI1mdVbOCMeSNwDwxPnik1sWhOcxnHNt8o4CFUIFoS0iHtHu9ETF97Wv6TKJzZ1qsSLaVPKi0tFmjRrzstMgMysHJhrqjo4BtjPQoOU40sF7gM7LIymOw7o4WH/ShhspoPwQ66xs66D2bs66cVP6rD6FBriWjsbHZFGeVwtnkSGOt6dBkGuNDkqSMl+wt/hv7bfNbDd4QdO/pXWCNPaRsFgC+RIjpqe/z3rIUFgF0rH7UvdEWk4xkrIvX9IcV0Hp9lMVQZAKew9nS9a/DIKnlSZAV0Q==
Received: from AM0PR03CA0077.eurprd03.prod.outlook.com (2603:10a6:208:69::18)
 by GV1PR07MB10216.eurprd07.prod.outlook.com (2603:10a6:150:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:59:25 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:208:69:cafe::a0) by AM0PR03CA0077.outlook.office365.com
 (2603:10a6:208:69::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENJ032273;
	Mon, 21 Oct 2024 21:59:23 GMT
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
Subject: [PATCH v4 net-next 02/14] tcp: create FLAG_TS_PROGRESS
Date: Mon, 21 Oct 2024 23:58:58 +0200
Message-Id: <20241021215910.59767-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|GV1PR07MB10216:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd114ee-465d-453e-e127-08dcf21ba06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE9QWWk3UzdtWHhLTzJ5dVNNZ3VoM1BoL29EaUcwckRZUWUvVE1pMDNoTzNP?=
 =?utf-8?B?Yi9jZXlGeUp6Q3oyZUJwaGk5L3BJUmpobm4zYm0waE1hTWRlZXdlQ0FhQlhP?=
 =?utf-8?B?SUVJKzdJVXNrblQxZkJ3MnBZTnNlYUlQZzI1NTY5b2Z0R3R6N216SlNmMXVa?=
 =?utf-8?B?UmFybm5kUlIzNU5uamFiZlVJNkdHMmF3ZG9Bc21mSmF1WGZKVkdlVWNZTTNV?=
 =?utf-8?B?OGV3VTNpak1ocGFFVGdGTWtyeTMzQlNueUpMRGpCRUpXQWwxbHJ0TUczRUdm?=
 =?utf-8?B?UVJvaWt4VUZyVVE3WnJPUitKZVRCK29qQ2FPWmllbkVwbVJmSGhCcjVBblI3?=
 =?utf-8?B?MUNmUy8yMDF5a2RMNW1VUmg1VzZJWXdJMm9KRUgyblJvYnJFNXBEbVkxMDE2?=
 =?utf-8?B?eEFjOEY3NjlZeHJwYTEybldqb01iV0JBY1RKMzZsWnVxKzhhUzlQUzJ1YVRM?=
 =?utf-8?B?NnhDRmdMZ3c0MHFzS1RBazAydmFBY0FXUHMrQXRiMEFjR0Zhb2tkMys3U0xS?=
 =?utf-8?B?SStKZWdTUytnRlMxOEszMng5TDU2cndHdURmYjE2UU5YRTQxNGgzcSs5VVYz?=
 =?utf-8?B?djhzNUdONHhpOUI1enhvdFA2cE5XY0dMQW0yN21udkwrSkZleHpTUUovMnNR?=
 =?utf-8?B?cmtGQ1RxamcwVnNsTGpGaU1sOWhZWmdsUCt4ZjNpM0d3VVVFeDBYMzdyQ3ds?=
 =?utf-8?B?UnduT0pUOGVlS080RTB5RXkwekdXamNiVjhxbDlCazFZYlN1VW1nc0RVNVYr?=
 =?utf-8?B?dGNPZEtieVBhLzlwTXRQeVlnRmlRZnd6NzE3M0xBc0R5RW9nVkpWZTNtYlF2?=
 =?utf-8?B?bnlyUkpUckw5VUMzOW9hMHU5VnArZkdOaDhDZlpkREF5MDZaWmNMa3E0NWd1?=
 =?utf-8?B?OTI4QVhlNmhIalRmSG5lRk9qd0oyRTJmT2FENktLSWM2TmczZ3B6OXJ6NHhE?=
 =?utf-8?B?TWJWNEE5cWw0VEhaMXFnQjhZT2owRDVpZGRQUisxaCtNVDJRc1R1TURRV3hO?=
 =?utf-8?B?dHNlMTZYYjFpTzdZMW5HaHAwSjc4alJ4dDJ5ZWJMYUV0alRJb1pmVFFBenVB?=
 =?utf-8?B?dWhxVXg5L1BZZ0wwaWJFRlFHZjRRUmxJWVoxWkJQd2hVK2U0U0Y0VE9IMGpN?=
 =?utf-8?B?bGw4RWozUGtVMFpKWCtSNll3QWhlWU9Ic3F2R3FJV1VXa1d4ZHhHenVRbmVO?=
 =?utf-8?B?UEgrZUtnTjlldDlzRWc3ZysvMEhMbEdjRUlLekhkK2lWN2pXWSswejhnYVBB?=
 =?utf-8?B?eGR1MkhBZmVSUytneU0xbUVpZnhTRkJMZC9LRUJrZFVZSlRqajBjWXk1eVEy?=
 =?utf-8?B?MnJzMWhLVFA3amg5SkdMb3B3enVrTFZIMGk1YnRtZVJrMmk0SHZUWkJCNTFF?=
 =?utf-8?B?b1BIU2wyUVZYaXlWY0F0c2JXemM2Rnk2S2Q4SlVVbzlqRzFwMm1uZm9VRytt?=
 =?utf-8?B?ek9tQUxHdjZxSi9aMUlqZSt0U09vd0pYT3pBL3dJS2FsSmhvcGxBcXA3WDZS?=
 =?utf-8?B?cXVZeFo5K1FPY25IMHZhdW4yL3NnRHJIWHBjZmtiYzkvMGliZy9XeHVrL3Ji?=
 =?utf-8?B?UWxBUHRjMjJiNFY1eWhFMHFDRWlHSFEwNkJGRFJlYWdIeFBLYjNtd0dJaTg5?=
 =?utf-8?B?LzhibGwwbE9VWm1tNXpEVHpneFM4QkRpeWc5Ny8vYkNKS0JUVHB2bkRTUnFo?=
 =?utf-8?B?akw4VENsMVFjRHVSeGQxS2x1TlNMZ3BBaFFqSVhnSC9oNGp0ZkhzZWd6VHlV?=
 =?utf-8?B?Mm1UN0lxU2RUTGJIa2xNSjNvTzVMcWd4bVlxQ0NSOFJUZjA5dE1OME5WM05Q?=
 =?utf-8?B?Lytia1FNWFdDcWJEVEt4Mm5YSnF2RjNrVWIvalJEYzB2RjBKd09VMi9oVjY1?=
 =?utf-8?B?QU9GbWxmRHpQOGhBeDVxZnhrdThuYmNkaXFSam5YQ3cyS0E4VHI2YmdLaXJE?=
 =?utf-8?Q?gHnapTWHiAk=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:24.8071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd114ee-465d-453e-e127-08dcf21ba06a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB10216

From: Ilpo Järvinen <ij@kernel.org>

Whenever timestamp advances, it declares progress which
can be used by the other parts of the stack to decide that
the ACK is the most recent one seen so far.

AccECN will use this flag when deciding whether to use the
ACK to update AccECN state or not.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5a6f93148814..3295ad329aef 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -102,6 +102,7 @@ int sysctl_tcp_max_orphans __read_mostly = NR_FILE;
 #define FLAG_NO_CHALLENGE_ACK	0x8000 /* do not call tcp_send_challenge_ack()	*/
 #define FLAG_ACK_MAYBE_DELAYED	0x10000 /* Likely a delayed ACK */
 #define FLAG_DSACK_TLP		0x20000 /* DSACK for tail loss probe */
+#define FLAG_TS_PROGRESS	0x40000 /* Positive timestamp delta */
 
 #define FLAG_ACKED		(FLAG_DATA_ACKED|FLAG_SYN_ACKED)
 #define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
@@ -3813,8 +3814,16 @@ static void tcp_store_ts_recent(struct tcp_sock *tp)
 	tp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 }
 
-static void tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
+static int __tcp_replace_ts_recent(struct tcp_sock *tp, s32 tstamp_delta)
 {
+	tcp_store_ts_recent(tp);
+	return tstamp_delta > 0 ? FLAG_TS_PROGRESS : 0;
+}
+
+static int tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
+{
+	s32 delta;
+
 	if (tp->rx_opt.saw_tstamp && !after(seq, tp->rcv_wup)) {
 		/* PAWS bug workaround wrt. ACK frames, the PAWS discard
 		 * extra check below makes sure this can only happen
@@ -3823,9 +3832,13 @@ static void tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
 		 * Not only, also it occurs for expired timestamps.
 		 */
 
-		if (tcp_paws_check(&tp->rx_opt, 0))
-			tcp_store_ts_recent(tp);
+		if (tcp_paws_check(&tp->rx_opt, 0)) {
+			delta = tp->rx_opt.rcv_tsval - tp->rx_opt.ts_recent;
+			return __tcp_replace_ts_recent(tp, delta);
+		}
 	}
+
+	return 0;
 }
 
 /* This routine deals with acks during a TLP episode and ends an episode by
@@ -3982,7 +3995,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 * is in window.
 	 */
 	if (flag & FLAG_UPDATE_TS_RECENT)
-		tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
+		flag |= tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
 
 	if ((flag & (FLAG_SLOWPATH | FLAG_SND_UNA_ADVANCED)) ==
 	    FLAG_SND_UNA_ADVANCED) {
@@ -6140,6 +6153,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 	    TCP_SKB_CB(skb)->seq == tp->rcv_nxt &&
 	    !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
 		int tcp_header_len = tp->tcp_header_len;
+		s32 tstamp_delta = 0;
+		int flag = 0;
 
 		/* Timestamp header prediction: tcp_header_len
 		 * is automatically equal to th->doff*4 due to pred_flags
@@ -6152,8 +6167,10 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			if (!tcp_parse_aligned_timestamp(tp, th))
 				goto slow_path;
 
+			tstamp_delta = tp->rx_opt.rcv_tsval -
+				       tp->rx_opt.ts_recent;
 			/* If PAWS failed, check it more carefully in slow path */
-			if ((s32)(tp->rx_opt.rcv_tsval - tp->rx_opt.ts_recent) < 0)
+			if (tstamp_delta < 0)
 				goto slow_path;
 
 			/* DO NOT update ts_recent here, if checksum fails
@@ -6173,12 +6190,13 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 				if (tcp_header_len ==
 				    (sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED) &&
 				    tp->rcv_nxt == tp->rcv_wup)
-					tcp_store_ts_recent(tp);
+					flag |= __tcp_replace_ts_recent(tp,
+									tstamp_delta);
 
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
-				tcp_ack(sk, skb, 0);
+				tcp_ack(sk, skb, flag);
 				__kfree_skb(skb);
 				tcp_data_snd_check(sk);
 				/* When receiving pure ack in fast path, update
@@ -6209,7 +6227,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			if (tcp_header_len ==
 			    (sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED) &&
 			    tp->rcv_nxt == tp->rcv_wup)
-				tcp_store_ts_recent(tp);
+				flag |= __tcp_replace_ts_recent(tp,
+								tstamp_delta);
 
 			tcp_rcv_rtt_measure_ts(sk, skb);
 
@@ -6224,7 +6243,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 
 			if (TCP_SKB_CB(skb)->ack_seq != tp->snd_una) {
 				/* Well, only one small jumplet in fast path... */
-				tcp_ack(sk, skb, FLAG_DATA);
+				tcp_ack(sk, skb, flag | FLAG_DATA);
 				tcp_data_snd_check(sk);
 				if (!inet_csk_ack_scheduled(sk))
 					goto no_ack;
-- 
2.34.1


