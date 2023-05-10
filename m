Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6656FDFD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 16:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjEJOSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 10:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjEJOSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 10:18:37 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2079.outbound.protection.outlook.com [40.107.9.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F019A3;
        Wed, 10 May 2023 07:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LStdGkq2yD7Xv8BtKMpTUn89IPGanjRd3nM9wg2PR6YzsMFgdHq0lTAS/4cUAz1cD7PHfGqY9Iv+dgQNeUDeaCmJEv7wkQVMS2e3QDA9F7Jgt0n9NepDuxpp4MCc+eRewcXPcAJlWIAh8F6X/s3vew7twr9tkjeXwo0lRen1eHSMmuoj2+Sy3T7dOspw1eBpAK39SMnax2c/N/3xOsPSSuqGUTJhoAc+IPJdQx0qCbuwnxINLT8s7SQCKyjLXNL4TRkXq599i4C56yap7MCXwyDVCEpPBfKmYjQ8QTo3q7QIbME3X7g3SRXhZXzMT6HX/eIQrlP+3zjrOrPwLgHrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQX8yv85wPnLiWZFicSz+EzQSZ1vxOher/fxlmi3/OY=;
 b=TO4JbVUV7icfwrSu/jR4+neXwO22x61ENLgxQwbRQyO7Ub9tDaIVF1IQx64HyBBsPmon+fM5zrZQjoC2igaHXMDUnYBSAHuEDYMnAfsmxSQF2c2sF0CZyxi2sVmvTKxbY2RCpWYaiDbPoPXQN+9rIqYMuDqP9oihQUck7sScX9WnRKm0MCRBMiLRGF3CVQcNnr81xCEWOT9aiCUKu/RLdEG+O7YlT07M46VjZTYXS++eUnkcGanRLDzRbCne2UEy8xWnIOO/GibylufKlYQ3L8KbwPf8y5RW9mNyuHRNO99Isd5IERso+P4VXh6xbpNIZiv8oOO+dYgLFPyAxg/CPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQX8yv85wPnLiWZFicSz+EzQSZ1vxOher/fxlmi3/OY=;
 b=RJGNrYxOueio8v1JUx3vS4wWx9c053Iq1Srra3HFeIDrkKQylZe169egRftJNzV55JpsRP4IEWPF36UzAtrC7TrwcuT5zFeDoG2zvScBuYXy/2AmTRpk02a1d4yGbHVtol7KHhCehkkDpq1HFGXaK7/lGP+MmXYQ/2DFExVJvq+KaA038ijuVzvNcWwc7oVoJF5tThUFQhqfGlTvwxWhs5l2xx7DrkeHcc+A+7pGypyg/Ry7m6NLu21MkreFYr2CSwVwv30LKqWE01xgcK4Z769k+fHyLhUrkEm5jkKPhwnOlMg2OPwODiT3D10utZmm5j9SLk4G1pkjTXg+PBSiTQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2919.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 14:18:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fce5:485d:b5f5:c8ec]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fce5:485d:b5f5:c8ec%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 14:18:32 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>
