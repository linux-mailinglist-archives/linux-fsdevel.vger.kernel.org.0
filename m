Return-Path: <linux-fsdevel+bounces-55002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92467B06457
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51DF18908E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242A274B26;
	Tue, 15 Jul 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nj+2jrWk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281C1E531;
	Tue, 15 Jul 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596903; cv=fail; b=ZydJEVo1nOg/bLKJwk/IWHMy5QKHU9HhjiRvr0uIPuzdat+xPS2lDsdjED2UFunepKkGd2c2B4dGAsBRe+WJAK5074xUWLHrMDhxvBvWg/y1KLN8zhODfvAi4Dd57WgHXiZUX3ZXtsPjEjV1RX7tm1YLdQO6s4OA6qQVSrvylEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596903; c=relaxed/simple;
	bh=GZbl+zsH3ArfSpxQgbwMD0/zaefbX2plT40Ml8WEhVA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jdD1AmtzBKSzOCBiiPm8YnXnDa57HLnnJ1N+5+5o56edj4m0tTSnjyypgwy8jd1477pGjVVIyLffjwKjUZT6dXwrPGrScVZa/8nG3avskvYoY78X4nj7GbUbeI9eVmd5LiqrDktmtBvb1rF3tYaTM/iv1zJBvKR572YQkqCK6ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nj+2jrWk; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752596902; x=1784132902;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GZbl+zsH3ArfSpxQgbwMD0/zaefbX2plT40Ml8WEhVA=;
  b=Nj+2jrWkxyCoiLI3KRSUIvZUkWh0zuLOmRKgAPo+NJEZF19bpfng0/3e
   VJme2NhYkfgcyIFWtDyy2/1pIIOwZRf7Qt7CNK/UyiG7QwKRIe7k/kOBz
   LRhtWZaSxzAqTQwQ3pyagjea6iWDHYFSgVDtVhbOE2vQv3fVlgAc9yIbQ
   3l5eu33ZdAj5beZXv2vVLbLjWoWXdtWKARcJsNFlKsEtbMOETpYhjIXuu
   3GndF2JZRJPG5CavpxhpX1nMiE0YioqAZQuDI20D9JILpfWnhAPrWUlkX
   //j6OC2Ss2uK5xkNzVfz8z7Ohi6KKdlmb4qXlD5Ps0PUfjsoC33DwfAYr
   w==;
X-CSE-ConnectionGUID: nDuKLmQ7SIuO2BESunIfdg==
X-CSE-MsgGUID: XuEN6n+DQEK1SIwWJAhuXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54972418"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54972418"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 09:28:14 -0700
X-CSE-ConnectionGUID: vtJtMTEZRLKaNuV9ymtFhw==
X-CSE-MsgGUID: IBsjptsNRoqXt6rU+sLFWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="188276426"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 09:28:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 09:28:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 09:28:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 09:28:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIFxFPO6JW5PoQJhrTWg+rnCiIhWXaPE1fxCetrvPgsxhertmNuMNsRv3joMtKNB0a/zknKe5z+v4nQasZk5+Wo63l+07BzVjZ/ytfg6cf6x/hIWNIzMwDa21ifIXQHCvCE2SczugLZ+ku7uxz4fSKy/japdOagO5EG3bRw/v4TgCfL32XVtREOGmfhNy6iaz8M0AeN7lP8MZO9F6SqK/1iOSctAyEsr9EHWmKn+yT20JJP5/ARZCx39h1pRTnYllyt8aTqOg4DAHVj6oKpq1wrtsWc/vMoGHXfrrvqE9jfossFslpRV3aQR6cdlfgTNVJxJ5t+SX0kLitfNBNE6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6QE7n75pUNPYzbuiMn4aRrc6eTwzjabaF9SJjRu4dI=;
 b=txgiGndfG4n3U10Kou3ptfIx519bTmMtVM4sWylQvpbfI6cr50VdKGAfCQMKZwCvCjw0Bxoz56S/EbENJb5/9MkqiVOE90DUn6vtuPqxuoxIAxiE5emRqM2eUb2lebZkhw15f+pWx0atfpi9jagaKbOgmfsA5H/h2apXODklUI9HGwRTY3789gxgchYlHZ28W04V+trZT0qhpclavxRqM6UFl9pk9zZhW5ouEVYMbJPfS4LrWTmxnbYnDMJ5f1f+mGbarHpxTdaB9P01KcA+fdEGj5EFnj0ybAigSEcYVdeFCS2OCA9pqN0FFLfv6D/NFNYHWv57UBex1t2JS6tp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 16:27:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Tue, 15 Jul 2025
 16:27:40 +0000
