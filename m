Return-Path: <linux-fsdevel+bounces-37356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F39F1545
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E1A7A1351
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681DB1F03D9;
	Fri, 13 Dec 2024 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ofd7sReD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2075.outbound.protection.outlook.com [40.92.90.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53E1E6DDD;
	Fri, 13 Dec 2024 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115901; cv=fail; b=B0eA6OGHu0k9ZeRyimwM5NfmZ5iZj+a3npotZjz7yJu+kNkQ1nBaMX8F5lZsiW8WasEAePZksgK4cwZhD1ToySP1kmrzi8xRHhei26mp8iRFkQ3VKUMB+8GOQF1jzowKD2V9BTxtgMK0NVQIXsmHadffuQwVpGweFtsCXLzxkCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115901; c=relaxed/simple;
	bh=k0rRgZ16Fd6U7XMIPa17D99Do1h0PZEaf/j0A2AQ14M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AaYJb45bX8YOswrwG4dqxlc+KoDMOFdooOrTIas+Levoi2OFJF8ilJBiGSjWcN0W/q0ELqnmrHMvr5qC0fVoItN5rXOhFeI3xVQ2/peWDIWYsW3ZLlNJezKMnaKUrXHg4DTVTeGM/FSSQQnZTqyHX30D+PCIT+67lvFcRKjkl3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ofd7sReD; arc=fail smtp.client-ip=40.92.90.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MV9L6Htq3o9r/iEByqFiT6xOJaQVie8L1dowQKuf+5GGq04sg+fNW52pJcgRTVyzRUJaSPCpVPu5pwqSNP0vrJ2beYljxk6f1/zy4OCcqRV3VBMLM9loYCT8pH/03Q8OTr6E0u7HNi6mz+OmzDGtBgE28cYKWUZjSPuf6OE7hu21TveMZQkkutU07AlSn+8xFX80Mdq39U/UpDNFVkhuSD9mZ63r0CjSqD163DB6+hv5nkN+z9FQeWPLh0HUa0ONH0wxRgsQ273eNLqtLNlzQt7N2Ivz0Wr15iLJ7zCiL6vKKKuS5GS5wyZyUDliat2RKXfdvbTwlBF0QSdbDVsNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UG8+wY7d5xU4r3YYWWnhhLuF+jgdRJvz40jLXTijnc=;
 b=uVqw5CU+irO6ZErB72J0u3jzlYkSMvR05dCbDewJjQm/Z0gEgJ8GpFK2X8XjXf2gvoy9OEl+U3H+NlOQtuUYDiHIRilNMwgvegy5/1mrecFRO/H1dYn5OWK+0mcjEBIoLlQnrr8z28OpuB9IArEjgu2YRVri1yd63+6K/m824iMNx65kHETNbC/v2gfenGaOn3sLHG7ZJVXTa+co579RaGChbNoRqqtAgelG3rNmLTfJ+N79SxsGv3Defk/xLAriKxQW6ER700fRuDyNz5/OcnYLLN8/CzmxRcolRCcU82TEKBQi+QKM0tVZE1/X0ZiRhnIvAJIUGCS08vIKq8CIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UG8+wY7d5xU4r3YYWWnhhLuF+jgdRJvz40jLXTijnc=;
 b=ofd7sReDJKgDPt8aAAxzAo1pKeIrkDHe3DVtD0A1eqI005OVR4twnmzAZNN0IIM8XFppVHXHGUqWp0iROgb9P1HGgTU+YpKM57OO/rnopTssx3Oe+IKfuaJ/YIacsBmwy7GIbA/JRvQfPYJf1cTLHaogdCcGE32Ci+3N82EE4GsjJaTsWIcpHfBR59Hsac8sEbhJ7KfkbSkWxAfZ4HfBWdiWxSfyzvnpx7eRY3boZ63keNh3YKZVTz/okC4TH6TaZxRxqBLd8LabeHv46gAOGeNyGVfkFDebyV/IQrLbvq44gO1Yb2D0NIJs30V2d6atFJy9TI3FlJYsdeGQ1BUzlg==
Received: from DB7PR03MB5081.eurprd03.prod.outlook.com (2603:10a6:10:7f::32)
 by PAWPR03MB10133.eurprd03.prod.outlook.com (2603:10a6:102:330::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 18:51:36 +0000
Received: from DB7PR03MB5081.eurprd03.prod.outlook.com
 ([fe80::7b9e:44ca:540a:be55]) by DB7PR03MB5081.eurprd03.prod.outlook.com
 ([fe80::7b9e:44ca:540a:be55%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 18:51:36 +0000
Message-ID:
 <DB7PR03MB508153EF2FECDC66FC5325BF99382@DB7PR03MB5081.eurprd03.prod.outlook.com>
Date: Fri, 13 Dec 2024 18:51:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL
 and TRACING program types
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
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-eckig-april-9ffc098f193b@brauner>
 <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
 <AM6PR03MB508072B5D29C8BD433AD186E993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQK3toLsVLVYjGVXEuQGWUKF98OG9ogAQbJ4UeER42ZyGg@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQK3toLsVLVYjGVXEuQGWUKF98OG9ogAQbJ4UeER42ZyGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::20) To DB7PR03MB5081.eurprd03.prod.outlook.com
 (2603:10a6:10:7f::32)
X-Microsoft-Original-Message-ID:
 <efa8397a-d142-46b7-9d72-750bd3928344@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB5081:EE_|PAWPR03MB10133:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7477bb-ed92-47eb-40e5-08dd1ba72ba1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|461199028|5072599009|8060799006|6090799003|10035399004|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emVVeDlockZVZXYvMC83UkhTdlcxdVZzNU9tSU84cXFQK1N3cFhsSlliSmo5?=
 =?utf-8?B?QWVFVVl5ZVBudnVidDU1Y1hJcldRT0Z1ZDlIdDVHSEpDTVN0S1ArL2Fvam53?=
 =?utf-8?B?MVUxdmUwb3M3UjJkaERMWFBpUEZsWTNoQitqaHdNcVJQY2pleDFpRG1adTZv?=
 =?utf-8?B?K0tPSFpDTk1pMFdWeTNxcTFmSmRQZHM5MTkrcE9iNUdOKzE2ZFNJcmxQUGJ6?=
 =?utf-8?B?VmZ2bHNMTnJsdmtrbENKeWFScU93a3pBZ0NmZHBGR1NxL2NHT3lWUEZDVXZq?=
 =?utf-8?B?N3lTSXZLTm0za01VVHdxRDBaekVPeFFSRmxpMEk0eDF6VEUxOUF2YktkeWhF?=
 =?utf-8?B?SXRQL0VlY3RCRkhDdHh4Q2x6Z0RYMUd4aHdNZyt1bUwzaDdyOUpUcEZWck44?=
 =?utf-8?B?aC9RMW16cnlxWFFDdkd2VXMrNU05SkJXSUdjRk1FbHpjUzd0RDkzbnBtK3VR?=
 =?utf-8?B?bm5xZDhBYlNUTEc4UjgyKzRVbGQ1eWdsakdCdXdZSmgyR0hLbHN2KzRBVmx3?=
 =?utf-8?B?d3JDK1NHQUJ6WTlPRlJIOUYzdUpzOXYvRGZVdDNnck1LYUhTcGIwL3JIODNL?=
 =?utf-8?B?TXNWYVFYa2ZPZWlsNWYwRTZ1STNVRW56V1cxc0Vhc0tqaHlWRDBPT0tzam1w?=
 =?utf-8?B?Mk9NaSt5SmwrWDZoaS9rM0J4VnFhU25ITHVmZ3Z3RkZJcXZHZUUrS2hOcCtp?=
 =?utf-8?B?ZUNkaklPRFVGV1FzKzRJc0YreDdvaGZheFRCWjlvYU9hZ3NSQVBXYWZxYmlp?=
 =?utf-8?B?SmFiUHdDSEF1c0NvODNEU0s0WlRBalp6dURzZnRUNlhGM0czcnBlY1FCRnhn?=
 =?utf-8?B?WGo2MjdxdTc5b2d6Z041VVFBY3Z3Z05tanYrTERId0xwZGFRMzl1dkxxV0s0?=
 =?utf-8?B?MnNQbHhCdEJRWGpCQWtLcFdSVEdWdkx5UjhUdVZzZVZMNjFoOXBkWm5UTXBP?=
 =?utf-8?B?MjVXbWRWYkNhbmQ1My9DQ3F3YlRnakV0MXBxK3pNV2dWNGVzeEtxRWNPeW9o?=
 =?utf-8?B?MG1VeDMwS2tYYXVSakQxemZFcnBGR3pkdWs3Mzlrb0NYSmZFaTJXTGYrTHhM?=
 =?utf-8?B?dDZSMkVQSGRWZ28yT28rVTlNYmJ5WVg0WmhTS1hMZ1ZUQXdJOXBEc2k1ajJK?=
 =?utf-8?B?WGNKalZBT3lIajRGSWxwNVI2QVluMXl2Wmhma2FkMVV3Y0ROUkNsaVo4ZGZq?=
 =?utf-8?B?RWdlcFBmODN6RUV5RTNPZFRFKy80Q2p0dnRROEgxdnZUcXc2ZFJGQlp6OEc5?=
 =?utf-8?B?STFsYTh4YXlkOVI2RFJWZ3p0Um1ObVdHeGtIK3JNbTdLQ0xzb0FxQ0pmSUR2?=
 =?utf-8?B?RWdvWWlOOEIzdzhUMTcraWE3UDBrcGk3WGZnVXRCTmtsUlR0d1Zkd0ZTTnY0?=
 =?utf-8?B?UE1ZbUJnQ1F5N2lrbEVOMFZsYThwNGNrZ09vSnk1Nk5SRFVpR2FEVFA4ZjFL?=
 =?utf-8?B?OUVROFI4TEtMb2lDTWlTVlJEMEV5dmNVVm1kb0Qra1lMeWFlMU14TEExZlpF?=
 =?utf-8?B?UVM2WlE1c3hnVFJYa2NKUHZNQlBlQ1Z4Tmpad2hQSlZqRHZXVExOYWlhaU1S?=
 =?utf-8?Q?D13Q4gur37tf49HXgrygtvidw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWFVcWpxUmhvN1FrRWJ6Y2V3VWFEVFhGK2FmV0tUNUFETnA5TU1XN1dsdVdF?=
 =?utf-8?B?N2UxdXZRLytURUZCM2NNc0RhT0htM0xvK3NoSkcwUjFEN3ZSdFl0eEZocytJ?=
 =?utf-8?B?WUZZdWk0SUlsdXZQNVZFbTIyMVNYeHpDTk1tUVdSbWszRDdzYWF6TTVqQmx4?=
 =?utf-8?B?blJ6VEFZdXhNNWZHYkJxL1ZQZGRYM1orM0ZjMC9LQ05JZW9xUUFGZ1NxU1cz?=
 =?utf-8?B?VVd2TE5yNXNPTExPK1RJbis2LzZ3cFFlb1FsUXd3RjZid3BETHdwQnpvSFpU?=
 =?utf-8?B?SWNZWVAyMXNWYWswYXJNamI4OHdvWEtQVDZjWlJuUFBXTXhXazlYYTFvSTV6?=
 =?utf-8?B?NjBWQXBkcTA2eU5vczVJN21Bd0FpUGNBd0R5MkZqYWkrSGhqbWthSVRRcnpj?=
 =?utf-8?B?Uzl6NzlVMVlaVnpXMjAyYVVtYi9wN294YVBIaVllQk4ySTV2OGR3RHZtYnV2?=
 =?utf-8?B?S3UrS3VtUHZRWVNyVExLaVRqMjcrZ2JkUDJPUy9qazhBY1dkNnQzaFJ5MG95?=
 =?utf-8?B?aEtmUUxIWEF5cVkzU2VDcithU0hTYzVxaE1Kak85OTV6Uk9GZG1SQkpBdTJH?=
 =?utf-8?B?bE9WSUt5QWlXdUdpc1JIMU9lbUJBb0ZzVXN2SDZlMS9EVjRlcTVZZG0vNnAz?=
 =?utf-8?B?NkJabjlWeGdmTXFDbC8ydTFRemJwck9Fb3ZQNjIwbG1YMDdVZFBIUW5FZXpQ?=
 =?utf-8?B?Y3RFbVVabjJvWmFBQW9FZnhTSTFQbFd6QnNOOHc0TFFQbVErK1RkbHNYWUIy?=
 =?utf-8?B?VmgyME9TVkZ4MjdVdmxUdncxZzhSb25CbHZ5cFFUVmZnSFdIazR4T1VjdDBj?=
 =?utf-8?B?SzVhZndRV0h1WGc4MmJJTC9NeThCVlB5VlAyTStGUFYzV3RDN2xSZCs5TlRP?=
 =?utf-8?B?ZFBncFN5RWZsNjFBYlJ2aFp2THM2UDlqQTNFU0dGUFdINzBJRFY1aFBiMUhl?=
 =?utf-8?B?L1dVUzM0WnZ5T0lTdjZxVHFCbjFiQ0t4MkJzaTFGcjlLMnU3T0U1R3FPNGMz?=
 =?utf-8?B?eEVWSFZoeUQvVmUway9NT1NlQU1yRElBZ3F1WjcxSDlVVTlES1FGamNiNkMx?=
 =?utf-8?B?dUV5OElHQ0FYcXFmNlpUWkhPdzMxNktMTENrVk5tTE92N1dVVEszWDFZNVpt?=
 =?utf-8?B?WkFhenUzaWxTK3hQaHRLUFNTU1ZLMHI2TTJ6T0p4QTljS1JjR3lJZ2xaemZ4?=
 =?utf-8?B?Q0NXUm9TK0pZYWY5aDlKWjR0V2ZnSnBIZFh5TXFZTWEyRDZDdnBVaVJXM3BQ?=
 =?utf-8?B?YmhLYnc1VDNHeThOYStFQUtFVWh0MjlpeGVEd0lhaEJKSUNnZUFRSzZkUUdk?=
 =?utf-8?B?QTdxdlBhaEg5bXVWTGxJTHNDY0NFUHFCME8xc09ydzVET2xRNjlxN0piQXRk?=
 =?utf-8?B?WjJJNkU3cVFkbVJIL3hrak9nNG1rNUJvbGNZZGJNVnk2UHRqT1RjOWlNNFpJ?=
 =?utf-8?B?Z2wrVXB0SWFJdTAzVzFoREswcFBQMjhkWnFwQ3lsdXBzRWcvYnkwQVVkbFBW?=
 =?utf-8?B?Wk9pZWVpVDBNVkNrRzhSQUlNRkgzcFBoc1dJVElubyswNSt0dnBQQ2N4bXJJ?=
 =?utf-8?B?UlZwOE1lRzJIRW9NRE5xMVZxNjVjQldMM2ZYQkgxdHZUZC9sa0M1YXJIdjBi?=
 =?utf-8?B?blZYRVVCWFNGNG01N1hqYWEyeWQ0T0R4QXVjVHRQOE9nWmo1d2QvNEQvd1RR?=
 =?utf-8?Q?9wZFlfD8kVFGzudLUtCk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7477bb-ed92-47eb-40e5-08dd1ba72ba1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB5081.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 18:51:36.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10133

On 2024/12/12 00:53, Alexei Starovoitov wrote:
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
>>
>> If Song saw this email, could you please join the discussion?
>>
>> [0]:
>> https://lore.kernel.org/bpf/CAPhsuW6ud21v2xz8iSXf=CiDL+R_zpQ+p8isSTMTw=EiJQtRSw@mail.gmail.com/
>>
>> For BPF_PROG_TYPE_SYSCALL, I think BPF_PROG_TYPE_SYSCALL has now
>> exceeded its original designed purpose and has become a more general
>> program type.
>>
>> Currently BPF_PROG_TYPE_SYSCALL is widely used in HID drivers, and there
>> are some use cases in sched-ext (CRIB is also a use case, although still
>> in infancy).
> 
> hid switched to use struct_ops prog type.
> I believe syscall prog type in hid is a legacy code.
> Those still present might be leftovers for older kernels.
> 
> sched-ext is struct_ops only. No syscall progs there.
> 

I saw some on Github [0], sorry, yes they are not in the Linux tree.

[0]: 
https://github.com/search?q=repo%3Asched-ext%2Fscx%20SEC(%22syscall%22)&type=code

>> As BPF_PROG_TYPE_SYSCALL becomes more general, it would be valuable to
>> make more kfuncs available for BPF_PROG_TYPE_SYSCALL.
> 
> Maybe. I still don't understand how it helps CRIB goal.

For CRIB goals, the program type is not important. What is important is
that CRIB bpf programs are able to call the required kfuncs, and that
CRIB ebpf programs can be executed from userspace.

In our previous discussion, the conclusion was that we do not need a
separate CRIB program type [1].

BPF_PROG_TYPE_SYSCALL can be executed from userspace via prog_run, which
fits the CRIB use case of calling the ebpf program from userspace to get
process information.

So BPF_PROG_TYPE_SYSCALL becomes an option.

[1]: 
https://lore.kernel.org/bpf/etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so/

In fs/bpf_fs_kfuncs.c, CRIB currently needs bpf_fget_task (dump files
opened by the process), bpf_put_file, and bpf_get_task_exe_file.

So I would like these kfuncs to be available for BPF_PROG_TYPE_SYSCALL.

bpf_get_dentry_xattr, bpf_get_file_xattr, and bpf_path_d_path have
nothing to do with CRIB, but they are all in bpf_fs_kfunc_set_ids.

Should we make bpf_fs_kfunc_set_ids available to BPF_PROG_TYPE_SYSCALL
as a whole? Or create a separate set? Maybe we can discuss.


