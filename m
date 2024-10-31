Return-Path: <linux-fsdevel+bounces-33358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B009B7E87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 16:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D23F1C23A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 15:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096C1A4F01;
	Thu, 31 Oct 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P1Nncupq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498E1A01C4;
	Thu, 31 Oct 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388674; cv=none; b=IhfO0cDymlHQxBPTuRdWszSzGJH1SzMSmGDzFXpGnR6hz3+Q9nL/DOw/RQ1vSHKJWIX2wckwhWnJ0Ibmzfj3PY/BYki8UjTw6r0tZio/8LqKbu+bqMwZjWE+Rx1Ng55plFPUpYKxHhV5tBKbzHwpzBMn69SX3dC0uP44UPqeQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388674; c=relaxed/simple;
	bh=kjEtoR7WXcrlDmWv79wlde5j4Pe/SHsa6DdfWTkJccw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhOji7DBOqM+2DDLFPkwBu6YrUR6OsOUKKU1XHk05azrSRb22D2serKvOfly/bC3oHFc3HmdL62KGIpuuVW3+AE/9NhWQ2+v6LFKLynOZhROQLLUmmq7Lr8w4fa/C8o7LjGdflQtRfEIMeuLakU/1gf3k7WkoJQYzwwpaKKwKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=P1Nncupq; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730388672; x=1761924672;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=kjEtoR7WXcrlDmWv79wlde5j4Pe/SHsa6DdfWTkJccw=;
  b=P1NncupqU6LYHOGoy8KlIR+/AtrWJhuxD3VTxiGcd5tOAUrH9Ke26JaT
   ieyjtNMRxIBaAQo7Cglj56PdFUNY4/20oUD9T1Z+PBmaWcIMwdO+V4bwI
   kSRQbS1fAli84sWWqdMyWuxooU+U6rCRQfGShiezTznwnb11/2SCeWyLe
   E=;
X-IronPort-AV: E=Sophos;i="6.11,247,1725321600"; 
   d="scan'208";a="381479065"
Subject: Re: [PATCH 05/10] guestmemfs: add file mmap callback
Thread-Topic: [PATCH 05/10] guestmemfs: add file mmap callback
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 15:31:03 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:32967]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.199:2525] with esmtp (Farcaster)
 id 2f3f7fde-846e-4fec-9d29-916d333d5f38; Thu, 31 Oct 2024 15:31:00 +0000 (UTC)
