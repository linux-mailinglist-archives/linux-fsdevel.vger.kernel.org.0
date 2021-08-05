Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089BF3E1552
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 15:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbhHENHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 09:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240029AbhHENHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628168828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w3Cmdk9W0BCPcGY/VxLt8tV+dlv64Ayfb+LViyE6SGc=;
        b=JKhW2Y4zRohZlKh8FNEi6QWoclphQFDwcokKewWrpriCCV0wg8sJVKkgOYHavtwrVSpB7r
        c2BK9YO3EPz+1J438oxx+GPKqSS+v4TUncrbkiwOG/7TJ0aPKsUi1yc5PvifE4hRgCopwm
        laScIW2MX4mhptd6CsG1Ye00wnjlyFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-8QolsM8eOiiWG1zxW8RIZw-1; Thu, 05 Aug 2021 09:07:07 -0400
X-MC-Unique: 8QolsM8eOiiWG1zxW8RIZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAC82801A92;
        Thu,  5 Aug 2021 13:07:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 538AA5C1B4;
        Thu,  5 Aug 2021 13:07:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YQvbiCubotHz6cN7@casper.infradead.org>
References: <YQvbiCubotHz6cN7@casper.infradead.org> <1017390.1628158757@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Could it be made possible to offer "supplementary" data to a DIO write ?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1170463.1628168823.1@warthog.procyon.org.uk>
Date:   Thu, 05 Aug 2021 14:07:03 +0100
Message-ID: <1170464.1628168823@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Say, for example, I need to write a 3-byte change from a page, where that
> > page is part of a 256K sequence in the pagecache.  Currently, I have to
> > round the 3-bytes out to DIO size/alignment, but I could say to the API,
> > for example, "here's a 256K iterator - I need bytes 225-227 written, but
> > you can write more if you want to"?
> 
> I think you're optimising the wrong thing.  No actual storage lets you
> write three bytes.  You're just pushing the read/modify/write cycle to
> the remote end.  So you shouldn't even be tracking that three bytes have
> been dirtied; you should be working in multiples of i_blocksize().

I'm dealing with network filesystems that don't necessarily let you know what
i_blocksize is.  Assume it to be 1.

Further, only sending, say, 3 bytes and pushing RMW to the remote end is not
necessarily wrong for a network filesystem for at least two reasons: it
reduces the network loading and it reduces the effects of third-party write
collisions.

> I don't know of any storage which lets you ask "can I optimise this
> further for you by using a larger size".  Maybe we have some (software)
> compressed storage which could do a better job if given a whole 256kB
> block to recompress.

It would offer an extent-based filesystem the possibility of adjusting its
extent list.  And if you were mad enough to put your cache on a shingled
drive...  (though you'd probably need a much bigger block than 256K to make
that useful).  Also, jffs2 (if someone used that as a cache) can compress its
blocks.

> So it feels like you're both tracking dirty data at too fine a granularity,
> and getting ahead of actual hardware capabilities by trying to introduce a
> too-flexible API.

We might not know what the h/w caps are and there may be multiple destination
servers with different h/w caps involved.  Note that NFS and AFS in the kernel
both currently track at byte granularity and only send the bytes that changed.
The expense of setting up the write op on the server might actually outweigh
the RMW cycle.  With something like ceph, the server might actually have a
whole-object RMW/COW, say 4M.

Yet further, if your network fs has byte-range locks/leases and you have a
write lock/lease that ends part way into a page, when you drop that lock/lease
you shouldn't flush any data outside of that range lest you overwrite a range
that someone else has a lock/lease on.

David

