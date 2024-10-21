Return-Path: <linux-fsdevel+bounces-32523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B49A9269
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 23:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E2B21FF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC091FE11C;
	Mon, 21 Oct 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JObfxykA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A01D0F76;
	Mon, 21 Oct 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547967; cv=fail; b=WYslNiGGNifXy56OtglSJmLqqwL3tq66i1Y3Lf6byBDrCZPiv7RBXMxBnvrx7pXFsYdn7+P/aYULrHmbrdjn8gMtrEykvHdj55jEP3qPcmmX3zpaDaU0APnh35G0z2i4chWFofFEL2ITe9VrqJCENc+00momN2z8gJdVmiYEMA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547967; c=relaxed/simple;
	bh=kVBB8UqHkq3xgz44CTFfnvmFdrkdlzfcD1Y+wMT5g/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RSVcurG0pNiaMvPx30aiPTsunkYTm8psCe+uijousNX36VmhLcibpshwpbgHbOW+dLRrTdEVj40QPCkzeLzZnGm8QL+ngV0ZdJYIY/z3uLy524z7hfmltMQ7tXu3CVj7m3kyyEk+/3C47nw8WNoz1aoEp9POrHp6ljMwI2i+Oxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JObfxykA; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnCUWb8Bh58euntG3BAiNsS1zGa+LycasTBqQf17p7SCAM35Z7S8PC/07OGNgxbBlU2p4Za8Uy1uvhVrGEgKTUuiagA25sJACS3wGd6dtlWfWvgnhm9GsrcwlItNTi1RbCGrn2DK25nfXAtB9r7HJBIDIzr9Lrbeec5piI/I5F7MO1TLM6mX6IDf+d6bfLKSxf0UCUVK7DxnmcgDcljM34o//FnOz4s/+jOUKycpdRuk12Oq6iscr163W4muH0LPiCR1ozpPFowZXl/rKQ5lBAgmt/KNwWqSx8YVcHsmeztIeEkFrmhmYMT0Jlz0YD1APUAD8/jR8dCX8fRG85eyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqQ5+Lx1S0lSEVoC25198zC3UdMH1pmJD3u/hVpxuQU=;
 b=EbZWY3WQFzTqQxA4XhQAXLQC7HlUx+MU0rZ7JylJsNDchgFVbnUBJj+yv84dIlYAoWr73ZkBAcQTJ1TXdPkAPl4XAugjPE+JgI4WFK6Z8BiJ+B+rLbH2YySX1rRAg24hQjCXkLtiTT1da6hL8CKV06hrVbb2r5qZnxAndTWmnGJNHd9UGjz+E8t9QvefNHMn6LHg5ko1ebuMNeKMku1TbU44w8V2SwBdESihbkZX6UdicR+2F3OIGKajZXeumVw9UxtqUvsbbdp7nBMv1ggsojv5UX5k2vHR0iDtVCqXQtw+X1dmvwWT2sjNZdMRGAHdR7fydrFU9LXjDpyzoQrgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqQ5+Lx1S0lSEVoC25198zC3UdMH1pmJD3u/hVpxuQU=;
 b=JObfxykAAdu1yvpT8haiTSZCecoWJQxaDBzX7Sba5rfOmdfyIvkPKMiCDo2MXanJX57WaPKIleevKG+/OtVMo2v++ZZ/hY2GWv2RfVs8QW42kEei+cwVy87S+0FEfNlATE/QcSNl7CcpzpKuYKN8Vux/6czg8Fs2DKfQVz9PAoFcFviUlk4ORqfWYQt0o6olm7kn5m1fOE56GX8D5EIeO6FeQ074xYqnIQxBvJqGI2UBycMSt78wsCOsmJyaZuVe71i0ESnGj5OECiPecGvNZzQpI9di46uZGJFwsLadLm/7TusQRIHwRLabvyCNj4gEdySA6Q9ubKy0TkXeld1LOg==
