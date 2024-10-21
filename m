Return-Path: <linux-fsdevel+bounces-32537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E50B9A92C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1548283AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3532038BC;
	Mon, 21 Oct 2024 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tILYPKtA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B42202649;
	Mon, 21 Oct 2024 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547988; cv=fail; b=TxUI5YkHapS/gyhnoTcVbx0wwVpm6mlIyisn6Hl2aeEX7gJl8cwwDjhSY+iHp7mmYwm1rHgOKx5o90y01MozJvn8iehAgCM+qV8SMSg4GzeNgNdORKSl/8Zk33LjmVk6YvivSQnY8nITIrq1ZiqZHZbXP/MvVf7Z3IHolCbAhl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547988; c=relaxed/simple;
	bh=InWE5VdTYS9XAJEJCLoyUYuoVX/6u3C5uYfgEWK3+zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uc+XZ/3D3+869nKcwt8FcNtnENL4Bfm/2MzwyawMuOzIZWa44rEPbaQtDI/oLF/d1VigEN509FiLpS6RDMaFh4TP/GCK/3LNWKj2zGoYlZXK0+ONUSH0UMeYAPxNX2+zsu12l+/ayU6uuhBlvs0w09rwv8l/GIk/PGywAM0chfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tILYPKtA; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asSQa+8d7FPJFisgMc8giGZb4zZojVXz44Vw0nHf0S19jYOGw6gnsr1XFEU8y3fqOrkpPEJ0SOxUwOdaO7mxWj4w2qT2wm9fm3wD3c+rq6Z35EbXQJ/JyRc9yG/o9TwjY7YGhQhVwf605R4wTE1bXFU7xs9DBVftPerkiG+8kVF52LY2FJllbVJSQ8OsywezAQUYeScm09vljYLZyDXxaPStBzjlpuv+jdrHED3kdgO2J759ZzLyF8dkrbHPJeOnPbIXPNbdinaxMb8qM7/kS9L4j2JO3jMGFzCW3A191YpkfdmlbC3rI18T07kBXFJnQU/HARiPaYQtoMP3q/1UUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjtUDDwqSBTlN8GJJ93JAg7mvHQQiZNwgPW34th73Ss=;
 b=vx4REsqNhrUVUCImLt7gM/WboWx95h07FqA/fqgK/ETSj28eiQiR4VTcxJr0qA7JCNHgE5vhYDQDMX+Izj+3idn+VYPwH2ihDbCwSPu9i4ANG6o8IAwfTijJ1WZaGNcOvMON6ywoMIvP+GVoT5rkYF0vXG1WcXae3f1NoVx2/duTdgNTuYm8JUf+3yshBdMHh3zOvXS75okog8aJuv8Xey6tf5X68QG+MOgtjdvl9NlPpBTk8e5sWHSRdiuh+IGLjg2y54B6ozxDPV60XMt7dNBfEzfACBUDHwUQ7rtYvGQImF7dl3RlUmbt7zv2uNwwXAdtn34NkgtHmUxSh64SAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjtUDDwqSBTlN8GJJ93JAg7mvHQQiZNwgPW34th73Ss=;
 b=tILYPKtAvucywIigfWJhQWi0knIp2ymRtQCFyB0os45r9TYwe0AF+XmjwJ33IPH1Kzc0M2WhmUU1gr0pwfslrlppCSPxfPsLa07ZqpzyZ9dST3o4NqP68UZZldMBhjcrd7kTdWHBIFOxTOA6fk4fvUImk9puloemr7Fd9yty3wizjMq9q32rfG5pdO4WWdW/yJKwoZVTWsd1bRGlS23xXWXERFH+OtsI2djiIq5IsbCxu9Z5p7sBZW6DRu80lJFcEowf07/96AvUYiEiqiSRvya8p8WsXPWBg/73elBdx0p3Smb8b9qGQJXeuxJLo99DDRzHr4yQwIsDOvVbq6jjfA==
