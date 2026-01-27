Return-Path: <linux-fsdevel+bounces-75668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NvPJEJMeWmzwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:37:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CFF9B6FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74BA2301AD16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F392EE268;
	Tue, 27 Jan 2026 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hom0TIBY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B62D46D6;
	Tue, 27 Jan 2026 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557042; cv=fail; b=mvhbelB1L09TT+JZKGovgXYPneyakem2wdhjx3X6NZmZbWbOAr5OqrFIMtuc1pRwjcBS2aemXWYw51lgjqY3aMu83Dj6+ivJPohkAjAh1CNOwIKkM+YmmANVU77CMBzaj4Zf78jScVwrNjx5u+pn1HiVhoAiRMInxerQjZ/NmZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557042; c=relaxed/simple;
	bh=Q1QkPTN6rFU1EyftQurJd9pVACrD3a/QtV0tcPu9GgQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=JmzJJt5MgdcAH4Ll8QvnkP5V6s629Z13kJM49ybX5KbQDsBTWcuY+YzaD4hvhoIOoMxC6Roz1Wyvww9BjSd2kgsCrUutr3qir9/3NFKKFPtoOc3SBLDSHvJN2A6EIZV/Wb+J9fk1TTaSwTrw4vtIy0Jwp9QvdSY4zW150FjvqfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hom0TIBY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769557041; x=1801093041;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Q1QkPTN6rFU1EyftQurJd9pVACrD3a/QtV0tcPu9GgQ=;
  b=hom0TIBYzeBGbdq3LF1D+zXYZcnns54sW2QZkZFwnPJddXh2f7PZBDY1
   3osusJ7SHgPe+/M53RzNuidaHHvP/+qe8A+8QapzTklQVUqWUe9n1qakT
   rvYbC+CTWKea4+oD/JD8pMoMYXQgJ3WPZdPqTQ+6K05hg0X0rLst7YoZ4
   qrldTK+EKHjNMvawhoV4RPJSYbtBQWsdlpgBPH3JpfToZxpzTlFNUOpBO
   5jHvAThc6QYgO+N2Y1VNIKTs26ozcahukWldY4PE5sIYqSfMR+SsdxDqv
   owN4I66KGFxlD9vzBz5xy6x3E2AGjYQEqDeasLbCUgcR4hcJ7Dowq/8qu
   w==;
