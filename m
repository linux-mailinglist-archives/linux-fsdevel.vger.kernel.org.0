Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C1E69A219
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 00:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBPXFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 18:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPXFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:05:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF144CC82;
        Thu, 16 Feb 2023 15:05:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4191B829D5;
        Thu, 16 Feb 2023 23:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79577C433EF;
        Thu, 16 Feb 2023 23:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676588736;
        bh=tWzvmCqJPOnr45OGjkzXmZBnFUvhmuGwVG9tIKTRbxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoLhVyQ91w3roWKHZetCB/zdG7WBBnqspOpBr3qPbJlP0vzCtOsaQK1nncUeHdYcJ
         l43Tlf4hJfL+gwwRud5eHbkUkugTqyHKtLlTm12Sz3ICIrLg+640OPCJu8FN7G+a4Y
         HRtpEMd8MFWcZFxi2tWzU9erqsrUWDyqbGlWXOhfZ9gUkObLLA3S0iCkPVE6YpMmrx
         foruTRv+K4seG2uRzZulb0OB/IaShtCaLxoE4hacE5c4k4yysy1lBlO6HconYNxMdC
         nCXQxzaeKasHq6zlvQJyBDL64Pi2f3xLvKDYesEfcdYbrqeyrv2uRgyF7y1QjcBMHS
         HKtSNcNL/MzEg==
Date:   Thu, 16 Feb 2023 15:05:35 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 09/14] xfs: document online file metadata repair code
Message-ID: <Y+62v5kfhv5lr/R8@magnolia>
References: <166473478338.1082796.8807888906305023929.stgit@magnolia>
 <166473478486.1082796.11670617428892270355.stgit@magnolia>
 <addbcebf5cc6b59d5910df8cce80d47f445eb891.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <addbcebf5cc6b59d5910df8cce80d47f445eb891.camel@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:46:30PM +0000, Allison Henderson wrote:
> On Sun, 2022-10-02 at 11:19 -0700, Darrick J. Wong wrote:

Not sure why this reply is to the earlier submission of the design doc,
but oh well, it didn't change much between October and December of 2022.

> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add to the fifth chapter of the online fsck design documentation,
> > where
> > we discuss the details of the data structures and algorithms used by
> > the
> > kernel to repair file metadata.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  .../filesystems/xfs-online-fsck-design.rst         |  150
> > ++++++++++++++++++++
> >  1 file changed, 150 insertions(+)
> > 
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst
> > b/Documentation/filesystems/xfs-online-fsck-design.rst
> > index c41f089549a0..10709dc74dcb 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -2872,3 +2872,153 @@ The allocation group free block list (AGFL)
> > is repaired as follows:
> >  4. Once the AGFL is full, reap any blocks leftover.
> >  
> >  5. The next operation to fix the freelist will right-size the list.
> > +
> > +Inode Record Repairs
> > +--------------------
> > +
> > +Inode records must be handled carefully, because they have both
> > ondisk records
> > +("dinodes") and an in-memory ("cached") representation.
> > +There is a very high potential for cache coherency issues if online
> > fsck is not
> > +careful to access the ondisk metadata *only* when the ondisk
> > metadata is so
> > +badly damaged that the filesystem cannot load the in-memory
> > representation.
> > +When online fsck wants to open a damaged file for scrubbing, it must
> > use
> > +specialized resource acquisition functions that return either the
> > in-memory
> > +representation *or* a lock on whichever object is necessary to
> > prevent any
> > +update to the ondisk location.
> > +
> > +The only repairs that should be made to the ondisk inode buffers are
> > whatever
> > +is necessary to get the in-core structure loaded.
> > +This means fixing whatever is caught by the inode cluster buffer and
> > inode fork
> > +verifiers, and retrying the ``iget`` operation.
> > +If the second ``iget`` fails, the repair has failed.
> > +
> > +Once the in-memory representation is loaded, repair can lock the
> > inode and can
> > +subject it to comprehensive checks, repairs, and optimizations.
> > +Most inode attributes are easy to check and constrain, or are user-
> > controlled
> > +arbitrary bit patterns; these are both easy to fix.
> > +Dealing with the data and attr fork extent counts and the file block
> > counts is
> > +more complicated, because computing the correct value requires
> > traversing the
> > +forks, or if that fails, leaving the fields invalid and waiting for
> > the fork
> > +fsck functions to run.
> > +
> > +The proposed patchset is the
> > +`inode
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-inodes>`_
> > +repair series.
> > +
> > +Quota Record Repairs
> > +--------------------
> > +
> > +Similar to inodes, quota records ("dquots") also have both ondisk
> > records and
> > +an in-memory representation, and hence are subject to the same cache
> > coherency
> > +issues.
> > +Somewhat confusingly, both are known as dquots in the XFS codebase.
> > +
> > +The only repairs that should be made to the ondisk quota record
> > buffers are
> > +whatever is necessary to get the in-core structure loaded.
> > +Once the in-memory representation is loaded, the only attributes
> > needing
> > +checking are obviously bad limits and timer values.
> > +
> > +Quota usage counters are checked, repaired, and discussed separately
> > in the
> > +section about :ref:`live quotacheck <quotacheck>`.
> > +
> > +The proposed patchset is the
> > +`quota
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-quota>`_
> > +repair series.
> > +
> > +.. _fscounters:
> > +
> > +Freezing to Fix Summary Counters
> > +--------------------------------
> > +
> > +Filesystem summary counters track availability of filesystem
> > resources such
> > +as free blocks, free inodes, and allocated inodes.
> > +This information could be compiled by walking the free space and
> > inode indexes,
> > +but this is a slow process, so XFS maintains a copy in the ondisk
> > superblock
> > +that should reflect the ondisk metadata, at least when the
> > filesystem has been
> > +unmounted cleanly.
> > +For performance reasons, XFS also maintains incore copies of those
> > counters,
> > +which are key to enabling resource reservations for active
> > transactions.
> > +Writer threads reserve the worst-case quantities of resources from
> > the
> > +incore counter and give back whatever they don't use at commit time.
> > +It is therefore only necessary to serialize on the superblock when
> > the
> > +superblock is being committed to disk.
> > +
> > +The lazy superblock counter feature introduced in XFS v5 took this
> > even further
> > +by training log recovery to recompute the summary counters from the
> > AG headers,
> > +which eliminated the need for most transactions even to touch the
> > superblock.
> > +The only time XFS commits the summary counters is at filesystem
> > unmount.
> > +To reduce contention even further, the incore counter is implemented
> > as a
> > +percpu counter, which means that each CPU is allocated a batch of
> > blocks from a
> > +global incore counter and can satisfy small allocations from the
> > local batch.
> > +
> > +The high-performance nature of the summary counters makes it
> > difficult for
> > +online fsck to check them, since there is no way to quiesce a percpu
> > counter
> > +while the system is running.
> > +Although online fsck can read the filesystem metadata to compute the
> > correct
> > +values of the summary counters, there's no way to hold the value of
> > a percpu
> > +counter stable, so it's quite possible that the counter will be out
> > of date by
> > +the time the walk is complete.
> > +Earlier versions of online scrub would return to userspace with an
> > incomplete
> > +scan flag, but this is not a satisfying outcome for a system
> > administrator.
> > +For repairs, the in-memory counters must be stabilize while walking
> > the
> nit: stablilized

