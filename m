Return-Path: <linux-fsdevel+bounces-29749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1697D67F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 15:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48B81C22105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7166117B51B;
	Fri, 20 Sep 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QIjgkAdN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5F57CB6;
	Fri, 20 Sep 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840543; cv=fail; b=KKd5Hu5Z+nxNTk4zPcBrKHwTzAzsOrTaEPy6qhDdhsBT3S7PBpBeJTpkut5PO44CVsmTgMt8m07FNRvAL1XNJcD+btJNl1xkdzwWpyGVGoZuTD9aqWmsLw00SMmDxXfDPu9PxuKCNw7XkJuRkAoluXhCM5dAJ58qTjUyoZscYwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840543; c=relaxed/simple;
	bh=gG4OagSGjIgMPyFQeL9T+D6Y4fQL2GQXmiMSj2c4h3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mlN1rAsCcagSJ6bQrJRdn1p8++n0wtKg90/LAnIOXbiqGiEILIMAZetjvyD6wn/illDLhohVNkaoiBASX8oZPs7AQZN0zRHqzJHFAub9wT/4lPlUHD7Tt8apcFxJmtsUdlzlu8x4rrMJ1hILIjYNXGbLlopZc9CXqlEmvHpfmVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QIjgkAdN; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KCqXxf007768;
	Fri, 20 Sep 2024 06:55:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=NOiCfkFwp4AbkT1ASINPtLimSZFHsm5kL+XNMeabn9Q=; b=
	QIjgkAdN0rYDs5zSbPZz8FbY1kF95/IqitvpnoH6jus6BXtzPK9dNtnXkR3e2t9d
	QcSsujMfZxv1kkV+qkRob+IyCsxUKXYRcn7cHfnIqIs795P2+YBTLwJ2G+Q0QZix
	5TyxpkIQfh+CT0YChC2HoOJdJM+VS8C3iK/qj5ZYHogDHaxbWrIjcdobG9Pojk/q
	DDNvXBBrIb7Jjsm6UyUPKrJ2hIsmdKQp7/19icgnmqvGNVshtm9IH9IQbFozDXu+
	flUpHj922NERCrqCSSAAe9UGoyfsgcsEgPowBLvOvqxir0Edbo1ESmPjSzTiae3L
	gSN4aXIS55BYQz7RSqMf3A==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41rsvtn918-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 06:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQlaaIkve6QNsppMVXJqCZxUjiMjNWDu3v3wH1AJE3Fl4+UdN26HulABFaCV7aqLNMhveV2xUjcjAfOJ5wMHSpDpMnnbSZwUw4f1/Dr+CN+scyu2jVyodRpODqZexjjEZSiliiBelB59T0dRACQxgpqSVERXYVI9vKH4TA/AhvdF9n0QhsD1Lklu4Su0RRZCvhbruY9vlCo5PL3QO9fzXgaQ5wJXhJfzSc1Fj/GzTaDBNvOdEVXXkeAtDsyO9s7ewppA4ba7IoK0HB3pQde5rn7jKrK75a9XrztMkNuGdxPToh/kjCesclXsY19iuv1OH2JcT3BUi6rfIlmfwJ3Svg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOiCfkFwp4AbkT1ASINPtLimSZFHsm5kL+XNMeabn9Q=;
 b=eXZESKMHbw8oLZ5fSG6HYWlSgtWa7dwT7TYu4teeO+SRmaJn5pcvo4iP7AmZRPtYOK8lAagRmU4F0r1XVgcFFN6EdP19RFQg3mgmrr4TqM8PwCK9ay9nuy9HN5WFdQfBdDraNPWDqMKe6GIduwseM2E0p44KFJIxiZyH/MI+LxUr7mr/LgP3MkH4z/oaADrMHmPYBkxsEex49+vby6YiFebkxkJ8hFzaiMxhatk7cpd6Ps9IgtFsGF50TB1zS3UgACmSZbBmb3MzkKuWB6BXluNarySHdTiGmWfyWlFbNQv6osvH2wtmroI1K6e7EdX8ei+zZKA3UbW0eb1ewVsCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SJ0PR15MB4328.namprd15.prod.outlook.com (2603:10b6:a03:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 13:55:15 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28%7]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:55:15 +0000
