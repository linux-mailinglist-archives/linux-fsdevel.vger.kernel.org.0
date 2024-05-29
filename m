Return-Path: <linux-fsdevel+bounces-20467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3EC8D3E64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E7B2256C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74241C0DC7;
	Wed, 29 May 2024 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="1DdteggO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EE15B552
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007612; cv=fail; b=MZry3alIM5YNgblTyxTv2BdzpczWSupLSWqhenwuyaQaJTFrn4kqZE5H7kyNLrtIuO6K+EnJxY8BQt0sfwhgkmWMIpZKPohfNkTYtrI7JNCCJA8Dwv8g6SFOjzqynD82iCXOfs4z5722k7khUvBDTN4caU2Igek+rwU0x9UbXHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007612; c=relaxed/simple;
	bh=ykdZ3lsNXXK395eD8JO7ON7n6z6X51OKzfrXSwxvITs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=TgIBMAfVW/kuGoLZkUEK8+s7D1MOdq0If4tRXESveiiv1Q5/w4iAzDslaImfCD1oNar00UDS8byyhGP989fZIgU8JkwnPmSdg6ycp+bz5namEBBaZ+qLgtB6FiTqJawEnOas3IpdL0XsizsTcnV0FkYN3UuuivSvWUA1pVNS+xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=1DdteggO; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44]) by mx-outbound42-38.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBRKPBKCw0EI/SMrorFMEAr2wEomwhD5EmYr6YyZqASh/YGM27dLIidbpz+1xXR+Vw59DMkgokg+6DgeUPvTex9GVflIqBbX0/fkg6aLocrkRSRjOVz3M4VvDvo+DmgjybfXGikwENY7M5nskpHLmsGn7Whc7fK3WzS3wLAY3C/r1bdjjN/vCIECyf6iEqUgMU3X7LIfjxv6eFV7LknqLT4bj1XU77l7k48UPEeBH42F9sIJhhnugCnREmwJco4XOBHaWXVtxU+X7y8wTJfk5A211FbMeBJExfTdumFyPZMNMUE7E8lvFcvG5p+zbPd/ngGqJafFxEKzpPGKj1MS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjv5dbjJ16GG3iK99Ld3pUZNQSnzorgHj+tlht9zc94=;
 b=jJ3DVv+TspziOOr0JcKDLudcn7TZuPID6+rh6Ksowa2DeLl+sdhhWx1UvN2F897Y/Yx2t2d4akbqnohTyv+rCNtC2QcgoFagxKPx+7gwKXhGV9Zn+pFiLaWKhMBPsUUBsqpe6nQ2dhCnmd9EvhINovij4EEcm7kL76bGzI79EPo/t9HWvpX8uibZ23gFX1cfs6RcQeGMy2SWcJm0sF/8HmfQbk1bRFSkyDOYf3DwTqUOUVTpEyMI0Fx5LFAxy1/P4aFA6exQREi+Jl1pBZEo7GruJQ/Z1DXL0vJvxo44kQRK79jyMh7yi8qwN+gdxgTG7E8A5pOovFXWql+IkzEb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjv5dbjJ16GG3iK99Ld3pUZNQSnzorgHj+tlht9zc94=;
 b=1DdteggO0vpQkJZJgVLAM0CYRARMJDXV8kW72YeqgoF2wPUL9rZDAiTt4fSsou9aNFHlLhdYLdqiqXA09Eg6ejdgCeP4zYZv30tL8okmGodWT4moGLZDL7b7SXk3+NR+2y+2zZmcpdw/1wkxFzmS7gf0QaOp5AwvwbyeQpOHhiY=
