Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C56423297
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 23:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhJEVED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 17:04:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22760 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232250AbhJEVEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:04:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195KtN4F029448;
        Tue, 5 Oct 2021 21:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Iu8l/kjfpN/J1tVMYPWBmN12VadVdC8oGYTJqghB95Y=;
 b=Jk70e7OAskticiFb+UFfF5V9HAJhCIOM6/XS9aeENXIbhzrFLArRV8/9HE4aGQCRPd+W
 vvNzZOK4IR2rC+NMTrIIi90A33ubfjNMorRtE4Snr4VNWEX7R+BQS5E96LNMlQwAACJZ
 7oYKQ2P66Yf9qyvq6TcdrPYOiFWTUYiAxjK7+sguwRYFevC1c9inwLIkAZHQ41HSJgFG
 QVowqnz1ty+1sXo4lM6/4rg8rCI9y+jJikqAYEnobpKng2snQuDfV5+kSSyxfLILQNkz
 jiu1N8PYaOwsIGNCb93KxyCtMrfCGKWVjr75vdSvs4RyLiCbdwEB4xEZb/gHXTwsb1Yx dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42ku56e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 21:00:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195KoxHk165293;
        Tue, 5 Oct 2021 21:00:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3030.oracle.com with ESMTP id 3bf0s76d2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 21:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdklJ//PU5DcBico6xoescveFGZqfFz+Lg/1oqRLu6Vld840NvUrIotODfXh4SosrGLwjJgeQ4aPxL09SwPtq7otF9fckjgOm0+vUF56pXa5HYmqWxGwDuJ/SZJC+tiyOVyt5BdL0EIH2jiipanaLWyf4HXiQ1WMOioXsappny9EZ4Pf/iMBvVfaJWau3lGp3GTPTp9EUQR62FbIqDNqyIkTGxnBxtvSH0wYGQVCzLNp1fDHHEiZc0yxePg05kYjIypjnrVVIZB9WjNV4tmzcITbdXkAFs5ITXfjeF3ETQScB0P2CvWvO/7SBsKVSNQbXyDoEZXRkE/91pykhUenFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu8l/kjfpN/J1tVMYPWBmN12VadVdC8oGYTJqghB95Y=;
 b=TAhBshchSCN83s3b1JDq3IKArHiLVNsMX08sY397GcKZD+S3PLQ0UZyfb2gOlM+E4x0A6XSYo97WWc9P6a7/UP98DmyJmr7KePp0iNllkNT0LIkZCiMSZLX77A6PuQeHLpXVpUlU0Mu5p3TaU/jLobuKFf23WdQ4Gpf5tvg55diM+HHuOLmX/qtwncWPDrg89IBD0r0bK28xiG7PlbuyD6xCEA0BFTzsAC8TtSGAAWMiy/t45HuklJUrkIV0Uw3yPUPLQCjyP5E6XzZqV4jr4UkdQYOoMc0zQszhr1IJHkYmnMTy734oL9Eq3TYWly4C2LeJEjPJJdPoqpO9qgwMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu8l/kjfpN/J1tVMYPWBmN12VadVdC8oGYTJqghB95Y=;
 b=L1kCoFWgcrZWdutYs5eyEiw8AH6CdOAT98lmM8YWlyXiNUakF9xz7j2d81wmbiWVrP43FC7Y+PGB96OO6WXSWZHttct9s4FIS+Ev9SuO+R05xTMzzMdQC8p8xoQ7VkU4DD91ZGKQKbw2V/xeVXo1peuoy1xdCkeKSunxFFmv5rk=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 21:00:24 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 21:00:24 +0000
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
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
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
Thread-Index: AQHXtwbqRHUtflHT6EeCVViEJ7Fas6vCbdyAgACa+ACAAeENgA==
Date:   Tue, 5 Oct 2021 21:00:23 +0000
Message-ID: <20211005210003.v3zgqhefn5j65gig@revolver>
References: <20211001205657.815551-1-surenb@google.com>
 <5358242.RVGM2oBbkg@devpool47>
 <CAJuCfpF57Wppc_Si98wEo5cASBgEdS7J=Lt9Ont9+TsVr=KM_w@mail.gmail.com>
