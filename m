Return-Path: <linux-fsdevel+bounces-32528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267609A92A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA601C21F43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A781FF7BD;
	Mon, 21 Oct 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pFLTO40o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4F1FF05A;
	Mon, 21 Oct 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547975; cv=fail; b=UWyaAWAfPhzVGP02kgA9qKFOH2jQaHrZ2fBY1cqvVKtpnjJrzpPoMuOOqevyGy9nm3EsnBjWPwqu2p3Pgbk2uRs6gWGPHZ6VquY2ziNXTZtAWa8QeISp0OssShx7DOJsMyJaOzpR65cJ99+4RDS4wEo4CoFmrfnDHjHuSmFq5DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547975; c=relaxed/simple;
	bh=2t+5N638urHzd2mITJuqBgr0vLodMfkStFo2Z29puv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdsAsPAFf2DBNXT1CrJdAJUgY8VyiJVjxsLKNJg1GoyjFJRQx2Cv0V+mZ1AEWUNoHVNgCfbiK0JFa0LNqNdI7PcvNyTJdS22w4SkgaYm8f1oj8ALywC/vilHsNH7D0PmEY5Y0jsHvGHR5IjmoTFSL+4zaxguCoS/Oq8Dvw4WI0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pFLTO40o; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PglEc6e96Bt3bgDJwI3sLYw68WozJ179JZPw6Erghf37xqMvHbZX+AJXLFziVby3Y8bdGwg3zKCW8oWR3G2rEorHl/gxo3+Q/kvGirlGNu36rZFFS8A67N4rcEBcV5BA0hkco0/YRL1JyMWFdoJ6AlYDGcnoNdKZll2lWLa9WJHuS3NnIbDq+Zv1W/LZAiCKr0xSqcFdrLExI2ZcUNO/w0OWt1EnIwj5f7IXmn358lk6ISq7VNH8NfrxOIjK69R+deP0bC49gvIGs3NdT1sJ+/NQVk6L9PlTo79CaKEKD00Erq+IiBbNRLF9+wcz8dG7wHXcuED+mhcjoukNmlVe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2xhPcQlS+ABToD5tbnfVaU6cD2DcEEZ0wnz+k3lwd4=;
 b=qUAVnG4P4b3l01NeoFwW+Yq3+NGYEuOdFJpx7Doe7dYs36fvBj4JE57H5uTOKiZNvGZDbz0+LSJm97tnvlGmYKHxT9sFg5iX0G0qELF+r1Yx/hjgCSIGogYa4gANTBzia88lGDAaJs+2OIBlwlNvInHjxauB3uU5+us5nbdp6nbhRW5HP5YJVe2WIzQr50PYnU89Jsdz72SWZ4+SQ68QuO0KMDWDz7uvUpzU206hum+UUjbOxY/EwKrYxRzLUs01q2ofpp+FMfxkmzDNqIvR4Zm2HTVeROmcV1YV3MPt4TZP2tWpa7bqNJ/92Gze1Ry6vUDGsW2cfQuQMo+2zMzBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2xhPcQlS+ABToD5tbnfVaU6cD2DcEEZ0wnz+k3lwd4=;
 b=pFLTO40oSHSN60y3I1j2NVkTA26BLXoF/yeauSgYJyG8yjvDM7I4LRAsC/o4HrZV7B59L+XiseuFCC5073rF5Nz9FcZxx1QEuHV/5wgIbr/ZfaPIWX16ews67F1FSRxkgKteHyh42qebd3UX+Bjddakpk21RMjmoxdMGGnHuXctculCVcaGAhgLK1zEy3grKIo+OHki8qTnG+juiuqsZ5jcqqmtqUqJ9GoVryaeocsa64ok1R4bqSOcpJeoKodst1DIHU7XJBqSC5inezHpSQP2cgGeetWGFEchx25Bn9/nlMLu9uOxfGyc9Np/noF93jfnMfHsH4G81joDbJoDmWw==
