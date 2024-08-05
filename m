Return-Path: <linux-fsdevel+bounces-25039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D99482A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 21:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40A5280FBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E97E16BE1F;
	Mon,  5 Aug 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="utXWB6RX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69387149000;
	Mon,  5 Aug 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887621; cv=none; b=B0RsbNnplJZaBm2ri/ZsxlWs6yuOnfqmgkJl8J8EIjFKTgQnaNDS8CKIgDLLNnH78jt46c6GXvpr5GeBtDVrx9K/yYFgvCP5/pWGR40re5VkHzil1kA1yQRwjBADzxIgdtB/+Htwg+cj1OL9Uh4kv6r6TkqrX2akzWOJ+7r3Zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887621; c=relaxed/simple;
	bh=YS5ZQJ3DgdfPEIdZrvtluLYloT+1y1x+El0IGLTXA4o=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hPnp6f/QIV6as7Pni36BPZFsSoQepOTHwE9rOlR1+jSciAzo42NjFMobxwkP8RhwZKwSltDTl2/Zyf41iFHKv6GNfuLWC9e16FKmPoViOvHv9xsqVrBasyVfL+GI0z1+x4Ks+X9yUz1at7GEZUEo96oWzjd0cJtury+AqmFkmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=utXWB6RX; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722887620; x=1754423620;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=YS5ZQJ3DgdfPEIdZrvtluLYloT+1y1x+El0IGLTXA4o=;
  b=utXWB6RXBNg0xrnmI5MHlw5stu0OWOsDrNEGXCbjDm3twbJjyVhLvaG0
   R/+UHbQPn2yCGh4NfwzMMmS++y21XMEONL5slhtbP33nIspSoHeQ6KlqI
   QoPm5t6GJCyk+gdR4wtxfNqG50zv49WwlO6ZAN89nm0BGT++y46zjsHqn
   A=;
X-IronPort-AV: E=Sophos;i="6.09,265,1716249600"; 
   d="scan'208";a="415388985"
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Thread-Topic: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 19:53:36 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:17143]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.164:2525] with esmtp (Farcaster)
 id 2e3e2e7a-910d-4c7b-b605-16b9b4b5b303; Mon, 5 Aug 2024 19:53:35 +0000 (UTC)
