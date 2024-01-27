Return-Path: <linux-fsdevel+bounces-9210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED483EDE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15ECB1C2141B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66B28E2E;
	Sat, 27 Jan 2024 15:27:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9228DCA
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706369235; cv=none; b=unA5XZvx5z6llpxEySzPEzA1XFsqsb+rrpS5Qz//fUZVf30kv4H7FU0abqLpai0CH7XltelJqI/bjzm+2aVElAx2WALj5fHxPUoINwGnQse0WwumpIYQ7sHmx0XIiAUk8YCrlxC0YQ0PfoOYxmhSgEFDz7DCFNtGHnq1IgXrBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706369235; c=relaxed/simple;
	bh=iFW2ERuTEIYk+fmvTQBQjnNRLBqVcxtT7bSBGDVOQEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=u/MnA8e52PrVjfnvK7cRNzGwPUtpoCa+XTO3jTeyWo1Rfz7HKXsVS4R87WX7Xx/vgfRVMzgAp6/pk5sGrtO7krNce2pyrJMsMBvmHqwed4NAHxxgWYpmCkeQS7V6r1TUP2PiFsxOtkJUCZJaCBzspOQbohEbdu9a3P+Q7v46tVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-87-hz-_3iJRN8aUc6HcCR5UTA-1; Sat, 27 Jan 2024 15:27:11 +0000
X-MC-Unique: hz-_3iJRN8aUc6HcCR5UTA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 27 Jan
 2024 15:26:51 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 27 Jan 2024 15:26:51 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Steven Rostedt
	<rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>, Linux Trace Devel
	<linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
	<brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, linux-fsdevel
	<linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] eventfs: Have inodes have unique inode numbers
Thread-Topic: [PATCH] eventfs: Have inodes have unique inode numbers
Thread-Index: AQHaUJ+9Uz3INJwNPU61vvwJRYci6bDtx3zg
Date: Sat, 27 Jan 2024 15:26:51 +0000
Message-ID: <9b34c04465ff46dba90c81b4240fbbd1@AcuMS.aculab.com>
References: <20240126150209.367ff402@gandalf.local.home>
 <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
 <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
In-Reply-To: <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjYgSmFudWFyeSAyMDI0IDIxOjM2DQo+IA0K
PiBPbiBGcmksIDI2IEphbiAyMDI0IGF0IDEzOjI2LCBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBn
b29kbWlzLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBJJ2QgYmUgaGFwcHkgdG8gY2hhbmdlIHRoYXQg
cGF0Y2ggdG8gd2hhdCBJIG9yaWdpbmFsbHkgZGlkIGJlZm9yZSBkZWNpZGluZw0KPiA+IHRvIGNv
cHkgZ2V0X25leHRfaW5vKCk6DQo+ID4NCj4gPiB1bnNpZ25lZCBpbnQgdHJhY2Vmc19nZXRfbmV4
dF9pbm8oaW50IGZpbGVzKQ0KPiA+IHsNCj4gPiAgICAgICAgIHN0YXRpYyBhdG9taWNfdCBuZXh0
X2lub2RlOw0KPiA+ICAgICAgICAgdW5zaWduZWQgaW50IHJlczsNCj4gPg0KPiA+ICAgICAgICAg
ZG8gew0KPiA+ICAgICAgICAgICAgICAgICByZXMgPSBhdG9taWNfYWRkX3JldHVybihmaWxlcyAr
IDEsICZuZXh0X2lub2RlKTsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAvKiBDaGVjayBmb3Ig
b3ZlcmZsb3cgKi8NCj4gPiAgICAgICAgIH0gd2hpbGUgKHVubGlrZWx5KHJlcyA8IGZpbGVzICsg
MSkpOw0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gcmVzIC0gZmlsZXM7DQo+IA0KPiBTdGlsbCBl
bnRpcmVseSBwb2ludGxlc3MuDQo+IA0KPiBJZiB5b3UgaGF2ZSBtb3JlIHRoYW4gNCBiaWxsaW9u
IGlub2Rlcywgc29tZXRoaW5nIGlzIHJlYWxseSByZWFsbHkgd3JvbmcuDQo+IA0KPiBTbyB3aHkg
aXMgaXQgdGVuIGxpbmVzIGluc3RlYWQgb2Ygb25lPw0KDQpEb2Vzbid0IExpbnV4IHN1cHBvcnQg
NjRiaXQgaW5vZGUgbnVtYmVycz8NClRoZXkgc29sdmUgdGhlIHdyYXAgcHJvYmxlbS4uLg0KDQpJ
IGFsc28gZG9uJ3Qga25vdyB3aGF0IGZpbGVzeXN0ZW1zIGxpa2UgTlRGUyB1c2UgLSB0aGV5IGRv
bid0IGhhdmUNCnRoZSBjb25jZXB0IG9mIGlub2RlLg0KDQpJSVJDIE5GUyB1c2VkIHRvIHVzZSB0
aGUgaW5vZGUgbnVtYmVyIGZvciBpdHMgJ2ZpbGUgaGFuZGxlJy4NClJhdGhlciBhIHBhaW4gd2hl
biB0cnlpbmcgdG8gd3JpdGUgY29kZSB0byBleHBvcnQgYSBsYXllcmVkIEZTDQooZXNwZWNpYWxs
eSBpZiBhIGxheWVyIG1pZ2h0IGJlIGFuIE5GUyBtb3VudCEpLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