Date: Tue, 15 Jul 2025 09:27:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
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
Subject: Re: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED
 resources until after CXL region creation
Message-ID: <aHaBdj0QrEe_gymR@aschofie-mobl2.lan>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: b8997dbb-7bf5-461f-5dd4-08ddc3bc84ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3dHam5JNG9oeGRlblVHWEtxZ0RJUVJOZFpFMHhKSmZDUVFpVlE2UGtDZFZX?=
 =?utf-8?B?Ni8wMUxaM2NhUmdTVDFKK0dPb29hTGVrUlpBaUpoU3J0MHlEd2FlVTlDckp4?=
 =?utf-8?B?Qk1UVWZhSUFNQjNFdXIzcDBaQmNRODgzbm1xT3l0QlJ6UXNmT0FVMmdkdHJW?=
 =?utf-8?B?SEQ1UlhpNVdyTi9tZHRCdHFYcXUrNXVMelpKaHY0d0dydDYxMmhnbVJpKzZR?=
 =?utf-8?B?U2JqRzdSZDJOUzFQQ000MFJ3TVhzUmRybERKZmFwbWlFeGRXMGNDUkxrMjNj?=
 =?utf-8?B?ZE5xSTVxUUU4VlBYYlJxaXMyTDIya2hTQ3Z6N0ZiblhMYkVNazNtRHNoNDZq?=
 =?utf-8?B?NkJhM1IvZm1HVGx2WGJDRHdTRlpVa0ZibHM2UEZrcThuVjFrRTJ0NG5iOGQ5?=
 =?utf-8?B?cHo4TXM1Y0pRYml0bUVBOGthdEx6WFZOK3FJOE5HWEZIM2ZsbkhOc2dLUEFC?=
 =?utf-8?B?bStycUdyd25HQnV5UVBrWXBjNDdqdUtxNkc2cG9DaFdQckJvVmRhU0ErcU95?=
 =?utf-8?B?L0pXS3lVK3JvMllVbjYwOXNvUFZMeksvNjcraS81VWlkVmZEa2JMdFVBWlhl?=
 =?utf-8?B?L2llb1JWRktVM0Y1M21KTE9mMXhZVk1vWEREcjZuQ2JRYkovWS9Na1dFNU1C?=
 =?utf-8?B?dUlqcGhRaWN2ZmRWVk5XQ3U5djhnRnNsWFFUOCtZenkxd0pFcEE1V3BJV3pO?=
 =?utf-8?B?clg4N0ZtYUg2ZUJWUFlKK3h3eTBhNTY4dng4Y24xNTFxQ0huYVJrQkllaStY?=
 =?utf-8?B?NEoyVE1RQldsYlRiZmdUdnBSWVJQOVFFUFB3bnNFbUpEK2FVY1dmSUZTbzJS?=
 =?utf-8?B?RlRiVXY1UXYxcmZGbFZMdkRETVQ1a1YydklNMW9VZkhVdVd6cUpjUndmMUZl?=
 =?utf-8?B?VVBKM0hFUXlnWTBsRXRtRlg4dU1wZi9IRk9oSWtBRHVjMUQ5RmlVd0w0N2RJ?=
 =?utf-8?B?VHkwUCtmYVo3U1VjWVZ5angySHo0aGNlNXBNa0lGME5qR2MvVEs5N2NTekh1?=
 =?utf-8?B?R1RTOTY5UWdvM1JLS0RuYnlWTVRkc0tyS3V5T3RGanhzaWFyc2tUL0QrR1Bk?=
 =?utf-8?B?U2grVEdpeVZ2bHovcnowZktRMERxME5pOE5nV1dLSFgxOFVHMlpMa1oyT0JC?=
 =?utf-8?B?OTRFU1VXRDgyOXFxNkJ6eWZkKzd5SXlXL1U2cXJ6OE9NQi9kMUs5UVN5MVFF?=
 =?utf-8?B?U0dRdjZPNHFPS1NQaWw5Yk1XeTNyajA2QTdmU01YTE1PNTZnTWcrMHZaNWlV?=
 =?utf-8?B?REZLdytWTlhNOW1EdVpqa0JFU1VCa3k2T3RGWWJYYXJwQzdudTAvZFFSd3hU?=
 =?utf-8?B?RU03Vm8rZGlFVm1QVldZV1M1cW4zcEJGODZRVElpUVVRanlDd2JVbHhvL3Aw?=
 =?utf-8?B?SzVaRDN3R2tmTTYweURsclJ6Qkp2M1krLzhWcmNBZlAwaUlXZER5UERjWU03?=
 =?utf-8?B?c3pUY1pyWlRHaWZ4OGZDeUkvcUZVZFlMWEFEQ0tFcStUK2FnY05jbVNjRHln?=
 =?utf-8?B?MHpVSUFRbU5KQXh6YWpKQjlwTytRSnRCenZRdWpNRjM1UzZqVUFJdlI0Wkxl?=
 =?utf-8?B?bmtmNldGQXJ1T1JNdWV2cEEwTFlPQjhCei92MGtiekhyWW5rdTd2bnJXNzdI?=
 =?utf-8?B?R281VFZKaVkvTi9hVXpPK0NqMDFJRjV1TzdETkN3OFVYZzRuN3p3UmFlSG9l?=
 =?utf-8?B?S3hBYmRJZHRWMlR4T08wWkEzNHdLYU1aN2R6V3BLK3FReDE3VUo0RENNczVO?=
 =?utf-8?B?SU9JVWhaS1NVK2RiSE5zRUN0S2J5YUE0RGU0dFNUdzFUUklqRnluY2pjQllQ?=
 =?utf-8?Q?9GKz7DuMZhKJSRJALAZNNC8DwizJZFNjKBU7s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eSs2SnBxR1FPMXUyZ1J6eGQ4UDlDbE96RERVK2NqRnBLalNIMFJEM01HbDNU?=
 =?utf-8?B?WENmTFczUnJ2aGNFTG4xMFBpU2VFSlZpdHVoenFhSHRYRmxDUEdSY3FuM3ZI?=
 =?utf-8?B?WTJnL2dONXh2RXcrU2JEZzBLdk9ONUpTUUpFb2NKUTVIV0RqV2QrcmkwQkpJ?=
 =?utf-8?B?aWJUYWFJRW51cjlaaDU5RDRNTkVPRkl5SFprdi9WYkhmS0ZsOGNrUHZNSFdR?=
 =?utf-8?B?NmQwbGc1Rk10Rm9WL3FUL0ZYQm9SbmxtRFFobkI4dmpISnBDOGhsbGI4NXor?=
 =?utf-8?B?M2VoU1I2S2xJbnJRTW9Mc1h3ZDB0R2R4dlJ5SGdNZ2lTOU5zeEcwSTZWSjNi?=
 =?utf-8?B?MzBURmJkcHUwWCs3SkR4M2ZtUG9sUEl4YXpxcjh1bXR0T2I1MDFub09ZQ2RW?=
 =?utf-8?B?ZUU1V3FYZ1JnN1VNV29RampxTXY1RmdhbUdiRzA3ZUdZbEM1cVhkOW5BNDBD?=
 =?utf-8?B?T1VNbEVoVE5xMmJhK05LNi9XVm5MOXFQTlM2UmhFSkptY0g1bCtZeEltR2ll?=
 =?utf-8?B?WVJJZ0twTStMR3BJNThuNktncUNIWjBlc0R2RlRxSWs1LzVTWjN5ZVpPRDY2?=
 =?utf-8?B?T3BIbzgySUZ5K3ViUGdxSjVtNngxc2xWVmNlMi9TZ0F0ZUhwd3VpRnF0aEdB?=
 =?utf-8?B?UlVzRGI3bU13cTZmT1AyUVdPOWFFMThYZXVtWEh3M2RISFNNWEoxUjlpR2dw?=
 =?utf-8?B?elNGRVZoU2JRNEJYWFdydktWT2QzVEdjbFdBSG00WENYekpiMjF6bHlZZGVz?=
 =?utf-8?B?b25RQUp5VHlMUFFFY1Q5b1VPdWFVanRNT1l4QjJhZncwL2NZU3crUTdVTm0x?=
 =?utf-8?B?WWJMSHJWd2RScXJmTm1UTFE4N09QTCttUHhKS1QyaE1vaVVVUzdKTmZBRFNx?=
 =?utf-8?B?ZWlac3EyNEZ2ckIvL3k0TFZwMzZqQVp4RllYaWlmNi9uWjlSa1VRV2xaNjR3?=
 =?utf-8?B?c3NqL0Q2WlVMbUZxMlhEUzlEaFhqVmJSZVN5T3NxMnVKSjdmNFFGZXV0SXl5?=
 =?utf-8?B?cWNVazJ0Q0QxcU5qWkN6NXlDQmM5Z212Y2p0Qldzdkc1amQwT01ZamQzUGZ3?=
 =?utf-8?B?dnV5SnFHbk9WMlZTcEhDSklnSFRVQzg4NGpRTXpxMHBpKzFqcUNrVHFPNCs5?=
 =?utf-8?B?YndDWHBkWFJjMjIrSHJwTFhtR05hK1lTTUZ0cENIR2xlaUl3NXFJL1hEYTFv?=
 =?utf-8?B?NmIvOFdGQkNjTlhMek5MaXdlRHZrZU03MjUwSkR1cmlKK3IyYUdtOWF1WC80?=
 =?utf-8?B?VWdTMkd1VDhnelg0eVlkTmVyS2xweVVncjZYSW5uRXB5OHl4WEZ0YTVhWjFa?=
 =?utf-8?B?dnRDU3o1dDZqTWpGS05ZR1NTWGcwdytscXFQMnE0TVlOdXpseUlMakE2S2pG?=
 =?utf-8?B?VDhUb1lJNXArTjBhZmZTVmJMZmxsRWpmcWpleDFDckVtQWxiL2phUW8rWnhV?=
 =?utf-8?B?SEx2ZGVIeFNsYUxSTmNZRFNBYndoMCtpRXJpSk9ObmlyV3JGc3hpVnNTaTZi?=
 =?utf-8?B?N0w3OTN0VEo1SjF5WFlTTGNOMWZvOGFmSFFGUFBDN25pYndGVFMvVXhDc2pK?=
 =?utf-8?B?TVlRMHBYbTQ1YzRVTUY1UE1GS1lmS3FiNWUraTNlVXk2d3JmY1pmZGVnZzdT?=
 =?utf-8?B?MzUvS0l0TlRQakp5dkwxTE9kSUkyUWwzVHZaMXNURGZ0QnhBQUtON0VjMTdi?=
 =?utf-8?B?YjVCajdnMi9DYjNNUm5sd0ZCUS90ZWJDOXNqQVY5eFQyakU5bW1paXhQMVcv?=
 =?utf-8?B?NlVMdG9Ka085c1ByOW9DWE5pR2lJcTQvNDNEWlZZRXEyUDQwQ3pEdnZ1c2Vw?=
 =?utf-8?B?UVIxbE1sU0FWdFpCdE50aW1qVmYwcVFuU2ZYY3U0U0prUGFqbC9vZmFneFZ4?=
 =?utf-8?B?WUtVc2UxeXIweG0zc09sRVo2akVGSC9CeTgxYklDbVVjek1NYWY2NzRqY2xi?=
 =?utf-8?B?akZNMXcxUTlOcFlVem5zcDVaMURNUHVxdXVKQlNMWE4zcG5vdnBZVTR5Qkgz?=
 =?utf-8?B?RDlZV0x5V0ZkaEVSUDIrRW40YVU3VGtWdi9nMVFoMktLa3pPS3dWZGFFSnda?=
 =?utf-8?B?a2FzbE1heTBSZFlRWGhHZGlvSTJUd3JYRzRucjBBNHo0RlNvRlFpVytlRFRs?=
 =?utf-8?B?U3pMTHorQVoxTkVEcTRqMGo3ZktURXhram1nZkJNdmRxVGxFNHNqZEhDYjd2?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8997dbb-7bf5-461f-5dd4-08ddc3bc84ba
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:27:40.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8e0PptQ9RsInXvPN0pNCQhxE7EAptJFl49kTqTnQMK5TvjLu53mQGt2/4rzevfnVfgTU6W2LnFhGgs6yV+pkBphimauTTwCVf07lLXnTNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com

