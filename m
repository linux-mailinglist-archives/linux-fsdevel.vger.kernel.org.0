Return-Path: <linux-fsdevel+bounces-40416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB0A232EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B68F18867F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C91EB9E3;
	Thu, 30 Jan 2025 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uoSLl5PM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DF4C7C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258332; cv=none; b=f1VgRMUQDxqNweN40OWUyyIkqtjsimOYnzrQ9MggpjPnnjVvOh5xB4bN2xcZJMl1rZ045oHNNxed7VJKa+N/es8XTTSZQxEfRVBdhCnJ4uKN88/WlaHIp083Z4c3vAyijntqqs1iCrxk45n+G9ZQxhPmNBIUe9HC+eueq7RkWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258332; c=relaxed/simple;
	bh=UuEdP8E4DhSAhUqrwlKXuuC4qfhYKhlaikl2d0NIXJE=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sJZ4bw4FdkWnMCLm7Yg45/NmkmBVjVoWUwoQKeOatIMqfm+r72We+Q9MuGw2b0dWH1nLKFsQnKcBsSbQWK+cCzsgDxPK9K6iNvpy0olTPtUWs0PPFWaIJJbBaWoggcrBhbz6Or+8coCwLmILPlpZAavLkbBnYFGGcbbyDijlajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uoSLl5PM; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738258330; x=1769794330;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=UuEdP8E4DhSAhUqrwlKXuuC4qfhYKhlaikl2d0NIXJE=;
  b=uoSLl5PMgIPKsoslyxG8ZC1UKpkkRGeLg7s1EExHYeRGqK2kaOx+5a1/
   t9XCznGNT7PVSPditpp5rBsw6ippW4TJ0jds3t65YZBZCw07JEJW60v61
   Yszh8HcHxDWEvTVZd6/5KLq9VmZ7pv0mQ7JXw2CuYFtyQuW3+9+7pTwCK
   E=;
X-IronPort-AV: E=Sophos;i="6.13,246,1732579200"; 
   d="scan'208";a="373194693"
Subject: Re: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Thread-Topic: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 17:32:09 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.44.209:34580]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.84.172:2525] with esmtp (Farcaster)
 id 16cb664c-c552-4b9c-86bf-998b9a7999b7; Thu, 30 Jan 2025 17:32:09 +0000 (UTC)
X-Farcaster-Flow-ID: 16cb664c-c552-4b9c-86bf-998b9a7999b7
Received: from EX19D017UEA004.ant.amazon.com (10.252.134.70) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 17:32:05 +0000
Received: from EX19D017UEA001.ant.amazon.com (10.252.134.93) by
 EX19D017UEA004.ant.amazon.com (10.252.134.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 17:32:04 +0000
Received: from EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed]) by
 EX19D017UEA001.ant.amazon.com ([fe80::bffb:623f:af5e:ebed%3]) with mapi id
 15.02.1258.039; Thu, 30 Jan 2025 17:32:04 +0000
From: "Day, Timothy" <timday@amazon.com>
To: Theodore Ts'o <tytso@mit.edu>
CC: Christoph Hellwig <hch@infradead.org>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jsimmons@infradead.org"
	<jsimmons@infradead.org>, Andreas Dilger <adilger@ddn.com>, "neilb@suse.de"
	<neilb@suse.de>
Thread-Index: AQHbbqGKPQGkNCnWmkGOpAnSPDKrX7MruoAAgABZxoCAA1TiAP//yvQAgABegAD//7YQAA==
Date: Thu, 30 Jan 2025 17:32:04 +0000
Message-ID: <D982D180-C528-417E-BA83-B0D2C1C983BD@amazon.com>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org>
 <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
 <20250130142820.GA401886@mit.edu>
 <0E992E6A-AF0D-4DFB-A014-5A08184821CD@amazon.com>
 <20250130165642.GA416991@mit.edu>
