Return-Path: <linux-fsdevel+bounces-75546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIQMLbvrd2nlmQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:33:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB5A8DF24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8501A300A8EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39C3093AB;
	Mon, 26 Jan 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPlsqov6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1F308F3E;
	Mon, 26 Jan 2026 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466806; cv=fail; b=O/nBgktM1CvAViVSovnES/SxI6LukCm9oTBuntQ/f5Ejq+Oz5XrV8F1sKbLwAonyDpOxbEvVsWHWyhfGrsgkYCh542idmMVDWB37Z1iySNbchlgJ5DnJj+gTBSIgZUop1atZSYWuWx6K2PdiJcYzhh9R1UQJqQpcVfmEmWpBPXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466806; c=relaxed/simple;
	bh=QvK5sox/cLqAFxV30Z5H7kF/gzbkupVYu3wXgv6zVHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fUNpO1muHoxK5RwtWSopF9BPLSnr0pdQK/eLoUjRFBybepl3SnkuOvNr2Cg8HQKYPGybuh7RqHbP49f57GMRW3pOYf+V5F8dltiOd6sgY+Pq3PQoIFLnlVEKU//FSTaWhY5UpnNVgSm1w0UERs1SfHkiPH0eiAtziiCOFx7MYG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPlsqov6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769466803; x=1801002803;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QvK5sox/cLqAFxV30Z5H7kF/gzbkupVYu3wXgv6zVHY=;
  b=BPlsqov6SAV5Eb/1EmL1oN05emxE9aJBNOdY/HkDZXF2USInjut9/e3K
   rj6DC9v7uust69JThew1u1oYhiPmN3o8WWmGhAMCKNN863uX7sapb47Yt
   oUE/3GNgl9g7quJo57ToGVfmbzA8tDW1JFNhBCnfGEwP/9tqIaJfFyAgZ
   gT2wsKbz85vw4v9+QwSu1LWqFfxvOjKFFadaWGos9EtUnZ0bAxHkhcT2p
   mP1tOcqtfc27aRkrGf1vIZgqCt8CpyCqkBM2G1nG6Kk4c73DHdnqLaPsc
   h59ymf++pygPWTwJrfr5XQrwH+y/2P3tGAAm10/ryKb2+25qInOqyRmrp
   g==;
X-CSE-ConnectionGUID: 2M6eKARIQeKfgBocURkKMg==
X-CSE-MsgGUID: c1fW0UUpS/WZvMGMI6v+aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70547901"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70547901"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:33:23 -0800
X-CSE-ConnectionGUID: IrtKx6hzS52mu+GSoRM2qw==
X-CSE-MsgGUID: YODQ78m/SJqefmkE1Tv0ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207411002"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:33:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 14:33:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 14:33:21 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 14:33:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYIx4G3su3qf3rJEmVESRXBMYybuTtROmmZy2GdXqNrmrscDKhvfjhxIDowWjI2mtibSukTEV+8XX1Anj1vQfDjPwBBIFfjGAVjQMchxuHJOH2qaAUVuV/5G9+m0aPAkQwewsFNw8kXJAMLLoF6EM92Y0yt92UZElr9rlhKwmKaSr6GCDthZmGphrgNbPriwz3G3BiN9uyZu6C/S50DkT8+GHnsS+FOEWTIce13DDZPQuLJ47PHhmOHzA+wwFy8t3X7HzRCJu9DJEJ6kK0FAFTbq0EWKHvLRQeQIgfmFAGEhExCbNnQRpdZghNZoYY0iugdkd8a0M82SHiu+b3uZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIrUQt7S5UTngWwzf4HEgyiEFv5gIgHk/NGUrLFenug=;
 b=VGou+fR4exqVrOp+WOB1J10UWcRJaXMxXFt2NAVusKNcI/U5Je7Ji8BSzxtfYvpinan1fNOBZmAPiGQK1BUxoXYVFLCK/YKt601RTwAGfaG2yUzkeXMIVR6FB4U221xFwfWdc+HJu/OV3YG/9CMOUTYsvZLTarpf0fAKZwDuXtB3CaNZtX01e08o9lE/QYzRZcjtxzzxL4FaLcQekmAUlXXrIAKBF0rRm0nPcxRLZbrH1OC9v/cqmIK2eQXhg3EVc/JpI1lMCRipbTKnZLNgPP5f6Xvtjr5a8ASW2e2uJiWIQW+JFosbNcycfGsHB78mG5K8CRLKMuj7ycQY2SdfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 22:33:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 22:33:16 +0000
