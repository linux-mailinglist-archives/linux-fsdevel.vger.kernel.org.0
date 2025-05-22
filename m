Return-Path: <linux-fsdevel+bounces-49699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C135CAC176F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 01:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC471C044FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 23:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897642C2ADE;
	Thu, 22 May 2025 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5qL32B/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF1258CC2;
	Thu, 22 May 2025 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955599; cv=fail; b=bBQwTf5yX0uVwdgc9W3XrmGUf516Vr5rqIpmiTVVYiThhIZg0p4ADMEel4Qk28tPyiUIC65i3eoqzh6gV7PolR2TTgRWiEBPi0yGdC1jYyupQVOWnFbbpFWOysle6nKpHtcujc1ZfIAs7plCJWPT4YKuFHTscrJ2CaG3QTq4ewY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955599; c=relaxed/simple;
	bh=3FQWM8rLoM+AH9+xpcZ0/vAci4zxEjUvjGBWyEbgcFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R7opQGF4YXP5ia3ffHmNrXpoGGDPx0Lb9vJDSYwbKchJ/7IeqJrkQeX7oj5ApZ9HssdbRLDr0BDNUIfgF14UDj3s2siJuOriX5QMdxcmKQpgROb8SDYEilLyW2mm7znF40l0dzmOStdHphBLUDR5SYTRj9eJajpxyaVUg5zPwdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5qL32B/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747955597; x=1779491597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3FQWM8rLoM+AH9+xpcZ0/vAci4zxEjUvjGBWyEbgcFM=;
  b=X5qL32B/35AdiCcL9uw3Z9Dckx2FuKllgRaWv4Ihmb7QmanAZZvAEXK/
   E83b0XzPoKykMXSRd4Rzogdo9jwCqhHr+juHYZAkllLg9Byey7hO1n4lr
   WtlslJ050yGGwzLe7olkUxDI9RVKpGDNC+TSlq+TkE3VxgypQ5Hv0cIp1
   Sdh/9sKzn2DeaAWWC0cKR9X7giojaHa9drDp3d4Vuambts4m4p4G8EvRO
   hkAq3lLoLUkltGKB97g8JpzCRy+h0AWdRsw+KaqP3H8lfdDlznOnRQCPR
   EGD8j+U9jtkZ+DwU+NbkTF/FpHxphoR6ByuVYs0msIiJGWb0MCuteNu9l
   Q==;