On Tue, Jun 03, 2025 at 10:19:49PM +0000, Smita Koralahalli wrote:
> From: Nathan Fontenot <nathan.fontenot@amd.com>
> 
> The DAX HMEM driver currently consumes all SOFT RESERVED iomem resources
> during initialization. This interferes with the CXL driver’s ability to
> create regions and trim overlapping SOFT RESERVED ranges before DAX uses
> them.
> 
> To resolve this, defer the DAX driver's resource consumption if the
> cxl_acpi driver is enabled. The DAX HMEM initialization skips walking the
> iomem resource tree in this case. After CXL region creation completes,
> any remaining SOFT RESERVED resources are explicitly registered with the
> DAX driver by the CXL driver.
> 
> This sequencing ensures proper handling of overlaps and fixes hotplug
> failures.

Hi Smita,

About the issue I first mentioned here [1]. The HMEM driver is not
waiting for region probe to finish. By the time region probe attempts
to hand off the memory to DAX, the memory is already marked as System RAM.

See 'case CXL_PARTMODE_RAM:' in cxl_region_probe(). The is_system_ram()
test fails so devm_cxl_add_dax_region() not possible.

This means that in appearance, just looking at /proc/iomem/, this
seems to have worked. There is no soft reserved and the dax and
kmem resources are child resources of the region resource. But they
were not set up by the region driver, hence no unregister callback
is triggered when the region is disabled.

