Return-Path: <linux-fsdevel+bounces-64502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29595BE923C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E096248CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85E2309B9;
	Fri, 17 Oct 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBOK25qr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373021B9D2;
	Fri, 17 Oct 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710580; cv=fail; b=IsAGt7tFNMxx8v7xT0fNJvKouPHzXoCmyqgHnziutGnrCELBpQD2W22k/xQ3N69mZdYtnt/R4S+bs06CJou8mR5cC7cR/pJZUWIrzyPJ1EkQOu5oGOBU1aD1qaCKOA3o4AQMRwAxzn0MQiMP2S1n9/NJFfHNTAgXVDUZetftRzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710580; c=relaxed/simple;
	bh=Ze6/oBXbwhnuMs1pMfUy8ShwS6ugyb1N2i9/IPGYJPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pe/IdS1mNHsnW28OjFfZPtNNJT2mDl09Uy3VYz7R9mAZBXwgGe8clCYa/yokpgiRC1lfisfNNqiKG/QgKw9xH4LuQdpQRktEOpTrN93VbsLKzmBctJmmx7NDcCzZT45xRHV1QZuV5AzI3ILtfZv+fFOkyQxkvxq68wjHYeuKB00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBOK25qr; arc=fail smtp.client-ip=52.101.53.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD/oYVF9MoTM6vY8aQOwg82VO8RcZKFAZUvOSzFdnLbMs93fmflJ9/4XHaFYQ1c63YDeAO8T+6OvLv8nqfQNkSUnJ3GuHLHfJfP7vim9T+SGwQpW1W3c9ua5oLndlEFOq2v1Fza4BZerH9EwzBIjOaDoLw2zy6hl9gYCELSVhVOQ9X1TI6iVciaW4pdV/NXJWtKKXZd0mF0rQ6AZWtGZnIfee9ygxYNzravVfJt2Whk4Z4/wqnl58Hjhialy6NqV3R5BGAcqmJS7xsikN/A6uarjQ18MiVcu8VjgF6tfbhdAa7nJ0Hrw1RjO+kt0aBOdpaAC610rXEUgiduzYZG9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47HB+ywl2x9iU+2SakIidYpArCajdWwkfulZ04Jeiok=;
 b=eHpJhbJLl/5jDBYBxOdNZQj8GDVpyRm2WAzJvQAiuk4yuy7vzwIL4KiAM49toC1icW1MDZqizbZssWyIcP6ZeilZZw+AGDD3Yt58Djq/6IM/udAi9P6XoUslCz8C7u6K9aJWPBpugRMhKPaVWjPXtiEpep4WwDJcDTpPk4lekUklaVQyxR3VJ82toCZMTpfVzPZg4/q0DpkuI5pYVlmPDVqeHA32i00O7Np/CUhG7DE8dayKJeIpGw7Z65fkOyuMDFc2IHqI/R51JfY2XPmDnIEXaTOaAYvZ/t/N/bKZci0XBOMEJSLFI7i0HtHE36xqKmFTuPsaOLFRX8TtWb8Hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47HB+ywl2x9iU+2SakIidYpArCajdWwkfulZ04Jeiok=;
 b=VBOK25qrSpW0V/lyXAiPq1HnMRz6BWmJR6nV++Sio4kCaGNdNJ+vHGityE8n/UsRSC+JFCMriQVZIMN7SlzU5+ZbfYXHjlGvGw+4rmRJJIcb50nyAV4hXIZ/SExGQeQRB3tQ6ZCOhYB3bkFznRKVE7QX2W3mpAlR8QVEs8oSv4ieyE+4eBAc3EsAErcsd3tZSooSNhA1p06BsriA4Hl0qTMY/q7qgQ0O00NkbdAeMh62fgsDsPe2Kff1odanOF8MTWztTa4xN7M5ejni0+OH+PBdk0Q9060vjaRrFzMvbiKYyeBY6ZgzxaiRbJT33650hSX/jDCsu4FX6U9SK+uf0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 14:16:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Fri, 17 Oct 2025
 14:16:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linmiaohe@huawei.com,
 david@redhat.com, jane.chu@oracle.com, kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Date: Fri, 17 Oct 2025 10:16:10 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <FEFDFFAF-63BD-463A-B8B2-D2B2744DEE2F@nvidia.com>
