Return-Path: <linux-fsdevel+bounces-36291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B520F9E0F31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 00:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EB6164865
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 23:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B0E1DF98E;
	Mon,  2 Dec 2024 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="cvQfpfHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3FE1DEFC2
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180494; cv=fail; b=S9btoKbv8ce6604UnVPZSwmzTCZQaAmEMiJFmkm7BbMDtk4oV9mEIsEnhombcU0Nl+U+zr+koh9JUje1o70DqD+Q0O0xgX2/+ENE2Sww3OlMsoWHqP0OT8pyWUVmtynuKW9tw5o7BGXuzmPFZ27/VVOlVFeZzlUUOBh9zidtksA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180494; c=relaxed/simple;
	bh=loI3oMCh7Ogj+v4RoKuM6QoI7SMYTi3JSoFqPETKiEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vBDZkAS7yIvmU7dJnkQmcVbZ8drIz3Zr4pj+iOESky0W37woIcoDhP96vx6/Am9ab2tVUIyYGrthJA8iCAZH/e088CK0BR09OlyNZo788lKsHR404kuXZRHATqJv3wRONVUOF/6Py5pqqY0I6gvopVQhPChQo4dLg5RsvDgTRjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=cvQfpfHV; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45]) by mx-outbound21-90.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 02 Dec 2024 23:01:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru2adyy75ZhriFeAE8EWgt9jIn+BVkI2q6W1fQcJ4/oTQYoPGJ7MVkhQ2iM/Oj/jap5XWeDkt/0DtWiZ0Lmp9Fhl5Euz77BiwlhN0ZnZC3ujK1xEbhCyvapDPF9BiiXkFz9yVHrS7ILc6Q1JFjXfC71ITXWu3WLc3Bq7ifHgDwxigQZcknFKus+ztgtxMUpKnMLT4UxJlSjKYHesVGBv4Nn2EnWliZNzbtvHkdEQO55maUlUDkqJcwQ9VJZ1Pa4nrQYI2UwqSEz6UHsQV5laIbWcqOb09T5juHEQKyeXx2mY5N3SiBjKT/2VUF21jopwG+Z5QbjwqTmRBG8Wd3iJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VB7NwbozzRJz1HQfIPyYMp+uILgFWnRA5aJ3BdVgQk=;
 b=vPnV8vljsyG/CTGiPXqd+ls0inufgB+2lQJu785liRKBnRcZjq8vDRm7/O3W9crHnjveZLt633Nag568GKVHyKG0rYnIRgphqEzf0SBVuQFtMtzSCbuy8Y8A4nhex6C0W56JCY5VS79zSae/n2+V76WKFyHKbrjWGV+t8HS5QgzrZCQH/Gu+YP5lELW3Pq5VhPFReudpoLLO2NxKVO9/lPVn8A7qrpy0G3jD2QH0XqDQex5em8Q/dRjrbPlDagAF4FT93nyam/II9eD25TNNWegegArt3uQfCbDr5jGtvDsZPR4phzQ3hCPZQ1BHvEC9swCNDz4/AcsYXbMhMfyzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VB7NwbozzRJz1HQfIPyYMp+uILgFWnRA5aJ3BdVgQk=;
 b=cvQfpfHVE1YZP2sxyAQSd2LhXEQUlrGDgrYDIH9e1PGstmtanYPSrt8tSysNJndm0nZxydp3PyvSsHZTZBTTSRSwtmPIjXVopU4/WCBfopUpUsHtFkgid84AL1+lw0p7TiY0LmDK1qtjMunxmCc77U30FtsR0lsvAEZf15e9VkA=
