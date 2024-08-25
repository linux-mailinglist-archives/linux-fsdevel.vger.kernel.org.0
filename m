Return-Path: <linux-fsdevel+bounces-27060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FAA95E2C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 10:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05DA1C20DE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 08:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C8A3A1DB;
	Sun, 25 Aug 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXM8l+ok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053F537F5
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Aug 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724575628; cv=fail; b=Nm2H8B/mcOr27Ti5SGgAExNRQD3eHctG+NHvGgA8FtYNeI9O51Rbiep2WL2VIvTNbogwKHqzW6ck0Ua11oYUxObdXj8OSIzDTZiDfprXCTERQ3ydf1B/Q+d1ocWQTdT7iEbIV3S6dguqghg5V19cZmatHLKYElk/RVgKr/0UzME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724575628; c=relaxed/simple;
	bh=QKk0aS5xNCh0qJns6hI5IglKBIC/yZ+lHFvPhYpbEog=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=q/JubcuiSsX/yqt8bjr/J6FkTsOAybOAyiyFbl+n19SohK/yYwNaIyCPfwsC5GyFSSO0CWbUV4SEQGqDxG+NF/xztfmn0b3MGhO7sW6GNch5ZN6j+mC9sfC1p0DRDDYeBrOifH5FXveHlzL55tUVR7vQCRJBCW0CYg86puYDnKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXM8l+ok; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724575627; x=1756111627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QKk0aS5xNCh0qJns6hI5IglKBIC/yZ+lHFvPhYpbEog=;
  b=QXM8l+okluPiUYeOq9XmMYPNb087fO0NOijpkhzmE42yk32Y3u8ABX5A
   I80ZegK18gbbDn7Xdf3QztBeaq8K6W+ligknqgb2C2q329LxIYC1ZHvGk
   ZR2Lps080I/O8rRnK/t1KZIvxcqTKPOjil0jg5USu32tOhYT9YIxsCn/I
   gIg4G6wNTwSBuTVGmvHqxINJ5kvgcIdYQxswU8OGugV79+VHlhq/U5cWT
   jK+w2az9EF+HrXTEXOC/sPOwJLvlSFgBTxOGzHRQjWEwKahQL+7lBSiEp
   LqfiACB/dZASw86xWfTbv7CDnxT0bEVlLRjSXvSR8NjKNhXJuhTuyctMU
   Q==;
X-CSE-ConnectionGUID: x+BUmYi2Sw+V1WEvehGfMA==
X-CSE-MsgGUID: QS9LxjCnSWuMgoc/K2MjUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="40516125"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="40516125"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 01:47:06 -0700
X-CSE-ConnectionGUID: FBnzmlOLRk+ve0TpIh2S8Q==
X-CSE-MsgGUID: OXyDG3r9SP+OJnUx1zJfMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62534063"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Aug 2024 01:47:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 01:47:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 01:47:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 01:47:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 01:47:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZcCaJYUq5IU4KEIkpJTsecpjmVjPstarMcKu0dJjh8E+abtrdEWZZoeDAXfIZqNLoYtAe31B9bL+QCFvBmuGwW+WX5Xl4xjTFNRUR0QATSXJYDtxkijzEuaRa5I2/Xbne7dLmVHva+98wnbrPsuXUw8BPgsK0PcFalJ1hUZhY49HTxaO+5sFQLQnjc0lB/6/6yEUfmPg6ai/+JgPJ4BOswCDuMOqNhf4A5WXNUCQcc1iCd1XCsermYJ6fc8/SckMYnowZJ9gp/Mvd2SBNZHj0RL5DGAf4mJ70ezVZCfTQp14kqcRve8UAmuV1AVBgr6wm5fjaWGEoJgsssT/ctLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhbV54vp5HWoJmmDpkU07Hu3rqzTOpKqTHdr0MjkhIQ=;
 b=u98a4/VwRt0FTrYGnVGHt7SKBZjqr3xbVHXqaknXaOa/boNZ/bxsq6kzbOIQsVOTSrdf+LHsrcyXBsg9+ECegeejYWnQZaVdlunPsBTT40cL59s08pjhyc+mvRXxLLsiRnsJpx+M0NECI8GK1tnpFGb7wGLuBh1p9LvRSN5BHtgsbg7Z7Sk5X/7RwkskY0hEMw1Jyj637YLjPT+KwkDt2FF6kxi5aBMQ+g1TviED/j5YDPFVDAylz/AWKlAioZTNGGujMtSUqI+/H9sF0v3A/f+HA5CqVa6FR08ibU3AqKQSo13hwJn4pTPbIO92w5yI99tlhP+fCcItVNur07h58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7063.namprd11.prod.outlook.com (2603:10b6:806:2b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sun, 25 Aug
 2024 08:47:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.021; Sun, 25 Aug 2024
 08:47:02 +0000
Date: Sun, 25 Aug 2024 16:46:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Dave Jones
	<davej@codemonkey.org.uk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev] [mm/filemap]  199735cdc2:
 BUG:sleeping_function_called_from_invalid_context_at_mm/filemap.c
