Return-Path: <linux-fsdevel+bounces-26073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44C953700
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C468B1C2365A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D014E1AD3F7;
	Thu, 15 Aug 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hg6nq7xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5751ABEBC;
	Thu, 15 Aug 2024 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735279; cv=fail; b=colgPyQmi9OiaZ0Zqg752abPbfHSJIXD53GGIVqhKBpOPGuNKTGZxJ8tRCYt1TvagWOTvMK8NuduJxFFDE+gCoxCn/glG/Ij+krpyPsUb//CD12BoumLhldqcQ0q3VOXNTLnrEBGZb6+ksnyexy7gAl76ZcXoArbkINtvEzLdgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735279; c=relaxed/simple;
	bh=JhI0vsVQC6pG6cHe188LZGLVSqDidtqoxZ3U0+zSbtw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fl3r53ctLHyXKb8Jw1vybONlcfzaMGW/Jssv8t5z8JKJfk+RrpfmfItkRG2nXhXiDGIiAIsLbgYjHsRaSrZOkC9Q9cJictZkiE0hALQqFWGxEVl+hcH/dRK4ll4l9XOb9xfDI9ZXWFiY3kbzXPCzkgGIQcUJch+l5mrt9lqiN4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hg6nq7xx; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723735278; x=1755271278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JhI0vsVQC6pG6cHe188LZGLVSqDidtqoxZ3U0+zSbtw=;
  b=Hg6nq7xxiSE6IDK9V1C3oMp4mwn2rDbpP5DLhkV2aOubWyKUKgcgIWDm
   7R8vmwCmF0pW+LSZv1Xq0iLS/chm/FRnr/JMdGZqOVIfxahSD2OM6KrFQ
   tyHBdYGr9XsIOnHZp7GO2da+baEkCf3L1Ah7bDsFLnNm14crpckpuCjVY
   dv11Ermr0ArMo21LO5E7WuRxB8I3I701cZsw4NH8w+QJIXFhkrOGFGLns
   wXRgH3Y+FRvifnwJJ8FY0K10z7oXA/Ilnt3DczlhhrGFHBgV4AMd6UTmz
   YImf59+tWcz2JxnVgjPyRRc3Z5ekFc2jVkNunJ7r6jX6Df++cpAxuAUFw
   w==;
X-CSE-ConnectionGUID: iXuhHFFJRteOX61wKy+RoQ==
X-CSE-MsgGUID: mcInEjYYRAKSdqSI31Di2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21819365"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="21819365"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 08:20:57 -0700
X-CSE-ConnectionGUID: XvZnf5cBQPi08bgN0uIvbg==
X-CSE-MsgGUID: pQaM0U44T0WSqqUdojXcCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="63795537"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 08:20:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 08:20:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 08:20:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 08:20:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tghsw+IT+TSnsrQIryooLQip+g52mHx8mp73qsD4vBgGsQttl1sZix6L7S6XExBBlYRdS8RLIqUCDQFfkzLCtxRATmOdt4f+58RtoiZB6EaATwS6eelUMbGmc7FRvM7Ofv/Wjxx2NOv7oXkjbUa/6r5xjc7AxMBNDuMMvXV7KIVRAe3y3y4mFB7B+lZ5av7D5AsWCOCiOIOVDX+oulYwaLlybV20i4AaKlVLvHIH4wOZKLaC+xSPc/zv4C60tH2kuRN1k9YEFZBXmTzWkjXOtG0Hwoy64NeqygjHEo9iCVrExjjD/43KH/lCZf6/gWPCZs9rCxNsgggXtn1A1Y/EOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhI0vsVQC6pG6cHe188LZGLVSqDidtqoxZ3U0+zSbtw=;
 b=XTvYn3F2zNGJ92WxDSEgXy7h66ICYdmt7/tVY4DKPp/cTmUEzCymUJGgqZuhg03Y6h8VNcEX7iUSITTjI94/DcIe5BmZ0obBLIo4LGw7tEzbYncoh3I0QlUkfrDKFHNNe0ajH/nLg2HN5x+Ea1Ni/iiPGYti2DzE8nS6i6v4ksX6cFhP85cXegK8ZKvt9tX34JLzqsdaFWNB6chtY0BHljkfuFFjDPovlMtxE+3eT3cL0YJNb4TvorD1oZ1+ZuvLzudlUqeHtQWsI4tZXSGwE/ZG+oCIXZLZxlpaVz/n5JCawZ9Ob8jQ98hf3UzsxRGspVvu7yHFqjFcL4jQslrHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Thu, 15 Aug
 2024 15:20:52 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 15:20:52 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "oleg@redhat.com"
	<oleg@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "will@kernel.org" <will@kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "kees@kernel.org"
	<kees@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"broonie@kernel.org" <broonie@kernel.org>
