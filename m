Return-Path: <linux-fsdevel+bounces-49283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3BABA190
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764AD176175
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E952550A3;
	Fri, 16 May 2025 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ez5J7X5u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513221CA04;
	Fri, 16 May 2025 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415098; cv=fail; b=NvlLsgccg0MoysLNWnK/1tZNMHyCpVfMdOqwB8KJ7kzaDuY2SzS5ypYH4yjUHNC7vFrKAZPJqrK581dhroBhkgJVqnMs3T8KjYGZExxXro/4ayLtfs8nAPfl3pUZYX05pQR2eTQ8tIX47tDRzf3QXLicNnBYluQYBwrGgC+0kHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415098; c=relaxed/simple;
	bh=9uFT6LGJKDBauC3dX0rQMT1Dx4vWbxC96q5SM418OvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGPnFhAzt0SUOEEVNoQViAhNPB0diMv3XkWNdf9mvmJRJF+Xcu81QYkFXwniEyW7yWBAnrLuthk9Ff3lVz6Ag0OxAKR1YK1NGX4kkyqsqmRX5hv/F1kkgItX9EmwYCQ1j/Vchx3FCHKfl3moNlHcVhiQzb0Qz7QNfs4QG5MBvGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ez5J7X5u; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747415096; x=1778951096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9uFT6LGJKDBauC3dX0rQMT1Dx4vWbxC96q5SM418OvE=;
  b=Ez5J7X5uRref4e/zLPA71sHYu0lvBmry+jr7pVa/X8hNyihvDl8X0f+s
   C698U6R9P5rAwbIazT7kLbLpwl69MF9GA7FnKPAWvZuKydNGgyGTn8+Po
   1SoiVB4XVxo7S+/ZeOHy7K1kvxa8GA9GJZvXBoA4VmZoFiOS3Bxs9PQgU
   8SXP1uv3ZvYopSwQFSVdMprCtOmJ6Kyd+IShYOmrCbh6OJvpQirpIUO4A
   437qgKG+/4dFYmd2T7WxUcqTvULZJMynRi94BExC9e9TE3M0V0bq/5ZzM
   0yZ/sb9G+yw008Tk7SpTnasVubCTvrzEjSaSP6TyI2zSp8c6vTQnWH9CQ
   A==;
