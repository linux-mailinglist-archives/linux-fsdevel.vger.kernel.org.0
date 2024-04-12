Return-Path: <linux-fsdevel+bounces-16826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 431248A34C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A80B22665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8A14D70E;
	Fri, 12 Apr 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRBHCuUM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303414D703;
	Fri, 12 Apr 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943173; cv=fail; b=exlFcK9EkjJukvcWhNdqsUXteHtRMHwaUV8rU7+eVhngYe+ZNDUjDXor/P7y0Js5iaJDN7ORCs7F2jw9FGq7MeOYzyG2bQrIcCvzTHUnCWcpwSVoLuwBlSz9hEZsWrw1z3h/d0G9KuYiMSQDbWbMzEyaFfo3/+rPz43+0kBrVEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943173; c=relaxed/simple;
	bh=lsL7cBieAgaJPlkr3q8ciB9WIMrga/7OFdYnLJmjnew=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KW+bm9Wk2R2yZDgdAy0hnPyGYw9VjApfMcLNEqTXAUTowq6sqldBTsiL2eTrPs3yTI9fS38RE7pD6afaGIbNIvQXkarEKn7O5XfcZ03+yvi2vMmPendzOqPITjricPgwnbYAtnjluc2aWlxn9bhDYam8XVoF5kaLakhDV61UIMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRBHCuUM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712943172; x=1744479172;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lsL7cBieAgaJPlkr3q8ciB9WIMrga/7OFdYnLJmjnew=;
  b=LRBHCuUMgw3Te31Is81aA5MA3sNuvEFGYBqz+Z/txheUoTpmhHOlHEGb
   cVW35Rswh1Os1+ks64icAM+Lo0fnE7MQ9LP/v8XI67qkD1XK8l5XptoXG
   JOQLu0/RQ6nryWyQHaXfAY5DQrN54NVq/Vqm5ihGkUaBJJEbTWVH8uLt/
   mfzHfpWG/vRDbmU57yXcDRfLmCUjoCQ14aki0sAa56ef4CP5+S7w2VpZ/
   8MGZsdAqvOimZ1kf5fP/ajqvniom/0anGSL/fgIU1k02jnInu+tjk2Fcr
   LSyJPYUK9nXVjXfpy+gc/xU9txOReF8zE+QXCUf/dzfB8m0F92c0JFBaq
   A==;
X-CSE-ConnectionGUID: v5oYumTTTTGizf7ycOrnCQ==
X-CSE-MsgGUID: cu7/u+DSTLyd7ZRxNFec+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="18966172"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="18966172"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:32:52 -0700
X-CSE-ConnectionGUID: Z6y3e5X2SM+85a9/ED4TMw==
X-CSE-MsgGUID: 3nRWq5+NRJ2hl1RNVpD8Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21207082"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 10:32:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 10:32:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 10:32:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 10:32:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwp34lCgheold++/evNpMjvnM07VgFF3i9xoLczd6PmsVB9Xr6jldRUzO1RoxKblCzQYlqEiLXGDMn9wSXLpZd3tYqWnDV4QoTMHAxeNbj5R3EoBIgBRL3SvscSs8aXsEzswaG/eJpT7Py0TnPL/ZMQYR5ukKDvERR8gel58oadl6nhsxTY2C9OscJ3OmWpM2scHdnLWz0h2LTqmgMWMCst0ldeOMXZ5u/z4ivKDkYARWdqgw1v0UAJEwLktYNIj/gkKndSbq8taHi11NpIOOWtKH2I4t1c1MOIh2ck//4vEkLTqW5I0RFqPvfq/4mmbPGf2LPOSdFg9QZ2zAU/kGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocJCAro1U/KdCjJUIaTkOSoMHe44WEaTJcT0qygFLJM=;
 b=C6YyS5BU3YfX7e+duXHIsMRJI75Z64iMvmp+eaTyt9oegqkAcsMyJ8GpFAZ9/Jc1urgk/SgmjMvfzLILZMShDkQpTpRKaDCajBMDNlI+TiYOk1oWaB88pvZOXX0/pA8bQIMhLx+yvWKsXdgPEJqyTqANT5140GBCsgb0cbCQrmF4jpkW9GWowxf7Ub6xsGZEcg/tW2usFFZQCO75DPaglNt90gyqdjeZLOvrHM3GGwY5OvQmrHUW10PZsHi7cx6/7Fu2pEhtTu1uNCMv4aPC3FsXtNVD1hz+EZaz//IqAykhHwpV0Jtq5A1x6Zfv0yzusz2inDBrvpB24Q+qWnwwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8350.namprd11.prod.outlook.com (2603:10b6:806:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 17:32:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Fri, 12 Apr 2024
 17:32:47 +0000