Message-ID: <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>
Date: Fri, 20 Sep 2024 15:54:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
 <ZuuqPEtIliUJejvw@casper.infradead.org>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <ZuuqPEtIliUJejvw@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0197.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::8) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SJ0PR15MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: a0abfa4a-ecd0-406d-f7df-08dcd97bda75
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck5vbHRZYXA5NWRmNGd2Y1FoQm4yZW5haG1YcmJvSHE1SlB1K291STdNcHZu?=
 =?utf-8?B?TDFTdlI0UjVUN1JRNlU1VkhWTmRsbUJFOUt4eEVScHc4NFY1Q2NNQ0Q4NTFr?=
 =?utf-8?B?Mm5zbU9wNEdKRHA0blRiSjE5emI3SCtZQmVWQ1VBd2lHbHhZMVJ6b0ZhR1RK?=
 =?utf-8?B?MWJSUmpzVXdNUmJlb1YwMzRMK0U2VlJPOExlemR4NURrMWdPK0NDajdRZlVk?=
 =?utf-8?B?bVlNTDNzZ2RNZW1NaXlreDd3b2xERVJYbVd2cHEwVEY0WFoxY0RraUNrSGln?=
 =?utf-8?B?UWZ1Nmxza2lLd29DUTh1R21ETkpmYjl4cTRneFJ1dWwrbWovUFdDZUlVV2lq?=
 =?utf-8?B?MmRPeWxwelNhSW8wVU9hRUdUa0dTdlkvcDJYaEp2M3N0Z2JxYjc4cEdiL1Ri?=
 =?utf-8?B?cFBXYjJxdXNIQlpwczUwR2ZIcmVZZGJaNjlXZ3pTTUxwWHZILzh6L2pSTzE4?=
 =?utf-8?B?NE1paU5GdGFUUTgyMVJHTlRnNXhQbTNOejcyNVFSeHJGUTBiK1NyTTl4MUZj?=
 =?utf-8?B?ZmVJc21BU2UvZURJNE9KTXBiT20vWkhrNmxMQ0pLUGFvYTVhVE00a3JuS3FM?=
 =?utf-8?B?NmkvbnVwRmp4ODM1TFMwZnB3dTBEMXd1TFNwVTAyeVlZbGJWM3hoRFFGejVZ?=
 =?utf-8?B?bkdmVWdmY2I0NGMyeW9RcS9HaFJJZ3ZPaHJKYWdaWTVwZmdKUXNEU0dVZzUv?=
 =?utf-8?B?cHN6M1Rhc3BLREtSWEFPT2hUQ2tQMkhYZFZ6dFBSanlUWmVrQjBnR3NpeUxN?=
 =?utf-8?B?cnE3WldyRk5RQnJiWThEWEpiU2FhVGJmdmtyajR0TTNEOFJzeWdxQ01QSFFG?=
 =?utf-8?B?QmUyOXlPTCtNTUV4eVRyaWtkQ2hidmYvQVBKd0NKdDd2aU1Gc3RIczVwOXE3?=
 =?utf-8?B?czZJZWFNdEdDcjFIbzZtS2NQSkV1VGpsTnl3ZWFJTnc0MUkxOFI5UnhhNU5V?=
 =?utf-8?B?RFlJaFYrakV3clNSUHRCaGg2ZDZIb0lFVmVPajlZUHh2ajVkdHpHNmNBd0dZ?=
 =?utf-8?B?d08yb3pJQ2NjSTIyWXFkMnE4YytQbmdCa0Q3SHVzSFRmT1FsekhSUGs2SzU4?=
 =?utf-8?B?NkVrY0x1cUpqYW9EMUZCdGhwekdsM2xnZU1YaWU3NzhSa21HMHlUSERNOGFD?=
 =?utf-8?B?OW02ODVONHZ2eE94YXdTWmNaOFlheVluL2ErSGtzWVpEOGprSDVWOW5Ea25R?=
 =?utf-8?B?UUd5RWMvc1IrcmFoMyt5NEdZQnNTTXNoTDYyR1F4Y1hKaEdPcE5Jd2phNW52?=
 =?utf-8?B?cGhWRGV1ZzI3dTdIODladmR6SzJ3VUgwNWdrVnpTQlZMVGphcUwvZk5Sbi9R?=
 =?utf-8?B?ZkJOM2ZuR25WdU5TRjRvVHNHd3pHK1h1ZXBFbStEUUtKZWZ1anlKTUJ1cjNo?=
 =?utf-8?B?K0UvQ1U4dTJFZmh4NUgvUkFlVDFoUXNrRUwvbFV3dkI1cUZHVHdEa1FMWDRB?=
 =?utf-8?B?cmRpNFJ3Q0FqK1NkNmJvdkVPZGg1YURqVmtVTU8wQ1AvT0orVjVRY2ZzVFhn?=
 =?utf-8?B?RHBOOEFOMmdDQ0lUOU5lbEUvNTY4N0JDWHFKdnpmWXpsRjcyUEhCSFUycFFI?=
 =?utf-8?B?Zm02V0xrUWkyVWN0dnlXY1lwYnVHWjdZTnJJUk9hcEZmN3o2dUtHWVd5aGlE?=
 =?utf-8?Q?TZzcWy1z/l6AVKJINGYCcABnpPEANkz3zyupGG271x/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVNaRGYrTi9lL3NLZWVickZyd3YrZkRtdmc0c0pYdXUrVTZVZ1p0bkQvZ2Ux?=
 =?utf-8?B?amtrMHdveGNuaDhQNWlSRWRxK2N4TStCRkxBb1g4cm5rL2VOcEZUSEVmYzdj?=
 =?utf-8?B?Tk9sMlFBNzRVVlVmbFJ2cmZ0Zit2VHlOQ2NFZUFTa1B0RFRKa2Fud3lqWFJ1?=
 =?utf-8?B?MjZmbXhFaDUyTmpUQmJJNWUrNC9GMlF0N0tSVllTOHFnY2ovallUS1NhM0NE?=
 =?utf-8?B?RG1heXUvT0RZdGxtMWRINVZzOW9Ja1BmQzRGYkdEWTlJUm8wYzByTllkSUpa?=
 =?utf-8?B?UXRsNlJFY3FHb3krWWhvb2p1eWFPR1FsNWIvaFFDb3RaV3RJbU9aMmRnMk1Q?=
 =?utf-8?B?dlE3TGN3RG1wdVFTclBZb2xtWVlJTGlqT1JkaXVHQnMwQjBuUzVLZVBQYUdL?=
 =?utf-8?B?aEhyTFZqaEI3emR3YlVVVGFxc3dyKzJaeGt4YUdqa2lYMjdncm1oRkFxR2hq?=
 =?utf-8?B?SHZvamV0Z25WN01SdUR5aklOVkpWL3JJWUVJZkFrRnhuYVFiSnJiYThiWVkw?=
 =?utf-8?B?Z1p0WGkwUEtKRjAwbVVXeSswK2lmaVQvZ01wT05HaVJaa0NhWUpZK2VldHhN?=
 =?utf-8?B?U3I2MXVVMXdiZTJuYTZuLzlrNERiRVU2aTlZUWZJNzZyQ1lzZlU4bTl5ZjRt?=
 =?utf-8?B?WVlKK21DSVVrZWRJTURZSmNDZDE5VHk3N2ZKcVNpbHZPakJhNW00WWx2SGVr?=
 =?utf-8?B?aUpCUFpyS1d5WDZHOVZkR1R5NER6SVJmRjNQNVBPZzhPeS9rYmJsbVloaHc3?=
 =?utf-8?B?MzdpMkJIcGt5eEJHaEQwQklKSVVMWW40NkQzcTdkNXlBNGRFZjVWZDl6aXp2?=
 =?utf-8?B?VVlNakxxazRURGNXb3pUKzNrRUN1Zm1UdHFiTHVOT0Y1c2s5aHUrQnlUTis2?=
 =?utf-8?B?NkZaWThwa21ia2dPNlorNG9DOHhlQ1ZjOVJ6a0c2TVFYdlIzbmRsMEMvRmhm?=
 =?utf-8?B?Tis3N25vYkhwclgwMWoxdUU2dnNFRG9KZ2dHNlRFUGJ2TGVsRzBhYUxGVjlq?=
 =?utf-8?B?UEl6OXp1V0pnN05JcTFZaFF1U3RrZnNhM0xVeHR4ckJUN1hIbWZmSENPc21H?=
 =?utf-8?B?c1JjZG9yZUNaZk9yZjZlUkEyYW94YkdLcG1mbjVsNTBSRlk3K2cwYnh4RURR?=
 =?utf-8?B?ZE1wOXFIQjNIN3NCSzJrV0xqQnBwQmpWRFdFWU9JU0hZZlp3ZndZbTlpY0Vn?=
 =?utf-8?B?OEUzM0RGVGpVK01qNjdZcXRSWkU1anI1b1lXaFFBcjN6R0NtSE5zS1VFNjdH?=
 =?utf-8?B?OTBqdVMrVHdpQTRIUi9lRTF4R0l1ZlJNNk1sbFBhd1NObmlmazVGaU5TcGt0?=
 =?utf-8?B?UUxaTEVhMlZrcTlEbTZVNHBSRWZuS0htRFdUcUl2cUp3Y2ZucjdxcG5URjdJ?=
 =?utf-8?B?SVRoQktMTHFSdTdRNElIbUpHTVpPSWUrUERSSjJVR0NmUVMzUkg2VERwOXlm?=
 =?utf-8?B?dXZUY2pxUkZtT0JnNTBVS0dLWDFWdnp1eFNRemlJMWExaDlRTk43TTBlNDd4?=
 =?utf-8?B?TW9nS2ZXOHVRcHducDBkbkhlb3JURlRnREtQdU5Cbk5yaXBPUXIzZHMzdXFO?=
 =?utf-8?B?M0NFWkF0NFYxRU5ja1JId1h1czJVaEJoblIxenh1QjMwTXc2aVU3eXhQSGpk?=
 =?utf-8?B?RGZRV1pBMk9ydnZDY1gvcGl5Qkxyd2xtRmRmbXJFdE9xcG5RdTI0UnRTWlZL?=
 =?utf-8?B?VWlIakpobmZFMTYyQWZkQUEyTm40SDhKQUhqNjJpTzhvbWE0S1Y2TmxPVi9R?=
 =?utf-8?B?Wk5CNkNPeEc0WXd3MzFKR2tVSEkzaVZqT0FLV2Mvc3FhRHpkNGZlWUNua1ha?=
 =?utf-8?B?M2tvVmRTR2twTVkrYTJLVXYvS1ZwVGVrUzV1Z1k3Wk5KQzJrT3NHWmhmejdD?=
 =?utf-8?B?eDM3YVhFYXdPTDRXanhqazA0WkYzMkRTYnhhc1JYb09TUVlVWkhDYU51Z3N2?=
 =?utf-8?B?YTdPemVrUVJUNVlMQkRzMHFoajd5cTZ5c2NDZExaNkxDaTJtelBiYVUzQXRa?=
 =?utf-8?B?c1JSYU5PTy8rQi90WlBOM21UVXIyeEdGV0VFV3hjNGt0ZUNSY1R4SkFDQlZE?=
 =?utf-8?B?Y3Z2cjgwS1VsTytvSEtIMlBBaHluTkQrNllYVk8vcGk1QkFKYkNvL1YzMDlw?=
 =?utf-8?Q?G6Ck=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0abfa4a-ecd0-406d-f7df-08dcd97bda75
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:55:15.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRGWlG1FxREjGmj5tWx92GY4mhHr3X6kh/Z3NOobSaBfWcpPIQ0jPLUYoGtwFF6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4328
X-Proofpoint-ORIG-GUID: qEheREv6YFr9ZLLsQ3if4LUbp9EOP_M-
X-Proofpoint-GUID: qEheREv6YFr9ZLLsQ3if4LUbp9EOP_M-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_06,2024-09-19_01,2024-09-02_01