X-CSE-ConnectionGUID: 6AoeaFOcQj2iN+dr/XF0VA==
X-CSE-MsgGUID: sxpy4EMsQnqWkPig3w+QiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="37013247"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="37013247"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 10:04:54 -0700
X-CSE-ConnectionGUID: WHddbqc6QWS3PAD+zij8ug==
X-CSE-MsgGUID: m5cHhDFBR5aDwSILwg8siA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139232346"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 10:04:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 10:04:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 10:04:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 10:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezOunh5kL97hKl2RHbD0f/FlmjVJA3IlEd4Mr7cnxBSj1eak2LjzqG347HAEsD+C2eEIsFrbu4WmArukF1FLcJDfgyLsBfJ9etQ+iHcZ3IsfaarKpRJVqoNvSzcjIQxZGrNvUalUdXkIBX6C9+H10YZWwhfvrJEnuYVuF05Yd7nEl7/sCiVlizHTYqG3qUKK/MtZtOzzGCUryewqpDAJ7v3YdgG3tXaVYAqY//m78QA5DBxTuTDwY6/Cb50hv7MPbbQG3/JtRLDhy/cZH4sHf+Ys6cEezzLDoK6CfZl3YjQp5+KVEyJ/cJksryTtib74uviz8nE0Kcq33e0cq1dQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uFT6LGJKDBauC3dX0rQMT1Dx4vWbxC96q5SM418OvE=;
 b=INmMyJxH/ev6JXN/gaZErCVAIsCVSae86cZP0rCV/onSWjL1iRBrevT2nOVpYRtkmYgIJCURBDiCkW6n3YjgrmzqjeGvV56MyxEqpRQjF/wLGcZ4HdZx50nCOE8CrjcVgobBBAwYNOcpbWxZelwsovyZk2efyAttiLr9jGOBT/pUaWu+ashYfnfjc1bHXLl2M+yqmr/f5yO3jGJCnqOwOCmgvSCGte8xrQZNcGzCBE9lVRVpT/H1iSR/L+xy/nqbMxGE2lKVhWnomgVAq87rOyLH+MyJYfhmJ+IF5wlBYxJ9TFoyFLtW6CEfxoo9ghfSOV88CynBbStXHilGsF1CAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 17:04:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8722.020; Fri, 16 May 2025
 17:04:47 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "Shutemov, Kirill"
	<kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>,
	"steven.price@arm.com" <steven.price@arm.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"amoorthy@google.com" <amoorthy@google.com>, "tabba@google.com"
	<tabba@google.com>, "quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>,
	"maz@kernel.org" <maz@kernel.org>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "keirf@google.com"
	<keirf@google.com>, "hughd@google.com" <hughd@google.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "jack@suse.cz" <jack@suse.cz>, "Wieczor-Retman,
 Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "Du, Fan" <fan.du@intel.com>, "willy@infradead.org"
	<willy@infradead.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"nsaenz@amazon.es" <nsaenz@amazon.es>, "aik@amd.com" <aik@amd.com>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>,
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "fvdl@google.com"
	<fvdl@google.com>, "rppt@kernel.org" <rppt@kernel.org>,
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"bfoster@redhat.com" <bfoster@redhat.com>, "quic_eberman@quicinc.com"
	<quic_eberman@quicinc.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "mic@digikod.net" <mic@digikod.net>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "Li, Zhiquan1"
	<zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas, Erdem"
	<erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "Xu, Haibo1" <haibo1.xu@intel.com>,
	"anup@brainfault.org" <anup@brainfault.org>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"Wang, Wei W" <wei.w.wang@intel.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "quic_pheragu@quicinc.com"
	<quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "pankaj.gupta@amd.com"
	<pankaj.gupta@amd.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"nikunj@amd.com" <nikunj@amd.com>, "Graf, Alexander" <graf@amazon.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, "Xu,
 Yilun" <yilun.xu@intel.com>, "liam.merwick@oracle.com"
	<liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "qperret@google.com" <qperret@google.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"pgonda@google.com" <pgonda@google.com>, "quic_pderrin@quicinc.com"
	<quic_pderrin@quicinc.com>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org"
	<will@kernel.org>, "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrPT/RKAgAAK44CAAFGtgIAAFymAgADMfQCAAEGWgA==
Date: Fri, 16 May 2025 17:04:47 +0000
Message-ID: <74311e891016f9c8480229aec171142b3b0bf4bb.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
	 <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
	 <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
	 <aCaM7LS7Z0L3FoC8@google.com> <20250516130950.GA530183@ziepe.ca>
