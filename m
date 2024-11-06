Return-Path: <linux-fsdevel+bounces-33836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F49BF970
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF9EB21F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044D420D4F1;
	Wed,  6 Nov 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BPbPH0jm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2082.outbound.protection.outlook.com [40.92.90.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5E1D7E5C;
	Wed,  6 Nov 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933171; cv=fail; b=fUN5P5SLyjDgt+MhkDxMB4ZW2I4wrEXUcYfPXRQM5L055NEkmuPK1p7zgh66BmdOEOjTlelRVSmclEMBl2cv2EIGSDdzICUZfAoTCDK+hnwcWbE+yDocujuhn/9HWXLXeL9K5C6lzI31YnEFzJ4dMtsDmu2z+9ccpL+SC7pfKcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933171; c=relaxed/simple;
	bh=mody8pGjtk15Fv05MHtt1+VMhpMFGd6O1F4IGAuoVJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n8ARh20xGuOmj/+JOxwTVbthPtApJjvkBkLpEH2DVNAenONFz1+gcEX6eCcMTf7hoYMnXeDnsl3btlc39I3n7wJXd+MERUPIgwhmsirzciCQxPpL8Vb2FpGZDny0vTOc/ZbRKujj7QUy3ZLbjHSvuX4NC2q2YuF61qayTVI535k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BPbPH0jm; arc=fail smtp.client-ip=40.92.90.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjwL3KpdIiulJhqSd542PX5nnedSJUJbtxTjV6VB3YmbbZgTiT7/S+Y8edtjM/drc6Kr4oXBvc7dsfejGs5Px+5fCK3E9tH4xdEVmFj07XKdUyGGml+YJpmHPBLsHXtP0UcOg7Ni8D7+6WN2a1Z0Gw2M/TDdID9DZuurNk+dSyF83RVO/QOKW2+Bya0hTznTpCjRA7fnCTmGHCOiXIVqEwUB2MmeDGB3U5Oxa2k29L2NtjAxrSzwvO6lfKfn04Ny4gYcxHSmY8VDq5BD1UfRsOAY/pIFesPNdVdAz014TesNCXs3u0rqvXRs60CtHcei1jFq0JGQkElhiSTSdm8sNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXQooo7Xkq1ri3iAaL504gDS+mHxuw2Hef4PzidOkPw=;
 b=Epqk/fQY3YE9cUisLI8Mru7+7SlNGbkK/UW7kJ7ajESA5pUhRGDWOktZlxL2zv5Xm2NmgvwiHDwbZyRV+tGm+NI/NkgEwtWHYLHRAcLng0TXCBQNRJ6cupSY7tHQf/gJl5ZBclPhhFvBeWd7TTuCtlTL0ybNvESWOSik9M7U7lk3k0u1MnyMyQa6nrJ7fYAxMC+RodbNaxwtIAK9uOKGDvCrI0TLRhecZRZeSOgR87be+neQeYDWi22ZALTGe8WzXjpEqMMxkPoeEuVLZARXiqGWTb4TXd0RXR6ounR+YE/jWgl2DC4k+Ad6F2YIu344ewF8D3xLNIsiQFeLE12RqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXQooo7Xkq1ri3iAaL504gDS+mHxuw2Hef4PzidOkPw=;
 b=BPbPH0jmhFaE3BsD+36lb8EuAx9aTScla90N4/VofrrTBjO1UojzkZzXZHduH3Vmdjag0c1M7Ukb+MQSyKbURVBWCpbrcqdbicJSV0vr+u6WM9uC/fB5MmfgO6LI2o8CnQDkf6gOIe3mHkgXjFvbSJa0noCPXRil35Zg0Q8ToileI27AfckyF9D+zyKd6WyJ7j/BST1Jt2Fj5kB9IMUcSTdH+5aBQxSsfeY3xmPNdgNx+tbzZDuhapyWuEVhvd1Icq1ylZTVSpycf1DbIcwCPdgCyrFdoxNXwbP7A/6chxB32YH3NiFqjH/m5MC3VrppyO1UuJL0oNfw62WJQJdNNA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB6808.eurprd03.prod.outlook.com (2603:10a6:20b:29c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 22:46:06 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 22:46:06 +0000
Message-ID:
 <AM6PR03MB58485AC0EC31E8DA0D5169FC99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Wed, 6 Nov 2024 22:46:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/4] bpf/crib: Introduce task_file open-coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB5848C66D53C0204C4EE2655F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQKuyqY7J4iJ=FZVNoon2y_v866H9hvjAn-06c8nq577Ng@mail.gmail.com>
 <CAEf4BzYib5jyu90tJYSTEmhpZ-4aF135719V+A7J7pzMj7RpNA@mail.gmail.com>
 <CAADnVQ+0LUXxmfm1YgyGDz=cciy3+dGGM-Zysq84fpAdaB74Qw@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQ+0LUXxmfm1YgyGDz=cciy3+dGGM-Zysq84fpAdaB74Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0455.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::35) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <ee73d24e-4a19-4795-a965-33d5b218b367@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ea88a0-672c-4a58-2d29-08dcfeb4cce3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|6090799003|5072599009|15080799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2VreFU0NFBMQmNIeHpTWmJjcmpLTTdhZUJTTUIwUlJsVFpVdlNTQko1NDdR?=
 =?utf-8?B?MjFnNDJQUnFaS2NUSHBzazJSUzVwYmZnQXRNd3U0NjZCNEovODg1ZnQySFc5?=
 =?utf-8?B?dlhyYmM1NHFEWHdqUlRPVVpkWUczeVM2M3FQdktONHdsdElWQmR4QUdOUW9v?=
 =?utf-8?B?cURMbVljTEg1N094STR3YUNhVVpQNkdNNGZ5UnIzQTU2dXBGdkVaVEg3aEZz?=
 =?utf-8?B?dE1CZE04RXh0SmxKTDNJejZVWTNRS2pqd1dRSHRmbVBDT1JSajYyYkU3Y1p3?=
 =?utf-8?B?SkY1enplbGF0RW1yNS85NmpmV1YwQmtBa1o2emFBS0xtYnp4bXZOVHJzU1My?=
 =?utf-8?B?V3MrVFMvRGxyRkwveHlhN3hjMSthQ1pMRkNIV2FTWU9VMm9TaWQrdndxd2ZU?=
 =?utf-8?B?OVNTTlN3S1VoTVVpWmFCeFlpVXY2NHpUVTZPOUhGYlhLUkpheFV1c1UybjlS?=
 =?utf-8?B?QWV0LzcyU3lwZUQ3U1NkdkVFaTU1dk5XaE9jakM5NHhZYnZHNGhDZzBzN3lt?=
 =?utf-8?B?NStFKzVLeEQyY0NRVG9Mdzl1b1FtZmN5eDRaaHY5WkVZelRTT0Q2TzJGZm9z?=
 =?utf-8?B?Z0NrYTNLeTFld0JGR3QxeGVhQzc2MGdqcjZZR1Zaam9FVmdkY1VqK0xiZGdC?=
 =?utf-8?B?bUExUjlxRHNZRk9wQ3JYNW9IS2F3NWNZODZQaGVab1N3Z3BhbmsyeGhNM1h2?=
 =?utf-8?B?bnpqWnlKNTVJM2ZaTitBL3RqcmxKOVd2ODVzUmVxcjlUclVmY3dIbVgxWHpE?=
 =?utf-8?B?VU5lbnJCbXNTZzB0OGZ3b2NCY0wyZ0xlZkorako4bnNBQmxQcGxuRHpKa1JI?=
 =?utf-8?B?V2RUYzVUWW9PVzNqN2tkeSs2aUdERUZQQ0x0TjhXVmE4ckU5UG9iVHo0U2dW?=
 =?utf-8?B?cTBSN2lMR2lCbTEvaGRqcXMwSkp4eEpOZjBGV2tueGVRTlJYcy9lUVpDbUNm?=
 =?utf-8?B?SjdGRGhldWNIaDhKLytCR0lxMTBRekwreXhrZEkzUytvUEpGSGJwcHhjVGRX?=
 =?utf-8?B?S29qSnk4Y0o1Y1B5VDlwRE1wL2VuT1lJWEwyWnN0TlNnQi93Z3B3THQ4ZnVm?=
 =?utf-8?B?aXZjZ3RFWktXeHV2aEpEcDVSZlVRT1RKNms3M09TaUVMazhrMWExSWdHd3Y0?=
 =?utf-8?B?SUpZNWVsRWE5UnlvVWd2YmZ1cEFwdW03d013VDRYYjdYZVIxd3hUUTIvZ2ZE?=
 =?utf-8?B?NDg4aHZINGEyblhGQUhjVXJpV3NRRWRMSnd4Y2taOEd4SDlVUEtzdE1JSXNl?=
 =?utf-8?B?Q3dsNW52NHk3enl0eStvcDFTRm1wempkZzZHTTJ2bzFFQmVYQnZwSXZhSHFz?=
 =?utf-8?B?d3ltNjZpNWxDS2R1dGJEUVU5Q1NTbU5tTUI3aVR1VlJWZkw4c01GZ21Pa0tU?=
 =?utf-8?Q?rZDlRiMJD6WCG/bidRyvtTBKc44TvXKQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzJ4M2tEUVpOcUNzdGlqcEtyS3NpbldNL2NKZ3VLU1NtYkhHekJRS3FMcTRR?=
 =?utf-8?B?d2RyaUY3ZzIxNGNFY2xtcmVjS0kvUm5BSjBqRHVIcmdlWWEwQUltak90dHBV?=
 =?utf-8?B?MDlzN3MrM0RvT2tyWUp2V1RHWkhHeUdjWEhoNUJ0OWM4bjZRM1B4cEZpZDUw?=
 =?utf-8?B?ZUx1WnJRWGhXNXJNTlpVdHNLWE4xNjhIb3RDYnlDMlJEYVQ2aFA1TXhTMmZ3?=
 =?utf-8?B?b25MaWVhT0gxbnppcUE4TmxIb0c2a3YvOTduMCtvR3F5d3pBRmppblRtZnlU?=
 =?utf-8?B?R3MxcnBQTWV0RlMybGtXTWtWZUVMMDFlSlpWOUg2UWY4a0hYcDM0cmEzN3l2?=
 =?utf-8?B?dzhQbFVueEQ2Ni95UXZXcERiRG1Dczk5YVRwcWZJb25TRjZHUlJkSVNMdit6?=
 =?utf-8?B?VVVvNzVDWlJ0aFFkVWRPRUV2anZZbjNoakRUNW9jY3NzZHFZYzFxSzFVMTFR?=
 =?utf-8?B?MnBaZ3l1YnE0eHhMVFJBbS9hTm1vL0dKQ1lGZ3dJS0JUWktiN041ZUk1eVVz?=
 =?utf-8?B?OWRXMlpmcUJ4TnZnVFpxSVo0QkdqSVIxWWcwSHBmbUdDemIvdng2VXhiUUZi?=
 =?utf-8?B?UEpibGNQWEdtWFZPL0t1L1RsUTd0YXkyK280eEl6SzhiMk9PVzNSb25mUlF1?=
 =?utf-8?B?RWkvQmRlaWtHQWxiSVRkVUF0eXVIaWZIQWNUSW9FUTI2VmprbW83emVJcDZu?=
 =?utf-8?B?VFB3eURDdWloMGVVT3ZjSkFJSVpHWjI3eXVsV3c1bXp6N3VXZ3R0SXk5bzdV?=
 =?utf-8?B?L0VSVEovVmswa1pId0J4cEJYcXpIZkFIZmtJMlJOeWJ5dDJNSTlGK0VnL2l6?=
 =?utf-8?B?OVdKZ0svaHBMWmk3ZkpwNnR2ZW1tSWdTaGl3bC8xenY2M3hVRWlMdDEyQ2Jv?=
 =?utf-8?B?TmtRdWNJL2hmckxVVEg3djVaZGJlV0d3djlwemFJTVgrYWpkYlYwcWtFdSts?=
 =?utf-8?B?NmFvb3FLNmxUSWpSQ3I1a2xmdmQ4TkM0ei9zNFhEclJsdnUxNUxHOW9weTRL?=
 =?utf-8?B?RGhXNG13ZXkwa0xZTkhYRkNzQnBUV0o4MGJqVWVoNEVUdVFvdDdrTlNpQS9o?=
 =?utf-8?B?S1gzZ3JyWjZVU2VpbzIvMGE0ekFQUUEza0N2cUZqTjZtdHRWdjJKbnFycFRl?=
 =?utf-8?B?NzRLU1dsZThyRkZRSzBVTG9uQWpZWE5oRFlINzZ5MFFIdktDMEZmQ0VNUksz?=
 =?utf-8?B?ZVEwa2dDNkpWeGUvSFdtVzNXYU16Ty95R3Zhd25vdHI3OG1VbE1RRmR0blB5?=
 =?utf-8?B?T1VZcU50NVl3ZGlTUHhlRXNseXRURmdxdTdjOFJOOVlmTjZIRmE4L3RiWWRn?=
 =?utf-8?B?QnNYbnlJY0tPcXNlTTZWQUk0a3VzalpUNDRHUk03MWpOVHRiVVRha1pmWkdp?=
 =?utf-8?B?OXJyQ3ZwWVA2NFRJWnVMQnIxOHNHaU1IS1AvYTBEc01WRmhNWVcyNTFYWE1z?=
 =?utf-8?B?dWNNRTdrUTJib1o0b0EzclJWLzZkUEt2ZVBqdDd2K01PRFMvZDY3U1dtSWdY?=
 =?utf-8?B?M3pGbUFZa2NTSWo2OTBnRDBJOC9YRHR1QkVONnUxeE9qNXl2Uk41SGt6SlJu?=
 =?utf-8?B?Mm1qbVhROUNDRngwU05xYWFJUHBZUXdGZDBJbWVMdXE4WEc4YXI2Q3RmTzVB?=
 =?utf-8?B?bmFoVzQwNTVybmFZTm1OVWxxOGxSS2lRRytjM2Y5SnVQdnVPTGpnM0ZJL3Za?=
 =?utf-8?Q?/QhOHxv/D1RUAy9OJtA2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ea88a0-672c-4a58-2d29-08dcfeb4cce3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 22:46:06.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6808

On 2024/11/6 22:13, Alexei Starovoitov wrote:
> On Wed, Nov 6, 2024 at 2:10 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>>> +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
>>>> +               struct task_struct *task)
>>>> +{
>>>> +       struct bpf_iter_task_file_kern *kit = (void *)it;
>>>> +
>>>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(struct bpf_iter_task_file));
>>>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=
>>>> +                    __alignof__(struct bpf_iter_task_file));
>>>> +
>>>> +       kit->task = task;
>>>
>>> This is broken, since task refcnt can drop while iter is running.
>>
>> I noticed this as well, but I thought that given KF_TRUSTED_ARGS we
>> should have a guarantee that the task survives the iteration? Am I
>> mistaken?
> 
> KF_TRUSTED_ARGS will only guarantee that the task is valid when it's
> passed into this kfunc. Right after the prog can call
> bpf_task_release() to release the ref and kit->task will become
> dangling.
> If this object was RCU protected we could have marked this iter
> as KF_RCU_PROTECTED, then the verifier would make sure that
> RCU unlock doesn't happen between iter_new and iter_destroy.

Thanks for pointing this out.

I will fix it in the next version of the patch series.


