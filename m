Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B9D5B26C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 02:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfGAAKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 20:10:13 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50460 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726402AbfGAAKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 20:10:13 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id BF99143C6B5;
        Mon,  1 Jul 2019 10:10:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hhjsR-0003pM-Ia; Mon, 01 Jul 2019 10:08:59 +1000
Date:   Mon, 1 Jul 2019 10:08:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190701000859.GL7777@dread.disaster.area>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-12-hch@lst.de>
 <20190624234304.GD7777@dread.disaster.area>
 <20190625101020.GI1462@lst.de>
 <20190628004542.GJ7777@dread.disaster.area>
 <20190628053320.GA26902@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628053320.GA26902@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=gcBstl5XYRDGDS1EmpUA:9 a=qcOipdrg3TMiS51E:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 07:33:20AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 28, 2019 at 10:45:42AM +1000, Dave Chinner wrote:
> > You've already mentioned two new users you want to add. I don't even
> > have zone capable hardware here to test one of the users you are
> > indicating will use this code, and I suspect that very few people
> > do.  That's a non-trivial increase in testing requirements for
> > filesystem developers and distro QA departments who will want to
> > change and/or validate this code path.
> 
> Why do you assume you have to test it?  Back when we shared
> generic_file_read with everyone you also didn't test odd change to
> it with every possible fs.

I'm not sure what function you are referring to here. Can you
clarify?

> If you change iomap.c, you'll test it
> with XFS, and Cc other maintainers so that they get a chance to
> also test it and comment on it, just like we do with other shared
> code in the kernel.

Which is why we've had problems with the generic code paths in the
past and other filesystems just copy and paste then before making
signficant modifications. e.g. both ext4 and btrfs re-implement
write_cache_pages() rather than use the generic writeback code
because they have slightly different requirements and those
developers don't want to have to worry about other filesystems every
time there is an internal filesystem change that affects their
writeback constraints...

That's kinda what I'm getting at here: writeback isn't being shared
by any of the major filesystems for good reasons...

> > Indeed, integrating gfs2 into the existing generic iomap code has
> > required quite a bit of munging and adding new code paths and so on.
> > That's mostly been straight forward because it's just been adding
> > flags and conditional code to the existing paths. The way we
> > regularly rewrite sections of the XFS writeback code is a very
> > different sort of modification, and one that will be much harder to
> > do if we have to make those changes to generic code.
> 
> As the person who has done a lot of the recent rewriting of the
> writeback code I disagree.  Most of it has been do divorce is from
> leftovers of the buffer_head based sinle page at a time design from
> stone age.  Very little is about XFS itself, most of it has been
> about not being stupid in a fairly generic way.  And every since
> I got rid of buffer heads xfs_aops.c has been intimately tied
  ^^^^^^^^^^^^^^^^^^^^^^^^^

*cough*

Getting rid of bufferheads in writeback was largely a result of work
I did over a period of several years, thank you very much. Yes, work
you did over the same time period also got us there, but it's not
all your work.

> into the iomap infrastructure, and I'd rather keep those details in
> one place.  I.e. with this series now XFS doesn't even need to know
> about the details of the iomap_page structure and the uptodate
> bits.  If for example I'd want to add sub-page dirty bits (which I
> don't if I can avoid it) I can handle this entirely in iomap now
> instead of spreading around iomap, xfs and duplicating the thing
> in every copy of the XFS code that would otherwise show up.

Yes, I understand your motivations, I'm just not convinced that it
is the right thing to do given the history of this code and the
history of filesystem writeback code in general....

> > i.e. shared code is good if it's simple and doesn't have a lot of
> > external dependencies that restrict the type and scope of
> > modifications that can be made easily. Shared code that is complex
> > and comes from code that was tightly integrated with a specific
> > subsystem architecture is going to carry all those architectural
> > foilbles into the new "generic" code. Once it gets sufficient
> > users it's going to end up with the same "we can't change this code"
> > problems that we had with the existing IO path, and we'll go back to
> > implementing our own writeback path....
> 
> From the high level POV I agree with your stance.  But the point is
> that the writeback code is not tightly integrated with xfs, and that

Except it is....

> is why I don't want it in XFS.  It is on other other hand very
> tightly integrated with the iomap buffer read and write into pagecache
> code, which is why I want to keep it together with that.

It's not tightly integrated into the iomap read side or page cache
implementations.  Writeback currently gets a dirty page, we look up
a block map, we add it to/create a cached ioend/bio pair.  There are
four lines of code in the entire XFS writeback code path that
interact with iomap specific state, and that's the grand total of
interactions needed to support block size < page size writeback.

IOWs, we barely interact with the page cache or page/iomap state at
all in writeback anymore - we just write whole pages based on the
current inode extent map state. Yes, the writepage context, the
ioends and the extent map structures we use to implement this can be
made generic, but it's all the other details that are the problem
here.

e.g. If we have an error, we have to do very XFS specific things
(like punching out delalloc ranges) and so the generic iomap code
has a hook for doing this XFS specific thing when necessary.

e.g. XFS requires COW fork manipulation on ioend submission
(xfs_submit_ioend() calls xfs_reflink_convert_cow()) and this has
some nasty memory allocation requirements (potential deadlock
situation). So the generic code has a hook for this XFS specific
functionality, even though no other filesystem if likely to ever
need this. And this is something we've been discussion getting rid
of from the XFS writeback path. i.e. reworking how we do all
the COW fork interactions in writeback. So some of these hooks are
suspect even now, and we're already trying to work out how to
re-work the XFS writeback path to sort out problems we have with it.

That's the point I'm trying to make - the whole "generic" iomap
writeback API proposal is based around exactly the functionality XFS
- and only XFS - requires at this point in time. There are no other
users of this API and until there are, we've got no idea how
generic this functionality really is and just how much overhead
making fundamental changes to the XFS writeback code are going to
entail in future.

IOWs, before we go any further I'd really like to see how the other
proposed users of this functionality fit into the code and how
generic these XFS hooks are and what new hooks they require to
implement their specific functionality...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
