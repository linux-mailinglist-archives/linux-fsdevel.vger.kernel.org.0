Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE305938E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 07:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfF1Flx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 01:41:53 -0400
Received: from verein.lst.de ([213.95.11.210]:45079 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbfF1Flx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:41:53 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2019 01:41:52 EDT
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7AFC268C4E; Fri, 28 Jun 2019 07:33:20 +0200 (CEST)
Date:   Fri, 28 Jun 2019 07:33:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190628053320.GA26902@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-12-hch@lst.de> <20190624234304.GD7777@dread.disaster.area> <20190625101020.GI1462@lst.de> <20190628004542.GJ7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628004542.GJ7777@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:45:42AM +1000, Dave Chinner wrote:
> You've already mentioned two new users you want to add. I don't even
> have zone capable hardware here to test one of the users you are
> indicating will use this code, and I suspect that very few people
> do.  That's a non-trivial increase in testing requirements for
> filesystem developers and distro QA departments who will want to
> change and/or validate this code path.

Why do you assume you have to test it?  Back when we shared
generic_file_read with everyone you also didn't test odd change to
it with every possible fs.  If you change iomap.c, you'll test it
with XFS, and Cc other maintainers so that they get a chance to
also test it and comment on it, just like we do with other shared
code in the kernel.

> Indeed, integrating gfs2 into the existing generic iomap code has
> required quite a bit of munging and adding new code paths and so on.
> That's mostly been straight forward because it's just been adding
> flags and conditional code to the existing paths. The way we
> regularly rewrite sections of the XFS writeback code is a very
> different sort of modification, and one that will be much harder to
> do if we have to make those changes to generic code.

As the person who has done a lot of the recent rewriting of the
writeback code I disagree.  Most of it has been do divorce is from
leftovers of the buffer_head based sinle page at a time design from
stone age.  Very little is about XFS itself, most of it has been
about not being stupid in a fairly generic way.  And every since
I got rid of buffer heads xfs_aops.c has been intimately tied
into the iomap infrastructure, and I'd rather keep those details in
one place.  I.e. with this series now XFS doesn't even need to know
about the details of the iomap_page structure and the uptodate
bits.  If for example I'd want to add sub-page dirty bits (which I
don't if I can avoid it) I can handle this entirely in iomap now
instead of spreading around iomap, xfs and duplicating the thing
in every copy of the XFS code that would otherwise show up.

> i.e. shared code is good if it's simple and doesn't have a lot of
> external dependencies that restrict the type and scope of
> modifications that can be made easily. Shared code that is complex
> and comes from code that was tightly integrated with a specific
> subsystem architecture is going to carry all those architectural
> foilbles into the new "generic" code. Once it gets sufficient
> users it's going to end up with the same "we can't change this code"
> problems that we had with the existing IO path, and we'll go back to
> implementing our own writeback path....

From the high level POV I agree with your stance.  But the point is
that the writeback code is not tightly integrated with xfs, and that
is why I don't want it in XFS.  It is on other other hand very
tightly integrated with the iomap buffer read and write into pagecache
code, which is why I want to keep it together with that.

> I've been planning on taking it even closer to the extent tree to
> give us lockless, modification range coherent extent map caching in
> this path (e.g. write() can add new delalloc extents without
> invalidating cached writeback maps).  This patchset re-introduces
> the iomap abstraction over the bmbt - an abstraction we removed some
> time ago - and that makes these sorts of improvements much harder
> and more complex to implement....

FYI, I had an earlier but not quite optimal implementation of lockless
extent lookups using rcu updates in the btree.  And at least for that
scheme all the details stay 100% in XFS in the split code, as the
abstraction between iomap and xfs is very clear and allows for that.
