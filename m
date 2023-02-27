Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DDE6A4BD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 20:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjB0T7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 14:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB0T7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:59:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E2D16313
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tHE3W2hDSjG4vPzPWLyKAiq/lpxIyult3kS14bkpF+s=; b=YmXVW3po14eT3bn0sG9QS/azYz
        F9ekRhFTS5gF+MQsEaiJnHkNU7Lzi4q3tr7cbkL5l3OFMFbOmIBCGQOcyqSrzxDaWD6Wz0cxP0EH6
        ykmFh1XKspyZjWUesD5cNJsVV5aewEr4Nd566u9iO0UZ4/+KWGaKWN8QsdakpCfevsKqkMat12lKM
        hmc2guBrKrC+zJcqigcU/wA7XlMezg/wt8ZVApLGelNPZlbedzIBIahZYqxeKU20ZKzyPQXKj05IU
        +1Ukr+VC5pLJuNUxGq93vBOsEYwdu+o6YnMaUrvYdL4NltaqgJdfKLwSBFLLMNldDqZ44fSGwu1qg
        5QzFpIcw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWjeC-00B4xY-EV; Mon, 27 Feb 2023 19:58:56 +0000
Date:   Mon, 27 Feb 2023 11:58:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <Y/0LgMey64fv+n2v@bombadil.infradead.org>
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
 <Y/z/JrV8qRhUcqE7@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/z/JrV8qRhUcqE7@magnolia>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:06:14AM -0800, Darrick J. Wong wrote:
> On Sat, Jan 28, 2023 at 08:46:45PM -0800, Luis Chamberlain wrote:
> > One of the recurring themes that comes up at LSF is "iomap has little
> > to no documentation, it is hard to use". I've only recently taken a
> > little nose dive into it, and so I also can frankly admit to say I don't
> > grok it well either yet. However, the *general* motivation and value is clear:
> > avoiding the old ugly monster of struct buffer_head, and abstracting
> > the page cache for non network filesystems, and that is because for
> > network filesystems my understanding is that we have another side effort
> > for that. We could go a bit down memory lane on prior attempts to kill
> > the struct buffer_head evil demon from Linux, or why its evil, but I'm not
> > sure if recapping that is useful at this point in time, let me know, I could
> > do that if it helps if folks want to talk about this at LSF.
> 
> I think there's so much to talk about WRT iomap that I also think we're
> not going to have time for recapping why buffer heads are awful.

Does this mean you'll finally be attending a conference (if invited)?!

I have some private write ups on this as I reviewed *dozens* or threads
on prior efforts to address this issue before, so I could try to
condense some of this as a preamble write up before this session,
should this session be a candidate discussion.

> > For now I rather
> > instead focus on sharing efforts to review where we are today on the effort
> > towards conversion towards IOMAP for some of the major filesystems:
> > 
> > https://docs.google.com/presentation/d/e/2PACX-1vSN4TmhiTu1c6HNv6_gJZFqbFZpbF7GkABllSwJw5iLnSYKkkO-etQJ3AySYEbgJA/pub?start=true&loop=false&delayms=3000&slide=id.g189cfd05063_0_225
> 
> Ooh, slides, excellent!
> 
> Slide 3 -- there are a lot of separate struct iomap_ops in XFS because
> we learned (somewhat late) that creating a separate ops structure (and
> functions) for each IO path / use case is much more sanity-preserving
> than multiplexing everything into one gigantic function.

This is of huge value. Is is interesting that this was found through
experience, ie empircally, rather than early on, and it made me wonder
if things could be re-done -- what would we do?

If that was useful for XFS -- could this also be usefulf for other
filesytems? Could implying this somehow on the IOMAP API be useful?

Based on your experience *should* filesystem authors *strive* towards
splitting up the paths as well for IOMAP use?

