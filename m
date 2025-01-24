Return-Path: <linux-fsdevel+bounces-40027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1713A1B1D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 09:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62786188E91D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5F219A70;
	Fri, 24 Jan 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1ccWZgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA4166F32;
	Fri, 24 Jan 2025 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737708147; cv=fail; b=jHkuD1hH2rDXi4d5WDVkTZ2GPsZlvUNPOJdQswfmjx2L0GPm883+HU5bthocoEoeFQnGN/+ktbDPyWSXF1Rnxn78Sdwxve4korWbRiVod4ZCSyLKb9IQuZRsf6cCdgVK1MN/hUM9uxNLBC7prnoM/uRm2mwWEYGp2oJERqaiEOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737708147; c=relaxed/simple;
	bh=7uyGDirjhftg+in1uL1tS+zmqz4YgQ+s9MeT5bShnOM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=mVuZzpcDgGRmZDyk/rYWGd8v+ct6YDyHGcQBGYbRYuX9dlA6DPVRoUEpoy0y9E6eJa8booR7sAmld7eaq8vR7dQ85HwkOhv2TekNQzNCReNoj8VP0i0GxLEBUcTwbQ+U16pp+8bn8KINexKsKN4UiKK5j64DdRI4y5te+Uz78lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1ccWZgO; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737708145; x=1769244145;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=7uyGDirjhftg+in1uL1tS+zmqz4YgQ+s9MeT5bShnOM=;
  b=T1ccWZgOde2CtUqRPN9noN4d5L97aQ1Hbu8+mO+y6aCnHS6r6jKMJH1/
   4FnDffqrPBP5aHA05spIwjj481w7mvKtdPx9q8zA6PmwAp0whdJQOkaSt
   AApvXyXdElLdmbPGAtRCWE+EjD871eyUD0IqYZc2/N2bJftPsco9n0SsJ
   L+oK+kUq+m40KvPAch1/6xVJx5SQHuLDibQxaZ1OjBRsLOFkaVlnXAMAE
   lanzp2xCl+RDll7n39NNhScENycOdu9iRuHkxh6f34dZMwHMSGz01nVJJ
   9puqgUig0WrvC0VVo+1MiApEWeVFgR9UoVLu0hf/J+AG2/y3JXKrcXCMq
   w==;
