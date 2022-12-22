Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06E7653A22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 01:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiLVAhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 19:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVAha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:37:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966381A051;
        Wed, 21 Dec 2022 16:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671669448; x=1703205448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l696ckwBHmv15Jh/iyydo8jsnhR0M+jXnkTHqRgCWzA=;
  b=QjKQRWmin1k/7ASv0sxiaqwzy0d8utHt7XEpNfiLKT7yYMynz347hhDl
   jb75Bi53TOY1sOjB/ew4nctAe5BrWppTWB/IvYx83hkHCfQEFYCN6DwQN
   glVmEmKHAKU4pYTXhhuNN54PoDuP8fz0zBvAkHcQFY+QyO83TVVnQ69IO
   r4NRhL6ckeBQ911ukOFGXw6W0joq/5t6jf6r43ie0cJYXQqQy6wYKVVAD
   Oi9YVs06AQa4unS2fEkY7lW++o2b/XV4WHy5bSJZFV7BwS+eDnGDZO1tq
   4AshJj7LMjbLe2PV4mWM7Qb3dgZBOaPXlqYqrdwpMFpjqqONqDt4u4iqG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="406249166"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="406249166"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 16:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="825797672"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="825797672"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2022 16:37:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 16:37:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 16:37:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 16:37:26 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 16:37:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGUGwFthMVKUMO2dsBzSZLUcThFwJGofYyTZ12moRNGJXj2hpZTR/ANf4LMymDaE2ubeFrtNutR+PMC5LBZ7Bimafz4g8/PChPh3QcUI5IKXUz1h7iqsH8/GHjNbAkAAYbp60rgVl+DZIdFih99zxKJeqfP6V9+0sZlk/KkNUmJV0HsoDKZ1JdxWbWY3aHebaeq1CXKH3Qayj+w4JEtfOKSqGyiWh/rYBoOZZRSL6qM6hK4piv+LoTOJa3jocEMi/H9c7MR5YDFSVZXstq7ByCikBW0+QdOv+BHo36isSuWjV/nr/WMCWpVEROGOtNJSvpfoPdU2fsC34GWAKV2AEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l696ckwBHmv15Jh/iyydo8jsnhR0M+jXnkTHqRgCWzA=;
 b=NLm/fzrAO2fpL93g/W/KqKEngC3z9nOnYFflMP5aLDhzYYwBAQKYL/9q0q99vnpA7U3TvQhu5hPlxKVSLKMa1WgheWqWreY3dnHG+0vyG11OHFnkfW2q0CVdpqzJD8jWiPLcWVk3+FlFNib9xSrtwOWGEx2NAhL4okqkuchqu7L2h7NDqBg6mK45+5g+K579o7xmjRpYNuzVVP+XBXdWUSk94sjvFQhfiMPdVOERgsjJgA5zcMlP43AjsDRjVLW/3Y/48bw9nYl7BW3MiLj8Oit7FyCTHjX5vKBOywZk5zb61xSYAVW5A0Sp7tRVMtiXtxSrIDRnryVDbPUzNy3xqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 22 Dec
 2022 00:37:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e%8]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 00:37:19 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>
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
        "Christopherson,, Sean" <seanjc@google.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
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
Thread-Index: AQHZBhXuq53UEB1w4kqtU0OzCkPOIq5sjtQAgAhi5ICAAA9XAIABemYAgAATugCAAefUgIAAt+UA
Date:   Thu, 22 Dec 2022 00:37:19 +0000
Message-ID: <b898e28d7fd7182e5d069646f84b650c748d9ca2.camel@intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
         <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
         <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
         <20221219075313.GB1691829@chaop.bj.intel.com>
         <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
         <20221220072228.GA1724933@chaop.bj.intel.com>
         <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
         <20221221133905.GA1766136@chaop.bj.intel.com>
