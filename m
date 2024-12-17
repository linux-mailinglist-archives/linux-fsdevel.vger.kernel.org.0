Return-Path: <linux-fsdevel+bounces-37635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81FC9F4D52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0822F168160
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680A1F76A1;
	Tue, 17 Dec 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c/rDPxyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2022.outbound.protection.outlook.com [40.92.89.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CA1F6688;
	Tue, 17 Dec 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444712; cv=fail; b=up8H4O8g6buJfpUQGXadHaoT9TAGXeRkjqTdQ9LQzBisvqs3xfOoKb9ApiEAhTWzGaXX9zQHeTQuexNW0zA4uZKrWuoCAD7rIfxoH8FSxReoOWt1I+HH/rsXLlHlOCS1o3zAiMF+teSv9zTtf16DfkTdi9tHNhP0/F2DYEqbuww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444712; c=relaxed/simple;
	bh=lNQLWyT0aYIiEt4j1JFeCgLrpY18zCmf/pHXjiJAQJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAnQmkAYaUpF/zt1F4+qhMOQLqyTL6zSkqfAur/stc0ZW6tNJVZ/qxeSPoION3VNzlDMfFivFeWggjkOzbi52FjYe5Q0nCR9kEzdQN0ddHYLVYQE3ldnO5SspWN7MDJQUcGrc6d+gAesywuJyTJdWzSkSutcT9RO3i/kCjWhj70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c/rDPxyP; arc=fail smtp.client-ip=40.92.89.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfPpSaGE+sEuy+Rg50H8LKGzljPZCwWaeeIFvNldqOudW8aRcaLCvUYBLiZ/9kP5e7REFpjcDtVYOhG6hm2yjY015s7r41a4jhoWRunZCcfvOdn77js/k6yVyZd5z5HCjqnHe4XiwabWr9OnyYpMTu0PEpmt6dNcw12wb/tdPiO4S/oeRVteYsEYsyXUk74uxC9+f7M2t6BjjowGMA9XiWqHoEEyJt3exPR2T59go1TpwNkAG2pnfn6xgLwGTZSrIhvNUEjED5rmTahzi9RTA8juB0m5g7FS+J/U6fsD5HMtZlW/X+ujwnbMVdXK72hAt14rIPjFRYMUXtDEGSZd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n8VK1CA7Av/MO4RytZcooGTeG1GJnF3VWWmTD42KrI=;
 b=fY9bzVFoH+4lbILW8XxC3H5/4jAspxtu//+3gDQnbQvX5HRmFFYQmdXYn+4ICDhibL5XlFcrxxCOnMcTAA6F1WM2X5DR+AF+SzPtROjDROYDQY8NYc0sFBbh296YW2s7OvnaYufaaNprWqxUty8n6XToThpJqv5HbVyXWn6u6B6OCGFHPvrBky5sGScsZGYvhqfGzoATnvV3X7aodrjffQ/DYXJRVy2xoopieMqV/8wIe9AH97hMXrlQd43oL9Qxx8pJfzRT7JDMjXWM6owC11owG48vOMv0H7GQSR3BSQa6RjyRx14HwVJvTx8e2rnaTI3GTAJ2vAaGhYhDbqHSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n8VK1CA7Av/MO4RytZcooGTeG1GJnF3VWWmTD42KrI=;
 b=c/rDPxyPOwj9Hah3LKFYEKQcHmc17ORjlf/XUi/4WfQHMelyc/8HWRIMoSxT0pwIYwGHr5ariRhDeCfmR5sXLvBFsoZsa+BlDcl3tQMXo91l2g4DHogBGHx2kGXxkvBitU/W+e163EK+cu9uBmefze4v8mehHcNScjrS9uNTPUZC2GKXZvkxr3Zl8/SVr27+OeqUs+zgm3pe4WDd0IH9SKJthToK8F0AdgiNtH7oCT4Rqsoe4Pq9OWkFUuOb32lUEPZxilYlhPT1V+FhXVfttfdSkRe04+BJEXy911whtzaL6QZEH9igr73CXD9f+1W8O6nP1Yptt85ZM2bGBcxrdA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB7509.eurprd03.prod.outlook.com (2603:10a6:20b:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 14:11:48 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 14:11:48 +0000
Message-ID:
 <AM6PR03MB50808451138F84235B45190199042@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 17 Dec 2024 14:11:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL
 and TRACING program types
To: Christian Brauner <brauner@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <20241217-bespucken-beimischen-339f3cc03dc2@brauner>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <20241217-bespucken-beimischen-339f3cc03dc2@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <9a59c513-41aa-4043-9094-f591ae413053@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf30502-cc6a-4f67-2e70-08dd1ea4be4f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|5072599009|19110799003|6090799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXB6WE95RjBIM2dYWW5wT2NTYWt4RWpjS0Yva1gxUXA3NkpTRUhUZHRoem1F?=
 =?utf-8?B?UW1NcEVRZVBJT2Y1Z3pERHJqcmZzeE9yVWFaUTdxWlh0V1lOUWpqLzVzT1RC?=
 =?utf-8?B?U3Y5SXhkWlFvM0E1UThyUTE2ajkzY05wRE1BWUIzeWFpaWVhbWo5VklsVkJk?=
 =?utf-8?B?Rk5EZG01NG0zTFkxY1lyMHhMZjY4NVozWGVQY0VTNGNJQWpuRkVqaTBhSkNs?=
 =?utf-8?B?TitTeGdKeG5hb2p5dUlyQ20wZnpWbWszelpTcnlVZjl3bGl3TE5pMUNtc3Zj?=
 =?utf-8?B?S25OQkpMZThDMkdpZllHOHZLNUhsWThqeit3dnUzQzcrY000YVhweWovTWQ1?=
 =?utf-8?B?Mk5HaExRMXhrQ2VFc0hIMnk4cE9weXhiaElOVENvclQrQmlMT3AyeXhyalVN?=
 =?utf-8?B?VjhSVHU1L1JQZUZ6c1RVd1pmNkZtd2hqbjlvZ3Z5RFlLQ29pbDRmeGVDdHlC?=
 =?utf-8?B?bzhEWFVTMXl4TDhBOGdDdFZNOWhYUEZyRXIwLzV4dkhySnVYRkw3M2h4NVEy?=
 =?utf-8?B?d3IvdG43aW1JbUlTcTVCWjN4Z2ZDek85Y0lzcFgzajQvditPNTVrYm1ZRjRD?=
 =?utf-8?B?UjVQS0NrRFFWeHI2d3F0b1VTdStCemgwTUZNM2NiS29sZzMzdENQM0tzcjhY?=
 =?utf-8?B?aFdPUFJjWHJIbzBHbWtTT2NXc3p6RDZ4ZUREL21tMEU2T0YzZmUxRzVKK3Vn?=
 =?utf-8?B?Y04yelg5QkJCdmQyNzlLRjlDUk5ycE95aExHZFJWOUtydkNhRTdhMGY2ZWlv?=
 =?utf-8?B?ZzBiUXFWVURraVg5bFZPVEVFZ2FaR3pKVGFBZnMvVkoxTWdjQnBoMVFyOTFB?=
 =?utf-8?B?YndYWENvVHFwUmpXMGkyWFVQYTRvRUg2dVNDdDFaMGlHWURieW1IQWVWcXZp?=
 =?utf-8?B?a28zVENXMEc5WGs2b1hteWN1RzhaeVM0N2xnS29IZnYxSWVYWkhEamR4Yk54?=
 =?utf-8?B?NnRmQ1d0d3BpK1hIM3U4V292V3BOMm5ETVZUVkttZlZnbzU4Tk1kZ3FuSlNm?=
 =?utf-8?B?Nmg4T3Fhcmw5WEhKRFh5TjZxaU9WWENNWVo5RmRJMm4xb0NvWVRjWG94UmJn?=
 =?utf-8?B?M0toOXFIMzUrVXFyUWNWa2N2cEVVcUVxUHQ1MEpPaCtuUGFHMEJsdGFvQUxn?=
 =?utf-8?B?SWRMaG4zeW5zSnhzT1BFbjczb0d5WkRzaFRsaERNQXdFUkxOUEJBYWlMaHBy?=
 =?utf-8?B?eXBpOG9GQmI0WkRvZjZKMFJXeFZrTW5yeE5lMGJXTVkyaVUvazNHM2d2QzJh?=
 =?utf-8?B?UGNEcmJQd1dtbGxXRzVSQWJmd0RDUXpqR2tiU2VubzlpakpXV1pvZGFMRm52?=
 =?utf-8?B?djJWeGpNQmhkNHB5TGMwcERuMEJvM2U4bnFjNHBEVG9EbWZsQk93eDhiOEFS?=
 =?utf-8?Q?XE68GJh+g2o4wOKTj5ViMTP5j3c3pubY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVh2by9VTjZoaTI2b2pZY1ZZOU5VWFQvZWRmSCtpd3ZqV0ZMcjlFL25xRmoz?=
 =?utf-8?B?L2VmZmZKczl0ZXdMQ3lCajVIZmhPa25pNHpDTWtqWC9uTWlXU0cyNEMxR2w5?=
 =?utf-8?B?ZWNiNTU3WndBY0x4bWhpSTE3RDNhUXhFNFNZcm9JRE0yZEk0V2VIdDREV3Ur?=
 =?utf-8?B?VVBHK2E3V3JLc1ByeHEzWkppdUhzWVRzR1QvQlpRQm9CUzlXckh1ZFlNb292?=
 =?utf-8?B?SzZSbVdlaHNzM3o4MGxvVGxCSlBkM1NvQWFqbWd6eThZS2JWZk83TnVsaUNT?=
 =?utf-8?B?Y3RBbTJTbEFOTTB4SVNPNlgyT09oblUxYVRWWHA4RE1tRDhkY0F4a0hyYlFW?=
 =?utf-8?B?NzVJSHRZbWY0TS9DcW1aWTBlTjZoNTkrUEpOeGNEL0YxY3N2ZjZkc3Vtb0ps?=
 =?utf-8?B?Qyt4TkxIZHRpZUlwUUlBRHdBUnlsRmNNNHZUc2s3dGlmc3hWQk5DZVJZLzJ3?=
 =?utf-8?B?RmUrenAxTmxnRE9YOSt3WU9EQjNTYk5qUWQzUWpVRmkrYStTNFh4R04xL2tT?=
 =?utf-8?B?VmlhRTVodnM1VFFXRFUxQVFkeHRXdnNVY3djU3RxbTZrcEwrVGUwaXd0NFky?=
 =?utf-8?B?RXl0RDRmYUZrV0tZVUp5RlpDZG0zZTVvck1EdGcydnhmQlg4ZG02YTdCa3N3?=
 =?utf-8?B?Sk0zVVUzU2JRR2ZydnVUdW1rOXFRYWNPT0lSNXFwOStqbThyeGtDeTNaYXl2?=
 =?utf-8?B?Si9RNEhUWnFHRll6TTJLQWE3dytRb3QyeTZGeUhMZXNmZWIzMlpuZ1ZqZ0cw?=
 =?utf-8?B?VWZwM3VLUEVNcHZ1ZmExc0xTNFZpRjZjUjBHNGd5SXhoQlFrdzB4b2laVVZh?=
 =?utf-8?B?TzNvS0VwWEk2TTQ5bjdudEJmZlp4Qzc5WUd6L1A3QTlsdUdvK3FzaWhMNnpL?=
 =?utf-8?B?S1RIc3VOU2ltNW9wT2tMN1ZwUHBLVHFNWXlsTWlJOU41Qk1PN0NGRXBJdlBj?=
 =?utf-8?B?TlpGVm5waTlEZVpINlRZTnozRFZvTkpwVkw0Vi9xUHRqUUZ5M0V6RTlzVmJ1?=
 =?utf-8?B?TkxWcGplT3FOejNLOWFiU21HTmxnU2tybDZDUUZvUytXdno2YUlEOFRrSXJa?=
 =?utf-8?B?OGpLd1JvcU5ySUp0WHZFMVRCN1VEWG52U1dvTEpLWWJlcU1uZFlPN3g3MlBO?=
 =?utf-8?B?YVdYdDBhQTN3TjJGVU5VclRWTG0vcDZJdHpMb0dRU045blc5Zkc1RWxRVnZk?=
 =?utf-8?B?NzlrVVh1bnlHc2Q2alNSbkgvNTd3RU5sSHFNTWcyUmJzaTRjTWJVNENjL0ZP?=
 =?utf-8?B?ZXp6SkFWU2l3WjZaTE5FZ0NXamd3bUw2REQrbE9SWEJjRjhxQnpVK1hxUTNh?=
 =?utf-8?B?TnJOcVNibEptS29lYkNUbkJPNjJhVlN2Y2FGMzJ3OVFZNXRRUFBtQldHN2ZV?=
 =?utf-8?B?dlZ1akU0aTNEaEVITVVSWVc3NFJIbzV4blpFR2hzS2dnWTNNYUVSNEMrVkQx?=
 =?utf-8?B?Nk9uMmNBa3kzNWJGQUY3ZmZLRHpWaVVWVVN0MVVISWF4Qlh4VC8wdTh5bEpu?=
 =?utf-8?B?eGVNMlNsNHZPc0MzTE90Q0VyWTZmL0p4QTdFS29FTzQ5OFJTNWw4YW5vSU5B?=
 =?utf-8?B?NzRYZDhvZEdLS1hrcHVHQ09Rb3M2SE5LV0MyWHpIZ1FDVkx5dWd2VWFSakpu?=
 =?utf-8?B?S25BaTU2a3NkSWpHSG95Um9wTzZmL3Jpc0svZjh3dGlCb1hkVDdhSXpWMDd0?=
 =?utf-8?Q?tubHc0Kp3eDe/8YUsWSD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf30502-cc6a-4f67-2e70-08dd1ea4be4f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:11:48.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7509

On 2024/12/17 12:30, Christian Brauner wrote:
> On Tue, Dec 10, 2024 at 10:58:52AM -0800, Alexei Starovoitov wrote:
>> On Tue, Dec 10, 2024 at 6:43 AM Christian Brauner <brauner@kernel.org> wrote:
>>>
>>> On Tue, Dec 10, 2024 at 02:03:53PM +0000, Juntong Deng wrote:
>>>> Currently fs kfuncs are only available for LSM program type, but fs
>>>> kfuncs are generic and useful for scenarios other than LSM.
>>>>
>>>> This patch makes fs kfuncs available for SYSCALL and TRACING
>>>> program types.
>>>
>>> I would like a detailed explanation from the maintainers what it means
>>> to make this available to SYSCALL program types, please.
>>
>> Sigh.
> 
> Hm? Was that directed at my question? I don't have the background to
> judge this and this whole api looks like a giant footgun so far for
> questionable purposes.
> 
> I have a hard time seeing parts of CRIU moved into bpf especially
> because all of the userspace stuff exists.
> 

All these kfuncs I want to add are not CRIB specific but generic.

Although these kfuncs are to be added because of CRIB, these kfuncs
are essentially to give BPF the ability to access process-related
information.

Obtaining process-related information is not a requirement specific to
checkpoint/restore scenarios, but is also required in other scenarios.

Access to process-related information is a generic ability that would
be useful for scenarios other than checkpoint/restore.

Therefore these generic kfuncs will be valuable to all BPF users
in the long run.

>> This is obviously not safe from tracing progs.
>>
>>  From BPF_PROG_TYPE_SYSCALL these kfuncs should be safe to use,
>> since those progs are not attached to anything.
>> Such progs can only be executed via sys_bpf syscall prog_run command.
>> They're sleepable, preemptable, faultable, in task ctx.
>>
>> But I'm not sure what's the value of enabling these kfuncs for
>> BPF_PROG_TYPE_SYSCALL.


