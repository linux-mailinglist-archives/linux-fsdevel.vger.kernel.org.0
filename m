Return-Path: <linux-fsdevel+bounces-60600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23EB49D44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 01:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BEE1BC75ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 23:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A217E2F0C45;
	Mon,  8 Sep 2025 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSg8kOcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDD15667D;
	Mon,  8 Sep 2025 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372493; cv=fail; b=Mv1Gpnjm5wrnkWL+IKrN8aHO81r8glj4Mogq7cN81hnYXxohUmSrh+FYsIHCTJDWkuF1/chamNjnF90ilyY7mx0CTNvu4DTK+7hPZeEZoALSpou0tZahwj0PqALwGRKNKKoo3NvSMzTHZ/ezWDpKbYnzOGMkPwsXWEN/OuObVkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372493; c=relaxed/simple;
	bh=iUalprXwUX2gNI7B8VhvmCzH2004QMepD6gfHSVvOqc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WuYtSAbYZ9/bsJMQX2WtB9EMmlUryBbw1DcWxOTUH4yEKi8b0dkVo6FgyUICt/ZU2Wb8RGCggU44WBi6qcNh5wLe66iQcv7nvKPZrfCvRRYQqJeeFFQvBmsbJ9NRPYxsDVOzr6CVQA8b8U4q7dvSYjVvSGFMzVQSQEml6VQKBMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSg8kOcb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757372491; x=1788908491;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=iUalprXwUX2gNI7B8VhvmCzH2004QMepD6gfHSVvOqc=;
  b=nSg8kOcb7WhJVKo2EPcn5TqEIB8608yGW1Y7GNHpX2mYffL7AL0F2wRB
   NDTL41xFNCHplKEAGRlaq0VOq7vQimWA3KFOJCiWY/gM3swCwwrMHld/r
   hjuUKHY2FF5J7zVTs58EUJXSMl2XBtc0WM44znIo4rPcJxDzD51NYE9IS
   bey4oqvC9k1J0k8SAUu/Qoyc6oj7hAN66hN5F8cAMXV1gjIth8BgPnsYx
   TNHiTj5uvFjfetoTxpufoxxe/2qCKGGiNomY7+AmxsPldbbeQuzNCG5iB
   X1U9iS+X8Zu2+oV65mbVZwJrUZSiZsYpXGQ0xZNM6FQ+vpZCVKIuZFLQT
   w==;
X-CSE-ConnectionGUID: ZthAc8TASi2yL8IHur1GXA==
X-CSE-MsgGUID: sL5q9SNYQiGesviRhK3oTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59752266"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="59752266"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 16:01:27 -0700
X-CSE-ConnectionGUID: Y07/gBceQb290VRSsAvsyA==
X-CSE-MsgGUID: JUK66x50TqygzAnhK/dhHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="203700479"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 16:01:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 16:01:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 16:01:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.87)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 16:01:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAiQYJ4cwqCtS7YDck4to6RwuOwp2OAWpfrThVLYHxs+ybgIzI0KwILd9Fn1dmODfPrbi/3LZ6UOyF2XNrGxVmNQYggLcRV4QtmySdY/oq8s421hYKoK8V2yazstMM1C6qgODmvfkGYBanCufycxhSUDia+XtcMw4ae33vqtD5RCot/7rGXTxCPOKYfbbuIXpZcUZdvPhCBpU+CgrKKhs5h4Owh+UuD3gKVNglSIKrm0VYJk6NAWAn/cQerZhjEIpw6KncDu7juzBz4cSAkrfCiDQpRay0TTRxYMv8jjRI5cxXjfKCWU3+nHfWe/7JZCXtwHzXFMUgDbIE4L+9Cqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDkQoNzrarVB/LDfXZ6cMdslgjUpWrnYjoSVH4okblg=;
 b=uZ8jw6dDhGYC197hS5f4uVjmmsF0eab6ntgN0MacBRG3zE0NjfvsU/6K89viMhQLeSGNXSGsvw7JBddUb1dl4jDxpyIrbhHuIbzgVmcCLV2Kkqm7G0TrP6d9/RJEcJfUNWL20P7bcY7qm8zH/AL39rHMk+deTwnvcqGDua6rqqkVEDwy4u3n8Fo5NaY6Zi4BWDsg/tGTQF5h7UGzHg2PVRVZ+UyG7OnPK3CabgGfjcWVVNaBZjE1HySB/xqMm2KXNVpizwxlEUcShaPXtlpV5CaXUijdO29+ZcTVGlRHomiCLKOA3foOleXSQj1uTpdJedsxeapXqHC1HMIoTlMgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 23:01:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 23:01:19 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 8 Sep 2025 16:01:17 -0700
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
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
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>,
	<ardb@kernel.org>, <bp@alien8.de>