In-Reply-To: <20221221133905.GA1766136@chaop.bj.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB7091:EE_
x-ms-office365-filtering-correlation-id: ea763d79-4423-4978-4a90-08dae3b4aeea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bvbFyar3jXDmk1MGwX2ZYkKAbDDAC3IUaYAiH/8J71r/OamqJKaFNyVqcQeuhOQN0tECAbKMYQrF43kug9qC1YrTjMhRdf+4ewRcrVdAYZdnYzdwJG6Uob4Mwx5L7ShFXrRhLHx29Xffmuunk4WbKGM81eCl+bN22nKv3tSB7woRtIlKk+udjBnwtn5XwRfcbHl+qqMYjH8z+dTbC0h6OcJhSCJdvPeyh0LuxopQTu1EsXUX0skLzTzV8E7QM9xHNUWz0WUsk7nO86U6UN1oTB5n6Gh/qzTjyB4jE31JQHbNQO/SSx6cQLsxxS4mrO69acbl4lbatC4bkVdda64LTVSZ0LHPcvZHpUBPyEfFqbZ2VAzNKjd6sSp6fr/62KhpOWvC7hycy4/++IvXXNIlkZHGp8I/crv6iwqiCWIHYZv5Cekbkv3hX8fCDKEoJM3Le2Jx0z/b4xjOm1mkjB5v7LjrL9I//4IHkxGqlve1iprMG1AowxRE8sFdn0NTxBa8K5ibX7WPc/Vd5C03sYCKz/Jp5DHGoyOc5rWC7bjLxJZ5yPCx02SUIOxZclkl3d+0aZnLqQsfF+r0aYpSAwbLlmPmzJurhWv5J3VnXGtde3Xb8fePXtk2ABZR5+1EBT0w22k7Q+e0yO3Azfc3F9d5ijZFbN+MzRvpzj3Fc5cVTrXRa8FSI3C9CJu+SGeq6m9PhHq/hiUd6/9twJeO+P4qSsh/TBfSpe31FdXJaPiBQ9PnN81DGObWj+FcXPkH68tyCfAIUZyI6C91O3fiaUqq8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(6916009)(186003)(54906003)(71200400001)(36756003)(38070700005)(83380400001)(316002)(91956017)(2906002)(4001150100001)(66946007)(86362001)(2616005)(478600001)(26005)(966005)(6512007)(6486002)(6506007)(66556008)(82960400001)(41300700001)(38100700002)(7416002)(122000001)(64756008)(66446008)(76116006)(66476007)(4326008)(8676002)(5660300002)(7406005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW9HL3c2amtWbVBpY1lMM0dHaWJodkRBeHM5Zlh5b0FJRWJmNVhLNXhZUi9S?=
 =?utf-8?B?OFZrWndLblpNQW16bEFXbC9LU0FiSTdrZTZidGlUVFpEYnk2K0tqeWszeUMz?=
 =?utf-8?B?WGxlWnRpNHQwU0xLVlp5L0xoQWpUcE9kaDVSN2w2VlExbnc0Rm10ZFFCSEVq?=
 =?utf-8?B?YU1xOWo3ajV2aUZCU2NqRXYyYU8yeVVUellySWc5MmlPb1VtWmNwWFJMWTVD?=
 =?utf-8?B?bGpRc0doY3VZalFDV0txMyt1aGR3VTduMHRvNngzd2VuZWw4VWFIYWxKTko0?=
 =?utf-8?B?WnFUOXFOMG1yZW1FcDdpb05UT3hlTzUxQk81YnRnaHFtN3NSZWdHNXZndzhS?=
 =?utf-8?B?T2dpQyt4UUpiY1VabVN4UEFmOFExS3p6cTlLMDFHM0EyMnpWTEpoQkZaRUZQ?=
 =?utf-8?B?UTNqRFZDd2VEVGhXK1YrdyttdzJRT0xzVkgwQllaT0xpWTJpN0NpY0lqYjhw?=
 =?utf-8?B?Yy9LZVpvS0xtWklock5vazR6aEVYcDJtTk9LL3dPb1BGQW43anBONk9YMlVo?=
 =?utf-8?B?ZFBWYm5WWC9iL3lrSVpWUERKbUl4TTVuZkpPT3BpcDI3VFAyejMzbEhXbzJw?=
 =?utf-8?B?UVZZclVSU1drWTR3ZDJqL29OTG1BdFVYOTdUZjFCNVpNSkFxVUsxckluTzZH?=
 =?utf-8?B?dDhjM2FKakN2R3FNaGlwTXc5Wk1IVHEyeThQbmtmaUUvekZoTGVONjgrdWMr?=
 =?utf-8?B?dEJZSDRXVURrc1BZZExXRVlzWVlxK3hzT2xDVk91aGJVcHZGQUl1bzhGV0Fu?=
 =?utf-8?B?eFF6MGtSdkwrR0grVHRDcUFNTUg4Mzk1YVptbitzR2ZsV2ZHVkZTSFVXa1Jn?=
 =?utf-8?B?RWRkRUNocFlENUFhNXR6YlpCSW1tdkE2UlAxdDR6eHRLaVVuNTgwb1FPOTh3?=
 =?utf-8?B?S3cvbFQxZlFidlJiMzE2LytJUDAwYUVYbEFZODRORTBKcExBZkN0ZUorbE9F?=
 =?utf-8?B?OGkxVDBmMXV5YzBzdXRBalN5eWJuQ3dVbnU5M1krZmYyUEVLaXA5RHNnR1ZS?=
 =?utf-8?B?N0ZIdHhtUTl2a2JRcWJVMHVOR2hXZDZTQ01UZkorOWFqSDlUZ0FEdUYzV3Zi?=
 =?utf-8?B?TzBnekNBb01KVDBGRzlNTm4zUTNSRTdHZGVld01FZTdmMEdSWjBMcGFPZEtp?=
 =?utf-8?B?ZkNsNlVaR0w3NzNtalNTdSt6RUFxTDgwNlIzUHNMTUo3aUtVc2w2b2RJL2do?=
 =?utf-8?B?a293WG9PRU1zZW1WdUJMeWExV1cvNjFnQU10eVVsVThzL2NrWW5BOE0vZDBP?=
 =?utf-8?B?bzU3VENRU2hielp2b3FPOTBmTVJZdlZqUUV2WTVDYUhkcXB6M2llcklkU09H?=
 =?utf-8?B?YUp6OUFWWTdNVnA3QWVUanVIaGhYbDFHRXNlRUtCQ2pLWVVwRWNJV056QTBB?=
 =?utf-8?B?L1lXejE3d3N6eGhvcEl6dnRNTDlWM1QzMFJSTW1CWk1MajcydEl6OVFoeXFh?=
 =?utf-8?B?Sk9rR0o3eEg1NHhxR05DamFRQ2JtOGVKUzBwOE1rWkdUN0w4U0hxbG9KcGlU?=
 =?utf-8?B?RkNHZVExK21uaEluMXlVaE8vWHAyd1pYYWM1bUVmYU54YjNnUzIvOWJRZHha?=
 =?utf-8?B?S0ZkdWFhWWd3cGMyZWVIc3RNSVQ4OWZIU1pXVTlxYmNtWmJ2ekJIbURnWHBP?=
 =?utf-8?B?UFkxUU5tTlVyem5FdFdIL0lRak9HSzB6VFJ0RyswSS8wVzhiYlBFdUVJK1NK?=
 =?utf-8?B?SzlQTUw1YnI1dXNJUWphNUY2STZLWmc1ZktPRWNQbDM0dDR3MHZXQkdCeXhV?=
 =?utf-8?B?VWRUaGRwUkM4UkJKWnBTVkxEZ1Q1TllNdDczQmdQS2U3RnFNc045cGo5OW9T?=
 =?utf-8?B?T1R3OVFmaDJKemxpWnVUeUxlM2Npa09VVUU2KzNWakwrcURDVm1oMmVETHJJ?=
 =?utf-8?B?WEZ6ZHJNQjlGY2VLUkVLcTF1c25va3kvejBCUDkreDl1S1dPNjNXSXRJdDY2?=
 =?utf-8?B?TDNTWFpheUN5ZWNheUhYbTFKanlNSjFtdW1wREhJZnRDRS9nWldJcXV5Z1F2?=
 =?utf-8?B?Q3Zua3c5c0hhMkZlSjJTUzhDSUdmeElqNXhRNWEvMkd4OFRHRVlGbUtXTTVo?=
 =?utf-8?B?VFJzR0J1WG5tTVQzVHptWWtaMlN6b25NaWpGNjF4UFo4Wk1KVkV2NjEvcG03?=
 =?utf-8?B?YUpVUVk0eWFNbFJ4eGVDVmpDYmhGaEZYWXB6b1N5NnhWUkFBaVV1MjdrVkZ2?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E5718C0997025419B413F3864A76E46@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea763d79-4423-4978-4a90-08dae3b4aeea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 00:37:19.4086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sOnUOtWUw8Ztct0wnUGu/9Mj5GjnRcrDr9apg35vimJ0S3MrAxFzCy4Bgeiguw29fpHeYHiy3KpP8nQYm9NMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTIxIGF0IDIxOjM5ICswODAwLCBDaGFvIFBlbmcgd3JvdGU6DQo+ID4g
