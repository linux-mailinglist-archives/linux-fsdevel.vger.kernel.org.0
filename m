Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDC85E6380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiIVNX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIVNX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:23:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C8533A16;
        Thu, 22 Sep 2022 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663853035; x=1695389035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lmAkbfBC9cLFsfIZf8Oh0+jUxspkvacTRZqTuke9CI8=;
  b=WjPrOmKMyjjXmbhpxVNWTCixz3FaF0oFS5VRkferTkyEDLvMoK09gOQG
   65HcZcg7lA/8iK8MPbcPDdcALa3+YtGzvm7JvFrRDQmeDGtz7xS/T0unp
   ftuBe2S3hc32AjeMdtwI/3Fb5BIMU2sKsGT0YTN9zvZsU7aDyJONTI0/b
   JapaoEc6toRjzlkTO32fppErimYCPOmvH8/d7O9LvsKry5qbdWF+BJz7V
   ktPY4WOG98S/JH/KDDjivsipopOqcJUctNCmFN01M5YLTDopGNNBWuKGh
   xMXcsS3X2Dkq5Sh/fMz0bOteSAJ1740O7cIa+TJoniiH45A7rSUX327a8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283347224"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="283347224"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="723660358"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2022 06:23:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 06:23:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 06:23:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 06:23:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 06:23:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIdVArIWdRe83gfcj7EgOJ15cHrI808mOEFibaxvNoL0UxE5iF+1BhXtlGcjULrs1JQeHSIo7FeYX3784wOlU+Eo1wd9M7JYJqbGU3wr/bU1aJOfp90lW2hmfb3J+v/BtC2FdZQCCnHprKScFrNceDRzdmZmgOGED9FiU9ruiyoYsgCUMFFMxMIpwA+4+Mk/GgY4jYgsha8B1YW7rfFX6zewKtmC4hkR+L9cBjxYL5jje1O9cJZuoKYG8+x1O3KUrjkMUh+2xqVomHzTD/b30aFLJ6JC8ex3FItYDHYK/Mv5h11+eTRafZApVfrF77qtMMPCIuD/A2Hk5OyW5HSsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EV88kzipDGLk8m3+7N8I2wNuyPp7aZNaoEsiFKVwIvk=;
 b=BAM74igGU2LsZ5U8SjPjEIVSLr1jO/L7Rw+kNq3CODOA41LKIWpWaVPs7S6cvbNfytJeB/3YHopYlw7DQca8xg8TsZ98cb4WdYYqRBzxQ0i/hOA7BYHIXjhyj3LtIsM6wSKFPoSXJFBIi7bRBCg64k6+tHxBPTuRHiGAHZo1wV9Gr76QgODYOE6gYGn8cUYhjTLsiugN2oeOtc4o9MXsZOdrAdGGpk7+Xup+7NBbMbQUHH86b2x+/tSx7KzOB79jPHxLobYnIfo3wEBwadcWpxz6EFQdxQMbdZC4C3ttp5KvvO/RA9AoyWLHTEG2hEbd7rj6sS+coyFBZtPir6CWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DM4PR11MB5520.namprd11.prod.outlook.com (2603:10b6:5:39f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.19; Thu, 22 Sep 2022 13:23:43 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::817a:fd68:f270:1ea0]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::817a:fd68:f270:1ea0%7]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 13:23:43 +0000
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>
CC:     Chao Peng <chao.p.peng@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "Quentin Perret" <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Will Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Fuad Tabba <tabba@google.com>
Subject: RE: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Thread-Topic: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Thread-Index: AQHYyRA+DGITW09wp06ZhgFK30MXVK3mfdYAgACm74CAA0ZcgIABDdiQ
Date:   Thu, 22 Sep 2022 13:23:42 +0000
Message-ID: <DS0PR11MB63734C0FC6A7FABCAF826620DC4E9@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com>
 <84e81d21-c800-4fd5-ad7c-f20bcdd7508b@www.fastmail.com>
