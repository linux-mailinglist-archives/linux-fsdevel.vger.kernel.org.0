Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DFA780B9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 14:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376819AbjHRMQu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376862AbjHRMQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:16:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC414214
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 05:16:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-98C0T_vJOJK6bOwFbwR9Yw-1; Fri, 18 Aug 2023 13:16:27 +0100
X-MC-Unique: 98C0T_vJOJK6bOwFbwR9Yw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 18 Aug
 2023 13:16:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 18 Aug 2023 13:16:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        "Matthew Wilcox" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Topic: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Index: AQHZ0DpP/l59sWTPXU+UuQ9VGbJikq/s16Kg///6foCAACRpIIAC+zJggAAE0WA=
Date:   Fri, 18 Aug 2023 12:16:23 +0000
Message-ID: <b9c32d9669174dbbbb8e944146814a98@AcuMS.aculab.com>
References: <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com>
 <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk>
 <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk>
 <1748360.1692358952@warthog.procyon.org.uk>
In-Reply-To: <1748360.1692358952@warthog.procyon.org.uk>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells
> Sent: Friday, August 18, 2023 12:43 PM
> 
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > Well, that part is trivially fixable, and we should do that anyway for
> > other reasons.
> > ..
> >  enum iter_type {
> >  	/* iter types */
> > -	ITER_IOVEC,
> > -	ITER_KVEC,
> > -	ITER_BVEC,
> > -	ITER_XARRAY,
> > -	ITER_DISCARD,
> > -	ITER_UBUF,
> > +	ITER_IOVEC = 1,
> > +	ITER_UBUF = 2,
> > +	ITER_KVEC = 4,
> > +	ITER_BVEC = 8,
> > +	ITER_XARRAY = 16,
> > +	ITER_DISCARD = 32,

That could be zero - no bits and default.

> >  };
> 
> It used to be this way, but Al switched it:
> 
> 	8cd54c1c848031a87820e58d772166ffdf8c08c0
> 	iov_iter: separate direction from flavour

Except it also had the direction flag inside the enum.
That caused its own piles of grief.

IIRC Linus had type:6 - that doesn't leave any headroom
for additional types (even though they shouldn't proliferate).
It may be best to avoid bits 15+ (in a bitfield) due to
issues with large constants and sign extension.
On x86 (I think) 'and immediate' and 'bit test' are the same
size for bit 0 to 7, BIT wins for higher bits.

gcc generates strange code for some initialisers (see yesterday's
thread) and you definitely mustn't leave unused bits in a bitfield.
Might be better is the fields are assigned later!

(I also saw clang carefully preserving %eax on stabck!)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

