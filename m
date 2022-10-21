Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD86081C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Oct 2022 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJUWkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 18:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJUWkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:40:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A209A2202
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Oct 2022 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666392013; x=1697928013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8rM/pMRpLylV70PWZbEP3OJLUeyLF1qPy5efCSTGUJs=;
  b=TZbmWkG8fe5Nj1QVXfVoFgnCvYem2tTKBo+xuJEFjUvmFlAWxQcLTvfV
   gW1B5BMEo8WvDdxsM+YCaBS10jJDaE0LZW+gVaznv1mRHDmSgOlGqkuqF
   K2xzhiapBcs9uer0koSFazP3lNhAjinJMxmk/sBiTqI8Vz/G7h7+oedl/
   PRx4WfwBoSkMaHMk9R0VjSQ7QCgf7Mqkq07Y6e7G2FA7BiWftT0eZzC/W
   gbruTuqrFQUQCRqPxw29VfvVgXM/suGta6GrpawCXonzKUS0dP9OXA67k
   DQg1CzDUiRHCf+ZMofKS3jibVlIS9IYjKHpSJNe5oxJkkI2wcAsP8EVYk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="294517500"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="294517500"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="608551711"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="608551711"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2022 15:40:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:40:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:40:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 15:40:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 15:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW78YA4ml1gwU3kpFNi/gkq4py3prGKDudgYuvjwNGGuoJL/m3Fprav4I1U6i5xjs79kqUyYQ6tjkekLIlFZN2J7faTb9QTkWE9TR3cpYQPkmZ/8HRt+h92lZNVAaeM4zKC34hxvvFFX4JtIOWJMPMZPYm11evlvLQAQRDmlyzs4p/1XDsnl+nkp12iy11dbp87FTcmdvyv4W4zS5dO3DuCbWr+SvNek/DaYBmUe4mnp7+1WdRNthkp6uqnZK5IQDBj49+vH3FWWljDxVPurbxvK7ateYMJhlB+OpGUJXAlYf8ZygIeIZ+t1gn7fIQZSwa9yscjtR5Qd07OErnpRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XDfob9eZunMQ/wUpnc59kBNl3gfz4F9zNjvCLJC+DM=;
 b=Z0qe41aHqmq4s+qOZVn2ZgA2F4xJtdqQvVLufb7nJvBR9JSENGpH8yJw5ZAk3dc1j3w7CWyEdI7XGXcdWQUH87mQ/NdJGh1nO9j3BZukNEIBw+yMbpBCE9BgzYJHAFxDWbHqHO8txR1UHXp0vAOXiQf6gmQVWezdHlVR7Cci6DqEt+7/WAibSHPp5IWOV7qGXGClGkIaA5Lj2Uiw1Me+Ags5oLvaG2KVBNTRddTd6+75QTpWwFL2NCBdS0RKFxfZgvilKcfdMHjFC7ILOHOhp3MUWvUCjnuoDZB5SN1YDmYbZ47Bb1OPo7n3fVl2CZagMPz0sKoCUFLbkHCMJ69pKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3978.namprd11.prod.outlook.com (2603:10b6:5:19a::14)
 by SJ0PR11MB5679.namprd11.prod.outlook.com (2603:10b6:a03:303::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 22:40:05 +0000
Received: from DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::1b68:f941:6705:2288]) by DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::1b68:f941:6705:2288%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 22:40:05 +0000
From:   "Pulavarty, Badari" <badari.pulavarty@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "huangzhaoyang@gmail.com" <huangzhaoyang@gmail.com>,
        "ke.wang@unisoc.com" <ke.wang@unisoc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [RFC PATCH] mm: move xa forward when run across zombie page
Thread-Topic: [RFC PATCH] mm: move xa forward when run across zombie page
Thread-Index: AQHY5Zz4BT/DMcb+H0K5D/9RcgEw0q4ZbwQA
Date:   Fri, 21 Oct 2022 22:40:05 +0000
Message-ID: <DM6PR11MB397838A94F24C1F4CCE306929C2D9@DM6PR11MB3978.namprd11.prod.outlook.com>
References: <DM6PR11MB3978E31FE5149BA89D371E079C2D9@DM6PR11MB3978.namprd11.prod.outlook.com>
 <Y1Md0hzhkqzik/WA@casper.infradead.org>
