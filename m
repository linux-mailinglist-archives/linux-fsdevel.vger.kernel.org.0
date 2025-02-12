Return-Path: <linux-fsdevel+bounces-41567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56921A320D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 09:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E2F165109
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C86204F9D;
	Wed, 12 Feb 2025 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEfX2CmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C68204F83;
	Wed, 12 Feb 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348461; cv=fail; b=gprdYUZqX+Qw5ChshW0QIFFuKz73blyJ1cLM38TKLuqPmnzDdtIREeXP6/ERNde2cN6SDMnb/nEw/D76xAQcICsR+YjHMwsqPqYXTOGgO60qDfEuZkrU4sQr7CDW2HXkEWIHI5OkQ/xNPMnzSdnZkypiBB5zJMUrrzK2m72uJQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348461; c=relaxed/simple;
	bh=Flq1d5U0eEY8Uks4cxRQ/ffjpHNzofTBrWjIIGMLSoE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Wws19KJsng4NBzlmuA6gwa1XLiUPqmDbj79ZQPN7apWhB6VL4he3gTwFg7n+ggeKseQOK4dyYeXD54HlwoahhM/bD0ezc8lIhXgwxLykoRu9i7bVaFvKZ3wSF92zAi77gznQydvlBuZhPhYgKryAbFHecCnNIRizyID7k5HFfvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEfX2CmL; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739348459; x=1770884459;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Flq1d5U0eEY8Uks4cxRQ/ffjpHNzofTBrWjIIGMLSoE=;
  b=IEfX2CmLFQ9tAk/6iHgMhEzIN8yac2SjF+bgGwfAP5vKn9ffeIJAI/Oy
   qb+WM/uKKWNbE/Pu3LmyCkSdTDb6PajgXJOW6YNO2RXQeeymOznUB7992
   AyG+JKgLpthBFRzuciYoTUTpsLENJRdd0eBDYspAfdzR+6EicNMkLSPD1
   PrNrleHQK5hxXgEiOagHG5l5x0fVtr6gMx2DB37i1WrNO6taAfRITUfsJ
   QIC/wxRHmwFUx3RKsdJ4/1Zv24gISrRMMX+PZo9yilv6XJMp1+XRwFN1Y
   OPjLhqgPZ6e4h5m1+k7lxse+ZcwInVqAyR/AL3JbtPAKXIn+oUzgwn7VP
   Q==;
X-CSE-ConnectionGUID: edfVnpM9RXes9R+umjM5Iw==
X-CSE-MsgGUID: 2RVhBhYZQG207I4NSkmwlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50636849"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50636849"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:20:57 -0800
X-CSE-ConnectionGUID: kqLPjs1NT8a3rtvF26HdLQ==
X-CSE-MsgGUID: LBIIzv6HR7yJaHsVjFfkBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112706654"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 00:20:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 00:20:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 00:20:56 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 00:20:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVL5EyVgImhEw5PyBepLZILz/xzNzkwKm+DdNQG9lK8s277MboICSqhChs7vEjY+9KmM9nY6/lfAf4NxdvmV9F2ajXyh14WIkLA44zPG2zR/sOiPV3L2VqElUPX8wCRMofTcr4a5uB6iDQkwaGL3sAfhq63jfuGvkiEVxU03MlZTg3ZPRHcxeaM6SgTeA4Pk9tcMN2ugN/l2JblKYJAjNBFMCDN9AAqU3pl1ligEjzxTYovI1LBarkVqVpeYxxE0d8sjKx3jaAS0uBJg4GrzEvRn9OI56mbtgwQKnZYcnbmAnBXmcZTbG+aGgsW35zIMkp981aCJKZFYTVwHpIY+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj+LC5aR5mZb3VDwrcH4T7bR6pztau2gug2bc/uuHtw=;
 b=CeF2QY7RMut31cGk7vHwsAJfl/1L8APPqU0cxAmwXtQigB+8EsJO8ESfL5yyd8x3KRI8wbufKZasJZpPnb3E/x8NIq4N7kGNxyoV98BwH5o1xsO/mzj34t7jG/59SA64nEJ9EXluVGBT3oKUDKwmqCWN/XK5kANW9dm+wFw/U6kbWad4018WtpTMGci6I5befUnTz0pfFfuMjHEuCQUn01GAjmuisEOyOEvjWRz+b+ZbEj70y6+svUGqXmnWuB3l58ef6/k9TuTLwiPC6VVzbhMgt5Zwls8fxqj1NdQB2r5uhw/4ezShAYqzI6UyFfKVaULF7EW8Ypt3eCYj6zm1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 08:20:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 08:20:52 +0000
