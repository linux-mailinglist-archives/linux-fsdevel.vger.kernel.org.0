Return-Path: <linux-fsdevel+bounces-32524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7099A9270
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 23:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2DD1C21EDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171F21FEFD5;
	Mon, 21 Oct 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="F5+jz30F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4951FE0F2;
	Mon, 21 Oct 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547970; cv=fail; b=nHB2u+ID0YM+3N2nG7MbIxoIeramdnIYMyEThOjvKMQnKh1V/0sYeFV9UyX3adAeef5Ny0VkSeo6dNXO+Fuz14x5Hq/POc+e/IrHexFH7ts5RrQ3m5bl+FBT2C0oQg8TC0JVsiUpA2jdHrVBLO9DAOtm7Jxo3kU8FkEJYahzG0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547970; c=relaxed/simple;
	bh=iqP4Lrn2Z/fBm0RWoUJbIosaP4CJmoZQtGIJjWwHjO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvDutqvQFdXOx7Kg4SItLPEHzwLgElj68aJSxBfxj3bRb3dwi/Hc4KhtROm8shIlGiR8YqFGmekT6xVaeeJ7UVTOm1MHUrMQ6OiMXmD2ZJws7X2Srbs4F9VSVPQxwaofsPrTPFQhW3DtZflwTNlu18/FuV1o8VjylBFvS15tef4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=F5+jz30F; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faCRTco2xY5YLG2jqvm90V+RWUKCFLBkiFvnBiqhFlGegwqYfsJ/y0T3+tTIiTS5eqyqY6XJygRMIQDpxr0lDByYl/TIcNZz8qZcdfzLb0KEhHRh+FAQgy3zQ+bKuujdlWWR1wkNc4Ei3PW/8uakGrK2TYIxOMtIh+BgThZdTVZ5lth/0hQpQME1VXIllwox53jQOh2rHTxFihfC4d0M56yaC9lbzu7w1Dp1iN8lV4FtinOWJZsiQKNvlP8VB7uG3mID8PDbA1MKTgO4IgoKKVZk4KL2gGQ7PaNWMamAA09lC2LtyGJiVKh9QXpcMyf5f67bNc3cg5i9M3kLFAG3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qap5KOTYkSn3sw5d0xLoait3kFngQIXe3o0O4mhxPZA=;
 b=FET7T0MHAFNENrb8ATCS8AhBIPaImRT8zxElQs2F2NxOaKGH+ZBI2eNVUOLDxCPwzsuiSoOt7t145M0GDKmcIho7zBWeG2bkth750q2ZO9qMxJuwFf5naYTIG2hxLr89xwLohr6sjc65slgvJklX85DFOHhfRu5oyGlX7tT6Q/UxLlf3r7Gkep1sjZwAJRHNrc6UhVPfBMpMceKAT83N9w+2lyGpKjqkdWUqxDdjrP/czKEgxotDpr3xkGhiZKfpbkDIQ+n0+ewcUji1qSZxkg4yhMHPOun49ruHwKHHibUvdmrtur0vk/KoSPM/KJeHhn4L989sNkl5L+iUBgQoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qap5KOTYkSn3sw5d0xLoait3kFngQIXe3o0O4mhxPZA=;
 b=F5+jz30FD9Hjy0UOwHPmZHHXDIPCphm7Fl2E6+nnprL/OMKWp0GyYStslUSOCju162O77g2CurJZnRCqk40o9HivPksQSDDRf86rt3WfCOGRAI7UxuCOW8RXlgnJBgNrs0r2bE1Yp8CFIAkiHECWrS1sdVt1AMYCD3m1+K00yiRWsw5EbayW3RWwAvYj3feHC4yiy+99SAPwSEBoq4c/XSaqZsWqsYC1fWx3oCyWrOPwTKELWvQkHZil/waMvHOjROshSBisEeOZWA4eFHRz68sx9hmUPTVRH+ecVWgvfabtW+1wvzMGD0CYY4GW8ZTPo0PufqBHZhRNkPuAZ2MLbw==