In-Reply-To: <9567b456-5656-4a48-a826-332417d76585@lucifer.local>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-2-ziy@nvidia.com>
 <20251016073154.6vfydmo6lnvgyuzz@master>
 <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
 <20251016135924.6390f12b04ead41d977102ec@linux-foundation.org>
 <E88B5579-DE01-4F33-B666-CC29F32EEF70@nvidia.com>
 <16b10383-1d3a-428c-918a-3bbf1f9f495d@lucifer.local>
 <9567b456-5656-4a48-a826-332417d76585@lucifer.local>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fd7eed-3df6-4d9a-2a7e-08de0d87ba0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q9qR//+5aXyTUlD12O02vDFM0/3WJ34o0HtUu0E5mypc/g5C+mEOV2uN7BwU?=
 =?us-ascii?Q?/zuKs/jZbtbRER0mZzPUQdHsN8je7fxdJQOanM2PBJouFn2R7TiU41VfeXsA?=
 =?us-ascii?Q?k54r6qlh08Mcnbbr9LXrO+rmHvoRnQl3qSi+z1VscwBfRYqrX34STxg1nLTU?=
 =?us-ascii?Q?DQpOX3CTFQHfiEhhTfWA60risHkssZaU+Vq7AJ0k1jC+102elediGJBEAMK3?=
 =?us-ascii?Q?ROf4wvWMjBvOYB1VgI5jnEfyRVxpJZMANGT6ka4E9scbiFnYXyAROUA9iiwh?=
 =?us-ascii?Q?nrNMwFJfj1RjsxGNOTE61znNKsDNrc26/R385I49cowAd8Yi0LZKi9XV+Lov?=
 =?us-ascii?Q?UOqry2rnczwsVBvkUCuoMvoiu60bZgLSWyo+mTTNqBxO01qOJCkipJBL0u+q?=
 =?us-ascii?Q?8omnful5eIFw8ECFl5+UcwTiWiqbYmj6XE9OQXbG76SJpf0CdiRA3s5yA4m/?=
 =?us-ascii?Q?riK5ZzFpeAXQlVf6zhiTOhmYID4C3CTmJvFmOIHwrJEvl2P7gW/AY7uJo5iY?=
 =?us-ascii?Q?+TAwVkY53uvvhblmqoh0WhOd6tWONvWKvPX/bsQ6bj12+A9iqtxnluwtt0xo?=
 =?us-ascii?Q?lVR/u/el6Rymk37edHTseSEKwfVH2aH934ZqiWlL96i/UaqTtxbGnNRyGTbw?=
 =?us-ascii?Q?h50QqKmjYQE0KT+tS0dCYkou3fz5VIJgypqZIbkBAIer9P5/jzxB9IG5bCJI?=
 =?us-ascii?Q?8TtJG2QpmGNB2oe0yP2vAh+yS7kJUuEZRBHiDqlKKgIX2so2D/g6TySf/Vqt?=
 =?us-ascii?Q?nVuRCuIkY3BZFgPtGUuC9ForfP2/uXhP5EEd5HoHgprp680jxvyAx11GAq3E?=
 =?us-ascii?Q?yfh/sTFkYBW1TnoPUtIhJopQfml+08yLKCUSzuUY2yZuOC76szOmIbpRcEu5?=
 =?us-ascii?Q?x1OZf6oC/+eLOZ/OJHX6XbCgPqgddOYZKYxr0+tiu4/Bu8HKCo8rPooCyVOH?=
 =?us-ascii?Q?Bd9TUhhXKZf0b1+pvMJV9EDoNFcLOk5A6flsRCSHug1VYX4z4qs1eaOXX855?=
 =?us-ascii?Q?+TZKLLGFMzwqJAynHf/Z24TYhQrzW/2hK0xIoub8ApuD02ZDYAfPF84Vb03M?=
 =?us-ascii?Q?UIG7uGnrU9Q9pwvZ+JUhwLYGEvITOPU4aQ1HeTiQTwLxYC2wsRgP/DbzLW0/?=
 =?us-ascii?Q?zedWBedZyiMiQZhe2Fs9uiW88s37IBA2TlBavLXUP8N3j3mYza+y+y2mUL3f?=
 =?us-ascii?Q?HMJNxItASdFYmk+1GCrvKZI8jeS7YQ6vbHhIiirRZ+0kUu2pvodNWIxOdtIV?=
 =?us-ascii?Q?5dP9hyXIX7LUIg10Jue1BDlNV6C9PI/zd5YnlF3qYfIPf7Jj/d9jWt0JTwxo?=
 =?us-ascii?Q?81zAvv4FPdaHc+if2IEVX/9jY27oKiVtozkF4hgGUUI+FHKIyVdtFYD2K7i5?=
 =?us-ascii?Q?5MXOfeBnm79e47Pmj4WzD0YYFjmWqofM4FJli7PwEXdlJd71L6VaznB9dvRk?=
 =?us-ascii?Q?louy0+cuZoSpsbUPmswsrQOkzPT+CqC1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N32ORJftj/Etg7CtzEsTzqS3E+JUCZbdWpc6Q0Wyx55vpdgXKlV1Sm3xd47W?=
 =?us-ascii?Q?YCQB99AutozddeA4GtJFeDV50DdBE87msBBkd4aH6I37IE5dzvwUqmD4Q0Qe?=
 =?us-ascii?Q?vU/DtBjBg4m+NgvTwfwXs1ngL5YCIfbi9QIlnaDBmMDA8f15NvI0IFAnDUv2?=
 =?us-ascii?Q?QNWpAPKi8NJmQ51hL4FQA/OxvsuHK46lfQjFYRkR7kTRsqeGClCaqFL+P+6I?=
 =?us-ascii?Q?LaSXpvRiDWUOCf8OCC4b/qfIk5+iAADF2dzlocH7AEovRV+WoAg7bd13yChJ?=
 =?us-ascii?Q?5hKX9TmhdN2N68KR0TDzMLzx+gnmPRfeX6cfMKZ7vT0LViKApvwZlDjFYEHw?=
 =?us-ascii?Q?V0KL8xfv6fQuEPfHSg83Ft32Es8AnZ+CJdUs3KiQZDFfsoSdbNSETj6BQWLL?=
 =?us-ascii?Q?M0eOUTSA1Q3vzU8J4vb97aeq55Ug+2BrlfQgdZYnvH1WgUohhEfxFM1zfUG+?=
 =?us-ascii?Q?54zykqR3Gc/NzeH6SsQXr9OVw12ujZ1jHlC+QM9flHB3M5wUFWXDljLqwOMU?=
 =?us-ascii?Q?r/Tq2SPpjiEUrUtiATv8fm0OUZb/45UQhSbvjpvnE8N2TTPAeK+tuVAyM8+C?=
 =?us-ascii?Q?rhFklFeihw37HJLIKRNeU6BiJAXBBHgu/Nuuf9BQeav/cvCztwG+Gj27SDlF?=
 =?us-ascii?Q?twC1md7p4K7LwVo0wJbFYZLAr7AHeWXSLchUCOFocfgLNlSMvFXBZbtMjXa8?=
 =?us-ascii?Q?qpe0dS1a/wMuR/JU+tYTrUKzk2VjJVh/weiy497aiTmkr8Aq4zHTmXFFPnar?=
 =?us-ascii?Q?1xF1geXh4PGAITRWNy5FUWNkSdTd7no4acLJq/McORlKdDWVms4e45W8i8IU?=
 =?us-ascii?Q?RzVCA9b+HLMx41OLOC5n5pPHQfhtimv7qRGs0L19jgfRPmBzpbtBoQOhIcQs?=
 =?us-ascii?Q?Mbo8tbRnYtdmwvNf2Y4ajQsNGOp+esUvc8FTw0UT8nUuOXOOtdzc9MuInFxF?=
 =?us-ascii?Q?4pcmzABCThA6FLmm7MqVEH0sNAZ0sEVxFFtf9ZnF0OZAwwrEZQMC7mtZf2KC?=
 =?us-ascii?Q?0IaWmW72TQO8zo/MfECHRTlOzDKAaaCMMOtJ90NpkqbNlCZxCp33B+RmIS7s?=
 =?us-ascii?Q?euF52RG66cgAXE3gktvg+5CsxP4xvCjkiZNgfb/kQbIvPfdU4piQxyEPkEPR?=
 =?us-ascii?Q?kzi/eoXe5ceqDGbs9VB+YnqBM0kHzq0iwNDrO24mRDvKmRI2GfrOnyGLengS?=
 =?us-ascii?Q?CkFo9Vvc8f+m93MJwN4HLenjVHqutyxZr3Lx1Vy0+HmpYtNY9wNjCxTJON7w?=
 =?us-ascii?Q?xSavyPqWWSKel6K3Cyfikq4bB5PVTTP9vNVHla1bZi3BmwHEjQlztGTagk+A?=
 =?us-ascii?Q?3/b9z7y1yLllDLB6/8SkZs9Llzc0Oa9BYez0b5YKVxNzXlPPGzxk3Quab/pX?=
 =?us-ascii?Q?6yY0gxwCATJfoO4Rt3RgPZwpT+a3QLn7odkU4PXx1xwcOza8pPYo/sIQTme6?=
 =?us-ascii?Q?j3xcQTtaxxDwf4F/QuHruv9Du79CyEzgFhJyhZfEKhuyA2TGwtMPGYTpoDL8?=
 =?us-ascii?Q?UeG6DRIqlGjZAS+7U9fb5VjX9ij4iJWSSmSwWZa+0Ouj7bSlkgJovBikfLcs?=
 =?us-ascii?Q?NOpz3wdrvu7aZaZEOBSrd0ZtVol9RWRLZrRgmzTp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fd7eed-3df6-4d9a-2a7e-08de0d87ba0a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:16:12.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED9nJu9/t0BSFLR33YUXbrvNEFwAPBXE20n68mmnMVgeYD0IRKg3LTJekeiziWgP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566

