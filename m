Return-Path: <linux-fsdevel+bounces-70919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A83CA9AD9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 01:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 519AF3009103
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 00:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11ED1862A;
	Sat,  6 Dec 2025 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Go7DNICD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208D14A8B;
	Sat,  6 Dec 2025 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979901; cv=fail; b=Rk22s0qW8LTb2R9avnTzk+9yPryTetR9xCSZGtllQL4JNQfIWzp6yBP1Qe+jekrEMwK0a8BtklWHMA1xCxyWFaCypF0LFiyFLqP9GfwwhO00Kj0IrWl7s4DlvMw6cMECdCRQ5xubidC8sjttg9MdPMZkaFVDu03JJj/iyX+h2C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979901; c=relaxed/simple;
	bh=eGWOhSr+0lcbidZ7apKAr/prSzzT28ElFduTLczjtoY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=KD1Qd4PHPuMssnCE8VUCIrassCaHWrRlJ86FQ5KimM5noiUxSDcCwEuuFFgIJZimiBgQeQz3ySs/VNO++NFehDavrsZ1AThL8VzIeRyf8HyHfh3qRL1CQDL6l06BZ+DNSMJvItgjw0ObcfmCjFbWSlCwJjQ2QVm3oe5N97krQJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Go7DNICD; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764979899; x=1796515899;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=eGWOhSr+0lcbidZ7apKAr/prSzzT28ElFduTLczjtoY=;
  b=Go7DNICDJ/H83BwFF0Ntc3ULW48H3bcxzANQpgAxvXX3Io81+iaLBkzC
   of86SpMkt+dHIZ7w0/5OuOeWSnf1rOjDlR7dlomKVUDyNi3Nrvs4/zV1o
   VAc1D1bILPvGg1hUV+BaOX9ZwA0oIrJfyk/c9vJoisyUpM9T1nNScpUZF
   AZlqOKQT9eouASeGPVEhRQZ6NiwBslr+3vH9Nozu8dA+v3/AXvn8o6xwv
   uqAWrgD1ekcLbX3ao5sVY58ALojb9Qgx95cbVqEICYR1idXhp4321tUTL
   YZhtA6q5K22lKEIgmM/8pHk/+bfBN3qEKuf7QzCdhlQzu6TbR8eVE1xGP
   A==;
X-CSE-ConnectionGUID: RGjtxC8xQoyZgcSLoKQaxw==
X-CSE-MsgGUID: wWFn3gAQQVms+3MI/NI8HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="66205334"
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="66205334"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 16:11:38 -0800
X-CSE-ConnectionGUID: gMn2c6hcTdu+FcYQ8HborQ==
X-CSE-MsgGUID: kSqTG+2/ToOjQCSFzE1UUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,253,1758610800"; 
   d="scan'208";a="226438771"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 16:11:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 16:11:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 16:11:37 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 16:11:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYLPMJPO+wwL9MFQoLJCYJOrj/q8tllGZk9dM8NkPbiDMwl5klaoJZsrbANjMLkjY+VbCrWNcq6JA9BGaSORy4JIJCbHxUL4+nhhWvUkMVtS+azugtaKEKEq19c/Xuzy+i+i68wD0Mdmf0z0da/P2iiLNuK3IG43cVSAp7TJ8yuB3KXH3DiP5AxB+WcvslYPiG564rN9LF282aSowJllkdKmpB5T8EfHCUxuMMLpIMprMtefcx/Y7o/6/rYYkwDwN6Tcqm4cuUTP8Sdl5XwC0JnAckdH4xaJKiXyX0edbo9Z2MC3ASX2hPHMHpDwpbA1dCVpmJl96iw17EivPhuJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbFOJB4qAPSzwtcl0eykvQkdf8Fj+8dnBjgzhCR9Gy8=;
 b=JL0lZAbOUKWMyJ5BA9vSpleBygTvoBCvGRhShsLsE2vfb9aWcerHQQGkdJP7qb6WkIyep9luQc/Mh8WbQ6nwR69cJ84qQrinaeJmzFQOsn2dT+5SwFhg3FCHXBVaSrdU+rOkho9edHxRmtf6HFbkc3/TUIrVM4uc6zVoBnxYXHcCu5eq5/d9x6U503LVOYM9o034LvoQuwfglAXaFfL8d7PCuQ5Ee//5msnwNUtRgoNUK1eVSkb9bNgcjSypJsGMQiCU72adRbITRz9gYRMmDlB3eeXnPVE/jAyyJie/VFvk7NW1OKVZtBcXyBOhGMdKBgSc7pSYN/QM4LalxM++ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7423.namprd11.prod.outlook.com (2603:10b6:510:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 6 Dec
 2025 00:11:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9388.011; Sat, 6 Dec 2025
 00:11:35 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Dec 2025 16:11:34 -0800
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"'dan.j.williams@intel.com'" <dan.j.williams@intel.com>, "Tomasz Wolski
 (Fujitsu)" <tomasz.wolski@fujitsu.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>