T24gVHVlLCBEZWMgMjAsIDIwMjIgYXQgMDg6MzM6MDVBTSArMDAwMCwgSHVhbmcsIEthaSB3cm90
ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIyLTEyLTIwIGF0IDE1OjIyICswODAwLCBDaGFvIFBlbmcg
d3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBNb24sIERlYyAxOSwgMjAyMiBhdCAwODo0ODoxMEFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgMjAyMi0xMi0x
OSBhdCAxNTo1MyArMDgwMCwgQ2hhbyBQZW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBbLi4uXQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICsJLyoNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArCSAqIFRoZXNlIHBhZ2Vz
IGFyZSBjdXJyZW50bHkgdW5tb3ZhYmxlIHNvIGRvbid0IHBsYWNlIHRoZW0gaW50bw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IG1vdmFibGUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiArCSAqIHBhZ2VibG9ja3MgKGUuZy4gQ01BIGFuZCBaT05FX01PVkFCTEUpLg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKwlt
YXBwaW5nID0gbWVtZmQtPmZfbWFwcGluZzsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAr
CW1hcHBpbmdfc2V0X3VuZXZpY3RhYmxlKG1hcHBpbmcpOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICsJbWFwcGluZ19zZXRfZ2ZwX21hc2sobWFwcGluZywNCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiArCQkJwqDCoMKgwqAgbWFwcGluZ19nZnBfbWFzayhtYXBwaW5nKSAmIH5fX0dG
UF9NT1ZBQkxFKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gQnV0LCBJSVVDIHJlbW92aW5nIF9fR0ZQX01PVkFCTEUgZmxhZyBoZXJlIG9ubHkgbWFr
ZXMgcGFnZSBhbGxvY2F0aW9uIGZyb20NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG5vbi0NCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IG1vdmFibGUgem9uZXMsIGJ1dCBkb2Vzbid0IG5lY2Vzc2Fy
aWx5IHByZXZlbnQgcGFnZSBmcm9tIGJlaW5nIG1pZ3JhdGVkLsKgIE15DQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBmaXJzdCBnbGFuY2UgaXMgeW91IG5lZWQgdG8gaW1wbGVtZW50IGVpdGhlciBh
X29wcy0+bWlncmF0ZV9mb2xpbygpIG9yIGp1c3QNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGdl
dF9wYWdlKCkgYWZ0ZXIgZmF1bHRpbmcgaW4gdGhlIHBhZ2UgdG8gcHJldmVudC4NCj4gPiA+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoZSBjdXJyZW50IGFwaSByZXN0cmlj
dGVkbWVtX2dldF9wYWdlKCkgYWxyZWFkeSBkb2VzIHRoaXMsIGFmdGVyIHRoZQ0KPiA+ID4gPiA+
ID4gPiA+ID4gPiBjYWxsZXIgY2FsbGluZyBpdCwgaXQgaG9sZHMgYSByZWZlcmVuY2UgdG8gdGhl
IHBhZ2UuIFRoZSBjYWxsZXIgdGhlbg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBkZWNpZGVzIHdoZW4g
dG8gY2FsbCBwdXRfcGFnZSgpIGFwcHJvcHJpYXRlbHkuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+ID4gSSB0cmllZCB0byBkaWcgc29tZSBoaXN0b3J5LiBQZXJoYXBzIEkgYW0gbWlz
c2luZyBzb21ldGhpbmcsIGJ1dCBpdCBzZWVtcyBLaXJpbGwNCj4gPiA+ID4gPiA+ID4gPiBzYWlk
IGluIHY5IHRoYXQgdGhpcyBjb2RlIGRvZXNuJ3QgcHJldmVudCBwYWdlIG1pZ3JhdGlvbiwgYW5k
IHdlIG5lZWQgdG8NCj4gPiA+ID4gPiA+ID4gPiBpbmNyZWFzZSBwYWdlIHJlZmNvdW50IGluIHJl
c3RyaWN0ZWRtZW1fZ2V0X3BhZ2UoKToNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIyMTEyOTExMjEzOS51c3A2ZHFo
YmloNDdxcGpsQGJveC5zaHV0ZW1vdi5uYW1lLw0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiA+IEJ1dCBsb29raW5nIGF0IHRoaXMgc2VyaWVzIGl0IHNlZW1zIHJlc3RyaWN0ZWRtZW1f
Z2V0X3BhZ2UoKSBpbiB0aGlzIHYxMCBpcw0KPiA+ID4gPiA+ID4gPiA+IGlkZW50aWNhbCB0byB0
aGUgb25lIGluIHY5IChleGNlcHQgdjEwIHVzZXMgJ2ZvbGlvJyBpbnN0ZWFkIG9mICdwYWdlJyk/
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IHJlc3RyaWN0ZWRtZW1fZ2V0X3BhZ2UoKSBpbmNy
ZWFzZXMgcGFnZSByZWZjb3VudCBzZXZlcmFsIHZlcnNpb25zIGFnbyBzbw0KPiA+ID4gPiA+ID4g
bm8gY2hhbmdlIGluIHYxMCBpcyBuZWVkZWQuIFlvdSBwcm9iYWJseSBtaXNzZWQgbXkgcmVwbHk6
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW1tLzIwMjIxMTI5MTM1ODQ0LkdBOTAyMTY0QGNoYW9wLmJqLmludGVsLmNvbS8NCj4gPiA+ID4g
DQo+ID4gPiA+IEJ1dCBmb3Igbm9uLXJlc3RyaWN0ZWQtbWVtIGNhc2UsIGl0IGlzIGNvcnJlY3Qg
Zm9yIEtWTSB0byBkZWNyZWFzZSBwYWdlJ3MNCj4gPiA+ID4gcmVmY291bnQgYWZ0ZXIgc2V0dGlu
ZyB1cCBtYXBwaW5nIGluIHRoZSBzZWNvbmRhcnkgbW11LCBvdGhlcndpc2UgdGhlIHBhZ2Ugd2ls
bA0KPiA+ID4gPiBiZSBwaW5uZWQgYnkgS1ZNIGZvciBub3JtYWwgVk0gKHNpbmNlIEtWTSB1c2Vz
IEdVUCB0byBnZXQgdGhlIHBhZ2UpLg0KPiA+IA0KPiA+IFRoYXQncyB0cnVlLiBBY3R1YWxseSBl
dmVuIHRydWUgZm9yIHJlc3RyaWN0ZWRtZW0gY2FzZSwgbW9zdCBsaWtlbHkgd2UNCj4gPiB3aWxs
IHN0aWxsIG5lZWQgdGhlIGt2bV9yZWxlYXNlX3Bmbl9jbGVhbigpIGZvciBLVk0gZ2VuZXJpYyBj
b2RlLiBPbiBvbmUNCj4gPiBzaWRlLCBvdGhlciByZXN0cmljdGVkbWVtIHVzZXJzIGxpa2UgcEtW
TSBtYXkgbm90IHJlcXVpcmUgcGFnZSBwaW5uaW5nDQo+ID4gYXQgYWxsLiBPbiB0aGUgb3RoZXIg
c2lkZSwgc2VlIGJlbG93Lg0KDQpPSy4gQWdyZWVkLg0KDQo+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiBTbyB3aGF0IHdlIGFyZSBleHBlY3RpbmcgaXM6IGZvciBLVk0gaWYgdGhlIHBhZ2UgY29tZXMg
ZnJvbSByZXN0cmljdGVkIG1lbSwgdGhlbg0KPiA+ID4gPiBLVk0gY2Fubm90IGRlY3JlYXNlIHRo
ZSByZWZjb3VudCwgb3RoZXJ3aXNlIGZvciBub3JtYWwgcGFnZSB2aWEgR1VQIEtWTSBzaG91bGQu
DQo+ID4gDQo+ID4gSSBhcmd1ZSB0aGF0IHRoaXMgcGFnZSBwaW5uaW5nIChvciBwYWdlIG1pZ3Jh
dGlvbiBwcmV2ZW50aW9uKSBpcyBub3QNCj4gPiB0aWVkIHRvIHdoZXJlIHRoZSBwYWdlIGNvbWVz
IGZyb20sIGluc3RlYWQgcmVsYXRlZCB0byBob3cgdGhlIHBhZ2Ugd2lsbA0KPiA+IGJlIHVzZWQu
IFdoZXRoZXIgdGhlIHBhZ2UgaXMgcmVzdHJpY3RlZG1lbSBiYWNrZWQgb3IgR1VQKCkgYmFja2Vk
LCBvbmNlDQo+ID4gaXQncyB1c2VkIGJ5IGN1cnJlbnQgdmVyc2lvbiBvZiBURFggdGhlbiB0aGUg
cGFnZSBwaW5uaW5nIGlzIG5lZWRlZC4gU28NCj4gPiBzdWNoIHBhZ2UgbWlncmF0aW9uIHByZXZl
bnRpb24gaXMgcmVhbGx5IFREWCB0aGluZywgZXZlbiBub3QgS1ZNIGdlbmVyaWMNCj4gPiB0aGlu
ZyAodGhhdCdzIHdoeSBJIHRoaW5rIHdlIGRvbid0IG5lZWQgY2hhbmdlIHRoZSBleGlzdGluZyBs
b2dpYyBvZg0KPiA+IGt2bV9yZWxlYXNlX3Bmbl9jbGVhbigpKS7CoA0KPiA+IA0KDQpUaGlzIGVz
c2VudGlhbGx5IGJvaWxzIGRvd24gdG8gd2hvICJvd25zIiBwYWdlIG1pZ3JhdGlvbiBoYW5kbGlu
ZywgYW5kIHNhZGx5LA0KcGFnZSBtaWdyYXRpb24gaXMga2luZGEgIm93bmVkIiBieSB0aGUgY29y
ZS1rZXJuZWwsIGkuZS4gS1ZNIGNhbm5vdCBoYW5kbGUgcGFnZQ0KbWlncmF0aW9uIGJ5IGl0c2Vs
ZiAtLSBpdCdzIGp1c3QgYSBwYXNzaXZlIHJlY2VpdmVyLg0KDQpGb3Igbm9ybWFsIHBhZ2VzLCBw
YWdlIG1pZ3JhdGlvbiBpcyB0b3RhbGx5IGRvbmUgYnkgdGhlIGNvcmUta2VybmVsIChpLmUuIGl0
DQp1bm1hcHMgcGFnZSBmcm9tIFZNQSwgYWxsb2NhdGVzIGEgbmV3IHBhZ2UsIGFuZCB1c2VzIG1p
Z3JhdGVfcGFwZSgpIG9yIGFfb3BzLQ0KPm1pZ3JhdGVfcGFnZSgpIHRvIGFjdHVhbGx5IG1pZ3Jh
dGUgdGhlIHBhZ2UpLg0KDQpJbiB0aGUgc2Vuc2Ugb2YgVERYLCBjb25jZXB0dWFsbHkgaXQgc2hv
dWxkIGJlIGRvbmUgaW4gdGhlIHNhbWUgd2F5LiBUaGUgbW9yZQ0KaW1wb3J0YW50IHRoaW5nIGlz
OiB5ZXMgS1ZNIGNhbiB1c2UgZ2V0X3BhZ2UoKSB0byBwcmV2ZW50IHBhZ2UgbWlncmF0aW9uLCBi
dXQNCndoZW4gS1ZNIHdhbnRzIHRvIHN1cHBvcnQgaXQsIEtWTSBjYW5ub3QganVzdCByZW1vdmUg
Z2V0X3BhZ2UoKSwgYXMgdGhlIGNvcmUtDQprZXJuZWwgd2lsbCBzdGlsbCBqdXN0IGRvIG1pZ3Jh
dGVfcGFnZSgpIHdoaWNoIHdvbid0IHdvcmsgZm9yIFREWCAoZ2l2ZW4NCnJlc3RyaWN0ZWRfbWVt
ZmQgZG9lc24ndCBoYXZlIGFfb3BzLT5taWdyYXRlX3BhZ2UoKSBpbXBsZW1lbnRlZCkuDQoNClNv
IEkgdGhpbmsgdGhlIHJlc3RyaWN0ZWRfbWVtZmQgZmlsZXN5c3RlbSBzaG91bGQgb3duIHBhZ2Ug
bWlncmF0aW9uIGhhbmRsaW5nLA0KKGkuZS4gYnkgaW1wbGVtZW50aW5nIGFfb3BzLT5taWdyYXRl
X3BhZ2UoKSB0byBlaXRoZXIganVzdCByZWplY3QgcGFnZSBtaWdyYXRpb24NCm9yIHNvbWVob3cg
c3VwcG9ydCBpdCkuDQoNClRvIHN1cHBvcnQgcGFnZSBtaWdyYXRpb24sIGl0IG1heSByZXF1aXJl
IEtWTSdzIGhlbHAgaW4gY2FzZSBvZiBURFggKHRoZQ0KVERILk1FTS5QQUdFLlJFTE9DQVRFIFNF
QU1DQUxMIHJlcXVpcmVzICJHUEEiIGFuZCAibGV2ZWwiIG9mIEVQVCBtYXBwaW5nLCB3aGljaA0K
YXJlIG9ubHkgYXZhaWxhYmxlIGluIEtWTSksIGJ1dCB0aGF0IGRvZXNuJ3QgbWFrZSBLVk0gdG8g
b3duIHRoZSBoYW5kbGluZyBvZg0KcGFnZSBtaWdyYXRpb24uDQoNCg0KPiA+IFdvdWxkbid0IGJl
dHRlciB0byBsZXQgVERYIGNvZGUgKG9yIHdobw0KPiA+IHJlcXVpcmVzIHRoYXQpIHRvIGluY3Jl
YXNlL2RlY3JlYXNlIHRoZSByZWZjb3VudCB3aGVuIGl0IHBvcHVsYXRlcy9kcm9wcw0KPiA+IHRo
ZSBzZWN1cmUgRVBUIGVudHJpZXM/IFRoaXMgaXMgZXhhY3RseSB3aGF0IHRoZSBjdXJyZW50IFRE
WCBjb2RlIGRvZXM6DQo+ID4gDQo+ID4gZ2V0X3BhZ2UoKToNCj4gPiBodHRwczovL2dpdGh1Yi5j
b20vaW50ZWwvdGR4L2Jsb2Iva3ZtLXVwc3RyZWFtL2FyY2gveDg2L2t2bS92bXgvdGR4LmMjTDEy
MTcNCj4gPiANCj4gPiBwdXRfcGFnZSgpOg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC90
ZHgvYmxvYi9rdm0tdXBzdHJlYW0vYXJjaC94ODYva3ZtL3ZteC90ZHguYyNMMTMzNA0KPiA+IA0K
DQpBcyBleHBsYWluZWQgYWJvdmUsIEkgdGhpbmsgZG9pbmcgc28gaW4gS1ZNIGlzIHdyb25nOiBp
dCBjYW4gcHJldmVudCBieSB1c2luZw0KZ2V0X3BhZ2UoKSwgYnV0IHlvdSBjYW5ub3Qgc2ltcGx5
IHJlbW92ZSBpdCB0byBzdXBwb3J0IHBhZ2UgbWlncmF0aW9uLg0KDQpTZWFuIGFsc28gc2FpZCBz
aW1pbGFyIHRoaW5nIHdoZW4gcmV2aWV3aW5nIHY4IEtWTSBURFggc2VyaWVzIGFuZCBJIGFsc28g
YWdyZWU6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWXZ1NVBzQW5kRWJXS1RIY0Bn
b29nbGUuY29tLw0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8zMWZlYzFiNDQzOGE2ZDli
YjdmZjcxOWY5NmNhYThiMjNlZDc2NGQ2LmNhbWVsQGludGVsLmNvbS8NCg0K
