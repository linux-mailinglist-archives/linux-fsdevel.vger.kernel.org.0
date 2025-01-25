Return-Path: <linux-fsdevel+bounces-40113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A0A1C4B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 18:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CA51885722
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 17:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A31178F5E;
	Sat, 25 Jan 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="wKc6XPrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8D70803
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827064; cv=fail; b=cqgZFNCH5lbP8BYd0+xpucG+GnO1OHOIeuADwkSfqXArT6xxNDRedt3EByYCpbQm2VMcCqdoxodHRlEtnzSNqvYnWF9tR0YJBkoWGwQer/cH8Hd93OX+o7P0e8CT84y+50thMq/ZF21VmmMnWTO5wlW1l25hRJ7DpIY8+JbQRfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827064; c=relaxed/simple;
	bh=xKmi7hZFPY4y51ArjrYHaE6HqhuZiZuSOyDuRlOKVIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GErUQKG5KoJ86OGZdprA+nw8i2k/3oGNhZ9Dmp1ZKPkzhbxRwdKMhETCcijwJDXvEaf06yIVlYy3FFBm3/R/sx6Y8h7meR+1iZ2dE2BPbB7B4OMyHCeBwEUKXjIrt+5+b59PttuD57n3Kn1Cb5YxTXPRGSaCrcqE7JgEPItBW7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=wKc6XPrk; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42]) by mx-outbound17-96.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 25 Jan 2025 17:44:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBSHRBmtr3RmU34t8L4/3PTadMCmigIska4hihadiRH+t21kTyZ+aapuAB5WZS/Ya1rb+pPsimAf1gLKeBT5VsCnCe5Q1YSv/vnBFtlLeVShayLl0lUWZ5Upag4MP+R9ZZMZqERrNhDLfMQsjWt5+Fq7tC/un05VbaQWT9mv5Ku7Emr7tJz2rYLCq8TrbrHg9PgHklB0iHE3LWbHHsf5etCWWgNa7NKda2T2eNGWdhdY09e0FILnu4jB9oGtyj3X2J54f5aUhMesF14m9L1GnBO2yvkqC5wxLiR1O1oiTsv1W/aAKFSth2dzFke4IO09pccsBnhwhIKjepaW48eWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbdeyY+3unnhvj87n4IYQxvetBxhM/bINF4A5vx6Y8c=;
 b=YSBTyLHpexnmJz8OOwfZczxo+bXN74/zbMb7cvKK0UhyVz+WdEEuNx2N7F6Ecld5MSd5tHLB4TYwS5xUy2poAiH150g8C1sOG1wwvdfSX789ppKf82rKtBh7HHmBCb614k1SsB9jIFMpRR+AO5m1/G7MHfD4sy9+YDM12XgLb3LCcBVjQgP2Oyr9sRWcNxjQQU4PBjT4wsHO5NRJFUekKum8zv/UKNw4JumtSuiv/62poZ4I+TjKZ4lJ0guJa+vZtyO2TtGE908u3CPtK26YFzqVEeo/r/uD9efbTfz7w23wXhfhk3A9LROhBFv4dUbBUQouQzZxjQn5vGNGpVDYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbdeyY+3unnhvj87n4IYQxvetBxhM/bINF4A5vx6Y8c=;
 b=wKc6XPrk2HQs+7/8KvbSxUWpzlNFykMmlblKbfcBr5lmoHaG3rp6NQHIiKcJmV0rql56TODJ2DxOAMKS5kPsmuzWPJS+DRt7YdOVElzvel0MNA16uJ/e8xOxg+asOMlXy39bLo6UlG91HgHmnA2wWxYnb7RAUj4vWNsKk2eDU2Y=