Message-ID: <202408251605.df83b338-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ff9158-98c6-4e04-0e20-08dcc4e27d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r86KYtk6xMrc/0XjTNw8ES3INKGlpnGUKE1gKF5k/5uSmDs1UT7Lm7jFbBRA?=
 =?us-ascii?Q?WW0Lq1Yyq4r47PT6A5jJtef5LDVOGjDCHlbh8fTkfEHXJavPY3lJ1RIHl8a4?=
 =?us-ascii?Q?lUGBxiFD95BiWKMryO5TdOGSDeypgDgvE+LYdrOmT+x/m3jwn/wgBjbV33gx?=
 =?us-ascii?Q?kkciFA58oh26dQz393Jq72E1mjh6U66ip0MmYb7PttMNdURMvpG+Lfo8s2Ee?=
 =?us-ascii?Q?sbvKSwHk56HMfeMxzFM/XSSAGrRxoojOTj/XKfhyhX5g2SQ9lZIHJ/Oep1OZ?=
 =?us-ascii?Q?KLlM5pZi3QmEGqiiIiyyINqsVUSGKerDjNveUtzL21HsmZsmN1xtA1DUUDY1?=
 =?us-ascii?Q?tCr8vfVURCw9CA+z5hOpaHZxBs3Ij0BPJAGRk+//mtTO73dsmTBIFKwMh3ns?=
 =?us-ascii?Q?9ZHKFu9Xlo49CVCAbKY4ffwvZn2lu8c6bhjzoz+wCMAvzDINMaDmi7YREbwN?=
 =?us-ascii?Q?stMRmvZXksCDwuTII3eOrlv6kcd38f9SkEqMGsYTqrGC0GeZJXhcj+DQoBC3?=
 =?us-ascii?Q?sFeP3mPdsEWEtdP1C6HgXBjwwtndKsBBK/YU2neBDi55ryxbC5fBasF+bG5+?=
 =?us-ascii?Q?RolVbBZ0Jf0xsd51KerJ3A6ZcKXBfeDuMpXqi+4WSr/ahUu/O4estOG7kpeT?=
 =?us-ascii?Q?gh2Wt1FQ4ci7mC1VgGBV3LVNCl1hkmLImI09dbAwggsDZIhX3ZAQLSDsje4N?=
 =?us-ascii?Q?Ys2zcc/F7S1mIOnPG+doPyQOaR2reztw/mutFKofVRvHP1ixNfSjeAKLSHi+?=
 =?us-ascii?Q?4tzlVrlFEPhySa8ZCRvzh2PxIpxAF5C1Gh60VfLo+MY1uafMn4ulrQtEdTvZ?=
 =?us-ascii?Q?+sb8QfLK7cmy+g1Td33evbbSpwH4eUMA5LdYNQt5aHALyRvEcvT5FfLmXjxF?=
 =?us-ascii?Q?UjMsm4nu+jdLAn7OdaECP6kCqpFic0c4vNbrIkRqhRLqMoFZMl2UzA7ZaYFC?=
 =?us-ascii?Q?ePv99pegEutVf8C2r/PlmiJ9mNIFucq+fhhOE70c1ra6UBOSkFp6eFQVUWFt?=
 =?us-ascii?Q?cZUmk3yKoN4gMaaD/ew4SMYNMY4Iofv2zO+KLIdbJRYZA1xcQjWfW7eAWB0M?=
 =?us-ascii?Q?ml+76CTlZlzzQSrIS8JS9rohH65kn++3ecbqrm1A65J3n3L0yJJ5OU5Z9x0u?=
 =?us-ascii?Q?k/wf+2+Zafs/fJrAaRpjZ6M7gEIKbf7ooFBajtZmIsVGjHX2oObe9oI0P1Hv?=
 =?us-ascii?Q?p6smVVB7EqDfGdTeqk2qNbM1E+6Q0RoR8N2OhgcU8TxKHpJPH9KeTBQtZxfs?=
 =?us-ascii?Q?rNEVLEP6Exqtk1l7cOmJZNyamb8puMVg/g1gK0pkYamPDs/Xu9a2bhbb8hAy?=
 =?us-ascii?Q?ZMnR7T4XvYrfHEHZa5Y8OHeN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mTYX9etjQvqumxPMq0hdhGj1ZDr40QnmpX+MeNU66ypEBSq3HUECBSz8c1Vw?=
 =?us-ascii?Q?zjYq3HEiJHSEJxB7GQ7+eKqBNfynA9KUYbSvz6V8npbuVVMF6l91SaH4Pseu?=
 =?us-ascii?Q?7yfJpSlhO3+q0MefXZURDRU0IZavBQdCVNypsh3gEFC/k547oMr6zC50nm61?=
 =?us-ascii?Q?XRBmYqDsd4sIVKAO18GXtoWVliJDbtuSuV/gEEKxXMOjZe8kERdYqZ0kcaGH?=
 =?us-ascii?Q?X6apOXJV09UtsakpYFfZIEKQaXH79/904UbMDx7uTSvAa7Tji5aKlwgBAvGJ?=
 =?us-ascii?Q?+lLA8l7WzS44l17D98F3q5+++H6/4+lKwqBeCJAKl1j3c0bmb4Nt/l1y9KoL?=
 =?us-ascii?Q?D+t/JR3+qIDAGKjWdmvDNiYbCV3LQUDu26A4vRHouu7yYpHK7hN3vcXXqBO8?=
 =?us-ascii?Q?j3RHAxMf5rlFX66E69u4uUFoYAB8gdcSHy8tUUSum1UtyxlMDcMdKf/d0y3w?=
 =?us-ascii?Q?GLmIyqk+hGQwgTFbhM04i1bX71ppJZYIB/K7tY67aMSqKbVYAXjrMuP/JSJi?=
 =?us-ascii?Q?/gLLPBnrQZ+HPy1Raoz66h8S3jz9+8RVFiAR2ZeIvzs37qc7+4ieDlC/xVyQ?=
 =?us-ascii?Q?Byeko87yDqg0HoIZ0Eo3de3QSeJMaB/o9WYzeUJxnZEbKIfnN0JlXijr+e+H?=
 =?us-ascii?Q?0QAH3atvkgAHcT4QT4Ttg8LOlt3OADtynnwsBfhym9U6wRgmt23860h7s6qP?=
 =?us-ascii?Q?b2MO5ySt3c6uUP+bM4mR5IwjpSXiekCnxVvab0rq6YVjUEWUNH5sXHUEeUwA?=
 =?us-ascii?Q?Q4g5YOTPk0yXz4w+k3i6a3RVuaYNtsvnz/VKvMT3QdJeE2BRUJrHvnVPkE8M?=
 =?us-ascii?Q?CSno901XYbNu1x0aqSnk5HfMoF5k+CkbnNsM5Gp/DAJUcHUuEV4nw1gd+leX?=
 =?us-ascii?Q?tzfHCJeOWjjfERkmjh3L4pfv06MNpCOsba+cnHnEESK7YLlFHQACOn+D9Yn8?=
 =?us-ascii?Q?t12xjzI3w0wX1H46WyzamZsT/FFn1WnnJkmqTpT6KfEPTUd9pjsOufO0LHTQ?=
 =?us-ascii?Q?Z22iilUdSWsi4hT1WmvuJDCL+6R+6pV+KoBsgkfxHr8Xgum/Fy19rNh+NN+W?=
 =?us-ascii?Q?S3h0eJ68CHBqiRBkYJx5tYCYaFr2QVSzxGS56cJ7ZYrAZ0O5awU8joZGA9dr?=
 =?us-ascii?Q?DMJ7RjBixDJ9VWP6LklERtntfoxhjmnDlx7T/YKXWHvfdBfUI/EwaUGzc6os?=
 =?us-ascii?Q?z9SkM0KFqiC4grISWk/hvN58PiW8YNFgqncU01ijHHXOy/6IgIHAaAcE4/PM?=
 =?us-ascii?Q?kDn6eQCAam9mOjJqg2/3jJOZ+33PspHpcN6kcPa+F0GDIsjh8sazyocKeE2h?=
 =?us-ascii?Q?5gVB0ErEf5cGCxoxIPlPOESBSt+DjruqLeuosBtMOjxQwV8SSu/s7MaNCs6E?=
 =?us-ascii?Q?EC0E99SzZnHDJvL+vDM7JSgCQKge3a4qjQPHGbaPOHPj2yitWtqwREzzuTr4?=
 =?us-ascii?Q?AWPI6KfFHy3RSTLjlTCYbPI+XULOYxAFWZsYlX1QyIUc92uBMpNE1wfWqFN7?=
 =?us-ascii?Q?uPXgIMkGSG1vQuAJ+p0I11nJ/YI9+97f8jbj+llThV6h2mw4ModyZoDX1itj?=
 =?us-ascii?Q?JO+X9O8GuhN3mLpKvUcmlr4icNrWqu6jZoKUrEdNezCuGwzavRrhJ2hETJUn?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ff9158-98c6-4e04-0e20-08dcc4e27d3f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 08:47:02.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRPjRbBBHSTkdgdRsPKWHX2X6nJoA0MhZc17M9wbRjagltlXee4NzSBD3d/HeSm+/4CnYSwOodI2pXHB/SkHNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/filemap.c" on:

