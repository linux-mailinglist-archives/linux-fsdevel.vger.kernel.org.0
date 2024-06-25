Return-Path: <linux-fsdevel+bounces-22294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A11B3915EEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 08:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F4D1F22154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E609145FFB;
	Tue, 25 Jun 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SKY+camz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2171.outbound.protection.outlook.com [40.92.62.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B72BCF6;
	Tue, 25 Jun 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296965; cv=fail; b=aTzBQTV9hgeriOs3P+yWM6nuXXhGldirZmXWl8fUUPVWqD50vXsefuJOr9wUUxT3VslrH71jNgy76oubX5LzCNlAFpuISiKqnriKxkW9IT2DvkdE4wUi9Imld/+oyCzQ2JLCfRdBBCNemCI08t8fTjTZFH9LQvmSeRUrEJM/JdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296965; c=relaxed/simple;
	bh=0dsaRTBxZiRo7Va9RtO2FsRfNVNRHIHwbmeJBa2fkK8=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B5e2I/R0MSBE/P8dCV7AXr1jRGHOKJdNRn00AEWY2I7Rgp55QdZln6jdS1/N74XImlZGC5IA9WXEply7g+EuBnCpIB4slqn79oNV/9u8OAhZbZYswVn679KQntCOuWE+rwk8/qP0ECIlq+wo7jBYpgymntQVduhVWgGBqbLvj+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SKY+camz; arc=fail smtp.client-ip=40.92.62.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVKEczRI03bj5to5ZiYvsOJRbqifz7BWwpmoMZWrnpSkSdMSLpSyvMmv3kn8Qx5wwwsdXOF6ySWMGC4ZDrSvE8hn2Z6chbwZbz27Y1gRRXq4r3ZCxsZOZVEy/OatRJAkm9ZgLKcAeTUWzsduDF9xafCCJqfP9uoeVeLDuwuuLK4IXcJzwETf7mdKahMQWRHT+XRcKF994m2q7G3CiwB19IsoBt6mkJe6ogYZ1X/XYWpJmINKI8Fa/oCVdfl6l7Yg/zfk9idPLhIuTDGIDocyLWukpu4Eer57mteuLhYKoW0vEZOXycNSUgS2BBmCyLskPnPZ9RKmy6mIU++rMhO46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6zdtc1aeOF4xwvLNoan3k2K6fBx0DdQWhQ6F6UDZFQ=;
 b=h4ZnXY5AqXAlRPD1hrlSpdr4fzYt991AVzzyM64owGsf/VgCWgxDalDjVLG4IxGuUmAl1Bz2Tzoh3Y/t66rPLgo0R81ubztldJJL38NeGAxBmgiQnKprFEoX0g6oSE+rVoVpHz+AfAZAuToGllwEd1IS2EQxXmyY7s3FA7lL5P909O/ygQM4dVPA96CPMtRHUB4rVVanRyDpgBkOZDgKbI+WV4LRC1rDGYJtudqTd8hhIXIoR49TO6tmoEOytuj584aW7naM+J/Roda+1Rn2ZwDnhChPcTaqS5YhbSoxJwQzvUCya7XO5fj4rcs7ekIZJj/dN6OmeAiLJSnKPGpH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6zdtc1aeOF4xwvLNoan3k2K6fBx0DdQWhQ6F6UDZFQ=;
 b=SKY+camzPh1r7xHQmxHwG4u3wBbOdRjaofWEs578SKOss6jNQsWnx5yfJpxzchYHo8kcVIB3mLcfrUXYnERMq4nyEzq7S8N+A0cPUsV6a3s9uhb22cn8juRKTieZKNqNYCZpZqVYIHA+QKlIcW4UGSanXgvkwAnb1q9TS571Xx9nR117TJ3zshkP13rTtStsmd7vH5fXIGn29J8VqzpxvBhQ50spQ8nep7oILSfV2LHLq9ULy4GIahvQ1hxg6BQYkNakyPYuIUndczdfCHsGPJUf30zNMc1/CBDl/Zjt2sPISGtUyLzVF29FSefxdN9Bp13ATiQZRmy7cG9LtTjoxQ==
Received: from SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:97::7) by
 MEYP282MB4060.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:170::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Tue, 25 Jun 2024 06:29:18 +0000
