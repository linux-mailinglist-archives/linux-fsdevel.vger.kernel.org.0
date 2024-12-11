Return-Path: <linux-fsdevel+bounces-37102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5819ED884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF27B1647EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D531D1EC4CE;
	Wed, 11 Dec 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YFWhOsnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2099.outbound.protection.outlook.com [40.92.89.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD71E9B32;
	Wed, 11 Dec 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952470; cv=fail; b=ph1/Z2/IL6jO+L9Mw+EBSSWf6ZtzrP8l44L26iTcYDxKIn6bVhP58R97RROQ4V3LrvkdPx63HoZgNql9NkOubZK9wRFGoeto/2bi4U3aI3T31s19SElgie/qUCVSaww5dM2DdcLPE/x3gsUGfJWCukGU31JF6ozF/RIDoT79HVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952470; c=relaxed/simple;
	bh=/xtocB/0FMrJ+RcYTFdE87eRQOn86Yt3tDNylVbCFZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XtdWnDudvJ8SRzRm9YBrgVnD8AzezX92goizLq7F4Onef6LTOIprgHjVLflzL2cqD7XoDopStuYsJ1Z8Z7N9sPaaFwTSEp+Uer1RzUFlcY5BiucsWRS72IXJ8K+lClmenK/5q6mXTiaNQvcPGoYaAfufaGWz+HyJiVrQh3kjKRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YFWhOsnC; arc=fail smtp.client-ip=40.92.89.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiJw9zBKETLroJMEc2u8JqY17/xX38iqu2h7i/ITAJNK5hdM39WTqtb7r1RcxQHh/zgee/Ys8rLmA5xTZcN79UNm6b1563zsa1sKye0EQEx+e3rCK2kBWmCsCCc6EotGXqYtdywFTWxsSO0v5KMj3JJ/2mVyTjMTMQkUkrIkUpQaTjeGqVsHhm/HPm+xIfavXo86qBUqaG/GMEZxf9cnYUicA8BaUhKHRInKmtGgwQeFg+zj+gdvamEpYJScQEXDdZGRDhQzw4bVVqETa0xVXZxaLRuhxdDTYScX/XBx1Z9dDzoZrmiiHb3H35gtbYVXxsWMt6a3kzYumudkH/IM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8I6EcqMASBgDTol9gTV3JySHQAIl/PpztfOLl9iPsQ=;
 b=BnwYaO+5wC1VMuZl5Z8+87lIl5MM73vJnVfziuX6R4KWT+JBn7z4vF2UxI8zUoEY63RMrtERWdBaOUeAGRhKvTSXcVx4ZHxhEj4qp1oK+a7CG8V+BI55CUeAf94ROuiQiseu+WrIouVw2KO5WbKXILV3OWoSk3oQUbHRXyVJxUO8Hjr5jRXossAoHT6YyAAfx5lxGjJI2TK2qVvH9eYb57/h0GFM5/nxJcOpLFIo/AH9o1v3Udrg+QlbQ1eTXw7gRv1V4LAJetvN+Su4VngeWYSxTHahKlg9D6Zpv3PzkKuP6DProYwo32yhjIrsYT/rcjxDH7Ejs1wztkaUPOveFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8I6EcqMASBgDTol9gTV3JySHQAIl/PpztfOLl9iPsQ=;
 b=YFWhOsnCq1SUQnKYCa6cyFYEDrIycHYJCA6JFrBe3QYDv14kziAYebiYbP9+Mwjg0TQ/HoCeWyUag7HZZfpZ5aK+5YZ2k3SH6+kTOsMHEdnFBtLZgm2NHH7ncPZYGAeH9CZKKzaKX7I3WzdAfv9gJofYLjzbNFAy9U9CxMnRllHbBk3TQHnidqKopEVkbDDyggz76HomnCM92W7lW5C/BtCprG37LTCI4L6v2ncfK6buFpRUPw4whW4RhmmtkT7lEl59IWSTnLxQaRwHYjDmfc2dhxyZJd8Yzd0uv31ADVj25nUnOsR1HHZfQPGg/7qE4d14xBr1z73sYEkrjTRWLw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM9PR03MB8025.eurprd03.prod.outlook.com (2603:10a6:20b:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 21:27:45 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 21:27:45 +0000
Message-ID:
 <AM6PR03MB508062C9203BCD7C63BC5206993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Wed, 11 Dec 2024 21:27:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/5] selftests/bpf: Add tests for open-coded
 style process file iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080756ABBCCCBF664B374EB993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-zustehen-skilift-44ba2f53ceca@brauner>
 <AM6PR03MB50808A2F7DEBB5825473B38F993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQKK3vmfPmRxLuh6ad94FeioN2JV=v+L-93ZvwdYqR_Kcg@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQKK3vmfPmRxLuh6ad94FeioN2JV=v+L-93ZvwdYqR_Kcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0252.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::23) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <f8b65830-f38f-4184-b2aa-d30b5ce1e26a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM9PR03MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 7900a01a-53bd-4552-8689-08dd1a2aa738
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|6090799003|15080799006|5072599009|8060799006|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkpCQTZOV3Vub0VCZFlHTDVrcVZvdWY1UWNCWUl0Tzk4Rm5qclN5OEtaMzZ4?=
 =?utf-8?B?Z2xRcC9QbU5mMnZpam0zNTNIQk1UMVJPV3BXRHRhT1RES2x1V3FiOUFFOG1o?=
 =?utf-8?B?ZlRIRGplUFI1TForSVBlb2tmM1FRSnQyYmZCVW1ZOGxQWndvcXFDeTNCRldR?=
 =?utf-8?B?SU12a0dYdVFDdkw5UWhqMmtOTXRmTmx1MFJaN0E3dDhjck94MHN0cTQ5ZHo4?=
 =?utf-8?B?YmhRZkV4T2NQTWJBcndON3pVeGdtYkRWeGdBWVBLRnpsdjRVdlF2ZnJjR0JN?=
 =?utf-8?B?STFpQ0lucUxONENJektDS2RJUVJoWXk0MkFhVG5HL0xsam9QbzRQK1R4T0tJ?=
 =?utf-8?B?Z3psQUcyL3FIaXllbyt5VjZYMzE3OU1qRzdsazJ0aGVDVUFEUFBQbitBVnVs?=
 =?utf-8?B?c09JZWR5MGxLS0hsdnp6WDVVeVd2U0czK2tpK0FjWkJwVHMrVnJMbzVPRlNj?=
 =?utf-8?B?b3YwSGwvOXhzY1J5cjZsNytDMU9FajNQUFpWY1E2L2dYdG9sK2RjTkt3NnA1?=
 =?utf-8?B?cUVuOTFydG12MHpOTmxDVXpOWjk4YU40MGtCcWozQktUWnhNeDdMc2dOQS9T?=
 =?utf-8?B?OUdOQ2pNelBINGpreGZ4SVpvVjNtdjNBRjFQWTlodWg3YVJ2WElwcDBlQ3Q4?=
 =?utf-8?B?V1l5QmlxMG9EcXVBak9oSnd2eXhmYmRoV1N1UzA5SW16K1hPWDJjQWt1L0tt?=
 =?utf-8?B?d2lFSVdTV0duLzdBcElNRnBnRTlhak1GU3QwRVZxQ0dydGFDbXBtMnRsTTNO?=
 =?utf-8?B?SitmNFp3YnR3UzVoTU9RT0wweGZpOWY2M3lPa1FiUkIxbU5wKzVkcjZkQzJt?=
 =?utf-8?B?emJ0dmR4RmpNZ2tkRjB2NXNuQ081M0xSZlREb1JDc3JsdkI3M3gyNzkvRUtH?=
 =?utf-8?B?RHhZYWkwYndibTFpcDRGRUJtTzFWV2dxOExIYmtWMExid005Y2x0R0Q2RmZC?=
 =?utf-8?B?ZndwTTNRWktpcWJaaktRem9iRHJPVU9GcC9TNGhYYXZPNU8rRTJ3NSt1SHJn?=
 =?utf-8?B?cklNazF4a0VweHlLNGpjdG0vZXlLZ1Q4K21zak5kMHh1aXAwR2l0dCtGOEti?=
 =?utf-8?B?bEl0cWdzZDR6ZmZwZ2FzSFdHcUg2b0IwY0VsR210YW5jcU1MWHBNMXRyTlRl?=
 =?utf-8?B?dzBlWXdzcGJkTWxCRnR3Tyt3OUFhbEg4b2hienJhMWRuTXM2UUhZc2kzdG1t?=
 =?utf-8?B?RWpZSjFkTUM3a3NmaC9qQUJxRjBKNHlPQXJhaXNQM3c2WVhzWWptNk9DTGVL?=
 =?utf-8?B?SzJUbjZORjNrbDJ1enlvOUhzOWw3MFlVTkxwSmFQMUxPemN0a0gxbkZ3Ymha?=
 =?utf-8?B?TEtrVmxkSWZJRHVUM2ZOdGZCZzgxc2tFeXlIS0gzTGtDK29wVC9BZ0pVT25v?=
 =?utf-8?B?TkYySmZMWEhLbnFPRE80blB1LzBtZFUzQ2dMMnNocVFwMGFCTjBWRm96a0hY?=
 =?utf-8?B?eFdSRUUzMmQwRHlkYTNkR1ZIMVFyRCtPYmVDV3R5UkZRZVgzUWd2M3llMWsx?=
 =?utf-8?B?QkJ4VEFMNUJ1WmhyMGozQ21WU3VmYVRzN3BKVmo1WlJjbno3Z091cTByTHlS?=
 =?utf-8?Q?mxJTpfVZCR8kAynajVMvYQ3p32CxwJN8IZA8Nm55WLrYnB?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q09hcm4yT1NRMDJlNFJWY0FidUtYWjFvS0k0blJ5eHA1VHBMSGRTbDBwbTRM?=
 =?utf-8?B?RnlSbFhnMWgzQWNpSW1BS1hodTBQc0VkYVgzM29meVQxdktraHlBVm0vdnZW?=
 =?utf-8?B?ZVM4WndnMktkVUZwcGdZNXN6SkpjdVhvdy9CVHd3eEhUaVFsa2g5ZXZmRm45?=
 =?utf-8?B?VEJIekV2T2tsUlo4aFBKNEZKcW9aMHdEQ2Y4bnJiNDM4bk9ZUDlBUmxScXE1?=
 =?utf-8?B?Q2MrZXlnSHJ0YXJOVDV2djhXcUNCWlIrWTd1SGtwaDloVGxwZnpHUWJpd0sr?=
 =?utf-8?B?ZThFbU5HQnBpQ2VHTXljV0hXRHh2Nk5aQ3Njb2o0bnc3N0FRWHZvSGZkdUxv?=
 =?utf-8?B?V1lITy92OWJwYlc1Y1B3anRrbnJYVzZ3aDU5bVJhMUpKZG0zZmx4VjFPbXlT?=
 =?utf-8?B?VUZpQi9ha0M5aG1EazlBaEoyenFtdFlRYUVlS0pXMVhBdVVBYmcvRUkvcmhB?=
 =?utf-8?B?QnVYQjA3WFZ2eXBtVFhpS21qSUhNU3NuMGgrWnN5YUduZkRrekZzUXdmTGEw?=
 =?utf-8?B?SS8wb1hNYWRDdzZqNU1JOWtvKzhNYllEcEN3UkI5SnVMRW93czZ1N0Vzdmd0?=
 =?utf-8?B?NmRxa2pweXJkbW43MGQ0ODI3SVB3b0VDOE9JeTJRWExENTJzS0RzMnAyVkw3?=
 =?utf-8?B?ZUlZaGF4OVk0Uituc2o5NE1JVS94OUM0enFUUG56N0J5RFltVEdlc1RnV2J3?=
 =?utf-8?B?eElROGhRS0ZlTkNucSt2VC92eUhyKzJuV2cyRmVUR3VtMkV3d3ZuTEx4TlF1?=
 =?utf-8?B?TWhvOWdFbnR0WE01ZldTTDdmWXdTQVlYNWVXQm9vdnZmS0toNXNJNTlRMUdB?=
 =?utf-8?B?UmFsREFyL2syUW5KM1p4MFRrcG9HbFBSek9QMjg4bnhvS1FPYUZJRnQ5YVZD?=
 =?utf-8?B?VTM5azNEYjRJVXIzU3dJdkJ1WlVXSUxaRUl5YjRRMVZwWEszck5DWmVjYmlW?=
 =?utf-8?B?cGRoOCtWaCttaGgySU51dm9XTFVIbFNJajEzcG03S2lUdmYvZ0J0eW1MMkdx?=
 =?utf-8?B?TnNWUmNVRmhYVFNydVpqUnI1NjMyd2hlNG1TUU9Lekt3T3Z1TXlUQlo0UjMy?=
 =?utf-8?B?OHBNcjZOWW9vVXp4MmM2ZGJtUkZHTHR1Z2FrVjBSNEg2UDFvNElnaUdNM29Q?=
 =?utf-8?B?SWVMQTJXODhUSndmR1NIeUhnMnBISWZXcElXWDhiWitnR0pRUWpDU25wVm8x?=
 =?utf-8?B?U0lwdzUvaVBtL2V2N3NFMmV2SHdFMDg5SDlURExpNlAxNXNSQklKRWFicEdQ?=
 =?utf-8?B?aktPd2ZiWFQxUzhVbDlzaFZUa2RrcE8wNVlndUxmQ1ZhKzEvUDIrcWtIM2RS?=
 =?utf-8?B?V3VkendlVlY0YWlBMU1ja1Frc0ZOZ3VKaGhTU2E0dUJsZTJCTk5sbnhDQ2N2?=
 =?utf-8?B?RU5mMHBDbk1QRTMwV3crVzFFNTYrTTRqdjIrOEZkVTY0T0MwQkV5RTQrbm43?=
 =?utf-8?B?SVRjUlRkbGUrbW9KNFVJZ20yVmZTZUxvMVBYeUhjUmdrUmdlQVplRmw5eG1w?=
 =?utf-8?B?UUI3OFhtSXU4UlJJb09veEcrMmh0d0RkQWNlNG1OVTJVNFVTSkdJd3l6d2xr?=
 =?utf-8?B?bnFuNlB3Z25XYzczcXcxWkljdmhzSVJGa2dianhNa2VJdnQxNHhIYmEyMWdT?=
 =?utf-8?B?YUs1ak9xRlBOS2pwd0Q4S2dQd294OThZWElhQThzcWJhMkZJOStXRVg1QjVE?=
 =?utf-8?Q?7lNRuPp6zEySqbWHWrB5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7900a01a-53bd-4552-8689-08dd1a2aa738
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 21:27:45.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB8025

