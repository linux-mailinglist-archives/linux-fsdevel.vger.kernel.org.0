Return-Path: <linux-fsdevel+bounces-58084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6344B2918F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 06:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4711689C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 04:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A79A1F0E50;
	Sun, 17 Aug 2025 04:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="ZqWuRZOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2D16DEB1;
	Sun, 17 Aug 2025 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755405849; cv=none; b=TIBff+BFtz9tP2hIUKLS8qPdB35npgvBydFTN0cgLi/HLhKoZnM3gO1e+oDlkNn0WDMavLLl7AO5Cv4NSp6S1OmW6ub5X0TVaXaqMgPTEc3SCtihrppEbrhD3tMZ+K6o1n8kmDJkKjFsEZkAy6Y/L9vQoHIi2rFBHFcNSYBlK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755405849; c=relaxed/simple;
	bh=P3VOaa2AHqjcGObv6vHwnEfq1cYCBzytJb2Lv6uoxLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ecrOcRXWupQltifaypoYMbj5WKQY853uGVkxvaMk00F2DG0BGC8Qux++eZQffqdkY/rh0ec4reFI/zarffwOKy6IMjO8DL129S226yz3NKBVwq+FWTnPrlhJ3/yqhW4InwKUYEiPRrdKaPjYh4QxR8Bki6YWv+N5GtduaMKS4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=fail (1024-bit key) header.d=126.com header.i=@126.com header.b=ZqWuRZOH reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=TTUBPNPGlI/pbOhVvgZ3yq4pwbsl1IdZ8XlTgeU2je8=; b=Z
	qWuRZOHVv42DOWA7lmZrS5T2RT7r8sMZgEZd0LkTIKIK8fn/aSVpbiVFwOMdi5e/
	zN14ZRHH3qYUgZO56ujLR6nvRmGcgdHoaV81amxsp9yYf+0zgX/mCedep/aB5nHW
	hnbW0G6kwuceGZ1u7dK7fdiXDppfLdkxFlnTErrbQs=
Received: from nzzhao$126.com ( [112.86.116.50] ) by
 ajax-webmail-wmsvr-41-110 (Coremail) ; Sun, 17 Aug 2025 12:43:11 +0800
 (CST)
Date: Sun, 17 Aug 2025 12:43:11 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Jaegeuk Kim" <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	"Matthew Wilcox" <willy@infradead.org>, "Chao Yu" <chao@kernel.org>,
	"Yi Zhang" <yi.zhang@huawei.com>, "Barry Song" <21cnbao@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re:Re:Re: [f2fs-dev] [RFC PATCH 0/9] f2fs: Enable buffered
 read/write large folios support with extended iomap
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 126com
In-Reply-To: <e81c31e.56a.198a604868e.Coremail.nzzhao@126.com>
References: <20250813092131.44762-1-nzzhao@126.com>
 <aJytvfsMcR2hzWKI@infradead.org>
 <e81c31e.56a.198a604868e.Coremail.nzzhao@126.com>
