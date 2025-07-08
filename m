Return-Path: <linux-fsdevel+bounces-54288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C71AFD594
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C593AF5F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931182E62D3;
	Tue,  8 Jul 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnKg5FPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A22DECA7;
	Tue,  8 Jul 2025 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996408; cv=fail; b=C4XdsrfdJNgj4KpTSQzvFHw3IWnGwHjcPrHoqils/H1emLJw6yFzuECllJo4hwO5yo/bTrlXYMGM0z5tzgnUoyZAXZRh4QTEyxydRXXYwxV/3VEb0mp3T5lZfU9tQAYbI9LdlY3PVL/lCO+2woF9lTJXjF4yFz2OeKFykSRFwa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996408; c=relaxed/simple;
	bh=pVsOqFw193pVp+UaUr0oN4COi6tZblYVOb/WXLT/JwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L//5GxtghGbjBG856FLMqHUHCsI38guiEFC54t/QSWd2vGjTRcYBeD+57UDeCCaeYOr9mCRwytiM9WIU1vm2NTy0Oc8aVJM74QZxnJS5w4Tclm29+kZQNoHNr/HR9prjmyfWLu9JuxuS3Y5pDg6yTKmgDm8OA/4kMnssUFnzxVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnKg5FPz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751996406; x=1783532406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pVsOqFw193pVp+UaUr0oN4COi6tZblYVOb/WXLT/JwY=;
  b=BnKg5FPz0YSY679cG/OdTwKSMSJwbZK4tugJM0Br+c1V/5DNHMOfIq2M
   Q3pNXghZdy36beNDiCkE/3dTgBTVDgaDIhZ80G/2fN4ilvcuiIONE52Hb
   OlcxqV9ePkoRA7sKe9VeSvRcgCWaHLNHIpDxHZV5VnepsUGlAoZn+XV6y
   gZJ8ogTj0jjoymQAk3hx8cc1G4s263JGDZX2cMj3OCttY0RKVIVXV5Peh
   dHHUFlPKQhuI7+aJTiOBAPE3jgNaXg+PvLK4syLK/hdxJNOPPywGWYebO
   M84WMJ3JabzoDUtd3/34FD+TtpdZoUvZxy2i48ZBYqoOHqyUDcQaakQSZ
   g==;
X-CSE-ConnectionGUID: 5jRV7VRlQbeU7yKp7jmZSw==
X-CSE-MsgGUID: nbW9DH+FTGaOQzea6AyZRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71829631"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="71829631"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 10:40:02 -0700
X-CSE-ConnectionGUID: AitMsSvFQheL8iYC9+ffiQ==
X-CSE-MsgGUID: mIKtNThVSmOMyPn7GKzeig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="156295656"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 10:40:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 10:39:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 10:39:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 10:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI/Y2r3vh3r8vC2TGiNwH9TqYvk5ZxXjGazEUwwx/IobTKNdbHTgjbBaZu+BbSDkaMsZYLgGrC78jsyh9aEowbNjKG6WojTfM5J5DegSWD80nNdPPIMOlgqDmTNUIhIVmXzz+v0AhP7zlu4HxL/w/WRQYhNlnQ32DfhClywd+UZzdonCigmSzfcKUfu48H5oMPI9FvXOjeaqEaO087iaEJTKgq541uYY+I+J6+bUV2FcXCRa8Zt/Uus6qTH6oLzE7F2E9dADf6VcAUpIWK4W8EfgZXKvLmgemb2eIQguViED7TZ8+8DNhQgDFzGRHY1SU0zB3U43JfMuDz8zgJ0O4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVsOqFw193pVp+UaUr0oN4COi6tZblYVOb/WXLT/JwY=;
 b=Zq6CTlDi494a2w9Jxy9PELUpioqe5mm2CevweySVOp/WSQxhfOJb3u7w21pHuUS4tcQyQ1VehfL9SxjoB/jyBcZfWw4lwByhzi48UpHX0vUaUPuCSSMRij+Qg2qfaNS/iUCDH265hC2ltQcc9/pWJdVcgMXyB1879M4dktzzDUyvUEWi/T0PfNDTWpU+as6Z6Y/Ffc8UP6s3IpDcEjZusAZE1A2ZlDrA4IMxmq41aVLfey+4vexVtbCuQqrUeUoIBQd8ov4GoI5v6+s/lQ5zlsp94tGQf1E4cQEX4LUjKo3jFhnYyaf1eiNSnO3wU0gjrPpdMz8iV6+MGHrHEHisrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 17:39:25 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 17:39:25 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>,
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk"
	<pdurrant@amazon.co.uk>, "peterx@redhat.com" <peterx@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "tabba@google.com" <tabba@google.com>,
	"amoorthy@google.com" <amoorthy@google.com>, "quic_svaddagi@quicinc.com"
	<quic_svaddagi@quicinc.com>, "jack@suse.cz" <jack@suse.cz>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "quic_eberman@quicinc.com"
	<quic_eberman@quicinc.com>, "keirf@google.com" <keirf@google.com>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, "Wang, Wei W"
	<wei.w.wang@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"willy@infradead.org" <willy@infradead.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "maz@kernel.org" <maz@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "anup@brainfault.org"
	<anup@brainfault.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mic@digikod.net" <mic@digikod.net>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "Du, Fan" <fan.du@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"steven.price@arm.com" <steven.price@arm.com>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"rientjes@google.com" <rientjes@google.com>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "Aktas, Erdem" <erdemaktas@google.com>,
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"hughd@google.com" <hughd@google.com>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang,
 Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
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
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "hch@infradead.org"
	<hch@infradead.org>, "will@kernel.org" <will@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrQKWaYAgAAM4gCAEFZTAIAAkwSAgAC4SICAAP4mgIAA8aaAgAmqgQCAAA20gIAADwOAgADddQCAAAjqgIAABCOAgAAGpoCAAB1VAIAABn+A
