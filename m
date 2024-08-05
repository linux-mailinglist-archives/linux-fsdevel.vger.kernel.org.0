Return-Path: <linux-fsdevel+bounces-24973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD49475FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C466E1F21A3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 07:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8C149E00;
	Mon,  5 Aug 2024 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RD/GYihn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CE149C50;
	Mon,  5 Aug 2024 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842715; cv=fail; b=cFWWoCYamxzDnNuNwgxCMjNfdVUJsb1LMRaV2mx6SXAKSg3rBKKNJHlhA065kqWsBLFdXldyv2Vw/e1N23yfc+9L0biCKFHN7oWFyitH/ah9hoDR4NWoR1FKt/cw1vTKCfmlSpdKEkzM/fUkw4w3TXGTD0jISwRaiLeDAEbiLDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842715; c=relaxed/simple;
	bh=TqPpNUb0g3BxNX+WC69yWedDBnQxueUIwwA2PKhz8Wg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dFYkvYEZvP0fACnxY2nZlq6CgSwyQ9FjKVNIyk/t/BN5AOskNMUE0Z8B1dRZyfrRRhtPWDHiw8OH8kycSFj+nRXuwtpixx8nkWO0u5APwYWZ+4nhVLIiLx6zsjkjqxU7BynT4kbEdc5rf0zE+cfhnQkhx6Wm8xqQNwcX8k1qRs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RD/GYihn; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722842713; x=1754378713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TqPpNUb0g3BxNX+WC69yWedDBnQxueUIwwA2PKhz8Wg=;
  b=RD/GYihnsUGey2FZv6U1owF9E+r/aNAIldr3Oljv+3JwihfUnk1Ppfv7
   Ccay3FnfVZv8RdOFnrpYx8t2JADlUyWY+p3KbKfp+b9SS0UftKIjBVVFD
   bd8Rcydsu9jnxz0SHUR7WDo9d2aVNZy4WOnOwoDeJYuz8SuD0ypoiTSG2
   JD1NeLav1uUqcWnYA6tlHjoV7dm6lSFpuLbNLEOUw/nCYa6GDxEaqlzRK
   ad776J5t8KOd8k41UX1t8hzjaZxdq13o5qCjvHMh0ycFrmde07Hec1Hna
   ch8HVSqvi5zv/IUrEEJxbOm1pwniYwOkPmfteaQIWdOwzVu0DwqddIG2c
   g==;
X-CSE-ConnectionGUID: pNvhqv6mRi+E79MDz+niiQ==
X-CSE-MsgGUID: kc7wug0eQZqLE852hdtmPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20364994"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20364994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 00:25:13 -0700
X-CSE-ConnectionGUID: R14/jLrfQSGCN35sazMenw==
X-CSE-MsgGUID: 4NxbRsz5Tsq+jlm1rsptVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="55949993"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 00:25:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 00:25:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 00:25:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 00:25:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 00:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXlQcrKBq1pcTmXYazEguznIWMJjV70jbUF0vaD0bfj6n6LSMN5iJIOE7tEXZwlAimXD7d1elA31+zL141I0Qzh/WSCw+pTUb4W41ZaKx6asBs29u8rR7t+7Yq7gXXK4QLq4CC9Ni4zmhntr2hG2E2uJIwaC6NBn7oed1KIZurThXwH9l2qDkOWYWYmNW4HgkYwvwh82bb9DQD0ZpRS4TxcwSBZoUtwtFiHGKDFCT8g0bKO2eYiJoiWxmvLF+rtNrUksQsfvjboW3mOPwBV/YuRfTqssy6/PPerE4ywGM6R9eTQ2EKgWCdHSjQnEHiK4ETMIsV2mz1cR5JvKJdJptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL5KK1tkKiOHm5mp5LIk5Y0raoVCFk87TXCSDesal6c=;
 b=LP8qTlKqNGFFnsagTFUBbg0dSGQzqRVxNVRXg1zTNtiMDM9/TfnFVcrLDioWBvIbbOyBetwgjc9EOSiNlKXlKOfjadZQbkicLuXbTwK3Lg5+AuK03qzlvg/4lYIDowx2CNBYaLPBTD0WXPKTzxiAUhgdMyES5wAxL4oaVPFsZa8z31yn4WjCDQuuj2nZNOIZLpIBZHnc6r8iCinyJWix7URYeYjgAId0zOFqnLAJgl1Mw2gL+lCHhVZ4CV2zevmrXV959CGSQMJp8KL9+4GR0Uag0zL9Iv+HchkU7/IA2rqFPuNkJsMqAoydIePGAbWO4VisOmLfB4Tj04Yo/k9qBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 07:25:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 07:25:08 +0000
