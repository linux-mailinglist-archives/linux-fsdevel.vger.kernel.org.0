Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0375D64C0F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 00:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiLMXwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 18:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiLMXvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:51:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F15F66;
        Tue, 13 Dec 2022 15:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670975508; x=1702511508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BDZRtswbTyTAIg3E/7a9GhKawSilwdbGW/jDlDC3/6g=;
  b=P50FQ6Pdg4iLLRVdJYUlvfpRmqYsRZFz+eFuidC2MdGJ0EhM8j9h6obG
   SHYbix3Og/ARrR4lqAP4wD8vWt2S0CGoR3q8/4dL/YIeP4QGchyu8s0+/
   7wsRmGJoHXJOen5SFAau0gLqmSFYBQCTEPSiQGrKT8E/z3kdpHvAxR2hk
   k7N8iBA+vFYtimfjYZP+KKNsZQqXj84zKUaPjLdd5Ynt3XqdltQODmHgH
   R7nwKU+hS6OxBFeCOCAFehsH9m2Nrb7yvjQQwZpFEq0jCvu6b4GvzqNzS
   ZfIw5WXdbAFW/vSkoEERizQXii+CngLPdzQtpiqjmp3VwwtRgx6W5OGgi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="318308362"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="318308362"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:51:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="737547520"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="737547520"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2022 15:51:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 15:51:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 15:51:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 15:51:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 15:51:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAm2zwkJ0BLcmQP6wRQaUrS4H+DNe0k7CzsQog9DZmKULUWfwXJXJYchawo0jIp/hJ6g5Vt83N/5jEJ14VIg1H8OD7euN9G38uzWpZfAooXV1dls0uIOF5bVta4ox11hhgxCEjCirD4eeH5jUzEnlcQMH9e0GVGV+iBhZZhc7GJktk8+XATjARrbWjbAYq6bEFWFWEL52kBWBBdRCVxayYYdezc0/pd0ZNFFPXLnDW4pkjwXAMDo5ZoUGrc7GIOc4pmB5SMGkAUi+CtGrZ317Sa/O5Y4oK7gct0+Y4W7O4+HJuXpCcF24FrvH0XhtGOH7BUVUJcpuOVcHXZvHpfLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDZRtswbTyTAIg3E/7a9GhKawSilwdbGW/jDlDC3/6g=;
 b=CxZNY9XxVjejgHeeNLh0Y+43W/PHUevqQUsaichgEPDyIx1I+1F62AoMlhp95bZFIKUMmj8CHU2mdh3nWlxzip+Bwhu/10u/Gv3zGdELq2ECfaXGtSa6XCLzjKIbhx5EmBp46+0OzDa/E/euoaEzR33YNLVL2OBxxheDpW4H+oewliWiRPh8Ry+qry8xYEIbIJfji5hPN4jxr0lMyBiR8KanWPNUoQFQkQAHhqk7iWbjJcISLMUvk9gfjQFvDA0vz0XOnC8OL6ESy62D4JH+vXh48Unra6vO2c4Vh8SWNrINUoeSWhx/gWNQIQsq0as5ig8w1hsHgH7GoF3m5UJx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 23:51:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 23:51:26 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "tabba@google.com" <tabba@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "qperret@google.com" <qperret@google.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [PATCH v10 6/9] KVM: Unmap existing mappings when change the
 memory attributes
Thread-Topic: [PATCH v10 6/9] KVM: Unmap existing mappings when change the
 memory attributes
Thread-Index: AQHZBhYXb/slawlr2EmphLwcHYc4dK5sj3EA
Date:   Tue, 13 Dec 2022 23:51:25 +0000
Message-ID: <0889bab999cbb464e63490bdb5b3c68c07791979.camel@intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
         <20221202061347.1070246-7-chao.p.peng@linux.intel.com>