Received: from MW3PR06CA0027.namprd06.prod.outlook.com (2603:10b6:303:2a::32)
 by AS8PR07MB9495.eurprd07.prod.outlook.com (2603:10a6:20b:633::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 21:59:42 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::a3) by MW3PR06CA0027.outlook.office365.com
 (2603:10b6:303:2a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENU032273;
	Mon, 21 Oct 2024 21:59:37 GMT
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
Cc: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v4 net-next 13/14] tcp: fast path functions later
Date: Mon, 21 Oct 2024 23:59:09 +0200
Message-Id: <20241021215910.59767-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|AS8PR07MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a863bb-d6f0-4260-1b21-08dcf21ba8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnNxckFNc0tkditWZnRkaXB6MVV2aWt0QTlzbDN4OFV0bXUvaWdFbitjV3E0?=
 =?utf-8?B?aEdaMkZieXVqRkZkNmF4ZnVMT0xaVE1vdnMrL0dYNDJiMjc0ZnJWUWVUSlhS?=
 =?utf-8?B?dGlmeDBhVFkrTmxYdUVNeWY1UDMrcjRmcW16VlJLR0NDVnptVGM2Rk1nZ1Ur?=
 =?utf-8?B?TjdqVCtaVFZjdEN3V2s1UjZnbnFaUjRnSkRBcGl0NUVTVk1XeUFramYxZk5P?=
 =?utf-8?B?dGtsdWdHa1hJam83b1B3UG9UdHRGMlI4S0FMSDF5M3VJVm5vc0JIY1QrU0Nn?=
 =?utf-8?B?eVVIU1FjTkFvSHIyMmFKa3c5ZGJldUtWSTRCVTAwVHFPM1RQWkVVZlZjcEJx?=
 =?utf-8?B?VWp1ZFEya3VhaDVENkJBTTRKaUM0WC94WDgzMERVRVMwZkRpaW5Yd2xJVG1X?=
 =?utf-8?B?Y09FT3FaY25IaEwxU2s2VGV1bWhZc1g0SXV0Y1hhQ0xKYUZFNThyanhOUjhI?=
 =?utf-8?B?R3RxWnc3NkR2N3E3S29nN1VCdGoxOW9xWUgxY1VVd2huNFRsSFhXdkY2blpa?=
 =?utf-8?B?OWxMdldVQ0svbFVVNjZVdm9ldm5idnFRS3VNZFV3MDRScDBxcVJGVC9kUHd2?=
 =?utf-8?B?czJqZ2JjaVkwMXJ4OHVTbHBMa0Y1akhoRGlOZTdVblJEQnBjNXRGNmg0eGdD?=
 =?utf-8?B?S0EzY1hMaFN6cFUxbmZXR05XNmFLN0hkRDBtdWEyUHBXZ2ZWbGRyM2FvMmpw?=
 =?utf-8?B?SVc1ZUNCODh5VEJMczJtSkU5M01EdzU1eWp1dnVVRjJOelhFVDlmd3JDODN0?=
 =?utf-8?B?TkxwTXIrNDlGOHA1NWdGb1R4cXdGemJUMkdqWWpML1ZHVlFXR0l1djgyQTQ5?=
 =?utf-8?B?RG82UnpST0V6c1ZDYTF5ekhXMVNOeW9uWlRHZklVbU53YzM3NEs5eXRCMXBr?=
 =?utf-8?B?VUlyZmp4eXM0VXdIMzRQVWdvWTNiYm4rWHp2YTd5MkdRY1hwa3V5ZkllNWtz?=
 =?utf-8?B?dWdrQWpFWTBReUJRMEx0K0hxelRZRXlCTVBhWnR2c09DZFV5NHVkbloxTUY1?=
 =?utf-8?B?d0tTbTdidDFrRk1UOVVob3g2Q2t2bEsyamo2QkZuc1ExVWxjVGR4WXMyYkpW?=
 =?utf-8?B?WEFSQ2UrbWxLUHQxZm12OXZWTUpWQnZSdGhwS0YyMWhaU3Z3bkhtZ1JNcDBS?=
 =?utf-8?B?MkhreUhiV1VWZlRyelRwSDFmR1JKVVFmUnpueGtQcURzdCtReHI0UEM0amdi?=
 =?utf-8?B?V1FZdk5vK2p2U0FrNjZHNzc4Y1E5NzVZcGlncWNyVmgvUHBNd0xlRVdpcGFm?=
 =?utf-8?B?YkZSc0haT2tmcHVXVjBxckhIa09NNHpjajhFSVpjdDhmU245c2xMU1hjeXZC?=
 =?utf-8?B?NWhhVEpCdDVxUmtveFBtSzhqckZhNE5wSTJvTDV1WHFSYlBPMWxvK2xhbWc0?=
 =?utf-8?B?eHpxTWpOc3d3MWtBREJLbTJrdjZjbTlpUGhZSUx0TGFqWjdsMmtSeUQrZjZM?=
 =?utf-8?B?TzFwcGt2bUM5cjhidjBIenYwdEV6RG1jTXVFczNvNm9odjlJRWxENnZoSWFa?=
 =?utf-8?B?TDZBMTVodXpKdDdkYmMwT0k5MzQxakdsV2xpeHdCSEFhWWtyWDJXMmtlQk5o?=
 =?utf-8?B?MWVBbXRESUJ1eXdlc0NGRTQ5Z3kxZ2s4MmhEK3A5SGRtY01BSGQwQXlIUW9F?=
 =?utf-8?B?N3NVOUxKYVZjemlsZUlGMWdXMHRTN3pSeElqL1YxV1NoZmlDNEptRVdPT2dZ?=
 =?utf-8?B?Nk1GakpVaXdRM2w0Y2ZLdksvWW01cEFNbnA0MWl1eTR6cVg1T1l2SFN6dTJF?=
 =?utf-8?B?ZUhSbFBUK0RrVWREUUsvVjZKSGN4T1dLSVNCZnZlVWhVMFZTdjY1cWY1R21G?=
 =?utf-8?B?c0Z0eGNMdUl4ZmMvQ2JoM0tpOS91bnZXZDUzU1hvdE5ZYjhiU2VlTjJ3UnVS?=
 =?utf-8?B?RmkvQUVROTI2ZTRXUkZTdUh6ZGI5RmpjcEJRYnVzMHo5YjJBcGdnOFA1di9Y?=
 =?utf-8?Q?zH8P4RE+60A=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:38.9634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a863bb-d6f0-4260-1b21-08dcf21ba8e2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9495

