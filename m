Return-Path: <linux-fsdevel+bounces-37354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD09F1526
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F0188CAD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B413F1EB9F9;
	Fri, 13 Dec 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MQgQlEJr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2057.outbound.protection.outlook.com [40.92.90.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B891E47B6;
	Fri, 13 Dec 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115449; cv=fail; b=kXe7ItOi6CQCPQm1ZmptKzTvkFtk1Bk0oARsSqdntgeDyv6NFBaJWIvmHtqG7C58P1pf6cG549UMvqe73oqoz57TKj1Di9k9krBKBdglLJMTJiatoD5SHbYZnPxtFU2OsgR4uoj5mkyUcm/Yh93/FD/EXZ4no2LTdaH0fI0S+ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115449; c=relaxed/simple;
	bh=qw+XsgUOLneVguGcqWKVFlR6K2rY2e6TETZnJ5qsw2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ocely0mBL/km1i/Sk7OwxGsafg3NXDr9XQQavBQaIZteqpbQWeug5dDu+NQrE5c0m06n+VrtoANtGxeThI9wov/yDE3qOPM2xkC1B8T/9Kodl8ePXMdKj5VS9HxvYVjID8nr8q1IwkIydq4LZkniT9IAj/xZpXN2dAq6MC+CF0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MQgQlEJr; arc=fail smtp.client-ip=40.92.90.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXCVndgQL2w6IMO37GtxKOrRF6/NO+CL5ZEeuPZwe9wBQmvzBdcin+T8UdelOxkhv5djJ87s3oKPo4PngHXqtJBAseBsc4ifyXDS2AfGz7i6eI9kiEPC/xxTKuUD9PRTmHn+qiIh8Tx0eesexd7G5Q/wtnu/R2i7tFTeG9mgjKijEqldzBdkOAQKrKMK5axeFXvOxyMMeWef1tblExs9pu6gZCwenDgrnJhAiVwRwGBtoiqEsQR8E7amxTPfJNfJBcHMT4495ofRdY/+XAZoejRJiBwYSCji39kL69d0xBp5lb/awsVhdLOOdCLSftAqxDJxEutXskw9dW1NJw767w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FXIPeoK4IbkicUlSc0SYwUPtCsbJg97KUPuPtsAP+4=;
 b=v0UH8Tgi5ysanFUUmr4L3J4tHCBTqtcptUR6DErBW6vR/KuTMshZqo7wpt9tgiRR1e4UsnaubGCShi4QjuBOmK/j1jnYqLgwblZ9YdBd4Rdr5+72uPwWQk84FW+ZBkvhMIdKNs5XA73D0ZeCYzZaaBiaX/EHj0Sr8sdBzqWLdU7ADUuB2YD3xOF1uiRj/RaaupR9FUU/4+9CxjTRbOdEi9u9FRbErX4NjsDIHZNOB88UDUlNKikq9Pc7b0exK6gnpoZsW2enXe0OeVda9QYKjxtiKQd9h87Daxf7mcpsPl45OvlELwm0YVouWRV0o/PrbhkpAIJbS8Kpy7rSgW9d5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FXIPeoK4IbkicUlSc0SYwUPtCsbJg97KUPuPtsAP+4=;
 b=MQgQlEJrCDjU1f0fNweiqf8DS/Dl0wlH+BEAhrR1tD7mINLamnm/Uk+2iL4nf8kkFvxGYT5nFr7wmHpHeXwMIc23RhBr7PPDAHTJyf5CruSmSEI/kTGQGCz4lctd54lxl25os9Evce36FtKMmFBlU7FTYVlOPcYpZIvD4k6Zq0xtviK24dnvSn9YkWIlYsavu58yrH33wVLpIzWOyptuZb126twcl7IGLDp+uEqDph0riCQEriND6ZH7OpoelntOjRrD+Rs5QaAop3S2EkPMJFDVKNbJ67rDy1HwvBZcalvraxhnPDwG0nP0lDd9fD1Ur9Osazeys/lE2T4T7Z46qQ==
Received: from DB7PR03MB5081.eurprd03.prod.outlook.com (2603:10a6:10:7f::32)
 by VI1PR03MB6207.eurprd03.prod.outlook.com (2603:10a6:800:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 18:44:03 +0000
Received: from DB7PR03MB5081.eurprd03.prod.outlook.com
 ([fe80::7b9e:44ca:540a:be55]) by DB7PR03MB5081.eurprd03.prod.outlook.com
 ([fe80::7b9e:44ca:540a:be55%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 18:44:03 +0000
Message-ID:
 <DB7PR03MB5081B6DC951ED1776640939199382@DB7PR03MB5081.eurprd03.prod.outlook.com>
Date: Fri, 13 Dec 2024 18:44:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL
 and TRACING program types
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 snorcht@gmail.com, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-eckig-april-9ffc098f193b@brauner>
 <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
 <AM6PR03MB508072B5D29C8BD433AD186E993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAPhsuW7zZuHf6dgDpYnibONoKt0p=zb0wCta1R1MtLv=Q=4FfA@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAPhsuW7zZuHf6dgDpYnibONoKt0p=zb0wCta1R1MtLv=Q=4FfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::18) To DB7PR03MB5081.eurprd03.prod.outlook.com
 (2603:10a6:10:7f::32)
X-Microsoft-Original-Message-ID:
 <eb179ae6-63b7-4df3-868f-f4ebce2e1eca@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB5081:EE_|VI1PR03MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6df31c-9618-43de-8311-08dd1ba61cde
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|6090799003|19110799003|5072599009|461199028|8060799006|10035399004|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MCtRUXhacmJ1Mkg5K0FhUjh1TzVNWEVmaTM5SGx5SU11MDVsa2JiVVYzb1Zz?=
 =?utf-8?B?bzZIWG1SYjZtbTlrbDdZWk1tV0ZxWWdrOENTdC9XZGNiMWpuZVBmNjF6K05I?=
 =?utf-8?B?dDd6NGdNOVVqUEJ5Wk53bnBZTDk3dFlrbTFuWkNGL29FcjRvQms5SGx6emRD?=
 =?utf-8?B?RktRc3c2aEMxN2FQTTBuMWF5NCsra0p1MGptbGZEankzWWE3YzBvUElBbGFs?=
 =?utf-8?B?UW1rRzR4TER4aW1yOThMUklFY0Y2aE1pYXdsMVk5QXNkbndNYUZrRXY4M2xN?=
 =?utf-8?B?NThZWmVyMkFkYTJZVHVyOGZ2QWlEZGl4OXVSY2pwamp5QlBKRDZoWWJQOHJE?=
 =?utf-8?B?eE1ycWp3ak94Ym4xS3ZXamQ5b1llTFZUQkpXa1ZmbkZoZ3doaXVyektnUDBZ?=
 =?utf-8?B?QlB3QWhMeFFlN2lHaTJMV2wwTGdnVkR0ZlcyRE1RaXUrV0xGaUFrMlE1MWFY?=
 =?utf-8?B?Q0ZFc25aMmFKY0hHWmVRZDNiSzJycW4vYk05eXNDeTkyUUNTdFVOYVc1U3gr?=
 =?utf-8?B?ZDE4UUNEN0FUVzkwYWh6em9YYldXOWt5Q3oxdVZNWGcrZHJqdlJ3eTM3MzBY?=
 =?utf-8?B?VGJJZmc4aE0yY0pnN0plNXk1YXBxMTVRblJsWENqU3pvbkIyaWVMcE5Pa3JF?=
 =?utf-8?B?LzVTM3ZxdFhINmZuam1vVFlTdlJmM0c5cE0zaExJQnYzcGdNT3NKcGM1SUE4?=
 =?utf-8?B?QS95MzNyWnRFS295d0d0a1BCdVJzYkI1Z29KTVpqK2lWYW5iWm9DcmROK1Zt?=
 =?utf-8?B?YnJFVjJ3b2cxNmo1b2lwbDRNZ291MTBsVWtKejE0UVVobEN1VjhXNDRRVTQ4?=
 =?utf-8?B?Z08yTTA1OXFsdzhoRDE2SElaTU50STkrOGR1NUFTdDdtakE0c1VIcStmcGhs?=
 =?utf-8?B?MkZtanJiOU9aSVdSYzBSVjVoZWdwcm1UcGFPQ0tuMWI4dHNXV09nbEViNFNG?=
 =?utf-8?B?Y3BsMDd1bFpub3NYbDMvRnVZbHFnTVhvMGFqNDhLdVplNDFHek53QmF5Zi9x?=
 =?utf-8?B?NHhKYkVNb2owdHdWWVlDOFo3L09jQVF2RytVQUxDWVc0ak9aZDJHMWEzMGpq?=
 =?utf-8?B?QVVaekZGTzJBSk5OekU4eC92WGlqL0Z5YzBPa3hOR05Pb1d4NU0xalkwSkU5?=
 =?utf-8?B?NFNjOW13cFd6ZjhueVVhYkRyaWRPUDltZ0dxNWo2SzQxd3BYWlBTVG1vSTI1?=
 =?utf-8?B?TzEwY0dGVFpjdkM2b2oxWDAwREJTamxnWFNkc09BemNxUjh4SS9RQXNaQWZQ?=
 =?utf-8?B?aTFIeldobUtKa2gzVjlMVVpkbGdHT2ttbWhabCsvZ1BGdVBvQ3d3dW1zTERz?=
 =?utf-8?B?SDVGYm5jd3FHQXM2RzYvZEdrazBaVzhkTjQ1ZDNBWUY1QXpUcjVZVkxJVXdv?=
 =?utf-8?B?ZTZMZzVpOG5vSFVYeXlEWlhTbkY0T09qbDQycnR1VVI5c0V0Ykc1a3BSeWFK?=
 =?utf-8?B?MVVrbDF3aG1BVkcrTWZVckg4dE5hMmNUSHVEOHRpRzUza3pRMjE1MEl2VTVU?=
 =?utf-8?B?bkVtWlV4Slo1b3lXN0xnandJMitzNzAxNVI1Wmk1bG5SOG1OTVZNK1NudXMr?=
 =?utf-8?B?ZVN1Y0p5S1ZtYjFxa0lzQjZvaHl2MkRxWnkxMVBPWTMvWHBmV3RqYTFyVnhn?=
 =?utf-8?B?SUYyNjFtSUZUb2sybjM2SnlrTjBiNWc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVVFZmt6dVdxNjZRUkV4Q1g3azFqM3JkbmFMTmsvZ1liVW8wd3ZHdWx5TDFM?=
 =?utf-8?B?R0pmVzcvbEpVZDJNcWxNVyszTmJkNjM4eE9rRWZZcW00SzA4YS9ubEt1cnNO?=
 =?utf-8?B?d3NDUmJwallNWGZ1OHExSnBHOS9YVFlPR2J2Tjg4NFpvbHQ4TmlQK29KRHN6?=
 =?utf-8?B?Q3NrS1NLSG9BSDdKZk1SRFM5c2xhcDVqVVhyaTJwYmlOekVyQXJzV3Y5Sm0r?=
 =?utf-8?B?cjA3VzUxWlVzanlub3N3U3JGanVaN3FTK3pwOHZJdmNLQ2cyZXB4bFFaWHhL?=
 =?utf-8?B?Qmhaa2YxK0VaUk1IdFlhTnFoNDZ6bnBaMGtJb3pHSE84T3Z4b2Q1NkxZZG5n?=
 =?utf-8?B?a09tU2tGMnlORzNVekNveGYrc2psM0s1YjZGc1M5R2hmQ2pKMHBUc1JSc3NY?=
 =?utf-8?B?WjNHODFzQUQ5S2F6dnJaNXpmbXptT3IwT2NtY0NWMUpZYkpOd0w1R29QM0x0?=
 =?utf-8?B?V290bE9BNjFia1F6L05sb1VsQ296OXFkNmNMVE92bEQxMXg5SnZEOE5TWlZM?=
 =?utf-8?B?SHlyRlRKVTVFUG5rSUhsdi9uZmlubE1vN0NPSFM2cEU2RjdJczVDTHlTVXdh?=
 =?utf-8?B?enkxMXJzemdReVQ1T0dXQzFmWm1tRUxieDdhVmd4MGJaOEdPbWQwUGNDMUVX?=
 =?utf-8?B?aG40WFBQRlpRanAwc0F0VzhEOXBTRnJDVVp3WGRVNlVaWXFzUk5sMFBMRmxB?=
 =?utf-8?B?VjE3K1FQS2FsZ3FzTG80eG0vWWl6TWhiZ2duSndveXdnRzFXY3BTc29NNEtW?=
 =?utf-8?B?VmRqK0dIcW9oVnVOdEtEcnFVY0FuT0U1ZjYxaEdvQ2V1R2pPaTc0eDlmeWh1?=
 =?utf-8?B?MTFEWkFuZmJ3WElWNm1yVk8vZWc1VUZ5RDZQNFowNjRCT2VnVFp2TCtzcTRK?=
 =?utf-8?B?c1g3R2lsMUhvalFlMFM1WkxROHBnVWFUdm40SERIenFvUWE4WWdocCtGUTdW?=
 =?utf-8?B?MjFobmxPYUxzYjhVamFhTjgzdW1GSHNQREo3Qlpzck9sWVg4NmthVUU5V0lT?=
 =?utf-8?B?bTZ0aGxFbW1vMzk3ZzVadUM0ZU5DVUsydXBrYkpvemdWRWh5SkJ2WTMxOXlj?=
 =?utf-8?B?ejl0a2RiUGtYblFQdkMxZk4zMzUyMEFkejVjQ21NNmY3VzJBYUd1QlpEc3Nw?=
 =?utf-8?B?b2x4RmJoK2lUeSsxV3UveGpscXpYK0txUFBtWm10UDlhQkdLTWcrWlpmMUZV?=
 =?utf-8?B?OENrVjNPTGJJaEk3WW5lMGQrQ0hMODRVUExpczVZbWIvQWFUMzVKNU9wQjBr?=
 =?utf-8?B?VkgzZ3hnb0VmMmdvNUFmV3dNb0haYlNOdEdrNTQ1Vzk1TXJYZUdmNUZGWjVk?=
 =?utf-8?B?RVVOMFd0VnlKQ1BuN3QxVVB1YnFYWXppcFhmdlU2eU5Wa2tUd0lmK0lpNCtv?=
 =?utf-8?B?bmFhUWRUdkcyWlNoY2lGSVh6TjRERUxvR0NRWFRRVkU0dk5zL05BVUpJTmpY?=
 =?utf-8?B?SHl5eGNZa3IraW5HZjFXbU9Vak5tU2tYa0kxcHlDVjhXTVIyK3VxK3haSm0x?=
 =?utf-8?B?YndXU3E0elgwQysxYktod1lFb3B2eHc2TnB4UUIrc3JmZXVpU2hjL3F0aysv?=
 =?utf-8?B?b0JFMVp6R1BabGJFL3ZxWjFSdGNnTlV4enFwUkVqNURQajhCVEFuQUpSQTBL?=
 =?utf-8?B?aDJxaTVvWFp1Y0Fya05oVVpsM2xSdSs4SzZEWEZlak83Ti9sTUxjTGpSTytX?=
 =?utf-8?Q?VyzkaaIm4rsBE0GEbVDH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6df31c-9618-43de-8311-08dd1ba61cde
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB5081.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 18:44:03.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6207

On 2024/12/11 22:06, Song Liu wrote:
> On Wed, Dec 11, 2024 at 1:29 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> On 2024/12/10 18:58, Alexei Starovoitov wrote:
>>> On Tue, Dec 10, 2024 at 6:43 AM Christian Brauner <brauner@kernel.org> wrote:
>>>>
>>>> On Tue, Dec 10, 2024 at 02:03:53PM +0000, Juntong Deng wrote:
>>>>> Currently fs kfuncs are only available for LSM program type, but fs
>>>>> kfuncs are generic and useful for scenarios other than LSM.
>>>>>
>>>>> This patch makes fs kfuncs available for SYSCALL and TRACING
>>>>> program types.
>>>>
>>>> I would like a detailed explanation from the maintainers what it means
>>>> to make this available to SYSCALL program types, please.
>>>
>>> Sigh.
>>> This is obviously not safe from tracing progs.
>>>
>>>   From BPF_PROG_TYPE_SYSCALL these kfuncs should be safe to use,
>>> since those progs are not attached to anything.
>>> Such progs can only be executed via sys_bpf syscall prog_run command.
>>> They're sleepable, preemptable, faultable, in task ctx.
>>>
>>> But I'm not sure what's the value of enabling these kfuncs for
>>> BPF_PROG_TYPE_SYSCALL.
>>
>> Thanks for your reply.
>>
>> Song said here that we need some of these kfuncs to be available for
>> tracing functions [0].
> 
> I meant we can put the new kfuncs, such as bpf_get_file_ops_type, in
> bpf_fs_kfuncs.c, and make it available to tracing programs. But we
> cannot blindly make all of these kfuncs available to tracing programs.
> Instead, we need to review each kfunc and check whether it is safe
> for tracing programs.
> 
> Thanks,
> Song
> 

Thanks for joining the discussion.

Yes, we should do that.

Sorry for the misunderstanding.

>> If Song saw this email, could you please join the discussion?
>>
>> [0]:
>> https://lore.kernel.org/bpf/CAPhsuW6ud21v2xz8iSXf=CiDL+R_zpQ+p8isSTMTw=EiJQtRSw@mail.gmail.com/


