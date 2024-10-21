Return-Path: <linux-fsdevel+bounces-32532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2355E9A92B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8021C21B2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3B1FDFBF;
	Mon, 21 Oct 2024 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="G6T+L3na"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F191E25F3;
	Mon, 21 Oct 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547979; cv=fail; b=SNLEUOn76jIuBuFoOi27QWzgBIg4TPemYr3nM8/r8t/umoAr6ofqgvs609gyncj5CUd00+xljPQkFJ6f3J6y55RQrfmMtzQZGkqM4oT6SxNAUTQ1bVUTnO/orz+P4eLDnqbXVw8YziLfWly6uZixusP/rocOFqXd8Sol24INMvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547979; c=relaxed/simple;
	bh=WztCfr7DU2uQkLa72YOgwPpB13/PQ87q2/XsS4qJoUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjqay95QV85DZqBIl2lcj2qdK/Qi29/K/h5EAPF26yWoV3HEOvDpoq3W/Yu347wytjH46/EWckgyulN2+IcheFOoCt1owi0ul+r6+UT5zcTNZafWlGZO8/sA1o5CXeAvDufj/WxzMU9mzPnr2o/NJuOcSL/xQrJuQ3ODiFPzB5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=G6T+L3na; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFRl/BIGDxAdNHQ19D30Pll9OEg1jjUDmXsPFjUj9/+1MOvJ49XpdkdKAs1CLur1cTgjFM4xuMV4WTPGGL9gpH+fQ4nQXrl2fSp2RGKVn3x2TVamXbRpmkGuuQO0Wx+qFVqnItcyAh6aH9rtM6wHOYNtid5BZscgJOuTKhmPhKuisJvH4CSjhvgeRuJbQyB8bcy2RCYGBvreO73BOrI4Xvee67153mlHbd2ca4q1qFm3yioGoOe39Q9rSaw+q/hQqrp9DSo/OXRAdRT3GGRDVTKOENQaG0asMsfcuOhCgN+4V8JEFQCMyTLvCegtWuIJih5wuASmemwNTK8Rk6eeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMLJhFkpP+SH8QSt/9Ge4HrMPEmhzLTSJg317FeAfgM=;
 b=R6E/3ulO6N2Nqf+Wmj1xdNBJXj+uadoKRmIRWbQY0u8Z8A0mGPk4NfynH3vgF211/BKfwwRvhvKIIv7Z2QWqXQ5h69bAFPpJu3801gJ8fqQysVm+qHWP/pK4VSXTwG4qUaBBAaZaW4bolM3aWdo9lZJXQ3sk9P3I94IG3f/fmzzlqLAJZSl53upRBuRfDIsqr+QJ6Mo9jScVrb/5vBMzFvggxJFuBQKBDgI8/75323GNwJ1DXuki8lqu+Z+Xg0NcR75W1nil6rJDc/MTQp5OPOCtVOB7AikQ0MuFbwMDL7fHodL8ySzRboaN1o/+vHLaIRrzX+KLpwRRdjMSmtMSkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=bestguesspass action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMLJhFkpP+SH8QSt/9Ge4HrMPEmhzLTSJg317FeAfgM=;
 b=G6T+L3na0xTpru0G6ZWu2YTyuyIzNxUWpcmE/r7+xYqCaP/oFlZjaCOVSX0hav/0IT4cQ9Yh/A9EZr6+3abZd/mKkIMdtZ47zIUHf7Vtnb0auQ02LSw9Sc283xLSRpyYlE6Ip6jZPBN+SL/o9twnjqw/ZrKnbFRSex0lCvF8PMJDWbpg//WEFWDJvkV9vnHvamxXC+l3awuwYt7oWLxBoJGPOBWR14uXJhlnE0Uy03iY+FnyW4npK397nLsVrl0R/u/c5y+kplVOyHqHxIiPUGfWrKAhB/W4RTUscFdBUf1HgD9AQQKIGN4gX26o6og1a/K53W/YGt6pghagZitSJQ==
