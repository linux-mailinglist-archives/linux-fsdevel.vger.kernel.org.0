Return-Path: <linux-fsdevel+bounces-32530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE29A92AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C54B23165
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B920013E;
	Mon, 21 Oct 2024 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="duPDBjtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0625200110;
	Mon, 21 Oct 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547978; cv=fail; b=QftCn9hWNnLQZ8ONTGg/nwxRVMSIZXf0lmMANJiO9ZY69lcGMfKdwhTvzhhqOR5zpy23rAYkE8sWmCNsQzKJkzTaSTwYsJW8tWb+W1wyg8CE+8dESfofbdvyncWrhfm3Nfky9azQ+fx6YaXh4XQ9bPcibGaGd1XIxy2I0iPCSjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547978; c=relaxed/simple;
	bh=J9zvNIGCSv/VEda7aJQwG9Uhgv43BCWIAQkMiwTdNKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTD1CGcs/JNalQFsEol4wxxterCV7+vUoISurlsUb7s4y/uA2dxC8hxEbmrWICBS9IeTgtJw0JDlzRgSWfs070Ls/N5FaA7cAAqL0DU39xh7ClcRTtqwQ+Yh0QduwI0rTdeaC8W75ZxlK+sHWDtt/UP8is2T5WsfcX/w6YMXNsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=duPDBjtl; arc=fail smtp.client-ip=40.107.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVqG14qJSTq2hrNplyq4r9doEOtDzHHSIBxJc7nR7yVGoTygLEsRdCZFNozqfgVtXAoliJ1FDKXYl9hzs5/bvsw9XSOQjs+GwEqRe6uNbLPFJvGCyS5/Tdu45b1ZN2bH1U/TP7nqqFeRY3d+03KfUQDvGJkv/YDiLE1klTak65RRsY7c6Gw7y6mSES0m6TI5S4HN7wvHg19PuacMe0pqtOS+anoneWC9ldYuU5cBr7VfPxt1aa+uZvTm8IpeWEV6l/Vwk2WNU8cqYkJ1a14lehFhHRY172YgLxbLl87HCFrN3g6LX+1HZc+fUXFSBNJbgA36dtvKIEhx5df4qvaj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utVwYKFd5vjX/MZSV3gMWkfZps4OlT4rUH+yT3OEJx8=;
 b=xoZSA3QEWj2zzSxZEHruup0IEtNEFnEWtCTgMjhRimFUDZt53CG4Z9pPDUU92Wg8tCjvIDOzgHaluX95FJgtFW0adStR4kYrlscQUf8cvtui1a21uOSGBJK7lIViDaKmJLr1EZIa3u63Ca768x45Mk3MBo0PFEIG6DxhCgZloiJijb6U0PEjrB7oZj0NpGC3WuwLb+Mr3Jlm15nBKKYYmhVsL+6K5zv+GoxmRR0AygyesOcD/LMntVLGk4YfpJg6Kq0ZyAFBY+ofMD9OpcxK5+6TvEn/m1O806IZEWzVk/nf5gn7136NrgL2YoqXdUbEY8P4+9tmxWYWt7sbhQ/vAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utVwYKFd5vjX/MZSV3gMWkfZps4OlT4rUH+yT3OEJx8=;
 b=duPDBjtloIvHK1bWseQSK1hwNBh4qIrsGgufPeeiXZKw5Elr/tr0+O3vt4Rh0XEdcgurjXbmB1KMpDV2rOr/Xg2rBYlLbxYFFvd4/u3h31tnx2mQvkGsBk29fomYN5sv0B5J0E2jK0qP7OdRwU9Tue5/FVkwCqUvx1Ji6V9mmH2TIgkBXV8lm4Bkmh943pckYZV2jM9eDQB50nCKzdvZtk0qHmh8q6nlw1B25ZbViPo1F2NOej6rrlQdvy8wc5EKZ9zeFsSSO76WBuTz0OnNNcvPRxaBHFcjEmIgvZwadQ5rsbK5NN/4u95ICvP2DnzfEqjYJ8RGGu8RRskveJojbQ==