X-CSE-ConnectionGUID: 6dy+WBC/QiSjcQsssNnl0g==
X-CSE-MsgGUID: IGC2BNQ8TjuCgWkYMhnyDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38402281"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="38402281"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 00:42:24 -0800
X-CSE-ConnectionGUID: XqOEhNP3Q7aN5W2ArT3GpQ==
X-CSE-MsgGUID: jWyDtFxrSfShLzItJ2z4UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112669864"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 00:42:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 00:42:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 00:42:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 00:42:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8mDZ8gm+Wbs/nZ7D9D9LwRgW+o4i641JjvE2bazkJ48nrnKX7C5tTgQIH5anFfNOKJqxLH1ekT8tRYhEAqkEYojEMhOEMHykBke7hEv1ptRq399wUtOls4AGJq4UDyy88+IQJQiG47yNiLqeoph1GRYerWxxUGRSaMDKyiOFuL5EUo9TIP3bcDAITx1SdFI8e3CYKrf7ZE4erjSqLW98wyR/UzTecOaAOjRonyVQPMZ7Vb4TqLT++/nofBJCHIThY4a6dSN1GZ5Q3SmhnwWm3QrdpeM1OL6AyoAxWR0/FH6P76I7oQhtTGSqTluko2QvQ/t0XhYrjdwnpAg0aE87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euovGw2stj2F3ih3khBdwAx/Z8q5rPsmXUKpJGRSmb0=;
 b=ht0MEkjUuTsiVApWCR5OUKTL4SorfnF+ohb0RdkR4dRuDgIGvAFzVU7uU+tGGYQfxmBI2zMAiqziTnNOp2mvwoB9NCw8TD/mlz4RCx6nU7zYk5QUJ1hMBZwPJJW2xdtYPhLHZ/6YbK5RJQ124CT0z29nBjMF+4sgG9t8caqqjGjhqFKt+44pHf3MBOti1zM3qfzOoakx6lJR2yYx9SfC5VpXPmFLgDsRGIgsKC3Nb2AsPKC/Ikl0MUF5EgZnLmAIjBLLTwkGIUQnTSwpT2iwDHeKsRVUwjQio6O5RJDA1jL8uGnWdlGd09KhjYo3GC85JjG8xBNw6pQRtLPneftvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8276.namprd11.prod.outlook.com (2603:10b6:510:1af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 08:41:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 08:41:36 +0000
Date: Fri, 24 Jan 2025 16:41:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [close_files()]  1fa4ffd8e6:
 stress-ng.fd-fork.ops_per_sec 6.2% improvement
Message-ID: <202501241646.81b10e21-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: fc434d16-c875-41c9-749b-08dd3c52e9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?EtkP+ayNKHJ8OZTZ3D5+mTKs/M5azUW6x5IxwzyHVifaH4Gbk2aRe8st/j?=
 =?iso-8859-1?Q?uf4OEJ7u+un/LRhav/aQGOpo954JGQNcOshYf035lDHjCwP4gO/DIFlER6?=
 =?iso-8859-1?Q?QgJOCl12GVzXRju2b/EEzAUQ6e8goQ5sjFsM+XZJKN3hDLN7IYFSdSN//7?=
 =?iso-8859-1?Q?lP1ns5CS++MBI5oti0eCpL2/nJIPQK3qpf9O/m5CBZktRNyyZySa0dnf8g?=
 =?iso-8859-1?Q?bsnPZfdsyF+GxftPaTawLCHJaT5jol8g0MjeUpx0N8XvxWyjKYITn0HjIv?=
 =?iso-8859-1?Q?PIGqRkjGN7lpf0cs57HBdSTw5zT9WUfR/qrkp7msQkhYpYN9/Ky9tv7mb8?=
 =?iso-8859-1?Q?EGZRvuKp9gIA6aV5qQUJdnMQzBgtTo+jjiPWZzmG4x6PMB8IhULMr0x6rN?=
 =?iso-8859-1?Q?Fqnm3ThKebcyARoC54hedrR6fNkFpQxIw8Qf+Uj0Ez1CH25uhA+BLMDKBu?=
 =?iso-8859-1?Q?F6bpCZhNFkkmT+fwG++56dJxvCc60XyRjwzNlp5CDZF2vf+EJuwPKAyuoU?=
 =?iso-8859-1?Q?uO6la7PgXoLGb1PdbjEtl32SIJ2urmqBNH+w/pgV84f6gMEzUYfmfJQ1nR?=
 =?iso-8859-1?Q?GXMedZASwSiuo+xvxaK0q6ZcUgC2ibNL2HOoABYq52lF6zD8ACGbfnEZRC?=
 =?iso-8859-1?Q?86gvBTAMGq3NPnFaUBzCBDMfHsQ28fgYRzhnulqUOPQaoFdqILXtKSTYXV?=
 =?iso-8859-1?Q?UT6hJumKbuEimyI8Wo36VXMuo7krW/WFHw0aDpOxIUKPw32RxukA+b6Fvw?=
 =?iso-8859-1?Q?Fzti/ARYtZhCcGdBQeXJ3ZQ2ev3An5QhrfkEMZkNHsifQ4QuMZCt2uPFla?=
 =?iso-8859-1?Q?TTP6G2KEB1rYimm2Y8lkwyoLzo7Pg3neKxQjloYJBEq5klt37aWT28gplz?=
 =?iso-8859-1?Q?FAMBEuUGrFYBqahy9XwIKF7uh7gv6EsQgEImO/DOiIfmdwmkqHGsD9lB2P?=
 =?iso-8859-1?Q?0biBqTsPbvo8ouQ9sZI9ixfyHKAagaDc/EzoU78EbnPJLRpNKveU3f643a?=
 =?iso-8859-1?Q?CjxGfHALidIuTnNrPdZ9dzTlPSj+ZfxqFRSu40ASDaYd5+9rhjC83tZWxY?=
 =?iso-8859-1?Q?NA7zvFIsAHjGTiBdU0KaSZIVi2SEEjsiyL4uneiLesrhmobhWe0zKK7uBB?=
 =?iso-8859-1?Q?LoJigWBQ407lImQtMTUE4Lz4irx8pPs4XziPtf1Eb0UCkNeZOinr3q32sx?=
 =?iso-8859-1?Q?YUl5zpWPyM8HPe7TOHXY1xcmkwpdxWGvKyO+k73y2b7eh8JBcwp4b6v3QO?=
 =?iso-8859-1?Q?s2Om66D6G44tPJRrUffC2usnj6CnXHKMaD23jrAQWTulVrXsagYQlipLB7?=
 =?iso-8859-1?Q?Aax1UGFUk7ATDXSW22X/C0W6X9g49aU47qepRmPBz2FIaybyb/pZ2qf4oC?=
 =?iso-8859-1?Q?ZDzMjxqDA0lrYxZj/gpx0TEpTzyr+V3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?h2ko5Te9A/ZBiDz3PlvY1RG9UpjxS+9rptY97MdZu3fcjCFPfzReaXfCj+?=
 =?iso-8859-1?Q?Jo5Rmit/Pnz16bB9DQO875H0R/a5l1rNsvhbgOQGD+dY1tbSu3uBbgF74Q?=
 =?iso-8859-1?Q?3SDG3VL3ZyjG4Ho1Re9vFyEPNiFWZ/6aZKBST+JhmALYpWCzstf49G5Mos?=
 =?iso-8859-1?Q?N68KyTipTKoCZleIeHtHyEnA+6E0jGiT81f4Koc6OSJ5FgObu14i3YAt5a?=
 =?iso-8859-1?Q?YH7+JPzI+5nNoTN8w7rvnFLpCReJrsMtLi+MEjB3611BMWvdLNom/yakxf?=
 =?iso-8859-1?Q?dKMRyo2kPfnQNwgxEPlWgvHToRz9pdl96JSqG7ZrDSwAGy+/gh/sjMiRbH?=
 =?iso-8859-1?Q?jcGwRh3MAYR+8jTprw/lIYjm9/sXTKMS2BI72ygVoBw2vPGLM60JHyJeD2?=
 =?iso-8859-1?Q?Y71EMap6a+xO1igUVz/qwCYQZlCBynK+MkU/86p08vQSbjoOtS9eiGQf/R?=
 =?iso-8859-1?Q?O6/GGV+9UWEN4z//YYI3kXriHjsWZEv4AwSaoFZFzH4B+vdQ8zQmMEAAqW?=
 =?iso-8859-1?Q?/8KyY0Yg8mceRGBJcQV4gwsnY7gmbE24zEo5ITnn4tBDfbzLZgtFhpp8ae?=
 =?iso-8859-1?Q?fxu6EpuskPyWZzej0GHzBxmN2Vv9zMCVG8FSVY6kLzgKSJ+lb8q3D/YV9a?=
 =?iso-8859-1?Q?qxDDE0Xl0UNkczOEwGyhzKYLvxIG74BSA011KRgaz51kbeV6Z7cBuYhSiX?=
 =?iso-8859-1?Q?dF+Cvb5wRdx8Llv6O+zVR7jNp7IxPf5CbrHMFm8SPKpEK5xtT3fHgxwwUl?=
 =?iso-8859-1?Q?LZCA1+RAXtqm6v1LQmmOlbbGZfPFzIVRujOpnpA73W6zyB1PI6YBJ7BQif?=
 =?iso-8859-1?Q?d+ooxeve0xBzRqFPgxuws7U4obMQtWyedAgeGcCc72YH4a6+jUmF0G+MVD?=
 =?iso-8859-1?Q?dKgFvaN8ilCZLlB0YiZGyFACvl2z7RYEbvJrZGF3V9La+C6pH/te4PqX8y?=
 =?iso-8859-1?Q?lrwW+EseTsiYIYB4KGSeosyQIEq5tTCWCvBucl4FcX+4qn6Ga6bnwAiKrn?=
 =?iso-8859-1?Q?kdQE6Tlbz3VPDD20BC5HN2qm7XezCEfwxk0SC7LwEz/vXGalOIzE1aGQ6y?=
 =?iso-8859-1?Q?vBPTkMhXncT1ywfe4YHeRYPH1l/ptlnYruw2dZ2bBPIPzkvgISorxOIvoM?=
 =?iso-8859-1?Q?xsIvyFfY4s8fGCuDjK4epg7L2zAJcEin9zJ4MJgnlsmap3Dgv6wscjQGsD?=
 =?iso-8859-1?Q?Q0P+7ya3yPa7MCYQ1AkLSs7Fs8tmohiLTp0ZNAnJyH5ThdF+EI0aheS98U?=
 =?iso-8859-1?Q?RL8VAqhshldNySJv+OY0X3R/NITyODNjJ/2jgjeLPy56zZmc19ipEHZoio?=
 =?iso-8859-1?Q?TqXhO07jB5prR9B7fi9JD4C5nPQaatp9aMHfJI8/sx680ObXOeQaE8azCQ?=
 =?iso-8859-1?Q?8BFPH4r0XPS0ljeut69JJdS2Ss94VCCjr2w3T55qqQdSHSoud9tOnXi2Hm?=
 =?iso-8859-1?Q?jkyqAZvWydYwJiPFUPV9RG90eTYliRkJ1M2AUjrEdY8qlcsSLEoTHh9ZQu?=
 =?iso-8859-1?Q?MtdwSabXlKSrMGBSdYj16SqHvkKMcRS0vJ0LTHNqBC5135tBzUUCw1sXVT?=
 =?iso-8859-1?Q?reZmR1dMTYs1uWNngovvwYnoh46rgXzFwRxDQau1bQHvifr4QbWnBSKhJu?=
 =?iso-8859-1?Q?hGPlmAQISgWPZDg66mOb9PBilIgyexUC58?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc434d16-c875-41c9-749b-08dd3c52e9fd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 08:41:36.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzEfopknusPzsOAHFf3ngndHix6w0mDudvh+aZzHcZ53s49pigSZRKQ4UeittIPAbrrhLkBEMx87RyX4jrOGig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8276
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.2% improvement of stress-ng.fd-fork.ops_per_sec on:


commit: 1fa4ffd8e6f6d001da27f00382af79bad0336091 ("close_files(): don't bother with xchg()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: fd-fork
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250124/202501241646.81b10e21-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fd-fork/stress-ng/60s

commit: 
  be5498cac2 ("remove pointless includes of <linux/fdtable.h>")
  1fa4ffd8e6 ("close_files(): don't bother with xchg()")

be5498cac2ddb112 1fa4ffd8e6f6d001da27f00382a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     38705 ±  5%     +11.1%      42989 ±  2%  sched_debug.cpu.curr->pid.avg
     96837            +6.2%     102865        stress-ng.fd-fork.ops
      1611            +6.2%       1711        stress-ng.fd-fork.ops_per_sec
     10.10            -6.7%       9.42        stress-ng.fd-fork.seconds_to_open_all_file_descriptors
    131663            +5.2%     138573        stress-ng.time.voluntary_context_switches
   4224262 ±  3%      +5.5%    4458103        proc-vmstat.numa_hit
   4158770 ±  3%      +5.6%    4391868 ±  2%  proc-vmstat.numa_local
 1.002e+08            +6.8%   1.07e+08        proc-vmstat.pgalloc_normal
 1.001e+08            +6.8%  1.069e+08        proc-vmstat.pgfree
    200571           +14.3%     229179 ± 16%  proc-vmstat.pgreuse
      1.24 ± 15%     +39.0%       1.72 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      2.36 ± 21%     -31.4%       1.62 ± 32%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.40 ± 17%     -34.7%       0.92 ± 30%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      8.65 ± 31%     +64.9%      14.26 ± 55%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.30 ± 70%     -70.6%       2.14 ± 97%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
    227.50 ±  2%     +13.1%     257.36 ± 13%  perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.35 ±  6%     -13.4%       6.36 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     22270 ±  4%     +51.5%      33741        perf-sched.wait_and_delay.count.__cond_resched.__close_range.__x64_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
     55845 ±  2%     -22.5%      43303        perf-sched.wait_and_delay.count.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      1051 ±  2%      +8.6%       1141 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    226.27 ±  2%     +13.2%     256.09 ± 13%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      4.72 ± 23%     +69.3%       7.99 ± 27%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
 2.431e+10            +7.6%  2.617e+10        perf-stat.i.branch-instructions
     12.91            +0.7       13.61        perf-stat.i.cache-miss-rate%
 1.033e+08            +9.5%  1.132e+08        perf-stat.i.cache-misses
  8.11e+08 ±  2%      +3.4%  8.387e+08        perf-stat.i.cache-references
      1.98            -6.4%       1.85        perf-stat.i.cpi
      2168            -8.0%       1993        perf-stat.i.cycles-between-cache-misses
 1.128e+11            +7.3%   1.21e+11        perf-stat.i.instructions
      0.51            +6.7%       0.54        perf-stat.i.ipc
     65995 ±  2%      +6.6%      70332 ±  3%  perf-stat.i.minor-faults
     65995 ±  2%      +6.6%      70332 ±  3%  perf-stat.i.page-faults
      0.91            +2.1%       0.93        perf-stat.overall.MPKI
     12.73            +0.7       13.48        perf-stat.overall.cache-miss-rate%
      1.99            -6.5%       1.86        perf-stat.overall.cpi
      2179            -8.4%       1996        perf-stat.overall.cycles-between-cache-misses
      0.50            +7.0%       0.54        perf-stat.overall.ipc
 2.391e+10            +7.6%  2.574e+10        perf-stat.ps.branch-instructions
 1.015e+08            +9.5%  1.111e+08        perf-stat.ps.cache-misses
 7.975e+08            +3.4%  8.247e+08        perf-stat.ps.cache-references
  1.11e+11            +7.3%  1.191e+11        perf-stat.ps.instructions
     64224 ±  2%      +6.7%      68500 ±  3%  perf-stat.ps.minor-faults
     64224 ±  2%      +6.7%      68501 ±  3%  perf-stat.ps.page-faults
  6.87e+12            +7.4%  7.379e+12        perf-stat.total.instructions
     29.66 ±  2%      -1.3       28.36 ±  2%  perf-profile.calltrace.cycles-pp.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     30.58 ±  2%      -1.2       29.42        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.58 ±  2%      -1.2       29.42        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
     30.58 ±  2%      -1.2       29.42        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.58 ±  2%      -1.2       29.42        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.58 ±  2%      -1.2       29.43        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.58 ±  2%      -1.2       29.43        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.53            +0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      0.54            +0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.54            +0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.78            +0.1        0.87 ±  2%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.76            +0.1        0.84 ±  2%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.34 ± 70%      +0.3        0.65        perf-profile.calltrace.cycles-pp.rcu_all_qs.__cond_resched.put_files_struct.do_exit.do_group_exit
      1.18 ±  3%      +0.4        1.56        perf-profile.calltrace.cycles-pp.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     21.65            +0.8       22.48        perf-profile.calltrace.cycles-pp.dup_fd.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     22.48            +0.9       23.40        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.50            +0.9       23.43        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     22.50            +0.9       23.43        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
     22.50            +0.9       23.42        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     22.50            +0.9       23.42        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     22.52            +0.9       23.45        perf-profile.calltrace.cycles-pp._Fork
      1.47 ±  4%      +1.0        2.49        perf-profile.calltrace.cycles-pp.dnotify_flush.filp_flush.filp_close.put_files_struct.do_exit
      2.19 ±  4%      +1.2        3.38 ±  2%  perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_flush.filp_close.put_files_struct.do_exit
      9.47 ±  2%      +2.7       12.14 ±  2%  perf-profile.calltrace.cycles-pp.fput.filp_close.put_files_struct.do_exit.do_group_exit
     22.10 ±  2%      +3.5       25.60 ±  2%  perf-profile.calltrace.cycles-pp.filp_close.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     30.02 ±  2%      -1.2       28.79        perf-profile.children.cycles-pp.put_files_struct
     30.60 ±  2%      -1.2       29.44        perf-profile.children.cycles-pp.do_exit
     30.60 ±  2%      -1.2       29.44        perf-profile.children.cycles-pp.__x64_sys_exit_group
     30.60 ±  2%      -1.2       29.44        perf-profile.children.cycles-pp.do_group_exit
     30.60 ±  2%      -1.2       29.44        perf-profile.children.cycles-pp.x64_sys_call
      0.09            +0.0        0.10        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.11 ±  3%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.down_write
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
      0.15 ±  3%      +0.0        0.16        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.14 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.16            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.16            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.exc_page_fault
      0.25            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      0.24 ±  2%      +0.0        0.27        perf-profile.children.cycles-pp.free_pgtables
      0.31            +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      0.13 ±  5%      +0.0        0.16 ±  8%  perf-profile.children.cycles-pp.copy_p4d_range
      0.54            +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.__mmput
      0.54            +0.1        0.61 ±  3%  perf-profile.children.cycles-pp.exit_mm
      0.53            +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.exit_mmap
      0.78            +0.1        0.87 ±  2%  perf-profile.children.cycles-pp.dup_mm
      0.76            +0.1        0.85 ±  2%  perf-profile.children.cycles-pp.dup_mmap
      1.53            +0.2        1.75        perf-profile.children.cycles-pp.rcu_all_qs
      3.50            +0.5        4.03        perf-profile.children.cycles-pp.__cond_resched
     21.65            +0.8       22.48        perf-profile.children.cycles-pp.dup_fd
     22.48            +0.9       23.40        perf-profile.children.cycles-pp.copy_process
     22.50            +0.9       23.42        perf-profile.children.cycles-pp.kernel_clone
     22.50            +0.9       23.42        perf-profile.children.cycles-pp.__do_sys_clone
     22.53            +0.9       23.46        perf-profile.children.cycles-pp._Fork
     33.30            +0.9       34.24        perf-profile.children.cycles-pp.filp_flush
      3.75            +1.0        4.78        perf-profile.children.cycles-pp.dnotify_flush
      5.04            +1.2        6.22        perf-profile.children.cycles-pp.locks_remove_posix
     21.42            +2.6       24.05        perf-profile.children.cycles-pp.fput
     56.02            +3.7       59.71        perf-profile.children.cycles-pp.filp_close
      6.16 ±  2%      -5.2        0.91        perf-profile.self.cycles-pp.put_files_struct
     24.86            -1.2       23.65        perf-profile.self.cycles-pp.filp_flush
      1.14            +0.2        1.31        perf-profile.self.cycles-pp.rcu_all_qs
      1.76            +0.2        1.94        perf-profile.self.cycles-pp.filp_close
      1.91            +0.3        2.20        perf-profile.self.cycles-pp.__cond_resched
     21.51            +0.8       22.34        perf-profile.self.cycles-pp.dup_fd
      3.30            +1.0        4.26        perf-profile.self.cycles-pp.dnotify_flush
      4.58            +1.1        5.72        perf-profile.self.cycles-pp.locks_remove_posix
     20.87            +2.6       23.46        perf-profile.self.cycles-pp.fput




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


