Return-Path: <linux-fsdevel+bounces-10847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86D84EAF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CBA1C2634F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0394F5FA;
	Thu,  8 Feb 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQdweD+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C54F885;
	Thu,  8 Feb 2024 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429327; cv=fail; b=LZadhfG50w6x6XBDu6GLeoy+pZ53DYA11b0zWsow75iqm2DTkvGTrw75h9ITtPOdC5htYQnz3clUgwDOiUkvJH1P2Ya71C7hPSK4iKPfu5qIFNXr5waNyDOzKacstCb6Z6pXpiIarSHXGLVwkPYBOLatyAObtB9/E1moCoOtJgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429327; c=relaxed/simple;
	bh=e4hvGxJKr9A0ShvS5Psxooz0ijHyebccPNseCizcGfE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nQ8ZHYG2Ynt7HpYb7QIrzgMUw4pXVaVOUlxx+39LckGjAlY7Lgymf/FDWUux4qbnXTPhWxkcTxFWU1VcYidyt6w1s4YbLJ5RkHO8Nu+H97P1oh3vxrnBOEbFUFGwDN8WJw7TTGufIh4323s6Gu2bVXifXM2mAfeFnaoeNTVSeTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQdweD+1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707429323; x=1738965323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e4hvGxJKr9A0ShvS5Psxooz0ijHyebccPNseCizcGfE=;
  b=FQdweD+1tq7+Jrxsd+WjRZU79QcH7O2PB+WvsIXAk66ucx4eyxp89v0v
   045hWlDhiFRbYM75LLBF5MRWEeC+1edbUjNdd2kt/YpuIOupgRlPjCpyz
   jXD1QRkJeFjzhgg8dwyWvoKPGGFzJRKChgja6aAc3dmf1RUZIyjq9HIMy
   k0FRf794ngAcB0SgsKBo0DtEeGmp/JCLMzVzvJLGyMAFm5rFtuc6QCVU+
   9abyAH/TTVWo9tgFSm+uc1sSxRERCgBcXZg4dlQS5SXIVslX2bKFUcXWq
   X5U1rqJKphkXGYhwmjhm51sQ2AtFhoHY1Fl7S0cugA8GFWjrTlqWKf0AZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1464707"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1464707"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1775584"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:55:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:55:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:55:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:55:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:55:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guYAmN2t59BEsd5LKxgiqzhnhWN64dC+Y4mq8cvaHIP5ntGpOChHS7dlUgxT3ms/jHJoaHh+dLpHHXDEK4qi6VR5AOavEnJwWOciu+KEwttwwSouubsAGMwGFe5FnfxjhAgfKzJRjPFM7pr+NVXBXOIIJZVgGpvJpdsdTzeATNJV05h3jRaBVjc0gUjg4ZAeHIRJ2A182xLaAgwGKEDfOFFs1oz0hyESPv3pbvuAoQn4/Rs4dvAdq8pwmujhZBO7XhSUTFNQ5mmnk1wUMmjOyQWK3ZwLKCZhLtMnuXjGJLz78jTcftuyHjoNq3hctB8Lz3Mm9mqMkRsVhLMwQpWgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOYcU2ETWo17C9q1iMRHJDRNSoybjYiiWWxaE36DvMk=;
 b=ePG7GEepFWPlDLd/bK7PT1QLcmPyzXx0qcTajuY3x4YbGvFj/oqdN3ox39i/qS5WaeE63V0t8bNAwD+GbhIWCWAtbeuAeot3S9MiFj7g0MaHQ4q5O7mBn+pAAcbUCeBXTUs8ml4MOd5NSq1Noj8MaxBPO5S6fdZ7rDrsm/uO8TH/i0/FM7mzccsm79t0SnewL60u7ojgosS/a0kUbze2GKapDyzy9Bzlro4THAnsgiBk0ckqM4MDC87c++Hg5Tpjk036epoFAYLk/JfrdyVOySGd8uk0ohHAocqxAFGhpR22273WdWkdNuJvFkb/fehM220VAg92v5UOjMg3xEAxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 21:55:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 21:55:16 +0000