In-Reply-To: <20250516130950.GA530183@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4936:EE_
x-ms-office365-filtering-correlation-id: c5da2491-985f-4651-144d-08dd949bc38f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K0dNQXMwZHRqR05INnJCYldIZEhLNlJWM3hibnl6T1ZZY2FNenB6Q3RHSlJH?=
 =?utf-8?B?bW50NVR1V29PbHBHOUIweGZkSkxNL1hGOEZBMFJyTjJlbTI0bXY2Vk4xYzRH?=
 =?utf-8?B?MzNYZFZUeGZEc25ad3hodFlZZjdkVVZJNkl2OTUxR01GM2hNRGhwakxWM2sv?=
 =?utf-8?B?Q01LU1dsYWpJZnppMGEvZ3A4NCswSXM0MXd3VmhBbnZISHdleCtMTy90R1po?=
 =?utf-8?B?dlpwSk03WGJpVVFkNmpGc3BrUDVUUnhiUG9aek1kTkFPWCtBZHE2NENWNXNn?=
 =?utf-8?B?cjFPU2o2Z3dSVEZXbllEOXZVQ2FGYUhiVnhsU1phdCtZQ0hSWDhlQllSeTc0?=
 =?utf-8?B?azhDN2lmbEhNUEVxUHVUMGRZVnRzczFuTWxXbFJzSEZHWUtxUE0xdWEyRFhj?=
 =?utf-8?B?dllTckF0eko3dDExKytRaks4YmRQSXNQWFFZbFU0R3d3eUFLZHJLdVFhZGxh?=
 =?utf-8?B?TmowZzBVaU5TL2hSeEFmVFR1bVI4ZStEenhkb0hoK0FLSHFBamY3L0FyTzZN?=
 =?utf-8?B?MG5LaUkvVmdtSkkxOXgrd2FuMDdlMWM5VjBnRkhLekczc1hiZ0czYTlWelJM?=
 =?utf-8?B?b3g0U3hnV0c2SEdxUkMvM2EycmJRbXA5UWl6cmk0Y0NkT0UyMFk4MlZ6dTNs?=
 =?utf-8?B?U0JQaHVma1pqdUREb2V5Z0dnajltVmZzbGNsZ0pBa0UwWW5yQUtDQjd6a2xO?=
 =?utf-8?B?bm5lSi9UMmZNc2ZCRUtsdm5KdkJXaHpWV3p4Ukd3aVRjQ3dNWGpTUHk0WFAv?=
 =?utf-8?B?OUo3emJFR3ZTWGxkdlB0b1lKZDltbTQzUTNVNTl1NklLdnFucDVXUGlTV2pH?=
 =?utf-8?B?WGFPeTRSd0NxbzVlQTVEN091Y1FPbFhXNERlSlVKODNjTFlkcGQ2VnRkWDY3?=
 =?utf-8?B?T0FFV044TzRKclBRbEorcFk4dmFjOEtmQjgxNVY0bG4zaUhtMS82NVVYMHBG?=
 =?utf-8?B?ZmJzUGpTRE1la0owR1k4Y082V1J6WnRrWTlCSTE2cGV2ZFhYRzErMHg5KzdM?=
 =?utf-8?B?WGsxSTR4ZnlhZ3MwNkthNTVmTTUrbjg2WjRXMlBtSFNIVTN2Y1Y5cFNxZXV3?=
 =?utf-8?B?c2Rna2s2eE8wQkx6eE8wSlFHZmdscUtUNzF1SzdIVXVJQms4b3JVSVk3eG1J?=
 =?utf-8?B?bmJyRElYdmNVQi9xeklqenBVc2pCTEdzSWtLbFhzeEFhby9yOGptbExZMUFY?=
 =?utf-8?B?OThxWEw5WDdiOERqRnY2WUdYRVNQdlQ4ejIxQXh1Z2lObU9HanpRT2t6WnJF?=
 =?utf-8?B?OXdlcnRkL1hkb1pRbXNRcXFtc21NUjBXcnk3OTI4WTFRQldzaVN5UFdFTCt3?=
 =?utf-8?B?Wktma1ZTZWhKbUZyc1ZreEJ1UVpZS2tpM0lFdFhWZkhNZnpYSVNMMnF2Qkhs?=
 =?utf-8?B?RmhYUGQxdTlQMDE3dmt2U1JTbEZnbVdpRkdQL28wUHZza2JxWTg5UHRsaG95?=
 =?utf-8?B?Y1NuKzZQbXNQRkZOMzczcG5pbjBmTW04a29PN2c0YVNnSCtIMnBnRFNYaEU1?=
 =?utf-8?B?ZTY4NzNnd29hRW1lemdJaDdzaktidTNaVEFpL3VNQU0wNTBPZWZqMWtTL1Zp?=
 =?utf-8?B?akliNHJRNE81RU55ZW5HV3lGNUZJdTlEQTV5T2d4OVVDcjVWcUxwYkgxcDNL?=
 =?utf-8?B?SkNNK1hPUG9IVGNpSUZLYWMxUjMrSnlVSjBOL2FqUlZGelZaRFc4WlJrWHBB?=
 =?utf-8?B?dmsvVWo0Z2ZjSmh4NUNWbXd3NXRvU0lJbnBXbTZLcUk2b1lueW9xa2Jra040?=
 =?utf-8?B?QWNqNllwcHRTTVg4UkEwT0FPZUhlNnl4R1J3UEEzNkFGYVNLRko2OTVVUFpU?=
 =?utf-8?B?dHUzNHZNdEtaZ3htL1hMRTZMdGFpTzVvYUowYUc5VXpyQThjWG43MUdwS3A1?=
 =?utf-8?B?LzRBSUtSMDRLcjY3TmVKaVROTEtNYUhDNUVCbEdZYk41OXc4bVFlMzdWSHhR?=
 =?utf-8?B?ejFmb1FnVjN2ZG54WXRKNU4xVDRLYmJmTW8yRTg3TjhTaWZJOG5jMGpKaXdJ?=
 =?utf-8?B?Tld5b2IvZ0hRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEk3dHovbGI1SlJnTk9zcGRteWZ4RFJDTGVPa2kvc1ZPNldidENoS0xwcW9L?=
 =?utf-8?B?bXZXTXZQc3NjM2JaQjJ5c3JCYXp1WDNWNGcwaVZlbmlORDd5RVNZd0NTbjhs?=
 =?utf-8?B?SXdvK2trenVmZXhBNGdLdmFCYmluVTBnSU5QN2FuRElubFczYm4vS015emg2?=
 =?utf-8?B?RTNSQ3Z0eHV4VkRNZWtwQ3VaWnpsTXRuNS9MS3lMQ3FoQU5lM0h5eHNxNUJ0?=
 =?utf-8?B?dnlieHoxY3ZoWlFuNWp0dmtZclcvc3NVaDdqK0kxZ3VoWkxHU0tLR2IwMk94?=
 =?utf-8?B?Wm5kM2oxOW9mT21kaG9wR2ZiOVlFY1czSkZvT0oyN3hzUGFKa0FWNDhvQ2FV?=
 =?utf-8?B?eWVrajZKYzVFZDErRTlvU2UrNUc2YU5YMzhTN2RhdTl6RHJmaERXL1doMDE2?=
 =?utf-8?B?TVFiOHB4L3ZVZ3ZPanZZbVhUVnBMS1UzVy9Qbll4K01DaDI5WjhqMmk3d0ta?=
 =?utf-8?B?RHA4WDBGMmErWGFqRU54UGM5L1ZmRHdXZk1ncGJqa01xc3lreTN6OUR1QUNR?=
 =?utf-8?B?OER6bWJwaXlsTndXL0xIVjc3MDM1ak1YRnFITFA4L1pxN09sbVphTEdoQzJn?=
 =?utf-8?B?eGVPM1RIcE81ejhGY2hBU2RNMWZ5SlE4MFRUbTZPbXovTFp1NHRKNTllaGdx?=
 =?utf-8?B?WVF0WVpuQ1FLMHVmaHk4K1BOM2UvdHB5MHVvTWJHVXRmV25VQ1NLd1pEdjQx?=
 =?utf-8?B?VzQ0c3VWVzlYbm9WU2hvcVl4MW5wcHdOZnpucERjTUF6Sm9FK2lINzQ2M3Vh?=
 =?utf-8?B?R29tVE1HZjZoTXVFdFFER2NjdU1aMDhwWXgrQ05rQWZlNVZqakFpQ0MxQjNL?=
 =?utf-8?B?eUxJaER6YnlJNU05dGNTZFdtU0RzM0RWenBYK1kxdEdRdFYzTGZtekpnSjh3?=
 =?utf-8?B?WjBkRmhoUmowMkVVb09LSWhqVmYyeENsOEpNTk9KUXNDZDgvUmNoRzdJQ0Js?=
 =?utf-8?B?TGQvMlhacUhpdkwyUFcreStLa056VExqOEQzN1E4YzFXOC9RaTZBVHVSQVll?=
 =?utf-8?B?OCt1aStPOEZTYXRUSVJYZVRoVVRqU2VhRmdWVEJsNU5iRkVHdThic2t0WFhI?=
 =?utf-8?B?UWJyNGR5d3Evd3hmS0xHM3crYzJhZVZOWWtVY3hMb21jMmRGNUQ5QVFpV2gy?=
 =?utf-8?B?enQxWmlxMTdmK3NSWk1EL1JuanR3d0tBaGRnOHpCL09nQnZ4TzZrdzIvMmFI?=
 =?utf-8?B?dCt6MnJ2ZGFNaWlOTWJhVy9NSXBnRm9zL2w5eWFFY2NBVk5jbXl2ZW53Ykcx?=
 =?utf-8?B?cjJRQVE0WEtORjh6ZEpkUjBKNWJvRFZ3bkp1VGpoVU1hYUxmMTVQMzExY3pw?=
 =?utf-8?B?ME9VM2xLUkpFc01zd1d2MThlZFJSTnZPS0xheWd3TEF0bGVjNitFZlJRUTJE?=
 =?utf-8?B?K0lxYUlkeDR2V3QvaEFHQXVOSUVXRmREc2xLTjlkWWt3NEdQM2FJUnhyOEYx?=
 =?utf-8?B?Vm9sVi81NitJR3d3SmszeHM1K1hPcEEvK0YwQmgzY0c4eTdUckxhWWpVcGlk?=
 =?utf-8?B?R2NGb1p2TlJaL0hVQm11N1lXZTM1SHd3bmQ5cFVEaEo0WWhWcjc5VFNiekdR?=
 =?utf-8?B?eGZkRXk4ZnB2N21XeGlLcFZRU2IvVVlwaGVSS0hQMDVNaHUyYWVrR0Q3QUZN?=
 =?utf-8?B?USs3VjByWFE2MU5Lb1AwVGd0SkdMOGFkK29JQVhPVU1keXVXMHA0VU5BenZJ?=
 =?utf-8?B?YjJnK0N6RHZwRlpQYWtoQmJ1ZkJVL1A4Y3Rybk9aOEFVb1lNNXJhUGovamho?=
 =?utf-8?B?NEZnNjNob2NtRkJUS1hFT0JrUFVteE1wRGxoUm1ZWlNiL2hva3JrZVJwbDQ4?=
 =?utf-8?B?dGp5YkExbU9oOXA3VGlaK3Y0SnU0UUhqd3ZCTy9MaWdUVVY0UFF4SFo5VlAy?=
 =?utf-8?B?TGxuSWxRbWQrSWhkQnpDRHNXaVFBQ2RtdnVQRm5zTG5qUWw4MmxEd0NUN0hO?=
 =?utf-8?B?TTdVejRDcHNqVEZSTGpnV3B6U05iYmYvQnV1eU1kZ0dnQ0FzRkVuUVh0aEk1?=
 =?utf-8?B?TkxwbFZYd2ZoRS9MVFFnWFJpNzhqY3V3STk2bm1jMHRkZ1hveU1idGgxandz?=
 =?utf-8?B?ZWpEQTFiSERtSCsyaGMzLzR4UnZ1ckUxaGhURzJWcUcyNWpVemxhUGthRDB0?=
 =?utf-8?B?QWRqd3hqeE4vY1FCZjIxdkRDSW9lWEJqd0FmSGFFUjJtUlVyWnBEc3ZFZTAr?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A095B44840A7846962864FB8672F0EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5da2491-985f-4651-144d-08dd949bc38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 17:04:47.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZyEei5DFDAbUpUp7oM2NeJyEOWnACOcIer+Bhoroo0Vgkgch8gR2OprkPgomRqUFTHLWdO5viqDuout65SHHSh0/0h25ULjJnvgd0oT15g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA1LTE2IGF0IDEwOjA5IC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+ID4gWW91J3JlIGNvbmZsYXRpbmcgdHdvIGRpZmZlcmVudCB0aGluZ3MuwqAgZ3Vlc3RfbWVt