CC:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Topic: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Index: AQHZgpdUsgx7flCbUE+3jXS45Hg7zK9Tj2uA
Date:   Wed, 10 May 2023 14:18:32 +0000
Message-ID: <d874c1f9-472e-398b-87e7-f83701fa2bfa@csgroup.eu>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-8-kent.overstreet@linux.dev>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2919:EE_
x-ms-office365-filtering-correlation-id: 910034a9-e451-435b-b29d-08db51616f8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ZixOGr0eGOhPDA9VG+zKn8u055SYWOBx+Hmkijg+xs9QtQRO+4DM9t+6q+FE/E53JaF8EdpXZzGwoka+KK3JlKEEET45JPdyBoW1lyynUh2Uo08o6ijVVLz0KksAmZpiN7wlEpky5TeSv06uLPMnf/niN/zakN6+KhW8cWSnDshPD9QK/m3pYZ8o34ezd7GGaDH6SvgHgvdY2451HCwmxp2TS79jpoK4OoNIrC8Wl2c+F1OfrqkrTI5n7C7fD8jCxnIkfkWRzjzzsc7BrbCiVvk6soVRh+0UmG0mLzfUcDeqBUIGny5jkIs/VnzSE6y/FZSlXVBiS0pXy+BRaQKANkprTZfAxd+Loo98gCQPQ+XmL+XbeWQRxMGoEsXsWHs+rzvxFUjZalo9BRZ1g+CHLqIgMwOfHXbsAqdDQQxxDJEbysp9ytNBdCSkv4NWDscQjpSHMl55MwaQIl0/yLwvQGmv75VdBFbwsZp5Gr8M75w6B8Trjlb/BOo6A4IG3ac0aKWwbW9n420wWs8yUfL9wk3A1lrWRUiXJKk59ZsSi+HS7uRhwpiPuotKHawDe6p+n7RAgZJARdPuuPUsgI754SHQ/a1DMzgWuXk29DfkTypvj4+KFhqTufNW2DENzxLt3JGBfhOLqmHfPDk0LtgsgvMCAi7mZuvquI43uonRbI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(86362001)(31696002)(36756003)(966005)(76116006)(478600001)(54906003)(316002)(91956017)(110136005)(71200400001)(4326008)(66946007)(66446008)(64756008)(66476007)(6486002)(66556008)(44832011)(5660300002)(2906002)(8676002)(41300700001)(122000001)(38070700005)(38100700002)(186003)(8936002)(6506007)(2616005)(26005)(6512007)(83380400001)(66574015)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmxSN1BVU3owUHMxV2xBL3NlOC9QTFI1NWFjdlNRRkNuakMwWXlYdFJvUVJT?=
 =?utf-8?B?cDJQMU1LUVByNTlVL3hhakdNT0ZmZEl4T3cwMlFQRnB5dE85SHJKaDE0WSti?=
 =?utf-8?B?YVZGTDY1UFgzQlU4bXFiQXlBeGNKRVhXYnMwNkg5MnVxTTU2WWNDdUM4Ujkz?=
 =?utf-8?B?cmRFQ1hqSUJFQzJyc2F6SUtDNHBKbHJYU3hMMkNjbndHVVhtWURvRG1OZWlJ?=
 =?utf-8?B?T0t5YUVtdzJjZnIvMnJNY1BKZk1SNkZvZU12MXFHdXhVelZ3RjlTNE4za3VU?=
 =?utf-8?B?Z0lTQkxteUs1aFVTc3ZaSHhaZnVZb2dMcjJMK1BpREhvUDJaZmtnc2lIdzZL?=
 =?utf-8?B?cktWSEhOL2JpSmxtTngyUldzZ3d2a2l2MVRWS1JEdXhmeVIvMENDNnp6clMw?=
 =?utf-8?B?aDFxTThGNmNzWDNoSU4xdjZ5RFFVeTF0SXd3cUYxV0hoOENxLzFDcU9iTUhO?=
 =?utf-8?B?b210ZjdPWWRXd1dzN09KT0J6MDArNHZQSXhpVWdSTlN5ZVlyaHJzN1BnVG9u?=
 =?utf-8?B?bnJYaGhScGxPak1QYlZxdVRMTTJGeGJ3dmh5WUZrbzg2REpkWnI1YVh6YjB0?=
 =?utf-8?B?aWpYemVUT05jVlNpSmhGbEJxNXdDdTNIRVdaNUpha2ZjTC84ZXI2OFo3SnY0?=
 =?utf-8?B?cjJSMG93ODFDcnhPUXVSYkZSWm9rdnhxTWd3YTZQNzlFaklzL1hsR0U1YzEv?=
 =?utf-8?B?M0hjNGE1aXlHTFI3anU3QjZRMDM4ZEN5emJGK05iNTZZSnJLNDZ0WlpWMjRs?=
 =?utf-8?B?bVBOOEYwVE9QbmRPZW53Vm1OUUwrVHJXY3VNeDAzR0dsMWgrODdpRUZJWi94?=
 =?utf-8?B?TEI0SElTc0ZBSWk1MnhvWnZPUUMyN2hGM1RYTXY3c2NDcVRkem13dkhGUzI1?=
 =?utf-8?B?NUIyQmV2em5Md3NyRnFxODBOT0UrNkFONWNKbXYxeU90NWNSV0N1Z21wSnNQ?=
 =?utf-8?B?eTBiakZFcDF2SnMyWE9wTFJsZGFBMFIwM3NZdGtyc1lEdUxWNGNBODM1RzRY?=
 =?utf-8?B?Tkl0Uk5FZGVQQ3hnWG9xYm5od1BIbDdoaTZvQlhESmJyUVRMWjdOUlBRQWNo?=
 =?utf-8?B?ZTBja2xkZHkwaCtlaXFKdk1OL1lKOU9VUk0xOUFvZzByeEJtWlFKZ3duckg4?=
 =?utf-8?B?SGkvN0FvWjNPZGxnRElmalhldUhBQ3dGZFMzMXZtd3JIcStTaWFBOTdpdDJW?=
 =?utf-8?B?b3YreE5La3YrRFlKb2FYUVhGNkljMGlKbUw4bWZNV2wyZU5Qa0hiZVBMVDZR?=
 =?utf-8?B?UklydHBUUVcwTHhGczRwd1VUeEljbHMxNkNEb3M1TWJKYndUUFVVNFhoNWxk?=
 =?utf-8?B?SkhrMlZNYzJHdElZdDRQdDdQanc0QmRJZCtGYzd1NWU0Q0wrZHU2WlM4dGdH?=
 =?utf-8?B?cTI4TllaQkRCVThDaE8veUFwV05TbDh3ZVhPQ0FEUjdzTVY4NDZsbnBOS0tw?=
 =?utf-8?B?Qk01TGoyZ3hxeFZSSDJzVEdobDVJNkFUZE9NRHZmYnhuVEJJVG9xTGZpVFN1?=
 =?utf-8?B?S0o5cHNja3doN1VzQUs1M081TmtwM2NzNldhWFFwZnlTaTZLNnRJcDhwMmdr?=
 =?utf-8?B?THVYSnFtZDF5SjlzcHNGNTJaMy9vVmkvam01dXV4SUM1UEFEQThrNkRocC93?=
 =?utf-8?B?M0pJYXZGSnpYazE2RU5FaVRqSHhVTHg0dzF3ZFVBZ1YrQlYrVC9vSFFHT01v?=
 =?utf-8?B?R1gxVGZKMGNjNUFMdEp0WWRXcWdBOHlRSmN3TzIvK3QzNWczQ1RGSGpSc1dF?=
 =?utf-8?B?VnVkZm1hd1c0aUhHTzhMT1JQM0JHTFpKeXI0TXNiZ3ZUZ1hRWTFPTTc0YUp4?=
 =?utf-8?B?d0lQRGwzYm1ocEFUdHhFVGU0QkNsY0pwL3BqWXA5MURFcUdLVitYb25ZV09J?=
 =?utf-8?B?bXdwL2ZWY3RWS3loTzRoZ0dwN3hOcDVUR21PZlp1Y2FENis2b1pIQms2R3Q3?=
 =?utf-8?B?YmwwNWg4YXZtejB4Nm82aWZGOTlGTGhvR2d5eSttNEVCTGNMaGNDT0dKQXRY?=
 =?utf-8?B?L25CYjdCZUp0Ymx0TjFmRkJkRklvZUV2WVY4ZU1JcTZERkVPaE11WUpPMFV6?=
 =?utf-8?B?WitKRXF3Z0RVejJ1MVRsbGZuSzNPbEt0SVdWaXh1UmRUT0dGVXV6K3FnQk5y?=
 =?utf-8?B?WDZiVGU1MDRPTmdya1pRbkkvTGsxQmlPdXgrTWVsUEszMUFESkFndFpnTlZU?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5219AB3A4C98F649BDD74A637C87B617@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 910034a9-e451-435b-b29d-08db51616f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 14:18:32.7975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkD6i5caLEGWJwwtOZdExz6bP2a9dPQYWHPrJ6Txoj/WDOGsqv9M3ET0OARuL6uyDgDtovNlQD1eMibIcc33TdNCIeGaFxgmpSMl2gDiK7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2919
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCkxlIDA5LzA1LzIwMjMgw6AgMTg6NTYsIEtlbnQgT3ZlcnN0cmVldCBhIMOpY3JpdMKgOg0K
PiBGcm9tOiBLZW50IE92ZXJzdHJlZXQgPGtlbnQub3ZlcnN0cmVldEBnbWFpbC5jb20+DQo+IA0K
PiBUaGlzIGlzIG5lZWRlZCBmb3IgYmNhY2hlZnMsIHdoaWNoIGR5bmFtaWNhbGx5IGdlbmVyYXRl
cyBwZXItYnRyZWUgbm9kZQ0KPiB1bnBhY2sgZnVuY3Rpb25zLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogS2VudCBPdmVyc3RyZWV0IDxrZW50Lm92ZXJzdHJlZXRAbGludXguZGV2Pg0KPiBDYzogQW5k
cmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IFVsYWR6aXNsYXUg
UmV6a2kgPHVyZXpraUBnbWFpbC5jb20+DQo+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGlu
ZnJhZGVhZC5vcmc+DQo+IENjOiBsaW51eC1tbUBrdmFjay5vcmcNCj4gLS0tDQo+ICAgaW5jbHVk
ZS9saW51eC92bWFsbG9jLmggfCAgMSArDQo+ICAga2VybmVsL21vZHVsZS9tYWluLmMgICAgfCAg
NCArLS0tDQo+ICAgbW0vbm9tbXUuYyAgICAgICAgICAgICAgfCAxOCArKysrKysrKysrKysrKysr
KysNCj4gICBtbS92bWFsbG9jLmMgICAgICAgICAgICB8IDIxICsrKysrKysrKysrKysrKysrKysr
Kw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZtYWxsb2MuaCBiL2luY2x1ZGUvbGlu
dXgvdm1hbGxvYy5oDQo+IGluZGV4IDY5MjUwZWZhMDMuLmZmMTQ3ZmUxMTUgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvbGludXgvdm1hbGxvYy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvdm1hbGxv
Yy5oDQo+IEBAIC0xNDUsNiArMTQ1LDcgQEAgZXh0ZXJuIHZvaWQgKnZ6YWxsb2ModW5zaWduZWQg
bG9uZyBzaXplKSBfX2FsbG9jX3NpemUoMSk7DQo+ICAgZXh0ZXJuIHZvaWQgKnZtYWxsb2NfdXNl
cih1bnNpZ25lZCBsb25nIHNpemUpIF9fYWxsb2Nfc2l6ZSgxKTsNCj4gICBleHRlcm4gdm9pZCAq
dm1hbGxvY19ub2RlKHVuc2lnbmVkIGxvbmcgc2l6ZSwgaW50IG5vZGUpIF9fYWxsb2Nfc2l6ZSgx
KTsNCj4gICBleHRlcm4gdm9pZCAqdnphbGxvY19ub2RlKHVuc2lnbmVkIGxvbmcgc2l6ZSwgaW50
IG5vZGUpIF9fYWxsb2Nfc2l6ZSgxKTsNCj4gK2V4dGVybiB2b2lkICp2bWFsbG9jX2V4ZWModW5z
aWduZWQgbG9uZyBzaXplLCBnZnBfdCBnZnBfbWFzaykgX19hbGxvY19zaXplKDEpOw0KPiAgIGV4
dGVybiB2b2lkICp2bWFsbG9jXzMyKHVuc2lnbmVkIGxvbmcgc2l6ZSkgX19hbGxvY19zaXplKDEp
Ow0KPiAgIGV4dGVybiB2b2lkICp2bWFsbG9jXzMyX3VzZXIodW5zaWduZWQgbG9uZyBzaXplKSBf
X2FsbG9jX3NpemUoMSk7DQo+ICAgZXh0ZXJuIHZvaWQgKl9fdm1hbGxvYyh1bnNpZ25lZCBsb25n
IHNpemUsIGdmcF90IGdmcF9tYXNrKSBfX2FsbG9jX3NpemUoMSk7DQo+IGRpZmYgLS1naXQgYS9r
ZXJuZWwvbW9kdWxlL21haW4uYyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+IGluZGV4IGQzYmU4
OWRlNzAuLjllYWE4OWU4NGMgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+
ICsrKyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+IEBAIC0xNjA3LDkgKzE2MDcsNyBAQCBzdGF0
aWMgdm9pZCBkeW5hbWljX2RlYnVnX3JlbW92ZShzdHJ1Y3QgbW9kdWxlICptb2QsIHN0cnVjdCBf
ZGRlYnVnX2luZm8gKmR5bmRiZw0KPiAgIA0KPiAgIHZvaWQgKiBfX3dlYWsgbW9kdWxlX2FsbG9j
KHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gICB7DQo+IC0JcmV0dXJuIF9fdm1hbGxvY19ub2RlX3Jh
bmdlKHNpemUsIDEsIFZNQUxMT0NfU1RBUlQsIFZNQUxMT0NfRU5ELA0KPiAtCQkJR0ZQX0tFUk5F
TCwgUEFHRV9LRVJORUxfRVhFQywgVk1fRkxVU0hfUkVTRVRfUEVSTVMsDQo+IC0JCQlOVU1BX05P
X05PREUsIF9fYnVpbHRpbl9yZXR1cm5fYWRkcmVzcygwKSk7DQo+ICsJcmV0dXJuIHZtYWxsb2Nf
ZXhlYyhzaXplLCBHRlBfS0VSTkVMKTsNCj4gICB9DQo+ICAgDQo+ICAgYm9vbCBfX3dlYWsgbW9k
dWxlX2luaXRfc2VjdGlvbihjb25zdCBjaGFyICpuYW1lKQ0KPiBkaWZmIC0tZ2l0IGEvbW0vbm9t
bXUuYyBiL21tL25vbW11LmMNCj4gaW5kZXggNTdiYTI0M2M2YS4uOGQ5YWIxOWUzOSAxMDA2NDQN
Cj4gLS0tIGEvbW0vbm9tbXUuYw0KPiArKysgYi9tbS9ub21tdS5jDQo+IEBAIC0yODAsNiArMjgw
LDI0IEBAIHZvaWQgKnZ6YWxsb2Nfbm9kZSh1bnNpZ25lZCBsb25nIHNpemUsIGludCBub2RlKQ0K
PiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MKHZ6YWxsb2Nfbm9kZSk7DQo+ICAgDQo+ICsvKioNCj4g
KyAqCXZtYWxsb2NfZXhlYyAgLSAgYWxsb2NhdGUgdmlydHVhbGx5IGNvbnRpZ3VvdXMsIGV4ZWN1
dGFibGUgbWVtb3J5DQo+ICsgKglAc2l6ZToJCWFsbG9jYXRpb24gc2l6ZQ0KPiArICoNCj4gKyAq
CUtlcm5lbC1pbnRlcm5hbCBmdW5jdGlvbiB0byBhbGxvY2F0ZSBlbm91Z2ggcGFnZXMgdG8gY292
ZXIgQHNpemUNCj4gKyAqCXRoZSBwYWdlIGxldmVsIGFsbG9jYXRvciBhbmQgbWFwIHRoZW0gaW50
byBjb250aWd1b3VzIGFuZA0KPiArICoJZXhlY3V0YWJsZSBrZXJuZWwgdmlydHVhbCBzcGFjZS4N
Cj4gKyAqDQo+ICsgKglGb3IgdGlnaHQgY29udHJvbCBvdmVyIHBhZ2UgbGV2ZWwgYWxsb2NhdG9y
IGFuZCBwcm90ZWN0aW9uIGZsYWdzDQo+ICsgKgl1c2UgX192bWFsbG9jKCkgaW5zdGVhZC4NCj4g
KyAqLw0KPiArDQo+ICt2b2lkICp2bWFsbG9jX2V4ZWModW5zaWduZWQgbG9uZyBzaXplLCBnZnBf
dCBnZnBfbWFzaykNCj4gK3sNCj4gKwlyZXR1cm4gX192bWFsbG9jKHNpemUsIGdmcF9tYXNrKTsN
Cj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHZtYWxsb2NfZXhlYyk7DQo+ICsNCj4gICAvKioN
Cj4gICAgKiB2bWFsbG9jXzMyICAtICBhbGxvY2F0ZSB2aXJ0dWFsbHkgY29udGlndW91cyBtZW1v
cnkgKDMyYml0IGFkZHJlc3NhYmxlKQ0KPiAgICAqCUBzaXplOgkJYWxsb2NhdGlvbiBzaXplDQo+
IGRpZmYgLS1naXQgYS9tbS92bWFsbG9jLmMgYi9tbS92bWFsbG9jLmMNCj4gaW5kZXggMzFmZjc4
MmQzNi4uMmViYjllYTdmMCAxMDA2NDQNCj4gLS0tIGEvbW0vdm1hbGxvYy5jDQo+ICsrKyBiL21t
L3ZtYWxsb2MuYw0KPiBAQCAtMzQwMSw2ICszNDAxLDI3IEBAIHZvaWQgKnZ6YWxsb2Nfbm9kZSh1
bnNpZ25lZCBsb25nIHNpemUsIGludCBub2RlKQ0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MKHZ6
YWxsb2Nfbm9kZSk7DQo+ICAgDQo+ICsvKioNCj4gKyAqIHZtYWxsb2NfZXhlYyAtIGFsbG9jYXRl
IHZpcnR1YWxseSBjb250aWd1b3VzLCBleGVjdXRhYmxlIG1lbW9yeQ0KPiArICogQHNpemU6CSAg
YWxsb2NhdGlvbiBzaXplDQo+ICsgKg0KPiArICogS2VybmVsLWludGVybmFsIGZ1bmN0aW9uIHRv
IGFsbG9jYXRlIGVub3VnaCBwYWdlcyB0byBjb3ZlciBAc2l6ZQ0KPiArICogdGhlIHBhZ2UgbGV2
ZWwgYWxsb2NhdG9yIGFuZCBtYXAgdGhlbSBpbnRvIGNvbnRpZ3VvdXMgYW5kDQo+ICsgKiBleGVj
dXRhYmxlIGtlcm5lbCB2aXJ0dWFsIHNwYWNlLg0KPiArICoNCj4gKyAqIEZvciB0aWdodCBjb250
cm9sIG92ZXIgcGFnZSBsZXZlbCBhbGxvY2F0b3IgYW5kIHByb3RlY3Rpb24gZmxhZ3MNCj4gKyAq
IHVzZSBfX3ZtYWxsb2MoKSBpbnN0ZWFkLg0KPiArICoNCj4gKyAqIFJldHVybjogcG9pbnRlciB0
byB0aGUgYWxsb2NhdGVkIG1lbW9yeSBvciAlTlVMTCBvbiBlcnJvcg0KPiArICovDQo+ICt2b2lk
ICp2bWFsbG9jX2V4ZWModW5zaWduZWQgbG9uZyBzaXplLCBnZnBfdCBnZnBfbWFzaykNCj4gK3sN
Cj4gKwlyZXR1cm4gX192bWFsbG9jX25vZGVfcmFuZ2Uoc2l6ZSwgMSwgVk1BTExPQ19TVEFSVCwg
Vk1BTExPQ19FTkQsDQo+ICsJCQlnZnBfbWFzaywgUEFHRV9LRVJORUxfRVhFQywgVk1fRkxVU0hf
UkVTRVRfUEVSTVMsDQo+ICsJCQlOVU1BX05PX05PREUsIF9fYnVpbHRpbl9yZXR1cm5fYWRkcmVz
cygwKSk7DQo+ICt9DQoNClRoYXQgY2Fubm90IHdvcmsuIFRoZSBWTUFMTE9DIHNwYWNlIGlzIG1h
cHBlZCBub24tZXhlYyBvbiBwb3dlcnBjLzMyLiANCllvdSBoYXZlIHRvIGFsbG9jYXRlIGJldHdl
ZW4gTU9EVUxFU19WQUREUiBhbmQgTU9EVUxFU19FTkQgaWYgeW91IHdhbnQgDQpzb21ldGhpbmcg
ZXhlY3V0YWJsZSBzbyB5b3UgbXVzdCB1c2UgbW9kdWxlX2FsbG9jKCkgc2VlIA0KaHR0cHM6Ly9l
bGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNC1yYzEvc291cmNlL2FyY2gvcG93ZXJwYy9rZXJu
ZWwvbW9kdWxlLmMjTDEwOA0KDQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh2bWFsbG9jX2V4ZWMpOw0K
PiArDQo+ICAgI2lmIGRlZmluZWQoQ09ORklHXzY0QklUKSAmJiBkZWZpbmVkKENPTkZJR19aT05F
X0RNQTMyKQ0KPiAgICNkZWZpbmUgR0ZQX1ZNQUxMT0MzMiAoR0ZQX0RNQTMyIHwgR0ZQX0tFUk5F
TCkNCj4gICAjZWxpZiBkZWZpbmVkKENPTkZJR182NEJJVCkgJiYgZGVmaW5lZChDT05GSUdfWk9O
RV9ETUEpDQo=
