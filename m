Return-Path: <linux-fsdevel+bounces-39867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6AA19A51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C236188D431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476A1C68B6;
	Wed, 22 Jan 2025 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kAUfsASU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2053.outbound.protection.outlook.com [40.92.90.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4B1C232B;
	Wed, 22 Jan 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580819; cv=fail; b=Q2KLh6uFkF68flhIBUSI1z44HR8afimE3dx7bdBerIAw/IbDUOXjAhSr58GxsiabqyLFTHSSdH1NWYNnyrN5PLRsCkIGCX2l2n6Z6Pzk1VVujCq3cCTYIvNWT080SaAeoWqx0k4mmCL5a4Ug/2Y9BwwNWLAlzrUDkvFqIpS5a94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580819; c=relaxed/simple;
	bh=CIZ9eS9It80sTonjvA7hJ+7Iy8pSMwIIsHYMWkqZreQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJu+nm9R/HYWKp9Cml5IROmdjvKIy/vMttT5xafFTZScRbTiiEqevgTTWV9H00FPymxxmngHImBm+AzAdB3utGEFZa5oItBS4snqDYyNzf4WMWE/iWzwuesaIFauBGS+XpEHsm7khUSZw5idx/E4DyHi2cfIAOJgs8QhyvL3WCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kAUfsASU; arc=fail smtp.client-ip=40.92.90.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do1RRYJO0K7RRwbF0hoBqw3i+jHQhWShjAE4Dv/mPRUyAJjRU14AD0EunXhv62pvCgbGSzCHrQLLank60vI2lxuFx552H+4+vfXDBJf/0Noo1Pj71FWBvawxToLu85RmDeLubFTrE++z5XhiJPxQ4FsVlUI5QRhfXTFqwxlWvgVQwpR+VGJDlFAQCRn9G440+JJA6dR/KxkdudHSLA2/uqI6R7udIXXz067SxTLjKwQABIxNlAE7GpBSeQs/ey7ztvW8taf7td3+k80ExO0sPq6/0ITGAyU2xFYhrr2SuWgxBtSs16W+HptxQfxqXhlDMaqPfOK3c9GVmtHNJLhePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/U5c1y+kmLOAfmgL/3z3e58QItDL9nNUU0K8q/9qMk=;
 b=ScjSWfe5pbgo1dYKgVETktf0mJrOVchjpjVBaJEg4/lR9aFz6VafRy9c/bnmHaE7AO1r4PxsYkDgLRresqNFas9Gp//jazbEUfSsosGPgf7sPVW0Ophwxeh9L9dwZZlvkYcusB1pDxXBjPEOhVvjcjXpCTOvcMH6K5Nu0J253gzyU3kugwwDGCRzKVsiXhbYNK+tiOSN82ZnfaVKkyxx9telYwFWi50cUUdP0qxPbRQAlrmvP9W7FXGvPJrQVP6RGUaIo/xU7HPiYp3cGl6r2WobQhRR72jQGuxmgsgeBCYKT55k87bu7GV8x+sNnTn7YPp5fqaYUDIZrLZh+39hJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/U5c1y+kmLOAfmgL/3z3e58QItDL9nNUU0K8q/9qMk=;
 b=kAUfsASUoL0eWfVzgIpxCplE2fawTDNEFrjAXjz+QnWK1qcUggltmpnpN3yxuCli9RgHmki9O+H+JDQUPuKSaaDcRSI/YMOqlLOeBmBEbpCAFuL6gbZOkXTVOWZg7vnKq1SPIj9LI5WGbfJuCD5PW7eHxs/xZwXLIVgJZi0dQZKUA2uak4a3KmnxhY6jewXJ1irSlUvGHGAGsvPawgY35RBYOCzO+NOBKkuvb2Q0ZIQLhljOBsf5IH02t/LHhdCeipghhSorjDz0MetqqItZRtc47HZ2l0FtoTm/EDYAozfNWd2E9g0u5Jn5rKI4Jjo8pJ+TudEWuFHXtfXoYi9mzA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM9PR03MB7900.eurprd03.prod.outlook.com (2603:10a6:20b:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 21:20:12 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 21:20:12 +0000
Message-ID:
 <AM6PR03MB50804F40EA53A4EF22E4FEC999E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Wed, 22 Jan 2025 21:20:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 4/5] bpf: Make fs kfuncs available for SYSCALL
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
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50806C5D9B5314E55D4204A499E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLk6w+AkpoWERoid54xZh_FeiV0q1_sVU2o-oMBkP2Y7w@mail.gmail.com>
 <AM6PR03MB5080CDA2F6336B1BA2FDF2C199E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQKkaWkSHLapcUe83YQcmhO+S=2w+1rB_NzUbt=TOW9WFw@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQKkaWkSHLapcUe83YQcmhO+S=2w+1rB_NzUbt=TOW9WFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0450.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::30) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <5ac5b6eb-261d-41a9-bc76-f356f7c5467c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM9PR03MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a13e99-fc9f-4ada-07a5-08dd3b2a8c63
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799006|19110799003|5072599009|461199028|15080799006|440099028|41001999003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzVLcHdpam1DcjJ0T09VNDJNdFRwZGpOZVVjVmpXVWIraFBYUTgyVW9heEtn?=
 =?utf-8?B?dnE5ajNld1N3M3RUZnIrUXFMT2NDUUM3WUdlb3RJQ3Bsc3pSOXoyVGVkaE95?=
 =?utf-8?B?SS85dWVEeWR1UnB5V1dOUTg0Mmp6RlkvSlNkb2tjaDB4ak5yd1JyVXJ2WjMv?=
 =?utf-8?B?bjlJNStjUXFaajFWY0t4UkJlUkM2bHJFaXZPVUFLdk1pcER3dm9pZnQ5c1Vo?=
 =?utf-8?B?S1dPZTJZVFZLSFNtbnJKWjZnV1h3RDZWSjVmQldhZnBHTlhmTWduREhyNS9i?=
 =?utf-8?B?akFQVU4zSDJ3ZWxTWEdtRzFSNis3ZWZFdHpRcmZta0xYdSsvQWJLaitReEFK?=
 =?utf-8?B?RWN1cEVnM2pQaC9rL3drV1I5UERobFRoWHpGeUoxS0JQQkFnRnFmRnZGakpv?=
 =?utf-8?B?TW9IcnYrdERWa25HRnJ5K3hqOEh6VEdtUzNuVTNBNC9keUY2UTBqMGNRM1Nn?=
 =?utf-8?B?L2lQMEFpWlZoTVdCajhQMjJ1cndOVWdqTm5waEFQZUsvV3RSSlZQSWl0Wlph?=
 =?utf-8?B?Ykh2aTZUSm9lOURGT0VTbEo0bVRNNGRkcHA2MHZRNnBIc1RqOXY2elBkMEFH?=
 =?utf-8?B?aXdCRjY3N0w3czNBejBxOEFhN1JvZUFSbjNYRXVncENOMVRreXJYbFhPbTlE?=
 =?utf-8?B?d29yZjRDMGcxbVM0K2tzUzJ2R2RBZENFcEZvdkZFTi81dkVIdmJwWHBDZVhB?=
 =?utf-8?B?a3Rhbjg3UTlkTjJ4SnFXcnpOSDN0czRFVEdZSnhFaVUvUTNGYkpTaUlEblVU?=
 =?utf-8?B?dHRXMzUwZk92YUEvaGpxenU2bmk5dEUrTlMrTGVQNkpRWlZrV2hHd2hQd3BO?=
 =?utf-8?B?TUZ4elZzSE8vM0o3bHFDRnF3eDRzRTBnMmZsa3VLcDJyQWU2bWtNSkVTenNJ?=
 =?utf-8?B?RDVsTjQ4ZnEzVFRnRkZnVUpUck53VXhUdjQraWU0cWRzVW1yVHlhM3orcUlU?=
 =?utf-8?B?NjZjYzV2Si9vZjI2V2cvdElCYkFxR09RVUEyZmJmNEM5OXJJMS8xb1UrQlFU?=
 =?utf-8?B?QWxNU3NocUNYNVpXcGNKdTF2VXNyMmxnaWlnR3JOZWxRYTZOTUtxNTRxenZP?=
 =?utf-8?B?MnlBY2hGZGFRQStQVmhBOGZwS0JsOUt1a1RXWExtRkNvUm9pcDVkODdpUmI1?=
 =?utf-8?B?Vk1jV2hhSGhUZnNDWUJBeCt2L1A4R1dTWHJtckt2aWVuM2dmN0F6VEl1WVJR?=
 =?utf-8?B?Tlhha21jakhLMVUxS1dXclZNbGJ3VWdtb2FjL0FISHVvb2dSOWJ5WFhMU0tn?=
 =?utf-8?B?REdqNG93YVRITC9VdGg3UnRqN204U3BaVTZGMmZ3RVRqVzZ0aHovS01HTWRD?=
 =?utf-8?B?bFZNcFVZOFA5WjJVdVZud2diVlRLdVVDTzF5bkFaYkpIRHA3elFOMkFEK3JF?=
 =?utf-8?B?cVZUTTF1ZHdDQzhBVGtoZnpaQVkvenYwQ3cxWmZKQ1ZRTXVDUWt1dGpXVG5J?=
 =?utf-8?B?SjdPdmd2K2FhZmo0OGV4Z0MvOVpaS2plUitERTEwcXU3RnNjMUlBajRKbW1u?=
 =?utf-8?Q?VeATVY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0JvNlk1RTBiSTlDSmNxa213WGdEU0t4QmZvbTYwKzFjNStTVFJmUGJTR0lG?=
 =?utf-8?B?R0NlUkNBcTZrcGZtTVJZWW5WZVNCa05vbERLZzhpZklxblRSNHMvdTlidFQv?=
 =?utf-8?B?dWV6WkdmNExCVTdna25xS2dmM3NxVERWNWQyaFVKVEVVdXBGdFVXNytnQ1B1?=
 =?utf-8?B?TnBFaStsOG8valVpMDc3dE5ZbkdJUmNKTzBEUktwZldwamdLK3R4UHk4N1FJ?=
 =?utf-8?B?a1pNL2s0T1NyakRzbWR2eGU4bHBKR1NoYkQ5bGFjR1c4M1dMMnF2Tm5Ga25z?=
 =?utf-8?B?cSs5Uno0T0VOSjFYbHhFSDFZbVAxOUhXcjc5MTlSZDE1Y2xYdXFqYWNNWXYx?=
 =?utf-8?B?d3JaYU1UdS9QQlRqNVIzRVhrYU1sd3JGWHRzeHlNTG8vR29WakR0STZTejNB?=
 =?utf-8?B?dEVlRXRRU3pQQ01sTTR5ZmE3OHhwaEk3SUdxRDU1V3YwSG1MRlVwZTFjZzRU?=
 =?utf-8?B?dUd2UTl2MnZuUk5zdkNHMHh3TzBDNXliYjNuUmVIc3VoenErNXBrYXVVbE41?=
 =?utf-8?B?MlNrR1lldXBRU0grZEJiMFpvSTdwWm9RMmlIODNqUnBzMXZ3SFo3aS9Xdis5?=
 =?utf-8?B?cTNnQWRQRytKRHY2SHBQNldIa29ZVHFSYTJGMHdlUENvd0VYd2ptVlVsMkRr?=
 =?utf-8?B?WG9sdldWMjlNV002SUk5dGliRFFGbW1LVkVJYUxERmRXNHNCTm1jQisvWlZ0?=
 =?utf-8?B?R2drYU9FUDk3V2F3eERVdU9neDdRR1p6VWo0UTh1V0xFVnYwTHFzMDFJa0lG?=
 =?utf-8?B?UXdTRTA2dG50eHNLM0FMV2w4UGEyMzN1SzZDWVEwNjBYbTU2dUk3bTBnUytm?=
 =?utf-8?B?WnBwcVczMi92dzJwUlZ5Qk83cm1YRW1hckNEZWNydkZWL0RlS3FtajIxTFpk?=
 =?utf-8?B?Q0dCTXFOMHhqWmhVS09ab1kxRWR1R1ZlUjhLZjlvRDA5UXgzVDlBVjdhMFBI?=
 =?utf-8?B?LzhVMWpMNjZKYWVYSC9ZU0huS2dOejNFYzUrMFhNOTFnZURhWDhiWC91Zkg3?=
 =?utf-8?B?QUxYSW8yYy82cnVzVlZUbmRSNHdpUzl2cWlrZG1YRHdYeU5iRmFJL2pqVW5a?=
 =?utf-8?B?ekYrTWx2d2pDMDdWbVlkR0t6dnJ3SGhBcDdhRHJpb0wyVEpiWjR1aFlIUlJV?=
 =?utf-8?B?NFRLVlQvTVE2SmFXWDBqSGFUbXNGSVFyWXMybm85djllK25wR3Q3Z3M4dk1l?=
 =?utf-8?B?eENVMTJnQkNXTjBmM3lyMkd0MmVwbFYvSVlsRzBOcU4weS96NWY2QWNJNk5X?=
 =?utf-8?B?TmR4QW4vWmVDblNjN0l1MU1La2R1Q0wwYTFjWllVQ2V1OXpSLzJHMWVSaU5j?=
 =?utf-8?B?MlJWTno3WW9qSC9PamFyVnRVTmlkdFBxaHVnTHc5WkwzdXRoMGZQZ045RTkz?=
 =?utf-8?B?UHNkc3RzNEFXcmN1YmV1SjBya25mTU9YclJvZUhyajJzcjNIZ2NRYkducFlG?=
 =?utf-8?B?MG5RdGRGTnhjNE1YZHNBNWFHOGZseEdzNkllakNtRTI3S0xSMlpGRlBWTTZT?=
 =?utf-8?B?Wlk3UWhhTzAvNUkzVlpKYVBFQ2JTOTBIZUhsQmh4ZFFwMzhkWkJXWmw0S1hW?=
 =?utf-8?B?Z1JpVXlreVBqTTdQaHZDd1dzaU1ybHVkUjE2QlRMSVcwNzhDYXVBMFZ0VjNR?=
 =?utf-8?B?TDFHeFl3YW82OVdqWlM0V1haYnQ1SjhtRFZCczNOVFBMQ2h2ZGhJN0hZUGlz?=
 =?utf-8?Q?gKvndU/HMLbjdUCZWig6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a13e99-fc9f-4ada-07a5-08dd3b2a8c63
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 21:20:10.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7900

