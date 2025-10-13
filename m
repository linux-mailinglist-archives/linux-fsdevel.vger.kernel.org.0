Return-Path: <linux-fsdevel+bounces-64010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA9CBD5C38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36AD24E3009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2762D6E75;
	Mon, 13 Oct 2025 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="QcWbEuMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7E4C81
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381098; cv=fail; b=VNBfvmUmNSxEaWQ7TxgriEpqDazPtd7/ETJVslylDFmbDqiVFvwIPlvMJPeJg+eJ6wbjYfKwXnGFijcYpIYofDknbiaLsAsJiBEqQTHs0jgtepBSsgxvHAAbIBNEHcOLBTMgrWf9ZnB8/BFSTWJxUZBNYzAGiwP6WjonEAh4nfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381098; c=relaxed/simple;
	bh=jQQpGzIV8aEZI02IYO0FkNsOwDqFVD7GqEO273xdXxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nG0dXtQef1+0lB/uAdTiIajRQpUlPhnedkTl9srZSzc/m7l/v9DY9dOVOH4MNtIsQ1oSkFYuXlxeCtc5wamqpZS5wG3rKFXjDJz5SRPDGZs4L6Z6/sSH6fZPM6U5A+FkRxyFGa3P2gmaYqWthHoo2swXcKY1W/UtpGrU8wOvSmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=QcWbEuMI; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021075.outbound.protection.outlook.com [52.101.52.75]) by mx-outbound47-89.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Oct 2025 18:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMCCzJYln4so3LU/slA+Qbtrm/0g2mnbCmKtqf+MzRPUkmuLeIjrLViXSXa9M1jwsjibq25RptAsknenojFY4INoPlj3UdKPnKPvGSLD0OMKzecnnrl2hcbCN3UuWWJJfvgxQb7oQoUCI4nxgvCZj500g8LFuq7HWVVcY/QSi4lCUziGIfL0m9+PBjhPL9IkHRM38X9Feggdv9RFV283ceelYGJes3wCr5PJ46rVm0L5Z86WTMq3NujxqBSu7AWiy2qjQVjQ+bcsli3nBdkTpE1QcusevY5O9L8DJ8nsAL+C/SDgFoCoVyIeqMHZ0guaPIuwtRFxCVWZmF2rSIA5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooaRY4AQfOEraTRcelzc5S37adgwpy4MrmwOGyKXOJA=;
 b=dMvoV66oNYmQ77nOVv9/2+6HbsfcmP+iXRERLhbwBm0h7DXNWTXx+cxFi63oYTdFfV3fAhYNCSId+4Im0ZYH04Kt6kSeQVZeWQzOmsII6UrmcfIBDels/M0Ptvyh5fQlRFkHhYv9bx3ZRjFCsCJeEynadiSBGkTpMCQuo23wgp55H48M7UENoiW7N9hXMCwH/efRLpiKqHOlRwcYEsgBwKapS0jPuNFBPSdtnOxvZXBxb71scfrBTzwPWFvuVieIdRosU0N/4mqyAuU1/EVkblzMyVs22dLmmfVL3uZX4MprpEJuV4sGNZft19eTBoW2CBgGbBo0yGAYrh4MKOLvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooaRY4AQfOEraTRcelzc5S37adgwpy4MrmwOGyKXOJA=;
 b=QcWbEuMIrON3z2Y4fJCU6Rdt7Jy/vBTFHRUGuELr/6HuNuxq/1v4ZiJAhJZnpwse+si4vb423a+Mb2MzxD8wkVacf85BkEgAR+ZCAVJt/o04dqaW6jkukMCj1PpKTXnlbQU3iqGzOpCjPatrWZvom6eYHyOHxBZZTQLU0Ua5FvM=
