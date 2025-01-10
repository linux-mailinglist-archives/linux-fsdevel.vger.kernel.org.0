Return-Path: <linux-fsdevel+bounces-38912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB8A09C91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289923AAA2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F8215F7B;
	Fri, 10 Jan 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WZvW2liD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2010.outbound.protection.outlook.com [40.92.90.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530832063FB;
	Fri, 10 Jan 2025 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736541778; cv=fail; b=ieGaHfeP1843xT6G1zxoVvj1WdgvBHNs6HF6JMF1MyYAxEQQUcdT+tAk7ARIxPcYBWJrKCZD1yGmyo6+6OmeZbk3qPdwDhadxgmlNL5GZdOHtAqXQOMyucU3YPOgiWgPRMfIB/wSm5JBf38hOMZO+Q2Mh6bpSwRqGtsLjmnLOSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736541778; c=relaxed/simple;
	bh=dqEuRE04Hgx1ecFqP6RhpzfLA3A0TJvuXPLuTF5aMD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJdN/Bn10Csbe/Rc7sqA1ca5LFdQXsxDH3xRvz5zDEzWs5Znx5q0UmgMNLjccu2klSjKrIbHSv1jDxKcogEfx8ctXtHn9CbmZuEIYqKzPObfxqdsniB6EpFxfRSSAJHAVf72MvTouNlJGWzLDKt6sz9ncjY+XmPWA7N/oekMshk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WZvW2liD; arc=fail smtp.client-ip=40.92.90.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKutrm9xn6taa4xZ0H80FVQ0/AVilV/uQcPEUXbYsULLbTQIIw4eoucpnl+TBLr/9IU7mAU4O2/STWwUXgFvCrAv9JA/ll/oIY3XD8WxxGi320U7fp1AJrXL9OosBUskX2lOJ7mlhbcKEi2BXpitwYKFfCm130PRezJn08G+Qb6CyjVA44dlzdixGFY9HPx6Ur3Sm+6q36qwyq3APcqmKRxkmEGzcuL0EJsFbwiFjMOwj29Wlr9oEJsM12b27kNE/UbSlQmid5N1/2M1E11gFdik+On2iuygwjwDYtdpt72S+s+eAI2rBU+pHerdK5zBzGV3/sa1P//2MPO4Xx64MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6NcaAfYJ8SHCpdzBu04vSfpXohZqdZEMx6ACoWqnwI=;
 b=DyHVXJeOBnkr2tgOmFIPmoImaxLwcml5hXcC64vMJfHrdKvClPTBC+wTS0XCKO5pIQvt/+O5bXy/RN9AlaH6bOOAonBomxX6BZJjnT4uuZJC0Zbbd1xLYnKGuIMnr/AWf+tmzLiGX1oo45e3HRmnhl9nz6BM12CCGxNO0KYRFvMsq6NAMGfUv8wBPb87gCZ8vmL7za7HRnmXEMwTDcC5cVwGYc3CVphbPe1LZjEo77GCLvC+PkIgOSN05B7b7IPPCyoYGRrRmHxWtU8K6QPF2qV/DTJfVemmOq/wbRp3dYW0LzQlykZ1i7ii9kznz41ISJz3IUWvEIbV0c1UU/+a7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6NcaAfYJ8SHCpdzBu04vSfpXohZqdZEMx6ACoWqnwI=;
 b=WZvW2liDRBmOXmHTXg0+K5fWBA/kdlebR11YJiwjHS2JLd/Uu2IJuZdaMm16L2yQoya76STGPKnnkzTa4ej7oxN524oSWyDEHJCwqSs1CAM5c2FJVjLL+O4vAl9+CMlROihJjIhHYFqtRF8VAXaiHwa+DzXZHpL4eLkKyIv68nonHojDeDgnwP9n+RHeQqQiy8VYmYuhMnYTFMjathxJqqRGoPKiUFBh57lyv0FbG/m43U7LgjDBVI85WCHr9SnN3AUjeeWz/YniPpRcX/GZhr8ZZuU5mrdYSUPwi5PtRFsaC0EoJwAbz0lu9Sc1unPwvrPyRCOwItGawY2A75gmcw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI2PR03MB10595.eurprd03.prod.outlook.com (2603:10a6:800:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 20:42:53 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 20:42:52 +0000
Message-ID:
 <AM6PR03MB50808DF836B6C08FE31E199C991C2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 10 Jan 2025 20:42:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: per st_ops kfunc allow/deny mask. Was: [PATCH bpf-next v6 4/5]
 bpf: Make fs kfuncs available for SYSCALL program type
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Tejun Heo <tj@kernel.org>
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
 <CAADnVQJYVLEs8zr414j1xRZ_DAAwcxiCC-1YqDOt8oF13Wf6zw@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQJYVLEs8zr414j1xRZ_DAAwcxiCC-1YqDOt8oF13Wf6zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0636.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <74532087-8a72-4102-bebc-d55b7d60cfa9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI2PR03MB10595:EE_
X-MS-Office365-Filtering-Correlation-Id: 745920d4-b84d-445c-7c55-08dd31b75a32
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|8060799006|19110799003|5072599009|6090799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnhTMVdMbDBjMnhiL2V0TFZ5UGVIVC9LVnh4ak1FemtYT2pPWlpPelVyWWQ0?=
 =?utf-8?B?L2owSlQza1lQblkwSHVDeEZJeUNLUk9tcU5COGxhRGdhTitCU2hQTzFySkts?=
 =?utf-8?B?MnhuNWh4RThKTlRLdWV2N0tmSUhGVEJRbmtabEY2WVh6STh0YnpEQmZIdHkx?=
 =?utf-8?B?RWJ6Y1RVNjBublZoS2ozR01jemxkMlNrcXl1TVB6MXlQYmZkOVN5a0F2TE5N?=
 =?utf-8?B?bzhwK0dsM1pGVFhLMm9iTjRvdC84eGcwQnNoMGd4blZsMFpLZHg1aVAzR29G?=
 =?utf-8?B?NkZFNXJ3WGZuK09XYlVSUXdIdjd6VkhqZnpHTGY5UHJudXJPYWNDWldCMkNP?=
 =?utf-8?B?QWw2RktjTzRBSXNldm5Fb0xES0ZFQmR0cFdHZUc2YzBVVnJvTTRzZElKajYz?=
 =?utf-8?B?Z2pnNG5MOGtJbDlYaG1hOCsyREErUWRxN25CYW9DaytPNCs2aUVsWjRJeGhz?=
 =?utf-8?B?V3REcXpuaUxGa0kvYWhhZG8zdlQ2Z0ZkNGtSSGdZYWdQM21UWWdRbllTVGxP?=
 =?utf-8?B?WUpIdjRESzg3aHRERU1YRWpFWFB4YjIyWHVLMjFOeGVNdENUNXp4QU1SR3Nw?=
 =?utf-8?B?S0Q2TUlteExzNjh1U3JETGlENWpITU55U3RiTVQrQlloaFBYc1JvMnJMWFZY?=
 =?utf-8?B?UENZMXR3K2UzdGF2WHpkNFZjaG9kbG44RmxPRTBORHV3UXVIVC9IN1NRbllY?=
 =?utf-8?B?ZVVjKzRuZG5OM1NoTE93NVd5OUpnMmpFRXJFb05NakZncDRRZUVWcWsyNVdH?=
 =?utf-8?B?b244dm8rMkVrTllqN08vRFRwUW11R2pRL24vU3dHT0swcHdJZ3ROQUdoc3Fh?=
 =?utf-8?B?OWp3bmxvQkFOeGIycU44eXdEUUJwQ1FRT0ZQbkEwVTVUR2cwSFFadnZzYlcr?=
 =?utf-8?B?MStlck8zdlhJOFNPSVBVemJnTjd1RXpsdDhNcjZSU0Q3WGhmVzBobkZ4cDhO?=
 =?utf-8?B?UXdzNFRFV1RGL0NHTi9xdEt2VHdvWVhMMVNEeC91bC9scHVwQlp0TkNIa0g2?=
 =?utf-8?B?ajdRaFdnc05EbFEzTXRyaGtLRnA2SlZsQjRPa3BaTkx4eFZtbk9GbVo0VmhD?=
 =?utf-8?B?ZnhtWG1IalZUN0ppUUNQY3NIeGp3R1g3RDFKRlZieGZORlhpYUlKd2dzamlv?=
 =?utf-8?B?SHVPQ3lwSkp5K2MvU2lHUWNTd3VhbnVGNWVOMlZrczh0cUFhV2NsSWVKaEV4?=
 =?utf-8?B?c2ZzYzNleUMwSFo0RlNjZXFvakYrU1VrNXlnWjBsTXQ4ZDZNYTROZkJSdW00?=
 =?utf-8?B?QzNWdm15Wmw0ajg4dTVJTENUY2NTb1dBMWVPYUcwR0k0MW9PQnYrNmRHbVpK?=
 =?utf-8?B?cC9uZ2o1dHI0Q01hZSt1NlRyVVpYUlBzVTNjSGw0dW5iNmNZejc0c3owRWlt?=
 =?utf-8?B?cUhMOXBJWjFtUzhJcjllNW05SXBla2FQVDNRemhmYlp4TUVRcStnbjNxbFhk?=
 =?utf-8?B?QnFJQTVkRzkycW5LMmJ4S1ZVcGlZclZpS2VVNEpBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjFKc2w0cXNkNEJkYm1qNld6ZHcrK2Jtc05UYjJyWVFoWXFEVE5ISGV0ZTNy?=
 =?utf-8?B?d0lUQWFCVDdoa0p3U3pNck9MWjlhaEc3cEs5ZVJuQVk0UUFFTFdOSGNBYzd1?=
 =?utf-8?B?dHU0Vkd6SXIxT0xBcUdlZEJTZHVEVW1jTXo5bURZc3RvSlBIeTZoMmhYVUxC?=
 =?utf-8?B?RGpCRFA1bTdUc3pZR0hkV1ZsQk5MUDd4d0JndGtjN1l4aXhsa21tMzJoK2RD?=
 =?utf-8?B?d01tQlpGS0J5MHVzaGdiQ21RRWg4bkM0RnJXbklVWVR5VE9ORjljdUVKd2JB?=
 =?utf-8?B?NkdKSmlKbThGbklMVmRoSGlWRUNiYVkxdlhHaVRIcGRRdWJlbTBjbmdTYkMy?=
 =?utf-8?B?R2hCd2VCZWdIM3hlUmhybFRYeW84OTdPY2hjdk45ZE9YalpaMk4raHluWStp?=
 =?utf-8?B?WERzNzdBbEx0aXNJaHFPSFAxWGZwUXJoTW5KWVRKd280eTJCMFFWQ0NoZ1Yw?=
 =?utf-8?B?djhjTXZ2R2ozcE9TeWUwZjR4WlJFc1NsL0VTMDVMT0dtNktNdmhEOFk1NUhZ?=
 =?utf-8?B?MWZtRzF4MnQ1RC9SM2ZmSDlJNW5MU2s1dWZLUHBITjlNd3Y2ZDllM3JJUzBB?=
 =?utf-8?B?K1hrY0ZMQUpxNFB1VG1zUGRuN0VhQzNrdVhQemFvQ2tRVHdUU2lhN3JxZk16?=
 =?utf-8?B?dWFEWXZVRnZ5SEd3dXdsSHRFcVROWVZIV1o4ZkhIQkh0NUhwVnFsejlPNjk2?=
 =?utf-8?B?UTNMd3E5NFVDWVZIc3RmVEVYUzluMXo5UHgyVlRLMUk3YWpYQndvaUhYSnZ6?=
 =?utf-8?B?UHRiMzhvZXpiYUVDdkh1WnVYa2ZjZHBIQTJKWkpDVzlza1p1ZXRtamlObG9k?=
 =?utf-8?B?SzRZNEJRZHRCREMvS3FEbU5RN3FsTWlvb0tldGh3Y0o2eGd3T1VRWVI0MFh5?=
 =?utf-8?B?VmtNS1pJajkvbjVqUVRSRU5oVkhlZWFIeXN2R2dxdExRckMwcmM5UHJkK2lM?=
 =?utf-8?B?dTFvTG5GdDh1OG9jVGR4QytScGtudWFxdkQ4T09vR1YzK1NKL1l6Y3N4aE4x?=
 =?utf-8?B?Q2pPRUc4MEl6UWFwRVRFQU1RRGpkNVRWbHcrb2dpT0xYdU53RVY0UUhKalY5?=
 =?utf-8?B?TVBzMEJkMGdVdzNVRWs3ZjJGQmtGMlBjN0hnNVZrQmZJbVhKWUZXWTA0dzJu?=
 =?utf-8?B?SjhaMnhsdHkyNmhBdm43R2hhTTBaRnU2Q0pReTVNcEhZd0NyZzU2dFlFYUw4?=
 =?utf-8?B?cTRUQ3VURXJXbjd2aW4rMzg2YmVVdnZIeUxJQldhSlBkMUQ3TktBd1I5WEIy?=
 =?utf-8?B?SjlHaDFiUVFmazhNK0xYNlNlSWlFV0V2L2tXUnFhdkJReUQ3VklZa0s2OWw5?=
 =?utf-8?B?dGFpSUcvcXFXZVAzRDBYcDBnVjdXM3BwRk5vUnFTZmV4TCtyZGx4dk8vMmdx?=
 =?utf-8?B?RjBlTUk2VHlJK0tteGp2NWczT1pSVUxOc1hoS3JpaEVXL2duenhVY0pjVS9Q?=
 =?utf-8?B?bXd2OVB2WDdkYXdPT0Y4cVY4K3hlMzVkdkNwaWZ3OEdLeG1yQWdlZ2t1SVhm?=
 =?utf-8?B?MG4wL3JWaGNwck96Y2U0UEh2UkgybnlkaHErTjhsd0YwK2djUUZKUnc2MFMw?=
 =?utf-8?B?anJVbTBGNlJINkNWSWY0NFFmNjQ2WjNiTUw1TlJVMERTRytLU3JVNXB0TVRP?=
 =?utf-8?B?NjhBWXZvcnNob28xeVRWVEdTS3p3SzVHVE5TK0RYNHNSRktMSm5Nalp6ZVhI?=
 =?utf-8?Q?/XFKnbA55DHbOjmkMvuB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745920d4-b84d-445c-7c55-08dd31b75a32
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:42:52.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10595

On 2025/1/9 19:23, Alexei Starovoitov wrote:
> On Mon, Dec 23, 2024 at 4:51 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>>>
>>> The main goal is to get rid of run-time mask check in SCX_CALL_OP() and
>>> make it static by the verifier. To make that happen scx_kf_mask flags
>>> would need to become KF_* flags while each struct-ops callback will
>>> specify the expected mask.
>>> Then at struct-ops prog attach time the verifier will see the expected mask
>>> and can check that all kfuncs calls of this particular program
>>> satisfy the mask. Then all of the runtime overhead of
>>> current->scx.kf_mask and scx_kf_allowed() will go away.
>>
>> Thanks for pointing this out.
>>
>> Yes, I am interested in working on it.
>>
>> I will try to solve this problem in a separate patch series.
>>
>>
>> The following are my thoughts:
>>
>> Should we really use KF_* to do this? I think KF_* is currently more
>> like declaring that a kfunc has some kind of attribute, e.g.
>> KF_TRUSTED_ARGS means that the kfunc only accepts trusted arguments,
>> rather than being used to categorise kfuncs.
>>
>> It is not sustainable to restrict the kfuncs that can be used based on
>> program types, which are coarse-grained. This problem will get worse
>> as kfuncs increase.
>>
>> In my opinion, managing the kfuncs available to bpf programs should be
>> implemented as capabilities. Capabilities are a mature permission model.
>> We can treat a set of kfuncs as a capability (like the various current
>> kfunc_sets, but the current kfunc_sets did not carefully divide
>> permissions).
>>
>> We should use separate BPF_CAP_XXX flags to manage these capabilities.
>> For example, SCX may define BPF_CAP_SCX_DISPATCH.
>>
>> For program types, we should divide them into two levels, types and
>> subtypes. Types are used to register common capabilities and subtypes
>> are used to register specific capabilities. The verifier can check if
>> the used kfuncs are allowed based on the type and subtype of the bpf
>> program.
>>
>> I understand that we need to maintain backward compatibility to
>> userspace, but capabilities are internal changes in the kernel.
>> Perhaps we can make the current program types as subtypes and
>> add 'types' that are only used internally, and more subtypes
>> (program types) can be added in the future.
> 
> Sorry for the delay.
> imo CAP* approach doesn't fit.
> caps are security bits exposed to user space.
> Here there is no need to expose anything to user space.
> 
> But you're also correct that we cannot extend kfunc KF_* flags
> that easily. KF_* flags are limited to 32-bit and we're already
> using 12 bits.
> enum scx_kf_mask needs 5 bits, so we can squeeze them into
> the current 32-bit field _for now_,
> but eventually we'd need to refactor kfunc definition into a wider set:
> BTF_ID_FLAGS(func, .. KF_*)
> so that different struct_ops consumers can define their own bits.
> 
> Right now SCX is the only st_ops consumer who needs this feature,
> so let's squeeze into the existing KF facility.
> 
> First step is to remap scx_kf_mask bits into unused bits in KF_
> and annotate corresponding sched-ext kfuncs with it.
> For example:
> SCX_KF_DISPATCH will become
> KF_DISPATCH (1 << 13)
> 
> and all kfuncs that are allowed to be called from ->dispatch() callback
> will be annotated like:
> - BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
> - BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
> - BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
> + BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
> + BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_DISPATCH)
> + BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_DISPATCH)
> 
> 
> For sched_ext_ops callback annotations, I think,
> the simplest approach is to add special
> BTF_SET8_START(st_ops_flags)
> BTF_ID_FLAGS(func, sched_ext_ops__dispatch, KF_DISPATCH)
> and so on for other ops stubs.
> 
> sched_ext_ops__dispatch() is an empty function that
> exists in the vmlinux, and though it's not a kfunc
> we can use it to annotate
> (struct sched_ext_ops *)->dispatch() callback
> with a particular KF_ flag
> (or a set of flags for SCX_KF_RQ_LOCKED case).
> 
> Then the verifier (while analyzing the program that is targeted
> to be attach to this ->dispatch() hook)
> will check this extra KF flag in st_ops
> and will only allow to call kfuncs with matching flags:
> 
> if (st_ops->kf_mask & kfunc->kf_mask) // ok to call kfunc from this callback
> 
> The end result current->scx.kf_mask will be removed
> and instead of run-time check it will become static verifier check.

