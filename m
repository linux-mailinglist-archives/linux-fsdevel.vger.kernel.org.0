Return-Path: <linux-fsdevel+bounces-55186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7777BB07EC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 22:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29294A7B2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 20:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C612D77E3;
	Wed, 16 Jul 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jscN9cZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7CC2C158B;
	Wed, 16 Jul 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697274; cv=fail; b=edOXEDJo9s2Rff0aNk8giSxgOzR832qXkQocEyJAO38rWiEQb/kjzSdOy3Ez4hXPgtBvn7AWg00GbCL0RVcbriuMXbkap7wZ1Z0jUNTXDOXeOeI3PZTBh2br+rfzBfuoJjuydlqhsj4Y1anVKxt0S5KrK4PgHqq2QCnCny59KII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697274; c=relaxed/simple;
	bh=tJ55tMqnX64nF6r+mEma7GBbBv2aY1zP+/Fpqa8vfDc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ivcdNLDJhvll+h9z1X2LuN+w9sI7qiT/fQFT07ySDSgAgaAvNbgQ3CjK0mQOfq6y0pV5jE55fNJe6E8dR+2IOKQcZsGCTF1AfgIXceV19abM3CXmSjCPiS6K0J7ha5v2wShFIIHu62RTMcCI1RWbKnT6JgyQsToYw1q8alitBW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jscN9cZh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752697272; x=1784233272;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tJ55tMqnX64nF6r+mEma7GBbBv2aY1zP+/Fpqa8vfDc=;
  b=jscN9cZhO5s5cTBZkyjFaA+VO1PU7pnme55vGy3xwfIwFaMC2r2FtRf1
   mWKkLLWYDXnu83HkltZsfLREmo34fzq6R5j6fN9PZAJXLx27dbZo9ChMl
   Klb+ZX8aGvnw/atgWAN7z+LNfvEJ1jWdoNjJtc+xhkC0xOu2NifSwwLZx
   UkQ5jeiy52eFnWoZS9dnPgWfyB9VNzpo33FjPzLmyfD41oB53vWltviAt
   +uCi5oS/nEl67iJBDETYFg1diN8dyjZyfS/pnefK6pTQyui/50ZVOXlMo
   d0VQbPzQP1EwysA/vgGI4DYTC++xJ5LKwtNiMN5y2ACcLVD2sPMP/G5Ok
   Q==;
X-CSE-ConnectionGUID: DcsxBW1/TMCeXUvhS3HOvg==
X-CSE-MsgGUID: YPvc/OjgTruOsPdZtwnJqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54675607"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54675607"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 13:21:10 -0700
X-CSE-ConnectionGUID: Av62Ih48R2GC2jaSCCWnug==
X-CSE-MsgGUID: mzl1iEECQA6FC/ScRFMOog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="188551912"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 13:21:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 13:21:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 13:21:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 13:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7NF335RPXebennCxE10kRQoggTJhNo/NkpEG590At235rtuw8HWo4KF5Mj+4VhhWdcI8PMIkXkuuM6dWzvn4+brbFIbysu2SOAUx6wTtRom9AUUR3Mvbdxm/3I4F+YZEPcqYDEzNH2HrzDW2E5T3YioeGqtLNssxurogS/BN4XVpMAH8SJ4vdtMVS4ILYhVxL+tenySPsnAJHNnrJxrP8lIT+wyzZlLB52CiqtZIbBH4QJVmbr5yVsjG1p7qlgPksz7VXQ1VFPgxS0a5RY+AZCApVYxV0pEo0xUYiRo+vixgXn0ILJkUwjE66n5+2X707jx9wo1zwTgicRorwn/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZH1Slm/ZAi0pyxgBOlX+WYrp0Cucrd99Y76nnY/VuE=;
 b=WZ/eVcqQz/0kEs3pQubmrvi3dE5ZbHkmS7vbA+QPMr+zPzCXNNrv2iT3WsapD2XciUcDuoAbPidcEMHPpBrus3rGW2KE3tAs+siZ7/OSafPs4o3pvhZBuT1bXQOd9QeWtF1mHF2oe73xyX9abqKzWjKTrU9g2wLwerxcb/P+uJQPxQcLuOC1UUxegYo99+OJiy6F1a2qakxTE5bxcrq73jM+ku4SFMIb2AYnbYwmGkiVVS4CEE0rHdLR1+CufUnoDU4NAgpX/2XdYYEgygyiMp62BsH7anScxph1D9qRemsxgnplnns+uqvpBtrgs2sPkrRucRFS3tdohXNQOWexVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 20:21:07 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::6bdc:278b:bb01:2da6]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::6bdc:278b:bb01:2da6%7]) with mapi id 15.20.8835.023; Wed, 16 Jul 2025
 20:21:07 +0000
