Return-Path: <linux-fsdevel+bounces-14776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B51187F293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 22:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872F8B21A72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 21:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D16659B71;
	Mon, 18 Mar 2024 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vMrNwQMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9C59B4C;
	Mon, 18 Mar 2024 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798668; cv=none; b=BooM40GyuSo6Mw8acjrOGXKDfIa2c9sWHCgQaSWACI5Y5L7rp+vHOB5o/+vq19gtGiUUVSh9np/7UJdVMqEleIKFtQv83s9BOEIEZwdEXR6t0DY0Wy5V0gZIXsUQxL14QUU7QBs3B1lPBykXu8/8vDpDzyMiIlT0luisj0d8Y7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798668; c=relaxed/simple;
	bh=t48BTKEfxRoE6vzKtASN4ZILJHHG5zCzsAm9dMku81M=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8uDIfuN0tDFnVVoLRBnby4hiRsCAAkXTqAYsBkg7jWoLF2Jco2fFcSo0qes+e47bvBmBVEc4T7fiq+WnmLQJB5T0dx7w8sWIZRdQC5vGFnEgG0NjO5kXzdwIfBGRZR7/V8laEQ1NfkpJnnVedT1amxXG/osJ9B3QR41EM6baN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vMrNwQMP; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710798668; x=1742334668;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=t48BTKEfxRoE6vzKtASN4ZILJHHG5zCzsAm9dMku81M=;
  b=vMrNwQMPFt3AP+xSanYn4NRyYBARguQREY8s+HoA/BZuuM96di9FBqNg
   cRfWdtjcw0COmom4KbVcKh470ni1rj0b8k7xgiqkvlCh2skymyQxv16Hb
   DfLxXpHM+cq1l3fOzpn+WvoJVNyASEp0Tqbo8lwQgtWVhC8Ms/AGBmR+r
   c=;
X-IronPort-AV: E=Sophos;i="6.07,135,1708387200"; 
   d="scan'208";a="711898919"
Subject: Re: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Thread-Topic: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 21:51:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:7322]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.10:2525] with esmtp (Farcaster)
 id ee40fc96-dfbd-4d21-9a62-ccb2dc7432dc; Mon, 18 Mar 2024 21:51:05 +0000 (UTC)
