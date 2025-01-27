Return-Path: <linux-fsdevel+bounces-40173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E2DA201CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED1D164879
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F11DC9A7;
	Mon, 27 Jan 2025 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H1c7TCnY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476DB156F57
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021380; cv=fail; b=PD3bCSzww5iF1UUGGXMiKjvG77TF1AccxrBGHQJfsWnUqXzM5t5V3fJ/ptljnhXxhunNjZ4EV87EWYU9+mLcegPnMi6KPv5YXP8VikVgeW988hyikJQYaPT0FHCnc8/aTUUOQ7YEiqENyFkJ93J14lcCWzVL71Q/t3LlEaS6kjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021380; c=relaxed/simple;
	bh=hdCBBSE1X5sD51snX9BV/sx7Ywti3QxEmp2pjwhegwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pVnIOb44hm0I8BsvHvjnndlY+AqInogQ+xpLbAgWNbGdPGN/lRWCz6bl8O1Xi0E+zNTEHD4KLtDQTqvB7lbnqIvgYVDc5WojSagkf62SZqY0eG2ZqosuWsxShDXBoQPHhzPsC3jbLaF8g42smIrsbzI3gRQohHe+6DsxfMYDBDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H1c7TCnY; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iY/kO42PfIJDD0lxFRwMnXZS5bIqqhTiKTFow+TrRkM2ijhpH5q2qpSvmnqgLQvE+LO5w3aqzY5jGUMm+A9snbB+kVP2NSBIZclIPt5JBERXBXzpS3bqPRiF959kPXlHTk3NbFdFjXnlZhJlec+tYZXHGuNwNZw7ZCne0wKAcEzkFqth/jM+yMeTPoJNvax9a6zoyhKPrRXlYy4PmGFEeJeIC8SH/bFypanMJfgMMLZnuRfxl5USMK6P1jKsDJAxMHINMeGfVdh2Cc1B5MysvOWnxJ3kiD1afUtv3Tcoa5c2ZLzrRRnQvCwOqSl1bnwBGoQwQ25HhT/zeIoWGekdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/91wxxTPRZ+mXh2U7r8KSpNQNIrAEyJer6496OkHyTQ=;
 b=ddAosSrqsMN4kWVna7Zn4sLDhbA/sy606XEVxbnBvK3KWv5MRbzMQ79RJgNKRFk4vJbpb/GtPptwadrnrGlXSN27ZqE0ROwhL81fmZy2c893fAT8Y+/sc7C7fUXQrugaJ6DCu3IPq+etVJlKdn0oszZ0aN/M7x1XBUM5VdtBwQRpzCxjTGZXF1dhsPIkxCrC89v25i/7t5JTq1kxATpRXvGdAkBlDunjljVWlROXx/+6DuIAgmc4wg7MTsEOKdZunfGHVJfAvgeIMEBcZmtsB7OQAqUmob3+jehqSLipEtL/ynP41VpPEQCcXT5LNpOTe/GWX/w9WxfkDnDNPm8X/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/91wxxTPRZ+mXh2U7r8KSpNQNIrAEyJer6496OkHyTQ=;
 b=H1c7TCnY1wYZevr4VOwHov7uvyLTqApIDTqThPiihvkjSNxRTsUllKDoSi1kZf9G2hPpxEXCA1o0swgnkMTtYrI757mWQxvWw7vvwRf4CxDvRU3bSNA2LSXjp6thqe7QFWyjT0NtvS0Wv6b+S2QXGlBYLdy13L2M+b9X+getZyjvDfvdbcd1XvB9Othe6brLlHg9v6Wkfgo7rLbU2GUTPF3UWnit9TbmDg/jMAgWe1Q8u4lHnlpH4kWHmvQ6Za4kGo76aNVciVN5iUSa0q8HWI64nVGIKTKC17Pu0LdPl41039eCpbq7ZXIfj5sYyrrUxR3ygDJ3ElJ0DToW0cyiwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.23; Mon, 27 Jan 2025 23:42:54 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 23:42:53 +0000
