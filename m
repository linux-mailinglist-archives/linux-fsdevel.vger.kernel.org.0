Return-Path: <linux-fsdevel+bounces-65873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E9C12A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 03:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674F9565277
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB25D1AF0B6;
	Tue, 28 Oct 2025 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIP7dGpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71B1DB127;
	Tue, 28 Oct 2025 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617560; cv=fail; b=VtgUzpopkSwe7Yb7ClehOxJfvM0ryHkziOQMhQ3mTVe3S4PZUrR+DW57AFQsgHIO+LXoFQM6p9/sZ731ikkNmViLVnqIsrxYnbrm0M29yxNYZh279kk5gsdwaWt9YOUN90T2Q0CZ+0kxC26Mmz0HYjlN3DElQwG0ahaeX9d7QPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617560; c=relaxed/simple;
	bh=Q4xuEK6PV8arfLTNqsxQyntTBrqcSJ1jXaIhU22OHzg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GqqT0kZ6sLS4E5swzG3VmZI3FPBTGj6g0r9+t1xiVZ0ecpUE9jLFxTzxod63uhAFZcVw9VoNJj46WZMbbwPT3djdpkP8+5A1WESuhUOzi6e/2hJK3fONSHdUWNUHtAh937qCcO2ycr590clZcmNdtUQQr162j8V5GPCbJTLRJbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIP7dGpK; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761617557; x=1793153557;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Q4xuEK6PV8arfLTNqsxQyntTBrqcSJ1jXaIhU22OHzg=;
  b=WIP7dGpKT+f21L5IA6vwoD12hEHx5ulFKabJRRb8EumqoJy+kDQXcKjs
   uVd2OWTh7+BGn5I9nv+azOxDExrmQVUT2JH9DdsURjemwk7kxoMvCDXDF
   I87/AHm9V1TVRUXf8SwFgz1XPKdVcF1W/1gcLZ8lWoNm+VQm+K4LviYCA
   U3OUalKmBLTfCKfSobhUnXcYfsAg2VKRuXwbo6MGBKpq5DtxCdJMHkLa2
   n6+bkC5eqQegDWKB476k4wUYaCxjlstbBWNftXRX4Qa20s1k4tb9Kp2Ov
   43876hcAhEo84kJAMjZeBESn/kj+17UEc9iwYmY90fZdFaImqEtp58gpV
   g==;
X-CSE-ConnectionGUID: YNaBSEMuTuKeA/9y/50cyA==
X-CSE-MsgGUID: ANq7thXTTaG+eww5WPSqjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74829103"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="74829103"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:12:37 -0700
X-CSE-ConnectionGUID: xacIW5OHRlSNpFPR07LVtg==
X-CSE-MsgGUID: olGOWvrZTCSkbh0CuYb6oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="185549339"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:12:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:12:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 19:12:36 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:12:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8GFTc4+PJaU0q1Mza5RhEDt/fgtMy+qzJNO/eKczHp2o0kmxTE5KPbh2MUveZA5gvgfbNozpAAE8NIEW6F7Bb12L/GhLM1FEVB61NOfLVVB+G8gyxL2Vn8lNa89G/6pUFHJOLNoDEpes8Q2dOCRBYU05VrojfGFyE6F0xWeWu6I4YSpKSZIQ9fu8e4rK0yPHeJ/wY6AdTswRuADSlCB3TpY8MeNQya7GGc6u3zT8CJSDoeSTPlFBaGqIHrsWMQ0PScwhRSzmSgDwcFH92adFWpeKrpGi4OSG3ov6cYTnAssf/aTj81blfXE2U6qioK3Xdn4O52MeXc6PrT93RfvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAcyppjkbrZguE8ESjzkHhW3eajvRDzKZ84ndsAvOdY=;
 b=p8nNEHmpxA3eJETWjRGKHDnC2SvaJiEczGUJc0oLsjKugw1O3whGm8hp1Y+7qMoRmlf5tam2zNh69/TXVhTSdHoWxi1EV0MKBhqfBhVNVYi7gSHGVuo4KVX2XOqSJuWqUO+LIeXXerCvH0ouxIMk4MGyVTeDb2OIjGjz/Zj+ZWZVVs8OKKh6dXUxIngaoJ/wWiZeM0rUB5slxvMgmdq3E9jzPr/vV6FgSB5iPhbKZ58jtRZdg543SWOBzWrjYP2mOPtr5eH6VNR1Nmbx8gWUScj9icexLVLQviw+IcwwcJRgXXq7oN2wZEl2otQPTYIsb8gC6iENZvo3U7WjPBx3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 28 Oct
 2025 02:12:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:12:34 +0000
