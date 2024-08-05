Return-Path: <linux-fsdevel+bounces-25038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E694828E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 21:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29B61F22371
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729FA16BE17;
	Mon,  5 Aug 2024 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zsl06BGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF414A85;
	Mon,  5 Aug 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887282; cv=none; b=YUKU5qQT33MTpJOubzUZqsFYYKGuIh38IhMREGteJ7/6fGdDdA3XjBQUMA/SI2SqUKAplPU3eNOePppITKm7NNHafDckC1GEW6b32uUAqpP9jRZ6m0aWVUILF0ySi5fZyuFUw7Wu8b3RLAjGIVT5ILsFcMTGetFpMRouqUCT/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887282; c=relaxed/simple;
	bh=hWFIHHWuFbJXkky+ht6BUwYWPc3b4HXDslWubfqa1x0=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KueWE10Zg1DcygLs57Q834aPVjI2OOMNLUV3ZyDMIov2R1ZNvnr9SXzj+7a9cgMcTgQI+dKD9vUmNZ6iei/4ld0CwdWJWQdqCQeZH6Ki8o4wI8QL5jceCN4r4pBbUtq9pyZvzcXA4a/VbUeAZhbfGHCB18C8lV2JvOQhlmRNRZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Zsl06BGj; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722887281; x=1754423281;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=hWFIHHWuFbJXkky+ht6BUwYWPc3b4HXDslWubfqa1x0=;
  b=Zsl06BGjIel+Mt4OHv4cTzAme4/zA3IvOePTOcis91+QiiOf0Sdi9Jt8
   9MmaL7ODp6gsM4FGmsOO49eE76Z0IT7IBilBtFqvvF5PAi4RUy/BZ5HER
   gZwG6CCaXctzfS/TzFbXxpDGDCsILcp65yHczm01bVkkGgSzc3pJw+4ey
   8=;
X-IronPort-AV: E=Sophos;i="6.09,265,1716249600"; 
   d="scan'208";a="112636161"
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Thread-Topic: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 19:47:58 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:45937]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.164:2525] with esmtp (Farcaster)
 id 76bd4af3-4e48-49dc-983a-668f865f6d2a; Mon, 5 Aug 2024 19:47:57 +0000 (UTC)
X-Farcaster-Flow-ID: 76bd4af3-4e48-49dc-983a-668f865f6d2a
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 19:47:57 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 19:47:56 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Mon, 5 Aug 2024 19:47:56 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "tytso@mit.edu"
	<tytso@mit.edu>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "nh-open-source@amazon.com"
	<nh-open-source@amazon.com>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"Durrant, Paul" <pdurrant@amazon.co.uk>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>
Thread-Index: AQHa5xp7YUfIGy2/kUGqgjccLElzprIYul2AgAAChoCAAFWigA==
Date: Mon, 5 Aug 2024 19:47:56 +0000
Message-ID: <3f9064160b43df488d73302b3d736e23a9cd2b66.camel@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
	 <20240805143223.GA1110778@mit.edu>
	 <CABgObfYhg6uoR7cQN4wf3bNLZbHfXv6fr35aKsKbqMvuv20Xrg@mail.gmail.com>
