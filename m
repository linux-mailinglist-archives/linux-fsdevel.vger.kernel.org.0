Return-Path: <linux-fsdevel+bounces-33499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E1D9B996D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 21:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A815B213A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 20:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E721D9A57;
	Fri,  1 Nov 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WsF+d5+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012039.outbound.protection.outlook.com [52.103.32.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C51D130B;
	Fri,  1 Nov 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492897; cv=fail; b=rttVyB7tS9zesjYV88MG4rpEsKdnrDO6E89ePjgSH5TPmjueM46TfD2A9tmJxzHrvKD+BZUqwsJ9pGSyqtmqSBJdyEvIRnWtm7/ClkNZVVAUvjAKvEZRzjenb6QO2TjIBE4h/Ecpg4lYHZV1FHbhyIAdF+D9iecUBf3Y5ztHCCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492897; c=relaxed/simple;
	bh=hYErj29L5xcIiV5FGSsA3H16ZN0j/jmWJtzcDJAfqyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P0OvDyGsj2Su8SD5BE08evrrcOIuahTAhSxf256jEV+8ngQnTIZqq/PSGuvqpP3YTJttHKkJWAvD8zFLvrQ/0ls79M8J0GbifhzahmD3txMxOIrFY8Y4+WYUaG/9XRUtwKf9uGbaGFFHXLgDCRPCwFSLrBdovjM8w3CncT1Qkrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WsF+d5+f; arc=fail smtp.client-ip=52.103.32.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7Z/186g/X92yX2gL46SQ4F9yg8lASYCZLFoHbA+0l43zMdF1iMjWoVZ/rQRvX4Ffa8RvdWi4MgMxF/xnsh+pltDzE8MVQV5vbOI2+vobx2+HEJudkhHZV6N+wRWfGBkDx2zeYu6p9VgqRKWXq0jbcyYkPqlCpKiQrfegoblR/x7J+n3DaOtVSU++EmMtCfaU2yRp0YCR/dvBYl2L0o3tFB3NYMJmGmXVzgG3WtwP4VBIuYJ0HMpN3BbONZAjm+GreZrPKN2BMq1e9oSnxoi1ZftRzilQ5Fs0Yr6DlUJEcfxPOnWhPVRBhOO0omPhqEHMFNtdjBBunjd6ejIbOS27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYqaIB3TJEvX5Dy24oOumDqv88donNgZEwGvUrnrkAQ=;
 b=VXSU0Vgw+gwzfLIhLOjeT9hvQUOhzXKRTmwuPqRuUSFiIiDEByapxjbomXP7tL9VwhiJ7yX6jjLDUShV020yqeUfQgyuC/xqGSSvWOeMH+gjBRgMhg8qmSfziYZS7XeZf0FrxojWkrdUocZOKHqn166KkUOiVu2PikXcoDGZhja3cLzyBws5iAn4PmfYmxaweq6YQKqFxNMf8aBFQmTeiXokNjqeZ2bdu/D09MRaLunnUJSV+aJPv0DbQPvoTFNZLedY26A3OFfU5pXWTYKqpwtzR1VdDZsbsTHHNKSZGidThVo32vKoPSnP6GsqsXwLAgbJJXduFW5WJroFwxFtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYqaIB3TJEvX5Dy24oOumDqv88donNgZEwGvUrnrkAQ=;
 b=WsF+d5+f3AVtwCRiMLVu3d+kkzHT3slfzDepP2sOaqlvVhjS8Dc9lph05gyG3bFcPUby6u1D9RU3QSv8KtYObZK0+E8iRZ9ywpUeYXOYriCd8DwBUpibqTZwHYJ19MbnCHpEiHJfA+n5TUugYJDe5hBrTWUhtUer/NcesRbzmmboLJfIb4JZXJguYNMLuI9STbBpVuRzXDshq1yRSkSieLz/ubJkZ5pA+OcvBrg0rvDFT9fhqpbxEHrOQv3cbf99Op1EorpWWzHQX8baU7ftDTDY40sFQtET0Ew8ggwmHPwPWIiY0kRqGirGphPgi7gnUmkRdmXoSi6FGR3Lc6RAig==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PAWPR03MB9059.eurprd03.prod.outlook.com (2603:10a6:102:33c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 20:28:11 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 20:28:11 +0000
Message-ID:
 <AM6PR03MB5848E2CFFC021ED762E347BE99562@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Fri, 1 Nov 2024 20:28:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/4] bpf/crib: Add struct file related CRIB
 kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB584858690D5A02162502A02099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4BzadfF8iSAnhWFDNmXE80ayJXDkucbeg0jv-+=FtoDg5Zg@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAEf4BzadfF8iSAnhWFDNmXE80ayJXDkucbeg0jv-+=FtoDg5Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::10) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <23ebc04a-8400-45f5-aefe-e3f9d2091fff@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PAWPR03MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 122ddcb3-6999-4301-e999-08dcfab3b438
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|8060799006|19110799003|15080799006|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0gwcEd2Z0l6ems0RFAvTzRsc00yZHR4N0dxd1cwZEw1SzIwUHdFNWtEQWxX?=
 =?utf-8?B?d1QxbFpIajFaeUFGVXdkMU9UVDNmYTVZc1R6SEdGTmlEMkl1SVRMT2UvWGkr?=
 =?utf-8?B?bDBTWWVWeHBPUVdzdjU1ZktTczFUVmdjKzNXWDY1Z21Kb3MzU3Y0cVpZa1Yx?=
 =?utf-8?B?SlhuNnMwUWlVVjNRTjZEWFJyRmx6WGkyeWRIR0VDWWsveXVvUVdOODFDVGtJ?=
 =?utf-8?B?UU1aZVNsSmNmVmRpTms1OUZKNk9JRHh4V0U3bVBXWVJVZ292NlpMck5lV2xF?=
 =?utf-8?B?THp1Z3d2NVlvWDJuenczLyt5SFRjV2ljb1JIYmlGRWRQcUpTRGJkQThUT0JX?=
 =?utf-8?B?b3M1OE1RREY0WEZ3Ykg2Z093aTJBMFMyVHM2MURJRWpEMS9DZHgrcGl4SFUx?=
 =?utf-8?B?a0VpN0pQTHdlZ3pTMkZqNlhTaytQbzFWYnp0b3FLM3BONGhuVEs2WTl3enl1?=
 =?utf-8?B?TFYzMkRRTzV1Mkc1aXBHOElHTzFwN3FZdVlYdkxEd3pQN2VZbFZLT25rRmJn?=
 =?utf-8?B?WEF6WDlhNGQzd20yNFVmbi94UVdVZW9ic0htYXViOThUSTFuWlFiM0JNa2c0?=
 =?utf-8?B?SUxkQWZrdFFJYm90YnhaWFZmSlhxTWRUa0F1MnR0Q2V6dDRIcmtnZkRMZ0l0?=
 =?utf-8?B?YWo0aENhbzNHVUNMN09rR09vQlkvL3l1bFkrbEVZUDU0bUN0YmdZM1ZmQW9M?=
 =?utf-8?B?WGVQQ0RKUGlKMlpISy9SVlRibXk5UzlGT2NyelN1eWVCcEx1VTBrNFRiamZR?=
 =?utf-8?B?amhhcFRHbE5wU0NjVDhOcldJZXVHaUw5N1VWbk51WW5nVXgzTXJ3RGY5SlNU?=
 =?utf-8?B?K3Awa294WWZMcG8zZVdaYTlselI5WkZHa0FUVG9DNW1NcUxvb0NheGkwbXRm?=
 =?utf-8?B?TXBkT1ZpNWd1YkpiRFpocHNhVXNlbmV6SndWeGNZZURHZDlleWlMSWFMTTBk?=
 =?utf-8?B?a3JEeWRnaGJFQXNXSGVXRVdINzdEWm93MFZQZTdXL24xS3hKcDQzUnJGQlBB?=
 =?utf-8?B?TkdzSnVUQk1La1F6OVIzQTd2QjdIcnNibEx0Y2NUNE5QenZ2QWVLc1NraDdL?=
 =?utf-8?B?VzY0bmxPZmo2UmR4bnN1ZTBBS0VDU0I5ZGdTRzBOc2hjWlE5ZCtlUU9YNnVQ?=
 =?utf-8?B?bnN1L1NlS2dSQXByeUtsVzhCdHJBeFZrTC9QY3Fvc2l5cjhhZWNCRGFGWE1p?=
 =?utf-8?B?SDB0dUZQNzhZa0JHNlI4Y0xaQUpybGIvQ3c5em5jOHpYdWRVUjFLdmRvMGxJ?=
 =?utf-8?B?NHQwMFM2dW5sS0QyTTZ1STQ3cUYvYSs3LzZlRlFYSjBFb2xYeWY3MndPRkx5?=
 =?utf-8?B?MEVjUGFNK0JSZkRqSHljdUFVWTdrSGV0Z0FRd3NjbHNlaWx5YTNUVU1hV2Zz?=
 =?utf-8?Q?FVmIqIFFasAredsgfaaeNp8k6p68Iwoc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V045VnJlK3N5NStPaTgrRnN5TUE5TklLQnFWaEJwQjVybmZOZXJORGhoSW9p?=
 =?utf-8?B?VmQ0UzFoRW45a0toM1BoUWFveHVJREZNS09EVDdwbTRKcTl3OEQ1UE1mYk1D?=
 =?utf-8?B?b3l0YW9UUzArVWVGMGw2RVlPRDdBdVRiSk0xeE5nYURXODZpTURYWituOXBD?=
 =?utf-8?B?Ujc4WWFsLzFjb3JXTHdiSmtVSnJYUkZhMkdKaGJGTHBnQ2ZSQzNnYk1ta0dC?=
 =?utf-8?B?YTZoclBLOVRHQXdSVlUrY2lLMW1Ga0FPQzFBNTZCUGNWYUZsYUUwZC9zZFZI?=
 =?utf-8?B?NDZ0SS9kOUFZc3RaaDJOV3ZEemxXYis1NGsvQ2NESUZWNlpFY0VYN3hkRW9n?=
 =?utf-8?B?UWRWcC9JUkkrNmxhbk5WSk0wMXFscnljN2taM09uaG84SW9sL1VYYmI0cGhD?=
 =?utf-8?B?NGRod2tPVktRc2dHdkEvcmJFUkcxTXY2cmd2RWllbU00ekJ5SzYxcEs3Z2Fw?=
 =?utf-8?B?TXdlRGxlKytWTGRocmJmNDdjelpVaXpUZ3UvSDZqVzlPcERiNk5IRGNITGJa?=
 =?utf-8?B?blh0Z3ZaZE5yVVJTQ1o0eVpIVTFTTEFaUEJWZklDb1FqbldIL0RmU09EbUdx?=
 =?utf-8?B?UmhwT09RZUZkcmh4a043ZmJrNkJoRVpzYXZ1TnAwZEh4UlBkczBIQVRzbnpn?=
 =?utf-8?B?WUVNVlRIUWNQcllEbjBWeWd4elp1SER6MENqd0RKK0lzTG8yNlB4VUFxSGM2?=
 =?utf-8?B?cFJvbm5tTVN2ZWpnZ09GL2VHSStKTnYvVlVzaGdhUXowQmFTQkNiRGF3MnQ1?=
 =?utf-8?B?RUZJeWtaR1ZieXMyazAyblBIL25HSzVtbFl5NC9nK2FYU0V3SGZ4bU5iTXo3?=
 =?utf-8?B?L0RKVDdEaDFxWHJkNWxpOCtNNkIzYkhyLzNGTTBYOTdwa055QlNhbktBd1N3?=
 =?utf-8?B?eklYMkVDclBEUnhrb0pOREpuaHBwYVdMTHZYY2d1a0s0VGFoN0RhOUl2bWw4?=
 =?utf-8?B?SGVSZTBDMDJmVUEyR3N4VXhpTjEvZDVsVDlMVFprbmNqbHp0WTh2QXRzU0Va?=
 =?utf-8?B?UU5ZWlR5eFFMZ2tZZWt2Ky9WelQ5M3BTN2RlbFM3eVRoellYeUJOb0RyRi9W?=
 =?utf-8?B?Z1FIUlJBbFo1ZjZWZHJrOG40NlhZMFZQU3FGMzAzRmVpL0lxU3BOZEQxTmhG?=
 =?utf-8?B?bjlSQzljNlVKTHI4aGYwbHNTUmpNaFhLY1hzZm9YbCtEVXJab0FiajRiSkdz?=
 =?utf-8?B?RTBjdVRIVGVkVDhKc09NQWFVUTZodnFRVHZvRXZBS0pJNlYyUUlIUkhxR0ZB?=
 =?utf-8?B?bnZ1R0ZtU2Z4T1FPTGhLZ204L3hyTVdEbDlaTW45cm9ybG5sUWNqcmFoY2ZM?=
 =?utf-8?B?K0ovYkRBRXMyR1hwR01ReDVzRnpaM1FEM0NLSDV0RmVtbE9EMVhKR3RWVXNh?=
 =?utf-8?B?YnF1MVN4Qk9YdytUOWxPS2lvOFBGWW1ldDhraHAyZjdpemJrMWhBZjZOenFL?=
 =?utf-8?B?L3hId2w3ZGY3VTdjQitXclRuZjhHblE3MUJqakg4VWpxLytQV1U1S1VBTzl4?=
 =?utf-8?B?b0Vad2k5TUxOblBVbk0vVEpvOU4zTzBNekpZYkV2MjdWMDdJYUVlOTVlZGVH?=
 =?utf-8?B?UEo3Tytoc01WNzh3YnBDU3cxaVFRY1RuNFZhWVZEa0oxQWs4M2ZFU0p0V2V3?=
 =?utf-8?B?WWhBOGc5ZGxhQkdOYnoxNW04dys0dWNNWi9TYWNZNCt4WFJ6UHQ1NklkTTRS?=
 =?utf-8?Q?MQ2AZZycL9UgQXgCLJnS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122ddcb3-6999-4301-e999-08dcfab3b438
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 20:28:11.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9059

