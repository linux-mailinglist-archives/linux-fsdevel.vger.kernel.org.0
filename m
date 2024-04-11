Return-Path: <linux-fsdevel+bounces-16729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C3B8A1E2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D4528C3AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E422B78C7B;
	Thu, 11 Apr 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U893PnnU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30202E648;
	Thu, 11 Apr 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858217; cv=fail; b=m3pm7/8+yEcleN6gQxdr5C786CzXNhuLv89F5kClpRom7mLnRhAjH7jKIpp+9gJu7O6YngYwroOpfpw5FzDDYnZBLZJ0cRgK37gPm0AVpd1kfQEXvVo7wgAoMxNqS+EMVqlu/58bGOiJzUffDNgzGl29EILW0DKiZ9AvFLKqWq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858217; c=relaxed/simple;
	bh=uzk1FieAvwi9vb7he0i9eNOgrDdkd+pII3dwzAqyNPo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dygQY1eWkHh+qSXsSgtrMrWs5TMhx/bsRwPbd0gu8JDmKrYG7XW5FvonvIZBi+R9GWHROboJ94dNme1vJqdJCDqUp0auh8RUBfw0k3eOqhpBqoouKxiUwbrOz+9qJ97L8KNf/r8FVEpyZWu7q8CFI2bT/M2u61ZtYD8Uy8eTF+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U893PnnU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712858213; x=1744394213;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uzk1FieAvwi9vb7he0i9eNOgrDdkd+pII3dwzAqyNPo=;
  b=U893PnnUvKxtEbWrogz6p1ypfTKzcbnmpjoioVnyd/MoZOq5dRAbJAZQ
   mz9BBF5QMIPD6zmED5SHU8fM4Kd59LfN1ZY4J0kGCNvWTDYfyi0BOBwYt
   vzclyaifEJOs9BYbgNAsgXzGgsKrJ8FZT+jrceT+M5zi+DLD+6iuYPZh0
   Xy/YyE6KXEz+nH8QzHvx8citpZYNwyx7+vLx5M/mO263WSrnQcv3j1Eed
   32vqdzzyun8wjlO8rRhySbTZeteo/Z5hroGb2Eyof59L3H2sltsbJFW8f
   UeCS/yTyh1lmiS5nF00wls5kuV+f9dzzQjdFXN9Gh2xQmziLfEBHMzQmt
   w==;