CC: "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "huang.ying.caritas@gmail.com"
	<huang.ying.caritas@gmail.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"jack@suse.cz" <jack@suse.cz>, "jeff.johnson@oss.qualcomm.com"
	<jeff.johnson@oss.qualcomm.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "len.brown@intel.com" <len.brown@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"nathan.fontenot@amd.com" <nathan.fontenot@amd.com>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "pavel@kernel.org" <pavel@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "rrichter@amd.com" <rrichter@amd.com>,
	"terry.bowman@amd.com" <terry.bowman@amd.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "willy@infradead.org" <willy@infradead.org>,
	"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>
Message-ID: <693374b63fed_1b2e10063@dwillia2-mobl4.notmuch>
In-Reply-To: <OS9PR01MB124214C25B1A4A4FA1075CADA90A7A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
References: <aS3y0j96t1ygwJsR@aschofie-mobl2.lan>
 <20251203133552.15468-1-tomasz.wolski@fujitsu.com>
 <6930b447c48d6_198110029@dwillia2-mobl4.notmuch>
 <OS9PR01MB124214C25B1A4A4FA1075CADA90A7A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
Subject: RE: [PATCH v4 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd868af-c5d8-4534-b930-08de345c04ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjE1d0xFYnEvKzJiYU4zMVd4RVR5cWpnYmRsZWNDS2VkZ0FrNjBVRjBqMFdQ?=
 =?utf-8?B?T0hMeDhDZE1XdXlXalNRUVBxY0NmaDdGWU9KcUozc1gwUnYzdW4ycy91SzhG?=
 =?utf-8?B?WFQ5RlVHR2NRQUthK2o2NDV5WVNQQmZlZ1ZPWmZzZXZVMGFrWVFDYWt4eHpQ?=
 =?utf-8?B?VXpvY1FINTlHNU5ZRVhwYXRkUUZ5ajBrS1psYS9oSlFtVWxaamwvS1JnRlVs?=
 =?utf-8?B?SWxINnhsTEFObDg3U3FESTlSMWYraDFocXluQUFCUEFPZXU3K2VQWlRoSnoz?=
 =?utf-8?B?dmFqZDZmNFZ1Y1B2MGJicTN2cDhDZEpyUXh2Q1Z5NHpXZGJDZEIxS2ZzSEpS?=
 =?utf-8?B?ZCtLeUI5bHN3UGRhWHI0N2hpRlJ0MHdTaTVDa2tSQUxUNzluWS9QdGg5ZWdS?=
 =?utf-8?B?Nk5SbldTVTZkRVE3SDVWNkRLM2svSWkzSHVmanNTMkdFdnlCYTVFSStuKzFx?=
 =?utf-8?B?bC9uRkRqVFpQNjduY1VRT3FqZ2pScEd5VzhjN2ZhY1hnTXFRaWtjUGdDNnlr?=
 =?utf-8?B?TW1VS3VsMWhaTjNGL1praVJrd1crVnhHNkZBQklJOWVBRnBzVGcvV1U2MWxz?=
 =?utf-8?B?TThUOVA3RmtqWDBJRmUxcjNRKzVETEN2MHFGRUtSUmRjQnVKTm1JWCs5d2ds?=
 =?utf-8?B?SThHa3ZWYWpiRm5EL1Avd3doQ1VmSGNsVFVVVFN3MjdVQjM0RHlsTUU5R05x?=
 =?utf-8?B?ZmtSNGk4Y2o0WE1nbVdQS2hqMndUTXNJQkFlWk9RYm4wQWsvV3FyTk9FNVRo?=
 =?utf-8?B?Zml5SWtaK3FFOUYveEtRZ1VZdTRlaDkzeTVka21ZOWQ2MXZXbkc0ZHk3SnBI?=
 =?utf-8?B?K3I4YllOcUVobThZd0RMaktZemZQRHYyWWVlaXVtZWMyN3NuclJYRFJMUVJ2?=
 =?utf-8?B?KzlBaklNOXova1BsbFZaUmxIanB3K3dJUms0R3V4bmN1dTljQU9uTVlaY1NM?=
 =?utf-8?B?SjNqZWRhTzMyV015dDhkTG9jR1pYVlh2cHZ3clR6dFpCckRTejFLVnJKWUVV?=
 =?utf-8?B?OXhEendYRVJ3TUtqekxIanRjcTVUWWs3elhFa3U3eUpabm5Wd2UyS2hHUzB0?=
 =?utf-8?B?bXhXSVNpQ2RZclJDekJ0b0laVTdka2RvV3N0aEQwLzFvNkVxQlRieFI5Unp0?=
 =?utf-8?B?S1pPS3RpM3ZRVXQyRnY2cUdlRHRnTFJMWWtjVk00eWc3TVlsblBTcEpISWRT?=
 =?utf-8?B?cXlmUWZyTmNMNGlweHVTUnk2c2YyMWlnSXVGS0Y5bTR2VnBCRm4xTmRNYnBX?=
 =?utf-8?B?RjYrMEVCbXZhcWVZbFVJM0htNUk4OXhDVHF0N05XYStIM2laQUpZT3hVNXds?=
 =?utf-8?B?Y2RCcmo5MjdEQ3V3Z1kza2JpSXBpWXNzQU9JalU1YVdjSExhb0trZERGOG8w?=
 =?utf-8?B?dE44WDNkdFk1UERZa01nYzJ3eXJFc3VIUEo4L2kzZkZvdW5nTERqUDFRTHYy?=
 =?utf-8?B?NTZIdmsxenhESW9TdXI4UnBpVWYyRDdRbm9qWXRwK0dhY2JkYUxycUdRWEEx?=
 =?utf-8?B?eFFHZmdKbUl1MWljc3pLWEgvakszekQ4dEVyYTdFa2JlTEs0ejczUVA3Rm5L?=
 =?utf-8?B?RUFXTWtJeG5YTDFZRGRSYm52K0x4d3VadWJ2bU1zSHp0NWFLL0RtalRkc2Zw?=
 =?utf-8?B?aWVBRWlLc1FUOEl2czY0Z0dzZ1hIVEZuMFhWL1p5SEFOOHgvZm5yWjdBUUw1?=
 =?utf-8?B?MkhsSWNSWDQvd0FMOXdoZGVpdVk1OWtPb3VVWWw2V2pCamVBQjRScy8wbXpn?=
 =?utf-8?B?ViszM1UwRTdGQTNJN3lMWmVyUmF6Q29nN0hqR0w3MWI2K3luTVFDazZLUVVU?=
 =?utf-8?B?MlpTTnIvZ214b0tzcXlaVWpmWS9NaTc2V01scEJYUStlWERLdFRPTEZMcVpW?=
 =?utf-8?B?VVMzcGFTQlh2TGZ2b3pTU251QWFTTmd3dHhaL1AyNmt1dktUQ0V0NllNVEhX?=
 =?utf-8?Q?lnlyX1Vzlu4rEQeZ7G7etb3A7tTTjMQw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cENGR21hSHgzL1BueGptbW5uc3AvMXFLaHlRMnppR2xlNi9OMnhFK2tScG4w?=
 =?utf-8?B?YytndVlMZXhOSTcvbTBzQlJKcE95ZWV2QjcrdGswOWxLeENacTNyT0dzbzZQ?=
 =?utf-8?B?ZVN6ckpVY0UvRUZKMXJTOU00ZzJzWHRLMnJpUXA4WXZaOG5wWTlRRUQ5d3Fu?=
 =?utf-8?B?RjBPTVFFYTRBZ1lZTVFSR1hKN3dvemR2SWVOeUlscnZ0RHExdm1iU203Qm5v?=
 =?utf-8?B?cHFidHgxaXh0RkhEYWI4a2NUcGlJZ2RoMlY2RFlEaWhObm1rNTN6eVhNQTcz?=
 =?utf-8?B?Rlg2WmpodHpSbVBCUXMxMmpYenozNXRxMEtkeHVIV3FTZnNvNWRHczF6N3FD?=
 =?utf-8?B?VEdWbDRkMjR3TEZkd2pXUm1aVEl3R3lLMFFzTWhSR2oyejhXRHY5ODNwK2la?=
 =?utf-8?B?L2hSREF3M1cxV0dhSzY3RW1sUHhnUXNURHA2YW8zSFZPRGNyTDc2U0h3My9y?=
 =?utf-8?B?dWxFMHZNcUc4NytYSitYQ2hiR0hldUlGbnVNcW12TVFMM0dqRHBtZ1F0dVFy?=
 =?utf-8?B?eWNLWnFEb25YaVVLblFkSWM5YkRzYzJRWUZZUDRNa2d6RGd6NTRxOXZuVDJk?=
 =?utf-8?B?VkdwdExzT3hUMXJBdllMMy90NHlPZVFPeUpURlhQOWdyZUo5V3ZPZW5vcmZ4?=
 =?utf-8?B?RCtyUGUreitIQ0hCRFF6TjNjUmgxR0ZQRmtFMEVUcStzd1ZSTU9ZaFU5VDho?=
 =?utf-8?B?TkszZGxPSzJtM3VGTm95Wkp2eDhxVnFxM1gxU3B3Yng5ZG5iQUNvL0wveXgx?=
 =?utf-8?B?NHZocmdsSlFOMUsxSWpOblNYOWdCSzF4YSthRUNFUDkzTnRYUHdibjE0VWhp?=
 =?utf-8?B?N1g5NVlSbFhBUkhTdWdVa3ZESzQxWitCR3dhLzhNbDVGL3g2eU1HVXlaaVFy?=
 =?utf-8?B?bEcyL2plNzdJV2FEeVBNRnJpNTBiNUpzdEJrOTluU25jaUdYYWcwam4yaXRz?=
 =?utf-8?B?NkRlOUhVRWV1QjZrcStSWUlSM2QweHNZRnpVYis2UytJbU4ya25KbFJSRVZO?=
 =?utf-8?B?S3dKYXFhMGp1bFF2YTJzaEsrQmhETHRGZ2tLa01yeXdCSXFFdWpvQXIyWkFR?=
 =?utf-8?B?L1pqMTBsa1N1dXdxRjluWEZyQkhMT2xpbVdlSFF4dG8yeE9pM0tVeUdkQ1NU?=
 =?utf-8?B?Z2RRUFV1U3RBVEpVenRQenRqQjJlMWc0elRtSEtnSkdsRnlONG1PRlJtUS9n?=
 =?utf-8?B?UkFKVjhsM2RWME9WSnpNUWlOZXZIWTlPaXN6bWQvcWVVQjJaM0I4b0IzTncz?=
 =?utf-8?B?V2YyclM5TFVMRGlCZHk2bDJwMy9zY29zT1MyRVczc2pIKzMxcDBHL3A0LzI2?=
 =?utf-8?B?Z0ROUDJDRjQ5dHdueVhRbWExZXluYVpZYk8zRWhGdTdTaCtTY1ZhS1BBNVJm?=
 =?utf-8?B?NEJwSXVFbkI1K045MDN0dW9mcnU4TFJleWV5dzdIOUlmSGlibHdkUVQwSUhu?=
 =?utf-8?B?WTBPQXRRa3gwRS9HK3VtVllndExxYXVMSXBTZkdKK2FBTWxEankrL3A3TjUz?=
 =?utf-8?B?QWNWcXM5NytEdko5ano2WU9LcysvNWdBNFJtWUZnekVxdUxwaVczeDZTc1Vx?=
 =?utf-8?B?SzhSUkh3NFlydlQ3Sk40UUpSTy9abE9HeVVCZVJNMGFZc2pNdThBUXRhYmh3?=
 =?utf-8?B?T3hJWS9yOEtLaHZ0Z2pKM3h2R0FlQWZGMUxoQ1BEN0NxSTB2QjRlei83YWVP?=
 =?utf-8?B?Wi9HSVUyeHVuUVE3M21Ec1NYb3Q5dU5wUDV3WW9GREZGSUcrakF6OHBtbk90?=
 =?utf-8?B?dEIxdllNQ2M4Q0w5d0ZQbHNBeDBkaXlSMXdlUjR6VUdJb3MwQXFUY2NXRkxD?=
 =?utf-8?B?TzVQYU5LQ05sNUU0YkpMa3ZXcXUyL2VYYkl6bkdOVzdaUW1WeUozcFc1dVEy?=
 =?utf-8?B?QlFjNkVlVFVINUg3M0xJR2pac0VueXJoUGRYUzl1L0VMUWE4NnFvQlhOYjFX?=
 =?utf-8?B?UndIMTJFYlNTNjlmRnhhNTRNSVNhUW9oOGdLMFZpVzRZa1dZS0RnMWpEQkJT?=
 =?utf-8?B?UTRpTEc2dnJIYVI3aFQ3QkVzSjRCM01SVWtPcERBSE91QnlKWkRFZ3h4OGxk?=
 =?utf-8?B?TVNNdnZkQUJjWWl1SW9nSTd6c1d5TmNWUnBwNGxsazBpaWtlN0Y0M0tUZ3hH?=
 =?utf-8?B?R0dLVkUvNEMvejA1dks1MWozRHBuNm9vbnNMQ2FoSS92N0RwLzFUNytnM3E5?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd868af-c5d8-4534-b930-08de345c04ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 00:11:35.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9lWf29CAYAhfGTy1OB0cn0b7MYa1sb3RGUyQVywMsROtinjGVgZ+BhCPaKq4xeuAR6zXfRtibK48lJFGSzPJ/fxQ0YUpuSVaS/Z7sJ5q0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7423
X-OriginatorOrg: intel.com

Yasunori Gotou (Fujitsu) wrote:
[..]
> > > == plug - after PCI rescan cannot create hmem 6070000000-a06fffffff :
> > > CXL Window 1
> > >   6070000000-a06fffffff : region1
> > >
> > > kernel: cxl_region region1: config state: 0
> > > kernel: cxl_acpi ACPI0017:00: decoder0.1: created region1
> > > kernel: cxl_pci 0000:04:00.0: mem1:decoder10.0: __construct_region
> > > region1 res: [mem 0x6070000000-0xa06fffffff flags 0x200] iw: 1 ig:
> > > 4096
> > > kernel: cxl_mem mem1: decoder:decoder10.0 parent:0000:04:00.0
> > > port:endpoint10 range:0x6070000000-0xa06fffffff pos:0
> > > kernel: cxl region1: region sort successful
> > > kernel: cxl region1: mem1:endpoint10 decoder10.0 add: mem1:decoder10.0
> > > @ 0 next: none nr_eps: 1 nr_targets: 1
> > > kernel: cxl region1: pci0000:00:port2 decoder2.1 add: mem1:decoder10.0
> > > @ 0 next: mem1 nr_eps: 1 nr_targets: 1
> > > kernel: cxl region1: pci0000:00:port2 cxl_port_setup_targets expected
> > > iw: 1 ig: 4096 [mem 0x6070000000-0xa06fffffff flags 0x200]
> > > kernel: cxl region1: pci0000:00:port2 cxl_port_setup_targets got iw: 1
> > > ig: 256 state: disabled 0x6070000000:0xa06fffffff
> > 
> > Did the device get reset in the process? This looks like decoders bounced in an
> > inconsistent fashion from unplug to replug and autodiscovery.
> 
> You are correct.
> This environment does not support actual PCIe hotplug.
> Even if we perform PCIe hotplug emulation by manipulating sysfs, some CXL Decoder registers,
> which have read-only attributes, are not initialized.
> I confirmed about a month and a half ago that this was causing the hot-add process to fail.
> I suspect that such registers must be initialized by the hardware when a hot-add occurs.
> 
> I should have informed Wolski-san about this in advance. My apologies.

No worries, just wanted to understand what was happening, thanks for
confirming.

However, this does raise an important issue that tooling could solve. If
you are committed to unplugging a device and the decoders are locked
then tooling should probably arrange for a secondary bus reset to unlock
and disable those decoders. Otherwise, the kernel might have a hard time
guaranteeing that a removed device restores at the exact address it had
previously, especially when there is free CFMWS capacity.

