Return-Path: <linux-fsdevel+bounces-14166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13367878A2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 22:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2235D1C20D65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 21:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A2656B99;
	Mon, 11 Mar 2024 21:42:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463043AAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193366; cv=none; b=R2rvPrih7wuW0YMAJJDU1mWWdRJKKemRyMvzx5QfLFlAbsUcmgi05QNQir4agGo18GXR3ftSMxUn54K/saMrrVp63psIoLNVVNM/uGzJxz9cve4LRTFgQ6a4F4wfloqaoVdvw8+mLMp1f2Szb3IxNd7WyJxMI4PV0Pcwzj7vBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193366; c=relaxed/simple;
	bh=GQXaXyc1zQJyIJwVtjwpKqnlF5O4YH+/iBVavsbfGpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=h+nCBNWtAPykV0KUYFW0hsjuOYRTXIdYNW4gONcWJILSe4MAlt4P7SUTkcrc4OZ/bgi+tSpYDQl8DO8Gbcv5WQraKBed64FAFX0RZPDjNSDmipKBFrRRJgmE18nUqGnN0INfJ1icLEPXyPaQyAVSDv6fLftz7MJwzoUqL83PCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-182-1CQnVePBPnqOGYOB4eHJow-1; Mon, 11 Mar 2024 21:42:41 +0000
X-MC-Unique: 1CQnVePBPnqOGYOB4eHJow-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Mar
 2024 21:42:46 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 11 Mar 2024 21:42:46 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Matthew Wilcox' <willy@infradead.org>, Dave Chinner <david@fromorbit.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: On the optimum size of a batch
Thread-Topic: On the optimum size of a batch
Thread-Index: AQHac2YDWJ9ZLWk00E2JGYCnzpWSgrEzDvkw
Date: Mon, 11 Mar 2024 21:42:46 +0000
Message-ID: <5c54bfe5123f4e6390400599427c23b7@AcuMS.aculab.com>
References: <Zeoble0xJQYEAriE@casper.infradead.org>
 <Ze5onaXsI+LT1+Be@dread.disaster.area>
 <Ze59byUR80z42m8R@casper.infradead.org>
In-Reply-To: <Ze59byUR80z42m8R@casper.infradead.org>
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

From: Matthew Wilcox
> Sent: 11 March 2024 03:42
...
> But that doesn't necessarily mean that you want a larger batch size.
> Because you're not just allocating, you're also freeing and over a
> large enough timescale the number of objects allocated and freed is
> approximately equal.  In the SLUB case, your batch size needs to be
> large enough to absorb most of the allcation-vs-free bias jitter; that
> is if you know they always alternate AFAFAFAFAF a batch size of 2 would
> be fine.  If you know you get four allocations followed by four frees,
> having a batch size of 5 woud be fine.  We'd never go to the parent
> allocator if we got a AFAAFFAAAFFFAAAAFFFFAAFFAFAAFAAFFF pattern.

That isn't really the allocation pattern you need to worry about.
Per cpu free list should be large enough to handle it.
The problem (as the first people doing a sparc SMP port found) is
that you'll get one bit of code that 'pumps' items from one
free list to another.
So you have to decide that you have too many local free objects
and then give some back to the global free list.
Keeping them on the global list as a block of 'n' items can
make things far better.
Indeed 'arrays of pointers' are likely to be better than a
linked list.

Caches in front of SLUB (or similar) really shouldn't be needed.
Except, perhaps, to indicate which list the items come from
and, maybe for some extra allocation stats.
There might be rcu oddities - where the memory can't be used
for a different structure. But there are probably alternative
solutions to that one.

The page free code is a different problem.
I suspect that needs to process batches of items to avoid
repeated (expensive) atomic accesses.
But it definitely needs to avoid thrashing the L1 cache.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


