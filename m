Return-Path: <linux-fsdevel+bounces-35941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21CD9D9F1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 23:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F06116681F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A611DFE08;
	Tue, 26 Nov 2024 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NbjGDwPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2077.outbound.protection.outlook.com [40.92.58.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD01DB377;
	Tue, 26 Nov 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732659316; cv=fail; b=ltMX7EzKV6iXWcFRpHs9v7jHDHqWBHrdtTASSMyVNpFiZ3z4K+SvhAiTS5CZGeOvysxjFfeW6ABvg/9ejT5F5tTf4sI28U9Nr+9JcTbfKfI3lYwu1P/HINQHPmOreH4Jzxmlpg+kfJnfbuqjKEIjZPlgt2Bw6v5WKIjWNapjc4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732659316; c=relaxed/simple;
	bh=KvrYyJy1016M4Le8B9vCF2xz6WR80nf/byvx2HDFdSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P7m210AN8aHB4HSOKzJ0DD9LcqFKNCOxpC/l7j9Lm8avI6mYcJmt4T6TgD95ANBI6XANx722dkNoU/IVDdEY0RoelqYoAzR/FfXM9JFRhlnCxO5NXK3vxD4GiMi3gQeH1ZG/aKMqo6k9MhPO44kUK5H51QnJK+f3WYs5NQ4JqYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NbjGDwPl; arc=fail smtp.client-ip=40.92.58.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4N5FPUIPJOjJKHq5vA2+vlM363Oy4P0xml67gOOuYrX5bCPEuX04FF2/hpCftpPBVxAOKloei0qz+cKaIOzeeqaheVlWXnRu927bqgUoaqKzqNeebEiaDmF64fDxSslGSaiadOKH+XmryFUCzN+DqkhMbZiL3wC53p1eCBeW3eBz9NZoI6DbRRm2K0HZIeeArH1j0wAIghwLmCS4NHqrZnolMlwjeunB3JozBqGmCGN/tV1GSjJVO6/fpUITtFSrJdAH/TLNgLdbT0ExaLE5AaSIKROsvX+NlJuz3jnElGhIr3uzzHkh/6ndd1B5QuCoj2T2b/7PBSg2/wdF/vBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=399vdkEDxCH5PFTmP+56RZNmBkjj6Rg6rcyf0MGxxTs=;
 b=R+y437H8hR9qlDgM0kWIYOl9MVnRTigIPAtQgVgypSQyChxUd2qWKOrDc0zyEKCOjceH8rNyywbCLgfKyJlyjE46dzOBklQzsZm21IvI97I4vjg+SAw3ttG0uSjcFhWvXUUNDGOyBu4A8y7xcmP6yaG2Kj19beXNHl2f+RVqt6e6+GHCW8kc0Y72soBBnonTVA9iJk8pW8vgOeGHN7eKNVjTG3maeTrhQxPd5Vidz2/wtU82N5FIRDFRHRU31Emp2YxzYxivGMfdKWgB/7/ASQO25BnyaCErSHieY03Iq8LD6SzJ4y0QyHFMaYn8VUVa9PGcVf0eeDCnLSZd7IV4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=399vdkEDxCH5PFTmP+56RZNmBkjj6Rg6rcyf0MGxxTs=;
 b=NbjGDwPln2oh7vXHsQlIRVWvcRjj9u81T+q+u2vsoTjA3JBYJlCVXGSP/QBfMkOMcSQ8RD9oK1ezZHPEfYGb2JFmFcThAAz5MTzBw6J59wRobKxHR6r272BxHe7Ck3IYPwbzNDykAQkBW589SvfMzaSAJmDApSF7NptzBccKaufIPUKKbsN4nB2xSiadvQdCdHB1Zx+x/ztdXHck7bOYPzRz0s/7m8ouJYHTH9BWx8JF3tfLPwt3bHkdDkIhTVPDDckNYGmS/fxGJnuY1dWlxikSVZNwzbhzW7+mwc05HJyjytax3nC8MA/nCdrMgRWThsIS6kqzAIkw4thvjVfZkA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GVXPR03MB10245.eurprd03.prod.outlook.com (2603:10a6:150:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 22:15:11 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 22:15:10 +0000
Message-ID:
 <AM6PR03MB50804262BBB1A50C254A506D992F2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 26 Nov 2024 22:15:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
To: Christian Brauner <brauner@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080BCAC62436057A03B334499202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241120-campieren-thermal-a2587b7b01f5@brauner>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <20241120-campieren-thermal-a2587b7b01f5@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <49ab7507-a8ce-4e8d-aa24-9dbcde39ce55@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GVXPR03MB10245:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb556ae-5916-4ca8-fb54-08dd0e67c94e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|15080799006|6090799003|19110799003|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWsxM2lnQlA1Tk9iUE0yZ0p4eFJwL0hMT3pEU2krWWlMNkJOcjF0T1hGdXFk?=
 =?utf-8?B?T3NzaHI1RkI4bDMyZGswNzVPSFNkU2RYWGw5cG9wb3BpZjZhU09OYzgveTVt?=
 =?utf-8?B?VTdhNU5UT3p6M0REY0FPWGJzNXBIVDNHb1g2U2FOSXIydTBrOS9wNVFTc05y?=
 =?utf-8?B?eGVDT0pMRUZTYWNad3J5ZVJHQkNQUTd1TW1RMHEyM01wZHRzZEFvSjEyZ2l4?=
 =?utf-8?B?eEt1dnJEaUZ1SnREejRLTjk0d3ZGQjc2bUkzQkFQbHN1QnUzTFJOa2dWYzM2?=
 =?utf-8?B?VzBmQjRPM0ZZTFEyb20rRVk2VEdaVnZxQVFWYVBTZ3hwNm5VMzdDbXprV2hk?=
 =?utf-8?B?TUtLK0lDQ3VManlXdkpJTnBUNVcwREprdlZxbTY1S3dFNWMrWDdJS2hicndJ?=
 =?utf-8?B?allSdHYrZHdsem9kUExYK0dnZElhMjg3QVU5NTBEajllWGM1MTA5Q1NJeHRI?=
 =?utf-8?B?eHZpVUdhcytSVXB4NzIwRXFvMFlPcXJBdEFodzhkYU82NUZIbER2OG5ybmor?=
 =?utf-8?B?ZkhwYURjb1lTWXJsaFBCNFZmd1RYWm5ySFVkMnYydnNaR0c1Zlh0ZXk4R3JC?=
 =?utf-8?B?azNGU2ZCNnVFZGh1UFRQQkdzNGMvTDFUSGF4QkxJdVdCT091ejJ6TWlDSHNm?=
 =?utf-8?B?dTVMbGEyQnl1UU8rVWtHaHFlalRqT3p5b3ZsSk96ZldROXdJd1VSeTMwTUYv?=
 =?utf-8?B?cUxlakkvTUYwaXFocjM1SGpVTm1Pd2VQaGRVaWpwUFgrczZZT3l0aGd4TlR5?=
 =?utf-8?B?SkVUWlc0RzBwYTFBQ3ZUUWRUaldIM05FTFp2L21zVWt2R0J0VXdXU3lJWEli?=
 =?utf-8?B?Y3pSRC82OGRIOG5XTWFNZkljaklyS1pndlI4SzZxNFIrbGhnMG1FTzBhMjlD?=
 =?utf-8?B?NFV0VWIrczE1bVhnUk52cTk1ZUgya3JyZWU0MmpXS0R3L2lzeXFOSklDellP?=
 =?utf-8?B?a3dUdVEreUMva25RVjM0ZUZXODZza3RUMUxodkNrcitCdC9BM2V4Smg0VkxJ?=
 =?utf-8?B?VU9LZVRiL25MT3YyTzNCdG9BMjA3dHpjVWgwQldtWFpxa203OGNEeGtUM0hj?=
 =?utf-8?B?YXdUQ0VWY2tJWFVzN1hmSUUvQnNuQ0tDa3htS0dySExpUVZDbE5ja3VMeGVZ?=
 =?utf-8?B?My9iZ1Z5U0s2RTY0K0Z0M3VSblBKYTY0cmNETnowT1pRaHlCSGRGbGVRRm5L?=
 =?utf-8?B?cGx1ZFMvYWlKMUNsQ3p6ZkM5WGxxQmJlLzhyNjh3RHhNU0FzeXBId0Z0eURZ?=
 =?utf-8?B?bVJiR1BtUnNraUFSZFE1ZVdsaCtraXVyKzVhbldqTFZOcnc3L1BjVi9uWHI0?=
 =?utf-8?B?T2FQQlpEWUsyemVxY1R5Vm5LT2VJQ2tUc0RYRm52aERza3FpcHdCNFBJQVNN?=
 =?utf-8?Q?aPjd3PC8jxScBk6RgX1P6bB0ERYU35W4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N05NVVVOanl4ZUJZRVh6R1FzdW5vempJNlRSS2pGSkl3eUpsRndtSkdnUW05?=
 =?utf-8?B?VEt3WnR5b3RGVXg3ZGhNN29Md2Y3KzIxL1BiVU1EemNIUU1QOFVyR3B4SE9v?=
 =?utf-8?B?dTcxOTFvS1hhNGtZRnp3TTZXbHVNN2hsOHlHYVg5WDJNZGc5S01GTGRsZStx?=
 =?utf-8?B?aDNEalRualBjNWVTM1lCN2xiV25IY1hGRGJ5SFNIZnhaVjQ2TnNNbDlJQmV3?=
 =?utf-8?B?Y3V5QWZEN2RIWmdIVW5VK2h0SzZ6bFUyUXR6TyszVmVVOWh2dkg5NFp0U3Fv?=
 =?utf-8?B?ZitvZW81K3JyUHBnRXM4cDhwRWRxdm1rZ3dGZ202UUltZnhVUEd6NmprU1RX?=
 =?utf-8?B?RWNKWHBBQXhhM25MZmZobklOOFA5T2VNN21XaGtXc2xOQyttcUZDUmYwbElU?=
 =?utf-8?B?Q3lDbXBGRGxnOWdsSXkwMlhkSU1hejdHb1R3Q0ZmUWJzeDgwSHpnQmJGNDJE?=
 =?utf-8?B?R2dZUkkzM0FKZ2FYVzRnSXlLcmtpd3hrQXVkSkZVMkxWVngxVkRRSHhnVDdJ?=
 =?utf-8?B?V1R6RmZuaU9yaE1kUktqSUVxQ0V1bDE1dmk3eEhYVDJPbHlMQituZVBjaHNz?=
 =?utf-8?B?UWs0RU92eGpBS0lzS0pyMUZuYUk4ckxvaW1WVjZ3V2JjSjVIUEt4czJqWGdF?=
 =?utf-8?B?TFBqZXlIcXBWTDlFVTdnMGtpbXVWWFFvRlVpanQ4VWdGSWE3MWxaQks0eXpN?=
 =?utf-8?B?RVhkMGlMTzVOMHpoR3EySDZCWTJYU1hYZUtzbnBqTEJLTnh5WXcwek1PWUMy?=
 =?utf-8?B?WjgrcTYrME8xYU9PcFNWN1FwSHZPVzJ4NFhmOWRJdDQrK3BBYVYzdGY5eVVI?=
 =?utf-8?B?VGRwYy90eHBPRVprb21RY2UybHo1SWJ0N3VwM0t0M2psVTRhMWZZTWdDQkVH?=
 =?utf-8?B?dkJ6b3M1NWlzTEErb0ZTczlFWXplSHFhTWJoYk52cXcrcTRqUmFBTGxnLy96?=
 =?utf-8?B?YjFZWEFwNG51Y09sL0ZndWF3N3UwZ2RKYWVxdksyS0x4NDJYaHFDL3hmanFC?=
 =?utf-8?B?WlZ6L09KSVk1eVdqQ3pzQ252dDdYdW1TV0N0dG93SFZNb0xpZVlwem1kamRO?=
 =?utf-8?B?TXNpWU5sUUJJRjkxdXIxV3dlcER5N1YxQWRmK0N2ZU1qbzJXRHpaNU5BbEs3?=
 =?utf-8?B?WEZUeHJpdW5JV3hVbmozWWxTaWE0K0lZRmd6dnNsMUlETjI5NnVCclorOVBl?=
 =?utf-8?B?Qy9tM29DY3V4Yk11Y3ZIQWRBcDdaYnRpZ280ZklzdVh6Vk53WlRBSHkvNlh5?=
 =?utf-8?B?WisrRFVqZEQydXNjUkFrdUV0TUNXUmFUVUVMRlp6SDJoakhlR0JydjJyUW50?=
 =?utf-8?B?d2R4b2N0cUJML1FjUDlySXFQOWVicWkvQ2lLWm9FYzFmcnZuNWhjSkk4Q3dI?=
 =?utf-8?B?YUhLbEczZUFSSkZ1NVVUNFlRZkxWcFd1VGhPUVlhWnBhU2VUdkttYkhCNUda?=
 =?utf-8?B?Y1dTQWllSmJWZTVJU1QzUnNuTEw5MnZ0NzRFanl6UmYyckN3M1gyYzQvV1dx?=
 =?utf-8?B?c1YzWTdxWFcyN1hZT0JnN3IwWDVJSFNKYWVSY01BQXg3S3NuY3l6SzVaVnJ5?=
 =?utf-8?B?ZCtWRmd2MWo1ZDgrMDZTcVVUcUFsUTczQmNBamhKeDBFUnF0aFBkYk5BTTU2?=
 =?utf-8?B?eU1TWmc0K3BUVWNxeUZQMGo0bFZONWlIVFFNZ2ZlUUlPRU53eFpjZWEzMC9X?=
 =?utf-8?Q?RXNMDDmqPrnrX1bArIa/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb556ae-5916-4ca8-fb54-08dd0e67c94e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 22:15:08.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10245

On 2024/11/20 09:12, Christian Brauner wrote:
> On Tue, Nov 19, 2024 at 06:40:12PM +0000, Juntong Deng wrote:
>> I noticed that the path_d_path_kfunc_non_lsm test case failed in BPF CI,
>> I will fix it in the next version.
>>
>> But before that, I would like to get some feedback. :)
> 
> Please resend once -rc1 is out and rebased to upstream where - as you
> noticed - all fdget_rcu() variants are gone.

Thanks for your reply.

I will rebase in the next version.


