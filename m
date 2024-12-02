Return-Path: <linux-fsdevel+bounces-36287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAABF9E0EB3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 23:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D78C1657A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 22:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4C1DA103;
	Mon,  2 Dec 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="f+KOoC45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621B1DED42
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177448; cv=fail; b=PGff8UO9NkMGiLsYQGEy6bIkmdt2iM2I9GxOVokngkmKGnU4zB8unUk9mq25x50qrGT/2FA6QFW0MFgu4tXY1RvMa5GoN/7hEimk1Z/IAh0MI97gKNdXGKh4p1rYDoCuIZzbqz6A9qieFXg9/ea85BxW7idoEI19il+xqXaylOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177448; c=relaxed/simple;
	bh=Z5mtiWkfpkA7aWpGXZXw2on78KP4nqX4rR5cWBImsho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g8ZXgu/JnlKsR9toz+seqaR8eCs+n7G2rd6pHT6fMnNZYyb2RPBseUiPUa+6mmgu05lXA2mqWvJah+6UtmCCkilRZsZ03b+HvObc2XDcvBglGt6wW7X8CYg5/uMeaJvDpniNsN/TeYp1Bg9Vj2oLF4xGFiX1Y0WvohB0lo/NFxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=f+KOoC45; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48]) by mx-outbound10-174.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 02 Dec 2024 22:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blEQDKB/9E5LPf47b3+p/vu+vPyRouusXgsyqAShUaO0DJSNz9JoJu1mWsHSiCUeMJuRjlIG+0EIeuD5JdBwVo84bTLhd95DdWuIhfhaHz8+x7UBD0lCXsDLIzayHGC/6F3drSmLLgMaDh/52s8+Xfvzs1QYC6NIp8V74NDePcfyoGT2tSjwJKhk/tF4Ma1b2oowpB9GBstvfMne/EjfzbVdbm8nFhoxmtsPYmf5HqiwFUB2DjwJKJpndge0SukZVNDefqBW74t/uSYyLUqrO9wPnOqK1VRRNohFBK6k7VH6CPgDe+BXLXzm9xY/mbG6qM8IoetcKnl11g6xnoU79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T8kZyeI/Taw4gtP43n5ZETOxMVoi0lpL2Is4PAUH9U=;
 b=c21tHInpt0F1BslqQDpRZUcV/aq4Ua3lWg2vHL1fkV25tkeej2K9pyGlSgye3tNJniTodk2EJ0bBQJlHP5FQH+eHK42hcFn52O1TTaF+pdk66flyPkFAKKv6HZBrSHa8vxlN25wH8S/aZWuiPlVaD2ubWuZXM5qohqsQrNvBMck/m4sCui1Q/3mZX4O7RiPGXbFrFZ7T4g9bu/wdQPM2FalI7vSUWYj2v4PkGq5M79X7bVSXiZi78B9OFWageXFdNRIS6vzUiAC6JcJCHci30dEzWhDfSAZQ5NQZrmkRqAQ2IoGktdTlkh1xWG09PBRAKOjxBXDU2SaJRpEb4ZIHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T8kZyeI/Taw4gtP43n5ZETOxMVoi0lpL2Is4PAUH9U=;
 b=f+KOoC45NYrHQR4oOaA+SPUezWVHETQ4NTNk+BImyD0nqMPbCw2pxRnKS3aJp7norvEdI1ddj5Liz7M81bvYwxpUg4sQZMN936WXRbbCeRdjtW2JbLAbgws1Jh4BCxGRxAXgSNT6D7oYt3SKzjS4pe7Qr6QDMUJby/V+XnbCs88=
