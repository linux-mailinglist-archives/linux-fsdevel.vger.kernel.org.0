Return-Path: <linux-fsdevel+bounces-14947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85704881C51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 07:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FBF1C21A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 06:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722D38DCC;
	Thu, 21 Mar 2024 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoIDW+ZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9E6FBF
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001157; cv=fail; b=Y5wr9BcR0xb2js6um6FZqjYzMleXYKVVvBwBryuxVmkm80N30X44Hr53Z+PuXIohBH8IadLDUnGBfcQjWlQB23Xj1/zq2YKk0qHH3vLGW+bj/0iX4fkLgryOvO0IfY4AVCFsBhJa/i/JdoSoLUzrD7zqelFM+c4Oif1xoI95rt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001157; c=relaxed/simple;
	bh=6NeOoMKbkYD+oUBUkZr2SVHdFqmxJF7ACHya3pph1h4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YS7ZTqR9/H+oySe5EHGdlSENSNrcTdLQTaiprl5lrLDHarLm9gyUtJNiXLRgoYpIamxBiNrDKivv4tFVTnvySZa8cB0qmT1TZF52SOiZ9SEOWgUY5P0j1PPBmL4oMO6zOhoDEcMe+nmmqxFJk9wIKvHGXlxZTqkpk6CfABLdu4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoIDW+ZG; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711001155; x=1742537155;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6NeOoMKbkYD+oUBUkZr2SVHdFqmxJF7ACHya3pph1h4=;
  b=IoIDW+ZGn94XhIUbjGbQQvJtaMKQOJ0RvJPPeaS+x4Jagx1qXeJGtgIc
   uMjreuo0jRrYkBv5k6eJIMm9ZyFnjM4fJ+wuaiMgAwt7Ou98tQY87oZ94
   W+ioCGIYnpmqzRTxUhcWgliaIR1aLEuB+c+CI78Uo44v3ATO9obdH4jQ4
   VZiacX9TeKtw1D9nJZit6QFTEM0cZaD6f96ZUZkBkrYtujCmcRaIJ6SNq
   Q4RSSASgZtLQsejbzP2YEZJYGapqQB3bSQpRz0y8EvQQN9uuGVNlJvOwR
   FAf9dDak7SW/+qKsG+ptBu8N4wj9nYUaWd8za19Ck2vAES39V6BEgqqCR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9754059"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="9754059"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 23:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="19119404"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 23:03:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 23:03:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 23:03:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 23:03:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 23:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzMH7m6J/rnPtTOWjr+E+pHN153KT55fHsPl1zHy+oDlBt/6eRhGBe0kWKMi9iOmvW13oAMdFGtey1X9AVRcDHDpUn2GEtHnXkNLrnQONvnFWr+rPNM68eQgl9/fOVSgIUQpUhQBF2P0R3uWLOgZ+xQHtwOh9gSY7CXIYIXLjAGYkuEF2wBEf9dGLd3U9F7LqIMKWEwpacee8jxXbgvFZXjzn7vPkFEZM16y3U1bg+5QHsIrLRdgy6zzkD3WiGVACHA1JX0pHCMXeB08meN4sigu7kcilMr5K69c4whE6/c0mq1hVqbOdB/8mPQ6FumN4akVc2T9n8ZbPeDHfVV/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIdlC2yivf21yFphG8AkwgqAu6dZaX8SM2/5jmxj2Ks=;
 b=i74y4yLSQYqXOEM6Nw8i3iMJbl98Clksv3nKA0NEp3q3f4dRxjMUWYToz47kfhlnIYtEroca+xyiCN7KNJjWd7VGMfiLJBjyiFII1YK/e+2UxR3ylAlAri48mXenj4Uw6a3jbStTygcvh2y5Haex33HGlMTPnS2T3aoo2IO7g69NNOjUboSnQSym4FtVXBCIx7GAjx3fkWqQU/Bul7q0dd/kdqW942Pv8x8XmpXiybToqusUy4FjUiG4dPRxKMX7w1uB1GUtc8DA5gcY22CWmgGR+AfmmWYhl/jc+3i3in1wdSaipuyqSlaDzFEjzOXPRQ3lBqjirdUDS9qSBExemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8397.namprd11.prod.outlook.com (2603:10b6:208:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Thu, 21 Mar
 2024 06:03:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 06:03:29 +0000
Date: Wed, 20 Mar 2024 23:03:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
	<jhubbard@nvidia.com>, <rcampbell@nvidia.com>, <willy@infradead.org>,
	<jgg@nvidia.com>, <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
	<jack@suse.cz>, <djwong@kernel.org>, <hch@lst.de>, <david@redhat.com>,
	<ruansy.fnst@fujitsu.com>
Subject: Re: ZONE_DEVICE refcounting
Message-ID: <65fbcdaf2042f_aa222948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <87ttlhmj9p.fsf@nvdebian.thelocal>
 <65f148866bc56_a9b42947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87y1ad776c.fsf@nvdebian.thelocal>
 <878r2c6t99.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <878r2c6t99.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e73de79-96ed-414c-16f9-08dc496ca1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3QApXi6VfBaidPajxtoFKCHrM7DBcyl253uA+qnI3AjzRwWy8kt0fqPVX++DWQw9cHxGK5jCsFpC0XC8+SSekKT+8O+x5E9GYjzgsyUTNdLMW+mYKrcg9U2lsTf7zYVmtRh0QmwiuL3Z62RlBofYwcK10ptzoJyhRPellsvpoMGvxYKRBRx8WemkJbMJT2BQALVxmAVyZf+oDlOGt9mt2jGStWoKbg+5zUkYV9LQ/K6HPCzs/9XvsaNCnTxVT2D36cmHtPcbHUWqks548acDbg1ArvSGBLEsr6WsA+VPHPaPfiBZzhmWYfqAgFinIa4DIjCq45O0BEKBAi0KIWxzVupSJKq2oB1DPfQXPpqwxXxQaWJSx8GP+YfujsoDcsc5gK8SMDpyFQdB//tM70Cv/SpDGC/yRz888WxC7N9UJn0NQNHp7zyQQdcFSFOcKpv47VAqowLCUo2SAOtwz+bpIajQGubaKNFqmXsB9yHpHSIDW91LEknKjJAKYyOw8IdOSWG2I/ezu6gYQKtujX7z+a1S/rcJnRUEZaBiwgWXXzXXi84rSNKj3OixHIIeSRxe2ugAKGFUaehZxZYcX0qYu1D5E8g9rJb4EdXmJE1wpaPrX2UNSIZVyIR2/FyARiDnyAutTnrLDKcLYtSuO+lHzCfKPB04p4ZHqXhpP3SgnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2I+iCahyihFYWkMJB9cuhF/CPR9Z4QQvNTLzNhygXdPTQnGgN86Z4bu9EcL4?=
 =?us-ascii?Q?rckd+Lm7lbO1AaF1PZlBtkDnDEJjDNm98mLRTSQ2Y4/uFloMSYmnFyxUXnMy?=
 =?us-ascii?Q?r1BrjonhLRnLhxcWYzS3m0FC+/F94D97jDC6TmYV/KiEzt1HBzKlZS8q9Mgq?=
 =?us-ascii?Q?CmKyqsPgGTGsQ1+KA36ZqXZM0UW1oN4whawe4bfXjyjrb7LG8n7yEAP6gA3F?=
 =?us-ascii?Q?0QmvAtFPpvaet3R4kIMCvGkbZF1dSHmnEN7h6z6fTWd+XKfQl5iJC7sXAtmH?=
 =?us-ascii?Q?ThCq34z7ZAlrJSErNP/kvhkcYT5AO2cQZ+huGzGH2bjlN//gcaWFAXNfB07s?=
 =?us-ascii?Q?fX3TqtLT4gShaSkCSAT37qqQVC+tMosD4o9UyPSfLLhX0pYYLt269l/9Qc/g?=
 =?us-ascii?Q?TuXBNK1vLhiZrNO/mqPqDf4rLDt7kKMc9VUR6j68cPCKQe2LgeO2NGKlj2eV?=
 =?us-ascii?Q?yg5BKkRaBr+Vg2et/dJeq2Fh934cisIG3YPGWv6C4FK28GGiDhPXRSAKxPyx?=
 =?us-ascii?Q?xt7UH7yXfJa0h7Ks90rqHa4m6DaQdUlqsdmMfdqzFPSaGXz7RI+26i0xGL5J?=
 =?us-ascii?Q?OGouijINROVeWAUg2wOCOQ9kFDmTJuYmkHyb0jxB6izdOk4Oc1JEGMMOKU66?=
 =?us-ascii?Q?f1uFD8LqkWvU6Bj5ctxYWt0l7MBWFJURA+BqD/b0RUu0L/FUqqliwxIit2is?=
 =?us-ascii?Q?SktI69sahBCRw/qVrec1C1JK0k0mpMN2lEs0pziK58CzbH00X1oX8iTkzKAl?=
 =?us-ascii?Q?o3SfyC/2OpDcXC5/PlW0n9LYdD+gPZVJk8ZIj6+PR8YkcLsGmUKYlKphNYJz?=
 =?us-ascii?Q?QVgeMyM5O4UPf/m6teduGqDPo4dZ/SAqHjJadlJccZMg92sdlc6CRjmKNiHH?=
 =?us-ascii?Q?BHx0C0A4KjrkNl755ehAShQlIceravaGnfp6PohAYAWuBju98hX1mvn2b49Y?=
 =?us-ascii?Q?FcNVOsC8eCbWHwBO1YmHYUG1BOsFvrWRquJUEFCWEKfJJx7CD9kXBuQtixBG?=
 =?us-ascii?Q?Lzc8ngZfzJ2xftvU5Gp8HXJFOgb/LuskbthXff72TGDsQMFa5dAJQva69LNY?=
 =?us-ascii?Q?pE98zIfKSg69bCAu2wn1b5HjRiO7BjNfD1lPIEbV7foV7PGjI/M1Dg0zrnLK?=
 =?us-ascii?Q?QkhQx6SrspTp2UpdH4S1xFx5+GIF8m9dX4hk7NlNKKUg4OZzRvch9JqjopHZ?=
 =?us-ascii?Q?MSfr+ghvcORifMobU08YnpudFGmU3WBvhFcWsmnMfN2V1xA0PJFF8shM+Owy?=
 =?us-ascii?Q?QPWs0XPOYt5qsvpcsk9NT8arK0dEdLVqiHowvIAbVhuiNSvWa1SAl3s0Voyx?=
 =?us-ascii?Q?Nt2Uly+wjaHldPp3gV3h10K4d42nkZguIUk4DACu/8P2tDd+0Zk2FLKa3qIq?=
 =?us-ascii?Q?H457S2ZrLEeP83xSc7tbXmXipAZrE+YCj1hxyXpOQ85CNo1UKBpoeUPbW4Qj?=
 =?us-ascii?Q?wymnZOM5LU0qLbP6PyjjkK9AMuUSbTUL1DFKK5N8oWmpa0KFeZ1bbtiNJJpS?=
 =?us-ascii?Q?0eDFBqvD5cUyzVIzQOh0s5nXbW8PRmeOM2wv238CyyOecxB49waPP8Q2HVpW?=
 =?us-ascii?Q?qkptvraGqIUnJE0q1ZVhopjFxHfE6y44k4FToMGtTCpGriJpnrY/hgIfueJe?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e73de79-96ed-414c-16f9-08dc496ca1ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 06:03:29.8604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GO7e1WobVe5DJBYeqYz6YlMb3zGnlLFXUU9hmaZXzliMkxtCKn9kdWUuyNJPqjdK5WiDsxtnHGaywD0Yg8LVdLy/ZFwUwslFBjRZmqYbrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8397
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> 
> Alistair Popple <apopple@nvidia.com> writes:
> 
> > Dan Williams <dan.j.williams@intel.com> writes:
> >
> >> Alistair Popple wrote:
> >
> > I also noticed folio_anon() is not safe to call on a FS DAX page due to
> > sharing PAGE_MAPPING_DAX_SHARED.
> 
> Also it feels like I could be missing something here. AFAICT the
> page->mapping and page->index fields can't actually be used outside of
> fs/dax because they are overloaded for the shared case. Therefore
> setting/clearing them could be skipped and the only reason for doing so
> is so dax_associate_entry()/dax_disassociate_entry() can generate
> warnings which should never occur anyway. So all that code is
> functionally unnecessary.

What do you mean outside of fs/dax, do you literally mean outside of
fs/dax.c, or the devdax case (i.e. dax without fs-entanglements)? Memory
failure needs ->mapping and ->index to rmap dax pages. See
mm/memory-failure.c::__add_to_kill() and
mm/memory-failure.c::__add_to_kill_fsdax() where that latter one is for
cases where the fs needs has signed up to react to dax page failure.

