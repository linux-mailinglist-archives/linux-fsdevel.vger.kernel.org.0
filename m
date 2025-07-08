Return-Path: <linux-fsdevel+bounces-54267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A35AFCE4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7733B1884C5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7872DECD4;
	Tue,  8 Jul 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWLmW9AN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70000288CB2;
	Tue,  8 Jul 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986392; cv=fail; b=r1OXARz8z1fISIrhoEp9k5hu3lRsh6BntDoAILFkXNp8oZE/BlmeRI2pqr2Nu41eMoS5ZpYy3GVGj4xOKuA2n0zjeWGFnuRW/1zfmvhDgJJviq9LuLMXu2F9pJCG46uyX5QtfDjwF+YZU+iOLX7tTCBIyTkjI3xClkwzRNMtjeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986392; c=relaxed/simple;
	bh=W+4sC2i/oo91NllG74F+cbRnafQqt/txC2PuocNpQog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a1oGv7jz9QWor1mHuniHo8LMAnACV/UMCkzSwuzIPEDfeUQ24tHBth7TWpFKxyWlwumF6uqj76LV/lLk2Y1hDeLhDa5tn3AttgezkHtjnKHeUNMxAjbf+MWwC9bpUZyavNXwNF2JnPTbnBVYml++2JyW76MGgSTn7phEJe2DwSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWLmW9AN; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751986390; x=1783522390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W+4sC2i/oo91NllG74F+cbRnafQqt/txC2PuocNpQog=;
  b=aWLmW9ANggR0QJxkYo74yHfjDe8lZc7jP9qk0ojVguHYIdb1cFflTASv
   oMjk4A+day7QVgiJLEgNfbGF//yY6ox8Kce2bheTVQfi5Vtk8Rm6bkOZH
   Qm74lQ31xr6vKIIGu0gWwvKm8kuIlem9YSJisdTG48GyNnYAQMqdUDZCQ
   HgYJIq3wEZ9zZQUF5+Uf5J6OSPqDlxGr7j6P2RehbV6EziW+2gqLzGxBs
   9MeK9k7DSe75ZfVl0b5+d3VjBQTcsA/VUqA++qpLXrCQFzZTjpF9WyNGx
   jY6xV89mqNvnfX5lpmkoZn6vP4h3E24aaepsuQmeIgpVanQY7fZLrowqS
   Q==;