It appears like this: 

c080000000-17dbfffffff : CXL Window 0
  c080000000-c47fffffff : region2
    c080000000-c47fffffff : dax0.0
      c080000000-c47fffffff : System RAM (kmem)

Now, to make the memory available for reuse, need to do:
# daxctl offline-memory dax0.0
# daxctl destroy-device --force dax0.0
# cxl disable-region 2
# cxl destroy-region 2

Whereas previously, did this:
# daxctl offline-memory dax0.0
# cxl disable-region 2
  After disabling region, dax device unregistered.
# cxl destroy-region 2

I do see that __cxl_region_softreserv_update() is not called until
after cxl_region_probe() completes, so that is waiting properly to
pick up the scraps. I'm actually not sure there would be any scraps
though, if the HMEM driver has already done it's thing. In my case
the Soft Reserved size is same as region, so I cannot tell what
would happen if that Soft Reserved had more capacity than the region.

If I do this: # CONFIG_DEV_DAX_HMEM is not set, works same as before,
which is as expected. 

Let me know if I can try anything else out or collect more info.

--Alison


[1] https://lore.kernel.org/nvdimm/20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com/T/#m10c0eb7b258af7cd0c84c7ee2c417c055724f921


> 
> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/region.c | 10 +++++++++
>  drivers/dax/hmem/device.c | 43 ++++++++++++++++++++-------------------
>  drivers/dax/hmem/hmem.c   |  3 ++-
>  include/linux/dax.h       |  6 ++++++
>  4 files changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3a5ca44d65f3..c6c0c7ba3b20 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -10,6 +10,7 @@
>  #include <linux/sort.h>
>  #include <linux/idr.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/dax.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> @@ -3553,6 +3554,11 @@ static struct resource *normalize_resource(struct resource *res)
>  	return NULL;
>  }
>  
> +static int cxl_softreserv_mem_register(struct resource *res, void *unused)
> +{
> +	return hmem_register_device(phys_to_target_node(res->start), res);
> +}
> +
>  static int __cxl_region_softreserv_update(struct resource *soft,
>  					  void *_cxlr)
>  {
> @@ -3590,6 +3596,10 @@ int cxl_region_softreserv_update(void)
>  				    __cxl_region_softreserv_update);
>  	}
>  
> +	/* Now register any remaining SOFT RESERVES with DAX */
> +	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM,
> +			    0, -1, NULL, cxl_softreserv_mem_register);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index 59ad44761191..cc1ed7bbdb1a 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -8,7 +8,6 @@
>  static bool nohmem;
>  module_param_named(disable, nohmem, bool, 0444);
>  
> -static bool platform_initialized;
>  static DEFINE_MUTEX(hmem_resource_lock);
>  static struct resource hmem_active = {
>  	.name = "HMEM devices",
> @@ -35,9 +34,7 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
>  
>  static void __hmem_register_resource(int target_nid, struct resource *res)
>  {
> -	struct platform_device *pdev;
>  	struct resource *new;
> -	int rc;
>  
>  	new = __request_region(&hmem_active, res->start, resource_size(res), "",
>  			       0);
> @@ -47,21 +44,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>  	}
>  
>  	new->desc = target_nid;
> -
> -	if (platform_initialized)
> -		return;
> -
> -	pdev = platform_device_alloc("hmem_platform", 0);
> -	if (!pdev) {
> -		pr_err_once("failed to register device-dax hmem_platform device\n");
> -		return;
> -	}
> -
> -	rc = platform_device_add(pdev);
> -	if (rc)
> -		platform_device_put(pdev);
> -	else
> -		platform_initialized = true;
>  }
>  
>  void hmem_register_resource(int target_nid, struct resource *res)
> @@ -83,9 +65,28 @@ static __init int hmem_register_one(struct resource *res, void *data)
>  
>  static __init int hmem_init(void)
>  {
> -	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> -			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
> -	return 0;
> +	struct platform_device *pdev;
> +	int rc;
> +
> +	if (!IS_ENABLED(CONFIG_CXL_ACPI)) {
> +		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> +				    IORESOURCE_MEM, 0, -1, NULL,
> +				    hmem_register_one);
> +	}
> +
> +	pdev = platform_device_alloc("hmem_platform", 0);
> +	if (!pdev) {
> +		pr_err("failed to register device-dax hmem_platform device\n");
> +		return -1;
> +	}
> +
> +	rc = platform_device_add(pdev);
> +	if (rc) {
> +		pr_err("failed to add device-dax hmem_platform device\n");
> +		platform_device_put(pdev);
> +	}
> +
> +	return rc;
>  }
>  
>  /*
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 3aedef5f1be1..a206b9b383e4 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -61,7 +61,7 @@ static void release_hmem(void *pdev)
>  	platform_device_unregister(pdev);
>  }
>  
> -static int hmem_register_device(int target_nid, const struct resource *res)
> +int hmem_register_device(int target_nid, const struct resource *res)
>  {
>  	struct device *host = &dax_hmem_pdev->dev;
>  	struct platform_device *pdev;
> @@ -124,6 +124,7 @@ static int hmem_register_device(int target_nid, const struct resource *res)
>  	platform_device_put(pdev);
>  	return rc;
>  }
> +EXPORT_SYMBOL_GPL(hmem_register_device);
>  
>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>  {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index a4ad3708ea35..5052dca8b3bc 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -299,10 +299,16 @@ static inline int dax_mem2blk_err(int err)
>  
>  #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>  void hmem_register_resource(int target_nid, struct resource *r);
> +int hmem_register_device(int target_nid, const struct resource *res);
>  #else
>  static inline void hmem_register_resource(int target_nid, struct resource *r)
>  {
>  }
> +
> +static inline int hmem_register_device(int target_nid, const struct resource *res)
> +{
> +	return 0;
> +}
>  #endif
>  
>  typedef int (*walk_hmem_fn)(int target_nid, const struct resource *res);
> -- 
> 2.17.1
> 

