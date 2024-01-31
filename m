Return-Path: <linux-fsdevel+bounces-9712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A549684491A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC951C23728
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516E839856;
	Wed, 31 Jan 2024 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPvk/XKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17B38382;
	Wed, 31 Jan 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733775; cv=fail; b=eLe38MgURg08wNrj4gLzkqJ4iIsn9NgAgJNrbMSVeoKGKmd2C5iEm3Dtu4jlPCedN1aQGDqKbhTOVW6Z1cM5aOFasc228EfnsAqtpUg42/CTr/zPQs4bf1diGlPeBtyZqUcBg76xyd+bkeWTogwF7O7j82rRTC0mOlTe+yMalXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733775; c=relaxed/simple;
	bh=I5beWVQteC7QD+F9SSBOhvnRZeAQvtr7Sy2VM98xXLs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Inys/vEyPr5OAFzajMzxwEJyqy5qr9Ce4e37w9QIfERNNSZ8EeEPTaQN2rOgMbvN4NzAU+/DOm8zIxuK7mwBTvA7gUtpx7BxMLqtZ/vGqNDo5ydJhv9TzG8pHndDcYBRymdnwTvhFOXaq5j3FZgiHn0dqr2NvIwHM++U242vqPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPvk/XKC; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706733774; x=1738269774;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I5beWVQteC7QD+F9SSBOhvnRZeAQvtr7Sy2VM98xXLs=;
  b=cPvk/XKCCSyBPJtf6X0FdBWdO0dkaM7LYeS5wxMMhnq4lFvc4TViH51r
   tsKsewO8D7FTQn6aB0ryhM6cgJFhvcYQi+r4fFQVc6Fp8jRJP256kS8D0
   Tvz8KzoXAZQhzboyCsk6xrRY83MLBeb89IQH4bE8E6mHP6Oz8533q5W8h
   GR1n0GbilLOaBy0ioJSI3ZG38Drcpv2Ec+RWuzYmYJFIlA96m+kXXRxRu
   Az2dQVnr3kC6zvl8kqgWnVyLBHsU1rt/WVQp9Ot1pqqn0OYvFM18e44MJ
   Bk+pUYvjD6UV2fkEnGc1DfsPY1UskmHCmo0OapiDURtTquzQpdevXQljq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17104944"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="17104944"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 12:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788709226"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="788709226"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 12:42:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 12:42:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 12:42:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 12:42:49 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 12:42:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3do1eenfdO5xO7l7zas0416HgOGTie7OadcZkmymqnYLTF/dGZRcZkZFG55cM7Q2A45DLf/YyyEEbJgTcvKqs7NUgl533IPdO/BMFAOY4OpkVmREhbNdhNqDdNZdr8YayKEPG/cfdWcxOjL1+X/587SmchHJfRy5qYPSQngvkvA4vMgA4IjJZM0Veao9t46GdCLtO9heUmB8nmIoDWZCB+XcHRH/wRFhhKhk11HSSUXZ1zFJmLCiCPV4rH39CN2QcH6rR69JZNYP7Qa8HWUROOrOr3WM54o6NtXRFdQ3fpjynG11ViFvw+Z2FQzvXQfJhDxe6QUHuDWY+VTvQXrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xya12SJnb/yBXtvZ/+c1DZxyqOZAKEvH7OxqLwSflhI=;
 b=hvd+e50zi8T+Y/hfvcrU4dIC7BtLMiyKUWnE4cszSiYfLsqX2dFCOfyOX4JtRc45bzDTepkAcSx0Ygnaj5OkRUbQWtF/6nZXj8C4KHGMsh1Q1hSrOXrkb+w0F0Dgn3KTGFU3aMutglSDqUt6i4dwvRDAUQA50ozSa5D1J9bGlaOXgn96Ka0a/Dtpy1kitJhoCG7qsMLtngeFxVu63X3aztkcvoLZI15dTA75mP1A1X6r/7bxj36ZmiozVrsXh3ZpDrDSEsHo7rZWZisKLoZmhizj5KmVhlDXcuNq5RSpK2HU8BPZQzuF1aYCZL1DMxtBRcJb/COx8gm4Y5qOnrh/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 20:42:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 20:42:47 +0000
Date: Wed, 31 Jan 2024 12:42:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christoph Hellwig
	<hch@infradead.org>
