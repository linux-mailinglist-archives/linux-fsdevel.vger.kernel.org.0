Return-Path: <linux-fsdevel+bounces-10060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF53847646
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC1D1F248DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4BF14AD0D;
	Fri,  2 Feb 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRAFNNwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AA14A4CD;
	Fri,  2 Feb 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895435; cv=fail; b=HujirKz6k0ACWsdTOjhN9H0kHuLV8vnbH51dL4vPffZjdt1KlciUkCpAE7GeApCDFpHZnYhwzqQJAFwKvOdH+9lB5UfkWpGgfvZu7t+RpI/SaWRhu88nrS1fX3ysW/5Xro1mADp8GxLf5Q4wd2PY2+Ve+qo5kW2mPRjrf1dk4/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895435; c=relaxed/simple;
	bh=q5GsIGFwEAB+wiR+wkv7RSbPEEQI1N0iud4dmXtfeK4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H7+FTGnBoDJIiobRSfI2OG6YVFTj9q98nXhP/IM1bs82JCniqEFw7F7WwIoKWLXZRvGpPuhw7fc/Qyczz/fuXBu95an5oLSVeB3QTMZ7dWN3oBvh860wm0g2ulXQdGLPnP/yuuQ6aVEH0Bf8nCpxmQ8crOv3leiZxUvlWvkb3ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRAFNNwq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706895434; x=1738431434;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q5GsIGFwEAB+wiR+wkv7RSbPEEQI1N0iud4dmXtfeK4=;
  b=TRAFNNwqDtD27ZsLV0b0XWHAQZ6fI/h2KOH5P0j9WCpNUyokoD3hwUUw
   IHRrSB41CxYiih/QaXLdv6X93Wszlyz6NZtT6TyGSlLoIPiXBKWIS4Jfi
   OIGou5mdpOOHHjOUC/ReHKMjrZBxnqM7MwZqcgmC814tGtAZ9tUwJLpWb
   BuA0pEdsFaap1IDqki58ISRCBvoEIqY8yYoL/qj7P8tQgUFahm1tAPKrW
   QUC1w8G4ek/0DWgLTOu2oQhTzgdKVmxHdMQCDUCyhjvR9zhEzczplYVeK
   x8p9DXf8pDLEK5lZa7oEp7E4KwC/GXXgLHFL8fzEk169y7MS0jIamBDEj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="114609"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="114609"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:37:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823264488"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823264488"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 09:37:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 09:37:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 09:37:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 09:37:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQWLGxspVnIowFnQkzCkxcekhQgIrTGWn9yYQtleqBaXXDWKdKbvFvhXAaXR+YVB0QQDHUDsNysW7lS2oi+96GSoy6jQ3WtaztDzxqpxabUyva8VtUm24bd77g7ko2WEVHC5zD59mLHoYYaT/Azex8oGlI1tAzGsVq4gallaN+xek4zNJh4UAlBzMnB+yI4hveOmqPehcdAWhv387zhLqjFVSeffPXtj6AlADyObDU8wu6tcqgNG3EbCekW5GIUwBzItS/6hKoyto65m/AilEtTXmhp2l+Kyga5Y+pxG1+Mp1VfZGWjt5zj00dAKKJK4qjyPsmCKWaKldBzCKP/UOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uLjFgoQBM4AyB3Ics2816hgtgIPB6mh3fPF1MI5S5c=;
 b=DzVhcf8gcgEPr0Nxjkc5FJHoqCvePbpD8hkXqnWwVIQJF1Gh89u8Ty3Ba/8J4QLpYtoI/MOBMwOEH7xyxwt6X5YLkgCQJWBrOUUZvaYBpQTIJwo/y4DyIiAGCv8D4lZNsJKnHryavl1BjJQkMGTID8cglDTuPpoImsnEKVOjr+Us0j5McCiDITd/Q8Dggil4LCB7lDk/2je2dONNUs21nileSro5joO+Bvcny06rpIK3TjPlFGSK4NOf4uVOe6RxileWJG0qsUztfkb00nOIxywMA7naGkc5wsvUrGI8iwmkKrzoml27TTAj+gLx8FrZqJfAxSQ3irxFKlT8NvZjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8706.namprd11.prod.outlook.com (2603:10b6:610:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 17:37:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 17:37:08 +0000
Date: Fri, 2 Feb 2024 09:37:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-arch@vger.kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, "Russell
 King" <linux@armlinux.org.uk>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<dm-devel@lists.linux.dev>
Subject: Re: [RFC PATCH v3 2/4] dax: Check for data cache aliasing at runtime
Message-ID: <65bd284165177_2d43c29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
 <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
 <0a38176b-c453-4be0-be83-f3e1bb897973@efficios.com>
 <65bac71a9659b_37ad29428@dwillia2-xfh.jf.intel.com.notmuch>
 <f1d14941-2d22-452a-99e6-42db806b6d7f@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f1d14941-2d22-452a-99e6-42db806b6d7f@efficios.com>
X-ClientProxiedBy: MW4PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:303:8d::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: e80525e5-2350-45d3-88c0-08dc24159486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teJJUUpLzDq8sc10qKt7WS59dhD3Qum+paWwLATdPEEt7Fow9UULSl/rU7NKcVcf02MAsvYs9U/yPFWYm8mt1U2HH6k1f3izyNdLt1wip+aoJParwpAyY2n90NByS6yYWs8QQEKcVVbuJVbLgod0gSfFM2Id43GqxVRTOUxOAb1Jz0nGBOIOgBoxOQzzf1DTaM93IpDSjtn6Wnrsxe+z6J/6wqqoDuhFJL61kv05UIKdiohNbPRom86TvBi9Sv2IJmp0+lEfYQOBsvMiMXrlaNBvKxrCpET6Uy9C5Jxm1rjL/XHvqQ21toih2nATD93ZCwQAqhHqqrg1xOsgPnUHZX5k2hqSG/pUu+4ECABEjUgtCNVs1wZ09VW9/c1UVqPzmrxL03irO6YaYvcmbG68PQRVwT6U9biIYyuG5+h8UUv1PX2aVLGYb3AkmM0Q3lS3XzOzS9s7A2wBuCv5+qIHYCA02YBHprxhkwaHnCxwO6O8Dx0gxGmo2kdfn0rFjwCVtn2jJMxYPGkjIL0g6XurHF1VH+trgwHPr2tgNglYBtOlVVS9PA1uV8sF1sr7qgGI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(86362001)(82960400001)(26005)(2906002)(38100700002)(6512007)(30864003)(9686003)(6666004)(66946007)(6486002)(110136005)(6506007)(316002)(4326008)(66476007)(8676002)(8936002)(7416002)(478600001)(41300700001)(66556008)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uYKEP0bKUqi7tzpPXnaG/Njg2fdyIb0RKOEvF+Fn0017mK2H8O21CL60c7bt?=
 =?us-ascii?Q?qk4HCJl4YYYizAfOlM70ydtrj7+nehjZ1ZhsDEZsH5+1LZdguw9a3V97e1Oy?=
 =?us-ascii?Q?h+KsA4yxnGXwPeFYOscDlGkO6Q1tio8ymysWYE6CM2KDzKOazxEpGM8dFltM?=
 =?us-ascii?Q?WgFUH08XdrzNG3Hs528OK5fJ6IyZ+nIJNMYu+lwkb+t3cRGaMBerjDICTLUo?=
 =?us-ascii?Q?L1XRmOT6008xPuwlshitilUB+ZWCpgjtBucM+T8x1X3wGE8InRtMpU6MLQ2q?=
 =?us-ascii?Q?ai5JiNLv8oZuxC07MMN5vG36SWMfRdZplAUN0p3K6nMsWNo8rXDC+ivgdouj?=
 =?us-ascii?Q?FINDL5bUcnBF2Cor11SMc4/rOsg6rx3eneb9fBwhEaISOtUHHCUfQQaaUCad?=
 =?us-ascii?Q?S3+9aduCiS29U6Pq10MLK2a3NkUC3ZKg/u0xOqYEf39WB0COG7EaOayBgLVP?=
 =?us-ascii?Q?kElAWNGW9i8V0x4wrgFPtk2RuhDajbmK7hTWz3Lmqp6cssBLzUSNSeNMnwhS?=
 =?us-ascii?Q?c2b1jbn9gtvZk12FJouJKIIZz7tYQ3wPkByngXjlH9AcKRDEX9th2Z9i3Ef9?=
 =?us-ascii?Q?Kw4/wOXYjMDMaToYqgxV/KrJ5uV3IIkjDbDct6L2JyQ/rSNVKmav35J8lAcH?=
 =?us-ascii?Q?oVW6wTKFvMgtiHoFQ0xg5HnA6E1JNv+ZDY61xdhrXdxbn1vsRScBw26dGzBC?=
 =?us-ascii?Q?Ojvp1b1QBzE8lM8c7sXZjnRXLr5Y4bszWb1dvL+Ta/HTP1QqMsvotz0kxumC?=
 =?us-ascii?Q?Zob6c4BFAoGi8Ar3XFw7+R3kACP1RBvvdShATYbOEegwojPKv0wK9WIFB9d7?=
 =?us-ascii?Q?zrsdhNE/UgErxeI1KpJB5XCBSoLB3uFqyPN31g3cisKegTDnUAPoEVhmfzqh?=
 =?us-ascii?Q?UgBn/DPl+r8HAqh6tJOyiqiC0I2fb4QmIDZ4kcpsAAT4+N/7GNYiGX2ED6Io?=
 =?us-ascii?Q?I+bPmBBYDKSeCeJ3QUuIlTH6w4iquyhyS63uiit/MXSlnDLUUcCAK4z3fwQZ?=
 =?us-ascii?Q?GO/FWCQ/MQ2vD9b6hGcIbGGaRdDA/nq9gJ79UysalbyZHvU0d+6XA/KDB/MC?=
 =?us-ascii?Q?FZ6h5rMN1QIQqQs+lvkuhL6B1SHG0C61bRDtaiL0j2RK2AZN2H/lBqu93DcZ?=
 =?us-ascii?Q?ERYGkCUWu1Zqtp59/KstwiG+9DcqBx8HglVNGH++40tN8o5YDJyowinr+DE0?=
 =?us-ascii?Q?xxvBL4oJ+F2TE/MqeNxt4qDI/3lkOEJIdw1piNLwVS1UMeKmx7pg5QFfdarT?=
 =?us-ascii?Q?KBk2It9QKeJ6fmITEQAEgRPCRvJTL7SKPe60FNkiScLkrEqA5lYQ6z4B0XrZ?=
 =?us-ascii?Q?zPdfKMr3BkXrPWQaD1if4NP9J0FSyRws3FiZIxtioS1Gyj8iZKOZRnaC1QuX?=
 =?us-ascii?Q?nLy59INnYTyXN3/ftNujdpRnjQwwAG/NcKYISQiGlpa8PxBfMCDz53BIFrH2?=
 =?us-ascii?Q?/5qM8VspxlQMCsXKACVbVYRv2XqeFEkH7dm1jubkR0YM41XrdNMG4VGhDW4C?=
 =?us-ascii?Q?tTsBJHtqMvFyUDCBNH6Nt6gi69ePnTZpxoMYR9W2KcJEg3RSSBWy8dYfCrkV?=
 =?us-ascii?Q?j2qeqCCrSLF/i2lzhro7cWxaw/g4ACOvoSICFYS812gNmI2MDePHdDrExuL1?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e80525e5-2350-45d3-88c0-08dc24159486
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 17:37:08.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZJhuAw/6xEA6aqVA1gJkXLFbaX7z3BOR3yxhRIccRc5E3bHTkGQjhSQ9ZG5Pb8UcHwTUPOw8nqD1jiakkAlzAeXiXdNlCESZ3NxpQx3a/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8706
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
[..]
> The change for -EOPNOTSUPP in header and implementation would look like
> this (more questions below):
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b463502b16e1..df2d52b8a245 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -86,11 +86,7 @@ static inline void *dax_holder(struct dax_device *dax_dev)
>   static inline struct dax_device *alloc_dax(void *private,
>   		const struct dax_operations *ops)
>   {
> -	/*
> -	 * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
> -	 * NULL is an error or expected.
> -	 */
> -	return NULL;
> +	return ERR_PTR(-EOPNOTSUPP);
>   }
>   static inline void put_dax(struct dax_device *dax_dev)
>   {
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 8c3a6e8e6334..c1cf6f0bbe12 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -448,7 +448,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
>   
>   	/* Unavailable on architectures with virtually aliased data caches. */
>   	if (cpu_dcache_is_aliasing())
> -		return NULL;
> +		return ERR_PTR(-EOPNOTSUPP);
>   
>   	if (WARN_ON_ONCE(ops && !ops->zero_page_range))
>   		return ERR_PTR(-EINVAL);
> 
> > 
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index f4b635526345..254d3b1e420e 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -322,7 +322,7 @@ EXPORT_SYMBOL_GPL(dax_alive);
> >    */
> >   void kill_dax(struct dax_device *dax_dev)
> >   {
> > -	if (!dax_dev)
> > +	if (IS_ERR_OR_NULL(dax_dev))
> 
> I am tempted to just leave the "if (!dax_dev)" check here, because
> many other functions of this API are only protected by a NULL
> pointer check. I would hate to forget to convert one check in this
> change, and I don't think it simplifies anything.

It's not that it simplifies anything, but mistakes fail safely as a
memory leak rather than a crash.

> The alternative route I intend to take is to audit all callers
> of alloc_dax() and make sure they all save the alloc_dax() return
> value in a struct dax_device * local variable first for the sake
> of checking for IS_ERR(). This will leave the xyz->dax_dev pointer
> initialized to NULL in the error case and simplify the rest of
> error checking.

I could maybe get on board with that, but it needs a comment somewhere
about the asymmetric subtlety.

> 
> 
> >   		return;
> >   
> >   	if (dax_dev->holder_data != NULL)
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index 4e8fdcb3f1c8..b69c9e442cf4 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -560,17 +560,19 @@ static int pmem_attach_disk(struct device *dev,
> >   	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
> >   	if (IS_ERR(dax_dev)) {
> >   		rc = PTR_ERR(dax_dev);
> > -		goto out;
> > +		if (rc != -EOPNOTSUPP)
> > +			goto out;
> 
> If I compare the before / after this change, if previously
> pmem_attach_disk() was called in a configuration with FS_DAX=n, it would
> result in a NULL pointer dereference.

No, alloc_dax() only returns NULL CONFIG_DAX=n case, not the
CONFIG_FS_DAX=n case. So that means that pmem devices on ARM have been
possible without FS_DAX. So, in order for alloc_dax() returning
ERR_PTR(-EOPNOTSUPP) to not regress pmem device availability this error
path needs to be changed.

> This would be an error handling fix all by itself. Do we really want
> to return successfully if dax is unsupported, or should we return
> an error here ?

Per above, there is no error handling fix, and pmem block device
available should not depend on alloc_dax() succeeding.

The real question is what to do about device-dax. I *think* it is not
affected by cpu_dcache aliasing because it never accesses user mappings
through a kernel alias. I doubt device-dax is in use on these platforms,
but we might need another fixup for that if someone screams about the
alloc_dax() behavior change making them lose device-dax access.

> > +	} else {
> > +		set_dax_nocache(dax_dev);
> > +		set_dax_nomc(dax_dev);
> > +		if (is_nvdimm_sync(nd_region))
> > +			set_dax_synchronous(dax_dev);
> > +		rc = dax_add_host(dax_dev, disk);
> > +		if (rc)
> > +			goto out_cleanup_dax;
> > +		dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
> > +		pmem->dax_dev = dax_dev;
> >   	}
> > -	set_dax_nocache(dax_dev);
> > -	set_dax_nomc(dax_dev);
> > -	if (is_nvdimm_sync(nd_region))
> > -		set_dax_synchronous(dax_dev);
> > -	rc = dax_add_host(dax_dev, disk);
> > -	if (rc)
> > -		goto out_cleanup_dax;
> > -	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
> > -	pmem->dax_dev = dax_dev;
> >   
> >   	rc = device_add_disk(dev, disk, pmem_attribute_groups);
> >   	if (rc)
> > diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> > index 4b7ecd4fd431..f911e58a24dd 100644
> > --- a/drivers/s390/block/dcssblk.c
> > +++ b/drivers/s390/block/dcssblk.c
> > @@ -681,12 +681,14 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
> >   	if (IS_ERR(dev_info->dax_dev)) {
> >   		rc = PTR_ERR(dev_info->dax_dev);
> >   		dev_info->dax_dev = NULL;
> > -		goto put_dev;
> > +		if (rc != -EOPNOTSUPP)
> > +			goto put_dev;
> 
> config DCSSBLK selects FS_DAX_LIMITED and DAX.
> 
> I'm not sure what selecting DAX is trying to achieve here, because the
> Kconfig option is "FS_DAX".
> 
> So depending on the real motivation behind this select, we may want to
> consider failure rather than success in the -EOPNOTSUPP case.

Ah, true, s390 is a !cpu_dcache_is_aliasing() arch, so it is ok to fail
driver load on alloc_dax() failure as it knows that ERR_PTR(-EOPNOTSUPP)
will never be returned.

> 
> > +	} else {
> > +		set_dax_synchronous(dev_info->dax_dev);
> > +		rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
> > +		if (rc)
> > +			goto out_dax;
> >   	}
> > -	set_dax_synchronous(dev_info->dax_dev);
> > -	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
> > -	if (rc)
> > -		goto out_dax;
> >   
> >   	get_device(&dev_info->dev);
> >   	rc = device_add_disk(&dev_info->dev, dev_info->gd, NULL);
> 
> My own changes, if we want failure on -EOPNOTSUPP:
> 
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 4b7ecd4fd431..f363c1d51d9a 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -549,6 +549,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>   	int rc, i, j, num_of_segments;
>   	struct dcssblk_dev_info *dev_info;
>   	struct segment_info *seg_info, *temp;
> +	struct dax_device *dax_dev;
>   	char *local_buf;
>   	unsigned long seg_byte_size;
>   
> @@ -677,13 +678,13 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>   	if (rc)
>   		goto put_dev;
>   
> -	dev_info->dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
> -	if (IS_ERR(dev_info->dax_dev)) {
> -		rc = PTR_ERR(dev_info->dax_dev);
> -		dev_info->dax_dev = NULL;
> +	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
> +	if (IS_ERR(dax_dev)) {
> +		rc = PTR_ERR(dax_dev);
>   		goto put_dev;
>   	}
> -	set_dax_synchronous(dev_info->dax_dev);
> +	set_dax_synchronous(dax_dev);
> +	dev_info->dax_dev = dax_dev;

Looks good to me.

>   	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
>   	if (rc)
>   		goto out_dax;
> 
> 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 5f1be1da92ce..11053a70f5ab 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/fs_context.h>
> >   #include <linux/fs_parser.h>
> >   #include <linux/highmem.h>
> > +#include <linux/cleanup.h>
> >   #include <linux/uio.h>
> >   #include "fuse_i.h"
> >   
> > @@ -795,8 +796,11 @@ static void virtio_fs_cleanup_dax(void *data)
> >   	put_dax(dax_dev);
> >   }
> >   
> > +DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))
> > +
> >   static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> 
> So either I'm completely missing how ownership works in this function, or
> we should be really concerned about the fact that it does no actual
> cleanup of anything on any error.
> 
> I would be tempted to first refactor this function without using cleanup.h
> so those fixes can be easily backported to older kernels (?)
> 
> Here what I'm seeing so far:
> 
> - devm_release_mem_region() is never called after devm_request_mem_region(). Not
>    on error, neither on teardown,

devm_release_mem_region() is called from virtio_fs_probe() context. That
means that when virtio_fs_probe() returns an error the driver core will
automatically call devm_request_mem_region().

> - pgmap is never freed on error after devm_kzalloc.

That is what the "devm_" in devm_kzalloc() does, free the memory on
driver-probe failure, or after the driver remove callback is invoked.

> 
> >   {
> > +	struct dax_device *dax_dev __free(cleanup_dax) = NULL;
> >   	struct virtio_shm_region cache_reg;
> >   	struct dev_pagemap *pgmap;
> >   	bool have_cache;
> > @@ -804,6 +808,15 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >   	if (!IS_ENABLED(CONFIG_FUSE_DAX))
> >   		return 0;
> >   
> > +	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
> > +	if (IS_ERR(dax_dev)) {
> > +		int rc = PTR_ERR(dax_dev);
> > +
> > +		if (rc == -EOPNOTSUPP)
> > +			return 0;
> > +		return rc;
> > +	}
> 
> What is gained by moving this allocation here ?

The gain is to fail early in virtio_fs_setup_dax() since the fundamental
dependency of alloc_dax() success is not met. For example why let the
setup progress to devm_memremap_pages() when alloc_dax() is going to
return ERR_PTR(-EOPNOTSUPP).

> 
> > +
> >   	/* Get cache region */
> >   	have_cache = virtio_get_shm_region(vdev, &cache_reg,
> >   					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
> > @@ -849,10 +862,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >   	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len 0x%llx\n",
> >   		__func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
> >   
> > -	fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
> > -	if (IS_ERR(fs->dax_dev))
> > -		return PTR_ERR(fs->dax_dev);
> > -
> > +	fs->dax_dev = no_free_ptr(dax_dev);
> >   	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
> >   					fs->dax_dev);
> >   }
> 
> In addition I have:
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index f90743a94da9..86de91b35f4d 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2054,6 +2054,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
>   static struct mapped_device *alloc_dev(int minor)
>   {
>   	int r, numa_node_id = dm_get_numa_node();
> +	struct dax_device *dax_dev;
>   	struct mapped_device *md;
>   	void *old_md;
>   
> @@ -2122,16 +2123,13 @@ static struct mapped_device *alloc_dev(int minor)
>   	md->disk->private_data = md;
>   	sprintf(md->disk->disk_name, "dm-%d", minor);
>   
> -	if (IS_ENABLED(CONFIG_FS_DAX)) {
> -		md->dax_dev = alloc_dax(md, &dm_dax_ops);
> -		if (IS_ERR(md->dax_dev)) {
> -			md->dax_dev = NULL;
> -		} else {
> -			set_dax_nocache(md->dax_dev);
> -			set_dax_nomc(md->dax_dev);
> -			if (dax_add_host(md->dax_dev, md->disk))
> -				goto bad;
> -		}
> +	dax_dev = alloc_dax(md, &dm_dax_ops);
> +	if (!IS_ERR(dax_dev)) {
> +		set_dax_nocache(dax_dev);
> +		set_dax_nomc(dax_dev);
> +		md->dax_dev = dax_dev;
> +		if (dax_add_host(dax_dev, md->disk))
> +			goto bad;

Looks good.

