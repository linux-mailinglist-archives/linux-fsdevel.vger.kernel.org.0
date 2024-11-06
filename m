Return-Path: <linux-fsdevel+bounces-33835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429219BF951
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88A51F227BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF020C487;
	Wed,  6 Nov 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WfOsIq+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2073.outbound.protection.outlook.com [40.92.91.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E018FDD0;
	Wed,  6 Nov 2024 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932288; cv=fail; b=LnO4nyw4gDEYP6IuHnu3C8bGryG6wigpE7RlKVBgmrkeMGAQVO52yYVHBVm3dSpdhVL+XJZGtwBob8RRJXadEb5Njv1Ixxb7onfhELPjYHTPidpxezMOpw98r7rNEz6uCVtwllubwqE91uIjnu8JmXIP7t3gxcBvgqG/R1ARyGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932288; c=relaxed/simple;
	bh=BfMdaSiHN2P1Icdh89Ycdr9YvGpSQDxs2avMeLO6rKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AUCAPHNlKx8rmvHiAMko/300P7fEwZkfMU50nscBbWT0x9Ojal9gfkfvcc7FlRPczHp4PXMyqdi6vd0/JXlTB/FxjzCzyrSdHCV8vqBnqOYhPphz3ZilGSTdGkwBQVYqSiwhTaGJxnnIPcsVRvBhEQi1POJD0IIehEDLT3pPNGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WfOsIq+W; arc=fail smtp.client-ip=40.92.91.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3NZJ9L/txDJAakwio2s9i0gMCEpGbAcGvHceBg5k+RVH0rTgolOU/YY+KdUNS3qnCa+9MfTTQyu+BZM+RceIhP1l7sJpDgjI6/eR6qYJntnDh48ZP4GO32FwCohQHTh2jajQHflI9MFXF4UgMDUV6r4naRNqDr3tAoNeaume+tMV2dXzcuvynSqm/ma7TLT9H4/9lWbkOUj4/lEBl5J11tjHxvJ9tVMw5LWzk+q86fG61r70SYoIrg6pZ0wY9PX6fxnFDil1Cc2Xt9BEzJcXZq/DCGs9vWNwNYcuuQNuNsubB/9v9dxJKT0v1CxPKYGRDVCMsvXdLs+lBXJYSA+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1l4C1Co1+xLjmuhszfhqmaE9NKpaF6yGvHgAH/rxps=;
 b=ItNFd3O2lWB/wkhnVSorxBitrso/7fZQEa20PeQAJdZ6er/yc63DfYrOfkmjsmAV4Q57dRh5oUsUQtq8/8bcK+x0/gb182maw6GNbwZrvaxV6+74akx6+cIvvu8ADQtObH7dC4OSfBmKpKds0wT4/GlXGuLXeg4LnQcx+pWepYQqz3G7czCBfby2StHzXxlUfOig4fdNm8nNJAaMndGqUx71aP4fdVzBx1QjYuPPH8jFvgjsDmd0otk9Fqup1MSbANhuqxasBZnbbY4iwcHWSy08pvmdZ4Mc39Ws7FNTVStNb1ZnK57hJOsQcKwllSXwhDegeG4bOcMp0a9Lg4o4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1l4C1Co1+xLjmuhszfhqmaE9NKpaF6yGvHgAH/rxps=;
 b=WfOsIq+WVyecfOlKlJBCBBbw5ZHq2hP7GZ7PEeWnAMt5DtsyQH9PTqeRCw0quxuxolAQNs83oDtMMcgJUHQWDHigLRxFalQ8IzVrg88RX+1E3Kuk5LHITFFJCCQcshGwLp//jkynlMf9h1G6l2Eedj+tNTz8QOi4IfDqFQ2X0MW7TSHhFT9wb886L4vy6+yhBTzDHevx74SxafrDgg3BzaxRD37GfF4O3PTymF1MFJ5QjxqxFwjI5B4pZpsuBMr3Lq6we/VHZZzdeyteOmttvVbz3vVE1Ynn/28cWPnWCkEjF2RG2+XZelz74f1YfRZraqBwYSD9ZMSBuYZ6pwJs0A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PA4PR03MB7134.eurprd03.prod.outlook.com (2603:10a6:102:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 22:31:23 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 22:31:23 +0000
Message-ID:
 <AM6PR03MB58482B34E2470CA2126A490899532@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Wed, 6 Nov 2024 22:31:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/4] bpf/crib: Introduce task_file open-coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
 Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB5848C66D53C0204C4EE2655F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQKuyqY7J4iJ=FZVNoon2y_v866H9hvjAn-06c8nq577Ng@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQKuyqY7J4iJ=FZVNoon2y_v866H9hvjAn-06c8nq577Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0287.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::35) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <e890d2b0-b794-4377-9083-8a4024a3850b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PA4PR03MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: ea099d80-c401-4cbf-a031-08dcfeb2be14
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799006|6090799003|8060799006|19110799003|3412199025|4302099013|440099028|1602099012|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elhjRG9OR0dlQXRscFo4bXhZVTE0UW5iWjFYVVpPVzluMktEZVdSYm5HcGxu?=
 =?utf-8?B?VWRXZVNpNjdVN3E3Z2pNRjJKRUxMOG9pdlBWWjRaZklVbEREWWdyR3VxbXdu?=
 =?utf-8?B?ZHN6ZzhzVVpBSnh4dzNxc3B2VGNSRTF2bmxQSER1M3ZMUm9ZTmdCTUxLZ2Vq?=
 =?utf-8?B?Yi85LzI2MTZCS2RYNzNmOGQyZTVGZVo0L29PSXNUK2hDemRBSDVXZHdRMHNH?=
 =?utf-8?B?SlNYNUhONU5YRHZUYjFHYjgvenVxTlpzY3RZVXdGMUIvU3pyTGYzbWVkMUNV?=
 =?utf-8?B?VFMvbmFwaU4rUDE0eEJ6aVE5RGpOSEtEcWVic2syQXBKTDRycXR3aSs4dG1W?=
 =?utf-8?B?WFRyZXBzQU9BK0dJNGRCM2RTQkVja3VOMjh1L2ZhL3YvSERUajN6T1hOSHU4?=
 =?utf-8?B?UFhTM1NzS1lnSGJXQjlDRy93NE82N0NCc2VvN010b2t3eE9lQmdzOHdFSlhz?=
 =?utf-8?B?dnlYTmxES2dBWkVlbVBZUVZzekhxN3VSY2lIaWN3NU5IY0tCV0V6OFNqdU9k?=
 =?utf-8?B?QzFqTE5PRmZjZkE2cm1GMjY4UlM2RHM2dzJ3TDZFblhUWUdjaHpwM3IwOUdP?=
 =?utf-8?B?eXBhS3o3eHA5SDFZRkgvc21MMkhmVVhZRHBxbVd4SU5sQjM1UWx5RWs5K2VR?=
 =?utf-8?B?WUFjZGxnK1pqUUh5TFgzVTdUOFVOcnFycWh0NW1leHZxbjdOY3lGcno5VE0z?=
 =?utf-8?B?ZnZ2MlUxUWRXTzJHTlN3UWFISlJKb244UFMwSHhVQ0c4Vm12dXlFa0dCNmxY?=
 =?utf-8?B?Nmw3ZTM0UFV5c0Z6eW9NRmlwcjVTT1JIaTlTelBOK3BBY0xiLzROVWVKc09u?=
 =?utf-8?B?Sk9zRDJpMkgyWURlSkt6c0pVMHlOWlNUYVNtSUNTeGhlUVU5eHFZY3pWQ053?=
 =?utf-8?B?RDczNnpEaCtJK0ZEbHRkdkM1WTVBYTdrekMybUdrd3pOOWpLYlkxZXNsTm9U?=
 =?utf-8?B?bUhmcG5TK1dUcWdHWmR4bWd4ZGtrYUpyWW1SNkxtT1ZCM2xUZkptRVphbENr?=
 =?utf-8?B?a25tK3M4R3pVK3cwbnpMT1p1R2d6cFlhd0cwSjJJSjdWQ0tkZEFSNmRzMkVv?=
 =?utf-8?B?MENTbE4yL0ZVZ0ZTNUQzZm9jbDFhblZzcmdiSVVnUVhCekZ3SHlpN216TFFw?=
 =?utf-8?B?d093OFgwaWs2VjdPNUd4cSthTGpmMWFZQm5remU2VlZOZVpZbnB0TFVkSzNi?=
 =?utf-8?B?d1lrRTJZclk1M3ZwSjB2UmZvWk93MElHVUM2aUs4MjJJdCtTZlNWMi91aHpy?=
 =?utf-8?B?VXgza0FvbStZNWM5c2d6TmlZSFlaWWdET0hqVzgrbkgrV2NWeWxRZUxnaHdG?=
 =?utf-8?B?M2h5eFI0dUdZT0V1cXo0SjZpNHVaSXFUN0xxTXNJR0JaTERuS3hPMlY5ZE83?=
 =?utf-8?B?a3N5UVoyZmhac1o5c25wSTA5ZEtaSlBRRmQxMTg2VEhUajVnSThsWFBsMmhw?=
 =?utf-8?B?QlhmV3RPVFlTWjdhUkRZSGFaM1NEMFhmMVdZWkM3SE5zbWt6THU1eGphTENY?=
 =?utf-8?B?YVB0bjBzWHVEQ0lvUGx5WVBjc1I3L3VRQ1hlYXFsQXJaM09UWEhxdUVKZmVs?=
 =?utf-8?B?bDIwQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1QzTVJmQ2M5N29yWXlYdkhOS2ZYQXMrNjMzcmFpZkVZaEZnQnpsMGtGdmRp?=
 =?utf-8?B?Q1pHelJONFdhVmhvTis1V2ZpS2pmOHFHZUJnT3JpWlU1OVpRR0RpM09PZkt4?=
 =?utf-8?B?T1JjQXpyZWJpYkdacUI1OGxLRzdDcWpxOTNKc3V1MXR6cWlpUlZod0M5TzQ4?=
 =?utf-8?B?NlBpMHc4QzY0dTJ3UG1IT2Rzc1M5Y0ZOWXVpL0gzQWtzQzVLUE0wRTBsK1Fo?=
 =?utf-8?B?bHZoSVVLaFFlTFczNlI2OVVHbjJnRjltOC9ZMUpySndhTFFaR21VYi9KcTdu?=
 =?utf-8?B?aWUxdkpRUTVLNzFSaHh2bjgwYWJTVWJLamJHVlArNTZRT2tKeWt1RncxY1ZY?=
 =?utf-8?B?L0U4Qld1UFVkWG5rY1dQMG1sUEVpQXpVZ0Y5eVNvOFJKQnZEaGRsaTI2UVFT?=
 =?utf-8?B?eldMRWp6T29JNFZINEd4ZkJkc005d2Ftb3hVdTdDUDNackdJelFndzBmM2xD?=
 =?utf-8?B?dTdSb0xQNkxSYVJaaXc2cHZuQjJsNFl5RzdnaDdmVWZpVzZnNkR3Nit3RU5Q?=
 =?utf-8?B?Myt1NENsNW4vdkxKVGxWM3ZoSCtkS0FnN1l6WUdWUjFjNXFqYkZjT3c3SnFr?=
 =?utf-8?B?b0dBQnRHRnM4M1ZPbVdSVGx1bVE4ZFY0aWZiaGhOTWRFWmh3dFVhakVuS00y?=
 =?utf-8?B?QzVJNFBXN2pUbzdLcFVsUXlCbjFXczNVYW9SZEpiVmpENk5BSU94cEFqS2s1?=
 =?utf-8?B?dE5aSmdmSExrU3JXSmdkdTQ2cVdCUC9sTFpyaE0zVnAvZWJrN1owZmRjRHZ3?=
 =?utf-8?B?T3lYSXZvMnhKVjJBc21RTG9yNkxkbmNjcFgyTnNqWU5WN1Uzb01VTXl4TWZQ?=
 =?utf-8?B?VSswY0VINEJXd0d4VHA4bnlqQUpVK1dMbFh2OFEyaWNVYlZLbnVoZHRCNFRU?=
 =?utf-8?B?d2JXZXdvdnBWNGJIaTBUalJTbmI0WkhzZngwdU1BNHdvZXhKTGZ3a3RXSmFu?=
 =?utf-8?B?R2Y5ZzEyM0NhbFhtaG9DaFNpL2JwdGpRYWIwdGFJaktmcU1URkw5bHRLenJs?=
 =?utf-8?B?cDI3RFd3RFk1b0NrWnQ0VEhNc1pGK2FRL3ZNS08vWXFkS1dzN1AzN0xKRk5Y?=
 =?utf-8?B?MnMxRmlMQTZQZG1pR3FObTRJaDQzUUE5KzdIb1d1d3NSMENkc09Pbkk3T2RL?=
 =?utf-8?B?eU1tNDEzaEJGT2E1ai80aFV1ZGtVT0Y2TUkvN3V5NEczUkdsejdOQy9RK3F0?=
 =?utf-8?B?YU1weGc0T3I5MHN6cFlhdjBTanEwUUNmVFUzR3ltNG5CWm1mTUNSVks5M05Q?=
 =?utf-8?B?MC9ic0NrR3RmTmhaKzZQTnJad3VBWWYwM0NhUldPbHE2bGNnRUxkOHJQelhK?=
 =?utf-8?B?WlJ1b0QrS01vYkQ2UU94Qnl1U2tTYkhvWjRrU2lFZGkzSS9PclUwZXA1SkI3?=
 =?utf-8?B?dVpEQVl0cGpjVWVMV3JmYXVBajdDb2RtRzgwa003REdoRTJiOVB5bXNmRXZz?=
 =?utf-8?B?V2NZUFQ1SkxvNGJlOGxpWG9jNHhRdGo4M3Q3ekxMd2pCYkI4emx1b0JzVC9i?=
 =?utf-8?B?SkVGUEtvVGdoUGtnOVZHVWh1Z0tpTXdocWNxK2ViWFlvRXFlNlVNeHN6TVE3?=
 =?utf-8?B?b05hWlNxSURWZ1dTLy9YTTh3QkZkdmxDdkpCdXd4dkFLTGkrb0lTVk1OQVlJ?=
 =?utf-8?B?MGUxNmlTVTJ4MjU3SFlaeXp6Mk9wWUlITURsbzJpdVVDS3J0RlV3bFRDNlBZ?=
 =?utf-8?Q?t9dUVyJSJpuZawCBykTc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea099d80-c401-4cbf-a031-08dcfeb2be14
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 22:31:22.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7134

