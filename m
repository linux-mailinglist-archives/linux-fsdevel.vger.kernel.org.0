Return-Path: <linux-fsdevel+bounces-49306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAACABA571
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 23:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555DF4E741B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6447D278741;
	Fri, 16 May 2025 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr4gTF+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3414B1E64;
	Fri, 16 May 2025 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431765; cv=fail; b=nfzmX31GeDU0IJt0sImq1oatXVZc1wXrJSz3WIsHj48bdysrAED3vIoD57+usWk3dIkpjWyJdv/5PF9uhKhFSt6VIZKxzJ8J8cEMGjbNU1GqYQfld+eE2naAFx1FSJjjP0Nno2mYYB86ijS7MeuL2tO7BYIUHcaMK4C6cc9kgZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431765; c=relaxed/simple;
	bh=oLQLvmwhzsUoawSxdSb7BpImqaenVCgYfRJOgkEK5Dk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p5tzFp87w6rq+vfxFoL3lhh1Pwjzx9eoYKY6AQeGn+beV87+eD4/ZDa3WYfO2W9Xt5z0/GlWLpJVCRX4CWKRnvYmcn1DZQsJd6E+nyL1IxNHkB8dpQCclXXI0JBJWaPKPGtF6SmoZofbXwWje4cx39MXW3560OGNpp/3rO3RvO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vr4gTF+f; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747431763; x=1778967763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oLQLvmwhzsUoawSxdSb7BpImqaenVCgYfRJOgkEK5Dk=;
  b=Vr4gTF+fflNCBDN89zATE7orUwpj8otw9nIYbziOREOilWmj3pGQkO4Q
   CFerNR2gv2IVg5rV6qInNREG6kqG7NEAMkKtbhsIew7PHfUmTHAVj87et
   CsGYzDvzxhLxB8j44MXzME/QKdftVXZH1030nGzgeuef1lRQfrAGAhVUf
   r3sYzNZ49Ob6+TP6bnqQg7LrI0i2ZeZpLX0MpbeLUowdER+T/pWJdUN4B
   3q6jDxShZ5/X2vd59Kyyz7lPGEmpFGmjmo22p12dCfIXVbt2J+RXVnFZ3
   a27nL/XDSHU4DyfvVz3lVa37yZDjZ/aNINQ4wYidEzADcby86BRJ2rOwm
   g==;
