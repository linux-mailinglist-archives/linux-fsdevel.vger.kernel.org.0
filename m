Return-Path: <linux-fsdevel+bounces-17363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1BA8AC03F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Apr 2024 19:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA75B20A98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Apr 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3A3717B;
	Sun, 21 Apr 2024 17:22:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079D2942F
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Apr 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713720140; cv=none; b=RQGKEOy4zdyXFlMOzKFhhSkDGdDZ24c4fpnTGNXepe2zyvpisw5rX1XnbbkEkTZvLpXYsiGv81pBhb5vL3iD11HgmqhK90wTOC1qGrKrqi7mIgfUFKf6QTBFhPsjYxUO0M/ATWRokNPrG7QgOzsR+bWQk2QrKoY9nxqRwJEwEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713720140; c=relaxed/simple;
	bh=E1Nho4TNCkRiQ+1z/eEfslZqH0CAmLGWXWNzWODCxYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ej/xfVqYdOA7r5I1EhJZkZdxGYIrS5ZHKaPpFwsXxcADmOTKAe99u2dW8t0GUuBNgzzAxu0dtKfwiA0xvFNotsXoqJEBAAq38+jK3VhK1M0IRkxvxqigDlkAjy28zprOxzjLL96YNZ9d6HJOvoHFf+JPpldnHt7ZJhFS0Q6nkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-130-wqOpvSleMPWkRxXpPk1rMw-1; Sun, 21 Apr 2024 18:22:05 +0100
X-MC-Unique: wqOpvSleMPWkRxXpPk1rMw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 21 Apr
 2024 18:21:32 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 21 Apr 2024 18:21:32 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe JAILLET' <christophe.jaillet@wanadoo.fr>, 'Al Viro'
	<viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] seq_file: Optimize seq_puts()
Thread-Topic: [PATCH] seq_file: Optimize seq_puts()
Thread-Index: AQHaj3fscOebCwNNKkWKivYclXgg7bFrX8CggASjjoCAAvw6MA==
Date: Sun, 21 Apr 2024 17:21:32 +0000
Message-ID: <e3b8b5d4c43d4d6d88bc8e6d516c1d41@AcuMS.aculab.com>
References: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
 <4b1a4cc5-e057-4944-be69-d25f28645256@wanadoo.fr>
 <20240415210035.GW2118490@ZenIV>
 <ba306b2a1b5743bab79b3ebb04ece4df@AcuMS.aculab.com>
 <5e5cde3e-f3ad-4a9b-bc02-1c473affdcb1@wanadoo.fr>
In-Reply-To: <5e5cde3e-f3ad-4a9b-bc02-1c473affdcb1@wanadoo.fr>
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

RnJvbTogQ2hyaXN0b3BoZSBKQUlMTEVUDQo+IFNlbnQ6IDE5IEFwcmlsIDIwMjQgMjE6MzgNCi4u
Lg0KPiA+IEkgZGlkIHdvbmRlciBhYm91dCBjaGVja2luZyBzaXplb2YocykgPD0gMiBpbiB0aGUg
I2RlZmluZSB2ZXJzaW9uLg0KPiANCj4gZ2l0IGdyZXAgc2VxX3B1dHMuKlwiW15cXF0uXCIgfCB3
YyAtbA0KPiA3Nw0KPiANCj4gV2hhdCB3b3VsZCB5b3UgZG8gaW4gdGhpcyBjYXNlPw0KPiAyIHNl
cV9wdXRjKCkgaW4gb3JkZXIgdG8gc2F2ZSBhIG1lbWNweSguLi4sIDIpLCB0aGF0J3MgaXQ/DQo+
IA0KPiBJdCB3b3VsZCBhbHNvIHNsaWdodGx5IGNoYW5nZSB0aGUgYmVoYXZpb3VyLCBhcyBvbmx5
IHRoZSAxc3QgY2hhciBjb3VsZA0KPiBiZSBhZGRlZC4gQWN0dWFsbHksIGl0IGlzIGFsbCBvciBu
b3RoaW5nLg0KDQpEb2luZzoNCglpZiAoc2l6ZW9mKHN0cikgPT0gMiAmJiBzdHJbMF0pDQoJCXNl
cV9wdXRjKG0uIHN0clswXSk7DQoJZWxzZQ0KCQlfX3NlcV9wdXRzKG0sIHN0cik7DQpXb3VsZCBw
aWNrIHVwIGxvb3BzIHRoYXQgZG86DQoJY2hhciBzZXBbMl0gPSAiIjsNCg0KCWZvciAoOzsgc2Vw
WzBdID0gJywnKSB7DQoJCS4uLg0KCQlzZXFfcHV0cyhtLCBzZXApOw0KCQkuLi4NCgl9DQphcyB3
ZWxsIGFzIHNlcV9wdXRzKG0sICJ4Iik7DQoNCldoZXRoZXIgdGhhdCBpcyB3b3J0aHdoaWxlIGlz
IGFub3RoZXIgbWF0dGVyLg0KQnV0IGl0IG1pZ2h0IGJlIHVzZWQuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=


