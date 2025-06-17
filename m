Return-Path: <linux-fsdevel+bounces-51829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F83ADBF12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 04:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84D4188C654
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 02:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C882116F6;
	Tue, 17 Jun 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e6taY005"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021120.outbound.protection.outlook.com [52.101.57.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EC2BF013;
	Tue, 17 Jun 2025 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126779; cv=fail; b=IrzMePbJkwEvvdv3WMr+VLFhUAvBkn+/ezv+t8GhS6w9R/Z1qNKdUORKlcE6n17PwmWyMqwYbUFxoi/lKBKZ1Ozm/oAVYWyCtvgXmlfXP9Wpq6Hbu2gT1OsQfA6+PrF8KRjVxNGoUTzphMSMrHU2hMqD5sBNr4iIWT71+vqximo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126779; c=relaxed/simple;
	bh=TvlOcND9ZWj5zAZzHC7qhooo4ZkYTfClJEN1ZJCKKRs=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=WN42kdq7kZrIWpkefLgsNytmvJgAze6MAhLo771RFoazhZt0Go2lVyAZG2tD4fbielQP1vo/qRKuuI5ONvLVlVp/Of4/q6UyQ7A66bxe4c6tnU9TEMbjBlVypkufyeBelpY2aQeoCyc16KUyCWkEOronnwdKx6FnYZpD0psi2P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=e6taY005; arc=fail smtp.client-ip=52.101.57.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGde22mniBWau24LJa+y6JUlVibIhlSHVWlGwrjbir4LEjC1yrtrTldIfERZOj3IKsFSa8vypSLZ0k8tmqmF7bbWhjfiVuVp9MF+DVeq0s7lDhtZpnHegwNBN/VKNlQdKwF1rnQsviqfaDduXAYr993+jPA1snjXNBmmeHXAKAzWYYUHxlEoObdOjSsocw3dpq35dunRTgNkbQl3TWsUtn/Qf5eySdjO/S1EVQflw8Y1bBwrUrwkP0LaZXzVaJ4fD9WHx+djJFnI+pOoUNZQBwI91IdG2LavT9z8yfQjUr6ubvG3oUBht9BYM8z3bQdQPccJQFbZEBXu9RCY3v0rdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvlOcND9ZWj5zAZzHC7qhooo4ZkYTfClJEN1ZJCKKRs=;
 b=Wf4gOwGruM/SAKZzJ36n+IYLEsC9XjQ3OW2bAiKy0zYvz8hKK0YI2FUGKbGemDK6WGYCkl7N0N9ZZwADAkhmoHy7C/r8/UT2v58f1wdH5UvCl674L3dxHSlfgcCpT0r6YlYhA99Mo0AU5tviEETkD904uh9WkXEXbznt1XvEuSB7QexssRZwp73S/CwrFKambs/yVBl5iCAy0oVHoBDwBI2mHdt/IFUskUFi0++afAFDWvBg8Ge6+uwdXHgPpZ/HjJoxUnFtIOQekBg0xfPqqEl9wPENDO8Awd5QLXd4dv693PYebXJXCGIv2McwkqN61JnAZ+0wZ3aDVQvZ+h3vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvlOcND9ZWj5zAZzHC7qhooo4ZkYTfClJEN1ZJCKKRs=;
 b=e6taY005cQWCqkzFNYuq3U39RXnCLV9+WU+6ZiH7R9jWgI4O0CaClC/Wq5eeTid1iVWrJ/LdlhIk4vRYMlA8Bw+0FtjDkSyDLJ3514IopPZjdmaJ3M9vUrU8Fhf71CUJO/197pGto3kNC9BNoutvL93m5cLiGPoyT/5E8Vae6v0=
Received: from substrate-int.office.com (2603:10b6:a03:5b9::9) by
 BY1PR21MB4513.namprd21.prod.outlook.com with HTTP via
 BN9PR03CA0225.NAMPRD03.PROD.OUTLOOK.COM; Tue, 17 Jun 2025 02:19:34 +0000
