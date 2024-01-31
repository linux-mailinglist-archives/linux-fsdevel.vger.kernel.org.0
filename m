Return-Path: <linux-fsdevel+bounces-9610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87869843462
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 04:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA0282818
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFF2107AA;
	Wed, 31 Jan 2024 03:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLzBG8O5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF64210FB;
	Wed, 31 Jan 2024 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670795; cv=fail; b=X21SXV75sokDun5yti0ycwGiZ39KpCS7TwsqtZAJa9MQvImkLbxzuzxscu6+3DjQzgKDLL/fem4JIVvxq4o5J105xgdCx6UEzianx0fqyD5Z95fRiSBq6lZr+wUAzarjcdME+v/2nrjCan4qqe8QknjuWU7xWJKY4M28/U1e+28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670795; c=relaxed/simple;
	bh=i538GwV36CPC4xlt3uxCFy0yvg6emjTOJxYtyWdG4pc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b+oU/4bVPF3L2qBahxI6V4iCs/Td7w0+sdpjqV4lmxG3O1NF9bhtNPaoTNp3er+sZnETasAK6/KF38mHEwMBMUN0w3RUfDqf8MNsn/T+lChCbsbqTkbyoQHzmc94DsDodR47bSa1XJ7+xb6pEUxkOuGuXgUM8+CYMrWUSRTlMrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLzBG8O5; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706670793; x=1738206793;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i538GwV36CPC4xlt3uxCFy0yvg6emjTOJxYtyWdG4pc=;
  b=YLzBG8O5jycLjtdm21kt04uPzKsN/r5QQ/DpvluC/WbGvXB9ddpPBNO3
   NGCJ9ed8Dmm2C50VtmuduKM2OCnopwfBIl18SE1/GtPlnp1YTE4PTZTan
   7YJ1UxveoYPEaUFpQXdFsoxtO77LaJRKE5fofJRmNyUHu+i7zyBZQD+HB
   BUr0/Ia6qs0GAo0vAbESx8+0mrWAR1WTYnCbZfHPk+ltzWEhrlhx1wpsh
   iuisCdzfM5aaYA5sLFMK/ZgEw9dGFcvS5zj2GCGekSSxsCW08pJL/LUNi
   sIIaC3QuwyY5DgvJhgc6IRXiG+uDir3oSvmNH/Rxu/jfe0ohZ8rTqNpnO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17001691"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="17001691"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 19:13:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858670975"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858670975"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 19:13:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 19:13:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 19:13:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 19:13:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 19:13:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBc54Mu1c44rxrGPUVUhYpqbVzZJlnWSdiNpWMaspIUgsbuifh3vkrJHwuym+j0/3WDLs4XANHCm1abvg/g3uFBI2w3Ux7HH5TeLDTnZVDQehrPiPK9svHCz3Ja+ZtPNv4Cfr2Le8eYcOG1X71g/d3/kwQSQ29ClAw/rY6Qy/4kvSCRNLfl9ymy1uw5UnV9AkWCFpmhHaehpOx3rpvZs/CZSY5D8Fli8juRwKpU959Lwc5u4u6kWPNV0NQSpeHJAM4DZs2ij26EKvswr9I4L3SBWWYL3uKegfibSd1FDo2X1A9CqXlNLLawFO9DiIAvk4ofzzKWUzWdrLjRV9UyUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X780JI5Xsj+7yZEfLGUFUJNISnyXfXUFQ6EZS2GoIjE=;
 b=l4EQZYaeR48luLXCNl9k1YeAjRg6TamSc9iUYqw+5CbBM2I4/NXRRCKbLaLBUwqAxIlThVqIkEtKUF3pWEmkQDittL9C/PHkOmpurYkG1JzHC5HKxSoqCmKGiBpUAo2P8fZlY9bszs6NUtU3R84i2Qrp0k80lYH7VNNiESx/sOugDgPYPim7iGDtgvqbu9N79roOhAEqdrWqthyjhE7b5hca9Rd2yaO84fFmX71lNG/i3XIHptekG4wMwrZ7zl/O9Mj9m8fjSurRftbq2MMJR+y/864DeefmJAacHtpXPqFbxheQKckzMTFIYqUPlb1eQBkrjlOVWJNB/CuHRZG14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 03:13:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 03:13:06 +0000
Date: Tue, 30 Jan 2024 19:13:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Chinner <david@fromorbit.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>
CC: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-arch@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 8/8] dax: Fix incorrect list of dcache aliasing
 architectures
Message-ID: <65b9babf6b3de_5a9dd294de@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
 <20240130165255.212591-9-mathieu.desnoyers@efficios.com>
 <Zbm2eS/AMlmhm8EW@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zbm2eS/AMlmhm8EW@dread.disaster.area>
