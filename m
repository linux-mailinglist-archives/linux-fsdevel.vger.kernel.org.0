Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A85AD58A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 11:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389786AbfIIJTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 05:19:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:46472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728200AbfIIJTl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:19:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DEDCB04C;
        Mon,  9 Sep 2019 09:19:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 60EB11E43AC; Mon,  9 Sep 2019 11:19:39 +0200 (CEST)
Date:   Mon, 9 Sep 2019 11:19:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [Q] gfs2: mmap write vs. punch_hole consistency
Message-ID: <20190909091939.GA17151@quack2.suse.cz>
References: <20190906205241.2292-1-agruenba@redhat.com>
 <20190906212758.GO1119@dread.disaster.area>
 <CAHc6FU5BxOHkgHKKWTL7jFq0oL4TbAPpe49QDB6X35ndjYTWKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5BxOHkgHKKWTL7jFq0oL4TbAPpe49QDB6X35ndjYTWKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 06-09-19 23:48:31, Andreas Gruenbacher wrote:
> On Fri, Sep 6, 2019 at 11:28 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, Sep 06, 2019 at 10:52:41PM +0200, Andreas Gruenbacher wrote:
> > > Hi,
> > >
> > > I've just fixed a mmap write vs. truncate consistency issue on gfs on
> > > filesystems with a block size smaller that the page size [1].
> > >
> > > It turns out that the same problem exists between mmap write and hole
> > > punching, and since xfstests doesn't seem to cover that,
> >
> > AFAIA, fsx exercises it pretty often. Certainly it's found problems
> > with XFS in the past w.r.t. these operations.
> >
> > > I've written a
> > > new test [2].
> >
> > I suspect that what we really want is a test that runs
> > _test_generic_punch using mmap rather than pwrite...
> >
> > > Ext4 and xfs both pass that test; they both apparently
> > > mark the pages that have a hole punched in them as read-only so that
> > > page_mkwrite is called before those pages can be written to again.
> >
> > XFS invalidates the range being hole punched (see
> > xfs_flush_unmap_range() under XFS_MMAPLOCK_EXCL, which means any
> > attempt to fault that page back in will block on the MMAPLOCK until
> > the hole punch finishes.
> 
> This isn't about writes during the hole punching, this is about writes
> once the hole is punched. For example, the test case I've posted
> creates the following file layout with 1k blocksize:
> 
>   DDDD DDDD DDDD
> 
> Then it punches a hole like this:
> 
>   DDHH HHHH HHDD
> 
> Then it fills the hole again with mwrite:
> 
>   DDDD DDDD DDDD
> 
> As far as I can tell, that needs to trigger page faults on all three
> pages. I did get these on ext4; judging from the fact that xfs works,
> the also seem to occur there; but on gfs2, page_mkwrite isn't called
> for the two partially mapped pages, only for the page in the middle
> that's entirely within the hole. And I don't see where those pages are
> marked read-only; it appears like pagecache_isize_extended isn't
> called on ext4 or xfs. So how does this work there?

The trick ext4 & xfs use is that they writeout the range being punched
first (see e.g. ext4_punch_hole() calling filemap_write_and_wait_range() or
xfs_flush_unmap_range() called from xfs_free_file_space()). This writeout
also has the effect that all the page mappings for that range get
write-protected.

Another related issue is what Dave points out: Even if you use writeout to
writeprotect pages, GFS2 still seems to have a race where page fault can
come while you are freeing blocks and if you allow that you usually get
into a problematic state. Effects depend on fs implementation details but
usually it can result in stale data exposure or fs corruption.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
