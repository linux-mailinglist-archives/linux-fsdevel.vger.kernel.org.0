Return-Path: <linux-fsdevel+bounces-53292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2ACAED2D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 05:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0637A5442
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 03:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29151885A5;
	Mon, 30 Jun 2025 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R30kKWm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AC4C6C;
	Mon, 30 Jun 2025 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751253472; cv=fail; b=EtX82cvXEWd9vMTV+dyx2M1/dNkHgv7j4f9/Bs00enYfU9yzIaJS5IYBjT15W8Z8HcuSoYd+8T25ugwEtrwlWUrVvOXOcJGoRShNbnyX/w5T+xNWmIk/eK6gwJfW+RtKQnFUhH+Sv4if94Iv1a3cn5TX9F0CIwBes0AJPzwAWjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751253472; c=relaxed/simple;
	bh=o4l8wZFNHs8HdJGJv+mDhFBjlkMTIQWrkHcY9oPTOIo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Goo5LDMwpiM2oSGeoE/umHokxl5LKr1UxI7X/zma5wRULs0uzKkfC0vstuZERHnw6XhxtQsH2NPGcKbUcFJNyttct9TDF8tQIuk4nRGZUfP3oB9u6fUYdLn4wExmg0n89NodVSKQEGqEJpBKWr6zfNqMy/l0MG7ANHA0bfeTdWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R30kKWm3; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751253470; x=1782789470;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=o4l8wZFNHs8HdJGJv+mDhFBjlkMTIQWrkHcY9oPTOIo=;
  b=R30kKWm3m5axledsfnufS7G30SGFwO9VWlGArbbFIKVL1uouF8UUgjG5
   poVQqRpg1Zy2MFKvtTHcu/tsLw+L4J5KMuTC6kOQTECq4iKtD4s7bk9RK
   00sum8JVjhlxjmmTI597eqjNCnGRl4fvbXPbXJYy7NwccaSKgWzl2K050
   3+FJLTvHdhRwUkW5QGnvrQJt3VV98sS+a2WE7rpaHhJ47S1rAkB5tTyA9
   d7ZFDW78uHVLOvXjhlJ7VkZ4iIAYDli0kuQqSgBtas7Nr2V34BlGerAyR
   SBxC/eBCGrKRFkuUXrWCcI8jvKn4vWooHhw8kcTjKXcFi0cvZ6G8MgiDy
   A==;
X-CSE-ConnectionGUID: fzqmV1OeT1+RiSshHoV56A==
X-CSE-MsgGUID: XKJSmqjeTuOrVj4vovk47g==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53190853"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="53190853"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 20:17:49 -0700
X-CSE-ConnectionGUID: SQU2CY1eRG2aiMVwtFPOxg==
X-CSE-MsgGUID: b7+LNVIiS7mQRtYzuJom3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="152959729"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 20:17:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 20:17:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 29 Jun 2025 20:17:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 20:17:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKMAbcQwl/fKil7qMgd4/xJJvUogwO7rWrmlqzQ18VgDHuBygtSDNU/V58odUs0gHRMBTAL41VwH9/U9zNd44IZDRsySwS7HwS2OLk5gleloj3VubSa8dwcCX8zmvGqUeb1KTjaClSiLjcUcCG5ORySc1NhvxheFBdryWyNELFYVNrA+bXuOl28B1/ihsC36g66BjcgFMD0+gfJsax8AoNnp2KFq84DnDLwSuD7RIU6SuXFKaSYk4Td+3FdO+N/EJ+nCvvZebsVFXWu0oJfJSevxgzuTdBeOsMsKrwLZbGdbZFgIHfOXk78R+2WZ/+2YHZUDkwY+YIrmRbjgz29JEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDxM3kMfG/+rNPCPhnoJE/6mBLUoJCQ8kQ/R2vHSu1U=;
 b=EHMFYE4ajicWVZnsN1RJqefDuP5+bcX0mxG69r36j+cqix4lrIYDFvPxwAWLICK3di80vnAQzq5O0uNVifyWXcHKR2nK75VAzedTHnEwZwrNxgcfuJLKmyghjm8a/E4Ge03r6ECrkS6ZS/QggCBNFmuUOM7Zx0SXzWk6qRXv66CGtofSB5gqhy7CvTggh31djIXZgELjAhk/3HA5PbKT/Wiwzt8JEJtysn6a6Tmx1zRE+0/j99vT1JYsllkSqpDKWe9EaBe4FM1Nc0yqFMVs6O5LTZRr131mlAJhHrMsUG7yaDMYvp0Hm4Kig09rfLL2JSejc2GqKgyma056Xb9Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Mon, 30 Jun 2025 03:17:29 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 03:17:29 +0000
