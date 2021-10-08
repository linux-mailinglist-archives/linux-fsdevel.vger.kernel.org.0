Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9D42618B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 03:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhJHBGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 21:06:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3000 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhJHBGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 21:06:32 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197Nacue001318;
        Fri, 8 Oct 2021 01:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rvOX2hb9rSLR+AVZTw3/QeQbkhTaeJ1su+q+9NlYi5Y=;
 b=FqEDinTktCS5M3P8vMNkfTvW/ykgc2Q82XuhcjyUkgD4x+QTBYVklAgiMYO83vEGGO/f
 q0WbnwOP93nIUysPufubwkMmuZR4FelDpudAgYyL7XXy+LTiiYLkwbCBzPwVdDORARHi
 KI+O+cONVj75qkJw8fsrl6MdpTHnmwxCsCLtmLXMvL96bz1PYUWCByWhhjp/w4teiBO4
 VMxQVk/w4gTloGS0CfgxadKvu5fWUHGrfrrEAwAVfomXAPEkEqCAHn8prNWpOIYipDWI
 btMa2aWxXIjmQFOboYneGoNKcjcjFOsTxpg+FBzOAc6MdyOK2uKHfb4xO4rT0wsEt5Y+ +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj1ecmqh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 01:04:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19810pf6019001;
        Fri, 8 Oct 2021 01:04:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3bf0sb4g09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 01:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkvyevM7ecv8b/3EeDmZxOK+KX2TARjY70Be1MulEUUoqHsyMwHzeItHf/n0NC8hrF897c3+v6IAY7w+Nr/pVsMH7JYcuUL4UXJ84s772QLPpeDoLVSaFbqIJqGEkB5sxgjDIuiS7Xr8+lvns29SZrZD3LFqQydtZBo7pnIuUMARn1zq555QZrCR2pkE8F2ZQDzwY5BgerPdIguPjqGMUVlTBvo/PZMqbamNNd24IjBEeieH6+vStwf8HHVKlBMSejQsjxpGtQ2/RSdaTPSkStyAwbICaDaWMJeD39yLYs1EQBBqU2sNlq5PJUDOhocQDocdA52aV0gC+XahlDQ56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvOX2hb9rSLR+AVZTw3/QeQbkhTaeJ1su+q+9NlYi5Y=;
 b=hGoneS7sto/Qp2H+cPSgSkDttL6a8iUQbXDwFwh0CjZTVkyjxHFTUBhG9fP49PQNdCOgsTan/DS24s5nMnvKiZpLpSYYe07ZuP7avmq3SV4NrRWqNSKv9iMk6fGJuEypIfX3V4c1gFeEnMn0lGCBcsmySyTufCzC73RsjNI+TLpMyr/gG9JDC5aBH02ZDu22t4BYyxFJBQQ7CQMe9AZtpcJEElDh29nzLkNA5rZ/ASxUuhJh8ptWfWYBUIONiUg9ath4N3IOjdQby74QqdIQEEYixrl4ucs9sLL7i413xc0QzSQupGD5mlctcDFj5mVmbsbzmtA6WZb8r/vVpSoQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvOX2hb9rSLR+AVZTw3/QeQbkhTaeJ1su+q+9NlYi5Y=;
 b=ONLJ7j9mtMe5uwqo5f9aGQKxC4BSmCR7jdK5neBHHZEr4wQSQ4x+zBlyzm623vdWPQSe5dTOYbXhSol1XSzPVciva2WKsh4ABJiAnm9+XMleAup4t04cddmUGkN8DvFc0ex2a9MpR1FBA74ODQYjSHQhEhciJf/wI7iUkgV9nys=
