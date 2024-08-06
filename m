Return-Path: <linux-fsdevel+bounces-25076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B86F948AFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE61C22B36
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697D1BD4E9;
	Tue,  6 Aug 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="McctYRDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F81BCA15;
	Tue,  6 Aug 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931989; cv=none; b=Ki85L0WfWfsTtEhPstY9WZeJY3KtYYkg8vFjIO+pEM/t60gsAS6iUIrmIkEf77Yb5dHCHQRBrDmCDoms7R088857zW/oSL6sWKAJNcB3rFeE+Ieih+kIBo+Wm+Bd1ZGsnI1Ke4n//GJLJkdqLN1V/I+vwor8c3JW2fLG1kQIKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931989; c=relaxed/simple;
	bh=hSogQLcCDIgv8DxuaxzG4fCRh59Kxu2arAuL+km92FA=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CF0Xz4EKw73CJSlDYHf7uIihneH4eWWP5NgPvsU689Z5C7KKZqhXS+9RSHrpEd2b1aR3UngUlrLfW1dYXHYuYezg485/gk65IahsR5qoWUFY3GXTJKRq7s4T/2C315QYWu+bvTTPJ0tE13GMk86dENEpuRMthZeuI09CaoA5VF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=McctYRDD; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722931988; x=1754467988;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=hSogQLcCDIgv8DxuaxzG4fCRh59Kxu2arAuL+km92FA=;
  b=McctYRDDQaKhVrniwVOvEnZzuTom8RPT5AJXEecGuARwWrTKtxhHVpH6
   s+XdG2q+xluo6ZPoC2VmcdTc2eOR8LJ0T3GzAK63ad8y0/oCnAsnfmcJF
   3+/GhZPn82xztXslrSmoPqHeR23w/inyDOqZWxpKE28Up0l4AEmkuZx67
   A=;
X-IronPort-AV: E=Sophos;i="6.09,267,1716249600"; 
   d="scan'208";a="360771049"
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Thread-Topic: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:13:01 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:61873]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.73:2525] with esmtp (Farcaster)
 id 196b9097-d357-43ab-a94c-93e4e2e312dd; Tue, 6 Aug 2024 08:12:59 +0000 (UTC)
