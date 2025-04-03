Return-Path: <linux-fsdevel+bounces-45641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E9A7A352
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550B41896092
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD15C24E4AF;
	Thu,  3 Apr 2025 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="GpwqCVsY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91670242905
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685529; cv=fail; b=ik6MuAvnDMsxuEAznl+jwIUp7YLOBIhxj1dX3wl3VYzrSMNIVMAhbP3oMj5lGBbol1Rb3oEvEwt9GoxbFhHo6ZpmRXkatycEbMc2z2E82My2EYTTeSToLMxPUJJMSXi6cchKgxSJnC532lMw/wplRTAd9LIRIdE6dE4sDklVPIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685529; c=relaxed/simple;
	bh=t/qWU7S8DFwFw1ltRPZymLwhxW9CiMD3+kpjL0lZZRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cyEJYwn0DouzkgqyCZ3hBlw2emdRyCW3KLj4LEXIOQ9pYHQLSMT+IjQizpQvCvwfodlwm/0XP+bFd47i8+ZuMm8ERrbTR9bIK2mrnDxrsyHPq7awnT4cyldwIO3GAzvqzdXj0GLq/2ohHrkiHHWSm6wWyVh/o4hFgW42QiMuxXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=GpwqCVsY; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174]) by mx-outbound23-127.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 13:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH8UeHh/ORUE8g4taYEHYF8p4XEU+tfp9TvuwSP/WytN8DB32nfXnuT1ocKD/m1stNVjpdDIPomcF7WRE2IFu81XV2EDPbGyG7rBrNvVoOiCPruN3jibfBgmjvlCYn73960nVr2DUzoi6qduMamT0zj4IObag5ErcCmgj8iRnke371JpQ9kvxZZi7LCagNKwD+rUvoO3WgXpq7FIubWPIMZXnNer7kisy3W7m5itwTd1lR3gDT+858Z6b0jFf86QP6WCL3QShM2LcdRlfRc8DMQrJgCRF5s4jn+CybOAIqr+s3BIrvraGxxFDfBOYyhQFGn43slc1UJRnnUbjjJBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9c4thro/65LNTQvw9TViG04eyuC/g4rHehyEfqiU64=;
 b=o7aZ0PEuuVUC1Z5b6HV1ebeDrYueZ70J5u7wTpdcCTj2RGZ6a/IcTuQSpawzrKiWabfP9fFmcnm3X8lGxvzEvj7XyLpjMpLzNim2+SNiV+yMQW+BWt+C8m5gIUBorWKo/egYZ1SRmnWTWwGhoKjrD0KkeD1InxoRPdvqGPG2J05SgvsxyszJrAfdhZfz3teS8jqS/BL0a1YjajTTbxQu0H4lkztk/uKmWIosbHK3AmzvwmhOTYNzYBXVZr2ajKLO61Mr+16i/u7ntWr1VBSs4ZgGjlnw/N+OTzAzZic4KRaFcH4A1pH6ibPiZo8VID1W/40/eObiqesmZNDZSNeuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9c4thro/65LNTQvw9TViG04eyuC/g4rHehyEfqiU64=;
 b=GpwqCVsYEAn8gTu4p1BubQ9Vu9YDThZiFbSYFu7X/VVKP077fhj0qxDECBGqmMDts/2rqqxcWO7lTVNEfYPzwCyCrKcebcxILFV5gpy/gjWggEzD4pm6KhTNN4s1eNBoKBNd500KFyZFk17pjrpHMfPVjA7DjPPbXeb/9F3GUWM=