On 2024/11/1 19:08, Andrii Nakryiko wrote:
> On Tue, Oct 29, 2024 at 5:17 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> This patch adds struct file related CRIB kfuncs.
>>
>> bpf_fget_task() is used to get a pointer to the struct file
>> corresponding to the task file descriptor. Note that this function
>> acquires a reference to struct file.
>>
>> bpf_get_file_ops_type() is used to determine what exactly this file
>> is based on the file operations, such as socket, eventfd, timerfd,
>> pipe, etc, in order to perform different checkpoint/restore processing
>> for different file types. This function currently has only one return
>> value, FILE_OPS_UNKNOWN, but will increase with the file types that
>> CRIB supports for checkpoint/restore.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   kernel/bpf/crib/crib.c  |  4 ++++
>>   kernel/bpf/crib/files.c | 44 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
> 
> Please CC Christian Brauner and fs mailing list
> (linux-fsdevel@vger.kernel.org, both cc'ed) on changes like this (this
> entire patch set)
> 

Thanks for your reply!

I will CC Christian Brauner and fs mailing list in the next
patch series.

>> diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
>> index e6536ee9a845..78ddd19d5693 100644
>> --- a/kernel/bpf/crib/crib.c
>> +++ b/kernel/bpf/crib/crib.c
>> @@ -14,6 +14,10 @@ BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
>>   BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
>>
>> +BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_get_file_ops_type, KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
>> +
>>   BTF_KFUNCS_END(bpf_crib_kfuncs)
>>
>>   static const struct btf_kfunc_id_set bpf_crib_kfunc_set = {
>> diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
>> index ececf150303f..8e0e29877359 100644
>> --- a/kernel/bpf/crib/files.c
>> +++ b/kernel/bpf/crib/files.c
>> @@ -5,6 +5,14 @@
>>   #include <linux/fdtable.h>
>>   #include <linux/net.h>
>>
>> +/**
>> + * This enum will grow with the file types that CRIB supports for
>> + * checkpoint/restore.
>> + */
>> +enum {
>> +       FILE_OPS_UNKNOWN = 0
>> +};
>> +
>>   struct bpf_iter_task_file {
>>          __u64 __opaque[3];
>>   } __aligned(8);
>> @@ -102,4 +110,40 @@ __bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
>>                  fput(kit->file);
>>   }
>>
>> +/**
>> + * bpf_fget_task() - Get a pointer to the struct file corresponding to
>> + * the task file descriptor
>> + *
>> + * Note that this function acquires a reference to struct file.
>> + *
>> + * @task: the specified struct task_struct
>> + * @fd: the file descriptor
>> + *
>> + * @returns the corresponding struct file pointer if found,
>> + * otherwise returns NULL
>> + */
>> +__bpf_kfunc struct file *bpf_fget_task(struct task_struct *task, unsigned int fd)
>> +{
>> +       struct file *file;
>> +
>> +       file = fget_task(task, fd);
>> +       return file;
>> +}
>> +
>> +/**
>> + * bpf_get_file_ops_type() - Determine what exactly this file is based on
>> + * the file operations, such as socket, eventfd, timerfd, pipe, etc
>> + *
>> + * This function will grow with the file types that CRIB supports for
>> + * checkpoint/restore.
>> + *
>> + * @file: a pointer to the struct file
>> + *
>> + * @returns the file operations type
>> + */
>> +__bpf_kfunc unsigned int bpf_get_file_ops_type(struct file *file)
>> +{
>> +       return FILE_OPS_UNKNOWN;
>> +}
>> +
> 
> this is not very supportable, users can do the same by accessing
> file->f_op and comparing it to a set of known struct file_operations
> references.
> 

Yes, users can access file->f_op, but there seems to be no way for
users to get references to struct file_operations for the various file
types? For example, how does a user get a reference to socket_file_ops?

Also, currently the struct file_operations for most of the file types
are static, and I cannot even get a reference to them in
crib/files.c directly.

My future plan is to add functions like is_socket_file_ops to the
corresponding files (e.g. net/socket.c).

>>   __bpf_kfunc_end_defs();
>> --
>> 2.39.5
>>