Date: Mon, 26 Jan 2026 14:33:10 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
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
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of
 Soft Reserved memory ranges
Message-ID: <aXfrptWS1C5Pm2ww@aschofie-mobl2.lan>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
 <aXMWzC8zf3bqIHJ0@aschofie-mobl2.lan>
 <9f33dc8b-4d0c-4e0b-8212-ecf1a2635b5d@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f33dc8b-4d0c-4e0b-8212-ecf1a2635b5d@amd.com>
X-ClientProxiedBy: BY3PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: d96f3173-09ce-4c16-7fac-08de5d2ae628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDlpdjhpUnRmSDFzOHNBMWwwMStPb0I2Nm5URUxCUVRST2F2V2U0VlRpTEwy?=
 =?utf-8?B?Wjk1WURZYnh6WUxveUN4dHF5Y1R2NC9mdXF1UHdaeXJyc3h1cWpZNWtRTzdu?=
 =?utf-8?B?Vi9mUFloUXN1eDZzbVZjQmF1QkNYSHZFWnVjTDRuY0p2UWlXaW1Id2xtZjhH?=
 =?utf-8?B?VTZMeHJtV1dWMGtLRTRBMDV0dWRaNDR0MFhqZE9FTElXOEdJb3pmWWd6Y1lW?=
 =?utf-8?B?UHpYK0JVNk5GaWZQRzBJYWJMWjZmSWVOclpTUXQrdmZWRTB3K3IwWTlzNC9w?=
 =?utf-8?B?WW5jNVdrQ0QwMG8zQUxsUTRtVmJaZnQ3YW05bjFlZ2s2akdvZGpUUW90dnFM?=
 =?utf-8?B?RFVqMVZFN1ZFazBiejMzTzJCczFoMlZmaXdsMjZOb2ZHTWUwRndjV3BxTGxP?=
 =?utf-8?B?NGRMMFVDeFRkOWhuU2xTUVpyaXliWTAxMU5DcHJxS2gzTTJBSUtNV0tRVE5G?=
 =?utf-8?B?K1VtRFBKTE1vVk44RHB0VmZXZWg1MFNvTEE1c3QwMXhsd2hLcjZBb1ZpWjAw?=
 =?utf-8?B?T0hmMS9QZk11c3E4OUgxcm1xbUhnRzFqRE1mSG5PeWExZzZYTzBQaUxwa1ZV?=
 =?utf-8?B?OFpWZjdNUXJPNkprV0lIRkJNZFhjbndTRW9leEZzekwzUHNVbWVoL0JaYWFF?=
 =?utf-8?B?WFNUdkx0T2l2VDgzZTlDME9qSDljOTY4bGgxOVFVVlBvcEZlR2E1R0drN1VX?=
 =?utf-8?B?aGp1Y2NRM3FPRmQ4RGZBNUNoZ3J6Mmlpcnh6b2tkVmR5TDExTGNiUW5YS2Q1?=
 =?utf-8?B?QlJKY2ZPOXdubUNiV3g1eWxYSitjKy93WlpTd1dWaHNMRldiNHJxRk9Sc0pS?=
 =?utf-8?B?STgzc3ZJZXBET2dhdUhrUWpCUFBoRmoxb3UzNTZCQUpLRFlwa3BtVmJvUits?=
 =?utf-8?B?SVVWY1dSSTkvNGcxaXdlVU1IQkpDbU03Nko1MnFpY0JWZEtSS3kraXlNcHBy?=
 =?utf-8?B?ZkFKTCtIdVpSMGxZYmpFZjZXMjJJNEMyb1pOTXgvam0vY05BYWFuM3NDenBp?=
 =?utf-8?B?NmdBL1h0RUIxeTlrQUFMM0dzMUx4SVUzRGMzREtKQ0N2RkN3TFRnR3ZCSy91?=
 =?utf-8?B?MGlmQ1hPb1ZDdGRiR3VVT1g4TXFMRXRyTXMvUG56b25vT3B2MHVmNzBYZWpM?=
 =?utf-8?B?NjJub05Qby8vckZrR0FaQWt2YlZHa29LdWU4T1V2ZEZGTzdzQWdjZFQ2MXZt?=
 =?utf-8?B?dHNGVWtxNUtPZGw0VXE0Z1hoSXhZMURWWllzTkhQalB4NGMyNXk3a0F5eGV4?=
 =?utf-8?B?N2dxZ09ZZk8zQ0lZVWQ0VmRBWjFPOGpHQ3pLeDZ0Q09jRGJ1aTlVcUZ2QVV1?=
 =?utf-8?B?MDAvT1VKVlVJTW5USXpVb25lQ083NTVDRitoamppLzl3b3J6aWNNNkkrZ093?=
 =?utf-8?B?eXRaS0JLdnhUamU4bi8yZVJBeE1PT09FKzJnT1FDZzZuQktmYXNxYlg4U1BP?=
 =?utf-8?B?dStTbFp4cEtNZGsrcUhKK3hERHBXZlRJWExyTEtjVTkyT0NFeERoUmJXbUxH?=
 =?utf-8?B?K3hCNWR0dEhNM0NOMmNrSWtSVERGWlVuZS9SUHZ2ck9hR2JGdHpxVlJpNDg3?=
 =?utf-8?B?L25rRWlFbjQzTjhaRlNlZEY3bXJpR3d6Y1ArcnRQT1FMWTJkWHQzWkJ4cXFw?=
 =?utf-8?B?YklUNU9RSjNnZ1BiMXFXUjh3aTdWbCtlVFY1MEhjSWhjdzdCenhzT2lJamsv?=
 =?utf-8?B?YjZRMzB1dzVnYVJxUVFVcklvc0hDdzdpR2VJMzlmb3k3bzRTYUJ6U0h4MTZM?=
 =?utf-8?B?NVdoL1gvQnlKS1ZjMjFnTjExcTNOL2ZKL3h6UEpBWXJKbkVVZlRGMGhKVENs?=
 =?utf-8?B?TW1JMXEyUldSVTB3a29oRnpIWTc1TmdBcVlZTWJ5NzNtamhyR1BIeXQvVDFh?=
 =?utf-8?B?UVRXclJDSThqZTBYcExUVGJpNmd2WkJkY0ZyY0hqOTNjbHhHQ3diVGE5RWIr?=
 =?utf-8?B?dHlkQjFzaXlnUEdxMVJ0ZktsOC9EVG5WZDI2WWVSdVhBUzJVOTFmbnFKSGhz?=
 =?utf-8?B?YVh5RHZFaFIrT2NsNm12eitscytSZFZMVFU1eTViWHY2S25ueFcrQ1ZwTUk0?=
 =?utf-8?B?cTY1S2laR1VXMzVwZHBGdGcyZ3QzWVQxSnU4TjdDTXVackJLemZCaVlFSDdV?=
 =?utf-8?Q?oagg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJEbkNrejJNL1N6MDRaZHZVbTFadXdKWlpZRU5PQUJkUW5YOUQxWG9UOW1t?=
 =?utf-8?B?cHZIR3RuODVwUDcyVmw5M1JHSUZDdWpQcUFzclJoTTdHSEZaUnhyV2xsY1JR?=
 =?utf-8?B?b0tPY1ZyNEhPM0E2UzlReFd3dWRxQmNwenVjb0xvcTRzamFhMFVQTlMvSUgz?=
 =?utf-8?B?VUhPWGtkU0JFS3NLRU9ueW9heWw1aWhoVWhiSzR1TWZFWUJTczZMcEdCcG9y?=
 =?utf-8?B?dEl2RHpXOW1MVDBZeWNISUx4OXp3ay9aaCtuVk1aV2V4Q1BlS2dGUUVTNjJZ?=
 =?utf-8?B?UG8yaTFUV3grdDVkamNVeDJzYXI0V0xSVkhoMUdHdC81NXJmaXFsUmE4OXUw?=
 =?utf-8?B?UkFrYVJhYk5HN21mTnVQVDFRRmhoVmRJYUFTWGt3UkFZRlVHTm9qY1JvQUJI?=
 =?utf-8?B?bFVLa0RHU1QvTUJNZnR6L0N1V2NnQW9CUkUrSExqN2p2cFFEQWFHRmE4OS9G?=
 =?utf-8?B?SUNscnM3QThDdWdNMEVpUTFrbHFValozWlo2VmJpQ3JRYU1UQXVXRG54Vkh2?=
 =?utf-8?B?ZkNpT2Q2UUpuTGwwbU9KVFFGclozOHE2Ti9lemVrR0dSczkzT2V0Y2VpcUx6?=
 =?utf-8?B?eTJtYithYWs5UXJjK1FLOVFEdnZPMnFyRDJYZ1JpUitwUExnbCttTzg0UjFB?=
 =?utf-8?B?eHluMzBhZGREL0lyRDdUdWtkSS9WK2cwdzIzR0ZkSDhlMEFCeGtDMER2TVll?=
 =?utf-8?B?d2d2NGU3Yk9sQk1IQ3hXVGFKOEp0MFd0WW03RE11bXNxUlVnd2MrVUErM2lh?=
 =?utf-8?B?cUI4ZVhGNmcyb3h3US9lb2d4ZnJIUkJlU3g2MExsWnpwTkkxRUw2cXMzalZv?=
 =?utf-8?B?STQzMXVhbk0vQmFOZ3hQTkxSU0RmeitzS3ljNE11N1BwaGtaS3cwRHlpWTMw?=
 =?utf-8?B?aEVWYjZoUG10amtTby9PeTdwVnZONzlLVW9va29BWXd0L1VVNmdsYkphWWhR?=
 =?utf-8?B?YWdzVGk2R1F6TWZYd1diTTNUN1dhZzhVTHozUTZwTDJEUkdEc3hldEFodzl0?=
 =?utf-8?B?cUt6aHlhK0E3ckROZDdQQVBRa1FsVzlZTm5tdHkvUFR2VFVIUS9VMHJBUHJN?=
 =?utf-8?B?Sk5nWTA1SE5FeFRQcUVTcXpiZkZPTTVYb1B4RFBiKzRDSTh6NnRPamdCRThK?=
 =?utf-8?B?cUI5c2hGZU81OFhxRzVlVmJtcDNmN3RqTTZFZy83eGVyOVlTSC9oc1VoaE0y?=
 =?utf-8?B?ejAwZndDaDdBZUhIa0NjbTdjTlYyUGIycEJzNERRU0k3TGx1eUhhUUw0dUFK?=
 =?utf-8?B?engva1Z6VkpiZ1V6eU5HQUZqanZNSmVDNzBSeHhwdUJEMFVhc21PMGp0cVMr?=
 =?utf-8?B?bHdrbUJlR1laQlExMHpaM3Nydkk0eTQ3b1JlMjQ3SUQrS0VKMHNJWjgwdEk5?=
 =?utf-8?B?dmI0c1UxWWk0S1NtNWx5RkN4QURkQVpFLzZBMXZ4ZVBDVVFFeXRqYVJPdGxt?=
 =?utf-8?B?cDF6WHRRd2NTUlFqQ3YrUG9FWVo4cEVRb044MllxcWNJdVFqOG8wWVN1YS94?=
 =?utf-8?B?WWdFSUpKQlEzUEZ0VGE5SHNLem9tdE1XOGovWjBjUHJZRW1FT1ZsNG8yTWd5?=
 =?utf-8?B?WXJXRG1NL0JFaDBXYUJXRzRzK1QvZUNYYURUMmdiaTNuUmxpMjcwV2tpQ1di?=
 =?utf-8?B?QnRpRHoyYkZsc1YvYjM2bDRRTFB4NUVFSUFMU3pNMDVIZDN6WVcvMDE5RWlt?=
 =?utf-8?B?UXRUQ0VPa2Z2TERucEdzOXBDc0Zra1Y2dHllUVVxVVB3VmVTYndlaWlRUnl5?=
 =?utf-8?B?Y2tFcVEwbWwrZWRCMmNybHZsbEZ0Njg4VzB4NDRRakVwdUtJeE5VQmdRV0tn?=
 =?utf-8?B?anpuSmU4Z08ybkVMK2krck5yeWZhaExEV1IvcG1CSE5CQThOM05Na0NvbWJS?=
 =?utf-8?B?V2FSVERqd1FMY1BGYXUrRGc3VDdyR2hWUFB1L3I1WEgxQ0c4VCtPVWMrRm9z?=
 =?utf-8?B?Umw3Znk2WmNLelNUcDIwVmExQmp0NHdBTVZBbHBON0tYZ0F6YkJFMW11UGd0?=
 =?utf-8?B?K2ZJWi9BcEVvVDg1NzZ2eVF4eWxQNm9ibGxUYVF1TlVpZEhoT1BlYisvZUgx?=
 =?utf-8?B?N081SDBsdXJneFNhUDFudm9HUkw1UFVtWlh6N3d0M01tSnNUNEpKRVdRazVC?=
 =?utf-8?B?YlhvUktjc2pBaDN1VU5Lb1lqWHV1NjdnQkQ0Sng5S2k4S1ZmK0cxSGdFT0ZI?=
 =?utf-8?B?YWs0TUltNnZXM3BrRlNCRDJWbXZkK2cwZDd6b3d6SFlhQlQweXBaeG10WTRa?=
 =?utf-8?B?UU1vU05jZzFaYThXTFgvdFhRcTUxdnNXV3hacmtTUkFPUURJTjRYYlI5bUR4?=
 =?utf-8?B?eExqUEtSSDdDa1VlVlk2YVZydWlvRi9aWWZaalFxWnF4NUtKb0FSaFB0alRv?=
 =?utf-8?Q?Xkym0+a9TI6C7jrU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d96f3173-09ce-4c16-7fac-08de5d2ae628
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 22:33:16.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkjL77C2s2vYbCSIu2z6nRXgBRlvF/kyCT6CJOVSmLGBALehtDXiIvBL3U8Xi9JBLMSCq68FjUHAOf3QbKqfdQwIJ0xP/OzZ+yfgH4JKUO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-75546-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,aschofie-mobl2.lan:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9CB5A8DF24
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 01:05:47PM -0800, Koralahalli Channabasappa, Smita wrote:
> Hi Alison,
> 
> On 1/22/2026 10:35 PM, Alison Schofield wrote:
> > On Thu, Jan 22, 2026 at 04:55:42AM +0000, Smita Koralahalli wrote:
> > > The current probe time ownership check for Soft Reserved memory based
> > > solely on CXL window intersection is insufficient. dax_hmem probing is not
> > > always guaranteed to run after CXL enumeration and region assembly, which
> > > can lead to incorrect ownership decisions before the CXL stack has
> > > finished publishing windows and assembling committed regions.
> > > 
> > > Introduce deferred ownership handling for Soft Reserved ranges that
> > > intersect CXL windows at probe time by scheduling deferred work from
> > > dax_hmem and waiting for the CXL stack to complete enumeration and region
> > > assembly before deciding ownership.
> > > 
> > > Evaluate ownership of Soft Reserved ranges based on CXL region
> > > containment.
> > > 
> > >     - If all Soft Reserved ranges are fully contained within committed CXL
> > >       regions, DROP handling Soft Reserved ranges from dax_hmem and allow
> > >       dax_cxl to bind.
> > > 
> > >     - If any Soft Reserved range is not fully claimed by committed CXL
> > >       region, tear down all CXL regions and REGISTER the Soft Reserved
> > >       ranges with dax_hmem instead.
> > > 
> > > While ownership resolution is pending, gate dax_cxl probing to avoid
> > > binding prematurely.
> > 
> > This patch is the point in the set where I begin to fail creating DAX
> > regions on my non soft-reserved platforms.
> > 
> > Before this patch, at region probe, devm_cxl_add_dax_region(cxlr) succeeded
> > without delay, but now those calls result in EPROBE DEFER.
> > 
> > That deferral is wanted for platforms with Soft Reserveds, but for
> > platforms without, those probes will never resume.
> > 
> > IIUC this will impact platforms without SRs, not just my test setup.
> > In my testing it's visible during both QEMU and cxl-test region creation.
> > 
> > Can we abandon this whole deferral scheme if there is nothing in the
> > new soft_reserved resource tree?
> > 
> > Or maybe another way to get the dax probes UN-deferred in this case?
> 
> Thanks for pointing this. I didn't think through this.
> 
> I was thinking to make the deferral conditional on HMEM actually observing a
> CXL-overlapping range. Rough flow:
> 
> One assumption I'm relying on here is that dax_hmem and "initial"
> hmem_register_device() walk happens before dax_cxl probes. If that
> assumption doesn’t hold this approach may not be sufficient.
> 
> 1. Keep dax_cxl_mode default as DEFER as it is now in dax/bus.c
> 2. Introduce need_deferral flag initialized to false in dax/bus.c
> 3. During the initial dax_hmem walk, in hmem_register_device() if HMEM
> observes SR that intersects IORES_DESC_CXL, set a need_deferral flag and
> schedule the deferred work. (case DEFER)
> 4. In dax_cxl probe: only return -EPROBE_DEFER when dax_cxl_mode == DEFER
> and need_deferral is set, otherwise proceed with cxl_dax.
> 
> Please call out if you see issues with this approach (especially around the
> ordering assumption).


