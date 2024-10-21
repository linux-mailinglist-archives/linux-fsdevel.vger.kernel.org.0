Return-Path: <linux-fsdevel+bounces-32534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFAD9A92BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587E82839F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3B61C461F;
	Mon, 21 Oct 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Glmuc3dK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00941FE116;
	Mon, 21 Oct 2024 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547983; cv=fail; b=M7ZAEe8kdphcYzBm3XbmL0g4FNo2AjzyZpOEof/b3fv3LxfWjvdzWg12/xyqURggM37NHuzhTZMVsIOtMMuAFqrcSkMZPl/NY2zwju6j7zlu57N6+qbv13ma7aHi9aENDE6CLu1WQS2gSIUZxBfRl2n4JJKRM2Y8C+4Nhgp0vp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547983; c=relaxed/simple;
	bh=UtKvF2A85J1YpCN00/2xMK7AfJNPRzHn8FJ1Dc7Tiro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd7N0mziPoSIowRrx/5kAZ5iuvKbVtjnfDsJ2WKWVEhWcwUayCglcy+AIgSSG2hNZlTY+bXZg1NbYdRz8hjmuT+twR7WFpSrXY/7Ui6s6lSGdhLvSF4djkOnQqT6LTILDfCDVKZ3WC5rSmV7+p9VNHFYryGpmU2CEVxHGaEWJR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Glmuc3dK; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+6MgHZ4mx4P/Hr48+7RlkwUbLp02MemPtcRxHRyhqoukRQ2jspoVSEyYvUXmuRS2JpDWsYfLRVtEL45clezRmJwralfHjLgi6iMyqMxsbzaBDLdKNNXYfkZlgeSpNLvgHrHPdraDvEJug7vy/4oM/tbzKrqckqHXl7AA9x9VcMLEiXqyMUtz8/7/DbmegmBXq6EQOcDQrfLsXCo4uR+wJZs7OuoKdFVogxUeWOy3jnge/KOGlvfrVsvTCLpfcxjvsvLPszQRxjg8sGcGGksu12dh3D0Z2dDQ4cM4u9rfoDQ5jz3GSH9LVNcSheKuJBfoAB2LDYpIr1ZtjVWmvvfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evuwPAKFfK5xlB++jG+LcM/1cDYl6Tr3X2lvjgrTehA=;
 b=i5BmFgNCEKf2r6NwZ/4Z9NxeQ8WepWJaobyGa+Ph7B4B448ti4FT9Z3HXVTbCCvD4rBE5MJlWGWvez/jhRCA6KKryrk+BZpe+KhjM7n8wjlJzKQa2us+i2IdRpm02ZDyaqgKtg/1fa4FlPt9sw0YjA/+/yX5KXY5VDqq1vcGN7/v+iD7bTqi9QDV/lpOQGqWhaX27aJV5bY3XK7L0G6wx5Ezq5mq6BbrMv2p45wkIs9bPgGv48xDi39sKmCp0kwEanVR4jP2EVISLlN2zoePaelcWruMEYr9bPMDW9GtWGNn4nn+HoxKNBkSFexezXW61nDNdTHje7i48GHGfk/7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evuwPAKFfK5xlB++jG+LcM/1cDYl6Tr3X2lvjgrTehA=;
 b=Glmuc3dKtrUY8tXiB9cH11DX4GRfyGiXvDQkRoIg29SkUEEOZbzlbbLGa/V9kk8WJqf2NbpbJ84SjwilF/lTaMuHuKRFbo5z2zK9LkFLJf1dk4s7bD49fkNFK1sax7jYoNdNl+zQbLtnJ41Vpj9G8n2wd6aoQYJZQ/+Dxbq3uW+rluq3F3ztRpwoIXPPwePW63CTJjGMH2UxTcWKc7Dd7csbG+t5Upm8tKHUf3isZPDRAxud4gK5ME0mCk1OlqovP/j/NBbB1OJaU3+biG5jbZpFkGPwC1kqWvDYvHsAzra8EH2HNly9BsRnfuCPUaJ5Mxd9tsKrHTmD6H/zdUW0kA==
