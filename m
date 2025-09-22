Return-Path: <linux-fsdevel+bounces-62371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF717B8F7DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0A874E1CBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191D2FE598;
	Mon, 22 Sep 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="SuqVWK6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675032FE581;
	Mon, 22 Sep 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529540; cv=none; b=uwSNPdVkhtDsxG0R2DFzIbsYvPxv1sRqteo4YpyZ4VkLrxnxnMsrxC08rUCwqxlGD0aZDZRdJZmH+RzaBEKbNWWSL6xHZn+z1Yul+QxYJMhronUqND/jmvc+K3RaHHN6JNVAmg5eCosyXmb1VN1qkkMsBfUxF82T47WFcu5ooa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529540; c=relaxed/simple;
	bh=Xqi9Sgq4VhejWmgtT4T2+dvvNznH5Kepb1xNlwU3H94=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Czb7z3+jg97iDbAgJ1gJIU3USs+ITOLfgtXJNaHXKcV3mRFhBrgtteo/8ZTdOKUC6wicHIFqR0iN/4k/58PiU4tc4xQw/t18m9KEVrd90tOPCXlh2zBVbtJRwl+rVFVn47jZTSBA4U0QcVX+iK12WfSZrhRDhHrlTxi0JzALY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=SuqVWK6B; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1758529538; x=1790065538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Xqi9Sgq4VhejWmgtT4T2+dvvNznH5Kepb1xNlwU3H94=;
  b=SuqVWK6BgXsxnN2QvqgCabDy3pY8xdWAKfjoUhawaLqB3i4afAXZXaBL
   JoIw4CgdqisWIA8zm4rVBJnRe3J7kodnRLrGm4VhDtQwlDRsWrkt0DX/a
   8AuRr7nU4fLLOszSSLQeFYmkOG941KxBW9zy8IkRMmAol9PApzU0R9Ne8
   0dRhhX/8S51NtqwtK+nu80PxegdZce35LBF6xeUnwbbMakaBXxiIltMxz
   10Xm/1fP5hoIbw9idl1F+jAMrnoT8mEULkvsu+kT3WFRu45vah3IjQhSk
   VSsHzIFDmjAze5HXKHHjEuibcZSAgyitCg5lfRgnE3iJZ3B2pwtna/kL/
   A==;
X-CSE-ConnectionGUID: qa2Kd9FhRdaTc3i4bRSx+A==
X-CSE-MsgGUID: 0r9BXvYNQdW+RBwnztS4SQ==
X-IronPort-AV: E=Sophos;i="6.18,284,1751241600"; 
   d="scan'208";a="3461784"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:25:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:61493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.168:2525] with esmtp (Farcaster)
 id 4a4b0435-8707-4310-ba6e-b30ce0c87a13; Mon, 22 Sep 2025 08:25:36 +0000 (UTC)
X-Farcaster-Flow-ID: 4a4b0435-8707-4310-ba6e-b30ce0c87a13
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 08:25:34 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 22 Sep 2025
 08:25:32 +0000
Date: Mon, 22 Sep 2025 08:25:29 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: David Hildenbrand <david@redhat.com>
CC: Andrei Vagin <avagin@gmail.com>, <linux-fsdevel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
	"Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, Jinjiang Tu
	<tujinjiang@huawei.com>, Suren Baghdasaryan <surenb@google.com>, Penglei
 Jiang <superman.xpt@gmail.com>, Mark Brown <broonie@kernel.org>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] fs/proc/task_mmu: check cur_buf for NULL
Message-ID: <20250922082529.GA13752@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
References: <20250919142106.43527-1-acsjakub@amazon.de>
 <CANaxB-yAOhES6j6VJMDybAJJy8JEXM+ZB+ey4-=QVyLBeTYfrw@mail.gmail.com>
 <20250922072414.GA40409@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
 <17919309-4e13-4ca0-945f-82a2c71e24d2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <17919309-4e13-4ca0-945f-82a2c71e24d2@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: base64

