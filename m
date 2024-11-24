Return-Path: <linux-fsdevel+bounces-35662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C73A9D6D20
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 09:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC649B212FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 08:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0734B1547CF;
	Sun, 24 Nov 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="x8PZ9rMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810DC3C12;
	Sun, 24 Nov 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732438038; cv=none; b=OCwtMlhMyHeHmTQRQJDtA8EvAFPhNt/y3/tbCmbgS+L1gvDb9xF5rfPYE7ls0+B516uLo3Bcr4vgSgOoaoXVTbP4Tq2lmnS6nAKwZwZMqhzB1NF+BAGYp/2C/0fhVxex5b1dNB+r2MeSEGknguLVylts1c6bjmpVmLtvd/DpKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732438038; c=relaxed/simple;
	bh=SmkG5pppsWnJiVYBd3F6Y3NOapASpge3WWBuMaCBc4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=axukK2XHtNF4LN5Ooo/zHwEfBSolly82/AEIR9ns1ii6P2YQMElX+S2oLFT9Bl38bx0Ec6eSFwhxfmAO+faZaDUq06h/z4AWnBfYAZnqY0jKMyhGl7RNDhx+n7vrF2l41AuezXO+XXVH5YsOLbdETK09OSR8pASSdSseSnC658Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=x8PZ9rMA reason="key not found in DNS"; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=OI38ZUo+qIWhmN4Jrh9l/MMiqa1OcMJ6ZroG
	WNzkrWM=; b=x8PZ9rMApbH+hMAd5L27L8aeFAg6QEZznivDxJ+mbsqXbI766Gee
	u30452eiR+6amK5fcPnfMcSFrCnckJlokVLgiT2JD+7UP9PoWN07QrNZu1KaADSw
	BzoGCLG+aAXNF6JbCpFHG+tmWtq5/+h/dgHbVWrpSKYBXi1PC7EsxiQ=
Received: from zhenghaoran$buaa.edu.cn ( [115.60.191.15] ) by
 ajax-webmail-coremail-app1 (Coremail) ; Sun, 24 Nov 2024 16:46:42 +0800
 (GMT+08:00)
Date: Sun, 24 Nov 2024 16:46:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6YOR5rWp54S2?= <zhenghaoran@buaa.edu.cn>
To: "Jeff Layton" <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com, 21371365@buaa.edu.cn, zhenghaoran@buaa.edu.cn
Subject: Re: Re: [PATCH v3] fs: Fix data race in inode_set_ctime_to_ts
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20240305(0ac2fdd1) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-63b7ebb9-fa87-40c1-9aec-818ec5a006d9-buaa.edu.cn
In-Reply-To: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
References: <20241122112228.6him45jdtibue26s@quack3>
 <20241122130642.460929-1-zhenghaoran@buaa.edu.cn>
 <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <26bf3b09.18da5.1935d5a0c1d.Coremail.zhenghaoran@buaa.edu.cn>
X-Coremail-Locale: zh_TW
X-CM-TRANSID:OCz+CgDXBxLy50Jnu9JMAQ--.39035W
X-CM-SenderInfo: 1v1sjjazstiqpexdthxhgxhubq/1tbiAgMLA2dCDMIc1AAAsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

