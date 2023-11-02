Return-Path: <linux-fsdevel+bounces-1786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9227DEB42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 04:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5261C20E6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC31863;
	Thu,  2 Nov 2023 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBQq+HzE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F0184F;
	Thu,  2 Nov 2023 03:17:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E47C9F;
	Wed,  1 Nov 2023 20:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698895052; x=1730431052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4Lk/L4/BLcelwM4VhmXR9LEkLksp6ecUesdhMoTNJW0=;
  b=kBQq+HzEiEYEJ1xXTFFu08X6quAZsho2J5hOY+j6ByV+41iuLp3cSQZ/
   4zo1x2R1r1uOfuZV6u0OTina2DnV5CB/jSw/EAD6pcWrFQ1i/rI9KRbqt
   i45IN6vJgdQBV84uCofIvKtrHAvK4CZ3QQsKYWS6ei3WHRtppol73vmm3
   wZhugEqjQoYq6YiDiXSnzNWp99r6ZWg+CvBnnyXRU+BkpJrHdjnagrwXU
   xpXfGApo6TDEl7oBqtMvGJO93b8ZrXRsCv6uzvCJ1T0/1JAVteVARvYZf
   VbKyEHxQwsPos+AqFc/rdJr+7lNQ12r24CMviz+eRZa085krnF2LXaJQO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452924957"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="452924957"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 20:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="761149696"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="761149696"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 20:17:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:17:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:17:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 20:17:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 20:17:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCbVd2rIVqhrAZ1S64g4aGiIXvIHACf7FBRqE5HzwcQJudcz/cVQtNGylsYbllvvPUtcMNpExnK3E3qkwaeRxxoqEY01l4sonb2rWmeGhraGm+Y/w435YoD2XuiVMsvGRh091iCahx3QvV2gpl6dtgLbtjRqrhKJtxHqrynMtBo+OPmLbQGVvTlkQyPlnkUSLIMSRPj+NG9cKaxumMTiLEFC0rJDkmeDsShrjr/5oeL96d/3ljd06vGPYDEHaugjELsUfq682kquEkPAR8trU8QU1nIqQ7TAqewRfHm1ueEAMWtZ1FjmrWWPykfyAFKqGP8xnUu+rowjn40mmccopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lk/L4/BLcelwM4VhmXR9LEkLksp6ecUesdhMoTNJW0=;
 b=P/ZiguKKrMPR4xNrSz3Z6U5HxnLIkUUdzmo83fEJYukhnbl0gD42S0q5e2LPRz+udWjjkeOnHVkHpouDl/w5hddjs7mqvRTMOtGQNWf2/ckvQcwKr753zkIyG1yjeqql6rgjqA4IukQRn6ODQ2P16w3zO5cQL3JdaLkqRNriCpJdhTVz8RtixwuAkQ9u36rQy6HigoFEYSjaRbTTReXcJ9eV2keeNXJphzlDT4PGNVtsjNYLMzoU8fNXSx982BsWf7u60vjS6ylkfSRXPgb1WxaZ6uDkaXkQeLAkH093sE1Oj8rw2rAz4XuCwaZOA8lgu0zW43tAkGCoc9muYH+pLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5010.namprd11.prod.outlook.com (2603:10b6:303:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 03:17:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 03:17:12 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Christopherson,, Sean" <seanjc@google.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "mic@digikod.net" <mic@digikod.net>,
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "amoorthy@google.com" <amoorthy@google.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"tabba@google.com" <tabba@google.com>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Annapurve, Vishal"
	<vannapurve@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"maz@kernel.org" <maz@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "dmatlack@google.com" <dmatlack@google.com>,
	"anup@brainfault.org" <anup@brainfault.org>, "yu.c.zhang@linux.intel.com"
	<yu.c.zhang@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"qperret@google.com" <qperret@google.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "Wang, Wei W" <wei.w.wang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Thread-Topic: [PATCH v13 09/35] KVM: Add KVM_EXIT_MEMORY_FAULT exit to report
 faults to userspace
Thread-Index: AQHaCQKnsgoTcbnsvUKkAITO6oVjaLBlURAAgABw5QCAAKIkgA==
Date: Thu, 2 Nov 2023 03:17:12 +0000
Message-ID: <64e3764e36ba7a00d94cc7db1dea1ef06b620aaf.camel@intel.com>
References: <20231027182217.3615211-1-seanjc@google.com>
	 <20231027182217.3615211-10-seanjc@google.com>
	 <482bfea6f54ea1bb7d1ad75e03541d0ba0e5be6f.camel@intel.com>
	 <ZUKMsOdg3N9wmEzy@google.com>
In-Reply-To: <ZUKMsOdg3N9wmEzy@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB5010:EE_
x-ms-office365-filtering-correlation-id: 47e48193-2c2d-418e-8bdc-08dbdb5234cb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfDoU1c8UDpiyCZy9LV6Qq2LSKxb7qcrspO0WyQeYfc9EqZFq/LXIvB32jeN9XS1hheIHy+tDSOrraKRtKXqQIgoe2R/KoA6VG9SMFDe7zfVl0izmyoZYitImgZEGi5Rhh3/QIKl8ABHneq5jMTGcM35u1Ijzd64+2RHwF97QtiyOmWjZs+xOt3Y0jnQ2DeDIdeCx5BuAlz1k9UB+5U/z6bjPDZNDKu7I+pFjUajfXeCgyCtFf0YRzNx1/v3kYwjnWNmOk12Pb2idlfCBPLJFMGljy46xdq1qOFToDb9hroJcPkS+lPDoUuxyOJOIGnOJ2igLWxHjb1Ng9hFFVBmWOceYe5MCsq9G20OdLBZd/IfRpjMB40am/PjcDTqTWYZklXO82BuCu1exptwPsLI/6Wd9tDvOSgGfLmMTYBvnxvU9rNkcfRzGzJpbqvQ94FBYOultw3jUz2XN4Two45Oh9fE78MRQ7SsenqgAHIp4d3u0NMLqEyUO+vb/JJkQCSF9qajU0j7bTDoBYuOQYeM8sOYlCIGhluGx7yCbJ6MuQK3alKLsQ1kbNz8R/fy80p3748HdAOK4P4UcHErtjQDg9HhV2pVFmOfdyTCFwUjLzw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(26005)(6512007)(2616005)(38100700002)(122000001)(36756003)(86362001)(38070700009)(83380400001)(82960400001)(7406005)(66946007)(4326008)(8676002)(8936002)(7416002)(5660300002)(76116006)(316002)(66446008)(91956017)(2906002)(66476007)(64756008)(66556008)(6916009)(54906003)(71200400001)(966005)(6486002)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkoyeFNCNitYWHczeGV2L0Z6bDM5a2hkUWJmYk5nVTBjYTc1alA4eDc5Q3ND?=
 =?utf-8?B?cVhNOTRYM1d1NnFvRzJnbEdmTVVBWmRMdStqQ0JIa2ZlbHp5RnRFVTlzdEw3?=
 =?utf-8?B?NDdISlFuL2RhWHBKdnZHcFg5UGtveGFscWR1Q2FxZFd3cVMwY0ltbXd4dEFH?=
 =?utf-8?B?THg1U0RkUHNXUVNscnNic3RmaWgrODNoTHN6RUhjaU1RQWU5V0xlemVLc1Ru?=
 =?utf-8?B?ZFpsQVVRVkNzTDNuK0NXMVRxMi9hZmxCdHNTemU4SXRSVktteDA5SkJzbnp4?=
 =?utf-8?B?Z0RzdDJndThQVC9BcGYrMzRRVGQycFBkYmJOWU4xaHpucW40SDQ2QWhxTito?=
 =?utf-8?B?NTRXMXl5eXRDSHdqMkMwbG5YY25RSFFBMEcvUlFFSzBubDBsejdrZ1lDYlky?=
 =?utf-8?B?aDNUZnJFRU5mWXl6TlhkaHlpTzNqMzgraS9tdUVDbGZtNFk1aVlXUkJTUFdW?=
 =?utf-8?B?MEJjR0t3bzNKcDhxbkZ6bGZDQjFzVTlRSk9zT3lITTIwSklJZmxqVm9GRUhm?=
 =?utf-8?B?S1RUYjhTaWtNcUNxTEF2eURuT0Y2NTVHQnNjNVJtd3VrNlhTenRXb3owSWpp?=
 =?utf-8?B?djlSUWRVNjUxSXVDM2ZwdDh2OUFhMzBtYUszMzZvRlZhY2RybTRyUlNsWFV6?=
 =?utf-8?B?ZVc5STRaSzlsQjNrV1ljS00ra0k3ajJLazd1d05heUhjWks2V0xCMEFlS0Np?=
 =?utf-8?B?UlhPVjJsZzZIeDc3SmhwZThGaWFNMW16dVlyLzc1TXR3VmJZclphTEdFQ1hB?=
 =?utf-8?B?alJTYW9pZ1MvOUpxYVdremlLdFAySDQveE94citEV0tGWUVybXZCMHJSbnc1?=
 =?utf-8?B?alJjT2NxdUFiWjhVOXJKRTQ5TmY2ZVJkOVZPUng2K0h2UWMxMzNETVVxWGRY?=
 =?utf-8?B?ekRRbHMvMWZCMFFlUUN4UWR6THhzV1Nvb09RMFg3TnZNSVJPNXVhUFhhTUZC?=
 =?utf-8?B?YVBNcENDdktXTG5UTHRFaWFuRlpxSjVCT0ZhOE83ZjFtRG9rQnV5amtsRzZB?=
 =?utf-8?B?bVhYRDQ0cmdTS0F6Q1pEamZJb2xIbExCOFZodHdGekVuNmsyS1Bhekcwc3Fv?=
 =?utf-8?B?UTd6YnVJWTkvL205TVZxYW1CMGloT0ZabnM4My9iYXQ5NkRNbERUcFkxQ1N1?=
 =?utf-8?B?UXlUeEgrNkZONXo3Z1ZDUGNzVnQvQUYxNmZVbUd5SEs0c2JDaXVuTzN0UWlu?=
 =?utf-8?B?d3JiSHVxWnM5dkN1VG0wYXVPc1dESVk2TXBKM0JSczNOMlpFUzJ1TFAwb1NK?=
 =?utf-8?B?VndUV216enJwam9wdVhmVTloVEZIcEM0Y2prOEVicjhYUXJNcXFrUWplb3lo?=
 =?utf-8?B?c3JleXJPTm1CeWVzMU1adVFzcFl5YkFYTHN1aENjQTFWVEZUYkJQdUhQTXRC?=
 =?utf-8?B?TXhaTzNQMnpxWGNhNnNPbGNtZFhUanZURWhNZCs4VGI1cW1zb2hUYjk3bGpR?=
 =?utf-8?B?WUljYWJBdzJHUmNZd0F1S1RhQVdSaXdNUGNEMW43eFliZ0VncDdwaHl1dTdm?=
 =?utf-8?B?bDkwY3ZNUzJOUWI3Tk9ZYU83N2cxL09IOEk1R3UvVHFNb2E0NUhYMGRTdGc5?=
 =?utf-8?B?YVBlSTN6c21LWTNTTGgvYlordldHNnVFUEg2Z0JTRFRVM0lIRmE2SzErcGlT?=
 =?utf-8?B?bko2ZmROckNGcGY1dkZLaktEYUxqaHUzNHpiUkdXUTY3ZDZHSG13U2l5TUJt?=
 =?utf-8?B?WTdvN3ZUTGxSUGY1QWxiaHI1RGo3ZXdOZlR1V25rV0M1aWpjUlgyRldSRSth?=
 =?utf-8?B?NXdXVElERzJxMTVDTGF4NkEvc1lYVExycGc2ZG1aQ2JkeVhDLzZWUzBRSXV2?=
 =?utf-8?B?bjg2dW1scUNscG5TZ2p6bmp6cStaRWp5ZVkzV0JNRlI4K3FBUlhaRUtBakg3?=
 =?utf-8?B?dTdxWVZsdElOUXlCbnMxcFFabEJxdmorNDFYL2dvYzRPYTJjVTlLc2p6bnJO?=
 =?utf-8?B?Tm4xRW93bE4weVppNnpLZW5CZ0ozRzU3aEYvT3RWbE9PdVU1b3BDNmE4SzFh?=
 =?utf-8?B?WlpGVStqZjUyQjhzZEtDK1VoYnhyTG91c1pDRnF6WDVLNXczRXFtUnlVRThV?=
 =?utf-8?B?bVJFdTVvYnhrYzNsTGYwUFVLcjhpdkVJQTRkSVFCQkVZc0o3QWhwWDNjUkJD?=
 =?utf-8?B?ZnQ5eVBqOExmUzhxWDFncDFpUGN3cmw5NkMvK3RLM0N4REtNY2xvTjhvSDYz?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0861DBF72B07F54483DC2732B6675773@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e48193-2c2d-418e-8bdc-08dbdb5234cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 03:17:12.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCKU5CTD/JyZJ9aM+C2h/3lLgEPHhYDBNL2xeIN09mQb/VX+vhWQDqcDJmZJn78t+HDC58/X5duEH/NYuTUYLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5010
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDIzLTExLTAxIGF0IDEwOjM2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIE5vdiAwMSwgMjAyMywgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IA0KPiA+
ID4gKzcuMzQgS1ZNX0NBUF9NRU1PUllfRkFVTFRfSU5GTw0KPiA+ID4gKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gKw0KPiA+ID4gKzpBcmNoaXRlY3R1cmVzOiB4ODYNCj4g
PiA+ICs6UmV0dXJuczogSW5mb3JtYXRpb25hbCBvbmx5LCAtRUlOVkFMIG9uIGRpcmVjdCBLVk1f
RU5BQkxFX0NBUC4NCj4gPiA+ICsNCj4gPiA+ICtUaGUgcHJlc2VuY2Ugb2YgdGhpcyBjYXBhYmls
aXR5IGluZGljYXRlcyB0aGF0IEtWTV9SVU4gd2lsbCBmaWxsDQo+ID4gPiAra3ZtX3J1bi5tZW1v
cnlfZmF1bHQgaWYgS1ZNIGNhbm5vdCByZXNvbHZlIGEgZ3Vlc3QgcGFnZSBmYXVsdCBWTS1FeGl0
LCBlLmcuIGlmDQo+ID4gPiArdGhlcmUgaXMgYSB2YWxpZCBtZW1zbG90IGJ1dCBubyBiYWNraW5n
IFZNQSBmb3IgdGhlIGNvcnJlc3BvbmRpbmcgaG9zdCB2aXJ0dWFsDQo+ID4gPiArYWRkcmVzcy4N
Cj4gPiA+ICsNCj4gPiA+ICtUaGUgaW5mb3JtYXRpb24gaW4ga3ZtX3J1bi5tZW1vcnlfZmF1bHQg
aXMgdmFsaWQgaWYgYW5kIG9ubHkgaWYgS1ZNX1JVTiByZXR1cm5zDQo+ID4gPiArYW4gZXJyb3Ig
d2l0aCBlcnJubz1FRkFVTFQgb3IgZXJybm89RUhXUE9JU09OICphbmQqIGt2bV9ydW4uZXhpdF9y
ZWFzb24gaXMgc2V0DQo+ID4gPiArdG8gS1ZNX0VYSVRfTUVNT1JZX0ZBVUxULg0KPiA+IA0KPiA+
IElJVUMgcmV0dXJuaW5nIC1FRkFVTFQgb3Igd2hhdGV2ZXIgLWVycm5vIGlzIHNvcnQgb2YgS1ZN
IGludGVybmFsDQo+ID4gaW1wbGVtZW50YXRpb24uDQo+IA0KPiBUaGUgZXJybm8gdGhhdCBpcyBy
ZXR1cm5lZCB0byB1c2Vyc3BhY2UgaXMgQUJJLiAgSW4gS1ZNLCBpdCdzIGEgX3ZlcnlfIHBvb3Js
eQ0KPiBkZWZpbmVkIEFCSSBmb3IgdGhlIHZhc3QgbWFqb3JpdHkgb2YgaW9jdGxzKCksIGJ1dCBp
dCdzIHN0aWxsIHRlY2huaWNhbGx5IEFCSS4NCj4gS1ZNIGdldHMgYXdheSB3aXRoIGJlaW5nIGNh
dmFsaWVyIHdpdGggZXJybm8gYmVjYXVzZSB0aGUgdmFzdCBtYWpvcml0eSBvZiBlcnJvcnMNCj4g
YXJlIGNvbnNpZGVyZWQgZmF0YWwgYnkgdXNlcmVzcGFjZSwgaS5lLiBpbiBtb3N0IGNhc2VzLCB1
c2Vyc3BhY2Ugc2ltcGx5IGRvZXNuJ3QNCj4gY2FyZSBhYm91dCB0aGUgZXhhY3QgZXJybm8uDQo+
IA0KPiBBIGdvb2QgZXhhbXBsZSBpcyBLVk1fUlVOIHdpdGggLUVJTlRSOyBpZiBLVk0gd2VyZSB0
byByZXR1cm4gc29tZXRoaW5nIG90aGVyIHRoYW4NCj4gLUVJTlRSIG9uIGEgcGVuZGluZyBzaWdu
YWwgb3IgdmNwdS0+cnVuLT5pbW1lZGlhdGVfZXhpdCwgdXNlcnNwYWNlIHdvdWxkIGZhbGwgb3Zl
ci4NCj4gDQo+ID4gSXMgaXQgYmV0dGVyIHRvIHJlbGF4IHRoZSB2YWxpZGl0eSBvZiBrdm1fcnVu
Lm1lbW9yeV9mYXVsdCB3aGVuDQo+ID4gS1ZNX1JVTiByZXR1cm5zIGFueSAtZXJybm8/DQo+IA0K
PiBOb3QgdW5sZXNzIHRoZXJlJ3MgYSBuZWVkIHRvIGRvIHNvLCBhbmQgaWYgdGhlcmUgaXMgdGhl
biB3ZSBjYW4gdXBkYXRlIHRoZQ0KPiBkb2N1bWVudGF0aW9uIGFjY29yZGluZ2x5LiAgSWYgS1ZN
J3MgQUJJIGlzIHRoYXQga3ZtX3J1bi5tZW1vcnlfZmF1bHQgaXMgdmFsaWQNCj4gZm9yIGFueSBl
cnJubywgdGhlbiBLVk0gd291bGQgbmVlZCB0byBwdXJnZSBrdm1fcnVuLmV4aXRfcmVhc29uIHN1
cGVyIGVhcmx5IGluDQo+IEtWTV9SVU4sIGUuZy4gdG8gcHJldmVudCBhbiAtRUlOVFIgcmV0dXJu
IGR1ZSB0byBpbW1lZGlhdGVfZXhpdCBmcm9tIGJlaW5nDQo+IG1pc2ludGVycHJldGVkIGFzIEtW
TV9FWElUX01FTU9SWV9GQVVMVC4gIEFuZCBwdXJnaW5nIGV4aXRfcmVhc29uIHN1cGVyIGVhcmx5
IGlzDQo+IHN1YnRseSB0cmlja3kgYmVjYXVzZSBLVk0ncyAoYWdhaW4sIHBvb3JseSBkb2N1bWVu
dGVkKSBBQkkgaXMgdGhhdCAqc29tZSogZXhpdA0KPiByZWFzb25zIGFyZSBwcmVzZXJ2ZWQgYWNy
b3NzIEtWTV9SVU4gd2l0aCB2Y3B1LT5ydW4tPmltbWVkaWF0ZV9leGl0IChvciB3aXRoIGENCj4g
cGVuZGluZyBzaWduYWwpLg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1pGRmJ3
T1haNXVJJTJGZ2RhZkBnb29nbGUuY29tDQo+IA0KPiANCg0KQWdyZWVkIHdpdGggbm90IHRvIHJl
bGF4IHRvIGFueSBlcnJuby4gIEhvd2V2ZXIgdXNpbmcgLUVGQVVMVCBhcyBwYXJ0IG9mIEFCSQ0K
ZGVmaW5pdGlvbiBzZWVtcyBhIGxpdHRsZSBiaXQgZGFuZ2Vyb3VzLCBlLmcuLCBzb21lb25lIGNv
dWxkIGFjY2lkZW50YWxseSBvcg0KbWlzdGFrZW5seSByZXR1cm4gLUVGQVVMVCBpbiBLVk1fUlVO
IGF0IGVhcmx5IHRpbWUgYW5kL29yIGluIGEgY29tcGxldGVseQ0KZGlmZmVyZW50IGNvZGUgcGF0
aCwgZXRjLiDCoC1FSU5UUiBoYXMgd2VsbCBkZWZpbmVkIG1lYW5pbmcsIGJ1dCAtRUZBVUxUICh3
aGljaA0KaXMgIkJhZCBhZGRyZXNzIikgc2VlbXMgZG9lc24ndCBidXQgSSBhbSBub3Qgc3VyZSBl
aXRoZXIuIDotKQ0KDQpPbmUgZXhhbXBsZSBpcywgZm9yIGJhY2tpbmcgVk1BIHdpdGggVk1fSU8g
fCBWTV9QRk5NQVAsIGh2YV90b19wZm4oKSByZXR1cm5zDQpLVk1fUEZOX0VSUl9GQVVMVCB3aGVu
IHRoZSBrZXJuZWwgY2Fubm90IGdldCBhIHZhbGlkIFBGTiAoZS5nLiB3aGVuIFNHWCB2ZXBjDQpm
YXVsdCBoYW5kbGVyIGZhaWxlZCB0byBhbGxvY2F0ZSBFUEMpIGFuZCBrdm1faGFuZGxlX2Vycm9y
X3BmbigpIHdpbGwganVzdA0KcmV0dXJuIC1FRkFVTFQuICBJZiBrdm1fcnVuLmV4aXRfcmVhc29u
IGlzbid0IHB1cmdlZCBlYXJseSB0aGVuIGlzIGl0IHBvc3NpYmxlDQp0byBoYXZlIHNvbWUgaXNz
dWUgaGVyZT8NCg0KDQo=

