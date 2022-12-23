Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7D86549D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 01:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLWAuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 19:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWAui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:50:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A32D1DDDB;
        Thu, 22 Dec 2022 16:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671756636; x=1703292636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dfpQa3xVfepFtVnUq/Bu8sMVfEBaI5Gc4e0dq+/i174=;
  b=NU8/ADlpFiEmAkmNwiV6HMtoFDbpcq4W71cFf/ctVpn1uhqVarAtpQUJ
   0p3g6IPsPVNpswOak1iF9GHkE3OM0SCfrY22QqvFg+SgHvdfeMZlGGAqu
   ApxqWcJ0Sy+hJACufsDcKfUI0e8JVpGvP1ijMOvn+bWi8s8xwakCHRZ2C
   DRNB6hxwnIRNICZhsHwb+xcq8ik8BcbscprJ0hgx+iZJ3vKyGMI5m1hTE
   INNwAGukOuyvWbgxNpa0+DrDCg2MOiKCkVKzGtI8zWCM8yRhn53/ZpNp2
   zcjXdUBHtaJUCA34cOKiJnVYJi1DbY90tFyy4kUx7j9sVz4pkFhAsCcnM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="322185774"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="322185774"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 16:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="826148960"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="826148960"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 22 Dec 2022 16:50:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 16:50:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 16:50:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 22 Dec 2022 16:50:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 22 Dec 2022 16:50:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhVQY/GT998B4gPnfjKa509FhJiZnUIIZihtKyJJdZ55gUEZwxBN1iqQmzZWPtHIRisnXaRrVLF5qnDF80M51Ms/CUV51sEBN7xcxK0SoUYnya/lA5ePIh03eSbeAuwyEM/8dYILY22G575bXSiFhTny9GPsULSe/O+A6cbPdmSs2ZMpkWxI53h4yTqnSdjMNsLdJZ/k329aBOsgwTgfpoB0URAolKpXimdf7Ba36/i8fSZEUbadlPIBiDqO0N6m1WMmVLHeaANDp9pG/zmaqjSZize50zRCyJkVBOxCIUGwv9LKZS5YHFqS0Gy9CZW9tzsSyIgILDD+GC0+oRbzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfpQa3xVfepFtVnUq/Bu8sMVfEBaI5Gc4e0dq+/i174=;
 b=iVizRZUQZFQgszQtSEQI6dx3MK+Nd4K3OyKj0QBuRaig+LvhFR4f/JUozOt1JhthrHA4JyRPkAUg3yQVAxNSS921Bzctur7eZWReFNLwxqMODvrldutHhhb/X0Jup68jfScn5LzL4QoA3uZ/bKRRloUv7kDlFGGqScxRQsXevfv32Ez4CpNNzLYlWb2Nj+HUi7UYhA5/55C6vhyhHJ3QZSivmeIGer1z/qxOFzacdQRpM7Cnqk2oFmBQf8VzKZ6EFdzHbamvd9IlN7ER/evoY6sePYqOm+q8FQZd3rJxxUh5i4oWpdkk36owVmkzF3Ts+3YxzOSmjWkVBapYJ0tN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7443.namprd11.prod.outlook.com (2603:10b6:8:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 00:50:23 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e%8]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 00:50:22 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "tabba@google.com" <tabba@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Topic: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Index: AQHZBhXuq53UEB1w4kqtU0OzCkPOIq5sjtQAgAhi5ICAAA9XAIABemYAgAATugCAAefUgIAB34kAgABuWYA=
Date:   Fri, 23 Dec 2022 00:50:22 +0000
Message-ID: <05a5ec889f3e04d71c0ed067bedea2e3b0eacd00.camel@intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
         <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
         <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
         <20221219075313.GB1691829@chaop.bj.intel.com>
         <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
         <20221220072228.GA1724933@chaop.bj.intel.com>
         <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
         <20221221133905.GA1766136@chaop.bj.intel.com> <Y6SevJt6XXOsmIBD@google.com>
