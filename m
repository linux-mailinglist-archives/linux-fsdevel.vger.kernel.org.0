Return-Path: <linux-fsdevel+bounces-49172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E8AB8E6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EEE160EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC7225A627;
	Thu, 15 May 2025 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmJy/ZGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190C1EA7F9;
	Thu, 15 May 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332234; cv=fail; b=r1xrV6zLVez3bJkhDnZjBV5NlWwkeXbjLhfCepUk40bNNT5gEuIQu7gx92IKBXAOlquXsqBvWh5XBphTSGBITTFqj9Ro8nsghf/UpThLb/iUJXuhU5nmqxRNJ6H9PwWvumG2kcqwzxSSIiDf2JhwAyYYb6I1I14lb65FSPLInP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332234; c=relaxed/simple;
	bh=ND22Wps7xTq3tgY+Bol1z0+TmVd7WKjdnazhmxP4RLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uTuBCPU5YXCzzRTLQsCmwCvS7Aa2p9HBOPbaH6EZNk8nZhjQAfzAoWLsT+jGh0aAa/On+Z8stKOeU6+tXypHXI+++gpGGklTP0uaHNvQm84tUAmucWFg08aJZkkE8mQW05e3E5cYZEtyhM6N6KPRjHzIn77wn3uWGPJ1JrSzx8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmJy/ZGX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747332233; x=1778868233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ND22Wps7xTq3tgY+Bol1z0+TmVd7WKjdnazhmxP4RLI=;
  b=YmJy/ZGXZOu8lkDrehfIGCdcxUegKlFSSPPMQXSBYBi6IsvT+t+GP7aP
   pomXjThBHAXrbqWR40E5H4Wte63JmvEWHP8oWtQ+DULa+UqFvBkfBSXvB
   Bhxx1QrlW1F9FDdqLmKp33BnoFMkSW9WXYd3l66BQqZiasnMePzd9tsLQ
   Twf2ydyCXNTEAwXJsg5aO7OC4WogkdHzNY3DRE7r3OeCrX+03Qq2aK/Lg
   nV+Iwsl2hncWG28GZIfjWNQ32ooAVExN2BPl7X8Hzf0HiL0KPkfgHAmSc
   Q1mArn/HCn+d4EoPwR+Qig83pKcJKIe+IgC1GUfvCO8JihJZJG1DMQieY
   A==;