In-Reply-To: <CABgObfYhg6uoR7cQN4wf3bNLZbHfXv6fr35aKsKbqMvuv20Xrg@mail.gmail.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C270A5EF62CAB4FACD59CA91FD35FD4@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA4LTA1IGF0IDE2OjQxICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiBNb24sIEF1ZyA1LCAyMDI0IGF0IDQ6MzXigK9QTSBUaGVvZG9yZSBUcydvIDx0eXRzb0Bt
aXQuZWR1PiB3cm90ZToNCj4gPiBPbiBNb24sIEF1ZyAwNSwgMjAyNCBhdCAxMTozMjozNUFNICsw
MjAwLCBKYW1lcyBHb3dhbnMgd3JvdGU6DQo+ID4gPiBHdWVzdG1lbWZzIGltcGxlbWVudHMgcHJl
c2VydmF0aW9uIGFjcm9zc3Mga2V4ZWMgYnkgY2FydmluZyBvdXQgYQ0KPiA+ID4gbGFyZ2UgY29u
dGlndW91cyBibG9jayBvZiBob3N0IHN5c3RlbSBSQU0gZWFybHkgaW4gYm9vdCB3aGljaCBpcw0K
PiA+ID4gdGhlbiB1c2VkIGFzIHRoZSBkYXRhIGZvciB0aGUgZ3Vlc3RtZW1mcyBmaWxlcy4NCj4g
PiANCj4gPiBBbHNvLCB0aGUgVk1NIHVwZGF0ZSBwcm9jZXNzIGlzIG5vdCBhIGNvbW1vbiBjYXNl
IHRoaW5nLCBzbyB3ZSBkb24ndA0KPiA+IG5lZWQgdG8gb3B0aW1pemUgZm9yIHBlcmZvcm1hbmNl
LiAgSWYgd2UgbmVlZCB0byB0ZW1wb3JhcmlseSB1c2UNCj4gPiBzd2FwL3pzd2FwIHRvIGFsbG9j
YXRlIG1lbW9yeSBhdCBWTU0gdXBkYXRlIHRpbWUsIGFuZCBpZiB0aGUgcGFnZXMNCj4gPiBhcmVu
J3QgY29udGlndW91cyB3aGVuIHRoZXkgYXJlIGNvcGllZCBvdXQgYmVmb3JlIGRvaW5nIHRoZSBW
TU0NCj4gPiB1cGRhdGUNCj4gDQo+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQsIHdoZXJlIHdv
dWxkIHRoaXMgdGVtcG9yYXJ5IGFsbG9jYXRpb24gaGFwcGVuPw0KDQpUaGUgaW50ZW5kZWQgdXNl
IGNhc2UgZm9yIGxpdmUgdXBkYXRlIGlzIHRvIHVwZGF0ZSB0aGUgZW50aXJlbHkgb2YgdGhlDQpo
eXBlcnZpc29yOiBrZXhlY2luZyBpbnRvIGEgbmV3IGtlcm5lbCwgbGF1bmNoaW5nIG5ldyBWTU0g
cHJvY2Vzc2VzLiBTbw0KYW55dGhpbmcgaW4ga2VybmVsIHN0YXRlIChwYWdlIHRhYmxlcywgVk1B
cywgKHopc3dhcCBlbnRyaWVzLCBzdHJ1Y3QNCnBhZ2VzLCBldGMpIGlzIGFsbCBsb3N0IGFmdGVy
IGtleGVjIGFuZCBuZWVkcyB0byBiZSByZS1jcmVhdGVkLiBUaGF0J3MNCnRoZSBqb2Igb2YgZ3Vl
c3RtZW1mczogcHJvdmlkZSB0aGUgcGVyc2lzdGVuY2UgYWNyb3NzIGtleGVjIGFuZCBhYmlsaXR5
DQp0byByZS1jcmVhdGUgdGhlIG1hcHBpbmcgYnkgcmUtb3BlbmluZyB0aGUgZmlsZXMuDQoNCkl0
IHdvdWxkIGJlIGZhciB0b28gaW1wYWN0ZnVsIHRvIG5lZWQgdG8gd3JpdGUgb3V0IHRoZSB3aG9s
ZSBWTSBtZW1vcnkNCnRvIGRpc2suIEFsc28gd2l0aCBDb0NvIFZNcyB0aGF0J3Mgbm90IHJlYWxs
eSBwb3NzaWJsZS4gV2hlbiB2aXJ0dWFsDQptYWNoaW5lcyBhcmUgcnVubmluZywgZXZlcnkgbWls
bGlzZWNvbmQgb2YgZG93biB0aW1lIGNvdW50cy4gSXQgd291bGQgYmUNCndhc3RlZnVsIHRvIG5l
ZWQgdG8ga2VlcCB0ZXJhYnl0ZXMgb2YgU1NEcyBseWluZyBhcm91bmQganVzdCB0byBicmllZmx5
DQp3cml0ZSBhbGwgdGhlIGd1ZXN0IFJBTSB0aGVyZSBhbmQgdGhlbiByZWFkIGl0IG91dCBhIG1v
bWVudCBsYXRlci4gTXVjaA0KYmV0dGVyIHRvIGxlYXZlIGFsbCB0aGUgZ3Vlc3QgbWVtb3J5IHdo
ZXJlIGl0IGlzOiBpbiBtZW1vcnkuDQoNCj4gDQo+ID4gdGhhdCBtaWdodCBiZSB2ZXJ5IHdlbGwg
d29ydGggdGhlIHZhc3Qgb2Ygb2YgbWVtb3J5IG5lZWRlZCB0bw0KPiA+IHBheSBmb3IgcmVzZXJ2
aW5nIG1lbW9yeSBvbiB0aGUgaG9zdCBmb3IgdGhlIFZNTSB1cGRhdGUgdGhhdCBvbmx5DQo+ID4g
bWlnaHQgaGFwcGVuIG9uY2UgZXZlcnkgZmV3IGRheXMvd2Vla3MvbW9udGhzIChkZXBlbmRpbmcg
b24gd2hldGhlcg0KPiA+IHlvdSBhcmUgZG9pbmcgdXBkYXRlIGp1c3QgZm9yIGhpZ2ggc2V2ZXJp
dHkgc2VjdXJpdHkgZml4ZXMsIG9yIGZvcg0KPiA+IHJhbmRvbSBWTU0gdXBkYXRlcykuDQo+ID4g
DQo+ID4gRXZlbiBpZiB5b3UgYXJlIHVwZGF0aW5nIHRoZSBWTU0gZXZlcnkgZmV3IGRheXMsIGl0
IHN0aWxsIGRvZXNuJ3Qgc2VlbQ0KPiA+IHRoYXQgcGVybWFuZW50bHkgcmVzZXJ2aW5nIGNvbnRp
Z3VvdXMgbWVtb3J5IG9uIHRoZSBob3N0IGNhbiBiZQ0KPiA+IGp1c3RpZmllZCBmcm9tIGEgVENP
IHBlcnNwZWN0aXZlLg0KPiANCj4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCwgdGhpcyBpcyBpbnRl
bmRlZCBmb3IgdXNlIGluIHN5c3RlbXMgdGhhdCBkbw0KPiBub3QgZG8gYW55dGhpbmcgZXhjZXB0
IGhvc3RpbmcgVk1zLCB3aGVyZSBhbnl3YXkgeW91J2QgZGV2b3RlIDkwJSsgb2YNCj4gaG9zdCBt
ZW1vcnkgdG8gaHVnZXRsYmZzIGdpZ2FwYWdlcy4NCg0KRXhhY3RseSwgdGhlIHVzZSBjYXNlIGhl
cmUgaXMgZm9yIG1hY2hpbmVzIHdob3NlIG9ubHkgam9iIGlzIHRvIGJlIGEgS1ZNDQpoeXBlcnZp
c29yLiBUaGUgbWFqb3JpdHkgb2Ygc3lzdGVtIFJBTSBpcyBkb25hdGVkIHRvIGd1ZXN0bWVtZnM7
DQphbnl0aGluZyBlbHNlIChob3N0IGtlcm5lbCBtZW1vcnkgYW5kIFZNTSBhbm9ueW1vdXMgbWVt
b3J5KSBpcw0KZXNzZW50aWFsbHkgb3ZlcmhlYWQgYW5kIHNob3VsZCBiZSBtaW5pbWlzZWQuDQoN
CkpHDQo=

