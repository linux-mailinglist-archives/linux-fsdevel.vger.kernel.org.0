Return-Path: <linux-fsdevel+bounces-70531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834FC9DAD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 04:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DB33A91E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 03:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C81258EDB;
	Wed,  3 Dec 2025 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLl9arOX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC12AD32;
	Wed,  3 Dec 2025 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764733823; cv=fail; b=jG+mkryo84nqBC21j33V4SjyXY3m6VaNB0YXsCGZ0sGMuI5T9miHZadHANmMLA7c+ckQ3ubJlLPixinkBd2zF/hFO6hQtFnYSq9ZxWuab/lDRjn2QoD+OLw/AaebNEIqLT9nx7hvCApD8DKm9lioDKZWQFocQZV5UEcjE3aq1R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764733823; c=relaxed/simple;
	bh=tDFgO5Ul5RFCkuojOSyxbHRLczKObxbSf0gOB7PlcUk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EhiEfuTVmsjRY1RHUr8iEw3wpoDfe4e+lJnT4APbBH389VavDlzn22rWueoc7vILQCqlB6ZaEAW/4m5SF+7Xu8gB9JGObr7X7bdtKD/dYSh/VHPThxHRohqqMNnyYVD2R4YmUpUqzBx92BiigmuBIVluwvwS1VMvURXrW2NQK84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLl9arOX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764733822; x=1796269822;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tDFgO5Ul5RFCkuojOSyxbHRLczKObxbSf0gOB7PlcUk=;
  b=fLl9arOXpPK829PSPagSclzSu0nIFrE4HwkcNSwluaQQLdTzFPaZxNBY
   DJYTYyEz/R7l8rTMKab/IMg6FkQUu7qTJwpcWQgbw0y4FZ3k0Ex5lecVz
   A0LUj+fExMyIeR+uZ9uH3nH8uLb8GBjFtkZPqkiVwJ/0/sAWLYC+qF6s+
   mhBs9U28luAKmq4M5uznkIetUTDT1QtDBHWJMWQ02soesEWSz7jD0kVYT
   fyZISj1W3+bbBoaNvQBiCKhoBFoL63DFPmvYZo940pshoF6OE15Cl/J6a
   SBzEgpSdwGZdJYz3WnO7h4OfvMTettR3JVwEa0mGfpAPkk46nIsL4zfMh
   Q==;
