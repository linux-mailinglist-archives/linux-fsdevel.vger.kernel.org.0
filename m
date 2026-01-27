Return-Path: <linux-fsdevel+bounces-75671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL7qKVVNeWmzwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:42:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EDC9B783
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 164E0302AF2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611ED2F361A;
	Tue, 27 Jan 2026 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvFZmEA7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14832E62D1;
	Tue, 27 Jan 2026 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557322; cv=fail; b=RedlIyNRMHZP+nz5CxsUgXk2AsTSgOFtDD/4AjtlYLpY675NPwaoU2TXvbtD+7FB89OoZstg8U4SMVvw4EOOltzWN+NYUuCg9f12Ow8PCR9O1OOY0P+4orVuV0rOYFAvVR+jXiaNhQmfuhcUiw1sC5BQLEQTJDUmH4WdUYZxay4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557322; c=relaxed/simple;
	bh=BtG3kbuXer69qHy8OeRiauAFepZItWclMOyLyjfECBY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=JFErVWSamR8pzaZhD6H2Jw5ZR4XJZGvy42xFpl2Wbh2/rJcl/zgcRWnmkrfF+f0c8JYiK/b/gTI3ha8KcGOkm+mx22OF7hyy5C3R8H78uLnyqFsD0wYuDQ+stpZpUaPJe6zLjXf3TgJ/F0rxFmyMAESfBQj6+Ap+WOk9GKrwzag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvFZmEA7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769557321; x=1801093321;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=BtG3kbuXer69qHy8OeRiauAFepZItWclMOyLyjfECBY=;
  b=FvFZmEA7ETsZiZrMhVykhvb9nI1QBfllcWkdS2SHp33+OoleRr6eD7+C
   POya3RRIn3VIscaymFZj6o+kpOgJ9IxASeBMqbNKpwVBPmnbLKmR5tKYv
   0F2KSwBgd4UItC1xi5L4pdrMjl1JTy6GzVM2fAOnMl6PfLCt8vCyGTvyS
   0uz//TOI9q7nymQVo60wFnYZ6NUNBawBKdVpItHU3emyOKMJNrwlCgd6J
   zCIiF1ILzkU9y7qTgWd24o/wMDsOht02h0YCIchzIoQGLJOiu4ClQeScI
   c6+5FuUAAyWLhWtIN5MUPIp1BeH6V40cn+Ceb3cVrSaCmJMuF9fyMldgU
   g==;
