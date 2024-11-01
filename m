Return-Path: <linux-fsdevel+bounces-33464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749AE9B9152
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AE11F22059
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998C19EEC2;
	Fri,  1 Nov 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DFK+KNAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBFAF9D9;
	Fri,  1 Nov 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465591; cv=none; b=pdsD7D8Lv8qxL8dbDz5dQZIxQ0WOjFxVOfPgiX1SHxus8/8Fus9sCZwZyGXPzb8PKNKZqFEXqizC4N16Li9j/NJ2a0Ewxviwut/pYTk1syIlm/TUBO6HFL1V8nNAJlc168n3kcyvAWHljflD2aoMVeXet/PQMbxqWJh6sob+soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465591; c=relaxed/simple;
	bh=Z2Xc/FMNYDrdOd4IOmaJMwKHtzD7DGi6YvToIsrdRfY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nk1/akpR4yFOQ+VG+Vy2nVRmu9qNOI/nXFO/8i78e1hG+FBWZbrznR+cmDhWvYR2aSiVk0EQLvVa0p16wSuM4xvfzMJPWUKGblRe5d95yEnlGjpBOujzPGOftBYuxxzMvy2Q1AXgQi8aIwg2MzFDzBGKKLxPsltjPh+/tIlpQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DFK+KNAe; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730465590; x=1762001590;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=Z2Xc/FMNYDrdOd4IOmaJMwKHtzD7DGi6YvToIsrdRfY=;
  b=DFK+KNAey1PGsbiDVcSlb69Jj1GaEsm3/+AprMzsvdHpQ+qCdU8QSKgr
   gHlYhWXdYMzKCmd9C8wzARKwczyG3GRIyhH7M4ZsueWJ5BPW+C7sLD2bx
   w8DtAWCWhH9dNlMqEAhZ4FBDxP2JwxvbaLJKbF1eUQzcC0d60kLPOBFEm
   A=;
X-IronPort-AV: E=Sophos;i="6.11,249,1725321600"; 
   d="scan'208";a="381711897"
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Thread-Topic: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 12:53:05 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:47038]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.52:2525] with esmtp (Farcaster)
 id a533ecb5-77c4-4ef5-a7b8-6ddce04c94c6; Fri, 1 Nov 2024 12:53:02 +0000 (UTC)
