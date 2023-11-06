Return-Path: <linux-fsdevel+bounces-2050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B27E1D30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058121C20B24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70F16428;
	Mon,  6 Nov 2023 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4RTshr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6D15AFB;
	Mon,  6 Nov 2023 09:27:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFF3FA;
	Mon,  6 Nov 2023 01:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699262831; x=1730798831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bu3RUiqIcCuuTsoctLTRmwQdyz5EAcdPRP47ZTzlUvc=;
  b=W4RTshr3w5t6QdccFHnwpy9/cKG29fAxkzYQ/i+1sDY1ffnIGG498TkL
   W7jkRMKiAMqslGTMw0KaThsgwnRAw7Zamh5fSiTmxrtrhLzkJVXGm9zkY
   a7+Mht3DmOB8rHgHtGtsBHAEdyG4ri7SxMcpRqaAzEdZA98QPoI6BhHsE
   JLxwHFCCcAkuRQWq2rLC8H80JoO72jtuhObN72kqJ5Gk2hOs16Ui5qzH7
   PrrKLW/Tlt3SqtXHPFrK95pT9TKcYq2bwof8eTAGrnVeczk22lYAmvEo2
   BuuvgbI2ARDL4JMVhbrBDtw7Hbf2AGdvJoxzVjfr+2I2GfiUoLy6vwAFS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386415284"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="386415284"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1009468715"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="1009468715"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 01:27:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 01:27:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 01:27:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 01:27:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS0FJ/ELNI9+MZeIyomk3jO1BShJAGpZF1cSno+AGArXDTsihhdxWI4h4AtHaTVma/877RcAfDmTqT2T/vtFarvQyNn7631bov3NtBCZp8HpcEXiRj2TVhFde1tl12XMxZdQvdBdIYb1WsyIwVE21dIkjqh+c1KW5qIbDHNm5ZaT+2P3DDAOxUu8r5ddh2QhlhivbXVPV51bH5NGVVSEltgHXYz5IPM58UcOfFD0+Do0Bt5KGVfxNHPZU5hygjPqCYIfiKCga8bz+YQiSgv+1idYffi+5ma0peqjKgpEV9ovP+aXN4xXy5G9ggjYFpP21WxeSsOlZHoPkPXbt3SJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu3RUiqIcCuuTsoctLTRmwQdyz5EAcdPRP47ZTzlUvc=;
 b=PyITgPKSjDFDSLh5AsJsgHg/YGqlKJeif57uDhyP5h+H6IInErKDLW/N8EIHthqJFj38cLxtNjfV14CzG+LT29q9+IoOo3bng8EP7eiWrcpq+QfOsOtzIBq62MfWjJVScyhiTKmIvfC0XhgAt8PL1BZfXGklg2S2RnmqzRdKT1StBzmUFGvFbeXUf54tpchWVijjk1Lf7G84J/qzkq6wrBUT+b4TVVoyN/W0wK5RU0bPWva/HrDvNcfs5L75PH/YzBoSocQrXtSQUSE7QlFgod470416MCIKdD26djIKIiI/jFVq2AuWdMPNmvIVuipou5qlilg4EfZdeDtcmk8eSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 09:27:07 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.021; Mon, 6 Nov 2023
 09:27:06 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "Christopherson,,
 Sean" <seanjc@google.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "maz@kernel.org"
	<maz@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "anup@brainfault.org" <anup@brainfault.org>,
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org"
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
Subject: Re: [PATCH 08/34] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
Thread-Topic: [PATCH 08/34] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
Thread-Index: AQHaEAWe1s9vtM/5MkyLlkzyVHClwLBtBsAA
Date: Mon, 6 Nov 2023 09:27:06 +0000
Message-ID: <f42154178a882e3df7696821c85881f10c724a5b.camel@intel.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
	 <20231105163040.14904-9-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-9-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5525:EE_
