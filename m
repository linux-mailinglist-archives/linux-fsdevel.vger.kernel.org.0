Return-Path: <linux-fsdevel+bounces-33503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB239B9A5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 22:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA1A281D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 21:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB9D1E884A;
	Fri,  1 Nov 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jxd2V+0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E051E7C2D;
	Fri,  1 Nov 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497652; cv=fail; b=ejz/k67tml3yWlczdbIcx59yskBcSDjSDPVO/cJ1z143atwdDA7Qdk8h7YiRY51BflsrW1r2+F43C7rmVyUUsA7Ds0/FEK9iZjVePJc5DgO+sVEMucSkYJ9FWcPtX8rtHlDwd3S/CWAmwW7QheGozbwFfZKyjGr/NMnGkT+M1gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497652; c=relaxed/simple;
	bh=4tx9Tvn5Ohi8wsxFdBREeCdyg5NgBs1lrjytORqn7F8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ue2d+1eg7XEYo8fOYBPpMgYgfEQkYQo7e4vObIMuYjzByeJzqPXmkjVnPWcQ0gbVB+ubede3UHTjZjPpnDmvSIVJfMYbx4yYlp2izYDvyxsv4VLckcEGsomBemAGZEuzgxcz09aR9HHLqGzMIO5bDqthKx1aPaxmt4WP8BG5FAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jxd2V+0r; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730497650; x=1762033650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4tx9Tvn5Ohi8wsxFdBREeCdyg5NgBs1lrjytORqn7F8=;
  b=Jxd2V+0rvLGTx8GfFRPi891+YoIQGf5uZe6WLNnzI1wpvforkhzZOg6p
   hXAc05xqLJBDQSAvB2DyCsZNCXTeu0dcudFkV1noVSAkvuSNNANmaXcyG
   9exUTaHLjl3Eh3u2z+HuEE5oI0XuxDghBiqz6r0U0QfPlKfhFO9Mz1czn
   m5MU0ff3km3S8PvD9Ho0KceZ2BFWumnmFHvVYN+8uTZo5mXjrJeFBqWzN
   pEJqBTyfpgj/LyoAp+8x8jZtoW6zYBN8XQ0ZBhhnthvfsMCte8Xo0FYyE
   Rnr1AagCFusJXKFnnYw3nawb9IwsvLFkE0SR11fBsWLPxUj+D/9wd6IsS
   g==;
X-CSE-ConnectionGUID: 0b4j4dFCTHanIYgeECw2xg==
X-CSE-MsgGUID: 7kyc2aojRFGe0gUwyLoTvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="34065222"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="34065222"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 14:47:29 -0700
X-CSE-ConnectionGUID: eMnWSTKBSRit8hR8feZkYQ==
X-CSE-MsgGUID: 3nqjim+UQhaYQkWF3egm2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="83203539"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 14:47:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 14:47:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 14:47:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:47:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy/qhcZvFXOodXsKXRI9zhpjunXrPPuNX/plD1OEPNgDj7Eb8gdHk7zvRN2gyWRb3IZT1Zqr7t+BYhqtu7hIOCpAd5MISFn99/hJA0TW33TBtK+Srkt79fIblHDbHKWA2Vdlpn1AqBnjynzYMcNxvT7GurZYqVolFO14jhAtYoyiNb1f4DgSjcio3mrM1aGFqM4F5b0VwDc4DlAb9af+DdYBqhNn+0a6keBJf/QoUuRsrf4SGiAV5XJoUcHpy+PzkdtJXTqMOAecUuogIA9honSxi2G5P03obBwV/X2IOg7wmJXl33Dl6Wn4Hw1zY4XW6xjlP5QVuzmtM/rITZEl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tx9Tvn5Ohi8wsxFdBREeCdyg5NgBs1lrjytORqn7F8=;
 b=rqRkl89yqxXEPiviHwN0gw8HRajWDMt2CXCo3wcyEL1edw11ZSBY41WmRFiD3qDWIpr6fQkAuL1PbEgV2t5i15UPEEFE8MhY1NuqJWseA5Rk8UpTNZ7JUzxLFu0UEkrvFt9D4TFheS7HNns8LYJkYqLN3+RpYZknYe2v+GgYqvIjZXxOExET/8JVDrW4mEMAvitIxIhmlcoetDrj1ld5PeN+SYFphs3DJ98EoFKWS18EbK9mvQTbFK2+ENFT4EGCR7UlqURyoRuEqtvlMJfvbINg5qnynsNZMz23kCWiwcT0yc35MRhRyFdlx6rnGlzEVYMJyxBj4Adc5GUWlfSpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Fri, 1 Nov
 2024 21:47:25 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 21:47:25 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "debug@rivosinc.com" <debug@rivosinc.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC/RFT v2 1/2] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Thread-Topic: [PATCH RFC/RFT v2 1/2] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Thread-Index: AQHbIBZy9P8dPHuOz064fRpxrHmBQrKjDxmA
