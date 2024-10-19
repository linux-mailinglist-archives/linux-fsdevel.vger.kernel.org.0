Return-Path: <linux-fsdevel+bounces-32414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C7E9A4CAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 11:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3803C1F2383E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E401DF27C;
	Sat, 19 Oct 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="OxENbPtI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46E20E30B;
	Sat, 19 Oct 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330623; cv=none; b=q9+txfomZxFhAdVYpTFqp5VczWNnTqEbSBDd5H9TutuwXqAf1XIEiPeKV2PsDC15I+GqaMPfOtELNteZU8/whibnoZ4E3t/7FDhXFzj+rblvSjduN48WhjpLEvUsafR7lo4j0g9UyiIw8/LDNGzdBy67rYM2nEFn0uMjM/LZE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330623; c=relaxed/simple;
	bh=4FyAyNs0RDZLPtAVg0ePE4f4kUHnkDi9sj0QxmXhD7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Av8l2GeIBr753WwIa6jp6/Qn2yhqUXkwnL7xchwGHCJ7IjZk+iw80WAAMimrAys5h2nTyl9pVcfxxPIyXmhfxr8PR8VcNTaze2Ux2ggOI8amMjEXoWeBFmtN+dyDaVBKNKOvi0RmP/Y017UCDI8NyYk9bfaBu2zSlT0h/6ujHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=OxENbPtI; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1729330289;
	bh=4FyAyNs0RDZLPtAVg0ePE4f4kUHnkDi9sj0QxmXhD7w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OxENbPtIykSnrTaA+/ak/OkO/OMy9tJk16QVP4ToWXdwUUpsC6xxXbHYsdFwnkdc3
	 wTPDF1VcSS5yJHEDvRm4ZS6ATTO343j7geZMaFFmKYAlkstpZyS61x/+qSHJHHntQh
	 hKt9MmgH4CLdb8Skn4VqxhrVmFn6kU3lbVPkL/io=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 240921A3F67;
	Sat, 19 Oct 2024 05:31:26 -0400 (EDT)
Message-ID: <cab68955dccebbedbe5ddd84b3fccb542186bdde.camel@xry111.site>
Subject: Re: [PATCH 2/2] vfs: Make sure {statx,fstatat}(..., AT_EMPTY_PATH |
 ..., NULL, ...) behave as (..., AT_EMPTY_PATH | ..., "", ...)
From: Xi Ruoyao <xry111@xry111.site>
To: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miao Wang
	 <shankerwangmiao@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 19 Oct 2024 17:31:25 +0800
In-Reply-To: <20241008042751.GW4017910@ZenIV>
References: <20241007130825.10326-1-xry111@xry111.site>
	 <20241007130825.10326-3-xry111@xry111.site>
	 <CAGudoHHdccL5Lh8zAO-0swqqRCW4GXMSXhq4jQGoVj=UdBK-Lg@mail.gmail.com>
	 <20241008041621.GV4017910@ZenIV> <20241008042751.GW4017910@ZenIV>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTEwLTA4IGF0IDA1OjI3ICswMTAwLCBBbCBWaXJvIHdyb3RlOgo+IE9uIFR1