Received: from PR2P264CA0029.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::17) by
 PAWPR07MB9509.eurprd07.prod.outlook.com (2603:10a6:102:359::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.27; Mon, 21 Oct 2024 21:59:29 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:101:1:cafe::ff) by PR2P264CA0029.outlook.office365.com
 (2603:10a6:101:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Mon, 21 Oct 2024 21:59:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENL032273;
	Mon, 21 Oct 2024 21:59:25 GMT
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
Subject: [PATCH v4 net-next 04/14] tcp: extend TCP flags to allow AE bit/ACE field
Date: Mon, 21 Oct 2024 23:59:00 +0200
Message-Id: <20241021215910.59767-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|PAWPR07MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a835c1-2ae4-4e5c-d3f5-08dcf21ba1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGQxeSs5NUVXbWxhSmY5NnJiVXNyRDRqNzdjNlQ3MFpwbEp3RE1nMlBGd2dY?=
 =?utf-8?B?dno1bWVIWXNOa2t5NlhzOVZEQ3pEaHozbktJRWhORUcrRlZ4UlJUQ2NlaG15?=
 =?utf-8?B?RzFDMDNEZHcxc1V6a1VUL0daZm5zcnBzaE9XaEtTQkhFeFJiYzVDaU1UZFNm?=
 =?utf-8?B?RmY2Yy9ReW5FNGIwWXZKTk44WTBNMnpoZmkrMlE4bGVZc0UzdlVtd2hnMEM0?=
 =?utf-8?B?VjFzeEFqamRLOGowL3laZkRnVDArUXdIRU9rdlJuenVVZEkyTTR3UGI1aEJF?=
 =?utf-8?B?UW00ZnBJUFdoQ2V6aVF5Wnl3NjQvSVVNN2g4ZGMxWmFaVGNuMGdGdk9lSjhj?=
 =?utf-8?B?NVFWNHJGU09uODJTWFZOaGxhZnNPMmg1NmpSRUswcmRRblZiWDVQWUE3RDVu?=
 =?utf-8?B?WjM5dFhmSDBEWG9hdnVTQ0lHTGFpS25hYklSeGJWZEYwRVlueUNNVUJta08x?=
 =?utf-8?B?dDNiZm9kaHRDQnZUVHdVaWM2blNoWkxzWW9PYzlzcUpJWGF4QUtGWFpLU1Jk?=
 =?utf-8?B?K09HUk1EQ3hSNnBwam40eEtTaFpPR0F6T09wRTVyL0w5VkFIM3Jad2tsT3lm?=
 =?utf-8?B?NEU0TWNERVBQZFZtc1dPeWV1a2RkNGZKMnVQTDh4UW03UzY0N1JjeXFZNVU1?=
 =?utf-8?B?dFppRW0zZ2lRSjJUSVF6dWJoR3VyMmdscy9xUE9YMEhnbGlNM1ZLRGZPZWxl?=
 =?utf-8?B?RENsSUhVbEVsVVVUMkpJS3lqRFJPZWFhTGI1L0JFSzZQeUwzTXpNMlZIT0ZU?=
 =?utf-8?B?eU80aUVYTnBqaGZhVHZhZ1JSYUgxV0ZNdzl2K3FkMmlPTWIwejN0WWNKTng1?=
 =?utf-8?B?MVJXUDBvejJqUWk4a0s0RXdtSGpiZ3M2NVVlb2l1c2FHRnkvWkgyU2RqVnlI?=
 =?utf-8?B?angzcFU3SDMwN1ZldlhjWit6NkVVcDJKNUw1M2twZDNIaVBVSXRKeHRHekVT?=
 =?utf-8?B?VGxTVEs1TWg4eGlIczlxakVuKzA2UUNFbXlmQ3dIY3NiWnhoZTFNazUrMkYw?=
 =?utf-8?B?VFRWazdEenUvVERsWU1wRExZbjkwQXlVSEhWL2ZSQ2UyRnRUbWlldzdsRG9o?=
 =?utf-8?B?TGdiY0M0TnVBMFJaanRsb3JIblFjRmRyMzRLOElza3lKbmZFUDhDYUdYUnlF?=
 =?utf-8?B?WG1aRjdhbXpKc3BEQTUrUG8wYVhYd0owck1SOXJYUXB4S1VUZ2hUUW5LNm8z?=
 =?utf-8?B?YXdZVVU3Y2czVzU4YjhiOTRuaFg0a0pzZUdrTkdxcXdVR3l0NFluS2lmOXBY?=
 =?utf-8?B?a09TRWhPaUJZSXh6c2VldUJLMUxBNnB1U2JPTHNUK3FpTHc3Y1MwOEE0SXVK?=
 =?utf-8?B?NlNueTJQRWE3R3czcFZwalM4V08xY3RPbk9lVkcwQkhMM1R0VkFVYldJazJQ?=
 =?utf-8?B?SjMwQ0RaNUNqaE51UFBIenVVdXZUNHFQZVg4anRQYkZRcGRGRTZkV1FrQkYz?=
 =?utf-8?B?N1BNb3d2WTdOejFQb0pOaC9QZ2U3OHpERUJpT2ZVeVBORFpUZkJIRzFGdWxH?=
 =?utf-8?B?cXE4Nno2ZzBaQjRrZHZpU1lML2ZQK1NJM2FKM2U1T3RCbm1FdUJhTnNneHVB?=
 =?utf-8?B?TVpyQWFNS2xFYmRueko5UnpERkZ2L3U4R2d3ZkxHeEVrZGcxM213WUwwNzU3?=
 =?utf-8?B?dTNoYXZjeTV0NGxjdjlqcmc3YWNDQU54b0lQMUt1TEdmU0QrSnJOOG11L0Zv?=
 =?utf-8?B?ZGpieGY4ZTc3MXpZUmpVT3EraG5ZQzc3RU5OUXg1UmtLRkdjcWRBT2NGKzha?=
 =?utf-8?B?c2ZmNFVCRWlqelNjdHc0d3ErL09QNi9Wa0ZyakJsaG1PMWdsOVE4YnA3dTdF?=
 =?utf-8?B?cnM0Y3FnL1FSSTNuK2tRNFVWNGdTSGFPdHkyelk5WkI5ek42QkFjWFJKSWJz?=
 =?utf-8?B?WGpyQXVkNlJyVzNBK1NXTzBrM2d3M2hvakFPZTRZNk1vNGRwRE01MDR1cnF3?=
 =?utf-8?Q?RAeT+9Lw1dA=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:27.3864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a835c1-2ae4-4e5c-d3f5-08dcf21ba1f6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9509

From: Ilpo Järvinen <ij@kernel.org>

With AccECN, there's one additional TCP flag to be used (AE)
and ACE field that overloads the definition of AE, CWR, and
ECE flags. As tcp_flags was previously only 1 byte, the
byte-order stuff needs to be added to it's handling.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h             | 7 ++++++-
 include/uapi/linux/tcp.h      | 9 ++++++---
 net/ipv4/tcp_ipv4.c           | 3 ++-
 net/ipv4/tcp_output.c         | 8 ++++----
 net/ipv6/tcp_ipv6.c           | 3 ++-
 net/netfilter/nf_log_syslog.c | 8 +++++---
 6 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index bc34b450929c..55a7f0a7ee59 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -920,7 +920,12 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 #define TCPHDR_URG	BIT(5)
 #define TCPHDR_ECE	BIT(6)
 #define TCPHDR_CWR	BIT(7)
+#define TCPHDR_AE	BIT(8)
+#define TCPHDR_FLAGS_MASK (TCPHDR_FIN | TCPHDR_SYN | TCPHDR_RST | \
+			   TCPHDR_PSH | TCPHDR_ACK | TCPHDR_URG | \
+			   TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 
+#define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
 /* State flags for sacked in struct tcp_skb_cb */
@@ -955,7 +960,7 @@ struct tcp_skb_cb {
 			u16	tcp_gso_size;
 		};
 	};