Message-ID: <68bf603dee8ff_75e31001d@dwillia2-mobl4.notmuch>
In-Reply-To: <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 1/6] dax/hmem, e820, resource: Defer Soft Reserved
 registration until hmem is ready
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: bf143fed-88e2-446c-b76b-08ddef2b9f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHVMcEF2US82RHNSVkhXWDRkcjNqOWQzU05iQlJBWFBIYnQzQ1ljWG9oRUtO?=
 =?utf-8?B?Z01Jc2NmK1pZZGFpZlRTbDcxS1M4ZGJYQ0wzYjg5VlBrdCtINHlpT1E2ZlJr?=
 =?utf-8?B?cFNCZXhtVzg4d3ZONzdTbVcyQW9Ga0dHT0hhRVk0U1FnY3UxRHJNbHF5Rmto?=
 =?utf-8?B?SFMya0k2cWFONzJZdkFCM2dVTkNWUmNwek0yeEFvNFF3VWc1d1pmNXNGd3BO?=
 =?utf-8?B?WFVPRnFPOGR4U25ic0pTbjdEOWQrTEdqbkR0K1VjL2dlb0FwalFBY0QrU0tK?=
 =?utf-8?B?bmY2NXE2enlDVzRyNWI0Slk4akZqVWdDMUViTmdDdzZoeGVKVG9mTG43UkVr?=
 =?utf-8?B?SVNXZTFObTJ3Njh2WEVCVk16cXRQWVA1d09saHUwYzY4RFB3RmIzaHl1WkpX?=
 =?utf-8?B?Zm1DL0w2cmVQRUFPZ1F1RGZDMmRieGRic3RHTXFvVXZ1STJiQW1COVF2UHpH?=
 =?utf-8?B?cDBOcG4xT0dlanRkVUJINlFwN1pWUGFBdXRvL0RXVmc2V1dlU3IxVEp3RDhB?=
 =?utf-8?B?QWZwOGhKeFhxQTVieUFvdFRRc2FsR3ZPNkhlMnN2a1ZLN2JVckFWREN2MVdJ?=
 =?utf-8?B?MlFLQXhvQjRLZE5JL0JKVWI3NXVScEptc0l2MWFCZERUcElwU2svWmhPcUVW?=
 =?utf-8?B?UDcxbVBMM2lxQVA4dXlsTy9ad0VaQ2crclQxUE85bFF1cnM4Z1lyekF2SXcy?=
 =?utf-8?B?SWJUbmVaZkF6QjA3clRSeU5EbDVyNmVaamVCWjV4VnQ0VmNDMHJVUWJXK0N3?=
 =?utf-8?B?V041VkdOTmVCK0ZpVXF4RFN2clhBMjJIU2hsWURhOFNjVlFzSzBCRmNDN0Y1?=
 =?utf-8?B?R29GcmRKR3dYTjh0OSt6RENZOUlKNi9MeGxyT1VIdEx5K0czb2EzRUhoVCtR?=
 =?utf-8?B?UWFvaDFaODdEaEs1MnVvYThxK05RVDZVZVZveitIa2FzeVd1QXRrQ3pxT09x?=
 =?utf-8?B?aEc4NmtRK1ZKQW42VjRjRW9FMFRCY2NPcVVncFpNR2xnaUdTOTNnR3dRcC9L?=
 =?utf-8?B?VnFaWDlhVTRBSy9QYWMxM2ppRXlhNlVadURUOHZMcitLVW9tS2dhdmZaV0FN?=
 =?utf-8?B?K0hCTS9iNTMrcGFrem5oN21GL3pTV1hpajR5ajkvd2dqZ3NOY3hGZnBGckFX?=
 =?utf-8?B?WjBIYUVYNkdIZDdFS0hEYk1sempaM3VFcmlYZDlzaFYvdVVvY2ZDdDV0V08r?=
 =?utf-8?B?aUtTMWhVTkZTK2o3MFJPSmNSazJ1L3hSeEt4UFFkWDViSk9SbFdmUFVRM0pL?=
 =?utf-8?B?eENZUHVDWUdieUxXcXozelI1UEd6MnRGMWJnWXkxemkzSHI5NUlYYjBLS3U3?=
 =?utf-8?B?UVAza2tPcjF0UloyWk1mZDhzbkRWdE1OQjVhOXBZajM3a1dvR0ptb2NoSG9j?=
 =?utf-8?B?ejQ2OHU2bURERGpTbDR2ZlMvaVdRK3AyRG9hME5lZ2IrWWNSWUNjbllJZ1FL?=
 =?utf-8?B?RndqMDJtLzFFYVA3SncrczdPazRLZXVjL2piSFlsMEVQMk9GTDl3Ynk2d2cy?=
 =?utf-8?B?eVZJL2hhZHhtbFU3aGJiL3J1ejFNaUZFWW9RQjZldGd2N01lUzhrUnl1UUZH?=
 =?utf-8?B?NFU0WXN2dFFUZGpIa2VYd3dtSGVOanNHMVdkRjdoZXd4blpmMzVDMFRmOXRU?=
 =?utf-8?B?clZGYjVYUk9FbEhzOTFzZVdvcGZsbjJUeWk0eE9uSmtPcEk4OXFoS1EzZGx1?=
 =?utf-8?B?ejl5SDJ1RVlCdGFWaFpsVVhSaWVLd3dyM3ZDMHZVK0RQMmFZVndwU3puZkQ3?=
 =?utf-8?B?RzNnS3dOdVhLMEhHOSthMjdnTVNldWZsRDRBdDRUekNyMnR0WTFPMUJianBD?=
 =?utf-8?B?Ujk4V0FnYWZhUnhHWnU4MDVjT1hvMEdTUUZFZjY3bkpLcndFWDZIR1U5VU83?=
 =?utf-8?B?ZHlZRHJDdjdqYUJreThJNEwxT3dmcFRNZElDV1B1QjJYSUZCd2IrWXZPSVdJ?=
 =?utf-8?Q?jFfdvGU+bXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDFPdUc0SUczYXErZ2s0WGhNbU8xcFFSYkMrVWZ3RGY3UFpuWk1lb3BGWGtZ?=
 =?utf-8?B?b08wbURzTElvOCtjSEpnZjZFUEUrSFE2SG1zd3hRTHovZmRWd1Z1RUQ1bEZL?=
 =?utf-8?B?UHlSQjgybkJCZHZzdnplZUxvNzh3Z2V6N0gvcDVsRENhaGJ3V1VxdElDOTJn?=
 =?utf-8?B?OFpYYlo2Z2RHWjQ3ak96YUxCTGJoRVlwVEtDQWhqOW1DcFZIL3F2QXUxbVBQ?=
 =?utf-8?B?azJQNHllQTZ2dFpjdkdXUmhESCs1ajVUc25TN0cyQnBXYWFVVUtzUllOeGFi?=
 =?utf-8?B?Y3JDNzdKVjFKZmxXVCtoQURkejdDL3lPcm9oVm1KM21PYkdnSDVOd29EMnFj?=
 =?utf-8?B?TzVwZTBuTWt1cytaOUIyUmNXVW84OHB4VFhOTElkcFdSZmlZTXAwUUxtSURs?=
 =?utf-8?B?Ky9Fa2M3MkIyeE9mVUU1NkJuaG5naWtoWXVkZ25qNzhqcWRySmVFMUIvVWhT?=
 =?utf-8?B?U2N2MUdvY216M0QzN1hINWFubmdackJHMjJVTFBCZGhEcEZWWnhCM3FEOUo5?=
 =?utf-8?B?WlJqOHM5VFBhcnNXeCtvS1lNMzJLNEFUOFhkQXA2cStuUEhnZFhDblJielFX?=
 =?utf-8?B?ODhWMEk1MUs3UW9GTlUzYjUzbG4rMnJ6MnJFS2Z6d1RWNnVwTVZCWTZDQ3p6?=
 =?utf-8?B?c2t0ZFk5Y1dSYlhERTg3L28wenJ0bWdReDFqMzhDd1RleXB1ajhOdW02MERw?=
 =?utf-8?B?UXRuMzVUbzlEVzkyQ3hWMHZIbXBNckNxSTBDU1Awc3I4dHVDK0hHVEppZmFC?=
 =?utf-8?B?M2xmRHNvZzRQNTBpeE9GU2Y4SWdVNW85L293QllOMEZqbHlpcGM3dUZZekdV?=
 =?utf-8?B?dVFRQU91K09hdE5ob2hFdzJKbWJUZjZwRE1rQ095OXgxMklmVnVPRmlGTVh5?=
 =?utf-8?B?NFA4azFUc1drcmx6QUtNdE0yNkZIc1kvZ0xkV2pacmlOaVhRWi9GajgwV1Yy?=
 =?utf-8?B?NGM3OG9NL2JOc0Z2ZGp3bitqRkV0dWhaTTdueEVrUjlyWEhsQUZNZjM4Nk5R?=
 =?utf-8?B?VXZSUWFpbkVIbzlBOXZxb01yaGpQNWtaSWJCT0VuQnVxTGxVUTZEQWJuOW9l?=
 =?utf-8?B?VHBtVTF4N2tvL3k1L1RmQzZEWXJqMHAwT3RkUC9aMEIrZkJLbi9DbDdZejZj?=
 =?utf-8?B?S1c1S2ZjdkZYNndZQmdiWnFYRStRaEt6Sk01OU5ST1lVdmZZWCtIVU9QMnIz?=
 =?utf-8?B?Z3N0SVM5LzBRcmxYanlRclZXd2ZLL3o5Vmd1S0kvMmRQejJHTzVLVzhsbVlG?=
 =?utf-8?B?ZHAvNzBYblArdzlVZW9Ca2pUdEFPM2NhdnczU1hGb2F2UXdvbHhFSThzUGJH?=
 =?utf-8?B?RFNBejF4dHJuUjVhaGd1NnlSR3hjMDNiQTE3ZHJBWkk0RzQxVzFRdzZGdVRS?=
 =?utf-8?B?Sml0c3Y0aVJFc3VMU2ZSU25mL0QzY3Q0bFZsV3BZRUorTGVTTkJPcTgyeHJ4?=
 =?utf-8?B?aGk1UUIzOG9EcFJ3M3pkUmVsdC9TMUQvakt0RGxNUFVXb2F5eS84RWNSMWhY?=
 =?utf-8?B?YmpHTlQ1TlVSc21ENDZMeGs5akRBYUwweW05ZzdVMFIwUk80YzdoTXJwK016?=
 =?utf-8?B?bGNTYzBFbmJEYXNsT2dYZDhOVTU5ZTFid1dvTVdJUjNpYXNlcldKbmdWT2R3?=
 =?utf-8?B?TWl0a0VML1Q4MklVSi9kcW9IekVPeEE2a1BjdjRnQWU5NlZWWEk0cElSQ2dt?=
 =?utf-8?B?czgrOFF4SjBrL3ZsMkdtK1lwdmlOallDVE91bGUxOWlSWFcyMmF4YTB5Q1Ax?=
 =?utf-8?B?MWN2SmprVm8zWkt5RGIwWTFVcmRPbWxpNVE3MlFTSE50aGtLQ3FZc3BWdFI5?=
 =?utf-8?B?T3VQR0tFZ2xtUngwMzZGQUg1MGs3bEQ3eFA0cWo1Z3dwS1FjOFNPNU42Nk91?=
 =?utf-8?B?ajN5RkpnRDkxZktCbzFnM2NjY3VvbmJwaWo1aGR3TENpSTEvTmg2NXFMSWd4?=
 =?utf-8?B?S3YybmU0c3dlM2RIY0dKdExMWUkxZEFLTHZDalRNQll1YjJSVlZzejZaYVF4?=
 =?utf-8?B?cHVlRU5yY3p5QWZwcSt1Y1VtN2h3RCtaeDhjQndZUXVIenN0MllvMEl1d2Ri?=
 =?utf-8?B?ZVdpOERmNFR6eWJaTm5CVTdYaXM0b1dYUC9NTG1Qa1AwM2NNS2tVNExuMnQ3?=
 =?utf-8?B?QzlWTjMrSk0vbTNFSWRlSmY5TVkvYjZlMzJwZjJCZWdLN1haVENHaDhBUEtD?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf143fed-88e2-446c-b76b-08ddef2b9f7d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 23:01:19.7885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zF8/9SXNFrL6H/QYzzi9DI+ks3w8NwukezVSmzyT/bqLjQ5mLcD+sjSyPZw7wQNwny4FL9LIdm1axkzP/XDgIAXtHDrQ5k4x/RoBZ067sBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