Received: from BN8PR15CA0017.namprd15.prod.outlook.com (2603:10b6:408:c0::30)
 by BY3PR19MB5185.namprd19.prod.outlook.com (2603:10b6:a03:368::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 18:00:57 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:c0:cafe::c3) by BN8PR15CA0017.outlook.office365.com
 (2603:10b6:408:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 18:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:00:56 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 1A5D725;
	Wed, 29 May 2024 18:00:55 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:42 +0200
Subject: [PATCH RFC v2 07/19] fuse uring: Add an mmap method
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-7-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=5745;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=ykdZ3lsNXXK395eD8JO7ON7n6z6X51OKzfrXSwxvITs=;
 b=6s6Jqt7xriWk0pHQmXWy1wE8RRBQQ80JOavLoDZ20WF4qs4HDHzjFfF/4V3YJMXh+5+f8zYC0
 1n844CFktjvDjpXPSqBMAIWZQGeJj2nOSkjbbTO4rsTFhN0dwKfpljD
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|BY3PR19MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5c6d7d-d726-4cb2-7332-08dc80094a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eHl1bXl4N05FTzJRMERBSzVOcWpnNnBXYTlBcTVqQ21ILzZ0dGxtSVVzc09N?=
 =?utf-8?B?cGg4dFlVMENwWEFId1JQeWk2ZTc3YlpuZEVrWGRBTWJvWHZwQ040bWRiZzJN?=
 =?utf-8?B?QVQ3R2VLaXJaNUlOQ05OczdtdU5jMENsU0JadFdOZytKREUxVEttR0h1R21m?=
 =?utf-8?B?VTYvOC9rdXR4RjlJWjFlaEI2dFpIMXNwSTlZdWQ5cVpuclMvV3lIOVltbWhX?=
 =?utf-8?B?WHV2YmdFMlNHdXplOTMxYzZIVmQ0dG8yWnE5RitENHQ5RER1Nk9rZVZoT0l6?=
 =?utf-8?B?L1BKd1BlcW5lRlVXdVdVV2NFYlZNQ0FpUld5eHlXY3ZnajlVczNIOVZ5TGFo?=
 =?utf-8?B?d1lBbkJFVkd2OXpZMUgxZFlJOXp6b3RyckVHdU1FRWlxcGFlb05welJwUUVY?=
 =?utf-8?B?WUg0TDR5TjF4bFp3RUkyK3EzWmFjb2s4R2lLSTFrOXVZaXl4V1dTU2NreWRO?=
 =?utf-8?B?U3dtcnoyTGJ4UTR3ejlSRDFiRWQ1c20xU0EvRCtCODhXcHVXdlpXUk1IbnBV?=
 =?utf-8?B?bytxYnN0NGZWUmtqNjNDMzJ0NENHK2UyVFgzNnhzR1RsMDNyWXZSMDl1c2x0?=
 =?utf-8?B?bk82RGU4bWw4ZkJJVG5NaVE5SWRiYTdHV203cVYrMHJoQ2xCZ2ZzKzJtb3hx?=
 =?utf-8?B?U0pmS05qaS9RS3NkdkhUbDFBbUZ3K1g2NWNyN0NTc09TbldDN3NUTkxjRXNt?=
 =?utf-8?B?T1NNZEVEQzFPU0N3WGNOcHp0LzhpWTN5QmI3dENWVnc5WktOdmwvTDJtNEpY?=
 =?utf-8?B?L3ZDWXNkRnFNTUp3a1ErSFMxN0lSWmhLUTJQb1lxNlo1VnE3cjlXTXY3RWQ0?=
 =?utf-8?B?V0NJY2FUNTU4dm8yYjNEWWpmL1ltUUQ0Y0pGMDdURnJEUnVXK0F1MWRzRFhr?=
 =?utf-8?B?Q2JQckVZU2VSRUxxQzM5K2JHYnJZcGh1eG51M2dWTW1iOGNabFl3TlNZSU8r?=
 =?utf-8?B?SWpnY29SV0ZmZ1QxRUpuZDhCTmtwcXRvaGd3WFkwUTNvbTVQU0VrYnYwK1BU?=
 =?utf-8?B?cUFOWGV0UkJwdi9qMzlKWWJXRGgwZ2l4dE1qdXJ3R2pjVUUvUjZha3F1amR1?=
 =?utf-8?B?RlE0d0x6S1JtMUIrSS9SbmxXZm9oUmRNZU5IaHNmR0Ruc2orcWdWRFFzVGYw?=
 =?utf-8?B?UU5wNHZJQVEvS1MyRzZnQ2dZL0hiZjQrWU9JNzNGbVFWTHVkSTVXK3lITmlD?=
 =?utf-8?B?Y1UzMktZZ002eGg5SU5MVC9Oc1g5MERWbWFrMVhqekQ2a3pnZ1lhdlRWRjlz?=
 =?utf-8?B?NUJtMzdSZnNQbTRJS2FnMmJ4RWtIMTVackFydHpMeVVkUGRmbzNkZGpPcXk2?=
 =?utf-8?B?c2tiU3NaWE9iMEVlVDNWcWFFS1JyRXdEUURCQlVRV1RzZnFaOFVtaGJ6MTcw?=
 =?utf-8?B?MXZpRnF4U0QwTmhSWEtmemxUZktBYm9UTEJ2TWhpeGNsMDJKVG5iZkpYN2dP?=
 =?utf-8?B?cmtYMGRoaEZtREMydW5ySFFSakhkb1dGY3JSbGpMd1NvbGE2eGRDRE81RmFm?=
 =?utf-8?B?T3pmOHBseGc1dFI2T0ZRd051U1o0YnlHYit3MEgwRDR1ZGVEWStSc2IxSWIx?=
 =?utf-8?B?N1hhY2lGTzIybU5LdU9YbldJRExHQ1RzRDBydURycU5rbTQ4aURLbHUrbTNX?=
 =?utf-8?B?aEZYamYya2xKQzA1OExpMkkwN2c3MWtuRnB2dm14TlhJK1BXd09QRzNERG04?=
 =?utf-8?B?aUFGcjJ5Qllxb1dBSWdHOEk5OEt4S2xWdGUrNUFTRlFmQW5KU3VOVXZFamVn?=
 =?utf-8?B?c0FZTUFMTjY5NS91d0NJY1ZSbXdnQXB2Y29La2pXYmE2UmM1NWxYc2w4MUFk?=
 =?utf-8?B?TGpMdXdMMkd0OFFNalgzQStzT3J1SUU1Mk5EK3IwTC9WZDVKanJ0eSswbHNt?=
 =?utf-8?Q?t5HJayX0Jpmvw?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 EDzWxt2VZc1gGdGdYEBxQXTH7zd8gZIf14vXuSzduwWkVv/9E2Ci75eqoWG6tjxd59kA3AKRyravaS8tHLdzF9A8odIXWkwfOri19ZzwJnbJIdmYywHUxkLm1l+wwDLzf+BhJcuxZeR09NxPOADBFKS1RPG0AbDKTRzHcdM7IqGid+iIi1tnasBwW3yls88h5B48cNTUPQRyTspS2yI3Ba4WG3lvz89cDojHdSs2w2Q28IfQF9j9lBcY/hyObnHgJPunWI02ReAiKTvt0CRpSUak6Hg7wJ4Fvp5HcVWBnoaeAxUFfY5a3CGQm1iM2Ofn75G8cwlyPK6bALW66yv/0RQFjDfLkNFcRsmsmXn1J7keiya8WY6kmpMB/h/yb2Cy/hID3W33JhH7sow0aSgI6oB7Ducdqf402pOQw0/f3VgaVPqstU7r9KvAw1XC7/Knj2ze5Vovt7l1tOjcZCDNz/ohPI9OEWemnFGZSk7O0j+wTEqRPjvtoDpJ7IY/fC6020O+NwTLr2AuLDFraXU4L1M3ggq1PpiH8msibqFk9qzek0vxX6jlNLpqiO9SRypyYF2nFbyGjZ4hiMG2wAIlg3osBecnUrVo758Od0ISB9eoQn2RsUKX2mXSy0PBCCVC0C/ljEvoQeINXf7EqLavDw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:56.9781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5c6d7d-d726-4cb2-7332-08dc80094a68
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5185
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717007608-110790-12643-48789-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.66.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamJuZAVgZQMNXYLNnM1DjVMs
	nYyNwg0cjYMNE4zTLJ0MI0ydIg1TBRqTYWACRdiIZBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan19-133.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c             |   3 ++
 fs/fuse/dev_uring.c       | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h     |  22 +++++++++
 include/uapi/linux/fuse.h |   3 ++
 4 files changed, 142 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index bc77413932cf..349c1d16b0df 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2470,6 +2470,9 @@ const struct file_operations fuse_dev_operations = {
 	.fasync		= fuse_dev_fasync,
 	.unlocked_ioctl = fuse_dev_ioctl,
 	.compat_ioctl   = compat_ptr_ioctl,
+#if IS_ENABLED(CONFIG_FUSE_IO_URING)
+	.mmap		= fuse_uring_mmap,
+#endif
 };
 EXPORT_SYMBOL_GPL(fuse_dev_operations);
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 702a994cf192..9491bdaa5716 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -120,3 +120,117 @@ void fuse_uring_ring_destruct(struct fuse_ring *ring)
 
 	mutex_destroy(&ring->start_stop_lock);
 }