X-CSE-ConnectionGUID: /0zTOomNTF6KPi2uCrpZrQ==
X-CSE-MsgGUID: vCXAAcgXS5Catp0Nj1rfcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19441598"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="19441598"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:56:44 -0700
X-CSE-ConnectionGUID: NRZbYzJyRnSicFSVDmXjqA==
X-CSE-MsgGUID: bOTIQ/xvR5mF6NK5FFhLYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="52156332"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:56:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:56:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:56:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:56:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkHqMd1efC63XhI7DrTEEVA8FMv39v9kws8NMryP0+AB2ZpLhVgOQcEuXDy1rWAuCchwBbsonoFGG1skAwU7jstgotImLyYiLd4bxf6BSX8yJoLW/qquiUtHCvjldIPi0TyjvdQtxCJOIq7DwhWeACwiv6QiLo6pzrPZGuSe0c/sCciY0yOXGjh/a7Zdj1BoWytUGqKNUFLkNZYIiy4z2T4vIbHMkCrVkb114ziT5UbLOJTG2g1A2gToSIT4IHZmJ32c8S11wXT3d72ZUz2EpwyoB9T2vlXm2qk4x2HzpsOZbn3ZAb0pWfhchvLnpZliRSxj1ID5isDTxs/sPaWFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkLPx0zBtSiPkuXvhIjbiYebQa1tMKCwrm56LOzFBks=;
 b=HygX/G8L35VItzZJgey/zMmG/HhKlrbdpKVRJpu6HAp6WmPmEvHpVIqWo3mAHSYxhnQXwnY4HwHSFvFRJTJikg5ati6MVpe+7AtLkieu6jr29ESDFc7iN9J6qiHHjf2hqPvp6szN/JgwESz0G88PeDU3h65JI5luyDjbBv4X2B6rEQwRRNLKSpYNEv4kSoHHFAHChbs8fClOEbKEbTSAfbzEbyGYJcaa8EkxZxv0o04+x3jUwzDvvPCAH9h3bZPyosliDhE88vdzrHzz5WToHqVQL/o/lzrGNvT6INojGlkGOmND3Ew5KFFJUBe2Hj1nCfz8ie0oGqH4uNIKZPNZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6719.namprd11.prod.outlook.com (2603:10b6:a03:478::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 11 Apr
 2024 17:56:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Thu, 11 Apr 2024
 17:56:38 +0000
Date: Thu, 11 Apr 2024 10:56:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<david@fromorbit.com>, <jhubbard@nvidia.com>, <rcampbell@nvidia.com>,
	<willy@infradead.org>, <linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<djwong@kernel.org>, <hch@lst.de>, <david@redhat.com>,
	<ruansy.fnst@fujitsu.com>, <nvdimm@lists.linux.dev>,
	<linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<jglisse@redhat.com>
Subject: Re: [RFC 00/10] fs/dax: Fix FS DAX page reference counts
Message-ID: <66182453df757_15786294f5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <66181dd83f74e_15786294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240411173559.GX5383@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240411173559.GX5383@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: daf3e89a-4da3-4ec0-985d-08dc5a50bc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIcB8VAw9isuHSi0Ve3ViNTMSBh0TDWDSCtHkknlfECWW27kbPHN4X4CzzoA9PeOFP1PM2xD/v2LV7VNissjc4zs6dJywEcCZoSnZrBH8M015MiV8K7DfwtFgMw56+J5WxaxKmSSXKouaqdN9zd+0icmki4z+xbZ2tlWIyG+yDrsOb7CGgOHa0+uqRh+nKZVc2cHp6IaUx/37RCmMjalqH95C2LldkFSJbmtCxIGSzuA4HVMiQhMD/X48FzC+qfIqNhp2JIU5Ev5adTnWkG+2xqiZOnvlxOnpVW6m9ymvnMNtOc3/F8YxJgnEydJk6Av99d9c3sJ6VnQa6RgmOTOePlFFkp8cM/hcEZC726LdfWLeUOyxbuv9RwpD1M3CzgFZm5HNKbq7WA6P6yTYtpZnXQmPgA1kV1na70exeOen3TghxR0R3RMe8qhXRqBPL0z5jXKOQaeA7czmGJVJJuprf0MJpicPDm9Bk9Y+dAjtXTJa7Jc4aUGmWnLiTHuzlTxUAaXwH+L5lSGls6gjy8gcCr0Kvoyn04zFJl0YOAX2eDgbEDwH/kJ/lyZ0opPZ1bhiMOD2l40oRh/7WLyvz9IChuasrFji3HWYjpW6iKtR9NMEbtgj2wU80lMZC0OzAC1kpf26CerbvjeBU8b4p1K0uZzez2wUnWouhec3bR19W4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZLP3UoZ6+Ro82jeN+mpOjgFMEl3J/PFaTkFia/jJFa1LA2htcFVZrHIyQxet?=
 =?us-ascii?Q?zoSGD5+G8e5CtQOOW9FiYRLplmPR7XdjKDljaCOzwouRx0dTWvrzlUscYkUQ?=
 =?us-ascii?Q?mhXhnDdby6L3CBWRwbeOeMhZ4pCFh3tgntURyXEFzWNskj7VeQVqaZ1rA3ni?=
 =?us-ascii?Q?xx4NZwBzufbA4Zrmye/nBiwYlH4p2UgroSNFhdkbtM/lzs54ZcFRcspxR780?=
 =?us-ascii?Q?FObePwh68hDhXNRukpMbSHDYxGgfJtCODg+bkUEIh/FU0UZ1hHoYEreAMXAG?=
 =?us-ascii?Q?JXTStOLZ53gIJz6joasQ2BY4w+egDMOQAq58erlxrOppM+AXGmJlwK8BsTjd?=
 =?us-ascii?Q?KmMSqKFPR1T8vlgjl6MooFCfN28eWeDxntk/4dLfS9tTCnhgKrVaxSuij1an?=
 =?us-ascii?Q?9zzSnHQRzggnwx8S3FPOKIIdOLKHQmObZOZ3weLsrtkXwj1g77bHBGPbaTEY?=
 =?us-ascii?Q?pg5+KmLM1RxYZkL3jLE5ofIOMLgAZWiUVC1qrzmbNo9r49gGSZTBy0f9n2cs?=
 =?us-ascii?Q?0Q6+kwSZeAV37sagxfbh25Qz8zJNq75viE/0taNz2VdSNMo1EtY1Z6sbQvhE?=
 =?us-ascii?Q?DCQNKJPN8gwOE7/2Shq1bdI0J/iH8c12DSk8gDrOzTBe3OSjabluJfZVhmOu?=
 =?us-ascii?Q?rnMnZcGQ0pk7xp0B6585UNDWX2UCWZEDi/AnvA/L+CqD3WWqNSeTr8fOIoDj?=
 =?us-ascii?Q?84HzUOsx9wUq8rUYfnNJXwtrkrb/MwzNC9DZeNzeg6ujrF6WhIhOaaQvvuQI?=
 =?us-ascii?Q?NKFx5QfBDEe12maiDMiqNr/PqNH+RTO3RKxrTf78NtxgSeF0uNj0roSKEjhC?=
 =?us-ascii?Q?vIAYkDNc/p05RigqJmbFsxukrZRUXjSsbevgsxNo3l5UTGp7cnxMsaO19GzK?=
 =?us-ascii?Q?2ZbJXSX4VILwz2LV0jZUYyyprVfWA5ABupaqdDWr8rewH16iXc10BG7hTjdw?=
 =?us-ascii?Q?AClPkcOxe3H3JhZJ0um7yGpRCWkvUUEbEjvxfkeygkqMaXAgRFcWhblRSXK5?=
 =?us-ascii?Q?j7z7rp5CAob2ZPHcWu5OQcvtRnsvHYnjEUnfQ92/AOfLNfYnMUzHIG/mtxwG?=
 =?us-ascii?Q?rfF+IR41OL5CHtCOGPdAlHWpn/H6Ehq4JQdXUiIOQl31+DeZsyKeksRiAyzd?=
 =?us-ascii?Q?LpK2YY3Lf0Iqd3fcmRgGNaz/j7gT62G+/IL2tuxHxyGSLRBZATu8OdCTu2fM?=
 =?us-ascii?Q?Fr/t4+aRfESVThckHriwUKggsy4bQGFvoJi6OmNgXTW9eM2w4XXejnEU23mO?=
 =?us-ascii?Q?DfugB+CChsGsgKNCiqQ5qXbOTndx/kp80umWyXSy9ocNxItcNh/wwcLMiKvf?=
 =?us-ascii?Q?zCXP6BFgCvQeXd1axCbMTmSRsM/qruP2HQ25yMJAGG6r7q5Y4z/0M3R/F8Pm?=
 =?us-ascii?Q?9c0hfjuCQwBuCgoAfdxbCxKPYL8kvjFpxFJvCMg6HjUu4dXaEzUPhxd5SKSA?=
 =?us-ascii?Q?hFsaZ9Tik5STiEHXUV6SRZ6MqYxrZKRYinyxVC9lFY2AVxkoNKEiii3q2f2E?=
 =?us-ascii?Q?TYvLdYUxhKlV6QEDDeB3u2I+yKQ+Y6Zb+ClgFIiIDPIyCOiXV8GoCTIGq2HI?=
 =?us-ascii?Q?1s2EV/Cv7KSvAtePak/xbm74ZmwT1J70ZqB7Mek9i7ErHRQfyxn/P3c1Hrab?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: daf3e89a-4da3-4ec0-985d-08dc5a50bc76
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:56:38.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6N3wBKHxrFFK7s6K0Nv3htbb1XMtvhMc0JzMCXIg64WzeH0t1i/PvT9Hh002PRaTbmRQrcpVNJ/LA3NswCMlZBM7/Y2dpuEsMG/y7hmNic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6719
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Thu, Apr 11, 2024 at 10:28:56AM -0700, Dan Williams wrote:
> > Alistair Popple wrote:
> > > FS DAX pages have always maintained their own page reference counts
> > > without following the normal rules for page reference counting. In
> > > particular pages are considered free when the refcount hits one rather
> > > than zero and refcounts are not added when mapping the page.
> > 
> > > Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> > > mechanism for allowing GUP to hold references on the page (see
> > > get_dev_pagemap). However there doesn't seem to be any reason why FS
> > > DAX pages need their own reference counting scheme.
> > 
> > This is fair. However, for anyone coming in fresh to this situation
> > maybe some more "how we get here" history helps. That longer story is
> > here:
> > 
> > http://lore.kernel.org/all/166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com/
> 
> This never got merged? :(

Yeah... I got hung up on the "allocation" API to take ZONE_DEVICE pages
from recfount 0 to 1 and then never circled back.