In-Reply-To: <84e81d21-c800-4fd5-ad7c-f20bcdd7508b@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DM4PR11MB5520:EE_
x-ms-office365-filtering-correlation-id: 963dcb76-ac18-47f3-a5d4-08da9c9dab95
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHYZk43SqfWZ4yq2uPUuFie7dUX88sPC75tKe881sPhEFKk6txJ/DM/jVV7dpOkk5eFv1tT6kBM4nsY05mJTCqRpVsC80CnybK+vPwPrIuwsmm4M+MSba8OggTKrqgcpr1+H6ja6hF47FsTN5ztiipYwRsBxKKlijED5F5vgom1VpqbSPo6RNPJ1yI5EVhQR4I+rwJL+upvOV6mVjy7+GJxalH21Vn4oLmfvWC8EHfnW/zylF9WSuVZb+9FSzVCsXOQkX61k+n4dzWWkgSu5NGvh+f1pgZ9iEYVP6WIxr+wQmPJEa86C9z/0ia9zHYpKP3Nd58to1+ydDRlvXSykS84bfZvyQ6jwzDkuLF15Bn0Np+0+Evn/N6JRUyYO0Q+Q8Oos/CaQP/p79oWQ16eDiuKLOuk/zNtB3Qp+Xb6w6Y0RBlapX9hK5dPVzmd5K5r46Q6aQIwIpxOvQYoW8Lehj4XqJMjeV8F6P5Fx5Hkz8hHb3kF8iosGOKZLqziPgwIg+9f6V8IZH6bUCflkwDEgoDy28uSgTU2jtx7Lf7869NA3qH5rurYSuVg9bsGeA98iquUFbm3wgJisP/SJDmW+CCxUCvu0g1Mku1UmJmynpbgeynkKshsKsw8Gk8FLOPEky/2d6pr8ZT5AFo2Lx7h0kceyrb1Ka85bzTMeP/avQxcfpsLt48xAqwdA0Uid65jye96mG4PlBtllGDb7hgGQtMjCz8Ncpej6kDas70O269dGFijTgV7cEDsHSF062fqavaI2IZkWkJVIeDYielvFSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(66899012)(9686003)(26005)(316002)(52536014)(76116006)(4326008)(8676002)(33656002)(66446008)(64756008)(66476007)(66556008)(66574015)(66946007)(110136005)(54906003)(2906002)(71200400001)(86362001)(7406005)(41300700001)(5660300002)(8936002)(7416002)(38070700005)(478600001)(6506007)(7696005)(122000001)(82960400001)(38100700002)(53546011)(55016003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NpVmU2cw1KTvNZU93PDsRrZX5Z1sbA/sl7eQ+TV2CuxgOeITWk6moKVG/+nw?=
 =?us-ascii?Q?VVTmkns8ydZdFkuB7Cx6hhqtYskwkT2XrY5bUVLty08QnOnQq+m1QOrAPcQS?=
 =?us-ascii?Q?Q2s1fTcam+aElPDqAjnTyd8Ryop8pXK2tk8Mp0Pllam3gUdZr3KCSbsMQdQv?=
 =?us-ascii?Q?Z8mz0el1wpfoorcTPjaQlqjO0PNCb/UZKPYbJhAOdVO+GgognqeAkQy4HSYG?=
 =?us-ascii?Q?LDzz4zrSHfshyg54ke2pdK4SsSNcVUghoB1gvxzthPkA5hgBfF//aVGnx6Yh?=
 =?us-ascii?Q?Peht1DdDxpMqND8m6z5Hi+3YKNgw6G0D5E+9FgMKB/BwVaTM2bJjsputwjWL?=
 =?us-ascii?Q?zyJbueCyxVZRetMgwGmUeLsIh6mjZcWdrTd7GZxt5Nzp/XpCq1GYB3fup8HT?=
 =?us-ascii?Q?lYFig0LBPWngtQdXtb0wZZ5HCNlHMzLlF5Mkk0esDkc0ZKPVbRRv3ZDeCizr?=
 =?us-ascii?Q?3OgwVZ92gTUyZgCFKQPW7Rcv8tIrIqeG6YEzsy+uz20KSI+7N3PQZO3MtFgL?=
 =?us-ascii?Q?lzo8BkShCnGAQmLXB5L/Khssw3TTyilGX0p9tvtYlP7EJiZUwpVN9zcINPus?=
 =?us-ascii?Q?0FO5L5/XQoVNS1+I1CoZ68BW8yYl8aZNapH55Z9YB5ngSe/KXS6SWtB0PLay?=
 =?us-ascii?Q?cOKq0TxRgwAFKw8FgWXYS/vRk+u3w17o08YGZ4GV9f/gnR0X5MmvF/25z7k6?=
 =?us-ascii?Q?ikRuKgk1ti0pI4AZIug++BuQ5+Wlq/etBVyGXVqOzbCBT7yN2rqdAHjyBYZo?=
 =?us-ascii?Q?yaLcLTsxvmiWE2LmxVszgmP2RIoIWQgrtU+93uZeRQ+4Atm0d3SX8YRTObXk?=
 =?us-ascii?Q?McgMpciDnA5+x9t/9kWiShrEbEh/EashlmDlKaTqE8rJJ+rbfp1tXnrNxCrF?=
 =?us-ascii?Q?pnfBvKohz0msnaKJTYy7NhQl4Y+2xUyp4j9/sje+GsFRvcH+qROd+PYPFxF5?=
 =?us-ascii?Q?LE9NjxIVcsDo/GuV8MECrtDwLlp7EvXREwyuk+sOHiUEg+csGUmiql4rTij2?=
 =?us-ascii?Q?bR4J9PkhEZfbhVS60fBArQpMXjnqocyTmEjo58jIZyzxR2+hNpP+/HbFMISv?=
 =?us-ascii?Q?Ew3i4GRA8h2ERdmVwAeRdN0KepPwOpuQAjHT+X6GlVJbqq27oom3msgGsc6a?=
 =?us-ascii?Q?aA03ardfeJp8Hrd7Fmps242W7go/TMhef2j9PBkLwLQvK0tUvObCDxZF5TDr?=
 =?us-ascii?Q?j/cnFC6Rodn4mXb/h1gDzUR3lMn8EQ8x9/owHUkTp1+tt3CVj/oojhkD3ihO?=
 =?us-ascii?Q?9RzuvXsg2e0Xm+9SZ5Rt/NNFOwZ8YXQ8wakgaK6akvOVoMLs12Tyt/iOPbb+?=
 =?us-ascii?Q?IX1+prcgbLhIeepifUQGHUzmw9YrVCvj58aVcQEM7YOGA3DfxFAQwDBDJWch?=
 =?us-ascii?Q?LhK1RLOMFJElPMtGqjhYo7IkftYinIi1OnErKnNp8eRo2ZN0vRw1ol4ZGKMQ?=
 =?us-ascii?Q?kGoQ8ZjIdKO0ODF8ZKXrxQbJmEPVIc8p+4liXfN2cw+nBjM2O3AMZmLr5NDU?=
 =?us-ascii?Q?ZdGMAO/pEW8XRqfI8yw5MMkHe1vNeJjaclQXHfmbGJD48UphojcrQfx6+Ox3?=
 =?us-ascii?Q?QSEDsjep7sjkWboTEf0W5j/0uBKSUCY6Ui8RY3Kz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963dcb76-ac18-47f3-a5d4-08da9c9dab95
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 13:23:42.8543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8JZVmNYKEWC4BcUOlRwBnLmmbyOyqbhtM2naGi/wFNTIU58XYyGWvLl6CTKqzMlh/xocKdyaqRKHQDrxKKDgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, September 22, 2022 5:11 AM, Andy Lutomirski wrote:
> To: Christopherson,, Sean <seanjc@google.com>; David Hildenbrand
> <david@redhat.com>
> Cc: Chao Peng <chao.p.peng@linux.intel.com>; kvm list
> <kvm@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-mm@kvack.org;
> linux-fsdevel@vger.kernel.org; Linux API <linux-api@vger.kernel.org>;
> linux-doc@vger.kernel.org; qemu-devel@nongnu.org; Paolo Bonzini
> <pbonzini@redhat.com>; Jonathan Corbet <corbet@lwn.net>; Vitaly
> Kuznetsov <vkuznets@redhat.com>; Wanpeng Li <wanpengli@tencent.com>;
> Jim Mattson <jmattson@google.com>; Joerg Roedel <joro@8bytes.org>;
> Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> Borislav Petkov <bp@alien8.de>; the arch/x86 maintainers <x86@kernel.org>=
;
> H. Peter Anvin <hpa@zytor.com>; Hugh Dickins <hughd@google.com>; Jeff
> Layton <jlayton@kernel.org>; J . Bruce Fields <bfields@fieldses.org>; And=
rew
> Morton <akpm@linux-foundation.org>; Shuah Khan <shuah@kernel.org>;
> Mike Rapoport <rppt@kernel.org>; Steven Price <steven.price@arm.com>;
> Maciej S . Szmigiero <mail@maciej.szmigiero.name>; Vlastimil Babka
> <vbabka@suse.cz>; Vishal Annapurve <vannapurve@google.com>; Yu Zhang
> <yu.c.zhang@linux.intel.com>; Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com>; Nakajima, Jun <jun.nakajima@intel.com>=
;
> Hansen, Dave <dave.hansen@intel.com>; Andi Kleen <ak@linux.intel.com>;
> aarcange@redhat.com; ddutile@redhat.com; dhildenb@redhat.com; Quentin
> Perret <qperret@google.com>; Michael Roth <michael.roth@amd.com>;
> Hocko, Michal <mhocko@suse.com>; Muchun Song
> <songmuchun@bytedance.com>; Wang, Wei W <wei.w.wang@intel.com>;
> Will Deacon <will@kernel.org>; Marc Zyngier <maz@kernel.org>; Fuad Tabba
> <tabba@google.com>
> Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible
> memfd
>=20
> (please excuse any formatting disasters.  my internet went out as I was
> composing this, and i did my best to rescue it.)
>=20
> On Mon, Sep 19, 2022, at 12:10 PM, Sean Christopherson wrote:
> > +Will, Marc and Fuad (apologies if I missed other pKVM folks)
> >
> > On Mon, Sep 19, 2022, David Hildenbrand wrote:
> >> On 15.09.22 16:29, Chao Peng wrote:
> >> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >> >
> >> > KVM can use memfd-provided memory for guest memory. For normal
> >> > userspace accessible memory, KVM userspace (e.g. QEMU) mmaps the
> >> > memfd into its virtual address space and then tells KVM to use the
> >> > virtual address to setup the mapping in the secondary page table (e.=
g.
> EPT).
> >> >
> >> > With confidential computing technologies like Intel TDX, the
> >> > memfd-provided memory may be encrypted with special key for special
> >> > software domain (e.g. KVM guest) and is not expected to be directly
> >> > accessed by userspace. Precisely, userspace access to such
> >> > encrypted memory may lead to host crash so it should be prevented.
> >>
> >> Initially my thaught was that this whole inaccessible thing is TDX
> >> specific and there is no need to force that on other mechanisms.
> >> That's why I suggested to not expose this to user space but handle
> >> the notifier requirements internally.
> >>
> >> IIUC now, protected KVM has similar demands. Either access
> >> (read/write) of guest RAM would result in a fault and possibly crash
> >> the hypervisor (at least not the whole machine IIUC).
> >
> > Yep.  The missing piece for pKVM is the ability to convert from shared
> > to private while preserving the contents, e.g. to hand off a large
> > buffer (hundreds of MiB) for processing in the protected VM.  Thoughts
> > on this at the bottom.
> >
> >> > This patch introduces userspace inaccessible memfd (created with
> >> > MFD_INACCESSIBLE). Its memory is inaccessible from userspace
> >> > through ordinary MMU access (e.g. read/write/mmap) but can be
> >> > accessed via in-kernel interface so KVM can directly interact with
> >> > core-mm without the need to map the memory into KVM userspace.
> >>
> >> With secretmem we decided to not add such "concept switch" flags and
> >> instead use a dedicated syscall.
> >>
> >
> > I have no personal preference whatsoever between a flag and a
> > dedicated syscall, but a dedicated syscall does seem like it would
> > give the kernel a bit more flexibility.
>=20
> The third option is a device node, e.g. /dev/kvm_secretmem or
> /dev/kvm_tdxmem or similar.  But if we need flags or other details in the
> future, maybe this isn't ideal.
>=20
> >
> >> What about memfd_inaccessible()? Especially, sealing and hugetlb are
> >> not even supported and it might take a while to support either.
> >
> > Don't know about sealing, but hugetlb support for "inaccessible"
> > memory needs to come sooner than later.  "inaccessible" in quotes
> > because we might want to choose a less binary name, e.g.
> > "restricted"?.
> >
> > Regarding pKVM's use case, with the shim approach I believe this can
> > be done by allowing userspace mmap() the "hidden" memfd, but with a
> > ton of restrictions piled on top.
> >
> > My first thought was to make the uAPI a set of KVM ioctls so that KVM
> > could tightly tightly control usage without taking on too much
> > complexity in the kernel, but working through things, routing the
> > behavior through the shim itself might not be all that horrific.
> >
> > IIRC, we discarded the idea of allowing userspace to map the "private"
> > fd because
> > things got too complex, but with the shim it doesn't seem _that_ bad.
>=20
> What's the exact use case?  Is it just to pre-populate the memory?

Add one more use case here. For TDX live migration support, on the destinat=
ion side,
we map the private fd during migration to store the encrypted private memor=
y data sent
from source, and at the end of migration, we unmap it and make it inaccessi=
ble before
resuming the TD to run.
