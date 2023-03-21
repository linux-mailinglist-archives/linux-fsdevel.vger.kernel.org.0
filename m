Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC97D6C3548
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 16:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjCUPOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCUPOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:14:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027FC5261;
        Tue, 21 Mar 2023 08:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03F23B817C0;
        Tue, 21 Mar 2023 15:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76D0C433EF;
        Tue, 21 Mar 2023 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679411619;
        bh=0Iwy/vDqt7mXeicFOYkbKbYVA6PpicVIbc2RJjP5C5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rm/TBm5HfiLwVKpaRdbApnoyQi0uEg1tvjLbR8fem1lrcwqoV0KgXzlHJE9DF9qgh
         wzBnqOSpqVNuzvv9D7V9Q6wVn0XxcR+OiNAW5TcjY6RgNT7N8+EKJuZC/DLA9qJ+tZ
         MSfKWYF6rTg7Uxq6TfskE0PBdlPZAtSzIUdkFyqmO/lQvm4paaYkBrm6jQNptyVK4H
         vLNWpAoy4BLqD6c7UzDOaXfoYg3YfwLcx13mh7yPjxHivxA2quoeM0XTTtnivd/0v2
         S63Td/76u69FidkhYG1QTCMWsJ6coSyVU8AqtYN7/GK78lBdizegA9EJKnfWXnmZFB
         aY1GpR1uFXh+Q==
Date:   Tue, 21 Mar 2023 08:13:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH] xfs: check shared state of when CoW, update reflink
 flag when io ends
Message-ID: <20230321151339.GA11376@frogsfrogsfrogs>
References: <1679025588-21-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20230317203505.GK11394@frogsfrogsfrogs>
 <011cd163-4e6b-40b9-beeb-7fbc55b3a369@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <011cd163-4e6b-40b9-beeb-7fbc55b3a369@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 06:02:05PM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2023/3/18 4:35, Darrick J. Wong 写道:
> > On Fri, Mar 17, 2023 at 03:59:48AM +0000, Shiyang Ruan wrote:
> > > As is mentioned[1] before, the generic/388 will randomly fail with dmesg
> > > warning.  This case uses fsstress with a lot of random operations.  It is hard
> > > to  reproduce.  Finally I found a 100% reproduce condition, which is setting
> > > the seed to 1677104360.  So I changed the generic/388 code: removed the loop
> > > and used the code below instad:
> > > ```
> > > ($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -v -s 1677104360 -n 221 -p 1 >> $seqres.full) > /dev/null 2>&1
> > > ($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -v -s 1677104360 -n 221 -p 1 >> $seqres.full) > /dev/null 2>&1
> > > _check_dmesg_for dax_insert_entry
> > > ```
> > > 
> > > According to the operations log, and kernel debug log I added, I found that
> > > the reflink flag of one inode won't be unset even if there's no more shared
> > > extents any more.
> > >    Then write to this file again.  Because of the reflink flag, xfs thinks it
> > >      needs cow, and extent(called it extA) will be CoWed to a new
> > >      extent(called it extB) incorrectly.  And extA is not used any more,
> > >      but didn't be unmapped (didn't do dax_disassociate_entry()).
> > 
> > IOWs, dax_iomap_copy_around (or something very near it) should be
> > calling dax_disassociate_entry on the source range after copying extA's
> > contents to extB to drop its page->shared count?
> 
> If extA is a shared extent, its pages will be disassociated correctly by
> invalidate_inode_pages2_range() in dax_iomap_iter().
> 
> But the problem is that extA is not shared but now be CoWed,

Aha!  Ok, I hadn't realized that extA is not shared...

