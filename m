Return-Path: <linux-fsdevel+bounces-31154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C93992848
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73323284120
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C01199935;
	Mon,  7 Oct 2024 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcZ1o2MY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3BF41C69;
	Mon,  7 Oct 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293993; cv=fail; b=Ye7w9el0HrggXEg8+tAIpmnSfRxCLj8sv8mIll+HRtGR+1OFLAxPMugr15BNyofNYWg3bS8AibWZECmSy0lV9S0CTFoh1giJa3m/eg8CC1YkhG5zGLoozhO98r0SvpxeeL/WnqTC/rtj2Q1UqqPycmMJc1RITf+tJUQtzUHYa7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293993; c=relaxed/simple;
	bh=kIdrstaaaWHgBr3Q2RsqNNxlbBTcGB0rTrpt7biKLmE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hk7FjGZx5aNVFYZlqXfSzyQntTZel67r8jV7hr7P1v8952Dn2m7x5lXowOLiPoQjmXFoVN9RaxdGiuzquD3wbBzrjnBQKH25om2gIjKlSPw9JJT0OcSmgbqThcZRm0vOLhZkEYUGNGoYnevYuAqRkyvB+Qm6AfXl5aP0X//OXAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcZ1o2MY; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728293991; x=1759829991;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=kIdrstaaaWHgBr3Q2RsqNNxlbBTcGB0rTrpt7biKLmE=;
  b=fcZ1o2MYi2Sub4ZsjLui8/5qGkFGXLFC27aOmXSf2BYtRmzOsY0Qm9AM
   y4aEKZ73yZnMdx6KVajHf/ms9r0jaR8Li5MNH0Iq6hH59MoBACtWNSpqM
   R2ojkUSoUh1jo7rjd8PM0ciocdSw3+t4kIbPALAsOgV3Z80F5ybxMd2kM
   uxzA+Gh66WPF0hd42q3YNdWso5N01urUdB/ooMCqv1VWq/Z0S88zYU17C
   E2PcLn5zhJuJKdo/pediQGaEU3Vd5mFVTD6G5fEU4hiNxG2tMNZhRNOUa
   +18P0oLelK5X0y9/7Q6+gE3HMomVCoRN3J3SGZ9EF6vOCSlba8vL1fJSi
   w==;
X-CSE-ConnectionGUID: KfDJlL57QYWBb8z7aDvTDw==
X-CSE-MsgGUID: 7gTicqllSX6tLVaVrx4p/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="27524033"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27524033"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 02:39:50 -0700
X-CSE-ConnectionGUID: uLmx+xqESSinN3rz2X3HXg==
X-CSE-MsgGUID: Sm1aFk18ReqgGo5fyb/Gxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75664102"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 02:39:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 02:39:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 02:39:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 02:39:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 02:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9zvHy2ElZJaIzKAbNpL/xnP/QmkbMTyehWXIv1W7k03Er0nxbgIlIJM3x8Fvv3mAIoFddFuyOhjUrIczLy7OuJEvxatbNdHuGOgXJD02kP8xEcw3v7BguPx4dBRqb+mav4lBYzjB9i3nq7ksp7rvNYW2HqKf5mBU4NMUZkBTTIk2Ruw33hT34dWjlmG91RYTBzLX8PSJKG8iobf9D6PWncZ6bCWVtoaGhsDlSE9maYEwpe2blzJYyTYazeltlgSx4hkkTanrcbQfGJoL9z3xuOfP50WcK5uSu8Yai3R7CfO9le+Bm5z4ydN0tqEgtWQ8Z2lrWhnZMRrF1YqfR2vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tF0G9GWTFk3tES20TABJFn6w24dNUOi7O2bZjhWi84=;
 b=D2sU7FCLprEsOCW6aJf6TtHnnDyuHSS0kjh+zkyS27PtRV3qP0+LvK3ZlbvE/MslOOU13Ea9mppsBrUVuvFrfaiKXNZvt9n+iBqvI8cjQ2cadQCWzgGoK5ZwUnEQLhL72Gegn9Vxkb8JrXNLmCdEVZ/gG0w/MuENeXdPRnlLNlMqx8Ix4IruZsHC3Xg7WLmr77lJ5jdaeKO4Nx6zK6mN3qPzy7/HSavaQUt8Ij12ZwfuhwpvDHTDsYyGad5F8mrchhhmsbu1XGaJrhgNQdBPEZ34DiiNk+nptvMjt9kjw2K5J1liY1AfaSmpk2/epiRaQOrAy1gQ/bLKDVJ1HnP2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 09:39:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 09:39:45 +0000
