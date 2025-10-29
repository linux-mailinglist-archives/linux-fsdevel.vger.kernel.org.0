Return-Path: <linux-fsdevel+bounces-66172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 634D2C181E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 04:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60A4B4EAFE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 03:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C702ED869;
	Wed, 29 Oct 2025 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+eHE45u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6F2ECD37;
	Wed, 29 Oct 2025 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707187; cv=fail; b=SwACe1fhoOfxOBejSnwWa0W/PKOFDV9WDOV2Qe6c0ndfiTXHSHrwy38c8CDiJc1rpyQin5bvIhpV1/gcoAuWVnIvmRqkRMNd1dbODEmPLgJla28D3eAUGgLAdVePGjjC+Khojfz7UVSxjoffu+mXjij4yUpDitbkCj7qizKpub4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707187; c=relaxed/simple;
	bh=xArSjQA1zNPjOgwWbSEd911hp68KhAp83csB+iKvrro=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iCGtiDMlbAdpkqvFSjtOlZcpAm5DL5awBZsPWz3zorhXIk9Ke++bcEohjC3MYqe5798xF1FFjIu1XUIt+LiiRfTlSO2Yv68ZJcoMQe9Rz359PDoJvkfC+S2neo638svcpEIHK9yLz6agdYNQh/v28elGggAPgENbFLABRu1AHZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+eHE45u; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761707185; x=1793243185;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=xArSjQA1zNPjOgwWbSEd911hp68KhAp83csB+iKvrro=;
  b=R+eHE45uWg19/L7RCvLGQco8EpKmm61q1ijdCDGTOifr+K82eeC/Kqb1
   zm3JhDhfhtoGw8E1/4z5xPMcgstkNVNC7eeWtsKBNShIFxtuZbCd7D1Rr
   ZytnJ2r2CQrWpkeyko4x4Ks9YbCS5YUtIHMKyuCewKlKjBPhGjbtdjfoc
   b0+d2bgy3Csz+8DB0lc+EYWtF5lQO9mmAlHo5iOpnJEiJPZvaIeN2iRyz
   sbaubw5/IP5aV6lfNBAcuCkeMPQ8c+bNG4sIpzVLHPMQFPMq6ZG/rm4yB
   Y8jcrpQaifM4MDYVv7cXyG/yShufVhxwZgMm4clEYwZIhksDzELpOnPuq
   A==;
X-CSE-ConnectionGUID: 7GX+5k9gTqqspf7v02TcEA==
X-CSE-MsgGUID: UmSWjWjLQdCYgA6/nn7f4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51392952"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="51392952"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 20:06:24 -0700
X-CSE-ConnectionGUID: M4SC4g3YSZSgxjQYVHxObg==
X-CSE-MsgGUID: /9qKOv6bTgys8EOEa2dQ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="189844081"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 20:06:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 20:06:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 20:06:23 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 20:06:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B71iJq1y3OJXWUqfWRHC5FE3lMiXgRTAZaLk7SK6lxOtGiV6Cy7YBuEs900j7K+36XMtPYkWdHRz3tZrapLzVahZENCss/qxYGu4M7MFL1MzGJSeHcs16SnyfnHkmYfAh/NvXApQ3VnWkVPyO1w0cFcJFQC1d/s1njnBSlmcHg8meVjylxenyhi0sFfQI2+VPu5S308qvCLUoTORIdbTIka2fIfFWuJ+q/r1w25VFWcNoh/ZpJgVSoczdD+7+i0CpHXeRUI07PjEGkCf0TFEnWriZIj/+FEwHLDkYBPNA6EMIgKjrTsHqKbAS533Lij5lgvgheS0SzpTnueSPpUYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2Ig/vqBAPW/H1+3GJgS3yVW7mvBHFwkU6THRQptt/U=;
 b=Pd61z8IykgtwZBML31ARjFbbcpESxKf4xykHXOOJz1iBWLBKff5A3sWFN8nsOkXc9dpCms+rtA+8ChtcwzTz8iDeJSmu6dG+OetKLZN2gTRz+i4nHVAgXy/F/0tMpI1L514JiXE07pph9N8E5Xown2kUbKjAaCQMper1l8Tfje+W7P3l1ZN1I1km+Zfe59wxxAw4U4r3KLK0lDsv8K4PR/9LIrrrPzAeFcC9e4lzjzUxz7L1RAUQg+PCCZsJMar+VvmRyw2OcJbNmcr90PEjDUs8CUWoY14A7H2hqsUM7x0ChE4pC9hWYfQm7Tvpfmw5VgdQclzG27F4mpYsVqdhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 03:06:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 03:06:16 +0000
