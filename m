Return-Path: <linux-fsdevel+bounces-55092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C5B06DDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76243189E8A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 06:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0B2868B7;
	Wed, 16 Jul 2025 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bly6QbDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747D3376F1;
	Wed, 16 Jul 2025 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647133; cv=fail; b=GeqiuLca1J1yMevchlV1Ivmdjg9YdVa8gyLgvY+zOKQqsoosLNj0XLuCcPcBB45vFIfkRMCInpq1DaH6k0bK3cJQo+QQ2F0HfQhTupImAs0/rP9T/exPrpIdxhS24RG+VxAWQAp74dobZPXk+S7vr9z5UIft0X9BElEimtuOLIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647133; c=relaxed/simple;
	bh=oN3pcA55LUQbdmEDhzCg9OZtcWeKesY0ywWYg6lo+Og=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZfw/8x7gtoTARX8eNN3xDSM1ATY9ZDADC59qtRzKrtMOCUG4d216mDvvEiG4tkc1qLtzkzQ2O9Vhh+T9oLL/dmfqjNUIguy09Xw34aoxSi2BsLkZ7aQZGqW3zA0hZoJf8tAO2ChfjX7Mg8MUNsRWey2f5NrndjtZf0V0uWnohA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bly6QbDO; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752647132; x=1784183132;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=oN3pcA55LUQbdmEDhzCg9OZtcWeKesY0ywWYg6lo+Og=;
  b=bly6QbDOFJt7+kI1621IDing+AoWaOa/UNTwCdOzwjfKnh6YsOTvsD5M
   bDFxzO0MxSUeJyLLtMn/rCir2WZ8xHTQ/1uoAqUiKO9Db9ibv+4wbW+nW
   95hhHH0C739lMwWtgUUDQw9HcrXQHWlE27X+D2tXOpmifcMJj5f3de99S
   FvZ3VFt5J239IJ/A/h2IdazE0EeXvW7EIJHhanRf4Zo998bNhvl2RbWz9
   nVPVCBF/HtHCfj+sHCfK9K6dyuuHRWBea4cMYi02vcOpUT7kZfAge/oAG
   AqI22e3GuGGxTheP92vMXpHj8eWUZfvJO4vubiqcPMKfVeAQGgXU57wVD
   g==;
X-CSE-ConnectionGUID: sp8rwhRqTCecu4RMiOzVCA==
X-CSE-MsgGUID: uzEIzTaERcawt5qsimh2OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54736161"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54736161"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 23:25:31 -0700
X-CSE-ConnectionGUID: PHZsNbyOTB6wogyF21edbQ==
X-CSE-MsgGUID: 1Rjzdx5QSsS4f8rAnnUZ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161962476"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 23:25:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 23:25:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 23:25:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 23:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOp4JUJHpIE+mRan1i5HEvcE3S0v65Y71OL/VvrM03bYgSBVh46/qXyI7pvWXWf1+H4BYhj0T84//SO9z2Z/uspclQ4gEMQlUuqxaNAp426TR+ehEV0ncKj8B0XMSSydJLwl/b11/Qt2S3J+tLop3hSAi/QlSXuMFCbU04OaSgoyXa3pMpByp1GpYaCfDzJHe6aJtrtq/rxLRk5i7VXI4F+5V+aaSqCmQ/gQO7NuC6cYyoFpyKSqmRjI4+epxozhZ31hp4+Br+gTS9aS6vSKFZHLk+qvzbUzd9Sbd4+tHfPQq0HgerZvWwOUTF3IbXmoMpRSVJn/p07inSDycc3NpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCOqGItaMlELFXZd7x0P6GodPUzQhS8PSjZHOrr16Fk=;
 b=LlepgF5TkeKk78UuyQ0M+Nf2K7kXoc8tq5GPqjdgH8YU6+seAZ6hafvG5kky7CRYwA/uCtUhnXda3KMcHXC+zQU75AxdrB3eZFK0baNORNl7gtdAC1pUi6MMedu7MbjdGvb+0sAylhFZj+Qtn2dwYs+we38svG944QwLg72qD7b3XSp4dmWW+HaklaK5swHdmy1PJGY74qIBvUYfAkTsof3V7UUrD5hRno5i2Pw4jVp4Faukmf/prPZDEiqldVd9KfyXyYmAoAyA0xpeiRAfy34lY8tI8IWpGjbiD3bNeqENQEhBN8eHnv77WXPybKGUq5mXl1qyZTMrtDry7SyV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 06:25:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Wed, 16 Jul 2025
 06:25:27 +0000
