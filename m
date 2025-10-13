Return-Path: <linux-fsdevel+bounces-64006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80CBD5C1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B08018A376D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D92D6620;
	Mon, 13 Oct 2025 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="LfUE5AX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034327055F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380998; cv=fail; b=L+AK0TmH6sDZNP+sMG10ZzFsNigkaOz9LhZroyRbOALdmNplEvthjq5vOF3hZtoDv6k8jqrjXoiJTZ2ZUfpg0bXHY7sgutTtlwVi4mZVQKRh7jsP5viber9rz8Jj0dfIzOx2r1MBKnRC2DF8HFUC0QDwElAbCcoi7TVg6KsIivI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380998; c=relaxed/simple;
	bh=ywDdBO4PdxwMM9dXN1hDmBTYmeeglawNUlKQsI5lbMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYx7NDBvHN2PZPbMemp0Rj2tW9+YT2R1dybf8rxEgmhGvJ4VJdbVdzbUHLlK4V3p1iZOXg/IeVKmzwcZqNERr6F6x3ORI7JswPxNvHmutxBE93vZ85I+KsoEA1e32WhfXSA03y933iZx9S38OUZq/M3vPO30OwwbgL1bSslowiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=LfUE5AX7; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022082.outbound.protection.outlook.com [40.93.195.82]) by mx-outbound13-162.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Oct 2025 18:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDXSncn0tfOoEl7MCvIIL0MR7kJUVXxarBs/iHh9cbzfd3Tt2NM41XPsvkRs6755MQOHZx/+Sjx395pRLi7J8Y6mvvHTycNS5RdCSyPBaDa4L5tjoqGlohnUjBX7P+RJ9Yux/fYLhauEvKBNQjudjSRYzfKYG7tazrIY+/7Cbhoz+DZmvmGW7sHWjACk2OYNIANs89t/GQnkbV1q/txRwhGjLrkfjI8uffAnGYK2WhoatKJ7IP5Q140SlwDRhZF+vl7c1DiBS1HqOXBjR93zbUHkcL2+yO94VaqNRbpPYOInl/hvxJrE+Fhu/oMIk2rUoNRjIA1baPoHSCNxvg/fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CROsBqbnavBjSLM6sBkSY72ZEuI0Rmb5N44afSgWBvQ=;
 b=R9TCkztEtzhvxaOCG1Bft5kacqv7SJlyQiU+2nb5BJ7yYVheATGtS5ss9cVj1mQkAOlTClNaEC4bMGLqnZ+59TmkJK6KiwA34G7yAaRDt1gzHzhfy2N+9ZRv5v25MIWKXHvjEuWnpKTxc009KfEEYknKyXx3qnUAR21IHfDGxtgj6XTfWhK/20vJbqia3U2kZdczq45Ur8/WirfwsfBRd8b+rc9WClVjlxVC/4CpybJ25KfRYiJqMjDqQJ5+7aRSzaO+XiFy96qVDtVVW5G/GoiHTuNUQIhOW11JHrWyUFVlyxqSM+bNLlgIzmXxISuEXpT588qfdD8mm3+gRw+/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CROsBqbnavBjSLM6sBkSY72ZEuI0Rmb5N44afSgWBvQ=;
 b=LfUE5AX7fXWiR8d8mg/LS39gyXt5yAb8jiE1uL4K2xa8/lbRsiBCbNx3ybeNHGxBAAt+Rr6VTkMQQ4LqQYdC3wkqF3fnmYM61o5gV8RyaaaTh5zLC/+we8XfCXLQm3uTF/4yLN/sdah9pEmpTkOUPsE5vCfrK3MGAaIbvIluViM=
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by SJ0PR19MB6816.namprd19.prod.outlook.com (2603:10b6:a03:47b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 17:10:05 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::d8) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:10:05 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 146B663;
	Mon, 13 Oct 2025 17:10:03 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 13 Oct 2025 19:09:58 +0200
