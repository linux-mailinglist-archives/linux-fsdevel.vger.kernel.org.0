Return-Path: <linux-fsdevel+bounces-34652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1C19C7360
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2491B2D9C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82465200B84;
	Wed, 13 Nov 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iR46ji/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6481F4705
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507304; cv=fail; b=Qty5s5QSjlbHvqBRq3psFIVQf3e2PjUfQMr+OX6mlhNP7tbdYKgpeYVAWU1+7C+kF2LKws7p5R/KI0PgRDRq/Xl3LWo4zsgObM5HAs/AwCM+4WrRef83ozu7pBPtzAQWmK5usPqMzrcPI3hsi2Y3JUw5vDZSUbJ9miqFg4iFN68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507304; c=relaxed/simple;
	bh=HfRYTW22DfezKh9iCk7j/cjDVAs7TJDcLfhKFNYJZLY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RPoFNgAl9lLeNmSx20/6UeDUk1WV0CCBouPrSaYSU8JqsINgxsSpEiMKiMJZZL6iFwKR+kuL51lh3a3fd1hTeqdERNpaQpk4dCdzcSmG2ZboAKg+J3cS0KcjynNmF89b7NSwCpD385n/CqSYAXcCrQa1moebenD0rtp6EqPslOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iR46ji/x; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731507304; x=1763043304;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=HfRYTW22DfezKh9iCk7j/cjDVAs7TJDcLfhKFNYJZLY=;
  b=iR46ji/x0Q/jmPdqoFaCwwyduNzis1k8RPZ6KwWpm790FVqfufVaA3jO
   gs+i7dsWXUiIjj8WLqxwM83mOepuL56/uze662L++oAbh6lmPN+5XQexQ
   rUnZSAziLXAmh3i27KtffoEhLzLVyO9kueemT2Ncd5HHUbfFoJDLtLIQi
   kuvWekFL/4EDrZLKTidhVrARPAKgYAbG5WlQw+4/dho5jHu2dM4pHu4KD
   eHdnIReIl2LPfx7Db+ltAJlSYSIV9OmSUd59ylfq5VF8kgUMJUYFf8V37
   zE/eFVu/yFbWtU8LWlduBFVOpi/hZplvKkDUp4I6AQdeipOaIGlm7KE/3
   w==;
X-CSE-ConnectionGUID: B7u4pZDTRQ+kEKPefpWuxQ==
X-CSE-MsgGUID: v97dfk3nSSyehY0TQKfUUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31510998"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="31510998"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 06:15:03 -0800
X-CSE-ConnectionGUID: tcZF5PTKStOpU4v0ujZU9Q==
X-CSE-MsgGUID: 0uGm6kDlS8OA49cOjAwIIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87783124"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 06:15:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 06:15:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 06:15:02 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 06:15:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjAffnATQt8wnHDMmEb663yIEAIaHlJV/z4LA390C/fimpBWxueMbWHXnqYrv7qRJ1ulg9OdBM0KBuGlMmp8AgU606t92z3fI7Mzdo+ViG+m072XLSobLeTno9qzl6SCjPY+WQgz4GUMIELUMberLLgeIGp0DbbmMbtdqzt8eiMl4unX6kIfcFHWVE4FALg8h7mLV3BZ/C4V4Mm6cWakBETeuDU04vkToVdukIZ1ROk7vhRnp1aNXHT108VKQh1gWg4jaevTinQ+6X9FQnZatGF6kArFkRfskLRtY5L9Y5u7xr/qHi/19ODxJlIBmP4whEJqJiLsn5rCMFuS/KHikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXoQJfbNQ31dVD5yE2YvbkclatEo92XRVAVOfYnT/nE=;
 b=HkqCpOCodffOi90hQq4Y6xlLZintwMtnc9oSuBvGiUtZFAT3slC/H6UUpLtV0Wt1XxNhiT/rsUoVG2b+J2c5jX6q4lNbMLhdWQVO0XULxpBB07SO62lMsQdhFMxa7bAsOEIWR1fFEsBgf2lTXmGNrbiAHmrr296u3cP7nLAOvNi8M1AmNATutaHQjTo84AIXZi7DAFwSVpTEY2vjRzf8X8OEmgZN4R0MKSzz9EhKHlWnnxIFIc+Hqx2lyI4W2hsmHfqA7Gira4a8lczGMdNyqXS2ra7CxPtVbv96EidO3sqav0a0/xPgghGCbIWxSmOIDQDq/PRic37+i9u8HMSGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 14:14:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:14:59 +0000