+
+static inline int fuse_uring_current_nodeid(void)
+{
+	int cpu;
+	const struct cpumask *proc_mask = current->cpus_ptr;
+
+	cpu = cpumask_first(proc_mask);
+
+	return cpu_to_node(cpu);
+}
+
+static char *fuse_uring_alloc_queue_buf(int size, int node)
+{
+	char *buf;
+
+	if (size <= 0) {
+		pr_info("Invalid queue buf size: %d.\n", size);
+		return ERR_PTR(-EINVAL);
+	}
+
+	buf = vmalloc_node_user(size, node);
+	return buf ? buf : ERR_PTR(-ENOMEM);
+}
+
+/**
+ * fuse uring mmap, per ring qeuue.
+ * Userpsace maps a kernel allocated ring/queue buffer. For numa awareness,
+ * userspace needs to run the do the mapping from a core bound thread.
+ */
+int
+fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct fuse_dev *fud = fuse_get_dev(filp);
+	struct fuse_conn *fc;
+	struct fuse_ring *ring;
+	size_t sz = vma->vm_end - vma->vm_start;
+	int ret;
+	struct fuse_uring_mbuf *new_node = NULL;
+	void *buf = NULL;
+	int nodeid;
+
+	if (vma->vm_pgoff << PAGE_SHIFT != FUSE_URING_MMAP_OFF) {
+		pr_debug("Invalid offset, expected %llu got %lu\n",
+			 FUSE_URING_MMAP_OFF, vma->vm_pgoff << PAGE_SHIFT);
+		return -EINVAL;
+	}
+
+	if (!fud)
+		return -ENODEV;
+	fc = fud->fc;
+	ring = fc->ring;
+	if (!ring)
+		return -ENODEV;
+
+	nodeid = ring->numa_aware ? fuse_uring_current_nodeid() : NUMA_NO_NODE;
+
+	/* check if uring is configured and if the requested size matches */
+	if (ring->nr_queues == 0 || ring->queue_depth == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (sz != ring->queue_buf_size) {
+		ret = -EINVAL;
+		pr_devel("mmap size mismatch, expected %zu got %zu\n",
+			 ring->queue_buf_size, sz);
+		goto out;
+	}
+
+	if (current->nr_cpus_allowed != 1 && ring->numa_aware) {
+		ret = -EINVAL;
+		pr_debug(
+			"Numa awareness, but thread has more than allowed cpu.\n");
+		goto out;
+	}
+
+	buf = fuse_uring_alloc_queue_buf(ring->queue_buf_size, nodeid);
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
+		goto out;
+	}
+
+	new_node = kmalloc(sizeof(*new_node), GFP_USER);
+	if (unlikely(new_node == NULL)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = remap_vmalloc_range(vma, buf, 0);
+	if (ret)
+		goto out;
+
+	mutex_lock(&ring->start_stop_lock);
+	/*
+	 * In this function we do not know the queue the buffer belongs to.
+	 * Later server side will pass the mmaped address, the kernel address
+	 * will be found through the map.
+	 */
+	new_node->kbuf = buf;
+	new_node->ubuf = (void *)vma->vm_start;
+	rb_add(&new_node->rb_node, &ring->mem_buf_map,
+	       fuse_uring_rb_tree_buf_less);
+	mutex_unlock(&ring->start_stop_lock);
+out:
+	if (ret) {
+		kfree(new_node);
+		vfree(buf);
+	}
+
+	pr_devel("%s: pid %d addr: %p sz: %zu  ret: %d\n", __func__,
+		 current->pid, (char *)vma->vm_start, sz, ret);
+
+	return ret;
+}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 58ab4671deff..c455ae0e729a 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -181,6 +181,7 @@ struct fuse_ring {
 
 void fuse_uring_abort_end_requests(struct fuse_ring *ring);
 int fuse_uring_conn_cfg(struct fuse_ring *ring, struct fuse_ring_config *rcfg);
+int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma);
 int fuse_uring_queue_cfg(struct fuse_ring *ring,
 			 struct fuse_ring_queue_config *qcfg);
 void fuse_uring_ring_destruct(struct fuse_ring *ring);
