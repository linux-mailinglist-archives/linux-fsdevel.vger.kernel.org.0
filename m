Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D93B0FD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 00:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFVWH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVWHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:07:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AABC061574;
        Tue, 22 Jun 2021 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2m7GLG5w20KHHhlTaOprqLvS/Hx9yXDVOmadVvXFND8=; b=u3lQwtebrfuytes2L8nzZ8N6YB
        aJhsNvMMqMSpPGNJH8kmiR7ZH5GZ8SaF6yU7/DOCPamQgOmhypPXOtCUwm2z1Uuq6NQAJOrjXIRU9
        n/ezdix3gyl8PG/XzrrMkgvYY6M/RFMFSGzbaMi06n0HKx4MbgT6PLCgR0eTxZgD19e3PU7iZkul2
        y4z1w0+QVKMDlEUubiBrPxYl21fwfxo+q5NE67cHub2Jm1uTmGVXZfWHsHzz8kFgw6LdE3F6YDdAe
        mOmOdSvwj8/y4BLxz3wuRRtYpq7Pw3J2c2GCZZGWaWpZ0fTG17fhLLlpwU1wnkA84w5mZPT9JKDZf
        IAbFQkXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvoVD-00EnTi-HC; Tue, 22 Jun 2021 22:04:25 +0000
Date:   Tue, 22 Jun 2021 23:04:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'David Howells' <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Message-ID: <YNJeX3rWAIIh5H8H@casper.infradead.org>
References: <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <3221175.1624375240@warthog.procyon.org.uk>
 <3225322.1624379221@warthog.procyon.org.uk>
 <7a6d8c55749d46d09f6f6e27a99fde36@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6d8c55749d46d09f6f6e27a99fde36@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 09:55:09PM +0000, David Laight wrote:
> From: David Howells
> > Sent: 22 June 2021 17:27
> > 
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > > On Tue, Jun 22, 2021 at 04:20:40PM +0100, David Howells wrote:
> > >
> > > > and wondering if the iov_iter_fault_in_readable() is actually effective.
> > > > Yes, it can make sure that the page we're intending to modify is dragged
> > > > into the pagecache and marked uptodate so that it can be read from, but is
> > > > it possible for the page to then get reclaimed before we get to
> > > > iov_iter_copy_from_user_atomic()?  a_ops->write_begin() could potentially
> > > > take a long time, say if it has to go and get a lock/lease from a server.
> > >
> > > Yes, it is.  So what?  We'll just retry.  You *can't* take faults while
> > > holding some pages locked; not without shitloads of deadlocks.
> > 
> > In that case, can we amend the comment immediately above
> > iov_iter_fault_in_readable()?
> > 
> > 	/*
> > 	 * Bring in the user page that we will copy from _first_.
> > 	 * Otherwise there's a nasty deadlock on copying from the
> > 	 * same page as we're writing to, without it being marked
> > 	 * up-to-date.
> > 	 *
> > 	 * Not only is this an optimisation, but it is also required
> > 	 * to check that the address is actually valid, when atomic
> > 	 * usercopies are used, below.
> > 	 */
> > 	if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
> > 
> > The first part suggests this is for deadlock avoidance.  If that's not true,
> > then this should perhaps be changed.
> 
> I'd say something like:
> 	/*
> 	 * The actual copy_from_user() is done with a lock held
> 	 * so cannot fault in missing pages.
> 	 * So fault in the pages first.
> 	 * If they get paged out the inatomic usercopy will fail
> 	 * and the whole operation is retried.
> 	 *
> 	 * Hopefully there are enough memory pages available to
> 	 * stop this looping forever.
> 	 */
> 
> It is perfectly possible for another application thread to
> invalidate one of the buffer fragments after iov_iter_fault_in_readable()
> return success - so it will then fail on the second pass.
> 
> The maximum number of pages required is twice the maximum number
> of iov fragments.
> If the system is crawling along with no available memory pages
> the same physical page could get used for two user pages.

I would suggest reading the function before you suggest modifications
to it.

                offset = (pos & (PAGE_SIZE - 1));
                bytes = min_t(unsigned long, PAGE_SIZE - offset,
                                                iov_iter_count(i));