Date: Fri, 1 Nov 2024 21:47:25 +0000
Message-ID: <5a89e49fe1f9d6ee2c72af411d40e2dbb1299759.camel@intel.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
	 <20241016-shstk_converge-v2-1-c41536eb5c3b@rivosinc.com>
In-Reply-To: <20241016-shstk_converge-v2-1-c41536eb5c3b@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB7276:EE_
x-ms-office365-filtering-correlation-id: 557f6304-42c6-4a50-f343-08dcfabec63f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WUVTcjczYzNJdmF6UzJublhkbktlMVIwWGhtM3gzVkFsTXpQaW1ROWU1YXF3?=
 =?utf-8?B?T05BZG9KbHBQYnZscUhGWW9mQjQ2NzRuckVLdFpVZy95Vzc0dFVIUHpxbURv?=
 =?utf-8?B?NHVTUFNoNm1NUzRURXQrUWJjNU5YcGplNzlBY2ZKSXNIWC9UVEJBdVFiTS9I?=
 =?utf-8?B?RTExV1ZvakNTOXlDWTRSQS90T1Rad1o0NFBNSU5zeTFtOHl1ZGpMN3F3eU8r?=
 =?utf-8?B?RWluOExjUCt6WG1nOTA1TUxIbCt6YVVsU0JDcGZuTkJ4SytGcnBwVThwbUQ3?=
 =?utf-8?B?bHZpQmJIbmlnNHpmMkVPN2ZOZTRxY0ljcnd6T3lObWtHYWtOaHdyOHRycVZK?=
 =?utf-8?B?SElRWnl5cE12UWVRVFh4d1d2VTE3Y240dHhmdFRRSTNlNUQwUnBpMW1YaW1w?=
 =?utf-8?B?WVRvRWdIY3Z1ZXJmdXJhcWtBbU4rVnVxck5rc3pwaFYrRmk3K2VFSnJYZEVX?=
 =?utf-8?B?VlFjaGZ5b3Q3cXc4eDdRV3hSTk1EYmpLZVJsOVl6MzM5T0o3bWdOd2s1Sitp?=
 =?utf-8?B?UHRIVFBYQWFwQ0RCUkM4Znczd2RRVkNtUmhuWEtkclc0cUpubTBiVlVCSzJI?=
 =?utf-8?B?dHdwMGprOGJqT3hWV2VkMUJWdzM3QmpFUjY2amp1N3JOWWhZV3FScFZiMVpw?=
 =?utf-8?B?VFlPMWNDZHVqQmNTWDhBMHRXUHZZUGFxS0NCR2llTzQzY1NNM3Q5cU9GMEt6?=
 =?utf-8?B?QmJlQjFTcy9wTHRwNXZqTWtZYTdxZFpwN2xtcVM4RnNOdmlNNnpSa1IwWlVm?=
 =?utf-8?B?VGhoYVE5aXQrZTNKUHB3WVN0b1RIWnIwS1B4TVloYW96VmsxMy9yZy9obVZm?=
 =?utf-8?B?emtubTA5dDF3bktPVjlid1dKY3A1OCtMU0tHa2E3Q1l2ZTgzYXNUcThSTEdw?=
 =?utf-8?B?Z2NOZ1ZLdHJoT2NONHlpczUvK3I0b2hETkt1MUJtYjEyRkV0aGNqS1I1ZDhl?=
 =?utf-8?B?aitOdDljOUtzVmhTa0kreEZXc2hZOW04U1p1azgwOUFCMjJEV3pRcDFxQW8w?=
 =?utf-8?B?L3k1ejFSZGs3NFc2Sk5IMzlqT25qL3I1QVowbklHS1d2UkZFNTBJZGR0VGw4?=
 =?utf-8?B?ZXBGVUpST2dTSDJTeTdOMHRrUHFmQ1ZVc055cWJyM3JVdHBlMEZCR2VkTVRr?=
 =?utf-8?B?b1VQMWxsb2xFeUhnV3FDYUc4UEI4L05aV3hYaWlSdnM4ckc0TnZTSmJTNGdo?=
 =?utf-8?B?bXVFcit1S2tDN29zeWdrS3cxaG85K3RoVUpmTzlnUzFaWU50M0Z2WnJ4eVFm?=
 =?utf-8?B?U0o5YzkrS3RPeUFOOTJGb0dUU0NhSE54ODh6dTNENWo3enlhZHUzZFRDOGtD?=
 =?utf-8?B?SVk4dHM5dHlNNmJ4anlnOTFmakxiWjRKcUZXajdvRi9aRFdvSkU4OWl0RDds?=
 =?utf-8?B?eWZNV3NzNnJKRkgzeWt0TlIwenBCVFNuMjFITVlDQU9GZ0lIZE1HNCt2d3RT?=
 =?utf-8?B?bjZ1RWUzcmhNeXlLeUl1SjR3eS9qYStJMmt0S200aSt1TWZmNmpUVWpiK0NK?=
 =?utf-8?B?Tk9UR253ek5BOCtSbnFmWHpxTUovWEdQR3U3VSt1NnhUQjl3eURGYVVHdVda?=
 =?utf-8?B?T0xua1RLRU0rRWFOR1NHOHFzdDh0TEJCUEV6WXk0VFpCa20xbXAwWkxzYzll?=
 =?utf-8?B?QS9maDBIOGx1cXpnS01yZDVlNlo0NEhYczMzR0Ryb2t5MmxVTVRNUEFicURp?=
 =?utf-8?B?QWRvZ1dKTWIwYjNOcU80TGFIZkJxZnRDcGVsUzNGY2wrandPdUVLZFJudzZk?=
 =?utf-8?B?bVNYcHVIeGc5OHZaMjRPUnRIWm9DVG1scFVXM3RqTU9Wd05vNisvejE5V1VE?=
 =?utf-8?B?SU0rdFZzMHNZNFBRSlBOYzAxd2FnczdZUWR1VGszSmp0eVF2N1Q3d0hoOTlq?=
 =?utf-8?Q?+Sdqg+sMY986+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajRSZW1Nd0tmMlluZ25ndjB0b240emUyeW9udWVqNFdGL3FvblA1UDJFSkMz?=
 =?utf-8?B?ZE90YTJvZFRFVHJIb0JSTVdkeFh1MUpra2hVZjVDSkNlNlcwSFgvZkdVcHp4?=
 =?utf-8?B?MXVpZjF3VUZGYUtWSXY0SlBsVXcxTitEZzFjMFVDWFNTU01oTk0yV0hGRHBp?=
 =?utf-8?B?amg5Wm04d3gvNEZkbWNLMUlxZzc3OFNvZW51YjU4NzF4ZzMyQzF3dnVKODFu?=
 =?utf-8?B?elhKd1o5aHMyeVMxRlpwemkyTkxaejRiMGNsclZUY2s4eHhHZXVxZzdYUmc5?=
 =?utf-8?B?UXo3cjlHeVdpK1hvSkhXL1hDWWxrSUJhaFE5eVN2V01EbjhQMTk4bEdCNXlM?=
 =?utf-8?B?K1lxTC8reWcwbVRlWVNKMTlzeFZRNWtDMjh3RVNHcFpwcS9PZnprdFYveHRF?=
 =?utf-8?B?bFNnVnFYR0xFNUFyTVZpZHVBWVNLaWNGUGRhSnozcnJCSTdScHBZRmZ3eits?=
 =?utf-8?B?bjRuMDV2M0hPWk1OV08xN2Y3OWFucnJQZEJabTdRc1JIRkM0U25wOFl5bktn?=
 =?utf-8?B?Q0loTE1UOWtNNFZrZ0tGNWFuVTl3ajFsQ2dReUtNbmJLQmV2V1laa3NxQ1l4?=
 =?utf-8?B?TzFxNmRmQXJoQXdmY0FjTWVDdkNDWGlkTmNPSEtJT045b3FGWnJvVVEzTE5r?=
 =?utf-8?B?RnRBK0gzcW1FaUlBczNlVVYwOXk1OHdRbllsa1NsQTU5aUk5N3N1U3RlQWx5?=
 =?utf-8?B?Y09GSVB5Z2s2VXZGcHdTSVdobVVnVHpua3gyQ0ZkOXJLVlF6QUU0K2FjTnU3?=
 =?utf-8?B?cERIUysxVWhNbEJoUWx2bFMwT2NicVA3SnJPNlp4OWJlOWRzMmpHeU4yb3BU?=
 =?utf-8?B?QmxCYzVnSldBYlpLdVFaODd5L2dmcEFucUF1MnhSMGFPNHhxMUV5YTZSWFZT?=
 =?utf-8?B?WkJOV29INUJRbHc1dlF2TWNNc0dobXN2a21iSG1zV3JKV3hjeFJiMmpiNGVT?=
 =?utf-8?B?V0FnOFFTZEt4Mlc1UWZRVlhpNUNFTVU2alFFLytQWjNlYm03RkdmWEE2T0Zj?=
 =?utf-8?B?MllyN1Iwc1ZtTDFzYThhVkE3QkNBQ28wamlMbWdMTlV3b3F5T0o4MlZ6WmhM?=
 =?utf-8?B?OWgrSXlXUGt4THdyRU5yd3huL3hQNnU4UVU5aVJUUUt5OHpvRzZsb0I0UjVU?=
 =?utf-8?B?UXFJc1ZVTHJ2NmRpWWFrUFdnUVBNaHFNcTZIdllzZFJ3Q3l0VDBmcDZTYnM1?=
 =?utf-8?B?V2o1aXRiK2Z0T1FoNm1rWEtJaTFVSlNRZGpVTTJYS0NFdytwRFYwdFN4RkN1?=
 =?utf-8?B?MVlGM2Y0dTVrRkxGZWNNQ0E2Nkw3emMvTEt5NnNqOTduWUx3NUYyZnF0aiti?=
 =?utf-8?B?Zm0vaUYyMGhsVGtibEVuQTQ5Qlpha2pnRGYycElIMHowR240aHIxcGRiSXMx?=
 =?utf-8?B?SlRKQnEzWVk3T3NMT0VPN1FwYTg4eGdQbTBJT2JZR0MrRDFkVHFCMktpWXpn?=
 =?utf-8?B?VmpTdGlxcTNCRk9QSzRadEFJWDlTTW5TOFJYck45czBpS1FwdzdqNjJ5SFg5?=
 =?utf-8?B?QWgxUjZKVTFqUGxOMlBMWlpxaVFCb3NwR1R3WmxrQlErQ3c4VTVETkd4dGp0?=
 =?utf-8?B?L3pHODBXSWladko0dG85UlpLaHBTTnB4VzMrb0I0TWo5TkFzb1FjWFN0SnJF?=
 =?utf-8?B?bnJ6RWhOLzY3NDMzWGVqSjNhc3ZnbkRtYzQ3N2hOcjU1MHJXQlNRTTd5em53?=
 =?utf-8?B?U2luSGp3R250UGphM1JseHE5UW9aanQ3cENNU2pEUDRTNXVwSkRJMU9Ja05N?=
 =?utf-8?B?b2dtY0VlMTE1dnVHOEtyYUlqZE5IMitCdGNvMzBBK3NXNmY1Y2gycFYvWlFB?=
 =?utf-8?B?dWxvTEhxMXZjZTBza1p4OHNjSXIxejVNVDI4RXcwMG5qcHphMVlic1JwQWhZ?=
 =?utf-8?B?aFY2QWdKWW1IZjJBMjdoU1RweGF5YlhsOUJEMTQ1T3Nmc1k5bHhpL0o2K21y?=
 =?utf-8?B?aHhscGlwdHhLb29HSUtkdmJJOG1GazRhMVo4ZUFXOHZyU2VBUTY5MzBNMGp2?=
 =?utf-8?B?Zm8zcGVjNlBzM1NzTU9lUG95Y2NqWUptMzB2aGp5K1oycG9pQzBLRWdCUndP?=
 =?utf-8?B?K09DRXp4dHp4TG5mTFBSZ3JQdE16ZXFDVEZzd3NwVG0wcXh4WTFOZlVkZ2RD?=
 =?utf-8?B?S1BSMnRHOHpQRmRMMzVmN3pLbFN0clJUZVhWNnk0WTl3SWJoWDVRNVZCa0Nv?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2AF4D984575EB449036AEE1CC9EB6B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557f6304-42c6-4a50-f343-08dcfabec63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 21:47:25.6057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyApOWNhL4qzBNDS4aYltv/BzCFTFV/rMnXvxYCYZd1lc/Azr2ZlGelrh5sNY8BhF0uA/+RQTC7TssJQ/NwITVU8e0SQDm2khehk9Tna5SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTEwLTE2IGF0IDE0OjU3IC0wNzAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IFZNX1NIQURPV19TVEFDSyAoYWxpYXMgdG8gVk1fSElHSF9BUkNIXzUpIGlzIHVzZWQgdG8gZW5j
