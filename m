Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE64C48395A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 01:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiADAE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 19:04:27 -0500
Received: from mail-sn1anam02on2102.outbound.protection.outlook.com ([40.107.96.102]:3908
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbiADAE0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 19:04:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDK66bpg/rOehvy/OgJHAcsD5zGCFZTrXJaI0YF2gXqIWMCUIFPDQ4xHkRkc8kBoyCioKp3lJtVm3XMtVM12hnMmadyqw5bvVFkQTETON6E1B3x++g9xqIEY8vi37mLQ4CPlXH86SzZQ1XU9giCto7xbRP/kfKPRYEVanrXKsGbwZURUHIDFNVUw8GQTxWLC5p8AhLU7oBn10jNiKesul4sdHX7OQJRzI+a3Ed04tR69ne5BI7UO79P2YrH8qt0FwdvoRp9euRIaGzhJL+lZKk4aPAz30+FrRv6WlCEQuJBXUdQRO6NJYFiszX4hWVrulH0s2dX7gwDTcozOnBRSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZCohA5A1RvIOosMi09ZN9IT7kfXfLElCk4Dvpqwr+w=;
 b=e2yf4gw4JcwpOPX6AWWlcGt0yxhpgAFhOqzkiqjMDJ1NQX86mIBWHBexKEaMTZ2gxr29wAEdfzsH7Zs/kjsczm7HwmT4278G5zoqydQIM7tKxQvO40qNz7rxcX4Fz4cB0dQ23ue2t9x5oa9Fev6njC/ovZPTBXjpaWm/yb1Dj16Bht7FUVCYhNLfq4lUOyX4Wdt2NpcG8gH+dkJxr4npRFtR2MwT1eENdYslKrxet2gN0KI2JODg0054CDS5KiQngLCkz4pOYgMYuNfOTUBeA8I9tqMrIUFIiijESsHHoeKGt9Fj2z7OsdwE33O28nYZzyZJHHqQB6nrhbP50VoJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZCohA5A1RvIOosMi09ZN9IT7kfXfLElCk4Dvpqwr+w=;
 b=OEUhdkU8cDOcMdkTgZ273+LZ8WVBVxZZU5jtUWtpcKdmu0NrOGv89MQb4ePbw9GC8mxiuKd/nFvEJFtnuaLvKzHMZLA1pv5BdHUbMWtN8UTw4XOd7veQPDlQPaN4weo3oPQ0OOPe9xKsOn7pbSfidnnte4ymErFDc+Sirkce+cs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR1301MB1959.namprd13.prod.outlook.com (2603:10b6:910:40::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.6; Tue, 4 Jan
 2022 00:04:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.006; Tue, 4 Jan 2022
 00:04:23 +0000
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
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xL0+EAgABMs4CAAWrGAIAA5lqAgANuRQCAACHbgA==
Date:   Tue, 4 Jan 2022 00:04:23 +0000
Message-ID: <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
References: <20211230193522.55520-1-trondmy@kernel.org>
         <Yc5f/C1I+N8MPHcd@casper.infradead.org>
         <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
         <20220101035516.GE945095@dread.disaster.area>
         <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
         <20220103220310.GG945095@dread.disaster.area>
In-Reply-To: <20220103220310.GG945095@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f503745c-09da-4492-5d4b-08d9cf15c3e9
x-ms-traffictypediagnostic: CY4PR1301MB1959:EE_
x-microsoft-antispam-prvs: <CY4PR1301MB19594302706C143543615002B84A9@CY4PR1301MB1959.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HQctczq9GIrFt+nF7BSEvzX1nEdyQb9lqcvS4YxD9szezr26G2sTpKUC6KRRriLVeheLZ8Ahua3jUI2hEffRsvGdVq9B9Df5oL5Vk8+qx14xWTI+/y+WegltoU3ldRX9rj9bNs7YSxAM0h47uD/PfExPw/hwKa8o0Ix+hmjz7ubebZRReqhyIwJW9XvGwp68377fOLA4Kjj0EPORDLQmo9hmPEacy+0yMHoHcTCxiE+d1c+UnxT/qf+c0fRqRq+vw33Atd1pi5csNgqZ0HgX6TS42HU6TUhrRLKA+gVyE+XUfc0HKMLyvBoXZN2hhWnh9S4Jq4G/QqV9LqJRdBwNNbSAfXkwTtSlH14DhkOt5A1VvSUYXIJ3luBvTqpCH6LvTFb/JlSBmVg+MkV0KgLFLB3EK4u9CNfkkKmIgxPI3m7d1Ku0CbZ57e+Vpn19gEONrQhmEqfdzoGO0C3Yha270dCMu9nOrF0NZ3M7I1ZKKIGf1qB12Q563yPp8rQjtm5pJFjPzKQdCndDIMTFWlma7MThHEpx3XKogrUlcMrYSR1ue8ihYZrFtU+ApupA7Jz6NEJjjLmq1mXcdZg/k0ftGYjp0WvdilNrOlxb8AqJ4OouADY/MlYnpKrgTWbe3KlP9DswAxL39EsxKF2vBpoCamQFMlu7A9KQO9wVNNBfgxcnk+BCRqnvcAmJ1fcBs9LYsCQjJIIqvJEanxeuPS05tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(396003)(136003)(39830400003)(366004)(316002)(71200400001)(508600001)(122000001)(26005)(38100700002)(186003)(6512007)(6486002)(76116006)(6506007)(54906003)(86362001)(6916009)(2616005)(2906002)(83380400001)(38070700005)(66556008)(5660300002)(66476007)(8936002)(64756008)(66446008)(36756003)(66946007)(8676002)(4326008)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2NsSUp2VEcxMjNCUFNiUisveVRybUxCNDhwNkpTUndGM0kxdzRvczBHRFE2?=
 =?utf-8?B?SzFjeTZDdGJMelEwSElLcWNXcTBKNWNuOXZZZ1VwdmJmeDJWeGhPS3VISnNr?=
 =?utf-8?B?UW9qZ003dkV5bW42V1J0WEM1V1creUR1WG9HL1VBQlJrY3lDcTBrTWdyUE1Y?=
 =?utf-8?B?K1NSOHFpdGh0UVZMM3NXdGFyV0orcWtESmdXTCtJTXR3bnl6S0hZWmorcTdj?=
 =?utf-8?B?Ni9vWHNLME9tcVk3QnI1UlB4ZnY2NFMxZVQ1MXFjY0pJRDJwTTR0aTdCaDd0?=
 =?utf-8?B?NTBHdmU4Vzl3dzZwN3lHRVZIeUJuREJmVDllZWNzZHNpK2p6TUkxTGUxNnlC?=
 =?utf-8?B?eUtadHNWZzdST3lqaFo5Snp2NE9tVFZvbUNpSk8vbFlqUllvNHl4Q2N5ME5k?=
 =?utf-8?B?QzIwU3ZtNktXTG9UYnBPSTFhRndFcU9YYTYzVnB0bTBZMUZZTnFoWE9MdTNu?=
 =?utf-8?B?cy9EQ3h5emFQRDl4V2RZMEgxUEd0Q0NTYU45d3dEQ082SkFlVzdMVTNkc3B3?=
 =?utf-8?B?UFlPUmtuR2lOemFLaWxLZENjRDc1dkhoUWFNeEEwOTVRQkZKQm1FZTllcGU1?=
 =?utf-8?B?WEhqOXZEc05aTTR1eE9yd2orOVVzSlZhQko1RXJXcDc5dzIxb2RndjNGSk55?=
 =?utf-8?B?ZFgzUkJzVW9wQldLUmdQTTl0Z05EMFE1WkFxZnpwME5uOGRPNlFteGVjRVpi?=
 =?utf-8?B?Zkh3dzhzZ09BSFZ5NGV6RUdjcUYvT3dMVzB2WHZuY2llVjdBamxhRkFIK0pX?=
 =?utf-8?B?cnJNL0g2N05nNGxaeWk1ZTVhaTlORC9RRHlNNVhGbU01Mml0NUdzRUIyYnJC?=
 =?utf-8?B?aFNMQ2tKbVRHeFVlR2FKcjRMdElBVGR4Sm51bFhoTmFMNlBrb3lOTmN0YzJ2?=
 =?utf-8?B?UzNraUZSaXM1dFJFSkRqL0ZQeCtSZG5ZQXRzcUhUU1RpUHdzcFRWMHJWdjJQ?=
 =?utf-8?B?MHp3d1RPcmhhYWI0bmlyTTZuVzh3V29kSmxBdkkyYWFMRW40WG9QMkZoR1d3?=
 =?utf-8?B?YllXaUIvNXpBbk5WM2JVckxRaFdtbXN4ME81Q3k0TkVneTZ5WVNmQW9hbmdq?=
 =?utf-8?B?Z09uMDlwdVlhSm5mL01mT2EyS0oyMHFwR2QxbU0vVmt1d09LT09Ncjh3b1Av?=
 =?utf-8?B?TkkyNjB3Y2Fickd5bFpuQlZFVHhSNU8yb3FTUXh4KzBDNExWUHN1UDVRL2dW?=
 =?utf-8?B?UEtvdDU0dW9qVWkvcUtySjFPWGpJbVpmejlPbnIzVGpFM0w3UENHWWgzbW01?=
 =?utf-8?B?SWdJOHU0NXFEMEFOeVdkOG10bjNEWEFmMnJSNGJrK1h2dE9ob3lxZUI0K21T?=
 =?utf-8?B?NWhVbmJ4RGdtYk8rZTUxVXpMSXR4amt0QVpWQmN0Wll2eEh0K0R5b1JNdzdk?=
 =?utf-8?B?SVR6S0hMcDUrZVYzU3JobStMMi9SN0U1dTdieGcvYWhGbzY0cGlXNUVhZ2dU?=
 =?utf-8?B?SXN4UzA1ZzFzdHNwUGVVeTJyNmcvWWduN3g4TFBxK1VGYlhTVit1UVFGNFR5?=
 =?utf-8?B?UnFKc1JCMTh3YnBPN1pkYm0yMTZmL25ZaFJHaFVWMEgwSmZJeHB0QlVnUjhr?=
 =?utf-8?B?WjRVQXdtTkN1ZktxWGxHVmlXZ0ZiVnFEVWtXOTc1ZEFKV0k2NXJYK1M5YkQ0?=
 =?utf-8?B?eTVPNHJtSXdUdEF6cGE4QzdVMXdVVHhURzQyK3BxWmdFQnZzbG9QVnM4Q09B?=
 =?utf-8?B?T09JNjRaK2RqSDZXb2x5emdrTzh5cVNMUzJVM0pDTlV2UUVlWHhhZXRpVnBT?=
 =?utf-8?B?TUlIZjhGZlRWZVl6SWU5ZWVmZlFRWlRxRnhRckhiZFozdGN0Ni9kOXhlUTZ0?=
 =?utf-8?B?c1A3SzJYWVpPaDF2SDFMZndHdkVsb2k4WEIzK2xRWnpMNGVLTTdBYmREYmpF?=
 =?utf-8?B?OWs5K2JQbktGMTBRSkIrd3dKbFdHTmhlUmxBOWxMRnNHaWxqYTVmL3V3ZVMv?=
 =?utf-8?B?RVlsVWxoNXExTjJVckoySEdhb1k0amFqenpnZjFmM1pHUWU5YVMyV2k0V2RO?=
 =?utf-8?B?OUtXMkx1ZlNvc0oxeGk5aVlNeGtCVDBqeGI0MjY4eGVwT0xtZmxPc0wwODJT?=
 =?utf-8?B?aDNvYmV1MU1wSmQyN2wxc240VDhLOE5ncDY5cmo1WXBXT3BRd0ZoeFRRL0xG?=
 =?utf-8?B?MUduODVGSnJlVm1jdTZqTGRuY2R4VitqbHN4aVRaa2pHZjlXcFY5S0Y0S3BM?=
 =?utf-8?Q?zhBPIxWCIXTV5pMz3AyKhaI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF908C472A37DE41A2EFF4391508A620@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f503745c-09da-4492-5d4b-08d9cf15c3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 00:04:23.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqQqrn6MoTygsYR0cRYUPlneHgJp0AgH4y3zMBHfuar1K1Alxn/tRcRYmA1Ftqekp0Lb4qL0NWLMWiEIiAPfWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB1959
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTA0IGF0IDA5OjAzICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFNhdCwgSmFuIDAxLCAyMDIyIGF0IDA1OjM5OjQ1UE0gKzAwMDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBPbiBTYXQsIDIwMjItMDEtMDEgYXQgMTQ6NTUgKzExMDAsIERhdmUgQ2hp
bm5lciB3cm90ZToNCj4gPiA+IEFzIGl0IGlzLCBpZiB5b3UgYXJlIGdldHRpbmcgc29mdCBsb2Nr
dXBzIGluIHRoaXMgbG9jYXRpb24sDQo+ID4gPiB0aGF0J3MNCj4gPiA+IGFuIGluZGljYXRpb24g
dGhhdCB0aGUgaW9lbmQgY2hhaW4gdGhhdCBpcyBiZWluZyBidWlsdCBieSBYRlMgaXMNCj4gPiA+
IHdheSwgd2F5IHRvbyBsb25nLiBJT1dzLCB0aGUgY29tcGxldGlvbiBsYXRlbmN5IHByb2JsZW0g
aXMgY2F1c2VkDQo+ID4gPiBieQ0KPiA+ID4gYSBsYWNrIG9mIHN1Ym1pdCBzaWRlIGlvZW5kIGNo
YWluIGxlbmd0aCBib3VuZGluZyBpbiBjb21iaW5hdGlvbg0KPiA+ID4gd2l0aCB1bmJvdW5kIGNv
bXBsZXRpb24gc2lkZSBtZXJnaW5nIGluIHhmc19lbmRfYmlvIC0gaXQncyBub3QgYQ0KPiA+ID4g
cHJvYmxlbSB3aXRoIHRoZSBnZW5lcmljIGlvbWFwIGNvZGUuLi4uDQo+ID4gPiANCj4gPiA+IExl
dCdzIHRyeSB0byBhZGRyZXNzIHRoaXMgaW4gdGhlIFhGUyBjb2RlLCByYXRoZXIgdGhhbiBoYWNr
DQo+ID4gPiB1bm5lY2Vzc2FyeSBiYW5kLWFpZHMgb3ZlciB0aGUgcHJvYmxlbSBpbiB0aGUgZ2Vu
ZXJpYyBjb2RlLi4uDQo+ID4gPiANCj4gPiA+IENoZWVycywNCj4gPiA+IA0KPiA+ID4gRGF2ZS4N
Cj4gPiANCj4gPiBGYWlyIGVub3VnaC4gQXMgbG9uZyBhcyBzb21lb25lIGlzIHdvcmtpbmcgb24g
YSBzb2x1dGlvbiwgdGhlbiBJJ20NCj4gPiBoYXBweS4gSnVzdCBhIGNvdXBsZSBvZiB0aGluZ3M6
DQo+ID4gDQo+ID4gRmlyc3RseSwgd2UndmUgdmVyaWZpZWQgdGhhdCB0aGUgY29uZF9yZXNjaGVk
KCkgaW4gdGhlIGJpbyBsb29wDQo+ID4gZG9lcw0KPiA+IHN1ZmZpY2UgdG8gcmVzb2x2ZSB0aGUg
aXNzdWUgd2l0aCBYRlMsIHdoaWNoIHdvdWxkIHRlbmQgdG8gY29uZmlybQ0KPiA+IHdoYXQNCj4g
PiB5b3UncmUgc2F5aW5nIGFib3ZlIGFib3V0IHRoZSB1bmRlcmx5aW5nIGlzc3VlIGJlaW5nIHRo
ZSBpb2VuZA0KPiA+IGNoYWluDQo+ID4gbGVuZ3RoLg0KPiA+IA0KPiA+IFNlY29uZGx5LCBub3Rl
IHRoYXQgd2UndmUgdGVzdGVkIHRoaXMgaXNzdWUgd2l0aCBhIHZhcmlldHkgb2Ygb2xkZXINCj4g
PiBrZXJuZWxzLCBpbmNsdWRpbmcgNC4xOC54LCA1LjEueCBhbmQgNS4xNS54LCBzbyBwbGVhc2Ug
YmVhciBpbiBtaW5kDQo+ID4gdGhhdCBpdCB3b3VsZCBiZSB1c2VmdWwgZm9yIGFueSBmaXggdG8g
YmUgYmFja3dhcmQgcG9ydGFibGUgdGhyb3VnaA0KPiA+IHRoZQ0KPiA+IHN0YWJsZSBtZWNoYW5p
c20uDQo+IA0KPiBUaGUgaW5mcmFzdHJ1Y3R1cmUgaGFzbid0IGNoYW5nZWQgdGhhdCBtdWNoLCBz
byB3aGF0ZXZlciB0aGUgcmVzdWx0DQo+IGlzIGl0IHNob3VsZCBiZSBiYWNrcG9ydGFibGUuDQo+
IA0KPiBBcyBpdCBpcywgaXMgdGhlcmUgYSBzcGVjaWZpYyB3b3JrbG9hZCB0aGF0IHRyaWdnZXJz
IHRoaXMgaXNzdWU/IE9yDQo+IGEgc3BlY2lmaWMgbWFjaGluZSBjb25maWcgKGUuZy4gbGFyZ2Ug
bWVtb3J5LCBzbG93IHN0b3JhZ2UpLiBBcmUNCj4gdGhlcmUgbGFyZ2UgZnJhZ21lbnRlZCBmaWxl
cyBpbiB1c2UgKGUuZy4gcmFuZG9tbHkgd3JpdHRlbiBWTSBpbWFnZQ0KPiBmaWxlcyk/IFRoZXJl
IGFyZSBhIGZldyBmYWN0b3JzIHRoYXQgY2FuIGV4YWNlcmJhdGUgdGhlIGlvZW5kIGNoYWluDQo+
IGxlbmd0aHMsIHNvIGl0IHdvdWxkIGJlIGhhbmR5IHRvIGhhdmUgc29tZSBpZGVhIG9mIHdoYXQg
aXMgYWN0dWFsbHkNCj4gdHJpZ2dlcmluZyB0aGlzIGJlaGF2aW91ci4uLg0KPiANCj4gQ2hlZXJz
LA0KPiANCj4gRGF2ZS4NCg0KV2UgaGF2ZSBkaWZmZXJlbnQgcmVwcm9kdWNlcnMuIFRoZSBjb21t
b24gZmVhdHVyZSBhcHBlYXJzIHRvIGJlIHRoZQ0KbmVlZCBmb3IgYSBkZWNlbnRseSBmYXN0IGJv
eCB3aXRoIGZhaXJseSBsYXJnZSBtZW1vcnkgKDEyOEdCIGluIG9uZQ0KY2FzZSwgNDAwR0IgaW4g
dGhlIG90aGVyKS4gSXQgaGFzIGJlZW4gcmVwcm9kdWNlZCB3aXRoIEhEcywgU1NEcyBhbmQNCk5W
TUUgc3lzdGVtcy4NCg0KT24gdGhlIDEyOEdCIGJveCwgd2UgaGFkIGl0IHNldCB1cCB3aXRoIDEw
KyBkaXNrcyBpbiBhIEpCT0QNCmNvbmZpZ3VyYXRpb24gYW5kIHdlcmUgcnVubmluZyB0aGUgQUpB
IHN5c3RlbSB0ZXN0cy4NCg0KT24gdGhlIDQwMEdCIGJveCwgd2Ugd2VyZSBqdXN0IHNlcmlhbGx5
IGNyZWF0aW5nIGxhcmdlICg+IDZHQikgZmlsZXMNCnVzaW5nIGZpbyBhbmQgdGhhdCB3YXMgb2Nj
YXNpb25hbGx5IHRyaWdnZXJpbmcgdGhlIGlzc3VlLiBIb3dldmVyIGRvaW5nDQphbiBzdHJhY2Ug
b2YgdGhhdCB3b3JrbG9hZCB0byBkaXNrIHJlcHJvZHVjZWQgdGhlIHByb2JsZW0gZmFzdGVyIDot
KS4NCg0KU28gcmVhbGx5LCBpdCBzZWVtcyBhcyBpZiB0aGUgcHJvYmxlbSBpcyAnbG90cyBvZiBk
YXRhIGluIGNhY2hlJyBhbmQNCnRoZW4gZmx1c2ggaXQgb3V0Lg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