Subject: [PATCH v3 2/6] fuse: {io-uring} Rename ring->nr_queues to
 max_nr_queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-reduced-nr-ring-queues_3-v3-2-6d87c8aa31ae@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760375401; l=4316;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=ywDdBO4PdxwMM9dXN1hDmBTYmeeglawNUlKQsI5lbMI=;
 b=1Nr8O2vhDah1LL5BJCU5zOFfQcDXKUnf0uB72N2kMKMAMLZ4jBo6FfzXneL0KTlrCq4bX3tMi
 DW590S2Xoi1CPl0Rhjd6ZOXKOoi/awpeYQXrIjd+MMbE4vvscrLo1dZ
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SJ0PR19MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: b7440d67-eb21-4f26-f94f-08de0a7b5ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|19092799006|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UnZkZHZwZzIyOWo5QTVCUXlGbXBXZmxyeU8zRjkzSHdXV1VwR1VjR2cyYjh1?=
 =?utf-8?B?TFRsWVcwWCsxRnhPMk52R2tkd1gyNTV0cmZRY1hTUXhuWGRGMEl4bW5BRjdr?=
 =?utf-8?B?aTQ4VDZ4Zk1Cbzdhc0ErZDBqUTg3OStadkZZUFZsNjVKS1M1UTlOMzFwMXZp?=
 =?utf-8?B?MmZFQUtpTHREa2t5azZLMTdpMWlrYzRQMnBJSDdadWhRQ041RVNIMFZlVmlK?=
 =?utf-8?B?Z0ZOOE1yc0laTEFyaTQ2ZDN3bGljZmI3MW5Ua0t5Z1BTSFZSYmZJZGVsN0sy?=
 =?utf-8?B?dHRYcVpSUE04cEVyeEdFeVZvdFVuSVVDbGVuaFc1Mkk4ckk1Z1F4ZnVuUnlQ?=
 =?utf-8?B?bWJQTUlpdklGeTBBUzhjWEdteGdLam4zUmV6K2hsbUdJRjRtZi9zR1pycGVu?=
 =?utf-8?B?OVhqdStIMFZ3RVdlZmJaU0twdWtXcTVNZG1CeFY3cFo3M0d6SUVPV0hnMFE1?=
 =?utf-8?B?NWhzVVo4RjV1cnJKSlNmT0cwVk4zRjhGSVhJM0dFOGJJVytUWEZMQjh2aGx0?=
 =?utf-8?B?QlZIeGE5dnl1NXU5VGNUck5tNS9LVWI1YXozNnl1SVNZTXpPUHpUalc2bURx?=
 =?utf-8?B?L0owZVVaS0NHbmhnVWdZa29BVXZBeng3NFp5M2QvWjJGY0RzUC9lakQ3WnF0?=
 =?utf-8?B?VDR5d3RWdzg0bDJLMDRSTUNPd2NNWWlIT2gvL2U5MWg0OEJiZG5xbCt2bmpO?=
 =?utf-8?B?b1MvTmN0UG4xSnk0ZzZGNFA5eDlkaFRqVzhXUUNHUW9keE94bFFqUEVTblJF?=
 =?utf-8?B?c01YdFV4Z1JzcXZnVzRObFRuUjhEUDJtVXBmZTF6Yyt6UWYwcjQyeVR0d3Vs?=
 =?utf-8?B?NE5hZjIyVXFhT0RoeHowUEhwZG43MUE0eDlvQ2RNeURCNFZXbTNubmYwaUE4?=
 =?utf-8?B?Vjd5VDVqQitJQWxrR1FIeVVvTXVwdnhkNXlZcC92WXRzVk5vdCtoTVZQaEJy?=
 =?utf-8?B?ZGlqU3cvMHVIeWwzK3VLOE54Z2g4U1RmNXcweXZJYkdPZnNCS3Azc2RzN1Zr?=
 =?utf-8?B?d09CWDI5U3prdm9sU1A1ZlgxVy95b3k2Q3NzVEh5SFJVenNPSTV1dWl0V2lJ?=
 =?utf-8?B?ZHdZcHo4dUtzSnhPWEptN0pZZGdBTnlDUlptLzhYVGw4K0xCWm90bzJMNVhw?=
 =?utf-8?B?TGlBMGhRN0NiWjU1dHFzWGp3LzAwT2U1U3Z2by9oMjlWU3hGTURlR1NxZklj?=
 =?utf-8?B?UlhDNGlyOEZBcEJFN2I3L2EwNHFxckZzMmJ5RUdZbEd4aTFYaC9zclpYcTZw?=
 =?utf-8?B?VFZpTnFCR0UzZVdicThVazhzQmU1dTVXVmlSQkM2U1UwNm1WY1MvUWdTSXds?=
 =?utf-8?B?eCsxMC8ydFZIb2lGK0hJWFFmUTRqTEtMdUJ2enpnNkNHZkU5VStWMXIycG9v?=
 =?utf-8?B?cEhZUlpPblVhZmJmUkVJRWlQWmRQMXF5S09HYUtkc3NZanRpQ2p6aDB2cGNM?=
 =?utf-8?B?c2xLYjBLVmxSbDhQWWJoZXJxbzAwL0NpdU4zYmtqV3cvYjNaSnVZTHNuR2ZC?=
 =?utf-8?B?akZQbVIwZWVyNmcrcTJzWVNLa3gyaTF3bitHQzhNeWNKM1QxbU13RTFzSHVk?=
 =?utf-8?B?eFVyaTlVS28ydjNXMEZReGpRb29KTXRpT0JCeFE3VHJ3dktZbjhPa2Q4SHBD?=
 =?utf-8?B?MDVpYzFsUHgvRFhrUTNUemFTc3d4ckNGWFR1RUZYTlZjRG12bmsvZ1dWaHl0?=
 =?utf-8?B?NlNkZXJLdlZkZ0pwSG1LajlYdmJFc0tiQ0tOQ2lyeEdidFRSazlSZ2NjS3I4?=
 =?utf-8?B?R21sd2lHMStNaEQyMHNxa1ZPMXpJbWRNemRtL0o1eW50QklWTGQzMHpTVkph?=
 =?utf-8?B?bWRPMnJXVEtMYXZEU0EyaDNzcWpGYzFiNDdHUCswQmRMdVdtRmdOVGJOa01t?=
 =?utf-8?B?bkU2bS9VRGk4RHZSVVhNUkVyZEhCUTJ0c3hnRDVrTmhFSExJS3NiQVpSNFFq?=
 =?utf-8?B?WElaelo2WUFrYnRMN1VMMm9mM0piU0I5djI0WVhrODFCeVFkTDE1blYrYzNK?=
 =?utf-8?B?ZzBSTU9tdUR6bm5jeS9nU3p6Ym10UEt6V1dJYjFzcmtxc0ozTzFmUlJGRHNY?=
 =?utf-8?B?SjVRSzVhMGdhYW1TbThSRGZ0ZnA5MURuTi9uMjBWek1OS3pYQ2xwdFdqYVdu?=
 =?utf-8?Q?9Bo4=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(19092799006)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 Rb7byqDJAAU7VkrYtCfsLMixSMjl33CMcMlXJ0vHmlGnSQ6NBx7JTrBKYijKxQ+7jaF8YJNb57utTLAw5oFzEKxV8NXOn1YAuGM3hP837ddtT5TcUBrMVZtfJ6bb2E/wEcEeGK/VsuGQZrXWyPhVrrXNzrJ5ayAB2t1n3ooQacX2XJQvHXlDAlcvlbrnu+ZEobw8IPV7LUaoAXpOnUm10/Au7vGLK2HMeMNWrnHJr9OIlmW+GvmvxGmcjtq8B5QmYcauxLG1O2d6oqXQMc6EsLMXMxFlB4SGBdgI0bMOPt3JYFOVSaADTZkyvxkm5YhVHeZAkhibm2j1z/fQmWFXFO8FTs6fC7QO0VB3PgjoCxK41jBLJ2LAjn68Ebm3zs06/jzzHU2FSI4rg+xA+CugkO8uAAIEsRyR7IFxXncF2bnS4LRl5sBilBn2dHLKFBqJ2xQDkcEf/Cokb5N38tGNHhW4x88dnWchy1hOoMn275sMFKl8vBsvW8L7dVkjvK5QKdopgiZLA8kZYtQoY7Je8ADZ3JsI59wDsD0HACH7N2y8Wo2EP/vovMqz5NoDe3IB6yhSg2tH7w+HMEmM60LyJ/GG1J5QalSopWpybxFa1CInjqEFURexBGrVTZc2vNp9rj8WsYmLbsHIMxp0naLwCg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:10:05.1072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7440d67-eb21-4f26-f94f-08de0a7b5ac5
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6816
X-OriginatorOrg: ddn.com
X-BESS-ID: 1760380994-103490-7589-4362-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.93.195.82
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaGFmZAVgZQ0DLZ1MjMMM3SOC
	3RxDjNIC3ZPNkgKck81cTU1DDVKMlcqTYWAGafvalBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268183 [from 
	cloudscan18-183.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is preparation for follow up commits that allow to run with a
reduced number of queues.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c   | 24 ++++++++++++------------
 fs/fuse/dev_uring_i.h |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 872ae17ffaf49a30c46ef89c1668684a61a0cce4..70eed06571d7254f3a30b7b27bcedea221ec2dd1 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -125,7 +125,7 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 	struct fuse_ring_queue *queue;
 	struct fuse_conn *fc = ring->fc;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue)
 			continue;
