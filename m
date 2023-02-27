Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8426A4F89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 00:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjB0XJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 18:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjB0XJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:09:16 -0500
Received: from CY4PR02CU007-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11011010.outbound.protection.outlook.com [40.93.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5A8EC73;
        Mon, 27 Feb 2023 15:09:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO/TC+IHRl6eVManlQpyGPaeOiptKJd1WvzAcApswlFhYXwUpmCK0pYOjAHxeZmw8319plVy0a9veMJo1paeMvubQ4sDputXI/Lyys68HIdfEqrIXMNh5p047K8Hb3JC38N5je+5SX/yaJdJnt2r7OPHM1HdyoQZ5Bwp+Jdyb9uEDXP8Nmm36PFBZLtWEqfiivI199OLkW2+ljY+i/QtVfSq3QFFSIMnG8CiovWZYbIgE/wCT4VI6fq6nli2vo+KXmb6gQdQRjemcf58hCdyd79OvBwagtij0rl7CAaIaSOThbAoR0ozEwcAVr8J4ojMTpwx9mCu7OYRGMjp8yR9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJMt0vQCd8fH48l6MT43aEcoI8Cu/Kk2h/+dNR4KI1c=;
 b=NKwA634WTz7w8YUZ6wT5lOvXvmm9HoaEUdES6lI82mTiDV+kQchv468T8KYqkIrZFiUm6V5vUTh755vJGzZ6ROjMSczQfIqo+DqADZs4S2GDRAhmQTrtiUbhQT1oAdtrHEcq5Tayvma/w0T9LFVtIuabLQWdn7IMKhtehhOrowCMBufy0VX/NkjQAwnxgwt0WIuFC5wIpdEIc2+HOldX1YA5ICpsYQX8jkYFbI1D+fDZGzHJIL8GQqXbM/kKjArx4XHB8u/N9oyFCbwlVgt17FQqVSSoG833OM2NU7u3MwMLnzh5aj6/7ILxQnhjR2PzFZSHdQl2Ax+3/e5TLZDgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJMt0vQCd8fH48l6MT43aEcoI8Cu/Kk2h/+dNR4KI1c=;
 b=dIXQQbejydgMKhH+/kbVntzqZ5vayljbMAemyRIvi5Wrmz2XkRtzgkgfbTXqpZma9ibFJTcMqmCe4w+FZw3t/vJ1kAlf7TVECkO6jECqNeE6Ax6yb5S5Hpwsy5sL+jjytbGDB1urPqQdU+BZLRFlVzCif2DNLkMln0GUdsUn+9A=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SN6PR05MB5728.namprd05.prod.outlook.com (2603:10b6:805:b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 23:09:12 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%3]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 23:09:12 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Thread-Topic: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Thread-Index: AQHZNvnMjIrwR8b570Ch3VOm2txWlq7WZLkAgAGKnwCAA4VRAIAAyUIAgACnuwCABo50gIAAHuYA
Date:   Mon, 27 Feb 2023 23:09:12 +0000
Message-ID: <5D5DEEED-55EB-457B-9EB7-C6D5B326FE99@vmware.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
 <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
 <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
 <c15446c5-eedd-690f-9dae-2bc12ee9eb78@collabora.com>
 <F73885A1-14AE-4820-876B-A8E6DC6D19CC@vmware.com> <Y/0eIUIh81jK9w2i@x1n>
In-Reply-To: <Y/0eIUIh81jK9w2i@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SN6PR05MB5728:EE_
x-ms-office365-filtering-correlation-id: a68cf528-f99f-4480-a03b-08db1917a37e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXww2Oa0hEKzgYP26Ikqzv41+XKA1j0vskL33rMxlxtYPu9cUG93DH5mmRnmOkdLlwtssca40oWMoPy0YuDRlb79UqcKPSd2io6B27HkjwqPokgFDxPqwTdPTaeT3VSGWFWq1yE5GySef7LuSKHS6eG67TyVn28DIATDvMHDewCUO1+Ywbkyeuqg+SfJMliS1Woxvq0/Crq3MVc7PiMA9TuijmqCwbk9QJSysZHjNY7ZjxY3SR1/Rh4jg4O1c1UK1Hmh3Q7iYK1ibiJ8N1bcJXd70WcODJ0UwoADkMlCCL3zz/eH8eYvF8Ex664oxNWWyrXyJyP4zJozxRX2vlVL5UcgNGo/j4aPYxXTxfLC61GW4fKev5l8zIz1OoPiGRBW1o6MfzwQqTajac1MKIJMFA09R3ur3W1kLgYRY9jF3yikZVYGMi6C4wBetzksIADPA4t3rlYBSx+0ZYWplLI2Q7kMgSUsdEA3oXHUhgzzpMg914ZW4LVilH+QsNE4cIibvogPCAz86p88VCP78VDZdzs08LZ41+1YtxYvJA2F0Vyw0SKfi9tp2wKyKvaEx+izd6ZHocPucL+t2DU8QLi/Pk/m05vqWxy3LxqfC8hjtp3DDc0P5/y2/y6viFetj3ca7wbJggvjAtGg6LYKrcl5Ox5H4Wcw/tIPaN81dMRSPa1DJ2tv1vo1y7WOyy35jPwn2dbq80y1ovESgI6s2+GkkD1zVsx7Jq4NXMywsLOeD3Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(478600001)(6486002)(2616005)(71200400001)(53546011)(54906003)(316002)(186003)(6512007)(26005)(6506007)(66556008)(66476007)(76116006)(64756008)(83380400001)(8676002)(4326008)(66946007)(66446008)(5660300002)(41300700001)(7416002)(7406005)(8936002)(122000001)(38100700002)(6916009)(86362001)(36756003)(38070700005)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWdlUDE5SHlRb011OVlEZCs4MTlubGpUazNPZG9sM2tpWkRXVm95VGdjRjB1?=
 =?utf-8?B?NlFBR2g1SmRSZitGQzBrM2FMcU5YWVpiY0ZCSW91Q0tHZCtFUE1DVW1lUGd4?=
 =?utf-8?B?UWxvMk5BVmk0UkNqRURmM3hqYnhGbGpCeG1QYkFyVlhaYkVmaVlNS05xMmdP?=
 =?utf-8?B?WTR0QmlOR1R3cTh5dzBsSDlmWGx0WUxpT2k2OXNZamVscE02RTlwTHpxTFNQ?=
 =?utf-8?B?NjZ4a2ZGRlpNNVhkSzlXaVZvMnFlMHYxekoycmVsRjVsWG9SeWlqT0xVd3lK?=
 =?utf-8?B?VVZYN1QwUzljNXhGbVN2Mld1NmRqTmh2SFVqUTlDRTdGeUFqODBzMFdlM0lj?=
 =?utf-8?B?WExUbjQ2QU1WdTdTZ3gxTnpkQ2crK3pIYVFnc3ZNcmhCNkxKeUlDb3NJT0hR?=
 =?utf-8?B?UWtzSktrTm1KNCtyc2pkY2d4eGxUbTMyZG5SSzlqT0JDRHdDRkpmQ2F0Q3dw?=
 =?utf-8?B?SDR5S0tXd2dNVml3ZnFEaVFwWStBQ3kwUC8rOTRQU3BZNG9CVFcva1JhOHc1?=
 =?utf-8?B?YUtuK1huVWp0UDI5aFBwL0YxTzIzYzA1Y2x5RGRQRTFNem1sL0gyZ1pPQ1RK?=
 =?utf-8?B?OUMyNzJmUWJXeE4yblR5RlUvM2k4ZXdIOFRFYW5yREF4WXd4SFRRK3I2dTlp?=
 =?utf-8?B?MGRScVAyYXRoRkZYMGREdTRvMGxQaUsrdjFsdUJEczRuQUhwZ05YTUk1MC9Q?=
 =?utf-8?B?MkFZQS9QVFNqZm1pWEM3M2VOWVg1NGZsZkNEVUMyV2UrMklXc0FKdmU5dlJD?=
 =?utf-8?B?MllwM082cWhxMXphSEVQZTlvTmcrNWFGTjN6NXF1Unk3b0dEZTY1RUxpcWxm?=
 =?utf-8?B?SDZUTFh5ektISVBCMnV6TjJhUm9XWHVYeWJhbmVxVVArUHhPOWFSZ1VrTklC?=
 =?utf-8?B?c3g0cSthQWJDelkyRGJhdWdidWdVYTBNR1doN2tPWWRWbnBoakM2cDBrcm5O?=
 =?utf-8?B?TzRUZ1BXN1J3VFZxQUNxVmtZRWxYN0VIaTdWMDNzZmtURGxRKzJVQUJCbU5v?=
 =?utf-8?B?d09uNEQ5Z0hYQW5jeWZUY3pxc3YxY21BV2VEL0pvRUxMYzNON3VOT2g4OUV2?=
 =?utf-8?B?L0tBTStiRmdWSUcvMlBSN3JXbm5mVzNFaEQvaTV2SUpZTzBxekprSXQyb1pS?=
 =?utf-8?B?NU5nQWJ6UlJybkJMMWw0OWVIWUhsWFkwNzhwQTI3Q2Rxa0ZsSDErYXhJVGNQ?=
 =?utf-8?B?cGFmTHNDU0hCY3lrWStMR3NLK0hOY1BVUElXaGNLakp0ZjQzZWkxQnlQQVFW?=
 =?utf-8?B?WDBmQnB4M25ZK3JhL2U2VmxBSFBJU2Y4cFZKY1lRdmRGMXEwU0NLengzQ281?=
 =?utf-8?B?blBEdzVpV3VDZW9jaGovZGdDYkJ5TnpJV09FK3lIWWNZV2tUVndEaFVaSCtX?=
 =?utf-8?B?M21IWlhvSjJyUUFPZXZlR1RNUTNNQ2lJcEtudWlaVVZPR3p6MERxWURSOVVu?=
 =?utf-8?B?VVhlSGRnZEhKOWZxWnJ5dTlsUUVvK2M3N09HbTRxQUlodFl2ZG94SzNHREhs?=
 =?utf-8?B?ajFrL2lEV2dvemhOMUwzN2RjTzdReFMzWjlrc2dTdEt0MEF2WFllUVRoVWJo?=
 =?utf-8?B?M044bFFSWUZRbE9NeE5KRWgzc2hnOTNUNU1OZ3Jycys1cmhCZmdtRXZWZXRO?=
 =?utf-8?B?aURJTXIrVVB2Q1RIWHZHamZ5b1JGWlY5Y2YwVGpqaHU2UGdKR044WjZuaVdS?=
 =?utf-8?B?RVVTT1VsamFVTE84RVYyRlZSeXhjT2F1VjlNVVJGeXFtM3lPUzlWd2gvbFBv?=
 =?utf-8?B?bzJYLzNPMTZaOHMwSlVjMmZtRGxNWFFuS2o4dnBoSkwwdkhVendYb3I0WDQ2?=
 =?utf-8?B?UXBFVnB6OGZkaWpVNVNWOGJjcjBjYUgzalZ5TytsVGF4UWRpb1dHbDg0TDJw?=
 =?utf-8?B?YzQxN2t3SGppQkZ0Vk1HTC9nRlpzKytNT2xnVlFZOSsrTG9pbEZDOWpIQVdj?=
 =?utf-8?B?Tm1ta29vUmFkeDRmQ2s1RWo1WWdUeFBINnBBOEtpQlY3bnBETElwSkhlamIy?=
 =?utf-8?B?czVpYlR4OHA5Nzd4L2FiajJjaVdDZ1g1SkpiZ2sxUXRLVGZ6ck9JRUhTR3Zl?=
 =?utf-8?B?akpad2JUandtZnkxenlPeFdsNVVqcEJ3SlFRVndIOWhnM20wZWJqaVJzakV3?=
 =?utf-8?Q?sCpo90QQSwNGLY+H1rd+2SSdF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4FAE66B4AC89E479227FE650475EDE8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68cf528-f99f-4480-a03b-08db1917a37e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 23:09:12.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QEK/4SAe5joSfpnQLWlCtf0YUEtWNIiOKQGWrW9MYcTIOO5M1H772Mw085OW2O+hiZZFU132w77EhuZ+w1Cjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB5728
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gRmViIDI3LCAyMDIzLCBhdCAxOjE4IFBNLCBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhh
dC5jb20+IHdyb3RlOg0KPiANCj4gISEgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIFRodSwgRmVi
IDIzLCAyMDIzIGF0IDA1OjExOjExUE0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBGcm9t
IG15IGV4cGVyaWVuY2Ugd2l0aCBVRkZELCBwcm9wZXIgb3JkZXJpbmcgb2YgZXZlbnRzICBpcyBj
cnVjaWFsLCBhbHRob3VnaCBpdA0KPj4gaXMgbm90IGFsd2F5cyBkb25lIHdlbGwuIFRoZXJlZm9y
ZSwgd2Ugc2hvdWxkIGFpbSBmb3IgaW1wcm92ZW1lbnQsIG5vdA0KPj4gcmVncmVzc2lvbi4gSSBi
ZWxpZXZlIHRoYXQgdXRpbGl6aW5nIHRoZSBwYWdlbWFwLWJhc2VkIG1lY2hhbmlzbSBmb3IgV1An
aW5nDQo+PiBtaWdodCBiZSBhIHN0ZXAgaW4gdGhlIHdyb25nIGRpcmVjdGlvbi4gSSB0aGluayB0
aGF0IGl0IHdvdWxkIGhhdmUgYmVlbiBiZXR0ZXINCj4+IHRvIGVtaXQgYSAnVUZGRF9GRUFUVVJF
X1dQX0FTWU5DJyBXUC1sb2cgKGFuZCBvcmRlcmVkKSB3aXRoIFVGRkQgI1BGIGFuZA0KPj4gZXZl
bnRzLiBUaGUgJ1VGRkRfRkVBVFVSRV9XUF9BU1lOQyctbG9nIG1heSBub3QgbmVlZCB0byB3YWtl
IHdhaXRlcnMgb24gdGhlDQo+PiBmaWxlIGRlc2NyaXB0b3IgdW5sZXNzIHRoZSBsb2cgaXMgZnVs
bC4NCj4gDQo+IFllcyB0aGlzIGlzIGFuIGludGVyZXN0aW5nIHF1ZXN0aW9uIHRvIHRoaW5rIGFi
b3V0Li4NCj4gDQo+IEtlZXBpbmcgdGhlIGRhdGEgaW4gdGhlIHBndGFibGUgaGFzIG9uZSBnb29k
IHRoaW5nIHRoYXQgaXQgZG9lc24ndCBuZWVkIGFueQ0KPiBjb21wbGV4aXR5IG9uIG1haW50YWlu
aW5nIHRoZSBsb2csIGFuZCBubyBwb3NzaWJpbGl0eSBvZiAibG9nIGZ1bGwiLg0KDQpJIHVuZGVy
c3RhbmQgeW91ciBjb25jZXJuLCBidXQgSSB0aGluayB0aGF0IGV2ZW50dWFsbHkgaXQgbWlnaHQg
YmUgc2ltcGxlcg0KdG8gbWFpbnRhaW4sIHNpbmNlIHRoZSBsb2dpYyBvZiBob3cgdG8gcHJvY2Vz
cyB0aGUgbG9nIGlzIG1vdmVkIHRvIHVzZXJzcGFjZS4NCg0KQXQgdGhlIHNhbWUgdGltZSwgaGFu
ZGxpbmcgaW5wdXRzIGZyb20gcGFnZW1hcCBhbmQgdWZmZCBoYW5kbGVycyBhbmQgc3luY+KAmWlu
Zw0KdGhlbSB3b3VsZCBub3QgYmUgdG9vIGVhc3kgZm9yIHVzZXJzcGFjZS4NCg0KQnV0IHllcywg
YWxsb2NhdGlvbiBvbiB0aGUgaGVhcCBmb3IgdXNlcmZhdWx0ZmRfd2FpdF9xdWV1ZS1saWtlIGVu
dHJpZXMgd291bGQNCmJlIG5lZWRlZCwgYW5kIHRoZXJlIGFyZSBzb21lIGlzc3VlcyBvZiBvcmRl
cmluZyB0aGUgZXZlbnRzIChJIHRoaW5rIGFsbCAjUEYNCmFuZCBvdGhlciBldmVudHMgc2hvdWxk
IGJlIG9yZGVyZWQgcmVnYXJkbGVzcykgYW5kIGhvdyBub3QgdG8gdHJhdmVyc2UgYWxsDQphc3lu
Yy11c2VyZmF1bHRmZF93YWl0X3F1ZXVl4oCZcyAoZXhjZXB0IHRob3NlIHRoYXQgYmxvY2sgaWYg
dGhlIGxvZyBpcyBmdWxsKQ0Kd2hlbiBhIHdha2V1cCBpcyBuZWVkZWQuDQoNCj4gDQo+IElmIHRo
ZXJlJ3MgcG9zc2libGUgImxvZyBmdWxsIiB0aGVuIHRoZSBuZXh0IHF1ZXN0aW9uIGlzIHdoZXRo
ZXIgd2Ugc2hvdWxkDQo+IGxldCB0aGUgd29ya2VyIHdhaXQgdGhlIG1vbml0b3IgaWYgdGhlIG1v
bml0b3IgaXMgbm90IGZhc3QgZW5vdWdoIHRvDQo+IGNvbGxlY3QgdGhvc2UgZGF0YS4gIEl0IGFk
ZHMgc29tZSBzbGlnaHQgZGVwZW5kZW5jeSBvbiB0aGUgdHdvIHRocmVhZHMsIEkNCj4gdGhpbmsg
aXQgY2FuIG1ha2UgdGhlIHRyYWNraW5nIGhhcmRlciBvciBpbXBvc3NpYmxlIGluIGxhdGVuY3kg
c2Vuc2l0aXZlDQo+IHdvcmtsb2Fkcy4NCg0KQWdhaW4sIEkgdW5kZXJzdGFuZCB5b3VyIGNvbmNl
cm4uIEJ1dCB0aGlzIG1vZGVsIHRoYXQgSSBwcm9wb3NlIGlzIG5vdCBuZXcuDQpJdCBpcyB1c2Vk
IHdpdGggUE1MIChwYWdlLW1vZGlmaWNhdGlvbiBsb2dnaW5nKSBhbmQgS1ZNLCBhbmQgSUlSQyB0
aGVyZSBpcw0KYSBzaW1pbGFyIGludGVyZmFjZSBiZXR3ZWVuIEtWTSBhbmQgUUVNVSB0byBwcm92
aWRlIHRoaXMgaW5mb3JtYXRpb24uIFRoZXJlDQphcmUgZW5kbGVzcyBvdGhlciBleGFtcGxlcyBm
b3Igc2ltaWxhciBwcm9kdWNlci1jb25zdW1lciBtZWNoYW5pc21zIHRoYXQNCm1pZ2h0IGxlYWQg
dG8gc3RhbGwgaW4gZXh0cmVtZSBjYXNlcy4gDQoNCj4gDQo+IFRoZSBvdGhlciB0aGluZyBpcyB3
ZSBjYW4gYWxzbyBtYWtlIHRoZSBsb2cgIm5ldmVyIGdvbm5hIGZ1bGwiIGJ5IG1ha2luZyBpdA0K
PiBhIGJpdG1hcCBjb3ZlcmluZyBhbnkgcmVnaXN0ZXJlZCByYW5nZXMsIGJ1dCBJIGRvbid0IGVp
dGhlciBrbm93IHdoZXRoZXINCj4gaXQnbGwgYmUgd29ydGggaXQgZm9yIHRoZSBlZmZvcnQuDQoN
CkkgZG8gbm90IHNlZSBhIGJlbmVmaXQgb2YgaGFsZi1sb2cgaGFsZi1zY2FuLiBJdCB0cmllcyB0
byB0YWtlIHRoZQ0KZGF0YS1zdHJ1Y3R1cmUgb2Ygb25lIGZvcm1hdCBhbmQgY29tYmluZSBpdCB3
aXRoIGFub3RoZXIuDQoNCkFueWhvdywgSSB3YXMganVzdCBnaXZpbmcgbXkgMiBjZW50cy4gQWRt
aXR0ZWRseSwgSSBkaWQgbm90IGZvbGxvdyB0aGUNCnRocmVhZHMgb2YgcHJldmlvdXMgdmVyc2lv
bnMgYW5kIEkgZGlkIG5vdCBzZWUgdXNlcnNwYWNlIGNvbXBvbmVudHMgdGhhdA0KdXNlIHRoZSBB
UEkgdG8gc2F5IHNvbWV0aGluZyBzbWFydC4gUGVyc29uYWxseSwgSSBkbyBub3QgZmluZCB0aGUg
Y3VycmVudA0KQVBJIHByb3Bvc2FsIHRvIGJlIHZlcnkgY29uc2lzdGVudCBhbmQgc2ltcGxlLCBh
bmQgaXQgc2VlbXMgdG8gbWUgdGhhdCBpdA0KbGV0cyBwYWdlbWFwIGRvIHVzZXJmYXVsdGZkLXJl
bGF0ZWQgdGFza3MsIHdoaWNoIG1pZ2h0IGJlIGNvbnNpZGVyZWQNCmluYXBwcm9wcmlhdGUgYW5k
IG5vbi1pbnR1aXRpdmUuDQoNCklmIEkgZGVyYWlsZWQgdGhlIGRpc2N1c3Npb24sIEkgYXBvbG9n
aXplLg0KDQo=