Received: from DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) by DB9PR07MB8562.eurprd07.prod.outlook.com
 (2603:10a6:10:302::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Mon, 21 Oct
 2024 21:59:32 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::71) by DUZPR01CA0001.outlook.office365.com
 (2603:10a6:10:3c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENO032273;
	Mon, 21 Oct 2024 21:59:29 GMT
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
Subject: [PATCH v4 net-next 07/14] tcp: helpers for ECN mode handling
Date: Mon, 21 Oct 2024 23:59:03 +0200
Message-Id: <20241021215910.59767-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|DB9PR07MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3554d9-13e3-47ba-3acf-08dcf21ba461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU9tWDg1c2lIM3Z5bVRVRDF0dk5jaXNTWWFybG1aUERuY205cHdRVE5lUmU3?=
 =?utf-8?B?cVZqZ3ZNc1FKem54SERUK3lZVHV2cGs5YktwaEcySzMyK3NWcmlGc25Xc01q?=
 =?utf-8?B?QjNyT28ydmFLL3VVdGhCK29iMlBFVHZ5WDFEMjZ1TWhMRGxzZnNpRnAvMWIx?=
 =?utf-8?B?eDRCNUNsdXk4RmN6emFxZTB2LzBSZDhITWlTYXJoL1lrdEVQNjdQTU1hOUNv?=
 =?utf-8?B?eXIrd0VSSGkvM3FXL0lYa0d6emVDb2tQUFlORm9SRllQcU1YY29jUHRnRjZi?=
 =?utf-8?B?V0htUGxqeHNCRWY0b0pCeVdaRCtPcEZ6Z0ljZzlaNW5hdTkrT210dWY0Qk54?=
 =?utf-8?B?YlJPRk5IdWk2L1pFSFRBbUFlZU54RndVWVlOK0lneFl0THora3F3MGowU2tw?=
 =?utf-8?B?akFacFpZcDhxRnVsbTg4Ync2WGZYV0FMWE4zdmU2V3RVVmkwT0NOWHQwc0NH?=
 =?utf-8?B?dVE0VWxUZ0hLY2lkelJJdVp6dGZJSkRaUWM0SkJ5QkdaZzVZK25IU2FUR0tB?=
 =?utf-8?B?YkdLck5nWG96VVB6emxvZnpFQUlVeDN2OW40TkdBOHV1a1lYaEVoTkFWMC8y?=
 =?utf-8?B?Q2dTL3NKNDl6SkhUeVVHcm1vb25kRzVOY3N3UlhTMnBJa3FCNlJScjVQejE1?=
 =?utf-8?B?TUhIREw2NlFlRnIxbUdhTUh2UkdhWkFpNkFvWGd4cjJGSGplNy9WOEZVL2p1?=
 =?utf-8?B?QzJ0S1V3Q3lLTHdvWHI1aDdnUWVGVGpwZERlcHdXWmsydkpIR1ZyV0tZVWxG?=
 =?utf-8?B?VEtTdFFBZlpNd3BWa2lTTE1zOGtYYjg1ZXdxT2hPVWdkVlRKSkxoYldPQnRY?=
 =?utf-8?B?MTdWOERJdEZBcGRNdzF0UjVnZjdnQWF4aTVmdERmUWdUNUU4UzFLTGlMQ3M1?=
 =?utf-8?B?S2FIRmo5bUpiQkR0dm9hNXA1MTJnZFJPamJ0cjVZK3JZWjFXZzhrcjlYS2xH?=
 =?utf-8?B?dkl1VW9CYURycjlXODBJdXhidjJjM0ZpSWVEN3R3Wlp5S1ljOG1uaUZNMVFD?=
 =?utf-8?B?aWZIM3VXbk0yb1V5VjhQTTVrRlNGM0J0OThqczRyTGUxZnFOWG1CaXNxNlJF?=
 =?utf-8?B?T01UNndmNlNDK1Z6M0tiVjJnWWFsdkNPRTg2MkVBbkhUSm0xV0Z5ZkQ3SjlL?=
 =?utf-8?B?S1NPUEdFYVdNbGJ2TnVxTGRBQkJmTzlrUVVkWW5aUHVvTG5rRysrZUpvOU84?=
 =?utf-8?B?SUo1b2szMGdMdmdNL1JRRkIvZ0pzWTRsU3l6L1NWMFV4Y1BYSEFqWTkrTnRz?=
 =?utf-8?B?Qkc5OGRSd2s1ZVRzYzhnNW1kbm9nREpUVTFiU2Rmdjh1bm94Vm9halRaa2J1?=
 =?utf-8?B?bmh4dGxtblFsS29EekY2bWJDQ2lMYkZDMnY2V3ZCQnJsT0tGdmgrS2VzK0Yy?=
 =?utf-8?B?S0o2WllKV0xqR1ZpMzNFT29yWE5hQklGTFQrMGdING1tNGVOUGRiVXl2bHFD?=
 =?utf-8?B?ZFdkKy9OVTIzb0NYZVhxb3o1eHd5ckttU1N3RW9aamxNZ3AvYlcwSUY3TXRw?=
 =?utf-8?B?YUxTNjFIamp5cTJCVGVyT2NWYmJOUkw2SzU1ZEZRZlVRdTlIVGVSb3BTQmc4?=
 =?utf-8?B?S1pDRXVMQ0FwOUlSS3MrV0NpOTc3dUtWSy94MndUcVg4bGFMdXpkN2dBdlJU?=
 =?utf-8?B?NWpKVEZIVzJmYVZxRVhDSUorS0VCUUh3SzNmd1F6ck1FdUNVdG52Z08rdm5T?=
 =?utf-8?B?VlhEU1hnSVovV05WR3RjdWVLK1VlTFhWUnBBcUNRQktOc2U2d0ZnYStyaWtt?=
 =?utf-8?B?dUxDTE1LQmZPQUEyMnBkTlN6U2xObjNFT2VZVFl4QURQVkFRWVUrdmZoQ0RV?=
 =?utf-8?B?aUZDbnl4cmN0dzVWVVJVVTYveTFUQU5BL2lUb2M5U2hGV01jRUE0MzRiMzVC?=
 =?utf-8?B?Y2ZKYVUwUnk3RmtyYmMyNTdWaGtSc2hoVXlZcjM2STZuZ0ZIaTM0VEpvSUxx?=
 =?utf-8?Q?eGwf90Jpi0A=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:31.3923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3554d9-13e3-47ba-3acf-08dcf21ba461
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8562

From: Ilpo Järvinen <ij@kernel.org>

Create helpers for TCP ECN modes. No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h        | 44 ++++++++++++++++++++++++++++++++++++----
 net/ipv4/tcp.c           |  2 +-
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_input.c     | 14 ++++++-------
 net/ipv4/tcp_minisocks.c |  4 +++-
 net/ipv4/tcp_output.c    |  6 +++---
 6 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 55a7f0a7ee59..b6a4e0124280 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -372,10 +372,46 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 	}
 }
 