X-CSE-ConnectionGUID: JUDu4HY6QYen1xrtkTVGiQ==
X-CSE-MsgGUID: partheFSSOe3G6mD5IDf4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53435274"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="53435274"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:52:37 -0700
X-CSE-ConnectionGUID: 4XJSFj+PRWmo3GnRNsF2OQ==
X-CSE-MsgGUID: dpVs8SrWQa6b/b1vRWyVbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="161155591"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:52:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:52:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 07:52:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1jsZ9Ba1LeF2kXd6+z7ApA4ku8tf8/eAq06MyZb7Gu+FUovwYC/332Z0KFAAMUsAPP0EncwoG+I0LYNxRc4ZyPOo4GVTOyZ0PbVZDGs48x2SXvvx+vv/LHXrVdf1QvaxfpbeyzaizRvqlcbflh24scHQTyVHmeGWHyUWQV11DAZRNDk8eUqLhhtz2vH3WoW5jJTZXNTgUrmXw7B4e5jpxiHMTyK/5w+ih4R+ZuZCKW3KLKI/iIY1Yrv/rIY7HxpjPtsXRuTYY9T4Y5IPbzhe2rIHBSTJsXS6IQ755N46xD+jOweo28pOrc3eeBSXjuNZMDSSU5M1tKeycupqj5Tiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+4sC2i/oo91NllG74F+cbRnafQqt/txC2PuocNpQog=;
 b=aqqKBd868FFpTG38p7OK5pi4G4Ayhp2+ThqeFCbMfKRP0eNeja31IkfW8So1LE8RChzcBO6nLCL0GHXMZCgcW4w3+j8i3WBFv5sahGUCkqiWphSIYmylbdKN7+EThesZzWZ8+IhYtha6sW62/1nFnwT1DKGhtVM3NUi629pSUVT8cKrTjenYet2I436NtVPjSsL55xCic80i0jyNDsefuio2nkK0iJyrWGYL7dOUDV3Rf1QCmTyAszHx8zcO3Hp0chbk5TBofmO9Z2u1+CmrPgYMz9aAnT5dNf5dN8rnzeCezREPcQ3661jDcnAl9ijJSjOiTQOqoMFqkqAxN6rYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 14:52:34 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 14:52:34 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "Shutemov, Kirill"
	<kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "amoorthy@google.com"
	<amoorthy@google.com>, "jack@suse.cz" <jack@suse.cz>,
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "keirf@google.com"
	<keirf@google.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "Annapurve, Vishal" <vannapurve@google.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, "Wang, Wei W"
	<wei.w.wang@intel.com>, "tabba@google.com" <tabba@google.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"willy@infradead.org" <willy@infradead.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>,
	"aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"fvdl@google.com" <fvdl@google.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"nsaenz@amazon.es" <nsaenz@amazon.es>, "anup@brainfault.org"
	<anup@brainfault.org>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "mic@digikod.net"
	<mic@digikod.net>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>,
	"steven.price@arm.com" <steven.price@arm.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hughd@google.com" <hughd@google.com>, "Li,
 Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com"
	<rientjes@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas,
 Erdem" <erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"Xu, Haibo1" <haibo1.xu@intel.com>, "Du, Fan" <fan.du@intel.com>,
	"maz@kernel.org" <maz@kernel.org>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "quic_pheragu@quicinc.com"
	<quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "Peng, Chao P"
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
	"hch@infradead.org" <hch@infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrQKWaYAgAAM4gCAEFZTAIAAkwSAgAC4SICAAP4mgIAA8aaAgAmqgQCAAA20gIAADwOAgADddQCAAAjqgA==
Date: Tue, 8 Jul 2025 14:52:33 +0000
Message-ID: <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
References: <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
	 <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
	 <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
	 <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com>
	 <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
	 <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com>
	 <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
	 <aGxXWvZCfhNaWISY@google.com>
	 <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
	 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
	 <aG0pNijVpl0czqXu@google.com>
