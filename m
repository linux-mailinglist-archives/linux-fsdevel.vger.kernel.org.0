Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A636DE71E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 00:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDKWSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 18:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKWST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:18:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFCF3C39;
        Tue, 11 Apr 2023 15:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh+JtbPiZv3RNgOVAe7NpL+7sQ+dwUb/eejIYyDzU0llxybjwdeoVHv2IOgVzjoPQOY0/8nSRVMJ1arnd0tUk2v03lbKwAl5gNzkt92h+bF6yo5hYB0oRo95+FZ11BElYTIk0JI9FU5OzdL9bLEiIYInrpKvm0lWBPSopEC4maVJrAXcHjx/YO/FszAfQ/sNqODtwPMYnpnvpXKyxUIr9Bu148utfNM2tsmMWUQfHmbIfAF/8YO0o8E9Sll64GL3AHgznvipG6lvayLn9nsBagE+3fw5wPwNw2sA1LFr2a6TTUVGarQ42ApbXweXIjurBY4M27UBRyHr26AZb8k/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wtpQ3zHxFqam3YYBGCfldF9AOpEpa6qCyxF60xE0qw=;
 b=dBFnBCXOzrLZP+PWXRJ8X9ebXcrwkmkDVuPgJix3wRBqtHtVOW0YNGcb1j6dZf/aSCypwYnipEFR8MVlMF16pXkS5vNEl4gEPgeBjBDq2EQcTqljdAVv2fDzlIq23noVlCC0xpx23SV+lRYzSweqoaXqmaLw3zKryPJl+UKXt14XXSw2pVFdzHD4Wp00UuoLeyOGucihTvRCyjJvr5eb+rR+mw7Nu74fedoOZjmSoT9Qj/qnVIoZqjGa1EURW4+ESeBEkosjgN65tC5gvkZZu+NjvkugzHwYcssI2rqZ4z7XGYB3GtzcLtkx7fn9Aebb4mZiNdfEgAztKYCI1eIkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wtpQ3zHxFqam3YYBGCfldF9AOpEpa6qCyxF60xE0qw=;
 b=xde2URxzZHGuwYetXnD3zE9Y2c4y7Qk64jzqcQ4i4d60OcfR6xw7SWi07mpH9ETCO3jjd8wnrfSexL+VLGo8cG7C7/fErT5N9fnnaTKtDtn+tsaw6wlrMaH/Im+ZDnMSYwSg64P+SYqNNAKOJ+5S/rHWEX6xbBVDJy6SnTg2gIE=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by SJ2PR19MB7532.namprd19.prod.outlook.com (2603:10b6:a03:4c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 22:18:12 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8cb3:ef5b:f815:7d8c]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8cb3:ef5b:f815:7d8c%6]) with mapi id 15.20.6277.031; Tue, 11 Apr 2023
 22:18:11 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
