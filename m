Return-Path: <linux-fsdevel+bounces-36955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5379EB624
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E60E28128B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3521BDAA2;
	Tue, 10 Dec 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="e4VdnEue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2038.outbound.protection.outlook.com [40.92.90.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04219D06E;
	Tue, 10 Dec 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847797; cv=fail; b=tuFlK3J5yYY6HzGW/m1fpPTGMbbnmppFNmWPWuVfS4qgXL6/wSnGssxwFrXzfb/yoyqWPl2tRgYCT2yUfzMToqq5jmUD266MR82WCeePFqL39NlEY0tBdsKqsYh7rSBPtlVryztALnScp/QWA8I7bo1SffFgPnMab+JkqEQr1as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847797; c=relaxed/simple;
	bh=u5cGNKz6aj3lt+RRF0uKni8gKHs3YoPTkfRYp1kbIQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=myzHjYM9FIYY8BqiXJXarkDLXBnMP+yem+gIBdxpaXS1SlZMCFUAhCU/BuVUQt2ecMD6gNFpyIHWjtAkhS/Vj7s7YF7B9lSBZOki1v5EX2W1ND0lLAnAEW6g2Nnqns50LUEzQeSiIbGRohTGE29RyfcoMx+L7YNaZf66GAHPYyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=e4VdnEue; arc=fail smtp.client-ip=40.92.90.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSbGHvS80sTmtOia2uQPlkSvWzAgxuhTetT3vVIUI7SE+tlDVdOUShTNVHuVkyG1IwcLUZnew6G0TFRi2zZ5Se4o6df4EfHSRLk9wUE1BYL+jLPpbGLaKY6r5f8caNrq0n7BWO6qKM7UtyH7qrGxLG8/R4OAdnaE/xMty2L+yi2mlz/dJ/cdHnoLf8PgcIvMYxU26fmProy2Cy7eTRLbygnEffOOm8Dd1Fh8D9+CmrBIbQ/Ek1IG47YaE4FeC77DzO+Pgsn1fGo8gV6OGrDnixFZXaY6l5Y1f8/Ycp6vdmSzrSuw9Y31r85PTMOGHjPOTdMg6XB+ufVGpWsneB5XyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgY3z3c4t2J2TvV2rWtgAn2WTZmZ60AkzlFXY4InlEQ=;
 b=ZcFyTDRwpUCRyXW5VrX+rdb5hnKhAO2LodsEY6RqsGQJfCWT4w3G+DxN+EOrHC1eb0ZjKIj5Frh5YFCTGQ+Jwfii6ot6nWTIhw4lGiF9lAJmXaEXCGHMntirdyhCvsTmgagGGxwcKENvhpkbx+rAGE+4CsD9sJGnc0/qyfdiRR56ln0vopNFrQ727A2LjgrS9MMnW85lnopmgdXNYgFUvyCYAFsif9pX4DKP/HnjBNFC25PZOjtjXmXUzjOfGI2I1AGYFKs3aHuwg0PwXrTrDI3xVanGOB0M1cgf+MG0EwziArQ1RLByem6G5/Em1+BdNWv1+erF2pxyGOKGm/PPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgY3z3c4t2J2TvV2rWtgAn2WTZmZ60AkzlFXY4InlEQ=;
 b=e4VdnEue0hfhXdm5ph4Qj12xU70dkDHeFT18WAgyERAgeJwASDlgfApg0w8vwTNX3Xlnqxa+2EAuFWYSOZnSd10Q9vRhvgxgYUM4pMRK/FrUILthJyxOdsFseG1oT9S3wlmZDxtOi6W/6v4oOJtzKvg5MSY1Z3lW6rcR8F/aTvuGpQ+1ybs2Pc/LMLWeCE3+hji0gOsid7wJ7cdK8yuaLWCeyl3Kk0g7HqdM83GS+WBwUJE7zhY4NuPg1qs+AGqfaSCu/vhAy8n0Y3wE005oclK25hB90R7lQKDpmDYoS1Re03fGwvbEzThcN9eucoItd8hPgEI1SxBSaLzuSzFNuA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS2PR03MB9671.eurprd03.prod.outlook.com (2603:10a6:20b:5e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Tue, 10 Dec
 2024 16:23:10 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:23:08 +0000
Message-ID:
 <AM6PR03MB50808A2F7DEBB5825473B38F993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 10 Dec 2024 16:23:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/5] selftests/bpf: Add tests for open-coded
 style process file iterator
