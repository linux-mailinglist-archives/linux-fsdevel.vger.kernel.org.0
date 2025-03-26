Return-Path: <linux-fsdevel+bounces-45065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB89A71208
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 09:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752893BD189
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AE51A2398;
	Wed, 26 Mar 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnrAjImd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68927157A48;
	Wed, 26 Mar 2025 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976305; cv=fail; b=r9jNsUmZ4HApcXm3du7yo+UvtuA6M0MjnoM8eXTiAgbwWBhy5eCDXiOVxzCFRzouQdwtloELNRlNhmHG0XrEm4Mgfs4Ape+POKIr3krW1NZaellsUen6VNVNCbX3FLxABLOwqGtI47TQkBx0x0WsR4blO2XUmQ2Pgd4EPLt0zEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976305; c=relaxed/simple;
	bh=8KErA7MrcF1deAQL2eTDga63mMDwAgDz8enDvc3pbOc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MOvcNakk+1M0sEDK8tV/GtuA1hHXbFs9vHrh/2HBkRcVxL05Nnajbao1mwwhGoEUCizXgehyCRFTAT8MRyWtDR8qvysqLuNoB0dbSmPjRL0liMhBdgHOao4KetkTzZjcbRvv8UANnFds+NTo5ux+5a7z6oNUx7n0AMCyU0NBt1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnrAjImd; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742976304; x=1774512304;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=8KErA7MrcF1deAQL2eTDga63mMDwAgDz8enDvc3pbOc=;
  b=WnrAjImdpX+pQG2qaR2WA8s84MNEvucvW4mV6W6qn8z/GxhhhSeuwVDA
   bs40LqNEZkp/cx+sAIXuKyoEDLA7g4OZndF6NeVzRbi8KnG+lRELX1EJW
   eMnSUNG/JzE9+DzDBTtCHb8wx7IIFEWa1ugtMqTcXzmPzKu6JJ4YlGTn9
   LoFjbSNiUDAVtIa2LyuRLab+3UFB7S/7WRi9ehEjedxLQeK4DWpelw13X
   gAiPgVdRj3ka7VyHTHs0BYM3S6iqvAu8SPAAlsiTyXIkB+ifqqtdywksR
   Ls3tDnu1emnoIuMv5mhlSOEgyLma7ahrk+lgWhUNlST/bLGe7K+btELZ7
   w==;
