Return-Path: <linux-fsdevel+bounces-55883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FE8B0F7E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA39AC2719
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B11F3FE2;
	Wed, 23 Jul 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2DGxb1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1481E47CC;
	Wed, 23 Jul 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287242; cv=fail; b=Pi3d4ZDykw6Gti/a/C6FnQ/4lKJkmX3wE3VLHa/kRipkBvb/Xnvz2Hmta43Wt2nON/hXKTzchvyi9xcQzE6xJwD0c4Y/MIBnTzdDgZf4znwFhr2vJX3hsUF9MNrg+CneV+yzSteHI0xkDtb4lXfGPajH5mxqoPz1zDnNk+4orRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287242; c=relaxed/simple;
	bh=guo46SAw0HaTASB3V6M3GVjkIBReyHXfNIYTOHXH6QQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=IjbPFY9JK5MzvZhmptv3Epqn9pdx7axg8VfOXt2JCCNsfSvz72wRCKQXvkd+fprANAG4aBPsqj8p57tkrqCZrIuKnsFgsyTRpGvSgWM67O9DAW9Laprlk3PVvY78Ls1iyAiHXdGxAByTjktl5dKHLIwbG93ZhOPmGbbZVbyJQds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2DGxb1e; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753287241; x=1784823241;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=guo46SAw0HaTASB3V6M3GVjkIBReyHXfNIYTOHXH6QQ=;
  b=B2DGxb1ehmvAsAbAn1nPeLlTvi9xIHHcJjyrBTAXxX9njrrGxwOACi6G
   IDuwZn9eGZ/i3SVPfJkGrzMLiJIT4gLbaBcRpWM58lZk5EjXy1HC9V4Cn
   vM3pCMEFnjG+p7DOX+N1Y/rYDgU6m+k07TNUSkYnusBX9gRtIxCqZE6WL
   hUQyZWe60WAAzPJ5gvsKDuixDpQUTynhRTGwqoQcOtDSDfbD+rOSm4Xhr
   OHqI/bxANjNvxZQHAwsaGeYiTiMUFoQBC1q8P+pKL8gg2KVHrsViyj66z
   II2YiJDXsLvQsHsYnoHo8aikY0oDD30tIzSqVTkbWrxkev+dAkp5Ls6t8
   Q==;
X-CSE-ConnectionGUID: qJbUP0JRSlSyAahAaw9Z9Q==
X-CSE-MsgGUID: +OU4ao2qSJu8XlWPVU7ptQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59390982"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59390982"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 09:14:00 -0700
X-CSE-ConnectionGUID: bJMUVv02R3WNK9Bj4/hyUg==
X-CSE-MsgGUID: 8VF8Y/ANQ5iavthaXrALjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159675725"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 09:14:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:13:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 09:13:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 23 Jul 2025 09:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hM/aruHHMbcFl7CiMcmykd/JoFF2OCr8HkLlfQ/15G7mUc9ObAOjkmatDzvSJGERoOG/Pj1qYVFG72ZhyqJ9Mgy011UeGyT375RhrV7q608Av31BnkcJykOptkVbUkm8aViRTmfD0WNNt5zQc/0kHQo49noPUhEnmAcDuUsOOgjxsLu2eXsleEeyZBga4DsHJ9pMpBiGZgUV/vh9ioFbpozcNrmV5tTK9gwQcPuuc+U0tYGO02/b9EvcE6y1pkSMd/d4Etn1lElK1ut0JCkFYS+VcEBq0chTl6iGV2spBa9/od+BwI79VnmimW/dSR44hPnQpzoN9RU4fxyOOm1jew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL0j9hpwMh7B3IWyRcCaJk4UpZrQCE7XthFa8hlyNP0=;
 b=j9ly5rN3MsuMKCpd3nJnOEdM51g6j98L0Lh322hE9bHDuM7sknuKzvCCh6hqWCZg8VPBiqNO1guJGJX8Oe/zS68OWlL6+GE/90YHMeJDkbWgC3e4mkoCrPNGiAK6DckIN1H/JpsqxP1/RbdAdYxbDXsjLobVrvP9tgwWji/eLaEXbOgKZm/ReC7fAaj1wknSBtfSolTl6ahNSY9uSpKF79NsruMGhzLfwRLxNzwYVOrq46rvcIrZQMhb49DrS1+5qOgqG/5CqUkiDM9SWrvhqmkF7BuLyBewm/AsvIdGFBNehFufI2hMSLg+03VygFOQyM9WhLaWcpzpboVjl3GWrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 16:13:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 16:13:56 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 09:13:54 -0700
