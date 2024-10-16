Return-Path: <linux-fsdevel+bounces-32059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BEE99FEB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 04:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F023AB2491A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264E14D718;
	Wed, 16 Oct 2024 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXFDSh8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960E1494DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045190; cv=fail; b=sM4NttMQfBaZBMPiwh+/hJEjpANIKAUMWzQzgJSKbZ2g/+BDCNOkgi7MQclF7RJCedtn80iaOCfwbhlsXwKylKqUnkjp5jghSA4alZn5mfdUyODjJjpzSOKB3I+JdaA0M4HCcRAXFk2eMF1hzmH5exQ9n/GNp7dSWz7TttifCqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045190; c=relaxed/simple;
	bh=WRCv6eH71bhOexOmj4nVa5b5wSFH08LK1FLApDLRzb4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Fe6QQl/f25m/VP7SIJRNWEhi4uEl7dERcwL77GytqEntsuI6z0NHIdSpFhlIXT5PYNznmj8qXrOr3lxMwwrj6mo0THvvdk7k9H7/OhwT8VqMbNhaOAzrjTi9YEarCoKmrM4+ltg1KLFrE+F7nBumDI+kiuyYYIZsqCP5UZWOgAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXFDSh8q; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729045187; x=1760581187;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=WRCv6eH71bhOexOmj4nVa5b5wSFH08LK1FLApDLRzb4=;
  b=lXFDSh8qXoV2f3GflIc3yXcyROlpwfpnOUzUZTwECBODkRsvlC8Tmr7O
   xeilxSQBLKT997HGA/39QCTMjUHSE50lh4YZ8LclhUv1kjceay73hTeDS
   5Ew/JCD0SkphgMJTYORUD5Gn2JBpsF5fI+UFd+jCJCnBljEzv5uED/dRM
   u3zmHjJR1LpktI8da3Pd62wknrYygk59VmK69GH9GyJurwIWFqZZyuHYn
   p6t10xihxP+ZApquaFAF1AYDJ93HAF9vEgqGlXkPmUu1nl+pOHtXJnTAF
   LKQKGf/vQkWL6u7PHeUBcj6oVgbWGCmoyeE1rHhZcUdVvQcvL+IYGhADo
   Q==;