A quick thought to share - 

Will the 'need_deferral' flag be cleared when all deferred work is
done, so that case 2) below can succeed:

While these changes add sync and fallback for platforms that use Soft
Reserveds, protect against regressing other use cases like:

1) Platforms that don't create SRs but do create auto regions and
expect them to either automatically create dax regions on successful CXL
driver assembly.

2) Plain old user space creation of ram regions where the user expects
the result to be a CXL region and a DAX region. These may occur in
platforms with or without Soft Reserveds. 

> 
> Thanks
> Smita
> > 
> > -- Alison
> > 
> > > 
> > > This enforces a strict ownership. Either CXL fully claims the Soft
> > > Reserved ranges or it relinquishes it entirely.
> > > 
> > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > > ---
> > >   drivers/cxl/core/region.c | 25 ++++++++++++
> > >   drivers/cxl/cxl.h         |  2 +
> > >   drivers/dax/cxl.c         |  9 +++++
> > >   drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
> > >   4 files changed, 115 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 9827a6dd3187..6c22a2d4abbb 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
> > >   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
> > >   			 cxl_region_debugfs_poison_clear, "%llx\n");
> > > +static int cxl_region_teardown_cb(struct device *dev, void *data)
> > > +{
> > > +	struct cxl_root_decoder *cxlrd;
> > > +	struct cxl_region *cxlr;
> > > +	struct cxl_port *port;
> > > +
> > > +	if (!is_cxl_region(dev))
> > > +		return 0;
> > > +
> > > +	cxlr = to_cxl_region(dev);
> > > +
> > > +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > > +	port = cxlrd_to_port(cxlrd);
> > > +
> > > +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void cxl_region_teardown_all(void)
> > > +{
> > > +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
> > > +}
> > > +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
> > > +
> > >   static int cxl_region_contains_sr_cb(struct device *dev, void *data)
> > >   {
> > >   	struct resource *res = data;
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index b0ff6b65ea0b..1864d35d5f69 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
> > >   struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
> > >   u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
> > >   bool cxl_region_contains_soft_reserve(const struct resource *res);
> > > +void cxl_region_teardown_all(void);
> > >   #else
> > >   static inline bool is_cxl_pmem_region(struct device *dev)
> > >   {
> > > @@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
> > >   {
> > >   	return false;
> > >   }
> > > +static inline void cxl_region_teardown_all(void) { }
> > >   #endif
> > >   void cxl_endpoint_parse_cdat(struct cxl_port *port);
> > > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > > index 13cd94d32ff7..b7e90d6dd888 100644
> > > --- a/drivers/dax/cxl.c
> > > +++ b/drivers/dax/cxl.c
> > > @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
> > >   	struct dax_region *dax_region;
> > >   	struct dev_dax_data data;
> > > +	switch (dax_cxl_mode) {
> > > +	case DAX_CXL_MODE_DEFER:
> > > +		return -EPROBE_DEFER;
> > > +	case DAX_CXL_MODE_REGISTER:
> > > +		return -ENODEV;
> > > +	case DAX_CXL_MODE_DROP:
> > > +		break;
> > > +	}
> > > +
> > >   	if (nid == NUMA_NO_NODE)
> > >   		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
> > > diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> > > index 1e3424358490..bcb57d8678d7 100644
> > > --- a/drivers/dax/hmem/hmem.c
> > > +++ b/drivers/dax/hmem/hmem.c
> > > @@ -3,6 +3,7 @@
> > >   #include <linux/memregion.h>
> > >   #include <linux/module.h>
> > >   #include <linux/dax.h>
> > > +#include "../../cxl/cxl.h"
> > >   #include "../bus.h"
> > >   static bool region_idle;
> > > @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
> > >   	platform_device_unregister(pdev);
> > >   }
> > > +struct dax_defer_work {
> > > +	struct platform_device *pdev;
> > > +	struct work_struct work;
> > > +};
> > > +
> > >   static int hmem_register_device(struct device *host, int target_nid,
> > >   				const struct resource *res)
> > >   {
> > > +	struct dax_defer_work *work = dev_get_drvdata(host);
> > >   	struct platform_device *pdev;
> > >   	struct memregion_info info;
> > >   	long id;
> > > @@ -69,8 +76,18 @@ static int hmem_register_device(struct device *host, int target_nid,
> > >   	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
> > >   	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> > >   			      IORES_DESC_CXL) != REGION_DISJOINT) {
> > > -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
> > > -		return 0;
> > > +		switch (dax_cxl_mode) {
> > > +		case DAX_CXL_MODE_DEFER:
> > > +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
> > > +			schedule_work(&work->work);
> > > +			return 0;
> > > +		case DAX_CXL_MODE_REGISTER:
> > > +			dev_dbg(host, "registering CXL range: %pr\n", res);
> > > +			break;
> > > +		case DAX_CXL_MODE_DROP:
> > > +			dev_dbg(host, "dropping CXL range: %pr\n", res);
> > > +			return 0;
> > > +		}
> > >   	}
> > >   	rc = region_intersects_soft_reserve(res->start, resource_size(res));
> > > @@ -123,8 +140,67 @@ static int hmem_register_device(struct device *host, int target_nid,
> > >   	return rc;
> > >   }
> > > +static int cxl_contains_soft_reserve(struct device *host, int target_nid,
> > > +				     const struct resource *res)
> > > +{
> > > +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> > > +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> > > +		if (!cxl_region_contains_soft_reserve(res))
> > > +			return 1;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void process_defer_work(struct work_struct *_work)
> > > +{
> > > +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> > > +	struct platform_device *pdev = work->pdev;
> > > +	int rc;
> > > +
> > > +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> > > +	wait_for_device_probe();
> > > +
> > > +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
> > > +
> > > +	if (!rc) {
> > > +		dax_cxl_mode = DAX_CXL_MODE_DROP;
> > > +		rc = bus_rescan_devices(&cxl_bus_type);
> > > +		if (rc)
> > > +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
> > > +	} else {
> > > +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
> > > +		cxl_region_teardown_all();
> > > +	}
> > > +
> > > +	walk_hmem_resources(&pdev->dev, hmem_register_device);
> > > +}
> > > +
> > > +static void kill_defer_work(void *_work)
> > > +{
> > > +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> > > +
> > > +	cancel_work_sync(&work->work);
> > > +	kfree(work);
> > > +}
> > > +
> > >   static int dax_hmem_platform_probe(struct platform_device *pdev)
> > >   {
> > > +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
> > > +	int rc;
> > > +
> > > +	if (!work)
> > > +		return -ENOMEM;
> > > +
> > > +	work->pdev = pdev;
> > > +	INIT_WORK(&work->work, process_defer_work);
> > > +
> > > +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	platform_set_drvdata(pdev, work);
> > > +
> > >   	return walk_hmem_resources(&pdev->dev, hmem_register_device);
> > >   }
> > > @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
> > >   MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
> > >   MODULE_LICENSE("GPL v2");
> > >   MODULE_AUTHOR("Intel Corporation");
> > > +MODULE_IMPORT_NS("CXL");
> > > -- 
> > > 2.17.1
> > > 
> 

