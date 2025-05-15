Return-Path: <linux-fsdevel+bounces-49203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75051AB92D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015F34E79B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6119A2918FE;
	Thu, 15 May 2025 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJhizAFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2A28032E;
	Thu, 15 May 2025 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747352120; cv=fail; b=XdLxfdiF7XpROvV0EY2f/BCjwmaTJtmoHWYDJS2+v+acNdv+5GDaAK5nBYTWagfip3BevWifj8028ydQmD/60TPZqwlf6gYvc/yMEWZJwMmOb71G9MESQshJpRbyWoZtIzcvSTZsiu8xLLbDTiHXGRradwKwmOKVKG1rGyhx2No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747352120; c=relaxed/simple;
	bh=iv5RtdxjR+BV/snS2YVuqOtVc2pmKyHrvUD34YVW4k4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQItcGQV/Z7EVDsBxM1TWFW8YvfC4vE9n37Bo2ubpjJa90tM3WbjVCdlTy7k/7M+TK6DNO3t+TT3aEQcn9N9iH+XaeDZ6iB2iy1UwweUyPPo5ADmdO8uRuvbg+9+tUgn+uzzq0EC+7dHyFTBvm57mkaHX+hx2NYdcOnFP9Xh0Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJhizAFn; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747352119; x=1778888119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iv5RtdxjR+BV/snS2YVuqOtVc2pmKyHrvUD34YVW4k4=;
  b=OJhizAFn8Vf4IPuL6pIhgiO2BjhfSp0UfCJDuCJLj2lRBU8tQGm+Z89O
   W9hxVqI2q//kK5WgiMSdYyg2OhNbkdeQyli7vObZMzL/oxYElmlCPZIyP
   4o/G+tVeVB5LIyiD75kleHliJiJN/SJNE/uYPQ4My/Bp+vasIOGtYDJsM
   RJ2LjgadfczE4gbCqLMMfTw0/1pmJwdUwP/YWpY/cSls0YWp7rG4DFqFp
   4EMZGCfP/4i8I1/t9vUK4hmHjuRbFnwvFWUyfY9SRUe+/ryv3W22Ih4at
   I+wMmPb0Dh1aWn4LIOyYtrLRE3W9zYAZQgHv+923B8psR1GgwUL5axqdG
   g==;