On 2024/11/6 21:31, Alexei Starovoitov wrote:
> On Wed, Nov 6, 2024 at 11:39 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> This patch adds the open-coded iterator style process file iterator
>> kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
>> files opened by the specified process.
> 
> This is ok.
> 
>> In addition, this patch adds bpf_iter_task_file_get_fd() getter to get
>> the file descriptor corresponding to the file in the current iteration.
> 
> Unnecessary. Use CORE to read iter internal fields.
> 
>> The reference to struct file acquired by the previous
>> bpf_iter_task_file_next() is released in the next
>> bpf_iter_task_file_next(), and the last reference is released in the
>> last bpf_iter_task_file_next() that returns NULL.
>>
>> In the bpf_iter_task_file_destroy(), if the iterator does not iterate to
>> the end, then the last struct file reference is released at this time.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   kernel/bpf/helpers.c   |  4 ++
>>   kernel/bpf/task_iter.c | 96 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 100 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 395221e53832..1f0f7ca1c47a 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3096,6 +3096,10 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
>>   BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
>> +BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index 5af9e130e500..32e15403a5a6 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -1031,6 +1031,102 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
>>   {
>>   }
>>
>> +struct bpf_iter_task_file {
>> +       __u64 __opaque[3];
>> +} __aligned(8);
>> +
>> +struct bpf_iter_task_file_kern {
>> +       struct task_struct *task;
>> +       struct file *file;
>> +       int fd;
>> +} __aligned(8);
>> +
>> +/**
>> + * bpf_iter_task_file_new() - Initialize a new task file iterator for a task,
>> + * used to iterate over all files opened by a specified task
>> + *
>> + * @it: the new bpf_iter_task_file to be created
>> + * @task: a pointer pointing to a task to be iterated over
>> + */
>> +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
>> +               struct task_struct *task)
>> +{
>> +       struct bpf_iter_task_file_kern *kit = (void *)it;
>> +
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(struct bpf_iter_task_file));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=
>> +                    __alignof__(struct bpf_iter_task_file));
>> +
>> +       kit->task = task;
> 
> This is broken, since task refcnt can drop while iter is running.
> 
> Before doing any of that I'd like to see a long term path for crib.
> All these small additions are ok if they're generic and useful elsewhere.
> I'm afraid there is no path forward for crib itself though.
> 
> pw-bot: cr