Received: from AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33) by
 AM9PR07MB7921.eurprd07.prod.outlook.com (2603:10a6:20b:30f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 21:59:22 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:205:0:cafe::83) by AM4PR05CA0020.outlook.office365.com
 (2603:10a6:205::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 21:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 21:59:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LLxENH032273;
	Mon, 21 Oct 2024 21:59:14 GMT
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
Subject: [PATCH v4 net-next 00/14] AccECN protocol preparation patch series
Date: Mon, 21 Oct 2024 23:58:56 +0200
Message-Id: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AM9PR07MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a5a4df-0ebf-405a-4e30-08dcf21b9ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlJDLys2UU16dW1uQzN5aFZOeUxNSmlnbk9Eb3g3bU5XYURSVGRTb2MvNTg3?=
 =?utf-8?B?b1NiMzgzU0VyUXF6RDRKb0g1VUJFNStFWXpOeGkvcWgra21hdHRTSDdWem9k?=
 =?utf-8?B?RDBZRFZHM2VlYjdaRURtZU9zSzFBYmpPRU93NGREOUlpQlpCaWI5MFBsY1Iy?=
 =?utf-8?B?ZVBxVTdwT0ZQK1o0K0VROHFmUHFLK1Jya2FLbG5Wa3FWWDlNS2dHWkFkOENK?=
 =?utf-8?B?b2FYaWYvK1B1WDlQRTl3S3BGM2JFOUs0ZVVtWGFCYTdXK2dzdzRNV0kvMFUy?=
 =?utf-8?B?MlBLUWE3L01OT0FaNVFDdjNxby8zcDB4OXhRNnRyRzdFbExUWkx3cnhudWcy?=
 =?utf-8?B?Z0VzWEJhNzdvWnVkN2MwcmpoTi95MENhR3BseXJaZlgzYnhQOTVyWkJpM1pQ?=
 =?utf-8?B?eU9HclVWaFZCN0N6aHpMeUprYzlvYWM1N3JmZnFQSjlSMFhNVHVMK0l2YWF3?=
 =?utf-8?B?WlBJaGppTUh1RWs0Q2MvcTFLM1dGbGlXdHZydSs5RUJiYm8rWTNLeUgrRS92?=
 =?utf-8?B?RkNnM1UzR1g4VVd1N2taVG5JZjRiNkg0YUdraTI4WWowZGFMbXBHbWR3blVL?=
 =?utf-8?B?U3hTZmY1UzNPakQ5MTVNSndyUkJhL1FVMWZzR3RSbEVyWVRZck43Z3dFaTFU?=
 =?utf-8?B?NXA1ZU9HUlpqTzJFT2hCVksxZkt6czVicDdiVnRXQUY0VXV6Y0lCQ0I2QU81?=
 =?utf-8?B?ZFVqVmhGY3VTa3lkT01EWnNtZ2ZCYjh6SURUTWlBbUpuWDFjbmVtQTBBNUNo?=
 =?utf-8?B?Yk5TU091VW54SFAvWFp4K24yb1FFZWhhTmlsU2l2UFVQK3pJb3BjdjBxYjU2?=
 =?utf-8?B?MnlmajRhWC95akNnTnhJQTM2NThaUXNpQUtqN1V2UGd3d3hzMXlHZW4zSStv?=
 =?utf-8?B?UnBkWVQ1VkVVTnRlaDVOdkovRmhjSkJTdU9KSFZRWTBNUTdTZUliTk9sSm9a?=
 =?utf-8?B?ZVNnVkxuYTA2YlZ1VTJ3c25kcllyR1V1eVBaQ1RHdVIwNWdJc3RsNlc5TDha?=
 =?utf-8?B?R0ZpZy9sUVBOOW0wSFBLaFI4YUdHME5ZQStVd05Dc21aZ20zRlQyaW1XdGVY?=
 =?utf-8?B?ZTFLUSszNnZsVy9BMlBHYURQZGozWkZFZU5RUmpFZ2hrcjRPODU4L1hMMUth?=
 =?utf-8?B?QXdBakQybTFGRzkwRkx5ekRUaWlLdXFzb1VvM1hkdmlsY24rYlBYV3Y0Vmtt?=
 =?utf-8?B?emY2STdadlJ3M085OTYvcUFDb0dBcEprMkYzQ0pTSXBicjBHSW1sUXdSbERU?=
 =?utf-8?B?ZDV5RGp5M1Bpd0hNN3RoK0ZJcVBkMGdSTFc5djdsdHZzUVl4SXVydVlBSnZ2?=
 =?utf-8?B?aHZYaUVzVUY3L2d4TGlkZWYzKzRrUGkxeWRqMVZtLzM3OTgwdG5Ybmh5MU5K?=
 =?utf-8?B?UVVyVVVvZHN4QjB1QUlrTjdUYXhPL0RDOWRtc0ZPMVpieCt4dzZvUzYxWTJN?=
 =?utf-8?B?RC9SVlAyc1ZydG9TNEtHQlpaNThBVFJXVkllWjIraGh2bW1rZG1QbzNZWGlM?=
 =?utf-8?B?UjdndXhzR3JRZ3JaQmJJWGsrT1RCaGFnU1FPUVp6Mk5QVjk0VTR4ckllNFlv?=
 =?utf-8?B?Q2dLN2VhbGtNMloyNUNpc0IrODBWSmY3bG9LbHduRGxlK0V3OUMxa0ZTaTZC?=
 =?utf-8?B?SVQza0V5QXA3Ymdjb1dYS0pQRjlycE9JQ2lIZmFIbjRma3gzTFBIYTNmNllM?=
 =?utf-8?B?SlVBZUJXMG0wQ09UU1JaR2lXNVlTSVRZbzYrM3lDTGZRUEN3OXVnNjRlRDdm?=
 =?utf-8?B?ZnRkQ0t1NktBVjFVbzIrcDArWm9FSGR4YWd1Wm9LSFIrdnhocm8xckp0Nlda?=
 =?utf-8?B?eUdJZ0RsU1dMSjBGcm5OenJJMzMyUUpyT0NkaGl5WjQ2ZGswVG1qWlJLQjFF?=
 =?utf-8?B?NFR3anlQdTZXTFd4RVk0MDI1ZVh0c1dMQ2JIVE91eEtTaXM3T0JPQmpscmMr?=
 =?utf-8?Q?fnmtlgwnY0A=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:59:22.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a5a4df-0ebf-405a-4e30-08dcf21b9ee5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7921

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Specific changes in this version
- Fix line length warning of patches 02, 04, 08, 10, 11, 14
- Fix spaces preferred around that '|' (ctx:VxV) of patch 07
- Add missing CC'ed of patches 04, 12, 14

This updated patch series is grouped in preparation for the AccECN protocol,
and is part of the full AccECN patch series.

The full patch series can be found in
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

--
Chia-Yu

Chia-Yu Chang (2):
  tcp: use BIT() macro in include/net/tcp.h
  net: sysctl: introduce sysctl SYSCTL_FIVE

Ilpo Järvinen (12):
  tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
  tcp: create FLAG_TS_PROGRESS
  tcp: extend TCP flags to allow AE bit/ACE field
  tcp: reorganize SYN ECN code
  tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
  tcp: helpers for ECN mode handling
  gso: AccECN support
  gro: prevent ACE field corruption & better AccECN handling
  tcp: AccECN support to tcp_add_backlog
  tcp: allow ECN bits in TOS/traffic class
  tcp: Pass flags to __tcp_send_ack
  tcp: fast path functions later

 include/linux/netdev_features.h |   8 +-
 include/linux/netdevice.h       |   2 +
 include/linux/skbuff.h          |   2 +
 include/linux/sysctl.h          |  17 ++--
 include/net/tcp.h               | 133 +++++++++++++++++++++-----------
 include/uapi/linux/tcp.h        |   9 ++-
 kernel/sysctl.c                 |   3 +-
 net/ethtool/common.c            |   1 +
 net/ipv4/bpf_tcp_ca.c           |   2 +-
 net/ipv4/ip_output.c            |   3 +-
 net/ipv4/tcp.c                  |   2 +-
 net/ipv4/tcp_dctcp.c            |   2 +-
 net/ipv4/tcp_dctcp.h            |   2 +-
 net/ipv4/tcp_input.c            | 120 ++++++++++++++++------------
 net/ipv4/tcp_ipv4.c             |  29 +++++--
 net/ipv4/tcp_minisocks.c        |   6 +-
 net/ipv4/tcp_offload.c          |  10 ++-
 net/ipv4/tcp_output.c           |  23 +++---
 net/ipv6/tcp_ipv6.c             |  27 +++++--
 net/netfilter/nf_log_syslog.c   |   8 +-
 20 files changed, 260 insertions(+), 149 deletions(-)

-- 
2.34.1


