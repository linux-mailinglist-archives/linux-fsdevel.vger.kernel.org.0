Return-Path: <linux-fsdevel+bounces-1796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D87DEF05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514A01C20F08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2A11CBB;
	Thu,  2 Nov 2023 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiLVgNnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05263AC;
	Thu,  2 Nov 2023 09:35:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D333B19F;
	Thu,  2 Nov 2023 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698917743; x=1730453743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UMBvCakKT8U88QbLtZU4M0lTyMosxIU9x7W7yrZ46u4=;
  b=XiLVgNnca9TtVF515XblZiCL+X0M8pOm/Ku8auwjt9XIUMx3LQUV8ldU
   LGIxBXSnIlF1tyrlPELVty6QFDS/q621P6Z1Bg6nguxzySt0IjD80uHH4
   +/ZSQf5b28XfybD6l9cDhViPEdRHvUTu6cT5OEVVqxNHE5gXghIsRDYYK
   H4L1ENXekq8bwYAr+2LvPPklZvdcTmdVxEPvwtsEezXsQtP5AHfa6u8cN
   S76R6uQSKqWpyJQy7pWFYNp/zyi5BctZT1aH7HwqF0MwsTumytqY04Nhh
   FarlpylR4vCfkm57arx1xwGptX4yvVR2vbD5pauDSgMmKqfWfROA/sHxS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="392559594"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="392559594"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 02:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="737700570"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="737700570"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 02:35:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 02:35:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 02:35:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 02:35:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 02:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crBfvbFv0Nw4wYstkZJMvqReFKnvEIc4B2WnNKm6vCc5HmQy7QKfWfwcgkl/kluc0pTW/Y7grIn+7FLkpJHe7j52lIyjsfO/U/gYN0do6ttXLyXpeRgTs/hNpND6bR+sNtV2SXyWlVFjKI2OUgLqeyLPGWmMfqsoF5N04MaQ+23c9MXn+73YxF3c9a7N3xq67WetBSqu0x6t8noFpAeOmVEPkq53hbFBCcsAmNgTrMB5+rkeJJdWWm0shsbumXfZfHZDYROYSx+PIiDSW5mbtwi5H78VD3yqlVwciqUayFCCM3oyRnyzl2L2zaJUm+TmMfLaXX+MSq1Mx3cshw15zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMBvCakKT8U88QbLtZU4M0lTyMosxIU9x7W7yrZ46u4=;
 b=UV3B91ZvYIcLCMK6fNXASfDH6EFB1Emb8DlHJcoRF4+IYcAuLLegp6v2bDMwbSm3lIUk9T2Gj9dtUQutP7br/cXJJmQozh5VwmfWS0+SRfTuJjb54llACpngRGuo47E3WbxbyQV1Ms/9EYyjTA32NHuRIIWPUP7245pjp3wqCxQrBA177a33zvI3dpTiF8IJebVFK0pxYuX3Etx5nj4V4Q6wPJvXLO+lheHGoQdy82wxRL1iuhjXqco1oA9dCv/qFBHg0KRk5DgWsyqfXCUYdSSxQGChrI1ZAm+cXUQkZrsS63zj4NEPlyUhdNv/3xuyyht3Gmv+rZzmUQqbv86TTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:35:36 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 09:35:36 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Christopherson,, Sean" <seanjc@google.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "mic@digikod.net" <mic@digikod.net>,
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "amoorthy@google.com" <amoorthy@google.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"tabba@google.com" <tabba@google.com>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "Annapurve, Vishal" <vannapurve@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "mail@maciej.szmigiero.name"
	<mail@maciej.szmigiero.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "maz@kernel.org" <maz@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>, "dmatlack@google.com"
	<dmatlack@google.com>, "anup@brainfault.org" <anup@brainfault.org>,
	"yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "qperret@google.com" <qperret@google.com>,
	"brauner@kernel.org" <brauner@kernel.org>, "isaku.yamahata@gmail.com"
	<isaku.yamahata@gmail.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "Wang, Wei W" <wei.w.wang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Thread-Topic: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Thread-Index: AQHaCQKnsgoTcbnsvUKkAITO6oVjaLBlURAAgABw5QCAAKIkgIAAabmA
Date: Thu, 2 Nov 2023 09:35:35 +0000
Message-ID: <32cb71700aedcbd1f65276cf44a601760ffc364b.camel@intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
	 <20231027182217.3615211-10-seanjc@google.com>
	 <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
	 <ZUKMsOdg3N9wmEzy@google.com>
	 <64e3764e36ba7a00d94cc7db1dea1ef06b620aaf.camel@intel.com>