-	__u8		tcp_flags;	/* TCP header flags. (tcp[13])	*/
+	__u16		tcp_flags;	/* TCP header flags (tcp[12-13])*/
 
 	__u8		sacked;		/* State flags for SACK.	*/
 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dbf896f3146c..3fe08d7dddaf 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -28,7 +28,8 @@ struct tcphdr {
 	__be32	seq;
 	__be32	ack_seq;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-	__u16	res1:4,
+	__u16	ae:1,
+		res1:3,
 		doff:4,
 		fin:1,
 		syn:1,
@@ -40,7 +41,8 @@ struct tcphdr {
 		cwr:1;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	__u16	doff:4,
-		res1:4,
+		res1:3,
+		ae:1,
 		cwr:1,
 		ece:1,
 		urg:1,
@@ -70,6 +72,7 @@ union tcp_word_hdr {
 #define tcp_flag_word(tp) (((union tcp_word_hdr *)(tp))->words[3])
 
 enum {
+	TCP_FLAG_AE  = __constant_cpu_to_be32(0x01000000),
 	TCP_FLAG_CWR = __constant_cpu_to_be32(0x00800000),
 	TCP_FLAG_ECE = __constant_cpu_to_be32(0x00400000),
 	TCP_FLAG_URG = __constant_cpu_to_be32(0x00200000),
@@ -78,7 +81,7 @@ enum {
 	TCP_FLAG_RST = __constant_cpu_to_be32(0x00040000),
 	TCP_FLAG_SYN = __constant_cpu_to_be32(0x00020000),
 	TCP_FLAG_FIN = __constant_cpu_to_be32(0x00010000),
-	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0F000000),
+	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0E000000),
 	TCP_DATA_OFFSET = __constant_cpu_to_be32(0xF0000000)
 };
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9d3dd101ea71..9fe314a59240 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2162,7 +2162,8 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff * 4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
-	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
+	TCP_SKB_CB(skb)->tcp_flags = ntohs(*(__be16 *)&tcp_flag_word(th)) &
+				     TCPHDR_FLAGS_MASK;
 	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
 	TCP_SKB_CB(skb)->sacked	 = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 054244ce5117..45cb67c635be 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -400,7 +400,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 /* Constructs common control bits of non-data skb. If SYN/FIN is present,
  * auto increment end seqno.
  */
-static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u8 flags)
+static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u16 flags)
 {
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
@@ -1382,7 +1382,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	th->seq			= htonl(tcb->seq);
 	th->ack_seq		= htonl(rcv_nxt);
 	*(((__be16 *)th) + 6)	= htons(((tcp_header_size >> 2) << 12) |
-					tcb->tcp_flags);
+					(tcb->tcp_flags & TCPHDR_FLAGS_MASK));
 
 	th->check		= 0;
 	th->urg_ptr		= 0;
