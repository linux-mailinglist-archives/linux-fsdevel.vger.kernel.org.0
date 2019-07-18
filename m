Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDAF6D308
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfGRRrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 13:47:06 -0400
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:19584
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfGRRrF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:47:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dadVJznFYDOQz8y7tDnbEp+cUJhcjou+zVL9cZLOElASvhLURJgj0X5TCOuqT7fUmQHGhrQmxu3dYaNg70LCE8Z+MhA8tshcFVkldR5O8+/HIva35EA14jWMyxE5+twg3EFxihbtXDfSvCWwVysDFRz4x7OuwBmbQ1msOtc1OgkeBrKHQLWY59USn90w9ANmwSLOyLJaB5k3cZsJvjKBU47eR/xMFX1lERfTlYWshElxTF/xOKQETdF/ErhZ+OZMiOueezYxF6BhB3MtIjZGo/FYuVs+tCb8JL5Gs0k+7R2HFjja7Q7v4xEl7HkpRZFQAaAvbKA4U/ZTidz3akD4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tOe0visBYdGs3MXpfdztXVmFPQbX+FomCoT7LIxekQ=;
 b=aMrcdtaX0IeXOxYJUCdSbUpOFQHt5czpv6XhCWtyGGn9+tde4y1dCyh6h/aVY2zCbV4mgr+nbYjYCo+w5/TQh1wSKOyzaMMmOAdIAKO6GLd+OHKO21ZUsPwo3F/Mceal6Oh+Z+VdoEugvjxkdh4QuxcytI8IWQLzzs+rspQ+TBXuTpvmZEWxeGtIY/ojFRK6jQi0/X1ivZMesDEmJHfWpqzCu2jTb2iQP72s20HttaIsfCX3winVKifjyJsw+EXce9iQj4ys9+0RkJsr9Z8y1+M2Cdraz57u9bcXJBfWGxSIhIjqSKS1lPUkTBa0W4MRk38GYqjskaPRGQVr3F6nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tOe0visBYdGs3MXpfdztXVmFPQbX+FomCoT7LIxekQ=;
 b=mWnSia1tFvzDrjnTmewSMH9L/V2xSxt1LWNQWUBHmDvxGuXid5KRPTLoC36rcILAIoZZekClfIci6nKLN1gr+PA+BdD2xaPn50T8tKb3YfrunOiz4fFK4HZJiW6cCz8gvuCTj7fBqEt0sCZ4ik0I7paUIom4f3/Vh/PnXRH+xYk=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB4155.namprd12.prod.outlook.com (10.141.8.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Thu, 18 Jul 2019 17:47:02 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 17:47:02 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 5/6] fs/core/vmcore: Move sev_active() reference to x86
 arch code
Thread-Topic: [PATCH v3 5/6] fs/core/vmcore: Move sev_active() reference to
 x86 arch code