X-CSE-ConnectionGUID: 6OoOx/umTpyWNDzhX+uFhw==
X-CSE-MsgGUID: wQ6rA0hcTHSc9yel2vGLKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49424101"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="49424101"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 11:03:51 -0700
X-CSE-ConnectionGUID: D/MgADDQTXCB/oPrqaG3MQ==
X-CSE-MsgGUID: yR8sIxlCTLaSLSnFV+94sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="143675385"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 11:03:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 11:03:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 11:03:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 11:03:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxgl34/kCNIgYWds8I2XYV8CBi4/kRO88kzoHxymLFEuXcB0/N0kNw0Q429TJ1v8QGCLrgaggXxnqdhb4wYTMOzcMRITG+4JPTKV4w7rggbn06hbvnhKbgBHugyuI7oz+1IJV5rfdbxUsoiH1wIO/RlTxx1LdgePIWeRo1zKb62p3Q8tmN9kZXYEFsbM1djgyoed/74WFjadcpaLVyEOqY0JItKfcwy98S/pAs9kev/2wy1QW52pqORA1L1orVEOSZoZ9KK+b6yE/WKQMm1o9qgexStxytdMeaxaeyaQ2fhiHu6CjdI0JbMpO5q3JoBc/IuaMKP8Zn6e7B2SBzokvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND22Wps7xTq3tgY+Bol1z0+TmVd7WKjdnazhmxP4RLI=;
 b=HvLA09Sc60OFEYeKLPGazighuM64D98A5MPTifv7YI6xdU12f2PmpW2GH7XwgKzRZaPmpgLQWfgzt0DBGEwn8SMTLy50HwDKvL+OIz1HYmnYyE2cDjGnyFqB1k87QRgG3hmy30/WPV9vmqNuDMeAQbZyQhDnqdyD8vgKoeDhv6QfgIPZXuFZ1K/PhdXPGVGBjQT1o5v/elVJieHO6EX4DSKfJSyhW4ovxq+wqXhg2PcjB0wc3S8dSiKIDEBW1cdpBKy9gNAIjrfr3IJaZ3k+52k719iQMIrgPgRUsiK0W59XuuIwrTQ6+zAgLdJW+l/KaDDJ5mpl6CL/o7KJ5uEBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7946.namprd11.prod.outlook.com (2603:10b6:930:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 18:03:47 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8722.020; Thu, 15 May 2025
 18:03:47 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "ackerleytng@google.com" <ackerleytng@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "pvorel@suse.cz"
	<pvorel@suse.cz>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "Miao,
 Jun" <jun.miao@intel.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "steven.price@arm.com"
	<steven.price@arm.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "jack@suse.cz" <jack@suse.cz>,
	"amoorthy@google.com" <amoorthy@google.com>, "maz@kernel.org"
	<maz@kernel.org>, "keirf@google.com" <keirf@google.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "quic_eberman@quicinc.com"
	<quic_eberman@quicinc.com>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "hughd@google.com" <hughd@google.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, "Wang, Wei W"
	<wei.w.wang@intel.com>, "Du, Fan" <fan.du@intel.com>, "Wieczor-Retman,
 Maciej" <maciej.wieczor-retman@intel.com>, "quic_svaddagi@quicinc.com"
	<quic_svaddagi@quicinc.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "nsaenz@amazon.es"
	<nsaenz@amazon.es>, "aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>, "anup@brainfault.org"
	<anup@brainfault.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"tabba@google.com" <tabba@google.com>, "mic@digikod.net" <mic@digikod.net>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com"
	<rientjes@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas,
 Erdem" <erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "Annapurve, Vishal" <vannapurve@google.com>,
	"Xu, Haibo1" <haibo1.xu@intel.com>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "will@kernel.org"
	<will@kernel.org>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "quic_pheragu@quicinc.com"
	<quic_pheragu@quicinc.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
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
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "seanjc@google.com"
	<seanjc@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrPT/RKA
Date: Thu, 15 May 2025 18:03:46 +0000
Message-ID: <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7946:EE_
x-ms-office365-filtering-correlation-id: 2bd930ef-7f15-4ce0-e74a-08dd93dad684
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NzhLbTVFcnZyVUplYXVqbkV0ZXFFOXZOM1RCV1NQeEJ1cDhzbHArRkxqVjNw?=
 =?utf-8?B?Qmw4VjRNZEoza0pGUitlcC9QMnBONGQrLy9sUzdYNkE0eEgzUSt0azFYT1Q3?=
 =?utf-8?B?dys0d0tjY2ZsN3FlTWwzWTRHdmxLNW5VME5DbjhLaFo0Kzg1Z0l0UGI2eCtS?=
 =?utf-8?B?YzZmUkhDcmxSY0hXVzR3TW9reDdJUkNnclU1S0VaT01tMCtJSCtuSVlFSmFJ?=
 =?utf-8?B?UEJhZ3YxVkxWdlFHUTZLTXhHM3hhbTJIcmJ5cExsMFl0YkRDTENLUGRZdjMz?=
 =?utf-8?B?aFZobXdNVS9Na1g5SjM2YVBRVnN0WUUwVjNiUGRuR1FFOGYwNWlqRlVRczNF?=
 =?utf-8?B?M3RkQjRWd0dpSEJlQ2VReTZDU2ZNOVNMTkw0eGNzZzhyeHg2MmhzTkt3VGpG?=
 =?utf-8?B?TEdGcW00NVhISituN2d2VUphR0xJTWd0TnhOanZSVmROQlhHbDNIc1dlNDhi?=
 =?utf-8?B?Vi9kNElUZnl0V1dHOUM0WVhpSnl4Tnh2TStub2tuWm5qUXY5YUFsNzJTeGtr?=
 =?utf-8?B?TUFzbVQvbnhPbjI0eE1mM3RReWZqWWdEdFREUjlPVFV0Rzl1cHBITnVibEhG?=
 =?utf-8?B?enBWYjgrbFBoOWUrc1NTcm40YUh6bjJ6aUYxVnZIcXRJRWtNL0RLamo4UnEx?=
 =?utf-8?B?Zys0REZUSXV2cVZ4SE11RGdpeTBSMFhlOFFJRFRvNVFLSEdDZHhDT1h4dXgw?=
 =?utf-8?B?elFKSDVGMytFUEJRRXhzN0VlL1dNVEVXUEVmdTArK3JUbnljYURkWHA0Z1hM?=
 =?utf-8?B?RWJsdjVzall0bkRyRnZzc1ROY3BudngrWk1hVExwS09hblpJcXJMalA0c3lS?=
 =?utf-8?B?RXIvb0FITmtjVnhqaHZnWHVmZEp1dzQrYlNXR1ZvWENST2RiZ3B0N1BOczkr?=
 =?utf-8?B?MGNac2xiaHpoNHFHb0lCVkR6T2xTTjUxZFZKNTJUcXdVL2ljVUNiYkpURkc5?=
 =?utf-8?B?NG5kMmprSzhRVTR2N2pvOGIzZFZYNGxDbGd2a3BucFlydEE2L1hqeWxXNFJE?=
 =?utf-8?B?dUJTbVh2L2pxcVJXenlodlhRdUJOUzRNcUovZlkzRjBpYzhJVFdXTW5jOVM4?=
 =?utf-8?B?N1JGWm9kQ3FIdUNwQXpxNmJzaFZ0NEpYM3hYYmlKZWU1WXR4d0hPMktOSmJF?=
 =?utf-8?B?Z0lHMHk2Zm9XcERCYmZZbjdncVI2U3NiNGxaNlBnd1F1SVZOWWJDSjlTMGtL?=
 =?utf-8?B?NDIvQnhmU096RnRMakE1bmtIbkRPd01KeXRSNjFVVUlmZkFzdmRGVDFOUEli?=
 =?utf-8?B?WVNOM2w5V3hZbWtqQkpKeU9wbUszN0Z6TU9CTk41K01aMTA5NlQ5aHc4MXph?=
 =?utf-8?B?ZzFLeVZYaWVsZmZhZ3dLai9WZmF3alU2ZHBJRFZuLy9xSXN1VUt1M1VhL1Ex?=
 =?utf-8?B?NkdrNVNEQWtxYkJ5VTFITTdoR1NUWEJ4dzQ5cU11MkxaL1FNWElDOGNERDR4?=
 =?utf-8?B?WkZkWFlueU1DaTY3Smo2Um1scnZ2L3oxQVpvQ2NlVXdxdmZLTjZ0bTc5ZlNw?=
 =?utf-8?B?aGNYNE13am9PL01Hd2JJOVZCMTNySW9MYlk1dXJaYzFFOEhvMzg4eUxwRHBU?=
 =?utf-8?B?K0tINHVsMnZnVWJ1QWIzbjdnUXZheVdDYzlXWXRqUTZWa3lsNlVnWFdNT0x0?=
 =?utf-8?B?RG9FdVFZMFRvUWU2R1A0NXpHU0VyQldFMDVBcUlwbUhCRTRRN3BIYUplcEx1?=
 =?utf-8?B?WkNZZS9yWE4zVTZIQUcvclJMdmtrSkdsemJJS2w3WFZScWhLVndSdlAxQUZz?=
 =?utf-8?B?Q25ieTdEdHp5S3dtQjFXOU1Cd3FkaVpXcTBFVU9iL1R6eTVmUzFJaDlTM0pL?=
 =?utf-8?B?YUZYeTByRU5VdmFZRXZlZ0xGZFo4OVB3SWxpSmRJVlhrRmgxckxxMitQREM2?=
 =?utf-8?B?QWwzazNjWGdpaGFHM0xKQXpwb3phMnQzUGIyQjhheUhnd3FVdDBFTGtuMGta?=
 =?utf-8?B?Y3FWSC9lUHhzWGtiLzhQZFdXT3VZb3o0SnAvQm1rOVJSTStGc3g4RWNZOGZq?=
 =?utf-8?Q?outpyLs1UwV/dhkK9GEpmTclQp6xBM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVlDTHF2aURKckd6NjBIU0tiVFp0U2VGMWloVUM0TjVxYjNaWHovekwxanhv?=
 =?utf-8?B?ekFySUV5LzlISTBkejlxdGJ5Y2xpd0FzL2NiZVlCb0pUWEUrVThpOU5ZKy9n?=
 =?utf-8?B?ZUhkWi9jMjVhamlzeWRxM3h1THRyaFlURVRlblJsM0FIMWRYMnBURi93NzV2?=
 =?utf-8?B?VHMyTnMzNTdyWW04bi9XVUE0cjRNSktTbDdrWTcvUkM0c282MzhyVnJOMGYz?=
 =?utf-8?B?ekZvQ3hZdnhUcEUzMjMrVUUvbTVDbkhZM3BxWU1LN1BWZ0lYbFhGejVwdDlw?=
 =?utf-8?B?SThtbEZTRytQbnZmaDVVNUpPbkZXcXdOajkyWUpCZmZLb1ZTeTdPbXVnQlRK?=
 =?utf-8?B?cDdObFR2bjBLLzVkN1BlcTNuVDFTdVdyeCt5TFdHSW9aU0xLdHErbG1ZYkhO?=
 =?utf-8?B?dlBGWmJyTjNNNzJ2MFhoMTlMb2hYcGNucVQzQllubVZYS1Q3N0dxbUtZYzd3?=
 =?utf-8?B?dXl2bUthQmdaSHRkeVg3NE5kQytGbURabVp6RHdoNEpZVGZ2emk4U3hYVm9F?=
 =?utf-8?B?NnlqSDZidEF6RFJyOUJGcnRsWjFuYVMvOUdaN2lKbStwbHRyV2JPc0JtdVZp?=
 =?utf-8?B?OFFBeTVQTDR3WXlHM1h3YmZFNFo1TTdZV3ptYkdTNTN3c3RQeGp3NUhlY1Nq?=
 =?utf-8?B?L2M3TWcwSWVKTjhLQ29ldDByVmNCMEtKeDE5cEoyQnFHd01yZTRtTGhqWEhR?=
 =?utf-8?B?M1Z0Q0dIRU9rN3pqSjlUM3MvaTlneDNVb1Y0b3VVZUdQa3NwcWxHL0o0ZFIr?=
 =?utf-8?B?YVdUVUltMWMybXYybWJKZFJYS0U2YXFHTE03T1pHSlRyQTRZUjhCa1c0MjJt?=
 =?utf-8?B?OTZ2Si82NkZGTFhiVFIzZThGR3JXVytET2tUUFEzTU43RjQrRFhsUVcrdlNh?=
 =?utf-8?B?Y28rTlBndUFkUE9mcmdJMnNUd24zNXh1SDlVVEd1NnBkM05MZVMrZDRPRzFz?=
 =?utf-8?B?b3VPZ2h1RCtZMTlkM1hhVUR4VGRxY0NxTzExQmZCRUhZMUU4UFJ2ZWJrVTdw?=
 =?utf-8?B?Y01xaXBaRng1WUI3TTZsWE9xUkFYRHJMQnVsRmtSaFVhcitobEF4cS9IN3JB?=
 =?utf-8?B?YW1IMitQMmRtRGluNm1yY01IVmc0NmxxQzhjMldZWWxSZTVsWU0ydEJkVGll?=
 =?utf-8?B?OHVwQjFSZTdqT20zdkgvV2lHMVZUV0k0UzlmUHJyZHlXQ3dDZWttcmNPUnhE?=
 =?utf-8?B?V25pYzRZQXVjRml5ZHYzQWtJSW9FbmtZV2FYb0hkMEFxa1ZuUTVtczlxUkZY?=
 =?utf-8?B?WmQ0blQwR2pTSlZITWdEdm4zVXpUTTUyZzNrYkxORHVML1ZEcGl6cG0zLzBQ?=
 =?utf-8?B?bGVBQ3Q1MWJxYWRBZ051VzZwREhuK3ZqbjVEQzIxTnRRLzlVV0ZMNXJFY0ZR?=
 =?utf-8?B?dUFtbG8rcHpuR2ZQOHNqSFFNM1ROc0tzbHdnNW1pV29JaU5wY0tBL1h2R1FM?=
 =?utf-8?B?MVg1bHZQckE1WjZBMGs1YS85VU02emZKdWVkS1o3WkhKTktSQUZwS0lwbUxE?=
 =?utf-8?B?TGFzelJwQ3pHZnpQdjNQVS9YUXdVSXNvakRvTlJkeEdKUTg1eThJeFRBcG05?=
 =?utf-8?B?b01QeDEwQk1FNmlNSWlDOHd2aU5FU3B3ai9uQlFaKzg0bzNYSjNpVS9rOHNa?=
 =?utf-8?B?M2U3alRTOHU0NWdHdzl4enQrcmt0YXVoeWpaZEJzTWtOdWxwdWxYT2lySHBF?=
 =?utf-8?B?aVo4RTRtSjJUejRPWUJiWlIvbXR5VlRNNitnaEVEQWp5cUM3Z3EvR0xNMm92?=
 =?utf-8?B?ak5kWlB6dHkrQ25nSmJ2MHdFMVovb09xZU5uQmpGcFlaQ1Y1NytvdDlEcmtD?=
 =?utf-8?B?bExjQU04SEpNM2V5NXdxQUZzRGlaZW5TR2ZkOWJTVXozOVFDeTVLUlNBOUFD?=
 =?utf-8?B?UHU2VlhBenU3ZzhieE4vZlhNRkpNTmZsSTRoTVJZNjErVzdGK28rWGxvNlRH?=
 =?utf-8?B?YS9nVVdwa1Jsc0dBNmdoQStRZUJaR0dtOFhRWHJOZjY3UkJ6QVRkd0M3bHZJ?=
 =?utf-8?B?QjY1ZWFOOGl1TEplUGVoK2p0bGc2ZFBIQVY3bForTjZkZlFZVCswNXcwRldL?=
 =?utf-8?B?d2Z4QjQzUjA3UHN5dkROMy9nQ0pFeUk4eXBKMUsyb0wvRlI4QzdNWkY4ZHVl?=
 =?utf-8?B?N3NQUDNhTlNwS3BtbWVmdnc2ZmhOOHhyYTc3a0JhOEJncHc1UWhlbHpUN0R0?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34CB39FD20BF2144AB2B5F35DF414B08@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd930ef-7f15-4ce0-e74a-08dd93dad684
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 18:03:46.7136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lh0X85JTVTOgWY2BOTKfa/2g1OWm0JCI/rag3rg9+eU4w0avkotZMZdHxI/+qSNLjdTjXxFTnZK3ccp2TRJsY0btqsoG18mSlYXt2plkgh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7946
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA1LTE0IGF0IDE2OjQxIC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
IEhlbGxvLA0KPiANCj4gVGhpcyBwYXRjaHNldCBidWlsZHMgdXBvbiBkaXNjdXNzaW9uIGF0IExQ
QyAyMDI0IGFuZCBtYW55IGd1ZXN0X21lbWZkDQo+IHVwc3RyZWFtIGNhbGxzIHRvIHByb3ZpZGUg
MUcgcGFnZSBzdXBwb3J0IGZvciBndWVzdF9tZW1mZCBieSB0YWtpbmcNCj4gcGFnZXMgZnJvbSBI
dWdlVExCLg0KDQpEbyB5b3UgaGF2ZSBhbnkgbW9yZSBjb25jcmV0ZSBudW1iZXJzIG9uIGJlbmVm
aXRzIG9mIDFHQiBodWdlIHBhZ2VzIGZvcg0KZ3Vlc3RtZW1mZC9jb2NvIFZNcz8gSSBzYXcgaW4g
dGhlIExQQyB0YWxrIGl0IGhhcyB0aGUgYmVuZWZpdHMgYXM6DQotIEluY3JlYXNlIFRMQiBoaXQg
cmF0ZSBhbmQgcmVkdWNlIHBhZ2Ugd2Fsa3Mgb24gVExCIG1pc3MNCi0gSW1wcm92ZWQgSU8gcGVy
Zm9ybWFuY2UNCi0gTWVtb3J5IHNhdmluZ3Mgb2YgfjEuNiUgZnJvbSBIdWdlVExCIFZtZW1tYXAg
T3B0aW1pemF0aW9uIChIVk8pDQotIEJyaW5nIGd1ZXN0X21lbWZkIHRvIHBhcml0eSB3aXRoIGV4
aXN0aW5nIFZNcyB0aGF0IHVzZSBIdWdlVExCIHBhZ2VzIGZvcg0KYmFja2luZyBtZW1vcnkNCg0K
RG8geW91IGtub3cgaG93IG9mdGVuIHRoZSAxR0IgVERQIG1hcHBpbmdzIGdldCBzaGF0dGVyZWQg
Ynkgc2hhcmVkIHBhZ2VzPw0KDQpUaGlua2luZyBmcm9tIHRoZSBURFggcGVyc3BlY3RpdmUsIHdl
IG1pZ2h0IGhhdmUgYmlnZ2VyIGZpc2ggdG8gZnJ5IHRoYW4gMS42JQ0KbWVtb3J5IHNhdmluZ3Mg
KGZvciBleGFtcGxlIGR5bmFtaWMgUEFNVCksIGFuZCB0aGUgcmVzdCBvZiB0aGUgYmVuZWZpdHMg
ZG9uJ3QNCmhhdmUgbnVtYmVycy4gSG93IG11Y2ggYXJlIHdlIGdldHRpbmcgZm9yIGFsbCB0aGUg
Y29tcGxleGl0eSwgb3ZlciBzYXkgYnVkZHkNCmFsbG9jYXRlZCAyTUIgcGFnZXM/DQo=

