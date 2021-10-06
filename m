Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC442445D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhJFRgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 13:36:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7676 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231175AbhJFRgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:36:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196GxD3b025531;
        Wed, 6 Oct 2021 17:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Oi7WVbyHpd6gwq7dIV6GDOaD0Nn0mYAMBHU92gbXWfU=;
 b=bep0PuMsDB5PvggvTAORA06jO1vO2ksf5oCH7TbssQ4tF2axaF6MXlU3ZV5jw1Ys4lEN
 9Piwc+dNnBukd/iPNwM4SoqdSugOPVQ/Zq5JIKo5FnMmQNTZI8f6MNgjN5nAo2E7pukT
 E7miyL6w+KxlCPkaL7zHnrnsemlII2gjTsPwOSn7iurtrO1KcsAEwcSBbyw+gd4oCnz7
 +JCktg0hBYYRwCeAmrrCMZfLOHVfQO5zh1xYhTosi6glrmpYISLPalEtasUMfwXY0nM6
 CPGNwzIrY8gbTEEe3wfalluFu3QsjYDucBr+EoK+LZOQy99jxYWJyTlk6RZe8vnSwp6y tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh3y5drx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 17:33:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 196HEjkv091785;
        Wed, 6 Oct 2021 17:33:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 3bf16vg1rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 17:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyzuuzajCKneUbasIhtLbtZcwIdM7f+jRpjE72U9nfWWePcuQ7g1ZRJjd5ui6gY49GLENsGPx8ds6HBHTLuDouc/NwDO29aK47yfNJxGRr/1tUbPSglNeFHFpa0pYQpnpjMHobRxzTmUXB/Sb0C4vbV74PbIcbLCgscJzu8uHFN9Pb/V+AV4Ezc/odMfxNMdfE/I8fC6cpiE9rwFUWhufE+W5QNI3CS/SYelmJOlAu3TT5xmH+hGXa7QbeCFLxU2S7muWVgDD0qSHXS/xZpyw2ojT+5q9IJFm7J5+23F98SD/kaC7kFG6uipGaOzQJV2jdwfuBd7urxis9bQd7RAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi7WVbyHpd6gwq7dIV6GDOaD0Nn0mYAMBHU92gbXWfU=;
 b=YrIlWfm+fkQikRCmUbjvPMokCqYbFSGc6ZJId2SkZkYZoqosiknPB8YSIwNYW/ownEy8jeptIyPMnXCcswepQRDQZ8Gyv1cg+Ubf91bQOpR4cXo8BUYkwsC1kOMexk7cNrklbQ/rGRRVkeXqHG7KflJZKaMQtna8SticBoXDMjjsIDFFDJRv8ISosJPsrNUygUey3LvIKDsVvwWNSBKXXChxkx0KVX6ISs9S+rmybZhs/MmK2SwFpJU3K+rqqVjsXPW2gBBiPe1hzgfNlKdmLyvoLKW/Q39JYAxOxWb4qxFU6mdWx5mVnxVHk17ns919R1rHN8idgUPVd8E/RLorog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi7WVbyHpd6gwq7dIV6GDOaD0Nn0mYAMBHU92gbXWfU=;
 b=wnelBhURYsM3igJhNUoZmI5A6slw/D+eh4mn8sYUTVHjOywxF/jENnOhz5nU3SJchc6hb3gYzTEHkpyEQsgzAz1UwR7gCpHJUZcZK9IFmJ0dyz8A6XSNqXSRg7EETzf87WDv4gjtolcLOr6yBhvn2j8cU3m2pMrhBw0VEY/o5Cg=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5012.namprd10.prod.outlook.com (2603:10b6:208:334::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 6 Oct
 2021 17:33:14 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Wed, 6 Oct 2021
 17:33:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Rolf Eike Beer <eb@emlix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
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
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "cxfcosmos@gmail.com" <cxfcosmos@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Pekka Enberg <penberg@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Jan Glauber <jan.glauber@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Landley <rob@landley.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Serge E. Hallyn" <serge.hallyn@ubuntu.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, Shaohua Li <shli@fusionio.com>,
        Minchan Kim <minchan@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v10 1/3] mm: rearrange madvise code to allow for reuse
