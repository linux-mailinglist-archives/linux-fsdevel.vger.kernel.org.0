Return-Path: <linux-fsdevel+bounces-10846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68384EAE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB66B2629D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B284F8B6;
	Thu,  8 Feb 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOjpNxd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C44F618;
	Thu,  8 Feb 2024 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429184; cv=fail; b=NbVdScEqIjdJCVYOGuVRTWQBds4qx4/J24Pxeu8a2XwyTumSxx9KDXfZpvfNi1Z5B0WIvMYAdcG1214N/7pswqvRSEG1sNMT6dmBd31mpDAFsGRubzf9nP6kSujx/re/H5SiRnPIIBQ3k8YTY+c/gXgWtrdbCEjLyAQ8/xo+b4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429184; c=relaxed/simple;
	bh=5zmr57Fr7Z/Bs8y/9nd4s5lY6sr5D5pVyNsM071EuTM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bk4o+mKyGqbx2ZCDhSGF8ZdS1/TE5QclHtSOzm0rG+fOkrQravyf6i13T3U9QTWScDfrqaoYGTXmQvVG7SXfb1SXzsxycTYKcbbYZicDZ7T1ruCX3WDGLradVhoqBknFp3+2vZ3q7jAZq2zCs/Vil6J0e7uxD72zu8/2mVZuU18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOjpNxd1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707429182; x=1738965182;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5zmr57Fr7Z/Bs8y/9nd4s5lY6sr5D5pVyNsM071EuTM=;
  b=nOjpNxd19af2Q87N+AkawpG+Yp/JCn9sgl0J3h3IBnXtE0wxs03OMoM5
   xrVN4dy8bWmJYhbzAbS6TFSiBXsyPZKB33GXWJzlmxoJj4U9kwO/9kroM
   M8nlyvB1nOFQIlU4YM9RPjMgowZ4aZJGupSwnp7mlqGTu7zNoJjEcUFEN
   UpyZhvDGdgxWNp3NkMQVxjsrnNG0RC7kkJS9/xprcYBgEdc1RoN774oxQ
   iTTb9rjIkW+WCK2UCTUXdh5HHhEl3gWoFqFDrfMy1e3k1sWLG642LQTDt
   LHGwnac7zZbuZdWeIHPI9ux+M1QRfE8kZZ8oCaQA2BcD1Mq7cq1n3u4QU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1462097"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1462097"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:53:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1763405"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:53:01 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:53:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:53:00 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:52:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWOxb1pBFtlwuCZ7BxA+yEgojc4ls7DjyngtqKl7OYX3Otesj4ZELjQP1DUy6LRgzwxX9x0+l7W63APp6ZGI98URli+MunmtXG1kpEQ226HjBT9VRlj8FO3Q2qg/E28pDm5/z5JB0WzZQAUPG2O+FzOYJdStC7ePLM60WIOKdOwnDlIXUtIy+DXpEXUwY9Ud3QdVorLQ50rxvsWshoRS/9pYrolgE+7ySrzIpwvc6VoB6ZCIw8imPc/tXZj4KV+Dbo55Wb3XCzJNeqfZY4TIhRHYlpsrxmXlAaXnsuYTR/7g7BIo/BF+aXEipNd8PVivhzUJSZxJLgl6uITwFBKVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/MOp4LnfSmnW5hCCYNGVRHt7TN7IOVMVH5EJNHC4Mg=;
 b=ARfHkAaq/G5DhsyqQOLQlzg01jeVfWTqqm05j47YrnwTFhyWYDk8aUj/kGclyhFHIKDcGo9DM/BiDevH40a6pVd/rBUfFrcNSrs1MA0YjbrKu3zijjoncyCxA54JckwNYEnbbl+ttTWN36Pfi14Db79UfaHhSMbfkpF8R+66YpZdcYz8afPgghCrleughYvG3HQPOGRMOrLoIUBpMO8+RcGlRazuyULV5cZYfsbh7JbYr5TDF3hJRk8Xx1zm3zg7mztJ4gJw0eM2wzimdS0tU9oAy9rc+W7uzq1X6/d/d2tYv85/a5NSG7qVG2Gwag0IYltbSvfH0ohi0MGdGE4bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7513.namprd11.prod.outlook.com (2603:10b6:510:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 21:52:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 21:52:56 +0000
Date: Thu, 8 Feb 2024 13:52:53 -0800
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
	<nvdimm@lists.linux.dev>, <linux-s390@vger.kernel.org>
Subject: RE: [PATCH v4 08/12] dax: Fix incorrect list of data cache aliasing
 architectures
Message-ID: <65c54d352f294_afa42942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-9-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208184913.484340-9-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:303:b6::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: b54e0b2f-48c1-435e-2394-08dc28f04eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPP4N55ALuzutxtMKS977Lkki0adHhugEqBQGeagkTfDX7GcKXxpcVNUtfhKp1vQW9e8lJ/PWPrfJTWN19AGcnYp3BpZ+gqcNo13MAnZOGsQhuXobwmiWvY/GFluPxKizSu3GpWVoUEoEhvDsOUePS4qR0vwIPWzXvgkku/4tu3oK/cgCNVXGccsqi8+8KDEQDV2KHtqMza1G/Jm/QvXAPmJZr94Uloi9L59ejxUe/oQPdIPLZgUcv3doHs+wKVziyxMAen0+jM9PM2Fl/GHmxwKmTC9+4MS08o8LAbLMQv9qXNpPaDXERcdlpJcDzozi+eQvY/t/YDp4TFaFAkDOc1CDAlm4k0l2AAJK/2/WXq+g7Xf3JT53mOJTSOxRFU1Gk097nQ+FmGE3sR/VkV5SE4kYlcKuvRkN8CugM0bteBdzpbkA85b6KV879XHccOWlpE2gSpLqrGffVeKpf/+eTRrkYGfdA5utQO1zt2GpQgB1DEqet0sorfulIfn5DQAWwdVnSBpl3HrwjTO/V5pPm2Uvvfb+31XcZbnIoX2tml8TrB4FUlB5XjuhnNGOkFc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(7416002)(110136005)(54906003)(316002)(41300700001)(2906002)(83380400001)(26005)(86362001)(38100700002)(82960400001)(8676002)(4326008)(8936002)(66476007)(66556008)(66946007)(9686003)(6506007)(6486002)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TRTQJp9dLkjQJerZNm4/RtTBJHdEfAXhWR2Hb3TI3VfpumjqWD97aJiEuo5J?=
 =?us-ascii?Q?H0ql8fGQHC1POYDuz1d+ZMtEVCwIcUlG+OUSwdxiQPTy2h9wW8cM6m9/md2P?=
 =?us-ascii?Q?x+A0giOa4mSQzg3Av4CRbzBcSf39HNxTTYaIE90im/ESS2a4ddwiiXPZGHjz?=
 =?us-ascii?Q?BRmA9k/48PNHi322CrAF7scJ1CiG2NR3qzMIr/EBuTfuOYMwCO2QXxV//l46?=
 =?us-ascii?Q?gPS9l7HzYktmkZQumTEBOZnn+eDCr0DdOeNZ2Cgvf5JfQinepW78LrOiK4IB?=
 =?us-ascii?Q?9bi8m20pXe7j74nJmMbUMYfgnfobCrfwXVU+wMiqTMPgOmlzxG0Wt1rnyG4d?=
 =?us-ascii?Q?/06IGHLLha315cqQKDytGKz+iJWc1JXHucEzXOHmHgct6+h1lKdYIvWo3j9f?=
 =?us-ascii?Q?Ny/zwUemEUynDQvu2xckfWT1E+4tA+3kxwSfFqiW9ppPA2ndMlX4vpz2c4la?=
 =?us-ascii?Q?fynTB+Fq7RA47c0wa5e1M5xSdbhXd8qiPzLNI3eS6OGZGHfbZ3fqMOf3Byf6?=
 =?us-ascii?Q?1oZD0BYJtdQwPAgOBkCRemb7d39bqpi0HUQvKhBg8CdqFE62apRbmkN5mvjR?=
 =?us-ascii?Q?ezzZMOKyp8yoXPL9PPZzv1g2DNO49XyKvucM0ml+uX5oMlc9h44wB5mMG3Bu?=
 =?us-ascii?Q?r2fA1fMHKTAATKoADv+uS4o+aJlPY0sPI+rd8DQff7ULJWSnNVA8RTdf0P/d?=
 =?us-ascii?Q?Uq7/q7WX5Pfs5hG4l/5jXfXP+Xm0qJbUWI5kbo7h09071SY78/8DzHO7vxAp?=
 =?us-ascii?Q?uRjuSe1wNZktngvLw4SwpSOTnIE2R5QQGxKYRBea1ss6/8dTQTggTo9Zyhv6?=
 =?us-ascii?Q?IUrcS5Vzz51hM90CkTvrs0Je/QUKfkX94UX588oWDJdVa5rS3bbk06wWJeQx?=
 =?us-ascii?Q?rNQSlvl/J5yO8UtBFd0vjIdnW7jzaUFRZiOyz4o5E9XzdZcEEk3s5YLVSik0?=
 =?us-ascii?Q?2sbQAnBvYLAM2TvPG+17kfZysoxfh6SXUipkW76i9IQX24U6ZU8DRL7W/sAh?=
 =?us-ascii?Q?iy+rg+Hu8bnVbQzHA0qPIC27bd3WUXDc86FZcu+qLVW05fplf6QyPf6gnr9f?=
 =?us-ascii?Q?zDyhJnQpgY/z5h5l2ud1AzrkYW3JNaFofgPoSctKyTvhqy3w9K3HD/j9rs6C?=
 =?us-ascii?Q?McviKop0U28Q4DR7OFHfoZH4qEL60+f3Qlb7/GrmoWRAuMuFXrjdrHDoatlq?=
 =?us-ascii?Q?Ap6dGz9IYJsTxRV9L6sq4v6v4miZIBxeVTCCjTVg2089Nh0swfMPeW8F4yzn?=
 =?us-ascii?Q?nOJAXTI2sHNmiR4vZ8oamKSae1Rdnoy+HohooQAsGvaHh3hCjln43xB6vZ5+?=
 =?us-ascii?Q?adsnn3JVwNiJBrVkwIrAxLEsQa2n/aSufiYyqDdhqw4zRCGhvVFxgoFSSrlC?=
 =?us-ascii?Q?O8J82wiHM1So2popYSTo1ss4wWzAfVeAciAW0ADs6/rGRz0CxBJNPLpdaiDa?=
 =?us-ascii?Q?Y0LJjsN/oWJVKECvW8T/ZgH4tn1Vu4xg6ZUNGCsc4fSrL+n0Gi4h/HvTcNkW?=
 =?us-ascii?Q?kniMc9hTLD/4JeG+wEPRQnSxXFjxoYfUEWmc7HGDGeR2bIlAUfNwgC7vR3nv?=
 =?us-ascii?Q?pPzB03vW6uWJ3fZ6XMFOvOtrABbwskTViOK2ygpP3KJ5+cGtm4ZJpQF/EX1O?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b54e0b2f-48c1-435e-2394-08dc28f04eb7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:52:55.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5CBcdfuyGTkVlrgYxpitsEGE/PWC1OmbgZvfrh2Dyq1kwRiSo8b7RGjdSDKtE7vZTnAELw0OnvYWpqKxd/VPZ1zcfG32aZKflVQXNQX+lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7513
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> prevents DAX from building on architectures with virtually aliased
> dcache with:
> 
>   depends on !(ARM || MIPS || SPARC)
> 
> This check is too broad (e.g. recent ARMv7 don't have virtually aliased
> dcaches), and also misses many other architectures with virtually
> aliased data cache.
> 
> This is a regression introduced in the v4.0 Linux kernel where the
> dax mount option is removed for 32-bit ARMv7 boards which have no data
> cache aliasing, and therefore should work fine with FS_DAX.
> 
> This was turned into the following check in alloc_dax() by a preparatory
> change:
> 
>         if (ops && (IS_ENABLED(CONFIG_ARM) ||
>             IS_ENABLED(CONFIG_MIPS) ||
>             IS_ENABLED(CONFIG_SPARC)))
>                 return NULL;
> 
> Use cpu_dcache_is_aliasing() instead to figure out whether the environment
> has aliasing data caches.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-xfs@vger.kernel.org
> Cc: dm-devel@lists.linux.dev
> Cc: nvdimm@lists.linux.dev
> ---
>  drivers/dax/super.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index ce5bffa86bba..a21a7c262382 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -13,6 +13,7 @@
>  #include <linux/uio.h>
>  #include <linux/dax.h>
>  #include <linux/fs.h>
> +#include <linux/cacheinfo.h>
>  #include "dax-private.h"
>  
>  /**
> @@ -455,9 +456,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
>  	 * except for device-dax (NULL operations pointer), which does
>  	 * not use aliased mappings from the kernel.
>  	 */
> -	if (ops && (IS_ENABLED(CONFIG_ARM) ||
> -	    IS_ENABLED(CONFIG_MIPS) ||
> -	    IS_ENABLED(CONFIG_SPARC)))
> +	if (ops && cpu_dcache_is_aliasing())
>  		return ERR_PTR(-EOPNOTSUPP);

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

