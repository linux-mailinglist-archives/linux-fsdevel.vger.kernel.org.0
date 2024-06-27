Return-Path: <linux-fsdevel+bounces-22601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E4919F1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 08:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A9BB20BEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 06:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60007208D7;
	Thu, 27 Jun 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RxvV8X2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2177.outbound.protection.outlook.com [40.92.62.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338817C6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719468704; cv=fail; b=ns03zlEpfhwt9Nvc+/JCnx522wv2c67cCdH5aOiRPUEQvOZ13yPPg4gGMyXPh1A8U7FALe74HgVwXy1YFQ5YjYw1ls6NiWkUHAz4wxYAXdfDwx0K0ZYpNOH8jJ42ptkVHtM9VQ5e5GtusuX1IsqApbIf8dg7pkbqE9zhjiYhAic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719468704; c=relaxed/simple;
	bh=k0zbl9B5fVrBOxQPwMWdILQgc4yE4EPArA2+y+IfMaA=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MjLAhwP41ZpdoAvs1yQiam2aWMLB6fHOjsD1iNb5buR54VG2NPVe2s5reriUnGnMoFJimmF/0XfTJN0DT7oYb0ZdH8Bq/YzfhgsE1VlT+RQhsW6L+kSBQrXKzfOa4Hc9veahpDYy6UBGiAAQ8YfJnMaU43BZ+VjRFP13m6cjJyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RxvV8X2z; arc=fail smtp.client-ip=40.92.62.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXyFNMQ3egWrlf1F6IxUhHaF568GtsmiSkjbwMq0gwIRDaTFa7/RmjLQtYJuz10pQKgi+DgCoCwtzIywDUM7z+FIoUcXcpzu+x5KLr4s5SCtRIQeyYvmnjKywEi+jG+2yNmnl9+HdD3gHXJX7Fp0NQXFar3iBzTNr8CbV94YXDuBt4A4ph/QD0GDXDHUiqDLMMFaOw89N29QVklHrErU3mBef7peJKpU7FBZx0qgWMgD79jpxmZh45CSRgG0E0a/B58CSqn6V6tpIQqAg99W5WHZcV7Il9dYiyONNjBBHxjuKj6eVKtmfWMLu8E4GDrj2I2Ns8wjjsQw7/fEkBEIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfSjUwJ9Hv0H8nzBJ/bcoldE3LxZBbeAHDTlTya4kRE=;
 b=YLeDI3CH0lR8daIkGHnDy7BhHYThyFBwiOkccmAxOy/yVcN1c2UsGJwjC7sriE6cPf7MRP5bMbe34nGmVDK5pyt9+x6qbAFOjI6ULiR9Es7wtCkUX+LsdPfhz9bC+Deob2uG7P1N4P2nUz9DI9zCftlYoBZ29IejgYam1cDjnBpWEpcnNiXkzihuzH1b5R0rW+wpoG9aPkKLatSlqBDItd97vugiLeBUz2oZBpXeJ7QGpxCdB93dgQnBnA44SJr6cFzZXDHAlgEYdZME39B8nNxH9W9oFHeP/oPBQ03GQOpaY9Ga/ywGqT5xEIynMBR4UUcSRjrasQ46vQeGLryoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfSjUwJ9Hv0H8nzBJ/bcoldE3LxZBbeAHDTlTya4kRE=;
 b=RxvV8X2zVw5oQeZkF6FtUe0O4Z35kNVj/WYtCr99rPZbVMOOyQlvxkOLWCCnihIvcihotddqAnmtD3ZVNVTbamZxhLLuvuR7dAPURacJ3Yd0RbQDw6uE6SqSrSbss9lg3sc+IlmM6vGGMdCsasBEL1FMzJIm6EScPjlV3F3AcjuLECaZKuLzKmnUqkuJvCYGkHVX2kQOMjpALtQbGh640VTGsJYV7OP8QQlD5I4sCWisjlEYgm4CWpvMgo84IjInNtlABX47ufsDOOnyIQGspBzY0rWmPIIkZe4rNdxPBI38ntJIndKL0wRtUnNcqsSqX5LPIfaUybextJSsb5ahRQ==
Received: from SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:97::7) by
 ME3P282MB0786.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:8c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.35; Thu, 27 Jun 2024 06:11:35 +0000
