Return-Path: <linux-fsdevel+bounces-54368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF7AFED79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFB33A81AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4451C2E62B5;
	Wed,  9 Jul 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/6/dA63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC81DFE1;
	Wed,  9 Jul 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074233; cv=fail; b=p1E10CO+fohZ9i3IqnlmcffKRKr3PlBHrIfLi6WsnoZHHXXxwUTma4+DHlzG0UnnDIAtLNSbcO4dsO1uyUlk44ZmTuYdXbjWzIItElsGkt4gQ1VICcI+VSSEuA7ZbgUpGDRAWzs7a8auiTUVU7Gia+cXTWORSwEWHpfNtDKaqcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074233; c=relaxed/simple;
	bh=/mmHdK8/mmYoXRqD/VciWYT1F850+0YHH3SbOzCnxUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h/2+wDx4V6FCB7bJPZGdvMaOPcWM6Df9qDVleIst/siCcBzJOBjs44tBRpEnFmYTBNyjjUTLJouAij1sgpFyKNFkRdsLH8UtBcAjRYGTqX3PSf9BEcz6FyYYCBKg0YHvZItJTuMuvAcCrdwo1o932jdS7pqUdKQYvDkW00P0qh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/6/dA63; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752074232; x=1783610232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/mmHdK8/mmYoXRqD/VciWYT1F850+0YHH3SbOzCnxUw=;
  b=d/6/dA63bwRlnuUNhGcRa8R/LfZvN1nV30Oiu+MUSu2n4va+Xhdxfzd9
   oLDAUtZF0HowhrL8ZFF9HgxFhy5MLwneE6PZyi1gN3lJL1jxBG5j/Enkd
   7qtqjj2NBDfxcqaFzxySoLDAa5k2j/+C8SqLE8CNp9dG+pvQxvhE+agKr
   9m2lkQHNQV+YHFbRsKOmc4xsciz7Q3KTu8GaMLCVSgTD5yVrBKaFlJUnW
   j2JzL1Z9qbiuqPWGraYF0ZR4+mW8SRmyzNrIclQx9Ve2oPO1ydM6ybp2P
   /FcA4relUzoVZFJpqZ4WICRuLF8S53rq37dgocoCnEHlDt5pCNPmwbtao
   g==;