X-CSE-ConnectionGUID: UvUYlM3BRGKWz/2hSVNzIQ==
X-CSE-MsgGUID: i9xjkbXBTUOimBPdgjTC0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66752932"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="66752932"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 19:50:21 -0800
X-CSE-ConnectionGUID: v8+7TZ4zS9CT8sQXljea9g==
X-CSE-MsgGUID: OBI299NeTq6TDjg9xg6bfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="225241155"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 19:50:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 19:50:20 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 19:50:20 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 19:50:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQWl6WkY/BN0SxyjKJrECKZDeMCt5gDAwY6R3fuUxHi5g8ypiZ17KCw2eu4dpppBvlM4vzjzr9QdKgCDElQOb4k4coPH9VOYpkaS6X+nLCzMIBiDQugHGjZMcCzUxIvIYK15sSSQeJcOUVNjRWls2QhbdEOvsF+InHlWLBA/vlRK63r87b0xp/Wv/7C0Td03uiupgOBt76yaWxFqDoFJwx4JsXKiHcGQAupSwQ+Twn/HoaWP1HR1FOTxWcqrv3EfGQ3ycguVMYYT+xjMyFtQ0ZMo8wbCjXjVVwvUG6KmRR1WsjURJWvUnKkiD8C3lH/H+qlFxb0MrgRbxUpEt+Kh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoEBpYwxhOD9CLsnuCugDKGOWz31d1C/XgGolgxyugo=;
 b=wyIu8ifOrzqWS4jr+6zCdfo8+vgiMPTC9V2FXTVId8e0duItlOn5AHiaRCQb2VNfbTMGIRVRNUug5OFVxZyIoS8VU/2MtpCpF5vn+sIHPKVBZ/1vuf0rWfvovCiiWOzmpvE0OXby7BLdtN2pFzmyL2+bryoDkYXRS2WwxyieSzXTBckJ6OM/JAkNQZTcWD/0+GhpS67qQpuQMgklc2h6TkXHCjjZqEdvk2VWVONja8c2YCPx0wBiflejF/2eojy1brDA55kmB7uMKbsuNqaxVPQnx/7joT+UHoSaVkivs7uofT8zwEzp4/RDJSUMJ5q8O1d4YMJOHzj4waFcJedd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9323.namprd11.prod.outlook.com (2603:10b6:208:565::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 03:50:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 03:50:13 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 2 Dec 2025 19:50:11 -0800
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <692fb37395f3e_261c11002e@dwillia2-mobl4.notmuch>
In-Reply-To: <20251120031925.87762-6-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-6-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v4 5/9] cxl/region, dax/hmem: Arbitrate Soft Reserved
 ownership with cxl_regions_fully_map()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f238ded-c706-4fbd-999b-08de321f101e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEtVQnBZM1BDTS9pVm9jK1NQMkl5TGQ1STdFeUIySlRDWHFLYUhlVHJNenFs?=
 =?utf-8?B?ZVpacFhiZ2ZDVWorVGpYVzZ3ZTBMUU1rZDZiVFBEUW1OT1BJcFRKTHhjQVZR?=
 =?utf-8?B?eEU4SWFuN0tnUGVyb1lUOFIvRXR5RkNmckF1TWtDU0ZHdjN0OTBYY212TUxX?=
 =?utf-8?B?TU1OT2tyeHdmVFlHZk9GS2lQN3RZT1hLd3NQVjBwNHlwNzVtQzl5d0RObS9Q?=
 =?utf-8?B?NEk5U2FTZTdMRFVSQVBad1VLKzV1QW4zUXptL2VnbGJwY3gyamtzM0lxd3Rp?=
 =?utf-8?B?OFRmMXppU0RtQTl1QVZvVHE0SWprZVJsam1qaE9lb2srdFlpNEMwYVJscEd6?=
 =?utf-8?B?NjFWOUxoM3dJVzd0SVNyM3F1cDFOblRTNjl3N3FnT2dSRXBJbkIrMW40aE05?=
 =?utf-8?B?eXlaaFlielgrZG9qaGlpa0tFeFJmMkNMZkpPcU8yTUxBR3JUYWk4SlhXYUhv?=
 =?utf-8?B?OFJvdi90ek8zSkdlY1I0UjZRRkYwcHdPWjY1S3EwNVc0OEs0MUEwNzE4YURD?=
 =?utf-8?B?UHVPWmdudU5UOFFQWCtQN3VZQ2FxUUE5Y1Vzb3VKM1hHNzRTY1Mrd3hpRUhj?=
 =?utf-8?B?b0VndGhHSFdWd3BWb3A2RkU5RENHSEJjQ1Q4SDhENHV4QnNEVXNZMnJmSVoy?=
 =?utf-8?B?bEhwYTVMaUx6ZFpYS0JmWEZFd2t0YTdMcnpCNU5zUjlvMkVDZXZnemQ3Rzd1?=
 =?utf-8?B?KzArckZGU2ZJR1VycXdIM1Q4bnc3L3UyMGoxRDJqYVpoTk5VWjZBWVRaL3hh?=
 =?utf-8?B?MXFjcjR4dWIyaytZd1NSWVZtZ2U0Tk55ZGhPb1B3MzlIcytibDh2UDZUaDN6?=
 =?utf-8?B?OGR3QkJVam5yMEs0K2FJZHErdVJnZENZUTlqSGlDSUh0czlocXRzQklZSEtU?=
 =?utf-8?B?UW1DeE43TElhS21hdzN5bkFud0ZnRlhkbGRvMGY2TTg0blpoYXA5V0plRUFU?=
 =?utf-8?B?K2dFY2VlQmpza0Rrd2RzdDkySFVZZWxrUlY2VmhDVHREQ0o1TXprWnJBbmhh?=
 =?utf-8?B?T3Fpa3JQTkxpejRPWmtpeVlTRFlQSjR2MXhuRjJIMWQ2Z1c2VDhwQWlCR3k2?=
 =?utf-8?B?WEZ5TFlOZ0hHejJmSWRRQitsOXBRb1RET09tOEZyei9qUjk4Tlpmd3pDUE1W?=
 =?utf-8?B?U3BsSi93SjNHdlVBeFBXN05OSE1XdXRvWWNkOFVnUlpIQzFRd1RzQ21DWkNV?=
 =?utf-8?B?MmoxRkZFUm41WW1OZUpGRGx1MTVFWHpLY0NicnZRbElhcERlT20yUEFNb00v?=
 =?utf-8?B?ckFPU3hlVndmb3FTTW1jRnlkUU42endiQ0plem0yRkNSU1NmY0x1SlYvaVg2?=
 =?utf-8?B?d0lzT3RTbzQ0Z2F1eUVEU1NLVzdwNVk4dzJKeHcxMi96Z3BCWENVV0d1ckpr?=
 =?utf-8?B?RFZrU25pbzF1V3RRMnpFbGlXeDFyanFqSTRmZUlQcmNEM1dGdFdHai9idjg4?=
 =?utf-8?B?ODdhNnhvZ1FPMURIWEpZN3hCSHBkeXZZc1lXNHFjRldVd2tNb0NaOWR2dXhM?=
 =?utf-8?B?R3FvK0w3ZDBiWHFtelNLVVlRcEhmM085bDFxVlYrVW9MM0htU0ExbmFOeEpu?=
 =?utf-8?B?NEFDUWRRY0dSQStsTTFZSFBIS1dnYTFRdW9lWTlMcm83MlA0bTJVYXhHWGRG?=
 =?utf-8?B?MmFOUWdpYktyWFdvRFR3MHg2Z2prNndqQVpMMitBZUJnZENUZnRaNUliWlFY?=
 =?utf-8?B?aW1SUTRJaEJrL0tob3d1WWpJaTE2ejVIaUFvTjVwTkE0OUwzaUh6NXBpL09W?=
 =?utf-8?B?Z042bVJNTUNTN3ppNVdra0Q2QzdtZ3JXNjNBVk4yaFJXSDRzdVJlaWpJZkhC?=
 =?utf-8?B?R2J3QlNSWXRhejJLNVhDVWtvNmRpSVd3SGlFY0dMc0NvTGZycmxIdDlGOFhY?=
 =?utf-8?B?VmRXb0V0VThaRFlVQ1Q3Q2lockkrZ2dZbjFlNVBNZ2F0SGhRZDZDb0V3Tnor?=
 =?utf-8?Q?pcdr0tMFIe8gea3DYN9GSENBz0LnWGXh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjdBejJXejBSNVJFS1NzRkg4QUkwclVHTHl0U1hTYndzNmE2dVlUalMyaTVi?=
 =?utf-8?B?QVlHdjVnWTUxNGxaaGxIVVBNVEs1dVVGcUtuRUo1aWtBNy92ZjYwRitNa3R0?=
 =?utf-8?B?OXBhMG10RjlTZjkybGpIM2dPMEU5VUhwdmRhOFQwZGVDWFBQN1Z1eEkybElk?=
 =?utf-8?B?NTVyZGVNVlNjV0xUdXBvd3EreCtoVGpSSXZjTi8vQ0NUMXhtNG1NNUh0VWgz?=
 =?utf-8?B?ZUlkMVZDV2xzcWRXNlRTYndxLzFqbUxxbTVPQzRkQlpkMHBpNjNaVDk5Znk1?=
 =?utf-8?B?MXRnWjRRVGhIUXFvcnFJbmowTlkzUW1hU0R2OXFQQm9ZTEFJMVBnajFTVHBV?=
 =?utf-8?B?bkI5ZEZUbndsUDlkR09YcGpiWXB4RVpLL3pRbUxtMmQrVlVZbCtFUUg3WThi?=
 =?utf-8?B?a2JWQmtlRkRLeFFpaVFFdStOS1o4cUU4RkhKN3NlTEZlazQ5VFpuLytaN2x1?=
 =?utf-8?B?MitGTWl0RGU5aWthUU1XYmc5Zk5oZkU2bEZLWE5Zb0tiZm9pbVBWaVUvR1FU?=
 =?utf-8?B?cUJ3V1pLU2pxcEp2OGFUeTVSTE4rT2VYUWRYdXNRK2N4SHhMOFYzK0I3dWhm?=
 =?utf-8?B?S2dma0xBZS85WTd0ZDRiQkkwZldQaXhSSkFxUFpuTkl2NmkvSzFuSGhWcVdX?=
 =?utf-8?B?Mi80TnRjcXZXMERJTVlxeE9XSXpZOXJRSWRxcTYxUDEvNHU0UldXcWI2RHVR?=
 =?utf-8?B?N00xdWlBSGJNUXNwMC8xT0FQMHg3UjR0OUNCUkVwbUd0YVR5d3pOcE8xdnIz?=
 =?utf-8?B?VWxXaWgvcTZlTjQ3L3g2R1ZNTVBoRXA3b2JPU1Rtc1FacTJ1TVpsWTFIMjUv?=
 =?utf-8?B?V0hZd0RCdVRMMHZPL2NvSW1WWk5oZ1RxL29YY0gyY29vSEhNd0MyTTdreVRo?=
 =?utf-8?B?Sy9scFJaZTcwU1I4bkNZdWt3TVZDZlVMOGIyYVFmcGdzYWdqNVk4Qks0RkNy?=
 =?utf-8?B?RFR6T2pyRHFOSURHNUszb25lRlUvU2VzMXlRYWhyL3lqbi9FcExDNGFCdDlZ?=
 =?utf-8?B?TjFjSUNnajVjNTFCVVJBL2tQTUtUeHJKY2pGTUtqQUlkWENTQm4rZlZWdHI3?=
 =?utf-8?B?T0xXUVE4T2NEcFp6bG9TRjhiUjZ1TUNpVEZEYTZTS0QzTXpxbW9ZeWF0ODVB?=
 =?utf-8?B?dk52bHc3d3JhbXlNcDdnVno3OHh5N0JFa0FWMFl0Qy9OQ2RMbVF1dFFMcjVm?=
 =?utf-8?B?R1NjaXBqMzJNL2ZqTG1XTG9yVlY2WDRIbHZqUzU5UHY5bnZGb1JlUGdhZ3pq?=
 =?utf-8?B?NmRoY1dCQS9CQm5pTzAxOGppbk91KzFiU1BXQURSelkrOElrTHFkajFBbGJ6?=
 =?utf-8?B?UTduYXp5aS9OblFJbVlqaXVMVzEzMlNZZytIOVdKWDNpQi84bDg5Z1ZNd05L?=
 =?utf-8?B?Y3dmeUVqN2x4bjVRUkNoS25YbXRTUWdoZVFiYjh4ZlE4TXZxd0JiakpCWlZB?=
 =?utf-8?B?UVVHOVprd0dLMXByVStVeEhRdkRWdlpYN201ME5wNTBHaFIvbUNPRGkyUFN0?=
 =?utf-8?B?aklxTFRxZGkxYjVUcW1tRVd0Z3VvV3k2SVd5Z2dyZlVTZkZGTlViN01tYXA5?=
 =?utf-8?B?YnJrZEMxRnRaU2ZYS1N6UW42S0lweUxydFh1MjJDOHh6YUNBT0FzSkF2amEz?=
 =?utf-8?B?d1F5cXZFVFFUVzJ2WHNRZnFZN1FSSlc4Sm1GcnRSV2wxRXFGWFVSalpvdzFC?=
 =?utf-8?B?dTg0cXdJWGxQRnN0L0prQ211U1B4cHhjbFo3aWY2MUZSd0hRUXdGWXlxYmNr?=
 =?utf-8?B?c2JqVUgzZDgweW44UDNOY1JySWVSM1ZQcXp4NVBvT1AwRVVhVGNQMjdRRGZI?=
 =?utf-8?B?bGtJVnBvMFh3Ti9mekhsQ3BjQUFQU2dZNmY3M21qc3ZTYmtJcXZDRFk1NTc4?=
 =?utf-8?B?L3FqbmdEakZ0NHorQlNoblgxUk9FVVF3NVEyODNGMWxjaE9ic2Y4YlR6Y0c5?=
 =?utf-8?B?UlNXLzlReXV5WjVoV1d5RmMzT3Q0aDhTY0REd3dxTkdjRnZPMjhoR3pqZVN0?=
 =?utf-8?B?eVZrbWtxM1luSFNLUGluRVppNUIrUG15NEc2aVFyVFdhSCsyK0tkK3F0UVlo?=
 =?utf-8?B?RHNNRktrY1IzZHYxbkZOQXpHeXJkZ3VYVDFJRGcrWGpFRU9pRGZ1K09Zdmk0?=
 =?utf-8?B?THVWNkZHQldNSENwY1crTll4TFQyMWFsNExtQXhQTWtuZUh6R0c1bnJhMUJV?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f238ded-c706-4fbd-999b-08de321f101e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 03:50:13.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZCFLP/cuQssYIIu2LZ+boggHq+Z06l83Lg1O5uTXXSXdTAojLZyYPZy8opYOdP1mLLjj/7CbbqJUVgWY4C++Nakas7o1qq4yr4oGNr7Czs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9323
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Introduce cxl_regions_fully_map() to check whether CXL regions form a
> single contiguous, non-overlapping cover of a given Soft Reserved range.
> 
> Use this helper to decide whether Soft Reserved memory overlapping CXL
> regions should be owned by CXL or registered by HMEM.
> 
> If the span is fully covered by CXL regions, treat the Soft Reserved
> range as owned by CXL and have HMEM skip registration. Else, let HMEM
> claim the range and register the corresponding devdax for it.