In-Reply-To: <CAJuCfpF57Wppc_Si98wEo5cASBgEdS7J=Lt9Ont9+TsVr=KM_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85538125-ee0a-4b44-b1eb-08d9884326c1
x-ms-traffictypediagnostic: BLAPR10MB5218:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BLAPR10MB5218E8C90A93DE54C9162992FDAF9@BLAPR10MB5218.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zs/el4Nnyve9oNfgj+CMbTmfYD4N06tS9n+Jaw7vYTp4XWmfqaR6XmREdaO+06mVYtmSwi5DEfyEKhwVR/i6nLi+GaWxpDsLkU2pBHn6jvL4igxM/Ntz1QuoYW8PSbdHtakzW6BTExtQZFbCqH2xMwgV617n8DIxtK4dYe5KQqNo//ICwdC7lSbgvIu/XMm31wVy5JOvFIhckZGvmyANzfrfmZnMgmfcNsarzpkxFPX2zklDeLnnCFE9u6GXpwpbHYsohj8DV75hr1M6eVvkMgXF0Ab5pBU2TF7wO8JlXeNph6+rUiTbYJP/KbxRQ+2g9H3ztpCxOwNK2eFOMjuCORRpIjIonAeNbKzkbSNxUF9sE7jENOwSJWTzCjGXiTbZQ35svFzVMUA9AO2pSE0aQcY2pLcy7FYsxn+ckrAirRiZ2aXVLhj2Hmn6p71WCmCvUWqJQN4V3lraCworUuJSWiLCPscucL/m7eQovTOt+Jzypvb0veDrqLLTOKDbfNTb2dGi9HxokY4nDmEGSTiIInKCnDzBxguue28e0cJbhm/jzLR1FF7c0G6keXlv+i+q3+13Q/Xvo4j6yMDaoMWScgdmmmBB5I4Ket45bvyGc47YEUx6z5qp/P+3vY+RxSQngT9TQMVhNdYC19LBpaKuDTPner5nPQ4HQHfl8794/GviJ5aOR1wFrviCPhNseJFaGkKJyYpdaqsLkM6YN5/tr7bWFNdrMNICzvqap0FhTsqytXbxDs4frmmlND9VMWQtxVQ/aU643UHfvP2FLgNU0yB3UcA/LLbyv5XkzI8rrL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(8936002)(5660300002)(71200400001)(26005)(6486002)(6512007)(1076003)(6506007)(86362001)(186003)(38100700002)(508600001)(33716001)(122000001)(53546011)(8676002)(966005)(6916009)(38070700005)(76116006)(91956017)(66946007)(7366002)(44832011)(7416002)(66574015)(54906003)(7406005)(4326008)(2906002)(316002)(64756008)(83380400001)(66476007)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cklZbEhKbzl1cHdvTC9zM0x2aEo3cDJyMGNINTJPMkFHTUZacDB3ZDRrZzYv?=
 =?utf-8?B?QWpIZGF5UEkxMi96aWZmaEszUGhBMmtjekpkc3JXaFpKNVhKeFNQRlRxeStJ?=
 =?utf-8?B?ZUZNTHlJTHZBREgyK2YyY1RoLzk5bnppbnlFLzlBcW5CR0toWU1PNHV4d1Uz?=
 =?utf-8?B?TUJNQUxCR0VuemorYWNzMjVmeGxrWXY0KzhlY0U4OEdLcW13ZytrL1c5SkI3?=
 =?utf-8?B?UGxVSmQ1anRxT2lDd3ZOSDlBSzkrWWt1WEdBQXh6TW5YNlVRd0lIcTF6QlEy?=
 =?utf-8?B?cmN2djRhWWZpckI0V2U2aUdkbHNER2JHd3BkYTFXS0JBQXpCK2RFaVpiTS9r?=
 =?utf-8?B?amdIeUh0NFpRUE1ZRjZUMkg2eStkNWpOYko0bmxEelhYVzlHWndDaDdZVjk5?=
 =?utf-8?B?bituallkc0xlLzcxT0NVM25ITW9MQ2dzZzJBNUxkbFRwajNRcUZNam1PSUpH?=
 =?utf-8?B?ZWllM2FCQ0pPaGZGbHhEUC9ReEVhWFg1WUVrSkY2ZUJ3MVJDVHZUMmJNREo3?=
 =?utf-8?B?dm9wN255UE83aEo1bGFVdmgyRWlsbHVzdTUySGtDcUFvU081UW9zUE5RSmkx?=
 =?utf-8?B?WHZLS01ZRXBSWUhhZlBXcHBYTlhZS0orcXU3WGF6MGNqU1puQklaWEJ0aFJX?=
 =?utf-8?B?Q1JPYUt3b095b0xKTU5OTDRyUExicWZuOGZhUFlxYUZSZFo5emE5VWdxWkNh?=
 =?utf-8?B?WXZ1QzNnSVh0TmtxYngzNnp3TDFLQnlueDg1OVFSMXJIUHNGTFkxUy9DbVF2?=
 =?utf-8?B?S2NkdmtERndpZUt4a1QvR3h4TlM0MURWWXppcGZ4akZ5Y3JBSmM2YW9JZGlX?=
 =?utf-8?B?YnJ6aURha0psc0N5Y0VCenJ6dnpvR21aYzN3SE9Ib3NkOERPcjcwdk5Dejc4?=
 =?utf-8?B?YmRoU0hpaTVFRE4xdFMvajdyYVNHekxEZ0U3MDVRTStEMFk2d0JuUjZEZmw3?=
 =?utf-8?B?b3NDYVJtS2h2ZWhmY0tOMXVsOG50UytXZzBMT2dFSmZ3WWF2eE15Nmo1UDV3?=
 =?utf-8?B?OEVRVzVBL29UVjc1UzlhWjFVRFVQSG95bmZrd0pEeVYvZEUzd0ZnRkluRVV1?=
 =?utf-8?B?YXZmNHJTejRnSzlIU0hDWlZ1VHhRNWJTeG4yS2pCYkRrKzRPYnZJcCt1dHdh?=
 =?utf-8?B?RzVSWm5kWkVDRGJCODZMT2ZYYkRoVFZBT2pMYURRREdmOGkvSkNqNGZoY3l0?=
 =?utf-8?B?cHhDSEhCSDZiSm5uWStNSTdJOVFhMldTVzI1SkNIdzIvOGdBdEtUK3JobHFC?=
 =?utf-8?B?dEtaYzBqT2pKcjBHREcyN2dBMW9uNTE3QzZmWUtpTExHUnVKS2JYbFlXY3NN?=
 =?utf-8?B?V3dlY2YxMk1Kb0pOL3hmYVQ3ZWtHcGcyMFgzNFloU0xqdnBVRmZNeXpDVVZ6?=
 =?utf-8?B?eHZ5eEZsYkRsVjBXbFZPTWJtemcyMHdZSTljY1VyL1NRRTRMMi9CMzRPMFYy?=
 =?utf-8?B?QXZEdEN0dllsMTNCVVlKalJVVGQvUDg4R3VGakErcDh6NjA0Qm5uYThYVE4y?=
 =?utf-8?B?VXYzcmF2Y2xaME04TFQ5Rk5iZGlZN2IwRWc1Vnc2WFRNZXlNZ0w3ZWl4Qkty?=
 =?utf-8?B?UlplK0pSTENBQlM4LzhBc3VqZW14WGFGK0RQNk1aVitWL09KajJZUDJWS3pn?=
 =?utf-8?B?K3gwL0Z2dFdUSG14V0JPcHF1dDkxQ3lHZjl6U01lTzJMOENKd1hIdDZ5aHdN?=
 =?utf-8?B?ZG0yNG15Ukx1bVoySGh6WHdmYnRndU1DTkY0Rm5DaXMrckxmK1dFcHo4bi9M?=
 =?utf-8?Q?uGVyx9/nFfC9RWz1Uz0izQjjJpYDfoARzQD5Ylt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E057B3F6C9F7547A915D818CD18DB7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85538125-ee0a-4b44-b1eb-08d9884326c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 21:00:24.2361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tse71g+30PL9hESCs0AEnr+yGAo2Mw9vhHKPArJwu+MWoLCZHU+4g6VgXVFI0x7AWNf91MZ7E2sQ792H7ikGVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050122