X-Farcaster-Flow-ID: 2e3e2e7a-910d-4c7b-b605-16b9b4b5b303
Received: from EX19D004EUC004.ant.amazon.com (10.252.51.191) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 19:53:35 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D004EUC004.ant.amazon.com (10.252.51.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 19:53:35 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Mon, 5 Aug 2024 19:53:35 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "tytso@mit.edu" <tytso@mit.edu>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>, "Saenz Julienne,
 Nicolas" <nsaenz@amazon.es>, "Durrant, Paul" <pdurrant@amazon.co.uk>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz"
	<jack@suse.cz>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Thread-Index: AQHa5xp7YUfIGy2/kUGqgjccLElzprIYul2AgABZuAA=
Date: Mon, 5 Aug 2024 19:53:34 +0000
Message-ID: <cc168bf913aaf9bb11fb31d0f5a6c3d453a38942.camel@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
	 <20240805143223.GA1110778@mit.edu>
In-Reply-To: <20240805143223.GA1110778@mit.edu>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BED7CC18831D0429E325D6E63775338@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA4LTA1IGF0IDEwOjMyIC0wNDAwLCBUaGVvZG9yZSBUcydvIHdyb3RlOg0K
PiBPbiBNb24sIEF1ZyAwNSwgMjAyNCBhdCAxMTozMjozNUFNICswMjAwLCBKYW1lcyBHb3dhbnMg
d3JvdGU6DQo+ID4gR3Vlc3RtZW1mcyBpbXBsZW1lbnRzIHByZXNlcnZhdGlvbiBhY3Jvc3NzIGtl
eGVjIGJ5IGNhcnZpbmcgb3V0IGENCj4gPiBsYXJnZSBjb250aWd1b3VzIGJsb2NrIG9mIGhvc3Qg
c3lzdGVtIFJBTSBlYXJseSBpbiBib290IHdoaWNoIGlzDQo+ID4gdGhlbiB1c2VkIGFzIHRoZSBk
YXRhIGZvciB0aGUgZ3Vlc3RtZW1mcyBmaWxlcy4NCj4gDQo+IFdoeSBkb2VzIHRoZSBtZW1vcnkg
aGF2ZSB0byBiZSAoYSkgY29udGlndW91cywgYW5kIChiKSBjYXJ2ZWQgb3V0IG9mDQo+ICpob3N0
KiBzeXN0ZW0gbWVtb3J5IGVhcmx5IGluIGJvb3Q/wqAgVGhpcyBzZWVtcyB0byBiZSB2ZXJ5IGlu
ZmxleGlibGU7DQo+IGl0IG1lYW5zIHRoYXQgeW91IGhhdmUgdG8ga25vdyBob3cgbXVjaCBtZW1v
cnkgd2lsbCBiZSBuZWVkZWQgZm9yDQo+IGd1ZXN0bWVtZnMgaW4gZWFybHkgYm9vdC4NCg0KVGhl
IG1haW4gcmVhc29uIGZvciBib3RoIG9mIHRoZXNlIGlzIHRvIGd1YXJhbnRlZSB0aGF0IHRoZSBo
dWdlICgyIE1pQg0KUE1EKSBhbmQgZ2lnYW50aWMgKDEgR2lCIFBVRCkgYWxsb2NhdGlvbnMgY2Fu
IGhhcHBlbi4gV2hpbGUgdGhpcyBwYXRjaA0Kc2VyaWVzIG9ubHkgZG9lcyBodWdlIHBhZ2UgYWxs
b2NhdGlvbnMgZm9yIHNpbXBsaWNpdHksIHRoZSBpbnRlbnRpb24gaXMNCnRvIGV4dGVuZCBpdCB0
byBnaWdhbnRpYyBQVUQgbGV2ZWwgYWxsb2NhdGlvbnMgc29vbiAoSSdkIGxpa2UgdG8gZ2V0IHRo
ZQ0Kc2ltcGxlIGZ1bmN0aW9uYWxpdHkgbWVyZ2VkIGJlZm9yZSBhZGRpbmcgbW9yZSBjb21wbGV4
aXR5KS4NCk90aGVyIHRoYW4gZG9pbmcgYSBtZW1ibG9jayBhbGxvY2F0aW9uIGF0IGVhcmx5IGJv
b3QgdGhlcmUgcmVhbGx5IGlzIG5vDQp3YXkgdGhhdCBJIGtub3cgb2YgdG8gZG8gR2lCLXNpemUg
YWxsb2NhdGlvbnMgZHluYW1pY2FsbHkuDQoNCkluIHRlcm1zIG9mIHRoZSBuZWVkIGZvciBhIGNv
bnRpZ3VvdXMgY2h1bmssIHRoYXQncyBhIGJpdCBvZiBhDQpzaW1wbGlmaWNhdGlvbiBmb3Igbm93
LiBBcyBtZW50aW9uZWQgaW4gdGhlIGNvdmVyIGxldHRlciB0aGVyZSBjdXJyZW50bHkNCmlzbid0
IGFueSBOVU1BIHN1cHBvcnQgaW4gdGhpcyBwYXRjaCBzZXJpZXMuIFdlJ2Qgd2FudCB0byBhZGQg
dGhlDQphYmlsaXR5IHRvIGRvIE5VTUEgaGFuZGxpbmcgaW4gZm9sbG93aW5nIHBhdGNoIHNlcmll
cy4gSW4gdGhhdCBjYXNlIGl0DQp3b3VsZCBiZSBtdWx0aXBsZSBjb250aWd1b3VzIGFsbG9jYXRp
b25zLCBvbmUgZm9yIGVhY2ggTlVNQSBub2RlIHRoYXQNCnRoZSB1c2VyIHdhbnRzIHRvIHJ1biBW
TXMgb24uDQoNCkpHDQo=

