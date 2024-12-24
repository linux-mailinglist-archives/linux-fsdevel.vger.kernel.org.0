Return-Path: <linux-fsdevel+bounces-38084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A0B9FB80B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 01:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887B71883DEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 00:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18874C80;
	Tue, 24 Dec 2024 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YERb0vZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2051.outbound.protection.outlook.com [40.92.89.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175B367;
	Tue, 24 Dec 2024 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735001015; cv=fail; b=p+b3uOFCy1tYtbNMiglomytIqwQLLajopevD9M4hl5iaYkxWmArgkTImGzvw0EVEtpcewBDRS4OJZncnKaJZB++997j/YyyNHqo+ohfK+1Wl/azwr+SqXhfFPc0IUxhPCzvHjdQAmfXIzvn3ivH/ih/phHfrbTVfsPHAHrt94no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735001015; c=relaxed/simple;
	bh=ot7FjJgE3iyxsuswpWgz/gRPbh04LQ0jFdYsyNxO5aE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYpKijW027QYXjqNUfeaaijAuIY4N6W/WTOvwddZak136NL97CoaN+4Wn3KO2XBjIFKIHOJ3bmm7AVJN/V33i+FfrnAqgB7ic/N0PgnACV+/0dnraUsaY0HQ2T0EK3AQP213YGqq4BaoAInIjabf6SqvUFe5djSxL09Gq6BPoFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YERb0vZv; arc=fail smtp.client-ip=40.92.89.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDU5GpMsAe49B2phSOJpypndjYFkwp9KcHfrSYhsNGuC8iIqLqMPkuC+hVbzc7oHiwalkLNUt/xZkKHxfLNAgzGa5GIWZKc+3dH7ZyxfDVjQ6DbXI42wD4wBma/aQMNgBxEVqSzaKOSp23p7imGPaX2eDSJ7g6Ug0/rzd3supU+33FxhWZ3riV4H05iPH4dR46IsFzzy71AkS7f78WNGv2vawp06azZWMlA4P4Y4sUzJJNS4XGF3s2AVoDAQFewBCmu164werMYb8MamxPXfAwealOB7C9rNcOAqD28pyYvsG45QpLZYutT6+FEXqwYAp/2Gu8OGBu49j5kD47N/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh8ypjGk8HC8wxGM25SDl8Gcw20YV/WZVcQCr6PZAG8=;
 b=PAkaPgU/SLTykYE85XNp2MTmFliDfevMieldfqBfTnen/8sEJ2AV9SEQKr0TLIxHqDvVRzaIm7SzOHZZkBZv282LNHC8+MQ3FZ2VEz7wL7ZeDQtS5Kj3kn8woBndlLufiTj02KxCd6yCNWUjiJRr4QrprsrLc+VxsR96LfDyiz8R0Ipl73wcbuTjZhLI1rTOx0x+TSPU04E7bma9Ud4S6/UCjHVRTyiO0i6BDuyJBpSkR1EwpkiSYSIjKX0dCmHIjYPYzXqKKGfy693HKkBBLtgRnXxGuCI6BfoHoUPpJO54bXgl9dyV2bqtNpO2zbMn81FjI6EZgZmtJ6RXCKz5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh8ypjGk8HC8wxGM25SDl8Gcw20YV/WZVcQCr6PZAG8=;
 b=YERb0vZvN0WHIOvvToo/A40ln9NfKikugN28aAsUPlhTTEDWvDILKYXpofhl5PDfOsxk6L/wc5wXyAlj/4qmbZfYfnKkXdKUej1WSeLHnZx3GFz6UK3ItytEbP33z076Ju2oPxvxoit6+udTUf+DVp5SZ8ybxZtQzU+lsQBn7vPOfV5D4BeQDtoMfNrHQS5kanrBgpsUQc6+Bu6PKCD8AA3ALFdjOfzsgbBwZVGdKVGgr5QVNzPxGjtCU9hhSIqpAHIALvclGWYBU3nX8R7VNWAzy+SCho1is/MQ8DbA97LXSi8dvnnkOC4yzUKINSCDCrpNEQOxjfcMKMDquLDGdw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB7322.eurprd03.prod.outlook.com (2603:10a6:10:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Tue, 24 Dec
 2024 00:43:30 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 00:43:29 +0000
Message-ID:
 <AM6PR03MB508014BF8B4B311FA218FFBB99032@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 24 Dec 2024 00:43:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 2/5] selftests/bpf: Add tests for open-coded
 style process file iterator
To: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, snorcht@gmail.com, brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508014EBAC89D14D0C3ADA6899042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <2d389258-ad08-4d28-a347-667909b0e190@linux.dev>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <2d389258-ad08-4d28-a347-667909b0e190@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <d4ca7608-7968-4446-a2b2-b3429f8ccb4b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: d969a9ca-d3f1-4653-8538-08dd23b3fc6c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|15080799006|461199028|6090799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXA2TXNxNHpsN0xOWU5MczZmTnlwMWVnSVpxSXh6S214SkRuZEJMRVZ3cXV5?=
 =?utf-8?B?bVhQSGdpYlc1RVJDK0pNamlOZ1JheG54SkpvR0xDZkx3cmF0UmJCNWMzVW5P?=
 =?utf-8?B?amZiRUEvWGZJVTFQM1V3NldPZXZZTm9qV2JPcVdialFxdGtyRkZERGxVZm5D?=
 =?utf-8?B?U0FtMVZ3K29FdEVtQWJXTjFDTHp4enN3NktMQ3BndmhIN05KZXRMYU5Da0ho?=
 =?utf-8?B?eFBaRXR4ZFdxRzFyWUwxTlN6Ymp2NzAzSGE5VVFSN0JiL0tDb1FlOTF1RTBX?=
 =?utf-8?B?bmdTdU1xMGNseWVwQkc0NXVnbVZnekFrdFR6M0RKZ0FRTGRyQzdwK05XMGVD?=
 =?utf-8?B?S1lENml4S3Q4REFjeEJvbG9UTkxpOW04ek9WNzBDZHB4M0JSL1doUVFJOEhZ?=
 =?utf-8?B?VXMyQi9zU21yamVTcnk1c2tpUzVZWFpQaUhjNU1wTzV3SmFYMVRQQ3BGREpG?=
 =?utf-8?B?K0Y3Q2FaSHNIU3pkT3YwNmtxbzFWWXBVNkIzWm90bWtTVHdaRFZ3UXZBV1Nt?=
 =?utf-8?B?YXlOVUxiNXNPeHROWUxXUXFKUG1ibDVCZlR4Z0dHS1dybHkzSW9qcEJTblJY?=
 =?utf-8?B?eFMwVm9ZdUdsb3NzWlhVZTg3bnZZZlRXSmhxS29zQnp0RTBkWHBndUlwY1pO?=
 =?utf-8?B?cTk4dDdLd1JsWkluMXNjdjFUSzRlZVZrb0ZLUVVyck94QWpjL0t4Qi84MTJU?=
 =?utf-8?B?YnAzWkNlbVNUZElKRkVMSTlDcm9lQURqdjNPTUVOemFPWXN4MTk1SkFhdi9o?=
 =?utf-8?B?d09paUJsenYvZ3FCQXkzd0pETEcrOGlhNTF6bFc0bEJRMjVhR2VJb3BoUzN1?=
 =?utf-8?B?b1dZZ2J0dTRZdzE4eEJ6TGlnNUZXVFBnVERhMlBNc0x4ZmNkVFNnMG4yZThM?=
 =?utf-8?B?d2dIUTVlVURwUy92dXk5UzRvNUNybmloRUFLc2lSeG9PWW9mNGlkSmNFZ1pS?=
 =?utf-8?B?ZG1BRXlETis4TlVMNUlGOEdSQXdKZDhpZGpzeEgvQmt4UnRiYUdwc0x4UVI3?=
 =?utf-8?B?L0M4VG0wVnV6RlQ4ejArditlOVpITWpRMGtFNTFrOHZVVFYxRjNKelc1Uzll?=
 =?utf-8?B?ZWxOR2Z5ekc0b29HeExLYnFXc3hpOTdvWkJwSUlOTHFxSkRnTWhhVVVWek1D?=
 =?utf-8?B?ZmNmalNBeUEvUDNlNlNidlFycDh6KzY1UkE0TUZLUE56czkzK25KeXlaY1lm?=
 =?utf-8?B?R1l5Uk5KczB6R1I0alhCMGdOcU5ycldkRWlKTWxCdzB6bGFyUFJBMVRnTWlm?=
 =?utf-8?B?bWZnRFVhU3d5bnhXSGpyRHhvazdEeFpkc280a1pOSy9vVE9SVk8wclJLNm5S?=
 =?utf-8?B?ZDJNRVVvS2N1bDF0UEt0VHk1ZFhVdSt4WUtydUlPODVBZ21PSmhwdGxWN0hN?=
 =?utf-8?B?M0xsZmpuWm1KaGg4UVNubFMyak5iSmVwcytFU0ZQN2VGZklCcWxPL0pUT2xD?=
 =?utf-8?B?OEtIdC9OS1UzamNmTlBTVVRtS3UyV2pOSFhwRWZ3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WThWN2tZcSsvR3lublVJaXZYZXFKSUZoaEdaZFp6YTExeDBkTnNRNExMaW5N?=
 =?utf-8?B?ZmdxeEh6T3RSak1ORElpZW02WVVPWVRzS1Flby9PWS9GTnkxOGpPSkVBdDNw?=
 =?utf-8?B?a1BGVk45YVhSY3ZHZFJnTW1sa2gvWnBCcFZEYkQ1NnIwN3ptcVBRa25zazJm?=
 =?utf-8?B?VGFrbDBPakl4UDVuenFQQndkOHU5bTBZb3JCQzNJSFMwa2tQTjRheGwveGxI?=
 =?utf-8?B?QmR3dGV5U2dEQ1pUd2pvZi9hcXl1RjNzVFE5S1k4a3dmY3hRRlE5TGJFYTAx?=
 =?utf-8?B?NG5pYUVmSmpmUU1NWVZXcXJxWlYyS2hYeUQxYXd0aVVnL05iZDFtR0NhRkpD?=
 =?utf-8?B?ZWZrak5YZHJjWElNcjVVZUtyNGc2cHhsY0EzQW51cUFxWkVCNUxaaXFlS0VT?=
 =?utf-8?B?MmdzNXdUWGVYeW9Mc1VQWDlzMUJMMzZ1V1Njd2t0b0ZNc1dNYUJXcnI3cUQ3?=
 =?utf-8?B?U3RMZFZ0SFhsNmNqSDd0bFR5cnFrMS96MWVxRkVHVmpXd2Nza2ZZKzVsQTV3?=
 =?utf-8?B?RjNTNWVvZUV1dzMwNWx3bVFydE9RWnBiTGNXbFFQYzNkbm1wbXY5dElNeGNM?=
 =?utf-8?B?b3lXY3VuV3c2dzhVNHlVcXI5T0E1UlcybWM0THMxNHVwV0ZGNHVNWjB1bk50?=
 =?utf-8?B?WXZjZ2czdVQ0bEZBMFJ4cnNWdDA3RUdFeVZxRmYzQ3hPSTJKYXB1WHJHc1BO?=
 =?utf-8?B?RGxKS3JXZ0krUzMzQmtLU1JHZWtZVEtLQnlORURocEs2QldyWmhLbkk1QnF3?=
 =?utf-8?B?THlTZXpHR1BaU2NDU0UyU3A4VmNLRXAwaVdZbWROZ2lJM2lXY3ZuNnkvNEpM?=
 =?utf-8?B?eWFWR1Q4a2lUN3FBSnQrdnp6d1lhNHN0dnd2UDByZnBEYnduYVlaK09LNlo3?=
 =?utf-8?B?S21Ea3djMkg2Y0xQN2ZCMWJQbDQ3Nkk4QWtxUTVUdGlzekhFa3Y0eXEzV00z?=
 =?utf-8?B?QnNEaC9tZTcvMERTeXZ1dFU4RXdjd1o4bXlienNjeVlNekowK1FJd2RMWWpO?=
 =?utf-8?B?M2c2MHhzSmdMdFZvOC96YkZQREJ5Z3pwRk9YdExJMGZidWRuQ0JKQmhBRElR?=
 =?utf-8?B?UWE5eTdFZklGcHE3TEdxOVllOTRGaloyd3BEUEhGenhsbVV3YlFvMjU4Rjhu?=
 =?utf-8?B?R09JWEJkWjQ2cWE4aTB5MUwraHlMZlp2VUVzYXdDT0JuNHgwREZYc2prRUJr?=
 =?utf-8?B?d0VrdXBlREdoQ2dSbkF0bnN5Ykt4TlJyZFhTWU1maFBEZG1FcGU5UVVYeXRM?=
 =?utf-8?B?QzlzUnF1WkhjczFTRVJmYkNORlJxaWNVenpkRUdrR3BCY0hhS0VJTklXNWdo?=
 =?utf-8?B?UlBrbnY2dm5QOWZNT0ZBaUcxcGxnUG9zUlVKdGdmdzhyM2xNbjFmOEk3Y20v?=
 =?utf-8?B?bDFOem4xSHhaZndsOVorb1dINmx2ZUZUNkdWZ0NmU2dLcUR5alRDOTZnK1dx?=
 =?utf-8?B?RUtod3BqNkdJcWczZlcwaytpbmg5czg4Qyt2eVVlbi8rSEFBRXU5VjRxQVdr?=
 =?utf-8?B?dndrQmhKLzhaYUFCelkvUmNDSy9ncitja01YMk9ucXhFNFkrRGFPa0RYMHdE?=
 =?utf-8?B?dVpzdERRMXByWEhvd0hrMVBiL1FhcEh6SHNrYmVZMjBSNHhkRm1SQTEyYW9Y?=
 =?utf-8?B?b21sV293WDVQV204cFBEWTlNbU5CSHZWeE9xdHhXK1ZsT055RHZpd0xVSGdN?=
 =?utf-8?Q?aKgf6INuh923qhTYtaJQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d969a9ca-d3f1-4653-8538-08dd23b3fc6c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 00:43:29.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7322

On 2024/12/19 16:35, Yonghong Song wrote:
> 
> 
> 
> On 12/17/24 3:37 PM, Juntong Deng wrote:
>> This patch adds test cases for open-coded style process file iterator.
>>
>> Test cases related to process files are run in the newly created child
>> process. Close all opened files inherited from the parent process in
>> the child process to avoid the files opened by the parent process
>> affecting the test results.
>>
>> In addition, this patch adds failure test cases where bpf programs
>> cannot pass the verifier due to uninitialized or untrusted
>> arguments, etc.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   .../testing/selftests/bpf/bpf_experimental.h  |  7 ++
>>   .../testing/selftests/bpf/prog_tests/iters.c  | 79 ++++++++++++++++
>>   .../selftests/bpf/progs/iters_task_file.c     | 86 ++++++++++++++++++
>>   .../bpf/progs/iters_task_file_failure.c       | 91 +++++++++++++++++++
>>   4 files changed, 263 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/ 
>> iters_task_file_failure.c
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/ 
>> testing/selftests/bpf/bpf_experimental.h
>> index cd8ecd39c3f3..ce1520c56b55 100644
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -588,4 +588,11 @@ extern int bpf_iter_kmem_cache_new(struct 
>> bpf_iter_kmem_cache *it) __weak __ksym
>>   extern struct kmem_cache *bpf_iter_kmem_cache_next(struct 
>> bpf_iter_kmem_cache *it) __weak __ksym;
>>   extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache 
>> *it) __weak __ksym;
>> +struct bpf_iter_task_file;
>> +struct bpf_iter_task_file_item;
>> +extern int bpf_iter_task_file_new(struct bpf_iter_task_file *it, 
>> struct task_struct *task) __ksym;
>> +extern struct bpf_iter_task_file_item *
>> +bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksym;
>> +extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) 
>> __ksym;
> 
> All the above declarations should be in vmlinux.h already and I see your 
> below bpf prog already
> included vmlinux.h, there is no need to put them here.
> 
>> +
>>   #endif
>> diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/ 
>> testing/selftests/bpf/prog_tests/iters.c
>> index 3cea71f9c500..cfe5b56cc027 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/iters.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/iters.c
>> @@ -1,6 +1,8 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +#define _GNU_SOURCE
>> +#include <sys/socket.h>
>>   #include <sys/syscall.h>
>>   #include <sys/mman.h>
>>   #include <sys/wait.h>
>> @@ -16,11 +18,13 @@
>>   #include "iters_num.skel.h"
>>   #include "iters_testmod.skel.h"
>>   #include "iters_testmod_seq.skel.h"
>> +#include "iters_task_file.skel.h"
>>   #include "iters_task_vma.skel.h"
>>   #include "iters_task.skel.h"
>>   #include "iters_css_task.skel.h"
>>   #include "iters_css.skel.h"
>>   #include "iters_task_failure.skel.h"
>> +#include "iters_task_file_failure.skel.h"
>>   static void subtest_num_iters(void)
>>   {
>> @@ -291,6 +295,78 @@ static void subtest_css_iters(void)
>>       iters_css__destroy(skel);
>>   }
>> +static int task_file_test_process(void *args)
>> +{
>> +    int pipefd[2], sockfd, err = 0;
>> +
>> +    /* Create a clean file descriptor table for the test process */
>> +    close_range(0, ~0U, 0);
>> +
>> +    if (pipe(pipefd) < 0)
>> +        return 1;
>> +
>> +    sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>> +    if (sockfd < 0) {
>> +        err = 2;
>> +        goto cleanup_pipe;
>> +    }
>> +
>> +    usleep(1);
>> +
>> +    close(sockfd);
>> +cleanup_pipe:
>> +    close(pipefd[0]);
>> +    close(pipefd[1]);
>> +    return err;
>> +}
>> +
>> +static void subtest_task_file_iters(void)
>> +{
>> +    const int stack_size = 1024 * 1024;
>> +    struct iters_task_file *skel;
>> +    int child_pid, wstatus, err;
>> +    char *stack;
>> +
>> +    skel = iters_task_file__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +        return;
>> +
>> +    if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
>> +        goto cleanup_skel;
>> +
>> +    skel->bss->parent_pid = getpid();
>> +    skel->bss->count = 0;
>> +
>> +    err = iters_task_file__attach(skel);
>> +    if (!ASSERT_OK(err, "skel_attach"))
>> +        goto cleanup_skel;
>> +
>> +    stack = (char *)malloc(stack_size);
>> +    if (!ASSERT_OK_PTR(stack, "clone_stack"))
>> +        goto cleanup_attach;
>> +
>> +    /* Note that there is no CLONE_FILES */
>> +    child_pid = clone(task_file_test_process, stack + stack_size, 
>> CLONE_VM | SIGCHLD, NULL);
>> +    if (!ASSERT_GT(child_pid, -1, "child_pid"))
>> +        goto cleanup_stack;
>> +
>> +    if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
>> +        goto cleanup_stack;
>> +
>> +    if (!ASSERT_OK(WEXITSTATUS(wstatus), 
>> "run_task_file_iters_test_err"))
>> +        goto cleanup_stack;
>> +
>> +    ASSERT_EQ(skel->bss->count, 1, 
>> "run_task_file_iters_test_count_err");
>> +    ASSERT_OK(skel->bss->err, "run_task_file_iters_test_failure");
>> +
>> +cleanup_stack:
>> +    free(stack);
>> +cleanup_attach:
>> +    iters_task_file__detach(skel);
>> +cleanup_skel:
>> +    iters_task_file__destroy(skel);
>> +}
>> +
>>   void test_iters(void)
>>   {
>>       RUN_TESTS(iters_state_safety);
>> @@ -315,5 +391,8 @@ void test_iters(void)
>>           subtest_css_task_iters();
>>       if (test__start_subtest("css"))
>>           subtest_css_iters();
>> +    if (test__start_subtest("task_file"))
>> +        subtest_task_file_iters();
>>       RUN_TESTS(iters_task_failure);
>> +    RUN_TESTS(iters_task_file_failure);
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/iters_task_file.c b/ 
>> tools/testing/selftests/bpf/progs/iters_task_file.c
>> new file mode 100644
>> index 000000000000..47941530e51b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +#include "bpf_experimental.h"
>> +#include "task_kfunc_common.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int err, parent_pid, count;
>> +
>> +extern const void pipefifo_fops __ksym;
>> +extern const void socket_file_ops __ksym;
> 
> There is no need to have 'const' in the above two extern declarations.
> 

Thanks for all your feedback.

I will fix all the problems you pointed out in the next version.

>> +
>> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>> +int test_bpf_iter_task_file(void *ctx)
>> +{
>> +    struct bpf_iter_task_file task_file_it;
>> +    struct bpf_iter_task_file_item *item;
>> +    struct task_struct *task;
>> +
>> +    task = bpf_get_current_task_btf();
>> +    if (task->parent->pid != parent_pid)
>> +        return 0;
>> +
>> +    count++;
>> +
>> +    bpf_iter_task_file_new(&task_file_it, task);
>> +
>> +    item = bpf_iter_task_file_next(&task_file_it);
>> +    if (item == NULL) {
>> +        err = 1;
>> +        goto cleanup;
>> +    }
>> +
>> +    if (item->fd != 0) {
>> +        err = 2;
>> +        goto cleanup;
>> +    }
>> +
>> +    if (item->file->f_op != &pipefifo_fops) {
>> +        err = 3;
>> +        goto cleanup;
>> +    }
>> +
>> +    item = bpf_iter_task_file_next(&task_file_it);
>> +    if (item == NULL) {
>> +        err = 4;
>> +        goto cleanup;
>> +    }
>> +
>> +    if (item->fd != 1) {
>> +        err = 5;
>> +        goto cleanup;
>> +    }
>> +
>> +    if (item->file->f_op != &pipefifo_fops) {
>> +        err = 6;
>> +        goto cleanup;
>> +    }
>> +
>> +    item = bpf_iter_task_file_next(&task_file_it);
>> +    if (item == NULL) {
>> +        err = 7;
>> +        goto cleanup;
>> +    }
>> +
>> +    if (item->fd != 2) {
>> +        err = 8;
>> +        goto cleanup;
>> +    }
>> +
>> +    if (item->file->f_op != &socket_file_ops) {
>> +        err = 9;
>> +        goto cleanup;
>> +    }
>> +
>> +    item = bpf_iter_task_file_next(&task_file_it);
>> +    if (item != NULL)
>> +        err = 10;
>> +cleanup:
>> +    bpf_iter_task_file_destroy(&task_file_it);
>> +    return 0;
>> +}
> 
> [...]
> 