Received: from AS9PR06CA0237.eurprd06.prod.outlook.com (2603:10a6:20b:45e::24)
 by DU0PR07MB9140.eurprd07.prod.outlook.com (2603:10a6:10:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:59:32 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:20b:45e:cafe::8c) by AS9PR06CA0237.outlook.office365.com
 (2603:10a6:20b:45e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENP032273;
	Mon, 21 Oct 2024 21:59:30 GMT
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
Subject: [PATCH v4 net-next 08/14] gso: AccECN support
Date: Mon, 21 Oct 2024 23:59:04 +0200
Message-Id: <20241021215910.59767-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000047:EE_|DU0PR07MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1df74c-cd3a-4a4f-aa77-08dcf21ba4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RThYMFMybW1SVUhQa0YwNHh5R3JzUHZFaTFaOXRtZ0x4QWc2SWU5S3A2SXYy?=
 =?utf-8?B?emhmaEovQ25iY0c2ZjhUSTBFZDBvcElEY0dlUjc2Sm9uUHpRWlNoRlRUUm16?=
 =?utf-8?B?TVIyYlBjYTlaS0UxeVBuT3VyeXhZT1labVhINDdzQjVIZ1VDQ3VGOUd4Zis5?=
 =?utf-8?B?bTNlbW5TWk0rNUFUdDZxZ0RleWVMaTlMeWxRN0VRSXpMUGdKeWsvNTdmVDBV?=
 =?utf-8?B?RFpzdjVjY1c4Ny9ld1JHRW93OW8zeHg1a24vVGlPYk9yR2NJcVhJY0xJSGN1?=
 =?utf-8?B?NS9TRnVrOEZ1WVlyOWlONGJ3Y2h1S3loYkJ1Sm1rTDJQdmFSKzJuTkIzMXFX?=
 =?utf-8?B?ZngrVWwvVDIrYnR2U1hEZUJMTVB1WkFIS2w3Sm5weGgrMFE3dzlOYlBlOVlU?=
 =?utf-8?B?eWdUcm45SXpPQTQvTktEUTRuNmExdTdaNis3QUQ1VytXNWZMSkxJQmNoc2ho?=
 =?utf-8?B?RnlVaEFvMHdwdmM1aWdab2k3RnIyTmRlRXBlR2NCQkFldHNsTnN2Zm5makk0?=
 =?utf-8?B?djZPQVRsdlhnQXRBZGlBTGdBMEhna2Z5ZFlzaDE0YXJjVUNkdWdBc2cvUGZV?=
 =?utf-8?B?ME1vbHZFbjFxRE9qaTMvSDlEeGhhTlRqRjY4c3Fqci92YlpRYTRJTkdSdHIw?=
 =?utf-8?B?WkJsUTFlblpRMURaNmVRU2ZpSFg1WUtQTnRCbDd4dWZZMTFPMEw4eGdLWk84?=
 =?utf-8?B?RVkxZkVwYmgyV3BKNmNxWnFjOTZzaDJnM29YYk9RSnpqV2VEbnp0UnVTU1FD?=
 =?utf-8?B?VDQrQVZ5eEdoQjNFRTF2cVBmeS9YczJyQlVUenJtL3RNckJ6L29DL09pYms3?=
 =?utf-8?B?U0xFdmRvdGNha2VHeVdRYUVmS3MrS1BZclAxdFN3c2FFSGRvTUZkcktGNmNH?=
 =?utf-8?B?Y2p4TmQraU5teU41ZTQxd1JobWp4aWMrUzQvTlc3VzNaTVlZVi9wdkxiYXJ1?=
 =?utf-8?B?TGxueTNYTEUzeEZ3RGIwaTdSQ3hJclVHY3hZbUlSUG1lK2J4RkdCRzFLM1F5?=
 =?utf-8?B?eDZWcDU3aml5ZUdVTlZrTTFieXM3T01md1BUNjMzdGxPQk03MXJ2QmpjYyt6?=
 =?utf-8?B?TVRBZS80bTVhWlB3TDZpNnh3K0Q5MVlseUludVgyRUpsK3RWSnV3bnF1N3Uv?=
 =?utf-8?B?blZTQ2pLbWwvblo0ZFIra1h4Q0pockNHRCtwTlFFanQ0c2lDZk9yYUM5MTdx?=
 =?utf-8?B?cDJ2djhVNXBocUR0ODZpbVQ5bnNRb1RKampBc3BaNDN3L0xsLzJlWEdhOW5F?=
 =?utf-8?B?U2t3a0pLMjM2bkFLakJvSVpmdVFpeWpEUDRtRzJIU1YxcGxjQ0g5Z2hBQnJV?=
 =?utf-8?B?eS8vVmQ1Q2VkVithLzVtK2RUcnkvUTJXdE50RWlqK0o4R2lRSVNicTNEa0F0?=
 =?utf-8?B?UjdYU2tydFQ1M2o1V1l0MkwyYVc1UW5ONGZpZVpwRE9xeUVHU0FsMmVBeEcy?=
 =?utf-8?B?ZXdkZE9UWlFZV212U285emJpOW1mdGd4eXIrTjZJQnRoOEFhcGdacmEvc2k0?=
 =?utf-8?B?Z3laakZ5SWtKNzB5eUk4NEk5SGY0THoxZ3k1SXJoOUlZcG93MURnVkpFQk1r?=
 =?utf-8?B?WjJ2eDJNcXlMME1JZzNKdGptaWR3L2ZuODdJSzIrcnRFU2tOTzNHbUxzcElt?=
 =?utf-8?B?NktDNWZuekxJdFB3QXJZem4wTUE1Z3pEbzB5MlkzM21pQi9IREdYUk5xWTgv?=
 =?utf-8?B?YW84QTFlc1Nsalgwa3kvd3RwczBMZTNFVXhJMlZybGJqVkZCK2U2OVloL251?=
 =?utf-8?B?RmdXM1d3UjJMUXovUGNIWXdQdG53b0kxTm5pek53ZVI3Wnh3R0lqbGRSOW8y?=
 =?utf-8?B?c1lPM1c4bGNHTzE5Um5uR1h4ZHYyWnhySm5WMVh6VlViZzFJSEpkWXdFR1JJ?=
 =?utf-8?B?b2puY0M1dHkyWUlRWXFqL3J6UXJsdkY3L3RrZGdPTENUeW1QdEpDc1dTOXgw?=
 =?utf-8?Q?TRrt8lqFGK4=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:32.4709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1df74c-cd3a-4a4f-aa77-08dcf21ba4fe
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9140

From: Ilpo Järvinen <ij@kernel.org>

Handling the CWR flag differs between RFC 3168 ECN and AccECN.
With RFC 3168 ECN aware TSO (NETIF_F_TSO_ECN) CWR flag is cleared
starting from 2nd segment which is incompatible how AccECN handles
the CWR flag. Such super-segments are indicated by SKB_GSO_TCP_ECN.
With AccECN, CWR flag (or more accurately, the ACE field that also
includes ECE & AE flags) changes only when new packet(s) with CE
mark arrives so the flag should not be changed within a super-skb.
The new skb/feature flags are necessary to prevent such TSO engines
corrupting AccECN ACE counters by clearing the CWR flag (if the
CWR handling feature cannot be turned off).

If NIC is completely unaware of RFC3168 ECN (doesn't support
NETIF_F_TSO_ECN) or its TSO engine can be set to not touch CWR flag
despite supporting also NETIF_F_TSO_ECN, TSO could be safely used
with AccECN on such NIC. This should be evaluated per NIC basis
(not done in this patch series for any NICs).

For the cases, where TSO cannot keep its hands off the CWR flag,
a GSO fallback is provided by this patch.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/netdev_features.h | 8 +++++---
 include/linux/netdevice.h       | 2 ++
 include/linux/skbuff.h          | 2 ++
 net/ethtool/common.c            | 1 +
 net/ipv4/tcp_offload.c          | 6 +++++-
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 66e7d26b70a4..c59db449bcf0 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -53,12 +53,12 @@ enum {
 	NETIF_F_GSO_UDP_BIT,		/* ... UFO, deprecated except tuntap */
 	NETIF_F_GSO_UDP_L4_BIT,		/* ... UDP payload GSO (not UFO) */
 	NETIF_F_GSO_FRAGLIST_BIT,		/* ... Fraglist GSO */
+	NETIF_F_GSO_ACCECN_BIT,         /* TCP AccECN w/ TSO (no clear CWR) */
 	/**/NETIF_F_GSO_LAST =		/* last bit, see GSO_MASK */
-		NETIF_F_GSO_FRAGLIST_BIT,
+		NETIF_F_GSO_ACCECN_BIT,
 
 	NETIF_F_FCOE_CRC_BIT,		/* FCoE CRC32 */
 	NETIF_F_SCTP_CRC_BIT,		/* SCTP checksum offload */
-	__UNUSED_NETIF_F_37,
 	NETIF_F_NTUPLE_BIT,		/* N-tuple filters supported */
 	NETIF_F_RXHASH_BIT,		/* Receive hashing offload */
 	NETIF_F_RXCSUM_BIT,		/* Receive checksumming offload */
@@ -128,6 +128,7 @@ enum {
 #define NETIF_F_SG		__NETIF_F(SG)
 #define NETIF_F_TSO6		__NETIF_F(TSO6)
 #define NETIF_F_TSO_ECN		__NETIF_F(TSO_ECN)
+#define NETIF_F_GSO_ACCECN	__NETIF_F(GSO_ACCECN)
 #define NETIF_F_TSO		__NETIF_F(TSO)
 #define NETIF_F_VLAN_CHALLENGED	__NETIF_F(VLAN_CHALLENGED)
 #define NETIF_F_RXFCS		__NETIF_F(RXFCS)
@@ -210,7 +211,8 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
 
 /* List of features with software fallbacks. */
-#define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
+#define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | \
+				 NETIF_F_GSO_ACCECN | NETIF_F_GSO_SCTP | \
 				 NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST)
 
 /*
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8feaca12655e..4f0747e2325e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5066,6 +5066,8 @@ static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 	BUILD_BUG_ON(SKB_GSO_UDP != (NETIF_F_GSO_UDP >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_UDP_L4 != (NETIF_F_GSO_UDP_L4 >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_FRAGLIST != (NETIF_F_GSO_FRAGLIST >> NETIF_F_GSO_SHIFT));
+	BUILD_BUG_ON(SKB_GSO_TCP_ACCECN !=
+		     (NETIF_F_GSO_ACCECN >> NETIF_F_GSO_SHIFT));
 
 	return (features & feature) == feature;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 48f1e0fa2a13..530cb325fb86 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -694,6 +694,8 @@ enum {
 	SKB_GSO_UDP_L4 = 1 << 17,
 
 	SKB_GSO_FRAGLIST = 1 << 18,
+
+	SKB_GSO_TCP_ACCECN = 1 << 19,
 };
 
 #if BITS_PER_LONG > 32
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 0d62363dbd9d..5c3ba2dfaa74 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -32,6 +32,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_TSO_BIT] =              "tx-tcp-segmentation",
 	[NETIF_F_GSO_ROBUST_BIT] =       "tx-gso-robust",
 	[NETIF_F_TSO_ECN_BIT] =          "tx-tcp-ecn-segmentation",
+	[NETIF_F_GSO_ACCECN_BIT] =	 "tx-tcp-accecn-segmentation",
 	[NETIF_F_TSO_MANGLEID_BIT] =	 "tx-tcp-mangleid-segmentation",
 	[NETIF_F_TSO6_BIT] =             "tx-tcp6-segmentation",
 	[NETIF_F_FSO_BIT] =              "tx-fcoe-segmentation",
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..0b05f30e9e5f 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -139,6 +139,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	struct sk_buff *gso_skb = skb;
 	__sum16 newcheck;
 	bool ooo_okay, copy_destructor;
+	bool ecn_cwr_mask;
 	__wsum delta;
 
 	th = tcp_hdr(skb);
@@ -198,6 +199,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
+	ecn_cwr_mask = !!(skb_shinfo(gso_skb)->gso_type & SKB_GSO_TCP_ACCECN);
+
 	while (skb->next) {
 		th->fin = th->psh = 0;
 		th->check = newcheck;
@@ -217,7 +220,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 		th = tcp_hdr(skb);
 
 		th->seq = htonl(seq);
-		th->cwr = 0;
+
+		th->cwr &= ecn_cwr_mask;
 	}
 
 	/* Following permits TCP Small Queues to work well with GSO :
-- 
2.34.1