X-CSE-ConnectionGUID: LYzbVXHyRMO1gdKtLFQ4QA==
X-CSE-MsgGUID: DobCC5UETya7XKHjj9vkXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="58338335"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="58338335"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 15:37:20 -0800
X-CSE-ConnectionGUID: LHcjL8cKTk6wlQ5Awe1mQQ==
X-CSE-MsgGUID: xFx8hK3iRB+ZH2MrCJ9LrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207343381"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 15:37:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 15:37:19 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 15:37:19 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 15:37:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOU2JoRii6NWxehsFmkh0rqWZr0yCGvk8ocE9NvdR/tX1UfceoVk0lFPA61bP0DYrc5I+7qza+ktqHjqsT04VfeirnwjyGXyIdBlUADIR0+jb+5KBbqskXZ/sCaZVrZIjl0IQvo3vJw+7nMQbFZ5bg0WB9ShOlsgwt/8sIslMPnEtd3ct/krbiBx7O9JkPvKJL/GAguRCsGvoQVosb6LgARAtYlb3YqQ5ZhvZN2sBtCStBMLqwLqD9PysQ0kU6yV3vSzoK6cSWsuYggehRwxECVJrCliVjoANtyRdukLz8sZyhHwj00xWq1LC3VyLORPy+ST/nR4vmn+MeUQJZZaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1QkPTN6rFU1EyftQurJd9pVACrD3a/QtV0tcPu9GgQ=;
 b=YZ9oly9iTbjZPzxD8KZOdtv12b4XvVC6LliHR6EFEJSGucHyhci0LGIF0v6IrnI0puRHCsyCx1iAODaMbq/sSS3qZemV0HVd/Gm5y9FoHo5f7gnEWOtzLs+O9QbV+3VqRL2fE8eycNbyziRHCqYza/L7TbiY7DcWiFWvt+xUIeEg4KR3FkyZDOIou4WFeyiagD+k/wcfVzRmksOxbkeGXHbCOL8f8x1GeaicIFZWMltdAG229ZJ/+NOVJtY1UnpZ9HUvbojCyDq0FjRyDfgucCMZT3rpfiFp821+7xyEosIKE47cmVDXs7L+YFuYPrtJma/tVYITLItNWIi8IPtH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF10012BF96.namprd11.prod.outlook.com (2603:10b6:f:fc02::a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 23:37:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 23:37:11 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 27 Jan 2026 15:37:09 -0800
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Robert
 Richter" <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, "Tomasz
 Wolski" <tomasz.wolski@fujitsu.com>
Message-ID: <69794c2512bfc_1d3310087@dwillia2-mobl4.notmuch>
In-Reply-To: <9c5150ba-c443-4ce1-a750-57736f0dabf0@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-4-Smita.KoralahalliChannabasappa@amd.com>
 <20260122161858.00004b0c@huawei.com>
 <9c5150ba-c443-4ce1-a750-57736f0dabf0@amd.com>
Subject: Re: [PATCH v5 3/7] cxl/region: Skip decoder reset on detach for
 autodiscovered regions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF10012BF96:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b42c36b-640a-4641-9c25-08de5dfcfe10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3RMcmdlMSsyNXZSRjBRWjYxK0pUZ01sNE1QRUowSjdkZXJXM1psSmtNSWVs?=
 =?utf-8?B?S2x1RThhMzBwT0IwaVpGa3pYMjlSQTV0VGpITjhOU3ZTWnhSS20wQld3emlQ?=
 =?utf-8?B?UnpxRDlYUkhVcldiZmFRcndNVVpvNHVicjhHYnlXaFc1SlJpWUphS0N4ckZv?=
 =?utf-8?B?azZIdmFERE1tYkUvSVlMV3BnZUFqNGxNWDR4OHZZbVU3QWV4UEQ2Q0t2VnN5?=
 =?utf-8?B?RG1WZVYwTVJqa3c0ODUwS1d2Q3B2aFRDK1BCUWpCc1lxRThpdFlhSFQ5OGN4?=
 =?utf-8?B?YWgzdFRjZ1lrSmROYmRpWVovOFoxUVBlWklCczZXNkY1ZGtiU2xGNHlIMDl4?=
 =?utf-8?B?c2I4R1d3OEJhbEcvaUlkdElhZjhUWGxRSE5RU0dZVkRZS1V3cjVSUStNLzV5?=
 =?utf-8?B?c2Jtd1ZIalVseElSTmhJOVJpUURaa25KL2JwdDNzZlJJZE8yN3NFSjdtVk92?=
 =?utf-8?B?aDF5bkFxL2oxQ0xOQjdhcFJDRzUxZVNGODdEWkZtaHNQdVVYV2plN2RDRjBt?=
 =?utf-8?B?SFphWE1NSEV1ekgzeVNCamlaNjU5cVVObDBpcUZwWGVZQmFQMGdYQjJNV2dT?=
 =?utf-8?B?cDR1N2djVWtsc0hHai9OcnRLMC9aZUNTZHVQUGs4TGh2RWZRTWFIOERidXAv?=
 =?utf-8?B?UHFhakxCd3hSNUlvYjMyakZWcWJ0U3NDZllZV3dLNEFtVXdNcWJ5b2Flenc1?=
 =?utf-8?B?V0U4V2ZOZTRrakFKMFUvUHVXT1BUSlgvZFM0OHhGSFBsQ3FsVkRVSE4rOWZM?=
 =?utf-8?B?YlpVOTNzRkNlaklGN2w4cEcvZDNDcFdaem9MTG5WSkJaeGQzcFhlOVF2Y0tB?=
 =?utf-8?B?dCtXRk5pU282c2h1aVVyMWVtY0V2U2l0cnRUbCtYSHJsRHZncTRHZUhOOHIw?=
 =?utf-8?B?VGhWaEtuN3h6ZDQyZFNuTUE1dVFFTm9wOGcvTStWVzQzaTJQa21FeFJnQW4z?=
 =?utf-8?B?elFheWRPZDQxdENYTVNsa1dnWjMyRVdSZTdrQlhFblBMNmxUeTFHUVpsVXRG?=
 =?utf-8?B?Vk4yLyttNEwyUmRsU25DVlVJK0xwcXFUT3I0Sk5yaVYrK051WE5oZnByOWhw?=
 =?utf-8?B?RHhvZzVFd3JxeGY4YityL0VKUXdHdmJzTUx4ejNKbzg4ZnphUEFIQWFNd1lG?=
 =?utf-8?B?NG9ONkhEclgrSDlndWVSUHVzYzg5bEM5UkNQTnZ3UFR1aklkKy96c2NIUUFh?=
 =?utf-8?B?Q2svRjVsT0VoWEtaNGRzaENWU0JYKzFDUTBIQmEzWjY1Tnl5b1phMHVOQ1FG?=
 =?utf-8?B?bVJjTHdiemdpS0FldDZHTjRiVXVKeTlHMWdMQi9KZyt4VUJTTjVxamI0N3Mw?=
 =?utf-8?B?MUsrVzZLUWhyeThML2U0dmhMempUdGZiM0xyR3BQTEJDVXpHeUZBc01CSDAw?=
 =?utf-8?B?WlpVSVM0TGlJVHRqQzNWMjE2UVJXd2tGOUdvM2dIeE00c3M4UGJRKzF4bktS?=
 =?utf-8?B?VkVCbFBzTlBMMnJ1TW8yVm1aQm5JUTgxZmQzSFhhSE4vQjA0LzgwSEVMRkVs?=
 =?utf-8?B?OTlaUnpsK0lGTnViWGVrR3Fua3hHSTlpcEZ6cDFnalliY3ZWMW43Q3dHRFlz?=
 =?utf-8?B?WjY3S0xrTjRibHhpNXRZRE1Nc0g0cGx2U09zTjZlcmttSXRaRWk0b1VuRDBZ?=
 =?utf-8?B?YTlwcmM5WWlINSs1eWVPWXpWOXNvUStseTkrTlBMRGxFVlNYUTVzRFNPNitj?=
 =?utf-8?B?a1J2K0JBZUo1M2VVdkFXdDRMcFVzQmFhbE5vVEhDdmFoQWdmbmFDTmR6aXYw?=
 =?utf-8?B?UEIzQXZjRVIyRzk4Z2lvR3k2b05oTGJwL0p0Q2dyTW95VkJpT01pa3QxUnJp?=
 =?utf-8?B?bEMwNHF6eGUxUCtmZUQySEZ5QUxQWTZRYXFFT2tDSHVvb0pZT0g0RTMwbFpW?=
 =?utf-8?B?ZGl4OXgxblJvTlh0a05KWGUxWlUrQ1FBNUc4RGN1Z3R2REZWWk9MSCtoNmho?=
 =?utf-8?B?UnhLOHYvUXUzZXFFVVFyN0pGaGNBb1M0UXBYUDlSWkVtS3VWYmhJQ1VieFBj?=
 =?utf-8?B?dTNiUUpTWUpTRU5XVnQ5UUMvZmpENCtGQnZmVkRsZ0IxeG9CZ2tKbXZFSHB4?=
 =?utf-8?B?QU5Yb2s4T1BaYWx6YVVmZk80dGQyblNWK0JZUzVKRjVNZkxkMHp1SS9CeVU3?=
 =?utf-8?Q?NZ6s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZXNS9mbHd5bWxhdDVDVjdIcUhvcWVvbUZ1VkJHWXM4QUR1djdmZlZ4VnpL?=
 =?utf-8?B?ZXV1WVp2QmlhS2JQQktISnZ2TW5ZaHFmWmtmZVkzUGR1TGloZWpOSVhBUk9T?=
 =?utf-8?B?VlZ4YklMdUhYZ29Uck9DWGd0eEZFVHdSTVhwclV5cFJiS1FLRTFEdS9aUXNW?=
 =?utf-8?B?UWtkdXQwOTVDKzhsT3YxODlJRDEyRkVYTnZUR1VoaXUzQzFERzdtbHlHajFN?=
 =?utf-8?B?R01aajBQNWcvazlGM1p3RldNeEx1ODhVTVZudUJXZ1dxZ3R0V0NLdk5Ed2Fk?=
 =?utf-8?B?d2xFb0pRUTBVMHdaN3BTeTYrVEk3aWJxSys4NHV1cGxWZVNGYzFzVzhlREc5?=
 =?utf-8?B?NE1DUU95aTB0VnI2R2FyTVVQbCtvVTc5SDIySldjcHB6MlZnTFJ3ckkwcXE3?=
 =?utf-8?B?VThJUlRCNGErTnNDTVA5aWtGTHpXcDZHOVJlSlVoZ2tKamR3ZzgxOXRrYU5s?=
 =?utf-8?B?V3BYQ1RtcVd4cDRKT2xEWDBIcjIwbDF5Mkg0eVdBaDhaak9GVVFVbzdoNkdr?=
 =?utf-8?B?Tng0WjFJOUlwdnRaajBJOWg4M1dvN2lPVmpieC9qTWRPK2ppdlRPNmt0RFpw?=
 =?utf-8?B?bE5zU2hyVWZpK1hEcDl2RDh3QkREelh2Y2ZiRjV4ejNucEh0UExiYnBQOUtC?=
 =?utf-8?B?VUxwSUlzNTRkTVQ5RG5UV0krdy9CcXkvOFUwcjllMWNRWUh0Tk93b253alEw?=
 =?utf-8?B?cXV6OVdTT1Y1cHU4RVNBTGJpdXRWNHNYUmhaaVlVK1JIamdWN2JENlErWEpQ?=
 =?utf-8?B?Q3hwbHVsRWpmYlNYMHhXdXpBSVNPQ2Q0ZWMrK1ZlRWdGdkozcFVCN0NKRzBR?=
 =?utf-8?B?NVNSdkkzRDhyd0FoWWNPQWI0UDR0b3U3bXBlMmlaRUhFelZjWndUVmh0YmpV?=
 =?utf-8?B?Mitna1VnL3R2ZThPdlNkell2RytEMi90UnN0b2xWWlAyQmlpNlhzd1o2Q1cw?=
 =?utf-8?B?R0FCOXcvM0wybkE1cmJmYTVBdXFZOU4vdkcxSG5JM2ZYSUVaZUJsNjJuM09m?=
 =?utf-8?B?SUR2SndRcFQvT3hJYmpwRThNMjUyNHpwMlFSZGxHelcxYTFuS1QwZHlzZkt2?=
 =?utf-8?B?V2VGeGpZb1JySDJ0YzJSYVpYbnJOYTBKU2Y1ZXZEWFF3aWtzOUI2NUtNQzNW?=
 =?utf-8?B?QzkxQ2VEL3hpNFJOeHZHZ01NNHpwWU1tVDRoaFkzYW9WemNMd05vREJFc2U5?=
 =?utf-8?B?RnkyM3lNYnlaaWIyQjh1ZWE5d3VDcmtFQ3VHMUtGbk9FZUlKWWZsWFVnUjJm?=
 =?utf-8?B?bHdZUWxTU3lVU3RIVHpjeWJoZjhLejR5MXJQOXVkWGhKRUlJSjNSWkVJdExu?=
 =?utf-8?B?eDF0SVMwKzBKNk0zY1lXSGJEc1JoWmZoSzBIRzFyOWNWck1VcWlTQ2ZyWW5X?=
 =?utf-8?B?TU82V3IrNlVzV1FDYzdwdzE3aFhPQ2gwYUFRRytoSVF6QTZWMUdqaEt6UFNs?=
 =?utf-8?B?RlZKd1V6b0NOZ09VbThEejdFblNPdTlXYWQraEM4SUdhR1Vtb2VEemxDTmpv?=
 =?utf-8?B?RDZvZTVPaS82L25DWHNmR21XUUVwU3FTUzdQU0gyVFlYME9PKy9sNitJMlIz?=
 =?utf-8?B?Z1d4aU84clZuM1dJOGN6RFdwNjJWd25WMnRYR0x4ZHZWZEYxcHZkOGJkdU9s?=
 =?utf-8?B?enZzck5KbDRmclVQeXd5ekN6aFdwaHlyNWhsZFJwbzRaMXd4RENSN0FhaEdw?=
 =?utf-8?B?bU16ckZGTDFSZWpxSG1UMlgwdWN3NTlQUzljSHNGTXpOZGVPTHJXUkZ3ZWZh?=
 =?utf-8?B?YVcyQmRPeFU2OTBrZVNUSUFYaDVONjd0Rm1xNzVLL0VtV0FFdjN5Y2Rjd3h1?=
 =?utf-8?B?VE1BRjNjL3FJbTgrVXZOVWEvendzaVVVYnYzRHNxcXhiOC9TNVV3emJpSG9n?=
 =?utf-8?B?QXJCdjFOMHBtTGtCWlVtMG1ZZ1Q1M3hySGc3Rk5wOGxWNDJxQUtueTU5ZHlY?=
 =?utf-8?B?WG1rTUxadXBwcTZmeWVsUWtJNUdMb2p4YVF4REZtQk1raFRyb1lHdlNyUHFh?=
 =?utf-8?B?RWtUcUlwbVMzTlBSbXBaR1NGZGlLVm5RZFJyL0hhOG5WTEp0TFlKZjJRTmRH?=
 =?utf-8?B?bnlEN3pCdFg5dHJpay9yYXMxdTNHMjZkbTBxSk5JMmNIbkNGTFJPOHhWQ0Qv?=
 =?utf-8?B?eVZFaVQ1dVZycnpEZm54ekxaUlFwakd1WjlJL3c5TEpoamtxT0ZIK2lsS2lw?=
 =?utf-8?B?Ykx6RStjQUpWWktDZ3p2dkRseXVZL3ZMcHJKT0ViZ3YrMXFNVEE3cjBRYWFO?=
 =?utf-8?B?MFdTV0JFZlZkc3k0Tk5SZzJTcVlxRDVFRER2c2EzZFJXejV0ck1LQmpydlZK?=
 =?utf-8?B?eFhhMmkrb0RjSHVTWkd4RUJ3eUNZVjZPZ1FnU0ZvaEx2RWtVcC82bTlRQUZz?=
 =?utf-8?Q?7RwNAQ90x4hMgPks=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b42c36b-640a-4641-9c25-08de5dfcfe10
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 23:37:11.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vFe+rEP+HvuYDqTf7kYkQOoFKv/lhG4amRf5pGCmsEynEaCijSEgwPooWb4a1tKX3hbAmMNi/IemRjFQHHdwhsiUMpSrkhPPi+IVACcCLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF10012BF96
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-75668-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E5CFF9B6FF
X-Rspamd-Action: no action

Koralahalli Channabasappa, Smita wrote:
[..]
> I=E2=80=99m re reading Dan=E2=80=99s note here:
> https://lore.kernel.org/all/6930dacd6510f_198110020@dwillia2-mobl4.notmuc=
h/
>=20
> Specifically this part:
> "If the administrator actually wants to destroy and reclaim that
> physical address space then they need to forcefully de-commit that
> auto-assembled region via the @commit sysfs attribute. So that means
> commit_store() needs to clear CXL_REGION_F_AUTO to get the decoder reset
> to happen."
>=20
> Today the sysfs commit=3D0 path inside commit_store() resets decoders=20
> without the AUTO check whereas the detach path now skips the reset when=20
> CXL_REGION_F_AUTO is set.
>=20
> I think the same rationale should apply to the sysfs de-commit path as=20
> well? I=E2=80=99m trying to understand the implications of not guarding t=
he=20
> reset with AUTO in commit_store().

Linux tends to give the administrator the ability to know better than the
kernel. So if the root forcefully decommits the region, root gets to
keep the pieces.=

