Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68FD4C60A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 02:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiB1Baf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 20:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiB1Bae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 20:30:34 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2126.outbound.protection.outlook.com [40.107.95.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346D6AA7B;
        Sun, 27 Feb 2022 17:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECJa/d+ClflAQdEHfq4K/Q00eC+A7FyA0D6XRT/7eqtQMANGdQR5WGZ1eimLy5/Y3Bz6I36sWTYYD96IaBYpZVfuwy4+kxSV3FNO5ttAlZkbPZdpe7RQ44MUb+rpp975pBh9fwpm+lH/hj+vFSolENT0mzLChWKC/c25jF6ZB936lJVkHoE7PF/iGxlzEFPBwO4H/2x9Cy0XfghqitCZHMkfurFecmzZl8EpDFTFwvYppkUh9aSzbcPiE1YehKa8moiqJAtNiHeuLg5dueTme7CCNUo2o3vHY9fTaCrUiTERhv2TWEVI2nCQi7OE/F2mp/+Mnaawm3263iMluH4DsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmCTe5RM86MgZFshbD4FRCYWEVvw7twKaWbiawNEG4w=;
 b=MZaw6h3Uh3UZ9ud4yShyiCtqp+DYR9zapMZJ19bhxaw1bSvFWlcQ415ly8A6zq4efI9DTHQ3IA2KhhJYD2eBc6WkroH5OygyHtlO9fbh+omsJHMThBr28KcYHrrBqa+hDEiuOg78Khcla4Of/hvyIYcoBhzIud9gSkqag1SKL8dHhrhDSKpabVKEBY+e3r3ebh5tdaSGOpNbA6aMu3lJIL21PVhbcmxNwIzXGaQZHo/SR9fPiPwmuhM99Gb7OHdHfpX1lkJWQ1OM3457Vpr143ltWOnNhRgaacoZLV95RrxFQSP6rH8Fa8PoGheyms7p73Wdx36dMAIfXZHnInpWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmCTe5RM86MgZFshbD4FRCYWEVvw7twKaWbiawNEG4w=;
 b=FjQGzHyf3eGFGFc1kqWi7ERe1w8tIZZB12AmMCZskjeDhy4IY/7kLauE4D2FRU3FRHsBpi66ax60FwPVMSnHP4I6lU7Q0wrlEcMtt7BSgXWCPUCrTx02ihKYPOfqtqon+wWsBkIbaaij27mclpu0KU94JvOCrEkoXpf2oQcVyHY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3605.namprd13.prod.outlook.com (2603:10b6:610:2c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Mon, 28 Feb
 2022 01:29:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.013; Mon, 28 Feb 2022
 01:29:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] Convert NFS from readpages to readahead
Thread-Topic: [PATCH 1/2] Convert NFS from readpages to readahead
Thread-Index: AQHYD9JZMpH99jSHC0aEacDA4/4++6x9QQGAgAsb8gCAADpjAIAchimAgANIOQA=
Date:   Mon, 28 Feb 2022 01:29:53 +0000
Message-ID: <07857ce5e6455616f2269707db81ed679df3c6f7.camel@hammerspace.com>
References: <20220122205453.3958181-1-willy@infradead.org>
         <Yff0la2VAOewGrhI@casper.infradead.org>
         <YgFGQi/1RRPSSQpA@casper.infradead.org>
         <a9384b776cc3ef23fc937f70a9cc4ca9be8d89e0.camel@hammerspace.com>
         <Yhlku5//fKl1cCiG@casper.infradead.org>
In-Reply-To: <Yhlku5//fKl1cCiG@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96aa834d-bbdb-4ac9-29a2-08d9fa59d228
x-ms-traffictypediagnostic: CH2PR13MB3605:EE_
x-microsoft-antispam-prvs: <CH2PR13MB360509FF115382635DAF62F9B8019@CH2PR13MB3605.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24haYgekwV8IkMAC5zBv/CnsNzpuFhIbkaQwof7TANI6CVoV3qWnnVxjkVEayCwWsZf8pMsteFKf4jx07cQweeFe65fds27avEykXteK0wYSlexYCt/lGVB6o1kY5b9qEgAHxdo6jhl37fRMZknKG/FY63CluHWVkn13Lby50PoIplA32apACGqemy9NpaIsQECOo2nMPcfdedd2jcO++B4dB/cIODLn1X8k0moiqdCajwlmpXgM9FOSqhcIj+NSEtCMJp6B+azNdX7lijYp10Ufk8Smo1rF5h/QsI+J5BklX/z9/VoFzMe7vW0NobmKi6rc0Fze/pVS51Obuk/KwbwERzfOeeNOmwvI8OuB2rpOSnpn+AaUMN995aEaZMC/MmvTr+kaX9xeHWeLcBc8WK6cg/pmSh8XZkii4IQbINfz9G9OlQjfvKJ7n8bTDeboSIOqdWXqWhYHbEmrpOqzrUvuyp/StyPD64MgCXVuYZ+no57FEwUtyIumEsmDKVQqBzftc13LQbIezwt76zb4Hnps1Tye3vS5Xxbk9moEU9oayAoROo+W/4rabb2uqU9i13c/JY74Mj1502mdrEEMl4UyASL42LwszqPOWg4hV7OvwwZABWqxS5A+PN1JNUy2ob9DLuOsIxMF/o+vAh44cY7stF9HWWoiY5x8h7zvhmdMIW4JN8YDHmJVmw2Ne8eAFh703aLIV9+hCsb4CtfwAmZa5Fvc19H2tg/5/rE3Hi791ekGC12160qqsXtSV7rI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66446008)(5660300002)(66476007)(66946007)(76116006)(38070700005)(64756008)(8676002)(2616005)(8936002)(83380400001)(4326008)(6512007)(6506007)(54906003)(6916009)(36756003)(122000001)(71200400001)(26005)(2906002)(508600001)(86362001)(316002)(6486002)(186003)(38100700002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTUydTEvMkVkdGppYjNuOGNqeEpiSCtzYmR2M1ZaOGwxSjhHSTR6OFlIK2hY?=
 =?utf-8?B?S0U4blUybDAxc1h5SmFwb0ZkQm1lTGgyZGlFSm1uS3h1V2xCbnJSeklVYng3?=
 =?utf-8?B?a2RrODEyTFI2TnJvd1dMZGE1UUhqNFR0eUxBSHVod0tzSWszaWhicG8zSEQ2?=
 =?utf-8?B?MW0wY01TTzVjMmtBNVVtM08waGZVZGNzMlREa0pKaUdYcm5RZ2NUenVtY3RD?=
 =?utf-8?B?UzdnNVFDN20xQVNtdmlPV0NrbWw1ajBOb3h5cU5lVDZucFBxbjE2Y2V0OG1V?=
 =?utf-8?B?RG9INjZlR2lUOGQ3aVZuejhrVHhBVXptdm9aa0I4U1oyTmxIR3paK2Y4NTM2?=
 =?utf-8?B?NG56ajVuYkJnYkJmVnQvWW9zMDgzQ3FERFQyWFpoYW50Ly9ORDJKRjY1UllE?=
 =?utf-8?B?NTJod3ROa3JGZE1UK2F6Q1kyTFJKQkJFWTY3U25xeXRKSDFDY2ttTmhiWlRv?=
 =?utf-8?B?VDc5MTl2RS9sTG5LSjllZmRyd0xCa1pSNkJKVFgwcHlqeCtSeHYzOGtXRjIx?=
 =?utf-8?B?YzRKUVE5Y1Q0VjVidzNMVklodUdpdlg1UHkrYThudnNkQnExZysvWmwrR1gw?=
 =?utf-8?B?NDFnbU15amVIb01ybHlOWTVSUUdBQmFMc3B4c2x4WDcweXMzMVd6R2FpYUt5?=
 =?utf-8?B?VXRjQjh1YVZCNnlZVlNybndqWTQwNVRtNnZHRFcweXZCaWw5a0tlMnBiZUFq?=
 =?utf-8?B?RGRiM1EvU0JDaVNtcTVvOFFGSDdmdG1vUnRqYmhOc21BZlNTeDdJcEZ1K3VJ?=
 =?utf-8?B?KzNKVllUMDJzdG1CRTljNjJycm9hTFVUaXRuOW44ZE5kQkpTMXFHeW1YaWVI?=
 =?utf-8?B?MmxqdnBhcVlyWVFzdmI1QVNRN2lpMGxCZ1AwWDNJU3N5NnFRUmxrakI2VnFv?=
 =?utf-8?B?Y2ttTzZYeHU4d0tGeTRFV3N6b0lUZ0F6UHRRUDk0QmVHYTVRU3BhWVZlTGor?=
 =?utf-8?B?NzhYMHljQlFXTlQvMEtKV1NBekszSjRZWUNQVkxZZElBTWJJclkvcmM4SUV2?=
 =?utf-8?B?ZG1ieWRZQVVhNkRkYVg0TktSTWEycHNDMkdrOVRiNGhuaS9HelZzUHhCazdQ?=
 =?utf-8?B?Z0JpVm9NYVl4ZTJrKzd5L25wS1Z2K3VyWWl6Q2xkcWRFNWMyOW9YTlptSHIy?=
 =?utf-8?B?TjRpWk54VEVqclRXZ1BSbkx0TUZPblQ5Z05mWnFsdVpDT29VWU96U09HdGRP?=
 =?utf-8?B?by84bjF2LzdMbkorN3VHdU82VWM2VTU4OEhDN2MrcmV0T2tObk5vYnY2ZjNX?=
 =?utf-8?B?Zm1UZ2JUQkpHZ0tBSm5ack5mU2RkTU9RU24wYlBEaGxOaEE4VlBxbWsvRVB1?=
 =?utf-8?B?U1ptN2FqM3dBTnkyeVB4TUdPZzc2SEJaWUQxTERnMnU2VGJYdy82THdrb0xH?=
 =?utf-8?B?WEQ5cEszdVRMK25VeUNlZG82UEgzcTRzMTZHRkxTSjYzUlppUk01eW8wVG1B?=
 =?utf-8?B?cHQ0RGQ0K1dsZWZOSFhaM1dvc04zaC8yK1BSUWZFK3VYZFhWYjdWMVZPMGFG?=
 =?utf-8?B?akdFWDN5QnI4YzJKNENyeHEyNnZPU0habE5QblRaejdLdVJLbVFNUGc5VjZS?=
 =?utf-8?B?b1NmY1Q5MHJtN04xVzRQTkg2allZQzBvanFjTnB0Rm9hakN6Y3FvN3V5MS83?=
 =?utf-8?B?U0tKRE1uSk55bVFHTUlqbjc5TEViOFg1M3RxVnhQM2lMYUFLaG81UHpCZ24y?=
 =?utf-8?B?WWE2RW1rbEVjTlQ5SFVPUytselRTWmNFay95YS9LSXdCNitpMU5oMTMrOVlX?=
 =?utf-8?B?SmJ2UlVIK1A5b3ZlcGMyRUNoeS9wVktEc0dlVkdqZVAyMHk4anhVQ0Fld21K?=
 =?utf-8?B?TDZ5ckVOaUlqazhXcmNUL09wbFZJbnBjSmJBMXpXY1ZCWEUxU3NaU2lXMWEv?=
 =?utf-8?B?Z2tvUG9mVFNJR2ZZMHRtd1ZLTTN6T0hRbWxyb1RDc0ZGaWJIV1A3Rkw4OE9N?=
 =?utf-8?B?dTJqY2s5cG1TU0Y4cVhoWlhnN2xmR1hHZVVwL2R4ZGZPZEZ2aHhQNWNHRmoy?=
 =?utf-8?B?VE8yVWhWMC9ybEYvSExDZlBxMXVHd2V1Uzd3b0NkM0g4Z1NaRDFKS1BSOXlN?=
 =?utf-8?B?TVhrM1JlZ3IyNUtPYVdTc2luMjRWay9Dbmk1a2t6bDBUUUZ6K1dOdVVZQ09k?=
 =?utf-8?B?MnBSYUNuL0RYSDZRKzJ5dEZZbFhnamNvVnJGVXU4bFdwa0hSczZzUFRINEZt?=
 =?utf-8?Q?bUS5RQpCx4xLsUNIzKTupkg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7DE004CFEE57148A13638398640F536@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aa834d-bbdb-4ac9-29a2-08d9fa59d228
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 01:29:53.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6OSxENx3dy/vo+64rOIJtLmUOOqBPGYjjYcGnGkd1ur80KnrYE9upNaSRcifMuaU3Wrs5C9IPq309AyrWpxoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTI1IGF0IDIzOjIyICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gTW9uLCBGZWIgMDcsIDIwMjIgYXQgMDc6NDc6MDhQTSArMDAwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+IEkgYWxyZWFkeSBoYXZlIHRoZW0gYXBwbGllZCB0byBteSAndGVzdGlu
ZycgYnJhbmNoLCBidXQgSSBjYW4ndA0KPiA+IG1vdmUNCj4gPiB0aGF0IGludG8gbGludXgtbmV4
dCB1bnRpbCBBbm5hJ3MgcHVsbCByZXF1ZXN0IGFnYWluc3QgLXJjMyBjb21lcw0KPiA+IHRocm91
Z2guDQo+IA0KPiBIZXkgVHJvbmQsDQo+IA0KPiBJJ20gbm90IHNlZWluZyBhbnkgcGF0Y2hlcyBp
biBsaW51eC1uZXh0IHRvIGZzL25mcy8gb3RoZXIgdGhhbiB0aG9zZQ0KPiB0aGF0IGhhdmUgZ29u
ZSB0aHJvdWdoIEFuZHJldyBNb3J0b24sIEplbnMgQXhib2UgYW5kIENodWNrIExldmVyLg0KPiBI
YXMgdGhlIGxpbnV4LW5mcyB0cmVlIGRyb3BwZWQgb3V0IG9mIGxpbnV4LW5leHQ/DQo+IA0KDQpT
b3JyeSBhYm91dCB0aGF0LiBBcyBJIHNhaWQsIEkgd2FzIGZpcnN0IHdhaXRpbmcgZm9yIEFubmEg
dG8gbWVyZ2UgdGhlDQpyZW1haW5pbmcgNS4xNyBmaXhlcywgdGhlbiBnb3QgZGlzdHJhY3RlZCB3
aXRoIG90aGVyIHdvcmsuDQpIb3BlZnVsbHkgaXQgc2hvdWxkIGFwcGVhciBpbiBTdGVwaGVuJ3Mg
dHJlZSB3aGVuIGhlIHVwZGF0ZXMgaXQuDQoNCkNoZWVycw0KICBUcm9uZA0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