X-Proofpoint-GUID: o0OpNIfd2lW_GoarindG2Rvk1fzfJtHa
X-Proofpoint-ORIG-GUID: o0OpNIfd2lW_GoarindG2Rvk1fzfJtHa
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KiBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUuY29tPiBbMjExMDA0IDEyOjE4XToN
Cj4gT24gTW9uLCBPY3QgNCwgMjAyMSBhdCAxMjowMyBBTSBSb2xmIEVpa2UgQmVlciA8ZWJAZW1s
aXguY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gLS0tIGEvbW0vbWFkdmlzZS5jDQo+ID4gPiArKysg
Yi9tbS9tYWR2aXNlLmMNCj4gPiA+IEBAIC02Myw3NiArNjMsMjAgQEAgc3RhdGljIGludCBtYWR2
aXNlX25lZWRfbW1hcF93cml0ZShpbnQgYmVoYXZpb3IpDQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+
ICAvKg0KPiA+ID4gLSAqIFdlIGNhbiBwb3RlbnRpYWxseSBzcGxpdCBhIHZtIGFyZWEgaW50byBz
ZXBhcmF0ZQ0KPiA+ID4gLSAqIGFyZWFzLCBlYWNoIGFyZWEgd2l0aCBpdHMgb3duIGJlaGF2aW9y
Lg0KPiA+ID4gKyAqIFVwZGF0ZSB0aGUgdm1fZmxhZ3Mgb24gcmVnaWlvbiBvZiBhIHZtYSwgc3Bs
aXR0aW5nIGl0IG9yIG1lcmdpbmcgaXQgYXMNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5eDQo+IA0KPiBUaGFua3MhIFdpbGwgZml4IGluIHRoZSBuZXh0IHZlcnNpb24uDQoN
ClNpbmNlIHlvdSdsbCBiZSByZXNwaW5uaW5nIGZvciB0aGlzIGNvbW1lbnQsIGNhbiB5b3UgcGxl
YXNlIHBvaW50IG91dA0KdGhhdCB0aGUgc3BsaXQgd2lsbCBrZWVwIHRoZSBWTUEgYXMgW3ZtYS0+
dm1fc3RhcnQsIG5ld19lbmQpPyAgVGhhdCBpcywNCl9fc3BsaXRfdm1hKCkgaXMgcGFzc2VkIDAg
Zm9yIG5ld19iZWxvdy4gIEl0IG1pZ2h0IHByb3ZlIHVzZWZ1bCBzaW5jZQ0KdGhlIGNvZGUgaXMg
YmVpbmcgcmV1c2VkLg0KDQpUaGFua3MsDQpMaWFtDQoNCj4gDQo+ID4NCj4gPiBFaWtlDQo+ID4g
LS0NCj4gPiBSb2xmIEVpa2UgQmVlciwgZW1saXggR21iSCwgaHR0cDovL3d3dy5lbWxpeC5jb20N
Cj4gPiBGb24gKzQ5IDU1MSAzMDY2NC0wLCBGYXggKzQ5IDU1MSAzMDY2NC0xMQ0KPiA+IEdvdGhh
ZXIgUGxhdHogMywgMzcwODMgR8O2dHRpbmdlbiwgR2VybWFueQ0KPiA+IFNpdHogZGVyIEdlc2Vs
bHNjaGFmdDogR8O2dHRpbmdlbiwgQW10c2dlcmljaHQgR8O2dHRpbmdlbiBIUiBCIDMxNjANCj4g
PiBHZXNjaMOkZnRzZsO8aHJ1bmc6IEhlaWtlIEpvcmRhbiwgRHIuIFV3ZSBLcmFja2Ug4oCTIFVz
dC1JZE5yLjogREUgMjA1IDE5OCAwNTUNCj4gPg0KPiA+IGVtbGl4IC0gc21hcnQgZW1iZWRkZWQg
b3BlbiBzb3VyY2UNCj4gPg0KPiA+IC0tDQo+ID4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGdy
b3VwIGFuZCBzdG9wIHJlY2VpdmluZyBlbWFpbHMgZnJvbSBpdCwgc2VuZCBhbiBlbWFpbCB0byBr
ZXJuZWwtdGVhbSt1bnN1YnNjcmliZUBhbmRyb2lkLmNvbS4NCj4g