Received: from BN0PR04CA0125.namprd04.prod.outlook.com (2603:10b6:408:ed::10)
 by CH2PR19MB3910.namprd19.prod.outlook.com (2603:10b6:610:a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Thu, 3 Apr
 2025 13:05:15 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::2e) by BN0PR04CA0125.outlook.office365.com
 (2603:10b6:408:ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Thu,
 3 Apr 2025 13:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 13:05:14 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 43BDC4E;
	Thu,  3 Apr 2025 13:05:13 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 03 Apr 2025 15:05:08 +0200
Subject: [PATCH v2 3/4] fuse: {io-uring} Avoid _send code dup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-fuse-io-uring-trace-points-v2-3-bd04f2b22f91@ddn.com>
References: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743685510; l=2416;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=t/qWU7S8DFwFw1ltRPZymLwhxW9CiMD3+kpjL0lZZRE=;
 b=ailbvq51Lp7tHCWNh0RC8aMEuGn7BIl51m/hFL0lhiFZ9U192YbDh7VzH7KIg6HL1qDPoCDn2
 TgHek6ghkH6BoPhbvQwCMSN8rwangBwxw/PRKJ2xa9qHlFJ57+bHoa6
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CH2PR19MB3910:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1abd76-f032-4611-b519-08dd72b02cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXVsYlVVYTR4czdWTDRnbVdqcWhua010dlJCZEsxSUg3Sm02SnNXQ2xQVUJs?=
 =?utf-8?B?dFd5LzBCUitoTjJJQVY2eXpSeUlCb2NWSnByRWViNCtNc3l3dHhPQlVXUm1a?=
 =?utf-8?B?aTBUSDJibjhFVkZJVjRRcVFlUGdaR1YvZ25hUWkxczlmNWZEOUMvN2QreGFM?=
 =?utf-8?B?WEoya2JxTytZemhYWUZONGZhMHZneEIwY0pYVElXRW1EQlVCTVJlMVFuNHhI?=
 =?utf-8?B?Qk1ORlVWaXJkazR5SERVRXIxWXViemJIdW1JR3NRWnJsVUlYbCtLQjVhYUZS?=
 =?utf-8?B?SWFYNUpzY0F4ZXRrRyt4UytsNVg1M3kyNnMxUkJib2l0ODZUZkpDbjBsY2xY?=
 =?utf-8?B?b2gyV1YrM3JrYmVnS1hXeVlrcUw3Sko2SVhoTVk3WkZrRlZuWGs1am11Qzlt?=
 =?utf-8?B?U3FhZGRXYW5xN0JoTkdPdjdDVisrSmMrN2tRbGQzWnVFVm9MN0tRYXE0d3JO?=
 =?utf-8?B?V0pOcjd1b2FPYmRPbVIxeUFoRDM4bjlvdjJtNFR2T3VjTUtmYzJsOXdMSlpP?=
 =?utf-8?B?ZzRrTVhHK2ZTOGtNMXQ3eUVibmMzekpPT0dqbC9pZGJVS3lBWXVMNzJjUVJp?=
 =?utf-8?B?d1ZXL21lVFVoWHRRcTI4V2lpbkkydXM2S21oMTJtOE9vNFROcXRNREM0aEFk?=
 =?utf-8?B?b29tSVNFaHRYZWkxMjZrSC96cGIzQXRwNE1kaG53NEVYRExOQWJsSEV5VElI?=
 =?utf-8?B?ZWs3NTJsRE5BbnhnWUozWVlIQUtCMkE0ZGRYK0tRYnJHUXR2bUJTMk5zMWJS?=
 =?utf-8?B?T29LeFVMbmNOZHlxSnpOMUxnU05XRStwbWdER0hqbXdvS0c5TVlUbVdqd1dY?=
 =?utf-8?B?aEhMVnZtb1U2Ky9wN0Y0bHViYklab2VhT2ZNVkkwVFh1K0FyYnFwemQwRmFq?=
 =?utf-8?B?M2R4Q3R4V2FmQXE5ZlgybXdHNFJSLzUxYmN4ekErSWVxbHdKQnNKN3FFVUFl?=
 =?utf-8?B?VVVGU0xLYjdselhjSnR1MHBRMWdrY3NSNlMvdEdMaC9IbnBpUkwrcWc3bkpu?=
 =?utf-8?B?Zmx3RVhjT3BlSW9SUTYxL29UVFdTUnA5U3dGUGFmdy91WlBPQVlyeko1TEgz?=
 =?utf-8?B?ZHlyWnlZaTZSSk8vVHY2Zm83Q1g3V0t5TFI4aExTcEM4NVJXMkp5bU1jSlY5?=
 =?utf-8?B?VlAwc2RtOWpIQlhpL0xrQUJFUHpWZlNIR1gya0RYcTlXWS9ocm1WdElldXkz?=
 =?utf-8?B?TW53d1Fpb2tMcmQvYldGVGwvdTk4aVFIY2hGc1hBeFB6WWJGMk5rRzBncXRN?=
 =?utf-8?B?bTIyTEdENmszbmF2NDhqbzE5WHhDeU5xNEdnZWNmcVY4a2txMkgzdVFKTGo2?=
 =?utf-8?B?YnZrZXg0MmcvSUMrUXV2R2ZhblVGWWZtUmtqM0pDenRJUWVpMUZadjh4K3hw?=
 =?utf-8?B?NHpJcFhjL1BKTFYvZUJVNTRkUlExUXNWQWZWcUh4TlMydURocEdYazgzRzVU?=
 =?utf-8?B?VVdIS1dlSExJSGNPUTI3QUV1bHZDVWV2TENPZ3JJTjEvVUx6akVKOHVBTjk0?=
 =?utf-8?B?S29xV2g0aDJ6VEtIektwS3FRMmt2SEEyUU5PTUo1cjUzS0Z6bG9UMnViSFJw?=
 =?utf-8?B?TWM4ZzNtTU5sUXNxUG1CYUoxallvanhmN1F6Mk5lOTJtZU9XczNEK0dLVFNE?=
 =?utf-8?B?b2lpZVFBSGQrQU5BbUdBRlJSRXVISmpGWEl3TlN6eFpObWFYNU90V3RDQ1gr?=
 =?utf-8?B?UDVvY2pZQi8yd20wV2NmcDlmb0Q1Tmh6dUpHMmVJNWRPQkg2VEh1RndzTnJu?=
 =?utf-8?B?MVpTSGJaNHhkWEl5eXJIK2hXRnVEMGFGOXlZOVpCRmVRd2Y2REtaSWJiRmND?=
 =?utf-8?B?RkVKTExCQ1F5cU9zTDVHVnoyODl2M0IybFZWYmZKZ3BZZDdKNjdkT0pnb2pV?=
 =?utf-8?B?dUNLN3ZpeWRyVHF6MjVYVE5Rc0FjVHE0anhOcXdOTWVmdXBlbUNLcmh6NjQ4?=
 =?utf-8?B?YlVrN1NNeC9KRGFuQkh4MW1NdXF0cmtxWEdhZjc5RjJIbjJwbGxYSXQ4UkZY?=
 =?utf-8?B?YVY4YUcrakJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QfL/EjRKuEGLuFD7aQT8My8MQXvEX7ogOTWmgvFr5tWESBQGAHRqsOjJst1sqwWA9ppjCrGlig/BRsus5aN//UeYbu+TvVQu4uD0o3rEC6Jj+Xlzqt+Q3NKqIXV8K2I3pLY5+ewOZbQfZAOe/dOf1OKPOtyB9UckREqfxX6pG72lJ1kSua/TQUsyN+TOJFvG8aoy60RWL+XiZAXySkBgmnP0aghoV4r1/d/bDugnwxv/d3YU9B/FzOuT+F6BoRuCpWEk81842hxizaUjx2hzy6llNw4QA6+wWEKV4Rk7gfIqVP/I0+0z3v0te9mFdE3BX/aCbrP/5uCjvXW9OxPCZbpnt6zh5JyygurMBsX4dYhz3hM7U0SqN1vRur/k76YxQVlwHIyfqhV541Ki+uvUn5p3NFak49mOXU/3DA+sutPK94sZXfzSR367pz/q/zKkY+GWsXKc/HI4TxyerjZboiMR9wnvBXOBA6W4RVuzETLUE7Lu4fkKN4Mb87yT2HgXninuC1g3jk1ELG2bnmQh5nxmbsv82RcisgVa3Ed+Exn0EDkkiTaTC9URoqoOw5uZSnXtMjnCN0UG1v5RlnDNok7ud40K4sMQ8RWnpLn0Z30XgYzX8/gsSEgonIfH1WHWVYEdDq+y8cWa1J3/xv1IvA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 13:05:14.5049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1abd76-f032-4611-b519-08dd72b02cc9
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3910
X-BESS-ID: 1743685520-106015-7818-637-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.55.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGxmZAVgZQ0CDZyMLE2MDUwC
	TR1DIxNc0gLTHVJNkyzcQ8ydQiycxSqTYWAKVqchFBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263622 [from 
	cloudscan21-94.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

fuse_uring_send_next_to_ring() can just call into fuse_uring_send
and avoid code dup.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5a05b76249d6fe6214e948955f23eed1e40bb751..c5cb2aea75af523e22f539c8e18cfd0d6e771ffc 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -667,6 +667,20 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
 	return err;
 }
 
+static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
+			    ssize_t ret, unsigned int issue_flags)
+{
+	struct fuse_ring_queue *queue = ent->queue;
+
+	spin_lock(&queue->lock);
+	ent->state = FRRS_USERSPACE;
+	list_move(&ent->list, &queue->ent_in_userspace);
+	ent->cmd = NULL;
+	spin_unlock(&queue->lock);
+
+	io_uring_cmd_done(cmd, ret, 0, issue_flags);
+}
+
 /*
  * Write data to the ring buffer and send the request to userspace,
  * userspace will read it
@@ -676,22 +690,13 @@ static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
 					struct fuse_req *req,
 					unsigned int issue_flags)
 {
-	struct fuse_ring_queue *queue = ent->queue;
 	int err;
-	struct io_uring_cmd *cmd;
 
 	err = fuse_uring_prepare_send(ent, req);
 	if (err)
 		return err;
 
-	spin_lock(&queue->lock);
-	cmd = ent->cmd;
-	ent->cmd = NULL;
-	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, 0, 0, issue_flags);
+	fuse_uring_send(ent, ent->cmd, 0, issue_flags);
 	return 0;
 }
 
@@ -1151,20 +1156,6 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return -EIOCBQUEUED;
 }
 
-static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
-			    ssize_t ret, unsigned int issue_flags)
-{
-	struct fuse_ring_queue *queue = ent->queue;
-
-	spin_lock(&queue->lock);
-	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
-	ent->cmd = NULL;
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
-}
-
 /*
  * This prepares and sends the ring request in fuse-uring task context.
  * User buffers are not mapped yet - the application does not have permission

-- 
2.43.0