In-Reply-To: <Y6SevJt6XXOsmIBD@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7443:EE_
x-ms-office365-filtering-correlation-id: 2db37618-6181-42ed-7f91-08dae47fac21
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8wAd6aHoobwGwgyseaaDoAdnDWM7AMIbQ7YjcZjYPz2GOBOMLCxrih1pxZNeqYoLcHNQh42TYJjt7D+AyMqR7o+UW4khho3aezkUAmdSGkz9B1HQghQw81zobAdQ35UD0aoh6TkZBp6KcRgITmEp2aZ5nDq+3TUdheA13987+uerCbanksyOAa2UuAO99jz9tbw1aeAytf3t2By6TnPlG5tewa9S1l95kISzeG7Pxl6Adr0i+w0uwFR4Z1ZnRG7edmM2CddL6vYjJ9ziY/bEDLzOYoB5mHoyBsGdUNY/aL1scF99RuM9rW44VoDsQnxnajd49b4j1IhS9O9N1qdUvOiY7nfdU8QGTGNvr4z9bh1XK/BYpb1Mkon0w8YZS0Bc9mU8MWg+l8jsUxZB9+1DifjfzkKbylNsz/RMewosO1O8n0UghrWH8QxaKKUS4blYjhVr46zNiy9dywWQG4CXa9tqR3YdZ2l2oDdJ8Ot/IWU89TShKIP14eKfCzAIL/9dcah5QrLeGKjwOcXdC1edERQ1/fPnCDfcppPi5NMlbn3829+mYtc0Pox7N4QpBe/igZ6gX+RfG5wCFwShkVhSrynvUqv8Xdn2UFZxZReC+A/rLvUeTkwO/tKFveKzcC1rWlUTNYs8gJ4lYtDKs8M903jVH5Y/CEcPbg2hoWsVJn8K4QCxwnS+bwQQ9yIwV8i5dEk3I3wZe3C/xzuctvEPcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(8936002)(83380400001)(41300700001)(186003)(4001150100001)(2906002)(26005)(5660300002)(6512007)(36756003)(110136005)(6486002)(66946007)(71200400001)(76116006)(478600001)(7416002)(91956017)(7406005)(82960400001)(54906003)(38070700005)(66476007)(4326008)(86362001)(8676002)(6506007)(316002)(66446008)(38100700002)(64756008)(66556008)(2616005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUlNanBjZ1lQdk40Z0YzckFXNHRDb1VVZkNTTU1DblFPNTVrUXVQUmtxdjUr?=
 =?utf-8?B?SXlQUWdsYXpENXRoU1FWczRqb1JBUDN6bUNaSkx3LzFFRXpBUDdWYWRSenZM?=
 =?utf-8?B?UWJMdDd3OU1hQlNzaFNPRDk5MzZBbDFhZHVIRHJMWWxibjcybG9TY01xdmlw?=
 =?utf-8?B?K3FHUDB4QUlZL3g4Ukl2QU1xM0h2ODdRclNIdElnVThPWDI2L2lOOXBST2o1?=
 =?utf-8?B?aDd1aVhISnZmbm1Wbm1FK2Y3WTZleGYrMTcxczB6K1JLNkZlMFlvTFZKcTB3?=
 =?utf-8?B?cHJuRU9CQ1ZVWml6THBUVmlLMURyb3JlNm9DREJEY3lUd3Z4OWh2UWJNTU9P?=
 =?utf-8?B?RDZLY0JuR0UvVURnTE84ZHhPaGxCQU5PSnRnU0I3V2lJVU1yM2lEL3F0Mlpa?=
 =?utf-8?B?bTRWT0p2SGxXRTJQbVRzMEJTTHpibWVrZVA4dXVJK3VhZEZteWUvams5VUEv?=
 =?utf-8?B?RUNkaDBIK0YwMWs2NW1Hc0lScXpSNjNkNUYyQTdwNXhNSVV2VFVHQ3RORFhM?=
 =?utf-8?B?STgvWUlDVlNsT2hNMG1TVkYyNi9tbnpCZ3pRWTZDSFpRUDFHd3VXdGJBREJv?=
 =?utf-8?B?VWpqY2RseGVNVDFzWURTRXpyZVdJZXM3UW1Hc0owNnh3WGJRZFVaaG9HYXNS?=
 =?utf-8?B?MzVlS3prV0lNZXRHdFBwcGYvVlBUcFBZdkxDY0dZV3c1bVduaFZWN3VSa0tz?=
 =?utf-8?B?YmVtOG1lUzVIWVZzTERUb21pd1ljN3htTExYanQwem56Ym9weTNhcVhmYXZz?=
 =?utf-8?B?Ykt3TUlLc2FsdTFFaDdhWXcyZDVacTc5T2tKU2tyS2RMWnJzNURkaloxVStL?=
 =?utf-8?B?cHNDNEVHaXpBSDJFRzFPektkeEJzUEhhYTRPdmZSd1huSUNrNmdXeld6LzZR?=
 =?utf-8?B?NVFzUGZnR2RWajg3bTU5ZVliNUM1MThJSlVqamdhQ1VVbjVJZlFEODVOYnFG?=
 =?utf-8?B?ajE3eUpuMEQ4ZjBXblNWNWVTZ1dzRzNObjd3empIWnRCRmpTMnZCamN3TzFL?=
 =?utf-8?B?Sy9jRmJYT0VuOWRRcStEaXdTNVhPcVQ1Nk91Q2hFSEdjdEpQQVhReXdqRlUw?=
 =?utf-8?B?RUo0V09zcE9JakRiS2s5MW9ZRkZ6eFJuVWE2SWVueEEvUTBYQ0pLMzdHcE1i?=
 =?utf-8?B?dk5qdFlsUTQwRUN6TEppcjF0eUJiL0J5NjMvUHN3RGJ4b1A1QlJMb2xZZFpi?=
 =?utf-8?B?RGYwaXM1ZGFwTmZONHZVYjg4WHRsNE80M0szSlozZzlVWnJpRldHbDF0RkJ1?=
 =?utf-8?B?cEdDcDJvOENUcEx4aHNUZm0vOTYzQ1U4YjNLRW4xRkJIUG4zSngxN0RSZDFC?=
 =?utf-8?B?NDlneEw2ZzNGbC9YMnlmY0VhK3pma3lBWWVsR1RjaVVqS3NHL3BhWXVOY1NQ?=
 =?utf-8?B?Y3R1TjdDNFNWSmRxTUdnZVdrd0NJWXRMaU14RTR5U0w1VjkzTVAzTktrYXdw?=
 =?utf-8?B?NUUwWG1LQnZaOWwvUU1ndkhoN0Jkdk8xNjlzMUxXei9ncUlWbzE4VXZCZm5Y?=
 =?utf-8?B?TW5RUHhDZjkreHhBTERjcHJLcmh6VW1CQ2lES2N3TTJXT0tHTTRpN2ZLUVkv?=
 =?utf-8?B?NVZiTll1SU9iUkxxN0xxdXI0M0hjNmdoTGJPbnozVElwdkZ0aFMyazRlK3l1?=
 =?utf-8?B?R0swSGxVVG5kYjU1ckNNeDJUMGs0NDV0OHJGbEtjTDAvbm1HMGFPblg0SmhL?=
 =?utf-8?B?dE9pTUVFR3NBZW1nL1BHRmJvNk11ZWhKL09IZENEcmJGR1VHRDNaY0EyNEFm?=
 =?utf-8?B?dE1sT093eUpXNHhPL1hQNTE4dGI2SElCWGhIejByNUgwSHNQSHVjV3p3UzhP?=
 =?utf-8?B?NHRxRXE2TWV6blZCR3NyN2RBbnJLL0czTi9KTFF5NEQrQ2M2VVp2N1IwK2NW?=
 =?utf-8?B?TFVIYklKcnJBcXoyTW1wM0FDbU83bWZRdlY0cFFjTFhpWStxZ0c0WkN6VDNW?=
 =?utf-8?B?Q2NUVHhjVzlkUExsV0hrQzBPdWV4Z1FEcTVUY244MFB6VUhiLzVIN0lRcGRD?=
 =?utf-8?B?Mm1JcVpCY0lKVE42RzJIOEo2SllCVVFWREZIakRuR3pBNXB5dFF6QlVaNjdR?=
 =?utf-8?B?NXljaW1EVXB4SXJQZ2RPMVJnOFd0dlg0RXE2ZEJQVjNSc29tL0NYTXUrWnBn?=
 =?utf-8?B?QThaa2NyeXVGcUUycldvR1k4MUxoek9xRVdTeTJ4TDRUSnpsU3laOCtMNThj?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B51BC747AEDC5A43A0AFCE589E590201@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db37618-6181-42ed-7f91-08dae47fac21
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 00:50:22.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yO+CaEoYaMfyD8spdTYkW5perQeCA79t2IUPDest/joyAaAoYPsQ7A671HEaB/pFgqCZl1oV9TfSpi/wbyZ2zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7443
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTIyIGF0IDE4OjE1ICswMDAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIERlYyAyMSwgMjAyMiwgQ2hhbyBQZW5nIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgRGVjIDIwLCAyMDIyIGF0IDA4OjMzOjA1QU0gKzAwMDAsIEh1YW5nLCBLYWkgd3JvdGU6DQo+
ID4gPiBPbiBUdWUsIDIwMjItMTItMjAgYXQgMTU6MjIgKzA4MDAsIENoYW8gUGVuZyB3cm90ZToN
Cj4gPiA+ID4gT24gTW9uLCBEZWMgMTksIDIwMjIgYXQgMDg6NDg6MTBBTSArMDAwMCwgSHVhbmcs
IEthaSB3cm90ZToNCj4gPiA+ID4gPiBPbiBNb24sIDIwMjItMTItMTkgYXQgMTU6NTMgKzA4MDAs
IENoYW8gUGVuZyB3cm90ZToNCj4gPiA+IEJ1dCBmb3Igbm9uLXJlc3RyaWN0ZWQtbWVtIGNhc2Us
IGl0IGlzIGNvcnJlY3QgZm9yIEtWTSB0byBkZWNyZWFzZSBwYWdlJ3MNCj4gPiA+IHJlZmNvdW50
IGFmdGVyIHNldHRpbmcgdXAgbWFwcGluZyBpbiB0aGUgc2Vjb25kYXJ5IG1tdSwgb3RoZXJ3aXNl
IHRoZSBwYWdlIHdpbGwNCj4gPiA+IGJlIHBpbm5lZCBieSBLVk0gZm9yIG5vcm1hbCBWTSAoc2lu
Y2UgS1ZNIHVzZXMgR1VQIHRvIGdldCB0aGUgcGFnZSkuDQo+ID4gDQo+ID4gVGhhdCdzIHRydWUu
IEFjdHVhbGx5IGV2ZW4gdHJ1ZSBmb3IgcmVzdHJpY3RlZG1lbSBjYXNlLCBtb3N0IGxpa2VseSB3
ZQ0KPiA+IHdpbGwgc3RpbGwgbmVlZCB0aGUga3ZtX3JlbGVhc2VfcGZuX2NsZWFuKCkgZm9yIEtW
TSBnZW5lcmljIGNvZGUuIE9uIG9uZQ0KPiA+IHNpZGUsIG90aGVyIHJlc3RyaWN0ZWRtZW0gdXNl
cnMgbGlrZSBwS1ZNIG1heSBub3QgcmVxdWlyZSBwYWdlIHBpbm5pbmcNCj4gPiBhdCBhbGwuIE9u
IHRoZSBvdGhlciBzaWRlLCBzZWUgYmVsb3cuDQo+ID4gDQo+ID4gPiANCj4gPiA+IFNvIHdoYXQg
d2UgYXJlIGV4cGVjdGluZyBpczogZm9yIEtWTSBpZiB0aGUgcGFnZSBjb21lcyBmcm9tIHJlc3Ry
aWN0ZWQgbWVtLCB0aGVuDQo+ID4gPiBLVk0gY2Fubm90IGRlY3JlYXNlIHRoZSByZWZjb3VudCwg
b3RoZXJ3aXNlIGZvciBub3JtYWwgcGFnZSB2aWEgR1VQIEtWTSBzaG91bGQuDQo+IA0KPiBObywg
cmVxdWlyaW5nIHRoZSB1c2VyIChLVk0pIHRvIGd1YXJkIGFnYWluc3QgbGFjayBvZiBzdXBwb3J0
IGZvciBwYWdlIG1pZ3JhdGlvbg0KPiBpbiByZXN0cmljdGVkIG1lbSBpcyBhIHRlcnJpYmxlIEFQ
SS4gIEl0J3MgdG90YWxseSBmaW5lIGZvciByZXN0cmljdGVkIG1lbSB0byBub3QNCj4gc3VwcG9y
dCBwYWdlIG1pZ3JhdGlvbiB1bnRpbCB0aGVyZSdzIGEgdXNlIGNhc2UsIGJ1dCBwdW50aW5nIHRo
ZSBwcm9ibGVtIHRvIEtWTQ0KPiBpcyBub3QgYWNjZXB0YWJsZS4gIFJlc3RyaWN0ZWQgbWVtIGl0
c2VsZiBkb2Vzbid0IHlldCBzdXBwb3J0IHBhZ2UgbWlncmF0aW9uLA0KPiBlLmcuIGV4cGxvc2lv
bnMgd291bGQgb2NjdXIgZXZlbiBpZiBLVk0gd2FudGVkIHRvIGFsbG93IG1pZ3JhdGlvbiBzaW5j
ZSB0aGVyZSBpcw0KPiBubyBub3RpZmljYXRpb24gdG8gaW52YWxpZGF0ZSBleGlzdGluZyBtYXBw
aW5ncy4NCj4gDQo+IA0KDQpZZXMgdG90YWxseSBhZ3JlZSAoSSBhbHNvIHJlcGxpZWQgc2VwYXJh
dGVseSkuDQo=