On 2025/1/22 17:59, Alexei Starovoitov wrote:
> On Wed, Jan 22, 2025 at 5:34 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> On 2025/1/22 00:43, Alexei Starovoitov wrote:
>>> On Tue, Jan 21, 2025 at 5:09 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>>>
>>>> Currently fs kfuncs are only available for LSM program type, but fs
>>>> kfuncs are generic and useful for scenarios other than LSM.
>>>>
>>>> This patch makes fs kfuncs available for SYSCALL program type.
>>>>
>>>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>>>> ---
>>>>    fs/bpf_fs_kfuncs.c                                 | 14 ++++++--------
>>>>    .../selftests/bpf/progs/verifier_vfs_reject.c      | 10 ----------
>>>>    2 files changed, 6 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
>>>> index 4a810046dcf3..8a7e9ed371de 100644
>>>> --- a/fs/bpf_fs_kfuncs.c
>>>> +++ b/fs/bpf_fs_kfuncs.c
>>>> @@ -26,8 +26,6 @@ __bpf_kfunc_start_defs();
>>>>     * acquired by this BPF kfunc will result in the BPF program being rejected by
>>>>     * the BPF verifier.
>>>>     *
>>>> - * This BPF kfunc may only be called from BPF LSM programs.
>>>> - *
>>>>     * Internally, this BPF kfunc leans on get_task_exe_file(), such that calling
>>>>     * bpf_get_task_exe_file() would be analogous to calling get_task_exe_file()
>>>>     * directly in kernel context.
>>>> @@ -49,8 +47,6 @@ __bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
>>>>     * passed to this BPF kfunc. Attempting to pass an unreferenced file pointer, or
>>>>     * any other arbitrary pointer for that matter, will result in the BPF program
>>>>     * being rejected by the BPF verifier.
>>>> - *
>>>> - * This BPF kfunc may only be called from BPF LSM programs.
>>>>     */
>>>>    __bpf_kfunc void bpf_put_file(struct file *file)
>>>>    {
>>>> @@ -70,8 +66,6 @@ __bpf_kfunc void bpf_put_file(struct file *file)
>>>>     * reference, or else the BPF program will be outright rejected by the BPF
>>>>     * verifier.
>>>>     *
>>>> - * This BPF kfunc may only be called from BPF LSM programs.
>>>> - *
>>>>     * Return: A positive integer corresponding to the length of the resolved
>>>>     * pathname in *buf*, including the NUL termination character. On error, a
>>>>     * negative integer is returned.
>>>> @@ -184,7 +178,8 @@ BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>>>>    static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
>>>>    {
>>>>           if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
>>>> -           prog->type == BPF_PROG_TYPE_LSM)
>>>> +           prog->type == BPF_PROG_TYPE_LSM ||
>>>> +           prog->type == BPF_PROG_TYPE_SYSCALL)
>>>>                   return 0;
>>>>           return -EACCES;
>>>>    }
>>>> @@ -197,7 +192,10 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
>>>>
>>>>    static int __init bpf_fs_kfuncs_init(void)
>>>>    {
>>>> -       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
>>>> +       int ret;
>>>> +
>>>> +       ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
>>>> +       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_fs_kfunc_set);
>>>>    }
>>>>
>>>>    late_initcall(bpf_fs_kfuncs_init);
>>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
>>>> index d6d3f4fcb24c..5aab75fd2fa5 100644
>>>> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
>>>> @@ -148,14 +148,4 @@ int BPF_PROG(path_d_path_kfunc_invalid_buf_sz, struct file *file)
>>>>           return 0;
>>>>    }
>>>>
>>>> -SEC("fentry/vfs_open")
>>>> -__failure __msg("calling kernel function bpf_path_d_path is not allowed")
>>>> -int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
>>>> -{
>>>> -       /* Calling bpf_path_d_path() from a non-LSM BPF program isn't permitted.
>>>> -        */
>>>> -       bpf_path_d_path(path, buf, sizeof(buf));
>>>> -       return 0;
>>>> -}
>>>
>>> A leftover from previous versions?
>>> This test should still be rejected by the verifier.
>>
>> Thanks for your reply.
>>
>> Not a leftover.
>>
>> bpf_path_d_path can be called from SYSCALL program type, not only LSM
>> program type, so it seems a bit weird to keep this test case?
> 
> How is it weird?
> How is this related to syscall prog?
> It's a check that fentry prog cannot call it.

Sorry, I misunderstood this test case.

This test case is used to test the filtering for aliases.

I will keep it in the next version.

