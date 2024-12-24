Return-Path: <linux-fsdevel+bounces-38083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E5A9FB808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 01:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32C6165AF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 00:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022DC4C80;
	Tue, 24 Dec 2024 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d6w8TgXh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2029.outbound.protection.outlook.com [40.92.89.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F50367;
	Tue, 24 Dec 2024 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735000952; cv=fail; b=j4Iiti1m5ngMujNc6BYM6qfhR4zg3XtU5Vd/3K0WiN5y94JjcbjRaoB/HjMWhLGgOYf+kWc85zW+WJfPx+u2Z6MrnVe2ccvJfWWJlraLArxBU75Og2stGzBBoISXO/DUqMKPYKSbNZOzWQz0mWi9JGGdv3CDsZDSBFx8US19Rjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735000952; c=relaxed/simple;
	bh=cPf/5c6cpS3B0k68Wm+rbv7h0KLvV7egt6kPYGBh010=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gPD1Z5COfz+2+yvBPHtSAkhoX/38dD04k67WV4Up5CTJffGdNsRjLNHDSKScd8PaTCnxrIFci7dtTl51v6Q+Ziv44tN5b9eHyQECkRMonCvzQDGEcOGErj7dY58qhAVIJr1kLh7vgPVs0VbjfaNdl3KlAYlxvRBaSGlXFlWXqHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d6w8TgXh; arc=fail smtp.client-ip=40.92.89.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJtCi4IGwRNSmWJmylY0x/9y0JPNqKEMLlQ3zwvO2kPAWeFiSWQ65NJMbhTLmaX74zQmFTycFQ3tk+hfP9R4YNyJYCa2dZFXrNtTicPeG86KsZJdwdxM+Rj24HWYkTeeS60mhHqxhRMhs7jcydnGQ1cZ3xsDbdPYzvPOb7ivFjdft5uCUL4z+8xrLGDRmG+Xtf24KqzK1yst+2ThJ0S3EUeejX1PnkgjVxgDGhMH0qEOaampF0ff2JeG2S5Jfa7J3uv1q/myhmWhTJLa3lQv8GukPJwAbyYgWsFPK37sr05IVP+ISzJnhf0m5PqRwI4tFjA/ONaESX2SenLYysAHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vth8wAETOZ1SGSvcliIf6Kt/cR0a7mGL2Ob32GZfaxM=;
 b=Ls+KfyqAqqOQkSO5Hf1bWhUqLlnXZbEMChFm0JWEblcilQSdrlcpgdmLx2/0qSf8zdD/FBIEdViUMqfL2bSIimLKySORz89bQm/TVN+y11NL6vpFlAShILHoTN6w5j8kIpZ2cgR/6tgukCS9St/OBaZBsITEGCvziC/tTw5fKsho9n4XasWjGgflh87XaeI4OSKUDoq16Ptm4PAhVgM954sQ9AHdovhyIR2MoX0f4fjiIFTmzn262fwW3qbhA2/bcBiGWYa95zaJxIrz91Dh5VORM46hCZ73qxKgI3FT3PZUHLoTyQf+Q8X3ITRyjX9dASSzQXJgK8SXgX5qo50P6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vth8wAETOZ1SGSvcliIf6Kt/cR0a7mGL2Ob32GZfaxM=;
 b=d6w8TgXh081/rkCettF2dgiQ6JKKtxAI1OkwxRNF4TyseWy848eCfKAJ+pq0KJkR9il6+29CIW8tgu6OGRlfoqgSR2HONlJyqcjD+6u66JHPqxosuA+/2jKVIjfEOsUIBC1lCRWGPb6zT4FlhWy89upWEU/6qi/ccR/vkOP6u2AsBLUvrKZjnRfcaOIL9IxWMIGWmCP9tcup22rCns8LSsaOvYJNvJr/5RtDxcMaTbb1Ea9nomZmjapypxu4iKK4Km7R/mAU5FQDOXc2OKkFwQb15/Du10128F1dGpAgRCgglUbNSydheb9nbFkWaoQPjRTLU2AusoLJ1yfqAAET/A==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB7322.eurprd03.prod.outlook.com (2603:10a6:10:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Tue, 24 Dec
 2024 00:42:27 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 00:42:26 +0000
Message-ID:
 <AM6PR03MB5080C4BE4FDD7144E588671499032@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 24 Dec 2024 00:42:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
To: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, snorcht@gmail.com, brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <09256acb-9b23-4a25-a260-a4063d219899@linux.dev>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <09256acb-9b23-4a25-a260-a4063d219899@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::6) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <cfd023f1-1591-4574-9fda-2d1947a2e02d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: afc40c16-7687-4d26-6b68-08dd23b3d6b8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|15080799006|461199028|6090799003|1602099012|440099028|4302099013|3412199025|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFJYTTVhczQraUJ0bGtOUitNZzZYYWwrUmlhYUVLRlQ3dzRydlpCRXFIODly?=
 =?utf-8?B?L0VsaDFyUzB6c3pSbDZxV1lTdUNzZDV5ZkNyNlVoWkdtaDRxZDFSSXdyRFRS?=
 =?utf-8?B?V0hReGkrbENCY0VXeDUvazl0cFpBL3RNOVd4UzNBak1keFZoTitCbEUvWm5U?=
 =?utf-8?B?Y0lMUEdsOGtGejB2ZW1ldjJvallic0lCZEY5cTVtcWRoUC90eDdIOEhsQ295?=
 =?utf-8?B?SS9TKzNIUHBHeGZjbVRhS1ZqM09EUHFHQWFGUTJxd01TK2tSVEx3RnZMbC92?=
 =?utf-8?B?Wkl1aWNRcVgxbUVxTzk1anl1QjA2QzNpWjlaUE4veXowS3ZWQXh0cWZOZ0NF?=
 =?utf-8?B?WWZQNEppVmFJTEgvME9QbUc2U1QxRklEUXp5V3Uwd3dDOWRjRnEzWFA2R2tF?=
 =?utf-8?B?cW5WVkwxQnk4NDdCVzZPdlRhQm4zQ1lCVEUrVGovRnB6Q2M4TEkzZW9hNGg5?=
 =?utf-8?B?bjhrNHNvR1ptNUpEMnlJSVo0TExOOW9IWUJUekY1N3QxWU1iQ0YzdzV3MFBM?=
 =?utf-8?B?UlRpY1YwUm01SnVZRVAzcGxjVHFqMTh6MjVCZnhIWlVmbFBySkJ1VlNSMlRu?=
 =?utf-8?B?UUxLN1pMTTRENlEzMVlHUmNBVDVib3hlWkkvdkpVRWo0M2dPQ0dYdGM0Y2Iy?=
 =?utf-8?B?WGZHc1Y3K2JGWldBdU5ya0duczNjNFIrUWdkRFliaHFNZ0V0QjFlWnJWaXFM?=
 =?utf-8?B?dkRkTllhVzJlZS9WVm54cW9wcTZqN1pJZnd0bXduMHJ5TjA4S2V3Uytnd0Jt?=
 =?utf-8?B?OXBVVTU4aUpoTk9ZV0E5ZWJSTXhId21FSFpyb1BNYi9iTVJtZXY4SkhsL0RB?=
 =?utf-8?B?T2RvcVUzR000b0pDU3BZUno0TXJpT2hqWmhQdVlhcjFXaUdOUWRjUTQySW0z?=
 =?utf-8?B?VkFaaityNVgrd0psVmJZMVpVNVJnN3VvQ2RNazl6S3FZK25oaGxjS2FESlZN?=
 =?utf-8?B?eHY4ZDJ5dWgrdzFQUnJkZ2RQa0tuc0dSR1lhQVZIRk8vY3ZwR3ZNSUc3UFFB?=
 =?utf-8?B?YUVaSmx0VGo4ck1QazRGUkQ2NGc0S0lWZzNFamZWSjhHaU9mYkVQb2lackNn?=
 =?utf-8?B?MFMwMytvUGdaaUluOFNjY0ZXZXhwSk1MOTcyN2lhUjJoZWo2ZzBQcUxGaFdj?=
 =?utf-8?B?dllpNGlDWkFPak1NTm1PdXBucGRLQlJRQSs5UUFDdUpEQlNIbjh5OGJkY2Rk?=
 =?utf-8?B?b2hhekxlVENxVzRVYkFUd1FvSDhJblhaQVBFbllsSnJvTG5uOGltRG5rNkxu?=
 =?utf-8?B?bFlVMjFWL1UxYytoVmlrR0tjaUpmZUYwd29DcWpQVHZGUk5FdkM2Z1JvSWpE?=
 =?utf-8?B?eHFiYjRpc3F2b2hCU1pCVnBEckJMSzB0SWFtMzg4OU90Rmt5V0VFeEF3aVRu?=
 =?utf-8?B?bG1nYTZGU0lablJIb2hNeEJVQ3hhbTAxUTE5OUVQY25qYTh6dHZRRk5EWjll?=
 =?utf-8?B?YUhMTU80V0JybjMvaU41N2lyb0o5NDNpRVNxSDIrTE9kTjhtNi8wckZaeEVr?=
 =?utf-8?B?RWNHT1lkZFBkMC9hZGR4KzBBYzJrcDR0bHFkKy9NUmIwdlNuZElvOU5tNTJ6?=
 =?utf-8?B?ZjVFckNkZVZlb0Z3VFUwOHRGOFlhV2U2VXFwdFBWSWhEV3MrcEQrMlZhc2pR?=
 =?utf-8?B?c2M3WUQ0b1d3TWVleDlHekt4cE4xUFE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnQ5bGxpTmhTbm4zbEtsQzdWUUhjMUtGVlBCR2N5ZnZmdlZXL1Y3NnY4bm9Q?=
 =?utf-8?B?TjFhNFNOTnlYZ1FGZmJBQmxwMGNEMDJSN2UyOFZvZmN5WUQ5ZHlaMC9haDVS?=
 =?utf-8?B?M1JSQnpFbmtlVS9RanNzOXFQWHMzancrb1lJR2s2akpwM3pGNXdXN3RzM2hl?=
 =?utf-8?B?SnpXSnRZUWhaZHVONjVyUHd4VVZxUmhvNkYwNEtvUlJBSjY0ZFRTZlhtUzJr?=
 =?utf-8?B?eEJuQzJiQmVkNS8zM0NJd1NGTVFSNXI5RVdQLzhITHBFM29oTDlKbnZVNnk5?=
 =?utf-8?B?d04ydklFb1YrWlZnalh2V01pNjFiTXozV2Z5K3NRK3BOL3YwUlJrZktIRTBj?=
 =?utf-8?B?Z2lGNFV0dldmWWFDbTlFRCtIWVhsbDRMZU9rb2xlSHJ5MzRhTVI4YXc4N2Vo?=
 =?utf-8?B?c3JxOTgwdkh6dDVGYkhtckhDQmx0MW9mNWVpQ2JTeUdHSVdXTk1INDJyZlcy?=
 =?utf-8?B?NXVFNHd6WWVDSkRtRDJLODlOcTJHRHFJMElROVBncEZKOGhpM2xIVExHQnR5?=
 =?utf-8?B?azJVM3FoMzNQOVhjVTBjU3JBM3hYUldvbFhDdUdlczdxZnhYQjFPZDRYbVFI?=
 =?utf-8?B?eUhTcXF2Wnhqd1d0ZFNYVUREQWhnUUtjVlNGU0tpeWdoS25Wc3RxYjF2Sm1r?=
 =?utf-8?B?aTdYa0V1LzFqS0F1QUpKNW1sUTZZR2N2c0JJUnVKMVk2RXlRekhVaEJYclRo?=
 =?utf-8?B?c3BIYmZONk0zVnI0T1IxUmk5NC9mNmFTOFJtb1hLOTVPMENRRHpBN3FReGE4?=
 =?utf-8?B?YmJlaldnMGpQUDZQTktEenVKSEhGWXhXNXhKYVVXdWtybjlUNVdMWEw0L1dB?=
 =?utf-8?B?S1pRZE91cDhnUGQ1RDREOTUzNG5Ka1MxT0V3V0c4emlhaXdsbllxOWd1M2x6?=
 =?utf-8?B?RkNNb29RSUJQVEdXQ1g2WjY1WHlYSytsWXIwcDNrOStTNVl1Zk1pcVRWTmpj?=
 =?utf-8?B?WDR4dUFyU2NJaUJPeDRZWXJaZ1A0WjRHczdHaUovL2RWZkR1bWYySTRUNFA5?=
 =?utf-8?B?TmhZRTlORCt4cFpIL1l4a0tIOUZ4LzUvK2JvT1g3c0k1eFVMMzI3MDF2ZEQ5?=
 =?utf-8?B?NUFmRUNIUXV0MUpKWHNBYU42Vjc1Y3BiVm9pY2g4UlRIUjNvTlROeStHQlVI?=
 =?utf-8?B?UDltSVJzeHdSdFVhenZTbS9RQ1pnOTl0NVpPeHJSc1E3MlNUcEFwMTJzajVW?=
 =?utf-8?B?SHZuQmZRcWN0cFZXYXQ1Q282LzBMNTlwcWo5ZGpzbWthMndnMURZSTFmSXp6?=
 =?utf-8?B?OE9lQStieGFHbEZualR3YnN3MGgwR2syUGViRE9KcU9NVnA0ZjRXMCtIZGJx?=
 =?utf-8?B?OTlRdE9FVUpHU1pkQStMQUpmNGtONVI5RmkrbjN0WW5MaURHN0JueXczS01J?=
 =?utf-8?B?VmFqWU5KWUxqS2xHQlN4eG1mRllOeWZMRDVYYm96WjJ4ZmlFRi9NbTFJZWs3?=
 =?utf-8?B?cVBnWnYyVEdIeWRyS1VFaTdJUnBoYnZHek03bjc1b3BFei92KzBIeE9sMkFV?=
 =?utf-8?B?ZjNuSHBHOVJOTzI3TjZtVWV4UUlRbHB0V2lIL2ZMMlA3OVZEMnRaUjJMdkJy?=
 =?utf-8?B?SFNXa0dESmthc1lFTlVGVm11b3VicDM1N2lVall0ajltL0FHWmpjeFdQZ3A3?=
 =?utf-8?B?d0NMV1hxbUVyTk5MMkJCVHErcmRvekUrcjZnUmJJOHR4L3YxN29UZ3JUbmh6?=
 =?utf-8?Q?9R/JbGvtujohFux8I/Wo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc40c16-7687-4d26-6b68-08dd23b3d6b8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 00:42:26.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7322

On 2024/12/19 16:11, Yonghong Song wrote:
> 
> 
> 
> On 12/17/24 3:34 PM, Juntong Deng wrote:
>> This patch series adds open-coded style process file iterator
>> bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
>> selftests test cases.
>>
>> In addition, since fs kfuncs is generic and useful for scenarios
>> other than LSM, this patch makes fs kfuncs available for SYSCALL
>> program type.
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
>> [1]: https://lore.kernel.org/bpf/ 
>> AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/
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
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>> v5 -> v6:
>> * Remove local variable in bpf_fget_task.
>>
>> * Remove KF_RCU_PROTECTED from bpf_iter_task_file_new.
>>
>> * Remove bpf_fs_kfunc_set from being available for TRACING.
>>
>> * Use get_task_struct in bpf_iter_task_file_new.
>>
>> * Use put_task_struct in bpf_iter_task_file_destroy.
>>
>> v4 -> v5:
>> * Add file type checks in test cases for process file iterator
>>    and bpf_fget_task().
>>
>> * Use fentry to synchronize tests instead of waiting in a loop.
>>
>> * Remove path_d_path_kfunc_non_lsm test case.
>>
>> * Replace task_lookup_next_fdget_rcu() with fget_task_next().
>>
>> * Remove future merge conflict section in cover letter (resolved).
>>
>> v3 -> v4:
>> * Make all kfuncs generic, not CRIB specific.
>>
>> * Move bpf_fget_task to fs/bpf_fs_kfuncs.c.
>>
>> * Remove bpf_iter_task_file_get_fd and bpf_get_file_ops_type.
>>
>> * Use struct bpf_iter_task_file_item * as the return value of
>>    bpf_iter_task_file_next.
>>
>> * Change fd to unsigned int type and add next_fd.
>>
>> * Add KF_RCU_PROTECTED to bpf_iter_task_file_new.
>>
>> * Make fs kfuncs available to SYSCALL and TRACING program types.
>>
>> * Update all relevant test cases.
>>
>> * Remove the discussion section from cover letter.
>>
>> v2 -> v3:
>> * Move task_file open-coded iterator to kernel/bpf/helpers.c.
>>
>> * Fix duplicate error code 7 in test_bpf_iter_task_file().
>>
>> * Add comment for case when bpf_iter_task_file_get_fd() returns -1.
>>
>> * Add future plans in commit message of "Add struct file related
>>    CRIB kfuncs".
>>
>> * Add Discussion section to cover letter.
>>
>> v1 -> v2:
>> * Fix a type definition error in the fd parameter of
>>    bpf_fget_task() at crib_common.h.
>>
>> Juntong Deng (5):
>>    bpf: Introduce task_file open-coded iterator kfuncs
>>    selftests/bpf: Add tests for open-coded style process file iterator
>>    bpf: Add bpf_fget_task() kfunc
>>    bpf: Make fs kfuncs available for SYSCALL program type
>>    selftests/bpf: Add tests for bpf_fget_task() kfunc
>>
>>   fs/bpf_fs_kfuncs.c                            | 38 ++++----
>>   kernel/bpf/helpers.c                          |  3 +
>>   kernel/bpf/task_iter.c                        | 91 +++++++++++++++++++
>>   .../testing/selftests/bpf/bpf_experimental.h  | 15 +++
>>   .../selftests/bpf/prog_tests/fs_kfuncs.c      | 46 ++++++++++
>>   .../testing/selftests/bpf/prog_tests/iters.c  | 79 ++++++++++++++++
>>   .../selftests/bpf/progs/fs_kfuncs_failure.c   | 33 +++++++
>>   .../selftests/bpf/progs/iters_task_file.c     | 86 ++++++++++++++++++
>>   .../bpf/progs/iters_task_file_failure.c       | 91 +++++++++++++++++++
>>   .../selftests/bpf/progs/test_fget_task.c      | 63 +++++++++++++
>>   .../selftests/bpf/progs/verifier_vfs_reject.c | 10 --
>>   11 files changed, 529 insertions(+), 26 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/ 
>> fs_kfuncs_failure.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/ 
>> iters_task_file_failure.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c
> 
> There are quite some CI failures.
> 
>     https://github.com/kernel-patches/bpf/actions/runs/12403224240/ 
> job/34626610882?pr=8266
> 
> Please investigate.
> 
> 

Thanks for your reply.

I noticed it, I will fix it in the next version.