@@ -208,6 +209,27 @@ static inline void fuse_uring_conn_destruct(struct fuse_conn *fc)
 	kfree(ring);
 }
 
+static inline int fuse_uring_rb_tree_buf_cmp(const void *key,
+					     const struct rb_node *node)
+{
+	const struct fuse_uring_mbuf *entry =
+		rb_entry(node, struct fuse_uring_mbuf, rb_node);
+
+	if (key == entry->ubuf)
+		return 0;
+
+	return (unsigned long)key < (unsigned long)entry->ubuf ? -1 : 1;
+}
+
+static inline bool fuse_uring_rb_tree_buf_less(struct rb_node *node1,
+					       const struct rb_node *node2)
+{
+	const struct fuse_uring_mbuf *entry1 =
+		rb_entry(node1, struct fuse_uring_mbuf, rb_node);
+
+	return fuse_uring_rb_tree_buf_cmp(entry1->ubuf, node2) < 0;
+}
+
 static inline struct fuse_ring_queue *
 fuse_uring_get_queue(struct fuse_ring *ring, int qid)
 {
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 0449640f2501..00d0154ec2da 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1259,4 +1259,7 @@ struct fuse_supp_groups {
 #define FUSE_RING_HEADER_BUF_SIZE 4096
 #define FUSE_RING_MIN_IN_OUT_ARG_SIZE 4096
 
+/* The offset parameter is used to identify the request type */
+#define FUSE_URING_MMAP_OFF 0xf8000000ULL
+
 #endif /* _LINUX_FUSE_H */

-- 
2.40.1


