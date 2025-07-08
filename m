Return-Path: <linux-fsdevel+bounces-54271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E229EAFCF47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843E31BC2B25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1702DC351;
	Tue,  8 Jul 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eS2e0ZRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C91C8632;
	Tue,  8 Jul 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988763; cv=fail; b=ocFHiKEm0AjM+HEoLHIIVyyHuj1Aav8f3r27Xk4Ku38Eb4vOeXHTZQLRwwsrh8KHs9JjO9v21EDl5NQ2+0aTmCf30ivxsGqjXo2JBg6khX9pb5JQTdXtvYs1YxcwDpr4WaVnwG2FwO8szDusQQq3xekOS1G760qeGD9USdTFDac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988763; c=relaxed/simple;
	bh=/uj9w9GJOkeQJn+n0QOtqTmQXEF+xthrsTka3YH8c/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=spmX90TulSokAcaLwCNjWlfKu2O65q7A8Oo5k1vfo67vqLQj3dURd6D7qHuU4MIG/jOLUVRqDCHK4RsAcsO7fMWS1t+Xc47+j8hwNvFBc+50Dq0kkKWf+diIDdGLCM+GWmfQE9khZFI5eiyqr8pRvcMMpXls2XUbKB/REWtDnME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eS2e0ZRc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751988761; x=1783524761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/uj9w9GJOkeQJn+n0QOtqTmQXEF+xthrsTka3YH8c/s=;
  b=eS2e0ZRc3ZzjG01UdsYyudRZqYH+zKxI5Vf4+ng+6r2RNNrC1T6CTJ3Q
   FQP2C4kluPJ71LYbZrOVvBvWe2aEJAw3bK8w1zM0T8K5NHpaJEcRfaeD8
   eUensAIQveD7kcB6B1n/Xi5XUdS56RDXzk9rh3uCXP3cxs4vIhvyyF/y8
   tD/5re4Z4xqANCUQuIu7rIJYyfFr6Jl65xhZJ+IXBTw/ReSS7ibu/BuvQ
   CeLEM0CPA/bqoIglq44uSyIoFoaDibIpDI+SL9RidO2hQsgmKAX2nK1d1
   rru8NAnlKysKH7QCFa/WYr7xCnZALEzAHDCy4aHyp1cWnxxxhvovPKpJS
   A==;
