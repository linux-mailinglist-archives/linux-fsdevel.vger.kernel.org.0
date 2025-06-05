Return-Path: <linux-fsdevel+bounces-50772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116CAACF605
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F64189CD8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4E927A907;
	Thu,  5 Jun 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIqZM2Cg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67A1DFF8;
	Thu,  5 Jun 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146049; cv=fail; b=DCByyliQh30h5/RXRpomTxZPRsPaqnKtaOVb8kVw6j2psXkdPFjeo6V4gIh1PLecUwxvHmzNQXPw53jXi2psx7pELViWMVs3PccWVJHpfEVeu6TaBLkNPwQlWTF6EW3NiSJgie6b0CMjMJhXO5+e1JZWSj7EwjVg19RKEeeCM+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146049; c=relaxed/simple;
	bh=bjHsFFRifAGd13Cya/8eImaoAf+mXtArGrjOZtmBH/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LpNGm75+x8PWeQwgQh0DSAn8gew7Y2Lb16ZnFaG+6HGJC0zHUO48auDrtqQFlav9xhUV0iRDCTPhNwo4eGt/X9HXSj7M4g2DUKotj51dThU7zZBadeOnWsln6bHEKVcepCPiGHqcwMvYwf+fAGRDsJnyY+y/OoH3uqU0hWwKso8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIqZM2Cg; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749146048; x=1780682048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bjHsFFRifAGd13Cya/8eImaoAf+mXtArGrjOZtmBH/4=;
  b=HIqZM2Cg11DbjyZ1L2eGOOsmD6HGcRhItvbasCZDWYJoJ5VQOQMr+aH6
   CYf+y/xn3XA7KLPTswLN9K0gnp6mKY7OBCgNmGJcBQWAFUsjzEzPGjOWv
   tUdPbD6QFCpiLAfMORwh0DmC37p4pLcYHkTQ6HV9U1Z2QSuFSBn/HibUn
   nX+xWv5KmHWN2oPTW8hincHxCuAAqwTp3MpQNOE61ghbmu/9vua+N7kVk
   k+dFooD1iua/gcKBfj3pzNTr8pcwKdR7HBoWIGqCHh/Qisx/uKuIXqTQo
   rMnbY9Q6u8qzohUi1HumZa/8OjqaCe4joTag1sXabQI5tp8vjan+juOV2
   g==;