Date: Thu, 8 Feb 2024 13:55:13 -0800
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
Subject: RE: [PATCH v4 09/12] nvdimm/pmem: Cleanup alloc_dax() error handling
Message-ID: <65c54dc181e01_afa429468@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-10-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208184913.484340-10-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:303:b6::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d364ca-aca3-4b50-cd44-08dc28f0a262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hwvRTiBzsWO2rkvMBN6WmFdX7HC/YWxTAue8qW+WY+K/CWHbmH5VbOeMYuQPQTW0PltNhAP5lZNEstqszB82akAmwB079AUKpVLMfH+LulcpRdTRf/zxrZU6EOiVdIDUeAzaBsKq/BC0fF4Y2RfSTsW2o9tx6L78iFV9glpRbDi9CTng8x5o0uZ2BaP9CdXsBigFnxmu/eVw/9/O7ZY4y91lGfgQgzqnI1dplnPb6QWJ5QS2+89yHu8+06Ndz4fzRj3y8kWXhIFnRUDPPsYPPGYAxK1B54gjUwGe+pGwW55HTmNJKYWwikAQPVtfC2cxO9YBXZrJTTZN1cfqGz/UhbZ0Hb17WHvzTfNVVvf0GTgR3gncu3W6Gs6tBf7w4/KJNro69UbsZ7yyKEIX3h0JnvL8Qd+frVRVewtIGHi1wIExHb89HiCniRdoiWhHLVR7Xhdhu/OYZPEHTKlrQquR8OT3PxTuilfrqMuBTYIZaj6C/XS6DKRzBftfpuJ4DFcaIE9D0e/uxnoxGRDaYFef+ed3aok3ztsvurplQUq6NhlmjZg38JsQEX6JDQi3/Cr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(83380400001)(8936002)(82960400001)(8676002)(66556008)(54906003)(66476007)(66946007)(110136005)(316002)(2906002)(26005)(6512007)(9686003)(5660300002)(4326008)(6486002)(6666004)(6506007)(478600001)(7416002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PEGGVD14ZI5v/Ou3GOmlN3zyAZADo07RqDca+rt4ePhY1IHw6+UJrPuwn1f7?=
 =?us-ascii?Q?ZYdmFRU3YtTspdetBWn5JCgmIsY/fhoIPp/gKHE/BIzkHYLgz0IetezXls6r?=
 =?us-ascii?Q?C5187SjCsOE2DR+NPi3jsecWLr0dlOFdB1AusmenTZ1sGuyb6kVeynlnpkbP?=
 =?us-ascii?Q?SiuASDuB3H284RqaQKILUCr7UwbZOFDbyugA/JGwPIgTvh5/rsPW7XTP8vKk?=
 =?us-ascii?Q?lcREf8ijSy/MbIUnJTRyugd5eVURXjvxvvcbL3loTfiacBTesqDIZQUGAJPl?=
 =?us-ascii?Q?aSUIHZC6mObfW7yjIGX503uGt3/HWy+7q8o/z9/2vnlxDHy/q9aDafFqoCa1?=
 =?us-ascii?Q?6GCA1oBIq0w9Pn4foMpJlcwtpjtgpc6UjvdPp4sxeY4O14HETXi6Zps40n8s?=
 =?us-ascii?Q?nmIfhZd2jMm8SDEsZNoOD/HJZWbgurwLnCQIDRTRlkdXCrvrnEDVnJ+QcHCt?=
 =?us-ascii?Q?6PJQHvmBN1xsKLeIfDXtYyAUfvOrVZdnQTtkotRPU9oVyV/ttsfHRx8l1MWq?=
 =?us-ascii?Q?tqUPZwVAHXQH5eQa8yRs+x8TJMmT1lCRtJPqT897AaKCSSYzstsbTnU3Aq+l?=
 =?us-ascii?Q?qYXeK2axHkbluHr6CJNCCJT3x+gi0oUMsKN8nNJ4tFLP+SnKFVO1os2YEKDV?=
 =?us-ascii?Q?ZPJso6eVu0CdaCXJzHdw6L6lo2STjx5VODKUHF0MGrLYnjWIXXuT3BI9DDqb?=
 =?us-ascii?Q?RhjuSkgB7KFfVj90aL4uwDr6Q0kyoqhdm5C5c/I3xXJUK/pOL3M93LGorvUm?=
 =?us-ascii?Q?tFfcJFhxZdqCB0orHm6QIbE6SRTnIJM3c5+N8IZwuXEJPX+SwU6bRt/6Kc2y?=
 =?us-ascii?Q?rDEkIoGNGGD8fkYyySTViBZomaSE10QRSTR+EzRemG0uHGFPAQC8mdbr2cnW?=
 =?us-ascii?Q?Il7p3YAma4OikBh3z7ou9qb7W+nv6PolvLTb5Y/24/CWGM8RSCCw/qbInY7T?=
 =?us-ascii?Q?BPrQVbKJ279aIqcHTqRMmnuyzKwd37hyhDd4sKvWmx7l00uoiCcZJfVH7pTc?=
 =?us-ascii?Q?PXZJWLH8j3AVsHQFaK01aZPHJHR9Iqt+HMbsDrla4nKnrjTREph35SrguoCN?=
 =?us-ascii?Q?emE9iVJmHm5qaXCiwdpuseZzC+1VAYjgu5CuVu3C0JJQl/8lXS3WL4QI5FaM?=
 =?us-ascii?Q?yDC3Kt/qeTeDPok9wjwRi5dnVAbrfEhLje1P7M5qhrFBXz+e3VX7JaQhslm/?=
 =?us-ascii?Q?SpaOlb+6YW8v8ZxEzZT2bjCK4SL/5DSgBz/vEpSiHw+7wXUY4sRB76m3A2yH?=
 =?us-ascii?Q?li9hNw4Gn/9XPro0wu/UAjvkfOqM5qLGBNDToXrI1dX9EhsGfnkfU1/j08mZ?=
 =?us-ascii?Q?l6DuFCqj8gCC26x+T3mjUyazAKSKl2Cmwa0Il543/YEm9vNEdpZlYTsvTrfg?=
 =?us-ascii?Q?9q5hByRXOFrhIbsZans+UeV5JN5OcLcDQ/V2KDJ8oUP8NGf8xERPLM6tUTJQ?=
 =?us-ascii?Q?BtZ2jw9q6DhvYx3HqEYf+I+Z6JSX3k1qQ4N4tOhQ0NQBoXlmVITzpz1RB9V6?=
 =?us-ascii?Q?bL4de+IxI74On3S1KisPGDkPfUKMG48rNLxrPaJ1ro5VdoM65lT2oMaFsXaQ?=
 =?us-ascii?Q?YJgK9MIX2ghNXCZtuix0CkjGkXFWqUV6FtYffOUZu4H65qQkZGT4a1lVVj0E?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d364ca-aca3-4b50-cd44-08dc28f0a262
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:55:16.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CBEgT6rHaVYLwqRDeBIlpzdNBqZuZhqxDXZ6cBc0PMIZmO8hZBzwmn5KL4GWKm9zKITG7cyd+ePcDWRM36daqzChT62vOs1eE/b+YyeiZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> Now that alloc_dax() returns ERR_PTR(-EOPNOTSUPP) rather than NULL,
> the callers do not have to handle NULL return values anymore.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
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
>  drivers/nvdimm/pmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index f1d9f5c6dbac..e9898457a7bd 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -558,8 +558,8 @@ static int pmem_attach_disk(struct device *dev,
>  	disk->bb = &pmem->bb;
>  
>  	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
> -	if (IS_ERR_OR_NULL(dax_dev)) {
> -		rc = IS_ERR(dax_dev) ? PTR_ERR(dax_dev) : -EOPNOTSUPP;
> +	if (IS_ERR(dax_dev)) {
> +		rc = PTR_ERR(dax_dev);

Oh... I see you cleanup what I was talking about later in the series.

For my taste I don't like to see tech-debt added and then removed later
in the series. The whole series would appear to get smaller by removing
the alloc_dax() returning NULL case from the beginning, and then doing
the EOPNOTSUPP fixups.

...repeat this comment for patch 10, 11, 12.