In-Reply-To: <Y1Md0hzhkqzik/WA@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3978:EE_|SJ0PR11MB5679:EE_
x-ms-office365-filtering-correlation-id: aba86655-9a14-4161-1b63-08dab3b532e9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RY6d8PuAieMFtFOSwi/Ky+X7hfNs+zpatHmy0+0r9LCbiPFBm4leeywb3ceGezx5YN+FVV5nIOoE4NNwIhtlFFaUqXDVWpIm0e7nvnAHo20R7G5sl5AdLTJUeG7VGSBVnBtJPK6SDvTILucG0xTLniNuO3eXoSN3Yuxy64u1kYt5f3uz+Ti7mFhGcADT59slddfqqOlywCiXmv4IQl3HOMimsBUuK/TDsm69xVTwTe7EWDbKMl3QelwaIHDu73hvbMmjO/4WrUMf4lGDOIJrx0eXxinPqvB4qUPq1DFqhfIFpqkWs3RzANMK0HaZgaxqKxdPAahzIyxHVXHobcpY72Q9bcMJ1dj9OIX/wh1e/odExyPrLeK/WyXfFJRTVqZXsBaXn/ktNaETCZAECT0QntrFe/s+EOrmPsPhFOpypdXzgDioi3eAWYrvdak1SSBx+fpNCH/KCbAG/fSNozmvKdqLJY2GU6ZyJ2kHzS4N5mRJpVo5Zwps5pZesR8TCKeMcV3X/OzDJvAPWIGANqKZny9/SFhcSGGuG9Wa8C37EvAjSDubdzjZ3Ec4v0C0wJmVZMNtOZ6LXf0g/xWTSc8qzpfJEw869AxtoiE8dG4TZj3uwDI7Q5dEpmbnDsquQ8NqQbbxUnNBZsYGOJJ0thU+I8d+AAOsJHoBYaFF9r7awOBRRmxoGuMuIwfeSBPXmiWazDV56/abKTN6rmEVZqtLGoorzjk07VzSpXO51UnnvdIc/lUokWjSDy85N2+8u3rtEZLEQluFkWk7oR2u+bQfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(71200400001)(83380400001)(86362001)(478600001)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(6916009)(107886003)(6506007)(53546011)(316002)(7696005)(5660300002)(8936002)(26005)(52536014)(9686003)(41300700001)(55016003)(2906002)(38100700002)(122000001)(33656002)(186003)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1xIOnMuh5ZPyGvLe+122wUmbp/B8jvjxwlHScpaCP5gq3G6V0fTg1ZNpLSvQ?=
 =?us-ascii?Q?vA5AmYcKQX6NVwL4wZExgWr7O1AXADGxhQaHl6ua9NzBC0fbR5KJN1EXBMgV?=
 =?us-ascii?Q?17Yw/LblI7Kt76ZjovHEg4UvoU35QCGNJq9OU5el7YrUWx4no+lMR7ccCkTT?=
 =?us-ascii?Q?J+ih4zumF1Ny9NiFStgxWaVz7kYHadDBMvWoDd4VaRZVn5a5oHg5gJeW5MZV?=
 =?us-ascii?Q?oscUUD/yYPDxrAsN23ATQ6ycUP9LSLo7RY4EZCpYWInGQKc/T5iDtx7fxpZ0?=
 =?us-ascii?Q?0zrIOg1ZxKrr5z0W3cDM4E6E+lfg20ybjHRenGISC1Mp6RBGy4EPC/cOszdj?=
 =?us-ascii?Q?cn84a1K+Id83NuRXYPmaSoxKRHTV2jiGePwl2nx5S0ERqamQXpCByB2QUGyj?=
 =?us-ascii?Q?0o3eA+UcyYDYtW4wsbQxuv3pr7f4wPhLHKPnl26jRXnNtD/JAJfmTWm5B5To?=
 =?us-ascii?Q?B4wYp2ZpGCiRcqZk+kD9FR55+VOGcyu5KRlVaJaTgQh0yd3SEHqp3Ofy0Vji?=
 =?us-ascii?Q?fflOefLBzl7A8yBj65+HNSAC2PvmZvtFRNC4wqL64V/5dXafXCIbVrAvqFlD?=
 =?us-ascii?Q?6rVORor5sEaX46UJe+cvCY+ieQexQxB1NY63bFrVATwb05Trz2YACsvr7Y3v?=
 =?us-ascii?Q?Gaknjelzxvmn98SUxPjQLC0KycTN4FjWQgQKcuqIyUcOZQbPGAF5fdko3zMH?=
 =?us-ascii?Q?6Z/tHmL0u+Joj0aJOg5qQePVa4j5nSC1nyzT69qp2CM27WgPyZ2OC9dq7628?=
 =?us-ascii?Q?4+807XZEnhnihPNEHOpI0LvKA4s5zKl4QucS4ubtMEIYEj//UIa/6B58Fba7?=
 =?us-ascii?Q?UBTZ4vkn9YJWuFMjAW54wtC/7796SkaY+nsQc/sCn0vvPPnsdZEz5LzYCQNk?=
 =?us-ascii?Q?AOoszgAvJsHryREpzXrK8+0Ac9x7hdgYCqT4L12Bsy2Fy4G1r+4/0tdzto3O?=
 =?us-ascii?Q?7cbiB33Eb/2+kVNYspIX+WJhakUlkKDLE7TgwgFtsjqr/s9vaZluJ/qOkPAJ?=
 =?us-ascii?Q?mCuHdeV4g6pRhmBkyphh5sbmrURqOVTDQJR3cven8P4krCu4TyBm9fTpDaet?=
 =?us-ascii?Q?q+9vkEMhuwenBxntEHcDdnrM/WW7ImhQGQ4+DQPub1o7GrK7DpSzxiuqBqVw?=
 =?us-ascii?Q?b4RM5ammWHfucx0U3+eVC4u8UAU+khj5u1jQA/PS/BAmfC8JkV6xwwQm6rqe?=
 =?us-ascii?Q?pk7SllULzEb8PHZFIc1I7DOMHldOnDRuEML2DkTLcOI49xCp2+GrnmQ5uqj8?=
 =?us-ascii?Q?LCrizNbflak5RKqsoGvZxLimiY1VQkm7kg3pLClS1aEUqsQonycF5uPyuqYh?=
 =?us-ascii?Q?Q3L+2RDou1mN6mMSB48VWBs4bOijZqS0Q9o3B7vpOZpofWjRJiSfUdMt/p7/?=
 =?us-ascii?Q?WEX5zhLMmkT7A5KKhQKXHihn7+epivMpJAdWCyYm5AGq0KSYUumSgMTheIA5?=
 =?us-ascii?Q?rBseO+kmvH3aqYnGukpQan+wOOsjzq9wiUAai2oxH3HiKv3ArEPBBetilF+g?=
 =?us-ascii?Q?SjwyLsBPALIRPv77aQ2Sb+2ycKOdOXHZLGKCqyl3ZFVjaJQam11FuJaIk2hp?=
 =?us-ascii?Q?JmCO+tmPLA4Ma6zsJUGuxmvdO21HXDrOwjURP5ub?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba86655-9a14-4161-1b63-08dab3b532e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 22:40:05.0467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmWiar+1STpIDklYYF23RDBpQn1uRs8i1PdOAbOt0+oUuuILLvO06b08BULdihwmoDJe4Zjx43c2mx5+/sccGLdTCvL7iZdKP3B5/5Vbvbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



