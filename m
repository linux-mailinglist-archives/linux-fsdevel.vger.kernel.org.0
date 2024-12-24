Return-Path: <linux-fsdevel+bounces-38085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70FA9FB812
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 01:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB23D1884B99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 00:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300289454;
	Tue, 24 Dec 2024 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bsiySsZL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2091.outbound.protection.outlook.com [40.92.91.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71128137E;
	Tue, 24 Dec 2024 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735001480; cv=fail; b=UPv+joPIyOxFPKCH1xqlZ5rTx1J0qJJppP2uaYaGtlTLQHTeqVUCM0h91vkkYL61Uw34up70GH/uQlyQHjFcy6RRhizA4PdQapb3KQcZuq9Exj2brnVB10TQz78Ho5BY9LIFzBiVlBH11YZcwBiXijesj5ZKJu1NwoSB5+UgeJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735001480; c=relaxed/simple;
	bh=YMJA3l6fGCa0L6pQzNpZURGmiMKIyPa+bwASUnGkVgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j8fXGm7BFDcY5WeDG2t8/R+pF0VhKuCMS/3ImeUJilnEU5jaLZfi4R49RIY2NqSE1N0WV3iuYADKl6LGjYtJ5Ri7YCaIIDQMPbJcK0EEWGoXG3gZ7mZ2gMTqyxjZwgMZIDOiKLCK95ZWoWHDKn0NSrz/leYecTEW+yNLDVz/+Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bsiySsZL; arc=fail smtp.client-ip=40.92.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq/Xz4J5/YVNpD8y/46EkYo0Oez0x+LYPQyLC9rPz/pmjze5fV0YwwGcXiaq7BnQMPrPHqEJYlLB+1/ypIFZvU0k3RHlpEl0OP8BVGhpM/s5kdKyihuT5nyTgw7hXAkrH3635DcqX0mzg+SihFP4YnTy8S+xjeyy+JUcQMcg1owqQLyjVZ5onUhStscocXoVcKVL9Gg8000d9YWcc/PBXiOXD5tDlWRMdXlNvNSbWLcIX7AF0dyB6yCg/QUvs9sbkVB0PwNXRONf9glnJ0fhwksqpuzrQHEdEeDrITnradUK9UD2BT4BxeJBpZZZNQIIUP9r/Yg7z0Fdu+Nua9R20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhD4y8uCptAZNwtMo4N3XTGYB/rhEdrulYz3F7pKa14=;
 b=VOsEe+ULA71HS3/gmsfivQ1KDwLg0vtljDwoRkZbmFRfjly5MdSkcUfxdKczsRHWZWpOfemrVJb172/LrtgrbjAa5K7MsMAtJca5djhiaBCHaDS0qBAi0BBb/TBkiMih525uQy0t67DJraQ2HxMYiJ/JKLNfjuaDPdJ7/q6Ct6Vd1MgcaYtz/IAeXYr5rZdstgBikUUtDpHM0LkCYGm6pdL85brJeg3fDfzEFdCrVt7Wm48zCVkY5T/oU57DPDhHw55MHYbpL5EZRNb5MdsuS7kvrI9t5Q2ow9qk+jYgsbpUHtglpZtApSb1dyJEcoiZHTcu5qcvP7yJtlSuWNL66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhD4y8uCptAZNwtMo4N3XTGYB/rhEdrulYz3F7pKa14=;
 b=bsiySsZLnX78ZigrJeeKEHXjdObANeyhwXR0QLCA/oB9maWcEBZ0rpBKcliXqfwvWQsikm17k4ym8GkPs6N/fvgdh5Wgg46mM50LnWDZOY3sjx1plS6njhoT3e3rkJke8nj0b1YNnx+8D8ShZWALky8A7TMQba1f4PGGEn+3n95pm90dAd9gQ8003jHzvPBUwwdAehR7ow/mWvEUF1NVY/UJfMmtkXQshvB0ms69zNKaIY5moWzbj+DTtIVWePXKnKvWCGlGdAkOXjowWeYbUDSa0LdITf//yMnG31FTAehNjkD2zgK8fN2ks4UlpVBNjE+6J0QLRuhG+bYuSxqwWw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU0PR03MB9730.eurprd03.prod.outlook.com (2603:10a6:10:44e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Tue, 24 Dec
 2024 00:51:14 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 00:51:13 +0000
Message-ID:
 <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 24 Dec 2024 00:51:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/5] bpf: Make fs kfuncs available for SYSCALL
 program type
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
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQLU=W7fuEQommfDYrxr9A2ESV7E3uUAm4VUbEugKEZbkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0035.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::11) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <d742722d-7e06-4bd3-8675-ecaea7a51209@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU0PR03MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 15596d52-19e2-4d04-6f71-08dd23b51064
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|6090799003|15080799006|461199028|19110799003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVhvVjFXTk5jZmFiNGJRMUxhRDZzSFpsVi9VRG94ZW1HZEdjTkFmaDV6OFZ6?=
 =?utf-8?B?dC9YVVdIbmRaM1E0ZTJjelVOUllJbXdsZjdIQ0htQUlkZisyc2pLRVRaNVhm?=
 =?utf-8?B?OGFDQzZBNGtLTE84V2xHUHd0Y256eGxJRHFiMkQ4WS9XbVgybStkOXpta3E3?=
 =?utf-8?B?YXUvMEI5YUU1SkNxTUxoSC9acVZoUXNhSnl3RWljVEZacHZZMU1aUDJHYXJZ?=
 =?utf-8?B?L0RhNnE0QWFMV2NjVmNROGN3MkdvaGlweC93MVVlRGgxaXNjOUxXU3FxeVIw?=
 =?utf-8?B?b1pwaHBjYU5YTWVrNC93Mzg2UTdNajJkMTMwU2Z1MUVIUUhPMGJvUmQ4bElw?=
 =?utf-8?B?NFVxNVJ4SnFVYmlXOSsrcjBTVGs5ZzRzeVA2TzkzbE1VUEFIMTRlbFFaWi8w?=
 =?utf-8?B?WXBFeDdNam1VeHQ3MUNBUWY5cUZ5VlNWSUlBOWFQZ1RhQTJKeUZvSEhyREo5?=
 =?utf-8?B?TFRNUjQyZWN0V3dtRER0SmZ6UVREbFhyQ3FkSi9PS0ZZdS9pTTBYdjlCa001?=
 =?utf-8?B?TE05aVZ6NUR2Qk42VG5EbVdCWi9ORXkwS3ZTTWpWdFg3UXZoS3dBSkVQaU5Q?=
 =?utf-8?B?TnJMODEyRElWaFpod05uZWl3TWxVK29TSFpIT3hYVE1zZ0xIVFRlRWFOTisw?=
 =?utf-8?B?bXJLbTVqS3JUZEpiL0tENnVLbURWWWp1K2tpWWNOd0daYTRBVGEwWXBrTlVX?=
 =?utf-8?B?NFJvNWZqYkhHcXBkU3ViVHRCYko2cCtCUE1rNGRoVE04Uy9zQXJhSDloWWt4?=
 =?utf-8?B?MzM3ZkNiekRnVWVQQTl2REFvbk8xQWNsVlg2RVBsV1FVd1NsVVhNbURzaU03?=
 =?utf-8?B?VTBrcmRneHhKYmtaamEyNEVwZFBGbkUwaE1MMFVkNG9YY25uRlRLbSt6cGRL?=
 =?utf-8?B?UjQwdUpCOGtXZytWakVCQ1JKcHFETUFCYlV0cEFJbnRiQTF0MmNac1MrSkZI?=
 =?utf-8?B?WnBGYThxY0NIMm1KVlNWaUR6bnhJM3AzSHE0dldETHVxNThna0RUZzBwM2tY?=
 =?utf-8?B?RHdvSUU5d0grUTUxaDJEdzhlNXAzYWVUUDY3MHhDWnU1UG9DK252aklHODJz?=
 =?utf-8?B?UXpXRGtINVQ2R0ZZODY1dU1wTjl3ZWZxbkFLTyt6MWM5UzJNcS9xdXkvY01j?=
 =?utf-8?B?REQyZ2NhL2dVczFTb29YUWJidFMrdU41REE1UC9zeGc4RDJaMHRpcFRjMzN3?=
 =?utf-8?B?OFNUR2srMGEzQnRYMDhLampJMmZNZHpMNkhBbzJNS3RFZWNxYmdBd3hGbDd0?=
 =?utf-8?B?QW5ETEtqVlc5RHBUWDVXbGJ3L1JvTWNvSXZRdVNOdEN5RUczS0N6ZkdtWEFl?=
 =?utf-8?B?dkMxN1l0WjhROFc0SS9uQ2ZYUWVXOTlkeVlMdmkwY3ZEdlh5Rzh0U05FVkZH?=
 =?utf-8?Q?OcPtzVGTwOnJz8N1UwAzXDCDOTGnNROA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWZmTFBGUVhqQ2Z3UVZaa25MbnlnU1R0ZmIxU2J1Q0dvcndUUGx3c3RFVHl0?=
 =?utf-8?B?dU5jYks0bTVBaENuS2x3djlrR1g2WUtNaWlzQTUzQnJGcEI0Y1NDNkJYT2Z6?=
 =?utf-8?B?bXU4V2h0aldVVEZVOW5teDQ2MGRNemk5S21FeFhudUxJUDMwNjZyUXRWK25w?=
 =?utf-8?B?WE9iWkpSanJvZ21WV1M4ZkxtRWx5Vzhya0tHUzJ5SnlTK1dUY3Zpak9lYzNm?=
 =?utf-8?B?aUsyNnVvS3QzQWZPNmhCVlltaXRmb2MzUE1DNlpKeHdUbU56Vk8vaWtXNWxK?=
 =?utf-8?B?MWdYNTZJTUpMWkVNM0w0NDZBSFNGWitkeEJTL1FST0ZDdHBrclYyVzUvMEx2?=
 =?utf-8?B?cHdLVFh0QXY3UnVNakU4SThyZ1k5aUtvYWg1R0RnNVJJUjRoZ3JFaXB0SEpP?=
 =?utf-8?B?Z2tSaUVBRmJPS2F6dzZ1Z09PZXQxSVMrRnVmZzhyb2M4Q1o5Rm1ZVHROMEpR?=
 =?utf-8?B?MFVPUjE5cmNqMzAvajZKSFFRQU1uRWlBK0JoZWhnVjVLalBPbnFwUTVuNWRO?=
 =?utf-8?B?QWJXaWcrbUVUVktyME54bTJXQjdZQUFEWm1lelNsZXNYbkx0aXprMENERytz?=
 =?utf-8?B?YmZqeDJBWWxQT1JQZ2t5Rzhnc0IxQ1I0d24rQVNFUzFZR3J5ekNUL1REalFJ?=
 =?utf-8?B?T3hOUjBrTlN1dnAway9ZYW5pbkl5cmptejlzajlIRDdZZFRPV1o3UlJ5czlq?=
 =?utf-8?B?NVlueUNOdjNqeWhnSWltR092aTA3dS80WGplQ0lSclNBRkVJeXVvNngycGFj?=
 =?utf-8?B?cCsxa1JZSmZvb2VOMGNoeU5xREJ1YkNPa3prbXBwZjA5M2x3blV2SEcxby96?=
 =?utf-8?B?RkRTUjdlNzlaUDQ4ZDRlSG92WGlxT2dNQnVhaFhvNVkwcHNVOGlkWDhGNXo4?=
 =?utf-8?B?bzZZMytqY3VGZHlmd3g3eVJ5TVpFYnM1T25zelQ3S0lOUEpGRFgwN1g2S2xr?=
 =?utf-8?B?QTg0N3doVXpIZVdBekFjZm8zWk4wV3AwcDJRTTF4UFVpQlgvZGMwcktWNXdt?=
 =?utf-8?B?S0U2TTliV2FxWDBzQnlzSURZZjFNQ0VBenBTQ1dxM2JBZmdEVS80Uk9DNkRV?=
 =?utf-8?B?RE5LYkVxYmtKYU5NUXorWm1QbTlBQUthWHJZcFdTdDgzejNnMWxqQlUzY2xt?=
 =?utf-8?B?VjlCaUdiajlEUmNHb1pYSHo3U0JwRHg1bFJIdldoNEdRTGh5WTRPOXROci9E?=
 =?utf-8?B?Yno4VVJiclZ0M2QwdldIMGdzeFR0cTQ3RFRwVFd3WEVEMmZHVFNRSlNXVy9w?=
 =?utf-8?B?eEtvcG8rM3hHWnpIOUZaS1lhMmpKSzhWMGxwU3lTTTZwbEpNTmFpRW4rVGox?=
 =?utf-8?B?VCtUeGtMNUJERWRuL3c1ZjI1N240NGswTHFBNThVbVo4RGN4TGcyb2VQV1di?=
 =?utf-8?B?dmh6ci9RWG02Z3dPTGFMM3FPZWlVQnFRNlpNOFQxU0lMWkJwSVJERWJwSWxq?=
 =?utf-8?B?ZGxxZktBc3NhbjV3QnM0cU01a3ZDb01Kb3ExYXZJNzRYdHJPVEpxSzQ3SlJm?=
 =?utf-8?B?YmpSUGNaNU1RQ2JGYW8rR2pGOFo4M0xZVnNFa05JRCtNS3ZiejQvcHdvMXoy?=
 =?utf-8?B?aVJZRXpuMHc1WHhjdGE3OVYzMjN2Vkg0bzZQNTdBcEswUHhzeE43aGJmbFZ2?=
 =?utf-8?B?S3BZK1hvOWZJelYrYWFjTVRpbXJDUjNVSVFnZjMxNTlaUVBEYzRLR2NBclJX?=
 =?utf-8?Q?w1pQdDF7FqdkCgR5JoUG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15596d52-19e2-4d04-6f71-08dd23b51064
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 00:51:12.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9730

