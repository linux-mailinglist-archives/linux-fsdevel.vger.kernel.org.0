Return-Path: <linux-fsdevel+bounces-20464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BED8D3E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB51F24007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F31C0DC4;
	Wed, 29 May 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Udz61Use"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC015B990
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007555; cv=fail; b=YoExcxU0VbkIE8kTNkitujN4ltW4Y/yzI7fsnkpnP6ApNKekrKtvyNpcAJPyAjgYd2x0uReKpKrueA1I7BY1oASQeo28zn5bQk9ZcXrwd9O4rYKWqG586qBdZcDCrIimh0VNX7mWp8PFEr/DvsU8Q3gfo4yDtPyWS17INcHNbfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007555; c=relaxed/simple;
	bh=5P+SlHhnYL+H2qDGLLceYVEx54wv23x8rBxC3VHaBIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=kaS5Pksd5SfEF69d0wb7nr2aGPm4n4VkvpXS4UFSuMqOpL0/Sjr4j8AnZXXMNx70j1pvVYJpUd7jp77xJ4tbXqu2XuIg+xyQ6vuDS8hxhQG8RJOE6bphtUoEjIVHvtoDxeu7bmDk4o9umRpssc3WApyh1t50iuTSDM2GdhZAnYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Udz61Use; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169]) by mx-outbound43-95.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:32:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqclSzZedTANCDhEVIwn2Uqslv+qXaq2tmWYFSp2T0mKH5ttfp/KxpeSopSoaXMQ+sIXHDTiYq26SUmolqdqZ+7oeKq2edU9XMj0NOiQYvaubXi34gU3AAjhlX/5tTsAOHiY4DUfoRBq0xSne11teF5+nZc47cq1z4KFVvscvbvwkRWZCV7MNBsP3xNVfdD0K8KlXWrAeWWFGG069dg+vmfzWga+Y8Y0IwcpwH6WMqtzOx9PKSGMn8rHG+IZSJ6ByU8FlKfB5FkHODr2XtbyXQ6H/kXrjFwh7rPHVtYiXwAijuYS5TsKG42PyEfwYSBVtnUrPqu7NQ0MaobRqOe23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aASvbKn+gE8AZu7tSrVfXZnhZs5w6zP3ns3NT3u/usU=;
 b=NEikDEAGbKFJZzi8BfyUpaCTRqXNzU7BjOqOSTeWZWaEcDNnKWvrn6n93L+OMI08xHIWBg1GrSq/WVYAzTvR53XaHsCq/b2bzrj/K/LvAM7CQcRjLkZs/HCgTwdcTdEMnPhgGnpcJuhODhLEuWSc7rjpO4Y4OrT01cZD2ulW6JeDAkl9XgFPZ3zceuZUzUxMZ+mpOBPx5odguOKuW8CTexm8nP6Og8eFh3O5gBhXyEWEV3h3N8//JNm3qvz3OQkvIXKXlDqU7oReSNg4cw8NS176A3a/goR6HVeu1s8hmSWHW/4h8jgOMcvUm0dAAdkLvoWD7NXivIk12vX2DDUjmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aASvbKn+gE8AZu7tSrVfXZnhZs5w6zP3ns3NT3u/usU=;
 b=Udz61UseCywoXwA/gVaxbWtYym3nRkApKTbJ0mHFzLgjcHZ1LkuMe0MmkBAOzvPsQHEnYxyrQipV8EpnyWk6wIE2Ca2gLyDhrbPOHUZMxDSCmUg0B76gBoORTxqbAQuLn7xRK83GMvcn5CQyTnPWTdQhrEc6PdwBu1/Iw5t7zGw=
