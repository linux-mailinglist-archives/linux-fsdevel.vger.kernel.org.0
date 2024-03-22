Return-Path: <linux-fsdevel+bounces-15060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29113886735
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 07:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A2F287CD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2B112E5C;
	Fri, 22 Mar 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVpmIKv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C81125CF
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090740; cv=fail; b=ql62JRHIKHYwGGw1WRUlOqDvT0XVFCMN4zVk7cCZxDq1wfSw5B6jebph4QytPL+VXlNvYXiB6oD+HsrF3t4GwOEsTPIFRgs1dLNo2Rl9UMVJAqVFZBtCH+CHRLS7tvmRIHmHQQzsbwR0Y6dOIe5uWkRMomaW2ocxUnSw0V4iu4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090740; c=relaxed/simple;
	bh=jAZjT/HumXKuapckTTkeX4/cXJpJpcXRYkp6zv6q6Rs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u7cwTXybhjaS+ceYC6QWq6/kVQK9FC0IS/yFek0p/0MooqsoF2dsBcwVsy9L+ALLLpq7MKuca0lKU9hmwRubhLxry+q+kEZx9ZvVXJTMJzC8lZnVEq3nPH+4Q6PRhRb+n79xO1uCfKyY6tWKpLEGiKaYTCKp0uJloEmKQoXps04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVpmIKv/; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711090738; x=1742626738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jAZjT/HumXKuapckTTkeX4/cXJpJpcXRYkp6zv6q6Rs=;
  b=GVpmIKv/Ffoz6VOAF057lXDuqSD7HGWpnv2mVL+8+7THgaUvB/5AsZgF
   b3vOE1Ce9CnH7GjqfswR81jwmZQXSSYs/hR1Xa5SzrmAhwoxWeXkGvQld
   ZZVFaoPSvZ/sFGWHM2nQqzzObqlygg9/rGQzWhO8xvyw6W9MDUpbVQQ0Y
   9Ox6SJcNgbZ1wHBgcwIA/uLICKDcCBQXfnS2kNnqMpf0BgQ1p4KBHKq51
   3mGZ9Oz5TLw/zaGx08pg+xuZ725RyHooEmFrto4fOAb2r3J79ftUyJQg+
   QwUL+TAy7m7bm0IEuf1CEEvGgakK75v0rNslGrMWzfJdezPjGL5vbzliA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9911660"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="9911660"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 23:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="14818256"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 23:58:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 23:58:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 23:58:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 23:58:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZyHdD716EENkCM+sHAln9XRQ7uc+CHCXJcZJMJF0HBJfqofsUss1l6TC4G9kQuALYSyErwkbl4jZDu7qowcbC7Av1wBgDON++lzsbwbBh6Ws3rGrlJ6I7pIrEMZ3w22TYgLF+72iYVFzOvjWJ4l6TvkMIyHXDY1deCl/9Jsstkxuqzg5QZBp8VI3E3kfYRj+nd/1n+GgqK/cYoF2Hu80gl8d1YTdGEIK8pNaKQaKB75YGYm2Y71/izwQlXdYZ1yhmuapp3QP37WRbrzVVNmQkZ9IPWGy4SCV7LoNbn+UxzTr1+dou37UVvK2sV39jQxImSC34JQnB2SCxyk9VizHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHUPaNGlHgbEDo/T11TyGa+S3oLPQlox7PURkefpRLA=;
 b=fC9ge9wQGq/z3tz/GGTMhfNP+DcImvTxCHI3YYamg1uj2IX76VaDnQvT4KBzo9IuK6e1sXVwT2CBe6uc62AzZOClaMrBfhdevA429oqWmrtUOxzfLjwO3OoEtWAf254+Qe2lsctO9aUpd9qbbKK635aM1m23EMYAgNdYFNKKcCroVZ4/viRfagbwYqNNqZvyPzpimakJX8d4bRYz0s/bEzFheuD0XZVnBO2/j2hyqLq45EHXnyjjFYaaIpb4YGr+Wqsq3GUyNMjLwh+IU+RTnEnNeQNVHsp9+QByozus15umo4GKJHZf+AV4QhX07LUElarzTUEHpejzRbfCdfgH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7534.namprd11.prod.outlook.com (2603:10b6:806:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Fri, 22 Mar
 2024 06:58:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 06:58:47 +0000
Date: Thu, 21 Mar 2024 23:58:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, Dave Chinner <david@fromorbit.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
	<jhubbard@nvidia.com>, <rcampbell@nvidia.com>, <willy@infradead.org>,
	<jgg@nvidia.com>, <linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<djwong@kernel.org>, <hch@lst.de>, <david@redhat.com>,
	<ruansy.fnst@fujitsu.com>
Subject: Re: ZONE_DEVICE refcounting
Message-ID: <65fd2c2448dbf_2690d294fe@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <87ttlhmj9p.fsf@nvdebian.thelocal>
 <65f148866bc56_a9b42947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87y1ad776c.fsf@nvdebian.thelocal>
 <878r2c6t99.fsf@nvdebian.thelocal>
 <65fbcdaf2042f_aa222948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <874jcz6ryu.fsf@nvdebian.thelocal>
 <Zfz4dT+YWpx5OYxM@dread.disaster.area>
 <87v85e6cj2.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v85e6cj2.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb8feae-6fce-4c64-6eef-08dc4a3d8537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCNMwxhe5Yu/QJzmKt9Pp7UZjB+8iLrNHKc6b+yaM+8m5++amzjfPIAuHrjAhboGvqeFdPTVV2gs1vCQtTH39SkmuNT0XQD+7lwOdKW7waUuzHF1sJMYyK4mM3LpkSjVxiPs05Luh5RffhbW3lZ6eOy1UxUky+kS2poH4YD2LNfXiRfD/E4R+0CxyerKZ3JL1fbOeP55w92IOykEj0Tg8yrOXsDS4CYG9+zaR0nDE+E6z2DMfzDd3+3XW8CDIib7db/N9qvtw3p22dmlU9AxEe7nqW8YCjOL351FbRZHLayHZXTyvJIZ822cbcxccSCMW06dku/jjow1uWlqXRFxzdB2v/0eil4XwCOduV4sTTbFg9Z/4ODqk5T5p8VOWRd+eXr1kN49AZR8IRlHBKArRmOfBw3ikuMvxQclqtD8DW1sx6LmGTUQdcIfkh2ZdRg94VfYQOuc5NMfTMDIN5uxMNIdY+HwSLk/T6KkczTY5lAfdWrI0SWwePoCH70ex+MLfodLFPYd4iFDws8BssUhZq8cS2Zg60QuKNayjAqTjkpZxVsSZZPJEFyOUA/000Fl7NsUKfpSKWF27WK7H5unp2mfDm5iVV7SvTcVVDrBoprar6Tf+rqf2TdcS5G11O9t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wbajzIw+9xZnxks6FaRCHq7VmAVm+zmKp4KwGi/F5bOCVscFVnPPVGphvKKy?=
 =?us-ascii?Q?g1E4v6Zv99aAUlOQP7asyr/6q4190nezQITjt3v7afiXI7wzfruk7DYFT/2F?=
 =?us-ascii?Q?9uUqxYObYu6afF5Sa1L7Qbzd8PKC66BLB+jiY3bxnYSTFiFZvhUqibpM8w/4?=
 =?us-ascii?Q?Mp7zY/dmBUYezvH6X1415nL1xoCGVg2D0U6gAq+te/cTudnzPPnRuAGwM4F7?=
 =?us-ascii?Q?2Aapo60TlL/uzsPNNbIdFHdty17ltL/zxJQno2RyeWMhVkyDpcSOuPII8aMI?=
 =?us-ascii?Q?Xjd5Vq9xGD2giXFs/RLQq1BKcebCtM/sq0eihqYCAVOAADnhWvDS7BoN/OWp?=
 =?us-ascii?Q?ZZwAz6ZLXIlg/orzOeGYKbQcs9pwa/xXt4TCSQ2Viv5wH2wlwtM8fYK9K9B9?=
 =?us-ascii?Q?Dn73Dk/6gvaVHZhZ7EwUN5gYno/dwOXf7p4cFl5bw6ZGEtgwT8Qr0Wd+4/sy?=
 =?us-ascii?Q?AZAN/SSz/rvDjF9yMmKKG8b6IbZVxjhPNCm9s3EBU7V4DTqct6hOraSA7hdv?=
 =?us-ascii?Q?Y/j2PlkWK8a6EmEnmDSpDHWbLgAmUIZxQClj75jL7kGl+v/4Dukas9ajA0BG?=
 =?us-ascii?Q?JVDSpyaQW2Zf4pr/Tu/ZsYLe+W7pEfSVFtxSIa04vjd22ZdIbIGlW37HffM2?=
 =?us-ascii?Q?RShHMc/PjVzGWW8+iFgkfTS9qxkDxpntV28M1rTQyFTUxmcUUa2Uj4jwuFkm?=
 =?us-ascii?Q?Tzgq0vDIZIyjnj6shX2KYTEoeJoeibGBTZLvb5zFcQsVFOhho7kbTkIIjzS7?=
 =?us-ascii?Q?F3h+SDxz3fltKr1AGri18nFKCMBIFPOxHciEvx4jTaChIDTr09/W8ZQArPX9?=
 =?us-ascii?Q?/wZSZoa1e31dqcvdYUmAS+D9M610rdxr5La14/Qk/NZhJQOUSkq0mRZs9oMM?=
 =?us-ascii?Q?ULON2va6zVHpBhqA2Rk421RjD6sIEun5xZXPdTmcoW6Wu5l4yNMBruH3QTW0?=
 =?us-ascii?Q?kb65wxlAQwo4vX4EGcAcjkvgSlYOXYW6K92WWs35fDQleHEy8xe+UdW1ukDz?=
 =?us-ascii?Q?vDwYhpahzni8olUZDjui7M3XN6Z2r3r80nY/uufTvXKluDZpHKO3xsWZdFvJ?=
 =?us-ascii?Q?uS/UMgzfC9rAT5dVQlvN7J508KFJ3NNp8OZICn35nqLtzZSx4Ew/V/R5T8u6?=
 =?us-ascii?Q?D1GB3QavuiinHMGgq4D8+ufOsQnRsp9R5Sxs/WlHMLElGvJ7NhRrvPmsha9S?=
 =?us-ascii?Q?96f37mudw9E9lQSJiBgr6I23H24VVTljlGrE37uPVRLeD9SmVj1e3t4y/Isx?=
 =?us-ascii?Q?mTG6gb2dEfKoS4fstXbYgbNV4P+JdmRmvQeyzXlZdKl67xJJ9zCxlu5p2Z8n?=
 =?us-ascii?Q?hihHq2i1NSCHzpOJENaRkHmUsO3NwU2ifAXbf/mV7K0PjSnSYo1VI45xSoAL?=
 =?us-ascii?Q?OvWI3B1UA34cadvpEmQOOb5uX1vMMNqvlu1Oj6cl/zJIEV116csQ+vONDepZ?=
 =?us-ascii?Q?hSoG0UqxE2Dx/xwS0H75swIRXSuBHMvXn3QwLgGt8mqhWN+3y3MP0XtZ2D0v?=
 =?us-ascii?Q?XHuQao9b51VXPg7qn9F4GHkw/KTPZXwZx1T+yniY2XsLZXtRaVjC8hUI43jG?=
 =?us-ascii?Q?zkPi7BdDyY6CApYzI337fYZPydckBjhWYXROga0UbbsGyIKE+zdkureHT14D?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb8feae-6fce-4c64-6eef-08dc4a3d8537
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:58:46.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o030o8SjnToLQ0ulBWilgiSbWoyFNE4P4akGJ1Kvs1fvY7UgFSl/DI2M2YMpYR5t9fAgZPTT0/adV2bjPRfoYr0/vk4w/9gUNBkmahTvcAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7534
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> 
> Dave Chinner <david@fromorbit.com> writes:
> 
> > On Fri, Mar 22, 2024 at 11:01:25AM +1100, Alistair Popple wrote:
> >> 
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >> 
> >> > Alistair Popple wrote:
> >> >> 
> >> >> Alistair Popple <apopple@nvidia.com> writes:
> >> >> 
> >> >> > Dan Williams <dan.j.williams@intel.com> writes:
> >> >> >
> >> >> >> Alistair Popple wrote:
> >> >> >
> >> >> > I also noticed folio_anon() is not safe to call on a FS DAX page due to
> >> >> > sharing PAGE_MAPPING_DAX_SHARED.
> >> >> 
> >> >> Also it feels like I could be missing something here. AFAICT the
> >> >> page->mapping and page->index fields can't actually be used outside of
> >> >> fs/dax because they are overloaded for the shared case. Therefore
> >> >> setting/clearing them could be skipped and the only reason for doing so
> >> >> is so dax_associate_entry()/dax_disassociate_entry() can generate
> >> >> warnings which should never occur anyway. So all that code is
> >> >> functionally unnecessary.
> >> >
> >> > What do you mean outside of fs/dax, do you literally mean outside of
> >> > fs/dax.c, or the devdax case (i.e. dax without fs-entanglements)?
> >> 
> >> Only the cases fs dax pages might need it. ie. Not devdax which I
> >> haven't looked at closely yet.
> >> 
> >> > Memory
> >> > failure needs ->mapping and ->index to rmap dax pages. See
> >> > mm/memory-failure.c::__add_to_kill() and
> >> > mm/memory-failure.c::__add_to_kill_fsdax() where that latter one is for
> >> > cases where the fs needs has signed up to react to dax page failure.
> >> 
> >> How does that work for reflink/shared pages which overwrite
> >> page->mapping and page->index?
> >
> > Via reverse mapping in the *filesystem*, not the mm rmap stuff.
> >
> > pmem_pagemap_memory_failure()
> >   dax_holder_notify_failure()
> >     .notify_failure()
> >       xfs_dax_notify_failure()
> >         xfs_dax_notify_ddev_failure()
> > 	  xfs_rmap_query_range(xfs_dax_failure_fn)
> > 	     xfs_dax_failure_fn(rmap record)
> > 	       <grabs inode from cache>
> > 	       <converts range to file offset>
> > 	       mf_dax_kill_procs(inode->mapping, pgoff)
> > 	         collect_procs_fsdax(mapping, page)
> > 		   add_to_kill_fsdax(task)
> > 		     __add_to_kill(task)
> > 		 unmap_and_kill_tasks()
> >
> > Remember: in FSDAX, the pages are the storage media physically owned
> > by the filesystem, not the mm subsystem. Hence answering questions
> > like "who owns this page" can only be answered correctly by asking
> > the filesystem.
> 
> Thanks Dave for writing that up, it really helped solidify my
> understanding of how this is all supposed to work.

Yes, thanks Dave!

> > We shortcut that for pages that only have one owner - we just store
> > the owner information in the page as a {mapping, offset} tuple. But
> > when we have multiple owners, the only way to find all the {mapping,
> > offset} tuples is to ask the filesystem to find all the owners of
> > that page.
> >
> > Hence the special case values for page->mapping/page->index for
> > pages over shared filesystem extents. These shared extents are
> > communicated to the fsdax layer via the IOMAP_F_SHARED flag
> > in the iomaps returned by the filesystem. This flag is the trigger
> > for the special mapping share count behaviour to be used. e.g. see
> > dax_insert_entry(iomap_iter) -> dax_associate_entry(shared) ->
> > dax_page_share_get()....
> >
> >> Eg. in __add_to_kill() if *p is a shared fs
> >> dax page then p->mapping == PAGE_MAPPING_DAX_SHARED and
> >> page_address_in_vma(vma, p) will probably crash.
> >
> > As per above, we don't get the mapping from the page in those cases.
> 
> Yep, that all makes sense and I see where I was getting confsued. It was
> because in __add_to_kill() we do actually use page->mapping when
> page_address_in_vma(vma, p) is called. And because
> folio_test_anon(page_folio(p)) is also true for shared FS DAX pages
> (p->mapping == PAGE_MAPPING_DAX_SHARED/PAGE_MAPPING_DAX_SHARED) I
> thought things would go bad there.
> 
> However after re-reading the page_address_in_vma() implementation I
> noticed that isn't the case, because folio_anon_vma(page_folio(p)) will
> still return NULL which was the detail I had missed.
> 
> So to go back to my original point it seems page->mapping and
> page->index is largely unused on fs dax pages, even for memory
> failure. Because for memory failure the mapping and fsdax_pgoff comes
> from the filesystem not the page.

Only for XFS, all other filesystems depend on typical rmap, and I
believe XFS only uses that path if the fs is mounted with reflink
support.

You had asked about tests before and I do have a regression test for
memory-failure in the ndctl regression suite, that should be validating
this for xfs, and ext4:

https://github.com/pmem/ndctl/blob/main/test/dax-poison.c#L47

meson test -C build --suite ndctl:ndctl

There are setup instructions here:
https://github.com/pmem/ndctl/blob/main/README.md

I typically run it in its own VM. This run_qemu script can build and
boot an enironment to run it:
https://github.com/pmem/run_qemu

There is also kdevops that includes it, but I have not tried that:
https://github.com/linux-kdevops/kdevops

