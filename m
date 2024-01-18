Return-Path: <linux-fsdevel+bounces-8217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC3D831139
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 03:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297791F2205B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 02:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51024688;
	Thu, 18 Jan 2024 02:04:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6F1FAF;
	Thu, 18 Jan 2024 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543478; cv=none; b=ZCZCCXDXi4O8uxWUnV4Dm9p5jPgMeE5FM/Mad6ST0NUlIyKe2CScOE1NlWXdBr4nWULtGajNRP1DZWDgIjV6EApNiZaqIHVDj8XzCnC4MRxhCVcSWWdQJFrP2DApq/5GwYCVaZhCp1XjJGZtKoq5H9M2pQGwphbHGwsL/cDIA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543478; c=relaxed/simple;
	bh=tHPwGIdFqi94LdAZOqJ7np7r/3FQCZ+fdVeRXwSazeE=;
	h=Received:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:x-sender-location:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-DNSRBL:
	 X-SPAM-SOURCE-CHECK:X-MAIL; b=E18hjj8g8o4ZBBrpNbdeyz10s0kmZTf8KwOfS9Ery9/x8eUYSnGvVNPL50x2lVa5p097WCa6+VdwApcehwbvnpLevusfXbnSIrYf0WvFMX5MG2qPwpP+WNRHJajMqJ1mEAL78QxIwu1MDoA93BMVq/nYKmCGxr3a6KUDfsLkFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40I235rx063437;
	Thu, 18 Jan 2024 10:03:06 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id D29152004BB7;
	Thu, 18 Jan 2024 10:07:35 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 18 Jan 2024 10:03:04 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Thu, 18 Jan 2024 10:03:04 +0800
From: Huyadi <hu.yadi@h3c.com>
To: =?utf-8?B?J01pY2thw6tsIFNhbGHDvG4n?= <mic@digikod.net>,
        "'Christian
 Brauner'" <brauner@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "514118380@qq.com" <514118380@qq.com>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIHNlbGZ0ZXN0cy9tb3ZlX21vdW50X3NldF9n?=
 =?utf-8?Q?roup:Make_tests_build_with_old_libc?=
Thread-Topic: [PATCH v4] selftests/move_mount_set_group:Make tests build with
 old libc
Thread-Index: AQHaRII9d44IpKHVmkiSX1xdCq/Vx7DUFK8AgArGFwA=
Date: Thu, 18 Jan 2024 02:03:04 +0000
Message-ID: <b7872e67938f4022ad0537bc617403ed@h3c.com>
References: <20240111113229.10820-1-hu.yadi@h3c.com>
 <20240111.mee0ohZie5he@digikod.net>
In-Reply-To: <20240111.mee0ohZie5he@digikod.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 40I235rx063437