Date: Wed, 16 Jul 2025 14:25:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Amir Goldstein
	<amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ibrahimjirdeh@meta.com>, <jack@suse.cz>,
	<josef@toxicpanda.com>, <lesha@meta.com>, <sargun@meta.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v4 3/3] fanotify: introduce event response identifier
Message-ID: <202507160713.34ee11f5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250711183101.4074140-4-ibrahimjirdeh@meta.com>
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 3976c7a6-6655-439e-c1ba-08ddc4318e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W/5WeSvVrQHsMwNLZpUpR8JiK2g1cAyIo3VrTpu8vU3BlxSEQyX9bYSO5b7A?=
 =?us-ascii?Q?1FVahQdIvZqRHXQ9fN2K0V0eHyl7GsGsdGYsqgYCYoEkylcvYWSqmhL5s4ea?=
 =?us-ascii?Q?QdfGrJ5qlYBo+nseLWh+9Z7iuvlqD+Yt2r/yfX9iVtYMLYhsrNnVYxX8qn8V?=
 =?us-ascii?Q?QhTRZj/GrezePheFzTHlviIgq5XGud7W9HB/+CpDtMXQ0wRhl+TmGrb819Cb?=
 =?us-ascii?Q?J4UjvAhsISnOQjqcVg2PE7hl1AkkX3p/6cLkrfB7Eh6Bq4hZ7QPZ6pTq575E?=
 =?us-ascii?Q?RJiA8iwnF+aEqTpY1PtKXBssfNvxc14BT/zMSeaWveOXYzynIY5MF7AF6AcW?=
 =?us-ascii?Q?aoCDyprR1yUoA/44O9yts/shAGkWncWwyYaTSUN9TJrof6GKjrELh7JAm9/Y?=
 =?us-ascii?Q?H9eYi9zUkd+7Yj8A2Plxs3paLYe5xNRSqh2fuAC8QiiL8BjXi+wT0cVdLaBF?=
 =?us-ascii?Q?cde7b4D3QKdQYQpCLHQmAaUJr1wboIMzTya1wDsq3kT8awo+v23JfIIBV7GX?=
 =?us-ascii?Q?LMG51mDJexd0/LCG9E0oOgW+sar03xM69UmqYJJHxK6bD5eflC1Nv2uVTFx/?=
 =?us-ascii?Q?n13I47+Zk9gLOs12T1T4t6K++v9uHkEYj+xkVKejkAYYVRibCUSq16YKFPv/?=
 =?us-ascii?Q?Eg2x+vG/64X4yHmhJ3vvo/yq/1BjQsQe+4JhPz/GQ6WHEJizrhlHZxY+4NaU?=
 =?us-ascii?Q?voWhJCvL4XeA9zvvpcjXaPjKjwDMjPjplBLb67MvYkYUpPAzo5i3q7L7gRoO?=
 =?us-ascii?Q?fs3J2VTuWzrvsQBBSHWm/T0kPP3yaMREDSnF/IGJUbtS+08P9AzDuRX6plhq?=
 =?us-ascii?Q?IAinTxenQkNz1M5M1uHGVXfvaOve0NI5VNQi+1OxUtjFGdGwyzIaUsAnWq71?=
 =?us-ascii?Q?4UiKwBPULJoQvNgN+QoGhrpPV1z1Yi3LzuN/pqi8XUEuD/jccTy/G3z66pEU?=
 =?us-ascii?Q?qvrA6onqGex/fSBqv/AJxwdnKKxZMtWKMkGlePT5G3AFV8WLoOBXiats3MyZ?=
 =?us-ascii?Q?iTlJVYz3F89AzUPXXExXGCoO43qfGp8MRAFJRyAqS45EorrTb3TvfIzsQex0?=
 =?us-ascii?Q?BxMrJ0pzJQ0c90ndHSuPdq6iV+S8HblVkn1xBmKkitWzM7e1HtZDsbM9nSAy?=
 =?us-ascii?Q?8x4dpMXve0v5uOtZYgsGCvDoDFoOLZYvnfEfar03kH5lym/YyFgE78zr1XPq?=
 =?us-ascii?Q?xAkj6qS3n+MU4vzx0uBZSAdNg+8kMyfcmvJHQjCYuNNMDN/qf6s/MPsGCa1l?=
 =?us-ascii?Q?dDV2DPxnLX7+JRZzctspF5T3/FlQgkVf5TujWUBgVBucRYBlqKvRwiaIMhTR?=
 =?us-ascii?Q?c2VZRgPKgRaptPJnZoVGHje/bZDI1JxdMLUB2UANW7B8k+xctmXwo8QVITY6?=
 =?us-ascii?Q?nYdMYadEpMY7JSfanz0ELS5XuNYx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6rrYmrOCvxoazNzkqJJDqiQ7Q2dnyYQgN/1NIE1IorF90QVG9IDeKKungFq7?=
 =?us-ascii?Q?rY7OUwDBcLIDfIdUQwa4pPIKtGmXpTeiOXkUvcy+vopDCoAE40+hzFt+tsMH?=
 =?us-ascii?Q?OWNCx4TJ56PC/Bi02pGlEvhs18AadMhiCCCUiq+fgX3+D0uFilxkiUgrVj1o?=
 =?us-ascii?Q?Wy0CPLEKnx2ER6qEIfv8rBSFMz6R57tLOoEzwdzJFLVVKy8IAAoKAMGyQg9q?=
 =?us-ascii?Q?/lsJpbcmhgki5qA17Gj75EOFsDHFmExbrwvJgwUz2VzMkqRl+/Oa2BspgLeZ?=
 =?us-ascii?Q?d8WuHzHkwG6QthqxKqKdckoA2+oVwpRYou/e35+auVm4k3H5FKRf15LR08rC?=
 =?us-ascii?Q?O2G1S6A/HyWlkP80nm4T6NK2BrTUK62r1AZNVmPCiPZX3r0ZgQMod2asXC0h?=
 =?us-ascii?Q?ThJvpbvIZREeSkOdk6ZUU4D7mJyhQag92sBbDlaIsjuX5kSnU7tHJmAzR2Pw?=
 =?us-ascii?Q?sNgLHmxeDJumCx5Pj0K4mrOh8isZAIsZfxqEgJ419oW0hIApiOlYUq5v0xFg?=
 =?us-ascii?Q?RHyo19tKLXZjCyxprOacWD5g1RxOqeX7iGtZHLrTCGItbAkIGvK3zSEkvXnv?=
 =?us-ascii?Q?ryxNuha7cQCyLEGVPRNAWcQGKMpgrU57dYtV844wUC3tGUIo0QT/361h/RZA?=
 =?us-ascii?Q?hc61bOwh9RhmeYPo0fvh74HOC8jS8yajZQ/giqVr81wFK6wjTUQ2QeIpKe9P?=
 =?us-ascii?Q?OOK91C0KMlZGKYg4KF2Z4OVrl4vELq41vs7wDE+ptU6DqMc+tD3nL5QjJRHZ?=
 =?us-ascii?Q?IL7tMUXv5fUZn0DPr7SROzPHCv/mjm8Ur7hPrmaAX9CWhtuiHF/ZY2hAzgr3?=
 =?us-ascii?Q?fYwm2Gsj+zCncYHlVASvuJeLBwwM32Lg9YdyAogreXtkv3tAYsOt8ztjry94?=
 =?us-ascii?Q?l+CCSrSo7HrGFM3srLM4DvNTLuDp82P92zyJUDkJRJQ7M+38KjZvBCqvSJiq?=
 =?us-ascii?Q?ehWEUQn2Bv2y4BIrPZmx02RSq+mcam5IcQB+NgXXU480rKCgd5iOdm3D/Xu5?=
 =?us-ascii?Q?uydV8JDEVyjualUjj01u6adrAXVsE/g1DyOj/yt/40yhmyh8D4+dQX+rwY0d?=
 =?us-ascii?Q?WF9E89rF+W58IgEAvX5wm652UDJSTQPxyHUvUHqhiplIL3WcQaxKicRn3ThT?=
 =?us-ascii?Q?YpqPkCVIk6Kyj0BtiP27o8YiHhxP4VeoAc1xpd85iVXkjWwhkuESmUGoQh6B?=
 =?us-ascii?Q?NLkfKgKz4OBORVn+oU25WeP2m6a+/Jd6Pis2nQENogAPkanyU7s8LSpZCOLE?=
 =?us-ascii?Q?cTnN/uE1ZWWrS3GBKK9n2ltNnuFPLUg9FzlOACAYciURY5RTeyCQxionKmeX?=
 =?us-ascii?Q?cEsznJ7T8/PWm+IVcZaAOGU9y9X+lqY4bKk5IrgjrQJb2QC+axq2CJsXq+2u?=
 =?us-ascii?Q?x2TggiJ39oaqNlnKfqLgN9RO03T6p5XgI2fT7pFE6ja8coepInHLd5i8zWg1?=
 =?us-ascii?Q?9/NbELeMh4iRHh7Hw/OWrMdhEzLoAyjQOQeBn+ClHya0fb3dir8KbH3Layfj?=
 =?us-ascii?Q?AfN4yMKjj1BfPmeaHo/AtUTLM9CZx7LcfFfm/tL6EYGGn9uP3/B8sYWXAgp+?=
 =?us-ascii?Q?go1CORXO0oRsg3PgZGKAzumTU9fTd+JM4Gj5S9QSCeu+yCJQffn+cUxzopaz?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3976c7a6-6655-439e-c1ba-08ddc4318e43
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:25:27.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FF8KKHLJlpFAAuIoqmqAwXgTccpJeNFakPGdBZuaJx3VHa6oK0mKN/lnttsu1yzGb36oYhpvj8tfn0TOl1z1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:trying_to_register_non-static_key" on:

commit: 16091e7d62ae910fee1e3bfc72943ec678e8df35 ("[PATCH v4 3/3] fanotify: introduce event response identifier")
url: https://github.com/intel-lab-lkp/linux/commits/Ibrahim-Jirdeh/fanotify-add-support-for-a-variable-length-permission-event/20250712-023425
base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
patch link: https://lore.kernel.org/all/20250711183101.4074140-4-ibrahimjirdeh@meta.com/
patch subject: [PATCH v4 3/3] fanotify: introduce event response identifier

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



config: x86_64-randconfig-006-20250712
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------+------------+------------+
|                                        | feb842cee4 | 16091e7d62 |
+----------------------------------------+------------+------------+
| INFO:trying_to_register_non-static_key | 0          | 11         |
+----------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507160713.34ee11f5-lkp@intel.com


[  570.145604][ T3660] INFO: trying to register non-static key.
[  570.152934][ T3660] The code is fine but needs lockdep annotation, or maybe
[  570.161254][ T3660] you didn't initialize this object before use?
[  570.168674][ T3660] turning off the locking correctness validator.
[  570.176388][ T3660] CPU: 0 UID: 0 PID: 3660 Comm: trinity-c3 Not tainted 6.16.0-rc3-00238-g16091e7d62ae #1 PREEMPT(lazy)
[  570.189708][ T3660] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  570.202248][ T3660] Call Trace:
[  570.206437][ T3660]  <TASK>
[ 570.210125][ T3660] dump_stack_lvl (arch/x86/include/asm/irqflags.h:26 (discriminator 3) arch/x86/include/asm/irqflags.h:109 (discriminator 3) arch/x86/include/asm/irqflags.h:151 (discriminator 3) lib/dump_stack.c:123 (discriminator 3)) 
[ 570.215892][ T3660] dump_stack (lib/dump_stack.c:130) 
[ 570.220985][ T3660] register_lock_class (kernel/locking/lockdep.c:988 kernel/locking/lockdep.c:1302) 
[ 570.227173][ T3660] __lock_acquire (kernel/locking/lockdep.c:5116) 
[ 570.232580][ T3660] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873) 
[ 570.237898][ T3660] ? ida_destroy (lib/idr.c:615) 
[ 570.243703][ T3660] ? _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
[ 570.250176][ T3660] ? ida_destroy (lib/idr.c:615) 
[ 570.255813][ T3660] ? trace_preempt_off (kernel/trace/trace_preemptirq.c:128) 
[ 570.261457][ T3660] ? ida_destroy (lib/idr.c:615) 
[ 570.266841][ T3660] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 570.272831][ T3660] ? ida_destroy (lib/idr.c:615) 
[ 570.278373][ T3660] ida_destroy (lib/idr.c:615) 
[ 570.283784][ T3660] ? xas_next_entry (include/trace/events/filemap.h:49) 
[ 570.290885][ T3660] ? kfree (mm/slub.c:2312 mm/slub.c:4643 mm/slub.c:4842) 
[ 570.295967][ T3660] fanotify_free_group_priv (fs/notify/fanotify/fanotify.c:1049) 
[ 570.302446][ T3660] fsnotify_put_group (fs/notify/group.c:28 fs/notify/group.c:110) 
[ 570.308643][ T3660] fsnotify_destroy_group (fs/notify/group.c:51) 
[ 570.315249][ T3660] ? fsnotify_group_stop_queueing (fs/notify/group.c:51) 
[ 570.322447][ T3660] ? lockdep_init_map_type (kernel/locking/lockdep.c:4976) 
[ 570.329051][ T3660] ? lockdep_init_map_type (kernel/locking/lockdep.c:4976) 
[ 570.335640][ T3660] ? __init_waitqueue_head (include/linux/list.h:37 kernel/sched/wait.c:12) 
[ 570.342015][ T3660] __do_sys_fanotify_init (fs/notify/fanotify/fanotify_user.c:1718) 
[ 570.348111][ T3660] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:445 (discriminator 3)) 
[ 570.353754][ T3660] __x64_sys_fanotify_init (fs/notify/fanotify/fanotify_user.c:1526) 
[ 570.360325][ T3660] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80 (discriminator 22)) 
[ 570.366287][ T3660] x64_sys_call (arch/x86/entry/syscall_64.c:41) 
[ 570.371831][ T3660] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
[ 570.377436][ T3660] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  570.384571][ T3660] RIP: 0033:0x463519
[ 570.389240][ T3660] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 59 00 00 c3 66 2e 0f 1f 84 00 00 00 00
All code
========
   0:	00 f3                	add    %dh,%bl
   2:	c3                   	ret
   3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   a:	00 00 00 
   d:	0f 1f 40 00          	nopl   0x0(%rax)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	0f 83 db 59 00 00    	jae    0x5a11
  36:	c3                   	ret
  37:	66                   	data16
  38:	2e                   	cs
  39:	0f                   	.byte 0xf
  3a:	1f                   	(bad)
  3b:	84 00                	test   %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	0f 83 db 59 00 00    	jae    0x59e7
   c:	c3                   	ret
   d:	66                   	data16
   e:	2e                   	cs
   f:	0f                   	.byte 0xf
  10:	1f                   	(bad)
  11:	84 00                	test   %al,(%rax)
  13:	00 00                	add    %al,(%rax)
	...
[  570.411823][ T3660] RSP: 002b:00007fff92c9e6d8 EFLAGS: 00000246 ORIG_RAX: 000000000000012c
[  570.421741][ T3660] RAX: ffffffffffffffda RBX: 000000000000012c RCX: 0000000000463519
[  570.430814][ T3660] RDX: 0000000004000055 RSI: 00000000001c1400 RDI: 000000000000002c
[  570.440208][ T3660] RBP: 00007f4a06748000 R08: ffffffffffffffb7 R09: 0000000000000000
[  570.449706][ T3660] R10: 0000000000002c85 R11: 0000000000000246 R12: 0000000000000002
[  570.458904][ T3660] R13: 00007f4a06748058 R14: 0000000036007850 R15: 00007f4a06748000
[  570.468210][ T3660]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250716/202507160713.34ee11f5-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