> Now we have four different write codepaths in the kernel:
> 
> extern const struct iomap_ops xfs_buffered_write_iomap_ops;
> extern const struct iomap_ops xfs_page_mkwrite_iomap_ops;
> 
> These two use delayed allocation and use the pagecache for COW.
> 
> extern const struct iomap_ops xfs_direct_write_iomap_ops;
> extern const struct iomap_ops xfs_dax_write_iomap_ops;
> 
> These two don't use delayed allocation.  IIRC the DAX ops also take care
> of pre-zeroing allocations since we assume that memcpy to pmem is
> relatively "cheap".
> 
> Only one is needed to cover the read cases and FIEMAP:
> 
> extern const struct iomap_ops xfs_read_iomap_ops;
> 
> And then there's the weird ones for SEEK_{DATA,HOLE}:
> 
> extern const struct iomap_ops xfs_seek_iomap_ops;
> 
> And FIEMAP for xattrs:
> 
> extern const struct iomap_ops xfs_xattr_iomap_ops;
> 
> (I'll get to xfs_writeback_ops downthread.)
> 
> > I'm hoping this *might* be useful to some, but I fear it may leave quite
> > a bit of folks with more questions than answers as it did for me. And
> > hence I figured that *this aspect of this topic* perhaps might be a good
> > topic for LSF.  The end goal would hopefully then be finally enabling us
> > to document IOMAP API properly and helping with the whole conversion
> > effort.
> 
> Heh.  Yes.  Absolutely yes.
> 
> struct iomap_ops is a giant ball of frustration:
> 
> 	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
> 			unsigned flags, struct iomap *iomap,
> 			struct iomap *srcmap);
> 
> If you're a filesystem trying to use iomap, it's not at all clear when
> you're supposed to fill out @iomap and when you need to fill out
> @srcmap.  Right now, the rule is that an ->iomap_begin implementation
> should always fill out @iomap.  If the operation is a copy-on-write,
> only then does the ->iomap_begin function need to fill out @srcmap.
> 
> I've been mulling over redesigning this so that the two parameters are
> @read_iomap and @write_iomap.  Any time there's a place from which to
> read data, the ->iomap_begin function would fill out @read_iomap.  This
> would also be the vessel for SEEK_*, FIEMAP, and swapfile activation.
> 
> Any time there's a place in which to write data, the ->iomap_begin
> function would fill out @write_iomap.  For a COW, the read and write
> mappings would be different.  For a pure overwrite, they'd be the same.
> 
> This is going to take a bit of thought to get right.  It'll be easier
> for XFS because we split the iomap_ops to handle different
> responsibilities, but I haven't looked all that far into ext4 and btrfs
> to see what they do.

IMHO so long as those use-cases don't break we should be fine in
re-thinking IOMAP now. Otherwise a change later would incur much
more care and could regress. A few of us are the brink of helping
with the conversion effort, but these questions seems a bit more
important to address than just trying to reduce the struct buffer_head
count on each filesystem.

> I also want to convert the inode/pos/length/flags arguments to a const
> pointer to struct iomap_iter to reduce the register count.

Neat.

> > My gatherings from this quick review of API evolution and use is that,
> > XFS is *certainly* a first class citizen user. No surprise there if a
> > lot of the effort came out from XFS. And even though btrfs now avoids
> > the evil struct buffer_head monster, its use of the IOMAP API seems
> > *dramatically* different than XFS, and it probably puzzles many. Is it
> > that btrfs managed to just get rid of struct buffer_head use but missed
> > fully abstracting working with the page cache? How does one check? What
> > semantics do we look for?
> 
> I'm under the impression that for buffered io, btrfs manages pagecache
> folios directly, without the use of iomap at all.  Hence no mention of
> buffer heads in the codebase.
> 
> A big problem I see in porting btrfs/ext*/f2fs/etc to use the iomap
> pagecache code is that iomap doesn't support io permutations at all.
> It assumes that it can assemble struct bio with pagecache pages and
> issue that bio directly to the device.
> 
> IOWs, someone will need to port fscrypt, fsverity, compression, etc. to
> iomap before those filesystems can jump off bufferheads.

Is it a worthy endeavor to have filesystems use IOMAP to manage working
with the pagecache for you? Even if hard, is that a worthy lofty goal
to aim for? Do we have general consensus on this?

> > When looking to see if one can help on the conversion front with other
> > filesystems it begs the question what is the correct real end goal. What
> > should one strive for? And it also gets me wondering, if we wanted to abstract
> > the page cache from scratch again, would we have done this a bit differently
> > now? Are there lessons from the network filesystem side of things which
> > can be shared? If so it gets me wondering if this instead should be
> > about why that's a good idea and what should that look like.
> 
> All good questions to ask.
> 
> > Perhaps fs/buffers.c could be converted to folios only, and be done
> > with it. But would we be loosing out on something? What would that be?
> 
> Dirty secret here: I still don't understand what buffers.c does. ;)

I'm on the same boat :D

  Luis
