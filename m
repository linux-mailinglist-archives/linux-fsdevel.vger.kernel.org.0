Return-Path: <linux-fsdevel+bounces-34462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B89C5C5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C41DB38499
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319DC1FBF52;
	Tue, 12 Nov 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eai4GO/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D864DA04;
	Tue, 12 Nov 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420043; cv=fail; b=Jgipj93OakbpWd/3RzUjmvnhBmTkvCqpjt9s4d0wNg9y51lkM4biI5JtWjrO5RAayHFnCtHLh6lcm9UJ2OSGAH4/eLYYGeZz4jcOjRepudAtvYGhIgGYOQHVLgjXqAAFj3EaLWgYklhEqsVPHeLvT05lHFSdaDL1m02iDDxJTl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420043; c=relaxed/simple;
	bh=YdKekjj75RgPryEQQpG8gTVO4jWnLKcOL59I1sRAYAU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cEa6N26gvM87TWqws+KK1SAtXBoq87+3qnXJj9U+A44ugHNBIXBMOLHClG6x68iR7alTVWkqSeVtFfgmUHrQqqzBeY67qtYELbETiDkmANMPCpdqY+qmdbPT0FtNiCb70TgarxvmntYfnIgeXcQLOjeV3nM9nTxYO4g9IsVNrEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eai4GO/j; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731420041; x=1762956041;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=YdKekjj75RgPryEQQpG8gTVO4jWnLKcOL59I1sRAYAU=;
  b=eai4GO/jI0EpLaWgzgR82A5kQzHWY1eHR8Oq1aIHNTE4TehgPaLikAbt
   Pl1eO41lVWM77hsdQvkDI8EdHltsjWzqK42Mv54QUC6DKkVc2YAjolOtT
   F55yPbcNAux0x2RKSOxkLP6g0CLlYTKQVLwtLenEpybrKxDllmUm6soPJ
   vDqLHaj20XRIFIQ8OJsO++621BlpoER/G/zCZg/zVu+Jjg3flgBntDUXi
   INDTS+eNc0kxaTsdPaeoil3b8v7M7HIH/1uMWPLdPGBnX+GSWkeZ647aU
   h7vu3+m37253c5jtRMJrHTPlFg2BPjnxhBSgW1/4nwk92DTGms8q+Ro/m
   Q==;