x-ms-office365-filtering-correlation-id: 9631418d-925e-43f4-3523-08dbdeaa8b32
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+Ya9D/DlXjYUgYT3eYCX/PSbPghDr7aSezsgXK3e506wJq54xjNgZelAZyZAK5pcgc7okvkkBCGHey/qJ2OaTDIeaRx0mXw71KPdrS+dcNJib99PPG20uyDK53rczVRTNiK32oeoh9mWPPuhLtQrSvckniPqs0MD8byHT3KpgqQyzHLf4YtZt32ii6rOzHt55n3pnftBGAHODxQxMAeMH6jntuWPx+7kYJpYiWRpxU2jF1vBXp00z6DnI91fCJYLs97zVjzwhWiNOaZXTU8l6ILb+f6peJvp0Ql80rE1GQ4meszYmtk6glzIf8fDvKMpEfbhfcnKuDbGnKCQ5g9owmNmAvjnISa5qDnCdxTJxPt4SPLi2X54ZIdM5jMMbZaIByOHEJRqcfa3NIuIX25JU931UhtOeTDVMeoHW7HpOL81CIhT1SW9HaP8OBCRSlCSTmi26IYSmeIutlEzY6SbdC/t/N/PmuqJ7HWIVE9/ghD4G9/aKia6Q0dlwdQbIz3nWnT5FYus/DPbHfQbRxJ2yiV8QCcCL6wJ7fO/ui25w+R3qNaNmwOP5l1sZVmh864s76cyfk75y2AbFlj5ujB3LY4EECgj+40vK8x4hpkTvK9y78f1AzRmIc9Y6UnyZXZQ6iQSlEZnVvWLjfhIBxEpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(6512007)(6486002)(6506007)(478600001)(71200400001)(2906002)(38100700002)(36756003)(86362001)(122000001)(82960400001)(7416002)(5660300002)(7406005)(41300700001)(66476007)(64756008)(66446008)(54906003)(66556008)(66946007)(26005)(921008)(38070700009)(91956017)(110136005)(316002)(8936002)(76116006)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dy9oV0NKdjhmK3RQOE1mMk4xd2x4K1ZuUHdHMVJCUDdyUzhvQWJIVGRuNnVz?=
 =?utf-8?B?dEFsRXVJdEZlRDA3WnJ2V1hGc0E2Tm9iTkJuZXdJSk1JaTRnNzBmZzJ5Uy9l?=
 =?utf-8?B?dzlkUHRka0sxZjQvemxxUmg5ZlFOaHA3WFZ0d1ViektUNFVVRGwwV0g2eDRW?=
 =?utf-8?B?cHVwVnJFRDM2bFlOUmxabEF4RFFNSzVZSDFQZUcvS3Rua2NleUhtOWYzZExw?=
 =?utf-8?B?by9PM1lDUTJzZTQwY1h3YVdxOXZxbE1qOG1hSDhlN2tmakpKekhpZXZkYlpZ?=
 =?utf-8?B?bmhXSWJabjEvdDVnVCtBL2h2MFF5TytEN1pvZ1VvWS8xTjBpQWZJNHZsSjNv?=
 =?utf-8?B?bW54MTh6Qmk3SDBXMDNFUU5Pb3o4cXU4VUIrYnExTjk4bTVrTDRZdDB1NFNr?=
 =?utf-8?B?TXBvRXhHV0VGTTd2dGhnRkRla0d0VngrMHN4MDVpb0xUOStaQWFRSkdaSWpZ?=
 =?utf-8?B?WXZuMXA1Yk8vSkVUUGtsZG1VSWZDbUNQT25hcjFMTzNiWlNLYVVJKy9JbTNN?=
 =?utf-8?B?bjBiQTh0U1FXYWU4Tmd1Mm1lQzJvenU0R3dwTmNycUFwdkQ0T1hoQmpCSFRs?=
 =?utf-8?B?bExSa0xhS2dMOGFyenJ4cVNBWUI0aGhZdWVIclQ4VUdCQnpJZWRiU3M3Qk5p?=
 =?utf-8?B?dms0UllsL0p0NmNJYVVQcTFjenpjNEw2SldJVHoxOU50UHl3dUVyUzFRb2pl?=
 =?utf-8?B?ZFhKcVlodGdoVkM2cXdhQ2dUTXVyaGZXVjNsaWlLaTY5NXlxbkR3bTVycG1I?=
 =?utf-8?B?V1NWUFdIbXZ6WCs5SlhyeW9xaUppdWJ4TWJ4QTdQZ1NjWUVTZWtRN0dJYmdl?=
 =?utf-8?B?dGJQYmlERTNUNEFlZkw3RkVsa3ZjNGR5dk85U3Y3Y21xL0xlNFgxb0F4dzlR?=
 =?utf-8?B?VkV5S3N1VDl6ZnZDd3NTY0t4RGEyaUxGUTRkSlkvQXdOTGMyS1pud0dpdk9V?=
 =?utf-8?B?VEtaY1ZJMnJDdmZQeEJ1K1habTJDcnZwNGFoQmhSZUZYYlg2OEN4Q3dxcmQw?=
 =?utf-8?B?bHk2UE5vZmlqMDRNWHpEYUx3MURsbUhDMm5UbFZ0c1hDLzR1UWNITTh2S2w2?=
 =?utf-8?B?LzRjeEFZZXhER0xvdjl4SlloWGFFenpiaVZUZkovYUFnbC9qQUZwV25mS2Jy?=
 =?utf-8?B?VDB4SW9vT0cvM3NzdlZ0TEFLbzNQKzB3dk13amdZc2xDbHlhZWcxREZuVXpv?=
 =?utf-8?B?Z1ZzeGQvUS9JRVRhQmR4Zi8xU09saHJobjA5RTZDelZkNTVMRmQyMEowa2tt?=
 =?utf-8?B?VFNoYkdneEpLdS9FSzNjT01ZUkZzRXRxakhCbUU3ekNzb1ZMRUNoQk9rRjVa?=
 =?utf-8?B?WTg2QzZ4anhsV0FValIyeGkyV3hOenh4b05rM3gvQmVxQnFXQTdzczRhdHB5?=
 =?utf-8?B?WFdyK2k2OHlzbHArTzNZb2ZmT0dLQkcrQVM1Ylh2SVlwWHBwVndUSWhJSFJC?=
 =?utf-8?B?WjJuYzdSdGdxWG5pVDVmNEJrZy8yak9oZXJORHlHVUZSM3FoNHlFdUIwSVVj?=
 =?utf-8?B?cGFlS0dxWkJnWDZuencycTh0NmcrTFFwRXBWVXFSMFlpZXEzMVpCb05lQUxu?=
 =?utf-8?B?UkdBaVJrb1J3eXhsemFNVXlyK2E3aFNFNmRNaFgvZFZSOE9URE4zMll2SWJR?=
 =?utf-8?B?WW9BRmtoMlBsb1lEUDYwRGEyZGhQNVN2VWdQT25jMnRxU05HK2JYVE9OS0ty?=
 =?utf-8?B?YXlaN29pb0VrSVBucGlnTUtQempxQlRRRDY4R09yeFBhU3RCTzFnSmsvZ3lq?=
 =?utf-8?B?WG5FZmpaaWt6dDVlS1AwUTR3RzY4ZDk4QUU2K2RyaDRBSks3dWdEc25HU0k2?=
 =?utf-8?B?Y2hGQ2srcVExSExLUFNlWHhiZ1hYcnUzcW1jZG5pUDg4d21PZVVnSDBkajQ3?=
 =?utf-8?B?ZG52b3loeTcvRDY1S3ZVR2oyTFV1Q1FCMHFHU2Njem9kUG82UCttT1BVYjBw?=
 =?utf-8?B?T0RnV3ZGRHVQRUlWS00xWGZlKy9TVVh2RVowbHNLUzdOeG5tU3VKYUtqRXZl?=
 =?utf-8?B?Z1FONnEyN2hnV3p2THVNUkJWYWpYMnNVRkN5SU1mRW1Zd3RTNHYrZHFLSXc5?=
 =?utf-8?B?YXBjY0FaTWVkdGUzakZUWVNhRDRncXZQekFxcGFhTTVLUW5GK044azZBZlpq?=
 =?utf-8?B?OGFvNFR2R0M4TmZzTDlLWmIzeUhqVHlpZEhtVW9HTUNZRHhDVVljcHVETzNi?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80BECADCC55CFA48ADB92ABB9518B0EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9631418d-925e-43f4-3523-08dbdeaa8b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 09:27:06.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKuffZuEgqkfff0k4MUvwI4ug/TeqmXr+qxB3Kt3Q6my80bYGoqRafd55oYHbhbYV0/sFpilrYzzYpjFAl7EMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5525
