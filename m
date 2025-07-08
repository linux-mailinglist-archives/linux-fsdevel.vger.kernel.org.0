Return-Path: <linux-fsdevel+bounces-54292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4018AFD631
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 20:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50DB3AB640
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF36D2E54B5;
	Tue,  8 Jul 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFPSTxzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487451E9B2D;
	Tue,  8 Jul 2025 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998413; cv=fail; b=o5ZqalBQ7Z6JTbOjuu/xxRn1aiJ3LJYOFz2WGdFGcia5NAO/6dNpGlnHEYzlVf+YBnfMY+QhevFAcJ7EDqYqEatKW544KRP78FHq7V7MVAvPLtwCdj0Vhvb8tN3w8462jE/mWjbZgYk4dtLhbd4hGU7ooEUuyK+CdxgqJTTGzyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998413; c=relaxed/simple;
	bh=GGNARcGeyEVf7lmgeCkX0nzTDH1YAcaU2xu1MN5JDp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kky7qL63Qyv2bB5X+yPVdly2Algo88G+11Pj+dHfoGmEFknvUxP/sspbrGXjsN+PnjVnzQISrZ6syRXoOvbjrM+L1H+BvEyqQ7BZrEVAhhktCFFXeKUnBClCiLXYwdIx6EX8I5033FdlGoChSD0lQ9bDbc2srefC8PGCe/FIYEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFPSTxzp; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751998412; x=1783534412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GGNARcGeyEVf7lmgeCkX0nzTDH1YAcaU2xu1MN5JDp0=;
  b=lFPSTxzpJKn4TirfODn7xoksS5HZ/M18qOb6SVVGjRqc240rGhLWzVXu
   gjTX6Zgw656OCdrzZlXT/i11aUvASqw4M5Tors49/ACs9A5srTJxLWMgl
   sbVu7QbFZ+AZpaQv1+I+yzUi9epHCN8XsJlQ6eOhawrsKKOAFt4mWGeYB
   33VlJQ+NXCRWEMXp7fJ3MeToGCB+G6zjH4P3ohhj+eRFh9jUnNsK1tvgE
   xZtuwOCNz5plNoBrOXwTTEYeoZSEF0IVoXNm9zyj1ztDroymQoxA4IBQI
   GGECSr5F4pINfdHJCDov5lbt1N2PyQVEjtIakisNrjNhkDrwfsHEzgBQc
   Q==;
