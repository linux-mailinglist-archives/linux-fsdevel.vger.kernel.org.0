Return-Path: <linux-fsdevel+bounces-33465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5589B915F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996021F21570
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD7419EED4;
	Fri,  1 Nov 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rR9aCURY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F5199E94;
	Fri,  1 Nov 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465709; cv=none; b=ugmhpVJhsBSu763ZCVeacfD1Ph08TG+cZEwcvk8ATdIDV0sYLWP+Hm7iStvj2qt1aqQXLPRCIXH8vF4fbsTo6bs1UAHRPahP1R59e8HpYMaOFQ6LCUFGcAl9R4MK7bd389fBZQhaLO39wU/T9LVmPOBJttn6wG0qDg8+XE+zVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465709; c=relaxed/simple;
	bh=NW1aUg5kdRLrg8heldWb079SMbDLskn0KR8BJQyQ9Sc=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9JaJXh6mJtIBjKraGxhB/eb8DWkDZwfsAqDcXFOGk55/CnfS2Am9IWczjFvU2hbCaLzWSSKkigdAYKJafSlNhw+i5/fG8iJ32OyfUuRmTj3/GVT+HGk7NcrLIWwyZH8AfFUNG1AUlYcsVT2zG1/PjmXU+56hOnu3s8DTx0feEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rR9aCURY; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730465708; x=1762001708;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=NW1aUg5kdRLrg8heldWb079SMbDLskn0KR8BJQyQ9Sc=;
  b=rR9aCURYzUBD1FYZ36cWpP2jorvfcivsZFhUjrHyAVNDDaf0GyxB8rnB
   XC+A3Kuf5GkZO6u7sjvmYaSM4iePdW0aYSdmtebiUcBv6OVvK8sNBCfpK
   BN0BaNoovCmTMKuhC3W2L8bhDsaQ++0u/8hKVg6Q0kktockwd/hAwl5hT
   c=;
X-IronPort-AV: E=Sophos;i="6.11,249,1725321600"; 
   d="scan'208";a="348611607"
Subject: Re: [PATCH 05/10] guestmemfs: add file mmap callback
Thread-Topic: [PATCH 05/10] guestmemfs: add file mmap callback
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 12:55:06 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:36541]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.191:2525] with esmtp (Farcaster)
 id 96d808fa-6ee9-49a7-9811-aef3290e246f; Fri, 1 Nov 2024 12:55:04 +0000 (UTC)
X-Farcaster-Flow-ID: 96d808fa-6ee9-49a7-9811-aef3290e246f
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 12:55:04 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 12:55:04 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Fri, 1 Nov 2024 12:55:04 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "fvdl@google.com"
	<fvdl@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Saenz
 Julienne, Nicolas" <nsaenz@amazon.es>, "Durrant, Paul"
	<pdurrant@amazon.co.uk>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Thread-Index: AQHbKlc3IZ2PqNLJ5E+mkZOTFQYr3bKf3peAgAKHQgA=
Date: Fri, 1 Nov 2024 12:55:04 +0000
Message-ID: <a6a39b440b969318b446ddf862f9a6a235b8c6da.camel@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
	 <20240805093245.889357-6-jgowans@amazon.com>
	 <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
	 <CAPTztWYZtO6Bfphdrfr6Pbc-v4WAgCG+iCJJK26aS1f1AdNbVw@mail.gmail.com>