X-CSE-ConnectionGUID: HbE9RpcRQqSwNpJ7srIvJg==
X-CSE-MsgGUID: EUnLMuazTaayKZBxXkVubQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="58338809"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="58338809"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 15:42:00 -0800
X-CSE-ConnectionGUID: L680U0LmTpezij8dmMvKXw==
X-CSE-MsgGUID: IerNvX6ORPmzL6t7AjF9NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207344366"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 15:42:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 15:41:59 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 15:41:59 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 15:41:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF9p38jekF6BqnjIK4d3os4qNxrooDM1yB15SdZ8rDivvILD3aurwBOgInPwbeBrC4IZi/tU7aVb+pvCbKr+s+yYfRq0FUu5QSj8FOsO5v6ELbz9pNsocgkfK3ezArSrGB2bwyHqTMWHuj6xVwaXs0AoeJHmDmo5LPNRcoRJD+WDJYUGE2FxkhuBZLVTZFt2tszKBW3fwQa4gefMtFy8AFW3XZ21Ki1+34Os8s74eka1wmpKyH+oQLu5CYatOR/ipRsiCgANQaha/nY06r7oIR9LB5Ah5vQvQAakFWBZCrvUKW+YVBj2FcJAOaxr+pjrRvLMBqjQknXCALSYevQBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdgDZYJcg0QnmcoQGlm/DZoteqxPsUPxk/dY/1rYgxA=;
 b=lQqufAMDmGu3MesPIaEKzXdbMP+eNuuTlScdR7poLWOh6Jo65Su8RmPppIhqlecTPMPKyAURWqKuEVeNFS1FjT2HbL9lWwDev7VSoGJG3E+9ZZtboi1k/k9d77HIoKiBw4yaHbe8VIja8YCNn6AMNU3xINGmkxmFzGmvt0H2YeFGViGM8NAPMqjJ/Vj3InPtjj1zepQAQ0ydL3lwLoR6mofeT60KgO9jdCbw+i3ikuwTLoOnaL6AO4W4eyHTj8eJEXxIHzvEfaHwKJMROZbw5kFESP39fP3/7NOtotVTnphdRKhIqB08Wn6TBgI5YqGctdekdSgBF8oXaNXSjcCvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF10012BF96.namprd11.prod.outlook.com (2603:10b6:f:fc02::a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 23:41:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 23:41:57 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 27 Jan 2026 15:41:55 -0800
To: Alejandro Lucero Palau <alucerop@amd.com>, <dan.j.williams@intel.com>,
	"Koralahalli Channabasappa, Smita" <skoralah@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Message-ID: <69794d438629e_1d33100f3@dwillia2-mobl4.notmuch>
In-Reply-To: <f4bdf04d-7481-4282-b9da-ce5fcf911af9@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <e38625c5-16fd-4fa2-bec0-6773d91fd2b4@amd.com>
 <84d0ede7-b39d-4a41-b2b6-8183d9ccbb9e@amd.com>
 <6977fe94d8ee_309510033@dwillia2-mobl4.notmuch>
 <f4bdf04d-7481-4282-b9da-ce5fcf911af9@amd.com>
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF10012BF96:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f774cd7-7290-4852-523d-08de5dfda8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWdwMjI5SEkyalpYVUpuTGJhNWVXdWpkenh2Wi90QXJtZXJ1N0xNQkpDVldX?=
 =?utf-8?B?RGpRa2ZhdDBmZnFjZTlpTEVwaFYzNXdGZjBpcm04dm81enUxQXNVOUR4ZmUr?=
 =?utf-8?B?ZFhtV010bHpYQkF1cW5mUnZXU2xGT0pUQmFBLzZTNnpiUnhDdkJ4bE5YUjFM?=
 =?utf-8?B?RGFCSmFraW5ydEt1MVdaVVdWVUR2SnVnLzRYR3F5MzJhV0s3WUNmejJFMXc0?=
 =?utf-8?B?WlFWajFiYXNHTDB0SjFyV05WZ2pVRGZ5V2drVEJKOEhIM3M1NUZYTVRvaVp3?=
 =?utf-8?B?d1c3Z1lIV0ovbmRKWVg0dGNJR2I4aisvNTkvOUcyRkh3WkFtV0J6blNjblNu?=
 =?utf-8?B?c2ZKdnd4ZWI3Y0dFVVBlQzFQL2xBQURlek5sem8rMU9PVTFjNHA5T2JBR3Zn?=
 =?utf-8?B?Z0JsUGtNOE1rVWMwdDhGQ1ppTE10b0N0bGQ0MGx5SVVXR2daei9NRHl2djE5?=
 =?utf-8?B?MUhieHJ2eEVjTnM4NXVxelhDL1NJVUNYbUJwQWREUmxzeVM5NXN2bklIdFY0?=
 =?utf-8?B?eXNVcTFGTlRpY3BBNVBXUysxSjI0U2RiTkhyY0JYWFpEOEkwbkxPMHYvYUVy?=
 =?utf-8?B?QW1LNyt1NjU4VEtmc3ZHdzZUSDZoL3pIUjFTWnpoc1V0WEZCa2Y0TFN1M01S?=
 =?utf-8?B?QzM3MjU3TkNvbEVIN0hEOXEyelByOHI3UEJvWnZjaXdqUEp3SWYrb3NObU9i?=
 =?utf-8?B?bHhyb2FXeldKTVd1aTFna2hyTjl2ODdyUUFNZnpidUdjdWVjTENKM2RpOFFJ?=
 =?utf-8?B?OEJIamZPa2xPVllOOENCOG9nbnhRZG12RElMcXorSGNQN09DWWNNdm9NUHdm?=
 =?utf-8?B?bml4TjNaNkJsYVVIeVZCOTEvbWt4cDNvVk5jWnJuYzVXT0FiRmJKNEZjOExU?=
 =?utf-8?B?REtFbXJFTjZCRDE0SURybGk5aVdETXRLNVlibUJmcDRDQzlQNXFEeXQxRkVB?=
 =?utf-8?B?MVRXRTd3ZWVtUnRHWklsQW9mYVFSVDVaMlREZk5leDlhMDJDZjdFZXZkWm5S?=
 =?utf-8?B?RHF5dXJKakJobkFzd0E0OGVFbVliWTVpdGprZjZsUEZaZTZOZGRncHJsYkhX?=
 =?utf-8?B?NHVmZjlEYnl3VU01dU1qWXNvQnFZZ1FFS1lKZVYycDY2ZkF0VTVndTZVMGtP?=
 =?utf-8?B?dG03dTdET1FHMHRkQWVtbndJcFBTTUVyV24vcDFqSWFvdDVTZnJ0R3o4eEdM?=
 =?utf-8?B?VmNxbVVMcFBrb1BOVmtWQUswc1VoaUdoY09LaVNTRHAyR2l2c1VOREs4U3Ra?=
 =?utf-8?B?b1BGeFBZZCtEQUxHSDRveHRwakt6QjZsdkREZFJCc05YMUl1MXo4Yk1FcVpT?=
 =?utf-8?B?ZDhlUllHM2xHdTBWaWppckRzVzhqMjFFSFAwbDVrMTZnYklGUHNPNkJGbmZj?=
 =?utf-8?B?VGVhT2lDeUIrWHl3K1M3WEJwMmFQd09IekxiQm9ZSjk1Y1FBTkhURDBRVkEv?=
 =?utf-8?B?NnIwV25TRG9UcitLemhSVTNKK2oxR2I0MVdxMzBldTdqT3NHK1dsM05WMGdn?=
 =?utf-8?B?QmFVUzNWOVVBRURaU2Jna2VQZFFsUzQrRVF1TWZGQ25ZNTNNVkRKWU1XVDVS?=
 =?utf-8?B?d3ZZeTV2YlhwVThXZkQ2WlFibElkaTU5Ymw4VHpIN3ZWVWZua2kyaHo2R0JT?=
 =?utf-8?B?MGdzQnJBdTlqa1dhYUhLTVo5SWl6YTY5SXQ0ODUxcHdzcFpZVU9SWk45SDJ6?=
 =?utf-8?B?cFduU3gxT0VBTldmOXJxZnFKbjdTbXovU0RrY05xdTRXczBLTzJvVkt6b2JT?=
 =?utf-8?B?alRDSjBvSHpmMHMyQS8yczRKRE5IaGJYWnVORkgyMFFoNzQyOExabHBnZmNj?=
 =?utf-8?B?MnBKNUxTVWhVd2doM00rSVYvSEV6OTFjKzlFam8ya0x2djNudUprTkdCbkcz?=
 =?utf-8?B?dW5qZEhNRnY0UDlpcHFXUXAybk56Y0R4NFdLWXFxWEpRa0x6ajR3b2pDUzlB?=
 =?utf-8?B?S0pnNDVGUDhNV2kwUlBCNE9uZFE0V1lXUkcyRms2bjVkWVFWeUVUMERQWU5M?=
 =?utf-8?B?bllnRkFvRWNXRkZ1aVdhMmRCZVlRTkF6Mzd1dTFydm1BeHpsTlY3K0YxYUN0?=
 =?utf-8?B?cGE2QUpQUnRFRk9abHJpRHJoYS9vN2gzYmtKSzNRSHU2QkpPWGNtdzdEQkpi?=
 =?utf-8?B?RGYyQyt2Z1lqanQzOFp6TUtiT1FuRWI0N3dwUkpsRENHM2N2VG91TzdNVC85?=
 =?utf-8?B?RkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZuZnJUcms2RWpBeEczYXAxVlRMdzRLdnREUU14a0EvKzRHY09oMEphK2Fn?=
 =?utf-8?B?MWlBeE84c3ZsZldEdGFsbjR4NFJjN0dldG9wV1dOa2hURTZjOXdwRE9ob1J5?=
 =?utf-8?B?VVVvQjBTNWd0S2JiTXQ5SnZReGMrZ2k2UmcyOHgvT3hqMEZ6NG45S2p2NVhk?=
 =?utf-8?B?V2dBNFFDT244bW9hUUFYU2tnVkl3eW9mUjNIVUJzTG5nRm9tdDVSMHk3ZG96?=
 =?utf-8?B?enhOS29NWGNpajBoMkVxVkJkbE1lRUlrQ3UwTGxaN1FuSGU1SEQ1TTBmbzJo?=
 =?utf-8?B?NDdpLytlLzhOdXdnUU55QXN5N3FleEdZc3B6ZS82ODRmYnNqOSt1d3VzQURE?=
 =?utf-8?B?UHVFZUVFT1RJRk8reHg4d04xbGJPWmdxV0g4cDh2UUlXREZVdG42TEVqaWRR?=
 =?utf-8?B?bVoxa3dRNE9URW9VQ2lrd2I2NnB1RFRaRzlwNUg0ZUt1Qkt6KzNzakg1Uk1s?=
 =?utf-8?B?R0MwV3JBb1o2dXJzSDJJWDZFTTFEd2V1ZTN3NC8zYjFvTWFvZkJsVmNVdFFy?=
 =?utf-8?B?bHlLTE9ybnFqTjIzczNnMVlpdjliRXhQVTJVOU1BS1R0RlRMaVVFNmhTY0RW?=
 =?utf-8?B?dlpHakMycXg4VVF4aVlTQTFRcC9QOEJnRm5wV3ZWNWxzS1lXNkJlSEg3RHp1?=
 =?utf-8?B?R2l0NjlnVUI4dU11KzNocEQxVVllSGg1dnhScHF6cjVVWnlTMlMrdTdSOTB2?=
 =?utf-8?B?b29veHpDZDd0VVpzZkNvQTRwWUxKd3dPU0RldVIycFp4cW1kazBuZ1NmaTFG?=
 =?utf-8?B?MzNBQ3pmbWlvMEFLN05vTnF1eEk2Y3N0YnlmZlRubDlUZnBMRFNpYVdMa04v?=
 =?utf-8?B?ZERaSFdFajVXS09xV0NmTlRFSDAzelcxeTMwZjVRSnpwWjBLU1IyN2d6c1I3?=
 =?utf-8?B?V3BuWFB0OVBTK00rdmNJS1hOdWNSOGpkZEdzdnhtSkIwQjRVK0hJa1B3QlV4?=
 =?utf-8?B?TzYyY1JvNU1BemlabnhxUkhaWC9XdlZOTzcxQTJ4ajBWQXhYNEJCcXc1Vi9m?=
 =?utf-8?B?bHgxUjF2cTFBbERza1hQTG9ESHN6cktreFRraHAxU1l3d2U2ejhZQnlOVmcx?=
 =?utf-8?B?dWpURmNEYk1COWpCZW1OVGF5NDduK1I0V3ZnY3h5aG81dUQ2aVY0SFBkTkI2?=
 =?utf-8?B?V05aMzJSaTZySWR0R3dDMGJ6L0VFMVFZU0dWeWwrRmsvbkFWcWRoUHdGNnY0?=
 =?utf-8?B?NWZwRFkreU5RZWlITFdQMnNBd1ZZV3JiUmVBejFtRGxNblVWTFlvQUZRTExo?=
 =?utf-8?B?NVVGeVBBZXUvRlRwK1NxYnp4MElWcytMU0VyWk81N1Z1a203emFoZTFacitv?=
 =?utf-8?B?czJZZVp5YjFoMHAwRGx6cVFFanliNTFKWVpuaW1QcmY0Qmk5OXFaY0pzZ3Ry?=
 =?utf-8?B?cGQrY2tMYk5zU1c5OEhoRDFuSkZRcUQzbFhLZE02YUJUMXJpL1BuNUd6MDJJ?=
 =?utf-8?B?emtOWURUeTNDOG1DQTJISmNIUE1WMlN3bWpubzgzanpmK3Z2SldDQnA3Mkxv?=
 =?utf-8?B?U0JNMHRUTmJXVFlUT2VpeEZ4WU5kRFBIcGJPVFRIcy85R1dFMElnQWZCd3J6?=
 =?utf-8?B?ZTkvRGNDNHBYT3dXQWF6cWZqMkZkeGxoazQyWnFZcWVUbVlMa1JJLzRuY2hG?=
 =?utf-8?B?QU9URkRWNDRxc0txR2YvVlMvQUE0aGZIL0k4Q3pIWExhU2t4dmd6dEpCc0pw?=
 =?utf-8?B?TWdQV3hvZ3ByN3dTL0tPOWJsdVQyeENocmdFK3NxT0FWZVZJZG9IVVpYZkdM?=
 =?utf-8?B?THJoMTBQVjc3R2dXaHRUbFlFcnN2M3JJSmZVM3dkaGdXV2FXMTNOQ2NJUEFE?=
 =?utf-8?B?YldPTUpXajFHdUhxS1dVZlRPaUZzMnBpZUhzTmlRaEY5ODQzOGpRbmQwVk9E?=
 =?utf-8?B?WmI2WnNRVDlXcUJ4YngvSUxoc0Uyc3FOc2huN2M4MW9CcEx6QUE0T0YvK2tS?=
 =?utf-8?B?aUZMSWs4VElXOG5GQnVXU094YzhESzY2Ym8yUWJ2SUdoMVVRMnk2ZnhDOTl4?=
 =?utf-8?B?T3lrb3hVZjJJRzdxajErMXdxa00vVHU4Rmw2WUxCTDhwSldwWGQwazBaVmpl?=
 =?utf-8?B?R3RyVlNQT0JXT0Z5dTVGaXRIR2d2b2FwUDdpWWJmekN5NG9sNFZMS0YwMDhj?=
 =?utf-8?B?YmpGOUtnNHA4ZVdTWU94dXNqaW80NHFQZUgxTnBUSEF4ZEJWSllROVFOTlVy?=
 =?utf-8?B?dVM2YnV2eHlKdmlGeUhyd2ZDQktsNzgyaDF5bFBqN3FBQXdWZldHNk4rU1NT?=
 =?utf-8?B?MlYyZmxZQU1PZWZNakR2VW9CVGJJbG15eTd5Ym1iYmxSYWEvSzlJWDNJaEtq?=
 =?utf-8?B?SkROSDVzNVMwM284cTE3TzFPRXl3cDVadWsycDJTcHZva2txd0E4d2thY0ZH?=
 =?utf-8?Q?0Umz9jhyWEMRlhLE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f774cd7-7290-4852-523d-08de5dfda8b8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 23:41:57.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjWIzBqg9vegmvsgFUVy7MqGrZeYhr/EtUd8My0fIunF724Z0ZIJphixuS4uHHlpZ+JcfO6Zu0cby38A4cZHGZWH90xeenRJH9PG9xrMTAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF10012BF96
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-75671-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 24EDC9B783
X-Rspamd-Action: no action

Alejandro Lucero Palau wrote:
[..]
> I will take a look at this presentation, but I think there could be 
> another option where accelerators information is obtained during pci 
> enumeration by the kernel and using this information by this 
> functionality skipping those ranges allocated to them. Forcing them to 
> be compiled with the kernel would go against what distributions 
> currently and widely do with initramfs. Not sure if some current "early" 
> stubs could be used for this though but the information needs to be 
> recollected before this code does the checks.

The simple path is "do not use EFI_MEMORY_SP for accelerator memory".
However, if the accelerator wants to publish memory as EFI_MEMORY_SP
then it needs to coordinate with the kernel's default behavior somehow.
That means expanding the list of drivers that dax_hmem needs to await
before it can make a determination, or teaching dax_hmem to look for a
secondary indication that it should never fall back to the default
behavior.

Talk to your AMD peers Paul and Rajneesh about their needs. I took it on
faith that the use case was required.