X-CSE-ConnectionGUID: 5TLM2w1GTRG+0yA3EhnpgQ==
X-CSE-MsgGUID: CsuNSJucRhGhFOOX2Hs7jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71925364"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71925364"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:17:10 -0700
X-CSE-ConnectionGUID: 6YzmaWOHSpauYYBDuoUW4A==
X-CSE-MsgGUID: 11LfdPKFQSOalyL5TcrPGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="193003032"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:17:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 08:17:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 08:17:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.87)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 08:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhmRo0ysCXIwXF0qwrQASDYbnRwWKQl0WRO8cZVjsTVcsYv3U8LhE9tR6E5BxmvqRG9f/sb8txapJxhnkgbhNZeoueibkkVaqOA5jN7f2S1T/EFS0NYECMBbtUtK/MAudB59FG6z7yqb2G5TIzJAqByKwgA2OAq7Jl4XGKDsFduT2fdbxSZ4f5zW6fZIbkPvQNa04F8mywdk60OvrsPc7Jz4+gtFaKNIYJ2VCqwo0j6oahp9M8d5fNWuvlfMRlDQ7q9MBA3DvVmSnYAKpU3lWeBMaaqoabjkGMY74cB+JetsN4q+OfgbenYrpcozgnMwyv1FEjUV/trZP4hXHjtbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mmHdK8/mmYoXRqD/VciWYT1F850+0YHH3SbOzCnxUw=;
 b=hj8ZFOTdQqQCICHH5rAhqe0oYI6TfTI8mg9czyQ4TtFTEbH1D7VlQaG/jRpbDe0dhfVtxFJ+NI1hKKko/kPUCv4dievLf6LY6qDFHJUgtBAcQGjResYddr/67LfUD1oimrOfnEqY+6cYAfsIQ9ID9VBEH4kM+cOx8xIe03C9T2Mg4nm9NNN70P8LU7l5mUmweKKLE5Af8dZDQsnlf8Hdii29oW2MeogsQgEPBPt0k2bNQbm3Hj0qbfjOnSlqFN3qkK4FVTYsZM52I3B4uMwaZuPu2F8JPFuWc81Mhxh0RtDCdJoibq9OQFj8cOl128ib+3Tg6QLzuo5STbhOo0Aq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7528.namprd11.prod.outlook.com (2603:10b6:806:317::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 15:17:06 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 15:17:06 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org"
	<x86@kernel.org>, "amoorthy@google.com" <amoorthy@google.com>,
	"tabba@google.com" <tabba@google.com>, "maz@kernel.org" <maz@kernel.org>,
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "jack@suse.cz" <jack@suse.cz>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "Wang, Wei W"
	<wei.w.wang@intel.com>, "keirf@google.com" <keirf@google.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"willy@infradead.org" <willy@infradead.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>,
	"anup@brainfault.org" <anup@brainfault.org>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mic@digikod.net" <mic@digikod.net>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "Du, Fan"
	<fan.du@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"steven.price@arm.com" <steven.price@arm.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com"
	<rientjes@google.com>, "Aktas, Erdem" <erdemaktas@google.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "david@redhat.com"
	<david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hughd@google.com"
	<hughd@google.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Xu, Haibo1"
	<haibo1.xu@intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "quic_pheragu@quicinc.com"
	<quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "Huang, Kai" <kai.huang@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "bfoster@redhat.com"
	<bfoster@redhat.com>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>,
	"Graf, Alexander" <graf@amazon.com>, "nikunj@amd.com" <nikunj@amd.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, "Xu,
 Yilun" <yilun.xu@intel.com>, "liam.merwick@oracle.com"
	<liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"Weiny, Ira" <ira.weiny@intel.com>, "richard.weiyang@gmail.com"
	<richard.weiyang@gmail.com>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "qperret@google.com" <qperret@google.com>,
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com"
	<pgonda@google.com>, "quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "hch@infradead.org"
	<hch@infradead.org>, "will@kernel.org" <will@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrQKWaYAgAAM4gCAEFZTAIAAkwSAgAC4SICAAP4mgIAA8aaAgAmqgQCAAA20gIAADwOAgADddQCAAAjqgIAABCOAgAAGpoCAAB1VAIAABn+AgAAGtgCAAAKygIAAC/GAgAFHvQCAAA19gA==
Date: Wed, 9 Jul 2025 15:17:06 +0000
Message-ID: <c9bf0d3eca32026fae58c6d0ce3298ec01629d33.camel@intel.com>
References: <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
	 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
	 <aG0pNijVpl0czqXu@google.com>
	 <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
	 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
	 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
	 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
	 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
	 <aG1dbD2Xnpi_Cqf_@google.com>
	 <5decd42b3239d665d5e6c5c23e58c16c86488ca8.camel@intel.com>
	 <aG1ps4uC4jyr8ED1@google.com>
	 <CAGtprH86N7XgEXq0UyOexjVRXYV1KdOguURVOYXTnQzsTHPrJQ@mail.gmail.com>
In-Reply-To: <CAGtprH86N7XgEXq0UyOexjVRXYV1KdOguURVOYXTnQzsTHPrJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7528:EE_
x-ms-office365-filtering-correlation-id: 98fc2003-34e6-4d12-a862-08ddbefbaa90
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZGZyelFLODU5cFFEcFhPT3JNbjZZMU4xYXdJdmNFTEQwaG9GNVlMdVZWY1lS?=
 =?utf-8?B?SkVhZm1NRE81eHhLWGYySkxQb3FMZkJNNUxnNXdpanBiTm9YcGY4dndscEZG?=
 =?utf-8?B?NkdJN0NvZUdkUmxNeU5OS3FUSG9VcXpkVlVtay9pNVlUMUordjZEVU4zSkND?=
 =?utf-8?B?REVyTDZjKy9sUkVjUms5d3VldERkYVdUZVBnTTh2Z1BxUmFPVzI0N0wrMXB4?=
 =?utf-8?B?VnpCWUFNZW9sT2x1S1VhQlE3bnl3Y1NpMVpBQzhsSEF1eHMrK2F5ZkZwTndS?=
 =?utf-8?B?WmZVMGRsM3VucGNRWGFjUFY1RHpxK0VmQmczR0lEczBmSHFNMTdCTXA4T0VE?=
 =?utf-8?B?MnRBbEFYcHZuNFAvY1Btb0gzdXNleksrK01PeUt0K2U1eHpDNUJocHNjOW5S?=
 =?utf-8?B?YnA2a3lSRGxYLzYzWlgyQVZ3cm5XY3NjTm9hR21LeWRmUW9tVGhQZ2Z3azRv?=
 =?utf-8?B?VXREbkx0NnJOYjZxWFliN21lbFRES3h6Q2g0L0dqck9lRGRtL1VGMVgvS1o3?=
 =?utf-8?B?Z0thWkNFMnR4VEZjdzFTQWtLL1JmWGduT3B6dHcwNUpMR0NqL3V0Y0EzS1BN?=
 =?utf-8?B?U1NqZ3dycmhvMGVxb1FoelpoSHRIdnZWYmhEYis4SGs0bWhrNDRaYTBURTdC?=
 =?utf-8?B?bW52SVBXajZKZ3RaTEg4MHRGRUUxdEpmanFFd01aWm9FOVg3YTMyYWRZbHhH?=
 =?utf-8?B?c0ZQYitxZHpRdmpDK3NrTHdVTUVDT3oyeXh0Z3hHMER2K0Z4SzJJb2xyQWQz?=
 =?utf-8?B?SU9UUlNXUmdCdHRmZ3kyOWZzdVlFZDF3aTN1VTB3ZE5OUU0xclJqUjBIQnZM?=
 =?utf-8?B?R2g1Smx4L09PVkFkNXJWRCtsMmVWN29Ja1dnUHZPTktGYnFNV2hUZlJXK25N?=
 =?utf-8?B?d2lhTjdLVnpVZkhwMGNDVGhOcnpCS2Ntck4zVGVkMzkxOVJDeFMxbDdnMmda?=
 =?utf-8?B?bEtaeGdnbDR4QmR3ek9hdW1jc3JLV0VSMXlyR2xwU0xHZHpIUFVzbWkzc1VZ?=
 =?utf-8?B?VU5uMk1lUEZiaGc1MEdyMWw0RDhhTEJtT2RhMjN4aFRZY0VHVjJJbzMvWHNI?=
 =?utf-8?B?aW42eGJOSGV2a1FtRmoxVHVEOTlTeHBCeVNqUjdIZ2p4cm9yOWg3Y1lRSlA1?=
 =?utf-8?B?SmVDY1diUTJCY1hBM2grVnBMNU9kbkZVK1k1MnlNdzllamhYMjJ2R29oU1dI?=
 =?utf-8?B?QUluK1BjMkZVWnhUY2RzYndWMWZEWlI5d1RzV2NVSlNzYllMUng5K1ZqNmhl?=
 =?utf-8?B?eFUwNlYxWFFRSk40WFh6akt0NGdTUlJZVm41ekI0REUrcEFLWHI0RGIzNWFy?=
 =?utf-8?B?VTVnZCszYXlCU1lXanJEZ0I2N1QwSzFseGFhd0NUWW85YXozSHQ4dWkvUDVs?=
 =?utf-8?B?SGRWQXZFMnFiS2tJTElmSHNnanQ5Y0k1Snp2R0tXVTE0Sm41YXhRRTZheFh2?=
 =?utf-8?B?RGVyVWZwWEVScjNFT2RrL0ZPV0lnM0RDNFFvdWVzZHRua0xCMGRTeTRMVnJN?=
 =?utf-8?B?SFhTd25vZlJzM3BybXRiTnovV3dnQlVEczJ0WjFuZitkQkRHMHExRzRvWUlB?=
 =?utf-8?B?cHJaUWJuNys1RVFzbTQxZkNkWEFLZUx3NnArRGdWYURBN2dtZnBwVnFEalBM?=
 =?utf-8?B?aDRka2FOZ3ZWUDZtUW55UlZjK2FxYXpEYm9hQlQ0NVB5bCtCY3RRTEZLdTZl?=
 =?utf-8?B?dFVMN0FHMjFYUkFKKzJjT1RyWmtuQVloTHpQblRhUXNVdmh4dlJ3NFNFWnpa?=
 =?utf-8?B?RDRMUDcxd1ZqTEtQRU9NTThlc3JwSjh2TUwzdmNnRHQyeEpOL3RqTjIxRFdC?=
 =?utf-8?B?M1dhZmVoU3NLQnVJS1RQOCtnWHFEb1ZpUVpEbGRQR2lTRER3cHo4NmdYaHBx?=
 =?utf-8?B?UzJQYkFSbnlhYVREWHJZOTBTdVgvOGdJSlcxdUx5MjF5Uks1ZnVRcTc3dExB?=
 =?utf-8?B?UEdrN0JWWWNqWENiK1c1TmZEZTdmZXIxRm9tR3J1V0YyLzU5b1VYU3pTbjc1?=
 =?utf-8?Q?uQE/MEk/CmYtVu+4fhPAc8oE8XaQKI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWQxemtKQ3Z1WWFKK25WRGlVWU5tQWVLNStpNDlUcVlmQzdHVlBYU09tcUNK?=
 =?utf-8?B?QVhIYzI3aG16Sy85YXlINTdiZkRtYzdadDg2MWNPV20wTHNhSUpWblRySCtW?=
 =?utf-8?B?dG90STJuNFRCRVA0N1F5T2RpVVlwNWN6YW5NaGVtdDNQaDNlZnYyVXZjcmxG?=
 =?utf-8?B?Z29id3dkeko2UFlPY0d2NFZMeFJXRVo5SEI1bTJ6clA0eVdjU3RnSEw5Si9I?=
 =?utf-8?B?akkxUlkxK3dmYkZSY2JMaERMV0FIRXkyV0pLYmlWSjhMNW1lUk54a1B2SXZJ?=
 =?utf-8?B?NTdzVVlxTlRNOTNJMHdRcmV5RWFCSnk3MFB4K0JLb3Z6VXR0VGNkOWpqV2Vk?=
 =?utf-8?B?Vk91d0x5dDRaK0tnT1dSaHRaSjc3MC94UzY5dUdYcHIyKzc0MllhK2F1bXFM?=
 =?utf-8?B?Uk1CbHFIb0lWYlRKZGE3emJFWHFUZW5QTHZ5Z3ZGVUtRb204eXVDSXpWSXFM?=
 =?utf-8?B?SnFWR1FZNWVsT0tBcXVVRmpxRmtDS0o5NXlWdGhRdVp1VWlJMGUrbTFiYXJP?=
 =?utf-8?B?MXBacE9zZVNnNkhYTGFYemU1dDlTeWNqOVljYUVVRnVLUytaWTNXeHE0cjlF?=
 =?utf-8?B?OFhuZkxqcThITmRrRFViNnBoa21EWWRidmZTZHZNQlkvcHMzV3RXRnB1b3FQ?=
 =?utf-8?B?N0d1Q3BUQ0EvTDRlSTZ4UlV0aktVejFWc0cxbERLcTdrNWkyL3VBN2o5dk5q?=
 =?utf-8?B?RnU2Sjc3R0xBQVcxWGJ2T0t3V0FaRzBQRUNWalllNW5IQkNLaTBGV0dQRHVo?=
 =?utf-8?B?alZoWXJVOCs4Y2xOK1AyQ2lIT3dhcWQvOUMwTWlSb21TNkpZMkVQalQwQnZC?=
 =?utf-8?B?WlhjWFhkUGhEWHpMWklFM2FsMGY2MW9iekZhRHRlVC9qLzY1SmZKT2I2VlA3?=
 =?utf-8?B?Um4zNWl2blpnU05udkJzSHNraGQxdTRFZ2srT29sS2pTSlViSldvam5RSy9X?=
 =?utf-8?B?Q0x2MHR5OUNXM3JCRDZTR1dYWWlRRDZ3K2tzRnVrcC9MVno0ajNsN1VKS3Aw?=
 =?utf-8?B?R0NWdUNJSUtyaThkNTFZeWgweUVWK0kxckFpUTlrVTh4UDFjaVRleHFHa0dF?=
 =?utf-8?B?ei93dUt0YWxvcnNFMVdObU0rTmFEbWVDcmZzSWFUbitDdHRySFZIM25QRGpu?=
 =?utf-8?B?Z2t2NFpZSXNWeGdFVEpHWkpuakJVYWZQTmdyK2ROc2J6eFF4cDJYOFBMdDhS?=
 =?utf-8?B?eVZXd2NLM3BlcWV4S1Y4aTJjeWEwaHJkUS95ajFhN0pvYjBXREV5RDA4ZUQr?=
 =?utf-8?B?a3NLM2ZDaHpwbkZyNnRVZ3pEeDFQV295NVBGelEzeStTSXNIeUZhMlBiMzAr?=
 =?utf-8?B?UVVFTHc3dXJuY3o5N0cwaDFYeFJuem9TclJtM1F0cFVObEI4SzNjMmlpYkJW?=
 =?utf-8?B?M05aMXFzL3BYUnVqQVREQVFYVXgzd2k3dFpCWXp0NWgyVDl3a2tmekUvT0p5?=
 =?utf-8?B?NWhwRWUrY0srQ2ZiVE03NVQ4RjhqdVBGQkdTQVNHWURLZ2NnYUgwcjg5S3F4?=
 =?utf-8?B?U2RGbGgzdG9EUG0vd0Rwd1pKMnl4T0ptWFlyNFFrb2x0V3Z1LzlsM29UdTV6?=
 =?utf-8?B?VTB3S3Q2TDVaNVlESUJCSlFwdHpnQTEwcWg0L3NtMG5hV1BHWVhqdHRWN1BJ?=
 =?utf-8?B?d3BIcW5ZSDRkazQzUVN2R2VBaGZ5bTVNS3lzcEFlbk1WT1NSVGJpY21jZjQ0?=
 =?utf-8?B?Q1docXRDNlFZYTFERzF5R0p1SEJEaU45R0pobGdxb0VpbGcrbTBwTU5pU0Rn?=
 =?utf-8?B?Vk9Pam5wUEN5U1B4TkVqeUFJQVc1THZDWDg3czBJM2dscVZybU9UKzRUenI2?=
 =?utf-8?B?eTFndkI2STJETWNyeC9qQXhqMC9FdVNSU0Flbllnd0hKQTUxcVZMWDc2TW1t?=
 =?utf-8?B?WXRncVZ3Nmo2THVLOTFlOWk5T0NTM0x3TGJFcDBIejlRS2ZtYjVNMDFBQStz?=
 =?utf-8?B?QklMVkV4OUZoVHZWNzlJM1VRSTZDd1pKMTY5YXNRbkc3TGxzYkxWT2VZMXRR?=
 =?utf-8?B?NGU4b28zOVQxa0JrK0NkQ2I2VXN6VVBpeVAwVUEvcnFXOTEzc0dibjRQSjhU?=
 =?utf-8?B?YXFGVkZjVHNuUCtrc05lUklha2l0SlJjVjNwZGNEZHI4VXVBTzBiSWlIVUky?=
 =?utf-8?B?bytlaEZpcVREaTZnNTNISmcvTlFmaHQwdjJoNmRwckFWODIxdmVPdDEvOTlz?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76148A99F6AA6740B23A530BF30FBEB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fc2003-34e6-4d12-a862-08ddbefbaa90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 15:17:06.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwCkE0iR5/B7l3Yo6h8rp9TbFvogb4ZasxrXOurfLF9rW6s0MTcpxe5pJ36rkLq9PtQ8mWCnUXpvrwRJqbaazSG/pa32G3Po8Ai6gq/4uek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7528
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA3LTA5IGF0IDA3OjI4IC0wNzAwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiBJIHRoaW5rIHdlIGNhbiBzaW1wbGlmeSB0aGUgcm9sZSBvZiBndWVzdF9tZW1mZCBpbiBs
aW5lIHdpdGggZGlzY3Vzc2lvbiBbMV06DQo+IDEpIGd1ZXN0X21lbWZkIGlzIGEgbWVtb3J5IHBy
b3ZpZGVyIGZvciB1c2Vyc3BhY2UsIEtWTSwgSU9NTVUuDQo+ICAgICAgICAgIC0gSXQgYWxsb3dz
IGZhbGxvY2F0ZSB0byBwb3B1bGF0ZS9kZWFsbG9jYXRlIG1lbW9yeQ0KPiAyKSBndWVzdF9tZW1m
ZCBzdXBwb3J0cyB0aGUgbm90aW9uIG9mIHByaXZhdGUvc2hhcmVkIGZhdWx0cy4NCj4gMykgZ3Vl
c3RfbWVtZmQgc3VwcG9ydHMgbWVtb3J5IGFjY2VzcyBjb250cm9sOg0KPiAgICAgICAgICAtIEl0
IGFsbG93cyBzaGFyZWQgZmF1bHRzIGZyb20gdXNlcnNwYWNlLCBLVk0sIElPTU1VDQo+ICAgICAg
ICAgIC0gSXQgYWxsb3dzIHByaXZhdGUgZmF1bHRzIGZyb20gS1ZNLCBJT01NVQ0KPiA0KSBndWVz
dF9tZW1mZCBzdXBwb3J0cyBjaGFuZ2luZyBhY2Nlc3MgY29udHJvbCBvbiBpdHMgcmFuZ2VzIGJl
dHdlZW4NCj4gc2hhcmVkL3ByaXZhdGUuDQo+ICAgICAgICAgIC0gSXQgbm90aWZpZXMgdGhlIHVz
ZXJzIHRvIGludmFsaWRhdGUgdGhlaXIgbWFwcGluZ3MgZm9yIHRoZQ0KPiByYW5nZXMgZ2V0dGlu
ZyBjb252ZXJ0ZWQvdHJ1bmNhdGVkLg0KDQpLVk0gbmVlZHMgdG8ga25vdyBpZiBhIEdGTiBpcyBw
cml2YXRlL3NoYXJlZC4gSSB0aGluayBpdCBpcyBhbHNvIGludGVuZGVkIHRvIG5vdw0KYmUgYSBy
ZXBvc2l0b3J5IGZvciB0aGlzIGluZm9ybWF0aW9uLCByaWdodD8gQmVzaWRlcyBpbnZhbGlkYXRp
b25zLCBpdCBuZWVkcyB0bw0KYmUgcXVlcnlhYmxlLg0KDQo+IA0KPiBSZXNwb25zaWJpbGl0aWVz
IHRoYXQgaWRlYWxseSBzaG91bGQgbm90IGJlIHRha2VuIHVwIGJ5IGd1ZXN0X21lbWZkOg0KPiAx
KSBndWVzdF9tZW1mZCBjYW4gbm90IGluaXRpYXRlIHByZS1mYXVsdGluZyBvbiBiZWhhbGYgb2Yg
aXQncyB1c2Vycy4NCj4gMikgZ3Vlc3RfbWVtZmQgc2hvdWxkIG5vdCBiZSBkaXJlY3RseSBjb21t
dW5pY2F0aW5nIHdpdGggdGhlDQo+IHVuZGVybHlpbmcgYXJjaGl0ZWN0dXJlIGxheWVycy4NCj4g
ICAgICAgICAgLSBBbGwgY29tbXVuaWNhdGlvbiBzaG91bGQgZ28gdmlhIEtWTS9JT01NVS4NCg0K
TWF5YmUgc3Ryb25nZXIsIHRoZXJlIHNob3VsZCBiZSBnZW5lcmljIGdtZW0gYmVoYXZpb3JzLiBO
b3QgYW55IHNwZWNpYWwNCmlmICh2bV90eXBlID09IHRkeCkgdHlwZSBsb2dpYy4gDQoNCj4gMykg
S1ZNIHNob3VsZCBpZGVhbGx5IGFzc29jaWF0ZSB0aGUgbGlmZXRpbWUgb2YgYmFja2luZw0KPiBw
YWdldGFibGVzL3Byb3RlY3Rpb24gdGFibGVzL1JNUCB0YWJsZXMgd2l0aCB0aGUgbGlmZXRpbWUg
b2YgdGhlDQo+IGJpbmRpbmcgb2YgbWVtc2xvdHMgd2l0aCBndWVzdF9tZW1mZC4NCj4gICAgICAg
ICAgLSBUb2RheSBLVk0gU05QIGxvZ2ljIHRpZXMgUk1QIHRhYmxlIGVudHJ5IGxpZmV0aW1lcyB3
aXRoIGhvdw0KPiBsb25nIHRoZSBmb2xpb3MgYXJlIG1hcHBlZCBpbiBndWVzdF9tZW1mZCwgd2hp
Y2ggSSB0aGluayBzaG91bGQgYmUNCj4gcmV2aXNpdGVkLg0KDQpJIGRvbid0IHVuZGVyc3RhbmQg
dGhlIHByb2JsZW0uIEtWTSBuZWVkcyB0byByZXNwb25kIHRvIHVzZXIgYWNjZXNzaWJsZQ0KaW52
YWxpZGF0aW9ucywgYnV0IGhvdyBsb25nIGl0IGtlZXBzIG90aGVyIHJlc291cmNlcyBhcm91bmQg
Y291bGQgYmUgdXNlZnVsIGZvcg0KdmFyaW91cyBvcHRpbWl6YXRpb25zLiBMaWtlIGRlZmVycmlu
ZyB3b3JrIHRvIGEgd29yayBxdWV1ZSBvciBzb21ldGhpbmcuDQoNCkkgdGhpbmsgaXQgd291bGQg
aGVscCB0byBqdXN0IHRhcmdldCB0aGUgYWNrZXJseSBzZXJpZXMgZ29hbHMuIFdlIHNob3VsZCBn
ZXQNCnRoYXQgY29kZSBpbnRvIHNoYXBlIGFuZCB0aGlzIGtpbmQgb2Ygc3R1ZmYgd2lsbCBmYWxs
IG91dCBvZiBpdC4NCg0KPiANCj4gU29tZSB2ZXJ5IGVhcmx5IHRob3VnaHRzIG9uIGhvdyBndWVz
dF9tZW1mZCBjb3VsZCBiZSBsYWlkIG91dCBmb3IgdGhlIGxvbmcgdGVybToNCj4gMSkgZ3Vlc3Rf
bWVtZmQgY29kZSBpZGVhbGx5IHNob3VsZCBiZSBidWlsdC1pbiB0byB0aGUga2VybmVsLg0KPiAy
KSBndWVzdF9tZW1mZCBpbnN0YW5jZXMgc2hvdWxkIHN0aWxsIGJlIGNyZWF0ZWQgdXNpbmcgS1ZN
IElPQ1RMcyB0aGF0DQo+IGNhcnJ5IHNwZWNpZmljIGNhcGFiaWxpdGllcy9yZXN0cmljdGlvbnMg
Zm9yIGl0cyB1c2VycyBiYXNlZCBvbiB0aGUNCj4gYmFja2luZyBWTS9hcmNoLg0KPiAzKSBBbnkg
b3V0Z29pbmcgY29tbXVuaWNhdGlvbiBmcm9tIGd1ZXN0X21lbWZkIHRvIGl0J3MgdXNlcnMgbGlr
ZQ0KPiB1c2Vyc3BhY2UvS1ZNL0lPTU1VIHNob3VsZCBiZSB2aWEgbm90aWZpZXJzIHRvIGludmFs
aWRhdGUgc2ltaWxhciB0bw0KPiBob3cgTU1VIG5vdGlmaWVycyB3b3JrLg0KPiA0KSBLVk0gYW5k
IElPTU1VIGNhbiBpbXBsZW1lbnQgaW50ZXJtZWRpYXRlIGxheWVycyB0byBoYW5kbGUNCj4gaW50
ZXJhY3Rpb24gd2l0aCBndWVzdF9tZW1mZC4NCj4gICAgICAtIGUuZy4gdGhlcmUgY291bGQgYmUg
YSBsYXllciB3aXRoaW4ga3ZtIHRoYXQgaGFuZGxlczoNCj4gICAgICAgICAgICAgIC0gY3JlYXRp
bmcgZ3Vlc3RfbWVtZmQgZmlsZXMgYW5kIGFzc29jaWF0aW5nIGENCj4ga3ZtX2dtZW1fY29udGV4
dCB3aXRoIHRob3NlIGZpbGVzLg0KPiAgICAgICAgICAgICAgLSBtZW1zbG90IGJpbmRpbmcNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAtIGt2bV9nbWVtX2NvbnRleHQgd2lsbCBiZSB1c2VkIHRv
IGJpbmQga3ZtDQo+IG1lbXNsb3RzIHdpdGggdGhlIGNvbnRleHQgcmFuZ2VzLg0KPiAgICAgICAg
ICAgICAgLSBpbnZhbGlkYXRlIG5vdGlmaWVyIGhhbmRsaW5nDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIC0ga3ZtX2dtZW1fY29udGV4dCB3aWxsIGJlIHVzZWQgdG8gaW50ZXJjZXB0DQo+IGd1
ZXN0X21lbWZkIGNhbGxiYWNrcyBhbmQNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICB0cmFu
c2xhdGUgdGhlbSB0byB0aGUgcmlnaHQgR1BBIHJhbmdlcy4NCj4gICAgICAgICAgICAgIC0gbGlu
a2luZw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAtIGt2bV9nbWVtX2NvbnRleHQgY2FuIGJl
IGxpbmtlZCB0byBkaWZmZXJlbnQNCj4gS1ZNIGluc3RhbmNlcy4NCg0KV2UgY2FuIHByb2JhYmx5
IGxvb2sgYXQgdGhlIGNvZGUgdG8gZGVjaWRlIHRoZXNlLg0KDQo+IA0KPiBUaGlzIGxpbmUgb2Yg
dGhpbmtpbmcgY2FuIGFsbG93IGNsZWFuZXIgc2VwYXJhdGlvbiBiZXR3ZWVuDQo+IGd1ZXN0X21l
bWZkL0tWTS9JT01NVSBbMl0uDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC9DQUd0cHJILStnUE44Sl9SYUVpdD1NX0VySFdUbUZIZUNpcEM2dmlUNlBIaEczRUxnNkFAbWFp
bC5nbWFpbC5jb20vI3QNCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMzFiZWVl
ZDMtYjFiZS00MzliLThhNWItZGI4YzA2ZGFkYzMwQGFtZC5jb20vDQo+IA0KPiANCj4gDQo+ID4g
DQo+ID4gWypdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9aT083ODJZR1JZMFlNdVB1QGdv
b2dsZS5jb20NCj4gPiANCj4gPiA+IFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvY292
ZXIuMTc0NzM2ODA5Mi5naXQuYWZyYW5qaUBnb29nbGUuY29tLw0KPiA+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcva3ZtL2NvdmVyLjE3NDk2NzI5NzguZ2l0LmFmcmFuamlAZ29vZ2xlLmNvbS8N
Cg0K