Thanks for your reply.

The long-term path of CRIB is consistent with the initial goal, adding
kfuncs to help the bpf program obtain process-related information.

I think most of the CRIB kfuncs are generic, such as process file
iterator, skb iterator, bpf_fget_task() that gets struct file based on
file descriptor, etc.

This is because obtaining process-related information is not a
requirement specific to checkpoint/restore scenarios, but is
required in other scenarios as well.

Here I would like to quote your vision on LPC 2022 [0] [1].

"Starovoitov concluded his presentation by sharing his vision for the
future of BPF: replacing kernel modules as the de-facto means of
extending the kernel."

"BPF programs are safe and portable kernel modules"

[0]: https://lwn.net/Articles/909095/
[1]: 
https://lpc.events/event/16/contributions/1346/attachments/1021/1966/bpf_LPC_2022.pdf

If the future of BPF is to become a better kernel module and BPF kfuncs
is the equivalent of a better EXPORT_SYMBOL_GPL.

Then all CRIB kfuncs are useful. CRIB essentially gives bpf programs the
ability to access process information.

Giving bpf the ability to access process information is part of making
bpf a generic and better "kernel module".

Therefore I believe that CRIB is consistent with the long-term vision of
BPF, or in other words CRIB is part of the long-term vision of BPF.

Many thanks.


