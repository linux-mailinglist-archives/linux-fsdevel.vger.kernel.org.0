Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C14977DE5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbjHPKRc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 06:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbjHPKRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:17:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D380E3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 03:17:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-263-B9QQiW5KPp2z-0gqw5gR7Q-1; Wed, 16 Aug 2023 11:17:27 +0100
X-MC-Unique: B9QQiW5KPp2z-0gqw5gR7Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 16 Aug
 2023 11:17:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 16 Aug 2023 11:17:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2] iov_iter: Convert iterate*() to inline funcs
Thread-Topic: [RFC PATCH v2] iov_iter: Convert iterate*() to inline funcs
Thread-Index: AQHZzvgmq2lQZxPz+UuF+eoksadYZ6/rhpfwgAEYzACAABNV8A==
Date:   Wed, 16 Aug 2023 10:17:23 +0000
Message-ID: <a72036d57d50464ea4fe7fa556ee1a72@AcuMS.aculab.com>
References: <8722207799c342e780e1162a983dc48b@AcuMS.aculab.com>
 <855.1692047347@warthog.procyon.org.uk>
 <5247.1692049208@warthog.procyon.org.uk>
 <440141.1692179410@warthog.procyon.org.uk>
In-Reply-To: <440141.1692179410@warthog.procyon.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells
> Sent: Wednesday, August 16, 2023 10:50 AM
> 
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > It is harder to compare because of some of the random name changes.
> 
> I wouldn't say 'random' exactly, but if you prefer, some of the name changing
> can be split out into a separate patch.  The macros are kind of the worst
> since they picked up variable names from the callers.
> 
> > The version of the source I found seems to pass priv2 to functions
> > that don't use it?
> 
> That can't be avoided if I convert everything to inline functions and function
> pointers - but the optimiser can get rid of it where it can inline the step
> function.

AFAICT the IOVEC one was only called directly.

> I tried passing the iterator to the step functions instead, but that just made
> things bigger.  memcpy_from_iter_mc() is interesting to deal with.  I would
> prefer to deal with it in the caller so we only do the check once, but that
> might mean duplicating the caller.

You could try something slightly horrid that the compiler
might optimise for you.
Instead of passing in a function pointer pass a number.
Then do something like:
#define call_iter(id, ...) \
	(id == x ? fn_x(__VA_ARGS__) : id == y ? fn_y(__VA_ARGS) ...)
constant folding on the inline should kill the function pointer.
You might get away with putting the args on the end.

...
> > I rather hope the should_fail_usercopy() and instrument_copy_xxx()
> > calls are usually either absent or, at most, nops.
> 
> Okay - it's probably worth marking those too, then.

Thinking I'm sure they are KASAN annotations.
The are few enough calls that I suspect that replicating them
won't affect KASAN (etc) builds.

> > This all seems to have a lot fewer options than last time I looked.
> 
> I'm not sure what you mean by 'a lot fewer options'?

It might just be ITER_PIPE that has gone.

> > Is it worth optimising the KVEC case with a single buffer?
> 
> You mean an equivalent of UBUF?  Maybe.  There are probably a whole bunch of
> netfs places that do single-kvec writes, though I'm trying to convert these
> over to bvec arrays, combining them with their data, and MSG_SPLICE_PAGES.

I'm thinking of what happens with kernel callers of things
like the socket code - especially for address/option buffers.
Probably io_uring and bpf (and my out of tree drivers!).

Could be the equivalent of UBUF, but checking for KVEC with
a count of 1 wouldn't really add any more cmp/jmp pairs.

I've also noticed in the past that some of this code seems
to be optimised for zero length buffers/fragments.
Surely they just need to work?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