X-CSE-ConnectionGUID: yOXw6oxiRu6/WxxZ6kRZKA==
X-CSE-MsgGUID: wcIWZI96SfumBaXBmSo3gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55244314"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="55244314"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:05:03 -0700
X-CSE-ConnectionGUID: Voswt8KkS1qxMmTv78wbIg==
X-CSE-MsgGUID: m/HQ0f7NQOa0mQ1YmBWbMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="125143472"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2025 01:05:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 01:05:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 01:05:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 01:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHoCXJZxkPJfvPDhQ1Ly6/wTlnsRLUww7fXkrp0z/gJNlwOt6wdhAA9Eyplvv1pg5k3mF3Kqcyuu99asGdAAmmpQtv94+sR9vuT6FStipZhRFmRBEXwbI2dUp1SkaWaBe5+eoaJZB6vIh0rzq0mebEWLw9w7jU8YwcpqiUrFxw6tlayQwynnAdmmCzSdOPyckrXe/Df4iQTRvVolHJ0WzCjOIJMLJMTjmmqPKavLEfrUqREoOiYbh60wNvMRuzNmcnVQ/7P8fq1Y2yz3/usL/HCVuHt6WVmKRJe/FLJ0Fg83cmfs6rSGmBIpV38UPkp7q+lqtnu02SdOX5OEHLJ8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul2QY9OBD8oNCH2QaeTCcKDblQmAMOBZockHk+o7kmk=;
 b=bDdgD13e6fG503aVxYY/oANY1/O4fyYe09cOskpVBwSj536Gn/tTwVMriCgKuM4EadBqSy3S5hAVPLPMftZ6mFFX7t17W+7qMOvjRnrW1X85wg5Jz27oytMuxWTTpFfEzTtEqxF9al0iFJifYF5RVt4iyyYkkduJgUaqQsbGvz1vLqGrnNH7ggOr9tIFHFU/2L5Nr02D7wQjL7eLXmcKGnZNeSWsHqJD3wpIjUiCsPk1el2fLNqIB2OyAHmwWCv0poNjDADkzqHo0Eegft5qkGQN4qo+Bj8x1DjEnUX+k5/R+BnpFmkZEoDi2Qsw+/NW0oaP4pC7sblytNhMkYl4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB7655.namprd11.prod.outlook.com (2603:10b6:806:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 08:04:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 08:04:58 +0000
Date: Wed, 26 Mar 2025 16:04:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Pan Deng <pan.deng@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Lipeng Zhu <lipeng.zhu@intel.com>,
	Tianyou Li <tianyou.li@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [fs]  e249056c91:  stress-ng.mq.ops_per_sec 94.3%
 improvement
Message-ID: <202503261501.2a99ac6e-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca26ad4-bf1e-43f1-d4ee-08dd6c3ce6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?dfOzvcZU0PXUR3gZz0hX2R3Gif5emkoR3ExMbWgo3wBd6LB4s3Rv1so1Rw?=
 =?iso-8859-1?Q?y2CV+D73QNV57q6Jg6YunOQNB2l5mtMNDIrrKny0mBK2k3D46Px4x98Y4D?=
 =?iso-8859-1?Q?fN8AbOvG8/MBPcdquZ2uD3PUqRMnFqO/WDg/iya4hXCvZQgdA3CfJziNVj?=
 =?iso-8859-1?Q?FOn8452EYaV3GyCaxATr6djoE5cccEPWWAyg3rc9o4sKLAQA1nfY49et3l?=
 =?iso-8859-1?Q?o3atLdK46pnsZPvpOCLVYNgoDh3f2SrLzEyJTFyzY21JeHr5mpAux9Unbu?=
 =?iso-8859-1?Q?J8lVeem/ktc4x+waIX36oevTQdu5sOaI/PzMRK0ceEf8lpu/HonUtFqj6C?=
 =?iso-8859-1?Q?/rjqdxOVbjVR2fwebIpLE3V2fDyYaKhY2AVUDtitkPAjZls828MqwN/MtH?=
 =?iso-8859-1?Q?ZGOEz2qP+8nlS6701CKBia0Fgo1Vn4gw7K234lnrW9D+lx/DmMez0bJtrh?=
 =?iso-8859-1?Q?gyQ1Bpa3kLOpb4sSriDRwi9fa1nmXOp/zFhWhkX3uGFrzT6hcJZmc/PySQ?=
 =?iso-8859-1?Q?nwmdtRx+FpceXrTcKjpGFOFOgyX6rTJpf8WraIFAPT3QMUwMvQJoVUCjOZ?=
 =?iso-8859-1?Q?ZrIUYjJGir3pkpktHdytTyP3md91Dn/aHZuJALv0HezAEs6Yt39Lf1ptuB?=
 =?iso-8859-1?Q?WvkwsIg4YuVQQ7f+YjjHqfgEw/C3qpPQVYNHXZY2YH5w23UmSLTUE+uj8T?=
 =?iso-8859-1?Q?UPpoBy8Vb7Wyk6tw8VzTsGulnQQa1IyGUWg7b+jRQBcskTfS5UP1dwep8q?=
 =?iso-8859-1?Q?Vvz8HxnEzdif1sGP/kuBDFbTS0uaNe7BFc2VpDUr72Yj4yqxXkDFA/7C1v?=
 =?iso-8859-1?Q?0NZokgqK3UCb9Hp/zteSRohB0xtbcjQ+IJKSmjRtGj2UAyJMytrqwiyQjO?=
 =?iso-8859-1?Q?+aM66ddpU/lEcMmUKRnhN7+DbGJIy/ZAYIXLPPsZM/T9Q4cFVmokbd9Xt2?=
 =?iso-8859-1?Q?Ohu+RtAZs2gmm/cFMPc9yYNq71hVqs0FQowzCXbJ5B+bBJFYtLBLzIYOYp?=
 =?iso-8859-1?Q?zOWmSCBkedF1YvZ7naCfl5SvHBiyS7HvkvL8qRjqXXw/5vrt7+XSLxInoI?=
 =?iso-8859-1?Q?ythd4uXxgtZW58PlySuEwFt/nF2mcmyZY6p13+GQ/08ApyQu8lEr3ypud4?=
 =?iso-8859-1?Q?cad/opQ8Cpa6FmnXOle2MeCHqdSuqeV1WD4vr1S6+S3bYaDh3oYbv56w5G?=
 =?iso-8859-1?Q?UL06v8Ma+CPZyDRXZCn3ZU44fUsaqBL5Lk5YQG/F2UBTuHPh+i02avoi9F?=
 =?iso-8859-1?Q?tk4fEjidXXfNexkIQtS582C3354205c0HEw2+qiShHvu5bAH6ICsX2St4n?=
 =?iso-8859-1?Q?yyfPbfaP0NqOJdVXKAlrZLTPgpzwZGtapRehwRqdH49xGsQDAnaP2+Qu12?=
 =?iso-8859-1?Q?Plgyrp3KygO95drWNoyuWoytDzIA7NMBSsE+LT1zOEhUP+qm4DD4sIzeIl?=
 =?iso-8859-1?Q?zNDEYqs607VtnOB3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NH4XwhyEpz1Mrd3UR6hoj+nukUjntaFE217098TlxJMCiZ1qBAs2Ei+/sL?=
 =?iso-8859-1?Q?4a1oGzuHrlbGP+dkalRHkRgONIq4lZLMTB9eQ2sqWjMWEDjEpS7cHABWpy?=
 =?iso-8859-1?Q?HvKmllenBxnunmKjW3zP/6y8rkXZFntzuTv3yPlmT1+UbeAE0nLucbrWAn?=
 =?iso-8859-1?Q?ybo33X3QLoz0MSgEtDCeV0OpN6RKowcWTMSfrwVu8hIwbCoJbQ9mBfRgZy?=
 =?iso-8859-1?Q?sDC4gUYCQMrRPmlDGyOU7AevRdGed2QzQm6IybQJiq2yEIaQcP6KX+bf3V?=
 =?iso-8859-1?Q?vHZ0qtclGYCEiauy1kCan+X0EMMk/0tded/Z+WRRIOrn1M04QFRLlR+iOq?=
 =?iso-8859-1?Q?CPdXH/pJwrBy3i9aWH28z1BRwlVC1l1OwhxGhWKLoQmfEAi6sCesE8mnRN?=
 =?iso-8859-1?Q?pvEYleqohg/IFq/eBQT2aPfvc/TH3W4Ny4iRxGqLJ9xkBNJKbL8BP/8NIX?=
 =?iso-8859-1?Q?hmrlewk4r1+9ZofBBUcZbd4XGh6XJcDIJasddlwUexGjf62mtxVyc5yyZm?=
 =?iso-8859-1?Q?9t47o0IVGxALurEsYmUbffWLkB5RDfHwhxh7V7TfmJPeS0RxDsaZ4OZYcs?=
 =?iso-8859-1?Q?xBzDaeO8jYQafqSwG3SRkeyCu0doOkVXCm1W1uqVqkHTx5BXBVsQsShxsm?=
 =?iso-8859-1?Q?GGAu0nXiHnfhRkouDOesUudkbElv5WF4pDm1rH5e6akKggoBTrlJUKcfDo?=
 =?iso-8859-1?Q?Bz3mHjBIxUg8sH7OmINqN3TxqbreEnLS94M0GFKwmALBiJqZ8UJkLeOMzj?=
 =?iso-8859-1?Q?5OQvWhXojodHo+75Nv0I+dzewVwfEsbI3LFpv2xQbF8fO6oI70C+DGdg1w?=
 =?iso-8859-1?Q?NJFOBAo7QR2tZSNpHdnazRabaFl6Lv7Fvny+oZzAhg6DL9ENVOCHtxrtws?=
 =?iso-8859-1?Q?qslgLuBLFDPFGbjwpimrsj318gxjo7+amgqzTgrUaPvo1sIxPMFNtt2vUt?=
 =?iso-8859-1?Q?SjmiPLKeWrbFACIzz9igzUizaTPv7JzSLZx3jUxKbP19oXlpTnQFqRGf81?=
 =?iso-8859-1?Q?uDBFWGbungaAI8gqx5115tXvPQi1mrrkLXbC+1m7vxz3aJl2Cl3RRNWXJa?=
 =?iso-8859-1?Q?R5tcb2+PZgIjLZOTU5lymJzvYlLTSN588W1yGTz+66neOAzB1ZyB6rXcdH?=
 =?iso-8859-1?Q?K6IOyqAdncZD23uV6HqHZEzkXxSaDkaVrRNR8ukRewararwIs12VYc87JG?=
 =?iso-8859-1?Q?fLc9oGHc5OP8C6K77WhZJDd1pJ59GR7fKXtyRQGW1ayI2058bZl4lCHM2H?=
 =?iso-8859-1?Q?Q+p7BvUQEsxYjperagWI8hWX7/mewysnSsxen7NF0O9IlNPSROcv2FKfmA?=
 =?iso-8859-1?Q?3stbTHpcsnnkM+o+mjT+ifuwvYH3nHPE941cUE11PcRZYA6zPbspW22SmH?=
 =?iso-8859-1?Q?AYN6h9X95J+axmna71BA5mfmTxYeXqZTQhlLko0zrDpIvZfwbE/2nWMwrJ?=
 =?iso-8859-1?Q?Q5eLhP9D+pJ9Z3oQjf1/YM0fq3HMFOcUHgJtePPE2cWt3jyp8+ZkveVjL+?=
 =?iso-8859-1?Q?EzmmGUkZsdOL1yotWR1UoRCumUPMkwOsNasFThDbwFYL7bcV2guN9JbYfI?=
 =?iso-8859-1?Q?eZFlKnyfzTK6HSHnLfkTkFa1Jah7Znk9K2YZcZNFvvGiKBV/oV+1hEu3n2?=
 =?iso-8859-1?Q?lVuTLHsLq4QoeN3AEWFabZpITd8nOKxoe3ZUghJmJf9L1vmTxqnxWhQg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca26ad4-bf1e-43f1-d4ee-08dd6c3ce6a2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:04:58.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gh+WTmkck4b03MpCgyx+7kVRndpL/j2Z/kpKHanrWb6Yf40dK6bsdblBqOSuvulo+2W5/fm+aPhsAfojhMGTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7655
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 94.3% improvement of stress-ng.mq.ops_per_sec on:


commit: e249056c91a2f14ee40de2bf24cf72d8e68101f5 ("fs: place f_ref to 3rd cache line in struct file to resolve false sharing")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) Platinum 8468V  CPU @ 2.4GHz (Sapphire Rapids) with 384G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: mq
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250326/202503261501.2a99ac6e-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/igk-spr-2sp1/mq/stress-ng/60s

