Return-Path: <linux-fsdevel+bounces-74027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE88D295A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 01:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3BAA3015835
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4021231A21;
	Fri, 16 Jan 2026 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krY0Uoyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED327713;
	Fri, 16 Jan 2026 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521624; cv=fail; b=id5dcgCkFcdLuztLoQZDD60D3F8hiEcNtLI8mRS6nRbbR0QkpQQEYh/eISfnEC6I2eV7yM5H8PN6bTEtk61oY4ovWqvZGo0kyhvJoe8AhJq/F5AivLp4u9ZTWN0F0W94pRzBvEEbeJILM41v6xoRybBW9kCgu4MtvB5qmEqWe4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521624; c=relaxed/simple;
	bh=J+J5cLn0zrTc4uYNyvXGPjmpluFDBooU8r33HyFUhfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iy8AgTQn9vGd67bi+PJPU4vNs5hrXJD/wiV4VEKBvMy+JSHNqGUZWJ0FaSrrXL8HVLvGSileFkzxAsl5v9pBBG88KqebiWFgI1PP+jpdFMT4C4oCHShlbk05WW3Y8qq4rkXLd/3BTes12d/jTRSQUBWM2WabR7v2uahf2HYDP+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krY0Uoyi; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768521623; x=1800057623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J+J5cLn0zrTc4uYNyvXGPjmpluFDBooU8r33HyFUhfE=;
  b=krY0UoyiP0bpNq+nE4KJzWigObYpfGqNywbDDnoTWFKVF9vcM/W88jLL
   2q7wi1ZN1dj0A9kJoLNdEK8ZwBhSPv1YCwfDsGNc09J+5t2WOrwo/PKo5
   PIdKhlBZUEajfZbReeWLMfvpOzB9SHIinMO3HLfdS/DNsDwBgrncYfsjX
   aGyhMODh8XAKdcA5UE2cdHs/dZ2LQC8lSEcr0tZYifieGqSWiVh6yffEM
   dPUx9ydVU7Paqs3KvFNUJjRYmdIsv8fdsF7sXAdqHOBiW7A3i6FxJR0OC
   IESo8QUoOSDqPQ6U1IV+LsaiMfmeHkKhSns4gptrQSLdnEk1yOiYdgpSU
   Q==;
X-CSE-ConnectionGUID: TIfgkWELTtCdGEiNAYORuw==
X-CSE-MsgGUID: C3RLo0sXQMORDGTIDEFZcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80950284"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="80950284"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 16:00:22 -0800
X-CSE-ConnectionGUID: CjWqP0BGSGiU1sXXYx43+A==
X-CSE-MsgGUID: Up88fRUXTZusZ1aHFHrd3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204879906"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 16:00:17 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 16:00:16 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 16:00:16 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 16:00:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCJpM5VQkxwHDqi4NjoRRipIIG/GjidXi9OdVAW+QaZqQvB6M675lZtKBAR/zRNkL6/uRIcvV1n8B2si9V7KH5xTJJDZTPJMLQR+g7biHsV0ZoCV09otp8QJuJ50UGzjb7ZHXERcycEP3ObuJzuj4A3an/fgscRdifZBG0w2l4oTrdxFJwnjWIA7IegBF/HfWIYjPU3nqa+1vMVzLTf51rzT1lfN+joMl7QuYf0UNECJSB385w5G1zf2LbtIt4EChA1XBAIOCfXHi6xgJoNZs1OcJyxbDRbnByTRoI3Twcp6DC7CmPUIeXftPnTbSdUbm1ZCnB0eUZb6fnEA2wq9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+J5cLn0zrTc4uYNyvXGPjmpluFDBooU8r33HyFUhfE=;
 b=Nqxz3WQv6rRBzJyeBGZbQQsXMH2IluAenLAGjj8JwGEk86TpSTlneX6BYBNvSEJlbd5oDUtnKuStLom5mPYEQgndMaAh/Wce/LskmH+MRuDW55hpZWade81vwswOvXSgSo5elgI8/xRxgTF9t/f8Ngix3IFRJlADV9eBierZPlkdsS3WkDfaU7go1ulvbUZ33XPUf5BZSPmrNZnd2GOmu+hYVXQwK3qjEf6MwW+L/lr6l7wzkxlbQ6omFv4Lvz09w79qdg4g34b8/o1zgn7SPcMyY9Jlnt90z6pRm0TMVqM/wSL+Qr0BZiM7jK1IWF2L3IJ1TsYdf1fb9+ALDR2ThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by MN6PR11MB8103.namprd11.prod.outlook.com (2603:10b6:208:473::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 00:00:11 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::d099:e70d:142b:c07d]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::d099:e70d:142b:c07d%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 00:00:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, "kernel@xen0n.name"
	<kernel@xen0n.name>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