Date: Mon, 7 Oct 2024 17:39:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael.j.wysocki@intel.com>, <tj@kernel.org>, <regressions@lists.linux.dev>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2] driver core: Fix userspace expectations of
 uevent_show() as a probe barrier
Message-ID: <202410071741.4aa3984e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172790598832.1168608.4519484276671503678.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ff48f2-3816-4aee-089a-08dce6b3fa3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P/GebhSiv5+sMJ0LFJ8AEgZZpwE7KlFIYkAVkGxYOalb1otl/wHOWoyj4GMZ?=
 =?us-ascii?Q?DFrzUqxhqs50S20/kXdl6QuRlnxaE7t/fS4OkjyicAYFRSi9P/NCYnoHFsZz?=
 =?us-ascii?Q?LXEXN0isuvXwUQlvO01EHUpIdkl67JVeQnSYnrAzzrZX17hjE+XD0gdzI1V3?=
 =?us-ascii?Q?/J2cMTKeoLJr0rOriMPzlxTOjeFj6oceuOL6JKb6ynYeKTsl9Fgo1mF/Le8s?=
 =?us-ascii?Q?bIs6atRkhQ0QmRGZVldLbCbjkCQSOzVXjz6ipMpkD9Hvd7zvlE6J3lWgEG2C?=
 =?us-ascii?Q?uriQXnNzzUvEBToUZPQcI0uiFYGvqfUeOgOoAoPOsMZZZIl8Nn61c5jgBOJT?=
 =?us-ascii?Q?0JEu0SVZZbvBqA6eymiRgREc6z0eVG28QzXArIAAKcF1e27nFyUpifxTkhXI?=
 =?us-ascii?Q?YYkr//xkjhg4d/NCpRsp6qAfRwus0hY6n3dxlxtnjEQ2sRPG0f4aoipQfPbM?=
 =?us-ascii?Q?v8EPZYf4zWKOgEO3vkx3fQ5RBPDwY3E0lQAnOAlbv7MhOBUKIRaScSgmqVA8?=
 =?us-ascii?Q?+kLPIln6SaQZnHivkqiCSdNb+CedTaBHk2HO61SUCuBEc2uLmWcfkGQjsD18?=
 =?us-ascii?Q?0tSxhrmBXDl/2MSdaWKvkRVxxHR/HzJMR0JIWLV2pu0EL9Q4rVp88qRZ4Wse?=
 =?us-ascii?Q?Khrok1dkl2LBkR7nN8vqdhqFkFGYsnCJaYimGShJ15McER6EEF4w7tfWf5gQ?=
 =?us-ascii?Q?py53uYfV2nnuFCnUFIRcErEV2tMdKamNfJgv36od2dm0M7N44/sLYNeHOeY8?=
 =?us-ascii?Q?4s8ifKcIHzMZM4/N/59s6IVOxBnEv+tLAjRLSsExkmnYG5NhhYBbiRWs7MBo?=
 =?us-ascii?Q?+otrH4FwHYKjpHXmPiE5URCVaoj+xgwAS4Nwys7BdSZBjxruw35nQmEItGph?=
 =?us-ascii?Q?xTpcu6TsVDTdzSETuRp/8nTd9Wb3mYDKPhgZEzyfO0rCyTlKOrfJRbiju154?=
 =?us-ascii?Q?DQlBRx/T6PhQoMWHrvexRiGo5KY1ARxgTp6ak4t04CfzMJ54Wb8pZROht18x?=
 =?us-ascii?Q?yb8NQ2l/Ewp6KgAgSOMWqSzhBcWIt8pqJbxz8HepxYFcKPWoMZYsTS40lqhH?=
 =?us-ascii?Q?9wZgVE+HGUUtuk3wkuAOOmeYTfg67wGJ4lwVf+gPnTX/Yg40QpWJ/bJ25mLx?=
 =?us-ascii?Q?aeLkQ8dd7JGEFm17TANm5Zocc4KP65gbs2OV62zGghJ8bb0RxJ5PnppmOPE1?=
 =?us-ascii?Q?BscR3QM67kTF81aOjnyaHzQQxdwCDSdn1LFZsY8H/XLPHzbVh+7hElaOM5M?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kTBK8Q38HtVH2tEmq9hP1+iI9Esx1BlQf8HRSnUARrE1ieA489Rsk7ZMGssO?=
 =?us-ascii?Q?bNyPjOfNDGs0n0c416DM60dM3mjFihXUOweTyLOXlFWbEC0PYtZX+01APGAQ?=
 =?us-ascii?Q?z4CgqS+zUHvRGyrOcKJi99r0WoGyjqBE/NiiXYTrFwdY5pzQ0N5Pd3+eaGVK?=
 =?us-ascii?Q?ncYHpw2Xyi7T8gPXx4aKAjlA9BqsTSad6bhkdWDvtC9M7kJEImr9lhPZ3Urx?=
 =?us-ascii?Q?ke4MeoRs0MyMnnHk8wlnjRFIbeynRAe+BqOjm3sa0RhGIGWBjI8TNcD25ehP?=
 =?us-ascii?Q?u500nLG+cRPkkI+7B0DooGW7SxMbeKJJj3ruk5fPXa7eWwDftHxfNYj2S+Np?=
 =?us-ascii?Q?XDzXWTDCG3RgbDg/wzwrfLfgCrsmH3ZKXsCX/udTBIBWXZlaU5+CcN4hJYgd?=
 =?us-ascii?Q?bF6EdwZeMJN9zp+FnqYWxVJ+vp+okXy83IHKcExKbqMHPKATZWJLqP1YAnlx?=
 =?us-ascii?Q?mWvF/bhkl6vuTE+XMvBhl8CxHiI6aM47XKl+oiL+22PyhECUZLmCrr4us9H6?=
 =?us-ascii?Q?wpVUOPZY5vC6YidbERhrZ6xXb/RdWMeITllB++cpYU4LLW6I/s82PelyZkYR?=
 =?us-ascii?Q?fYj6jMJkzkjYrLqr7vFmfKQ0NM476Qdf6WOwJGaeR9rm88Fur2nKFugzLyzT?=
 =?us-ascii?Q?7mfMCu/zMAGsjQuRUYBrCB58hG3PcEc8Wg4FZDin/KV6f+KSe0VxR4wAUz0Z?=
 =?us-ascii?Q?RCL1W2nVPvECs7iIJn2nP9TyPDjUIFUKBtZZSQzTsvJ0F77dpqG9HbStMhEd?=
 =?us-ascii?Q?vM6B/Pak2g8S22t42TfphC69cw+VsFaD+Sc4bw7oWWxtf7CYv1+Avw1Pt+1I?=
 =?us-ascii?Q?D9FUnXmIpZ6su8aO0dlqhw6g9Fku5Yp4e1y/xGv8HrARsKF69C2V4m0qGGov?=
 =?us-ascii?Q?b20pcyL19fFoESPPmSSOB8LVG0Fjjb6NRvTcLING+1r5SMUpNGmV/AFaRMpS?=
 =?us-ascii?Q?6uvZ6Ub2PvZNpbtjLkPesWe84Z7hhJ31oJup4nT/doFck00t1x7DLaqEfUWH?=
 =?us-ascii?Q?CSmpkTSPKX8FafVoFALyHL2GAjEGgNE2cn9GuSWA4OnE3hPkt6iHE/8Jhrtn?=
 =?us-ascii?Q?bRAptEVqW0uEgof9pWbyihOF9aVXmC+9E2tOqlDsv6yRaQXKWFsMCjkkrXGW?=
 =?us-ascii?Q?ceVLME8casL5lKiPzFg7kD//Y+kpayw86JAGP1WqacH4kkjx67RKw4eTduZS?=
 =?us-ascii?Q?pgWZMXHaGFYU4Fkjk7RmC2+Ff27aLte1IBBYAyp3X4CbFGm5imRnvPIe1EX2?=
 =?us-ascii?Q?lWu7maKX7fb2xyWEblcNM2SajwJUANnZcjD30tVyQRgTrel5CARepvB+F9M5?=
 =?us-ascii?Q?XO2hyuqiTphMlGHkrkojTgUi1Eu40y86MQ1wEwD6tQ6sskihCAQS7JouFkmz?=
 =?us-ascii?Q?WErOpO2syn2Li5OjfDZfRvqZ3YQT4El6/ItCuKc9TYjhrzE5m6I1+aK4RLyq?=
 =?us-ascii?Q?Fp0CBURQt4Zy848uF38im//v+ZeU++Q5DVloQSuyX1LASbZSyMy6f2TFvQPO?=
 =?us-ascii?Q?F2T4MM0c/2h2jWtWmiIMhxNatVh0a4D/BsXVpQ6dtbnoY65CCyi/R2M9Ahml?=
 =?us-ascii?Q?Knsx2L5nvuz/ObqUq5q/Ugt0aE+XHcg8JxmVwADy3jM0K8HeM+pZLH7CkKWK?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ff48f2-3816-4aee-089a-08dce6b3fa3b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 09:39:45.2939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6e4cJ1/FtZCvkDrdekQlD2XBpMYUBUaf/85jXfAn812r5Wgzlyf5baAUNnlpVO8QfnDfwhvrkN86ADUIER79gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__mutex_lock" on:

commit: cfb789a84ee6fe1368d091941af50e0eb6381d30 ("[PATCH v2] driver core: Fix userspace expectations of uevent_show() as a probe barrier")
url: https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/driver-core-Fix-userspace-expectations-of-uevent_show-as-a-probe-barrier/20241003-055515
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git 9852d85ec9d492ebef56dc5f229416c925758edc
patch link: https://lore.kernel.org/all/172790598832.1168608.4519484276671503678.stgit@dwillia2-xfh.jf.intel.com/
patch subject: [PATCH v2] driver core: Fix userspace expectations of uevent_show() as a probe barrier

in testcase: blktests
version: blktests-x86_64-80430af-1_20240910
with following parameters:

	disk: 1SSD
	test: block-001



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410071741.4aa3984e-oliver.sang@intel.com


[ 51.504416][ T130] BUG: KASAN: slab-use-after-free in __mutex_lock+0x1003/0x1170 
[   51.504423][  T130] Read of size 8 at addr ffff8887ff562250 by task systemd-journal/130
[   51.504427][  T130]
[   51.504429][  T130] CPU: 2 UID: 0 PID: 130 Comm: systemd-journal Not tainted 6.12.0-rc1-00001-gcfb789a84ee6 #1
[   51.504434][  T130] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[   51.504436][  T130] Call Trace:
[   51.504438][  T130]  <TASK>
[ 51.504439][ T130] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
[ 51.504445][ T130] print_address_description+0x2c/0x3a0 
[ 51.504451][ T130] ? __mutex_lock+0x1003/0x1170 
[ 51.504455][ T130] print_report (mm/kasan/report.c:489) 
[ 51.504459][ T130] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 51.504462][ T130] ? __mutex_lock+0x1003/0x1170 
[ 51.504466][ T130] kasan_report (mm/kasan/report.c:603) 
[ 51.504470][ T130] ? __mutex_lock+0x1003/0x1170 
[ 51.504475][ T130] __mutex_lock+0x1003/0x1170 
[ 51.504480][ T130] ? __pfx___mutex_lock+0x10/0x10 
[ 51.504485][ T130] ? __pfx___might_resched (kernel/sched/core.c:8586) 
[ 51.504491][ T130] mutex_lock (kernel/locking/mutex.c:286) 
[ 51.504495][ T130] ? __pfx_mutex_lock (kernel/locking/mutex.c:282) 
[ 51.504499][ T130] ? __kmalloc_node_noprof (include/linux/kasan.h:257 mm/slub.c:4265 mm/slub.c:4271) 
[ 51.504503][ T130] ? seq_read_iter (fs/seq_file.c:210) 
[ 51.504507][ T130] kernfs_seq_start (fs/kernfs/file.c:169) 
[ 51.504511][ T130] seq_read_iter (fs/seq_file.c:225) 
[ 51.504516][ T130] ? rw_verify_area (fs/read_write.c:470) 
[ 51.504521][ T130] vfs_read (fs/read_write.c:488 fs/read_write.c:569) 
[ 51.504524][ T130] ? kernfs_iop_getattr (fs/kernfs/inode.c:197) 
[ 51.504528][ T130] ? __pfx_vfs_read (fs/read_write.c:550) 
[ 51.504533][ T130] ? fdget_pos (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 fs/file.c:1177 fs/file.c:1185) 
[ 51.504537][ T130] ? __pfx___seccomp_filter (kernel/seccomp.c:1218) 
[ 51.504543][ T130] ksys_read (fs/read_write.c:712) 
[ 51.504546][ T130] ? __pfx_ksys_read (fs/read_write.c:702) 
[ 51.504550][ T130] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 51.504555][ T130] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   51.504558][  T130] RIP: 0033:0x7fddff64e1dc
[ 51.504562][ T130] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 d9 d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 2f d6 f8 ff 48
All code
========
   0:	ec                   	in     (%dx),%al
   1:	28 48 89             	sub    %cl,-0x77(%rax)
   4:	54                   	push   %rsp
   5:	24 18                	and    $0x18,%al
   7:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
   c:	89 7c 24 08          	mov    %edi,0x8(%rsp)
  10:	e8 d9 d5 f8 ff       	callq  0xfffffffffff8d5ee
  15:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  1a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  1f:	41 89 c0             	mov    %eax,%r8d
  22:	8b 7c 24 08          	mov    0x8(%rsp),%edi
  26:	31 c0                	xor    %eax,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 34                	ja     0x66
  32:	44 89 c7             	mov    %r8d,%edi
  35:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  3a:	e8 2f d6 f8 ff       	callq  0xfffffffffff8d66e
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 34                	ja     0x3c
   8:	44 89 c7             	mov    %r8d,%edi
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	e8 2f d6 f8 ff       	callq  0xfffffffffff8d644
  15:	48                   	rex.W