[ add Boris and Ard ]

Ard, Boris, can you have a look at the touches to early e820/x86 init
(insert_resource_late()) and give an ack (or nak). The general problem
here is conflicts between e820 memory resources and CXL subsystem memory
resources.

Smita Koralahalli wrote:
> Insert Soft Reserved memory into a dedicated soft_reserve_resource tree
> instead of the iomem_resource tree at boot.
> 
> Publishing Soft Reserved ranges into iomem too early causes conflicts with
> CXL hotplug and region assembly failure, especially when Soft Reserved
> overlaps CXL regions.
> 
> Re-inserting these ranges into iomem will be handled in follow-up patches,
> after ensuring CXL window publication ordering is stabilized and when the
> dax_hmem is ready to consume them.
> 
> This avoids trimming or deleting resources later and provides a cleaner
> handoff between EFI-defined memory and CXL resource management.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>


> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Smita, if you added changes this should have Co-developed-by. Otherwise
plain Signed-off-by is interpreted as only chain of custody.  Any other
patches that you add my Signed-off-by to should also have
Co-developed-by or be From: me.

Alternatively if you completely rewritel a patch with your own approach
then note the source (with a Link:) and leave off the original SOB.

Lastly, in this case it looks unmodified from what I wrote? Then it
should be:

From: Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

...to show the chain of custody of you forwarding a diff authored
completely by someone else.

