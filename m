Return-Path: <linux-fsdevel+bounces-37767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3CF9F7048
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 23:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636341685FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 22:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5B919D098;
	Wed, 18 Dec 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gNsbdzz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90E1991B8;
	Wed, 18 Dec 2024 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562167; cv=fail; b=Tnvtze5YwBMEj7+V6K6p/TyQ2s7hxUoLYrHyOIbA1L26SJhdQBlJmOWSh6ZJ6cj0iC8lpaEIH4i74XqcNRLnP2TvHVG+3plI2C+s/zm4XJfMVy9TKwQLp2a0ge9DU1hgImTqvhTT95LcQCYLLky+IwlZmJLB5es5nnyqUE3rX/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562167; c=relaxed/simple;
	bh=BdfA+wy5rz5oRvBNKV1BxgocN3tcjENT+7PwkYMoF9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evDYAMP+2bzeKLgp+EnODeFDK08lh68+WpE2obXteIIAK87NIqbLQ73Rd7ORfIt/9TmUCmIh9yyFb8pDkHr8dFsKQSUe3mgdyH9aQUrutU1vP27jutWNvtjDPGnUUWhTuJpUh/cOgsVwYWIZ6A76Iyp8w1LHiHK/e6uMfZkZyow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gNsbdzz2; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTaoBnevIeEQXIPNew7PdOZ9o4Lpc/4b0jNKqqh1YnKklPvbeyfAUtLYzMAD3dh2ViEzwbt9EqJbK7277070RlKrpryFlNls+u9x+kDIrPLLCU9meVGpA75gc+4RbkdnSkGk61n78SNooWZKmUQTpIay6Ke1yqx9vQ1X05r4F6W8NyaQJL1AtevTRrB+WcRE1rMMma//4ofWuNOfcjYkx/AONsv49+w8pOMWpGuXekUq7BZzLNdItxd5u93BrzK+lrzRDywnsQSmrBKdnSDHwiZ+7XxElFub0aysTFlY1mzfy5WWhUVJhmyPNSIe5GDsocBZg2/1aggSOKcg/8Bu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TntSzvEXUOWNPMNazJTCwbyu4pJDZYd6/Mf4IwJ2Mww=;
 b=m5Fdl/46PNjC343rMURUjpa3LylhYv5YHhtEW3S84FK59ZIewOCbyBJdzzqBHl7Q0PnV/cs7DTlA+DTfqYZfe6rrUB6uOomjJP6teS0fJxbRIseOwoV+qoAQZV+HfttLx7cKcV7PQIG390V07GyvWDy/09SOQJh6IwDs3cZonKpbTnHH6IX5MtAPkMIYbud6zP0N+I42cZrN1qvBm7juXiU8poC40jPFeBHqVgvdQeArWLjdJ90a5+M/BM+SbAstYCUhGkoCNKubDBOIQQHA0+GB8yjVmUPgzI19eqx6AzUy/Vhh+2M+RHJCc0t602obhDYGbp+EW/ktnBhE8KJjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TntSzvEXUOWNPMNazJTCwbyu4pJDZYd6/Mf4IwJ2Mww=;
 b=gNsbdzz24S4QoLQvEefNRhDgnVMIOId6tqFVXi+pUIqmAeYR9tyDBOI+LTEwu20UE/dWcDW6mQGYE5dmkPD/3MpWUZNj+xA7NO+XMsbn/G1MPw3QkxB4E9SJgixjGoQDglqfPFyMGrdb2HljPV/9S4SWmUCQTE+SptVAYdk7zy1UcgGMQa+Zem3z9X0FPDHElC88cfpDjnUXUp6wGIChkS6adqoMBA+EiuyUJyl7PtosDMMLt/imWCHManL+WVh+hev+oI8oMYYUCEqMBb88sXkRxQ3tnJ9SxDUeA8JEIFP6dLeXA36bSs1f1ndokY6ZOQLv4CzCxqPyw9DI0I03tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 22:49:22 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 22:49:22 +0000
Date: Thu, 19 Dec 2024 09:49:18 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH v4 10/25] mm/mm_init: Move p2pdma page refcount
 initialisation to p2pdma
