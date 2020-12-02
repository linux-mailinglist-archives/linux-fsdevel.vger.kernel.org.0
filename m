Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5462CB336
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 04:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgLBDTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 22:19:17 -0500
Received: from mail-bn8nam12on2106.outbound.protection.outlook.com ([40.107.237.106]:14144
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbgLBDTR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 22:19:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDcmuRvX2KF3jxvTViVGPjMizqKyfklq32Dysi5tGaaQJBmp7jZPH+aWJz3VxCjYBdc+a50/63Frfd165EJn1gtyLNqtu4WOZmkKcTUUVjlYAQFoAE4BGCLoM6GXeBT724BaHxwuuMd/IaBs8aAzn/B0DMyteLxTlIgDqymA6RFgLGzeyVagdFFx2gPBw3947dHTzCFsLHzkyagrpae8RxNPhxbS2LBmEPHsKKdO0HCu4pcIP3lAyrXZGFyQwwtk47kRrZ52FPftlLMOK/8khqI3KQlnko2v3qTXysYXEXISe4/B06PeS11u3pU7U0K7QVybZJB62ptS/3FsNK2EyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yVi1d3U93ZIJoxiIwXJCDwMdF1iaWMXLnHPJvUljpU=;
 b=HF+rXQKOtqNtRaErorRuVPseYEtSpYVNsZEGPs9IyOKmHBZG/nkTBiuzxLlNsDjuFxdT3tcCacc8wGmYglCgJMXpKsO0EqOmQd9nojB5QV8RZEC4Xkm5wMfqUcc6x2QPAyGqigEMcfBQcN3rrkLbJpIfUBb9c39odW0Fc4NUQBELg1xyb0ZaVvVtUJqIl9uruSfD7gbSZvb7JrUxmBBmplHvrBE6vmEu/IM8SmHXsxuWNTSiZJId0yNS85BA31U6KLAQosg0F+OmjpM9ntnowm4zLmnJ0YXNOPn56c5v5naOaDYbxLWRPx8GxrSq/tFs7foppfMzWIwli9V0MSYzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yVi1d3U93ZIJoxiIwXJCDwMdF1iaWMXLnHPJvUljpU=;
 b=vfbbIZV9/0jOF7K2XIxR2GpR8A12llFZ9YAxOeTFiKsAwYMkkCZfUPyuJ4fa8UCOEPk8ixBxxkKiEF3pRY7zH+l++f11+EIyg2wNMqI5cXvRQpDT5VuTiDUbb9qFqldZzLbtVkrY6tOUqsDsK9TCaNbsZdzgNyF9zlAekKi1SUE=
Received: from BY5PR22MB2052.namprd22.prod.outlook.com (2603:10b6:a03:235::12)
 by BY5PR22MB1779.namprd22.prod.outlook.com (2603:10b6:a03:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 03:18:27 +0000
Received: from BY5PR22MB2052.namprd22.prod.outlook.com
 ([fe80::5c47:73c9:d7c:f1b4]) by BY5PR22MB2052.namprd22.prod.outlook.com
 ([fe80::5c47:73c9:d7c:f1b4%8]) with mapi id 15.20.3632.017; Wed, 2 Dec 2020
 03:18:27 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: PROBLEM: potential concurrency bug between do_vfs_ioctl() and
 do_readv()
Thread-Topic: PROBLEM: potential concurrency bug between do_vfs_ioctl() and
 do_readv()
Thread-Index: AQHWlaXfvTpx7KESnEekWqIbdjook6njiEwA
Date:   Wed, 2 Dec 2020 03:18:26 +0000
Message-ID: <DFE6D155-3123-488D-B6E3-02E8757A7585@purdue.edu>
References: <ED916641-1E2F-4256-9F4B-F3DEAEBE17E7@purdue.edu>
In-Reply-To: <ED916641-1E2F-4256-9F4B-F3DEAEBE17E7@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [98.223.109.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d881895-f1fc-4855-ada7-08d89670ef91
x-ms-traffictypediagnostic: BY5PR22MB1779:
x-microsoft-antispam-prvs: <BY5PR22MB177923EB0CF6035431C399C4DFF30@BY5PR22MB1779.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5DYLe9T8ahLAVJNNhl6t8Ph0HtN3/IjbWyDaUQtTEu3emzu5NTRJ20ahW+ZzrG8LxPOzaxadnGNRcR2NF8pQYZEV5blCcUKU1Keqotq8HFx1YODwJXGKX/0Jqh1vR5bWE4a8m6hVfI7t/ReV8HpJpu8/qlDXYCSQDNO7dPL/0Q7AiwrM0EfozLlntqTNEdn8s3Lo2IJmDZuSWmbOJ0m+Ynr0jhwxKpcha/5reO73ThTutcw9Pyw1GqaGJEzr2INpLe0AbFT9r6g5UcoDcc8UYeaSeun0XLADDJYntwe3sjJLkuXTI+CyPm/j9UermM9qhsQF+jdWZMPIYSNLSZ4CAKB2F3j5AMKbR8/VgJfcg3NZ5vbl/Hx3g7ixHNYM3FL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR22MB2052.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(396003)(39860400002)(6486002)(86362001)(316002)(786003)(26005)(5660300002)(6916009)(83380400001)(186003)(6512007)(6506007)(33656002)(2906002)(66946007)(71200400001)(53546011)(36756003)(2616005)(64756008)(66556008)(66476007)(478600001)(66446008)(8936002)(75432002)(8676002)(76116006)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OFkwMVdCdTZYMUxGeGwvY2ExQ2l5TGV0dkZBOVI4UDdoV3lENXRoajZNR29m?=
 =?utf-8?B?YUswTnp5em5sRER5UmlyelV4WVZwditVbExJSHlqSVBWMDJKeC9XK3NkckpX?=
 =?utf-8?B?OFlqK3FhSkxGSHVPcE9oUU9qZzR4LzJya3oxVUxyb0VrZGNHWHh6cXduVW9J?=
 =?utf-8?B?emlGa3ovT1c2cGIwZzBOUlllVVNoZTdxc0lRb01pZmJPU2VQMWpHUDBJRVFr?=
 =?utf-8?B?MXNTNmN6d3JwenZjQjRBVjlSUWRheUVzVytEbVd0Q1EwN1JvN0tNSDlIQXRq?=
 =?utf-8?B?R2kvakc4SlpRZ1MySmZNTWF4bmxSenhBck5lRmZ4YjhuYWUrRW1QTnlQZEkx?=
 =?utf-8?B?MVgxL2grbFUxemlCRUxBQjhnQUp4T3RmUkNkM2s2OXlGMFZ0ZnRRcVRaV1Fx?=
 =?utf-8?B?ZVltYjhYbkFvTFRFWUVGOG85ZHFVUGZSYVI0S1hOcStXekY1VUYzdWxoOFJH?=
 =?utf-8?B?MlhHWFhldWZibHVSRThncytBUGZ5WWZMTXg4M1E5czQ1dkZMQ0FUbXFadmpM?=
 =?utf-8?B?Q045aDR2Zit2ZDIwOFBFRDBSelhYMmJxd2ZVSXlPWmRJeXp3cnZBSFcveWJt?=
 =?utf-8?B?cmU1eEZqNzVJd3laS244dUQyQ01zSU9qUkgxL0RmSzY4S1BldmVxM1RxdmEr?=
 =?utf-8?B?eVNvb1Uxb2ZuTnJrVS8wc2JYZW5wYll3UUdNK0JnemF1bG52REJLVG1oVjdO?=
 =?utf-8?B?Wm5CdnhKUjVqVUhWTnVtRFoxUEZacm1rQlR3b056bGx3cVlmVVhUL0dRWWZ4?=
 =?utf-8?B?YmRBL21kU3ZrSElYeC9WaGx3dm9ZSWhyVmQvNFhabFBqMDl6N0NaWHRwU1N5?=
 =?utf-8?B?Q0ozVHBRMXl4M1lxaVhCSWQ2QWZqNGpZZjRxTFFKYWNTcmtNTUk2QUhnUE9P?=
 =?utf-8?B?aU9iVmVTUmZYTC95UFJRZU1qUEI0TnhqdjZZYTFGaHFjQjQ1dVBoYVlUb3JT?=
 =?utf-8?B?YStHNFlsNFV6R01nOFdZWFNkeUdkWkNtbXR2N3B3djZhZWl0c3pmSVFnclhq?=
 =?utf-8?B?R2tlMWZhaTRGbEI0aVUyT29wUGxQcThRQm43Q1hlMnFUczlPYUZIakVvN3JJ?=
 =?utf-8?B?K1VIVU1SeUlMbnpnNkJkSlA0TVhoK0l2Rk9CZkF0dUl5elE4Zlhya1g3dDhW?=
 =?utf-8?B?MU5OMDNXeFlnckFVRmJDbnZ4V3RBQlpyN1orcFBCMElGZE1pdDlZcWM4bW9v?=
 =?utf-8?B?OGhCYldWWG9mN3Y2dVhjcWNhYll3N0ZRNEFhZjV2eUNiV2FyUS9pYzl2b05C?=
 =?utf-8?B?VkxuUzRUNEwxdmNMcEJCZlI2dW0wZ3VHRFVXUlgybjZoTEtsQ3VWRU80eUdZ?=
 =?utf-8?Q?Nq9WRgBQf+yzK0YfA6Yu9sf0h+qQYCwThn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <969788E38FC18F4EBD67ACBE85AB4AA9@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR22MB2052.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d881895-f1fc-4855-ada7-08d89670ef91
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 03:18:26.8758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dk00mRhc5LaRtQ6/90MzlDhbeU1TuQN5HwePD1Aqn/hTi/yfZTvlum/o5n+3In5F6AVgZXSxOB/EC7GUAJcvJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR22MB1779
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

V2Ugd2FudCB0byByZXBvcnQgYW5vdGhlciBlcnJvciBtZXNzYWdlIHdlIHNhdyB3aGljaCBtaWdo
dCBiZSByZWxhdGVkIHRvIHRoaXMgYnVnLg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCktlcm5lbCBjb25zb2xlIG91dHB1dA0KWyAgMTM5LjQxNDc2NF0g
YmxrX3VwZGF0ZV9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBsb29wMCwgc2VjdG9yIDAgb3AgMHgw
OihSRUFEKSBmbGFncyAweDgwNzAwIHBoeXNfc2VnIDEgcHJpbyBjbGFzcyAwDQpbICAxMzkuNjI4
MDk5XSBibGtfdXBkYXRlX3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2IGxvb3AwLCBzZWN0b3IgMCBv
cCAweDA6KFJFQUQpIGZsYWdzIDB4MCBwaHlzX3NlZyAxIHByaW8gY2xhc3MgMA0KWyAgMTM5Ljg0
MDI0M10gQnVmZmVyIEkvTyBlcnJvciBvbiBkZXYgbG9vcDAsIGxvZ2ljYWwgYmxvY2sgMCwgYXN5
bmMgcGFnZSByZWFkDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KRGVzY3JpcHRpb24NClRoaXMgZXJyb3JzIGNvbWVzIHVwIHdoZW4gdGhlIGZvbGxvd2lu
ZyB0d28ga2VybmVsIHRlc3QgaW5wdXQgcnVuIGNvbmN1cnJlbnRseS4gVGhlIHJlYXNvbiB3ZSBz
dGlsbCB0aGluayB0aGlzIGlzIGEgY29uY3VycmVuY3kgYnVnIGJlY2F1c2Ugb25seSBhIGZldyBp
bnRlcmxlYXZpbmdzIGNhbiByZXByb2R1Y2UgaXQuDQpIb3dldmVyLCBkdWUgdG8gdGhlIGNvbXBs
ZXhpdHksIHdlIGFyZSBzdGlsbCBkaWFnbm9zaW5nIHRoaXMgcHJvYmxlbSBhbmQgd2Ugd2lsbCB0
cnkgdG8gcHJvdmlkZSBhIG1vcmUgZGV0YWlsZWQgYW5hbHlzaXMgc29vbi4NCg0KVGVzdCBpbnB1
dCAxDQpzeXpfbW91bnRfaW1hZ2UkZXh0NCgweDAsIDB4MCwgMHgwLCAweDEsICYoMHg3ZjAwMDAw
MDA1MDApPVt7JigweDdmMDAwMDAwMDJjMCk9ImNjIiwgMHgxLCAweDdmZmZ9XSwgMHgwLCAweDAp
DQoNClRlc3QgaW5wdXQgMg0Kc3l6X21vdW50X2ltYWdlJG1zZG9zKCYoMHg3ZjAwMDAwMDAwMDAp
PSdtc2Rvc1x4MDAnLCAmKDB4N2YwMDAwMDAwMDQwKT0nLi9maWxlMFx4MDAnLCAweDAsIDB4MCwg
JigweDdmMDAwMDAwMDIwMCksIDB4MCwgJigweDdmMDAwMDAwMDI4MCk9e1t7QGZhdD1AY29kZXBh
Z2U9eydjb2RlcGFnZScsIDB4M2QsICc5NTAnfX0sIHtAZmF0PUBmbWFzaz17J2ZtYXNrJywgMHgz
ZCwgMHgxMDAwMDAwMDF9fV19KQ0KDQoNClRoYW5rcywNClNpc2h1YWkNCg0KPiBPbiBTZXAgMjgs
IDIwMjAsIGF0IDEwOjQ0IEFNLCBHb25nLCBTaXNodWFpIDxzaXNodWFpQHB1cmR1ZS5lZHU+IHdy
b3RlOg0KPiANCj4gSGksDQo+IA0KPiBXZSBmb3VuZCBhIHBvdGVudGlhbCBjb25jdXJyZW5jeSBi
dWcgaW4gbGludXgga2VybmVsIDUuMy4xMS4gV2UgYXJlIGFibGUgdG8gcmVwcm9kdWNlIHRoaXMg
YnVnIGluIHg4NiB1bmRlciBzcGVjaWZpYyB0aHJlYWQgaW50ZXJsZWF2aW5ncy4gVGhpcyBidWcg
Y2F1c2VzIGEgYmxrX3VwZGF0ZV9yZXF1ZXN0IEkvTyBlcnJvci4NCj4gDQo+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBLZXJuZWwgY29uc29sZSBvdXRwdXQN
Cj4gYmxrX3VwZGF0ZV9yZXF1ZXN0OiBJL08gZXJyb3IsIGRldiBsb29wMCwgc2VjdG9yIDAgb3Ag
MHgwOihSRUFEKSBmbGFncyAweDgwNzAwIHBoeXNfc2VnIDEgcHJpbyBjbGFzcyAwDQo+IA0KPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gVGVzdCBpbnB1dA0K
PiBUaGlzIGJ1ZyBvY2N1cnMgd2hlbiBrZXJuZWwgZnVuY3Rpb25zIGRvX3Zmc19pb2N0bCgpIGFu
ZCBkb19yZWFkdigpIGFyZSBleGVjdXRlZCB3aXRoIGNlcnRhaW4gcGFyYW1ldGVycyBpbiB0d28g
c2VwYXJhdGUgdGhyZWFkcyBhbmQgcnVuIGNvbmN1cnJlbnRseS4NCj4gDQo+IFRoZSB0ZXN0IHBy
b2dyYW0gaXMgZ2VuZXJhdGVkIGluIFN5emthbGxlcuKAmXMgZm9ybWF0IGFzIGZvbGxvd3M6DQo+
IFRlc3QgMSBbcnVuIGluIHRocmVhZCAxXQ0KPiBzeXpfcmVhZF9wYXJ0X3RhYmxlKDB4MCwgMHgx
LCAmKDB4N2YwMDAwMDAwNmMwKT1bezB4MCwgMHgwLCAweDEwMH1dKQ0KPiBUZXN0IDIgW3J1biBp
biB0aHJlYWQgMl0NCj4gcjAgPSBzeXpfb3Blbl9kZXYkbG9vcCgmKDB4N2YwMDAwMDAwMDAwKT0n
L2Rldi9sb29wI1x4MDAnLCAweDAsIDB4MCkNCj4gcmVhZHYocjAsICYoMHg3ZjAwMDAwMDAzNDAp
PVt7JigweDdmMDAwMDAwMDQ0MCk9IiIvNDA5NiwgMHgxMDAwfV0sIDB4MSkNCj4gDQo+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBJbnRlcmxlYXZpbmcNCj4g
VGhyZWFkIDEJCQkJCQkJCQkJCQkJVGhyZWFkIDINCj4gCQkJCQkJCQkJCQkJCQlkb19yZWFkdigp
DQo+IAkJCQkJCQkJCQkJCQkJLXZmc19yZWFkdigpDQo+IAkJCQkJCQkJCQkJCQkJLS1kb19pdGVy
X3JlYWQoKQ0KPiAJCQkJCQkJCQkJCQkJCS0tLWRvX2l0ZXJfcmVhZHZfd3JpdGV2KCkNCj4gCQkJ
CQkJCQkJCQkJCQktLS0tYmxrZGV2X3JlYWRfaXRlcigpDQo+IGRvX3Zmc19pb2N0bCgpCQkJCQkJ
DQo+IC0tdmZzX2lvY3RsKCkJDQo+IC0tYmxrZGV2X2lvY3RsKCkNCj4gLS0tYmxrZGV2X2RyaXZl
cl9pb2N0bCgpCQkJCQ0KPiAtLS0tbG9vcF9zZXRfZmQoKQ0KPiAtLS0tLWJkX3NldF9zaXplKCkN
Cj4gCQkJCQkJCQkJCQkJCQkJKGZzL2Jsa19kZXYuYzoxOTk5KQ0KPiAJCQkJCQkJCQkJCQkJCQls
b2ZmX3Qgc2l6ZSA9IGlfc2l6ZV9yZWFkKGJkX2lub2RlKTsNCj4gCQkJCQkJCQkJCQkJCQkJbG9m
Zl90IHBvcyA9IGlvY2ItPmtpX3BvczsNCj4gCQkJCQkJCQkJCQkJCQkJaWYgKHBvcyA+PSBzaXpl
KQ0KPiAJCQkJCQkJCQkJCQkJCQkJcmV0dXJuIDA7DQo+IAkJCQkJCQkJCQkJCQkJCXNpemUgLT0g
cG9zOw0KPiANCj4gCQkJCQkJCQkJCQkJCQktLS0tZ2VuZXJpY19maWxlX3JlYWRfaXRlcigpDQo+
IAkJCQkJCQkJCQkJCQkJCShtbS9maWxlbWFwLmM6MjA2OSkJDQo+IAkJCQkJCQkJCQkJCQkJCXBh
Z2UgPSBmaW5kX2dldF9wYWdlKG1hcHBpbmcsIGluZGV4KTsNCj4gCQkJCQkJCSAgCQkJCQkJCQlp
ZiAoIXBhZ2UpIHsNCj4gCQkJCQkJCQkJCQkJCQkJCWlmIChpb2NiLT5raV9mbGFncyAmIElPQ0Jf
Tk9XQUlUKQ0KPiAJCQkJCQkJCQkJCQkJCQkJCWdvdG8gd291bGRfYmxvY2s7DQo+IAkJCQkJCQkJ
CQkJCQkJCXBhZ2VfY2FjaGVfc3luY19yZWFkYWhlYWQobWFwcGluZywNCj4gDQo+IAkJCQkJCQkJ
CQkJCQkJCS0tLS0tcGFnZV9jYWNoZV9zeW5jX3JlYWRhaGVhZCgpDQo+IAkJCQkJCQkJCQkJCQkJ
CS0tLS0tLW9uZGVtYW5kX3JlYWRhaGVhZCgpDQo+IAkJCQkJCQkJCQkJCQkJCeKApg0KPiAJCQkJ
CQkJCQkJCQkJCQktLS0tLS0tLS0tLS4uLmJsa191cGRhdGVfcmVxdWVzdCgpDQo+IAkJCQkJCQkJ
CQkJCQkJCShlcnJvcikNCj4gLS0tLS1sb29wX3N5c2ZzX2luaXQoKQ0KPiDigKYNCj4gDQo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBBbmFseXNpcw0KPiBX
ZSBvYnNlcnZlZCB0aGF0IHdoZW4gdGhyZWFkIDIgaXMgZXhlY3V0ZWQgYWxvbmUgd2l0aG91dCB0
aHJlYWQgMSwgaV9zaXplX3JlYWQoKSBhdCBmcy9ibGtfZGV2LmM6MTk5OSByZXR1cm5zIGEgc2l6
ZSBvZiAwLCB0aHVzIGluIHNlcXVlbnRpYWwgbW9kZSBibGtkZXZfcmVhZF9pdGVyKCkgcmV0dXJu
cyBkaXJlY3RseSBhdCDigJxyZXR1cm4gMDvigJ0gSG93ZXZlciwgd2hlbiB0d28gdGhyZWFkcyBh
cmUgZXhlY3V0ZWQgY29uY3VycmVudGx5LCB0aHJlYWQgMSBjaGFuZ2VzIHRoZSBzaXplIG9mIHRo
ZSBzYW1lIGlub2RlIHRoYXQgdGhyZWFkIDIgaXMgY29uY3VycmVudGx5IGFjY2Vzc2luZywgdGhl
biB0aHJlYWQgMiBnb2VzIGludG8gYSBkaWZmZXJlbnQgcGF0aCwgZXZlbnR1YWxseSBjYXVzaW5n
IHRoZSBibGtfdXBkYXRlX3JlcXVlc3QgSS9PIGVycm9yLg0KPiANCj4gDQo+IFRoYW5rcywNCj4g
U2lzaHVhaQ0KPiANCg0K