X-CSE-ConnectionGUID: 4Vz/lrfbQSq0XatWaNP2iQ==
X-CSE-MsgGUID: zmL00EidTh6X2bXtok9OIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51376857"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="51376857"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 10:54:06 -0700
X-CSE-ConnectionGUID: SK08Nr1ySV29YWi7SaeZ3g==
X-CSE-MsgGUID: WX2hArvST2S2teTy6CXi9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="146567344"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 10:54:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 10:54:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 10:54:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.58)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 5 Jun 2025 10:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANuOr/VZ1YUHqt0W7ircItCZW7Ae4bdyS6ETkYz/PEncYAEowpns/IrGPlvw9+ZVvrx0mqc2Lm9Nt0gcO1WcVKVlj01wdJXxs/t9v20OODpspgXNHqt+oDxH9dk1NwJclZRXq8O2dOrlvhvbswZs92RAGNOLubcPhjuhhWwrE1TLSsNN+4xkU8/TMtBrSBo51W2AXe2fWbnpfDpdd6HhwGQyXS2zKO9NjDQCIiQH1MN8VpXWGTj2VSj6faBOqvdNyXoP2bcxkUOfIAoisAhvI/X5GKDmonPy+d5UtOZKBAOE82zrt2cHLlzyq3g2jf4NkBPB8KqaP+bo9f5zIkWtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjHsFFRifAGd13Cya/8eImaoAf+mXtArGrjOZtmBH/4=;
 b=Fdq4lHLgLXa+8s+k6LFeHwO9gHusAuJSSJydKAJMQ8VFON6uL9BOAhY1QFG32wJeSARS6h14IirNMFiFaRLkjXxRIfpUrgnUs8oH16jUi7qRFInx2/C6dn3qZcajf0w4R98JSLiTyF+uSTmJPEwtDtkCcSMZXon8T7B+lAFQPdOK+tkNVC+21pGuU+RegJiC8YBgnpqaSrmLFfYhC9N9/mr+Ztewv3dR66PCRAfrfZS9CvrOD2mwaPcQApUnsPifxiJKwj5oezMGo8dGbl96tcAwArNJAjauOfw0TYyRaN0EsDYch3FDQm3963NShDrkIlKI1/SBUu/JExmlSxVzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7068.namprd11.prod.outlook.com (2603:10b6:806:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 5 Jun
 2025 17:53:47 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 17:53:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "ackerleytng@google.com" <ackerleytng@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "Shutemov, Kirill"
	<kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "nsaenz@amazon.es" <nsaenz@amazon.es>,
	"peterx@redhat.com" <peterx@redhat.com>, "keirf@google.com"
	<keirf@google.com>, "amoorthy@google.com" <amoorthy@google.com>,
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "jack@suse.cz"
	<jack@suse.cz>, "vkuznets@redhat.com" <vkuznets@redhat.com>, "maz@kernel.org"
	<maz@kernel.org>, "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
	"hughd@google.com" <hughd@google.com>, "Annapurve, Vishal"
	<vannapurve@google.com>, "Wang, Wei W" <wei.w.wang@intel.com>,
	"tabba@google.com" <tabba@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "willy@infradead.org"
	<willy@infradead.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com"
	<aik@amd.com>, "usama.arif@bytedance.com" <usama.arif@bytedance.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "fvdl@google.com" <fvdl@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "bfoster@redhat.com"
	<bfoster@redhat.com>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "Du, Fan" <fan.du@intel.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "anup@brainfault.org"
	<anup@brainfault.org>, "mic@digikod.net" <mic@digikod.net>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"rientjes@google.com" <rientjes@google.com>, "Aktas, Erdem"
	<erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"steven.price@arm.com" <steven.price@arm.com>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang,
 Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
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
	"pgonda@google.com" <pgonda@google.com>, "quic_pderrin@quicinc.com"
	<quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>
Subject: Re: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
Thread-Topic: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
Thread-Index: AQHbxSobNXexLibvg0WApmJDfnUF6bPfRPaAgBWrsYCAAAqUgA==
Date: Thu, 5 Jun 2025 17:53:46 +0000
Message-ID: <06f602073cc65e4d3f1e61a59f432a9616c78fa8.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
	 <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
	 <diqz7c1qjeie.fsf@ackerleytng-ctop.c.googlers.com>
In-Reply-To: <diqz7c1qjeie.fsf@ackerleytng-ctop.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7068:EE_
x-ms-office365-filtering-correlation-id: 49161240-ef19-499c-ca82-08dda459eb83
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RytDamRpMnZSYTdhWHkzODVhazhMclRWSFZQVERKTzRzL3JKVjNHdzVZdGJZ?=
 =?utf-8?B?dVVQMGNsQUlBU0d4UHdkd1E0ekR3NkRYbDR6Vkx0cmJxYlk0V1lVaitGT0dN?=
 =?utf-8?B?WXBEU2VqTDQweGxZVGVSdjBrZnU3d25sK2xmSWg5cHlMZGNwQytLY2orelhO?=
 =?utf-8?B?TmJrUWNVaGNvNGdUTFA4MWlsOUxYYld6ZXNUSUUvVklLaktUa1BKaEt1UHkx?=
 =?utf-8?B?b1FVY2tBdjR6ZGVXY2oyVk00eDNaRy8wOHVYU3JiT1pFZU5mNnM2bFdoeGtl?=
 =?utf-8?B?TFdoamdSTEU5OHZLai9LZzZ2TThPKzk5MnFXSGlqQ0pTbDdnTm11dEY4OFZJ?=
 =?utf-8?B?NnFoNXVjdXVBZFI3Nlhra3RZQ0dtQklvWjZIRGt3UTFyWlRtWjF5UDJnclg2?=
 =?utf-8?B?R0doYjl3U0x3NFZueHBuYW12SUh6UTRKb3pwWHlKMk5rb1pwRUprMUlRRWxo?=
 =?utf-8?B?U2tsc1FOaTJjVmRncXZta3ZWQ0hmeFRUU0l3YVkvRzlpZnVuQVpJTXMxUGJ0?=
 =?utf-8?B?d2RZeXVrSDhNNkg4OHhzV1RWczVBYWowQTJpR3Z0YWFlV0tHa1JUZlM0d1Jq?=
 =?utf-8?B?QTRWQ0Q1NDNHL1FOZWQ4WDJVamtVQ2Y2WS9JRGdPM0Y4Mi93VVdoZDF0QjV1?=
 =?utf-8?B?ZFl4azVQaUIwUlUrV2xPK3RoeGY3VnFWbHRFQ0QxQmVYcUwvaVdvdml2d2Yv?=
 =?utf-8?B?WHlHRkEvajlzNFlHUzlNSVlOOCsxUkFhV1JuaFFUalFpZFZZb3RXQkJhWnJz?=
 =?utf-8?B?U1hVaFJ0OUczZmJuOGZMclZLVE1QRm9xczNCMWJLTFhQN0FDV2JrZlJoNVJj?=
 =?utf-8?B?L2x4cGUzUHU5S08ya1RXdGlyazE5TTMzTUliUGRxTVFFc3dWcDdIejM5N1Fp?=
 =?utf-8?B?SXVNV2s0OVk2NlYyT1NkWExCc1NoMlFWWCtuRjgyOTN2MmwxN2g4aEJobVlO?=
 =?utf-8?B?akhVZFdqZjMycTZVQTN4eC9EaWlOMjJOSlZnT0JTclQyUU9Ga1NpaHVKdjl0?=
 =?utf-8?B?c0dhVlAwaVlseEFHODlNMzNUaGFhc0VwOVhSSkNEK3NqdEtodE9uU0pqUjFt?=
 =?utf-8?B?MHIvMHdheHZNOExQR2hxekpKNGFjNUt0YlZDUUJxV0RPU0pid1lpMDBNSFJU?=
 =?utf-8?B?cFlRdlJFOG9waWRWVE1GSjAzOHdQWVUvWVFqMERTNmpDMEhTd0poaUdLc3BQ?=
 =?utf-8?B?Ly9sdENuUnFSR2pBR3VpZW9sVzVzY1RYK1B5Q2xZUGV4OENyb1hDN3ZhNnV5?=
 =?utf-8?B?elNiYjRUVWxocGtGQmV5OVBGWnp2SU1GcUMzUmI0REhJVkprU1QvekVESTNG?=
 =?utf-8?B?Rmp6ZHhnUTVva01reTZpZm9UVXZhWlcxTWJER21nTTFxMURVc29Wa3RCU0dP?=
 =?utf-8?B?MjhyUTQ2em5pb2lzRkVkNGE4aitSdDM4bzBtQjk0VEtGbllmK2RDMmcvcVRF?=
 =?utf-8?B?cDgwMTFsa25QM25iTzhUWkpodWJLUGs4SU0yb3l1MFoyRC9NL3VWS3ZqTDk5?=
 =?utf-8?B?ZzYyK1N6OXBPcTNZREQrOWZVWWVKcHFMVng0dUsxOXZBR0ZKb1g2NHFjenlE?=
 =?utf-8?B?QzVDL0lpQUNTUmxUNEt6bXpVeWFsYTFGN1hud2Vla00vdWt1ZHcxTWRJeGd2?=
 =?utf-8?B?TzZGUjQ5SzRFdkRyLzdkMk9hOGNncFFKazRGOTBhbTRaM21SL1JSdkE1MjNP?=
 =?utf-8?B?TldhWHFndFZNMEZiVkJnV1M1N1QwZHVGUzZ5UjNJOGU5azlyc0VVbXV0RnlS?=
 =?utf-8?B?eFV3SExyYzMrQ2gvUlFGU1R1OWF5RlRMZ2JjMFVDSXB1OWlkN1ovOXl5Mk1p?=
 =?utf-8?B?RXVvd1NGZENiYTB4dFg5U3RTaVNuUVNMa1F2cDYzOUt5cEVsVCs4R2IvaWJT?=
 =?utf-8?B?WE1JRzk2Q2Jnblh4ODd0TGd1alJ2LzZqZHhLemU2aGc0bmZhcGttckV3QnRR?=
 =?utf-8?B?YTdES2YvWk9wVndRaTJDZk5YbjF2YmFEc0JCQWlXQm1QTFVnaEFnSVM1VG1k?=
 =?utf-8?B?d2tKZ2Y4TXBRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDlkZVZEQmRLNm40TGIwaThjTytLdlBZV2ZiUG1MOGh1dUY0R25hZk5uRWJ6?=
 =?utf-8?B?M2FaOTBOK1Q0TFBEc3ZnU3l2UFNsV2NFVGY4eEYwRVhRTG1DeGZuMGUrZVBR?=
 =?utf-8?B?VDBINGtJYVdETHU5NE1lSzdXS0Rlcnk0bjk0dDhkTGhFaXQrWWszQ2p6azFl?=
 =?utf-8?B?SG5DTnByRitRa2E4QUw4aUpNQWM0cmNOS0paMHRvbWpSSVlzVVVCQkVPazFh?=
 =?utf-8?B?b1FRVnBtRE9pbmM5cGI0T0hKQTVuWkxTcjZ2NTJtZ0Q4UnVFclFDRmM3NXBp?=
 =?utf-8?B?VE0zQ3lQZE1WOGU0VWlsbWZoc0UrYU0xa2tNL3RLMmxEVnRHYzlnbFNCSHVB?=
 =?utf-8?B?d2s5bUI1Ny9EY0ZiOFQzKzdSV2phV3ZjOForYWZHNU9TZjBVamF3QzVmWlpt?=
 =?utf-8?B?Wk5xeHJKNTFJNktrSElBQjlCdHZkZ0V3TVRyczdab2hsc2Q2VmdmTjVpSVZF?=
 =?utf-8?B?c3ZteUZZOWVoS214S3V0aHBZcStYaEJ5WDlCdExCem9YWDMzcFN2WjhMSGFh?=
 =?utf-8?B?SXU0Q0xRZGNXUU04VVNSclFFZVE5VHllSXJva3IxeWhLcVVLalNQaXQrYmVW?=
 =?utf-8?B?YjU1RTh6czYybGM2dHhVVFBQOWtsa0dRNDR0YWgrYXUyYlMwVFlHZ0VKZHo5?=
 =?utf-8?B?bVVwYWo5dkdjM2hJQWZWdGpwd1lwdnQ2YWdrTk95ZEV6TzlwTy9Melgwd0I2?=
 =?utf-8?B?dG5WR0txdGFqZlZudFl1aVZkWmoxSG9yNmY5UXBvdVJmWk1wTzJmQnIzYi9X?=
 =?utf-8?B?NStSb0M5cVAzNzJ4a3hDNWw5bTRHRWpzcUhtUjJQaUc1Q2dXZk5sK1NFczVs?=
 =?utf-8?B?dEoyaXB6WmtPWXR3L2pLUzRvV3VKOFM0Q29lYVJTNFJEbmQ4dy9Xa0p3Nkt5?=
 =?utf-8?B?NVd1R0hhZFFEMkxMN1V0TTBmWHBSVEY3d3NNYm1pNXBTc0VSNG9nYVRpVHhh?=
 =?utf-8?B?ZTQ4OXViZ1dWZnZ5VWUyWk9rSlR2WndKZGlWeFZyN28wTEFhRGtZc05JNG9n?=
 =?utf-8?B?aFRIZFlpb04yL1pqQ1pXU0JhVFY4WFEreVpwR3kzWEppQ2VDTEJkeStwYU1k?=
 =?utf-8?B?cGhYMEFrTnViVHFsN1E0cWU1NlN4dHlVOSswYzNGWUFkQm4yaG5NVWN4TFVX?=
 =?utf-8?B?VGJaRWhqeXNKQUZNckR3T3p1ck5CYlhCQlJ2SnNFN0JrYUJFQzNIKzRWaklh?=
 =?utf-8?B?MytqY21wc00yR1NnWHJvREs5bStGajZUMkI5M1RHMG95OWlwMXJiMVl5QXVS?=
 =?utf-8?B?Ry9uM21SRlRqUXl3T3NvRDUxSnBhSXd2aUxTbllkWFRPamlsZklkYzZIcWFx?=
 =?utf-8?B?cUx6Tnl4T0VsSGN2OEVOcEZvRC9OVWljTk92cHdkVC9ZMmVwbldUc1VpVTV2?=
 =?utf-8?B?cUl3YjV3Y20xTGhOdUhlWHBraCtTdWN0c2s5bzA0akd1T3NKeVVEUUxjM0NX?=
 =?utf-8?B?SUtha1RVNHg0bHc3OWdWZGpCTmtLWFNWays2MXU2SUJVcmxiY1BSR1BXTEFo?=
 =?utf-8?B?Ukk5ZS83VkhkeUFsbkR4TXpnOWJxVHMvMytFOW5Sd2tVNlJ2bHB5RlRqcHBX?=
 =?utf-8?B?dkNyTEZvSmliclQ2eklSdjAwaDJsT2RHWFlQUWxLMzVEanppQXR6V2pwaGht?=
 =?utf-8?B?VEJ4TDBLN0djUGtvZE5TbjVEb0U5UnRWUmpQVVUxVko4QzkxZ2pvU0JqU1lh?=
 =?utf-8?B?WVJRazBZMXVRL002WUo2c21Tc3doYytCM1FBQXNTalZ3RDJlbHhiM3E4NENN?=
 =?utf-8?B?bWR4WDhrL3dMNXVDeklWS3Vkd2hnN2J0Rm5DaDNMdWVyNjYrQnhaTTBveXpI?=
 =?utf-8?B?cngwQlJEandUUnNjaS8rOEppYWVYbmE3VVNTQzBtbmhydEF1R0NnSmJVbXRq?=
 =?utf-8?B?UU1DWHdERzNEa3hGUzlWWkZYTmJPc2VROHV3eEpTZ2MwNVpNVjdXcFpVeVAx?=
 =?utf-8?B?SlViZDBTTzZXOWpxMHllU3BrelRrdFdxVG1hVHJVUnkrYzFXajNHZDllT0tq?=
 =?utf-8?B?VzBxSjJhaUxQVkVCV0JLZlpiMzlSYjVHYVp2dXRRcUpiN2FLenhxTjUzUHZq?=
 =?utf-8?B?K0llRFJCc1pBN1ZsOFNhQlJ6UEtPMkhPcDlHeFdNS084MXNKT0tobjVhU3J3?=
 =?utf-8?B?QS9wdlIyV3BKZVR2SmY2YVIwSldrS01VVzlxWE9wRVRuRHBKMVBvbFdFZkxZ?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDD5825BBC49E34E812F8E85BB0E70A0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49161240-ef19-499c-ca82-08dda459eb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 17:53:46.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rb2dzmwCU6mz4iHasTZd4Bi6lEAFJlK6Gy0BbfWtGgVUP6Q/C98Me07T+Ec8jbf75z7e/dXLjr6c/jfKQkEh/gqhzi0vnZDxd+mweygs2Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7068
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA2LTA1IGF0IDEwOjE1IC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
ID4gPiA+ID4gPiA+ID4gRGlkIHlvdSBjb25zaWRlciBkZXNpZ25pbmcgc3RydWN0IGd1ZXN0bWVt
X2FsbG9jYXRvcl9vcGVyYXRpb25zDQo+ID4gPiA+ID4gPiA+ID4gc28gdGhhdCA+ID4gPiA+IGl0
ID4gPiBjb3VsZA0KPiA+ID4gPiA+ID4gPiA+IGVuY2Fwc3VsYXRlIHRoZSBzcGVjaWFsIGxvZ2lj
IGZvciBib3RoIHRoZSBleGlzdGluZyBhbmQgbmV3DQo+ID4gPiA+ID4gPiA+ID4gYWxsb2NhdG9y
cz8NCj4gPiA+ID4gDQo+ID4gPiA+IEkgZGlkLCB5ZXMuIEkgYmVsaWV2ZSBpdCBpcyBkZWZpbml0
ZWx5IHBvc3NpYmxlIHRvIG1ha2Ugc3RhbmRhcmQgNEsNCj4gPiA+ID4gcGFnZXMgYmVjb21lIGFu
b3RoZXIgYWxsb2NhdG9yIHRvby4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgd291bGQgbG92ZSB0byBj
bGVhbiB0aGlzIHVwLiBOb3Qgc3VyZSBpZiB0aGF0IHdpbGwgYmUgYSBuZXcgc2VyaWVzDQo+ID4g
PiA+IGFmdGVyIHRoaXMgb25lLCBvciBwYXJ0IG9mIHRoaXMgb25lIHRob3VnaC4NCg0KVXN1YWxs
eSBuZXcgd29yayBzaG91bGQgaGFuZGxlIHRoZSByZWZhY3RvciBmaXJzdCwgdGhlbiBidWlsZCBv
biB0b3Agb2YgaXQuIFRoZQ0KY29kZSB0b2RheSBib2x0cyBvbiBhIG5ldyB0aGluZyBpbiBhIGRp
cnR5IHdheSBsZWF2aW5nIGNsZWFudXAuDQoNClRvd2FyZHMgYWxzbyBleHBlZGllbnQgcmV2aWV3
YWJpbGl0eSwgYSBiZXR0ZXIgb3JkZXIgY291bGQgYmU6DQoxLiBBZGQgYWxsb2NhdG9yIGNhbGxi
YWNrcyBvbmUgYXQgYSB0aW1lIChvciBpbiB3aGF0ZXZlciBncmFudWxhcml0eSBpcw0KcG9zc2li
bGUpLCBtb3ZpbmcgNGsgYWxsb2NhdG9yIHRvIGNhbGxiYWNrcyBhdCB0aGUgc2FtZSB0aW1lLiBC
YXNpY2FsbHkgYSBjb2RlDQptb3ZlLiBEb24ndCBmYWN0b3Igb3V0IGNvbW1vbiBjb2RlIGJldHdl
ZW4gdGhlIHBsYW5uZWQgYWxsb2NhdG9ycy4gV2lsbCBiZSBkaXJ0DQpzaW1wbGUgdG8gcmV2aWV3
Lg0KMi4gSW50cm9kdWNlIGNoYW5nZXMgdG8gaHVnZWxiZnMsIGV4cGxhaW5pbmcgd2h5IGVhY2gg
d2lsbCBiZSB1c2VkIGJ5IGd1ZXN0bWVtZmQNCjMuIEFkZCBodWdldGxic2ZzLzFHQiBjdXN0b20g
YWxsb2NhdG9yIHRvIGd1ZXN0bWVtZmQgY29kZSwgYSBjYWxsYmFjayBhdCBhIHRpbWUuDQpIYXZl
IGFueSBuZWNlc3NhcnkgZmFjdG9yaW5nIG91dCBvZiA0ayBwYWdlIGFsbG9jYXRvciBiaXRzIG91
dCBvZiB0aGUgY2FsbGJhY2sNCmltcGxlbWVudGF0aW9uIGNvbWUgaW4gYSBzZXBhcmF0ZSBwcmVj
ZWRpbmcgcGF0Y2guIEV4cGxhaW4gdGhlIGNvbW1vbmFsaXR5Lg0KDQpXaGF0IGRvIHlvdSB0aGlu
az8NCg0KQWxzbywgZm9yICgyKSBkbyB5b3UgdGhpbmsgeW91IGNvdWxkIG1vdmUgc29tZSBvZiB0
aGVzZSBwdXJlIGNsZWFudXAgcGF0Y2hlcyBvdXQNCm9mIHRoZSBzZXJpZXMgdG8gZ28gdXAgYWhl
YWQgb2YgdGltZT8gQW5kIGZvciBhbnkgaHVnZXRsYiBjaGFuZ2VzIHRoYXQgMUdCDQpndWVzdG1l
bWZkIGRlcGVuZHMgb24sIGV4cGxhaW4gd2h5IGluIHRoZSBsb2c/IEknbSBub3QgY2xlYXIgd2hh
dCBpcyByZXF1aXJlZA0KYW5kIHdoYXQgaXMgb3Bwb3J0dW5pc3RpYyBjbGVhbnVwLg0KDQoNCj4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSWYgaXQNCj4gPiA+ID4gPiA+ID4gPiBkaWRuJ3Qgd29y
ayB3ZWxsLCBjb3VsZCB3ZSBleHBlY3QgdGhhdCBhIG5leHQgYWxsb2NhdG9yIHdvdWxkDQo+ID4g
PiA+ID4gPiA+ID4gYWN0dWFsbHkgPiA+ID4gPiBmaXQNCj4gPiA+ID4gPiA+ID4gPiBzdHJ1Y3Qg
Z3Vlc3RtZW1fYWxsb2NhdG9yX29wZXJhdGlvbnM/DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGlzIHdhcyBkZWZpbml0ZWx5IGRlc2lnbmVkIHRvIHN1cHBvcnQgYWxsb2Nh
dG9ycyBiZXlvbmQNCj4gPiA+ID4gZ3Vlc3RtZW1faHVnZXRsYiwgdGhvdWdoIEkgd29uJ3QgcHJv
bWlzZSB0aGF0IGl0IHdpbGwgYmUgYSBwZXJmZWN0IGZpdA0KPiA+ID4gPiBmb3IgZnV0dXJlIGFs
bG9jYXRvcnMuIFRoaXMgaXMgaW50ZXJuYWwgdG8gdGhlIGtlcm5lbCBhbmQgdGhpcyBpbnRlcmZh
Y2UNCj4gPiA+ID4gY2FuIGJlIHVwZGF0ZWQgZm9yIGZ1dHVyZSBhbGxvY2F0b3JzIHRob3VnaC4N
Cg0KTWFrZXMgc2Vuc2UuIFRoaXMgd2FzIHByb2Jpbmcgb24gd2hldGhlciB0aGUgaW50ZXJmYWNl
IGRpZG4ndCBmaXQgdGhlIDRrDQphbGxvY2F0b3IuIEl0IG1ha2VzIHNlbnNlIHRvIGhhdmUgdGhl
IGludGVyZmFjZSB0YXJnZXQgdGhlIGV4aXN0aW5nIDINCmFsbG9jYXRvcnMsIGFuZCBubyBmdXR1
cmUgaWRlYXMuDQo=