On 2024/12/19 16:41, Alexei Starovoitov wrote:
> On Tue, Dec 17, 2024 at 3:45 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> -static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
>> -{
>> -       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
>> -           prog->type == BPF_PROG_TYPE_LSM)
>> -               return 0;
>> -       return -EACCES;
>> -}
>> -
>>   static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
>>          .owner = THIS_MODULE,
>>          .set = &bpf_fs_kfunc_set_ids,
>> -       .filter = bpf_fs_kfuncs_filter,
>>   };
>>
>>   static int __init bpf_fs_kfuncs_init(void)
>>   {
>> -       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
>> +       int ret;
>> +
>> +       ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
>> +       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_fs_kfunc_set);
>>   }
>>
>>   late_initcall(bpf_fs_kfuncs_init);
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
>> index d6d3f4fcb24c..5aab75fd2fa5 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
>> @@ -148,14 +148,4 @@ int BPF_PROG(path_d_path_kfunc_invalid_buf_sz, struct file *file)
>>          return 0;
>>   }
>>
>> -SEC("fentry/vfs_open")
>> -__failure __msg("calling kernel function bpf_path_d_path is not allowed")
> 
> This is incorrect.
> You have to keep bpf_fs_kfuncs_filter() and prog->type == BPF_PROG_TYPE_LSM
> check because bpf_prog_type_to_kfunc_hook() aliases LSM and fentry
> into BTF_KFUNC_HOOK_TRACING category. It's been an annoying quirk.
> We're figuring out details for significant refactoring of
> register_btf_kfunc_id_set() and the whole registration process.
> 
> Maybe you would be interested in working on it?
> 
> The main goal is to get rid of run-time mask check in SCX_CALL_OP() and
> make it static by the verifier. To make that happen scx_kf_mask flags
> would need to become KF_* flags while each struct-ops callback will
> specify the expected mask.
> Then at struct-ops prog attach time the verifier will see the expected mask
> and can check that all kfuncs calls of this particular program
> satisfy the mask. Then all of the runtime overhead of
> current->scx.kf_mask and scx_kf_allowed() will go away.

