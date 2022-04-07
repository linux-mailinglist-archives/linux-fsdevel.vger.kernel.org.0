Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F084F7FE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 15:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbiDGNDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245698AbiDGNDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:03:46 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2091.outbound.protection.outlook.com [40.107.212.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C18A235764;
        Thu,  7 Apr 2022 06:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kV9ojtKiQ1f50zgdqGnM+2AIZqQtSF3hjbs/utNOlnMONSvNgOhDFNHEhzxMmkQXdvKx0OWhEseK85ABhP5AzFaswx2ACZFrqEjhz1BtGoByQzEgKfMpk01IBIxo2Pyd2UVHfwPDMakiM+/QGkbKwPpOP7SHoUeyxJWffy7RKqyfuw5cU6yOJ3O5FbCkuoeueO6eCmL1gv93bmYEl2jlLE+ZSAH0iTzHhfzjl/S6KR6YTbfWPRHpx2Elk4+5yetBfGoHnb/VpqK1MppCDcI4gfJmun9tHT62OwtJ654YEY16xUg6PoC0jeJINTx+ubI+/YV6je5m8I/dIdP6reQOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XImUaKyIGRfGv0SsgsX/XZ4DyLNL2cQVJslTMCY91m8=;
 b=EhQvQbBuLsQyazYOc62DE/jv3gAmqPkilIJwfynnwpdULvCkO/UtUjPN1+h54fzpk5sootwExFnQRAhOLKYYuYe6gQPpj5bM+CCIFAzvPW0NWcOXDm+ykghcvETqKyUxLNtohgomlhGMlQLygjTamfFEx99SGrfUJhoLOMESLE4gTHs6vWojvCkI9T+8B+ZNChMLT6RoJQqCVyTpXiLxDgjBB/pNYZ/gAHBcmpkCnAsw/vC5dL+5tNzs/bGYrfMv/uWWDPLsX7cC5EfmrDn5CFvIONmM+5+ZGoa0ZCN+tUzwg+7afuxRiaLDj+emPLuIUSBFKYCKgFz0cWUM2LDDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XImUaKyIGRfGv0SsgsX/XZ4DyLNL2cQVJslTMCY91m8=;
 b=fNBTo0/MktV6Vm86m7Aaj8KEV1YxLu4q67r6vTP5DNNIi45RPXCPXpfDQQwkoUAc2NQ6wAaGPp4+A2kELNM9b9LeEZ2QG7GPc9o7tcEwO3mBoxneKsPAvtaWWBSPw1JN7pwH+ATlsi/d/+fZGR4NA++d9uQ7qCqpZnDNz0HEAG0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN8PR13MB2674.namprd13.prod.outlook.com (2603:10b6:408:86::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Thu, 7 Apr
 2022 13:01:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5164.008; Thu, 7 Apr 2022
 13:01:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: sporadic hangs on generic/186
Thread-Topic: sporadic hangs on generic/186
Thread-Index: AQHYSfqw0+tgllXvcEWzJalDi9pcWazjlQyAgAADk4CAAA5/AIAACbaAgAAmUgCAAJQkgA==
Date:   Thu, 7 Apr 2022 13:01:42 +0000
Message-ID: <43aace26d3a09f868f732b2ad94ca2dbf90f50bd.camel@hammerspace.com>
References: <20220406195424.GA1242@fieldses.org>        ,
 <20220407001453.GE1609613@dread.disaster.area> ,
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>        ,
 <164929437439.10985.5253499040284089154@noble.neil.brown.name> ,
 <b282c5b98c4518952f62662ea3ba1d4e6ef85f26.camel@hammerspace.com>
         <164930468885.10985.9905950866720150663@noble.neil.brown.name>
In-Reply-To: <164930468885.10985.9905950866720150663@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c149c63-3313-436c-35da-08da1896c384
x-ms-traffictypediagnostic: BN8PR13MB2674:EE_
x-microsoft-antispam-prvs: <BN8PR13MB26748BEA5FDB178040C48752B8E69@BN8PR13MB2674.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QcsXlUoO0uPadZLbMpBYRjnaAX2MDoQmcqcA0LyakKbun8zwEO4n4kv2g82L2DTeKb1UL429Z78BS4HhrvHX7BOBCNjaHjZ4M2e1SzYENJnhvF9Ne7ueEKkBdX81z87gsUhvTOqs5DIogFz3Xo6tptz4yMDKHJUhaArh/s4F2r6By9T4S75yC/5J031HlLxE5ID1r68bk4i4yxiqfsac/JEFkbdTNN4r8qqV2VVhngTZRvKOi9g4yqjRbMsLUbGyFhOxaaZsa0o5B6s9Q4rzlYdfi0Vo1RtxRgw98XfjbZ/lD4RJpp7wsutDxRDqQAMJl5JibFCPC7eA6Z5CYMjpZ1DIP9nBNaw03PYAuA1j9YPS+/3V8x8ZvIlR5SwEtejck3JXvBkkKi/cr/W9AR91hqumLSVGLy/CfWCjGzhzfN+6dXrmH7l5pGmX92X+KWxoVtEyasVm2lJwjVc/ysX6IzSOz7zC5PWFYtVwWR5lSyEDYrsHzM/iJkH53cQqh20FU8YqF4zXmw8bwyjx4aTuxWFzghLTic9HcydjgCaiwNYzaOu2DV21GBxz27Qq87Uw6NjTooQ4eALhPIffjjBW/rWXp/A73RR5q9+BEWRvc8ZPP6W9bt1IwQLBQS8YWvt8ShdJ+udRVVdNrcd9IM7UeZ+tZpsqT0vw4Z/+XO/Iw4vNxl4I6zAupOvchFgpVjFUsr+sACLHMi4i8LyNm6jadsIv59w09gTTC5zn8mrwp/w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(38100700002)(76116006)(4326008)(2906002)(6916009)(83380400001)(71200400001)(316002)(122000001)(64756008)(66446008)(66476007)(66556008)(38070700005)(8676002)(66946007)(36756003)(54906003)(5660300002)(508600001)(86362001)(6486002)(6512007)(26005)(186003)(2616005)(8936002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnN1TGFtdGNtVGlJenREejl3QU44YkRrNURwMUpTWXp6T1lHY3oyUUtTQjUv?=
 =?utf-8?B?OGRESGFLS250aU5aV3dZU0Y2NEFvU05ZNVNTM3ZUK3liZUI0MU5wUGNMWmNt?=
 =?utf-8?B?YXJISXdIamNkSmQybG5LTUthaEVsLy8rYVJaOHpBZHRGampBWXVlVTQ0OG5o?=
 =?utf-8?B?NmNUYzhQOTJQS3h0SG5TZ3ZBTEFJOUN0bnl0Q3lSaC84VUYzS1Q5cHpKcVdv?=
 =?utf-8?B?ZVI4Nkc4VjhIUjVubWZ0aENIZVlKK2hKWXlUVkZQOTlQV1lqbmdJeUxvNWRI?=
 =?utf-8?B?S2lKZmdGSW1NeVJSUWtraUNMeFZETjBQbms0dGFUUTFpSzA3OWxhUW5aeUJ2?=
 =?utf-8?B?WnIxdHF0SkdqamZKU1UweVFra1hVNTNrSXFrcDJyVCsxanlrck5Gbm1MazFX?=
 =?utf-8?B?dUdFczgxV2c1TE1VK09TWlliUmxQRDVJZ3psN1RyV3p3V3dLZUNyZXdlcTlj?=
 =?utf-8?B?V3RnVWlsMGRjRCszVkpiY2NsVXh3WEJFSWk2aHFmUWkxT0xCUDZuR3M2Ulpn?=
 =?utf-8?B?NDhHeU05NVNUN1I2Y3ozWkhHeFRhMHE3NERSMVpjYlNNdnkzcGVzRXpMU05l?=
 =?utf-8?B?OU1yQmdXTjRsN0xzQXhaLzQ3aWZ3NHcycTBUSytxaURjVW15c2wreExVU3dP?=
 =?utf-8?B?QWx2UVZHWE10b1V3ZS9xN2dXZjNaZzJjWkloTVB5Z3pYOW1BUGFPYjVPOExa?=
 =?utf-8?B?N3o4Q3NRanJMRGphdTdYZzZ5ajQxRVc3QkI1L1V5N3Q3YzB0cVBOamZPdEJO?=
 =?utf-8?B?S1VLeTFIb0hTbi9zSmlxNkVtS2trQUtnbG41SG9hMnp3YXdVMExZM25uVGRw?=
 =?utf-8?B?aFovUk1nT2F1a3lkbndyVGR0NWx3RVNSWVFUWjhlbGp4d1dkdmNqOWp4THc1?=
 =?utf-8?B?S0xGMFJqSDJyeERhK2R0cEk1YlRYWWhvc1NnZklRZkRhSXVuUnJBVzFMUlJL?=
 =?utf-8?B?WGY1cmpsRm1RMEFNUUpBU1B3NkU2RjVFSmM5QmxtY2lHZERwUDJadTlvSEtT?=
 =?utf-8?B?cjNRdlZMTzZOSmtqRWpBRFhWVnpnSGRRbmNjWGlQZ1U4TFFUUG1ybjkzUFVt?=
 =?utf-8?B?Y1F3QVphcGRBZ0hoWG1aK2E0dVdGNTdKZDh6djlOMCszNDY0NFlIdWd4c2s0?=
 =?utf-8?B?RlIzZENEeUhXb0IrWmdhUHpmcHp3WTM5ZnAyZGhaLzdCSEQzN2JCTEVwaDJZ?=
 =?utf-8?B?WGwvQXNVVFBKNmtXYjF5TjQ4OTAxS3lUNml4UEJtMWtUSUkzVjhYOU9TU3J4?=
 =?utf-8?B?Rjh1S2w5eENqam1NejBkM1YrNEVDU0RLWEtiSUJsdUZJWTErelQrZU85b1FZ?=
 =?utf-8?B?Z2R1VU1EUExRQ2hnK1lvM3VQSVZQZXhnZS9lTXJMSVNvdmtSaFlzbGFVY1V0?=
 =?utf-8?B?emEzSDNYblBkdWYxdnp3VisyWG1TR2NOOUFPY05TZDZ4MVoyenlzN0VtL2Iy?=
 =?utf-8?B?QlEvWDI1Y3p4VWwzemZzZVZ5N1pPWkszS0hkd21pUWMvSUVIR29oOHdnWnJV?=
 =?utf-8?B?TkZERTVxb3FYUXQvMjhMRFVRaUFFU29jbXVmdFFXaVhJQnhmY2oyN2poazl5?=
 =?utf-8?B?bmJSZVYvYmQ1MVFPQWRMY3R1R3hUYVFLeTFEL3FVMjVPMjdSYXZlT052TXcz?=
 =?utf-8?B?aXFWVVh3T1h0MU9YSDdnMWFsOG5pdUZjTVM2OEIzWCt2VXZ6eW1OUnh2N0dC?=
 =?utf-8?B?WFhab0l1SnJBRS9MVG1tWlUrMExwNVU4STJyMTRQR3d6OUNxWXo2VlFjTWhX?=
 =?utf-8?B?OUpBRnNKamZaMWtwTTdGQVFUU3ZvdzRad1RudUc1Z21PNkdSMHZZcG1wdFY3?=
 =?utf-8?B?dVN2QmxLSGw0azJtWENhL2VBMC9teUswWVhkUkt6R3NwZWtoWmV0QjQ4OExI?=
 =?utf-8?B?d0hoRm0vdVpDMTlCQnQ1Q1VlU25OdnhhTnFBVzNGa1JaNzgzaDBUNmIwQ2h2?=
 =?utf-8?B?TWU5dnpVU0NNajBGOFFwRkl5bDU0WWdCNWhUenRNRC9wMGc2amRDK1ZoUlpD?=
 =?utf-8?B?T25nVnppNmJuNjFjemJLUGxtelJRdDVFWVIrTTd5cjg3NGgwWjhsSTF1M0Z6?=
 =?utf-8?B?N1hXMHFlZFJxNmRHVWdlZWErcnRHa0JMVnMvMnpxbDNzYWZ4SFB4NDBHTHJt?=
 =?utf-8?B?Y05ja0ROTWtITWVXemV3ZnlDZVhONHVNdHZ2SUY5NTA3VEpCOTB4MnU0blky?=
 =?utf-8?B?bGZLWG94dTI4SCtlWVlJWm05Q1liL1NKQ2NDbUdyZHVnNkJoVTJucUpSaUJn?=
 =?utf-8?B?NTdBblQ2YXVRU1llQzVRMmcxZEwwZk9ydUpWVkF4UUxKSmxmNDV0a0VmVmo4?=
 =?utf-8?B?eC9TbXRhVU42Z0Q0VjNVY2N4Z2pDZXh1Mk5zMkwxNW9VZlhKcUxoaE01U29i?=
 =?utf-8?Q?kOO6c3zbbFprT2qs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28A5D484B11E65478846C6801CDBF331@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c149c63-3313-436c-35da-08da1896c384
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 13:01:42.9635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StgpUyhl9ukOCiuNjykrdcwQF6s4Y5XCryvIFHMax7F1H0I40DfZ5dZbtiU/JHoBIgBVIXLTqor4Gy3EcnxwjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR13MB2674
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTA3IGF0IDE0OjExICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFRodSwgMDcgQXByIDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUaHUsIDIw
MjItMDQtMDcgYXQgMTE6MTkgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IE9uIFRodSwg
MDcgQXByIDIwMjIsIE5laWxCcm93biB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCAwNyBBcHIgMjAy
MiwgRGF2ZSBDaGlubmVyIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFdlZCwgQXByIDA2LCAyMDIyIGF0
IDAzOjU0OjI0UE0gLTA0MDAsIEouIEJydWNlIEZpZWxkcw0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+
ID4gPiA+ID4gSW4gdGhlIGxhc3QgY291cGxlIGRheXMgSSd2ZSBzdGFydGVkIGdldHRpbmcgaGFu
Z3Mgb24NCj4gPiA+ID4gPiA+IHhmc3Rlc3RzDQo+ID4gPiA+ID4gPiBnZW5lcmljLzE4NiBvbiB1
cHN0cmVhbS7CoCBJIGFsc28gbm90aWNlIHRoZSB0ZXN0IGNvbXBsZXRlcw0KPiA+ID4gPiA+ID4g
YWZ0ZXIgMTArDQo+ID4gPiA+ID4gPiBob3VycyAodXN1YWxseSBpdCB0YWtlcyBhYm91dCA1IG1p
bnV0ZXMpLsKgIFNvbWV0aW1lcyB0aGlzDQo+ID4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+ID4gYWNj
b21wYW5pZWQNCj4gPiA+ID4gPiA+IGJ5ICJuZnM6IFJQQyBjYWxsIHJldHVybmVkIGVycm9yIDEy
IiBvbiB0aGUgY2xpZW50Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICNkZWZpbmUgRU5PTUVNwqDC
oMKgwqDCoMKgwqDCoMKgIDEywqDCoMKgwqDCoCAvKiBPdXQgb2YgbWVtb3J5ICovDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gU28gZWl0aGVyIHRoZSBjbGllbnQgb3IgdGhlIHNlcnZlciBpcyBydW5u
aW5nIG91dCBvZiBtZW1vcnkNCj4gPiA+ID4gPiBzb21ld2hlcmU/DQo+ID4gPiA+IA0KPiA+ID4g
PiBQcm9iYWJseSB0aGUgY2xpZW50LsKgIFRoZXJlIGFyZSBhIGJ1bmNoIG9mIGNoYW5nZXMgcmVj
ZW50bHkNCj4gPiA+ID4gd2hpY2gNCj4gPiA+ID4gYWRkDQo+ID4gPiA+IF9fR0ZQX05PUkVUUlkg
dG8gbWVtb3J5IGFsbG9jYXRpb25zIGZyb20gUEZfV1FfV09SS0VScyBiZWNhdXNlDQo+ID4gPiA+
IHRoYXQNCj4gPiA+ID4gY2FuDQo+ID4gPiA+IHJlc3VsdCBpbiBkZWFkbG9ja3Mgd2hlbiBzd2Fw
cGluZyBvdmVyIE5GUy4NCj4gPiA+ID4gVGhpcyBtZWFucyB0aGF0IGttYWxsb2MgcmVxdWVzdCB0
aGF0IHByZXZpb3VzbHkgbmV2ZXIgZmFpbGVkDQo+ID4gPiA+IChiZWNhdXNlDQo+ID4gPiA+IEdG
UF9LRVJORUwgbmV2ZXIgZmFpbHMgZm9yIGtlcm5lbCB0aHJlYWRzIEkgdGhpbmspIGNhbiBub3cN
Cj4gPiA+ID4gZmFpbC7CoA0KPiA+ID4gPiBUaGlzDQo+ID4gPiA+IGhhcyB0aWNrbGVkIG9uZSBi
dWcgdGhhdCBJIGtub3cgb2YuwqAgVGhlcmUgYXJlIGxpa2VseSB0byBiZQ0KPiA+ID4gPiBtb3Jl
Lg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIFJQQyBjb2RlIHNob3VsZCBzaW1wbHkgcmV0cnkgdGhl
c2UgYWxsb2NhdGlvbnMgYWZ0ZXIgYQ0KPiA+ID4gPiBzaG9ydA0KPiA+ID4gPiBkZWxheS4gDQo+
ID4gPiA+IEhaLzQgaXMgdGhlIG51bWJlciB0aGF0IGlzIHVzZWQgaW4gYSBjb3VwbGUgb2YgcGxh
Y2VzLsKgDQo+ID4gPiA+IFBvc3NpYmx5DQo+ID4gPiA+IHRoZXJlDQo+ID4gPiA+IGFyZSBtb3Jl
IHBsYWNlcyB0aGF0IG5lZWQgdG8gaGFuZGxlIC1FTk9NRU0gd2l0aCBycGNfZGVsYXkoKS4NCj4g
PiA+IA0KPiA+ID4gSSBoYWQgYSBsb29rIHRocm91Z2ggdGhlIHZhcmlvdXMgcGxhY2VzIHdoZXJl
IGFsbG9jIGNhbiBub3cgZmFpbC4NCj4gPiA+IA0KPiA+ID4gSSB0aGluayB4ZHJfYWxsb2NfYnZl
YygpIGluIHhwcnRfc2VudF9wYWdlZGF0YSgpIGlzIHRoZSBtb3N0DQo+ID4gPiBsaWtlbHkNCj4g
PiA+IGNhdXNlIG9mIGEgcHJvYmxlbSBoZXJlLsKgIEkgZG9uJ3QgdGhpbmsgYW4gLUVOT01FTSBm
cm9tIHRoZXJlIGlzDQo+ID4gPiBjYXVnaHQsDQo+ID4gPiBzbyBpdCBjb3VsZCBsaWtlbHkgZmls
dGVyIHVwIHRvIE5GUyBhbmQgcmVzdWx0IGluIHRoZSBtZXNzYWdlIHlvdQ0KPiA+ID4gZ290Lg0K
PiA+ID4gDQo+ID4gPiBJIGRvbid0IHRoaW5rIHdlIGNhbiBlYXNpbHkgaGFuZGxlIGZhaWx1cmUg
dGhlcmUuwqAgV2UgbmVlZCB0bw0KPiA+ID4gc3RheQ0KPiA+ID4gd2l0aA0KPiA+ID4gR0ZQX0tF
Uk5FTCByZWx5IG9uIFBGX01FTUFMTE9DIHRvIG1ha2UgZm9yd2FyZCBwcm9ncmVzcyBmb3INCj4g
PiA+IHN3YXAtb3Zlci1ORlMuDQo+ID4gPiANCj4gPiA+IEJydWNlOiBjYW4geW91IGNoYW5nZSB0
aGF0IG9uZSBsaW5lIGJhY2sgdG8gR0ZQX0tFUk5FTCBhbmQgc2VlIGlmDQo+ID4gPiB0aGUNCj4g
PiA+IHByb2JsZW0gZ29lcyBhd2F5Pw0KPiA+ID4gDQo+ID4gDQo+ID4gQ2FuIHdlIHBsZWFzZSBq
dXN0IG1vdmUgdGhlIGNhbGwgdG8geGRyX2FsbG9jX2J2ZWMoKSBvdXQgb2YNCj4gPiB4cHJ0X3Nl
bmRfcGFnZWRhdGEoKT8gTW92ZSB0aGUgY2xpZW50IHNpZGUgYWxsb2NhdGlvbiBpbnRvDQo+ID4g
eHNfc3RyZWFtX3ByZXBhcmVfcmVxdWVzdCgpIGFuZCB4c191ZHBfc2VuZF9yZXF1ZXN0KCksIHRo
ZW4gbW92ZQ0KPiA+IHRoZQ0KPiA+IHNlcnZlciBzaWRlIGFsbG9jYXRpb24gaW50byBzdmNfdWRw
X3NlbmR0bygpLg0KPiA+IA0KPiA+IFRoYXQgbWFrZXMgaXQgcG9zc2libGUgdG8gaGFuZGxlIGVy
cm9ycy4NCj4gDQo+IExpa2UgdGhlIGJlbG93IEkgZ3Vlc3MuwqAgU2VlbXMgc2Vuc2libGUsIGJ1
dCBJIGRvbid0IGtub3cgdGhlIGNvZGUNCj4gd2VsbA0KPiBlbm91Z2ggdG8gcmVhbGx5IHJldmll
dyBpdC4NCj4gDQo+ID4gDQo+ID4gPiBUaGUgb3RoZXIgcHJvYmxlbSBJIGZvdW5kIGlzIHRoYXQg
cnBjX2FsbG9jX3Rhc2soKSBjYW4gbm93IGZhaWwsDQo+ID4gPiBidXQNCj4gPiA+IHJwY19uZXdf
dGFzayBhc3N1bWVzIHRoYXQgaXQgbmV2ZXIgd2lsbC7CoCBJZiBpdCBkb2VzLCB0aGVuIHdlIGdl
dA0KPiA+ID4gYQ0KPiA+ID4gTlVMTA0KPiA+ID4gZGVyZWYuDQo+ID4gPiANCj4gPiA+IEkgZG9u
J3QgdGhpbmsgcnBjX25ld190YXNrKCkgY2FuIGV2ZXIgYmUgY2FsbGVkIGZyb20gdGhlIHJwY2lv
ZA0KPiA+ID4gd29yaw0KPiA+ID4gcXVldWUsIHNvIGl0IGlzIHNhZmUgdG8ganVzdCB1c2UgYSBt
ZW1wb29sIHdpdGggR0ZQX0tFUk5FTCBsaWtlDQo+ID4gPiB3ZQ0KPiA+ID4gZGlkDQo+ID4gPiBi
ZWZvcmUuIA0KPiA+ID4gDQo+ID4gTm8uIFdlIHNob3VsZG4ndCBldmVyIHVzZSBtZW1wb29scyB3
aXRoIEdGUF9LRVJORUwuDQo+IA0KPiBXaHkgbm90P8KgIG1lbXBvb2xzIHdpdGggR0ZQX0tFUk5F
TCBtYWtlIHBlcmZlY3Qgc2Vuc2Ugb3V0c2lkZSBvZiB0aGUNCj4gcnBjaW9kIGFuZCBuZnNpb2Qg
dGhyZWFkcy4NCg0KSWYgeW91IGNhbiBhZmZvcmQgdG8gbWFrZSBpdCBhbiBpbmZpbml0ZSB3YWl0
LCB0aGVyZSBpcyBfX0dGUF9OT0ZBSUwsDQpzbyB3aHkgd2FzdGUgdGhlIHJlc291cmNlcyBvZiBh
biBlbWVyZ2VuY3kgcG9vbD8gSW4gbXkgb3BpbmlvbiwNCmhvd2V2ZXIsIGFuIGluZmluaXRlIHVu
aW50ZXJydXB0aWJsZSBzbGVlcCBpcyBiYWQgcG9saWN5IGZvciBhbG1vc3QgYWxsDQpjYXNlcyBi
ZWNhdXNlIHNvbWVvbmUgd2lsbCB3YW50IHRvIGJyZWFrIG91dCBhdCBzb21lIHBvaW50Lg0KDQo+
IA0KPiA+IA0KPiA+IE1vc3QsIGlmIG5vdCBhbGwgb2YgdGhlIGNhbGxlcnMgb2YgcnBjX3J1bl90
YXNrKCkgYXJlIHN0aWxsIGNhcGFibGUNCj4gPiBvZg0KPiA+IGRlYWxpbmcgd2l0aCBlcnJvcnMs
IGFuZCBkaXR0byBmb3IgdGhlIGNhbGxlcnMgb2YNCj4gPiBycGNfcnVuX2JjX3Rhc2soKS4NCj4g
DQo+IFllcywgdGhleSBjYW4gZGVhbCB3aXRoIGVycm9ycy7CoCBCdXQgaW4gbWFueSBjYXNlcyB0
aGF0IGRvIHNvIGJ5DQo+IHBhc3NpbmcNCj4gdGhlIGVycm9yIHVwIHRoZSBjYWxsIHN0YWNrIHNv
IHdlIGNvdWxkIHN0YXJ0IGdldHRpbmcgRU5PTUVNIGZvcg0KPiBzeXN0ZW1jYWxscyBsaWtlIHN0
YXQoKS7CoCBJIGRvbid0IHRoaW5rIHRoYXQgaXMgYSBnb29kIGlkZWEuDQo+IA0KDQpzdGF0KCkg
aGFzIGFsd2F5cyBiZWVuIGNhcGFibGUgb2YgcmV0dXJuaW5nIEVOT01FTSBpZiwgZm9yIGluc3Rh
bmNlLA0KaW5vZGUgYWxsb2NhdGlvbiBmYWlscy4gVGhlcmUgYXJlIGFsbW9zdCBubyBjYWxscyBp
biBORlMgKG9yIG1vc3Qgb3RoZXINCmZpbGVzeXN0ZW1zIGZvciB0aGF0IG1hdHRlcikgdGhhdCBj
YW4ndCBmYWlsIHNvbWVob3cgd2hlbiBtZW1vcnkgc3RhcnRzDQp0byBnZXQgcmVhbGx5IHNjYXJj
ZS4NCg0KVGhlIGJvdHRvbSBsaW5lIGlzIHRoYXQgd2UgdXNlIG9yZGluYXJ5IEdGUF9LRVJORUwg
bWVtb3J5IGFsbG9jYXRpb25zDQp3aGVyZSB3ZSBjYW4uIFRoZSBuZXcgY29kZSBmb2xsb3dzIHRo
YXQgcnVsZSwgYnJlYWtpbmcgaXQgb25seSBpbiBjYXNlcw0Kd2hlcmUgdGhlIHNwZWNpZmljIHJ1
bGVzIG9mIHJwY2lvZC94cHJ0aW9kL25mc2lvZCBtYWtlIGl0IGltcG9zc2libGUgdG8NCndhaXQg
Zm9yZXZlciBpbiB0aGUgbWVtb3J5IG1hbmFnZXIuDQoNCkkgYW0gcHJlcGFyaW5nIGEgc2V0IG9m
IHBhdGNoZXMgdG8gYWRkcmVzcyB0aGUgaXNzdWVzIHRoYXQgeW91J3ZlDQppZGVudGlmaWVkLCBw
bHVzIGEgY2FzZSBpbiBjYWxsX3RyYW5zbWl0X3N0YXR1cy9jYWxsX2JjX3RyYW5zbWl0X3N0YXR1
cw0Kd2hlcmUgd2UncmUgbm90IGhhbmRsaW5nIEVOT01FTS4gVGhlcmUgYXJlIGFsc28gcGF0Y2hl
cyB0byBmaXggdXAgdHdvDQpjYXNlcyBpbiB0aGUgTkZTIGNvZGUgaXRzZWxmIHdoZXJlIHdlJ3Jl
IG5vdCBjdXJyZW50bHkgaGFuZGxpbmcgZXJyb3JzDQpmcm9tIHJwY19ydW5fdGFzay4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