-----Original Message-----
From: Matthew Wilcox <willy@infradead.org>=20
Sent: Friday, October 21, 2022 3:32 PM
To: Pulavarty, Badari <badari.pulavarty@intel.com>
Cc: david@fromorbit.com; akpm@linux-foundation.org; bfoster@redhat.com; hua=
ngzhaoyang@gmail.com; ke.wang@unisoc.com; linux-fsdevel@vger.kernel.org; in=
ux-kernel@vger.kernel.org; linux-mm@kvack.org; zhaoyang.huang@unisoc.com; S=
hutemov, Kirill <kirill.shutemov@intel.com>; Tang, Feng <feng.tang@intel.co=
m>; Huang, Ying <ying.huang@intel.com>; Yin, Fengwei <fengwei.yin@intel.com=
>; Hansen, Dave <dave.hansen@intel.com>; Zanussi, Tom <tom.zanussi@intel.co=
m>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page

On Fri, Oct 21, 2022 at 09:37:36PM +0000, Pulavarty, Badari wrote:
> I have been tracking similar issue(s) with soft lockup or panics on my sy=
stem consistently with my workload.
> Tried multiple kernel versions. Issue seem to happen consistently on=20
> 6.1-rc1 (while it seem to happen on 5.17, 5.19, 6.0.X)
>=20
> PANIC: "Kernel panic - not syncing: softlockup: hung tasks"
>=20
>     RIP: 0000000000000001  RSP: ff3d8e7f0d9978ea  RFLAGS: ff3d8e7f0d9978e=
8
>     RAX: 0000000000000000  RBX: 0000000000000000  RCX: 0000000000000000
>     RDX: 000000006b9c66f1  RSI: ff506ca15ff33c20  RDI: 0000000000000000
>     RBP: ffffffff84bc64cc   R8: ff3d8e412cabdff0   R9: ffffffff84c00e8b
>     R10: ff506ca15ff33b69  R11: 0000000000000000  R12: ff506ca15ff33b58
>     R13: ffffffff84bc79a3  R14: ff506ca15ff33b38  R15: 0000000000000000
>     ORIG_RAX: ff506ca15ff33a80  CS: ff506ca15ff33c78  SS: 0000
> #9 [ff506ca15ff33c18] xas_load at ffffffff84b49a7f
> #10 [ff506ca15ff33c28] __filemap_get_folio at ffffffff840985da
> #11 [ff506ca15ff33ce8] swap_cache_get_folio at ffffffff841119db

Oh, this is interesting.  It's the swapper address_space.
I bet that 0xffffffff85044560 (the value of a_ops) is the address of swap_o=
ps in your kernel?

I don't know if it will help, but it's an interesting data point.

> Looking at the crash dump, mapping->host became NULL. Not sure what exact=
ly is happening.

That's always true for the swapper_spaces, AIUI.

>   a_ops =3D 0xffffffff85044560,

Correct. Its swap_ops. (I am using zswap).

In my scenario - I run the workload in a container and use DAMON or PSI to =
squeeze the cold pages out to zswap.

Thanks,
Badari