Message-ID: <bk6cmiubwvor6gevit3wgl4k66xxpfcv6swmfrtvxnjnuojqkx@yow3pmyuxozw>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
 <aaa23e6f315a2d9b30a422c3769100cdfa42e85a.1734407924.git-series.apopple@nvidia.com>
 <359a1cf2-c5b0-4682-ba3c-980d77c4cfdb@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359a1cf2-c5b0-4682-ba3c-980d77c4cfdb@redhat.com>
X-ClientProxiedBy: SYCP282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::24) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffe71dd-2e6b-4a63-8217-08dd1fb636b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?24+F253LJRoTpK1A6lcedv6/9pmEcPT8TDXNaNl25l9WxqsD1LEYgH1yMv3w?=
 =?us-ascii?Q?0u7EfBG8l0/e4t6MhOiiMtYrdctGmqNaTxXFYrmjMmhX+ZI34VuCH7dN3vrN?=
 =?us-ascii?Q?DHyqEBOTIfHOCFrbd3/wCNF1BU9fDFJ3EVGZgIWNIT1+vcf+Dz+KF5QNSvlz?=
 =?us-ascii?Q?UASvWP21cYYUnpjs6QYL6G2Gn56I8GcVNdivoCZ7zj30TpSdh+191XPNkcb+?=
 =?us-ascii?Q?UOeYBC05jNTPocrpZ4VdUUcqCiDr3KYyYn1CRoSDPtuRreyBKnk9d6SE2u3/?=
 =?us-ascii?Q?Y0sa4jk1TWiTDL2dlDYialOHIGhyvR0McmtVizoj0Sfb1jnRwhGb5hsW2bXs?=
 =?us-ascii?Q?XtMks8Sb8rGHBcltxVzR6dNhwRe9U5ziE+Xdm7F291faNJicH2739wzuSNPP?=
 =?us-ascii?Q?woDwnYFBgZ9PKgMPoNqCm3ddVVkst8xbNZxxVbookmKUW7oRwjm9VNqWNjBB?=
 =?us-ascii?Q?J8yMdxyMKMM9hVdXMZZhUJLNt0nA1Dvh8iA5HmPvHRPC/GQF+WGhhupeQccm?=
 =?us-ascii?Q?c5k43UPvyI0Ns63uxew6T9+fIZm8L+OVq6sUlcaRpX34MHruTjxxL57Z+I3Q?=
 =?us-ascii?Q?DgvTY5QrEbbGGWo4u+keZ3M5mgWH3TZNI5knhiuBzc815kYu0ovy07EzbQ9F?=
 =?us-ascii?Q?hBLQm0ZNIQsa3cpx58NUZ+9gMF3JX13IhEtoAdtMVkhcYCLqasgzlRuEqFFR?=
 =?us-ascii?Q?QcCywwLAK+OgbHB4rEVqx7hrjY+R/Ti0GlwxZQcvXFiFLUB0O+6IJZKGGu33?=
 =?us-ascii?Q?DT3jSma8J3QIeAal0yi6XgTVs3+4PJ81B/B/qjtmIsQ9hznjMp5z4azUSzkD?=
 =?us-ascii?Q?VbODzFfz27pp7XbU5x8a9lmq0lIhP+MknHJNTnHRk6Q1xbF8yo9qPzn8oS68?=
 =?us-ascii?Q?7t9KBTpRTdv3t9R3Nz9VlPyU3aUoRWwyRUzyFvKY3M36h2G6lpI77QQv5g20?=
 =?us-ascii?Q?p7Hr/NE575LXbueC2AE8nJytEHtRzE97wCXez3DQ1aPZWMKbod0+9sehiEKy?=
 =?us-ascii?Q?xqAN0NQTOZhHZuXLhBBRBEsSQ1j7ggrYrLNgmq7hxV60Tq1kNJoKXcxodZKv?=
 =?us-ascii?Q?tQ2uPp7Yg+6inWobaPpNFbefiBfFX7E5YH/vjdPkD9I/pQ9LM1wu74Bm0YGx?=
 =?us-ascii?Q?F/lC+ABGrhbmPcwbSyhipGQVbiVNOT7CpIRjfPGAhJGi6kY5+bgKw3s0agBB?=
 =?us-ascii?Q?WA/g9IiM0qP9I8gcGSy6YBZ4ECGvA3MbXP4oxS88WbXQXhyVJh7gyl9lIsR0?=
 =?us-ascii?Q?tmHTB1WN5vjuWkghKAksq9864TOq3+OtcyfKejQfxwJoa77f12M9wQBts2pN?=
 =?us-ascii?Q?H2j0Jq16vngHLc3g3y1a567a3ky1Mi9YIlcdd96siuAggykkdo9aYFL7TjTO?=
 =?us-ascii?Q?hQXzCvcd5TCkatInJssfJW4kjh70?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pjd+PGywJ+ddECp/LwLw3g+eeM9HA/SHgMPrKLJYq2KgG2OM6ds3Hodstfo7?=
 =?us-ascii?Q?QutO7+yzJ3heAm55UnkIHuPzKEPu/lDr744wOXjKQh9sonDXGGxb5BHdqGop?=
 =?us-ascii?Q?0Mdm45gehoHwudFUqaquUgl+kBXxfb3qDHnVM/lnBynJhZJ+i3rt7HBUUNAA?=
 =?us-ascii?Q?IB0wZEPrZb83bTgJ1DAO8NkaOoexCcpLSfozS6KBP7ZQzfHXXzddtmGdr0tw?=
 =?us-ascii?Q?9HelC96E9M+CyhE2C/VKU/jtmtyj6oJrISD3mCAQE/m3NNm/wMyBB/EG6shU?=
 =?us-ascii?Q?pI6HdVOO9+1xgQlQk7OOGl9F1GWUCf/SGjwyIXkMdwWmXtGyT0NsbIiLjC2D?=
 =?us-ascii?Q?IWh4Qez0w0mYZuK4wJvlUlEfnfMijpIsePIcZELQEwUdPScLnF/rIoBO/Avg?=
 =?us-ascii?Q?sqYEWN13HpeJ74WMBWIAsynhBEqoEYgqRUS8fKcaF9Ek0ZSJHza3WCPfwOxW?=
 =?us-ascii?Q?84TY+V3dhG6uSnkI59WuMv99+vcCvUk8fQTQWtqNbImI5mSl6Xtu1bOwgmVb?=
 =?us-ascii?Q?IhcfhbesnpoviGnWdQzGrIIkBz88FUIrR+nBOwr9edjWlVC/elNzHI6xYYXi?=
 =?us-ascii?Q?YFF4vhbSXm6biEb0pKM8NHkkUsIJQYVPcbNeiwT0ju2TvsK0+CIQcJWvGFix?=
 =?us-ascii?Q?KT7dEpQ+fTxowI0Fap0NWz1H4y1WTkYz78xtmf75BUKxvxzBg2Xhp/PT/RJw?=
 =?us-ascii?Q?hxoz1C3L5Dsnx1CQBP1pgDmE91c9ALyi9FyTEKzzDHShslVbcJQFrwSTY/Xs?=
 =?us-ascii?Q?cWFhs8NRwnmo5QpTtZzwl4oL2MqVTtf4drVRsEAsP+/7G8IwXSmcI7feLKb+?=
 =?us-ascii?Q?Wn2rrtD5861lKmtzGxZvWuA/dFxL5ko0IyjQ76uBYE71iNbP4MXVml+iti0i?=
 =?us-ascii?Q?8Ey4FQWPrCcYGw2Oijq7K+821oN+GFvwODodYdCK2dYeZ1icuUyTdd/TxZKc?=
 =?us-ascii?Q?4btR0oG8/lSXGf8mtNBY0pZOmCXUctEIjiLTbvkAWwa4+5sZGUnEOa18rlO8?=
 =?us-ascii?Q?CwwtA+U2xcyLJ90P6lRo4iqEj7/oUu1q36ANNCAs76as1wOkDAjIMLjwU3Bz?=
 =?us-ascii?Q?BxZkhu3knWPTxUIVCfpO6oZHRCiXxCxrkaAUsjS00GymLCJbPbLgLXGtDaZG?=
 =?us-ascii?Q?jjXSnuBg107LZkqQhJJYwNVU77WANDbPFFkEeRfzdXMCQ7YLE8gjH/RxekTH?=
 =?us-ascii?Q?NhYoYqRg5yI1Udeo7iIZr3HoYN5jOSInmduiLjdR54vf9yrNOUQsIjPpziJ2?=
 =?us-ascii?Q?Cf7LzPTC+gDhEs+08OBF9Hpqztyp9hD1cldZR76RUxC2LBwvz8mc1SlguFmP?=
 =?us-ascii?Q?QWGAfRHxLuCh/cYvhn4twgh25HROjRK4KmWU7SEfxcLrDqhP+4a3QyMSaBfW?=
 =?us-ascii?Q?omNKgt0HWE6PhkWv1oh+yrfJgQa7UKeFWalol08ZO7C/HbxIHy01ykFZ0u4j?=
 =?us-ascii?Q?R0GTy+UXwYsCsti+Z9WUaTbRMMKlXOWbpKCuikdLpBZ5hU2LL9Nf324GZ1Fb?=
 =?us-ascii?Q?4nG0CodxAl0bDcFIwUGFQauUOA9C3kDITM3zZiylGD3rWzjWZaSQvk4N09ja?=
 =?us-ascii?Q?wYx5Y5Te4s7ofBiHOFe41/PHNPhj8FsqyTitFy+U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffe71dd-2e6b-4a63-8217-08dd1fb636b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 22:49:22.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnBgmtDOTFmkC8UbZNf0fDHwQiJrSv/48IoakA7KAgtiPSSV2Et0ctS1OGWOtAOA31MYvJFtG2GKdelwVzjxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104