X-CSE-ConnectionGUID: bJjSNVHASGqXf07pDxpvXw==
X-CSE-MsgGUID: WgoojnCrQriR0CpTyFNrMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="59645958"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="59645958"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 14:42:42 -0700
X-CSE-ConnectionGUID: QxvY5ypfQoynJ48DJVzg8A==
X-CSE-MsgGUID: ccSLV5DhSRqWIR4jPyBxrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="169842672"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 14:42:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 14:42:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 14:42:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 14:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOFoNMnnBJMgRhmtY3lceVXPZGDBJ/9mfhN2/nDlHJvwH/hEn3nZIjx8SNIOjXODhlFTZ7tH1WxLbTyGaDTydMg9vhSFdjRM1839GNSwAvB/5tu6wWBNbMTiKCyaxiDxPT4TzpxO2zZ0kRr7VfnHhEOFQmbHx87QoLaRZnbmsGOJ6qhLxw+NZJQWXaE2X/ZV5cUJNyG9fUMaOJdl+ASLBBaCmgXwo48gOqgtDg8+8ajV+9sAJRFGqKcfDKwkyCbRKjOUegas9v0SI5LwUl15YXvPyj59AKvEoLlQdZzgdpUzgVxcCeiNOYghmXtvykuMPyfKIydUiGMGN7zA5FwTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLQLvmwhzsUoawSxdSb7BpImqaenVCgYfRJOgkEK5Dk=;
 b=O6ip7Vfu4K21/WVGWgksnYMlLAH1yW/wMHP8G9OHbuRNzOOsbC1YiCqJ7S5ymsyDSPgiI3q8KmkTrXV9fqTI3qch+hWsYSeQAh0b1tD878iWcWX+t0tf38ISFF+DI1nopX7h0S2JuCfJtZX6yo2ppYuwAhkiVTVoZlEUSl8w5qqGxONLP7VTQmxNUSMuIyAt/BCbxxqwEy9krLEvkqiImL0KA+bRMLzS3ZCEzS/6B28fpSpup6esl4acgloDJ1oChOxMXqMB+To0EUWnbtMEs4EoepMvMkpP8QrKV5EuAu/PQ8Mdt5XCphfs55qXeHr86kNWYlwvOgDJoXOw1Kuu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6657.namprd11.prod.outlook.com (2603:10b6:510:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 21:42:35 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8722.020; Fri, 16 May 2025
 21:42:35 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "pvorel@suse.cz" <pvorel@suse.cz>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "Shutemov, Kirill"
	<kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "amoorthy@google.com"
	<amoorthy@google.com>, "tabba@google.com" <tabba@google.com>,
	"maz@kernel.org" <maz@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "quic_svaddagi@quicinc.com"
	<quic_svaddagi@quicinc.com>, "keirf@google.com" <keirf@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "Du, Fan" <fan.du@intel.com>, "aik@amd.com" <aik@amd.com>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "Wang, Wei W"
	<wei.w.wang@intel.com>, "fvdl@google.com" <fvdl@google.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "bfoster@redhat.com"
	<bfoster@redhat.com>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "willy@infradead.org" <willy@infradead.org>,
	"steven.price@arm.com" <steven.price@arm.com>, "quic_eberman@quicinc.com"
	<quic_eberman@quicinc.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mic@digikod.net" <mic@digikod.net>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "nsaenz@amazon.es"
	<nsaenz@amazon.es>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "Li, Zhiquan1"
	<zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, "Aktas,
 Erdem" <erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"hughd@google.com" <hughd@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "anup@brainfault.org"
	<anup@brainfault.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
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
	<quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "will@kernel.org"
	<will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrPT/RKAgAAK44CAAFGtgIAAFymAgAAUsICAALhjAIAAO8yAgAASaACAABcrgIAAE7MAgAAVmQA=
Date: Fri, 16 May 2025 21:42:35 +0000
Message-ID: <fbb240fef8b7091ece5f88f394adebe19aec35ba.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
	 <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
	 <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
	 <aCaM7LS7Z0L3FoC8@google.com>
	 <7d3b391f3a31396bd9abe641259392fd94b5e72f.camel@intel.com>
	 <CAGtprH8EMnmvvVir6_U+L5S3SEvrU1OzLrvkL58fXgfg59bjoA@mail.gmail.com>
	 <ce15353884bd67cc2608d36ef40a178a8d140333.camel@intel.com>
	 <aCd5wZ_Tp863I6pP@google.com>
	 <8e783fa6ee3997567c661e5c10b05b5d456382fb.camel@intel.com>
	 <1c004de5-4132-49f2-bbf2-6a0517f25d58@intel.com>
In-Reply-To: <1c004de5-4132-49f2-bbf2-6a0517f25d58@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6657:EE_
x-ms-office365-filtering-correlation-id: 00dc5d4d-7778-4146-5aab-08dd94c2924b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NWJaY0dpYXdndmliR3dWVnBIcHB1ajFnWG9BUTliV21HMjI5R2ZWUkkyWEdE?=
 =?utf-8?B?ZFYzbUluY20zNVRYS0ZJVTRyVEV5clplNkpuR1NlMWRwWDB4ZDE1MlRrTTZX?=
 =?utf-8?B?M21Ibkk2SDRRaDh6NmJJWXNRbC9EY2lpaGVrLytlejZSNmRYOXFYV2Zja0Jp?=
 =?utf-8?B?YmVWeTFNTzFQRHJYVkh4TG9IQVlCWWh1SDJ6YU9iTHh6WTRNUWRnRW5DSW9m?=
 =?utf-8?B?Z1lCdFNFMDJqWWFxc0M3WHdXVHRvWmZINUpDRjByK21yNjZ6NU5RTnhjMlVh?=
 =?utf-8?B?QU1KcUF4YU8vUFZhdEl6TCtXa055TzdUZDk1K1Q0d3ROWURQejNTcTQ4a2F4?=
 =?utf-8?B?QWM3bUNhUG1wQUtERGRaV0xnSkh0RVl2MmVVbHNJVkpScTNHTUdEQ3poUFFF?=
 =?utf-8?B?cWVIVzFaSCtjVjlCVkZRaDVrRDNMNEkrbW1YRVI4Mk5TUlVxc0swRkRJSkp6?=
 =?utf-8?B?VHJmV2kwV2huWHRYMVZFUS9Pai9jU3BRdnQxWS90R2dMNU5GRXdiQlpIZEd3?=
 =?utf-8?B?dm5BZEw5T09weUoyeC9yZEdDNFJLV2J3S2xwb2lTT0F1MzJxUCtMMUZjTDE4?=
 =?utf-8?B?ZVhobFU5RjErN0NGTWxvQjFwZDBqNFJhalEvejBsTlQwOVB6M1NmejJBVE12?=
 =?utf-8?B?OUIzRUEwMDdMd2p5Q1VPY1VrTURGTHZVMjlpMDg4dlk3NSt0RHgwejlOWjgw?=
 =?utf-8?B?a24vZlF6WHhrY2FBY0JVbVZMd2k1eEY3ODdaVjhqZkZBTEk4RUZiQ0FhL2pB?=
 =?utf-8?B?YldDUlNPZk5yenh4NERUTU9wK1dVbE1kT1hja0JRa00yY3o3Y0NoVm9qd2Zl?=
 =?utf-8?B?QXV5RktYd2hQUDlDeDJMNExWd0J6WGpaQUFYL2RsQVNjRzQ4RFg3dnpqRlIv?=
 =?utf-8?B?MTNjMnBsZ0oraTZBZDVtdEN5RTR2L015NERadXpjb2M0ckEvMFEwNDB1enVs?=
 =?utf-8?B?cWZ5S25RenY2Vk1kaXdjN0RLWldscXNDZ0VXWE1manFxV3h2YUJ1Qkwwc0g1?=
 =?utf-8?B?QmlsMDZVZlVGWUVTbDg3RjA5STV1QzVxeERDYTc1VDlCTXZQaVdRalp0L2ww?=
 =?utf-8?B?TVhTdHAzWW1RNEhLRTRBQXlNVmJEMDFtWUprd0JBdERLQk0vRkRjV0JwNXhq?=
 =?utf-8?B?VDREc0lrMGdSMGJ1K2NobGRjdmd4bjA0QTZiY1orcXZYSkNyT0xYQW5WR2E2?=
 =?utf-8?B?VzArSFJYYjc0WEYwZUVzV2l6M21hRE5CaHcvbDArY0ZQUzRmcE9lM2hhVmF6?=
 =?utf-8?B?R3BTWVRtQ1hBYzZML3JPdFRnMXFIRGdjTHZNeVYyYS9JWm44RnhFbFJNRXNi?=
 =?utf-8?B?blgwa3gvTi9teW00QThabVFIVXdrNDUxUHJXaU4zeGY5RlBOb0tyR3FlMWNy?=
 =?utf-8?B?bHJlQWg4MUdsWUloWW1wc1VSYWRMOURXdFBjMGZDYm0xenQ4cWc3UmNRSkxr?=
 =?utf-8?B?Z0NSNlZDbzdBQlNITXpwVEw4MmQ0R0FyMndvakNlU2hiWjVvbEYwQ1RKZ1V1?=
 =?utf-8?B?RnZvbUNCRWhZTk5SaCtCRi80YzMyYm9vNGhSa3F3Z3N0em1uK1hWalVYcjYz?=
 =?utf-8?B?ZytDNWFyTm8wVUJKVXJha0ZnL3R6Q250TTJ4bjZ4aUVNZFdXQ1ZCb3F5N1p3?=
 =?utf-8?B?REFBdDlaYThzSlA3Y1FhSnVGN0lIU29jd2wyM0JLRkNWTktaZ2dLZS9yejkv?=
 =?utf-8?B?b3dzR0lob1ppMTU5ejQ4dzg0Y2lZVEsrTjZOWS9Od0xLMTd0bXJmeXhHb3N2?=
 =?utf-8?B?bjJxNGhrYXlZMmVETzZRYjk5ZitzYWdSSzNFd0xWUTJnSWxwaGFHalJwMXhv?=
 =?utf-8?B?VVNQWlVtZys0R2l0NUpWajIySWdYekIxV0RrZVlDc2lnWlE5dERFWVpnbTJz?=
 =?utf-8?B?aFd0WVY1TXA2ZUErWVdmSjZqWHZuL203Zzd4SHlJWDlPUThHSWcyMXFnSnlZ?=
 =?utf-8?B?VVA2djZ6TVdkNEJuMER4RFo5SXBhUXdrbThyWEJmTnJMeWJrSXg4N3hKWWxV?=
 =?utf-8?B?emYwRkpjTHFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0MzNzRUN2ZWQWhwcmtYcG5zOG5kRTk2UUNob2xNYUNWV1hjRnhDQUgveDdP?=
 =?utf-8?B?b3V5NTBrYzJ6T1Y5RWsvRE9BOTVqM2lWNURwZG9aMXNuQlpGUjZBYnVwS3lu?=
 =?utf-8?B?WHNUbC9za1VScHlsWTZzTnpyNU1tL3c5eW1OaklhRkVGVW9XK21BSEtxaUNP?=
 =?utf-8?B?TW5sK2VOTzRmMzdnYlBVdkY1a3hRbkJxbCt2ZlMzL3kzZTQ0YWQ3K3ZkcUsr?=
 =?utf-8?B?MTlKeW5qUno3VlNhQ3lOQ2w4YXd6RTk5L2wveTc0bHNVV3hpYkdHakZ0RDlC?=
 =?utf-8?B?YU1rTnJVNnJlNjU1dWFYVU5oU1VFVVFadzVMQTdTU1VITzdtT01Qd0pVc0do?=
 =?utf-8?B?Q2UyTktaRk1DZS9qalVwLzAzSERMRThqeU9WKy9tTDRJNVhJQ213cStPNWhL?=
 =?utf-8?B?U2JJclUwaDRzQlowcU5LY3J5WVVVV3Fvdk5DakRCQXQ4Q3JpSVBHcWRHbzBm?=
 =?utf-8?B?OUZ5SHVXd3Q0ZS9zNnJKZEEzLy9XM3paMkd2cU1kOEVUa09PNTlVTWtvQlY4?=
 =?utf-8?B?eEFzOFk1TEZ3UDBHL3ZkeXZ0eWxKenFTVFVBaStncnIwU04yS0ZzempVdDNR?=
 =?utf-8?B?Tmp1M3hDNG9qWWJyMWtvMUFYb0JZTGNCdWxhKzVzMEhQeXNtcWNJUFdlUGlt?=
 =?utf-8?B?V3hZNzBTY0lYMXUvQlpBZndSVUZaZkl4VlZRditFK05kVUlxOUJoYVp1MzAw?=
 =?utf-8?B?Uk8vdFhmVmlHZFZPMlY2RzJsT291aFZVSGZnQ2toOFkvSVpOcWhieG9DUElX?=
 =?utf-8?B?cHQwOWxBWVhBNTVqeVB2MGNZb1N6TVVaZkxGSndENmZITEsxMXJTSHhZV09k?=
 =?utf-8?B?bytkNlEraVRleElwRVhnNmVrL01od2VNendCVUhYeDZWekplM2w3YXlkbFdG?=
 =?utf-8?B?L1VZT01RWWN0WkQ5MVJmdzI1L0lDaEJnK3hGTHRXV3RMeTN6RFBIb0RqQ3U2?=
 =?utf-8?B?eEdvYURRR1pHRnZzUjlVVHVlUzZIVDVQOUI0SWhsZmlPSWU4NEJuY3RmSnRH?=
 =?utf-8?B?TDcvSzhJaFV1eU44MUVmNEc0TTlWN0pOMFhNZW5HZHZKbEE4YlVrUVhhRE1u?=
 =?utf-8?B?RXRQNkEyYnJDVG4zL1E2S3JTWGFDQmFOWndMQmJLQWx5UEU0UEI5ZFRJYm5Q?=
 =?utf-8?B?djE2blpzQnBhL2JjcGFTVFBSVTJuRlNQYXFMMzdqdzlNbzh6K2NCbkFqSzF4?=
 =?utf-8?B?NXNLczh6QTBKK0dNTGVVd05VSllKTEwydlFqcFhHK054VTlqb2g3bmxiaTE4?=
 =?utf-8?B?L2NVRU1BSEt4OHJZdnJxbTBLSlE4U3BrdjhDNk1tS0JPOW1kMkk0Y0phMG1i?=
 =?utf-8?B?cUcrcUVvME1rZ3RIc3FGZ09lTTZEWG5TRDJNUzFDdUcrVE1sZ2JGdDBJdXBB?=
 =?utf-8?B?c2UwSGN1SC9yLzVRT25pYUk3WWt4YnhhVkl0RXpHU0VOZVBkZzdsL3dObGhU?=
 =?utf-8?B?RG04blg3QUhQeXgra1pFektmMEcxTW1VWElTNC9Bd01CUytqMXE2RzlwK2J5?=
 =?utf-8?B?VGJzR3JTanc4N3NaWWJqOVdCMjNrT0hHYWloVDJScGtQRi9BTUR2WFpRclgy?=
 =?utf-8?B?Y3RQMEZiVjVpSjdnWnd0UlVhNUEvY2xKT0VRNWF4Y2RzOTQ2ZVFJdkhsL01k?=
 =?utf-8?B?UC9xZ2plRzFpajBHWEdNR0pVMmJjdTFuL1NjNU5zM0FvWGozSVl4TEw3MzBr?=
 =?utf-8?B?blBudUwyTFFBcVNrUytRRkI1cm9nMTFXQ2xJaUJqYTd0QnNPRmJiVzBjbHNi?=
 =?utf-8?B?YThoRjcxdXVGYytVSmpIcWxJWGU4Q20xMzVnaWxJb29PM1BMdXV2OGwrQzFG?=
 =?utf-8?B?eCs4amo4dnEvbTFCeXNHbVFDeWFEcUVQQTBjeXpFZ1pxNUhvUkF1anJhR3F3?=
 =?utf-8?B?SEdQSis1VkJZWHJCTlRXdjR6SnV3NS9LVkdnWDJJRkhHd1g3bVY5ZWpLV0Na?=
 =?utf-8?B?a01FL2xINEFBbTdLdHN2WGpnUnNXVVplOElDUCt1OG1aVmxsNko1L2JrODdK?=
 =?utf-8?B?c0RwOFJRR3ZtWE4yUElYNmk0VTJnNVZ3blV3Q0c1K1BqbXp5WHd0QzR5WlpJ?=
 =?utf-8?B?cUtlczJUTWpGK3Vud3lUclpTcFpsUDlZYStxZktpMzhwWFBTcTIwR01mUlU1?=
 =?utf-8?B?QnZjOXdyRTVLemdrSVRSWU5YdTduVXNhVHJRV3lHQUtlS1IrNURFOUkxVUgz?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B61CE6F8020DAA48B22B4D1E1715C24F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dc5d4d-7778-4146-5aab-08dd94c2924b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 21:42:35.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QbClbiBImRGPuaZ1HMvuSYhOu6u0lNA6ZHSUcn+DNAN8zdI0t+/UQFkuh2d1hqXB3BptxyNmvt76n93R6IgRwOgOMxm6l17Z0DrmwjhJu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6657
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA1LTE2IGF0IDEzOjI1IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
SXQncyBhIGxpdHRsZSBtb3JlIGNvbXBsaWNhdGVkIHRoYW4ganVzdCB0aGUgZGVwdGggb2YgdGhl
IHdvcnN0LWNhc2Ugd2Fsay4NCj4gDQo+IEluIHByYWN0aWNlLCBtYW55IHBhZ2Ugd2Fsa3MgY2Fu
IHVzZSB0aGUgbWlkLWxldmVsIHBhZ2luZyBzdHJ1Y3R1cmUNCj4gY2FjaGVzIGJlY2F1c2UgdGhl
IG1hcHBpbmdzIGFyZW4ndCBzcGFyc2UuDQo+IA0KPiBXaXRoIDUtbGV2ZWwgcGFnaW5nIGluIHBh
cnRpY3VsYXIsIHVzZXJzcGFjZSBkb2Vzbid0IGFjdHVhbGx5IGNoYW5nZQ0KPiBtdWNoIGF0IGFs
bC4gSXRzIGxheW91dCBpcyBwcmV0dHkgbXVjaCB0aGUgc2FtZSB1bmxlc3MgZm9sa3MgYXJlIG9w
dGluZw0KPiBpbiB0byB0aGUgaGlnaGVyICg1LWxldmVsIG9ubHkpIGFkZHJlc3Mgc3BhY2UuIFNv
IHVzZXJzcGFjZSBpc24ndA0KPiBzcGFyc2UsIGF0IGxlYXN0IGF0IHRoZSBzY2FsZSBvZiB3aGF0
IDUtbGV2ZWwgcGFnaW5nIGlzIGNhcGFibGUgb2YuDQo+IA0KPiBGb3IgdGhlIGtlcm5lbCwgdGhp
bmdzIGFyZSBhIGJpdCBtb3JlIHNwcmVhZCBvdXQgdGhhbiB0aGV5IHdlcmUgYmVmb3JlLg0KPiBG
b3IgaW5zdGFuY2UsIHRoZSBkaXJlY3QgbWFwIGFuZCB2bWFsbG9jKCkgYXJlIGluIHNlcGFyYXRl
IHA0ZCBwYWdlcw0KPiB3aGVuIHRoZXkgdXNlZCB0byBiZSBuZXN0bGVkIHRvZ2V0aGVyIGluIHRo
ZSBzYW1lIGhhbGYgb2Ygb25lIHBnZC4NCj4gDQo+IEJ1dCwgYWdhaW4sIHRoZXkncmUgbm90ICp0
aGF0KiBzcGFyc2UuIFRoZSBkaXJlY3QgbWFwLCBmb3IgZXhhbXBsZSwNCj4gZG9lc24ndCBiZWNv
bWUgbW9yZSBzcGFyc2UsIGl0IGp1c3QgbW92ZXMgdG8gYSBsb3dlciB2aXJ0dWFsIGFkZHJlc3Mu
DQo+IERpdHRvIGZvciB2bWFsbG9jKCkuwqAgSnVzdCBiZWNhdXNlIDUtbGV2ZWwgcGFnaW5nIGhh
cyBhIG1hc3NpdmUNCj4gdm1hbGxvYygpIGFyZWEgZG9lc24ndCBtZWFuIHdlIHVzZSBpdC4NCj4g
DQo+IEJhc2ljYWxseSwgNS1sZXZlbCBwYWdpbmcgYWRkcyBhIGxldmVsIHRvIHRoZSB0b3Agb2Yg
dGhlIHBhZ2Ugd2FsaywgYW5kDQo+IHdlJ3JlIHJlYWxseSBnb29kIGF0IGNhY2hpbmcgdGhvc2Ug
d2hlbiB0aGV5J3JlIG5vdCBhY2Nlc3NlZCBzcGFyc2VseS4NCj4gDQo+IENQVXMgYXJlIG5vdCBh
cyBnb29kIGF0IGNhY2hpbmcgdGhlIGxlYWYgc2lkZSBvZiB0aGUgcGFnZSB3YWxrLiBUaGVyZQ0K
PiBhcmUgdHJpY2tzIGxpa2UgQU1EJ3MgVExCIGNvYWxlc2NpbmcgdGhhdCBoZWxwLiBCdXQsIGdl
bmVyYWxseSwgZWFjaA0KPiB3YWxrIG9uIHRoZSBsZWFmIGVuZCBvZiB0aGUgd2Fsa3MgZWF0cyBh
IFRMQiBlbnRyeS4gVGhvc2UganVzdCBkb24ndA0KPiBjYWNoZSBhcyB3ZWxsIGFzIHRoZSB0b3Ag
b2YgdGhlIHRyZWUuDQo+IA0KPiBUaGF0J3Mgd2h5IHdlIG5lZWQgdG8gYmUgbW9yZSBtYW5pYWNh
bCBhYm91dCByZWR1Y2luZyBsZWFmIGxldmVscyB0aGFuDQo+IHRoZSBsZXZlbHMgdG93YXJkIHRo
ZSByb290Lg0KDQpNYWtlcyBzZW5zZS4gRm9yIHdoYXQgaXMgZWFzeSBmb3IgdGhlIENQVSB0byBj
YWNoZSwgaXQgY2FuIGJlIG1vcmUgYWJvdXQgdGhlDQphZGRyZXNzIHNwYWNlIGxheW91dCB0aGVu
IHRoZSBsZW5ndGggb2YgdGhlIHdhbGsuDQoNCkdvaW5nIG9mZiB0b3BpYyBmcm9tIHRoaXMgcGF0
Y2hzZXQuLi4NCg0KSSBoYXZlIGEgcG9zc2libHkgZnVuIHJlbGF0ZWQgYW5lY2RvdGUuIEEgd2hp
bGUgYWdvIHdoZW4gSSB3YXMgZG9pbmcgdGhlIEtWTSBYTw0Kc3R1ZmYsIEkgd2FzIHRyeWluZyB0
byB0ZXN0IGhvdyBtdWNoIHdvcnNlIHRoZSBwZXJmb3JtYW5jZSB3YXMgZnJvbSBjYWNoZXMgYmVp
bmcNCmZvcmNlZCB0byBkZWFsIHdpdGggdGhlIHNwYXJzZXIgR1BBIGFjY2Vzc2VzLiBUaGUgdGVz
dCB3YXMgdG8gbW9kaWZ5IHRoZSBndWVzdA0KdG8gZm9yY2UgYWxsIHRoZSBleGVjdXRhYmxlIEdW
QSBtYXBwaW5ncyB0byBnbyBvbiB0aGUgWE8gYWxpYXMuIEkgd2FzIGNvbmZ1c2VkDQp0byBmaW5k
IHRoYXQgS1ZNIFhPIHdhcyBmYXN0ZXIgdGhhbiB0aGUgbm9ybWFsIGxheW91dCBieSBhIHNtYWxs
LCBidXQgY29uc2lzdGVudA0KYW1vdW50LiBJdCBoYWQgbWUgc2NyYXRjaGluZyBteSBoZWFkLiBJ
dCB0dXJuZWQgb3V0IHRoYXQgdGhlIE5YIGh1Z2UgcGFnZQ0KbWl0aWdhdGlvbiB3YXMgYWJsZSB0
byBtYWludGFpbiBsYXJnZSBwYWdlcyBmb3IgdGhlIGRhdGEgYWNjZXNzZXMgYmVjYXVzZSBhbGwN
CnRoZSBleGVjdXRhYmxlIGFjY2Vzc2VzIHdlcmUgbW92ZWQgb2ZmIG9mIHRoZSBtYWluIEdQQSBh
bGlhcy4NCg0KTXkgdGFrZWF3YXkgd2FzIHRoYXQgdGhlIHJlYWwgd29ybGQgaW1wbGVtZW50YXRp
b25zIGNhbiBpbnRlcmFjdCBpbiBzdXJwcmlzaW5nDQp3YXlzLCBhbmQgZm9yIGF0IGxlYXN0IG15
IGFiaWxpdHkgdG8gcmVhc29uIGFib3V0IGl0LCBpdCdzIGdvb2QgdG8gdmVyaWZ5IHdpdGggYQ0K
dGVzdCB3aGVuIHBvc3NpYmxlLg0K