-#define	TCP_ECN_OK		1
-#define	TCP_ECN_QUEUE_CWR	2
-#define	TCP_ECN_DEMAND_CWR	4
-#define	TCP_ECN_SEEN		8
+#define	TCP_ECN_MODE_RFC3168	BIT(0)
+#define	TCP_ECN_QUEUE_CWR	BIT(1)
+#define	TCP_ECN_DEMAND_CWR	BIT(2)
+#define	TCP_ECN_SEEN		BIT(3)
+#define	TCP_ECN_MODE_ACCECN	BIT(4)
+
+#define	TCP_ECN_DISABLED	0
+#define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
+#define	TCP_ECN_MODE_ANY	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
+
+static inline bool tcp_ecn_mode_any(const struct tcp_sock *tp)
+{
+	return tp->ecn_flags & TCP_ECN_MODE_ANY;
+}
+
+static inline bool tcp_ecn_mode_rfc3168(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_ANY) == TCP_ECN_MODE_RFC3168;
+}
+
+static inline bool tcp_ecn_mode_accecn(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_ANY) == TCP_ECN_MODE_ACCECN;
+}
+
+static inline bool tcp_ecn_disabled(const struct tcp_sock *tp)
+{
+	return !tcp_ecn_mode_any(tp);
+}
+
+static inline bool tcp_ecn_mode_pending(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_PENDING) == TCP_ECN_MODE_PENDING;
+}
+
+static inline void tcp_ecn_mode_set(struct tcp_sock *tp, u8 mode)
+{
+	tp->ecn_flags &= ~TCP_ECN_MODE_ANY;
+	tp->ecn_flags |= mode;
+}
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82cc4a5633ce..94546f55385a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4107,7 +4107,7 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_rcv_wscale = tp->rx_opt.rcv_wscale;
 	}
 
