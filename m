Return-Path: <linux-fsdevel+bounces-10617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8184CD21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A14F1F237E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7037F461;
	Wed,  7 Feb 2024 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tTWnapD5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA37E58E;
	Wed,  7 Feb 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317155; cv=none; b=Eh4Brx90RF61Ukw852jNN+GIzBJ9PFaWURemJ3qFykblB7b4MwT/+EQDV91PgVwjLL88Pm7U3CdejInNXq0tLygoLCqNKgjQYnAe0ZfEdjeKqynxFIU+6Q8+uSULDNCfWf76jGc6pXd7DTfUVE9gesjulPPYkL6q+9nxQwPLbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317155; c=relaxed/simple;
	bh=xnrWyx53VIUJEPzp2lM1BBf+Vnl0G17hwj5j4DVqdZc=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CD1AAcyDJ1iNDD9+AUDErgmnJ47H5y1RI9v53VKmHRJ/IphW3/toPL3iPyEFcWcWsf+QWP9XM9lByu3su5hobIZOBAYVE/ZnWMXQppGxjHCGF9Ac6D4bPfBlIglEdJD1VQnJzVjiXh1svJBBpXQs6xzHXZCnhCVEpkJ1Oa40zbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tTWnapD5; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707317154; x=1738853154;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=xnrWyx53VIUJEPzp2lM1BBf+Vnl0G17hwj5j4DVqdZc=;
  b=tTWnapD5uqvMpW/LeEJsRjIYD84cdGkrKKfyW2RLDEcqQOozn4EW4zVi
   /7gqi4s+7v2agEmbXLjx8U/Ya41BsGohqhf9VrsYsx0qDGgI4vKSFzfDu
   cY8ov/ldK0NLxOT/FuZB/ctDEeGx3eTZYvyhlCsONJ0WBZ43Ej3mBVlqL
   M=;
X-IronPort-AV: E=Sophos;i="6.05,251,1701129600"; 
   d="scan'208";a="379570168"
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Thread-Topic: [RFC 00/18] Pkernfs: Support persistence for live update
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 14:45:50 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:39014]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.146:2525] with esmtp (Farcaster)
 id a3b64052-5a7a-41d6-a2eb-422b30db9435; Wed, 7 Feb 2024 14:45:49 +0000 (UTC)
