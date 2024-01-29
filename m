Return-Path: <linux-fsdevel+bounces-9374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C7B8405C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3676D1F2147E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0A64CF5;
	Mon, 29 Jan 2024 12:54:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DCF64CDD;
	Mon, 29 Jan 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532861; cv=none; b=B382wpWUXEZOa9EiSvmS5Lr2QmAQaSu5T1KFFHj6dFPERB2m5ekbbtZBxpzjJnI/E3P9WqkH7T1XRtWCkc9QE91xYIpQJ6URGvn8h9gLgL/W4CAcZiOHXZ1YlNUOnx0xR6nzsXo8FNFRlT4gcyo7DApG9VkjJ+xm9vTZD9ymG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532861; c=relaxed/simple;
	bh=Wgrn7ehhZzT7XDm3PPzsk73AYC+R1L3bcS47dve1/DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NIqcWU4e7b2AxLsoUdVWPUkYhIlFLUo2Hj1wdWuooZy+yR2jicLv96Uk3lz58H3MCjD/8S7jN4epZLfGLgG57jVddZ9y9E7ZVncQ+IyQPqIvTp1fbsWrA/ZQzOBL6+mRYFzeZHgAAZTwWqV8FpL+ZFXvNRsIRl3rxL3T+In/sV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.77.58] ) by
 ajax-webmail-mail-app4 (Coremail) ; Mon, 29 Jan 2024 20:54:02 +0800
 (GMT+08:00)
Date: Mon, 29 Jan 2024 20:54:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Viacheslav Dubeyko" <slava@dubeyko.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
	"Desmond Cheong Zhi Xi" <desmondcheongzx@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfs: fix a memleak in hfs_find_init
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <F36C0C80-DAF3-4D8F-8EA3-5209E8FB5BE3@dubeyko.com>
References: <20240122172719.3843098-1-alexious@zju.edu.cn>
 <F36C0C80-DAF3-4D8F-8EA3-5209E8FB5BE3@dubeyko.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <38fd9f3.214a.18d5548ac0c.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3dYXqn7dlRrnDAA--.14989W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgAPAGW2oGMXhwABsM
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IE9uIDIyIEphbiAyMDI0LCBhdCAyMDoyNywgWmhpcGVuZyBMdSA8YWxleGlvdXNAemp1LmVk
dS5jbj4gd3JvdGU6Cj4gPiAKPiA+IFdoZW4gdGhlIHN3aXRjaCBzdGF0bWVudCBnb2VzIHRvIGRl
ZmF1bHQgYW5kIHJldHVybiBhbiBlcnJvciwgcHRyIHNob3VsZAo+ID4gYmUgZnJlZWQgc2luY2Ug
aXQgaXMgYWxsb2NhdGVkIGluIGhmc19maW5kX2luaXQuCj4gPiAKPiAKPiBEbyB5b3UgaGF2ZSBh
bnkgbWVtb3J5IGxlYWtzIHJlcG9ydD8gQ291bGQgeW91IHNoYXJlIGl0IGluIHRoZSBjb21tZW50
cz8KPiBXaGljaCB1c2UtY2FzZSByZXByb2R1Y2VzIHRoZSBpc3N1ZT8gSXQgd2lsbCBiZSBlYXNp
ZXIgdG8gcmV2aWV3IHRoZSBmaXgKPiBJZiB5b3UgY2FuIHNoYXJlIHRoZSBwYXRoIG9mIHJlcHJv
ZHVjdGlvbi4KPiAKPiBUaGFua3MsCj4gU2xhdmEuCgpXZWxsLCB3ZSBmb3VuZCB0aGlzIHBvdGVu
dGlhbCBtZW1vcnkgbGVhayBieSBzdGF0aWMgYW5hbHlzaXMuCgpXZSBmb3VuZCB0aGF0IGFsbCBv
ZiBoZnNfZmluZF9pbml0J3MgY2FsbGVycyB3b24ndCByZWxlYXNlIGBwdHJgIHdoZW4gCmhmc19m
aW5kX2luaXQgZmFpbHMsIHdoaWxlIHRoZXkgd2lsbCBkbyByZWxlYXNlIGBwdHJgIHdoZW4gZnVu
Y3Rpb25zIAp0aGF0IGFmdGVyIGhmc19maW5kX2luaXQgZmFpbHMuIFRoaXMgdGFjdGljIG9ic2Vy
dmF0aW9uIHN1Z2dlc3RzIHRoYXQKaGZzX2ZpbmRfaW5pdCBwcm9iZXJseSBzaG91bGQgcmVsZWFz
ZSBgcHRyYCB3aGVuIGl0IGZhaWxzLCBpLmUuIGluIHRoZQpkZWZhdWx0IGJyYW5jaCBvZiBzd2l0
Y2ggaW4gdGhpcyBwYXRjaC4KCkJlc2lkZXMsIHdlIG5vdGljZWQgYW5vdGhlciBpbXBsZW1lbnRh
dGlvbiBvZiBoZnNfZmluZF9pbml0IGluIApmcy9oZnNwbHVzL2JmaW5kLmMsIHdoaWNoIGlzIGVz
c2VudGlhbGx5IGlkZW50aWNhbCB0byB0aGUgb25lIGluIAp0aGlzIHBhdGNoIChpbiBmcy9oZnMv
YmZpbmQuYykgYnV0IGNhbGxpbmcgYEJVRygpO2AgaW4gZGVmYXVsdCBicmFuY2gKdG8gdHJpZ2dl
ciBhbiBlcnJvci1oYW5kbGluZy4KClRoYW5rcywKWmhpcGVuZy4KCgo+IAo+ID4gRml4ZXM6IGIz
YjIxNzdhMmQ3OSAoImhmczogYWRkIGxvY2sgbmVzdGluZyBub3RhdGlvbiB0byBoZnNfZmluZF9p
bml0IikKPiA+IFNpZ25lZC1vZmYtYnk6IFpoaXBlbmcgTHUgPGFsZXhpb3VzQHpqdS5lZHUuY24+
Cj4gPiAtLS0KPiA+IGZzL2hmcy9iZmluZC5jIHwgMSArCj4gPiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2ZzL2hmcy9iZmluZC5jIGIvZnMvaGZz
L2JmaW5kLmMKPiA+IGluZGV4IGVmOTQ5OGE2ZTg4YS4uN2FhM2I5YWJhNGQxIDEwMDY0NAo+ID4g
LS0tIGEvZnMvaGZzL2JmaW5kLmMKPiA+ICsrKyBiL2ZzL2hmcy9iZmluZC5jCj4gPiBAQCAtMzYs
NiArMzYsNyBAQCBpbnQgaGZzX2ZpbmRfaW5pdChzdHJ1Y3QgaGZzX2J0cmVlICp0cmVlLCBzdHJ1
Y3QgaGZzX2ZpbmRfZGF0YSAqZmQpCj4gPiBtdXRleF9sb2NrX25lc3RlZCgmdHJlZS0+dHJlZV9s
b2NrLCBBVFRSX0JUUkVFX01VVEVYKTsKPiA+IGJyZWFrOwo+ID4gZGVmYXVsdDoKPiA+ICsga2Zy
ZWUoZmQtPnNlYXJjaF9rZXkpOwo+ID4gcmV0dXJuIC1FSU5WQUw7Cj4gPiB9Cj4gPiByZXR1cm4g
MDsKPiA+IC0tIAo+ID4gMi4zNC4xCj4gPiAK

