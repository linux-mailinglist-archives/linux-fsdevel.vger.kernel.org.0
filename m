Return-Path: <linux-fsdevel+bounces-64008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607ABBD5C23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14751421025
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CDF2D73A8;
	Mon, 13 Oct 2025 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="etgPy6Zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F44C81
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381037; cv=fail; b=mj7WIm0XP++BE4ppHKC4vl/+UoagRSZH/C/QFDxH3ViaJ/Jw9EXiZk+yDayx89ZysHEaZ+zyt8J080jUz0OGIszxfXQOO/1yDljR5RiPT0xlnnVv5ScrzRvNXVf32U7hndOHxXekTwehve9si0f+1h1R4MUY0Z8QyzMdhFe0y4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381037; c=relaxed/simple;
	bh=XdexGJyMH/qUI0b3cSaeHurouEBinQWjyG/kg4J1AQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Abu4VR0mdpZ8qhzOh6FPX8wj2rVmuWJ83x70gku30p0XY3LGOJNlkJLKdUAgfG7lA4nnI42HnImLXeh5WYR3jlhpHgXSZZJ7tL+PxEKQTWOyhV1A7UnXdUfq+ERuyH4hCqVDipdU6rk1PnVUfRrs86OgcZHP1FWxNaPZhVvGS5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=etgPy6Zo; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020096.outbound.protection.outlook.com [40.93.198.96]) by mx-outbound44-152.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Oct 2025 18:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HETTZ96zR6AzY2HD+Y7Awj7cYoWjC2C6xHe97Y2MTY/XwuWsEpPwzCF4n5WaBcbHZrXoILyrcvyG1NT83OUk7MDd0Q645Ok72kqRYtOphF9FeHHXVF9hKakUx0zMEjuHEI0eCt2okcllpZjVcI/UyTi5zkQ0ryjwvdL6egtAte7UEAgaXniSgVkYpQ+OnFFlBjRQRlLe5iqvWGZpsBGaXuUy1D/yvXCEMf48P/+oraxRYoyM+6Wgs3DyVNMAiVhYEhlrRuY48y+E2kYzwNLXl1bm5XtcX2JqdRw8tlGS2Ws+1sID8PnyF6lFOjoxHtO7bvGzJcri+afk+Ego6xpYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPZ1EXGw1FXUQ8qZb7Pm+PZStgfvxMjsgQ7Jk3VzSj8=;
 b=p3D9mrwMOfoYZL68Da5fEqElztliGFi/9aJCIMKE6baMxsZ0YiEhEwWsqpz1H5+g/a79k0weipwcITYMaUqE9LXn5xGttNULnLGm7yOTC0zCtLDTloK82hSiZCph4M4PacQ1jelZgCiFbXeoN3jOQFXXiXmwoTiJiOlNMcvFpEFreTWf/Nmfbx6UJO4jyxGbhliUIgI/S3bBUfp1xqWnEavYYHXnB6CrdBQGCoLJAZtViiqaNKVfaPcQKdgibldF7Yo5gVS/1XZN864lXlhfpqDkpPlr6uidE8Bqb5fTmeyqJSj4nGeSkRZ9jX/2oTCGyLDd1MJVD6/3hrbcbb8sbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPZ1EXGw1FXUQ8qZb7Pm+PZStgfvxMjsgQ7Jk3VzSj8=;
 b=etgPy6ZolSl5CpKHcDGkX2LB6fuIFE7L99UYGT00wmpK1euonO1VRVxw0Yfk6fUEp4X43Tx1X8wIk+rInsL1apFfChEzifluzOlvieNY6IdXKMf2Tb2yWWrxZJhJFsR7/jAaV0kJinTtHPNaL46UvdHsA78TsR7Eer5Ho3j4Sy8=