X-Farcaster-Flow-ID: 2f3f7fde-846e-4fec-9d29-916d333d5f38
Received: from EX19D004EUC003.ant.amazon.com (10.252.51.249) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 31 Oct 2024 15:30:59 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D004EUC003.ant.amazon.com (10.252.51.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 31 Oct 2024 15:30:59 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Thu, 31 Oct 2024 15:30:59 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>
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
	<linux-fsdevel@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Thread-Index: AQHbKlc3IZ2PqNLJ5E+mkZOTFQYr3bKg/xKA
Date: Thu, 31 Oct 2024 15:30:59 +0000
Message-ID: <33a2fd519edc917d933517842cc077a19e865e3f.camel@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
	 <20240805093245.889357-6-jgowans@amazon.com>
	 <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
In-Reply-To: <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <260366AA7173934389D9B2AED5356A54@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTEwLTI5IGF0IDE2OjA1IC0wNzAwLCBFbGxpb3QgQmVybWFuIHdyb3RlOg0K
PiBPbiBNb24sIEF1ZyAwNSwgMjAyNCBhdCAxMTozMjo0MEFNICswMjAwLCBKYW1lcyBHb3dhbnMg
d3JvdGU6DQo+ID4gTWFrZSB0aGUgZmlsZSBkYXRhIHVzYWJsZSB0byB1c2Vyc3BhY2UgYnkgYWRk
aW5nIG1tYXAuIFRoYXQncyBhbGwgdGhhdA0KPiA+IFFFTVUgbmVlZHMgZm9yIGd1ZXN0IFJBTSwg
c28gdGhhdCdzIGFsbCBiZSBib3RoZXIgaW1wbGVtZW50aW5nIGZvciBub3cuDQo+ID4gDQo+ID4g
V2hlbiBtbWFwaW5nIHRoZSBmaWxlIHRoZSBWTUEgaXMgbWFya2VkIGFzIFBGTk1BUCB0byBpbmRp
Y2F0ZSB0aGF0IHRoZXJlDQo+ID4gYXJlIG5vIHN0cnVjdCBwYWdlcyBmb3IgdGhlIG1lbW9yeSBp
biB0aGlzIFZNQS4gUmVtYXBfcGZuX3JhbmdlKCkgaXMNCj4gPiB1c2VkIHRvIGFjdHVhbGx5IHBv
cHVsYXRlIHRoZSBwYWdlIHRhYmxlcy4gQWxsIFBURXMgYXJlIHByZS1mYXVsdGVkIGludG8NCj4g
PiB0aGUgcGd0YWJsZXMgYXQgbW1hcCB0aW1lIHNvIHRoYXQgdGhlIHBndGFibGVzIGFyZSB1c2Fi
bGUgd2hlbiB0aGlzDQo+ID4gdmlydHVhbCBhZGRyZXNzIHJhbmdlIGlzIGdpdmVuIHRvIFZGSU8n
cyBNQVBfRE1BLg0KPiANCj4gVGhhbmtzIGZvciBzZW5kaW5nIHRoaXMgb3V0ISBJJ20gZ29pbmcg
dGhyb3VnaCB0aGUgc2VyaWVzIHdpdGggdGhlDQo+IGludGVudGlvbiB0byBzZWUgaG93IGl0IG1p
Z2h0IGZpdCB3aXRoaW4gdGhlIGV4aXN0aW5nIGd1ZXN0X21lbWZkIHdvcmsNCj4gZm9yIHBLVk0v
Q29Dby9HdW55YWguDQo+IA0KPiBJdCBtaWdodCd2ZSBiZWVuIG1lbnRpb25lZCBpbiB0aGUgTU0g
YWxpZ25tZW50IHNlc3Npb24gLS0geW91IG1pZ2h0IGJlDQo+IGludGVyZXN0ZWQgdG8gam9pbiB0
aGUgZ3Vlc3RfbWVtZmQgYmktd2Vla2x5IGNhbGwgdG8gc2VlIGhvdyB3ZSBhcmUNCj4gb3Zlcmxh
cHBpbmcgWzFdLg0KPiANCj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vYWU3OTQ4
OTEtZmU2OS00MTFhLWI4MmUtNjk2M2I1OTRhNjJhQHJlZGhhdC5jb20vVC8NCg0KSGkgRWxsaW90
LCB5ZXMsIEkgdGhpbmsgdGhhdCB0aGVyZSBpcyBhIGxvdCBtb3JlIG92ZXJsYXAgd2l0aA0KZ3Vl
c3RfbWVtZmQgbmVjZXNzYXJ5IGhlcmUuIFRoZSBpZGVhIHdhcyB0byBleHRlbmQgZ3Vlc3RtZW1m
cyBhdCBzb21lDQpwb2ludCB0byBoYXZlIGEgZ3Vlc3RfbWVtZmQgc3R5bGUgaW50ZXJmYWNlLCBi
dXQgaXQgd2FzIHBvaW50ZWQgb3V0IGF0DQp0aGUgTU0gYWxpZ25tZW50IGNhbGwgdGhhdCBkb2lu
ZyBzbyB3b3VsZCByZXF1aXJlIGd1ZXN0bWVtZnMgdG8NCmR1cGxpY2F0ZSB0aGUgQVBJIHN1cmZh
Y2Ugb2YgZ3Vlc3RfbWVtZmQuIFRoaXMgaXMgdW5kZXNpcmFibGUuIEJldHRlcg0Kd291bGQgYmUg
dG8gaGF2ZSBwZXJzaXN0ZW5jZSBpbXBsZW1lbnRlZCBhcyBhIGN1c3RvbSBhbGxvY2F0b3IgYmVo
aW5kIGENCm5vcm1hbCBndWVzdF9tZW1mZC4gSSdtIG5vdCB0b28gc3VyZSBob3cgdGhpcyB3b3Vs
ZCBiZSBhY3R1YWxseSBkb25lIGluDQpwcmFjdGljZSwgc3BlY2lmaWNhbGx5OiANCi0gaG93IHRo
ZSBwZXJzaXN0ZW50IHBvb2wgd291bGQgYmUgZGVmaW5lZA0KLSBob3cgaXQgd291bGQgYmUgc3Vw
cGxpZWQgdG8gZ3Vlc3RfbWVtZmQNCi0gaG93IHRoZSBndWVzdF9tZW1mZHMgd291bGQgYmUgcmUt
ZGlzY292ZXJlZCBhZnRlciBrZXhlYw0KQnV0IGFzc3VtaW5nIHdlIGNhbiBmaWd1cmUgb3V0IHNv
bWUgd2F5IHRvIGRvIHRoaXMsIEkgdGhpbmsgaXQncyBhDQpiZXR0ZXIgd2F5IHRvIGdvLg0KDQpJ
J2xsIGpvaW4gdGhlIGd1ZXN0X21lbWZkIGNhbGwgc2hvcnRseSB0byBzZWUgdGhlIGRldmVsb3Bt
ZW50cyB0aGVyZSBhbmQNCndoZXJlIHBlcnNpc3RlbmNlIHdvdWxkIGZpdCBiZXN0Lg0KDQpIb3Bl
ZnVsbHkgd2UgY2FuIGZpZ3VyZSBvdXQgaW4gdGhlb3J5IGhvdyB0aGlzIGNvdWxkIHdvcmssIHRo
ZSBJJ2xsIHB1dA0KdG9nZXRoZXIgYW5vdGhlciBSRkMgc2tldGNoaW5nIGl0IG91dC4NCg0KSkcN
Cg==