In-Reply-To: <CAPTztWYZtO6Bfphdrfr6Pbc-v4WAgCG+iCJJK26aS1f1AdNbVw@mail.gmail.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <47F577D2C0FBAD49B2D929C65198B9FB@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTEwLTMwIGF0IDE1OjE4IC0wNzAwLCBGcmFuayB2YW4gZGVyIExpbmRlbiB3
cm90ZToNCj4gT24gVHVlLCBPY3QgMjksIDIwMjQgYXQgNDowNuKAr1BNIEVsbGlvdCBCZXJtYW4g
PHF1aWNfZWJlcm1hbkBxdWljaW5jLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9uLCBBdWcg
MDUsIDIwMjQgYXQgMTE6MzI6NDBBTSArMDIwMCwgSmFtZXMgR293YW5zIHdyb3RlOg0KPiA+ID4g
TWFrZSB0aGUgZmlsZSBkYXRhIHVzYWJsZSB0byB1c2Vyc3BhY2UgYnkgYWRkaW5nIG1tYXAuIFRo
YXQncyBhbGwgdGhhdA0KPiA+ID4gUUVNVSBuZWVkcyBmb3IgZ3Vlc3QgUkFNLCBzbyB0aGF0J3Mg
YWxsIGJlIGJvdGhlciBpbXBsZW1lbnRpbmcgZm9yIG5vdy4NCj4gPiA+IA0KPiA+ID4gV2hlbiBt
bWFwaW5nIHRoZSBmaWxlIHRoZSBWTUEgaXMgbWFya2VkIGFzIFBGTk1BUCB0byBpbmRpY2F0ZSB0
aGF0IHRoZXJlDQo+ID4gPiBhcmUgbm8gc3RydWN0IHBhZ2VzIGZvciB0aGUgbWVtb3J5IGluIHRo
aXMgVk1BLiBSZW1hcF9wZm5fcmFuZ2UoKSBpcw0KPiA+ID4gdXNlZCB0byBhY3R1YWxseSBwb3B1
bGF0ZSB0aGUgcGFnZSB0YWJsZXMuIEFsbCBQVEVzIGFyZSBwcmUtZmF1bHRlZCBpbnRvDQo+ID4g
PiB0aGUgcGd0YWJsZXMgYXQgbW1hcCB0aW1lIHNvIHRoYXQgdGhlIHBndGFibGVzIGFyZSB1c2Fi
bGUgd2hlbiB0aGlzDQo+ID4gPiB2aXJ0dWFsIGFkZHJlc3MgcmFuZ2UgaXMgZ2l2ZW4gdG8gVkZJ
TydzIE1BUF9ETUEuDQo+ID4gDQo+ID4gVGhhbmtzIGZvciBzZW5kaW5nIHRoaXMgb3V0ISBJJ20g
Z29pbmcgdGhyb3VnaCB0aGUgc2VyaWVzIHdpdGggdGhlDQo+ID4gaW50ZW50aW9uIHRvIHNlZSBo
b3cgaXQgbWlnaHQgZml0IHdpdGhpbiB0aGUgZXhpc3RpbmcgZ3Vlc3RfbWVtZmQgd29yaw0KPiA+
IGZvciBwS1ZNL0NvQ28vR3VueWFoLg0KPiA+IA0KPiA+IEl0IG1pZ2h0J3ZlIGJlZW4gbWVudGlv
bmVkIGluIHRoZSBNTSBhbGlnbm1lbnQgc2Vzc2lvbiAtLSB5b3UgbWlnaHQgYmUNCj4gPiBpbnRl
cmVzdGVkIHRvIGpvaW4gdGhlIGd1ZXN0X21lbWZkIGJpLXdlZWtseSBjYWxsIHRvIHNlZSBob3cg
d2UgYXJlDQo+ID4gb3ZlcmxhcHBpbmcgWzFdLg0KPiA+IA0KPiA+IFsxXTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcva3ZtL2FlNzk0ODkxLWZlNjktNDExYS1iODJlLTY5NjNiNTk0YTYyYUByZWRo
YXQuY29tL1QvDQo+ID4gDQo+ID4gLS0tDQo+ID4gDQo+ID4gV2FzIHRoZSBkZWNpc2lvbiB0byBw
cmUtZmF1bHQgZXZlcnl0aGluZyBiZWNhdXNlIGl0IHdhcyBjb252ZW5pZW50IHRvIGRvDQo+ID4g
b3Igb3RoZXJ3aXNlIGludGVudGlvbmFsbHkgZGlmZmVyZW50IGZyb20gaHVnZXRsYj8NCj4gPiAN
Cj4gDQo+IEl0J3MgbWVtb3J5IHRoYXQgaXMgcGxhY2VkIG91dHNpZGUgb2Ygb2YgcGFnZSBhbGxv
Y2F0b3IgY29udHJvbCwgb3INCj4gZXZlbiBvdXRzaWRlIG9mIFN5c3RlbSBSQU0gLSBWTV9QRk5N
QVAgb25seS4gU28geW91IGRvbid0IGhhdmUgbXVjaCBvZg0KPiBhIGNob2ljZS4uDQo+IA0KPiBJ
biBnZW5lcmFsLCBmb3IgdGhpbmdzIGxpa2UgZ3Vlc3QgbWVtb3J5IG9yIHBlcnNpc3RlbnQgbWVt
b3J5LCBldmVuIGlmDQo+IHN0cnVjdCBwYWdlcyB3ZXJlIGF2YWlsYWJsZSwgaXQgZG9lc24ndCBz
ZWVtIGFsbCB0aGF0IHVzZWZ1bCB0byBhZGhlcmUNCj4gdG8gdGhlICFNQVBfUE9QVUxBVEUgc3Rh
bmRhcmQsIHdoeSBnbyB0aHJvdWdoIGFueSBmYXVsdHMgdG8gYmVnaW4NCj4gd2l0aD8NCj4gDQo+
IEZvciBndWVzdF9tZW1mZDogYXMgSSB1bmRlcnN0YW5kIGl0LCBpdCdzIGZvbGlvLWJhc2VkLiBB
bmQgdGhpcyBpcw0KPiBWTV9QRk5NQVAgbWVtb3J5IHdpdGhvdXQgc3RydWN0IHBhZ2VzIC8gZm9s
aW9zLiBTbyB0aGUgbWFpbiB0YXNrIHRoZXJlDQo+IGlzIHByb2JhYmx5IHRvIHRlYWNoIGd1ZXN0
X21lbWZkIGFib3V0IFZNX1BGTk1BUCBtZW1vcnkuIFRoYXQgd291bGQgYmUNCj4gZ3JlYXQsIHNp
bmNlIGl0IHRoZW4gdGllcyBpbiBndWVzdF9tZW1mZCB3aXRoIGV4dGVybmFsIGd1ZXN0IG1lbW9y
eS4NCg0KRXhhY3RseSAtIEkgdGhpbmsgYWxsIG9mIHRoZSBjb21tZW50cyBvbiB0aGlzIHNlcmll
cyBhcmUgaGVhZGluZyBpbiBhDQpzaW1pbGFyIGRpcmVjdGlvbjogbGV0J3MgYWRkIGEgY3VzdG9t
IHJlc2VydmVkIChQRk5NQVApIHBlcnNpc3RlbnQNCm1lbW9yeSBhbGxvY2F0b3IgYmVoaW5kIGd1
ZXN0X21lbWZkIGFuZCBleHBvc2UgdGhhdCBhcyBhIGZpbGVzeXN0ZW0uDQpUaGlzIHdpbGwgYmUg
d2hhdCB0aGUgbmV4dCB2ZXJzaW9uIG9mIHBhdGNoIHNlcmllcyB3aWxsIGRvLg0KDQpKRw0KDQoN
Cg==