Received: from BN0PR04CA0179.namprd04.prod.outlook.com (2603:10b6:408:eb::34)
 by SJ4PPF4188E0764.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 17:10:08 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::be) by BN0PR04CA0179.outlook.office365.com
 (2603:10b6:408:eb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:10:07 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id E285081;
	Mon, 13 Oct 2025 17:10:06 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 13 Oct 2025 19:10:01 +0200
Subject: [PATCH v3 5/6] fuse: {io-uring} Allow reduced number of ring
 queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-reduced-nr-ring-queues_3-v3-5-6d87c8aa31ae@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760375401; l=3349;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=XdexGJyMH/qUI0b3cSaeHurouEBinQWjyG/kg4J1AQ8=;
 b=EiyMy8Ae5+liaz6VcRmEI80q3q+kL+1180OLMFUYFvcFTCWNj9+LhYAHRLsmECifMLbquiyPD
 nfqZnVqjnxMDWGlRR4m2lelWQBqPoow+9k2Esip8wNQQAEXdFjoZCcU
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SJ4PPF4188E0764:EE_
X-MS-Office365-Filtering-Correlation-Id: aea4083c-1f6d-4a08-b518-08de0a7b5c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bGNYWWk2VldVb1UyM2lLNldwemdneUVCRG5WWFE3TmRJK1FMN3Z3dzRVMDV0?=
 =?utf-8?B?bUU4STlLYndrZTZsUEl6d1A5RnpUKzhsNlE2enVXaFEyRUN0MG82dVhPaytK?=
 =?utf-8?B?TnJpb0FYZkJEdjd5QXlqeU5ZdS9FMDd6eWlzU281NURYNnZsR3YwTjBROE1Q?=
 =?utf-8?B?Y2QxVkJXZERzbjJqeXI4OUgvOWN5alNHY0RUVENOQzliVmFrRlFFZU9nbElP?=
 =?utf-8?B?bXdIcFg0d0t4dlhTaEJoTEVHWGhWOUJQZjdjWEFJUmVnSTQxSGtZNnJrUnJ3?=
 =?utf-8?B?TmJCODc4cjlHU0o0NjdxZlhydGQydnpNdll3d285TU9QMngxVm04MTU4eDcw?=
 =?utf-8?B?L0JIV1JtbWR6S0llY0JGcWlXQVpxQnptaDBDMk1iemk0NTZEeW9HQm53Unl0?=
 =?utf-8?B?dWZOUFlTTE1mQzRZYVUvUEpXZE1SbUVGTEtwN3QvUFlOZ0pIQ0E3empHTmE5?=
 =?utf-8?B?N3h3RVJzV2RlSzhHa21ySjBlT2x6M3RNQlZmOWhsRzkzUXh0V0J2d28zLzQr?=
 =?utf-8?B?RmllZDJzVkhOUkt2ekFTQnRWSzVTV3BCVnFaL3hhcGdTcnR2VFFkL1ZDZUxk?=
 =?utf-8?B?eVNLMkVaSEx2NG5MYlpKdnRqL0Q2Q1JSc0xxMXdwUngzbkxTeFlEb3liOVhV?=
 =?utf-8?B?K0ljeUdkbHdYbFYwd0tMbzZiMVJQdzFDRVZtT2RUaG1CMXdRS0dkcnR6Tk11?=
 =?utf-8?B?Z3JkUFBveEl5VkJlM3BGeUdkK2xpTlBNb0taM0djNUNDTER6Wkg3NmNQVEVJ?=
 =?utf-8?B?U243aU5NVFM4dXozYzhkeUw5MWhVSXJHOFZpWjhzV21NUkUyOGVhbUFrM2Z3?=
 =?utf-8?B?NDcxcGxCNGR3czM1NTdFYU1aUmVsWXVjMHFRajgrZGNLRGl6QmM0bExiMHhD?=
 =?utf-8?B?SVdoMjQ1OURIOFcyejRDTmdNQ09jdS9sZ2ZLTytDNW9vZ3JpRUZSMFozUEN3?=
 =?utf-8?B?bk1RQ2srOHR5UGdVbnhCNVFGZTJqNjBlRXVGRFVqZXpzVlZxOUhhRjVwYXho?=
 =?utf-8?B?QVNvTFJKV3NkV3YzK0pMaGlTVW80VlJFNzVDazFPbjMzWlE5ajZLMmpOczBV?=
 =?utf-8?B?VUhhWlpGM3RPVUJ2WUlKNkxPbkN6T1VtNFdZUFlaMmdDNWZjRkRDNjVJOTVK?=
 =?utf-8?B?TDR1Tno5UlhyakFBVEIzVGFoaGd4OWhURzdQekJRVCtGR0k1c3ArblhCaVNM?=
 =?utf-8?B?WkpSV3lPL0xOSzBQQXhldkFaWDBkby9RS1BMZlhZYysxY3Eyd2RNcmpvSmlC?=
 =?utf-8?B?RTFpSjdYZTFld2d3M2xRZmk3bkMvNjdrNDZmVjRKTng3Q3FON3A1RS9JUk1y?=
 =?utf-8?B?Y2RpWFpra2wyZzB6N2FMTE01SEhYYVJrNkJocklLYTVOc1NYM1JYdWZ0SWht?=
 =?utf-8?B?NE81YkY5QzVIV3NmQnNMT2ErVlhEUllBNmJJVU1lVXVjdlVMZkp2K28zZi85?=
 =?utf-8?B?ZEJqQmVwalBRRWltbjdyUTR2cFdsT1NvSFJ5b3RWNW9hTm14cC9oTXh3WVQv?=
 =?utf-8?B?M05GOFQ2TllLSmw2N3NKMFk5QlpRM0tWenJKUXpaUkxieTFXeTVRRlNCK3BR?=
 =?utf-8?B?WlZ0NFNScUVybHo2eFM1WGdvWUhob2w2Rm9SOW1hNkdBa01lQURZQ1Y3UURS?=
 =?utf-8?B?UHp2MWhMK0dkQ3FjeTZGNVE1QzF1U2lVb3J6ZHpKdEtvUlBpMjRhTkx4TDla?=
 =?utf-8?B?QWZxUGdGY0t3TUN3V3FkMlJnaGdjazhlbTYxRWdUQmlHZjhQT3dyYWtjeWNr?=
 =?utf-8?B?ckUvZWlXem11cUxDTlpWcWhsdjMvMVQ5NzhHSWRaYURTdnh5eGlhbUFaaVRh?=
 =?utf-8?B?RDhiK1ptOW9nK1JnNlQ2bnQ2V1RReUN6UEdaYWNJY3E1S0RDV3BjMHovWXNk?=
 =?utf-8?B?K0JyVFRnem83U0RNZmloWlZBNUFBdzdEV3ZIZEpBbzFSekkzRkZDY1Q2eUZR?=
 =?utf-8?B?U0pDQXFUemFmbWFhL1NYMzFpQjgwQXpXdGtoRUMzZjQ2SzNBdEg5RWhWbU1P?=
 =?utf-8?B?YnE5MTQxRkp4ZTZ5d1lMT21IbEN4UmVJZFZFR0IxTTdzLzVJOFFETUxPaE8z?=
 =?utf-8?B?Y0RVZlhka29vYkdQdlNFbVBqRFJGWkJjRENkZ285cXNlbCt4R08yRnRzNXdG?=
 =?utf-8?Q?bUXY=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(19092799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 XFghekDgcmHzCSzMV2Cl3JKlMzq8twFek1lHQWRQKtjA9FcrAvfCKWKl21yvioZH8qN/uXumsF8h3hubH3LGlMd/MdIEVoLxsqKpK4mQQFAQq34Q66Lke4OpjFmc+QWY1M6Y2ZfBrxAyQfSe5zgIYecvmYEwlYLaRbeN4R/V2uPBWeImeCuWUkKemk7Mh2NGfqrpAtwZqLvrzEYUetOQZ95RRmYglnmoov61FgtLsAgc7rX+aMVJwjbV2U3flTn+0IuHz0mpRO7/rxJ/TUvHSLZoR+qCf50svTj6HJwITrbY01quuiFKxB/yCoHq1bRQ5YM2GXNqnCa0TtBF96hwynljIXwJtUAsV75JcZyChFOp8dhX0wdK90Xus0wl3PnklAnC0A/52swshG+WvJQYYm1wxG2vMqKSyDAeezQsCAZ3bl1G1kezJBytI9Eff0OT1fZbYg2JepvZd8UaPEE063e3zr7j1SFChAOJGtO2je6XskvJndBsuQSFPCyl6KOXkUYs67ADWQV5PcA5UIzbGzaaOxiLnKAnc61pz0iMYhRHqw17w618De/lNbSC6GeIvgYh/yJU6YJnoxcjtPiRwtWtPYV7RD+VsAWm6wb7OuQvi1HL3RHaUyFZswGChP5jNNm+Uh4Zq6PwjUNjvx+AVQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:10:07.9809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea4083c-1f6d-4a08-b518-08de0a7b5c6e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF4188E0764
X-OriginatorOrg: ddn.com
X-BESS-ID: 1760381034-111416-7618-2051-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.93.198.96
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZGJpZAVgZQMCUpNTk5xczY2M
	LEJCU1OS0lKdko2cA4yTLFNM3U0NhIqTYWAL0Ia0JBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268183 [from 
	cloudscan11-158.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Queues selection (fuse_uring_get_queue) can handle reduced number
queues - using io-uring is possible now even with a single
queue and entry.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c       | 35 +++--------------------------------
 fs/fuse/inode.c           |  2 +-
 include/uapi/linux/fuse.h |  3 +++
 3 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 92401adecf813b1c4570d925718be772c8f02975..aca71ce5632efd1d80e3ac0ad4e81ac1536dbc47 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -999,31 +999,6 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	return 0;
 }
 
-static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
-{
-	int qid;
-	struct fuse_ring_queue *queue;
-	bool ready = true;
-
-	for (qid = 0; qid < ring->max_nr_queues && ready; qid++) {
-		if (current_qid == qid)
-			continue;
-
-		queue = ring->queues[qid];
-		if (!queue) {
-			ready = false;
-			break;
-		}
-
-		spin_lock(&queue->lock);
-		if (list_empty(&queue->ent_avail_queue))
-			ready = false;
-		spin_unlock(&queue->lock);
-	}
-
-	return ready;
-}
-
 /*
  * fuse_uring_req_fetch command handling
  */
@@ -1051,13 +1026,9 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
 
 	if (!ring->ready) {
-		bool ready = is_ring_ready(ring, queue->qid);
-
-		if (ready) {
-			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
-			WRITE_ONCE(ring->ready, true);
-			wake_up_all(&fc->blocked_waitq);
-		}
+		WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
+		WRITE_ONCE(ring->ready, true);
+		wake_up_all(&fc->blocked_waitq);
 	}
 }
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d1babf56f25470fcc08fe400467b3450e8b7464a..3f97cc307b4d77e12334180731589c579b2eb7a2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1503,7 +1503,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
 		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
-		FUSE_REQUEST_TIMEOUT;
+		FUSE_REQUEST_TIMEOUT | FUSE_URING_REDUCED_Q;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12bd39f535188cb5466688eba42263..3da20d9bba1cb6336734511d21da9f64cea0e720 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -448,6 +448,8 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_URING_REDUCED_Q: Client (kernel) supports less queues - Server is free
+ *			 to register between 1 and nr-core io-uring queues
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -495,6 +497,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_URING_REDUCED_Q (1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags

-- 
2.43.0


