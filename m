Return-Path: <linux-fsdevel+bounces-33466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934549B9171
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1820E1F21C09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5F19F421;
	Fri,  1 Nov 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jrIQIU3r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5C1990C0;
	Fri,  1 Nov 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466068; cv=none; b=XxGogc+V9CTQ+fS3/Qc82HmTl0XAzCa+PwEAD64QV2BWy6IAm2laFy7ukAe0xsAElFvJ3e6iEsjp1OhQTL90vIjKtMP+McwnHYZIgUVE487SbJY3DquvVRcM9B0+LyYwfn/4fufR7kk1fzFnMqJ0nXum3gXRRygGkpbzyw4JalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466068; c=relaxed/simple;
	bh=V6NpXkEbRqzudi+uwHwdqoba+Kdq76cN1fCEb58mUKg=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Za20bpdFj0xTbtL/HKA2X6nByOK5YN/pXeDIWxBKEfwS3aoP/DDE07kZ/tCZk59k7jbAVCADkqGFoKq7xCgf0A9ic83iCIAk+UgEgaleUMVV21r7OUWHQ2R7EjCeoSBCZ0DBhWzAjbspoyPMlW/87O+Ah0BQL5CpNyUr9gwjN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jrIQIU3r; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730466067; x=1762002067;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=V6NpXkEbRqzudi+uwHwdqoba+Kdq76cN1fCEb58mUKg=;
  b=jrIQIU3r0HNc3NYlXRelbA7HJ4WPR5WM5HCAuFxPcg3qEgwKvBXjWvC7
   4qwMIsqoeDIIipS4IVUK4gj/X1f6GGTvW+7DNWGtpek7asOLer/vZt2/X
   H6cyCAMfsglBxgEUJ486aCtO5Qq7WRYPAyRMoF5WLb+/YVRJSn1AGDcgR
   A=;
X-IronPort-AV: E=Sophos;i="6.11,249,1725321600"; 
   d="scan'208";a="692299084"
Subject: Re: [PATCH 05/10] guestmemfs: add file mmap callback
Thread-Topic: [PATCH 05/10] guestmemfs: add file mmap callback
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 13:01:03 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:37212]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.199:2525] with esmtp (Farcaster)
 id db462b59-ddb3-40e3-bdd1-54faaf62725c; Fri, 1 Nov 2024 13:01:01 +0000 (UTC)