Date: Mon, 30 Jun 2025 11:14:33 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Vishal Annapurve <vannapurve@google.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Ackerley Tng <ackerleytng@google.com>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-fsdevel@vger.kernel.org>, <aik@amd.com>,
	<ajones@ventanamicro.com>, <akpm@linux-foundation.org>,
	<amoorthy@google.com>, <anthony.yznaga@oracle.com>, <anup@brainfault.org>,
	<aou@eecs.berkeley.edu>, <bfoster@redhat.com>, <binbin.wu@linux.intel.com>,
	<brauner@kernel.org>, <catalin.marinas@arm.com>, <chao.p.peng@intel.com>,
	<chenhuacai@kernel.org>, <dave.hansen@intel.com>, <david@redhat.com>,
	<dmatlack@google.com>, <dwmw@amazon.co.uk>, <erdemaktas@google.com>,
	<fan.du@intel.com>, <fvdl@google.com>, <graf@amazon.com>,
	<haibo1.xu@intel.com>, <hch@infradead.org>, <hughd@google.com>,
	<ira.weiny@intel.com>, <isaku.yamahata@intel.com>, <jack@suse.cz>,
	<james.morse@arm.com>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
	<jgowans@amazon.com>, <jhubbard@nvidia.com>, <jroedel@suse.de>,
	<jthoughton@google.com>, <jun.miao@intel.com>, <kai.huang@intel.com>,
	<keirf@google.com>, <kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<michael.roth@amd.com>, <mpe@ellerman.id.au>, <muchun.song@linux.dev>,
	<nikunj@amd.com>, <nsaenz@amazon.es>, <oliver.upton@linux.dev>,
	<palmer@dabbelt.com>, <pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <pdurrant@amazon.co.uk>, <peterx@redhat.com>,
	<pgonda@google.com>, <pvorel@suse.cz>, <qperret@google.com>,
	<quic_cvanscha@quicinc.com>, <quic_eberman@quicinc.com>,
	<quic_mnalajal@quicinc.com>, <quic_pderrin@quicinc.com>,
	<quic_pheragu@quicinc.com>, <quic_svaddagi@quicinc.com>,
	<quic_tsoni@quicinc.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <seanjc@google.com>, <shuah@kernel.org>,
	<steven.price@arm.com>, <steven.sistare@oracle.com>,
	<suzuki.poulose@arm.com>, <tabba@google.com>, <thomas.lendacky@amd.com>,
	<usama.arif@bytedance.com>, <vbabka@suse.cz>, <viro@zeniv.linux.org.uk>,
	<vkuznets@redhat.com>, <wei.w.wang@intel.com>, <will@kernel.org>,
	<willy@infradead.org>, <yilun.xu@intel.com>, <yuzenghui@huawei.com>,
	<zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Message-ID: <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
 <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
 <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM4PR11MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba4d8eb-96c6-4e7b-dc8e-08ddb784a4ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1ErM1NadmVuaG1hZWhzcU1hYkhZWU16ZEhwRER6ZTcxNkhFM0o3Ry93VzJs?=
 =?utf-8?B?aGJpRVo2TENxMktJNUcxVS9wMmdNOU0rVkovQ1hXQVdFUUtKeEZoMjdQYzlp?=
 =?utf-8?B?Nk1BclJUK0cwMHhqcXYzU2ZQWXVGWWxicjVubE9EN3ViMVQ0ak9HZ1VibS9Z?=
 =?utf-8?B?VE1GSVk4akFHcEpKTlR3YTVHdVNpbWI3REFIdXlMNjM4Tmo3RFp0dHNubjVw?=
 =?utf-8?B?bThUUVdBdGMyNXFYMXhxekkrOER3bldwazVqb0lJaC9ESmJkUGROaGtUWE9Q?=
 =?utf-8?B?NFlzbTl4RlpoS3JWZlJVcVVkSTk0YUFqUkp1dWFBM0d4NVFKdk5IRm5BdnlG?=
 =?utf-8?B?bWhzd1hZUS9ZRTRMUG9DQS90eGNBYUE2RW5tRXJINkJ3VGtka0J4OGxUOUdm?=
 =?utf-8?B?UWtvKzhKNUpCelExRUtkd0twZlZ2SWlna0l0N1dZNkNFUit4QmltQ3Zqd2ZO?=
 =?utf-8?B?Vk9qRFBUcVZ1Q0pvanRkeDBSdjFyMG9BWCs1YjFqYWxOR2drOWRveElWOVdD?=
 =?utf-8?B?L0hSL2JYS084NjI5a2FQWHlkRFRxdm9lQlJtZ0czSmFWKzE5V1g2TXBNMEtq?=
 =?utf-8?B?TVFjbm1mbnlhRTJDTE0ybksyVGFCRi82cWNSdVVOUWdWS1BTWGRUazN6R29T?=
 =?utf-8?B?WmFtc05lZHk4VVUwdkFyOXR0dG1KcGh1WEdvcE5kSEVRNU9XdWJ1Z3N4QUpU?=
 =?utf-8?B?V3VPUlF6cmlNYUZ4ZjJsNXdKdG9vMnl1Mzl0cDM2eG5oT1gyQ2dKOVRFTVNL?=
 =?utf-8?B?dWxyTWpmak84Z2J3R2lOU2hHRFQ5RUIyazdpeW8xWW9SY0ZCc1cwWlZNOXN0?=
 =?utf-8?B?WVlKODdna1oxL2FzZnJRaUo1czZMNjN4cXgrQkJBSGRIWDJZWXcwWkRVOWJ2?=
 =?utf-8?B?eXM0dmcrNzgwaldQQnN2dGdHak9Ddlp0Wmd4RU55N3FTNnNTL0ltUHhtSCs4?=
 =?utf-8?B?TGY5eGtvdFJsc1JLNXcxdjkvTFNDTFltQTRNNmhLN3VhVGVYdUh1czgxdm5P?=
 =?utf-8?B?NTFYSmx4ZkdnUkZERnd4dUY2UERqc0lrY3Boai9wem5nbk15dERDRWhaQXc2?=
 =?utf-8?B?RDEyeTZGMFNnTlhvYzlKSlNyQnkxUXYwSXNIdk9jTTZ3VGVqWWM5MUlkWVRR?=
 =?utf-8?B?a1J2MWwxeVU5S1hsUHlvUHRsR05QSjdlV05kL3hmVno5TWZGUUJkaFdzT1Vj?=
 =?utf-8?B?dnlWT0w0aE51ckhqNzdBdWdhcHloUFhUK3EvcldQYnNiL0QxcGhPWGtXQnpI?=
 =?utf-8?B?RVlLNVhOdzFXckdGOUR3R3M0djBxUGhIU3FZOTU2Qk05RmFqdm93dlJmeWw5?=
 =?utf-8?B?akFzQlhPbG4vM0t5Z2ZXbFYzMWFRak9GeStQVnhRUE8xdHZTZGNBSkxRZHU3?=
 =?utf-8?B?ZnBMTEUxZXFzb05wdWdDVS81bDc2SURvWXM4Z2NCOVJ5UG56QUliV1Nlc2ZZ?=
 =?utf-8?B?VElIb2MrYXZiS21ZWFJYdWdadjBxUk8zTndhK2FMU1lDUXUxVlFtWkNDSUdL?=
 =?utf-8?B?a3NkeWxRbjVzSnFvNmZqNkFFV1BiRGVsV1VMTmp6THo2dmlJWS9hMFg2S2Rr?=
 =?utf-8?B?bElHTDFvVjkxUFpyNHF4NERUQXBMeGVHT093M2t6VVNpcXY2cDJoNlpZOXpC?=
 =?utf-8?B?STkvSXQvMnNheDJwV2RydDJVdWlkNkc0Z1FkQ29YSWpQeVRNVlNEeldwRGJu?=
 =?utf-8?B?Wmp6dzM0YWcramNtMCtHcXhWQXZRTEthc0hkZjJHc200d2oyaEdRUTAzeWZW?=
 =?utf-8?B?dW5WR3Fadk9LZGVzUVNzVndvS1VBM0t5Y0I4ZXd1NXRFcmxBQi9wNk9nZFFi?=
 =?utf-8?B?Q2dPckNRUUd0UHFMNEVCYXFxdkZxRVNtUzlOYWZWT2xJbjJOZzh3cGwwb1N3?=
 =?utf-8?B?V3RKdXBqMnBlM0ZrbXlaTmh6RDgyK1JSVFI2Yk5LVjcvb0pWVHNKaGJUV2JD?=
 =?utf-8?Q?UrroExMXFYo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWpKaVFjeHd3K05hNmRwaEpUUDdqZFhGU2QwSTNRQThYZ0NSbE9wSEw4b0kx?=
 =?utf-8?B?aHpKRHFJUkgvSzgyNEpPTlEybldpTWo0d3hiV3BYWUZaZkxOaXV5QjBGK1dL?=
 =?utf-8?B?UmVnc1hjQ3psTkxiMmQ4NmE4Wm9kblZ1UzFzbmtTRy8xaUJFa3dXMVZpQ0xh?=
 =?utf-8?B?bUJETXlhbjE2ZzRQaDhNcUV6TVJiZG1MQ1VPaDNhN0ZsL1NIb1M0TnI4ZnF0?=
 =?utf-8?B?bjJLVWFUNzB0c2lOTmlvWmN5TUo5V001dHVoVmMwR1pULzVKMTYyNHh5NHpY?=
 =?utf-8?B?T3RNT1dxSGJPcUZpTkN5eWgzVmc5akI4OWc2Rkpoa0FKRHE4YXR2WVhmZ3pI?=
 =?utf-8?B?MXFNNFU3MHdNTlBXZlF0LzlnK3pqYVFRSXNjdUlDRndiQXhhbURYN0VtemFj?=
 =?utf-8?B?QklVV25GdG9FcUYyaFZvK0VVc0FJMjZEQlIrV2xQRERSeVZ6L0tZT3hBVWVC?=
 =?utf-8?B?K2MzNllDYkxzMEh4akMvNDJndVJUTlRZdW4xZUNUd00zeG1xN1M4Y3c1NWxD?=
 =?utf-8?B?SlhHaUorelFOeG5UeE5ZTXRHVWlKaHM4Q3gxcE16eFJJaDNEeXd1NGlqaGVJ?=
 =?utf-8?B?ejVaZzdYN1I0MXhwb0pkY1BheGVzUWJybHlFdjlBSmIyZnJYbis2d3JJMW91?=
 =?utf-8?B?b2lFa0YzOTZYcWM5Zi9TNW15T0RHSURNR1VTeEd6eFZPZEFZYlpua044VTVK?=
 =?utf-8?B?VThOUm5TVG0xd3NQbmwvc29XQWZIMDVLUjVSS2Q5dzA1K3dKdWlYU0VTUENh?=
 =?utf-8?B?V3ZtdkRMdE93UUxNNVBUWFpxcnkzZGNiRUhEbjZFWkZjTHpsRjFwSVdyRFpi?=
 =?utf-8?B?U0gvN2p0NkhOOHF3K1hlbmFuRENoejNjY3N4SXNzV1N4T1EreWxyUlhhQWoz?=
 =?utf-8?B?MTI3K1ZQT28rSlBoa1R4YVpoMmI4Y1loM01BKzM3SDFGTGx6eElrMlFNNVg2?=
 =?utf-8?B?RndVbkN2SnhLMnRMYlhDSklXQ3pxV2R4SEdqMytxU2p2bVZuZWVmMEJoWW1s?=
 =?utf-8?B?SzQwMUJGb1pYQnowbk9YNFdvOHRVbU1tc0pFbmRwUmoxcTBCQUlBMU1uUE8r?=
 =?utf-8?B?ak4xYlZWZUhzYzVJY0xCMmpmUTZ3SzJrbWR6SCtxWmJzc1NWS3pIQ0hyVVZx?=
 =?utf-8?B?dkVXLzQ4Ui9jZ3EvRFlMbGJZdVdwTEVaZ0E2djB4Z0dLNlVWRGhkaFdJdHJF?=
 =?utf-8?B?TzkyVVVZeExEMjJsT00zTTdOckUrMHVEdDdNUDhFRlN2Sis4RzMrVFpZMm8z?=
 =?utf-8?B?aUxhQ3h5MTBtdDQ5T3BlZUZqcDVhUmZsWDZKQU1HNFFVTU5rRkxOR01wRWJ2?=
 =?utf-8?B?OWYvcDBrc1Eza2xNZnJyUnJYLzVHYkhuRGFwZjBCWnpOSElpczRuWjVUd2c3?=
 =?utf-8?B?azZudlVBSmM5Q2lOaWVPYmxxNm1KMlFsZkkxRkJqSnBiNnFTdzNiUm9Xd3dy?=
 =?utf-8?B?dmJTRmlpejEzcjc2Y0FjSHpOcGVZc3o3ODhDeUhORzJySmpVZGI0bXBFUnVt?=
 =?utf-8?B?UFU2NnZXeFdZc2pCLzgvd09oVEl2YjVqRlJVQkF0VmF6S3NFMC9GUGZ1dk1Q?=
 =?utf-8?B?RE5xenpNZHZMclpFMEJEVUJKTlk4UitQRlJMWnAxbXpySGl3SmtNSm5yTjhS?=
 =?utf-8?B?bDhBRkpvUjdiZU5RZkZ1MEcxRUFnY0lxdXVPeHd6UzVMMDFVZGJvaVdHOWQ0?=
 =?utf-8?B?a2pRWU14QUJOOU9nM3BiNDArVnNCTlBnc2VjZlNqT09CMUpnYUV0eG9wc0E5?=
 =?utf-8?B?bWN3cjZrUWxFUy9MRFkxZ0toWDU0R29GeFlTRlpDQ29oRFBXYmdXaUJzZ3lw?=
 =?utf-8?B?bXhJMEMxbWUxRFgrRkg3bk1Wa1FIdVNwWjkrRGllQjBKRm1rNDdNdWo0bzVs?=
 =?utf-8?B?a3JQQzRudTJHREpvTlZ5d1dTREc3aFZmcXZZQ3JaNVd2bFBOK2pxL08rZGZq?=
 =?utf-8?B?OHBOdUVib1pzRjZzbFNQcUVkazd1L21BamlSTTRQU0pxdFJ6Z3FoZUdmNUtH?=
 =?utf-8?B?dFR3S2F5N242RU1qUldoUnprNTZNU0ZjYlpjSCs0UWUyRWQvMG9FZFRGQjNq?=
 =?utf-8?B?MUhuazEzdXJVaUMxQlhhUFhNWGgxQlNpTXUyOThSR1lXSmVFalNhUFBFeGsx?=
 =?utf-8?Q?cZPUEr/12Wn8OFVg8y00T7Bh3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba4d8eb-96c6-4e7b-dc8e-08ddb784a4ce
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 03:17:28.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNOkh0zsEOqe2LNecL1Z3oTolKsAEo/K7TuwX8u/eFPAU8cQgMRNXXsvzaqs2+N5pD1NXdCpvPDILC7K9U4Wqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com

