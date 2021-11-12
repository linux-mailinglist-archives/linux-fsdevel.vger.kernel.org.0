Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3254244E6D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 13:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhKLM7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 07:59:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4091 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhKLM7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:59:43 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HrJPl25CZz67NsT;
        Fri, 12 Nov 2021 20:51:55 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 13:56:50 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.015;
 Fri, 12 Nov 2021 13:56:50 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Ajay Garg <ajaygargnsit@gmail.com>
CC:     "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>, "corbet@lwn.net" <corbet@lwn.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH 4/5] shmem: Avoid segfault in
 shmem_read_mapping_page_gfp()
Thread-Topic: [RFC][PATCH 4/5] shmem: Avoid segfault in
 shmem_read_mapping_page_gfp()
Thread-Index: AQHX18MROltj/rJe+kKE1cDtluXUoav/yFuAgAARW5A=
Date:   Fri, 12 Nov 2021 12:56:50 +0000
Message-ID: <5b4ea24c3c104e74a2cae4cf0b90eaa3@huawei.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
 <20211112124411.1948809-5-roberto.sassu@huawei.com>
 <CAHP4M8V9i7PZvPKwzWRo54u0xjrGwhtPPsHCjxwy9SLQM7HbEg@mail.gmail.com>
In-Reply-To: <CAHP4M8V9i7PZvPKwzWRo54u0xjrGwhtPPsHCjxwy9SLQM7HbEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.63.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBBamF5IEdhcmcgW21haWx0bzphamF5Z2FyZ25zaXRAZ21haWwuY29tXQ0KPiBTZW50
OiBGcmlkYXksIE5vdmVtYmVyIDEyLCAyMDIxIDE6NTQgUE0NCj4gSGkgUm9iZXJ0by4NCj4gDQo+
IElkZW50aWNhbCBwYXRjaCBoYXMgYmVlbiBmbG9hdGVkIGVhcmxpZXIgdmlhIDoNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtDQo+IG1tL0NBTVpmR3RVcDZka1Q0T1d6TGhMOHdocU5u
WEFiZlZ3NWM2QVFvZ0h6WTNiYk1fazJRd0BtYWlsLg0KPiBnbWFpbC5jb20vVC8jbTIxODlkMTM1
YjkyOTNkZTliNGExMTM2MmYwMTc5YzE3YjI1NGQ1YWINCg0KSGkgQWpheQ0KDQp0aGFua3MsIEkg
d2FzIG5vdCBhd2FyZS4NCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxk
b3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIFpob25nIFJv
bmdodWENCg0KPiBUaGFua3MgYW5kIFJlZ2FyZHMsDQo+IEFqYXkNCj4gDQo+IE9uIEZyaSwgTm92
IDEyLCAyMDIxIGF0IDY6MTUgUE0gUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWku
Y29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IENoZWNrIHRoZSBod3BvaXNvbiBwYWdlIGZsYWcgb25s
eSBpZiB0aGUgcGFnZSBpcyB2YWxpZCBpbg0KPiA+IHNobWVtX3JlYWRfbWFwcGluZ19wYWdlX2dm
cCgpLiBUaGUgUGFnZUhXUG9pc29uKCkgbWFjcm8gdHJpZXMgdG8NCj4gYWNjZXNzDQo+ID4gdGhl
IHBhZ2UgZmxhZ3MgYW5kIGNhbm5vdCB3b3JrIG9uIGFuIGVycm9yIHBvaW50ZXIuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+
DQo+ID4gLS0tDQo+ID4gIG1tL3NobWVtLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL3No
bWVtLmMgYi9tbS9zaG1lbS5jDQo+ID4gaW5kZXggMjNjOTFhOGJlYjc4Li40Mjc4NjNjYmYwZGMg
MTAwNjQ0DQo+ID4gLS0tIGEvbW0vc2htZW0uYw0KPiA+ICsrKyBiL21tL3NobWVtLmMNCj4gPiBA
QCAtNDIyMiw3ICs0MjIyLDcgQEAgc3RydWN0IHBhZ2UNCj4gKnNobWVtX3JlYWRfbWFwcGluZ19w
YWdlX2dmcChzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4gPiAgICAgICAgIGVsc2UN
Cj4gPiAgICAgICAgICAgICAgICAgdW5sb2NrX3BhZ2UocGFnZSk7DQo+ID4NCj4gPiAtICAgICAg
IGlmIChQYWdlSFdQb2lzb24ocGFnZSkpDQo+ID4gKyAgICAgICBpZiAoIUlTX0VSUihwYWdlKSAm
JiBQYWdlSFdQb2lzb24ocGFnZSkpDQo+ID4gICAgICAgICAgICAgICAgIHBhZ2UgPSBFUlJfUFRS
KC1FSU8pOw0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gcGFnZTsNCj4gPiAtLQ0KPiA+IDIuMzIu
MA0KPiA+DQo=
