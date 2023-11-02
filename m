Return-Path: <linux-fsdevel+bounces-1785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332727DEB1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 04:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02131F220B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 03:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A21849;
	Thu,  2 Nov 2023 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNq1er3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988D184F;
	Thu,  2 Nov 2023 03:01:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312CF83;
	Wed,  1 Nov 2023 20:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698894080; x=1730430080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yjgfxZxGlGyjnlm7Kte2VJ2IH3hJ5RzZ0v7xomO1+wA=;
  b=eNq1er3q4qUYTfLhSVYJpw9+q4T+QPVNDSNoctU0eyfZ8kxddqAxtae6
   0DmsLIthptXN6dPyMNP5mlXCDahwpyfUjeR1UK1Bh0IMSkFpqMi0G9q7a
   sMrHuKWa73OhpcMN5iwSvTnkh+OTcuX8wVyvtCsXbjAgi2hbwFWGco8mx
   u8ompypbaNLaUA98YggQys0Zz+1evabdeDamZjRPphKGD7zt9/wzeftqm
   3338FKOBSYvhaLGt70k6oas4CVcXVspfjA3ik+wgxpwRDbHiBA/THfWBp
   ROZN3PgGWw6ooqY5wl7kfK/DuFZbujoiWmjwrqEI/w+/05c69+3LB2jyw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="368835775"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="368835775"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 20:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="878085579"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="878085579"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 20:01:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:01:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 20:01:17 -0700
Received: from outbound.mail.protection.outlook.com (104.47.56.168) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 20:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp9nJuDGv56QaOzKjV2VLiJt9n9cIuJ6KYrTr/yfVRn61mA2PxquFAFDgcZtPyxsNUpybw+s4ZAIvuviIpw7YeTFudOvpsopZE3HkHm4zclQfFVwGo/lXu3VK1nbac2u5bQQkNgh3qZKUiQqlwnUf1mvvytphdUETBnK9p8yq7/mK9kGPAiWCc3HcDgtmgbM+Gn5a2Wzn8Eu1AspvYG38dlAwZbS9Zg2AMMNL+k/aNlj5b6Wu+yG3TaW0rfVxtJX9j4efEX6HysXdAvfZpsQ/hoeRXOL1xUyb9lJHM1tQy7ifMd5YQGCBGc8qk42B1JurWX7EQqORGr77dJDezBUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjgfxZxGlGyjnlm7Kte2VJ2IH3hJ5RzZ0v7xomO1+wA=;
 b=eQFXi5KV1jZ2JF/I5+kn1tSco6yZAro2fdRNnwZlcUkHURWL3HPw+Uiwxf2xlyPRgFgHSNfKdLVE5hOxtTMQ6tFrZ/gHqjWRlNK3MqSd/fU+OBaGEfIBoppKBrZd3I9XCPvV6wgt9UbXogWgVk9RYC98q1V2EnMstL7vtsVyvgPvRnau30d7RmbqGMqbfQ3KCiLLLAfDiMKm4xYzjB0GeyruhjWQFK02T3nOv2Ycwsv8jj7HfCtHjk/geLOne9wjUO92Icx52dQcNqzsWsAM1NkxwQOAwOon81v/Nj6N16++kIj5ElSmQMqFQ+1SApa+iq1SjJahfPI5T0S897TEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 03:01:11 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 03:01:11 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "Christopherson,, Sean"
	<seanjc@google.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"maz@kernel.org" <maz@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"willy@infradead.org" <willy@infradead.org>, "anup@brainfault.org"
	<anup@brainfault.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "mic@digikod.net" <mic@digikod.net>,
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "tabba@google.com" <tabba@google.com>,
	"amoorthy@google.com" <amoorthy@google.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "Annapurve,
 Vishal" <vannapurve@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
	"yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
	"qperret@google.com" <qperret@google.com>, "dmatlack@google.com"
	<dmatlack@google.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
Thread-Topic: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
Thread-Index: AQHaCQK3kNRHfZahgEebBaAjW/uRc7BmX58A
Date: Thu, 2 Nov 2023 03:01:11 +0000
Message-ID: <b486ed5036fab6d6d4e13a6c68abddcb9541d51b.camel@intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
	 <20231027182217.3615211-14-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-14-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB4907:EE_
