Return-Path: <linux-fsdevel+bounces-35942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEFA9D9F2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 23:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D032B166AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 22:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E061DFE06;
	Tue, 26 Nov 2024 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DVC4tF9T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2096.outbound.protection.outlook.com [40.92.58.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E61DA632;
	Tue, 26 Nov 2024 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732659854; cv=fail; b=I7CMx9x10LVo0T0Rwo6MVihCO8eCEXz4U/I5ZWBe7kwY5MWI2uIhNtr7L9IQd7vhKakoAkn504V+8bFmK/Lall9Vo5JXFwXCCKvMTcsCnJeqjoyKmZ9xnMtC9th24+BV6cKc9hpEKqB2JWfXQ1WsGP7JFf0QzD9UnzgM+KnsSw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732659854; c=relaxed/simple;
	bh=97gNRAvgJoZvShIYJ3v0FQ3GhUvXDs49qCioysFNNvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P5tml+mznTiJxWktcBGqq0UFKH3N3Y7GZEq4G/0okRn6229Nb8TByUCvZRAcdLzpzisaeanLPVlO5l7WpvXyZfjbeoe/z3jJE2tJ+E3usQaJCJ5Ptf44m87M81FE7ZfZokER3UOHfhrk3qnizq4SFZ/nC73xvv15T+2ZOzsmRzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DVC4tF9T; arc=fail smtp.client-ip=40.92.58.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGt5ivBqO1sH3FleU1KuloZET+qPzb3IA78QZSrK9tuG/RzcZPL74/+QPz/xfy1kFvUWzMtb/Fzu2I6xWuis2xpHA99xupnAm5lbl17g3SDgHnDyKOQNCoPANF5sn3HlOPljG1Xc6p1TPBWfysl91BPDclHcObFjm9qtbtEUbfBHwP3SJ0Zk5H7zgXbS1oyPilOsO3JTF9iFGhhKQQw/rsym/K5O6aCT78BdrCiEjtlzUUpq6x4zZRrk2shr5E8vRsIIbU1FYQ3fOag4q0P1E+umanpMOIMrVP/6epUPrLg1kuDy+AePwjJqjoyEsBNU5H7D2jBltO/LRiKVaZDgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o8qUDMy6DQ+9Jduomwkyp6ZFjPvvLAk5PxM582oRAs=;
 b=F7sWIYtKREUCDJ0IAXKhndmkYyWScu38vzp/GOcSDqtUyPZh2JSKc8W6CGgRwOaSx/SzjLzkN3rxCPwL3BWbl135Hf2q/lXm6y9ld2xu0ajnEetQLVnA2EZgnbzL/RywjG2R1qiZa88D/ow3pXgcQDFKk5RlWYi5ESk6NXlvayYUc4DEpFAUuAQV5LTGFvdTRuQNS9NeOb3JzQcaHDW017Ipru4FJu60y22JWvY2zhTh2suOvym5S31mlWk8KPEzVLVFocMgZflTB/lbrspziS9FK5NG0dOTotpuKhKWUesy3HVqBrKw3u9p4QS4pjr0jLV3yARpZnDTSGHYCrSuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o8qUDMy6DQ+9Jduomwkyp6ZFjPvvLAk5PxM582oRAs=;
 b=DVC4tF9TpyYzl1sleZNOT83vme+Q1wRwx9EQ+hUn3Glc9nfDySm/q/sOB6prdMaLxRMTspMbXWs4TLaiVsaHAFSQS4V/OxLnb6mdJotQIC4O/F8uwDRxXd6xP5M2Ini938bZ8vUvaFgE/dTPTIsU9gsDP3QaSr1ZDqjf1vKgDNbc9PQ14LwNoBTiQHyjYTjQNdaNQK9tCvnLhimh4BEm3JGb2agi+3ejfQ3rUf1Ub/7wZkTs1hW0Ndf9Lforp86YyfcTJTseB+QnPH0a0mNiwsBWIx2i1aaLNXA8qQJ3Y0TA1rZZBK9Br7q7JovcwczWeZM23Z1IjEXQ/F5AeyVIdQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GVXPR03MB10245.eurprd03.prod.outlook.com (2603:10a6:150:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 22:24:08 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 22:24:08 +0000
Message-ID:
 <AM6PR03MB5080FB540DD0BBFA48C20325992F2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 26 Nov 2024 22:24:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/5] selftests/bpf: Add tests for open-coded
 style process file iterator
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, memxor@gmail.com, snorcht@gmail.com, brauner@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50809E5CD1B8DE0225A85B6B99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Zz3HjT24glXY-8AF@krava>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <Zz3HjT24glXY-8AF@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::9) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <fad8939c-91c0-4c88-886b-c98a25adb139@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GVXPR03MB10245:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b162f2-7296-4364-ee00-08dd0e690b83
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799006|19110799003|5072599009|461199028|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGNRanZqMS9ob2VkYzk0RkMvYktRVVJJeTBjZDRtL2dnQnRVNlF3a3hqNkZ4?=
 =?utf-8?B?TFJVdzFkWVFWN0dpWTNkczgvNG92NFFTTGdiZjgvS2lhQk1MQ094UTg4NVJk?=
 =?utf-8?B?Z2J4UkZhV0k3OUpVajROVkJTM2FPS1kxaGpzZHRRcDlvYmxGZUw2UUZiN1pF?=
 =?utf-8?B?bE4ydERkK29aQTAxVkR0NFpxY3phdUdKMnJ2UjkrRnpMdk5GVm5CMzRUSkVh?=
 =?utf-8?B?ZG9KSkltVFY3YytnNjFqTTNmWkloUjhyNkpwZ0Z2Zy9PQStkT0diRWxISU1l?=
 =?utf-8?B?c1F5Nm9UZEs3RjdVM2lwbDhWVnd2K0k3d1BJOE9WK2VuZ3QvaWppb2hjWlZY?=
 =?utf-8?B?NXJFNzAybk5YblFMRnVjbXlDQmpwQTBESnZmT3Y0SG1SY3FkNVBmOXM3cUk3?=
 =?utf-8?B?QVdQcnpQLzRzZHA2WHlTcGUzT3lhVzBRZm8xMDYyMHdranZha3VLWUp3TmRn?=
 =?utf-8?B?WDZvcjJqQmx4dnoreXRFdnpBUzJFazFwRHM5TFNzRHJmZ0dKVitpUy93WkNn?=
 =?utf-8?B?NXgveUtxZ2E5bnFvNlVRc1B5bFlERlBNTVZVb3F5dnRqazYxSlk4c2pwalJD?=
 =?utf-8?B?S2V4UndvNTBISlhhOWZjdlFkYXBrc0NabmJYeGxpUlMxY3R5eHk1QTU5NERS?=
 =?utf-8?B?OW1ud2ZCWlZJOWZMMTNTM3dRWjdSOUFzVFJBeU1vOU1EMktISUFOTnFJQjdP?=
 =?utf-8?B?c3dmaGY5cnV0U2pEZUdaVjcyMU9mcHBucmUrV2U0SStNamkzR3l6cVZkN3do?=
 =?utf-8?B?LzczdEY4aHBUSnFWWUx3cDFQYjNURDhsQ2s2SGhHSlVuaGorV2R6RlJIa2Fp?=
 =?utf-8?B?NFliNmsxOHN4SmZNREJNUkJYbjVlKzlvb3J2SHhRbm9MQm40WEhiZFNUdEtS?=
 =?utf-8?B?YVF0ZHQ1ZWdxQ3JoRG94b3M2d3lvUllVcmNJZFI5OGpTa2s5LzczejJ5MXBq?=
 =?utf-8?B?Y1pzNlNCdXEzbDA1encvbEhMNUdSWGhmOG5idVVOazFNeUM2OUYyeWNVNGQz?=
 =?utf-8?B?RG9XTXdaM1JGNFlsdjk0emw3VjVKaUt0bE5oaFc5cUZ0R1p0RW1lSFN1YkVQ?=
 =?utf-8?B?M2JXazJHdWE1THRUY0JudkxCT2lOZ3BweDRmSGFaU1FzZnhVeExEam8yZXdF?=
 =?utf-8?B?cVhhVWw0OFN0dnlRTi9PWlpFVGhRTy9wMGxEenBrMWV4dkVpZHp4SzZEdGJH?=
 =?utf-8?B?RXVQbDFBSTZGU0R3YjJONlNBZXV0MTEyNFF2d0ZGMU1meXJJZ3VHTEZRMmtv?=
 =?utf-8?B?b1RqWEJKeGNPVnJhSDhoKzc1Z2xXQmE4bTVoYm96T1pEQng4WHNWRUNxWkR5?=
 =?utf-8?B?T3pGZi9vR21aYnZXZEEzaCtFNEorMmdKKzQ0OHkwb01vYmZwTHBvaThKblVJ?=
 =?utf-8?Q?+m+YykwmdHN8mN2i6S9X/3UXidhaYa8E=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXVETldlenA2a29iQjRDWFRwZ1NkdkFwWW5RVUZ1VTE1ZUZqVUhHRmZnZlJU?=
 =?utf-8?B?bWhaR2dMU2FONnpKeEZieXVhZXZ2STZQeitKTVFOYnRQS2MxVEprOHYxc01G?=
 =?utf-8?B?R3V6eUhFbjA3NGN0RktqVXJwMFZaMUhPUDZnNXZITnA4WTF0amYwOUJnbjZB?=
 =?utf-8?B?c0RreUsxd3pzWnkxTU1jcGxWa0JNanlTUGo3UzV2ODF5c1hhSWlTSGg0Y1Zn?=
 =?utf-8?B?WjNaWjI0SWluSm1XT1V4N3ViSERpNFc4Vng4WG92eVdaamtwdW4veC9LWlcv?=
 =?utf-8?B?TzEvNkhNa0VOOTlnZmREalMzSkM4aXFveTl6dzBUcC9yQnRwdW5aeEc3WTJo?=
 =?utf-8?B?Rk93OGpadGdzc3RWUGw4bk5oSzZ1RzZHem1DQi9OOWRxNVNiY2dqTjYxaWpo?=
 =?utf-8?B?Wk5xT1pNV1lZdzB6dmZrWjdFV1FrR2hSd0R4NS9XbmlPTHBmWEhsdGUyMzMz?=
 =?utf-8?B?bjJmNStCMUM1RTF1S2ZTVngrWVhMY1pNV2ZPVU8rQ0Q0REZiWUdhdVdnL2lO?=
 =?utf-8?B?M3RlRmx2WnNkTnlsTHVyT29lRGwrTjBlcGJLb1ZMeW12c1JDSTRnNVNkZjd4?=
 =?utf-8?B?TmNFczVrSGZ1dCtISG1GZURCN1Q0clVCVWdCR3IydlBWZ0p4TG84TnIxTTJD?=
 =?utf-8?B?WEw1RzRzeGhpNzA3QmFIMHJRQ3hZZ3ZzdzA4OEo5YWx1K2grOUhxNWNweXBx?=
 =?utf-8?B?ek54WVpENnI4NFMxU1ZwajRicGVwK0FJMFFZNWsreHByamlGdkxNckczK1JO?=
 =?utf-8?B?dyszcnNYcUFPeVJiRFk1Z2tXbTNvZDNPZFFKd0VPOUVZT3Nlc3p4bjR0NlI0?=
 =?utf-8?B?TUhYM0dUdVRNcVBxKzhDb1RyS1l0ZnRnbU5qczdaTGMvQ2pxVS9rNzRmZGVt?=
 =?utf-8?B?aC8rYTVNUXdhblZvRHE0aEE2WUxlbnBueGRVV0JCMnF5N0pVbW01bXhkREEz?=
 =?utf-8?B?N3NwQkgwbzh0SUx3N243QnVrWE9Db1Q3WEFPLzdhd0IwZHhqRWQyVnhLQWx0?=
 =?utf-8?B?QXdyVTV3a2tia09Vc2FjQVd0ZUNIZEFwcWV4OU5rSFNuYW91QU5uN3plZ3pn?=
 =?utf-8?B?QkYvVnY3Zzl1cGJXbUc3bnRKbUhmYmt4R0F6SEhtamg3Z0x0L1RqM3M2ZTcr?=
 =?utf-8?B?RXl2NFJwNmFhL29zQjRkTGEyVXF1YXhST0hmaWM1bUlDMDMra0pDMjBFZ256?=
 =?utf-8?B?TUlEdkhubWNvak9FTFBlZnVnTHdaUzNTaUxOeHFvekFlblhmK2VrN2I0ZjBN?=
 =?utf-8?B?MmQ5dGw3TGdoNldtQTVKTms0Nzkya1dhYXBCeC85L254RzY4VUViVlM5VEFp?=
 =?utf-8?B?ekovUW5iRnNpMC9kdTJIam9DaG9laWNFK1JzQkJManZUUytIRU1TREhidzAy?=
 =?utf-8?B?dmpUdXBUQnVhaERsK05tL3g5b29tY1dwdlZFOTZpbXJvWjNJK2ZqSG5lMHZD?=
 =?utf-8?B?ZWFmRVJVb0dveHFLSmIxYzU5Q2VJTk1vN1lqUkMvVEpldTJ4czVDcU9wclo1?=
 =?utf-8?B?RFl0Y3dMTmpDeDJoS3ZGM2V2ZzlkZmRxMWIyZ2JWTlZua0lRRU5aUFJKbDZO?=
 =?utf-8?B?dVZ1aSs0clQ0eC9CQnJHV241TFpseWVKVGUxMkZoSWY1bWZnYks3V1Nzc3o1?=
 =?utf-8?B?WnVZeGNlS3l1QzFVRXhmNHNER3U3bkNnQmRGbUdCc28wUHJwczhNVGF5UGlV?=
 =?utf-8?Q?uLwyVxD23dNiRaHnrTMA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b162f2-7296-4364-ee00-08dd0e690b83
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 22:24:08.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10245

