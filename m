Return-Path: <linux-fsdevel+bounces-10868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5176884EE7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 02:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764BD1C23A16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD515D0;
	Fri,  9 Feb 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZS9bhiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B781F;
	Fri,  9 Feb 2024 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707440517; cv=fail; b=qAaaObPvDgfEKmPJ+GgL9WZvounUO5BDJiqu7LWXzv069W2j7K5jPtz2iNG5sUejd/8e2dUvN2LKsL5+LpSInT4yvXkeFz8NwonZHskloAe1/A7H3fdKTnUpOsijsCbcNMAXm0ELyo3Uov4uf8vpZlUNw+tajQjIjAzZhZACS4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707440517; c=relaxed/simple;
	bh=KO0NB6VA/DHde+u1QidACgniSizD023az229gkFgXlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oPW2TvW34IeiTYuVgvMZDIw3r+CiFcXSmLt+RryQIMM3K6Jhbqc44zbJAEtPdm+TZJYCeTiTVWs39PUXyOpUfXzzM10kHo3IMQmZ+rB1e4hCIN0hVYcOQyPvOJ2civ2BJqRs2VqKXceu5nOY7f5I+zy78x7x7Ot61c86gUtX+Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZS9bhiq; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707440516; x=1738976516;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KO0NB6VA/DHde+u1QidACgniSizD023az229gkFgXlE=;
  b=cZS9bhiqYFzpzmnGV0Mj7MuOEq+TX5Azs5jnzCwRyRP4W8VjRQs1GInK
   cBWKQv0vYrDSa9mNev7ISyfdQqx//V+MYexhoET5PKA2aN2DzTah89q5r
   NjxXR+vt4cse9IDCCHa5qTYCXRet7b+rjA0psqUFiCyLeU52f/as9os1S
   1/vpj6s85QzjqLYRUia/1X4vgCUnvvufe/95H9OKU5k33Pg10AMDOh0HB
   w3uFk7Cb5I91RKoNsrocfb5nCs9SBZB8jSg4Rf4D4POF6mvvNGBYx0P7I
   jE+naARTjFd2KcOib0TA0g8Jr4JBrGRI14u2qzBmeeQOMSFcqxgKqUnfh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1232455"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1232455"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 17:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="6440034"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 17:01:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 17:01:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 17:01:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 17:01:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 17:01:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsdlWAMjbrP3Tb0Ig9mjxjffxMJzI8L0QeyJJoMN+LPmwoNh3mbRQ8e/hQ3oJp5pN1Ez4lOtrGOPrvN0fELvHRMIyp8R/m1DPTIzz4jMSss2KFCIGRGQlanBPwmJpkC+AFdQ6sMblzNVXdJQqVwyHa1t12G+lG806/O+IkpVKT2aFXbuQXmAiIAIsyfr3Oh0Jckt8JTO4nOxxPNtz9+sJPU8/2ZyaxhTkCZtg5htJYJGQ3I+90QdiIB9vzqHcYWO1FlaEQyfnTKR+XPiLhLodu1WUGM0YDdw5V95fSeEqugsf4McdjPpXaR8kbNFCwOiOOKi/ZiXlLF0sMmQ5ay9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIGOUd0Jtz8jRSAzNb3Ekwk4Hbncu74Q8gho6EfnMIc=;
 b=NHt1YnnLJYdDjbEhet0EQJeQjn5/Rv2XQbo08AwTaCJzx3Er+4RDvtqt4vlHJr4BxFamdevAFltZrnM3mnAk2VSwavFlKEoBIrWJV0GVsW5lB4wY174lXxbe8iKpKd3ejXhyNKPBLHBljzPyMOZTRiQRD+gRjW3MRZ1Bi4AcnXnLDETRp+Di+ctJCEg4ekx1whkFbR72ct9+eHmL76LbEKUwBaH972mRtOAiOCCgIuMFt4kmgraEUymc2PsVW0cl/vjrF57vNNItTZuVZQZOM3cHjtPYyrixW9wjNoI7G5ylRoTIUvnwXI3ByRhstXAcC8uQgwyq+2lxlh1cZYJUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5266.namprd11.prod.outlook.com (2603:10b6:610:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 01:01:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 01:01:51 +0000
Date: Thu, 8 Feb 2024 17:01:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
	<linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v4 06/12] dax: Check for data cache aliasing at runtime