b2RlIHNoYWRvdyBzdGFjaw0KPiBWTUEgb24gdGhyZWUgYXJjaGl0ZWN0dXJlcyAoeDg2IHNoYWRv
dyBzdGFjaywgYXJtIEdDUyBhbmQgUklTQy1WIHNoYWRvdw0KPiBzdGFjaykuIEluIGNhc2UgYXJj
aGl0ZWN0dXJlIGRvZXNuJ3QgaW1wbGVtZW50IHNoYWRvdyBzdGFjaywgaXQncyBWTV9OT05FDQo+
IEludHJvZHVjaW5nIGEgaGVscGVyIGBpc19zaGFkb3dfc3RhY2tfdm1hYCB0byBkZXRlcm1pbmUg
c2hhZG93IHN0YWNrIHZtYQ0KPiBvciBub3QuDQoNCkkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgd2Ug
bmVlZCB0aGlzLiBJSVJDIHdhcyBzb21lIGRpc2N1c3Npb24gYWJvdXQgd2FudGluZyB0bw0KYWJz
dHJhY3QgZGlmZmVyZW50IHdheXMgb2YgdGVzdGluZyBmb3Igc2hhZG93IHN0YWNrIFZNQXMgZm9y
IGRpZmZlcmVudA0KYXJjaGl0ZWN0dXJlcyBzaW5jZSByaXNjLXYgd2FzIGdvaW5nIHRvIGRvIGl0
IGRpZmZlcmVudGx5LiBCdXQgbm93IHRoaXMgc2F5cw0KdGhleSBhcmUgYWxsIHRoZSBzYW1lLCBz
byB3aGF0J3Mgd3Jvbmcgd2l0aCB0aGUgb3BlbiBjb2RlZCBjaGVjaz8NCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGVlcGFrIEd1cHRhIDxkZWJ1Z0ByaXZvc2luYy5jb20+DQo+IC0tLQ0KPiAgbW0v
Z3VwLmMgIHwgIDIgKy0NCj4gIG1tL21tYXAuYyB8ICAyICstDQo+ICBtbS92bWEuaCAgfCAxMCAr
KysrKysrLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9ndXAuYyBiL21tL2d1cC5jDQo+IGluZGV4IGE4
Mjg5MGI0NmEzNi4uOGU2ZTE0MTc5ZjZjIDEwMDY0NA0KPiAtLS0gYS9tbS9ndXAuYw0KPiArKysg
Yi9tbS9ndXAuYw0KPiBAQCAtMTI4Miw3ICsxMjgyLDcgQEAgc3RhdGljIGludCBjaGVja192bWFf
ZmxhZ3Moc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgZ3VwX2ZsYWdz
KQ0KPiAgCQkgICAgIXdyaXRhYmxlX2ZpbGVfbWFwcGluZ19hbGxvd2VkKHZtYSwgZ3VwX2ZsYWdz
KSkNCj4gIAkJCXJldHVybiAtRUZBVUxUOw0KPiAgDQo+IC0JCWlmICghKHZtX2ZsYWdzICYgVk1f
V1JJVEUpIHx8ICh2bV9mbGFncyAmIFZNX1NIQURPV19TVEFDSykpIHsNCj4gKwkJaWYgKCEodm1f
ZmxhZ3MgJiBWTV9XUklURSkgfHwgaXNfc2hhZG93X3N0YWNrX3ZtYSh2bV9mbGFncykpIHsNCj4g
IAkJCWlmICghKGd1cF9mbGFncyAmIEZPTExfRk9SQ0UpKQ0KPiAgCQkJCXJldHVybiAtRUZBVUxU
Ow0KPiAgCQkJLyogaHVnZXRsYiBkb2VzIG5vdCBzdXBwb3J0IEZPTExfRk9SQ0V8Rk9MTF9XUklU
RS4gKi8NCj4gZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAuYw0KPiBpbmRleCBkZDRi
MzVhMjVhZWIuLjA4NTNlNjc4NDA2OSAxMDA2NDQNCj4gLS0tIGEvbW0vbW1hcC5jDQo+ICsrKyBi
L21tL21tYXAuYw0KPiBAQCAtNzA4LDcgKzcwOCw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHVu
bWFwcGVkX2FyZWFfdG9wZG93bihzdHJ1Y3Qgdm1fdW5tYXBwZWRfYXJlYV9pbmZvICppbmZvKQ0K
PiAgICovDQo+ICBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgc3RhY2tfZ3VhcmRfcGxhY2Vt
ZW50KHZtX2ZsYWdzX3Qgdm1fZmxhZ3MpDQo+ICB7DQo+IC0JaWYgKHZtX2ZsYWdzICYgVk1fU0hB
RE9XX1NUQUNLKQ0KPiArCWlmIChpc19zaGFkb3dfc3RhY2tfdm1hKHZtX2ZsYWdzKSkNCj4gIAkJ
cmV0dXJuIFBBR0VfU0laRTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvbW0v
dm1hLmggYi9tbS92bWEuaA0KPiBpbmRleCA4MTlmOTk0Y2Y3MjcuLjBmMjM4ZGMzNzIzMSAxMDA2
NDQNCj4gLS0tIGEvbW0vdm1hLmgNCj4gKysrIGIvbW0vdm1hLmgNCj4gQEAgLTM1Nyw3ICszNTcs
NyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hX3ByZXZfbGltaXQo
c3RydWN0IHZtYV9pdGVyYXRvciAqdm1pLA0KPiAgfQ0KPiAgDQo+ICAvKg0KPiAtICogVGhlc2Ug
dGhyZWUgaGVscGVycyBjbGFzc2lmaWVzIFZNQXMgZm9yIHZpcnR1YWwgbWVtb3J5IGFjY291bnRp
bmcuDQo+ICsgKiBUaGVzZSBmb3VyIGhlbHBlcnMgY2xhc3NpZmllcyBWTUFzIGZvciB2aXJ0dWFs
IG1lbW9yeSBhY2NvdW50aW5nLg0KPiAgICovDQo+ICANCj4gIC8qDQo+IEBAIC0zNjgsNiArMzY4
LDExIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19leGVjX21hcHBpbmcodm1fZmxhZ3NfdCBmbGFn
cykNCj4gIAlyZXR1cm4gKGZsYWdzICYgKFZNX0VYRUMgfCBWTV9XUklURSB8IFZNX1NUQUNLKSkg
PT0gVk1fRVhFQzsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGlubGluZSBib29sIGlzX3NoYWRvd19z
dGFja192bWEodm1fZmxhZ3NfdCB2bV9mbGFncykNCj4gK3sNCj4gKwlyZXR1cm4gISEodm1fZmxh
Z3MgJiBWTV9TSEFET1dfU1RBQ0spOw0KPiArfQ0KPiArDQo+ICAvKg0KPiAgICogU3RhY2sgYXJl
YSAoaW5jbHVkaW5nIHNoYWRvdyBzdGFja3MpDQo+ICAgKg0KPiBAQCAtMzc2LDcgKzM4MSw3IEBA
IHN0YXRpYyBpbmxpbmUgYm9vbCBpc19leGVjX21hcHBpbmcodm1fZmxhZ3NfdCBmbGFncykNCj4g
ICAqLw0KPiAgc3RhdGljIGlubGluZSBib29sIGlzX3N0YWNrX21hcHBpbmcodm1fZmxhZ3NfdCBm
bGFncykNCj4gIHsNCj4gLQlyZXR1cm4gKChmbGFncyAmIFZNX1NUQUNLKSA9PSBWTV9TVEFDSykg
fHwgKGZsYWdzICYgVk1fU0hBRE9XX1NUQUNLKTsNCj4gKwlyZXR1cm4gKChmbGFncyAmIFZNX1NU
QUNLKSA9PSBWTV9TVEFDSykgfHwgaXNfc2hhZG93X3N0YWNrX3ZtYShmbGFncyk7DQo+ICB9DQo+
ICANCj4gIC8qDQo+IEBAIC0zODcsNyArMzkyLDYgQEAgc3RhdGljIGlubGluZSBib29sIGlzX2Rh
dGFfbWFwcGluZyh2bV9mbGFnc190IGZsYWdzKQ0KPiAgCXJldHVybiAoZmxhZ3MgJiAoVk1fV1JJ
VEUgfCBWTV9TSEFSRUQgfCBWTV9TVEFDSykpID09IFZNX1dSSVRFOw0KPiAgfQ0KPiAgDQo+IC0N
Cj4gIHN0YXRpYyBpbmxpbmUgdm9pZCB2bWFfaXRlcl9jb25maWcoc3RydWN0IHZtYV9pdGVyYXRv
ciAqdm1pLA0KPiAgCQl1bnNpZ25lZCBsb25nIGluZGV4LCB1bnNpZ25lZCBsb25nIGxhc3QpDQo+
ICB7DQo+IA0KDQo=