Sorry, I may not have explained my idea clearly.

The "capabilities" I mentioned have nothing to do with userspace.
The "capabilities" I mentioned are conceptual, not referring to the
capabilities in the Linux.

My idea is that a similar "capabilities" mechanism should be used
inside the BPF subsystem (separate).

I think the essence of the problem is that ONE bpf program type can
be used in MANY different contexts, but different contexts can have
different restrictions.

It is reasonable for one bpf program type to be used in different
contexts. There is no need for one bpf program type to be used
in only one context.

But currently the "permission" management of the BPF subsystem is
completely based on the bpf program type, which is a coarse-grained
model (for example, what kfuncs are allowed to be used, which can
be considered as permissions).

As BPF is used in more and more scenarios, and as one bpf program type
is used in more and more different scenarios, the coarse-grained problem
starts to emerge. It is difficult to divide permissions in different
contexts based on a coarse-grained permission model.

This is why I said that the BPF subsystem should have its own
"capabilities" (again, not part of Linux capabilities, and nothing
to do with userspace).

In my opinion, we should separate permission management from bpf program
types. We need an extra layer of abstraction so that we can achieve
fine-grained permission management.

The reason why I have the idea of capabilities is because in my opinion,
bpf programs need application-like permissions management in a sense,
because BPF is generic.