Received: from SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4e8b:9d6f:dc5:3464]) by SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4e8b:9d6f:dc5:3464%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 06:29:18 +0000
Message-ID:
 <SYBP282MB2224E68F688DD74FFEA86AA6B9D52@SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 25 Jun 2024 14:28:34 +0800
User-Agent: Mozilla Thunderbird
To: zhangpengpeng0808@gmail.com
Cc: akpm@linux-foundation.org, bruzzhang@tencent.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, vernhao@tencent.com, willy@infradead.org,
 zigiwang@tencent.com, jack@suse.cz
References: <20240618114941.5935-1-zhangpengpeng0808@gmail.com>
Subject: Re: [PATCH RFC] mm/readahead: Fix repeat initial_readahead
From: zippermonkey <zzippermonkey@outlook.com>
In-Reply-To: <20240618114941.5935-1-zhangpengpeng0808@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [i5QxIOE9VtPBZxqDOZnIh2io2jps2r/k]
X-ClientProxiedBy: TYAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:404:15::26) To SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:97::7)
X-Microsoft-Original-Message-ID:
 <4126e46e-e5f8-4588-a2d6-ab61dc3f5af7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2224:EE_|MEYP282MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb2aee5-1ac5-471d-cf02-08dc94e02412
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	+C8wNU4NrwxKuN8RR6Z71xeQyQciZDMhB6q1u0AhYT8Y+TPM30Q80j/75sijfQTKXMRcAer7rDcOFqxw0jr51NscQcfb1ajYs+ShIo/Dq8h4Pt0ZKFnd7P5moYt3kFUzIyqokG5Kj+hfdMEauktYmpYx3F54QYfxpcE3RIFBPW0Jv9xA1MRXXFz2rAShZc2b0+YcMLBE0K5DygGObvk5VDZ13AhtysJckcTN8s+krkQJJSmHMTTFWOOyqeDDi1BoTijvCrl2ltlx2JWSIA8DIueKkTQy2FQZcV6U6hmBgOdSaYAgmU1e9z/tjcN7GzkdyoWhxH4HxzpwLvgQWMeHb/hBbl45JGI9GIpT2Kn4ktPowvWKLxogazStbxGlhpOEbaCXXmQM/4i2Oroj7fn2vI+R+hAw1/i2VfMyB+gXsomi8TggWT7Or3XUlLUO9eW/UOnE9a0Nsq7cFyWJcqWkhVlTBliPONvLK/etYuzBGLbVsaMgvp7c7vykVvPt34tyLLpFkN3IM/L+ZQBlvAI7mQmEYRU8gGZlnWphr5L/ihrj7JKTRZVYPRUEFpAhigBM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UENYRXJIYnVIWFVoK28rSllaK25tZzJwQXhFRWp5ODJ5U29BQzM2M2xZdVNj?=
 =?utf-8?B?UmVvZDMxZXd5emlFNHZQdVRQc24zMzhOQmp5Q0M2Q3hOTmdpS3pkWmhNa2Vq?=
 =?utf-8?B?alhpL1NxOFpxNFN0NnFHMmRWTHZDTGx6L1J4eEN5L25HZ2dzMExObVRQVlBJ?=
 =?utf-8?B?bHpwcnUwU29NYjZVT0lnR1pzOFdtMXJGejRoMjJZMG5yeFFsR00rZkJ5azhJ?=
 =?utf-8?B?eVpldTk4QzRwVW8xR1IreDRkUnArVW1RcDdmSVdaTytjZDl4UkZscDd3UUNn?=
 =?utf-8?B?STNUOG5vREJ4aE1UbVpNemE5V3hNNE1tZkVqOEpOajJ4MlNaVFEzTDBpTERv?=
 =?utf-8?B?Y240QXpqSUdiU3p1V1pWajNTVCtSOGdwbHk4YkNzV3NDS1ZHM0tRbi8rVDB5?=
 =?utf-8?B?MXVtMmRNT2NLcTIvVlB1WjVReTlNVk1pRDlpQ1ErYlZYeEcyQlhwSWRxYWpm?=
 =?utf-8?B?eUpYd05SYzRMajZyUzBHMWVFS3hQL3VGODBENk1IaVFwakpWT3lIaDhUb3Vy?=
 =?utf-8?B?elJJcHFqczZhaXJscVhVSWpUTHFZbWVjUEF0c2FGNlRBS29kS3hYTUd3RGlw?=
 =?utf-8?B?aEpNQis1bTVGUUtKdGt2ei9ocG5xYllkZ1dIZnRFVzVKWjVBZmQwanhmeHlj?=
 =?utf-8?B?TGtUYWhNUWNhQ3lKQm9ueTBnM1Q1aVRyVExyMjRJa3RFNE16VnJkYzFveDln?=
 =?utf-8?B?QzMwVWRNckdpekFrNHNyVkU2TUJvOEx6RXJ3ZjRua0hvem1OUWs0YVV2Qlo1?=
 =?utf-8?B?V2VuS0dVVDhHNVcrb3k0WEE4OW9uYnczSDdZZEY2T0lMVjZhSENHQi9ua0pD?=
 =?utf-8?B?Vm82NDhBSE9zSjlQSHRPcHpMc3A0aFhUUWFxZnhtb284RlZZOS8zdEFvOHNj?=
 =?utf-8?B?ZWZEMUU4QzF6NitwTkRiM0FVbUpNUWlKdCs4cFFLN0lXQStBOS85VktSVWp6?=
 =?utf-8?B?eGwxRlBnbWFRY3ZIR3A3WVN6dk5LL0VlcVZRRUpPSGl1WEpKWmFrRk9VYkVR?=
 =?utf-8?B?T09GaHRycEo1Z2EvbW03TGFaZW4xN0ErSDZVa2Y1NkJ0REp4MEJHWUViQzI4?=
 =?utf-8?B?RDBTT1hURktycnBzVDg3ZXpaN1F4Q29rOU9BRmFySVJFZno3eGg2R0Q0TmFT?=
 =?utf-8?B?SC9jR2w5bDUrQWRRWmUzR2wyZW51aGhnSTdkalczRzF0MkhhUllFRFhibHc2?=
 =?utf-8?B?MVFwM0ZXeTFncXJEeGJLd2xuOHNyOEpQT210VFliVXFhcDBmQnpXVERoSVI2?=
 =?utf-8?B?UUloMnY0WnpscDRFY2lTYnh6YVRya0R0ZGRzVkFTR0JVcS9MUktYZDNkTU1x?=
 =?utf-8?B?N3NlTEgrVGl1di93SEFIa0NBRnU4b2RqdENxMFFwMG1ON3J1UzZHcXk1dm90?=
 =?utf-8?B?YTVlSlNJUDFRTktBU2NFclQ2QTJ4MWFlSjF1dFdWN0VkcnVsSHlreTFQRWpN?=
 =?utf-8?B?VUhwNGUvVmsrcFRQaGxxeEhtS2NCTXhoamYxRWRBeHRJeFVOZjZaYmlPSDZh?=
 =?utf-8?B?WVdldkhwSU9MenpEaURIMElEaDVRTlRqVlNCRVBINzdwY0lVci8ya211ZXNK?=
 =?utf-8?B?NHBQS1hMRVJtbXJXakJuMVFuWjM0WHNyM2d0TUdTL2t1Y2p4cUU0K1ZMMVpL?=
 =?utf-8?B?MmhEeC9XemZITW9QWmdmcWJXb3Uwd1lsYjF4aTF2d1BhbS8vaElHdkJlSGUr?=
 =?utf-8?Q?7Zph7FBTXpK6iawdBWfB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb2aee5-1ac5-471d-cf02-08dc94e02412
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 06:29:18.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB4060

To illustrate this problem, I created the following example:


Assuming that the process reads sequentially from the beginning of the 
file and
calls the `page_cache_sync_readahead` function. In this sync readahead 
function,
since the index is 0, it will proceed to `initial_readahead` and initialize
`ra_state`. It allocates a folio with an order of 2 and marks it as 
PG_readahead.
Next, because` (folio_test_readahead(folio))` is true, the 
page_cache_async_ra
function is called, which causes the `ra_state` to be initialized again.