ZSwgT2N0IDA4LCAyMDI0IGF0IDA1OjE2OjIxQU0gKzAxMDAsIEFsIFZpcm8gd3JvdGU6Cj4gCj4g
PiBGb2xrcywgcGxlYXNlIGRvbid0IGdvIHRoZXJlLsKgIFJlYWxseS7CoCBJTU8gdmZzX2VtcHR5
X3BhdGgoKSBpcyBhIHdyb25nIEFQSQo+ID4gaW4gdGhlIGZpcnN0IHBsYWNlLsKgIFRvbyBsb3ct
bGV2ZWwgYW5kIHJhY3kgYXMgd2VsbC4KPiA+IAo+ID4gCVNlZSB0aGUgYXBwcm9hY2ggaW4gI3dv
cmsueGF0dHI7IEknbSBnb2luZyB0byBsaWZ0IHRoYXQgaW50byBmcy9uYW1laS5jCj4gPiAod2Vs
bCwgdGhlIHNsb3cgcGF0aCAtIGV2ZXJ5dGhpbmcgYWZ0ZXIgImlmIHBhdGggaXMgTlVMTCwgd2Ug
YXJlIGRvbmUiKSBhbmQKPiA+IHllcywgZnMvc3RhdC5jIHVzZXJzIGdldCBoYW5kbGVkIGJldHRl
ciB0aGF0IHdheS4KClNvIElJVUMgSSBqdXN0IG5lZWQgdG8gc2l0IGRvd24gaGVyZSBhbmQgd2Fp
dCBmb3IgeW91ciBicmFuY2ggdG8gYmUKbWVyZ2VkPwoKPiBGV0lXLCB0aGUgaW50ZXJtZWRpYXRl
IChqdXN0IGFmdGVyIHRoYXQgY29tbWl0KSBzdGF0ZSBvZiB0aG9zZSBmdW5jdGlvbnMgaXMKPiAK
PiBpbnQgdmZzX2ZzdGF0YXQoaW50IGRmZCwgY29uc3QgY2hhciBfX3VzZXIgKmZpbGVuYW1lLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IGtzdGF0ICpzdGF0LCBpbnQgZmxhZ3MpCj4gewo+IMKgwqDCoMKgwqDCoMKgIGlu
dCByZXQ7Cj4gwqDCoMKgwqDCoMKgwqAgaW50IHN0YXR4X2ZsYWdzID0gZmxhZ3MgfCBBVF9OT19B
VVRPTU9VTlQ7Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGZpbGVuYW1lICpuYW1lID0gZ2V0bmFt
ZV9tYXliZV9udWxsKGZpbGVuYW1lLCBmbGFncyk7Cj4gCj4gwqDCoMKgwqDCoMKgwqAgaWYgKCFu
YW1lKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdmZzX2ZzdGF0KGRm
ZCwgc3RhdCk7Cj4gCj4gwqDCoMKgwqDCoMKgwqAgcmV0ID0gdmZzX3N0YXR4KGRmZCwgbmFtZSwg
c3RhdHhfZmxhZ3MsIHN0YXQsIFNUQVRYX0JBU0lDX1NUQVRTKTsKPiDCoMKgwqDCoMKgwqDCoCBw
dXRuYW1lKG5hbWUpOyAKPiAKPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0O8KgIAo+IH0KPiAK
PiBhbmQKPiAKPiBTWVNDQUxMX0RFRklORTUoc3RhdHgsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGludCwgZGZkLCBjb25zdCBjaGFyIF9fdXNlciAqLCBmaWxlbmFtZSwgdW5zaWdu
ZWQsIGZsYWdzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQs
IG1hc2ssCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBzdGF0eCBfX3Vz
ZXIgKiwgYnVmZmVyKQo+IHsKPiDCoMKgwqDCoMKgwqDCoCBpbnQgcmV0Owo+IMKgwqDCoMKgwqDC
oMKgIHVuc2lnbmVkIGxmbGFnczsKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZmlsZW5hbWUgKm5h
bWUgPSBnZXRuYW1lX21heWJlX251bGwoZmlsZW5hbWUsIGZsYWdzKTsKPiAKPiDCoMKgwqDCoMKg
wqDCoCAvKgo+IMKgwqDCoMKgwqDCoMKgwqAgKiBTaG9ydC1jaXJjdWl0IGhhbmRsaW5nIG9mIE5V
TEwgYW5kICIiIHBhdGhzLgo+IMKgwqDCoMKgwqDCoMKgwqAgKgo+IMKgwqDCoMKgwqDCoMKgwqAg
KiBGb3IgYSBOVUxMIHBhdGggd2UgcmVxdWlyZSBhbmQgYWNjZXB0IG9ubHkgdGhlIEFUX0VNUFRZ
X1BBVEggZmxhZwo+IMKgwqDCoMKgwqDCoMKgwqAgKiAocG9zc2libHkgfCdkIHdpdGggQVRfU1RB
VFggZmxhZ3MpLgo+IMKgwqDCoMKgwqDCoMKgwqAgKgo+IMKgwqDCoMKgwqDCoMKgwqAgKiBIb3dl
dmVyLCBnbGliYyBvbiAzMi1iaXQgYXJjaGl0ZWN0dXJlcyBpbXBsZW1lbnRzIGZzdGF0YXQgYXMg
c3RhdHgKPiDCoMKgwqDCoMKgwqDCoMKgICogd2l0aCB0aGUgIiIgcGF0aG5hbWUgYW5kIEFUX05P
X0FVVE9NT1VOVCB8IEFUX0VNUFRZX1BBVEggZmxhZ3MuCj4gwqDCoMKgwqDCoMKgwqDCoCAqIFN1
cHBvcnRpbmcgdGhpcyByZXN1bHRzIGluIHRoZSB1Z2xpZmljYXRpb24gYmVsb3cuCj4gwqDCoMKg
wqDCoMKgwqDCoCAqLwo+IMKgwqDCoMKgwqDCoMKgIGxmbGFncyA9IGZsYWdzICYgfihBVF9OT19B
VVRPTU9VTlQgfCBBVF9TVEFUWF9TWU5DX1RZUEUpOwo+IMKgwqDCoMKgwqDCoMKgIGlmICghbmFt
ZSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGRvX3N0YXR4X2ZkKGRm
ZCwgZmxhZ3MgJiB+QVRfTk9fQVVUT01PVU5ULCBtYXNrLCBidWZmZXIpOwo+IAo+IMKgwqDCoMKg
wqDCoMKgIHJldCA9IGRvX3N0YXR4KGRmZCwgbmFtZSwgZmxhZ3MsIG1hc2ssIGJ1ZmZlcik7Cj4g
wqDCoMKgwqDCoMKgwqAgcHV0bmFtZShuYW1lKTsKPiAKPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
cmV0Owo+IH0KPiAKPiBzdGF0aWMgaW5saW5lIHN0cnVjdCBmaWxlbmFtZSAqZ2V0bmFtZV9tYXli
ZV9udWxsKGNvbnN0IGNoYXIgX191c2VyICpuYW1lLCBpbnQgZmxhZ3MpCj4gewo+IMKgwqDCoMKg
wqDCoMKgIGlmICghKGZsYWdzICYgQVRfRU1QVFlfUEFUSCkpCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBnZXRuYW1lKG5hbWUpOwo+IAo+IMKgwqDCoMKgwqDCoMKgIGlm
ICghbmFtZSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7Cj4g
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIF9fZ2V0bmFtZV9tYXliZV9udWxsKG5hbWUpOwo+IH0KPiAK
PiBzdHJ1Y3QgZmlsZW5hbWUgKl9fZ2V0bmFtZV9tYXliZV9udWxsKGNvbnN0IGNoYXIgX191c2Vy
ICpwYXRobmFtZSkKPiB7Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGZpbGVuYW1lICpuYW1lOwo+
IMKgwqDCoMKgwqDCoMKgIGNoYXIgYzsKPiAKPiDCoMKgwqDCoMKgwqDCoCAvKiB0cnkgdG8gc2F2
ZSBvbiBhbGxvY2F0aW9uczsgbG9zcyBvbiB1bSwgdGhvdWdoICovCj4gwqDCoMKgwqDCoMKgwqAg
aWYgKGdldF91c2VyKGMsIHBhdGhuYW1lKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIEVSUl9QVFIoLUVGQVVMVCk7Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKCFjKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsKPiAKPiDCoMKgwqDCoMKg
wqDCoCBuYW1lID0gZ2V0bmFtZV9mbGFncyhwYXRobmFtZSwgTE9PS1VQX0VNUFRZKTsKPiDCoMKg
wqDCoMKgwqDCoCBpZiAoIUlTX0VSUihuYW1lKSAmJiAhKG5hbWUtPm5hbWVbMF0pKSB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB1dG5hbWUobmFtZSk7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG5hbWUgPSBOVUxMOwo+IMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gbmFtZTvCoMKgIAo+IH0KCi0tIApYaSBSdW95YW8gPHhyeTExMUB4
cnkxMTEuc2l0ZT4KU2Nob29sIG9mIEFlcm9zcGFjZSBTY2llbmNlIGFuZCBUZWNobm9sb2d5LCBY
aWRpYW4gVW5pdmVyc2l0eQo=


