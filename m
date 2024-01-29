Return-Path: <linux-fsdevel+bounces-9391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B538409A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D282FB274D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12262154BF3;
	Mon, 29 Jan 2024 15:17:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13974153BD9;
	Mon, 29 Jan 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541465; cv=none; b=Kvh5439OV1CkxPO6rBmSb8mDrY+0vW6t3DfsbE2J+20GNAP7M5U65d458urUPCxYJ7kMMvlRs9RNobqdkbCs4HBh83QkeKtdeXtJg2t5OaXml0OW/T0I8FJLzPhzvUb/8L8D2veqJHjkOrtDa3eb1LQ9O7un1IpbcfnCXckuQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541465; c=relaxed/simple;
	bh=+e4MeMpVtatRr9w5a834UwxLCgYT7m+gxxbS5zk3y0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gOZuWGajQBoNU1NNqU4+VAkbRgtJH9ZHV9f2mJtfTykAVsknkgXsOwcRB06JoOwuYGoq3F98/5eoh6S50bYaRbPqmfMS5zp4uDXfkcTumyepShphtkzPEE3EQLoP79nXRClYuDegY54Z3KjeRYsBMNhYr6vULQdtMiE1JIaVgzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.77.58] ) by
 ajax-webmail-mail-app4 (Coremail) ; Mon, 29 Jan 2024 23:17:28 +0800
 (GMT+08:00)
Date: Mon, 29 Jan 2024 23:17:28 +0800 (GMT+08:00)
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
In-Reply-To: <DCBF7671-E982-49F2-8687-DF030D2A99C7@dubeyko.com>
References: <20240122172719.3843098-1-alexious@zju.edu.cn>
 <F36C0C80-DAF3-4D8F-8EA3-5209E8FB5BE3@dubeyko.com>
 <38fd9f3.214a.18d5548ac0c.Coremail.alexious@zju.edu.cn>
 <DCBF7671-E982-49F2-8687-DF030D2A99C7@dubeyko.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <44665a1c.22c9.18d55cbff19.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3k4KJwbdl8s7EAA--.15305W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAg4PAGW2oGMdygABsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IE9uIDI5IEphbiAyMDI0LCBhdCAxNTo1NCwgYWxleGlvdXNAemp1LmVkdS5jbiB3cm90ZToK
