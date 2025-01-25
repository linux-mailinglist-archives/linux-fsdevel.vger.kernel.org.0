Return-Path: <linux-fsdevel+bounces-40104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE2A1C12E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 07:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB763A97AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128A1C831A;
	Sat, 25 Jan 2025 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ldx0irAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA9EC4
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737786808; cv=none; b=Il91HERr4Pz2hIGBF7WYDpclgDEpYwCRgbMXPu6nTD0FyGTEBhJ4vdXp/v58Kit+8lb8+3SzUboKehc5JN7r7EfXnaiEMIOj0B/Qq/8PbTkqEWVQ7lrTaboViD5JZ/yHHUjyFAr4J7tzRq/sjMQb0bh1A/hKWg4objw3jm2htm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737786808; c=relaxed/simple;
	bh=12it4yerENY6J474YzaKEI3CyIheYqnDWmYuaxteKYw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B/g5hJGSfWfzzaF4oioIttLAifQe06n2yfpVOKgt6Pe92Gimy/P1oO7sgnNR6R9nclLgLLHgt0LKOGLW84OvqG8ZecQwUNa/84tldiXNk2sQub8paRlG4gTePgzALGgq1QAoqctEljZkKvi7XWi7iAxrnf7PFHV9rREhauVGjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ldx0irAF; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737786807; x=1769322807;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=12it4yerENY6J474YzaKEI3CyIheYqnDWmYuaxteKYw=;
  b=ldx0irAFzsr1aIaPvRl4V7kVREuKP4QuUhrSIQL3e74dt6sCMDLesBnz
   g17KIWkMH7RtDspUVL4Lt5f5vovNvBur/z9p6d5GrAWxz8IrnxuBs/Rzj
   VgArhuVW7P50Ir+bIeBghFDD11AgoIs9D+cN/s90amNhvRNiJVLT0CFc6
   8=;
X-IronPort-AV: E=Sophos;i="6.13,233,1732579200"; 
   d="scan'208";a="403390070"
Subject: Re: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Thread-Topic: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 06:33:25 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.29.78:2734]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.50.34:2525] with esmtp (Farcaster)
 id cdb06fb1-8f26-4255-90b5-5047119a29b1; Sat, 25 Jan 2025 06:33:24 +0000 (UTC)
X-Farcaster-Flow-ID: cdb06fb1-8f26-4255-90b5-5047119a29b1
Received: from EX19D017UEA004.ant.amazon.com (10.252.134.70) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 25 Jan 2025 06:33:24 +0000
Received: from EX19D017UEA001.ant.amazon.com (10.252.134.93) by
 EX19D017UEA004.ant.amazon.com (10.252.134.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 25 Jan 2025 06:33:24 +0000
Received: from EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed]) by
 EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed%3]) with mapi id
 15.02.1258.039; Sat, 25 Jan 2025 06:33:24 +0000
From: "Day, Timothy" <timday@amazon.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jsimmons@infradead.org" <jsimmons@infradead.org>, Andreas Dilger
	<adilger@ddn.com>, "neilb@suse.de" <neilb@suse.de>
