Return-Path: <linux-fsdevel+bounces-25077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA249948B46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 10:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01671C21E90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 08:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF61BD034;
	Tue,  6 Aug 2024 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MhlOlm+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647051BD00A;
	Tue,  6 Aug 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932788; cv=none; b=SH5BNEvy0s8rrrGltRCvDuF5Ah7O+WWVuex77qy0MeIYkjMbWPHyFvHNwTt0qx9cU7BVtFlv/xtQvz6COfiPCKW74siysmD6hLlr/DS0mjMhBqM0y1nPK5fAh4PXjO5TB/E3c1dEYIbEiYpfUrNbKQ1kRX9fXj2BXU+D/ZcZMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932788; c=relaxed/simple;
	bh=XVIfxLlcD8aXE+J8hdCh5vskTp9Tk/E9A2XP/YqNYxM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HfQU3E1FQtw3a6lAEQ7PJHmvI2xoPVYT1p23ZCKvIg2j5v2rVWhKDSvnisPY3ytEQFVLm80wcIJ052Xpl1E643zLdSp+LG01LL7dgU8jjaQUXp5VEbKLIlP5mi7LzkXs6x3wAqeP5GFyJQwHbYg5tubtfYxcdKZDrDC+jIcnUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MhlOlm+a; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722932787; x=1754468787;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=XVIfxLlcD8aXE+J8hdCh5vskTp9Tk/E9A2XP/YqNYxM=;
  b=MhlOlm+aOEZc3P72AK339/IDVR1DnCY/lGvvAMaNcR2JL74F0ordZuef
   SKIMxBCwfHMKb/t8CU4owc56N4HraocMPszW/uf0vnHlpOVt0x5/QP82F
   P3ZbillGk/hJwgu98RPK5H4pmXFKJn3iFb9eRIVdwIDaGWl0Bp5Kxo9ul
   k=;
X-IronPort-AV: E=Sophos;i="6.09,267,1716249600"; 
   d="scan'208";a="318395121"
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Thread-Topic: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:26:23 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:17875]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.248:2525] with esmtp (Farcaster)
 id 4f4de83e-f658-4ec0-843f-65d77b69dbad; Tue, 6 Aug 2024 08:26:22 +0000 (UTC)
X-Farcaster-Flow-ID: 4f4de83e-f658-4ec0-843f-65d77b69dbad
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 6 Aug 2024 08:26:22 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 6 Aug 2024 08:26:22 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Tue, 6 Aug 2024 08:26:22 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "jack@suse.cz" <jack@suse.cz>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Durrant, Paul" <pdurrant@amazon.co.uk>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "nh-open-source@amazon.com"
	<nh-open-source@amazon.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Index: AQHa5xp7YUfIGy2/kUGqgjccLElzprIZFmqAgAA56gCAAJYYAA==
Date: Tue, 6 Aug 2024 08:26:21 +0000
Message-ID: <0ecbbd25ccddcdf79b90fdfd25ac62ade6cfd01c.camel@amazon.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
	 <20240805200151.oja474ju4i32y5bj@quack3> <20240805232908.GD676757@ziepe.ca>