X-CSE-ConnectionGUID: zGAuw2CkQ/+vqVkgVWdt2w==
X-CSE-MsgGUID: +rur7DB2TFSK1zY2huCvsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49212643"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="49212643"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 16:35:17 -0700
X-CSE-ConnectionGUID: NtlyQgUYT3i/e1qkN8cbjQ==
X-CSE-MsgGUID: 8+ZZKhtNTyKXF437cLdhNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="161826358"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 16:35:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 16:35:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 16:35:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 16:35:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgOo63c0mKl/RfcYAcg+lLCN/fR8VLYOSVO1nXBlKxx+HENaRU+7XHM6rk/tcDNm72yZEZ5qes9ZwF0/3ZNM0xt6Ren6rj72MS204CRFn0JYPl4UlEW80nwr2ID7aNGkX4gcUTxE3ow0jb0814VfhAMjqlkcarpj1ICI1jryGtmXB3XgDdcSyx+KizY4lqspHPb/56chdR0OVCsFpiWhFLVGil3KG+b4U2TJMKAEnbdj36bCwCKPO7vYMz9/mb0VBLBAd10WGvEowFlpE6OMbnqAcaEEebugSg3oPt6YBWYWyef7XjeA9TXLWNL3PeuMGw2yUnUWH+LJ/mB15lp4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv5RtdxjR+BV/snS2YVuqOtVc2pmKyHrvUD34YVW4k4=;
 b=kQAd3X9R3vpfXySC2cYAWSWNBGrtWWPWRe5CXQ4dNqvGXRcrBynKI6S+EqcB7cM3x2BA0Gw8RlaAnxN5elAlxAaR563hfhTpV3DDbcLFGhcLIvzkNpaA4pUYzHIj1gV1wLt8TupppjLAck5Wc51R+1hPROyJSrApFKD7BDmhwf0AytO8Bd0llaseJs+ViMoqUGXiGQU+bXzbI3yX7/xsoE8PtXea+xxiYM2BrKAQH7jL7sX0p96VgeItRB4UxvG10XzATkF346OR+oEbls7PT3NtRAROP7SkZAL2xlh5EYgqSRl6vqJGK+VJf5futnbDxUrzvCTJZ67PjjhrV/QE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 23:35:04 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.8722.020; Thu, 15 May 2025
 23:35:04 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"Miao, Jun" <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>,
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org"
	<x86@kernel.org>, "tabba@google.com" <tabba@google.com>, "keirf@google.com"
	<keirf@google.com>, "quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>,
	"amoorthy@google.com" <amoorthy@google.com>, "pvorel@suse.cz"
	<pvorel@suse.cz>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "Wang, Wei W" <wei.w.wang@intel.com>,
	"jack@suse.cz" <jack@suse.cz>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "quic_mnalajal@quicinc.com"
	<quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "willy@infradead.org"
	<willy@infradead.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"bfoster@redhat.com" <bfoster@redhat.com>, "quic_cvanscha@quicinc.com"
	<quic_cvanscha@quicinc.com>, "Du, Fan" <fan.du@intel.com>, "fvdl@google.com"
	<fvdl@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "mic@digikod.net" <mic@digikod.net>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"steven.price@arm.com" <steven.price@arm.com>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"rientjes@google.com" <rientjes@google.com>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "Aktas, Erdem" <erdemaktas@google.com>,
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"hughd@google.com" <hughd@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "anup@brainfault.org"
	<anup@brainfault.org>, "maz@kernel.org" <maz@kernel.org>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>,
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "Huang, Kai" <kai.huang@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, "nikunj@amd.com" <nikunj@amd.com>, "Graf,
 Alexander" <graf@amazon.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "jroedel@suse.de"
	<jroedel@suse.de>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"jgowans@amazon.com" <jgowans@amazon.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "qperret@google.com" <qperret@google.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "pgonda@google.com" <pgonda@google.com>,
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "hch@infradead.org"
	<hch@infradead.org>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Topic: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Thread-Index: AQHbxSn/oJ+2/ue6ME25PZzqtT0pGrPT/RKAgAAK44CAAFGtgA==
Date: Thu, 15 May 2025 23:35:04 +0000
Message-ID: <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
	 <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
	 <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