Received: from AM0PR03CA0080.eurprd03.prod.outlook.com (2603:10a6:208:69::21)
 by PAWPR07MB9324.eurprd07.prod.outlook.com (2603:10a6:102:2f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:59:23 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:208:69:cafe::4d) by AM0PR03CA0080.outlook.office365.com
 (2603:10a6:208:69::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:23 +0000
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
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENI032273;
	Mon, 21 Oct 2024 21:59:21 GMT
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
Subject: [PATCH v4 net-next 01/14] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
Date: Mon, 21 Oct 2024 23:58:57 +0200
Message-Id: <20241021215910.59767-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|PAWPR07MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 161c7a1f-a8a8-40c1-c263-08dcf21b9fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1cwL3NNSDdVdHNjck96S0x2M3RyUmlHYnNIZHF1cUtPdnh4SVZ6MUpzNmNq?=
 =?utf-8?B?SUV5UzVkVHlCMTRadVdPZ1NKMittWHkvNThCSUNlR29MOWdlUDRLSDlzZHg0?=
 =?utf-8?B?N0lHK0F1UEJJVzdveFlqOURRaDhhM3NtRVlTMkRpalBTRDJTc0tjZm1lQk0x?=
 =?utf-8?B?c3QrS1Y2MEVGUkQ3VTUyTThiTnJ3VGlDSDkxZm01QmM5d1RncDl0RGtXV1pR?=
 =?utf-8?B?SEVkZm4wKzlFeWUxaGF5YXdmMVRmWnE1TXEzOHphMFFILzZJOWozbHBsYW43?=
 =?utf-8?B?YW5ITkg1UkdhSlUxcEU2QXpwZ2tGUzVpaXFLTmJTWEpUQThIc3NPbjdOOWlQ?=
 =?utf-8?B?M1JQNHZLZnJZbGNJU3JxeWp4eUlMV1hKN0FwVzVDN1hDMlkvWm5DM25Sc3RP?=
 =?utf-8?B?VUU1WnQzd3pOTDh5ZnNkK0VUVDlXMDhldmgxMGQ0OWhyejNLdkxhc1ZNZW9h?=
 =?utf-8?B?a0V6bTVmc2NHck1HRjcrdm5xNzd3REtRU0hUdW5iTTF5N0FOUjhEOEpiNUhn?=
 =?utf-8?B?M1lGVEg2Q0pIeCtIcmZlK0NmTWdrL3RNUENKWVlRSzVEUnI4aWluKzVnMi9z?=
 =?utf-8?B?MnVmdnR2R0lMckFpV3QrTlNJU21rR2dQY21hUERBY0FCVkdCMlJaM2w1cGZT?=
 =?utf-8?B?MjE5WFN4bDJ2M3ZJN3IrTllMc082VWZZbzdES2ptclAzdXQrejhKT1Y1Z0c4?=
 =?utf-8?B?SkM0aWoxenNHTnZEL2JjOThyVHBRbGF5d0Y1dTlMVW1ud0MweUhJTVJlNmYx?=
 =?utf-8?B?OVVnbkprc0Q3cXljUUpkaXFhMkV1ZlZOcFpQNndGTzR3OERVZmQ5OW85Mjll?=
 =?utf-8?B?bEwyUzIyZjc4emQrZFMvTlphRGdyVE4vNmU0Z2l1dzVrV011Z0l4RU9DVDJH?=
 =?utf-8?B?ZWl4di9HRjRyZ0JSenRscDhlcWgyczZxY0pxRGdMMi9JTG1XV2hpVmpycE9x?=
 =?utf-8?B?a1lwUFpNOVhqT2dBZzU0aTVzT1JlankraU90bFdSemFobW00cTBRenNPMDhL?=
 =?utf-8?B?T29yeHlGZ2RIVFZBN3dDREFKeDVRWFVvSFhXcW1ZSXRkSmRKV1BLdHJwSW5w?=
 =?utf-8?B?T0xqRTYrTVpla2FxenIvQmZWUTJ6UFNRMWJDY1hqdWtCL1FXZ2RDWnFlRXlo?=
 =?utf-8?B?ZE8zTlhCbGt0Y2xzeTNnVE1VbmI5QlhaVEVhbWVKSTg3Z2JSbDBnY2ZONElj?=
 =?utf-8?B?Tmg1anl2b25RL3I0K2tWZVBrYzZsNk8xZEprNTlTQ2RvSXROQlVJT1UreUhi?=
 =?utf-8?B?UFpUZWVmeWZjZzZwWDBTblBlclJqTGVyWUFZb2U3bG1jeTNJd0VFeDR3Z2pL?=
 =?utf-8?B?a2JHTktoeXZDUVJ0aVBSbmNrUDhhV1hic3pyQXZVVmw4U1Z3NTBXQzBPU09t?=
 =?utf-8?B?ck4vc2dVOThOcHBUVDBQcUNSajkrSE8yRGFsVmo2K3V5dUxWcDhhNEpEYnh1?=
 =?utf-8?B?SndkRjA0bjJIc1BtNHR6bzYraENKMVFqRldWVDhVZ2JNQU8xYm53Y3RHaC9J?=
 =?utf-8?B?Q3FNQmJzdlR3b3VSZ3BVK0o0WUk5NzFPNlluOHVQRXlYQ1NnWTJteG5KME1G?=
 =?utf-8?B?ZFBaZlFXNlJFMUlmWE5WSzZxWC9XTHRhaW4vYjdHc1R1VS9kZzllRW1paXMz?=
 =?utf-8?B?QmVsakFpVEdXeDRBaDExeDZNV0c2MlZJSHovUE1iVjR2N3Nwb1dvVnFqb0FP?=
 =?utf-8?B?RW9DNnNlWnFQRXh1VWRPY1BBYTdKbEU1TFYxcW9oTGoyZ3VMTEx2bHNmeS9X?=
 =?utf-8?B?cTF3RkhheXoxS1RyZndiUm9vQmRBY3BVRlR3V3RsOHBONGVWSkpOblprS2FT?=
 =?utf-8?B?NXB0VWt6bm5HR01pUWdmNzdwcnJyOHpZa0RDN1JZb2xMazFnZ1lvdlVKdzR3?=
 =?utf-8?B?cHMrTnArNVRvRzV1V0ZKQUt4d0hsS3EwN28zbi83TWtEWUFydWl5Ty91R1dm?=
 =?utf-8?Q?7f1bIPjte4o=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:23.5415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 161c7a1f-a8a8-40c1-c263-08dcf21b9fa9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9324

From: Ilpo Järvinen <ij@kernel.org>

- Move tcp_count_delivered() earlier and split tcp_count_delivered_ce()
  out of it
- Move tcp_in_ack_event() later
- While at it, remove the inline from tcp_in_ack_event() and let
  the compiler to decide

Accurate ECN's heuristics does not know if there is going
to be ACE field based CE counter increase or not until after
rtx queue has been processed. Only then the number of ACKed
bytes/pkts is available. As CE or not affects presence of
FLAG_ECE, that information for tcp_in_ack_event is not yet
available in the old location of the call to tcp_in_ack_event().

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 56 +++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d844e1f867f..5a6f93148814 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -413,6 +413,20 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
 	return false;
 }
 