To: <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Message-ID: <68810a42ec985_1196810094@dwillia2-mobl4.notmuch>
In-Reply-To: <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b59bc7-b50f-440b-cca4-08ddca03ed0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVM4U1lYZ3B2NVdHeXFzajBFN2xwVEI1WUZQTUlPdnRBbktPWlRqR01rK3JW?=
 =?utf-8?B?Rm5SdXl5WUdid24xbUZWNWR0eVJlTzIxVzZrN25SZ3Bja0ZLSDdiSXZoRmF2?=
 =?utf-8?B?bzd0WXlZekhNOGJFbERUM0UxeGFjN2Y1NVpuREdyazRpUHlTR0QvQ0VLaGd4?=
 =?utf-8?B?SE9KMjczL0QvcWIrQUJuSUUvcjloaDBhdlFHTHNoRGxGNjNDaGdYSENuOVZl?=
 =?utf-8?B?SGY3K3BZM1lleTZMR0krSkQyckgvQXZjYlQxTDRMazlYMXNKTTd2M3NsOXVa?=
 =?utf-8?B?WTJHTU0yRWw5ZExsSytPK29PU3VidWJpVEJzNmRWbitOTk1kWE5rQndNYnVK?=
 =?utf-8?B?Z3BadjEyeHppUVpLUXpXclR1ZDVQZEoxQjBQS2JIcmY0emRMYlNnVXQ5R284?=
 =?utf-8?B?SDE0T2dXMzF3NTNweC9xS1I5Wlcrd2U3dmhsU2VxTFBmTysrb2s0L0xDSW1Y?=
 =?utf-8?B?c3ZLVGZaWXN4dUxCTW51ZDVIdVcrOTRYYlFhL291WjdLYUhTOGZHT2VxdjRR?=
 =?utf-8?B?ajlZbzQ5SHVUV3lJU1Bxa2x4WXE4d1ZCa1AxNXl4MWtpMFo4TDI3NTllQ3d6?=
 =?utf-8?B?YkdFdzZQZFBrVytEbUl1VGIyWlBEZGFwZjVTd1FOU3hIbW9EaGZ0Yjh0VlVV?=
 =?utf-8?B?OFlwdmszMUtoZzFwbmpaY0RQU004V1dDM3RlRWZZUkNxbGtlZG9NYnlIc3RY?=
 =?utf-8?B?aytlTTkwWUdEWXRUOUhwamlmYVo2ZGhjUHVHUHJEOWRrZkFGUU80R2htcWNm?=
 =?utf-8?B?eEhyVEpDYkpxU0dUNzFlVUFnMjBvRDYrRlphdG5SWVNzWWV4Q2ZaMHdqZWZN?=
 =?utf-8?B?NzN5WkgrWWg5ZUE0M00ycmIwWmZ2V2V4eEVHcXIzUnZYTXZCc05hTm5XODRW?=
 =?utf-8?B?SE9LbzhUMzcrR3JkN0dIeVJMNVZoNHBzZGlUREs2YlU3MG5QMzNLV3puc2dl?=
 =?utf-8?B?VUM1SU04ZzNnZW80VFpnU0g1UHB6WHNza0ROUkRRV0hHYmE3NDh3b0N1aGxu?=
 =?utf-8?B?eFhIWDFSN3V4NnVPQk5jd21kNWJlS1NHQUtQQkNna3htemlwT1g4KzVPdHFB?=
 =?utf-8?B?eW5DL0lZenVuRnlERnRiMWdWQXZ0U2ExYjhHSjIwSmNscDR5Y0oyakNuZWZt?=
 =?utf-8?B?c3V6L2tYb2hJUUVNVFZTSG5mM2c4RlJuaEdhMzFtdXBBazVWckNOaDBHdXJw?=
 =?utf-8?B?eExEb1Z6dWdvd2JGYzNDUlFnbEc2bEhwNW9vOXVFY0VCSzBSM2YrekJGeWdo?=
 =?utf-8?B?eXBGbkhTeUd2RjlWL05RMUxiUE9US0h6a29sN1hmYlJScmtscnl6djhWcEI5?=
 =?utf-8?B?OFFxa0prNzE1RGc1R3F6MWlRREFuUmFpbFhDNmRDS2FaMU41ME91N2N0bUVi?=
 =?utf-8?B?MXU3bUtPc3Z0Nm1US3NyckVoOTFFekozYUpsMHNPZmNnZU5hQ29oVTRweXNv?=
 =?utf-8?B?dDkxTEJJUEJxZ0FCK0h3d2VUVjQyWHBLY0pycWF0bEpQVm45Mmt2NHlqaGU0?=
 =?utf-8?B?R21kaDkrMVdhWU0zUEhRcFk3Y2laV1NjaUpjNFZydDNDUmhHSG9vMytFcUdh?=
 =?utf-8?B?VGJEelIxVmtwYnZiN1Z5K3NicWpyMmNZZFNPeVRGZ1lOOEc2Mm43L3Q3THpp?=
 =?utf-8?B?d0lZaFlTS3FxQ005blVOc1Bjc0RlZUsxOUtSWGpvdUdEL2hnQWYyOXNKaExK?=
 =?utf-8?B?eWEwemY4ejlWQUZ6S0FRRDluZ2pBY3U4UkcxTyszRkNqS3JNZjBxUDBWcHlp?=
 =?utf-8?B?bi8wL0RnOE5hcFpSTDNYamhsM3BKeDdyVzlCc3dKK3FncXlRVjBoNW52a1d0?=
 =?utf-8?B?bnVOZ1JOT3RtaDArZEVEUW1aeVl3V1ZWdUh0cDVVRTNwQnFhbWcxZDM1d3o0?=
 =?utf-8?B?d0wvUTlpcFRBMUVYREJoUjIwc0JVRk9tL25yeEFpdThmRWJEWmo0ZFlBM3NO?=
 =?utf-8?Q?vrufbyFuiv4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3hBbHFBUUNqaklDRE1SeGV5elZZeFA4UEl6RnpWQlhnaGkyUFZUVEZFOWJ1?=
 =?utf-8?B?c3E4eVY3OFB1Q1V2TnZudUN1ZWJlOVNyMGVhemhQcUJVMWxLWkdrYkYyL0l2?=
 =?utf-8?B?V0VIWFpRTkNCbVFETjg4d2JzS2pTVDVBaERuY3NNcmE5RUdvWG9sakxQMUF3?=
 =?utf-8?B?Vnd5MjdVYjZzZVJqdVhwVTNyamtyeDQrWVByYU5UTC9oYm0xSEcxUHBFekUy?=
 =?utf-8?B?c2FJY1BiSHJJb2dPY1picGJhdUZjajZWVVBkdGZ2ODd3Rk5YeWtqckdreGpI?=
 =?utf-8?B?WVpqZno5YXYxMjJ1SGV4WUIrQ0ZLZkFuRVFQUmxwQjdmOXZqMXNxa3YvY1ll?=
 =?utf-8?B?NC9CQk4zaUdhNk1oelg4elJYOTZoaEx1MS9PakIyWjVNdXBURWY1c3BidjM3?=
 =?utf-8?B?dHdnS25LR2F4UHllTm9iWkpxUU84WTVXa1k3T2V5NS9DaXBEZERUblBSVXpV?=
 =?utf-8?B?UWgvSWR4ZmxNeVlIVjgvM1Z6MitCeW1ud0c5Vzc0dy8wWm1NOWFYRXFwTDlm?=
 =?utf-8?B?NGE2SG1sMEw0YVdLcEo3Y1lwTVJleHo2akxtS0w2bFVoTiszVmVNVEZRcitw?=
 =?utf-8?B?bVJ1MUhtNU9NOEc1WkdLN2ExZ2NOZ1M0bWdHQXI2MXhhK3hGU2wwR2JOT0FC?=
 =?utf-8?B?Q0hNZlhIWWZsRHBpNS8reldZMEg5d0ZJeTRScW90VDhNeElhMDlDeVFXc21J?=
 =?utf-8?B?bnUxekdqRnYrTERXVnBDaHFBemMrRGNWTmU3cDlTNGdIc3hPNGV5M1ljWXZD?=
 =?utf-8?B?TlpHczQ1QW5rbHdxQXlVTFM2blF0YmdOamJIZ3pjYUhLK0hNTDBkU1dVSjlj?=
 =?utf-8?B?QmZ1S3IrLzdpS0szOFBpckoxRUlvNmM4OGpqbksvcXdCakY1UGY5Y2dOcWYr?=
 =?utf-8?B?aGRVME44OXB1WGQ4aVNFSytNUzJMSm5DUU5nVHZZcnVDVlIvN0EzTWNyOUYv?=
 =?utf-8?B?YklJbm5YeHJyMjNrY0FoVDdXbXg5bGxZcjZMWHlUMVlIbllla0N6cHROSDBR?=
 =?utf-8?B?NDdzak1rZzF6bjVXUCtYNkZUd3ZGdUpJMXJkcVNLQ1NTTmJSWXBGSVhsNXdP?=
 =?utf-8?B?QnprSTBUeklaR3NLRDB6MTYyWWFHTW53Sy9QRGJzY2YzK0hvRWNIdDhpZkp1?=
 =?utf-8?B?ZHpaMkxlYU9QRFBhVktHVTF2cTFmNHpab0JML3pqcnlkTXZUalhERk1xbEQv?=
 =?utf-8?B?QXduWC85dytYZkhiRUNaYlYxc1ZRVE93NDUvamdleUQ2VDhEdzB3TEZzMHZx?=
 =?utf-8?B?dzdDcTl3c1VtZndGVTZoNjFSM3lURmZDQndYdGFTUVd0N05wMnB0V1RIWjJl?=
 =?utf-8?B?R2orTk1KbUtLVHFHdDVHbG5iazNoRmV6aGRJTFFXMlNzeWlWMnQ2bzQxRXZP?=
 =?utf-8?B?d0tia1lnSjcvWXNSZ2c5Qk95K3dlUmpRcjJmZG1pOTh0ZVhyaE04cng0TEpS?=
 =?utf-8?B?VVpab3RBYVYzRnUwa2YvOVdQTTF0dUwrYkxsNXpOQ3dORC9NVFV5Q1FZK1Q4?=
 =?utf-8?B?ZEV0THRPQm4zL0IwNW5RL2lxS1FuT3h2bVJ5QmhjampwMThFMStJMzZ3dDdp?=
 =?utf-8?B?ajlKZ01ITENRNVhCMnhhNkU1eXQ3MmxUdENRUExIVjQ2bkI5L0FJWFNMaHFL?=
 =?utf-8?B?a1hOaWtUTHZFakZsWCtkQ21JYUpyUGVPdlFUSWZiem9uZStQMzh4VERyU2pO?=
 =?utf-8?B?Y3gwd1IzWms4eFVQeDVRRnhqTnBuWExxN3ZaRzB4eGw4aE5MQjFwSDBXVUM0?=
 =?utf-8?B?djhWbmFjNDVzYm5NdnBrSmZUZGMxM0Qxamkrc0wyV0w2Wnc5dzdZa2dyejBk?=
 =?utf-8?B?ZkQwSHJnSkQwQmMyYjVzaVNrYmoyKzlETUM2TnMyei9BdS9tOWpGN1ZiQkhO?=
 =?utf-8?B?anpsNmxTRkRmaUY1d2d1OENuZmlOd1ZvQ1VQZ0E3dFJQUEoxVTlsNndqdHlX?=
 =?utf-8?B?K0JYV0MyeUhnOUxqam1pMWRqa1lsU1VDTUZ2cGZYQmUzRktnQ1dtbUs0ZTdB?=
 =?utf-8?B?aXJnQ3Q3Zzl2dFpVeEdCMVBXWmJhMFlEU21RYzRrMDRWOUszYzkwaVUxajh1?=
 =?utf-8?B?ZUtDcCsrN2lvL3kvYXRnOE1QZkFtSmVqbDZRWkEyZjB1UVNtdStLRFRzYTdN?=
 =?utf-8?B?WVdTayt1SFp4aVo4MWFudTNsUmhKZFAvR2ZEMDlYQ0N0Ky9TaGgvYk5kNmxY?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b59bc7-b50f-440b-cca4-08ddca03ed0b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:13:56.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVCxtmEk1b7deD9dM1AMlUXco3mIUXoFXlhDPSCt478S4Y2LQIeSuAjqgCpBio+sAnXpJIGOs+AgnVDURAf1t5hJ5JIkhrei0Wmda5giI9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
