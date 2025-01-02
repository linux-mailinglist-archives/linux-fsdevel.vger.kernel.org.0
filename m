Return-Path: <linux-fsdevel+bounces-38334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B59FFB7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 17:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C4C7A113F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A4374CB;
	Thu,  2 Jan 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VrFe3v6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58A7DA66;
	Thu,  2 Jan 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735834907; cv=none; b=Tw1jCA4B2AmX8S04ZsdO82q5pnnnveGA69L5uLtryqKoO25cS+bfijQ6lEVbAFHL9h4Scp+acaS/7a6lPc5lGE0GjU570iNbh5NGAGo0N45DKijtLCmH1I9NqxBuPrH4yoOLHO57ebPXiRrAjycnnLUhZKzNAj8kGbl4KiX+xtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735834907; c=relaxed/simple;
	bh=r2sB3vgG4gVC93zaBeSlhna7Rak3JStGHC+vzINouNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDE6lPmeWdb6mZh/cbAkCREUbI4v5Gj7rEft3RZmCI2T7H/DD0+Fs4nTopMi0lkjtaO/yRcpUDoesMMTR/M5HKOG2vwxDkqMzev2RqHad84xmWFH06N9/vMujsZQlruALg52JzeVhF8sXjYOf64Elil88GgpAWQzqi8vKNjfqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VrFe3v6X; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1735834824;
	bh=HRhL8cSCoLEHuUSAHT03u9NgUQrrF1NmM3qeAWtHcaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VrFe3v6XBbf8xfKNqlq1/YXOpQb4yzx1xKj59R48Mol0vy5z/RYL0tODwp1nIKS7q
	 GHYWv4MeviDYTDg975VYD7ofRmy/Ve4W55qFw5svBt7Ysy7YK+KdMMPwoxnrxe9RbJ
	 SiqwsTCZQPNKSI36yVC2xHJ5heWiHpbF+hOHlRIg=
