Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88494F71C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 03:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiDGB4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 21:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiDGB4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:56:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2105.outbound.protection.outlook.com [40.107.243.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C5C1150;
        Wed,  6 Apr 2022 18:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPxCmjtTqZegWi5g1OzPyjK2YB32UTb6U9XZOT2jUBCsY7FU48R1ioNMHy7GnusmiysmUp2JaNRom8M/WX3aZngpjLPERWTedGoxAno3F6jU3eTRkGiuNK11SGw0bsol9FdRQGElVlbR3hHQ5CrX85CNGfYzNzsVgy1nNu6yM2oePoY+MXn7/fz4iaFS6XVFkk4DI61NqVTT4DNmaPwkDAPDwvcB1x91XGOBzsriQEgxqc9qM6DJKwNrDH4xD0VdasjxDy/O/QZX1ixRRJYzcedLc/2V8FhYTTOvQo1bWk/hlFwHFMcyVVckFHdBdS+OwiZvqZ3NSl6+Ftek+Yr4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tse3UCqCgnj8SwpsHLPnXPwZ1WdfqVBG1LAb571b/TI=;
 b=eR3zICbE9d3isrXXusyL5DVVkoRlZvNnYcuzcj+b81GtJTJvRg3gi3E7Mvjnyq0u8D/1+OIxB7zxUY4Vtejq69LOt7hLTMP2IrRY4LsG0+LBxrUZxm73M4tGsngF3U/PuDe0PGryvpHy6xtgO0InpYCQA8ZOFP9Dj8frGVtPCf4gDLooFYziVukroXcUm3obfF92xotQEmpK3nJQBvct2z7josK/sPgF7IKCTSF3dPGfBnf4h+iducp95LbBECoI+P9In4ILJWi+QLndmgZB2H+xL8id0LGNlURnwiPm1PEVOrwZZ2gTcx4xTEePHz33tky5lyD9MufXSqs55xb+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tse3UCqCgnj8SwpsHLPnXPwZ1WdfqVBG1LAb571b/TI=;
 b=f5imWdOWnc75DZdyiYvn/tLgXVfgAcX/VMMxNnAJplBEOOttwqWAugmfAO4w9iuDGwWeIKvQoOPvIGUeAAXaXpoHdDy6qeMjV5NbEYtuWtA3eLT0DF2D9Trmpc+YEJ/KmiO6i5C+31NHfwwSk97y+geVF7ts4pEr4btDfOIVadc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5500.namprd13.prod.outlook.com (2603:10b6:a03:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 01:54:20 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5144.019; Thu, 7 Apr 2022
 01:54:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: sporadic hangs on generic/186
Thread-Topic: sporadic hangs on generic/186
Thread-Index: AQHYSfqw0+tgllXvcEWzJalDi9pcWazjlQyAgAADk4CAAA5/AIAACbaA
Date:   Thu, 7 Apr 2022 01:54:20 +0000
Message-ID: <b282c5b98c4518952f62662ea3ba1d4e6ef85f26.camel@hammerspace.com>
References: <20220406195424.GA1242@fieldses.org>        ,
 <20220407001453.GE1609613@dread.disaster.area> ,
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>
         <164929437439.10985.5253499040284089154@noble.neil.brown.name>
In-Reply-To: <164929437439.10985.5253499040284089154@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dcc1c91-6d74-48c9-f660-08da1839885a
x-ms-traffictypediagnostic: SJ0PR13MB5500:EE_
x-microsoft-antispam-prvs: <SJ0PR13MB5500C76F4D80740693F76E34B8E69@SJ0PR13MB5500.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AcjRwWm/hf9XwmwIQL1RlZxK9qrAlZAfY46LkU51N0buQnQWRpwQXUBUuDqwGr5IGJaCNf5XnymhbmVTHGqrABni0bf5T9sNC43/vtR0aTadC8l0h0tcjN/iiKycfaMMgd1gnZlU/yI3TtMTDnYX3RK/+1TPlSb051XXT+tfze2KQBDvjmu7pQ7G1e5Yz0nvf4ObGncXQUNsM5jaYifQsVCWdHzNgg6ryrFpnp7qDx8Qxiw5COSZkFpdNLikDkmjCnTKNFz0cFpIcAKexCBjiNhXR2BcBcvD8K9a7YcxuNnfw5HsJDk9BWMp8SP//rhBfgl+N1+G1aaHBBbImya/pguIe48quYMeQw98X+nLyDzi7WmqtZugEl4EpQfQHukpZB5X37nW+XQRa/85+BbLQ0i/nYrgs2+L1IGeeVP23DbwztbHvk1DCuwubIwhnqvuaRnaLHCNscTzq62k3rlFE5WXA8b/ArI2SKGSOhxiW/BNbOepiSeZykOehrlvJJlJKQRBk1KTC324LhkLRLw2hD+/tbnovmwvN342MDflvZo+sMayJBRQcT0FOcaSiavsdBH6RJ1iAe2Cs9//q+BHpVz/CKG1LSRXA1538NFE9F2Vr0y3rkrhA2YpDS126saxR2TWLqvI+/TNxAIp6cNvvxqrUFIdLIH318bodAK8f/12CnR5cYCZYdPKsIO9mOfPxs2Vx/lom6NRwGX+nvXNjnHLMuvUGB7o5fsEqHaRho1gE2vAoDWW3LL/NMTzar2e5f61BwnXUzQd/80aVc7V3HItE8qqfuMgBoiplbZgwGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(36756003)(6512007)(26005)(2906002)(5660300002)(6506007)(186003)(8936002)(71200400001)(66476007)(66556008)(316002)(64756008)(66446008)(66946007)(86362001)(8676002)(6486002)(38100700002)(4326008)(54906003)(508600001)(110136005)(76116006)(83380400001)(122000001)(2616005)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZENuQ2ZKaGVvMG45MjRIZlNpbnZtTnBJRGpSL1EzejNRblFrNGRBb1dWcDlw?=
 =?utf-8?B?aGtrUjVOR0NwRVVmWmRPVEFFeWZSNHovY2RZY0VaOVRoMG1KYnNzNGJ3UW0y?=
 =?utf-8?B?WG5JRHFtc0ljQWlmR3d1QmJzNGpRSzFHUmxmRCtxc29vVjNFZ0QxR3UzaGZj?=
 =?utf-8?B?VkJIRFpOZWIybXluY1RXREhvNURZUTZUNWsvOE5OQkdWd1F0M2U4azJlbUs3?=
 =?utf-8?B?b0JSVU8ySWFnRFRld0Y2QnA1MkZoUGd5MDVJNENGdHhZUG5VRXNQcWpVWUl1?=
 =?utf-8?B?UEIxd3F3dUZ2RkptTXhGc21tKzhUVzhDUDBJVVRvdUlHSEQwbVFLdnJzd0dj?=
 =?utf-8?B?dDJ4N3lrTTlmMmcwOTRPMEFZbDFBclZTUnRtV2FKVTlUMjlPUXQxcHVhNHo2?=
 =?utf-8?B?WE1qSnlJY3NNQXdvYjF4SUJhTHRjS21yZjJkL2pmRkYrRE9TWnVDT0hnek11?=
 =?utf-8?B?alJycEtQVWlzdEhTNTByNkt4dmRTckZmN1BSVTF2SEhKOUFxdFlLOUZ6Z0Iw?=
 =?utf-8?B?MFZxNUd2UDlyYnZZN1dBNy9ZSVBVUzVJbENoNTAwY1h6a2x6cnM5b0pVSkg3?=
 =?utf-8?B?dXJ4QkhORk03TUpwcnU4MWNjTGFBNTlwQ0xLZjZOUFdwbDNGeGNRVjk2VkJ4?=
 =?utf-8?B?WGZEVEVUWjIwVFBnZTlqOHNTT2lKNnl2YmlBUGtBcllzcWtaTmNxeDlPZUtT?=
 =?utf-8?B?c2RoNnJKcEgyRlJtdWdpUFNnbHQ2R0pOQmJ6dTFWdjNwdE4xcnpoN3JraEor?=
 =?utf-8?B?a1V6QjVaVGlESTFFNk5iNTRjdS95aURrcnlDNEVMSXRoa0lQVCtGM2NaRGlD?=
 =?utf-8?B?TkRlNlVaWmZ0Q24zMVlGVXJuM0REOTM1THZYd01US3ozemIycnRkQUhscVZm?=
 =?utf-8?B?UEQ1ZnVHbGxJVnpNTWR6WmdmRDgyRUF3eUgwcFk2NmVSNGZ3SG9helJ1ZUNt?=
 =?utf-8?B?QVp1azlMR29xejdZK3VzWEVXUEhsbUdURXljNDNnTkpkb0FWdHppaUZBU1Mv?=
 =?utf-8?B?SmtZU1hHeThuVndPWmsvT3UySmEvVlRWM0Zua2ZkUFJ6RnJEQk1HYURCM294?=
 =?utf-8?B?ckRyQmlSVlFVNnRxWW13L04rZm9yOTNoWDFpMmNQc3NmeEJvbWNzYlF6WlJs?=
 =?utf-8?B?KzNJNkJlYkdjTGJYUGh2Sk9YQ1R4aVJPZmlZSnIzMjhNbDFNbUsrOEUwMnJ0?=
 =?utf-8?B?cVZCa0prK2VxMjBuNXhlU3N0OURvdldFZk1vbUZ5MjU5Y3hlNFVkT3JXTCt4?=
 =?utf-8?B?bFF6UnlKbEtPajdFaW1kZDA2eEx0OTlEMit5QTdnOSt4ZmxITzVrZ1NJb3BL?=
 =?utf-8?B?QVE3OWtXajUvcXZwV0FmTUpydUFHcDBocGNUTVNEK255TzdoeThwNExlZU5v?=
 =?utf-8?B?a1gzdExJRWRyREk3N2hjQ2NDRWtvMkxWUVhWOGNlRWppc0NBVi9DM1dPaUlZ?=
 =?utf-8?B?alNGQkl3dmFXNU1pU1Q5dzdONDVSd1dwR0tBaXdac0JkK2hCalNQU1NoaUlX?=
 =?utf-8?B?ajZldm5OOExyN3pvTGxtWHVPZUNWcXYvNEppTU9hNU9GeWgrTUxvVmhqTXRK?=
 =?utf-8?B?bkhuaTErUkdFVmZabS9wTXBEZnVjME1KT0VxQ3l5UE1iVHRTUGZtQWZhKzRT?=
 =?utf-8?B?L2wzNTRIeWNVa0xRWGZrR2t4dDhqNXhPYVhoOVBMQmR6MmFvVEtoU1U3WFRj?=
 =?utf-8?B?MFIwK0MvY2NlOGIyUk8zaDQ1YkJvMTNWcWZkblMzdjUxeWF1a2VDb090ZFBj?=
 =?utf-8?B?WGNkYnNmdzdlb1NDbStuNTZUYXBsWkF5SVZ4ZmJKSENxeS8rQ09PZzc3UE5l?=
 =?utf-8?B?bFY1NVYxbWVLd1E1N3JVNW1mTWxQRjF6dWNTeEFkWVZXVzVid0w2S25aMXVa?=
 =?utf-8?B?UDRFVmxYcmxrRnNGdmFmMWVsaUxIQkRBNXEzd1B4bUNNRHNDRURtUFRtYTBK?=
 =?utf-8?B?UW1vWU5Wem53WW9FTWV6czZ5SjR1Yy9ITTlIbFBub1Nxd3ZoU29yNUsrK2x1?=
 =?utf-8?B?SWR3SGdFK09HOFdIeTJLRTNCbGFwWE52L2txZE9sWk0zMElvYXVvUTZiM1BB?=
 =?utf-8?B?TmM5cE1Bdm5kblorSXU4eDJ2UURNWFdQZnlLOGRYMUttWjRaL01Cd3ljL1Vi?=
 =?utf-8?B?YTR0Z0ZuaXJZdlRjKzYvdlh3YytQUTMzV1RSckpheFlyTmcvcXJQRTlCNkMw?=
 =?utf-8?B?elJMeDR5clZqaytoWGxGNDV1ejJvc1VLYlhQL2F1TERYSnhmYzNXWUNXNW84?=
 =?utf-8?B?T2dQdG1ZYjl3Z1piU2ZMNjNrVmovOHd4di80eHc1a3pYZmZlRFNINkhFNlZo?=
 =?utf-8?B?YUhZcjNuN3ZDK0w3RGhpV2JDNE0yb1Uzbi9KUHk2bVRDMFZ6djNaS05tL0pJ?=
 =?utf-8?Q?R23OTM3ItNjpQEl4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B307DDE04B1D0E41B1E65725DEE8D692@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcc1c91-6d74-48c9-f660-08da1839885a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 01:54:20.4961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYp0mM0nU4dssg8WYnTXpMYaAdZK+W4ZLEG7m9ePfnQnSilgp4LM0hI9o8MO50foAqfTWRaqHAWrb3NRhZz5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTA3IGF0IDExOjE5ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFRodSwgMDcgQXByIDIwMjIsIE5laWxCcm93biB3cm90ZToNCj4gPiBPbiBUaHUsIDA3IEFwciAy
MDIyLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEFwciAwNiwgMjAyMiBhdCAw
Mzo1NDoyNFBNIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+ID4gPiA+IEluIHRoZSBs
YXN0IGNvdXBsZSBkYXlzIEkndmUgc3RhcnRlZCBnZXR0aW5nIGhhbmdzIG9uIHhmc3Rlc3RzDQo+
ID4gPiA+IGdlbmVyaWMvMTg2IG9uIHVwc3RyZWFtLsKgIEkgYWxzbyBub3RpY2UgdGhlIHRlc3Qg
Y29tcGxldGVzDQo+ID4gPiA+IGFmdGVyIDEwKw0KPiA+ID4gPiBob3VycyAodXN1YWxseSBpdCB0
YWtlcyBhYm91dCA1IG1pbnV0ZXMpLsKgIFNvbWV0aW1lcyB0aGlzIGlzDQo+ID4gPiA+IGFjY29t
cGFuaWVkDQo+ID4gPiA+IGJ5ICJuZnM6IFJQQyBjYWxsIHJldHVybmVkIGVycm9yIDEyIiBvbiB0
aGUgY2xpZW50Lg0KPiA+ID4gDQo+ID4gPiAjZGVmaW5lIEVOT01FTcKgwqDCoMKgwqDCoMKgwqDC
oCAxMsKgwqDCoMKgwqAgLyogT3V0IG9mIG1lbW9yeSAqLw0KPiA+ID4gDQo+ID4gPiBTbyBlaXRo
ZXIgdGhlIGNsaWVudCBvciB0aGUgc2VydmVyIGlzIHJ1bm5pbmcgb3V0IG9mIG1lbW9yeQ0KPiA+
ID4gc29tZXdoZXJlPw0KPiA+IA0KPiA+IFByb2JhYmx5IHRoZSBjbGllbnQuwqAgVGhlcmUgYXJl
IGEgYnVuY2ggb2YgY2hhbmdlcyByZWNlbnRseSB3aGljaA0KPiA+IGFkZA0KPiA+IF9fR0ZQX05P
UkVUUlkgdG8gbWVtb3J5IGFsbG9jYXRpb25zIGZyb20gUEZfV1FfV09SS0VScyBiZWNhdXNlIHRo
YXQNCj4gPiBjYW4NCj4gPiByZXN1bHQgaW4gZGVhZGxvY2tzIHdoZW4gc3dhcHBpbmcgb3ZlciBO
RlMuDQo+ID4gVGhpcyBtZWFucyB0aGF0IGttYWxsb2MgcmVxdWVzdCB0aGF0IHByZXZpb3VzbHkg
bmV2ZXIgZmFpbGVkDQo+ID4gKGJlY2F1c2UNCj4gPiBHRlBfS0VSTkVMIG5ldmVyIGZhaWxzIGZv
ciBrZXJuZWwgdGhyZWFkcyBJIHRoaW5rKSBjYW4gbm93IGZhaWwuwqANCj4gPiBUaGlzDQo+ID4g
aGFzIHRpY2tsZWQgb25lIGJ1ZyB0aGF0IEkga25vdyBvZi7CoCBUaGVyZSBhcmUgbGlrZWx5IHRv
IGJlIG1vcmUuDQo+ID4gDQo+ID4gVGhlIFJQQyBjb2RlIHNob3VsZCBzaW1wbHkgcmV0cnkgdGhl
c2UgYWxsb2NhdGlvbnMgYWZ0ZXIgYSBzaG9ydA0KPiA+IGRlbGF5LiANCj4gPiBIWi80IGlzIHRo
ZSBudW1iZXIgdGhhdCBpcyB1c2VkIGluIGEgY291cGxlIG9mIHBsYWNlcy7CoCBQb3NzaWJseQ0K
PiA+IHRoZXJlDQo+ID4gYXJlIG1vcmUgcGxhY2VzIHRoYXQgbmVlZCB0byBoYW5kbGUgLUVOT01F
TSB3aXRoIHJwY19kZWxheSgpLg0KPiANCj4gSSBoYWQgYSBsb29rIHRocm91Z2ggdGhlIHZhcmlv
dXMgcGxhY2VzIHdoZXJlIGFsbG9jIGNhbiBub3cgZmFpbC4NCj4gDQo+IEkgdGhpbmsgeGRyX2Fs
bG9jX2J2ZWMoKSBpbiB4cHJ0X3NlbnRfcGFnZWRhdGEoKSBpcyB0aGUgbW9zdCBsaWtlbHkNCj4g
Y2F1c2Ugb2YgYSBwcm9ibGVtIGhlcmUuwqAgSSBkb24ndCB0aGluayBhbiAtRU5PTUVNIGZyb20g
dGhlcmUgaXMNCj4gY2F1Z2h0LA0KPiBzbyBpdCBjb3VsZCBsaWtlbHkgZmlsdGVyIHVwIHRvIE5G
UyBhbmQgcmVzdWx0IGluIHRoZSBtZXNzYWdlIHlvdQ0KPiBnb3QuDQo+IA0KPiBJIGRvbid0IHRo
aW5rIHdlIGNhbiBlYXNpbHkgaGFuZGxlIGZhaWx1cmUgdGhlcmUuwqAgV2UgbmVlZCB0byBzdGF5
DQo+IHdpdGgNCj4gR0ZQX0tFUk5FTCByZWx5IG9uIFBGX01FTUFMTE9DIHRvIG1ha2UgZm9yd2Fy
ZCBwcm9ncmVzcyBmb3INCj4gc3dhcC1vdmVyLU5GUy4NCj4gDQo+IEJydWNlOiBjYW4geW91IGNo
YW5nZSB0aGF0IG9uZSBsaW5lIGJhY2sgdG8gR0ZQX0tFUk5FTCBhbmQgc2VlIGlmIHRoZQ0KPiBw
cm9ibGVtIGdvZXMgYXdheT8NCj4gDQoNCkNhbiB3ZSBwbGVhc2UganVzdCBtb3ZlIHRoZSBjYWxs
IHRvIHhkcl9hbGxvY19idmVjKCkgb3V0IG9mDQp4cHJ0X3NlbmRfcGFnZWRhdGEoKT8gTW92ZSB0
aGUgY2xpZW50IHNpZGUgYWxsb2NhdGlvbiBpbnRvDQp4c19zdHJlYW1fcHJlcGFyZV9yZXF1ZXN0
KCkgYW5kIHhzX3VkcF9zZW5kX3JlcXVlc3QoKSwgdGhlbiBtb3ZlIHRoZQ0Kc2VydmVyIHNpZGUg
YWxsb2NhdGlvbiBpbnRvIHN2Y191ZHBfc2VuZHRvKCkuDQoNClRoYXQgbWFrZXMgaXQgcG9zc2li
bGUgdG8gaGFuZGxlIGVycm9ycy4NCg0KPiBUaGUgb3RoZXIgcHJvYmxlbSBJIGZvdW5kIGlzIHRo
YXQgcnBjX2FsbG9jX3Rhc2soKSBjYW4gbm93IGZhaWwsIGJ1dA0KPiBycGNfbmV3X3Rhc2sgYXNz
dW1lcyB0aGF0IGl0IG5ldmVyIHdpbGwuwqAgSWYgaXQgZG9lcywgdGhlbiB3ZSBnZXQgYQ0KPiBO
VUxMDQo+IGRlcmVmLg0KPiANCj4gSSBkb24ndCB0aGluayBycGNfbmV3X3Rhc2soKSBjYW4gZXZl
ciBiZSBjYWxsZWQgZnJvbSB0aGUgcnBjaW9kIHdvcmsNCj4gcXVldWUsIHNvIGl0IGlzIHNhZmUg
dG8ganVzdCB1c2UgYSBtZW1wb29sIHdpdGggR0ZQX0tFUk5FTCBsaWtlIHdlDQo+IGRpZA0KPiBi
ZWZvcmUuIA0KPiANCk5vLiBXZSBzaG91bGRuJ3QgZXZlciB1c2UgbWVtcG9vbHMgd2l0aCBHRlBf
S0VSTkVMLg0KDQpNb3N0LCBpZiBub3QgYWxsIG9mIHRoZSBjYWxsZXJzIG9mIHJwY19ydW5fdGFz
aygpIGFyZSBzdGlsbCBjYXBhYmxlIG9mDQpkZWFsaW5nIHdpdGggZXJyb3JzLCBhbmQgZGl0dG8g
Zm9yIHRoZSBjYWxsZXJzIG9mIHJwY19ydW5fYmNfdGFzaygpLg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
