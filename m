Return-Path: <linux-fsdevel+bounces-17005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9061C8A5F54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 02:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E121C20DF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 00:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08248485;
	Tue, 16 Apr 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVuUHhkv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB35227;
	Tue, 16 Apr 2024 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227828; cv=fail; b=pQkb+aegbqZmIhTjjnUkoRoviYyluDYbTBAprrdiSA8empnqhO2nWPPrtwL9O3tKtCpTVYNAtt0FOMv3Uzn6EnEnThQt9EGNvBdudkLiuWDZln/4bKS44xmY6tFtmUSyiDZgoY23wXstNE7ufKe8c6xbMhGUmuMKAC2YwBV+k8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227828; c=relaxed/simple;
	bh=uCdWLacPkOW9Cu+dZMulz1pD7Pcv27fVeGtOfee+kdg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QMWTwlRjvfgxqiNxfQIjaI2dgxo5tA60fhT5F5MA/t0GhNMgXiXw5YZYu9pBpAiL22CEEDx6SdiWW7dc3TPCWoGNG0dCzgfDjj8s6IjGV3ngWrDTpXuBPkxz9MyV5qczKk2gKwgj/tdmnS9iN73tNr74cqTv/LdiFcmnA45h/gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVuUHhkv; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713227827; x=1744763827;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uCdWLacPkOW9Cu+dZMulz1pD7Pcv27fVeGtOfee+kdg=;
  b=IVuUHhkv4vVBYciv35K8slcTSLXx/hPyqq2vkYi+w93w8DH+1wrC2YoS
   XVY5N8xlZPohnankW6Y+3+22jD9Xq09CFl2sMpjqnf6eVfMhgr8LYQ3H+
   qDbS+xN+XF2L41fONH2sAbFOvTIOY9Ri9XquSdlEeycoYOpsKEz29KrBg
   w4rfe5OTUNKhHZQ1s+z9asrrZZlwYQgMgxnzSz6PN8Lh4jXguJqTMvZce
   u/6O9LLP13aHu2/2y185nSGq1j1DI6hJPkjDDj8XShsrDonQia1OL0Ikh
   Ozm29FUr4yeXJUR1IJULhMWD9IucJhBZcK4df1CDhrngjrHNgBBryiUX8
   A==;
