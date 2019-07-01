Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236BE5B53C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 08:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfGAGng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 02:43:36 -0400
Received: from verein.lst.de ([213.95.11.211]:58657 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfGAGng (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:43:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 831C568B20; Mon,  1 Jul 2019 08:43:33 +0200 (CEST)
Date:   Mon, 1 Jul 2019 08:43:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190701064333.GA20778@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-12-hch@lst.de> <20190624234304.GD7777@dread.disaster.area> <20190625101020.GI1462@lst.de> <20190628004542.GJ7777@dread.disaster.area> <20190628053320.GA26902@lst.de> <20190701000859.GL7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701000859.GL7777@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:08:59AM +1000, Dave Chinner wrote:
> > Why do you assume you have to test it?  Back when we shared
> > generic_file_read with everyone you also didn't test odd change to
> > it with every possible fs.
> 
> I'm not sure what function you are referring to here. Can you
> clarify?

Right now it is generic_file_read_iter(), but before iter it was
generic_file_readv, generic_file_read, etc.

> > If you change iomap.c, you'll test it
> > with XFS, and Cc other maintainers so that they get a chance to
> > also test it and comment on it, just like we do with other shared
> > code in the kernel.
> 
> Which is why we've had problems with the generic code paths in the
> past and other filesystems just copy and paste then before making
> signficant modifications. e.g. both ext4 and btrfs re-implement
> write_cache_pages() rather than use the generic writeback code
> because they have slightly different requirements and those
> developers don't want to have to worry about other filesystems every
> time there is an internal filesystem change that affects their
> writeback constraints...
> 
> That's kinda what I'm getting at here: writeback isn't being shared
> by any of the major filesystems for good reasons...

I very fundamentally disagree.  It is not shared for a bad reasons,
and that is people not understanding the mess that the buffer head
based code is, and not wanting to understand it.  So they come up
with their own piecemeal "improvements" for it making the situation
worse.  Writeback is fundamentally not fs specific in any way.  Different
file system might use different optional features like unwrittent
extents, delalloc, data checksums, but once they implement them the
behavior should be uniform.

And I'd much rather fix this than going down the copy an paste and
slightly tweak it while fucking up something else route.

> > stone age.  Very little is about XFS itself, most of it has been
> > about not being stupid in a fairly generic way.  And every since
> > I got rid of buffer heads xfs_aops.c has been intimately tied
>   ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> *cough*
> 
> Getting rid of bufferheads in writeback was largely a result of work
> I did over a period of several years, thank you very much. Yes, work
> you did over the same time period also got us there, but it's not
> all your work.

Sorry Dave - this isn't avoud taking credit of past work.  But ever
since I finally got rid of bufferhads and introduced struct iomap_page
we have this intimate tie up, which is the point here.

> e.g. XFS requires COW fork manipulation on ioend submission
> (xfs_submit_ioend() calls xfs_reflink_convert_cow()) and this has
> some nasty memory allocation requirements (potential deadlock
> situation). So the generic code has a hook for this XFS specific
> functionality, even though no other filesystem if likely to ever
> need this. And this is something we've been discussion getting rid
> of from the XFS writeback path. i.e. reworking how we do all
> the COW fork interactions in writeback. So some of these hooks are
> suspect even now, and we're already trying to work out how to
> re-work the XFS writeback path to sort out problems we have with it.

Every file system that writes out of place will need some sort of
hook here with the same issue, no matter if they call it COW fork
or manipulate some all integrated data structure like btrfs.  Moreover
btrfs will also have to deal with their data checksum in exactly this
place.

> That's the point I'm trying to make - the whole "generic" iomap
> writeback API proposal is based around exactly the functionality XFS
> - and only XFS - requires at this point in time. There are no other
> users of this API and until there are, we've got no idea how
> generic this functionality really is and just how much overhead
> making fundamental changes to the XFS writeback code are going to
> entail in future.

No, it is based around generalizing what we have in xfs so that we
can use it elsewhere.  With zonefs and gfs2 as the prime users
initially, and other like btrfs hopefully to not far away.
