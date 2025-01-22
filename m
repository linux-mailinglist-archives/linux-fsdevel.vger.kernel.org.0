Return-Path: <linux-fsdevel+bounces-39842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C8A192B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 14:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25871883897
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0961C212FA9;
	Wed, 22 Jan 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VvyXo0yv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2103.outbound.protection.outlook.com [40.92.57.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A006B10E0;
	Wed, 22 Jan 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552980; cv=fail; b=Ggw5iOzKU//AQ3yGnleLDY1tuBkV7MOrVm+UP0y5nkUlRCznDfsigX2FDbf4qXKbIGzd2z+3gKhBoxHrnmnJCBthPDVpQNOz6rYhnIWydkrpYuUCDw0Aq7pB2V37InrNoPi2G2WMAQvSOMI+fZtZlN2DUHJ0XgEBMwCTTRL6p+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552980; c=relaxed/simple;
	bh=7tB2JMeOfcllCxf5ysNgT0hZTq4pc+aVzDMCT/akBkk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oAidoSoBT+2OXTEuQmTVlW8YNaBTHD4nptn2IW3zu7cOY1/5EnaB4nhW24Lin1mr15lNp4QFKBC8LFMt6iG+LDaaQTo/4WtcTavojY4l5Wgu80WMXTt3nVo8FQ0SbpaIJoK7pSug3C1QO0jid/vVckFwllnWCYj7Vbz9KkHK/Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VvyXo0yv; arc=fail smtp.client-ip=40.92.57.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOmI5FDwSNrpcf76wsUVpcVYR10N14J5zvlY/r0mqmVQNAt6vtofYNlE8tPev9bEWw91BFfKyRq/svFbWqJUR8pFb6Q4PSqZZTjK6207voTlcQaqWgsXhdlm/nIx52OsjZm5tfDZVAluIt/Y0vdhU+NyPndj89iUNOLnfqACDjQs8moXrXIaDLpZSlDB/tzbnkVvwEoKDn9vMyK410ZnDB7XEWZ1gbSjS7v0Jtpim4z2yG/o1oVQKHAQhuXsj4aMDG/QnBFF5lyp42s+uxS8FWezz5YYIlMSzyO1Eg68154IAJccpBdt4MJ8OuvVO5U2nmDV49gf7fqKrlhuVs6JYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryoDQDso9gxJxcxdj2HWOw6k80tr9222aDraJB64zx8=;
 b=taMBuEV4aAEj7Tgvb7m4TI4gnvXfb6nvm5V1wpyYIb5nmeeupaoScqhpY9IsgJ7KfUzRmoW/2ZwX8wYRh87rDNLodUQT315qK3+mDUm7aoHblvCI5VwBjXX38OjVDPpvE6s41haWqE7nfkq0YEwTx8WgK5k9chWd8WXmPsgO+wsHEjuDH0P5cGI6oA555IwnZh/oRr/xE0V+ZHsGlHTNUgNqaY/ZiZmoIHWN4BXxaocA5Ju7WGxIexveCcz5ArJnlwMEz+O+P8uWIYldrrEDlIDwL34NbOPTJd4h4SB/C9KLYMQZvBjTGTFel4klgxQe5/cQK+Jtrq3tg6hsOW1PFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryoDQDso9gxJxcxdj2HWOw6k80tr9222aDraJB64zx8=;
 b=VvyXo0yvrrPLHG17kDkRTTqTQ+Oji+dE0nZdcTjWyugiTEGJssCOgoRRCN0vVE3ZrCnYewZxW/pfrQmNujYHoS+QQKoYQH6xvk21++4+AnkRFNLEfanxkeqX9aOmJ3KhiAverqU10oM9F7pjkbc6k8FMLLqLpbNNgDIi0Qao1XBSS1WaXgF8PcKWTlbZoJEqYt3unWCsSth6es7hU1dBkv4cpr9+lpSbOd1al/Sf1cyFD6LfoPlOSty8gVoQWHal9+bqzCsOshHFCbD3BqTuV0GYag6O6651ABdRWGOOELwdSJhNZ4QuBzaqqSNXhir2nngBpqnRFGRWoRxHisRRhA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB8806.eurprd03.prod.outlook.com (2603:10a6:20b:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 13:36:15 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 13:36:15 +0000
Message-ID:
 <AM6PR03MB5080EA6AC9C1DCA2A2359D8D99E12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Wed, 22 Jan 2025 13:36:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB508004527B8B38AAF18D763399E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508081D38D00CD4AC299A8FB99E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <AM6PR03MB508081D38D00CD4AC299A8FB99E62@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <929af72a-6d9e-433b-aaa0-d82d32519043@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 339ec86a-82be-44b2-b957-08dd3ae9be93
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|8060799006|6090799003|15080799006|19110799003|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2k3UTZ2M0tLZFVNOVAycnRGc0gyc3NCVW85czA4RVBYdCtaWE9hQlF1L1dF?=
 =?utf-8?B?a0pDR1dDVmFUdlFvajhYZURrZEhTRHhWV1ZtQ2Rtc1ljcjFNanNYd3dGVjFD?=
 =?utf-8?B?a0hzSVpBaGphckZkZ1pyQWxGSE13ZWpWN0JLWng1enVtTEU0c1cvazB3RG5J?=
 =?utf-8?B?ek9NazA1VGt6K2RaVDBLanZ0VFpiWnRHU1BMRmhNODNjZXRvMThLM3NZWHh1?=
 =?utf-8?B?QU5OU1NtSCtsbFVMblBxTnVPYTBBQ2J5cWVwcjRxY3V6SGpWZ1pHTit6bk5B?=
 =?utf-8?B?ajkzNk5wMFkwQVZkNlRYa3FmZFlrTTFpU0NkMW1pTENaSFhwcUk5aUdremxl?=
 =?utf-8?B?dVdKRW9TVTQzNzFacHkrTnI4dVJ5U1NxUGQ1dnVmM1h5ajhDUTN3elNieFZJ?=
 =?utf-8?B?cGd4M0dyQngwRC84cCsrS0l2eGR2ZVVzTHBqNEJGVEZiR2FGMlEvb0pGcG9D?=
 =?utf-8?B?SnVMMEw3Yk9QRDZmeDBTSllQVDM1YTZvYWNYNjhjNm9BcCtXa2FUZERyL1o4?=
 =?utf-8?B?dHdnS29BOGZKdithLzBXc2hhNExnR1hTTkF5M1VTcjRFZDNYY01iVy9vMFdh?=
 =?utf-8?B?cHdJbWF1SmpkSWxLWUx4ZUo1eDh4ZjFlSm9iSytHUGcrOEVGL2hOb25qM1ZN?=
 =?utf-8?B?L3FIcWxHZThFcWI2VG8wY3R6UHpOOHJHSzlwTU9jZnpIVjVHR3NjMmJQTzV3?=
 =?utf-8?B?VDFEKzF3cXZMbHNaV2t2UUVHMGY3Sjdvb3hjcGhOR0VtSkRCbmZ0Y05WOWZr?=
 =?utf-8?B?SUE3RHA5YmRlYVdXczk2bHdQVGtYVDdwSDZCNllpVi82V1BicjU2ZXNjd3JX?=
 =?utf-8?B?bk1sTlRyOHFKTlJnT05SWnhTRFlOVmtDOGJhSE4zdkRLeEt3SHZBSkdkbzBs?=
 =?utf-8?B?VW5FTEg3T2RGcEsxV3BnSlRST3FsMk1PNmE0czJYQi81bXhaaUNMMnNvdzFt?=
 =?utf-8?B?TFYvWitSMHB2VkgwamJKT1crVE03Tmdqb0RtS3N4Ym5iOFA3VUx0TVYrb29x?=
 =?utf-8?B?K3k3Sit6Y2tmcE1FdFRmVGdBbjJGd2RMV0dkOW8vRmRvNFdFdFE1MkNxMUI2?=
 =?utf-8?B?VzFjU25LT0UyUmcyWVNXSEd6ZWNqRDRlOFlzenNUYVdSUUtLUXQyRktjbkFH?=
 =?utf-8?B?Y3pyRWMrZTFzQXptbXFPOUZ1eUhvMytPNzVDK0gzNllUR2JOMzdNcEwvMEJH?=
 =?utf-8?B?U2NHaEFreGI2R3JIeGN4Z3F0Z0ZtSGhBMmRWb3JnRXBpekw4a2drRHEvNlEv?=
 =?utf-8?B?K3VjT0dxQmhEbUFZa3VYQTZ2NkZycnhhb0hPYUlvOVUyakZWRDgrM2dtWTZS?=
 =?utf-8?B?c2JGUG5CNkx6RVUvVC9HVEZvNlloQU1HdUtuRVVxYWdFUHpXWnFvTEN3eE5G?=
 =?utf-8?B?RS9FeldwSFVVUmFOQTk0T2RPN2VBUGJxN3lZTnpyZHNSbkJKQVlsVzhlRFVq?=
 =?utf-8?B?WkdEWUhXaERTMm9RNWZXczhTOWlrREtTdDRXUWFCZGZuK1NhR3cyMzYyc09o?=
 =?utf-8?Q?kGyVZg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWdHaDZRa3BaUGEzbkU0bGtXUzExbHVKd3Z0Z2t4WU0xZDJYSUZUQStsU3RM?=
 =?utf-8?B?N0FhbEsxVGNPT1ZYS25hQnZGMjUxbndrd0F1cysvb24zS2pnclJMTVE4c0FZ?=
 =?utf-8?B?K1JUK2UvMXRLUHFReFhGaWpVam56MTFOcjV1S0dkaDFTNE5ZNHAwWm9HcTU2?=
 =?utf-8?B?K3ZJbEpCYnF0YTl1NmZXb3FqMmRzZ1VLaTBkNzBrS2tvWkxDQ0hBMGhaKzFp?=
 =?utf-8?B?Q1FCVWlyWTkwa0RDQnVISzB6QWxRZCs2MWNvM0JvSHRQb01jOU5WZGxPbnIv?=
 =?utf-8?B?aGRrMkk2SWNzYk1hRWxaTUllMnFqcmlvUG92Q1JTWnl1dUljLzA0U3pNam5m?=
 =?utf-8?B?WjUvVDFqbkRZV1RsVDJ5Z0dWcDJpait2QW1oaThXS2h6RmZzS0FWOHVOSmZq?=
 =?utf-8?B?ckFTZjJYTDZPaUhzZ3FQelpiM1FLdHBzNXB1TzUraWk1V1VhellHNWphRGho?=
 =?utf-8?B?ZXgwWWNPUXYrNkxHYytlVGMrdnlScFFxYUdTMTh4SC9tMmQ4dk00TjJ2YVFL?=
 =?utf-8?B?R1d2MmVsbFh1SnROODlWRzJIZWFwTnZMNXQzY1BqRFVIODZ6Y2dKZlJyN1JR?=
 =?utf-8?B?UjBrUmZPazVTODJRb09sdVVRVVI1cTM1V0x6SDlhUTVvZFoxYmtkUTVVOVl3?=
 =?utf-8?B?T2xQdkpMVldMNWlmdlg2TU5Ebzh6akk3bHl0SWliVUk3MWNCZ3lNTEFoZXZP?=
 =?utf-8?B?TklacFNLdldlR1BjSkdrNlA3bW92ejFZcmU5NUR4ZFQrYXE1RXhiQ05IUnZY?=
 =?utf-8?B?Q3RpYy9LZUR4dGFwWEdTSnVQSkRDNy9adHNVbmxBRWtHZlRvZjBmRm1aT2FJ?=
 =?utf-8?B?T2lCNFNpRzJhRlowa3ZKODkxdjYzVjJ6NXpBMzE2Q3dHVzdtVVl0OTRtY0hD?=
 =?utf-8?B?bzZkdzdCUnpPZjlEQm5xY1FiYlovYjNLNHZsYmY2UDVxRDY5SHVYdWZ4VXNK?=
 =?utf-8?B?RnNVdFpuSXN2SUpINHZxMEFPUndEQU1KcG9uanVScDN6Ulg5d0dUSml2TjFu?=
 =?utf-8?B?U0pJMDNvckp6L21McTRUOTk4MXlYdzFncGFSWmNiZlB0VlpaM01lbHovMmx0?=
 =?utf-8?B?Z3I0Y1g5L0QybC9JSTRHWGlrYmQ5MExoT051UmJqdm9CRlpBRVNwL1dhbTNV?=
 =?utf-8?B?RjNydFdBTU1TSmlGU2xKenZuaXpIWXBWdUdUUndnd1R6ZmtZcUpMNFduZWxQ?=
 =?utf-8?B?ZW9jV3NyU21HZnhxbXBQeWZDZmtUVnJkcTM0NGVZaUozU2wzUnAvd2tHV0Qv?=
 =?utf-8?B?d3FTdjF0eU85TG1qZDFwbTM2b3dCUVZMdTFWcWJGbmFVN0J5MzZ6d1g1Kzc0?=
 =?utf-8?B?MWoreFJRaXlMUWVDd0ltR3lURWhUcjd4dElyRWcxd3R3NStFdk1hYWhZL2p3?=
 =?utf-8?B?Vy9QVm42Vi9IM3pDOUpwRE43L0NySThab1M0a3JEK3c0djllVnFVc2VRMCtq?=
 =?utf-8?B?SjFFbHdmbHNldTNITzRCTUxRblBPOExTS29qRDVVR3IrUVh4dE1JbDExMWVv?=
 =?utf-8?B?WGVuaXMzMGFwR01kODZlVk5udDhaYkJOZmNKUmtJZ2VlZHN6Y1dxUktzQ3cv?=
 =?utf-8?B?b2xUZW9KNFBtN3lESG9NUENrYXRkcnJPUTE2WmE4eHEvMjZXcE8vTXN2TkRt?=
 =?utf-8?B?WS9tU0Zwa0QyTHlMM1NuZko2Q29xS1hvYS9WODJKRFBMYjYxa0tWcGcvTStz?=
 =?utf-8?Q?zST4yosvFJ59PbFiKs7I?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ec86a-82be-44b2-b957-08dd3ae9be93
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 13:36:15.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8806

On 2025/1/21 15:20, Juntong Deng wrote:
> I noticed that the errors in Kernel CI
> 
> progs/iters_task_file.c: In function ‘test_bpf_iter_task_file’:
>    progs/iters_task_file.c:43:33: error: taking address of expression of 
> type ‘void’ [-Werror]
>       43 |         if (item->file->f_op != &pipefifo_fops) {
>          |                                 ^
>    progs/iters_task_file.c:59:33: error: taking address of expression of 
> type ‘void’ [-Werror]
>       59 |         if (item->file->f_op != &pipefifo_fops) {
>          |                                 ^
>    progs/iters_task_file.c:75:33: error: taking address of expression of 
> type ‘void’ [-Werror]
>       75 |         if (item->file->f_op != &socket_file_ops) {
>          |                                 ^
> 
> These errors are caused by -Werror (treat all warnings as errors).
> 
> In this test case, we do need to get the address of void type.

I found out that these errors were caused by removing the 'const'
in front of 'void'.

I will add back 'const' in the next version.

