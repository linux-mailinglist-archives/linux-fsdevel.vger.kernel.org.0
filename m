Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A103E15C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbhHENfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 09:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhHENfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:35:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98CC061765;
        Thu,  5 Aug 2021 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eNQq9YXEqPok0QuE+YM5YdpE7wuAuM2V7XctMV2GEeo=; b=Meg3JevYHlugdIuS0HDzSl2F/k
        V21HulFkfrbuUPqcfkvpz2aib4d8PFQYvISWdYWboMa1EVGi8BngAbAK++GhiQKHhMdwx3YVQLuy2
        Bbgcvcnv/uNLLjZJJRCbK8nA5GdVZOEDUt1032Gg3Y66JoGjuSzptugMezHfvYd/J+Xpb+U/gNYxe
        R+nQ70i+129coULhp/bCXHJSzX9ToW5raVQpLWklBq+B56cb2ZdBL3sU5eCkGZYi6Rdgl9ORyVi2A
        u6IIGp7fodY2dAhxlTjzQkuB4McPRh9vI7rACGZzN9rFy0HwJWYhZyJDfI8w+WuklL9GwMyYUPCs/
        vE11/a6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBdWe-00779b-Vp; Thu, 05 Aug 2021 13:35:11 +0000
Date:   Thu, 5 Aug 2021 14:35:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Could it be made possible to offer "supplementary" data to a DIO
 write ?
Message-ID: <YQvpDP/tdkG4MMGs@casper.infradead.org>
References: <YQvbiCubotHz6cN7@casper.infradead.org>
 <1017390.1628158757@warthog.procyon.org.uk>
 <1170464.1628168823@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1170464.1628168823@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 02:07:03PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> > > Say, for example, I need to write a 3-byte change from a page, where that
> > > page is part of a 256K sequence in the pagecache.  Currently, I have to
> > > round the 3-bytes out to DIO size/alignment, but I could say to the API,
> > > for example, "here's a 256K iterator - I need bytes 225-227 written, but
> > > you can write more if you want to"?
> > 
> > I think you're optimising the wrong thing.  No actual storage lets you
> > write three bytes.  You're just pushing the read/modify/write cycle to
> > the remote end.  So you shouldn't even be tracking that three bytes have
> > been dirtied; you should be working in multiples of i_blocksize().
> 
> I'm dealing with network filesystems that don't necessarily let you know what
> i_blocksize is.  Assume it to be 1.

That's a really bad idea.  The overhead of tracking at byte level
granularity is just not worth it.

> Further, only sending, say, 3 bytes and pushing RMW to the remote end is not
> necessarily wrong for a network filesystem for at least two reasons: it
> reduces the network loading and it reduces the effects of third-party write
> collisions.

You can already get 400Gbit ethernet.  Saving 500 bytes by sending
just the 12 bytes that changed is optimising the wrong thing.  If you
have two clients accessing the same file at byte granularity, you've
already lost.

> > I don't know of any storage which lets you ask "can I optimise this
> > further for you by using a larger size".  Maybe we have some (software)
> > compressed storage which could do a better job if given a whole 256kB
> > block to recompress.
> 
> It would offer an extent-based filesystem the possibility of adjusting its
> extent list.  And if you were mad enough to put your cache on a shingled
> drive...  (though you'd probably need a much bigger block than 256K to make
> that useful).  Also, jffs2 (if someone used that as a cache) can compress its
> blocks.

Extent based filesystems create huge extents anyway:

$ /usr/sbin/xfs_bmap *.deb
linux-headers-5.14.0-rc1+_5.14.0-rc1+-1_amd64.deb:
	0: [0..16095]: 150008440..150024535
linux-image-5.14.0-rc1+_5.14.0-rc1+-1_amd64.deb:
	0: [0..383]: 149991824..149992207
	1: [384..103495]: 166567016..166670127
linux-image-5.14.0-rc1+-dbg_5.14.0-rc1+-1_amd64.deb:
	0: [0..183]: 149993016..149993199
	1: [184..1503623]: 763050936..764554375
linux-libc-dev_5.14.0-rc1+-1_amd64.deb:
	0: [0..2311]: 149979624..149981935

This has already happened when you initially wrote to the file backing
the cache.  Updates are just going to write to the already-allocated
blocks, unless you've done something utterly inappropriate to the
situation like reflinked the files.

> > So it feels like you're both tracking dirty data at too fine a granularity,
> > and getting ahead of actual hardware capabilities by trying to introduce a
> > too-flexible API.
> 
> We might not know what the h/w caps are and there may be multiple destination
> servers with different h/w caps involved.  Note that NFS and AFS in the kernel
> both currently track at byte granularity and only send the bytes that changed.
> The expense of setting up the write op on the server might actually outweigh
> the RMW cycle.  With something like ceph, the server might actually have a
> whole-object RMW/COW, say 4M.
> 
> Yet further, if your network fs has byte-range locks/leases and you have a
> write lock/lease that ends part way into a page, when you drop that lock/lease
> you shouldn't flush any data outside of that range lest you overwrite a range
> that someone else has a lock/lease on.

If you want to take leases at byte granularity, and then not writeback
parts of a page that are outside that lease, feel free.  It shouldn't
affect how you track dirtiness or how you writethrough the page cache
to the disk cache.