X-Farcaster-Flow-ID: a3b64052-5a7a-41d6-a2eb-422b30db9435
Received: from EX19D012EUC004.ant.amazon.com (10.252.51.220) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 7 Feb 2024 14:45:43 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC004.ant.amazon.com (10.252.51.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 7 Feb 2024 14:45:42 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Wed, 7 Feb 2024 14:45:42 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>, "will@kernel.org"
	<will@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "usama.arif@bytedance.com"
	<usama.arif@bytedance.com>
Thread-Index: AQHaWFq1iDfmUo9FfU6oG+xq/LSkjrD+9+4A
Date: Wed, 7 Feb 2024 14:45:42 +0000
Message-ID: <8e4cc7fd4c7cb14a8942e15a676e5b95e6f44b43.camel@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
	 <20240205174238.GC31743@ziepe.ca>
In-Reply-To: <20240205174238.GC31743@ziepe.ca>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A237CC033D44A4F89212FB75F123760@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSmFzb24sDQoNClRoYW5rcyBmb3IgdGhpcyBncmVhdCBmZWVkYmFjayBvbiB0aGUgYXBwcm9h
Y2ggLSBpdCdzIGV4YWN0bHkgdGhlIHNvcnQNCm9mIHRoaW5nIHdlIHdlcmUgbG9va2luZyBmb3Iu
DQoNCk9uIE1vbiwgMjAyNC0wMi0wNSBhdCAxMzo0MiAtMDQwMCwgSmFzb24gR3VudGhvcnBlIHdy
b3RlOg0KPiANCj4gT24gTW9uLCBGZWIgMDUsIDIwMjQgYXQgMTI6MDE6NDVQTSArMDAwMCwgSmFt
ZXMgR293YW5zIHdyb3RlOg0KPiANCj4gPiBUaGUgbWFpbiBhc3BlY3Qgd2XigJlyZSBsb29raW5n
IGZvciBmZWVkYmFjay9vcGluaW9ucyBvbiBoZXJlIGlzIHRoZSBjb25jZXB0IG9mDQo+ID4gcHV0
dGluZyBhbGwgcGVyc2lzdGVudCBzdGF0ZSBpbiBhIHNpbmdsZSBmaWxlc3lzdGVtOiBjb21iaW5p
bmcgZ3Vlc3QgUkFNIGFuZA0KPiA+IElPTU1VIHBndGFibGVzIGluIG9uZSBzdG9yZS4gQWxzbywg
dGhlIHF1ZXN0aW9uIG9mIGEgaGFyZCBzZXBhcmF0aW9uIGJldHdlZW4NCj4gPiBwZXJzaXN0ZW50
IG1lbW9yeSBhbmQgZXBoZW1lcmFsIG1lbW9yeSwgY29tcGFyZWQgdG8gYWxsb3dpbmcgYXJiaXRy
YXJ5IHBhZ2VzIHRvDQo+ID4gYmUgcGVyc2lzdGVkLiBQa2VybmZzIGRvZXMgaXQgdmlhIGEgaGFy
ZCBzZXBhcmF0aW9uIGRlZmluZWQgYXQgYm9vdCB0aW1lLCBvdGhlcg0KPiA+IGFwcHJvYWNoZXMg
Y291bGQgbWFrZSB0aGUgY2FydmluZyBvdXQgb2YgcGVyc2lzdGVudCBwYWdlcyBkeW5hbWljLg0K
PiANCj4gSSB0aGluayBpZiB5b3UgYXJlIGdvaW5nIHRvIGF0dGVtcHQgc29tZXRoaW5nIGxpa2Ug
dGhpcyB0aGVuIHRoZSBlbmQNCj4gcmVzdWx0IG11c3QgYnJpbmcgdGhpbmdzIGJhY2sgdG8gaGF2
aW5nIHRoZSBzYW1lIGRhdGEgc3RydWN0dXJlcyBmdWxseQ0KPiByZXN0b3JlZC4NCj4gDQo+IEl0
IGlzIGZpbmUgdGhhdCB0aGUgcGtlcm5mcyBob2xkcyBzb21lIHBlcnNpc3RhbnQgbWVtb3J5IHRo
YXQNCj4gZ3VhcmVudGVlcyB0aGUgSU9NTVUgY2FuIHJlbWFpbiBwcm9ncmFtbWVkIGFuZCB0aGUg
Vk0gcGFnZXMgY2FuIGJlY29tZQ0KPiBmaXhlZCBhY3Jvc3MgdGhlIGtleGVjDQo+IA0KPiBCdXQg
b25jZSB0aGUgVk1NIHN0YXJ0cyB0byByZXN0b3JlIGl0IHNlbGYgd2UgbmVlZCB0byBnZXQgYmFj
ayB0byB0aGUNCj4gb3JpZ2luYWwgY29uZmlndXJhdGlvbjoNCj4gIC0gQSBtbWFwIHRoYXQgcG9p
bnRzIHRvIHRoZSBWTSdzIHBoeXNpY2FsIHBhZ2VzDQo+ICAtIEFuIGlvbW11ZmQgSU9BUyB0aGF0
IHBvaW50cyB0byB0aGUgYWJvdmUgbW1hcA0KPiAgLSBBbiBpb21tdWZkIEhXUFQgdGhhdCByZXBy
ZXNlbnRzIHRoYXQgc2FtZSBtYXBwaW5nDQo+ICAtIEFuIGlvbW11X2RvbWFpbiBwcm9ncmFtbWVk
IGludG8gSFcgdGhhdCB0aGUgSFdQVA0KDQooQSBxdWljayBub3RlIG9uIGlvbW11ZmQgdnMgVkZJ
TzogSSdsbCBzdGlsbCBrZWVwIHJlZmVycmluZyB0byBWRklPIGZvcg0Kbm93IGJlY2F1c2UgdGhh
dCdzIHdoYXQgSSBrbm93LCBidXQgd2lsbCBleHBsb3JlIGlvbW11ZmQgbW9yZSBhbmQgcmVwbHkN
CmluIG1vcmUgZGV0YWlsIGFib3V0IGlvbW11ZmQgaW4gdGhlIG90aGVyIGVtYWlsIHRocmVhZC4p
DQoNCkhvdyBtdWNoIG9mIHRoaXMgZG8geW91IHRoaW5rIHNob3VsZCBiZSBkb25lIGF1dG9tYXRp
Y2FsbHksIHZzIGhvdyBtdWNoDQpzaG91bGQgdXNlcnNwYWNlIG5lZWQgdG8gZHJpdmU/IFdpdGgg
dGhpcyBSRkMgdXNlcnNwYWNlIGJhc2ljYWxseSByZS0NCmRyaXZlcyBldmVyeXRoaW5nLCBpbmNs
dWRpbmcgcmUtaW5qZWN0aW5nIHRoZSBmaWxlIGNvbnRhaW5pbmcgdGhlDQpwZXJzaXN0ZW50IHBh
Z2UgdGFibGVzIGludG8gdGhlIElPTU1VIGRvbWFpbiB2aWEgVkZJTy4NCg0KUGFydCBvZiB0aGUg
cmVhc29uIGlzIHNpbXBsaWNpdHksIHRvIGF2b2lkIGhhdmluZyBhdXRvLWRlc2VyaWFsaXNlIGNv
ZGUNCnBhdGhzIGluIHRoZSBkcml2ZXJzIGFuZCBtb2R1bGVzLiBBbm90aGVyIHBhcnQgb2YgdGhl
IHJlYXNvbiBzbyB0aGF0DQp1c2Vyc3BhY2UgY2FuIGdldCBGRCBoYW5kbGVzIG9uIHRoZSByZXNv
dXJjZXMuIFR5cGljYWxseSBGRHMgYXJlDQpyZXR1cm5lZCBieSBkb2luZyBhY3Rpb25zIGxpa2Ug
Y3JlYXRpbmcgVkZJTyBjb250YWluZXJzLiBJZiB3ZSBtYWtlIGFsbA0KdGhhdCBhdXRvbWF0aWMg
dGhlbiB0aGVyZSBuZWVkcyB0byBiZSBzb21lIG90aGVyIG1lY2hhbmlzbSBmb3IgYXV0by0NCnJl
c3RvcmVkIHJlc291cmNlcyB0byBwcmVzZW50IHRoZW1zZWx2ZXMgdG8gdXNlcnNwYWNlIHNvIHRo
YXQgdXNlcnNwYWNlDQpjYW4gZGlzY292ZXIgYW5kIHBpY2sgdGhlbSB1cCBhZ2Fpbi4NCg0KT25l
IHBvc3NpYmxlIHdheSB0byBkbyB0aGlzIHdvdWxkIGJlIHRvIHBvcHVsYXRlIGEgYnVuY2ggb2Yg
ZmlsZXMgaW4NCnByb2NmcyBmb3IgZWFjaCBwZXJzaXN0ZWQgSU9NTVUgZG9tYWluIHRoYXQgYWxs
b3dzIHVzZXJzcGFjZSB0byBkaXNjb3Zlcg0KYW5kIHBpY2sgaXQgdXAuDQoNCkNhbiB5b3UgZXhw
YW5kIG9uIHdoYXQgeW91IG1lYW4gYnkgIkEgbW1hcCB0aGF0IHBvaW50cyB0byB0aGUgVk0ncw0K
cGh5c2ljYWwgcGFnZXM/IiBBcmUgeW91IHN1Z2dlc3RpbmcgdGhhdCB0aGUgUUVNVSBwcm9jZXNz
IGF1dG9tYXRpY2FsbHkNCmdldHMgc29tZXRoaW5nIGFwcGVhcmluZyBpbiBpdCdzIGFkZHJlc3Mg
c3BhY2U/IFBhcnQgb2YgdGhlIGxpdmUgdXBkYXRlDQpwcm9jZXNzIGludm9sdmVzIHBvdGVudGlh
bGx5IGNoYW5naW5nIHRoZSB1c2Vyc3BhY2UgYmluYXJpZXM6IGRvaW5nDQprZXhlYyBhbmQgYm9v
dGluZyBhIG5ldyBzeXN0ZW0gaXMgYW4gb3Bwb3J0dW5pdHkgdG8gYm9vdCBuZXcgdmVyc2lvbnMg
b2YNCnRoZSB1c2Vyc3BhY2UgYmluYXJ5LiBTbyB3ZSBzaG91bGRuJ3QgdHJ5IHRvIHByZXNlcnZl
IHRvbyBtdWNoIG9mDQp1c2Vyc3BhY2Ugc3RhdGU7IGl0J3MgYmV0dGVyIHRvIGxldCBpdCByZS1j
cmVhdGUgaW50ZXJuYWwgZGF0YQ0Kc3RydWN0dXJlcyBkbyBmcmVzaCBtbWFwcy4NCg0KV2hhdCBJ
J20gcmVhbGx5IGFza2luZyBpczogZG8geW91IGhhdmUgYSBzcGVjaWZpYyBzdWdnZXN0aW9uIGFi
b3V0IGhvdw0KdGhlc2UgcGVyc2lzdGVudCByZXNvdXJjZXMgc2hvdWxkIHByZXNlbnQgdGhlbXNl
bHZlcyB0byB1c2Vyc3BhY2UgYW5kDQpob3cgdXNlcnNwYWNlIGNhbiBkaXNjb3ZlciB0aGVtIGFu
ZCBwaWNrIHRoZW0gdXA/DQoNCj4gDQo+IEllIHlvdSBjYW4ndCBqdXN0IHJlYm9vdCBhbmQgbGVh
dmUgdGhlIElPTU1VIGhhbmdpbmcgb3V0IGluIHNvbWUNCj4gdW5kZWZpbmVkIGxhbmQgLSBlc3Bl
Y2lhbGx5IGluIGxhdGVzdCBrZXJuZWxzIQ0KDQpOb3QgdG9vIHN1cmUgd2hhdCB5b3UgbWVhbiBi
eSAidW5kZWZpbmVkIGxhbmQiIC0gdGhlIGlkZWEgaXMgdGhhdCB0aGUNCklPTU1VIGtlZXBzIGRv
aW5nIHdoYXQgaXQgd2FzIGdvaW5nIHVudGlsIHVzZXJzcGFjZSBjb21lcyBhbG9uZyByZS0NCmNy
ZWF0ZXMgdGhlIGhhbmRsZXMgdG8gdGhlIElPTU1VIGF0IHdoaWNoIHBvaW50IGl0IGNhbiBkbyBt
b2RpZmljYXRpb25zDQpsaWtlIGNoYW5nZSBtYXBwaW5ncyBvciB0ZWFyIHRoZSBkb21haW4gZG93
bi4gVGhpcyBpcyB3aGF0IGRlZmVycmVkDQphdHRhY2hlZCBnaXZlcyB1cywgSSBiZWxpZXZlLCBh
bmQgd2h5IEkgaGFkIHRvIGNoYW5nZSBpdCB0byBiZSBlbmFibGVkLg0KSnVzdCBsZWF2ZSB0aGUg
SU9NTVUgZG9tYWluIGFsb25lIHVudGlsIHVzZXJzcGFjZSByZS1jcmVhdGVzIGl0IHdpdGggdGhl
DQpvcmlnaW5hbCB0YWJsZXMuDQpQZXJoYXBzIEknbSBtaXNzaW5nIHlvdXIgcG9pbnQuIDotKQ0K
DQo+IA0KPiBGb3IgdnQtZCB5b3UgbmVlZCB0byByZXRhaW4gdGhlIGVudGlyZSByb290IHRhYmxl
IGFuZCBhbGwgdGhlIHJlcXVpcmVkDQo+IGNvbnRleHQgZW50cmllcyB0b28sIFRoZSByZXN0YXJ0
aW5nIGlvbW11IG5lZWRzIHRvIHVuZGVyc3RhbmQgdGhhdCBpdA0KPiBoYXMgdG8gInJlc3RvcmUi
IGEgdGVtcG9yYXJ5IGlvbW11X2RvbWFpbiBmcm9tIHRoZSBwa2VybmZzLg0KPiBZb3UgY2FuIGxh
dGVyIHJlY29uc3RpdHV0ZSBhIHByb3BlciBpb21tdV9kb21haW4gZnJvbSB0aGUgVk1NIGFuZA0K
PiBhdG9taWMgc3dpdGNoLg0KDQpXaHkgZG9lcyBpdCBuZWVkIHRvIGdvIHZpYSBhIHRlbXBvcmFy
eSBkb21haW4/IFRoZSBjdXJyZW50IGFwcHJvYWNoIGlzDQpqdXN0IHRvIGxlYXZlIHRoZSBJT01N
VSBkb21haW4gcnVubmluZyBhcy1pcyB2aWEgZGVmZXJyZWQgYXR0YWNoZWQsIGFuZA0KbGF0ZXIg
d2hlbiB1c2Vyc3BhY2Ugc3RhcnRzIHVwIGl0IHdpbGwgY3JlYXRlIHRoZSBpb21tdV9kb21haW4g
YmFja2VkIGJ5DQp0aGUgc2FtZSBwZXJzaXN0ZW50IHBhZ2UgdGFibGVzLg0KPiANCj4gU28sIEkn
bSBzdXJwcmlzZWQgdG8gc2VlIHRoaXMgYXBwcm9hY2ggd2hlcmUgdGhpbmdzIGp1c3QgbGl2ZSBm
b3JldmVyDQo+IGluIHRoZSBrZXJuZnMsIEkgZG9uJ3Qgc2VlIGhvdyAicmVzdG9yZSIgaXMgZ29p
bmcgdG8gd29yayB2ZXJ5IHdlbGwNCj4gbGlrZSB0aGlzLg0KDQpDYW4geW91IGV4cGFuZCBvbiB3
aHkgdGhlIHN1Z2dlc3RlZCByZXN0b3JlIHBhdGggd2lsbCBiZSBwcm9ibGVtYXRpYz8gSW4NCnN1
bW1hcnkgdGhlIGlkZWEgaXMgdG8gcmUtY3JlYXRlIGFsbCBvZiB0aGUgImVwaGVtZXJhbCIgZGF0
YSBzdHJ1Y3R1cmVzDQpieSByZS1kb2luZyBpb2N0bHMgbGlrZSBNQVBfRE1BLCBidXQga2VlcGlu
ZyB0aGUgcGVyc2lzdGVudCBJT01NVQ0Kcm9vdC9jb250ZXh0IHRhYmxlcyBwb2ludGVkIGF0IHRo
ZSBvcmlnaW5hbCBwZXJzaXN0ZW50IHBhZ2UgdGFibGVzLiBUaGUNCmVwaGVtZXJhbCBkYXRhIHN0
cnVjdHVyZXMgYXJlIHJlLWNyZWF0ZWQgaW4gdXNlcnNwYWNlIGJ1dCB0aGUgcGVyc2lzdGVudA0K
cGFnZSB0YWJsZXMgbGVmdCBhbG9uZS4gVGhpcyBpcyBvZiBjb3Vyc2UgZGVwZW5kZW50IG9uIHVz
ZXJzcGFjZSByZS0NCmNyZWF0aW5nIHRoaW5ncyAqY29ycmVjdGx5KiAtIGl0IGNhbiBlYXNpbHkg
ZG8gdGhlIHdyb25nIHRoaW5nLiBQZXJoYXBzDQp0aGlzIGlzIHRoZSBpc3N1ZT8gT3IgaXMgdGhl
cmUgYSBwcm9ibGVtIGV2ZW4gaWYgdXNlcnNwYWNlIGlzIHNhbmUuDQoNCj4gSSB3b3VsZCB0aGlu
ayB0aGF0IGEgc2F2ZS9yZXN0b3JlIG1lbnRhbGl0aXR5IHdvdWxkIG1ha2UgbW9yZQ0KPiBzZW5z
ZS4gRm9yIGluc3RhbmNlIHlvdSBjb3VsZCBtYWtlIGEgc3BlY2lhbCBpb21tdV9kb21haW4gdGhh
dCBpcyBmaXhlZA0KPiBhbmQgbGl2ZXMgaW4gdGhlIHBrZXJuZnMuIFRoZSBvcGVyYXRpb24gd291
bGQgYmUgdG8gY29weSBmcm9tIHRoZSBsaXZlDQo+IGlvbW11X2RvbWFpbiB0byB0aGUgZml4ZWQg
b25lIGFuZCB0aGVuIHJlcGxhY2UgdGhlIGlvbW11IEhXIHRvIHRoZQ0KPiBmaXhlZCBvbmUuDQo+
IA0KPiBJbiB0aGUgcG9zdC1rZXhlYyB3b3JsZCB0aGUgaW9tbXUgd291bGQgcmVjcmVhdGUgdGhh
dCBzcGVjaWFsIGRvbWFpbg0KPiBhbmQgcG9pbnQgdGhlIGlvbW11IGF0IGl0LiAoY29weWluZyB0
aGUgcm9vdCBhbmQgY29udGV4dCBkZXNjcmlwdGlvbnMNCj4gb3V0IG9mIHRoZSBwa2VybmZzKS4g
VGhlbiBzb21laG93IHRoYXQgd291bGQgZ2V0IGludG8gaW9tbXVmZCBhbmQgVkZJTw0KPiBzbyB0
aGF0IGl0IGNvdWxkIHRha2Ugb3ZlciB0aGF0IHNwZWNpYWwgbWFwcGluZyBkdXJpbmcgaXRzIHN0
YXJ0dXAuDQoNClRoZSBzYXZlIGFuZCByZXN0b3JlIG1vZGVsIGlzIHN1cGVyIGludGVyZXN0aW5n
IC0gSSdtIGtlZW4gdG8gZGlzY3Vzcw0KdGhpcyBhcyBhbiBhbHRlcm5hdGl2ZS4gWW91J3JlIHN1
Z2dlc3RpbmcgdGhhdCBJT01NVSBkcml2ZXIgaGF2ZSBhDQpzZXJpYWxpc2UgcGhhc2UganVzdCBi
ZWZvcmUga2V4ZWMgd2hlcmUgaXQgZHVtcHMgZXZlcnl0aGluZyBpbnRvDQpwZXJzaXN0ZW50IG1l
bW9yeSBhbmQgdGhlbiBhZnRlciBrZXhlYyBwdWxscyBpdCBiYWNrIGludG8gZXBoZW1lcmFsDQpt
ZW1vcnkuIFRoYXQncyBwcm9iYWJseSBkby1hYmxlLCBidXQgaXQgbWF5IGluY3JlYXNlIHRoZSBj
cml0aWNhbA0Kc2VjdGlvbiBsYXRlbmN5IG9mIGxpdmUgdXBkYXRlIChldmVyeSBtaWxsaXNlY29u
ZCBjb3VudHMhKSBhbmQgSSdtIGFsc28NCm5vdCB0b28gc3VyZSB3aGF0IHRoYXQgYnV5cyBjb21w
YXJlZCB0byBhbHdheXMgd29ya2luZyB3aXRoIHBlcnNpc3RlbnQNCm1lbW9yeSBhbmQganVzdCBh
bHdheXMgYmVpbmcgaW4gYSBzdGF0ZSB3aGVyZSBwZXJzaXN0ZW50IGRhdGEgaXMgYWx3YXlzDQpi
ZWluZyB1c2VkIGFuZCBjYW4gYmUgcGlja2VkIHVwIGFzLWlzLg0KDQpIb3dldmVyLCB0aGUgaWRl
YSBvZiBhIHNlcmlhbGlzZSBhbmQgZGVzZXJpYWxpc2Ugb3BlcmF0aW9uIGlzIHJlbGV2YW50DQp0
byBhIHBvc3NpYmxlIGFsdGVybmF0aXZlIHRvIHRoaXMgUkZDLiBNeSBjb2xsZWFndWUgQWxleCBH
cmFmIGlzIHdvcmtpbmcNCm9uIGEgZnJhbWV3b3JrIGNhbGxlZCBLZXhlYyBIYW5kIE92ZXIgKEtI
Tyk6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAxMTcxNDQ3MDQuNjAyLTEtZ3Jh
ZkBhbWF6b24uY29tLyNyDQpUaGF0IGFsbG93cyBkcml2ZXJzL21vZHVsZXMgdG8gbWFyayBhcmJp
dHJhcnkgbWVtb3J5IHBhZ2VzIGFzIHBlcnNpc3RlbnQNCihpZTogbm90IGFsbG9jYXRhYmxlIGJ5
IG5leHQga2VybmVsKSBhbmQgdG8gcGFzcyBvdmVyIHNvbWUgc2VyaWFsaXNlZA0Kc3RhdGUgYWNy
b3NzIGtleGVjLg0KQW4gYWx0ZXJuYXRpdmUgdG8gSU9NTVUgZG9tYWluIHBlcnNpc3RlbmNlIGNv
dWxkIGJlIHRvIHVzZSBLSE8gdG8gbWFyaw0KdGhlIElPTU1VIHJvb3QsIGNvbnRleHQgYW5kIGRv
bWFpbiBwYWdlIHRhYmxlIHBhZ2VzIGFzIHBlcnNpc3RlbnQgdmlhDQpLSE8uDQoNCj4gDQo+IFRo
ZW4geW91J2QgYnVpbGQgdGhlIG5vcm1hbCBvcGVyYXRpbmcgaW9hcyBhbmQgaHdwdCAod2l0aCBh
bGwgdGhlDQo+IHJpZ2h0IHBhZ2UgcmVmY291bnRzL2V0YykgdGhlbiBzd2l0Y2ggdG8gaXQgYW5k
IGZyZWUgdGhlIHBrZXJuZnMNCj4gbWVtb3J5Lg0KPiANCj4gSXQgc2VlbXMgYWxvdCBsZXNzIGlu
dmFzaXZlIHRvIG1lLiBUaGUgc3BlY2lhbCBjYXNlIGlzIGNsZWFybHkgYQ0KPiBzcGVjaWFsIGNh
c2UgYW5kIGRvZXNuJ3QgbWVzcyB1cCB0aGUgbm9ybWFsIG9wZXJhdGlvbiBvZiB0aGUgZHJpdmVy
cy4NCg0KWWVzLCBhIHNlcmlhbGlzZS9kZXNlcmlhbGlzZSBhcHByb2FjaCBkb2VzIGhhdmUgdGhp
cyBkaXN0aW5jdCBhZHZhbnRhZ2UNCm9mIG5vdCBuZWVkaW5nIHRvIGNoYW5nZSB0aGUgYWxsb2Mv
ZnJlZSBjb2RlIHBhdGhzLiBQa2VybmZzIHJlcXVpcmVzIGENCnNoaW0gaW4gdGhlIGFsbG9jYXRv
ciB0byB1c2UgcGVyc2lzdGVudCBtZW1vcnkuDQoNCg0KPiANCj4gPiAqIE5lZWRpbmcgdG8gZHJp
dmUgYW5kIHJlLWh5ZHJhdGUgdGhlIElPTU1VIHBhZ2UgdGFibGVzIGJ5IGRlZmluaW5nIGFuIElP
TU1VIGZpbGUuDQo+ID4gUmVhbGx5IHdlIHNob3VsZCBtb3ZlIHRoZSBhYnN0cmFjdGlvbiBvbmUg
bGV2ZWwgdXAgYW5kIG1ha2UgdGhlIHdob2xlIFZGSU8NCj4gPiBjb250YWluZXIgcGVyc2lzdGVu
dCB2aWEgYSBwa2VybmZzIGZpbGUuIFRoYXQgd2F5IHlvdeKAmWQgImp1c3QiIHJlLW9wZW4gdGhl
IFZGSU8NCj4gPiBjb250YWluZXIgZmlsZSBhbmQgYWxsIG9mIHRoZSBETUEgbWFwcGluZ3MgaW5z
aWRlIFZGSU8gd291bGQgYWxyZWFkeSBiZSBzZXQgdXAuDQo+IA0KPiBJIGRvdWJ0IHRoaXMuLiBJ
dCBwcm9iYWJseSBuZWVkcyB0byBiZSBtdWNoIGZpbmVyIGdyYWluZWQgYWN0dWFsbHksDQo+IG90
aGVyd2lzZSB5b3UgYXJlIGdvaW5nIHRvIGJlIHNlcmlhbGl6aW5nIGV2ZXJ5dGhpbmcuIFNvbWVo
b3cgSSB0aGluaw0KPiB5b3UgYXJlIGJldHRlciB0byBzZXJpYWxpemUgYSBtaW5pbXVtIGFuZCB0
cnkgdG8gcmVjb25zdHJ1Y3QNCj4gZXZlcnl0aGluZyBlbHNlIGluIHVzZXJzcGFjZS4gTGlrZSBj
b25zZXJ2aW5nIGlvbW11ZmQgSURzIHdvdWxkIGJlIGENCj4gaHVnZSBQSVRBLg0KPiANCj4gVGhl
cmUgYXJlIGFsc28gZ29pbmcgdG8gYmUgbG90cyBvZiBzZWN1cml0eSBxdWVzdGlvbnMgaGVyZSwg
bGlrZSB3ZQ0KPiBjYW4ndCBqdXN0IGxldCB1c2Vyc3BhY2UgZmVlZCBpbiBhbnkgZ2FyYmFnZSBh
bmQgdmlvbGF0ZSB2ZmlvIGFuZA0KPiBpb21tdSBpbnZhcmlhbnRzLg0KDQpSaWdodCEgVGhpcyBp
cyBkZWZpbml0ZWx5IG9uZSBvZiB0aGUgYmlnIGdhcHMgYXQgdGhlIG1vbWVudDogdGhpcw0KYXBw
cm9hY2ggcmVxdWlyZXMgdGhhdCBWRklPIGhhcyB0aGUgc2FtZSBzdGF0ZSByZS1kcml2ZW4gaW50
byBpdCBmcm9tDQp1c2Vyc3BhY2Ugc28gdGhhdCB0aGUgcGVyc2lzdGVudCBhbmQgZXBoZW1lcmFs
IGRhdGEgbWF0Y2guIElmIHVzZXJzcGFjZQ0KZG9lcyBzb21ldGhpbmcgZG9kZ3ksIHdlbGwsIGl0
IG1heSBjYXVzZSBwcm9ibGVtcy4gOi0pDQpUaGF0J3MgZXhhY3RseSB3aHkgSSB0aG91Z2h0IHdl
IHNob3VsZCBtb3ZlIHRoZSBhYnN0cmFjdGlvbiB1cCB0byBhDQpsZXZlbCB0aGF0IGRvZXNuJ3Qg
ZGVwZW5kIG9uIHVzZXJzcGFjZSByZS1kcml2aW5nIGRhdGEuIEl0IHNvdW5kcyBsaWtlDQp5b3Ug
d2VyZSBzdWdnZXN0aW5nIHNpbWlsYXIgaW4gdGhlIGZpcnN0IHBhcnQgb2YgeW91ciBjb21tZW50
LCBidXQgSQ0KZGlkbid0IGZ1bGx5IHVuZGVyc3RhbmQgaG93IHlvdSdkIGxpa2UgdG8gc2VlIGl0
IHByZXNlbnRlZCB0byB1c2Vyc3BhY2UuDQoNCkpHDQo=

