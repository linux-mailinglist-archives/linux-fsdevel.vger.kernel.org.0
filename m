Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0624E7919
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 17:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbiCYQoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245627AbiCYQoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:44:07 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2098.outbound.protection.outlook.com [40.107.100.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C743E09AC;
        Fri, 25 Mar 2022 09:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcsJh4aamkBdcmTqNYYdG6XgSjbZHsY/BRHgEHph7x2tGP0TVTgArk8Mnva2SyLyfFtB1L9Er5F0MplK14xFTUBswx4VumOIAS+Q9rbseBqIZ509eAuLgmSZoY6mEf+YQufKaRcoScduUR2vYymvUBMU0hon1jsWsqpsLZMFqfJUeOUcBBCEQxBx7CcQhQqayhFNhf8C5P5V3kYQzGRUW0QXOhVqap6ZubPNTNfOcZ12L/NhQHv50PImUzExLpPR0RHWpCEAof4A93/fsXzbKYR5psMMr5atZzx7YdBkfMr7Ap10DXFB6P2moTUC3uD7BFoJiAvl0g8CzbyGae2Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/CWeFlOmafrcSWJPeZzTlKfAFXJjjW6wLBlHMXTebk=;
 b=HXzTIYmMhxOiQiA1fd/kH9DjHAhiylnw/MTTMfJFMTBXL2NSk2zSKwWrpAezlVuQJe59jxHvDO+S+fIlMek1ZvRRIJ2WlL4nXkxDfYoN5NNh4n+gp+yFlDbuOp3ux0RW7wHiDqhSQyDq75h0MV4Bndn9SPlXVcx9PhuoTn0c9YWPwc5ykMT6GduB2Zv+9nHC0ryRhT3pNN1AljjuM6UUv3gN1KzdbMUHKpEx4clpRg20R0599EfhmIPiETxL7faZ+8+ADNzWyAg4fxHHoJHiMV5mbopoPIV/3iLmZCYXGYCxjGDBKdl0QIvw6bjl0UoOx9LJ69SWicBrGQYn9jrxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/CWeFlOmafrcSWJPeZzTlKfAFXJjjW6wLBlHMXTebk=;
 b=HiBWbkAXj0fcUdkDzhgL9w+ZB7Rc/NR8biE3q+26VhCAWwqwmmUnX8SMNK8z5y0r6dgPI9dERCDDJI6ysAbqW5KCNtr1Oimr9begV+FGUZvfylhRHGjloSoltWgSN+LM6negLTOLeB46z2WSAXsbqQ6epgxWU6sCRRPKD0TpLL0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO6PR13MB5276.namprd13.prod.outlook.com (2603:10b6:303:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.11; Fri, 25 Mar
 2022 16:42:27 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%7]) with mapi id 15.20.5123.010; Fri, 25 Mar 2022
 16:42:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>
CC:     "raven@themaw.net" <raven@themaw.net>,
        "kzak@redhat.com" <kzak@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Thread-Topic: [RFC PATCH] getvalues(2) prototype
Thread-Index: AQHYPiLfN3SIvxZ+fUmiuec7ccugx6zNltCAgACnSACAAMHbAIABUmSA
Date:   Fri, 25 Mar 2022 16:42:27 +0000
Message-ID: <5d5c170949a5c4e2e4b8ef8949e5cdc5110eeabf.camel@hammerspace.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
         <20220323225843.GI1609613@dread.disaster.area>
         <CAJfpegv6PmZ_RXipBs9UEjv_WfEUtTDE1uNZq+9fBkCzWPvXkw@mail.gmail.com>
         <20220324203116.GJ1609613@dread.disaster.area>
