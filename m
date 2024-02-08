Return-Path: <linux-fsdevel+bounces-10839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E822E84EA7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54D4283502
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02B4F5E6;
	Thu,  8 Feb 2024 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9uPZB2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C704C3BF;
	Thu,  8 Feb 2024 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427729; cv=fail; b=m44PWlFC7W61yj/QciiWeliFGRdgnUf9oAN0vVs7tF7ceOvblroVxpszWTsxJHYei99i+b2C6yczDHOiZlnOk/DwqrqCyJasWi/88rGJ67pr8x37p4//L/9a9bN17nPVCjlRAD1cyOrn/RTtyLc4D2MMCz/DUmb6fu6SzIzncqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427729; c=relaxed/simple;
	bh=F1s8PH8YMB3oMNLCxrRxUr0JZrbaO6ow5MAYrQ9DzXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f3t+brTTgyVF3c/y8uqoH7yr72DhUBwEaW0u+lNcOPOVH5j7Tws/iZADMJG03GUu3YCQ8ndxcXPyDwXPr1FhtQZajp7G94Ln+okXmQqYW/zzS2w994BJe2igduDhnt/44EV7GBw+q/5embpwzR/nhT/5RFvep1Izf00UsAJdcDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9uPZB2V; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707427728; x=1738963728;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F1s8PH8YMB3oMNLCxrRxUr0JZrbaO6ow5MAYrQ9DzXE=;
  b=F9uPZB2VZ1hqK76fAMeIZPEvxnda111W2YzRuPW4YRows9dwxm6ENOGZ
   dQFnFw1JYQUbV8g7//Bm3NRFE6IoEPFkESWqMTA8Ocwaflubqm2vyS8dm
   uo1d1x22Hyl2K8r2W3Q5egoJuJiKDqrdTFLcnQGJya6fdlnNQ1dgsFoZq
   68ehwqqSiJ2q2fpRDvzxhv8/UZeGOw/PaOSoOU2763DT/zwlYa9OJnzhJ
   gLyXdSVepooXeVAw4YNnHzV1+4OdZhUJ1+0192Wpl9wDQclLRqHJqEBqD
   Umxv9Q8Ml+NHCt+LH5GE1Lc9puGAL3bG+JgVAnD65F0STKls+ywfoGSAt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1458278"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1458278"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1755595"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:28:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:28:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:28:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:28:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:28:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp8FTqudCzd5a7cHeEGPxVZ14zFW48jnEk23nTT5/yIW5ecZnNd7ZQZ9pa1Q/DnAhwwMpNNCXukH74ykCD4st7st+6u/fYuaWe7/li2VQSR5s7LZVUYUKj1qnEsIN3ShNO89b5csczUTNWsewdCuKrHn43FkyMPEO6Ef8AsW4dg/ieX+ep/IhqtQ0fRih/mwNrRy1gxOK1M979p/QUBsfyRiMuvAR5rtLz38t+vjhHp3DeDAXtIYsIa5Dump9TZc/NB+anY05hr08ia2YryBgeWvN1wbSzayfJvS41VeaXI4ZisNiWnEMQ4N/ZEImj1NzB+UcdIbyK/fxaCItABF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT2AF+C22usOGwrGVRxHRz0iW2nUsy33KTaGSwCK6Jw=;
 b=jpXqmgtvAOPn8PY8fQEQfqqednOu7HEuqlaZ/TTgGod2yApaonKG8qzR7RaR80jeuLbKzdc2i4sWb2qowfKeJKBu8fl7xJJ8wnUcX0df1yUhsOTf3a5oQrCvowuyKqTefEGlZYEL1j0aImqbWe+1k5+G9ZrbOdG3d43Fb7kNbT5/hyXi8+EN+Q/WAuqbo+sfz74IR72NzUZO4k94pPhjTbhl0p36xjZsHxvtNs0BebU9p1s0VaBcBD4tFfWbutmsh++GUqaLSHlT37I/T8yUmeLkPyKu7BQvBO+kjo4zPQYnUdUZ47xOU5dRKZfpoffH6QfhCwHIlVBlqchUoHqUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5671.namprd11.prod.outlook.com (2603:10b6:8:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 21:28:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 21:28:43 +0000
Date: Thu, 8 Feb 2024 13:28:40 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
	<linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <linux-s390@vger.kernel.org>, Alasdair Kergon
	<agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>
Subject: RE: [PATCH v4 01/12] nvdimm/pmem: Fix leak on dax_add_host() failure
Message-ID: <65c54788187c3_afa42949f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-2-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208184913.484340-2-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR04CA0344.namprd04.prod.outlook.com
 (2603:10b6:303:8a::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b1b247-973f-4081-97b6-08dc28eced26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMPfH32wYKgexol0IAf+RESArTJ/++jT11rAo3E4cu/S/OsDI/EHe1vmPubxnnRLXg3V48kKF7oEoUAFzAdVYFoDjIbdlRwicIcOFVea2PzpVlzQx2SNX2OmEXiB6tGXa7g8PciaBS/li+JSPpmetQv+cDCuodopRSfo2APktwxXlT/DDo1RvUZKi0tsaXOuDPTsB6J/+EHFEBN6WrfGsD6DYZ3Ibynms/YuPhuKOTHBBCv9R3G4RMl/KEaHCJH/4uJGSa0Zp3bYhClY3emSpDn/fqe6o7QB1AYylR/wbUQNq+o6Spge1qXkgKutQ1WOr4wJ1Xir7WSTDJGByG1aRtFM9ytecj8R3stTczIU7LNVdWh0hvdYW2tHNLEnqJ5g1bH0e4SzAFc5uTPG3fWhOO6YxKBh1O43iaKNEWqHDMOo0ibujR+pRvlHrKDHp6Fv1ek2H382MPg1ank1ULAhYOoD4/7u4HK3gGI/gS4mB2i6or1ZE/ziWPaT2WgFSor3zByahb/rzOMJc+w1r/0Bd0ZUAnWVhv3r88vVBGHDBdAg9oSGhONXLTjOooV+9O8K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(4326008)(82960400001)(8936002)(316002)(66946007)(110136005)(66556008)(8676002)(66476007)(54906003)(4744005)(478600001)(2906002)(5660300002)(6512007)(9686003)(26005)(6486002)(6506007)(7416002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4TUVmHOeDXU7PbP0JZGMI70g8b1CKrj7X4kGtVCyDTa0tgxpjazmhUHrLvU?=
 =?us-ascii?Q?pne/L5fwD/R1+2G+8NCN+bGutAxzFTdzGfcYz0HXmKlB4GiYMOGu9UvsJAah?=
 =?us-ascii?Q?XY+6vUuD1aDLmJfK3ZJsq8D5MDaIxSUefpeSNlpL0F5PcjMUfdWgxKyyjaML?=
 =?us-ascii?Q?sB9h0oHV6+4vVCCGM1yi42Nw6HPxFXzInVDy8K5q1VtAhYOgx4oFVpKgjghI?=
 =?us-ascii?Q?4D+7FAXGpduXy2Vt+aDfBGmcSZeH93ip3N4NamBj25/lJfaROyLDtP9pUJND?=
 =?us-ascii?Q?3i9G36o4t3dGUZlI6mbgRmnwT27856u40VeBV5LXhmnFMMvCW25d7QZt3E56?=
 =?us-ascii?Q?I8ytUnpHwsP0USyC7r1ft0IIAEvE/8EiBR9hlCvu/EnHYRcscrrEMlaKyXru?=
 =?us-ascii?Q?oK2tay1zefEb4fIuLJjgMBAS0FHm4KgJHY+Knbt/sHPO9x8gtn2IAqeJRaAt?=
 =?us-ascii?Q?Bjcn1gbaXlRZw9SxAKBtm0/0GtfHkAJv4cO1MfuShPwlpKiMhRzEiW5hizBQ?=
 =?us-ascii?Q?xiXvzJP8DruH1RWw3zGvHPXzzf4g0Sl+28bGyCjV712JYoJb+Qw4PPfaduTf?=
 =?us-ascii?Q?H0h1vJGuaNqAOJt2//7+6IJkB0NMuwC3A+cT+JNhUkbW1daqp/Lx4SDN313p?=
 =?us-ascii?Q?glIXUTEN9ej0HSoLQwtNDBTtFDcIqoCBOnn6E5KoxZ3dSqFoINtYudUFIfpW?=
 =?us-ascii?Q?L2f7VmJW3c+0cDllgZy/te/amiHRLu8VaXEYWBKcw+7tcYxMPdmx2JbM+h4v?=
 =?us-ascii?Q?Ae5eIjd/CUjuNBtmEyBpPF3KZpic3pWsmd9bN1+sQWk9x71Cq4utqt6Tj/5m?=
 =?us-ascii?Q?ndTxT2QmfH8EP4S2OzrXRpo6hwVqFQAnfslOAxU/3RlAjNg/M92jgwUdrGBE?=
 =?us-ascii?Q?EdVJ4iMSrsoGjL/dL53YWv0qNgc/c9gOBhBUSGF0/sVkldESL6vlsE3O++W8?=
 =?us-ascii?Q?l07+3vl5jleiWknAosp6O8vbSG5pVZj3Z+xTGkShLIvNsaxBA1pNrbN33s/O?=
 =?us-ascii?Q?BDU48n01v6OwClTQx54cveJYjUTsVaLc9oXmVdwDOZ8PbQ5XK7rynaVmj3BV?=
 =?us-ascii?Q?Y229zgxLMaCE4htW3CCDCkOD5nrBKpK1L1spwliM6g0mNDvqK869TUVjM9Hf?=
 =?us-ascii?Q?sOUIjBqJidAUGAb7gEX7DYQfvf2f0gEdIFuN8VSpw2q6pb6WEL1KkTQPqqqW?=
 =?us-ascii?Q?61/iMwnQnT5+3Ot6z6cv+ujaLVaJFhbEaSQ6eDfQWC1xBVtyRhH748zeFOaR?=
 =?us-ascii?Q?8j2NBdC3o3EBYYUL5aSfss/vqYjrTWAz3wU2GMlcUpJAUtGKN0Fi3EauJfA4?=
 =?us-ascii?Q?gXdxJLrAmEGwve691eBdO6bnxjBJtcyMZMgmkN6UEyYopwHOq4A9NJAc/DEE?=
 =?us-ascii?Q?uTzodd2dmaVqF0nDKDpGHXyX8ahoWeGcA+7vmdbPKaE224+WIDWktYSJb820?=
 =?us-ascii?Q?yNHZDvNyn0cN4NcIpNdhiiHB0J7kWPje/yi4XXPaMenG/njYsDs9B6Qk4I+V?=
 =?us-ascii?Q?rYGGlTgKWAPK1U/3RnbVCoKQvxQnDsv/7n9ilRMoCbYyq7LRxSkhynamOymX?=
 =?us-ascii?Q?y9coOaSmgVuys+8oN/JTvkniyrTCX0wuyV55XMxcULnxtn6VsUEhcvbX9OE+?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b1b247-973f-4081-97b6-08dc28eced26
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:28:43.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHvvtP7JM8WOKGB4Sf/vVazgvsHBPbdD1rf/B/PZ8x7rZoocFFD4eJSBRJlOZzJ0qGD9SejLOb+i5mVEZ1cHqAcLz5+pgxyWEvYWQxgecVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5671
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> Fix a leak on dax_add_host() error, where "goto out_cleanup_dax" is done
> before setting pmem->dax_dev, which therefore issues the two following
> calls on NULL pointers:
> 
> out_cleanup_dax:
>         kill_dax(pmem->dax_dev);
>         put_dax(pmem->dax_dev);
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