X-CSE-ConnectionGUID: S2Jh294iRbak8f58IQuoLg==
X-CSE-MsgGUID: UhZyMJqIST2CPPi9mf6gtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="30654961"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="30654961"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 06:00:40 -0800
X-CSE-ConnectionGUID: xwYSaJMkQTSTSbesi8XYjA==
X-CSE-MsgGUID: PuaWW6T2QG2dMyNrODldCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87840894"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 06:00:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 06:00:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 06:00:40 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 06:00:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXgTgjh6qnXyO3YBlDGB+jBamDxe1gGmfBXH0zKWvQKpsiG3GJl/TVciXfITLP/35xFVJZKoxiu7T9T13IILjB2td9XHWJXyg26nnMhfr2gOEDR74n26f6DZNFbPKBUXdxbus6luKBv8kgwkZ6lPUufz1DH0a2Gcpg38jLm7wzeeO6eXQmhpy3WSHmZjUiDV16c33b+zQtz3vPxa7T1bDbD0g79FHHaduU5MNxVTPhPNS4iKAYtKWQhrj0usypAY9LTFLieoDD2My1dsyN3OkYNXpydFRbqpF0jZZSqU8PUeuMLaJfP3E4MwMEzeQG3qwHo5kewWidihDWD77jkPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DadJfNtVc+GgHJSGGG27n2Szg6sBv+TmPGmdzc4+h4=;
 b=jAc4OGeNK7W4MqGAVzW1dUxkK4oLuXD3LZITxwkvU6BYGvmZ+pjLMQjJYaP5UU+Z1af1V6JEQCBsRCmbuIwCMEZMoLMrJLEoHitDL2lQerodmuwQHPbcGRZa/iQglSg+1z3dunDKVxbDW1EcVrZGgEWeOiYt2uu2acxK+t+NA/XI46C+n+KU+Z/5qbhsQb2SH2fC4ZbkxqZegteX0OGoMuF3YDrP+lFvdEgg33FIvpYVeULeehXzEC8Q1r8b+EoAQyMhrA17IABW4Ma7Jir3WZ+yksD0dDBoGo0Ju9i94N1OrsTJMRz0A43y9PSjNQhhi/o1Q2IDPBlMbBCczGYVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6143.namprd11.prod.outlook.com (2603:10b6:8:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 14:00:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 14:00:29 +0000
Date: Tue, 12 Nov 2024 22:00:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xuewen Yan <xuewen.yan@unisoc.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, Jing Xia <jing.xia@unisoc.com>, Brian Geffon
	<bgeffon@google.com>, Benoit Lize <lizeb@google.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [epoll]  900bbaae67:  filebench.sum_operations/s
 3.8% regression
Message-ID: <202411122121.de84272a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cbe3b2-aeab-4c20-90e3-08dd03225dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/qvJFkbdpykG6rC2xXW/ITtqvpTxkFeHciv7lMTt8w4ZS3BQePt+1ACwwT?=
 =?iso-8859-1?Q?2L6cfpBnbwLfIgeqr+CtbEoEG6qsbopzoXzl0tbIeRGe0a4BXv53xgyiGx?=
 =?iso-8859-1?Q?erilbkoQ7YkWMJRHuvuFdbVLZqnnXaX/YIq6lQzwMp+Vy1O/M2YT8j4b1e?=
 =?iso-8859-1?Q?plXTrfTA2WhoOO1b29eAmY9WDes9QmlLjZXENpTcNSx58sUXDZhZvuZuTb?=
 =?iso-8859-1?Q?ENNTEGQTBbQsp4HSO53CeNu12Z62qlU8EtaCqvtmVLKNOeXC7r3u7qXPbA?=
 =?iso-8859-1?Q?ve0kY8t2NvCD4NC0PQoobE87O3UOEb/oOBUKqSIqVmcIiUXrzk9U5mjsDE?=
 =?iso-8859-1?Q?0aN5bXuXlmQk9addecR7H3Oohkc4fhFH6EYK1+u/o+qkJdlTAWSWQO8GA8?=
 =?iso-8859-1?Q?c/LN7jpov5SFHw0s0Vr5Hys6xT9ZwLw5taAHZms1H74CuqJFvAOhFxrAKI?=
 =?iso-8859-1?Q?mz00d0Y+efhVXVS+mkRH4+4dSDGRpTelCfW5RutCiHXPlK+MLnWvFMRfpE?=
 =?iso-8859-1?Q?xOFT7XElmf6hJe2KJgs+DxoBf6f+/jt3qxBTPsWRvCVe41n7Az32SvTOtS?=
 =?iso-8859-1?Q?77+MietdodqfnxDDssBxWBQXGuqvIEIvd3/dk806vxQGE+HL/xu8mNNN/h?=
 =?iso-8859-1?Q?qsDLGy1iyFa36+gIDXGJlG2Q7Pn2jVL2h7VxO2+bDHkMzcNOZDv514v4TT?=
 =?iso-8859-1?Q?APi7mIIbsz1delHKFBE7vLWcdy1FLiVmWx4bPxiDEVfhfsviAdR3cFYTLh?=
 =?iso-8859-1?Q?3DCO3k0yTgVOqtvPDZbcovrqIurQmhl9g2HsheaWOZD4WZN5a1Bb1LU8V0?=
 =?iso-8859-1?Q?XwWiTvTJ6fEKBSpXBT2CkC56P4KjuRVY/7iTw8cKY0TUkdGda3jV2n+JLH?=
 =?iso-8859-1?Q?bombh3LuDadmS0gVh62DBHR/Jnv+ZJ5fHgos43KMKHOoqpCED0GqJif1CW?=
 =?iso-8859-1?Q?XvLiEEkuWBni6DUEbE54otFVZuaRFKEV2SmybKG5/4KPNuffpvjyJmZQv7?=
 =?iso-8859-1?Q?Cs+bZXK4G5OU+AYUbhF1t8QPDORjxkykVXNL0/4qBDOlwvx64mJhEMmCAX?=
 =?iso-8859-1?Q?DcE+7fFhRd5N+iMWSl/rcqKfyoT0+MiY7ytx0qte3gTlcJst+pBISYCWcD?=
 =?iso-8859-1?Q?/99HB72L6XZT5L8P+mOmw0oiUE2gdNsZjQspuDkeyq1jMJIhen0xQPJei+?=
 =?iso-8859-1?Q?EM/0R/2AxAU5BnKnvRcqhhiHIwahinQzmVDTbaPsm34Ob9gUj7c+x3Fh2s?=
 =?iso-8859-1?Q?bOPwGOI1F+jMCwpD2w47v1ecECRM1tEaQxxK0qNOq6xnLZutjv1BmIQadP?=
 =?iso-8859-1?Q?l8xbQtsstN6UaIh/amXCqie4SWdhMdm2vDZg/djR6Pc27amwtQyjMVEr9v?=
 =?iso-8859-1?Q?txk9nzrZoH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yWnxyYqPBhaWTwcnCRwMxm66npU0spRv3qIgBqVsb4KlEtJp8yoBMSDYaa?=
 =?iso-8859-1?Q?ppSPqnsqLOAv5+0jx7y0pl5MJwzsPa1U5eKr38HfnKoBkO6sEYi0Zthp7m?=
 =?iso-8859-1?Q?tomR3EUXo86QVWAXFbq2LI52KdqyOgA1V/a5rke4EpFYfLa2YWP8FIsB8j?=
 =?iso-8859-1?Q?ljwSblaInZ7uc1zYfuLmFm7DY0fUoTNKb6SQVfIgPFyGfVOCvmvUW3X8y7?=
 =?iso-8859-1?Q?fP7UG6wzxk2PIpd9l0x3oAsPnhUnByQHEZuLKcDIExcoTHf23mGMGSYmoY?=
 =?iso-8859-1?Q?lVXgrUZxu3UFJNRC9qHm5L1uCdlXRnKvy/FxmgvWtGo4DTQMc3YQTXYu7B?=
 =?iso-8859-1?Q?ZIaEmHuk1zZU3WAfXfU7ClXMFFLt2UNupVaJOhySie6JZo2Dekr0MqV/16?=
 =?iso-8859-1?Q?bRUu4z8HVm4RCYHwZqdB9V1kjF8DgID7LpOYCRmFLf4eLASCw+CQjRoN9H?=
 =?iso-8859-1?Q?1sCVjwgGAgaFE9Rm0Dj0vAWCd9MEsz9TwL7AQ+Yy/9NaU0RLi15HtOFtfO?=
 =?iso-8859-1?Q?z1ztF/WjBEn51w+6k27IGKgcs6GC4uOIXP84k0mVIB6w6t72uiTv6V5q3w?=
 =?iso-8859-1?Q?dar4o7Hj/x1vCLI+5TmHchHRhjR+YxEv/cT59DUMIsV8Opl0uzkRDZDTU8?=
 =?iso-8859-1?Q?OCpm5tuX70sgsBUAV6PSO+ryYVVg/8tLknzUBDoVKqEcA6xWkX5/V536hm?=
 =?iso-8859-1?Q?+u+AnD9RcxILPJ416tNGHu885PihInGRDJcUl9hTgloJxbCqD5uc3NI39/?=
 =?iso-8859-1?Q?9BI6cRpv16grjQ3lqhP8Z+Gm4RqA/wuR5fXbFWj1oJ9fbk1nrtvpDgl0hj?=
 =?iso-8859-1?Q?3ox/z4f88+MrbAWW6KDI1M9yQ8mU+jKgu+DrrpSkUUCFRKDCcasV5z/2/O?=
 =?iso-8859-1?Q?ZLjr4sEcJqkT+4tD2efA2+daNa/nSJ5XXwBsKZLxL41LMy3Tk7Yt+8cDK7?=
 =?iso-8859-1?Q?DYaV8L15Kpuf/PECHVtosWm6Fx+4vRs5INqn7IVPBodkvTsU8pq3fK/Ul2?=
 =?iso-8859-1?Q?Y6Kd5FoRiKr9MG32QSqnO5w/Hj/BiMM+qFzlndfJSjjAxg8kHPtdDRJMFJ?=
 =?iso-8859-1?Q?JGKsPiX2Ovl+HriagN9r1jJxh54OO2t7qhgaFuCDyOJEFrpFB09i0m1vj1?=
 =?iso-8859-1?Q?C4CARYiROhKxadKWfIlCjrOvpOuFSiTdM2KFlFQk1yWPrt+FataulHopA5?=
 =?iso-8859-1?Q?7MENEX22l93SvqQe/yo94iiopGdTf8cj7r0lc+4rmimXJiCr0BSrPoXhn+?=
 =?iso-8859-1?Q?C3dzL+MJSN2zdJ3kbLaW6A+jmo+bYcZRWacAlzeQT4EcJzQrW46B2Irqpz?=
 =?iso-8859-1?Q?K0dfLt/G7HIconOT/HEzb0KGO7lD+AehCw84VfmTrj6Y8hU1ELLBKJAiDf?=
 =?iso-8859-1?Q?EWtTPB1X5Hz9CJyMO7XBRoUdvUJSvVeqd8vUIxSxAo+iMfcQWkESHwgyL0?=
 =?iso-8859-1?Q?uEfqzhXKh8ImzqmoHiJ21GtG8xQ9lT+bjCkAgU4NDqgZDa3ci/M+fmNo9d?=
 =?iso-8859-1?Q?0CSSOe/fb7IDKh39HyhPEWZk0+6GcqS19CojFWrLONO6jCDIYnwu/yPZmL?=
 =?iso-8859-1?Q?QQhF4sdKyFOKKcKK9Rxsa8C4vAVXJlu29SsSO4HnIPwAgSYhPONlE5vm0s?=
 =?iso-8859-1?Q?Bu/QBnoCbRNg3ADp1bAUD02F5etX92dNAWtdC+wonv0Dmup9IZlhnVLQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cbe3b2-aeab-4c20-90e3-08dd03225dc3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:00:29.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMDCmWUK5noeAnEuUhx+plyF+KHiZ8xMVKBUP6mfcCDKsqG6XwvD3WA0alMTTEVGswBK6ZKYv7Nn0cgNOCA+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6143
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.8% regression of filebench.sum_operations/s on:


commit: 900bbaae67e980945dec74d36f8afe0de7556d5a ("epoll: Add synchronous wakeup support for ep_poll_callback")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb]

