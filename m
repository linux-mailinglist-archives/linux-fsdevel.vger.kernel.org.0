Return-Path: <linux-fsdevel+bounces-38998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E428AA0ADCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 04:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44DB165183
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39AD146A72;
	Mon, 13 Jan 2025 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+n3cm0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F3632;
	Mon, 13 Jan 2025 03:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736738355; cv=fail; b=Xh04P/2JmcAvcVnD/PCu2+aeW2/pdJpuCfFXfqVIMyC+QPnwoteyC2kYs4IGZJVpZyzdslSqpDWpWwlUPxngebAsnJhnHtP6/GHLhpIuahpn1we2U3ZjYBuTCsEdNIlWXf45OCrL6oCKS4wU7knz/EYqSqZk5zOs+ciCqrqzo6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736738355; c=relaxed/simple;
	bh=28TltqNauB+SxiL8eINisya6VKcL9xAQ8KLVBvNv7wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=okNdV4ex3BTMEXdumr72hdWUun5MnAwvsihHxM515DyVhNvEwHG6w6Ap5TMr+k1asx4X4vxk+gFtqIhUO3BkLwJo1PwAYqFFEqAafmbI7/NtGd7BA5tU/fFjjNfzoyicLSuxE76wR9u3Tv3aB6fWAg07iVeK22PfPA65XKfi6EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D+n3cm0i; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi54Q4ekxz3RDVbxFZqi6KBW+++sGIAd4yxZs1Kk7LWsCEyb35IpgrB5na7zNx4/E5UvjHumDftrZ6MUdjwB66B6gTbSm4OSSCu4uSFsuX5kns3qMCxsn8IGZWrQAi4zwMAE20Oc8TE24VC2sRjVsoEDNu2NnE/mT7dVG8mqoNlTDKVilf4d7CYVezZNMKZHyj/uxytYcjiEDkJX4TZVZnV4dk3PfGtRkNJ2XUb4PMfkqR8QDejKpZC5IMqpS09nqscya7TsoU4sjZrDFOiAJks0QstLyKijO+3MIe27V9fgnIwG/kNa+ohXf52q7dNFaVXt1zajjGjwsoQjJRuDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Taa3UHoU5smvHnadmYdvHEFxz1vzXJM9kiMYmjCgi4=;
 b=EboVAsK5sYWkUi24xl63EZnpxOclViGs1J7LlIwIgrrRcLnik/6GBucEQFtdd8AvzMjBJ99MSgrumlaXveV81VFJTPz8OLb8oLT/PQtGhFZyhkYfguGq6uJjOC87iY+tmhixHVzG4METcv1vOCfl72yFgTgG/o7BY1qKVsE6aoa+Z/ONAOah3MwHaQ/rYT1m79ETeTF1STaGqid8Vn4u6YHLZI0HTfIgLstLNdbXdM0xoSJh61Qh7GPlYUto/7DFWNOn5pdGfAQHp7j9cGoKOwlRtODQOC3q11cMKSGQHV3hUe/XfiGlszrqBQihTbWxuqcEl0hI7k5gN52rPuMsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Taa3UHoU5smvHnadmYdvHEFxz1vzXJM9kiMYmjCgi4=;
 b=D+n3cm0i/2q8olxAKfU7wO9ke0dHnD2PQt0z/uYihnLYdwc8pO6+OEfgeV0dZAMNKQiBS/io8fqg2JeFuQkfdb9ZOQDOa4tVbcePIVErw8CnWyaD8TDTyCbXJf3RJWaHVQOqrq9KvhCx0Tu8U4MP8u9IMb9EqmoUPtOfrEVV3E7pr0p5DurR1jdQ83tNcMkxCzprNew3JmW0aEC+B14WfmyGxWqjzq3w8upeDtfK3LrhTYoRmfTwd70qBX70MtZFDTuNJNy0pcLwt5lcZnxYOvyyANagRbnznHACYn1kywdPBs0oWcpZK1qTWOXCs1JHphlihQSXRq5/fpdyXBK52g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 03:19:07 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 03:19:07 +0000
Date: Mon, 13 Jan 2025 14:18:57 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, alison.schofield@intel.com, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, 
	peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 21/26] fs/dax: Properly refcount fs dax pages
Message-ID: <zwbuflyk2fmauewhian7hcqibcbyjjofqowbddrud4ohkbora4@yrdd4rjt47tt>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <b2175bb80d5be44032da2e2944403d97b48e2985.1736488799.git-series.apopple@nvidia.com>
 <20250110165455.GR1306365@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110165455.GR1306365@frogsfrogsfrogs>