Message-ID: <65c5797cc88be_5a7f29421@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-7-mathieu.desnoyers@efficios.com>
 <65c54a13c52e_afa429444@dwillia2-xfh.jf.intel.com.notmuch>
 <0e6792eb-7504-464a-aefd-d2a803adb440@efficios.com>
 <65c557a2e77f7_afa429490@dwillia2-xfh.jf.intel.com.notmuch>
 <5328e7f0-0864-4626-aa6c-fef5f3f62dc8@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5328e7f0-0864-4626-aa6c-fef5f3f62dc8@efficios.com>
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: a62a6431-639c-4cc9-0d7c-08dc290ab328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pWXP+h89SGQErhKSSj4nyTgUBorxnztsN3ZLgxd6PsCfOxNT0CmO+pWrMROb6Qjbb9UjmVylkFidTX4H32/7bMd1fGXHYbn8SUUID5VQrngAmblBvccjY8nmsvgqRsHoXfIvaZnkutRC9AwEc5ywp0H0YAILdvPT1yo/AcUco6ahz+5KlooOx4l1nsAuOAbffWCu5pRC446kuQ9yaHu8tZLOoHGd0AcudE3e4KqbbJInyQDnka3QrF2z835i/BRwzyKsPBf0xSbOvgDGxFNApqQFG3cWazNJqyUZy6n5Ml8jmXwVFrvqDXvkBFPzBSmn7TQMd0czyR1kF3spfGRiUsGwN6vywpIDm6aVdt4zUk6ZJV9uqG78j8T35+L5bZzEUdfB+LtzMNh+gXjgPYGMKsi0xAmICZ81cls4xDEiaa49Of4ivQ3wFIetSeCAVtV69FRPLOqKqVfYRKjkayiOnKUNbzl0nPNKpHmkjRKc5yxLeXTMQfb1ELbQ1WZn5yq506vRgu0/Jmobw4Lp/oUqvtUSjvsDeq4VdcqgqTPIclmKbhewEmEQ5v+qLELxmRr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(5660300002)(7416002)(4744005)(41300700001)(83380400001)(6666004)(86362001)(82960400001)(38100700002)(26005)(6512007)(54906003)(66946007)(9686003)(110136005)(6506007)(66556008)(478600001)(66476007)(6486002)(53546011)(8936002)(8676002)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bmkmWqiPjsidYoPB/Jw5tH4bqSgzAvg3OSsDtcMdesNzodQ6cMPwlQ8pG+vy?=
 =?us-ascii?Q?c+IDqLewDa0UZ70ubdqlmysiLXRXHQLCoqu5uH8Rlzm0cTivsCBFab69J6Q5?=
 =?us-ascii?Q?E2UqxzelOavrYzXzW/v35Yszl7s2rHQxnBowLAh6GobjSJIvGahV7RJaKQLD?=
 =?us-ascii?Q?fQqj33oWtAUB6pxCWISYwITBpixkKT6c5bk9ZbsGbfEG4r0CP7uYm96piZHA?=
 =?us-ascii?Q?37VlyPBZMI9+6b/nSrBCAYY8rPsFzbDbsymk3NK/0p4vWX5DBHaZ1we9zOwH?=
 =?us-ascii?Q?ubJbNhQKIInjgTiGcAqcZruzxbIxRJjGpRLw7Ut1qbxovwUv3yBLFhoBvy0f?=
 =?us-ascii?Q?JS6yFEvam+utGN5CvwEfsQ+yl6ZWHleX0WT8WPT9fpNCNZ6mxnRnOtpj4uwy?=
 =?us-ascii?Q?5Ln98e5OjTkxtbXQMiueAXWyDXkWNiNlXEc1DUvVbZLseuVPZi7vHo3u5FNz?=
 =?us-ascii?Q?Leg4EHf+FENe7kvBJDPQO7dMu+l/VPrvHbC6aEevJ3aKVJvrDUdd4H07JOxA?=
 =?us-ascii?Q?L7FbjuTKTS4bWRsrpyr7nbRa9kxjiAZLYsxEJN/QVp+5RK2A+BJ6cHtmB7Fa?=
 =?us-ascii?Q?PyBZcwIETO9MLwIplxDwsZitEWc4P/Mfr3LYdJEndN8V+QaqmROY2h8sSruP?=
 =?us-ascii?Q?Gd5TlhXumcjV6hzhtPQen9wm6qk9y1jFHVsthvwo1LT9yzaRCU3G+oscqijs?=
 =?us-ascii?Q?VcImlkOenKJ0ggiVjyM6jE8GZOQdqKKNvdpJ4pYbjrJ2XrHCkgjjem4NV3Sg?=
 =?us-ascii?Q?ibNf1DGASp/mzR9n3X8va3gEiduYfkAmKlzu8IrPQPSMIBPzACAFNtFpWU1C?=
 =?us-ascii?Q?Ya9x2JnIezRLJJh4QFTJewZLc2Q7JBR8S252oZJPrVF9JeZ7hsEkQG/hVOvR?=
 =?us-ascii?Q?09N3nX4QZ5Wxrmp0Jay71cmQH0rcQ2+UUTAu3L7qGagfgPGKDVHvXlos9TSq?=
 =?us-ascii?Q?AGWinJawdZgJhzlUvs5EAfUBbHUUpxC0Xt4jh+G0uOiIsX710VYN3fqtuEi6?=
 =?us-ascii?Q?MnECTzKrbL1y9DNNrK2T9r/dsS3Y2xpX+WAi5vpW5gEW/Y0uTayb5n3nsUZF?=
 =?us-ascii?Q?Xzsb2gsrCjv+TS0lMbcCl5HbTepwTWCj6tL9D2vOzhPWgmmmIDLLU9zsOJXI?=
 =?us-ascii?Q?j++m0YQJapU4lD5UBT7a0HdzYGmnYxxnIvKFq0tMyA6l7dYiH1AeQQzYN8cC?=
 =?us-ascii?Q?/KCrt59z4+kkOT2fp+ZNWQ6RSyVmmJqwc4k2JiDDSMpoNaTlxEm6/YaoygdS?=
 =?us-ascii?Q?ExAY3bKSThgjCkEmQJhta/H+2p/uqRBgKuo6VC0K7w/NB5EV/x5b78USq/+5?=
 =?us-ascii?Q?BE+Pd0bOzLN7PsmSDgEPfbb/ftG4RcHhQKHqh9QOfjeHtMchIcGK3mn9GS8d?=
 =?us-ascii?Q?VwyFrIAo+gR4WDRgWYJZihxpsBUX5DdJBovOwegwhpdR/lME/tz1hlwQ2kbu?=
 =?us-ascii?Q?9QviALOAEWT7NilB27iXV6ngXDtwbRyL/Ky7PWPvVIXrqxTlZjRSEkXs9Z/d?=
 =?us-ascii?Q?skEW5O+IHW377J1uM8HGNGKU16rQf1p7RyrClFXMUDEBrhCbOn8IJnoQdMZh?=
 =?us-ascii?Q?6G4o0038sGqigCv3j83kFX7bhougiw+65nfXv6+SYIbAvP8buDlGa3rQO2sV?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a62a6431-639c-4cc9-0d7c-08dc290ab328
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 01:01:51.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dO85l20Go248D8jVbSeJJBhxoTzTMfTTxt9ZXYhoLHpJD4zma+XO38ke0W04OU5NArSMTPeSQ1NaCXlGxc+sXM5X4LKoLCrXojNA3cEl78o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5266
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> On 2024-02-08 17:37, Dan Williams wrote:
> > Mathieu Desnoyers wrote:
> >> On 2024-02-08 16:39, Dan Williams wrote:
> >> [...]
> >>>
> >>> So per other feedback on earlier patches, I think this hunk deserves to
> >>> be moved to its own patch earlier in the series as a standalone fixup.
> >>
> >> Done.
> >>
> >>>
> >>> Rest of this patch looks good to me.
> >>
> >> Adding your Acked-by to what is left of this patch if OK with you.
> > 
> > You can add:
> > 
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > ...after that re-org.
> 
> Just to make sure: are you OK with me adding your Reviewed-by
> only for what is left of this patch, or also to the other driver
> patches after integrating your requested changes ?

Sure, if you make all those changes go ahead and propagate my
Reviewed-by across the set.