Received: from DM6PR10MB3018.namprd10.prod.outlook.com (2603:10b6:5:6d::27) by
 DM6PR10MB3980.namprd10.prod.outlook.com (2603:10b6:5:1d2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Fri, 8 Oct 2021 01:04:32 +0000
Received: from DM6PR10MB3018.namprd10.prod.outlook.com
 ([fe80::8d95:1612:fb86:6c68]) by DM6PR10MB3018.namprd10.prod.outlook.com
 ([fe80::8d95:1612:fb86:6c68%7]) with mapi id 15.20.4587.020; Fri, 8 Oct 2021
 01:04:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     John Hubbard <jhubbard@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        =?iso-2022-jp?B?Q2hpbndlbiBDaGFuZyAoGyRCRCU2U0o4GyhCKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "krisman@collabora.com" <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        "legion@kernel.org" <legion@kernel.org>,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "cxfcosmos@gmail.com" <cxfcosmos@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Thread-Topic: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Thread-Index: AQHXtwbp0N5wJZFV1UW7KtzlcFc+IKvEw1yAgAAJKoCAAA2/gIAACwuAgACrhQCAABk7AIAAELiAgABdXwCAADFKgIAABaOAgADolQCAAAo3gIAAGJGAgABhbYCAAAozgIAABNsAgAAJRACAAAVeAIAABk4AgAAKY4CAAAORgIAAKa8AgAA7UoA=
Date:   Fri, 8 Oct 2021 01:04:32 +0000
Message-ID: <20211008010425.atn6kzho7xmnet4a@revolver>
References: <20211007101527.GA26288@duo.ucw.cz>
 <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook>
 <CAJuCfpFT7qcLM0ygjbzgCj1ScPDkZvv0hcvHkc40s9wgoTov7A@mail.gmail.com>
 <caa830de-ea66-267d-bafa-369a6175251e@nvidia.com>
 <CAJuCfpHJmDeyTXdsO8T5tTLgcNT22b15hj41EBNCDXBAoCdpog@mail.gmail.com>
In-Reply-To: <CAJuCfpHJmDeyTXdsO8T5tTLgcNT22b15hj41EBNCDXBAoCdpog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e86edbb2-8e9e-4ce5-21ff-08d989f79676
x-ms-traffictypediagnostic: DM6PR10MB3980:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3980A83A1ABEFA9FCA9093EBFDB29@DM6PR10MB3980.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhJJh1DyIB8u9WbRQZJB9YoRFcyFfOCoF5PiOQ9iELj4CO7Vwb1trlCISQfrWz96FnmZqggXP0Ci99CW/KI+GctzVTF1AhFEh2ga0mUfbszUacvJYOpmm65ttlAgu/UiNd/m/5meBWPhOO7KP6bSz4Fw7BqSJhDHkffB7T97Cd2xINL6RZgia59cY6M0xxYr2GsugCWGKipcBf+GAgCKkaiA4mget4GJ7LVqwsghDfmA8kW3Gno3zSJweLwobo3HgbjLp7uQfv6dkAcOqKgnmXhRuAY25qIz4EZHfoW0897GzMCOhZulbsciDnNfPjuZ02W739vSdjZepxlFS+BHiVlP93oxoqS9NSM04HyPEfBDvz5JjfNUn221spLiUXyDxc0H3koKz2n4b8l+mIweuCrFJLVRcFHKxumbeFPdIeMapPYYzDe41zGNtvIQ1dgYQnNtiwFgSY0Us0NZy07XvXq4HLVsfdzrPz+Iyf6NVDRa72DYGDEfhCm8dGrMhbtIeUJ5bq/Sf29FOfeaipxYvWS/4eAonP7QsY4LqjxNh5bMIncB7jJ4sGVGriII+L6QFrKn2mz1xIRUwpwYX6AYy3kLH1yjH8ujhHczE33jqR91k6uncKM7/80lUxxihgNmyGfR5FQDVVv+FrFu1/iA3XmK3HoipgzeGJRfU//4EqaFvXLxqvqS3/AEvxzMiZn5M9wreSxVBldrDvkIdOkpUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3018.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(53546011)(6916009)(33716001)(186003)(7366002)(5660300002)(6506007)(38070700005)(54906003)(76116006)(71200400001)(86362001)(8936002)(91956017)(1076003)(7416002)(26005)(9686003)(44832011)(2906002)(508600001)(6512007)(316002)(7406005)(66946007)(64756008)(66446008)(4326008)(66556008)(122000001)(83380400001)(8676002)(38100700002)(6486002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WStQY2hVOHZqdzZKdGRVamZUZVA1aGJRdmsyQXJ4UERRdWhDakowRVR0?=
 =?iso-2022-jp?B?MUNFb0ZRSTczSFprSy81Ym9Cb2lPTTdMRFVDU1o2U3dGY2lDRy83Znhq?=
 =?iso-2022-jp?B?VDZaanowNzR4TlRzeDFTdFJoNmNhZmEyc0syWGhPQmZWbFVVVFFwWTZa?=
 =?iso-2022-jp?B?QWJEeVR0dFBTc1BaZGFObkFWYjVUT0U3dTB3SnF6eTZXdU9vMXMwbXor?=
 =?iso-2022-jp?B?T2JpeUd4VUg5OWlxRjFkdWZMdnA5ZnZ0MW5Wc01OMVcxcERrZ0dqN08w?=
 =?iso-2022-jp?B?czgwb3hPVTFEMmptekwxbWJBRy9PeXJOdEVqS3hZUG5XVGlxZEFFTjlw?=
 =?iso-2022-jp?B?RlU5b1diMUNJcVJkWU9vUWpnVzRCZGdraW5adjFRVWluc1NNSldPUHhj?=
 =?iso-2022-jp?B?U1MvRWNmcm8vWTJWNlJqZC9GeVorZ1JQYnJ6T3Mvb0RLQ0dncy83aUMr?=
 =?iso-2022-jp?B?cWVneHJRZ1RTVHNuem8ybEVvNVBJdHZQVHZLS1pUQTdNRmpybWZJZmpu?=
 =?iso-2022-jp?B?dUdickZCTVNjeEhUS0VEMnZJZUZWblJ3b3ZHUlBJN0hXbGM1N0Q1b2Fh?=
 =?iso-2022-jp?B?ei9PWDhzRnJwTGw0RHRsdHZaTXRqbllzSmVNOURDeEtjbTZ2bk5kdzBI?=
 =?iso-2022-jp?B?OXI5d250RGZqOTZsRUlzc2JrTHh1L1JUREgrOW90N2U2L3RMUTZSWGtB?=
 =?iso-2022-jp?B?OGcwREFZYkNKZWpiV2JjNDkzL3Q1ZjNzbTZIS2dKNlBlM09Da3VTaEpK?=
 =?iso-2022-jp?B?clpyRDh0NDJXWlA5V0tXOEZyZ2xxMlQrZUo2MXArbzROVWg1QmVxVUFh?=
 =?iso-2022-jp?B?S3JCelBFcnFNRVNUVWhRb0RuN2R0bXgwRlRrejNZbklZd29xeXk1M09X?=
 =?iso-2022-jp?B?T0MxRFRvaU91WEorVzRFd0JjMmZJNW1QNzBRajdhWDNYck9KaTJiRVZz?=
 =?iso-2022-jp?B?S0N0Qm03cDJWRFN2OVFaaFhIYmdhZ1BEVFVzU0ttdUQ2WkVVajNKUHBF?=
 =?iso-2022-jp?B?VmpyV3FNSlJuaTFjMGRIOGpxK1RMdkh5R1hqU1pzSjRUblVCbnZnUi9H?=
 =?iso-2022-jp?B?TEJIbHJBQzh0cW80QzU2S2JKOURHcFIwZnNrcGYzMlZDR3dwTTI5Wklm?=
 =?iso-2022-jp?B?MlVUQzhWR2V6cEpjWW1jVVJTT3hIamFmQS93VTdmUHYyU0NtaG5UYmUy?=
 =?iso-2022-jp?B?T1g5bm5tcVhqLzdBcGxOY3pNOGMyalZpR2tycjNGcTNUcFNEZnFPMytE?=
 =?iso-2022-jp?B?L0wwbkVzb1pyWWFJMFBxbU5XMTVUalE1Z2FuWW5TeFkyOHNvOTF1aEo1?=
 =?iso-2022-jp?B?ZHBJYnRnYVFyNXYvZXN3eDhSeTI5UytXSFV4ODRWL0ZBc0ZBbXZtcVJs?=
 =?iso-2022-jp?B?bUY1aXFNWkV6VGdhN24xS09tMjQybG4yWklzS0txbEM5SlBnaCtmR1dX?=
 =?iso-2022-jp?B?N3c3SzNtQlA3WTkzWjhLNHQ2NUphVEFlcjhGYWVFam8rMHRPczVkNEoz?=
 =?iso-2022-jp?B?WTVBaWNQSVQvRlY4cFpPb1FibS9YeGtKSlhxWmRVQURnRjIwaUswTmpp?=
 =?iso-2022-jp?B?S2RKT1VRWlFGYlhmcUtQNnRJd1hVNnQzWkdGVkZMQWRRSkR1VndXRDVC?=
 =?iso-2022-jp?B?NW5xSFZGMkVwZkxkckFVMEY2bmg1WVM1a3RFa3RWeElVN2pPV0RRNkNk?=
 =?iso-2022-jp?B?Uzl1RjhCSWthT0p6eFNobVcrSWUvSEdmblZYVDU3dUxFR2ZKU0ZOMUtZ?=
 =?iso-2022-jp?B?WVlBZk9xdnViVE9wZjk4RU8ydGVJMGlpTHdEWWFHQXRONHJmMVdzVjh3?=
 =?iso-2022-jp?B?M1ROZjdtdkp4K24yUEVtL3puYjdSRC8xQzg5bW5WZUtLdkN5WlY1eExi?=
 =?iso-2022-jp?B?TUp6bGpUNHN0K1dHdG5NYUZwamZOWFhvYVd0OTdVVG0zMHpLNzNiSkNz?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <BF2349D043B26643BEF827D711C635A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3018.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86edbb2-8e9e-4ce5-21ff-08d989f79676
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 01:04:32.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zt160D/rpk0EcvOoFacEpT+3/gCtQqGmpVq44Vw2PN5Dxc9Bee070BNrlFE/XhUEyGWiUSNDe5XowV4jOgw4gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3980
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110080003
X-Proofpoint-GUID: noCwKXh9u9bNmqpXFFXvmBwWzmkhlTcF
X-Proofpoint-ORIG-GUID: noCwKXh9u9bNmqpXFFXvmBwWzmkhlTcF
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [211007 17:32]:
> On Thu, Oct 7, 2021 at 12:03 PM 'John Hubbard' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > On 10/7/21 11:50, Suren Baghdasaryan wrote:
> > ...
> > >>>>>>>>>> I believe Pavel meant something as simple as
> > >>>>>>>>>> $ YOUR_FILE=3D$YOUR_IDS_DIR/my_string_name
> > >>>>>>>>>> $ touch $YOUR_FILE
> > >>>>>>>>>> $ stat -c %i $YOUR_FILE
> > >>>>>>>
> > >>>>>>> Ah, ok, now I understand the proposal. Thanks for the clarifica=
tion!
> > >>>>>>> So, this would use filesystem as a directory for inode->name ma=
ppings.
> > >>>>>>> One rough edge for me is that the consumer would still need to =
parse
> > >>>>>>> /proc/$pid/maps and convert [anon:inode] into [anon:name] inste=
ad of
> > >>>>>>> just dumping the content for the user. Would it be acceptable i=
f we
> > >>>>>>> require the ID provided by prctl() to always be a valid inode a=
nd
> > >>>>>>> show_map_vma() would do the inode-to-filename conversion when
> > >>>>>>> generating maps/smaps files? I know that inode->dentry is not
> > >>>>>>> one-to-one mapping but we can simply output the first dentry na=
me.
> > >>>>>>> WDYT?
> > >>>>>>
> > >>>>>> No. You do not want to dictate any particular way of the mapping=
. The
> > >>>>>> above is just one way to do that without developing any actual m=
apping
> > >>>>>> yourself. You just use a filesystem for that. Kernel doesn't and
> > >>>>>> shouldn't understand the meaning of those numbers. It has no bus=
iness in
> > >>>>>> that.
> > >>>>>>
> > >>>>>> In a way this would be pushing policy into the kernel.
> > >>>>>
> > >>>>> I can see your point. Any other ideas on how to prevent tools fro=
m
> > >>>>> doing this id-to-name conversion themselves?
> > >>>>
> > >>>> I really fail to understand why you really want to prevent them fr=
om that.
> > >>>> Really, the whole thing is just a cookie that kernel maintains for=
 memory
> > >>>> mappings so that two parties can understand what the meaning of th=
at
> > >>>> mapping is from a higher level. They both have to agree on the nam=
ing
> > >>>> but the kernel shouldn't dictate any specific convention because t=
he
> > >>>> kernel _doesn't_ _care_. These things are not really anything acti=
onable
> > >>>> for the kernel. It is just a metadata.
> > >>>
> > >>> The desire is for one of these two parties to be a human who can ge=
t
> > >>> the data and use it as is without additional conversions.
> > >>> /proc/$pid/maps could report FD numbers instead of pathnames, which
> > >>> could be converted to pathnames in userspace. However we do not do
> > >>> that because pathnames are more convenient for humans to identify a
> > >>> specific resource. Same logic applies here IMHO.
> > >>
> > >> Yes, please. It really seems like the folks that are interested in t=
his
> > >> feature want strings. (I certainly do.) For those not interested in =
the
> > >> feature, it sounds like a CONFIG to keep it away would be sufficient=
.
> > >> Can we just move forward with that?
> > >
> > > Would love to if others are ok with this.
> > >
> >
> > If this doesn't get accepted, then another way forward would to continu=
e
> > the ideas above to their logical conclusion, and create a new file syst=
em:
> > vma-fs.  Like debug-fs and other special file systems, similar policy a=
nd
> > motivation. Also protected by a CONFIG option.
>=20
> TBH, I would prefer to have the current simple solution protected with
> a CONFIG option.
>=20
> >
> > Actually this seems at least as natural as the procfs approach, especia=
lly
> > given the nature of these strings, which feel more like dir+file names,=
 than
> > simple strings.

I think the current locking around VMAs makes this a very tricky, if not
impossible, path.  Watching a proc file which takes the mmap_lock() is
painful enough.  Considering how hard it has been to have this feature
added, I cannot see locking changes being accepted as a more feasible
approach nor can I see increased mmap_lock() contention from any feature
being desired.

I like the CONFIG option.  The patches are in good shape and have a
clever way around the (unlikely?) scalability issue that existed.

Thanks,
Liam=
