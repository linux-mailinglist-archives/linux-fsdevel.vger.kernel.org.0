Return-Path: <linux-fsdevel+bounces-64997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F015BF8C36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 22:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9069F4E692D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F6284671;
	Tue, 21 Oct 2025 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="oYgzWfDB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBCF26B942;
	Tue, 21 Oct 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079617; cv=fail; b=EWDNZXNlqqWjG8SXdoaYhdws7UotxuR0kOjsuMzl1j9yTDMPRt9SzJJoRISVpKWqUNgefQIu8z2Wxu0BF2gGQ9PnjH43hRRdDdOv8lhwOv1hOL7uYrMWYY79f4cwGOFl98VXR+RNxyFXdGtkreVYYIeLY/plppkNKW53me32tbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079617; c=relaxed/simple;
	bh=ungSF9HkwDWzpX9OC6tE2YiDvNWNc3JKQpx1Ruf7buE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgCTUTnGh0ncdgqSjpWcOkzH0VRruTFV5842eJd0XzTzJS17mEyQZTguXEA9g2pFKX82jHole9x74pGI8bSlJOeRJI1T5RbzgpS0TZfyhC4lSINaUiB6coeXAP23t3WPzLRJ9a4q8dGdVLV1cU4vT1mPNpaWRgOHkWplf/lriCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=oYgzWfDB; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023117.outbound.protection.outlook.com [40.93.196.117]) by mx-outbound16-144.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 21 Oct 2025 20:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co/0H417XEWrR2IgaNLn3W3SVZMU4mfuCE1j9JOutRZIGkhQaji0ZR33kq8w2WjwoYf/hpehqXAAZehShb6t5YBTQPUbGSy0Yah103bbnAtzscho9wbm7YUOPZLdshZ/qMlzO+K4jxdb7lJuxTVSjaMvEPJiqJzRv6r2swGRcpVKbTpjtSRo98xWEOHmeb8mJrygVNJqad91RBfPt0Zt/uwKHKi/0tL/f83V7/xkQ/1rCKlA7fCSsSuLnRYSA3Y2G+t/6PIW7CLfnwB2uZDY/mNtSlqMWykTI7zwqLJl4CSMkk8Y4jqgWEO007fjWIGMsCvHcs8QZXLGziv2Xg+rPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv0NltcpDda69QLQz6d/+ESiG9gZV73tKyZ4bs1HCjc=;
 b=WORsdtCbGofq6r+LnVwbtofuMe8o3OT6ftSeaLxukZhLdW7URJ26B4wmrHp2rDX4Q5Otew1nyASx47uNU3aEDo60b5esyH0UDUwovDHHmDBDitBuuBoJHBys53zX0bp5eswRXIRCQBbavSvEVga9PaYqQbeiAnvq7bBDR/fWi2FxNanTay/LLaZ9flYf/wJo4cfCe38OUXC6X421KKI8m5fRTJrfDa/NGHpGLa835XkSbycmDJs+bNh20/3mEEEebi8pjKNNU6ERVjk7F09Vd+ez9JNayL5QY5Q0vfC+WmL+2qj3r47SigJFhPV+KiFbajgazxqIAOUN4E6Wjeif8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv0NltcpDda69QLQz6d/+ESiG9gZV73tKyZ4bs1HCjc=;
 b=oYgzWfDB9dC+HVNcbVThwP1Lotm+vn3AFggDngQy88oe+rSW10X+Qfv2DnNgvKa+/U9rKO/yxOuSSb6H6euRGtqttCM618LeHw8QGhJ+Fi4/N3BtRlb3powbT79KrgsYqs8tlW1BWwVn1Z6RXYzpWRM5zHZ68tZ0wJfdYIEQNRI=