Date: Wed, 13 Nov 2024 22:14:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Ma <yu.ma@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tim Chen
	<tim.c.chen@linux.intel.com>, Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs/file.c]  0c40bf47cf:
 will-it-scale.per_thread_ops 6.7% improvement
Message-ID: <202411132104.c3e2d29f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7331ff-9637-4afb-e87f-08dd03ed8e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?pF+/mMpPoF/bjkIJXmqEU237A7g8G2jume5JPQbsy7OXihY7YSNKG1so/y?=
 =?iso-8859-1?Q?ydlkMSZAscmt340NM0tqKzEwQy9AkAKbk//xoJ8YpLu7J69vXuV4GjwASq?=
 =?iso-8859-1?Q?JaMkpKu3dr20ZhSNzdVeA+1lF4mGt0v6gxN9+X8cqyw/LRaEHtQlLsK8Sb?=
 =?iso-8859-1?Q?DzvhCRKZK4RnoOYK2E6MB2eQd5yzVGNL16IKEFTIh9HzAY78xTfCP4PPMD?=
 =?iso-8859-1?Q?rFQ3qK09htTrG+X75GptuGCXhf/qZhFVebYY4tP0VM8DCPJrHZC+3wVOQF?=
 =?iso-8859-1?Q?BMs9KCc+yTnPsymwMEMMau4FSASJ3pefjnbVn+JELgZ3SUSIl3kvRKeI7F?=
 =?iso-8859-1?Q?xrU0pcPq6BXEne2Sr17rf9kE8cxFbnjORMPWLKylsKPDQTG9vOS+Ec6HB+?=
 =?iso-8859-1?Q?piu6gT78+iDN9UICO/IDvCbY4AvHce4lEShs5c4A7Pgv2ZToywUuhnLuiS?=
 =?iso-8859-1?Q?XQ4yyy0PZqOrhAwgrpg1EGsQyMLnB6F+MqP3MEVpLxA4TxqADNA0bfnkOG?=
 =?iso-8859-1?Q?cn8TQelxOs4KF5Np45oSi+bZ9NoFb0lwA/KSVzaz05aYEOQjDit4E9vaIp?=
 =?iso-8859-1?Q?YrPnSqhSKqjk8Gv9FLX/TEJRjgPezLZu30fdk+WD8GHQilWADrJc8Mwa4R?=
 =?iso-8859-1?Q?LdcX0t07PvEAXfyoB89Q3HKq6F94Ny4YWBR+colnyGJ6qDwmdZhMwWn8C4?=
 =?iso-8859-1?Q?9zXhdXSA0dc5h0GdHf4z4W9n2q/SNTZ06wNydWWm6xry1dhMTc+gd1D6ju?=
 =?iso-8859-1?Q?ZdQWNQ+9U8gdE8wm02Q9QlKiCcREn+LAMHhc3XZmzw+hfYPL0SbBSZrfV/?=
 =?iso-8859-1?Q?LJrKwFt+F4OPgpoqOa7SBtiHJnfS7ujYN2vlQiVTfFLQVbK9ByZdO7kT+b?=
 =?iso-8859-1?Q?PMBAk71qroiObh7llLli81ZtiULZK9W0EPLAiMO8uX8v0YmFl6m6cpaKcL?=
 =?iso-8859-1?Q?ZG2wTIK9AB6yGPuFWfLQndOUmES2bYoJP4IFkZwJWk0BaZjr8UgX1a6l7f?=
 =?iso-8859-1?Q?AXDaFvX1Pt+ISkpxqawcQhLGHtiu41dnqwiez3UtXI0rVOMwirs/wSSihh?=
 =?iso-8859-1?Q?WeifmwT0mghJ3W7Mp07dkKQHgrqt40JiXNv94DRKPWkd9kDMxUtFzR7dFS?=
 =?iso-8859-1?Q?6131xXmm9EgCAiPF8RAVG+2QzzEOkBcKLesQtkwXiSjGvDqIIqZR7bpD7L?=
 =?iso-8859-1?Q?u9fUNUpnQJ6CRBatxQ5jvrRVl1jk9QDbbWMaPYP1mNizCGkeaNqjYI+dEd?=
 =?iso-8859-1?Q?TwoS4g5zO2Iq7yS0TYee8dBsRnT1kqx1EIL4bAn8gzhSQ62cnZYnItevt8?=
 =?iso-8859-1?Q?7HvMOtrtv0RTiFiMujdp3BVKYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gJr7jYmbD9b9nV8VQlHRl4KLR16R5c6UyzLrLiZTLocpCV7C6oJcaIrlHg?=
 =?iso-8859-1?Q?CSlGka0qTC72wU4a3Inzu2uceOR10V+oS31iO6Xf2bgopch6WcoDOxD4dQ?=
 =?iso-8859-1?Q?VzNwIG5dWX3EETxxHeXITw/J56dMjhG1r/fXJO2GQEuhPwImrXwXX9Rfaj?=
 =?iso-8859-1?Q?46r5cUro7iV8xbw2SfLUGjbWQhhP1YXtmy03Fg0lf1NG3hYTx6Ngrm/djX?=
 =?iso-8859-1?Q?2aruZUmzeMHP0vv8u5OznqxfilhRRC59BY0vSp8JbSMDItJQXISC9EqabT?=
 =?iso-8859-1?Q?lEZblIPK9DoC3OagTLNUo/TlIC434dKvtqxIkRfIA0nnkMtkI2kDy6jneg?=
 =?iso-8859-1?Q?1SH8X3y3dfMdfZDCgC+YvtCn3tok4cste+yA4zIcmwjl+Fr3fk2JZmpYWB?=
 =?iso-8859-1?Q?QDO5CoxIrxtoAga/1/FPivak481Xhc05qHh6c1df5srGzlO96Ll1TUtE4d?=
 =?iso-8859-1?Q?9yKkl9zmGmrMHUjJ3YjhcBuOwaKOO79gw3URzHO+gIYvQJ5GJoTZOsGnz6?=
 =?iso-8859-1?Q?Vw/v4WNS4BhSrhWqHndnQSd+SkedLuI7G4pZq1LB14ZhBhKbjscNFVcYM3?=
 =?iso-8859-1?Q?PvmBA3SYY3yyyjDB3InszuQHj9waqFu6dFdq8a5vGxuJhp5VMo9MW3rWqF?=
 =?iso-8859-1?Q?nETEA7NuUdM4wHtVnRIaImVyV0YCeRzYs1PHEuZepOG0s4Q74Kp78SFXZ3?=
 =?iso-8859-1?Q?bd57VjuB3A7V7acboLshmWBu1qffIl0gXx1F9ybiHVnlsmDwJjTK06dazG?=
 =?iso-8859-1?Q?28SMf75DoClq4VQyz0EyfnbzQPtB7IYF73UXj5dzplQGGkWJmfPWVGfEJU?=
 =?iso-8859-1?Q?E02qzoWDBkDjlKlzApuy/OOX0aFODuOCjzW+ng/JuM0GmEFAbrzRreCaCH?=
 =?iso-8859-1?Q?WDWABkUJ5zE1gAbeNv7L1GlNcEh4To4jrL2A/WbBxVTx5u75czzAH3GIoy?=
 =?iso-8859-1?Q?O/wwo9yXeNmMf0h7zN5dUF7pkFoMNsauZbQGomKh8lfnLTfugSbZIcSre+?=
 =?iso-8859-1?Q?vEyq8M+tSmBW7Cy3rOk2XbVTvV0N4fMP6JUHYgV34+aedD3gFLTvGRRZ1a?=
 =?iso-8859-1?Q?T8lOkaL9ih3+/y1oQYVjlOZZ+au6mMz86qNkoEAy5dU+0YoeWFCgCQgFJz?=
 =?iso-8859-1?Q?QcrnHL2jOQ5vZPi/VHa627ERKZpHOOHB6+Co8aa/5/l3VebxJNS9xhSdsQ?=
 =?iso-8859-1?Q?3Aj33V8JOwg3hze2bUasgxkXr6Ip8dxSwztmq/bdhsFip6P7B908+VQPBQ?=
 =?iso-8859-1?Q?DbEsqCjDQCI7KY3NkaE3HMcDyBZMT5g6OKWXMMu2BZ8pgqOfGeLviCsX65?=
 =?iso-8859-1?Q?iBd7GPRxR653Ys4dLfV5iyXveOYCga+1qnFGokU+c4gdxPnF6MkyabdKGU?=
 =?iso-8859-1?Q?O77Hl9d6Ig+bKBvwJgrZIZHRf4spLrvvr1YROjkSd3IBZEGaSEZiIP7ebt?=
 =?iso-8859-1?Q?F6wnwYy1+V2RyoI4ewx13nU5Ty+9VvvrK9ICCsxNKBRn/zmNU0p0ey/pXL?=
 =?iso-8859-1?Q?luUZ5bfhw7q0oTf2ieDEifg+1wZ/XKP7oo3vxGjVa6QuBq7Uv50tj2O66X?=
 =?iso-8859-1?Q?y8TJp+ECK7ygWgU3J6cpG0CgNiGx11Kk+XHwEOxZo1EmZD7QlTSsciOesn?=
 =?iso-8859-1?Q?xnmtxzkClk3gJspgOFw9kT5p96v+UlbdQL7qxFaZKgxYAWl+LHuNbwCw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7331ff-9637-4afb-e87f-08dd03ed8e75
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:14:58.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fudZC+tdrbhjjRyRj2w1M1bL0PbTN8By5UbtStP65r8viLMn8SSHtb0cuPRNs5aayaYz1FeQZHgwx9aqU2AkQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.7% improvement of will-it-scale.per_thread_ops on:


