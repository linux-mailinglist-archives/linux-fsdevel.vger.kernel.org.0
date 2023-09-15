Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE57A1E29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjIOMLa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjIOMLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:11:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECDD3271C
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 05:10:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-284-UcFWVE2yOQ6WrAoloj9v_Q-1; Fri, 15 Sep 2023 13:10:12 +0100
X-MC-Unique: UcFWVE2yOQ6WrAoloj9v_Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Sep
 2023 13:10:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 15 Sep 2023 13:10:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        "Matthew Wilcox" <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "David Hildenbrand" <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: RE: [RFC PATCH 9/9] iov_iter: Add benchmarking kunit tests for
 UBUF/IOVEC
Thread-Topic: [RFC PATCH 9/9] iov_iter: Add benchmarking kunit tests for
 UBUF/IOVEC
Thread-Index: AQHZ51kQ26Nrcgq1TkqWWiI5nPv6dLAbdkPggAAj+YCAABqPYP//+bcAgAAdLuA=
Date:   Fri, 15 Sep 2023 12:10:07 +0000
Message-ID: <72e93605b28742c2a496ce4890ecaa80@AcuMS.aculab.com>
References: <5017b9fa177f4deaa5d481a5d8914ab4@AcuMS.aculab.com>
 <dcc6543d71524ac488ca2a56dd430118@AcuMS.aculab.com>
 <20230914221526.3153402-1-dhowells@redhat.com>
 <20230914221526.3153402-10-dhowells@redhat.com>
 <3370515.1694772627@warthog.procyon.org.uk>
 <3449352.1694776980@warthog.procyon.org.uk>
In-Reply-To: <3449352.1694776980@warthog.procyon.org.uk>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells
> Sent: 15 September 2023 12:23
> 
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > > > Some measurements can be made using readv() and writev()
> > > > on /dev/zero and /dev/null.
> > >
> > > Forget /dev/null; that doesn't actually engage any iteration code.  The same
> > > for writing to /dev/zero.  Reading from /dev/zero does its own iteration thing
> > > rather than using iterate_and_advance(), presumably because it checks for
> > > signals and resched.
> >
> > Using /dev/null does exercise the 'copy iov from user' code.
> 
> Ummm....  Not really:

I was thinking of import_iovec() - or whatever its current
name is.

That really needs a single structure that contains the iov_iter
and the cache[] (which the caller pretty much always allocates
in the same place).
Fiddling with that is ok until you find what io_uring does.
Then it all gets entirely horrid.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

