Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98235740D76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjF1JsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233791AbjF1JeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687944811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QMzisq1grZMezPf2xhSzRVCRVpvAbjFhFL5SGPZabPI=;
        b=AXoEFKMxhFKkD1dv2s19a3frUKi6tEtr5rO7xd1h8nMz48slSKz0QC2qQsB5p7BuQGJDiK
        bT3bdEwcCZXgivLAhZj4j+puvJYwc4tF/a7SwVfNQ2U6KJV5T/1MbQFfzv5LcEXHPA4R4N
        VP5viDJTPM60i+slMzWJDS8GLnkhkAg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-O3B7MN5bN5mYZqfaAwh67g-1; Wed, 28 Jun 2023 05:33:27 -0400
X-MC-Unique: O3B7MN5bN5mYZqfaAwh67g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C8C287323C;
        Wed, 28 Jun 2023 09:33:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE7340C2063;
        Wed, 28 Jun 2023 09:33:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZJvsJJKMPyM77vPv@dread.disaster.area>
References: <ZJvsJJKMPyM77vPv@dread.disaster.area> <ZJq6nJBoX1m6Po9+@casper.infradead.org> <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name> <ZJp4Df8MnU8F3XAt@dread.disaster.area> <3299543.1687933850@warthog.procyon.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and FALLOC_FL_PUNCH_HOLE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3388727.1687944804.1@warthog.procyon.org.uk>
Date:   Wed, 28 Jun 2023 10:33:24 +0100
Message-ID: <3388728.1687944804@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> wrote:

> On Wed, Jun 28, 2023 at 07:30:50AM +0100, David Howells wrote:
> > Matthew Wilcox <willy@infradead.org> wrote:
> > > > > Expected behavior:
> > > > > Punching holes in a file after splicing pages out of that file into
> > > > > a pipe should not corrupt the spliced-out pages in the pipe buffer.
> > 
> > I think this bit is the key.  Why would this be the expected behaviour?
> > As you say, splice is allowed to stuff parts of the pagecache into a pipe
> > and these may get transferred, say, to a network card at the end to
> > transmit directly from.  It's a form of direct I/O.

Actually, it's a form of zerocopy, not direct I/O.

> > If someone has the pages mmapped, they can change the data that will be
> > transmitted; if someone does a write(), they can change that data too.
> > The point of splice is to avoid the copy - but it comes with a tradeoff.
> 
> I wouldn't call "post-splice filesystem modifications randomly
> corrupts pipe data" a tradeoff. I call that a bug.

Would you consider it a kernel bug, then, if you use sendmsg(MSG_ZEROCOPY) to
send some data from a file mmapping that some other userspace then corrupts by
altering the file before the kernel has managed to send it?

Anyway, if you think the splice thing is a bug, we have to fix splice from a
buffered file that is shared-writably mmapped as well as fixing
fallocate()-driven mangling.  There are a number of options:

 (0) Document the bug as a feature: "If this is a problem, don't use splice".

 (1) Always copy the data into the pipe.

 (2) Always unmap and steal the pages from the pagecache, copying if we can't.

 (3) R/O-protect any PTEs mapping those pages and implement CoW.

 (4) Disallow splice() from any region that's mmapped, disallow mmap() on or
     make page_mkwrite wait for any region that's currently spliced.  Disallow
     fallocate() on or make fallocate() wait for any pages that are spliced.

With recent changes, I think there are only two places that need fixing:
filemap_splice_read() and shmem_splice_read().  However, I wonder what
performance effect of having to do a PTE hunt in splice() will be.

And then there's vmsplice()...

Also, I do wonder what happens if you do MSG_ZEROCOPY to a loopback network
address and then splice out of the other end.  I'm guessing you'll get the
zerocopied pages out into your pipe as I think it just moves the sent skbuffs
to the receive queue on the other end.

David

