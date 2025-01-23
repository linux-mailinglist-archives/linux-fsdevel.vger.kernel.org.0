Return-Path: <linux-fsdevel+bounces-39973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E82A1A834
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620F3188C0BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B901547FF;
	Thu, 23 Jan 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="BwZBttAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7813FD86
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651348; cv=fail; b=doR0NgQcrFxiaZc/ydsZExyYxZ9ExTvjsSC8a1P9NmtcJU7C4A6yezENFvNsVOwaaLj4QHfbHhi9ndehM2i8wpKq5B9cqlUbDoIA1S0UAzHcRrF5GzLe6rkB/VXsQ2oTJ+YiAv41KS9hswBAJWzfmlKMiUFa09mAUiFy1HqI8sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651348; c=relaxed/simple;
	bh=rdfMq1HAE2encw/WY/ckMwU62JWj/mIGOqQmGzFXnRI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EdldBgvJH9KM1oIsG5TUhD1T6sAyxhY9nbeXwdp7+AUR54FFd/0fElL/KZH1KLa+/D8PrqQUqnEnOswcX+Dnux9O8yf+8cSsHjV05tR4LPJjqto+RBo3Jv8bJ9DunuJUdFuQmia/DPGnXkRhjy+DiI8ejRXAgwlJkSXOtafPPB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=BwZBttAV; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170]) by mx-outbound8-228.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 23 Jan 2025 16:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOwIYiOCMfNZUzCMUIMbObkDFI0uoEaWZvRNMm8rjuVNFXHsc3o1AqO10voJNE3SFuPpjBUVuAWh1B3K04AcSANJrvsC56sRFK1nnC85/AmffO+lRza+uCctlGbq4PmRzLc1B5UUeDHlvJTl4M8bpxfTfIrxRjM1FEKaZpmQWDO/7mYz4OrpeJlRFOF8rnHe4FBvXvXvqnESESJ6azRZ1ya0xI/wURahDG4p1W9lnm2K/jv1gd7THduaVLc3DGAAkAJ9lArzzZ6TMCXjz8e32Gn3fJcdLjWkD2uQFMtSdWeetgpnqA3zGrinzZrTAPPWeuW6eVT9/AmlZ1BJW5x48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/v/NdeUwuTrinsjh8ObvD9QjgyZuXzXfvHA826PVUA=;
 b=kr923zd7G+rrEEEmPNdRieDsiQi0rsoUkv77fzoTi1NvwxJK3HlFDtbmrYEY3DwQUE7+jRVPUyzI6tOlbvVKJ7XhcTZGpS4rRsC+moesOH3OMRD4Ry3pb/Pq83pwoqwxZQpAjCwbU+6wnv1dhx2aGiKYqMFV/KVMGammKLL0WNCOKycGshp95lndxM5fb/rLy8A1eW52iYIUetihzjUnwfSviJAFEMxqWic2BCdKb9BsK3TezFu+vktyrdDkcQ2Uu764tlrw0ebLya2eGKFXi5gbJ0WpmLidvojO2OXAn4H7bEMA37rEWX8TK5Cd/FC+os1yUZjcS5VQJizO/LIaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/v/NdeUwuTrinsjh8ObvD9QjgyZuXzXfvHA826PVUA=;
 b=BwZBttAVHvsv8XqDx7+FlA9PueOP8fQw7TiznraEBzTq6kJ3B1SiFfqnEz5/r786AG6PwKpj0JjKdH+jiCejAq4x03PU2b8vHHPieqJzW+oT0tFSvxwp72IrHhYLGd2hU6jmfrrcJoNl1ti3cgMBjK5tStJjtMwid/o3epCVGJQ=
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by DM6PR19MB3737.namprd19.prod.outlook.com (2603:10b6:5:248::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 16:55:32 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::a9) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Thu,
 23 Jan 2025 16:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Thu, 23 Jan 2025 16:55:32 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 79E5E58;
	Thu, 23 Jan 2025 16:55:31 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/5] fuse: over-io-uring fixes
Date: Thu, 23 Jan 2025 17:55:29 +0100
Message-Id: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIF0kmcC/x3NwQrCMAyA4VcZORtoqmvRVxEP65bOgKaSbkMYe
 3eLx+/y/ztUNuEKt24H402qFG2gUwfjc9CZUaZm8M73jvwZ81oZVxOdMRfDgHRB0dH4zboML1w
 KbuQwhXSlkGKM3kGLfYyzfP+j++M4fgC3pzV4AAAA