@@ -166,7 +166,7 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 	if (!ring)
 		return false;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue)
 			continue;
@@ -193,7 +193,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 	if (!ring)
 		return;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = ring->queues[qid];
 		struct fuse_ring_ent *ent, *next;
 
@@ -253,7 +253,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 
 	init_waitqueue_head(&ring->stop_waitq);
 
-	ring->nr_queues = nr_queues;
+	ring->max_nr_queues = nr_queues;
 	ring->fc = fc;
 	ring->max_payload_sz = max_payload_size;
 	smp_store_release(&fc->ring, ring);
@@ -405,7 +405,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 	int qid;
 	struct fuse_ring_ent *ent;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = ring->queues[qid];
 
 		if (!queue)
@@ -436,7 +436,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 		container_of(work, struct fuse_ring, async_teardown_work.work);
 
 	/* XXX code dup */
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
@@ -471,7 +471,7 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
 {
 	int qid;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
@@ -890,7 +890,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	if (!ring)
 		return err;
 
-	if (qid >= ring->nr_queues)
+	if (qid >= ring->max_nr_queues)
 		return -EINVAL;
 
 	queue = ring->queues[qid];
@@ -953,7 +953,7 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 	struct fuse_ring_queue *queue;
 	bool ready = true;
 
-	for (qid = 0; qid < ring->nr_queues && ready; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues && ready; qid++) {
 		if (current_qid == qid)
 			continue;
 
@@ -1094,7 +1094,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 			return err;
 	}
 
-	if (qid >= ring->nr_queues) {
+	if (qid >= ring->max_nr_queues) {
 		pr_info_ratelimited("fuse: Invalid ring qid %u\n", qid);
 		return -EINVAL;
 	}
@@ -1237,9 +1237,9 @@ static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
 
 	qid = task_cpu(current);
 
-	if (WARN_ONCE(qid >= ring->nr_queues,
+	if (WARN_ONCE(qid >= ring->max_nr_queues,
 		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
-		      ring->nr_queues))
+		      ring->max_nr_queues))
 		qid = 0;
 
 	queue = ring->queues[qid];
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index c63bed9f863d53d4ac2bed7bfbda61941cd99083..708412294982566919122a1a0d7f741217c763ce 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -113,7 +113,7 @@ struct fuse_ring {
 	struct fuse_conn *fc;
 
 	/* number of ring queues */
-	size_t nr_queues;
+	size_t max_nr_queues;
 
 	/* maximum payload/arg size */
 	size_t max_payload_sz;

-- 
2.43.0


