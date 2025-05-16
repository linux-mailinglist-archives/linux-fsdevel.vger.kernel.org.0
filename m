Return-Path: <linux-fsdevel+bounces-49282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C83ABA0FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 18:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DBE16D161
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5CB1DCB09;
	Fri, 16 May 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFFCqHKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA941760;
	Fri, 16 May 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413969; cv=fail; b=Psp6VEonBQOUJdTo/X8m0oQ5vfjYcx1H8gZAI5wTIsC0RirusjQpQoy4Z/yWvFIwdTkhhHhxfdOb0U5H5wIf/zBgwTZIwDwS78Bs2uPDGiygefFwMFkmltPndKAn9jMRCfDi/ViEFQi4J9IWxQM9jvLxPqdvYzh8jGELMLIt6fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413969; c=relaxed/simple;
	bh=Pvs1Od/qUg5v/1fVKl1nkrRV1fUpFp7TACF12qXsIfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iEjga0GnP8Xbspdv7/Q0Dd7mrlCi0sB9XHnDLxfNSHBJUD7eekvAcPN0aw010Pv+VzxPEK+pRvBUzzdjsOvb4jYo5iFXlCOaHtkgMdwToeGf4GgygDGCK3BL6QUc4Pj+JG5Md3kSG3niwROzNAdgDhzMhdav9PjVN7eIe7nQtfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFFCqHKI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747413967; x=1778949967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Pvs1Od/qUg5v/1fVKl1nkrRV1fUpFp7TACF12qXsIfI=;
  b=nFFCqHKIvjX+6gHqRp/tW94frv4LsGkO53+d2IjhxOfug/zoo4c7k7p6
   +ZbLJ60VXSpGjG/Ewt5ksYbTbh0Rf40V6zPPxXvlCbM4PzhxbHP/svEJl
   8p8+SeDM/EiNnESS5F48UZL0q9smgQhEVeJOp3mUq5RtdYd2yTR/Ef+hC
   +BHIZuo0wt8PW8AU+yu0sZlZ4Hu3XpSyGBo6ya6f6pZo0J8u4KtxPgwh2
   BD0Y7Hgo9CtrSdyXHgMBVLCs8JgVoJ0zplyF114VjKCrEc/uGN5lcPOfs
   QhJRUg663ZJrAFKoVy3KCcUEkJYwfIWPxfCC7g60WCbbA4mQ7DFhWozMa
   Q==;