+static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
+{
+	tp->delivered_ce += ecn_count;
+}
+
+/* Updates the delivered and delivered_ce counts */
+static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
+				bool ece_ack)
+{
+	tp->delivered += delivered;
+	if (ece_ack)
+		tcp_count_delivered_ce(tp, delivered);
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -1148,15 +1162,6 @@ void tcp_mark_skb_lost(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
-/* Updates the delivered and delivered_ce counts */
-static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
-				bool ece_ack)
-{
-	tp->delivered += delivered;
-	if (ece_ack)
-		tp->delivered_ce += delivered;
-}
-
 /* This procedure tags the retransmission queue when SACKs arrive.
  *
  * We have three tag bits: SACKED(S), RETRANS(R) and LOST(L).
@@ -3856,12 +3861,23 @@ static void tcp_process_tlp_ack(struct sock *sk, u32 ack, int flag)
 	}
 }
 
-static inline void tcp_in_ack_event(struct sock *sk, u32 flags)
+static void tcp_in_ack_event(struct sock *sk, int flag)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
-	if (icsk->icsk_ca_ops->in_ack_event)
-		icsk->icsk_ca_ops->in_ack_event(sk, flags);
+	if (icsk->icsk_ca_ops->in_ack_event) {
+		u32 ack_ev_flags = 0;
+
+		if (flag & FLAG_WIN_UPDATE)
+			ack_ev_flags |= CA_ACK_WIN_UPDATE;
+		if (flag & FLAG_SLOWPATH) {
+			ack_ev_flags = CA_ACK_SLOWPATH;
+			if (flag & FLAG_ECE)
+				ack_ev_flags |= CA_ACK_ECE;
+		}
+
+		icsk->icsk_ca_ops->in_ack_event(sk, ack_ev_flags);
+	}
 }
 
 /* Congestion control has updated the cwnd already. So if we're in
@@ -3978,12 +3994,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		tcp_snd_una_update(tp, ack);
 		flag |= FLAG_WIN_UPDATE;
 
-		tcp_in_ack_event(sk, CA_ACK_WIN_UPDATE);
-
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
 	} else {
-		u32 ack_ev_flags = CA_ACK_SLOWPATH;
-
 		if (ack_seq != TCP_SKB_CB(skb)->end_seq)
 			flag |= FLAG_DATA;
 		else
@@ -3995,19 +4007,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 			flag |= tcp_sacktag_write_queue(sk, skb, prior_snd_una,
 							&sack_state);
 
-		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb))) {
+		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb)))
 			flag |= FLAG_ECE;
-			ack_ev_flags |= CA_ACK_ECE;
-		}
 
 		if (sack_state.sack_delivered)
 			tcp_count_delivered(tp, sack_state.sack_delivered,
 					    flag & FLAG_ECE);
-
-		if (flag & FLAG_WIN_UPDATE)
-			ack_ev_flags |= CA_ACK_WIN_UPDATE;
-
-		tcp_in_ack_event(sk, ack_ev_flags);
 	}
 
 	/* This is a deviation from RFC3168 since it states that:
@@ -4034,6 +4039,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	tcp_in_ack_event(sk, flag);
+
 	if (tp->tlp_high_seq)
 		tcp_process_tlp_ack(sk, ack, flag);
 
@@ -4065,6 +4072,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
-- 
2.34.1


