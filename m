Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921123E2D2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbhHFPFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 11:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243564AbhHFPF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628262311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5B073nk1DS+XhzOJ9EAEUKaNTVzIvIbT8CxRSjSpPZU=;
        b=WbQk/Y3XZCoG2+qhBe/tlrupojF1gle5w0fu2xR0a+jCRlu+8gUV3HEm5wBe486Q3RgmJn
        843j0TdzoGNcmNF/kqDI8IxPjwvueBTDuKDOGs5OjGLsKcZ5qNHAzZL9f5oa2oMgBhwupX
        f855jDAyRkJv6WBOWrofQDprgT2KWCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-ky3v8YG6NV-FlJD_H1kZwQ-1; Fri, 06 Aug 2021 11:05:08 -0400
X-MC-Unique: ky3v8YG6NV-FlJD_H1kZwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72BB9107ACF5;
        Fri,  6 Aug 2021 15:05:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBEEA10640E8;
        Fri,  6 Aug 2021 15:04:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YQ1Ei9lv9ov2AheS@casper.infradead.org>
References: <YQ1Ei9lv9ov2AheS@casper.infradead.org> <YQxh/G0xGl3GtC8y@casper.infradead.org> <YQv+iwmhhZJ+/ndc@casper.infradead.org> <YQvpDP/tdkG4MMGs@casper.infradead.org> <YQvbiCubotHz6cN7@casper.infradead.org> <1017390.1628158757@warthog.procyon.org.uk> <1170464.1628168823@warthog.procyon.org.uk> <1186271.1628174281@warthog.procyon.org.uk> <1219713.1628181333@warthog.procyon.org.uk> <CAHk-=wjyEk9EuYgE3nBnRCRd_AmRYVOGACEjt0X33QnORd5-ig@mail.gmail.com> <1302671.1628257357@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1306893.1628262293.1@warthog.procyon.org.uk>
Date:   Fri, 06 Aug 2021 16:04:53 +0100
Message-ID: <1306894.1628262293@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> No, that is very much not the same thing.  Look at what NFS does, like
> Linus said.  Consider this test program:
> 
> 	fd = open();
> 	lseek(fd, 5, SEEK_SET);
> 	write(fd, buf, 3);
> 	write(fd, buf2, 10);
> 	write(fd, buf3, 2);
> 	close(fd);

Yes, I get that.  I can do that when there isn't a local cache or content
encryption.

Note that, currently, if the pages (or cache blocks) being read/modified are
beyond the EOF at the point when the file is opened, truncated down or last
subject to 3rd-party invalidation, I don't go to the server at all.

> > But that kind of screws with local caching.  The local cache might need to
> > track the missing bits, and we are likely to be using blocks larger than a
> > page.
> 
> There's nothing to cache.  Pages which are !Uptodate aren't going to get
> locally cached.

Eh?  Of course there is.  You've just written some data.  That need to get
copied to the cache as well as the server if that file is supposed to be being
cached (for filesystems that support local caching of files open for writing,
which AFS does).

> > Basically, there are a lot of scenarios where not having fully populated
> > pages sucks.  And for streaming writes, wouldn't it be better if you used
> > DIO writes?
> 
> DIO can't do sub-512-byte writes.

Yes it can - and it works for my AFS client at least with the patches in my
fscache-iter-2 branch.  This is mainly a restriction for block storage devices
we're doing DMA to - but we're not doing direct DMA to block storage devices
typically when talking to a network filesystem.

For AFS, at least, I can just make one big FetchData/StoreData RPC that
reads/writes the entire DIO request in a single op; for other filesystems
(NFS, ceph for example), it needs breaking up into a sequence of RPCs, but
there's no particular reason that I know of that requires it to be 512-byte
aligned on any of these.

Things get more interesting if you're doing DIO to a content-encrypted file
because the block size may be 4096 or even a lot larger - in which case we
would have to do local RMW to handle misaligned writes, but it presents no
particular difficulty.

> You might not be trying to do anything for block filesystems, but we
> should think about what makes sense for block filesystems as well as
> network filesystems.

Whilst that's a good principle, they have very different characteristics that
might make that difficult.

David

