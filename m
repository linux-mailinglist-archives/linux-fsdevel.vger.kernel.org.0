Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201A25604B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 17:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiF2Pds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiF2Pdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:33:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2123.outbound.protection.outlook.com [40.107.244.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1F22B07;
        Wed, 29 Jun 2022 08:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz06FJw+pjZcsmR9+fcRRfUlZhw8wv5rkvb+eY3aRX2gCt/z19qMjJ+kqaJnj4Da3i85ramlAFWwrhlm7zwfIIhza9xnVDJYCQ/OJZCi2ONYbU3OOfF77rYEF8MKKrUhv5R50EJTFyhmzBZlYFQ0s6BAPxPBUmo9e8PDwDZSimp6Z/LIYoqLp1oW58sBNMRJ61AkHr0xskrmb3JSp7i6uZ8dA+gFeId6pqFPM/Es7bo1tZkHASzINEpXF00MALQLDwA2IzEuq7IYY4NJEB411/rP7muIkT2nztqEpNB5sFFLiyjP7pHGL/f6fj7EoXcXRfwrFrWenWHinMatG43zSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpmRcnI+H6TnFLa/w/IFvITrxdDnaHa7iH8zElg6/HQ=;
 b=TuFEVGn5lCyV81ODbt0GaYf368plneyVk4rDvXcO510zWyiHvXR6xqbVZhO0CaZj0tY0UvMdt76ddFvYInNJ9mlVizFLgIgUUQZCItt1UHJHyiBmwx2RmSBQAYTfb3V6UtZbwd79TG79pXOKQilb8Q/OfhL2yizT0BcjDnkpoWRPvJUU32/p9t1DQR3WhXsHjsGU+Xh2g5cqd/MG4O+TBkRHKupUz0D3xt1dNip1YoH0QhwOm9r0hB3wuekfMJ3Ny2mTrfbxDWVUGbqbx+jSKfXQOf8H59ENKsybNpXYIqJeXIQFIGS1PXzphHoo2aTYIiaT85/IJCkBpfmrqyfRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpmRcnI+H6TnFLa/w/IFvITrxdDnaHa7iH8zElg6/HQ=;
 b=BMKEh5R/9WlhZrdZQDr5B8PDkBaO2swjDSkpGp7xA3A1vdiHW+iVzWrVtckTixN4Xbs+uPkzHsordeNDbeyq1lxGoXJrd4cRXLbYibX7sWTlzjEK5juGy8z18Hr81l+A6rQStlCaWcb9Yp+W9v2CBSQtEBwToC/l54iOHo7bYi8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1225.namprd13.prod.outlook.com (2603:10b6:3:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 15:33:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::28a1:bc39:bd83:9f7%9]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 15:33:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>,
        "raven@themaw.net" <raven@themaw.net>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [REPOST PATCH] nfs: fix port value parsing
Thread-Topic: [REPOST PATCH] nfs: fix port value parsing
Thread-Index: AQHYioWJZklspGquU0m3p/tguyzN061k40UAgACvlQCAAPNRAA==
Date:   Wed, 29 Jun 2022 15:33:41 +0000
Message-ID: <891563475afc32c49fab757b8b56ecdc45b30641.camel@hammerspace.com>
References: <165637590710.37553.7481596265813355098.stgit@donald.themaw.net>
         <cadcb382d47ef037c5b713b099ae46640dfea37d.camel@hammerspace.com>
         <ccd23a54-27b5-e65c-4a97-b169676c23bc@themaw.net>
In-Reply-To: <ccd23a54-27b5-e65c-4a97-b169676c23bc@themaw.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8b1768f-351c-457a-d139-08da59e4bf06
x-ms-traffictypediagnostic: DM5PR13MB1225:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cxUKiWB+cO2FzTmTs5vp0AZWRN3tqkbXcgmcr+8QmKnjHbSJpy4w2j5Dk5fBuBpqaRUfWBx8CRoyPrEIXo2g1a7OAyQXTqo02QDHqjcN+/MI7MtB+Q/ZAE40J5VeSJYAOGgBQKq41gE5al+oghaUqkMWSiAdjAK5WgeDkiQ8FG/IU/UDtL8mptITKmTTSicqHRC/phVTdWG2n2MEn/JEoIWIVtPTfvT89txLQgtR+1Ye4vI+KTi4yumAU8NWw2PTU/HX5kDzg4dsHsDH3SKDMnA5ZUVp1VdhSvTGFSCB1DNyhNJSPHjP7o9/Z7XOokqTdb+bmCD7tTPrWNDBzuExoxZZ4p+ttaCFbx8HjpA9LF+JQpdaC6fHaSwKhVqR+VvxGenKdgiZCNoNtQgpQtmqPCRtzeFpRfyMvKNADWn6r4k6d08H0ojODuaB5nzprimEiwjChMe5jQymLF58InaPw4ZNKfDrvGdmzqaArIazMoRyxe4zVyVabVwjtxu1WoMAJILHu9mGRRT3ophGagZqO56LU7SNKb/VY62RwXI6NOD5YMv1H8mJk76DIcPchBusClO8odOA5WseVf+lygm+/iLeW0T6BJO8q1QDET4py4yGWgxO7cpYjkUd2/y6WTB6BSGYz13m/ee+HSbtz7PGxKpsm3Mzz6zykCakdA/aDOgZirlCyDIaH+sWWOWEn8z6akm+XLNAWrroxrTeFIrrtWWoMqztqRDuk8dPGO2Y3Lz1qrQQJqmI/F+tESNVyGGorcxAbGdE/jcQaVrzaIBMK+lCnkKT+ZX1c9knvsfioDI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39840400004)(346002)(376002)(396003)(38070700005)(6506007)(53546011)(8936002)(5660300002)(110136005)(54906003)(6512007)(76116006)(36756003)(6486002)(478600001)(2616005)(41300700001)(186003)(86362001)(2906002)(8676002)(66946007)(83380400001)(4326008)(122000001)(66476007)(71200400001)(38100700002)(26005)(316002)(66556008)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3ZpdnJsS2VIaytaVDJHVUtrcHY2NWYrQUk5MHgxcFFsa3lPUjlDTURNQnFu?=
 =?utf-8?B?eGg4bWdGUTQxaDdXaGdKVnR1WlVVNDhSdGlsaFFyY01RcEs1N0dUL3Z5TzE2?=
 =?utf-8?B?bzhZdXJ3SjBld0lvR0ozbnhxQWg3SjZubFVnOUNuSWVOYTU1VDUyRUpzY1R0?=
 =?utf-8?B?MTczOUR4ei9sdmxWaUp2Nmo3amZDV05NZ09LVEsrd0hBT1pKRjlNOXFvMVV5?=
 =?utf-8?B?NnVXV2pia2FHL2N0UC9oL1lzdFVDN2xnMkVoU0xkd0ZWM3JxYzR1WGpMcStv?=
 =?utf-8?B?V1I4elNObVR4MG1vVU5lajZOMVZuUjg5RHNGaHloYzZ4YkdiQkhzRDd5V3hz?=
 =?utf-8?B?ZDJuNE9OVXZXcWxZcFBISXIyZjk1bVU4Wmp1cmdOak9DcktOVmUzblRTWmN0?=
 =?utf-8?B?clZNb2J4aFZnT3JxRWc1VEM0SzhGMnpPNW5adTNGUjNtRm9uNGNNbG5URUdp?=
 =?utf-8?B?T3JXK2JXVElhU0ZRUVFXT2twZ1RWV3E0eHVWd1lMRzRjR2h1SStaSmVxU0FH?=
 =?utf-8?B?SmFtTWErOCs4VEI0Z3Z3alp0SUhXc2RtbWUxbnlvdG5Pc2FMcDljeUJaem1y?=
 =?utf-8?B?a1Bsa3puc3ZIbFBCSlBndXhnVUQ1Rmw5UWpnV1FyVjB3eE9Db2o3K0NZZEtr?=
 =?utf-8?B?RjVvRFh0WmYyb1dRUVpSdUFvM2tvcWdHanUyTzQzK1ZzQytpeDZpNzZZMzAx?=
 =?utf-8?B?VFBxTXlDeDlBTHpMVkUvL2Y3T0Y5dXBxNURvU1Z4VGo0Z3JoRTdFdEdveGsx?=
 =?utf-8?B?aGlPWWpmTjhFYTlOZHk1cXpOYVhvWEJZaGZMbHFIaUpiamJmVDV0TDBzZVZs?=
 =?utf-8?B?bGNMVERRSm9kdDIwa2Z4R0I1RUk5UGhNTkx4WjFYYTBTcG8zbyt3MUVrRG1C?=
 =?utf-8?B?TDdvQUU1dEVTdS96Mm1wWTlURUJmTTJ6L0p2K3FGc3hiTTdpZCtHdXZPaWRK?=
 =?utf-8?B?ZVQyYStrUC94THV2d0l0N09Ba3NUK3BiU2pGZEd4blQ1RG0rRDhuN3MxaHdG?=
 =?utf-8?B?SmxKU3I2MHRJYlhuQ0EyKzN6WUs0dGxIMHNyWUVkU1ZBeG0vMzU4R3JRYTFy?=
 =?utf-8?B?WXhnR1RyNmdQYThIT2d0TmN3eHNvY1ZKREh3dHNpQU5kL2VKN0x1R1l1R2lj?=
 =?utf-8?B?S1lUR0tNQWNlbGhCZjFTaE9jQ1JJaDhnSGJOTTdDekRuUy8vYmRlM0JrM29L?=
 =?utf-8?B?aGZwQmVjd080dytpaVBjekZUZzRpMU8rbDBhemppaWk0OURhczRsZzgrRmc3?=
 =?utf-8?B?eTk2cUYvbEluYmNuNDlFaUFZMVFDMFpRN0g1MFdxR282UnNZV2hSOEZybVkz?=
 =?utf-8?B?Ky9VT2liRHE0QWZHeFBCZWIwampVNm5mL2tyV3lzaStPZDVXZXdqM3ExVWw2?=
 =?utf-8?B?SStPRTlETlpGRXZGMzIwbHhMRHUwNFpTa2s2ckhYZmlBTzR4L0Zjd3V0MVY4?=
 =?utf-8?B?emtBTkZuelpDR3czY0RlemJsVCt0WjlpYzdkNEpDS3BFcGVqcVVvZHRCL1dG?=
 =?utf-8?B?ZWh0VlFabWd5NlNXUzVJWU1jSHkzTDc3U1kxUDhJRU1VT3ExYUlQYWhQdXpO?=
 =?utf-8?B?NFFzQVpsbWQ2NWgvaWJqWDJDbEoxYUVvRnAxL2RTNjZWbEhnczFMaDRvT1JZ?=
 =?utf-8?B?V1RhN1lmYmtjS3duRDNwdkJPUVlUL0syWmdwbGFZNGRudFpVVVJYekdSbkhP?=
 =?utf-8?B?ZGFDOUlza0lQMzY1ekQ4cnBsRnNXZlRsVlU0OGthSXRJTkhPMEVkNXdWZDBt?=
 =?utf-8?B?cFV4aitydzlVZXVha0FtaHB6MFNUUVdNWFZVRVd0U25YNjR2U21WTnpzNDZs?=
 =?utf-8?B?UWlNdXBOYVdwWjhQb25ZNUZzdXEwdjVHam5LOTlQdzhBcWFQZUl4ekt2bFVI?=
 =?utf-8?B?U2Q3QUloNjFLV0dBbUhIcWpUVVJCN0JaRVAwcVllTlIyVEEyZk9jY1JEZDBF?=
 =?utf-8?B?ZXcxaWNqWVRQUVlheGlqSi9yamRIRWltaUtVK1NHREdOc1MvSnNBTy9Va2c4?=
 =?utf-8?B?V3g2ZzRCMGN1NGdxV3FxTGN0a1ZyMm9FVmoxNzVMaGx2Wk14WjYzNUZNaS8y?=
 =?utf-8?B?T29xaVg1Z1BiK2l2Q1BTZFhxSHlid1BubXFnOUtlaFhDMktGZlYycmlCN25L?=
 =?utf-8?B?N3lLTFQ5dzJuaGFmZU5vbmY1SjMxM1ExN21pQk5BZDBWYnlkTVJTREtsd1dP?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB49766FB9FD1C479248BBE40703A0E4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b1768f-351c-457a-d139-08da59e4bf06
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 15:33:41.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1ZtuWaqLVwtknGV40SOfuh2jD0TsBixIe+UgsvxaNdPB+4gUu/3+w4gSS2yRxLhsHJHkiRzltcwl6MH5N9xTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTA2LTI5IGF0IDA5OjAyICswODAwLCBJYW4gS2VudCB3cm90ZToNCj4gDQo+
IE9uIDI4LzYvMjIgMjI6MzQsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUdWUsIDIw
MjItMDYtMjggYXQgMDg6MjUgKzA4MDAsIElhbiBLZW50IHdyb3RlOg0KPiA+ID4gVGhlIHZhbGlk
IHZhbHVlcyBvZiBuZnMgb3B0aW9ucyBwb3J0IGFuZCBtb3VudHBvcnQgYXJlIDAgdG8NCj4gPiA+
IFVTSFJUX01BWC4NCj4gPiA+IA0KPiA+ID4gVGhlIGZzIHBhcnNlciB3aWxsIHJldHVybiBhIGZh
aWwgZm9yIHBvcnQgdmFsdWVzIHRoYXQgYXJlDQo+ID4gPiBuZWdhdGl2ZQ0KPiA+ID4gYW5kIHRo
ZSBzbG9wcHkgb3B0aW9uIGhhbmRsaW5nIHRoZW4gcmV0dXJucyBzdWNjZXNzLg0KPiA+ID4gDQo+
ID4gPiBCdXQgdGhlIHNsb3BweSBvcHRpb24gaGFuZGxpbmcgaXMgbWVhbnQgdG8gcmV0dXJuIHN1
Y2Nlc3MgZm9yDQo+ID4gPiBpbnZhbGlkDQo+ID4gPiBvcHRpb25zIG5vdCB2YWxpZCBvcHRpb25z
IHdpdGggaW52YWxpZCB2YWx1ZXMuDQo+ID4gPiANCj4gPiA+IFBhcnNpbmcgdGhlc2UgdmFsdWVz
IGFzIHMzMiByYXRoZXIgdGhhbiB1MzIgcHJldmVudHMgdGhlIHBhcnNlcg0KPiA+ID4gZnJvbQ0K
PiA+ID4gcmV0dXJuaW5nIGEgcGFyc2UgZmFpbCBhbGxvd2luZyB0aGUgbGF0ZXIgVVNIUlRfTUFY
IG9wdGlvbiBjaGVjaw0KPiA+ID4gdG8NCj4gPiA+IGNvcnJlY3RseSByZXR1cm4gYSBmYWlsIGlu
IHRoaXMgY2FzZS4gVGhlIHJlc3VsdCBjaGVjayBjb3VsZCBiZQ0KPiA+ID4gY2hhbmdlZA0KPiA+
ID4gdG8gdXNlIHRoZSBpbnRfMzIgdW5pb24gdmFyaWFudCBhcyB3ZWxsIGJ1dCBsZWF2aW5nIGl0
IGFzIGENCj4gPiA+IHVpbnRfMzINCj4gPiA+IGNoZWNrIGF2b2lkcyB1c2luZyB0d28gbG9naWNh
bCBjb21wYXJlcyBpbnN0ZWFkIG9mIG9uZS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
SWFuIEtlbnQgPHJhdmVuQHRoZW1hdy5uZXQ+DQo+ID4gPiAtLS0NCj4gPiA+IMKgwqBmcy9uZnMv
ZnNfY29udGV4dC5jIHzCoMKgwqAgNCArKy0tDQo+ID4gPiDCoMKgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2ZzL25mcy9mc19jb250ZXh0LmMgYi9mcy9uZnMvZnNfY29udGV4dC5jDQo+ID4gPiBpbmRleCA5
YTE2ODk3ZThkYzYuLmY0ZGExZDJiZTYxNiAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25mcy9mc19j
b250ZXh0LmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9mc19jb250ZXh0LmMNCj4gPiA+IEBAIC0xNTYs
MTQgKzE1NiwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZzX3BhcmFtZXRlcl9zcGVjDQo+ID4g
PiBuZnNfZnNfcGFyYW1ldGVyc1tdID0gew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgZnNwYXJh
bV91MzLCoMKgICgibWlub3J2ZXJzaW9uIizCoMKgT3B0X21pbm9ydmVyc2lvbiksDQo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3N0cmluZygibW91bnRhZGRyIizCoMKgwqDCoMKgT3B0
X21vdW50YWRkciksDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3N0cmluZygibW91
bnRob3N0IizCoMKgwqDCoMKgT3B0X21vdW50aG9zdCksDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqBm
c3BhcmFtX3UzMsKgwqAgKCJtb3VudHBvcnQiLMKgwqDCoMKgwqBPcHRfbW91bnRwb3J0KSwNCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoGZzcGFyYW1fczMywqDCoCAoIm1vdW50cG9ydCIswqDCoMKgwqDC
oE9wdF9tb3VudHBvcnQpLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV9zdHJpbmco
Im1vdW50cHJvdG8iLMKgwqDCoMKgT3B0X21vdW50cHJvdG8pLA0KPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgZnNwYXJhbV91MzLCoMKgICgibW91bnR2ZXJzIizCoMKgwqDCoMKgT3B0X21vdW50dmVy
cyksDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3UzMsKgwqAgKCJuYW1sZW4iLMKg
wqDCoMKgwqDCoMKgwqBPcHRfbmFtZWxlbiksDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBmc3Bh
cmFtX3UzMsKgwqAgKCJuY29ubmVjdCIswqDCoMKgwqDCoMKgT3B0X25jb25uZWN0KSwNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoGZzcGFyYW1fdTMywqDCoCAoIm1heF9jb25uZWN0IizCoMKgwqBP
cHRfbWF4X2Nvbm5lY3QpLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV9zdHJpbmco
Im5mc3ZlcnMiLMKgwqDCoMKgwqDCoMKgT3B0X3ZlcnMpLA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKg
ZnNwYXJhbV91MzLCoMKgICgicG9ydCIswqDCoMKgwqDCoMKgwqDCoMKgwqBPcHRfcG9ydCksDQo+
ID4gPiArwqDCoMKgwqDCoMKgwqBmc3BhcmFtX3MzMsKgwqAgKCJwb3J0IizCoMKgwqDCoMKgwqDC
oMKgwqDCoE9wdF9wb3J0KSwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGZzcGFyYW1fZmxhZ19u
bygicG9zaXgiLMKgwqDCoMKgwqDCoMKgwqBPcHRfcG9zaXgpLA0KPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgZnNwYXJhbV9zdHJpbmcoInByb3RvIizCoMKgwqDCoMKgwqDCoMKgwqBPcHRfcHJvdG8p
LA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgZnNwYXJhbV9mbGFnX25vKCJyZGlycGx1cyIswqDC
oMKgwqDCoE9wdF9yZGlycGx1cyksDQo+ID4gPiANCj4gPiA+IA0KPiA+IFdoeSBkb24ndCB3ZSBq
dXN0IGNoZWNrIGZvciB0aGUgRU5PUEFSQU0gcmV0dXJuIHZhbHVlIGZyb20NCj4gPiBmc19wYXJz
ZSgpPw0KPiANCj4gSW4gdGhpcyBjYXNlIEkgdGhpbmsgdGhlIHJldHVybiB3aWxsIGJlIEVJTlZB
TC4NCg0KTXkgcG9pbnQgaXMgdGhhdCAnc2xvcHB5JyBpcyBvbmx5IHN1cHBvc2VkIHRvIHdvcmsg
dG8gc3VwcHJlc3MgdGhlDQplcnJvciBpbiB0aGUgY2FzZSB3aGVyZSBhbiBvcHRpb24gaXMgbm90
IGZvdW5kIGJ5IHRoZSBwYXJzZXIuIFRoYXQNCmNvcnJlc3BvbmRzIHRvIHRoZSBlcnJvciBFTk9Q
QVJBTS4NCg0KPiANCj4gSSB0aGluayB0aGF0J3MgYSBiaXQgdG8gZ2VuZXJhbCBmb3IgdGhpcyBj
YXNlLg0KPiANCj4gVGhpcyBzZWVtZWQgbGlrZSB0aGUgbW9zdCBzZW5zaWJsZSB3YXkgdG8gZml4
IGl0Lg0KPiANCg0KWW91ciBwYXRjaCB3b3JrcyBhcm91bmQganVzdCBvbmUgc3ltcHRvbSBvZiB0
aGUgcHJvYmxlbSBpbnN0ZWFkIG9mDQphZGRyZXNzaW5nIHRoZSByb290IGNhdXNlLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
