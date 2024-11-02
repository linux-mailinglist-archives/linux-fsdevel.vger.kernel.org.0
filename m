Return-Path: <linux-fsdevel+bounces-33557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD799B9DE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 09:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A27F1C20F34
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B164015853B;
	Sat,  2 Nov 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KsVeJxJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F042070;
	Sat,  2 Nov 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730535860; cv=none; b=j2Hs2WEOZnGBR/XUQXFfLTWdLFQHR4tjzOHruhCatyDM3XSIYUqfNqNrVofD0iO3/qY1GRDmRXAERM21cuwPHGr5iNfjZkKPJv9mSThcpyf4rY7B+otIboo1Yg7LZT6V2ORTb/uSoMKBSSmMSCKPDLcTGTQhrkVv/oybv5r2YC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730535860; c=relaxed/simple;
	bh=yGK1KN39J4qBgGabjddBS4CW61b4/PobSXi3k7uiWHY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xe9Pcpe+PAKS98gbU8DNRb3FAvyGnyYkVdSxzYcbdl2580dRrzEUTTsoN3uuf0cRmymFTEo4Pi+2KugFTcAWqRpGHk8jnkmtRapE43ak3m7xlIJMgzgZdMMPGSOCxpyjs2aGwCYM2u3sv8bWwszyx4ot3w6UsC8z8y8O3DcFT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KsVeJxJS; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730535858; x=1762071858;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=yGK1KN39J4qBgGabjddBS4CW61b4/PobSXi3k7uiWHY=;
  b=KsVeJxJSsfvTecCS7p3uO0fWGJmzJdAFFSO1dht5IBT/Pc4Xi3o9zCBh
   i+SUv7eHpo6jQfDtF+UIV1J4MQXCwfvhd8oTxQ/bDbIdaeRyTK96VxRHW
   MRFB1BQNayXiY0A/IHCLwq0TFZMwDLs+4ufqWDuS5HxIErzzwZB/A0VFv
   E=;
X-IronPort-AV: E=Sophos;i="6.11,252,1725321600"; 
   d="scan'208";a="142784627"
Subject: Re: [PATCH 05/10] guestmemfs: add file mmap callback
Thread-Topic: [PATCH 05/10] guestmemfs: add file mmap callback
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 08:24:17 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:21274]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.191:2525] with esmtp (Farcaster)
 id d77b947b-8f2e-4f82-a732-694a889584ed; Sat, 2 Nov 2024 08:24:16 +0000 (UTC)