X-CSE-ConnectionGUID: A8QL3IAoR36q2AZHrcYBMA==
X-CSE-MsgGUID: folsbCqnStmMaPadtwA84A==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50167063"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="50167063"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:13:15 -0700
X-CSE-ConnectionGUID: VARz0i02RbSVP3GnBSSnlA==
X-CSE-MsgGUID: GyytFEGfT1etGgOh08aFiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="140871982"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:13:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 16:13:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 16:13:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.75) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 16:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oviXEfjPuNfvQun+rtW8+C1d0YLvgi2K/8v/mYnrzuFeM0fHXFrXnIEE2U+QlU1FNW90FDqDDXObZR9qsf2/JqbfIj5ww51FHkAgd51Y4/o8igFQK6uEHvKnykOb0obKf4TmKd5vnfFwVadr+z7sfdm9X1FdNshjNgkJevNDzw01DuOSi1kG4O7PSbHLo5DxxY8cfGVkqzWzROs03bTN8ib/VTSYdUa+Df4mFebEZ0MEuT95fi2cEcMK1iFWYu0W2Q/gtJfJBw9kxxbMN+aBojDlfBjoGdoxtL/c7dv1oAdLz28iHcOg71FbpYMvj0DM25ssrgOQ8g7xHq0VusIAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FQWM8rLoM+AH9+xpcZ0/vAci4zxEjUvjGBWyEbgcFM=;
 b=El7fRzS6eDv24n5qL+IbONKN0eAoCszDosyw3Ag135QhK9YE0jhyMQPV3cn5T++SlSeRUvGi3e/ORdfInXnEynV7juuOH2J2IWuaTbMvtobs1fLnbe0GN+U71M5INYQfIYTHxFW5Hs6aZhvXKMBEJs0ww5UpXCNOI8zJCWv/Uz4U59hz+rSp47LuFQqMLZcsLiLyYEu6KzZ3NubijngbpLW3aVhF7LxzaM1k3C0PUnL0Ha886bR3CW5xOmEksxRtxlRMI2BU0Ku+C8CNEwFKLX1NCI9Kt5n+bCRAx6/QWVY6qhMxkyp2U1CAA8ggCKPI9CfRhgC9Mt4cN8orxNVvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB7713.namprd11.prod.outlook.com (2603:10b6:a03:4f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 23:12:25 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8746.035; Thu, 22 May 2025
 23:12:25 +0000
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
Subject: Re: [RFC PATCH v2 33/51] KVM: guest_memfd: Allocate and truncate from
 custom allocator
Thread-Topic: [RFC PATCH v2 33/51] KVM: guest_memfd: Allocate and truncate
 from custom allocator
Thread-Index: AQHbxSoTpxHzkeUvHUi5Uzoj64ig5rPfU6AA
Date: Thu, 22 May 2025 23:12:25 +0000
Message-ID: <3730f3d177e3b4627fd28c50eaa12914abf08b8b.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
In-Reply-To: <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB7713:EE_
x-ms-office365-filtering-correlation-id: b71615d8-3c2f-4a7a-6044-08dd99861d57
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y1lrSVBHM0NYdVFscnZXc2VMQ3BTditTRXRwZXpQeXFqZElPSnBMQmJzR0Ir?=
 =?utf-8?B?Mklmd3lRZ3JlSzV0VFROcG5XZkVYT3IvektRbGJzU1BXTGwzQWxEaE1mcVp6?=
 =?utf-8?B?dU1rTS9VbzVhdWN1WFpmbVdMZXJBUTlpSnVWZ3VxWWtSL0NBQjExNmUyZ2hP?=
 =?utf-8?B?S3JUbk9FcGdGQWJhemk3b01WU0dLdHVNM3pjaEF4ZU5TUm9LQjdZL1VLN01O?=
 =?utf-8?B?RWRjazdtdjhUOW14OEJuWDA3SE9sUFNFUzdWZUppek5tSWNIWGdYL1pkSzhw?=
 =?utf-8?B?Z3VRZVZZRzZKTEIxZjl2TVdBZWpTdHNYU2lUTE5oSzdrSDRhWUppT281cm1R?=
 =?utf-8?B?ZkJacy9SeGl4YXBoUTdCUmJTQzVwcjY1aUVsRWtydXFXcGMvcXVqZUlLSVBC?=
 =?utf-8?B?UUJmalhaREt2SDFZOHFjVGtrSVBseXFEcE1Fb0pqSWRoUHRFc0hUVklUSW9Y?=
 =?utf-8?B?b3dic0I0VTJGSmZob1lXMTk4WWpTSFhyTVdBWDNma2dST2JRSDg5YnRpa1Nt?=
 =?utf-8?B?Q2Mwdk9odk5GMVkwWWZYRTE2T2NvS1o2Q1VHNno5Yk5uTE5mMnpLODN6RkJo?=
 =?utf-8?B?d2pDYTNxYzVjQ0JRWWNiNHNZazZpNk9vL2NwVk1aVTVTR1E0dVBQcS9EeWx1?=
 =?utf-8?B?cUxSdStwQ0dQQnl6RXJtRTZiZUNLWDFveC95U0drK3dqb29JclBkNURVVncv?=
 =?utf-8?B?bmpSSGJHRFFpeUhNTXdjZnh3MHhKMEkzQUVTMzYzTWRGd2EvNGZ3ZjgwQ3RD?=
 =?utf-8?B?T1NkVVNUQzRqNjczdnpFenZWdW1Ebis5ZkkwVUNaTnhrQXFWdStodXRRaWhx?=
 =?utf-8?B?eEc2QmptM0tZWDF1UDRxYk82Tzk2dG1yYVREb0p0SUZMZCtIUGo1ZnB4clpq?=
 =?utf-8?B?d0RPZzJzd1BkOE13Zms0ekJNSGx0RTdVMzZkY3lOTGgvc1RpR21TTnVyL29K?=
 =?utf-8?B?MnJnK0x5T1RrT1A2cFdGMi9vWkZzbXd6SUpSRlVycjNzS2QrRkFDS0JvMmUy?=
 =?utf-8?B?cVRiNnc2THV4SXBNNmNLUis3RWlFTmZEclNRVGFwN2kvdEwxNXRDZEdraFFZ?=
 =?utf-8?B?TE4yZFJ0VUNSUUVWYmI3QmM5TE9QWFVYSjlHbmpqOFhGTXpBUUVjcmdvbmRD?=
 =?utf-8?B?aGx3SjhnM1NvZFVBZ2tzMWVJdmNPKy8wQnY5Si9hb2YzdUxldVVpQVA2a0cw?=
 =?utf-8?B?cFZscDVRZ1pTU2xJcFpiVkc3WlZ4T2p2QUhaMkQ0cXd5Ui9LOXVHa3ZsenRi?=
 =?utf-8?B?T2ZGZ2lvbXV3UnhDQ0Z5MG9oN0kyTXRRdUQ4dm8vVHQ1U1NaWnFoTGI4ZmEv?=
 =?utf-8?B?TmxqbmtNL05TZTlkZlJ1czZGZDFiWjBOYkE3eGt5NHZyeWZhNzhrUnJUWTls?=
 =?utf-8?B?WDJqQ3JmVEQ2QTJUNlp6MzRrN3JCdGowOFowM2NtSW83WStUU1hEQmNTRmRu?=
 =?utf-8?B?bDMwbkVPOGtFMGU4K3VLOVEySGpZdG9McUJPcmI0eW9ma1M3aWpUUEkxcDBv?=
 =?utf-8?B?dlhLYTErcThFMFQ2RHBmSGdxRW00blJYYkMxa0tkRS9WNHM4eUtwdGFRR1R2?=
 =?utf-8?B?Z21nSWdPc2VUSFdiRGxadk1XbzUrS1NvRjRXNHFPSXgxMWo3YVRZVXFUTXgz?=
 =?utf-8?B?bGdrclVHb1pnVWVUK1d0RGxuN2VoTkw0YnVWWWp1MzV4SkNqVmxwaXlzKzNk?=
 =?utf-8?B?aGZqWDF2V3Z1THdHbGxmbGVmN3NxQllPRXo0bWNGK2xUaDJOWHppdlQySkl5?=
 =?utf-8?B?dmR3ZW5Ycm9UKzdDaXNLZ2RoaGNxd1FSeW9VU2w4bzlaeGxPZWhiZGg3V3E3?=
 =?utf-8?B?a2NQYW9aWDd5bCtaOGRFK1BvTWI2dzBVT3VOTXVtVDF4WjhnL2N6dWVENVZh?=
 =?utf-8?B?YmlJOVFPeGlFZ1UybUtmMmlQNW5PQ081SU9zSEovNS8zRHp4YjlWVkp2QVdO?=
 =?utf-8?B?WFNRT0I3cmxJOTVzMEJMelZOdUR0MzRObkNUVGNHRUhNR2pHTVlvaGVQZW9l?=
 =?utf-8?B?djJENml6WGZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzN0eDZhQWN3ODlveHRrbkcybmEyQTVaT1VtSFBhbXVkcXphTnRhNWVMYldn?=
 =?utf-8?B?SlNMMzQxbk1IeWVXWnJBSVVSWlRQNTJQYU1pUk1wVXZEd3owSUgrTlZCZ200?=
 =?utf-8?B?SDg5Z0VXSlZpNTMvenhtenE1MXpjaXU4S0hNQTZocHJBR2RBdTBpYi9OdjZY?=
 =?utf-8?B?ck9PcnhPbUJDY1JIYWFNaGdDdDl1dG1rVkl6UlpoMURJRjRzaHlpNXJmcWRH?=
 =?utf-8?B?VGhDUHBJL2REOGZiY3dVOGpjYkkyVzdtdjdsNlNnS2tDWk83QU1ac1FPSS9w?=
 =?utf-8?B?TXNVeGhWK1VPMFBXQXNIUTNHaDVuOHBjNnpyQWhHdmVDazFLLzNmc05rSFN1?=
 =?utf-8?B?VDM3WklGdmRBNEV1NjFGNk9zQW9mV2NTSXBaZjYzQm9HaVljd1g3MnRPWU1W?=
 =?utf-8?B?UFhMck1pWXRxS0hHRGtSTk1zYU5Ublc3REFoRFduMzVaTDJyZEcvWXRsV25P?=
 =?utf-8?B?c3lVSzNZcGx4ODQ2d1hFTUUzYkNrV3NQZmhKT1dRMHNmZzgyS0RWMTc5T25W?=
 =?utf-8?B?VVJtcmpsNnlEazNsd0RFMU4yZDBUbVRISzhYVE9KRy95OU1OaG5kV3NoLzZw?=
 =?utf-8?B?QjkzMG0wZFROUDBuQWZSNzNPbkxSQm1OS2dyTnJIbzJuZ05MWHFLQktzRGhk?=
 =?utf-8?B?dVBIdTFYcm5PNEkyc0MyR25LUlhUek04S2QreWdERDcwK084Zm92TkVtcVFR?=
 =?utf-8?B?Z1NMRy9EMXRuZWlwWXRKako5dWhCbzh4eDArUXpuc1hHcjBBVVplb3dvWXZB?=
 =?utf-8?B?MEl4dWtVdVdQeWFnUExpWnFHWGtYcHZrMldhWVIya2ErbkRnbFVIbDhtRVdZ?=
 =?utf-8?B?MkU5akZaSENXZS9vbjNVeWc3L045REZNbkxXTWpCWXVseG50QnlQWGxabVdD?=
 =?utf-8?B?UzMxR1J0QnZ2aXQxMmJGcjUvT0o5MW0zV25LOU5uMmxERWFiZDR1V0IwZm95?=
 =?utf-8?B?Tk82U2l5TWtFcmdBTFFtMllHQ05MVVhKVi9xbEN6OTlMd2hqVlB1YTc3NVRI?=
 =?utf-8?B?cWthTWNPUlRLZTBPMlVZWWdsMmQ3ZHJLd1ovN2o1NTQ5QjJOc3dUYUc3azEx?=
 =?utf-8?B?emlJMklVUEJYZTluOFYxVEtKTmo2MHBLMTdFUmQzalRIWGZtcGhZSjhJRGFj?=
 =?utf-8?B?NzdSSHY1OVdzS2tRbEgza3FSc1RvY1FmaWZJazZ6Mi9oVGIydWp0UmZEL3ZU?=
 =?utf-8?B?Q2N6L3FOMUcrekcxaTlTcXZ4SzZaa1BIb0hpVFFJTFNwbmlIQjJBSzVObGZ2?=
 =?utf-8?B?bWFIT2wwY3hla2duZ3phT0hzYmJYMVg3MTNFTkZvVWwvdlJ6MFRNSzhiWHUw?=
 =?utf-8?B?K3d5MUpVNWhGSk5HQjYvalFJTHNDRjFabDBpT0ZDMDJtSkFXZFFEbHRJNTV2?=
 =?utf-8?B?M2QwdC9Fb2Q5amdYVHgxb1g0NzRLdUdja0JaaW9YNHB1dmFOVEI4OUdqLzNK?=
 =?utf-8?B?K2x3bjZ2ZTE4S1RmUFVxd0dyUk9XQ21HUGhTNW93U2QxYmVNK3I0SDVpOWxj?=
 =?utf-8?B?MHJnMEphR0J0ck9OUTV3QlZPa1BnSndBTXorcXF0eVVqL2NFUnpKd010UVZJ?=
 =?utf-8?B?bXdpUHdWNzNQc05XaWJZdExnNURUbTVPMzJuKzJaUisvNVViREp6Sk5yeXVR?=
 =?utf-8?B?Nkt2cFRsRDA5MlcrckxMdmtFb3lheDlnTHVUZUdQaWxKdm5oK04rNGdWbEsy?=
 =?utf-8?B?cC90ejdXaXFQRXdyOGl5bHEvMld0R3NldGJMMXhIMUVJdWNUOTNvYUpTK1Ev?=
 =?utf-8?B?TTMwTmRWcVNpRnNYQnd0WHRkRk9KRlRpQWhCaklUcWZCbUdQYmdEbXBUNXlY?=
 =?utf-8?B?M1ovd1VyeHNNZ1ZwQWV4Q1poN3ZpMGtKYVdsR3dmZUVwMlZNQnJNWGNhTysx?=
 =?utf-8?B?REF1em9nMUJxbHcxcW1objNGTG5ZVFc0Rkh4bjNQZjVyV3Y0bnJhQVZER3JS?=
 =?utf-8?B?eFNlSDFvTi9JUC9WMWpPcm1KUTlHcGwyWVUzS05zV1JFK01hUjZPM2pIZzJP?=
 =?utf-8?B?cU5vdkIyR3hTUVJBbkg4eENUa2cyZXc0NTR6b0tmM3VWcmU5SkE1NWRrYWdr?=
 =?utf-8?B?dWFjaGJBNmdCSTdFN2VJMlVoUXFlbU1KTFIvOUpsdjlWeFhEeE9DM05ENklB?=
 =?utf-8?B?M1lkN0gycXhFNE83TlZhaHdxVkRzWlJmYno0Z3Ztb0JGSDNXZlZkTk1LS1Fi?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <911A01F4B4F6A74D90E6FC1959BD1936@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71615d8-3c2f-4a7a-6044-08dd99861d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 23:12:25.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDOEnJ59dJnMIzWn75b3BEGq9dBEm4GNnG/1htJDUOhHMqky4BuAwgIOiMik+zBEgHN4KfaPZBrTjEuyn2t1svwDlkcG3wUFR9/yiml7s2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7713
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA1LTE0IGF0IDE2OjQyIC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
IElmIGEgY3VzdG9tIGFsbG9jYXRvciBpcyByZXF1ZXN0ZWQgYXQgZ3Vlc3RfbWVtZmQgY3JlYXRp
b24gdGltZSwgcGFnZXMNCj4gZnJvbSB0aGUgY3VzdG9tIGFsbG9jYXRvciB3aWxsIGJlIHVzZWQg
dG8gYmFjayBndWVzdF9tZW1mZC4NCj4gDQo+IENoYW5nZS1JZDogSTU5ZGY5NjBiMzI3Mzc5MGY0
MmZlNWJlYTU0YTIzNGY0MDk2MmViNzUNCj4gU2lnbmVkLW9mZi1ieTogQWNrZXJsZXkgVG5nIDxh
Y2tlcmxleXRuZ0Bnb29nbGUuY29tPg0KDQpJIGtub3cgaXQncyBhbiBSRkMsIGJ1dCBmb3IgZnV0
dXJlIG1hdHVyaXR5LCB0aGVzZSBsb2dzIGFyZSBwcmV0dHkgdGhpbiBhY3Jvc3MNCnRoZSBzZXJp
ZXMuIE9ubHkgb25lIHNlbnRlbmNlIGZvciAxNDMgbGluZXMgaXMgd2F5IHRvIGxpbWl0ZWQuDQoN
Cj4gLS0tDQo+ICBtbS9tZW1vcnkuYyAgICAgICAgICAgIHwgICAxICsNCj4gIHZpcnQva3ZtL2d1
ZXN0X21lbWZkLmMgfCAxNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTMyIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMNCj4gaW5kZXgg
YmEzZWEwYTgyZjdmLi4zYWY0NWU5NjkxM2MgMTAwNjQ0DQo+IC0tLSBhL21tL21lbW9yeS5jDQo+
ICsrKyBiL21tL21lbW9yeS5jDQo+IEBAIC03MjQ5LDYgKzcyNDksNyBAQCB2b2lkIGZvbGlvX3pl
cm9fdXNlcihzdHJ1Y3QgZm9saW8gKmZvbGlvLCB1bnNpZ25lZCBsb25nIGFkZHJfaGludCkNCj4g
IAllbHNlDQo+ICAJCXByb2Nlc3NfaHVnZV9wYWdlKGFkZHJfaGludCwgbnJfcGFnZXMsIGNsZWFy
X3N1YnBhZ2UsIGZvbGlvKTsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGZvbGlvX3plcm9f
dXNlcik7DQo+ICANCj4gIHN0YXRpYyBpbnQgY29weV91c2VyX2dpZ2FudGljX3BhZ2Uoc3RydWN0
IGZvbGlvICpkc3QsIHN0cnVjdCBmb2xpbyAqc3JjLA0KPiAgCQkJCSAgIHVuc2lnbmVkIGxvbmcg
YWRkcl9oaW50LA0KPiBkaWZmIC0tZ2l0IGEvdmlydC9rdm0vZ3Vlc3RfbWVtZmQuYyBiL3ZpcnQv
a3ZtL2d1ZXN0X21lbWZkLmMNCj4gaW5kZXggYzY1ZDkzYzVhNDQzLi4yNGQyNzBiOWI3MjUgMTAw
NjQ0DQo+IC0tLSBhL3ZpcnQva3ZtL2d1ZXN0X21lbWZkLmMNCj4gKysrIGIvdmlydC9rdm0vZ3Vl
c3RfbWVtZmQuYw0KPiBAQCAtNDc4LDE1ICs0NzgsMTMgQEAgc3RhdGljIGlubGluZSB2b2lkIGt2
bV9nbWVtX21hcmtfcHJlcGFyZWQoc3RydWN0IGZvbGlvICpmb2xpbykNCj4gICAqIGxlYWtpbmcg
aG9zdCBkYXRhIGFuZCB0aGUgdXAtdG8tZGF0ZSBmbGFnIGlzIHNldC4NCj4gICAqLw0KPiAgc3Rh
dGljIGludCBrdm1fZ21lbV9wcmVwYXJlX2ZvbGlvKHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2
bV9tZW1vcnlfc2xvdCAqc2xvdCwNCj4gLQkJCQkgIGdmbl90IGdmbiwgc3RydWN0IGZvbGlvICpm
b2xpbykNCj4gKwkJCQkgIGdmbl90IGdmbiwgc3RydWN0IGZvbGlvICpmb2xpbywNCj4gKwkJCQkg
IHVuc2lnbmVkIGxvbmcgYWRkcl9oaW50KQ0KPiAgew0KPiAtCXVuc2lnbmVkIGxvbmcgbnJfcGFn
ZXMsIGk7DQo+ICAJcGdvZmZfdCBpbmRleDsNCj4gIAlpbnQgcjsNCj4gIA0KPiAtCW5yX3BhZ2Vz
ID0gZm9saW9fbnJfcGFnZXMoZm9saW8pOw0KPiAtCWZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsg
aSsrKQ0KPiAtCQljbGVhcl9oaWdocGFnZShmb2xpb19wYWdlKGZvbGlvLCBpKSk7DQo+ICsJZm9s
aW9femVyb191c2VyKGZvbGlvLCBhZGRyX2hpbnQpOw0KDQpUaGlzIGlzIHVucmVsYXRlZCBjbGVh
bnVwLg0KDQo+ICANCj4gIAkvKg0KPiAgCSAqIFByZXBhcmluZyBodWdlIGZvbGlvcyBzaG91bGQg
YWx3YXlzIGJlIHNhZmUsIHNpbmNlIGl0IHNob3VsZA0KPiBAQCAtNTU0LDcgKzU1Miw5IEBAIHN0
YXRpYyBpbnQga3ZtX2dtZW1fZmlsZW1hcF9hZGRfZm9saW8oc3RydWN0IGFkZHJlc3Nfc3BhY2Ug
Km1hcHBpbmcsDQo+ICAgKi8NCj4gIHN0YXRpYyBzdHJ1Y3QgZm9saW8gKmt2bV9nbWVtX2dldF9m
b2xpbyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBwZ29mZl90IGluZGV4KQ0KPiAgew0KPiArCXNpemVf
dCBhbGxvY2F0ZWRfc2l6ZTsNCj4gIAlzdHJ1Y3QgZm9saW8gKmZvbGlvOw0KPiArCXBnb2ZmX3Qg
aW5kZXhfZmxvb3I7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgcmVwZWF0Og0KPiBAQCAtNTgxLDgg
KzU4MSwxMCBAQCBzdGF0aWMgc3RydWN0IGZvbGlvICprdm1fZ21lbV9nZXRfZm9saW8oc3RydWN0
IGlub2RlICppbm9kZSwgcGdvZmZfdCBpbmRleCkNCj4gIAkJCXJldHVybiBFUlJfUFRSKHJldCk7
DQo+ICAJCX0NCj4gIAl9DQo+ICsJYWxsb2NhdGVkX3NpemUgPSBmb2xpb19zaXplKGZvbGlvKTsN
Cj4gIA0KPiAtCXJldCA9IGt2bV9nbWVtX2ZpbGVtYXBfYWRkX2ZvbGlvKGlub2RlLT5pX21hcHBp
bmcsIGZvbGlvLCBpbmRleCk7DQo+ICsJaW5kZXhfZmxvb3IgPSByb3VuZF9kb3duKGluZGV4LCBm
b2xpb19ucl9wYWdlcyhmb2xpbykpOw0KPiArCXJldCA9IGt2bV9nbWVtX2ZpbGVtYXBfYWRkX2Zv
bGlvKGlub2RlLT5pX21hcHBpbmcsIGZvbGlvLCBpbmRleF9mbG9vcik7DQo+ICAJaWYgKHJldCkg
ew0KPiAgCQlmb2xpb19wdXQoZm9saW8pOw0KPiAgDQo+IEBAIC01OTgsNyArNjAwLDE3IEBAIHN0
YXRpYyBzdHJ1Y3QgZm9saW8gKmt2bV9nbWVtX2dldF9mb2xpbyhzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBwZ29mZl90IGluZGV4KQ0KPiAgCQlyZXR1cm4gRVJSX1BUUihyZXQpOw0KPiAgCX0NCj4gIA0K
PiAtCV9fZm9saW9fc2V0X2xvY2tlZChmb2xpbyk7DQo+ICsJc3Bpbl9sb2NrKCZpbm9kZS0+aV9s
b2NrKTsNCj4gKwlpbm9kZS0+aV9ibG9ja3MgKz0gYWxsb2NhdGVkX3NpemUgLyA1MTI7DQo+ICsJ
c3Bpbl91bmxvY2soJmlub2RlLT5pX2xvY2spOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBmb2xpbyBp
cyB0aGUgb25lIHRoYXQgaXMgYWxsb2NhdGVkLCB0aGlzIGdldHMgdGhlIGZvbGlvIGF0IHRoZQ0K
PiArCSAqIHJlcXVlc3RlZCBpbmRleC4NCj4gKwkgKi8NCj4gKwlmb2xpbyA9IHBhZ2VfZm9saW8o
Zm9saW9fZmlsZV9wYWdlKGZvbGlvLCBpbmRleCkpOw0KPiArCWZvbGlvX2xvY2soZm9saW8pOw0K
PiArDQo+ICAJcmV0dXJuIGZvbGlvOw0KPiAgfQ0KPiAgDQo+IEBAIC03MzYsNiArNzQ4LDkyIEBA
IHN0YXRpYyB2b2lkIGt2bV9nbWVtX3RydW5jYXRlX2lub2RlX2FsaWduZWRfcGFnZXMoc3RydWN0
IGlub2RlICppbm9kZSwNCj4gIAlzcGluX3VubG9jaygmaW5vZGUtPmlfbG9jayk7DQo+ICB9DQo+
ICANCj4gKy8qKg0KPiArICoga3ZtX2dtZW1femVyb19yYW5nZSgpIC0gWmVyb2VzIGFsbCBzdWIt
cGFnZXMgaW4gcmFuZ2UgW0BzdGFydCwgQGVuZCkuDQo+ICsgKg0KPiArICogQG1hcHBpbmc6IHRo
ZSBmaWxlbWFwIHRvIHJlbW92ZSB0aGlzIHJhbmdlIGZyb20uDQo+ICsgKiBAc3RhcnQ6IGluZGV4
IGluIGZpbGVtYXAgZm9yIHN0YXJ0IG9mIHJhbmdlIChpbmNsdXNpdmUpLg0KPiArICogQGVuZDog
aW5kZXggaW4gZmlsZW1hcCBmb3IgZW5kIG9mIHJhbmdlIChleGNsdXNpdmUpLg0KPiArICoNCj4g
KyAqIFRoZSBwYWdlcyBpbiByYW5nZSBtYXkgYmUgc3BsaXQuIHRydW5jYXRlX2lub2RlX3BhZ2Vz
X3JhbmdlKCkgaXNuJ3QgdGhlIHJpZ2h0DQo+ICsgKiBmdW5jdGlvbiBiZWNhdXNlIGl0IHJlbW92
ZXMgcGFnZXMgZnJvbSB0aGUgcGFnZSBjYWNoZTsgdGhpcyBmdW5jdGlvbiBvbmx5DQo+ICsgKiB6
ZXJvZXMgdGhlIHBhZ2VzLg0KPiArICovDQo+ICtzdGF0aWMgdm9pZCBrdm1fZ21lbV96ZXJvX3Jh
bmdlKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KPiArCQkJCXBnb2ZmX3Qgc3RhcnQs
IHBnb2ZmX3QgZW5kKQ0KPiArew0KPiArCXN0cnVjdCBmb2xpb19iYXRjaCBmYmF0Y2g7DQo+ICsN
Cj4gKwlmb2xpb19iYXRjaF9pbml0KCZmYmF0Y2gpOw0KPiArCXdoaWxlIChmaWxlbWFwX2dldF9m
b2xpb3MobWFwcGluZywgJnN0YXJ0LCBlbmQgLSAxLCAmZmJhdGNoKSkgew0KPiArCQl1bnNpZ25l
ZCBpbnQgaTsNCj4gKw0KPiArCQlmb3IgKGkgPSAwOyBpIDwgZm9saW9fYmF0Y2hfY291bnQoJmZi
YXRjaCk7ICsraSkgew0KPiArCQkJc3RydWN0IGZvbGlvICpmOw0KPiArCQkJc2l6ZV90IG5yX2J5
dGVzOw0KPiArDQo+ICsJCQlmID0gZmJhdGNoLmZvbGlvc1tpXTsNCj4gKwkJCW5yX2J5dGVzID0g
b2Zmc2V0X2luX2ZvbGlvKGYsIGVuZCA8PCBQQUdFX1NISUZUKTsNCj4gKwkJCWlmIChucl9ieXRl
cyA9PSAwKQ0KPiArCQkJCW5yX2J5dGVzID0gZm9saW9fc2l6ZShmKTsNCj4gKw0KPiArCQkJZm9s
aW9femVyb19zZWdtZW50KGYsIDAsIG5yX2J5dGVzKTsNCj4gKwkJfQ0KPiArDQo+ICsJCWZvbGlv
X2JhdGNoX3JlbGVhc2UoJmZiYXRjaCk7DQo+ICsJCWNvbmRfcmVzY2hlZCgpOw0KPiArCX0NCj4g
K30NCj4gKw0KPiArLyoqDQo+ICsgKiBrdm1fZ21lbV90cnVuY2F0ZV9pbm9kZV9yYW5nZSgpIC0g
VHJ1bmNhdGUgcGFnZXMgaW4gcmFuZ2UgW0Bsc3RhcnQsIEBsZW5kKS4NCj4gKyAqDQo+ICsgKiBA
aW5vZGU6IGlub2RlIHRvIHRydW5jYXRlIGZyb20uDQo+ICsgKiBAbHN0YXJ0OiBvZmZzZXQgaW4g
aW5vZGUgZm9yIHN0YXJ0IG9mIHJhbmdlIChpbmNsdXNpdmUpLg0KPiArICogQGxlbmQ6IG9mZnNl
dCBpbiBpbm9kZSBmb3IgZW5kIG9mIHJhbmdlIChleGNsdXNpdmUpLg0KPiArICoNCj4gKyAqIFJl
bW92ZXMgZnVsbCAoaHVnZSlwYWdlcyBmcm9tIHRoZSBmaWxlbWFwIGFuZCB6ZXJvaW5nIGluY29t
cGxldGUNCj4gKyAqIChodWdlKXBhZ2VzLiBUaGUgcGFnZXMgaW4gdGhlIHJhbmdlIG1heSBiZSBz
cGxpdC4NCj4gKyAqLw0KPiArc3RhdGljIHZvaWQga3ZtX2dtZW1fdHJ1bmNhdGVfaW5vZGVfcmFu
Z2Uoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IGxzdGFydCwNCj4gKwkJCQkJICBsb2ZmX3Qg
bGVuZCkNCj4gK3sNCj4gKwlwZ29mZl90IGZ1bGxfaHBhZ2Vfc3RhcnQ7DQo+ICsJc2l6ZV90IG5y
X3Blcl9odWdlX3BhZ2U7DQo+ICsJcGdvZmZfdCBmdWxsX2hwYWdlX2VuZDsNCj4gKwlzaXplX3Qg
bnJfcGFnZXM7DQo+ICsJcGdvZmZfdCBzdGFydDsNCj4gKwlwZ29mZl90IGVuZDsNCj4gKwl2b2lk
ICpwcml2Ow0KPiArDQo+ICsJcHJpdiA9IGt2bV9nbWVtX2FsbG9jYXRvcl9wcml2YXRlKGlub2Rl
KTsNCj4gKwlucl9wZXJfaHVnZV9wYWdlID0ga3ZtX2dtZW1fYWxsb2NhdG9yX29wcyhpbm9kZSkt
Pm5yX3BhZ2VzX2luX2ZvbGlvKHByaXYpOw0KPiArDQo+ICsJc3RhcnQgPSBsc3RhcnQgPj4gUEFH
RV9TSElGVDsNCj4gKwllbmQgPSBtaW4obGVuZCwgaV9zaXplX3JlYWQoaW5vZGUpKSA+PiBQQUdF
X1NISUZUOw0KPiArDQo+ICsJZnVsbF9ocGFnZV9zdGFydCA9IHJvdW5kX3VwKHN0YXJ0LCBucl9w
ZXJfaHVnZV9wYWdlKTsNCj4gKwlmdWxsX2hwYWdlX2VuZCA9IHJvdW5kX2Rvd24oZW5kLCBucl9w
ZXJfaHVnZV9wYWdlKTsNCg0KSSB0aGluayBpdCdzIHN1cHBvc2VkIHRvIHplcm8gdGhlIHN0YXJ0
IGF0IGEgYnl0ZSBncmFudWxhcml0eS4NCg0KPiArDQo+ICsJaWYgKHN0YXJ0IDwgZnVsbF9ocGFn
ZV9zdGFydCkgew0KPiArCQlwZ29mZl90IHplcm9fZW5kID0gbWluKGZ1bGxfaHBhZ2Vfc3RhcnQs
IGVuZCk7DQo+ICsNCj4gKwkJa3ZtX2dtZW1femVyb19yYW5nZShpbm9kZS0+aV9tYXBwaW5nLCBz
dGFydCwgemVyb19lbmQpOw0KPiArCX0NCj4gKw0KPiArCWlmIChmdWxsX2hwYWdlX2VuZCA+IGZ1
bGxfaHBhZ2Vfc3RhcnQpIHsNCj4gKwkJbnJfcGFnZXMgPSBmdWxsX2hwYWdlX2VuZCAtIGZ1bGxf
aHBhZ2Vfc3RhcnQ7DQo+ICsJCWt2bV9nbWVtX3RydW5jYXRlX2lub2RlX2FsaWduZWRfcGFnZXMo
aW5vZGUsIGZ1bGxfaHBhZ2Vfc3RhcnQsDQo+ICsJCQkJCQkgICAgICBucl9wYWdlcyk7DQo+ICsJ
fQ0KPiArDQo+ICsJaWYgKGVuZCA+IGZ1bGxfaHBhZ2VfZW5kICYmIGVuZCA+IGZ1bGxfaHBhZ2Vf
c3RhcnQpIHsNCj4gKwkJcGdvZmZfdCB6ZXJvX3N0YXJ0ID0gbWF4KGZ1bGxfaHBhZ2VfZW5kLCBz
dGFydCk7DQoNClRoaXMgaXMgd2VpcmQuIENvdWxkIGl0IGp1c3Qgcm91bmQgdXAgYGVuZGAsIHRo
ZW4gY2hlY2sgaXQgYW5kIHVzZSBpdCBpbnN0ZWFkPw0KDQo+ICsNCj4gKwkJa3ZtX2dtZW1femVy
b19yYW5nZShpbm9kZS0+aV9tYXBwaW5nLCB6ZXJvX3N0YXJ0LCBlbmQpOw0KPiArCX0NCj4gK30N
Cj4gKw0KPiAgc3RhdGljIGxvbmcga3ZtX2dtZW1fcHVuY2hfaG9sZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBsb2ZmX3Qgb2Zmc2V0LCBsb2ZmX3QgbGVuKQ0KPiAgew0KPiAgCXN0cnVjdCBsaXN0X2hl
YWQgKmdtZW1fbGlzdCA9ICZpbm9kZS0+aV9tYXBwaW5nLT5pX3ByaXZhdGVfbGlzdDsNCj4gQEAg
LTc1Miw3ICs4NTAsMTIgQEAgc3RhdGljIGxvbmcga3ZtX2dtZW1fcHVuY2hfaG9sZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBsb2ZmX3Qgb2Zmc2V0LCBsb2ZmX3QgbGVuKQ0KPiAgCWxpc3RfZm9yX2Vh
Y2hfZW50cnkoZ21lbSwgZ21lbV9saXN0LCBlbnRyeSkNCj4gIAkJa3ZtX2dtZW1faW52YWxpZGF0
ZV9iZWdpbihnbWVtLCBzdGFydCwgZW5kKTsNCj4gIA0KPiAtCXRydW5jYXRlX2lub2RlX3BhZ2Vz
X3JhbmdlKGlub2RlLT5pX21hcHBpbmcsIG9mZnNldCwgb2Zmc2V0ICsgbGVuIC0gMSk7DQo+ICsJ
aWYgKGt2bV9nbWVtX2hhc19jdXN0b21fYWxsb2NhdG9yKGlub2RlKSkgew0KPiArCQlrdm1fZ21l
bV90cnVuY2F0ZV9pbm9kZV9yYW5nZShpbm9kZSwgb2Zmc2V0LCBvZmZzZXQgKyBsZW4pOw0KPiAr
CX0gZWxzZSB7DQo+ICsJCS8qIFBhZ2Ugc2l6ZSBpcyBQQUdFX1NJWkUsIHNvIHVzZSBvcHRpbWl6
ZWQgdHJ1bmNhdGlvbiBmdW5jdGlvbi4gKi8NCj4gKwkJdHJ1bmNhdGVfaW5vZGVfcGFnZXNfcmFu
Z2UoaW5vZGUtPmlfbWFwcGluZywgb2Zmc2V0LCBvZmZzZXQgKyBsZW4gLSAxKTsNCj4gKwl9DQo+
ICANCj4gIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGdtZW0sIGdtZW1fbGlzdCwgZW50cnkpDQo+ICAJ
CWt2bV9nbWVtX2ludmFsaWRhdGVfZW5kKGdtZW0sIHN0YXJ0LCBlbmQpOw0KPiBAQCAtNzc2LDYg
Kzg3OSwxNiBAQCBzdGF0aWMgbG9uZyBrdm1fZ21lbV9hbGxvY2F0ZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBsb2ZmX3Qgb2Zmc2V0LCBsb2ZmX3QgbGVuKQ0KPiAgDQo+ICAJc3RhcnQgPSBvZmZzZXQg
Pj4gUEFHRV9TSElGVDsNCj4gIAllbmQgPSAob2Zmc2V0ICsgbGVuKSA+PiBQQUdFX1NISUZUOw0K
PiArCWlmIChrdm1fZ21lbV9oYXNfY3VzdG9tX2FsbG9jYXRvcihpbm9kZSkpIHsNCj4gKwkJc2l6
ZV90IG5yX3BhZ2VzOw0KPiArCQl2b2lkICpwOw0KPiArDQo+ICsJCXAgPSBrdm1fZ21lbV9hbGxv
Y2F0b3JfcHJpdmF0ZShpbm9kZSk7DQo+ICsJCW5yX3BhZ2VzID0ga3ZtX2dtZW1fYWxsb2NhdG9y
X29wcyhpbm9kZSktPm5yX3BhZ2VzX2luX2ZvbGlvKHApOw0KPiArDQo+ICsJCXN0YXJ0ID0gcm91
bmRfZG93bihzdGFydCwgbnJfcGFnZXMpOw0KPiArCQllbmQgPSByb3VuZF9kb3duKGVuZCwgbnJf
cGFnZXMpOw0KPiArCX0NCj4gIA0KPiAgCXIgPSAwOw0KPiAgCWZvciAoaW5kZXggPSBzdGFydDsg
aW5kZXggPCBlbmQ7ICkgew0KPiBAQCAtMTU3MCw3ICsxNjgzLDcgQEAgc3RhdGljIHN0cnVjdCBm
b2xpbyAqX19rdm1fZ21lbV9nZXRfcGZuKHN0cnVjdCBmaWxlICpmaWxlLA0KPiAgDQo+ICAJKnBm
biA9IGZvbGlvX2ZpbGVfcGZuKGZvbGlvLCBpbmRleCk7DQo+ICAJaWYgKG1heF9vcmRlcikNCj4g
LQkJKm1heF9vcmRlciA9IDA7DQo+ICsJCSptYXhfb3JkZXIgPSBmb2xpb19vcmRlcihmb2xpbyk7
DQoNCllvdSBtaWdodCBiZSBhYmxlIHRvIGhhdmUgYSBzZXBhcmF0ZSBwYXRjaCB0aGF0IG1ha2Vz
IGV4aXN0aW5nIGNvZGUgd29yayB3aXRoDQpsYXJnZXIgZm9saW8gc2l6ZXMuIFRoZW4gYWRkIGlu
IHRoZSBjdXN0b20gYWxsb2NhdG9yL3RydW5jYXRvciBiaXRzIGluIGFub3RoZXINCm9uZS4NCg0K
PiAgDQo+ICAJKmlzX3ByZXBhcmVkID0gZm9saW9fdGVzdF91cHRvZGF0ZShmb2xpbyk7DQo+ICAJ
cmV0dXJuIGZvbGlvOw0KPiBAQCAtMTU5Nyw4ICsxNzEwLDE1IEBAIGludCBrdm1fZ21lbV9nZXRf
cGZuKHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2bV9tZW1vcnlfc2xvdCAqc2xvdCwNCj4gIAkJ
Z290byBvdXQ7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKCFpc19wcmVwYXJlZCkNCj4gLQkJciA9IGt2
bV9nbWVtX3ByZXBhcmVfZm9saW8oa3ZtLCBzbG90LCBnZm4sIGZvbGlvKTsNCj4gKwlpZiAoIWlz
X3ByZXBhcmVkKSB7DQo+ICsJCS8qDQo+ICsJCSAqIFVzZSB0aGUgc2FtZSBhZGRyZXNzIGFzIGh1
Z2V0bGIgZm9yIHplcm9pbmcgcHJpdmF0ZSBwYWdlcw0KPiArCQkgKiB0aGF0IHdvbid0IGJlIG1h
cHBlZCB0byB1c2Vyc3BhY2UgYW55d2F5Lg0KPiArCQkgKi8NCj4gKwkJdW5zaWduZWQgbG9uZyBh
ZGRyX2hpbnQgPSBmb2xpby0+aW5kZXggPDwgUEFHRV9TSElGVDsNCg0KVGhpcyBjb3VsZCB1c2Ug
c29tZSBtb3JlIGV4cGxhbmF0aW9uLg0KDQo+ICsNCj4gKwkJciA9IGt2bV9nbWVtX3ByZXBhcmVf
Zm9saW8oa3ZtLCBzbG90LCBnZm4sIGZvbGlvLCBhZGRyX2hpbnQpOw0KPiArCX0NCj4gIA0KPiAg
CWZvbGlvX3VubG9jayhmb2xpbyk7DQo+ICANCg0K

