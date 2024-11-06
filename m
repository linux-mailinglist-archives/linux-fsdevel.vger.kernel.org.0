Return-Path: <linux-fsdevel+bounces-33837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C49BF975
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41042B2236E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1440020D4F0;
	Wed,  6 Nov 2024 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="maOpXXhY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2023.outbound.protection.outlook.com [40.92.90.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E273645;
	Wed,  6 Nov 2024 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933372; cv=fail; b=Vnnk4ihkfzA/YimxgTfupcsi0YJqH2N6/mB43i4pUNQgPUxkpX/eUefulSfLZZvyfnRl9IKJKa5y9yc2mz8/1Jn4Xf2AVmIM3Cu1St4BGVjsJ/UhuRp1rjjqjhdz4Wlk9tKqr4eL5Me8Cw5Dzmd1d0ALwgoFoXSMMwKklb0htsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933372; c=relaxed/simple;
	bh=sZ+8e0wDNiibETJ4qItX8SFnp6snVpBEQW9/0p2DJTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nFzp9N2in24PyFzkdrUf6SdILb3CGBOyniMMWUoHmJr9ZfflEkVhRR+svSW3UgIFZhubuAuZHpcLT9N/HrmqyhHbGxLTlv+ld9PqqT89m7f7C9eVOyDFRgyQ3Cb0KCLY9ggueeseOYcohUhxoV4LBrexvIUMwT0nkA7KupMT4rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=maOpXXhY; arc=fail smtp.client-ip=40.92.90.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBtzJcOqAsmPgnoOAqSViqLdRh6drIfGhHkMaX1UdINZ8XOCCP8LLb/BsGEVB51Jzg549nnu+ktXfniOqZKxEt5FVfjcolwbb31oyUAUkvw8yb97c/1vXmT7IrjPpIQnRmVsFImZNygwYBafprkKeWnOrSbuy33YR5FfWVOgov8uddOfMLx8jmmFNUy/MWvBDwOCMlZsnjJ6IapB+jkve8UiU7ludfH0PauXxNeYjZMGUv/YIyOQAzSFf3iXI0OcIp9c5bs7Celri8bLRx1NTnVGOqkoxXsCdKGKaZ1R/OrVEka+UPkEI0BwxjBu+2n9TLnTcxbu+VxL15dcApwXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+1KAaOs+qVe13Le+jjIxLZBz2RWesm1B4V31LbFYKE=;
 b=ih1uEfeJxEOo0whzNpotDDvI3oMODRxYA3HtgfQiGsM9w2I8Gd+eHGSPrxoSGli2ibkhHJWIu4Njk59PKwAbaX+XLV1VXQHdipCy9W4uO3+G7/2pPnYWrTlhs1Ne4H7rj1MFKQs++XVdUpnzuBh3E3Lzc539mxoaSwTJjhEyzkVjIW1RU9mf4iKJ66ZWtdc3RR7SqHuI6rj80oyqU8EX2DNsxeqbx772HBrmzOKWHgO+PrK23O/Y4GTHlvB09++9OsmTd0NB/2804WPP9JYtOg/VXmvzzfrqInX1IRZ5zP0dGcZhiX9U8WauZmWs7I/Akm8/0UNl28TMQMsCFweOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+1KAaOs+qVe13Le+jjIxLZBz2RWesm1B4V31LbFYKE=;
 b=maOpXXhYZv6h1O9BzawL/A8/7YVWyvuE46GOAJwlrDteJ6CtiQ1hGUPKld7aHsorjQanJJGs9oaTvlrzNSNOuAgax6hrbmiS/Prku029pDaub58TldwEPWkaffj5PyhOydLEYG7+DtEXhAcymZWqxOeRKWgYCLOjzY9qYuS5DzkqXSyXHkg5fy4GnVFvLS1mXUy5WET1qZu5lX+XXBKAykCUwkz2LxXrHuhQgWmMCrsFqWhrFVqo4lZdQj9F9/hmWjl7PJqzKi1Hjav67/cYVTNTodzFoD36KF0rWDzzzpc8fhFBKOZ5/+C1PwwLP881nB8nqXjiyPEFcdGduDWIhg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB6808.eurprd03.prod.outlook.com (2603:10a6:20b:29c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 22:49:27 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 22:49:27 +0000
Message-ID:
 <AM6PR03MB58481666F9D89607DFDD4C4F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Wed, 6 Nov 2024 22:49:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/4] bpf/crib: Add open-coded style process
 file iterator and file related CRIB kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 brauner@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4BzZJuWcCLeUdmzhRVe9nyi9jAN8y=u2nK=mqzxXG6DTkDw@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAEf4BzZJuWcCLeUdmzhRVe9nyi9jAN8y=u2nK=mqzxXG6DTkDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0447.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::27) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <8eaf71c5-f84a-4fa7-ac4f-495e62c333ed@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 0734dbbb-01ea-4691-a07a-08dcfeb54451
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|6090799003|5072599009|15080799006|461199028|56899033|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGRtUkdvVUExRC9FK1RaNXdDYmpTY0x0OE5sNFBmWlZDZ0pKdUt6S3BQZkVy?=
 =?utf-8?B?eVJOWFFPRjUwUnp2dnNjQThvbHJHRnZqS2hNQjAxOHBxa09NZTNWMHZpQmpT?=
 =?utf-8?B?ajA0L21iY1k3QU5sMnBvSkNmcmRBeVBsNVpLT21GL2t6alV5S2dsWmltM2VG?=
 =?utf-8?B?ay9EM1creHpKRGgxQVRSWlFTaHZhUG1NM2xvQWtmendKd2VTcGw0MGJrK3BX?=
 =?utf-8?B?Q2VQR0s4a3oveW51czVMV0JBaFRDSjhEWnJLOW1GTHB2blQ2emVJdFZaSk9M?=
 =?utf-8?B?NVVteFV1czNoUjhRbHhrTVpHWXc3Ly9Rc011cEdHRkFaS0U5VWdZS3FLandp?=
 =?utf-8?B?dHlOWVNhTnlsM1Y4Q2d6dVF3RHlXSk53RDNQUE5vcHg1c24wTHVwUlZEVHBC?=
 =?utf-8?B?TEZYNUQ4dGNWaGl6OXF6aEZJYUtaMXE4Z0hSbUVXVEw5STlvZVMrQkhja1lB?=
 =?utf-8?B?d2ZPY1V1NVA1cThZSDR0NUZRbUNmVlRxaDhOZzM0RUY1cktEbkxUUEovdnpK?=
 =?utf-8?B?WmpTaWJ3S09kckljZjVQVmhBZEpINTVNQm41WDM1SUNybkJXelhNKzhnRm9T?=
 =?utf-8?B?ZXo1SnQwRERkTjRPUGhIQU5vREtYZjZVb1JKM3lIeDRJWCt4S3kyVGFlUG03?=
 =?utf-8?B?bjVGdVAveFJCWW1GSkRydk9wZkhDci9wTEFCdGp2ZE9iQjlYcXVtVk5qdHR5?=
 =?utf-8?B?RVZCUyt0R09ucFVmTkpySHpwL1dCYXN5eGZmNWJjaGpoN0FCeHFZQzVsdnpr?=
 =?utf-8?B?SmY1QUNBTFkyVzV4N3Ftb1cvWjRPdkFHa2F0MW1xVzJ5UVRQYnFsbXNQckpv?=
 =?utf-8?B?VElJeUtzWkFLdnVuSmRhWFpiOThXa3lZR25RUm5LQjlRT2RNdjNoRmJicW9H?=
 =?utf-8?B?VTM2UUZNZHNkQWhQS21oVTAwMFBvaWl4Q3RiWUxwdnRGam1KblR3Z1lqZThS?=
 =?utf-8?B?enlpQ2d5b2ZsOFJQUUExcnAzTnUzNXdBN2ZkSmkvWE5ocXo1ZkFZV1ZpdEJD?=
 =?utf-8?B?ZUZLYjRVN0tzdTEwZkoyR2kyQ2x4YWJnSGVFTk5uUkRMK2hsQWhmM1lURm9h?=
 =?utf-8?B?THlQbUlTYnV4OWNVcjdyUW12SlptQ3FQTTQ2TkNGMTZKaHVVdUtCTjdGSGlR?=
 =?utf-8?B?NWw0amlnRWdBa3BaM3BvQnR1eUttSDNiSStBY3ZCTUhnK2tOTUJ0dzZzMWp1?=
 =?utf-8?B?SnpTRmc3dzRwL0NZQzl6dVQ5Q0VnRFZ1WXEycCs1Y0FQcjdVUFJtK0YyeWQx?=
 =?utf-8?B?TVQrTzlDWWpoTXIrWEplWkwyVmZKbVI1VXNxMlFYdDQ2Z2Z2aXpnNUVHK3ds?=
 =?utf-8?B?L2hYekJySDBuWUdaY0ZmeGpRUjhjMlBrWkdGeXJuTGUzUE9hNGdCaGNycm1y?=
 =?utf-8?B?Tk5RYm5zcUJGL3pTU25kM0hBQ1hxMlZMM25UYk1nWE9pcTVZVWg3ZkZwTWZi?=
 =?utf-8?B?eGZjajNUbEF5M0luVEVDVFkwU1FPZFdhaHdFK3RTS1VqTmIrMWIzZE81NElm?=
 =?utf-8?B?NHBOcmN1NitlVlIyZ201ZlhneG5rYkhScFlwZCtKWHdJd054Q3NyUU1PS2l2?=
 =?utf-8?B?UHlaZXBHVWxKY1hZeCtvN2dkcUFIc2pabW1OL0o5eDByS0crOUQ2a3BySzBT?=
 =?utf-8?B?aHNtZmlNQXVwZFlqdWNSSCtYN1YweFE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFVNV1NTYzh2ZUdGSmpSNzZLd2gzUGZ6dHVhQ3Q1OG05NG5Pb2NPVit6NTlp?=
 =?utf-8?B?NTUvNjViQ3JKOGJYNXhkKzJRcnBpbDFDZmpWSFIzeFZyaHNLdHpKeUpZbCs2?=
 =?utf-8?B?VVlMd3dFeER5YVdIczBUcTF6cW9vdVNKajQ0MWhjM2FWL1B6Y0dhZDhrYktn?=
 =?utf-8?B?UWVlTSt6S2ZBNUgyMFNIN2dEWCt1OGNWM3R5blZ1cGZHR1ZrQW50eWJ4eTB2?=
 =?utf-8?B?c2JzNEEwUFlNcDlqbHhYalFGMmNrcEVnZ1dTUFd5QXR4VWtvdjlBNllyODRt?=
 =?utf-8?B?eUFnNCtFeDhHK0xIZjAzTnBLb09wTy8vcUx3S1hrVHNlek83U0dmcEFXd2Zv?=
 =?utf-8?B?L1VoVlRBcFp6ZURwYkZGWW0wL1pRbnBsZ2d3ckR2N3cxallEMnEvV0RlQVli?=
 =?utf-8?B?LzZhQUlvaUxpdlVFOHBEWFBFZXNPRkpPYStoL0wvN0p0RFh3cTdXRlN3ZlJp?=
 =?utf-8?B?ejNVU0s1M3BSZEJmOXdSaW1IQVBZY1Y5ME45TjNBc0VrMjhteXhkT3FDZUx3?=
 =?utf-8?B?ejNwSFQzWHFmc09LNm1UQzBWYWNPenp6cXJ3QWgxOTIrQ0hJQ1NCN3gyeFNj?=
 =?utf-8?B?SURHMUZZMlh2ak5CSElheFdFbG5GQWsyUDRjUmdVcVVUMW10RkE0eFk3WkxV?=
 =?utf-8?B?VUxLdFVoVFQ5b3FzWG42cjE5M1lBVjFSM0FGaEFSd1NETmRvcjN0NEF2aUlz?=
 =?utf-8?B?Smx5WEhXR0sxb285ZGJGK2dnTytrMEpFODZDcDRaWHhaL2VZUUh1R3E2RGgr?=
 =?utf-8?B?dXlQTnFrQlZJdlpYa2gwRWwvTEYxV2Q0c1FBQUhGOG9iNXJLQ3NnaEF2Njh0?=
 =?utf-8?B?QnRxd3lBN2FwaXllM281eTNZd2lQQXFNbjlGU0ljWjNzakk4dWZlZzZHNnRZ?=
 =?utf-8?B?K0xBeGZTZy9rV3hNNWZIa2RCaTJTL0d3ZFNZQ0tQMTF6Q1ROVngvSXJZMUNo?=
 =?utf-8?B?NTVMVnAzUWhGOGVtSHNiQlppaGJuSmtoYklvZVMzM0RlakRiWDBDNnN3Y0N1?=
 =?utf-8?B?ZjRDMW9JSnZ5QmZsdlNreVE0TTRsWE9BZ3UxWm1lUHA1N1RJbEo0OFMyTjhP?=
 =?utf-8?B?ck5wb21uYXZvbXNHMGhyRTZrREJuZ0hPOC82ckIxbEpvMlRDNVJXZlFTTERv?=
 =?utf-8?B?YXNqaXZ6Y0V1QUtMYndNOFJCVGc0MWNkNjNVeUQxaVZDQ0ttVklRb1VCWkIw?=
 =?utf-8?B?aGZ5a3UvcE4zMGYrVFlTcUJsNlF5TzJtR2ljU1RDWWViamxWRUVYOEVrSGRy?=
 =?utf-8?B?OCt5OVdvREdNMmlRVjFHSmVkVmFFVk9NZkZmRC9RZzBvTUVvUDR1bkgrdnhp?=
 =?utf-8?B?aHhibXdqK3grTzZhQ05Yc1BqUm9sZEpWZDhxOE9CQVcva2JVWGljOFlXK05P?=
 =?utf-8?B?c3BIcXA0eVdUd0J0cnIzbFUzZEtPN1N1NVZlWFV4ZUFFZ0ZiU2tWclJMOWVC?=
 =?utf-8?B?bmRRMkhUcks4enhLMGNWY2JUa2lUZFo2OHR4T0hrQkwvdDA4clIxcEFwKzM4?=
 =?utf-8?B?LzNUZDdpaXdRUlZDZDVSM0lCNjQwNlpDOEU4bXlHVUsvWW5aQUo5UG5TUGw5?=
 =?utf-8?B?eWRUcFNYeWFLWXhSdG5UTVlQMUc5SGtFOGxkT0VjYWxaZElwc2pFUUpLQ2Ez?=
 =?utf-8?B?dmQ3WGJIOFRQK0RFRTJZYWk4KzJCVzFzd1B5a2dtQ2FOQmdKZjJGMExmMmVa?=
 =?utf-8?Q?p+Dt0caD9+pyj1yWuOdJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0734dbbb-01ea-4691-a07a-08dcfeb54451
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 22:49:27.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6808

