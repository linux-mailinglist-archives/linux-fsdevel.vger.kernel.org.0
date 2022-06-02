Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA2453B3E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 08:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiFBGxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiFBGw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:52:59 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0C3BC22;
        Wed,  1 Jun 2022 23:52:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 804EC5EC53C;
        Thu,  2 Jun 2022 16:52:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwehQ-001hT0-GM; Thu, 02 Jun 2022 16:52:52 +1000
Date:   Thu, 2 Jun 2022 16:52:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Mason <clm@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Message-ID: <20220602065252.GD1098723@dread.disaster.area>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62985e47
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8
        a=eJfxgxciAAAA:8 a=7-415B0cAAAA:8 a=HJgjh_s6yEUk2DSsFgoA:9
        a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=xM9caqqi1sUkTy8OJ5Uh:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:13:42PM +0000, Chris Mason wrote:
> 
> > On Jun 1, 2022, at 8:18 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > This does look sane to me. How much testing did this get?
> 
> Almost none at all, I made sure the invalidates were triggering
> and bashed on it with fsx, but haven’t even done xfstests yet.
> The first rule about truncate is that v1 patches are always
> broken, so I’m expecting explosions.

If there are going to be explosions, it will be on block size < page
size configs, I think. Otherwise the folio_invalidate() call is a
largely a no-op.

> 
> > Especially
> > for the block size < page sie case? Also adding Dave as he has spent
> > a lot of time on this code.
> > 
> 
> Sorry Dave, I thought I had you in here already.

You did - you got me with linux-xfs@...

> > On Tue, May 31, 2022 at 06:11:17PM -0700, Chris Mason wrote:
> >> iomap_do_writepage() sends pages past i_size through
> >> folio_redirty_for_writepage(), which normally isn't a problem because
> >> truncate and friends clean them very quickly.
> >> 
> >> When the system a variety of cgroups,
> > 
> > ^^^ This sentence does not parse ^^^
>
> Most of production is setup with one cgroup tree for the workloads
> we love and care about, and a few cgroup trees for everything
> else.  We tend to crank down memory or IO limits on the unloved
> cgroups and prioritize the workload cgroups.
> 
> This problem is hitting our mysql workloads, which are mostly
> O_DIRECT on a relatively small number of files.  From a kernel
> point of view it’s a lot of IO and not much actual resource
> management.  What’s happening in prod (on an older 5.6 kernel) is
> the non-mysql cgroups are blowing past the background dirty
> threshold, which kicks off the async writeback workers.
> 
> The actual call path is:
> wb_workfn()->wb_do_writeback()->wb_check_background_flush()->wb_writeback()->__writeback_inodes_sb()
> 
> Johannes explained to me that wb_over_bg_thresh(wb) ends up
> returning true on the mysql cgroups because the global background
> limit has been reached, even though mysql didn’t really contribute
> much of the dirty.  So we call down into wb_writeback(), which
> will loop as long as __writeback_inodes_wb() returns that it’s
> making progress and we’re still globally over the bg threshold.

*nod*

> In prod, bpftrace showed looping on a single inode inside a mysql
> cgroup.  That inode was usually in the middle of being deleted,
> i_size set to zero, but it still had 40-90 pages sitting in the
> xarray waiting for truncation.  We’d loop through the whole call
> path above over and over again, mostly because writepages() was
> returning progress had been made on this one inode.  The
> redirty_page_for_writepage() path does drop wbc->nr_to_write, so
> the rest of the writepages machinery believes real work is being
> done.  nr_to_write is LONG_MAX, so we’ve got a while to loop.

Yup, this code relies on truncate making progress to avoid looping
forever. Truncate should only block on the page while it locks it
and waits for writeback to complete, then it gets forcibly
invalidated and removed from the page cache.

Ok, so assuming this is the case, why is truncate apparently not
making progress? I can understand that it might lockstep with
writeback trying to write and then redirtying folios, but that
lockstep pass of ascending folio index should only happen once
because once truncate locks the folio the page gets removed from
the mapping regardless of whether it is clean or dirty.

Oh.

Aren't there starvation problems with folio_lock() because the
wakeup is not atomic with granting the lock bit? Hence if something
is locking and unlocking a page in quick succession, a waiter can be
woken but by the time it has been scheduled and running the lock bit
has been taken by someone else and so it goes back to sleep?

And the patch fixes this problem by breaking the lock/unlock cycling
in writeback() by not redirtying the folio and and so writback
doesn't iterate straight back to it and lock it again?

Regardless of the cause, why do we redirty the page there?

/me trolls through git history

commit ff9a28f6c25d18a635abcab1f49db68108203dfb
Author: Jan Kara <jack@suse.cz>
Date:   Thu Mar 14 14:30:54 2013 +0100

    xfs: Fix WARN_ON(delalloc) in xfs_vm_releasepage()
    
    When a dirty page is truncated from a file but reclaim gets to it before
    truncate_inode_pages(), we hit WARN_ON(delalloc) in
    xfs_vm_releasepage(). This is because reclaim tries to write the page,
    xfs_vm_writepage() just bails out (leaving page clean) and thus reclaim
    thinks it can continue and calls xfs_vm_releasepage() on page with dirty
    buffers.
    
    Fix the issue by redirtying the page in xfs_vm_writepage(). This makes
    reclaim stop reclaiming the page and also logically it keeps page in a
    more consistent state where page with dirty buffers has PageDirty set.
    
    Signed-off-by: Jan Kara <jack@suse.cz>
    Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
    Signed-off-by: Ben Myers <bpm@sgi.com>

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 5f707e537171..3244c988d379 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -953,13 +953,13 @@ xfs_vm_writepage(
                unsigned offset_into_page = offset & (PAGE_CACHE_SIZE - 1);
 
                /*
-                * Just skip the page if it is fully outside i_size, e.g. due
-                * to a truncate operation that is in progress.
+                * Skip the page if it is fully outside i_size, e.g. due to a
+                * truncate operation that is in progress. We must redirty the
+                * page so that reclaim stops reclaiming it. Otherwise
+                * xfs_vm_releasepage() is called on it and gets confused.
                 */
-               if (page->index >= end_index + 1 || offset_into_page == 0) {
-                       unlock_page(page);
-                       return 0;
-               }
+               if (page->index >= end_index + 1 || offset_into_page == 0)
+                       goto redirty;
 
                /*
                 * The page straddles i_size.  It must be zeroed out on each

Ah, I remember those problems. Random WARN_ON()s during workloads
under heavy memory pressure and lots of page cache dirtying.
Essentially, this fix was working around the old "writepage to clean
dirty pages at the end of the LRU during memory reclaim"
anti-pattern.  Well, that problem doesn't exist anymore - XFS hasn't
had a ->writepage method for some time now memory reclaim can't
clean dirty pages on XFS filesystems directly and hence can't try to
clean and release dirty pages while a truncate is in progress.

Further, the filesystem extent state coherency problems with
bufferhead caching that triggered in ->releasepage don't exist
anymore, either. That was one of the exact problems we invented
iomap to solve....

Hence I think we can remove the redirtying completely - it's not
needed and hasn't been for some time.

Further, I don't think we need to invalidate the folio, either. If
it's beyond EOF, then it is because a truncate is in progress that
means it is somebody else's problem to clean up. Hence we should
leave it to the truncate to deal with, just like the pre-2013 code
did....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