On Sun, Jun 29, 2025 at 11:28:22AM -0700, Vishal Annapurve wrote:
> On Thu, Jun 19, 2025 at 1:59 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> >
> > On 6/19/2025 4:13 PM, Yan Zhao wrote:
> > > On Wed, May 14, 2025 at 04:41:39PM -0700, Ackerley Tng wrote:
> > >> Hello,
> > >>
> > >> This patchset builds upon discussion at LPC 2024 and many guest_memfd
> > >> upstream calls to provide 1G page support for guest_memfd by taking
> > >> pages from HugeTLB.
> > >>
> > >> This patchset is based on Linux v6.15-rc6, and requires the mmap support
> > >> for guest_memfd patchset (Thanks Fuad!) [1].
> > >>
> > >> For ease of testing, this series is also available, stitched together,
> > >> at https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-support-rfc-v2
> > >
> > > Just to record a found issue -- not one that must be fixed.
> > >
> > > In TDX, the initial memory region is added as private memory during TD's build
> > > time, with its initial content copied from source pages in shared memory.
> > > The copy operation requires simultaneous access to both shared source memory
> > > and private target memory.
> > >
> > > Therefore, userspace cannot store the initial content in shared memory at the
> > > mmap-ed VA of a guest_memfd that performs in-place conversion between shared and
> > > private memory. This is because the guest_memfd will first unmap a PFN in shared
> > > page tables and then check for any extra refcount held for the shared PFN before
> > > converting it to private.
> >
> > I have an idea.
> >
> > If I understand correctly, the KVM_GMEM_CONVERT_PRIVATE of in-place
> > conversion unmap the PFN in shared page tables while keeping the content
> > of the page unchanged, right?
> 
> That's correct.
> 
> >
> > So KVM_GMEM_CONVERT_PRIVATE can be used to initialize the private memory
> > actually for non-CoCo case actually, that userspace first mmap() it and
> > ensure it's shared and writes the initial content to it, after it
> > userspace convert it to private with KVM_GMEM_CONVERT_PRIVATE.
> 
> I think you mean pKVM by non-coco VMs that care about private memory.
> Yes, initial memory regions can start as shared which userspace can
> populate and then convert the ranges to private.
> 
> >
> > For CoCo case, like TDX, it can hook to KVM_GMEM_CONVERT_PRIVATE if it
> > wants the private memory to be initialized with initial content, and
> > just do in-place TDH.PAGE.ADD in the hook.
> 
> I think this scheme will be cleaner:
> 1) Userspace marks the guest_memfd ranges corresponding to initial
> payload as shared.
> 2) Userspace mmaps and populates the ranges.
> 3) Userspace converts those guest_memfd ranges to private.
> 4) For both SNP and TDX, userspace continues to invoke corresponding
> initial payload preparation operations via existing KVM ioctls e.g.
> KVM_SEV_SNP_LAUNCH_UPDATE/KVM_TDX_INIT_MEM_REGION.
>    - SNP/TDX KVM logic fetches the right pfns for the target gfns
> using the normal paths supported by KVM and passes those pfns directly
> to the right trusted module to initialize the "encrypted" memory
> contents.
>        - Avoiding any GUP or memcpy from source addresses.
One caveat:

when TDX populates the mirror root, kvm_gmem_get_pfn() is invoked.
Then kvm_gmem_prepare_folio() is further invoked to zero the folio.

> i.e. for TDX VMs, KVM_TDX_INIT_MEM_REGION still does the in-place TDH.PAGE.ADD.
So, upon here, the pages should not contain the original content?

> Since we need to support VMs that will/won't use in-place conversion,
> I think operations like KVM_TDX_INIT_MEM_REGION can introduce explicit
> flags to allow userspace to indicate whether to assume in-place
> conversion or not. Maybe
> kvm_tdx_init_mem_region.source_addr/kvm_sev_snp_launch_update.uaddr
> can be null in the scenarios where in-place conversion is used.