Thread-Topic: [PATCH v10 1/3] mm: rearrange madvise code to allow for reuse
Thread-Index: AQHXtwbqRHUtflHT6EeCVViEJ7Fas6vCbdyAgACa+ACAAeENgIAACJcAgAFP6QA=
Date:   Wed, 6 Oct 2021 17:33:12 +0000
Message-ID: <20211006173304.w77ksyuql6x5fbk2@revolver>
References: <20211001205657.815551-1-surenb@google.com>
 <5358242.RVGM2oBbkg@devpool47>
 <CAJuCfpF57Wppc_Si98wEo5cASBgEdS7J=Lt9Ont9+TsVr=KM_w@mail.gmail.com>
 <20211005210003.v3zgqhefn5j65gig@revolver>
 <CAJuCfpGaxhpePj8KN3S=Q7jMUjaeWZfoBTAHqjodhoH5MV-9yQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGaxhpePj8KN3S=Q7jMUjaeWZfoBTAHqjodhoH5MV-9yQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60d9c937-f169-4298-2b1d-08d988ef5f78
x-ms-traffictypediagnostic: BLAPR10MB5012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BLAPR10MB5012529F1C3963E89AEE3B06FDB09@BLAPR10MB5012.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AicKNneMM6RnVuve6v9uM1YjPRcss47b7BKZhxjTdoBI5KU4YMwPVpieCi2BHKEHRvONzoWF+5vbipKNTE7tsIAC3RskADafbJEz9mYIffZgk94NxVH/1vcR7SLjsgQTWDI8ucBP+GTqE2/FpMu0ipUhsHnJiAqsmthM2E3hYPeu+YnMuh7vcjzUy1wQb7bnNmpZodFjVK4ZCg2vX2tNP18+JudFFkAGAZpO9nX259YWNq10VspE/5BVq+ed2W1Nw3Oeul9wcp5CNjCmIywYU1gllosgxrr2vlH86cjsg4KndNahzR1Q5BZmoUh+xRojnz3MRNYaOv43HU4tgJXASDzmHCWMeIjSr649v5jwOOWlCFX7Bn9+5LPMlY4DiBzt6UOndGClMRzkIVwWdD2OiBuZ7sDWTjPKRR2lSbsKSsx5Q+oycv24zKByvDvAtUPHs/t4jrfDIGS93C7kP2gB67NRn8Ih+a6M9WnJmTvGUJPGIlas/tM3xj+MJlGwC4QJYemupQf8uGhdycdOf2AcpJQzb8wwQPnRwxZRbTGxxMOqz+ODpd8DJ2+DlU8d94qQKFHfBEDoFu99kxpwuGROxorRcdyY8EkrtT5vV6BpXW9t8hqY5lxL/lxp8qnatVyCLTg0h1GCnQmsvP+hsTPvzozoRVF47wq19oaW+ewFyVo/nNwTpJ3/VzTlNa4uKJY5vqulbe/Tuae2uAQPMHaDXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(8676002)(86362001)(33716001)(38100700002)(8936002)(122000001)(6916009)(66946007)(316002)(71200400001)(91956017)(4326008)(53546011)(6506007)(64756008)(508600001)(7416002)(54906003)(2906002)(7366002)(66446008)(7406005)(66476007)(66556008)(5660300002)(76116006)(186003)(38070700005)(9686003)(6512007)(44832011)(1076003)(6486002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZjRMK1BWT29PemxDb3NUb09ZeVJUaWlPZHJwOER2VXVJTHpBZG41TzVU?=
 =?iso-2022-jp?B?Y3R1ZEpvbUViK2sxbHpxVEJMczlCSmNNeGpVM1Fib2gzOE1VdVMvMHJK?=
 =?iso-2022-jp?B?ak1QRmN5TlRpc3ZndDE3TlBFTmErYmxYTnFmblB5U0c5VjhBWk44Mm5Z?=
 =?iso-2022-jp?B?MmExMGR1cDlBSzdlcTNQUXEzWnpUdWQwdnAxM3hUWjgrQWlLanBVT1pl?=
 =?iso-2022-jp?B?cTZwM3RCN3QxNnhTZlduKy9kKzhCRGlMQi9yZEdpbHdIbTlDVlo1RDBW?=
 =?iso-2022-jp?B?anZXUmJpU1d1TTRTSnRJYVpIM2liK09ZS1E1NWFWRXlHbWF1VGg1dXVS?=
 =?iso-2022-jp?B?elNaNHVFcytjbkxPL2FKblVhcUdwcGRWME9DdUQrMTRuMzFyVTNTY1hX?=
 =?iso-2022-jp?B?QzhaRXlGY3BPancvSE9KdXBqZ0RKTFEyaVVsM1c3ZGp1OTJtNmxFYnNy?=
 =?iso-2022-jp?B?azFwZXd4L2JBM1VIUDhrMDlSZFVuT2V0ck1pTWsxSmpCVFM0ZS82ZWxJ?=
 =?iso-2022-jp?B?NlFLRU83Z1lXeXc3VDA3Y2lOMzkvajE3RHlScFZjMUNnVTErTjVpZzdn?=
 =?iso-2022-jp?B?b0hmSjVGNlRTSXpzdFJwWGthRUR1cmNybnZVTlZqR0xJMzB3dlM0NkY5?=
 =?iso-2022-jp?B?OGw1b2p0R2FoZEV0SXh6OU1GN3VrcXBYNXZOZHlVZmFwZFliZERpTHpP?=
 =?iso-2022-jp?B?ZXJ5djkxaVVYRnczZGx5eDdDeHBWQndyVXRxWUpqazI2TW9kd05DcG5u?=
 =?iso-2022-jp?B?NjVvU2QvY3c4elczc2REVHV1MjEwNDFsMkZpOVRhcnQzVnV2eXJSUnpq?=
 =?iso-2022-jp?B?ZmlNb0x4VlB3Y3JwdDRWUTFoOUJvWkJZOUhITHVGRldiVDlKWlZ6Z2RV?=
 =?iso-2022-jp?B?dDJnUzJWK1oyNW9LWHdwWUNNVTZmNHZqaCtpK0ovczVlN090bEJOYVdB?=
 =?iso-2022-jp?B?ZFhaOHgvUEhzbTRzMWEvUVgxRGhreVNtdFBkbWFzWHRZSitPRHhFek4v?=
 =?iso-2022-jp?B?T2hNNDl6ZFM1d2hBeDEvbHZlWTNBL3c2NmhGeHZkbDUxTTNZc2VQQkQr?=
 =?iso-2022-jp?B?WCtrTk5GOVZJeDhWT01hdDRiN2pjc2pWTTdhMllXcTRua3BXSjVpR3VY?=
 =?iso-2022-jp?B?TkpuN2JFd056c3lVRi9pN3MrUnJ0Y0JrMFlMZXhSU3IrbDh6bGN5aXEy?=
 =?iso-2022-jp?B?ZzJ6TndQMXpuNHZnK2wyODlQbTRiSlBOa1JOR0RCMXhzTEdoTmVrak9k?=
 =?iso-2022-jp?B?azM1K1VZZmhFM3RPMXBJMG5SV3dVUkRYNTVSQit6ZjJXZXYzNlRjSTRB?=
 =?iso-2022-jp?B?cERySXVNT3Zsa0xFNmFhYytRZ1BUR1U0MXZGZXhZYldHa1BTQ1dxVXlt?=
 =?iso-2022-jp?B?WDRXU0tDaDBpRlh6R3pBd1BYb2FnZVhrSWtMdkVZK1hhbmJuRDNNZXN1?=
 =?iso-2022-jp?B?VE1PVmlFNHFDYjlLWi9ieWducDMxUU1jeCtUeTRMZ21yQWlRbGljanNP?=
 =?iso-2022-jp?B?YVg1Z3Y1QThwRlk0MzRJK3NIdmVXMW5IMDFSak9ENXpEd09KR0F6bzM5?=
 =?iso-2022-jp?B?U2JWNE1URUppOXNXZzJSd0tnWjJsemYyN09yblFzY2hkamYremtpUDBQ?=
 =?iso-2022-jp?B?SnRNVUgrVXJqbDdmVTRNL291NWUraGo1TlZxaTlFeGliK1B4dXB2Umtm?=
 =?iso-2022-jp?B?SzE1WUZHZlVYSWUyT0ZFSy9CM21CMWxvNUFPTGUveWdUWmJXOEN1QXp2?=
 =?iso-2022-jp?B?aGVjNVFPKzhFMVliMVZRdTVESVh4RHJ2Q0E0Z0E4WlltdmQyVVIzQmUv?=
 =?iso-2022-jp?B?V1dKSzViMkJxdkxqdEtJM014d1FuOUs1RmVwejFlOUZ2M1Jscis5dS9I?=
 =?iso-2022-jp?B?Nkg1bDJxWFZyV0tzSHJLblZCeWpWVGJnNFpWWCs3L3FXNE5FRXdwZTlv?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B246910A7EE5084BA8EFFEDE80918A9E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d9c937-f169-4298-2b1d-08d988ef5f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 17:33:12.7669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpRmnpMopjUiCBwpvbly5+pJYSl84ieKdDA3hyulHvOKwf//F79NzF2tHmG4iG2WhavhZvnJtVNdY+TFZVqZCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5012
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10129 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060109
X-Proofpoint-GUID: SDIQtRBo92kKtTy6Zf8-jtMQIegffB1l
X-Proofpoint-ORIG-GUID: SDIQtRBo92kKtTy6Zf8-jtMQIegffB1l
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [211005 17:31]:
> On Tue, Oct 5, 2021 at 2:00 PM Liam Howlett <liam.howlett@oracle.com> wro=
te:
> >
> > * Suren Baghdasaryan <surenb@google.com> [211004 12:18]:
> > > On Mon, Oct 4, 2021 at 12:03 AM Rolf Eike Beer <eb@emlix.com> wrote:
> > > >
> > > > > --- a/mm/madvise.c
> > > > > +++ b/mm/madvise.c
> > > > > @@ -63,76 +63,20 @@ static int madvise_need_mmap_write(int behavi=
or)
> > > > >  }
> > > > >
> > > > >  /*
> > > > > - * We can potentially split a vm area into separate
> > > > > - * areas, each area with its own behavior.
> > > > > + * Update the vm_flags on regiion of a vma, splitting it or merg=
ing it as
> > > >                                 ^^
> > >
> > > Thanks! Will fix in the next version.
> >
> > Since you'll be respinning for this comment, can you please point out
> > that the split will keep the VMA as [vma->vm_start, new_end)?  That is,
> > __split_vma() is passed 0 for new_below.  It might prove useful since
> > the code is being reused.
>=20
> Hmm. There are two cases here:
>=20
>         if (start !=3D vma->vm_start) {
>                 ...
>                 error =3D __split_vma(mm, vma, start, 1);
>         }
>=20
> and
>=20
>         if (end !=3D vma->vm_end) {
>                 ...
>                 error =3D __split_vma(mm, vma, end, 0);
>         }
>=20
> so, I don't think such a comment would be completely correct, no?

Yes, you are correct.  I'm not sure how I missed that.

Thanks,
Liam=