X-Farcaster-Flow-ID: ee40fc96-dfbd-4d21-9a62-ccb2dc7432dc
Received: from EX19D023UWA001.ant.amazon.com (10.13.139.15) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 18 Mar 2024 21:51:04 +0000
Received: from EX19D023UWA003.ant.amazon.com (10.13.139.33) by
 EX19D023UWA001.ant.amazon.com (10.13.139.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 18 Mar 2024 21:51:04 +0000
Received: from EX19D023UWA003.ant.amazon.com ([fe80::2d45:e73:b7a8:15de]) by
 EX19D023UWA003.ant.amazon.com ([fe80::2d45:e73:b7a8:15de%6]) with mapi id
 15.02.1258.028; Mon, 18 Mar 2024 21:51:04 +0000
From: "Kiselev, Oleg" <okiselev@amazon.com>
To: Kent Overstreet <kent.overstreet@linux.dev>, Theodore Ts'o <tytso@mit.edu>
CC: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Thread-Index: AQHadoyDsV0USCkQJEC028Q3z6qlgrE5A18AgAABWYCABJWUgA==
Date: Mon, 18 Mar 2024 21:51:04 +0000
Message-ID: <A0A342BA-631D-4D6E-B6D2-692A45509F63@amazon.com>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
 <20240315035308.3563511-4-kent.overstreet@linux.dev>
 <20240315164550.GD324770@mit.edu>
 <l3dzlrzaekbxjryazwiqtdtckvl4aundfmwff2w4exuweg4hbc@2zsrlptoeufv>
In-Reply-To: <l3dzlrzaekbxjryazwiqtdtckvl4aundfmwff2w4exuweg4hbc@2zsrlptoeufv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <26EE5E8E86AD7645A307DC5C99A094F6@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMy8xNS8yNCwgMDk6NTEsICJLZW50IE92ZXJzdHJlZXQiIDxrZW50Lm92ZXJzdHJlZXRAbGlu
dXguZGV2IDxtYWlsdG86a2VudC5vdmVyc3RyZWV0QGxpbnV4LmRldj4+IHdyb3RlOg0KPiBPbiBG
cmksIE1hciAxNSwgMjAyNCBhdCAxMjo0NTo1MFBNIC0wNDAwLCBUaGVvZG9yZSBUcydvIHdyb3Rl
Og0KPiA+IE9uIFRodSwgTWFyIDE0LCAyMDI0IGF0IDExOjUzOjAyUE0gLTA0MDAsIEtlbnQgT3Zl
cnN0cmVldCB3cm90ZToNCj4gPiA+IHRoZSBuZXcgc3lzZnMgcGF0aCBpb2N0bCBsZXRzIHVzIGdl
dCB0aGUgL3N5cy9mcy8gcGF0aCBmb3IgYSBnaXZlbg0KPiA+ID4gZmlsZXN5c3RlbSBpbiBhIGZz
IGFnbm9zdGljIHdheSwgcG90ZW50aWFsbHkgbnVkZ2luZyB1cyB0b3dhcmRzDQo+ID4gPiBzdGFu
ZGFyaXppbmcgc29tZSBvZiBvdXIgcmVwb3J0aW5nLg0KPiA+ID4NCj4gPiA+IC0tLSBhL2ZzL2V4
dDQvc3VwZXIuYw0KPiA+ID4gKysrIGIvZnMvZXh0NC9zdXBlci5jDQo+ID4gPiBAQCAtNTM0Niw2
ICs1MzQ2LDcgQEAgc3RhdGljIGludCBfX2V4dDRfZmlsbF9zdXBlcihzdHJ1Y3QgZnNfY29udGV4
dCAqZmMsIHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpDQo+ID4gPiBzYi0+c19xdW90YV90eXBlcyA9
IFFUWVBFX01BU0tfVVNSIHwgUVRZUEVfTUFTS19HUlAgfCBRVFlQRV9NQVNLX1BSSjsNCj4gPiA+
ICNlbmRpZg0KPiA+ID4gc3VwZXJfc2V0X3V1aWQoc2IsIGVzLT5zX3V1aWQsIHNpemVvZihlcy0+
c191dWlkKSk7DQo+ID4gPiArIHN1cGVyX3NldF9zeXNmc19uYW1lX2JkZXYoc2IpOw0KPiA+DQo+
ID4gU2hvdWxkIHdlIHBlcmhhcHMgYmUgaG9pc3RpbmcgdGhpcyBjYWxsIHVwIHRvIHRoZSBWRlMg
bGF5ZXIsIHNvIHRoYXQNCj4gPiBhbGwgZmlsZSBzeXN0ZW1zIHdvdWxkIGJlbmVmaXQ/DQo+DQo+
DQo+IEkgZGlkIGFzIG11Y2ggaG9pc3RpbmcgYXMgSSBjb3VsZC4gRm9yIHNvbWUgZmlsZXN5c3Rl
bXMgKHNpbmdsZSBkZXZpY2UNCj4gZmlsZXN5c3RlbXMpIHRoZSBzeXNmcyBuYW1lIGlzIHRoZSBi
bG9jayBkZXZpY2UsIGZvciB0aGUgbXVsdGkgZGV2aWNlDQo+IGZpbGVzeXN0ZW1zIEkndmUgbG9v
a2VkIGF0IGl0J3MgdGhlIFVVSUQuDQoNCldoeSBub3QgdXNlIHRoZSBmcyBVVUlEIGZvciBhbGwg
Y2FzZXMsIHNpbmdsZSBkZXZpY2UgYW5kIG11bHRpIGRldmljZT8NCi0tIA0KT2xlZyBLaXNlbGV2
IA0KDQoNCg0KDQo=