X-CSE-ConnectionGUID: UgISpeTeQeqIGd77BO69sA==
X-CSE-MsgGUID: RmODzO6eSneF02GRg1xhig==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79664463"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="79664463"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 08:32:31 -0700
X-CSE-ConnectionGUID: IqsbW6yAQtaD6uibvtpjrQ==
X-CSE-MsgGUID: hfv8kI1vTiWWgu1tYS0/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="159567948"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 08:32:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 08:32:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 08:32:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 08:32:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBx1ZJhJCxj/uiQBpJUxbohvuajX60xm/C+z0sMfbP17uaAEWY+5IQqZr992KnX4YvaxHd6pK0L2LfjUbdtvzVCbAfyGKdTplFVWHt6IzJWY5IAMGmJxjiD0JzFhc6cxypXvcpCM9Oys9XyY8YNyzpEVe/s7FkoiJEFF4fevoP8au4q/qC983fl4vgccOAsB83GJvcAwmXkxGEyIVC/u7thH+udB4a0knANzzikOzfB2h5xzXtz5e5pHwtdp1018Wo4467ksOtU/5kC2JoMosS4u4YV6HZIoJk3VYI8bsWgZIWJspP0Y8jcefNosTd6KhUhq5L38H9qEW/yGV4zhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uj9w9GJOkeQJn+n0QOtqTmQXEF+xthrsTka3YH8c/s=;
 b=jJaFaQUtMXih6fqTISoDRemRGSUHURVN+neBhFQFx2f2JYlIgt2xbz9mpoVoyJxnlcf3VsptMtPLx/G0oWNtALgZeP3f31E3313G384WkOGNyeeGzYflvfl36LA30Unq1CX290qkFvqDDI0XxnGEOI0ev5EWvUkS83pz1X6WcXyePKdd5AXrpyvJlx1Fs0sWEp3bGJPPRp92YrmNQCHRM+7aWRuuAhMbg4LeQsu4EJBJJDdViXx/kdE46DODYsH4OLMNO3e14+cmHiBvspMbsb/7dHVRNg8A84l6eV+LOlOeen3Hnlpj2pqKTTneruXvopWBPKDv8Ei9Fbd0iRpHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY5PR11MB6511.namprd11.prod.outlook.com (2603:10b6:930:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Tue, 8 Jul
 2025 15:31:11 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 15:31:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "steven.price@arm.com"
	<steven.price@arm.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "amoorthy@google.com"
	<amoorthy@google.com>, "tabba@google.com" <tabba@google.com>,
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "jack@suse.cz"
	<jack@suse.cz>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "keirf@google.com"
	<keirf@google.com>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "Wang, Wei W" <wei.w.wang@intel.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "fvdl@google.com"
	<fvdl@google.com>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>,
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "anup@brainfault.org" <anup@brainfault.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mic@digikod.net" <mic@digikod.net>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "Du, Fan" <fan.du@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"rientjes@google.com" <rientjes@google.com>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "Aktas, Erdem" <erdemaktas@google.com>,
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"willy@infradead.org" <willy@infradead.org>, "hughd@google.com"
	<hughd@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "maz@kernel.org" <maz@kernel.org>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"will@kernel.org" <will@kernel.org>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "nsaenz@amazon.es"
	<nsaenz@amazon.es>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang,
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
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com"
	<pgonda@google.com>, "quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>,
	"hch@infradead.org" <hch@infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "seanjc@google.com" <seanjc@google.com>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrQKWaYAgAAM4gCAEFZTAIAAkwSAgAC4SICAAP4mgIAA8aaAgAmqgQCAAA20gIAADwOAgADddQCAAAjqgIAABCOAgAAGpoA=
Date: Tue, 8 Jul 2025 15:31:11 +0000
Message-ID: <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
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
In-Reply-To: <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY5PR11MB6511:EE_
x-ms-office365-filtering-correlation-id: 6692e04c-ef28-4c81-5d0c-08ddbe3477b8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?REFwY2ZOREhOTHloU2ZUSlZOSFNrYjhtQVpycm1HZXYyL0wzdldvSVAzWCtX?=
 =?utf-8?B?azhyZStMQnc5OG1sZnkwLy8zakN3Q1JUVGJTMFVPcWtQQWFmK3NxcDROVHpO?=
 =?utf-8?B?ZkhYNGRobGpZWW5MbE1JcC9LK1hWa0dycG0xMmh0L2dpbjlMbW0vV1RlSVow?=
 =?utf-8?B?SUh3eEVZNUxFcWJtRGQrU3M0Mk5MTkc5eW9HSWV1akpKTlpvdndTdjBidWpH?=
 =?utf-8?B?N3hpOVZVamgwTENiM1c4bHo0bjBueXZEZnhxZVJ2WGZvbXNGNEEvb0FhZ0Zi?=
 =?utf-8?B?T05TTEJYKzlDMUhKbmxUSlNvQmYwY3FkcUdwa3pIbWRlSkU4TVZXZzhqQXRU?=
 =?utf-8?B?YWc0NmxQOGRSdTJ6dENoVUN4elVxdCtkN2ZmUE0xQ0h6NUtPYWcvcjVjK1RP?=
 =?utf-8?B?QWRrOENIM3czZkdhOExYM05hckM4M0UvdXpDMGdYaXdBRUdrTWJvZEdWbzRS?=
 =?utf-8?B?Mlh0WUVxOURsR1I0cndPOUdOc0V6anhRNE01dUNNWEJRaUZ5WWx2bnFGS0Fp?=
 =?utf-8?B?QlQxVEZ5MC9rdEtOOVZtRkZBYWpEZ2d6ckZvbTgyek01NFVaUHFlSW1kVm1y?=
 =?utf-8?B?RXZHS2FSZWtwZjlKY1pzNWwyZzBxaWtrWGltd0llaThDWVY5dmJSUitRVVJ6?=
 =?utf-8?B?MkN2dElRQVJVWEg2NktzUUYrUlV3YVkxKzZFK2UrWWp4ODFjU25ybFRTS3pJ?=
 =?utf-8?B?dTJGWHNkVGtVd0sxblJnYlFyL2lUQU8yTEkzVmRMdUNxTXExcmdFZ0ZvVTVt?=
 =?utf-8?B?TUg1WVVodWNCUWFKam9tNXlOTVllNms0SlF3ZDg1UzQ2R0FnQkRCbHVIL0ZS?=
 =?utf-8?B?c3pUU2VGMlZmV0tnT0swOUxQbStLeEFYRFB6V0ZlY0tZSnRIK2EycDA0ekN6?=
 =?utf-8?B?RnRDSTFkbEc4UzFjMmxIc1NMbmFGbXZ2MkhBZmkyOXZBL1QyVkZmU0puekxz?=
 =?utf-8?B?bHhnRFpVOHk2T0N3K1MyNzFmL2JXd2hGYnVNTXNJODB4L1ozaW5wdk5lUm83?=
 =?utf-8?B?UnZEVU9DTEZldEgxd1hjUW1NMHV5UDBxWUYyY1V6SWpKd0t6NmpyODhnRER0?=
 =?utf-8?B?NmxPa0cveWxHRDZOV2ZxckRPRU42ZC9KUjNvZkVuSWcvYWxSYi9rMUptOXdT?=
 =?utf-8?B?UnZmNTIzeFd4dXRzQ05NZ3krY1JkaHBqeEtsOEJJWVNITkZoN0IwWFA5aGtE?=
 =?utf-8?B?R09kMEwrT0d5MncwVEQ1djhzcloyN2d2OGd0VjZ3SitqU1FVbzZFWlQxTWNQ?=
 =?utf-8?B?RUFpbHZ6S0xzbm1KZDNlSkFKNTBzMWdEcGEyUGNQaUtlMzNUR2k5bFlPYUhs?=
 =?utf-8?B?MUJRN1lhUjEvTWlubDRKQnRxejJ6WjBGS21hNTYzN0JpNGxSK1NmYXROZEow?=
 =?utf-8?B?NDRMd2VnbHUwRDdZVFlrMUJaZzVXTXBoeWhMdXZNTjhzcUlKRzVxVWFQeGZl?=
 =?utf-8?B?bHNzclkzS2VGMVYvdXJZNlNyeS9sczRqMjBZMjJPNlFlZm1zUGxDK2trMnlx?=
 =?utf-8?B?bklzN1Bhd0ZDMHlBSVE1bHpWZTNRR1BYNlNXa3lYQ2tDNWd3VlY1VG5tY0Rt?=
 =?utf-8?B?ZVJBc1JBcGRyaHJPZGJxK1pIOERUZ1RUTFVoUERLNEtYMkdOVEtuM0FYeHVu?=
 =?utf-8?B?KzFrMFdxR1JqNnNZZHhaU0FLTHZzam93a3hodjdIR2E2REU5Ty9peFFWSzQ4?=
 =?utf-8?B?WEd4cnNSa1BhbTZ4azlvWllxNnBXWlp5bjNDYkFCYkowazBQTkFicmZZTHlG?=
 =?utf-8?B?WG5yZkxVMkVLV0syTjBWUkZNdDErM0lBTGI2RHJ2NXBUVTZUeVZBbXQ2V3Z2?=
 =?utf-8?B?dFN3b0FIY0E0dy9jNStQRDd4ZGRiT1RXbkNJbnk4eEdJQm9TeHZXbDd4NWFW?=
 =?utf-8?B?VkNKcnJHOU02eHRZV0I1a3BpRTJSZlFteTQ3U3poYWZML2twcDBwNzkyQXN3?=
 =?utf-8?B?VGJRZFNrTE5wU0QvaUR0OEw0Z3lQQWVqUFVIanh5YXlEajlRSUUxWmZmZmZ5?=
 =?utf-8?Q?SiUZumWUwsEGKqBj1V7jLqKNZ2BCyI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmZYR3FYUjk5cG1weFRwV2ZGdGpVMFNIS0FqTUpKclM3NkJzck9ydG1OSzBr?=
 =?utf-8?B?RXNVbnkwdEVrZy9qTXJ0VDVBcVVEbUZGUTIwZVIwUWc5SU5ucVVOckxCcG1Z?=
 =?utf-8?B?WU9BV0p2UGZMczhIak9TdmZqU1ZNRHlCbkRmdTM5aHAzTmxoKzhYRzdRczdw?=
 =?utf-8?B?Q2FtNms3NHdKZXJ4aU16Ynd2RWM1bUtNaU5qMTdYNXBsUkF5bjdaNEtGcnJs?=
 =?utf-8?B?NGNjSjBaNFhZemo0NzJVWG4yL3BXU2hUUlVMak5yWSttUG9VUmF3V1VpRmtO?=
 =?utf-8?B?cDdXeE95dlZwZFVpTWRRZE1LcVhsOEdBV3h4MW1QMWtyY0UxbUREMlNLdExL?=
 =?utf-8?B?UWYrMjFlYWxQRE5ISFhLTEJTZGtvcTMvLzZyZFN6dUsrRHZLNGV1a09obUk4?=
 =?utf-8?B?Q0tHci9mL2J1OVNLM0o4Q2NUaEY2MFpMYmMxWnVMSHRBUWNwYTc0MVRmY1N3?=
 =?utf-8?B?LzdScDdkWWVNVjRsOU5JMTNBSHVkc3BqdFFTSDYyQytxcmI2amV4ckhXL0tu?=
 =?utf-8?B?YUpKS3VWYTlZcjI5S05YUE5xMXlSTVh5YzdqcXFDNmlJdFVzV1k1RDA3VUs5?=
 =?utf-8?B?MUJPOWV1SDhWS0FHZ3IwcUZhS3MvNUpoQVBLRTlkNUdaQVhBVUdFT010UWJt?=
 =?utf-8?B?b0t5NndseThsTmZYR3dIQ1lJYWJwaXpDdzJtdTE1b2hldEFsU1RVUlZiOUs1?=
 =?utf-8?B?MmN4VTFsQll4c1VKa0w2VGw0OUdIL05lRTVRa1JzdThYN3dzdTdWejRIZXRo?=
 =?utf-8?B?YWpPME5rcEZzcjUrUjh0U3Q0aUhNdmN3S2pxRDZERHBrRkQ5TVN0SGszbC8z?=
 =?utf-8?B?cVV3WE95KzdsSXNUNmhoUURmeGhCcnZpS2dndGJhUDMyamlwWXkrTFJwejBC?=
 =?utf-8?B?T2Y1TDBwbE1EcWlHREhLaEFldHhxMmNVNzVRcU91NnZFUDMrNjNnV2VyQ013?=
 =?utf-8?B?TWMrTFA0NThWcFRMd2phNHNXN28yTDg0Mm1SZ3JOMjdlamtGTmp1WitvMUdM?=
 =?utf-8?B?b296dlZnY1dFeDhFaDlubG1FTGdRMU1sWjVmNE9NV2ZIeGtuRGw3NllYZitq?=
 =?utf-8?B?bFhhTGFFQWVycWREeHc2clplYUlNMWpDb0lMcW9xcEpZNStrNXU0RWphbTRU?=
 =?utf-8?B?QU9lSEZNd3ZzM3Mxd1JxMEovcElTaDZBZG1KSE8yOWlTZkRMREZnUU5kbEFF?=
 =?utf-8?B?VzFvdkR3WGl5TkJxenJtWGx3cllmczRGa2lHRElwUG5vaWNXUTlrcDFVc2Q3?=
 =?utf-8?B?bm5wYkp1UGRIMEhwY2E1cFV0bkZyNEhHaXZSQ3ZhVC8zQ0kzbEo2elVsUFpF?=
 =?utf-8?B?TWZoaTcvMm54Ry9oMFVFNUs4ZTRtRXQ2MlptK2x0RHFKQVltelEyYzBBUDNX?=
 =?utf-8?B?SGJRL2IwVVlvcHEvZ0lIRmJta3l5Zm9CbGZ6aWVleHBuMjQzRGEzREtiSDVY?=
 =?utf-8?B?czVJQk9nbkxtUXphVUZUeDQyVExrdFRNc0hmRGxSZTNJeFFEU1pwb0ZuRjFZ?=
 =?utf-8?B?YWdHZDM3MkM1VWZIcmhqZy9mN2YvdTg3c1NDMmRHSHU5NjRsTEFOOUZDVDlL?=
 =?utf-8?B?eFFsY3lMZlo3dlovUzJnMWY3bVp0S2M1ZDlIeDE1UjBHQU0xMTBhTFEvSzF2?=
 =?utf-8?B?eTZHOGVRK0JJVVlBWitUb29kbUNtUnJPSWRQVnAxODRjTDVXSnFDcXVhNTgv?=
 =?utf-8?B?V00wWUZ4RTl4Q3d1Umg0Tlk1VUpiN2Z6Y3JSMDl3YnhRbFkwa2FYUWhFVUZr?=
 =?utf-8?B?VHdveVZ3ZnBUMGZmQ1dPWjRVTjh2b09qZnlMeVM5aGU5UXk1a1d2Z055SjFB?=
 =?utf-8?B?UVB6Rzh3alVHMTJMV3lCOVlTTjJOU3hwZ0paT2xXOHlKZTBneFBpYmZEcFV4?=
 =?utf-8?B?enRSNXNBUEt0MkRHK2tDYks4cEY0WHl5RnVlTWpCbUh3U2VUMUQ5WHovV2NU?=
 =?utf-8?B?UVdxSHp6QkFJMWlXQWo3K2tsaEF0TCtoMFRvcHRFNGw4cWIybkhuWnl3aHpT?=
 =?utf-8?B?R0tSaUZ6UGYzOVpSVFh0a0VjcG9tMm5PVy9vWjcxV3VDUllEamdHWjVOYmxN?=
 =?utf-8?B?OERsSFFSdWtaMDV3djZnY3FzWDFycTlxdGNGVTZGQnpTME1pK2tyb3BmaWwx?=
 =?utf-8?B?S244OU1YR1FFZ0o4enA4NnNWajJaa210U1JmZjM1Q1F0N043Nm1MWW1vZ2gy?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <220E29D4ADEEF94BA5FF0FC78071D77B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6692e04c-ef28-4c81-5d0c-08ddbe3477b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 15:31:11.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdwtA74xm1bdAY1NNBL57o0VL7NkOwTX/TNg3k0Cl+jBY9tSHLsdNwJVklpdK7jB1yTL9kdvLZoQF/ktrnnHgKuPRRNWJbSDn5ETBlo17GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6511
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA3LTA4IGF0IDA4OjA3IC0wNzAwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiBPbiBUdWUsIEp1bCA4LCAyMDI1IGF0IDc6NTLigK9BTSBFZGdlY29tYmUsIFJpY2sgUA0K
PiA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFR1ZSwg
MjAyNS0wNy0wOCBhdCAwNzoyMCAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4g
PiA+ID4gRm9yIFREWCBpZiB3ZSBkb24ndCB6ZXJvIG9uIGNvbnZlcnNpb24gZnJvbSBwcml2YXRl
LT5zaGFyZWQgd2Ugd2lsbCBiZQ0KPiA+ID4gPiBkZXBlbmRlbnQNCj4gPiA+ID4gb24gYmVoYXZp
b3Igb2YgdGhlIENQVSB3aGVuIHJlYWRpbmcgbWVtb3J5IHdpdGgga2V5aWQgMCwgd2hpY2ggd2Fz
DQo+ID4gPiA+IHByZXZpb3VzbHkNCj4gPiA+ID4gZW5jcnlwdGVkIGFuZCBoYXMgc29tZSBwcm90
ZWN0aW9uIGJpdHMgc2V0LiBJIGRvbid0ICp0aGluayogdGhlIGJlaGF2aW9yIGlzDQo+ID4gPiA+
IGFyY2hpdGVjdHVyYWwuIFNvIGl0IG1pZ2h0IGJlIHBydWRlbnQgdG8gZWl0aGVyIG1ha2UgaXQg
c28sIG9yIHplcm8gaXQgaW4NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGtlcm5lbCBpbiBvcmRlciB0
byBub3QgbWFrZSBub24tYXJjaGl0ZWN0dWFsIGJlaGF2aW9yIGludG8gdXNlcnNwYWNlIEFCSS4N
Cj4gPiA+IA0KPiA+ID4gWWEsIGJ5ICJ2ZW5kb3Igc3BlY2lmaWMiLCBJIHdhcyBhbHNvIGx1bXBp
bmcgaW4gY2FzZXMgd2hlcmUgdGhlIGtlcm5lbCB3b3VsZA0KPiA+ID4gbmVlZCB0byB6ZXJvIG1l
bW9yeSBpbiBvcmRlciB0byBub3QgZW5kIHVwIHdpdGggZWZmZWN0aXZlbHkgdW5kZWZpbmVkDQo+
ID4gPiBiZWhhdmlvci4NCj4gPiANCj4gPiBZZWEsIG1vcmUgb2YgYW4gYW5zd2VyIHRvIFZpc2hh
bCdzIHF1ZXN0aW9uIGFib3V0IGlmIENDIFZNcyBuZWVkIHplcm9pbmcuIEFuZA0KPiA+IHRoZSBh
bnN3ZXIgaXMgc29ydCBvZiB5ZXMsIGV2ZW4gdGhvdWdoIFREWCBkb2Vzbid0IHJlcXVpcmUgaXQu
IEJ1dCB3ZSBhY3R1YWxseQ0KPiA+IGRvbid0IHdhbnQgdG8gemVybyBtZW1vcnkgd2hlbiByZWNs
YWltaW5nIG1lbW9yeS4gU28gVERYIEtWTSBjb2RlIG5lZWRzIHRvIGtub3cNCj4gPiB0aGF0IHRo
ZSBvcGVyYXRpb24gaXMgYSB0by1zaGFyZWQgY29udmVyc2lvbiBhbmQgbm90IGFub3RoZXIgdHlw
ZSBvZiBwcml2YXRlDQo+ID4gemFwLiBMaWtlIGEgY2FsbGJhY2sgZnJvbSBnbWVtLCBvciBtYXli
ZSBtb3JlIHNpbXBseSBhIGtlcm5lbCBpbnRlcm5hbCBmbGFnIHRvDQo+ID4gc2V0IGluIGdtZW0g
c3VjaCB0aGF0IGl0IGtub3dzIGl0IHNob3VsZCB6ZXJvIGl0Lg0KPiANCj4gSWYgdGhlIGFuc3dl
ciBpcyB0aGF0ICJhbHdheXMgemVybyBvbiBwcml2YXRlIHRvIHNoYXJlZCBjb252ZXJzaW9ucyIN
Cj4gZm9yIGFsbCBDQyBWTXMsIHRoZW4gZG9lcyB0aGUgc2NoZW1lIG91dGxpbmVkIGluIFsxXSBt
YWtlIHNlbnNlIGZvcg0KPiBoYW5kbGluZyB0aGUgcHJpdmF0ZSAtPiBzaGFyZWQgY29udmVyc2lv
bnM/IEZvciBwS1ZNLCB0aGVyZSBjYW4gYmUgYQ0KPiBWTSB0eXBlIGNoZWNrIHRvIGF2b2lkIHRo
ZSB6ZXJvaW5nIGR1cmluZyBjb252ZXJzaW9ucyBhbmQgaW5zdGVhZCBqdXN0DQo+IHplcm8gb24g
YWxsb2NhdGlvbnMuIFRoaXMgYWxsb3dzIGRlbGF5aW5nIHplcm9pbmcgdW50aWwgdGhlIGZhdWx0
IHRpbWUNCj4gZm9yIENDIFZNcyBhbmQgY2FuIGJlIGRvbmUgaW4gZ3Vlc3RfbWVtZmQgY2VudHJh
bGx5LiBXZSB3aWxsIG5lZWQgbW9yZQ0KPiBpbnB1dHMgZnJvbSB0aGUgU0VWIHNpZGUgZm9yIHRo
aXMgZGlzY3Vzc2lvbi4NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NB
R3RwckgtODNFT3o4cnJVakUrTzhtN25VRGp0PVRIeVh4PWtmZnQxeFFyeTY1bXRRZ0BtYWlsLmdt
YWlsLmNvbS8NCg0KSXQncyBuaWNlIHRoYXQgd2UgZG9uJ3QgZG91YmxlIHplcm8gKHNpbmNlIFRE
WCBtb2R1bGUgd2lsbCBkbyBpdCB0b28pIGZvcg0KcHJpdmF0ZSBhbGxvY2F0aW9uL21hcHBpbmcu
IFNlZW1zIG9rIHRvIG1lLg0KDQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IFVwIHRoZSB0aHJl
YWQgVmlzaGFsIHNheXMgd2UgbmVlZCB0byBzdXBwb3J0IG9wZXJhdGlvbnMgdGhhdCB1c2UgaW4t
cGxhY2UNCj4gPiA+ID4gY29udmVyc2lvbiAob3ZlcmxvYWRlZCB0ZXJtIG5vdyBJIHRoaW5rLCBi
dHcpLiBXaHkgZXhhY3RseSBpcyBwS1ZNIHVzaW5nDQo+ID4gPiA+IHByaXZhdGUvc2hhcmVkIGNv
bnZlcnNpb24gZm9yIHRoaXMgcHJpdmF0ZSBkYXRhIHByb3Zpc2lvbmluZz8NCj4gPiA+IA0KPiA+
ID4gQmVjYXVzZSBpdCdzIGxpdGVyYWxseSBjb252ZXJ0aW5nIG1lbW9yeSBmcm9tIHNoYXJlZCB0
byBwcml2YXRlPyAgQW5kIElJQ1UsDQo+ID4gPiBpdCdzDQo+ID4gPiBub3QgYSBvbmUtdGltZSBw
cm92aXNpb25pbmcsIGUuZy4gbWVtb3J5IGNhbiBnbzoNCj4gPiA+IA0KPiA+ID4gICBzaGFyZWQg
PT4gZmlsbCA9PiBwcml2YXRlID0+IGNvbnN1bWUgPT4gc2hhcmVkID0+IGZpbGwgPT4gcHJpdmF0
ZSA9PiBjb25zdW1lDQo+ID4gPiANCj4gPiA+ID4gSW5zdGVhZCBvZiBhIHNwZWNpYWwgcHJvdmlz
aW9uaW5nIG9wZXJhdGlvbiBsaWtlIHRoZSBvdGhlcnM/IChYaWFveWFvJ3MNCj4gPiA+ID4gc3Vn
Z2VzdGlvbikNCj4gPiA+IA0KPiA+ID4gQXJlIHlvdSByZWZlcnJpbmcgdG8gdGhpcyBzdWdnZXN0
aW9uPw0KPiA+IA0KPiA+IFllYSwgaW4gZ2VuZXJhbCB0byBtYWtlIGl0IGEgc3BlY2lmaWMgb3Bl
cmF0aW9uIHByZXNlcnZpbmcgb3BlcmF0aW9uLg0KPiA+IA0KPiA+ID4gDQo+ID4gPiAgOiBBbmQg
bWF5YmUgYSBuZXcgZmxhZyBmb3IgS1ZNX0dNRU1fQ09OVkVSVF9QUklWQVRFIGZvciB1c2VyIHNw
YWNlIHRvDQo+ID4gPiAgOiBleHBsaWNpdGx5IHJlcXVlc3QgdGhhdCB0aGUgcGFnZSByYW5nZSBp
cyBjb252ZXJ0ZWQgdG8gcHJpdmF0ZSBhbmQgdGhlDQo+ID4gPiAgOiBjb250ZW50IG5lZWRzIHRv
IGJlIHJldGFpbmVkLiBTbyB0aGF0IFREWCBjYW4gaWRlbnRpZnkgd2hpY2ggY2FzZSBuZWVkcw0K
PiA+ID4gIDogdG8gY2FsbCBpbi1wbGFjZSBUREguUEFHRS5BREQuDQo+ID4gPiANCj4gPiA+IElm
IHNvLCBJIGFncmVlIHdpdGggdGhhdCBpZGVhLCBlLmcuIGFkZCBhIFBSRVNFUlZFIGZsYWcgb3Ig
d2hhdGV2ZXIuICBUaGF0IHdheQ0KPiA+ID4gdXNlcnNwYWNlIGhhcyBleHBsaWNpdCBjb250cm9s
IG92ZXIgd2hhdCBoYXBwZW5zIHRvIHRoZSBkYXRhIGR1cmluZw0KPiA+ID4gY29udmVyc2lvbiwN
Cj4gPiA+IGFuZCBLVk0gY2FuIHJlamVjdCB1bnN1cHBvcnRlZCBjb252ZXJzaW9ucywgZS5nLiBQ
UkVTRVJWRSBpcyBvbmx5IGFsbG93ZWQgZm9yDQo+ID4gPiBzaGFyZWQgPT4gcHJpdmF0ZSBhbmQg
b25seSBmb3Igc2VsZWN0IFZNIHR5cGVzLg0KPiA+IA0KPiA+IE9rLCB3ZSBzaG91bGQgUE9DIGhv
dyBpdCB3b3JrcyB3aXRoIFREWC4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBhIGZsYWcg
dG8gcHJlc2VydmUgbWVtb3J5IGFzIEkgbWVudGlvbmVkIGluIFsyXS4gSUlVQywNCj4gMSkgQ29u
dmVyc2lvbnMgYXJlIGFsd2F5cyBjb250ZW50LXByZXNlcnZpbmcgZm9yIHBLVk0uDQo+IDIpIFNo
YXJlZCB0byBwcml2YXRlIGNvbnZlcnNpb25zIGFyZSBhbHdheXMgY29udGVudC1wcmVzZXJ2aW5n
IGZvciBhbGwNCj4gVk1zIGFzIGZhciBhcyBndWVzdF9tZW1mZCBpcyBjb25jZXJuZWQuDQo+IDMp
IFByaXZhdGUgdG8gc2hhcmVkIGNvbnZlcnNpb25zIGFyZSBub3QgY29udGVudC1wcmVzZXJ2aW5n
IGZvciBDQyBWTXMNCj4gYXMgZmFyIGFzIGd1ZXN0X21lbWZkIGlzIGNvbmNlcm5lZCwgc3ViamVj
dCB0byBtb3JlIGRpc2N1c3Npb25zLg0KPiANCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvQ0FHdHBySC1Lem4ya09HWjRKdU50VVQ1M0h1Z3c2NE0tX1hNbWh6X2dDaURTNkJBRnRR
QG1haWwuZ21haWwuY29tLw0KDQpSaWdodCwgSSByZWFkIHRoYXQuIEkgc3RpbGwgZG9uJ3Qgc2Vl
IHdoeSBwS1ZNIG5lZWRzIHRvIGRvIG5vcm1hbCBwcml2YXRlL3NoYXJlZA0KY29udmVyc2lvbiBm
b3IgZGF0YSBwcm92aXNpb25pbmcuIFZzIGEgZGVkaWNhdGVkIG9wZXJhdGlvbi9mbGFnIHRvIG1h
a2UgaXQgYQ0Kc3BlY2lhbCBjYXNlLg0KDQpJJ20gdHJ5aW5nIHRvIHN1Z2dlc3QgdGhlcmUgY291
bGQgYmUgYSBiZW5lZml0IHRvIG1ha2luZyBhbGwgZ21lbSBWTSB0eXBlcw0KYmVoYXZlIHRoZSBz
YW1lLiBJZiBjb252ZXJzaW9ucyBhcmUgYWx3YXlzIGNvbnRlbnQgcHJlc2VydmluZyBmb3IgcEtW
TSwgd2h5DQpjYW4ndCB1c2Vyc3BhY2UgIGFsd2F5cyB1c2UgdGhlIG9wZXJhdGlvbiB0aGF0IHNh
eXMgcHJlc2VydmUgY29udGVudD8gVnMNCmNoYW5naW5nIHRoZSBiZWhhdmlvciBvZiB0aGUgY29t
bW9uIG9wZXJhdGlvbnM/DQoNClNvIGZvciBhbGwgVk0gdHlwZXMsIHRoZSB1c2VyIEFCSSB3b3Vs
ZCBiZToNCnByaXZhdGUtPnNoYXJlZCAgICAgICAgICAtIEFsd2F5cyB6ZXJvJ3MgcGFnZQ0Kc2hh
cmVkLT5wcml2YXRlICAgICAgICAgIC0gQWx3YXlzIGRlc3RydWN0aXZlDQpzaGFyZWQtPnByaXZh
dGUgKHcvZmxhZykgLSBBbHdheXMgcHJlc2VydmVzIGRhdGEgb3IgcmV0dXJuIGVycm9yIGlmIG5v
dCBwb3NzaWJsZQ0KDQoNCkRvIHlvdSBzZWUgYSBwcm9ibGVtPw0KDQo=

