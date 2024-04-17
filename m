Return-Path: <linux-fsdevel+bounces-17105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF58A7D75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 09:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEAD286842
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A466EB75;
	Wed, 17 Apr 2024 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="eC5vXzOm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0536BB58;
	Wed, 17 Apr 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340439; cv=fail; b=XwqxGaE8wqPZhlDz9TvDEPXqGR/Fl+tSChITLPxBkBoNlG/yw/0hch9UO5VGDtPoEZ4mlzpL3MDOkT5aWzTlLXtPi0inGarIa0voX46hohgzpr2TF7As6Sajc7++DKuMKs8UjNIHgrqv6dt2m7QeXd4Y3SGJx2ZJB7lRw2U1MX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340439; c=relaxed/simple;
	bh=Im3jNsP797sfcRHZ00HZPuzxTAbPMZ7Kf6Mwgsb1F8c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ingPvb4jqWU6/aCGwBFNn6dbfk33uLuYEC79t8B1F41IOFz04nNytL0GYf9F5U7tKQkZPKsNOXoLPXRonEXcqmjkK7HWutwGwarBMc8GJoa90rVP0WOiXStnuOxlAUtDLOtVOETHEy2AgKZgCWUV4opwHbzOus2b9pImxkFxGZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=eC5vXzOm; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrq5IHUn94IFTgu92jcEzyp5zMX6LRbH1RLrg2univY9pZKrql6mrccZZ6cXjRdtMP6s0du/VQrnzUkpqyxrAhfLXC9UdGpkuxVbLqzREqukRj2hN2MBQUoskEnwhOsKlR1dUPjo1QT70GJnUMtrQGC/WSOEwNiAyHSnIHRYsJVzlqX9tIzrcnA9LZqK83a0IiilQRQidm/GAF/iCA9XRXL/uzRLtyOJ6eERk321Q77qJuI0tllNlC9CB0LwtDId6lgzVlQXakiKVUIkU2LybAnFJqiQoyRFgZnK6WjuTwtka4tKLWkRzMRx/rRslOAXiVJpSFZWnMqSzGrS0uTvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m73cOd8mfIn2g9f9qLHzPmLWc3ZlvV41u5oLZnfakQQ=;
 b=l4Ag+vI9nyEVuJXYo2XSsdKb0/72sT8j3jvtwnyRZ3FNIvKf1InGtbMxXIWBa4FMQMt2qSACq+4mgy9Cvc8AyrDbF3PBiAwJ19TAL4TqN0HOTgWh9uvoFk2l+2YlUApUwPkQMd+eomwUmHUQH0qDr1t/onT5LmQ1tWXwBzEFwgl2ttPbSoiAM3wHtD2IqE+Qij8xHjIdrBJ1iYqNoaIFtICbsOWYGIBLSo2RzjDYpenTuEWRHxCVkSaCf1Eakm+EF1lK2GgwszizqQ8f3mKb3Lbgkv8HzVQ3/DtuAQKlQjd0VivL9GBFlwe45S6SLQpx+l1cqF4TIEURhvDyaCFY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m73cOd8mfIn2g9f9qLHzPmLWc3ZlvV41u5oLZnfakQQ=;
 b=eC5vXzOmn3oMiqiJ215xRtM1l9k22X2YzwYO83O00OmwjgcdWa3IpMScfm2lstGTpwQuMorTzSob/r9hLUYeHAgW05TZfTOfgijo2kTdDyCEcJB8vmptlsnaxZDqm3KC1bKAhk/k3yvsbtrBcmMS1bw9yRdaeEYDYHv+2RRL+mI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI0PR10MB8693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Wed, 17 Apr
 2024 07:53:48 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809%6]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 07:53:47 +0000
