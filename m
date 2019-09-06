Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69EDAAFF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 02:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbfIFAzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 20:55:36 -0400
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:27817
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387908AbfIFAzf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:55:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAkOhwjIQcxtvyDDKppjVZ43FujCIQTU6dV9Qug09HRJJw9Lp56yas7fA4CrMFCG/WkSYuk3HfzDgMh6rbwTgvx97dG2+vD0Fnn+HUzl+4DXRYwHlx2a2RFzax/ChBCS0YsF3dDr9MTzC4bXF/+a/hXqKx+Dl6Ohi47anscGbVzzamigiFmavAMhXnVSj2xeCSwjzRNgKNjANaAlUmpAr0Pgjajmdc7eIIvkSSAhWXdHUfVffKK/SffBw6tA6WE9cT4ilLBWaGUL9Z81uxJWi5c5o4OzCVrt0H1oAZQzf2I8QoDCWrw1Jabs5MgfB7ELT5V5X59EFmav1alh7SZ0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrhmbyavE/pa8U+AGsBClAYliJ4UZ2TrvmtS0PSnM1M=;
 b=F3+rlnGBrmIRzRGNFs3D+DnhGX+ouExPHPCy3JlvWG9VZeWLWWMft/f150ky7UwcdbYqkEIXWsCijJJ4IMqCji4WAYbHVjY8TT+0JlO0ZxYA4Ty2JSJQ3d65ONAF/s5FIl2lm9uV/s8lexjgJuOjn/ZTc7x8DD3m8PUDI3En+E+dY0yZBx5H4VTiMeXqGdPwHtlk3An2gcP3Kdt6yOcX42GA0/E/amOlXhELqcZ12d8ZDPTLOdBPRlAMFplKM1nleeJAWym+7eq8yjiAyX2EaWboI9vDODGjYRoKOPKR9mDkrBMm8wKs1yQcnWwWT6H5FvswtcSAd0bZ0f8WyMqK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrhmbyavE/pa8U+AGsBClAYliJ4UZ2TrvmtS0PSnM1M=;
 b=sDr21PdTmqwC+tFjX8tSpdth/h2iT6RIPxKEgPS0hhLfOy+tGjZshIDzDkNkLAWAEBFSlkAvYaZrqAimJ1QvpX864qgc+cymJhQeZ/yQwhOT6JG8ErkIai9ezeqa6IAOrTo6MKxPyDA8mLmrMmhc0/spy5Jzx+cNvzWVvtfGTK8=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (20.179.233.225) by
 VE1PR04MB6382.eurprd04.prod.outlook.com (20.179.232.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Fri, 6 Sep 2019 00:55:23 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::b562:85a9:9f8a:20ff]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::b562:85a9:9f8a:20ff%5]) with mapi id 15.20.2241.018; Fri, 6 Sep 2019
 00:55:23 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "zhengbin (A)" <zhengbin13@huawei.com>