commit: 0c40bf47cf2d9e1413b1e62826c89c2341e66e40 ("fs/file.c: add fast path in find_next_fd()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: will-it-scale
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_task: 100%
	mode: thread
	test: dup1
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241113/202411132104.c3e2d29f-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/dup1/will-it-scale

commit: 
  c9a3019603 ("fs/file.c: conditionally clear full_fds")
  0c40bf47cf ("fs/file.c: add fast path in find_next_fd()")

c9a3019603b8a851 0c40bf47cf2d9e1413b1e62826c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     33.83 ± 20%     +27.1%      43.00 ± 12%  perf-c2c.DRAM.local
      0.42 ±  6%     +26.9%       0.54 ±  8%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.29 ±118%     -58.2%       0.12 ±  2%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.42 ±  6%     +26.9%       0.54 ±  8%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    878341 ±  2%      +6.7%     937496 ±  2%  will-it-scale.224.threads
      3920 ±  2%      +6.7%       4184 ±  2%  will-it-scale.per_thread_ops
    878341 ±  2%      +6.7%     937496 ±  2%  will-it-scale.workload
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__fput_sync
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.find_next_fd
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__fput_sync
      0.09            +0.0        0.11        perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.find_next_fd
      0.18 ±  2%     +11.5%       0.20 ±  3%  perf-stat.i.MPKI
     26.36 ±  3%      +2.4       28.75 ±  4%  perf-stat.i.cache-miss-rate%
   8636784 ±  2%     +11.9%    9662915 ±  3%  perf-stat.i.cache-misses
     76932 ±  2%     -10.9%      68510 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.17 ±  2%     +11.8%       0.19 ±  3%  perf-stat.overall.MPKI
     24.92 ±  3%      +2.2       27.16 ±  4%  perf-stat.overall.cache-miss-rate%
     74960 ±  2%     -10.5%      67085 ±  4%  perf-stat.overall.cycles-between-cache-misses
  17263265 ±  2%      -6.3%   16180844 ±  2%  perf-stat.overall.path-length
   8605013 ±  2%     +11.9%    9625712 ±  3%  perf-stat.ps.cache-misses




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


