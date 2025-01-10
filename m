Return-Path: <linux-fsdevel+bounces-38914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6420A09CA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97834188F689
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 20:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C34A215F6C;
	Fri, 10 Jan 2025 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dC/lXUm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2022.outbound.protection.outlook.com [40.92.58.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09883206F38;
	Fri, 10 Jan 2025 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736542216; cv=fail; b=SyOXX+3J/eSCoeIJcjE+j/96o/46Y8jOA6WknGdz2POGQjIQ9/EpvHNFlEEYawQ8MWt00mCO+NTqVw2YdKTntuTI4bLB9ZmjsOP+4jGTQcriMG378Rgh104PFaqM7PPMLmy04F5TFl09VZVswoZGOFEUb+1yROJHnkfbmq7eeNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736542216; c=relaxed/simple;
	bh=wRrr9lswZiAPYCVD2YTyAMU6AmtHTninB5e+wWQ69Uw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BIlHK5D7t9sOr/7fx58KjvtT/YZA2/GdLkGz/V34AnLUM9HhcNTKoN5xVOGVvR0jrc7CU7PJUkWaIIpqIQ+NHEjgFyWYlknWQkKcp76oZg050tTAOCfC+othHNV+KF3skXS5zaqGJx+7U76ZBkrzR5QY7/tdvbcOVteT//xiANs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dC/lXUm0; arc=fail smtp.client-ip=40.92.58.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxGixJ+TRJEzUe/5T1J2OOtISFNe2liQgWSV9xDjLIwqNWtuh+RzIexeGdPfnWbK1iof8u8IyUCfPIFFxaamGojicVdA/jTDKo/5OkPsbxnmPdbe1dzvr5+3kFTJ5z8d77lomrmE6EJJDRi4fHxQts0S/8YjS1rBC//dRtoWS4CY0NLGmS+OCH36JEgA33+Zwf/CtJuZuea7UUgE/LnA7YqrO7D54moVMYeZgqjuaNZHJ6R8cJxsdaKSEoV4+1oB+XDdXwGUgA+X/xQmg9EkmMqsVGKkvFGZ6F/81bzwfcRT/Mq6PexmqvEP8nA/4m4jYz3waBuw0FD/FJZQFu42UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6yapK9t5HLTFH7vyHenQxPsBg+GTIyjw1jy6iL0Lsc=;
 b=EV7pJ0calUu4uF8sF/dro5ycpurP+EQJdGRvTwh6ok+vALdzAJof2ZhiUnXlPjjm8Z2ME7nIbJGIJ19qlRik1GhFyHvCnZxU+IrfYCK78GcTsCobtxQrqUdztDX0mSpYCcQIYa11IhF7kMuJ8wWJAWZgwcWOejn0/FDru1mWQYtI6PNDb23ThN8gUOcemZiOCyhNfZixT093zZJ9DnaE2F30BGQZyDYjtLj/lS00CPh/GTIWC9l3fhYwWFoEQcRGiwoSWTvEuetaYO6gzH9MTtYef/tHHdW4Rlgc2xiJWjLjD8yWUk+qJnaL6wV7mh0LtEwBA/4AILCUR0RSi03OEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6yapK9t5HLTFH7vyHenQxPsBg+GTIyjw1jy6iL0Lsc=;
 b=dC/lXUm0d3GOtR0D50ymmjF8OfpibMO9BVkQNSl0kcH8pbnuEXXRk2ENw4gkrWdlsOG6SYiKy8FkLGM8i6KNR7lYx3gwK7caQEb2mhXc5xwqYlMbPeLi72TehPA/XMmB+JgAbbw7VN7A6ZLfRXroZiLmNqtM2tR+l/+Xe/EClNWK1bv/c+ts+Gjyae1DLkMhZToYtNMXS20lu/m17kcNJdLjRFoj09LLQuLisrh0SM9+amsGoXDgBRhYufcl14scsk3VxOF2c8cM4ycM/NRlQd+xANhZ3KTpCR0VZNlorOvZYW0ouwU5/tFGUKe828rPerHKHR6Tsupr3pRn7Tckkg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI2PR03MB10595.eurprd03.prod.outlook.com (2603:10a6:800:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 20:50:10 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 20:50:10 +0000
Message-ID:
 <AM6PR03MB5080AC3D309A9072196E6C4D991C2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 10 Jan 2025 20:50:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: per st_ops kfunc allow/deny mask. Was: [PATCH bpf-next v6 4/5]
 bpf: Make fs kfuncs available for SYSCALL program type
To: Tejun Heo <tj@kernel.org>, Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 snorcht@gmail.com, Christian Brauner <brauner@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLU=W7fuEQommfDYrxr9A2ESV7E3uUAm4VUbEugKEZbkQ@mail.gmail.com>
 <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQJYVLEs8zr414j1xRZ_DAAwcxiCC-1YqDOt8oF13Wf6zw@mail.gmail.com>
 <CAPhsuW7KYss11bQpJo-1f7Pdpb=ky2QWQ=zoJuX3buYm1_nbFA@mail.gmail.com>
 <Z4GA2dhj1PZWTvSv@slm.duckdns.org>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <Z4GA2dhj1PZWTvSv@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0691.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <e364727f-7c8c-4394-90fe-5ca6940c0503@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI2PR03MB10595:EE_
X-MS-Office365-Filtering-Correlation-Id: 1274245c-dbea-4f2c-74de-08dd31b85fa2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799006|5072599009|19110799003|8060799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW5ReUZteFkxdm9PM3p3dU8rU1NkMENmM0RjVVdHZ2RjUTAyT1BtdW5yZUVI?=
 =?utf-8?B?cnlxQ2l6V0E1d1lVSjl2YmFNbzUvTVkvWVJzYWk2TVBNQXk2K2Faa3RzZWR1?=
 =?utf-8?B?dGxqSFVlQzVWaHR5ZDQ5OTdiWi9iZ2NINHNBRjZVaUwzMUxRcnFtMW5KVjZR?=
 =?utf-8?B?RldZQldyWkk5UFBQVjZoVWpJRytENThoelNkQW5ELzJiM2JXSy9iQW8zZWZ1?=
 =?utf-8?B?elZhaWhmc0xLaUM3cTU0c3pnaFhiT2puVkpYYzhvVmFhVkIxR3NyQ3ptWDR0?=
 =?utf-8?B?bXVMQzZFU2ZWSzgzYUFQL2tkeG1rSWVlZUVjY3U0ZENkN0xBcWxFWnlUcmVh?=
 =?utf-8?B?R0I0NjVjNCsxNmZtZWRsYXRiOGJDMGwvcG5QZ1d3ei9YanJSQXpJOFM1WCs0?=
 =?utf-8?B?cWlUMlAyK0EyNm5IVHFyRzVrYjBzTmFsTFQ3L2R2QTcyRDN1di8yZkorNmxi?=
 =?utf-8?B?Y2RzQ2I4OUJyVnJHYXNTMVkzL01zclljUXRGamJOczVYYkk5aDFkelRNV1dT?=
 =?utf-8?B?RUg5VEU0OEgwcWxicVF6WjQrREJ0MXArYmZjY1VhdEgxSHZXZVZWSnVQQ2lZ?=
 =?utf-8?B?cThDMmVyNjUzTXovM2FGVUttRUtPYUxjbnBNWmRFbWlDeWhRZFFVemFLTjFF?=
 =?utf-8?B?WUwrcG40QTN0TjRHelcrKzZkbG9jbFFIYXZObnhMNktGZitzS3ZtTTFNR1hN?=
 =?utf-8?B?cGdDRjB1cVZXMnBmdmlMMXJSeUR3NE9xQ3Q5am55K3J2Zkw3UmZvVWxrMXVM?=
 =?utf-8?B?OERqZlZMekVpc0YyQ3R0dTR3Z09iMXgzSENld3B0UjZvQzNrUmpuTjVJQkQ4?=
 =?utf-8?B?QlBjT1gwM3AzNzdNRjVsbjVNdkR6dk5QK21VSFVWOFZSOTlaN2xaWnlMOTdT?=
 =?utf-8?B?ODBqdTBGZ2FjdlZCUm9teGUzTEdEemRqdXR4N1pYLzcwT3g0S05lbFNSZmEy?=
 =?utf-8?B?WWpIL0gwa2dpNGRhVm14OWJSQ2pjYlVUT3V1Z05ESzIxUkk4d3ZLa2FIUkZ3?=
 =?utf-8?B?RmFuOHoyVUFZSksxZGhIRkVIbTloWEJZZ09BRDZBaGZ4YnJjUmJ1VEExUGZ5?=
 =?utf-8?B?ZGtOajdYZE9sNitqNmllNHBVSFhXT2x1NElOTFV2S0NnR0cyNVZkZjBnbmRD?=
 =?utf-8?B?M2w1OVRXRmJVNE9mUFY5QlBGSEQ0STZUSzN6b3pqUHpqSWtjQVNWMlYvNUFQ?=
 =?utf-8?B?ZEdDWnppSCtYYlp0Qy84VnlENGJUSXQ5N05IN1RUaHV0amtxSjQ0MjhYYVZy?=
 =?utf-8?B?Mk1keWJaamJ2dlArQUhOYWtEZjltaE9nMVRXclc4SEZWRGk0SU9idXh0MG10?=
 =?utf-8?B?TEw0K0dVVlBOaC9lb3Y3cWJxYmVSSEt4RTI1YStkbXFETXlkdmxrdDFiekNL?=
 =?utf-8?B?bWlaaHBrOW12bDV4dFZzZklQaU1ybzN3MTVzcVNCNUQ1SzJUeEl6L1U1ZjVj?=
 =?utf-8?B?dzZsVlc5VWw0WGpzNDc2UldSNDFPYlgxdk1jd3lnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3FUcUFXUDJvZmJLVjE0clVmZWh5RzdnaE5ldG5ZZmpCU0JNY2Ywc3lzdXpS?=
 =?utf-8?B?N2ZTa3JyV0lIR2hxM2tmMmdoNnQzRU1QRnQzdHd3UzVrRDhPcEM0TXQ0WWJo?=
 =?utf-8?B?SEZBVEUweGNHVGJBMUd6RHZUdUsvUkVLR0JCUzJEenZwWHNCWjU1dXdpVzNw?=
 =?utf-8?B?elR1WG5zQjRnbkpDaWorb1N0Q0FTR0NTcndBdVpwc0UzVmJqRGszY3J4ZFFV?=
 =?utf-8?B?UG9lU1RVWEdJNFlvK2hJUDg5Ukd6UjFYbFUzS1ZVbnNuRXdRS2NMOUkvbTVH?=
 =?utf-8?B?VURoMVY4d3NjREkxRG1HOFZhY3ZieEpnd0NmbUR4V3dTVm5SWlFlRlkvVkhD?=
 =?utf-8?B?Sy8vcWRXcWo3UjNvMHMwQ1JDYzBDOVJDelZXcFI2cGVMK2xOUlpiR1lnZ1lQ?=
 =?utf-8?B?dVV4M3dCeHVhbXl4ZThybWJjdTdjVDlpb0xCQ1ZhTUhJd1NmakdyRGtNNFJU?=
 =?utf-8?B?MmY1UHExNUFkRWk2Tk5oVFVnT2dIUFQzYnoyTVJ4Z29hL0ZoUkpZdmhveVBF?=
 =?utf-8?B?OWZodVJYdlBDRE5wMTh1bC9HRlhiMW40WFZuOXpMRzRQY1ZTWUM1T0JMNExQ?=
 =?utf-8?B?Z3MrTVhFZTRHb3hacjVHL0QvN0c1UkpHNWJpM0NGZFpCTFRvbzhiTTZvU2Mz?=
 =?utf-8?B?Tjd4eEg5SjR0NEd6ZmRkNHE0cUpDaHE4bXNpOG5hK2dVUDU2L1JROFgyQ2RW?=
 =?utf-8?B?N3NpSlFsM2NPWFFrbDNYWEZaY3dOZExWTVo1STdGZFI3TGV4L1lwNi9mL1A3?=
 =?utf-8?B?RSt3MFN2MW94R1NXZU53SEdiSkJJa3lNd2NJb2ZlVTBPN1lWRnNpZXdvZmJE?=
 =?utf-8?B?ekNuQjdqR1JXRkg2WFZIUk5XVDN4ZmZHYkNjSDBpSzIvYzFINGgzUm56dHZE?=
 =?utf-8?B?Q2tzcDZoT3YwdFU2R0NlWWJ2TUVvSFpvVlN2bkZNdE56ZXFucWx4WUtISXkv?=
 =?utf-8?B?Mm8zWncxV2Z2N2NFZGJ6ZTFOOU9VM1lwYUdQL0J2c3JBZVB0VHljM1c0a0FX?=
 =?utf-8?B?K0gwOU5qV2MrQ1BCYW9UbjNsNlJDTmNYVnplcTJoaHRmUnZoUFZWbGFHZE1R?=
 =?utf-8?B?RTh2WW9aZitzT0hKa0xtbmVzTzEyYXBUQ1dYem00ci9pODBuVEF4MzdKRzZ4?=
 =?utf-8?B?RU1GZ3RkSk9jeWJtdTBybXJWRG5jSVVsV3YwSUxzRVVjNzhiMHJxS1Rqajlu?=
 =?utf-8?B?SDZWbis1SWxsbnJ2TXc2R2k1WkpsZTFkWnMyNzZwZEJYcmNkNGJibitISjJH?=
 =?utf-8?B?SnJHbTNFblBkT2NSWDhnNjVPeXgzakZuajdIVmJHL2dwUzNkcUlUVDQrakZr?=
 =?utf-8?B?cnhjSUh2dlRweHhlZnpqeDZNUDRMZXM3WHBVaDlYOFdZeEU1Y2piN2VxaFh1?=
 =?utf-8?B?WFY1Vm9NNGdPUTJ3Q3hvUXpjaXRPNEVWaVZOUEQ3UjFrWklCWklqVWlWazk1?=
 =?utf-8?B?VHkxUlRmVFZ5MWpyWXJMcjB2MCtRdSs2NTZERU9CRUFHL1hvclluaFl4YUVh?=
 =?utf-8?B?REQ3ekczRitVVVdzNTRMMnJFUGwvc3VxTzRBamlhb085VUtpL2RrOTJDcXd6?=
 =?utf-8?B?Sy85RnNjdCtRbUFMUFh5ZzFLcHh5NCtzVENDQ2t5RzVINzVlRzV5T3ZQV0tT?=
 =?utf-8?B?bEFPdFlROFVyK2o5V1MzdzBrZmlWZjUyT3JBQWZoYitLdGRGUmp2a0xBL2hT?=
 =?utf-8?Q?IKQAsc6wbSSzo+iZc9ra?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1274245c-dbea-4f2c-74de-08dd31b85fa2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:50:10.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10595

On 2025/1/10 20:19, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 09, 2025 at 12:49:39PM -0800, Song Liu wrote:
> ...
>> Shall we move some of these logics from verifier core to
>> btf_kfunc_id_set.filter()? IIUC, this would avoid using extra
>> KF_* bits. To make the filter functions more capable, we
>> probably need to pass bpf_verifier_env into the filter() function.
> 
> FWIW, doing this through callbacks (maybe with predefined helpers and
> conventions) seems like the better approach to me given that this policy is
> closely tied to specific subsystem (sched_ext here). e.g. If sched_ext want
> to introduce new kfunc groups or rules, the changes being contained within
> sched_ext implementation would be nicer.
> 
> Thanks.
> 

I think so, it would be better to use callback functions and keep
this part decoupled from bpf core.