Date: Tue, 8 Jul 2025 17:39:25 +0000
Message-ID: <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
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
	 <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
	 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
	 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
	 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
In-Reply-To: <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB8500:EE_
x-ms-office365-filtering-correlation-id: 39f023d4-1bb5-458b-4d51-08ddbe4661f8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K3E5ajJXR3JhR0xhT1haa3NTWW82Q2dJNmo2ZGowbUFGUTV5L0ppZ2ZwUUhR?=
 =?utf-8?B?MVNrWU1DYU0weXNiMGtPMzdML0I0Q1FOZjlqZFVYRk1QWWVXa1FCdlRsMDdV?=
 =?utf-8?B?S05DYStjR2RwYThlSWJiaXljV2VMLzVKNzcrcloxVVZObDJmSDNiWEx5aitx?=
 =?utf-8?B?b1VtVzR0UWQ2djR6OWVldHhtU2xSZnJTNjc1ZGxMcW5Jamt4MHNVZFNZc3pV?=
 =?utf-8?B?VkthTmpSUWJJQ0JsZXZHenhIdktTQ0cyUjhHQm1qTDR0K25EZXl4UXpZaWNJ?=
 =?utf-8?B?cGp1cFBHSktTbFFtTXg4T25mUTJwTlNqK0xpN1RvVlZZWjNEVGxWL1doVWtr?=
 =?utf-8?B?ZnRUOC9Md296T2c1Nlo0bEhJSVJOYU83MkhNTUlZQkhsZnhoYVN0eW93bjhI?=
 =?utf-8?B?Q1hmTVdsbXZkUGlPL3EvVU85M3B0c3BNTk13dkFLLzRkRnNHTVFWZmh3d2hJ?=
 =?utf-8?B?dDRvMDZPcUVOKzlGc3ZyUm56UTlCM1plR0hxMHhZaVJDR3FnZHFGOC95b3RV?=
 =?utf-8?B?NFdHaEJKOU1mZUFWZnhSYTBqL1RMUjMySEdhQzVvQllGL3UvV2FQVDFiUXJM?=
 =?utf-8?B?MGNCNDcrSDBFaEZHNytHSko4TlJqQUt0Y2hFTFpVL093aG5BSmh2REEwbnNm?=
 =?utf-8?B?QUpCaVBQb1JaSCtzS1Y5N05VYnZzbVI3L3pyT3FqZzVZUmErc3F5RHBWUXJ3?=
 =?utf-8?B?ajg3V2tLUERZMWVHYXUxYkVSekgrNXFmWmhnTmRUaHBycW1BQU9oRlFuV2tV?=
 =?utf-8?B?Y3J3a09QUjZJQVRkRjM4dkVaOVhQK2VjU3pXM3ZiclVONGJ0dnhMUkFSQ2Qr?=
 =?utf-8?B?b1AzVVRBN2w1VjgydllCQm9qK3drK0gzblRtTE1FaFd3NklpMVJWTDk2anVL?=
 =?utf-8?B?cXRvQWc0aUNSZitFZG9sSGZ3cWVpWVNTR3M4TTQ5Wjd3UXJSc2UxTmk1dHIy?=
 =?utf-8?B?TFc4Qnh6VVJmNVNhdCt0ZVpNU0tLKytSSHExT0c0ajlVSzhkQ01zQ2lxeFpp?=
 =?utf-8?B?aDVkTXh5WGxyb21oM283QlhBcUFwVkIvdmF5S2xiM2JVRkhYWWIzTC93MHVv?=
 =?utf-8?B?a2o1ME5aYTcydjcwQ1g0V3JZVmJzVVZTSVg2UDJkSmhvRkxkRVpWWlZkcXM2?=
 =?utf-8?B?blV2L2hYQWttVHUvUThpUGZ2RXhWTStIcHNSSTVqalRMSUlmbXJWZW9pcXor?=
 =?utf-8?B?MTZ4cUJjRTZsTFdUaGs0L2hVc3FXR1NDQUZWYmRDRDlNV1RZZndBZVpNa0Uw?=
 =?utf-8?B?MnJvd0d5dnZCcDRwajE5RnFHUytBV29YdHZhL0NFUExrSy9lYTlwUldGUkpQ?=
 =?utf-8?B?SlQxTE54OEdBSGpmMXdrdkprWFVCR2VwMEhpSXBDaEd3a09hUEtoSGFtZHNT?=
 =?utf-8?B?UTdqaUNuSXAvT2RCL2NUNVlZS1FpbXlTUzgrRGJSM1pHcXp1TmpKV1JFREpI?=
 =?utf-8?B?V0hWNWZETXIveGNvbzBPLzluSFlIa2RsZ20xY3NDdElLN2xJeEFHL0VTcnpl?=
 =?utf-8?B?b1U5UnRQWW5UWHIrdFFJYTBwblBhN2JSSnk3ZU9Gb3hYbWN0SVRyN0NCNHND?=
 =?utf-8?B?MHlJOXlsd1lrSk9hSHNDdWcwSFl4SE5QeHdaVkdpVUxUT3pZQ05qSDRGejdX?=
 =?utf-8?B?WGhkWWQzQUdyOVVRVzRseWhQWmNJMnNYQnBNRE0rLzlwQ3dpOGJBZHRxVTNa?=
 =?utf-8?B?VUlzNTArUlp0WE43SjE3UUt3dlIydkZXdDN0N09GVUtia013TmNxVENyMk9q?=
 =?utf-8?B?TnFWTDBWb2l0L3FKbEs1eEVacjdrU2I1ejFSbVk2dlRxZ2lscmZMWExTSTNJ?=
 =?utf-8?B?UUczeGhXSnNvay9oY3V3bVVjNi9BVDdsRGh6WXVPTVBCdG10R25lVExDOXZX?=
 =?utf-8?B?NFRQajNISEUyUXZYRVlBM2pzWDRrdkthL1laVE5WTHBnMDhpQ09tQ2J6N2xy?=
 =?utf-8?B?SDA5SjE5Ylo2MlBrSWIxcTEzQTdDT2ZtTkVET1JkYmFnZGVPSlRmd1RHUHUw?=
 =?utf-8?B?a25MODgrK29BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djM1R2tLK0YxNTZzMGxvNVgzNm5UOTlzYjU4aFVXZW5GWnIrTllqdWJPYTU1?=
 =?utf-8?B?SlNndFBxTnpucDRhWThlWUhUdmd4TUVkSGkyRUlKVmpKUW1DVHphMlBhYjMr?=
 =?utf-8?B?Y2IwenduclFIN3hlSGdBdGNJT2dOT1BhZWI0NTFBa0hVQWtIUTdLQVRjY1Na?=
 =?utf-8?B?c0UwelFsZmJCTFF4UlJUdWZXTWVkQlRVQmtUTXRkV1N5WnBRSHM5SjNRZW5w?=
 =?utf-8?B?dG45YXU1VWZEejJJM2w2anNCRHBOcVpHVjVJWUVyZDUvY1dpcEQ2eXE4R25a?=
 =?utf-8?B?eXorSkIwOXYwVGF3a1FIbnhUODc4WnN0OE0vbXVmU1g3dmRWdGozRFNuR3Zh?=
 =?utf-8?B?S2R3TmhOMHZzbElqR3lQMFdqZEttM2J4VUthaTA1cm92UWdaQnJnNFhCL3da?=
 =?utf-8?B?dEpnNVJrTDN2YS9UZVo0b1hqWUx3YjNuK1ZNZXM5dEs2eU5NRkdnR1Z0aHA1?=
 =?utf-8?B?SDhRZkV3YjJnWEdhdkgya1dQVmdadGpkWUt6QUVtUzlMRW1FTHkwNTREQnRw?=
 =?utf-8?B?cnpGYm44bnNZbHN1TWFYNk1tN2IrTkg5Yy92UGpuU0dCM1hZNm9mTUpkOXd1?=
 =?utf-8?B?MURYYU9Gck9DQ1U2OUJZaHhnNzlBWmhoRGIrVCtZajc4Ym4vZ1VCTkNTalZk?=
 =?utf-8?B?RFJiMUNqeWM3cGhaVFlNZFFMVFpZSWkrQ1NrcktVck5GeGh6NllaYlBQaFNV?=
 =?utf-8?B?emFJVEQrWmJaQ0c0dmU1RUtPeStFOE1YRmRaaFErVUN4NTd4QlpYMldTaDkw?=
 =?utf-8?B?MWZBOWFXbDkvM2l1N1Qvbzd3WkVMcXRFZW5ZazRtWXI0aUdJYy8zaVJSYXpZ?=
 =?utf-8?B?bi9Kc0doVGpETXE2Q2pMZm9JdUZQSkJkUTZhM2tNa1FsOEFETVJRRXR5Tm16?=
 =?utf-8?B?Qm5rbmkwQ0lZSVNMZStyM29SS0ZoaGl5RUY2WUgxZWpBcFNhWGtLNDRqVlls?=
 =?utf-8?B?V1ZBa3ZJQ0FJVExCZEovQ1hHUDVzbTN3eTA4aGk1UVFycXRtS3Fkc2pVdjFO?=
 =?utf-8?B?VkRQbVhDRWhocTAzZzdGckZxbEhyZkFuYVFXQ0xYTVRLcUg5MXpBWXNZVTZp?=
 =?utf-8?B?Lzh2WVpoTWh6NzZ4MmxrSGNFUjdKSjU0ZFhKYjAvZW5mM3JJN2hISGs1VlR2?=
 =?utf-8?B?ME5EK1k2WDFlNENXZmcrWXRyODNpK3JaL2FPTHR6N3UyNmovK1pDTW9UK2NI?=
 =?utf-8?B?NGtlTnNDZmtsZzFtb0lZSm54S3M2MFliR3ZjS2dBaDIvbmJhMHNuNlM3Wlg5?=
 =?utf-8?B?SjR2NGpiS1JOcFN5QjVYU2FSb3VwdE5wVUw0SnVDa0tRc3I0NXpFRVgrUmha?=
 =?utf-8?B?N1FFL29OdHNUb0cwTVFKY0FIWFJTVC85cTNQcmw1NmFxczZRY3ZYS2xFRVkr?=
 =?utf-8?B?NnRBWDdKOHdTQURYU3ZRNHdIZEczRVkxTGoyZ0hjb2pqblpiMngva2RFeVRY?=
 =?utf-8?B?SzlTMUFqVTkxRE5NdU12QW42UzdhcTdxUldHU2pTd0NjL0JHVjByeTFYNzJN?=
 =?utf-8?B?QVQzUllVRVQ1K1g4VnRKQjdhTnBlMTdvMGRxTTJ2eE5SVm5idlFHMXc4cHFD?=
 =?utf-8?B?SXl2NnJCUzdVQVhDVGc1QXJIemJaZDJBbzN3R1RVZnVaTEVIdmcvRW5oVHg0?=
 =?utf-8?B?SFQrQTlwTVlmN3NRT2NtbHIxOC8ycHo0NEdxbmxDY1BkVjUxdTh3TmQ0bGxN?=
 =?utf-8?B?WEQ0bFl1Mkw4aVROK1VROEROZ0g5YjdkbFpKYzJaaWJML09xZk9rUWwvOEc3?=
 =?utf-8?B?MHpFVGU5V2pITFJTcmdLUi96TWJ2enNLU1RmYlZRYWVQWlRObko0eWVScmp5?=
 =?utf-8?B?eHNmQTRNOWU4NnlmQ3cxWnNyczVpZ2xsRnhmdlBkZE9aSUJDRUhxQ1NFQW1v?=
 =?utf-8?B?aDhJQU9WOUhUVVFiKy8xNFFMOWZpVVZyNUNlS0NvRWpWdFBVR1RmS3Q3SFo0?=
 =?utf-8?B?WnMwV1VpUi9MQTJKa1R6cUVBOUdua20ycWdTS2IrMEM2bnZSTkFLaEROcjVF?=
 =?utf-8?B?Tzc5cXI4MTZqbWRxaEpoRzQzVjlaMTlmL1IrWlJ4SEZGU0hWNEZFcHdzckJx?=
 =?utf-8?B?WU1xYzRhbm5vZEYvRW5EOFhKMTBnQXpmMXY3VkR1VkxzTVdEM1RMUnh1NzNv?=
 =?utf-8?B?MldhVmVKeFBGTHBFZkVPdFk4cGhaejgyanlhcWJiY0xJbjlZZ3I5VDFOM05j?=
 =?utf-8?Q?PXDGeSH3SQRwRP8U/h1q5Bs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A27D26621D7E004AA5E1D2908E2A9492@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f023d4-1bb5-458b-4d51-08ddbe4661f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 17:39:25.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJc+gimyhEe88gnp2nwXx2ajzEvSRu0i+Q7B7sz/YjPIuIGz3VfFBUMXU8/hAO2Q9PCMN3ZcKp0FsmxaIo3zxOJ1E3Uka73sJ9Q0V91Z3u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA3LTA4IGF0IDEwOjE2IC0wNzAwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiA+IFJpZ2h0LCBJIHJlYWQgdGhhdC4gSSBzdGlsbCBkb24ndCBzZWUgd2h5IHBLVk0gbmVl