Received: from AM0PR07CA0011.eurprd07.prod.outlook.com (2603:10a6:208:ac::24)
 by DB9PR07MB7707.eurprd07.prod.outlook.com (2603:10a6:10:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:59:37 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:208:ac:cafe::e6) by AM0PR07CA0011.outlook.office365.com
 (2603:10a6:208:ac::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:37 +0000
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
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENT032273;
	Mon, 21 Oct 2024 21:59:35 GMT
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
Subject: [PATCH v4 net-next 12/14] tcp: Pass flags to __tcp_send_ack
Date: Mon, 21 Oct 2024 23:59:08 +0200
Message-Id: <20241021215910.59767-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|DB9PR07MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ae915f-d0e0-4348-5c9b-08dcf21ba807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUZXR1pWRi9VN0VwUDJmOXEvOUVxdW00VHFLajhsTTFFUGVyM2N0QlVKbDdk?=
 =?utf-8?B?NXd4VXd5ZCs4czljL0MvZ2IxRTJ2L2xzOGJyN1hpQzYvTFRpSjA0SnZxdEdG?=
 =?utf-8?B?RW53eUNaT3JTemFzbDZhRFdxOHNlMHNqVnVlVzdsSXVVcHl1Qlkxck9tZDUw?=
 =?utf-8?B?K016R0JFTGZqUUI5K0ttOHZydnFkamtkZnRKNWVDb3FseEc5Y2VVU1RkWHBt?=
 =?utf-8?B?M3drenVmK1hkZTFOcTcrMjJIUHpUb2FOTU9KdlJQRkZkZUZpRW1yU3I2R2pw?=
 =?utf-8?B?cEFxdmhjcU13VGV1RkdqY0FrME9ZZ3YyUklwSVltaFhsUVNVdHRpejhaRlAy?=
 =?utf-8?B?bmdFRm5DM3ZkZ2YrcVM0QTk4bGdrRzl1YUFCZEFsRmRaNWMxU3NrM1F2N0ZS?=
 =?utf-8?B?MXh1SGwzM2NyQ2pleVN3enlNQzRXSHFzQkphUWtKNTZrQU84Sy9zblJXRGRB?=
 =?utf-8?B?WGtDV2pVYVVXQ2tHRGZXSnVmL2ppYVE5U04zeTZvY1JBVC9MZlpHeUVTZGRx?=
 =?utf-8?B?ckVud1RtQURQcEcrZ1NOdzRhVG9rUHZYUDlKWjN6NVBBYXFWYm01aTZzSDlS?=
 =?utf-8?B?RFduaExwSWpsMkt0VmVqVjBQczdRNkJDby9qb0xDTGNnS1pvbjZidnREbVQ0?=
 =?utf-8?B?RmNVSFY3VkgyODEzdjlJM0NHTHdNYnFKMjgwanQ0WnRoZ3lKMUNJNmQ3UzR0?=
 =?utf-8?B?Uk9Ic1RIL2QvZ0swbkRqY29hM0YzMkNSNVNVNkJwdE9SaGN5Y2c3VUxaUU9R?=
 =?utf-8?B?d25tZ0l4dTdBeFF0L3hlRnI3dnh6ZXIwZ2JLWmlIYVVsWkRPdlRLektaUkYw?=
 =?utf-8?B?Rk9FRkZwOFFuRWlCMC96RGpWa0FvbGQybllZeHIxNTdmUXpxajZibkp3SC9y?=
 =?utf-8?B?Uld6aDJkVlVmVUkxc01kc0pXcHJuMlZuc2w3K0xNTUpvMW1LOFR2MFdsWVFx?=
 =?utf-8?B?T05xOHM4ZHp5MzNoTkJqZUFHbDFyYU9YdnRveHNJaDFuKy9pcnUyUWpuMkpI?=
 =?utf-8?B?NEdtYjB3R3o0dDRzdzh5UTFZNEFUR2g3dEJ3MXU4MklaZjB0YzZPNldRQk1I?=
 =?utf-8?B?aU01c0wwQXpmd2hHRi82WFFEVDc1TnJYSnFIQk4wcWJiZ3IrYzFYNmdUb3Zo?=
 =?utf-8?B?SnAxeVQvRlE4bU1lSE5GMHVkRlNZVWUxRzcvTUJ0UXROZXVkdmFNdHRtbVB6?=
 =?utf-8?B?dE0zNGY4RnY3bHYyQ1Uvc2JuaVlTWkk3Ui9ZZmRSN1crODRZQ0x3Qkk5aHg5?=
 =?utf-8?B?SDB5d2xqWU9Eck1jajdOMEsrbFMvSHpodkpuSHByd3h0U2ZJeW5wYStxTEdB?=
 =?utf-8?B?MGg3SFV1NTYrbzRMRHZEdFlkbVhJTktMZnVFVlJEcHUrMWdWUWFZTHpkZ1F6?=
 =?utf-8?B?T0tzV0F4MC93eEJvQmFGTlFPV0Z1YmI5dzkxeldnbzhxQ1p4ZUdtWUt4dk1R?=
 =?utf-8?B?UU01elFVVy9YY3pUMDRFVEF5Zm9MbHBLcmhIZmRWRzdWTWpYZFB6STYzM0hx?=
 =?utf-8?B?UlVxUWdQb0F2aDB1Rmxja3NkVElzRFI1bkNSOW83TlVXQlBFM0owZVRudDAx?=
 =?utf-8?B?Y3NGMXBsWTRoMi9jYUxtM2czczRSQmNZTWZ0MjIxZE4ya291eUtrc0dHb2w4?=
 =?utf-8?B?ZDBIbzFmc0ZzYnY2WWJHSEsxWXpZaFYyOEpDNkdCTGJMMEVybytVcEpkZXJp?=
 =?utf-8?B?SnJFNzJnRXNnN1Y2ZWxwRHNXNWZvR0xmVjR3UktySFc2MmdaV3dkUnMySVd4?=
 =?utf-8?B?dC8wUFpvTWFyeEIxaWxaelJ6Qncvd05Wdlh3VDYyd1RzVVBnQzZYZzQrQmtp?=
 =?utf-8?B?NXV4MTZ5c1I5YlBPUEVkTkJxSkZ3clhvMkg1MHNRelpRYmxrdHlBVnVDa3pE?=
 =?utf-8?B?TkVqSEltY0xvZUw3MWJTbE1wTmwyaTVFdkQyS2M0VERGUWxFOXF0Ym9qd2Js?=
 =?utf-8?Q?QqZyaDi7rhk=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:37.5611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ae915f-d0e0-4348-5c9b-08dcf21ba807
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7707

From: Ilpo Järvinen <ij@kernel.org>

Accurate ECN needs to send custom flags to handle IP-ECN
field reflection during handshake.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h     | 2 +-
 net/ipv4/bpf_tcp_ca.c | 2 +-
 net/ipv4/tcp_dctcp.h  | 2 +-
 net/ipv4/tcp_output.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d348ea9be172..81efbe1195fc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -704,7 +704,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 			   enum sk_rst_reason reason);
 int tcp_send_synack(struct sock *);
 void tcp_push_one(struct sock *, unsigned int mss_now);