Fixed, thank you.

> > +filesystem metadata to get an accurate reading and install it in the
> > percpu
> > +counter.
> > +
> > +To satisfy this requirement, online fsck must prevent other programs
> > in the
> > +system from initiating new writes to the filesystem, it must disable
> > background
> > +garbage collection threads, and it must wait for existing writer
> > programs to
> > +exit the kernel.
> > +Once that has been established, scrub can walk the AG free space
> > indexes, the
> > +inode btrees, and the realtime bitmap to compute the correct value
> > of all
> > +four summary counters.
> > +This is very similar to a filesystem freeze.
> > +
> > +The initial implementation used the actual VFS filesystem freeze
> > mechanism to
> > +quiesce filesystem activity.
> 
> 
> > +With the filesystem frozen, it is possible to resolve the counter
> > values with
> > +exact precision, but there are many problems with calling the VFS
> > methods
> > +directly:
> > +
> > +- Other programs can unfreeze the filesystem without our knowledge.
> > +  This leads to incorrect scan results and incorrect repairs.
> > +
> > +- Adding an extra lock to prevent others from thawing the filesystem
> > required
> > +  the addition of a ``->freeze_super`` function to wrap
> > ``freeze_fs()``.
> > +  This in turn caused other subtle problems because it turns out
> > that the VFS
> > +  ``freeze_super`` and ``thaw_super`` functions can drop the last
> > reference to
> > +  the VFS superblock, and any subsequent access becomes a UAF bug!
> > +  This can happen if the filesystem is unmounted while the
> > underlying block
> > +  device has frozen the filesystem.
> > +  This problem could be solved by grabbing extra references to the
> > superblock,
> > +  but it felt suboptimal given the other inadequacies of this
> > approach:
> > +
> > +- The log need not be quiesced to check the summary counters, but a
> > VFS freeze
> > +  initiates one anyway.
> > +  This adds unnecessary runtime to live fscounter fsck operations.
> > +
> > +- Quiescing the log means that XFS flushes the (possibly incorrect)
> > counters to
> > +  disk as part of cleaning the log.
> > +
> > +- A bug in the VFS meant that freeze could complete even when
> > sync_filesystem
> > +  fails to flush the filesystem and returns an error.
> > +  This bug was fixed in Linux 5.17.
> > +
> > +The author 
> 
> I think the above is a candidate for culling or maybe the side bar if
> you really feel the need to keep it.

I'll turn it into a sidebar, since it took me a while to figure all that
out, and maybe some day I'll need to refer to what amounts to historic
notes.

> Aside from the fact that it was
> simply bug prone, it makes sense to avoid an entire freeze if we can
> help it.  I think it would be fine to just pop into the current
> proposition:
> 
> "However, this approach was found to be both costly and unstable. 
> Later optimizations of ofsck established ..."

How about:

"...Once that has been established, scrub can walk the AG free space
indexes, the inode btrees, and the realtime bitmap to compute the
correct value of all four summary counters.  This is very similar to a
filesystem freeze, though not all of the pieces are necessary:

- "The final freeze state is set one higher than ``SB_FREEZE_COMPLETE``
  to prevent other threads from thawing the filesystem, or other scrub
  threads from initiating another fscounters freeze.

- IIt does not quiesce the log.

"With this code in place, it is now possible to pause the filesystem for
just long enough to check and correct the summary counters."

<giant historic sidebar here>

?

> > established that the only component of online fsck that requires the
> > +ability to freeze the filesystem is the fscounter scrubber, so the
> > code for
> > +this could be localized to that source file.
> > +fscounter freeze behaves the same as the VFS freeze method, except:
> > +
> > +- The final freeze state is set one higher than
> > ``SB_FREEZE_COMPLETE`` to
> > +  prevent other threads from thawing the filesystem.
> > +
> > +- It does not quiesce the log.
> > +
> > +With this code in place, it is now possible to pause the filesystem
> > for just
> > +long enough to check and correct the summary counters.
> > +
> > +The proposed patchset is the
> > +`summary counter cleanup
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=repair-fscounters>`_
> > +series.
> > 
> 
> Otherwise looks good.  :-)

Thanks!

--D

> Allison
> 