CC: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>, <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-arch@vger.kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, "Russell
 King" <linux@armlinux.org.uk>, <linux-cxl@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<dm-devel@lists.linux.dev>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 3/4] Introduce cpu_dcache_is_aliasing() across all
 architectures
Message-ID: <65bab0c4714ec_37ad2945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-4-mathieu.desnoyers@efficios.com>
 <ZbqAl3gerwe2o6jy@infradead.org>
 <64e4a411-f35b-4e29-89d5-310420df4884@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64e4a411-f35b-4e29-89d5-310420df4884@efficios.com>
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 89849125-2a95-41d7-f947-08dc229d2eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynZi1c0JTwndu7k1fi6cOMBN2s4uD+IcePGQywN4ale1Hjj1Q3zZVYv9sgszQO/JPughIJIYF6Lk9q/4WNIQmA3lvVDQYD+iakkfIDKMgBYtnDPaq/HlZiAISb7e3JErVx5Hsk1cWllBcFWSwVuPTZrqvIzrMxMg4iQLtTB2jbX61FDl00J38ZXKFb5owrqhA+cLgKX6aQtITMmHSCQqmn84OEasZD6QaGqZIqz/atAgCGd/5YKQsl4NXDiUuy23YNarVRCvw5zJYbzU/2dRyr74z1bIPaWtmN3k3j2XDBnnSKegzW9V+OZ6CxR1iLTBVj5Ss3ZhtlhQtlidYuhvCJNmi/PHc109oAqI8VMdT9XEV/0lxn5y2TaaBLGfPs077/Zul/jjKA3DrGREpmeqZMZ8r2j8ST7tETeoBmcn5ecC7r7TRuPg9zt3ibO8TjMtwwwX1amLL+YWJj9PeljyYZvkgyi8LUkkk77rOmcJfVd49FhwzcmsHgHatyIJsG6EEGo8s9QaCWfVXIDHWqCRAi1NyaXKvUjm5Fx9c7z0Hvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82960400001)(86362001)(26005)(41300700001)(6512007)(38100700002)(9686003)(53546011)(6506007)(966005)(6486002)(478600001)(2906002)(316002)(110136005)(54906003)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(5660300002)(7416002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P4liWkSgwz0WSlXWofInVMmfiNm41DisQwXOzXpVrGIlSlLXzaCNVx+WhrHk?=
 =?us-ascii?Q?D/j+m2G+LGlHjSc4glrAX0s7wgewRj83fV3rMcM0fn2u/LZr6uCouYLGfcYh?=
 =?us-ascii?Q?RXK5If8xx1yWmUzQqcZ2aUCkTOZgh7zVUPKgYO1pUoddrOYBYUG59I8COOld?=
 =?us-ascii?Q?1LvbehvPFJpAeFG6SUl4+klxVFa0tgMDXzNVVrYKnufC4y6wnNHtem7LveS3?=
 =?us-ascii?Q?2tBQcP0iKdS2JSpNsHQoB6furo1DdqFo+98z43U0pNLeDeFzOPV6xqJlKs4A?=
 =?us-ascii?Q?/ya86iPAyZtVLYKhNQM90DTbEXTdo/tm5A/VxoM7oSqLo2MsbncwLv0MApdI?=
 =?us-ascii?Q?/NulWk3Ri4chPkWhXkD5VTd1DaKwkjkuoefPWttyWQGOkf+DPsMc5mA/OCJL?=
 =?us-ascii?Q?eir7PBcd5ukDQCNWPcpTW6SDnSdhkGsowrdHRcduRPlwGhZrYiGHeOAZYkAI?=
 =?us-ascii?Q?D22wZW+1jOMQuqJEQ8p0Dzptbk6IxyiKW14+f6rjSekQKIGAza69JsHujwPz?=
 =?us-ascii?Q?hdJcV2GH0xJ8voiNFrieRtl3PoZdgpiELEek8WJRYnNdzbCv9jHa4M8TwcDz?=
 =?us-ascii?Q?68fN4uTKb9BDN4JsiVTj3e4SZIj0hd2l95fO4XTkqB8hLNNibHYhRz0NlUgd?=
 =?us-ascii?Q?uLADY/OOP8VpQ1p7FLpILz7wShhv6jMhmM7+Uu5A4C28LdEXc6panHKBPaKR?=
 =?us-ascii?Q?5sxFEFl+yNraUMzpKNSWajrTGlmX+PgyXpjVpYNakrv+KWRBb6t4vaN+eSTp?=
 =?us-ascii?Q?21Hyk3xJgvfFWKC8F9U5z4N2iY9LV3aAgV/eUTNNTlPR/yh9BQB3QZGFjP8d?=
 =?us-ascii?Q?+ob7KU15sj8ihYfTWlmol8Hm8scICyp1TleQ8y4iHwWMoS6lcefa4rV/Bheb?=
 =?us-ascii?Q?WTkGZ/w7PBCczAtUOPnxhzGTqAoKPG56n9xaDqB/v4DQ+TNupw3fFuMJhtqx?=
 =?us-ascii?Q?oslhkRJ+6gDwtt2JlJ+Xf/fK7lyEgTAQpBOCic3s073JppkjEg8cW7NZ1gin?=
 =?us-ascii?Q?qYi0pI/t19upMwIjWMX0446FNdocDg6E+QLIG27c1ARSu2EILVyk1YqyFz2a?=
 =?us-ascii?Q?lp8hXmqLaZpTZD50R4FscdVYAuLhVyBrfvV/CmBpZuMIkBL2MZ3XNEUxBC1o?=
 =?us-ascii?Q?3/KFQaIM+0CTwYokO7STHZmo08N0wPEI006m/G1nu7STsYKmscjGfxSlyYu9?=
 =?us-ascii?Q?zuTLjO20bIn3JFPGT2U1z35wsoMlRH414Q3/xDnUsxpY/8IM8C4MmZmxKnLQ?=
 =?us-ascii?Q?TAsB83Rq/qhga0R4LpnqBRuM/qLiUMBQuRFI7ckAIHfzN1NsjM6F5wOB5KJF?=
 =?us-ascii?Q?Eeq7OtVt74BzVQePTrI2vP5sEydZz75Iz/artoXe0Ldpye2mrWQ25ZBOYCgg?=
 =?us-ascii?Q?AyaXdBl2LRSEenqIXptjGYOTxUvJbDiuwWf50b2g1UVXRZsXF7XU/sJ4bprT?=
 =?us-ascii?Q?jf+mC5ZBiWvgw+eRF7EF/D2L5RLd9pM9DluDSJIc8B0XQWHfa2dNkff7169f?=
 =?us-ascii?Q?EKJsIPyslOBaw3hCPnXJvcQ2XeSXFQEmIQqLVX0L57fkwZn83hOv9M+hTg3/?=
 =?us-ascii?Q?XtqXHJTacM0iDILzslRd/bdPRN8vOf6Ou1Ny255Io8Kwu3+ITf1DLNNQTTEn?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89849125-2a95-41d7-f947-08dc229d2eff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:42:47.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqOL1BeVFA8Fael5KcqNoPXNLaqGBqlqrOEBeT+fLNMAYfWUIuEvYbPSZY1N+W7A5S2BtilKl49SjuF+8ErkYmp3ACW4/jgd2KetHqu8Cy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> On 2024-01-31 12:17, Christoph Hellwig wrote:
> > So this is the third iteration and you still keep only sending patch
> > 3 to the list.  How is anyone supposed to review it if you don't send
> > them all the pieces?
> 
> My bad. I was aiming for not spamming mailing lists on unrelated patches. I did
> not CC linux-xfs@vger.kernel.org on the other patches. But the missing
> context is just confusing. And I forgot to CC linux-fsdevel@vger.kernel.org
> on patch 3 as well.
> 
> You can find the entire series on lore:
> 
> https://lore.kernel.org/lkml/20240131162533.247710-1-mathieu.desnoyers@efficios.com/T/#t
> 
> I'll make sure to copy all lists for all patches in the next
> round, namely:
> 
>      Cc: linux-arch@vger.kernel.org
>      Cc: linux-cxl@vger.kernel.org
>      Cc: linux-fsdevel@vger.kernel.org
>      Cc: linux-mm@kvack.org
>      Cc: linux-xfs@vger.kernel.org
>      Cc: dm-devel@lists.linux.dev
>      Cc: nvdimm@lists.linux.dev
> 
> Thanks,
> 
> Mathieu

FWIW there are some developers and lists that want all patches and there
are some developers only want to see the one patch they are directly
copied on. I have a locally maintained list as I have discovered these
different preferences, but maybe MAINTAINERS could carry a flag to
indicate this to save the next person some time?