On 2024/11/20 11:27, Jiri Olsa wrote:
> On Tue, Nov 19, 2024 at 05:53:59PM +0000, Juntong Deng wrote:
> 
> SNIP
> 
>> +static void subtest_task_file_iters(void)
>> +{
>> +	int prog_fd, child_pid, wstatus, err = 0;
>> +	const int stack_size = 1024 * 1024;
>> +	struct iters_task_file *skel;
>> +	struct files_test_args args;
>> +	struct bpf_program *prog;
>> +	bool setup_end, test_end;
>> +	char *stack;
>> +
>> +	skel = iters_task_file__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +		return;
>> +
>> +	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
>> +		goto cleanup_skel;
>> +
>> +	prog = bpf_object__find_program_by_name(skel->obj, "test_bpf_iter_task_file");
>> +	if (!ASSERT_OK_PTR(prog, "find_program_by_name"))
>> +		goto cleanup_skel;
>> +
>> +	prog_fd = bpf_program__fd(prog);
>> +	if (!ASSERT_GT(prog_fd, -1, "bpf_program__fd"))
>> +		goto cleanup_skel;
> 
> I don't think you need to check on this once we did iters_task_file__open_and_load
> 
>> +
>> +	stack = (char *)malloc(stack_size);
>> +	if (!ASSERT_OK_PTR(stack, "clone_stack"))
>> +		goto cleanup_skel;
>> +
>> +	setup_end = false;
>> +	test_end = false;
>> +
>> +	args.setup_end = &setup_end;
>> +	args.test_end = &test_end;
>> +
>> +	/* Note that there is no CLONE_FILES */
>> +	child_pid = clone(task_file_test_process, stack + stack_size, CLONE_VM | SIGCHLD, &args);
>> +	if (!ASSERT_GT(child_pid, -1, "child_pid"))
>> +		goto cleanup_stack;
>> +
>> +	while (!setup_end)
>> +		;
> 
> I thin kthe preferred way is to synchronize through pipe,
> you can check prog_tests/uprobe_multi_test.c
> 

Thanks for your reply.

Do we really need to use pipe? Currently this test is very simple.

In this test, all files opened by the test process will be closed first
so that there is an empty file description table, and then open the
test files.

This way the test process has only 3 newly opened files and the file
descriptors are always 0, 1, 2.

Although using pipe is feasible, this test will become more complicated
than it is now.

>> +
>> +	skel->bss->pid = child_pid;
>> +
>> +	err = bpf_prog_test_run_opts(prog_fd, NULL);
>> +	if (!ASSERT_OK(err, "prog_test_run"))
>> +		goto cleanup_stack;
>> +
>> +	test_end = true;
>> +
>> +	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
>> +		goto cleanup_stack;
>> +
>> +	if (!ASSERT_OK(WEXITSTATUS(wstatus), "run_task_file_iters_test_err"))
>> +		goto cleanup_stack;
>> +
>> +	ASSERT_OK(skel->bss->err, "run_task_file_iters_test_failure");
> 
> could the test check on that the iterated files were (or contained) the ones we expected?
> 

Yes, that is the purpose of this test, to check if the iterated process
files exactly match the files opened by the process.

If you mean further checking what exactly the file is, e.g. whether the
file is a pipe or a socket, then I can add that in the next version.

> thanks,
> jirka
> 
> 
>> +cleanup_stack:
>> +	free(stack);
>> +cleanup_skel:
>> +	iters_task_file__destroy(skel);
>> +}
>> +
>>   void test_iters(void)
>>   {
>>   	RUN_TESTS(iters_state_safety);
>> @@ -315,5 +417,8 @@ void test_iters(void)
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
>> index 000000000000..f14b473936c7
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/iters_task_file.c
>> @@ -0,0 +1,71 @@
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
>> +int err, pid;
>> +
>> +SEC("syscall")
>> +int test_bpf_iter_task_file(void *ctx)
>> +{
>> +	struct bpf_iter_task_file task_file_it;
>> +	struct bpf_iter_task_file_item *item;
>> +	struct task_struct *task;
>> +
>> +	task = bpf_task_from_vpid(pid);
>> +	if (task == NULL) {
>> +		err = 1;
>> +		return 0;
>> +	}
>> +
>> +	bpf_rcu_read_lock();
>> +	bpf_iter_task_file_new(&task_file_it, task);
>> +
>> +	item = bpf_iter_task_file_next(&task_file_it);
>> +	if (item == NULL) {
>> +		err = 2;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (item->fd != 0) {
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
>> +	item = bpf_iter_task_file_next(&task_file_it);
>> +	if (item == NULL) {
>> +		err = 6;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (item->fd != 2) {
>> +		err = 7;
>> +		goto cleanup;
>> +	}
>> +
>> +	item = bpf_iter_task_file_next(&task_file_it);
>> +	if (item != NULL)
>> +		err = 8;
>> +cleanup:
>> +	bpf_iter_task_file_destroy(&task_file_it);
>> +	bpf_rcu_read_unlock();
>> +	bpf_task_release(task);
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