When BPF is applied to other subsystems (e.g. scheduling, security,
accessing information from other subsystems), we need something like
capabilities. Each subsystem can define its own set of bpf capabilities
to restrict the features that can be used by bpf programs in different
contexts, so that bpf programs can only use a subset of features.

Another advantage of this approach is that bpf capabilities do not need
to be tightly placed inside the bpf core, people in other subsystems can
define them externally and add bpf capabilities they need (Adding
KF_FLAGS can be considered as modifying the bpf core, right?).

Of course, maybe one day in the future, we may be able to associate bpf
capabilities with Linux capabilities, maybe system administrators can
choose to open only some of bpf features to certain users, and maybe all
of this can be configured through /sys/bpf.

So, how do we implement this in the verifier? I think registering the
bpf capabilities is not an problem, it is consistent with the current
registration of kfuncs to the bpf program type, we still use
struct btf_kfunc_id_set.

The really interesting part is how we allow people from different
subsystems to change the capabilities of the bpf program in different
contexts under the same bpf program type. My idea is to add a new
callback function in struct bpf_verifier_ops, say bpf_ctx_allowed_cap.
We can pass context information to this callback function, and the
person who implements this callback function can decide to adjust the
current capabilities (add or delete) in different contexts. In the
case of bpf_struct_ops, the context information may be "moff".

In my opinion, capabilities are a flexible and extensible approach.
All it takes is adding a layer of abstraction to decouple permissions
from program types.

Of course, there are more other technical details that need to be
figured out, and if you think the bpf capabilities is an interesting
idea worth trying, I will try to write a minimal POC and send an
RFC PATCH.

(Actually I have always wanted to write a POC but in the last two weeks
I have been busy with my university stuff and really didn't have the
time, but now I finally have some time to try it)

Yes, maybe I am a bit too forward thinking, at the moment only SCX has
hit this "wall", and at the moment we can indeed solve it directly with
KF_FLAGS or filters.

But I think the problem will persist and come up again in other
scenarios, and maybe we can try something new and maybe not just
solve the SCX problem.

Does this make sense?

Maybe we can have more discussion.

Many thanks.

