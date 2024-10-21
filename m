Return-Path: <linux-fsdevel+bounces-32527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E7D9A929F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DB21F220DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202271FF61A;
	Mon, 21 Oct 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="hPPw1bFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B31FE0F2;
	Mon, 21 Oct 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547974; cv=fail; b=gh/XSP/iHukWDCCUFgEUXfb/W0h2Bt2kXdxirDjOtCcSxbdnVsfB9WW2oUUS9W+KcvTcjogAbA0f9N0bip0r7FYokrvlXTYK5vt1CIalrR/x36wFzkIh18ZKum8xusuzNz8Kfc1B18VJ3Eg21FA4fqY9Qq1yZdDLes0DIUSSpEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547974; c=relaxed/simple;
	bh=/DXiP48JvOyuu2neVkASCL/V6m9Qs0aUxatR2JoMVD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMJvi0UwRfnL/NIa30q7h/FLyEmVjI5hlA7rsnpqE7x7RxhSIJC3Xqe/Hxt97OUdY43qhJmpMbRjSVP9WNWkUL9T710UxSfPZe+msZ9qyAD8te8ks9IZeh0Sbr0NFFz9W4b18hZBfKnEzr2Zv0hCkAUtcFG3sdZqfIH3QtwxujY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=hPPw1bFk; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdJdxtxw4cmAMpitvU/Zb7EQMxggY7fbKCX8dGKWVBUzyLuae7uvO/MZGQjXAsOVF3Z6uV6BWUWoNAPSyuzFerHRclouXCtK/SAUWDZ5wlR1abJGepUqe7HiayY06DR7byU/Y2QLyZCXuC9cMRItkXNqVJ6hyPXRtnDGhAHeQiUJgYUxZrWrY9ajMEXmHvMQ47g09mAV5zQi7A6fhtlAJEndNbjBOhwsri2MLRyNn+maRd6JQJbOiueMo8qaDW1TgMUIlAZ4DpXJJFR3YQjyoNT8gbmpPExmXjjkAHomI33YsUAhx69koHuZrgkCoticP+lBA8yzi2GMoI6dodhIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slhYpgNbfxS31y0O4s9n10+y1xuaFQsDE8kARtPSdOI=;
 b=ZpHEj1Vbm8aeWv2ilpsgydvR+rLMvg7PVg/SYuLfQnkKiR2GLZGNGkTJy3p0OjWMKcyFbcbLcYxzPqJuWD8AmJBdQiSV/+iLziujBNPt0hukVifRVmWpqmySVoq/EA3IFed/LXCQY3q7R35x11RfkmimpF/duiFVC8QqalYWSwYeJeBxFaVdMrQapXKBNeTD6ISHDJZs7jMKBug3x5PDBdSKvQrO8tBL4ekBu4ZKG4vQwQjWF75DRrVbvVJUhL458k6MDQ3BtUlVs8L5bhi0IQthyGT3HhZdvW23fr6fMTNsFJwRbotjty0Y2oDqePZFxT4hFne3jBf0m1mJbjXS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slhYpgNbfxS31y0O4s9n10+y1xuaFQsDE8kARtPSdOI=;
 b=hPPw1bFkwqDG1A01C2DrKPhECJm7JzG610lZTHTrRHP2K3b0AbQNSNkWlVEPrv7Gs+j3wClVaKBMFDWxBpaIpLZfGaB+mrV6ged+67fvwZ1C//MVPuzsdvxhvTGcoWZoLmwpdSIRhWlq3HYJEJbSP18qiIKp8RhVi19kj1obXW7y1D2V4tFVwhvSGergGq6Y5L5HswBhVQEEJh5TERXcqOclFCLD0b9di9nHjIpDdX8cxdsrAUHDwyHXz2A+3hdbznG53e+QVdAbgHzscVXWJBnMZWzQDDawG8O56Acif4kTeldn4F+br9vEGp3BwujOQtPDp1AxtLvhhqjpiO6IkQ==