X-QQ-mid: bizesmtpip2t1735834816trh3puf
X-QQ-Originating-IP: kQpL/BTcekaOzurxiYPa39nhYPqM50sdm5tNtO/YoSE=
Received: from [IPV6:240e:36c:d04:4e00:6fe:6b1 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 03 Jan 2025 00:20:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6433200815309813094
Message-ID: <74D957F3D234C8BA+47ec121f-4fea-4693-adeb-ae3d46538834@uniontech.com>
Date: Fri, 3 Jan 2025 00:20:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Oleg Nesterov <oleg@redhat.com>, Manfred Spraul
 <manfred@colorfullife.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yushengjin@uniontech.com, zhangdandan@uniontech.com,
 chenyichong@uniontech.com
References: <20250102140715.GA7091@redhat.com>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <20250102140715.GA7091@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------40GzhJ4O0XI99tfxgVfctQXJ"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MethMtsVJ2tA9ObSWfnvSRVcrsWTcfxMmUe5KR/ewonqvke6azGN1Wwi
	vpzrwfguPv5Di9wbWuv0V5/wKRSXYWznfD7GUAOnNkp7HUTpe48n1YHRFzX2B2nC0btD0IZ
	Lo6Yvt5uWykmama1dbzpow9HN7Mc78QAuFh6z8EKO+PXbNJsq3hDhe+wNL87bl4pflTzCFB
	aR7aMO+NQO8JbGG8quMjb3UvTkHOHi10rf9NHINq9D7zHzoaxvjKt2LgTgkJ5SfelD1g9e4
	YnTm+o+InuKA8wp/2Ypdjfead02te91hJDW7UaKHDGuiTW2xib/scahDSPs3YUVCAhyTD45
	iBjI9CjsVQZVlKgnDNAbpXrgTJfYmOeNdNZkGZHn08uBHkLMVhWf1b2585n9xSDvBCT3eNH
	P2PIDC2leArVRZBcyRbC3Z7Is/zCzIVnT8YJJQ5U1INW8TP+Si4qUr5O4ayY9tRM6r6kja2
	SQTGRPK39oUHJM9/9fbLIY6DitQmbyWslEqA2p6ymIj8Ssgo7n7P8E1g16DmWs8Lk8wRhZQ
	JKdQT7VmCcbjksoR1cIXR7O6RI3c+C/xmbBF977YYabApzd3T5KGChV256mHePUGyb68Ku6
	ntVbG904AEQcynFFlbr0MkgiLlffRVOZ74mEfuOje9hOn9L/+YaH8LpO5qCl3He9sILuCk+
	gqrMze1vPqWRyI8vi5ds/xz1aif3dR4qeT12EcJE1IFOv69PL2VJzXxNsCIzm6BZ6K08TH7
	eezF1LZ6iwBKNHyofzQMLpUHXevZs+r4nwmLEdlac7DH7a0xp3uzokwiur7JLFR9GX3QOGe
	V7WKV5vcUqDNERQA8mjf6oZloBFka0N/NAotOyXSXdFeLDxc0rWD/gt2CmXqGZoaQ1Rybjk
	ixt6Hvre+ElPFKSmk4lNYY9bNagjiCzZrvUXAg0z1ucm1y4CIsjl/LRuDMNg9Ubz9cowrJ2
	6w7DRkEtKF6gt3z5IMxtVz4jIU92MQ6VJffZF9bUZ7vqIK4MZP7jN+JNBSuhIR9l1q0VTEL
	+HHl3ZqwaMtDhU/AassKk6HRmL8OlsNCXZK9+TLIfmA9IqbSYnZHratzBhc6c8sI68LPnRA
	HZM2xefLudvBupGXUG8Yz3TP0B7cXQ3GVDtCO6iKGfnKXvlDx8vFu96vIwaf6JZaiE6FAlZ
	5qck3ceLWnw9xZhdpQAwPa63++1u4Q9RKAb45AZxw0N2o8mcZ1XUFp+0ca/bgWlXWUZt
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------40GzhJ4O0XI99tfxgVfctQXJ
Content-Type: multipart/mixed; boundary="------------5cTDq4TrUU7OgYWTdxbUrc61";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Oleg Nesterov <oleg@redhat.com>, Manfred Spraul
 <manfred@colorfullife.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yushengjin@uniontech.com, zhangdandan@uniontech.com,
 chenyichong@uniontech.com
Message-ID: <47ec121f-4fea-4693-adeb-ae3d46538834@uniontech.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
References: <20250102140715.GA7091@redhat.com>
In-Reply-To: <20250102140715.GA7091@redhat.com>

--------------5cTDq4TrUU7OgYWTdxbUrc61
Content-Type: multipart/mixed; boundary="------------luXnk0rZSkpBaiFq1o2Zs7Wn"

--------------luXnk0rZSkpBaiFq1o2Zs7Wn
Content-Type: multipart/alternative;
 boundary="------------yjtIRnLfypBSV1R06Z0eDLdj"

--------------yjtIRnLfypBSV1R06Z0eDLdj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

W0FkZGluZyBzb21lIG9mIG15IGNvbGxlYWd1ZXMgd2hvIHdlcmUgcGFydCBvZiB0aGUgb3Jp
Z2luYWwgc3VibWlzc2lvbiANCnRvIHRoZSBDQyBsaXN0IGZvciB0aGVpciBpbmZvcm1hdGlv
bi5dDQoNCg0KT24gMjAyNS8xLzIgMjI6MDcsIE9sZWcgTmVzdGVyb3Ygd3JvdGU6DQo+IHdh
a2VfdXAocGlwZS0+d3Jfd2FpdCkgbWFrZXMgbm8gc2Vuc2UgaWYgcGlwZV9mdWxsKCkgaXMg
c3RpbGwgdHJ1ZSBhZnRlcg0KPiB0aGUgcmVhZGluZywgdGhlIHdyaXRlciBzbGVlcGluZyBp
biB3YWl0X2V2ZW50KHdyX3dhaXQsIHBpcGVfd3JpdGFibGUoKSkNCj4gd2lsbCBjaGVjayB0
aGUgcGlwZV93cml0YWJsZSgpID09ICFwaXBlX2Z1bGwoKSBjb25kaXRpb24gYW5kIHNsZWVw
IGFnYWluLg0KPg0KPiBPbmx5IHdha2UgdGhlIHdyaXRlciBpZiB3ZSBhY3R1YWxseSByZWxl
YXNlZCBhIHBpcGUgYnVmLCBhbmQgdGhlIHBpcGUgd2FzDQo+IGZ1bGwgYmVmb3JlIHdlIGRp
ZCBzby4NCg0KQXMgTGludXMgc2FpZCwgZm9yIGZzL3BpcGUsIGhlICJ3YW50IGFueSBwYXRj
aGVzIHRvIGJlIHZlcnkgY2xlYXJseSANCmRvY3VtZW50ZWQsIiBwZXJoYXBzIHdlIHNob3Vs
ZCBpbmNsdWRlIGEgbGluayB0byB0aGUgb3JpZ2luYWwgZGlzY3Vzc2lvbiANCmhlcmUuDQoN
Ckxpbms6IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzc1QjA2RUUwQjY3NzQ3RUQr
MjAyNDEyMjUwOTQyMDIuNTk3MzA1LTEtd2FuZ3l1bGlAdW5pb250ZWNoLmNvbS8NCg0KTGlu
azogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMjI5MTM1NzM3LkdBMzI5M0By
ZWRoYXQuY29tLw0KDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWcgTmVzdGVyb3Y8b2xlZ0ByZWRo
YXQuY29tPg0KDQpSZXBvcnRlZC1ieTogV2FuZ1l1bGkgPHdhbmd5dWxpQHVuaW9udGVjaC5j
b20+DQoNCkknbSBoYXBweSB0byBwcm92aWRlIG1vcmUgdGVzdCByZXN1bHRzIGZvciB0aGlz
IHBhdGNoIGlmIGl0J3Mgbm90IHRvbyBsYXRlLg0KDQo+IC0tLQ0KPiAgIGZzL3BpcGUuYyB8
IDE5ICsrKysrKysrKystLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2ZzL3BpcGUuYyBi
L2ZzL3BpcGUuYw0KPiBpbmRleCAxMmIyMmMyNzIzYjcuLjgyZmVkZTBmMjExMSAxMDA2NDQN
Cj4gLS0tIGEvZnMvcGlwZS5jDQo+ICsrKyBiL2ZzL3BpcGUuYw0KPiBAQCAtMjUzLDcgKzI1
Myw3IEBAIHBpcGVfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAq
dG8pDQo+ICAgCXNpemVfdCB0b3RhbF9sZW4gPSBpb3ZfaXRlcl9jb3VudCh0byk7DQo+ICAg
CXN0cnVjdCBmaWxlICpmaWxwID0gaW9jYi0+a2lfZmlscDsNCj4gICAJc3RydWN0IHBpcGVf
aW5vZGVfaW5mbyAqcGlwZSA9IGZpbHAtPnByaXZhdGVfZGF0YTsNCj4gLQlib29sIHdhc19m
dWxsLCB3YWtlX25leHRfcmVhZGVyID0gZmFsc2U7DQo+ICsJYm9vbCB3YWtlX3dyaXRlciA9
IGZhbHNlLCB3YWtlX25leHRfcmVhZGVyID0gZmFsc2U7DQo+ICAgCXNzaXplX3QgcmV0Ow0K
PiAgIA0KPiAgIAkvKiBOdWxsIHJlYWQgc3VjY2VlZHMuICovDQo+IEBAIC0yNjQsMTQgKzI2
NCwxMyBAQCBwaXBlX3JlYWQoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIg
KnRvKQ0KPiAgIAltdXRleF9sb2NrKCZwaXBlLT5tdXRleCk7DQo+ICAgDQo+ICAgCS8qDQo+
IC0JICogV2Ugb25seSB3YWtlIHVwIHdyaXRlcnMgaWYgdGhlIHBpcGUgd2FzIGZ1bGwgd2hl
biB3ZSBzdGFydGVkDQo+IC0JICogcmVhZGluZyBpbiBvcmRlciB0byBhdm9pZCB1bm5lY2Vz
c2FyeSB3YWtldXBzLg0KPiArCSAqIFdlIG9ubHkgd2FrZSB1cCB3cml0ZXJzIGlmIHRoZSBw
aXBlIHdhcyBmdWxsIHdoZW4gd2Ugc3RhcnRlZCByZWFkaW5nDQo+ICsJICogYW5kIGl0IGlz
IG5vIGxvbmdlciBmdWxsIGFmdGVyIHJlYWRpbmcgdG8gYXZvaWQgdW5uZWNlc3Nhcnkgd2Fr
ZXVwcy4NCj4gICAJICoNCj4gICAJICogQnV0IHdoZW4gd2UgZG8gd2FrZSB1cCB3cml0ZXJz
LCB3ZSBkbyBzbyB1c2luZyBhIHN5bmMgd2FrZXVwDQo+ICAgCSAqIChXRl9TWU5DKSwgYmVj
YXVzZSB3ZSB3YW50IHRoZW0gdG8gZ2V0IGdvaW5nIGFuZCBnZW5lcmF0ZSBtb3JlDQo+ICAg
CSAqIGRhdGEgZm9yIHVzLg0KPiAgIAkgKi8NCj4gLQl3YXNfZnVsbCA9IHBpcGVfZnVsbChw
aXBlLT5oZWFkLCBwaXBlLT50YWlsLCBwaXBlLT5tYXhfdXNhZ2UpOw0KPiAgIAlmb3IgKDs7
KSB7DQo+ICAgCQkvKiBSZWFkIC0+aGVhZCB3aXRoIGEgYmFycmllciB2cyBwb3N0X29uZV9u
b3RpZmljYXRpb24oKSAqLw0KPiAgIAkJdW5zaWduZWQgaW50IGhlYWQgPSBzbXBfbG9hZF9h
Y3F1aXJlKCZwaXBlLT5oZWFkKTsNCj4gQEAgLTM0MCw4ICszMzksMTAgQEAgcGlwZV9yZWFk
KHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykNCj4gICAJCQkJYnVm
LT5sZW4gPSAwOw0KPiAgIAkJCX0NCj4gICANCj4gLQkJCWlmICghYnVmLT5sZW4pDQo+ICsJ
CQlpZiAoIWJ1Zi0+bGVuKSB7DQo+ICsJCQkJd2FrZV93cml0ZXIgfD0gcGlwZV9mdWxsKGhl
YWQsIHRhaWwsIHBpcGUtPm1heF91c2FnZSk7DQo+ICAgCQkJCXRhaWwgPSBwaXBlX3VwZGF0
ZV90YWlsKHBpcGUsIGJ1ZiwgdGFpbCk7DQo+ICsJCQl9DQo+ICAgCQkJdG90YWxfbGVuIC09
IGNoYXJzOw0KPiAgIAkJCWlmICghdG90YWxfbGVuKQ0KPiAgIAkJCQlicmVhazsJLyogY29t
bW9uIHBhdGg6IHJlYWQgc3VjY2VlZGVkICovDQo+IEBAIC0zNzcsNyArMzc4LDcgQEAgcGlw
ZV9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykNCj4gICAJ
CSAqIF92ZXJ5XyB1bmxpa2VseSBjYXNlIHRoYXQgdGhlIHBpcGUgd2FzIGZ1bGwsIGJ1dCB3
ZSBnb3QNCj4gICAJCSAqIG5vIGRhdGEuDQo+ICAgCQkgKi8NCj4gLQkJaWYgKHVubGlrZWx5
KHdhc19mdWxsKSkNCj4gKwkJaWYgKHVubGlrZWx5KHdha2Vfd3JpdGVyKSkNCj4gICAJCQl3
YWtlX3VwX2ludGVycnVwdGlibGVfc3luY19wb2xsKCZwaXBlLT53cl93YWl0LCBFUE9MTE9V
VCB8IEVQT0xMV1JOT1JNKTsNCj4gICAJCWtpbGxfZmFzeW5jKCZwaXBlLT5mYXN5bmNfd3Jp
dGVycywgU0lHSU8sIFBPTExfT1VUKTsNCj4gICANCj4gQEAgLTM5MCwxNSArMzkxLDE1IEBA
IHBpcGVfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqdG8pDQo+
ICAgCQlpZiAod2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX2V4Y2x1c2l2ZShwaXBlLT5yZF93
YWl0LCBwaXBlX3JlYWRhYmxlKHBpcGUpKSA8IDApDQo+ICAgCQkJcmV0dXJuIC1FUkVTVEFS
VFNZUzsNCj4gICANCj4gLQkJbXV0ZXhfbG9jaygmcGlwZS0+bXV0ZXgpOw0KPiAtCQl3YXNf
ZnVsbCA9IHBpcGVfZnVsbChwaXBlLT5oZWFkLCBwaXBlLT50YWlsLCBwaXBlLT5tYXhfdXNh
Z2UpOw0KPiArCQl3YWtlX3dyaXRlciA9IGZhbHNlOw0KPiAgIAkJd2FrZV9uZXh0X3JlYWRl
ciA9IHRydWU7DQo+ICsJCW11dGV4X2xvY2soJnBpcGUtPm11dGV4KTsNCj4gICAJfQ0KPiAg
IAlpZiAocGlwZV9lbXB0eShwaXBlLT5oZWFkLCBwaXBlLT50YWlsKSkNCj4gICAJCXdha2Vf
bmV4dF9yZWFkZXIgPSBmYWxzZTsNCj4gICAJbXV0ZXhfdW5sb2NrKCZwaXBlLT5tdXRleCk7
DQo+ICAgDQo+IC0JaWYgKHdhc19mdWxsKQ0KPiArCWlmICh3YWtlX3dyaXRlcikNCj4gICAJ
CXdha2VfdXBfaW50ZXJydXB0aWJsZV9zeW5jX3BvbGwoJnBpcGUtPndyX3dhaXQsIEVQT0xM
T1VUIHwgRVBPTExXUk5PUk0pOw0KPiAgIAlpZiAod2FrZV9uZXh0X3JlYWRlcikNCj4gICAJ
CXdha2VfdXBfaW50ZXJydXB0aWJsZV9zeW5jX3BvbGwoJnBpcGUtPnJkX3dhaXQsIEVQT0xM
SU4gfCBFUE9MTFJETk9STSk7DQpIbW0uLg0KSW5pdGlhbGx5LCB0aGUgc29sZSBwdXJwb3Nl
IG9mIG91ciBvcmlnaW5hbCBwYXRjaCB3YXMgdG8gc2ltcGx5IGNoZWNrIGlmIA0KdGhlcmUg
d2VyZSBhbnkgd2FpdGluZyBwcm9jZXNzZXMgaW4gdGhlIHByb2Nlc3Mgd2FpdCBxdWV1ZSB0
byBhdm9pZCANCnVubmVjZXNzYXJ5IHdha2UtdXBzLCBmb3IgYm90aCByZWFkcyBhbmQgd3Jp
dGVzLg0KQW5kIHRoZW4sIHNpbmNlcmVseSB0aGFuayB5b3UgYWxsIGZvciB0YWtpbmcgdGhl
IHRpbWUgdG8gcmV2aWV3IGl0IQ0KV2hpbGUgeW91ciBwYXRjaCBhbmQgb3VycyBzaGFyZSBz
b21lIGxpdHRsZSBzaW1pbGFyaXRpZXMsIG91ciBwcmltYXJ5IA0KZ29hbHMgbWF5IHZhcnkg
c2xpZ2h0bHkuIERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBvbiBob3cgd2UgY291bGQg
DQpiZXR0ZXIgYWNoaWV2ZSBvdXIgb3JpZ2luYWwgb2JqZWN0aXZlPw0KDQpUaGFua3MsDQot
LSANCldhbmdZdWxpDQo=
--------------yjtIRnLfypBSV1R06Z0eDLdj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>[Adding some of my colleagues who were part of the original
      submission to the CC list for their information.]</p>
    <div class=3D"moz-signature"><br>
    </div>
    <p></p>
    <div class=3D"moz-cite-prefix">On 2025/1/2 22:07, Oleg Nesterov wrote=
:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20250102140715.GA7091@redhat.co=
m">
      <pre wrap=3D"" class=3D"moz-quote-pre">wake_up(pipe-&gt;wr_wait) ma=
kes no sense if pipe_full() is still true after
the reading, the writer sleeping in wait_event(wr_wait, pipe_writable())
will check the pipe_writable() =3D=3D !pipe_full() condition and sleep ag=
ain.

Only wake the writer if we actually released a pipe buf, and the pipe was=

full before we did so.
</pre>
    </blockquote>
    <p>As Linus said, for fs/pipe, he "want any patches to be very
      clearly documented," perhaps we should include a link to the
      original discussion here.</p>
    <p>Link:
<a class=3D"moz-txt-link-freetext" href=3D"https://lore.kernel.org/all/75=
B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com/">https://l=
ore.kernel.org/all/75B06EE0B67747ED+20241225094202.597305-1-wangyuli@unio=
ntech.com/</a></p>
    <p>Link:
      <a class=3D"moz-txt-link-freetext" href=3D"https://lore.kernel.org/=
all/20241229135737.GA3293@redhat.com/">https://lore.kernel.org/all/202412=
29135737.GA3293@redhat.com/</a><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:20250102140715.GA7091@redhat.co=
m">
      <pre wrap=3D"" class=3D"moz-quote-pre">
Signed-off-by: Oleg Nesterov <a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:oleg@redhat.com">&lt;oleg@redhat.com&gt;</a></pre>
    </blockquote>
    <p>Reported-by: WangYuli <a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:wangyuli@uniontech.com">&lt;wangyuli@uniontech.com&gt;</a></p>
    <p>I'm happy to provide more test results for this patch if it's not
      too late.<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:20250102140715.GA7091@redhat.co=
m">
      <pre wrap=3D"" class=3D"moz-quote-pre">
---
 fs/pipe.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..82fede0f2111 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -253,7 +253,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	size_t total_len =3D iov_iter_count(to);
 	struct file *filp =3D iocb-&gt;ki_filp;
 	struct pipe_inode_info *pipe =3D filp-&gt;private_data;
-	bool was_full, wake_next_reader =3D false;
+	bool wake_writer =3D false, wake_next_reader =3D false;
 	ssize_t ret;
=20
 	/* Null read succeeds. */
@@ -264,14 +264,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	mutex_lock(&amp;pipe-&gt;mutex);
=20
 	/*
-	 * We only wake up writers if the pipe was full when we started
-	 * reading in order to avoid unnecessary wakeups.
+	 * We only wake up writers if the pipe was full when we started reading=

+	 * and it is no longer full after reading to avoid unnecessary wakeups.=

 	 *
 	 * But when we do wake up writers, we do so using a sync wakeup
 	 * (WF_SYNC), because we want them to get going and generate more
 	 * data for us.
 	 */
-	was_full =3D pipe_full(pipe-&gt;head, pipe-&gt;tail, pipe-&gt;max_usage=
);
 	for (;;) {
 		/* Read -&gt;head with a barrier vs post_one_notification() */
 		unsigned int head =3D smp_load_acquire(&amp;pipe-&gt;head);
@@ -340,8 +339,10 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				buf-&gt;len =3D 0;
 			}
=20
-			if (!buf-&gt;len)
+			if (!buf-&gt;len) {
+				wake_writer |=3D pipe_full(head, tail, pipe-&gt;max_usage);
 				tail =3D pipe_update_tail(pipe, buf, tail);
+			}
 			total_len -=3D chars;
 			if (!total_len)
 				break;	/* common path: read succeeded */
@@ -377,7 +378,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		 * _very_ unlikely case that the pipe was full, but we got
 		 * no data.
 		 */
-		if (unlikely(was_full))
+		if (unlikely(wake_writer))
 			wake_up_interruptible_sync_poll(&amp;pipe-&gt;wr_wait, EPOLLOUT | EPO=
LLWRNORM);
 		kill_fasync(&amp;pipe-&gt;fasync_writers, SIGIO, POLL_OUT);
=20
@@ -390,15 +391,15 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		if (wait_event_interruptible_exclusive(pipe-&gt;rd_wait, pipe_readable=
(pipe)) &lt; 0)
 			return -ERESTARTSYS;
=20
-		mutex_lock(&amp;pipe-&gt;mutex);
-		was_full =3D pipe_full(pipe-&gt;head, pipe-&gt;tail, pipe-&gt;max_usag=
e);
+		wake_writer =3D false;
 		wake_next_reader =3D true;
+		mutex_lock(&amp;pipe-&gt;mutex);
 	}
 	if (pipe_empty(pipe-&gt;head, pipe-&gt;tail))
 		wake_next_reader =3D false;
 	mutex_unlock(&amp;pipe-&gt;mutex);