@@ -1604,7 +1604,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 	int old_factor;
 	long limit;
 	int nlen;
-	u8 flags;
+	u16 flags;
 
 	if (WARN_ON(len > skb->len))
 		return -EINVAL;
@@ -2159,7 +2159,7 @@ static int tso_fragment(struct sock *sk, struct sk_buff *skb, unsigned int len,
 {
 	int nlen = skb->len - len;
 	struct sk_buff *buff;
-	u8 flags;
+	u16 flags;
 
 	/* All of a TSO frame must be composed of paged data.  */
 	DEBUG_NET_WARN_ON_ONCE(skb->len != skb->data_len);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 597920061a3a..252d3dac3a09 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1737,7 +1737,8 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
 				    skb->len - th->doff*4);
 	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
-	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
+	TCP_SKB_CB(skb)->tcp_flags = ntohs(*(__be16 *)&tcp_flag_word(th)) &
+				     TCPHDR_FLAGS_MASK;
 	TCP_SKB_CB(skb)->ip_dsfield = ipv6_get_dsfield(hdr);
 	TCP_SKB_CB(skb)->sacked = 0;
 	TCP_SKB_CB(skb)->has_rxtstamp =
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 58402226045e..86d5fc5d28e3 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -216,7 +216,9 @@ nf_log_dump_tcp_header(struct nf_log_buf *m,
 	/* Max length: 9 "RES=0x3C " */
 	nf_log_buf_add(m, "RES=0x%02x ", (u_int8_t)(ntohl(tcp_flag_word(th) &
 					    TCP_RESERVED_BITS) >> 22));
-	/* Max length: 32 "CWR ECE URG ACK PSH RST SYN FIN " */
+	/* Max length: 35 "AE CWR ECE URG ACK PSH RST SYN FIN " */
+	if (th->ae)
+		nf_log_buf_add(m, "AE ");
 	if (th->cwr)
 		nf_log_buf_add(m, "CWR ");
 	if (th->ece)
@@ -516,7 +518,7 @@ dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
 
 	/* Proto    Max log string length */
 	/* IP:	    40+46+6+11+127 = 230 */
-	/* TCP:     10+max(25,20+30+13+9+32+11+127) = 252 */
+	/* TCP:     10+max(25,20+30+13+9+35+11+127) = 255 */
 	/* UDP:     10+max(25,20) = 35 */
 	/* UDPLITE: 14+max(25,20) = 39 */
 	/* ICMP:    11+max(25, 18+25+max(19,14,24+3+n+10,3+n+10)) = 91+n */
@@ -526,7 +528,7 @@ dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
 
 	/* (ICMP allows recursion one level deep) */
 	/* maxlen =  IP + ICMP +  IP + max(TCP,UDP,ICMP,unknown) */
-	/* maxlen = 230+   91  + 230 + 252 = 803 */
+	/* maxlen = 230+   91  + 230 + 255 = 806 */
 }
 
 static noinline_for_stack void
-- 
2.34.1


