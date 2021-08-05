Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CAB3E1E7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 00:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhHEWMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 18:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhHEWMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:12:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D02C0613D5;
        Thu,  5 Aug 2021 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RvO+6JeVpLxlPcNmPsjLLYdjB15f9d7yagNnMlUscyM=; b=JmZQe8YwHGdxpbt0TwH//rA7bp
        HfAA5mzWQ300vIpQYo2arTXyklr5l76dKVELRLgAZnUKxXoRc+QEJSbaJuD0GoNpSfCd/Tm0UBMuE
        8SlOk735EbFz/87qkcy75AdIYWBzf/6Pu9MY7CX3ueVVY4JMora1+0oRcuu8osroUGfT0mXjfvMK6
        YRKger+O0AuVg9xmmLmzYUXKEtKW1DDQMgyAYZHjWr1kcBaMhMeG32BSAx4/3o6o/iRQtgZutc3wC
        Ppbf+HBE58BXsebQaFSh/F53V7A49MoL26n7Xo3oyaKsNZoU5Zwaw2sdDXexB/tn2REY4APSX99IZ
        UDs7r7iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBla0-007ZDJ-Ph; Thu, 05 Aug 2021 22:11:12 +0000
Date:   Thu, 5 Aug 2021 23:11:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
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
Message-ID: <YQxh/G0xGl3GtC8y@casper.infradead.org>
References: <YQv+iwmhhZJ+/ndc@casper.infradead.org>
 <YQvpDP/tdkG4MMGs@casper.infradead.org>
 <YQvbiCubotHz6cN7@casper.infradead.org>
 <1017390.1628158757@warthog.procyon.org.uk>
 <1170464.1628168823@warthog.procyon.org.uk>
 <1186271.1628174281@warthog.procyon.org.uk>
 <1219713.1628181333@warthog.procyon.org.uk>
 <CAHk-=wjyEk9EuYgE3nBnRCRd_AmRYVOGACEjt0X33QnORd5-ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyEk9EuYgE3nBnRCRd_AmRYVOGACEjt0X33QnORd5-ig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:27:05AM -0700, Linus Torvalds wrote:
> On Thu, Aug 5, 2021 at 9:36 AM David Howells <dhowells@redhat.com> wrote:
> > Some network filesystems, however, currently keep track of which byte ranges
> > are modified within a dirty page (AFS does; NFS seems to also) and only write
> > out the modified data.
> 
> NFS definitely does. I haven't used NFS in two decades, but I worked
> on some of the code (read: I made nfs use the page cache both for
> reading and writing) back in my Transmeta days, because NFSv2 was the
> default filesystem setup back then.
> 
> See fs/nfs/write.c, although I have to admit that I don't recognize
> that code any more.
> 
> It's fairly important to be able to do streaming writes without having
> to read the old contents for some loads. And read-modify-write cycles
> are death for performance, so you really want to coalesce writes until
> you have the whole page.

I completely agree with you.  The context you're missing is that Dave
wants to do RMW twice.  He doesn't do the delaying SetPageUptodate dance.
If the write is less than the whole page, AFS, Ceph and anybody else
using netfs_write_begin() will first read the entire page in and mark
it Uptodate.

Then he wants to track which parts of the page are dirty (at byte
granularity) and send only those bytes to the server in a write request.
So it's worst of both worlds; first the client does an RMW, then the
server does an RMW (assuming the client's data is no longer in the
server's cache.

The NFS code moves the RMW from the client to the server, and that makes
a load of sense.

> That said, I suspect it's also *very* filesystem-specific, to the
> point where it might not be worth trying to do in some generic manner.

It certainly doesn't make sense for block filesystems.  Since they
can only do I/O on block boundaries, a sub-block write has to read in
the surrounding block, and once you're doing that, you might as well
read in the whole page.

Tracking sub-page dirty bits still makes sense.  It's on my to-do
list for iomap.

> [ goes off and looks. See "nfs_write_begin()" and friends in
> fs/nfs/file.c for some of the examples of these things, althjough it
> looks like the code is less aggressive about avoding the
> read-modify-write case than I thought I remembered, and only does it
> for write-only opens ]

NFS is missing one trick; it could implement aops->is_partially_uptodate
and then it would be able to read back bytes that have already been
written by this client without writing back the dirty ranges and fetching
the page from the server.

Maybe this isn't an important optimisation.