Received: from CH0P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::24)
 by BLAPR19MB4452.namprd19.prod.outlook.com (2603:10b6:208:286::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 22:10:31 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::75) by CH0P221CA0023.outlook.office365.com
 (2603:10b6:610:11c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 22:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Mon, 2 Dec 2024 22:10:31 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 49D6E2D;
	Mon,  2 Dec 2024 22:10:30 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 02 Dec 2024 23:10:29 +0100
Subject: [PATCH] fuse: Set *nbytesp=0 in fuse_get_user_pages on allocation
 failure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fix-fuse_get_user_pages-v1-1-8b5cccaf5bbe@ddn.com>
X-B4-Tracking: v=1; b=H4sIAFQwTmcC/x2MUQqAIBBErxL7naAiUV0lQqxW2x8LtyKI7t7Sz
 wwP3swDjIWQoa8eKHgR05YFTF3BvIacUNEiDFZbZyRUpFvFk9EnPLx08XtIyKoJndXzpJ1pHch
 6Lyjq/zyM7/sB6tAjo2kAAAA=
X-Change-ID: 20241202-fix-fuse_get_user_pages-6a920cb04184
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>, 
 Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
 syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733177429; l=2285;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=Z5mtiWkfpkA7aWpGXZXw2on78KP4nqX4rR5cWBImsho=;
 b=i9CTbGsIRkS3rDnWceb0DEeu5ZzX08u+/y++LnphhOWm/HWzSYzB7LUCX0lZbQrJzuG88ZPVg
 7TCSq1/rsK3DYgrpOrMEWHNFVRI9DR0k11gxcVBuNIygy4bSJygOG37
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|BLAPR19MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: e89aa2aa-d98c-4aef-adbf-08dd131e22e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlI0bDZ4dHdIY0p0WXVVWWRmL1hrL1FkVDQ0ckJwZTJvREpUeFVkV1EwMkNw?=
 =?utf-8?B?WGFmSTJGZEp5dkZ4QkNFWHpJQTNPTlM3NDNxbDJLZUFvWVhsQ25wSXVzOGlD?=
 =?utf-8?B?MW1Fd3ZydkFSZCsvWEJhOTRrVGp0dTlvSEN2MzRHZVFMTzFERFZUZjdFRER0?=
 =?utf-8?B?K2FpeWJGUnQvbm56aTh2L3M5ZHJ0UFdHa2FaY01kVjFxVEpzRUJZODZMT1VM?=
 =?utf-8?B?VzlJOHZkYitPQmNPVElTU1JUaGtHRU00V1Q5SmMxLy9mQlE0WGl6eXZWQWRm?=
 =?utf-8?B?NjZjbGo4ZWNFb1I5UVJ6bWZSbENSZHNtK29YUzFHQ3VPbm9FNjJmaVB1TFhp?=
 =?utf-8?B?WnlkTXBmT21GbG1EUFJvSXlBNUVFcE9YTnBKaUhMbXVkNUl6OTZWUmk4WE9x?=
 =?utf-8?B?L29LZDN6YUdaaHhNbFNQbGJFdzhRbmRROHg1clExK0R1VG9hd1JQRjV2R1Ja?=
 =?utf-8?B?WHJ5N1dycThRUkpVc0FzbVVDTGxyQm40R3NFaTlHRkhBMkxaNVo4cXRIRHBk?=
 =?utf-8?B?OHJoaHdud0g1c21xbjZNajJQb2ZZcnozNE1sMXZrNk9hbS9SSWlPcUl1MXNt?=
 =?utf-8?B?RU9lYlo4NStKU25ZTU9wbmhuck5TamovZzJ5NUlRY0lDbXZZanZ4bnBid3Vr?=
 =?utf-8?B?SENaR2JSdnQ0ZzU4T1g4OVB3aDFjUnlZdXFXYitIWElvbjNWbjhqMU9hWUxz?=
 =?utf-8?B?ZEx5eGVZTE9FL0M1UmZpcGdsbUM2MkFqOXhTdlMvUlhjd2V1d2tuaGl4dkJr?=
 =?utf-8?B?Wm5GWjdHOUU1dDFkUGJMdlhxTWl2RDAzL3BZejZQajRzUWw4NW1JZk5vdWVo?=
 =?utf-8?B?Q1dTckFLeEJQUm51RXhvK1lOelI3bGRhS3NOT2tqZnBjRk1UQW4rcFBkMWdz?=
 =?utf-8?B?dURsa2tQNElmaS96VXVtcFdEbUtZMktDclJEWklzOUNOYXpLNm5BRzlYUndv?=
 =?utf-8?B?dTZjcnVBZzVKZnl6ckh5bW5aRzUwQ2p1Wm91WEM5ZnpaVGhTMDRWZjZTeGQw?=
 =?utf-8?B?YWNGbUgwYTB3WVRtQUtab0srK0xZVFFacHBRL3RsZU11SmEwUVdDOWtDTGd2?=
 =?utf-8?B?Z3VWZnlUbGcrT09oRDF1MzJsNkc4Y1M3bGVNWFdDVTdxd09uVVU4aUhOWS9o?=
 =?utf-8?B?bXc3SXIycnZGcVA1bEpEakxGWklKdTg3N2hzWjJ3ckNJQUdhdFhRRTBWaHVP?=
 =?utf-8?B?OHRvRDdDR2tvQXpZQ0N1OG9Xc09LR2p3bHY4a044N0g0WWpOV1Bya0ZvZFJJ?=
 =?utf-8?B?VXRPekIxVkJUTWJDaTdTbVRFaWc0dEpWTDl3bEthTHlYMURmQTY4QnFRcEVq?=
 =?utf-8?B?RlVWVHhJNUNUVlZURzQvTEZaaUpCdkI3QVB0RlRySCsrN0hwTFFQSUV6cXEv?=
 =?utf-8?B?OEVNOWhTU1cwb2htcjN2TVRjMlFPdTlXRkYrSUhZWFdYT2Jya2htTmQ2VTlV?=
 =?utf-8?B?S2lZSHMyZURydjF3ZHRIZ3FaYXZBVEl6TGlCNTRObnArL2ZKSHlwTFpPYW0r?=
 =?utf-8?B?aExjRjQvU1llMkUvdEQ2MlpOa2JpR25ISWZkWlFUaGt1cU55clR1WVlZVldZ?=
 =?utf-8?B?S096UlR1Z3EvTWIxeHBielZ2VEpucnIxYlBVN2pjV1kzSkJTODhrYXJZQWFS?=
 =?utf-8?B?UXRQaW9XMkwyZTFXTExiaUppSnBiMm9FKzN3Wmt2aW1zVXFjZ1J5Nkw3NW1T?=
 =?utf-8?B?K2RiaWxXRlNsS0xnYU14bHV3YkJNVXdWQk0vVzFkZ3hxWWV5KzNiTCsxUG5M?=
 =?utf-8?B?RUdZVlJaVmVrODFVSmd6dFRYZWVCV3ByVXBZR09GeWYxQ2VPNDFmejdLOXZC?=
 =?utf-8?B?MDh0SmNqWTdXb1gvSUpVaFcycTJyNTk5U01NQzMyTDFSQWhXSXU2bDNRUmRB?=
 =?utf-8?B?RTZsSGRMUUpjMmpGYmpsVDEvU0pBU3hTb2tlNU9jTFFjZmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ls7BCzPSDSoNcweZxXDQhn9s9p6MLECKvkOALNNKVr9r7L2EYl3LbJeNG0Jezin3TCes1pYZegMs0PNS8/6U6WDjnByvhyzdOff0E5weWGNOhsVxlqIf2JAGK8Vu9rkU9J6B5/3gvLDf/uDbsc+0V996ix66DXvQSD13NxvfXWHns4zyg3ftkyIiYv6vPtbpedAAEzCJCodckgpXPlqLVOttqt+2psgwzwVURXEsHIF59isaSVcbMjXT3ms27cuzj7PDTnP7I3giWfivSkTv1Qs2MVEj3aqJENtq+6mPSAzmNv1yGQtjzdljcxX/8HguoLmeIbiJrDA9C5m+ZDvkcDHRn6EIc1HctBmYa0EltLcdc3COAWgeW1yF13nnH2tpJBMkFRD4o9nShjsqO7nayGaBz7bYHqMYb5Izq1JUmXDIi+4JHEeC10IWecz/8oso68wenK4BUfGlKMaHiPkxGb7gPXY+y/N1wNkbrNc1Pi/PgUyA8Iz8z+9gevjq90MYGf75ffeF1P8zm0O8iVaxgasXCT8hAMFsCXV2bSjrRpWO2810QYO8aMNNDGmxZ18CN6P2wVJk1D1HQGn/PTp+TO2c+drPb6enJp7eS8VUvS0rYuxeytZmwqVb9LsYOsY5/3yHMLcG+pIcbYVdyxn6zw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 22:10:31.0677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89aa2aa-d98c-4aef-adbf-08dd131e22e3
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4452
X-BESS-ID: 1733177433-102734-13463-29013-1
X-BESS-VER: 2019.1_20241126.2220
X-BESS-Apparent-Source-IP: 104.47.58.48
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZGRoZAVgZQ0DLJzNTMJDkxNT
	k1zdgs2Twp1cDYyNwkOc3YxDjZyNhAqTYWAJXPbbNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.260845 [from 
	cloudscan13-66.us-east-2a.ess.aws.cudaops.com]
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
---
 fs/fuse/dev.c  | 3 +++
 fs/fuse/file.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d14ea339aa6c8da63d0ac44fc8885..2b506493d235e171336f737ba7a380fe16c9f825 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -803,6 +803,9 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 		void *pgaddr = kmap_local_page(cs->pg);
 		void *buf = pgaddr + cs->offset;
 
+		if (WARN_ON_ONCE(!*val))
+			return -EIO;
+
 		if (cs->write)
 			memcpy(buf, *val, ncpy);
 		else
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 88d0946b5bc98705e0d895bc798aa4d9df080c3c..a8960a2908014250a81e1651d8a611b6936848e2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1539,10 +1539,11 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	 * manually extract pages using iov_iter_extract_pages() and then
 	 * copy that to a folios array.
 	 */
+	ret = -ENOMEM;
 	struct page **pages = kzalloc(max_pages * sizeof(struct page *),
 				      GFP_KERNEL);
 	if (!pages)
-		return -ENOMEM;
+		goto out;
 
 	while (nbytes < *nbytesp && nr_pages < max_pages) {
 		unsigned nfolios, i;
@@ -1584,6 +1585,7 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
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


