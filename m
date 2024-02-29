Return-Path: <linux-fsdevel+bounces-13213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B090886D3E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 21:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5110A283F04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 20:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A9313F454;
	Thu, 29 Feb 2024 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="oTLih9Uu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84313C9F7;
	Thu, 29 Feb 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237134; cv=fail; b=nohZkOJLaZQET6abXj326d8rXqvZ9+YHc4X9J/nqF/ixOAecPwfpTnood2Sr++rN8SnkI94A8Z6n0ION7vqO+yeH+h4UppIilG6VMEmeAF230VP8njyVqvQhwG/acJ36lIfqGHD2KDEQXXtS/MDRdpsLp9JaEFD+gQsA32BrbOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237134; c=relaxed/simple;
	bh=ytWBX9mnTLujTSg48WZJ4SuNViTfXI6IJIQLfvw/a2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KLI9ogsQ97Pd7FHiuLIHYcjIEhn4zOFTsTLLQkWW7Ihueou4cPqXns0P73V3N7XFeuQeZQngEOpeZ/EPrv0RyND/jPw1bzUVrY7SIeOTAcUMcAxBkhe/g4BP42+FTfuVWLMAaDKHux5WVHQ7Q721v8PVFWSfO4or6apmrRcG3NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=oTLih9Uu; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41]) by mx-outbound22-148.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 29 Feb 2024 20:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz5B0WimP1jW86YGRmdCvjLBWeqy6T01dv5vEYxBlORqLGVYCsH3cY4JfRyTA0w2BijuS84bADA+5wBsFo1pmjk68UwWXj3TnsAV1Z3PaKehYGSnFyGc1PMTJEXs2eirIpnFCcACzDtfTR2gI9rSgATl4Y/dntqPk/CsHchL1TSNWAP0hQ4yPOtmOkQh+2RY+Hs9bCxCEfyE+6be7qo1Pxp9T8l1wyIs1CTdz17Zm2dPb+Ta87i8NTU2NIAiaTVVRMqXI9vb4+ca/6vteQaztOAU8QVxyJsgjHZ+c5ie9Uhr84PpOc9trSoBtcnjImwCF1D7OWNLkXp22K1j8Tgzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM9GDr5F4YESR/Tguk90YK+8co5a0C/wrXg5QShdB+M=;
 b=llaLETU+qO2WhnEXUNsHfXT7XmrF4tJixdpzgI9Zr+VVc0L9GUCCKLMzKeS/Cztggn7Kmxbde6y8JliRSaO2RFV0OezVC2Qn0BDeyQL7vshCkabXqZEc+qVAH9OMKXTSjx/sP+FQIm2ci2I89Jfz4mrAZWW2+yvG6cAQu8yy0dRJE9gQc0W/KpvaIkT4Nlbzj3lyXIoEd2PlRTFbllocsFYAIFFSIEWyvVfUok8ntYx2d40bxtTqayZFwxZ34e1t+/kCF6nP9XXuw3pGVU0wTMxOg0hM7867D/gSXC5m2gSqHW9F4rxZDiM1wtiGDr10Vv2WQmH8nrzaTaLTwRtBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM9GDr5F4YESR/Tguk90YK+8co5a0C/wrXg5QShdB+M=;
 b=oTLih9UulBXdvUcpHXSkpxcIAOvoOFkYezlRXqiCWETsRa/ONX1jFtAaQY95E6EYAjtdWm/BXhtLv+vjRooXj9LbV301Vp0TMwPNDYLMK1d0iLIaUGgCiz2blbfIkzY+pBs15R/653beAfB3EMaBQTdQOym/BmsZmTsFNZECp1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SA3PR19MB8193.namprd19.prod.outlook.com (2603:10b6:806:37e::18)
 by SA1PR19MB6645.namprd19.prod.outlook.com (2603:10b6:806:258::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 20:05:06 +0000
Received: from SA3PR19MB8193.namprd19.prod.outlook.com
 ([fe80::6eed:df87:b510:6c5]) by SA3PR19MB8193.namprd19.prod.outlook.com
 ([fe80::6eed:df87:b510:6c5%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 20:05:06 +0000
Date: Thu, 29 Feb 2024 13:05:02 -0700
From: Greg Edwards <gedwards@ddn.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <20240229200502.GA20814@bobdog.home.arpa>
References: <20230814144100.596749-1-willy@infradead.org>
 <170198306635.1954272.10907610290128291539.b4-ty@kernel.dk>
 <20240229182513.GA17355@bobdog.home.arpa>
 <ZeDc50LQSItEeXY8@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeDc50LQSItEeXY8@casper.infradead.org>
X-ClientProxiedBy: SN7PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:806:121::7) To SA3PR19MB8193.namprd19.prod.outlook.com
 (2603:10b6:806:37e::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR19MB8193:EE_|SA1PR19MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a6d1a4-5fd2-479b-52de-08dc3961b921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t2B67p/nBNVSlqiIjId2W/RWSF34/hgo1fv+9mO/fwYsIK8+u69Z4AzSE6vUxxH3meYsSe/UCH6uWwwiM3V9hOl+S0z2gH4U5amY6bwy3VFIKmbuWli8HD9yF/VNX1vqBpcKnK64qssvVX+HMIB0s5pN8f8P4JQxI3lwTvs7x66tesJpSxl1FldMybSzEmJygDWKeNpeF0RCFraww2N1KFgMIDeF75A80JzrfJnbGvynhlMhm0P7A/OW4tqF6eNbwtmw3zutl+XIodubrZn6OAxCNwsKPiGIPWML1jGg6IiQ9d6+JTa8wDnTEnubqvKf67K67stYwbqX0E5ylKq0tXJjhrp27UfpuV0hxPRkqt+C5P3Mr/TIEZoThznv4zR34XOlXR6E7GZcIoiOLNat13BSRAqlDlT26o0aQx3WXW5PZgzHAnj5YJ5NgZkhxsJNyr1C/+C0Mpde1sTgOecE/sS9gR0onSNK8OciH9o8wlQewl3iOL7NowiJ8BCRN4EcZaETh0tj4pj0QQKvSMOV9G8S44zF2Mj+cJHr6hfgc5Oy0Km4VFlv5IOmgzQeF2Nh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR19MB8193.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1QhV6nL8CcMrwZ13cZaL26DAtA4VKjBNlnuSQNiEx75BdTC0FGluhz0gq5Ww?=
 =?us-ascii?Q?HDjnhD4i3z4qt09R1cHw45HF1iSWmto/M2R0FBTFJgX30jIjQYHHNKs0qyoj?=
 =?us-ascii?Q?juUV0BkEs07kbMVOkAgYj55wcrNNtSK1jPDpDlKOhs5cT4/K8EjWagxait85?=
 =?us-ascii?Q?4URtXkgUr/f9d6VaedT+engVpWYd7ujtCyVcpN7S/q02f3uJ8lp0bwWWbjP9?=
 =?us-ascii?Q?6JxznjZOvv5Orfvt+f1H9l5SGqrXlkk07ioPQIhkw5Ijz3vCTvVLQ151NRV7?=
 =?us-ascii?Q?A7LLXo2ERZKT6U8iDgmJZ3boFT7ArnG5PWWI5LDPO8Tyiy1l5qkIyCyfNQ88?=
 =?us-ascii?Q?1Narw5+tMSfvpJZ8lTW47QWhRQcbQN5lwLP2Aoew3dxZNjbR4Q2TrqQLSuc6?=
 =?us-ascii?Q?ani5vSUfyUS2YPHjtN9fF+pTUqj8qS2zqPSx0b1NBkCNJbIV9k0ejzICS0uy?=
 =?us-ascii?Q?OnXMRbI92LLcd5vZ72n1z3BUdUy5DQQ32xKYf5ZJedUb7vbyFWI6JOoMqwsd?=
 =?us-ascii?Q?NX8PcuRaXa3pIVwrUS/grFUct6KWxSfUwxi0PDQL1dtHeyvuG48VKSPZneM0?=
 =?us-ascii?Q?AZrx1RO4prhthr+MBQCIwn+BWSegCvEppZmGkJdCGTz1swaDefXC2pwhFbu0?=
 =?us-ascii?Q?3zdORvH3215szOWahLvVvEkJaW2XVA/w3zJu9QMvHFNA6gD5xE1zpKHBUTN0?=
 =?us-ascii?Q?oTgBu9Z8s32GTN63KtGDH56F92wDlkBuAYMtUTGhO1nU6vfMbutY1V0/YBsj?=
 =?us-ascii?Q?chdDFZfr0QAB0fASo2hz4xeEFUX0vlITzGQ6NGPEy3g4SMLN42ou+oG1aGIA?=
 =?us-ascii?Q?IeCyPGn6QT5vGypCCjDZd97AAdFI2rTyGK3FHGs1id8f66hNofSFX21Mtawq?=
 =?us-ascii?Q?Z1YyAyTeHnNxNAo9BxCKPfAesYa/muIXPjuhDnACOOMDeQaxS7Y0PAEn8SZl?=
 =?us-ascii?Q?iVVja8MplAYy+MTjkrM8h6IRZSA71DUhjNFQAblANnIo1DasYh1Btn+qiKjX?=
 =?us-ascii?Q?//P6cEBEiPg88YXQaije1lJVphY4m/hnXPkTUjYID+lp/F2ncXRVl27qhwnO?=
 =?us-ascii?Q?qrIOS2VJ7N+wJjEwiFIb+0nJUINiZKqIMBkX0Jysy/CY3LBEx7TL/O5a2Flt?=
 =?us-ascii?Q?gV35DvggDJlDMyVYMs4hmERjsArDmcJRgxa2lSJQwLOIWDGSCw78u1l/2oQ1?=
 =?us-ascii?Q?aE1QXMRIvX8d2liSILetKSvuvKEX5OzGlLASZSDBhjB42MmutaWUG3Fcg6iB?=
 =?us-ascii?Q?fb2sBUkgQZzwrr16f6pRssGMR+PAjTh8rK2CJVxM/8mLWIjMVjozlnoANwsi?=
 =?us-ascii?Q?stgPNnOYZJuhIFqVzLQmF6B0pL/qd7eL8H33KbC9ZAoovG/obYZzXB0e8SML?=
 =?us-ascii?Q?z2FSO8D/+M/FCWbkaEY7LusuhsrTxMjjg2ENQWWWBp2X7bcfgJBICRLjHPaT?=
 =?us-ascii?Q?HG7EFxF4CEdtm2krmceIY7Yy5IAPxJRdAWSkOHvxLHRc7y1VEUSG9zO6s5kg?=
 =?us-ascii?Q?pFfkXnp5dnhLzO38u7fygxYE9vd4uXyNheCc8LiF3FJWnh/jg1UAEN2+9m7J?=
 =?us-ascii?Q?UzI2P0sC9scXcizq9u50OhEdCtSnmjoVm/Ehpg3OWqRydHnIL/1JNhI/q+s1?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SMBBtk9Ixfp3RZECiaCnnk5W883k4p9vi5HC7T4MUISmbpSlvbPToluJ0w+AFIlH16NFo4+2+FdCImx4rmvHAI0wxiyuA5oecWa7nK+Q8lurPJzmmMIlcaP1N64JzC1lwZlrrqJ+mKtcge2vkoA63aEM3/tBGhvUhMhUaU5vtkDqF1tlKseqaPkPrZ/KC3c2Fpq+vOQXz4HDLipZuIZO+O5TKZMzBD23NFQawe8TI4hz1C5uXfBiG/KFcE4O/XY5ocDZgvNQoELROENGbeiaARKatFwbD0/pwJ+CRrjqV71BCj7L4d47sBwl4O6XSClKturaoqkQSyYcsmCiReoo0rmL88evXBvESQW72+a6iCdXdbGNqBltRzjcUyH77QxZF+izwjtkix65/qP+zVt9g0MyIbFyynmS3sug93pJlFyApLNLnHsrdxvei6TYcg7CpUzxDnQiK1YQS3Zhd1OQGr+9VIIIGY8s383H1FnOeuSJTBnK3ViZ3oNxzShPbr3XCKcoEB1CoBMu1HnFezk4umN3U04Hisd9x09GyxcuYJ0ahjT/98UwHjEifOWY3yi0lbORbExAy2UQIUpICYrIzSDvrQVhWenPlnK5JhOTgLd2P6hGav3YIJLh0vEiJgHxF2/VdcWPG+iOihrrVEFKWA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a6d1a4-5fd2-479b-52de-08dc3961b921
X-MS-Exchange-CrossTenant-AuthSource: SA3PR19MB8193.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:05:06.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+s23MY/4h6Nr8BRqZeLNVf0Ek5a4g2R+wL5He6Ggz83ynqikNWpn2ABZ1M2tv1kdyVVVoZS77gv7lB7gncqCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6645
X-BESS-ID: 1709237109-105780-11268-6-1
X-BESS-VER: 2019.1_20240227.2356
X-BESS-Apparent-Source-IP: 104.47.73.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYG5qZAVgZQMNXIwtTE0DjV0N
	TSyNTU3Nwy2SAtNckw2cLU0sTU1NhIqTYWABfRfzVBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254556 [from 
	cloudscan21-235.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

On Thu, Feb 29, 2024 at 07:37:11PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 29, 2024 at 11:25:13AM -0700, Greg Edwards wrote:
>>> [1/1] block: Remove special-casing of compound pages
>>>       commit: 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55
>>
>> This commit results in a change of behavior for QEMU VMs backed by hugepages
>> that open their VM disk image file with O_DIRECT (QEMU cache=none or
>> cache.direct=on options).  When the VM shuts down and the QEMU process exits,
>> one or two hugepages may fail to free correctly.  It appears to be a race, as
>> it doesn't happen every time.
>
> By sheer coincidence the very next email after this one was:
>
> https://lore.kernel.org/linux-mm/86e592a9-98d4-4cff-a646-0c0084328356@cybernetics.com/T/#u
>
> Can you try Tony's patch and see if it fixes your problem?
> I haven't even begun to analyse either your email or his patch,
> but there's a strong likelihood that they're the same thing.

This does appear to fix it.  Thank you!

I'll do some more testing on it today, then add a Tested-by: tag if it
holds up.

Greg