CC: "brauner@kernel.org" <brauner@kernel.org>, "ross.burton@arm.com"
	<ross.burton@arm.com>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "thiago.bauermann@linaro.org"
	<thiago.bauermann@linaro.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Thread-Topic: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Thread-Index: AQHa5BKUVD7wI5NTNUm62iFzIM90d7IohUeA
Date: Thu, 15 Aug 2024 15:20:52 +0000
Message-ID: <34f7a5378447b1a8d5a9561594b37cfeaa6bd2b1.camel@intel.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	 <20240801-arm64-gcs-v10-12-699e2bd2190b@kernel.org>
In-Reply-To: <20240801-arm64-gcs-v10-12-699e2bd2190b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ1PR11MB6129:EE_
x-ms-office365-filtering-correlation-id: 754da618-6822-4d31-ee29-08dcbd3dd9bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R0hRek9OTllQdis4ZlFYWDJYQm9EUllNL3VYTEJ1Z3hMNDBJdll0Zk1NMmNZ?=
 =?utf-8?B?blBaOEVWc2tFUCtLdE9xc2grMjMrTkRqTk43RmhHK3RNU3BDUDl6bDFTOENW?=
 =?utf-8?B?eVdYL1g5eWNGWmoyVGVyanQ3MnFmejFOaVlGR2pKd3U3R3N1N0ZxRHk1ZGsx?=
 =?utf-8?B?UTh6TVp3L0RrcGl5akcwZ2tiR2ZYdm9vOXAyelFWTUhiNWpRR1A2bDVVWUZH?=
 =?utf-8?B?YkFKRUQwWkhYRFJvNldCNmxBa3p6TXZER1EvMzhPNEJTR3dNdnk0S1g4NDU4?=
 =?utf-8?B?U0l5L2dQdmZ0UnhYV2RoNS9PNjZxWUgzSmxPTzJCZG9wQjFtYy9nZ00veDk4?=
 =?utf-8?B?cldla2NxdlR3WW1GR0FIYWhRMCt6bStxRDFJYUZ4RHhad3dDNldRTmJibmZV?=
 =?utf-8?B?QU00OUhFdTNOZzZHYWk0NmFOelVWWnR0SWZOVlpiemhtWHBvaTYyOVJ2VTdi?=
 =?utf-8?B?ZnJseXZxTDVwUVo0aXNsTnF3NVhIRVRYMUFzWktXK3h2cjBxYURYWWxETTFI?=
 =?utf-8?B?K2pVQlByTVV4aVYzTm5GM0F5cTZFWjFuS3FxeHJxNm1CWGJjK3NkYjhTSnY4?=
 =?utf-8?B?dGZIaXpnMDhMS1hVcjJUZWpKWms4cTlvUnplcWswL1lvejJxVXcwTE1Wak9k?=
 =?utf-8?B?emU5ZUJ6U3Ryekd0Q1Ftd0pJeXM4MFowYjlKL2U3eHFKd3RRMWsyM1Nrblo2?=
 =?utf-8?B?VlNDUXF4TDZTNnRCZEYvMmlPTGJkL3BZTnVoazdmOVpkRms4b3NzMkhobG1k?=
 =?utf-8?B?MXZuNGMySHBoNk1zYVgydnZEclptdnlYMWhFNS9mdDNlNk5PT2U0NnJ0QUJw?=
 =?utf-8?B?ZnlKVTRTWXRIbG9OM0VndHNZU2owT240S3g4azdoVUpTSzZMdzBCeEUrY2Jq?=
 =?utf-8?B?M0xaR0w0WU1PYnIvcXhPSTFXWWF3bGxwWEpqLzNvbFUrUjdKRzIrdmZXVGF1?=
 =?utf-8?B?dzR6RVp4a1BxaGMvdjE5My9RUUwxN1pqYmJ5VnJ0dnlOYnJmMkx6aFJiTVBR?=
 =?utf-8?B?WTlESWFlRnBsZWhhMWUrK1kveTh6UjZ0OGtoZGYxalFrVWpQaGdGM1BKVDFQ?=
 =?utf-8?B?a2tncXdIeGZQTzVZVWp4a0ZoeXRJZjlkOW1lbXppU1ZvYU1YTXo5SXhNV3Jo?=
 =?utf-8?B?QUlnV2Z3aWdEeENnVHVZR1hmbFAvTm51Q1J5eU9mVFVsSEs1MU1UNEM0N3Ji?=
 =?utf-8?B?WTAxWm16QytKK09oL0ZkMXVVdUZQVGREZ0UvODZpNmRySjhPNlRyTTdCdnpn?=
 =?utf-8?B?WVRGUHdLcko3alY2djFZdHNCMSsram5JNjBYVGYrSWpCaHFOVGQzdjE4OUs0?=
 =?utf-8?B?THpNeFZOa0RvK0ZYSnlQQVAvbFdtaWdtSzMrU2ZOT3hoUzBaRmNEbUR2MlI4?=
 =?utf-8?B?clZETU03YjRZYVdhdGxDYWo0eFIreXpVbjNBTVNoYjlYejFCTHFZYll1Y3Jv?=
 =?utf-8?B?bEFwNWhtUXBINjZBeFhweHlqWkJFK0lCRnpTVVNxem1SSFpSQlQzQmNOUW9X?=
 =?utf-8?B?TGxOblNkWVZMWnA0WE5rWkVpZGtKZXN6RDIwdlRtOStzOTIwSm9YV2lrN1pW?=
 =?utf-8?B?VFM0NzZNZ2pQT3pvWGtoanl5YWlhYWxkSUdpaVVDUU42N0tQeURJWDZVWjg2?=
 =?utf-8?B?NXlOMHMrK3pJNnNqZzdoRVZxZDJjNXNOUWpHK1FHbmxyVUcyOUxBOWxTL0FO?=
 =?utf-8?B?R2ZjUkZhaDhSTG9hZWlIVUdsZ1lqRENQS1p2YXNqRzZDRkdkRVd2Z3FLRHBk?=
 =?utf-8?B?WlBaMkhBbWhmcVBjVlNDSFJ2WTQ1eEZEZ0ZXaUtza2lPSG8rQ1R4WXIzSzZy?=
 =?utf-8?B?T2FKTGZBRStHUlpULzlNWEV0dUFuTnFiQVJudHBuaE1QcFJoaHlEeFIvRmUr?=
 =?utf-8?B?NlpObHZRVTVyb3pBa0gxbTZOdEt6ZDA5ZGNGNTdTOTgybzZnWFFBbEtidE1q?=
 =?utf-8?Q?GMTJPKyhe7o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnNZNXZ2ZXc1ZWRLZWVLdEUrNExDWVRqRUNLNGdFMHNheThBZm4xRVhWZmFT?=
 =?utf-8?B?VlJrQVRKQWtENytESHI2ZmE5dW92VHZiZmJNZGYrNkcrMUd3YzBta2pMbFdG?=
 =?utf-8?B?ZmlEWUQvWDdPclAzcnNydE9ETjRKNlQ0a1YxYStXM0x5azRpZXpwb2IzQlRo?=
 =?utf-8?B?dUl4bkVML2RtbjVIMHVBOTZNbStMeFIreHJpR1djcFBXWnduWm9aTTROWmUw?=
 =?utf-8?B?bmc0WWkrYVdPdXZUVnRadFBqNUN6TkdXZGY3MlF0UWhFTTVvTk1GYzk0VFRa?=
 =?utf-8?B?VGtFMkFNME5MWGgwOWo2amMzUnJPeWNKdlJmZmg2VlArOXE2dEJPQVhkZjhm?=
 =?utf-8?B?anAycWM1QVBpZFQwL0JlVVpVaTVVaHNzRVQ2UHBrU0dmWVUzUVZ2L0UxeEor?=
 =?utf-8?B?NUttUlNVSDFQMTVnaGZxUDR1RFhkUDNCRS9TSURycGE3cVpwcjZCY1dKMzNh?=
 =?utf-8?B?eDhmZ2MxN282N0NjSWptdmlrVDc0R1hoS3hTVTUzRzlqWitSSTI0WGFRS3ZC?=
 =?utf-8?B?RlhnUkFGbkJUdjlwNGd2RStlZHl6NzBRSjEzTDd3VU1KUlhmbmRXSUhuVjFa?=
 =?utf-8?B?Q3lxb29jVTBXSHJJdWtSelNONTZhMXMxeEo4bDJrL20wejMwb3R5ajdJRitO?=
 =?utf-8?B?MmdlQmtDdnREQ1JwTG1kR1h2NUpDbFBhdXlqQkZNWkoxMm9FTGE4WHNCS0F4?=
 =?utf-8?B?emhqL01YODZPWXVtVk5jcHI2dFllZHZLS2hyOGpYb2NLY3MranFxTzlGZ2k5?=
 =?utf-8?B?NGxEcjBzbi9SNTF5YkxZaExHNHg1RkRJTDNGeGg1MkZjczJmWUI2TTF1RSt6?=
 =?utf-8?B?OVNhelhzK2g0c2o0bnpjTkFPY0ppcEFxSG9rUnhuV2JpZlNlcWJHM2Jud0sz?=
 =?utf-8?B?NkpCNzN3OGhzWUg3M3I3bUxQZDJ4M2F3UDhYQU5PS1N0djBoZTZPb1hOY3h4?=
 =?utf-8?B?alplSGg3YTFpSTB0akE2RmtmUWhveWdaaTAweFJhSVhHRTEyOUw2UldQdkpC?=
 =?utf-8?B?Z2hCeFczcDN5enZ0eXNRc201K0xrOXp0ZWMyOXVSSExOanpHbGlSZEMraUZk?=
 =?utf-8?B?QzRyWklSMmRuUXdXczN3ZkVsM3k3cHRPNUl0L0lFeXU0UUE1bXJzS1lSODJW?=
 =?utf-8?B?cVhZMTl3QlUydjRBMEFZSDNUeEdzRWE5UjlET0dXNkk0K0tQUmo5MDhVOWh6?=
 =?utf-8?B?TkJLVGpiWUxpaXF4dFpaQTBjRHB0SXRoRlpoM1dRSlJvQ2xHdFN6K3NQcjQr?=
 =?utf-8?B?MEpVSWR6aTFyMi9ybW5GL1dJUFg4OVlHYlhqNlJJaTRQY3RHbGljVWt1WjFr?=
 =?utf-8?B?T2tQbmlXaXU5SU9UcWxudFBJVVFEcStOUnpHaTNjTnFYTHlBV1VQWHVydkxP?=
 =?utf-8?B?cE81TnRPTGV1THZaSGFmQ3l0QkNTK3hrRUZDZnhNQTdrbFllelhOUUpsZFJy?=
 =?utf-8?B?engxaHZodCs2eHF6REl0RytFQk9EZ2sxWSt5bng5RWhMaW5neU0rQ09DZkx2?=
 =?utf-8?B?d3BGMUpwUlcyQmRMTzdVaCtLSlVydkxaZ2psQ2dzclZoSzhrQ1gwbVJOMlBy?=
 =?utf-8?B?Qm5RdnBhRHJJRDZpRVpiS3poRnRoOVhQcnNXeEtTZEFIcGlzK3dOZWZ2QWJ5?=
 =?utf-8?B?L2xtS1hpb0sydUg5TUJUZlNYMHBBY09Oam9pZW92SVFxSUo5Y2psQ040V0pF?=
 =?utf-8?B?YTIwaW9FeXM0WTR0Q0E5VnVGUGd3Z1NYbVB3ZkEyNk5Ea2h1VVVESkFlM1lm?=
 =?utf-8?B?MWdsdzRpWHRKWU5LcjRJYUtDMWZQZmRvb2VFMFhvYzc0L2d2STQwbUpkM1lQ?=
 =?utf-8?B?cE0xeFE5UGV6RHEwZzN0bXNPb0xzN2NEOEpEWWlhajRoWWlHeXprS3lrLzNi?=
 =?utf-8?B?Qm9mZ0xDVTAvY0R5Q1dZZG1KTTNXNmxIczB6R0RDOXlPanVBc3FWSmt4Zzkr?=
 =?utf-8?B?WkJMeDBQV2djY1ZJVklYZWI4Ly9VQ0dDbXVZbWp0V2Yzb0NMak5ZelFxV3dp?=
 =?utf-8?B?UjkwdTY1NE0wS0J2cy9ibjBaeXhvNWpLd2o3SkZvdDRkdCs4ZnhibHUxc0NL?=
 =?utf-8?B?VVVGY1NrSGZhK1piWUNXQUpkR0hFNUdDZzBONEhqcUFFY1JJaXZGU3YvdEVY?=
 =?utf-8?B?MTExZ2dXMmpERWlPc2l0d3VxMHU0VENUZk00Y3dEQmtFZTJ4NTJoaEFLQ0dE?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB7010345F9A034E8C3105817BBC6BA1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754da618-6822-4d31-ee29-08dcbd3dd9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 15:20:52.3026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38GMzPZ2a+FCWV5p3Cla7KfyMSTaBjNSfeu2kcYqSRDHASP/OhaTkcfwwumurV8kd28ZjqXxbgXTA3CFN7cwOfPK0zHa2SqeKAKh5/lhgEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTAxIGF0IDEzOjA2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBV
c2UgVk1fSElHSF9BUkNIXzUgZm9yIGd1YXJkZWQgY29udHJvbCBzdGFjayBwYWdlcy4NCg0KRllJ
IC0gSWYgeW91IHdhbnQgdG8gaGF2ZSBtb3JlIGNvbXBsZXRlIGd1YXJkIGdhcHMsIHlvdSBuZWVk
IHRvIGRvIHRoaXMgZm9yIGFybQ0KdG9vOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
bW0vMjAyNDAzMjYwMjE2NTYuMjAyNjQ5LTE0LXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0K
DQpVc2luZyBWTV9TSEFET1dfU1RBQ0sgb25seSBnZXRzIHlvdSBwYXJ0IG9mIHRoZSB3YXkgdGhl
cmUuDQo=