Date: Wed, 16 Jul 2025 13:20:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>
Subject: Re: [PATCH v5 0/7] Add managed SOFT RESERVE resource handling
Message-ID: <aHgJq6mZiATsY-nX@aschofie-mobl2.lan>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <aHbDLaKt30TglvFa@aschofie-mobl2.lan>
 <4ac55e2c-54a9-4fab-b0c5-2a928faef33e@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ac55e2c-54a9-4fab-b0c5-2a928faef33e@amd.com>
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|DS0PR11MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 11849798-bd59-4b18-ae0c-08ddc4a64b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzVOWVRLcTdYcUNiRCtteUZxZ2prQ1FWa3VrRXRrWVJwbnp5MGpiQVZhNkNR?=
 =?utf-8?B?YlI2Vk1TUy9HR292ckRmTWNrbS9FR2MrVHM4d25kdlpwemU0MjdYVEptbWRE?=
 =?utf-8?B?cG01emo2OGlibFg0RS9Yd2g4YWwwZ3VnMm5BdW1SK0E4VjVLSzRjcXkrMlVD?=
 =?utf-8?B?TmJmSGdFaUFGQWpiWXgyNkdsMTE0TVd3b1l4Wkx0dDAxc0xFVU5EY0dybDh3?=
 =?utf-8?B?amx4MGMxSUZBdFdHaDE3emd0SkhicVlHUnJlZWVNbmF2VDVKZ2kwWktmVGRT?=
 =?utf-8?B?OCtYY0M5RTNMTlJpd0pRK3pxc2JNaFlHNlFRd0gvS2pDMzd5OGlxUlg4K2Ra?=
 =?utf-8?B?QVY0L21UUlprMFA0WERBaXYwTDN0OEtYV2RzVFoxMGUweVhpeTNiQXhSYnR3?=
 =?utf-8?B?bHBJd280UzYwODZPTlBJdnNvUWdNMW94akhMQkZoUFA5VExsM2g0Tnp6MU13?=
 =?utf-8?B?STVBak8rZUs0bEVwZ2EzTGR5RGN0S0FyV1hQSVp0UTRjVjh2NDNFVnNFcXpx?=
 =?utf-8?B?RXJvdmhMZWM0eDdXdm5KRHRwT0x5NDBhdTl1SU4zOEM4YmZjQ0ZJUDZ6QmV1?=
 =?utf-8?B?cVlTb2JXbFdGUlJ2M240eVQrNHN4T2RXNHRBa0dLc2dGaVNWT1RCRWh1T3Ay?=
 =?utf-8?B?eEFiYkE1aExFTm52L2ZtSUdHcEsxekZ1N09hVmxnOXJGVFhYSmZCa1VmMy90?=
 =?utf-8?B?aTlIc1RwenFPZGIxQmUrdmpiR0R1WkVWRlFPVkRPSHgweUFub2d3STQrT0xs?=
 =?utf-8?B?OUtYSFBUb1pFV3RVN0ZETnFGUEFLUlBkTmlCdEl3a3pjcnhYcFk5S2xBc2FK?=
 =?utf-8?B?YkZOY1pYU0JNM2RqSVRTeWhQNXhtRjh2TW9JT1NqVHVjS1E3WldhWGptN1Ji?=
 =?utf-8?B?ZEo3TmhQTTZqVXlhNkp6SnFRMzdIK3krVGpWdzgzemx1UURmZmYvRGVWMU5U?=
 =?utf-8?B?Q3pUQUppZE9OZEdFTVdZZk82TUM1c1EvN3NtZ0hBa1pWeVo4R2pZTklhRGc2?=
 =?utf-8?B?OWd4QllOMnB5RTBmbEU2VWF5WEFSL21RNFNoeHFOb3ZFOC9NcFhFdDlNQjUw?=
 =?utf-8?B?WjlnYUlhU0VZYndWMGhtNnczWDNqRm9tSUNHSVMrK1g3dmE2a1NYSnlUMHVX?=
 =?utf-8?B?OXBHV2FDbXZYdnIvR0REejZid291OXpZcVo5YUMyYnhnUzhMTS84SHFYeXRv?=
 =?utf-8?B?dC9NREE4dGlYd2F1eWR6KzQ3WGhYVUhMeGJSeCtlM2pvSWpaTW5na01VQUVS?=
 =?utf-8?B?K20wRksyNjJEUlcxSmE4MC9kS0RIRHRUM2x3amZUdVRxcmF6aVMyeFgrUXY4?=
 =?utf-8?B?VExCVXRmQytpK1FYMVBwY1NCOGtGM0R2VUhSR2QzNWdRTktxTWJ1SVVGSHI3?=
 =?utf-8?B?eEswT25oRytWeUNBYkpUYjBVSlFSVUp2QWd1RWdQeFk3SjZ5M01NWXdYaUNr?=
 =?utf-8?B?OVpnM3lBOUpiTWJaRVk3K1ZPN2lDK1l3c3Y2dWJWUVJ2SGVpK0h1N3d1Rks5?=
 =?utf-8?B?RVlsZjU1U2ZIYm9hQ2c4ZS95M2szQ21CZFZFUldLS1lCNkJTNEJwbzJaaTJN?=
 =?utf-8?B?Snc3UUsvd2hqTnltT21sT3RHUUNYL3RIMlZkblNmU0RNenN3SnNXeDBNVnBa?=
 =?utf-8?B?N1ZSdS93cVByK1VsL1VOWmZWUUxnbjBWQzlFcSt6K0tXYjJ1K29TRnUvdlhO?=
 =?utf-8?B?R0M3SG9sL0E2ZzlBNzdEMkdvQURpWEtPbnVLT0NVQlZvTk5seFlsTVdBWmpD?=
 =?utf-8?B?cE40RXJ6ZFR6RWJiOE1qQUZKM1c5QUw2MzluOGpNSERnU2EwVU5XbU03bWZY?=
 =?utf-8?B?eG9GYkp6QTJBSHdxT0dKMWloTW5Ic09UN2gwQ3cwdlB1QVhwTTNkaFF2cEZn?=
 =?utf-8?B?NEcvcTRzcGVsNEtDckp3cFhiMGNiaXNmSGVKN3lRZ29CWG9VRDNEd3FXdFdi?=
 =?utf-8?Q?D1qtF0PP4LI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGRnN1BSRFNXZWE2eHZnN2hLd2FkVEo4TkcyeVZJTjZ1LzZuRURFRjdWdWRO?=
 =?utf-8?B?aUVydmNRQ3NMVDE5eVp6WnJLTW4xUHplNHpYSitUUi9IdU9Ra0l0TU5WN24w?=
 =?utf-8?B?UmdkcEgzd3NLV3F4TXpYd3lzZTlzdnJEQjNFMEorYjdOZ2J6TWQ4TDNmejlr?=
 =?utf-8?B?Zy9ad1YvTGZHN2FjUlpXYlVjN0loM3l6MjFEZC9wTVc5VU50c0c1S0NjZFhP?=
 =?utf-8?B?bVVMYTlhR2d2dEJmVGlNSjB3bGFsNFQ4STRFM2N5bVdSNkRpdnZpOHNwVDJx?=
 =?utf-8?B?elJpMWQ0ODg5cVFMT3g4Ty9wbzJoTzdJTGVUOE8rQ1BqYkEzWWFjOURuT3Ev?=
 =?utf-8?B?RUdiRnp2WUNOODJKOWF3WXdES0pZMzloV2tERjFMKzN1VnA4QnJRaWFSb3BN?=
 =?utf-8?B?T3E0N3ZjUmJXR2JIUkNJK0YvRFlGZkFUUmxjZGVzUUxNcm5YMDJWZzNKYWVa?=
 =?utf-8?B?UUNFY2tNNUhpMHBNdURRNG9nS0F0Z2g4UlNSNlJqUytudmZRNU10SmI4bGJh?=
 =?utf-8?B?bDNveUVlUEEwaytmOXNWTi93UzVqcWFrNStuU3BRZTlINGxUeTZ5ZU8wUGkv?=
 =?utf-8?B?OWdXeXNCdEhGV2ZSRVJBRHlNM1UzbThQeDExdkRJZTJTcCsvaXJ0c1pyY0ZO?=
 =?utf-8?B?L2NqZ1lKZ0FPRXN3SDNWMjJzZExyampWYSt2WmtRd3c1Q1A3Wjd2QjNCWVhY?=
 =?utf-8?B?Vnp6WVc5akh2SUp2M2Naa0czVEVFS3VnQ0wzaUNIdjdmRnp0MWpsMjF5NDN5?=
 =?utf-8?B?dTc5VHdBcExKOXJJcHdQMDBjYUtXK0JsTTFHNWJXQUZHOUQ4THJFODcyNlJF?=
 =?utf-8?B?VW04Z2s0VlJhUXFjdC9Vck94UGdheWZWWkRRcU0ySXNaYXBwUklzTDNyK1p0?=
 =?utf-8?B?eW1QL01ockZFWXBscEdLTUdpalpacWk2amJBSGtUS252OVFsZW5uc0dkQUJ3?=
 =?utf-8?B?TUw1dTBSMEpWemliRWUrbnhqenZHN2tmL05CTmc2UVZ2WnNCSWZ3VExoeXB5?=
 =?utf-8?B?SUdVUTNoMDZ2bFJUTVJFWTdiMXZuUU84VGZSalF3K1djVGhsblBORWhuQjFZ?=
 =?utf-8?B?TUYxYWFlVUZlWXZKdUJZekJ0cTVNZjZUckozaW90NlQweVVaMmczS25vWjZC?=
 =?utf-8?B?RStYWDMxNUxsQ1RMVUptQmhaalJET0JrUmpVc3VveXZONWdYWTRkYXZpdjhm?=
 =?utf-8?B?VkxwSVFDeTV3OXhKdCtjMWJrRTVNbE9UM28vYkNXVVJuR3I1SzY3UWVXbmxG?=
 =?utf-8?B?dkJ5bHMxTWlxdjF2VDR1Q1MwZ0FzTkhTeTVLNEd2RUlMZU1GUEc0cUNSaFMy?=
 =?utf-8?B?OUtJQnJlcEpGZktlNUZoV1B6UVBVQ0ZsL1lKNzlRSUNJQ1hQRnFMREYydjNo?=
 =?utf-8?B?bHIwQzFCSWxEUXlzQjY0VUZteDd5S2QvSGdPRWFBRzVQMVVCMEJ3bk91OFRJ?=
 =?utf-8?B?ekVnVllYVWF0Sm5hOGR0cGR6bk13ZXlWUG50bW1vU0RJcEh5SXFQNUUwMEhi?=
 =?utf-8?B?WFlCekJ3ekFqNHN3UnA2M3BWYlVacFMxM1pQdzFQeGJMQmhNRUlqVXZEb2N4?=
 =?utf-8?B?d1V0Z0lLVjE4RzJBOEdpclRRejVLbldmN2c4WG5Sc0hMalF2V0RQT2syd1pK?=
 =?utf-8?B?ZjRPeDRScDE3V1Y0Q08weDNTTFQ0Snp1d3VzSEFwVXBHZkNXWGVwNkJFT3oz?=
 =?utf-8?B?b2J5azJaaTZqNTdEdkx2OUFKOUJaNnpyaisvY0M1bWg3aXpXd3ZuQXB2VSty?=
 =?utf-8?B?TEZ3VkR6bmtKYkNjOEx4Zko5U2N1dkNFQ0Q0bFQ3QUNpT0hRWDVScTNZWHpo?=
 =?utf-8?B?NExxN1NjS2VzMU5wWUx4WE5YZFEvVkRic09oUm5nRHY1aUh6UUh6VUpWNFVY?=
 =?utf-8?B?R1k4dWI3dHVjVDNKczlYVjRoTGdMSE5CMlkwVlVUVXJ2TThEcHFlV1hWL0xZ?=
 =?utf-8?B?MVZiSmVyR2hEQ2EyKzMvY2ZkYzRNOHV0aUZwdFdPUDhQSDhVUDhqeWh1Vjhu?=
 =?utf-8?B?L1RjdCtRTmowcm03dThLdUNvSUNUNGZNNEt2czIyKzZJU0FNZk1wcWRzY0RM?=
 =?utf-8?B?NDErY0hKckV4WTBoVUxoRGREVU5PT2RnLzRweWlTWmpicURuT01hbWEyS3lB?=
 =?utf-8?B?SmdMc1lGcDZrakt2UjZYcnczU2E1aU41Z0FSWVRJcVdlWm1OUytQQUtGK2Mz?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11849798-bd59-4b18-ae0c-08ddc4a64b9a
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:21:07.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5ZmjgTULF2Ci7FVTXsHFQp/mLy5H0zqzOBOaF9/ykl+lhgYXsEt96O4ckf3UcrYNzpnctq5Sv7FcVkkANBIpd5s8tNlmZtYmsc0zFg9m8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
X-OriginatorOrg: intel.com