commit: 199735cdc2b09f27ee095b39d1a67ea6888d2dc8 ("mm/filemap: Add cond_resched() to find_get_entry() retry loop")
https://github.com/paulmckrcu/linux dev

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------+------------+------------+
|                                                                   | cf6115748c | 199735cdc2 |
+-------------------------------------------------------------------+------------+------------+
| boot_successes                                                    | 18         | 0          |
| boot_failures                                                     | 0          | 18         |
| BUG:sleeping_function_called_from_invalid_context_at_mm/filemap.c | 0          | 18         |
+-------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408251605.df83b338-lkp@intel.com


[    8.441495][   T10] BUG: sleeping function called from invalid context at mm/filemap.c:1989
[    8.442309][   T10] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 10, name: kworker/u4:0
[    8.443047][   T10] preempt_count: 0, expected: 0
[    8.443427][   T10] RCU nest depth: 1, expected: 0
[    8.443813][   T10] 4 locks held by kworker/u4:0/10:
[ 8.444214][ T10] #0: ffff888100a76d50 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3206) 
[ 8.445025][ T10] #1: ffff888101e7be48 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3207) 
[ 8.446045][ T10] #2: ffff888100e71430 (sb_writers#2){.+.+}-{0:0}, at: do_unlinkat (fs/namei.c:4470) 
[ 8.446763][ T10] #3: ffffffff833f0d00 (rcu_read_lock){....}-{1:2}, at: find_lock_entries (include/linux/rcupdate.h:337 include/linux/rcupdate.h:849 mm/filemap.c:2091) 
[    8.447523][   T10] CPU: 0 UID: 0 PID: 10 Comm: kworker/u4:0 Not tainted 6.11.0-rc1-00121-g199735cdc2b0 #1 ada3dbbd8db49aa7f6dc3bbe9d2d7b34f1d68c93
[    8.448151][   T10] Workqueue: async async_run_entry_fn
[    8.448151][   T10] Call Trace:
[    8.448151][   T10]  <TASK>
[ 8.448151][ T10] dump_stack_lvl (lib/dump_stack.c:122 (discriminator 1)) 
[ 8.448151][ T10] __might_resched (kernel/sched/core.c:8439) 
[ 8.448151][ T10] find_lock_entries (include/linux/sched.h:2007 mm/filemap.c:1989 mm/filemap.c:2092) 
[ 8.448151][ T10] ? find_lock_entries (include/linux/rcupdate.h:337 include/linux/rcupdate.h:849 mm/filemap.c:2091) 
[ 8.448151][ T10] truncate_inode_pages_range (mm/truncate.c:338 (discriminator 1)) 
[ 8.448151][ T10] ? save_trace (kernel/locking/lockdep.c:585) 
[ 8.448151][ T10] ? add_lock_to_list (include/linux/rculist.h:79 include/linux/rculist.h:128 kernel/locking/lockdep.c:1431) 
[ 8.448151][ T10] ? check_prev_add (kernel/locking/lockdep.c:3213) 
[ 8.448151][ T10] ? validate_chain (kernel/locking/lockdep.c:156 kernel/locking/lockdep.c:185 kernel/locking/lockdep.c:3872) 
[    8.448151][   T10]  ? 0xffffffff81000000
[ 8.448151][ T10] ? truncate_inode_pages_final (include/linux/spinlock.h:401 mm/truncate.c:455) 
[ 8.448151][ T10] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 8.448151][ T10] ? mark_held_locks (kernel/locking/lockdep.c:4273) 
[ 8.448151][ T10] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422) 
[ 8.448151][ T10] evict (fs/inode.c:672) 
[ 8.448151][ T10] do_unlinkat (fs/namei.c:4493) 
[ 8.448151][ T10] clean_path (init/initramfs.c:341) 
[ 8.448151][ T10] do_symlink (init/initramfs.c:428) 
[ 8.448151][ T10] ? do_collect (init/initramfs.c:267) 
[ 8.448151][ T10] flush_buffer (init/initramfs.c:452 init/initramfs.c:464) 
[ 8.448151][ T10] ? bunzip2 (lib/decompress_inflate.c:37) 
[ 8.448151][ T10] ? do_name (init/initramfs.c:458) 
[ 8.448151][ T10] __gunzip+0x2b0/0x380 
[ 8.448151][ T10] unpack_to_rootfs (init/initramfs.c:522) 
[ 8.448151][ T10] ? initrd_load (init/initramfs.c:59) 
[ 8.448151][ T10] do_populate_rootfs (init/initramfs.c:706 (discriminator 1)) 
[ 8.448151][ T10] async_run_entry_fn (kernel/async.c:136) 
[ 8.448151][ T10] process_one_work (kernel/workqueue.c:3236) 
[ 8.448151][ T10] ? process_one_work (kernel/workqueue.c:3207) 
[ 8.448151][ T10] ? worker_thread (kernel/workqueue.c:3349) 
[ 8.448151][ T10] worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3390) 
[ 8.448151][ T10] ? rescuer_thread (kernel/workqueue.c:3339) 
[ 8.448151][ T10] kthread (kernel/kthread.c:389) 
[ 8.448151][ T10] ? kthread_park (kernel/kthread.c:342) 
[ 8.448151][ T10] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 8.448151][ T10] ? kthread_park (kernel/kthread.c:342) 
[ 8.448151][ T10] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
[    8.448151][   T10]  </TASK>
[    8.949844][   T10] Freeing initrd memory: 198316K



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240825/202408251605.df83b338-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