X-Farcaster-Flow-ID: a533ecb5-77c4-4ef5-a7b8-6ddce04c94c6
Received: from EX19D004EUC004.ant.amazon.com (10.252.51.191) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 12:53:02 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D004EUC004.ant.amazon.com (10.252.51.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 12:53:01 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Fri, 1 Nov 2024 12:53:01 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "vannapurve@google.com" <vannapurve@google.com>
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
Thread-Index: AQHbIFCHYUfIGy2/kUGqgjccLElzprKieVSA
Date: Fri, 1 Nov 2024 12:53:01 +0000
Message-ID: <106e5faeaab5095cca21f8cadd34d65121efc45a.camel@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
	 <CAGtprH949pMq0GrQzyMvHNCFet+5MrcYBd=qPEscW1KtV5LjXg@mail.gmail.com>
In-Reply-To: <CAGtprH949pMq0GrQzyMvHNCFet+5MrcYBd=qPEscW1KtV5LjXg@mail.gmail.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <79C2095C1D329246948762716CBA6E42@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTEwLTE3IGF0IDEwOjIzICswNTMwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiBPbiBNb24sIEF1ZyA1LCAyMDI0IGF0IDM6MDPigK9QTSBKYW1lcyBHb3dhbnMgPGpnb3dh
bnNAYW1hem9uLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSW4gdGhpcyBwYXRjaCBzZXJpZXMgYSBu
ZXcgaW4tbWVtb3J5IGZpbGVzeXN0ZW0gZGVzaWduZWQgc3BlY2lmaWNhbGx5DQo+ID4gZm9yIGxp
dmUgdXBkYXRlIGlzIGltcGxlbWVudGVkLiBMaXZlIHVwZGF0ZSBpcyBhIG1lY2hhbmlzbSB0byBz
dXBwb3J0DQo+ID4gdXBkYXRpbmcgYSBoeXBlcnZpc29yIGluIGEgd2F5IHRoYXQgaGFzIGxpbWl0
ZWQgaW1wYWN0IHRvIHJ1bm5pbmcNCj4gPiB2aXJ0dWFsIG1hY2hpbmVzLiBUaGlzIGlzIGRvbmUg
YnkgcGF1c2luZy9zZXJpYWxpc2luZyBydW5uaW5nIFZNcywNCj4gPiBrZXhlYy1pbmcgaW50byBh
IG5ldyBrZXJuZWwsIHN0YXJ0aW5nIG5ldyBWTU0gcHJvY2Vzc2VzIGFuZCB0aGVuDQo+ID4gZGVz
ZXJpYWxpc2luZy9yZXN1bWluZyB0aGUgVk1zIHNvIHRoYXQgdGhleSBjb250aW51ZSBydW5uaW5n
IGZyb20gd2hlcmUNCj4gPiB0aGV5IHdlcmUuIFRvIHN1cHBvcnQgdGhpcywgZ3Vlc3QgbWVtb3J5
IG5lZWRzIHRvIGJlIHByZXNlcnZlZC4NCj4gPiANCj4gPiBHdWVzdG1lbWZzIGltcGxlbWVudHMg
cHJlc2VydmF0aW9uIGFjcm9zc3Mga2V4ZWMgYnkgY2FydmluZyBvdXQgYSBsYXJnZQ0KPiA+IGNv
bnRpZ3VvdXMgYmxvY2sgb2YgaG9zdCBzeXN0ZW0gUkFNIGVhcmx5IGluIGJvb3Qgd2hpY2ggaXMg
dGhlbiB1c2VkIGFzDQo+ID4gdGhlIGRhdGEgZm9yIHRoZSBndWVzdG1lbWZzIGZpbGVzLiBBcyB3
ZWxsIGFzIHByZXNlcnZpbmcgdGhhdCBsYXJnZQ0KPiA+IGJsb2NrIG9mIGRhdGEgbWVtb3J5IGFj
cm9zcyBrZXhlYywgdGhlIGZpbGVzeXN0ZW0gbWV0YWRhdGEgaXMgcHJlc2VydmVkDQo+ID4gdmlh
IHRoZSBLZXhlYyBIYW5kIE92ZXIgKEtITykgZnJhbWV3b3JrIChzdGlsbCB1bmRlciByZXZpZXcp
Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDExNzE0NDcwNC42MDItMS1n
cmFmQGFtYXpvbi5jb20vDQo+ID4gDQo+ID4gRmlsZXN5c3RlbSBtZXRhZGF0YSBpcyBzdHJ1Y3R1
cmVkIHRvIG1ha2UgcHJlc2VydmF0aW9uIGFjcm9zcyBrZXhlYw0KPiA+IGVhc3k6IGlub2RlcyBh
cmUgb25lIGxhcmdlIGNvbnRpZ3VvdXMgYXJyYXksIGFuZCBlYWNoIGlub2RlIGhhcyBhDQo+ID4g
Im1hcHBpbmdzIiBibG9jayB3aGljaCBkZWZpbmVzIHdoaWNoIGJsb2NrIGZyb20gdGhlIGZpbGVz
eXN0ZW0gZGF0YQ0KPiA+IG1lbW9yeSBjb3JyZXNwb25kcyB0byB3aGljaCBvZmZzZXQgaW4gdGhl
IGZpbGUuDQo+ID4gDQo+ID4gVGhlcmUgYXJlIGFkZGl0aW9uYWwgY29uc3RyYWludHMvcmVxdWly
ZW1lbnRzIHdoaWNoIGd1ZXN0bWVtZnMgYWltcyB0bw0KPiA+IG1lZXQ6DQo+ID4gDQo+ID4gMS4g
U2VjcmV0IGhpZGluZzogYWxsIGZpbGVzeXN0ZW0gZGF0YSBpcyByZW1vdmVkIGZyb20gdGhlIGtl
cm5lbCBkaXJlY3QNCj4gPiBtYXAgc28gaW1tdW5lIGZyb20gc3BlY3VsYXRpdmUgYWNjZXNzLiBy
ZWFkKCkvd3JpdGUoKSBhcmUgbm90IHN1cHBvcnRlZDsNCj4gPiB0aGUgb25seSB3YXkgdG8gZ2V0
IGF0IHRoZSBkYXRhIGlzIHZpYSBtbWFwLg0KPiA+IA0KPiA+IDIuIFN0cnVjdCBwYWdlIG92ZXJo
ZWFkIGVsaW1pbmF0aW9uOiB0aGUgbWVtb3J5IGlzIG5vdCBtYW5hZ2VkIGJ5IHRoZQ0KPiA+IGJ1
ZGR5IGFsbG9jYXRvciBhbmQgaGVuY2UgaGFzIG5vIHN0cnVjdCBwYWdlcy4NCj4gPiANCj4gPiAz
LiBQTUQgYW5kIFBVRCBsZXZlbCBhbGxvY2F0aW9ucyBmb3IgVExCIHBlcmZvcm1hbmNlOiBndWVz
dG1lbWZzDQo+ID4gYWxsb2NhdGVzIFBNRC1zaXplZCBwYWdlcyB0byBiYWNrIGZpbGVzIHdoaWNo
IGltcHJvdmVzIFRMQiBwZXJmIChjYXZlYXQNCj4gPiBiZWxvdyEpLiBQVUQgc2l6ZSBhbGxvY2F0
aW9ucyBhcmUgYSBuZXh0IHN0ZXAuDQo+ID4gDQo+ID4gNC4gRGV2aWNlIGFzc2lnbm1lbnQ6IGJl
aW5nIGFibGUgdG8gdXNlIGd1ZXN0bWVtZnMgbWVtb3J5IGZvcg0KPiA+IFZGSU8vaW9tbXVmZCBt
YXBwaW5ncywgYW5kIGFsbG93IHRob3NlIG1hcHBpbmdzIHRvIHN1cnZpdmUgYW5kIGNvbnRpbnVl
DQo+ID4gdG8gYmUgdXNlZCBhY3Jvc3Mga2V4ZWMuDQo+ID4gDQo+ID4gDQo+ID4gTmV4dCBzdGVw
cw0KPiA+ID09PT09PT09PQ0KPiA+IA0KPiA+IFRoZSBpZGVhIGlzIHRoYXQgdGhpcyBwYXRjaCBz
ZXJpZXMgaW1wbGVtZW50cyBhIG1pbmltYWwgZmlsZXN5c3RlbSB0bw0KPiA+IHByb3ZpZGUgdGhl
IGZvdW5kYXRpb25zIGZvciBpbi1tZW1vcnkgcGVyc2lzdGVudCBhY3Jvc3Mga2V4ZWMgZmlsZXMu
DQo+ID4gT25lIHRoaXMgZm91bmRhdGlvbiBpcyBpbiBwbGFjZSBpdCB3aWxsIGJlIGV4dGVuZGVk
Og0KPiA+IA0KPiA+IDEuIEltcHJvdmUgdGhlIGZpbGVzeXN0ZW0gdG8gYmUgbW9yZSBjb21wcmVo
ZW5zaXZlIC0gY3VycmVudGx5IGl0J3MganVzdA0KPiA+IGZ1bmN0aW9uYWwgZW5vdWdoIHRvIGRl
bW9uc3RyYXRlIHRoZSBtYWluIG9iamVjdGl2ZSBvZiByZXNlcnZlZCBtZW1vcnkNCj4gPiBhbmQg
cGVyc2lzdGVuY2UgdmlhIEtITy4NCj4gPiANCj4gPiAyLiBCdWlsZCBzdXBwb3J0IGZvciBpb21t
dWZkIElPQVMgYW5kIEhXUFQgcGVyc2lzdGVuY2UsIGFuZCBpbnRlZ3JhdGUNCj4gPiB0aGF0IHdp
dGggZ3Vlc3RtZW1mcy4gVGhlIGlkZWEgaXMgdGhhdCBpZiBWTXMgaGF2ZSBETUEgZGV2aWNlcyBh
c3NpZ25lZA0KPiA+IHRvIHRoZW0sIERNQSBzaG91bGQgY29udGludWUgcnVubmluZyBhY3Jvc3Mg
a2V4ZWMuIEEgZnV0dXJlIHBhdGNoIHNlcmllcw0KPiA+IHdpbGwgYWRkIHN1cHBvcnQgZm9yIHRo
aXMgaW4gaW9tbXVmZCBhbmQgY29ubmVjdCBpb21tdWZkIHRvIGd1ZXN0bWVtZnMNCj4gPiBzbyB0
aGF0IGd1ZXN0bWVtZnMgZmlsZXMgY2FuIHJlbWFpbiBtYXBwZWQgaW50byB0aGUgSU9NTVUgZHVy
aW5nIGtleGVjLg0KPiA+IA0KPiA+IDMuIFN1cHBvcnQgYSBndWVzdF9tZW1mZCBpbnRlcmZhY2Ug
dG8gZmlsZXMgc28gdGhhdCB0aGV5IGNhbiBiZSB1c2VkIGZvcg0KPiA+IGNvbmZpZGVudGlhbCBj
b21wdXRpbmcgd2l0aG91dCBuZWVkaW5nIHRvIG1tYXAgaW50byB1c2Vyc3BhY2UuDQo+IA0KPiBJ
IGFtIGd1ZXNzaW5nIHRoaXMgZ29hbCB3YXMgYmVmb3JlIHdlIGRpc2N1c3NlZCB0aGUgbmVlZCBv
ZiBzdXBwb3J0aW5nDQo+IG1tYXAgb24gZ3Vlc3RfbWVtZmQgZm9yIGNvbmZpZGVudGlhbCBjb21w
dXRpbmcgdXNlY2FzZXMgdG8gc3VwcG9ydA0KPiBodWdlcGFnZXMgWzFdLiBUaGlzIHNlcmllcyBb
MV0gYXMgb2YgdG9kYXkgdHJpZXMgdG8gbGV2ZXJhZ2UgaHVnZXRsYg0KPiBhbGxvY2F0b3IgZnVu
Y3Rpb25hbGl0eSB0byBhbGxvY2F0ZSBodWdlIHBhZ2VzIHdoaWNoIHNlZW1zIHRvIGJlIGFsb25n
DQo+IHRoZSBsaW5lcyBvZiB3aGF0IHlvdSBhcmUgYWltaW5nIGZvci4gVGhlcmUgYXJlIGFsc28g
ZGlzY3Vzc2lvbnMgdG8NCj4gc3VwcG9ydCBOVU1BIG1lbXBvbGljeSBbMl0gZm9yIGd1ZXN0IG1l
bWZkLiBJbiBvcmRlciB0byB1c2UNCj4gZ3Vlc3RfbWVtZmQgdG8gYmFjayBub24tY29uZmlkZW50
aWFsIFZNcyB3aXRoIGh1Z2VwYWdlcywgY29yZS1tbSB3aWxsDQo+IG5lZWQgdG8gc3VwcG9ydCBQ
TUQvUFVEIGxldmVsIG1hcHBpbmdzIGluIGZ1dHVyZS4NCj4gDQo+IERhdmlkIEgncyBzdWdnZXN0
aW9uIGZyb20gdGhlIG90aGVyIHRocmVhZCB0byBleHRlbmQgZ3Vlc3RfbWVtZmQgdG8NCj4gc3Vw
cG9ydCBndWVzdCBtZW1vcnkgcGVyc2lzdGVuY2Ugb3ZlciBrZXhlYyBpbnN0ZWFkIG9mIGludHJv
ZHVjaW5nDQo+IGd1ZXN0bWVtZnMgYXMgYSBwYXJhbGxlbCBzdWJzeXN0ZW0gc2VlbXMgYXBwZWFs
aW5nIHRvIG1lLg0KDQpJIHRoaW5rIHRoZXJlIGlzIGEgbG90IG9mIG92ZXJsYXAgd2l0aCB0aGUg
aHVnZSBwYWdlIGdvYWxzIGZvcg0KZ3Vlc3RfbWVtZmQuIEVzcGVjaWFsbHkgdGhlIDEgR2lCIGFs
bG9jYXRpb25zOyB0aGF0IGFsc28gbmVlZHMgYSBjdXN0b20NCmFsbG9jYXRvciB0byBiZSBhYmxl
IHRvIGFsbG9jYXRlIGNodW5rcyBmcm9tIHNvbWV0aGluZyBvdGhlciB0aGFuIGNvcmUNCk1NIGJ1
ZGR5IGFsbG9jYXRvci4gTXkgcm91Z2ggcGxhbiBpcyB0byByZWJhc2Ugb24gdG9wIG9mIHRoZSAx
IEdpQg0KZ3Vlc3RfbWVtZmQgc3VwcG9ydCBjb2RlLCBhbmQgYWRkIGd1ZXN0bWVtZnMgYXMgYW5v
dGhlciBhbGxvY2F0b3IsIHZlcnkNCnNpbWlsYXIgdG8gaHVnZXRsYmZzIDEgR2lCIGFsbG9jYXRp
b25zLg0KSSBzdGlsbCBuZWVkIHRvIGVuZ2FnZSBvbiB0aGUgaHVnZXRsYihmcz8pIGFsbG9jYXRv
ciBwYXRjaCBzZXJpZXMsIGJ1dCBJDQp0aGluayBpbiBjb25jZXB0IGl0J3MgYWxsIGdvaW5nIGlu
IHRoZSByaWdodCBkaXJlY3Rpb24gZm9yIHRoaXMNCnBlcnNpc3RlbmNlIHVzZSBjYXNlIHRvby4N
Cg0KSkcNCg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS9jb3Zlci4xNzI2
MDA5OTg5LmdpdC5hY2tlcmxleXRuZ0Bnb29nbGUuY29tL1QvDQo+IFsyXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9rdm0vNDc0NzZjMjctODk3Yy00NDg3LWJjZDItN2VmNmVjMDg5ZGQxQGFtZC5j
b20vVC8NCg0K