Date: Wed, 12 Feb 2025 16:20:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	<v9fs@lists.linux.dev>, <linux-afs@lists.infradead.org>,
	<ceph-devel@vger.kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<samba-technical@lists.samba.org>, <oliver.sang@intel.com>
Subject: [linus:master] [netfs]  e2d46f2ec3:  filebench.sum_operations/s
 50.0% regression
Message-ID: <202502121520.d583b3c3-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 48195e4e-314f-4c88-3cc1-08dd4b3e2a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?qtsiaud99NwVtu4RA79aWyfyzhUy7KMvlsk2EfxGlG+aw96OXjq/0KN4ed?=
 =?iso-8859-1?Q?8RBwUo3anzrwXpsdetLcvJRoHyOK+FH9RLtbJe/Zp7FOPUrmqFxg3AlfPg?=
 =?iso-8859-1?Q?4qPf5rWOPqkeZOK6nlLGg931iAzQuB5sABcpf2vq84Shp/suSiVgiMvVtz?=
 =?iso-8859-1?Q?gwPcYmP5ctFsmF4e0sfKmR1ABJ417fpxKDlB7aS4oVSGabABPgB0Lu8tS3?=
 =?iso-8859-1?Q?T2s2V1lJ19K50T5JfXOr5arcHBPMuVkT2xq+DrAkf2kTwPxY5nYuQaNI7n?=
 =?iso-8859-1?Q?Bjf1JGV3JlifFw49wlxTSrWt56i08tfXZ1LyGbZPRF5qriNoUGp8wz5gvK?=
 =?iso-8859-1?Q?O0RU5GaXSlY5R027AZVRtfeUsvmi70mHDepq15rib5P3TZBUAzkyg7dVeg?=
 =?iso-8859-1?Q?TElZFFQVYIcgkIcI3CPHSmCBXul7S/i5B16SmJ1HR57m49QQIvfa9krsZZ?=
 =?iso-8859-1?Q?SIKZfluhbn4CD6GAS62h1c3AV7zcZfNNkgOLArHApI69FYC8TsUSy+QYrW?=
 =?iso-8859-1?Q?M6YgSLDcrxS2BsF56tKik2yT3eBoi4TUsnmdgFlcYKDMt/U2d8sdSyxqcc?=
 =?iso-8859-1?Q?GUI127fscaCMwpolyIgtCIzWV4BlKUP4xEqFrxVH3IOmPmre0FJ058lrz5?=
 =?iso-8859-1?Q?tor9/lbsReovKO7yMW/+N3wjxW6oDB1JFnRQdM+bfSRFyTkeve86dRojsP?=
 =?iso-8859-1?Q?mJSbS26+MnNhWVPJ6eXjp5iIE1FgBMGllDTtITUoJe+Qeoyi3LGU4atriH?=
 =?iso-8859-1?Q?f0RNSpoTvIll75XjSMsoQIhD7IWp27m6CHz4w9bRe7xIZVu8dqq0WljtCS?=
 =?iso-8859-1?Q?j+Zvdbf0dF4hwNSFQV49X9iQ3ph8Wq5CUlKjcb08nTwHhdIY4tDLTCxE6/?=
 =?iso-8859-1?Q?D8opoYItteqCx5ld3JeC0k2TzgJHusxtxe3qlybRxMuO1S3Pjma8TFcwQA?=
 =?iso-8859-1?Q?AFeMAt41lyAjSxCaFSyW0FpbfRYamKmzW0teJh/vbwgQ7s0uTKB6QWoZba?=
 =?iso-8859-1?Q?Fq76rlkG+fwjEyQPoYD12vUR7c0mxdcOXzbV+kgO6gixtuL/RDMhYGa+tN?=
 =?iso-8859-1?Q?s94D/rhmBRjtu0fxn/eXUpFSeNjqbXpTfg5nQvmSDKUhd6pbhYsF2Ign74?=
 =?iso-8859-1?Q?t7nIYnHjxkcud+BCY1eQCeZjUGTwbSVPrdTuzibcY7YFIpBGzxbNd8tXqi?=
 =?iso-8859-1?Q?DG1Wa5Aa27mwMO2LcI3lrNkGIsbRXSaXOr2zyxEgQ8LDACVIzjkV1abR1H?=
 =?iso-8859-1?Q?/FKAh/PBsFSM3mjTAcmTlrI/CZB5a9eHHzScpWUaNslpvFaVl8HLepqkxt?=
 =?iso-8859-1?Q?J05C9PEu2QZuSd6j+Z2352FZQMCGwyN8SvlLfuY5ASxDWjnViJbs+Cz9mZ?=
 =?iso-8859-1?Q?7I26yxbUqeBNLq9t3lo2AZEa0ctStyMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ibdvSHX1bQHHZ7YZiT37VaMK4/zCoQYhNbh/TfiHVMPSSw3BffujEf1VQ0?=
 =?iso-8859-1?Q?+EGuRoJgFNNpXHeSF7bokQSFEQ3BRc6SsnejNIadi7aAHO5nT3oxSkF0bt?=
 =?iso-8859-1?Q?i0rhA2iBN/se7lNTt8l5ms6bVYyWWNgEXcRlnzFWlfa+NDbBKrbfpDHeGM?=
 =?iso-8859-1?Q?WsUqewEsu7sY5AMyzPatCrupK3xsFQQ/tGd42Kd4Qmg0wTR7oODEcIYeJZ?=
 =?iso-8859-1?Q?tjPz71slyDCr3WMF1d2x6nxCtJN8tXuERBDonNt6tg8Nt8GkUnATpEjUr4?=
 =?iso-8859-1?Q?MqiJmf2SshaZQqp+5i7tJg+RQvA3pvmwJ21KzElxVPFzYpKLphLOABMwXC?=
 =?iso-8859-1?Q?TyBqMT7tXj7EPOncY86I/2wJu8On4FKPfd++tL3MbB0n8c+rHM/83a8+hs?=
 =?iso-8859-1?Q?rpaxVAGX5XM+i8/bA6NhvlsRW2gMkF6ktQKCnWYulbhU4B5r8vGJp1rUMx?=
 =?iso-8859-1?Q?3UW/FKq6+Q0Fplstx/q/Alr323B+DNo0cNlTYGcAWSHkFAtQD9975rPnz4?=
 =?iso-8859-1?Q?s+YpQBe96EfHdXYGD7+lEqwayFm9CKdT+uctYJEKs65yKTgu2eb1sp1lFA?=
 =?iso-8859-1?Q?x16kcHErlmz/IIZkWsPJ+DR6gH8uwVNwxf5Mxmd2pvtGydKO/y18OB7B9T?=
 =?iso-8859-1?Q?1/HkhIHApuUlj8Top268bvzYFFNO3hlNj2BXlomwzBE7AJgrbEQQpivBa2?=
 =?iso-8859-1?Q?Ze2AB1hAcMB0kZNu0lB1VAgEUlVZuPLEJoXVwFjudghgjCPpu0hg78o+ns?=
 =?iso-8859-1?Q?GjNqSGlahrPfmDEiZS3Kc470wuRxywEsEUqxYK/uqGtLTICGuU3Jvrj3XS?=
 =?iso-8859-1?Q?owtGopcK6GT7KXebQnAlcm18QZWry34SQgVpLjSFdibCpGomFDDH1nV7r3?=
 =?iso-8859-1?Q?h7u62Ke5zhMrgj+VGp/QZNrbaPD9Dk5kCpv0t2pVRnklxMetQ3EIJ0zbjW?=
 =?iso-8859-1?Q?yBgWAaXtFQy5If+TXGVDFDSFi+dtYGiF2MMjrsTl/SRMCckDfV4QtFtL+9?=
 =?iso-8859-1?Q?dTd7hlv0Sl6M9PPSy+0247Kh6Vqc2+gV/cHhUmH2pBsflArtXv1Ghoo+jN?=
 =?iso-8859-1?Q?8dSqnAV4YGi1rferUpGJZHwhPeMzv+pR8pOsuIbyHGI4JDjzzjUOy7gMoP?=
 =?iso-8859-1?Q?GzehBh8XD8X6E2JbBreC7HPKN04bpoypL6Ug/AxGbTtvqbD0igFUdA7RNV?=
 =?iso-8859-1?Q?0y35ZGBQ5jQNZMzvVCRmNCXcZVrbLpmFJbF3pOlIzGd2VIBvYmW/S4GKoe?=
 =?iso-8859-1?Q?JayDhjHJ9yEeXYH9OzGwt/y9db9ZE+vn3Kul9hhnYBXM99s81EoBufsFAV?=
 =?iso-8859-1?Q?AGlNs6TvNgt5/ffe69jjzkMTC/bHqAWd3pNPF/6tRXeYYkRbM329F23txc?=
 =?iso-8859-1?Q?hLUXOmdI4tlsBnkz4OX3H8w1qZ8e6HVRd4DXS5NgCGUBIctOWEQqSIkXMa?=
 =?iso-8859-1?Q?iOv0e/wHcTk7JmHRLdSmALEU/51m1O/FoHmn0DpEkrKdZK0ka45w+Wxpu2?=
 =?iso-8859-1?Q?5gHi8RpcU4SoffUe2WuDs1+MrLOpT+u/pWfqzKwH+qsOWESGg3WRl7rHiD?=
 =?iso-8859-1?Q?zji1BkqetGc9b9rdtTcx0vT6EopDhbzSBOympoGG6on7PLgxbxL1aH6YFI?=
 =?iso-8859-1?Q?F/OAN4g+pJ7rzS3E3jGaIAlC24CSaz5kmH5EsiS72XGvH4tGgmSUjeQQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48195e4e-314f-4c88-3cc1-08dd4b3e2a00
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:20:52.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGjV/FU1SfNr3KkuTITxaFqgJFoOCRTKn3DJ02vgJxu0G8sz0OFpAZes/TegHhks30m8oqLzY6pIepu2taxKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 50.0% regression of filebench.sum_operations/s on:


commit: e2d46f2ec332533816417b60933954173f602121 ("netfs: Change the read result collector to only use one work item")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      69b54314c975f4dfd3a29d6b9211ab68fff46682]
[test failed on linux-next/master ed58d103e6da15a442ff87567898768dc3a66987]

testcase: filebench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: ext4
	fs2: cifs
	test: copyfiles.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502121520.d583b3c3-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250212/202502121520.d583b3c3-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/ext4/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/copyfiles.f/filebench

commit: 
  eddf51f2bb ("afs: Make {Y,}FS.FetchData an asynchronous operation")
  e2d46f2ec3 ("netfs: Change the read result collector to only use one work item")

eddf51f2bb2c28b0 e2d46f2ec332533816417b60933 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    111550 ± 17%     -17.2%      92328        sched_debug.cfs_rq:/.load.stddev
      4.52 ±218%     -98.3%       0.08 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.15 ±  2%     +22.0%       0.19 ± 12%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
   9404404            +5.0%    9871609        perf-stat.i.cache-references
      4.82            +0.1        4.87        perf-stat.overall.branch-miss-rate%
      4.88            -0.3        4.63 ±  2%  perf-stat.overall.cache-miss-rate%
   9290667            +5.0%    9751847        perf-stat.ps.cache-references
     31.30           -50.2%      15.60        filebench.sum_bytes_mb/s
      6001           -50.0%       3000        filebench.sum_operations/s
      1001           -50.0%     500.00        filebench.sum_reads/s
      0.11 ± 14%    +104.3%       0.23 ±  8%  filebench.sum_time_ms/op
      1000           -50.0%     500.00        filebench.sum_writes/s
      5.89 ±  8%      -1.4        4.52 ± 45%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail
      5.88 ±  8%      -1.4        4.52 ± 45%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail
      5.81 ±  8%      -1.3        4.47 ± 45%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail
      6.58 ±  7%      -0.5        6.10 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.74 ±  8%      -0.5        6.26 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.35 ±  9%      -0.5        1.88 ± 10%  perf-profile.calltrace.cycles-pp.getxattr
      5.35 ±  3%      -0.3        5.08 ±  2%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      5.35 ±  3%      -0.3        5.08 ±  2%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
      5.35 ±  3%      -0.3        5.09 ±  2%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
      5.35 ±  3%      -0.3        5.09 ±  2%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
      5.35 ±  3%      -0.3        5.10 ±  2%  perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.59 ± 10%      +0.1        0.66 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64
      2.16 ±  2%      +0.2        2.32 ±  2%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.17 ±  3%      +0.2        2.33 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.17 ±  3%      +0.2        2.33 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.17 ±  3%      +0.2        2.33 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      2.17 ±  3%      +0.2        2.33 ±  2%  perf-profile.calltrace.cycles-pp.execve
      1.39 ± 10%      +0.2        1.62 ± 11%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.44 ±  9%      +0.2        1.68 ±  7%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.58 ±  7%      -0.5        6.10 ±  4%  perf-profile.children.cycles-pp.process_one_work
      6.74 ±  8%      -0.5        6.26 ±  4%  perf-profile.children.cycles-pp.worker_thread
      2.37 ±  9%      -0.4        1.92 ± 11%  perf-profile.children.cycles-pp.getxattr
      5.35 ±  3%      -0.3        5.08 ±  2%  perf-profile.children.cycles-pp.console_flush_all
      5.35 ±  3%      -0.3        5.08 ±  2%  perf-profile.children.cycles-pp.console_unlock
      5.35 ±  3%      -0.3        5.09 ±  2%  perf-profile.children.cycles-pp.devkmsg_emit
      5.35 ±  3%      -0.3        5.09 ±  2%  perf-profile.children.cycles-pp.vprintk_emit
      5.35 ±  3%      -0.3        5.10 ±  2%  perf-profile.children.cycles-pp.devkmsg_write
      0.54 ± 17%      -0.1        0.39 ± 16%  perf-profile.children.cycles-pp.cifs_d_revalidate
      0.57 ± 15%      -0.1        0.44 ± 14%  perf-profile.children.cycles-pp.lookup_one_qstr_excl
      0.57 ± 14%      -0.1        0.43 ± 15%  perf-profile.children.cycles-pp.lookup_dcache
      0.21 ± 45%      -0.1        0.08 ± 51%  perf-profile.children.cycles-pp._copy_from_iter
      0.03 ±141%      +0.1        0.13 ± 38%  perf-profile.children.cycles-pp.__run_timers
      0.09 ± 56%      +0.1        0.21 ± 34%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.04 ±147%      +0.1        0.16 ± 47%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.17 ± 25%      +0.1        0.29 ± 22%  perf-profile.children.cycles-pp.xas_find
      0.23 ± 22%      +0.1        0.36 ± 10%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.19 ± 24%      +0.1        0.34 ±  9%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.04 ±147%      +0.2        0.18 ± 46%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      2.17 ±  3%      +0.2        2.33 ±  2%  perf-profile.children.cycles-pp.execve
      2.19 ±  3%      +0.2        2.36        perf-profile.children.cycles-pp.__x64_sys_execve
      2.18 ±  2%      +0.2        2.34        perf-profile.children.cycles-pp.do_execveat_common
      0.50 ± 12%      +0.2        0.69 ± 27%  perf-profile.children.cycles-pp.enqueue_entity
      0.15 ± 57%      +0.2        0.36 ± 16%  perf-profile.children.cycles-pp.perf_read
      0.49 ± 25%      +0.3        0.74 ± 23%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.35 ± 29%      +0.3        0.63 ± 15%  perf-profile.children.cycles-pp.readn
      0.77 ± 18%      +0.3        1.09 ± 19%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.19 ± 24%      +0.1        0.31 ± 10%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.23 ± 22%      +0.1        0.36 ± 10%  perf-profile.self.cycles-pp.native_irq_return_iret




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