In-Reply-To: <20240805232908.GD676757@ziepe.ca>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C847BE97C8F2447A1A080B33F49ABEA@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA4LTA1IGF0IDIwOjI5IC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+IA0KPiBPbiBNb24sIEF1ZyAwNSwgMjAyNCBhdCAxMDowMTo1MVBNICswMjAwLCBKYW4gS2Fy
YSB3cm90ZToNCj4gDQo+ID4gPiA0LiBEZXZpY2UgYXNzaWdubWVudDogYmVpbmcgYWJsZSB0byB1
c2UgZ3Vlc3RtZW1mcyBtZW1vcnkgZm9yDQo+ID4gPiBWRklPL2lvbW11ZmQgbWFwcGluZ3MsIGFu
ZCBhbGxvdyB0aG9zZSBtYXBwaW5ncyB0byBzdXJ2aXZlIGFuZCBjb250aW51ZQ0KPiA+ID4gdG8g
YmUgdXNlZCBhY3Jvc3Mga2V4ZWMuDQo+IA0KPiBUaGF0J3MgYSBmdW4gb25lLiBQcm9wb3NhbHMg
Zm9yIHRoYXQgd2lsbCBiZSB2ZXJ5IGludGVyZXN0aW5nIQ0KDQpZdXAhIFdlIGhhdmUgYW4gTFBD
IHNlc3Npb24gZm9yIHRoaXM7IGxvb2tpbmcgZm9yd2FyZCB0byBkaXNjdXNzaW5nIG1vcmUNCnRo
ZXJlOiBodHRwczovL2xwYy5ldmVudHMvZXZlbnQvMTgvY29udHJpYnV0aW9ucy8xNjg2Lw0KSSds
bCBiZSB3b3JraW5nIG9uIGEgaW9tbXVmZCBSRkMgc29vbjsgc2hvdWxkIGdldCBpdCBvdXQgYmVm
b3JlIHRoZW4uDQoNCj4gDQo+ID4gVG8gbWUgdGhlIGJhc2ljIGZ1bmN0aW9uYWxpdHkgcmVzZW1i
bGVzIGEgbG90IGh1Z2V0bGJmcy4gTm93IEkga25vdyB2ZXJ5DQo+ID4gbGl0dGxlIGRldGFpbHMg
YWJvdXQgaHVnZXRsYmZzIHNvIEkndmUgYWRkZWQgcmVsZXZhbnQgZm9sa3MgdG8gQ0MuIEhhdmUg
eW91DQo+ID4gY29uc2lkZXJlZCB0byBleHRlbmQgaHVnZXRsYmZzIHdpdGggdGhlIGZ1bmN0aW9u
YWxpdHkgeW91IG5lZWQgKHN1Y2ggYXMNCj4gPiBwcmVzZXJ2YXRpb24gYWNyb3NzIGtleGVjKSBp
bnN0ZWFkIG9mIGltcGxlbWVudGluZyBjb21wbGV0ZWx5IG5ldyBmaWxlc3lzdGVtPw0KPiANCj4g
SW4gbW0gY2lyY2xlcyB3ZSd2ZSBicm9hZGx5IGJlZW4gdGFsa2luZyBhYm91dCBzcGxpdHRpbmcg
dGhlICJtZW1vcnkNCj4gcHJvdmlkZXIiIHBhcnQgb3V0IG9mIGh1Z2V0bGJmcyBpbnRvIGl0cyBv
d24gbGF5ZXIuIFRoaXMgd291bGQgaW5jbHVkZQ0KPiB0aGUgY2FydmluZyBvdXQgb2Yga2VybmVs
IG1lbW9yeSBhdCBib290IGFuZCBvcmdhbml6aW5nIGl0IGJ5IHBhZ2UNCj4gc2l6ZSB0byBhbGxv
dyBodWdlIHB0ZXMuDQo+IA0KPiBJdCB3b3VsZCBtYWtlIGFsb3Qgb2Ygc2Vuc2UgdG8gaGF2ZSBv
bmx5IG9uZSBjYXJ2ZSBvdXQgbWVjaGFuaXNtLCBhbmQNCj4gc2V2ZXJhbCBjb25zdW1lcnMgLSBo
dWdldGxiZnMsIHRoZSBuZXcgcHJpdmF0ZSBndWVzdG1lbWZkLCB0aGlzIHRoaW5nLA0KPiBmb3Ig
ZXhhbXBsZS4NCg0KVGhlIGFjdHVhbCBhbGxvY2F0aW9uIGluIGd1ZXN0bWVtZnMgaXNuJ3QgdG9v
IGNvbXBsZXgsIGJhc2ljYWxseSBqdXN0IGENCmhvb2sgaW4gbWVtX2luaXQoKSAodGhhdCdzIGEg
Yml0IHl1Y2t5IGFzIGl0J3MgYXJjaC1zcGVjaWZpYykgYW5kIHRoZW4gYQ0KY2FsbCB0byBtZW1i
bG9jayBhbGxvY2F0b3IuDQpUaGF0IGJlaW5nIHNhaWQsIHRoZSBmdW5jdGlvbmFsaXR5IGZvciB0
aGlzIHBhdGNoIHNlcmllcyBpcyBjdXJyZW50bHkNCmludGVudGlvbmFsbHkgbGltaXRlZDogbWlz
c2luZyBOVU1BIHN1cHBvcnQsIGFuZCBvbmx5IGRvaW5nIFBNRCAoMiBNaUIpDQpibG9jayBhbGxv
Y2F0aW9ucyBmb3IgZmlsZXMgLSB3ZSB3YW50IFBVRCAoMSBHaUIpIHdoZXJlIHBvc3NpYmxlIGZh
bGxpbmcNCmJhY2sgdG8gc3BsaXR0aW5nIHRvIDIgTWlCIGZvciBzbWFsbGVyIGZpbGVzLiBUaGF0
IHdpbGwgY29tcGxpY2F0ZQ0KdGhpbmdzLCBzbyBwZXJoYXBzIGEgbWVtb3J5IHByb3ZpZGVyIHdp
bGwgYmUgdXNlZnVsIHdoZW4gdGhpcyBnZXRzIG1vcmUNCmZ1bmN0aW9uYWxseSBjb21wbGV0ZS4g
S2VlbiB0byBoZWFyIG1vcmUhDQoNCkpHDQoNCg0K

