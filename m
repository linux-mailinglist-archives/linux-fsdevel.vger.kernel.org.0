Return-Path: <linux-fsdevel+bounces-39841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EAA192A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC843A06A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C0E211705;
	Wed, 22 Jan 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="odjvKUrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013072.outbound.protection.outlook.com [52.103.51.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3D335C7;
	Wed, 22 Jan 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552862; cv=fail; b=nVlDeimR2xT77L8GjA+74ESfrjZZlRwKb43U7XmqYW8VwPgHqoi+6a1Q0xIfxpTOxaxY+0EPI/OkMenIlCHr2EJtXEMXPzqJQwpEDs6dl2Foc7RRvggFHR5pLNHZQYqHxFlKlN/T9GNhkZrnx+LfZ/0yWMOF3+GC8kpX/rpjV4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552862; c=relaxed/simple;
	bh=jwoF3aLML0QPSZeYqtm8ArRXU35QNFkq5fdIPyZ/c04=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HaqlRYUj7qPKGnw0oxwlqfoLXAwPn6akTZALK3dRY0+761pmILuY5lrC70k9+k4/8SBVRtei7C1FJASTSRJvKUgQfpEYxsDE5LSNUzyKKzolFhJFZoOx9F8xSkkYGXnLpoarTQRjbLA81t5jGmdsH5J39/4Qdck6uPGjkROF62Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=odjvKUrG; arc=fail smtp.client-ip=52.103.51.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKFIzL6c6X31iwIO/tUa0aXRI6zh8e2ihqBQSdg5Zd4ZUAJBvPrJaJvzsvM3uBu/+chH/Rg5skgWlq4W8gCFr7Fit359L34od8vIau5lypkkGfq4x4RbLVLMNdhQwEJEulFvu89IDxsyGEXIR2AIclEtFjSLaui2g8RWLCHTvb3wHHGIHZQclG/DNwJm7IR44FQernykXttxKVHihodYZuy1hJsbPFgGyMVDVI8LuqnSejLi9OWeLoJudz9IwsHFFFm2DRW43un7oZwMgvXdeqvk6/8vfkPcFiJgWMhTEs9GfPywMLDgcLKg3GOuuR/zEyPa78yIxQxWv94tni80Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhL6QkoeN9dXIfBHZewTgtq+Rau/EX6etsRZLi3jQ8s=;
 b=GlKzYZOBdSYjP8Yqf2452gheWzSL2CrgpJNcbPYWCYOC2r5efxpykiVrQB7W/6vKW/q9gGBoQfRZROXmEbHnlOKO4m4dtvF6BCx/4Jhd9jt843IgdjR3OffWekMFHt+eY7kUxHwlheYJFIYobYKM3qr29zjf/D+8D7ZxX23yU6KNZrPvSfb890fWEwsS0E6nLeN9tr2qgjCq51Kk9WlwSmj2jOtJ9j0T9RyYR5SelPU1STP7Nq+b0UWA7nT0o3bFj6v9KlyjDEmvuvVlQi+e4PIXcvtX+7muWb4VDajZcR5nW97Cw/hhdlgeLwYesZT65UR0irRZIB38NQfrTxyq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhL6QkoeN9dXIfBHZewTgtq+Rau/EX6etsRZLi3jQ8s=;
 b=odjvKUrGogY200220/JB2QpArGYmYmMYCNXOqYTW2BxsOm+q0SBJRDLbLjl4fYxUJkOy1U0zIWy3sT5q2N8XA2nP0XFoxgWMljEpScKaoeGFIhM5wpDhsR6wYfKY9E1b7iRLOoBSaaOqJZhvKarCUDMyqUOYA92Z6bpr0rgjMpDDSdYvKe4f6bPyH/oMkxUS6H7EbFg2sMGPKkItLKC/GPyeYtkHmTOC4N5NOTuw/vXGlfhCPxZDd48mOENVhgJvRhjMb6ehbyXNSPIpo5qOl0WBtxGR5jYv/riOs2Th6Rzg8uHLxaYtl3nrX0dsbPpJlZPdLpDFxeJ4FSYvCCeAQA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB7755.eurprd03.prod.outlook.com (2603:10a6:10:2cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 13:34:14 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 13:34:14 +0000
Message-ID:
 <AM6PR03MB5080CDA2F6336B1BA2FDF2C199E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Wed, 22 Jan 2025 13:34:08 +0000
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
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQLk6w+AkpoWERoid54xZh_FeiV0q1_sVU2o-oMBkP2Y7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0144.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::23) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <9a174472-0db6-46bf-8e18-fb03495103e0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 3711c901-23a7-4839-b35d-08dd3ae97617
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|5072599009|19110799003|15080799006|6090799003|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVVPME04Tk9jQkJJUDV5N3NSUTUxTHN3L1ZvSkZqOFdacnRrRVVXVjJHaFlw?=
 =?utf-8?B?a3lQZFVZT0J6L0JGTVp0ckFIVUlLNDMyUis0b2g2R21YYmlFTXMzWlowQkFm?=
 =?utf-8?B?Z2I3ZnN3S0xGWkVIay9mcjB3NlYraGt4UHcrMURMQ1NuQW5acmZGS1M2R3dw?=
 =?utf-8?B?R0JuclRpRndGUUswT2VramlvbmFMaXgvTDhqYWpnU3VnMGFhTllWemdNNHZC?=
 =?utf-8?B?aDFQRUFwK21kZHIxVGFYZEFIYWh5SVExTXFrb0JrcUhQZzNBRWhvL0ErcEVR?=
 =?utf-8?B?Q29IL2lFcVQ0Q3lWbjNYdjM5R3UxcnZ4K2hBVWhuU0xveC9hVXBNTVQxenQy?=
 =?utf-8?B?MDZGQUhVNTB4MGNlVkNZNXVqNFh2M0tpUW9qTUFrTUJBZ3ZSM3F4Uzh6a29Q?=
 =?utf-8?B?ZGs1S1FXZUNvUHE3UkNpYnVyVUxHU3h6SUpxTkJlQ1pWWHFqN21PQTNIcnRq?=
 =?utf-8?B?MFpwQi9YZG5VOFpQTW5KMS80aGtkZ0xldVlRK2V4MXo3WlFpWFgzNjQ1U3BG?=
 =?utf-8?B?dVhQY1RHWXdOVDhSZmUrc2daSXR4WEo1ZStSYUIyTnBGSytPcVdRNU55Q2RL?=
 =?utf-8?B?UnJCaWRJL05zQ0N1SlhaaHNYWlFLd0lSem93UlZmTHRGa2hDYyt1dmg0cm12?=
 =?utf-8?B?NDQ3YzUwNHQrS0QvUm95MUhnVTZwaHFuVURYL0wrUncyT2M4akVPZVhwelVJ?=
 =?utf-8?B?c1lPQ1grZFlDSCtkcUM4UFllSmExQTA3VTJudUsxQ0lzVWxmdFpkTXFrZ29M?=
 =?utf-8?B?S2p4Q3JWeFpveXBpUUpUZ28zREc0cUVOZEhBQUhVenJ0dEdnR2hkb3N3MVhs?=
 =?utf-8?B?dHcxLzZPNWpwOXJiZVNZVDN0R2sxaXltMys4eUpJMFkvNXJKRXZPSFFmQWZ1?=
 =?utf-8?B?VXo5TEZVQS9kOHR4NzQyZ25JaGRmb3JqR25QSVNGQWV4aWZTVWdmaU56K3E1?=
 =?utf-8?B?TnE5S2pETWxSZ2tBTmxjdCtPVFQ3ai9CemdqbmExTmZ1b0wvV1lTQzBVRWhX?=
 =?utf-8?B?d0V4TXh3dWlOejltd0VTckRSNXY2czd4ODJGNkN0YmFNdlZJby9BU2V5QXFx?=
 =?utf-8?B?L0pXbmd5bUhCYmlaRTc0dUZFdkNmaWg1cnk3eGZlRkh4RU16eUtCY3RReVhQ?=
 =?utf-8?B?QUN5RGFROVk3MFNWNmh3U3M4UDNOaDRJemhJeUhRYkoyL1ozL2FDVlRhOVpW?=
 =?utf-8?B?aFovTFpkaklLRVo2ZnpaeEFCOXRIZ01QYWJLcU5IbFNBLzFSZTBsdGZyRUFW?=
 =?utf-8?B?Q0R2cVhMdklHMDV3SFg2MTRSNUdaUS84T0R5SnBvbzY5S25EdEEvUkVxNVdN?=
 =?utf-8?B?YW1SekxvQ1dYQjE3VW94dWg0eDJ3UG52aXBndllOUXFJMTQwSWpZcGxhbkVl?=
 =?utf-8?B?cDlFMWh0MmNqcjlZaUVxM3diUXZhRjNmQS8yN3ZJZEptY2c1K2JlQXkyZVpZ?=
 =?utf-8?B?Vittc2x5cE94elc2S2xNVy9ackx3MmoxamdoMnBjajdJNzZPM2k0VlJHUW9I?=
 =?utf-8?Q?yFcez8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmhoY0Z0ZVp2M1F6SkJJdFNUYzArdWVJMnJwRWFydDIrdmxCeDhZRWREZ1hX?=
 =?utf-8?B?dU02SWdQZ3NDUERiaUpmVmc3RWFuUGFLUXZSMnRXd3JVZnJmTG9hdmlGaHhQ?=
 =?utf-8?B?d2FQOVJsRWhZTU9jTGdVNlc2QmdLN2xzTDRkUnBTbEJGN2c4Q2g0bXFrSTU0?=
 =?utf-8?B?c0dqNnFFUTBzclk4eGZSUklhT0pPcVZEOEtNYXZ5MWQxSHI5TlJMRUdFaGtt?=
 =?utf-8?B?ZHp0eXJjRndCM0k5ZUE5MjA1RnJrK2hoUVhFenVjUGZ5WFcwNks1dklJVHkz?=
 =?utf-8?B?NzUrbjd1eGhyeC9KMlVsMWJGKzZJcHB0bnlVOGoveHFwSUZnL1k0ZG95Nzd0?=
 =?utf-8?B?ZFlXR3ozRXEySE9OQ3VISlRoVkxtVXFHcDF5YVk1SjBFdXdtVGRXVFNidE5V?=
 =?utf-8?B?MVJ6Z2NjN0dnb0J1L0toYlFVYTlNdGNoRlg5cEJiVVZ3Y0RmMmZtOCtqWHBz?=
 =?utf-8?B?QXAxd3RxQnpEN01BTi9FSzNVaStBWmFQbmYrTytWMGdJN0NobjRJNU05ZzRC?=
 =?utf-8?B?U2lQbko2S2Fxa3E1M0xqemh6ZDk2K3d1QktrYk5DakJiQXM5TUtSeU4vYmdH?=
 =?utf-8?B?YkhmOXBzUW93dFo3UWZGRUpIYmMrcTd2bkJFbGI4M0c2T2Q4a3FITXNoaFdS?=
 =?utf-8?B?MGFQNEw2L2h2blpuYVE1ZkV5SkpRaUsxaG1aWnpTK0JQQ0VYS0h6bTdzcGZa?=
 =?utf-8?B?VG9KWjRCRlJpSWFtbEI1OVlicFY4TXRnK283QVRyY3pLNzhNOVR6dmxCNWxB?=
 =?utf-8?B?NGRxTk42aDRWZnZrblluQllXV3JLZG92bDhINFBUVXBkOVNJbCthUERWdisv?=
 =?utf-8?B?NzBTVSsvbUZlKzFycGtMNm9EQ0Q4NXVkbHIvMGxtdGRENGFUcWgrRHVDTTNU?=
 =?utf-8?B?WWYrRGhQUkJLRW5CNlVXRlArTVpETUQydENMSWg4YXhKNmRIVFNrR2dnN1hN?=
 =?utf-8?B?cmxMOS9BU2NmL3RxbXpReHNESG1xcFRRTmpJUHJwR1E1Yk5CUk9YWlhKUi9s?=
 =?utf-8?B?ZXNxTnhZcUJFSU9KaWtIU2dRR2FXc05PY1hJTktFNkxXNE9yemZwKzA3NzZs?=
 =?utf-8?B?dHlxS2d3OTJqQlNtbzVSNVBGb1VoOU11aWx3YlNhNHFMZ1JUQ2JvNnRka1dU?=
 =?utf-8?B?SUh5VlpNbXRsVjJDSzJ2a0h5YjN6QnFjWGEwbEhVYkE3Mjc3NEYxcUZPNWJL?=
 =?utf-8?B?WWZzR0czN3V4VEZhYk1nRlBTT01MNWVOLytaajVsaVkzbUJBTlU1V0pJbjk2?=
 =?utf-8?B?endVRmY5dXhXS0VtMDRBK2VtbVh0eFZCeHVyemlyUTBhazNYbk5QTWt0WGht?=
 =?utf-8?B?K2JaZ0MyRWpndHNoZ0xkOXNhTkNtWGRpa1FUVEFXUW40TWhPOXlMRWdocmtS?=
 =?utf-8?B?NTk4VmR3eHdNdWt5NlVobnQ3NDAzNGRVTjg3bE9lOGdxeEVqb1liUEJSMFJD?=
 =?utf-8?B?RndzZXk5V01NTFV2dW53eTN4OURZMEVuaHZmNnNrc09SdU96cVRRNy9sWmha?=
 =?utf-8?B?M1diZWZCRWt2Uy9YcVJleDJSRDI1TjJUZjRXd2gxVXNtS05PSWNlamRiQmdv?=
 =?utf-8?B?cnVHQnA3TVNRN0JMVWhsTnpNa1RGRkFLdFpDM2thMTcvaGFEcjczWjFHS1Ar?=
 =?utf-8?B?NFFCZ2RPN0lEY0x2dllYVlArcmxTMGQrODNMdXFHTFMwVXhDcEZ3dzFiMW9C?=
 =?utf-8?Q?UJQFV8H3aRIRbcn66OqB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3711c901-23a7-4839-b35d-08dd3ae97617
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 13:34:14.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7755

