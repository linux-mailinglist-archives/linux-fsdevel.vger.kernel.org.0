Return-Path: <linux-fsdevel+bounces-70488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC992C9D3A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 23:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6080A3A64BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE16C2FBDFA;
	Tue,  2 Dec 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGvwvd3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F42D6E7C;
	Tue,  2 Dec 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764715061; cv=fail; b=i7jzus2QFZOhF5gnjNmBoSAgcR0+JevEJBuhBGzONsIgpwfvSwY2X8lBzqUBIFtbFvBuriOpSE2zQajQbRLEtdr0VJTAD+JYdogA9EZd4LT2stBOq31c22qn6ORT9A0Ly3pUvrlXUxeaNTPNND1+VNvtsRa1lFppX415x7BV7GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764715061; c=relaxed/simple;
	bh=H5h+JBjfJAdN29XXsd/YxQJLNIs0764YUXsjnt/j214=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=bNKATeP3xBjFpESage9clt3QFrxiThV7rKJs4V5WpWuZGN0a5coVOrt3a/1TqM1xwgeEwOK1IKZqRm/+nzkhAQF+IonaSTviKf3ZVOm3acJSHIOoC1fdm2xJWRvgje/MtlN7N7egxeUEr90CW5wiOCv5IFb9YLybPolwkQ16z5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGvwvd3O; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764715060; x=1796251060;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=H5h+JBjfJAdN29XXsd/YxQJLNIs0764YUXsjnt/j214=;
  b=NGvwvd3OQoa5IRNVDvRkaxYSGQJ/9iSFm4Xpq4UOYrUUwJesyiL5hWcD
   mb6PKPJCS12+xse4SJlCx3tg8ZYKcZfDBpM+Mwi0DR6o5UogDXRsd7npP
   KUA5QEISe0cAki2IvxRpKMyatxHfU5ynBCZrD7L7eVniNtP+K+HIiOpIt
   gOP5vIFeVQEA71el50B+N2h2WgWxUIC0SNXaQor09aTuVbEHwhbOW4x8e
   LFRhZSf7Atoc6NjzgJmKooMvaVf5E+Pw0Qp9TMIcFwJgRpqNRup6H0Nzd
   Wm1ptQk4UO1/bykH3b02830dHB/eeue/a0Wd1LMv41kZuf11iJ4ZFArzT
   A==;