testcase: filebench
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: ext4
	fs2: cifs
	test: webproxy.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411122121.de84272a-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241112/202411122121.de84272a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/webproxy.f/filebench

commit: 
  0dfcb72d33 ("coredump: add cond_resched() to dump_user_range")
  900bbaae67 ("epoll: Add synchronous wakeup support for ep_poll_callback")

0dfcb72d33c767bb 900bbaae67e980945dec74d36f8 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.03            +0.0        0.04        mpstat.cpu.all.irq%
      0.85            -0.1        0.76        mpstat.cpu.all.sys%
   2185818 ± 58%     -45.3%    1195059 ±104%  numa-meminfo.node1.FilePages
   1975339 ± 64%     -52.1%     946422 ±133%  numa-meminfo.node1.Unevictable
    364.50 ± 12%     +50.6%     549.00 ±  2%  perf-c2c.DRAM.remote
    208.17 ± 12%     +56.4%     325.67 ±  6%  perf-c2c.HITM.remote
      1002 ± 59%    +152.4%       2530 ± 32%  sched_debug.cpu.nr_switches.min
      8764 ±  3%     -25.7%       6515 ±  7%  sched_debug.cpu.nr_switches.stddev
     13791            -5.3%      13057        vmstat.system.cs
     11314            +4.2%      11784        vmstat.system.in
    546482 ± 58%     -45.3%     298775 ±104%  numa-vmstat.node1.nr_file_pages
    493834 ± 64%     -52.1%     236605 ±133%  numa-vmstat.node1.nr_unevictable
    493834 ± 64%     -52.1%     236605 ±133%  numa-vmstat.node1.nr_zone_unevictable
     13.58            -3.2%      13.15        filebench.sum_bytes_mb/s
    232514            -3.8%     223695        filebench.sum_operations
      3874            -3.8%       3727        filebench.sum_operations/s
      1019            -3.8%     980.50        filebench.sum_reads/s
     25.75            +3.9%      26.76        filebench.sum_time_ms/op
    203.83            -3.7%     196.33        filebench.sum_writes/s
    499886            -1.8%     490769        filebench.time.file_system_outputs
     17741 ±  2%      -3.9%      17040        filebench.time.minor_page_faults
     68.50           -14.6%      58.50        filebench.time.percent_of_cpu_this_job_got
    123.86           -14.9%     105.36        filebench.time.system_time
    350879            -2.8%     341014        filebench.time.voluntary_context_switches
     29557            -4.4%      28256        proc-vmstat.nr_active_anon
     16635 ±  3%      +4.3%      17352        proc-vmstat.nr_active_file
     37364            -3.8%      35926        proc-vmstat.nr_shmem
     29557            -4.4%      28256        proc-vmstat.nr_zone_active_anon
     16635 ±  3%      +4.3%      17352        proc-vmstat.nr_zone_active_file
     12281 ± 13%     +47.2%      18083 ± 15%  proc-vmstat.numa_hint_faults
    965.00 ±  6%     -30.8%     668.00 ± 20%  proc-vmstat.numa_huge_pte_updates
    518951 ±  6%     -28.2%     372754 ± 20%  proc-vmstat.numa_pte_updates
     73011            -1.1%      72183        proc-vmstat.pgactivate
    698445            +2.2%     713680        proc-vmstat.pgfault
     31722           +14.9%      36439 ±  3%  proc-vmstat.pgreuse
      1.12 ± 20%      -0.3        0.81 ±  8%  perf-profile.children.cycles-pp.__lookup_slow
      0.37 ± 26%      -0.2        0.20 ± 29%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.39 ±  9%      -0.2        0.22 ± 56%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.18 ± 40%      -0.1        0.06 ± 73%  perf-profile.children.cycles-pp.__poll
      0.18 ± 40%      -0.1        0.06 ± 73%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.18 ± 40%      -0.1        0.06 ± 73%  perf-profile.children.cycles-pp.do_sys_poll
      0.16 ± 45%      -0.1        0.05 ± 84%  perf-profile.children.cycles-pp.perf_evlist__poll_thread
      0.15 ± 33%      +0.1        0.25 ± 15%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.03 ±100%      +0.1        0.14 ± 49%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.13 ± 47%      +0.1        0.28 ± 39%  perf-profile.children.cycles-pp.irq_work_tick
      0.49 ± 32%      +0.3        0.77 ± 20%  perf-profile.children.cycles-pp.__wait_for_common
      0.82 ± 20%      +0.4        1.22 ± 21%  perf-profile.children.cycles-pp.affine_move_task
      0.11 ± 37%      -0.1        0.04 ±112%  perf-profile.self.cycles-pp.task_contending
      0.03 ±100%      +0.1        0.14 ± 49%  perf-profile.self.cycles-pp.lockref_get_not_dead
 9.279e+08            -5.0%  8.816e+08        perf-stat.i.branch-instructions
      2.93            +0.0        2.98        perf-stat.i.branch-miss-rate%
  13227049            +4.3%   13791182        perf-stat.i.branch-misses
      2.99            +0.2        3.20 ±  2%  perf-stat.i.cache-miss-rate%
   1805840 ±  2%     +19.2%    2152127        perf-stat.i.cache-misses
  47931959            +6.2%   50910857        perf-stat.i.cache-references
     13706            -4.3%      13122        perf-stat.i.context-switches
 4.597e+09            -8.8%  4.192e+09        perf-stat.i.cpu-cycles
    338.72           +70.9%     578.79        perf-stat.i.cpu-migrations
      2345 ±  2%     -13.2%       2036 ±  3%  perf-stat.i.cycles-between-cache-misses
 4.233e+09            -4.7%  4.035e+09        perf-stat.i.instructions
      0.77            +1.8%       0.78        perf-stat.i.ipc
      2957 ±  2%      +4.2%       3081        perf-stat.i.minor-faults
      2957 ±  2%      +4.2%       3081        perf-stat.i.page-faults
      0.43 ±  2%     +25.0%       0.53        perf-stat.overall.MPKI
      1.42            +0.1        1.56        perf-stat.overall.branch-miss-rate%
      3.77 ±  2%      +0.5        4.23        perf-stat.overall.cache-miss-rate%
      1.09            -4.3%       1.04        perf-stat.overall.cpi
      2547 ±  2%     -23.5%       1948        perf-stat.overall.cycles-between-cache-misses
      0.92            +4.5%       0.96        perf-stat.overall.ipc
 9.229e+08            -5.0%   8.77e+08        perf-stat.ps.branch-instructions
  13149814            +4.3%   13712774        perf-stat.ps.branch-misses
   1795922 ±  2%     +19.2%    2140605        perf-stat.ps.cache-misses
  47675878            +6.2%   50645024        perf-stat.ps.cache-references
     13636            -4.3%      13055        perf-stat.ps.context-switches
 4.573e+09            -8.8%  4.171e+09        perf-stat.ps.cpu-cycles
    336.94           +70.9%     575.93        perf-stat.ps.cpu-migrations
  4.21e+09            -4.7%  4.014e+09        perf-stat.ps.instructions
      2934 ±  2%      +4.2%       3057        perf-stat.ps.minor-faults
      2934 ±  2%      +4.2%       3057        perf-stat.ps.page-faults
  7.63e+11            -4.2%  7.309e+11        perf-stat.total.instructions
      0.00 ±223%   +6816.7%       0.07 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.03 ± 20%     +40.2%       0.04 ± 16%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.03 ±  3%     +53.0%       0.05 ±  3%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.08 ±  5%     -11.9%       0.07 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ±  3%     +14.2%       0.05 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.03           +26.5%       0.03 ±  2%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.02 ±223%    +552.7%       0.10 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.cancel_work_sync._cifsFileInfo_put.cifs_close_deferred_file_under_dentry.cifs_unlink
      0.00 ±223%  +15516.7%       0.16 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.16 ±  6%     +16.5%       0.19 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
     33.98 ± 11%     +28.0%      43.51 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.56           +13.7%       0.63        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    392.79 ± 12%     +29.2%     507.64 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.02           +32.4%       1.35 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.24           +10.7%       0.27        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     99.17 ±  9%     -22.0%      77.33 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_noprof.cifs_strndup_to_utf16.cifs_convert_path_to_utf16.smb2_compound_op
     82.50 ± 21%     -48.7%      42.33 ± 16%  perf-sched.wait_and_delay.count.__cond_resched.cancel_work_sync._cifsFileInfo_put.process_one_work.worker_thread
    741.67 ±  4%      +8.5%     804.67 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      1228           -13.1%       1067 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      2421 ±  3%     -13.8%       2088 ±  3%  perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
     41.50 ±  7%     -25.3%      31.00 ±  8%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     10750           -24.7%       8094        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    279.23 ±  2%      +9.1%     304.73 ±  3%  perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_noprof.cifs_strndup_to_utf16.cifs_convert_path_to_utf16.smb2_compound_op
      1001          +111.3%       2115 ± 37%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    286.84 ±  4%     +10.7%     317.62 ±  8%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    290.82 ±  3%     +11.8%     325.18 ±  8%  perf-sched.wait_and_delay.max.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_open
    291.61 ±  2%     +11.4%     324.95 ±  9%  perf-sched.wait_and_delay.max.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info
      0.13 ±  6%     +19.6%       0.15 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
     33.97 ± 11%     +27.9%      43.46 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.01 ±223%  +12287.9%       0.68 ±114%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.08 ±  4%      +9.3%       0.09 ±  4%  perf-sched.wait_time.avg.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      0.47           +15.3%       0.54        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    392.76 ± 12%     +29.2%     507.60 ±  7%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.99           +31.7%       1.30 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.05 ±  3%     +14.2%       1.20 ±  6%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.cifs_call_async
    279.13 ±  2%      +9.1%     304.65 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_noprof.cifs_strndup_to_utf16.cifs_convert_path_to_utf16.smb2_compound_op
      0.01 ±223%  +35681.8%       1.97 ±121%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      1001          +111.3%       2115 ± 37%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    286.74 ±  4%     +10.7%     317.50 ±  8%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    290.73 ±  3%     +11.8%     325.08 ±  8%  perf-sched.wait_time.max.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_open
    291.52 ±  2%     +11.4%     324.84 ±  9%  perf-sched.wait_time.max.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


