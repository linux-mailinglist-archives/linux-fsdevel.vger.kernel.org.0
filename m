Return-Path: <linux-fsdevel+bounces-20482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A890A8D3EF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBCC1C20DCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 19:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7E317B404;
	Wed, 29 May 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="JzS+eElv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B542045
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011372; cv=fail; b=em6bJh08+jx9AHHt1fbMBVx1xUEs7bC+5z1fzmtwj2pDZS3L0mGc2p0CMiRHT6ZwNgU6yyeFmLuebK27zsB/P/Mjfg4ppwLMgK6sjKs1c3ETt037T+miWet5n6XorJjhkGDMIxfbZWSHVUMT7BWMmRDoOjbqBUZbYi0pvfmOLPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011372; c=relaxed/simple;
	bh=JBYJJyOhONGEWcMQZtn6PSf+1+tV6dhuuXcUy7sQHqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=fFNiQbTchW+7r5BrdnDo2QFcuB3efrQ+OcKeLHv4U3VIq6qt+gEGfz8XVcI6IkKNLNMwQPRKxjUi9SkP5QFjKCJxP0r0oX5s7ryyDpR9IBozlpeiiwYxIm543S4qClcrObgwnNQLqS5XFRRsaSQVfU7nvt37paBjBAlPpHg6QEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=JzS+eElv; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40]) by mx-outbound47-163.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 19:36:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ0r4VFn3IjiFLm/qXdSHbvEWOa2Un4rYczajourxFv+2GZGWKP1LviDLW1BM0XPJzLNrKNrrHTUfFbt9+fgpfHJiJ4qHba8WdmGNXpw+zaleKMBNlUq4lUxt6a9D36RW7tho1JmYDmQG1rPVszyhSykOk8NwYvVOOmijp3m2NXW/htXKFPSA/v2AfGbnKR0fLv7V7bUQ3VL30V5dpgCIADZh66I0FAKIOIpPzUqtANCwbysO99Yjnuv1m+p70UEbBqyU7yFpj4XlKETk1297bgc7F4y3EmiwH6fsLlm8IYzIR5/3jRXiH/rI/P0Vwy6cXL81YjEv/52lBW0owRYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tusvV1Y5IqVEMp+mGAs5Gmb2Tg/Ka4zR4RuLpMxZp8s=;
 b=Cu9u5Tklr1ZJi7B7tixa8RxvbL0PLo+28ZmYYIZCLCUTyJSpgiWHkpN2ojBXw5yV/mNYRRZNIl/jAmXydboMJAjy0WODqTScoTmomE3TzULm0fpwaHFlTCVTudLrxfXoetvj5u7xwaNVHsPSWfq/O8ilQf/RoXbctf5RmAGjfE89ww3zM/I/LQbVWiXWHH7Zob2lnfgTjxo//AyLRtyAACaszrEaaoBlYKPYrlIEcv4VT/X2QBsnxzF87Kmwu2y12jpZNzgMsXwa4ETBy2S+Tqu/6cL/pd/CdAldnPvzEaLms8zduFpJaLtdI94ZW6np+CDjbSETw7YIt0LVRq5fOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tusvV1Y5IqVEMp+mGAs5Gmb2Tg/Ka4zR4RuLpMxZp8s=;
 b=JzS+eElvca5bczK7r9zXJwvwf8uq+8sNJUdTxn6kd2LLgkAMzklK8mVXGbjWUSOrb3eqrx7RVW6UsbGi4CvkGWavskzadYmmlNbSxSwvIvG5hjcN4RKaGl2NbXrhByFBISbumlzPJ205GzsquATkBf/fYe4r+/ZQWpSUJiYc92k=
