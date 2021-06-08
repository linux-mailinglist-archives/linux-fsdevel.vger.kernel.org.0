Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0139F96D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhFHOp0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 8 Jun 2021 10:45:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:55431 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233521AbhFHOpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:45:25 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-8-KfK2vafPOQykcDa_LFRCgg-1;
 Tue, 08 Jun 2021 15:43:29 +0100
X-MC-Unique: KfK2vafPOQykcDa_LFRCgg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Tue, 8 Jun 2021 15:43:28 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 8 Jun 2021 15:43:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: RE: [RFC][PATCHSET] iov_iter work
Thread-Topic: [RFC][PATCHSET] iov_iter work
Thread-Index: AQHXWwdMcZdaHAC1iEOMJ2ZGTqwEgasKLatg
Date:   Tue, 8 Jun 2021 14:43:28 +0000
Message-ID: <7591552a5ec5469d8a084c47f370ac03@AcuMS.aculab.com>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
In-Reply-To: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
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

My 'brain farts' :-)

I've looked as at iterate_all_kinds() and my brain melted.

Certainly optimising for 'copy all the data' seems right.
There are also hot code paths where a vector length of 1
is very common (eg sendmsg).

Do I remember the code incrementing iter->iov as it
progresses down the list of buffers?
That is probably rather more dangerous than keeping
the buffer index.
If the buffer index is kept then 'backing up' and
setting a fixed offset become much safer - if slower
in unusual cases.

The short iov_cache[] used for iovec could be put inside
the iov_iter structure (perhaps a special extended structure).
I think everything allocates both (typically on stack)
at exactly the same time.
This definitely neatens up all the callers.
(I've had a patch for it - except io-uring.)

I wonder if long iovec could read the ptr:length
from userspace as the copy progresses?
(To save the malloc/free.)
ISTR the total length is needed up front - so that
would need to be a separate loop.
This might be problematic for architectures that have
directional and ranged user access enables.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