T24gTW9uLCBTZXAgMjIsIDIwMjUgYXQgMDk6NTc6NDhBTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6Cj4gT24gMjIuMDkuMjUgMDk6MjQsIEpha3ViIEFjcyB3cm90ZToKPiA+T24gRnJp
LCBTZXAgMTksIDIwMjUgYXQgMDk6MjI6MTRBTSAtMDcwMCwgQW5kcmVpIFZhZ2luIHdyb3RlOgo+
ID4+T24gRnJpLCBTZXAgMTksIDIwMjUgYXQgNzoyMeKAr0FNIEpha3ViIEFjcyA8YWNzamFrdWJA
YW1hem9uLmRlPiB3cm90ZToKPiA+Pj4KPiA+Pj5XaGVuIFBBR0VNQVBfU0NBTiBpb2N0bCBpbnZv
a2VkIHdpdGggdmVjX2xlbiA9IDAgcmVhY2hlcwo+ID4+PnBhZ2VtYXBfc2Nhbl9iYWNrb3V0X3Jh
bmdlKCksIGtlcm5lbCBwYW5pY3Mgd2l0aCBudWxsLXB0ci1kZXJlZjoKPiA+Pj4KPiA+Pj5bICAg
NDQuOTM2ODA4XSBPb3BzOiBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQsIHByb2JhYmx5IGZvciBu
b24tY2Fub25pY2FsIGFkZHJlc3MgMHhkZmZmZmMwMDAwMDAwMDAwOiAwMDAwIFsjMV0gU01QIERF
QlVHX1BBR0VBTExPQyBLQVNBTiBOT1BUSQo+ID4+PlsgICA0NC45Mzc3OTddIEtBU0FOOiBudWxs
LXB0ci1kZXJlZiBpbiByYW5nZSBbMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDAwMDAwMDAw
N10KPiA+Pj5bICAgNDQuOTM4MzkxXSBDUFU6IDEgVUlEOiAwIFBJRDogMjQ4MCBDb21tOiByZXBy
b2R1Y2VyIE5vdCB0YWludGVkIDYuMTcuMC1yYzYgIzIyIFBSRUVNUFQobm9uZSkKPiA+Pj5bICAg
NDQuOTM5MDYyXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlY
LCAxOTk2KSwgQklPUyByZWwtMS4xNi4zLTAtZ2E2ZWQ2YjcwMWYwYS1wcmVidWlsdC5xZW11Lm9y
ZyAwNC8wMS8yMDE0Cj4gPj4+WyAgIDQ0LjkzOTkzNV0gUklQOiAwMDEwOnBhZ2VtYXBfc2Nhbl90
aHBfZW50cnkuaXNyYS4wKzB4NzQxLzB4YTgwCj4gPj4+Cj4gPj4+PHNuaXAgcmVnaXN0ZXJzLCB1
bnJlbGlhYmxlIHRyYWNlPgo+ID4+Pgo+ID4+PlsgICA0NC45NDY4MjhdIENhbGwgVHJhY2U6Cj4g
Pj4+WyAgIDQ0Ljk0NzAzMF0gIDxUQVNLPgo+ID4+PlsgICA0NC45NDkyMTldICBwYWdlbWFwX3Nj
YW5fcG1kX2VudHJ5KzB4ZWMvMHhmYTAKPiA+Pj5bICAgNDQuOTUyNTkzXSAgd2Fsa19wbWRfcmFu
Z2UuaXNyYS4wKzB4MzAyLzB4OTEwCj4gPj4+WyAgIDQ0Ljk1NDA2OV0gIHdhbGtfcHVkX3Jhbmdl
LmlzcmEuMCsweDQxOS8weDc5MAo+ID4+PlsgICA0NC45NTQ0MjddICB3YWxrX3A0ZF9yYW5nZSsw
eDQxZS8weDYyMAo+ID4+PlsgICA0NC45NTQ3NDNdICB3YWxrX3BnZF9yYW5nZSsweDMxZS8weDYz
MAo+ID4+PlsgICA0NC45NTUwNTddICBfX3dhbGtfcGFnZV9yYW5nZSsweDE2MC8weDY3MAo+ID4+
PlsgICA0NC45NTY4ODNdICB3YWxrX3BhZ2VfcmFuZ2VfbW0rMHg0MDgvMHg5ODAKPiA+Pj5bICAg
NDQuOTU4Njc3XSAgd2Fsa19wYWdlX3JhbmdlKzB4NjYvMHg5MAo+ID4+PlsgICA0NC45NTg5ODRd
ICBkb19wYWdlbWFwX3NjYW4rMHgyOGQvMHg5YzAKPiA+Pj5bICAgNDQuOTYxODMzXSAgZG9fcGFn
ZW1hcF9jbWQrMHg1OS8weDgwCj4gPj4+WyAgIDQ0Ljk2MjQ4NF0gIF9feDY0X3N5c19pb2N0bCsw
eDE4ZC8weDIxMAo+ID4+PlsgICA0NC45NjI4MDRdICBkb19zeXNjYWxsXzY0KzB4NWIvMHgyOTAK
PiA+Pj5bICAgNDQuOTYzMTExXSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzYv
MHg3ZQo+ID4+Pgo+ID4+PnZlY19sZW4gPSAwIGluIHBhZ2VtYXBfc2Nhbl9pbml0X2JvdW5jZV9i
dWZmZXIoKSBtZWFucyBubyBidWZmZXJzIGFyZQo+ID4+PmFsbG9jYXRlZCBhbmQgcC0+dmVjX2J1
ZiByZW1haW5zIHNldCB0byBOVUxMLgo+ID4+Pgo+ID4+PlRoaXMgYnJlYWtzIGFuIGFzc3VtcHRp
b24gbWFkZSBsYXRlciBpbiBwYWdlbWFwX3NjYW5fYmFja291dF9yYW5nZSgpLAo+ID4+PnRoYXQg
cGFnZV9yZWdpb24gaXMgYWx3YXlzIGFsbG9jYXRlZCBmb3IgcC0+dmVjX2J1Zl9pbmRleC4KPiA+
Pj4KPiA+Pj5GaXggaXQgYnkgZXhwbGljaXRseSBjaGVja2luZyBjdXJfYnVmIGZvciBOVUxMIGJl
Zm9yZSBkZXJlZmVyZW5jaW5nLgo+ID4+Pgo+ID4+Pk90aGVyIHNpdGVzIHRoYXQgbWlnaHQgcnVu
IGludG8gc2FtZSBkZXJlZi1pc3N1ZSBhcmUgYWxyZWFkeSAoZGlyZWN0bHkKPiA+Pj5vciB0cmFu
c2l0aXZlbHkpIHByb3RlY3RlZCBieSBjaGVja2luZyBwLT52ZWNfYnVmLgo+ID4+Pgo+ID4+Pk5v
dGU6Cj4gPj4+IEZyb20gUEFHRU1BUF9TQ0FOIG1hbiBwYWdlLCBpdCBzZWVtcyB2ZWNfbGVuID0g
MCBpcyB2YWxpZCB3aGVuIG5vIG91dHB1dAo+ID4+PmlzIHJlcXVlc3RlZCBhbmQgaXQncyBvbmx5
IHRoZSBzaWRlIGVmZmVjdHMgY2FsbGVyIGlzIGludGVyZXN0ZWQgaW4sCj4gPj4+aGVuY2UgaXQg
cGFzc2VzIGNoZWNrIGluIHBhZ2VtYXBfc2Nhbl9nZXRfYXJncygpLgo+ID4+Pgo+ID4+PlRoaXMg
aXNzdWUgd2FzIGZvdW5kIGJ5IHN5emthbGxlci4KPiA+Pj4KPiA+Pj5GaXhlczogNTI1MjZjYTdm
ZGI5ICgiZnMvcHJvYy90YXNrX21tdTogaW1wbGVtZW50IElPQ1RMIHRvIGdldCBhbmQgb3B0aW9u
YWxseSBjbGVhciBpbmZvIGFib3V0IFBURXMiKQo+ID4+PkNjOiBBbmRyZXcgTW9ydG9uIDxha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnPgo+ID4+PkNjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4KPiA+Pj5DYzogVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5jej4KPiA+
Pj5DYzogTG9yZW56byBTdG9ha2VzIDxsb3JlbnpvLnN0b2FrZXNAb3JhY2xlLmNvbT4KPiA+Pj5D
YzogSmluamlhbmcgVHUgPHR1amluamlhbmdAaHVhd2VpLmNvbT4KPiA+Pj5DYzogU3VyZW4gQmFn
aGRhc2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT4KPiA+Pj5DYzogUGVuZ2xlaSBKaWFuZyA8c3Vw
ZXJtYW4ueHB0QGdtYWlsLmNvbT4KPiA+Pj5DYzogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwu
b3JnPgo+ID4+PkNjOiBCYW9saW4gV2FuZyA8YmFvbGluLndhbmdAbGludXguYWxpYmFiYS5jb20+
Cj4gPj4+Q2M6IFJ5YW4gUm9iZXJ0cyA8cnlhbi5yb2JlcnRzQGFybS5jb20+Cj4gPj4+Q2M6IEFu
ZHJlaSBWYWdpbiA8YXZhZ2luQGdtYWlsLmNvbT4KPiA+Pj5DYzogIk1pY2hhxYIgTWlyb3PFgmF3
IiA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+Cj4gPj4+Q2M6IFN0ZXBoZW4gUm90aHdlbGwgPHNm
ckBjYW5iLmF1dWcub3JnLmF1Pgo+ID4+PkNjOiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEu
YW5qdW1AY29sbGFib3JhLmNvbT4KPiA+Pj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4g
Pj4+bGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmcKPiA+Pj5DYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZwo+ID4+PlNpZ25lZC1vZmYtYnk6IEpha3ViIEFjcyA8YWNzamFrdWJAYW1hem9uLmRl
Pgo+ID4+Pgo+ID4+Pi0tLQo+ID4+PiAgZnMvcHJvYy90YXNrX21tdS5jIHwgMyArKysKPiA+Pj4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiA+Pj4KPiA+Pj5kaWZmIC0tZ2l0IGEv
ZnMvcHJvYy90YXNrX21tdS5jIGIvZnMvcHJvYy90YXNrX21tdS5jCj4gPj4+aW5kZXggMjljY2Ew
ZTZkMGZmLi44YzEwYTgxMzVlNzQgMTAwNjQ0Cj4gPj4+LS0tIGEvZnMvcHJvYy90YXNrX21tdS5j
Cj4gPj4+KysrIGIvZnMvcHJvYy90YXNrX21tdS5jCj4gPj4+QEAgLTI0MTcsNiArMjQxNyw5IEBA
IHN0YXRpYyB2b2lkIHBhZ2VtYXBfc2Nhbl9iYWNrb3V0X3JhbmdlKHN0cnVjdCBwYWdlbWFwX3Nj
YW5fcHJpdmF0ZSAqcCwKPiA+Pj4gIHsKPiA+Pj4gICAgICAgICBzdHJ1Y3QgcGFnZV9yZWdpb24g
KmN1cl9idWYgPSAmcC0+dmVjX2J1ZltwLT52ZWNfYnVmX2luZGV4XTsKPiA+Pj4KPiA+Pj4rICAg
ICAgIGlmICghY3VyX2J1ZikKPiA+Pgo+ID4+SSB0aGluayBpdCBpcyBiZXR0ZXIgdG8gY2hlY2sg
IXAtPnZlY19idWYuIEkga25vdyB0aGF0IHZlY19idWZfaW5kZXggaXMKPiA+PmFsd2F5cyAwIGlu
IHRoaXMgY2FzZSwgc28gdGhlcmUgaXMgbm8gZnVuY3Rpb25hbCBkaWZmZXJlbmNlLCBidXQgdGhl
Cj4gPj4hcC0+dmVjX2J1ZiBpcyBtb3JlIHJlYWRhYmxlL29idmlvdXMuCj4gCj4gWWVzLCBwbGVh
c2UgY2hlY2sgcC0+dmVjX2J1ZiBsaWtlIHdlIGRvIGluIHBhZ2VtYXBfc2Nhbl9vdXRwdXQoKS4K
PiAKPiA+Cj4gPkkgY2hvc2UgKCFjdXJfYnVmKSBiZWNhdXNlIGl0IGlzIG1vcmUgJ3BhcmFub2lk
JyB0aGFuICFwLT52ZWNfYnVmLAo+ID5idXQgaGFwcHkgdG8gY2hhbmdlIHRoYXQgaW4gdjIuIEhv
d2V2ZXIsIEkgbm90aWNlZCB0aGF0IHRoZSBwYXRjaCB3YXMKPiA+YWxyZWFkeSBtZXJnZWQgdG8g
bW0taG90Zml4ZXMtdW5zdGFibGUgaW4gWzFdLiBTaG91bGQgSSBzdGlsbCBzZW5kIHRoZQo+ID52
MiB3aXRoIGFkanVzdG1lbnQ/Cj4gCj4gRmVlbCBmcmVlIHRvIHNlbmQgYSBxdWljayBmaXh1cCBp
bmxpbmUgb3IgcmVzZW5kIHRoZSB2Mi4KPiAKPiBBcyBsb25nIGFzIGl0J3Mgbm90IGluIC1zdGFi
bGUgd2UgY2FuIGNoYW5nZSBpdCBhcyB3ZSBwbGVhc2UuCgpHcmVhdCwKCkkgc2NyZXdlZCB1cCB0
aGUgY29tbWl0IHRpdGxlIGluIHYyLCBzbyB2MyBpcyBoZXJlOgpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyNTA5MjIwODIyMDYuNjg4OS0xLWFjc2pha3ViQGFtYXpvbi5kZS8KClRoYW5r
cyB0byBhbGwsCkpha3ViCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVy
IEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRz
ZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQg
Q2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERF
IDM2NSA1MzggNTk3Cg==


