Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBA3B0B64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhFVR2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhFVR2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:28:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E98C061574;
        Tue, 22 Jun 2021 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mOJMY6UOYq7EaC2SDC9v+zeUo0FEEd2ZM34anZJPrG8=; b=RDSUY3nJuJPGNXnzMGU4Nm5OFG
        knOmUgsCxWwKh/8EEHQUy9vtATVzVa8ve5UAvHrphjagiV5sMXQBT4oiOpM56T/AXJAqcpSJwD5A/
        TaSvPzxDSTgo2NBa69kr1+HwavpGgZan5lVpRGf2qGKgLXfHgKq1d7I2IF1Na7rdx8tmP+lloSlRw
        ZumFsdUMykOmBOGfn0HqHv968m2YdfHs11FnwSsPriLaEBFmXg4B6I6KDyaYxrfl7V5IY3outGNQx
        WvWuOuZermop/gA5DF6UoLvqJXJ+efg0szmPWASoPPyX3nHPhyYdKQLnV+DvqhGYli8bhEQQGWXTq
        S6KI9I5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvk9t-00EY8S-Ia; Tue, 22 Jun 2021 17:26:00 +0000
Date:   Tue, 22 Jun 2021 18:25:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Message-ID: <YNIdJaKrNj5GoT7w@casper.infradead.org>
References: <3221175.1624375240@warthog.procyon.org.uk>
 <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 03:36:22PM +0000, Al Viro wrote:
> On Tue, Jun 22, 2021 at 03:27:43PM +0000, Al Viro wrote:
> > On Tue, Jun 22, 2021 at 04:20:40PM +0100, David Howells wrote:
> > 
> > > and wondering if the iov_iter_fault_in_readable() is actually effective.  Yes,
> > > it can make sure that the page we're intending to modify is dragged into the
> > > pagecache and marked uptodate so that it can be read from, but is it possible
> > > for the page to then get reclaimed before we get to
> > > iov_iter_copy_from_user_atomic()?  a_ops->write_begin() could potentially take
> > > a long time, say if it has to go and get a lock/lease from a server.
> > 
> > Yes, it is.  So what?  We'll just retry.  You *can't* take faults while holding
> > some pages locked; not without shitloads of deadlocks.
> 
> Note that the revert you propose is going to do fault-in anyway; we really can't
> avoid it.  The only thing it does is optimistically trying without that the
> first time around, which is going to be an overall loss exactly in "slow
> write_begin" case.  If source pages are absent, you'll get copyin fail;
> iov_iter_copy_from_user_atomic() (or its replacement) is disabling pagefaults
> itself.

Let's not overstate the case.  I think for the vast majority of write()
calls, the data being written has recently been accessed.  So this
userspace access is unnecessary.  From the commentary around commits
00a3d660cbac and 998ef75ddb57, it seems that Dave had a CPU which was
particularly inefficient at accessing userspace.  I assume Intel have
fixed that by now and the extra load is in the noise.  But maybe enough
CPU errata have accumulated that it's slow again?