Thanks for pointing this out.

Yes, I am interested in working on it.

I will try to solve this problem in a separate patch series.


The following are my thoughts:

Should we really use KF_* to do this? I think KF_* is currently more
like declaring that a kfunc has some kind of attribute, e.g.
KF_TRUSTED_ARGS means that the kfunc only accepts trusted arguments,
rather than being used to categorise kfuncs.

It is not sustainable to restrict the kfuncs that can be used based on
program types, which are coarse-grained. This problem will get worse
as kfuncs increase.

In my opinion, managing the kfuncs available to bpf programs should be
implemented as capabilities. Capabilities are a mature permission model.
We can treat a set of kfuncs as a capability (like the various current
kfunc_sets, but the current kfunc_sets did not carefully divide
permissions).

We should use separate BPF_CAP_XXX flags to manage these capabilities.
For example, SCX may define BPF_CAP_SCX_DISPATCH.

For program types, we should divide them into two levels, types and
subtypes. Types are used to register common capabilities and subtypes
are used to register specific capabilities. The verifier can check if
the used kfuncs are allowed based on the type and subtype of the bpf
program.

I understand that we need to maintain backward compatibility to
userspace, but capabilities are internal changes in the kernel.
Perhaps we can make the current program types as subtypes and
add 'types' that are only used internally, and more subtypes
(program types) can be added in the future.