On Tue, Dec 17, 2024 at 11:14:42PM +0100, David Hildenbrand wrote:
> On 17.12.24 06:12, Alistair Popple wrote:
> > Currently ZONE_DEVICE page reference counts are initialised by core
> > memory management code in __init_zone_device_page() as part of the
> > memremap() call which driver modules make to obtain ZONE_DEVICE
> > pages. This initialises page refcounts to 1 before returning them to
> > the driver.
> > 
> > This was presumably done because it drivers had a reference of sorts
> > on the page. It also ensured the page could always be mapped with
> > vm_insert_page() for example and would never get freed (ie. have a
> > zero refcount), freeing drivers of manipulating page reference counts.
> 
> It probably dates back to copying that code from other zone-init code where
> we
> (a) Treat all available-at-boot memory as allocated before we release it to
> the buddy
> (b) Treat all hotplugged memory as allocated until we release it to the
> buddy
 
Argh, thanks for the background.

> As a side note, I'm working on converting (b) -- PageOffline pages -- to
> have a refcount of 0 ("frozen").

[...]

> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 24b68b4..f021e63 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1017,12 +1017,26 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> >   	}
> >   	/*
> > -	 * ZONE_DEVICE pages are released directly to the driver page allocator
> > -	 * which will set the page count to 1 when allocating the page.
> > +	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
> > +	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
> > +	 * allocator which will set the page count to 1 when allocating the
> > +	 * page.
> > +	 *
> > +	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
> > +	 * their refcount reset to one whenever they are freed (ie. after
> > +	 * their refcount drops to 0).
> >   	 */
> > -	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
> > -	    pgmap->type == MEMORY_DEVICE_COHERENT)
> > +	switch (pgmap->type) {
> > +	case MEMORY_DEVICE_PRIVATE:
> > +	case MEMORY_DEVICE_COHERENT:
> > +	case MEMORY_DEVICE_PCI_P2PDMA:
> >   		set_page_count(page, 0);
> > +		break;
> > +
> > +	case MEMORY_DEVICE_FS_DAX:
> > +	case MEMORY_DEVICE_GENERIC:
> > +		break;
> > +	}
> >   }
> >   /*
> 
> 
> But that's a bit weird: we call __init_single_page()->init_page_count() to
> initialize it to 1, to then set it back to 0.
> 
> 
> Maybe we can just pass to __init_single_page() the refcount we want to have
> directly? Can be a patch on top of course.

Once the dust settles on this series we won't need the pgmap->type check at
all because all ZONE_DEVICE pages will get an initial count of 0. I have some
follow up clean-ups for after this series is applied (particularly with regards
to pgmap refcounts), so if it's ok I'd rather do this as a follow-up.

> Apart from that
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