-void __tcp_send_ack(struct sock *sk, u32 rcv_nxt);
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags);
 void tcp_send_ack(struct sock *sk);
 void tcp_send_delayed_ack(struct sock *sk);
 void tcp_send_loss_probe(struct sock *sk);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 554804774628..e01492234b0b 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -121,7 +121,7 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 BPF_CALL_2(bpf_tcp_send_ack, struct tcp_sock *, tp, u32, rcv_nxt)
 {
 	/* bpf_tcp_ca prog cannot have NULL tp */
-	__tcp_send_ack((struct sock *)tp, rcv_nxt);
+	__tcp_send_ack((struct sock *)tp, rcv_nxt, 0);
 	return 0;
 }
 
diff --git a/net/ipv4/tcp_dctcp.h b/net/ipv4/tcp_dctcp.h
index d69a77cbd0c7..4b0259111d81 100644
--- a/net/ipv4/tcp_dctcp.h
+++ b/net/ipv4/tcp_dctcp.h
@@ -28,7 +28,7 @@ static inline void dctcp_ece_ack_update(struct sock *sk, enum tcp_ca_event evt,
 		 */
 		if (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER) {
 			dctcp_ece_ack_cwr(sk, *ce_state);
-			__tcp_send_ack(sk, *prior_rcv_nxt);
+			__tcp_send_ack(sk, *prior_rcv_nxt, 0);
 		}
 		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bb83ad43a4e2..556c2da2bc77 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4232,7 +4232,7 @@ void tcp_send_delayed_ack(struct sock *sk)
 }
 
 /* This routine sends an ack and also updates the window. */
-void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags)
 {
 	struct sk_buff *buff;
 
@@ -4261,7 +4261,7 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(buff, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK);
+	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK | flags);
 
 	/* We do not want pure acks influencing TCP Small Queues or fq/pacing
 	 * too much.
@@ -4276,7 +4276,7 @@ EXPORT_SYMBOL_GPL(__tcp_send_ack);
 
 void tcp_send_ack(struct sock *sk)
 {
-	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt, 0);
 }
 
 /* This routine sends a packet with an out of date sequence
-- 
2.34.1