Received: from BN9PR03CA0452.namprd03.prod.outlook.com (2603:10b6:408:139::7)
 by CO1PR19MB4984.namprd19.prod.outlook.com (2603:10b6:303:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 17:10:07 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::5d) by BN9PR03CA0452.outlook.office365.com
 (2603:10b6:408:139::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 17:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:10:06 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id EF5AB63;
	Mon, 13 Oct 2025 17:10:05 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 13 Oct 2025 19:10:00 +0200
Subject: [PATCH v3 4/6] fuse: {io-uring} Distribute load among queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-reduced-nr-ring-queues_3-v3-4-6d87c8aa31ae@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760375401; l=5079;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=jQQpGzIV8aEZI02IYO0FkNsOwDqFVD7GqEO273xdXxE=;
 b=Wue7E/EOfSjCIiWCA3PFCm++xRoC+kaEntW54UUYkYJocrFqoLm/J2Hjft2v83lMuAfLIk1Ia
 tbeVNT32fYoA2i2rTN65aqOMOhzh7GSY5gDMuiSTsWhMzYAjk8WknXK
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CO1PR19MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 206e31b8-f4fa-461a-ca65-08de0a7b5bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YVJYSVR4UXZHSnhiMWNsRVNpMEVMRDFqWEpVcjc5dllYZjUxRkh2Z2VETmgr?=
 =?utf-8?B?TE5tcHNXc05BYnMrQ0R6cW9DcXdYYkJnajFTejFYZXRMdXNtMjBJNlgzNXlo?=
 =?utf-8?B?VEV0Vm0yWjgvNHpSR1N0dThtQ1JpNUhwZXc4OWZ5b3E0QkxuNHJMNnFlYU9X?=
 =?utf-8?B?ZFpZa3R6K2dMdE4wbis1cjNWeFNYWXFwTGtuSHFONTlNN2tnRjgzYlI3T0d6?=
 =?utf-8?B?alZkdTlTOHlSazBrQmlvZk5vY2JVazZ1ZitkSGVtQURFR1JsT3lYRW45M2pF?=
 =?utf-8?B?a3RoV1U1ZUlFaW1xemdlOWk3K0VnQWlOZGJyRkptQnNLWEIrOW56UzFjZzhT?=
 =?utf-8?B?NjNzbUlpSkpvT2tyaXpJQzhrcXRmYUl0enlDejJRYmN2RnQ3L0tpdE1wQmdB?=
 =?utf-8?B?S1dBMzlncFNIK0ZCSUtyTkdWN0VRckJ3bS9jNEJyYzQ1S0xpVEtrQUpYQndH?=
 =?utf-8?B?OEZnZzlCd2p6ZGlqNXUzY1NUT3VIUnE4b09ReE5wRWNvNmdYcFdzWVc4ZGJs?=
 =?utf-8?B?SCt4eGNkcGpXWURYajlpank3ckd1WVNPOHMrUno0a1JuZlF5di9xZ2czaWlP?=
 =?utf-8?B?b2drY29TeUlKOTgycDFkazIrVmxjYU1kN2I2TmpWNi9kYW1QMnBwc3UwWFpY?=
 =?utf-8?B?RTVaNnhiWEdFWkVOTHBmWmQ0eHZRVTVGZFBoa2YvbjJrT0ZXRnNXYkY1ZU95?=
 =?utf-8?B?S0tXQi9PNVhvNXJjWElIN1VCWkJsMFJyVEsvaGJJbWYwT2pFamo5WHVKRzZu?=
 =?utf-8?B?TnJPblR5NHliMGdMTUY3QmJad2s5Z2JBZ05DZnlhRktSdkFHWWgzdHJ6aUo0?=
 =?utf-8?B?MjJyM3VaOTlDUGZYNW9Ja0FWREN2aGtOZWhKeFZISmthVGI5V3gxSTZHUmlB?=
 =?utf-8?B?UmgwK1NMNThWMDloaXl3SENUeC9oQ2V1Wm1zdWp1empVdnhrQWdqZnRBemZN?=
 =?utf-8?B?NDZ2SFRoZmFBQ0VobGsyZlJMUTZMTHE3aFZVdUZFVGFXazlRT0xxWEJ6akts?=
 =?utf-8?B?RlZyVU5JckNnTC9LRExtVmNhUkwwR3ZGZDdXMi9lV0htYUduc3NTUUtDVkpC?=
 =?utf-8?B?SC9XcTBIbVJaekx4NUJIMVhXWlB5SW80ZkZadVlBQ29mbjcyUTJ2ck9PUjcx?=
 =?utf-8?B?WENFWjR0emU1R0J4Vk1GR1RMbndwM3J2RVlQbzFOS1RwdFBxc0svZnhjakdU?=
 =?utf-8?B?cmc0Y1hGVXFGOHZEV0VZaVN5RlBmUWhqTkdRSEZLWUtEZkN1NVhubUt3RWxr?=
 =?utf-8?B?Qks3a1NrNENHNlorTDV2TEg4S3hrbFFwcVl3WUtTdld4aW4xcHZIbjFkM3dq?=
 =?utf-8?B?NnFEeG40bUQrTlRmejEyMmxRN2puT2pmWjI2OXhHcC93UGhuMDAybTdiaXRB?=
 =?utf-8?B?bER3T0daaTZhMFRxS3NieUs4dkNaTW9pWGord1I1eUdhZEI1NkFUSWpvRzJY?=
 =?utf-8?B?OFZmZU5VeFIvTkdHYUoyOXJRNm5RRjAzcjB2dVFVSkxCUmFucXN3NVhGTkV5?=
 =?utf-8?B?R1FWa0tqdGYrZUdjZEticjBiQndVa0Rqc3hXZnlEWCs4U05sZjZ5TTF2OHZB?=
 =?utf-8?B?Qm5hZTZDcG11WnJLMzc2bHgvUTdqVklZTmUxTjJjOWdUcXNEV3FhTURpVEhD?=
 =?utf-8?B?MVFaNkhxMDFZM0N5YnJLWkZpQUNrV0dHaVk0cEY5MTJYQUNLVlRKcWd1d0t3?=
 =?utf-8?B?elNzS2FPOUNTcGMzRmhMek9yTEZyZjZlNVdrcGVJdnZYNkkwSldML09LeVkr?=
 =?utf-8?B?TVlGUWxpL3lqMjV2Z0o5eTU0aW9QYVpQUjhLMm9Wd3h3MXcrcTl1aVVDeWMy?=
 =?utf-8?B?WjcvNE1JaEhQQngwa2VKS1dSMGVYeW9EU2ZEK1pHcWRCTTkvTFdvbEpISG0z?=
 =?utf-8?B?TERHbnhpVzJSNmJGSFQ1Uit2cFlEYzJlQ0hXWDRXMTFzaU05WjFDWElqaStn?=
 =?utf-8?B?UkEzM2lhT2lERXBLRzI5Y2k0MVRYbnVkRlVFQWFTVE5IYksvZ3liQSt1c1M3?=
 =?utf-8?B?SjRnSUlVYWJ1VWxDaVRKZ1d4Y2t1cGJxbmY3K1JzTElKNmlyMGNQUmc5K2Y2?=
 =?utf-8?B?ZG1KK2dLUldYRWtKSytEMHlzUW55WVlQdzNJMmt2U2FqeEVmcU5vNGo3UGxy?=
 =?utf-8?Q?g0kI=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 sDOkXNi8/LT59p0G6J1s+AW6P84/sQD2p/RFah9mU/06BL3zjE2XIl0D+rveh0xwDNqhqRJT2IG21elU/tNnUqa7DWLphPzLKBiTwJtA+G5yqE3fGR0GaW3ts/Jo2b06B2+2mmE1nu4FTmx12FRr1EwO/lG6XHorjvcSr8jE50n12/QEnxk4Tk8/c0sQII6tXbXY2GkIZPwjgPaVSRAsplfaQeVbQF240/VvavUjk15bRVxi9YFuX8Pd+1a/xxeQC7pl54g/Ns5iITBEzbR3L5SkplQ+rJaVR5dtXGzIXSXh72iLSuPIOS1vyXx43ApRu2WZXMrcJWU+5zJyIS87D2HJBf3LMSkUCxd9UGCAvOEAzFQAKGkfSqcU0W0/QzOgxcf8AQ7YXFgIFUpJf74Ap50HacWIe4peFyyFACIzI3X/vGWCzPbejc5PAYMqf9B73W976Q9XJU6i5MrhtYX2WtFRAjTbZ6GQbjBPm2EOXQzKICdqyvJ4cNYD7m/1iaX/nEFklV37uUzf7ucZWkL1igqiyPzKpE9wBGFHZe2o8I3bHB41AO4prGXd8+AkjEy7LEAov4U7djtaQAgVkp8tbdrouLtOOIinKI2R9wAJbCSLoLlu4IWKNmDNGLhsUtAXOAEveu5EqAZXuddyA03oRw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:10:06.9003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206e31b8-f4fa-461a-ca65-08de0a7b5bc9
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4984
X-OriginatorOrg: ddn.com
X-BESS-ID: 1760381094-112121-7662-12117-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.52.75
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaWRmZAVgZQ0MLY3CDZwCDFzN
	I4xcwwydjcwjLRJNHE1NDMJCXF0NBQqTYWADbgHK1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268183 [from 
	cloudscan14-96.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

So far queue selection was only for the queue corresponding
to the current core.
With bitmaps about registered queues and counting of queued
requests per queue, distributing the load is possible now.

This is on purpose lockless and accurate, under the assumption that a lock
between queues might become the limiting factor. Approximate selection
based on queue->nr_reqs should be good enough. If queues get slightly
more requests than given by that counter it should not be too bad,
as number of kernel/userspace transitions gets reduced with higher
queue sizes.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 02c4b40e739c7aa43dc1c581d4ff1f721617cc79..92401adecf813b1c4570d925718be772c8f02975 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -19,6 +19,10 @@ MODULE_PARM_DESC(enable_uring,
 
 #define FUSE_URING_IOV_SEGS 2 /* header and payload */
 
+/* Number of queued fuse requests until a queue is considered full */
+#define FURING_Q_LOCAL_THRESHOLD 2
+#define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
+#define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
 
 bool fuse_uring_enabled(void)
 {
@@ -1285,22 +1289,94 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 	fuse_uring_send(ent, cmd, err, issue_flags);
 }
 
-static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
+/*
+ * Pick best queue from mask. Follows the algorithm described in
+ * "The Power of Two Choices in Randomized Load Balancing"
+ *  (Michael David Mitzenmacher, 1991)
+ */
+static struct fuse_ring_queue *fuse_uring_best_queue(const struct cpumask *mask,
+						     struct fuse_ring *ring)
+{
+	unsigned int qid1, qid2;
+	struct fuse_ring_queue *queue1, *queue2;
+	int weight = cpumask_weight(mask);
+
+	if (weight == 0)
+		return NULL;
+
+	if (weight == 1) {
+		qid1 = cpumask_first(mask);
+		return READ_ONCE(ring->queues[qid1]);
+	}
+
+	/* Get two different queues using optimized bounded random */
+	qid1 = cpumask_nth(get_random_u32_below(weight), mask);
+	queue1 = READ_ONCE(ring->queues[qid1]);
+
+	qid2 = cpumask_nth(get_random_u32_below(weight), mask);
+
+	/* Avoid retries and take this queue for code simplicity */
+	if (qid1 == qid2)
+		return queue1;
+
+	queue2 = READ_ONCE(ring->queues[qid2]);
+
+	if (WARN_ON_ONCE(!queue1 || !queue2))
+		return NULL;
+
+	return (READ_ONCE(queue1->nr_reqs) < READ_ONCE(queue2->nr_reqs)) ?
+		queue1 : queue2;
+}
+
+/*
+ * Get the best queue for the current CPU
+ */
+static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 {
 	unsigned int qid;
-	struct fuse_ring_queue *queue;
+	struct fuse_ring_queue *local_queue, *best_numa, *best_global;
+	int local_node;
+	const struct cpumask *numa_mask, *global_mask;
 
 	qid = task_cpu(current);
-
 	if (WARN_ONCE(qid >= ring->max_nr_queues,
 		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
 		      ring->max_nr_queues))
 		qid = 0;
 
-	queue = ring->queues[qid];
-	WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
+	local_queue = READ_ONCE(ring->queues[qid]);
+	local_node = cpu_to_node(qid);
+	if (WARN_ON_ONCE(local_node > ring->nr_numa_nodes))
+		local_node = 0;
 
-	return queue;
+	/* Fast path: if local queue exists and is not overloaded, use it */
+	if (local_queue &&
+	    READ_ONCE(local_queue->nr_reqs) <= FURING_Q_LOCAL_THRESHOLD)
+		return local_queue;
+
+	/* Find best NUMA-local queue */
+	numa_mask = ring->numa_registered_q_mask[local_node];
+	best_numa = fuse_uring_best_queue(numa_mask, ring);
+
+	/* If NUMA queue is under threshold, use it */
+	if (best_numa &&
+	    READ_ONCE(best_numa->nr_reqs) <= FURING_Q_NUMA_THRESHOLD)
+		return best_numa;
+
+	/* NUMA queues above threshold, try global queues */
+	global_mask = ring->registered_q_mask;
+	best_global = fuse_uring_best_queue(global_mask, ring);
+
+	/* Might happen during tear down */
+	if (!best_global)
+		return NULL;
+
+	/* If global queue is under double threshold, use it */
+	if (READ_ONCE(best_global->nr_reqs) <= FURING_Q_GLOBAL_THRESHOLD)
+		return best_global;
+
+	/* There is no ideal queue, stay numa_local if possible */
+	return best_numa ? best_numa : best_global;
 }
 
 static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
@@ -1321,7 +1397,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	int err;
 
 	err = -EINVAL;
-	queue = fuse_uring_task_to_queue(ring);
+	queue = fuse_uring_get_queue(ring);
 	if (!queue)
 		goto err;
 
@@ -1365,7 +1441,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 
-	queue = fuse_uring_task_to_queue(ring);
+	queue = fuse_uring_get_queue(ring);
 	if (!queue)
 		return false;
 

-- 
2.43.0