On 17 Oct 2025, at 5:10, Lorenzo Stoakes wrote:

> On Fri, Oct 17, 2025 at 10:06:41AM +0100, Lorenzo Stoakes wrote:
>> On Thu, Oct 16, 2025 at 09:03:27PM -0400, Zi Yan wrote:
>>> On 16 Oct 2025, at 16:59, Andrew Morton wrote:
>>>
>>>> On Thu, 16 Oct 2025 10:32:17 -0400 Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>>>> Do we want to cc stable?
>>>>>
>>>>> This only triggers a warning, so I am inclined not to.
>>>>> But some config decides to crash on kernel warnings. If anyone thinks
>>>>> it is worth ccing stable, please let me know.
>>>>
>>>> Yes please.  Kernel warnings are pretty serious and I do like to fix
>>>> them in -stable when possible.
>>>>
>>>> That means this patch will have a different routing and priority than
>>>> the other two so please split the warning fix out from the series.
>>>
>>> OK. Let me send this one and cc stable.
>>
>> You've added a bunch of confusion here, now if I review the rest of this series

What confusion I have added here? Do you mind elaborating?

>> it looks like I'm reviewing it with this stale patch included.
>>
>> Can you please resend the remainder of the series as a v3 so it's clear? Thanks!
>
> Oh and now this entire series relies on that one landing to work :/
>
> What a mess - Can't we just live with one patch from a series being stable and
> the rest not? Seems crazy otherwise.

This is what Andrew told me. Please settle this with Andrew if you do not like
it. I will hold on sending new version of this patchset until either you or
Andrew give me a clear guidance on how to send this patchset.

>
> I guess when you resend you'll need to put explicitly in the cover letter
> 'relies on patch xxxx'

Why? I will simply wait until this patch is merged, then I can send the rest
of two. Separate patchsets with dependency is hard for review, why would I
send them at the same time?

--
Best Regards,
Yan, Zi