Message-ID: <935fea29-86ef-4cfb-a370-0b9616a0c279@prevas.dk>
Date: Wed, 17 Apr 2024 09:53:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seq_file: Optimize seq_puts()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
 <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI0PR10MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 91676fee-9447-45e9-faf6-08dc5eb38259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DVJS20mSssYqbv/u29p+TxCggDmsZt6y1Uu3aLyZ63m8KTFTgBXR/jaQi6UwM9ap8fI9t+b3568xh5nSWigN1s9ZTQz6DZew4R/yN2BrnlQ57GsWPM4BCJbeS8Fg03pB1KK9WGqJ7n85kUn/pEt90x0mk06ZcO5Fxm3lDDJyjnyp3tW8stXG2NOuQo+y9rnDnLFNXzp6AiFWXhNpsEPgztVmd15mm5XE9zcEpL2y5/UmAlso92RuP7REr8MvgDQRTKjznVLcNTe3G6VbxZqhh22PohbAy7rY4MUTdXXs3E76+89ReAD/ix2WuyH4A00NanMdgNle2KY/kmR2lvC0JaQ58px0mm6TGZEqG6xRn6hp/rKQHkWqDZIMluvktQRUjYIqaXtYUSXd481O9aFUxCNyV5cl6MkU2TJCj45C+7TcDZSlTHI3HtxF8yAEjHyFQfSRnHgvbwNFlvllRcvjJO8iUo2JXMeJJvRGBdUNuxoD8RV3dFZM6hbQmJ+AAB0j3lnm2wAqx9KGEqBaqOCTsUtUbGflkbyJdCDiJHQ9vtVqZAT2Vev68mWuzpJlfrbS3ahIuYHB4SQT/9pAmPhjumyRK1k071KaAcdROUuGVSzJxGQ5VkHAX/YIHX3Yl7GNFHiLZzlEH0DfhY71QJwy+v/AB6QyJqHgiwOiGaoubU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXVLSFlKMlo4by9TSmd6eWJBYVdQd01pdTY2eFltNTNiQWYzT2orSHdnMjll?=
 =?utf-8?B?Z1NNaElzMVNOeCtTTmVxc1pZWVFPd001bWRha3J0ZWVmSFZ5bXQ3RHZqc1l5?=
 =?utf-8?B?YWswTFFURk1xTzl2YmNHNXRNOHV3cXNhZGJBNFJOZUl3SXAwaElua0ZRM1Az?=
 =?utf-8?B?aktMZitqRTJUWE0xUGVUVWxZTzdjU0R6YzFMVWQ0WWdJaDdRRTQybUQyZk4y?=
 =?utf-8?B?MXRwMXhOWkVWV2hPb3UxRDQwN1ZNdVRlUDBxNlV1QmF6dm1JSDZIZFhpMmNm?=
 =?utf-8?B?VGNoSXVWd1NkckVod2pvRTNMbzlLR2VtMWZ0dmJ4WmtPQURqY2NFTmRGbE4r?=
 =?utf-8?B?ekJIMGY4K0hXWjdjdzhIY3YrYXNXMUZoTnFpM2Q4RWFaY0hDM3hzeEJ1dDE2?=
 =?utf-8?B?NUVYeGllNlo1KzRuOTZQb09LRUpHTTRsdjkxMm0rZXk3QTR3UW1wcU1KRlpq?=
 =?utf-8?B?d3J4U3FuTXpzUlVwRTNNMTFrekFaVVFzUG5LdWJuTnl3Y3V3Q2lSWDU4N2R2?=
 =?utf-8?B?azgwLzdyM0dZc0dsOEpQZGY0SkFNQVAvc1pRT25wTTBjVVBIVVRYVCtLRnB4?=
 =?utf-8?B?TVZpTzd5dzZTTjNOalhiK0NIZnVGdTNOd0NNYVRqSk1kcXhPZ1ZwLzJYWlQw?=
 =?utf-8?B?OFVhOFRuRXlyems0aStxTGhSdVoxbzl5OUF5M3JZWktsOVhQK1pZL3dTZ2w5?=
 =?utf-8?B?ZUphbXZCZmo0Y05VTFpTaGNrNmZJdUhPRVFBWkkxRXNXd0pyK0p6bCs4UC9I?=
 =?utf-8?B?ditmby9pWlNTWCtxV3c2MWluVmhYUFVHYTJkUzRnbld5WHRKbmxYWjFZVVNW?=
 =?utf-8?B?NXdwaFlXazVpODdWU0VSWGtGbGtvSXJZdDdud2ZHS0szOW5hQnQ4bHFkR0JI?=
 =?utf-8?B?RmNIQS9NYkt4MnQ3NkRmZ2krS3VuSUJjWUR1NTVzTE5DdS9BVlBvQlZwVUFI?=
 =?utf-8?B?SWhLeWRFSnkrYnZGckgvNFhGNTd1N3lRTXArRE0rQnVjd21BUG9QeW8zWkZQ?=
 =?utf-8?B?clpwMVdRcjhnMEd6eVZpQnI5Q1k4c3pzaHh4enhJVXlubVNlM014aGMxZ2pr?=
 =?utf-8?B?aEFWb21MWFIxNmJMUUN4Z1IyL1c1cEZkU1owY0NkME5TNzhYVnJjeWdlNndP?=
 =?utf-8?B?ZUhYSjBhN0Z6UUFKUERoeEJEYzRJNTJLRi9tTG52blJFckdiTFhPc1lHeXU5?=
 =?utf-8?B?Y0ZiM1IwWEM0V2NJcVNJVXhjTlc0RXFNU25kS2QrZHlWaWFVcXBZc2tyWWph?=
 =?utf-8?B?K0o2ay9LaWZONDdacm4xM0RJM1ZmdjZwdkE4Q0I1dlBjcVUzOUFTYzEvTnVq?=
 =?utf-8?B?QTYydStVWTdKZUtjdUNBQnBpQVM0Qm9GcVNjMnZRUzdQU0U0RlJjdWgzQ1FU?=
 =?utf-8?B?NXE4aVJoVk5TbW1kWnYwMHc5RG5KNEV5dVFibk5iSGl3TENJZDd1eUpsNk8x?=
 =?utf-8?B?VDMxa3d2eWpQaE50TFRtbUVwWmhORDlBeXVkM3F1TUcwSktKU2p3Tnh3cC9o?=
 =?utf-8?B?SE8za1YybVVaYkk0R1ZUcmZoTGFpNG5HanpKdStZK1ltWU5Rcm56dUc5T2t2?=
 =?utf-8?B?enNndVBKazQwcVI4TTVKWUFkS09vVUJGeTZHMVpFdE5IUXFOYU9hbE1vWW9J?=
 =?utf-8?B?Ui96NVBNdG1ybkE0OGhFQ0JROW9QT0lyOEJGQXRCTG5JUnkrV0RTaG1WZGZm?=
 =?utf-8?B?OVhYVXZMVU9GclY2R1JTSGxqSk4vd3d1dzR1M3ZXQTdsT3lCWkVxVlNXNU5Z?=
 =?utf-8?B?QW9YbVNqcVowMWZBd3I3TE5KZTA0YWJMb0NGbkQra0JtbnUrSDhFNi9yYVQy?=
 =?utf-8?B?TEFXejdRQjBaMEpLcC9KcHNCeXl4VTl4QStUOUYzdU16TnZEZ2RvNkhJeUZT?=
 =?utf-8?B?bkFLNTY2ZWJicC9DWEN4OW9LQU5TMFY2ajlMNHgvdFhEWVY3b1o5UDd1U0kw?=
 =?utf-8?B?TmNneFMwNFY0anV0VXB1ZCsrcjZXYk50VHhrL2JXQTVuRVhYR2k2TVZjSjN3?=
 =?utf-8?B?QVBnTzl1VkhBUktJbU1nRTZnM2YvdUVuWVZnSmZZNEhTQU1nN0NML1ZYSDFq?=
 =?utf-8?B?Rk1iUDF5R2lwSmRTdHJuYlNqRGRReHZGVGQ2MG05UStLL3dITVUvNE9zRU85?=
 =?utf-8?B?N2lwYzJJOUlVZC9PdnIvTDlQR2V1TDRNajFraGJoL29UWElLYTMxeXpqV0Nw?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 91676fee-9447-45e9-faf6-08dc5eb38259
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:53:46.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxv7aKE7EjMO4jp1j1+cRwSc7olUw/uDUn8x569TzaPqSjSKT9Y/KOdupn1G2xR5nmyeBK+bqxMCrovO4haiDkuPhHxNqsljmZxYuRwnMk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8693

On 15/04/2024 22.47, Christophe JAILLET wrote:
> Le 04/01/2024 à 14:29, Christophe JAILLET a écrit :
>> Most of seq_puts() usages are done with a string literal. In such cases,
>> the length of the string car be computed at compile time in order to save
>> a strlen() call at run-time. seq_write() can then be used instead.
>>
>> This saves a few cycles.
>>
>> To have an estimation of how often this optimization triggers:
>>     $ git grep seq_puts.*\" | wc -l
>>     3391
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Hi,
> 
> any feed-back on this small optimisation of seq_puts()?

While you're at it, could you change the implementation of the
out-of-line seq_puts (or __seq_puts if it gets renamed to that) to
simply be seq_write(seq, s, strlen(s)) instead of duplicating the
overflow/memcpy logic.

Rasmus


