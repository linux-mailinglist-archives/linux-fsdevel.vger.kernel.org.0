Return-Path: <linux-fsdevel+bounces-50451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB0ACC684
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EBD171AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5723185D;
	Tue,  3 Jun 2025 12:26:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422F22F754;
	Tue,  3 Jun 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953568; cv=none; b=gN5zJWW2aT+rwmHLYBeD8LbMXAWf3P/FUwaps5kkKoWH9SsmKDHcMEBk5EDrA2Nj7J2GqwT5Y8nksD0SalpQoKryk1zDmZ9lZ9vU/ti2YM8enpBAj7LUh+h2aW8tSz9g3nQEXCPFeo1t7NW4Ubh+C8T0ilAJNnYwYajUJx7W0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953568; c=relaxed/simple;
	bh=9s3xEy4qyNKLwVMXOCn9v6rukdJc5v7PniCAdmE4YKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YL0FyMPzzIe0gUXRacw2lo1SzejfOh0tJ96UPnneR1SFX/0XTPR7IsdJPy8YLraiOkcUHG6lq5F8Qm++R4qnxfCSmckwaSjLplAmFUqqiqVKTcdMxHf/MCBHVcZahsvC5WY5QTKMMiDfz69sOitd53hdf0wLsb5/SK2klggshq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bBVHk1MspzYl3PS;
	Tue,  3 Jun 2025 20:23:46 +0800 (CST)