CC:     "jack@suse.cz" <jack@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "renxudong1@huawei.com" <renxudong1@huawei.com>
Subject: RE: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Thread-Topic: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Thread-Index: AQHVZBILYEzDeP0Cg0mWzxdZsrHq2acdzqgA
Date:   Fri, 6 Sep 2019 00:55:22 +0000
Message-ID: <VE1PR04MB652816E4C0903D7489F2E08589BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <20190905174744.GP1131@ZenIV.linux.org.uk>
In-Reply-To: <20190905174744.GP1131@ZenIV.linux.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b4737d0-ad61-40d7-36ce-08d73264e60f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6382;
x-ms-traffictypediagnostic: VE1PR04MB6382:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VE1PR04MB6382CB542C06E5603F02128689BA0@VE1PR04MB6382.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(13464003)(189003)(199004)(9686003)(81156014)(486006)(6436002)(44832011)(476003)(6306002)(71190400001)(11346002)(66066001)(64756008)(55016002)(81166006)(53936002)(66446008)(76116006)(102836004)(53546011)(8676002)(66476007)(54906003)(66556008)(71200400001)(186003)(6246003)(76176011)(26005)(446003)(66946007)(316002)(7696005)(8936002)(7736002)(110136005)(52536014)(966005)(6506007)(33656002)(256004)(2906002)(74316002)(14444005)(14454004)(6116002)(3846002)(4326008)(86362001)(25786009)(305945005)(99286004)(478600001)(229853002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6382;H:VE1PR04MB6528.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PI5CMXRdelUo3zUIJc5Pwgfgs8nB/s88/l6hIvC+zINahVS7ln+SVpj1fYX2yydrAiaZfzYX+t4wJxBubFYCYAHPF3TUoRmwz1GFJNQvgKbAvoDQWoj/wUFq50DlQeMZselYJ21AI/WO2/L4SfSh4HUirCUoQO6t1TaCjyoIYkOChvT2Rqtdcyv0Ku9CbOkZRHS9imG8IMa3yQFtlYM2bKAAt5l+GtvvrbBboF84j1aR/CSfqn4XnGzG5QjrJJ+lssTJ5p9dyV9Xl/XGFMNgmixWNrYdoeko+KeDx4NwnZscBiWpFWLaiC6VXGHjcpU08/ya6DxmdX6A7V/kP5Fk9zMHbS48mC52LXOlrpWk2lt0XysFlN4t0tQ4F08yxVcyHi/5i2IS3ehAN14ZR8fafdz1VbJQSNya98tURyQx8Vc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4737d0-ad61-40d7-36ce-08d73264e60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 00:55:23.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5U8qtf/Yw2RQDuoBVtr90ge96IJIEOzuOdKDjboF9ZOiZFc+RO1oxanV6EtmVdX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6382
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsIFZpcm8gPHZpcm9A
ZnRwLmxpbnV4Lm9yZy51az4gT24gQmVoYWxmIE9mIEFsIFZpcm8NCj4gU2VudDogMjAxOeW5tDnm
nIg25pelIDE6NDgNCj4gVG86IHpoZW5nYmluIChBKSA8emhlbmdiaW4xM0BodWF3ZWkuY29tPg0K
PiBDYzogamFja0BzdXNlLmN6OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1mc2Rl
dmVsQHZnZXIua2VybmVsLm9yZzsgemhhbmd5aQ0KPiAoRikgPHlpLnpoYW5nQGh1YXdlaS5jb20+
OyByZW54dWRvbmcxQGh1YXdlaS5jb207IEp1biBMaSA8anVuLmxpQG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBQb3NzaWJsZSBGUyByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuIGl0ZXJhdGVfZGlyIGFu
ZCBkX2FsbG9jX3BhcmFsbGVsDQo+IA0KPiBPbiBXZWQsIFNlcCAwNCwgMjAxOSBhdCAwMjoxNTo1
OFBNICswODAwLCB6aGVuZ2JpbiAoQSkgd3JvdGU6DQo+ID4gPj4NCj4gPiA+PiBDb25mdXNlZC4u
LiAgT1RPSCwgSSBtaWdodCBiZSBtaXNyZWFkaW5nIHRoYXQgdGFibGUgb2YgeW91cnMgLSBpdCdz
DQo+ID4gPj4gYWJvdXQgMzAlIHdpZGVyIHRoYW4gdGhlIHdpZGVzdCB4dGVybSBJIGNhbiBnZXQg
d2hpbGUgc3RpbGwgYmVpbmcNCj4gPiA+PiBhYmxlIHRvIHJlYWQgdGhlIGZvbnQuLi4NCj4gPg0K
PiA+IFRoZSB0YWJsZSBpcyBteSBndWVzcy4gVGhpcyBvb3BzIGhhcHBlbnMgc29tZXRpbWVzDQo+
ID4NCj4gPiAoV2UgaGF2ZSBvbmUgdm1jb3JlLCBvdGhlcnMganVzdCBoYXZlIGxvZywgYW5kIHRo
ZSBiYWNrdHJhY2UgaXMgc2FtZSB3aXRoIHZtY29yZSwgc28NCj4gdGhlIHJlYXNvbiBzaG91bGQg
YmUgc2FtZSkuDQo+ID4NCj4gPiBVbmZvcnR1bmF0ZWx5LCB3ZSBkbyBub3Qga25vdyBob3cgdG8g
cmVwcm9kdWNlIGl0LiBUaGUgdm1jb3JlIGhhcyBzdWNoIGEgbGF3Og0KPiA+DQo+ID4gMeOAgWRp
ckEgaGFzIDE3NyBmaWxlcywgYW5kIGl0IGlzIE9LDQo+ID4NCj4gPiAy44CBZGlyQiBoYXMgMjUg
ZmlsZXMsIGFuZCBpdCBpcyBPSw0KPiA+DQo+ID4gM+OAgVdoZW4gd2UgbHMgZGlyQSwgaXQgYmVn
aW5zIHdpdGggIi4iLCAiLi4iLCBkaXJCJ3MgZmlyc3QgZmlsZSwgc2Vjb25kDQo+ID4gZmlsZS4u
LiBsYXN0IGZpbGUswqAgbGFzdCBmaWxlLT5uZXh0ID0gJihkaXJCLT5kX3N1YmRpcnMpDQo+IA0K
PiBIbW0uLi4gIE5vdywgdGhhdCBpcyBpbnRlcmVzdGluZy4gIEknbSBub3Qgc3VyZSBpdCBoYXMg
YW55dGhpbmcgdG8gZG8gd2l0aCB0aGF0IGJ1ZywgYnV0DQo+IGxvY2tsZXNzIGxvb3BzIG92ZXIg
ZF9zdWJkaXJzIGNhbiBydW4gaW50byB0cm91YmxlLg0KPiANCj4gTG9vazogZGVudHJ5X3VubGlz
dCgpIGxlYXZlcyB0aGUgLT5kX2NoaWxkLm5leHQgcG9pbnRpbmcgdG8gdGhlIG5leHQgbm9uLWN1
cnNvciBsaXN0IGVsZW1lbnQNCj4gKG9yIHBhcmVudCdzIC0+ZF9zdWJkaXIsIGlmIHRoZXJlJ3Mg
bm90aGluZyBlbHNlIGxlZnQpLiAgSXQgd29ya3MgaW4gcGFpciB3aXRoIGRfd2FsaygpOiB0aGVy
ZSB3ZQ0KPiBoYXZlDQo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGVudHJ5ICpjaGlsZCA9IHRo
aXNfcGFyZW50Ow0KPiAgICAgICAgICAgICAgICAgdGhpc19wYXJlbnQgPSBjaGlsZC0+ZF9wYXJl
bnQ7DQo+IA0KPiAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJmNoaWxkLT5kX2xvY2spOw0K
PiAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrKCZ0aGlzX3BhcmVudC0+ZF9sb2NrKTsNCj4gDQo+
ICAgICAgICAgICAgICAgICAvKiBtaWdodCBnbyBiYWNrIHVwIHRoZSB3cm9uZyBwYXJlbnQgaWYg
d2UgaGF2ZSBoYWQgYSByZW5hbWUuICovDQo+ICAgICAgICAgICAgICAgICBpZiAobmVlZF9zZXFy
ZXRyeSgmcmVuYW1lX2xvY2ssIHNlcSkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
cmVuYW1lX3JldHJ5Ow0KPiAgICAgICAgICAgICAgICAgLyogZ28gaW50byB0aGUgZmlyc3Qgc2li
bGluZyBzdGlsbCBhbGl2ZSAqLw0KPiAgICAgICAgICAgICAgICAgZG8gew0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBuZXh0ID0gY2hpbGQtPmRfY2hpbGQubmV4dDsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKG5leHQgPT0gJnRoaXNfcGFyZW50LT5kX3N1YmRpcnMpDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBhc2NlbmQ7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGNoaWxkID0gbGlzdF9lbnRyeShuZXh0LCBzdHJ1Y3QgZGVudHJ5LCBkX2NoaWxk
KTsNCj4gICAgICAgICAgICAgICAgIH0gd2hpbGUgKHVubGlrZWx5KGNoaWxkLT5kX2ZsYWdzICYg
RENBQ0hFX0RFTlRSWV9LSUxMRUQpKTsNCj4gICAgICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9j
aygpOw0KPiANCj4gTm90ZSB0aGUgcmVjaGVjayBvZiByZW5hbWVfbG9jayB0aGVyZSAtIGl0IGRv
ZXMgZ3VhcmFudGVlIHRoYXQgZXZlbiBpZiBjaGlsZCBoYXMgYmVlbg0KPiBraWxsZWQgb2ZmIGJl
dHdlZW4gdW5sb2NraW5nIGl0IGFuZCBsb2NraW5nIHRoaXNfcGFyZW50LCB3aGF0ZXZlciBpdCBo
YXMgZW5kZWQgdXAgd2l0aCBpbiBpdHMNCj4gLT5kX2NoaWxkLT5uZXh0IGhhcyAqbm90KiBiZWVu
IG1vdmVkIGVsc2V3aGVyZS4gIEl0IG1pZ2h0LCBpbiB0dXJuLCBoYXZlIGJlZW4ga2lsbGVkIG9m
Zi4NCj4gSW4gdGhhdCBjYXNlIGl0cyAtPmRfY2hpbGQubmV4dCBwb2ludHMgdG8gdGhlIG5leHQg
c3Vydml2aW5nIG5vbi1jdXJzb3IsIGFsc28gZ3VhcmFudGVlZCB0bw0KPiByZW1haW4gaW4gdGhl
IHNhbWUgZGlyZWN0b3J5LCBldGMuDQo+IA0KPiBIb3dldmVyLCBsb3NlIHRoYXQgcmVuYW1lX2xv
Y2sgcmVjaGVjayBhbmQgd2UnZCBnZXQgc2NyZXdlZCwgdW5sZXNzIHRoZXJlJ3Mgc29tZQ0KPiBv
dGhlciBkX21vdmUoKSBwcmV2ZW50aW9uIGluIGVmZmVjdC4NCj4gDQo+IE5vdGUgdGhhdCBhbGwg
bGliZnMuYyB1c2VycyAobmV4dF9wb3NpdGl2ZSgpLCBtb3ZlX2N1cnNvcigpLCBkY2FjaGVfZGly
X2xzZWVrKCksDQo+IGRjYWNoZV9yZWFkZGlyKCksIHNpbXBsZV9lbXB0eSgpKSBzaG91bGQgYmUg
c2FmZSAtIGRjYWNoZV9yZWFkZGlyKCkgaXMgY2FsbGVkIHdpdGgNCj4gZGlyZWN0b3J5IGxvY2tl
ZCBhdCBsZWFzdCBzaGFyZWQsIHVzZXMgaW4gZGNhY2hlX2Rpcl9sc2VlaygpIGFyZSBzdXJyb3Vu
ZGVkIGJ5IHRoZSBzYW1lLA0KPiBtb3ZlX2N1cnNvcigpIGFuZCBzaW1wbGVfZW1wdHkoKSBob2xk
IC0+ZF9sb2NrIG9uIHBhcmVudCwNCj4gbmV4dF9wb3NpdGl2ZSgpIGlzIGNhbGxlZCBvbmx5IHVu
ZGVyIHRoZSBsb2NrIG9uIGRpcmVjdG9yeSdzIGlub2RlIChhdCBsZWFzdCBzaGFyZWQpLiAgQW55
IG9mDQo+IHRob3NlIHNob3VsZCBwcmV2ZW50IGFueSBraW5kIG9mIGNyb3NzLWRpcmVjdG9yeSBt
b3ZlcyAtIGJvdGggaW50byBhbmQgb3V0IG9mLg0KPiANCj4gPGdyZXBzIGZvciBkX3N1YmRpcnMv
ZF9jaGlsZCB1c2Vycz4NCj4gDQo+IEh1aD8NCj4gSW4gZHJpdmVycy91c2IvdHlwZWMvdGNwbS90
Y3BtLmM6DQo+IHN0YXRpYyB2b2lkIHRjcG1fZGVidWdmc19leGl0KHN0cnVjdCB0Y3BtX3BvcnQg
KnBvcnQpIHsNCj4gICAgICAgICBpbnQgaTsNCj4gDQo+ICAgICAgICAgbXV0ZXhfbG9jaygmcG9y
dC0+bG9nYnVmZmVyX2xvY2spOw0KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBMT0dfQlVGRkVS
X0VOVFJJRVM7IGkrKykgew0KPiAgICAgICAgICAgICAgICAga2ZyZWUocG9ydC0+bG9nYnVmZmVy
W2ldKTsNCj4gICAgICAgICAgICAgICAgIHBvcnQtPmxvZ2J1ZmZlcltpXSA9IE5VTEw7DQo+ICAg
ICAgICAgfQ0KPiAgICAgICAgIG11dGV4X3VubG9jaygmcG9ydC0+bG9nYnVmZmVyX2xvY2spOw0K
PiANCj4gICAgICAgICBkZWJ1Z2ZzX3JlbW92ZShwb3J0LT5kZW50cnkpOw0KPiAgICAgICAgIGlm
IChsaXN0X2VtcHR5KCZyb290ZGlyLT5kX3N1YmRpcnMpKSB7DQo+ICAgICAgICAgICAgICAgICBk
ZWJ1Z2ZzX3JlbW92ZShyb290ZGlyKTsNCj4gICAgICAgICAgICAgICAgIHJvb3RkaXIgPSBOVUxM
Ow0KPiAgICAgICAgIH0NCj4gfQ0KPiANCj4gVW5yZWxhdGVkLCBidXQgb2J2aW91c2x5IGJyb2tl
bi4gIE5vdCBvbmx5IHRoZSBsb2NraW5nIGlzIGRlZXBseSBzdXNwZWN0LCBidXQgaXQncyB0cml2
aWFsbHkNCj4gY29uZnVzZWQgYnkgb3BlbigpIG9uIHRoZSBkYW1uIGRpcmVjdG9yeS4gIEl0IHdp
bGwgZGVmaW5pdGVseSBoYXZlIC0+ZF9zdWJkaXJzIG5vbi1lbXB0eS4NCj4gDQo+IENhbWUgaW4g
InVzYjogdHlwZWM6IHRjcG06IHJlbW92ZSB0Y3BtIGRpciBpZiBubyBjaGlsZHJlbiIsIGF1dGhv
ciBDYydkLi4uICBXaHkgbm90DQo+IHJlbW92ZSB0aGUgZGlyZWN0b3J5IG9uIHJtbW9kPw0KDQpU
aGF0J3MgYmVjYXVzZSB0Y3BtIGlzIGEgdXRpbGl0eSBkcml2ZXIgYW5kIHRoZXJlIG1heSBiZSBt
dWx0aXBsZSBpbnN0YW5jZXMNCmNyZWF0ZWQgdW5kZXIgdGhlIGRpcmVjdG9yeSwgZWFjaCBpbnN0
YW5jZS91c2VyIHJlbW92YWwgd2lsbCBjYWxsIHRvIHRjcG1fZGVidWdmc19leGl0KCkNCmJ1dCBv
bmx5IHRoZSBsYXN0IG9uZSBzaG91bGQgcmVtb3ZlIHRoZSBkaXJlY3RvcnkuDQoNCkJlbG93IHBh
dGNoIGNoYW5nZWQgdGhpcyBieSB1c2luZyBkZWRpY2F0ZWQgZGlyIGZvciBlYWNoIGluc3RhbmNl
Og0KDQpodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC11c2IvbXNnMTgzOTY1Lmh0
bWwNCg0KTGkgSnVuDQo+IEFuZCBjcmVhdGUgb24gaW5zbW9kLCBpbml0aWFsbHkgZW1wdHkuLi4N
Cj4gDQo+IGZzL25mc2QvbmZzY3RsLmM6DQo+IHN0YXRpYyB2b2lkIG5mc2Rmc19yZW1vdmVfZmls
ZXMoc3RydWN0IGRlbnRyeSAqcm9vdCkgew0KPiAgICAgICAgIHN0cnVjdCBkZW50cnkgKmRlbnRy
eSwgKnRtcDsNCj4gDQo+ICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGRlbnRyeSwg
dG1wLCAmcm9vdC0+ZF9zdWJkaXJzLCBkX2NoaWxkKSB7DQo+ICAgICAgICAgICAgICAgICBpZiAo
IXNpbXBsZV9wb3NpdGl2ZShkZW50cnkpKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIFdB
Uk5fT05fT05DRSgxKTsgLyogSSB0aGluayB0aGlzIGNhbid0IGhhcHBlbj8gKi8NCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+IEl0IGNhbiBoYXBwZW4gLSBhZ2FpbiwganVz
dCBoYXZlIGl0IG9wZW5lZCBhbmQgaXQgYmxvb2R5IHdlbGwgd2lsbC4NCj4gTG9ja2luZyBpcyBP
SywgdGhvdWdoIC0gcGFyZW50J3MgaW5vZGUgaXMgbG9ja2VkLCBzbyB3ZSBhcmUgc2FmZSBmcm9t
IGRfbW92ZSgpIHBsYXlpbmcNCj4gc2lsbHkgYnVnZ2VycyB0aGVyZS4NCj4gDQo+IGZzL2F1dG9m
cy9yb290LmM6DQo+IHN0YXRpYyB2b2lkIGF1dG9mc19jbGVhcl9sZWFmX2F1dG9tb3VudF9mbGFn
cyhzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpIHsgLi4uDQo+ICAgICAgICAgLyogU2V0IHBhcmVudCBt
YW5hZ2VkIGlmIGl0J3MgYmVjb21pbmcgZW1wdHkgKi8NCj4gICAgICAgICBpZiAoZF9jaGlsZC0+
bmV4dCA9PSAmcGFyZW50LT5kX3N1YmRpcnMgJiYNCj4gICAgICAgICAgICAgZF9jaGlsZC0+cHJl
diA9PSAmcGFyZW50LT5kX3N1YmRpcnMpDQo+ICAgICAgICAgICAgICAgICBtYW5hZ2VkX2RlbnRy
eV9zZXRfbWFuYWdlZChwYXJlbnQpOw0KPiANCj4gU2FtZSBib2dvc2l0eSByZWdhcmRpbmcgdGhl
IGNoZWNrIGZvciBlbXB0aW5lc3MgKHRoYXQgb25lIG1pZ2h0J3ZlIGJlZW4gbXkgZmF1bHQpLg0K
PiBMb2NraW5nIGlzIHNhZmUuLi4gIE5vdCBzdXJlIGlmIGFsbCBwbGFjZXMgaW4gYXV0b2ZzL2V4
cGlyZS5jIGFyZSBjYXJlZnVsIGVub3VnaC4uLg0KPiANCj4gU28gaXQgZG9lc24ndCBsb29rIGxp
a2UgdGhpcyB0aGVvcnkgaG9sZHMuICBXaGljaCBmaWxlc3lzdGVtIGhhZCB0aGF0IGJlZW4gb24g
YW5kIHdoYXQNCj4gYWJvdXQgLT5kX3BhcmVudCBvZiBkZW50cmllcyBpbiBkaXJBIGFuZCBkaXJC
DQo+IC0+ZF9zdWJkaXJzPw0K
