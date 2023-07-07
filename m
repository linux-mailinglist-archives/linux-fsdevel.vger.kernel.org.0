Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0A74A91A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 04:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGGCr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 22:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGGCr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:47:27 -0400
X-Greylist: delayed 1189 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 19:47:25 PDT
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840DA19B7;
        Thu,  6 Jul 2023 19:47:25 -0700 (PDT)
Received: from w012.hihonor.com (unknown [10.68.27.189])
        by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Qxy3P3mbszYkxqx;
        Fri,  7 Jul 2023 10:27:29 +0800 (CST)
Received: from a003.hihonor.com (10.68.18.8) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 7 Jul
 2023 10:27:33 +0800
Received: from a001.hihonor.com (10.68.28.182) by a003.hihonor.com
 (10.68.18.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 7 Jul
 2023 10:27:33 +0800
Received: from a001.hihonor.com ([fe80::d540:a176:80f8:5fcf]) by
 a001.hihonor.com ([fe80::d540:a176:80f8:5fcf%8]) with mapi id 15.02.1118.021;
 Fri, 7 Jul 2023 10:27:33 +0800
From:   gaoming <gaoming20@hihonor.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     Sungjong Seo <sj1557.seo@samsung.com>,
        "open list:EXFAT FILE SYSTEM" <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        fengbaopeng <fengbaopeng@hihonor.com>,
        gaoxu <gaoxu2@hihonor.com>,
        "wangfei 00014658" <wangfei66@hihonor.com>,
        shenchen 00013118 <harry.shen@hihonor.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGV4ZmF0OiB1c2Uga3ZtYWxsb2NfYXJyYXkva3Zm?=
 =?utf-8?Q?ree_instead_of_kmalloc=5Farray/kfree?=
Thread-Topic: [PATCH] exfat: use kvmalloc_array/kvfree instead of
 kmalloc_array/kfree
Thread-Index: AdmvHl4gs76xLNH6Sd+soB17KujxsAA/YeqAABcLFgA=
Date:   Fri, 7 Jul 2023 02:27:33 +0000
Message-ID: <1e196b9bc884495fb43bbb0975d88226@hihonor.com>
References: <4cec63dcd3c0443c928800ffeec9118c@hihonor.com>
 <CAKYAXd89OqqqSPNBZjggexWCrnBD6V7rWE547iKejmeihHFAiw@mail.gmail.com>
In-Reply-To: <CAKYAXd89OqqqSPNBZjggexWCrnBD6V7rWE547iKejmeihHFAiw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.15.53]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZXhmYXRfZ2V0X2RlbnRyeV9zZXQgY291bGQgYmUgY2FsbGVkIGFmdGVyIHRoZSB1LWRpc2sgaGF2
ZSBiZWVuIGluc2VydGVkLCANCnRocm91Z2ggZXhmYXRfZmluZCwgX19leGZhdF93cml0ZV9pbm9k
ZSBmdW5jdGlvbnMuDQpUaGlzIGNvdWxkIGhhcHBlbiBhdCBhbnkgdGltZSwgd2hpY2ggc2NlbmFy
aW8gY2FuIG5vdCBndWFyYW50ZWUgdGhlIA0KY29udGludWl0eSBvZiBwaHlzaWNhbCBtZW1vcnku
DQpUaGlzIGJ1Z2ZpeCB3aWxsIGVuaGFuY2UgdGhlIHJvYnVzdG5lc3Mgb2YgZXhmYXQuDQoNClRo
YW5rcy4NCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogTmFtamFlIEplb24gPGxp
bmtpbmplb25Aa2VybmVsLm9yZz4gDQrlj5HpgIHml7bpl7Q6IDIwMjPlubQ35pyIN+aXpSA3OjEw
DQrmlLbku7bkuro6IGdhb21pbmcgPGdhb21pbmcyMEBoaWhvbm9yLmNvbT4NCuaKhOmAgTogU3Vu
Z2pvbmcgU2VvIDxzajE1NTcuc2VvQHNhbXN1bmcuY29tPjsgb3BlbiBsaXN0OkVYRkFUIEZJTEUg
U1lTVEVNIDxsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdCA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz47IGZlbmdiYW9wZW5nIDxmZW5nYmFvcGVuZ0BoaWhvbm9y
LmNvbT47IGdhb3h1IDxnYW94dTJAaGlob25vci5jb20+OyB3YW5nZmVpIDAwMDE0NjU4IDx3YW5n
ZmVpNjZAaGlob25vci5jb20+OyBzaGVuY2hlbiAwMDAxMzExOCA8aGFycnkuc2hlbkBoaWhvbm9y
LmNvbT4NCuS4u+mimDogUmU6IFtQQVRDSF0gZXhmYXQ6IHVzZSBrdm1hbGxvY19hcnJheS9rdmZy
ZWUgaW5zdGVhZCBvZiBrbWFsbG9jX2FycmF5L2tmcmVlDQoNCjIwMjMtMDctMDUgMTg6MTUgR01U
KzA5OjAwLCBnYW9taW5nIDxnYW9taW5nMjBAaGlob25vci5jb20+Og0KPiBUaGUgY2FsbCBzdGFj
ayBzaG93biBiZWxvdyBpcyBhIHNjZW5hcmlvIGluIHRoZSBMaW51eCA0LjE5IGtlcm5lbC4NCj4g
QWxsb2NhdGluZyBtZW1vcnkgZmFpbGVkIHdoZXJlIGV4ZmF0IGZzIHVzZSBrbWFsbG9jX2FycmF5
IGR1ZSB0byANCj4gc3lzdGVtIG1lbW9yeSBmcmFnbWVudGF0aW9uLCB3aGlsZSB0aGUgdS1kaXNr
IHdhcyBpbnNlcnRlZCB3aXRob3V0IA0KPiByZWNvZ25pdGlvbi4NCj4gRGV2aWNlcyBzdWNoIGFz
IHUtZGlzayB1c2luZyB0aGUgZXhmYXQgZmlsZSBzeXN0ZW0gYXJlIHBsdWdnYWJsZSBhbmQgDQo+
IG1heSBiZSBpbnNlcnQgaW50byB0aGUgc3lzdGVtIGF0IGFueSB0aW1lLg0KPiBIb3dldmVyLCBs
b25nLXRlcm0gcnVubmluZyBzeXN0ZW1zIGNhbm5vdCBndWFyYW50ZWUgdGhlIGNvbnRpbnVpdHkg
b2YgDQo+IHBoeXNpY2FsIG1lbW9yeS4gVGhlcmVmb3JlLCBpdCdzIG5lY2Vzc2FyeSB0byBhZGRy
ZXNzIHRoaXMgaXNzdWUuDQo+DQo+IEJpbmRlcjoyNjMyXzY6IHBhZ2UgYWxsb2NhdGlvbiBmYWls
dXJlOiBvcmRlcjo0LCANCj4gbW9kZToweDYwNDBjMChHRlBfS0VSTkVMfF9fR0ZQX0NPTVApLCBu
b2RlbWFzaz0obnVsbCkgQ2FsbCB0cmFjZToNCj4gWzI0MjE3OC4wOTc1ODJdICBkdW1wX2JhY2t0
cmFjZSsweDAvMHg0IFsyNDIxNzguMDk3NTg5XSAgDQo+IGR1bXBfc3RhY2srMHhmNC8weDEzNCBb
MjQyMTc4LjA5NzU5OF0gIHdhcm5fYWxsb2MrMHhkOC8weDE0NCANCj4gWzI0MjE3OC4wOTc2MDNd
ICBfX2FsbG9jX3BhZ2VzX25vZGVtYXNrKzB4MTM2NC8weDEzODQNCj4gWzI0MjE3OC4wOTc2MDhd
ICBrbWFsbG9jX29yZGVyKzB4MmMvMHg1MTAgWzI0MjE3OC4wOTc2MTJdICANCj4ga21hbGxvY19v
cmRlcl90cmFjZSsweDQwLzB4MTZjIFsyNDIxNzguMDk3NjE4XSAgX19rbWFsbG9jKzB4MzYwLzB4
NDA4IA0KPiBbMjQyMTc4LjA5NzYyNF0gIGxvYWRfYWxsb2NfYml0bWFwKzB4MTYwLzB4Mjg0IFsy
NDIxNzguMDk3NjI4XSAgDQo+IGV4ZmF0X2ZpbGxfc3VwZXIrMHhhM2MvMHhlN2MgWzI0MjE3OC4w
OTc2MzVdICBtb3VudF9iZGV2KzB4MmU4LzB4M2EwIA0KPiBbMjQyMTc4LjA5NzYzOF0gIGV4ZmF0
X2ZzX21vdW50KzB4NDAvMHg1MCBbMjQyMTc4LjA5NzY0M10gIA0KPiBtb3VudF9mcysweDEzOC8w
eDJlOCBbMjQyMTc4LjA5NzY0OV0gIHZmc19rZXJuX21vdW50KzB4OTAvMHgyNzAgDQo+IFsyNDIx
NzguMDk3NjU1XSAgZG9fbW91bnQrMHg3OTgvMHgxNzNjIFsyNDIxNzguMDk3NjU5XSAgDQo+IGtz
eXNfbW91bnQrMHgxMTQvMHgxYWMgWzI0MjE3OC4wOTc2NjVdICBfX2FybTY0X3N5c19tb3VudCsw
eDI0LzB4MzQgDQo+IFsyNDIxNzguMDk3NjcxXSAgZWwwX3N2Y19jb21tb24rMHhiOC8weDFiOCBb
MjQyMTc4LjA5NzY3Nl0gIA0KPiBlbDBfc3ZjX2hhbmRsZXIrMHg3NC8weDkwIFsyNDIxNzguMDk3
NjgxXSAgZWwwX3N2YysweDgvMHgzNDANCj4NCj4gQnkgYW5hbHl6aW5nIHRoZSBleGZhdCBjb2Rl
LHdlIGZvdW5kIHRoYXQgY29udGludW91cyBwaHlzaWNhbCBtZW1vcnkgDQo+IGlzIG5vdCByZXF1
aXJlZCBoZXJlLHNvIGt2bWFsbG9jX2FycmF5IGlzIHVzZWQgY2FuIHNvbHZlIHRoaXMgcHJvYmxl
bS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogZ2FvbWluZyA8Z2FvbWluZzIwQGhpaG9ub3IuY29tPg0K
PiAtLS0NCj4gIGZzL2V4ZmF0L2JhbGxvYy5jIHwgNCArKy0tDQo+ICBmcy9leGZhdC9kaXIuYyAg
ICB8IDQgKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9mcy9leGZhdC9iYWxsb2MuYyBiL2ZzL2V4ZmF0L2Jh
bGxvYy5jIGluZGV4IA0KPiA5ZjQyZjI1ZmFiOTIuLmExODM1NThjYjdhMCAxMDA2NDQNCj4gLS0t
IGEvZnMvZXhmYXQvYmFsbG9jLmMNCj4gKysrIGIvZnMvZXhmYXQvYmFsbG9jLmMNCj4gQEAgLTY5
LDcgKzY5LDcgQEAgc3RhdGljIGludCBleGZhdF9hbGxvY2F0ZV9iaXRtYXAoc3RydWN0IHN1cGVy
X2Jsb2NrICpzYiwNCj4gIAl9DQo+ICAJc2JpLT5tYXBfc2VjdG9ycyA9ICgobmVlZF9tYXBfc2l6
ZSAtIDEpID4+DQo+ICAJCQkoc2ItPnNfYmxvY2tzaXplX2JpdHMpKSArIDE7DQo+IC0Jc2JpLT52
b2xfYW1hcCA9IGttYWxsb2NfYXJyYXkoc2JpLT5tYXBfc2VjdG9ycywNCj4gKwlzYmktPnZvbF9h
bWFwID0ga3ZtYWxsb2NfYXJyYXkoc2JpLT5tYXBfc2VjdG9ycywNCj4gIAkJCQlzaXplb2Yoc3Ry
dWN0IGJ1ZmZlcl9oZWFkICopLCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIXNiaS0+dm9sX2FtYXAp
DQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiBAQCAtODQsNyArODQsNyBAQCBzdGF0aWMgaW50IGV4
ZmF0X2FsbG9jYXRlX2JpdG1hcChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPiAgCQkJd2hpbGUg
KGogPCBpKQ0KPiAgCQkJCWJyZWxzZShzYmktPnZvbF9hbWFwW2orK10pOw0KPg0KPiAtCQkJa2Zy
ZWUoc2JpLT52b2xfYW1hcCk7DQo+ICsJCQlrdmZyZWUoc2JpLT52b2xfYW1hcCk7DQo+ICAJCQlz
YmktPnZvbF9hbWFwID0gTlVMTDsNCj4gIAkJCXJldHVybiAtRUlPOw0KPiAgCQl9DQo+IGRpZmYg
LS1naXQgYS9mcy9leGZhdC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jIGluZGV4IA0KPiA5NTc1NzQx
ODBhNWUuLjVjYmI3OGQwYTJhMiAxMDA2NDQNCj4gLS0tIGEvZnMvZXhmYXQvZGlyLmMNCj4gKysr
IGIvZnMvZXhmYXQvZGlyLmMNCj4gQEAgLTY0OSw3ICs2NDksNyBAQCBpbnQgZXhmYXRfcHV0X2Rl
bnRyeV9zZXQoc3RydWN0IA0KPiBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLCBpbnQgc3luYykN
Cj4gIAkJCWJyZWxzZShlcy0+YmhbaV0pOw0KPg0KPiAgCWlmIChJU19EWU5BTUlDX0VTKGVzKSkN
Cj4gLQkJa2ZyZWUoZXMtPmJoKTsNCj4gKwkJa3ZmcmVlKGVzLT5iaCk7DQo+DQo+ICAJcmV0dXJu
IGVycjsNCj4gIH0NCj4gQEAgLTg4OCw3ICs4ODgsNyBAQCBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9z
ZXQoc3RydWN0IA0KPiBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KPg0KPiAgCW51bV9iaCA9
IEVYRkFUX0JfVE9fQkxLX1JPVU5EX1VQKG9mZiArIG51bV9lbnRyaWVzICogREVOVFJZX1NJWkUs
IHNiKTsNCj4gIAlpZiAobnVtX2JoID4gQVJSQVlfU0laRShlcy0+X19iaCkpIHsNCj4gLQkJZXMt
PmJoID0ga21hbGxvY19hcnJheShudW1fYmgsIHNpemVvZigqZXMtPmJoKSwgR0ZQX0tFUk5FTCk7
DQo+ICsJCWVzLT5iaCA9IGt2bWFsbG9jX2FycmF5KG51bV9iaCwgc2l6ZW9mKCplcy0+YmgpLCBH
RlBfS0VSTkVMKTsNCkNvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlIHdoeSB5b3UgY2hhbmdlIHRo
aXMgdG8ga3ZtYWxsb2NfYXJyYXkgYWxzbz8NCg0KVGhhbmtzLg0KPiAgCQlpZiAoIWVzLT5iaCkg
ew0KPiAgCQkJYnJlbHNlKGJoKTsNCj4gIAkJCXJldHVybiAtRU5PTUVNOw0KPiAtLQ0KPiAyLjE3
LjENCj4NCj4NCg==