On 2025/1/22 00:43, Alexei Starovoitov wrote:
> On Tue, Jan 21, 2025 at 5:09 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> Currently fs kfuncs are only available for LSM program type, but fs
>> kfuncs are generic and useful for scenarios other than LSM.
>>
>> This patch makes fs kfuncs available for SYSCALL program type.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   fs/bpf_fs_kfuncs.c                                 | 14 ++++++--------
>>   .../selftests/bpf/progs/verifier_vfs_reject.c      | 10 ----------
>>   2 files changed, 6 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
>> index 4a810046dcf3..8a7e9ed371de 100644
>> --- a/fs/bpf_fs_kfuncs.c
>> +++ b/fs/bpf_fs_kfuncs.c
>> @@ -26,8 +26,6 @@ __bpf_kfunc_start_defs();
>>    * acquired by this BPF kfunc will result in the BPF program being rejected by
>>    * the BPF verifier.
>>    *
>> - * This BPF kfunc may only be called from BPF LSM programs.
>> - *
>>    * Internally, this BPF kfunc leans on get_task_exe_file(), such that calling
>>    * bpf_get_task_exe_file() would be analogous to calling get_task_exe_file()
>>    * directly in kernel context.
>> @@ -49,8 +47,6 @@ __bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
>>    * passed to this BPF kfunc. Attempting to pass an unreferenced file pointer, or
>>    * any other arbitrary pointer for that matter, will result in the BPF program
>>    * being rejected by the BPF verifier.
>> - *
>> - * This BPF kfunc may only be called from BPF LSM programs.
>>    */
>>   __bpf_kfunc void bpf_put_file(struct file *file)
>>   {
>> @@ -70,8 +66,6 @@ __bpf_kfunc void bpf_put_file(struct file *file)
>>    * reference, or else the BPF program will be outright rejected by the BPF
>>    * verifier.
>>    *
>> - * This BPF kfunc may only be called from BPF LSM programs.
>> - *
>>    * Return: A positive integer corresponding to the length of the resolved
>>    * pathname in *buf*, including the NUL termination character. On error, a
>>    * negative integer is returned.
>> @@ -184,7 +178,8 @@ BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>>   static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
>>   {
>>          if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
>> -           prog->type == BPF_PROG_TYPE_LSM)
>> +           prog->type == BPF_PROG_TYPE_LSM ||
>> +           prog->type == BPF_PROG_TYPE_SYSCALL)
>>                  return 0;
>>          return -EACCES;
>>   }
>> @@ -197,7 +192,10 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
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
>> -int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
>> -{
>> -       /* Calling bpf_path_d_path() from a non-LSM BPF program isn't permitted.
>> -        */
>> -       bpf_path_d_path(path, buf, sizeof(buf));
>> -       return 0;
>> -}
> 
> A leftover from previous versions?
> This test should still be rejected by the verifier.

Thanks for your reply.

Not a leftover.

bpf_path_d_path can be called from SYSCALL program type, not only LSM
program type, so it seems a bit weird to keep this test case?

But if you think we should keep it, I will keep it in the next version.