On 9/19/24 12:36 AM, Matthew Wilcox wrote:
> On Wed, Sep 18, 2024 at 09:38:41PM -0600, Jens Axboe wrote:
>> On 9/18/24 9:12 PM, Linus Torvalds wrote:
>>> On Thu, 19 Sept 2024 at 05:03, Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>> I think we should just do the simple one-liner of adding a
>>>> "xas_reset()" to after doing xas_split_alloc() (or do it inside the
>>>> xas_split_alloc()).
>>>
>>> .. and obviously that should be actually *verified* to fix the issue
>>> not just with the test-case that Chris and Jens have been using, but
>>> on Christian's real PostgreSQL load.
>>>
>>> Christian?
>>>
>>> Note that the xas_reset() needs to be done after the check for errors
>>> - or like Willy suggested, xas_split_alloc() needs to be re-organized.
>>>
>>> So the simplest fix is probably to just add a
>>>
>>>                         if (xas_error(&xas))
>>>                                 goto error;
>>>                 }
>>> +               xas_reset(&xas);
>>>                 xas_lock_irq(&xas);
>>>                 xas_for_each_conflict(&xas, entry) {
>>>                         old = entry;
>>>
>>> in __filemap_add_folio() in mm/filemap.c
>>>
>>> (The above is obviously a whitespace-damaged pseudo-patch for the
>>> pre-6758c1128ceb state. I don't actually carry a stable tree around on
>>> my laptop, but I hope it's clear enough what I'm rambling about)
>>
>> I kicked off a quick run with this on 6.9 with my debug patch as well,
>> and it still fails for me... I'll double check everything is sane. For
>> reference, below is the 6.9 filemap patch.
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 30de18c4fd28..88093e2b7256 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -883,6 +883,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>>  		if (order > folio_order(folio))
>>  			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
>>  					order, gfp);
>> +		xas_reset(&xas);
>>  		xas_lock_irq(&xas);
>>  		xas_for_each_conflict(&xas, entry) {
>>  			old = entry;
> 
> My brain is still mushy, but I think there is still a problem (both with
> the simple fix for 6.9 and indeed with 6.10).
> 
> For splitting a folio, we have the folio locked, so we know it's not
> going anywhere.  The tree may get rearranged around it while we don't
> have the xa_lock, but we're somewhat protected.
> 
> In this case we're splitting something that was, at one point, a shadow
> entry.  There's no struct there to lock.  So I think we can have a
> situation where we replicate 'old' (in 6.10) or xa_load() (in 6.9)
> into the nodes we allocate in xas_split_alloc().  In 6.10, that's at
> least guaranteed to be a shadow entry, but in 6.9, it might already be a
> folio by this point because we've raced with something else also doing a
> split.
> 
> Probably xas_split_alloc() needs to just do the alloc, like the name
> says, and drop the 'entry' argument.  ICBW, but I think it explains
> what you're seeing?  Maybe it doesn't?

Jens and I went through a lot of iterations making the repro more
reliable, and we were able to pretty consistently show a UAF with
the debug code that Willy suggested:

XA_NODE_BUG_ON(xas->xa_alloc, memchr_inv(&xas->xa_alloc->slots, 0, sizeof(void *) * XA_CHUNK_SIZE));

But, I didn't really catch what Willy was saying about xas_split_alloc()
until this morning.

xas_split_alloc() does the allocation and also shoves an entry into some of
the slots.  When the tree changes, the entry we've stored is wildly 
wrong, but xas_reset() doesn't undo any of that.  So when we actually
use the xas->xa_alloc nodes we've setup, they are pointing to the
wrong things.

Which is probably why the commits in 6.10 added this:

/* entry may have changed before we re-acquire the lock */
if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
	xas_destroy(&xas);
        alloced_order = 0;
}

The only way to undo the work done by xas_split_alloc() is to call
xas_destroy().

To prove this theory, I tried making a minimal version that also
called destroy, but it all ended up less minimal than the code
that's actually in 6.10.  I've got a long test going now with
an extra cond_resched() to make the race bigger, and a printk of victory.

It hasn't fired yet, and I need to hop on an airplane, so I'll just leave
it running for now.  But long story short, I think we should probably
just tag all of these for stable:

https://lore.kernel.org/all/20240415171857.19244-2-ryncsn@gmail.com/T/#mdb85922624c39ea7efb775a044af4731890ff776

Also, Willy's proposed changes to xas_split_alloc() seem like a good
idea.

-chris