DQo+T24gVGh1LCBKYW4gMTEsIDIwMjQgYXQgMDc6MzI6MjlQTSArMDgwMCwgSHUgWWFkaSB3cm90
ZToNCj4+IEZyb206ICJIdS5ZYWRpIiA8aHUueWFkaUBoM2MuY29tPg0KPj4gDQo+PiBSZXBsYWNl
IFNZU188c3lzY2FsbD4gd2l0aCBfX05SXzxzeXNjYWxsPi4gIFVzaW5nIHRoZSBfX05SXzxzeXNj
YWxsPiANCj4+IG5vdGF0aW9uLCBwcm92aWRlZCBieSBVQVBJLCBpcyB1c2VmdWwgdG8gYnVpbGQg
dGVzdHMgb24gc3lzdGVtcyANCj4+IHdpdGhvdXQgdGhlIFNZU188c3lzY2FsbD4gZGVmaW5pdGlv
bnMuDQo+PiANCj4+IFJlcGxhY2UgU1lTX21vdmVfbW91bnQgd2l0aCBfX05SX21vdmVfbW91bnQN
Cj4+IA0KPj4gU2ltaWxhciBjaGFuZ2VzOiBjb21taXQgODcxMjllZjEzNjAzICgic2VsZnRlc3Rz
L2xhbmRsb2NrOiBNYWtlIHRlc3RzIA0KPj4gYnVpbGQgd2l0aCBvbGQgbGliYyIpDQo+PiANCj4+
IEFja2VkLWJ5OiBNaWNrYcOrbCBTYWxhw7xuIDxtaWNAZGlnaWtvZC5uZXQ+DQo+DQo+U29ycnks
IGl0IHNob3VsZCBoYXZlIGJlZW4gUmV2aWV3ZWQtYnk6IE1pY2thw6tsIFNhbGHDvG4gPG1pY0Bk
aWdpa29kLm5ldD4NCj4NCj5BbHNvLCB0aGlzIGlzIG1haW50YWluZWQgYnkgdGhlIFZGUyBtYWlu
dGFpbmVycy4gSSBDQ2VkIHRocmVlIHJlbGV2YW50IGFkZHJlc3Nlcy4NCg0KDQpBbnkgcHJvZ2Vz
c3MgYWJvdXQgdGhpcyBwYXRjaCA/IA0KVGhhbmtzDQoNCj4NCj4+IFNpZ25lZC1vZmYtYnk6IEh1
LllhZGkgPGh1LnlhZGlAaDNjLmNvbT4NCj4+IFN1Z2dlc3RlZC1ieTogSmlhbyA8amlhb3h1cG9A
aDNjLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBCZXJsaW4gPGJlcmxpbkBoM2MuY29tPg0KPj4gLS0t
DQo+PiBDaGFuZ2VzIHY0IC0+IHYzOg0KPj4gIC0gQWRqdXN0IGNvbW1lbnRzIGZvciBjb25zaXN0
ZW50DQo+PiAgLSBBZGQgQWNrZWQtYnkNCj4+IENoYW5nZXMgdjIgLT4gdjM6DQo+PiAgLSBBZGp1
c3QgY29tbWVudHMNCj4+IENoYW5nZXMgdjEgLT4gdjI6DQo+PiAgLSBGaXggbWFpbCBvZiBTdWdn
ZXN0ZWQtYnkgYW5kIFJldmlld2VkLWJ5DQo+PiANCj4+ICAuLi4vbW92ZV9tb3VudF9zZXRfZ3Jv
dXAvbW92ZV9tb3VudF9zZXRfZ3JvdXBfdGVzdC5jICAgICAgICAgIHwgNCArKy0tDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlm
ZiAtLWdpdCANCj4+IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW92ZV9tb3VudF9zZXRfZ3Jv
dXAvbW92ZV9tb3VudF9zZXRfZ3JvdXBfdGUNCj4+IHN0LmMgDQo+PiBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL21vdmVfbW91bnRfc2V0X2dyb3VwL21vdmVfbW91bnRfc2V0X2dyb3VwX3RlDQo+
PiBzdC5jIGluZGV4IDUwZWQ1ZDQ3NWRkMS4uYmNmNTFkNzg1YTM3IDEwMDY0NA0KPj4gLS0tIA0K
Pj4gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tb3ZlX21vdW50X3NldF9ncm91cC9tb3ZlX21v
dW50X3NldF9ncm91cF90ZQ0KPj4gc3QuYw0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvbW92ZV9tb3VudF9zZXRfZ3JvdXAvbW92ZV9tb3VudF9zZXRfZ3JvdQ0KPj4gKysrIHBfdGVz
dC5jDQo+PiBAQCAtMjE4LDcgKzIxOCw3IEBAIHN0YXRpYyBib29sIG1vdmVfbW91bnRfc2V0X2dy
b3VwX3N1cHBvcnRlZCh2b2lkKQ0KPj4gIAlpZiAobW91bnQoTlVMTCwgU0VUX0dST1VQX0ZST00s
IE5VTEwsIE1TX1NIQVJFRCwgMCkpDQo+PiAgCQlyZXR1cm4gLTE7DQo+PiAgDQo+PiAtCXJldCA9
IHN5c2NhbGwoU1lTX21vdmVfbW91bnQsIEFUX0ZEQ1dELCBTRVRfR1JPVVBfRlJPTSwNCj4+ICsJ
cmV0ID0gc3lzY2FsbChfX05SX21vdmVfbW91bnQsIEFUX0ZEQ1dELCBTRVRfR1JPVVBfRlJPTSwN
Cj4+ICAJCSAgICAgIEFUX0ZEQ1dELCBTRVRfR1JPVVBfVE8sIE1PVkVfTU9VTlRfU0VUX0dST1VQ
KTsNCj4+ICAJdW1vdW50MigiL3RtcCIsIE1OVF9ERVRBQ0gpOw0KPj4gIA0KPj4gQEAgLTM2Myw3
ICszNjMsNyBAQCBURVNUX0YobW92ZV9tb3VudF9zZXRfZ3JvdXAsIGNvbXBsZXhfc2hhcmluZ19j
b3B5aW5nKQ0KPj4gIAkJICAgICAgIENMT05FX1ZNIHwgQ0xPTkVfRklMRVMpOyBBU1NFUlRfR1Qo
cGlkLCAwKTsNCj4+ICAJQVNTRVJUX0VRKHdhaXRfZm9yX3BpZChwaWQpLCAwKTsNCj4+ICANCj4+
IC0JQVNTRVJUX0VRKHN5c2NhbGwoU1lTX21vdmVfbW91bnQsIGNhX2Zyb20ubW50ZmQsICIiLA0K
Pj4gKwlBU1NFUlRfRVEoc3lzY2FsbChfX05SX21vdmVfbW91bnQsIGNhX2Zyb20ubW50ZmQsICIi
LA0KPj4gIAkJCSAgY2FfdG8ubW50ZmQsICIiLCBNT1ZFX01PVU5UX1NFVF9HUk9VUA0KPj4gIAkJ
CSAgfCBNT1ZFX01PVU5UX0ZfRU1QVFlfUEFUSCB8IE1PVkVfTU9VTlRfVF9FTVBUWV9QQVRIKSwN
Cj4+ICAJCSAgMCk7DQo+PiAtLQ0KPj4gMi4yMy4wDQo+PiANCj4+ICANCg==

