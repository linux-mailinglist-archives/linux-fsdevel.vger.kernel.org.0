Return-Path: <linux-fsdevel+bounces-77826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPVSCpTLmGltMgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 22:01:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228216AD57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 661E13046070
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 21:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39DB1A9FA4;
	Fri, 20 Feb 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W3HhVIDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C351627470;
	Fri, 20 Feb 2026 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771621251; cv=fail; b=mmOWaQhKtkjkpXZVXRRoHT12gnxMZv9xZMFXqE2MLOKVZvYcHKbejA/BWqBs8ITWo/7TfPv/BCKpp1SLIdmp4KMkOZydzzpo1Mst+A8zx7hWit2RawYlFRqLxGo9ulZIlx+YMJ63Ec9Zq36l5ixIfSMzMO8TDfW26NWjFqYHZYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771621251; c=relaxed/simple;
	bh=j4cLYuoFqMCRXvQ6TTKrhCvd/3muqD0vliVdX54xcUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L3mEVtAVIl+q6sCQEfj59pR3NJ6I9XJL4Lk+YqLR7Om0w2XGrWyZvkBM7PPIxnLfTlJFNEoOKxeRq4t/CipXg+5uv6ru6UE9Ai7glWHhj6Q7gzCK/lPaZH0UWhqL85ewf1uKjujC7JlHRvc5kFiMX+OxozUe484o2KJckbHQ16g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W3HhVIDx; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7/m9zwjWN6k6kAETMN73Cap/xpgrFOABqn1zBkagvFPdgaBpMuuI8S0v4EdAviyhjYDeloh3cIR56e584KC1XWXsUHQjsPhDi4yysrCn1wsDPhfl6aM0Vao0we5u+UF/gxXJfiwDAbLSRLkoo+AxA+oItqb4kkU4YLPeiHKDjzGSMEkSP5OfIeWZrFBiByW4ESlUz/40uaBrS+avelTV043gzovFFP1dWUHwkEtc8hmLedng0ghPkCutB1tgORINfGZLAstfgdv1KdCqiAI8JMlfgyOnvlOmp2NDYu/7MKzcWEVcNU+wpC1XnZoJ0A5C+oOXNSys0aLw8yFqsLaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXMTlWTxXVO39c6YPTZL9FDgRvhkNCq31qCNiJLEnn8=;
 b=iLCKEO5qJKympofdmSHy6XrLke2H4moGHJUi5RVDObVe701JnW3AhOaFEwzo0+MVFaDdwGNH1ZJ5nEOAcWQyfuAw24etXF+apgckK/6/t0WjlnXgjrElX1lKZ4JeLjaFYeUb3CQihp/31FzQiJzBetfLkZVUYoBNqkGKmyg1HetR0yqM4z7YBi6oKvJz+FbofOnOXsQcwINbEn2cIN62R5y84SSnfPwCQMbdfH/rh5ZVaEAvpOKW2vxzV2CoK+lda+F2viO4xLVEyHoRXdWLocAyvERhjtxHlUqGXlVkST+yBu7z5QLQSNY5BM9C9irVVV16n/gaIl/9KyFvlEwsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXMTlWTxXVO39c6YPTZL9FDgRvhkNCq31qCNiJLEnn8=;
 b=W3HhVIDxNoZO4WroZZ/9vXyD8iKigkOhWX1At9mhdHCgA5tD2WgDBXB87/v+43QtplKnbGlbFKQMql2W3ZyA2z5TgysTsSSU8hh9JqM7qMAy2eQP4/IaSiCNA1pBvIELqUYlOpK6x7YI7yrntFf5Rh8GdiQ4xYUmhgA/dutM4zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 21:00:45 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 21:00:45 +0000