Thread-Index: AQHbbqGKPQGkNCnWmkGOpAnSPDKrX7Mmaz4AgABJvYA=
Date: Sat, 25 Jan 2025 06:33:24 +0000
Message-ID: <DA28F0FE-ACB6-486E-BF3D-85AF328FE2AD@amazon.com>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5QBiMvc-A2bJXwh@casper.infradead.org>
In-Reply-To: <Z5QBiMvc-A2bJXwh@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6787CCBEAB580E47BA42D8F6F35508F4@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gT24gMS8yNC8yNSwgNDowOSBQTSwgIk1hdHRoZXcgV2lsY294IiA8d2lsbHlAaW5mcmFk
ZWFkLm9yZyA8bWFpbHRvOndpbGx5QGluZnJhZGVhZC5vcmc+PiB3cm90ZToNCj4gPiBPbiBGcmks
IEphbiAyNCwgMjAyNSBhdCAwODo1MDowMlBNICswMDAwLCBEYXksIFRpbW90aHkgd3JvdGU6DQo+
ID4gTHVzdHJlIGhhcyBhbHJlYWR5IHJlY2VpdmVkIGEgcGxldGhvcmEgb2YgZmVlZGJhY2sgaW4g
dGhlIHBhc3QuDQo+ID4gV2hpbGUgbXVjaCBvZiB0aGF0IGhhcyBiZWVuIGFkZHJlc3NlZCBzaW5j
ZSAtIHRoZSBrZXJuZWwgaXMgYQ0KPiA+IG1vdmluZyB0YXJnZXQuIFNldmVyYWwgZmlsZXN5c3Rl
bXMgaGF2ZSBiZWVuIG1lcmdlZCAob3IgcmVtb3ZlZCkNCj4gPiBzaW5jZSBMdXN0cmUgbGVmdCBz
dGFnaW5nLiBXZSdyZSBhaW1pbmcgdG8gYXZvaWQgdGhlIG1pc3Rha2VzIG9mDQo+ID4gdGhlIHBh
c3QgYW5kIGhvcGUgdG8gYWRkcmVzcyBhcyBtYW55IGNvbmNlcm5zIGFzIHBvc3NpYmxlIGJlZm9y
ZQ0KPiA+IHN1Ym1pdHRpbmcgZm9yIGluY2x1c2lvbi4NCj4NCj4NCj4gSSdtIGJyb2FkbHkgaW4g
ZmF2b3VyIG9mIGFkZGluZyBMdXN0cmUsIGhvd2V2ZXIgSSdkIHJlYWxseSBsaWtlIGl0IHRvIG5v
dA0KPiBpbmNyZWFzZSBteSB3b3JrbG9hZCBzdWJzdGFudGlhbGx5LiBJZGVhbGx5IGl0IHdvdWxk
IHVzZSBpb21hcCBpbnN0ZWFkIG9mDQo+IGJ1ZmZlciBoZWFkcyAoYWx0aG91Z2ggbWF5YmUgdGhh
dCdzIG5vdCBmZWFzaWJsZSkuDQoNClRoZSBwbGFjZSBMdXN0cmUgdXNlcyBidWZmZXIgaGVhZHMg
aXMgb3NkLWxkaXNrZnMgKHRoZSBpbnRlcmZhY2UgYmV0d2Vlbg0KdGhlIEx1c3RyZSBzZXJ2ZXIg
YW5kIGV4dDQpLiBBbmQgdGhhdCdzIGFuIGFydGlmYWN0IG9mIGV4dDQncyB1c2FnZSBvZg0KYnVm
ZmVyIGhlYWRzLiBJIGRvbuKAmXQgc2VlIHVzYWdlIG90aGVyd2lzZS4gVGhlIHdheSB0aGUgTHVz
dHJlIHNlcnZlcg0KaW50ZXJmYWNlcyB3aXRoIGV4dDQgaXMgcHJvYmFibHkgYSBiaWdnZXIgcXVl
c3Rpb24uDQoNCj4gV2hhdCdzIG5vdCBuZWdvdGlhYmxlIGZvciBtZSBpcyB0aGUgdXNlIG9mIGZv
bGlvczsgTHVzdHJlIG11c3QgYmUNCj4gZnVsbHkgY29udmVydGVkIHRvIHRoZSBmb2xpbyBBUEku
IE5vIHVzZSBvZiBhbnkgb2YgdGhlIGZ1bmN0aW9ucyBpbg0KPiBtbS9mb2xpby1jb21wYXQuYy4g
SWYgeW91IGNhbiBncmVwIGZvciAnc3RydWN0IHBhZ2UnIGluIEx1c3RyZSBhbmQNCj4gZmluZCBu
b3RoaW5nLCB0aGF0J3MgYSBncmVhdCBwbGFjZSB0byBiZSAobm90IGFsbCBmaWxlc3lzdGVtcyBp
biB0aGUNCj4ga2VybmVsIGhhdmUgcmVhY2hlZCB0aGF0IHN0YWdlIHlldCwgYW5kIHRoZXJlIGFy
ZSBnb29kIHJlYXNvbnMgd2h5IHNvbWUNCj4gZmlsZXN5c3RlbXMgc3RpbGwgdXNlIGJhcmUgcGFn
ZXMpLg0KPg0KPg0KPiBTdXBwb3J0IGZvciBsYXJnZSBmb2xpb3Mgd291bGQgbm90IGJlIGEgcmVx
dWlyZW1lbnQuIEl0J3MganVzdCBhIHJlYWxseQ0KPiBnb29kIGlkZWEgaWYgeW91IGNhcmUgYWJv
dXQgcGVyZm9ybWFuY2UgOy0pDQoNClRoZXJlJ3MgYmVlbiBzb21lIHdvcmsgdG93YXJkcyBmb2xp
b3MsIGJ1dCBub3RoaW5nIGNvbXByZWhlbnNpdmUgaS5lLiB3ZQ0Kc3RpbGwgaGF2ZSBhIGJ1bmNo
IG9mIHVzZXJzIG9mIG1tL2ZvbGlvLWNvbXBhdC5jLiBJJ3ZlIHNlZW4gc29tZSBwYXRjaGVzIGlu
LWZsaWdodA0KZm9yIGxhcmdlIGZvbGlvcywgYnV0IG5vdGhpbmcgbGFuZGVkLg0KDQo+IEkgaG9w
ZSBpdCBkb2Vzbid0IHN0aWxsIHVzZSAtPndyaXRlcGFnZS4gV2UncmUgYWxtb3N0IHJpZCBvZiBp
dCBpbg0KPiBmaWxlc3lzdGVtcy4NCg0KSXQncyBzdGlsbCB0aGVyZSAtIEkgZG9uJ3QgdGhpbmsg
YW55b25lIGhhcyBzZXJpb3VzbHkgbG9va2VkIGF0IGhvdyB3ZWxsDQpMdXN0cmUgYmVoYXZlcyB3
aXRob3V0IGl0Lg0KDQo+IFVsdGltYXRlbHksIEkgdGhpbmsgeW91J2xsIHdhbnQgdG8gZGVzY3Jp
YmUgdGhlIHdvcmtmbG93IHlvdSBzZWUgTHVzdHJlDQo+IGFkb3B0aW5nIG9uY2UgaXQncyB1cHN0
cmVhbSAtLSBJJ3ZlIGhhZCB0b28gbWFueSBmaWxlc3lzdGVtcyBzYXkgdG8gbWUNCj4gIk9oLCB5
b3UgaGF2ZSB0byBzdWJtaXQgeW91ciBwYXRjaCBhZ2FpbnN0IG91ciBnaXQgdHJlZSBhbmQgdGhl
biB3ZSdsbA0KPiBhcHBseSBpdCB0byB0aGUga2VybmVsIGxhdGVyIi4gVGhhdCdzIG5vdCBhY2Nl
cHRhYmxlOyB0aGUga2VybmVsIGlzDQo+IHVwc3RyZWFtLCBub3QgeW91ciBwcml2YXRlIGdpdCB0
cmVlLg0KDQpUaGlzIGlzIHByb2JhYmx5IHRoZSBiaWdnZXN0IHF1ZXN0aW9uLiBTdGFnaW5nIGRp
ZG4ndCBmYXJlIHdlbGwgd2l0aCBtb3N0DQpkZXZlbG9wbWVudCBoYXBwZW5pbmcgb3V0LW9mLXRy
ZWUuIFdlIGhhdmUgdG8gcmV3b3JrIHRoZSBkZXZlbG9wbWVudA0Kd29ya2Zsb3cgdG8gc29tZWhv
dyBnZW5lcmF0ZSBwYXRjaGVzIGFnYWluc3QgYW4gYWN0dWFsIGtlcm5lbA0KdHJlZSB2ZXJzdXMg
b3VyIHNlcGFyYXRlIGdpdCB0cmVlLiBJIGhhdmUgYSBoaWdoIGxldmVsIGlkZWEgb2YgaG93IHdl
J2QNCmdldCB0aGVyZSAtIGluIHRlcm1zIG9mIHJlb3JnYW5pemluZyBhbmQgc3BsaXR0aW5nIHRo
ZSBleGlzdGluZyByZXBvIFsxXS4NCg0KVGhhdCdzIHdoYXQgSSdkIGJlIG1vc3QgaW50ZXJlc3Rl
ZCBpbiBkaXNjdXNzaW5nIGF0IExTRi4gSWYgd2UgY2hhbmdlDQp0aGUgZGV2ZWxvcG1lbnQgbW9k
ZWwsIGhvdyBkbyB3ZSBkZW1vbnN0cmF0ZSB0aGUgbW9kZWwgaXMgZWZmZWN0aXZlPw0KDQpJIGd1
ZXNzIGFub3RoZXIgaW50ZXJlc3RpbmcgcXVlc3Rpb24gd291bGQgYmU6IGhhcyBhbnkgb3RoZXIg
c3Vic3lzdGVtDQpvciBtYWpvciBkcml2ZXIgdW5kZXJnb25lIGEgdHJhbnNpdGlvbiBsaWtlIHRo
aXMgYmVmb3JlPw0KDQpUaW0gRGF5DQoNClsxXSBodHRwczovL3dpa2kubHVzdHJlLm9yZy9VcHN0
cmVhbV9jb250cmlidXRpbmcNCg0K