Received: from CH0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:33::7)
 by BL0PR1901MB4721.namprd19.prod.outlook.com (2603:10b6:208:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 18:00:53 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::52) by CH0PR08CA0002.outlook.office365.com
 (2603:10b6:610:33::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 18:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22
 via Frontend Transport; Wed, 29 May 2024 18:00:52 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 330C825;
	Wed, 29 May 2024 18:00:52 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:38 +0200
Subject: [PATCH RFC v2 03/19] fuse: Move request bits
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-3-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=1165;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=5P+SlHhnYL+H2qDGLLceYVEx54wv23x8rBxC3VHaBIA=;
 b=2R0WPTWASSU0CasQsjhXxXy5gg3mO1J70SSQpabQ8PaV53rTL2NjybsBhGNBPuEX1Jijwyj0X
 IHtxp/AeQGdD3pfvxSJsgPDxZp5CXzPIvDqZ2j1F67FHFthCilOV2xd
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|BL0PR1901MB4721:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2e5acf-91ff-4e9a-7471-08dc800947f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elkrM282VmZxK2xFSjhpdUJUSzZFa3VoMGpHM3MxNTlJRGFLSU9DbUFKS0Rl?=
 =?utf-8?B?TlVTTVVKbEdjbC9uTDVYMmdMa3B3bGpmOGUxMlhwY3dPb0g3NThHYjF2ajda?=
 =?utf-8?B?bEo0b09DVWh6ZEpUTHBKV01nWGdrV3dDcWluU29ja0VRVEdRTW83SDA0QzA3?=
 =?utf-8?B?MncvejB4Q3pncDFjTzl5cVovWTU1NzVkTlJWOGlOdFpKc0FKL3JKemtCbDcv?=
 =?utf-8?B?aS9BaWxNQnFrUGQ1UjlqOHJsMllidDlSN1JkZ3Z0dDg1RHNvMkpYVktJMnY4?=
 =?utf-8?B?R1JBWEtRT2lRSXhJZWlZYmw4cEtLWS9Eay9xd1hPWUFkdnliSFMzY1pGMWw0?=
 =?utf-8?B?OFgvNk9LU3pvWVFkMWNIY2hRT1hOdVl4blBicWJiWHBlcDFZbTZOVTZLaVk2?=
 =?utf-8?B?c2hDbzNmWTBXczlxMWFNdFU3SHpSMVUrV3M2UFpxTEFUOFlxUkpwQ1lwK1ox?=
 =?utf-8?B?VDBNQXpyek1SaEYxNktLMWdWWWhoWFZiSE1DY3RJVHR2NlRFZ2V0WmFZMFhJ?=
 =?utf-8?B?MXc1bEs1VElyYjliOVNCNGhiSlFSQ1JWVTkyZGllRTl3RWVDYUZSbmpSVU5U?=
 =?utf-8?B?eWxjazRvT04vRHdmYUp0akxGbm5ZWnZqWHc3N1MrWHZsVGtaaGFPWkNCOXc3?=
 =?utf-8?B?S0ZiQTRzaWx2RzdTMzlQbHVmTVVIV1Jib1kwNWFBeGFDbUt1RGdyMXBHYzdh?=
 =?utf-8?B?WmdrQ2diblViYTJ6QWp2cFBQQmxLNnREVUxXc3dCb0lpamNDck5lMjBXc3Nh?=
 =?utf-8?B?L2w2aURxN2xHdTlZZ2JQZXJ2Ty93VDNyRWcySU05b3JWVmNDbmVaeEZTVWor?=
 =?utf-8?B?V0duRGNVbGdMZUJiWTlDWjJPeVJIV0hFMmU3dlJIdUxuRS9CbTRVL2pudUY4?=
 =?utf-8?B?V1ZNelZtd1VBY3NLUGNyWnAybVljT0tlQTBsK3NxYVRqNms4aUlLL1JqQkxV?=
 =?utf-8?B?Q2VkUGo5ZnpyKytzUVBKRkRaS3dvZ1Fqdmh0WWtWeUh4SGtHazlTekVHdzJH?=
 =?utf-8?B?OHdtUmNkZk9mRFBzYjhFSTE0eTM5Y1gybjM4aUlSemhBdzg1VEVBRUl1dnRz?=
 =?utf-8?B?ZGowazBYWXQrYkxkQ2dYRHdldGsrTmVpYTRmeW9kS3NOUUNSOVlrOVppUWpw?=
 =?utf-8?B?SmhqemVXck9mU3hBMVhrbFBpSm1QT1NxRW84SUx0bEs4c1FMeVA1aEFFVE9P?=
 =?utf-8?B?Nm1mZ1VVYnBrcVVHQ21sQ05kZERWa241TWJwTlBGVmFTMkZYZW4wSGN5RXNr?=
 =?utf-8?B?ZTBTQjErM3cwN2ZkbHZzWlJuTTY2TlFFWUluRnArOVFlUlRFTFJrVVNUdUVR?=
 =?utf-8?B?SFhQeVNSVkVWcGIvRnNsNDcvNS9veUdCUDBSVTc2cTBvTW5TdGc2SktKNmhY?=
 =?utf-8?B?Sm15a2U2RUFVcG41U003SUhNZ1NlUDZhVHFuMXdaU1c1bjVYZDFuenFVdnhG?=
 =?utf-8?B?ZUN6all4Z0tJMlpiNWxMNHdEOEpEc0ZkT3pWbC90a1BiYjVFMkovVmNuTFJD?=
 =?utf-8?B?blJQVUxOSEQ0aTlUTzVxS3JWYXZhclR1YkxSNkRneFJpeDhsN0lBVytZclpw?=
 =?utf-8?B?SEczU0QzZ2tMb0U2aWRwZTMySEFiTXVHQU84M2JiQVVtdEpwUXRXK3dMSFM5?=
 =?utf-8?B?MWZXTll4UXpQVkJsanlxZDVmM1pVOUMvRmM2WmZ3M0pNc05FWEMzaVREVGxI?=
 =?utf-8?B?RlhManc3TDluU0FTdEZtT2xXaFVENDlXVHdlY2U4YVpJamVZM3gyZ1VFL1Zp?=
 =?utf-8?B?c3c3V3FvcXoybWl4bHZuVVpRMmpBb0Z6eXZDMHd4N3N2OWpiNnQwYUxCbk56?=
 =?utf-8?B?NTIzNXhyWnlndUdlL1dVNFc5WUZCU3h3ejU3S0luRHZXWitRNUZtV1VmOEoy?=
 =?utf-8?Q?DabVB3LwczaKW?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A4S+gPmxwDTpzhEhl1Gt7vC328WqgahzDYJNElAkOfQhkiW+++3XozU2HlR9gBHAgrFjdSXilZ5GAFgbIokFAbgt80f5ej6IkEIXcgDNRV8nJq+6QmktCG/of5L2g5WGU1KRVQwHOit+izs8EoVrG8/wyWVHD+3JbtqQ2kEVyH5QGdHg7B5tKtuHlfVJ77xXs3yw4Stxa2/WSCustXSq6nAy1BUV1am7cCdYGDdw0idz6IMgxtGqaOSeiBTOMJxKy0GqE0dk7LxpuMVTsKanCaCKZa/YWxChBIj76J2o/Yw4y2cbbdFeFGdDxqn9DXJ2i/wPV9WNphAlWnL4VHDxFGICEugOs2cux4w8Z7nWXKY0ODedGYULSIalyulUCNkPvNtyzNLXonmGRhDbJ2TY8J7aaEcdGZMgUOkZH9OlGfryOY12VuONjjPrNcK07r2uTnIVXQ26/cAEDmLY1iC/9OAtnXBDb9AnzpX3YtusnJZTh1hV1ReDXPMkg6iAtPJe9W9bSVruo3KUlZT6mf9my493ZbiqWNflt+2OW1ZOXi8C3sFxCWsABL0GOt4XuSE3bqaWbzP5jwOZKU4LLPAM7WYT3EohYi4RdToAa0gAswOxC2cR2WRYJL0izDZK05/QlxBS4DGjoz5d/k1UinyHWQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:52.8872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2e5acf-91ff-4e9a-7471-08dc800947f3
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB4721
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717007552-111103-12694-19299-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.73.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGRqZAVgZQ0CLRNNk8zdwyLc
	nQLMk8ycgi1cLAwiDV3NjSKM3MzMxAqTYWAN+niK9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan13-251.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

These are needed by dev_uring functions as well

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        | 4 ----
 fs/fuse/fuse_dev_i.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3317942b211c..b98ecb197a28 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -26,10 +26,6 @@
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
 
-/* Ordinary requests have even IDs, while interrupts IDs are odd */
-#define FUSE_INT_REQ_BIT (1ULL << 0)
-#define FUSE_REQ_ID_STEP (1ULL << 1)
-
 static struct kmem_cache *fuse_req_cachep;
 
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index b38e67b3f889..6c506f040d5f 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -8,6 +8,10 @@
 
 #include <linux/types.h>
 
+/* Ordinary requests have even IDs, while interrupts IDs are odd */
+#define FUSE_INT_REQ_BIT (1ULL << 0)
+#define FUSE_REQ_ID_STEP (1ULL << 1)
+
 static inline struct fuse_dev *fuse_get_dev(struct file *file)
 {
 	/*

-- 
2.40.1


