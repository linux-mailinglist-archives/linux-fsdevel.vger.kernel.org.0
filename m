Return-Path: <linux-fsdevel+bounces-14083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD087781D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 20:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF392817A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 19:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A2839FD1;
	Sun, 10 Mar 2024 19:07:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAE36AE1
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097658; cv=none; b=R8jwaXkDgIKv1AHVCRoM+6bXDvNDm1I6cNK1CJnNTGB7LlGH4ldNDCSJO7UUIH1gRgdrIHeCfNh8k/Gk94oJoXBoDTaUpsOUrQO+y/Io+B3TZ/ubC3NlguHMw+zqny+qljRlsFpfRngvXyInXZgpht4aL+prcyxSrOxMk0Rx2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097658; c=relaxed/simple;
	bh=kxWIp5Qt6rna3+DYNwudkMrznOHdEExHjOTg+CwdaOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=si24QVMLgBOGCIvOIOZSkU4O/y/EeWe4seHec/D242BKGahyw0vWPMkDxnMF2+2ZNKctDh7Y0I1EIEnrCUJ6di7yY1YM+E9MJjFF31RRL/4m9wgoYF7vbbdGmsiEog8tjS6MT5n6OwKJy0zu5/iI823f8XdQaPYRsIKUXzJrgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-40-SMhtXwpFNL6OmNRJqlhX_g-1; Sun, 10 Mar 2024 19:07:31 +0000
X-MC-Unique: SMhtXwpFNL6OmNRJqlhX_g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Mar
 2024 19:07:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 10 Mar 2024 19:07:41 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Matthew Wilcox' <willy@infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: On the optimum size of a batch
Thread-Topic: On the optimum size of a batch
Thread-Index: AQHacMlzWJ9ZLWk00E2JGYCnzpWSgrExV8hA
Date: Sun, 10 Mar 2024 19:07:41 +0000
Message-ID: <905fcd730d6e40b992c15ce0fe526941@AcuMS.aculab.com>
References: <Zeoble0xJQYEAriE@casper.infradead.org>
In-Reply-To: <Zeoble0xJQYEAriE@casper.infradead.org>
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
> Sent: 07 March 2024 19:55
>=20
> I've had a few conversations recently about how many objects should be
> in a batch in some disparate contextx, so I thought I'd write down my
> opinion so I can refer to it in future.  TLDR: Start your batch size
> around 10, adjust the batch size when measurements tell you to change it.
>=20
> In this model, let's look at the cost of allocating N objects from an
> allocator.  Assume there's a fixed cost, say 4 (units are not relevant
> here) for going into the allocator and then there's a 1 unit cost per
> object (eg we're taking a spinlock, pulling N objects out of the data
> structure and releasing the spinlock again).

I think you are trying to measure the length of a piece of string.
(and not the ones in the box labelled 'pieces of string too small to keep')

What I did recently for a global+local buffer allocator was to make
each entry on the global list itself be a list of objects.
So if the local list was empty it was a single cmpxchg to grab
(about 100) items.
Similarly if the local free list got too big a single locked
operation would free a block of items.
That significantly reduced lock contention.

If was necessary to split the free of very long lists - otherwise
a single item on the global list could contain silly numbers of items.

This was userspace, and we don't talk about the test that ended up
with ALL system memory on one linked list.
I managed to kill enough (remote) things to get a working shell.
It took the system about 20 minutes just to count the linked list!

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