On 2024/11/6 22:15, Andrii Nakryiko wrote:
> On Wed, Nov 6, 2024 at 11:35 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> This patch series adds open-coded style process file iterator
>> bpf_iter_task_file and file related kfuncs bpf_fget_task(),
>> bpf_get_file_ops_type(), and corresponding selftests test cases.
>>
>> Known future merge conflict: In linux-next task_lookup_next_fdget_rcu()
>> has been removed and replaced with fget_task_next() [0], but that has
>> not happened yet in bpf-next, so I still
>> use task_lookup_next_fdget_rcu() in bpf_iter_task_file_next().
>>
>> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8fd3395ec9051a52828fcca2328cb50a69dea8ef
>>
>> Although iter/task_file already exists, for CRIB we still need the
>> open-coded iterator style process file iterator, and the same is true
>> for other bpf iterators such as iter/tcp, iter/udp, etc.
>>
>> The traditional bpf iterator is more like a bpf version of procfs, but
>> similar to procfs, it is not suitable for CRIB scenarios that need to
>> obtain large amounts of complex, multi-level in-kernel information.
>>
>> The following is from previous discussions [1].
>>
>> [1]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/
>>
>> This is because the context of bpf iterators is fixed and bpf iterators
>> cannot be nested. This means that a bpf iterator program can only
>> complete a specific small iterative dump task, and cannot dump
>> multi-level data.
>>
>> An example, when we need to dump all the sockets of a process, we need
>> to iterate over all the files (sockets) of the process, and iterate over
>> the all packets in the queue of each socket, and iterate over all data
>> in each packet.
>>
>> If we use bpf iterator, since the iterator can not be nested, we need to
>> use socket iterator program to get all the basic information of all
>> sockets (pass pid as filter), and then use packet iterator program to
>> get the basic information of all packets of a specific socket (pass pid,
>> fd as filter), and then use packet data iterator program to get all the
>> data of a specific packet (pass pid, fd, packet index as filter).
>>
>> This would be complicated and require a lot of (each iteration)
>> bpf program startup and exit (leading to poor performance).
>>
>> By comparison, open coded iterator is much more flexible, we can iterate
>> in any context, at any time, and iteration can be nested, so we can
>> achieve more flexible and more elegant dumping through open coded
>> iterators.
>>
>> With open coded iterators, all of the above can be done in a single
>> bpf program, and with nested iterators, everything becomes compact
>> and simple.
>>
>> Also, bpf iterators transmit data to user space through seq_file,
>> which involves a lot of open (bpf_iter_create), read, close syscalls,
>> context switching, memory copying, and cannot achieve the performance
>> of using ringbuf.
>>
>> Discussion
>> ----------
>>
>> 1. Do we need bpf_iter_task_file_get_fd()?
>>
>> Andrii suggested that next() should return a pointer to
>> a bpf_iter_task_file_item, which contains *file and fd.
>>
>> This is feasible, but it might compromise iterator encapsulation?
> 
> I don't think so, replied on v2 ([0]). I know you saw that, I'm just
> linking it for others.
> 
>    [0] https://lore.kernel.org/bpf/CAEf4Bzba2N7pxPQh8_BDrVgupZdeow_3S7xSjDmsdhL19eXb3A@mail.gmail.com/
> 
> 
>>
>> More detailed discussion can be found at [3] [4]
>>
>> [3]: https://lore.kernel.org/bpf/CAEf4Bzbt0kh53xYZL57Nc9AWcYUKga_NQ6uUrTeU4bj8qyTLng@mail.gmail.com/
>> [4]: https://lore.kernel.org/bpf/AM6PR03MB584814D93FE3680635DE61A199562@AM6PR03MB5848.eurprd03.prod.outlook.com/
>>
>> What should we do? Maybe more discussion is needed?
>>
>> 2. Where should we put CRIB related kfuncs?
>>
>> I totally agree that most of the CRIB related kfuncs are not
>> CRIB specific.
>>
>> The goal of CRIB is to collect all relevant information about a process,
>> which means we need to add kfuncs involving several different kernel
>> subsystems (though these kfuncs are not complex and many just help the
>> bpf program reach a certain data structure).
>>
>> But here is a question, where should these CRIB kfuncs be placed?
>> There doesn't seem to be a suitable file to put them in.
>>
>> My current idea is to create a crib folder and then create new files for
>> the relevant subsystems, e.g. crib/files.c, crib/socket.c, crib/mount.c
>> etc. Putting them in the same folder makes it easier to maintain
>> them centrally.
>>
>> If anyone else wants to use CRIB kfuncs, welcome to use them.
>>
> 
> CRIB is just one of possible applications of such kfuncs, so I'd steer
> away from over-specifying it as CRIB.
> 
> task_file open-coded iterator is generic, and should stay close to
> other task iterator code, as you do in this revision.
> 
> bpf_get_file_ops_type() is unnecessary, as we already discussed on v2,
> __ksym and comparison is the way to go here.
> 
> bpf_fget_task(), if VFS folks agree to add it, probably will have to
> stay close to other similar VFS helpers.
> 