To: Christian Brauner <brauner@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080756ABBCCCBF664B374EB993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-zustehen-skilift-44ba2f53ceca@brauner>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <20241210-zustehen-skilift-44ba2f53ceca@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0366.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::11) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <0596bc66-c3f2-443a-a83b-b2c58085c3c7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS2PR03MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf35194-4e4f-4ed9-e00d-08dd1936eebf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|8060799006|19110799003|5072599009|15080799006|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFh1UG9PcUV1c3VMTEhWbC93bVRRb0xHSi9vbUFjWDdiZjZUWld5QkNiL0Nn?=
 =?utf-8?B?ZUdQVUdYNXNWN2p1MVgwM3JvQkFZNW1TeTlJWGl5NWxLdW81Smw5d1dUVmN5?=
 =?utf-8?B?aTVBckh1NnR2VERYVWhyQ1V5TldoS1F6cVF1SHVtQTVGM2tBNTBXVTZpRDYw?=
 =?utf-8?B?bTcxQVQxeE1RNlgyUTJqZW14WEVEc09aK0RRd1lmc3dSeE9DWThsVTJ2N0sw?=
 =?utf-8?B?VkpYb0l4TTIvSjhxSUtyOExhWHNJandmNGx2S1J6eWoyY0REajc4aXMvcGpw?=
 =?utf-8?B?SHpWYVg5bDhQVC9jcHJoQTlBTXJYMTFlR1BlY0d2SkthZ2RLL2F2b1pTdUw5?=
 =?utf-8?B?Z3hNc1lCcWpLR1pBMVpzUG00YmQrNEJzNTZySlBmM1phZmhMR2lHVWsvMGUz?=
 =?utf-8?B?Yi9wTFNzYlArTmZUTGRmMzZxZnhxemN2dU1HMmdtazJBK0dLaitiK3hrSnNm?=
 =?utf-8?B?WHByTnYwc0YyaldkVEFKZmxkZkxCRjJJZXFCbVNsTTRmQmtjVXkrRmlZR3R0?=
 =?utf-8?B?Unhrd2JCdjJsL3NBblFsWEtjdGFLMm9mWHA1YS9sa2Q2STVkc0xsZmtZM2No?=
 =?utf-8?B?ZHVVQVZNanpseEZ3VHd6Z0doT2x6QjZRZFZpTlhmWktmYnMrT0prQzhBd011?=
 =?utf-8?B?cWh6YndKY0FhNVB1Z1lnbERGVnZPckhHYUdRUG9QWnRzeHJNanF2NzhCdTZQ?=
 =?utf-8?B?cWVmR0VmcmdoOGw2UnRobng0YTZFUU54MDA4eFBjYnNDaTRmUnFTNmpTTTJE?=
 =?utf-8?B?NnVkdXZLN3FJcktkQWVsY3BqdGZQYzJ1eU83Z3g1SzN1aGJNcjBzeWQ2SWo2?=
 =?utf-8?B?RDk0QmIzSzkwbUVES2cwOXBnZVFQUFhiKzJTKzEyYWNEZDJxa2dkVWtQQzBw?=
 =?utf-8?B?bDdzem5hRHhrWVNJbWx5Z0Rod2FqYW1sb1h6VVlxK2kzNjluTUV3dDhVUEdO?=
 =?utf-8?B?VTdjZ1hnTTBXU1NPL2Y4aW0xdW5JdEgxbEw5Q0VFNnh6MXl6Z1pIYWtSL2ta?=
 =?utf-8?B?c2lrOXNxMFU2S3A5SnBWZGR0bkZzcHN2TUlZWkE2STJNTEhSZmFWMEFwTmVI?=
 =?utf-8?B?SllvMmpmbnA2TFI0NjhqSHJCK1EwYXBBRnNma1l6a2o5b0d1TE5acURhbmtr?=
 =?utf-8?B?eVRSbDhKN3p6bk04UWhpeGFQRGdDNmsrOE1QSS9tMzR2KzZQemhLUGZXM0Rr?=
 =?utf-8?B?RnJ2VUF6MzZsU1A2eFBNYmNQaXRyZGJKcHF3a29BdUYzRnRycCtlSDRFMWJm?=
 =?utf-8?B?WE1NRTgvd3hqQ1FUZmIwUkZRbXpnZkNTWlFTb3BabS82K29adi9TSURGMGJi?=
 =?utf-8?B?SkV6Sm45aEREcjZ5Z3VBbW1kaVJ2Sk5SRWpuTUR3bWZ5bVlJU2xPa1lpL3Nx?=
 =?utf-8?B?d2l0RDNWbEdMUVBSdGlVUjhXWlJndHN1VEJtK3l4cWlzRmxremQ0WERVT09P?=
 =?utf-8?B?WnI4UXlSbU8wcS9VS1FmRGxvOFNOMW1ZTklQTU5vWXZzL1ZwczNzU05OQWRz?=
 =?utf-8?B?VmliQ2JPZmdrQWlELzFGa25FQWhPWXo4NmZ1eThiOXRpYnhleVpsUGp2UDBV?=
 =?utf-8?B?RE5Xa2JSR2JEb1VXQVpnYnNtS3I2T2xMMmplY0FiL1Z3cUpjeGFqc0Zab1Zr?=
 =?utf-8?B?OUJRakNLbmh2MjluOFZyUGFkaDQ5NFE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnI3Vkl2THR3WENkWTQ2N3ViV0o1ekJvWnVVNDMvNDVnZEczdG1nbDNtRjI0?=
 =?utf-8?B?a2sxNGNad2tnWVF1b3pBYUQzclQ4L2pPRk5aSjVhclpSWTRWV3dmNVFuM3dq?=
 =?utf-8?B?Z1cvWkVLMDkxakxZUzZrb3I0cmd3TDlTRS85ZWxIeUUzRzBzc3VSNTMzcmR2?=
 =?utf-8?B?TDFmUDJkK0g3M2d5MTQ4ODUxNnlqMUlEMXFKc2RkcmpTckVmaTVnbmtZNFIv?=
 =?utf-8?B?czUybHpYdVZ6azRTOUZsUGsxYmJkbnpKZGZZWENXK056Y2RLKzZTRkM5VGt4?=
 =?utf-8?B?Y2s3SDBMV0MyMmdWRFpuSEVwbG9LU1Z2dDE1dmFTa3MreGprRDVSaE1GRGdC?=
 =?utf-8?B?MC9GRTZObVhrdlJQaTJ5N3FCTmJ4YUlOdWhUb0ZVemlBL3BDSi9ueWJZY0J6?=
 =?utf-8?B?ZXZ3c2lCK1NQcUtKMTVLTnJ6aTZRSysrejMyUENsQnhZQ1JzT3dvVTFsNEp3?=
 =?utf-8?B?SUUwa0trV0NrVFJWVnVVLzdiYjBsdnpmSEdMNXBLMk14cE05K29JVVZQTkJV?=
 =?utf-8?B?cnJPb1orYWJES24wcnZWc1BJRU9NajV3Q3loV1pNTXlRSVRGakdTK28vbFI2?=
 =?utf-8?B?M2FUR3FUYmlMQ2lqemIvTWhXT3o3dm9naFh4TVh4TkRFYW0vSlZCL1pOTzFx?=
 =?utf-8?B?LzdramhEOUJJVW9qMXl4OTlSdGw0aS84cTVKN0ladmxBdWJBQ0QyT2tpTVZY?=
 =?utf-8?B?bG42MTA0amcxb3cxRldVUFRoejhNZ3RqLzVwNGxuY3Q0U3dKWmpJUS9FTFRW?=
 =?utf-8?B?UzMwaW05d010QlVJQXVaWGFmK2ovbTlHNHYzcGdnSERBWll0K3RSNWw4c3JK?=
 =?utf-8?B?TTRVeG9KRkVSNHFPSHlSdUtXMlppajZMakFaMVZRcXkzQUlRekllaDB5TVdo?=
 =?utf-8?B?bnExZXVjaU4rZUNUSjR1WWNiaW56aWN5RHFDYTZERVlrK0t5N3lRNmJ5aTFo?=
 =?utf-8?B?RUV3eVJMUkMwU1VEaWV2SmM5ZGNsNmI1QzBrVFllM2pwc0FIa1Nra09JUnZo?=
 =?utf-8?B?YXhVVHliRTc1VWp2QzBHMkgzTkR4aWtiVFJnTjJBQXBFWXYxdlRLaXAvd3dO?=
 =?utf-8?B?T2RMckVKTkR4WjVJYzl1TGM5Q2FlMDdZdTVWUzFYdVhrazFmSkNwSTdrTDY0?=
 =?utf-8?B?MXljTUNOakRpR1UyWHB2MGlqbzBndVVobGF1cDY0M2xzSFVXSUlEWnpaN0xU?=
 =?utf-8?B?OEM4VDVZWmxLN3VuOHNncWxSMENuU1FuTkpIMTRuK2M1VG9PUENMeURpZ2dT?=
 =?utf-8?B?UVhsdTdkRUZBeUJCcExjV1QvUi83Z2J6a3FwazlldWRjdE5QT0FudWZSemJo?=
 =?utf-8?B?ME96UmwwWGZTZHZtMWVla2UvNVUzQW9idjl4NzlYZm80bkloUGdiN25xcWxv?=
 =?utf-8?B?ZzhvWEFXSkpFS2t0VnozYWRHU1Q3MlpuR1hPTzZSN1VXeSs3SWtSTm15Zi8x?=
 =?utf-8?B?NjNvRmtVV1VBT3BpL1FCMzJxOVo0Q0pEenMycWtWOG1WV0xhTm5FM1VKRTlQ?=
 =?utf-8?B?YWoybUNpUnNzamZiemlWNnlObTNvNm55cTMzQUx3b0UxZHdLWFRCWWRYTURl?=
 =?utf-8?B?MlZVS1hIaUhnY09icGNFK1QwMmtWcDUwRVgvUmQ2bEtjbFIyUTBDWkdza0hN?=
 =?utf-8?B?bzJvcWxrNWFmSVR5WHZGbmo5dTFJWEFuL2FGTW1hU0xHSVRsWlNYOHllSW5y?=
 =?utf-8?Q?mnuzML+mEZAaZJAUHT1P?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf35194-4e4f-4ed9-e00d-08dd1936eebf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:23:08.3155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9671