Received: from AM6PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:20b:b2::14)
 by DBBPR07MB7465.eurprd07.prod.outlook.com (2603:10a6:10:1ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 21:59:28 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:b2:cafe::b3) by AM6PR08CA0002.outlook.office365.com
 (2603:10a6:20b:b2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENM032273;
	Mon, 21 Oct 2024 21:59:26 GMT
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
Subject: [PATCH v4 net-next 05/14] tcp: reorganize SYN ECN code
Date: Mon, 21 Oct 2024 23:59:01 +0200
Message-Id: <20241021215910.59767-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|DBBPR07MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5bde0a-ca4c-4df9-328c-08dcf21ba2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3hZRmpTa1JNeEE2U3E5bDhNVVM2clgrd1U1d1cvMkxyZjZGN0tBRkZRbnFU?=
 =?utf-8?B?S0NOQkRqVkVrYmpPTlVyU29Ma2ZRSmpNNTFhMngrK2ZMWWVoMjV3MU5GZnR6?=
 =?utf-8?B?aWMwc0FtSllad1ZOY0hVcno5WHd4S0R6Qy9nZkRNakhuWmpJemlucFBMQUtN?=
 =?utf-8?B?SXVaNHpkQ1ZaRVk3NWt2TGFuQlp6STUzazM4YlVXMWpXU0cvSzBQZjJiVU5s?=
 =?utf-8?B?SlFzcnI3blFmeGlObGN6TWttaW55NkMwTmhuMVpuRTZ0SUdVL3hsT01ubzZp?=
 =?utf-8?B?T2p2eEV3bE43SGg4Q1dPRXlsVVRGZXJkQXFpWENLSHBEOWdWdXZXeHp3cHhT?=
 =?utf-8?B?OGdsM1kwY0d1bHBoQlFWSWRVMEVMMU9aYTlLZmVLaGZTWmJDdXgyU2gyb1Nm?=
 =?utf-8?B?dEErUHNObEVVODBrejFKK0JGWnNkMWZFTTltUHFCRDNOSERpUkw1RytwbXZO?=
 =?utf-8?B?NUw4VmxCOFI0dUQ3WnBESkcyQ2JLd3N3bllIYkZEN3NIY2xYRk11bmxtckVG?=
 =?utf-8?B?em1mV1NuakJwZnVJVFJEQjR3NDUyTUd2M01VQUxFVzVJVVJKSGVIY2xpWDd0?=
 =?utf-8?B?QzRMMTNVN2d1Z01MVHA1VmZlRmJuWUk3RlFFZUlCQ2pURGd1UG1TMFRadUNN?=
 =?utf-8?B?N0Ura29RcUd5dmNFcGg5WlcrM0xHV3B4Tm80dFV6MUNHRE43NmpFbHF2dnFY?=
 =?utf-8?B?Z1B6QndHMCtTTDhZU3Q2dVdpbTJOR0ZSQzFhTjU2WmgyR243ZDJ4TFBIUWQx?=
 =?utf-8?B?blpORU54T2dCdmVKYzNZQlUreUljSC80QUxHcE5URDdUUEpwQS9uM1kvNmd3?=
 =?utf-8?B?cWkxZlFrci9NMWg4eURRK3ZzVEl6MUNtQkh0RmtiTEFGVExUeXMyaDZFYTNv?=
 =?utf-8?B?UjhlWUxPLzhXaGVMcnFDSzVTa09oUjNaLzZHaVBVZmZya2Q5Vnk5UkhXVDE2?=
 =?utf-8?B?eGIwaTFUZkgySWtVYmhSc1BERytZRVNsT2pRcG1iaU9hZnMrUGVtUHhyWlcx?=
 =?utf-8?B?ZEZpcTFvL01VYzUvbW9IL0kweXIwM0ZZZ1NNYUJ0MHlsVmJOU2dhMnVzNDBx?=
 =?utf-8?B?MjdZaWZLV3M5ZzBlL09ZVkUrZndZVFp0NkdmQVpJWTQ4MmtkaTFLODN4VW1m?=
 =?utf-8?B?RFMzRi9oek0ybE56TGZyeXV1QllnSk5kOWkyYUpFbm4wK3dvUHpwYWYrcjB6?=
 =?utf-8?B?elA3NUtrMDlKZExKT05MMjh2TUkvOFhvUXhPa0pja0NzaXZWc0Z3cjZqM0pC?=
 =?utf-8?B?K014MlhxeExnT0FhNVB1WVdhT0hQcndWR0NkOGZLRFZnYWtWOUZ6anprbG9s?=
 =?utf-8?B?RWdacHdKaVVKcWVtaVY4L3h2TUhMYmY0aXVWQjAya2hoS0lJZHg0YmY1R2JQ?=
 =?utf-8?B?Ujl2WFdWd3FHUm5QM3RSNnorMUlaZG53UmpxNkIzK1NodWplU0dMV09GbVBJ?=
 =?utf-8?B?N3ltYzludmpoM0c1RnFYZkgwOEdJcVVrclY1aVNMWUZTL3Fzbjg3bGExNjV6?=
 =?utf-8?B?OGVkbmRmYzBXOUhYMzNJUUg3RGY4RXdkTitYYlZwTzVsbmNzL0o2cENaMHZD?=
 =?utf-8?B?emgyelRFYW5MUWZ2Smk0TTZ0VUpadGQzVnFxRHpUZFA1T1JQZkxqenY1aEgv?=
 =?utf-8?B?N1MvbWZmQ0ZtRmhEanIyUVFZeE1MdFFvbXR1T21WMEFwNS81TXdGWEUrbitR?=
 =?utf-8?B?OHBjeGlrSjBIUHl6T29LOUtKdHlaMkZzL2o1dEZVcjFlVit4RTQwOGZjejY0?=
 =?utf-8?B?MWxTN3ZKVGNzeHN5elVFUkxUeWZ4OWxTWDdCU21Gd3RmQU03aFpVeWdtNlpm?=
 =?utf-8?B?NnV0WTZlNy8yZ2I4OW9zYW5kTFc1UnFhZEdtNkV4VDVZNXJBTHVseHhSSFph?=
 =?utf-8?B?UkdneTVFWkpWc2FVVTRCQklsSWQzakF6NGo5ZjZaTWZYOGVYM29uN1BldS9m?=
 =?utf-8?Q?IHm0ajCAjds=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:28.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5bde0a-ca4c-4df9-328c-08dcf21ba2b6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7465

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 45cb67c635be..64d47c18255f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -347,10 +347,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tp->ecn_flags = TCP_ECN_OK;
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tp->ecn_flags = TCP_ECN_OK;
 	}
 }
 
-- 
2.34.1


