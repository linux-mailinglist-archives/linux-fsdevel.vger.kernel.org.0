Return-Path: <linux-fsdevel+bounces-9720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC5844954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A97A1F2201D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A30438FBE;
	Wed, 31 Jan 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0ivjRjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030E38DF1;
	Wed, 31 Jan 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734964; cv=fail; b=LjHfFgHYBotVHsB2lXOTrbkYLvyAHEpFfzimgf4YfSRwqG1GV3K7qoa2hWPQlYD2z0EYcl/UWe5WFspL3aog71O0Dw6z7aOzJpTQHhv+6BSXUgcgKiL5P2NAR0k2xj41mPQlh/Pc5oHX9a9I7jqeAen4D9faHcZWB6OtnL/q5u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734964; c=relaxed/simple;
	bh=a8KrKIWFalgBAC9gxi/aWImn2TjPttRO4oRESyH5lts=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EITXdkI568uzCPBjVeNf/7hPcExNcP2ycqhyvRxXyII92PO8Ua8yLao/3G8KfLFBWNeqhIBNKgsdR7ZZ+ghuJImib+oubWqZU/dAZkWEYl35gY6mZQjce1I1sz6BUQELHe3hsPNsCWzkOr7sOAuYOBW/sRnLUO1+dqgY74SBSEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0ivjRjN; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706734963; x=1738270963;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a8KrKIWFalgBAC9gxi/aWImn2TjPttRO4oRESyH5lts=;
  b=V0ivjRjN8RypYPmmW4TmHXnGgRMNe0+72cLlGJKsSOGvOoinR1yjRaBX
   1+tLngXUeiZj5Qvxsz58q+eSHmzcERwaHaUGERjgxPB2IQmIss5SscnFg
   pgXVH6oACpUV9Okjo+tMOxW5lU1a6U6GJZzi4rRak7UU9TtyOadLxWwjT
   Dpy9L0Td7wklEFr/XNGjP/ZB7CTdSMpJS3G6HjyqzIaGjNv/4CHjdaqUm
   zwb2ajKBQReUwdg8QFRY/twQONwZ8jbFwKgWN7kH5eKfLGfS0Zbx7+vFf
   Q8ZvH82xa6P8Nfb/CanS8cUJlFBMm3XbxW+waiYrKrkB+n8FDZu1dA18f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17109193"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="17109193"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:02:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878896221"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="878896221"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 13:02:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 13:02:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 13:02:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 13:02:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvjo/KbuuQHHp78c9L2xJM0UwPY0FqRMH42dIb5Svv/+OKEcOG/FMcsqWpKY3WeBVatVoWo4bFg/sRapVzv50l/Sy5h0n4tkA7zpH2GAqJpMHGaMFimPWbvBiOwKPSa+6Dy/bMO55Fhih1V4V4QweGpbT77bXQt6V283jHCU040JnOi22xMFPw+1EPs8U/nZ7AXozIZKLqWFv6KtbH8RrDcdada8ULcyy1YqDfnyQ6mUoOvaHFan71sL0AM7mUjkOqNtnqw/yJVUt44ng1kc82/Z4iRF36B5X4nDZOmTQnWI26k45cNsoHaaqzKEDZLbnVz+OdJAiHrS89BN8BF6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zr6IXfXIDFKRkqsZalTnOGJWkx072CyAb0yn8eUdr4=;
 b=mwi2j6R++30rEnHxR9i4zd1ILyyGH6dLs+l1qaNXDhLlHin49ais1R1QRexmtpyTb01kJMJd8PhcZbAXuMZWF4ZHnbAvZYZutp7IEGVUD52JyysAjRYWt4WwqfAVChoY8RlJX3IFo0nTCI7G8NRTsq0cE0I/NxRkP1brueKxmPW/rho+YwbPUN01Nod/mw9tSi3wzqEUVUrn7eEva/Xnc7xw0kc6RVN7khGw5/Xk6tg3+8D4/NZnEZwilSezxU6MViQz+UlazBCXhz2hn+XIFt7zntV120oKSvUerIZxnkflZor3HxnO93/TCLjZK9PlWR89EnhubAkMh90DY9ZrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 21:02:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 21:02:35 +0000
Date: Wed, 31 Jan 2024 13:02:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-arch@vger.kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, "Russell
 King" <linux@armlinux.org.uk>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<dm-devel@lists.linux.dev>