X-CSE-ConnectionGUID: yhouiuZKRCqnQEd9ENRqCA==
X-CSE-MsgGUID: XSVv6z0STlm/Ozm+k0F8rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66589331"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="66589331"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 14:37:39 -0800
X-CSE-ConnectionGUID: nkNO66lgRWW71Byev7FIpA==
X-CSE-MsgGUID: M6yv+YLXSeaZNIzkFv0N3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="194603858"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 14:37:39 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 14:37:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 14:37:33 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 14:37:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs8/BlD9JFMB648gYk0ZNqG0JAbttgGCapK4gaRc9N+4l+WvPWRl1Byg0QsMZP6zn+dLWR5zJ2nysrRi7tQqpXOBdejkYIAGJA2GoB5RkeNj8YG7iaUldVJY31xJXts9vMmINHAKbhC7TWA8LB8spbWYQ18Q5reOHoXrb+UF2UGOMaSDVd8SzErY0po+AekJOXQvlnB8O9NGbDKJSMYpkNNjC12LsbFGPjo+JPsN/iEtfOFucR4x32Ym93WnUDgP++mZhiARmHgYhacCpda54iIrmYY5+ohM3d6gnaIW6hw5NBl3mbVKODAnZafsKpmK4TzLlHT2N8zodHjx8ls2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHeZFtgvUgkoCJ9jOd5ZgOjZusctTqFeHQn98VBEeow=;
 b=p31lZTpmNPKO47eDdkOYLds71sBzHMv6XmJvKQqBIFd5h0GKCqWgb9ZuUM6vCU1ZvplA2chDTViwdrpcSUtHYGB6EUSJw3Y2YO1bURBjUA9mm3bb8G6yRI3meBxkyEDYCxzac8N2Fw55nzpSdYagFIkcH7shAD16KuZpX6gi3mNaAXvXM/jxF6rR9i9VFfEM4iJb41jppUWGo6faTnPugAN6MZtSKPn+XSx8KJzE9OnCT5uNPPVQ7zIRPijOhFWBOncK857YPlV9ojep2ujZbILKL8bsr1LVsjOp9gNi/eCsEpjtKhNoa2xMNWtNZJZ+vNH2fwGn1iA9h+KvRWWAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 22:37:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 22:37:21 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 2 Dec 2025 14:37:20 -0800
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
Message-ID: <692f6a2035c79_261c1100d2@dwillia2-mobl4.notmuch>
In-Reply-To: <20251120031925.87762-5-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-5-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v4 4/9] dax/hmem: Defer handling of Soft Reserved ranges
 that overlap CXL windows
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c55d84-16b6-4b4d-c4df-08de31f35afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2hMOXM4aFE1NXN6V1ZidWd1ejNhNkduMnYrclNaaHUyUkJGV1gvWjFRZTc3?=
 =?utf-8?B?OG9GZGRqVE4vYU9zLzRxaE9GY2dXRS9obGhVNFhnZWVxZVJEUTYwRjMrWVVR?=
 =?utf-8?B?L0l5ZDdSN0Jta2xUOGZCVTBjNk5vbFJmSUdTZHVYTzN2OURJMFd2WklJbjk3?=
 =?utf-8?B?ZDRLWVNCbjYyc3RBa205ZVYwWkltMEZpOTgxeVlQWTRvYUJkT0JSWGQreTBF?=
 =?utf-8?B?KzE5bWRHKzVGNUxBVktLeVkxMkx2M3QwS2pMUzZlaHJpcXl2b2lyRWxEODZi?=
 =?utf-8?B?TXVwNThiYXh6L1pZb1V3SzRvRXZ2bmVPcEQ2akRxRzFlUVJhQ1F1Wit0MHpi?=
 =?utf-8?B?S2tncHZwcUFRVzZZVU93MGMzcGE1NGxuczNUcTVERUV5QmRBOEw2dVpoc2lt?=
 =?utf-8?B?cTd6UGVIaVFvaGN3anRzendDb3kyYVo2WEtOY1JPYnBmV3N6YWRqK2VXNVE0?=
 =?utf-8?B?b1lkeXRCTTFqYlZrcFFaRzdOYkVtaHpqaUUzZ255eDJleDJvWEd1M0NueFBy?=
 =?utf-8?B?c1c0Q3BtYVF5MEVjUUNoWktSMElWWDRNNXM5bVJUY09kYmRrd01ncmRMei9v?=
 =?utf-8?B?cjBWcmF4dkRDMXFpSHdGSVpZb2xOVVp5MSt1M3ZmSGk0L25LNldCMHUyS2hj?=
 =?utf-8?B?S3ZCeWw0QkpuSEFsUndJYmh6bzM2RnlJOGtqVFFhMktlREY4ZWpKcmJCMHZS?=
 =?utf-8?B?K0FZSG9oNW1icEtsR2VHSitWRW5Jb1ZVdHJhakYvYTEvZkxHRkZwY2JNT2tl?=
 =?utf-8?B?Z2hXbHlwMGYraXVrWitoYm1uUXE4bmtOUzNRbU9mcnJSSGhSR2dTTi9XeG1C?=
 =?utf-8?B?WnlRVjRVQU1LQVgrdXk1a2ZwV0N4WXlaOXYzeGhXVE5XaDVLMGxyOHFVVUky?=
 =?utf-8?B?SUlmaVZ2aU5kLzJxakhwalRzSk9uRWUrSzd6eVpFcTIxYVkzYTRDZkU3N0VY?=
 =?utf-8?B?V1B0SWdUOWMySGtLR0VaWXRXWEZjcGZFdEwyOUVIY3VZTGVydWNwZlJuVG1a?=
 =?utf-8?B?VGxwRzNSZlViNlRMN2JDNks0OXJGbEdSL3lkZURzNkVJekdMc3ZXR2o2L3lE?=
 =?utf-8?B?NmVKQnIvMVUwbyt5OE1jcTgzRjRXWkRHenRxUjlaZTlZVDZQREJEYTk5YVdY?=
 =?utf-8?B?Qk5OUXM0WjZOQS90bE9UU3V0cDgzU2dpbHJYT3V0K1hGRllobUZJVzhJL3VY?=
 =?utf-8?B?a2RNWDB2OGVhdjVPQTBSZ25xSnoyYlZQRlZJQXo5WG9kaW1wZHRUazhjQnBQ?=
 =?utf-8?B?Zk5HWmdZQkZjQzYyMFB6UUNWMTJWbFJQVTY4QUtnSUpJWG9CTnFIVms4ZEZ0?=
 =?utf-8?B?R3NGTzM4OElmN3hKWmpEbnROa2p6THE5c3NGU3BNTjE4YnZKK29SZDJWWWxZ?=
 =?utf-8?B?QXAySkJ4djVuRC9WdnJXU2JVZG5JK29Vcm4ycW1hL3Y3YTNhZjRwUXBrcU45?=
 =?utf-8?B?b0IwV0orOXBSUDg5ejc2RGphNlh5Y2dZMWlrMXM3dkdLOHhnVW5iVEFZL2Z6?=
 =?utf-8?B?ODFISjd5SmZoVGQ1a21YQzJEUjhKcGJ1aXlZNjVRMnZsUWw2b1htQ1Z3MzZX?=
 =?utf-8?B?bUd6cjdCUVVGZlYyT25pYyt0M2M4RkpHWnVUQWxKWks3UldVM3J1UzNTQ3ZI?=
 =?utf-8?B?bHZVZFVaRXRwNDVFT2EzeGNudVBZYVVyblVpS1JvM2ptc0s0cDU4eEY3VVIz?=
 =?utf-8?B?VnNhdnpySTFDWGVqYXJ0UUxXVGxNRC8vOTZnWkEzcHpnMVN4d0FlUER4eTlJ?=
 =?utf-8?B?dlFCNitkUWRXc0Y4V3c1ZXI2Mjk5RC9PZ2JacnZ2VThqcnJXejkwYUJnM2Nm?=
 =?utf-8?B?bDhNaUVXN2pxSXZKSm90MTlLU3pWVXdsa2ljMXp6UHZQMXh3ZUI4dVBqa0ly?=
 =?utf-8?B?WGwxWGljY1ZRNkhjaVAxaWpGT3RHTkhTQkxzMm92NHNUYWovejN1R3IvcFdO?=
 =?utf-8?Q?tecoDF3aomhWGc78Vn+30cjAiFSzMcIq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1FqNXA5ZXFpNlhpZjdqMnZoY3g1eWJ1cmNyb1hjMk5Yemh4bWhmQU85MWZD?=
 =?utf-8?B?aHZsVVhRV2FmTnhaaUFoWklFQmptYkZwMDVIeHBpZkp6QnVBZnBlOXNKa3l6?=
 =?utf-8?B?a3Q2K1V3aUVIRHNicnF4WVlaa3dWT2k5bHZ6ZGVXdmJrSWVkdCttczRFOHNM?=
 =?utf-8?B?NzM2YzFGbnIyakpCamJBcldqMTJVU09uSGJybXVSRllBWHdsKzBoRnB5QU5q?=
 =?utf-8?B?QkJrWVVpby9QcVQrTWxUQlVlampZR3pIdEMwUkRkY05NTzl4dHRuREhMMHpS?=
 =?utf-8?B?azQvdy8xcVJMOWRXMndhZTNUTGlHVmUwL2dtS1IzNFJENVVrc0UyaHdtSmVT?=
 =?utf-8?B?YWVLVVFnMVd6cTloWmhVb2tJOHN1T2VPSnhRUURwYVd3UjZKQXkwdnRjQ01t?=
 =?utf-8?B?Vkp3YlJ2bnhublRJdTdUYVhxVUwvdzFwRXVXSWt5TVVwUnRTNnZ1SDBjUDdk?=
 =?utf-8?B?bnFBeW5heVI1NWx2cy95VDJvMFBvbENPV3piK2NOT2VBU1RUOFFYb0oxT2ZZ?=
 =?utf-8?B?L0UrZm5kRkFubVQ2SzRWekFKdFNodk5VOCtRYnVYNjkzQU9STEkrbUJuelM1?=
 =?utf-8?B?WGt1WmVWb201eHpRM0lwdmYzLzJkRDZYaUlvKzRpNWJmaURyT3JJMGNyNStj?=
 =?utf-8?B?L3lEUFRTR3FYYlppdXVTNWYrZ055Y1haSWpkM3ZNd1Ztb2VwNlo3THhKTTF6?=
 =?utf-8?B?cXhxb1NuOGxTVy9SdWdLWUVkUWtmYXFrUDYyZWNYb2ZNQTJ2ZDZ0cllLY2Ro?=
 =?utf-8?B?cGpYOU9pNWxBTVlFaG4xUC9QeTNyKzBBTk9mdnVlaXF3NE5QOHVVaFdoaTRT?=
 =?utf-8?B?WVJRRnVJNmZaZHFHNWNUNlEzekUxTnk2RGl5SWhqY01BcG04d3FRNnhUelZm?=
 =?utf-8?B?bVZCdkdSM1BVeHRSa253d3pVR2FxMDFzMXg0WjhINDFtVElUVm9BbDJYbGRq?=
 =?utf-8?B?WmVDRTdxVHUrZTVjS0pma25IY2owNUhheGVHTlcxZFBBTlRCdnI2eWQrbURM?=
 =?utf-8?B?eTVZUit3WkV2SVFteHFhQ0xPbkNRbDVxOC9USEo0QnF2UjRsYXZ1R0U1QUVK?=
 =?utf-8?B?WmpUNlRaRk5UNnhzRUtqMTJHNFRGTkdTcUQrNzdiMDdEd0ZaSGxSUFRaZndi?=
 =?utf-8?B?RWIrWkRBYVVNNmhSVXM2TWZnM0U0c2ErVVVQK0t3ZXMyQTZXK25DRUl1WTJr?=
 =?utf-8?B?UWd0dHlNdXB4UWJ6WGlnaEk2UFVmMkFJaG1IdGlldVp3UlFFWUhiNmY3ODlm?=
 =?utf-8?B?dnhzaTgwV2FmZG9obUlhUjBDMnJQbFBLOEZWVG5tQjRXeElzOFpsekRLODVX?=
 =?utf-8?B?TzkzRWRpNllyVVJ6bFpLVzJGSTBadEFPSkd0T2pXUDJHM1lxV2l1RGhLYlNZ?=
 =?utf-8?B?OUNMb3ozQXJOWm9LdVg3UnRPY0lMaEhJLzlQOVpVOEt3L3dxV1J4N1dKY3Ey?=
 =?utf-8?B?VVZGNWNxWERZMzdPWDZGNHBvb1ZZdURHdnFkL1ZOK3I2SndWVnZGb0dualhR?=
 =?utf-8?B?dlZsTXlKT2doN3lDVUpPZk9yZWNkT2RwbDBVZVNMSTkySFJManNaN1RMTGpT?=
 =?utf-8?B?c0hOM2FjaVFRUDd0a0Y2M3BBTFJ0bCtXZHJzTWZVYWc5QkMrSnJhcDhDNmVv?=
 =?utf-8?B?cnZrZ2ZQTVE3Vnd4Si91ZkgveEY1V09nY2FXU1hKOGVzc3pkOWlIMHFlSXBo?=
 =?utf-8?B?UitvRmNaaTFmUDJoL2dRcSt5Y21oTkFaRGt3S0xXTy9mV2xvbVR0ckVpbXZM?=
 =?utf-8?B?YzVpREMzZHZkT0ZWTHBmRzRZMDA1RlR3OUg2MmNZSjdxUHR6b0VHS1pad1Av?=
 =?utf-8?B?eWZXK3BpMkhKUm1INXQxZkpqWFoyeDF6a3NzWEg5UGlrV0h1UllsWjdkcEVs?=
 =?utf-8?B?YlBPaXB1eHNKckdlSGl6QUZVRlZISytlS3ZXdXFETS9LY1RPSHc0ZkdUWmZq?=
 =?utf-8?B?QlR3UTV4eFJtT3lpdzhsVWFDS3JlMFVjRHk0a0VOU0NtTDd1OUVKcDNOZng2?=
 =?utf-8?B?UXZxMkp1MGZreGxIUjBXRW9tT0NOZHBwN0pjbFFZRDFuRWtJZHpwYUFPYzh6?=
 =?utf-8?B?ZjNVckJvNTdHNEdiMS96WTlsNHJNY25JM0ZTTjBNS0Vwby9CYTV5ekpTUnln?=
 =?utf-8?B?ZEpqTk42UTcxTUp2aXpVYmYzOThkNS9wdmpYaEhtM1IzRXBBS3VUeWI2RG1r?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c55d84-16b6-4b4d-c4df-08de31f35afe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 22:37:20.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdlKHD7XTHBIqni7g/GvZiHwi9i2b742rW/KAlWR1ZE3w4WH/suNDLbyLsv+IMuw0792EMOA8SG9VER9+O+N1B/L9bq99zzcrRNP1vWJo+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Defer handling of Soft Reserved ranges that intersect CXL windows at
> probe time. Delay processing until after device discovery so that the
> CXL stack can publish windows and assemble regions before HMEM claims
> those address ranges.
> 
> Add a deferral path that schedules deferred work when HMEM detects a
> Soft Reserved range intersecting a CXL window during probe. The deferred
> work runs after probe completes and allows the CXL subsystem to finish
> resource discovery and region setup before HMEM takes any action.
> 
> This change does not address region assembly failures. It only delays
> HMEM handling to avoid prematurely claiming ranges that CXL may own.

No, with the changes it just unconditionally disables dax_hmem in the
presence of CXL. I do not think these changes can stand alone. It
probably wants to be folded with patch 5 or something like that.