PiA+IAo+ID4+PiBPbiAyMiBKYW4gMjAyNCwgYXQgMjA6MjcsIFpoaXBlbmcgTHUgPGFsZXhpb3Vz
QHpqdS5lZHUuY24+IHdyb3RlOgo+ID4+PiAKPiA+Pj4gV2hlbiB0aGUgc3dpdGNoIHN0YXRtZW50
IGdvZXMgdG8gZGVmYXVsdCBhbmQgcmV0dXJuIGFuIGVycm9yLCBwdHIgc2hvdWxkCj4gPj4+IGJl
IGZyZWVkIHNpbmNlIGl0IGlzIGFsbG9jYXRlZCBpbiBoZnNfZmluZF9pbml0Lgo+ID4+PiAKPiA+
PiAKPiA+PiBEbyB5b3UgaGF2ZSBhbnkgbWVtb3J5IGxlYWtzIHJlcG9ydD8gQ291bGQgeW91IHNo
YXJlIGl0IGluIHRoZSBjb21tZW50cz8KPiA+PiBXaGljaCB1c2UtY2FzZSByZXByb2R1Y2VzIHRo
ZSBpc3N1ZT8gSXQgd2lsbCBiZSBlYXNpZXIgdG8gcmV2aWV3IHRoZSBmaXgKPiA+PiBJZiB5b3Ug
Y2FuIHNoYXJlIHRoZSBwYXRoIG9mIHJlcHJvZHVjdGlvbi4KPiA+PiAKPiA+PiBUaGFua3MsCj4g
Pj4gU2xhdmEuCj4gPiAKPiA+IFdlbGwsIHdlIGZvdW5kIHRoaXMgcG90ZW50aWFsIG1lbW9yeSBs
ZWFrIGJ5IHN0YXRpYyBhbmFseXNpcy4KPiA+IAo+ID4gV2UgZm91bmQgdGhhdCBhbGwgb2YgaGZz
X2ZpbmRfaW5pdCdzIGNhbGxlcnMgd29uJ3QgcmVsZWFzZSBgcHRyYCB3aGVuIAo+ID4gaGZzX2Zp
bmRfaW5pdCBmYWlscywgd2hpbGUgdGhleSB3aWxsIGRvIHJlbGVhc2UgYHB0cmAgd2hlbiBmdW5j
dGlvbnMgCj4gPiB0aGF0IGFmdGVyIGhmc19maW5kX2luaXQgZmFpbHMuIFRoaXMgdGFjdGljIG9i
c2VydmF0aW9uIHN1Z2dlc3RzIHRoYXQKPiA+IGhmc19maW5kX2luaXQgcHJvYmVybHkgc2hvdWxk
IHJlbGVhc2UgYHB0cmAgd2hlbiBpdCBmYWlscywgaS5lLiBpbiB0aGUKPiA+IGRlZmF1bHQgYnJh
bmNoIG9mIHN3aXRjaCBpbiB0aGlzIHBhdGNoLgo+ID4gCj4gPiBCZXNpZGVzLCB3ZSBub3RpY2Vk
IGFub3RoZXIgaW1wbGVtZW50YXRpb24gb2YgaGZzX2ZpbmRfaW5pdCBpbiAKPiA+IGZzL2hmc3Bs
dXMvYmZpbmQuYywgd2hpY2ggaXMgZXNzZW50aWFsbHkgaWRlbnRpY2FsIHRvIHRoZSBvbmUgaW4g
Cj4gPiB0aGlzIHBhdGNoIChpbiBmcy9oZnMvYmZpbmQuYykgYnV0IGNhbGxpbmcgYEJVRygpO2Ag
aW4gZGVmYXVsdCBicmFuY2gKPiA+IHRvIHRyaWdnZXIgYW4gZXJyb3ItaGFuZGxpbmcuCj4gPiAK
PiAKPiBJIHNlZS4gSSBiZWxpZXZlIGl0IG1ha2VzIHNlbnNlIHRvIGFkZCBhbGwgb2YgdGhpcyBl
eHBsYW5hdGlvbgo+IGludG8gY29tbWVudCBzZWN0aW9uLiBNb2RpZmljYXRpb24gbG9va3MgZ29v
ZC4gTW9zdGx5LCBoZnNfZmluZF9leGl0KCkKPiBkb2VzIGZyZWVpbmcgcmVzb3VyY2VzIGFuZCBp
ZiBoZnNfZmluZF9pbml0KCkgZmFpbHMsIHRoZW4gaGZzX2ZpbmRfZXhpdCgpCj4gaXMgbmV2ZXIg
Y2FsbGVkLiBNYXliZSwgaXQgbWFrZXMgc2Vuc2UgdG8gc2V0IGZkLT50cmVlID0gTlVMTCB0b28g
YnV0Cj4gaXQgaXMgbm90IGNyaXRpY2FsLCBhcyBmYXIgYXMgSSBjYW4gc2VlLgo+IAo+IENvdWxk
IHlvdSBwbGVhc2UgcmV3b3JrIHRoZSBjb21tZW50IHNlY3Rpb24gb2YgdGhlIHBhdGNoPyAKClN1
cmUsIEknbGwgaW5jbHVkaW5nIHN1Y2ggaWRlYSBpbiB0aGlzIHBhdGNoIGFuZCBzZW5kIGEgdjIg
dmVyc2lvbiBvZiAKdGhpcyBwYXRjaC4KClRoYW5rcywKWmhpcGVuZy4KCj4gVGhhbmtzLAo+IFNs
YXZhLgo=