Message-ID: <789bb5f3-888e-43b6-ba17-66e0e1edfa48@amd.com>
Date: Fri, 20 Feb 2026 13:00:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
To: Alison Schofield <alison.schofield@intel.com>
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <aYuEIRabA954iSfR@aschofie-mobl2.lan>
 <d06fb76f-3fb3-4422-a8b1-51ea0c5e48f5@amd.com>
 <aY11TGmQvzuSKxyO@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aY11TGmQvzuSKxyO@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 19322284-e2bf-4ea7-2763-08de70c31dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0YwVjJKd3VZVnZiSUhmcTkrMEExU3JQNTRuVmFDV2ZsSktLOERyb2l5SDVV?=
 =?utf-8?B?R0tTRHRtZUJqMHJ2WGVSeGF6ZlNYS2M5OFg1MU4xWGc5cjkrcmtKaFd4Z0xX?=
 =?utf-8?B?TTJDamNySEhyZE0zZi9xbXQ3alloZjZ1ak4vQytsRmE1LzVTOC9RdmFRNW52?=
 =?utf-8?B?U3VaZGdTNUFrb1lrSU1oWWo2TzNyVWZMV0thNlYrdHg2WG02OVFkZFU1L3cr?=
 =?utf-8?B?OHVyM3FvZXA3a0l4eHFsaGZDTEpCZDNvSnZ1QkNOY1ZtVUNQMXVoa3FscHVG?=
 =?utf-8?B?cWNGQllXaW9vaDhvNE95WStia1lURURBMFFmQnk2KzBzcW5SanZXYXhQWDh0?=
 =?utf-8?B?SXVpdGVwY1FaNEhiNmV3L0ZMV21JZWxpK0pkVUZYbVgwcjJnT24vV1k3NW05?=
 =?utf-8?B?ZGhFSkVvS0VFL1dsblJObG90bkN2Tkk1bFA0VXo0ZHBRRWlXZjdicmMwTzZE?=
 =?utf-8?B?YzI4QkJRMjdSaW5xbW8vQ0t1ZUwwbVJtQTNUSldBdTJ0bzVCM0hXbEs2WHdn?=
 =?utf-8?B?UkJseklqQ3dzZnE2RzBBTHdXem1rMHY5WWJJdFBaOEJQS28yRHFwemNEZFFE?=
 =?utf-8?B?WE45a1ZEL01ISnNFSmR2NEZPcExpNzVNSVd6QVEyOW50RTlMNVVXR2FsSXN2?=
 =?utf-8?B?RU9CMzBWL3J6T29hT3o3L0U5K05QQ3liMFVQcHNuTGg0ekdZT1NwTEJvcy9y?=
 =?utf-8?B?bmZGblVOYnkrQlQySUlFZGlhK0N4dVZTSVJ0UmNaZDl6SGpDUHQ0S29oTWQy?=
 =?utf-8?B?VTJRYXFvTWZhWUUyRVFhZGtNU2QzRjJMUjBRMHptay90RnZoMzhnVENoTkM1?=
 =?utf-8?B?YWV6c2tiWTltcFQvZWZkTm9KUnpFMnkzNW5yREdQbk9JTmFYYU45Mng5M2Vh?=
 =?utf-8?B?bEVQd2t2T2hHSTlsY1BFc3kyekdmaDZYM0VTWUJRZG1yR25kOWxiZWZyUDFQ?=
 =?utf-8?B?c212aFRWUFM1WU5tdk9IVnh1SDhIcjRDeG5NODk1MUtLWnVPYVFvNDJKVmFE?=
 =?utf-8?B?cVhUQVJldHpYU2JLREMvWGRkZEg1OEZKK1MwcXlLYVAwNnV2Tjg5aEVoa0J1?=
 =?utf-8?B?OFFUMXdlTFU1SHdQbElOQWF0THd1K2lkS3MzYys3NUZPNkNOMjAzdlYxQmFp?=
 =?utf-8?B?eTNFelZ1KzNaMXgvZUFiaUJ6UlFsNGFWVVB3WTZrUDB5Q2wreERGUlFkdGpI?=
 =?utf-8?B?QnV4TXNQRHc2QmRrOFRWSytjMitiSXV3Ty9RTEJCWi9qQ24yS2xOMGd2YWRE?=
 =?utf-8?B?eW43bllzemRicE5CV2xtK2pUa1poWGZnWEsxQlZYRW1JMHQrRkF3OUVmc2JY?=
 =?utf-8?B?ZUJRcGQ5RVAwU2ZpQ0Y4RmlnSEk3blBUeG05c2VrQ2lvbWNBcWxKcUxwNTQz?=
 =?utf-8?B?Rm96Z1dmWm8rdytSWjBvRld2MGNiQnhJNTd6SXUxY1V2MWhZN1RxRXpwL215?=
 =?utf-8?B?U2VKSkIwZHdpQ1BPN3JuUnJndzBOeVNuNmdvU0ZGc1NTc3U2eFQyOHVpUTc0?=
 =?utf-8?B?RWNTUS9GdnhXQkF5ZlFPanBjMnVDQ2tCelFydHNwT2JRYi9zdmNtZTNtbDJY?=
 =?utf-8?B?a3lSWEM0TTRLS05IV0hoZXBWb2NlNVRnNWEzUEQwSjVrYkd1M2Vyb2FUaTI3?=
 =?utf-8?B?NW9qWlRmQnFmWXU4MWhTNEErOEJaQk16UzBVeDBVZjBZaTg2WWpNR3lBb29a?=
 =?utf-8?B?RkU1RGtuU3V5cXZqVmVkcG03NGFtUStFK21NeXJQRnVIZ2lnd2JIZlczRjhr?=
 =?utf-8?B?MnpDeHVYdXFUK1YxZXZtR05FL0ZJR0N6N0JZYkR1VWM3cmJ0YjB0MnFqQS9C?=
 =?utf-8?B?TXlyY09jVm8zMytyMWp3MHh3cnFzVWw1SUtDQUh0bUZzQzl4TzViaHdKRDJ0?=
 =?utf-8?B?K1BIeDhVRVdvbmk0OW4vYXRrTlAwU3h4RFBSWlo2WFhvMklUUlJiYTYxTlhR?=
 =?utf-8?B?ZHExalJkWjExOEdEN1NWQU5ReHNpaEphMzh4S1NvS2dKQm1tMjBHMGpWNGtO?=
 =?utf-8?B?QVM3RzQ2Wm93VVlZQTJ4aXM1eG9NdkpMdUR6MzNwM3lLYWRmTzVvU2xPZCtN?=
 =?utf-8?B?c0ZFSUZYY3NiTHNVLy9ta20wMURVK0xPTmMxbVJ3L25CcTFrOHl5aDkzV1Fk?=
 =?utf-8?Q?cGNpSU/RbEQzU693xAMM+3jBS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjVxajhmTGxQcGs2VzF0dzN0WFp0UWo3blU4UzFzZzNwZ2hkUHNSSzQrOE5Z?=
 =?utf-8?B?NjdVMFFCOUNkQk84aVNWeFNuQ2JKZEk1N0MwaXVYMGNOLzNid1lkVnh1OWxW?=
 =?utf-8?B?QS8vNjE4VVB1OXRPM2grcUluampGSmtvaitkcjM1c0p1Y3E3QnAyRExHaFpE?=
 =?utf-8?B?bjVrOGJVbEtTUURPbFFlSnNadTZJZTcwQTNBU256TEZKbXNrbjFzMXdhTE9I?=
 =?utf-8?B?VGpJR3dYQ2tCV1dtM1VlNTdsaEdhSVgyL21qZ3RDSmxEOFVXa21wUUhweUxF?=
 =?utf-8?B?RnNNU3huSGpHNUoyUzk1WE93TC9vSXRrS3RPNmFodHBxQkR4cGRIc3pNM25Y?=
 =?utf-8?B?WFAxV0s5ZjRhWHV3R2tWeUxheDJiNisyb01xNG8wNkNNd0YzcitpNk54RGpu?=
 =?utf-8?B?QzlOVFpQazVVMnY3TTFmODQreUpOWGFUVnVaNlFKbmZQV29hQkZ0SW00RFhi?=
 =?utf-8?B?UC9pQktxbmhBMCtjNTM0WEFRMEVXRmdHMkwyVXNuNkpHMDNOS29qM3ZtSW5L?=
 =?utf-8?B?THlwbnlNSHpmNHpLQXpoRnFReVhwc05sTEUzZmp0dCt2VGFpZnJjK0dGN3N3?=
 =?utf-8?B?RVpiOVZGa0tPcTlRT2lhWnFzanBXZGU0d1M1RUVDZFZ0ME1GUG1FTDhTZU5S?=
 =?utf-8?B?bVloMEZOYkFvVzkyekJ3UktzM1NXWnBsdWRvK0RzYWl2MmJvRVYyQnlOazdT?=
 =?utf-8?B?dkVjdkF6MlpuNVQ0MmRkbjhOVG9pVW9wTjQwc2NTR0xjc2FPS2FhQkw3T3JZ?=
 =?utf-8?B?eHd2NDNOeU9paUJhNGdJbkFaYzRLY0dtK1UzN21lSFl1UWVzWGVLUkhaaWN4?=
 =?utf-8?B?alVQVEswQ2RjaVdtZ3NnQmJrczdWWHhSTU1hcG15R0VXT2pRODFOQUNXUjlR?=
 =?utf-8?B?QnBRQVJoS1BPL0VOcDhPc1hWNWpqSzhRQU94TDgzYnBWRTBjZzJ1SWZicXpZ?=
 =?utf-8?B?ZnFobklwYVdpK0Q4MWI1RGNUOFlFR3RDdlViZ3BCY0hGZ1ptYVA4RVJtU2FK?=
 =?utf-8?B?cXA3MDZPZk9JMFNLMGNKL0xUajlmS2xrMHREMGdlbzRvOHZGamoreHZUZzh1?=
 =?utf-8?B?ZGRHQ2loNGtEdUtLTy9RQzh5Q0p4Yjgzc001MW1aa093azBOb0JLbm1kOUVs?=
 =?utf-8?B?bk40WVpTMFgvVzh2N0dscUlHcDZVM0I5ekV6OTBQa2FOVE1IaldwMklBU0NM?=
 =?utf-8?B?YkxaQk9kNzArejZjUUxyeHRFZlZKYm16WStEWENlSjhPdmo1K0tJOTd4Q1lB?=
 =?utf-8?B?MTNHVW9lM0QyTDhhZU1GSy80c3gveUo5clZPemk4bW9lQTdQTXJjcWVTaTFT?=
 =?utf-8?B?OG1OV3RBZ3RndzJaK2pnMnFhY1RBdHJaVWt0TldERFl4dmc0d28zTXc1akp2?=
 =?utf-8?B?cERDRmk5ak5IVDV5dG1UektQWHFoUEdWenk0WnM0L1dUQldPNmZ3WlVrZVYx?=
 =?utf-8?B?VnZIcXZzVkdzUU14dXhLaFE5SldCZGd2RlNhWVBrSmxNTi94UXoza3FOMmpy?=
 =?utf-8?B?MS9XZjZ2NzFNUFBIckJqOVo0ZzRyYkUwbGJBZ1JTRXRtN1lkaVdDZkUyQlJE?=
 =?utf-8?B?Skw5K09obFRFT3pmNlNwQzM3d3dnY0Y5dE9VSTBQcHdIbkhSQjlNTkE1Nkx0?=
 =?utf-8?B?WTFOL1FibE12ZmpFbWs4ckREVTM3ZlBCMWhTMUVoTXNoajFBVTZZcVFtaFFr?=
 =?utf-8?B?bnYwREJ6MmNxT1Jqc01YempGeVNvQ3BmU3VxYmlsZjNVQk82b1RBUDg3Y1p6?=
 =?utf-8?B?VE11ek9Kb0lCVk5kSTR1L1lPUkh1dTVoZng5OUwwMXY4RDE0aDFmdXdrVHhj?=
 =?utf-8?B?djQvSXBWZllvVDJlbVlPMzBrNyt6S0RQaW9jTjZQS2tDUEN6cW43S1B5YitL?=
 =?utf-8?B?ZjJYS2d5ZlQrc0llbVdwbTBoRlVCdEhwTjQyekI4dEhoeFcvb2JwV2FhZ2VV?=
 =?utf-8?B?dStENGlicUgrbUFYV0RWOUtRN2hUeTZ2Tm5YbmIwUkRjZmpqMVdlMHBpR3lM?=
 =?utf-8?B?QU5rVHFCNTZ6dm9oY3FFZVExMHphYXRJWEpWUjZZTjlDR2d3c2pPdjVQTUhj?=
 =?utf-8?B?S3FtM1ZUZDVPSEhkTGJrTTFoWHdoZk5kV1VONXJjOCsrNTRBenlqV3h1clhU?=
 =?utf-8?B?Yms4Q3FRWkppUmdTZDBhSDRoeUlLalNwQUp6RVpsQWkvOTdOaGFZWjMwSE4r?=
 =?utf-8?B?ZHZhTTNhMEpDR1ZMdksycXAyRFFVUVVYU3lZVjh4cXRFdFVqWWE1cU5MallM?=
 =?utf-8?B?UlNMZS9CNnVFdXcyNjBGTWROQnlxL0l1RnMxZW5LR2txL2taZ0J1VCtobS9w?=
 =?utf-8?B?MG1tUS9NSUNXVzJ2Qms0OWN5dGFvVzMrU1IwVGRlWXlUUzJnaWRtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19322284-e2bf-4ea7-2763-08de70c31dea
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 21:00:45.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fdnfCtBzWtedEpRa94QpkTs9RE+0w1wKTBm/OSzJzU5Zn0RerpDwN3jjdQjam9fB6NLFMYhGIFE0hqhGr+m6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77826-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skoralah@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4228216AD57
X-Rspamd-Action: no action