[..]
> If the goal is: "I want to give device-dax a point at which it can make
> a go / no-go decision about whether the CXL subsystem has properly
> assembled all CXL regions implied by Soft Reserved instersecting with
> CXL Windows." Then that is something like the below, only lightly tested
> and likely regresses the non-CXL case.
> 
> -- 8< --
> From 48b25461eca050504cf5678afd7837307b2dd14f Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Tue, 22 Jul 2025 16:11:08 -0700
> Subject: [RFC PATCH] dax/cxl: Defer Soft Reserved registration

Likely needs this incremental change to prevent DEV_DAX_HMEM from being
built-in when CXL is not. This still leaves the awkward scenario of CXL
enabled, DEV_DAX_CXL disabled, and DEV_DAX_HMEM built-in. I believe that
safely fails in devdax only / fallback mode, but something to
investigate when respinning on top of this.

-- 8< --
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d656e4c0eb84..3683bb3f2311 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -48,6 +48,8 @@ config DEV_DAX_CXL
 	tristate "CXL DAX: direct access to CXL RAM regions"
 	depends on CXL_BUS && CXL_REGION && DEV_DAX
 	default CXL_REGION && DEV_DAX
+	depends on CXL_ACPI >= DEV_DAX_HMEM
+	depends on CXL_PCI >= DEV_DAX_HMEM
 	help
 	  CXL RAM regions are either mapped by platform-firmware
 	  and published in the initial system-memory map as "System RAM", mapped
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 0916478e3817..8bcd104111a8 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -103,7 +103,7 @@ static int hmem_register_device(struct device *host, int target_nid,
 	long id;
 	int rc;
 
-	if (IS_ENABLED(CONFIG_CXL_REGION) &&
+	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
 		switch (dax_cxl_mode) {
@@ -209,7 +209,7 @@ static __init int dax_hmem_init(void)
 	 * CXL topology discovery at least once before scanning the
 	 * iomem resource tree for IORES_DESC_CXL resources.
 	 */
-	if (IS_ENABLED(CONFIG_CXL_REGION)) {
+	if (IS_ENABLED(CONFIG_DEV_DAX_CXL)) {
 		request_module("cxl_acpi");
 		request_module("cxl_pci");
 	}