[   51.504565][  T130] RSP: 002b:00007ffe3e501df0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   51.504569][  T130] RAX: ffffffffffffffda RBX: 000055d748fcdac0 RCX: 00007fddff64e1dc
[   51.504572][  T130] RDX: 0000000000001008 RSI: 000055d748fcdac0 RDI: 000000000000001c
[   51.504574][  T130] RBP: 000000000000001c R08: 0000000000000000 R09: 00007fddff728ce0
[   51.504576][  T130] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001008
[   51.504578][  T130] R13: 0000000000001007 R14: ffffffffffffffff R15: 0000000000000002
[   51.504583][  T130]  </TASK>
[   51.504585][  T130]
[   51.504586][  T130] Allocated by task 1044:
[ 51.504588][ T130] kasan_save_stack (mm/kasan/common.c:48) 
[ 51.504591][ T130] kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 51.504594][ T130] __kasan_kmalloc (mm/kasan/common.c:377 mm/kasan/common.c:394) 
[ 51.504597][ T130] __kmalloc_noprof (include/linux/kasan.h:257 mm/slub.c:4265 mm/slub.c:4277) 
[ 51.504600][ T130] scsi_alloc_sdev (include/linux/slab.h:882 include/linux/slab.h:1014 drivers/scsi/scsi_scan.c:288) 
[ 51.504604][ T130] scsi_probe_and_add_lun (drivers/scsi/scsi_scan.c:1210) 
[ 51.504607][ T130] __scsi_scan_target (drivers/scsi/scsi_scan.c:1769) 
[ 51.504610][ T130] scsi_scan_host_selected (drivers/scsi/scsi_scan.c:1877) 
[ 51.504614][ T130] store_scan (drivers/scsi/scsi_sysfs.c:151 drivers/scsi/scsi_sysfs.c:191) 
[ 51.504617][ T130] kernfs_fop_write_iter (fs/kernfs/file.c:348) 
[ 51.504619][ T130] vfs_write (fs/read_write.c:590 fs/read_write.c:683) 
[ 51.504622][ T130] ksys_write (fs/read_write.c:736) 
[ 51.504624][ T130] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 51.504627][ T130] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   51.504629][  T130]
[   51.504630][  T130] Freed by task 1044:
[ 51.504632][ T130] kasan_save_stack (mm/kasan/common.c:48) 
[ 51.504635][ T130] kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 51.504638][ T130] kasan_save_free_info (mm/kasan/generic.c:582) 
[ 51.504640][ T130] __kasan_slab_free (mm/kasan/common.c:271) 
[ 51.504643][ T130] kfree (mm/slub.c:4580 mm/slub.c:4728) 
[ 51.504646][ T130] scsi_device_dev_release (drivers/scsi/scsi_sysfs.c:521 (discriminator 5)) 
[ 51.504649][ T130] device_release (drivers/base/core.c:2575) 
[ 51.504653][ T130] kobject_cleanup (lib/kobject.c:689) 
[ 51.504656][ T130] scsi_device_put (drivers/scsi/scsi.c:794) 
[ 51.504658][ T130] sdev_store_delete (drivers/scsi/scsi_sysfs.c:791) 
[ 51.504661][ T130] kernfs_fop_write_iter (fs/kernfs/file.c:348) 
[ 51.504664][ T130] vfs_write (fs/read_write.c:590 fs/read_write.c:683) 
[ 51.504666][ T130] ksys_write (fs/read_write.c:736) 
[ 51.504668][ T130] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 51.504671][ T130] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   51.504674][  T130]
[   51.504675][  T130] Last potentially related work creation:
[ 51.504676][ T130] kasan_save_stack (mm/kasan/common.c:48) 
[ 51.504679][ T130] __kasan_record_aux_stack (mm/kasan/generic.c:541) 
[ 51.504681][ T130] insert_work (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue.c:788 kernel/workqueue.c:795 kernel/workqueue.c:2186) 
[ 51.504685][ T130] __queue_work (kernel/workqueue.c:6723) 
[ 51.504689][ T130] queue_work_on (kernel/workqueue.c:2391) 
[ 51.504692][ T130] sdev_evt_send (include/linux/spinlock.h:406 drivers/scsi/scsi_lib.c:2645) 
[ 51.504694][ T130] scsi_evt_thread (drivers/scsi/scsi_lib.c:2596) 
[ 51.504697][ T130] process_one_work (kernel/workqueue.c:3229) 
[ 51.504701][ T130] worker_thread (kernel/workqueue.c:3304 kernel/workqueue.c:3391) 
[ 51.504704][ T130] kthread (kernel/kthread.c:389) 
[ 51.504707][ T130] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 51.504710][ T130] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   51.504713][  T130]
[   51.504714][  T130] Second to last potentially related work creation:
[ 51.504716][ T130] kasan_save_stack (mm/kasan/common.c:48) 
[ 51.504719][ T130] __kasan_record_aux_stack (mm/kasan/generic.c:541) 
[ 51.504721][ T130] insert_work (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue.c:788 kernel/workqueue.c:795 kernel/workqueue.c:2186) 
[ 51.504724][ T130] __queue_work (kernel/workqueue.c:6723) 
[ 51.504727][ T130] queue_work_on (kernel/workqueue.c:2391) 
[ 51.504731][ T130] scsi_check_sense (include/scsi/scsi_eh.h:24 drivers/scsi/scsi_error.c:550) 
[ 51.504734][ T130] scsi_decide_disposition (drivers/scsi/scsi_error.c:2024) 
[ 51.504737][ T130] scsi_complete (drivers/scsi/scsi_lib.c:1515) 
[ 51.504740][ T130] blk_complete_reqs (block/blk-mq.c:1126 (discriminator 3)) 
[ 51.504744][ T130] handle_softirqs (kernel/softirq.c:554) 
[ 51.504747][ T130] run_ksoftirqd (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 kernel/softirq.c:411 kernel/softirq.c:928 kernel/softirq.c:919) 
[ 51.504750][ T130] smpboot_thread_fn (kernel/smpboot.c:164 (discriminator 3)) 
[ 51.504753][ T130] kthread (kernel/kthread.c:389) 
[ 51.504755][ T130] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 51.504758][ T130] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   51.504760][  T130]
[   51.504761][  T130] The buggy address belongs to the object at ffff8887ff562000
[   51.504761][  T130]  which belongs to the cache kmalloc-4k of size 4096
[   51.504764][  T130] The buggy address is located 592 bytes inside of
[   51.504764][  T130]  freed 4096-byte region [ffff8887ff562000, ffff8887ff563000)
[   51.504767][  T130]
[   51.504768][  T130] The buggy address belongs to the physical page:
[   51.504770][  T130] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7ff560
[   51.504774][  T130] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   51.504776][  T130] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[   51.504780][  T130] page_type: f5(slab)
[   51.504783][  T130] raw: 0017ffffc0000040 ffff88810c843040 dead000000000122 0000000000000000
[   51.504786][  T130] raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
[   51.504789][  T130] head: 0017ffffc0000040 ffff88810c843040 dead000000000122 0000000000000000


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241007/202410071741.4aa3984e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