> invalidate_inode_pages2_range() is also called but it can't disassociate the
> old page (because the page is marked dirty, can't be invalidated)

...so what marked the old page dirty?   Was it the case that the
unshared extA got marked dirty, then later someone created a cow
reservation (extB, I guess) that covered the already dirty extA?

Should we be transferring the dirty state from A to B here before the
invalidate_inode_pages2_range ?

> Is the behavior to do CoW on a non-shared extent allowed?

In general, yes, XFS allows COW on non-shared extents.  The (cow) extent
size hint provides for cowing the unshared blocks adjacent to a shared
block to try to combat fragmentation.

> > 
> > >    The next time we mapwrite to another file, xfs will allocate extA for it,
> > >      page fault handler do dax_associate_entry().  BUT bucause the extA didn't
> > >      be unmapped, it still stores old file's info in page->mapping,->index.
> > >      Then, It reports dmesg warning when it try to sotre the new file's info.
> > > 
> > > So, I think:
> > >    1. reflink flag should be updated after CoW operations.
> > >    2. xfs_reflink_allocate_cow() should add "if extent is shared" to determine
> > >       xfs do CoW or not.
> > > 
> > > I made the fix patch, it can resolve the fail of generic/388.  But it causes
> > > other cases fail: generic/127, generic/263, generic/616, xfs/315 xfs/421. I'm
> > > not sure if the fix is right, or I have missed something somewhere.  Please
> > > give me some advice.
> > > 
> > > Thank you very much!!
> > > 
> > > [1]: https://lore.kernel.org/linux-xfs/1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com/
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >   fs/xfs/xfs_reflink.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > >   fs/xfs/xfs_reflink.h |  2 ++
> > >   2 files changed, 46 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> > > index f5dc46ce9803..a6b07f5c1db2 100644
> > > --- a/fs/xfs/xfs_reflink.c
> > > +++ b/fs/xfs/xfs_reflink.c
> > > @@ -154,6 +154,40 @@ xfs_reflink_find_shared(
> > >   	return error;
> > >   }
> > > +int xfs_reflink_extent_is_shared(
> > > +	struct xfs_inode	*ip,
> > > +	struct xfs_bmbt_irec	*irec,
> > > +	bool			*shared)
> > > +{
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +	struct xfs_perag	*pag;
> > > +	xfs_agblock_t		agbno;
> > > +	xfs_extlen_t		aglen;
> > > +	xfs_agblock_t		fbno;
> > > +	xfs_extlen_t		flen;
> > > +	int			error = 0;
> > > +
> > > +	*shared = false;
> > > +
> > > +	/* Holes, unwritten, and delalloc extents cannot be shared */
> > > +	if (!xfs_bmap_is_written_extent(irec))
> > > +		return 0;
> > > +
> > > +	pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, irec->br_startblock));
> > > +	agbno = XFS_FSB_TO_AGBNO(mp, irec->br_startblock);
> > > +	aglen = irec->br_blockcount;
> > > +	error = xfs_reflink_find_shared(pag, NULL, agbno, aglen, &fbno, &flen,
> > > +			true);
> > > +	xfs_perag_put(pag);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	if (fbno != NULLAGBLOCK)
> > > +		*shared = true;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   /*
> > >    * Trim the mapping to the next block where there's a change in the
> > >    * shared/unshared status.  More specifically, this means that we
> > > @@ -533,6 +567,12 @@ xfs_reflink_allocate_cow(
> > >   		xfs_ifork_init_cow(ip);
> > >   	}
> > > +	error = xfs_reflink_extent_is_shared(ip, imap, shared);
> > > +	if (error)
> > > +		return error;
> > > +	if (!*shared)
> > > +		return 0;
> > > +
> > >   	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
> > >   	if (error || !*shared)
> > >   		return error;
> > > @@ -834,6 +874,10 @@ xfs_reflink_end_cow_extent(
> > >   	/* Remove the mapping from the CoW fork. */
> > >   	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
> > > +	error = xfs_reflink_clear_inode_flag(ip, &tp);
> > 
> > This will disable COW on /all/ blocks in the entire file, including the
> > shared ones.  At a bare minimum you'd have to scan the entire data fork
> > to ensure there are no shared extents.  That's probably why doing this
> > causes so many new regressions.
> 
> This function will search for shared extent before actually clearing the
> flag.  If no shared extent found, the flag won't be cleared.  The name of
> this function is not very accurate.

Oh, right.  I forgot that _reflink_clear_inode_flag walks the entire
data fork looking for shared extents, and only clears the flag if it
doesn't find any.

That said, if (say) this is a large sparse file with 300 million extent
records and extent 299,999,999 is shared, this is going to make write
completions realllllly slow, as each completion now has to perform its
own walk...

> BTW, in my thought, the reflink flag is to indicate if a file is now
> containing any shared extents or not.  So, it should be cleared immediately
> if no extents shared any more.  Is this right?

...which is why we don't clear the flag immediately.  Or ever.  Only
repairs take the time to do that.

--D

> 
> 
> --
> Thanks,
> Ruan.
> 
> PS: Let me paste the log of failed tests:
> generic/127, generic/263, generic/616 are fsx tests.  Their fail message are
> meaningless.  I am looking into their difference between good/bad results.
> 
> xfs/315 0s ... - output mismatch (see
> /root/xts/results//dax_reflink/xfs/315.out.bad)
>     --- tests/xfs/315.out       2022-08-03 10:56:02.696212673 +0800
>     +++ /root/xts/results//dax_reflink/xfs/315.out.bad  2023-03-20
> 17:48:01.780369739 +0800
>     @@ -7,7 +7,6 @@
>      Inject error
>      CoW a few blocks
>      FS should be shut down, touch will fail
>     -touch: cannot touch 'SCRATCH_MNT/badfs': Input/output error
>      Remount to replay log
>      FS should be online, touch should succeed
>      Check files again
>     ...
>     (Run 'diff -u /root/xts/tests/xfs/315.out
> /root/xts/results//dax_reflink/xfs/315.out.bad'  to see the entire diff)
> xfs/421 1s ... - output mismatch (see
> /root/xts/results//dax_reflink/xfs/421.out.bad)
>     --- tests/xfs/421.out       2022-08-03 10:56:02.706212718 +0800
>     +++ /root/xts/results//dax_reflink/xfs/421.out.bad  2023-03-20
> 17:48:02.222369739 +0800
>     @@ -14,8 +14,6 @@
>      Whence     Result
>      DATA       0
>      HOLE       131072
>     -DATA       196608
>     -HOLE       262144
>      Compare files
>      c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-421/file1
>     ...
>     (Run 'diff -u /root/xts/tests/xfs/421.out
> /root/xts/results//dax_reflink/xfs/421.out.bad'  to see the entire diff)
> 
> > 
> > --D
> > 
> > > +	if (error)
> > > +		goto out_cancel;
> > > +
> > >   	error = xfs_trans_commit(tp);
> > >   	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > >   	if (error)
> > > diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> > > index 65c5dfe17ecf..d5835814bce6 100644
> > > --- a/fs/xfs/xfs_reflink.h
> > > +++ b/fs/xfs/xfs_reflink.h
> > > @@ -16,6 +16,8 @@ static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
> > >   	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
> > >   }
> > > +int xfs_reflink_extent_is_shared(struct xfs_inode *ip,
> > > +		struct xfs_bmbt_irec *irec, bool *shared);
> > >   extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
> > >   		struct xfs_bmbt_irec *irec, bool *shared);
> > >   int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
> > > -- 
> > > 2.39.2
> > > 