On Tue, Jul 15, 2025 at 11:01:23PM -0700, Koralahalli Channabasappa, Smita wrote:
> Hi Alison,
> 
> On 7/15/2025 2:07 PM, Alison Schofield wrote:
> > On Tue, Jul 15, 2025 at 06:04:00PM +0000, Smita Koralahalli wrote:
> > > This series introduces the ability to manage SOFT RESERVED iomem
> > > resources, enabling the CXL driver to remove any portions that
> > > intersect with created CXL regions.
> > 
> > Hi Smita,
> > 
> > This set applied cleanly to todays cxl-next but fails like appended
> > before region probe.
> > 
> > BTW - there were sparse warnings in the build that look related:
> >    CHECK   drivers/dax/hmem/hmem_notify.c
> > drivers/dax/hmem/hmem_notify.c:10:6: warning: context imbalance in 'hmem_register_fallback_handler' - wrong count at exit
> > drivers/dax/hmem/hmem_notify.c:24:9: warning: context imbalance in 'hmem_fallback_register_device' - wrong count at exit
> 
> Thanks for pointing this bug. I failed to release the spinlock before
> calling hmem_register_device(), which internally calls platform_device_add()
> and can sleep. The following fix addresses that bug. I’ll incorporate this
> into v6:
> 
> diff --git a/drivers/dax/hmem/hmem_notify.c b/drivers/dax/hmem/hmem_notify.c
> index 6c276c5bd51d..8f411f3fe7bd 100644
> --- a/drivers/dax/hmem/hmem_notify.c
> +++ b/drivers/dax/hmem/hmem_notify.c
> @@ -18,8 +18,9 @@ void hmem_fallback_register_device(int target_nid, const
> struct resource *res)
>  {
>         walk_hmem_fn hmem_fn;
> 
> -       guard(spinlock)(&hmem_notify_lock);
> +       spin_lock(&hmem_notify_lock);
>         hmem_fn = hmem_fallback_fn;
> +       spin_unlock(&hmem_notify_lock);
> 
>         if (hmem_fn)
>                 hmem_fn(target_nid, res);
> --

Hi Smita,  Adding the above got me past that, and doubling the timeout
below stopped that from happening. After that, I haven't had time to
trace so, I'll just dump on you for now:

In /proc/iomem
Here, we see a regions resource, no CXL Window, and no dax, and no
actual region, not even disabled, is available.
c080000000-c47fffffff : region0

And, here no CXL Window, no region, and a soft reserved.
68e80000000-70e7fffffff : Soft Reserved
  68e80000000-70e7fffffff : dax1.0
    68e80000000-70e7fffffff : System RAM (kmem)

I haven't yet walked through the v4 to v5 changes so I'll do that next. 

> 
> As for the log:
> [   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for
> cxl_mem probing
> 
> I’m still analyzing that. Here's what was my thought process so far.
> 
> - This occurs when cxl_acpi_probe() runs significantly earlier than
> cxl_mem_probe(), so CXL region creation (which happens in
> cxl_port_endpoint_probe()) may or may not have completed by the time
> trimming is attempted.
> 
> - Both cxl_acpi and cxl_mem have MODULE_SOFTDEPs on cxl_port. This does
> guarantee load order when all components are built as modules. So even if
> the timeout occurs and cxl_mem_probe() hasn’t run within the wait window,
> MODULE_SOFTDEP ensures that cxl_port is loaded before both cxl_acpi and
> cxl_mem in modular configurations. As a result, region creation is
> eventually guaranteed, and wait_for_device_probe() will succeed once the
> relevant probes complete.
> 
> - However, when both CONFIG_CXL_PORT=y and CONFIG_CXL_ACPI=y, there's no
> guarantee of probe ordering. In such cases, cxl_acpi_probe() may finish
> before cxl_port_probe() even begins, which can cause wait_for_device_probe()
> to return prematurely and trigger the timeout.
> 
> - In my local setup, I observed that a 30-second timeout was generally
> sufficient to catch this race, allowing cxl_port_probe() to load while
> cxl_acpi_probe() is still active. Since we cannot mix built-in and modular
> components (i.e., have cxl_acpi=y and cxl_port=m), the timeout serves as a
> best-effort mechanism. After the timeout, wait_for_device_probe() ensures
> cxl_port_probe() has completed before trimming proceeds, making the logic
> good enough to most boot-time races.
> 
> One possible improvement I’m considering is to schedule a
> delayed_workqueue() from cxl_acpi_probe(). This deferred work could wait
> slightly longer for cxl_mem_probe() to complete (which itself softdeps on
> cxl_port) before initiating the soft reserve trimming.
> 
> That said, I'm still evaluating better options to more robustly coordinate
> probe ordering between cxl_acpi, cxl_port, cxl_mem and cxl_region and
> looking for suggestions here.
> 
> Thanks
> Smita
> 
> > 
> > 
> > This isn't all the logs, I trimmed. Let me know if you need more or
> > other info to reproduce.
> > 
> > [   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for cxl_mem probing
> > [   53.653293] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
> > [   53.653513] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1875, name: kworker/46:1
> > [   53.653540] preempt_count: 1, expected: 0
> > [   53.653554] RCU nest depth: 0, expected: 0
> > [   53.653568] 3 locks held by kworker/46:1/1875:
> > [   53.653569]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
> > [   53.653583]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
> > [   53.653589]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
> > [   53.653598] Preemption disabled at:
> > [   53.653599] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
> > [   53.653640] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Not tainted 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
> > [   53.653643] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
> > [   53.653648] Call Trace:
> > [   53.653649]  <TASK>
> > [   53.653652]  dump_stack_lvl+0xa8/0xd0
> > [   53.653658]  dump_stack+0x14/0x20
> > [   53.653659]  __might_resched+0x1ae/0x2d0
> > [   53.653666]  __might_sleep+0x48/0x70
> > [   53.653668]  __kmalloc_node_track_caller_noprof+0x349/0x510
> > [   53.653674]  ? __devm_add_action+0x3d/0x160
> > [   53.653685]  ? __pfx_devm_action_release+0x10/0x10
> > [   53.653688]  __devres_alloc_node+0x4a/0x90
> > [   53.653689]  ? __devres_alloc_node+0x4a/0x90
> > [   53.653691]  ? __pfx_release_memregion+0x10/0x10 [dax_hmem]
> > [   53.653693]  __devm_add_action+0x3d/0x160
> > [   53.653696]  hmem_register_device+0xea/0x230 [dax_hmem]
> > [   53.653700]  hmem_fallback_register_device+0x37/0x60
> > [   53.653703]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
> > [   53.653739]  walk_iomem_res_desc+0x55/0xb0
> > [   53.653744]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
> > [   53.653755]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
> > [   53.653761]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
> > [   53.653763]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [   53.653768]  process_one_work+0x1fa/0x630
> > [   53.653774]  worker_thread+0x1b2/0x360
> > [   53.653777]  kthread+0x128/0x250
> > [   53.653781]  ? __pfx_worker_thread+0x10/0x10
> > [   53.653784]  ? __pfx_kthread+0x10/0x10
> > [   53.653786]  ret_from_fork+0x139/0x1e0
> > [   53.653790]  ? __pfx_kthread+0x10/0x10
> > [   53.653792]  ret_from_fork_asm+0x1a/0x30
> > [   53.653801]  </TASK>
> > 
> > [   53.654193] =============================
> > [   53.654203] [ BUG: Invalid wait context ]
> > [   53.654451] 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 Tainted: G        W
> > [   53.654623] -----------------------------
> > [   53.654785] kworker/46:1/1875 is trying to lock:
> > [   53.654946] ff37d7824096d588 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_add_one+0x34/0x390
> > [   53.655115] other info that might help us debug this:
> > [   53.655273] context-{5:5}
> > [   53.655428] 3 locks held by kworker/46:1/1875:
> > [   53.655579]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
> > [   53.655739]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
> > [   53.655900]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
> > [   53.656062] stack backtrace:
> > [   53.656224] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
> > [   53.656227] Tainted: [W]=WARN
> > [   53.656228] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
> > [   53.656232] Call Trace:
> > [   53.656232]  <TASK>
> > [   53.656234]  dump_stack_lvl+0x85/0xd0
> > [   53.656238]  dump_stack+0x14/0x20
> > [   53.656239]  __lock_acquire+0xaf4/0x2200
> > [   53.656246]  lock_acquire+0xd8/0x300
> > [   53.656248]  ? kernfs_add_one+0x34/0x390
> > [   53.656252]  ? __might_resched+0x208/0x2d0
> > [   53.656257]  down_write+0x44/0xe0
> > [   53.656262]  ? kernfs_add_one+0x34/0x390
> > [   53.656263]  kernfs_add_one+0x34/0x390
> > [   53.656265]  kernfs_create_dir_ns+0x5a/0xa0
> > [   53.656268]  sysfs_create_dir_ns+0x74/0xd0
> > [   53.656270]  kobject_add_internal+0xb1/0x2f0
> > [   53.656273]  kobject_add+0x7d/0xf0
> > [   53.656275]  ? get_device_parent+0x28/0x1e0
> > [   53.656280]  ? __pfx_klist_children_get+0x10/0x10
> > [   53.656282]  device_add+0x124/0x8b0
> > [   53.656285]  ? dev_set_name+0x56/0x70
> > [   53.656287]  platform_device_add+0x102/0x260
> > [   53.656289]  hmem_register_device+0x160/0x230 [dax_hmem]
> > [   53.656291]  hmem_fallback_register_device+0x37/0x60
> > [   53.656294]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
> > [   53.656323]  walk_iomem_res_desc+0x55/0xb0
> > [   53.656326]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
> > [   53.656335]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
> > [   53.656342]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
> > [   53.656343]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [   53.656346]  process_one_work+0x1fa/0x630
> > [   53.656350]  worker_thread+0x1b2/0x360
> > [   53.656352]  kthread+0x128/0x250
> > [   53.656354]  ? __pfx_worker_thread+0x10/0x10
> > [   53.656356]  ? __pfx_kthread+0x10/0x10
> > [   53.656357]  ret_from_fork+0x139/0x1e0
> > [   53.656360]  ? __pfx_kthread+0x10/0x10
> > [   53.656361]  ret_from_fork_asm+0x1a/0x30
> > [   53.656366]  </TASK>
> > [   53.662274] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
> > [   53.663552]  schedule+0x4a/0x160
> > [   53.663553]  schedule_timeout+0x10a/0x120
> > [   53.663555]  ? debug_smp_processor_id+0x1b/0x30
> > [   53.663556]  ? trace_hardirqs_on+0x5f/0xd0
> > [   53.663558]  __wait_for_common+0xb9/0x1c0
> > [   53.663559]  ? __pfx_schedule_timeout+0x10/0x10
> > [   53.663561]  wait_for_completion+0x28/0x30
> > [   53.663562]  __synchronize_srcu+0xbf/0x180
> > [   53.663566]  ? __pfx_wakeme_after_rcu+0x10/0x10
> > [   53.663571]  ? i2c_repstart+0x30/0x80
> > [   53.663576]  synchronize_srcu+0x46/0x120
> > [   53.663577]  kill_dax+0x47/0x70
> > [   53.663580]  __devm_create_dev_dax+0x112/0x470
> > [   53.663582]  devm_create_dev_dax+0x26/0x50
> > [   53.663584]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
> > [   53.663585]  platform_probe+0x61/0xd0
> > [   53.663589]  really_probe+0xe2/0x390
> > [   53.663591]  ? __pfx___device_attach_driver+0x10/0x10
> > [   53.663593]  __driver_probe_device+0x7e/0x160
> > [   53.663594]  driver_probe_device+0x23/0xa0
> > [   53.663596]  __device_attach_driver+0x92/0x120
> > [   53.663597]  bus_for_each_drv+0x8c/0xf0
> > [   53.663599]  __device_attach+0xc2/0x1f0
> > [   53.663601]  device_initial_probe+0x17/0x20
> > [   53.663603]  bus_probe_device+0xa8/0xb0
> > [   53.663604]  device_add+0x687/0x8b0
> > [   53.663607]  ? dev_set_name+0x56/0x70
> > [   53.663609]  platform_device_add+0x102/0x260
> > [   53.663610]  hmem_register_device+0x160/0x230 [dax_hmem]
> > [   53.663612]  hmem_fallback_register_device+0x37/0x60
> > [   53.663614]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
> > [   53.663637]  walk_iomem_res_desc+0x55/0xb0
> > [   53.663640]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
> > [   53.663647]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
> > [   53.663654]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
> > [   53.663655]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [   53.663658]  process_one_work+0x1fa/0x630
> > [   53.663662]  worker_thread+0x1b2/0x360
> > [   53.663664]  kthread+0x128/0x250
> > [   53.663666]  ? __pfx_worker_thread+0x10/0x10
> > [   53.663668]  ? __pfx_kthread+0x10/0x10
> > [   53.663670]  ret_from_fork+0x139/0x1e0
> > [   53.663672]  ? __pfx_kthread+0x10/0x10
> > [   53.663673]  ret_from_fork_asm+0x1a/0x30
> > [   53.663677]  </TASK>
> > [   53.700107] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
> > [   53.700264] INFO: lockdep is turned off.
> > [   53.701315] Preemption disabled at:
> > [   53.701316] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
> > [   53.701631] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary)
> > [   53.701633] Tainted: [W]=WARN
> > [   53.701635] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
> > [   53.701638] Call Trace:
> > [   53.701638]  <TASK>
> > [   53.701640]  dump_stack_lvl+0xa8/0xd0
> > [   53.701644]  dump_stack+0x14/0x20
> > [   53.701645]  __schedule_bug+0xa2/0xd0
> > [   53.701649]  __schedule+0xe6f/0x10d0
> > [   53.701652]  ? debug_smp_processor_id+0x1b/0x30
> > [   53.701655]  ? lock_release+0x1e6/0x2b0
> > [   53.701658]  ? trace_hardirqs_on+0x5f/0xd0
> > [   53.701661]  schedule+0x4a/0x160
> > [   53.701662]  schedule_timeout+0x10a/0x120
> > [   53.701664]  ? debug_smp_processor_id+0x1b/0x30
> > [   53.701666]  ? trace_hardirqs_on+0x5f/0xd0
> > [   53.701667]  __wait_for_common+0xb9/0x1c0
> > [   53.701668]  ? __pfx_schedule_timeout+0x10/0x10
> > [   53.701670]  wait_for_completion+0x28/0x30
> > [   53.701671]  __synchronize_srcu+0xbf/0x180
> > [   53.701677]  ? __pfx_wakeme_after_rcu+0x10/0x10
> > [   53.701682]  ? i2c_repstart+0x30/0x80
> > [   53.701685]  synchronize_srcu+0x46/0x120
> > [   53.701687]  kill_dax+0x47/0x70
> > [   53.701689]  __devm_create_dev_dax+0x112/0x470
> > [   53.701691]  devm_create_dev_dax+0x26/0x50
> > [   53.701693]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
> > [   53.701695]  platform_probe+0x61/0xd0
> > [   53.701698]  really_probe+0xe2/0x390
> > [   53.701700]  ? __pfx___device_attach_driver+0x10/0x10
> > [   53.701701]  __driver_probe_device+0x7e/0x160
> > [   53.701703]  driver_probe_device+0x23/0xa0
> > [   53.701704]  __device_attach_driver+0x92/0x120
> > [   53.701706]  bus_for_each_drv+0x8c/0xf0
> > [   53.701708]  __device_attach+0xc2/0x1f0
> > [   53.701710]  device_initial_probe+0x17/0x20
> > [   53.701711]  bus_probe_device+0xa8/0xb0
> > [   53.701712]  device_add+0x687/0x8b0
> > [   53.701715]  ? dev_set_name+0x56/0x70
> > [   53.701717]  platform_device_add+0x102/0x260
> > [   53.701718]  hmem_register_device+0x160/0x230 [dax_hmem]
> > [   53.701720]  hmem_fallback_register_device+0x37/0x60
> > [   53.701722]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
> > [   53.701734]  walk_iomem_res_desc+0x55/0xb0
> > [   53.701738]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
> > [   53.701745]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
> > [   53.701751]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
> > [   53.701752]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [   53.701756]  process_one_work+0x1fa/0x630
> > [   53.701760]  worker_thread+0x1b2/0x360
> > [   53.701762]  kthread+0x128/0x250
> > [   53.701765]  ? __pfx_worker_thread+0x10/0x10
> > [   53.701766]  ? __pfx_kthread+0x10/0x10
> > [   53.701768]  ret_from_fork+0x139/0x1e0
> > [   53.701771]  ? __pfx_kthread+0x10/0x10
> > [   53.701772]  ret_from_fork_asm+0x1a/0x30
> > [   53.701777]  </TASK>
> > 
> 