In-Reply-To: <20250130165642.GA416991@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <77F1E11FB913714F9FB735E0AE225F1E@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMS8zMC8yNSwgMTE6NTcgQU0sICJUaGVvZG9yZSBUcydvIiA8dHl0c29AbWl0LmVkdSA8bWFp
bHRvOnR5dHNvQG1pdC5lZHU+PiB3cm90ZToNCj4gT24gVGh1LCBKYW4gMzAsIDIwMjUgYXQgMDQ6
MTg6MjlQTSArMDAwMCwgRGF5LCBUaW1vdGh5IHdyb3RlOg0KPiA+DQo+ID4gTHVzdHJlIGhhcyBh
IGxvdCBvZiB1c2FnZSBhbmQgZGV2ZWxvcG1lbnQgb3V0c2lkZSBvZiBERE4vV2hhbWNsb3VkDQo+
ID4gWzFdWzJdLiBIUEUsIEFXUywgU3VTZSwgQXp1cmUsIGV0Yy4gQW5kIGF0IGxlYXN0IGF0IEFX
Uywgd2UgdXNlDQo+ID4gTHVzdHJlIG9uIGZhaXJseSB1cC10by1kYXRlIGtlcm5lbHMgWzNdWzRd
LiBBbmQgSSB0aGluayB0aGlzIGlzDQo+ID4gYmVjb21pbmcgbW9yZSBjb21tb24gLSBhbHRob3Vn
aCBJIGRvbid0IGhhdmUgc29saWQgZGF0YSBvbiB0aGF0Lg0KPg0KPg0KPiBJIGFncmVlIHRoYXQg
SSBhbSBzZWVpbmcgbW9yZSB1c2UvaW50ZXJlc3Qgb2YgTHVzdHJlIGluIHZhcmlvdXMgQ2xvdWQN
Cj4gZGVwbG95bWVudHMsIGFuZCB0byB0aGUgZXh0ZW50IHRoYXQgQ2xvdWQgY2xpZW50cyB0ZW5k
IHRvIHVzZSBuZXdlcg0KPiBMaW51eCBrZXJuZWxzIChlLmcuLCBjb21tb25seSwgdGhlIHRoZSBM
VFMgZnJvbSB0aGUgeWVhciBiZWZvcmUpIHRoYXQNCj4gY2VydGFpbmx5IGRvZXMgbWFrZSB0aGVt
IHVzZSBrZXJuZWxzIG5ld2VyIHRoYW4gYSB0eXBpY2FsIFJIRUwga2VybmVsLg0KPg0KPg0KPiBJ
dCdzIHByb2JhYmx5IGluaGVyZW50IGluIHRoZSBuYXR1cmUgb2YgY2x1c3RlciBmaWxlIHN5c3Rl
bXMgdGhhdCB0aGV5DQo+IHdvbid0IGJlIG9mIGludGVyZXN0IGZvciBob21lIHVzZXJzIHdobyBh
cmVuJ3QgZ29pbmcgdG8gYmUgcGF5aW5nIHRoZQ0KPiBjb3N0IG9mIGEgZG96ZW4gb3Igc28gQ2xv
dWQgVk0ncyBiZWluZyB1cCBvbiBhIG1vcmUtb3ItbGVzcyBjb250aW51b3VzDQo+IGJhc2lzLiBI
b3dldmVyLCB0aGUgcmVhbGl0eSBpcyB0aGF0IG1vcmUgbGlrZWx5IHRoYW4gbm90LCBkZXZlbG9w
ZXJzDQo+IHdobyBhcmUgbW9zdCBsaWtlbHkgdG8gYmUgdXNpbmcgdGhlIGxhdGVzdCB1cHN0cmVh
bSBrZXJuZWwsIG9yIG1heWJlDQo+IGV2ZW4gTGludXgtbmV4dCwgYXJlIG5vdCBnb2luZyB0byBi
ZSB1c2luZyBjbG91ZCBWTSdzLg0KDQpJIGRvbid0IGhhdmUgYSBnb29kIHNlbnNlIG9mIHdobydz
IHJ1bm5pbmcgYWJzb2x1dGUgbGF0ZXN0IG1haW5saW5lIG9yDQpsaW51eC1uZXh0LiBCdXQgYWdy
ZWVkLCBJIGRvdWJ0IHRoZXJlIHdpbGwgYmUgdG9ucyBvZiBob21lIHVzZXJzIG9mIEx1c3RyZQ0K
cG9zdC11cHN0cmVhbWluZy4gQWx0aG91Z2gsIHlvdSBjYW4gZGVmaW5pdGVseSBwbGF5IENvdW50
ZXIgU3RyaWtlIG9uDQphIGhvbWUgTHVzdHJlIHNldHVwLiBJJ3ZlIHBlcnNvbmFsbHkgdmFsaWRh
dGVkIHRoYXQuIDopDQoNCj4gPiBBbmQgaWYgeW91IGhhdmUgZGVkaWNhdGVkIGhhcmR3YXJlIC0g
c2V0dGluZyB1cCBhIHNtYWxsIGZpbGVzeXN0ZW0gb3Zlcg0KPiA+IFRDUC9JUCBpc24ndCBtdWNo
IGhhcmRlciB0aGFuIGFuIE5GUyBzZXJ2ZXIgSU1ITy4gSnVzdCBhIG1rZnMgYW5kDQo+ID4gbW91
bnQgcGVyIHN0b3JhZ2UgdGFyZ2V0LiBXaXRoIGEgc2luZ2xlIE1EUyBhbmQgT1NTLCB5b3Ugb25s
eSBuZWVkIHR3bw0KPiA+IGRpc2tzLiBTbyBJIHRoaW5rIHdlIGhhdmUgZXZlcnl0aGluZyB3ZSBu
ZWVkIHRvIGVuYWJsZSB1cHN0cmVhbQ0KPiA+IHVzZXJzL2RldnMgdG8gdXNlIEx1c3RyZSB3aXRo
b3V0IHRvbyBtdWNoIGhhc3NsZS4gSSB0aGluayBpdCdzIG1vc3RseSBhDQo+ID4gbWF0dGVyIG9m
IGRvY3VtZW50YXRpb24gYW5kIHNjcmlwdGluZy4NCj4NCj4gSG1tLi4uIHdvdWxkIGl0IGJlIHBv
c3NpYmxlIHRvIHNldCB1cCBhIHNpbXBsZSB0b3kgTHVzdHJlIGZpbGUgc3lzdGVtDQo+IHVzaW5n
IGEgc2luZ2xlIHN5c3RlbSBydW5uaW5nIGluIHFlbXUgLS0tIGkuZS4sIHVzaW5nIHNvbWV0aGlu
ZyBsaWtlIGENCj4ga3ZtLXhmc3Rlc3RzWzFdIHRlc3QgYXBwbGlhbmNlPyBUQ1AvSVAgb3ZlciBs
b29wYmFjayBtaWdodCBiZQ0KPiBpbnRlcmVzdGluZywgaWYgaXQncyBwb3Nzc2libGUgdG8gcnVu
IHRoZSBMdXN0cmUgTURTLCBPU1MsIGFuZCBjbGllbnQNCj4gb24gdGhlIHNhbWUga2VybmVsLiBU
aGlzIHdvdWxkIG1ha2UgcmVwcm8gdGVzdGluZyBhIHdob2xlIGxvdCBlYXNpZXIsDQo+IGlmIGFs
bCBzb21lb25lIGhhZCB0byBkbyB3YXMgcnVuIHRoZSBjb21tYW5kICJrdm0teGZzdGVzdHMgLWMg
bHVzdHJlIHNtb2tlIi4NCj4NCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS90eXRzby94ZnN0ZXN0
cy1ibGQvYmxvYi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9rdm0tcXVpY2tzdGFydC5tZCA8aHR0cHM6
Ly9naXRodWIuY29tL3R5dHNvL3hmc3Rlc3RzLWJsZC9ibG9iL21hc3Rlci9Eb2N1bWVudGF0aW9u
L2t2bS1xdWlja3N0YXJ0Lm1kPg0KDQpEZWZpbml0ZWx5IHBvc3NpYmxlLiBZb3UgY2FuIHJ1biBh
bGwgb2YgdGhlIEx1c3RyZSBzZXJ2aWNlcyBvbiB0aGUgc2FtZSBrZXJuZWwuDQpJIGhhdmUgTHVz
dHJlIHdvcmtpbmcgb24gYSBzaW1pbGFyIFFFTVUgc2V0dXAgYXMgcGFydCBvZiBLZW50J3Mga3Rl
c3QgcmVwbyBbMV0uDQpJIHVzZSBpdCB0byB0ZXN0L2RldmVsb3AgTHVzdHJlIHBhdGNoZXMgYWdh
aW5zdCBtYWlubGluZSBrZXJuZWxzIC0gbW9zdGx5IGZvciB0aGUNCkx1c3RyZSBpbi1tZW1vcnkg
T1NEIChpLmUuIHN0b3JhZ2UgYmFja2VuZCkgWzJdLiBTbyB3ZSBjYW4gZ2V0IGEgTHVzdHJlDQpk
ZXZlbG9wbWVudCB3b3JrZmxvdyB0aGF0J3MgcHJldHR5IHNpbWlsYXIgdG8gdGhlIGV4aXN0aW5n
IHdvcmtmbG93IGZvciBpbi10cmVlDQpmaWxlc3lzdGVtcywgSSB0aGluay4NCg0KVGltIERheQ0K
DQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2tvdmVyc3RyZWV0L2t0ZXN0DQpbMl0gaHR0cHM6Ly9y
ZXZpZXcud2hhbWNsb3VkLmNvbS9jL2ZzL2x1c3RyZS1yZWxlYXNlLysvNTU1OTQNCg0K

