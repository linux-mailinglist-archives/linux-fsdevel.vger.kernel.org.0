Return-Path: <linux-fsdevel+bounces-36944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EA99EB2F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95FD169B38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E811AB6E6;
	Tue, 10 Dec 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Gnd2TpUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2021.outbound.protection.outlook.com [40.92.49.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8317580;
	Tue, 10 Dec 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840265; cv=fail; b=NqfQkTg8pAKDDPC/oTqp+wPo8M/HW0sO/JpebrvJSUv8AtQW6/JTkd3DuGcn/DxyaeeEzXISZh9l0jSlZNcmRG8U98jTwn4yWbaEqnq5B0dky0AjQrFXZbFsvFSDTIMGPRyEbg/q0YSeYz54X0xAu4TwUJQ65EsGWcf44teDMdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840265; c=relaxed/simple;
	bh=i5gnChQNBJD1lqybqbsRhInWGOox3POF800q7Bb5pfc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KWhNMBsoC8aWWfFF9pdqA9q6paxMtlDuxiG8Fw5b3Wg9PgB8UdKUYjZikkrmrvbVUMSmsE0aHRqPoxrB7iaqgFmHSfc7EDyy84VVz1qNmZXkJwaSEjZMXSQTlMwD4qslszagBKBYncsaqZDC6nmXj/2RGFeipIfgJ2rY63rlnK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Gnd2TpUd; arc=fail smtp.client-ip=40.92.49.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSUSJ66EGeUfMSjyaJymBKQ4dkfa6rwcaa5lqkfZF6jP3De6UDtuGgdzqQUDBTCoGymew1hwojIXDoec23W4ctDh0uONA4lAR4OeD6/PhJZRa89pYPXZPIRe1qeQgvjYMZclzV3JUJiLogiVYJjYvwFiPd+O6YA2qw+e0yT40BYnnRKwgcZar2ZNg9B9X6znwOjoiJMWGJMZUBYaXPckXAsg7Q/RWG7bCmblXqZJHqLvSF9x1WnKuL5tL3a3RuhuHph+3ZYLU51nKOht0lqgE3A9loBZ+z4Y1B80b/0DVH+BLzCkbwkdALTbV2mUw3D/RpW6CBqrxrWt2iiUDuMotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRxFR6OMTzugkgzgy8ueHB6o8raqKYcG82ZeMxkvtNo=;
 b=mRGbASyzdvigXHeFEY+KPnEF3xMxfDtXl7VepTsUC/QaVlQ35Cuhd/Ul+RHCbidlJV9cIQbJDM+zbNpxlfNBSON0O6j/0JCETEMRy+eoeOyIoS6/lgg4db6bP7DjL2OKl9wdOSKjIo9w0CwYU+E9Cq10Jh7WfNiJONIVd2b7EsRWLQGAX2iTvpaCr7IJPssqZKj4dO8ZaSHJZ6mcGhMrd65XV7qJkhQSQXpfxDMA/sjmbO2+Xn1FcFCWi5pBwmjuCDRl0iB8ns8wMC4TxCpFl7QMhdvTICfXmpSz6/xc4DSmAr31gxatuuk0iu7iiTCl2v06v2It0JwNwMdG5TG9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRxFR6OMTzugkgzgy8ueHB6o8raqKYcG82ZeMxkvtNo=;
 b=Gnd2TpUdDEabvjkAGjrH+jC8uMI8YBIyRI0uzmtf3FETLkwdlm0T4rzTZftu3Xf+xFZpN63McmwUKTY0/D4lrx9Ct7CtE6pqN3KXE6cn+5oNFLekuR2WWk/MP9iQNVpU1GdBvi211QKINaf4Zs9hszhy76BziPxQPFxAQWcdXjlFVbyAQEOHFjGfDI+guF0P7wxHButfIkcIq/aM80Uvz0syoUF2JJBI3yavjS5X1Itz0BhulVtaOMXge2EzdlkwBTYeuKkJru2TfDqyMbTIIgjRDhBaPJZtJIdG9MfWK7c5qOHzkK7taAXeF8iN4Ybd6G3k8dkd4hmGdoCwz4PYWw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM9PR03MB7849.eurprd03.prod.outlook.com (2603:10a6:20b:430::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 14:17:40 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:17:40 +0000
Message-ID:
 <AM6PR03MB5080EB3C342F9114ABB5B4FA993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 10 Dec 2024 14:17:39 +0000
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
 <AM6PR03MB5080FB540DD0BBFA48C20325992F2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z0cAz3uOGRcl36Eu@krava>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <Z0cAz3uOGRcl36Eu@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::32) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <9c530a9d-b4d5-4afa-85df-0c260c14fc79@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM9PR03MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 60821349-a1d1-4322-2b79-08dd192567bb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|461199028|5072599009|6090799003|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzZZUzhQc21tODI0Zk0yWXpldVlNa0htSWR4b1p1N2o4ai9ib2hSODl4VDZt?=
 =?utf-8?B?UllFRlVMRFhWZFRlbEl0NThFeEkxUGJ0YjhLN01FbURtckNNV09MTDVzR0RB?=
 =?utf-8?B?dTcyVFJMQVJxdEpFMTVaOGpvUURsdVh5N2xGaUo2UEg5NWdIcnF1Q2FhYkhj?=
 =?utf-8?B?OHRQVElXRGg3ZWhtSEt1eVVJVXN6d0JKZmdnMVdNbDQwOEhnNy9lZDNBZWFR?=
 =?utf-8?B?NTA2OXRacDlpMkNKNW53MmpDc2F6cm5qdi9zTnBseEtOcW9kUzJEMjlTeWJZ?=
 =?utf-8?B?eXEvbUtXYWZCbUkwdTRheVBXdzA5NGlUOG9OL09SV2d4RzFsYkV2M2dmYmlS?=
 =?utf-8?B?b0lnZEw5QUVhOFlEaGlYYi9DS25SSndaVHJoWld2NmNsejJFaW5NemhsSmVs?=
 =?utf-8?B?bm9nVzlrRmI4ZjIyVmdEeXRKZ29CZ1k1N0htc1VsSWxUQ2pDVTM5TWJvRUhC?=
 =?utf-8?B?cnFoSCs5VHJLSXdOZlNoRERTdWFwUmdYYmppK3FPQ1RzS1pPUXdxcEhlQ1BY?=
 =?utf-8?B?TkhwdVBDTDBtV28xanhGclBaSTU2Q2VYbWdpVlF1RVQ0OGJZWS9RQkg4ZktD?=
 =?utf-8?B?aEQ3U01MVDhEVWF2U2JtT0I0cHRJSUJjN2YxMnNrK3padmc4T1N5dW9UTUI5?=
 =?utf-8?B?bXN0N1c1b2lrWU1RbGNJOCthMFp0Z3g4b0dRemRRVS9MT2JHbGh2YVJpTUdQ?=
 =?utf-8?B?azVaWTlJU3FyUTlESW5oRVgxcDNYeWFBOWh5dzBjYXdjU3RjR2tUYzBOSS9i?=
 =?utf-8?B?R2ZHdjIrVmlvNUdyWEsvYXpYZHo0aS90UGwrYktQd3hSNm1hMVdiNTRRU2NB?=
 =?utf-8?B?eklVSmtQSGNiYmFtWGQwTGZTWERsMU81Nk9iUWVpUzBwSVZNSXp0a1NrOVVi?=
 =?utf-8?B?ZVlKN0wrVXpNUTc2cGtGTlhidlkzSXlRRkUrNlAxVjRIcEJzUjNxcEhPOEZn?=
 =?utf-8?B?d2duM3RVVDZLbkxvMUNrVmlFUFhscFB4MzBkdGZUTmdIdXNWWWhHb2NUMWxv?=
 =?utf-8?B?b1VsSlRwN3BIVFJhM015a1VTVTNSUEF1NW5mSEx6eDIvNXRmTGhNRDUxV01G?=
 =?utf-8?B?NFZRVXBRSmRBa0p1ZXRsV0ZzUTZKd3JWQ3o4SjI4dFk1WHFKaWNyUVdIMW1I?=
 =?utf-8?B?MlFaYzJuUE44Y1pTaWt4L3RIaEREWUtnakY3SnFqbDYzMEVGdnVHNk5Vb09n?=
 =?utf-8?B?T29ndnd2RFptVmx5TmxJTlhYN1JsSEVrT3JIUENyNkNtOWt0NVdCbC82NStE?=
 =?utf-8?B?bG8vRENKeUZ4b3QxL0E0YmhuQXM5dW44UGR5aTBsSWwrQkNrUjhBK1JQTzVl?=
 =?utf-8?B?THZ6RG8wcnVuZDBxNEw5d2NHRm1tUjU4ZHREdnpyMjRZdjd3NDhVZ01GRTFG?=
 =?utf-8?Q?cr9PTL3D48G1WIbNxbuSWRd/u7fQLZAg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUlaYnliczk3dVVQcWVMZHFxM21SV0dIZmFqS0FLWHB3Q0REVjdlNTJLajBt?=
 =?utf-8?B?d05KZG0wS3ZNZzdGZlc2NlRHeUpGaWc1N1ovYVRERGw4NEJVTGs0aGx0NWh0?=
 =?utf-8?B?QTB3dXoxVWFHMisvcEhxU0QzMHBnZERMamVkblJFdFJUM2F4aGNsV2ZJNFFO?=
 =?utf-8?B?b25NSTFBWEQzTzdZdTlUSHdFaCszeW9ncVROcWw1SWdCMGFYQzFZTFg5c0s1?=
 =?utf-8?B?K2ExMDVXZmtOeXA4MTBSUlRSeW5ZT0Vka0FwN3VTU0wwTllNSkduZlZ3c240?=
 =?utf-8?B?Y1FNSzBOODM3NEdZd1pMMUVzdWNmcldONW5tdUJvUUFqZzE3dk9ycjkwVFJ3?=
 =?utf-8?B?bUVINGVmbENwWmIwSUo1YUZ0L2JheWxPMDRYMXNqOTAvcFRhYXhZYWgvTjJQ?=
 =?utf-8?B?Y1V4NDR6eUd3MUpiYktwWFlHbUtGRTg3SExzaHkrQzFaWGg1c2s3d25LVUhG?=
 =?utf-8?B?M2Qwdk1ac2lqMFA1M1BGd1A0UWNOTVlkSVNrZFkvMkVDd0pUTXU2Q21OWlQw?=
 =?utf-8?B?alA0cjRPYy9paTJKa003b0plMmVZRHdONlMwMC9MUjZkTzlpNDlxbXp5blVK?=
 =?utf-8?B?Y01qZEd6MjFiendwRlpuWHh6dnZ0a0k3MXdnZzYwVW50WjRLTG9MY0FIQ2lS?=
 =?utf-8?B?a2VzVkFwUGFPNUc3VjBtV3NNMWVHSmZ0UldPMDBHRkxjQk1kVHRmVG1GTGFU?=
 =?utf-8?B?S3pOTnJ6Nm4yK2xqc05pOVlKZVJrblFmWTB1NGZETzF3c0JiSGFGQ080Mzhq?=
 =?utf-8?B?aVR0YXU1STBYbDNnMEFnQWF4ZWI4YksrU09CZGtyWFhSTUV0YmNmWXRHVHRm?=
 =?utf-8?B?L3gwaFFJblZ0ZjJhUHl6aFpjOTk4VGtmZDh4SFNxV1haMEdLbldGeDJPKzQy?=
 =?utf-8?B?bmlQMFpPUDZITjFheFArVUJLWXRnZVZidmNHRlhzOUw1TTZsY1dzZUxrUDU4?=
 =?utf-8?B?d1hZcngzQXpvL0JVMXNHREROSm9NOWZ5RCtzRkJJNnpQaXBSMFJWUjdjUGhO?=
 =?utf-8?B?a1N0VjZxTi93cFptOUVVZkVMMXgwSURFazVsQW9SeHpNcmVZYXZXSkdmaXZE?=
 =?utf-8?B?SDJSTFgzZy9tVFpHVlREZlJSNUFQL2xsOUh2VHl3UzV0SGdVYkg5QUFZRGFC?=
 =?utf-8?B?c0ZFTDlaUDQ1b2RKMU1Tb0lWcUEyN25lYzFkM2RjaVprcHB1bld6bHV6UmlF?=
 =?utf-8?B?NXl4UG5VazZ1R00zTkNGVTFkczgvZ3ptUGJHYnNVbnRjY2Q2YkdoMGxRNWJV?=
 =?utf-8?B?SzIwS0MySi9Dd1FwTGRTWDZNT2hvUUhDdWtoWnp6c0FGQkcyaEdnTDBCaStP?=
 =?utf-8?B?ZmZiSVBja3h4VXNRUk1WdHBDelZWelA3cnJvNTFNZGp6dkkvd2UzV3NLc3hj?=
 =?utf-8?B?STZ0dndCRTlSQnI3WGVnRGhJNEgyL2RxMStJZGYzdSsvZk0xTC9sV3BScU5I?=
 =?utf-8?B?T0prTzZEQjR5c3BwZDF5K1ZpOGJFV0Nnd0haYmg4Vlp6WlM1bmJ5ck1Bek5X?=
 =?utf-8?B?NzVMdU9FTXlPaFR2YXE0RjhkZkl6NUx0a3ZpTUxab0xPQjRWRmVIVkpSQ3Qw?=
 =?utf-8?B?T1dRMER5YTVtVU5oZkpmY1dyb04yZk9mT1VJRFFPckZTSjY0UVJjYWc0VWRZ?=
 =?utf-8?B?Zkt0VDhqUGtnL1lsbWF1bHNCaU93LzRlcFJiaHF5Z1Jib0tZbk5ZUklYWXJY?=
 =?utf-8?Q?TXedW+qInB6HAcLJlmon?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60821349-a1d1-4322-2b79-08dd192567bb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:17:40.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7849

On 2024/11/27 11:21, Jiri Olsa wrote:
> On Tue, Nov 26, 2024 at 10:24:07PM +0000, Juntong Deng wrote:
>> On 2024/11/20 11:27, Jiri Olsa wrote:
>>> On Tue, Nov 19, 2024 at 05:53:59PM +0000, Juntong Deng wrote:
>>>
>>> SNIP
>>>
>>>> +static void subtest_task_file_iters(void)
>>>> +{
>>>> +	int prog_fd, child_pid, wstatus, err = 0;
>>>> +	const int stack_size = 1024 * 1024;
>>>> +	struct iters_task_file *skel;
>>>> +	struct files_test_args args;
>>>> +	struct bpf_program *prog;
>>>> +	bool setup_end, test_end;
>>>> +	char *stack;
>>>> +
>>>> +	skel = iters_task_file__open_and_load();
>>>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>>>> +		return;
>>>> +
>>>> +	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
>>>> +		goto cleanup_skel;
>>>> +
>>>> +	prog = bpf_object__find_program_by_name(skel->obj, "test_bpf_iter_task_file");
>>>> +	if (!ASSERT_OK_PTR(prog, "find_program_by_name"))
>>>> +		goto cleanup_skel;
>>>> +
>>>> +	prog_fd = bpf_program__fd(prog);
>>>> +	if (!ASSERT_GT(prog_fd, -1, "bpf_program__fd"))
>>>> +		goto cleanup_skel;
>>>
>>> I don't think you need to check on this once we did iters_task_file__open_and_load
>>>
>>>> +
>>>> +	stack = (char *)malloc(stack_size);
>>>> +	if (!ASSERT_OK_PTR(stack, "clone_stack"))
>>>> +		goto cleanup_skel;
>>>> +
>>>> +	setup_end = false;
>>>> +	test_end = false;
>>>> +
>>>> +	args.setup_end = &setup_end;
>>>> +	args.test_end = &test_end;
>>>> +
>>>> +	/* Note that there is no CLONE_FILES */
>>>> +	child_pid = clone(task_file_test_process, stack + stack_size, CLONE_VM | SIGCHLD, &args);
>>>> +	if (!ASSERT_GT(child_pid, -1, "child_pid"))
>>>> +		goto cleanup_stack;
>>>> +
>>>> +	while (!setup_end)
>>>> +		;
>>>
>>> I thin kthe preferred way is to synchronize through pipe,
>>> you can check prog_tests/uprobe_multi_test.c
>>>
>>
>> Thanks for your reply.
>>
>> Do we really need to use pipe? Currently this test is very simple.
>>
>> In this test, all files opened by the test process will be closed first
>> so that there is an empty file description table, and then open the
>> test files.
>>
>> This way the test process has only 3 newly opened files and the file
>> descriptors are always 0, 1, 2.
>>
>> Although using pipe is feasible, this test will become more complicated
>> than it is now.
> 
> I see, I missed the close_range call.. anyway I'd still prefer pipe to busy waiting
> 
> perhaps you could use fentry probe triggered by the task_file_test_process
> and do the fd/file iteration in there? that way there'be no need for the sync
> 
> jirka

Sorry for the delay, I have been a bit busy recently.

Thanks for letting me know, fentry is a good approach.

I used fentry in patch series v5.