X-ClientProxiedBy: SYAPR01CA0045.ausprd01.prod.outlook.com (2603:10c6:1:1::33)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 5308ee97-f7e8-43fd-1b9a-08dd338109f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PO2uT9a6uIgd4Vj+bP6y6vSRHo07509s872lfZTFQtYkzUZpPjGwQNqqMJE?=
 =?us-ascii?Q?rOWcDP7ARptAFS8e5e0rw97k2SEAf8n5DMPzWI6JqRenUhm5eswIxKi2ezLi?=
 =?us-ascii?Q?1rYfawyIpWvgB/hNMmDQU1EdS0yNigpDmEKu1MTOx/3tgUpHkIGGakvKzx32?=
 =?us-ascii?Q?dvbLzVAt4XqvbKx3dQhoqXRnkUtjcwuLsuYSxzmREAgT3Hq86VugCZsT0nbV?=
 =?us-ascii?Q?QHN52XHhy6Q8KzhmnGn6Z+kIeXhud3IWk1nnXk0wZ0tExLwSoqibxFu9sV+W?=
 =?us-ascii?Q?0eXOw7xeLyBB9b1G99+hmYa7pmJRKIC+D6piz+Wg1Q7MUoJgiOS3WTxIjShG?=
 =?us-ascii?Q?NLUb7uhV++IgdQ0rF7rHCWTUYFrj3FlXwrhmEkaMoPHcUAxYVIJrzkPnp18Y?=
 =?us-ascii?Q?vHo5/ZKG7Uli/Eh6LBNdAqGiwLrMuNrmVrWEv0DKJ1JtAH2Bznc/+V+0Kkv/?=
 =?us-ascii?Q?gX0D9tTn/aA+47PIZ7dBKggL7gjzxcwrJMYJ3w4DxI7XtNkoDUq1Bw0kfksy?=
 =?us-ascii?Q?Cuj/ggu75nQDNV6VJqXY8X8E1WqoOkbKHXnud1JDp0KPEh4G6oDINibQNvHa?=
 =?us-ascii?Q?kWWE3kYDX59eZyQQVOK6AedxjWIwZVg89+xHq3oG8E8iwsNDcpiX+r+liPsE?=
 =?us-ascii?Q?wKyCFyim423wtjXc4mBQZu1hsuAF2XyHvV5kTQMuUlA9R3G00verV1BS1sQh?=
 =?us-ascii?Q?etdfX6mc8rlgnvXMenmH8CeZZUMwVlwoR5UC0XIK9sP/zKZUXvB8iZWnGGtJ?=
 =?us-ascii?Q?U7JMBgjX8Fx7WLn3IXFv00pmEwVCjDYNy6tFWvPA/yk7nZCaP0PuKCrukNfq?=
 =?us-ascii?Q?0PAVxloDWbd/ez+Qp504JSf09FhD8+y5MdG0xT03ObuOY++XvQxFXx+A8H0Y?=
 =?us-ascii?Q?VJggZ/cj9exHXuKVyph7Uls8xtledqPMJfcfUM1zyro2+nn1DwBvSxh7zSJ5?=
 =?us-ascii?Q?UggW1I2lmO0aiRlF24gtD9TdQUFfWZ6rHO25VZn9sqMiwDJ6IFmmVouw7fs1?=
 =?us-ascii?Q?FCHiffs0rk00pjK/nDevSPKIHHqqYK8t99XmRwplaeySh9AwA+RH/ut8z1UX?=
 =?us-ascii?Q?LPfwMNUqrNh9x2cxnOsLt40p5mCWBQVX/TpGAWQV/XCW+EZjvpwfIQuSVBe6?=
 =?us-ascii?Q?QXLlRqa5RvPORP9d9DpAYAWJETE9Xhd+iVbJHShaDnq4/atnq7Y1zKI/pBer?=
 =?us-ascii?Q?upA7iFtLiWhsHjugcRXQba4qLOr9bYdqGGIrb60eFqtHMv5AzonQhn4ParLJ?=
 =?us-ascii?Q?WUXV333XINmPlj9NX6L5DacCi1kuzak/2XBnScZcgr6mVjiUbM+4BR4q1+Is?=
 =?us-ascii?Q?QIHK9hHm0Gy+WpzosqoxJuso2eJ8iTG1na7GEm5UxAiM93O2kRzwYtu2nU6F?=
 =?us-ascii?Q?pO4PKMegLZ6kR2Xnh9PPh3Wdh6Ac?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kh81mUX0ZbGvD6ASUSfKsT8hlmnL7v1nYkYkXGuCWK+YH8fXBKki5rIC6nRe?=
 =?us-ascii?Q?yZGDt9LBv/tAt3o+Kv+BQWzThCnzVkwy5KK1BhDyEu+pok/ZdQEaL7TLtI1k?=
 =?us-ascii?Q?ZC0UgBr2ByR8IZaVOfi0Z5bPVOuZ0hSYnwYYvRZ0GUo7yisxi9inc+nK1MEf?=
 =?us-ascii?Q?Wi0n/9f+C0QPxdSQR5QOhR9dD1o6sxHyK03uBNXVIaYyxOaEJXQxwr9kCVYq?=
 =?us-ascii?Q?GJOEyHDkn6eYC9hZg/x57B8izbUNr1AdNs5BVJX2l3cP6XJixH9AxALzWKJx?=
 =?us-ascii?Q?+qn0ZzUByFzkZfL+jyNtDvk1exN21Lscn2iv+PEL/ZUcMyzfXrLIBexE5QVo?=
 =?us-ascii?Q?md+lN3dBp/zClWK9MO1ULdqKeS8u/0gOid1W2R9f2Q2Zsc75cJLv8Cokrau+?=
 =?us-ascii?Q?D9K0bCdq7wUzg1FEnp39ycGkTKwNJScZgrl3W5zDdnlcIRKfrNw7Wsl/NXah?=
 =?us-ascii?Q?wKt7Hvo/GygScWy/gnmJCOxq9KREmUVk+mxxadt5GQFKiflJ2erFf4OWShzQ?=
 =?us-ascii?Q?McT+y0kqFylyKCNeLx8HUlZoVJ3aEUb0g0LjA3SgFDsZ6ImbaJJSw1jx7bUI?=
 =?us-ascii?Q?4ZZ3Ag6Blhm9ew6mIJ/R9mxtxBcryLzxwNzpSDL/qDLdFEP96TdXIn/yoFcq?=
 =?us-ascii?Q?+iUpsR6DJ2dG5um3QU6l5LqKI1yC8rc7QlOjT5d5a45ktL4YhbFZWDwGcJB+?=
 =?us-ascii?Q?Cv2jQGgBqL/Fyg0HreeDhktK1xaaN935EbOjak8tCe2YAIqwnWr3g8G6LNyJ?=
 =?us-ascii?Q?LtODTNQ4H5TLzp38elHocXY3k5b6fzKxUUS1ac3iwg7rA7loihHr9mWZdAVL?=
 =?us-ascii?Q?C+QluGmi1MdTqfQtCgw/tdDsF3ndus7Tz8IpT2jYfZ5bxfwhBD88HfymKS5C?=
 =?us-ascii?Q?ZtZOBidZCxJQMrvBsoIC20I6UiPlT9bMTYcfTXaCaFbEwySg0Bj/Q7SFvz17?=
 =?us-ascii?Q?zQsf/1EvwyyBZdqMiw8/FdY6j+NsQvRiFsYl40Yhaf3CvZor+Z6Admv+DcrI?=
 =?us-ascii?Q?BDsbJ8tvsE0fUewJ/EszUO1XZ1DVACXlqJPSbin2ApyjEqY6hrQw0snj2ENH?=
 =?us-ascii?Q?yVR1teUMUGQq3oADAdhumvDb0PBS5jCmU6HlHOw58UE0waIXx8LQCG0n9MQc?=
 =?us-ascii?Q?2hQqZ2BbBTKzIU820rdLGNsav3YYAqnoIsy4kkp3u6q2U6Fpw2m2KjlZnRYV?=
 =?us-ascii?Q?9J3FCIt/8WD5WiJAGSGyZ69laI/1TZQ8k8cx/Uf00l/V+U3JyyuPZYLCcUR5?=
 =?us-ascii?Q?P+zAV2gWw4QFcfWCrtFfY97l7hmqbDNuNOrbwbequQfFmVXFEpy3e/cC/k6+?=
 =?us-ascii?Q?qXYAeg6DQAl8om/7E0fcvLb7STwRZfWuHEHS593Ig1NqffmUSsNHMdrSeAOT?=
 =?us-ascii?Q?1iDLx+DGD6t/GXYg43Yts3CKyGTUgnI60rHRlpse0zzXdfva6dzRHq/tpvpr?=
 =?us-ascii?Q?dr5iZ4ZvhjiLBKYa9MtfbbjTgXOyDymhejnubSLu+i8rQHuLoeFABfEq6gX7?=
 =?us-ascii?Q?4uLGZWm098vR1f64A1PCLdODQ9I2QFNx7T0xIOj+IJMQmZw72IKuHGe4xUpP?=
 =?us-ascii?Q?H6PKo+UYFV4Z7HNJCN0hZir9Ivr/1o39dXpBuMWS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5308ee97-f7e8-43fd-1b9a-08dd338109f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 03:19:07.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dQGAlCM+9ydbkDykCL3WKmU0px+uQ5/UfZDm0YPq4XoY6Nvub2TFcXsk/khu5ccMRP3L2Ci4Kacxqbxb7LgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152