X-CSE-ConnectionGUID: XNdB1fWnRISvxrpEree2Lg==
X-CSE-MsgGUID: Re6lGETpTZCFkJFGl7GdLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64499361"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="64499361"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 11:13:31 -0700
X-CSE-ConnectionGUID: ZfCxy24YRLqNp0TzDdPZdw==
X-CSE-MsgGUID: TyjRWFbXQ/S/o9NcICyLWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="154979442"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 11:13:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 11:13:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 11:13:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 11:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzD1IqUsCgY5LaErRWmxp4SkgRgRSlA+dl9tp9AXYxLgsUJOiFQukmgD+n0vvNYs2jMtv0Yp0L/qNqHUC4EYsHWx0KRMf3hK4aDnQRNv0qt4dte5d0ylxXFxCh5rA43eoy+LVvBt/YbocJKefFvGazE5TY6TlEscHg/sn5ECmgrcSbK5BBFkDc8UiIDbufRKYiS6UwGtKZzCPzKEHpCa9bMLzh9UvX88S/xMQFPXOA8/X3o6rzQHzgWDB8QI3ldB1nbW3oouw0cvcWgD1LQQXAXmApYYFNnuoS8XAIODMAJAxf8xvHlbfP3l7J57qW124jjM726+7ncECq35A/a2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGNARcGeyEVf7lmgeCkX0nzTDH1YAcaU2xu1MN5JDp0=;
 b=gd4puZObE4NHx6Mpy2fgFRGGYseKW2CpxiGfgOgtj86+MgY5HcICS6xptXFW/w2f2F86uHGhnzqgWo5FNcNrDdGR25UV2GY+KIVoPzkkO2LYUQ90si+7I94YQ19glXuzAabHV3qSe8BtwrKiw/VbL8qZZoLinEmrtPCo3q56O7Ih7W3kYAk7LMsvr620EKUIk8Vk+3POFrhrrgm40zSt7jSx6XHF6EYQtV8o9ctFzArppldH2i1E/MwopEFmpUmb5AefxU80VfTNBLKYIgA9OpuUgbCqR6S0V8N/n/wca5TnhPAQhWXAfyiCMMcbCJmTAXuWOx3VGHK7uMp68tOz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB8356.namprd11.prod.outlook.com (2603:10b6:208:486::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 18:13:04 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 18:13:04 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org"
	<x86@kernel.org>, "amoorthy@google.com" <amoorthy@google.com>,
	"tabba@google.com" <tabba@google.com>, "quic_svaddagi@quicinc.com"
	<quic_svaddagi@quicinc.com>, "maz@kernel.org" <maz@kernel.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "Annapurve, Vishal" <vannapurve@google.com>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "Wang, Wei W"
	<wei.w.wang@intel.com>, "Du, Fan" <fan.du@intel.com>, "Wieczor-Retman,
 Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "fvdl@google.com"
	<fvdl@google.com>, "jack@suse.cz" <jack@suse.cz>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>,
	"willy@infradead.org" <willy@infradead.org>, "steven.price@arm.com"
	<steven.price@arm.com>, "anup@brainfault.org" <anup@brainfault.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "keirf@google.com"
	<keirf@google.com>, "mic@digikod.net" <mic@digikod.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nsaenz@amazon.es" <nsaenz@amazon.es>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com"
	<rientjes@google.com>, "Aktas, Erdem" <erdemaktas@google.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "david@redhat.com"
	<david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hughd@google.com"
	<hughd@google.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Xu, Haibo1"
	<haibo1.xu@intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "quic_pheragu@quicinc.com"
	<quic_pheragu@quicinc.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"bfoster@redhat.com" <bfoster@redhat.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, "Graf, Alexander"
	<graf@amazon.com>, "nikunj@amd.com" <nikunj@amd.com>,
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
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrQKWaYAgAAM4gCAEFZTAIAAkwSAgAC4SICAAP4mgIAA8aaAgAmqgQCAAA20gIAADwOAgADddQCAAAjqgIAABCOAgAAGpoCAAB1VAIAABn+AgAAGtgCAAAKygA==
Date: Tue, 8 Jul 2025 18:13:04 +0000
Message-ID: <5decd42b3239d665d5e6c5c23e58c16c86488ca8.camel@intel.com>
References: <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
	 <aGxXWvZCfhNaWISY@google.com>
	 <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
	 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
	 <aG0pNijVpl0czqXu@google.com>
	 <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
	 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
	 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
	 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
	 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
	 <aG1dbD2Xnpi_Cqf_@google.com>
In-Reply-To: <aG1dbD2Xnpi_Cqf_@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB8356:EE_
x-ms-office365-filtering-correlation-id: 51388584-a646-4357-5ee3-08ddbe4b155e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZEN2TVF5U3RsWlJpUGhDV0ZqUmNQVVdBQXFQY3pvWFNQU1RxVll1TFczNFVG?=
 =?utf-8?B?Z2VKUUVNRVIveWpUUUFyNmxESFRSS1lyVGthbThoaGxHRTA3ZzFQWWV0b1RE?=
 =?utf-8?B?MjZZcVUwSnhTSTNLVXBxcEpSMTdSYzQ1M1poZWMyRlRjdUhlRVJUWTRwaVUv?=
 =?utf-8?B?SWxJdVZxdENXOUxVUFBsUXVIRVhLM1JkNlVob2F0VHBqUnFRa0xRcGNtMm1T?=
 =?utf-8?B?OXdPNGVOR1p6NFNTaEdsYkZEMmhZeThlcWhrS2VQaEtvbzgyMWlBRkxSTElt?=
 =?utf-8?B?N2NvOUNqYWNENU1KTW8wcjRNWFRnSGVsNHIxT3VsZW5OMFBZQnNoUEtDVnlN?=
 =?utf-8?B?dGc2czU0N0k5M2hrS0c3ay9KV1lHa0g0RE5XWGh0WGwwbHRINlo2QWgwSVZZ?=
 =?utf-8?B?UlI3bGs3UVltaDlTb1QvR09pV3E0ZWlsREU4R1E0RW13OUIyblIvMnRRTU1W?=
 =?utf-8?B?Rm4xR0JpdTdJd0p1b3JJNU9XNVREa3VUbXJ3MDdFQnNIdXRhOEpiWGlscHQ5?=
 =?utf-8?B?Q0ZpUlNQU2JuTDNheW1lNFVQa0phNHhxNHppY0EyQ2FzK3J2U0hpWnBJMTZa?=
 =?utf-8?B?YVd3RnNqQ3JwNHJoMy84S0JLY1Y2aTV3amwyY2w0anl1VEh3VGQyR1ZmWmlq?=
 =?utf-8?B?M1haVVl1V25EbkpQemtFL2dyWEVZaEtmeFhSTVRXaUt1bmphajYwVFF0dENm?=
 =?utf-8?B?SnR1WlY2SnEyZTRJeHEwZmgzVkkyd0xZYzZlS1RTN0ZOV1VZd3JkZWJ5alZJ?=
 =?utf-8?B?ZXZMOXFramJJUFkwNjRIUXBEMFErMFFXQXlNUDVqVVN4RjA3cjljSUdwODUy?=
 =?utf-8?B?Q0MrcjRhV04rbVhkZlZ4TTdpZVFOV1FHdEdUdHNodmswL0ZyWHlnSHJCcEtv?=
 =?utf-8?B?L0QrQ2dRblo1VTY5dFEvRjdjdEZ5RzRwQXlpVGpWVm9tbGcvZWdqa09CR3c1?=
 =?utf-8?B?eERydGp0aWg3MDBjSUx5TDJ4VVBBWWdPNlBJcytMRUlRT1hXZ0hwVStYRjNj?=
 =?utf-8?B?QjMzVXpnMjNpOUhVeTMxOFU1UWN1VWF1bTJHKy9MS1lxMU5WNzdzOHA5Qmor?=
 =?utf-8?B?MDFrVGR1alRyeVVGWGdYcWlKZVAxSndQM0ZmTDBOM3pKLzVYN3Zzcmk2KzF1?=
 =?utf-8?B?QUZUZ3JuUS9NTWZZZi9Ea3NsRjRpZWFoOHk1Q01xRHRaOGxjK2w5ZnV3Z3R2?=
 =?utf-8?B?TkhlajQrS3l5TkhGazlGVGdhdC9iQlR4S25oN1dENWdJanQrN3ExVytyaWE2?=
 =?utf-8?B?djNZNVBOQ21IK21uZ1NGQnNJU0NLZXB4R1pDNy9mSnFBMVplU29CeGxpRHFy?=
 =?utf-8?B?TWt6S0FvWVBTbFZyWTFYWXBDTytiWTVjU2FtN0EyVWJlMTNKSGdpL0hCQ0lr?=
 =?utf-8?B?bjdxRjZZQ2dMS0ZSakwrV2F2enRvb2F5ZEJRQkc4ZkRXSFV0dUdmS3NPQUdu?=
 =?utf-8?B?WFg3RWxIekR6TjRsTnBGNDhDQnFWbmZEMVZyLzlkSCtVLzVvQlQ3NVorZHpp?=
 =?utf-8?B?QWVmczRCMUZ6ekZjS0RLbVEvMFNob3liWk5DZk85Yzd1TVppWjlHUTB5U0Vk?=
 =?utf-8?B?SmpGSk1iOTkzc1JFcnFZLzk3WHdmSENuOW8zVzNOSE5mZXk5bGZMYVpDZkRq?=
 =?utf-8?B?VW0yYm5qRUROUEtUR2hwQjhJUjNmTjZGa090Q0wyWXRSNVgyZXlYYjM0SUxx?=
 =?utf-8?B?MDdGci9OMXpGMVlmSG9EcGV4ZnpuNDBnSXdEeEVhWE1ycFdweGRPVFhyY3V6?=
 =?utf-8?B?TnJUUW5KVFVmaFRNL3JkL1RKaE9RM2VOV0diOVJ5cjNueDFLbmoxVEtLL3N6?=
 =?utf-8?B?djYyYzkwamZpb3ZWK2tCWGY3aDlDdEFJclZ4S1E5QVNTd3kyNm5hOWh1NG1p?=
 =?utf-8?B?bWs2WEFZRTM5N2NWTDYxUkRrUVQ2WlRBb1kxVnFkMFM1ZkhyK3NMSTBQNGJS?=
 =?utf-8?B?MVBpN1FGSHRwRk1uL296RGN2d2xEMVBXbld0cEdZa0hPQ0U3cWljOXdtRXpW?=
 =?utf-8?Q?tPbjZhTdg58hyCvHDw8HY/7dIalnxI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjhtOWpvYXNueWNpYWRPdkZ3d04xS2tZV1JoaGFEd3NTM2pHbWdwYVpHS0tt?=
 =?utf-8?B?eGxDQkRZaXRvQVVNZStISDNySEhXR2VWbWllYjYySHphS2RnZGVHV0ltOE01?=
 =?utf-8?B?QVVtTlFQK2xhd0tDMzVjZVlTeHQ4bDJWWVJtODd3THpVM0hzZWJvM3JVRFVh?=
 =?utf-8?B?V1VqV0dFN1BPc3FoOGxpNER3a2RCY1FmcmdoRU9ZRm84UG9ac21RdElaR3pu?=
 =?utf-8?B?VEdCa3pXUkZWWkFwcTQxZHl5aGhPOG1tOFRqTHdVemFkK2JkKzJRaWhUZHhm?=
 =?utf-8?B?M2c1WXNXc3dUdXlGdWV6SGlkWUFGQUdvVEY3WXQvMkYycWI2U2x0TWxaaTNV?=
 =?utf-8?B?cVdmVzBJby92YWJZMjBFRzN2L1psLzBseEljWTk4aHRBNXlWalVOSUFLbG5x?=
 =?utf-8?B?YVg5M1JjUEJWV21XOW1qRkxFSnF0ZGlsei8yS1FYeW5KbUZhWWhvWFhOeHJV?=
 =?utf-8?B?UytRbDk5MGlPMnFGdjVQZ1V5VUFGeHdkL2k4YW9qOHNiSWExZ3E0eHpDZ1Yz?=
 =?utf-8?B?U0R1Wkp6MEdFYWQvT3BEaittUTdyODlIQ0RzS25iZFJjaDdWZitMOE9vWVRM?=
 =?utf-8?B?SFRzTmpRdEtMUE1aOGJ3VkFvTUdPUFY0dlM3ZTNyNzN3MWl6bmRTa2U0NHk0?=
 =?utf-8?B?SEtxbjlkaTdPMlU1WEw1cEVrOWF4SzdBUTRMQnBEYmd6QkJ0Uy8yM1hNdnhn?=
 =?utf-8?B?YWNTanNqekdHTVF5MWZpZjd0bHp6SjdsUkJsbTlWbDEvb3QvNzRwVXJMSFFm?=
 =?utf-8?B?RjVBckRBVDl1U29zUkhKTHhHWGo2NnB2aCtTZ3NQemtBQUNhTWRYMWgxODdW?=
 =?utf-8?B?TnNvaDUyU2p2Wm1pTXpQc2xtbnQ5aS91NzRNK1Mvd01nTHVrRDA5TE5kaEhH?=
 =?utf-8?B?Umc5VmFSd2l1aVJ2cXBuUFNTOGZXRzNhdk00MWJCNkloT3NPQW04bUZMMFNz?=
 =?utf-8?B?MFhVcWZ2aytHZ21oTGVIQkl2ZERubE91b3BqQWNzckliY3RDZytvOTg4c2da?=
 =?utf-8?B?WTZSV1Q0MDBielhQendSSVVsOVcxVzV6K0llcTdHQUM2c2R4aVFWUmozSXo2?=
 =?utf-8?B?VnhrU1ZoRFIrbGRnSFZtK0p1Umw1K0phWUx0SGpMWVNKblZOSVFJRVpzNW9z?=
 =?utf-8?B?SWNQbFBkdjlnTXZKTU5aelNWNHdhd1RVNVBKWVRPS2g2Mm8ydFlLSDgwZW1k?=
 =?utf-8?B?L1d6RWJWWVF6ekZpdE9mZWVhaVlxMWZOWW56R2xDQU5wVlU0TlNnL01uMzhH?=
 =?utf-8?B?bS93Tjd5dGFnSFUwZDZ0bHlLRjNnUlB6UTM1VVo5MzBUQjJhOUdyOUhOR0Nt?=
 =?utf-8?B?UG9tdjh0c1duUllqa0NCTVp4K3M1Nm4yM3hvZEJCM0lpUDhDVlpVRGNJUmlI?=
 =?utf-8?B?N0NrN0Z0RVNKdmVuTmo3bWo2aFhJcW5odDNPbFZ2a3FWWkc2Qm9hUGw0UWZP?=
 =?utf-8?B?SzRnTDI1SERFVkRnTDMvVWJVWnArb2Z4VlRyRkpOUUpkSXNMSFJ1UzZMS0pl?=
 =?utf-8?B?VDQwcGtBRE1FNGNTaTM3OC9WeWVmK2ZYR0RwcXJTbGN4alo0THJNNUpYZWhx?=
 =?utf-8?B?TmsvMzdpZ2VZMXJOTTJmUytWd0ZJNFBWNGhHV2dZeEJsRmFRUjlSTThleEx1?=
 =?utf-8?B?bGFaTXFLMmN2Rjh5VVN4MnJNMGhkbjNibVV5UXRMQ3VZUUI5eHN3c3VWUTl2?=
 =?utf-8?B?NHhjSWtJeXozdGtVcjBMZVdCVUpNK2JJU3RZbWpqY0Q2SVVkT29MWTRmQXlF?=
 =?utf-8?B?OGNweUp6bU5yUUtQZllpS3BXdWFWektDRkVEOER5cCtSbUJqa0xrVWVydnd3?=
 =?utf-8?B?SVlKWk1maHp3aHhLek1renYxUXFjQzdJeHdSRzV1RVdKa2xmWDIzOXU3TGZo?=
 =?utf-8?B?MjV6Uk85Ni9FdFJoTFNoMkxZNWdoRFIyMTdjV3g4QjFpaHpqWDBmQjhuYTJq?=
 =?utf-8?B?QkZOOW1oSXF3L1FUenk4dExuSUM0Y0JDcjJvVFBjYnRkOGE0OXJPbWpja2tB?=
 =?utf-8?B?dkVCMHJCekZycndwZVF6M0pjN0tTSnBONlg2dGFsd0lDS2NqcGl5ZmpVb2Q1?=
 =?utf-8?B?MkdxOThRdUFEUWs1Y3Q2Rkh2b1JEZTNTNjRVM1VlN3Z2V0VUbjZLYjdHcVF5?=
 =?utf-8?B?enkyTkp2ODBldUQ3a28xN1R5b0tHTmh3cmt4MEFieWFBcDgvRWlIa25JbEFP?=
 =?utf-8?Q?cKioZpYq5d9jta/SjuHe4h8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FFE59233229F34CB15BB93D07D09440@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51388584-a646-4357-5ee3-08ddbe4b155e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 18:13:04.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dABHdSVpStWbwDb5EsKfLfRoXzTOWU1TpSCAuEBXyoHJzwkf9gh4KSqInk2R+pw+UPFyKz7L+iue+Icqp9/V05IDPGeEe3p05BjM5qIvb18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8356
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA3LTA4IGF0IDExOjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IEkgdGhpbmsgdGhlcmUgaXMgaW50ZXJlc3QgaW4gZGUtY291cGxpbmcgaXQ/DQo+
IA0KPiBObz8NCg0KSSdtIHRhbGtpbmcgYWJvdXQgdGhlIGludHJhLWhvc3QgbWlncmF0aW9uL3Jl
Ym9vdCBvcHRpbWl6YXRpb24gc3R1ZmYuIEFuZCBub3QNCmRvaW5nIGEgZ29vZCBqb2IsIHNvcnJ5
Lg0KDQo+IMKgIEV2ZW4gaWYgd2UgZ2V0IHRvIGEgcG9pbnQgd2hlcmUgbXVsdGlwbGUgZGlzdGlu
Y3QgVk1zIGNhbiBiaW5kIHRvIGEgc2luZ2xlDQo+IGd1ZXN0X21lbWZkLCBlLmcuIGZvciBpbnRl
ci1WTSBzaGFyZWQgbWVtb3J5LCB0aGVyZSB3aWxsIHN0aWxsIG5lZWQgdG8gYmUgYQ0KPiBzb2xl
DQo+IG93bmVyIG9mIHRoZSBtZW1vcnkuwqAgQUZBSUNULCBmdWxseSBkZWNvdXBsaW5nIGd1ZXN0
X21lbWZkIGZyb20gYSBWTSB3b3VsZCBhZGQNCj4gbm9uLXRyaXZpYWwgY29tcGxleGl0eSBmb3Ig
emVybyBwcmFjdGljYWwgYmVuZWZpdC4NCg0KSSdtIHRhbGtpbmcgYWJvdXQgbW92aW5nIGEgZ21l
bSBmZCBiZXR3ZWVuIGRpZmZlcmVudCBWTXMgb3Igc29tZXRoaW5nIHVzaW5nDQpLVk1fTElOS19H
VUVTVF9NRU1GRCBbMF0uIE5vdCBhZHZvY2F0aW5nIHRvIHRyeSB0byBzdXBwb3J0IGl0LiBCdXQg
dHJ5aW5nIHRvDQpmZWVsIG91dCB3aGVyZSB0aGUgY29uY2VwdHMgYXJlIGhlYWRlZC4gSXQga2lu
ZCBvZiBhbGxvd3MgZ21lbSBmZHMgKG9yIGp1c3QNCnRoZWlyIHNvdXJjZSBtZW1vcnk/KSB0byBs
aXZlIGJleW9uZCBhIFZNIGxpZmVjeWNsZS4NCg0KWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9jb3Zlci4xNzQ3MzY4MDkyLmdpdC5hZnJhbmppQGdvb2dsZS5jb20vDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9rdm0vY292ZXIuMTc0OTY3Mjk3OC5naXQuYWZyYW5qaUBnb29nbGUuY29t
Lw0K

