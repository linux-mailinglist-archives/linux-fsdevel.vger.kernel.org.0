Return-Path: <linux-fsdevel+bounces-32526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4959A9291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94F21C21F1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE01FF5E8;
	Mon, 21 Oct 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="cK8hMJwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711E1FEFC6;
	Mon, 21 Oct 2024 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547973; cv=fail; b=MZkZeZCMgcEvJlKPxe21er4wJ0mO2f+uxM2jE72M+7t30ITJSMr5whryFKkjB2790ojgDiznD1uRHMvU0I5koqDyRwvlEBuNF2bjYuL8KOUMJbLJewgEP6N6QAA0CC9IGWi1V2L/58A5G4F1znNag17NbGhbJjGLEuqA5Vl6JSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547973; c=relaxed/simple;
	bh=VWfBnNyWjEH3XDaLA3UuMW35easf2rQkez0Pfq+GLhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdpUNcbrkgucokUAotAM3s1OAN8N2OReOmLxVYzMwUkC48lv1skRz7M9l5UiPIobdw3UTRpVelxnlufbvypCCK8jBPT1c5iCDYcUeCKQ59AD12ektYgZSZWNdfLDdW7GIwmZ42br00dtjWAEYh1wtxKhd0ZUHzLLVuY9iD2D8zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=cK8hMJwK; arc=fail smtp.client-ip=40.107.249.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFUFdRIwPg4wOBjCRfbADx3oU3Dq3XxHMtRiiPW9ACsZrg2bdfCZcmcm4VJ/tzihi1mZ4WKYekBb9g3eGtcrkq3I85C3+g1T6y295iYYZDMKZep1T6105YIbT/TWQAuJ/IlmDNzVvkt5PTvU89kVXCN5+iNk2ZTjf38gQypl1d+iJ+Xno1bOJALu8u7H34imhwfiyAvLGKBhCc9UlYTo4+IWl5Ri8Vquzs6ZX7T3mSbdkiA6dx3XR8bPpF2GT6ZVGpkOsgh00jZ9L4CzuksZfSz5BHS0goCkM8r4tzubl0KF8F6e2XM5NeHE/UrmEY8ImWv0DlywaADnBr2pzKT+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMx3u4H44x+CVsqgJMWoc4rn9lSzlzPywoG4I9GWyRA=;
 b=vTFn873jKjqv6erkyJIG0cVQfjlti9i/qhWrGD8No1Npn57SFQln9CcD1rFB74Zda5R/J+QZPIzJnj7+kz2aHdwVJBOTk1fntFqZHkfkVZ8+qCCQO3AQj0FdXkXkiJm6mLf41NXWLEiWmseFQf0ZJ3wYFm8fdiS8jvhtb3GorbrrYDlc9eLXeXXzrzN+dqVw1oho9Vj2I+W3Yrlzw9EcAAoaPfXftLQq+lhfR9R9vmCekww97e3W5lhCASE7Iv2K33u2aQnDmd+/ASkuVrnodwP79uOiH1vJq5LATC7aofv1n9Z5RlyPDN9SzT5m6tOkt36ybvnhDgou5xa6TIUoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMx3u4H44x+CVsqgJMWoc4rn9lSzlzPywoG4I9GWyRA=;
 b=cK8hMJwKyV/wx4gTHVmITINRLtbOx3KDn+G79Mi6PvQKxTZjZjEo7B2YSV/CgFdDS3sphSmde+f2hnK6N6XsXwgaVpJvYXANxaTimjdhKD89Yg0X5hfl8IN1kE6qWaV0FRd2DLE41ihWujWi25iOtLawhE3ir6lPh4nvFKbsJA0e4Buv4JfoeZBmjwj6Ro9diqN7KAgzbikK4R+HauU301UTFEK+ctdzko58VX7uKbHU9TgoyCgSubwq9uJwwjnp8dmYTRAPxqwmOzaRgqlrEtAJ/qRRmnPoJt/3zs2k20Gx4jZd9NXLjyE8PSVthKNbkCvkEeyXkp1P5Ib9Jbe+bw==