X-ClientProxiedBy: MW2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:907:1::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: e100dab7-843d-4c85-14a5-08dc220a8b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tnhv2tlEXlNFdwXnZ6j+MMqVWkuNEE7srhn406t2pVendERn3n1CtwxFYfDrLFbDdOYFp7cb+k+8adhZBlHn2DpTmtatkywhdQN6pI4IZqsD7jgv2KSppa/akuo9O0we4SZtMWospdXiqOx/moeh+p1S1scyVcZuCxr3EklnF/v5iE9M4Z596DE8zSLWxit51XJh0L/BFo39SiCau4QkAKiZA3ovuMo3/ZoBzX8kUcxWs0mPzDbZbVFoPkHS3YH6fcKodbfnnVD8SpYZ4PDaHX9C2Ky+G3ZxB+z2QtiZ5ImvcUTnFjA67e35iRdO9yLzvIj+R9dkJ3PZIM+9kk71IqQVxjb+t2tShssMlYZ92Srb89WocPMSV+NNS4NDwWu1AYffwuMYQA4OwIh6k3g2my4tcpwGCj1SntTa6JVsyjJvR2B8HhUaQFVk3xMkZ9QiGud4KrS1cJIuWMdQc3CEEDI5D+ym7ynbMV80TOxCRgSIuVhn+nTdzVg7fXf55Us1Qva5MNJqi+aAqq7+tg+HmRKrvmnqHrp5AnDdUagCH/UpZWMJlnErNcdtUKKyJQF0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6486002)(26005)(66476007)(6512007)(83380400001)(478600001)(66946007)(9686003)(316002)(54906003)(110136005)(66556008)(6506007)(6666004)(4326008)(86362001)(5660300002)(8676002)(8936002)(38100700002)(82960400001)(2906002)(7416002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lfVC0cp+HqyTzLtRl0v/bnPNhjx7hUzehDtArC0jzgrlwYAPRlcXy1uioBIP?=
 =?us-ascii?Q?2fZqP6kOq2zQ1zVHZDBBmVORwhsGt4nEctGjtOrwWsevzeC8IH5K31xgFlzG?=
 =?us-ascii?Q?tO0ionj+nLdExCkmJM+X5cvJWHP7DQbMqqQfY7JI53nYXZ6/g8EUa9ZDCxgr?=
 =?us-ascii?Q?UNLX6m+6EETff4ETSJNZOjsixxpptW748gzBsvbKm3LCu0uagpRctzUTyrt/?=
 =?us-ascii?Q?OVedPU7MsGKkhytwJivbupkp5+/6fBREUQm8CPKTfsR60n7wF+fV5gGuxFPA?=
 =?us-ascii?Q?nPSfOYVC4NUu2h8yMpBelUp09siyhhq7k0dqZZKEX+Q0om8mn8FMzsz7Cold?=
 =?us-ascii?Q?t8kQbm319BFkHqkGq4VwqEjAc0Vsyj5JerDjY14U5y85xDQ+3fpJBIU4flTO?=
 =?us-ascii?Q?4ATQfGPnW01TfEJmn8a2LWt7ww1QC9tP27Tb8GP9DzpMNIHqpiRAjPF9zJTi?=
 =?us-ascii?Q?rWfwvSFK5yyCsZtw3reN8wl/IdGqlp2D0SLVkt6o8ERmU5lVL9vlA6eiRBf8?=
 =?us-ascii?Q?PCrdfsLT5qtIgfdo1VFj7LboH+uLCwImdWJHFKjpQi34hN8UK7by5jmwtVJ7?=
 =?us-ascii?Q?PgpoRcJ6ziL+OVnURYRzfF0H3rhGmoWKgXKfUuGfMHqrDUgaP/ATRpGkDDqs?=
 =?us-ascii?Q?i1Bg+0gGOz8GnjegqtFmQT7VDSfvBO9YEBTmuKTRaG7schJCBaJAYrWiqYjH?=
 =?us-ascii?Q?L34px405fAP4GrkWDA7nEsB06sbMf7uU/CUFAwapr2hBQbRslUX9+nWTqAUJ?=
 =?us-ascii?Q?zwYp+WE4XmByJi9kekD52Aw1e7ARcIjp6Oed0KuvANDe1jz4JtdE+D3CWaTg?=
 =?us-ascii?Q?P/rYrHvBF4bXob9ZB41HMZrVlBQptw4hflvT+yaJxygkB2xirDYoaHJm+msD?=
 =?us-ascii?Q?BHMsBMwG58r3H2dPsiUVQtO7zcEg9E738MX6UxN+d28vPvbinKDb08r3CU4F?=
 =?us-ascii?Q?3E5jVgX6FLsONOmccEdlulLIcyrZxldEiZXuCjgXtl4M/KRuQWjxfSQO7ZlP?=
 =?us-ascii?Q?1PjXnlQAp9ubSHZKEc0rR45I3bTz2fk9XcdddoVXKohlNbvCZv3xsllTYSb2?=
 =?us-ascii?Q?hrERY4GxWrOqISUDmjiGsDCQata4bdNPi04wyf2C4rh29nB4t4bEfg7xMfV0?=
 =?us-ascii?Q?OuNNY9Qh4gCpyE0GlYnWBgABZXbjfSfyDlaRppq1XYhBtOOySAhm+LyYkI3m?=
 =?us-ascii?Q?n+6X0RzrCMZb3rDqremId+5VGr3PfkJPI9/qfmfAej7vTKw4yqfobosoHOyR?=
 =?us-ascii?Q?JgIjSM8gjMXGVO7Lyw3FTtUI0eDsuqfSIC45icUg7zo6tldVvtO+sCwaDO/g?=
 =?us-ascii?Q?Kmjj2naiYpUkLGXe8Ai5PEv335nJUY+lbmAmPJ26LZepoop/mYR6eDNW2Cot?=
 =?us-ascii?Q?SRNeg+OHof3P7Lr5biOjJzwG0Ui+3kICSP1dgHPuY9aif0Z51eHkVmeFQIN4?=
 =?us-ascii?Q?p6nEIlCwGNefRu+Cl3PHWK9TshiPaQsikF/Uud7bbD6HmKgMl2kUUKG99z0I?=
 =?us-ascii?Q?FU+KVAMeaCv3UCsNza/0aGtKUe14RQ0JnFFeCsGblv6O4z38plrWFSyV/au+?=
 =?us-ascii?Q?2SqMXJGFQvPDjmAPbXQLbjt5mo96KHkQOF3TCpebDBAfwi7PboGKbkwlWhB4?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e100dab7-843d-4c85-14a5-08dc220a8b4a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 03:13:06.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMK7cnopuTv0VGY9rpz0VjJMhExERLGu+8Fg+Fn8a8IrbDzNculJ1Prdf6u4ZoAyamJiDWPlhm0ov3agtAmNgjW/KaNDoCQ0QrkrRvRRfKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6407
X-OriginatorOrg: intel.com

Dave Chinner wrote:
> On Tue, Jan 30, 2024 at 11:52:55AM -0500, Mathieu Desnoyers wrote:
> > commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> > prevents DAX from building on architectures with virtually aliased
> > dcache with:
> > 
> >   depends on !(ARM || MIPS || SPARC)
> > 
> > This check is too broad (e.g. recent ARMv7 don't have virtually aliased
> > dcaches), and also misses many other architectures with virtually
> > aliased dcache.
> > 
> > This is a regression introduced in the v5.13 Linux kernel where the
> > dax mount option is removed for 32-bit ARMv7 boards which have no dcache
> > aliasing, and therefore should work fine with FS_DAX.
> > 
> > This was turned into the following implementation of dax_is_supported()
> > by a preparatory change:
> > 
> >         return !IS_ENABLED(CONFIG_ARM) &&
> >                !IS_ENABLED(CONFIG_MIPS) &&
> >                !IS_ENABLED(CONFIG_SPARC);
> > 
> > Use dcache_is_aliasing() instead to figure out whether the environment
> > has aliasing dcaches.
> > 
> > Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-arch@vger.kernel.org
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: nvdimm@lists.linux.dev
> > Cc: linux-cxl@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > ---
> >  include/linux/dax.h | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index cfc8cd4a3eae..f59e604662e4 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/mm.h>
> >  #include <linux/radix-tree.h>
> > +#include <linux/cacheinfo.h>
> >  
> >  typedef unsigned long dax_entry_t;
> >  
> > @@ -80,9 +81,7 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
> >  }
> >  static inline bool dax_is_supported(void)
> >  {
> > -	return !IS_ENABLED(CONFIG_ARM) &&
> > -	       !IS_ENABLED(CONFIG_MIPS) &&
> > -	       !IS_ENABLED(CONFIG_SPARC);
> > +	return !dcache_is_aliasing();
> 
> Yeah, if this is just a one liner should go into
> fs_dax_get_by_bdev(), similar to the blk_queue_dax() check at the
> start of the function.
> 
> I also noticed that device mapper uses fs_dax_get_by_bdev() to
> determine if it can support DAX, but this patch set does not address
> that case. Hence it really seems to me like fs_dax_get_by_bdev() is
> the right place to put this check.

Oh, good catch. Yes, I agree this can definitely be pushed down, but
then I think it should be pushed down all the way to make alloc_dax()
fail. That will need some additional fixups like:

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8dcabf84d866..a35e60e62440 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2126,12 +2126,12 @@ static struct mapped_device *alloc_dev(int minor)
                md->dax_dev = alloc_dax(md, &dm_dax_ops);
                if (IS_ERR(md->dax_dev)) {
                        md->dax_dev = NULL;
-                       goto bad;
+               } else {
+                       set_dax_nocache(md->dax_dev);
+                       set_dax_nomc(md->dax_dev);
+                       if (dax_add_host(md->dax_dev, md->disk))
+                               goto bad;
                }
-               set_dax_nocache(md->dax_dev);
-               set_dax_nomc(md->dax_dev);
-               if (dax_add_host(md->dax_dev, md->disk))
-                       goto bad;
        }
 
        format_dev_t(md->name, MKDEV(_major, minor));

...to make it not fatal to fail to register the dax_dev.

