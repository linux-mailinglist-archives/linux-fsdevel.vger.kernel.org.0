Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E23E2C63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbhHFOT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 10:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbhHFOTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:19:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89613C0613CF;
        Fri,  6 Aug 2021 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AIojU9OyEcFpwE1NJjuvzE4uBfRHyEf2CFdTUs7T8kY=; b=aQCFuYjMfZmvdIItkIfG7EIyUL
        xuIJ9C4tiobJN1yMNBEBjYsSC8QXO0hYNGPowU15nqhg7a/kJH57+PqWeTMX4HufuAxQTsAggaWS5
        ME1HlzklZZhEV/AnOyoy74T8AjkOjYcYF/uaP4V+Xpez9HjQB54burcKwvyZITCfZYC10Wos2QC5w
        wVdt7p2nnNP9Puj38Fs+ho752eI4vIKNfSJNnve0Yz26UbAq//TDiQ5Z3KzTI37DU+2S7Q6HpK4E8
        UAAYFjQc2iw7eS23GDd8Y5JeUjywfgyXF1zu+PS9gZ1VjjcqAthhBS5MighJ9XGjHqi4n+J+WcodS
        OfOax+ig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mC0fT-008GBJ-Rm; Fri, 06 Aug 2021 14:17:55 +0000
Date:   Fri, 6 Aug 2021 15:17:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Canvassing for network filesystem write size vs page size
Message-ID: <YQ1Ei9lv9ov2AheS@casper.infradead.org>
References: <YQxh/G0xGl3GtC8y@casper.infradead.org>
 <YQv+iwmhhZJ+/ndc@casper.infradead.org>
 <YQvpDP/tdkG4MMGs@casper.infradead.org>
 <YQvbiCubotHz6cN7@casper.infradead.org>
 <1017390.1628158757@warthog.procyon.org.uk>
 <1170464.1628168823@warthog.procyon.org.uk>
 <1186271.1628174281@warthog.procyon.org.uk>
 <1219713.1628181333@warthog.procyon.org.uk>
 <CAHk-=wjyEk9EuYgE3nBnRCRd_AmRYVOGACEjt0X33QnORd5-ig@mail.gmail.com>
 <1302671.1628257357@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1302671.1628257357@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 06, 2021 at 02:42:37PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > It's fairly important to be able to do streaming writes without having
> > > to read the old contents for some loads. And read-modify-write cycles
> > > are death for performance, so you really want to coalesce writes until
> > > you have the whole page.
> > 
> > I completely agree with you.  The context you're missing is that Dave
> > wants to do RMW twice.  He doesn't do the delaying SetPageUptodate dance.
> 
> Actually, I do the delaying of SetPageUptodate in the new write helpers that
> I'm working on - at least to some extent.  For a write of any particular size
> (which may be more than a page), I only read the first and last pages affected
> if they're not completely changed by the write.  Note that I have my own
> version of generic_perform_write() that allows me to eliminate write_begin and
> write_end for any filesystem using it.

No, that is very much not the same thing.  Look at what NFS does, like
Linus said.  Consider this test program:

	fd = open();
	lseek(fd, 5, SEEK_SET);
	write(fd, buf, 3);
	write(fd, buf2, 10);
	write(fd, buf3, 2);
	close(fd);

You're going to do an RMW.  NFS keeps track of which bytes are dirty,
and writes only those bytes to the server (when that page is eventually
written-back).  So yes, it's using the page cache, but it's not doing
an unnecessary read from the server.

> It has occurred to me that I don't actually need the pages to be uptodate and
> completely filled out.  I'm tracking which bits are dirty - I could defer
> reading the missing bits till someone wants to read or mmap.
> 
> But that kind of screws with local caching.  The local cache might need to
> track the missing bits, and we are likely to be using blocks larger than a
> page.

There's nothing to cache.  Pages which are !Uptodate aren't going to get
locally cached.

> Basically, there are a lot of scenarios where not having fully populated pages
> sucks.  And for streaming writes, wouldn't it be better if you used DIO
> writes?

DIO can't do sub-512-byte writes.

> > If the write is less than the whole page, AFS, Ceph and anybody else
> > using netfs_write_begin() will first read the entire page in and mark
> > it Uptodate.
> 
> Indeed - but that function is set to be replaced.  What you're missing is that
> if someone then tries to read the partially modified page, you may have to do
> two reads from the server.

NFS doesn't.  It writes back the dirty data from the page and then
does a single read of the entire page.  And as I said later on, using
->is_partially_uptodate can avoid that for some cases.

> > Then he wants to track which parts of the page are dirty (at byte
> > granularity) and send only those bytes to the server in a write request.
> 
> Yes.  Because other constraints may apply, for example the handling of
> conflicting third-party writes.  The question here is how much we care about
> that - and that's why I'm trying to write back only what's changed where
> possible.

If you care about conflicting writes from different clients, you really
need to establish a cache ownership model.  Or treat the page-cache as
write-through.

> > > That said, I suspect it's also *very* filesystem-specific, to the
> > > point where it might not be worth trying to do in some generic manner.
> > 
> > It certainly doesn't make sense for block filesystems.  Since they
> > can only do I/O on block boundaries, a sub-block write has to read in
> > the surrounding block, and once you're doing that, you might as well
> > read in the whole page.
> 
> I'm not trying to do this for block filesystems!  However, a block filesystem
> - or even a blockdev - might be involved in terms of the local cache.

You might not be trying to do anything for block filesystems, but we
should think about what makes sense for block filesystems as well as
network filesystems.

> > Tracking sub-page dirty bits still makes sense.  It's on my to-do
> > list for iomap.
> 
> /me blinks
> 
> "bits" as in parts of a page or "bits" as in the PG_dirty bits on the pages
> contributing to a folio?

Perhaps I should have said "Tracking dirtiness on a sub-page basis".
Right now, that looks like a block bitmap, but maybe it should be a
range-based data structure.