=20
-	if (was_full)
+	if (wake_writer)
 		wake_up_interruptible_sync_poll(&amp;pipe-&gt;wr_wait, EPOLLOUT | EPOL=
LWRNORM);
 	if (wake_next_reader)
 		wake_up_interruptible_sync_poll(&amp;pipe-&gt;rd_wait, EPOLLIN | EPOLL=
RDNORM);
</pre>
    </blockquote>
    <div class=3D"moz-signature">Hmm..</div>
    <div class=3D"moz-signature">Initially, the sole purpose of our
      original patch was to simply check if there were any waiting
      processes in the process wait queue to avoid unnecessary wake-ups,
      for both reads and writes.</div>
    <div class=3D"moz-signature">And then, sincerely thank you all for
      taking the time to review it!</div>
    <div class=3D"moz-signature">While your patch and ours share some
      little similarities, our primary goals may vary slightly. Do you
      have any suggestions on how we could better achieve our original
      objective?</div>
    <div class=3D"moz-signature"><br>
    </div>
    <div class=3D"moz-signature">Thanks,<br>
    </div>
    <div class=3D"moz-signature">-- <br>
      WangYuli</div>
  </body>
</html>

--------------yjtIRnLfypBSV1R06Z0eDLdj--

--------------luXnk0rZSkpBaiFq1o2Zs7Wn
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------luXnk0rZSkpBaiFq1o2Zs7Wn--

--------------5cTDq4TrUU7OgYWTdxbUrc61--

--------------40GzhJ4O0XI99tfxgVfctQXJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ3a8uQUDAAAAAAAKCRDF2h8wRvQL7oal
AQDfTKz3jKjxZU/De97ZZvxC82cIJOiv83GWTLVEyZarAgEA4x9Pe/+uwUKrxxVYm3N728kVcAny
IP8mHKrhV80zTQ0=
=hdXD
-----END PGP SIGNATURE-----

--------------40GzhJ4O0XI99tfxgVfctQXJ--