In-Reply-To: <20220324203116.GJ1609613@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ea2dd3a-7c0b-4e33-07cd-08da0e7e726b
x-ms-traffictypediagnostic: CO6PR13MB5276:EE_
x-microsoft-antispam-prvs: <CO6PR13MB5276BF5CEA20E857D65523D9B81A9@CO6PR13MB5276.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wb2mNX/QCTXBXnVubdYP/P4caL+0BtKvsGLHZr4j7j3Da58AJrFGmzWwGFO9OIE6DXm0p1h0DNwCz8nJySqP1Ik8p07RBsfEsQtOmlji6RVcKp18V/+AOwUKJov3dQJMHkwWwlDZyQoDPRAPDgbgCsnP9sdOyb6ak1uw+QSd0U9SG0+3goHCvYCQ7yUH3gxu//b7DBro5pJX+FgM6IzwUxCbzeaKHCPpVnKujOT/vSE0MuCm8m1aQzjrBvIOO9jsDmCjseDW2sg2r94CEowol7T92J/lzEu70I5ushmkZhSFohLA1B9XGucjvcSZlATqkPhrhCUhI74pnn+Jp9LHSN9ryeQG57VMxF6jrgmvNWLzBtYyEX7Xprb2KanztrF5/zceRr8bwMecgvUL5dw9ECr//twBPDFOMEu8mYShwEsExthhZ5em1EfoUXrvERXMpy7MAI9BooH5UuzrbgAW97NJjGXB6NyyKgJNwFcolmUpdnisOENDqtxrgpTn7Cv4j03uMPxce8AXKBAzB4aefQtA+NH6vLHPdbkmuMF1re/V1F8/boASFT/D8pYNP96ZmND7cTpeXJ9o+0JjlXJtdT+tCxjAKnm/SAARbua/em3mr34sQohekfEkBXmhovu96ZBZwfyDH/ElF9DpZ0cqrDcu3UFcsUaecm4ePRPIX0dNGCcTWwTBuKWE6UhPb59wtU7s1uWSCzyogtTUlpOs11mPMRinflxjLVSvh6hRruEE4zRaneK+8oWM/73pwU6GeYiQHW1WTOY8aNBNJGNVOblA6TYG8isYV4NWye637ak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(64756008)(6506007)(83380400001)(54906003)(2906002)(2616005)(6512007)(110136005)(38100700002)(122000001)(38070700005)(66446008)(4326008)(316002)(86362001)(36756003)(8936002)(66476007)(66946007)(66556008)(76116006)(966005)(508600001)(71200400001)(6486002)(5660300002)(7416002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TER0aENsTE0wd3N6VHk4aExUR0ovdjRpMEhFa2RSMGtkaW5WOU41anM2ZWlH?=
 =?utf-8?B?Qm5IdDJYMFJOWTNDUElKY01QU3hESkR2R0xDa2hMQVRXNnpKSnpBcm1MUFdV?=
 =?utf-8?B?eHBJOG56QklMRXdPWHZxYjJKc2htVEU3UVZMQUVLa1c4RGtmMTQ0STlkMFNm?=
 =?utf-8?B?OHVxTnpROWdoNGJiUldqTHc3MzJqUmdpSFVacHRSRllZcG1sUWJLc2wwUEN3?=
 =?utf-8?B?MnJWY3RNSU5QQXJBT2NYOG9HOStnUjJNdi9Pd3JWWFZFQ25MMDlsSGtLdzhv?=
 =?utf-8?B?Ny9lazY5U0RjN3g0T2krOXJOM2VsMTZZcWFxeUdMWXNMd2NqN3lzdTFIVE5T?=
 =?utf-8?B?K1BvSnp4ZHhBWXhLUTRNQTloUmZFSkN4Q3dXYUE4WlJPamxXWUc0SGlVcXJv?=
 =?utf-8?B?Y2dSVjljazlJdlhPY3JsZVA4OHVMYUM0RE5WYnROaktISWJ0VG5xZEk5ZFlH?=
 =?utf-8?B?Zm9VdEJvcmFaUnE0ekZHVmZVcTRkWjdkblowY2Y2NG4zM1U4VCtQTHhXekZv?=
 =?utf-8?B?NjB3VWpkM1E4MGxwWkpPd3hHUE9UZXkrZkFMK3grS1RTYmxrVmltMmxmWTh6?=
 =?utf-8?B?UUdxbWg1MlJUTy9JMVRnZDc4YzlrRDlKSGxNTE9VblZZQXZpV2hPT2t6MFZ5?=
 =?utf-8?B?aEVqR0g4N0ZsNnpVNnZSV29IVm5IUTFXRXhrckRhWHNsSEEvSFl3bGo5Nytx?=
 =?utf-8?B?dFVHUUNFUm5xaWg5Rm1wNklpVlozS2ZWSkszYVF1aFFzMTd1b0F3dEVhMFZq?=
 =?utf-8?B?RC9HTXQ2WkMxMW1PWFU3Z2N5UnZheU1WS09QNnROa0duNzhWNE9CMGpkT2h3?=
 =?utf-8?B?WFJ0NGRPZXhBUDBvNVJzVXNiOVJHWUgyUjNuNG4rS1RRdU45emxtNjJpWmUx?=
 =?utf-8?B?QThLeks1TU5EV2JyVWQ4clJmUXRUL1hjdy83Nmo5NTcxbklOcWYxN0FCSmhQ?=
 =?utf-8?B?UXN5Qm93TWErMGg3RFl0ZXlWL042RldmL3FhaGlybUFNNUxMcHlCVG5WRnFs?=
 =?utf-8?B?aUdqY01ia2hFT2xod2xKQ2d2dURXZUtaOFlhUW5PMVdNNFBETExzdmRQZEVK?=
 =?utf-8?B?cVI1dFMzc0p3UmxjU0RrSmQvZXl5OStFS0JDUjdCZFVTWklleHlXdHhRUEZu?=
 =?utf-8?B?WXhKeFdWeUg1VlFpTHdSMU1idFR0UW5HMnl4SGJWVk8xaG5sNE5oUHRqd0Uy?=
 =?utf-8?B?dkVCMk4raHEveU9XTEc0Q0NGNjdLRFB6REljUnlvejVoR1lYUmQrRlk0VVV1?=
 =?utf-8?B?bFprWFpPSis2cUtNanBSd1ZXcC9XTWJDVUZ3VmZiYVgzMmhCNjVobXBtdGQ3?=
 =?utf-8?B?VWx2SmxlRkVCaG11Q1FtcVM4bW1HL0FsSHRoUndrTTJHSEd2UklrNU9wVUw0?=
 =?utf-8?B?em96TlBOelEzZUZaZkY0ZUcvVDZVankwMFdxeXNBYmFXODJ4QzlyZWdGaUxH?=
 =?utf-8?B?c0xmZm9TWWFZcGxoSDc3VEpLVFozZEkxVUZBMDhKbTFkMDQyZExZRHNVVHFM?=
 =?utf-8?B?cDhvaHdtZENVWVpQemlVdm5JSmZXcUM1bnhCOTdnZ2tnT01RZkxyUHZuelpn?=
 =?utf-8?B?MHZzRm0rSUxWbFViajVmRnZya05yK01PSDd2UWJlYW10MFFQby93Z1ZUVnJV?=
 =?utf-8?B?QXZSQ0dwM2hwaXJLemh5bnF3NytOVjZRVUVybVZhU3VCdkZqekZpNnhNQW0r?=
 =?utf-8?B?ZXQ0WHpCOG9LZWFxNk0yUWVmbXlTa3FVd3hBUG9CV2lORlQwelBjQmxDR011?=
 =?utf-8?B?bS9hMVlnUWN1aTNhVXFFR0xnbDUrMEVTUzhLcnZsaktURlpiYTVROFFheUh6?=
 =?utf-8?B?Y0FOMGx5M0pyV2JtY2lOdGdlaUxvWFhYY2YxclU2cXN3TXZSc2hCSWdsL2d4?=
 =?utf-8?B?aUxqRXVHczdLa1dIanFiZ0Z4VFVsNmlGQWNmdGc2dkR6OXY5M25nY0hHVWFa?=
 =?utf-8?B?MjVHZGs4VjhkK1oxdVRuVm1LMkdkZG9JbDlVT0JPNGFnN29lVkd0dHVZZ3c2?=
 =?utf-8?B?WTA0Y3JJUFFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE7FEF576ABAE746B9F88D9BD8F02418@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea2dd3a-7c0b-4e33-07cd-08da0e7e726b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 16:42:27.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLmbaXmloKm8wDYiPoarAPCEfXikJS+KJb7FMp6+y73WpXHXqvgfkMcfqe0HohCpWq4tYQi/sMunllxIBG0s4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTI1IGF0IDA3OjMxICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFRodSwgTWFyIDI0LCAyMDIyIGF0IDA5OjU3OjI2QU0gKzAxMDAsIE1pa2xvcyBTemVyZWRp
IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjMgTWFyIDIwMjIgYXQgMjM6NTgsIERhdmUgQ2hpbm5lciA8
ZGF2aWRAZnJvbW9yYml0LmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gVHVlLCBN
YXIgMjIsIDIwMjIgYXQgMDg6Mjc6MTJQTSArMDEwMCwgTWlrbG9zIFN6ZXJlZGkgd3JvdGU6DQo+
ID4gDQo+ID4gPiA+IC0gSW50ZXJmYWNlcyBmb3IgZ2V0dGluZyB2YXJpb3VzIGF0dHJpYnV0ZXMg
YW5kIHN0YXRpc3RpY3MgYXJlDQo+ID4gPiA+IGZyYWdtZW50ZWQuDQo+ID4gPiA+IMKgIEZvciBm
aWxlcyB3ZSBoYXZlIGJhc2ljIHN0YXQsIHN0YXR4LCBleHRlbmRlZCBhdHRyaWJ1dGVzLA0KPiA+
ID4gPiBmaWxlIGF0dHJpYnV0ZXMNCj4gPiA+ID4gwqAgKGZvciB3aGljaCB0aGVyZSBhcmUgdHdv
IG92ZXJsYXBwaW5nIGlvY3RsIGludGVyZmFjZXMpLsKgIEZvcg0KPiA+ID4gPiBtb3VudHMgYW5k
DQo+ID4gPiA+IMKgIHN1cGVyYmxvY2tzIHdlIGhhdmUgc3RhdCpmcyBhcyB3ZWxsIGFzDQo+ID4g
PiA+IC9wcm9jLyRQSUQve21vdW50aW5mbyxtb3VudHN0YXRzfS4NCj4gPiA+ID4gwqAgVGhlIGxh
dHRlciBhbHNvIGhhcyB0aGUgcHJvYmxlbSBvbiBub3QgYWxsb3dpbmcgcXVlcmllcyBvbiBhDQo+
ID4gPiA+IHNwZWNpZmljDQo+ID4gPiA+IMKgIG1vdW50Lg0KPiA+ID4gDQo+ID4gPiBodHRwczov
L3hrY2QuY29tLzkyNy8NCj4gPiANCj4gPiBIYWhhIQ0KPiA+IA0KPiA+ID4gSSd2ZSBzYWlkIGlu
IHRoZSBwYXN0IHdoZW4gZGlzY3Vzc2luZyB0aGluZ3MgbGlrZSBzdGF0eCgpIHRoYXQNCj4gPiA+
IG1heWJlDQo+ID4gPiBldmVyeXRoaW5nIHNob3VsZCBiZSBhZGRyZXNzYWJsZSB2aWEgdGhlIHhh
dHRyIG5hbWVzcGFjZSBhbmQNCj4gPiA+IHNldC9xdWVyaWVkIHZpYSB4YXR0ciBuYW1lcyByZWdh
cmRsZXNzIG9mIGhvdyB0aGUgZmlsZXN5c3RlbQ0KPiA+ID4gc3RvcmVzDQo+ID4gPiB0aGUgZGF0
YS4gVGhlIFZGUy9maWxlc3lzdGVtIHNpbXBseSB0cmFuc2xhdGVzIHRoZSBuYW1lIHRvIHRoZQ0K
PiA+ID4gc3RvcmFnZSBsb2NhdGlvbiBvZiB0aGUgaW5mb3JtYXRpb24uIEl0IG1pZ2h0IGJlIGhl
bGQgaW4geGF0dHJzLA0KPiA+ID4gYnV0DQo+ID4gPiBpdCBjb3VsZCBqdXN0IGJlIGEgZmxhZyBi
aXQgaW4gYW4gaW5vZGUgZmllbGQuDQo+ID4gDQo+ID4gUmlnaHQsIHRoYXQgd291bGQgZGVmaW5p
dGVseSBtYWtlIHNlbnNlIGZvciBpbm9kZSBhdHRyaWJ1dGVzLg0KPiA+IA0KPiA+IFdoYXQgYWJv
dXQgb3RoZXIgb2JqZWN0cycgYXR0cmlidXRlcywgc3RhdGlzdGljcz/CoMKgIFJlbWVtYmVyIHRo
aXMNCj4gPiBzdGFydGVkIG91dCBhcyBhIHdheSB0byByZXBsYWNlIC9wcm9jL3NlbGYvbW91bnRp
bmZvIHdpdGggc29tZXRoaW5nDQo+ID4gdGhhdCBjYW4gcXVlcnkgaW5kaXZpZHVhbCBtb3VudC4N
Cj4gDQo+IEZvciBpbmRpdmlkdWFsIG1vdW50IGluZm8sIHdoeSBkbyB3ZSBldmVuIG5lZWQgdG8g
cXVlcnkgc29tZXRoaW5nIGluDQo+IC9wcm9jPyBJIG1lYW4sIGV2ZXJ5IG9wZW4gZmlsZSBpbiB0
aGUgbW91bnQgaGFzIGFjY2VzcyB0byB0aGUgbW91bnQNCj4gYW5kIHRoZSB1bmRlcmx5aW5nIHN1
cGVyYmxvY2ssIHNvIHdoeSBub3QganVzdCBtYWtlIHRoZSBxdWVyeQ0KPiBuYW1lc3BhY2UgYWNj
ZXNzYWJsZSBmcm9tIGFueSBvcGVuIGZkIG9uIHRoYXQgbW91bnQ/DQo+IA0KPiBlLmcuIC9wcm9j
L3NlbGYvbW91bnRpbmZvIHRlbGxzIHlvdSB3aGVyZSB0aGUgbW91bnRzIGFyZSwgdGhlbiB5b3UN
Cj4gY2FuIGp1c3Qgb3BlbihPX1BBVEgpIHRoZSBtb3VudCBwb2ludCB5b3Ugd2FudCB0aGUgaW5m
byBmcm9tIGFuZA0KPiByZXRyaWV2ZSB0aGUgcmVsZXZhbnQgeGF0dHJzIGZyb20gdGhhdCBmZC4g
VGhlIGluZm9ybWF0aW9uIGl0c2VsZg0KPiBkb2VzIG5vdCBuZWVkIHRvIGJlIGluIC9wcm9jLCBu
b3Igb25seSBhY2Nlc3NpYmxlIGZyb20gL3Byb2MsIG5vciBiZQ0KPiBsaW1pdGVkIHRvIHByb2Mg
aW5mcmFzdHJ1Y3R1cmUsIG5vciBiZSBjb25zdHJhaW5lZCBieSBwcm9jJ3MNCj4gYXJiaXRyYXJ5
ICJvbmUgdmFsdWUgcGVyIGZpbGUiIHByZXNlbnRhdGlvbi4uLi4NCj4gDQo+IEluZGVlZCwgd2Ug
ZG9uJ3QgaGF2ZSB0byBjZW50cmFsaXNlIGFsbCB0aGUgaW5mb3JtYXRpb24gaW4gb25lIHBsYWNl
DQo+IC0gYWxsIHdlIG5lZWQgaXMgdG8gaGF2ZSBhIHdlbGwgZGVmaW5lZCwgY29uc2lzdGVudCBt
ZXRob2QgZm9yDQo+IGluZGV4aW5nIHRoYXQgaW5mb3JtYXRpb24gYW5kIGFsbCB0aGUgc2hlbmFu
aWdhbnMgZm9yIGFjY2Vzc2luZw0KPiBjb21tb24gc3R1ZmYgY2FuIGJlIHdyYXBwZWQgdXAgaW4g
YSBjb21tb24gdXNlcnNwYWNlIGxpYnJhcnkNCj4gKHNpbWlsYXIgdG8gaG93IGl0ZXJhdGluZyB0
aGUgbW91bnQgdGFibGUgaXMgZ2VuZXJpYyBDIGxpYnJhcnkNCj4gZnVuY3Rpb25hbGl0eSkuDQo+
IA0KPiA+ID4gPiBtbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGxp
c3Qgb2YgbW91bnQgcGFyYW1ldGVycw0KPiA+ID4gPiBtbnQ6bW91bnRwb2ludMKgwqDCoMKgwqDC
oMKgwqAgLSB0aGUgbW91bnRwb2ludCBvZiB0aGUgbW91bnQgb2YgJE9SSUdJTg0KPiA+ID4gPiBt
bnRuc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBsaXN0IG9mIG1vdW50IElE
J3MgcmVhY2hhYmxlIGZyb20gdGhlDQo+ID4gPiA+IGN1cnJlbnQgcm9vdA0KPiA+ID4gPiBtbnRu
czoyMTpwYXJlbnRpZMKgwqDCoMKgwqAgLSBwYXJlbnQgSUQgb2YgdGhlIG1vdW50IHdpdGggSUQg
b2YgMjENCj4gPiA+ID4geGF0dHI6c2VjdXJpdHkuc2VsaW51eCAtIHRoZSBzZWN1cml0eS5zZWxp
bnV4IGV4dGVuZGVkDQo+ID4gPiA+IGF0dHJpYnV0ZQ0KPiA+ID4gPiBkYXRhOmZvby9iYXLCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtIHRoZSBkYXRhIGNvbnRhaW5lZCBpbiBmaWxlDQo+ID4gPiA+ICRP
UklHSU4vZm9vL2Jhcg0KPiA+ID4gDQo+ID4gPiBIb3cgYXJlIHRoZXNlIGRpZmZlcmVudCBmcm9t
IGp1c3QgZGVjbGFyaW5nIG5ldyB4YXR0ciBuYW1lc3BhY2VzDQo+ID4gPiBmb3INCj4gPiA+IHRo
ZXNlIHRoaW5ncy4gZS5nLiBvcGVuIGFueSBmaWxlIGFuZCBsaXN0IHRoZSB4YXR0cnMgaW4gdGhl
DQo+ID4gPiB4YXR0cjptb3VudC5tbnQgbmFtZXNwYWNlIHRvIGdldCB0aGUgbGlzdCBvZiBtb3Vu
dCBwYXJhbWV0ZXJzIGZvcg0KPiA+ID4gdGhhdCBtb3VudC4NCj4gPiANCj4gPiBPa2F5Lg0KPiA+
IA0KPiA+ID4gV2h5IGRvIHdlIG5lZWQgYSBuZXcgInhhdHRyIGluIGV2ZXJ5dGhpbmcgYnV0IG5h
bWUiIGludGVyZmFjZQ0KPiA+ID4gd2hlbg0KPiA+ID4gd2UgY291bGQganVzdCBleHRlbmQgdGhl
IG9uZSB3ZSd2ZSBhbHJlYWR5IGdvdCBhbmQgZm9ybWFsaXNlIGENCj4gPiA+IG5ldywNCj4gPiA+
IGNsZWFuZXIgdmVyc2lvbiBvZiB4YXR0ciBiYXRjaCBBUElzIHRoYXQgaGF2ZSBiZWVuIGFyb3Vu
ZCBmb3IgMjAtDQo+ID4gPiBvZGQNCj4gPiA+IHllYXJzIGFscmVhZHk/DQo+ID4gDQo+ID4gU2Vl
bXMgdG8gbWFrZSBzZW5zZS4gQnV0Li4ud2lsbCBsaXN0eGF0dHIgbGlzdCBldmVyeXRpbmcNCj4g
PiByZWN1cnNpdmVseT8NCj4gPiBJIGd1ZXNzIHRoYXQgd29uJ3Qgd29yaywgYmV0dGVyIGp1c3Qg
bGlzdCB0cmFkaXRpb25hbCB4YXR0cnMsDQo+ID4gb3RoZXJ3aXNlIHdlJ2xsIGxpa2VseSBnZXQg
cmVncmVzc2lvbnMsDQo+IA0KPiAqbm9kKg0KPiANCj4gPiBhbmQgYW55d2F5IHRoZSBwb2ludCBv
ZiBhDQo+ID4gaGllcmFyY2hpY2FsIG5hbWVzcGFjZSBpcyB0byBiZSBhYmxlIHRvIGxpc3Qgbm9k
ZXMgb24gZWFjaCBsZXZlbC7CoA0KPiA+IFdlDQo+ID4gY2FuIHVzZSBnZXR4YXR0cigpIGZvciB0
aGlzIHB1cnBvc2UsIGp1c3QgbGlrZSBnZXR2YWx1ZXMoKSBkb2VzIGluDQo+ID4gdGhlDQo+ID4g
YWJvdmUgZXhhbXBsZS4NCj4gDQo+IFl1cCwgYW5kIGxpa2UgQ2FzZXkgc3VnZ2VzdHMsIHlvdSBj
b3VsZCBpbXBsZW1lbnQgYSBnZW5lcmljDQo+IGdldHZhbHVlcygpLWxpa2UgdXNlciBsaWJyYXJ5
IG9uIHRvcCBvZiBpdCBzbyB1c2VycyBkb24ndCBldmVuIG5lZWQNCj4gdG8ga25vdyB3aGVyZSBh
bmQgaG93IHRoZSB2YWx1ZXMgYXJlIGxvY2F0ZWQgb3IgcmV0cmlldmVkLg0KPiANCj4gVGhlIG90
aGVyIGFkdmFudGFnZSBvZiBhbiB4YXR0ciBpbnRlcmZhY2UgaXMgdGhhdCBpcyBhbHNvIHByb3Zp
ZGVzIGENCj4gc3ltbWV0cmljYWwgQVBJIGZvciAtY2hhbmdpbmctIHZhbHVlcy4gTm8gbmVlZCBm
b3Igc29tZSBzcGVjaWFsDQo+IGNvbmZpZ2ZzIG9yIGNvbmZpZ2ZkIHRoaW5neSBmb3Igc2V0dGlu
ZyBwYXJhbWV0ZXJzIC0ganVzdCBjaGFuZ2UgdGhlDQo+IHZhbHVlIG9mIHRoZSBwYXJhbWV0ZXIg
b3IgbW91bnQgb3B0aW9uIHdpdGggYSBzaW1wbGUgc2V0eGF0dHIgY2FsbC4NCj4gVGhhdCByZXRh
aW5zIHRoZSBzaW1wbGljaXR5IG9mIHByb2MgYW5kIHN5c2ZzIGF0dHJpYnV0ZXMgaW4gdGhhdCB5
b3UNCj4gY2FuIGNoYW5nZSB0aGVtIGp1c3QgYnkgd3JpdGluZyBhIG5ldyB2YWx1ZSB0byB0aGUg
ZmlsZS4uLi4NCg0KVGhlIGRvd25zaWRlcyBhcmUsIGhvd2V2ZXIsIHRoYXQgdGhlIGN1cnJlbnQg
aW50ZXJmYWNlIHByb3ZpZGVzIGxpdHRsZQ0KaW4gdGhlIHdheSBvZiBhdG9taWNpdHkgaWYgeW91
IHdhbnQgdG8gcmVhZCBvciB3cml0ZSB0byBtdWx0aXBsZQ0KYXR0cmlidXRlcyBhdCB0aGUgc2Ft
ZSB0aW1lLiBTb21ldGhpbmcgbGlrZSBhIGJhY2t1cCBwcm9ncmFtIG1pZ2h0IHdhbnQNCnRvIGJl
IGFibGUgdG8gYXRvbWljYWxseSByZXRyaWV2ZSB0aGUgY3RpbWUgd2hlbiBpdCBpcyBiYWNraW5n
IHVwIHRoZQ0KYXR0cmlidXRlcy4NCkFsc28sIHdoZW4gc2V0dGluZyBhdHRyaWJ1dGVzLCBJJ2Qg
bGlrZSB0byBhdm9pZCBtdWx0aXBsZSBzeXNjYWxscyB3aGVuDQpJJ20gY2hhbmdpbmcgbXVsdGlw
bGUgcmVsYXRlZCBhdHRyaWJ1dGVzLg0KDQpJT1c6IEFkZGluZyBhIGJhdGNoaW5nIGludGVyZmFj
ZSB0aGF0IGlzIGFraW4gdG8gd2hhdCBNaWtsb3Mgd2FzDQpwcm9wb3Npbmcgd291bGQgYmUgYSBo
ZWxwZnVsIGNoYW5nZSBpZiB3ZSB3YW50IHRvIGdvIGRvd24gdGhpcyBwYXRoLg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
