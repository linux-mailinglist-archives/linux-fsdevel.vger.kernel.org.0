Return-Path: <linux-fsdevel+bounces-10860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D20684EBC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321D01C23E2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87435026B;
	Thu,  8 Feb 2024 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyYWIJLF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CD50253;
	Thu,  8 Feb 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707431856; cv=fail; b=NRUkwNHNriX1bNXWNGxBzXCqtmtg5ew9g1JCw4Ior63IErDa0xZjsJzN1JENc5I33pn9JBTjhbDWnBcDzLh5LawJdhrQqNT10tcAKuxCL+Ef/AR431x0mC8nRmPkr9aplQd6uHzn9Yjzjk3YXvOpsFLkeONlyUTuuZVyMYl2BLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707431856; c=relaxed/simple;
	bh=2VbsjKFgGuqTlJCP7IAQfsU0p5nzJ+gaYnSCyi12hKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U36x/ZcVInoNvux1kKHgRNSFIzTrRy7uVbWCbRY8swU0marhyjwhNBYk39sL3K9+yqm7K1GRtJcUNkR4zlKt8RdAouwc5a94ktU6OVCFXy7jC5Yx2kigQS7RHOTzot299rjicCObfwZIM4JLxPx4h4Uknq4bwNrwpwZvn3Cwshw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyYWIJLF; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707431853; x=1738967853;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2VbsjKFgGuqTlJCP7IAQfsU0p5nzJ+gaYnSCyi12hKU=;
  b=EyYWIJLFzvgx7Cgf5SlJx3OWO5L4Xs1ckYv5Rp28XE29sD4CxcRld8Tz
   bw+0yI3FYLXJXEF7o9GFM0xRa5qYELEuad2jY5em0JSFokqJeQcJaCk2I
   vA8XKdVtClsGny8cd/RdXZQxAJM9YUF83zyIFoD5Kk8wlareANw/w9Nu4
   RbMKt6nAYIIpUyGnWfOCzzoZUJ9RD+BfU5ECpy5sDJWTCtiZerBvBlxoo
   Ix2XL9xdhAhtZGAxZccTx5bIfgRfVRk7r0I0lgk3/wzCXZa+ftGTPLH7Z
   kEi6BLr2RUjl7RQkMXiLt3lCyX4Vl/vWrJ7vk8vhP/eUslvzH7DDdd9g3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="436465305"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="436465305"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 14:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934269329"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="934269329"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 14:37:29 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 14:37:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 14:37:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 14:37:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 14:37:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/tJD3pu7kC7zI36eYKMRXJjc483Qk/OwAv941p8afW/wiiUzTjISVcMtjIoWfJ6COyt+PWphjmcwUTDYo3ABflWQZc0Wh0GtftS2Yrt/94KNvKkvFre9b6IRB9iFXvXGluVrXn+Hz53zCITKhKkDqInGU6K2J/+Be2SNlk+QiFay01luAUntIDivgejdomaMmD+ogS1Rs4PSbdQeGYlLaDTGKQz9RUD4iwezOa+lvEjO36oFVfcjk+F9QDggLC4LpBgMAoeAu+YqwYumeJNEpUusIK5clsvXP4ox4IeRdT+B9tGTPkxRVdYpu7F34KgVXTLWL+KZRW1r8qTjnMbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0hBArqWZLlXNfrG7GukfK+kRa5n88+uINrKL7wJHlQ=;
 b=WCygr+4tfboX2Ao/Q2UyyS8qCKXgARJ3qoZSK9rfRTjWto61d1fdXM55ZDH41OWDyCM5zHk0By9/1k8Ba6Vtc5tkm/WUdVdK9gSTF6lanvJ6OtAR6R/azoMYAEuwkcAyW7YVD2ETSmYASiz8YvvAvfrBGlMO4XsWREY9WKr9wWUsa5Uvme2CtrkmWUrjZTz/t9zOxNo/r/3tdjPNzRYxoCx6LCpxE/SeMFJ8BDwji6xoKsA+0THqv3gj1/vu4ieAvw89W7dqvB7ZdKk+cJWUU/XAvRqWCK1N57fX/dqTmgKqJC2BZN27W9qHP2ug4g7+2PuMl/710yzve0/LxXiX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7714.namprd11.prod.outlook.com (2603:10b6:a03:4fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 22:37:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 22:37:25 +0000
Date: Thu, 8 Feb 2024 14:37:22 -0800
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
Message-ID: <65c557a2e77f7_afa429490@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-7-mathieu.desnoyers@efficios.com>
 <65c54a13c52e_afa429444@dwillia2-xfh.jf.intel.com.notmuch>
 <0e6792eb-7504-464a-aefd-d2a803adb440@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e6792eb-7504-464a-aefd-d2a803adb440@efficios.com>
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 18beea80-c0e9-49b3-b973-08dc28f6860b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zk6HSHJCdpGOY6xTb1wLciPVl2H0ghsWLjk1wOe2QytkbR+MS/ew9nKnjVVIncGdEjamP+N2wFTbCBrzuu9ouofrfDJfj2PzVKRchlPZrfXeJaHrX2oKcrQ21KJ/Cb1PX8brmu3o6rqvpXzgO+ZQOlEVSSk9qKUAj4WYVPG3X+aNFkOjfSr3mVwQ8BERo4gEgRWLdEOtX1ZqxEv5TbmbLKVqe/AyX1FVyx/MbgNnfjy6gnd0cOfbGQr5QAPJdkwIagKitm0xLncbFzxam2Z+tdImheTD4hbgZrvK59s/O8iEFwUKysn87+ztxog3tD80jpF8Oz0jUiqZ3dC0FkZ36DtSiX7lcGnYHuYkXOiWXZAfnd52BTphSplwuki6r5WR4pR6E42F3Wz9GvcC7i9YS9E9E4tbrem0EGB6jKQOc0i9bfh31n8hE88JZnIUTph1GgJnPwV1NrWWAHnjRFYkn04G5f1dI+0GOgQ52MRUrcY2/hR10qquyabqh3HZfKStmxfEzuMbWf13B83QtEE1y1V+YtNtqeIkpyWAwypiVamCe+GubJ1zfFLw5VNf2ZD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82960400001)(38100700002)(53546011)(6666004)(6506007)(41300700001)(7416002)(86362001)(8936002)(6486002)(4326008)(9686003)(6512007)(26005)(478600001)(8676002)(2906002)(5660300002)(4744005)(66556008)(66476007)(66946007)(110136005)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGkWQAk0fIIB+TfXJXI6gk6Nli5MyktM8Y8vt6taH+4801neSpBWX0P/84Ge?=
 =?us-ascii?Q?cgTeLclnPRTyjIEGuvb29F5FWK1RGD3B9z2CuVrjRgkWwWyqJ86KWxnZMvyd?=
 =?us-ascii?Q?dIFx1t5SJgep4veJezhn7PW14y/j0QQ89P3diCHnqUqKOz392mfJDAMeOZXF?=
 =?us-ascii?Q?UpHbIl2Rn1Zd6rHzl67ZVchP/zdKO+7WilZnY7kpACKDYqejGxZkJn3Psipx?=
 =?us-ascii?Q?y+hY39Yb7Nt7grGSNf22qaal0dG/orhsyDH2qlR+3rfhGrr+U4v3kIdo2v2L?=
 =?us-ascii?Q?UEPhs2xyZD6IXOxKneie2CmmSZTR2GqOUbZMV9/QYr6mmYmOGJCA/aPkcU+H?=
 =?us-ascii?Q?D2eXfuPLWfBGzEzVhE4TstZMB/lXEJmLMZZiW5KbNC3YI4u5wFGHSrc0eIsR?=
 =?us-ascii?Q?ri44LhfZs2T+fQivLTgP/nIFbh4gF2uRjSeqcDTuSILWui6wUGhJ/88onelz?=
 =?us-ascii?Q?iDZaChDuaRxgFow3leF+dE87/muy7rXSEu1zNiD/+NI3wbu/FjU8cG846wH4?=
 =?us-ascii?Q?hU0Cwjfhgq3Kdxq/qWQfjKrNPCzMVRCYz5JroPQtpj1SBZP1Q61c75pFo8I2?=
 =?us-ascii?Q?kTPm4MwzxknfE+U2a8EvAEG8+wodBXkNRpjakbYBE+PtitgwrzmnP1GPLy13?=
 =?us-ascii?Q?PQewjYkLmQhtPXm5BvT0a9y3AC3u7gZR4W8jr7U2fJL3SFVH9UtTJozweJS+?=
 =?us-ascii?Q?GPYSeQFV12LrseL3wo9zsyl3splLfPApZIPDaaLtwAUkQ/j76tmn46GuQ1px?=
 =?us-ascii?Q?rVFDASU04KCFK6Dp8wlV9P78rT0YQ6AGr9axmY6fODvcHHTugsixdFfDx7s7?=
 =?us-ascii?Q?uRTaGh6PFuWa7GKsrwLx8EUPSa09RUWgUhtCOv0UJ0pIUej5A26kC+bm49Ey?=
 =?us-ascii?Q?FKrVPt7hWIRdpOftCX5SCqrrpFLJYvazQ5quqTpgZMWUrFpaq3gCrzWM2dCs?=
 =?us-ascii?Q?WAkwvL092s9cWJsX8cBmR432UF1gr+0U/9w5xkzJ59xrgXDeW7KE6CAxn7uG?=
 =?us-ascii?Q?//l4QkwHK480mhOKDsRdzNc4g/BrElfmP5RcvabJ9gq+FyIjNV24yL9ruOiM?=
 =?us-ascii?Q?kwAZTn3e/NJYsxoCPljlBIMlfByVhdTBHhl3zFxDNsxrrj3cxaffuIbmliji?=
 =?us-ascii?Q?HxnYr+khfEh7P+txc1v+9JohpUxP3m7mdThLhnyNmVfwm+Y/nTbmN6ftP3d7?=
 =?us-ascii?Q?rfnNHCz7CFRd1gasAP1rfSz0+5YWiT31pFa6DxEyBVMUPC66B2C/ODZ3NBnf?=
 =?us-ascii?Q?BwRC3YHqyDL0uf34rj/F9h8gEycWu1NPr5erToVV9zj6pH1U9nbVYquXrnhq?=
 =?us-ascii?Q?jzExTm0oKRynGK3bGkjBZXEcOC7QMiXCigoWYv+rdCSHBich1avB30VHteMA?=
 =?us-ascii?Q?u8HV338V/0NFxMwPVZq4yO86uOdV5o2YVewGYq+YQje5fwHCKG24E3Bi0HDq?=
 =?us-ascii?Q?MbNKZ0ltsykd7d3mA9AzedCSPC6EsUOHIB2McnjLviYmKLqn/xyYAI+goBRv?=
 =?us-ascii?Q?UT5LBazIwyWUPcTyqeG22P6ogZss5jQMNDttS7pqvp1XRzNqu928OdhyLgxS?=
 =?us-ascii?Q?7ZKnkNUXGyKLyoq0DxD3pGeb6+DICB8R/NIpbYuCYhk5Ojq3KijqfsACMjkx?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18beea80-c0e9-49b3-b973-08dc28f6860b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 22:37:25.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mt5pMJeMJg3adTU/03ueoSTJpNspm/OChquid7Xmu7d7mn7oMUo5RqOmpGBXWkjVBnHvtiTW+Pic2ZMaX36pjq+UAlZKsLJnAKDkCqb5a6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7714
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> On 2024-02-08 16:39, Dan Williams wrote:
> [...]
> > 
> > So per other feedback on earlier patches, I think this hunk deserves to
> > be moved to its own patch earlier in the series as a standalone fixup.
> 
> Done.
> 
> > 
> > Rest of this patch looks good to me.
> 
> Adding your Acked-by to what is left of this patch if OK with you.

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...after that re-org.