On Fri, Jan 10, 2025 at 08:54:55AM -0800, Darrick J. Wong wrote:
> On Fri, Jan 10, 2025 at 05:00:49PM +1100, Alistair Popple wrote:
> > Currently fs dax pages are considered free when the refcount drops to
> > one and their refcounts are not increased when mapped via PTEs or
> > decreased when unmapped. This requires special logic in mm paths to
> > detect that these pages should not be properly refcounted, and to
> > detect when the refcount drops to one instead of zero.
> > 
> > On the other hand get_user_pages(), etc. will properly refcount fs dax
> > pages by taking a reference and dropping it when the page is
> > unpinned.
> > 
> > Tracking this special behaviour requires extra PTE bits
> > (eg. pte_devmap) and introduces rules that are potentially confusing
> > and specific to FS DAX pages. To fix this, and to possibly allow
> > removal of the special PTE bits in future, convert the fs dax page
> > refcounts to be zero based and instead take a reference on the page
> > each time it is mapped as is currently the case for normal pages.
> > 
> > This may also allow a future clean-up to remove the pgmap refcounting
> > that is currently done in mm/gup.c.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > 
> > ---
> > 
> > Changes since v2:
> > 
> > Based on some questions from Dan I attempted to have the FS DAX page
> > cache (ie. address space) hold a reference to the folio whilst it was
> > mapped. However I came to the strong conclusion that this was not the
> > right thing to do.
> > 
> > If the page refcount == 0 it means the page is:
> > 
> > 1. not mapped into user-space
> > 2. not subject to other access via DMA/GUP/etc.
> > 
> > Ie. From the core MM perspective the page is not in use.
> > 
> > The fact a page may or may not be present in one or more address space
> > mappings is irrelevant for core MM. It just means the page is still in
> > use or valid from the file system perspective, and it's a
> > responsiblity of the file system to remove these mappings if the pfn
> > mapping becomes invalid (along with first making sure the MM state,
> > ie. page->refcount, is idle). So we shouldn't be trying to track that
> > lifetime with MM refcounts.
> > 
> > Doing so just makes DMA-idle tracking more complex because there is
> > now another thing (one or more address spaces) which can hold
> > references on a page. And FS DAX can't even keep track of all the
> > address spaces which might contain a reference to the page in the
> > XFS/reflink case anyway.
> > 
> > We could do this if we made file systems invalidate all address space
> > mappings prior to calling dax_break_layouts(), but that isn't
> > currently neccessary and would lead to increased faults just so we
> > could do some superfluous refcounting which the file system already
> > does.
> > 
> > I have however put the page sharing checks and WARN_ON's back which
> > also turned out to be useful for figuring out when to re-initialising
> > a folio.
> > ---
> >  drivers/nvdimm/pmem.c    |   4 +-
> >  fs/dax.c                 | 212 +++++++++++++++++++++++-----------------
> >  fs/fuse/virtio_fs.c      |   3 +-
> >  fs/xfs/xfs_inode.c       |   2 +-
> >  include/linux/dax.h      |   6 +-
> >  include/linux/mm.h       |  27 +-----
> >  include/linux/mm_types.h |   7 +-
> >  mm/gup.c                 |   9 +--
> >  mm/huge_memory.c         |   6 +-
> >  mm/internal.h            |   2 +-
> >  mm/memory-failure.c      |   6 +-
> >  mm/memory.c              |   6 +-
> >  mm/memremap.c            |  47 ++++-----
> >  mm/mm_init.c             |   9 +--
> >  mm/swap.c                |   2 +-
> >  15 files changed, 183 insertions(+), 165 deletions(-)
> > 
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index d81faa9..785b2d2 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -513,7 +513,7 @@ static int pmem_attach_disk(struct device *dev,
> >  
> >  	pmem->disk = disk;
> >  	pmem->pgmap.owner = pmem;
> > -	pmem->pfn_flags = PFN_DEV;
> > +	pmem->pfn_flags = 0;
> >  	if (is_nd_pfn(dev)) {
> >  		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
> >  		pmem->pgmap.ops = &fsdax_pagemap_ops;
> > @@ -522,7 +522,6 @@ static int pmem_attach_disk(struct device *dev,
> >  		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
> >  		pmem->pfn_pad = resource_size(res) -
> >  			range_len(&pmem->pgmap.range);
> > -		pmem->pfn_flags |= PFN_MAP;
> >  		bb_range = pmem->pgmap.range;
> >  		bb_range.start += pmem->data_offset;
> >  	} else if (pmem_should_map_pages(dev)) {
> > @@ -532,7 +531,6 @@ static int pmem_attach_disk(struct device *dev,
> >  		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
> >  		pmem->pgmap.ops = &fsdax_pagemap_ops;
> >  		addr = devm_memremap_pages(dev, &pmem->pgmap);
> > -		pmem->pfn_flags |= PFN_MAP;
> >  		bb_range = pmem->pgmap.range;
> >  	} else {
> >  		addr = devm_memremap(dev, pmem->phys_addr,
> > diff --git a/fs/dax.c b/fs/dax.c
> > index d35dbe1..19f444e 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -71,6 +71,11 @@ static unsigned long dax_to_pfn(void *entry)
> >  	return xa_to_value(entry) >> DAX_SHIFT;
> >  }
> >  
> > +static struct folio *dax_to_folio(void *entry)
> > +{
> > +	return page_folio(pfn_to_page(dax_to_pfn(entry)));
> > +}
> > +
> >  static void *dax_make_entry(pfn_t pfn, unsigned long flags)
> >  {
> >  	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
> > @@ -338,44 +343,88 @@ static unsigned long dax_entry_size(void *entry)
> >  		return PAGE_SIZE;
> >  }
> >  
> > -static unsigned long dax_end_pfn(void *entry)
> > -{
> > -	return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
> > -}
> > -
> > -/*
> > - * Iterate through all mapped pfns represented by an entry, i.e. skip
> > - * 'empty' and 'zero' entries.
> > - */
> > -#define for_each_mapped_pfn(entry, pfn) \
> > -	for (pfn = dax_to_pfn(entry); \
> > -			pfn < dax_end_pfn(entry); pfn++)
> > -
> >  /*
> >   * A DAX page is considered shared if it has no mapping set and ->share (which
> >   * shares the ->index field) is non-zero. Note this may return false even if the
> >   * page is shared between multiple files but has not yet actually been mapped
> >   * into multiple address spaces.
> >   */
> > -static inline bool dax_page_is_shared(struct page *page)
> > +static inline bool dax_folio_is_shared(struct folio *folio)
> >  {
> > -	return !page->mapping && page->share;
> > +	return !folio->mapping && folio->share;
> >  }
> >  
> >  /*
> > - * Increase the page share refcount, warning if the page is not marked as shared.
> > + * Increase the folio share refcount, warning if the folio is not marked as shared.
> >   */
> > -static inline void dax_page_share_get(struct page *page)
> > +static inline void dax_folio_share_get(void *entry)
> >  {
> > -	WARN_ON_ONCE(!page->share);
> > -	WARN_ON_ONCE(page->mapping);
> > -	page->share++;
> > +	struct folio *folio = dax_to_folio(entry);
> > +
> > +	WARN_ON_ONCE(!folio->share);
> > +	WARN_ON_ONCE(folio->mapping);
> > +	WARN_ON_ONCE(dax_entry_order(entry) != folio_order(folio));
> > +	folio->share++;
> > +}
> > +
> > +static inline unsigned long dax_folio_share_put(struct folio *folio)
> > +{
> > +	unsigned long ref;
> > +
> > +	if (!dax_folio_is_shared(folio))
> > +		ref = 0;
> > +	else
> > +		ref = --folio->share;
> > +
> > +	WARN_ON_ONCE(ref < 0);
> > +	if (!ref) {
> > +		folio->mapping = NULL;
> > +		if (folio_order(folio)) {
> > +			struct dev_pagemap *pgmap = page_pgmap(&folio->page);
> > +			unsigned int order = folio_order(folio);
> > +			unsigned int i;
> > +
> > +			for (i = 0; i < (1UL << order); i++) {
> > +				struct page *page = folio_page(folio, i);
> > +
> > +				ClearPageHead(page);
> > +				clear_compound_head(page);
> > +
> > +				/*
> > +				 * Reset pgmap which was over-written by
> > +				 * prep_compound_page().
> > +				 */
> > +				page_folio(page)->pgmap = pgmap;
> > +
> > +				/* Make sure this isn't set to TAIL_MAPPING */
> > +				page->mapping = NULL;
> > +				page->share = 0;
> > +				WARN_ON_ONCE(page_ref_count(page));
> > +			}
> > +		}
> > +	}
> > +
> > +	return ref;
> >  }
> >  
> > -static inline unsigned long dax_page_share_put(struct page *page)
> > +static void dax_device_folio_init(void *entry)
> >  {
> > -	WARN_ON_ONCE(!page->share);
> > -	return --page->share;
> > +	struct folio *folio = dax_to_folio(entry);
> > +	int order = dax_entry_order(entry);
> > +
> > +	/*
> > +	 * Folio should have been split back to order-0 pages in
> > +	 * dax_folio_share_put() when they were removed from their
> > +	 * final mapping.
> > +	 */
> > +	WARN_ON_ONCE(folio_order(folio));
> > +
> > +	if (order > 0) {
> > +		prep_compound_page(&folio->page, order);
> > +		if (order > 1)
> > +			INIT_LIST_HEAD(&folio->_deferred_list);
> > +		WARN_ON_ONCE(folio_ref_count(folio));
> > +	}
> >  }
> >  
> >  /*
> > @@ -388,72 +437,58 @@ static inline unsigned long dax_page_share_put(struct page *page)
> >   * dax_holder_operations.
> >   */
> >  static void dax_associate_entry(void *entry, struct address_space *mapping,
> > -		struct vm_area_struct *vma, unsigned long address, bool shared)
> > +				struct vm_area_struct *vma, unsigned long address, bool shared)
> >  {
> > -	unsigned long size = dax_entry_size(entry), pfn, index;
> > -	int i = 0;
> > +	unsigned long size = dax_entry_size(entry), index;
> > +	struct folio *folio = dax_to_folio(entry);
> >  
> >  	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> >  		return;
> >  
> >  	index = linear_page_index(vma, address & ~(size - 1));
> > -	for_each_mapped_pfn(entry, pfn) {
> > -		struct page *page = pfn_to_page(pfn);
> > -
> > -		if (shared && page->mapping && page->share) {
> > -			if (page->mapping) {
> > -				page->mapping = NULL;
> > +	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
> > +		if (folio->mapping) {
> > +			folio->mapping = NULL;
> >  
> > -				/*
> > -				 * Page has already been mapped into one address
> > -				 * space so set the share count.
> > -				 */
> > -				page->share = 1;
> > -			}
> > -
> > -			dax_page_share_get(page);
> > -		} else {
> > -			WARN_ON_ONCE(page->mapping);
> > -			page->mapping = mapping;
> > -			page->index = index + i++;
> > +			/*
> > +			 * folio has already been mapped into one address
> > +			 * space so set the share count.
> > +			 */
> > +			folio->share = 1;
> >  		}
> > +
> > +		dax_folio_share_get(entry);
> > +	} else {
> > +		WARN_ON_ONCE(folio->mapping);
> > +		dax_device_folio_init(entry);
> > +		folio = dax_to_folio(entry);
> > +		folio->mapping = mapping;
> > +		folio->index = index;
> >  	}
> >  }
> >  
> >  static void dax_disassociate_entry(void *entry, struct address_space *mapping,
> > -		bool trunc)
> > +				bool trunc)
> >  {
> > -	unsigned long pfn;
> > +	struct folio *folio = dax_to_folio(entry);
> >  
> >  	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> >  		return;
> >  
> > -	for_each_mapped_pfn(entry, pfn) {
> > -		struct page *page = pfn_to_page(pfn);
> > -
> > -		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> > -		if (dax_page_is_shared(page)) {
> > -			/* keep the shared flag if this page is still shared */
> > -			if (dax_page_share_put(page) > 0)
> > -				continue;
> > -		} else
> > -			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> > -		page->mapping = NULL;
> > -		page->index = 0;
> > -	}
> > +	dax_folio_share_put(folio);
> >  }
> >  
> >  static struct page *dax_busy_page(void *entry)
> >  {
> > -	unsigned long pfn;
> > +	struct folio *folio = dax_to_folio(entry);
> >  
> > -	for_each_mapped_pfn(entry, pfn) {
> > -		struct page *page = pfn_to_page(pfn);
> > +	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
> > +		return NULL;
> >  
> > -		if (page_ref_count(page) > 1)
> > -			return page;
> > -	}
> > -	return NULL;
> > +	if (folio_ref_count(folio) - folio_mapcount(folio))
> > +		return &folio->page;
> > +	else
> > +		return NULL;
> >  }
> >  
> >  /**
> > @@ -786,7 +821,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
> >  EXPORT_SYMBOL_GPL(dax_layout_busy_page);
> >  
> >  static int __dax_invalidate_entry(struct address_space *mapping,
> > -					  pgoff_t index, bool trunc)
> > +				  pgoff_t index, bool trunc)
> >  {
> >  	XA_STATE(xas, &mapping->i_pages, index);
> >  	int ret = 0;
> > @@ -892,7 +927,7 @@ static int wait_page_idle(struct page *page,
> >  			void (cb)(struct inode *),
> >  			struct inode *inode)
> >  {
> > -	return ___wait_var_event(page, page_ref_count(page) == 1,
> > +	return ___wait_var_event(page, page_ref_count(page) == 0,
> >  				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> >  }
> >  
> > @@ -900,7 +935,7 @@ static void wait_page_idle_uninterruptible(struct page *page,
> >  					void (cb)(struct inode *),
> >  					struct inode *inode)
> >  {
> > -	___wait_var_event(page, page_ref_count(page) == 1,
> > +	___wait_var_event(page, page_ref_count(page) == 0,
> >  			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
> >  }
> >  
> > @@ -949,7 +984,8 @@ void dax_break_mapping_uninterruptible(struct inode *inode,
> >  		wait_page_idle_uninterruptible(page, cb, inode);
> >  	} while (true);
> >  
> > -	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
> > +	if (!page)
> > +		dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
> >  }
> >  EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
> >  
> > @@ -1035,8 +1071,10 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> >  		void *old;
> >  
> >  		dax_disassociate_entry(entry, mapping, false);
> > -		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
> > -				shared);
> > +		if (!(flags & DAX_ZERO_PAGE))
> > +			dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
> > +						shared);
> > +
> >  		/*
> >  		 * Only swap our new entry into the page cache if the current
> >  		 * entry is a zero page or an empty entry.  If a normal PTE or
> > @@ -1224,9 +1262,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
> >  		goto out;
> >  	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
> >  		goto out;
> > -	/* For larger pages we need devmap */
> > -	if (length > 1 && !pfn_t_devmap(*pfnp))
> > -		goto out;
> > +
> >  	rc = 0;
> >  
> >  out_check_addr:
> > @@ -1333,7 +1369,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> >  
> >  	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
> >  
> > -	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
> > +	ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), false);
> >  	trace_dax_load_hole(inode, vmf, ret);
> >  	return ret;
> >  }
> > @@ -1804,7 +1840,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
> >  	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
> >  	bool write = iter->flags & IOMAP_WRITE;
> >  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
> > -	int err = 0;
> > +	struct folio *folio;
> > +	int ret, err = 0;
> >  	pfn_t pfn;
> >  	void *kaddr;
> >  
> > @@ -1836,17 +1873,18 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
> >  			return dax_fault_return(err);
> >  	}
> >  
> > +	folio = dax_to_folio(*entry);
> >  	if (dax_fault_is_synchronous(iter, vmf->vma))
> >  		return dax_fault_synchronous_pfnp(pfnp, pfn);
> >  
> > -	/* insert PMD pfn */
> > +	folio_ref_inc(folio);
> >  	if (pmd)
> > -		return vmf_insert_pfn_pmd(vmf, pfn, write);
> > +		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)), write);
> > +	else
> > +		ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), write);
> > +	folio_put(folio);
> >  
> > -	/* insert PTE pfn */
> > -	if (write)
> > -		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
> > -	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> > +	return ret;
> >  }
> >  
> >  static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> > @@ -2085,6 +2123,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
> >  {
> >  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> >  	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
> > +	struct folio *folio;
> >  	void *entry;
> >  	vm_fault_t ret;
> >  
> > @@ -2102,14 +2141,17 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
> >  	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
> >  	dax_lock_entry(&xas, entry);
> >  	xas_unlock_irq(&xas);
> > +	folio = pfn_folio(pfn_t_to_pfn(pfn));
> > +	folio_ref_inc(folio);
> >  	if (order == 0)
> > -		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
> > +		ret = vmf_insert_page_mkwrite(vmf, &folio->page, true);
> >  #ifdef CONFIG_FS_DAX_PMD
> >  	else if (order == PMD_ORDER)
> > -		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
> > +		ret = vmf_insert_folio_pmd(vmf, folio, FAULT_FLAG_WRITE);
> >  #endif
> >  	else
> >  		ret = VM_FAULT_FALLBACK;
> > +	folio_put(folio);
> >  	dax_unlock_entry(&xas, entry);
> >  	trace_dax_insert_pfn_mkwrite(mapping->host, vmf, ret);
> >  	return ret;
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 82afe78..2c7b24c 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -1017,8 +1017,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> >  	if (kaddr)
> >  		*kaddr = fs->window_kaddr + offset;
> >  	if (pfn)
> > -		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
> > -					PFN_DEV | PFN_MAP);
> > +		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
> >  	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
> >  }
> >  
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index c7ec5ab..7bfb4eb 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -2740,7 +2740,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
> >  	 * for this nested lock case.
> >  	 */
> >  	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
> > -	if (page && page_ref_count(page) != 1) {
> > +	if (page && page_ref_count(page) != 0) {
> 
> You might want to wrap this weird detail for the next filesystem that
> uses it, so that the fine details of fsdax aren't opencoded in xfs:

Good idea. I will introduce this in patch 5 as dax_page_is_idle() and do this
change there. That way I can replace some of the other page_ref_count() checks
in the dax code as well.

 - Alistair

> 
> static inline bool dax_page_in_use(struct page *page)
> {
> 	return page && page_ref_count(page) != 0;
> }
> 
> 	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
> 	if (dax_page_in_use(page)) {
> 		/* unlock and retry... */
> 	}
> 
> --D
> 
> >  		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
> >  		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> >  		goto again;
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index 7c3773f..dbefea1 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -211,8 +211,12 @@ static inline int dax_wait_page_idle(struct page *page,
> >  				void (cb)(struct inode *),
> >  				struct inode *inode)
> >  {
> > -	return ___wait_var_event(page, page_ref_count(page) == 1,
> > +	int ret;
> > +
> > +	ret = ___wait_var_event(page, !page_ref_count(page),
> >  				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> > +
> > +	return ret;
> >  }
> >  
> >  #if IS_ENABLED(CONFIG_DAX)
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 01edca9..a734278 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1161,6 +1161,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
> >  struct mmu_gather;
> >  struct inode;
> >  
> > +extern void prep_compound_page(struct page *page, unsigned int order);
> > +
> >  /*
> >   * compound_order() can be called without holding a reference, which means
> >   * that niceties like page_folio() don't work.  These callers should be
> > @@ -1482,25 +1484,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
> >   *   back into memory.
> >   */
> >  
> > -#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
> > -DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
> > -
> > -bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
> > -static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
> > -{
> > -	if (!static_branch_unlikely(&devmap_managed_key))
> > -		return false;
> > -	if (!folio_is_zone_device(folio))
> > -		return false;
> > -	return __put_devmap_managed_folio_refs(folio, refs);
> > -}
> > -#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
> > -static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
> > -{
> > -	return false;
> > -}
> > -#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
> > -
> >  /* 127: arbitrary random number, small enough to assemble well */
> >  #define folio_ref_zero_or_close_to_overflow(folio) \
> >  	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
> > @@ -1615,12 +1598,6 @@ static inline void put_page(struct page *page)
> >  {
> >  	struct folio *folio = page_folio(page);
> >  
> > -	/*
> > -	 * For some devmap managed pages we need to catch refcount transition
> > -	 * from 2 to 1:
> > -	 */
> > -	if (put_devmap_managed_folio_refs(folio, 1))
> > -		return;
> >  	folio_put(folio);
> >  }
> >  
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 54b59b8..e308cb9 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -295,6 +295,8 @@ typedef struct {
> >   *    anonymous memory.
> >   * @index: Offset within the file, in units of pages.  For anonymous memory,
> >   *    this is the index from the beginning of the mmap.
> > + * @share: number of DAX mappings that reference this folio. See
> > + *    dax_associate_entry.
> >   * @private: Filesystem per-folio data (see folio_attach_private()).
> >   * @swap: Used for swp_entry_t if folio_test_swapcache().
> >   * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
> > @@ -344,7 +346,10 @@ struct folio {
> >  				struct dev_pagemap *pgmap;
> >  			};
> >  			struct address_space *mapping;
> > -			pgoff_t index;
> > +			union {
> > +				pgoff_t index;
> > +				unsigned long share;
> > +			};
> >  			union {
> >  				void *private;
> >  				swp_entry_t swap;
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 9b587b5..d6575ed 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -96,8 +96,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
> >  	 * belongs to this folio.
> >  	 */
> >  	if (unlikely(page_folio(page) != folio)) {
> > -		if (!put_devmap_managed_folio_refs(folio, refs))
> > -			folio_put_refs(folio, refs);
> > +		folio_put_refs(folio, refs);
> >  		goto retry;
> >  	}
> >  
> > @@ -116,8 +115,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
> >  			refs *= GUP_PIN_COUNTING_BIAS;
> >  	}
> >  
> > -	if (!put_devmap_managed_folio_refs(folio, refs))
> > -		folio_put_refs(folio, refs);
> > +	folio_put_refs(folio, refs);
> >  }
> >  
> >  /**
> > @@ -565,8 +563,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
> >  	 */
> >  	if (unlikely((flags & FOLL_LONGTERM) &&
> >  		     !folio_is_longterm_pinnable(folio))) {
> > -		if (!put_devmap_managed_folio_refs(folio, refs))
> > -			folio_put_refs(folio, refs);
> > +		folio_put_refs(folio, refs);
> >  		return NULL;
> >  	}
> >  
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d1ea76e..0cf1151 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2209,7 +2209,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >  						tlb->fullmm);
> >  	arch_check_zapped_pmd(vma, orig_pmd);
> >  	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> > -	if (vma_is_special_huge(vma)) {
> > +	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
> >  		if (arch_needs_pgtable_deposit())
> >  			zap_deposited_table(tlb->mm, pmd);
> >  		spin_unlock(ptl);
> > @@ -2853,13 +2853,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  		 */
> >  		if (arch_needs_pgtable_deposit())
> >  			zap_deposited_table(mm, pmd);
> > -		if (vma_is_special_huge(vma))
> > +		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
> >  			return;
> >  		if (unlikely(is_pmd_migration_entry(old_pmd))) {
> >  			swp_entry_t entry;
> >  
> >  			entry = pmd_to_swp_entry(old_pmd);
> >  			folio = pfn_swap_entry_folio(entry);
> > +		} else if (is_huge_zero_pmd(old_pmd)) {
> > +			return;
> >  		} else {
> >  			page = pmd_page(old_pmd);
> >  			folio = page_folio(page);
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 3922788..c4df0ad 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -733,8 +733,6 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
> >  	set_page_private(p, 0);
> >  }
> >  
> > -extern void prep_compound_page(struct page *page, unsigned int order);
> > -
> >  void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
> >  extern bool free_pages_prepare(struct page *page, unsigned int order);
> >  
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index a7b8ccd..7838bf1 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -419,18 +419,18 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
> >  	pud = pud_offset(p4d, address);
> >  	if (!pud_present(*pud))
> >  		return 0;
> > -	if (pud_devmap(*pud))
> > +	if (pud_trans_huge(*pud))
> >  		return PUD_SHIFT;
> >  	pmd = pmd_offset(pud, address);
> >  	if (!pmd_present(*pmd))
> >  		return 0;
> > -	if (pmd_devmap(*pmd))
> > +	if (pmd_trans_huge(*pmd))
> >  		return PMD_SHIFT;
> >  	pte = pte_offset_map(pmd, address);
> >  	if (!pte)
> >  		return 0;
> >  	ptent = ptep_get(pte);
> > -	if (pte_present(ptent) && pte_devmap(ptent))
> > +	if (pte_present(ptent))
> >  		ret = PAGE_SHIFT;
> >  	pte_unmap(pte);
> >  	return ret;
> > diff --git a/mm/memory.c b/mm/memory.c
> > index c60b819..02e12b0 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3843,13 +3843,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >  	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
> >  		/*
> >  		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
> > -		 * VM_PFNMAP VMA.
> > +		 * VM_PFNMAP VMA. FS DAX also wants ops->pfn_mkwrite called.
> >  		 *
> >  		 * We should not cow pages in a shared writeable mapping.
> >  		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
> >  		 */
> > -		if (!vmf->page)
> > +		if (!vmf->page || is_fsdax_page(vmf->page)) {
> > +			vmf->page = NULL;
> >  			return wp_pfn_shared(vmf);
> > +		}
> >  		return wp_page_shared(vmf, folio);
> >  	}
> >  
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index 68099af..9a8879b 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -458,8 +458,13 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
> >  
> >  void free_zone_device_folio(struct folio *folio)
> >  {
> > -	if (WARN_ON_ONCE(!folio->pgmap->ops ||
> > -			!folio->pgmap->ops->page_free))
> > +	struct dev_pagemap *pgmap = folio->pgmap;
> > +
> > +	if (WARN_ON_ONCE(!pgmap->ops))
> > +		return;
> > +
> > +	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
> > +			 !pgmap->ops->page_free))
> >  		return;
> >  
> >  	mem_cgroup_uncharge(folio);
> > @@ -484,26 +489,36 @@ void free_zone_device_folio(struct folio *folio)
> >  	 * For other types of ZONE_DEVICE pages, migration is either
> >  	 * handled differently or not done at all, so there is no need
> >  	 * to clear folio->mapping.
> > +	 *
> > +	 * FS DAX pages clear the mapping when the folio->share count hits
> > +	 * zero which indicating the page has been removed from the file
> > +	 * system mapping.
> >  	 */
> > -	folio->mapping = NULL;
> > -	folio->pgmap->ops->page_free(folio_page(folio, 0));
> > +	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
> > +		folio->mapping = NULL;
> >  
> > -	switch (folio->pgmap->type) {
> > +	switch (pgmap->type) {
> >  	case MEMORY_DEVICE_PRIVATE:
> >  	case MEMORY_DEVICE_COHERENT:
> > -		put_dev_pagemap(folio->pgmap);
> > +		pgmap->ops->page_free(folio_page(folio, 0));
> > +		put_dev_pagemap(pgmap);
> >  		break;
> >  
> > -	case MEMORY_DEVICE_FS_DAX:
> >  	case MEMORY_DEVICE_GENERIC:
> >  		/*
> >  		 * Reset the refcount to 1 to prepare for handing out the page
> >  		 * again.
> >  		 */
> > +		pgmap->ops->page_free(folio_page(folio, 0));
> >  		folio_set_count(folio, 1);
> >  		break;
> >  
> > +	case MEMORY_DEVICE_FS_DAX:
> > +		wake_up_var(&folio->page);
> > +		break;
> > +
> >  	case MEMORY_DEVICE_PCI_P2PDMA:
> > +		pgmap->ops->page_free(folio_page(folio, 0));
> >  		break;
> >  	}
> >  }
> > @@ -519,21 +534,3 @@ void zone_device_page_init(struct page *page)
> >  	lock_page(page);
> >  }
> >  EXPORT_SYMBOL_GPL(zone_device_page_init);
> > -
> > -#ifdef CONFIG_FS_DAX
> > -bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
> > -{
> > -	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
> > -		return false;
> > -
> > -	/*
> > -	 * fsdax page refcounts are 1-based, rather than 0-based: if
> > -	 * refcount is 1, then the page is free and the refcount is
> > -	 * stable because nobody holds a reference on the page.
> > -	 */
> > -	if (folio_ref_sub_return(folio, refs) == 1)
> > -		wake_up_var(&folio->_refcount);
> > -	return true;
> > -}
> > -EXPORT_SYMBOL(__put_devmap_managed_folio_refs);
> > -#endif /* CONFIG_FS_DAX */
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index cb73402..0c12b29 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1017,23 +1017,22 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> >  	}
> >  
> >  	/*
> > -	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
> > -	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
> > -	 * allocator which will set the page count to 1 when allocating the
> > -	 * page.
> > +	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
> > +	 * directly to the driver page allocator which will set the page count
> > +	 * to 1 when allocating the page.
> >  	 *
> >  	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
> >  	 * their refcount reset to one whenever they are freed (ie. after
> >  	 * their refcount drops to 0).
> >  	 */
> >  	switch (pgmap->type) {
> > +	case MEMORY_DEVICE_FS_DAX:
> >  	case MEMORY_DEVICE_PRIVATE:
> >  	case MEMORY_DEVICE_COHERENT:
> >  	case MEMORY_DEVICE_PCI_P2PDMA:
> >  		set_page_count(page, 0);
> >  		break;
> >  
> > -	case MEMORY_DEVICE_FS_DAX:
> >  	case MEMORY_DEVICE_GENERIC:
> >  		break;
> >  	}
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 062c856..a587842 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -952,8 +952,6 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
> >  				unlock_page_lruvec_irqrestore(lruvec, flags);
> >  				lruvec = NULL;
> >  			}
> > -			if (put_devmap_managed_folio_refs(folio, nr_refs))
> > -				continue;
> >  			if (folio_ref_sub_and_test(folio, nr_refs))
> >  				free_zone_device_folio(folio);
> >  			continue;
> > -- 
> > git-series 0.9.1
> > 

