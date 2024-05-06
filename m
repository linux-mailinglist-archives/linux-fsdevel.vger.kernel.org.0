Return-Path: <linux-fsdevel+bounces-18862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E9F8BD57B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 21:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D6282466
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 19:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C9D15AD80;
	Mon,  6 May 2024 19:35:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502415AABF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024108; cv=none; b=I/bPQECp+i6rl6FwlGd19i792VGLdoeGlZbtsFcWnDZngyboMlZmDoYzjEoEDxXxLESmRy/F+Gq3lrrO89u1A+6/2eFURKSlsQZio0p34KP9hqie/ZqlwcZWdma8IgChthjLw4dPF53fka5jWBqLbgWoq+9EwxGQ0VGuhyH/Jho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024108; c=relaxed/simple;
	bh=r0WUpWmKbYhSZY5mZSEV3lVk9p3x2tNUijIrZnlk1oY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=iLC+haPNThgWJ4K4DL/KlitRWutCxPih52FW6lYM+C0buA5ZQ3xXDsD23PSPH7/dLjBthVrtW+k/1pOaNgXnzvpQKdbdqu3pajACNWWXsM5tp6ZqBxt+qhKmZotY1nPlSQymSNjWmxYLvADsLCAXyrKWzdyByFCVzMGlGQDUvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-83-XDilHoh7OGOqbgSr_C4z7g-1; Mon, 06 May 2024 20:35:04 +0100
X-MC-Unique: XDilHoh7OGOqbgSr_C4z7g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 6 May
 2024 20:34:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 6 May 2024 20:34:24 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andy Lutomirski' <luto@amacapital.net>, Aleksa Sarai <cyphar@cyphar.com>
CC: Stas Sergeev <stsp2@yandex.ru>, "Serge E. Hallyn" <serge@hallyn.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Stefan
 Metzmacher" <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton
	<jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Alexander Aring
	<alex.aring@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	=?utf-8?B?Q2hyaXN0aWFuIEfDtnR0c2NoZQ==?= <cgzones@googlemail.com>
Subject: RE: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Thread-Topic: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Thread-Index: AQHan9rzUUvHBi3CRk+0pc3o5ZO9aLGKmP4A
Date: Mon, 6 May 2024 19:34:24 +0000
Message-ID: <f8fafe1953ed41828a4c98187964477b@AcuMS.aculab.com>
References: <20240426133310.1159976-1-stsp2@yandex.ru>
 <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
 <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>
In-Reply-To: <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4uDQo+IFNvIEkgd2FudCBhIHdheSB0byBnaXZlICphbiBlbnRpcmUgY29udGFpbmVyKiBhY2Nl
c3MgdG8gYSBkaXJlY3RvcnkuDQo+IENsYXNzaWMgVU5JWCBEQUMgaXMganVzdCAqd3JvbmcqIGZv
ciB0aGlzIHVzZSBjYXNlLiAgTWF5YmUgaWRtYXBzDQo+IGNvdWxkIGxlYXJuIGEgd2F5IHRvIHNx
dWFzaCBtdWx0aXBsZSBpZHMgZG93biB0byBvbmUuICBPciBtYXliZQ0KPiBzb21ldGhpbmcgbGlr
ZSBteSBzaWxseSBjcmVkZW50aWFsLWNhcHR1cmluZyBtb3VudCBwcm9wb3NhbCBjb3VsZA0KPiB3
b3JrLiAgQnV0IHRoZSBzdGF0dXMgcXVvIGlzIG5vdCBhY3R1YWxseSBhbWF6aW5nIElNTy4NCg0K
SXNuJ3QgdGhhdCB3aGF0IGdpZHMgYXJlIGZvciA6LSkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


