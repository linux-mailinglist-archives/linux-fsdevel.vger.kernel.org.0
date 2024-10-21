Return-Path: <linux-fsdevel+bounces-32531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF229A92AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB5C1F22E86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19F2003AD;
	Mon, 21 Oct 2024 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="K4EV1kT8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C7E200117;
	Mon, 21 Oct 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547978; cv=fail; b=IRCRlxzFna8pxsJSM7X2zjXjAseS19V5d2B1SHVnFeNcKK4J6Z2O985M5Xbqy4xjw0EVNYcckwuv3WIiNdF7/Av6UsCQEOS78WuTmHseIIGUdVGzBoLf/eqFUNIOUEOmxXjCNwbDS4YIATVxeAs0YiDXmlRSMMqzYUBjqTVuhfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547978; c=relaxed/simple;
	bh=4j5SJ5HYuPel2Dv+IBBWRsO/17dTAoza3QBOY2Scc+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5Wg9xZBDt6kCGFV7VQJ9/yZi6sWWGQEz+qw1XggbUW2hrUEvg8E/g/7jW0Q92YpXGyF7KUY3Hlr8vwP88lhuzH53prwdZgV1WriZLCDoSuBeArzm/UvD+1OGkct/v5tS+V9Q8UzOQV0JJAmy8nFgBzj84AKJVQ/YY5v8yVLhgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=K4EV1kT8; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l973njf6aRltnSvOUjw7WNB3egpHjvSNZzt1UCUbkA1EPTK3yjmeo7XRHAz4+EdqiT7NdTdZ6QVrWCi8giM0BOR4G04i2Toe6DCcC+9CFgjjPMSywLZjxPXl+VrlydIzIenJxdriaDHcxkg45arSJ7ufiMfJolUVRYb+71/xhwEc59R7BI9Hrq/sAT5D0XCSVjVZ8FNWOMOMRJbH4MITu1nseFc/FfSiLV+ylFc75+29OteV2Yj3gXK9gBCZuCgWKupyLTgWIXF2WrTvhP2dsQn3irCHwG0U+oZhLEah5gSFe2q+za6tVapWDe79tk7klFx0ffnpBNA2YTClc83Oyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSA7eqx5WtqjVvMOGIZmeD65xQRrVJgg0ZR6KM5OeDg=;
 b=RMR+qNveCLh9xmfhxRWbUpI4rdj2ZJWW6H0FYouNe7myq5XSFCQ2CvkeDPz9ntkG0BoHoGSuP4kZerNZMZLjsQn8D6icCAqw2+tr/Pd5sEAteOBKkme9D9r0GIR792s1l9hQLa6aJNwVvWSIYeevCcnmJA/KSNrNSyO81WETKcDh4E1/5C30mha9eFrewqJvLEtlRL7GynDQ8kM0qcCcJdxql5fN9jeGbtNMV4Vu0o40Vj39KaI1CgNikQUi354YwACDtJKL14ay/cgIQNf26ILXh8/E6UoAcRUfF7lO5kx7xjXw74O132ZQz5GtlYHQNgvUKu5c4qrpjmcjfdD4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSA7eqx5WtqjVvMOGIZmeD65xQRrVJgg0ZR6KM5OeDg=;
 b=K4EV1kT83v/ODROGPe1DtDeCIvNN8kDWuM71PmHDYQyOUBn4t9DsIa7TcaisPiLj9z7jip0n6e5oPuNe4uTCXJ2rlSPZ6UwEI3P7jOq5it1RZkoaFSpfUHFtHy4Brn7che72oNB2v9qaGpVBZQo88OOd64qh1RjEJc2d9KIlsxXtyTZ4t9VJLM1sClyxnA310PUh6QbED0Dx+LxWK40HS58obyKuqXKkFIh2FNP+ZIEe3k9sKiYgdmVP8U1NMq3c0LIBtmczDbwOTSOX2IasrsdP+KmlMjTryQ3PqtCruH/SNHs4uviqdAIBqEiA1TRp3RmHK78RHflShCq9kivqtQ==