In-Reply-To: <20221202061347.1070246-7-chao.p.peng@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB6445:EE_
x-ms-office365-filtering-correlation-id: f3cd78a9-63e0-4415-98c5-08dadd64f247
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GHUTFx7fnx4vsNP/v8Bx95OSoCKxR98vTMFYZzLKujAWT2/HfLhFXnKuF964SqA+JXi8GhlWzyYQdDKykVraKIFuHOC/mb+vog5orQlKaIFlBtnw6GNPyZcPvWvWEo6i39brmbYy6Qx1RCJ0hD3qTHlr5yjMYWC4/+Nm7GjSyPZ1V0+sPG2MyqZQlwHFLG82w1LUxLw8L0FLbwn+QEtSZtNAR+E/p7FF5sYMp3kwrxCcghtrPyqJGe8+L1GGTjmdU+v2JmtF++dvx8mFb8MOdXZgBuXEAdNtuqkqtMVcefgFg1VCkI93nYZPCbFR8eV0LYbOPo6TmKJl4UPi9JMuDAgmGt9ec5KGVkgVuTPpqooQh6HARaa8l8FTqS6rv8eSmqsg+nx0+JhbJMpqiKj1vthtNHvsnzIwA0TOjbs6Ezb/XtVhBUYOf77AapZS6ZhVeUl6nR2Ls0xLZsVmRSVpTHxnjHFliOfT1j7aj3MywlHR2coKmX57ri1GhHGvfaeQb/ZBnp9qJGSZfe6rYwrOEpAicsMMyQAXgPY/g3wThGk4o3yxqq+h16KqZXBNi/lnWnMu/nkk0hWT6/xQ/Zx9R5kC38SgxIoYK3sRXycd2uTHgQ0g4jjXZsb2+Y0QXaH8dkddgiap1JVv20mZxKfcxZIaVSFu08CxyzbJKxuxbOCgRagj8Kbyq2rQqKzKNy23ge8pVrTRlWfc/RPk5+liA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(71200400001)(6486002)(7416002)(8936002)(558084003)(86362001)(2906002)(38070700005)(38100700002)(122000001)(5660300002)(76116006)(4326008)(6506007)(41300700001)(8676002)(186003)(6512007)(26005)(91956017)(66476007)(66556008)(110136005)(66946007)(66446008)(2616005)(82960400001)(478600001)(7406005)(64756008)(316002)(54906003)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VENqdXU0ZFIrRHZTempjdldWNVY2MjMrUXFZV2R0S3VKY0c3TmduYjQ4aDlJ?=
 =?utf-8?B?OEtoNjdFM1hHQlhHcytLK2RNTlhFWTVMRnpQaUU0dVU4OEVwb3NyZ2VPYTBj?=
 =?utf-8?B?RndFZFBLME16UFFkVnk3RVFtcnk5amJBcVVHbDIrTTZzdWtjSnQ0WTVkZEFt?=
 =?utf-8?B?K0pFeS85bmlHaGNyUTgvVXdQRkFLMFI5blRlQms5S3psaVNUNXRVRGRxY3ZH?=
 =?utf-8?B?S1dSdksxeUR1cVNZNWRsY1ljaDZhbE4rTFpoelNtc1N1K01MOHgxblBaUlB0?=
 =?utf-8?B?SzBHTFhRazBwd01SREN5M0NkWjBZVHF3aGY3Snp4TFlzRll4cU9BaVlNVlAw?=
 =?utf-8?B?ZUNBK3JLM2xuUmp4dzlYajRPWDhuaENKVSsyRnpTWExpSnRPL0I1RjNmY2Fs?=
 =?utf-8?B?ejAzTkJJR1ZBRnNuSm9PcjloanNRMnpVTEdtNkthNHNoNFZNMlZGRnZBQWJ6?=
 =?utf-8?B?OG40d3JtanhKMUJ0ektDcHl5RitRR0FkVkdibWtJOWVkdTZxWnhmNnJ3ZTgv?=
 =?utf-8?B?RGprazR0SnJKbnZScUFGakxXRXBpMFlrT1Y4ekdEeHlNTTI1Y3JkUDFqSVdE?=
 =?utf-8?B?SmV1cFBBV1JpNUdsNXhWYkR2Y3pXa3lQZFd5aXphTjJqdHI2aVJFYncvYnR3?=
 =?utf-8?B?V3gvdUZheEUwK1p5dEtqL1A5UzBCYU9EWWFZd0U4QnZPWFZKYS9KUDdtTlBZ?=
 =?utf-8?B?R3pLZnF1WVNtdU9CcHhxZUJ4SXI2Q1FLTCtHQS95bERwSWloZ3hCV1dSR2NQ?=
 =?utf-8?B?VGdFT2J5UlVZV0xsUkFCc3BwQXMrcytVYkVzbTE0R3Fua29rRzZJTE44RHV0?=
 =?utf-8?B?eitwanBETzhIcEl6MzBzKzZXK2lKdzkzS3FIeTJQY1U5S29Ma3JITkxMOExm?=
 =?utf-8?B?SnlXcGQ5aFo3M2RyK0F2Wmg0MkF4MDNDVDFoMlI4allZSGZwL09LOUUxUVUr?=
 =?utf-8?B?MkhHTHJqblNBZVdYZDN1ZmR4My9mYVVTTndHeXp3b1hjRUpsMjNWZjIzK1lR?=
 =?utf-8?B?WjRabkI2YkJJOEMyOEhjU2owUEprT083R1huaUtCNWlOZ3o1NFZPZHo5K1pz?=
 =?utf-8?B?YXFONUR1cHErNUVjMi8ySkRoMUtHSUI2SFlHdGNvVW0wVHJBU3d4aUxjRVBP?=
 =?utf-8?B?REQ5MlNaaE9uc3RPR1FqWmNsU0lqVE9LUlQvU1pOWVFOb2JnbGpDcllCZnpp?=
 =?utf-8?B?cmpCeEtELzVYejhVTHRudFVvVnl6bHljeStlSCt1dFdLL2NNTk5YOUlaTkF0?=
 =?utf-8?B?b1Fpek16QW5Qb3ViaitrNDB0b1VwbHliWExFcHRuSFZLQ3dHL096eElZcUdk?=
 =?utf-8?B?N081Sklya0trUDhzcU9veE9Ic0xGY1VpTTNOZVJYVzhOZmhWNXYrQTZqcnpv?=
 =?utf-8?B?UEx5R3VuMzB5d0FzL2lNZ2ZIRHVHdkNkdlg0dFBsZmFrV2FkcjZsakdGcGdE?=
 =?utf-8?B?MnVQOTVDZ3V4Nm8va25HcEg4aGwwN0NnK2JlSjcrenFCM1Y3dlo0SG9DZ2dN?=
 =?utf-8?B?THkvRjNMRWY1akNuWW1xRmd3Wk5HUUp6d0kvdEF0Q241cU1GZHIvNTdVMitm?=
 =?utf-8?B?SXUxQzZTSlJlQ1MwcS9tTFVxNy9WRzBud3NqNy9CeWkySXp5Q2U5aWl2NURx?=
 =?utf-8?B?SWpld3RMa21ZdTZJTThCQTNkNTU5dzhlc2ZQUHNWc2xjS2Ryd2taMkcxd0o2?=
 =?utf-8?B?Z2hsZ1RxWnpLM0VGaHFaS3M2OEVVK2FFUG5aSnQxQVB5aVBmWjBMVnREREI3?=
 =?utf-8?B?aStzSFNSdzJvbkRyUUZhMlQ5cVZJY2R1alRGYm1hSnVISGVERDR6MkR6SDlW?=
 =?utf-8?B?Wm1hUFR3OEdwc2swYVQxRTNtUWpZRUxpKzljejRMTUZhVE5WSlZmYStCWmlx?=
 =?utf-8?B?WkcxSHI2c2NTRFhPZFBaN2I4VFpqN05oUWYzSEdSQ0JLdzZYK29SMFNrckM4?=
 =?utf-8?B?TnExNDArbHpHdzR3b0kzKzQvcmxKSlgydjdJRmpxMjlIbzRnQnMwVjRUekgy?=
 =?utf-8?B?M1pwU0dHbjltVlB5Z04xcWJNNkw0eGM5L29NQ2l3RWRFU2M5TTRNb2Fqd2c0?=
 =?utf-8?B?SkwzNE51dVF5ZEFxNENhWEplMFFrYXE3anB4NThGTkNmQ2RiNVZtTlRlalpy?=
 =?utf-8?B?aEl2NjkwcjlOYndKUldoWVRibmFHQ08wR0UreFlYU1h0cUJzeTJmQ1o4S3B3?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <128FAB7E029EB449B972E9332BCF8663@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cd78a9-63e0-4415-98c5-08dadd64f247
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 23:51:25.7124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmUIt3QZKtJk5TD2UStFT4LxB+OkF+ZLrsM+6F/2bO88Q3/oM92cdgm115xl7As1Zn6kmXTQ6gULljU16G3mww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTAyIGF0IDE0OjEzICswODAwLCBDaGFvIFBlbmcgd3JvdGU6DQo+IMKg
DQo+IC0JLyogZmxhZ3MgaXMgY3VycmVudGx5IG5vdCB1c2VkLiAqLw0KPiArCS8qICdmbGFncycg
aXMgY3VycmVudGx5IG5vdCB1c2VkLiAqLw0KPiDCoAlpZiAoYXR0cnMtPmZsYWdzKQ0KPiDCoAkJ
cmV0dXJuIC1FSU5WQUw7DQoNClVuaW50ZW5kZWQgY29kZSBjaGFuZ2UuDQo=