Date: Mon, 27 Oct 2025 19:12:22 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
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
	Zhijian Li <lizhijian@fujitsu.com>, "Borislav Petkov" <bp@alien8.de>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL
Message-ID: <aQAmhrS3Im21m_jw@aschofie-mobl2.lan>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
 <aORp6MpbPMIamNBh@aschofie-mobl2.lan>
 <aOlxcaTUowFddiEQ@aschofie-mobl2.lan>
 <e2bf2bf1-e791-47e5-846c-149e735f9dde@amd.com>
 <aPbOfFPIhtu5npaG@aschofie-mobl2.lan>
 <d920b7d0-61db-481f-b256-a1f51ac7f743@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d920b7d0-61db-481f-b256-a1f51ac7f743@amd.com>
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ddd551-e14a-4acf-85f0-08de15c7750d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rno1UGlaOUQxdExZV3ppODhYUVhKMHQrQzBVb1lSVCtpMFRUYjV1aDkwODBa?=
 =?utf-8?B?a0l5cEhjc2dGakc2czlZdzBSbTdHRi82WndHZGQzbEFqVGpUcmVtb2RRM21P?=
 =?utf-8?B?WERjNHAxekl4NnZxQ3dwMWx2M0pteUpZUi9QdVhhNGgrcmcrMHdMVDhNRmhu?=
 =?utf-8?B?eGwvV2dqSDR5bWtqSFRVdmx1QjF5citMRXIrWnREbTNWSnp0eFNUUHdpV3JO?=
 =?utf-8?B?aVQwQ0NqbzJnVDgzOEN5ZmhpZEUxdU95T3hXT2JPczhMb2ZTQ1ZTYnI0MTRs?=
 =?utf-8?B?cGRVMVc4TFd5eDJqM1N0MGZwb2ExMCs3NkQzSEV4WTc3Vm4vd2RSZjh5aUxT?=
 =?utf-8?B?Y2dzYU8xb1BUbi94L3R5b3JlY2JJYlFweWh2cEZsWU9WS3g2YUNhQ3E1ZHFM?=
 =?utf-8?B?dmNPZlBrS0JXK0o2THcwc3VjaGpEYm1QMDRkenZwbjBhcGFTTXVTNnJ4N0tq?=
 =?utf-8?B?L3RONFdRWnNDdlduNG52bW1xemFxcnBPMDZ4Q1VwdndiYTRiVHRUTEFuQkZ1?=
 =?utf-8?B?OHROWGE2MmJtUktJUWVpMnU3cno4RHVTQWRlVXkzcVYwTEpoRmU2SkthRDJH?=
 =?utf-8?B?MlpDUkVkNW8xVHBUWEdpK1pYZnMxVDFpU3gxeFRYSkhtZ2xhRktxQm0ySlZD?=
 =?utf-8?B?d011b3o3RzlTNEJGazU5YzZ1RFNtUXJJWFk3b1cxNlk3RXBydWE2dUhIOEZD?=
 =?utf-8?B?T1JZNGY1Szhkb2RCTDBlOHA2ZU45R2w0aUVmTjBLd1pMd2c5a2Q3RTVWem9x?=
 =?utf-8?B?MjdwWENOSDU0UEl1anN1czhRb2p2bW0wS1MwSHllL2ljSXZUOWNGTDBiWjJi?=
 =?utf-8?B?bk1nR3Jab2RVc2NPMXZhbkgvL0xDbHRVeGhhUDhySEJBaURnS1BFYWRGdDV1?=
 =?utf-8?B?bXpZYWhXdm0vSmpqQkgvOXdMV2QxVlhyTzVnS1phWVc3TWFEQ0dITE1zamxQ?=
 =?utf-8?B?TmV6ZVBzc01vL1dRc20rcThWaHo1UURFVWZEVmRUSVB0c3J6Sk9rdFZ3QlE3?=
 =?utf-8?B?L2NTNU40M1BzeXlxc0Q1VzhPc3RWL1VURitxcCtPenQvNDBjWHhOa2V6a0pO?=
 =?utf-8?B?OG1QdjhVTFN4OFhObW85ZElxaUhuaEgwb2FnejZjUUhIaG9xaS9SNG9PeFJS?=
 =?utf-8?B?RVJ0VGk5YjNaNDdYcU84YTQ5RWRxZUNWKzhuZGtPUXRKVnJpcUg0aWs2b0Z3?=
 =?utf-8?B?b2pBT011ZzloOUlBakZqN3hsbjlLM2NsK1pNZXhLSDloMjNsOVdVc2dyTjNi?=
 =?utf-8?B?ZVB1ekwwRGc0LzNjVUY4WnZrRVNKcWRzZUVZQ1kvWk9aS0tJRXFEZG14ZVpE?=
 =?utf-8?B?UjJBcXNUb1NUVGx3a0xWUGhvejJkK3FPSWpDemtvYmdnL1NBb0xVelRvKzZT?=
 =?utf-8?B?Uk1uTSthNWl5ZnU0cEI4UXV0eGNGWnF5ajljRG4wdkFFMjhOTnJRYk1QMmli?=
 =?utf-8?B?dTBlRC90eFdNa0hJbWJiUi9XK2xGeDlyY00yclpjMzBRZTkzUE5EMG1raFA2?=
 =?utf-8?B?K05TN3h3K2I2UnEraVQxV1ltT2JDLzd3dk4wL09aeXBYMHNLU1lySlZIcU5v?=
 =?utf-8?B?b1QrcnJGc04zUlVBdk5JOXNIVVd2S09mUHVidDFqTHV0c1NwZkI5RGxNdS9W?=
 =?utf-8?B?VW1qQWl1OGNQY092YTdabHBDRC9RMm1RcDQyQWdjODhodU54ZFJpcDRsQlRD?=
 =?utf-8?B?Zy9lWFdLRklsZUViZm0rMFIwSXVDRGNYWEN3WU9LS1d6QkcxeEQ2SUxTd3ds?=
 =?utf-8?B?eUx2R2ZDekNVbG9MQzdhdWVWT0t2Tk9iM1ZKYzZGemMraWplbHNQVDhrS0tV?=
 =?utf-8?B?TzZQblVDNzhPcE5WajFUTU5hM2NZbVM4ZHllajZzR3dDQVI4cjN5Z0JDYlFV?=
 =?utf-8?B?bFBva2hpYkxaU0gweFJEOVJxNEN3cEk1WDYxZHJsZk5tYTFrTEs2UnlXYk15?=
 =?utf-8?Q?BDagQ0D7qfg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFqVkdHdVl3WFpFNnZKaWFaRFU2U1FoOStCRHJMcGRjM0ZvN3k4cWx4cGVu?=
 =?utf-8?B?U1duUFdhLy9yZzZaWTlKbkJWQWsySGRHNTlQWUxSN2xBNC9wb1cvOVFvdC96?=
 =?utf-8?B?RWI0RldhQUk0STZ3ZkE4eXJyakw1NklwZG01V2ZRWUtIUVJBTWNEWW1nNVlt?=
 =?utf-8?B?OERGUjNsOGZZUXBZdXNhR1pjV290Q2NhZ0gvR2dNYWxLeHJ0YVdiK0Q2SndG?=
 =?utf-8?B?UDNxRkRNQnBxSDBDN3g1dW5PTnhHS2MvL0VUaU9UQ1hxajJvQmR6VFRkV0d2?=
 =?utf-8?B?L0kyV2hONDVCUnlxaFpNR0o2T0ZyMGRiRTczcUtqMnVpdGJqRUhwWXpoTFpU?=
 =?utf-8?B?WVIxeEtkcXR5WHcrMU1zMTl2MnJNMDVHVjI3Q0ltc29Tak9DM1RBaElVSE1W?=
 =?utf-8?B?S09VTmFTOVVTVkFWSlNNQlNTeUdpd0JWVXBzUkluQ3VBWHRzWTVDU3BWUm0x?=
 =?utf-8?B?OXF5VHdYbXdRc2lFQnprOUR5TVN0TmJpaThZbFQ0SFJ0dWI4Snk0aVNBMVdK?=
 =?utf-8?B?MStoa1RwdzRUOEpuVWxOSFVObGtyVWQ1ZWFSemdMT1RmaStMUmNsSUNUVXJK?=
 =?utf-8?B?ZVFxN2orVkxSUUpzbVFiWWxHd2lzSEdWNmpSRk85TnNicUp0TlBuc09CZzZH?=
 =?utf-8?B?dHNNYy9ndXRaTGlzcWJJeHJscW5qcTlLRFZsVGpGWk9tb3lqT0hqaHJ0SmxE?=
 =?utf-8?B?Q0N6aWpwSTZFZGhON0dnK2pIV0h6Y0RHVVROc21kS0ZKQUQ5WDAzZjlEb09H?=
 =?utf-8?B?VlNNQjh3cUE2T216Z09kaGt2a2tKR3B2cERWV3dYOHZmTm5SdDE4TUlwYlFa?=
 =?utf-8?B?a0xHZ3RtOVlzeTdaY3d4WmxreGdMVWRRUEpmcUJOeG1rMmp3Z2JQQVN2WXBa?=
 =?utf-8?B?YUdSaTQzcW9yRFl4cWpYajFLb1hHSmZsQy9vaGV3cUhCdk05ZmZLdmVkSVk2?=
 =?utf-8?B?RG1OYTBXY3hpMkZ0ZkJVT2hDc2hXcnZXdU1iL3RrMjJST0FucndoZjRkYjUy?=
 =?utf-8?B?SDZKeHVoN3NGTUtYTU4wMmlqMnFrT1NNVG85NzRSNWZBalRXbFBOR24reWtY?=
 =?utf-8?B?VnNlT25JQjh3emJGODZhbm8zTmNWOE4wK3oxczduckxIZkpwdW54NjFCNjNJ?=
 =?utf-8?B?eEF6SkdYU2RaUGk0dnZEaUxadGczZkRIaUhJRTZLWStuNFZPT1Nkdi9LbHJU?=
 =?utf-8?B?akNmOG9uMXJDTitqekVVSU5xUm95ZnJJK2FIbG9HU05JcDJqaVNrdEtwSjBy?=
 =?utf-8?B?OE42NXZoNGxLTStST3BGOWs2elhtSEJoQlhFVmx0K0V3eldROWVhVmx6S2pG?=
 =?utf-8?B?blg3NkZOTTAxbTZZNEZUakUweENBYU02b0NZeitSODV6Rkt3NEZiUVBISWhw?=
 =?utf-8?B?eG5SNDlEOHNaN1dSaDdPQ3YwN2RKTUpaWlpMOUNCS0F1L1FvNG5hOEtRL1lm?=
 =?utf-8?B?Si9WbXJLZEhXR1Zwbmc4WkJHenhSU3RROXQvWFcrMXprVnpRODI2V0hYclo3?=
 =?utf-8?B?YWNiZ3FReFAxQzZKV1ovalN5bm1FSFpMV3ZSNTlPbWs1TVdjYndTTGI0RWVJ?=
 =?utf-8?B?WWdjcTVSRFNrUmlDM3I0MkFlODJhbFZZdDZKZ3pjU0x2NjVacHFKczJhUXNu?=
 =?utf-8?B?TlM4K2g0Q0Y2SGNOOGN3cDRraCsxVTNOczk0ajc2aUxMRWQ2ZkNLMm1QaCs2?=
 =?utf-8?B?WDdsc3JGWlBWNHFKN0ZuT001RDBoSnIvMXlxMUlMUmQ1S2FKNEZRR0V6d0dE?=
 =?utf-8?B?bnY3dFkra3MxZjNwMWxSNmVwWkNaNlQ5b2sxZDRyVG1mY0NweUlGejdjOEFw?=
 =?utf-8?B?M094NzNaWmQ5alJwU2FSMDdjODNJM2U2bGZxZStJRW9FaGVpSEE3dUFERVE2?=
 =?utf-8?B?UTc4ckhTK2U5NjRvUkU5QUZqWGtXK0c2ZU8xNndwKy8yRkVTL1R6KzlVVnhR?=
 =?utf-8?B?Yk0vU1pPTnVCRmNLdmlLdFVNQUZzRjY3SUFxVUZRNDJzZ2x0ZExTdm1SaDdD?=
 =?utf-8?B?cEdjdEszejhPZ1g0UzF5MUJ0aVQwMFpCRjYya2NPREppYXRrbnUzZVR6bnVQ?=
 =?utf-8?B?MjFySVhTTXFDU1NIeFZJckhGbDdROFAzb0dwb2VORjdjTDVEc093Y2QrTWtr?=
 =?utf-8?B?T0xORFBoR1J4VWFXR1VKV25hK2tBMmtlZkpOZ2RCaTV2QVhwWVpSRjk4b2VI?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ddd551-e14a-4acf-85f0-08de15c7750d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:12:34.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyaSQBWZJpUM936MwKNyz01Wgini54mkhuT3fbGg5Qm0oAaa+iKgFQv6nhD5HaX6fn6DQlrXxyN+o3tNJ86ceoCAjLQdagP2jWlFZUBt+Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-OriginatorOrg: intel.com