In-Reply-To: <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB4907:EE_
x-ms-office365-filtering-correlation-id: e8334beb-fe1e-40e4-0024-08dd94091e72
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L3VWOUNya1AySmFkUk9LbGkxMzZOdXA1cEg1TnFpTnR4MTR1QnVFTS9yWkZr?=
 =?utf-8?B?Z011RitQSXJORkhRWnY0MDZmNk1yMFNuaFpXdDNCd1dLT1ZuUUhaQ29RRkFO?=
 =?utf-8?B?czI2QVNWZlFmU3RGZWM3NkhRckVmaTlMS2lZd0NmT21DSG13Z09ybTZsZFZY?=
 =?utf-8?B?MzF2eWlreDZHVHV4dXRvekZlODdLQTdWY0dYOWVFT2VmNXJVNXB5eG1hdGkr?=
 =?utf-8?B?ME9JbnlSSHp0cFc4OER3Q3VNYU1HL3NLMG9FNHVhZE1Zb01RQS9mV2xQRlZR?=
 =?utf-8?B?Rm05dVdMNmM1azhrMSs1UXpSWmJzK01aMTVkMjR5aGxGUTU3UWxSNGVMZUdq?=
 =?utf-8?B?R1cvdkx3NUhoOTNRd0FFa1pHQ0s2eGxvem1MKzJuSzlWQVNDYzU1RGJrUDVT?=
 =?utf-8?B?ZVc5MG9OQWxjQ0NVUlBnYVBodXdYSTQwbEhSZEFqVHRhZE42c2MwZVRGZHFK?=
 =?utf-8?B?ai95TkxNZzd2SHhWZFhoSWJwMmRVbERPL2ZsMkZnRzRZODlLZXhDMUo4ODNR?=
 =?utf-8?B?a2lZSEVLeHRnTXFoK0RJc0pNWU94NFQzWWxTbm1BMXhoT01aZGtEVmNVNzZF?=
 =?utf-8?B?WG5pcm1FOHMycURaUytJNjFkS1RmUlBCTXV2TEdmRmVhQ0VkMEdLNFpaSmkw?=
 =?utf-8?B?V1dpV2dRY3NtcFZ5UHNuTkxkaHZpTGpqc01LTDVySVJJeTRXbm1tanlhNmVT?=
 =?utf-8?B?S0U2V0s3TGsxY05pbTQ1R014dHJLdFZzcmJCTmdpRThFektxVjkzK2RwSGRR?=
 =?utf-8?B?MlcrUGVEVEpwVU83S2lXS2dRYnRjNGpOdEJldnlDdVRVM3QwN0crTmlSbk5G?=
 =?utf-8?B?am9ZdmlUbHAxTGdBNXVteTlGQWRCK3pMUUExUGp2dXl2WVd3K3pmY1hQVlJW?=
 =?utf-8?B?SUJMcDhLYlRHaXhyN0JsNjMxY0NFdk1qd2VGNkV2bTJpU2o4QUhacklqLzRK?=
 =?utf-8?B?T2tjWGl2L0tVZVZZN281UmdUMlk1SE92ZXlRaHZyWC9wREdQc2t5MDhiVzhL?=
 =?utf-8?B?MkFtb0ttVkJuV2RhTHMwL0ZLWnZxNERCdnlxU1ZtWW5CSldsT0NPcDVxZXNP?=
 =?utf-8?B?N1U5WVllK0NPdjB2WmlrdUlDQmV4N1MvS2pCQkxNY3lON0Fqa1VHWFlXcnZZ?=
 =?utf-8?B?MEJzRE1McVFmQ2dZdnZmcTV6QVBSeUpnMzNPWC9BNWFsY2c3T1JwcldDUnUx?=
 =?utf-8?B?TzZqNERXS05hY2J0Mi9FMEVVV0NaZ05CVGc0dEU5NGNlS0pkeHhFMWFlZTVP?=
 =?utf-8?B?TTJKcFJVQi9VUzhzNWVJMytMZERpNU9aSzhSUGVyZ1VUZXhwTFlTM2M0VWdQ?=
 =?utf-8?B?UUUzeXFKczAzTGdVVFM3NlhmVDFyVWg5VERKNnBNTkY1Tmg4OTlROWN4SnB1?=
 =?utf-8?B?amxjQmNMc3BJZ01rV1hIakFURGNqbGRjZnRGVzVWVDRoUGV2YlRadTV3NXBW?=
 =?utf-8?B?TG14Q0xUOEwzSWx2NDV6RFY3NjU4bXJnaW9CcFdpOWtuelhFa2p6VXl3Kytq?=
 =?utf-8?B?R29BWm4rQXArSlZqckdXWDJGNEZZRnRkQ1R6NzZuZWdDV3dxR240Z2RBZ29U?=
 =?utf-8?B?ZlJINXkvMTZBWlJYS3JCNmJNbHVDUS8rc0dyZlJjeWgyRDJrVDJBRmVhT05N?=
 =?utf-8?B?R2o1c0M5ZUhSdlFnSCtoRXRHZGVxbDhDdWQ3bElTTGxIV1BXWi8vZ1dzMG5Q?=
 =?utf-8?B?TTFzZmhuZWZHc1B6TVJGSTdCM2MxcWdCK1dWSVIydUpTT0F6anU5QzFwdWVr?=
 =?utf-8?B?cG9aUnlFNzRJRi9YbUNQZWlSd3loaWVJZG1sMUkzeWNpaG1tSzZESll3MzJ0?=
 =?utf-8?B?TVE1ZkVqTWNCNUx3L0pxTzlNUDJ0NzZvS081RDcyK0VwOUFhQnJ3Wmh1NTQy?=
 =?utf-8?B?YXVleVdPeDJVdktOQWJsdTcxREpmREU1ZWJHNU84U1hZbjlpRkI0aHRUM1BO?=
 =?utf-8?B?a0pXbVI4U0pmUGUwTjZZY3lQWjE0bzA5Mm1Ic3lhZDJKOEJIbTI0RGZGa0kv?=
 =?utf-8?B?Ry95VHhpZWhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3QzZ1FNSGlJeHJINnVVMWtKWWdjc3ZKL1hJQ0haeC9icW1GUGpZNEU4SVVm?=
 =?utf-8?B?YVVrQmpZUS8wL2tFRHprbnVlcHJWVjJ3N202dURDR3ErZkZhMXU0QUswcCs1?=
 =?utf-8?B?SU81OW9vUStZbkxUdUZOTUlrbldRdVpOSUtUWWJ4dk5zU2dRbC83RGRxYWdP?=
 =?utf-8?B?NFRtVnBZeFB4SmJFd2NRcytTZkY5akVCQWp6ajYvSXAwWDMzK0pzMDBaR0Jp?=
 =?utf-8?B?NDEySXBuOW1rMVB5S1hmNHp2NWpLL3BLMDlocnM0ZFp4NVZFYk5RbWw5SFlE?=
 =?utf-8?B?K1VBUER5dUxQYlphVm5hNzRXWUNQRTRSZ2R2ODJZclNDMjFIRVAxSnh4Q212?=
 =?utf-8?B?elltdEFvaGNFKzZHMi9QR2lleDZUVFRkNWI5b3pZUHI5N0g2UzlLOW14TTJs?=
 =?utf-8?B?aU04b010ZHZncHFHaEo5NDhSdGFBWGZqTitQTjZIeW9QcncvOXErUVNHOTFG?=
 =?utf-8?B?aUpTay9NMlgzREh5U1U4Ymp4NFdWbnc5UWZXRVUwS01KR29HV2RNVzZSVnBN?=
 =?utf-8?B?TTNIMlQ4V2FnUWpmSXIxREZKeHhHc1dOTUVVbWdFS3Z1eTRZYjdrS0dKTmE0?=
 =?utf-8?B?VmE3bzR3blRhM3BTVlh2N3RScjZMdkQrTHA1RkJ3ZzViOHdyZGJ5c0JzMC9t?=
 =?utf-8?B?ZWJOSEJQNTVYeUluWU1RSG44OHUrNXFDbUt2UkdwLzA4akNWSFNNTTQ5alNQ?=
 =?utf-8?B?MXcvSElIc1VRQjJZM01SdENvS05IS3U4Rnc4TXk4dy9UTGd2TjQ3MHBxbU1p?=
 =?utf-8?B?d1V3VFdLaXhVSTdvSlZSOS9QTVdsNWhDam0wYWtHUElEcXQrUGMxMjZSRUNa?=
 =?utf-8?B?ejVSYTdrL3hFWjR1ZHZnZ3JnZTllREkwaHIrcnJtMS9OTWVFTm5UWVJsRTJo?=
 =?utf-8?B?TE1oclNCeXRlK1Z2aEUvbHhXRk9Ba1ZnUWtLZE1uSjllbWFNRmdzSkUrenNn?=
 =?utf-8?B?RjFKWXBjMkF0TjV3Vld5d0xZSjgyTUlHYm9ycUtnU1NMaytVVVVnSjlvUWsx?=
 =?utf-8?B?TXB0VW1zaFAwMkhOZmFpSVpXcUwvQ0FtRHJoNWtwSk9VamdUY2JHZWk5Rmlo?=
 =?utf-8?B?VmdybHU4L1JEVjExN2FwbGY0ZnluNzlra2hacXJTYXFhV2ZFNGY1a0dQRTdz?=
 =?utf-8?B?aVRTUnRMMVhvOFkvRzFpUlM1QlNyb001d3FYOHdzSFRJRDcrcFdidjZuM3Mw?=
 =?utf-8?B?YTk2d0pudTFNY0w0R3RHSklTYUxaS1dXaDVoczNZa0lKQUxwWTVlQWMvb1hG?=
 =?utf-8?B?M3dLdldOK3gyR0wzTnk1b1NLN3RCT0F2eGtNN0xCSXNnN0NsNkZhekZHK1Bx?=
 =?utf-8?B?RC91cWs4ZzZQcjJNVXE2WEpOYzRsbG1ja0dKUXlCQ0RUUmw2a3dhMTJLZWJK?=
 =?utf-8?B?aVFTUWZYTGE0UjhCaDlRdzVLYXNzT1A5MEE3aDEyam0wVERJN1BlNlJadUZp?=
 =?utf-8?B?aDFoQVdlUWR3OXMxUUtUZXhQZDBqZkNORVEvQ3N3dUxVdnJjQm5LVUlZQm9Y?=
 =?utf-8?B?R1dDbWtkNE9wc1NFVW1ZRFRWdnVjbDcxbWhoaE5pVzBOdmh4WGlpNm1XWXVT?=
 =?utf-8?B?bEFlbzRyVEZPa3JLK3laWk55N2ZXSGt0T0tWQ3ZxVW8vVDNaVXJ6NUEzanVN?=
 =?utf-8?B?WG1kRTU0NUE0R1JJRDZaalQxZjJLbWZVSFVVc1BudXNzWVpERk9EaFNaa2Nq?=
 =?utf-8?B?VUYrV01MRHJzR2ZUUld0NlE1QUtnc0JmMkpKcEZoaXMwUGdUT1pDZEdJWFZ1?=
 =?utf-8?B?TW1YY3ZqaGR5akc1SFJFL0xUQjJmMnVmTkNjZGRyWGlKUjVja0kzcll5Vk1R?=
 =?utf-8?B?Y2hCczV5eE1KekpjK0Ryd2xpeDNyc0pqa0haZEFZM3JJZE04M2tLMERUc3pa?=
 =?utf-8?B?NXJmamNGOFhKdUxMS0l3b01EeTVuT1lUeUY2cDR3LzlaU0c2SzVkanMxbEcv?=
 =?utf-8?B?V29oYzFUVmF3cmVUd2RVbFAxUEYwVnFPbkkvQ1NZUmE5NTZma0Z5MFJXTGxV?=
 =?utf-8?B?NmpyY3FqaUZnTHpTcFFhOUlYUHc2d0tHNC9GMzhoRmg3QkRicEhUOWJvUlFr?=
 =?utf-8?B?Y05pUkJhWlNDUGdSeDNzS2NjblRDQmUxRmIwVHBmUWsxUE11VU9wTFlwb3cv?=
 =?utf-8?B?S1ZwR2JWZUVNUk9VWVUvL2dab1BMMGlNa3NWblVmRnZDRW9HVHVxWFpqRjli?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <753807CFD9716C4284D84CBDD18EB490@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8334beb-fe1e-40e4-0024-08dd94091e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 23:35:04.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZ62/S1TQSaVf80tB6cYSy2MNj0cdRCbzqZiGpZG0QCgrtRboni5byONKhdwIptM8uz4DoU9wQRfClc2fBryaFcu75ZgW0PmWOwQIg4Vyl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA1LTE1IGF0IDExOjQyIC0wNzAwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiBPbiBUaHUsIE1heSAxNSwgMjAyNSBhdCAxMTowM+KAr0FNIEVkZ2Vjb21iZSwgUmljayBQ