From: Ilpo Järvinen <ij@kernel.org>

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 81efbe1195fc..6945541b5874 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -788,33 +788,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
-{
-	/* mptcp hooks are only on the slow path */
-	if (sk_is_mptcp((struct sock *)tp))
-		return;
-
-	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
-			       ntohl(TCP_FLAG_ACK) |
-			       snd_wnd);
-}
-
-static inline void tcp_fast_path_on(struct tcp_sock *tp)
-{
-	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
-}
-
-static inline void tcp_fast_path_check(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
-	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
-	    !tp->urg_data)
-		tcp_fast_path_on(tp);
-}
-
 u32 tcp_delack_max(const struct sock *sk);
 
 /* Compute the actual rto_min value */
@@ -1768,6 +1741,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 	return true;
 }
 
+static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
+{
+	/* mptcp hooks are only on the slow path */
+	if (sk_is_mptcp((struct sock *)tp))
+		return;
+
+	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       ntohl(TCP_FLAG_ACK) |
+			       snd_wnd);
+}
+
+static inline void tcp_fast_path_on(struct tcp_sock *tp)
+{
+	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
+}
+
+static inline void tcp_fast_path_check(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
+	    tp->rcv_wnd &&
+	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    !tp->urg_data)
+		tcp_fast_path_on(tp);
+}
+
 bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 			  int mib_idx, u32 *last_oow_ack_time);
 
-- 
2.34.1


