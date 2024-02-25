Return-Path: <linux-fsdevel+bounces-12721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63086862AD2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 15:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4E01F213A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E2C14016;
	Sun, 25 Feb 2024 14:47:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C9125CD
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708872477; cv=none; b=p7BFd3AEbUhjwE2QvI8DKKfWymoWvkYMVs/kwJsHq0N7ZoCi5HL/CG2bYVWmmUmDTYOy8sFpiTKT0Jea6dYR7hypiPTEQwrYcMkP2qYT/rz94o7izv/2Mr02sM90mPasbn+AKeHjNN9lo3yjK9dMhTS3QMiWXshZk2Ec+RrM1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708872477; c=relaxed/simple;
	bh=34Eq+uHp5yJqj4VGBsCh+xInlxIzSmCOpKaV0p3dL+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NsadL2fVNrWzbKWI3xAoIecbTT1OtgwLDGMc5f+0Aj7JsaI0hIGI8HKlBIXGbuTYOlmGtPbAXzwlhjWk+GT4r0Vz+Wvpx/7WJENx0/YTmEGgupANtNaO0VnCNak7Icy2Sp9t2kJ9yp8EtB5VIIWd3nmQsEmNLq+/Lb6w4xeda2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304-9wbhQDAnMhGhNXbq82bMeg-1; Sun, 25 Feb 2024 14:47:46 +0000
X-MC-Unique: 9wbhQDAnMhGhNXbq82bMeg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 14:47:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 14:47:45 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kent Overstreet' <kent.overstreet@linux.dev>
CC: 'Herbert Xu' <herbert@gondor.apana.org.au>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH 0/1] Rosebush, a new hash table
Thread-Topic: [PATCH 0/1] Rosebush, a new hash table
Thread-Index: AQHaZrdg3OPv1gzlbEiBbQpUz0xlprEaCpvwgABak4CAAL43MA==
Date: Sun, 25 Feb 2024 14:47:45 +0000
Message-ID: <2a6001442b354c2fb5b881c2a9d75895@AcuMS.aculab.com>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
 <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
In-Reply-To: <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
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
Content-Transfer-Encoding: quoted-printable

From: Kent Overstreet
> Sent: 25 February 2024 03:19
..
> when I implemented cuckoo (which is more obviously sensitive to a weak
> hash function), I had to go with siphash, even jhash wasn't giving me
> great reslts. and looking at the code it's not hard to see why, it's all
> adds, and the rotates are byte aligned... you want mixed adds and xors
> and the rotates to be more prime-ish.
>=20
> right idea, just old...
>=20
> what would be ideal is something more like siphash, but with fewer
> rounds, so same number of instructions as jhash. xxhash might fit the
> bill, I haven't looked at the code yet...

There is likely to be a point where scanning a list of values
for the right hash value is faster than executing a hash function
that is good enough to separate them to separate buckets.

You don't want to scan a linked list because they have horrid
cache footprints.
The locking is equally horrid - especially for remove.
Arrays of pointers ar ethe way forward :-)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