X-Farcaster-Flow-ID: d77b947b-8f2e-4f82-a732-694a889584ed
Received: from EX19D004EUC003.ant.amazon.com (10.252.51.249) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 2 Nov 2024 08:24:15 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D004EUC003.ant.amazon.com (10.252.51.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 2 Nov 2024 08:24:15 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Sat, 2 Nov 2024 08:24:15 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Durrant,
 Paul" <pdurrant@amazon.co.uk>, "Woodhouse, David" <dwmw@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Saenz
 Julienne, Nicolas" <nsaenz@amazon.es>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Index: AQHbKlc3IZ2PqNLJ5E+mkZOTFQYr3bKg/xKAgAAJ94CAAV52AIAAC3wAgAE5hQA=
Date: Sat, 2 Nov 2024 08:24:15 +0000
Message-ID: <9df04c57f9d5f351bb1b4eeef764bf9ccc6711b1.camel@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
	 <20240805093245.889357-6-jgowans@amazon.com>
	 <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
	 <33a2fd519edc917d933517842cc077a19e865e3f.camel@amazon.com>
	 <20241031160635.GA35848@ziepe.ca>
	 <fe4dd4d2f5eb2209f0190d547fe29370554ceca8.camel@amazon.com>
	 <20241101134202.GB35848@ziepe.ca>
In-Reply-To: <20241101134202.GB35848@ziepe.ca>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EDB8442E7DDA94C9445F2E7A451F7F9@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTExLTAxIGF0IDEwOjQyIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+IA0KPiBPbiBGcmksIE5vdiAwMSwgMjAyNCBhdCAwMTowMTowMFBNICswMDAwLCBHb3dhbnMs
IEphbWVzIHdyb3RlOg0KPiANCj4gPiBUaGFua3MgSmFzb24sIHRoYXQgc291bmRzIHBlcmZlY3Qu
IEknbGwgd29yayBvbiB0aGUgbmV4dCByZXYgd2hpY2ggd2lsbDoNCj4gPiAtIGV4cG9zZSBhIGZp
bGVzeXN0ZW0gd2hpY2ggb3ducyByZXNlcnZlZC9wZXJzaXN0ZW50IG1lbW9yeSwganVzdCBsaWtl
DQo+ID4gdGhpcyBwYXRjaC4NCj4gDQo+IElzIHRoaXMgc3RlcCBuZWVkZWQ/DQo+IA0KPiBJZiB0
aGUgZ3Vlc3QgbWVtZmQgaXMgYWxyZWFkeSB0b2xkIHRvIGdldCAxRyBwYWdlcyBpbiBzb21lIG5v
cm1hbCB3YXksDQo+IHdoeSBkbyB3ZSBuZWVkIGEgZGVkaWNhdGVkIHBvb2wganVzdCBmb3IgdGhl
IEtITyBmaWxlc3lzdGVtPw0KPiANCj4gQmFjayB0byBteSBzdWdnZXN0aW9uLCBjYW4ndCBLSE8g
c2ltcGx5IGZyZWV6ZSB0aGUgZ3Vlc3QgbWVtZmQgYW5kDQo+IHRoZW4gZXh0cmFjdCB0aGUgbWVt
b3J5IGxheW91dCwgYW5kIGp1c3QgdXNlIHRoZSBub3JtYWwgYWxsb2NhdG9yPw0KPiANCj4gT3Ig
ZG8geW91IGhhdmUgYSBoYXJkIHJlcXVpcmVtZW50IHRoYXQgb25seSBLSE8gYWxsb2NhdGVkIG1l
bW9yeSBjYW4NCj4gYmUgcHJlc2VydmVkIGFjcm9zcyBrZXhlYz8NCg0KS0hPIGNhbiBwZXJzaXN0
IGFueSBtZW1vcnkgcmFuZ2VzIHdoaWNoIGFyZSBub3QgTU9WQUJMRS4gUHJvdmlkZWQgdGhhdA0K
Z3Vlc3RfbWVtZmQgZG9lcyBub24tbW92YWJsZSBhbGxvY2F0aW9ucyB0aGVuIHNlcmlhbGlzaW5n
IGFuZCBwZXJzaXN0aW5nDQpzaG91bGQgYmUgcG9zc2libGUuDQoNClRoZXJlIGFyZSBvdGhlciBy
ZXF1aXJlbWVudHMgaGVyZSwgc3BlY2lmaWNhbGx5IHRoZSBhYmlsaXR5IHRvIGJlDQoqZ3VhcmFu
dGVlZCogR2lCLWxldmVsIGFsbG9jYXRpb25zLCBoYXZlIHRoZSBndWVzdCBtZW1vcnkgb3V0IG9m
IHRoZQ0KZGlyZWN0IG1hcCBmb3Igc2VjcmV0IGhpZGluZywgYW5kIHJlbW92ZSB0aGUgc3RydWN0
IHBhZ2Ugb3ZlcmhlYWQuDQpTdHJ1Y3QgcGFnZSBvdmVyaGVhZCBjb3VsZCBiZSBoYW5kbGVkIHZp
YSBIVk8uIEJ1dCBjb25zaWRlcmluZyB0aGF0IHRoZQ0KbWVtb3J5IG11c3QgYmUgb3V0IG9mIHRo
ZSBkaXJlY3QgbWFwIGl0IHNlZW1zIHVubmVjZXNzYXJ5IHRvIGhhdmUgc3RydWN0DQpwYWdlcywg
YW5kIHVubmVjZXNzYXJ5IHRvIGhhdmUgaXQgbWFuYWdlZCBieSBhbiBleGlzdGluZyBhbGxvY2F0
b3IuIFRoZQ0Kb25seSBleGlzdGluZyAxIEdpQiBhbGxvY2F0b3IgSSBrbm93IG9mIGlzIGh1Z2V0
bGJmcz8gTGV0IG1lIGtub3cgaWYNCnRoZXJlJ3Mgc29tZXRoaW5nIGVsc2UgdGhhdCBjYW4gYmUg
dXNlZC4NClRoYXQncyB0aGUgbWFpbiBtb3RpdmF0aW9uIGZvciBhIHNlcGFyYXRlIHBvb2wgYWxs
b2NhdGVkIG9uIGVhcmx5IGJvb3QuDQpUaGlzIGlzIHF1aXRlIHNpbWlsYXIgdG8gaHVnZXRsYmZz
LCBzbyBhIG5hdHVyYWwgcXVlc3Rpb24gaXMgaWYgd2UgY291bGQNCnVzZSBhbmQgc2VyaWFsaXNl
IGh1Z2V0bGJmcyBpbnN0ZWFkLCBidXQgdGhhdCBwcm9iYWJseSBvcGVucyBhbm90aGVyIGNhbg0K
b2Ygd29ybXMgb2YgY29tcGxleGl0eS4NCg0KVGhlcmUncyBtb3JlIHRoYW4ganVzdCB0aGUgZ3Vl
c3RfbWVtZmRzIGFuZCB0aGVpciBhbGxvY2F0aW9ucyB0bw0Kc2VyaWFsaXNlOyBpdCdzIHByb2Jh
Ymx5IHVzZWZ1bCB0byBiZSBhYmxlIHRvIGhhdmUgYSBkaXJlY3Rvcnkgc3RydWN0dXJlDQppbiB0
aGUgZmlsZXN5c3RlbSwgUE9TSVggZmlsZSBBQ0xzLCBhbmQgcGVyaGFwcyBzb21lIG90aGVyIGZp
bGVzeXN0ZW0NCm1ldGFkYXRhLiBGb3IgdGhpcyByZWFzb24gSSBzdGlsbCB0aGluayB0aGF0IGhh
dmluZyBhIG5ldyBmaWxlc3lzdGVtDQpkZXNpZ25lZCBmb3IgdGhpcyB1c2UtY2FzZSB3aGljaCBj
cmVhdGVzIGd1ZXN0X21lbWZkIG9iamVjdHMgd2hlbiBmaWxlcw0KYXJlIG9wZW5lZCBpcyB0aGUg
d2F5IHRvIGdvLg0KDQpMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluay4NCg0KSkcNCg==

