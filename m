Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A292BC5ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 14:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgKVN6Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 08:58:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:52821 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbgKVN6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 08:58:15 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-83-68wCZSYwMYuMi8rKowULxQ-1; Sun, 22 Nov 2020 13:58:11 +0000
X-MC-Unique: 68wCZSYwMYuMi8rKowULxQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 22 Nov 2020 13:58:10 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 22 Nov 2020 13:58:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/29] iov_iter: Switch to using a table of operations
Thread-Topic: [PATCH 01/29] iov_iter: Switch to using a table of operations
Thread-Index: AQHWwNQxMI88twW4zUSLxoYAnZFgBanUKLlw
Date:   Sun, 22 Nov 2020 13:58:10 +0000
Message-ID: <4890290b302e480fb0d1cc66bd0d6ce9@AcuMS.aculab.com>
References: <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com>
 <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <254318.1606051984@warthog.procyon.org.uk>
In-Reply-To: <254318.1606051984@warthog.procyon.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells
> Sent: 22 November 2020 13:33
> 
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> >  - I worry a bit about the indirect call overhead and spectre v2.
> 
> I don't know enough about how spectre v2 works to say if this would be a
> problem for the ops-table approach, but wouldn't it also affect the chain of
> conditional branches that we currently use, since it's branch-prediction
> based?

The advantage of the 'chain of branches' is that it can be converted
into a 'tree of branches' because the values are all separate bits.

So as well as putting the (expected) common one first; you can do:
	if (likely((a & (A | B))) {
		if (a & A) {
			code for A;
		} else {
			code for B;
	} else ...
So get better control over the branch sequence.
(Hopefully the compiler doesn't change the logic.
I want a dumb compiler that (mostly) compiles what I write!)

Part of the difficulty is deciding the common case.
There'll always be a benchmark that exercises an uncommon case.

Adding an indirect call does let you do things like adding
ITER_IOVER_SINGLE and ITER_KVEC_SINGLE that are used in the
common case of a single buffer fragment.
That might be a measurable gain.

It is also possible to optimise the common case to a direct
call (or even inline code) and use an indirect call for
everything else.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