CC: "david@kernel.org" <david@kernel.org>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "jgross@suse.com"
	<jgross@suse.com>, "surenb@google.com" <surenb@google.com>,
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"maz@kernel.org" <maz@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "ast@kernel.org" <ast@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "Annapurve, Vishal"
	<vannapurve@google.com>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"pjw@kernel.org" <pjw@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"willy@infradead.org" <willy@infradead.org>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "wyihan@google.com" <wyihan@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "jmattson@google.com" <jmattson@google.com>,
	"luto@kernel.org" <luto@kernel.org>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "haoluo@google.com" <haoluo@google.com>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hpa@zytor.com"
	<hpa@zytor.com>, "song@kernel.org" <song@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk"
	<itazur@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"andrii@kernel.org" <andrii@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "derekmn@amazon.com"
	<derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "jackmanb@google.com" <jackmanb@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jannh@google.com"
	<jannh@google.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kas@kernel.org" <kas@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHchnGR8zlgd593vU675Y8ML/1Q0bVT6T2A
Date: Fri, 16 Jan 2026 00:00:03 +0000
Message-ID: <e619ded526a2f9a4cec4f74383cef31519624935.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
	 <20260114134510.1835-8-kalyazin@amazon.com>
In-Reply-To: <20260114134510.1835-8-kalyazin@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|MN6PR11MB8103:EE_
x-ms-office365-filtering-correlation-id: 5397450f-8296-4c54-2add-08de54923413
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MmR4VUh5ZW1CNG93a2VwKzJ1N2RjdHZ6K0g1VkNIMXJVQzlmTElGemgyL2FU?=
 =?utf-8?B?SWZyVEpFMHVEWVJEWmd3Nzl0Umw5QzdYd1UrYWNFNlhyWFcyVVZ3SU80SkV0?=
 =?utf-8?B?NWtPTlFEbHFSLzdpSTVKanpDQjZRVVYrVnAxd0xtdHVhNUY3VlhPaFhwU2Zv?=
 =?utf-8?B?RUdvbUk3ZDhEd2dFamNWZzVLMmhHVTFwbXRkZHp3RXh5cHFmWDI5Y252emZy?=
 =?utf-8?B?UUlha3hMbVlxVkNnc21POVB1REh6dVMwanNZZ3RDZGtaU2cvQzl2Y0htOFJp?=
 =?utf-8?B?RFpkSWdEZnd5S01tUmZqYWQrWnJaQ0dsSXVCMDhJMHQrTHpicmI0VFhEaFU5?=
 =?utf-8?B?UjdzcWo4VnZkUHEzdVdKK0ZtOXlubXdHRFhwSUJtVjFTTjBoKzBvTGhPRWlu?=
 =?utf-8?B?bzJZak9zaTFBYVNPbVdCSjd1OHdUR1lXN3Y0L2tvVFhodE5EYUc3RGlIZE5h?=
 =?utf-8?B?ZWxUWFdOWi9KR0JZbDNIcldndWtacyt3bUp1djd6MFBKTTNEUFNvYTkvalp4?=
 =?utf-8?B?Si9Jd2RROHEyZUl5STYraUxnOHZPZkduL0VLeXBscVNwN25GalBBVGR4dHNY?=
 =?utf-8?B?aWtScnpQY2xuRGFJZlh4TjV4SFNpRlhiUkxMMDIwUkZwRWU4R2xGNDdWdHRT?=
 =?utf-8?B?dGdndHNqd2c3V0drd0hVcWZwek9tMklHamJ2VGVqKzJ5aml5TXVGbllEK2t4?=
 =?utf-8?B?TU5Mbk90OTh5T3JwOTM3aHUwWnhnbTB5SEtjZE1PWVF2dTdRQW0rOEVmcU8v?=
 =?utf-8?B?NkdocGxrcTVRb0hZelF1cUxnK1hFci9DRFRFRnAwUHFUSGgrMmkvOVNyVEdi?=
 =?utf-8?B?MnB4SnRuYXFmWlM5Rng0dGJHR1dDTHNGdkd3QWFueC9YdWcxS2NWSUpCWXdC?=
 =?utf-8?B?eG4zYkcwc1pXYTRRNWU2bFRONjlZL3U4eUhYeUEvdEhCVHZMWXpDSDRCaVZT?=
 =?utf-8?B?T0hZeUkxd0V6RDZKaE5MQzExaUQ0aXdWbXpPdlI1UHNOME5NV1VGYjZlVnNQ?=
 =?utf-8?B?V0p3bEQ0UzR1SWlLWng3aHpFN0gxL2wyMTNucHhBN0dmenBROHJJQlpsME5K?=
 =?utf-8?B?Y2RleFFDeDBrT2p0aHBuNjN2TUtob1hoWEEvT1hwLzF0THNTdFRVOUtGYjBp?=
 =?utf-8?B?TjRnNlAxQSszS25rTVNrSWplQ1BpdHhpcVozZXFRUEk3RFVGUTdudGt0blJr?=
 =?utf-8?B?TStpM1ZqRUZCWGNvR1FENUJ5N0ZzNTVNbjUrd0k2aFR5UzBXdEZtMERabTJn?=
 =?utf-8?B?YWN0ZlY3ZTk3VWRTSUhHdmJyWENUS0NIRlZTdmwzUVV0L2lpZXloa2xUU2ly?=
 =?utf-8?B?dTV4UHJGNlJ2VTU3YlFDYnVIWEc0WlNpNjJNM09kdlNGNkEvRW9JZk1SZXlt?=
 =?utf-8?B?OUkvQUV4SUtYaG5qVVdMT04zRVZlWi9Qdk83R2lqbVptVjJxcjl5ZklZOVI2?=
 =?utf-8?B?RTZsa21aVmZCM0ZQakZNYXFYbk9HeW1GWkFkVVF3ZEVhMk9MRHB5OU5iQlY1?=
 =?utf-8?B?NG5mZHpuK0xELytnMnRlNzMwdkZ2QWtPZExEWmVxUlpRMXZJVnZvOXYxSUdF?=
 =?utf-8?B?TDZOMnF0ZUFiZVBnWFZJYnJVU3VKcUYvN3Z0SUtZcFpZOG1hdzZ4SVZRQWV4?=
 =?utf-8?B?NmwxNk0xVVNLTTc2OERwNGhTWXAxSnhRY0VFYU5iRG13cklnVUNjNDVpV1p3?=
 =?utf-8?B?M1RlbE9tM3pIYkI5K2k0VnZnY3JTUGdrYkFmVk96TWF0U1piTHd0a2lvdzlF?=
 =?utf-8?B?NWxXYTlxK3dWbitsNVRkNkUrUWZ2bDk4N1VDd25ENmFPWkhRN21nY1dnRjVD?=
 =?utf-8?B?UDZXaC9HZVY4a2JCY25RMVU5clY5M0puNG0xU3FRRGNGL2p2bEFoeFRUZ0h5?=
 =?utf-8?B?Zk42RS9pYWtIclU0ckNRSXU2bXQvZ1ViT2k0TFh1U2pvUzVOSmRjSEtVMnhL?=
 =?utf-8?B?cGkyMUp6ZTYzZWRVMGNHbThwY21xTWtHZGd4dW1WcFM3RHQ0TGQ5T0R5aXJj?=
 =?utf-8?B?WS93ZFh1UHV1ZTJ4ZnlBWXIxQ1YvdjdRSEJQaDVucEZsQ0ErS3EvR1hzcDly?=
 =?utf-8?B?R1cxTUdPaXdMNi80VVFMSkhxait2MWhtY3M2enptakJTMnU4dy92Vk8xcVM5?=
 =?utf-8?B?RzkyVXlzclBLR3o4ZjFwd0Fsckp5MWg1Y0gvbjJaeGsrV2w2blg4ZTRmRlhk?=
 =?utf-8?Q?kfY1eZ4BUX2eKEBv2YR6qGtnHum5RV8kvCJSl8NRlfMC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHpLcS9rbmNoTkdWQjdZOGcvM2dQQmhsaUhWbThVbmVUaWV5T2dhd015aEFT?=
 =?utf-8?B?aERJYndFWkh1TGRjS2ErTkdIVGZkamJHazloY3kzUW1PRzVLTWsza2I3VDhJ?=
 =?utf-8?B?ejFLNjBtWDF0VkVKbExLWUZsQlhocTYwU254a1RLRENzMDRXUEs3bm94Um9n?=
 =?utf-8?B?eWlhNVVOQ0R4anNhbzljVWtjL3d4Rm1CdEo3ekpLTW9kSDRVVk5FS2hjZW5K?=
 =?utf-8?B?ak1RcnBWOVFhOFFmcy9vRnMvL2xYdUtiaXc1ZEtmNmRzU2JaSWwyQnRZZTN4?=
 =?utf-8?B?bjhxRlZVNUI0aHlBQW03cWRuNVpRVm9jV05wTnV1cDViS2lDMTZJYjRKZGor?=
 =?utf-8?B?c2dHVktVc2d6V3hsY1IxbVIyZnBqVHpFbkVqNU1nS1BMblBDL1pGUlFaTkJK?=
 =?utf-8?B?cWV4Q1VjamJ1RFI4dk92VlRia3dsOVlObnJUdEJGVlFrU1paV294eThZVnJG?=
 =?utf-8?B?S1diMGxjcnNrTFFaVnpkN3JnVHFHS0xIditRM1hUK1o1Q0Jsa0hCYU1iemlm?=
 =?utf-8?B?SWN1NzRJNWpJR0YvTkpUd1dOWHVRVzJpOElqRXQya1N2SDFaeTl0azRxOVZX?=
 =?utf-8?B?REdKSHRxWGUvTTVjcTZVMnpkRFUrUHhraWJhOHBoVHBrclMvK0s4WSt4eUJQ?=
 =?utf-8?B?ZU0xZUNQb2NEN3dqVlRXbnBsVGh3Zk0wbVNZTjJlclE3RnFISTVEZ3VEbnJF?=
 =?utf-8?B?anMwNndZdy9SY2RYQXhVLy8zMmh2UmFaWGRJVkJ4SUxSUnJQcnhQRGpzUGVS?=
 =?utf-8?B?bEZ2Q0NYUG1RQXE2T2s5RG5BK0oySlQwS0NIbEF6ZWF1bGwrVkNCOVBQZWkx?=
 =?utf-8?B?RDkxeDFveXc4S3hHN092V2Z0azV5eGpsY2ttTEUyTnNQNm5RakJqWHZOYWR2?=
 =?utf-8?B?VHhLOGRFbE1QaWhaenB5Y2F5cjRxRDNBNEx4V3FkOHdrVzcyMjk0SXJJWER2?=
 =?utf-8?B?TW5wSDRqVGoxOU1EMGNFb1NKWG54NnpwOEhkbmErdG1GZ2RQNDJiWktSdzBB?=
 =?utf-8?B?eG9YaEZiNlkyOTBUNzRuRDVkNG5YcHB6Z2xYTWFPY3BNOWs2UjFIVERlWmpm?=
 =?utf-8?B?L0xQVWh1RmdiUmcrcWFIb2hnVkZMWEdUZVVJVThCaUMxa2R2SjhkT2VZeW1V?=
 =?utf-8?B?MVErU0xWSitZL29DeU4vd0hucE1ZZmRSWmFSOXRlNWdzTUZudy8rK2NUeE1i?=
 =?utf-8?B?RTlpU3AzQUtRYXZIcFFxcDFydUlTQlpFUXhEV2R5TDU1ZkliNDRoWFQ0VXZP?=
 =?utf-8?B?UXhNRXd1SFJ1U01nTXBMVU00WW1wOFkraGFaVlVkQnRvUmFZdVBLaFpmZnA5?=
 =?utf-8?B?QXNHalZIUXB5L1RCb0N4UDBMbU03QVRYVVNlQkFuSi9wVG5PTGZxZ1ovMVdQ?=
 =?utf-8?B?L3NJeGtzblZ5TXE2ZnRqTkcyeUFRaWd4YkluSDZOR281a2ZBRWg4cThWRnQ1?=
 =?utf-8?B?YmN4VXROb05mZTAvWGNIWTJKL3oxRUhjaWYzRHUreFhmRGJNRWRGREpnYWJl?=
 =?utf-8?B?amRSOVh4OFJKMjdXMTY3SS9ZYk4xajBPR2phTmRzRy90dGVxUkFBQWdhN3pX?=
 =?utf-8?B?MnJQbVo3U2dOL3BNTks5WWk4VW5oMm5Ia1NDS2RYT0hzZlFFMDU0YjcvSEdm?=
 =?utf-8?B?am5SQzlPd3lLOEpQb3NUVU1yOW0zYndqdWhyVFVYVzFSRTVCOXR2NzhKaUN2?=
 =?utf-8?B?bGpaay9tWXBEQit6ako5T1JtUGN3dS80d1VicmU2K2hLYTI3dGFSaWZPUlNi?=
 =?utf-8?B?OGtZT1RpWjZ5ai9HSS8xOE8rYnZpdlBnSXVvRmRZOE10YnVkL1pJL0NqWi9L?=
 =?utf-8?B?VFpHc1hPNFhFM0dkR1BORHlzcUNrU1lMUzZrV0NNRkZaak96ai9BTkUrTTly?=
 =?utf-8?B?TUpuMi9TS3pXZ2M3eE5GclB5M1grOGgrQTI3Kytteitkb2RuY3FFOXhkQys2?=
 =?utf-8?B?anh3YVlmWVlTWE5ObmU4eng0c0FTelplZmQzbDNWeXZBZ3pEakcycWYwVHFm?=
 =?utf-8?B?aVBHMzdkaHFUWGhMSi9GRG03VEowV3NYbDlraXlxRmVUdzJLYUtZdzhwN2VH?=
 =?utf-8?B?RTdlNGxGZzVLNkhuNzJXb2lJemFOeG9RM1kxNGtDTFhHUVE3NFVUVVVDdURV?=
 =?utf-8?B?TUhaQktPZ3UxNndkVCtmVVFBenJlN3h4USsrcjBzb2Qxd05WOW9oeUdoemNK?=
 =?utf-8?B?MjhGTXJGN3k2ek8vdCtKaVZHQ3BvaU1QZDVkb0hGRG8zTkNJbkpYZEdUdnlD?=
 =?utf-8?B?eUVwOC81SXdiZWFPaFhFdjFVNmxsTVNGYnpUbzlXK2x3RkNtenFKNTZ6SWlZ?=
 =?utf-8?B?dlhLSUN0THRkdGF2TzZkQmdWTkx1by9USEVUYVRaMVIzU1NybUpPSTlHeXFk?=
 =?utf-8?Q?ZCXQT9N7A8tyaDk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D778212393176E4889C84558D1CD40DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5397450f-8296-4c54-2add-08de54923413
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 00:00:04.8118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clx9b7O834azFuaZENO40EQPS9x569x9m5RnzkxwUPunnqEFME29c/yTLORmWKfVntg/8cEHmrAkwFgyyqE1nvtpoDmjXXmsK8FitxasfLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8103
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTAxLTE0IGF0IDEzOjQ2ICswMDAwLCBLYWx5YXppbiwgTmlraXRhIHdyb3Rl
Og0KPiArc3RhdGljIHZvaWQga3ZtX2dtZW1fZm9saW9fcmVzdG9yZV9kaXJlY3RfbWFwKHN0cnVj
dCBmb2xpbyAqZm9saW8pDQo+ICt7DQo+ICsJLyoNCj4gKwkgKiBEaXJlY3QgbWFwIHJlc3RvcmF0
aW9uIGNhbm5vdCBmYWlsLCBhcyB0aGUgb25seSBlcnJvciBjb25kaXRpb24NCj4gKwkgKiBmb3Ig
ZGlyZWN0IG1hcCBtYW5pcHVsYXRpb24gaXMgZmFpbHVyZSB0byBhbGxvY2F0ZSBwYWdlIHRhYmxl
cw0KPiArCSAqIHdoZW4gc3BsaXR0aW5nIGh1Z2UgcGFnZXMsIGJ1dCB0aGlzIHNwbGl0IHdvdWxk
IGhhdmUgYWxyZWFkeQ0KPiArCSAqIGhhcHBlbmVkIGluIGZvbGlvX3phcF9kaXJlY3RfbWFwKCkg
aW4ga3ZtX2dtZW1fZm9saW9femFwX2RpcmVjdF9tYXAoKS4NCj4gKwkgKiBUaHVzIGZvbGlvX3Jl
c3RvcmVfZGlyZWN0X21hcCgpIGhlcmUgb25seSB1cGRhdGVzIHByb3QgYml0cy4NCj4gKwkgKi8N
Cj4gKwlpZiAoa3ZtX2dtZW1fZm9saW9fbm9fZGlyZWN0X21hcChmb2xpbykpIHsNCj4gKwkJV0FS
Tl9PTl9PTkNFKGZvbGlvX3Jlc3RvcmVfZGlyZWN0X21hcChmb2xpbykpOw0KPiArCQlmb2xpby0+
cHJpdmF0ZSA9ICh2b2lkICopKCh1NjQpZm9saW8tPnByaXZhdGUgJiB+S1ZNX0dNRU1fRk9MSU9f
Tk9fRElSRUNUX01BUCk7DQo+ICsJfQ0KPiArfQ0KPiArDQoNCkRvZXMgdGhpcyBhc3N1bWUgdGhl
IGZvbGlvIHdvdWxkIG5vdCBoYXZlIGJlZW4gc3BsaXQgYWZ0ZXIgaXQgd2FzIHphcHBlZD8gQXMg
aW4sDQppZiBpdCB3YXMgemFwcGVkIGF0IDJNQiBncmFudWxhcml0eSAobm8gNEtCIGRpcmVjdCBt
YXAgc3BsaXQgcmVxdWlyZWQpIGJ1dCB0aGVuDQpyZXN0b3JlZCBhdCA0S0IgKHNwbGl0IHJlcXVp
cmVkKT8gT3IgaXQgZ2V0cyBtZXJnZWQgc29tZWhvdyBiZWZvcmUgdGhpcz8NCg==

