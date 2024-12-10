Return-Path: <linux-fsdevel+bounces-36954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C50C9EB613
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F246282BBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06151BD9FA;
	Tue, 10 Dec 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UjW51MZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2017.outbound.protection.outlook.com [40.92.90.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498519D06E;
	Tue, 10 Dec 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847692; cv=fail; b=IYziIl8Z3bnhRd6UMZ9zB69Jy22qBiSClPhghag3pqnyJ2IaBbq87XavXOXJ4R/YVJM84t1Ilm5hVMenol7AgPSVcho4m5Bpm4jX69lOWXW0nooysxXu4IVPKLdZbUk662R3uTetRWWWp+IU8S+91m3AVALvGgDVeqOG7NCGrps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847692; c=relaxed/simple;
	bh=3Z2PntF9fLk3+0rOXd4++eCNxa3KLueqNqfKYOFRsIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GumKy9Y+/NiZy+eueeo+CXjgFS0vRkpgiZSsRyp/YQGsj4CG/pvH2tZEh/aSnHWdtgsshMlwT1/udVnnyput+leA02N9oR0eoax6ML7+skyScQ6dxpZpft/Iusf5P7f6CKuHtQHC6Fe9tCDfhF4WAsESprtegXhCGYkJm/XIs4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UjW51MZa; arc=fail smtp.client-ip=40.92.90.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGe58omvbg+rZEfWPgz/IwSGav6BKayhGhJdks/RAlBZO3r1B1KA+KwQjpZ71koskE8xcSeTaReBoXpNczq0vHveOTzi83lnOeLY5TAfJWNEyfO5Ni7Bzi2CoBvoiif8e3qtINRUmXLW58myUuD2gNOlDjIJMezMrgPZoQjrJ8/g9inc8HMUtdsY7XYM/0pWxnFDrEUMlCx0wm1FRt/6Keu++nb80Jzs62wN6wn0T5cvZHuu2eO0m+yMdggjOFflLEe/Ch7ewb1v95tll9IViJM4eivq6soXuELUoUHMg804XUFqr0s9pynTDjRQGvNO7pTk1GIxEX5mzpSWUYI2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdfLkIxXZvxQd6n316+3xxotkC1xElAMJtczBA9Jl0g=;
 b=q/7nSm0cYP2G96s9zguLIHfyOlOXVaBoJFbj09myGBdS5fYbwQfbZwSv+LiuHgN5YcIOjS0e8ffPznTXozY0XapgfNJliawoB+2D3aG42xpS9T+O6kqpr97Bao98dJGSGGKn6x72fRQOwDIvY5SVwBFwqoTwkipziMYYWrJMK0spwyiai7mSppMuHt7nsd1tdg1r4ehYMzxiv8LlTbaa9rBlmSA1OKhBlbcQgZqJEomoq6XGVlMhN0hC9cDUnXIpN+XlA+E0HJBr1En3WgqVpDbEvb1OZrpY+reF9dzzpQiSQjCoJFNlHmbulNMT5QKhg2+lAVZAcgRb+0EEhf3pgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdfLkIxXZvxQd6n316+3xxotkC1xElAMJtczBA9Jl0g=;
 b=UjW51MZaCGQQ4+G8R6DR6TZ5y9Vvvce9bm8JbCGd7NPVRuo1auAIL4pxsq7sqSlbfwYJITVi4NPQXkc6YK/51B28C/1iTiQS2m0RVhRECHXs7Jyas/PU8W2lP0qkuSHN/xZ5WGN6BNYDj/3CkyikN1vdOfyDNN2wErFZN1CjepWeOIMIdY64coeb2g0lmJkeVmQTxjJh1hsnMZ1ZGkYbHacgA+xbK7DGaRaQxYAb70JDpgNTlvVLGRH5LlGnC6jSsLyhf/EOJ0O/rUmH/59F5zicDYgJ1+q8ZwBN6sXQtNv5JGp2SEpIioPt+lIp4BOGIAVsf1Tq14NDN1p4kKJFzA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS2PR03MB9671.eurprd03.prod.outlook.com (2603:10a6:20b:5e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Tue, 10 Dec
 2024 16:21:25 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:21:25 +0000
Message-ID:
 <AM6PR03MB5080248C764D651CBB1FA301993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 10 Dec 2024 16:21:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Add bpf_fget_task() kfunc
To: Christian Brauner <brauner@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080CD2C2C0EFC01082EC582993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-elastisch-flamingo-9271dc82c3a0@brauner>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <20241210-elastisch-flamingo-9271dc82c3a0@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0372.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::17) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <0e46e876-257e-4cb4-ae4f-c5c80ebba890@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS2PR03MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a01159-6fc9-416e-b5a4-08dd1936b173
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799006|6090799003|8060799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enNBakJjMW9vQ253b2VrZjV0aDJuYWRMWWtleHdGd0psYmtoYVozamhPQXYx?=
 =?utf-8?B?VUcvOGd0MU9mYm83K3MwNDBXQW53OEdVbVBnSlRQcG85S0xoR2cvVFVQRkZq?=
 =?utf-8?B?MXZwZjU1Yk9LazI1SmlMSnFHeWxBV09IeWtBVzhFVWZnSVJnWlVBWlpWbEpQ?=
 =?utf-8?B?WUlRWWVoSy85eE5wYzQ4R2gwdW9CMStDMzFIcFlrS1A3blgyZU04SlVRbTNL?=
 =?utf-8?B?d1Npc1VSVmRGWldrdDhQM1VxWVRJSlZ2bEtnWmZTdEJubWVNc1hMOFZyTWJm?=
 =?utf-8?B?UjlvU1hwM3psN29EMXg2WEpmVTV3MnM4ZnE0V1VjeU5FNENsUHRRWmNnUEpS?=
 =?utf-8?B?WVFhZHZtUDdWN3ZQQjRyR1pyUjhDenR2Q0FobEtxQ0RxUGN2SityTjk1aXZt?=
 =?utf-8?B?V2FHL1pXclRWWEJ6WHdVd0U0YzgzL011Rkh0Q25vc0tUNS9LZlB2bTM4MkJP?=
 =?utf-8?B?Y24yLzJ3LzNxYjFVeEJ1REFpcUttNGRwZUg2QndOaUw2dXZJOEEvT0Q3SFRS?=
 =?utf-8?B?K3NmaGFLK2NFbW1ER2NvVVBjWlViWGdEMXUzdWcxbjF1LzlkWDRYS1k2R2JC?=
 =?utf-8?B?TGx0YjdnY1NvK2lLTlljUTdHKzRBbkNxTjRnT21HYk5ucktuS3c2QUJNNG1q?=
 =?utf-8?B?ajBQcHhHU0RFRHREek5TZm1VWmJYL1FRVmxVMURwNUJEbitUbTJiTGNNNVpx?=
 =?utf-8?B?LzVEemMyeTNHOXpOZEtDN3RjSG5Za29hVGF0bU9WZ3ZKNHZGUEZhTGxZbitq?=
 =?utf-8?B?c3NyempCRVZxMXJ2dFkwdFJnRmwyWVRhZDhUS21XT1htc3JBOVJ5SU9rcDBQ?=
 =?utf-8?B?a2FoWVl4dFB6ekRVZVNqenZjaUN5SEN5aGNYdkRKY2s3VXBiNFJtOTlRaU9O?=
 =?utf-8?B?MVl5bDRNRTVEZVQ0cGJJR3hYSGhyWDhlMVFkRFlzdUlJUWlEeWVkd1JtZGkz?=
 =?utf-8?B?dTEzRDdPWWFEak80eCtXQUZzcVpob3RkZ2Q3bHNPb0l3NklvK2hjbGYyNUMw?=
 =?utf-8?B?eGtUS2ZSYVJ0eWtoWW5OS245SjdaVkhuL1BSMUFWWHJPTEFJUWhWa2VoMVdL?=
 =?utf-8?B?TUlYOU5wd0tkMGR6bEdqYzV5Q0l3VVRzSEpNZGo5VUNIZldHYWFkRzV4cVlh?=
 =?utf-8?B?ZGNlK21GWUZoWWwrODJVZm02MU14SmJXblhYaFN5ZFFsSkRIcHkzMlRSL1cy?=
 =?utf-8?B?REw3bFBMc1RUT0xZUEx4dGoxeHZpZi85S25GdjY2MW5yczFiRm96U1ozd2lN?=
 =?utf-8?B?RzFkeWhYT2tKcERxYmJBSzM3Tkk0K0swM2xjNEJyTW1wMU1UT1hOQkhvc2c0?=
 =?utf-8?B?SXJxZ0hVVGZ5QjEvZTh6dzFGdHE2U1l6cU1UdVBkckxJaE82T1I4NlNXUGVE?=
 =?utf-8?Q?z3/VtFTbup6xmMeGAihYltpw8uRCevc0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlZGdFk4Q1VESllOc0dxTWxrcmdKODNqcElDSGJtTkI3UUJqNU41aWJHV1h4?=
 =?utf-8?B?M01aUnBaZkJhVDQ1MUc5TmxFUExKTjlDbVNYckZSRmJHOFFpWGJrVEd5YmlX?=
 =?utf-8?B?bDk2ZTBWbGNVYXZNK1VaUU90M3J2aEc3WGkvTjRwZXFsSFNsajdFa1F5VkxW?=
 =?utf-8?B?MDdCdWNvbU5hWkxUdzVqQm9tenNaYVV3Umgwa0VJdEVIdVNzZ0NHb3h6NUFr?=
 =?utf-8?B?ajRsdDhFeHVoeTE5OE9NL3I3Zm5Qc2RqSHVtaHorTnY3dXhGUGV4NFFmYzRN?=
 =?utf-8?B?Z1NPMlgvUkF0Zmh4cTdBM1diTkIrTGZvUm1ROWFJSnR6SWtNRU9jZ1pmbWd5?=
 =?utf-8?B?ZjVzdEZ1YUlXN2hkakk0V1Rhb3JzOXhWMUpFSHpGUzk3Q05valF1TkFyWXRB?=
 =?utf-8?B?ZDUvMHg5c041azlEWVJxQXlJWXJWbHJEMjc3YzFIeVp5UGs3MmVyS2hEYmMr?=
 =?utf-8?B?TVRhYWxVaXhoV1A5NDBPeWpLM2wwUmt1T3QxWkxQb1RkdE85aWs1V2dudnBS?=
 =?utf-8?B?Z2N6d296R1BFMVV6b0NvSXBqa3g5eXV2OGFuZjd6UXhheTAxSU1HK0Y3OU9H?=
 =?utf-8?B?cm40RXVRKzlKclgyclNWeENmVWJIRENlNWZRTjNwWlRVVWQyVXBNb2xhb0h2?=
 =?utf-8?B?UkNwajJIUDBKRGZKcGVkOW4rbEhQN0hjZUhPeUFqZy8raEpwcndKUWpyYzFL?=
 =?utf-8?B?bHhSeitrUW9ZblRaUUhiNTdLcGd4a1NvSkU4SUpMb0RHQ3FaSFJQV1BBb0Jh?=
 =?utf-8?B?SlltL3dXYkNNbm83djBoYjVaNzdzSzdBUEEwR0szVGgrRXlTT3ZRSnFLcUlF?=
 =?utf-8?B?NXlyN0dlbFMxaXlacVNxVDlZS09BOUdOc2ttcWh3SGZ6cDJsQ3luQUd6UXdk?=
 =?utf-8?B?TDZIQXJpaFc3dkdDTTZVOEREeEpCbUFRb2hEZTFyZERtMWMzcW12KzU4eitH?=
 =?utf-8?B?RmVXWjVKNlJCbzcxVnFET0hYb3Foc2Jsdk5vSnFENXQxMUpOTVFZNEMzVy80?=
 =?utf-8?B?M2VzcDVxUjF0OTB4LzV5VXdZaGU4Nk9SWHg0eGxnSEZyMEZDQTZ3dmZaV0gx?=
 =?utf-8?B?bGFjZERsNENmMEVWL0tobFVMRzE4U1F4MFdrc2FDd1Fub3Vnd1JxKzZYSGlB?=
 =?utf-8?B?elBvMWpSVGFYNXZKQTVaVGtSdEFJREYvcHJFR2JaV3lYNGN6L3FmcnlYRVAy?=
 =?utf-8?B?T2dFT3NYbVFtakM1d0xVVURlbTdvSXA2bnN5OWEyNnVXbEZ3YTJ0Z3llSVNo?=
 =?utf-8?B?WmNXeDJXZUtrR09NWlN2WVpYalBhU0NXUTZNTW1aV0RlVnQ0cWJaenZDQ256?=
 =?utf-8?B?L0UyZjBFU1ZLK0VRc2hmb2w2SHVaTTdwc3VvZHJ0Q2w4NmljdVJEL3ZJL0J6?=
 =?utf-8?B?bGErekdPQXFkVmFUOVNoa1U5eVpqV1B3eCtOYzNsNlRuZjhFRmxPV3RUS0kw?=
 =?utf-8?B?d1JiVHFTbzZrK3h6THRqYitITmRWUkdTdEF0RitFUllKVUVQbGJHb1MxK0lC?=
 =?utf-8?B?T3BjUWphb2QwbkJTakdSemZ0b0RNMnZTQ0laKzVVSWwySGFmMGxmYlRBcGgr?=
 =?utf-8?B?WUZOdGtrSlB1TzBXKzBBUjJiT0E2OTdZVG5KZ3BiYmhWVWxONDZsdFZEdDZN?=
 =?utf-8?B?d2dqY1VxK09uTmVGSDNLbmRoTi9UbXBlb2ttdytiTno2c1JFWlV3L29VQ1Fr?=
 =?utf-8?Q?c4Xwq1rE2J8jejq06mUR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a01159-6fc9-416e-b5a4-08dd1936b173
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:21:25.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9671

On 2024/12/10 14:28, Christian Brauner wrote:
> On Tue, Dec 10, 2024 at 02:03:52PM +0000, Juntong Deng wrote:
>> This patch adds bpf_fget_task() kfunc.
>>
>> bpf_fget_task() is used to get a pointer to the struct file
>> corresponding to the task file descriptor. Note that this function
>> acquires a reference to struct file.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   fs/bpf_fs_kfuncs.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
>> index 3fe9f59ef867..19a9d45c47f9 100644
>> --- a/fs/bpf_fs_kfuncs.c
>> +++ b/fs/bpf_fs_kfuncs.c
>> @@ -152,6 +152,26 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
>>   	return bpf_get_dentry_xattr(dentry, name__str, value_p);
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
>> +	struct file *file;
>> +
>> +	file = fget_task(task, fd);
>> +	return file;
> 
> Why the local variable?

Thanks for your reply.

Uh, I forgot why I wrote it like that.

Yes, I agree that it is redundant.

I will remove it in the next version.