Subject: RE: [RFC PATCH v3 2/4] dax: Check for data cache aliasing at runtime
Message-ID: <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a1ea31-f14c-4307-fa17-08dc229ff2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ukuos4hW0e9u9CRsOX0aHXJ4OglysIkG6wJCuTos36K/pqM7Xl1Hs/MJW82P1N/59SLaFbhLqkA4dELGtdEXa+NJdy5oJrw0mc7bdZ5mtTpeQ1n1128N8ItTcIDvoQJBPR5aVLfdgLxQpdIle80ZrGGY8qhn//RyIdlnu10C6F4WWubUeDTSdGw1EzC6eAAGt8pRiXglFGY9Rqppjr/Gul46OJkkZ90xeHtJNhLLK56L4rHX3DatTVgQYHNQUWSwuFzkFsICrQ+QV2VOjGoyzri+LonsSGl6J2b0jYXs00sYfP2rM5PODhV5p1gL0B3HTJ8UXgwRa5JuxJzPxLucCLQ9fc8jvXvUO0GQ+tM1X6IY2yNIHie0N9ioe7Rs7qouyas6v7D9nZYjhOE+ivREN7U7TRUFT4iNsWgzNvVx0flaRJ1vf7TvETpLZZC91JzIiiweeLrO7FpxETwAy1jLTiIW1cvkkSqLo8aieYB4riUJpqbUrWrud8Erd/nDVbzO7FoOObiry7rfzhqHyeWLNUqyGyCaXSXHPY20VXoZYa2yYsJAsrkF2IK4ZLEh3ee4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(83380400001)(38100700002)(6512007)(9686003)(26005)(4326008)(8676002)(5660300002)(8936002)(7416002)(2906002)(478600001)(110136005)(6506007)(66946007)(6666004)(54906003)(66476007)(66556008)(6486002)(316002)(86362001)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0JTBq8UYMS5ThZbO5MlAc1c78GE68vnfbQv8yCHdxVpKjhr2jnzVTq2d22n?=
 =?us-ascii?Q?5YLZWIsJqX6DgBjeM38sgvpmnyFYRc2YyKFH9kWfToBrpfjLM2w+P9K+6oVh?=
 =?us-ascii?Q?IEzxfIzb+TydjAx2R5jG0xsmU0y+JQp4vOwx8Mrr3PzTpSfNi+V/mVB9zAuT?=
 =?us-ascii?Q?uURVfhfV7LonrDhfzVXBPZF3mSjEHp/5Utgf9mqC7oRKtWdGIPbvoMR6z/K0?=
 =?us-ascii?Q?Ef73VxG49QGfFkPOmvpKPLPhCWAEVhJjiXE0jwyIN/uuD1Md37cTCzwtNrJP?=
 =?us-ascii?Q?OTEhzqakSU4Fy/z9kK2OpxsBb2dJi+6U5BA51oFvuMw+0xR7I6a34y7fGAtD?=
 =?us-ascii?Q?Av2AH4SfUs4sZZ0dhJRt+Bz2Lo5/9Z9udgOGXqaD5DZluuWslbrYfKhEZZe3?=
 =?us-ascii?Q?6pRUXo3ScBM3Of2tD+fIb1V5KRHYTNa1T6rEh7/cu6Uh52uiq2IrBMObIjfd?=
 =?us-ascii?Q?JLE9vdwAZKqYyrLD7zZZAuviQZGuWMzDGRq7VdwyU9Xf5wcugwKHbrj6v+M1?=
 =?us-ascii?Q?y3tvgE2CX4pXE+6S+3AYpHfJ2ctd4LJY85R1nCGAYq8kGygOuEgASXJaTVeR?=
 =?us-ascii?Q?Vx4aIF3tQJHZ4rs3g9Tjv5eIYSMLRRqpyRrRuHxz41XhEuvGsjoNVAm4riwK?=
 =?us-ascii?Q?uOF0eqpIiuhk4WSXYGRIgMJNhIWFa9MMhUVlAWGxpwWNNJnZkYvO8Nemirx3?=
 =?us-ascii?Q?o/xjbsK8PQrlGnNMWyKT+qaClFX6Zd36Bxt+HTs5wQLUR+BFnHJBqUKdayOL?=
 =?us-ascii?Q?8awSWTwXmr2a2lI8i9Xx37TCeL1KWIWWrYIQ7Z4+rsLuaNU6dqwkDMlTWuZr?=
 =?us-ascii?Q?ebZJPCtN8MQ+K45L3EVhhOMJBJ1dYsE3pSeEItahKL/0FSMR6uwDKGJZZ6AT?=
 =?us-ascii?Q?eQXGAgL+qrKr3Q9meVVdFcITfYpSR1pu30vzYYiTGXq95rKyCWjz+rgSfKyM?=
 =?us-ascii?Q?p6LrgsIWKs6Hc79KIg7KoWSqvzXDpwKiqNTr1IgkJoGM5fj0HAzlMHz9TiWY?=
 =?us-ascii?Q?GcXfaUiXvSHEriALTN7c5DukTIyfaQaRGYpmP6D+X4BoycDwbKvEwPaCePO3?=
 =?us-ascii?Q?/uET9EZkvnCiH6F0LKRrAG5Kjp1+x0esCOjzBSRHKVJIaNr8PDZ4xv9IHcir?=
 =?us-ascii?Q?Z4LZHt9aa384Rj4sXDhrZ596pDA2b+mM9lgvOEfTg3HsRNLLv497yR3rQ2DN?=
 =?us-ascii?Q?U3BInMmn4tyfroSaR/FgLxD4hafpoEHciwogWukwmgU9AeC8G/J+/ReC+qqi?=
 =?us-ascii?Q?nzkWYow09VuItwWRBHCjQ/6z193bJbhNRYoAsN7yN/qXiDxbQEQAbCBZmJ2d?=
 =?us-ascii?Q?seiLp4Ya3Xw561i+4Pj3AajX4bNfKxB725yzOj+MTmEZezkNeQoUhyzl1L/3?=
 =?us-ascii?Q?PSqTicIENAoNt7VL7nQ03J07zglU6TPTP/X5bk1qqVMeISX+a90NNCPAjDVt?=
 =?us-ascii?Q?1r8BJn8nonj2CMB1yK1qcX0HnqSsOQZc4W1XHOZRCuQWTrNIc/5cFRWPEw73?=
 =?us-ascii?Q?XyX9mkJi++JeTs8Z6Fc18VUTv+mcPLyQ9iyvEqMos2uiUGoGiOOQkCeaHIQw?=
 =?us-ascii?Q?5+d96freP5F1FNcjRQwniiV4+xXNwzICqeaq3E5nKlVBpay9aI621LHppIeF?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a1ea31-f14c-4307-fa17-08dc229ff2e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:02:35.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edDio51DKHDj5cgPCqMWSpRVpzEbDLN1Pq29QX2IfOj5cTFgrxvCGkityzaMJTTWSSvIp8rKGBiItC6bIDCspyUZIZDbDV2wiB0kApnV+JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5880
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> Replace the following fs/Kconfig:FS_DAX dependency:
> 
>   depends on !(ARM || MIPS || SPARC)
> 
> By a runtime check within alloc_dax().
> 
> This is done in preparation for its use by each filesystem supporting
> the "dax" mount option to validate whether DAX is indeed supported.
> 
> This is done in preparation for using cpu_dcache_is_aliasing() in a
> following change which will properly support architectures which detect
> data cache aliasing at runtime.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: nvdimm@lists.linux.dev
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: dm-devel@lists.linux.dev
> ---
>  drivers/dax/super.c | 6 ++++++
>  fs/Kconfig          | 1 -
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0da9232ea175..e9f397b8a5a3 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -445,6 +445,12 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
>  	dev_t devt;
>  	int minor;
>  
> +	/* Unavailable on architectures with virtually aliased data caches. */
> +	if (IS_ENABLED(CONFIG_ARM) ||
> +	    IS_ENABLED(CONFIG_MIPS) ||
> +	    IS_ENABLED(CONFIG_SPARC))
> +		return NULL;

This function returns ERR_PTR(), not NULL on failure.

...and I notice this mistake is also made in include/linux/dax.h in the
CONFIG_DAX=n case. That function also mentions:

    static inline struct dax_device *alloc_dax(void *private,
                    const struct dax_operations *ops)
    {
            /*
             * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
             * NULL is an error or expected.
             */     
            return NULL;
    }               

...and none of the callers validate the result, but now runtime
validation is necessary. I.e. it is not enough to check
IS_ENABLED(CONFIG_DAX) it also needs to check cpu_dcache_is_aliasing().

With that, there are a few more fixup places needed, pmem_attach_disk(),
dcssblk_add_store(), and virtio_fs_setup_dax().

