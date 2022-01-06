Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6095486A09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 19:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiAFSid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 13:38:33 -0500
Received: from mail-dm6nam12on2121.outbound.protection.outlook.com ([40.107.243.121]:25825
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242731AbiAFSic (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:38:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSaHjKqzSIYv6ubo90+CPA/Y0dWIZ6dWp/mt7XmArAYFQyb4rS+LVFbEPuo8Evyx7x2DUiOEHWVECGZ6adZ3AaU+q61Q3BUqgbuRsabOIaMeG886GjKFSBcOkYgzatZOrWYqcZnUwyln+yjgA+l/o/sCWnEzoKtgB3BewnROEJReLYCdtAG17QFqhlV7QFR15tb+Lee+/eaeoEkiII4AdFglC2Ph+HocBdDJYKhSVaYnVKSfdjZxOzXElYBg2bpUE3BzqeDr1FOtf0ZrKoPJEgp2qP93sn4gud44BYqxB+Y9EqmOPoTf/g1Cv06wRZwvSZ3PjVkkrhxz5LS0t378ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mso2y5RIgAIT8ytOmXdb3byhT3J1r8Upm4lGtD7wCDI=;
 b=IO3vEoNMUxDrPxsQh4xG+lRDLekt4+1fMQePRLucWgmLyXFygXV4zyjjd/vCzOoUpOUrqLzc8DQ8hXi+wlAl6jJoH4nt5UefKFxF8cva3xPBOtnRvbpwqrwSQFPJ5w6xzfrAA3lEHBJ5gJ69ShXXkOEDrQRNtA2FYF/B1ct1JzmY1zROvUo6+XvGAXZkkgCJ1rg1x41dQM9IrHaVud9FvMzw+tGg7QDyWtmU1kli7TNKFn02CVMRXsnpO8OVC2QBRFAVLjQvu9DDC22adSR6NauPNgdjF09ywxJzshSMu529meOYrhMokG/N3+OyoPLtyaLmHD58IsHDWCq7Z20GYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mso2y5RIgAIT8ytOmXdb3byhT3J1r8Upm4lGtD7wCDI=;
 b=HQTTt3OHPTHlC1z2cX181kjRXf8GECyIoBVP6zN99yF1rHuj644yy0SVAJsTtuT07uCjKdMoUM/gX5JhOraLKBBS2ePpzm6vsG0q1NMp7JV6/uFwQMa3NO7ex+boMKKhbXD473nSEov1kZgu829MzHGieXxY237h5msmKjRWg+0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB1773.namprd13.prod.outlook.com (2603:10b6:300:130::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.5; Thu, 6 Jan
 2022 18:38:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 18:38:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Topic: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xL0+EAgABMs4CAAWrGAIAA5lqAgANuRQCAACHbgIAAFcSAgAGffQCAATe6gIAAIn2AgAFMBQCAAAByAA==
Date:   Thu, 6 Jan 2022 18:38:28 +0000
Message-ID: <f3b84819ae05ad055a7f5d3e2c45beae051db770.camel@hammerspace.com>
References: <20211230193522.55520-1-trondmy@kernel.org>
         <Yc5f/C1I+N8MPHcd@casper.infradead.org>
         <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
         <20220101035516.GE945095@dread.disaster.area>
         <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
         <20220103220310.GG945095@dread.disaster.area>
         <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
         <20220104012215.GH945095@dread.disaster.area>
         <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
         <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
         <20220105224829.GO945095@dread.disaster.area>
         <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
In-Reply-To: <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c87daee-8cf5-44bb-2650-08d9d143bb3e
x-ms-traffictypediagnostic: MWHPR13MB1773:EE_
x-microsoft-antispam-prvs: <MWHPR13MB177378284773296F06C9546CB84C9@MWHPR13MB1773.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvJBr1eNqOSycCfLswFKEXnRmyaJC5e3fqKbffYUFP1dn+uCW+WMO234xYUkQc9yeBTbpMPGMykoGrLcLjwDj67khhttbZ1oXHlWp+ocxOWhQDvzsnTjk4TFwG0ohQgz/Y4MYoguBAzTMitIgNC0aCHOq0rgGYM4FDPY+CjL3O4WEbYsyfn/RcNJgXLJ6F2wtmdOJXV0C5v2KrsNhrr0FGZmRokdpQHQ+Op7889GBiabanJ+PdakAcw1NAueIxCKsIFD0aCwFmz8FEFsH1ZQEXi7rK0L0eak+Q1+hI6oRdf1W0LuIb4Ipzu9WMvENTzhAl3M9BJ3E6lDrJIcajY0/aHT7KCG9uu3N3391C6VCkt1DapqKtQRGz/L/TOK8FK8WP6B+kjUBi2cHYHyhrJIXrhLswIre9+NJdPpDKGh6bw/8F1azEsyoBqB7z1/+tv2doxDLLbxSnsyU/QFgKvfVaZ23SkxbSrSsuudMMHTwDSDNBlWTJ/WANT/96q08sf4zRu3ncckBOsnIKWgRdAe3eg2pSBc+PTk8psJ3lmTJP7RMto9zVTZgwm5rlqEQFhX0/H0XSY70SrVKyoIB3OQxHkf6fcpPFDFMBnQKOYTwPIPzwMy3elIDMZjOKgYcoqSPOgusuuBSfTT4vN8KMgvzSiCz4H3ZVRqaH3EGsQeoP+zb0tUn7Z3dxEb+GG/ugv1mWNOTXq0X5s4D2xV22UvRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(346002)(136003)(366004)(396003)(39830400003)(508600001)(38070700005)(122000001)(71200400001)(45080400002)(6916009)(76116006)(83380400001)(38100700002)(54906003)(36756003)(316002)(186003)(66946007)(64756008)(8936002)(8676002)(2616005)(86362001)(6512007)(26005)(2906002)(5660300002)(6506007)(6486002)(66446008)(66556008)(4326008)(66476007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlRMdmszanBRVjV2UTRWWWliVlNmZ05meTRqM0xKcHZ6SHVKRFdaWStreWZm?=
 =?utf-8?B?NVVJL3E1M093ZzErUEpnSFJHWVczaUVUQnFxbzgyVHN5STBBWnBzZnFpMWtM?=
 =?utf-8?B?bHA0U1BjODVEbjdWWkxucjlLdmxEeDNCRXdSYVBJVjdoUk1MVmY0Tm1idzR4?=
 =?utf-8?B?WjdsMEE4bHhyd3Y2MVMvT0IvTGdDdkp1b252anFtdDRQYndOMTFZVEowYzlF?=
 =?utf-8?B?MXJEVkc5UWVYZGRJZTBFOU5xRngrSVJmSE9McGQremh0bzRUZ1J2Vzc5N29s?=
 =?utf-8?B?TnZNMFhPWUVBLzVvM0llMk5UbjBJR1FpekhoaUkraDV1NGZ0YzFnWHZYMXBS?=
 =?utf-8?B?ZnFOWXVrYWtyOHNWZWFkdG9uSW9PTzQxMFpNVzNUbFJhWGZRcnpNV2NGSGNJ?=
 =?utf-8?B?d1ZibENWcHJoZjdUWFVCcm02QUswR0NKdTZQcGhydXhNcWJsR1ZpVTNYSVJF?=
 =?utf-8?B?aU5JVENYMlNRMk1yN0swTE1XL0M4dW1XZDRQeFNQK1FldjFkTWlMK2U3OW9t?=
 =?utf-8?B?WGl0d2lSNm9tVWh0cDNXaTMyaU5vZW9BRm9HSkZuck14c043cjRJUlZJS1NP?=
 =?utf-8?B?cmFXVmpTUUZ4U3BaNG5jbjMzT2dLN2Y5RmliRkJ6dFFkUzNMS2Z3Y2xSSElR?=
 =?utf-8?B?czIwUkZGbWpOZWlkby9lWlcybExEMmtoYitxblJNYy9oNitPQWVoZGZWelFm?=
 =?utf-8?B?Nm8wUVdIdmlUL2xWYkQ5Uk1WZ2lscmtOWngxUno0Qm0vK0xhRnlqU25wbFZU?=
 =?utf-8?B?cEhpdXUzNHM4bWZ2a2tpTnFkaG0yRmFBcFZaZ0MySXBzN2NYLzdFV3N4a3pV?=
 =?utf-8?B?N0Q0NGJxbVBIMlBudmZVUVFmRzErVXYvbDNEV0xwcjRtblh2WU1yTlhZR05K?=
 =?utf-8?B?K2ZJWnNhVEg0WWF3Z1ZIZDlwRndKZHBGYUZpVkU5ZlV4dmtCR2JiQVVuVjhP?=
 =?utf-8?B?OVdCRS95M25UQTllMHNFSmY0Q3pzd29OMmtVdzhid2dUQ2ZhM0RwdVFrUTlE?=
 =?utf-8?B?am4weXB0R0Z1UDUzRk8xU1NFWTFIUGpiN1dkS0JJS1l4bnUvcUlocDEraG5v?=
 =?utf-8?B?Y2ovZWgrN2lnK0J2NDRtRXB2U2VyWkZoSklPZ2dhbDd3bjFvY0FDcExDU0Rk?=
 =?utf-8?B?dzJJclN1amUrQlJEQytQUUdNeHBrc3FScGlCTUFvV1RrRHJMS05JbEczYlpL?=
 =?utf-8?B?TUNUTWlMbmNjUk82UGVlZWFuQlFTaGgvTGZmdjl3QmFib3RocmVWOHRZa1hZ?=
 =?utf-8?B?MVdyR291ZDdRc3RCMkdoOGlDeDVrV2Y2dUJ5Z2loMGgwSnAvWUtNdGYwRFAx?=
 =?utf-8?B?WHR1c3IyMUhab3k3cGhmeUR5KzNBd2I4UThRR05WTmlpMTh5Y0gvMTdybFdx?=
 =?utf-8?B?bTFac0FsWmkxN091SGJ1UUpHdlBzMy9XdDErU2R5SUQ1alBzOVpxODM0bURz?=
 =?utf-8?B?MlBhaVRXM1BtSm1FM1U1S2orSWFrMndHdk9NR1Uwb3gyUHluemEvMGVYcEJv?=
 =?utf-8?B?RkVvcytlWXEwdzNJYmNRZFNxNDhqMmQyb3VuYnBmVHMyQjZ5UnB6OGJtTE50?=
 =?utf-8?B?TUJmaTFVNDFmS0FXdVlqSUkzWEl0dVl4dWtPWFJqK0NpczVuZUpONVMvU3U2?=
 =?utf-8?B?bjgzaGhVT0Q2MkNMMGpqekphM0t0bkkrOHNnZ21VQkZTRHRTL09VamlOaGpY?=
 =?utf-8?B?N0NZKzkrVk9aSDQ1UWhaV2hsS3V5cCtUdnlSZEYrbDVFbjYrZCtjMiswV055?=
 =?utf-8?B?Q1Y1bE1WYjRYNmxWOG9BNXVldEdXTVIzK0diMFY1Y0REMU40UDJQUFZ5Nlpu?=
 =?utf-8?B?cDNQT1BDT1hBMzRRYzk0dEJrYklETzhkcG9xbnRucXhaZWFBS1hYOVRXajVF?=
 =?utf-8?B?eTVaVmc3WXZJWGo1VmRPMzdBRGIza0E1VjNJdGRiTUJwSU9ncURpd0dYajlo?=
 =?utf-8?B?SmNVdXBtY1dFRmNRZHZyaW16QjJDR0c0UUdGL1hQMFI5dlkwa0FHWW5IMnRO?=
 =?utf-8?B?MGVYYUM2SVBiS29kT0tLZUxKV2F4c2RLKzhUcHg2bDJ2WmoySTNvWVpqZHdY?=
 =?utf-8?B?ZGdVcnZ0M3l0djBPWWxZejYwMkwzTlpqS0FObC82K2VLWUE0L1Jncmx2RWx0?=
 =?utf-8?B?UjZRYTlmSDczZmIyMWNHei9kUXhsemxkNTBITG8wOU44ajdKVkZOMkVBYWlM?=
 =?utf-8?Q?eNja+TgG5M/82GKxd6wtQzE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49A99A35EF304E44887E91311F5D6AA9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c87daee-8cf5-44bb-2650-08d9d143bb3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 18:38:28.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJCGjGgj+4xbquLPOMQRuUSPut2BwT62t6+jIH7ICWD4WajS51fClwm50tx/Yg1Uhe9Tsn7lZHfotj00YWvQ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1773
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTA2IGF0IDEzOjM2IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFRodSwgMjAyMi0wMS0wNiBhdCAwOTo0OCArMTEwMCwgRGF2ZSBDaGlubmVyIHdyb3Rl
Og0KPiA+IE9uIFdlZCwgSmFuIDA1LCAyMDIyIGF0IDA4OjQ1OjA1UE0gKzAwMDAsIFRyb25kIE15
a2xlYnVzdCB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMjAyMi0wMS0wNCBhdCAyMTowOSAtMDUwMCwg
VHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjItMDEtMDQgYXQgMTI6
MjIgKzExMDAsIERhdmUgQ2hpbm5lciB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIEphbiAwNCwg
MjAyMiBhdCAxMjowNDoyM0FNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3QNCj4gPiA+ID4gPiB3cm90
ZToNCj4gPiA+ID4gPiA+IFdlIGhhdmUgZGlmZmVyZW50IHJlcHJvZHVjZXJzLiBUaGUgY29tbW9u
IGZlYXR1cmUgYXBwZWFycw0KPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+IGJlDQo+ID4gPiA+
ID4gPiB0aGUNCj4gPiA+ID4gPiA+IG5lZWQgZm9yIGEgZGVjZW50bHkgZmFzdCBib3ggd2l0aCBm
YWlybHkgbGFyZ2UgbWVtb3J5DQo+ID4gPiA+ID4gPiAoMTI4R0INCj4gPiA+ID4gPiA+IGluDQo+
ID4gPiA+ID4gPiBvbmUNCj4gPiA+ID4gPiA+IGNhc2UsIDQwMEdCIGluIHRoZSBvdGhlcikuIEl0
IGhhcyBiZWVuIHJlcHJvZHVjZWQgd2l0aCBIRHMsDQo+ID4gPiA+ID4gPiBTU0RzDQo+ID4gPiA+
ID4gPiBhbmQNCj4gPiA+ID4gPiA+IE5WTUUgc3lzdGVtcy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gT24gdGhlIDEyOEdCIGJveCwgd2UgaGFkIGl0IHNldCB1cCB3aXRoIDEwKyBkaXNrcyBp
biBhIEpCT0QNCj4gPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb24gYW5kIHdlcmUgcnVubmluZyB0aGUg
QUpBIHN5c3RlbSB0ZXN0cy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gdGhlIDQwMEdC
IGJveCwgd2Ugd2VyZSBqdXN0IHNlcmlhbGx5IGNyZWF0aW5nIGxhcmdlICg+DQo+ID4gPiA+ID4g
PiA2R0IpDQo+ID4gPiA+ID4gPiBmaWxlcw0KPiA+ID4gPiA+ID4gdXNpbmcgZmlvIGFuZCB0aGF0
IHdhcyBvY2Nhc2lvbmFsbHkgdHJpZ2dlcmluZyB0aGUgaXNzdWUuDQo+ID4gPiA+ID4gPiBIb3dl
dmVyDQo+ID4gPiA+ID4gPiBkb2luZw0KPiA+ID4gPiA+ID4gYW4gc3RyYWNlIG9mIHRoYXQgd29y
a2xvYWQgdG8gZGlzayByZXByb2R1Y2VkIHRoZSBwcm9ibGVtDQo+ID4gPiA+ID4gPiBmYXN0ZXIN
Cj4gPiA+ID4gPiA+IDotDQo+ID4gPiA+ID4gPiApLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9r
LCB0aGF0IG1hdGNoZXMgdXAgd2l0aCB0aGUgImxvdHMgb2YgbG9naWNhbGx5IHNlcXVlbnRpYWwN
Cj4gPiA+ID4gPiBkaXJ0eQ0KPiA+ID4gPiA+IGRhdGEgb24gYSBzaW5nbGUgaW5vZGUgaW4gY2Fj
aGUiIHZlY3RvciB0aGF0IGlzIHJlcXVpcmVkIHRvDQo+ID4gPiA+ID4gY3JlYXRlDQo+ID4gPiA+
ID4gcmVhbGx5IGxvbmcgYmlvIGNoYWlucyBvbiBpbmRpdmlkdWFsIGlvZW5kcy4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBDYW4geW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cgYW5kIHNlZSBpZiBhZGRy
ZXNzZXMgdGhlIGlzc3VlPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gVGhhdCBwYXRj
aCBkb2VzIHNlZW0gdG8gZml4IHRoZSBzb2Z0IGxvY2t1cHMuDQo+ID4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBPb3BzLi4uIFN0cmlrZSB0aGF0LCBhcHBhcmVudGx5IG91ciB0ZXN0cyBqdXN0IGhpdCB0
aGUgZm9sbG93aW5nDQo+ID4gPiB3aGVuDQo+ID4gPiBydW5uaW5nIG9uIEFXUyB3aXRoIHRoYXQg
cGF0Y2guDQo+ID4gDQo+ID4gT0ssIHNvIHRoZXJlIGFyZSBhbHNvIGxhcmdlIGNvbnRpZ3VvdXMg
cGh5c2ljYWwgZXh0ZW50cyBiZWluZw0KPiA+IGFsbG9jYXRlZCBpbiBzb21lIGNhc2VzIGhlcmUu
DQo+ID4gDQo+ID4gPiBTbyBpdCB3YXMgaGFyZGVyIHRvIGhpdCwgYnV0IHdlIHN0aWxsIGRpZCBl
dmVudHVhbGx5Lg0KPiA+IA0KPiA+IFl1cCwgdGhhdCdzIHdoYXQgSSB3YW50ZWQgdG8ga25vdyAt
IGl0IGluZGljYXRlcyB0aGF0IGJvdGggdGhlDQo+ID4gZmlsZXN5c3RlbSBjb21wbGV0aW9uIHBy
b2Nlc3NpbmcgYW5kIHRoZSBpb21hcCBwYWdlIHByb2Nlc3NpbmcgcGxheQ0KPiA+IGEgcm9sZSBp
biB0aGUgQ1BVIHVzYWdlLiBNb3JlIGNvbXBsZXggcGF0Y2ggZm9yIHlvdSB0byB0cnkgYmVsb3cu
Li4NCj4gPiANCj4gPiBDaGVlcnMsDQo+ID4gDQo+ID4gRGF2ZS4NCj4gDQo+IEhpIERhdmUsDQo+
IA0KPiBUaGlzIHBhdGNoIGdvdCBmdXJ0aGVyIHRoYW4gdGhlIHByZXZpb3VzIG9uZS4gSG93ZXZl
ciBpdCB0b28gZmFpbGVkDQo+IG9uDQo+IHRoZSBzYW1lIEFXUyBzZXR1cCBhZnRlciB3ZSBzdGFy
dGVkIGNyZWF0aW5nIGxhcmdlciAoaW4gdGhpcyBjYXNlDQo+IDUyR0IpDQo+IGZpbGVzLiBUaGUg
cHJldmlvdXMgcGF0Y2ggZmFpbGVkIGF0IDE1R0IuDQo+IA0KPiBOUl8wNi0xODowMDoxNyBwbS00
NjA4OERTWDEgL21udC9kYXRhLXBvcnRhbC9kYXRhICQgbHMgLWxoDQo+IHRvdGFsIDU5Rw0KPiAt
cnctci0tLS0tIDEgcm9vdCByb290wqAgNTJHIEphbsKgIDYgMTg6MjAgMTAwZw0KPiAtcnctci0t
LS0tIDEgcm9vdCByb290IDkuOEcgSmFuwqAgNiAxNzozOCAxMGcNCj4gLXJ3LXItLS0tLSAxIHJv
b3Qgcm9vdMKgwqAgMjkgSmFuwqAgNiAxNzozNiBmaWxlDQo+IE5SXzA2LTE4OjIwOjEwIHBtLTQ2
MDg4RFNYMSAvbW50L2RhdGEtcG9ydGFsL2RhdGEgJA0KPiBNZXNzYWdlIGZyb20gc3lzbG9nZEBw
bS00NjA4OERTWDEgYXQgSmFuwqAgNiAxODoyMjo0NCAuLi4NCj4gwqBrZXJuZWw6WyA1NTQ4LjA4
Mjk4N10gd2F0Y2hkb2c6IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjMTAgc3R1Y2sgZm9yDQo+IDI0
cyEgW2t3b3JrZXIvMTA6MDoxODk5NV0NCj4gTWVzc2FnZSBmcm9tIHN5c2xvZ2RAcG0tNDYwODhE
U1gxIGF0IEphbsKgIDYgMTg6MjM6NDQgLi4uDQo+IMKga2VybmVsOlsgNTYwOC4wODI4OTVdIHdh
dGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzEwIHN0dWNrIGZvcg0KPiAyM3MhIFtrd29y
a2VyLzEwOjA6MTg5OTVdDQo+IE1lc3NhZ2UgZnJvbSBzeXNsb2dkQHBtLTQ2MDg4RFNYMSBhdCBK
YW7CoCA2IDE4OjI3OjA4IC4uLg0KPiDCoGtlcm5lbDpbIDU4MTIuMDgyNTg3XSB3YXRjaGRvZzog
QlVHOiBzb2Z0IGxvY2t1cCAtIENQVSMxMCBzdHVjayBmb3INCj4gMjJzISBba3dvcmtlci8xMDow
OjE4OTk1XQ0KPiBNZXNzYWdlIGZyb20gc3lzbG9nZEBwbS00NjA4OERTWDEgYXQgSmFuwqAgNiAx
ODoyNzozNiAuLi4NCj4gwqBrZXJuZWw6WyA1ODQwLjA4MjUzM10gd2F0Y2hkb2c6IEJVRzogc29m
dCBsb2NrdXAgLSBDUFUjMTAgc3R1Y2sgZm9yDQo+IDIxcyEgW2t3b3JrZXIvMTA6MDoxODk5NV0N
Cj4gTWVzc2FnZSBmcm9tIHN5c2xvZ2RAcG0tNDYwODhEU1gxIGF0IEphbsKgIDYgMTg6Mjg6MDgg
Li4uDQo+IMKga2VybmVsOlsgNTg3Mi4wODI0NTVdIHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3Vw
IC0gQ1BVIzEwIHN0dWNrIGZvcg0KPiAyMXMhIFtrd29ya2VyLzEwOjA6MTg5OTVdDQo+IE1lc3Nh
Z2UgZnJvbSBzeXNsb2dkQHBtLTQ2MDg4RFNYMSBhdCBKYW7CoCA2IDE4OjI4OjQwIC4uLg0KPiDC
oGtlcm5lbDpbIDU5MDQuMDgyNDAwXSB3YXRjaGRvZzogQlVHOiBzb2Z0IGxvY2t1cCAtIENQVSMx
MCBzdHVjayBmb3INCj4gMjFzISBba3dvcmtlci8xMDowOjE4OTk1XQ0KPiBNZXNzYWdlIGZyb20g
c3lzbG9nZEBwbS00NjA4OERTWDEgYXQgSmFuwqAgNiAxODoyOToxNiAuLi4NCj4gwqBrZXJuZWw6
WyA1OTQwLjA4MjI0M10gd2F0Y2hkb2c6IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjMTAgc3R1Y2sg
Zm9yDQo+IDIxcyEgW2t3b3JrZXIvMTA6MDoxODk5NV0NCj4gTWVzc2FnZSBmcm9tIHN5c2xvZ2RA
cG0tNDYwODhEU1gxIGF0IEphbsKgIDYgMTg6Mjk6NDQgLi4uDQo+IMKga2VybmVsOlsgNTk2OC4w
ODIyNDldIHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzEwIHN0dWNrIGZvcg0KPiAy
MnMhIFtrd29ya2VyLzEwOjA6MTg5OTVdDQo+IE1lc3NhZ2UgZnJvbSBzeXNsb2dkQHBtLTQ2MDg4
RFNYMSBhdCBKYW7CoCA2IDE4OjMwOjI0IC4uLg0KPiDCoGtlcm5lbDpbIDYwMDguMDgyMjA0XSB3
YXRjaGRvZzogQlVHOiBzb2Z0IGxvY2t1cCAtIENQVSMxMCBzdHVjayBmb3INCj4gMjFzISBba3dv
cmtlci8xMDowOjE4OTk1XQ0KPiBNZXNzYWdlIGZyb20gc3lzbG9nZEBwbS00NjA4OERTWDEgYXQg
SmFuwqAgNiAxODozMTowOCAuLi4NCj4gwqBrZXJuZWw6WyA2MDUyLjA4MjE5NF0gd2F0Y2hkb2c6
IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjMTAgc3R1Y2sgZm9yDQo+IDI0cyEgW2t3b3JrZXIvMTA6
MDoxODk5NV0NCj4gTWVzc2FnZSBmcm9tIHN5c2xvZ2RAcG0tNDYwODhEU1gxIGF0IEphbsKgIDYg
MTg6MzE6NDggLi4uDQo+IMKga2VybmVsOlsgNjA5Mi4wODIwMTBdIHdhdGNoZG9nOiBCVUc6IHNv
ZnQgbG9ja3VwIC0gQ1BVIzEwIHN0dWNrIGZvcg0KPiAyMXMhIFtrd29ya2VyLzEwOjA6MTg5OTVd
DQo+IA0KDQpKdXN0IHRvIGNvbmZpcm0gdGhhdCB0aGVzZSBhcmUgaW5kZWVkIHRoZSBzYW1lIFhG
UyBoYW5nczoNCg0KW1RodSBKYW4gIDYgMTg6MzM6NTggMjAyMl0gd2F0Y2hkb2c6IEJVRzogc29m
dCBsb2NrdXAgLSBDUFUjMTAgc3R1Y2sNCmZvciAyNHMhIFtrd29ya2VyLzEwOjA6MTg5OTVdDQpb
VGh1IEphbiAgNiAxODozMzo1OCAyMDIyXSBNb2R1bGVzIGxpbmtlZCBpbjogbmZzdjMgYXV0aF9u
YW1lDQpicGZfcHJlbG9hZCB4dF9uYXQgdmV0aCBuZnNfbGF5b3V0X2ZsZXhmaWxlcyBycGNzZWNf
Z3NzX2tyYjUgbmZzdjQNCmRuc19yZXNvbHZlciBuZnNpZG1hcCBuZnMgZnNjYWNoZSBuZXRmcyBk
bV9tdWx0aXBhdGggbmZzZCBhdXRoX3JwY2dzcw0KbmZzX2FjbCBsb2NrZCBncmFjZSBzdW5ycGMg
eHRfTUFTUVVFUkFERSBuZl9jb25udHJhY2tfbmV0bGluaw0KeHRfYWRkcnR5cGUgYnJfbmV0Zmls
dGVyIGJyaWRnZSBzdHAgbGxjIG92ZXJsYXkgeHRfc2N0cA0KbmZfY29ubnRyYWNrX25ldGJpb3Nf
bnMgbmZfY29ubnRyYWNrX2Jyb2FkY2FzdCBuZl9uYXRfZnRwDQpuZl9jb25udHJhY2tfZnRwIHh0
X0NUIGlwNnRfcnBmaWx0ZXIgaXA2dF9SRUpFQ1QgbmZfcmVqZWN0X2lwdjYNCmlwdF9SRUpFQ1Qg
bmZfcmVqZWN0X2lwdjQgeHRfY29ubnRyYWNrIGlwNnRhYmxlX25hdCBpcDZ0YWJsZV9tYW5nbGUN
CmlwNnRhYmxlX3NlY3VyaXR5IGlwNnRhYmxlX3JhdyBpcHRhYmxlX25hdCBuZl9uYXQgaXB0YWJs
ZV9tYW5nbGUNCmlwdGFibGVfc2VjdXJpdHkgaXB0YWJsZV9yYXcgbmZfY29ubnRyYWNrIG5mX2Rl
ZnJhZ19pcHY2IG5mX2RlZnJhZ19pcHY0DQppcF9zZXQgbmZuZXRsaW5rIGlwNnRhYmxlX2ZpbHRl
ciBpcDZfdGFibGVzIGlwdGFibGVfZmlsdGVyIGJvbmRpbmcgdGxzDQppcG1pX21zZ2hhbmRsZXIg
aW50ZWxfcmFwbF9tc3IgaW50ZWxfcmFwbF9jb21tb24gaXNzdF9pZl9jb21tb24gbmZpdA0KbGli
bnZkaW1tIGkyY19waWl4NCBjcmN0MTBkaWZfcGNsbXVsIGNyYzMyX3BjbG11bCBnaGFzaF9jbG11
bG5pX2ludGVsDQpyYXBsIGlwX3RhYmxlcyB4ZnMgbnZtZSBlbmEgbnZtZV9jb3JlIGNyYzMyY19p
bnRlbA0KW1RodSBKYW4gIDYgMTg6MzM6NTggMjAyMl0gQ1BVOiAxMCBQSUQ6IDE4OTk1IENvbW06
IGt3b3JrZXIvMTA6MCBLZHVtcDoNCmxvYWRlZCBUYWludGVkOiBHICAgICAgICAgICAgIEwgICAg
NS4xNS4xMi0yMDAucGQuMTc3MjEuZWw3Lng4Nl82NCAjMQ0KW1RodSBKYW4gIDYgMTg6MzM6NTgg
MjAyMl0gSGFyZHdhcmUgbmFtZTogQW1hem9uIEVDMiByNWIuNHhsYXJnZS8sIEJJT1MNCjEuMCAx
MC8xNi8yMDE3DQpbVGh1IEphbiAgNiAxODozMzo1OCAyMDIyXSBXb3JrcXVldWU6IHhmcy1jb252
L252bWUxbjEgeGZzX2VuZF9pbyBbeGZzXQ0KW1RodSBKYW4gIDYgMTg6MzM6NTggMjAyMl0gUklQ
Og0KMDAxMDpfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHgxYy8weDIwDQpbVGh1IEphbiAg
NiAxODozMzo1OCAyMDIyXSBDb2RlOiA5MiBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBj
YyBjYw0KY2MgMGYgMWYgNDQgMDAgMDAgYzYgMDcgMDAgMGYgMWYgNDAgMDAgZjcgYzYgMDAgMDIg
MDAgMDAgNzUgMDEgYzMgZmIgNjYNCjBmIDFmIDQ0IDAwIDAwIDxjMz4gMGYgMWYgMDAgMGYgMWYg
NDQgMDAgMDAgOGIgMDcgYTkgZmYgMDEgMDAgMDAgNzUgMjENCmI4IDAwIDAyIDAwDQpbVGh1IEph
biAgNiAxODozMzo1OCAyMDIyXSBSU1A6IDAwMTg6ZmZmZmFjMzgwYmVmZmQwOCBFRkxBR1M6IDAw
MDAwMjA2DQpbVGh1IEphbiAgNiAxODozMzo1OCAyMDIyXSBSQVg6IDAwMDAwMDAwMDAwMDAwMDEg
UkJYOiAwMDAwMDAwMDAwMDAxNWMwDQpSQ1g6IGZmZmZmZmZmZmZmZmI5YTINCltUaHUgSmFuICA2
IDE4OjMzOjU4IDIwMjJdIFJEWDogZmZmZmZmZmY4NTgwOTE0OCBSU0k6IDAwMDAwMDAwMDAwMDAy
MDYNClJESTogZmZmZmZmZmY4NTgwOTE0MA0KW1RodSBKYW4gIDYgMTg6MzM6NTggMjAyMl0gUkJQ
OiAwMDAwMDAwMDAwMDAwMjA2IFIwODogZmZmZmFjMzgwODg4ZmM4MA0KUjA5OiBmZmZmYWMzODA4
ODhmYzgwDQpbVGh1IEphbiAgNiAxODozMzo1OCAyMDIyXSBSMTA6IDAwMDAwMDAwMDAwMDAwYTAg
UjExOiAwMDAwMDAwMDAwMDAwMDAwDQpSMTI6IGZmZmZmZmZmODU4MDkxNDANCltUaHUgSmFuICA2
IDE4OjMzOjU4IDIwMjJdIFIxMzogZmZmZmU5NGUyZWY2ZDc4MCBSMTQ6IGZmZmY5NWZhZDEwNTM0
MzgNClIxNTogZmZmZmU5NGUyZWY2ZDc4MA0KW1RodSBKYW4gIDYgMTg6MzM6NTggMjAyMl0gRlM6
ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApDQpHUzpmZmZmOTYxMmEzYzgwMDAwKDAwMDApIGtubEdT
OjAwMDAwMDAwMDAwMDAwMDANCltUaHUgSmFuICA2IDE4OjMzOjU4IDIwMjJdIENTOiAgMDAxMCBE
UzogMDAwMCBFUzogMDAwMCBDUjA6DQowMDAwMDAwMDgwMDUwMDMzDQpbVGh1IEphbiAgNiAxODoz
Mzo1OCAyMDIyXSBDUjI6IDAwMDA3ZjkyOTQ3MjMwODAgQ1IzOiAwMDAwMDAxNjkyODEwMDA0DQpD
UjQ6IDAwMDAwMDAwMDA3NzA2ZTANCltUaHUgSmFuICA2IDE4OjMzOjU4IDIwMjJdIERSMDogMDAw
MDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDANCkRSMjogMDAwMDAwMDAwMDAwMDAw
MA0KW1RodSBKYW4gIDYgMTg6MzM6NTggMjAyMl0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjog
MDAwMDAwMDBmZmZlMGZmMA0KRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQpbVGh1IEphbiAgNiAxODoz
Mzo1OCAyMDIyXSBQS1JVOiA1NTU1NTU1NA0KW1RodSBKYW4gIDYgMTg6MzM6NTggMjAyMl0gQ2Fs
bCBUcmFjZToNCltUaHUgSmFuICA2IDE4OjMzOjU4IDIwMjJdICA8VEFTSz4NCltUaHUgSmFuICA2
IDE4OjMzOjU4IDIwMjJdICB3YWtlX3VwX3BhZ2VfYml0KzB4NzkvMHhlMA0KW1RodSBKYW4gIDYg
MTg6MzM6NTggMjAyMl0gIGVuZF9wYWdlX3dyaXRlYmFjaysweGM0LzB4ZjANCltUaHUgSmFuICA2
IDE4OjMzOjU4IDIwMjJdICBpb21hcF9maW5pc2hfaW9lbmQrMHgxMzAvMHgyNjANCltUaHUgSmFu
ICA2IDE4OjMzOjU4IDIwMjJdICA/IHhmc19pdW5sb2NrKzB4YTQvMHhmMCBbeGZzXQ0KW1RodSBK
YW4gIDYgMTg6MzM6NTggMjAyMl0gIGlvbWFwX2ZpbmlzaF9pb2VuZHMrMHg3Ny8weGEwDQpbVGh1
IEphbiAgNiAxODozMzo1OCAyMDIyXSAgeGZzX2VuZF9pb2VuZCsweDVhLzB4MTIwIFt4ZnNdDQpb
VGh1IEphbiAgNiAxODozMzo1OCAyMDIyXSAgeGZzX2VuZF9pbysweGExLzB4YzAgW3hmc10NCltU
aHUgSmFuICA2IDE4OjMzOjU4IDIwMjJdICBwcm9jZXNzX29uZV93b3JrKzB4MWYxLzB4MzkwDQpb
VGh1IEphbiAgNiAxODozMzo1OCAyMDIyXSAgd29ya2VyX3RocmVhZCsweDUzLzB4M2UwDQpbVGh1
IEphbiAgNiAxODozMzo1OCAyMDIyXSAgPyBwcm9jZXNzX29uZV93b3JrKzB4MzkwLzB4MzkwDQpb
VGh1IEphbiAgNiAxODozMzo1OCAyMDIyXSAga3RocmVhZCsweDEyNy8weDE1MA0KW1RodSBKYW4g
IDYgMTg6MzM6NTggMjAyMl0gID8gc2V0X2t0aHJlYWRfc3RydWN0KzB4NDAvMHg0MA0KW1RodSBK
YW4gIDYgMTg6MzM6NTggMjAyMl0gIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwDQpbVGh1IEphbiAg
NiAxODozMzo1OCAyMDIyXSAgPC9UQVNLPg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