ZmQgYWxsb2NhdGluZyBhbmQgbWFuYWdpbmcNCj4gPiAxR2lCIHBoeXNpY2FsIHBhZ2VzLCBhbmQg
S1ZNIG1hcHBpbmcgbWVtb3J5IGludG8gdGhlIGd1ZXN0IGF0IDFHaUIvMk1pQg0KPiA+IGdyYW51
bGFyaXR5LsKgIEFsbG9jYXRpbmcgbWVtb3J5IGluIDFHaUIgY2h1bmtzIGlzIHVzZWZ1bCBldmVu
IGlmIEtWTSBjYW4NCj4gPiBvbmx5DQo+ID4gbWFwIG1lbW9yeSBpbnRvIHRoZSBndWVzdCB1c2lu
ZyA0S2lCIHBhZ2VzLg0KPiANCj4gRXZlbiBpZiBLVk0gaXMgbGltaXRlZCB0byA0SyB0aGUgSU9N
TVUgbWlnaHQgbm90IGJlIC0gYWxvdCBvZiB0aGVzZQ0KPiB3b3JrbG9hZHMgaGF2ZSBhIGhlYXZ5
IElPIGNvbXBvbmVudCBhbmQgd2UgbmVlZCB0aGUgaW9tbXUgdG8gcGVyZm9ybQ0KPiB3ZWxsIHRv
by4NCg0KT2gsIGludGVyZXN0aW5nIHBvaW50Lg0KDQo+IA0KPiBGcmFua2x5LCBJIGRvbid0IHRo
aW5rIHRoZXJlIHNob3VsZCBiZSBvYmplY3Rpb24gdG8gbWFraW5nIG1lbW9yeSBtb3JlDQo+IGNv
bnRpZ3VvdXMuwqANCg0KTm8gb2JqZWN0aW9ucyBmcm9tIG1lIHRvIGFueXRoaW5nIGV4Y2VwdCB0
aGUgbGFjayBvZiBjb25jcmV0ZSBqdXN0aWZpY2F0aW9uLg0KDQo+IFRoZXJlIGlzIGFsb3Qgb2Yg
ZGF0YSB0aGF0IHRoaXMgYWx3YXlzIGJyaW5ncyB3aW5zDQo+IHNvbWV3aGVyZSBmb3Igc29tZW9u
ZS4NCg0KRm9yIHRoZSBkaXJlY3QgbWFwIGh1Z2UgcGFnZSBiZW5jaG1hcmtpbmcsIHRoZXkgc2F3
IHRoYXQgc29tZXRpbWVzIDFHQiBwYWdlcw0KaGVscGVkLCBidXQgYWxzbyBzb21ldGltZXMgMk1C
IHBhZ2VzIGhlbHBlZC4gVGhhdCAxR0Igd2lsbCBoZWxwICpzb21lKiB3b3JrbG9hZA0KZG9lc24n
dCBzZWVtIHN1cnByaXNpbmcuDQoNCj4gDQo+ID4gVGhlIGxvbmdlciB0ZXJtIGdvYWwgb2YgZ3Vl
c3RfbWVtZmQgaXMgdG8gbWFrZSBpdCBzdWl0YWJsZSBmb3IgYmFja2luZyBhbGwNCj4gPiBWTXMs
DQo+ID4gaGVuY2UgVmlzaGFsJ3MgIk5vbi1Db0NvIFZNcyIgY29tbWVudC7CoCBZZXMsIHNvbWUg
b2YgdGhpcyBpcyB1c2VmdWwgZm9yIFREWCwNCj4gPiBidXQNCj4gPiB3ZSAoYW5kIG90aGVycykg
d2FudCB0byB1c2UgZ3Vlc3RfbWVtZmQgZm9yIGZhciBtb3JlIHRoYW4ganVzdCBDb0NvIFZNcy7C
oA0KPiA+IEFuZA0KPiA+IGZvciBub24tQ29DbyBWTXMsIDFHaUIgaHVnZXBhZ2VzIGFyZSBtYW5k
YXRvcnkgZm9yIHZhcmlvdXMgd29ya2xvYWRzLg0KPiANCj4gWWVzLCBldmVuIGZyb20gYW4gaW9t
bXUgcGVyc3BlY3RpdmUgd2l0aCAyRCB0cmFuc2xhdGlvbiB3ZSBuZWVkIHRvDQo+IGhhdmUgdGhl
IDFHIHBhZ2VzIGZyb20gdGhlIFMyIHJlc2lkZW50IGluIHRoZSBJT1RMQiBvciBwZXJmb3JtYW5j
ZQ0KPiBmYWxscyBvZmYgYSBjbGlmZi4NCg0KImZhbGxzIG9mZiBhIGNsaWZmIiBpcyB0aGUgbGV2
ZWwgb2YgZGV0YWlsIGFuZCB0aGUgZGlyZWN0aW9uIG9mIGhhbmQgd2F2aW5nIEkNCmhhdmUgYmVl
biBoZWFyaW5nLiBCdXQgaXQgYWxzbyBzZWVtcyBtb2Rlcm4gQ1BVcyBhcmUgcXVpdGUgZ29vZCBh
dCBoaWRpbmcgdGhlDQpjb3N0IG9mIHdhbGtzIHdpdGggY2FjaGVzIGV0Yy4gTGlrZSBob3cgNSBs
ZXZlbCBwYWdpbmcgd2FzIG1hZGUgdW5jb25kaXRpb25hbC4gSQ0KZGlkbid0IHRoaW5rIGFib3V0
IElPVExCIHRob3VnaC4gVGhhbmtzIGZvciBtZW50aW9uaW5nIGl0Lg0K