DQo+IDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2Vk
LCAyMDI1LTA1LTE0IGF0IDE2OjQxIC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+ID4gPiBI
ZWxsbywNCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaHNldCBidWlsZHMgdXBvbiBkaXNjdXNzaW9u
IGF0IExQQyAyMDI0IGFuZCBtYW55IGd1ZXN0X21lbWZkDQo+ID4gPiB1cHN0cmVhbSBjYWxscyB0
byBwcm92aWRlIDFHIHBhZ2Ugc3VwcG9ydCBmb3IgZ3Vlc3RfbWVtZmQgYnkgdGFraW5nDQo+ID4g
PiBwYWdlcyBmcm9tIEh1Z2VUTEIuDQo+ID4gDQo+ID4gRG8geW91IGhhdmUgYW55IG1vcmUgY29u
Y3JldGUgbnVtYmVycyBvbiBiZW5lZml0cyBvZiAxR0IgaHVnZSBwYWdlcyBmb3INCj4gPiBndWVz
dG1lbWZkL2NvY28gVk1zPyBJIHNhdyBpbiB0aGUgTFBDIHRhbGsgaXQgaGFzIHRoZSBiZW5lZml0
cyBhczoNCj4gPiAtIEluY3JlYXNlIFRMQiBoaXQgcmF0ZSBhbmQgcmVkdWNlIHBhZ2Ugd2Fsa3Mg
b24gVExCIG1pc3MNCj4gPiAtIEltcHJvdmVkIElPIHBlcmZvcm1hbmNlDQo+ID4gLSBNZW1vcnkg
c2F2aW5ncyBvZiB+MS42JSBmcm9tIEh1Z2VUTEIgVm1lbW1hcCBPcHRpbWl6YXRpb24gKEhWTykN
Cj4gPiAtIEJyaW5nIGd1ZXN0X21lbWZkIHRvIHBhcml0eSB3aXRoIGV4aXN0aW5nIFZNcyB0aGF0
IHVzZSBIdWdlVExCIHBhZ2VzIGZvcg0KPiA+IGJhY2tpbmcgbWVtb3J5DQo+ID4gDQo+ID4gRG8g
eW91IGtub3cgaG93IG9mdGVuIHRoZSAxR0IgVERQIG1hcHBpbmdzIGdldCBzaGF0dGVyZWQgYnkg
c2hhcmVkIHBhZ2VzPw0KPiA+IA0KPiA+IFRoaW5raW5nIGZyb20gdGhlIFREWCBwZXJzcGVjdGl2
ZSwgd2UgbWlnaHQgaGF2ZSBiaWdnZXIgZmlzaCB0byBmcnkgdGhhbiAxLjYlDQo+ID4gbWVtb3J5
IHNhdmluZ3MgKGZvciBleGFtcGxlIGR5bmFtaWMgUEFNVCksIGFuZCB0aGUgcmVzdCBvZiB0aGUg
YmVuZWZpdHMgZG9uJ3QNCj4gPiBoYXZlIG51bWJlcnMuIEhvdyBtdWNoIGFyZSB3ZSBnZXR0aW5n
IGZvciBhbGwgdGhlIGNvbXBsZXhpdHksIG92ZXIgc2F5IGJ1ZGR5DQo+ID4gYWxsb2NhdGVkIDJN
QiBwYWdlcz8NCj4gDQo+IFRoaXMgc2VyaWVzIHNob3VsZCB3b3JrIGZvciBhbnkgcGFnZSBzaXpl
cyBiYWNrZWQgYnkgaHVnZXRsYiBtZW1vcnkuDQo+IE5vbi1Db0NvIFZNcywgcEtWTSBhbmQgQ29u
ZmlkZW50aWFsIFZNcyBhbGwgbmVlZCBodWdlcGFnZXMgdGhhdCBhcmUNCj4gZXNzZW50aWFsIGZv
ciBjZXJ0YWluIHdvcmtsb2FkcyBhbmQgd2lsbCBlbWVyZ2UgYXMgZ3Vlc3RfbWVtZmQgdXNlcnMu
DQo+IEZlYXR1cmVzIGxpa2UgS0hPL21lbW9yeSBwZXJzaXN0ZW5jZSBpbiBhZGRpdGlvbiBhbHNv
IGRlcGVuZCBvbg0KPiBodWdlcGFnZSBzdXBwb3J0IGluIGd1ZXN0X21lbWZkLg0KPiANCj4gVGhp
cyBzZXJpZXMgdGFrZXMgc3RyaWRlcyB0b3dhcmRzIG1ha2luZyBndWVzdF9tZW1mZCBjb21wYXRp
YmxlIHdpdGgNCj4gdXNlY2FzZXMgd2hlcmUgMUcgcGFnZXMgYXJlIGVzc2VudGlhbCBhbmQgbm9u
LWNvbmZpZGVudGlhbCBWTXMgYXJlDQo+IGFscmVhZHkgZXhlcmNpc2luZyB0aGVtLg0KPiANCj4g
SSB0aGluayB0aGUgbWFpbiBjb21wbGV4aXR5IGhlcmUgbGllcyBpbiBzdXBwb3J0aW5nIGluLXBs
YWNlDQo+IGNvbnZlcnNpb24gd2hpY2ggYXBwbGllcyB0byBhbnkgaHVnZSBwYWdlIHNpemUgZXZl
biBmb3IgYnVkZHkNCj4gYWxsb2NhdGVkIDJNQiBwYWdlcyBvciBUSFAuDQo+IA0KPiBUaGlzIGNv
bXBsZXhpdHkgYXJpc2VzIGJlY2F1c2UgcGFnZSBzdHJ1Y3RzIHdvcmsgYXQgYSBmaXhlZA0KPiBn
cmFudWxhcml0eSwgZnV0dXJlIHJvYWRtYXAgdG93YXJkcyBub3QgaGF2aW5nIHBhZ2Ugc3RydWN0
cyBmb3IgZ3Vlc3QNCj4gbWVtb3J5IChhdCBsZWFzdCBwcml2YXRlIG1lbW9yeSB0byBiZWdpbiB3
aXRoKSBzaG91bGQgaGVscCB0b3dhcmRzDQo+IGdyZWF0bHkgcmVkdWNpbmcgdGhpcyBjb21wbGV4
aXR5Lg0KPiANCj4gVGhhdCBiZWluZyBzYWlkLCBEUEFNVCBhbmQgaHVnZSBwYWdlIEVQVCBtYXBw
aW5ncyBmb3IgVERYIFZNcyByZW1haW4NCj4gZXNzZW50aWFsIGFuZCBjb21wbGVtZW50IHRoaXMg
c2VyaWVzIHdlbGwgZm9yIGJldHRlciBtZW1vcnkgZm9vdHByaW50DQo+IGFuZCBvdmVyYWxsIHBl
cmZvcm1hbmNlIG9mIFREWCBWTXMuDQoNCkhtbSwgdGhpcyBkaWRuJ3QgcmVhbGx5IGFuc3dlciBt
eSBxdWVzdGlvbnMgYWJvdXQgdGhlIGNvbmNyZXRlIGJlbmVmaXRzLg0KDQpJIHRoaW5rIGl0IHdv
dWxkIGhlbHAgdG8gaW5jbHVkZSB0aGlzIGtpbmQgb2YganVzdGlmaWNhdGlvbiBmb3IgdGhlIDFH
Qg0KZ3Vlc3RtZW1mZCBwYWdlcy4gImVzc2VudGlhbCBmb3IgY2VydGFpbiB3b3JrbG9hZHMgYW5k
IHdpbGwgZW1lcmdlIiBpcyBhIGJpdA0KaGFyZCB0byByZXZpZXcgYWdhaW5zdC4uLg0KDQpJIHRo
aW5rIG9uZSBvZiB0aGUgY2hhbGxlbmdlcyB3aXRoIGNvY28gaXMgdGhhdCBpdCdzIGFsbW9zdCBs
aWtlIGEgc3ByaW50IHRvDQpyZWltcGxlbWVudCB2aXJ0dWFsaXphdGlvbi4gQnV0IGVub3VnaCB0
aGluZ3MgYXJlIGNoYW5naW5nIGF0IG9uY2UgdGhhdCBub3QgYWxsDQpvZiB0aGUgbm9ybWFsIGFz
c3VtcHRpb25zIGhvbGQsIHNvIGl0IGNhbid0IGNvcHkgYWxsIHRoZSBzYW1lIHNvbHV0aW9ucy4g
VGhlDQpyZWNlbnQgZXhhbXBsZSB3YXMgdGhhdCBmb3IgVERYIGh1Z2UgcGFnZXMgd2UgZm91bmQg
dGhhdCBub3JtYWwgcHJvbW90aW9uIHBhdGhzDQp3ZXJlbid0IGFjdHVhbGx5IHlpZWxkaW5nIGFu
eSBiZW5lZml0IGZvciBzdXJwcmlzaW5nIFREWCBzcGVjaWZpYyByZWFzb25zLg0KDQpPbiB0aGUg
VERYIHNpZGUgd2UgYXJlIGFsc28sIGF0IGxlYXN0IGN1cnJlbnRseSwgdW5tYXBwaW5nIHByaXZh
dGUgcGFnZXMgd2hpbGUNCnRoZXkgYXJlIG1hcHBlZCBzaGFyZWQsIHNvIGFueSAxR0IgcGFnZXMg
d291bGQgZ2V0IHNwbGl0IHRvIDJNQiBpZiB0aGVyZSBhcmUgYW55DQpzaGFyZWQgcGFnZXMgaW4g
dGhlbS4gSSB3b25kZXIgaG93IG1hbnkgMUdCIHBhZ2VzIHRoZXJlIHdvdWxkIGJlIGFmdGVyIGFs
bCB0aGUNCnNoYXJlZCBwYWdlcyBhcmUgY29udmVydGVkLiBBdCBzbWFsbGVyIFREIHNpemVzLCBp
dCBjb3VsZCBiZSBub3QgbXVjaC4NCg0KU28gZm9yIFREWCBpbiBpc29sYXRpb24sIGl0IHNlZW1z
IGxpa2UganVtcGluZyBvdXQgdG9vIGZhciBhaGVhZCB0byBlZmZlY3RpdmVseQ0KY29uc2lkZXIg
dGhlIHZhbHVlLiBCdXQgcHJlc3VtYWJseSB5b3UgZ3V5cyBhcmUgdGVzdGluZyB0aGlzIG9uIFNF
ViBvcg0Kc29tZXRoaW5nPyBIYXZlIHlvdSBtZWFzdXJlZCBhbnkgcGVyZm9ybWFuY2UgaW1wcm92
ZW1lbnQ/IEZvciB3aGF0IGtpbmQgb2YNCmFwcGxpY2F0aW9ucz8gT3IgaXMgdGhlIGlkZWEgdG8g
YmFzaWNhbGx5IHRvIG1ha2UgZ3Vlc3RtZW1mZCB3b3JrIGxpa2UgaG93ZXZlcg0KR29vZ2xlIGRv
ZXMgZ3Vlc3QgbWVtb3J5Pw0KDQo=