VGhhbmtzIHRvIENocmlzdGlhbiBCcmF1bmVyIGZvciB0aGUgcmVtaW5kZXIgYW5kIEplZmYgTGF5
dG9uIGZvciB0aGUgZml4IHN1Z2dlc3Rpb24uIEkgd2lsbCBiYXNlIG15IHBhdGNoIG9uIHZmcy5m
aXhlcyBhbmQgcmVzZW5kIHRoZSBwYXRjaCB2NCBhZnRlciBmaXhpbmcgaXQuCgoKPiAtLS0tLeWO
n+Wni+mDteS7ti0tLS0tCj4g55m85Lu25Lq6OiAiSmVmZiBMYXl0b24iIDxqbGF5dG9uQGtlcm5l
bC5vcmc+Cj4g55m86YCB5pmC6ZaTOjIwMjQtMTEtMjMgMjI6MDE6MDggKOaYn+acn+WFrSkKPiDm
lLbku7bkuro6ICJIYW8tcmFuIFpoZW5nIiA8emhlbmdoYW9yYW5AYnVhYS5lZHUuY24+LCB2aXJv
QHplbml2LmxpbnV4Lm9yZy51aywgYnJhdW5lckBrZXJuZWwub3JnLCBqYWNrQHN1c2UuY3osIGxp
bnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Cj4g5oqE6YCBOiBiYWlqaWFqdTE5OTBAZ21haWwuY29tLCAyMTM3MTM2NUBidWFhLmVkdS5jbgo+
IOS4u+mhjDogUmU6IFtQQVRDSCB2M10gZnM6IEZpeCBkYXRhIHJhY2UgaW4gaW5vZGVfc2V0X2N0
aW1lX3RvX3RzCj4gCj4gT24gRnJpLCAyMDI0LTExLTIyIGF0IDIxOjA2ICswODAwLCBIYW8tcmFu
IFpoZW5nIHdyb3RlOgo+ID4gQSBkYXRhIHJhY2UgbWF5IG9jY3VyIHdoZW4gdGhlIGZ1bmN0aW9u
IGBpbm9kZV9zZXRfY3RpbWVfdG9fdHMoKWAgYW5kCj4gPiB0aGUgZnVuY3Rpb24gYGlub2RlX2dl
dF9jdGltZV9zZWMoKWAgYXJlIGV4ZWN1dGVkIGNvbmN1cnJlbnRseS4gV2hlbgo+ID4gdHdvIHRo
cmVhZHMgY2FsbCBgYWlvX3JlYWRgIGFuZCBgYWlvX3dyaXRlYCByZXNwZWN0aXZlbHksIHRoZXkg
d2lsbAo+ID4gYmUgZGlzdHJpYnV0ZWQgdG8gdGhlIHJlYWQgYW5kIHdyaXRlIGZ1bmN0aW9ucyBv
ZiB0aGUgY29ycmVzcG9uZGluZwo+ID4gZmlsZSBzeXN0ZW0gcmVzcGVjdGl2ZWx5LiBUYWtpbmcg
dGhlIGJ0cmZzIGZpbGUgc3lzdGVtIGFzIGFuIGV4YW1wbGUsCj4gPiB0aGUgYGJ0cmZzX2ZpbGVf
cmVhZF9pdGVyYCBhbmQgYGJ0cmZzX2ZpbGVfd3JpdGVfaXRlcmAgZnVuY3Rpb25zIGFyZQo+ID4g
ZmluYWxseSBjYWxsZWQuIFRoZXNlIHR3byBmdW5jdGlvbnMgY3JlYXRlZCBhIGRhdGEgcmFjZSB3
aGVuIHRoZXkKPiA+IGZpbmFsbHkgY2FsbGVkIGBpbm9kZV9nZXRfY3RpbWVfc2VjKClgIGFuZCBg
aW5vZGVfc2V0X2N0aW1lX3RvX25zKClgLgo+ID4gVGhlIHNwZWNpZmljIGNhbGwgc3RhY2sgdGhh
dCBhcHBlYXJzIGR1cmluZyB0ZXN0aW5nIGlzIGFzIGZvbGxvd3M6Cj4gPiAKPiA+ID09PT09PT09
PT09PURBVEFfUkFDRT09PT09PT09PT09PQo+ID4gYnRyZnNfZGVsYXllZF91cGRhdGVfaW5vZGUr
MHgxZjYxLzB4N2NlMCBbYnRyZnNdCj4gPiBidHJmc191cGRhdGVfaW5vZGUrMHg0NWUvMHhiYjAg
W2J0cmZzXQo+ID4gYnRyZnNfZGlydHlfaW5vZGUrMHgyYjgvMHg1MzAgW2J0cmZzXQo+ID4gYnRy
ZnNfdXBkYXRlX3RpbWUrMHgxYWQvMHgyMzAgW2J0cmZzXQo+ID4gdG91Y2hfYXRpbWUrMHgyMTEv
MHg0NDAKPiA+IGZpbGVtYXBfcmVhZCsweDkwZi8weGEyMAo+ID4gYnRyZnNfZmlsZV9yZWFkX2l0
ZXIrMHhlYi8weDU4MCBbYnRyZnNdCj4gPiBhaW9fcmVhZCsweDI3NS8weDNhMAo+ID4gaW9fc3Vi
bWl0X29uZSsweGQyMi8weDFjZTAKPiA+IF9fc2Vfc3lzX2lvX3N1Ym1pdCsweGIzLzB4MjUwCj4g
PiBkb19zeXNjYWxsXzY0KzB4YzEvMHgxOTAKPiA+IGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdm
cmFtZSsweDc3LzB4N2YKPiA+ID09PT09PT09PT09PU9USEVSX0lORk89PT09PT09PT09PT0KPiA+
IGJ0cmZzX3dyaXRlX2NoZWNrKzB4YTE1LzB4MTM5MCBbYnRyZnNdCj4gPiBidHJmc19idWZmZXJl
ZF93cml0ZSsweDUyZi8weDI5ZDAgW2J0cmZzXQo+ID4gYnRyZnNfZG9fd3JpdGVfaXRlcisweDUz
ZC8weDE1OTAgW2J0cmZzXQo+ID4gYnRyZnNfZmlsZV93cml0ZV9pdGVyKzB4NDEvMHg2MCBbYnRy
ZnNdCj4gPiBhaW9fd3JpdGUrMHg0MWUvMHg1ZjAKPiA+IGlvX3N1Ym1pdF9vbmUrMHhkNDIvMHgx
Y2UwCj4gPiBfX3NlX3N5c19pb19zdWJtaXQrMHhiMy8weDI1MAo+ID4gZG9fc3lzY2FsbF82NCsw
eGMxLzB4MTkwCj4gPiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8weDdmCj4g
PiAKPiA+IFRvIGFkZHJlc3MgdGhpcyBpc3N1ZSwgaXQgaXMgcmVjb21tZW5kZWQgdG8gYWRkIFdS
SVRFX09OQ0UKPiA+IHdoZW4gd3JpdGluZyB0aGUgYGlub2RlLT5pX2N0aW1lX3NlY2AgdmFyaWFi
bGUuYW5kIGFkZAo+ID4gUkVBRF9PTkNFIHdoZW4gcmVhZGluZyBpbiBmdW5jdGlvbiBgaW5vZGVf
Z2V0X2N0aW1lX3NlYygpYAo+ID4gYW5kIGBpbm9kZV9nZXRfY3RpbWVfbnNlYygpYC4KPiA+IAo+
ID4gU2lnbmVkLW9mZi1ieTogSGFvLXJhbiBaaGVuZyA8emhlbmdoYW9yYW5AYnVhYS5lZHUuY24+
Cj4gPiAtLS0KPiA+IFYyIC0+IFYzOiBBZGRlZCBSRUFEX09OQ0UgaW4gaW5vZGVfZ2V0X2N0aW1l
X25zZWMoKSBhbmQgYWRkcmVzc2VkIHJldmlldyBjb21tZW50cwo+ID4gVjEgLT4gVjI6IEFkZGVk
IFJFQURfT05DRSBpbiBpbm9kZV9nZXRfY3RpbWVfc2VjKCkKPiA+IC0tLQo+ID4gIGluY2x1ZGUv
bGludXgvZnMuaCB8IDggKysrKy0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9m
cy5oIGIvaW5jbHVkZS9saW51eC9mcy5oCj4gPiBpbmRleCAzNTU5NDQ2Mjc5YzEuLmMxOGY5YTll
ZTVlNyAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZnMuaAo+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9mcy5oCj4gPiBAQCAtMTY1NSwxMiArMTY1NSwxMiBAQCBzdGF0aWMgaW5saW5lIHN0
cnVjdCB0aW1lc3BlYzY0IGlub2RlX3NldF9tdGltZShzdHJ1Y3QgaW5vZGUgKmlub2RlLAo+ID4g
IAo+ID4gIHN0YXRpYyBpbmxpbmUgdGltZTY0X3QgaW5vZGVfZ2V0X2N0aW1lX3NlYyhjb25zdCBz
dHJ1Y3QgaW5vZGUgKmlub2RlKQo+ID4gIHsKPiA+IC0JcmV0dXJuIGlub2RlLT5pX2N0aW1lX3Nl
YzsKPiA+ICsJcmV0dXJuIFJFQURfT05DRShpbm9kZS0+aV9jdGltZV9zZWMpOwo+ID4gIH0KPiA+
ICAKPiA+ICBzdGF0aWMgaW5saW5lIGxvbmcgaW5vZGVfZ2V0X2N0aW1lX25zZWMoY29uc3Qgc3Ry
dWN0IGlub2RlICppbm9kZSkKPiA+ICB7Cj4gPiAtCXJldHVybiBpbm9kZS0+aV9jdGltZV9uc2Vj
Owo+ID4gKwlyZXR1cm4gUkVBRF9PTkNFKGlub2RlLT5pX2N0aW1lX25zZWMpOwo+ID4gIH0KPiA+
ICAKPiA+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCB0aW1lc3BlYzY0IGlub2RlX2dldF9jdGltZShj
b25zdCBzdHJ1Y3QgaW5vZGUgKmlub2RlKQo+ID4gQEAgLTE2NzQsOCArMTY3NCw4IEBAIHN0YXRp
YyBpbmxpbmUgc3RydWN0IHRpbWVzcGVjNjQgaW5vZGVfZ2V0X2N0aW1lKGNvbnN0IHN0cnVjdCBp
bm9kZSAqaW5vZGUpCj4gPiAgc3RhdGljIGlubGluZSBzdHJ1Y3QgdGltZXNwZWM2NCBpbm9kZV9z
ZXRfY3RpbWVfdG9fdHMoc3RydWN0IGlub2RlICppbm9kZSwKPiA+ICAJCQkJCQkgICAgICBzdHJ1
Y3QgdGltZXNwZWM2NCB0cykKPiA+ICB7Cj4gPiAtCWlub2RlLT5pX2N0aW1lX3NlYyA9IHRzLnR2
X3NlYzsKPiA+IC0JaW5vZGUtPmlfY3RpbWVfbnNlYyA9IHRzLnR2X25zZWM7Cj4gPiArCVdSSVRF
X09OQ0UoaW5vZGUtPmlfY3RpbWVfc2VjLCB0cy50dl9zZWMpOwo+ID4gKwlXUklURV9PTkNFKGlu
b2RlLT5pX2N0aW1lX25zZWMsIHRzLnR2X25zZWMpOwo+ID4gIAlyZXR1cm4gdHM7Cj4gPiAgfQo+
ID4gIAo+IAo+IExvb2tzIHJlYXNvbmFibGUuIFRoZXJlIGFyZSBhbHNvIGJhcmUgZmV0Y2hlcyBh
bmQgc3RvcmVzIG9mIHRoZQo+IGlfY3RpbWVfc2VjIGZpZWxkIGluIGlub2RlX3NldF9jdGltZV9j
dXJyZW50KCkuIERvIHdlIG5lZWQgc29tZXRoaW5nCj4gbGlrZSB0aGlzIGluIGFkZGl0aW9uIHRv
IHRoZSBhYm92ZT8KPiAKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvaW5vZGUuYyBiL2ZzL2lub2RlLmMK
PiBpbmRleCBiMTNiNzc4MjU3YWUuLmQ4NjllZTZmMWM2YiAxMDA2NDQKPiAtLS0gYS9mcy9pbm9k
ZS5jCj4gKysrIGIvZnMvaW5vZGUuYwo+IEBAIC0yNzg4LDcgKzI3ODgsNyBAQCBzdHJ1Y3QgdGlt
ZXNwZWM2NCBpbm9kZV9zZXRfY3RpbWVfY3VycmVudChzdHJ1Y3QgaW5vZGUgKmlub2RlKQo+ICAJ
ICovCj4gIAljbnMgPSBzbXBfbG9hZF9hY3F1aXJlKCZpbm9kZS0+aV9jdGltZV9uc2VjKTsKPiAg
CWlmIChjbnMgJiBJX0NUSU1FX1FVRVJJRUQpIHsKPiAtCQlzdHJ1Y3QgdGltZXNwZWM2NCBjdGlt
ZSA9IHsgLnR2X3NlYyA9IGlub2RlLT5pX2N0aW1lX3NlYywKPiArCQlzdHJ1Y3QgdGltZXNwZWM2
NCBjdGltZSA9IHsgLnR2X3NlYyA9IFJFQURfT05DRShpbm9kZS0+aV9jdGltZV9zZWMpLAo+ICAJ
CQkJCSAgICAudHZfbnNlYyA9IGNucyAmIH5JX0NUSU1FX1FVRVJJRUQgfTsKPiAgCj4gIAkJaWYg
KHRpbWVzcGVjNjRfY29tcGFyZSgmbm93LCAmY3RpbWUpIDw9IDApIHsKPiBAQCAtMjgwOSw3ICsy
ODA5LDcgQEAgc3RydWN0IHRpbWVzcGVjNjQgaW5vZGVfc2V0X2N0aW1lX2N1cnJlbnQoc3RydWN0
IGlub2RlICppbm9kZSkKPiAgCS8qIFRyeSB0byBzd2FwIHRoZSBuc2VjIHZhbHVlIGludG8gcGxh
Y2UuICovCj4gIAlpZiAodHJ5X2NtcHhjaGcoJmlub2RlLT5pX2N0aW1lX25zZWMsICZjdXIsIG5v
dy50dl9uc2VjKSkgewo+ICAJCS8qIElmIHN3YXAgb2NjdXJyZWQsIHRoZW4gd2UncmUgKG1vc3Rs
eSkgZG9uZSAqLwo+IC0JCWlub2RlLT5pX2N0aW1lX3NlYyA9IG5vdy50dl9zZWM7Cj4gKwkJV1JJ
VEVfT05DRShpbm9kZS0+aV9jdGltZV9zZWMsIG5vdy50dl9zZWMpOwo+ICAJCXRyYWNlX2N0aW1l
X25zX3hjaGcoaW5vZGUsIGNucywgbm93LnR2X25zZWMsIGN1cik7Cj4gIAkJbWd0aW1lX2NvdW50
ZXJfaW5jKG1nX2N0aW1lX3N3YXBzKTsKPiAgCX0gZWxzZSB7Cj4gQEAgLTI4MjQsNyArMjgyNCw3
IEBAIHN0cnVjdCB0aW1lc3BlYzY0IGlub2RlX3NldF9jdGltZV9jdXJyZW50KHN0cnVjdCBpbm9k
ZSAqaW5vZGUpCj4gIAkJCWdvdG8gcmV0cnk7Cj4gIAkJfQo+ICAJCS8qIE90aGVyd2lzZSwga2Vl
cCB0aGUgZXhpc3RpbmcgY3RpbWUgKi8KPiAtCQlub3cudHZfc2VjID0gaW5vZGUtPmlfY3RpbWVf
c2VjOwo+ICsJCW5vdy50dl9zZWMgPSBSRUFEX09OQ0UoaW5vZGUtPmlfY3RpbWVfc2VjKTsKPiAg
CQlub3cudHZfbnNlYyA9IGN1ciAmIH5JX0NUSU1FX1FVRVJJRUQ7Cj4gIAl9Cj4gIG91dDoK