On 2024/12/10 14:37, Christian Brauner wrote:
> On Tue, Dec 10, 2024 at 02:03:51PM +0000, Juntong Deng wrote:
>> This patch adds test cases for open-coded style process file iterator.
>>
>> Test cases related to process files are run in the newly created child
>> process. Close all opened files inherited from the parent process in
>> the child process to avoid the files opened by the parent process
>> affecting the test results.
>>
>> In addition, this patch adds failure test cases where bpf programs
>> cannot pass the verifier due to uninitialized or untrusted
>> arguments, or not in RCU CS, etc.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   .../testing/selftests/bpf/bpf_experimental.h  |   7 ++
>>   .../testing/selftests/bpf/prog_tests/iters.c  |  79 ++++++++++++
>>   .../selftests/bpf/progs/iters_task_file.c     |  88 ++++++++++++++
>>   .../bpf/progs/iters_task_file_failure.c       | 114 ++++++++++++++++++
>>   4 files changed, 288 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
>> index cd8ecd39c3f3..ce1520c56b55 100644
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -588,4 +588,11 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym
>>   extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
>>   extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __weak __ksym;
>>   
>> +struct bpf_iter_task_file;
>> +struct bpf_iter_task_file_item;
>> +extern int bpf_iter_task_file_new(struct bpf_iter_task_file *it, struct task_struct *task) __ksym;
>> +extern struct bpf_iter_task_file_item *
>> +bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksym;
>> +extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;
>> +
>>   #endif
>> diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
>> index 3cea71f9c500..cfe5b56cc027 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/iters.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/iters.c
>> @@ -1,6 +1,8 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>>   
>> +#define _GNU_SOURCE
>> +#include <sys/socket.h>
>>   #include <sys/syscall.h>
>>   #include <sys/mman.h>
>>   #include <sys/wait.h>
>> @@ -16,11 +18,13 @@
>>   #include "iters_num.skel.h"
>>   #include "iters_testmod.skel.h"
>>   #include "iters_testmod_seq.skel.h"
>> +#include "iters_task_file.skel.h"
>>   #include "iters_task_vma.skel.h"
>>   #include "iters_task.skel.h"
>>   #include "iters_css_task.skel.h"
>>   #include "iters_css.skel.h"
>>   #include "iters_task_failure.skel.h"
>> +#include "iters_task_file_failure.skel.h"
>>   
>>   static void subtest_num_iters(void)
>>   {
>> @@ -291,6 +295,78 @@ static void subtest_css_iters(void)
>>   	iters_css__destroy(skel);
>>   }
>>   
>> +static int task_file_test_process(void *args)
>> +{
>> +	int pipefd[2], sockfd, err = 0;
>> +
>> +	/* Create a clean file descriptor table for the test process */
>> +	close_range(0, ~0U, 0);
>> +
>> +	if (pipe(pipefd) < 0)
>> +		return 1;
>> +
>> +	sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>> +	if (sockfd < 0) {
>> +		err = 2;
>> +		goto cleanup_pipe;
>> +	}
>> +
>> +	usleep(1);
>> +
>> +	close(sockfd);
>> +cleanup_pipe:
>> +	close(pipefd[0]);
>> +	close(pipefd[1]);
>> +	return err;
>> +}
>> +
>> +static void subtest_task_file_iters(void)
>> +{
>> +	const int stack_size = 1024 * 1024;
>> +	struct iters_task_file *skel;
>> +	int child_pid, wstatus, err;
>> +	char *stack;
>> +
>> +	skel = iters_task_file__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +		return;
>> +
>> +	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
>> +		goto cleanup_skel;
>> +
>> +	skel->bss->parent_pid = getpid();
>> +	skel->bss->count = 0;
>> +
>> +	err = iters_task_file__attach(skel);
>> +	if (!ASSERT_OK(err, "skel_attach"))
>> +		goto cleanup_skel;
>> +
>> +	stack = (char *)malloc(stack_size);
>> +	if (!ASSERT_OK_PTR(stack, "clone_stack"))
>> +		goto cleanup_attach;
>> +
>> +	/* Note that there is no CLONE_FILES */
>> +	child_pid = clone(task_file_test_process, stack + stack_size, CLONE_VM | SIGCHLD, NULL);
>> +	if (!ASSERT_GT(child_pid, -1, "child_pid"))
>> +		goto cleanup_stack;
>> +
>> +	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
>> +		goto cleanup_stack;
>> +
>> +	if (!ASSERT_OK(WEXITSTATUS(wstatus), "run_task_file_iters_test_err"))
>> +		goto cleanup_stack;
>> +
>> +	ASSERT_EQ(skel->bss->count, 1, "run_task_file_iters_test_count_err");
>> +	ASSERT_OK(skel->bss->err, "run_task_file_iters_test_failure");
>> +
>> +cleanup_stack:
>> +	free(stack);
>> +cleanup_attach:
>> +	iters_task_file__detach(skel);
>> +cleanup_skel:
>> +	iters_task_file__destroy(skel);
>> +}
>> +
>>   void test_iters(void)
>>   {
>>   	RUN_TESTS(iters_state_safety);
>> @@ -315,5 +391,8 @@ void test_iters(void)
>>   		subtest_css_task_iters();
>>   	if (test__start_subtest("css"))
>>   		subtest_css_iters();
>> +	if (test__start_subtest("task_file"))
>> +		subtest_task_file_iters();
>>   	RUN_TESTS(iters_task_failure);
>> +	RUN_TESTS(iters_task_file_failure);
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/iters_task_file.c b/tools/testing/selftests/bpf/progs/iters_task_file.c
>> new file mode 100644
>> index 000000000000..81bcd20041d8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +#include "bpf_experimental.h"
>> +#include "task_kfunc_common.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int err, parent_pid, count;
>> +
>> +extern const void pipefifo_fops __ksym;
>> +extern const void socket_file_ops __ksym;
>> +
>> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>> +int test_bpf_iter_task_file(void *ctx)
>> +{
>> +	struct bpf_iter_task_file task_file_it;
>> +	struct bpf_iter_task_file_item *item;
>> +	struct task_struct *task;
>> +
>> +	task = bpf_get_current_task_btf();
>> +	if (task->parent->pid != parent_pid)
>> +		return 0;
>> +
>> +	count++;
>> +
>> +	bpf_rcu_read_lock();
> 
> What does the RCU read lock do here exactly?
> 

Thanks for your reply.

This is used to solve the problem previously discussed in v3 [0].

Task ref may be released during iteration.

[0]: 
https://lore.kernel.org/bpf/CAADnVQ+0LUXxmfm1YgyGDz=cciy3+dGGM-Zysq84fpAdaB74Qw@mail.gmail.com/

>> +	bpf_iter_task_file_new(&task_file_it, task);
>> +
>> +	item = bpf_iter_task_file_next(&task_file_it);
>> +	if (item == NULL) {
>> +		err = 1;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (item->fd != 0) {
>> +		err = 2;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (item->file->f_op != &pipefifo_fops) {
>> +		err = 3;
>> +		goto cleanup;
>> +	}
>> +
>> +	item = bpf_iter_task_file_next(&task_file_it);
>> +	if (item == NULL) {
>> +		err = 4;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (item->fd != 1) {
>> +		err = 5;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (item->file->f_op != &pipefifo_fops) {
>> +		err = 6;
>> +		goto cleanup;
>> +	}
>> +
>> +	item = bpf_iter_task_file_next(&task_file_it);
>> +	if (item == NULL) {
>> +		err = 7;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (item->fd != 2) {
>> +		err = 8;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (item->file->f_op != &socket_file_ops) {
>> +		err = 9;
>> +		goto cleanup;
>> +	}
>> +
>> +	item = bpf_iter_task_file_next(&task_file_it);
>> +	if (item != NULL)
>> +		err = 10;
>> +cleanup:
>> +	bpf_iter_task_file_destroy(&task_file_it);
>> +	bpf_rcu_read_unlock();
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/iters_task_file_failure.c b/tools/testing/selftests/bpf/progs/iters_task_file_failure.c
>> new file mode 100644
>> index 000000000000..c3de9235b888
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/iters_task_file_failure.c
>> @@ -0,0 +1,114 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +#include "bpf_experimental.h"
>> +#include "task_kfunc_common.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +SEC("syscall")
>> +__failure __msg("expected an RCU CS when using bpf_iter_task_file")
>> +int bpf_iter_task_file_new_without_rcu_lock(void *ctx)
>> +{
>> +	struct bpf_iter_task_file task_file_it;
>> +	struct task_struct *task;
>> +
>> +	task = bpf_get_current_task_btf();
>> +
>> +	bpf_iter_task_file_new(&task_file_it, task);
>> +
>> +	bpf_iter_task_file_destroy(&task_file_it);
>> +	return 0;
>> +}
>> +
>> +SEC("syscall")
>> +__failure __msg("expected uninitialized iter_task_file as arg #1")
>> +int bpf_iter_task_file_new_inited_iter(void *ctx)
>> +{
>> +	struct bpf_iter_task_file task_file_it;
>> +	struct task_struct *task;
>> +
>> +	task = bpf_get_current_task_btf();
>> +
>> +	bpf_rcu_read_lock();
>> +	bpf_iter_task_file_new(&task_file_it, task);
>> +
>> +	bpf_iter_task_file_new(&task_file_it, task);
>> +
>> +	bpf_iter_task_file_destroy(&task_file_it);
>> +	bpf_rcu_read_unlock();
>> +	return 0;
>> +}
>> +
>> +SEC("syscall")
>> +__failure __msg("Possibly NULL pointer passed to trusted arg1")
>> +int bpf_iter_task_file_new_null_task(void *ctx)
>> +{
>> +	struct bpf_iter_task_file task_file_it;
>> +	struct task_struct *task = NULL;
>> +
>> +	bpf_rcu_read_lock();
>> +	bpf_iter_task_file_new(&task_file_it, task);
>> +
>> +	bpf_iter_task_file_destroy(&task_file_it);
>> +	bpf_rcu_read_unlock();
>> +	return 0;
>> +}
>> +
>> +SEC("syscall")
>> +__failure __msg("R2 must be referenced or trusted")
>> +int bpf_iter_task_file_new_untrusted_task(void *ctx)
>> +{
>> +	struct bpf_iter_task_file task_file_it;
>> +	struct task_struct *task;
>> +
>> +	task = bpf_get_current_task_btf()->parent;
>> +
>> +	bpf_rcu_read_lock();
>> +	bpf_iter_task_file_new(&task_file_it, task);
>> +
>> +	bpf_iter_task_file_destroy(&task_file_it);
>> +	bpf_rcu_read_unlock();
>> +	return 0;
>> +}
>> +
>> +SEC("syscall")
>> +__failure __msg("Unreleased reference")
>> +int bpf_iter_task_file_no_destory(void *ctx)
>> +{
>> +	struct bpf_iter_task_file task_file_it;
>> +	struct task_struct *task;
>> +
>> +	task = bpf_get_current_task_btf();
>> +
>> +	bpf_rcu_read_lock();
>> +	bpf_iter_task_file_new(&task_file_it, task);
>> +
>> +	bpf_rcu_read_unlock();
>> +	return 0;
>> +}
>> +
>> +SEC("syscall")
>> +__failure __msg("expected an initialized iter_task_file as arg #1")
>> +int bpf_iter_task_file_next_uninit_iter(void *ctx)
>> +{
>> +	struct bpf_iter_task_file task_file_it;
>> +
>> +	bpf_iter_task_file_next(&task_file_it);
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("syscall")
>> +__failure __msg("expected an initialized iter_task_file as arg #1")
>> +int bpf_iter_task_file_destroy_uninit_iter(void *ctx)
>> +{
>> +	struct bpf_iter_task_file task_file_it;
>> +
>> +	bpf_iter_task_file_destroy(&task_file_it);
>> +
>> +	return 0;
>> +}
>> -- 
>> 2.39.5
>>