CC:     "mszeredi@redhat.com" <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?utf-8?B?U3TDqXBoYW5lIEdyYWJlcg==?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "criu@openvz.org" <criu@openvz.org>
Subject: Re: [RFC PATCH 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
Thread-Topic: [RFC PATCH 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
Thread-Index: AQHZbMOAVAK0wzrEgESfebBSytLjNA==
Date:   Tue, 11 Apr 2023 22:18:11 +0000
Message-ID: <4632a71e-8f15-66ad-3193-4605a1204f8d@ddn.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com>
 <381a19bb-d17e-b48b-8259-6287dbe170df@fastmail.fm>
 <CAEivzxf8HKs2FJwTohzGVcb0TRNy9QJbEALC3dni3zx+tOb9Gg@mail.gmail.com>
 <CAEivzxdjjJmwPaxe5miWPxun_ZCRt-wjuCCA2nzOWWyzZZUuOg@mail.gmail.com>
In-Reply-To: <CAEivzxdjjJmwPaxe5miWPxun_ZCRt-wjuCCA2nzOWWyzZZUuOg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|SJ2PR19MB7532:EE_
x-ms-office365-filtering-correlation-id: b721f538-de9f-43ba-ef71-08db3adaa328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MsUsCrgdbDubyF65yEmGk6acDP/uE3w49j30mtdkopknFmqO4dMNI2uyPCK2YJsp8n2SnBUagZ7zDECxbqmppoMvtf0HAcOjJ1eMMVWhPMmXHvyEi1wmhaanARFWS31+7bHEDbCjAVQ+bDY60jdX44dhBLMjJuxo8NbA1+26/U8sRniyNRh3pBAHh2/7gu+HpJGcdYrHgk2IZF42Xl5fuXFFvZllsz9oeoD+r/lqp7fSJ6jVIyTnb657hb+84LTRKnyTCRdBcWnjfGbUTEp+Chkb+fwz3C1HYzkLazEC0Px+WuaIjbKJCRXjisbPKAP7h4kwIzUbWBgSJg4O1jXcYrNmaHypDIFi6wJQVFQ6EHEjWqcKPxwjOINOdFh1Ro8woOVrIHqc0pbjf6wPF6y5tS1WUCRrVb79+kki4QHXUVUuXiBD59Ds5ZK4X3Oow/iTlyz5GhTDRTsumg6l4z0sONXUN3uaudzqzqaDlCQ1yHO1NrurepRC8iSLA8m/5cgw6Rd/0Hik1QM3lzY5uNmhq9DRkGxktF8DGJ127yS8nzQ1pba8y0DrmamOekD2QrX57ZvNVpD/P4MDo5XS4DFHd9zEMmeFCUAO85wPyoqbPPVzT+QOhuIdDaYQFry5nW/ZCqG9D6VjjFqHwAteHn0vkKyMI3umQcxfXdUGfHI3ONccTs+mRcYx1NiN3QPav8YI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39850400004)(136003)(346002)(396003)(451199021)(36756003)(38070700005)(86362001)(2906002)(31696002)(31686004)(71200400001)(6486002)(186003)(53546011)(83380400001)(2616005)(6512007)(6506007)(76116006)(66446008)(66946007)(66556008)(6916009)(91956017)(64756008)(66476007)(4326008)(122000001)(8676002)(478600001)(316002)(8936002)(7416002)(41300700001)(5660300002)(54906003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEFGcld2d3dTRGN0ZXEvOGtqYmova1psSnd5aXVtb29ZL0JIVk1MOERjUy9k?=
 =?utf-8?B?dHdFaEZ0MmxIR0pOZDg2Q0JHbU8rM3ZIaW01aGo5QzdHenVrZXlsRnpEZUI3?=
 =?utf-8?B?Yi9VT05iV1NOOEtDWFhFT3c0NVNlV1MreTZmWHc3RUp3R250RjJvdTRsNWRQ?=
 =?utf-8?B?MkNreEEwbFZRdGVuNXZQakRrRUo0d24yajhWTzNqai9MelBYYnl4TTRhSjBm?=
 =?utf-8?B?MUwwM1dHU3JOK3pHYVVINjFUY213S0VZYmhSeUtRekxpQWtvUUtsVTNvbkJz?=
 =?utf-8?B?aTZCZnBIcytEOWZaU05pRWFnYmt6S0N4RjF0MzI1S0NnSGFwVnBzeVBnc1g0?=
 =?utf-8?B?QlRVcnlUV2FXc20rTmhsMU9XelpJd1NoMHFYaVRFQ2ttYm0wM2FPQlRPRkJu?=
 =?utf-8?B?RzIwNnBOSzdBMVJ6enRFRmVEWXZEb3JxU1hReG42akdmeGtHbWdXOCtXRC84?=
 =?utf-8?B?WHZaei9uWFNvUlAzRStpRHhEb2p4RnJNM2JxUjh4WXJCQUxacTBlUHp1NVZq?=
 =?utf-8?B?djVBUUQ3T2F2WXltTUlMV3FIMTlMdHdmN1FwT1RBOWlqQmVOL0tEVEZ6ZWQ3?=
 =?utf-8?B?MnNuZ1FQSnVRR3dscnVOVzFXSWJiTUhHSmpTNERWTlR1NzFVNDJubXZrejY4?=
 =?utf-8?B?Vnd5VC9Rcmg2MWhMTkhWa2ZEOXlseGpjdkVOMU5MVWZCeWpSYlhXKzFpMWFl?=
 =?utf-8?B?cGloV1FoaEpGR3dZNU52VnVEbUFCZEIvQ25yMGxEKzFIM0wrWjhVSVp3Nzg2?=
 =?utf-8?B?WEpyWWtQQXN5QXlFMG4vWGdsMmhYZGtNZEdMUzRRY2xyUCszeWtLNW11UzRj?=
 =?utf-8?B?T2JRd09KWi9GQStiQTFOdFpVQU5QYjdWVTZkZ3l4M1FlOWVuMm9HOXpYWXFo?=
 =?utf-8?B?bzFvNUdJRGFPdFpLOGkvRlZzd0dhSzVJMk5zeFVxV1d6aXE1TWo4NGJhSEJL?=
 =?utf-8?B?aHJZQU1BQ0pCalNwUTNBWUNzZVFEMCtBZUVEWjZmWU1WS1R1a0EzODhvUDdJ?=
 =?utf-8?B?Wmh3bWw4R3k0OFQyU3hVNHhrTnd5K3RXRXpIcHNSWnMzVUwxRUpTdWxtbzhW?=
 =?utf-8?B?RWJzbnBHVTBCTGNaaHhzRXhIT3llMHE2eHNoQjA2c3ZZRVgzVG1UUkthanZq?=
 =?utf-8?B?dkVrMS9SaDRBcFNINWp6N0VNaG9CWUd0QXhwVGw1NGRsNXRBWVpxMk5yTUU0?=
 =?utf-8?B?c0dibUdMZzZsUkhXVlRjRlVFYTNUTEZtSytFUzA2a0J4R1VPNjUreVM5QUR2?=
 =?utf-8?B?cXZyRVhHZU0wVUVWakZyRjVubTZJSVhySmk3dDVadHRVTkFzVFJwZXF0YjdL?=
 =?utf-8?B?Rnl2RFo0S3puQTlacDY1UHpsd3NBclRsN253aWlvYno1MVByT1pob1NQblVP?=
 =?utf-8?B?UG8zTTRteFRPRllVNU9zclVCNEFSVDFCbHd4djhOVDIvaXNDZFJpMko5QlBQ?=
 =?utf-8?B?em94dW1Ja0Zld3R6UFZkV1FoV21GS1lhaUczRnZHc3lmd2YyWnlraFh2RENW?=
 =?utf-8?B?ZDNJb0FZN3R6SVk3bldNL3FPWmdyT29vSXBpa2x0aktyTThaYXJuemNOMW8x?=
 =?utf-8?B?bisvMndhd3hVUFVHMklKbHQwRitWVm9WV2NrMEVXL3dKcmhLZlVIVm1peUZT?=
 =?utf-8?B?TTRtSzFYN0dlenJ6T0xSc05Zc3kvMzdCd1lQaXFtQkFwRW9JZ0dSbHVjQzF3?=
 =?utf-8?B?NForQmkzczdLcUpBczN5bVFuUmlDdzEraXBSeGM1bkJxNXlFQ2g1c2tmSXpo?=
 =?utf-8?B?Q3IvOXpWR1FrUkhVUWYybnhHMmFWTHF5SWRqbXd0ZVM3RVlGTDNBakhVQ2tx?=
 =?utf-8?B?bHkwbDd6SVVSMnBmSXVOdkdsMmJoMHBOUnpkNjVrRktHdjRhMDErQ25sNEpn?=
 =?utf-8?B?VS9ySjFqNnUyVXc3WFhmYkUrOU5VKzhDQml2cll2VkQ5TEJKaGFTcEdKS3VF?=
 =?utf-8?B?ZHhnbWY3aHExY3hwdWdJR093WExNWXJReTF0Q3owRVUwZExrQVVnNmJ5N0Vj?=
 =?utf-8?B?cjVvMWg1WXBrWmZjR0Z5Z0wyczJZeWxQR3Z4RFFqaW4zNmZjWEVXYVNrQ1hR?=
 =?utf-8?B?cVVveEtXMWpKTjhDNlpJc3RDZHIzVWR0bE9FZWYrUFhTSzhGQnhnNDVYeGIr?=
 =?utf-8?B?bGNVZ2ZFWmdGS3p3bjlCQ2M4OWhSWXpQcCszSlVCa2FTeXJsYW00dSs2N3pC?=
 =?utf-8?Q?aFVuG9+WxrVTsire7j4/WoU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B7F35EFB08C4940BBDB9B3876AD1D1C@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b721f538-de9f-43ba-ef71-08db3adaa328
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 22:18:11.7238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsCh38Kya7v8mxao61/LTlR3p5ILbfDrWJDkdGc5nH3vq711NPcO6DivLAcDv6Gert/V91wF/43MxB+laTLWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7532
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCk9uIDQvMy8yMyAxNjo1MSwgQWxla3NhbmRyIE1pa2hhbGl0c3luIHdyb3RlOg0KPiBPbiBN
b24sIE1hciA2LCAyMDIzIGF0IDM6MDnigK9QTSBBbGVrc2FuZHIgTWlraGFsaXRzeW4NCj4gPGFs
ZWtzYW5kci5taWtoYWxpdHN5bkBjYW5vbmljYWwuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBGcmks
IE1hciAzLCAyMDIzIGF0IDg6MjbigK9QTSBCZXJuZCBTY2h1YmVydA0KPj4gPGJlcm5kLnNjaHVi
ZXJ0QGZhc3RtYWlsLmZtPiB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4NCj4+PiBPbiAyLzIwLzIzIDIw
OjM3LCBBbGV4YW5kZXIgTWlraGFsaXRzeW4gd3JvdGU6DQo+Pj4+IFRoaXMgaW9jdGwgYWJvcnRz
IGZ1c2UgY29ubmVjdGlvbiBhbmQgdGhlbiByZWluaXRpYWxpemVzIGl0LA0KPj4+PiBzZW5kcyBG
VVNFX0lOSVQgcmVxdWVzdCB0byBhbGxvdyBhIG5ldyB1c2Vyc3BhY2UgZGFlbW9uDQo+Pj4+IHRv
IHBpY2sgdXAgdGhlIGZ1c2UgY29ubmVjdGlvbi4NCj4+Pj4NCj4+Pj4gQ2M6IE1pa2xvcyBTemVy
ZWRpIDxtc3plcmVkaUByZWRoYXQuY29tPg0KPj4+PiBDYzogQWwgVmlybyA8dmlyb0B6ZW5pdi5s
aW51eC5vcmcudWs+DQo+Pj4+IENjOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29t
Pg0KPj4+PiBDYzogU3TDg8KpcGhhbmUgR3JhYmVyIDxzdGdyYWJlckB1YnVudHUuY29tPg0KPj4+
PiBDYzogU2V0aCBGb3JzaGVlIDxzZm9yc2hlZUBrZXJuZWwub3JnPg0KPj4+PiBDYzogQ2hyaXN0
aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4NCj4+Pj4gQ2M6IEFuZHJlaSBWYWdpbiA8
YXZhZ2luQGdtYWlsLmNvbT4NCj4+Pj4gQ2M6IFBhdmVsIFRpa2hvbWlyb3YgPHB0aWtob21pcm92
QHZpcnR1b3p6by5jb20+DQo+Pj4+IENjOiBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZw0K
Pj4+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4+PiBDYzogY3JpdUBvcGVu
dnoub3JnDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBNaWtoYWxpdHN5biA8YWxla3Nh
bmRyLm1pa2hhbGl0c3luQGNhbm9uaWNhbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBmcy9mdXNl
L2Rldi5jICAgICAgICAgICAgIHwgMTMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+Pj4+ICAgIGluY2x1ZGUvdWFwaS9saW51eC9mdXNlLmggfCAgIDEgKw0KPj4+PiAg
ICAyIGZpbGVzIGNoYW5nZWQsIDEzMyBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1n
aXQgYS9mcy9mdXNlL2Rldi5jIGIvZnMvZnVzZS9kZXYuYw0KPj4+PiBpbmRleCA3Mzc3NjRjMjI5
NWUuLjBmNTNmZmQ2Mzk1NyAxMDA2NDQNCj4+Pj4gLS0tIGEvZnMvZnVzZS9kZXYuYw0KPj4+PiAr
KysgYi9mcy9mdXNlL2Rldi5jDQo+Pj4+IEBAIC0yMTg3LDYgKzIxODcsMTEyIEBAIHZvaWQgZnVz
ZV9hYm9ydF9jb25uKHN0cnVjdCBmdXNlX2Nvbm4gKmZjKQ0KPj4+PiAgICB9DQo+Pj4+ICAgIEVY
UE9SVF9TWU1CT0xfR1BMKGZ1c2VfYWJvcnRfY29ubik7DQo+Pj4+DQo+Pj4+ICtzdGF0aWMgaW50
IGZ1c2VfcmVpbml0X2Nvbm4oc3RydWN0IGZ1c2VfY29ubiAqZmMpDQo+Pj4+ICt7DQo+Pj4+ICsg
ICAgIHN0cnVjdCBmdXNlX2lxdWV1ZSAqZmlxID0gJmZjLT5pcTsNCj4+Pj4gKyAgICAgc3RydWN0
IGZ1c2VfZGV2ICpmdWQ7DQo+Pj4+ICsgICAgIHVuc2lnbmVkIGludCBpOw0KPj4+PiArDQo+Pj4+
ICsgICAgIGlmIChmYy0+Y29ubl9nZW4gKyAxIDwgZmMtPmNvbm5fZ2VuKQ0KPj4+PiArICAgICAg
ICAgICAgIHJldHVybiAtRU9WRVJGTE9XOw0KPj4+PiArDQo+Pj4+ICsgICAgIGZ1c2VfYWJvcnRf
Y29ubihmYyk7DQo+Pj4+ICsgICAgIGZ1c2Vfd2FpdF9hYm9ydGVkKGZjKTsNCj4+Pg0KPj4+IFNo
b3VsZG4ndCB0aGlzIGFsc28gdHJ5IHRvIGZsdXNoIGFsbCBkYXRhIGZpcnN0Pw0KPiANCj4gRGVh
ciBCZXJuZCwNCj4gDQo+IEkndmUgcmV2aWV3ZWQgdGhpcyBwbGFjZSAybmQgdGltZSBhbmQgSSdt
IG5vdCBzdXJlIHRoYXQgd2UgaGF2ZSB0bw0KPiBwZXJmb3JtIGFueSBmbHVzaGluZyB0aGVyZSwg
YmVjYXVzZSB1c2Vyc3BhY2UgZGFlbW9uIGNhbiBiZSBkZWFkIG9yDQo+IHN0dWNrLg0KPiBUZWNo
bmljYWxseSwgaWYgdXNlcnNwYWNlIGtub3dzIHRoYXQgZGFlbW9uIGlzIGFsaXZlIHRoZW4gaXQg
Y2FuIGNhbGwNCj4gZnN5bmMvc3luYyBiZWZvcmUgZG9pbmcgcmVpbml0Lg0KPiANCj4gV2hhdCBk
byB5b3UgdGhpbmsgYWJvdXQgaXQ/DQoNCkhlbGxvIEFsZXgsDQoNCnNvcnJ5IGZvciBteSBsYXRl
IHJlcGx5Lg0KDQpIbW0sIEkganVzdCBmZWFyIHRoYXQgZnN5bmMvc3luYyBpcyBhIGJpdCByYWN5
LCB3aGF0IGlzIGlmIGEgdXNlciB3b3VsZCANCndyaXRlIGRhdGEgYWZ0ZXIgdGhlIHN5bmMgYW5k
IHRoYXQgd291bGQgZ2V0IHNpbGVudGx5IHJlbW92ZWQgYnkgDQpmdXNlX2Fib3J0X2Nvbm4oKT8g
SXNuJ3Qgd2hhdCB3ZSB3YW50Og0KDQppb2N0bA0KICAgIHJlZnVzZSBuZXcgcmVxdWVzdHMgLT4g
dW5zZXQgZmMtPmluaXRpYWxpemVkDQogICAgZmx1c2ggYWxsIGZjIHF1ZXVlcyAoZmMtPmlxLnBl
bmRpbmcsIGZjLT5iZ19xdWV1ZSwgSSBndWVzcyB3aXRoIHlvdXIgDQpjdXJyZW50IHBhdGNoZXMg
d2UgZG8gbm90IG5lZWQgdG8gaGFuZGxlIGZvcmdldCkNCiAgICBmdXNlX2Fib3J0X2Nvbm4NCg0K
DQpTbyB3aGF0IGlzIG1pc3NpbmcgaXMgdGhlIGluZm9ybWF0aW9uIGlmIHRoZSBkYWVtb24gaXMg
c3RpbGwgcnVubmluZyAtIA0KdGFrZSBhIGRhZW1vbiByZWZlcmVuY2UgYW5kIHRoZW4gY2hlY2sg
Zm9yIFBGX0VYSVRJTkcsIGFzIGluIG15IHVyaW5nIA0KcGF0Y2hlcz8gTWlrbG9zIGhhcyBzb21l
IG9iamVjdGlvbnMgZm9yIHRoYXQsIHRob3VnaC4NCg0KDQpUaGUgYWx0ZXJuYXRpdmUgd291bGQg
YmUgdG8gbW91bnQgcmVhZC1vbmx5LCB0aGVuIHN5bmMsIHRoZW4gZG8gdGhlIA0KaW9jdGwgYW5k
IHJlbW91bnQgYmFjay4gSSBkb24ndCBrbm93IHdoYXQgbmVlZHMgdG8gYmUgZG9uZSB0byBnZXQg
DQpyZW1vdW50IHdvcmtpbmcsIHRob3VnaC4gSnVzdCBoYW5kbGUgaXQgaW4gbGliZnVzZSBtb3Vu
dC5mdXNlIGFuZCBzZW5kIA0KdGhlIG1vdW50IHN5c2NhbGw/DQoNCg0KQXMgSSB3cm90ZSBiZWZv
cmUsIGF0IERETiB3ZSB3YW50IHRvIGhhdmUgcnVuIHRpbWUgZGFlbW9uIHJlc3RhcnQgLSBJJ20g
DQphbHNvIG5vdCBvcHBvc2VkIHRvIGVudGlyZWx5IGdpdmUgdXAgb24gdGhlIGZsdXNoIGFuZCB0
byBqdXN0IHdvcmsgb24gYSANCnJlc3RhcnQgcHJvdG9jb2wgdG8gbWFrZSB0aGUgbmV3IGRhZW1v
biB0byB0aGUgb2xkIHN0YXRlIChvcGVuZWQgZmlsZXMgDQphbmQgbG9va3VwL2ZvcmdldCBjb3Vu
dCkuIEluIHByaW5jaXBsZSB3ZSBjb3VsZCBldmVuIHRyYW5zZmVyIHRoYXQgaW4gDQp1c2Vyc3Bh
Y2UgZnJvbSBvbmUgZGFlbW9uIHRvIHRoZSBvdGhlcj8NCg0KDQpUaGFua3MsDQpCZXJuZA0KDQpQ
UzogV2lsbCBsb29rIGF0IHRoZSBuZXcgcGF0Y2hlcyBsYXRlciB0aGlzIHdlZWsuDQoNCg0KVGhh
bmtzLA0KQmVybmQNCg0KDQo=
