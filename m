Return-Path: <linux-fsdevel+bounces-35238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A69D2E19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FFB283264
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819D1D31AA;
	Tue, 19 Nov 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BqNt5E6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2022.outbound.protection.outlook.com [40.92.91.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4815359A;
	Tue, 19 Nov 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041622; cv=fail; b=jxI1FnD+TrCJkHU0lVgV2Wi8uc1yWmR30eDSwflKgygnpgSavUCF2vVZ+VVqcNj94Js2vj94C4gYo7PPoOjUkxapHW6v9uOIdPU76maYcbnDgcP0F7j5yXrsKRatcAywxj5qKqw1G4xfZ2kQmm6/vZLPmdfjd2Mhctv68Xy+B5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041622; c=relaxed/simple;
	bh=CGJ8LjF4HEpcWPmHzQt26pemfp+RtVTrswX+Q5bNcDs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BZc9n9+SJHRfNhAxcA9kIWT85HTl5ihrtMgNF7up6i84O/nBkH5wumBA4eaPxENZt51lUt7R0z3OCdt6xrUt9dky/Iu47TadiWUD821THrT368LmIc+CZsa+Xy/pw6uiovVBI8UWTMaEfkb89z1N8A+3oWRQuZCQ7FUVOiYDghU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BqNt5E6i; arc=fail smtp.client-ip=40.92.91.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoknJH0q0rgpQUsUqdjH2gOSJUY1Bxh6G0jsJ1E4Xk7XF8CvQrTEMMysGk+JLTccn43BI7j9ngZuUOO0mJbdj6dyK/QYTnjGrfhQCU4kYhQmf2NGVhYTucb6q7VaSvJYKB5/zWYmXg63EF7OmxieBUhDg26rU4wMvPpxS7Hxu0jOmhtXwKqux7sqckZm/T9CGM375LHsY++HOPbmpK9DSmCEpYnRMkV1yDa/GIVkXsffs6t0JfPgWb9gdBIgDwSMptIv1BEK0LHJv1fUDmYz52b95mYCbaVdSmL5M9yBv+JZ+zP6rtm/Qgj3FUw8DKSvoBq5hp/B3jwMdskGMHPjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGJ8LjF4HEpcWPmHzQt26pemfp+RtVTrswX+Q5bNcDs=;
 b=FADatdrXYIQoqe3Isj00b/Ka8ETI4MIPoLs2INAPml30oWI+Q6xzbnG8kQpz8Mk4aEyxnpQ/Ki8LEjszfVtJdRo0WyUEaoPeFzW2prGPdROhow6JrGPBLhO0aTocwt2pqDqM7r8ZPjxvhSV1pS3bezm4QW8f7mGf2zkpl+P0c2DaYb4BvkWN/m9IbKgforajHYZqNf0XALyWVjRen6QL3Si9OsYXWgqEYbO4SPPdoXrMQ/42csxTrtRYVfu8GuxtiOa51L6LoqJ6ZQ2I4EQR1eSmDDSmrg6F2vmfgqxtWcCavH73naXPQEOwZpAilYqpGBOhNPoqcOYE6HvH+/NusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGJ8LjF4HEpcWPmHzQt26pemfp+RtVTrswX+Q5bNcDs=;
 b=BqNt5E6il3djE8Z998yHKi9hLqWFBPzcCa0P/+H18x+pxhqxw6Syas9pogy/IPTV+ZJi8Cgsn4g3d1BFMaR9mHzNALcNWKf7jN+vz3SKuUQ4BV1PJyEF9Pz1wpTGtN5Akvf+oXusKyPenmhrEpAYc0Qv3KVpGEjV7lfSY0yb38rdeE4lm2235MQxo6yRuAie0yMGZCGjE3oPNTIDaqo6U00jDBhBR1rWUnZIg6vqvAAkVSA7NVUKGoJX/21a8T40hy7Rj7bkWeHM6bjQZ5P/jDZnBsYtGC2NYVEUGj5ZTKcZHt0NnmgUs1sS7m+eRqIbOC2jWRUFV4K52sPFeLb/Ug==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by PAWPR03MB9716.eurprd03.prod.outlook.com (2603:10a6:102:2f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 18:40:13 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 18:40:12 +0000
Message-ID:
 <AM6PR03MB5080BCAC62436057A03B334499202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 19 Nov 2024 18:40:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0364.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::16) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <83b8f178-fad4-45f1-87a8-4dbed0653acc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|PAWPR03MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb6c4ce-494d-441c-9f6f-08dd08c99a3c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|8060799006|6090799003|5072599009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0xjNnZnQ3ZhQUZadHJDakNDNU00OWRYbGVSbDFEU2hCbzJWVU1WQmV3andZ?=
 =?utf-8?B?TW4zQ1UrSUVBbkFmcVBjU3lsR1VhaU9jMzVjOGdVWFVDZE02UEd4N3Q4YU1O?=
 =?utf-8?B?ejY3ZElqejFMeEIybVNrajZxYnUwWU1GTStyek11U3N3SWhJWGNyWmhIcE90?=
 =?utf-8?B?NlZ2Z1JRSVU1Y3pLa211UGhoSDhjbXpLQ0NSZGRzdnIxajVHVElKc1o0am1Y?=
 =?utf-8?B?YW1YLzNSME8yM3JNajdydVN4MmdtYVg4UnNLYXVlLytCY1ZKa1NtbDdYMkVM?=
 =?utf-8?B?UlZ6OE9PMDhLZmw4bGNvKzA0cHppOEVRU2NOdFRDcHc0TnRxcHJ0QWRHTVc1?=
 =?utf-8?B?anVBZ1VqN1dNOFBUdDUvZHFMa3hhcHV3UXJWKzV0WUxBYlFwZzc2eVJwWU4r?=
 =?utf-8?B?VGliRlVFSTVmRkhCY0tiUEQ2cFIwR1V3V2k5a3FsbjlyKzhKaGdYVVdCdGhq?=
 =?utf-8?B?V01kL1pJb2NtdDZLMEFFVXJOVlR1c3o0eGNrSmo4czBnbnZENU1vdG1wMEpM?=
 =?utf-8?B?SWZadnVRVUdaYnVtY3M1Z1ZLbnFGa1hIbGlpek95QUJCTGMzOHZiM3p0ei9J?=
 =?utf-8?B?allKTVZDa21XYkk0ZlR6OU4zUHAyZHF2Vmh5QmpBbDBaeVdMeWtxOUJqQys4?=
 =?utf-8?B?UUY3UDBmaVdid1RXdnBYK0E3Y25TRXhJaHM4Wm8rTW1NOURIb0hCV0tGUytx?=
 =?utf-8?B?VW5GVTNJVTFjdnhxMUhZNWNSVWRGVU15VTlSOGFmUW11NWJIdk40SlIxWkJU?=
 =?utf-8?B?WkEwbE5vdzkzMDBvWkIxUGZSOEpab1c5WW9lS0lNTkFMY1dvUWhOSTJQQUd4?=
 =?utf-8?B?WDVxMk5oTjZlL09JTHljYktmUlVWUG1QeGwwY1dkZkpqRFJiUU9LMjZ1T0xN?=
 =?utf-8?B?NFZYbmRvZGEyMUR6eFlXVVVvaGM2S2FSZDFqNHBaQXZsQStCZXRyaUcwSTZS?=
 =?utf-8?B?VHkwL29lVFRDODF1Vk9hT1pPVDFDSG1TSE4wTTJ6NjZDQVI1ZXVKWjl0aFc3?=
 =?utf-8?B?STdmTittT0ZmMWRsY1Z0WW9xM3RwY3pVMTZ0SFJSOHBabFljOXQyTUF3cUdU?=
 =?utf-8?B?TlEwaEtZVzNpem53M0RnMEYybXVkZm5WdjQzWTZVUHFzT0grQzhTbFQzYW9Y?=
 =?utf-8?B?WUQxcGpBTnBTQmJOZzBUVU5qVEJsWitqVCtxcnpiZk9ONzVkQmFFOWpucndr?=
 =?utf-8?B?UXkzOCs0Wm56aGJ0S1lEWXdrWEFHT3NRa1B3RFF0TlYzd1JDenI1bGFoQWE0?=
 =?utf-8?B?UmlxWjNpMURlWERVUUtjcjFrd2JacXdVUDFnaEw1cHd3LzlxSThpYTVUZXpr?=
 =?utf-8?B?TkN6eS9UQ3N0M1ZEeUg3V3ZYRFk2SjRqYmtqTG9wemtSa1VoVkRWRmdFODRC?=
 =?utf-8?Q?fD5ZN/9qNpDgdb2YPAk3pHew4UoD6qzY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0pYYXRRMTVnYUJ0OEtWUzhUS1RQWFkxeFEyYTdKL2JuQmxCaDhBNXpLY2ZO?=
 =?utf-8?B?RTBKVmVqQTVIeVBGTkVDQUxRaTNEbHhXUVgvZExkbjNOcDkzYW9JOVFaSWo2?=
 =?utf-8?B?TlpmcGp6cXNQN3l6aW1GOHJjZFQrcUVwMVkzUU1HR2VyMUhBLyt4azg5Nkpu?=
 =?utf-8?B?QUJuY0E1NXFMbmVRTlRSOExyYVhlQ2hFOEVzUXJrSFM3ZU1NS0pPTzdrN055?=
 =?utf-8?B?YjNlbHFPMGxkZEhxbGVkeG1Cb3ljWTQ0OWliZ25CNFdsell2UFJPTWxLRFQy?=
 =?utf-8?B?Y29VMytiZ0J2bVVEdXVCNkp6OU1IcGVOUFV5cTZNaWtua1YyakVoQzVya25M?=
 =?utf-8?B?TzIxV05vUHRWcUJsZThxZjVLNDBQd1ZOT0NLcVE0ODdXMXpDYlo4Y3BYZTUv?=
 =?utf-8?B?UmZvRHRBTlJHTlMyRitmaDFpeVpnaDhWTWdFNE52ZlZKUENXMDNlYkZsVGtS?=
 =?utf-8?B?eEhkY2JHcFV1Sk9WbXdpRFRhYXVKdTI2MlNlZzJDSFZxRG0xSG1hMTlXbEJW?=
 =?utf-8?B?Ym9zTllIUHIrSU5aRjZlRUxocnVoZEczbHkrNkk3WGlVd0p3YmlMbmQwRUN1?=
 =?utf-8?B?RExPYWdZQ2NpYTVvTVk2S24yYmxrMS83MExualJnS0VKYzNEdGlodUdaSTBZ?=
 =?utf-8?B?T1ZSNUpZZW5OZmc1RkZaL29pViswR3padnlWUGZVdDRDekwxTUk4ais1L0lH?=
 =?utf-8?B?VFJiMnluS2NZdlVZaEcyQmsxcVpGVVZEMEhWOFhHRG10eHhqcGxiMUVjQmxG?=
 =?utf-8?B?eGhyZHdpc1RxM3VBYXpyTlJCZXp0bldHN3RWalN2UThYQytjRlZHaFZlM3I0?=
 =?utf-8?B?K0t0MFlkWU9ubGFkNkhuQnFNM3FRdVgzVXNpYWpab0JlRWt0dGNsTGluakZO?=
 =?utf-8?B?WE1BclI2ZFJwVkQwdDlwZVU1emdHanYvT0drR0g4WkxReDdyRlhVUkVscXVS?=
 =?utf-8?B?M3dmSzIyQ2cyS2IrbXREUnB3ZjF5Wis1QkU2YW9TZlJPblNCMlFTUWhDbG5l?=
 =?utf-8?B?TkU1Vk8zRW04a1NNNUJhZjRoQUFSUDV0ZHlsZGdvcjFWRHkvREljT0VldjRM?=
 =?utf-8?B?cVJ2blFYNWZUQXpHMU5QZDVIVHRGVmRVUjh3UDIvRWhqczlZTjM1bC9xcy9p?=
 =?utf-8?B?bVVEbVE4OUZzQlU3U09ESkw1ZmduaGY4b216QWtZREVpZ0RCWm9pSWh2VG5o?=
 =?utf-8?B?dnArSVprNXl5eG1zNE1jajRUUFIveFcydkRodGJJRDE0WS9xUEM3eG8zOWpp?=
 =?utf-8?B?Q1ZuWjAwZGFxOFVSalZoRFg2ajlNTEFTV256YWwwTXgxSHlkWnkya2lQVGJT?=
 =?utf-8?B?SzJnTitKYTJYR0hMbENYbU9EQ1YxOGFsSE11djFNcU1qbm40MXltei9SQ1RC?=
 =?utf-8?B?OVp2VitGSkJCVTRQcFRRRjVOTkZnZTBqT05PckpMUDV1QjE2b3BIZzdLR0o0?=
 =?utf-8?B?enFNalhoR3dSMWo1RjNnMk9QZ1JiUWJKejArUmU3R251MkhiVGJZdVBzbk1S?=
 =?utf-8?B?NmRaTU9Tc1V5VkdhcjBIa2g3RHRGKzNuZ2FIb095a0d4Z2xOQTNPS3Q0TWFo?=
 =?utf-8?B?Q2I0VnkvNUpLL1IwSlN0VHdrMGZyajlaRXM4ak5SUkdZRlhEV3Bqa2JWQnJr?=
 =?utf-8?B?alJTUXFKMXZTY3JtYzRLY01DN00va2VPQ3BTeWUrZkQ4UWRBd2k0aGNubDVU?=
 =?utf-8?Q?OhZ+5Xf1WeFidLLsJOm5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb6c4ce-494d-441c-9f6f-08dd08c99a3c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 18:40:12.7815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9716

I noticed that the path_d_path_kfunc_non_lsm test case failed in BPF CI,
I will fix it in the next version.

But before that, I would like to get some feedback. :)