This all feels a bit too custom when helpers like resource_contains()
exist.

Also remember that the default list of soft-reserved ranges that dax
grabs is filtered by the ACPI HMAT. So while there is a chance that one
EFI memory map entry spans multiple CXL regions, there is a lower chance
that a single ACPI HMAT range spans multiple CXL regions.

I think it is fair for Linux to be simple and require that an algorithm
of:

cxl_contains_soft_reserve()
    for_each_cxl_intersecting_hmem_resource()
        found = false
        for_each_region()
           if (resource_contains(cxl_region_resource, hmem_resource))
               found = true
        if (!found)
            return false
    return true

...should be good enough, otherwise fallback to pure hmem operation, and
do not worry about the corner cases.

If Linux really needs to understand that ACPI HMAT ranges may span
multiple CXL regions then I would want to understand more what is
driving that configuration.

Btw, I do not see a:

    guard(rwsem_read)(&cxl_rwsem.region)

...anywhere in the proposed patch. That needs to be held be sure the
region's resource settings are not changed out from underneath you. This
should probably also be checking that the region is in the commit state
because it may still be racing regions under creation post
wait_for_device_probe().

>  void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index f70a0688bd11..db4c46337ac3 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -3,6 +3,8 @@
>  #include <linux/memregion.h>
>  #include <linux/module.h>
>  #include <linux/dax.h>
> +
> +#include "../../cxl/cxl.h"
>  #include "../bus.h"
>  
>  static bool region_idle;
> @@ -150,7 +152,17 @@ static int hmem_register_device(struct device *host, int target_nid,
>  static int handle_deferred_cxl(struct device *host, int target_nid,
>  			       const struct resource *res)
>  {
> -	/* TODO: Handle region assembly failures */
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +
> +		if (cxl_regions_fully_map(res->start, res->end))
> +			dax_cxl_mode = DAX_CXL_MODE_DROP;
> +		else
> +			dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> +
> +		hmem_register_device(host, target_nid, res);
> +	}
> +

I think there is enough content to just create the new
cxl_contains_soft_reserve() ABI, and then hookup handle_deferred_cxl in
a follow-on patch.