In-Reply-To: <aG0pNijVpl0czqXu@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7468:EE_
x-ms-office365-filtering-correlation-id: 5a5843d6-c450-4fff-1776-08ddbe2f1287
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDVwWGlsSUJMeFFEWi9TaktWc1BoKzBMcTcrZkVkZWRXN3p0L1QwYmFvUFRB?=
 =?utf-8?B?VWsxS3NyNHpOeFZDS01VbWhhTTcwQis5TEE2cy90ek5DQlNPOGJic0x3UUts?=
 =?utf-8?B?aGpXQWhVcWkzUm1WN0dzQXdMdHczalVySi9ySjBZcWFITGZuckZSVW9mRVhz?=
 =?utf-8?B?ZmJUUWx1UDZpNnhnNENCUkhIWllneUJINTAvbGJLeUY3NkZvSUJXWFNDWXJv?=
 =?utf-8?B?NjBObTk3eUlYcFRpVzVWbW5QeUU4SEZkVGZpRkgzN0dVQWFtTWg0RE9qbjhv?=
 =?utf-8?B?SDNsVm55bWx2dzRpdUdLQm1zK3pDWkVmaWNGOTZ3QTlTTEZWRzY2QXVEbEhV?=
 =?utf-8?B?K0w4U1g1ZEhMcldBVys0R1h4bmlsSXRSbnNWWXFlWnVqaGtNSnIvdG9wdzJj?=
 =?utf-8?B?a1M0R2RLamZIc1dEVCtCLzF5WVdqNHlsZnNqbUdzTTEwdEJpWk15YzNZUzN3?=
 =?utf-8?B?ZXdxQlRQZ0tFdkh2Umh1L3V0eXpPYmJTT1ZCS3BYcFFqQnVQUEFSZ3BmU1lO?=
 =?utf-8?B?ZU1ESU1YZEhoN3dGUGJjcHB6TmI4elp2K2tJUkNoNlVnbGpaRjZVTnpvSGRl?=
 =?utf-8?B?Wi9FbVRoZUtqZWZCMm5EcUFKZW55dlNnWWpSbFhzc1VLZG9ONDJWQTE5K0Ux?=
 =?utf-8?B?MkY2QWtxTWZuRVNNdkM0QUYyQVFMZW9oYWV4ak9wL3VZM3p2dHZheGhndmRh?=
 =?utf-8?B?bStJcnU3eFNOS0QxbHpqcUtadUVSR3hJR2tqYVhTOXM4NzJ4NlRJSm5HU3VO?=
 =?utf-8?B?bVdXa215Vm5rS0N2UEpudGVPMGErMnlyb1F5WnlEckN2eFJSNm84bnM4dDNP?=
 =?utf-8?B?NXRObS9zQVVNb2VSQzR2RWo3UjE0OUlab0hMTWhhVmpzYnN4OWZvMVRFZzh4?=
 =?utf-8?B?OUtzV0NBUTJHVCsxZDQ3b2JFa3hBdXV1RS9hMEVJTmUveFNTbmFmbmZobWFX?=
 =?utf-8?B?Uzk2WlFTRUhWcmZnN2cxZUlqNnpyVFVCWHpaU2x5TWxVZi9EdW9KaVI3ZUJV?=
 =?utf-8?B?SWtHZGZyNVZLVVgrNFZjblNGRy9nbzZNR3p0UDRibzJmS3NablVkZHBSMStJ?=
 =?utf-8?B?cXlkeU9YU1BTSDJPN0J3TGNucnFSd3FTRVZsczE4T0x3cTI1cUJBS243VTZU?=
 =?utf-8?B?S3BPWDVwbitwOXlaVGtkd3p6aVozZWxGNksvNG8yeTlXVzh4YkVnZFlGVlVp?=
 =?utf-8?B?VDlEaTBKcGkvS3A3c3BYajhSTEhpN2NWWnIzQWVueSt0NHdkL204MlRYQ05R?=
 =?utf-8?B?VkJGV04zWlB3ejcxc0xYS3B2dUVmN2hjUUdQcm16ZS94ZHJUdW9Dcm1XbU90?=
 =?utf-8?B?VWVYWGlHSUVxY1pEbTRlVks4RFNtMHA0cHZUcUNIUE1MbUk2UnV3bjZrTU5B?=
 =?utf-8?B?RXlSeXFJNUpNU2s0Zk9SNm85VUJDeVdrbXJrcnhWZWo2OUhTTG5QUlRuaVNY?=
 =?utf-8?B?UHNHUUFXR0J3NEN6YlhHMnRjLzMxWkRPenBQOUhTcjV1OWxUV2dCMEp1eEdK?=
 =?utf-8?B?eFNnamxrT1o2dU14KzgxcjVZMlkwQlArL2VkTEMzbGRYNUJxWnIwZjFKbWUw?=
 =?utf-8?B?N0t2T3lVd1RRdlpiblVHYWdaK1VGMFR0eXlEd1NXdHgvc3Fmb09KTk1vSjhl?=
 =?utf-8?B?TjFwMStUdVFrUVlBRHpFTkY4SUZJRkdKMVlkTElhcGs3Vmc5RDhnN0lIczlp?=
 =?utf-8?B?dUhWWXhoUHE0NXZGSHN2Y1V0TFg5SFJDbFYydnQ2THJ5V01nWnd3NXg1empY?=
 =?utf-8?B?SzRKRUsvVFNyMnl6RnpSb2cwSmhMbTBIcklDN0l2U1NyRkRIUStibHN0R2FI?=
 =?utf-8?B?RFR2cDZlMmVpKzhTZGFyaHQySHV0SUhIeWVoVUNMSGk0S3RXSE9rMEY1Y0cz?=
 =?utf-8?B?UkRCWWRvODBqNDlRWXJ2ZkpmOU5IYnYzN01mb1ZmTUwzUEw2NFNrZEkvZVhr?=
 =?utf-8?B?QlcvNWswMEJRMTdZeEtLNW9vSDRwY1BOcHFUQzNwK0R5VVNGRDlIc09IRUNG?=
 =?utf-8?B?RFVlTFRjTWRnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2QxeXp2NWNiT05FUHRPUWxBb214aWxQb2hSU2F6VXNIV0g3d2xhei9aLzgx?=
 =?utf-8?B?ejFESDI4TGRhUHFwSVZtRGZsMXBEa254TURGd0liaG5YM3hsbDNEWW0zRlY2?=
 =?utf-8?B?ZnBvQ2FnNEZ6M1hYbnZ5L0pneURPS05Idng0VUJiSm5heW9DaTdOd2ppWmhS?=
 =?utf-8?B?RWYzM2VjNWZFS05EMXRLSXhHWUhRZW55Qi9jcTZDWGxRSEZjUDJlb0lJbHAr?=
 =?utf-8?B?T04wVGlMdU1wZWp5MUdtNXlSdFk3SWJjWXo2R3FWcThleS9WdlNOTVdhTzhj?=
 =?utf-8?B?TzBib3dCT0R3K09Yb2lZQWFEWDZpWjg3cDkyS0ZyYTJ0OUJIQTB1UjhNZVFu?=
 =?utf-8?B?UFg0dDI5dndFc1VjRXZVaW5IMnBRMjBpOEhEbHpiUmV5dkRnVndVaWcxT2l3?=
 =?utf-8?B?Y3NqNUFOS3B1SWFmaXpJN2NGMElYS2NiZGFkeGppK3MzTkVINHBLNHgvY1FV?=
 =?utf-8?B?Wll3dHRVR1dTeXRBL2Nodk5pcVR6YWVyVEo5VnRBeWZOWjYzOGhLZTFsdkxY?=
 =?utf-8?B?eFI4WmErY3V3Zkd3NzBMcjBaRzg2K1gxa3BwMzJsTTNmeDRUc3U4czNQYnhY?=
 =?utf-8?B?a2ROYlR3SnllaDkwTUd6MXhwbVRGb0p1NU03aStUcEx1RHZXRFZ0Z0VqZGph?=
 =?utf-8?B?ZisyVnVpMFB4Z00zY0h2aUZDMFRZSHBoSVJnVEdpY1NzeWJWc0lRVmZ3RmdI?=
 =?utf-8?B?ZGdaR1lNSGhNaEozUzBHZ3hBTUpZMEFUa2JIYm1DMjVITkZhQkJvQ3YrREV2?=
 =?utf-8?B?QjQxM1RYOUVIT2FkU1JkSm5DakUwZTgzRzlUd293b1FNNkVyZk9sZVNNV1hP?=
 =?utf-8?B?U2JnMFFDQWxZZTlvWXcrMmVCNWtCcGpQbmE2enVoeTc1WmhhdHlGTFRkQ3pu?=
 =?utf-8?B?NXQrRnNrUThHWEJrOExsNzdpMGVMTndUYW81ZkFxc1Zza0ZTaWF3ZGFNTFhT?=
 =?utf-8?B?TzQwNXdzUkxCZVRyTVYrV0VBUXNlTUZIYVBhOVRYUTlFK0FveTQyWmxPaUZB?=
 =?utf-8?B?MWgzamVQbSt4aGZTWGV4NEQ1Nms1Q2RPSDM4Si93SDBxOU5oK05zWXB0V3NT?=
 =?utf-8?B?cDVsVHY4VGNxNG5IYVJjS2M4M1V5amFiei9hWExDZzVDNjlINmNpaDRYSGJF?=
 =?utf-8?B?dndNOUxIcnBZVVNzYTFab1RPK005VWFWME5EWjZxWlowSlIreXlwYjVXT1VB?=
 =?utf-8?B?QXRxQ28yQ0ZoRUVBcHY2WUQ3WlJDL3NPdVhJd2YreVFoUGhFTGxiSjB0S29r?=
 =?utf-8?B?SlFWckR6T3kwYVJzR3J4UFRJK2VYOVp4aENrYjJ2K0IzdUhtSkhocDR6M0hn?=
 =?utf-8?B?OXlXUnkwWUNPWTVDTHNMSHh4YThLNVMrMEVGcXpmVDBOSEQ3NGExM0JuNkRj?=
 =?utf-8?B?RzJvSXc5SStOMHp4RUxYcWVkUFZpL01EdVhJSHhrZmlOTEZOL241dXRlSGtE?=
 =?utf-8?B?RGJhQzlXN242cjhnTU90aktIYlZPWHpIS3ZnY21Xem4zMk11dTVwNmVLZXlE?=
 =?utf-8?B?WkxIZWU5MUt3K0FuSTZDYUszVCt1Q1VIMzJ6aTFNYzEveDU1SUluMlF5L0ls?=
 =?utf-8?B?U21QcnZ5aGUzRndNWEJ6M0pZNHZlaDk0Y0dxeGJ2cS9yUWVFc051b2I4KzJC?=
 =?utf-8?B?bmEzNFkyU3htam5tOWwzd3dUS1pVWWpBcDNabDFoN0hjbDk5SjR1L2g1QWVR?=
 =?utf-8?B?a0VrdnBCYnJGZUd3M2ZTN1RNWFJDUEQ5Y1NPTEF2WjN2bXZ2R0Y2TEVUcHRU?=
 =?utf-8?B?QmdVbEYxYWNwRHcrakpsa0h6RGZlN1VOcml4YlBKV0l5cWF3SFU2M0t4RWM0?=
 =?utf-8?B?VHQ4QUQzdnFKVWtXVlJaRCtZQmYvQ3cyWCtiODZGV2N3Smd2YzdDSFljU3cw?=
 =?utf-8?B?bFk4MHlNek5aVTM2TmU4YUZOcmppdkhxQm96aDdYOWtoakxPSnZYNzhmdjUv?=
 =?utf-8?B?ZjJuUTIxL2lwNEJEUnA2R0lhalk0Zmc4aXh1Q2RQeHFpdTExWS95UWpsVCtQ?=
 =?utf-8?B?bThLc3pyYkhpWjdCZnVIMjMwaXV2YXRqNXJZTEJ1VWJWdmNJUy83aHUvTFJs?=
 =?utf-8?B?WkdQZlkvZlYyQUV0dTRLaVlvdlZWWWFLd2MwUkRVK2Y3eDcrY1dZMkdXejJF?=
 =?utf-8?B?OFV0VEJDemdSYWVsbWVaK0tmWVpKQ21ER1VSWWcyWHRyOWpsSGhFbm4zWlpM?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58E3182996A7BC4A9BDE0214ED296A6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5843d6-c450-4fff-1776-08ddbe2f1287
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 14:52:33.9532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ux1i9iRGUH8QdAGk81Ld0d1xfPWTt159MAh3O4O3veV7Jq/AhDCvdb+RHFK49h4yiJSnqSQkxiDp81T1dYl1YCPbkqL15M6i9ORMl7PwxD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA3LTA4IGF0IDA3OjIwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IEZvciBURFggaWYgd2UgZG9uJ3QgemVybyBvbiBjb252ZXJzaW9uIGZyb20gcHJp
dmF0ZS0+c2hhcmVkIHdlIHdpbGwgYmUNCj4gPiBkZXBlbmRlbnQNCj4gPiBvbiBiZWhhdmlvciBv
ZiB0aGUgQ1BVIHdoZW4gcmVhZGluZyBtZW1vcnkgd2l0aCBrZXlpZCAwLCB3aGljaCB3YXMNCj4g
PiBwcmV2aW91c2x5DQo+ID4gZW5jcnlwdGVkIGFuZCBoYXMgc29tZSBwcm90ZWN0aW9uIGJpdHMg
c2V0LiBJIGRvbid0ICp0aGluayogdGhlIGJlaGF2aW9yIGlzDQo+ID4gYXJjaGl0ZWN0dXJhbC4g
U28gaXQgbWlnaHQgYmUgcHJ1ZGVudCB0byBlaXRoZXIgbWFrZSBpdCBzbywgb3IgemVybyBpdCBp
bg0KPiA+IHRoZQ0KPiA+IGtlcm5lbCBpbiBvcmRlciB0byBub3QgbWFrZSBub24tYXJjaGl0ZWN0
dWFsIGJlaGF2aW9yIGludG8gdXNlcnNwYWNlIEFCSS4NCj4gDQo+IFlhLCBieSAidmVuZG9yIHNw
ZWNpZmljIiwgSSB3YXMgYWxzbyBsdW1waW5nIGluIGNhc2VzIHdoZXJlIHRoZSBrZXJuZWwgd291
bGQNCj4gbmVlZCB0byB6ZXJvIG1lbW9yeSBpbiBvcmRlciB0byBub3QgZW5kIHVwIHdpdGggZWZm
ZWN0aXZlbHkgdW5kZWZpbmVkDQo+IGJlaGF2aW9yLg0KDQpZZWEsIG1vcmUgb2YgYW4gYW5zd2Vy
IHRvIFZpc2hhbCdzIHF1ZXN0aW9uIGFib3V0IGlmIENDIFZNcyBuZWVkIHplcm9pbmcuIEFuZA0K
dGhlIGFuc3dlciBpcyBzb3J0IG9mIHllcywgZXZlbiB0aG91Z2ggVERYIGRvZXNuJ3QgcmVxdWly
ZSBpdC4gQnV0IHdlIGFjdHVhbGx5DQpkb24ndCB3YW50IHRvIHplcm8gbWVtb3J5IHdoZW4gcmVj
bGFpbWluZyBtZW1vcnkuIFNvIFREWCBLVk0gY29kZSBuZWVkcyB0byBrbm93DQp0aGF0IHRoZSBv
cGVyYXRpb24gaXMgYSB0by1zaGFyZWQgY29udmVyc2lvbiBhbmQgbm90IGFub3RoZXIgdHlwZSBv
ZiBwcml2YXRlDQp6YXAuIExpa2UgYSBjYWxsYmFjayBmcm9tIGdtZW0sIG9yIG1heWJlIG1vcmUg
c2ltcGx5IGEga2VybmVsIGludGVybmFsIGZsYWcgdG8NCnNldCBpbiBnbWVtIHN1Y2ggdGhhdCBp
dCBrbm93cyBpdCBzaG91bGQgemVybyBpdC4NCg0KPiANCj4gPiBVcCB0aGUgdGhyZWFkIFZpc2hh
bCBzYXlzIHdlIG5lZWQgdG8gc3VwcG9ydCBvcGVyYXRpb25zIHRoYXQgdXNlIGluLXBsYWNlDQo+
ID4gY29udmVyc2lvbiAob3ZlcmxvYWRlZCB0ZXJtIG5vdyBJIHRoaW5rLCBidHcpLiBXaHkgZXhh
Y3RseSBpcyBwS1ZNIHVzaW5nDQo+ID4gcHJpdmF0ZS9zaGFyZWQgY29udmVyc2lvbiBmb3IgdGhp
cyBwcml2YXRlIGRhdGEgcHJvdmlzaW9uaW5nPw0KPiANCj4gQmVjYXVzZSBpdCdzIGxpdGVyYWxs
eSBjb252ZXJ0aW5nIG1lbW9yeSBmcm9tIHNoYXJlZCB0byBwcml2YXRlP8KgIEFuZCBJSUNVLA0K
PiBpdCdzDQo+IG5vdCBhIG9uZS10aW1lIHByb3Zpc2lvbmluZywgZS5nLiBtZW1vcnkgY2FuIGdv
Og0KPiANCj4gwqAgc2hhcmVkID0+IGZpbGwgPT4gcHJpdmF0ZSA9PiBjb25zdW1lID0+IHNoYXJl
ZCA9PiBmaWxsID0+IHByaXZhdGUgPT4gY29uc3VtZQ0KPiANCj4gPiBJbnN0ZWFkIG9mIGEgc3Bl
Y2lhbCBwcm92aXNpb25pbmcgb3BlcmF0aW9uIGxpa2UgdGhlIG90aGVycz8gKFhpYW95YW8ncw0K
PiA+IHN1Z2dlc3Rpb24pDQo+IA0KPiBBcmUgeW91IHJlZmVycmluZyB0byB0aGlzIHN1Z2dlc3Rp
b24/DQoNClllYSwgaW4gZ2VuZXJhbCB0byBtYWtlIGl0IGEgc3BlY2lmaWMgb3BlcmF0aW9uIHBy
ZXNlcnZpbmcgb3BlcmF0aW9uLg0KDQo+IA0KPiDCoDogQW5kIG1heWJlIGEgbmV3IGZsYWcgZm9y
IEtWTV9HTUVNX0NPTlZFUlRfUFJJVkFURSBmb3IgdXNlciBzcGFjZSB0bw0KPiDCoDogZXhwbGlj
aXRseSByZXF1ZXN0IHRoYXQgdGhlIHBhZ2UgcmFuZ2UgaXMgY29udmVydGVkIHRvIHByaXZhdGUg
YW5kIHRoZQ0KPiDCoDogY29udGVudCBuZWVkcyB0byBiZSByZXRhaW5lZC4gU28gdGhhdCBURFgg
Y2FuIGlkZW50aWZ5IHdoaWNoIGNhc2UgbmVlZHMNCj4gwqA6IHRvIGNhbGwgaW4tcGxhY2UgVERI
LlBBR0UuQURELg0KPiANCj4gSWYgc28sIEkgYWdyZWUgd2l0aCB0aGF0IGlkZWEsIGUuZy4gYWRk
IGEgUFJFU0VSVkUgZmxhZyBvciB3aGF0ZXZlci7CoCBUaGF0IHdheQ0KPiB1c2Vyc3BhY2UgaGFz
IGV4cGxpY2l0IGNvbnRyb2wgb3ZlciB3aGF0IGhhcHBlbnMgdG8gdGhlIGRhdGEgZHVyaW5nDQo+
IGNvbnZlcnNpb24sDQo+IGFuZCBLVk0gY2FuIHJlamVjdCB1bnN1cHBvcnRlZCBjb252ZXJzaW9u
cywgZS5nLiBQUkVTRVJWRSBpcyBvbmx5IGFsbG93ZWQgZm9yDQo+IHNoYXJlZCA9PiBwcml2YXRl
IGFuZCBvbmx5IGZvciBzZWxlY3QgVk0gdHlwZXMuDQoNCk9rLCB3ZSBzaG91bGQgUE9DIGhvdyBp
dCB3b3JrcyB3aXRoIFREWC4NCg==

