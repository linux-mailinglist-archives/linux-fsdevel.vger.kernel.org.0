Return-Path: <linux-fsdevel+bounces-1721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E477DDFD3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57EC1C20D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF61096C;
	Wed,  1 Nov 2023 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnNGVKDm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F510794;
	Wed,  1 Nov 2023 10:52:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0784510C;
	Wed,  1 Nov 2023 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698835972; x=1730371972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yMVN41sxl9CqcL1LUDWvW9qw5XHt1ZknFiLbR50HVe4=;
  b=SnNGVKDmoD89U7EMcsuoFA13odi8KOexXgQEpnFO/EkErYtt8tWaGdUZ
   VLQrfGkr5Gta0W6Tba21XxYBKyyNXHNdM1nsE7j+/0YUFHxYikOiv5MsC
   Z5c8mR/7FQHOa/ZAdQNr4ojoxSYLkNHrR4WKvd0n/Ibfocob64fEfCMt9
   +tyL0Q2BkJ8t1SrC2BJdFnnAFwJIoMV/k5Rd9L3ki3ic9Kaf4ZaxQnJGI
   E0DVEQJbVXMmS2LO0zwnDHuoLLVTMNaOmzJvYJ0SXSvv2yOTndBb5GGfi
   aAKGoB+0vJjQeS+cxxFUaZvbDkPDN13gVOapPesRVekzPiiKK8Dbz7YgD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="387357254"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="387357254"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="795868917"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="795868917"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 03:52:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 03:52:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 03:52:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 03:52:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5UFXhRmMyll/wLi4MO93hO2M8O4oewdZfD/2i7tIr8V/yzzJOpoIvdP4S/sweDJRwFfE1rDR5Th2wMeD+6tAUv3n5WEV/6Hw/Vm8VfNCuw3OtalRNvqB2TaskRVWmusFh8WxA5YhV74VvSmkMlpCdFGh+0w2xKa0RZR6BKQ/QoD0G4IMJ6KAiE6AvJvpUdYJQ2OtD44VkrGRUHZJ+8iJinBIkhVP/VdBmNgV75TFwpfJzvPhLLPChiVxlmjThxG14nUlYrpA1XcHl34BRJaeX/DdwiuNa+aBmJlUQT/UnLzLkAisfkvcbnWbou/Tjaz5pHbqx7wny0iL1K6xPLc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMVN41sxl9CqcL1LUDWvW9qw5XHt1ZknFiLbR50HVe4=;
 b=gz3jeplBWOaukDok6qoecqB1Sa+kTx4XWpKmuPavSxIF57KzpS+5aEaR9tBv2UUGHacsXzi6omMOKD27nFHY5ea5baIKNKEX1lZqMyx4wNfKx0vq1/UoZ53OMqygTEc2eJUGAwOgWuiAFZCzhQfMko7BdanQAnyb6gOJ/3b7VYhHFPf7d+y6fuM4eGw0fhUByq6gb6Cr9Wn7r2AMmGlErRzlB08W6Her7ucelAwHuCqX4ventiv5nl7S/FqrGa0fSxhZ4vEMpmAT33wam96oYL5scrV5Y/M4A4JgXyRQGIQFBi3/C869PebuXSWztlYuM+UVKq/qXfG2hYCbpQUGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB5347.namprd11.prod.outlook.com (2603:10b6:610:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 10:52:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 10:52:47 +0000
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
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Thread-Topic: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Thread-Index: AQHaCQKnsgoTcbnsvUKkAITO6oVjaLBlURAA
Date: Wed, 1 Nov 2023 10:52:47 +0000
Message-ID: <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
	 <20231027182217.3615211-10-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-10-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB5347:EE_
x-ms-office365-filtering-correlation-id: e44ac44e-c804-4ac0-31d0-08dbdac8af8b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQll+TKNFCYMXh5ijEJ1s2k/tFprAoQfwYSyIDhLhuv1YFsjpusLQLp+mRY4Toh2xuqq/omAQbabwu5r6oYsVekq6sMiHxGtw1kCzYhbYoJZ52hXco40dKLmNoHueKhHypTOATtm6krd/5Q3uLTpLiSGdWBAmIFLCbZQZx9hZdsfFWtw+iJXXjahFXiSJMMvTLxjsuq98eogoD6TnfBCNE4jEDjsaMlNQPMpwEruQF6fFMgP2LmFAkmFyyFeGulgcG2T+EsD5puC8/DkjVhlccdJATzmUgEhnxyykTkKSdCfV6C5wM7afkvyKEdpzl6LWxeZt/590ZhpEZddLjauzn/brIx6GH8uR/lvbPFxzAR5TrgTK/MCWQSJ70FgqfsaBVMmV8H1dIxZMSJ5usX11gv+/SP6SSufoIzvy9lxX29Gt8RooUP+YK5v9+bmhMge5PwajclJT+7KVHrVDRhzD/N2kx4CbxJm5TR1Q+MVmSJ5HwUot+iaIH4OOKVy+xBEVyebRMgXWj92PlTWxnUYcsXXXsofSzPfL1bRFo8sHeZ8fR+OzM5hyKfkRp8gCaG0OjODs93WffLijW4elr+bbf0cOoJ3OCiEkJjh9EfGOTxd75/4hz92R01cffPVGylVOXrdlCEpNR813LDYN59KVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(41300700001)(122000001)(478600001)(6506007)(36756003)(66556008)(6512007)(38100700002)(66446008)(76116006)(110136005)(66946007)(82960400001)(5660300002)(7406005)(7416002)(6486002)(8676002)(71200400001)(4326008)(91956017)(8936002)(921008)(86362001)(2616005)(316002)(64756008)(26005)(54906003)(83380400001)(2906002)(66476007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXpZTjBXSGFCRStFVDhjZXBpMWxrb1RuYmo2eHRJUTFsaWIyZHgrVThUd01N?=
 =?utf-8?B?dHBYZDlZZmphc2RMOXNCdGRxVU5ROVVYakIrTzhZS3dUUTNSQmN4dzhFRVNt?=
 =?utf-8?B?WjZXaVdMbkVlbnNERUViVWpYWHo2bWs0UVZrM2hXKy9QbzdRZXBIZXUranNn?=
 =?utf-8?B?NHN4S0kyaEdCU0JUUjk0bHZDNEcyT054TWxFMWNydGpPbnp6VGZyeE95SzB2?=
 =?utf-8?B?UEkxaytWUTlYOFVpSFJOQUJTa0xZcmZIT0JQNlhnUUhRUHJTelJoVklTQWk4?=
 =?utf-8?B?ZVlmY2VGbkljMGV1MTlWQnFCQ3B0YTU4TVJxaHdYTmowRXVqSStiNmU3ZUJ5?=
 =?utf-8?B?RzkrcW02QzhCSnJic2tvL0djcmgyRWdrRUNTQWtDVlkySG1IcG9zNkVwYjBT?=
 =?utf-8?B?OG5vK21MWUF4Z0VxT2l1NnNoeEZQUE84UTlaOXJnSjVXeHhjdnB5RThLdHcr?=
 =?utf-8?B?bHhGdzNIMzFYdVlTOGlmRW14K01CTndtZnJMYUlmc0wra3NYNzZ0UUdGUndL?=
 =?utf-8?B?SERXdWthaU8xODJaRFZ3ZDNPV3FVd3JmbW44d3NlZld0dCs1SmV3Ujl5RUlR?=
 =?utf-8?B?N3VYczlxU2MxaG1JS1Zqd29yWDdKKzAzYTJUbE0yQkFzUHpSRXp3TitXRTZn?=
 =?utf-8?B?Nlo4bHdlSkw5dFI2amh4Wk5jcEpzVHozcUs4NUJCS3dVSUZucDQzOXo4NXk3?=
 =?utf-8?B?bjB1TjNHa2RQbzUrTkh1bnVzNVlnS2hoeWFJYStzKzNXRUY4QldHZnIxdEk2?=
 =?utf-8?B?TmdRempGOVlHNHN6U0FSb2dKekpYRmVvaEJ5MFR1Wi8rK0RUZW50RjF2S2Vp?=
 =?utf-8?B?SHE2WUJWMElxMHpYY1VKTUpRN2VhUWpwWlVZVGlNTUlwRXhFajhtSHJxSHNh?=
 =?utf-8?B?cUlXb2NYUzRsSUliS2Z6cjVxcVdwek9aYUVCcWswTVI2UldLS0dsKzhZc1A2?=
 =?utf-8?B?V3E4dk1OL3M5YVlXdjA4ODhKdmdwWk4reEZ3SjZ3NG5Uc1g2NWpjYzh2N2Zu?=
 =?utf-8?B?QzNoVGtzMXlnZjlzYzhLOXpsQldRbWdMQWY5MUpVVUVUNHpaVDFia2t2NXcy?=
 =?utf-8?B?bEkvTnV5d0ZwUHVxQ01QcU5uNmhIZHlqOFh6cVUrblZPYmxyaktqUTlLK0JU?=
 =?utf-8?B?Rjg4RmpWS0tqaE9hYnJ3eDAzRVJnMUR0cE1CMllJbWg4UDEwRFgxR2k5Zi8r?=
 =?utf-8?B?M0xXYVBkc2pLWGg4WnJ4bGhHTlZMZ0ljYU92ZENRdStQRXVxb3A5QUtaWkxS?=
 =?utf-8?B?NTczNzRWRjBUWVptQ3NabWI3Tkw5N21xazg1cVVTQXZhdmdGSFZVQkFjRWxi?=
 =?utf-8?B?Sk9XQStKL1RIc2JLVGRJaUh3emZ5NFluUlhoM2d5VG4wU25XTDgzS0RvVDlj?=
 =?utf-8?B?Z081VE1vVFhiblBZMlZ1NVJaSGRUbnRCMTN6aitkY25NbUZIVXU2ZjJJWWNh?=
 =?utf-8?B?blluQnBGLzd2NGVIZEl2NWoxQjFnaVJZc3FsRGVuSWNMOWFCYml3OG1jTnFV?=
 =?utf-8?B?Mk02UERpUVpaT3hxU05qTnZkelVoQVJObmVpUVRkOUZrNHRzVzdMRGJMalB2?=
 =?utf-8?B?aE9BSTY1RmFnVzVzRDFLZ2tDeTdDUGU3R044VFNoWEhOd0VoTjF0cU5hVHhY?=
 =?utf-8?B?ZkVWdXJIVGcrMVFJSUplbzNqY0xwNFpmNUZFUjR3UElpOC9LM1pYdVJuOWdK?=
 =?utf-8?B?UzBkWGVjNytId2pMU1Vra3phcmY0T1R2OWoxZGhiSFplY0pUUi90QXRYYVVU?=
 =?utf-8?B?ekpJdlB5Lys3WWRqNW12a2ZyM1VZa2pFUEtrUlZPMDdDZ1VHT2xLS0xycllB?=
 =?utf-8?B?N2hkQ0Z0am5NZXZOdkIyRVNDMTk1SXJGcUdobFlPNmJCbmNKMXU1L3lFRmYr?=
 =?utf-8?B?UWZoZy9OdXBTRy9aVVhnQUNmSm9NUWxiU2QxUFFqQ1BoQXg3Y3Njd0FUQXF1?=
 =?utf-8?B?aXJhQ3ZOaXhYS3VpWHpIZkJmMC9VeGMybFpIN3dVUUVYNU5pQk1FY1NGcVQw?=
 =?utf-8?B?bGJuMXVDbWkydlFJMCttcnRhdG9GekFhSkt5L2xtbWVTWTBsSkNYZjVWSkNB?=
 =?utf-8?B?QS9NY2dJQUtjQURRNVhLaFVmKzBPdnhHWERDcGlWZVFvM0VLUnBkd0RaU29R?=
 =?utf-8?B?WXZOUzZoUXFGQTVGNzZEaTZYRWZGaXBqVlY2WFdsNDQ0dGRja1ZDWkJaMHNl?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF19F01FC591D8448FDA4DD1D1BD8F29@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44ac44e-c804-4ac0-31d0-08dbdac8af8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 10:52:47.6319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBrOwCRjt6ruUd2uUiXFjMDxVPRDwNRDLmBtzpE7WZU5fdULaWw+LjmP2Da4My1JwAlCwB929GZt8RvmXM6pfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5347
X-OriginatorOrg: intel.com

DQo+ICs3LjM0IEtWTV9DQVBfTUVNT1JZX0ZBVUxUX0lORk8NCj4gKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiArDQo+ICs6QXJjaGl0ZWN0dXJlczogeDg2DQo+ICs6UmV0dXJuczog
SW5mb3JtYXRpb25hbCBvbmx5LCAtRUlOVkFMIG9uIGRpcmVjdCBLVk1fRU5BQkxFX0NBUC4NCj4g
Kw0KPiArVGhlIHByZXNlbmNlIG9mIHRoaXMgY2FwYWJpbGl0eSBpbmRpY2F0ZXMgdGhhdCBLVk1f
UlVOIHdpbGwgZmlsbA0KPiAra3ZtX3J1bi5tZW1vcnlfZmF1bHQgaWYgS1ZNIGNhbm5vdCByZXNv
bHZlIGEgZ3Vlc3QgcGFnZSBmYXVsdCBWTS1FeGl0LCBlLmcuIGlmDQo+ICt0aGVyZSBpcyBhIHZh
bGlkIG1lbXNsb3QgYnV0IG5vIGJhY2tpbmcgVk1BIGZvciB0aGUgY29ycmVzcG9uZGluZyBob3N0
IHZpcnR1YWwNCj4gK2FkZHJlc3MuDQo+ICsNCj4gK1RoZSBpbmZvcm1hdGlvbiBpbiBrdm1fcnVu
Lm1lbW9yeV9mYXVsdCBpcyB2YWxpZCBpZiBhbmQgb25seSBpZiBLVk1fUlVOIHJldHVybnMNCj4g
K2FuIGVycm9yIHdpdGggZXJybm89RUZBVUxUIG9yIGVycm5vPUVIV1BPSVNPTiAqYW5kKiBrdm1f
cnVuLmV4aXRfcmVhc29uIGlzIHNldA0KPiArdG8gS1ZNX0VYSVRfTUVNT1JZX0ZBVUxULg0KDQpJ
SVVDIHJldHVybmluZyAtRUZBVUxUIG9yIHdoYXRldmVyIC1lcnJubyBpcyBzb3J0IG9mIEtWTSBp
bnRlcm5hbA0KaW1wbGVtZW50YXRpb24uICBJcyBpdCBiZXR0ZXIgdG8gcmVsYXggdGhlIHZhbGlk
aXR5IG9mIGt2bV9ydW4ubWVtb3J5X2ZhdWx0IHdoZW4NCktWTV9SVU4gcmV0dXJucyBhbnkgLWVy
cm5vPw0KDQpbLi4uXQ0KDQoNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oDQo+ICsr
KyBiL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaA0KPiBAQCAtMjMyNyw0ICsyMzI3LDE1IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBrdm1fYWNjb3VudF9wZ3RhYmxlX3BhZ2VzKHZvaWQgKnZpcnQsIGlu
dCBucikNCj4gIC8qIE1heCBudW1iZXIgb2YgZW50cmllcyBhbGxvd2VkIGZvciBlYWNoIGt2bSBk
aXJ0eSByaW5nICovDQo+ICAjZGVmaW5lICBLVk1fRElSVFlfUklOR19NQVhfRU5UUklFUyAgNjU1
MzYNCj4gIA0KPiArc3RhdGljIGlubGluZSB2b2lkIGt2bV9wcmVwYXJlX21lbW9yeV9mYXVsdF9l
eGl0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwNCj4gKwkJCQkJCSBncGFfdCBncGEsIGdwYV90IHNp
emUpDQo+ICt7DQo+ICsJdmNwdS0+cnVuLT5leGl0X3JlYXNvbiA9IEtWTV9FWElUX01FTU9SWV9G
QVVMVDsNCj4gKwl2Y3B1LT5ydW4tPm1lbW9yeV9mYXVsdC5ncGEgPSBncGE7DQo+ICsJdmNwdS0+
cnVuLT5tZW1vcnlfZmF1bHQuc2l6ZSA9IHNpemU7DQo+ICsNCj4gKwkvKiBGbGFncyBhcmUgbm90
ICh5ZXQpIGRlZmluZWQgb3IgY29tbXVuaWNhdGVkIHRvIHVzZXJzcGFjZS4gKi8NCj4gKwl2Y3B1
LT5ydW4tPm1lbW9yeV9mYXVsdC5mbGFncyA9IDA7DQo+ICt9DQo+ICsNCg0KS1ZNX0NBUF9NRU1P
UllfRkFVTFRfSU5GTyBpcyB4ODYgb25seSwgaXMgaXQgYmV0dGVyIHRvIHB1dCB0aGlzIGZ1bmN0
aW9uIHRvDQo8YXNtL2t2bV9ob3N0Lmg+Pw0KDQo=