x-ms-office365-filtering-correlation-id: 9d6e2812-2784-4846-44c6-08dbdb4ff857
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2yLIdUe07QpAVQgLXzFQm78dr/typ6KTR6ny73q5A2QdwrflqDbVDyzHaKgN9Rz6mPYygzKA+L35JBel37Xy5qjcZOLSXHE25Wc0l5mw3gEcD8BJF/WFaN16zWvrhdAOhkXBgLYc01cfIEbSOk7rctYc8v49s1G/80MmW3HQ/ZFjtqEhJN4yiQiGFcNZFWLstS+6thWi8TvmfRvuQwUasZf6JhZFjXZjHrYdNfNgOIEMPNecU75i2TXOlEI8j6f/w3/TRQE61hNwFWKs4I2ambRkytfEUSd/bk0I9L4PfwqVz+oSgRjoRnv26q4rqibcZMaDLcZvI9paSCLo69iLsnLCGWWC0+S81y6rVXM8lmFMmRwjc7bOvou1lv3Mpn5g3G0Tj9uG4WoFwlO4PBxNFdUGXHIEz1DxJxtssLf3mrMZqp3sZT26fC+ofX74GMLTCKeBAFhRVuCJSo8kMx2v8YNdnPFdQHfzD6pwj0XV8QT+EVlIoJfMlPTv6Xf58Z7SkUoWQ7XjQBeVeykZ6L/bp+QkkDs1yhY3XSHYY8O5gS+cjwFwZKrZ2+o/Ee3dWVaiJ2DG2hwj42E5cr7hf2+lMNy86JFA7vI0dg/fHAxYi9cFx6iER9LvVnDA28vH6AL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(966005)(83380400001)(2616005)(71200400001)(38100700002)(5660300002)(4001150100001)(8936002)(8676002)(316002)(2906002)(26005)(7406005)(41300700001)(7416002)(4326008)(6506007)(64756008)(76116006)(110136005)(478600001)(6512007)(66946007)(6486002)(66446008)(66476007)(91956017)(54906003)(66556008)(86362001)(36756003)(82960400001)(38070700009)(921008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFRDNGx5ekdWaGUreTBrSGRIY2xXV2JLdDVwYjU0cDJRS0R4WG01R1NURGtQ?=
 =?utf-8?B?UWVpRXpWTVlZTjU1ZDF2aktTcG9vSFdDNEFxU2hXMkN3M3phcStidHROOFJX?=
 =?utf-8?B?N3VBcUtKWjBoSnNOZ0lvWWlXdzhjWk8zVHU0Y3BYeDVydW4yVkV4c1RFeUFN?=
 =?utf-8?B?eTBTM0JTbEdESy9UWU4zbDRqQU1hUDFMRlNWSUR1bW9LZTVHN3hUekJjYVBP?=
 =?utf-8?B?ZWVOMXVObGlhTUZHd1NkY0MzeWg3ZXMveGxETzVqNlc1SFpHQm5UVHFubUtw?=
 =?utf-8?B?Q2JiMGx3T3BZVkRTZjhYOFh5aStOUytla3lScEJVNnJlZTFCTWtzd0RwL1B5?=
 =?utf-8?B?QUdiNHlkNDZpdmVXOVd2SFBYdVhRYXFLSnVxK0dpeE5Ua1RBOWhneFcwVStO?=
 =?utf-8?B?b2h6K3luWkFydERtR1ErVXBMTkxuaDVRVk51Q3BsYXVJbEs1NjBCelFiMzVB?=
 =?utf-8?B?M1ZpaFdVUmp2cVF4N1JaWkpBVDY0T041emg0U0J0RHllcDFDV2hiOVpCL3Zy?=
 =?utf-8?B?MTBvbVE0MC8rYUpNTE0zdHBkZUlNbHIwb2ZhQm9UbmduaE1MSlJuOUJscnBH?=
 =?utf-8?B?b0VFdmhQV1krcnVqSW9KNDFjeU1TN29IVys4SWpSNE95cUJxeG0zeE9JTTUr?=
 =?utf-8?B?TkFsdXh6OGhrYWVXQ0VXc21GaWY5WmR0cHJLdmI5bjA2VERlekRUai9OYm9z?=
 =?utf-8?B?dFB2TDkzbnErMyttYUVISFhxekNvdXRyd3hacVUxRTNNRXVXNXFkeXVpK2o1?=
 =?utf-8?B?UVR0djBHeU9veTNRMVB3Y0lLWXRqWWluNUpMN3RSZGV4alBRZnRob2JhSVRh?=
 =?utf-8?B?ZXIxcENaT0ZreEtGb0tLNVFNeUpGK0N4TmY5dmdDTmM0blZJWTA2dnZHQmFR?=
 =?utf-8?B?SEdycVZuZE04YzdxQ2w2VmYrTytyUittQ3V0Y25lRHpEQ1c3dzRBOXJMTWVy?=
 =?utf-8?B?R1IyUGowcjQzamYvU21jRGE4VkRMK2E4ck41djhlSUNIQmprbEVQUS9ub2tq?=
 =?utf-8?B?djB4Yk85bjM2MWw0cjRWajcwNEhWWlNUU0daM0pnL0hoSWFCbFZqZW1zM3Ba?=
 =?utf-8?B?ekdSdU1NTlU2ejU3ZDVGa3ZmRlpoSkNCd3hFeDVMYXFKUExNaFUxSnNabGtt?=
 =?utf-8?B?UlVsS1RlRVZHa2g2VVFkVnBIbFl2MUV4MWtvUzhHaWE3L3JNRGJkdjJscVFu?=
 =?utf-8?B?VTJNL1Q2L09pRXFWajg0R3FJZEQxUnBiREhGaHE3Wk82WjhydStBTVhsMDlw?=
 =?utf-8?B?ZVlMOTYxZTBCSGFNMnJRV2JISnB6MXdjYVJwbVhxYi9NN05LQW9vV01MR3o1?=
 =?utf-8?B?K3JMY0lldTBOMEo1ZlRZc3NrOHp2dGYyb0dUSVZXT2tVNkdyUlIyalNXZjdQ?=
 =?utf-8?B?aWlnRmRTNkpXZGZnMk5YVExUVE9IOUYyVHdDclVxeVQxUFFNSitmVGFUTjRJ?=
 =?utf-8?B?TnY5LzNsNGFybFcvL0pVQ2tpaHJNazBpdHN0OXEyZGRiVlhlVXlXcmRtbkwx?=
 =?utf-8?B?Q2pPcHpIVDdRSjNSL1FyWE1KOUNZaWM3Q3lWU0gzeTlWYmtxQ1ZJOHRUdVly?=
 =?utf-8?B?NHpGN3JBUWlad1dadFZHQmhoNnlrU1hMVmNVOWtQN0VRdjZVQnlrb1VDdnhh?=
 =?utf-8?B?UkluS1FDOTZCd1JlTzBjNnV2LzRpMUJkZ3gzZW04c05HUkVGbFdIdmVmNkh4?=
 =?utf-8?B?UlVtUWdpYno1ZTNqRnNTNzNucCtjdXovak81dnovZXdOMUdNK3Y5NmpTWXNZ?=
 =?utf-8?B?TmpoYVZKdzhPQUdrSzlQdVNPajZEeTEyYzlWQUYyWHNmSEQyZ0dMQnlkZjBW?=
 =?utf-8?B?VlVyd2F0WEdIUXc3MG1NRHZNeC9LMG1NOXgyUnA2R2k3OGZCTENYNTU4amhz?=
 =?utf-8?B?THl0RUdVaUcxK2prZXFqNXJvZW1JYUFYQ3Y5TFZPWUhzYWVMek9OSFdBb2Zl?=
 =?utf-8?B?RkkzRzg3aktzSTc5V05FTkRYSnhGc2QzS2FiVmhZMnowSzRuMDRHV1BmQ01p?=
 =?utf-8?B?SEw5dzg5QzlyRkR6K1JyTGpoT1AySGhuRWhrZGFhZC9NUWJvUHRlMTMvTW41?=
 =?utf-8?B?T3Vjc0VoK01ZOUQ4ankrOXNtRGtKbkF2VXBrTU5iaTNnOGVzWm14LzQ3bTVv?=
 =?utf-8?B?VDRpZnIxSW9aOThPMEZMZWRZOU0zSDBLbDFYdUJXU0FZRUpleDRRajR1ZkFn?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DF99410E33A0243B3E23A55A52063A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6e2812-2784-4846-44c6-08dbdb4ff857
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 03:01:11.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQgmYxhDKf7sqVqbzq7zN++ZipnpGYHU98l9OBtJ+VrHTm/XJi29ygUYQtlqK0cYRZJ++nbgqZwaWEpm47JI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDExOjIxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBGcm9tOiBDaGFvIFBlbmcgPGNoYW8ucC5wZW5nQGxpbnV4LmludGVsLmNvbT4NCj4g
DQo+IEluIGNvbmZpZGVudGlhbCBjb21wdXRpbmcgdXNhZ2VzLCB3aGV0aGVyIGEgcGFnZSBpcyBw
cml2YXRlIG9yIHNoYXJlZCBpcw0KPiBuZWNlc3NhcnkgaW5mb3JtYXRpb24gZm9yIEtWTSB0byBw
ZXJmb3JtIG9wZXJhdGlvbnMgbGlrZSBwYWdlIGZhdWx0DQo+IGhhbmRsaW5nLCBwYWdlIHphcHBp
bmcgZXRjLiBUaGVyZSBhcmUgb3RoZXIgcG90ZW50aWFsIHVzZSBjYXNlcyBmb3INCj4gcGVyLXBh
Z2UgbWVtb3J5IGF0dHJpYnV0ZXMsIGUuZy4gdG8gbWFrZSBtZW1vcnkgcmVhZC1vbmx5IChvciBu
by1leGVjLA0KPiBvciBleGVjLW9ubHksIGV0Yy4pIHdpdGhvdXQgaGF2aW5nIHRvIG1vZGlmeSBt
ZW1zbG90cy4NCj4gDQo+IEludHJvZHVjZSB0d28gaW9jdGxzIChhZHZlcnRpc2VkIGJ5IEtWTV9D
QVBfTUVNT1JZX0FUVFJJQlVURVMpIHRvIGFsbG93DQo+IHVzZXJzcGFjZSB0byBvcGVyYXRlIG9u
IHRoZSBwZXItcGFnZSBtZW1vcnkgYXR0cmlidXRlcy4NCj4gICAtIEtWTV9TRVRfTUVNT1JZX0FU
VFJJQlVURVMgdG8gc2V0IHRoZSBwZXItcGFnZSBtZW1vcnkgYXR0cmlidXRlcyB0bw0KPiAgICAg
YSBndWVzdCBtZW1vcnkgcmFuZ2UuDQo+ICAgLSBLVk1fR0VUX1NVUFBPUlRFRF9NRU1PUllfQVRU
UklCVVRFUyB0byByZXR1cm4gdGhlIEtWTSBzdXBwb3J0ZWQNCj4gICAgIG1lbW9yeSBhdHRyaWJ1
dGVzLg0KPiANCj4gVXNlIGFuIHhhcnJheSB0byBzdG9yZSB0aGUgcGVyLXBhZ2UgYXR0cmlidXRl
cyBpbnRlcm5hbGx5LCB3aXRoIGEgbmFpdmUsDQo+IG5vdCBmdWxseSBvcHRpbWl6ZWQgaW1wbGVt
ZW50YXRpb24sIGkuZS4gcHJpb3JpdGl6ZSBjb3JyZWN0bmVzcyBvdmVyDQo+IHBlcmZvcm1hbmNl
IGZvciB0aGUgaW5pdGlhbCBpbXBsZW1lbnRhdGlvbi4NCj4gDQo+IFVzZSBiaXQgMyBmb3IgdGhl
IFBSSVZBVEUgYXR0cmlidXRlIHNvIHRoYXQgS1ZNIGNhbiB1c2UgYml0cyAwLTIgZm9yIFJXWA0K
PiBhdHRyaWJ1dGVzL3Byb3RlY3Rpb25zIGluIHRoZSBmdXR1cmUsIGUuZy4gdG8gZ2l2ZSB1c2Vy
c3BhY2UgZmluZS1ncmFpbmVkDQo+IGNvbnRyb2wgb3ZlciByZWFkLCB3cml0ZSwgYW5kIGV4ZWN1
dGUgcHJvdGVjdGlvbnMgZm9yIGd1ZXN0IG1lbW9yeS4NCj4gDQo+IFByb3ZpZGUgYXJjaCBob29r
cyBmb3IgaGFuZGxpbmcgYXR0cmlidXRlIGNoYW5nZXMgYmVmb3JlIGFuZCBhZnRlciBjb21tb24N
Cj4gY29kZSBzZXRzIHRoZSBuZXcgYXR0cmlidXRlcywgZS5nLiB4ODYgd2lsbCB1c2UgdGhlICJw
cmUiIGhvb2sgdG8gemFwIGFsbA0KPiByZWxldmFudCBtYXBwaW5ncywgYW5kIHRoZSAicG9zdCIg
aG9vayB0byB0cmFjayB3aGV0aGVyIG9yIG5vdCBodWdlcGFnZXMNCj4gY2FuIGJlIHVzZWQgdG8g
bWFwIHRoZSByYW5nZS4NCj4gDQo+IFRvIHNpbXBsaWZ5IHRoZSBpbXBsZW1lbnRhdGlvbiB3cmFw
IHRoZSBlbnRpcmUgc2VxdWVuY2Ugd2l0aA0KPiBrdm1fbW11X2ludmFsaWRhdGVfe2JlZ2luLGVu
ZH0oKSBldmVuIHRob3VnaCB0aGUgb3BlcmF0aW9uIGlzbid0IHN0cmljdGx5DQo+IGd1YXJhbnRl
ZWQgdG8gYmUgYW4gaW52YWxpZGF0aW9uLiAgRm9yIHRoZSBpbml0aWFsIHVzZSBjYXNlLCB4ODYg
KndpbGwqDQo+IGFsd2F5cyBpbnZhbGlkYXRlIG1lbW9yeSwgYW5kIHByZXZlbnRpbmcgYXJjaCBj
b2RlIGZyb20gY3JlYXRpbmcgbmV3DQo+IG1hcHBpbmdzIHdoaWxlIHRoZSBhdHRyaWJ1dGVzIGFy
ZSBpbiBmbHV4IG1ha2VzIGl0IG11Y2ggZWFzaWVyIHRvIHJlYXNvbg0KPiBhYm91dCB0aGUgY29y
cmVjdG5lc3Mgb2YgY29uc3VtaW5nIGF0dHJpYnV0ZXMuDQo+IA0KPiBJdCdzIHBvc3NpYmxlIHRo
YXQgZnV0dXJlIHVzYWdlcyBtYXkgbm90IHJlcXVpcmUgYW4gaW52YWxpZGF0aW9uLCBlLmcuDQo+
IGlmIEtWTSBlbmRzIHVwIHN1cHBvcnRpbmcgUldYIHByb3RlY3Rpb25zIGFuZCB1c2Vyc3BhY2Ug
Z3JhbnRzIF9tb3JlXw0KPiBwcm90ZWN0aW9ucywgYnV0IGFnYWluIG9wdCBmb3Igc2ltcGxpY2l0
eSBhbmQgcHVudCBvcHRpbWl6YXRpb25zIHRvDQo+IGlmL3doZW4gdGhleSBhcmUgbmVlZGVkLg0K
PiANCj4gU3VnZ2VzdGVkLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNv
bT4NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1kyV0I0OGtEMEo0Vkd5blhA
Z29vZ2xlLmNvbQ0KPiBDYzogRnVhZCBUYWJiYSA8dGFiYmFAZ29vZ2xlLmNvbT4NCj4gQ2M6IFh1
IFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+DQo+IENjOiBNaWNrYcOrbCBTYWxhw7xuIDxtaWNA
ZGlnaWtvZC5uZXQ+DQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gUGVuZyA8Y2hhby5wLnBlbmdAbGlu
dXguaW50ZWwuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNl
YW5qY0Bnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxz
ZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQoNClsuLi5dDQoNCj4gK05vdGUsIHRoZXJlIGlzIG5vICJn
ZXQiIEFQSS4gIFVzZXJzcGFjZSBpcyByZXNwb25zaWJsZSBmb3IgZXhwbGljaXRseSB0cmFja2lu
Zw0KPiArdGhlIHN0YXRlIG9mIGEgZ2ZuL3BhZ2UgYXMgbmVlZGVkLg0KPiArDQo+IA0KDQpbLi4u
XQ0KDQo+ICANCj4gKyNpZmRlZiBDT05GSUdfS1ZNX0dFTkVSSUNfTUVNT1JZX0FUVFJJQlVURVMN
Cj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBrdm1fZ2V0X21lbW9yeV9hdHRyaWJ1dGVz
KHN0cnVjdCBrdm0gKmt2bSwgZ2ZuX3QgZ2ZuKQ0KPiArew0KPiArCXJldHVybiB4YV90b192YWx1
ZSh4YV9sb2FkKCZrdm0tPm1lbV9hdHRyX2FycmF5LCBnZm4pKTsNCj4gK30NCg0KT25seSBjYWxs
IHhhX3RvX3ZhbHVlKCkgd2hlbiB4YV9sb2FkKCkgcmV0dXJucyAhTlVMTD8NCg0KPiArDQo+ICti
b29sIGt2bV9yYW5nZV9oYXNfbWVtb3J5X2F0dHJpYnV0ZXMoc3RydWN0IGt2bSAqa3ZtLCBnZm5f
dCBzdGFydCwgZ2ZuX3QgZW5kLA0KPiArCQkJCSAgICAgdW5zaWduZWQgbG9uZyBhdHRycyk7DQoN
ClNlZW1zIGl0J3Mgbm90IGltbWVkaWF0ZWx5IGNsZWFyIHdoeSB0aGlzIGZ1bmN0aW9uIGlzIG5l
ZWRlZCBpbiB0aGlzIHBhdGNoLA0KZXNwZWNpYWxseSB3aGVuIHlvdSBzYWlkIHRoZXJlIGlzIG5v
ICJnZXQiIEFQSSBhYm92ZS4gIEFkZCBzb21lIG1hdGVyaWFsIHRvDQpjaGFuZ2Vsb2c/DQogDQoN
Cj4gK2Jvb2wga3ZtX2FyY2hfcHJlX3NldF9tZW1vcnlfYXR0cmlidXRlcyhzdHJ1Y3Qga3ZtICpr
dm0sDQo+ICsJCQkJCXN0cnVjdCBrdm1fZ2ZuX3JhbmdlICpyYW5nZSk7DQo+ICtib29sIGt2bV9h
cmNoX3Bvc3Rfc2V0X21lbW9yeV9hdHRyaWJ1dGVzKHN0cnVjdCBrdm0gKmt2bSwNCj4gKwkJCQkJ
IHN0cnVjdCBrdm1fZ2ZuX3JhbmdlICpyYW5nZSk7DQoNCkxvb2tzIGlmIHRoaXMgS2NvbmZpZyBp
cyBvbiwgdGhlIGFib3ZlIHR3byBhcmNoIGhvb2tzIHdvbid0IGhhdmUgaW1wbGVtZW50YXRpb24u
DQoNCklzIGl0IGJldHRlciB0byBoYXZlIHR3byBfX3dlYWsgZW1wdHkgdmVyc2lvbnMgaGVyZSBp
biB0aGlzIHBhdGNoPw0KDQpBbnl3YXksIGZyb20gdGhlIGNoYW5nZWxvZyBpdCBzZWVtcyBpdCdz
IG5vdCBtYW5kYXRvcnkgZm9yIHNvbWUgQVJDSCB0byBwcm92aWRlDQp0aGUgYWJvdmUgdHdvIGlm
IG9uZSB3YW50cyB0byB0dXJuIHRoaXMgb24sIGkuZS4sIHRoZSB0d28gaG9va3MgY2FuIGJlIGVt
cHR5IGFuZA0KdGhlIEFSQ0ggY2FuIGp1c3QgdXNlIHRoZSBfX3dlYWsgdmVyc2lvbi4NCg0K