X-CSE-ConnectionGUID: 8tZe5ft0Siuym8ppmuXbnA==
X-CSE-MsgGUID: lPPGVXXPQy+gAG8kdaImkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49267731"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49267731"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 09:46:06 -0700
X-CSE-ConnectionGUID: itSjcU9/TfqWn7EXk9WoAA==
X-CSE-MsgGUID: QHE2ZkmrSSOyvSpNZIBcow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="143862062"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 09:46:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 09:46:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 09:46:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 09:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAOniLrgy5OXANEjwvdq6aj/4nFMCbKOT+sd9Suo95fmzS0I2LnLZk0tnJXRFUJd52DAu5kkymFTxDEn3dSrNqu5z40M9WpxM07qE1lemAWHzY+f69qTUuja0hcQIUZuImRJJQS1jQEOzp/kCECudUyJYlr6VCrvSNocvqZ/omgwC4mjiUO+nOqWSLqQASO5KrEtwrjrCMWEvpOenVfOIwOS6XfQBFmFWHLJNko99EoMwMhVpAtjDImA5TgLqvqAq9kwxVKv9Iml7YH62QfgpkBbXyYptmCMm/4jCn+4ei0ZYJ2DTaN/g5Hf6e/6ckP5Y1EN5v26w69Gc5y0CbIH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvs1Od/qUg5v/1fVKl1nkrRV1fUpFp7TACF12qXsIfI=;
 b=PDDaxA5w4X3UuzWWXG8cQisnD0AX3IUgoefg3Emxgl/yrKI4nPt35y1b0LCw0O8TnJjtsGlqOs0sXkYy2bHDnraUK11zS9TFtB6UhifWKl/hhsSFOqtjHKn84wcYah1QI71eQ+7qEtQhi+Yy8Dmji1+0w0PDvKwkYE4GX94iF5R9RIhvsQ7YRG4GZ27zUoxKVMD6eOoACEB4BKj4Syi3ZFujcUAnGKleV9UT08mMBFsD00jJmDM2WiNp24vuADEBkG6fH6njWyFMtdPcsXQyI1yrj+wR8A3WpG5y8qEVYvPophYDO4u0NfYT2adms40dqlTtjQLQiiYVVInUTZcJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8232.namprd11.prod.outlook.com (2603:10b6:8:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 16:45:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8722.020; Fri, 16 May 2025
 16:45:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org"
	<x86@kernel.org>, "amoorthy@google.com" <amoorthy@google.com>, "jack@suse.cz"
	<jack@suse.cz>, "maz@kernel.org" <maz@kernel.org>, "tabba@google.com"
	<tabba@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "hughd@google.com"
	<hughd@google.com>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"Wang, Wei W" <wei.w.wang@intel.com>, "keirf@google.com" <keirf@google.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>,
	"aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>, "fvdl@google.com" <fvdl@google.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, "nsaenz@amazon.es"
	<nsaenz@amazon.es>, "willy@infradead.org" <willy@infradead.org>, "Du, Fan"
	<fan.du@intel.com>, "anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "mic@digikod.net"
	<mic@digikod.net>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "steven.price@arm.com" <steven.price@arm.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "Li, Zhiquan1"
	<zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas, Erdem"
	<erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Xu, Haibo1"
	<haibo1.xu@intel.com>, "anup@brainfault.org" <anup@brainfault.org>,
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "jthoughton@google.com"
	<jthoughton@google.com>, "will@kernel.org" <will@kernel.org>,
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
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"pgonda@google.com" <pgonda@google.com>, "quic_pderrin@quicinc.com"
	<quic_pderrin@quicinc.com>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "seanjc@google.com"
	<seanjc@google.com>, "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrPT/RKAgAAK44CAAFGtgIAAFymAgAAUsICAALhjAIAAO8yA
Date: Fri, 16 May 2025 16:45:58 +0000
Message-ID: <ce15353884bd67cc2608d36ef40a178a8d140333.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
	 <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
	 <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
	 <aCaM7LS7Z0L3FoC8@google.com>
	 <7d3b391f3a31396bd9abe641259392fd94b5e72f.camel@intel.com>
	 <CAGtprH8EMnmvvVir6_U+L5S3SEvrU1OzLrvkL58fXgfg59bjoA@mail.gmail.com>
In-Reply-To: <CAGtprH8EMnmvvVir6_U+L5S3SEvrU1OzLrvkL58fXgfg59bjoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8232:EE_
x-ms-office365-filtering-correlation-id: bb2c12c7-a48b-415b-2a79-08dd94992274
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHVyZk5HenU2V3V6SzRXOG1DZGRvNnFPZElxSTU3cG9QRStrdTBSSEREdGFm?=
 =?utf-8?B?THZLMkYrY2dMR3R0ZzFpaDBEa2RRVDcrUmgyTnVsTkpjY0J4ZWFsZGRJUFI4?=
 =?utf-8?B?MGgzNzdXSVFBT3hBSjZBZnNpR2dOQitub2tEQTYyRDUyeFJQK2g2bmIyZFI5?=
 =?utf-8?B?RWYvNHV4TWVORVFpRm1RL3BsWWNBQ2FZZitjUzR6N2ZlSitwSmFzRXovYk5I?=
 =?utf-8?B?TWlUNmlXSHQyd3QvNGUyN283OFZJOUVHUHVpZmhrcmpwYXIza1FrNjh1Nk1V?=
 =?utf-8?B?SGM4ZUNENmpPejliRHB0bWpBdGRyS3FMSk5XdFg3dVFMcVcxbUFPWGdYa3lQ?=
 =?utf-8?B?cTlZQW55RjdWb3JYZlhqRmQ5UVMvalF4SVdXd01iaEF6TWxBU1MxZGVHVllr?=
 =?utf-8?B?TnF2THhJSGd2eGhHM0hxMlVXc1BiUno5VkRjNy9PbSthK2Q2Ti90djZ1QWN3?=
 =?utf-8?B?c3lNaWFEVXB4MWNzemtIOWV0VERDcEhsOUsyOXAxQ3pHSW5PY3ZvTUp3TGh6?=
 =?utf-8?B?TVVXRmZRNFVGdVdQTmZROWNXczZlZDhEOGdIa3MyTzhzTXZzcEhvQzFCdVZU?=
 =?utf-8?B?ZGhiZ0VDSlBTRDRPaTdGQjliVWJCaTl2UytkNFU5aEVHY09NYnFoWmhzT2p2?=
 =?utf-8?B?VTV2dmMwS0hUOExzQnFPVW0rU0pmNnlxRlRrUWtoTWpjaUdTWmd2VGlNZW54?=
 =?utf-8?B?QUNKNU9hbytmcXdRc29SN3MrYzUybmVWcSt5bWR4N3RmTVhPcTBlTGlkOFMx?=
 =?utf-8?B?ZDYzcHFMY2srbk9ERGtzWUwrbnlrZko0Z2pCd0xyejZicE9FS0JsTEoyRklC?=
 =?utf-8?B?Rkt1amRyK0pZdVpzVk1TS0I4dVRBOUExMXNOd2ovaFFlSEJOQkVLeXgvbzQy?=
 =?utf-8?B?VXhVS1hhWDcrTFdIeXpMME4yR01nZFk4MjFHL2VNY2dZMUgzNzRWbitTTGMv?=
 =?utf-8?B?REZ6L2xtSDIyc0szdDlzeE45N0dSR1luM3FOYjZBdEJ0MHhXVHAxTjdCeGRF?=
 =?utf-8?B?R3ZSajRrZGE4Y1ZVOGZnNUl0TVVSRnBtVEloMUZFdXlQS0w1RTdYUnFtNUY2?=
 =?utf-8?B?eFRmckVaamczajJEOVcwNi9yVHJXZy9INUFIamkvTnJaeHovREo3Q2xFTTYx?=
 =?utf-8?B?dzZPZUc1a0ZIOE1iSjg3V2gzZ0lRU2hUdlJhd1lQcTJRQTYvRUIwWE51VkRW?=
 =?utf-8?B?dFNOeW9rWGo3elR1U3hWLzdlZGZKUDh5cHppUGp3OVJsdjlVcW4rQXBuQ2xr?=
 =?utf-8?B?bFJFKzdpU21oZlFmdHZoRnM4ODcwTGhhN0pVeFVRY2RMYVZZOTFBUDUrakpT?=
 =?utf-8?B?cGxDb09HOU45MWlBdXlERG5ja1lTY3dyYzhZMHhLOVJFVFBQUVdMbWNURGtK?=
 =?utf-8?B?aVVxQjdlUXY2WU1GaysycXgyYUovcm5mNjUwWDF5ejlDTEQxR1Qva1RMUWFp?=
 =?utf-8?B?Mm1ZSUwxQ1ZIVyt2SjZxRFJSMlZ1RmJXZ3RDeFlzVzRzendCNHl3cng0U0Iw?=
 =?utf-8?B?aVFIUS9NcDR0VjFhajRkTXU3R0RnUFdhTE84ME9tWUQwNU1DZnZiVDloYUJ4?=
 =?utf-8?B?dXorVElKVjJramxlKzI2UzF6QUwycGdIczMrTnA0ekNwNjczSDhSOWN2ZU8x?=
 =?utf-8?B?UEVUQWsraHEwL21iQTB6Rnd2Nm1SQ1lxcEcxOFpZZEgxeEk5S0dPNkdhMGJL?=
 =?utf-8?B?NVJEVGdybnN2cGNhZkQ2ZXhtYmhiMTU2N0laNUR6cnk4NXhscDhDZTFNckl3?=
 =?utf-8?B?c1VJdXNoM0FMZzZMclBocUtoMnorRWtNZXpJaWZjYzIrMkkwdW4zVmxqN25C?=
 =?utf-8?B?eUZkMXBZaW9LcjlIUkpFT3dFS1QvRFV4eGlpZHlKSS9kMUZoN2lrRnN3NUJ0?=
 =?utf-8?B?WEJ2OGZJUU1abUIzSUFYMmxCQ1dacGhyd1dBc29vWUVVdWNYOXVQK3VuZmpQ?=
 =?utf-8?B?dStIZUFnTnJzT0Fwb29leGphUVhrTmZqNXdWcUFjUXZ6akptS2pQTDZ4Um4x?=
 =?utf-8?B?czlidmV6WSt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEl3NkhCaWZEQ0VoZHdDd0NLWmNhMW5mQk5JelFWSUoyd2o0eVBMYnA1VUJs?=
 =?utf-8?B?VENlRGt0aEVKMkJCcTFwWmhpdFRrSzZHUE1FSDlvQmVsazhHaW1qN2pzZnBS?=
 =?utf-8?B?R1NHSGF1bGNlTGhLVU9BTWNUV09mMnhkOHJWVW9icHY2aFJFU1czaVpyWFds?=
 =?utf-8?B?TnllcDE5eEx2dndJVDMwSTlCK1NmS2RNeEdPeVFyTWNLZXVWR2J2cFpSR3g4?=
 =?utf-8?B?OUU0akRMTW9ZSzdjQ0Z0V2duYm1KUENTVlRuRTYwMDFDUnJuMVlra1dlTGpO?=
 =?utf-8?B?QzBuTGZNaTUycEpHQTJCKzgrKzgxMGs5T0x5UE1BSmRXdUhSWEoxMER0N3NH?=
 =?utf-8?B?YWNONXlWRHExRUc3aXRWZVh1V1dGN2xsUEZMMkdmdGlaK1VJR2RQNGlEYjVk?=
 =?utf-8?B?YmZxZndSV28wUTMvbjFZQWxNU3JRdFgzNFViWERSN2g2NEMzNzNSc2tCYkRr?=
 =?utf-8?B?b1NRUEplRFRxNXRQR3RJeDRTY29KR0Z6K0puRlVGelJTM1cxV1Y1QlhJdk5z?=
 =?utf-8?B?UWtINWlIbWM0ZjV1RkxFRkl4aGpXZTNmRTgvazdMa2tEYVZVWEx3djNCQjQ4?=
 =?utf-8?B?dThhNDZYaThLZjk0YklsQlR5TWdJZ1BReUxKMHFnQ3FucTZHYzF4Nm9mcDBR?=
 =?utf-8?B?Tyt2M29NVTNCNTMydU8wVXp6V0RrVEF6WjNmM2FSczRnQnV3SkpKZ1hueE9q?=
 =?utf-8?B?eHJ2eXZTby9aczhtVW1VaFV1aWE5eEdxV1NEcys4QkVEYndidHowaUNLZWVM?=
 =?utf-8?B?N1pUTnJYNnd1ckVzWEIzMUtIUzNmVE1xdytMd1NOY2hUSUpWUVNaU2d1ajF3?=
 =?utf-8?B?RW4vQVJ6Y1VoNXVzZnlmSTVKbkp0T3ZMam1MWG5pellDQ0MxR0lXeVBXVmVY?=
 =?utf-8?B?a0YyQ3ZiVGtLTWJ4TVU0NmlURmpidFJGb05hd0JldlZsMHFyM3VTNGV6QjAx?=
 =?utf-8?B?RkVRSXRNUUpTc251ZFBFUHZkZkJNT1lsWVgwMTh3QUExL1U2czhSVlFIdUp0?=
 =?utf-8?B?Q0NLUmVackdKZ3ExS2ZtaElZNHVBMDMxMk4yVHRCZ3diNWdma3VFdmtleTlL?=
 =?utf-8?B?VG1Gaks2ZzJRZE8xcUpjVFk3QVcwcUEwRS9TWFI2NTlOcXdEY0Y3S0Z1S1BE?=
 =?utf-8?B?dzBnU3VIOGdFcm9HOUJ0UVExK1lMQkQrRDBseTRpYzF5b2hWUHBTRzMvM2k5?=
 =?utf-8?B?WVBuWGdxWFBkUnl0Q1RHaHI4ZVIxREJVNERwcitGUHhOa0xXVkZVNlpXb3VP?=
 =?utf-8?B?bDM1V20zOXNMVHpZZ3lReDRHT2Ewazg2dDNWTTFRc1A5UkZnREJxbkdVYk5I?=
 =?utf-8?B?bk5mYkRuYjJhYmZmbmQ4dnNuRy9IV1AyVUhmNHRnSFVxV2FFU1VZNTdqdlZF?=
 =?utf-8?B?b2YwcjBaaUZVWlRSeHFRTG4yZXNzakZmdW51WkJMMkZKb1k5bW03MTRRL2g4?=
 =?utf-8?B?dm45bmx4VE1kaTJsSEx4cCtFUEVSU1B0UCs1d3doNmFqSlNUaXZ4Wld3MWFv?=
 =?utf-8?B?N0RGZ0lkblJKN0NDZjdaNmljZFo1RDBBT01FL2g3Z0EyZGFmellmSnVUcEF0?=
 =?utf-8?B?VGNncDFQTkxzeWIvdmVXcEprM3BMMWRJYWJJK2FibXhKWFU5WUNFRmNkaTVQ?=
 =?utf-8?B?YnZvTjUwL0xBejE3dzc5S3ovRjR3SGEzSUFZZnVvc3oyMGZHOTJTdTVjbFpr?=
 =?utf-8?B?eC9XdnlpeTZKb29OOU5LR0hCZy9BZVhOQkdNeVZvMHVCZ1RXRUM0QkhFeE4w?=
 =?utf-8?B?MGJGOUtLa0RaMGtWUjNxcGFHSXAzUmQrNGtKWi8zdDFBaXFiLy83UUNLQkF4?=
 =?utf-8?B?NzJDUEsvNUcyYm5VLzZGcHhVU0FNbjFEcVUrY3BidXVPOWxCUHdvZG5YbVBm?=
 =?utf-8?B?aEgyN2V4Mk5hdG1OUVNsTkUzQldxYzZYdWlnbkhpeTB1QkN5S2JySUVEczZZ?=
 =?utf-8?B?ek93ZGE4NGNiUmsvUzVKeDh2Y0JWQmhjYUtUdzV5a0V2a0ZhYlQvS1F5a1Jm?=
 =?utf-8?B?YS9qcTFzbjBneVY1LzJ6UCtHdTVicVVmR1BhSW1WaCtFOXF6WjY1b2Fsdk5v?=
 =?utf-8?B?dUpUd3BOK0tqK253UmVVOXYxemt0L2g0em9rTHh3MG0vc0VRV08vOS9Lc0pZ?=
 =?utf-8?B?MVl5RitJaXhFWE9LeWtKZjRwelZvM3BnNngvK2Fpc3U0RXVDOXNpUStkc294?=
 =?utf-8?Q?ByjBA4uwUH8lSbgpHGmXHKk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2282D24AF669444CAF3A0F51FDD21F33@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2c12c7-a48b-415b-2a79-08dd94992274
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 16:45:58.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVJ2gLciPSEmewlL5aJq+SDBXkKdlTeHTuI8I9DhommUrHxzc46IC40SFwsPgFGFErCYxgpQmIXlOw/L1UUxmmAvyRlbTpCUvW1B8pozYk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8232
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA1LTE2IGF0IDA2OjExIC0wNzAwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiBUaGUgY3J1eCBvZiB0aGlzIHNlcmllcyByZWFsbHkgaXMgaHVnZXRsYiBiYWNraW5nIHN1
cHBvcnQgZm9yDQo+IGd1ZXN0X21lbWZkIGFuZCBoYW5kbGluZyBDb0NvIFZNcyBpcnJlc3BlY3Rp
dmUgb2YgdGhlIHBhZ2Ugc2l6ZSBhcyBJDQo+IHN1Z2dlc3RlZCBlYXJsaWVyLCBzbyAyTSBwYWdl
IHNpemVzIHdpbGwgbmVlZCB0byBoYW5kbGUgc2ltaWxhcg0KPiBjb21wbGV4aXR5IG9mIGluLXBs
YWNlIGNvbnZlcnNpb24uDQoNCkkgYXNzdW1lZCB0aGlzIHBhcnQgd2FzIGFkZGVkIDFHQiBjb21w
bGV4aXR5Og0KIG1tL2h1Z2V0bGIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICA0ODggKystLS0NCg0KSSdsbCBkaWcgaW50byB0aGUgc2VyaWVzIGFuZCB0cnkgdG8gdW5kZXJz
dGFuZCB0aGUgcG9pbnQgYmV0dGVyLg0KDQo+IA0KPiBHb29nbGUgaW50ZXJuYWxseSB1c2VzIDFH
IGh1Z2V0bGIgcGFnZXMgdG8gYWNoaWV2ZSBoaWdoIGJhbmR3aWR0aCBJTywNCj4gbG93ZXIgbWVt
b3J5IGZvb3RwcmludCB1c2luZyBIVk8gYW5kIGxvd2VyIE1NVS9JT01NVSBwYWdlIHRhYmxlIG1l
bW9yeQ0KPiBmb290cHJpbnQgYW1vbmcgb3RoZXIgaW1wcm92ZW1lbnRzLiBUaGVzZSBwZXJjZW50
YWdlcyBjYXJyeSBhDQo+IHN1YnN0YW50aWFsIGltcGFjdCB3aGVuIHdvcmtpbmcgYXQgdGhlIHNj
YWxlIG9mIGxhcmdlIGZsZWV0cyBvZiBob3N0cw0KPiBlYWNoIGNhcnJ5aW5nIHNpZ25pZmljYW50
IG1lbW9yeSBjYXBhY2l0eS4NCg0KVGhlcmUgbXVzdCBoYXZlIGJlZW4gYSBsb3Qgb2YgbWVhc3Vy
aW5nIGludm9sdmVkIGluIHRoYXQuIEJ1dCB0aGUgbnVtYmVycyBJIHdhcw0KaG9waW5nIGZvciB3
ZXJlIGhvdyBtdWNoIGRvZXMgKnRoaXMqIHNlcmllcyBoZWxwIHVwc3RyZWFtLg0KDQo+IA0KPiBn
dWVzdF9tZW1mZCBodWdlcGFnZSBzdXBwb3J0ICsgaHVnZXBhZ2UgRVBUIG1hcHBpbmcgc3VwcG9y
dCBmb3IgVERYDQo+IFZNcyBzaWduaWZpY2FudGx5IGhlbHA6DQo+IDEpIH43MCUgZGVjcmVhc2Ug
aW4gVERYIFZNIGJvb3QgdXAgdGltZQ0KPiAyKSB+NjUlIGRlY3JlYXNlIGluIFREWCBWTSBzaHV0
ZG93biB0aW1lDQo+IDMpIH45MCUgZGVjcmVhc2UgaW4gVERYIFZNIFBBTVQgbWVtb3J5IG92ZXJo
ZWFkDQo+IDQpIEltcHJvdmVtZW50IGluIFREWCBTRVBUIG1lbW9yeSBvdmVyaGVhZA0KDQpUaGFu
a3MuIEl0IGlzIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gNGsgbWFwcGluZ3MgYW5kIDJNQiBtYXBw
aW5ncyBJIGd1ZXNzPyBPcg0KYXJlIHlvdSBzYXlpbmcgdGhpcyBpcyB0aGUgZGlmZmVyZW5jZSBi
ZXR3ZWVuIDFHQiBjb250aWd1b3VzIHBhZ2VzIGZvciBURFggYXQNCjJNQiBtYXBwaW5nLCBhbmQg
Mk1CIGNvbnRpZ3VvdXMgcGFnZXMgYXQgVERYIDJNQiBtYXBwaW5ncz8gVGhlIDFHQiBwYXJ0IGlz
IHRoZQ0Kb25lIEkgd2FzIGN1cmlvdXMgYWJvdXQuDQoNCj4gDQo+IEFuZCB3ZSBiZWxpZXZlIHRo
aXMgY29tYmluYXRpb24gc2hvdWxkIGFsc28gaGVscCBhY2hpZXZlIGJldHRlcg0KPiBwZXJmb3Jt
YW5jZSB3aXRoIFREWCBjb25uZWN0IGluIGZ1dHVyZS4NCg0KUGxlYXNlIGRvbid0IHRha2UgdGhp
cyBxdWVyeSBhcyBhbiBvYmplY3Rpb24gdGhhdCB0aGUgc2VyaWVzIGRvZXNuJ3QgaGVscCBURFgN
CmVub3VnaCBvciBzb21ldGhpbmcgbGlrZSB0aGF0LiBJZiBpdCBkb2Vzbid0IGhlbHAgVERYIGF0
IGFsbCAobm90IHRoZSBjYXNlKSwNCnRoYXQgaXMgZmluZS4gVGhlIG9iamVjdGlvbiBpcyBvbmx5
IHRoYXQgdGhlIHNwZWNpZmljIGJlbmVmaXRzIGFuZCB0cmFkZW9mZnMNCmFyb3VuZCAxR0IgcGFn
ZXMgYXJlIG5vdCBjbGVhciBpbiB0aGUgdXBzdHJlYW0gcG9zdGluZy4NCg0KPiANCj4gSHVnZXRs
YiBodWdlIHBhZ2VzIGFyZSBwcmVmZXJyZWQgYXMgdGhleSBhcmUgc3RhdGljYWxseSBjYXJ2ZWQg
b3V0IGF0DQo+IGJvb3QgYW5kIHNvIHByb3ZpZGUgbXVjaCBiZXR0ZXIgZ3VhcmFudGVlcyBvZiBh
dmFpbGFiaWxpdHkuDQo+IA0KDQpSZXNlcnZlZCBtZW1vcnkgY2FuIHByb3ZpZGUgcGh5c2ljYWxs
eSBjb250aWd1b3VzIHBhZ2VzIG1vcmUgZnJlcXVlbnRseS4gU2VlbXMNCm5vdCBzdXJwcmlzaW5n
IGF0IGFsbCwgYW5kIHNvbWV0aGluZyB0aGF0IGNvdWxkIGhhdmUgYSBudW1iZXIuIA0KDQo+ICBP
bmNlIHRoZQ0KPiBwYWdlcyBhcmUgY2FydmVkIG91dCwgYW55IFZNcyBzY2hlZHVsZWQgb24gc3Vj
aCBhIGhvc3Qgd2lsbCBuZWVkIHRvDQo+IHdvcmsgd2l0aCB0aGUgc2FtZSBodWdldGxiIG1lbW9y
eSBzaXplcy4gVGhpcyBzZXJpZXMgYXR0ZW1wdHMgdG8gdXNlDQo+IGh1Z2V0bGIgcGFnZXMgd2l0
aCBpbi1wbGFjZSBjb252ZXJzaW9uLCBhdm9pZGluZyB0aGUgZG91YmxlIGFsbG9jYXRpb24NCj4g
cHJvYmxlbSB0aGF0IG90aGVyd2lzZSByZXN1bHRzIGluIHNpZ25pZmljYW50IG1lbW9yeSBvdmVy
aGVhZHMgZm9yDQo+IENvQ28gVk1zLg0KDQpJIGFza2VkIHRoaXMgcXVlc3Rpb24gYXNzdW1pbmcg
dGhlcmUgd2VyZSBzb21lIG1lYXN1cmVtZW50cyBmb3IgdGhlIDFHQiBwYXJ0IG9mDQp0aGlzIHNl
cmllcy4gSXQgc291bmRzIGxpa2UgdGhlIHJlYXNvbmluZyBpcyBpbnN0ZWFkIHRoYXQgdGhpcyBp
cyBob3cgR29vZ2xlDQpkb2VzIHRoaW5ncywgd2hpY2ggaXMgYmFja2VkIGJ5IHdheSBtb3JlIGJl
bmNobWFya2luZyB0aGFuIGtlcm5lbCBwYXRjaGVzIGFyZQ0KdXNlZCB0byBnZXR0aW5nLiBTbyBp
dCBjYW4ganVzdCBiZSByZWFzb25hYmxlIGFzc3VtZWQgdG8gYmUgaGVscGZ1bC4NCg0KQnV0IGZv
ciB1cHN0cmVhbSBjb2RlLCBJJ2QgZXhwZWN0IHRoZXJlIHRvIGJlIGEgYml0IG1vcmUgY29uY3Jl
dGUgdGhhbiAid2UNCmJlbGlldmUiIGFuZCAic3Vic3RhbnRpYWwgaW1wYWN0Ii4gSXQgc2VlbXMg
bGlrZSBJJ20gaW4gdGhlIG1pbm9yaXR5IGhlcmUNCnRob3VnaC4gU28gaWYgbm8gb25lIGVsc2Ug
d2FudHMgdG8gcHJlc3N1cmUgdGVzdCB0aGUgdGhpbmtpbmcgaW4gdGhlIHVzdWFsIHdheSwNCkkg
Z3Vlc3MgSSdsbCBqdXN0IGhhdmUgdG8gd29uZGVyLg0K