X-Farcaster-Flow-ID: db462b59-ddb3-40e3-bdd1-54faaf62725c
Received: from EX19D004EUC002.ant.amazon.com (10.252.51.225) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 13:01:01 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D004EUC002.ant.amazon.com (10.252.51.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 13:01:01 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Fri, 1 Nov 2024 13:01:00 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Durrant, Paul"
	<pdurrant@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Index: AQHbKlc3IZ2PqNLJ5E+mkZOTFQYr3bKg/xKAgAAJ94CAAV52AA==
Date: Fri, 1 Nov 2024 13:01:00 +0000
Message-ID: <fe4dd4d2f5eb2209f0190d547fe29370554ceca8.camel@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
	 <20240805093245.889357-6-jgowans@amazon.com>
	 <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
	 <33a2fd519edc917d933517842cc077a19e865e3f.camel@amazon.com>
	 <20241031160635.GA35848@ziepe.ca>
In-Reply-To: <20241031160635.GA35848@ziepe.ca>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2534BC19271204C81B93414AFF56B02@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTEwLTMxIGF0IDEzOjA2IC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+IE9uIFRodSwgT2N0IDMxLCAyMDI0IGF0IDAzOjMwOjU5UE0gKzAwMDAsIEdvd2FucywgSmFt
ZXMgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDI0LTEwLTI5IGF0IDE2OjA1IC0wNzAwLCBFbGxpb3Qg
QmVybWFuIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBBdWcgMDUsIDIwMjQgYXQgMTE6MzI6NDBBTSAr
MDIwMCwgSmFtZXMgR293YW5zIHdyb3RlOg0KPiA+ID4gPiBNYWtlIHRoZSBmaWxlIGRhdGEgdXNh
YmxlIHRvIHVzZXJzcGFjZSBieSBhZGRpbmcgbW1hcC4gVGhhdCdzIGFsbCB0aGF0DQo+ID4gPiA+
IFFFTVUgbmVlZHMgZm9yIGd1ZXN0IFJBTSwgc28gdGhhdCdzIGFsbCBiZSBib3RoZXIgaW1wbGVt
ZW50aW5nIGZvciBub3cuDQo+ID4gPiA+IA0KPiA+ID4gPiBXaGVuIG1tYXBpbmcgdGhlIGZpbGUg
dGhlIFZNQSBpcyBtYXJrZWQgYXMgUEZOTUFQIHRvIGluZGljYXRlIHRoYXQgdGhlcmUNCj4gPiA+
ID4gYXJlIG5vIHN0cnVjdCBwYWdlcyBmb3IgdGhlIG1lbW9yeSBpbiB0aGlzIFZNQS4gUmVtYXBf
cGZuX3JhbmdlKCkgaXMNCj4gPiA+ID4gdXNlZCB0byBhY3R1YWxseSBwb3B1bGF0ZSB0aGUgcGFn
ZSB0YWJsZXMuIEFsbCBQVEVzIGFyZSBwcmUtZmF1bHRlZCBpbnRvDQo+ID4gPiA+IHRoZSBwZ3Rh
YmxlcyBhdCBtbWFwIHRpbWUgc28gdGhhdCB0aGUgcGd0YWJsZXMgYXJlIHVzYWJsZSB3aGVuIHRo
aXMNCj4gPiA+ID4gdmlydHVhbCBhZGRyZXNzIHJhbmdlIGlzIGdpdmVuIHRvIFZGSU8ncyBNQVBf
RE1BLg0KPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9yIHNlbmRpbmcgdGhpcyBvdXQhIEknbSBnb2lu
ZyB0aHJvdWdoIHRoZSBzZXJpZXMgd2l0aCB0aGUNCj4gPiA+IGludGVudGlvbiB0byBzZWUgaG93
IGl0IG1pZ2h0IGZpdCB3aXRoaW4gdGhlIGV4aXN0aW5nIGd1ZXN0X21lbWZkIHdvcmsNCj4gPiA+
IGZvciBwS1ZNL0NvQ28vR3VueWFoLg0KPiA+ID4gDQo+ID4gPiBJdCBtaWdodCd2ZSBiZWVuIG1l
bnRpb25lZCBpbiB0aGUgTU0gYWxpZ25tZW50IHNlc3Npb24gLS0geW91IG1pZ2h0IGJlDQo+ID4g
PiBpbnRlcmVzdGVkIHRvIGpvaW4gdGhlIGd1ZXN0X21lbWZkIGJpLXdlZWtseSBjYWxsIHRvIHNl
ZSBob3cgd2UgYXJlDQo+ID4gPiBvdmVybGFwcGluZyBbMV0uDQo+ID4gPiANCj4gPiA+IFsxXTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtL2FlNzk0ODkxLWZlNjktNDExYS1iODJlLTY5NjNi
NTk0YTYyYUByZWRoYXQuY29tL1QvDQo+ID4gDQo+ID4gSGkgRWxsaW90LCB5ZXMsIEkgdGhpbmsg
dGhhdCB0aGVyZSBpcyBhIGxvdCBtb3JlIG92ZXJsYXAgd2l0aA0KPiA+IGd1ZXN0X21lbWZkIG5l
Y2Vzc2FyeSBoZXJlLiBUaGUgaWRlYSB3YXMgdG8gZXh0ZW5kIGd1ZXN0bWVtZnMgYXQgc29tZQ0K
PiA+IHBvaW50IHRvIGhhdmUgYSBndWVzdF9tZW1mZCBzdHlsZSBpbnRlcmZhY2UsIGJ1dCBpdCB3
YXMgcG9pbnRlZCBvdXQgYXQNCj4gPiB0aGUgTU0gYWxpZ25tZW50IGNhbGwgdGhhdCBkb2luZyBz
byB3b3VsZCByZXF1aXJlIGd1ZXN0bWVtZnMgdG8NCj4gPiBkdXBsaWNhdGUgdGhlIEFQSSBzdXJm
YWNlIG9mIGd1ZXN0X21lbWZkLiBUaGlzIGlzIHVuZGVzaXJhYmxlLiBCZXR0ZXINCj4gPiB3b3Vs
ZCBiZSB0byBoYXZlIHBlcnNpc3RlbmNlIGltcGxlbWVudGVkIGFzIGEgY3VzdG9tIGFsbG9jYXRv
ciBiZWhpbmQgYQ0KPiA+IG5vcm1hbCBndWVzdF9tZW1mZC4gSSdtIG5vdCB0b28gc3VyZSBob3cg
dGhpcyB3b3VsZCBiZSBhY3R1YWxseSBkb25lIGluDQo+ID4gcHJhY3RpY2UsIHNwZWNpZmljYWxs
eToNCj4gPiAtIGhvdyB0aGUgcGVyc2lzdGVudCBwb29sIHdvdWxkIGJlIGRlZmluZWQNCj4gPiAt
IGhvdyBpdCB3b3VsZCBiZSBzdXBwbGllZCB0byBndWVzdF9tZW1mZA0KPiA+IC0gaG93IHRoZSBn
dWVzdF9tZW1mZHMgd291bGQgYmUgcmUtZGlzY292ZXJlZCBhZnRlciBrZXhlYw0KPiA+IEJ1dCBh
c3N1bWluZyB3ZSBjYW4gZmlndXJlIG91dCBzb21lIHdheSB0byBkbyB0aGlzLCBJIHRoaW5rIGl0
J3MgYQ0KPiA+IGJldHRlciB3YXkgdG8gZ28uDQo+IA0KPiBJIHRoaW5rIHRoZSBmaWxlc3lzdGVt
IGludGVyZmFjZSBzZWVtZWQgcmVhc29uYWJsZSwgeW91IGp1c3Qgd2FudA0KPiBvcGVuKCkgb24g
dGhlIGZpbGVzeXN0ZW0gdG8gcmV0dXJuIGJhY2sgYSBub3JtYWwgZ3Vlc3RfbWVtZmQgYW5kDQo+
IHJlLXVzZSBhbGwgb2YgdGhhdCBjb2RlIHRvIGltcGxlbWVudCBpdC4NCj4gDQo+IFdoZW4gb3Bl
bmVkIHRocm91Z2ggdGhlIGZpbGVzeXN0ZW0gZ3Vlc3RfbWVtZmQgd291bGQgZ2V0IGhvb2tlZCBi
eSB0aGUNCj4gS0hPIHN0dWZmIHRvIG1hbmFnZSBpdHMgbWVtb3J5LCBzb21laG93Lg0KPiANCj4g
UmVhbGx5IEtITyBqdXN0IG5lZWRzIHRvIGtlZXAgdHJhY2sgb2YgdGhlIGFkZHJlc2VzcyBpbiB0
aGUNCj4gZ3Vlc3RfbWVtZmQgd2hlbiBpdCBzZXJpYWxpemVzLCByaWdodD8gU28gbWF5YmUgYWxs
IGl0IG5lZWRzIGlzIGEgd2F5DQo+IHRvIGZyZWV6ZSB0aGUgZ3Vlc3RfbWVtZmQgc28gaXQncyBt
ZW1vcnkgbWFwIGRvZXNuJ3QgY2hhbmdlIGFueW1vcmUsDQo+IHRoZW4gYSB3YXkgdG8gZXh0cmFj
dCB0aGUgYWRkcmVzc2VzIGZyb20gaXQgZm9yIHNlcmlhbGl6YXRpb24/DQoNClRoYW5rcyBKYXNv
biwgdGhhdCBzb3VuZHMgcGVyZmVjdC4gSSdsbCB3b3JrIG9uIHRoZSBuZXh0IHJldiB3aGljaCB3
aWxsOg0KLSBleHBvc2UgYSBmaWxlc3lzdGVtIHdoaWNoIG93bnMgcmVzZXJ2ZWQvcGVyc2lzdGVu
dCBtZW1vcnksIGp1c3QgbGlrZQ0KdGhpcyBwYXRjaC4NCi0gcmViYXNlZCBvbiB0b3Agb2YgdGhl
IHBhdGNoZXMgd2hpY2ggcHVsbCBvdXQgdGhlIGd1ZXN0X21lbWZkIGNvZGUgaW50bw0KYSBsaWJy
YXJ5DQotIHJlYmFzZWQgb24gdG9wIG9mIHRoZSBndWVzdF9tZW1mZCBwYXRjaGVzIHdoaWNoIHN1
cHBvcnRzIGFkZGluZyBhDQpkaWZmZXJlbnQgYmFja2luZyBhbGxvY2F0b3IgKGh1Z2V0bGJmcykg
dG8gZ3Vlc3RfbWVtZmQNCi0gd2hlbiBhIGZpbGUgaW4gZ3Vlc3RtZW1mcyBpcyBvcGVuZWQsIGNy
ZWF0ZSBhIGd1ZXN0X21lbWZkIG9iamVjdCBmcm9tDQp0aGUgZ3Vlc3RfbWVtZmQgbGlicmFyeSBj
b2RlIGFuZCBzZXQgZ3Vlc3RtZW1mcyBhcyB0aGUgY3VzdG9tIGFsbG9jYXRvcg0KZm9yIHRoZSBm
aWxlLg0KLSBzZXJpYWxpc2UgYW5kIHJlLWh5ZHJhdGUgdGhlIGd1ZXN0X21lbWZkcyB3aGljaCBo
YXZlIGJlZW4gY3JlYXRlZCBpbg0KZ3Vlc3RtZW1mcyBvbiBrZXhlYyB2aWEgS0hPLg0KDQpUaGUg
bWFpbiBkaWZmZXJlbmNlIGlzIHRoYXQgb3BlbmluZyBhIGd1ZXN0bWVtZnMgZmlsZSB3b24ndCBn
aXZlIGENCnJlZ3VsYXIgZmlsZSwgcmF0aGVyIGl0IHdpbGwgZ2l2ZSBhIGd1ZXN0X21lbWZkIGxp
YnJhcnkgb2JqZWN0LiBUaGlzDQp3aWxsIGdpdmUgZ29vZCBjb2RlIHJlLXVzZWQgd2l0aCBndWVz
dF9tZW1mZCBsaWJyYXJ5IGFuZCBwcmV2ZW50IG5lZWRpbmcNCnRvIHJlLWltcGxlbWVudCB0aGUg
Z3Vlc3RfbWVtZmQgQVBJIHN1cmZhY2UgaGVyZS4NCg0KU291bmRzIGxpa2UgYSBncmVhdCBwYXRo
IGZvcndhcmQuIDotKQ0KDQpKRw0KDQo+IA0KPiBKYXNvbg0KDQo=