X-Farcaster-Flow-ID: 196b9097-d357-43ab-a94c-93e4e2e312dd
Received: from EX19D004EUC002.ant.amazon.com (10.252.51.225) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 6 Aug 2024 08:12:59 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D004EUC002.ant.amazon.com (10.252.51.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 6 Aug 2024 08:12:59 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Tue, 6 Aug 2024 08:12:59 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "jack@suse.cz" <jack@suse.cz>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Durrant, Paul" <pdurrant@amazon.co.uk>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>
Thread-Index: AQHa5xp7YUfIGy2/kUGqgjccLElzprIZFmqAgADMRIA=
Date: Tue, 6 Aug 2024 08:12:59 +0000
Message-ID: <9802ddc299c72b189487fd56668de65a84f7d94b.camel@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
	 <20240805200151.oja474ju4i32y5bj@quack3>
In-Reply-To: <20240805200151.oja474ju4i32y5bj@quack3>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B4D7625E3E83B49B9FCB802F834D4A3@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA4LTA1IGF0IDIyOjAxICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gDQo+
IE9uIE1vbiAwNS0wOC0yNCAxMTozMjozNSwgSmFtZXMgR293YW5zIHdyb3RlOg0KPiA+IEluIHRo
aXMgcGF0Y2ggc2VyaWVzIGEgbmV3IGluLW1lbW9yeSBmaWxlc3lzdGVtIGRlc2lnbmVkIHNwZWNp
ZmljYWxseQ0KPiA+IGZvciBsaXZlIHVwZGF0ZSBpcyBpbXBsZW1lbnRlZC4gTGl2ZSB1cGRhdGUg
aXMgYSBtZWNoYW5pc20gdG8gc3VwcG9ydA0KPiA+IHVwZGF0aW5nIGEgaHlwZXJ2aXNvciBpbiBh
IHdheSB0aGF0IGhhcyBsaW1pdGVkIGltcGFjdCB0byBydW5uaW5nDQo+ID4gdmlydHVhbCBtYWNo
aW5lcy4gVGhpcyBpcyBkb25lIGJ5IHBhdXNpbmcvc2VyaWFsaXNpbmcgcnVubmluZyBWTXMsDQo+
ID4ga2V4ZWMtaW5nIGludG8gYSBuZXcga2VybmVsLCBzdGFydGluZyBuZXcgVk1NIHByb2Nlc3Nl
cyBhbmQgdGhlbg0KPiA+IGRlc2VyaWFsaXNpbmcvcmVzdW1pbmcgdGhlIFZNcyBzbyB0aGF0IHRo
ZXkgY29udGludWUgcnVubmluZyBmcm9tIHdoZXJlDQo+ID4gdGhleSB3ZXJlLiBUbyBzdXBwb3J0
IHRoaXMsIGd1ZXN0IG1lbW9yeSBuZWVkcyB0byBiZSBwcmVzZXJ2ZWQuDQo+ID4gDQo+ID4gR3Vl
c3RtZW1mcyBpbXBsZW1lbnRzIHByZXNlcnZhdGlvbiBhY3Jvc3NzIGtleGVjIGJ5IGNhcnZpbmcg
b3V0IGEgbGFyZ2UNCj4gPiBjb250aWd1b3VzIGJsb2NrIG9mIGhvc3Qgc3lzdGVtIFJBTSBlYXJs
eSBpbiBib290IHdoaWNoIGlzIHRoZW4gdXNlZCBhcw0KPiA+IHRoZSBkYXRhIGZvciB0aGUgZ3Vl
c3RtZW1mcyBmaWxlcy4gQXMgd2VsbCBhcyBwcmVzZXJ2aW5nIHRoYXQgbGFyZ2UNCj4gPiBibG9j
ayBvZiBkYXRhIG1lbW9yeSBhY3Jvc3Mga2V4ZWMsIHRoZSBmaWxlc3lzdGVtIG1ldGFkYXRhIGlz
IHByZXNlcnZlZA0KPiA+IHZpYSB0aGUgS2V4ZWMgSGFuZCBPdmVyIChLSE8pIGZyYW1ld29yayAo
c3RpbGwgdW5kZXIgcmV2aWV3KToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NDAxMTcxNDQ3MDQuNjAyLTEtZ3JhZkBhbWF6b24uY29tLw0KPiA+IA0KPiA+IEZpbGVzeXN0ZW0g
bWV0YWRhdGEgaXMgc3RydWN0dXJlZCB0byBtYWtlIHByZXNlcnZhdGlvbiBhY3Jvc3Mga2V4ZWMN
Cj4gPiBlYXN5OiBpbm9kZXMgYXJlIG9uZSBsYXJnZSBjb250aWd1b3VzIGFycmF5LCBhbmQgZWFj
aCBpbm9kZSBoYXMgYQ0KPiA+ICJtYXBwaW5ncyIgYmxvY2sgd2hpY2ggZGVmaW5lcyB3aGljaCBi
bG9jayBmcm9tIHRoZSBmaWxlc3lzdGVtIGRhdGENCj4gPiBtZW1vcnkgY29ycmVzcG9uZHMgdG8g
d2hpY2ggb2Zmc2V0IGluIHRoZSBmaWxlLg0KPiA+IA0KPiA+IFRoZXJlIGFyZSBhZGRpdGlvbmFs
IGNvbnN0cmFpbnRzL3JlcXVpcmVtZW50cyB3aGljaCBndWVzdG1lbWZzIGFpbXMgdG8NCj4gPiBt
ZWV0Og0KPiA+IA0KPiA+IDEuIFNlY3JldCBoaWRpbmc6IGFsbCBmaWxlc3lzdGVtIGRhdGEgaXMg
cmVtb3ZlZCBmcm9tIHRoZSBrZXJuZWwgZGlyZWN0DQo+ID4gbWFwIHNvIGltbXVuZSBmcm9tIHNw
ZWN1bGF0aXZlIGFjY2Vzcy4gcmVhZCgpL3dyaXRlKCkgYXJlIG5vdCBzdXBwb3J0ZWQ7DQo+ID4g
dGhlIG9ubHkgd2F5IHRvIGdldCBhdCB0aGUgZGF0YSBpcyB2aWEgbW1hcC4NCj4gPiANCj4gPiAy
LiBTdHJ1Y3QgcGFnZSBvdmVyaGVhZCBlbGltaW5hdGlvbjogdGhlIG1lbW9yeSBpcyBub3QgbWFu
YWdlZCBieSB0aGUNCj4gPiBidWRkeSBhbGxvY2F0b3IgYW5kIGhlbmNlIGhhcyBubyBzdHJ1Y3Qg
cGFnZXMuDQo+ID4gDQo+ID4gMy4gUE1EIGFuZCBQVUQgbGV2ZWwgYWxsb2NhdGlvbnMgZm9yIFRM
QiBwZXJmb3JtYW5jZTogZ3Vlc3RtZW1mcw0KPiA+IGFsbG9jYXRlcyBQTUQtc2l6ZWQgcGFnZXMg
dG8gYmFjayBmaWxlcyB3aGljaCBpbXByb3ZlcyBUTEIgcGVyZiAoY2F2ZWF0DQo+ID4gYmVsb3ch
KS4gUFVEIHNpemUgYWxsb2NhdGlvbnMgYXJlIGEgbmV4dCBzdGVwLg0KPiA+IA0KPiA+IDQuIERl
dmljZSBhc3NpZ25tZW50OiBiZWluZyBhYmxlIHRvIHVzZSBndWVzdG1lbWZzIG1lbW9yeSBmb3IN
Cj4gPiBWRklPL2lvbW11ZmQgbWFwcGluZ3MsIGFuZCBhbGxvdyB0aG9zZSBtYXBwaW5ncyB0byBz
dXJ2aXZlIGFuZCBjb250aW51ZQ0KPiA+IHRvIGJlIHVzZWQgYWNyb3NzIGtleGVjLg0KPiANCj4g
VG8gbWUgdGhlIGJhc2ljIGZ1bmN0aW9uYWxpdHkgcmVzZW1ibGVzIGEgbG90IGh1Z2V0bGJmcy4g
Tm93IEkga25vdyB2ZXJ5DQo+IGxpdHRsZSBkZXRhaWxzIGFib3V0IGh1Z2V0bGJmcyBzbyBJJ3Zl
IGFkZGVkIHJlbGV2YW50IGZvbGtzIHRvIENDLiBIYXZlIHlvdQ0KPiBjb25zaWRlcmVkIHRvIGV4
dGVuZCBodWdldGxiZnMgd2l0aCB0aGUgZnVuY3Rpb25hbGl0eSB5b3UgbmVlZCAoc3VjaCBhcw0K
PiBwcmVzZXJ2YXRpb24gYWNyb3NzIGtleGVjKSBpbnN0ZWFkIG9mIGltcGxlbWVudGluZyBjb21w
bGV0ZWx5IG5ldyBmaWxlc3lzdGVtPw0KDQpPb2YsIEkgZm9yZ290IHRvIG1lbnRpb24gaHVnZXRs
YmZzIGluIHRoZSBjb3ZlciBsZXR0ZXIgLSB0aGFua3MgZm9yDQpyYWlzaW5nIHRoaXMhIEluZGVl
ZCwgdGhlcmUgYXJlIHNpbWlsYXJpdGllczogaW4tbWVtb3J5IGZzLCB3aXRoDQpodWdlL2dpZ2Fu
dGljIGFsbG9jYXRpb25zLg0KDQpXZSBkaWQgY29uc2lkZXIgZXh0ZW5kaW5nIGh1Z2V0bGJmcyB0
byBzdXBwb3J0IHBlcnNpc3RlbmNlLCBidXQgdGhlcmUNCmFyZSBkaWZmZXJlbmNlcyBpbiByZXF1
aXJlbWVudHMgd2hpY2ggd2UncmUgbm90IHN1cmUgd291bGQgYmUgcHJhY3RpY2FsDQpvciBkZXNp
cmFibGUgdG8gYWRkIHRvIGh1Z2V0bGJmcy4NCg0KMS4gU2VjcmV0IGhpZGluZzogd2l0aCBndWVz
dG1lbWZzIGFsbCBvZiB0aGUgbWVtb3J5IGlzIG91dCBvZiB0aGUga2VybmVsDQpkaXJlY3QgbWFw
IGFzIGFuIGFkZGl0aW9uYWwgZGVmZW5jZSBtZWNoYW5pc20uIFRoaXMgbWVhbnMgbm8NCnJlYWQo
KS93cml0ZSgpIHN5c2NhbGxzIHRvIGd1ZXN0bWVtZnMgZmlsZXMsIGFuZCBubyBJTyB0byBpdC4g
VGhlIG9ubHkNCndheSB0byBhY2Nlc3MgaXQgaXMgdG8gbW1hcCB0aGUgZmlsZS4NCg0KMi4gTm8g
c3RydWN0IHBhZ2Ugb3ZlcmhlYWQ6IHRoZSBpbnRlbmRlZCB1c2UgY2FzZSBpcyBmb3Igc3lzdGVt
cyB3aG9zZQ0Kc29sZSBqb2IgaXMgdG8gYmUgYSBoeXBlcnZpc29yLCB0eXBpY2FsbHkgZm9yIGxh
cmdlIChtdWx0aS1HaUIpIFZNcywgc28NCnRoZSBtYWpvcml0eSBvZiBzeXN0ZW0gUkFNIHdvdWxk
IGJlIGRvbmF0ZWQgdG8gdGhpcyBmcy4gV2UgZGVmaW5pdGVseQ0KZG9uJ3Qgd2FudCA0IEtpQiBz
dHJ1Y3QgcGFnZXMgaGVyZSBhcyBpdCB3b3VsZCBiZSBhIHNpZ25pZmljYW50DQpvdmVyaGVhZC4g
VGhhdCdzIHdoeSBndWVzdG1lbWZzIGNhcnZlcyB0aGUgbWVtb3J5IG91dCBpbiBlYXJseSBib290
IGFuZA0Kc2V0cyBtZW1ibG9jayBmbGFncyB0byBhdm9pZCBzdHJ1Y3QgcGFnZSBhbGxvY2F0aW9u
LiBJIGRvbid0IGtub3cgaWYNCmh1Z2V0bGJmcyBkb2VzIGFueXRoaW5nIGZhbmN5IHRvIGF2b2lk
IGFsbG9jYXRpbmcgUFRFLWxldmVsIHN0cnVjdCBwYWdlcw0KZm9yIGl0cyBtZW1vcnk/DQoNCjMu
IGd1ZXN0X21lbWZkIGludGVyZmFjZTogRm9yIGNvbmZpZGVudGlhbCBjb21wdXRpbmcgdXNlLWNh
c2VzIHdlIG5lZWQNCnRvIHByb3ZpZGUgYSBndWVzdF9tZW1mZCBzdHlsZSBpbnRlcmZhY2Ugc28g
dGhhdCB0aGVzZSBGRHMgY2FuIGJlIHVzZWQNCmFzIGEgZ3Vlc3RfbWVtZmQgZmlsZSBpbiBLVk0g
bWVtc2xvdHMuIFdvdWxkIHRoZXJlIGJlIGludGVyZXN0IGluDQpleHRlbmRpbmcgaHVnZXRsYmZz
IHRvIGFsc28gc3VwcG9ydCBhIGd1ZXN0X21lbWZkIHN0eWxlIGludGVyZmFjZT8NCg0KNC4gTWV0
YWRhdGEgZGVzaWduZWQgZm9yIHBlcnNpc3RlbmNlOiBndWVzdG1lbWZzIHdpbGwgbmVlZCB0byBr
ZWVwDQpzaW1wbGUgaW50ZXJuYWwgbWV0YWRhdGEgZGF0YSBzdHJ1Y3R1cmVzIChsaW1pdGVkIGFs
bG9jYXRpb25zLCBsaW1pdGVkDQpmcmFnbWVudGF0aW9uKSBzbyB0aGF0IHBhZ2VzIGNhbiBlYXNp
bHkgYW5kIGVmZmljaWVudGx5IGJlIG1hcmtlZCBhcw0KcGVyc2lzdGVudCB2aWEgS0hPLiBTb21l
dGhpbmcgbGlrZSBzbGFiIGFsbG9jYXRpb25zIHdvdWxkIHByb2JhYmx5IGJlIGENCm5vLWdvIGFz
IHRoZW4gd2UnZCBuZWVkIHRvIHBlcnNpc3QgYW5kIHJlY29uc3RydWN0IHRoZSBzbGFiIGFsbG9j
YXRvci4gSQ0KZG9uJ3Qga25vdyBob3cgaHVnZXRsYmZzIHN0cnVjdHVyZXMgaXRzIGZzIG1ldGFk
YXRhIGJ1dCBJJ20gZ3Vlc3NpbmcgaXQNCnVzZXMgdGhlIHNsYWIgYW5kIGRvZXMgbG90cyBvZiBz
bWFsbCBhbGxvY2F0aW9ucyBzbyB0cnlpbmcgdG8gcmV0cm9maXQNCnBlcnNpc3RlbmNlIHZpYSBL
SE8gdG8gaXQgbWF5IGJlIGNoYWxsZW5naW5nLg0KDQo1LiBJbnRlZ3JhdGlvbiB3aXRoIHBlcnNp
c3RlbnQgSU9NTVUgbWFwcGluZ3M6IHRvIGtlZXAgRE1BIHJ1bm5pbmcNCmFjcm9zcyBrZXhlYywg
aW9tbXVmZCBuZWVkcyB0byBrbm93IHRoYXQgdGhlIGJhY2tpbmcgbWVtb3J5IGZvciBhbiBJT0FT
DQppcyBwZXJzaXN0ZW50IHRvby4gVGhlIGlkZWEgaXMgdG8gZG8gc29tZSBETUEgcGlubmluZyBv
ZiBwZXJzaXN0ZW50DQpmaWxlcywgd2hpY2ggd291bGQgcmVxdWlyZSBpb21tdWZkL2d1ZXN0bWVt
ZnMgaW50ZWdyYXRpb24gLSB3b3VsZCB3ZQ0Kd2FudCB0byBhZGQgdGhpcyB0byBodWdldGxiZnM/
DQoNCjYuIFZpcnR1YWxpc2F0aW9uLXNwZWNpZmljIEFQSXM6IHN0YXJ0aW5nIHRvIGdldCBhIGJp
dCBlc290ZXJpYyBoZXJlLA0KYnV0IHVzZS1jYXNlcyBsaWtlIGJlaW5nIGFibGUgdG8gY2FydmUg
b3V0IHNwZWNpZmljIGNodW5rcyBvZiBtZW1vcnkNCmZyb20gYSBydW5uaW5nIFZNIGFuZCB0dXJu
IGl0IGludG8gbWVtb3J5IGZvciBhbm90aGVyIHNpZGUgY2FyIFZNLCBvcg0KZG9pbmcgcG9zdC1j
b3B5IExNIHZpYSBETUEgYnkgbWFwcGluZyBtZW1vcnkgaW50byB0aGUgSU9NTVUgYnV0IHRha2lu
Zw0KcGFnZSBmYXVsdHMgb24gdGhlIENQVS4gVGhpcyBtYXkgcmVxdWlyZSB2aXJ0dWFsaXNhdGlv
bi1zcGVjaWZpYyBpb2N0bHMNCm9uIHRoZSBmaWxlcyB3aGljaCB3b3VsZG4ndCBiZSBnZW5lcmFs
bHkgYXBwbGljYWJsZSB0byBodWdldGxiZnMuDQoNCjcuIE5VTUEgY29udHJvbDogYSByZXF1aXJl
bWVudCBpcyB0byBhbHdheXMgaGF2ZSBjb3JyZWN0IE5VTUEgYWZmaW5pdHkuDQpXaGlsZSBjdXJy
ZW50bHkgbm90IGltcGxlbWVudGVkIHRoZSBpZGVhIGlzIHRvIGV4dGVuZCB0aGUgZ3Vlc3RtZW1m
cw0KYWxsb2NhdGlvbiB0byBzdXBwb3J0IHNwZWNpZnlpbmcgYWxsb2NhdGlvbiBzaXplcyBmcm9t
IGVhY2ggTlVNQSBub2RlIGF0DQplYXJseSBib290LCBhbmQgdGhlbiBoYXZpbmcgbXVsdGlwbGUg
bW91bnQgcG9pbnRzLCBvbmUgcGVyIE5VTUEgbm9kZSAob3INCnNvbWV0aGluZyBsaWtlIHRoYXQu
Li4pLiBVbmNsZWFyIGlmIHRoaXMgaXMgc29tZXRoaW5nIGh1Z2V0bGJmcyB3b3VsZA0Kd2FudC4N
Cg0KVGhlcmUgYXJlIHByb2JhYmx5IG1vcmUgcG90ZW50aWFsIGlzc3VlcywgYnV0IHRob3NlIGFy
ZSB0aGUgb25lcyB0aGF0DQpjb21lIHRvIG1pbmQuLi4gVGhhdCBiZWluZyBzYWlkLCBpZiBodWdl
dGxiZnMgbWFpbnRhaW5lcnMgYXJlIGludGVyZXN0ZWQNCmluIGdvaW5nIGluIHRoaXMgZGlyZWN0
aW9uIHRoZW4gd2UgY2FuIGRlZmluaXRlbHkgbG9vayBhdCBlbmhhbmNpbmcNCmh1Z2V0bGJmcy4N
Cg0KSSB0aGluayB0aGVyZSBhcmUgdHdvIHR5cGVzIG9mIHByb2JsZW1zOiAiV291bGQgaHVnZXRs
YmZzIHdhbnQgdGhpcw0KZnVuY3Rpb25hbGl0eT8iIC0gdGhhdCdzIHRoZSBtYWpvcml0eS4gQW4g
YSBmZXcgYXJlICJUaGlzIHdvdWxkIGJlIGhhcmQNCndpdGggaHVnZXRsYmZzISIgLSBwZXJzaXN0
ZW5jZSBwcm9iYWJseSBmYWxscyBpbnRvIHRoaXMgY2F0ZWdvcnkuDQoNCkxvb2tpbmcgZm9yd2Fy
ZCB0byBpbnB1dCBmcm9tIG1haW50YWluZXJzLiA6LSkNCg0KSkcNCg==

