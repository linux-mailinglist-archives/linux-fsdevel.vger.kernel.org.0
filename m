Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B661B3B0FA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFVV5b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 17:57:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:21262 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229501AbhFVV5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:57:30 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-86-sl1tZ6CBMP-L3jncOw6psA-1; Tue, 22 Jun 2021 22:55:10 +0100
X-MC-Unique: sl1tZ6CBMP-L3jncOw6psA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Jun
 2021 22:55:10 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 22 Jun 2021 22:55:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Thread-Topic: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Thread-Index: AQHXZ4N03eCp9KNCtEagRX54mD94w6sgkJXg
Date:   Tue, 22 Jun 2021 21:55:09 +0000
Message-ID: <7a6d8c55749d46d09f6f6e27a99fde36@AcuMS.aculab.com>
References: <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <3221175.1624375240@warthog.procyon.org.uk>
 <3225322.1624379221@warthog.procyon.org.uk>
In-Reply-To: <3225322.1624379221@warthog.procyon.org.uk>
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
> Sent: 22 June 2021 17:27
> 
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > On Tue, Jun 22, 2021 at 04:20:40PM +0100, David Howells wrote:
> >
> > > and wondering if the iov_iter_fault_in_readable() is actually effective.
> > > Yes, it can make sure that the page we're intending to modify is dragged
> > > into the pagecache and marked uptodate so that it can be read from, but is
> > > it possible for the page to then get reclaimed before we get to
> > > iov_iter_copy_from_user_atomic()?  a_ops->write_begin() could potentially
> > > take a long time, say if it has to go and get a lock/lease from a server.
> >
> > Yes, it is.  So what?  We'll just retry.  You *can't* take faults while
> > holding some pages locked; not without shitloads of deadlocks.
> 
> In that case, can we amend the comment immediately above
> iov_iter_fault_in_readable()?
> 
> 	/*
> 	 * Bring in the user page that we will copy from _first_.
> 	 * Otherwise there's a nasty deadlock on copying from the
> 	 * same page as we're writing to, without it being marked
> 	 * up-to-date.
> 	 *
> 	 * Not only is this an optimisation, but it is also required
> 	 * to check that the address is actually valid, when atomic
> 	 * usercopies are used, below.
> 	 */
> 	if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
> 
> The first part suggests this is for deadlock avoidance.  If that's not true,
> then this should perhaps be changed.

I'd say something like:
	/*
	 * The actual copy_from_user() is done with a lock held
	 * so cannot fault in missing pages.
	 * So fault in the pages first.
	 * If they get paged out the inatomic usercopy will fail
	 * and the whole operation is retried.
	 *
	 * Hopefully there are enough memory pages available to
	 * stop this looping forever.
	 */

It is perfectly possible for another application thread to
invalidate one of the buffer fragments after iov_iter_fault_in_readable()
return success - so it will then fail on the second pass.

The maximum number of pages required is twice the maximum number
of iov fragments.
If the system is crawling along with no available memory pages
the same physical page could get used for two user pages.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