Received: from BYAPR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:e0::15)
 by IA1PR19MB6227.namprd19.prod.outlook.com (2603:10b6:208:3e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 18:00:52 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::58) by BYAPR05CA0074.outlook.office365.com
 (2603:10b6:a03:e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 18:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:00:51 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 3E06227;
	Wed, 29 May 2024 18:00:50 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:36 +0200
Subject: [PATCH RFC v2 01/19] fuse: rename to fuse_dev_end_requests and
 make non-static
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-1-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=2022;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=JBYJJyOhONGEWcMQZtn6PSf+1+tV6dhuuXcUy7sQHqY=;
 b=fSlOgI41ITeTFunOzCo//OkrW2CIJwi/+wTiJv2VlzItPpZZ1zeMhbPaWm5YCQn5o1Bee34xR
 zhh7SAtdd75ChnKSNY7WCWU9gc6KPSZNuac5oakhzu24HYB21rR4db3
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|IA1PR19MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfd8dce-055d-48f6-dc3e-08dc800946ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTUwMURabkl2cDF1RzRwTDJQN0ZVMkI2d24xOWdJV05ZOGEyQWx4UXBIUkVw?=
 =?utf-8?B?bkNlaWhWeExoV0k4TFRxWDdGdUNCZ29YczhqdjBweGtFVFlIMHhtaWlJREo0?=
 =?utf-8?B?WGpFczhmU252RU9POGtLa2E3ZWg4ZFRQOHcxdTZqK1YvWmpSY091TkVia1Fm?=
 =?utf-8?B?K2dQak1yRWFYeWNSSXlYU3ZYbWtMRUgyeVlvZU93bWEwSUR0TURZdmlMM3RI?=
 =?utf-8?B?OVNaUlBlTmI1TnNMd2JqT0ZjVk1xUkFBcGlBSWhwbmlicGk5V1pNcDB1Mjk0?=
 =?utf-8?B?eGo3NUFkbzJpUnJDU3QvN2VQZ1pxajVXQ2g0VDFYNHNQL01JZm1uMXJzV3c4?=
 =?utf-8?B?WlZSNjd3YVc0eDR2Z01uZXAwaXhZZjBqWUd2RmNGbVdPRnVFdnNSUXBqMHhG?=
 =?utf-8?B?OWc2Wm5NMUN0cm9lOE1HWi9YdDhDMzA4bEtneEYrMWF4S0ZmMzcrV3FPeUt1?=
 =?utf-8?B?OWt5WG1neVNVQ29yTGo0UDNlVUl6MnN3QzJHTnVWVFRrV3BCYVNWNk51eWhk?=
 =?utf-8?B?KzZvV2NhRXVMOUNRUWMySE1jUVphR3NSeHUzZzIxd1hxVU83NkxpOUpWU1FK?=
 =?utf-8?B?REZFY3hXZU1KclhVQ3dNemZPcWpPYnZUcWxRM3F2YldQRlExYm44dU9ySklV?=
 =?utf-8?B?bm11N0VoQ0VZLzBCMUJQeTZQWXFRMUpEeXpITUU1eE1sNXI2Yk9aTHlOY29o?=
 =?utf-8?B?bWZpc2xiOG4vNDNibDViSC8zTmt0YUlMdTFOdWczZlFGcnR5TzVBcUkrLzRV?=
 =?utf-8?B?YTNzMmNvMXcweEYxWExqa2UyQ0NvVm03NW1ad05lbWg2Q3JUS214TEM1S2V4?=
 =?utf-8?B?dUt1WWE2S1dmVk9FdjBPSkNhUUppd0RTY0dpblRPY0tzNEYxSHh0Tmc4bXU3?=
 =?utf-8?B?bkprVnd5bUJwVXFuMnJQUzMwbXdSaDVpZDhpaUJRQnFGdWE0TW9VcDNrdDZ3?=
 =?utf-8?B?bTUyampiMFIzTS80VldzdkI1QWxnQVN1ME5ZemlBV0lvMXlWZDBKSkpYNWtC?=
 =?utf-8?B?NlpRVzdWRHY3QmlvTjlSR1N1TkdkMThYTkVCOVoyb2VpKzBJcjNqSlZFeERP?=
 =?utf-8?B?L0ZaaTBFMXRsSCtYSkFEY1dtYUk1bkI1bVZaMlhNLzRxanZab29oQXJTR1ZT?=
 =?utf-8?B?UGlkbnZoK2dtb2tKUVhmTzZ6RWs0dXhRQ3k3cSs4SEppaklTMTlZdVJiV2R1?=
 =?utf-8?B?ODc5S0xDdGM4alJ6ZXcvMmR0bEROdjlyc2ZLMG5lT3BzUFpxMWJQVzNVdGhK?=
 =?utf-8?B?RXhocmx1RlNjNERXdGQrSXZaTyt3UDZwSjRMMEpEWXNNay9ucjc1b002b2c4?=
 =?utf-8?B?blZSTzVTNmpCVW55SVpsT2RLNzAyOXlESUVNcnFOUFIzMlM2OFN1dnhFQ0Rw?=
 =?utf-8?B?d2hmS3NkZnlZeTBNby8veTd5MVRQUldLT2Zjc1pFOU5JbVJTb3VTeG5lQlV3?=
 =?utf-8?B?N3lXTEFrNzB4Yk0vbkozUDdqdVNzVWVRT1NvL3E4MXJhVXM4R1FMSlA2NkxU?=
 =?utf-8?B?TTNrWDdLVzRKYUkrUUIzdFdPMnVWMFE3Rzh4dEZ6UjBDUjF0L0t1Q2IvNmpl?=
 =?utf-8?B?RDdoU2RhSm9lRTRqVjdmNE9JbjIrSFlGc2Y3anNFN1RUWWpodHJMWERhL28v?=
 =?utf-8?B?aXlVZWZHdUc5bW5WZVkybFJ2NTRDeUtEQnloNGZhb2VyV1F0WHNhbGZ3UWE3?=
 =?utf-8?B?QVp6aEV2VEgwdjY1a3IzWEtTdkh6WXJHRzBRVit2amtGVUhlRWxQMnBUQm9Y?=
 =?utf-8?B?Qm0vUXZobzFqNGlIRER3Z2N4THR4NmZhU05WRy90Ynh5NDRzeVovY0RPeHhQ?=
 =?utf-8?Q?L8QOtZDgB6Wc310RZtBuADWhmrlexs7A3U1oo=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YvBmqkwT88fCeJ7ukNjhCjxnKyArCTchq9qhRggaCxtSKATKWeBIWBEy56Q4Md38WnyMsX9sQssYSFoHDdXeDeMtgiWYmjy64r0TvM6OcubdbxSxdw/Nbt+5UE0/vnpTo9zVShoSnoHeTIxv0t448md46QOtu/95OuEFYoLIvJiEyBuTb7f7WJ31hr62NLc3spf7/bAX4juIw3huc1mQoHkRY2PH7OPJH9liM26vD046DlruYuoDcRBlwQ5twQShKcW4AhjdDMoVIZtw+hAzjhDrBFIzc6ZGD2xf3AHHkN+3cVh/bMhPSb9cXHjZYXtoGhwz6D09tOawuKIL3G+/FNfymUVEtyb6BT0icTPyIAdLSbtT/HP3jQFxpF19n+MyJ+KI9CUmIxKu1DvdnxlINR5d0MwAH60pVT6RcjetGscuKTet+rRQoQ/iaT7bo++CioiuoqiQlYlrqcZKqay03P3y3+91966QZEcDAAzJZh4SkwMFgDmit3jrrqmfQA5FO7ET6lYeEW6ivbe0YRbyADHrkbCZRtyFHTI1v7Jd68EJE+mTo8oK5zVhCCvJzf/X9t/Yuat+rhXM8ZH0hPmvyP0eFXtvnGp/UPHjZBcMmcHlHOeyTGwBpnR4ggRAWz1zpiyVBYlMURoAqyBm4VpUfQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:51.1728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfd8dce-055d-48f6-dc3e-08dc800946ed
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6227
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717011368-112195-23577-6509-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.57.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWpgZAVgZQ0DzFwtTIxNTQMs
	nCzDg52dwyySjFODUtOTnRLNkoNc1UqTYWAIaVj/RBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256586 [from 
	cloudscan13-33.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

This function is needed by fuse_uring.c to clean ring queues,
so make it non static. Especially in non-static mode the function
name 'end_requests' should be prefixed with fuse_

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        |  7 ++++---
 fs/fuse/fuse_dev_i.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3ec8bb5e68ff..5cd456e55d80 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -2135,7 +2136,7 @@ static __poll_t fuse_dev_poll(struct file *file, poll_table *wait)
 }
 
 /* Abort all requests on the given list (pending or processing) */
-static void end_requests(struct list_head *head)
+void fuse_dev_end_requests(struct list_head *head)
 {
 	while (!list_empty(head)) {
 		struct fuse_req *req;
@@ -2238,7 +2239,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		wake_up_all(&fc->blocked_waitq);
 		spin_unlock(&fc->lock);
 
-		end_requests(&to_end);
+		fuse_dev_end_requests(&to_end);
 	} else {
 		spin_unlock(&fc->lock);
 	}
@@ -2268,7 +2269,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 			list_splice_init(&fpq->processing[i], &to_end);
 		spin_unlock(&fpq->lock);
 
-		end_requests(&to_end);
+		fuse_dev_end_requests(&to_end);
 
 		/* Are we the last open device? */
 		if (atomic_dec_and_test(&fc->dev_count)) {
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
new file mode 100644
index 000000000000..5a1b8a2775d8
--- /dev/null
+++ b/fs/fuse/fuse_dev_i.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
+ */
+#ifndef _FS_FUSE_DEV_I_H
+#define _FS_FUSE_DEV_I_H
+
+#include <linux/types.h>
+
+void fuse_dev_end_requests(struct list_head *head);
+
+#endif
+
+

-- 
2.40.1