Received: from MN2PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:23a::28)
 by CY5PR19MB6446.namprd19.prod.outlook.com (2603:10b6:930:3e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Sat, 25 Jan
 2025 17:44:04 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::91) by MN2PR03CA0023.outlook.office365.com
 (2603:10b6:208:23a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.20 via Frontend Transport; Sat,
 25 Jan 2025 17:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Sat, 25 Jan 2025 17:44:04 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 23C8734;
	Sat, 25 Jan 2025 17:44:03 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Sat, 25 Jan 2025 18:43:58 +0100
Subject: [PATCH v2 3/7] fuse: {uring} Add struct fuse_req parameter to
 several functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-optimize-fuse-uring-req-timeouts-v2-3-7771a2300343@ddn.com>
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737827039; l=2034;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=xKmi7hZFPY4y51ArjrYHaE6HqhuZiZuSOyDuRlOKVIY=;
 b=JMKB8KNlUOCi+FWg6oEVRUjgColFMtY0TZVQ0zjzRvtP5suKLNFtuMS21Qat5zqd9H1Hg75tJ
 ovHAjCLOgM1DQZkeSQGgK4kYyEc0NZg4KNW9JfFNQd87hx1PwThfga9
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|CY5PR19MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: c32ce68c-e6e8-49ce-18ce-08dd3d67dc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHpIWiszMjlNK2RUN0tUb3VVUlR6UWRRVWwxUXNYOTlSQkhhak9ZY1YxK1lY?=
 =?utf-8?B?Z2V4TkwwOU5uaGp6RkIwZEhLbUdhWGhQN3pDc01jYmtsamRMMEZuQjUwTkhj?=
 =?utf-8?B?RzZFM2RIUzlqYmdJVW9UdGJCU0Q4ajlQREZIV2hiVVhwd1J4eW1lL2ZzdTBJ?=
 =?utf-8?B?c3lHSklzSHIrL2JnazdOa3FITlBMRjl1MEd0UGtDMnNLdk5TbmtSZE1MY3pt?=
 =?utf-8?B?bS9GQTFIS1BjM3ArV01YYWJyMTkySTIzaUZjNmpraEYyTFFZS0txZldIVmdw?=
 =?utf-8?B?V0QwQnFXOVROZXNKWTVaZlVGbFg2M05CUkQrU1BVNS9HTmcxQ1dnZTVpMDVB?=
 =?utf-8?B?b3FYbEh1cXhrVDJqMjZvcDRmaVhWdXdlWWEzTzFZNU8xdWNRNEg1bmdyeUVN?=
 =?utf-8?B?amxTM3F3WHFjMWczOHRNRjhVbzJWRHhRN3lPVkNoSXZYUlFnYjVBVFVNbmkr?=
 =?utf-8?B?TjQ5TjNRajZVSVNZSEJNbVBpMThjSE83TnBzU1VzME81bnkzRkJzbU13OVYv?=
 =?utf-8?B?WmsrTU5XOVpUY3hFU0lNdzcyaVFzR2VYTGIwZlhyS3lWeHpRNkpkazM4R2FL?=
 =?utf-8?B?UmIwSFZpRHJPbnpXQ2xrT0xURzZ4QlVsRWk0V1EyTU11SjlxNnl4RWhrY1Rz?=
 =?utf-8?B?VVcxSjhnbTBWditDVmdmQTg5RHU5R1JaQngxbWltNDh6WGNDeVFHS3NIdzlH?=
 =?utf-8?B?L2p2dG50U0F2V3FTMStPWWwzSVA4bVRsdmRkU3B3ay9BWGdUY2w0b0oyUUFQ?=
 =?utf-8?B?RHVCakZpOEZXOUNaQmU5T1pkZzBFRWRaRnMwM284akpIcnh6TXFDM0dJdjNV?=
 =?utf-8?B?bTNuNFpEYUN2UWcvK1R0Z3R0bWVqTnJJaHVoSCt5cm84S2gybHUxWTRZN2NN?=
 =?utf-8?B?eFVNUTIzM2FHVWZId0taU0JJUURUMmMwWlB1UkcxTFo0M1lGeENtVjlCcFhJ?=
 =?utf-8?B?UkEzaC9UUnJrTHlmWEFnMGNZRklnYUk2OWozb05tTHBQZWpPVk56MUl1NTJK?=
 =?utf-8?B?dzFuV09zS053ZjFFRnNxcmE1b1N1cFFpUnphVWZHaFN3T0FpRWJjRnRDWkNu?=
 =?utf-8?B?YTNGQnJwdzJNeEdLV00vVC9ScENuRFZjSzVvcWJyOU1IcU52dDFrZFMrYnVD?=
 =?utf-8?B?MDBnMVNmNlhRWGFyQnVEMm5hbm5MRGFBTXpDWTlFU2xrbWlTRzZ3cDdDTWIv?=
 =?utf-8?B?cTE2UzdtMTVZTk9zTldLZXJtZ2pDczRwUm9ka3VXb28wbEtFU2MyZmtFT24x?=
 =?utf-8?B?L3ZaVisvZXJiRzNSVWNZbHFQRnB6a21WZSttdXk3NUdyS1BXdHFTOFRoN094?=
 =?utf-8?B?R1BhK25lUm82ODAzcXdHT2ljUUhCanR3SDJGNXd4R2o0V0RvTFJRYW1ackZ5?=
 =?utf-8?B?MjZEY2FRVDI3LzNSemhqWGp4MElBOXZva05abnNwMjVmSDloMjVicHJMTjNV?=
 =?utf-8?B?VitPcWFFU2xJeVFCNnpVNExLNHpKWEZqeGpSVDlmb0tNOUo4SXBYamhtVU1w?=
 =?utf-8?B?MGtnNHNBV3grZTlrOTJSOUdOVzF5TDBnalBmVDFmMzVoU1hHaGdDMFNXOXVC?=
 =?utf-8?B?WDBEejluZG1nYmV1TDBBQzc4S0VmVU95OUF0T2doYU1MemgrUTYxbXJXTHVK?=
 =?utf-8?B?Z21oZFVRMllDUXNYWjhYNlpaanNXekVMREVGM1lHbHdYdlhCaDdNYW1JNTdw?=
 =?utf-8?B?aUdqT0t6L0RNZ0MzMHc0OUlQbmJoSXhZd0pmSWZaMWhYdFhPa3pwa2dSOUFl?=
 =?utf-8?B?MHJ1U3I0S3VKTFJCalVZamVyRU1TRDF6Yko3NEs1K3I2Q29Ld1B6cjZZbmpL?=
 =?utf-8?B?dUN1ZnB0c0xzampxbm5FYVQybWhvKzdKTjNjTS9pd1R1T1RuVGRvYTNvcnhj?=
 =?utf-8?B?SFVBbU1yTm5NU01oYXBVOE9VL1lGRDA2QzFOd2c4Z2FWMW5BSkNTU0dLQTRC?=
 =?utf-8?B?SHNUamZxUFNOWVVhRUZaUjBqUW4wRjJXWnZrNjdHRlR3NEQzN1d1MHMwRTNS?=
 =?utf-8?Q?eyHqLJMWu8AbzKu/6eypMpIv8NbF8I=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0OXbLBFT5Oi9qGrw07NJ0LSIpPO4h71r8iXqAw3fc+Nwu0/yIm5Gjf7Sq0zah5E4Tserv5VJkA1AvE+O2ep/HBhzkHg8dLZzzfsyvscvWTA35Ie69Jg2voRea5ZNdddDA6xBKjOwgaBqE/+PT5yXYUNWhMwewu71fynCeMjpFHR4S3yzdI5iHQo2eUb1WlFtY97a4jyU+pPQSJ8MXrUtMjqP0Xg4+2IpHLlAZWcBoAib5Yu1LqjGNQQSNEUOCSFa01H3UV8V7j7Or/LKQ15gSNl8VWMyQyvi/yYovtmv9RDhKtJsaUXujqojIGTCFiXun0coSA/REvrCkYxtTA9DQfh/HVZL0RgY1ZP8T4EKjVMctOvbHubQcW62BS2a9CSTbYrg/38ezh/Ue2zclU6VqSO8+qUH1SNJYDDHbASamzATOGDauT6/wphrwpCtxvAzusVQOpPYVZJidKYPPEp3YuXnk5qUj5BqdwyDaiOjlH62nZ96lhYGpTijz7pDd/DxOw63yxyCB+7ziWTpNlm3RKYFGv/dXGhr8l9aDaEkYvXCHrh2WUk8L8r6TERWKo7m1V9kVLm8pYpf/silbwNuqah9yfIrVQ5tzoVwJl6NKtrxR3JUIW/7B+4Ys07KfOTxIic8PSyE980DXMwOm+MRRQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 17:44:04.2300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32ce68c-e6e8-49ce-18ce-08dd3d67dc51
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6446
X-BESS-ID: 1737827046-104448-13352-1007-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.66.42
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaW5gZAVgZQ0Nww0cTM2NgyMS
	01KSnR1Ng41STFINHAJDU11STN0DJZqTYWAGtxKCRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262052 [from 
	cloudscan21-118.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is just a preparation for the follow up commit and adds
'struct fuse_req *' as parameter these functions

fuse_uring_prepare_send
fuse_uring_send_next_to_ring

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 3f2aef702694444cb3b817fd2f58b898a0af86bd..62a063fda3951d29c27f95c1941a06f38f7b8248 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -675,9 +675,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	return 0;
 }
 
-static int fuse_uring_prepare_send(struct fuse_ring_ent *ent)
+static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
+				   struct fuse_req *req)
 {
-	struct fuse_req *req = ent->fuse_req;
 	int err;
 
 	err = fuse_uring_copy_to_ring(ent, req);
@@ -695,13 +695,14 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent)
  * This is comparable with classical read(/dev/fuse)
  */
 static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
+					struct fuse_req *req,
 					unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	int err;
 	struct io_uring_cmd *cmd;
 
-	err = fuse_uring_prepare_send(ent);
+	err = fuse_uring_prepare_send(ent, req);
 	if (err)
 		return err;
 
@@ -838,7 +839,8 @@ static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
 	spin_unlock(&queue->lock);
 
 	if (has_next) {
-		err = fuse_uring_send_next_to_ring(ent, issue_flags);
+		err = fuse_uring_send_next_to_ring(ent, ent->fuse_req,
+						   issue_flags);
 		if (err)
 			goto retry;
 	}
@@ -1205,7 +1207,7 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 	int err;
 
 	if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
-		err = fuse_uring_prepare_send(ent);
+		err = fuse_uring_prepare_send(ent, ent->fuse_req);
 		if (err) {
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;

-- 
2.43.0