On 2024/12/10 18:51, Alexei Starovoitov wrote:
> On Tue, Dec 10, 2024 at 8:23 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>>>> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>>>> +int test_bpf_iter_task_file(void *ctx)
>>>> +{
>>>> +    struct bpf_iter_task_file task_file_it;
>>>> +    struct bpf_iter_task_file_item *item;
>>>> +    struct task_struct *task;
>>>> +
>>>> +    task = bpf_get_current_task_btf();
>>>> +    if (task->parent->pid != parent_pid)
>>>> +            return 0;
>>>> +
>>>> +    count++;
>>>> +
>>>> +    bpf_rcu_read_lock();
>>>
>>> What does the RCU read lock do here exactly?
>>>
>>
>> Thanks for your reply.
>>
>> This is used to solve the problem previously discussed in v3 [0].
>>
>> Task ref may be released during iteration.
>>
>> [0]:
>> https://lore.kernel.org/bpf/CAADnVQ+0LUXxmfm1YgyGDz=cciy3+dGGM-Zysq84fpAdaB74Qw@mail.gmail.com/
> 
> I think you misunderstood my comment.
> 
> "If this object _was_ RCU protected ..."
> 
> Adding rcu_read_lock doesn't make 'task' pointer RCU protected.
> That's not how RCU works.
> 
> So patch 1 doing:
> 
> item->task = task;
> 
> is not correct.
> 
> See bpf_iter_task_vma_new(). It's doing:
> kit->data->task = get_task_struct(task);
> to make sure task stays valid while iterating.
> 
> pw-bot: cr

Thanks for your reply.

Sorry for the misunderstanding.

I will fix it in the next version.