ZHMgdG8gZG8gbm9ybWFsDQo+ID4gcHJpdmF0ZS9zaGFyZWQNCj4gPiBjb252ZXJzaW9uIGZvciBk
YXRhIHByb3Zpc2lvbmluZy4gVnMgYSBkZWRpY2F0ZWQgb3BlcmF0aW9uL2ZsYWcgdG8gbWFrZSBp
dCBhDQo+ID4gc3BlY2lhbCBjYXNlLg0KPiANCj4gSXQncyBkaWN0YXRlZCBieSBwS1ZNIHVzZWNh
c2VzLCBtZW1vcnkgY29udGVudHMgbmVlZCB0byBiZSBwcmVzZXJ2ZWQNCj4gZm9yIGV2ZXJ5IGNv
bnZlcnNpb24gbm90IGp1c3QgZm9yIGluaXRpYWwgcGF5bG9hZCBwb3B1bGF0aW9uLg0KDQpXZSBh
cmUgd2VpZ2hpbmcgcHJvcy9jb25zIGJldHdlZW46DQogLSBVbmlmeWluZyB0aGlzIHVBQkkgYWNy
b3NzIGFsbCBnbWVtZmQgVk0gdHlwZXMNCiAtIFVzZXJzcGFjZSBmb3Igb25lIFZNIHR5cGUgcGFz
c2luZyBhIGZsYWcgZm9yIGl0J3Mgc3BlY2lhbCBub24tc2hhcmVkIHVzZSBjYXNlDQoNCkkgZG9u
J3Qgc2VlIGhvdyBwYXNzaW5nIGEgZmxhZyBvciBub3QgaXMgZGljdGF0ZWQgYnkgcEtWTSB1c2Ug
Y2FzZS4NCg0KUC5TLiBUaGlzIGRvZXNuJ3QgcmVhbGx5IGltcGFjdCBURFggSSB0aGluay4gRXhj
ZXB0IHRoYXQgVERYIGRldmVsb3BtZW50IG5lZWRzDQp0byB3b3JrIGluIHRoZSBjb2RlIHdpdGhv
dXQgYnVtcGluZyBhbnl0aGluZy4gU28ganVzdCB3aXNoaW5nIHRvIHdvcmsgaW4gY29kZQ0Kd2l0
aCBsZXNzIGNvbmRpdGlvbmFscy4NCg0KPiANCj4gPiANCj4gPiBJJ20gdHJ5aW5nIHRvIHN1Z2dl
c3QgdGhlcmUgY291bGQgYmUgYSBiZW5lZml0IHRvIG1ha2luZyBhbGwgZ21lbSBWTSB0eXBlcw0K
PiA+IGJlaGF2ZSB0aGUgc2FtZS4gSWYgY29udmVyc2lvbnMgYXJlIGFsd2F5cyBjb250ZW50IHBy
ZXNlcnZpbmcgZm9yIHBLVk0sIHdoeQ0KPiA+IGNhbid0IHVzZXJzcGFjZcKgIGFsd2F5cyB1c2Ug
dGhlIG9wZXJhdGlvbiB0aGF0IHNheXMgcHJlc2VydmUgY29udGVudD8gVnMNCj4gPiBjaGFuZ2lu
ZyB0aGUgYmVoYXZpb3Igb2YgdGhlIGNvbW1vbiBvcGVyYXRpb25zPw0KPiANCj4gSSBkb24ndCBz
ZWUgYSBiZW5lZml0IG9mIHVzZXJzcGFjZSBwYXNzaW5nIGEgZmxhZyB0aGF0J3Mga2luZCBvZg0K
PiBkZWZhdWx0IGZvciB0aGUgVk0gdHlwZSAoYXNzdW1pbmcgcEtWTSB3aWxsIHVzZSBhIHNwZWNp
YWwgVk0gdHlwZSkuDQoNClRoZSBiZW5lZml0IGlzIHRoYXQgd2UgZG9uJ3QgbmVlZCB0byBoYXZl
IHNwZWNpYWwgVk0gZGVmYXVsdCBiZWhhdmlvciBmb3INCmdtZW1mZC4gVGhpbmsgYWJvdXQgaWYg
c29tZSBkYXkgKHZlcnkgaHlwb3RoZXRpY2FsIGFuZCBtYWRlIHVwKSB3ZSB3YW50IHRvIGFkZCBh
DQptb2RlIGZvciBURFggdGhhdCBhZGRzIG5ldyBwcml2YXRlIGRhdGEgdG8gYSBydW5uaW5nIGd1
ZXN0ICh3aXRoIHNwZWNpYWwgYWNjZXB0DQpvbiB0aGUgZ3Vlc3Qgc2lkZSBvciBzb21ldGhpbmcp
LiBUaGVuIHdlIG1pZ2h0IHdhbnQgdG8gYWRkIGEgZmxhZyB0byBvdmVycmlkZQ0KdGhlIGRlZmF1
bHQgZGVzdHJ1Y3RpdmUgYmVoYXZpb3IuIFRoZW4gbWF5YmUgcEtWTSB3YW50cyB0byBhZGQgYSAi
ZG9uJ3QNCnByZXNlcnZlIiBvcGVyYXRpb24gYW5kIGl0IGFkZHMgYSBzZWNvbmQgZmxhZyB0byBu
b3QgZGVzdHJveS4gTm93IGdtZW1mZCBoYXMNCmxvdHMgb2YgVk0gc3BlY2lmaWMgZmxhZ3MuIFRo
ZSBwb2ludCBvZiB0aGlzIGV4YW1wbGUgaXMgdG8gc2hvdyBob3cgdW5pZmllZCB1QUJJDQpjYW4g
aGUgaGVscGZ1bC4NCg0KPiBDb21tb24gb3BlcmF0aW9ucyBpbiBndWVzdF9tZW1mZCB3aWxsIG5l
ZWQgdG8gZWl0aGVyIGNoZWNrIGZvciB0aGUNCj4gdXNlcnNwYWNlIHBhc3NlZCBmbGFnIG9yIHRo
ZSBWTSB0eXBlLCBzbyBubyBtYWpvciBjaGFuZ2UgaW4NCj4gZ3Vlc3RfbWVtZmQgaW1wbGVtZW50
YXRpb24gZm9yIGVpdGhlciBtZWNoYW5pc20uDQoNCldoaWxlIHdlIGRpc2N1c3MgQUJJLCB3ZSBz
aG91bGQgYWxsb3cgb3Vyc2VsdmVzIHRvIHRoaW5rIGFoZWFkLiBTbywgaXMgYSBnbWVtZmQNCmZk
IHRpZWQgdG8gYSBWTT8gSSB0aGluayB0aGVyZSBpcyBpbnRlcmVzdCBpbiBkZS1jb3VwbGluZyBp
dD8gSXMgdGhlIFZNIHR5cGUNCnN0aWNreT8NCg0KSXQgc2VlbXMgdGhlIG1vcmUgdGhleSBhcmUg
c2VwYXJhdGUsIHRoZSBiZXR0ZXIgaXQgd2lsbCBiZSB0byBub3QgaGF2ZSBWTS1hd2FyZQ0KYmVo
YXZpb3IgbGl2aW5nIGluIGdtZW0uDQo=