From: Jason Rahman <jasonrahman@microsoft.com>
Date: Tue, 17 Jun 2025 02:19:34 +0000
Subject: Recall: md raid0 Direct IO DMA alignment
Message-Id: <3I7SSGMZFQU4.BD7AJXNGPXWT@bl6pepf0002e785>
To: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: adamprout@microsoft.com, james.bottomley@microsoft.com,
 girishmv@microsoft.com, kbusch@meta.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-MS-PublicTrafficType: Email
client-request-id: e8dfe048-034b-784c-2d73-03c4dfd3a061
request-id: e8dfe048-034b-784c-2d73-03c4dfd3a061
X-MS-TrafficTypeDiagnostic: BY1PR21MB4513:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-MS-Exchange-RecallReportCfmGenerated: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHVqQm9mM1pZektoeDVURTFKSHVtR0RWOTlaVkpBMzFKKzdxTkJmVmc0R2pC?=
 =?utf-8?B?aUF5dHp3Y3VoUXdJSkUzcWlkWm4zcGY1YVJqWFNkZXBvL2lDOUdrZXRWYjdB?=
 =?utf-8?B?aEtCYm02bVlCemNjNnlCQ2VkSmtSaU1qNUR6M3lLK2F0TlFUUTNpQ0ZXcWh0?=
 =?utf-8?B?aVVxM1pEaDBHNzFDVkIvRTd0T2Uvamw1QVNTUzE4RFRXcFZRb1hyZzMrUnBt?=
 =?utf-8?B?dmVUeDBiUHYzNlh5Nk95MGRNem5XKzRhL200ZllMNStKY2pxNjAvY2xyYXJ4?=
 =?utf-8?B?VzRGTTVvL083ZHdOdHg5QnBFdlB1RXppeWpwTFk4Rkh0RzdRckdQdUlHM1A5?=
 =?utf-8?B?eDI3djI5REpDYXFsNXY5VjdDV1BtTlVKNTc4cFFacG53QnlNbmxUR0IxaHFi?=
 =?utf-8?B?K3JhVVp3NXhKcUQ1NkYxd2REMFJHWjd5Nng5ZFRnbFJkMmlTY2RRY1oyazN1?=
 =?utf-8?B?QlhtbjFzWG1DSlBHdXYvOUJ4WUQvT2p1K1pybDZ1Y2syTkM2RHlHQ1UweXIx?=
 =?utf-8?B?d0pzRXUvSXA1NHRkYXlQelJZWEZSRy9QSm1XWnM5MlRPWGNrcGplckYyOGpE?=
 =?utf-8?B?R216a0grZWFvdVpRUkd3cHNXWmo5bkNZenFRcFluR04ySTAyalN1dWhpMFdw?=
 =?utf-8?B?cXhuT2ZBU2dTc1k1OVFwVUtVcENzenZQZ285elZHcFVWUmZqSUdGeUE1aDdl?=
 =?utf-8?B?YWtlMnpScTZtYWlRbE5KUmE4UzJ0VWRkamg2SmFySkE5Qjl2eGQyVVNFaGhp?=
 =?utf-8?B?TERxdHEzUmQvM3VlaXBuM2t1TWtwbTVna0h2d1Z5VGM2RkVFQTRrU1loWlZU?=
 =?utf-8?B?Wmw1cnFNdnY5eGJ1cjZxRERoY0NNa01sY1ZudGFNSUZlNTM4RUd2M2J2Wndo?=
 =?utf-8?B?cGFZR0t6TWgwc0c3bWtXV3BkWUtRbjR3UHdTM3FFOVpuZlNUaEYzQmxzWWVQ?=
 =?utf-8?B?N0lZckpzRmpzdkdSVS9FYkxJdUo2RGpTQmxBSHFmQWJzZHRWOEs1Tko4VFRB?=
 =?utf-8?B?OEFkM0hDWTV2dlJsWXM0SDRkNXA2N3lqSldSSEo0NytoVm1pNlFPUEpTdVph?=
 =?utf-8?B?NHMwVys3UmFHc2NBaVFtTWNhR0xHOVIvbThtd2x5MGsySjNhQVBMWHVsajNr?=
 =?utf-8?B?YzR6ZC90aWZKRjVCY0wzYUtiNlZwL1dRUnJRWmxNbWtXRWtpRnNvU2lzVjFt?=
 =?utf-8?B?UlY2WUNaVEtNRTdkUCt3QVpQRlpRRTNQTkh0dnZjai9DaDFqOWVJdUNObWoz?=
 =?utf-8?B?ZVhWSENlM3lvWkpkZ0xESjd5UjRLeEFEWUJ1QjNPNExKc3ZGOUlRMm90RGdG?=
 =?utf-8?B?VVNOclRxbUx4elc5U1ZYbm5uUFBFaVI1KzJaMm1XZC9PaFpoS3A4elIzS1p4?=
 =?utf-8?B?elVjMEhvN01UVTQ4RnB4QXZMUDV5cHJ2UFQrLzhtUzBlUzJUV1VyajZPWEFk?=
 =?utf-8?B?TG9wMGZkQksyb3M2LzQ4MjMycXVSdEpPR0Y3dmw0aG04TG9VUDk0UnpIcWJn?=
 =?utf-8?B?TkdTcTJ1enAyMnZvc3BFVGRVQkp4WitFQWtMVVZlR00vSXR0NG5MVDJ4SE5m?=
 =?utf-8?B?SGpoNnIrQnlTS3RKczlRclZJNmJhSEJrdHBQeFVrdkgrODI1UG9aSE5JamVK?=
 =?utf-8?B?YTdQaWd0VDRPZlpFblVpM1A3ZFBaUUZCSFZYMDVRZm5WblgvVGRaQVZodHE3?=
 =?utf-8?B?b2lLcGdGbjQvcU1acWJiYUZGSmk4T3A2MGVSaHJxU2ZtTUN0eEEzOGFpT0U5?=
 =?utf-8?B?RlFUdXVEcGlXNC9sVUpiQmdLY3lkR2srTkFHMVRpMVdteFE1ZThaMUhMN1RM?=
 =?utf-8?B?UUdyUGxGWlJJUW9kZzBZUldKMjRZYkZIVnJVSGtkVU1iQ2NMNll0SU5rT0xB?=
 =?utf-8?B?eXNJQUJXd1pVNWg2UTFtWm8rc0IrWTQwOElnNkp3YVg1MHB5RklTTGpTS241?=
 =?utf-8?Q?R2Kx9cI7XeA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zEk9VhYRc0uGRcjMCkViy8tBvvRo6zZuzH3b7wAaU6VrlhRilg8w1/skep1VOu+K3agChkTh0pOfc9luMzuyUJbeVb6IhV9FAJ0ti6ou/9uo08EkZR8wpZFb5/ZqSQD+0S+I3yaAVJZ8KUETWf9errxrLFKXz6tjIKBr4LJInudU5DosWufgPPnKWauMYRViRTzfn/GnFPpREUmjXiJVmXFy0CGIk3FhVqKXhbeiA87bhsgZnKQTDEoPlwRx9SB7EsV+8tL9UvXJPJ6g4MhkDcKE/NSVTNcrWaqyy2h3RllT8e2LDNHM3tgxJTU4TZJ5sI8BMjZIoFPMiGX0hZpk/xADw1Odim/L2tCvAigGkjQUVNivCPOCaYFb4XavqgXZqJC9qdgt2zwwsmuXE8UQYYfhrIyEwX16lNdKsCa/sGA=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-BY1PR21MB4513
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:19:34.3724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id:
	012b8fbb-9c1a-4a57-ecfe-08ddad4566ce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB4513

jasonrahman@microsoft.com would like to recall the message, "md raid0 Direct IO DMA alignment".

