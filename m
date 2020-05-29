Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8821E7D77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgE2MpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 08:45:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:57280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2MpQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 08:45:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4AD7FAE16;
        Fri, 29 May 2020 12:45:14 +0000 (UTC)
Date:   Fri, 29 May 2020 07:45:10 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
Message-ID: <20200529124510.rqpd5nfivafiswiw@fiona>
References: <20200528192103.xm45qoxqmkw7i5yl@fiona>
 <20200529002319.GQ252930@magnolia>
 <CAL3q7H4Mit=P9yHsZXKsVxMN0=7m7gS2ZqiGTbyFz5Aid9t3hQ@mail.gmail.com>
 <20200529113116.GU17206@bombadil.infradead.org>
 <CAL3q7H5cp8joqHnS8rtPBBEQyYw9L0KbRNCQwFfKz1pD-tZvwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5cp8joqHnS8rtPBBEQyYw9L0KbRNCQwFfKz1pD-tZvwQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12:50 29/05, Filipe Manana wrote:
> On Fri, May 29, 2020 at 12:31 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, May 29, 2020 at 11:55:33AM +0100, Filipe Manana wrote:
> > > On Fri, May 29, 2020 at 1:23 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > >
> > > > On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> > > > >
> > > > > Filesystems such as btrfs are unable to guarantee page invalidation
> > > > > because pages could be locked as a part of the extent. Return zero
> > > >
> > > > Locked for what?  filemap_write_and_wait_range should have just cleaned
> > > > them off.
> > >
> > > Yes, it will be confusing even for someone more familiar with btrfs.
> > > The changelog could be more detailed to make it clear what's happening and why.
> > >
> > > So what happens:
> > >
> > > 1) iomap_dio_rw() calls filemap_write_and_wait_range().
> > >     That starts delalloc for all dirty pages in the range and then
> > > waits for writeback to complete.
> > >     This is enough for most filesystems at least (if not all except btrfs).
> > >
> > > 2) However, in btrfs once writeback finishes, a job is queued to run
> > > on a dedicated workqueue, to execute the function
> > > btrfs_finish_ordered_io().
> > >     So that job will be run after filemap_write_and_wait_range() returns.
> > >     That function locks the file range (using a btrfs specific data
> > > structure), does a bunch of things (updating several btrees), and then
> > > unlocks the file range.
> > >
> > > 3) While iomap calls invalidate_inode_pages2_range(), which ends up
> > > calling the btrfs callback btfs_releasepage(),
> > >     btrfs_finish_ordered_io() is running and has the file range locked
> > > (this is what Goldwyn means by "pages could be locked", which is
> > > confusing because it's not about any locked struct page).
> > >
> > > 4) Because the file range is locked, btrfs_releasepage() returns 0
> > > (page can't be released), this happens in the helper function
> > > try_release_extent_state().
> > >     Any page in that range is not dirty nor under writeback anymore
> > > and, in fact, btrfs_finished_ordered_io() doesn't do anything with the
> > > pages, it's only updating metadata.
> > >
> > >     btrfs_releasepage() in this case could release the pages, but
> > > there are other contextes where the file range is locked, the pages
> > > are still not dirty and not under writeback, where this would not be
> > > safe to do.
> >
> > Isn't this the bug, though?  Rather than returning "page can't be
> > released", shouldn't ->releasepage sleep on the extent state, at least
> > if the GFP mask indicates you can sleep?
> 
> Goldwyn mentioned in another thread that he had tried that with the
> following patch:
> 
> https://patchwork.kernel.org/patch/11275063/
> 
> But he mentioned it didn't work though, caused some locking problems.
> I don't know the details and I haven't tried the patchset yet.
> Goldwyn?
> 

Yes, direct I/O would wait for extent bits to be unlocked forever and hang.
I think it was against an fsync call, but I don't remember. In the light
of new developments, I would pursue this further. This should be valid
even in the current (before iomap patches) source.

-- 
Goldwyn