X-NTES-SC: AL_Qu2eB/ibuk8i5yWRZOkfmUgRgOw3XMSyu/oi2o9UO5FwjDHjwAEMdlNvPmP86+SWEwalmwasXgpj785Bco1jU44bXwcKXxuA31xYV6iKzEAS+w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6be3b4b7.83a.198b656b16c.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bikvCgD3v9XfXaFoM9AbAA--.3364W
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiZBWrz2igkwCEcQAKsx
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ClRoZXJlJ3MgYW5vdGhlciBpbXBvcnRhbnQgcmVhc29uIHRvIHV0aWxpemUgYW4gZjJmc19pb21h
cF9mb2xpb19zdGF0ZS7CoAoKQmVjYXVzZSBmMmZzIGRvZXNuJ3QgcG9zc2VzcyBhIHBlciBibG9j
ayBzdGF0ZSB0cmFja2luZyBkYXRhIHN0cnVjdHVyZSAKbGlrZSBidWZmZXIgaGVhZHMgb3Igc3Vi
cGFnZXMswqBpdCBjYW4ndCB0cmFjayBwZXIgYmxvY2sgZGlydHkgc3RhdGUgb3IgCnJlYWQvd3Jp
dGUgYnl0ZXMgcGVuZGluZyBpdHNlbGYuIEdyb3dpbmcgc3VjaCBhIHN0cnVjdHVyZSBmb3IgZjJm
cyBhbmQgIAphcHBseWluZyBpdCB0byBhbGwgY29kZSBwYXRocyBjb3VsZCBiZSBhIHRyZW1lbmRv
dXMgYW5kIGRlc3RydWN0aXZlIAp0YXNrLsKgCgpTbyBJIHRoaW5rIGl0J3MgY29udmVuaWVudCB0
byBwb3NzZXNzIGFuIGYyZnMgb3duIHBlciBmb2xpbyAKcHJpdmF0ZSBkYXRhIHN0cnVjdHVyZSB0
aGF0IGNhbiBib3RoIGJlIGNvbXBhdGlibGXCoAp3aXRoIGlvbWFwIGFuZCBmMmZzJ3MgIG5lZWRz
LCBlc3BlY2lhbGx5IGhlbHBmdWwgZm9yIG90aGVyIGYyZnMncyBpL28gcGF0aHMKIHRoYXQgbmVl
ZCB0byAgc3VwcG9ydMKgbGFyZ2UgZm9saW9zIGFsdG9nZXRoZXIgd2l0aCBidWZmZXJlZCBpbyBi
dXQgY2FuJ3QgCmdvIGludG8gaW9tYXAgIHBhdGggKGkuZS4sIGdhcmJhZ2UgY29sbGVjdGlvbiku
CgogSXQgY2FuIGFsc28gYmUgZXh0ZW5kZWQgd2l0aCBmaWVsZHMgdG8KIG1lZXQgdGhlIG5lZWRz
IG9mIG90aGVyIHR5cGVzIG9mIGYyZnMgZmlsZXMgKGUuZy4sIGNvbXByZXNzZWQgZmlsZXMpIGlm
CiB0aGV5IG5lZWQgdG8gc3VwcG9ydCBsYXJnZSBmb2xpb3MgdG9vLgoKCgoKCkF0IDIwMjUtMDgt
MTQgMDg6Mzk6MzEsICLotbXljZflk7IgIiA8bnp6aGFvQDEyNi5jb20+IHdyb3RlOgo+SGkgTXIu
Q2hyaXN0b3BoLAo+Cj5UaGFua3MgZm9yIHRoZSBxdWljayBmZWVkYmFjayEKPgo+PiBUaGF0J3Mg
cHJldHR5IHVnbHkuICBXaGF0IGFkZGl0aW9uYWwgZmxhZ3MgZG8geW91IG5lZWQ/ICAKPgo+RjJG
UyBjYW4gdXRpbGl6ZSB0aGUgZm9saW8ncyBwcml2YXRlIGZpZWxkIGluIGEgbm9uLXBvaW50ZXIg
bW9kZSB0byBzdG9yZSBpdHMgZXh0cmEgZmxhZ3MsIHdoaWNoIGluZGljYXRlIHRoZSBmb2xpbydz
IGFkZGl0aW9uYWwgc3RhdHVzLiAKPlBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGUgZjJmcy5oIGZp
bGUgZnJvbSBQQUdFX1BSSVZBVEVfR0VUX0ZVTkMgdG8gdGhlIGVuZCBvZiBjbGVhcl9wYWdlX3By
aXZhdGVfYWxsKCkuCj4KPlRoZXNlIGZsYWdzIHBlcnNpc3QgdGhyb3VnaG91dCB0aGUgZW50aXJl
IGxpZmV0aW1lIG9mIGEgZm9saW8sIHdoaWNoIGNvbmZsaWN0cyB3aXRoIHRoZSBpb21hcF9mb2xp
b19zdGF0ZSBwb2ludGVyLgo+Q3VycmVudGx5LCB0aGUgcHJpdmF0ZSBmaWVsZHMgb2YgaW9tYXAn
cyBleGlzdGluZyBkYXRhIHN0cnVjdHVyZXMsbmFtZWx5IHN0cnVjdCBpb21hcCdzIHByaXZhdGUs
IHN0cnVjdCBpb21hcF9pdGVyJ3MgcHJpdmF0ZSwgCj5hbmQgc3RydWN0IGlvbWFwX2lvZW5kJ3Mg
aW9fcHJpdmF0ZSxhcmUgZWl0aGVyIGFsbG9jYXRlZCBsb2NhbGx5IG9uIHRoZSBzdGFjayBvciBo
YXZlIGEgbGlmZWN5Y2xlIG9uIHRoZSBoZWFwIHRoYXQgb25seSBleGlzdHMgCj5mb3IgdGhlIGR1
cmF0aW9uIG9mIHRoZSBJL08gcm91dGluZS4gVGhpcyBjYW5ub3QgbWVldCBGMkZTJ3MgcmVxdWly
ZW1lbnRzLgo+Cj4+IFdlIHNob3VsZCAgdHJ5IHRvIGZpZ3VyZSBvdXQgaWYgdGhlcmUgaXMgYSBz
ZW5zaWJsZSB3YXkgdG8gc3VwcG9ydCB0aGUgbmVlZHMKPj4gd2l0aCBhIHNpbmdsZSBjb2RlYmFz
ZSBhbmQgZGF0YSBzdHJ1Y3R1cmUuCj4KPkFzIGZhciBhcyBJIGtub3csIG9ubHkgRjJGUyBoYXMg
dGhpcyByZXF1aXJlbWVudCwgd2hpbGUgb3RoZXIgZmlsZSBzeXN0ZW1zIGRvIG5vdC4gCj5UaGVy
ZWZvcmUsIG15IGluaXRpYWwgdGhvdWdodCB3YXMgdG8gYXZvaWQgZGlyZWN0bHkgbW9kaWZ5aW5n
IHRoZSBnZW5lcmljIGxvZ2ljIGluIGZzL2lvbWFwLiBJbnN0ZWFkLCBJIHByb3Bvc2UgZGVzaWdu
aW5nIAo+YSB3cmFwcGVyIHN0cnVjdHVyZSBmb3IgaW9tYXBfZm9saW9fc3RhdGUgc3BlY2lmaWNh
bGx5IGZvciBGMkZTIHRvIHNhdGlzZnkgYm90aCBpb21hcCdzIGFuZCBGMkZTJ3Mgb3duIG5lZWRz
Lgo+Cj5Bbm90aGVyIGlzc3VlIGlzIHRoZSBoYW5kbGluZyBvZiBvcmRlci0wIGZvbGlvcy4gU2lu
Y2UgdGhlIGlvbWFwIGZyYW1ld29yayBkb2VzIG5vdCBhbGxvY2F0ZSBhbiBpb21hcF9mb2xpb19z
dGF0ZSBmb3IgdGhlc2UgZm9saW9zLCAKPkYyRlMgd2lsbCBhbHdheXMgc3RvcmVzIGl0cyBwcml2
YXRlIGZsYWdzIGluIHRoZSBmb2xpby0+cHJpdmF0ZSBmaWVsZC4gVGhlbiBpb21hcCBmcmFtZXdv
cmsgd291bGQgbWlzdGFrZW5seSBpbnRlcnByZXQgdGhlc2UgZmxhZ3MgYXMgYSBwb2ludGVyLiAK
Pgo+SWYgd2UgYXJlIHRvIHNvbHZlIHRoaXMgaXNzdWUgaW4gZ2VuZXJpYyBpb21hcCBsYXllciwg
YSBtaW5pbWFsIGNoYW5nZXMgbWV0aG9kIHRvIGlvbWFwIGZyYW1ld29yayBJIHN1cHBvc2UgaXMg
dG8gbGV0IGlvbWFwIGxvZ2ljIGNhbgo+Ym90aCBkaXN0aW5ndWlzaCBwb2ludGVyIGFuZCBub24g
cG9pbnRlciBtb2RlIG9mIGZvbGlvLT5wcml2YXRlLiBXZSBzaG91bGQgYWxzbyBhZGQgYSBwcml2
YXRlIGZpZWxkIHRvIGlvbWFwX2ZvbGlvX3N0YXRlICwgb3IgZXh0ZW5kIGhlIHN0YXRlIAo+Zmxl
eGlibGUgYXJyYXkgdG8gc3RvcmUgdGhlIGV4dHJhIGluZm9tYXRpb24uIElmIGlvbWFwIGRldGVj
dHMgYSBvcmRlcj4wIGZvbGlvJ3MgZm9saW8tPnByaXZhdGUgaXMgdXNlZCBpbiBub24gcG9pbnRl
ciBtb2RlLCB0aGVuIGl0IHN0b3JlIHRoZSBmbGFncyBpbiBhIG5ld2x5IAo+YWxsb2N0ZWQgaW9t
YXBfZm9saW9fc3RhdGUgZmlyc3QgLCBjbGVhciB0aGUgcHJpdmF0ZSBmaWVsZCBhbmQgdGhlbiBz
dG9yZSdzIGl0cyBhZGRyZXNzIGluIGl0Lgo+Cj5QLlMuICBJIGp1c3Qgbm90aWNlZCB5b3UgZGlk
bid0IHJlcGx5IHZpYSBteSByZXNlbmQgcGF0Y2guIEkgbWlzc3BlbGxlZCBmMmZzJ3Mgc3Vic3l0
ZW0gbWFpbCBhZGRyZXNzIGluIHRoZSBvcmlnaW5hbCBwYXRjaCBhbmQgSSBzaW5jZXJlbHkgYXBv
bG9naXplIGZvciB0aGF0Lgo+SSBhbHJlYWR5IHJlLXNlbnQgdGhlIHNlcmllcyBhcyAgCj4gIltm
MmZzLWRldl0gW1JFU0VORCBSRkMgUEFUQ0ggMC85XSBmMmZzOiBFbmFibGUgYnVmZmVyZWQgcmVh
ZC93cml0ZSBsYXJnZSBmb2xpb3Mgc3VwcG9ydCB3aXRoIGV4dGVuZGVkIGlvbWFwIgo+Q291bGQg
d2UgY29udGludWUgdGhlIGRpc2N1c3Npb24gb24gdGhhdCB0aHJlYWQgc28gdGhlIHJpZ2h0IGxp
c3QgZ2V0cyB0aGUKPmZ1bGwgY29udGV4dD8gIFRoYW5rcyEKPgo+QmVzdCByZWdhcmRzLAo+TmFu
emhlIFpoYW8KPgo+QXQgMjAyNS0wOC0xMyAyMzoyMjozNywgIkNocmlzdG9waCBIZWxsd2lnIiA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Pk9uIFdlZCwgQXVnIDEzLCAyMDI1IGF0IDA1OjIx
OjIyUE0gKzA4MDAsIE5hbnpoZSBaaGFvIHdyb3RlOgo+Pj4gKiAqKldoeSBleHRlbmRzIGlvbWFw
KioKPj4+ICAgKiBGMkZTIHN0b3JlcyBpdHMgZmxhZ3MgaW4gdGhlIGZvbGlvJ3MgcHJpdmF0ZSBm
aWVsZCwKPj4+ICAgICB3aGljaCBjb25mbGljdHMgd2l0aCBpb21hcF9mb2xpb19zdGF0ZS4KPj4+
ICAgKiBUbyByZXNvbHZlIHRoaXMsIHdlIGRlc2lnbmVkIGYyZnNfaW9tYXBfZm9saW9fc3RhdGUs
Cj4+PiAgICAgY29tcGF0aWJsZSB3aXRoIGlvbWFwX2ZvbGlvX3N0YXRlJ3MgbGF5b3V0IHdoaWxl
IGV4dGVuZGluZwo+Pj4gICAgIGl0cyBmbGV4aWJsZSBzdGF0ZSBhcnJheSBmb3IgRjJGUyBwcml2
YXRlIGZsYWdzLgo+Pj4gICAqIFdlIHN0b3JlIGEgbWFnaWMgbnVtYmVyIGluIHJlYWRfYnl0ZXNf
cGVuZGluZyB0byBkaXN0aW5ndWlzaAo+Pj4gICAgIHdoZXRoZXIgYSBmb2xpbyB1c2VzIHRoZSBv
cmlnaW5hbCBvciBGMkZTJ3MgaW9tYXBfZm9saW9fc3RhdGUuCj4+PiAgICAgSXQncyBjaG9zZW4g
YmVjYXVzZSBpdCByZW1haW5zIDAgYWZ0ZXIgcmVhZGFoZWFkIGNvbXBsZXRlcy4KPj4KPj5UaGF0
J3MgcHJldHR5IHVnbHkuICBXaGF0IGFkZGl0aW9uYWxzIGZsYWdzIGRvIHlvdSBuZWVkPyAgV2Ug
c2hvdWxkCj4+dHJ5IHRvIGZpZ3VyZSBvdXQgaWYgdGhlcmUgaXMgYSBzZW5zaWJsZSB3YXkgdG8g
c3VwcG9ydCB0aGUgbmVlZHMKPj53aXRoIGEgc2luZ2xlIGNvZGViYXNlIGFuZCBkYXRhIHN0cnVj
dHVyZSBpZiB0aGF0IHRoZSByZXF1aXJlbWVudHMKPj5hcmUgc2Vuc2libGUuCg==