X-CSE-ConnectionGUID: Q89DioEgROm7oWjoFI79ug==
X-CSE-MsgGUID: n3JTvjS9QKeigukZW2vdaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8771179"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8771179"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 17:37:06 -0700
X-CSE-ConnectionGUID: /Rt/dIdtSGGLACJbkH45sw==
X-CSE-MsgGUID: pBehtB4zRSC3iscDwGHSqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="59523546"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 17:37:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 17:37:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 17:37:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 17:37:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 17:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M375sX0rj8YVfFv05w1mS07pJ53xMmNG/sKm5vvgwo87nMRLnz82n0edvKjbOSGkOyQ++GoGCEF0TiCM2WtPgyLhIjLKEp23QS8npddt8hMAhlv7to4OQLi9k64K4VEB3PPz903V3FkRzyqWy7r2027nRHXqRc6O5y1ePdP47Cnxh+lZcJwHN6eBvg7fbD0IWIcP2b1+aOrKdEwmQzBAvvK7GENB5iois2EGYjX6gVqSbHCFg4jDvrCdbDu3rbmEIUExedtiQas5gTD3WGphsC+qzlHqJvw+lxoD50V0qZEXPoV03WD1i5ceTESTaTphWXRIaQCyUIK5I73XavO5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNOJ5yyzRRiwvTKWUfK51ExKiB/Cmol4xjSJAfXnNw0=;
 b=UZlRIndttOir+IwEqIrFzOMzImLz+1QCaSfHVPhQ4EOA1yRK6QUGrsG5mzvV8Z06iS/DHla2CLDBWl4X9Efyc4gV0Ah4nXR8bv125VCnNlJJYXC4kn4HQNTdfHULFUKu8oghT0knnSsCJ9AC16nxtdPmgO3tEIToKB79Rmy/Jq43m4fq8IyXRZs8OGoo7csYEKKVpUWfpcrzuNajjd9j7jYXzJiKdWkhfleF88Zhe/UVhziGmxAfxpPh0KsqEKw6DUVZpXzvcvhb7HkOEUY7b8/aAFgQnTTKX6WrtqI2HWcmABB+uQwCcK8eRfKwcoPTnisT51JkpY5pEUbAGEOvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8006.namprd11.prod.outlook.com (2603:10b6:a03:52d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 00:37:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 00:37:03 +0000
Date: Mon, 15 Apr 2024 17:36:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-mm@kvack.org>, <david@fromorbit.com>, <jhubbard@nvidia.com>,
	<rcampbell@nvidia.com>, <willy@infradead.org>, <jgg@nvidia.com>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>, <djwong@kernel.org>,
	<hch@lst.de>, <david@redhat.com>, <ruansy.fnst@fujitsu.com>,
	<nvdimm@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <jglisse@redhat.com>
Subject: Re: [RFC 04/10] fs/dax: Don't track page mapping/index
Message-ID: <661dc82bd6c77_36222e29493@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
 <20240412152208.m25mjo3xjfyawcaj@quack3>
 <66197008db9fc_36222e294b8@dwillia2-xfh.jf.intel.com.notmuch>
 <878r1f2jko.fsf@nvdebian.thelocal>
 <661d9355239bc_4d56129485@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87h6g2b1qs.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87h6g2b1qs.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MW4PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:303:16d::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9018afe9-2e8e-453c-8235-08dc5dad55aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Tx3aX0yfmAlRyvN286YBOGENSq3k8Jsz13vEK2Lmt00k3IBqDZ9D+aR85e6y0wnKPfw1np+BdCdRCxOCkxoXtzDenoSuCxuAyTCdO7fh4e4glXm80hs13eZpBAOgm3IbWo0CGb3GD6Sp2hAVU5bsrPBhfqzbF/UOeN7daYKPSZso+ubx8VM0xIeOQ4fSan5OA4fSHRx0KPl6hQguV6u4B8fRr7tghhB/J/rtvdJFJ3vOqwwHIFV2PpVpJWlULYwWOvmHL4FQ9edhoZQUjpZaUCfrB+/v+mIXRQ3uQ9LMd6Z6YEAe9um0GS//t7qfQLUkN6BOb6ObLZ+tSrUpz+vNaxr4wJTK1howK5iC8XECPjGK3AXFRpZx/2FKSEX1MBS5X2q1pWpWPLI4C7PE7SWsgmZCIvhT0z1wTIKeT4SrXjgEflxgXv5wtzGrLLbBHxEi0CWiauHfh7yRoEVBJsgdtcRWb+0gACcv6hsTwQvhPkRvulH3Hseh/s5Hhe74lcVMO8Sncd+Dwqww0tKAYCNjqoUtKiSAGYcpfSyzvK+C4GynNl/0U0SWw5OtGFnrHN17gmEqWutp4QqQ5HFWFN9CTI2aT9WvnuVdkQA+6zOSzcuTbs2yGKk/sx4gienDUxPg4n0ipSK0rC5yf8aPj20v+nRGgj+cK7eHtgSPXL7nQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uMx+TZiaTGTvVo3/EphtUTD0Z3/+y6RIhinl5bz8oPKq263yE4Mo6Js+Wxal?=
 =?us-ascii?Q?wULf5O8j6IFr8s/MBXsa3SloTK8kBFRw0qAkehEK/C8DejYZeMW4dcnWgbXy?=
 =?us-ascii?Q?xZHXfn4q8HpEglGNN3f1SS7521fauY78z+MhG1KHPFEzw35Zchwh43subrjs?=
 =?us-ascii?Q?Xs9exOyYJztyWmLi4QR81Wa6gtnoWSSbmpOnwVBcYT1JEgYxZIeUlJ7L3g8f?=
 =?us-ascii?Q?bZeNkG9X5hadtuNh/1u3oOLydxIjdFfqiZlFtK2ymhV65ILnQrqV8DITvWSF?=
 =?us-ascii?Q?waT2MFQi5tTz3vtj9rG2IEWRViFttD93xnQl/PVbME9DIAClAq4UkTChnH9i?=
 =?us-ascii?Q?sCu4oUxw6V4ZGc7qsI7hnkh/SdD8gsChGBS3cuUdq4oLuCOnnV/jcjTlnOFj?=
 =?us-ascii?Q?iw0/ceHjF5TfXmr2cTpsRbbH2Tk6sb/IkJVIFIxjoOr5eutkyzhrvi9tChAz?=
 =?us-ascii?Q?6bQ1PEbmOEUxhchDwenyotGEcyl9MZWhmZJTHPHeP0ikygictJkmJyTUZSod?=
 =?us-ascii?Q?AaPQWpUFElD1GAE3Eh3HTpCmftAb7sGd+Amb0LkkESXlrLt7yc9j1FvbnOM1?=
 =?us-ascii?Q?XWpMpO5u5TDjxmnLMIigajkeEi1x7yo4ZJp+rjW+MMdtMbJ8LqbrKyDKEzTF?=
 =?us-ascii?Q?n7sVmaGWTCcuZysMjdWlbcih2S3tCEEenVAEdB2mo8ReHlTuwZ2wfF0rPped?=
 =?us-ascii?Q?JXTqu2VzSC5+yUHZWxt2w1KgTXqbzb2wFd+0qBSizGYGQZIf6I6QGEjzH8N5?=
 =?us-ascii?Q?T9x7tko8uZZh4IPEmsiK/PHK6Hh6wDFxVqBFpGaCBWj2JbIw30YuuZ8kErYQ?=
 =?us-ascii?Q?0yQ+/skEnwM9gZgFr9f4qDMVAsllYbCbiPwI86TWEhUV0KxCJvLQO3AsIZ0/?=
 =?us-ascii?Q?dHUYbQBHinAljI9L7/jzKgL6yAhvCIgl0jZbHRLthP9UOXxedNu9Q7+zE2Og?=
 =?us-ascii?Q?GFiH1vUHQH8IAQEPnxW1ni7jeITuiqXEzhf85xWyxurz2zkET6Om2GVPj3SP?=
 =?us-ascii?Q?SHAUbOcpEnI6/hLlwDWh+pIpUZGrlZpYnSE+YZ62AVYokq7wDRu2WWh7+2q0?=
 =?us-ascii?Q?Z6IFJrZPoAhF47/vZ7H7VKE0gxY/QZa60dlyZKR6eOCXqe3mSJkRlk7M4s5v?=
 =?us-ascii?Q?oJ8vmpSdhb6laTrO9fKE5m8Y63/ldFReCNgOpHmbINcAmSuxOh8IzLzQDTgZ?=
 =?us-ascii?Q?PsXREu6JWp5aTWyerSreFkkgI4tpqfG2kV1zNA8JcEQiPCmu/+4NUREDoTSB?=
 =?us-ascii?Q?5gAfWs0uDuUgppJxJ8FmdIcfb1XdZ+DRJ3Gmsv0oqDDHvSOFQzjcfbMnIKq4?=
 =?us-ascii?Q?JferWKLbmvtXbZgj+cTRaDhvRq1umbCQmp/P/lLPXvyuYoxuVRX9SDJ2Tnkm?=
 =?us-ascii?Q?M5RvUTSRTdR/uCoVYeyRokYAC6+esBock5xiz2nTFx/ZAAmcmhPXECkL4W0m?=
 =?us-ascii?Q?79yvY2ZGeO/4BpYYapoE9t2d3Y+fTSbMn1H4quqQI5VIw2FJMrwWEzFMuB2Z?=
 =?us-ascii?Q?v5RQ29egPED7u3UVtjaBez45T3uUPnUkg9D7ma78F8vOrA1Y52Hjh+CBrkO/?=
 =?us-ascii?Q?VjX2oTGSx7MFjMyk7OqnWBabTM6CRN4SM2MtWHoSn3QFFjlzESOQvcrUbZOS?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9018afe9-2e8e-453c-8235-08dc5dad55aa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 00:37:02.9622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JA+KEKPYjCcxJ4NLY3h2Zb7zCUkAvQbN2j2LJEruuXJzIKmfOpHXaC840giPNGLwtYvz2vjj96VlfiN/locHq0rtZjCnLa3Vl064NOr/T58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8006
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > Alistair Popple wrote:
> >> I was initially concerned about these cases because I was wondering if
> >> folio subpages could ever get different mappings and the shared case
> >> implied they could. But it seems that's xfs specific and there is a
> >> separate mechanism to deal with looking up ->mapping/index for that. So
> >> I guess we should still be able to safely store this on the folio
> >> head. I will double check and update this change.
> >> 
> >
> > I think there is path to store this information only on the folio head.
> > However, ugh, I think this is potentially another "head" of the
> > pmd_devmap() hydra.
> >
> > pmd_devmap() taught the core-mm to treat dax_pmds indentically to
> > thp_pmds *except* for the __split_huge_pmd() case:
> >
> >    5c7fb56e5e3f mm, dax: dax-pmd vs thp-pmd vs hugetlbfs-pmd
> >
> > Later on pmd migration entries joined pmd_devmap() in skipping splits:
> >
> >    84c3fc4e9c56 mm: thp: check pmd migration entry in common path
> >
> > Unfortunately, pmd_devmap() stopped being considered for skipping
> > splits here:
> >
> >    7f7609175ff2 mm/huge_memory: remove stale locking logic from __split_huge_pmd()
> >
> > Likely __split_huge_pmd_locked() grew support for pmd migration handling
> > and forgot about the pmd_devmap() case.
> >
> > So now Linux has been allowing FSDAX pmd splits since v5.18...
> 
> From what I see we currently (in v6.6) have this in
> __split_huge_pmd_locked():
> 
>         if (!vma_is_anonymous(vma)) {
>                 old_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
>                 /*
>                  * We are going to unmap this huge page. So
>                  * just go ahead and zap it
>                  */
>                 if (arch_needs_pgtable_deposit())
>                         zap_deposited_table(mm, pmd);
>                 if (vma_is_special_huge(vma))
>                         return;
> 
> Where vma_is_special_huge(vma) returns true for vma_is_dax(). So AFAICT
> we're still skipping the split right? In all versions we just zap the
> PMD and continue. What am I missing?

Ah, good point I missed that. One more dragon vanquished.