Date: Tue, 28 Jan 2025 10:42:41 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: page_ref tracepoints
Message-ID: <t3pni56te2ii2wpgokp3pfk3do2g4lx72wwazfnamydhgxsu3h@2x3piqnoyqiy>
References: <Z5KerEzWmu61hFDU@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5KerEzWmu61hFDU@casper.infradead.org>
X-ClientProxiedBy: SYBPR01CA0058.ausprd01.prod.outlook.com
 (2603:10c6:10:2::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: e6991a3d-bc7d-4621-257a-08dd3f2c519e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+9nMvonjvoCTngPoHR5vpmdYsozotpxm4tQcFt0qsFSD232D1z3MKdQfpNw?=
 =?us-ascii?Q?COkQ1L+tYvrl4HSfrn5Ggp+g0JGs9MoFqnpzI6Spng7nOu/K0FcZDXLu6CYX?=
 =?us-ascii?Q?GVZJtNcG++Oe5xKBc+R+PyCy66i9mwIBbC4Ged2F/Dx1XieKr/M4U35eNOiP?=
 =?us-ascii?Q?/DcjQpjYRpHjKXcrLxZ/uXNN2wCOKxuMoYKQXDfgqWjYLx1h8LDCSnBvhXFS?=
 =?us-ascii?Q?Qpb5XmK/Tj4wbhk2aw2FUASdAIwYbHPRzvaDSypGr02q3GBl+fTB+GcnGYpG?=
 =?us-ascii?Q?KEiawINeE5EvOCrlqC3RChptXUhKNuw/wzxqPceChB8qOF6WWvpIB0sxgq1s?=
 =?us-ascii?Q?2zJMW2IinlWi22kJrdHk3UV4ay3R+pYJ7bb4Kbd9AVKc05j4LQNp9RK5iT3A?=
 =?us-ascii?Q?Js/wSiUtYn4HkxXIwMsFZ7IY/4Oj+OiwouX96PnQpOQahvQNcbKTo0tptkrc?=
 =?us-ascii?Q?6VXdIA6tjFFyW9HFr9NtaxUIvlxDYu1SBhDpBNwQR6vk9JpVJaaAAObEzYVi?=
 =?us-ascii?Q?/RhQaGImeum7KHHl5+o9UrUl4XdmS1h7eJoOGiMi09Im/N3BTedDpNBXDW1r?=
 =?us-ascii?Q?E07+ieefYYPkvlOXP4bVqRRC1Eo+0VILZT/b1UoMDi4fofxNSl3VRegJkS8v?=
 =?us-ascii?Q?bfFWYFGp5ycJaBxxEQeGvXEeP06Jqv5nXcLA6hDCj0uOPtYS6UshLwLIi1iE?=
 =?us-ascii?Q?Wl7XITvT08QgWUiXAH+YCUQUL2PjaU6RiRAYxzGjtXAIihg1VDiPxWw+lkag?=
 =?us-ascii?Q?AaDX7LWDogtbD3cv4dXwSSctdQyCcc8XmsPI6eYJq3skr676O1AaPBTWNQcK?=
 =?us-ascii?Q?OES1JDxccNIE04qvFffC73lqIC4XWwiEpeLu0LGOC7ybJVlar+VeNGtHkY9C?=
 =?us-ascii?Q?HcfXjWdQF9YX4s2yZbER8kH8ZXxC6Jg+32K8TL75QED5YTby9Lbdy7v058JN?=
 =?us-ascii?Q?g1olUiZB9qYagXQpvIejDOiCfjzAOPwwEFxcJGc3Id7jTs9nWtdRo1eQLYva?=
 =?us-ascii?Q?2M3VYG1JL+9MkRemkPtloomNxiMxNx77M0qR0eqA70fy6fz5l0w5BTJe1vKh?=
 =?us-ascii?Q?cD6sTIPslwLDIJBpNeLSrGYUXeU99gVkHRHtn8npLHUjpq1nFRPEAU/LH5Eh?=
 =?us-ascii?Q?TP/1Z+ja7o30bhSgTdKi2zNJ5X+W9vcroZwphIdkZ0YjYlW9+nqO+pECXa9y?=
 =?us-ascii?Q?l2zTN+zCkEkpugilwsIC5YyADVU6IrSy8OWUcdDswNVhBQVmKLWtf2y7USkp?=
 =?us-ascii?Q?5GTTMBbabWkNKJZXWMH+dTKvpZ/MwOh9+bxfwxj9+a6HTemh6SvK0BaA5670?=
 =?us-ascii?Q?ERepwYRyjOu3rjMbDyevqLNz4SIs6Tz3ZeBzFACRdeKWCQvqKIkjRAJGWv/r?=
 =?us-ascii?Q?YUGqdns3ZDBv9fxLIPzRft69XmB+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3JfL5Dwy4r+qY8AMX/4NCtyk7nrXiyDr9LAQFHoXLk/WuhvEBA9r4Vzy5mzp?=
 =?us-ascii?Q?G92cCVvXmCDtwnJXryGVux+3otITmewbpUTXOJ2024Go2XL15EHRF7c+/2tX?=
 =?us-ascii?Q?BauMhLT5LGYPN703hysIdXttr5VQYMJtneIjqKhbN2iwFGYluBjimSXrCUJZ?=
 =?us-ascii?Q?E3s9RoaXC4rrEK1qqtzQuS5zqLvBPnlBdw/OaWDlEu7Fxp6rm9oPomUDzS14?=
 =?us-ascii?Q?4pe3MrIu06dHP5yZkxoUPtxAU8xETUHXD/+XOYOfHnJmRC4B9+tKXZB74lvb?=
 =?us-ascii?Q?h+MbguSOGWlv9mdghMwRUbyyYcLzM3DjvVqFO5IGXIgmF/eml/WxzT9kEFBg?=
 =?us-ascii?Q?CQ/OqZuRv46Ob9geDUaSDPl/JeQI47GyMVYJCz0b1QSu2ZqquXDU4wU5NSc8?=
 =?us-ascii?Q?JXOoUnvw8UP7nLdjjAyipD3pDXT9nNjNAq+i6BeThn6Vk8tkfy4ms8zMwlSp?=
 =?us-ascii?Q?s+cE+0bFZrRtEm1cCODEEgywEbYNC1bRonWxp7ehzK2fRhMJSMHDhgv00P1M?=
 =?us-ascii?Q?2UDWrs+ec05Oi3CUDm0CLLYHAozoLW3TOdhstA24CIdVOucjcn7TQi+yZKgF?=
 =?us-ascii?Q?kTrEEdoRByetjupITH4gbKPnzDsDezsu69FTsi52My7jjGLb0ZcxC1iG8QSQ?=
 =?us-ascii?Q?gEk4ziThmscJe7Pvj3iFXPJnH9Qu5/Qbia9OzsJ/vUMufgtGItjovc4O+7VQ?=
 =?us-ascii?Q?qOPaXH0q/sbU/oHhVe20GwiZCt+r2QXpju/H6pCkP95mMMhJBdoQc+Bm6G+Z?=
 =?us-ascii?Q?AjkiF5X2K0sUd1lEoTF1efKYJzupfRxDUkpF4/xjVVP+9kbKdyImbzJhroyk?=
 =?us-ascii?Q?4iFtQGx5xzm5F0fyLbk8nB3lI5A7glyvCQRKg3Rud/NXONj7RhZr/F7QGsz9?=
 =?us-ascii?Q?xlUucTgMpjVkHv0ja4kduc7jLZnmhkuNfGPJTcHCCDR9mZjwcLB6+COne15e?=
 =?us-ascii?Q?8v9+D1uljGT8vlYJi863c1Do7T+H0O9ptYpUwECzua53Ql2cZlwMN8Thddb6?=
 =?us-ascii?Q?/x/og55ykL9+VC2uqxt+FssnQgsDn3a+qz4NZ9vsKjdlh14Az5YRxkAX4tlM?=
 =?us-ascii?Q?RvouANzNgMZPZSF/YJboso5hRJPVCr+KfIsuvWM5KQUzo598IKi4sQCnrHWW?=
 =?us-ascii?Q?3qpzFac0Ebt1RnAPyIYzIeABynvfaiaXKA5Gwv3Er3QJ8oLx4QPB845YtXpT?=
 =?us-ascii?Q?LYBdtknh9p3kDBroT92VlAm8lF5GKSEWoWMjuwbP6jlIL9ZVZarNIh3LCqIM?=
 =?us-ascii?Q?iCgLiUqdfRuEoLQQCpdVg1rempF3T9pLCW8CEPru0vokJGO+d/xBNPOOtt1g?=
 =?us-ascii?Q?MJbmLaMFFrftLfu2sdQb2GQCeNw3fpnwXjhfuO2uHpCxwvAvaQ5ogaS0jBL1?=
 =?us-ascii?Q?yh4NVNQxOfNRVPRlXZQ9KoUizAv7I1n+o9EoNe7iASOuM9Euc57TpXLe7950?=
 =?us-ascii?Q?p8GUaDhukeH1EhjTIPplp3ErrZ7ORSwQszkYRwpQ6zQH+3ZBxhjH9ACWEUG1?=
 =?us-ascii?Q?s562z5iKLnvyh62XIDLx6mhnA7yqFTxsT2q+18nTBfouYDsqTdds3U9iH7Jz?=
 =?us-ascii?Q?LpErk/NTxSUavRT/hNHp3q19UChgkjYF9APx/OmH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6991a3d-bc7d-4621-257a-08dd3f2c519e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:42:53.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLfw2fZsuhIleM7UljW0D1P1C2t+asTYQFgVxCXeG3wgoch4ZGCsUqC0LVtLC3Rw+Q3645xgKnh4Wu5ergwlhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405

On Thu, Jan 23, 2025 at 07:55:24PM +0000, Matthew Wilcox wrote:
> The page reference count tracepoints currently look like this:
> 
>                 __entry->pfn = page_to_pfn(page);
>                 __entry->flags = page->flags;
>                 __entry->count = page_ref_count(page);
>                 __entry->mapcount = atomic_read(&page->_mapcount);
>                 __entry->mapping = page->mapping;
>                 __entry->mt = get_pageblock_migratetype(page);
>         TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
> 
> 
> Soon, pages will not have a ->mapping, nor a ->mapcount [1].  But they will
> still have a refcount, at least for now.  put_page() will move out of
> line and look something like this:
> 
> void put_page(struct page *page)
> {
>         unsigned long memdesc = page->memdesc;
>         if (memdesc_is_folio(memdesc))
>                 return folio_put(memdesc_folio(memdesc));
>         BUG_ON(memdesc_is_slab(memdesc));
>         ... handle other memdesc types here ...
> 	if (memdesc_is_compound_head(memdesc))
> 		page = memdesc_head_page(memdesc);
> 
>         if (put_page_testzero(page))
>                 __put_page(page);
> }
> 
> What I'm thinking is:
> 
>  - Define a set of folio_ref_* tracepoints which dump exactly the same info
>    as page_ref does today
>  - Remove mapping & mapcount from page_ref_* functions.
> 
> Other ideas?  I don't use these tracepoints myself; they generate far
> too much data to be useful to me.

I'm afraid I don't have any specific ideas but in the past I have used
these tracepoints mostly to debug issues around what is holding a pin on a
page and therefore preventing some operation, usually migration. For that
page_ref_count(page) and page->_mapcount were the most important fields, with
the latter required to determine the "expected" refcount.

The ->mapping field was less interesting to me when I have used these
tracepoints.

> [1] In case you missed it,
> https://lore.kernel.org/linux-mm/Z37pxbkHPbLYnDKn@casper.infradead.org/
> 