Date: Mon, 5 Aug 2024 15:24:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Joel Granados
	<j.granados@samsung.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [sysctl:sysctl-testing] [sysctl]  9f1a3a2fce:
 sysctl_could_not_get_directory
Message-ID: <202408051453.f638857e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3952a1-cf54-4ce9-d8c2-08dcb51fbbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NNt1A5mE9XziDYJu7hZ460RBbMoQ7RRjWoUrbzK1XBSzBYLRbPjm5BjiRLjE?=
 =?us-ascii?Q?miIVFJGkEujmAZnBC1dwb6vEL4cQlUEEiM0Ra+loORtw9eSDyOcztfmo+THt?=
 =?us-ascii?Q?BFUOEMbAOd/gI4otejP2DzwqMrXIs8nkahLPqW9TV1An3Cy0Mz/QDpUSczaH?=
 =?us-ascii?Q?emu7zxFXUyYHVIQgKhzegUma6h3ObXpBkpjkWS6E15XsDPR0Zi64Ylhb1QwO?=
 =?us-ascii?Q?gCTgk/SbrIE09xTjtfu86TJsGTB56kNHJ9fToDnz2k/MGBgxOjhAEUhzt7pd?=
 =?us-ascii?Q?JOWWzrr7S8gVPWm7pyiGyC0C1BoE6CDZqTpAHraAX58IpxoPKP6XapUmJ6as?=
 =?us-ascii?Q?iKcKcP17wG0HBY9hOoqLw9C4fq5WgC97yIY8VY1CNaEmQJ77hmBw8Xafef+A?=
 =?us-ascii?Q?HuPM4OMpCzkvzoaOkNJy6L6hl1nDwRr/AOcHYJdQt1Vgoch1CB2e8+IlwewY?=
 =?us-ascii?Q?flsNshLfHoXDKXACrYsdfpU68MRC7I6owtfCIvZZdFZ3Cnb1obPwILiBOfgp?=
 =?us-ascii?Q?x5I1HRgkJSXcfn9VOtcXSxQ2zPlbrH0gRoE4V1tYWd02SeCyobnwyqlkffrw?=
 =?us-ascii?Q?yE+4o0CzMXLV/wrfLhWOwqtduvL9+lGWr204C4YR3CeFqgkAA/FWjPXivQ+S?=
 =?us-ascii?Q?RjzRsgohWSMoqzxq44iBypa78Fvtfstjso+qWrgo9SReT44AKpyrnXfaX/OM?=
 =?us-ascii?Q?5fOQcxRJqhKdEugTymIKe+wJqlED9ROt3PTAZ2K+EUVLYUib7g7gec7kPO4r?=
 =?us-ascii?Q?Mfu/opl2mXcrNtcYcioQbR2yhMuo2l8SHS5/3q2Se7D3/rIy4yWgvFsdZ00y?=
 =?us-ascii?Q?FUI3LHbaII/l6LbHKxiASai3ze82mo+017/QP6ELxy+WqgeP02NSxZg2cCRx?=
 =?us-ascii?Q?CBUsokrd6dnC5Ex++OHBtWc7xXtEW0Ve/ClkF8gLPmQXiKmKur+5EVESZ0No?=
 =?us-ascii?Q?FMIJv4OmaYRfRYqIFmqfcClHqpNbz7kDG08gCBqm8r44xVEjJzVVWnkMAwEp?=
 =?us-ascii?Q?4tSzajAUtSDm8VFwQ3JHGK7H5ToAikWJgtnIRfHlurCZBHyxz5mouKDrDmlj?=
 =?us-ascii?Q?x0Cv2fg2If7QZg+r0LKhjcy1WVSOR/SP8wiuV7r9W8DWANJ6FLdHwjN8deNT?=
 =?us-ascii?Q?aq0Q3Sj9TcQWPYyas/0Et/fE9dx196uVbFl4R3vfzYKrr0Yx4pY1cxyBwdjr?=
 =?us-ascii?Q?iF1Vp/q8FohHdCPb7RLCgzXdJ+Ci/9R+eq+ZuHbGu74NHjcMk7TShWytRvrq?=
 =?us-ascii?Q?QS+jcUeIFQc/NplxqJiVTkbf2eh7SNmrU7reXQlGq118EbfcsOn8hohnK478?=
 =?us-ascii?Q?FHNaat6sdnPmwrDWsMJ4oekl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JC3nklOuhBCupnLjPhwMgMj/jKhzphRFg3EhfRZECNnZJZ7DYT7u9MNRLS4g?=
 =?us-ascii?Q?bd0kFYRwfIdG3+wwBv+l5jh0YUxa+1tdgBQGCrPddyP1fnvct45iLAYlgM6I?=
 =?us-ascii?Q?33PeubC5aXx9hXZCgzJ4meD+Pobx+AcqWFEGw8u+5XVbs3gLq4dvIv6c/pJT?=
 =?us-ascii?Q?Ze1ylN/8Klae1u5UR3qcsVZxjrxZAjdr3yMeIxC4LlPQruMuYXPScJOR5rWT?=
 =?us-ascii?Q?swhCq4rlLeyig9oPyCz3eleah1tibYouCjboyz/yMCJ1W9JbL3OHnujsE713?=
 =?us-ascii?Q?umpaLjdQuVZwpyfRFqgcZSK9pge1EffAwogH5VueBZmd3f/UPgMyTxUzxGBD?=
 =?us-ascii?Q?N9aee+xnGs3FxCpZCzqLV25hKb9NStUWUP0GKMh8jZyS68JnIdsg18ljJzkQ?=
 =?us-ascii?Q?6fJhFMgwNJAH+nTKbixvLaL/EaFt18I3SIG5xgYx3ITmBx3RIZmHDtVYD7j4?=
 =?us-ascii?Q?7Z34EL7iLl2NMcyCVCxK5R+my5cClc/cAs29jduV9nCf1rHRS6dPAExIycqS?=
 =?us-ascii?Q?ONtYmbVmGMpB8HQDX2Etb1pvV6fnP2BG8YUrFAmJo0ixSp8CmAgeNNaUFkdy?=
 =?us-ascii?Q?cKfUO5Vo2orY1h3GiXV4aQ6jb9bboKDdGe1LQ8IjfltJz5LMawnWl0ECBuMr?=
 =?us-ascii?Q?IyfCVwGyl0O5zNq0S8K+qHaQg7F6tiIO0LLGZSAkXzCxY4dFfuYxMj4U0uUg?=
 =?us-ascii?Q?juQOhH0L5SDwEkoAJ/4uJJfE8+Jtcph0LtJPTifscnIMGaO1gLgocW9cF0KL?=
 =?us-ascii?Q?Hw3uDrepjXwX0+I4QyVOJbtIh20neblCGhZXlyk3kWwLN4SBgpUhZOUDkcDj?=
 =?us-ascii?Q?sr/C5aQEXLLgce71EzEUT68CDoPjY7/Osi4TSpvcIc9R0T1qM0of0dBtXQvx?=
 =?us-ascii?Q?WUJKyuVTThfEvgo6KmiRkewCT4bkiPX5Tssfh4LTeIsjuwULw0Yi02UtnqCF?=
 =?us-ascii?Q?/9N0S2wDXjRHWsGIB9GsfjaEbQ7Fa/8nIH3rZLnI0fUBLDFhTvG/1vXPiMJq?=
 =?us-ascii?Q?ghZ8ZVxNLRNfeEHdfSDcZ9k0CW8vq9mYzOSvM1jpmTMLKbDLulUw53opVRny?=
 =?us-ascii?Q?eFk3FQzl3KCUCjFyCXcvwoxn3ccvu0jriHvclAE6Gvyo0cRfU4tno4swzYoI?=
 =?us-ascii?Q?ndBQ1volms/CDOsB+EmJRjgtYgvfePR70VKllBqw3b8WiZtK8QVttpyjwT1s?=
 =?us-ascii?Q?OjtfwiOeOzFu9RONaFmpqPC/8ADkNqjL/Y+vz/BNG6BeOkDbgWN93Un/8OYI?=
 =?us-ascii?Q?SbgNkPjWTEEw7hKozmDuj+/vslsaErIljzs303+k9ZXY/czO74+i9NqzAev6?=
 =?us-ascii?Q?EsVrmL2OQ3P7Ld/PYBNQcml9/IQGZN9Phf5axW0/Befs8EkrWAUWh5KnPzIV?=
 =?us-ascii?Q?o0ulPS5qKucXs3Ru2ELZEBgIcgahNX2ez5gnu1u2Z87/o+n3v8Whw31BLT44?=
 =?us-ascii?Q?9Y7wKQH+8nErtereXEoyA1U5Q473t7BmkOe6U/RDd43VkiTORSON31gnIyge?=
 =?us-ascii?Q?cudNeC2ItJUBJcRrqza2uq3bvC7x4kxUP1Kp3y9rgRpuyP1gP7CM0SaGO1bi?=
 =?us-ascii?Q?oO7ixl7gGdzx+g5TSMPH67znRGNV+ixvByYbuuHRo3zcp9O664unJy7AcAuw?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3952a1-cf54-4ce9-d8c2-08dcb51fbbd1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 07:25:08.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGHU3TUX9kAZcm0jTBnZjp0VodS/112YC/G3g7i0azq+YExjiAMxH1MK1InkrLq2zZpFcBD1VrtiyBHRWD2sjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "sysctl_could_not_get_directory" on:

commit: 9f1a3a2fcea5b48ed81097e779d384a33deb1ac3 ("sysctl: make internal ctl_tables const")
https://git.kernel.org/cgit/linux/kernel/git/sysctl/sysctl.git sysctl-testing

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | 8ac44bd8e9 | 9f1a3a2fce |
+------------------------------------------+------------+------------+
| boot_successes                           | 24         | 0          |
| boot_failures                            | 0          | 24         |
| sysctl_could_not_get_directory           | 0          | 24         |
| kernel_BUG_at_kernel/ucount.c            | 0          | 24         |
| Oops:invalid_opcode:#[##]SMP_PTI         | 0          | 24         |
| RIP:user_namespace_sysctl_init           | 0          | 24         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 24         |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408051453.f638857e-lkp@intel.com


[    0.403331][    T1] devtmpfs: initialized
[    0.404444][    T1] x86/mm: Memory block size: 128MB
[    0.406772][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.408486][    T1] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.409606][    T1] pinctrl core: initialized pinctrl subsystem
[    0.410485][    T1] sysctl could not get directory: /net -30
[    0.411213][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.412462][    T1] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    0.413408][    T1] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.414428][    T1] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.415498][    T1] thermal_sys: Registered thermal governor 'fair_share'
[    0.415499][    T1] thermal_sys: Registered thermal governor 'bang_bang'
[    0.416351][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    0.418128][    T1] thermal_sys: Registered thermal governor 'user_space'
[    0.419133][    T1] cpuidle: using governor menu
[    0.421087][    T1] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.421666][    T1] PCI: Using configuration type 1 for base access
[    0.423516][    T1] sysctl could not get directory: /user -30
[    0.424138][    T1] ------------[ cut here ]------------
[    0.424885][    T1] kernel BUG at kernel/ucount.c:370!
[    0.425334][    T1] Oops: invalid opcode: 0000 [#1] SMP PTI
[    0.426110][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc1-00004-g9f1a3a2fcea5 #1
[    0.426125][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.426125][    T1] RIP: 0010:user_namespace_sysctl_init+0xdc/0xe0
[    0.426125][    T1] Code: 48 0f c1 81 80 00 00 00 48 8b 41 10 48 8b 88 58 02 00 00 48 8b 88 f0 01 00 00 48 85 c9 75 db 31 c0 5b c3 cc cc cc cc cc 0f 0b <0f> 0b cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
[    0.426125][    T1] RSP: 0000:ffffaa4540013b00 EFLAGS: 00010246
[    0.426125][    T1] RAX: 61a99279fe04ab00 RBX: ffffffffa210e1a0 RCX: 00000000000000b8
[    0.426125][    T1] RDX: 00000000000000b7 RSI: 0000000000039160 RDI: ffffffffa1644250
[    0.426125][    T1] RBP: ffffaa4540013e28 R08: 0000000000007fff R09: ffffffffa1653640
[    0.426125][    T1] R10: 0000000000017ffd R11: 0000000000000004 R12: 0000000000000000
[    0.426125][    T1] R13: 0000000000000000 R14: ffffffffa2346dc4 R15: 0000000000000000
[    0.426125][    T1] FS:  0000000000000000(0000) GS:ffff896c2fd00000(0000) knlGS:0000000000000000
[    0.426125][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.426125][    T1] CR2: 0000000000000000 CR3: 000000010241a000 CR4: 00000000000406f0
[    0.426125][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.426125][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.426125][    T1] Call Trace:
[    0.426125][    T1]  <TASK>
[    0.426125][    T1]  ? __die_body+0x66/0xb0
[    0.426125][    T1]  ? die+0xa0/0xc0
[    0.426125][    T1]  ? do_trap+0xa2/0x170
[    0.426125][    T1]  ? user_namespace_sysctl_init+0xdc/0xe0
[    0.426125][    T1]  ? handle_invalid_op+0x65/0x80
[    0.426125][    T1]  ? user_namespace_sysctl_init+0xdc/0xe0
[    0.426125][    T1]  ? exc_invalid_op+0x34/0x50
[    0.426125][    T1]  ? asm_exc_invalid_op+0x16/0x20
[    0.426125][    T1]  ? __pfx_user_namespace_sysctl_init+0x10/0x10
[    0.426125][    T1]  ? user_namespace_sysctl_init+0xdc/0xe0
[    0.426125][    T1]  ? __pfx_user_namespace_sysctl_init+0x10/0x10
[    0.426125][    T1]  do_one_initcall+0x11a/0x330
[    0.426125][    T1]  ? crng_fast_key_erasure+0x109/0x190
[    0.426125][    T1]  ? crng_make_state+0x174/0x1b0
[    0.426125][    T1]  ? get_random_u32+0x138/0x190
[    0.426125][    T1]  ? __get_random_u32_below+0xf/0x60
[    0.426125][    T1]  ? allocate_slab+0x1ef/0x670
[    0.426125][    T1]  ? parameq+0x13/0x90
[    0.426125][    T1]  ? __pfx_ignore_unknown_bootoption+0x10/0x10
[    0.426125][    T1]  ? parse_args+0x143/0x3e0
[    0.426125][    T1]  do_initcall_level+0x7c/0xd0
[    0.426125][    T1]  do_initcalls+0x59/0xa0
[    0.426125][    T1]  kernel_init_freeable+0x11e/0x190
[    0.426125][    T1]  ? __pfx_kernel_init+0x10/0x10
[    0.426125][    T1]  kernel_init+0x16/0x1a0
[    0.426125][    T1]  ret_from_fork+0x36/0x40
[    0.426125][    T1]  ? __pfx_kernel_init+0x10/0x10
[    0.426125][    T1]  ret_from_fork_asm+0x1a/0x30
[    0.426125][    T1]  </TASK>
[    0.426125][    T1] Modules linked in:
[    0.464137][    T1] ---[ end trace 0000000000000000 ]---
[    0.464859][    T1] RIP: 0010:user_namespace_sysctl_init+0xdc/0xe0
[    0.466337][    T1] Code: 48 0f c1 81 80 00 00 00 48 8b 41 10 48 8b 88 58 02 00 00 48 8b 88 f0 01 00 00 48 85 c9 75 db 31 c0 5b c3 cc cc cc cc cc 0f 0b <0f> 0b cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
[    0.468633][    T1] RSP: 0000:ffffaa4540013b00 EFLAGS: 00010246
[    0.469329][    T1] RAX: 61a99279fe04ab00 RBX: ffffffffa210e1a0 RCX: 00000000000000b8
[    0.470127][    T1] RDX: 00000000000000b7 RSI: 0000000000039160 RDI: ffffffffa1644250
[    0.471130][    T1] RBP: ffffaa4540013e28 R08: 0000000000007fff R09: ffffffffa1653640
[    0.472126][    T1] R10: 0000000000017ffd R11: 0000000000000004 R12: 0000000000000000
[    0.473126][    T1] R13: 0000000000000000 R14: ffffffffa2346dc4 R15: 0000000000000000
[    0.474127][    T1] FS:  0000000000000000(0000) GS:ffff896c2fd00000(0000) knlGS:0000000000000000
[    0.475127][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.475982][    T1] CR2: 0000000000000000 CR3: 000000010241a000 CR4: 00000000000406f0
[    0.477482][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.478502][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.480487][    T1] Kernel panic - not syncing: Fatal exception



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240805/202408051453.f638857e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