Received: from AS4P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::14)
 by AS2PR07MB9207.eurprd07.prod.outlook.com (2603:10a6:20b:5e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:59:26 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::6a) by AS4P190CA0022.outlook.office365.com
 (2603:10a6:20b:5d0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENK032273;
	Mon, 21 Oct 2024 21:59:24 GMT
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
Subject: [PATCH v4 net-next 03/14] tcp: use BIT() macro in include/net/tcp.h
Date: Mon, 21 Oct 2024 23:58:59 +0200
Message-Id: <20241021215910.59767-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|AS2PR07MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2861ee8b-38ff-4dcd-d262-08dcf21ba125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1FyVVhyUWxaQUdPVXQ1ZEJWU3VMS3hJMkNxUTBYbExxbmhQWjVrQ1R3OWR5?=
 =?utf-8?B?MWxNYXIzMExmVzc3b1FCcG1yZDFRZ1dZU2RiZnBvUXdzZVQwRnYwMExqamdu?=
 =?utf-8?B?OFUvc1hOZzNiR3NJQlAzMWlRa3Z1L1E3Z0xLRkVCWFJLclVmSWJuYWRNSmty?=
 =?utf-8?B?RWhXYzQxTlE5bWVzOGM1WFlkNDdsOEpYUHBLYzVYMHkra09vTUpqVHZWdGx0?=
 =?utf-8?B?cjNJQUdVQjR6ZHNDbFpoUFdDM3lhN3AxRXJTL2sxbWFzZE9aT3NuSTlDM0Iy?=
 =?utf-8?B?QXR2R1ZqeXVBelhiZjdPWTRGbGxDeXBRMEdNYmZUMHRramJjSi93a0d3OStC?=
 =?utf-8?B?ZzdZbHpuTHVpcHdlVlpvcVlVQi9CZGE1Ykl0TTlsTVNWRnhFMHo0UmppSVVo?=
 =?utf-8?B?WVFUeHE4Q1U3OUF1ZnVWblNibkdTU0NnS1c2V3E0ZHozU2NOaHhKejEzaWpU?=
 =?utf-8?B?ZDRHdlJoWjE5MDBMenJWemZodlR2OGZyL2ZwLzJRbWVZVmN1elRuQUVoS2tW?=
 =?utf-8?B?KzhKVWVBWjd2dDFORXFESkJ2Z3VmZ2t2amRkVncrTkYrNlYva2RMYmd4dnpl?=
 =?utf-8?B?cGRLNFRuMTUyNEFRQnhhamlzb2NmTkczTUN2N3pQakgzdEJ5L0VSUDZvOVlH?=
 =?utf-8?B?RFMyblpYbXRhMjM5Nm8vUkovd0VlZDlHamROcVFtRG01b0dvUEdIVjByS0FE?=
 =?utf-8?B?NmZ5cS8rZE5DV1pZTmVSZFlXRzBrNW94ZU5kL0QrQlBlSEd5cHdOeTdVMGx6?=
 =?utf-8?B?VnNHWkxmS2p3TTl5YXp0bjdjNjhWSXNMT1J5RHNIZjhUbVlmcXlVVVNuQWtu?=
 =?utf-8?B?V1hxOFR6ZStmeTQ0ajdRNVUvZVd1NzdoWXBmcDU1c1ZqMm92dUZvK1VYNVZz?=
 =?utf-8?B?Z0dNbmk3ZUFTemtReXVNWXVOQVFSVEs3cUdFZmU3bXFVMlBUb0tMQzhjeklU?=
 =?utf-8?B?emdsa3FkSXMyVDlQZy9lZE45L2NNM1Y1VHIzZm5TOG9TWGFNSVovaE9hWi9h?=
 =?utf-8?B?aUthUlVGS1BmRVBFNTdYODZJaTBoZ2d5STFmUG1iTHZiUVBrUG5jNU1zVmFw?=
 =?utf-8?B?SnFsQ3JFQnJxOXdGMnFDMmQ3ZXFsZXU2V2pLRXFsaG10VmZVTy90bmJoSzNQ?=
 =?utf-8?B?V0VtQWx2MTV0NUlBL0h0b0I1MzVDaWw3WlNnUGo1TFJjSDdEeWI1R1hPeWRR?=
 =?utf-8?B?Ri9HUlAwZmFGVHU1WUJjZnEzVzVRL3UvWHpodUplcUNJSGdDNldKQW9yVktr?=
 =?utf-8?B?c2VLbGY3am5SUnMrczNRYUpwK0t0d3FJV2JNNUl2cnp5N1dlV3JucUFkT1lF?=
 =?utf-8?B?VE03aFd2TlFnK3Q3dmhEMjI1SnMxRUprMDRjNldpNXRhc2NpWVJWVlJRSENn?=
 =?utf-8?B?S1ZTVU5Jd2hhLzRWOTFwTUNnUWh6K1AvemxtS044eTV0VlNJWjJ3bFp5RG9K?=
 =?utf-8?B?RjNNM0NMRzJsV2dvT0ZBSTJmbXlXYk1TNWJJUFVWTitTelhkYjNsM0ROSUxl?=
 =?utf-8?B?QzArMmZnUVpuNVZOYnVGK25BQks3NStvaG1IdVZYL05LYjdoTEtiY09sRGF2?=
 =?utf-8?B?bVA2S095OWhrRVM5NTVHMnlrZ0NHdGEvYW9hdWwzY3IzUUErcFY5bncrR1J3?=
 =?utf-8?B?ckIvSHVOdnpjdlpGaTlFMGVuZXkyZ0plOEQ3dVhNVXF6UlpzdkptaFdiNmY3?=
 =?utf-8?B?UEhMK0pZL0hGWlEzQmtKTXg1bVZIaVZYYzJGUlYyaU9JMFBZS2k4eFZLaUY3?=
 =?utf-8?B?dVhqdExldXZQVmlicDJxeVlrbkRXNGtUUUFTTkE4K0RIVTVpRlJQWmEwVFZx?=
 =?utf-8?B?emJ0Rlg0Q0E2eElYU2Q3U3JtMlBNeHlXbTE1VFBJNytZY3BIY1kzaE1leG85?=
 =?utf-8?B?QWdrUmpJVTRwbCtKdDU1Q1hGMm9FeFNNVStsbVVtSlJBRVE1eGwyMEhqNldl?=
 =?utf-8?Q?XPjgbOvU3ZA=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:26.0166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2861ee8b-38ff-4dcd-d262-08dcf21ba125
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9207

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Use BIT() macro for TCP flags field and TCP congestion control
flags that will be used by the congestion control algorithm.

No functional changes.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Ilpo Järvinen <ij@kernel.org>
---
 include/net/tcp.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 739a9fb83d0c..bc34b450929c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -26,6 +26,7 @@
 #include <linux/kref.h>
 #include <linux/ktime.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/bits.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_timewait_sock.h>
@@ -911,14 +912,14 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 
 #define tcp_flag_byte(th) (((u_int8_t *)th)[13])
 
-#define TCPHDR_FIN 0x01
-#define TCPHDR_SYN 0x02
-#define TCPHDR_RST 0x04
-#define TCPHDR_PSH 0x08
-#define TCPHDR_ACK 0x10
-#define TCPHDR_URG 0x20
-#define TCPHDR_ECE 0x40
-#define TCPHDR_CWR 0x80
+#define TCPHDR_FIN	BIT(0)
+#define TCPHDR_SYN	BIT(1)
+#define TCPHDR_RST	BIT(2)
+#define TCPHDR_PSH	BIT(3)
+#define TCPHDR_ACK	BIT(4)
+#define TCPHDR_URG	BIT(5)
+#define TCPHDR_ECE	BIT(6)
+#define TCPHDR_CWR	BIT(7)
 
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
@@ -1107,9 +1108,9 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CA_UNSPEC	0
 
 /* Algorithm can be set on socket without CAP_NET_ADMIN privileges */
-#define TCP_CONG_NON_RESTRICTED 0x1
+#define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
-#define TCP_CONG_NEEDS_ECN	0x2
+#define TCP_CONG_NEEDS_ECN		BIT(1)
 #define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
 
 union tcp_cc_info;
-- 
2.34.1