Received: from BYAPR21CA0008.namprd21.prod.outlook.com (2603:10b6:a03:114::18)
 by CO6PR19MB5338.namprd19.prod.outlook.com (2603:10b6:303:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 23:01:15 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::27) by BYAPR21CA0008.outlook.office365.com
 (2603:10b6:a03:114::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Mon, 2
 Dec 2024 23:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Mon, 2 Dec 2024 23:01:15 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 20F9255;
	Mon,  2 Dec 2024 23:01:13 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 03 Dec 2024 00:01:10 +0100
Subject: [PATCH v2] fuse: Set *nbytesp=0 in fuse_get_user_pages on
 allocation failure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com>
X-B4-Tracking: v=1; b=H4sIADU8TmcC/4WNTQ6CQAxGr0K6tmZmAgZdeQ9DyPyUoQsHMoNEQ
 7i7lQu4afO+fH3doFBmKnCrNsi0cuEpCZhTBX60KRJyEAajTK1l4MBvHF6F+khLLzv3s41U8GK
 vRnmnat3WINdzJqke5kcnPHJZpvw5Hq36l/53rho1tq7x3tuhcY7uIaSzn57Q7fv+BVRSaEO8A
 AAA
X-Change-ID: 20241202-fix-fuse_get_user_pages-6a920cb04184
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>, 
 Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
 syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733180473; l=2168;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=loI3oMCh7Ogj+v4RoKuM6QoI7SMYTi3JSoFqPETKiEw=;
 b=+LG0K8d01U3s/dG820A8LNJZLFDZLKjZ9PKSUbLDsBN5pA6y0blGHaN8U+pKvCyegn0Nfh3oU
 uS5TcfS9QQ5CAoNKwdkBaf+QTmpPxqvU+Auk5Ksy77ZUKx5+7lvqcgi
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CO6PR19MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: a2807ab4-1f73-4da2-5fb1-08dd13253935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlJlajRCU3cralEvOGw0d3ZuN25oQ1VPeTVYSHdZSFZMSFVsWXlueEZXeXk0?=
 =?utf-8?B?ZVdWY2VZU3BvZjRFUXp1ZzdHdE1LbkpjVUM1S3Bkb05NaGJKR2xjcGVTdTRI?=
 =?utf-8?B?L2hiZWZ1NW4xYXBLdHNyVEVTU3pOaE9iN2dCQk54RHhEaTBEZ2xsemc0Yk5S?=
 =?utf-8?B?b21IRWpKdzVRaElPb0xaays1Ulkwd0U1SHErSUxYdU8rNDNHNlUyamZ5WUE4?=
 =?utf-8?B?WWREMm0vd090NWQvSFVpa2dOTUhPd2Y1RW1PSkVCb0x3SG41UmpXTDhob1U4?=
 =?utf-8?B?ZE92TXVtWm51clQ3cHJQZEZEY0x6ZnV5bGNISnkwamJyR3kxVTZreXl6TUIv?=
 =?utf-8?B?cExFbVFlajljMWRJZ2NJNWMwOVhsVmpjQktkK3J2SFFyNC83bHVVa1dUaVdl?=
 =?utf-8?B?RkpCVy83NHlhaVJwd2x1NFFFS0JmcHJ5a29MbVdIbjFwOGprVGZhMmx5ZVlR?=
 =?utf-8?B?V0tqdFpucHJ5TDlmQlZzdk9WNU9xZmFDcUxjOHVsbmFsbXlrZ0ZJeURXY0hE?=
 =?utf-8?B?SE1HU1YwZGhTbzZqMDJ3eFpER0YydkxQMDRYc2RVSmpUeUJsTkJGTER3UmpI?=
 =?utf-8?B?U2VxNGVYMHFtcTl5MkNxdGU3SUJNalFMOVJEQXU0ZEdxWU5HbkgwbVJvb29U?=
 =?utf-8?B?cFY2LzZlRnBMYjgydmFQbXVNdmJ5SkpvNDBOUVAxUTJoSmwwTWpqNCtCbWFx?=
 =?utf-8?B?QlhqQTlidmdsYmNnQnYyVDkvZXhDVS9lNDB3MndIK01VUjFwa2t4S0FHbEhZ?=
 =?utf-8?B?UVhETUZxenYvd2xNN1RNZVBMMVc1MGgvc0Jad3RkVTk3RlM1S0tlZUZUVG1Z?=
 =?utf-8?B?TjNXNytYcUZPSGNHL1lIQk11dzJvdHA3MmUxbm1lNFkxanBZYU5IazZFSHYz?=
 =?utf-8?B?YkMyMkVHWHl6MFoyZk9QUzRWcVF4eEVWVUxSQ2dDK3J2MHZLUVIvM1ZOODNT?=
 =?utf-8?B?RS9uZ3kvbUs4SSs2TmJyMU02V3BtMHdGWVIxeG5GODNGK1JneFFGMXRYNk9a?=
 =?utf-8?B?WVZJR1lHblFaZVZUQmJmcWlSUHBGelFiM3VqTk16dktaYXU2eFZtS2dDUEhR?=
 =?utf-8?B?VXRsNzYzSjUra05qNFRvRDczL2hORitFdzFuYkViZHNKR2tpYWpOL0hGRjBR?=
 =?utf-8?B?alYybWZHdDFkcG5PMmNZM2Y2N0dCT2FCUWZvdVZZV3FLU2t4RmlzRHFtVE9o?=
 =?utf-8?B?Rm5rSlRzQXE4RmNrSGlkcnV0YWw3WnU3b2NUTEtkUmcyRzZ4NzFuTFkxUm1Q?=
 =?utf-8?B?Wkl0Tmg4N1A4UjhDazNKREN0V1piSC9EVC9YRXVvSnZ5ampwcUtNek1qVW5P?=
 =?utf-8?B?SnIxRlpMR0RCSFdQUExINFgwY3Y1OFUrZG9xaVp5UVl1R3hNNWFvME9pemkr?=
 =?utf-8?B?R2VpQVdWak4xU1RPWHJ3ZFBFV3pRb3RZSWVNZ1E5K29RZCsxbmxtc0Y3OE5O?=
 =?utf-8?B?NFBOZ3RBakxTcVl6TkJua2duRitYYTdjTElwRWpBbTNsNHVwcmdSVEJXT0dl?=
 =?utf-8?B?NmZJMkxyNTdzekY4bHJIZjN3ejVQck95Z3IyWmZhakx1TDhuQTRsREhMTVpX?=
 =?utf-8?B?WWZpdGszUXIvNk81M3E0ZXREb3dyQTV0Z3J4d0dZeWtvSmt5cmk4TG5idmNG?=
 =?utf-8?B?WDFFQ1ZKQTBuQXhYU3cvNWVrT2Q5cEhCTDBkVTNLaWtrVGY3YUFvb01uLzVU?=
 =?utf-8?B?MmZMeWY2RTFrUjJXaHNvL3RUNlpNRlF4MTd2ZDJWTE8xRWEvQWVWRWg4c2xh?=
 =?utf-8?B?b25Jdm9ZdkNVOHQvd0JGazJyK0dKTUQ1Wk04OG9IMEp2Wktld0FPczBSa05h?=
 =?utf-8?B?UnBFZlFnYlBLRVh4UnJBbDdZYXBVMjlpdE0xd2tlNGorcXhDclRuL0ZZUUZa?=
 =?utf-8?B?Mm9jZHk0YXdLemIyNElYaDVJb2hOaDhHc04wNW9MdjV2Y3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EusL1IcQaiwm9eeHy4vKx8XV2m65HC7CU1+BbiI63rINhjlVxeip78wgVkVfHMPIKxb4cwqMM8WPtYMDKUYIEB4a/d3h7oWLAOYCbrvOnzp7HRpRChz6KI2owwjpCCfC+Itx7PKBhNaBOoR1/8M9iV+KcWqu3PVVZP7YjFHDwVPR8mSAyu+HvogBvMuqLbgwNBdzFUszK/yQYBMjMnh49GKeKCOvtZ3ckyLOb59tYouaEcepVJufagXvSuWOfKLa4cOzOiycAH/11QwKx5kADZQQDDBFVVuCeYT9NCLmxE0etEhsMvb3dNHBiBnGH5TnNHUoJZJASQCXbVGH0OCDoPq8QMyHUtQzHFqEeZI10g9qdp2yARo32+QPyroX3Mi7aMPaNCTDjGdenbdKLGV/Tlt6CtDHN1GlnH2SY9zj/pjgvBE8zYvYUEZqeyzOQE6RAIX11QmztvjWoeENZAS3QDgQ+rRtNL2p04UO4MaJPhnXb7ijlpx3k5qKVXdxATCXurCNefPWc74wSvTy2fZTHKcal9emtrJiX6/2txRAjOOpC1NHfzDUr9/L3VNx2y7jEsuz6+ErgNbQU0UKK9mc9+NfDJGo/NOHVgNNOU8iFnCYXYH6DOxfEwVnpAGzeDknEDxW5P32zl/mpBNNua/vwg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 23:01:15.0057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2807ab4-1f73-4da2-5fb1-08dd13253935
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5338
X-BESS-ID: 1733180477-105466-1669-14111-1
X-BESS-VER: 2019.1_20241126.2220
X-BESS-Apparent-Source-IP: 104.47.56.45
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGhgZAVgZQ0NLAMs3SJDXJ0i
	TZNCXN2DTN2DjJ3Ngy1SDZ0ijV0jRFqTYWAPY/vDtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.260846 [from 
	cloudscan9-186.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

In fuse_get_user_pages(), set *nbytesp to 0 when struct page **pages
allocation fails. This prevents the caller (fuse_direct_io) from making
incorrect assumptions that could lead to NULL pointer dereferences
when processing the request reply.

Previously, *nbytesp was left unmodified on allocation failure, which
could cause issues if the caller assumed pages had been added to
ap->descs[] when they hadn't.

Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
Changes in v2:
- Set ret in the (!pages) condition only to avoid returning
  ENOMEM when the while loop would not do anything
- Remove the error check in fuse_copy_do(), that is a bit debatable.
  I had added it to prevent kernel crashes on fuse error, but then
  it causes 'visual clutter' (Joanne)
- Link to v1: https://lore.kernel.org/r/20241202-fix-fuse_get_user_pages-v1-1-8b5cccaf5bbe@ddn.com
---
 fs/fuse/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 88d0946b5bc98705e0d895bc798aa4d9df080c3c..ae74d2b7ad5be14e4d157495e7c00fcf3fc40625 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1541,8 +1541,10 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	 */
 	struct page **pages = kzalloc(max_pages * sizeof(struct page *),
 				      GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	if (!pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	while (nbytes < *nbytesp && nr_pages < max_pages) {
 		unsigned nfolios, i;
@@ -1584,6 +1586,7 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	else
 		ap->args.out_pages = true;
 
+out:
 	*nbytesp = nbytes;
 
 	return ret < 0 ? ret : 0;

---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241202-fix-fuse_get_user_pages-6a920cb04184

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