X-Change-ID: 20250123-fuse-uring-for-6-14-incremental-to-v10-b6b916b77720
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737651330; l=956;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=rdfMq1HAE2encw/WY/ckMwU62JWj/mIGOqQmGzFXnRI=;
 b=fh+zpwdJXx5kleEVONeP+AoRXXMKY4Ef4V3Pa9yVgieC5BAgpfUBwBJ9NQZsQDcqxS/R3ujBl
 3FN7UUJXeHMCgxJawds2ikna4j7bINxTkK+QyxAJVwA8+L9QtbsNLix
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DM6PR19MB3737:EE_
X-MS-Office365-Filtering-Correlation-Id: a840c1bf-559c-4d24-781f-08dd3bcebfb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ym1aWUhUaVFvT2pWMitLWTg5UlVEK0lBQ0QwYnd2NElpaER6SHVJQ21hRU1o?=
 =?utf-8?B?RTNWWitpd2RnVm8yWVJ3YnNiMUhWdkV6UVVncGc2cTZPUVhSaTk0M1lXK2Ix?=
 =?utf-8?B?dTZJbWppcXVzZ2QvSC9taHhGOFVtQ0J6Q09BSU5SblYzV1poVVp3MmxUdzd1?=
 =?utf-8?B?eENROW16Tk1zOUp6MUk1SFF0eXQxbzQ5VlhhamhrME9mRjRaU1NZNmxFTlhF?=
 =?utf-8?B?SGd1L0ltSXYrUXJMV0U5aTRLSVAxa2tRQ3N6dU9WamxaYzVwRUN2MTZvY1lm?=
 =?utf-8?B?byt1bEFNa3p6TW5sZEkvcTcwa3BFMzBwK1hQSHFqcWJadEVoMXczWGU1clVn?=
 =?utf-8?B?a0Jsdk9LeSs5ZW1XK25FeTVFMEJzK1VwR05iU05ySE1RY3BqaVJycDMxeE1M?=
 =?utf-8?B?WDVlRG9WY2NJSmo0a1VFSnpNb3NUNEMyK3FrYU9Mc2pwTWE2eWhwRWRBL2xE?=
 =?utf-8?B?WHFWby85dUxNMVZMcCtQdFk3ZnJ0MVhteG1pR3l3NFc1YTlxNVZlYlgxdzN0?=
 =?utf-8?B?SlRKaVhPV05idUZBZFpqRmtISjhIRHlJVWt5aUNCQWlGeVJGOThqQktuNjZX?=
 =?utf-8?B?MEJVQlFHa3RNWFNDd3o5STg1bXUxYTFkWThUSWoycGhEbk5SRUVIbDh0S1FK?=
 =?utf-8?B?Q3pSZW90ZnpxYlJWd2QvWDB3VkJpRmVXZ3VIVnA2Ym1vcHVrWmZOVnpuZktK?=
 =?utf-8?B?MGFvNmRKMllnSHR3ZGR4bmlPRkJDTGhncy9QTWlXNmdNdGxZQ09KaU9xdVpZ?=
 =?utf-8?B?R0x0VWlLc3Jla3lyMUxUNTdqVXphekVWcGNMQmVOM3UzRDdNb2pBZ2NkM1FO?=
 =?utf-8?B?YVUrUWJlR1hoVFI3S1l6eFdONEIwUVdRcGY1TzRaa1dDVGdqZGVZT2dKRHNT?=
 =?utf-8?B?ZWRIVFloeVl4Y1p6dkhxclM0aUxCcGpIeWRkV01XZHhJd1lnRWVRN2lQNUpv?=
 =?utf-8?B?aE15SEc1dEVWbFYwRk9kVFUwd3lzb0xXR1d3alJvZjQzbUtITVJ2ZGFMS29X?=
 =?utf-8?B?UGZVYndmNmgyUkVmUCtqZlM5NFB6VzBYRDZYNUlXbDdOZEFkSzJnTWs2Z2dm?=
 =?utf-8?B?SW9mbFNwOXhqNXhuaGQvRmVyQ2ZHM0VIRDZsbTdyZ0hZbG5yanVLdXJGK2lz?=
 =?utf-8?B?MUN6MUxkWUs3SGdHRmg2RjNiRFRWaWo3Z2w1NEN4emlBa3cwYytlVkxkS3Ni?=
 =?utf-8?B?dmJtT0s2Tmg1VUprK0x4a2RjNHFGZ1Q5Z0dyN052blhKYTBQMkJiY2xlYjZM?=
 =?utf-8?B?UFFoWC9vYkhRTUROdUlMUGRrNUx6ZGtyMENDd1hybTQrV1l0Wk9remg1VU80?=
 =?utf-8?B?c1l0cVVYSFVOakZnUzJOYmtFVSt5elcxOGY1aFV6cWVrcmlBUXptNmZwT1Fu?=
 =?utf-8?B?ejFEZVZmSktHUkNsZjZNbm9QTXQ0VFFmUjcvV0FOOWxPQnd5UVFzMFFEa1hX?=
 =?utf-8?B?UlRHa2p5ZHVGeDkwOXoySWhlOWlabmhKeC9QblkrLzM3dFNXTm1uQjZ4Vy9Z?=
 =?utf-8?B?Y05WSG95M2tVRVVwamppOUFSZHdaMmEwMTF0cnFsWms4by9FNGJtam5Wb0Ro?=
 =?utf-8?B?KzlHcGVKRE1ET2JLRnF1RzdkalgwN096SHVKU0s5VVYzUzBtMHl2WXFGaU1X?=
 =?utf-8?B?WUJxdjJOZXlpc2JvUXpZMHlORW5seXk0UnVkUUpCUWw5U2YvQ3FhNkFnWHNE?=
 =?utf-8?B?RkVXd0NURDBXcVNWeEt3UU1vYmE4NEtRNVpRLzhHYmMvRVQvU2tHblR5TU1X?=
 =?utf-8?B?YmRrNHQxMlZHVHVPL01nano5a3hUN1A2ZlZjMTE2L0tEY1hOd1ZyNG80QXZL?=
 =?utf-8?B?bmx6MVJGZDlSaVB6aWJ6MTg4K0llQ0YyRCthZVY1ZHJmUTVteUliZ2RiRlY0?=
 =?utf-8?B?WFNZa0tSdE41a1hNZUtBdDRVTnF6MytGR1c0eG5vc2VZWGlHU3FGSGt6Um9a?=
 =?utf-8?B?Z1VBTFA4VzQ2UUMvbUVMRjhTODhuMGZ6ZmxaNFM2MjF5ZG83bVlZcDU1bFZP?=
 =?utf-8?Q?7RvFZCU2oZwX7ytAopTBeOdN79vZzI=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WLGzpNlm0b6gNs4dpLUJR68NePmhk4oEjNr9VtS46B8dwJ2npcmVswxb4eH/QC9CqTiWqlWfBmBZyHJhPOqBGaetQuFc9/ANq9/I0qZ/XJ06eHqEAvDjP97EJa0L1iSGnOMployu+VyTF99ydFxKjfbz10Qh0LDce6HiiVj9xI5LIc7gC3eg9U4l9ghjv82+qvztunj8tCW0EeiHPI8vRyKDvI9gA9PQq0KnfVVr1ee+bTkYCkI72JXOOncOFsADF4N24B19nQiLXQEHV5ilgQIigL8Cew7Mpuzyctyi343gyPYq2WdqRblMQO2iCh4nEna9kMzFkJyqM9GYFsT02r9wVqd9Ht8UX8UpwImEGuadW2j+ROUEMwGhZbD41C6DoJWCmZt0abuUwDfEyi8WMVnDYu5g+RgJh8K6Hjpqhh0SwDIWnoV2Uqww9Bwn/2ZQPNVtjw7K8eXEXvF3p8/SZGwPPvTKo2uU266OKVHkI7bs17v7yoIcwQJn2Ja9s78uuMFxMfORvQuOJtOKbR5U4yFjwurkTaAjaGIOzTd90mh5xL7F74qrHoZcFChgo9UfPNY6Gve7Eo5ilOJgBCvZsAG43LeNXJ7n7Nehwd3B1NtwkJ8s//LojNhxl60GWCwV9nRy1whVEgA6JUGw9iiSbQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:55:32.1118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a840c1bf-559c-4d24-781f-08dd3bcebfb4
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3737
X-BESS-ID: 1737651335-102276-13470-14919-1
X-BESS-VER: 2019.1_20250122.1822
X-BESS-Apparent-Source-IP: 104.47.58.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpbGhkBGBlDM0iDZNDEtLdHS3D
	IxJc3MMM3YIiUxxdjcPCnF1CLVwFypNhYANfdqyEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262005 [from 
	cloudscan21-131.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is a list of fixes that came up from review of Luis
and smatch run from Dan.
I didn't put in commit id in the "Fixes:" line, as it is
fuse-io-uring is in linux next only and might get rebases
with new IDs.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (5):
      fuse: Fix copy_from_user error return code in fuse_uring_commit
      fuse: Remove an err= assignment and move a comment
      fuse: prevent disabling io-uring on active connections
      fuse: Remove unneeded include in fuse_dev_i.h
      fuse: Fix the struct fuse_args->in_args array size

 fs/fuse/dev_uring.c  | 23 ++++++++++++-----------
 fs/fuse/fuse_dev_i.h |  1 -
 fs/fuse/fuse_i.h     |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)
---
base-commit: a5ca7ba2e604b5d4eb54e1e2746851fdd5d9e98f
change-id: 20250123-fuse-uring-for-6-14-incremental-to-v10-b6b916b77720

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