commit: 
  d3a194d95f ("epoll: simplify ep_busy_loop by removing always 0 argument")
  e249056c91 ("fs: place f_ref to 3rd cache line in struct file to resolve false sharing")

d3a194d95fc8d535 e249056c91a2f14ee40de2bf24c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  16952975 ±113%    +479.0%   98151856 ± 20%  cpuidle..usage
   6298915 ± 11%     +61.8%   10188752 ±  5%  vmstat.system.cs
    522158 ± 18%     +59.9%     835109 ±  6%  vmstat.system.in
      0.43 ± 32%      +0.2        0.67 ±  2%  mpstat.cpu.all.irq%
      0.06 ± 11%      -0.0        0.06 ±  7%  mpstat.cpu.all.soft%
      6.40 ±  2%      +1.3        7.74 ±  5%  mpstat.cpu.all.usr%
    143216 ± 23%     -71.1%      41346 ± 87%  numa-numastat.node0.other_node
   1203882 ± 13%     +73.8%    2092918 ± 29%  numa-numastat.node1.numa_hit
     55987 ± 58%    +180.9%     157244 ± 23%  numa-numastat.node1.other_node
      1042 ± 35%     -82.7%     180.83 ± 21%  perf-c2c.DRAM.local
     40886 ± 71%    +138.2%      97387 ± 23%  perf-c2c.HITM.local
     46261 ± 60%    +119.4%     101476 ± 23%  perf-c2c.HITM.total
   1835281 ± 25%    +151.0%    4606463 ± 38%  numa-meminfo.node1.Active
   1835281 ± 25%    +151.0%    4606463 ± 38%  numa-meminfo.node1.Active(anon)
    300616 ± 82%     +63.6%     491945 ± 44%  numa-meminfo.node1.AnonPages
   1535692 ± 22%    +168.0%    4115480 ± 41%  numa-meminfo.node1.Shmem
 2.507e+08 ±  9%     +94.3%  4.871e+08 ±  5%  stress-ng.mq.ops
   4178927 ±  9%     +94.3%    8118700 ±  5%  stress-ng.mq.ops_per_sec
     18053 ±  3%      -7.4%      16709        stress-ng.time.percent_of_cpu_this_job_got
     10197 ±  3%      -9.4%       9242        stress-ng.time.system_time
    688.89 ±  2%     +19.7%     824.66 ±  5%  stress-ng.time.user_time
 2.076e+08 ±  8%     +64.9%  3.423e+08 ±  5%  stress-ng.time.voluntary_context_switches
   2440860 ± 12%    +105.3%    5012226 ± 35%  meminfo.Active
   2440860 ± 12%    +105.3%    5012226 ± 35%  meminfo.Active(anon)
   5221055 ±  5%     +48.7%    7762119 ± 22%  meminfo.Cached
   7184748 ±  3%     +36.1%    9777020 ± 18%  meminfo.Committed_AS
    361568 ±  3%     +47.5%     533427 ± 23%  meminfo.Mapped
   9552329 ±  3%     +28.1%   12232469 ± 14%  meminfo.Memused
   1692979 ± 17%    +150.1%    4234070 ± 41%  meminfo.Shmem
   9605594 ±  2%     +28.3%   12319244 ± 14%  meminfo.max_used_kB
      4885 ± 48%     +33.7%       6532 ± 38%  numa-vmstat.node0.nr_page_table_pages
    143216 ± 23%     -71.1%      41345 ± 87%  numa-vmstat.node0.numa_other
    460013 ± 25%    +149.0%    1145233 ± 38%  numa-vmstat.node1.nr_active_anon
     75283 ± 82%     +63.0%     122733 ± 44%  numa-vmstat.node1.nr_anon_pages
    384991 ± 22%    +165.7%    1022742 ± 41%  numa-vmstat.node1.nr_shmem
    460006 ± 25%    +149.0%    1145231 ± 38%  numa-vmstat.node1.nr_zone_active_anon
   1204935 ± 13%     +73.1%    2086163 ± 29%  numa-vmstat.node1.numa_hit
     55987 ± 58%    +180.9%     157244 ± 23%  numa-vmstat.node1.numa_other
      0.05 ± 72%     -79.9%       0.01 ± 67%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.06 ±129%     -80.3%       0.01 ± 56%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.mqueue_alloc_inode.alloc_inode.new_inode
    530.28 ± 31%     -54.3%     242.29 ± 61%  perf-sched.sch_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.28 ± 16%     -68.9%       0.09 ± 70%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend
      0.09 ± 88%     -81.0%       0.02 ± 64%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      1868 ± 67%     -73.6%     492.86 ±104%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1269 ± 25%     -49.9%     635.66 ± 59%  perf-sched.wait_and_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.77 ± 15%     -60.9%       0.30 ± 75%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.wq_sleep.do_mq_timedsend.__x64_sys_mq_timedsend
      3770 ± 66%     -73.8%     989.52 ±103%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.21 ±102%     -88.8%       0.02 ± 93%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.mqueue_alloc_inode.alloc_inode.new_inode
    739.22 ± 22%     -46.8%     393.37 ± 58%  perf-sched.wait_time.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      1919 ± 64%     -73.7%     504.99 ±100%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    608977 ± 11%    +105.5%    1251722 ± 35%  proc-vmstat.nr_active_anon
    188245            +4.0%     195771 ±  2%  proc-vmstat.nr_anon_pages
   1303984 ±  5%     +48.7%    1939187 ± 22%  proc-vmstat.nr_file_pages
     90548 ±  4%     +47.9%     133892 ± 23%  proc-vmstat.nr_mapped
    421965 ± 16%    +150.5%    1057174 ± 41%  proc-vmstat.nr_shmem
     41883            +4.5%      43768 ±  2%  proc-vmstat.nr_slab_reclaimable
    122762            +1.7%     124807        proc-vmstat.nr_slab_unreclaimable
    608977 ± 11%    +105.5%    1251722 ± 35%  proc-vmstat.nr_zone_active_anon
     39944 ± 15%    +190.1%     115861 ± 59%  proc-vmstat.numa_hint_faults
     27410 ± 19%    +281.4%     104548 ± 69%  proc-vmstat.numa_hint_faults_local
   1684470 ±  8%     +58.2%    2665570 ± 23%  proc-vmstat.numa_hit
   1485253 ±  9%     +66.1%    2466944 ± 25%  proc-vmstat.numa_local
    102341 ± 28%     +62.0%     165807 ± 36%  proc-vmstat.numa_pte_updates
   1751319 ±  7%     +57.3%    2754572 ± 23%  proc-vmstat.pgalloc_normal
    609827 ±  2%     +16.2%     708345 ± 11%  proc-vmstat.pgfault
      0.45 ±  7%     +20.7%       0.55        sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.43 ±  6%     +18.6%       0.51 ±  2%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
    267.72 ± 12%     +27.2%     340.40 ±  3%  sched_debug.cfs_rq:/.util_est.stddev
    586830 ±  4%     -10.6%     524667 ±  3%  sched_debug.cpu.avg_idle.avg
   1735827 ± 29%     -33.7%    1150356 ±  8%  sched_debug.cpu.avg_idle.max
     15839 ±143%     -77.0%       3638 ± 10%  sched_debug.cpu.avg_idle.min
    139.91 ± 42%     -86.4%      19.08 ± 21%  sched_debug.cpu.clock.stddev
     24838 ± 35%     +87.7%      46614 ±  8%  sched_debug.cpu.curr->pid.max
      2342 ± 22%     +63.1%       3820 ± 10%  sched_debug.cpu.curr->pid.stddev
    631455 ± 10%     -19.1%     510552        sched_debug.cpu.max_idle_balance_cost.avg
   1697254 ± 18%     -53.8%     784378 ± 19%  sched_debug.cpu.max_idle_balance_cost.max
    175055 ± 25%     -80.0%      35047 ± 47%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 48%     -81.3%       0.00 ± 35%  sched_debug.cpu.next_balance.stddev
      0.44 ±  9%     +23.6%       0.54 ±  4%  sched_debug.cpu.nr_running.stddev
   1043526 ± 11%     +59.3%    1662017 ±  5%  sched_debug.cpu.nr_switches.avg
   1390822 ±  6%     +62.8%    2263820 ± 13%  sched_debug.cpu.nr_switches.max
      5.88 ±  8%     +31.3%       7.72 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
 1.336e+10 ±  5%     +63.8%  2.188e+10 ±  4%  perf-stat.i.branch-instructions
 1.059e+08 ±  7%     +66.9%  1.767e+08 ±  5%  perf-stat.i.branch-misses
  11257488 ±  7%     +73.7%   19553240 ± 19%  perf-stat.i.cache-misses
  1.11e+08 ± 87%    +281.9%  4.239e+08 ± 11%  perf-stat.i.cache-references
   6566144 ± 12%     +62.1%   10640456 ±  5%  perf-stat.i.context-switches
      9.35 ±  4%     -43.6%       5.28 ±  5%  perf-stat.i.cpi
    119675 ±145%    +424.8%     628084 ±  8%  perf-stat.i.cpu-migrations
     55311 ±  7%     -40.5%      32929 ± 13%  perf-stat.i.cycles-between-cache-misses
 6.609e+10 ±  5%     +64.8%  1.089e+11 ±  4%  perf-stat.i.instructions
      0.13 ±  8%     +56.9%       0.21 ±  4%  perf-stat.i.ipc
     34.67 ± 10%     +69.3%      58.71 ±  5%  perf-stat.i.metric.K/sec
      0.10 ± 45%    +102.6%       0.21 ±  4%  perf-stat.overall.ipc
 1.074e+10 ± 45%     +99.5%  2.144e+10 ±  4%  perf-stat.ps.branch-instructions
  85818545 ± 45%    +102.0%  1.733e+08 ±  5%  perf-stat.ps.branch-misses
   9043150 ± 45%    +111.7%   19144861 ± 19%  perf-stat.ps.cache-misses
 1.008e+08 ±101%    +313.5%  4.169e+08 ± 11%  perf-stat.ps.cache-references
   5233955 ± 46%    +100.1%   10474383 ±  5%  perf-stat.ps.context-switches
    117697 ±146%    +425.9%     618947 ±  8%  perf-stat.ps.cpu-migrations
 5.317e+10 ± 45%    +100.8%  1.067e+11 ±  4%  perf-stat.ps.instructions
      5717 ± 44%     +52.3%       8706 ± 16%  perf-stat.ps.minor-faults
      5717 ± 44%     +52.3%       8707 ± 16%  perf-stat.ps.page-faults
 3.319e+12 ± 44%     +98.7%  6.593e+12 ±  5%  perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


