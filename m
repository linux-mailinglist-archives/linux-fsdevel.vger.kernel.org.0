Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9266730FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 06:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjASFJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 00:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjASFIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:08:50 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E4C38E87;
        Wed, 18 Jan 2023 21:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NAMvashxzYH+spBRFwlJgqXsMFHLHxqFKBzzhdwgkjk=; b=rYU+ISrMtx552gxyvUYbfwOBGl
        w0lWoJMHEipIW61re+ulGiG9id0ySKJZB53iPHOOu92CR1fi95zZ9A6Hvz9aORCxevWXuGg0R+EV2
        Ivq3j7DMDuiAHbbhr0XP4gPKp6rbsGJ7zX0jGGMBiGh5OZFqdGcD0Lm9+0v4mgN4/6JJ63pC7/kuT
        20ZWQr1p7rWIDnKqsoOD2XaUw7yKtUip6tSgPG58lGD/ZjPaEayFNcVX4qHvITvqDd9Zd6GB3dTRO
        niI0iBk2H6b3mJzNJ1K/Ir0iVhQL5gIkXfWs7q9os+BfY9p+arQ7gZu2lCYGxqBR3dNOQqz0NbTEs
        E5gMTcbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIN64-002g9x-2g;
        Thu, 19 Jan 2023 05:04:21 +0000
Date:   Thu, 19 Jan 2023 05:04:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/34] dio: Pin pages rather than ref'ing if
 appropriate
Message-ID: <Y8jPVLewUaaiuplq@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391061117.2311931.16807283804788007499.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391061117.2311931.16807283804788007499.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:10:11PM +0000, David Howells wrote:
> Convert the generic direct-I/O code to use iov_iter_extract_pages() instead
> of iov_iter_get_pages().  This will pin pages or leave them unaltered
> rather than getting a ref on them as appropriate to the iterator.
> 
> The pages need to be pinned for DIO-read rather than having refs taken on
> them to prevent VM copy-on-write from malfunctioning during a concurrent
> fork() (the result of the I/O would otherwise end up only visible to the
> child process and not the parent).

Several observations:

1) fs/direct-io.c is ancient, grotty and has few remaining users.
The case of block devices got split off first; these days it's in
block/fops.c.  Then iomap-using filesystems went to fs/iomap/direct-io.c,
leaving this sucker used only by affs, ext2, fat, exfat, hfs, hfsplus, jfs,
nilfs2, ntfs3, reiserfs, udf and ocfs2.  And frankly, the sooner it dies
the better off we are.  IOW, you've picked an uninteresting part and left
the important ones untouched.

2) if you look at the "should_dirty" logics in either of those (including
fs/direct-io.c itself) you'll see a funny thing.  First of all,
dio->should_dirty (or its counterparts) gets set iff we have a user-backed
iter and operation is a read.  I.e. precisely the case when you get bio
marked with BIO_PAGE_PINNED.  And that's not an accident - look at the
places where we check that predicate: dio_bio_submit() calls
bio_set_pages_dirty() if that predicate is true before submitting the
sucker and dio_bio_complete() uses it to choose between bio_check_pages_dirty()
and bio_release_pages() + bio_put().

Look at bio_check_pages_dirty() - it checks if any of the pages we were
reading into had managed to lose the dirty bit; if none had it does
bio_release_pages(bio, false) + bio_put(bio) and returns.  If some had,
it shoves bio into bio_dirty_list and arranges for bio_release_pages(bio, true)
+ bio_put(bio) called from upper half (via schedule_work()).  The effect
of the second argument of bio_release_pages() is to (re)dirty the pages;
it can't be done from interrupt, so we have to defer it to process context.

Now, do we need to redirty anything there?  Recall that page pinning had
been introduced precisely to prevent writeback while the page is getting
DMA into it.  Who is going to mark it clean before we unpin it?

Unless I misunderstand something fundamental about the whole thing,
this crap should become useless with that conversion.  And it's not just
the ->should_dirty and its equivalents - bio_check_pages_dirty() and
the stuff around it should also be gone once block/fops.c and
fs/iomap/direct-io.c are switched to your iov_iter_extract_pages.
Moreover, that way the only places legitimately passing true to
bio_release_pages() are blk_rq_unmap_user() (on completion of
bypass read request mapping a user page) and __blkdev_direct_IO_simple()
(on completion of short sync O_DIRECT read from block device).
Both could just as well call bio_set_pages_dirty(bio) +
bio_release_pages(bio, false), killing the "dirty on release" logics
and losing the 'mark_dirty' argument.

BTW, where do we dirty the pages on IO_URING_OP_READ_FIXED with
O_DIRECT file?  AFAICS, bio_set_pages_dirty() won't be called
(ITER_BVEC iter) and neither will bio_release_pages() do anything
(BIO_NO_PAGE_REF set on the bio by bio_iov_bvec_set() called
due to the same ITER_BVEC iter).  Am I missing something trivial
here?  Jens?