Yes, I agree.

Maybe we should put it in fs/bpf_fs_kfuncs.c?

>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>> v2 -> v3:
>> 1. Move task_file open-coded iterator to kernel/bpf/helpers.c.
>>
>> 2. Fix duplicate error code 7 in test_bpf_iter_task_file().
>>
>> 3. Add comment for case when bpf_iter_task_file_get_fd() returns -1.
>>
>> 4. Add future plans in commit message of "Add struct file related
>> CRIB kfuncs".
>>
>> 5. Add Discussion section to cover letter.
>>
>> v1 -> v2:
>> Fix a type definition error in the fd parameter of
>> bpf_fget_task() at crib_common.h.
>>
>> Juntong Deng (4):
>>    bpf/crib: Introduce task_file open-coded iterator kfuncs
>>    selftests/bpf: Add tests for open-coded style process file iterator
>>    bpf/crib: Add struct file related CRIB kfuncs
>>    selftests/bpf: Add tests for struct file related CRIB kfuncs
>>
>>   kernel/bpf/Makefile                           |   1 +
>>   kernel/bpf/crib/Makefile                      |   3 +
>>   kernel/bpf/crib/crib.c                        |  28 ++++
>>   kernel/bpf/crib/files.c                       |  54 ++++++++
>>   kernel/bpf/helpers.c                          |   4 +
>>   kernel/bpf/task_iter.c                        |  96 +++++++++++++
>>   tools/testing/selftests/bpf/prog_tests/crib.c | 126 ++++++++++++++++++
>>   .../testing/selftests/bpf/progs/crib_common.h |  25 ++++
>>   .../selftests/bpf/progs/crib_files_failure.c  | 108 +++++++++++++++
>>   .../selftests/bpf/progs/crib_files_success.c  | 119 +++++++++++++++++
>>   10 files changed, 564 insertions(+)
>>   create mode 100644 kernel/bpf/crib/Makefile
>>   create mode 100644 kernel/bpf/crib/crib.c
>>   create mode 100644 kernel/bpf/crib/files.c
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/crib.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/crib_common.h
>>   create mode 100644 tools/testing/selftests/bpf/progs/crib_files_failure.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/crib_files_success.c
>>
>> --
>> 2.39.5
>>


