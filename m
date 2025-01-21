Return-Path: <linux-fsdevel+bounces-39783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59158A18109
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504F33A14B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262BA1F470A;
	Tue, 21 Jan 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eWQEqiIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2040.outbound.protection.outlook.com [40.92.59.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219623A9;
	Tue, 21 Jan 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472856; cv=fail; b=Q4+1ewnbfO+kmGrp9I/GmqCsWIv1bCGsypKDxl1E75Ez6ZQR3iGuQ89ygNfZg/Rwok4DbJZM1l3P3/ijdzCvCuyH3n/SJBChBupbXmwIhgKfOUp18Sm6p3ujz6C29gprjlqEKsUyyjBm03UyRQltZVEji7bTxcAkta5OFHvfHc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472856; c=relaxed/simple;
	bh=gOBR+x1ileBf2rjvyqghSd0fRPwnzwaEbFED9yjsTrw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YuyCb/lreVYolrMZzBXzBV7iDT7TGn4Nj7EI/R/PFIFyxtJwqNFjZRbXs8TE4KBT+3fnyEr/AQ4uwUiP5I6wGxAitaFZHp8XaiL4OvZaWUbmIBU5fwB1xk842SXA3sKy+rj2+kRv1mMHlf4sHcWOZbkztBfosCVBjAa4A9fZJMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eWQEqiIM; arc=fail smtp.client-ip=40.92.59.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHHITXXlPWRXYvrm5v+FawOWJ/2IvMlAqhG4wRQXGY1E63dtR+TEpF1fIG9Fu1agsSSR/Rqf4hgspFs+QA3y2Dj04Db5PIckFv6c5KviQDfXqFfXPsTFAiF4t8ce1uiIOGcGV1Xs9vA2nROMss2ipFl6w6YNHDufLV32GZ/spual8PVVCtjdRW4KeS5InBjcugOyo/rO8CA8L9acsaPLm36wFfqJPwcNjShmFO74oaoxPO69TmaOW0k+hAheKt+zVaBtGXLf0qyAG84Tn7yW/SNFWTOpzFbU83RELszW2NurTAIPzlSVmzcwjtFYcedhHSs2DmORpF9kWJF4Vb+jDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF9pnd/FhAHOMhWcYQgh93fJVZ0SfWpgTzmyOX/guQs=;
 b=fAVwRuorv6AquOTJ63V2T6D5tk6WVKum+mVWqF5lck0o3wFm4txmc/UfkBAj7PYC+1Ah5Q6bAJrcFoZAPPRgIwi0KqaA/D1iB7FXsDoJNdn5LZaVcQG4HyqwLA8JX4dZTLbPI83djL3r7oBDgcXh9Dai28tEPhTLmw+ndhyivxwmaBOqc0zt7BPMiIm9nLuHBp8RvXlt5OmSeB2NLMPaUKtnehAoVpzOsomoB2T55TdZzHnTy+mD/U6eX9BWdYgzwNp6pMLjbnXR09kqdEHsdSpJxsIjI95Hhn4dxTUmREqY8Al3O6xMDhcZFAQdUEB7JV0TlEeBjRypV2ZHbvIBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF9pnd/FhAHOMhWcYQgh93fJVZ0SfWpgTzmyOX/guQs=;
 b=eWQEqiIM0l1WTt+K49efx8Sk0kvYIFhGyY9BblE0LeU//rQUUoilVUn6wYcAw24/hUOthmZUpfoc8H4DjSb7bCeF0gkCrMyup/iFqTEdrO0C2wfVe3oARbiEFySbNm7XuOLPvfQl5K9bkzcD3Ge/KPGhBVa5iWYYBtefPPjNL1gZtUTFfZu4EONf6G4uABTHu7ws4qHnnhznalFsBqc/qCHww/y5xaY5RwmXwi9ashZq4lqDqMNBZecBm2D8tOSoz16VCTN4E2tK0dxlz/Y1B18zqvBU7+ukolFXC2zoNvDwm3ANaGdDv+Ec0IFOuObgPqmwCZ5tz1RiVtu7WDiYCA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM9PR03MB7630.eurprd03.prod.outlook.com (2603:10a6:20b:411::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 15:20:51 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 15:20:51 +0000
Message-ID:
 <AM6PR03MB508081D38D00CD4AC299A8FB99E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 21 Jan 2025 15:20:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0331.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <e0eebb99-7ec8-4810-a2d6-b64926b2550b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM9PR03MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: df7c3f56-6b67-4abb-3e8b-08dd3a2f30cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|6090799003|15080799006|461199028|3412199025|41001999003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHQyRnREa3hMRm0wblBUVWE5NGZpWmhlMGc5UVd2RWRhR2VFTzZJSzdITVNI?=
 =?utf-8?B?VjVPQytNMUs5UFI2R2NqYmJuZFFETk40OGhyWlpWSUo2Qk1QMW5ySWtMN1Vo?=
 =?utf-8?B?Vk9GbmNQcnpVKytHY3BWUG1pSHc4QWdiMnhnMG5KaUpTNGFjalZMR0dreXQz?=
 =?utf-8?B?T0pDUU5BRng0MU5SUFhwQ2phVkV5Vk1mSnJOM05sWEVPUG1IRDc3dUFSa05w?=
 =?utf-8?B?ZkNIVi9TSXMwRTBnaHFEbkVjS2pRdENzT0Z6RzJNNVVscGN3aGRGSjJYM0Ft?=
 =?utf-8?B?MVVlSFVvcEVtNm5xNEJHYnRxcGxZYzBVY1ByUjdUUVVFWmdpdFRCc0NpcGZN?=
 =?utf-8?B?M3EweEVWdmpVUHdJRHJjVXNRUTc5VkMxY1liS2hpSkhnL0RVdHlnMUJBaFAw?=
 =?utf-8?B?S1J2c1FRT3FUdVVGdUhYUCt1THRCdTZmSElNK1Z1MlBKaGRncEtXTWV1RE5k?=
 =?utf-8?B?MW5lR2Z4SEFlbHhxQXM1dWtxSS8rbzI3NWZlODVFT0xhTm16ZHVObFRvWm01?=
 =?utf-8?B?MzA2Y2FzY3ZZYWRkZXA2OEhDdEQ4Q05XNENmOU9vYmcwdFZKbk1hSnpEYjhK?=
 =?utf-8?B?cHBmaFFDNGRnL2NwL25xOGFCWi9CaXBmZ0d1aVFBejJ1TWc4MTdSM1lscENw?=
 =?utf-8?B?UmdQbVdBcVdpTlZkSnJ4ajBFU0VNK0lOeWF6SEV3dWVLQzJ0N2NnUmJTbExL?=
 =?utf-8?B?cndqcVQ4OFJJaUhIZU5TOEJNNVJEbG1GM3R4alJlZFhPdHZ2YW0rZTRyblVM?=
 =?utf-8?B?Y2M3dHBJOXE4Ti9PZS9HMFFHVk1qTHBlUG1MSm02aTl6VnBPS0l4dmFkYzho?=
 =?utf-8?B?OW5wbXZ6bkVnOTl1TjYwdEhMMXJFZlhsM0J0WXVOeldxSHpnU01WcDJyc3ZO?=
 =?utf-8?B?ZEE0K0ZTeThOdXp6VkRGZE0wUGE3bSt0cytQNytQYUUwVVl0SXoyQlg0TjYw?=
 =?utf-8?B?NXFXbWRPSW5DNE1aWHJpMi9pN0hYN2NyZTIyVnN5NFVCbUt1aEQvZDFwb2RH?=
 =?utf-8?B?MG42KzFNNU9ic1NKbGYzUnNlL0xRQlBpNGI0QlBTNkQzckc0aFQxLzNOeE5z?=
 =?utf-8?B?NmVvQzZ3UFVwTUk5ZlV2TXoxdXdLeGUzUzUxT0xpZE1JVDcxdG1lR1kweU5P?=
 =?utf-8?B?WkZudjM0bGxaK01zMnBCWE45dFp4eTJPSlAzTE5xeDBNaFZQNXZvNmFwOWFy?=
 =?utf-8?B?QkZVM0xsem5xWm1ZZkJBV1oveUc1WmRxWUZWWld1ZTFYREYyOXpXbGpjcHVY?=
 =?utf-8?B?RGRYNGh1bUJxTWxOYjlFRGhkNFpwd3BId3NQSGNLYXdQazRTV0J3MEE4QjdN?=
 =?utf-8?B?RkpQekZZRmgvbzJGVCtCY2pyOXc1WG1tUFVORERhNU5ldStJaEwxSC9WR1Zt?=
 =?utf-8?B?K2doanBCOXFDbkJqMGRSdkdSalIxR21QeDgzUm1xMlVubHdlMjB4SEtTVEZL?=
 =?utf-8?B?d0puYzBvU3dYUGc1M3Y0U3F5STJBanVONlc3WXR6UEFlWEdrK0F6VFl5ZUpF?=
 =?utf-8?Q?bCAGrg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0VzamsxRHFQdTJyNTRPenRrcDRBVUg0OHZ6Y2xqaE5TdVl0cExIT0NWbE10?=
 =?utf-8?B?MXFRUk1kYzY5VVRvVi9WajlMbTRLcUZQYVNXUktPcTl2c2wraStYMlV3bHR1?=
 =?utf-8?B?UGVqZnAwNVNEbUN2TmFtVUhRTXBwSUtKcjdaSHgra080NlJSRWo1UXVicGFL?=
 =?utf-8?B?SmNMeGhkdzliUlFuYTJmOHQyNWkrVDVhYWRNeDRrUitTMHc5MGtxWThlR29D?=
 =?utf-8?B?cHFCK1hmK2NxNmFyMndjbFNLMmxDamZoSHlGeXVaMnBGSERiS3hBbGVFODky?=
 =?utf-8?B?RTZXQkpqMmFIS3ljclhNZitjWEowOVZTemo5ZGJYZG03b0VpTm1QNVI1SWky?=
 =?utf-8?B?OHp2eXNXK2RoL3VUNXdWcHdvaTRFTG0ra2ZhWlhlMGlsTys3YkNxK1VpNEJs?=
 =?utf-8?B?dGVOVVZNeS9pS1VmbE9nOFJ1TzJTV29tUjVNTzRyelM0OW1HbUFPZGFPTElP?=
 =?utf-8?B?aGJsWnUvdzZ4eStxN3RRTXZITldjRWgzTVFvNGFRdXpIaUd0andsRXFnbTdr?=
 =?utf-8?B?SFRkS2s1dzhSbHlLczBzTDJRdW1lVVJxQkdyV0RCSjJybDVkOVozTkVieitV?=
 =?utf-8?B?ZjdVaGJISnBaSytxaUZQL29JbytWUEMrcEhxdjZ2Mmp4Z0hEWXlHUXZSVTFX?=
 =?utf-8?B?REpJSnFGbnZzL1orSEo4NVVNc3RNb3ZoSUk1OWQrdk1na0hBVTRMV3cvajhB?=
 =?utf-8?B?NWRpMGIzek96d0QrVUpTS1Q0emJ2azZoMjRDTWlnWjBYc1F4SXhLSFcvUmx6?=
 =?utf-8?B?L0R6R1dnaFcvS1k1UWprTGRJMzA2U1RaZWdaV0p0S1liNUdGOVdReHgvSDJh?=
 =?utf-8?B?V24xRTBQUWl0ek9EaVFiQnIxVG8xOGs2US9XTE5DdmNiZnJVclRhQTNqVVA0?=
 =?utf-8?B?YWFRbFBKWks1NG9jUUIzUU1oZlNBLzRlS3ZDTUpLUU40ZmltakVxUWRqcG4x?=
 =?utf-8?B?U0Y0MVFocTV2K3M0WlhQNDZlRnpWY3kzU2dHOW1MTy9TM2JKZlpFQVVQZ3FI?=
 =?utf-8?B?SFdTOXprUzQxZzY5SHZJRmdwWHdxTTY5RzRpalZyTXNZU2JqQURFaUtkTDht?=
 =?utf-8?B?Q0xlZ0JNRkNXS2dBeVA3M2RTdjZPSXFsaURHWVBvQU45QVhCTXlqUU9Kbmpy?=
 =?utf-8?B?amI4MURvUGM5YmIzUkVLWTlpanNEQ1h6WW0xS0gwQmRxT2RZMW1mOGlpWDJa?=
 =?utf-8?B?VmFVUm1vR1hXVndqb01GTEhwYkxFRW1WZVEvMXlFUXllUERlcjUra0xTS0Ey?=
 =?utf-8?B?UnExUFBYQWdhQXVKWEE4WEZQNzI3dHFDYWRYYllyOEZRQUJURExzci85Nm05?=
 =?utf-8?B?SzVqa2dPUTRManU2Skw0MlUwbUNOVjlXZUdKTk1FbHlNQnEwRnczZzdIc2JK?=
 =?utf-8?B?S293Yk1GWG9iTldibUFpNjlseThHZVRnK2VGYktEUkZ4SEloN09aQm5BN0ZY?=
 =?utf-8?B?UmpSYVZaaHJULzZFMWxNalhHUkk4cHQrVFBOdUxBYlR6ZTRFbXlBUit4NnFh?=
 =?utf-8?B?OHFHZzRwZWViVVpmUUpxRWhhRHZCSUdhQ0I5ck9OeGRmR0hZMGd5S1lSVGFQ?=
 =?utf-8?B?UVVXanJDNGVtcGZhN3BpWk5SWTJZVGhjZzZlWEp5T1g3T0E0WXZjZ2lpN20y?=
 =?utf-8?B?dDNDcFdNaTAwaHdlMUJLZVdENHpGd2QxaHdBb1k3WFg5NGgyNENYUHFZb3By?=
 =?utf-8?Q?tq0C/w8uF4PZw1jycnkx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7c3f56-6b67-4abb-3e8b-08dd3a2f30cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 15:20:51.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7630

I noticed that the errors in Kernel CI

progs/iters_task_file.c: In function ‘test_bpf_iter_task_file’:
   progs/iters_task_file.c:43:33: error: taking address of expression of 
type ‘void’ [-Werror]
      43 |         if (item->file->f_op != &pipefifo_fops) {
         |                                 ^
   progs/iters_task_file.c:59:33: error: taking address of expression of 
type ‘void’ [-Werror]
      59 |         if (item->file->f_op != &pipefifo_fops) {
         |                                 ^
   progs/iters_task_file.c:75:33: error: taking address of expression of 
type ‘void’ [-Werror]
      75 |         if (item->file->f_op != &socket_file_ops) {
         |                                 ^

These errors are caused by -Werror (treat all warnings as errors).

In this test case, we do need to get the address of void type.