On Fri, Oct 24, 2025 at 01:08:19PM -0700, Koralahalli Channabasappa, Smita wrote:
> Hi Alison,
> 
> Thanks for the pointers and the branch. Here’s where I landed on the three
> items. Responses inline.
> 
> On 10/20/2025 5:06 PM, Alison Schofield wrote:
> > On Tue, Oct 14, 2025 at 10:52:20AM -0700, Koralahalli Channabasappa, Smita wrote:
> > > Hi Alison,
> > > 
> > > On 10/10/2025 1:49 PM, Alison Schofield wrote:
> > > > On Mon, Oct 06, 2025 at 06:16:24PM -0700, Alison Schofield wrote:
> > > > > On Tue, Sep 30, 2025 at 04:47:52AM +0000, Smita Koralahalli wrote:
> > > > > > This series aims to address long-standing conflicts between dax_hmem and
> > > > > > CXL when handling Soft Reserved memory ranges.
> > > > > 
> > > > > Hi Smita,
> > > > > 
> > > > > Thanks for the updates Smita!
> > > > > 
> > > > > About those "long-standing conflicts": In the next rev, can you resurrect,
> > > > > or recreate the issues list that this set is addressing. It's been a
> > > > > long and winding road with several handoffs (me included) and it'll help
> > > > > keep the focus.
> > > > > 
> > > > > Hotplug works :)  Auto region comes up, we tear it down and can recreate it,
> > > > > in place, because the soft reserved resource is gone (no longer occupying
> > > > > the CXL Window and causing recreate to fail.)
> > > > > 
> > > > > !CONFIG_CXL_REGION works :) All resources go directly to DAX.
> > > > > 
> > > > > The scenario that is failing is handoff to DAX after region assembly
> > > > > failure. (Dan reminded me to check that today.) That is mostly related
> > > > > to Patch4, so I'll respond there.
> > > > > 
> > > > > --Alison
> > > > 
> > > > Hi Smita -
> > > > 
> > > > (after off-list chat w Smita about what is and is not included)
> > > > 
> > > > This CXL failover to DAX case is not implemented. In my response in Patch 4,
> > > > I cobbled something together that made it work in one test case. But to be
> > > > clear, there was some trickery in the CXL region driver to even do that.
> > > > 
> > > > One path forward is to update this set restating the issues it addresses, and
> > > > remove any code and comments that are tied to failing over to DAX after a
> > > > region assembly failure.
> > > > 
> > > > That leaves the issue Dan raised, "shutdown CXL in favor of vanilla DAX devices
> > > > as an emergency fallback for platform configuration quirks and bugs"[1], for a
> > > > future patch.
> > > > 
> > > > -- Alison
> > > > 
> > > > [1] The failover to DAX was last described in response to v5 of the 'prior' patchset.
> > > > https://lore.kernel.org/linux-cxl/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
> > > > https://lore.kernel.org/linux-cxl/687ffcc0ee1c8_137e6b100ed@dwillia2-xfh.jf.intel.com.notmuch/
> > > > https://lore.kernel.org/linux-cxl/68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch/
> > > 
> > > [+cc Nathan, Terry]
> > > 
> > >  From the AMD side, our primary concern in this series is CXL hotplug. With
> > > the patches as is, the hotplug flows are working for us: region comes up, we
> > > can tear it down, and recreate it in place because the soft reserved window
> > > is released.
> > > 
> > > On our systems I consistently see wait_for_device_probe() block until region
> > > assembly has completed so I don’t currently have evidence of a sequencing
> > > hole there on AMD platforms.
> > > 
> > > Once CXL windows are discovered, would it be acceptable for dax_hmem to
> > > simply ignore soft reserved ranges inside those windows, assuming CXL will
> > > own and manage them? That aligns with Dan’s guidance about letting CXL win
> > > those ranges when present.
> > > https://lore.kernel.org/all/687fef9ec0dd9_137e6b100c8@dwillia2-xfh.jf.intel.com.notmuch/
> > > 
> > > If that approach sounds right, I can reword the commit descriptions in
> > > patches 4/5 and 5/5 to drop the parts about region assembly failures and
> > > remove the REGISTER enum.
> > > 
> > > And then leave the “shutdown CXL in favor of vanilla DAX as an emergency
> > > fallback for platform configuration quirks and bugs” to a future, dedicated
> > > patch.
> > > 
> > > Thanks
> > > Smita
> > 
> > Hi Smita,
> > 
> > I was able to discard the big sleep after picking up the patch "cxl/mem:
> > Arrange for always-synchronous memdev attach" from Alejandro's Type2 set.
> > 
> > With that patch, all CXL probing completed before the HMEM probe so the
> > deferred waiting mechanism of the HMEM driver seems unnecessary. Please
> > take a look.
> > 
> > That patch, is one of four in this branch Dan provided:
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.18/cxl-probe-order
> > 
> > After chats with Dan and DaveJ, we thought the Soft Reserved set was the
> > right place to introduce these probe order patches (let Type 2 follow).
> > So, the SR set adds these three patches:
> > 
> > - **cxl/mem: Arrange for always-synchronous memdev attach**
> > - cxl/port: Arrange for always synchronous endpoint attach
> > - cxl/mem: Introduce a memdev creation ->probe() operation
> > 
> > **I actually grabbed this one from v19 Type2 set, not the CXL branch,
> > so you may need to see if Alejandro changed anything in that one.
> > 
> > When picking those up, there's a bit of wordsmithing to do in the
> > commit logs. Probably replace mentions of needing for accelerators
> > with needing for synchronizing the usage of soft-reserved resources.
> > 
> > Note that the HMEM driver is also not picking up unused SR ranges.
> > That was described in review comments here:
> > https://lore.kernel.org/linux-cxl/aORscMprmQyGlohw@aschofie-mobl2.lan
> > 
> > Summarized for my benefit ;)
> > - pick up all the probe order patches,
> > - determine whether the HMEM deferral is needed, maybe drop it,
> > - register the unused SR, don't drop based on intersect w 'CXL Window'
> > 
> > With all that, nothing would be left undone in the HMEM driver. The region
> > driver would still need to fail gracefully and release resources in a
> > follow-on patch.
> > 
> > Let me know what you find wrt the timing, ie is the wait_for_device_probe()
> > needed at all?
> > 
> > Thanks!
> > -- Alison
> > 
> 
> 1. Pick up all the probe order patches
> I pulled in the three patches you listed.
> They build and run fine here.
> 
> 2. Determine whether HMEM deferral is needed (and maybe drop it)
> On my system, even with those three patches, the HMEM probe still races
> ahead of CXL region assembly. A short dmesg timeline shows HMEM registering
> before init_hdm_decoder() and region construction:
> 
> ..
> [   26.597369] hmem_register_device: hmem_platform hmem_platform.0:
> registering released/unclaimed range with DAX: [mem 0x850000000-0x284fffffff
> flags 0x80000200]
> [   26.602371] init_hdm_decoder: cxl_port port1: decoder1.0: range:
> 0x850000000-0x284fffffff iw: 1 ig: 256
> [   26.628614] init_hdm_decoder: cxl_port endpoint7: decoder7.0: range:
> 0x850000000-0x284fffffff iw: 1 ig: 256
> [   26.628711] __construct_region: cxl_pci 0000:e1:00.0: mem2:decoder7.0:
> __construct_region region0 res: [mem 0x850000000-0x284fffffff flags 0x200]
> iw: 1 ig: 256
> [   26.628714] cxl_calc_interleave_pos: cxl_mem mem2: decoder:decoder7.0
> parent:0000:e1:00.0 port:endpoint7 range:0x850000000-0x284fffffff pos:0
> [   44.022792] __hmem_register_resource: hmem range [mem
> 0x850000000-0x284fffffff flags 0x80000200] already active
> [   49.991221] kmem dax0.0: mapping0: 0x850000000-0x284fffffff could not
> reserve region
> ..
> 
> As, region assembly still completes after HMEM on my platform,
> wait_for_device_probe() might be needed to avoid HMEM claiming ranges before
> CXL region assembly.
> 
> 3. Register unused SR, don’t drop based on intersect with “CXL Window”
> Agree with your review note: checking region_intersects(..., IORES_DESC_CXL)
> is not reliable for 'CXL owns this'. IORES_DESC_CXL marks just the 'CXL
> Windows' so the intersect test is true regardless of whether a region was
> actually assembled.
> 
> I tried the insert SR and rely on -EBUSY approach suggested.
> 
> https://lore.kernel.org/linux-cxl/aORscMprmQyGlohw@aschofie-mobl2.lan/#t
> 
> On my setup it never returns -EBUSY, the SR inserts cleanly even when the
> CXL region has already been assembled successfully before dax_hmem.
> 
> insert_resource() is treating 'fully contains' as a valid hierarchy, not a
> conflict. The SR I insert covers exactly the same range as the CXL
> window/region. In that situation, insert_resource(&iomem_resource, SR) does
> not report a conflict, instead, it inserts SR and reparents the existing CXL
> window/region under SR. That matches what I see in the tree:
> 
> 850000000-284fffffff : Soft Reserved
>   850000000-284fffffff : CXL Window 0
>     850000000-284fffffff : region0
>       850000000-284fffffff : dax0.0
>         850000000-284fffffff : System RAM (kmem)
> ... (same for the other windows)
> 
> So there is no overlap error to trigger -EBUSY, the tree is simply
> restructured.
> 
> insert_resource_conflict() is also behaving the same.
> 
> and hence the kmem failure
> kmem dax6.0: mapping0: 0x850000000-0x284fffffff could not reserve region
> kmem dax6.0: probe with driver kmem failed with error -16
> 
> walk_iomem_res_desc() was also not a good discriminator here: it passes a
> temporary struct resource to the callback (name == NULL, no child/sibling
> links), so I couldn't reliably detect the 'region under window' relationship
> from that walker alone. (only CXL windows were discovered properly).
> 
> Below worked for me instead. I could see the region assembly success and
> failure cases handled properly.
> 
> Walk the real iomem_resource tree: find the enclosing CXL window for the SR
> range, then check if there’s a region child that covers sr->start, sr->end.
> 
> If yes, drop (CXL owns it).
> 
> If no, register as unused SR with DAX.
> 
> 
> +static struct resource *cxl_window_exists(resource_size_t start,
> +                                        resource_size_t end)
> +{
> +       struct resource *r;
> +
> +       for (r = iomem_resource.child; r; r = r->sibling) {
> +               if (r->desc == IORES_DESC_CXL &&
> +                   r->start == start && r->end == end)
> +                       return r;
> +       }
> +
> +       return NULL;
> +}
> +
> +static bool cxl_region_exists(resource_size_t start, resource_size_t end)
> +{
> +       const struct resource *res, *child;
> +
> +       res = cxl_window_exists(start, end);
> +       if (!res)
> +               return false;
> +
> +       for (child = res->child; child; child = child->sibling) {
> +               if (child->start <= start && child->end <= end)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int handle_deferred_cxl(struct device *host, int target_nid,
>                                const struct resource *res)
>  {
> -       /* TODO: Handle region assembly failures */
> +       if (region_intersects(res->start, resource_size(res),
> IORESOURCE_MEM,
> +                             IORES_DESC_CXL) != REGION_DISJOINT) {
> +

Will it work to search directly for the region above by using params
IORESOURCE_MEM, IORES_DESC_NONE. This way we only get region conflicts,
no empty windows to examine. I think that might replace cxl_region_exists()
work below.



> +               if (cxl_region_exists(res->start, res->end)) {
> +                       dax_cxl_mode = DAX_CXL_MODE_DROP;
> +                       dev_dbg(host, "dropping CXL range: %pr\n", res);
> +               }
> +               else {
> +                       dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> +                       dev_dbg(host, "registering CXL range: %pr\n", res);
> +               }
> +
> +               hmem_register_device(host, target_nid, res);
> +       }
> +
>         return 0;
>  }
> 
> static void process_defer_work(struct work_struct *_work)
> {
>         struct dax_defer_work *work = container_of(_work, typeof(*work),
> work);
>         struct platform_device *pdev = work->pdev;
> 
>         /* relies on cxl_acpi and cxl_pci having had a chance to load */
>         wait_for_device_probe();
> 
>         walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
> }
> 
> For region assembly failure (Thanks for the patch to test this!):
> 
> hmem_register_device: hmem_platform hmem_platform.0: deferring range to CXL:
> [mem 0x850000000-0x284fffffff flags 0x80000200]
> handle_deferred_cxl: hmem_platform hmem_platform.0: registering CXL range:
> [mem 0x850000000-0x284fffffff flags 0x80000200]
> hmem_register_device: hmem_platform hmem_platform.0: registering CXL range:
> [mem 0x850000000-0x284fffffff flags 0x80000200]
> 
> For region assembly success:
> 
> hmem_register_device: hmem_platform hmem_platform.0: deferring range to CXL:
> [mem 0x850000000-0x284fffffff flags 0x80000200]
> handle_deferred_cxl: hmem_platform hmem_platform.0: dropping CXL range: [mem
> 0x850000000-0x284fffffff flags 0x80000200]
> hmem_register_device: hmem_platform hmem_platform.0: dropping CXL range:
> [mem 0x850000000-0x284fffffff flags 0x80000200]
> 
> Happy to fold this into v4 if it looks good.
> 
> Thanks
> Smita
> > 
> > > 
> > > > 
> > > > > 
> > > > > 
> > > 
> 