Received: from AM6P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::47)
 by PA4PR07MB8389.eurprd07.prod.outlook.com (2603:10a6:102:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:59:33 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:209:8b:cafe::a) by AM6P191CA0034.outlook.office365.com
 (2603:10a6:209:8b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:33 +0000
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
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENQ032273;
	Mon, 21 Oct 2024 21:59:32 GMT
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
Subject: [PATCH v4 net-next 09/14] gro: prevent ACE field corruption & better AccECN handling
Date: Mon, 21 Oct 2024 23:59:05 +0200
Message-Id: <20241021215910.59767-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|PA4PR07MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c06c9eb-d1ab-464d-cca7-08dcf21ba5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkJjUVY5b1dUTk1hWENxSVlERjRnQnBWY2o2SllidXREblpQc2xUQ1FRN2NU?=
 =?utf-8?B?bnc1d0MzNjk5eUdNMGxOVXM3aGJSZ25yVi9oSmQ0QUU3aXVwUzN4VHYwTHRX?=
 =?utf-8?B?NnNNM1pDNC9aQk9PRjdZaUlxamRGcHV2TlpjMm5veG9FekxqNU5YRnJhbXFE?=
 =?utf-8?B?QjhmbGx0YmIzbHlaVitoYmxxQ2pIMmFjeFlMTmhiQzVhYjZTNWxYQmY5aENH?=
 =?utf-8?B?S0hzZ20yZHZuaUtwbVpsYzY2ZTlqMCtEOU9xeGhwS0Y3b3hzWkJycWFNdkkw?=
 =?utf-8?B?Z1RnODBEM0p3d1ltbXVGQVNSMUR2elNZOHdrb2k1WmVnOE95N1o4VXBhNTdi?=
 =?utf-8?B?am54M05uTFRjY0dhSEJtdG9pTUJqcnRUQnh4dytTOGJ1dTZ1K25ZaUJ2bkNX?=
 =?utf-8?B?eWlLSGFvWHRSK0liRklpUlY2aDZ4Y3plMmt1MG80UmFBZXNuMHIwWFpnOFFI?=
 =?utf-8?B?dVEycU1RaGxmUURZbCtnb2hiYlY5YUdWdjEyaXBhV0VjL2FXcHN4SUVSZEpj?=
 =?utf-8?B?R1gwVFMxVnZsLzlDU25rTEQxVnNTdkZ1cEIweDZNbjUxSlZmUWtjci81NXp0?=
 =?utf-8?B?aWRqZzZmQ3N3dVdTMVJOWFRRVUN4WGNsZnNUWDBGdXBMeXpyT3EzeWwvUUJP?=
 =?utf-8?B?czNYUHhacnF3RnBDVWxyKzQ3Y2ZiWFFTTTJ3aXc3Vng5a2k0QnA2UlViREZT?=
 =?utf-8?B?Qk9kUjVUVzRCOHkyOHFpcmIydGVPNExrNDFjaWUxVnFUdnNibHF5Nk90eUJJ?=
 =?utf-8?B?cUM1UHF3MzBKNnJaYkxIbFRFQmFHV1RvYW84T21xTWJtc3Q4N2RvOG53eGo4?=
 =?utf-8?B?QW5jL3RXUEhUcmRvNU5RRFQ3YmJpV0hZdzRhUUtYbkV4NGNZbFRKSWNLYTN1?=
 =?utf-8?B?a1dKTzA5ZXdUS0Z6L0pPMVFFY3g5RDdUd2tIUGxFQjlhL0o3b1cwSDJ6SklO?=
 =?utf-8?B?MmtSRlhjZC8vY3puMEtaR2ZwTU8zVUJGNTNHb2R4UlVNOEd3Wnhpa0ZEZnR0?=
 =?utf-8?B?cndJbkhJMXpRTldhb0d1NnJqZzVlUlFrVUdQa29hZnRWbm5RRTdjSEhuM2hw?=
 =?utf-8?B?ZFBsSEhDdm92QzU2YWxreDdaOU5kMVI5blVVSHlWTURNRVZFVXE1ZDRsek82?=
 =?utf-8?B?b1kxWlJrOGpmeXF1RStsdVNEanNlVnViNFN2Y0VzWjNGTWx6anhpNUYyY2Ri?=
 =?utf-8?B?bGFKK2k2Z0tUaGl3cjk2cGZPMGM2VWN6Qkp2SWlaaStFMU1BVytIMlNBdUE1?=
 =?utf-8?B?TTZFTmNnT0M0cU1vMkptSWlsK0U0OUNIbmtrWW1XYUxKVy9Ud0lTYnY0WkQr?=
 =?utf-8?B?UmViSTJVOVg1MWZ6M0pIMHJBNjNiT1MvQjRCZUxKSEx1MlBCeFI4Mk1nUnJt?=
 =?utf-8?B?aWl5NkJiZTVYQWxxMXA5ejNEUDhYVGVBVmRxd2NSQ2wyWXQ1Q0NPck16NDdm?=
 =?utf-8?B?dzNWdjVVQk8xVWdFeENYOW9FV2ZTTEI3UXdhK2lIVWI0N1l4akMvVDBUZ1Fk?=
 =?utf-8?B?alh1dlh6bUh2bXdYMDJjR3E0UmVwU0pJZ0NiK0ZJeW1LM3NzYmQ0Z2VsMDlY?=
 =?utf-8?B?YUhFSFArTTNtRk9heVRSbTVPaHBJaXNjM3NsNE9LRzhUMzJNU0RSdi9uV3oy?=
 =?utf-8?B?bnVBWjJzSUdlT3IwM0w3dkxBVXJWR2JkTXFYdURpWHI1dGZGdFY4U0N1S2xT?=
 =?utf-8?B?eFBFeHBtaHNNRkJjYVVaUVl3R293UFdSMlpVc1M2WXJKZ09mbndiVHQvT1Zy?=
 =?utf-8?B?aC9YM1Z5RjhxbUFObzRyTGlxWG0wOWtCUFkyakFrd1hrVVZIUlduaUdIWTZj?=
 =?utf-8?B?OCtBL1B4UXBZbDNHbFYxRldBaFI1Vjl5N1BUOWpkbVVpZW5NcTRlbjhtRmhR?=
 =?utf-8?B?L2VVZStmZHF4Nzhsb3lLd1NzN0tJWE5Ha091ZUJhQ0x2aGdFZk5PWkoyZ3o0?=
 =?utf-8?Q?gO+uFI6Lopo=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:33.6777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c06c9eb-d1ab-464d-cca7-08dcf21ba5b6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8389

From: Ilpo Järvinen <ij@kernel.org>

There are important differences in how the CWR field behaves
in RFC3168 and AccECN. With AccECN, CWR flag is part of the
ACE counter and its changes are important so adjust the flags
changed mask accordingly.

Also, if CWR is there, set the Accurate ECN GSO flag to avoid
corrupting CWR flag somewhere.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 0b05f30e9e5f..f59762d88c38 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -329,7 +329,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	th2 = tcp_hdr(p);
 	flush = (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
-		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
+		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
 		flush |= *(u32 *)((u8 *)th + i) ^
@@ -405,7 +405,7 @@ void tcp_gro_complete(struct sk_buff *skb)
 	shinfo->gso_segs = NAPI_GRO_CB(skb)->count;
 
 	if (th->cwr)
-		shinfo->gso_type |= SKB_GSO_TCP_ECN;
+		shinfo->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 EXPORT_SYMBOL(tcp_gro_complete);
 
-- 
2.34.1