On 2/11/2026 10:38 PM, Alison Schofield wrote:
> On Tue, Feb 10, 2026 at 11:49:04AM -0800, Koralahalli Channabasappa, Smita wrote:
>> Hi Alison,
>>
>> On 2/10/2026 11:16 AM, Alison Schofield wrote:
>>> On Tue, Feb 10, 2026 at 06:44:52AM +0000, Smita Koralahalli wrote:
>>>> This series aims to address long-standing conflicts between HMEM and
>>>> CXL when handling Soft Reserved memory ranges.
>>>>
>>>> Reworked from Dan's patch:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
>>>>
>>>> Previous work:
>>>> https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
>>>>
>>>> Link to v5:
>>>> https://lore.kernel.org/all/20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com
>>>>
>>>> The series is based on branch "for-7.0/cxl-init" and base-commit is
>>>> base-commit: bc62f5b308cbdedf29132fe96e9d591e526527e1
>>>>
>>>> [1] After offlining the memory I can tear down the regions and recreate
>>>> them back. dax_cxl creates dax devices and onlines memory.
>>>> 850000000-284fffffff : CXL Window 0
>>>>     850000000-284fffffff : region0
>>>>       850000000-284fffffff : dax0.0
>>>>         850000000-284fffffff : System RAM (kmem)
>>>>
>>>> [2] With CONFIG_CXL_REGION disabled, all the resources are handled by
>>>> HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
>>>> and dax devices are created from HMEM.
>>>> 850000000-284fffffff : CXL Window 0
>>>>     850000000-284fffffff : Soft Reserved
>>>>       850000000-284fffffff : dax0.0
>>>>         850000000-284fffffff : System RAM (kmem)
>>>>
>>>> [3] Region assembly failure works same as [2].
>>>>
>>>> [4] REGISTER path:
>>>> When CXL_BUS = y (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = y),
>>>> the dax_cxl driver is probed and completes initialization before dax_hmem
>>>> probes. This scenario was tested with CXL = y, DAX_CXL = m and
>>>> DAX_HMEM = m. To validate the REGISTER path, I forced REGISTER even in
>>>> cases where SR completely overlaps the CXL region as I did not have access
>>>> to a system where the CXL region range is smaller than the SR range.
>>>>
>>>> 850000000-284fffffff : Soft Reserved
>>>>     850000000-284fffffff : CXL Window 0
>>>>       850000000-280fffffff : region0
>>>>         850000000-284fffffff : dax0.0
>>>>           850000000-284fffffff : System RAM (kmem)
>>>>
>>>> "path":"\/platform\/ACPI0017:00\/root0\/decoder0.0\/region0\/dax_region0",
>>>> "id":0,
>>>> "size":"128.00 GiB (137.44 GB)",
>>>> "align":2097152
>>>>
>>>> [   35.961707] cxl-dax: cxl_dax_region_init()
>>>> [   35.961713] cxl-dax: registering driver.
>>>> [   35.961715] cxl-dax: dax_hmem work flushed.
>>>> [   35.961754] alloc_dev_dax_range:  dax0.0: alloc range[0]:
>>>> 0x000000850000000:0x000000284fffffff
>>>> [   35.976622] hmem: hmem_platform probe started.
>>>> [   35.980821] cxl_bus_probe: cxl_dax_region dax_region0: probe: 0
>>>> [   36.819566] hmem_platform hmem_platform.0: Soft Reserved not fully
>>>> contained in CXL; using HMEM
>>>> [   36.819569] hmem_register_device: hmem_platform hmem_platform.0:
>>>> registering CXL range: [mem 0x850000000-0x284fffffff flags 0x80000200]
>>>> [   36.934156] alloc_dax_region: hmem hmem.6: dax_region resource conflict
>>>> for [mem 0x850000000-0x284fffffff]
>>>> [   36.989310] hmem hmem.6: probe with driver hmem failed with error -12
>>>>
>>>> [5] When CXL_BUS = m (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = m),
>>>> DAX_CXL = m and DAX_HMEM = y the results are as expected. To validate the
>>>> REGISTER path, I forced REGISTER even in cases where SR completely
>>>> overlaps the CXL region as I did not have access to a system where the
>>>> CXL region range is smaller than the SR range.
>>>>
>>>> 850000000-284fffffff : Soft Reserved
>>>>     850000000-284fffffff : CXL Window 0
>>>>       850000000-280fffffff : region0
>>>>         850000000-284fffffff : dax6.0
>>>>           850000000-284fffffff : System RAM (kmem)
>>>>
>>>> "path":"\/platform\/hmem.6",
>>>> "id":6,
>>>> "size":"128.00 GiB (137.44 GB)",
>>>> "align":2097152
>>>>
>>>> [   30.897665] devm_cxl_add_dax_region: cxl_region region0: region0:
>>>> register dax_region0
>>>> [   30.921015] hmem: hmem_platform probe started.
>>>> [   31.017946] hmem_platform hmem_platform.0: Soft Reserved not fully
>>>> contained in CXL; using HMEM
>>>> [   31.056310] alloc_dev_dax_range:  dax6.0: alloc range[0]:
>>>> 0x0000000850000000:0x000000284fffffff
>>>> [   34.781516] cxl-dax: cxl_dax_region_init()
>>>> [   34.781522] cxl-dax: registering driver.
>>>> [   34.781523] cxl-dax: dax_hmem work flushed.
>>>> [   34.781549] alloc_dax_region: cxl_dax_region dax_region0: dax_region
>>>> resource conflict for [mem 0x850000000-0x284fffffff]
>>>> [   34.781552] cxl_bus_probe: cxl_dax_region dax_region0: probe: -12
>>>> [   34.781554] cxl_dax_region dax_region0: probe with driver cxl_dax_region
>>>> failed with error -12
>>>>
>>>> v6 updates:
>>>> - Patch 1-3 no changes.
>>>> - New Patches 4-5.
>>>> - (void *)res -> res.
>>>> - cxl_region_contains_soft_reserve -> region_contains_soft_reserve.
>>>> - New file include/cxl/cxl.h
>>>> - Introduced singleton workqueue.
>>>> - hmem to queue the work and cxl to flush.
>>>> - cxl_contains_soft_reserve() -> soft_reserve_has_cxl_match().
>>>> - Included descriptions for dax_cxl_mode.
>>>> - kzalloc -> kmalloc in add_soft_reserve_into_iomem()
>>>> - dax_cxl_mode is exported to CXL.
>>>> - Introduced hmem_register_cxl_device() for walking only CXL
>>>> intersected SR ranges the second time.
>>>
>>> During v5 review of this patch:
>>>
>>> [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory ranges
>>>
>>> there was discussion around handling region teardown. It's not mentioned
>>> in the changelog, and the teardown is completely removed from the patch.
>>>
>>> The discussion seemed to be leaning towards not tearing down 'all', but
>>> it's not clear to me that we decided not to tear down anything - which
>>> this update now does.
>>>
>>> And, as you may be guessing, I'm seeing disabled regions with DAX children
>>> and figuring out what can be done with them.
>>>
>>> Can you explain the new approach so I can test against that intention?
>>>
>>> FYI - I am able to confirm the dax regions are back for no-soft-reserved
>>> case, and my basic hotplug flow works with v6.
>>>
>>> -- Alison
>>
>> Hi Alison,
>>
>> Thanks for the test and confirming the no-soft-reserved and hotplug cases
>> work.
>>
>> You're right that cxl_region_teardown_all() was removed in v6. I should have
>> called this out more clearly in the changelog. Here's what I learnt from v5
>> review. Correct me if I misunderstood.
>>
>> During v5 review, regarding dropping teardown (comments from Dan):
>>
>> "If we go with the alloc_dax_region() observation in my other mail it means
>> that the HPA space will already be claimed and cxl_dax_region_probe() will
>> fail. If we can get to that point of "all HMEM registered, and all CXL
>> regions failing to attach their
>> cxl_dax_region devices" that is a good stopping point. Then can decide if a
>> follow-on patch is needed to cleanup that state (cxl_region_teardown_all())
>> , or if it can just idle that way in the messy state and wait for userspace
>> to cleanup if it wants."
>>
>> https://lore.kernel.org/all/697aad9546542_30951007c@dwillia2-mobl4.notmuch/
>>
>> Also:
>>
>> "In other words, I thought total teardown would be simpler, but as the
>> feedback keeps coming in, I think that brings a different set of complexity.
>> So just inject failures for dax_cxl to trip over and then we can go further
>> later to effect total teardown if that proves to not be enough."
>>
>> https://lore.kernel.org/all/697a9d46b147e_309510027@dwillia2-mobl4.notmuch/
>>
>> The v6 approach replaces teardown with the alloc_dax_region() resource
>> exclusion in patch 5. When HMEM wins the ownership decision (REGISTER path),
>> it successfully claims the dax_region resource range first. When dax_cxl
>> later tries to probe, its alloc_dax_region() call hits a resource conflict
>> and fails, leaving the cxl_dax_region device in a disabled state.
>>
>> (There is a separate ordering issue when CXL is built-in and HMEM is a
>> module, where dax_cxl may claim the dax_region first as observed in
>> experiments [4] and [5], but that is an independent topic and might not be
>> relevant here.)
>>
>> So the disabled regions with DAX children you are seeing on the CXL side are
>> likely expected as Dan mentioned - they show that CXL tried to claim the
>> range but HMEM got there first. Though the cxl region remains committed, no
>> dax_region gets created for it because the HPA space is already taken.
> 
> Hi Smita,
> 
> The disable regions I'm seeing are the remnants of failed region assemblies
> where HMEM rightfully took over. So the take over is good, but the expected
> view shown way above and repasted below is not what I'm seeing. Case [3]
> is not the same as Case [2], but have a region btw the SR and DAX.
> 
> 
>>>> [2] With CONFIG_CXL_REGION disabled, all the resources are handled by
>>>> HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
>>>> and dax devices are created from HMEM.
>>>> 850000000-284fffffff : CXL Window 0
>>>>     850000000-284fffffff : Soft Reserved
>>>>       850000000-284fffffff : dax0.0
>>>>         850000000-284fffffff : System RAM (kmem)
>>>>
>>>> [3] Region assembly failure works same as [2].
>>>>
> 
> I posted a patch[1] that I think gets us to what is expected.
> FWIW I do agree with abandoning the teardown all approach. In this
> patch I still don't suggest tearing down the region. It can stay for
> 'forensics', but I do think we should make /proc/iomem accurately
> reflect the memory topology.
> 
> [1] https://lore.kernel.org/linux-cxl/20260212062250.1219043-1-alison.schofield@intel.com/
> 
> -- Alison

Sorry I missed this message. I will go through it.

I think the reason I wasn't seeing regions in /proc/iomem during my 
testing is that I was using both of your test patches together, the fake 
failure in cxl_region_sort_targets() and the cleanup patch that calls 
devm_release_action()->unregister_region() on attach_target() failure in 
cxl_add_to_region(). The second patch removes the region on assembly 
failure, which is why the iomem tree had no region in my case.

You are right, just with faking failure in cxl_region_sort_targets() the 
region will exist in iomem tree.

Thanks
Smita

> 
>>
>> Thanks
>> Smita
>>