Date: Wed, 29 Oct 2025 11:06:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: GuangFei Luo <luogf2025@163.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
	GuangFei Luo <luogf2025@163.com>, <stable@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] mount: fix duplicate mounts using the new mount API
Message-ID: <202510291004.24ca6327-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251025024934.1350492-1-luogf2025@163.com>
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3be738-8a54-4281-8a40-08de16981fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bNqfKyGiKiju0saunJuTMwLW/F0F1C8Zn/yxWjTAwTqNxLXvIL/a4s7H1T5q?=
 =?us-ascii?Q?yPlAyTSLx6RRJ71gg28O6KyyYvOvp3asJlqFvYgKFU5trTEceZecAFEFJe6N?=
 =?us-ascii?Q?QykSAtbZYvk4Gj4I+Yjcn3MCCQGowibuX5e9d3nKjP49VZ4bnC5jfJm5AH8y?=
 =?us-ascii?Q?fKZumtTgwTdYWXsNhG/rGHW7j0t22QaBHqWq7HnYVdeYmXX2/OIG6GWWH9yu?=
 =?us-ascii?Q?Ue+5qVUuqrg5VvnMWR4YYWEg07GjPc9Lyzprmywb9TGkyvXqYfk4qit1x357?=
 =?us-ascii?Q?9JB7gJRjUQSKbvpIXTnjDEYlgxYDlUB837946vJ6sQoy7OTaQQeyauRv8te+?=
 =?us-ascii?Q?jWOwHPklpztwEXVBaYf5lhAhQibn2YIDo9zh1mrDwuUi8XgQ6pf793KIey4Q?=
 =?us-ascii?Q?G0bhBHzSpvUHeTQV9QQp9VsCEjZjgRg9EWe/cRIgxv7lLs20lp0lU1cW4qLz?=
 =?us-ascii?Q?Fayv3XZaS/Y+IDlJb7Ebx4e/u9p0x7BSEE7sB2pfj01Y6JrBYhi2PJdTi+MU?=
 =?us-ascii?Q?QUg+yHN+XzZpzpbFGSnHFqEmn6ltNyC42taWswWb6SaTRgiblYtYhzxTRljT?=
 =?us-ascii?Q?NrfYQ93BdjfjPIm9KXj1eVQjV/LhD8uP6/aHbfdc/4ubIg/3bGWXEZ5S7P5e?=
 =?us-ascii?Q?XXiT0OliPJbN5Dp8pXyG7bJV+RPeV/4207OUIqvNMk30lJoQS8Ei7LsyODjg?=
 =?us-ascii?Q?eGHzn1Dzcx6ihl98GazBYDQ3ykRW3wqzrJaEwzpgrIDHNNKObIH+AqU7NMmH?=
 =?us-ascii?Q?BucZ1eBY3LQxL9BVmS7t1tfzRWkjlnCUYvqRDFTJO8aHfUkzVrx8/63YW+TG?=
 =?us-ascii?Q?iI+8jLteMZTzkWouCv/40iFarAVUVO7vqzHR8F1KUImCckjl7jfUFCNo+WFF?=
 =?us-ascii?Q?WalKFw7lJqFCPcaLXj4f3izjWd0oEr3q/rqI6bzwzPZJ/CEaa6IRCsRgWQss?=
 =?us-ascii?Q?jZRcWvGculYCH4B0zf8IAeFYr7MllcYrIzcQJT2P7KOdA8UBq88Bs+OM9Dzj?=
 =?us-ascii?Q?L267mLjWTLN9cFlzIfaO0veXuVp17npHlquKyX5nBaKaattGX0tOYYpg9ZGJ?=
 =?us-ascii?Q?BiMb95RWE3EFpBXUr5YvrAnLNepIscTW5ODNJklbz8XWyQvadTM50/AJTfhl?=
 =?us-ascii?Q?kDICLejXaKdk3OhesyCm4KLMIcXJkA9tTmZjsO69g4K82LZaYOftkwL+xx6c?=
 =?us-ascii?Q?Aj46BsgqhrzO6cjEpDKua8ArVTkZPlrMlL/LzTQ5XdTKaAY2qRY3hOhJkzWE?=
 =?us-ascii?Q?o2bp1UOthMni6UhMxnR0p+Ifxd1XtQiM/emivMzMjhhZkn9jJmTiZ/rrrlrZ?=
 =?us-ascii?Q?VzrLPWoJldpbqg2yQfJWcbOIzoj+3XeJ1tQwVpCvBJLIHH/OqtSYblEvWxdp?=
 =?us-ascii?Q?zxJ8bobcCeXF378qj7aIBFyh/QHQy+vTv1mwPKV2eI/DxuKzI6800tKu5qCv?=
 =?us-ascii?Q?FZhkZZvPkLgVxAg5o1dfIODAfiYrnVjkh+tseo9TyNXMOYPiKk4yOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHOLqTQsaoRCwJpwxmmmIA93A3VxVWpYKAtsxlTeUTiEuI+ztE5JXjT4hvvz?=
 =?us-ascii?Q?pFSG2scG13bS+6bwmwuiUPSnvGEVknP82vF5HxP3tlWgtwSCw34Q525Wm9Tp?=
 =?us-ascii?Q?RbdzMWqTJt04XAkR29qU8bhUZMtLVZNsb631Y31DB4Y/j+PFpiW5bSg7Nw+i?=
 =?us-ascii?Q?WfpZLmU9mM/u+vzaIDuD2CuXSRIWyANpQaHGjwqdv6JaM5BydxPwhdZtbYwT?=
 =?us-ascii?Q?Udi0QAxNpEH2Bz6M+UBOhgko30Ek7wxV+w2hWwpKkCPF0UkpVQaX7q4t/vxb?=
 =?us-ascii?Q?LuBcOf+2PkXi7XIPgdIMIcp2y/LrSgbzm8ltl06WDBjRdy2FBF9oPANHbDDH?=
 =?us-ascii?Q?pVcGNK8BnqdYvkWCG9KwFQ7+I+xNDcO2FsJCuBJ2RbsW7260u7WBlzQy590d?=
 =?us-ascii?Q?FU/aDWxYQDXA3ztxOOQZFJyAIl9BoGhK+1GccQHzAVmwwP6gQvAYHivSyWbZ?=
 =?us-ascii?Q?QKdBsKymra1aWRVlktmkf8Nvn4XMrkFKgIK836TbEoeWoK0G5ZLO95G7Eafz?=
 =?us-ascii?Q?0zwdCcVcnqwak0wudgK3nN4H1i/nJcYOIv92pUbeNibglj+IPf3rgNOKocIL?=
 =?us-ascii?Q?mFnQxZFYsRwBUGD/ptlKU76V3oaYqmri5l00BEf4sfavKzBXlRvFiSkR2VEP?=
 =?us-ascii?Q?tYSTdr8TY8uEvGdQc7q2yhQhMtC69jTksk+pdmb7kbx26e5umUeiV6LW2Dxz?=
 =?us-ascii?Q?WEJR425dIgxf4QibYpA5oiNNrohqqdTD9HB0FLUymnDr8ZVJHuO0xoWfsVud?=
 =?us-ascii?Q?QiuUT7WCClNC3MJJnElBTsnulV8j2LiWCV85v25agMiVcrCyJ9mBZVrM/lh/?=
 =?us-ascii?Q?/xfv1+r7p3kbBcPpBQb0zBM1o7BUKtRfUX+5oTXNMMLlj/eata403ZINXjrz?=
 =?us-ascii?Q?+KRf48SfvXOG31EhXcZ1A+238Iz9RbUtpIHdTrs6av7oM5MxJ6uC9KFfHja/?=
 =?us-ascii?Q?QpD0dxHT5Kz79Fx8p6hspcIt7eeP0nHF5Q5EZD1K0YqT/A4v5a0VPorLT9Nw?=
 =?us-ascii?Q?hr5tniLpDwznWTH2JeDnzInU18g5QbVBP6lqIUt1LBHExfcCaM+z0MLCFuuq?=
 =?us-ascii?Q?dAOPpMZvkqD8dVbgp7kXQIKqUTLUfeuUAo/udnt5jU3Ekiop/RjbxGY5Bels?=
 =?us-ascii?Q?vz4LLQrEor89rdO04h/mJBFv6WrBbuuMz/NZYIocQkWU/Cq0ooXvN7HIjP9u?=
 =?us-ascii?Q?7CFqW65P1zVu3JlM87KLOoHhjpFponEAq56QseVpbBB8wG7iPOcq9bUrVHeK?=
 =?us-ascii?Q?AiTLlXteU0ArxQrYcP+eBoSi1+dzDGRVvY2jRd4nJ08fUSqN2Bu8bgIAUmBv?=
 =?us-ascii?Q?VMavJysMuXbQ43l089sI6DF+kIjKRdI0FbYMHFGpuFwvXTtuDY9oumcc20cu?=
 =?us-ascii?Q?rByOqMZzvve6n+IP1HKucjNxs5Xa5rgHxKyiX2r6OHrHWoD9zHo0kA5Y+dND?=
 =?us-ascii?Q?0iNiTKmSLY9b6JGrLjx3x1DUIa0jVEY1Pw87I6CAaGadMnpGoQDuwd4HOyOx?=
 =?us-ascii?Q?QK4skVx7j419pPVLHWksLjY+OSLlwoIW8pAltbbS2YSCkMX8BxvHGbi9qxGn?=
 =?us-ascii?Q?zzWn9yjMdAlAoqJTrsxqVDJi2Z7wjYI33lT1swnW6AywPOVjuYSVemI5+xFl?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3be738-8a54-4281-8a40-08de16981fce
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:06:15.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD0yld5BuYGXdvnpQfRY45aRM19Dl+xoH6q2QHJYyL30760wg7t+bL/Iq1PHc6Ty62hMoSBZjcLVLle7m8qwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.xfs.153.fail" on:

commit: ad04c4e00fd850d57b3a07e1920e4e44e6dc393b ("[PATCH] mount: fix duplicate mounts using the new mount API")
url: https://github.com/intel-lab-lkp/linux/commits/GuangFei-Luo/mount-fix-duplicate-mounts-using-the-new-mount-API/20251025-105257
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 566771afc7a81e343da9939f0bd848d3622e2501
patch link: https://lore.kernel.org/all/20251025024934.1350492-1-luogf2025@163.com/
patch subject: [PATCH] mount: fix duplicate mounts using the new mount API

in testcase: xfstests
version: xfstests-x86_64-2cba4b54-1_20251020
with following parameters:

	disk: 4HDD
	fs: xfs
	test: xfs-153



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510291004.24ca6327-lkp@intel.com

2025-10-28 06:08:21 cd /lkp/benchmarks/xfstests
2025-10-28 06:08:23 export TEST_DIR=/fs/sda1
2025-10-28 06:08:23 export TEST_DEV=/dev/sda1
2025-10-28 06:08:23 export FSTYP=xfs
2025-10-28 06:08:23 export SCRATCH_MNT=/fs/scratch
2025-10-28 06:08:23 mkdir /fs/scratch -p
2025-10-28 06:08:23 export SCRATCH_DEV=/dev/sda4
2025-10-28 06:08:23 export SCRATCH_LOGDEV=/dev/sda2
2025-10-28 06:08:23 export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
2025-10-28 06:08:23 export SCRATCH_XFS_LIST_FUZZ_VERBS=random
2025-10-28 06:08:23 echo xfs/153
2025-10-28 06:08:23 ./check xfs/153
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 lkp-skl-d06 6.18.0-rc2-00237-gad04c4e00fd8 #1 SMP PREEMPT_DYNAMIC Tue Oct 28 13:58:10 CST 2025
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /fs/scratch

xfs/153       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/153.out.bad)
    --- tests/xfs/153.out	2025-10-20 16:48:15.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//xfs/153.out.bad	2025-10-28 06:08:30.851957601 +0000
    @@ -11,119 +11,6 @@
     [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
     
     *** report initial settings
    -[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
    -[NAME] 0 200 1000 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
    -
    -*** push past the soft inode limit
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/153.out /lkp/benchmarks/xfstests/results//xfs/153.out.bad'  to see the entire diff)
Ran: xfs/153
Failures: xfs/153
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251029/202510291004.24ca6327-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