Date: Fri, 12 Apr 2024 10:32:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
	<david@fromorbit.com>, <jhubbard@nvidia.com>, <rcampbell@nvidia.com>,
	<willy@infradead.org>, <linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<djwong@kernel.org>, <hch@lst.de>, <david@redhat.com>,
	<ruansy.fnst@fujitsu.com>, <nvdimm@lists.linux.dev>,
	<linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<jglisse@redhat.com>
Subject: Re: [RFC 00/10] fs/dax: Fix FS DAX page reference counts
Message-ID: <6619703c781e4_36222e294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <66181dd83f74e_15786294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87frvr5has.fsf@nvdebian.thelocal>
 <877ch35ahu.fsf@nvdebian.thelocal>
 <20240412115352.GY5383@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240412115352.GY5383@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: d159644d-d84b-4655-e837-08dc5b1691af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcHQNCsXTbJbCxotdQ4Y5Hakxq0GgKy+sxNml6fR5tP7+P6I4kutdqOEppw/Tv6OxY7t3F69uzNpeXSniN9ymSXZkH/FTf2fBbDMNB/iGn6AGrN8JmDCVJiJQEdal0+jUB0oeBaMyeWcSqv5tpNWP5uHKdiZPV+dlUXfPC8NRae3dOHgckGa7UP6scvNToeFEfS81GF/oMUbImMzM7beO2iI1So68GKwrnh+/6Y5MVRe9/vOeU7cqPOVEuHZ4eH6LLEW01hMRmDawEXX7LfDIJx/dq/jlO5mzGr5kbKVE6s8J8tbSUVtxyDhcepK+jIl7rL2SpfHSoW87ihMc0K42qbJ6lqWnQ44g19Y3pKGRtnSyJ3C/FTYFQR5E6i3qL8Fk/W5cm+KZufg/8qyk680XTtK28N5BxX28dzoRcAsM9amTlyG0fZDHxHErXFXZ48iGSZ9gjixj33Cz+dC12+m1TdZFC7HqSXms/2Mc7rjvBYDD5Qqnw6geQDhgH1iCliEWrKB+QQybDo3GDbXwCY9p8oguDP8N9uXRJXh9vI7X1Bae34OZyPsfNLKnOZgN/pAcmqj9c1mIV2OvTzHtDIU+oMipv6Lad3F2ECJ29woUFXpMywM9JPz18uAIB3Icfvuk2deUAJPk5YN5V/S03R32m4RuJgTld+FnUuUTmgp2XU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mhwejgf1I+jatneDts8L9OabCk7hEYEx4TUcKNPhRoRa0Ym0/m4n4DULp1oR?=
 =?us-ascii?Q?/dIqtSyfg4C0F1ahMfzOuIpiZNNHUuNFNxtZeZWgh0T4BqK+89h9Kd+seoKb?=
 =?us-ascii?Q?TjtWjhJy7HPB1/2G6qLg+ypbS6oxlDEn0BbwK8hEx6Sk9PD9DygQgWCbPd3B?=
 =?us-ascii?Q?cGXFvrrpCD4wNDWLkzpnKyu49f8y8yMGqf7jyEywa/iJfjDEDeQShObkewxE?=
 =?us-ascii?Q?cGfnyuhqcYuE8FsXw3TQLWzmzkNa8fudv7UUCBb6/PTVzy73uAGg4SxOZQ6o?=
 =?us-ascii?Q?+ndt7UVjlZIuHwcEAEnbk+kytNx9fBny0F0q8Uy8GQZ+x4ekvuGdO3Kjg/U7?=
 =?us-ascii?Q?s4jNVShREsex6FP3xbQNLGw5iB7wOCqFnJUm8rKsVN05auuVvRqSIXfFZv50?=
 =?us-ascii?Q?fT2cOzVrqp2MqVttXM7t/M7vhA/fuWehicuqb3u6kL2yi+zM+8JQLDECkP1F?=
 =?us-ascii?Q?jDHm/dzupi9TpdDK2V5oyuw3Bpmh8+TH/v3jEZnLn1gpu3ldD5oUveoUGsA3?=
 =?us-ascii?Q?5oqXylVBKcy00RU05Secysvx209knLjV0mLLpDuYCnJC+jPOtZx/OhDEuTzd?=
 =?us-ascii?Q?dQ6SPqSkIGzDU6fsMp1mgxprnf09+b0KPREyGe+EPe10vs6KvozN7TibrpQk?=
 =?us-ascii?Q?DHDIxXklecNkZcDFhfgKdlxEXYDtUI1RI9B5Z3vjKNB/fq3o9YcJB9hT49TZ?=
 =?us-ascii?Q?G5VdSNj3RxS5MlOVzdCcyDNiamytS6NtW0m8bzqNqicSFQafwjmMayFEMJw7?=
 =?us-ascii?Q?uUgqQFPij4m3dTXwtH1kU5Z7Brfdhhfq3GKQX/T75I4NmLjJL33fbx1NGab6?=
 =?us-ascii?Q?ME6zmfcwevRpO/SqZ7BsaV1p5cEl4UPBFw2SaNirjcrj3t6an6H7vFUJXWEP?=
 =?us-ascii?Q?eC9FQor8pCx6D5UIt7HxHXG/yVJr5zeK0jfmUWZfN+mptV/+XbkzF1sRqGzB?=
 =?us-ascii?Q?zqEWwb66Zx1hXT2DlSxNCTz4TS48plxEjsEFw3fGYGmpyz7O3PzCvqyVUJGG?=
 =?us-ascii?Q?0jLs+6TovpCl5t9I9/d1vHPyQgxp9YNGWCoAnlRB/jAko73wKAwzH4tokH3M?=
 =?us-ascii?Q?j5a6C1RD87vHoeUTI4qI/AFiJ6BfNGdJqiOflmvU4P72NbGXmV1jET82EaJr?=
 =?us-ascii?Q?N/tx+Yhrjadujp9dxJyEokYblAK+wm5eiql8PUhugRlAHt++Ywxw6wUgGP3+?=
 =?us-ascii?Q?kiPMTt6s0h3bK9XMI2zWtCCwd73BugnsawEG71K+cxg6f/6UrVw4LMRS6Nmr?=
 =?us-ascii?Q?eDwLU4CoSeZ8TLwj4ows819iqp6qjOBOI/LwkBRvcpza4J6C1Xp1B68S1bcK?=
 =?us-ascii?Q?g0SlZNIVWChrQha5s5l9LpRu/ry92GDP+VS4RcGAKoY+s3fa0NJdLx5fT7M+?=
 =?us-ascii?Q?cwhQnfywRJE5iG7X6p7kjV1HwO044K5VgwILeKmxrfJGF67I/3IQzJ2WLrLn?=
 =?us-ascii?Q?mrXcXTlklTRlGIHomgscRggMf2DQYCfpdUfRWYkudn7zJXg/W8oLlauqeJGB?=
 =?us-ascii?Q?jAvvjEbgKBWP1NKLxRBa8BXk8gAzjEPdP4mxGlR2g188zuIcAUWEZooAJJxe?=
 =?us-ascii?Q?j9q8q/FZrtgIkVZNQ//N/hKn6IHPc/QanfZMlrIPnPE1yDfuBIwIHwaAuoRb?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d159644d-d84b-4655-e837-08dc5b1691af
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:32:47.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfny2RppeUhQlyT47Vx23BfvjBlvcHmWLoYwL3rWAXQs/m2IyBBBSMIz+Ay51+dLmAMrGsCvddQ+xFFjzVIAHUlcwoqslO35QSNUpm6dyRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8350
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 04:55:31PM +1000, Alistair Popple wrote:
> 
> > Ok, I think I found the dragons you were talking about earlier for
> > device-dax. I completely broke that because as you've already pointed
> > out pmd_trans_huge() won't filter out DAX pages. That's fine for FS DAX
> > (because the pages are essentially normal pages now anyway), but we
> > don't have a PMD equivalent of vm_normal_page() which leads to all sorts
> > of issues for DEVDAX.
> 
> What about vm_normal_page() depends on the radix level ?
> 
> Doesn't DEVDAX memory have struct page too?

Yes.

> > So I will probably have to add something like that unless we only need
> > to support large (pmd/pud) mappings of DEVDAX pages on systems with
> > CONFIG_ARCH_HAS_PTE_SPECIAL in which case I guess we could just filter
> > based on pte_special().
> 
> pte_special should only be used by memory without a struct page, is
> that what DEVDAX is?

Right, I don't think pte_special is applicable for any DAX pages.

