Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E06554CEFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbiFOQrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 12:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFOQrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:47:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5198842A3B;
        Wed, 15 Jun 2022 09:47:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwabz3Yz2KbqtDisoQ5yHPR2l7ERpunfag8OOWwHoXoY+OJBeKvmzsKBEAVMB9Unr9zbWJ1WZWZbckTnwYF/MDVmFflSVxAqBbe+usuDOE9YYC8UBiiKpUeeSvkyRU5qyKKJxl/05aNk3GurWg9CGXqUWhw4ft30OQrD1AJqSQLhXoQ6mMgZKHbfyyTqiuPeIFrgvi3JLugZ2acO7xWouASSQLRrMJ6pHl76auFR0tMtnPceCKjHV84q6ubhTQ97cOCh1xaQxjQDDZT9ca7LdPSDGbYkAdhfmk7nDAfAkpluNSg2DJfgNkb5Ozp6Q6XL11wPOZI1N+d96ce6ofEw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D52ubuPB6vIqNEpXsVdO9NKahx9qbZNJm133Enmnc0Q=;
 b=LLPNqjf8kbug0ZXzXhDP+yoNLCc8+9r9dix/XZitC8K3VBky8SHVOJIaNIgy8irc2oxSvSon1jX2WgONZ+AegqEC7HrKgG+KMIqOU5gssGQnAf+dfv4OhzeBvCHjS1xC47nTuZtOpifCYPfK4tAiQZGkSHO+lqPCRJEV/eixSnMxxxD41fqLP98c1dfehQGO1QTPW5XFN7yiASUAOJ7PWF39DHQ4C3YE16e6UaC5xwFyqJ504Lltz7KtkFCpGX/ZEOWmMdaPgEC9YjSe3cm3ZY0AyxifGAun10Gf4X1cOH6+RucOTePkgMj7mMdza1OW9vRS5aPFGMHsWPp+mR+cag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D52ubuPB6vIqNEpXsVdO9NKahx9qbZNJm133Enmnc0Q=;
 b=AFkeTKKZD+kOUJmG4O8xFiK8IVm6v4cmBkrU8qABKJPNT4uNIBask27tbHU2JFqT5s/NawfwbeCXdNoQxrnm0hiZ+z0orOygbNgH7kCRQv3SNtKVtxCfHplRJLBvClo7eqCVNricgtcjol8pNwVJb2LNOoMb/dQVAE6wm3OGDVA=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN6PR05MB3441.namprd05.prod.outlook.com (2603:10b6:405:47::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.11; Wed, 15 Jun
 2022 16:47:06 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 16:47:06 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Thread-Topic: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Thread-Index: AQHYdfv3YX54vWzxvUGMIUQ+ms6N9q1N9KwAgAAJcICAAAJmAIAAGdqAgAGfAYCAAQnAAA==
Date:   Wed, 15 Jun 2022 16:47:06 +0000
Message-ID: <5C19AED5-C2A9-4AD9-A2E3-757751568496@vmware.com>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-3-axelrasmussen@google.com>
 <20220613145540.1c9f7750092911bae1332b92@linux-foundation.org>
 <Yqe6R+XSH+nFc8se@xz-m1.local>
 <CAJHvVchdmV42qCgO6j=zGBi0DeVcvW1OC88rHUP6V66Fg3CSww@mail.gmail.com>
 <C1C5939A-B7D2-49E7-B18B-EE7FEFE9C924@vmware.com>
 <CAJHvVche7ZKOpO=8PY2frtJ5nHyzo=Yt+qT1OmYg8ZOUujkPfA@mail.gmail.com>
In-Reply-To: <CAJHvVche7ZKOpO=8PY2frtJ5nHyzo=Yt+qT1OmYg8ZOUujkPfA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7b36481-f448-42fa-affe-08da4eeeae64
x-ms-traffictypediagnostic: BN6PR05MB3441:EE_
x-microsoft-antispam-prvs: <BN6PR05MB344195CDA5C647F45311EDFED0AD9@BN6PR05MB3441.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFgM3vaDsAt/MlLw/TJfFhoWtvFJ3szNOpUmUG3EKhgt9pcSR5H8j8VNhwHFInADhKtcjk5M6l7B5BUOvP2Y0GkEzuKFaW0PnuvLAzByXpxVRYwS8K7pZtZ5EZqO/Ij/MWojl06xWW6imJoZQkkf8t56uZL9eMV/2Jg5KA0N3EycbuRS0fKUnHOnOm4pTggoj405FP86nTsP66igGmssZGZ1ilogxUNe0a4Enb2aQKncjjHZH9+9pZjedyJ4Rj1MkYZNDONG9tJtbM+pDoP13xl2Zov5Dtyix+xMPzKnZ3Cb+BuHZ3IJyz5pCBti4wn/GbWxX0PZl5fSPxixpDonajN3EpDGdkptjI4IOMHOBx4/Cir5tsS2MDwuF42sydNU41GM3KIsUvnfiP9pFNwKRU9A73KhB8R6NLSh5yHyxlftNeKNb7D8iKtav5Sf3d/3mG2TA7zbem3QYJq825M4HqoV/kiLOGgJc2MRICXWq+Hj0qo26cjasmlrviJ1QXDUEjrLQfGsmv88EbA5+TnFKW0Nrbm8ywRQ5jDkShlcKrxbKnC4o0r5d6M/e0ltqxf9GadAE400kLa2hcPKfwBAeGPLUGnFwouBgAE70WvndXwCYX9pXVPLjnZKlIqXxTNHJZAtRolC3Ulmp+QXf4cfCBtAMkU/MXKWQ762lKlHONVKmw/ZBSouew/YL98/lep205NDoxdBctU+gXd/ceqZkXO2Kkf9uUUvWPhYpqSJom/64tQbb1j8ew1m8hxG+a6W8oziVfnF8dGmqkDQFRUOKfiLL5ajs3MY6EZgqeAuxpg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38070700005)(6486002)(71200400001)(8936002)(122000001)(8676002)(86362001)(2906002)(66476007)(64756008)(186003)(66946007)(2616005)(508600001)(6512007)(6916009)(66556008)(66446008)(76116006)(26005)(4326008)(54906003)(6506007)(7416002)(83380400001)(53546011)(38100700002)(33656002)(5660300002)(316002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1l3L05pdjZIeUNZUlZWQXUvckhtSm9YMm5lMnlGT3RwelQwYmRqWitvcjFm?=
 =?utf-8?B?UmNCZFB2ZmJ3MTZOZnVBQVQrNlZ6OStqeHE4VjJPTS9mZTJzN0FxRDFwRGgr?=
 =?utf-8?B?UlVIZStwc1hIV2FGd25RUTNQL3RLVEgxY2o3QWlYUzhma01Rb2lZZTZjdSt1?=
 =?utf-8?B?dEMzbjJUa2M4bld4V3ZwdFl5UnhVTDlnVHhqTEI5bytMdEFsSWluUloxYjZU?=
 =?utf-8?B?TVJGRG1zdEN3ZWFIYlNleG15c0NKWWp2Z1hhb2sxMGUyaW9aUjRScDhtbUda?=
 =?utf-8?B?c2JzSTgwM0M2dHZxYWJMVzJqWUVKZTR0NHVwalQ3eFl1M2F1a3p1Z0hyTW4v?=
 =?utf-8?B?dHo0U3JSRzBoTzFWbmxOMHhaS0lpd2F4T3pWa3JlQ2R3QTk2UkFSUFRTMVZ5?=
 =?utf-8?B?YmpNU2tZZWJ4bHd3MWk1Y0pmRjI4c3FYdGRQNVdBZjVOWXN3dFpuY2hIZlFB?=
 =?utf-8?B?YXhVa1hsVGoySGpqYWhNWkc0OHJHdGNXTWtkL3JJdEVMUWlaWW9YOHpVdXJq?=
 =?utf-8?B?MVM0enZLNDRSekxZQkNYN1ZXcUxkdzBSSDZ0cUp5cFJzc0gwZHRGcmVwSElm?=
 =?utf-8?B?MkRUWW9rNjh0d0tsR3pWT3hDaXNGOWg5cEpMa2FFZUxxRWswL2FPcFNDR0pu?=
 =?utf-8?B?bVhiMkVwaUFySFFiOUZ2TTdYUUVxOFppWFhSNjN6a0hLMXNRc2p0aVFPZDY1?=
 =?utf-8?B?a1BpcXZRQUhWWWIzM3dBRzh5ZHNVYUJiWW9yU2p2ekZYVDlxaDBZRjJQekJM?=
 =?utf-8?B?c29Jdk9BajlrZWRsQnkzZFJaY1FvalhLdDlkN2E3b1R1MDE5Y1VFbWt5Rmlu?=
 =?utf-8?B?a3duTDFaV0l0dXppWTIvOGxaWCs4dWpSR1BMNnJvZjVjMjU5Tk9QbHVESjdk?=
 =?utf-8?B?WXdvWjN2cS9NNlVVMEJoYjI4aERQYXZJZWpsVWlSakpEVWJxaWRXb0NSVkNY?=
 =?utf-8?B?NVhzZmlmT2FHLzZIUlhlemxuKzRqVm5uL044RWdHMzM3aGwxYWxUVyt5bGdw?=
 =?utf-8?B?UlRlRUdlUXhZQktna1oxazArTGFlOU81clpKcnJZeGNNdndNUW5KeWV5Q1F3?=
 =?utf-8?B?UkkzeUpWVmlDWm41Wll4eWhBbkcvOUI2TGpTQXVTNlFNVk11L1piWGk0N3VC?=
 =?utf-8?B?OUdYL2hYNTZjd0IzNnJUUGtVQjlVVVVsRERkc0dtSXRPRlBIUGZnZGI0dEhp?=
 =?utf-8?B?ZWRDbVgzRkx2VmVVRDZaRmtUVHFPK2wrYTBwemdpcTRyVXhjNDd3Ni9sNnlZ?=
 =?utf-8?B?dDlNUUdBa1BwNmpUT0ZoN1g4VG5MS2dFc0RWeWZqS0lZWWhvTXNYQ1F2U2dw?=
 =?utf-8?B?b3NJa2V2eXBLaXM4cEkxL3hzOVplcDRyN1dpeHErSlBHczBncFVpYXJWZVNT?=
 =?utf-8?B?MHF5UnJOUFBCSDVmRE1odnlrbHp4TjlXY3h0M2l2ODcyMmcxUnA0eUp0cGQr?=
 =?utf-8?B?QWcvKytXQ0loTTBXaVJKYkwzZUxYN25qUC9BSFAwT0N5Q0pvSkNxanErYkhu?=
 =?utf-8?B?WDg3V0tJa0R3RmVOVHFUSlpER2VzcktJNkZ5emdaeGZGNE9xb3QvVDgrMzQ5?=
 =?utf-8?B?NFRmNERWOHlhcUpnM0hkeVZPNTBnYytKOERJTWJYV3ZTY3Z0TUY2cmROR21q?=
 =?utf-8?B?dEtVeDJRajFuZHJVeHZBbWIxOGdQeklHeTRYOTlUaW1qUUJkNTduN1MreHZp?=
 =?utf-8?B?OWNYQ0NpNHR3cjB6M0JsTDNkU2xDTTJ5RytHU3BQUE1iRkNSYmNvNExNSkpW?=
 =?utf-8?B?SmhkRmN4RXpKSlBnQjIyd0l3OGdBZUpDSy90bHlscGpjeW9SbFB0ZEF2R0Jz?=
 =?utf-8?B?UGhySHdldjZ1S2V5aXM3TDhvT0FVSnBkUy9TNC9OM0tJVEFoUFE4UGVod2Zy?=
 =?utf-8?B?NUI5c2JFWkRFWkFkZS9zelU4NXlUZ3BSdUw3WVpobHYvYU9XYW9RMTdzQk1n?=
 =?utf-8?B?ZDVENzdYdHROaVVweEdJT0JkaC9mVTdDbExsRldrNnFYZFdPWFByVnBoMTd1?=
 =?utf-8?B?TENFd1NqQk5JVkx2TzZldXd2OXU2ckpoc3l6MmdidnFUOWtCb1R5Qk9BcjRQ?=
 =?utf-8?B?T2JweVZrN2NZWlRsMjZ4NUVpWGpISG9aWDcwQnJQRUhKRHZGbDlEcWF3eXVI?=
 =?utf-8?B?OHRwTVIxWnd2MU9IbEVFa0pSZVY4OW9Ld3RRRGtwVlpBUzBVaHhPa1RxTWFD?=
 =?utf-8?B?bThlcXJ0d2w5Y2Ywd2Z4c0NpM0xsS0tRK3F4U0ZxUFVkN0t3dzJPcWgvYmpo?=
 =?utf-8?B?c0d6RlBBY1Z0cFdsZHBJNGRnMGtNOEtaQmg1OG1SNktweXJsdnQvMUQyQ0RX?=
 =?utf-8?B?eUFIZGFhY09sVElNNU9Kd2w4QjNqelhTNkNIMys3YkVTKzIxZWVQUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DA8E03EFBAD1844982121CDF3FBFCB2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b36481-f448-42fa-affe-08da4eeeae64
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 16:47:06.0895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIVfTypjT0b8elVG2csijnZd+3IKigyw/2VfnJ93lWnKhbLEoSAZDrx788k7whjM9undicNVwbJngwBReEPS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB3441
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gSnVuIDE0LCAyMDIyLCBhdCA1OjU1IFBNLCBBeGVsIFJhc211c3NlbiA8YXhlbHJhc211c3Nl
bkBnb29nbGUuY29tPiB3cm90ZToNCg0KPiDimqAgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIE1v
biwgSnVuIDEzLCAyMDIyIGF0IDU6MTAgUE0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4g
d3JvdGU6DQo+PiBPbiBKdW4gMTMsIDIwMjIsIGF0IDM6MzggUE0sIEF4ZWwgUmFzbXVzc2VuIDxh
eGVscmFzbXVzc2VuQGdvb2dsZS5jb20+IHdyb3RlOg0KPj4gDQo+Pj4gT24gTW9uLCBKdW4gMTMs
IDIwMjIgYXQgMzoyOSBQTSBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+
PiBPbiBNb24sIEp1biAxMywgMjAyMiBhdCAwMjo1NTo0MFBNIC0wNzAwLCBBbmRyZXcgTW9ydG9u
IHdyb3RlOg0KPj4+Pj4gT24gV2VkLCAgMSBKdW4gMjAyMiAxNDowOTo0NyAtMDcwMCBBeGVsIFJh
c211c3NlbiA8YXhlbHJhc211c3NlbkBnb29nbGUuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4+
IFRvIGFjaGlldmUgdGhpcywgYWRkIGEgL2Rldi91c2VyZmF1bHRmZCBtaXNjIGRldmljZS4gVGhp
cyBkZXZpY2UNCj4+Pj4+PiBwcm92aWRlcyBhbiBhbHRlcm5hdGl2ZSB0byB0aGUgdXNlcmZhdWx0
ZmQoMikgc3lzY2FsbCBmb3IgdGhlIGNyZWF0aW9uDQo+Pj4+Pj4gb2YgbmV3IHVzZXJmYXVsdGZk
cy4gVGhlIGlkZWEgaXMsIGFueSB1c2VyZmF1bHRmZHMgY3JlYXRlZCB0aGlzIHdheSB3aWxsDQo+
Pj4+Pj4gYmUgYWJsZSB0byBoYW5kbGUga2VybmVsIGZhdWx0cywgd2l0aG91dCB0aGUgY2FsbGVy
IGhhdmluZyBhbnkgc3BlY2lhbA0KPj4+Pj4+IGNhcGFiaWxpdGllcy4gQWNjZXNzIHRvIHRoaXMg
bWVjaGFuaXNtIGlzIGluc3RlYWQgcmVzdHJpY3RlZCB1c2luZyBlLmcuDQo+Pj4+Pj4gc3RhbmRh
cmQgZmlsZXN5c3RlbSBwZXJtaXNzaW9ucy4NCj4+Pj4+IA0KPj4+Pj4gVGhlIHVzZSBvZiBhIC9k
ZXYgbm9kZSBpc24ndCBwcmV0dHkuICBXaHkgY2FuJ3QgdGhpcyBiZSBkb25lIGJ5DQo+Pj4+PiB0
d2Vha2luZyBzeXNfdXNlcmZhdWx0ZmQoKSBvciBieSBhZGRpbmcgYSBzeXNfdXNlcmZhdWx0ZmQy
KCk/DQo+Pj4gDQo+Pj4gSSB0aGluayBmb3IgYW55IGFwcHJvYWNoIGludm9sdmluZyBzeXNjYWxs
cywgd2UgbmVlZCB0byBiZSBhYmxlIHRvDQo+Pj4gY29udHJvbCBhY2Nlc3MgdG8gd2hvIGNhbiBj
YWxsIGEgc3lzY2FsbC4gTWF5YmUgdGhlcmUncyBhbm90aGVyIHdheQ0KPj4+IEknbSBub3QgYXdh
cmUgb2YsIGJ1dCBJIHRoaW5rIHRvZGF5IHRoZSBvbmx5IG1lY2hhbmlzbSB0byBkbyB0aGlzIGlz
DQo+Pj4gY2FwYWJpbGl0aWVzLiBJIHByb3Bvc2VkIGFkZGluZyBhIENBUF9VU0VSRkFVTFRGRCBm
b3IgdGhpcyBwdXJwb3NlLA0KPj4+IGJ1dCB0aGF0IGFwcHJvYWNoIHdhcyByZWplY3RlZCBbMV0u
IFNvLCBJJ20gbm90IHN1cmUgb2YgYW5vdGhlciB3YXkNCj4+PiBiZXNpZGVzIHVzaW5nIGEgZGV2
aWNlIG5vZGUuDQo+Pj4gDQo+Pj4gT25lIHRoaW5nIHRoYXQgY291bGQgcG90ZW50aWFsbHkgbWFr
ZSB0aGlzIGNsZWFuZXIgaXMsIGFzIG9uZSBMV04NCj4+PiBjb21tZW50ZXIgcG9pbnRlZCBvdXQs
IHdlIGNvdWxkIGhhdmUgb3BlbigpIG9uIC9kZXYvdXNlcmZhdWx0ZmQganVzdA0KPj4+IHJldHVy
biBhIG5ldyB1c2VyZmF1bHRmZCBkaXJlY3RseSwgaW5zdGVhZCBvZiB0aGlzIG11bHRpLXN0ZXAg
cHJvY2Vzcw0KPj4+IG9mIG9wZW4gL2Rldi91c2VyZmF1bHRmZCwgTkVXIGlvY3RsLCB0aGVuIHlv
dSBnZXQgYSB1c2VyZmF1bHRmZC4gV2hlbg0KPj4+IEkgd3JvdGUgdGhpcyBvcmlnaW5hbGx5IGl0
IHdhc24ndCBjbGVhciB0byBtZSBob3cgdG8gZ2V0IHRoYXQgdG8NCj4+PiBoYXBwZW4gLSBvcGVu
KCkgZG9lc24ndCBkaXJlY3RseSByZXR1cm4gdGhlIHJlc3VsdCBvZiBvdXIgY3VzdG9tIG9wZW4N
Cj4+PiBmdW5jdGlvbiBwb2ludGVyLCBhcyBmYXIgYXMgSSBjYW4gdGVsbCAtIGJ1dCBpdCBjb3Vs
ZCBiZSBpbnZlc3RpZ2F0ZWQuDQo+PiANCj4+IElmIHRoaXMgZGlyZWN0aW9uIGlzIHB1cnN1ZWQs
IEkgdGhpbmsgdGhhdCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gc2V0IGl0IGFzDQo+PiAvcHJvYy9b
cGlkXS91c2VyZmF1bHRmZCwgd2hpY2ggd291bGQgYWxsb3cgcmVtb3RlIG1vbml0b3JzIChwcm9j
ZXNzZXMpIHRvDQo+PiBob29rIGludG8gdXNlcmZhdWx0ZmQgb2YgcmVtb3RlIHByb2Nlc3Nlcy4g
SSBoYXZlIGEgcGF0Y2ggZm9yIHRoYXQgd2hpY2gNCj4+IGV4dGVuZHMgdXNlcmZhdWx0ZmQgc3lz
Y2FsbCwgYnV0IC9wcm9jL1twaWRdL3VzZXJmYXVsdGZkIG1heSBiZSBjbGVhbmVyLg0KPiANCj4g
SG1tLCBvbmUgdGhpbmcgSSdtIHVuc3VyZSBhYm91dCAtDQo+IA0KPiBJZiBhIHByb2Nlc3MgaXMg
YWJsZSB0byBjb250cm9sIGFub3RoZXIgcHJvY2VzcycgbWVtb3J5IGxpa2UgdGhpcywNCj4gdGhl
biB0aGlzIHNlZW1zIGxpa2UgZXhhY3RseSB3aGF0IENBUF9TWVNfUFRSQUNFIGlzIGludGVuZGVk
IHRvIGRlYWwNCj4gd2l0aCwgcmlnaHQ/IFNvIEknbSBub3Qgc3VyZSB0aGlzIGNhc2UgaXMgZGly
ZWN0bHkgcmVsYXRlZCB0byB0aGUgb25lDQo+IEknbSB0cnlpbmcgdG8gYWRkcmVzcy4NCj4gDQo+
IFRoaXMgYWxzbyBzZWVtcyBkaXN0aW5jdCB0byBtZSB2ZXJzdXMgdGhlIGV4aXN0aW5nIHdheSB5
b3UnZCBkbyB0aGlzLA0KPiB3aGljaCBpcyBvcGVuIGEgdXNlcmZhdWx0ZmQgYW5kIHJlZ2lzdGVy
IGEgc2hhcmVkIG1lbW9yeSByZWdpb24sIGFuZA0KPiB0aGVuIGZvcmsoKS4gTm93IHlvdSBjYW4g
Y29udHJvbCB5b3VyIGNoaWxkJ3MgbWVtb3J5IHdpdGggdXNlcmZhdWx0ZmQuDQo+IEJ1dCwgYXR0
YWNoaW5nIHRvIHNvbWUgb3RoZXIsIHByZXZpb3VzbHktdW5yZWxhdGVkIHByb2Nlc3Mgd2l0aA0K
PiAvcHJvYy9bcGlkXS91c2VyZmF1bHRmZCBzZWVtcyBsaWtlIGEgY2xlYXIgY2FzZSBmb3IgQ0FQ
X1NZU19QVFJBQ0UuDQoNCkkgYWdyZWUgYWJvdXQgQ0FQX1NZU19QVFJBQ0UuIEkganVzdCBrbm93
IHRoYXQgaWYgdGhlIC9kZXYgYXBwcm9hY2ggaXMNCnRha2VuLCB0aGVyZSB3b3VsZCBiZSBldmVu
IG1vcmUgcHVzaGJhY2sgZm9yIHVzZXJmYXVsdGZkMi4NCg0KV2hhdGV2ZXIu
