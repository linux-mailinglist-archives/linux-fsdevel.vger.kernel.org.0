Return-Path: <linux-fsdevel+bounces-36956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACDC9EB64E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8891888E78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D061C1F15;
	Tue, 10 Dec 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DJvnNr57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2037.outbound.protection.outlook.com [40.92.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD41C1738;
	Tue, 10 Dec 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847964; cv=fail; b=FcIq06tf4QjlzgLGCKwnR6C8V7YrBhM11oGY/Ef3XvPzRpVJYExDCO/Ih7pfcdcdrgKAe/AjeGQ6Qo08KhA6kPoFK0qFiu7mNJsnz6/GKNGVuXWd8ycHkQyb7GIUPgXjBs8SifMiEgWFtCNWPPbUAZkNluNCtHpWjegKZA5jY/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847964; c=relaxed/simple;
	bh=GmZoqsbRx+8r/kNvf9640BvudNnGoGppbSrBQ1v3HRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CpiUDTHRLWUHz+5wP0PJKiLooiLLTvQCgC1tEqm+fyVyAjzO0C9hJ03Tv/7JbSmV3wBwGdYopSboN9cPmve0CTYZuLtvjfbnAdgvc/vGN6ksUQwl4b+GjAMEKJzGtC+Rbi+EgEivFZ5C18xgyhygn/Tvqc2xCsmaGbQzolyUwI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DJvnNr57; arc=fail smtp.client-ip=40.92.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rClkRWbL1KoCYubuOXrtdj6HKI+o5k243l+DKvWy6PP8bemYY+5SO0Ln2d3XdNn+WT3nyJ8xDjpTVVkw/PN4UmeMZXqAB5avPo8qzXy8szamt7TEXGMP6HL1TyqyGk6aKD3/AUbhSqQWxPe5Thwio7CsmyAvGX2ZKFYuyvFO4cS7koxyOQ6zlR6OXSq8Aq6utmJD6NJCMoD5rJbJn+EI1EY26N+xoL10VyYFqA8T8qRSperDNWvWTIPqxRvezARC4lV3tITipAjpeis3fdCsoriq3QOER5fNGMvJl5DA7HIdvdNDcOSNG5Qo03cwmFq3EOGmoylvV6PyXBTtpJTr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN7lVSVaVzWD1At3oNONNcMZzX+s08dOGsVnQ0E489w=;
 b=kLLNkg62EsqQrWNNk9LRAgrd7FKWICIdbxMBDZ7MO6FgDu4L/9aJW8duV1ZeIx1NEXIRFpo4RJjWmQXLiTQ11cm/hpWcxStd3SLqtX9pSt99HEBU4LfkTsbPZ8nHlDI4EWewiFwFFKLXnQLXJIp5Na8hnc14KUMcnbq6xdv/+6uFFvU8brTCqFhmrCsxQ0HNKyy2wBhGLM+zA+izBR5l2HZWHytDbNYS5VpWehxZN/7GWbXlOJzcPvjbLgfkPCcKFuF5XGg5KerkTJJV2sMEDiXrVWbm8e7W31Q2zqknHGnh12Kwk5mHT8+AstUfE7LXRtCSf9lgSMt5xapN1QalAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN7lVSVaVzWD1At3oNONNcMZzX+s08dOGsVnQ0E489w=;
 b=DJvnNr57uP+i25XYkofXh9nyott+2Hhz3q+R1j2KNRgsXKpA+vMIS+BKIuYOECaqNm4WeoyQcqvIigwW3aBPRwQB+VPofD2VRRiZYSiKI2eIf27AlBi/MRZz/nrnLE8lJHJIIwNj2Dzp3c96Wj7PLKhfMAdazHVNxibDF4u1ZgxM336zuk8OPlLZ6/8LWWoKQDjl3/B+4wg+DWCuTFsc8CgvDFPj+xy6DdH3TM5ZudJEFiH9sSk5phgs2TYZ70afQIyuOFpNEZifJWCI5OdVjrvU2LLVcW70CZ6j5qgnpPmzXoOE5G3647kTKU87mVAUeOJrpChstdtfHidBoCk8Tw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB7177.eurprd03.prod.outlook.com (2603:10a6:10:22c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 16:25:57 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:25:57 +0000
Message-ID:
 <AM6PR03MB5080C17BB893CE931E40DA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 10 Dec 2024 16:25:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
To: Christian Brauner <brauner@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-geholfen-aufheben-b4b57524c00f@brauner>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <20241210-geholfen-aufheben-b4b57524c00f@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::20) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <d968655f-8a4a-4dd9-98f5-081e60571c49@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e5a280-e4b3-47c2-3c79-08dd19375374
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|6090799003|461199028|5072599009|8060799006|19110799003|10035399004|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEFJSzdoQzFNb2xwbzdmdVdzNDVzbkZEbFdPb0NIMDdWWG11V3JOYWhTYXEy?=
 =?utf-8?B?SHFHd2R5M2pZT1U4cWE4N051akZuL0Y5bXIyNUdZMTVkQjB4MmtBS0NOZ3ZP?=
 =?utf-8?B?WHBaY08ydkhOT3l3YnhyNHdVdm9aNnhlSXNmWlRmZzR6aS8wM05YRmFPRWZm?=
 =?utf-8?B?WnBTaTBwdlJnaTVKTG5zOEV2bkRQZkxrV1FXUi9JWk8reERqMFgxRE1KakVy?=
 =?utf-8?B?bENMRVg1NlRmREhCYjlnK2tjQUNTL3hqQ1ZwMjhiWk96Y0pEUkR3Szc0ZWQ0?=
 =?utf-8?B?aFpUV0NrUStQTitaMWVTaVpDckI1WFZZZkR0ZzJQLzE2NFhSZ25KVWZtbEdz?=
 =?utf-8?B?MGJVbVljTGlidnVwY2tRbFZkS1U3SGkwK0ovRmQrVzcxdE5ubkpIMTJXdUVm?=
 =?utf-8?B?bDNpblNSa1VKMTNyWmVLYlBDMzREOFFrZkg4Ukk0MTd6b2o5Z0FCRDIrdmFN?=
 =?utf-8?B?K3p1TG42VFFNcno4Uk9OaDRieGFQSU0rRVM3Ti9URDJ6UDJuU21JdWhGOVhQ?=
 =?utf-8?B?alNoL1NQdEthamJwa3pZNmZ4MGNibUx6QlUwNXdnZkFzcjdtSkw1eEpEck9S?=
 =?utf-8?B?Z3grcG1LVDExRGhabGFXdWVXTXNueS8wWVkvK3l0SjdEOFRuZitmYmVxbFIv?=
 =?utf-8?B?cFc2dWx6YmpIbGh3K0ZlOS9CWmQxcGxpaGdjbkJ1cXNhY0lobTV6dGhpWUQ0?=
 =?utf-8?B?Z2I3N3VBSllGRVlQSFM2UGdrMHd6WTVVVENYNUhzZVpGSUJQL1J3aVBwaFlq?=
 =?utf-8?B?eTZxSzZmL1hpMEYvSXZBY3lVV2dNeWE5Y2t1U2lDNEh0aENMQ3VERVYyckZW?=
 =?utf-8?B?cU1GQ3haS2UvdjBveThYYml1VDk2Z0Q3bzlUN2FCLy9lTVVRVFVsbThUQTB2?=
 =?utf-8?B?dzVYK21YWHVDb2FicWczWUdLbmcxRllSQjdFZi9oOWhNNFpLMWh5Uk1IVEk2?=
 =?utf-8?B?THpZMkdpWmE4N1Q0RUJiUXp1K1BpWng3NU1kNGxiN3RHMHNpaEdoWnZlZ0VL?=
 =?utf-8?B?K212dlVBQXJJU1BFZUdFZWNjMEJDRWdWRm5Tak5qVEhWU3NxTzM2bFlnTVJ1?=
 =?utf-8?B?Q01hVGx2WUpBbENubFBOb3JRcmxpNkZHNytIcFFWRFpYLythZGJiM05jS3Js?=
 =?utf-8?B?RVZzVlFQRnJDWGxRcUJMd1Y5bitLem5WU29VdmJlUG51Ujg5NmxRWEZ4VTQy?=
 =?utf-8?B?MDYrbUdpcUxBeXpWc3ROOXdCZExtR3dGN2xiVWZZcUF4UlNIL1ZiMkR2SGhK?=
 =?utf-8?B?dXVPNlBTWjJENFJBREw0eDVtRG5obHVsN1hBdzk1dm5QanJHRDZ6QnZMSlNS?=
 =?utf-8?B?ZlZnMWdkMk04UTAwU2VCclE5c1FwYzJzVEJPL2VGQnlLbzdYTEF6c0VKTWk1?=
 =?utf-8?B?b3RBRWxpZHdhQWFUOXVtY3lXN3BTdldQNDh4eElxUXg0bVFUTnNPQnJ1QUpy?=
 =?utf-8?B?Y1hZdDQ4d3dWUkxDdXNDdDk5VWc5V0JkUWlrb3lBRVBiQm83YWU1V3BFa3Vv?=
 =?utf-8?B?TVRLQU8zZGRVb2ZZOTJwcUxRY3U1NDFYZ0xaTEFhemY3dzV1R2hsYnViRHV0?=
 =?utf-8?Q?4mHic6GuJNrSe7X4mOPaJpJJM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2ZySmhtNWhnSWFDbDFTRmp2Vm1wSVBBcW1Gck4rWVYvQ3hvQzlqUWI3NEV4?=
 =?utf-8?B?clZWbit1cnBYKzRvdXlKK1lTeXNDTENud2VBRENXNjNuWSsvdlh6SFVYMkxH?=
 =?utf-8?B?NkdFa2FKYXlNNmpMcUhxWFdWQmlGKzZCZkEyNVBPQUF6ZlZiMGZ1MGdEUzlp?=
 =?utf-8?B?dG96K2I4NGlORGVnRFBySVZwWStGWWFXaVlQVFIyZk10N2ticnllaWpmRnNJ?=
 =?utf-8?B?aFBSdmpsWU16cVFDQ3QwdjJvR2c2djlmaE4wWExkNzN6RHlocmV6TW9Gd0Iv?=
 =?utf-8?B?VWdqblY0dFpsUHFUOHdKa2VyOTk2dWJtTzhhRWlmenFJNEJ0SzdvdC9ORVIy?=
 =?utf-8?B?ZG9abWZzSm83eW1DcVpIcW4vR0dTL3NzZER1d0hhVjdSWlhTTWdvRVBMUHFE?=
 =?utf-8?B?UHEycjhUMTBRUFRVMzE2aE8rUkt1Qmc2azJ4YUM2Vll6cmF0NnQ4TGYwclNU?=
 =?utf-8?B?L25BMnZhVnU3RGVSbFFPbkhJZDB6WElMcUtEblJiVWhvL3FTMWZhN0FaYWJQ?=
 =?utf-8?B?ZkJsQWJLakhRRWJ5dEFlaXY0eHJJQnRQaWMwV0FqRzdZRTB5S0NOZ3hJQWxT?=
 =?utf-8?B?U3FTcDlVc2ZZZ0lhSUFnK0YybTdEZ2kwbWxSS2NqVDV6cjNTd0xHVmNRVjZa?=
 =?utf-8?B?aFBqMjZ5SnlBQ1V6R2VMRGJNSWhTY0g2QjBvd1M5WEtPMVFrcUcyOVpjVUth?=
 =?utf-8?B?bW9rdlA4WXgvOUN1MklEODZuUlZydysyQWNFMnpqNkFiZHNDSHRDK2wxNzhS?=
 =?utf-8?B?SVJ5dkh6aThkOTBTRURSQ0RqOU1TUnlucW55U2hINkFNWFhja3NKekZtbVlo?=
 =?utf-8?B?ZU5nYTh5cUJVUUJWWEhZeWM3VXVuNlgvV2g3R0d2Mmx0eDJta1JDcVg2R1ZE?=
 =?utf-8?B?ZkMyVVNITFlPd1duQ0lNYnhVWjdMUlgwWjkvZnM2aEI5U1REeGlNc2ZnUUR6?=
 =?utf-8?B?ZTk1TUd2ZHZVOG5SZ1ptQ1J5ei8zR2huSkIydjBkYk1qMkE3bWFuUDdoUUNR?=
 =?utf-8?B?K3RpQmpmRHFMU080YkFZR0RUbWF2MUNvSmdxSnI5RXgxTWRmd3BtbG1Mc0hK?=
 =?utf-8?B?RGJPbHR5Mzg1MkdoNlFuZ2dnNXFpUTBTTUgzS0pIOHF1LzNtUkM2YzhKZEZx?=
 =?utf-8?B?cUg3K1NxNjAzUjNrWjlFNFBLTmFWVGZEK1FBeUlZZUxrVEprdGhJNm1IUGxN?=
 =?utf-8?B?V0pNSGZjeHFISnV0ZEJ4RTU2M2tvOFhEVXJXMFM4dkZzWDRNbDlwT0NlL091?=
 =?utf-8?B?RWM3Z3ZkNHQ4d3dQY0JmbFlSYnp3b3NqcEtkNS8zRDFzSzl4aWxNWU8vb3Nm?=
 =?utf-8?B?bU5mMXltd0t2QnNJYWl5b2sycUdoekJ5Q0VqSVlUVVJsczlBdUxyeUh4QVNK?=
 =?utf-8?B?R3ljaGRUT2pBRmVvTFBCUGZsZXgrVEs3RTMwTmdpWi9nbXd3cjZOWXlkK0tY?=
 =?utf-8?B?dncrVDZDb1VDVHNnZHRpb05Pbmdhak9TRWF2RWJFejFYbTQrVGhoR2dvR0c3?=
 =?utf-8?B?Ry9vTkR3Z3pubndKQW1ZZGVwd0tFeS9sQk5ZTGxEdTRMQkVuL3l5bEJ5WDBz?=
 =?utf-8?B?Zlg4U2VaTFRKajJQNGF6K0pqOUswVExKcXZLQ1p3eWs2VEFmNG83MjhtZGF5?=
 =?utf-8?B?SFRhS1lQbDVJd3owUzQ3NjFUaVR3YXFmUGVwMmYxMTgxWlNqWEFIUjNEM0RR?=
 =?utf-8?Q?Op2ISN3UTw6IArHWkN+v?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e5a280-e4b3-47c2-3c79-08dd19375374
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:25:57.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7177

On 2024/12/10 14:44, Christian Brauner wrote:
> On Tue, Dec 10, 2024 at 02:01:53PM +0000, Juntong Deng wrote:
>> This patch series adds open-coded style process file iterator
>> bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
>> selftests test cases.
>>
>> In addition, since fs kfuncs is generic and useful for scenarios
>> other than LSM, this patch makes fs kfuncs available for SYSCALL
>> and TRACING program types [0].
>>
>> [0]: https://lore.kernel.org/bpf/CAPhsuW6ud21v2xz8iSXf=CiDL+R_zpQ+p8isSTMTw=EiJQtRSw@mail.gmail.com/
>>
>> Although iter/task_file already exists, for CRIB we still need the
> 
> What is CRIB?
> 

CRIB is Checkpoint/Restore In eBPF.

Introductions to CRIB can be found at the following links:

https://lpc.events/event/18/contributions/1812/
https://lore.kernel.org/bpf/AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com/T/#u
https://lwn.net/Articles/984313/

>> open-coded iterator style process file iterator, and the same is true
>> for other bpf iterators such as iter/tcp, iter/udp, etc.
>>
>> The traditional bpf iterator is more like a bpf version of procfs, but
>> similar to procfs, it is not suitable for CRIB scenarios that need to
>> obtain large amounts of complex, multi-level in-kernel information.
>>
>> The following is from previous discussions [2].
>>
>> [2]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/
>>
>> This is because the context of bpf iterators is fixed and bpf iterators
>> cannot be nested. This means that a bpf iterator program can only
>> complete a specific small iterative dump task, and cannot dump
>> multi-level data.
>>
>> An example, when we need to dump all the sockets of a process, we need
>> to iterate over all the files (sockets) of the process, and iterate over
>> the all packets in the queue of each socket, and iterate over all data
>> in each packet.
>>
>> If we use bpf iterator, since the iterator can not be nested, we need to
>> use socket iterator program to get all the basic information of all
>> sockets (pass pid as filter), and then use packet iterator program to
>> get the basic information of all packets of a specific socket (pass pid,
>> fd as filter), and then use packet data iterator program to get all the
>> data of a specific packet (pass pid, fd, packet index as filter).
>>
>> This would be complicated and require a lot of (each iteration)
>> bpf program startup and exit (leading to poor performance).
>>
>> By comparison, open coded iterator is much more flexible, we can iterate
>> in any context, at any time, and iteration can be nested, so we can
>> achieve more flexible and more elegant dumping through open coded
>> iterators.
>>
>> With open coded iterators, all of the above can be done in a single
>> bpf program, and with nested iterators, everything becomes compact
>> and simple.
>>
>> Also, bpf iterators transmit data to user space through seq_file,
>> which involves a lot of open (bpf_iter_create), read, close syscalls,
>> context switching, memory copying, and cannot achieve the performance
>> of using ringbuf.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>> v4 -> v5:
>> * Add file type checks in test cases for process file iterator
>>    and bpf_fget_task().
>>
>> * Use fentry to synchronize tests instead of waiting in a loop.
>>
>> * Remove path_d_path_kfunc_non_lsm test case.
>>
>> * Replace task_lookup_next_fdget_rcu() with fget_task_next().
>>
>> * Remove future merge conflict section in cover letter (resolved).
>>
>> v3 -> v4:
>> * Make all kfuncs generic, not CRIB specific.
>>
>> * Move bpf_fget_task to fs/bpf_fs_kfuncs.c.
>>
>> * Remove bpf_iter_task_file_get_fd and bpf_get_file_ops_type.
>>
>> * Use struct bpf_iter_task_file_item * as the return value of
>>    bpf_iter_task_file_next.
>>
>> * Change fd to unsigned int type and add next_fd.
>>
>> * Add KF_RCU_PROTECTED to bpf_iter_task_file_new.
>>
>> * Make fs kfuncs available to SYSCALL and TRACING program types.
>>
>> * Update all relevant test cases.
>>
>> * Remove the discussion section from cover letter.
>>
>> v2 -> v3:
>> * Move task_file open-coded iterator to kernel/bpf/helpers.c.
>>
>> * Fix duplicate error code 7 in test_bpf_iter_task_file().
>>
>> * Add comment for case when bpf_iter_task_file_get_fd() returns -1.
>>
>> * Add future plans in commit message of "Add struct file related
>>    CRIB kfuncs".
>>
>> * Add Discussion section to cover letter.
>>
>> v1 -> v2:
>> * Fix a type definition error in the fd parameter of
>>    bpf_fget_task() at crib_common.h.
>>
>> Juntong Deng (5):
>>    bpf: Introduce task_file open-coded iterator kfuncs
>>    selftests/bpf: Add tests for open-coded style process file iterator
>>    bpf: Add bpf_fget_task() kfunc
>>    bpf: Make fs kfuncs available for SYSCALL and TRACING program types
>>    selftests/bpf: Add tests for bpf_fget_task() kfunc
>>
>>   fs/bpf_fs_kfuncs.c                            |  42 ++++---
>>   kernel/bpf/helpers.c                          |   3 +
>>   kernel/bpf/task_iter.c                        |  92 ++++++++++++++
>>   .../testing/selftests/bpf/bpf_experimental.h  |  15 +++
>>   .../selftests/bpf/prog_tests/fs_kfuncs.c      |  46 +++++++
>>   .../testing/selftests/bpf/prog_tests/iters.c  |  79 ++++++++++++
>>   .../selftests/bpf/progs/fs_kfuncs_failure.c   |  33 +++++
>>   .../selftests/bpf/progs/iters_task_file.c     |  88 ++++++++++++++
>>   .../bpf/progs/iters_task_file_failure.c       | 114 ++++++++++++++++++
>>   .../selftests/bpf/progs/test_fget_task.c      |  63 ++++++++++
>>   .../selftests/bpf/progs/verifier_vfs_reject.c |  10 --
>>   11 files changed, 559 insertions(+), 26 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c
>>
>> -- 
>> 2.39.5
>>