X-CSE-ConnectionGUID: OBVmjMvQTGWXAsUB/w3vXg==
X-CSE-MsgGUID: o6b6fBbzSRGJHRq7f+lALA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39862442"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="39862442"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 19:19:46 -0700
X-CSE-ConnectionGUID: 7iOKr2aUSL+XymiU2Hys+w==
X-CSE-MsgGUID: i2w/+2anQ7qWxJMvpLtg5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82891604"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 19:19:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 19:19:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 19:19:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 19:19:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 19:19:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcZZcOlOm0BJ8ejYgiUSSbxldqNGdUvFNEbGthkSZ8fcs2+vEoISfF9UuKGUc7j09muz97MCgROPaXjPAgO9DprlR5WXHXzISXTUzILRfO2CnO1Bs0CjQqZlGpCOHh9cY2CgKKDPXSrSZa82alCDpUAnrQZTeVn8382Q+pmKf4IgZNYXyG4Cm7HoVsDBJbOxcFDHvRCevX9EvjcE+Q7s7Mzxpo8QV6jhW9eQNPy8YnPCQLwUdHpQQrfJ+mubeQPXuMzCKQ/kBzykzBZZznGfPKvV+VXZmSIjK3txm+Ib4ivy/1nxdvqhNj7uSV9jOrozm/dQ9B14xhcOM5tigtNsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PWOcLoewsZjzK59MbrhuV19VLM4MoNe1Rdk3uoNuhU=;
 b=CyK2yCWOJKk2HvlNDDcWBjl0zrZmd1H2UnBUoFkZ8U914T7wb0jC2VMIt56w0Ab/fyRq3a0Jdt+HYldxvOqrv4jMjvOTP1gaHKpibQ4g4fwlv4AZWbssc6Pqgg68BO/+U4FDFtSsrNzXLy0z9oE7G60NX1HWjZBQAJm57BXLKytnkVAkMXVrL84rhHPJa0M1n/iFIdC1u3erlVVlFeCxRHKhGXO66XsbC3ecyTv+M2tlWafWNyjYI7hC/ccaEAA4g10sXJT7So32sFH5uus6sIPM/9NBxQp559Y+94eMMmXfPPlKmJ+dNkKU1EpV6f6jyWJeFFw62dv6J0Zlvi0VzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8135.namprd11.prod.outlook.com (2603:10b6:8:155::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 02:19:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 02:19:36 +0000
Date: Wed, 16 Oct 2024 10:19:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  d91ea8195e:
 stress-ng.ring-pipe.ops_per_sec -5.1% regression
 (stress-ng.ring-pipe.pipe_read+write_calls_per_sec 7.3% improvement)
Message-ID: <202410151611.f4cd71f2-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cf712b-8a11-414a-cb3f-08dced88fac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?19KFtkJljfhkGK92/tY0VKyRW1VR9VTiftGJ4ieZmS7QELXCwP7o8RqN2n?=
 =?iso-8859-1?Q?sme+LZrRatrc322fYuiXIQt0JFdVBT7LjDbLzhtRqkYeke6OuAu1SimU4z?=
 =?iso-8859-1?Q?frjg4gk5VgLLlzhmgkJXI4vyJEj3jxkMyUtTC/hzIc5KsuSje6iTSGUKdb?=
 =?iso-8859-1?Q?txHbMFkLAJZwPC+yGiZ11nOjaKkKas1SiJ28rqmn0q7FRa22TDNmKJmKgS?=
 =?iso-8859-1?Q?T0QxJdmVcBMJfRWjpamyhsthRoC035iQT/XSw7cpIBqefVMKA0v4Fmh4Ic?=
 =?iso-8859-1?Q?dz5AurahEkCIAupNCp6MH1yb4ayIR4ZFMbHMxKTqx1HwW59INk8yxC+GvX?=
 =?iso-8859-1?Q?u7mVCd5/ndv7KzywjEI1YrB+egGjXkpNqWOlSATptHXg8Me1L5CNk4Djam?=
 =?iso-8859-1?Q?/5x7Hq4r6Wyfkh+fy8Q1ayHnQSSCYsTuxqRLqeVOgLw033WK6UfyKOSIV9?=
 =?iso-8859-1?Q?OZa6kGdivPeVYlwbT2V8v6tY8drnp78HsEgceuctVzh0SjfEAs4utlPe6A?=
 =?iso-8859-1?Q?f7m/Sqnzuy9udXkkXNesmZ8eN7PPjuNXy2Ur3tUunU/wmo3nuEwYTsspxK?=
 =?iso-8859-1?Q?AennAHkXb99vRUG7KAG4+DYpTZrZcJTATd98KNw43snrNWvRtrshkdEpcT?=
 =?iso-8859-1?Q?lM3niPY1sCmr1OrbZlOpFGGSIEzpO8sp7Zda1Osqb918bp3BGOt0a9dTXr?=
 =?iso-8859-1?Q?x/zQ5M99N6Mzgl4vRw9Y72KBHjw6ZB/YNQ/tC8MSGnRJJ6wSx3XX7b1yrk?=
 =?iso-8859-1?Q?GIIqjqhZJkboLcrjJXE25SlTprfTRu/tb70LVTpmo3Yx8Hyi/enVktfEgN?=
 =?iso-8859-1?Q?9GIq/ummgDraOn6wNXunatn2logY0djNgeM+KECwAXZzzbEVc36wFS9sAb?=
 =?iso-8859-1?Q?o2B3cpNNoTHJfyaaDCe2/V50OobK6fE+7MfS9pmrYk32blx3C6icuxK7e0?=
 =?iso-8859-1?Q?qnNA4jiS+ZaWST9lghSS71v0gCLByecMZs9c6MHW7yUBc7qbUkmAAlJshy?=
 =?iso-8859-1?Q?e9rc119RFsAxpO/DAFIlgyrTEWEC8uUUa5D2r96dPCh0W28a9lFjnSDEnW?=
 =?iso-8859-1?Q?NcHGzChbFPiZUp9xDS/SaU2XMnadIkeuuBjAT7Bh8MYXMireNteTT49k5a?=
 =?iso-8859-1?Q?K+Jwvve2qa86Y3WV3d4MlEF5OcWdZuky2ERaM0oIP0MNPV5DixFzKnT+Eu?=
 =?iso-8859-1?Q?thcIdBtdqgMTpyEjW7IHnR13sZFLyeJzFFUr1VyspdqmtgbZRrXRxSEr/P?=
 =?iso-8859-1?Q?h5oRvkm3YcUHLcewwaQAAojaxLL1CyrDNwB5lMyio=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QSHS5iW4gdZnlrFeIIBLZnU0xCzNzi0ZJgp96m+jflatYZxKL8xfuLFe3O?=
 =?iso-8859-1?Q?Pf09sG88ZuhfM3QwSDrv2qj60gS9zudGWcyJPE6MZ8QzSgqCpMVbTDqgXw?=
 =?iso-8859-1?Q?b9OIMA9+1TYtqKXm4jH+IgILGS19jMmkFycvgj86D69v+PR8d+S0TPL3LP?=
 =?iso-8859-1?Q?oZ6UatXOYufSIwLRk9/PH8DhsAMRVPGx85mguWwuUycS6pnQ8MiPFG9gOm?=
 =?iso-8859-1?Q?H0UC636iph8fM1024gL1ey5sdTHPbH3NVi6mQkp0nW6m35cBD0SN6KV6FR?=
 =?iso-8859-1?Q?rAaHA2RHUjj+bLBEgZ4Zyp69p4m7TNsD7u5z3yISv5mb0n81AqwdKF5nxy?=
 =?iso-8859-1?Q?hJuw8MXBP4hFpg8d7GttufIjv5V3LPMTvRU8Dc0dVSxEIV65ACULRRVI7C?=
 =?iso-8859-1?Q?0DgCTrOzhhpu1m5NlaeR89NYfds4CwH5d1UY6mQca/GQvzL9Z7qzC1uFWM?=
 =?iso-8859-1?Q?Bh3+u97Oys6m6LW0CJQEw1RzLPghtvR9xoq+0tCqVNVEFkH+YNI1a23Wzm?=
 =?iso-8859-1?Q?n+PwAGs48LBTE88N0+RlMDFCmXAZF62S3b14pBjTCgjaQkDCWoOfRq6pGe?=
 =?iso-8859-1?Q?jvoe2q5+fz49HoHU/LROwfY3L4e7C6lXlCoTM6jENAU+D0cNKw+JzIII5S?=
 =?iso-8859-1?Q?fpEbDGKAV6tAKnaKo3AivvepOK6BfbjQuKvtteGsNoxkfsTzgCX8hv3EpI?=
 =?iso-8859-1?Q?fhGLT8SWvc3OARtZvZzOBE/NG+vZTxejYYHhxLhXSEPpl/7GpXSU1x6KSQ?=
 =?iso-8859-1?Q?K65lkgMW9ZQW3LKoZ4ep6519PoYv1tYpDJhMeZQ4ne299CDVEeF9yCFp/W?=
 =?iso-8859-1?Q?L8M+c7BEv/iSxIPNt/P9T8l9KVFpd85IYYV2lOai2YJCabF/vtTjJCoNqL?=
 =?iso-8859-1?Q?7G54Y0eC+7m/eo2dykgZS7d6bO1okMaFthleXX/uTfs0FavmHPH5KCf+L+?=
 =?iso-8859-1?Q?92cQ2SsdtHqB8BcXi60iQKFmIz4onuBr/5lpXZ3XdBKH7B5VJgqwaIiK4W?=
 =?iso-8859-1?Q?3A9xnUq8i5zFHH3W+tMMm7QelR5f4LceoAUFcJzYH7KTWQpgZV7ZFmZj45?=
 =?iso-8859-1?Q?N4zeEg9IXT4+i5qK7opZON800aQZKC8PHCWXTHUW1dS++Tweyo8JnXpbG1?=
 =?iso-8859-1?Q?QLvfpvWpNpL3PVdP9NXhlMGhw7Y7ZiLUoqOytVMrQAlTtkIiLzgjWI+L5r?=
 =?iso-8859-1?Q?8c5A5C8CmBGwbcjDWktaMuusQQeygGKc6aIkLZCAdt5FUtEkUoG78bcC46?=
 =?iso-8859-1?Q?wgn9hptmiL6eQHht2+2/ATXVZuq22/1/Yc5uZa/A2p5OJ38/Y6mlcnHfDk?=
 =?iso-8859-1?Q?Zt4kFmI9qcBiIf65sE3aE5P+ygPfShlFEqGTDQiac18d/jBFnVn6Zg3Bi7?=
 =?iso-8859-1?Q?XeQZq9yMcXpmguzph7Pxh19VEqTM4BSThoOEHPGWFq4/JUHoy9MNCDYhhl?=
 =?iso-8859-1?Q?LJRb94Ik5xtSGrexzPKCXhJrHNH4IfU6nKX49G5RrSmMB+Jr57m7To+E68?=
 =?iso-8859-1?Q?qrn3L4Fa0eppCes6dMLWwKho/HEg0hu85qPsJfHxO3W5GMr6EEnMuVvt24?=
 =?iso-8859-1?Q?2VGuRLV/G+1qFG6dwip+uZ9ObXp680wLXEG0w2+Y459JMgDiejW6RfzAMT?=
 =?iso-8859-1?Q?eQkL0yLWAxjapGOk/tlCzMT1Epi56v8MXuuDCBUYQYi0furXR99JmmcQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cf712b-8a11-414a-cb3f-08dced88fac3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 02:19:36.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0yMrlBeirHBpxGlpWVckEhmIVLV6J8fyoRTBKC2AxgxktcVHVBYloYheLDTJM1nYUVM3ORXXHgIjWAGEghvhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8135
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -5.1% regression of stress-ng.ring-pipe.ops_per_sec
(but also a 7.3% improvement of stress-ng.ring-pipe.pipe_read+write_calls_per_sec
in "miscellaneous metrics" part of the same test) on:


commit: d91ea8195ed416365007d83d2967985dc6d8f882 ("fs: port files to file_ref")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: ring-pipe
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.io-uring.ops_per_sec 27.5% improvement                               |
| test machine     | 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory           |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=io-uring                                                                             |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+


at the same time, we also observed
"dmesg.WARNING:at_fs/file.c:#__file_ref_put"
"dmesg.WARNING:at_fs/open.c:#filp_flush"
"RIP:aa_file_perm"
then kernel crash issues for stress-ng getdent tests as below part [1]

similar to what we reported in
https://lore.kernel.org/all/202410151043.5d224a27-oliver.sang@intel.com/



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241015/202410151611.f4cd71f2-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/ring-pipe/stress-ng/60s

commit: 
  bef236c3c0 ("fs: add file_ref")
  d91ea8195e ("fs: port files to file_ref")

bef236c3c0fea5fc d91ea8195ed416365007d83d296 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    170804 ± 23%     -42.3%      98511 ±  9%  cpuidle..usage
      1.17 ±  2%      -0.1        1.05        mpstat.cpu.all.irq%
    444333 ±  6%     -25.7%     330133 ± 10%  numa-meminfo.node1.Active
    444317 ±  6%     -25.7%     330117 ± 10%  numa-meminfo.node1.Active(anon)
    111455 ±  5%     -26.0%      82465 ±  9%  numa-vmstat.node1.nr_active_anon
    111454 ±  5%     -26.0%      82465 ±  9%  numa-vmstat.node1.nr_zone_active_anon
      2.53 ± 32%     -48.3%       1.31 ± 55%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    136.17 ±  5%     -13.8%     117.33 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
    159.37 ± 10%     +18.0%     188.02 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
      0.01 ±223%    +500.0%       0.03        sched_debug.rt_rq:.rt_nr_running.stddev
    454317 ±  5%     -26.2%     335215 ±  9%  meminfo.Active
    454285 ±  5%     -26.2%     335183 ±  9%  meminfo.Active(anon)
   1124528 ±  2%     +11.5%    1254390 ±  2%  meminfo.Inactive
   1124315 ±  2%     +11.6%    1254176 ±  2%  meminfo.Inactive(anon)
      2705            +7.3%       2902        stress-ng.ring-pipe.MB_per_sec_data_pipe_write
 2.091e+09            -5.1%  1.985e+09        stress-ng.ring-pipe.ops
  34851569            -5.1%   33080540        stress-ng.ring-pipe.ops_per_sec
    692730            +7.3%     743014        stress-ng.ring-pipe.pipe_read+write_calls_per_sec
    708.08            -7.6%     653.93        stress-ng.time.user_time
    112900 ±  7%     -26.8%      82615 ± 10%  proc-vmstat.nr_active_anon
    281903 ±  2%     +11.4%     314032 ±  2%  proc-vmstat.nr_inactive_anon
    112900 ±  7%     -26.8%      82615 ± 10%  proc-vmstat.nr_zone_active_anon
    281903 ±  2%     +11.4%     314032 ±  2%  proc-vmstat.nr_zone_inactive_anon
 1.433e+09            -5.1%   1.36e+09        proc-vmstat.numa_hit
 1.432e+09            -5.1%   1.36e+09        proc-vmstat.numa_local
 1.431e+09            -5.1%  1.358e+09        proc-vmstat.pgalloc_normal
 1.431e+09            -5.1%  1.358e+09        proc-vmstat.pgfree
   1.6e+11            -5.1%  1.519e+11        perf-stat.i.branch-instructions
      0.14            +0.0        0.15        perf-stat.i.branch-miss-rate%
 1.996e+08            -4.2%  1.911e+08        perf-stat.i.branch-misses
 3.099e+09            -4.6%  2.956e+09        perf-stat.i.cache-references
      0.77            +2.6%       0.79        perf-stat.i.cpi
    338.14 ±  2%      -4.5%     322.99        perf-stat.i.cpu-migrations
 8.233e+11            -2.3%  8.048e+11        perf-stat.i.instructions
      1.31            -2.6%       1.27        perf-stat.i.ipc
      2.17 ±  3%      +4.3%       2.27        perf-stat.i.metric.K/sec
     11043 ±  2%      +6.1%      11720 ±  2%  perf-stat.i.minor-faults
     11044 ±  2%      +6.1%      11720 ±  2%  perf-stat.i.page-faults
      0.77            +2.6%       0.79        perf-stat.overall.cpi
      1.30            -2.6%       1.27        perf-stat.overall.ipc
 1.574e+11            -5.4%  1.489e+11        perf-stat.ps.branch-instructions
 1.953e+08            -5.2%  1.851e+08        perf-stat.ps.branch-misses
 3.049e+09            -4.9%    2.9e+09        perf-stat.ps.cache-references
      3027            -4.2%       2900        perf-stat.ps.context-switches
    329.74 ±  2%      -7.6%     304.82        perf-stat.ps.cpu-migrations
 8.101e+11            -2.6%  7.892e+11        perf-stat.ps.instructions
  5.03e+13            -2.7%  4.892e+13        perf-stat.total.instructions
     15.52            -2.1       13.46        perf-profile.calltrace.cycles-pp.write
     14.52            -2.0       12.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     14.42            -2.0       12.44        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     14.12            -2.0       12.15        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     13.24            -1.9       11.36        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     11.05            -1.6        9.50        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.13            -1.5       18.68        perf-profile.calltrace.cycles-pp.poll_freewait.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.10            -0.8        4.25        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
      9.10            -0.7        8.35        perf-profile.calltrace.cycles-pp.__pollwait.pipe_poll.do_poll.do_sys_poll.__x64_sys_poll
     11.42            -0.7       10.68        perf-profile.calltrace.cycles-pp.add_wait_queue.pipe_poll.do_poll.do_sys_poll.__x64_sys_poll
     11.17            -0.7       10.43        perf-profile.calltrace.cycles-pp.remove_wait_queue.poll_freewait.do_sys_poll.__x64_sys_poll.do_syscall_64
      9.87            -0.7        9.20        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.poll_freewait.do_sys_poll.__x64_sys_poll
      9.74            -0.7        9.08        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.add_wait_queue.pipe_poll.do_poll.do_sys_poll
      6.72            -0.6        6.14        perf-profile.calltrace.cycles-pp.read
      5.80            -0.5        5.27        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      5.71            -0.5        5.19        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.42            -0.5        4.92        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.03 ±  2%      -0.5        2.54 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      2.93 ±  2%      -0.5        2.45 ±  4%  perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      5.02            -0.5        4.55        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.84            -0.4        4.41        perf-profile.calltrace.cycles-pp.fput.poll_freewait.do_sys_poll.__x64_sys_poll.do_syscall_64
      3.91            -0.3        3.57        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.59            -0.2        2.41        perf-profile.calltrace.cycles-pp.stress_ring_pipe
      0.61 ±  2%      -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.08            -0.2        0.92        perf-profile.calltrace.cycles-pp.get_free_pages_noprof.__pollwait.pipe_poll.do_poll.do_sys_poll
      0.98            -0.2        0.82        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.get_free_pages_noprof.__pollwait.pipe_poll.do_poll
      1.50            -0.1        1.36 ±  2%  perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.84            -0.1        0.70        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.get_free_pages_noprof.__pollwait.pipe_poll
      1.54            -0.1        1.43        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.46            -0.1        1.36        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      0.70            -0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.69 ±  2%      -0.1        0.60 ±  4%  perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
      0.78 ±  3%      -0.1        0.69 ±  5%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.76            -0.1        0.71        perf-profile.calltrace.cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.54            -0.0        0.51        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
     73.86            +3.0       76.82        perf-profile.calltrace.cycles-pp.__poll
     73.30            +3.0       76.28        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
     73.24            +3.0       76.23        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     73.06            +3.0       76.06        perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     72.72            +3.0       75.74        perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      8.82            +3.8       12.59        perf-profile.calltrace.cycles-pp.fdget.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
     49.59            +4.7       54.29        perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.22            -2.2       14.06        perf-profile.children.cycles-pp.write
     14.42            -2.1       12.37        perf-profile.children.cycles-pp.ksys_write
     13.53            -1.9       11.58        perf-profile.children.cycles-pp.vfs_write
     11.13            -1.6        9.57        perf-profile.children.cycles-pp.pipe_write
     19.60            -1.4       18.18        perf-profile.children.cycles-pp.poll_freewait
     20.26            -1.3       18.91        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      5.39            -0.9        4.52        perf-profile.children.cycles-pp.mutex_unlock
     11.93            -0.8       11.16        perf-profile.children.cycles-pp.add_wait_queue
     11.72            -0.8       10.95        perf-profile.children.cycles-pp.remove_wait_queue
      9.31            -0.8        8.56        perf-profile.children.cycles-pp.__pollwait
      7.14            -0.6        6.54        perf-profile.children.cycles-pp.read
      5.44            -0.5        4.95        perf-profile.children.cycles-pp.ksys_read
      3.04 ±  2%      -0.5        2.56 ±  4%  perf-profile.children.cycles-pp.copy_page_from_iter
      2.94 ±  2%      -0.5        2.46 ±  4%  perf-profile.children.cycles-pp._copy_from_iter
      5.04            -0.5        4.58        perf-profile.children.cycles-pp.vfs_read
      5.03            -0.4        4.60        perf-profile.children.cycles-pp.fput
      3.97            -0.3        3.63        perf-profile.children.cycles-pp.pipe_read
      1.34            -0.2        1.15 ±  2%  perf-profile.children.cycles-pp.rw_verify_area
      1.28 ±  3%      -0.2        1.09        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.66            -0.2        2.47        perf-profile.children.cycles-pp.stress_ring_pipe
      1.24 ±  3%      -0.2        1.05        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.28            -0.2        3.09        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      1.16 ±  4%      -0.2        0.99 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.12 ±  4%      -0.2        0.95 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.10            -0.2        0.93        perf-profile.children.cycles-pp.get_free_pages_noprof
      1.01            -0.2        0.85        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      1.56            -0.1        1.41 ±  2%  perf-profile.children.cycles-pp.file_update_time
      1.06            -0.1        0.91        perf-profile.children.cycles-pp.security_file_permission
      0.95            -0.1        0.80        perf-profile.children.cycles-pp.apparmor_file_permission
      0.85            -0.1        0.71        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.76 ±  3%      -0.1        0.64 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.56            -0.1        1.45        perf-profile.children.cycles-pp.copy_page_to_iter
      0.71 ±  3%      -0.1        0.60 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      1.47            -0.1        1.36        perf-profile.children.cycles-pp._copy_to_iter
      0.41 ±  6%      -0.1        0.30 ± 10%  perf-profile.children.cycles-pp.handle_internal_command
      0.41 ±  6%      -0.1        0.30 ± 10%  perf-profile.children.cycles-pp.main
      0.41 ±  6%      -0.1        0.30 ± 10%  perf-profile.children.cycles-pp.run_builtin
      0.41 ±  6%      -0.1        0.30 ± 10%  perf-profile.children.cycles-pp.cmd_record
      0.41 ±  6%      -0.1        0.30 ± 10%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.40 ±  7%      -0.1        0.30 ± 11%  perf-profile.children.cycles-pp.perf_mmap__push
      0.73 ±  2%      -0.1        0.63 ±  4%  perf-profile.children.cycles-pp.inode_needs_update_time
      1.10 ±  2%      -0.1        1.00 ±  4%  perf-profile.children.cycles-pp.fdget_pos
      0.65 ±  2%      -0.1        0.55        perf-profile.children.cycles-pp.update_process_times
      0.31 ±  7%      -0.1        0.22 ± 10%  perf-profile.children.cycles-pp.writen
      0.31 ±  7%      -0.1        0.22 ± 10%  perf-profile.children.cycles-pp.record__pushfn
      0.58            -0.1        0.49        perf-profile.children.cycles-pp.get_page_from_freelist
      0.55            -0.1        0.46        perf-profile.children.cycles-pp.aa_file_perm
      0.24 ±  5%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.stress_time_now
      0.48 ±  3%      -0.1        0.40 ±  6%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      1.33            -0.1        1.26        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.25 ±  5%      -0.1        0.18 ±  9%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.24 ±  6%      -0.1        0.17 ±  9%  perf-profile.children.cycles-pp.generic_perform_write
      0.89            -0.1        0.83        perf-profile.children.cycles-pp.generic_update_time
      0.63            -0.1        0.57        perf-profile.children.cycles-pp.mutex_lock
      0.79            -0.1        0.73        perf-profile.children.cycles-pp._copy_from_user
      0.34 ±  2%      -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.sched_tick
      0.52            -0.0        0.48        perf-profile.children.cycles-pp.free_unref_page
      0.20 ±  3%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.40            -0.0        0.36        perf-profile.children.cycles-pp.__mark_inode_dirty
      0.70            -0.0        0.67        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.38            -0.0        0.35        perf-profile.children.cycles-pp.ktime_get_ts64
      0.10 ±  7%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.35            -0.0        0.32        perf-profile.children.cycles-pp.rmqueue
      0.34            -0.0        0.32        perf-profile.children.cycles-pp.select_estimate_accuracy
      0.09 ±  8%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.09 ±  8%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.fault_in_readable
      0.08 ±  4%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.perf_mmap__read_head
      0.23 ±  2%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.24            -0.0        0.22        perf-profile.children.cycles-pp._raw_spin_trylock
      0.26            -0.0        0.24        perf-profile.children.cycles-pp.poll_select_set_timeout
      0.41            -0.0        0.39        perf-profile.children.cycles-pp.inode_update_timestamps
      0.27            -0.0        0.25        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.26 ±  2%      -0.0        0.24        perf-profile.children.cycles-pp.kfree
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.update_load_avg
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.x64_sys_call
      0.14            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.26            -0.0        0.24        perf-profile.children.cycles-pp.read_tsc
      0.07            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.update_curr
      0.22 ±  2%      -0.0        0.20        perf-profile.children.cycles-pp.stress_time_now_timespec
      0.17            -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.11 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.rcu_all_qs
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.alloc_pages_noprof
      0.38            +0.0        0.40        perf-profile.children.cycles-pp.__wake_up_sync_key
      0.08            +0.0        0.11        perf-profile.children.cycles-pp.__wake_up_common
     32.65            +0.4       33.02        perf-profile.children.cycles-pp.pipe_poll
     93.93            +0.4       94.31        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     93.74            +0.4       94.12        perf-profile.children.cycles-pp.do_syscall_64
     74.12            +2.9       77.06        perf-profile.children.cycles-pp.__poll
     73.08            +3.0       76.08        perf-profile.children.cycles-pp.__x64_sys_poll
     72.77            +3.0       75.79        perf-profile.children.cycles-pp.do_sys_poll
      8.81            +3.7       12.53        perf-profile.children.cycles-pp.fdget
     49.60            +4.7       54.28        perf-profile.children.cycles-pp.do_poll
     19.58            -1.3       18.29        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      5.31            -0.8        4.46        perf-profile.self.cycles-pp.mutex_unlock
      7.85            -0.6        7.29        perf-profile.self.cycles-pp.__pollwait
      2.89 ±  2%      -0.5        2.43 ±  4%  perf-profile.self.cycles-pp._copy_from_iter
      4.74            -0.4        4.33        perf-profile.self.cycles-pp.fput
      1.50            -0.2        1.28        perf-profile.self.cycles-pp.vfs_write
      2.54            -0.2        2.36        perf-profile.self.cycles-pp.stress_ring_pipe
      2.78            -0.2        2.62        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      1.88            -0.1        1.76        perf-profile.self.cycles-pp.do_sys_poll
      2.02            -0.1        1.90        perf-profile.self.cycles-pp.add_wait_queue
      1.60            -0.1        1.49        perf-profile.self.cycles-pp.remove_wait_queue
      1.44            -0.1        1.34        perf-profile.self.cycles-pp._copy_to_iter
      0.58 ±  3%      -0.1        0.49 ±  4%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.53            -0.1        0.44        perf-profile.self.cycles-pp.aa_file_perm
      1.15            -0.1        1.06        perf-profile.self.cycles-pp.poll_freewait
      0.20 ±  6%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.stress_time_now
      0.46 ±  3%      -0.1        0.38 ±  6%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.63 ±  3%      -0.1        0.57 ±  4%  perf-profile.self.cycles-pp.pipe_write
      0.40 ±  3%      -0.1        0.34 ±  4%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.22 ±  2%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.76            -0.1        0.71        perf-profile.self.cycles-pp._copy_from_user
      0.19            -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.47            -0.0        0.42        perf-profile.self.cycles-pp.mutex_lock
      0.37            -0.0        0.33 ±  2%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.10 ±  7%      -0.0        0.07 ± 13%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.08 ±  7%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.fault_in_readable
      0.68            -0.0        0.66        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.36            -0.0        0.33        perf-profile.self.cycles-pp.vfs_read
      0.32            -0.0        0.30        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.44            -0.0        0.42        perf-profile.self.cycles-pp.write
      0.33            -0.0        0.31        perf-profile.self.cycles-pp.pipe_read
      0.29            -0.0        0.27        perf-profile.self.cycles-pp.do_syscall_64
      0.25            -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.kfree
      0.45 ±  2%      -0.0        0.43        perf-profile.self.cycles-pp.read
      0.16 ±  3%      -0.0        0.15        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.ktime_get_ts64
      0.22            -0.0        0.21        perf-profile.self.cycles-pp._raw_spin_trylock
      0.17 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.24            -0.0        0.23        perf-profile.self.cycles-pp.read_tsc
      0.15            -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.select_estimate_accuracy
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.stress_time_now_timespec
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.21            -0.0        0.20        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.23            -0.0        0.22        perf-profile.self.cycles-pp.inode_update_timestamps
      0.10            -0.0        0.09        perf-profile.self.cycles-pp.ksys_write
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.rcu_all_qs
      0.11            -0.0        0.10        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.15            -0.0        0.14        perf-profile.self.cycles-pp.free_unref_page
      0.11            -0.0        0.10        perf-profile.self.cycles-pp.generic_update_time
      0.07            +0.0        0.10        perf-profile.self.cycles-pp.__wake_up_common
      9.46            +0.6       10.09        perf-profile.self.cycles-pp.do_poll
      9.47            +2.0       11.50        perf-profile.self.cycles-pp.pipe_poll
      7.82            +3.6       11.46        perf-profile.self.cycles-pp.fdget



=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp1/io-uring/stress-ng/60s

commit: 
  bef236c3c0 ("fs: add file_ref")
  d91ea8195e ("fs: port files to file_ref")

bef236c3c0fea5fc d91ea8195ed416365007d83d296 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1535541 ±  2%      +9.0%    1673916 ±  5%  meminfo.Mapped
      1.89            +0.4        2.25 ±  2%  mpstat.cpu.all.usr%
  26276144 ±  3%     +27.0%   33383183 ±  2%  vmstat.system.cs
     61324 ± 32%    +129.9%     140985 ± 19%  perf-c2c.HITM.local
      1089 ± 18%     +39.6%       1520 ±  9%  perf-c2c.HITM.remote
     62414 ± 31%    +128.3%     142505 ± 18%  perf-c2c.HITM.total
   3210016 ±  3%     +27.1%    4080939 ±  2%  sched_debug.cpu.nr_switches.avg
   3921742 ±  7%     +18.6%    4651647 ±  6%  sched_debug.cpu.nr_switches.max
   1430679 ± 15%     +46.7%    2098846 ± 22%  sched_debug.cpu.nr_switches.min
  56092889 ±  8%     +30.0%   72920581 ±  3%  numa-numastat.node0.local_node
  56265940 ±  8%     +29.9%   73086770 ±  3%  numa-numastat.node0.numa_hit
  62870781 ±  7%     +23.8%   77845155 ±  4%  numa-numastat.node1.local_node
  62964012 ±  7%     +23.8%   77944394 ±  4%  numa-numastat.node1.numa_hit
    891691 ± 23%     -45.8%     482944 ± 55%  numa-meminfo.node0.AnonPages.max
   1316870 ± 31%     -57.8%     555447 ± 59%  numa-meminfo.node0.Inactive
   1316830 ± 31%     -57.8%     555286 ± 59%  numa-meminfo.node0.Inactive(anon)
    449544 ± 40%     +85.0%     831867 ± 31%  numa-meminfo.node1.AnonPages
    560249 ± 36%     +76.2%     987166 ± 26%  numa-meminfo.node1.AnonPages.max
 1.278e+09 ±  2%     +27.5%  1.629e+09        stress-ng.io-uring.ops
  21294308 ±  2%     +27.5%   27153066        stress-ng.io-uring.ops_per_sec
 1.295e+08 ±  6%    +108.2%  2.697e+08 ±  2%  stress-ng.time.involuntary_context_switches
    229.58 ±  2%     +20.0%     275.48        stress-ng.time.user_time
 1.497e+09 ±  2%     +20.5%  1.805e+09        stress-ng.time.voluntary_context_switches
    328981 ± 31%     -57.8%     138724 ± 59%  numa-vmstat.node0.nr_inactive_anon
    328980 ± 31%     -57.8%     138723 ± 59%  numa-vmstat.node0.nr_zone_inactive_anon
  56265900 ±  8%     +29.9%   73117237 ±  3%  numa-vmstat.node0.numa_hit
  56092849 ±  8%     +30.1%   72951049 ±  3%  numa-vmstat.node0.numa_local
    112088 ± 40%     +85.4%     207838 ± 31%  numa-vmstat.node1.nr_anon_pages
  62963484 ±  7%     +23.8%   77974570 ±  4%  numa-vmstat.node1.numa_hit
  62870253 ±  7%     +23.9%   77875331 ±  4%  numa-vmstat.node1.numa_local
      0.01 ± 71%  +68462.5%       5.76 ±106%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.67 ± 97%  +1.6e+05%       1043 ±117%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.82 ± 95%   +9213.3%      76.78 ±169%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2.42 ± 98%  +31107.1%     755.84 ±172%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.74 ± 98%  +10234.2%      76.70 ±169%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 69%  +19350.0%       2.14 ±169%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ± 67%     +75.0%       0.05 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.io_run_task_work.io_wq_worker.ret_from_fork
      1.96 ±106%  +38559.7%     755.80 ±172%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.68 ± 97%  +42994.8%     292.01 ±171%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    383037 ±  2%      +9.5%     419578 ±  5%  proc-vmstat.nr_mapped
    335546 ±  6%     +11.5%     374243 ±  4%  proc-vmstat.numa_hint_faults
    176181 ± 30%     +51.3%     266558 ±  7%  proc-vmstat.numa_hint_faults_local
 1.192e+08 ±  2%     +26.7%  1.511e+08        proc-vmstat.numa_hit
  1.19e+08 ±  2%     +26.8%  1.508e+08        proc-vmstat.numa_local
    108542 ±  6%     +61.5%     175324 ± 16%  proc-vmstat.pgactivate
 1.195e+08 ±  2%     +26.7%  1.514e+08        proc-vmstat.pgalloc_normal
   1441487            +2.6%    1478815        proc-vmstat.pgfault
 1.171e+08 ±  2%     +27.3%  1.491e+08        proc-vmstat.pgfree
 6.154e+10 ±  3%     +20.5%  7.418e+10        perf-stat.i.branch-instructions
      0.59            +0.0        0.61        perf-stat.i.branch-miss-rate%
 3.235e+08 ±  2%     +25.1%  4.047e+08        perf-stat.i.branch-misses
 1.346e+08 ± 12%     +18.4%  1.593e+08 ± 10%  perf-stat.i.cache-references
  27554460 ±  3%     +27.2%   35049527 ±  2%  perf-stat.i.context-switches
      2.42 ±  3%     -18.9%       1.96        perf-stat.i.cpi
     49139 ±  4%     -14.2%      42145 ±  5%  perf-stat.i.cycles-between-cache-misses
 3.022e+11 ±  3%     +20.7%  3.647e+11        perf-stat.i.instructions
      0.47 ±  3%     +20.2%       0.56        perf-stat.i.ipc
    107.68 ±  3%     +27.2%     136.97 ±  2%  perf-stat.i.metric.K/sec
      0.53            +0.0        0.55        perf-stat.overall.branch-miss-rate%
      2.15 ±  3%     -16.9%       1.79        perf-stat.overall.cpi
      0.46 ±  3%     +20.3%       0.56        perf-stat.overall.ipc
 6.008e+10 ±  2%     +20.5%   7.24e+10        perf-stat.ps.branch-instructions
 3.169e+08 ±  2%     +25.1%  3.965e+08        perf-stat.ps.branch-misses
 1.321e+08 ± 12%     +18.3%  1.562e+08 ± 10%  perf-stat.ps.cache-references
  27119503 ±  3%     +27.1%   34480596 ±  2%  perf-stat.ps.context-switches
 2.951e+11 ±  2%     +20.7%  3.561e+11        perf-stat.ps.instructions
 1.816e+13 ±  3%     +20.6%   2.19e+13        perf-stat.total.instructions
     15.03 ±  5%     -11.9        3.12 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.dup
     15.03 ±  5%     -11.9        3.12 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.dup
     15.01 ±  5%     -11.9        3.11 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_dup.do_syscall_64.entry_SYSCALL_64_after_hwframe.dup
     15.10 ±  5%     -11.9        3.22 ±  5%  perf-profile.calltrace.cycles-pp.dup
     10.35 ±  3%      -6.5        3.86 ±  6%  perf-profile.calltrace.cycles-pp.io_close.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64
     10.64 ±  3%      -6.5        4.15 ±  5%  perf-profile.calltrace.cycles-pp.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.77 ±  3%      -6.3        7.48 ±  2%  perf-profile.calltrace.cycles-pp.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     17.22 ±  3%      -5.7       11.52 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     18.00 ±  3%      -5.5       12.46 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     18.08 ±  3%      -5.5       12.54 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     20.36 ±  3%      -5.1       15.28 ±  2%  perf-profile.calltrace.cycles-pp.syscall
      6.35 ±  3%      -4.2        2.20 ±  7%  perf-profile.calltrace.cycles-pp.filp_close.io_close.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter
      3.93 ±  3%      -2.3        1.62 ±  5%  perf-profile.calltrace.cycles-pp.io_is_uring_fops.io_close.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter
      2.60 ±  5%      -2.2        0.43 ± 58%  perf-profile.calltrace.cycles-pp.filp_flush.filp_close.io_close.io_issue_sqe.io_submit_sqes
      3.49 ±  3%      -2.1        1.37 ±  6%  perf-profile.calltrace.cycles-pp.fd_install.__x64_sys_dup.do_syscall_64.entry_SYSCALL_64_after_hwframe.dup
      3.75 ±  2%      -2.1        1.65 ±  5%  perf-profile.calltrace.cycles-pp.fput.filp_close.io_close.io_issue_sqe.io_submit_sqes
      0.54 ±  5%      +0.1        0.60 ±  5%  perf-profile.calltrace.cycles-pp.__io_run_local_work.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.52            +0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.io_wq_activate_free_worker.io_wq_enqueue
      0.65            +0.1        0.72 ±  3%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.io_wq_activate_free_worker.io_wq_enqueue.io_queue_iowq
      0.58            +0.1        0.67 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.io_cqring_wait.__do_sys_io_uring_enter
      1.46 ±  2%      +0.1        1.56 ±  4%  perf-profile.calltrace.cycles-pp.io_queue_async.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.39 ±  3%      +0.1        1.51 ±  4%  perf-profile.calltrace.cycles-pp.io_queue_iowq.io_queue_async.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64
      1.14 ±  3%      +0.1        1.26 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.io_wq_activate_free_worker.io_wq_enqueue.io_queue_iowq.io_queue_async
      0.57 ±  3%      +0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge_folios.folios_put_refs.truncate_inode_pages_range.truncate_pagecache
      0.58 ±  3%      +0.1        0.72 ±  3%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_folios.folios_put_refs.truncate_inode_pages_range.truncate_pagecache.simple_setattr
      1.29 ±  3%      +0.1        1.42 ±  4%  perf-profile.calltrace.cycles-pp.io_wq_enqueue.io_queue_iowq.io_queue_async.io_submit_sqes.__do_sys_io_uring_enter
      0.57 ±  3%      +0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_folios.folios_put_refs.truncate_inode_pages_range
      1.20 ±  3%      +0.1        1.34 ±  4%  perf-profile.calltrace.cycles-pp.io_wq_activate_free_worker.io_wq_enqueue.io_queue_iowq.io_queue_async.io_submit_sqes
      0.71 ±  2%      +0.1        0.84 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.io_wq_worker
      0.57 ±  4%      +0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_folios.folios_put_refs
      0.66 ±  3%      +0.1        0.80 ±  4%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.92 ±  2%      +0.2        1.11 ±  3%  perf-profile.calltrace.cycles-pp.os_xsave.syscall
      1.12 ±  4%      +0.2        1.32 ±  5%  perf-profile.calltrace.cycles-pp.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker
      1.06 ±  4%      +0.2        1.26 ±  5%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
      0.83 ±  5%      +0.2        1.03 ±  5%  perf-profile.calltrace.cycles-pp.generic_perform_write.generic_file_write_iter.io_write.io_issue_sqe.io_wq_submit_work
      1.09 ±  3%      +0.2        1.30 ±  5%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__io_req_task_work_add.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
      1.18 ±  4%      +0.2        1.38 ±  5%  perf-profile.calltrace.cycles-pp.__io_req_task_work_add.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker
      1.65 ±  4%      +0.2        1.86 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64
      1.74 ±  4%      +0.2        1.98 ±  5%  perf-profile.calltrace.cycles-pp.schedule.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.69 ±  3%      +0.3        2.96 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.io_wq_worker.ret_from_fork
      2.97 ±  3%      +0.3        3.25 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.io_wq_worker.ret_from_fork.ret_from_fork_asm
      3.75 ±  3%      +0.3        4.06 ±  4%  perf-profile.calltrace.cycles-pp.io_wq_submit_work.io_worker_handle_work.io_wq_worker.ret_from_fork.ret_from_fork_asm
      3.67 ±  3%      +0.3        3.99 ±  4%  perf-profile.calltrace.cycles-pp.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker.ret_from_fork
      4.38 ±  3%      +0.4        4.80 ±  4%  perf-profile.calltrace.cycles-pp.io_worker_handle_work.io_wq_worker.ret_from_fork.ret_from_fork_asm
      2.99 ±  4%      +0.5        3.48 ±  5%  perf-profile.calltrace.cycles-pp.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      3.83 ±  3%      +0.5        4.32 ±  4%  perf-profile.calltrace.cycles-pp.schedule_timeout.io_wq_worker.ret_from_fork.ret_from_fork_asm
      0.00            +0.6        0.58 ±  3%  perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      8.69 ±  3%      +1.0        9.66 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      8.69 ±  3%      +1.0        9.66 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      8.68 ±  3%      +1.0        9.66 ±  4%  perf-profile.calltrace.cycles-pp.io_wq_worker.ret_from_fork.ret_from_fork_asm
      1.24 ±  5%      +2.1        3.32 ± 14%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      1.28 ±  6%      +2.1        3.36 ± 14%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      1.30 ±  5%      +2.1        3.38 ± 14%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      1.43 ±  5%      +2.1        3.55 ± 13%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.40 ±  5%      +2.5        3.88 ± 13%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
      1.40 ±  5%      +2.5        3.89 ± 13%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.61 ±  5%      +2.5        4.12 ± 13%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.81 ±  4%      +2.5        4.33 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.83 ±  5%      +2.5        4.36 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.84 ±  4%      +2.5        4.36 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      1.99 ±  4%      +2.6        4.54 ± 12%  perf-profile.calltrace.cycles-pp.__close
     21.18 ±  4%      +4.1       25.24 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
     21.35 ±  4%      +4.1       25.41 ±  3%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.truncate_inode_pages_range.truncate_pagecache.simple_setattr
     21.25 ±  4%      +4.1       25.32 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range
     21.26 ±  4%      +4.1       25.32 ±  3%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.truncate_inode_pages_range.truncate_pagecache
     22.03 ±  4%      +4.2       26.22 ±  3%  perf-profile.calltrace.cycles-pp.folios_put_refs.truncate_inode_pages_range.truncate_pagecache.simple_setattr.notify_change
     25.19 ±  5%      +6.3       31.52 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
     25.29 ±  5%      +6.4       31.66 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
     25.30 ±  5%      +6.4       31.70 ±  3%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range
     25.63 ±  5%      +6.4       32.04 ±  3%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.truncate_pagecache
     25.65 ±  5%      +6.4       32.06 ±  3%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.truncate_pagecache.simple_setattr
     25.65 ±  5%      +6.4       32.06 ±  3%  perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.truncate_pagecache.simple_setattr.notify_change
     48.06 ±  4%     +10.8       58.82 ±  3%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.truncate_pagecache.simple_setattr.notify_change.do_truncate
     48.10 ±  4%     +10.8       58.88 ±  3%  perf-profile.calltrace.cycles-pp.truncate_pagecache.simple_setattr.notify_change.do_truncate.do_open
     48.15 ±  4%     +10.8       58.99 ±  3%  perf-profile.calltrace.cycles-pp.simple_setattr.notify_change.do_truncate.do_open.path_openat
     48.37 ±  4%     +10.9       59.26 ±  3%  perf-profile.calltrace.cycles-pp.do_truncate.do_open.path_openat.do_filp_open.do_sys_openat2
     48.26 ±  4%     +10.9       59.15 ±  3%  perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_open.path_openat.do_filp_open
     48.70 ±  4%     +11.0       59.68 ±  3%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     50.48 ±  4%     +13.1       63.58 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     50.53 ±  4%     +13.1       63.65 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     50.76 ±  4%     +13.2       63.94 ±  2%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     50.82 ±  4%     +13.2       64.00 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     50.83 ±  4%     +13.2       64.01 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     50.77 ±  4%     +13.2       63.95 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     50.97 ±  4%     +13.2       64.16 ±  2%  perf-profile.calltrace.cycles-pp.open64
     15.01 ±  5%     -11.9        3.11 ±  6%  perf-profile.children.cycles-pp.__x64_sys_dup
     15.12 ±  5%     -11.9        3.24 ±  5%  perf-profile.children.cycles-pp.dup
     10.35 ±  3%      -6.5        3.86 ±  6%  perf-profile.children.cycles-pp.io_close
     13.77 ±  3%      -6.3        7.50 ±  2%  perf-profile.children.cycles-pp.io_submit_sqes
     14.33 ±  3%      -6.2        8.15 ±  2%  perf-profile.children.cycles-pp.io_issue_sqe
     17.22 ±  3%      -5.7       11.54 ±  2%  perf-profile.children.cycles-pp.__do_sys_io_uring_enter
     20.54 ±  3%      -5.0       15.50 ±  2%  perf-profile.children.cycles-pp.syscall
      6.36 ±  3%      -4.2        2.20 ±  7%  perf-profile.children.cycles-pp.filp_close
      3.93 ±  3%      -2.3        1.62 ±  5%  perf-profile.children.cycles-pp.io_is_uring_fops
      3.50 ±  3%      -2.1        1.39 ±  6%  perf-profile.children.cycles-pp.fd_install
      3.87 ±  2%      -2.1        1.80 ±  5%  perf-profile.children.cycles-pp.fput
      2.67 ±  5%      -2.1        0.62 ± 10%  perf-profile.children.cycles-pp.filp_flush
      0.37 ±  4%      -0.1        0.25 ± 21%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.37 ±  4%      -0.1        0.25 ± 22%  perf-profile.children.cycles-pp.perf_mmap__push
      0.37 ±  4%      -0.1        0.26 ± 19%  perf-profile.children.cycles-pp.cmd_record
      0.37 ±  4%      -0.1        0.26 ± 19%  perf-profile.children.cycles-pp.handle_internal_command
      0.37 ±  4%      -0.1        0.26 ± 19%  perf-profile.children.cycles-pp.main
      0.37 ±  4%      -0.1        0.26 ± 19%  perf-profile.children.cycles-pp.run_builtin
      0.27 ±  6%      -0.1        0.19 ± 21%  perf-profile.children.cycles-pp.write
      0.27 ±  5%      -0.1        0.19 ± 23%  perf-profile.children.cycles-pp.record__pushfn
      0.27 ±  5%      -0.1        0.19 ± 23%  perf-profile.children.cycles-pp.writen
      0.21 ± 13%      -0.1        0.13 ±  9%  perf-profile.children.cycles-pp.locks_remove_posix
      0.25 ±  5%      -0.1        0.17 ± 22%  perf-profile.children.cycles-pp.ksys_write
      0.24 ±  5%      -0.1        0.16 ± 21%  perf-profile.children.cycles-pp.vfs_write
      0.41            -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.vfs_statx
      0.55 ±  2%      -0.1        0.48 ±  2%  perf-profile.children.cycles-pp.io_statx
      0.14 ± 14%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.path_init
      0.22 ±  6%      -0.1        0.16 ± 21%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.22 ±  3%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.filename_lookup
      0.53 ±  2%      -0.1        0.47 ±  3%  perf-profile.children.cycles-pp.do_statx
      0.17 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.find_vma_prev
      0.08 ±  5%      -0.0        0.04 ± 60%  perf-profile.children.cycles-pp.perf_mmap__read_head
      0.08 ±  5%      -0.0        0.04 ± 60%  perf-profile.children.cycles-pp.ring_buffer_read_head
      0.29 ±  2%      -0.0        0.26 ±  5%  perf-profile.children.cycles-pp.do_madvise
      0.30 ±  2%      -0.0        0.27 ±  4%  perf-profile.children.cycles-pp.io_madvise
      0.27 ±  4%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.path_lookupat
      0.08            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.mas_prev_slot
      0.15 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.do_dentry_open
      0.11            -0.0        0.09        perf-profile.children.cycles-pp.asm_sysvec_thermal
      0.10            -0.0        0.08        perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.11            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.file_remove_privs_flags
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.sysvec_thermal
      0.19 ±  3%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.vfs_open
      0.08            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__vfs_getxattr
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.__sysvec_thermal
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.intel_thermal_interrupt
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.io_wq_worker_sleeping
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.find_lock_entries
      0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.io_readv_writev_cleanup
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__task_rq_lock
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.kfree
      0.07 ±  6%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.__cond_resched
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.cp_statx
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.update_curr_se
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.io_run_task_work
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.10 ±  4%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.update_min_vruntime
      0.13 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.vruntime_eligible
      0.05 ±  9%      +0.0        0.07        perf-profile.children.cycles-pp.unmap_mapping_range
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.11 ±  6%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__memset
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.complete_walk
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__put_user_8
      0.20 ±  3%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.filemap_read
      0.27 ±  5%      +0.0        0.29 ±  4%  perf-profile.children.cycles-pp.io_clean_op
      0.12 ±  4%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.io_assign_current_work
      0.10 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.io_statx_prep
      0.13 ±  5%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.update_entity_lag
      0.07 ±  9%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.dl_scaled_delta_exec
      0.04 ± 50%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.file_update_time
      0.06            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.13 ±  3%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.25            +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.mutex_unlock
      0.12 ±  3%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.requeue_delayed_entity
      0.19 ±  2%      +0.0        0.21 ±  5%  perf-profile.children.cycles-pp.getname_flags
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.alloc_fd
      0.06            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.dput
      0.09 ± 15%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.36 ±  3%      +0.0        0.39 ±  4%  perf-profile.children.cycles-pp.io_read
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.05 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.enqueue_timer
      0.34 ±  4%      +0.0        0.37 ±  3%  perf-profile.children.cycles-pp.reweight_entity
      0.23 ±  3%      +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.20 ±  3%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.avg_vruntime
      0.15 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.41 ±  4%      +0.0        0.44 ±  4%  perf-profile.children.cycles-pp.io_free_batch_list
      0.13 ±  3%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__get_user_8
      0.10            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__enqueue_entity
      0.12            +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.02 ±122%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.06            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.xas_store
      0.06 ±  7%      +0.0        0.10        perf-profile.children.cycles-pp.folio_alloc_noprof
      0.11 ±  7%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.26 ±  2%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.lock_timer_base
      0.22 ±  3%      +0.0        0.26        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.18 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.47 ±  4%      +0.0        0.51 ±  4%  perf-profile.children.cycles-pp.__io_submit_flush_completions
      0.21 ± 13%      +0.0        0.25 ± 12%  perf-profile.children.cycles-pp.ktime_get
      0.01 ±200%      +0.0        0.06 ± 14%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.54 ±  4%      +0.0        0.59 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.58 ±  6%      +0.0        0.63 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      0.15 ±  5%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.__dequeue_entity
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._copy_to_iter
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.dentry_needs_remove_privs
      0.55 ±  6%      +0.1        0.60 ±  5%  perf-profile.children.cycles-pp.__io_run_local_work
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.may_open
      0.27 ±  3%      +0.1        0.33 ±  4%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.23            +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.put_prev_entity
      0.28            +0.1        0.34 ±  4%  perf-profile.children.cycles-pp.pick_eevdf
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.try_to_unlazy
      0.36            +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.perf_tp_event
      0.22 ±  3%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.__try_to_del_timer_sync
      0.17            +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.mutex_lock
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.detach_if_pending
      0.38 ±  5%      +0.1        0.44 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.31 ±  3%      +0.1        0.37 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.25 ±  3%      +0.1        0.31 ±  3%  perf-profile.children.cycles-pp.__timer_delete_sync
      0.41 ±  3%      +0.1        0.47 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.28 ±  3%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.38 ±  2%      +0.1        0.45 ±  3%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.47 ±  2%      +0.1        0.54 ±  3%  perf-profile.children.cycles-pp.wakeup_preempt
      0.41 ±  4%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.59 ±  4%      +0.1        0.66 ±  3%  perf-profile.children.cycles-pp.prepare_task_switch
      0.38 ±  3%      +0.1        0.45 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.49 ±  2%      +0.1        0.56 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.46 ±  3%      +0.1        0.53 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.15 ±  2%      +0.1        0.22        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.37 ±  4%      +0.1        0.44 ±  4%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.30 ± 21%      +0.1        0.37 ±  5%  perf-profile.children.cycles-pp.queue_event
      0.30 ± 21%      +0.1        0.38 ±  5%  perf-profile.children.cycles-pp.process_simple
      0.76 ±  3%      +0.1        0.84 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.ima_file_check
      0.36 ±  3%      +0.1        0.44 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.40 ±  2%      +0.1        0.48 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.security_file_post_open
      0.20            +0.1        0.29 ±  6%  perf-profile.children.cycles-pp.stress_io_uring_child
      0.58 ±  2%      +0.1        0.66 ±  4%  perf-profile.children.cycles-pp.pick_task_fair
      0.33 ± 10%      +0.1        0.42 ±  6%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.59 ±  3%      +0.1        0.68 ±  4%  perf-profile.children.cycles-pp.__switch_to
      1.47 ±  3%      +0.1        1.56 ±  4%  perf-profile.children.cycles-pp.io_queue_async
      0.50 ±  2%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.47 ±  2%      +0.1        0.58 ±  3%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.29            +0.1        0.39 ±  4%  perf-profile.children.cycles-pp.__mod_timer
      0.35 ±  9%      +0.1        0.46 ±  6%  perf-profile.children.cycles-pp.simple_write_begin
      0.57 ±  3%      +0.1        0.70 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.57 ±  3%      +0.1        0.71 ±  3%  perf-profile.children.cycles-pp.uncharge_batch
      0.58 ±  3%      +0.1        0.72 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.71 ±  3%      +0.1        0.85 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.05 ±  5%      +0.1        1.18 ±  5%  perf-profile.children.cycles-pp.generic_perform_write
      0.57 ±  4%      +0.1        0.70 ±  3%  perf-profile.children.cycles-pp.page_counter_cancel
      0.81 ±  4%      +0.2        0.97 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      2.41 ±  3%      +0.2        2.57 ±  4%  perf-profile.children.cycles-pp.io_queue_iowq
      2.10 ±  3%      +0.2        2.26 ±  4%  perf-profile.children.cycles-pp.io_wq_activate_free_worker
      1.00 ±  3%      +0.2        1.17 ±  3%  perf-profile.children.cycles-pp.update_curr
      2.24 ±  3%      +0.2        2.42 ±  4%  perf-profile.children.cycles-pp.io_wq_enqueue
      1.18 ±  4%      +0.2        1.36 ±  5%  perf-profile.children.cycles-pp.io_write
      0.93 ±  2%      +0.2        1.12 ±  3%  perf-profile.children.cycles-pp.os_xsave
      1.06 ±  4%      +0.2        1.26 ±  5%  perf-profile.children.cycles-pp.generic_file_write_iter
      1.18 ±  4%      +0.2        1.38 ±  5%  perf-profile.children.cycles-pp.__io_req_task_work_add
      1.33 ±  3%      +0.2        1.56 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      3.75 ±  3%      +0.3        4.07 ±  4%  perf-profile.children.cycles-pp.io_wq_submit_work
      3.08 ±  3%      +0.4        3.43 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      4.39 ±  3%      +0.4        4.82 ±  4%  perf-profile.children.cycles-pp.io_worker_handle_work
      4.49 ±  4%      +0.5        4.98 ±  5%  perf-profile.children.cycles-pp.__schedule
      3.85 ±  3%      +0.5        4.35 ±  4%  perf-profile.children.cycles-pp.schedule_timeout
      2.99 ±  4%      +0.5        3.49 ±  5%  perf-profile.children.cycles-pp.io_cqring_wait
      4.72 ±  3%      +0.5        5.23 ±  4%  perf-profile.children.cycles-pp.schedule
      8.69 ±  3%      +1.0        9.66 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      8.69 ±  3%      +1.0        9.66 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      8.68 ±  3%      +1.0        9.66 ±  4%  perf-profile.children.cycles-pp.io_wq_worker
      1.24 ±  5%      +2.1        3.32 ± 14%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      1.28 ±  6%      +2.1        3.36 ± 14%  perf-profile.children.cycles-pp.security_file_alloc
      1.30 ±  5%      +2.1        3.39 ± 14%  perf-profile.children.cycles-pp.init_file
      1.43 ±  5%      +2.1        3.56 ± 13%  perf-profile.children.cycles-pp.alloc_empty_file
      1.40 ±  5%      +2.5        3.88 ± 13%  perf-profile.children.cycles-pp.apparmor_file_free_security
      1.40 ±  5%      +2.5        3.89 ± 13%  perf-profile.children.cycles-pp.security_file_free
      1.61 ±  5%      +2.5        4.12 ± 13%  perf-profile.children.cycles-pp.__fput
      1.82 ±  5%      +2.5        4.33 ± 12%  perf-profile.children.cycles-pp.__x64_sys_close
      2.02 ±  5%      +2.6        4.59 ± 12%  perf-profile.children.cycles-pp.__close
     21.37 ±  4%      +4.1       25.44 ±  3%  perf-profile.children.cycles-pp.__page_cache_release
     22.12 ±  4%      +4.2       26.32 ±  3%  perf-profile.children.cycles-pp.folios_put_refs
     25.69 ±  5%      +6.4       32.10 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
     25.65 ±  5%      +6.4       32.06 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
     25.65 ±  5%      +6.4       32.07 ±  3%  perf-profile.children.cycles-pp.__folio_batch_release
     46.44 ±  4%     +10.4       56.81 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     46.61 ±  4%     +10.5       57.07 ±  3%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     46.93 ±  4%     +10.5       57.42 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     48.06 ±  4%     +10.8       58.82 ±  3%  perf-profile.children.cycles-pp.truncate_inode_pages_range
     48.10 ±  4%     +10.8       58.88 ±  3%  perf-profile.children.cycles-pp.truncate_pagecache
     48.15 ±  4%     +10.8       58.99 ±  3%  perf-profile.children.cycles-pp.simple_setattr
     48.27 ±  4%     +10.9       59.16 ±  3%  perf-profile.children.cycles-pp.notify_change
     48.37 ±  4%     +10.9       59.26 ±  3%  perf-profile.children.cycles-pp.do_truncate
     48.70 ±  4%     +11.0       59.68 ±  3%  perf-profile.children.cycles-pp.do_open
     50.48 ±  4%     +13.1       63.58 ±  2%  perf-profile.children.cycles-pp.path_openat
     50.53 ±  4%     +13.1       63.65 ±  2%  perf-profile.children.cycles-pp.do_filp_open
     50.76 ±  4%     +13.2       63.94 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
     50.77 ±  4%     +13.2       63.95 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
     51.00 ±  4%     +13.2       64.19 ±  2%  perf-profile.children.cycles-pp.open64
     11.45 ±  5%      -9.8        1.69 ±  6%  perf-profile.self.cycles-pp.__x64_sys_dup
      3.92 ±  3%      -2.3        1.62 ±  5%  perf-profile.self.cycles-pp.io_is_uring_fops
      3.49 ±  3%      -2.1        1.38 ±  6%  perf-profile.self.cycles-pp.fd_install
      3.85 ±  2%      -2.1        1.78 ±  5%  perf-profile.self.cycles-pp.fput
      2.25 ±  5%      -1.8        0.45 ± 11%  perf-profile.self.cycles-pp.filp_flush
      0.20 ± 11%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.locks_remove_posix
      0.08 ±  5%      -0.0        0.04 ± 60%  perf-profile.self.cycles-pp.ring_buffer_read_head
      0.07 ±  5%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.filename_lookup
      0.08 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.do_dentry_open
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.io_wq_worker_sleeping
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.switch_fpu_return
      0.05 ±  9%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.hash_name
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.io_free_batch_list
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.07            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__io_run_local_work
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.do_filp_open
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.open64
      0.08            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.update_curr_se
      0.10 ±  4%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.08            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.05 ±  7%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.__close
      0.05 ±  7%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.lock_timer_base
      0.05 ±  9%      +0.0        0.07        perf-profile.self.cycles-pp.kmem_cache_free
      0.09 ±  4%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.update_min_vruntime
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__memset
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.11 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.04 ± 50%      +0.0        0.06        perf-profile.self.cycles-pp.update_curr_dl_se
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__put_user_8
      0.06 ± 12%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.dl_scaled_delta_exec
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.12 ±  3%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.mutex_unlock
      0.13 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.schedule
      0.15 ±  2%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.27 ±  3%      +0.0        0.30 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.24 ±  2%      +0.0        0.27 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.05            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.enqueue_timer
      0.09 ± 12%      +0.0        0.12 ± 13%  perf-profile.self.cycles-pp.ktime_get
      0.12            +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.20 ±  3%      +0.0        0.23 ±  4%  perf-profile.self.cycles-pp.avg_vruntime
      0.18 ±  2%      +0.0        0.22 ±  4%  perf-profile.self.cycles-pp.schedule_timeout
      0.22 ±  3%      +0.0        0.25 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.08 ±  6%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.truncate_inode_pages_range
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__mod_timer
      0.09 ±  5%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__enqueue_entity
      0.13 ±  3%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__get_user_8
      0.13 ±  5%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.__dequeue_entity
      0.10            +0.0        0.14 ±  6%  perf-profile.self.cycles-pp.__do_sys_io_uring_enter
      0.20 ±  2%      +0.0        0.24 ±  4%  perf-profile.self.cycles-pp.io_worker_handle_work
      0.53 ±  4%      +0.0        0.58 ±  5%  perf-profile.self.cycles-pp.__schedule
      0.18 ±  2%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.24 ±  4%      +0.0        0.29 ±  4%  perf-profile.self.cycles-pp.syscall
      0.25            +0.0        0.29 ±  3%  perf-profile.self.cycles-pp.perf_tp_event
      0.20            +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.pick_eevdf
      0.15            +0.0        0.20 ±  4%  perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__try_to_del_timer_sync
      0.00            +0.1        0.05        perf-profile.self.cycles-pp._copy_to_iter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.notify_change
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.put_prev_entity
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.resched_curr
      0.27 ±  4%      +0.1        0.32 ±  5%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.26 ±  3%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.do_open
      0.31 ±  4%      +0.1        0.37 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.38 ±  6%      +0.1        0.44 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.detach_if_pending
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.xas_store
      0.30 ±  3%      +0.1        0.37 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      0.35 ±  3%      +0.1        0.42 ±  3%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.38 ±  4%      +0.1        0.45 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
      0.20            +0.1        0.28 ±  6%  perf-profile.self.cycles-pp.stress_io_uring_child
      0.40 ±  3%      +0.1        0.48 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.53 ±  3%      +0.1        0.61 ±  4%  perf-profile.self.cycles-pp.__switch_to
      0.51 ±  3%      +0.1        0.61 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.37 ±  3%      +0.1        0.48 ±  5%  perf-profile.self.cycles-pp.io_cqring_wait
      0.57 ±  4%      +0.1        0.70 ±  3%  perf-profile.self.cycles-pp.page_counter_cancel
      0.80 ±  3%      +0.2        0.96 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.93 ±  2%      +0.2        1.12 ±  3%  perf-profile.self.cycles-pp.os_xsave
      1.24 ±  6%      +2.1        3.30 ± 14%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      1.39 ±  5%      +2.5        3.86 ± 13%  perf-profile.self.cycles-pp.apparmor_file_free_security
     46.44 ±  4%     +10.4       56.81 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




[1]

***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/xfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/getdent/stress-ng/60s

commit: 
  bef236c3c0 ("fs: add file_ref")
  d91ea8195e ("fs: port files to file_ref")

bef236c3c0fea5fc d91ea8195ed416365007d83d296 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :6          100%           6:6     dmesg.BUG:kernel_NULL_pointer_dereference,address
           :6          100%           6:6     dmesg.Kernel_panic-not_syncing:Fatal_exception
           :6          100%           6:6     dmesg.Oops
           :6           17%           1:6     dmesg.RIP:__file_ref_put
           :6          100%           6:6     dmesg.RIP:aa_file_perm
           :6           33%           2:6     dmesg.RIP:filp_flush
           :6           17%           1:6     dmesg.WARNING:at_fs/file.c:#__file_ref_put
           :6           67%           4:6     dmesg.WARNING:at_fs/open.c:#filp_flush





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