In-Reply-To: <64e3764e36ba7a00d94cc7db1dea1ef06b620aaf.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ1PR11MB6179:EE_
x-ms-office365-filtering-correlation-id: 82da4200-7f63-416f-6743-08dbdb87113e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TxLFXlVtDNnTyT8wpY9mhAPQ9sjguquwFou9ONyyELsPOh1zQRemHyhQjWzJ8Wfv8btLwTd53CezrVTwKdkDfOt446ZxTNPwmLzrM+7sHe1wYcEtplEvAsFaNIeKbbDBqQP55/+4CmqIJHc8pZX8Bf9NA/ZKHvW0+XFFMo2aVp9qkqIs7vSAVyw6uJLs9WYXnUWj6+MLsanACjRjB57IPG9+l5uWTma/T8XbSFaK19MOr6i25v+oG8qq4/RuqxlFwm9ca8y9mPUNuChT9+5vdm6Zei4/Hufai7+cDYhl4zx4fJdqx5iAiD1Nh4QX2NqcH7LoOV/2koRyyuFt47Yx6v7sG4qSEzwI5XlJEofTxjdvD6jTBDD2BBSiT4IJ5iZgruvC6T5fvVFz5RQ59eGj+BTTttAkRU5xLHy5Hj8sfnwdIzt5YT95SCePv9m43qkbrRzgglM0PUPXnXQCeX8dkxNcY4SWxVmuZjyQs1l8d0RjudUdTv2d2z2SvOmMBU8Tb3be17hup90dZ0WVkQDtt+xq66FLSh/+Sy+JSj04PqYpFJk1hR3+2Hns79OCke9lKDUwrr2Qcmhy0r7wUh0QA1mii+SOwMSBmft6M6LX5hQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(6486002)(41300700001)(966005)(6506007)(71200400001)(2616005)(4326008)(64756008)(8676002)(66556008)(76116006)(8936002)(54906003)(66476007)(83380400001)(26005)(5660300002)(7416002)(7406005)(66446008)(2906002)(6916009)(91956017)(66946007)(316002)(38100700002)(86362001)(82960400001)(6512007)(122000001)(38070700009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2xtSnl0aEpUVmNTSDVKWmFxU0V4RTE3NElhTnVuZ0dnTWlKUHZSeldQSEN0?=
 =?utf-8?B?em9iVU1LbFZDUGxENEcvKzkxYnhXNlAvamlDZGJQUng2NGRma3d0ai9GMzVz?=
 =?utf-8?B?MTl4cmxJWjdZdjArNHRoeU5FaUZOakxuMm40bGV5Si9Da0ZFRmJwdjY5dDZP?=
 =?utf-8?B?eHVpOHhFZk1NRzRFRlhlTGtLcEJIV3VjNDd3bHJMOHpnTXRoV3lqb3BSWEJP?=
 =?utf-8?B?VDVjK0VDU0tlaWlveHU0NGdicFdWdkFyVUg0UHVaOG9HekNtSW1wM3o0dXhw?=
 =?utf-8?B?b3QzbGVrTDJhaHdmUkNLWWJZc09SRExWR3I4QTgveFVQRmliV2JENHdoYkZv?=
 =?utf-8?B?d0lVTXV0bkg1MVZ3Uzc5dEZHcWd5UDBCK3RpVWQxb1ZCMExLZlUwSjZlSXZS?=
 =?utf-8?B?WHNPbUxBN21MUkhpOE9aVjlZU21sNStYamsrUWNUejFGck9iTG9DVllLSVpv?=
 =?utf-8?B?QmIxUWpWdElZQ2VSM0JUMFAwN0tlbWN3NTdpcUVkUTdCdUJUUnhIR2VDWTZ3?=
 =?utf-8?B?dW1Rd2MrcjdRMUh5aVNscENlU1djYllBUTdsT1RpMWhyWlQ3LzZ1OGR0RU05?=
 =?utf-8?B?UlZueEQ4NjlzbjRmNkZrdXpIazZYc1dYT2kwRlNhcTVOZUprNWxLNEM2TUVi?=
 =?utf-8?B?cWRvQTlubFRlWmNCV1BBRjg5bkZiTFFMNkxZQ3cvZzM4K0pmeUluOFNMWjhN?=
 =?utf-8?B?dmZ4Rjh2TGpTWXVYUm85VDBGZHhwakMvLzZNL1lxM1l6d1dhbEQ2YzhzbnNj?=
 =?utf-8?B?VnE3dlNpL1ZIelRBL3Fqa1hQNW9zRzFDM3VwN2pBdno4V2JTcWh3WlJMY1hQ?=
 =?utf-8?B?VWhqYU9ndlNxNW9QQTdySEk4S0FITWtoRk5zaVl4SzJmYVBYdU9xaDJiK1pP?=
 =?utf-8?B?Njh0QkVGTzJIRi9teTc2T0RSRmFheFFBMG1jUkdRNUl0ZTFLMXdrV29RaUxD?=
 =?utf-8?B?aFpkR25Kc243Z2EzYTA3QnJHdkVhUWZPOHE0K1ByQ2JJTEl6ZFpodEpwZ1d5?=
 =?utf-8?B?RWxnRWtIRnZ6Vnh1MWVPb1UwQW0rT2hUUEZUYUFXMW1VVkZ3VTBsTmxyRDhy?=
 =?utf-8?B?ZUNZSWpQUkxOYWZLeGkxUkxDNnpYU1NrLzRBYnBodFdTOGJTbktzTGZOZTNr?=
 =?utf-8?B?T045bjhFRWppTTZCZm9FTkJvaXBxbnJUSU9tQysycndUSnhLeG1ZdkhwZkxD?=
 =?utf-8?B?aCtZcGxkNzdGNDdneWVRRE1RQnlyYlhyQkdSd0tCQzJydnV2d3FTaUhaRDMr?=
 =?utf-8?B?cDIrNTdMOXpIVjcxU3kxWjFtMWZBTXhZSEZ3TkJvb2wzd0xYYWM3MmNsWHE1?=
 =?utf-8?B?ejBqSzFoNUs0RWFyWlZmYythT0UyZkdpejlKM2ptc2FOSWRtVXFNK3VublJq?=
 =?utf-8?B?cUN2TkxHMFZkWSswQ1cvZHlVQkFSTzZQQVlRek5ZOE5Fam5ZTUV3WmtnUGpz?=
 =?utf-8?B?MzFMUFBISU9BVEtEbFJUbGN6RVE2YWZtZnM4ZTlUWkF1a3Q0TEU5UllWc0dD?=
 =?utf-8?B?TDQvMnR3WCsvanJib1c3T0JjSEdIMG9ZNDJPejUvSWdLY2wwMG1VODFNYzAv?=
 =?utf-8?B?UXl1VnRpY2owTlRqUnFlR25peXIzTGVNSGlVMnBpVVNMN0QvMkt2VVdCelJV?=
 =?utf-8?B?U2tnU0RIaDQ4eElCY3RoQ3cyeFFnWnROUFNLNjJBcjRSeXk0eG5Pc1p6cmFJ?=
 =?utf-8?B?dTlnSE5jR0xrdzZGSlRqVGRDSWRrLzBoSXJZS052dTF6NEJMSlczUTdHOEc0?=
 =?utf-8?B?WVhFdEVCNUVZYnNqN0NucmxlRSs0ZjNETThxRkN0TjZzZmVsL042aGpaZHFq?=
 =?utf-8?B?NFdYSlR0cmk3VHFHanF6cGpvcFM4eGJNeFMrVk5ZbkF6WGZGYlN4aUVFbVhu?=
 =?utf-8?B?dmlIVzJhc0puZDlXV0kvcTdTa3Q0cEU3ZmcycU5qS1ZOTjVrZUxQQlJFUFhN?=
 =?utf-8?B?cCs0SElJN21pUHk0S0hLVHF2TjZoOFJkQzFIaklTUUwyUG55L2NSbnZOQy9s?=
 =?utf-8?B?WEVmLzNVc3A5aFdhVUg2eVFKL1phUklXZnVOOTZtSEs4TUYvaUM0TGlPdTJ5?=
 =?utf-8?B?RHdtNzdCYThEUm9WbDB6SjBFa21tODlYdnhkNWhBR3ZuK1MxSkpZTUcxcDAy?=
 =?utf-8?B?WHhCdGhuWGZkWU91UkQ3d1dMaVB4ODRmZEpHelNkSVZlOWpLSitIQWNWVk80?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAECC48038C4554DA998B24D16B9332B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82da4200-7f63-416f-6743-08dbdb87113e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 09:35:35.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enp1EsQGJT/bv7z7pycADECFt+caLxo1PZlXc/7uu/P2lV7Y3CPeU1vH3dznWl7/GdOfwsnzLoFFRhRCns1qMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6179
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDIzLTExLTAyIGF0IDAzOjE3ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBXZWQsIDIwMjMtMTEtMDEgYXQgMTA6MzYgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3Jv
dGU6DQo+ID4gT24gV2VkLCBOb3YgMDEsIDIwMjMsIEthaSBIdWFuZyB3cm90ZToNCj4gPiA+IA0K
PiA+ID4gPiArNy4zNCBLVk1fQ0FQX01FTU9SWV9GQVVMVF9JTkZPDQo+ID4gPiA+ICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gKw0KPiA+ID4gPiArOkFyY2hpdGVjdHVy
ZXM6IHg4Ng0KPiA+ID4gPiArOlJldHVybnM6IEluZm9ybWF0aW9uYWwgb25seSwgLUVJTlZBTCBv
biBkaXJlY3QgS1ZNX0VOQUJMRV9DQVAuDQo+ID4gPiA+ICsNCj4gPiA+ID4gK1RoZSBwcmVzZW5j
ZSBvZiB0aGlzIGNhcGFiaWxpdHkgaW5kaWNhdGVzIHRoYXQgS1ZNX1JVTiB3aWxsIGZpbGwNCj4g
PiA+ID4gK2t2bV9ydW4ubWVtb3J5X2ZhdWx0IGlmIEtWTSBjYW5ub3QgcmVzb2x2ZSBhIGd1ZXN0
IHBhZ2UgZmF1bHQgVk0tRXhpdCwgZS5nLiBpZg0KPiA+ID4gPiArdGhlcmUgaXMgYSB2YWxpZCBt
ZW1zbG90IGJ1dCBubyBiYWNraW5nIFZNQSBmb3IgdGhlIGNvcnJlc3BvbmRpbmcgaG9zdCB2aXJ0
dWFsDQo+ID4gPiA+ICthZGRyZXNzLg0KPiA+ID4gPiArDQo+ID4gPiA+ICtUaGUgaW5mb3JtYXRp
b24gaW4ga3ZtX3J1bi5tZW1vcnlfZmF1bHQgaXMgdmFsaWQgaWYgYW5kIG9ubHkgaWYgS1ZNX1JV
TiByZXR1cm5zDQo+ID4gPiA+ICthbiBlcnJvciB3aXRoIGVycm5vPUVGQVVMVCBvciBlcnJubz1F
SFdQT0lTT04gKmFuZCoga3ZtX3J1bi5leGl0X3JlYXNvbiBpcyBzZXQNCj4gPiA+ID4gK3RvIEtW
TV9FWElUX01FTU9SWV9GQVVMVC4NCj4gPiA+IA0KPiA+ID4gSUlVQyByZXR1cm5pbmcgLUVGQVVM
VCBvciB3aGF0ZXZlciAtZXJybm8gaXMgc29ydCBvZiBLVk0gaW50ZXJuYWwNCj4gPiA+IGltcGxl
bWVudGF0aW9uLg0KPiA+IA0KPiA+IFRoZSBlcnJubyB0aGF0IGlzIHJldHVybmVkIHRvIHVzZXJz
cGFjZSBpcyBBQkkuICBJbiBLVk0sIGl0J3MgYSBfdmVyeV8gcG9vcmx5DQo+ID4gZGVmaW5lZCBB
QkkgZm9yIHRoZSB2YXN0IG1ham9yaXR5IG9mIGlvY3RscygpLCBidXQgaXQncyBzdGlsbCB0ZWNo
bmljYWxseSBBQkkuDQo+ID4gS1ZNIGdldHMgYXdheSB3aXRoIGJlaW5nIGNhdmFsaWVyIHdpdGgg
ZXJybm8gYmVjYXVzZSB0aGUgdmFzdCBtYWpvcml0eSBvZiBlcnJvcnMNCj4gPiBhcmUgY29uc2lk
ZXJlZCBmYXRhbCBieSB1c2VyZXNwYWNlLCBpLmUuIGluIG1vc3QgY2FzZXMsIHVzZXJzcGFjZSBz
aW1wbHkgZG9lc24ndA0KPiA+IGNhcmUgYWJvdXQgdGhlIGV4YWN0IGVycm5vLg0KPiA+IA0KPiA+
IEEgZ29vZCBleGFtcGxlIGlzIEtWTV9SVU4gd2l0aCAtRUlOVFI7IGlmIEtWTSB3ZXJlIHRvIHJl
dHVybiBzb21ldGhpbmcgb3RoZXIgdGhhbg0KPiA+IC1FSU5UUiBvbiBhIHBlbmRpbmcgc2lnbmFs
IG9yIHZjcHUtPnJ1bi0+aW1tZWRpYXRlX2V4aXQsIHVzZXJzcGFjZSB3b3VsZCBmYWxsIG92ZXIu
DQo+ID4gDQo+ID4gPiBJcyBpdCBiZXR0ZXIgdG8gcmVsYXggdGhlIHZhbGlkaXR5IG9mIGt2bV9y
dW4ubWVtb3J5X2ZhdWx0IHdoZW4NCj4gPiA+IEtWTV9SVU4gcmV0dXJucyBhbnkgLWVycm5vPw0K
PiA+IA0KPiA+IE5vdCB1bmxlc3MgdGhlcmUncyBhIG5lZWQgdG8gZG8gc28sIGFuZCBpZiB0aGVy
ZSBpcyB0aGVuIHdlIGNhbiB1cGRhdGUgdGhlDQo+ID4gZG9jdW1lbnRhdGlvbiBhY2NvcmRpbmds
eS4gIElmIEtWTSdzIEFCSSBpcyB0aGF0IGt2bV9ydW4ubWVtb3J5X2ZhdWx0IGlzIHZhbGlkDQo+
ID4gZm9yIGFueSBlcnJubywgdGhlbiBLVk0gd291bGQgbmVlZCB0byBwdXJnZSBrdm1fcnVuLmV4
aXRfcmVhc29uIHN1cGVyIGVhcmx5IGluDQo+ID4gS1ZNX1JVTiwgZS5nLiB0byBwcmV2ZW50IGFu
IC1FSU5UUiByZXR1cm4gZHVlIHRvIGltbWVkaWF0ZV9leGl0IGZyb20gYmVpbmcNCj4gPiBtaXNp
bnRlcnByZXRlZCBhcyBLVk1fRVhJVF9NRU1PUllfRkFVTFQuICBBbmQgcHVyZ2luZyBleGl0X3Jl
YXNvbiBzdXBlciBlYXJseSBpcw0KPiA+IHN1YnRseSB0cmlja3kgYmVjYXVzZSBLVk0ncyAoYWdh
aW4sIHBvb3JseSBkb2N1bWVudGVkKSBBQkkgaXMgdGhhdCAqc29tZSogZXhpdA0KPiA+IHJlYXNv
bnMgYXJlIHByZXNlcnZlZCBhY3Jvc3MgS1ZNX1JVTiB3aXRoIHZjcHUtPnJ1bi0+aW1tZWRpYXRl
X2V4aXQgKG9yIHdpdGggYQ0KPiA+IHBlbmRpbmcgc2lnbmFsKS4NCj4gPiANCj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvWkZGYndPWFo1dUklMkZnZGFmQGdvb2dsZS5jb20NCj4gPiAN
Cj4gPiANCj4gDQo+IEFncmVlZCB3aXRoIG5vdCB0byByZWxheCB0byBhbnkgZXJybm8uICBIb3dl
dmVyIHVzaW5nIC1FRkFVTFQgYXMgcGFydCBvZiBBQkkNCj4gZGVmaW5pdGlvbiBzZWVtcyBhIGxp
dHRsZSBiaXQgZGFuZ2Vyb3VzLCBlLmcuLCBzb21lb25lIGNvdWxkIGFjY2lkZW50YWxseSBvcg0K
PiBtaXN0YWtlbmx5IHJldHVybiAtRUZBVUxUIGluIEtWTV9SVU4gYXQgZWFybHkgdGltZSBhbmQv
b3IgaW4gYSBjb21wbGV0ZWx5DQo+IGRpZmZlcmVudCBjb2RlIHBhdGgsIGV0Yy4gwqAtRUlOVFIg
aGFzIHdlbGwgZGVmaW5lZCBtZWFuaW5nLCBidXQgLUVGQVVMVCAod2hpY2gNCj4gaXMgIkJhZCBh
ZGRyZXNzIikgc2VlbXMgZG9lc24ndCBidXQgSSBhbSBub3Qgc3VyZSBlaXRoZXIuIDotKQ0KPiAN
Cj4gT25lIGV4YW1wbGUgaXMsIGZvciBiYWNraW5nIFZNQSB3aXRoIFZNX0lPIHwgVk1fUEZOTUFQ
LCBodmFfdG9fcGZuKCkgcmV0dXJucw0KPiBLVk1fUEZOX0VSUl9GQVVMVCB3aGVuIHRoZSBrZXJu
ZWwgY2Fubm90IGdldCBhIHZhbGlkIFBGTiAoZS5nLiB3aGVuIFNHWCB2ZXBjDQo+IGZhdWx0IGhh
bmRsZXIgZmFpbGVkIHRvIGFsbG9jYXRlIEVQQykgYW5kIGt2bV9oYW5kbGVfZXJyb3JfcGZuKCkg
d2lsbCBqdXN0DQo+IHJldHVybiAtRUZBVUxULiAgSWYga3ZtX3J1bi5leGl0X3JlYXNvbiBpc24n
dCBwdXJnZWQgZWFybHkgdGhlbiBpcyBpdCBwb3NzaWJsZQ0KPiB0byBoYXZlIHNvbWUgaXNzdWUg
aGVyZT8NCj4gDQoNCkFsc28sIHJlZ2FyZGxlc3Mgd2hldGhlciAtRUZBVUxUIGlzIHRvbyBhbWJp
Z3VvdXMgdG8gYmUgcGFydCBvZiBBQkksIGNvdWxkIHlvdQ0KZWxhYm9yYXRlIHRoZSBFSFdQT0lT
T04gcGFydD8gIElJVUMgS1ZNIGNhbiBhbHJlYWR5IGhhbmRsZSB0aGUgY2FzZSBvZiBwb2lzb25l
ZA0KcGFnZSBieSBzZW5kaW5nIHNpZ25hbCB0byB1c2VyIGFwcDogDQoNCglzdGF0aWMgaW50IGt2
bV9oYW5kbGVfZXJyb3JfcGZuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgDQoJCQlzdHJ1Y3Qga3Zt
X3BhZ2VfZmF1bHQgKmZhdWx0KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgDQoJeyAgICAgICANCgkJLi4uDQoNCiAgICAgICAJCWlmIChmYXVsdC0+cGZuID09
IEtWTV9QRk5fRVJSX0hXUE9JU09OKSB7DQogICAgICAgICAgICAgIAkJa3ZtX3NlbmRfaHdwb2lz
b25fc2lnbmFsKGZhdWx0LT5zbG90LCBmYXVsdC0+Z2ZuKTsNCiAgICAgICAgICAgICAgICAJcmV0
dXJuIFJFVF9QRl9SRVRSWTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICANCiAgICAgICAgCX0NCgl9DQoNCkFuZCAoc29ycnkgdG8gaGlqYWNrKSBJIGFtIHRoaW5raW5n
IHdoZXRoZXIgIlNHWCB2ZXBjIHVuYWJsZSB0byBhbGxvY2F0ZSBFUEMiDQpjYW4gYWxzbyB1c2Ug
dGhpcyBtZW1vcnlfZmF1bHQgbWVjaGFuaXNtLiAgQ3VycmVudGx5IGFzIG1lbnRpb25lZCBhYm92
ZSB3aGVuDQp2ZXBjIGZhdWx0IGhhbmRsZXIgY2Fubm90IGFsbG9jYXRlIEVQQyBwYWdlIEtWTSBy
ZXR1cm5zIC1FRkFVTFQgdG8gUWVtdSwgYW5kDQpRZW11IHByaW50cyAuLi4NCg0KCS4uLjogQmFk
IGFkZHJlc3MNCgk8ZHVtcCBndWVzdCBjcHUgcmVnaXN0ZXJzPg0KDQouLi4gd2hpY2ggaXMgbm9u
c2Vuc2UuDQoNCklmIHdlIGNhbiB1c2UgbWVtb3J5X2ZhdWx0LmZsYWdzIChvciBpcyAnZmF1bHRf
cmVhc29uJyBhIGJldHRlciBuYW1lPykgdG8gY2FycnkNCmEgc3BlY2lmaWMgdmFsdWUgZm9yIEVQ
QyB0byBsZXQgUWVtdSBrbm93IGFuZCBRZW11IGNhbiB0aGVuIGRvIG1vcmUgcmVhc29uYWJsZQ0K
dGhpbmdzLg0KDQo=

