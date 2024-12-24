Return-Path: <linux-fsdevel+bounces-38095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F03BE9FBD1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 13:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0599E162015
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD641BDAA1;
	Tue, 24 Dec 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AdmIhfyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2104.outbound.protection.outlook.com [40.92.57.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654541B1D65;
	Tue, 24 Dec 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042261; cv=fail; b=CKrYzBValIg8ogRggh2QesxmB0PT48hMxGZi/LB+NQpVvtmwY1B82s1pw2FODWCtPsahdLOYrc5fDHr9GdGbCjkS9ul6RW+QBg0hDs6ug3M+o5ohA7iqf+i1HBNZY3Zv0wC+twywodVvK2ITU9n4iRy5yhZMUZmGsQUkKz1QAlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042261; c=relaxed/simple;
	bh=RqurSDEhJxTWRT5tLP4jbuJYWtNbhlUiD1iCSFUBchM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EcijOqQKkIRzzKVjgcegKg/lWed/yty9b+W0qC75k01iGakoBgV+Tahqa5tSXHE8JQR7ur0mq53VLLlmY5reyNZ9pz873k4sqCZJpB6uH+X8T+DeOM+kUhOzuLu1h/3S4DYP2pkm8BtwtoQCrWluGSZZGqkSH/yltSi1JSrlYBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AdmIhfyH; arc=fail smtp.client-ip=40.92.57.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5cyzArNwDKDuE7ARPpHkosZQF1SL0lxUJdlxQzByJIusocOeCi9KBWyceS5WEEp8QrSFSxSUSNpNOAUYRflNEVnC0k9UsOMil+2TTrarDCo243VJgUNNpiGN9N4zQez/eJ9FtokSjVQJzxjjSCYBMw2vP/QBeGZjS08VVXnVK/+m1orCafhvIR7xDekU7D4FTyvGfZY34pGDFI1bUGnUYj8YN/oHAvtvPtxqSQKSxgzYiXnumOeQ2glV/NzO3gUrS94do3kgaHr+oYaBijKWiMFiJFU+iL8fEaAuEsy5xvnD4JUTvPZFMw5HrsfVF7q/siBMmCFEYAquUm5hkaIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oW7fR37d+6KUX0Aci4Lnv3pYfx3Ms7Y2On+6xU1jDo=;
 b=s9rrgJ7dXE5MO7CkxAKPAK53oFfEcjtLgZiqNHeUDUJGayvvlrEhO+Hs0fwpBufrCHgUHlzX++UrhTDrJUYBcAa7167CapmqV3figSL690B2Eq8Vst8yFHq5cAzZeQLyd2qAWi/aJrg+oI++4CKsBPGVoS8R7Ble15c7L5gRrOjfj3z1KZikRIDaHNcGnyqveJoH3Te6z9W+kyOnujjduH4ykZ7QlPKArUzDBbzihHpOl6FzSXQwRjflnHL3cZ/ugFj7Rv7Ttr5TLpDLZFyjHpPu9POueKpvVOI0QlatPIokrO+MIXJDcdA8iMFk4EmQ86zYjEB5ler61yE7rOTJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oW7fR37d+6KUX0Aci4Lnv3pYfx3Ms7Y2On+6xU1jDo=;
 b=AdmIhfyHTzuhkGlGG2IVsy51A4ANPvvJxuOSvAmLeF7I3tfHi/hDjlXtnP5/s1SWeHRBj2R6IRq0/ePK42KrwFpEPC5sL4fkbv79+ujyxpf+notDURDTuktYc2KINcAgsAaqk2hPm0ngWmg6fnj/TyY09qoIrITBCi2FiTtZQ+ice6koGDqEKxN+BXgFrSQYy++NytUOZ6PZ/146c9AW/PZLCRxtNVnum9zCUU9+8M78MMc12tAAda585ZhWm+XqkAxe/JRxuHYNSN52P0PrG9Tq2lEelt1h+xfnr2FlEqSyXFdgfydnXZUKbipfvGSM7TXpVL9yuUExfsa5RiRmTw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBBPR03MB6794.eurprd03.prod.outlook.com (2603:10a6:10:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 12:10:56 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 12:10:56 +0000
Message-ID:
 <AM6PR03MB50806221B121CB56E0D4958E99032@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 24 Dec 2024 12:10:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/5] bpf: Make fs kfuncs available for SYSCALL
 program type
From: Juntong Deng <juntong.deng@outlook.com>
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
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLU=W7fuEQommfDYrxr9A2ESV7E3uUAm4VUbEugKEZbkQ@mail.gmail.com>
 <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <af06e16d-8554-444e-b256-0fe253206160@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBBPR03MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bbe39d-4475-4c30-456f-08dd241404d6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|5072599009|15080799006|6090799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWpTWmZGYUswQmFVUE01WElwbTA1a1JObXVzaUtiZEE1Z0NlcmN5elR3WlBL?=
 =?utf-8?B?djZEcndhS3dEYWNuTHhocEl3Q3B6a0k3bnVnaGlNTi9Ea1pjdlNraGZQOVQw?=
 =?utf-8?B?dDVvRzJ1YjZSdHNmZStwQWN4dGcwbnExNnVlMUFxQXB3OVBxbXVvRFR4VHVX?=
 =?utf-8?B?TVM0OXNZNWdkSERvamNXZU5US0c1NTBKZlRJaUdFYktTV0ZzMHZ0YWh2c3RU?=
 =?utf-8?B?TlFjcXRPeUprdHd5OEVUQkhIakNPMkNTeldMS2JWMVR3ZmJqMVJVa1lhbDFG?=
 =?utf-8?B?NUJjUkRJbEpQVG80R0pPelcwYzNkMkk1VkFMbE9qL3VERFFhS2RvWUU3QjVB?=
 =?utf-8?B?M3N6ZHVBS1RJNk9USGUvckpGTStMOGhpTlBiTW5rVDNQRG54bDlPWjk5aGly?=
 =?utf-8?B?WVMwczRBQmtIQUhTVkdGTmJBWW1xeW4vL2RoREUvaG80SnRPb3BvZVAvejVu?=
 =?utf-8?B?U1d4eTJWRHpGaTE4V0lENDZoaVRpZXR2RXFnb3lueW82cVVvRUUxNG9yZ2Rs?=
 =?utf-8?B?aEhBd0RjTWV4OUl3TC9yZGFEcnNmcW9HUnRKMHgwazlncndVL2ZmY0xoNEZn?=
 =?utf-8?B?OUVFMTVRK0lXcVN0Z3hmNUtuaVRmdmE2ZkdnMEhhMnFmemtTR2U3ajZDNlBG?=
 =?utf-8?B?Snlxa01GWVlPNGdqRUxpSUpCYTFMWUFZZ0Z3dXpWNkQ4VjhKWGw4RkFZTFov?=
 =?utf-8?B?TU00OUZ5UDI1NG9uaVhUanhJN09kbUpYM240aGhaVEFTVG5CV3h0UW1ScHRu?=
 =?utf-8?B?SGhyOWJKYmUvOTJSNEV6aGJRb3RYQ3VqdFNldDN4VGJWUGhMeC95Z3RxQytx?=
 =?utf-8?B?QndPSytPYXM2eFEycGY2QUhrbzhyNDRudkk2RHY0cTlSamlIQmlpSnQ5aVgw?=
 =?utf-8?B?VWRxZHZlYmpxVnlvckNFYVdHbzJKUmhFb0xjZkZ1UGd1Q1NNUjFoelgrQk9I?=
 =?utf-8?B?WXg3SGs5enc2MXVOZjNuYW13RWw1anljMnptcUk0UmtFM2hVbmpCeHhzL05z?=
 =?utf-8?B?a2lMRGJTSDliT1Jvbk5leWk2b0ZPTGdDMDFYNGxuOHF3a3VwZnZkcHNjaDJn?=
 =?utf-8?B?eXlCMUxlbmZsZWlqTWVPS0NOQitDRWNPdlVEM3JPa090ZVpRQUN2cEV0aENi?=
 =?utf-8?B?dGo4bWRyZjhjNCtLcUc1VHhKWlJGWVA0NU92aUJRMis2VHNoSHpVWDFOM3B1?=
 =?utf-8?B?a3RQS0dqa3JmQ1dkVWd5WTNSdEtiSWd5OFY1ZnViMno4a2RDZndCQkdNTXRk?=
 =?utf-8?B?dm9ZNHBiZVkxeENLTnNyd04wSjB1WWgrQTA4YTVOb1dzbHFaNUU0Y1hKY1ZN?=
 =?utf-8?B?MDJWSDBtdVFpRlpKYjNHdjVrTTJBZCsyWkNLUVdDUWswajJMNlJEeG9nZlND?=
 =?utf-8?B?THZKb0tmeEtzUmhJWDhQb1V4LzdZUEdsM055dFd2cVFaU1JsUW15UXU0MmlP?=
 =?utf-8?B?SGN6Wks0YkhqVFZMQ1Fub3FuU0FKSFA2Snp6Q3p3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkp4ZXVXRjZyT1ZlZklBdGpqKzMrbllzNTUzQjVWalVpQ0szY3ZHTFJmajNM?=
 =?utf-8?B?ZFFsTGtMQkgrQlF4bDZJNE9na0dVQUVCb01MelBNL0oxcXU2Q2hmTTdIM3FF?=
 =?utf-8?B?N0RUMFBEV045VVZDVmRrTTBoMkhFVjRTcXNVbFNqRVlhVnNzbFNoVlhwTG9z?=
 =?utf-8?B?ZjZFWDFDRnVkbGRLMXBYaTducDczTzZydS9Bb2Y1NGN3NUdnZHBwb2ZleXZw?=
 =?utf-8?B?bzVQL2hWSnR4L0F0NFBGOVdZbHdzdFhrMU9DaWJzZVlOV0pTRWVHVjBEZzFa?=
 =?utf-8?B?SmdsVVhCQ1pFQkNHMWpGQzE1Ym9BaWFseEo4STgvUGRIWTk0WFI3OHgwaWdI?=
 =?utf-8?B?dEtvZEFZWUxkOGNacGphVGp5SDgwb0p1Rk8xbWtBcDdqeU5Ud2FjNkV1Qyty?=
 =?utf-8?B?S0Jud1FPV2VhczJ5QXRDQmcwR3E4Z2g5eC9CN1BhY1A3UmZLcjA4T215Q1FY?=
 =?utf-8?B?VmlLSzdXZW1kb0NUamZOSjVIcStaT3lrZDhsajBISjNkUk1qdkdxenVLUnNZ?=
 =?utf-8?B?cjh0V1BrYzNmNkw5bTh1THYwU3FEQ1B2RzFYU09qdTgwaUErbGl5UTNvT0dm?=
 =?utf-8?B?dnRZOVRKUitvdDNKNlhGOHZ6Q0Fra0hHQTVLOFJ2ejcrSHpnSUpqQWpLOEVX?=
 =?utf-8?B?MzgzMTlvRVYrYkhRRlhYU09ZdkZwdWRrRmd1eHlmR2NEdTVjd2VhcUhBUjJ0?=
 =?utf-8?B?cTQ4WlRIT1FoS1p1M0N0T29yQkxsV0ljZHhOeHpYeWZTT1lXKzFIWlR3S3NW?=
 =?utf-8?B?M3RuaEEvQUVWZHo0cGZyVmZyZnBhOUFTUTN6YlNFQnRQZEpRZVJ2c3JzUlh2?=
 =?utf-8?B?R2oyaGRvQ3NUK3dJd2lJbGZKSU5OZGhSV0ZxbytVUzAzNFBYb2tIMS9pV2ZF?=
 =?utf-8?B?NkswVGk0T3lHbXJiMnJTVjNwZVduV0E0QzNxREx3Sm1Ua3VqUGtlY1lJSCtZ?=
 =?utf-8?B?S09SQkdVS25YeXR2UkxwZXFVODFQenZDc01pd0J2L3BlZlp0SGRKbVNMTnU2?=
 =?utf-8?B?WjZGQ2pzSlRyYy9DblVtM0xTRjQrY3dyU3AvblBIUGIxMFV4YVJmTXcxTWdY?=
 =?utf-8?B?VkVvTjRVa2NDV05VUlQxNGxzOElhVmxoN1dKYXMvQVMzNlFGeXBVTjc2UVN3?=
 =?utf-8?B?NE5GQ3BJbk1Qd1RoU1dpOGx2YWQweG81WHhhV1AzdEM1dXlBanN0ZXNXZEFJ?=
 =?utf-8?B?dGNqcjc0cVRFQzdlRGhYc3RZSUFrMXlUWGNxUzBQbno1SWRDVTUrWWtTeU55?=
 =?utf-8?B?RGFFYnFkWjBGV1J3emRkaUk5V21MN1F4QmF5OWk2TE4yN2ViSG9HY1RyaFB3?=
 =?utf-8?B?NGozU2RyOGJmRGlBRHpwd016UFprZG9CTXdycHArR1RBSjJuTzZXNWlWT3Y5?=
 =?utf-8?B?NXZ3cTM1MVl5dzFTRVF6aEhEN3JnUDhLOHlxcHRqNXZBN0NMRUZDUzVwYTND?=
 =?utf-8?B?N1Q1L2ZGNXlUOWNYNGpUSzU5dVBiOG1ENHlBRTI3cFJrZkJSOVdCeis5OGdV?=
 =?utf-8?B?bVI4N2xMK29FbWRXcURlaWd2NkpYUkJwVkNWMndQU1E1RGVnRkFlVXkwK3A3?=
 =?utf-8?B?YXR0U04wYzlZSGMxZ00wTVNMV3ZsbVR6VHVaeFdMNkdDbTlRSkk1MW5PSzJr?=
 =?utf-8?B?bEg4UEROdERUb0tQcmpTL1dna0JtcCtyeFhTd2NCcEQyTW5PT3lOc1Y2WGhT?=
 =?utf-8?Q?Od6UvqR6Rv2kj3IEMVcr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bbe39d-4475-4c30-456f-08dd241404d6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 12:10:56.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6794

On 2024/12/24 00:51, Juntong Deng wrote:
> On 2024/12/19 16:41, Alexei Starovoitov wrote:
>> On Tue, Dec 17, 2024 at 3:45 PM Juntong Deng 
>> <juntong.deng@outlook.com> wrote:
>>>
>>> -static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 
>>> kfunc_id)
>>> -{
>>> -       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
>>> -           prog->type == BPF_PROG_TYPE_LSM)
>>> -               return 0;
>>> -       return -EACCES;
>>> -}
>>> -
>>>   static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
>>>          .owner = THIS_MODULE,
>>>          .set = &bpf_fs_kfunc_set_ids,
>>> -       .filter = bpf_fs_kfuncs_filter,
>>>   };
>>>
>>>   static int __init bpf_fs_kfuncs_init(void)
>>>   {
>>> -       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, 
>>> &bpf_fs_kfunc_set);
>>> +       int ret;
>>> +
>>> +       ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, 
>>> &bpf_fs_kfunc_set);
>>> +       return ret ?: 
>>> register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_fs_kfunc_set);
>>>   }
>>>
>>>   late_initcall(bpf_fs_kfuncs_init);
>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c 
>>> b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
>>> index d6d3f4fcb24c..5aab75fd2fa5 100644
>>> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
>>> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
>>> @@ -148,14 +148,4 @@ int BPF_PROG(path_d_path_kfunc_invalid_buf_sz, 
>>> struct file *file)
>>>          return 0;
>>>   }
>>>
>>> -SEC("fentry/vfs_open")
>>> -__failure __msg("calling kernel function bpf_path_d_path is not 
>>> allowed")
>>
>> This is incorrect.
>> You have to keep bpf_fs_kfuncs_filter() and prog->type == 
>> BPF_PROG_TYPE_LSM
>> check because bpf_prog_type_to_kfunc_hook() aliases LSM and fentry
>> into BTF_KFUNC_HOOK_TRACING category. It's been an annoying quirk.
>> We're figuring out details for significant refactoring of
>> register_btf_kfunc_id_set() and the whole registration process.
>>
>> Maybe you would be interested in working on it?
>>
>> The main goal is to get rid of run-time mask check in SCX_CALL_OP() and
>> make it static by the verifier. To make that happen scx_kf_mask flags
>> would need to become KF_* flags while each struct-ops callback will
>> specify the expected mask.
>> Then at struct-ops prog attach time the verifier will see the expected 
>> mask
>> and can check that all kfuncs calls of this particular program
>> satisfy the mask. Then all of the runtime overhead of
>> current->scx.kf_mask and scx_kf_allowed() will go away.
> 
> Thanks for pointing this out.
> 
> Yes, I am interested in working on it.
> 
> I will try to solve this problem in a separate patch series.
> 
> 
> The following are my thoughts:
> 
> Should we really use KF_* to do this? I think KF_* is currently more
> like declaring that a kfunc has some kind of attribute, e.g.
> KF_TRUSTED_ARGS means that the kfunc only accepts trusted arguments,
> rather than being used to categorise kfuncs.
> 
> It is not sustainable to restrict the kfuncs that can be used based on
> program types, which are coarse-grained. This problem will get worse
> as kfuncs increase.
> 
> In my opinion, managing the kfuncs available to bpf programs should be
> implemented as capabilities. Capabilities are a mature permission model.
> We can treat a set of kfuncs as a capability (like the various current
> kfunc_sets, but the current kfunc_sets did not carefully divide
> permissions).
> 
> We should use separate BPF_CAP_XXX flags to manage these capabilities.
> For example, SCX may define BPF_CAP_SCX_DISPATCH.
> 
> For program types, we should divide them into two levels, types and
> subtypes. Types are used to register common capabilities and subtypes
> are used to register specific capabilities. The verifier can check if
> the used kfuncs are allowed based on the type and subtype of the bpf
> program.
> 
> I understand that we need to maintain backward compatibility to
> userspace, but capabilities are internal changes in the kernel.
> Perhaps we can make the current program types as subtypes and
> add 'types' that are only used internally, and more subtypes
> (program types) can be added in the future.

Sorry, this email was sent at midnight before I went to bed, and yes,
it looks a bit radical.

But in the long run, as ebpf is used in more and more scenarios
(better kernel module), and we have more and more kfuncs
(better EXPORT_SYMBOL_GPL).

Managing (restricting) kfuncs that can be used in different contexts
will become more and more complex.

Therefore it might be better for ebpf to transition to fine-grained
permission management (capabilities).

Maybe we can have more discussion.

Many thanks.