Received: from SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4e8b:9d6f:dc5:3464]) by SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4e8b:9d6f:dc5:3464%5]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 06:11:35 +0000
Message-ID:
 <SYBP282MB2224ADAC7D8A689BCC18F78AB9D72@SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM>
Date: Thu, 27 Jun 2024 14:10:48 +0800
User-Agent: Mozilla Thunderbird
To: zhangpengpeng0808@gmail.com
Cc: akpm@linux-foundation.org, bruzzhang@tencent.com, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, vernhao@tencent.com,
 willy@infradead.org, zigiwang@tencent.com
References: <513c13ea-3568-441c-972c-c5427d076cb9@gmail.com>
Subject: Re: [PATCH 0/10] mm: Fix various readahead quirks
From: zippermonkey <zzippermonkey@outlook.com>
In-Reply-To: <513c13ea-3568-441c-972c-c5427d076cb9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [325nCcUT0WbsRbE2kUtR3cfVX9Fa/SPQ]
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:97::7)
X-Microsoft-Original-Message-ID:
 <a04de1ca-a64d-4c60-824d-87922ea52d18@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2224:EE_|ME3P282MB0786:EE_
X-MS-Office365-Filtering-Correlation-Id: a596ddd5-f3e4-4989-3db7-08dc966fff94
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	WwUlqgE4nhsXZaKIa9Lmgl0bspqrOKUQRahtdfdGO9tOKHZdQXaXLdGVNp7KR2xTzyHm/Yj/aIHwkzqfTAfHyZB4F+HHJXxxpTqEDIw4tdrK6QfJyGS7uNOvyCbidl4CKefGA48to8gDtp/UECOcaWdL8k8D9wEcxiYOegeseaxTJ3cF1ilmV1HP+pCxCHyx+FaZaEf6wUf0MtjAIYxsXEZfxBEmDnzUC8EQh47kHfU5O0NNYOnsYAMZIU0mD4mQaQJQqdnwTtgnZhqJApj3Ha8MNMFuNhzqqvFf54iVK0Ar9Rx2uDd6Z791cJomSBFrfFiQOY02+sCneEsFdnd+Pf72HvpLCjGiNDvilrmREm4Qrj2b0drzLf4QixLhPLxgeZqc6M6TVl+hboAKMFBZdgjB1t7NKHfxMaGwz6Y8lVpeuoxGhtZZDNO2zmFJtK45GOCxKmVrpb+5zg8oMO3OnJA5MmQgyP7T5kYkWuzJh3Po0/NKmS5IYqVQBVOtcKEpjuCMGSIcv1EAbLG8EOrz4tH4KH6tret+mj3Y45xLbojxtvctx9hC+1ntsDIlFTWYVCHpVJNerBln2eL+igUdFAWHW3bcEc1D0nmY9GjwktQn3UI7PvjJoCnQliEhaV1gyeEHwV2nG0RZLXjpMfphGvgMfbVV0+N+aH4bl0GPOtuN+pjcjz0S97dFgL7In8rg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRQdWZRVTE5bGQ5dm9FU1ZtSDhQSU5ORmtQM2pjWEFFeFhuOGgvS1lIaysx?=
 =?utf-8?B?ckZNb0duZzZYbVozK3pmV2RrWHp6Mk9sRTE0UExBR0hpVGo4cVdGZlN3d3NG?=
 =?utf-8?B?cnBKdXFKdG9ELzc0eEx6Q0hrcndQVy9TZ3dzdmhXc0V1bG5JTldEYmc5ajRV?=
 =?utf-8?B?QTZ2K1JkK3RhY3Azb3AyMmtGMUUybUVPY01OUUNDUUd5NVkrRW9iSnFSRDg3?=
 =?utf-8?B?VEdMMmtGQlplaXdsTEMzU3k2YUpneHg4MmVpWDZzcjkzNmVSSnZwcmQwSTV4?=
 =?utf-8?B?dWJ2b0JRbWhLS0VuenBVSUpvZ2NtOVlIU0k5NlJISkFXTVZSa0M4b3JXRXg3?=
 =?utf-8?B?R0RkSnlhY3VaUlgyd0tWa2pzWDFYOExEdGJFdW9VY25Mc25iOXVoZXlKYzZo?=
 =?utf-8?B?c1ZhVHVlYm8xcllTdGpuYlB0bC9VUWlpNFdBY3lDSTQrRFV0WTQ4TnhVRkhU?=
 =?utf-8?B?TWVrYTFPZk9Xc1Q4d3VxWHZuc2wxR05ONS9NMjVKNlhscFlRTHUyQllGK2Jk?=
 =?utf-8?B?WEY4NUlYeU9xZHhQMElLVnh0cGFIMGJkSG8rR3dGMHFiZzN0THYrT01BMWpp?=
 =?utf-8?B?SUtzaEVWQ29VM1IvZ3hTeHpwZTlnNWlsNTU1b29aSXRRN3daT2xUMmxyK2Rj?=
 =?utf-8?B?V21YY01qUHJBL1lVUUxQczJ3WHdmUTZIMWJLYk9WcGJrNkRjWXY2V2JDSVlL?=
 =?utf-8?B?TndxTWdZaEswOC9yZ3Z2eUxsbDkwN3NVR3RaT2Z0MDVOVDhpQUprbTgrbVJO?=
 =?utf-8?B?WUlLQjNaK1gvWnNCUnlmdXZtVklsVklvSjF1akhIYlZ5NHdpZTlhZk5aYXhz?=
 =?utf-8?B?MWtlK0VrS1lqZU1kRHpqZnF6azh6azBtU2hqOTErT3c0M3NtS240YUZWeUho?=
 =?utf-8?B?VzczUzhVcXBDODdsMGRXbDJsMHdaL1Vxa0Z2TnFpMHZXd2lLeFlta2IxR0J1?=
 =?utf-8?B?K01ETzN6Y3JZZWpyU0orcktoRDZMU1dCYzljNFJ1ZU0yRmJMUlNVYnNiUnpn?=
 =?utf-8?B?QURuOHo2ck01Yy9Wb3VqNkFuWjROTmFRVU1XVkU2c2krd2lzT21ZOTE4ZG9l?=
 =?utf-8?B?UXhlbk5kWWc1cWwzcmcxN2V0NG1QcHNpY2pPd3NTV2hiMm9LZ0hUU1VKeDQr?=
 =?utf-8?B?am96U3k3ek44YXVpSUViYjJUblJQd0RLaG9Db2hjL2tvb2dtM1dmSXBoaG9k?=
 =?utf-8?B?eTNieTdIYjlELzQwUjAxenFTK0h5dTV4SnVrOGVLRVMwRjNQb2RwWGU4SzJa?=
 =?utf-8?B?ZmxsZjZ2dHpPSHU0dU5UZktkUmgvZDUyZU5sS294MFVLckJqSFdBcURQNWVv?=
 =?utf-8?B?b0xaeEQ2R1R6Qkd5MkhrdHpFSW5lTTdnMDB1bXgxNVRzcHZmTCtqd3BlTzZz?=
 =?utf-8?B?dytwZDJqN3phL3ZKalJpaW9UNElhQmtOeElOZ3c2ZnlGUGZnYXhsYkZUNTlh?=
 =?utf-8?B?c0p6bldlQ1djOUhIc0F5d2xrQVpCbitncHMxd1ZuYnI4RVVSYU9IK01ML1lN?=
 =?utf-8?B?ZDRwNnpnbnFnV2VSWjhkcVpTTjVOeFNobG1mVFdzZ0MyaWRIZE1JQlc1Q1JG?=
 =?utf-8?B?SUF5N0hUU0RTdkEwT0pQS2N1N0l0bDFUN2ZUWnJ6MHlxaDY3ZC9XMlZxNHJR?=
 =?utf-8?B?NVZiTjdyS0M1SnZQeDVvK0M1RkxjM2JRbHE5Rml1OGtDOGVnUldDdFJZc083?=
 =?utf-8?Q?Boxa8kB9zGr/AMAM6FwA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a596ddd5-f3e4-4989-3db7-08dc966fff94
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 06:11:35.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB0786


Hi, Jan

This is my environment:
pcie gen 3  NVMe SSD,
XFS filesystem with default config,
host 96 cores.

BTW, your patchset seems also fix the bug that I found[1], more complete 
than mine,
soyou can ignore my patch :)

Thanks,
-zp

Tested-by: Zhang Peng <bruzzhang@tencent.com>


[1] 
https://lore.kernel.org/linux-mm/20240625103653.uzabtus3yq2lo3o6@quack3/T/