Received: from SJ0PR13CA0209.namprd13.prod.outlook.com (2603:10b6:a03:2c3::34)
 by SJ0PR19MB8158.namprd19.prod.outlook.com (2603:10b6:a03:47f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 20:46:48 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::f9) by SJ0PR13CA0209.outlook.office365.com
 (2603:10b6:a03:2c3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.11 via Frontend Transport; Tue,
 21 Oct 2025 20:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 20:46:48 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 5096363;
	Tue, 21 Oct 2025 20:46:47 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 21 Oct 2025 22:46:42 +0200
Subject: [PATCH 1/2] fuse: missing copy_finish in fuse-over-io-uring
 argument copies
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-io-uring-fixes-copy-finish-v1-1-913ecf8aa945@ddn.com>
References: <20251021-io-uring-fixes-copy-finish-v1-0-913ecf8aa945@ddn.com>
In-Reply-To: <20251021-io-uring-fixes-copy-finish-v1-0-913ecf8aa945@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>, Cheng Ding <cding@ddn.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761079605; l=2666;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=qJlqEj7A76C5ViDJzbQ2ruvZDqSkUmHuISley/z23HM=;
 b=YdoyuaWT+KmvC8mYYl0PsKyTcS6oIamqAKvXzGxVNGd+g396bMQA8kwVXL8u4Ku2fVoe9ztjf
 a7iVDu9XZu3CY9dEiv6xJP9hLXWBtr1caT2oc4lWMXHUPcwMnyyLLck
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SJ0PR19MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c48bf57-0f13-4db5-1d68-08de10e2f454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk03Ym4wS2lTcGJSQUNuWFRCSzhSZ0tYUEpFUlEzWjJFdXhsMC94SWsxbDRy?=
 =?utf-8?B?L0JrL3hXZXN2N1Z0UUswT3o4Z2lETjVieDNBNXIrMy92K2NYT3B4ZFhoOHlj?=
 =?utf-8?B?ejJJR2RkS3ZLYnljemk0UmJOdStLVTd6UzVtKzhtNlNzeDdQME1Tbkl2US9k?=
 =?utf-8?B?S2Yva3c2WSt5MTZjNjd3c1FXMDN0ZlBJcEU2U0g4MTFQNklyR2hlYnFQeEdM?=
 =?utf-8?B?alZSVzBKK1RJckJ6Rm1NRWdYVnlaczRkc0U1UWNQWWhWWi85MHN3VHFMc2JT?=
 =?utf-8?B?VHdKZnd3Q0xkdXkvQUw4eTk0RW9ZbTNJNVZydVFSOUZTRFV6WnZUcTl0L0R3?=
 =?utf-8?B?QWRiVE1yVFZ1cHB2MVJQT25jbzN1L1owMkQwM21VTFpva0hrenJaUkI4bmNQ?=
 =?utf-8?B?TUxXOC8xTEYvTG1rR3VTa3ZZYVNaR05jb1NIZzNUb3F6UW8xZ2s4QzdCZVRo?=
 =?utf-8?B?Z2cwVFlHUkRnaDVFUWlyUUFFRldBZytIa1B4bG5aOVR5LzAydnd6N2MvaC96?=
 =?utf-8?B?ZmE0R2xSM3V4WWprQngrU0Fybm5IUHAxWUZmZW0zb2sxUHZmK282TlhyS3pr?=
 =?utf-8?B?dGlCWjFKL1VhbGJmaWR5Ky9zS0t5MGhuUW51LzdOUTcwZzVET3NWb1JRYUYz?=
 =?utf-8?B?KzJFalYzTkt3NnNOdjI3WVRFblFYWEdtamN6dklSelFaZjUra0RhZGRVWHVD?=
 =?utf-8?B?WXlvekxBd1h6NWtET3ZzajhEcEF6SXB0R01LUkZvWEtwemVSbkxONVNmQ3FP?=
 =?utf-8?B?c2VCRFh1MDZLSTNHZi9SM2QxSFI1L3ZnUDBCSm94eTgzbUJlYTlaTk5qRHRm?=
 =?utf-8?B?MXNvUkZLcnJTcEptMXRyRG5FQzU4QXNQSC92eEpNY3N0RFl5MWZzYlpzK0Uw?=
 =?utf-8?B?SThydy94ditVWS9ueEt0TFFDQTBkT1Y2WDNLMFdQYmFlUkJOMEZQOTF3OFVm?=
 =?utf-8?B?d0Y0MHhNbGJKZXhxVzZvRWhCUkxOSUF6ZUluQlIxU0JlTUErQlQveUpsS3JM?=
 =?utf-8?B?aXRycjM3RElUQUZ1bjFsTXhpVTVBZUsvUVZiQW8vSXNUUHZNSS9jaUtYNmVX?=
 =?utf-8?B?eG5NR2h0QTluNFdmNjZLdmNMcFBGL2hrc0ZhQjg1Rmg5NUtCUW95M1IvSGpE?=
 =?utf-8?B?RkVkNkFkdzNXWU5NU3V2ZllXQStpeURNSm9PQ1k5VHB2VEhxbDYyclh3OXdS?=
 =?utf-8?B?aUJvTnpWaXFPcm1KcTFrNVk0SUxVeE03aWUxd001dklBSkl4a1NaTmI5TnRh?=
 =?utf-8?B?bERUNU9MSGx3aytrZXVhWmNzYm9GMDFUN282N3E2TzhFK2FZaVBlVjZoUDlO?=
 =?utf-8?B?dWtTcS9ZTzFMSGFuZVFVT0dwYUVLQStxemZhRU5PdkdXV2YxQTJHM2NueG5M?=
 =?utf-8?B?YUxYWnlMTHhRZGVYaFFmcEtJSDJ6Y25kWlZkMitwSi9lUkU5TWNIUnptQmxW?=
 =?utf-8?B?UUQ4RTdSelB1RVRhNktUeGFkYVd3alF5K3dJanZRaENSbmZYbUxZR3o5Uk1j?=
 =?utf-8?B?MTdUaTRZRkhYYVJIWk1yczA1TjAvR1hIZmtiRE5vTmRiMXlpbythMWk4V21G?=
 =?utf-8?B?MWpWQ2FCZzJiL1ZnZmR0elZKOXJsVU9qRXBQSjJYQkNzaTZmRzNtcHRGN2Vr?=
 =?utf-8?B?ajkwV1QwekxYVE1SVDczUGk5MEZOY1NDWldUR0JVRWVDTnBtUWhOZVBMK1BK?=
 =?utf-8?B?LzhHS3B4SGZ3blliSkxZS3c4bkdNR0NCQ0R2RmdTTVB0UGcxcXA0aEVsUzRu?=
 =?utf-8?B?dkVTOVlOc0tLcUR4NVhhSEphUXNTMS82TktzRm03b0V2Q0tycDlLK2N4cUU2?=
 =?utf-8?B?cTBZeWhtcm41bmdOdDYvNW1zUmdTbU9IUml4UlVoSmo0eEVxN2piOXNWcmM2?=
 =?utf-8?B?aU1mQWdYb1YyYlZPU2hubm9YZWp1KzNHWWg4WXZPUTlNellLS0lNOEVGalRY?=
 =?utf-8?B?TzV6NGh6Tk9pS1ZpSFVoUzNMV1JFcWdUV3RSV0ZqYkdHNEh2eWFWVWx0NHVt?=
 =?utf-8?B?SmhZdW9JNzVHK29VdHU5dkEwTGszekk4bVBOREJvbWk5Q09EdVpZcHM4N1Rr?=
 =?utf-8?B?R3ZTNVhvT3c1RzJGVlZvRDRqUFYzZ2pncFZQTGRlRlNNZ2N3OUJLL0Nocnhi?=
 =?utf-8?Q?Cfh8=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ovyjdg/PrZe9V3C5lnRg2M/tQGVI5+XlpnP4uQViZc3fX/Pb5FQp/aFCDGIslEkLmzJtZYBnGuyItV9HoryqyIpWb5oVtZvpHQOENx0Cfnniwj65TYtkABSN9Xz19b49FK5cAmegGqZdseC912jeDPG8mOFhtJRvrXEkOBLb7LsQ4KriH/AfD1DdPCV0GXDfEhN+bKKzOr5WmTx/82KuZdUStrb2osvgoxeV6OlQA9ueGspJijh2bJZV3Gk8VFzdtEIq8HUE+Ta1k8F2x2Tfzg1DDIXtNOyAxyssZNEJd93ob50yIQiOteDFwPaLprzwLmTwDcE1cYUBmSjTzB596RlDlAmQ83+WRb4jZc0JlYTMjOMuSbQX4MqM/OflSv5R0FpNOSabzZhnHwOOkv19uSuUAZ2C9q2rfFO/DiuQIQ+hD2wOEdZuMWLr2oD3BejPezj7HaKgf4mbtE2Lh7dypGTn807QCRcXf0dVScFCLpIWZFFU+rvjPbfBT93S88KpydEydNOx6gUUt2YkFQfavwFctvZzFZ0hBezAdCapZygI0PxCCZ1TJ/zQdlecTsG6AIwQ+HGmXcqnPO7DKO6SGJVrXLrV2nuwEJQylQSZrr+1vLqo5803pZlmVvBtzEPcK1Vxn+56mbO57mqys79VNA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:46:48.0071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c48bf57-0f13-4db5-1d68-08de10e2f454
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB8158
X-BESS-ID: 1761079610-104240-7618-12956-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.93.196.117
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZmRqZAVgZQ0MLUONEwNS0l0d
	DS1DA5JSXFxMLIwjI1OTnFzMjcPNlUqTYWAHhQ4cBBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268376 [from 
	cloudscan14-152.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

From: Cheng Ding <cding@ddn.com>

Fix a possible reference count leak of payload pages during
fuse argument copies.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: <stable@vger.kernel.org> # v6.14
Signed-off-by: Cheng Ding <cding@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        |  2 +-
 fs/fuse/dev_uring.c  | 12 +++++++++---
 fs/fuse/fuse_dev_i.h |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 132f38619d70720ce74eedc002a7b8f31e760a61..49b18d7accb39927e49bc3814ad2c3e51db84bb4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -846,7 +846,7 @@ void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 }
 
 /* Unmap and put previous page of userspace buffer */
-static void fuse_copy_finish(struct fuse_copy_state *cs)
+void fuse_copy_finish(struct fuse_copy_state *cs)
 {
 	if (cs->currbuf) {
 		struct pipe_buffer *buf = cs->currbuf;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bbe7d255980593b75b5fb5af9c669e..3721c2d91627f5438b6997df3de63734704e56ff 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -598,7 +598,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	cs.is_uring = true;
 	cs.req = req;
 
-	return fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
+	err = fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
+	fuse_copy_finish(&cs);
+	return err;
 }
 
  /*
@@ -651,13 +653,17 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 			     (struct fuse_arg *)in_args, 0);
 	if (err) {
 		pr_info_ratelimited("%s fuse_copy_args failed\n", __func__);
-		return err;
+		goto copy_finish;
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
 	err = copy_to_user(&ent->headers->ring_ent_in_out, &ent_in_out,
 			   sizeof(ent_in_out));
-	return err ? -EFAULT : 0;
+	if (err)
+		err = -EFAULT;
+copy_finish:
+	fuse_copy_finish(&cs);
+	return err;
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 6e8373f970409e83efdc5d5cfc3d943a8948d3a7..134bf44aff0d39ae8d5d47cf1518efcf2f1cfc23 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -62,6 +62,7 @@ void fuse_dev_end_requests(struct list_head *head);
 
 void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 			   struct iov_iter *iter);
+void fuse_copy_finish(struct fuse_copy_state *cs);
 int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
 		   unsigned int argpages, struct fuse_arg *args,
 		   int zeroing);

-- 
2.43.0


