Return-Path: <linux-fsdevel+bounces-37103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE4C9ED887
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0D61887CC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD81EC4D0;
	Wed, 11 Dec 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mso4FZUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2010.outbound.protection.outlook.com [40.92.90.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD32594A1;
	Wed, 11 Dec 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952558; cv=fail; b=TcZCeDW9nIKefGxLz0nqFypozVk5EfYAQhx7ygfeAXSNyqJMr27xJ+vUFBY/VHeHYDxJzAB5ZaLVJZhkTgCTJsWP+eJPsdX1nnCDxgHt0YSf9IVQoGHlCedzG6UAkThYAOEA8m87inHW0bxS4VIq4VZwmicD/iLJolfRtjxLw+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952558; c=relaxed/simple;
	bh=7NQjMDcW21NfbYbkhpLZwjaMOJSDUlZr663qyLQMB1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mjwaNfL9Ce3gJf+KER7TZz/seAyqO0LxEZHzlsh/CKHII5LNYwYAcJ5KpjSpPq6dI4vFfPnW6d4TPjBvNwU/rbm9NWpXiUNtt3sImDOk+KRqffqkAkWNdbbxsmoGiysfNzNSSnCmQ9Q5HXCmgG+yjxj6uRBxvx0ctobecNfr1yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mso4FZUJ; arc=fail smtp.client-ip=40.92.90.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq1V4Nz/zg7+HORXQBfgoKfWPeCl5gCHIe8O9OaYoh+KnwbyffeZWZJ7/50g8POxPyozhlVBCKVZTJJyANC+u6XWGFfvbr7a2kvo0GIXegTOI5ioGddE/47LVkhM3osrEWTdawfyZ3g/JIIEDHWVobpclMijqkV8S2sooLGCcUgnyeym4sVbPsmrhS0rbneEmobd9nvmqgXtwAtmIYlSE+NKbB7fKMK9N60XuaxOcO1lqD0aWCrXgqYUBqC19aib4ejhRBGFi4Z7OVMPI9Yi+N9ngwXgPO/SXzmNm1oqoSnYV5ac3bGVr7lxYr6SK4nwJUUbjPc/hm5ivGr2dUPIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/BcO+sAvI657kY+/Ji47DWctXe7O8XSzQxK5iMhUHQ=;
 b=px/qdM0SyJaWW9yY6IjKT5JrPQ3+s1i9rfMcpRky6neC/8xm+ItEn+Gwr7aXCdYUXJxLHIzMgOoPTNeGdlj07mwMKQxt9MlsN9VsoNjLrgBh0NV2lMuKVh0ax7fTewxPllPnIxREv6EJbZHBZEHe/sNhIsYz4uJTdrrtdEn7JmmO6tGNYODvjdvm4fKhK82Z2YgWiJhiTggpuA1Vi8uiG2JWsTVzdqyGBuUvYJQZs0aV7mymfvfaI+kXnBovIE1zTRxtEYrH+fIy9yp/ZaUwLz2x4IwU30nOtopyze7Jm/PulDo2xv2VV9lEJOsiotWXmanJikA+hbzAwVfQxjMxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/BcO+sAvI657kY+/Ji47DWctXe7O8XSzQxK5iMhUHQ=;
 b=Mso4FZUJHlO9k+7MsCnx11fAZ+0ouy7SrxwqcCpYYJo9ZhTGY8qiXHu+HK7fUi4Zq+TbO+MDej9jzzuK8XyVzYYqeTBnbOBqWh77TjlPt15wsBaigRH/NuvLOtUamyXLneNEqx1FxNZK0UeYBMBGTqxUD6xyX09gGI/zZRlfxJZTPj+Jm5j2rgi6/YgU/WCOKlqM7aIi7dbwerDfcfcupMrrpWijW6c7ALPUm5wzVgjQnOQ59vP6ynmqUf6rGoPKSDXGALayZuibQaj99yuPmgTEZSWlwY6pkavPCiKdmdKn4KJtOnqmLfJ/YKbCVMiJuKby+7dw0K/EfpXF47uepw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM9PR03MB8025.eurprd03.prod.outlook.com (2603:10a6:20b:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 21:29:13 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 21:29:13 +0000
Message-ID:
 <AM6PR03MB508072B5D29C8BD433AD186E993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Wed, 11 Dec 2024 21:29:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL
 and TRACING program types
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-eckig-april-9ffc098f193b@brauner>
 <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0236.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::7) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <170b24d5-0101-444c-ac22-58ed05f92e0b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM9PR03MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 27269254-5f30-43a8-7f84-08dd1a2adbb5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|6090799003|15080799006|5072599009|8060799006|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QktMM1hpc0JOanRLdGIyQjI2M0dMSy8rN3JXU1lyakxYTFdSUUZPRUtJeVgz?=
 =?utf-8?B?SE95VG1ibmpPSzhiSmdVbWdCMlR3bWlndU12YlFCaXE0c29KNVlnK0tudkxi?=
 =?utf-8?B?L2hCbnp3YUhJWUxQdkpxUGlOcWxBalFwODBqN0NSZTQxQkUrUG1COG1kdlZ6?=
 =?utf-8?B?L0RreVZJY1o4UGV0TVNxa3JIbjI4MU1Hd2grblNaOEp0eGpDSkk0ZW1PMHdS?=
 =?utf-8?B?ckJhSno3cnZNd0JHeUxPeHJ3SkswdmtHOFJnNkxwUUpTNlZYUVdyaWVtSDFI?=
 =?utf-8?B?ZVZQNnZsQTNRbFBCRHM2cXFxd05YcEhWdlljZlp6NTBEMXIzaHUxSU4vUmc0?=
 =?utf-8?B?eFhZdDlmcVV5OHNQUWs4Tzh6Y3dMNWdkVndkUFRRZUFKWjNIbGtVeFpaSEUw?=
 =?utf-8?B?bGFCQ3M4QmhlVzcxU2kraThZOGZodC9RVDVYT2N1ZXA3MnYxc3ZTdTY5SFFu?=
 =?utf-8?B?UXBjVVBPSHltUVpMampyWHp2MXg2ajVMeXpEWXhqaVl0WmllTk9rVWUrTGtp?=
 =?utf-8?B?YVNrY0FGa1ZqU3hPdCtZdTVjeGhTbE53MmJSajRlbTU0dE5WdXdYaHkvakZT?=
 =?utf-8?B?dW1scUMxUTdUQ2FnSWlqZS8yRFlQYmJUZFVhaEZrbUR0TGhVdmlIQjRVWWtU?=
 =?utf-8?B?WHBLKzJ2c2YrRUhudUE2bW9TWnlZdDJ1MzJMdWhSRXRvbjhscGFWd05IVnhl?=
 =?utf-8?B?TG5LT3lpZ2JWMEdNUjJsUS9SaGhVTk85STU5ajVMbEgvNHM4SGtMMEQxZFh5?=
 =?utf-8?B?NmZ2TkV0LytJdTBtUlJNSWsvTlp4aEcwcFRYK1N4bkEvdTFYMXZ5S3dFcEho?=
 =?utf-8?B?UTRvaCtRWnNweERIQ1NCNUdwM212V3BGTWZyYThJWEJQRk1uYXc0NXYzOFdH?=
 =?utf-8?B?cmRvdHlKS2dVTlRlUWdzbnhlTTEraEtOZjFyOWMyL3R6RXR1Nm8yQ2NxWlAv?=
 =?utf-8?B?SllDWmtZZStRZnBTT0FkZlpXRzc5RmJZUjBqVGxNVDZ3ZUxCRmwvSnhvSWxY?=
 =?utf-8?B?bzRMQVNnRWR1Q0Z5dXBXd2tQNWFTcFJYNmgrSWxzYXoyOUVTT1d0TWlTR29P?=
 =?utf-8?B?UlB0Q2VNcCtCRmlSMU04aGhtbldPcjVRbUhDQTRRN2wwRitKVTh0SkdmYk9B?=
 =?utf-8?B?R2JadDZQWS9Ia0xhOVB4bUJHRDVtRllCMGxRQ3pva214bVJFaGhSMC9yaEtN?=
 =?utf-8?B?UU5hVCtPWElxaHVUR1BqU1VHWUdJMjhIS3g1R3JXam9JRFZuc3Zrb3hKZ1ZH?=
 =?utf-8?B?NnJ5ck1UOHZUUWY0cFEvUmRhNi9DaFR3K3IrT1lMMmlEUXh3MC93Qk43akhl?=
 =?utf-8?B?RWpYWFJSdGFqM0dpZVVXUVg4b0JyS3hGZVpGb0lFMHVEYVlrOGx1SUpzUytz?=
 =?utf-8?B?MDc0ZnRpRUdnL2pPenlQYi82YzRSa0dwTGF3cjlKazk5aVV4ZVRRZFZWbXVr?=
 =?utf-8?B?V3NmNFJUWHZ2VTMrM04zbFZuWjZIUm81Ri9USm5xd0NnUE1wSUp4VTlqWVcy?=
 =?utf-8?B?Q1ZEa2p0MmpFaENZbi84RmxqcXMxaEpCWnF0c2tOQzNKZlJETStrQnZZZFZt?=
 =?utf-8?B?RHVSTmdHZW9YUFZSNnB3RUpyaHhxYnNTUmMrN3BXeTYrdS9MVVZWb2xHYUcv?=
 =?utf-8?B?WTE4MkluLzhsR2s1VDFLTE9PL0hsa3c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RllGMGxKSnVDRE93b3VnQlljVkwwclN2aTJaYy9jbEZWMWRURUNSYk5TSTNI?=
 =?utf-8?B?VEx5SGVaaVNzYmtOTU9MQ3pJc2kveU1SN3FmNkpNaHNUcmRMYTBIcGZiMEZ5?=
 =?utf-8?B?cExLWWRWUDRONDE5ck9FZ1pjUlVXS1k5WnJGbll3MEF0bFZiY1lXTVFDUVlv?=
 =?utf-8?B?dWhpcTlvbGRwdURBRmhmN3dvWmlmL0JjYzdTQTFYNjZ5UlJyWWsrUWIzVjlF?=
 =?utf-8?B?MkVDa1ovYUNqRFFUK0R0ZS81ZDJrLzVxNzFNM2VxMVZCRTRxcnNLSFhRN0Fa?=
 =?utf-8?B?RS9McHVhOHMyamtCdlRJdVF2dkhnTXkxNkdBYXdQOGVQczhHelYzVXplQnE3?=
 =?utf-8?B?UGdPaVl2SUREOWViZW1PUGVBT2NSTmtZQUdTeGVvZUNreFRkQVZxL0lnYzhh?=
 =?utf-8?B?Q1d3ZU5lcVhQRVRQZmpXMlRlQXMzdk1STklhWThPRnltNHc5WXZmMTVCcWJQ?=
 =?utf-8?B?TXAweW91RzM4L2RpM2s1ak5vWGdiTEJxVnVJcy82T0g0WVpTK2hjUlJWR0Yr?=
 =?utf-8?B?SDZKZWRpZlRKSnhUbE5velh5N3FFUWpoRjBidS83L1ZnZG9sOEZmT0pDQkVM?=
 =?utf-8?B?RnJuTUlKaU1BQ2lMY2lCcDcyNVIyTGh2VnRLSUhqK01SampSMVdvY29ja2Jx?=
 =?utf-8?B?aDlEQzR1d0tnTEhYT20zc28rK0tpeTkwcnNSV1BhUm82MWNidVNBV1VSTDlx?=
 =?utf-8?B?RlRwQTlLTEdNSjh0WFlwZVR4LzRWT3hXb01jNFI1dkErcmZqOTMxYjJhV21h?=
 =?utf-8?B?ZzBLRWNBWlFSQ05YalBtb0wzL2hJMzZZWXRtMCtHTXU5MmNKempsVmxFamc5?=
 =?utf-8?B?S216Um90bEQzWFdiNFV2N3RjNjJ0aE1XWmNrdWxuYzRueks5OHdoT1RZK2hK?=
 =?utf-8?B?YVR6Q1hoaVRRellnU1V5SVZBU0dsR0NQTnVselNveXZReW93b1JGRFNhZGJo?=
 =?utf-8?B?RXhncHJlNnRRNFRFT0w4VlVrbWlVNHJpUUpEMy9sL0t4T1QyZWU1MFNFYjY5?=
 =?utf-8?B?dURKVmN3cGJvaDFzSnp2dHlQTDM2b05ub0JpUk56QTRHVm96eGd0UkV5bkJ2?=
 =?utf-8?B?Wk05UytRV3h3NlBvWjNhZ3MvTFZPc1hBNmtObjh3N2taVlVwZ2pxL3VoVktq?=
 =?utf-8?B?Z1cvdzN0UEduNjM3QTBLQ2tvM0pwNG5aekt4M0NyczBuR2NaRnoyM0xzdWs4?=
 =?utf-8?B?QlkvWGRqakRIdm9iMVNXbDhnWGE4RjI0TElINzc1bkloY25kMloxL3dESXFw?=
 =?utf-8?B?TjRGNGtNdXZMSjc2N256OFBBY1l3bjhycHNiYVdocFNLWUMyVTdjSjJoOCt6?=
 =?utf-8?B?UDlodmlyemxuNlE0L2FOREl3MkNESG54MFBNRm5ONDJSZmlITWM0cDFDTGJa?=
 =?utf-8?B?RVp5cWJnR0xFWXFJdU55ZS9xd3RhSFkrajhVQWIyOHExQ3MrcStaaFFybzJM?=
 =?utf-8?B?OHdPVlljMi9POFNxRnljMS96L0Z5ZmdaWFJ3aktIVEw4TnM2d2tDK3NVS1gz?=
 =?utf-8?B?UnUvMlh1eVhtTnlpMm43K05QY0pNZWtVSUlCT2RuekQzbCtNbTFobzN6TC9S?=
 =?utf-8?B?d3oxY0dOYlRlZXdEYjZtL3JGK0szaDFndDNHMFdjMll5YnZ5TTQ2enpmQUR6?=
 =?utf-8?B?YVhLWktRL0Z5UWtWTTlkeHhSVzRsZXVvTUZST0xDeVp5OGFzcjNHeksrTnNo?=
 =?utf-8?Q?dfDccexnVBz7sPg/ydPj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27269254-5f30-43a8-7f84-08dd1a2adbb5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 21:29:13.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB8025

On 2024/12/10 18:58, Alexei Starovoitov wrote:
> On Tue, Dec 10, 2024 at 6:43 AM Christian Brauner <brauner@kernel.org> wrote:
>>
>> On Tue, Dec 10, 2024 at 02:03:53PM +0000, Juntong Deng wrote:
>>> Currently fs kfuncs are only available for LSM program type, but fs
>>> kfuncs are generic and useful for scenarios other than LSM.
>>>
>>> This patch makes fs kfuncs available for SYSCALL and TRACING
>>> program types.
>>
>> I would like a detailed explanation from the maintainers what it means
>> to make this available to SYSCALL program types, please.
> 
> Sigh.
> This is obviously not safe from tracing progs.
> 
>  From BPF_PROG_TYPE_SYSCALL these kfuncs should be safe to use,
> since those progs are not attached to anything.
> Such progs can only be executed via sys_bpf syscall prog_run command.
> They're sleepable, preemptable, faultable, in task ctx.
> 
> But I'm not sure what's the value of enabling these kfuncs for
> BPF_PROG_TYPE_SYSCALL.

Thanks for your reply.

Song said here that we need some of these kfuncs to be available for
tracing functions [0].

If Song saw this email, could you please join the discussion?

[0]: 
https://lore.kernel.org/bpf/CAPhsuW6ud21v2xz8iSXf=CiDL+R_zpQ+p8isSTMTw=EiJQtRSw@mail.gmail.com/

For BPF_PROG_TYPE_SYSCALL, I think BPF_PROG_TYPE_SYSCALL has now
exceeded its original designed purpose and has become a more general
program type.

Currently BPF_PROG_TYPE_SYSCALL is widely used in HID drivers, and there
are some use cases in sched-ext (CRIB is also a use case, although still
in infancy).

As BPF_PROG_TYPE_SYSCALL becomes more general, it would be valuable to
make more kfuncs available for BPF_PROG_TYPE_SYSCALL.