-	if (tp->ecn_flags & TCP_ECN_OK)
+	if (tcp_ecn_mode_any(tp))
 		info->tcpi_options |= TCPI_OPT_ECN;
 	if (tp->ecn_flags & TCP_ECN_SEEN)
 		info->tcpi_options |= TCPI_OPT_ECN_SEEN;
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 8a45a4aea933..03abe0848420 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -90,7 +90,7 @@ __bpf_kfunc static void dctcp_init(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
-	if ((tp->ecn_flags & TCP_ECN_OK) ||
+	if (tcp_ecn_mode_any(tp) ||
 	    (sk->sk_state == TCP_LISTEN ||
 	     sk->sk_state == TCP_CLOSE)) {
 		struct dctcp *ca = inet_csk_ca(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6d4abd452a36..0161660938d3 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -334,7 +334,7 @@ static bool tcp_in_quickack_mode(struct sock *sk)
 
 static void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
-	if (tp->ecn_flags & TCP_ECN_OK)
+	if (tcp_ecn_mode_rfc3168(tp))
 		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
 }
 
@@ -361,7 +361,7 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (!(tcp_sk(sk)->ecn_flags & TCP_ECN_OK))
+	if (tcp_ecn_disabled(tp))
 		return;
 
 	switch (TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK) {
@@ -394,19 +394,19 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 
 static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || th->cwr))
-		tp->ecn_flags &= ~TCP_ECN_OK;
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
 static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || !th->cwr))
-		tp->ecn_flags &= ~TCP_ECN_OK;
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
 static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if (th->ece && !th->syn && (tp->ecn_flags & TCP_ECN_OK))
+	if (th->ece && !th->syn && tcp_ecn_mode_rfc3168(tp))
 		return true;
 	return false;
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bb1fe1ba867a..bd6515ab660f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -453,7 +453,9 @@ EXPORT_SYMBOL(tcp_openreq_init_rwin);
 static void tcp_ecn_openreq_child(struct tcp_sock *tp,
 				  const struct request_sock *req)
 {
-	tp->ecn_flags = inet_rsk(req)->ecn_ok ? TCP_ECN_OK : 0;
+	tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
+			     TCP_ECN_MODE_RFC3168 :
+			     TCP_ECN_DISABLED);
 }
 
 void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 64d47c18255f..bb83ad43a4e2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -322,7 +322,7 @@ static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 	const struct tcp_sock *tp = tcp_sk(sk);
 
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_CWR;
-	if (!(tp->ecn_flags & TCP_ECN_OK))
+	if (tcp_ecn_disabled(tp))
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
@@ -351,7 +351,7 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 			INET_ECN_xmit(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tp->ecn_flags = TCP_ECN_OK;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
@@ -379,7 +379,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tp->ecn_flags & TCP_ECN_OK) {
+	if (tcp_ecn_mode_rfc3168(tp)) {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-- 
2.34.1