Thread-Index: AQHVPRkNny8Ij5XGSEqqm2aPE2P6lqbQp2SA
Date:   Thu, 18 Jul 2019 17:47:01 +0000
Message-ID: <4a07bf75-b516-c81b-da7a-4b323e6d7e52@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
 <20190718032858.28744-6-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-6-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:5:1c::24) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e5801d8-895f-4f4f-9389-08d70ba7f053
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB4155;
x-ms-traffictypediagnostic: DM6PR12MB4155:
x-microsoft-antispam-prvs: <DM6PR12MB415592443717BF15C1C735B3ECC80@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(5660300002)(54906003)(256004)(110136005)(4326008)(11346002)(316002)(2616005)(2906002)(6506007)(446003)(53546011)(76176011)(26005)(102836004)(31686004)(14454004)(99286004)(52116002)(229853002)(386003)(486006)(476003)(31696002)(186003)(86362001)(25786009)(71200400001)(36756003)(3846002)(6116002)(66946007)(64756008)(66476007)(66556008)(7736002)(66446008)(478600001)(8676002)(2501003)(6512007)(7416002)(6486002)(6436002)(68736007)(53936002)(6246003)(8936002)(81156014)(81166006)(305945005)(71190400001)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4155;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CvML0RuBLuSMvHOHS0zIOgdYzrxVKhDksT3op0g1P9UO6JsfdTtbiMB4YY4G4vekdwn4+MyGVxCm84xYyfBeiIT7NPZI7X+L8nWK0ACoa25Y0aiLggX4pJt4p7DQK3+YRchOB8e+nVmXU+mkD0JtPQImnFZGyRpBzC1EoeEMut6FvsKqMP/Gt2+Lm7kJ+Ig9bra6eY6QAbLYHcrD4YoR1y4sbpWDgB0P4h6bu9n6URwfFGa7TomjJo5LuE4uP2cUhiASYubodHrihW38HrPXzT4LwMGZypnLVqRiK9yA23OP/cgS8x9IdhFg4x+JiLdcGdGJgzI74Q4x0SCBn/caC/QXj0icsv8qgKOSR3kKszmrJaiIdJ+eiSifiM1ZXxnkLarjoxF7f1+CdJNblR4IxPoV7V92aBtEzWbL3rE15kE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2202C485E8ABF4BBFF76860864A3C18@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5801d8-895f-4f4f-9389-08d70ba7f053
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:47:01.8755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8xNy8xOSAxMDoyOCBQTSwgVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIHdyb3RlOg0KPiBTZWN1
cmUgRW5jcnlwdGVkIFZpcnR1YWxpemF0aW9uIGlzIGFuIHg4Ni1zcGVjaWZpYyBmZWF0dXJlLCBz
byBpdCBzaG91bGRuJ3QNCj4gYXBwZWFyIGluIGdlbmVyaWMga2VybmVsIGNvZGUgYmVjYXVzZSBp
dCBmb3JjZXMgbm9uLXg4NiBhcmNoaXRlY3R1cmVzIHRvDQo+IGRlZmluZSB0aGUgc2V2X2FjdGl2
ZSgpIGZ1bmN0aW9uLCB3aGljaCBkb2Vzbid0IG1ha2UgYSBsb3Qgb2Ygc2Vuc2UuDQo+IA0KPiBU
byBzb2x2ZSB0aGlzIHByb2JsZW0sIGFkZCBhbiB4ODYgZWxmY29yZWhkcl9yZWFkKCkgZnVuY3Rp
b24gdG8gb3ZlcnJpZGUNCj4gdGhlIGdlbmVyaWMgd2VhayBpbXBsZW1lbnRhdGlvbi4gVG8gZG8g
dGhhdCwgaXQncyBuZWNlc3NhcnkgdG8gbWFrZQ0KPiByZWFkX2Zyb21fb2xkbWVtKCkgcHVibGlj
IHNvIHRoYXQgaXQgY2FuIGJlIHVzZWQgb3V0c2lkZSBvZiB2bWNvcmUuYy4NCj4gDQo+IEFsc28s
IHJlbW92ZSB0aGUgZXhwb3J0IGZvciBzZXZfYWN0aXZlKCkgc2luY2UgaXQncyBvbmx5IHVzZWQg
aW4gZmlsZXMgdGhhdA0KPiB3b24ndCBiZSBidWlsdCBhcyBtb2R1bGVzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIDxiYXVlcm1hbkBsaW51eC5pYm0uY29tPg0K
DQpBZGRpbmcgTGlhbmJvIGFuZCBCYW9xdWFuLCB3aG8gcmVjZW50bHkgd29ya2VkIG9uIHRoaXMs
IGZvciB0aGVpciByZXZpZXcuDQoNClRoYW5rcywNClRvbQ0KDQo+IC0tLQ0KPiAgYXJjaC94ODYv
a2VybmVsL2NyYXNoX2R1bXBfNjQuYyB8ICA1ICsrKysrDQo+ICBhcmNoL3g4Ni9tbS9tZW1fZW5j
cnlwdC5jICAgICAgIHwgIDEgLQ0KPiAgZnMvcHJvYy92bWNvcmUuYyAgICAgICAgICAgICAgICB8
ICA4ICsrKystLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2NyYXNoX2R1bXAuaCAgICAgIHwgMTQgKysr
KysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvbWVtX2VuY3J5cHQuaCAgICAgfCAgMSAtDQo+
ICA1IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NyYXNoX2R1bXBfNjQuYyBiL2FyY2gveDg2
L2tlcm5lbC9jcmFzaF9kdW1wXzY0LmMNCj4gaW5kZXggMjIzNjlkZDVkZTNiLi4wNDVlODJlODk0
NWIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcmFzaF9kdW1wXzY0LmMNCj4gKysr
IGIvYXJjaC94ODYva2VybmVsL2NyYXNoX2R1bXBfNjQuYw0KPiBAQCAtNzAsMyArNzAsOCBAQCBz
c2l6ZV90IGNvcHlfb2xkbWVtX3BhZ2VfZW5jcnlwdGVkKHVuc2lnbmVkIGxvbmcgcGZuLCBjaGFy
ICpidWYsIHNpemVfdCBjc2l6ZSwNCj4gIHsNCj4gIAlyZXR1cm4gX19jb3B5X29sZG1lbV9wYWdl
KHBmbiwgYnVmLCBjc2l6ZSwgb2Zmc2V0LCB1c2VyYnVmLCB0cnVlKTsNCj4gIH0NCj4gKw0KPiAr
c3NpemVfdCBlbGZjb3JlaGRyX3JlYWQoY2hhciAqYnVmLCBzaXplX3QgY291bnQsIHU2NCAqcHBv
cykNCj4gK3sNCj4gKwlyZXR1cm4gcmVhZF9mcm9tX29sZG1lbShidWYsIGNvdW50LCBwcG9zLCAw
LCBzZXZfYWN0aXZlKCkpOw0KPiArfQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vbWVtX2Vu
Y3J5cHQuYyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0LmMNCj4gaW5kZXggNzEzOWYyZjQzOTU1
Li5iMWU4MjM0NDEwOTMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21tL21lbV9lbmNyeXB0LmMN
Cj4gKysrIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHQuYw0KPiBAQCAtMzQ5LDcgKzM0OSw2IEBA
IGJvb2wgc2V2X2FjdGl2ZSh2b2lkKQ0KPiAgew0KPiAgCXJldHVybiBzbWVfbWVfbWFzayAmJiBz
ZXZfZW5hYmxlZDsNCj4gIH0NCj4gLUVYUE9SVF9TWU1CT0woc2V2X2FjdGl2ZSk7DQo+ICANCj4g
IC8qIE92ZXJyaWRlIGZvciBETUEgZGlyZWN0IGFsbG9jYXRpb24gY2hlY2sgLSBBUkNIX0hBU19G
T1JDRV9ETUFfVU5FTkNSWVBURUQgKi8NCj4gIGJvb2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gZGlmZiAtLWdpdCBhL2ZzL3Byb2Mvdm1jb3JlLmMgYi9mcy9w
cm9jL3ZtY29yZS5jDQo+IGluZGV4IDU3OTU3YzkxYzZkZi4uY2ExZjIwYmVkZDhjIDEwMDY0NA0K
PiAtLS0gYS9mcy9wcm9jL3ZtY29yZS5jDQo+ICsrKyBiL2ZzL3Byb2Mvdm1jb3JlLmMNCj4gQEAg
LTEwMCw5ICsxMDAsOSBAQCBzdGF0aWMgaW50IHBmbl9pc19yYW0odW5zaWduZWQgbG9uZyBwZm4p
DQo+ICB9DQo+ICANCj4gIC8qIFJlYWRzIGEgcGFnZSBmcm9tIHRoZSBvbGRtZW0gZGV2aWNlIGZy
b20gZ2l2ZW4gb2Zmc2V0LiAqLw0KPiAtc3RhdGljIHNzaXplX3QgcmVhZF9mcm9tX29sZG1lbShj
aGFyICpidWYsIHNpemVfdCBjb3VudCwNCj4gLQkJCQl1NjQgKnBwb3MsIGludCB1c2VyYnVmLA0K
PiAtCQkJCWJvb2wgZW5jcnlwdGVkKQ0KPiArc3NpemVfdCByZWFkX2Zyb21fb2xkbWVtKGNoYXIg
KmJ1Ziwgc2l6ZV90IGNvdW50LA0KPiArCQkJIHU2NCAqcHBvcywgaW50IHVzZXJidWYsDQo+ICsJ
CQkgYm9vbCBlbmNyeXB0ZWQpDQo+ICB7DQo+ICAJdW5zaWduZWQgbG9uZyBwZm4sIG9mZnNldDsN
Cj4gIAlzaXplX3QgbnJfYnl0ZXM7DQo+IEBAIC0xNjYsNyArMTY2LDcgQEAgdm9pZCBfX3dlYWsg
ZWxmY29yZWhkcl9mcmVlKHVuc2lnbmVkIGxvbmcgbG9uZyBhZGRyKQ0KPiAgICovDQo+ICBzc2l6
ZV90IF9fd2VhayBlbGZjb3JlaGRyX3JlYWQoY2hhciAqYnVmLCBzaXplX3QgY291bnQsIHU2NCAq
cHBvcykNCj4gIHsNCj4gLQlyZXR1cm4gcmVhZF9mcm9tX29sZG1lbShidWYsIGNvdW50LCBwcG9z
LCAwLCBzZXZfYWN0aXZlKCkpOw0KPiArCXJldHVybiByZWFkX2Zyb21fb2xkbWVtKGJ1ZiwgY291
bnQsIHBwb3MsIDAsIGZhbHNlKTsNCj4gIH0NCj4gIA0KPiAgLyoNCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oIGIvaW5jbHVkZS9saW51eC9jcmFzaF9kdW1wLmgNCj4g
aW5kZXggZjc3NGM1ZWI5ZTNjLi40NjY0ZmMxODcxZGUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvY3Jhc2hfZHVtcC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oDQo+
IEBAIC0xMTUsNCArMTE1LDE4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZtY29yZV9hZGRfZGV2aWNl
X2R1bXAoc3RydWN0IHZtY29yZWRkX2RhdGEgKmRhdGEpDQo+ICAJcmV0dXJuIC1FT1BOT1RTVVBQ
Ow0KPiAgfQ0KPiAgI2VuZGlmIC8qIENPTkZJR19QUk9DX1ZNQ09SRV9ERVZJQ0VfRFVNUCAqLw0K
PiArDQo+ICsjaWZkZWYgQ09ORklHX1BST0NfVk1DT1JFDQo+ICtzc2l6ZV90IHJlYWRfZnJvbV9v
bGRtZW0oY2hhciAqYnVmLCBzaXplX3QgY291bnQsDQo+ICsJCQkgdTY0ICpwcG9zLCBpbnQgdXNl
cmJ1ZiwNCj4gKwkJCSBib29sIGVuY3J5cHRlZCk7DQo+ICsjZWxzZQ0KPiArc3RhdGljIGlubGlu
ZSBzc2l6ZV90IHJlYWRfZnJvbV9vbGRtZW0oY2hhciAqYnVmLCBzaXplX3QgY291bnQsDQo+ICsJ
CQkJICAgICAgIHU2NCAqcHBvcywgaW50IHVzZXJidWYsDQo+ICsJCQkJICAgICAgIGJvb2wgZW5j
cnlwdGVkKQ0KPiArew0KPiArCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gK30NCj4gKyNlbmRpZiAv
KiBDT05GSUdfUFJPQ19WTUNPUkUgKi8NCj4gKw0KPiAgI2VuZGlmIC8qIExJTlVYX0NSQVNIRFVN
UF9IICovDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21lbV9lbmNyeXB0LmggYi9pbmNs
dWRlL2xpbnV4L21lbV9lbmNyeXB0LmgNCj4gaW5kZXggMGM1YjBmZjllYjI5Li41YzRhMThhOTFm
ODkgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWVtX2VuY3J5cHQuaA0KPiArKysgYi9p
bmNsdWRlL2xpbnV4L21lbV9lbmNyeXB0LmgNCj4gQEAgLTE5LDcgKzE5LDYgQEANCj4gICNlbHNl
CS8qICFDT05GSUdfQVJDSF9IQVNfTUVNX0VOQ1JZUFQgKi8NCj4gIA0KPiAgc3RhdGljIGlubGlu
ZSBib29sIG1lbV9lbmNyeXB0X2FjdGl2ZSh2b2lkKSB7IHJldHVybiBmYWxzZTsgfQ0KPiAtc3Rh
dGljIGlubGluZSBib29sIHNldl9hY3RpdmUodm9pZCkgeyByZXR1cm4gZmFsc2U7IH0NCj4gIA0K
PiAgI2VuZGlmCS8qIENPTkZJR19BUkNIX0hBU19NRU1fRU5DUllQVCAqLw0KPiAgDQo+IA0K