Received: from a012.hihonor.com (10.68.23.251) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 20:26:03 +0800
Received: from a010.hihonor.com (10.68.16.52) by a012.hihonor.com
 (10.68.23.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 20:26:02 +0800
Received: from a010.hihonor.com ([fe80::7127:3946:32c7:6e]) by
 a010.hihonor.com ([fe80::7127:3946:32c7:6e%14]) with mapi id 15.02.1544.011;
 Tue, 3 Jun 2025 20:26:02 +0800
From: wangtao <tao.wangtao@honor.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
	"sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "amir73il@gmail.com"
	<amir73il@gmail.com>
CC: "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"Brian.Starkey@arm.com" <Brian.Starkey@arm.com>, "jstultz@google.com"
	<jstultz@google.com>, "tjmercier@google.com" <tjmercier@google.com>,
	"jack@suse.cz" <jack@suse.cz>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org"
	<linaro-mm-sig@lists.linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"wangbintian(BintianWang)" <bintian.wang@honor.com>, yipengxiang
	<yipengxiang@honor.com>, liulu 00013167 <liulu.liu@honor.com>, "hanfeng
 00012985" <feng.han@honor.com>
Subject: RE: [PATCH v4 2/4] dmabuf: Implement copy_file_range callback for
 dmabuf direct I/O prep
Thread-Topic: [PATCH v4 2/4] dmabuf: Implement copy_file_range callback for
 dmabuf direct I/O prep
Thread-Index: AQHb1G1oLKp2r/EedEGXp6nhARLCSbPwuW0AgAChKbA=
Date: Tue, 3 Jun 2025 12:26:02 +0000
Message-ID: <54fa25e19d834d06b758885d00f4fc63@honor.com>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <20250603095245.17478-3-tao.wangtao@honor.com>
 <ec85db1b-d536-4954-bad9-d5b1f3388492@amd.com>
In-Reply-To: <ec85db1b-d536-4954-bad9-d5b1f3388492@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDMsIDIw
MjUgNjo0MiBQTQ0KPiBUbzogd2FuZ3RhbyA8dGFvLndhbmd0YW9AaG9ub3IuY29tPjsgc3VtaXQu
c2Vtd2FsQGxpbmFyby5vcmc7DQo+IGtyYXhlbEByZWRoYXQuY29tOyB2aXZlay5rYXNpcmVkZHlA
aW50ZWwuY29tOyB2aXJvQHplbml2LmxpbnV4Lm9yZy51azsNCj4gYnJhdW5lckBrZXJuZWwub3Jn
OyBodWdoZEBnb29nbGUuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBhbWlyNzNp
bEBnbWFpbC5jb20NCj4gQ2M6IGJlbmphbWluLmdhaWduYXJkQGNvbGxhYm9yYS5jb207IEJyaWFu
LlN0YXJrZXlAYXJtLmNvbTsNCj4ganN0dWx0ekBnb29nbGUuY29tOyB0am1lcmNpZXJAZ29vZ2xl
LmNvbTsgamFja0BzdXNlLmN6Ow0KPiBiYW9saW4ud2FuZ0BsaW51eC5hbGliYWJhLmNvbTsgbGlu
dXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBkcmktDQo+IGRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBt
bUBrdmFjay5vcmc7IHdhbmdiaW50aWFuKEJpbnRpYW5XYW5nKSA8YmludGlhbi53YW5nQGhvbm9y
LmNvbT47DQo+IHlpcGVuZ3hpYW5nIDx5aXBlbmd4aWFuZ0Bob25vci5jb20+OyBsaXVsdSAwMDAx
MzE2Nw0KPiA8bGl1bHUubGl1QGhvbm9yLmNvbT47IGhhbmZlbmcgMDAwMTI5ODUgPGZlbmcuaGFu
QGhvbm9yLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyLzRdIGRtYWJ1ZjogSW1wbGVt
ZW50IGNvcHlfZmlsZV9yYW5nZSBjYWxsYmFjayBmb3INCj4gZG1hYnVmIGRpcmVjdCBJL08gcHJl
cA0KPiANCj4gDQo+IA0KPiBPbiA2LzMvMjUgMTE6NTIsIHdhbmd0YW8gd3JvdGU6DQo+ID4gRmly
c3QgZGV0ZXJtaW5lIGlmIGRtYWJ1ZiByZWFkcyBmcm9tIG9yIHdyaXRlcyB0byB0aGUgZmlsZS4N
Cj4gPiBUaGVuIGNhbGwgZXhwb3J0ZXIncyByd19maWxlIGNhbGxiYWNrIGZ1bmN0aW9uLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogd2FuZ3RhbyA8dGFvLndhbmd0YW9AaG9ub3IuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jIHwgMzIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9kbWEtYnVmLmggICB8IDE2ICsr
KysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYyBiL2RyaXZlcnMv
ZG1hLWJ1Zi9kbWEtYnVmLmMNCj4gPiBpbmRleCA1YmFhODNiODU1MTUuLmZjOWJmNTRjOTIxYSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jDQo+ID4gKysrIGIvZHJp
dmVycy9kbWEtYnVmL2RtYS1idWYuYw0KPiA+IEBAIC01MjMsNyArNTIzLDM4IEBAIHN0YXRpYyB2
b2lkIGRtYV9idWZfc2hvd19mZGluZm8oc3RydWN0IHNlcV9maWxlDQo+ICptLCBzdHJ1Y3QgZmls
ZSAqZmlsZSkNCj4gPiAgCXNwaW5fdW5sb2NrKCZkbWFidWYtPm5hbWVfbG9jayk7DQo+ID4gIH0N
Cj4gPg0KPiA+ICtzdGF0aWMgc3NpemVfdCBkbWFfYnVmX3J3X2ZpbGUoc3RydWN0IGRtYV9idWYg
KmRtYWJ1ZiwgbG9mZl90IG15X3BvcywNCj4gPiArCXN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qg
cG9zLCBzaXplX3QgY291bnQsIGJvb2wgaXNfd3JpdGUpIHsNCj4gPiArCWlmICghZG1hYnVmLT5v
cHMtPnJ3X2ZpbGUpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJaWYgKG15
X3BvcyA+PSBkbWFidWYtPnNpemUpDQo+ID4gKwkJY291bnQgPSAwOw0KPiA+ICsJZWxzZQ0KPiA+
ICsJCWNvdW50ID0gbWluX3Qoc2l6ZV90LCBjb3VudCwgZG1hYnVmLT5zaXplIC0gbXlfcG9zKTsN
Cj4gPiArCWlmICghY291bnQpDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IGRtYWJ1Zi0+b3BzLT5yd19maWxlKGRtYWJ1ZiwgbXlfcG9zLCBmaWxlLCBwb3MsIGNvdW50LA0K
PiA+ICtpc193cml0ZSk7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBzc2l6ZV90IGRtYV9idWZfY29w
eV9maWxlX3JhbmdlKHN0cnVjdCBmaWxlICpmaWxlX2luLCBsb2ZmX3QgcG9zX2luLA0KPiA+ICsJ
c3RydWN0IGZpbGUgKmZpbGVfb3V0LCBsb2ZmX3QgcG9zX291dCwNCj4gPiArCXNpemVfdCBjb3Vu
dCwgdW5zaWduZWQgaW50IGZsYWdzKQ0KPiA+ICt7DQo+ID4gKwlpZiAoaXNfZG1hX2J1Zl9maWxl
KGZpbGVfaW4pICYmIGZpbGVfb3V0LT5mX29wLT53cml0ZV9pdGVyKQ0KPiA+ICsJCXJldHVybiBk
bWFfYnVmX3J3X2ZpbGUoZmlsZV9pbi0+cHJpdmF0ZV9kYXRhLCBwb3NfaW4sDQo+ID4gKwkJCQlm
aWxlX291dCwgcG9zX291dCwgY291bnQsIHRydWUpOw0KPiA+ICsJZWxzZSBpZiAoaXNfZG1hX2J1
Zl9maWxlKGZpbGVfb3V0KSAmJiBmaWxlX2luLT5mX29wLT5yZWFkX2l0ZXIpDQo+ID4gKwkJcmV0
dXJuIGRtYV9idWZfcndfZmlsZShmaWxlX291dC0+cHJpdmF0ZV9kYXRhLCBwb3Nfb3V0LA0KPiA+
ICsJCQkJZmlsZV9pbiwgcG9zX2luLCBjb3VudCwgZmFsc2UpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IGZpbGVfb3BlcmF0aW9ucyBkbWFfYnVmX2ZvcHMgPSB7DQo+ID4gKwkuZm9wX2ZsYWdzID0gRk9Q
X01FTU9SWV9GSUxFLA0KPiA+ICAJLnJlbGVhc2UJPSBkbWFfYnVmX2ZpbGVfcmVsZWFzZSwNCj4g
PiAgCS5tbWFwCQk9IGRtYV9idWZfbW1hcF9pbnRlcm5hbCwNCj4gPiAgCS5sbHNlZWsJCT0gZG1h
X2J1Zl9sbHNlZWssDQo+ID4gQEAgLTUzMSw2ICs1NjIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGZpbGVfb3BlcmF0aW9ucyBkbWFfYnVmX2ZvcHMgPSB7DQo+ID4gIAkudW5sb2NrZWRfaW9jdGwJ
PSBkbWFfYnVmX2lvY3RsLA0KPiA+ICAJLmNvbXBhdF9pb2N0bAk9IGNvbXBhdF9wdHJfaW9jdGws
DQo+ID4gIAkuc2hvd19mZGluZm8JPSBkbWFfYnVmX3Nob3dfZmRpbmZvLA0KPiA+ICsJLmNvcHlf
ZmlsZV9yYW5nZSA9IGRtYV9idWZfY29weV9maWxlX3JhbmdlLA0KPiA+ICB9Ow0KPiA+DQo+ID4g
IC8qDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5oIGIvaW5jbHVkZS9s
aW51eC9kbWEtYnVmLmggaW5kZXgNCj4gPiAzNjIxNmQyOGQ4YmQuLmQzNjM2ZTk4NTM5OSAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
bGludXgvZG1hLWJ1Zi5oDQo+ID4gQEAgLTIyLDYgKzIyLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxp
bnV4L2ZzLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9kbWEtZmVuY2UuaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L3dhaXQuaD4NCj4gPiArI2luY2x1ZGUgPHVhcGkvbGludXgvZG1hLWJ1Zi5oPg0K
PiA+DQo+ID4gIHN0cnVjdCBkZXZpY2U7DQo+ID4gIHN0cnVjdCBkbWFfYnVmOw0KPiA+IEBAIC0y
ODUsNiArMjg2LDIxIEBAIHN0cnVjdCBkbWFfYnVmX29wcyB7DQo+ID4NCj4gPiAgCWludCAoKnZt
YXApKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBpb3N5c19tYXAgKm1hcCk7DQo+ID4g
IAl2b2lkICgqdnVubWFwKShzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgaW9zeXNfbWFw
ICptYXApOw0KPiA+ICsNCj4gPiArCS8qKg0KPiA+ICsJICogQHJ3X2ZpbGU6DQo+ID4gKwkgKg0K
PiA+ICsJICogSWYgYW4gRXhwb3J0ZXIgbmVlZHMgdG8gc3VwcG9ydCBEaXJlY3QgSS9PIGZpbGUg
b3BlcmF0aW9ucywgaXQgY2FuDQo+ID4gKwkgKiBpbXBsZW1lbnQgdGhpcyBvcHRpb25hbCBjYWxs
YmFjay4gVGhlIGV4cG9ydGVyIG11c3QgdmVyaWZ5IHRoYXQgbm8NCj4gPiArCSAqIG90aGVyIG9i
amVjdHMgaG9sZCB0aGUgc2dfdGFibGUsIGVuc3VyZSBleGNsdXNpdmUgYWNjZXNzIHRvIHRoZQ0K
PiA+ICsJICogZG1hYnVmJ3Mgc2dfdGFibGUsIGFuZCBvbmx5IHRoZW4gcHJvY2VlZCB3aXRoIHRo
ZSBJL08gb3BlcmF0aW9uLg0KPiANCj4gRXhwbGFpbiB3aHkgYW5kIG5vdCB3aGF0LiBFLmcuIHNv
bWV0aGluZyBsaWtlICJBbGxvd3MgZGlyZWN0IEkvTyBiZXR3ZWVuDQo+IHRoaXMgRE1BLWJ1ZiBh
bmQgdGhlIGZpbGUiLg0KPiANCj4gQ29tcGxldGVseSBkcm9wIG1lbnRpb25pbmcgdGhlIHNnX3Rh
YmxlLCB0aGF0IGlzIGlycmVsZXZhbnQuIEV4Y2x1c2l2ZSBhY2Nlc3MNCj4gZGVwZW5kcyBvbiBo
b3cgdGhlIGV4cG9ydGVyIGltcGxlbWVudHMgdGhlIHdob2xlIHRoaW5nLg0KPiANCldpbGwgZml4
IHRoaXMgc2hvcnRseS4NCg0KUmVnYXJkcywNCldhbmd0YW8uDQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4gDQo+ID4gKwkgKg0KPiA+ICsJICogUmV0dXJuczoNCj4gPiArCSAqDQo+ID4gKwkg
KiAwIG9uIHN1Y2Nlc3Mgb3IgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUuDQo+ID4g
KwkgKi8NCj4gPiArCXNzaXplX3QgKCpyd19maWxlKShzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLCBs
b2ZmX3QgbXlfcG9zLA0KPiA+ICsJCXN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3QgcG9zLCBzaXpl
X3QgY291bnQsIGJvb2wgaXNfd3JpdGUpOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIC8qKg0KDQo=