X-OriginatorOrg: intel.com

PiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdmlydC9rdm0vYXBpLnJzdCBiL0RvY3Vt
ZW50YXRpb24vdmlydC9rdm0vYXBpLnJzdA0KPiBpbmRleCA3MDI1YjM3NTEwMjcuLmJkZWExNDIz
YzVmOCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9hcGkucnN0DQo+ICsr
KyBiL0RvY3VtZW50YXRpb24vdmlydC9rdm0vYXBpLnJzdA0KPiBAQCAtMTM0MCw2ICsxMzQwLDcg
QEAgeWV0IGFuZCBtdXN0IGJlIGNsZWFyZWQgb24gZW50cnkuDQo+ICAJX191NjQgZ3Vlc3RfcGh5
c19hZGRyOw0KPiAgCV9fdTY0IG1lbW9yeV9zaXplOyAvKiBieXRlcyAqLw0KPiAgCV9fdTY0IHVz
ZXJzcGFjZV9hZGRyOyAvKiBzdGFydCBvZiB0aGUgdXNlcnNwYWNlIGFsbG9jYXRlZCBtZW1vcnkg
Ki8NCj4gKwlfX3U2NCBwYWRbMTZdOw0KDQpMb29rcyB0aGlzICJwYWRbMTZdIiBzaG91bGQgYmUg
bW92ZWQgdG8gLi4uDQoNCj4gICAgfTsNCj4gIA0KPiAgICAvKiBmb3Iga3ZtX3VzZXJzcGFjZV9t
ZW1vcnlfcmVnaW9uOjpmbGFncyAqLw0KPiBAQCAtNjE5Miw2ICs2MTkzLDI3IEBAIHRvIGtub3cg
d2hhdCBmaWVsZHMgY2FuIGJlIGNoYW5nZWQgZm9yIHRoZSBzeXN0ZW0gcmVnaXN0ZXIgZGVzY3Jp
YmVkIGJ5DQo+ICBgYG9wMCwgb3AxLCBjcm4sIGNybSwgb3AyYGAuIEtWTSByZWplY3RzIElEIHJl
Z2lzdGVyIHZhbHVlcyB0aGF0IGRlc2NyaWJlIGENCj4gIHN1cGVyc2V0IG9mIHRoZSBmZWF0dXJl
cyBzdXBwb3J0ZWQgYnkgdGhlIHN5c3RlbS4NCj4gIA0KPiArNC4xNDAgS1ZNX1NFVF9VU0VSX01F
TU9SWV9SRUdJT04yDQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKw0K
PiArOkNhcGFiaWxpdHk6IEtWTV9DQVBfVVNFUl9NRU1PUlkyDQo+ICs6QXJjaGl0ZWN0dXJlczog
YWxsDQo+ICs6VHlwZTogdm0gaW9jdGwNCj4gKzpQYXJhbWV0ZXJzOiBzdHJ1Y3Qga3ZtX3VzZXJz
cGFjZV9tZW1vcnlfcmVnaW9uMiAoaW4pDQo+ICs6UmV0dXJuczogMCBvbiBzdWNjZXNzLCAtMSBv
biBlcnJvcg0KPiArDQo+ICs6Og0KPiArDQo+ICsgIHN0cnVjdCBrdm1fdXNlcnNwYWNlX21lbW9y
eV9yZWdpb24yIHsNCj4gKwlfX3UzMiBzbG90Ow0KPiArCV9fdTMyIGZsYWdzOw0KPiArCV9fdTY0
IGd1ZXN0X3BoeXNfYWRkcjsNCj4gKwlfX3U2NCBtZW1vcnlfc2l6ZTsgLyogYnl0ZXMgKi8NCj4g
KwlfX3U2NCB1c2Vyc3BhY2VfYWRkcjsgLyogc3RhcnQgb2YgdGhlIHVzZXJzcGFjZSBhbGxvY2F0
ZWQgbWVtb3J5ICovDQo+ICsgIH07DQo+ICsNCg0KLi4uIGhlcmUuDQoNCkFja2VkLWJ5OiBLYWkg
SHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=

