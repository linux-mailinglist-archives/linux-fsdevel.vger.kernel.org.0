Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374E67B6E20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbjJCQKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjJCQKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:10:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950979E;
        Tue,  3 Oct 2023 09:10:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23475C433C7;
        Tue,  3 Oct 2023 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696349430;
        bh=ZWra+Tq42G4p2SC+6ScLVya/KfCUOp/MUUn0GCmN6Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LN+jGW/DZvPxLjnUTEFwjYJf8ZmqMDiEsLAJkvx+12L9yFSGyfBEAVYuK/EnvVZj2
         416zl+clfR5+bFCkzCdnlcpZv3SUxgQzII9WXYmVJqrEHNPYeC2tm3hY9OJQxvIJ7b
         LHYam79H9W8pzKyi4S0bHp4Nm2jCvkDtAMfdfgkVP8u8yAEvL9vBZ128asksqFI/Ss
         ZTktjmldERHqw88xLEJE7T6Nl76ZFwpqV19IpoW3/QquoZutdef7AEMwJ4BDoVJLWU
         +l6s4N2ZgtUUJEsm2/iH2ALfAvwYOjDy8IF5/06ugTIwOMybrN1o2S8CXfH4ciHOBL
         eIEhGrIb9OMjA==
Date:   Tue, 3 Oct 2023 09:10:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 15/21] fs: xfs: Support atomic write for statx
Message-ID: <20231003161029.GG21298@frogsfrogsfrogs>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-16-john.g.garry@oracle.com>
 <ZRuLQKKPCzyUZtC9@dread.disaster.area>
 <9be14161-907e-92f6-d214-11df00693fac@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be14161-907e-92f6-d214-11df00693fac@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:56:52AM +0100, John Garry wrote:
> On 03/10/2023 04:32, Dave Chinner wrote:
> > On Fri, Sep 29, 2023 at 10:27:20AM +0000, John Garry wrote:
> > > Support providing info on atomic write unit min and max for an inode.
> > > 
> > > For simplicity, currently we limit the min at the FS block size, but a
> > > lower limit could be supported in future.
> > > 
> > > The atomic write unit min and max is limited by the guaranteed extent
> > > alignment for the inode.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_iops.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
> > >   fs/xfs/xfs_iops.h |  4 ++++
> > >   2 files changed, 55 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index 1c1e6171209d..5bff80748223 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -546,6 +546,46 @@ xfs_stat_blksize(
> > >   	return PAGE_SIZE;
> > >   }
> > > +void xfs_ip_atomic_write_attr(struct xfs_inode *ip,
> > > +			xfs_filblks_t *unit_min_fsb,
> > > +			xfs_filblks_t *unit_max_fsb)
> > 
> > Formatting.
> 
> Change args to 1x tab indent, right?
> 
> > 
> > Also, we don't use variable name shorthand for function names -
> > xfs_get_atomic_write_hint(ip) to match xfs_get_extsz_hint(ip)
> > would be appropriate, right?
> 
> Changing the name format would be ok. However we are not returning a hint,
> but rather the inode atomic write unit min and max values in FS blocks.
> Anyway, I'll look to rework the name.
> 
> > 
> > 
> > 
> > > +{
> > > +	xfs_extlen_t		extsz_hint = xfs_get_extsz_hint(ip);
> > > +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> > > +	struct block_device	*bdev = target->bt_bdev;
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +	xfs_filblks_t		atomic_write_unit_min,
> > > +				atomic_write_unit_max,
> > > +				align;
> > > +
> > > +	atomic_write_unit_min = XFS_B_TO_FSB(mp,
> > > +		queue_atomic_write_unit_min_bytes(bdev->bd_queue));
> > > +	atomic_write_unit_max = XFS_B_TO_FSB(mp,
> > > +		queue_atomic_write_unit_max_bytes(bdev->bd_queue));
> > 
> > These should be set in the buftarg at mount time, like we do with
> > sector size masks. Then we don't need to convert them to fsbs on
> > every single lookup.
> 
> ok, fine. However I do still have a doubt on whether these values should be
> changeable - please see (small) comment about atomic_write_max_sectors in
> patch 7/21

No, this /does/ have to be looked up every time, because the geometry of
the device can change underneath the fs without us knowing about it.  If
someone snapshots an LV with different (or no) atomic write abilities
then we'll be doing the wrong checks.

And yes, it's true that this is a benign problem because we don't lock
anything in the bdev here and the block device driver will eventually
have to catch that anyway.

> > 
> > > +	/* for RT, unset extsize gives hint of 1 */
> > > +	/* for !RT, unset extsize gives hint of 0 */
> > > +	if (extsz_hint && (XFS_IS_REALTIME_INODE(ip) ||
> > > +	    (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)))
> > 
> > Logic is non-obvious. The compound is (rt || force), not
> > (extsz && rt), so it took me a while to actually realise I read this
> > incorrectly.
> > 
> > 	if (extsz_hint &&
> > 	    (XFS_IS_REALTIME_INODE(ip) ||
> > 	     (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN))) {
> > 
> > > +		align = extsz_hint;
> > > +	else
> > > +		align = 1;
> > 
> > And now the logic looks wrong to me. We don't want to use extsz hint
> > for RT inodes if force align is not set, this will always use it
> > regardless of the fact it has nothing to do with force alignment.
> 
> extsz_hint comes from xfs_get_extsz_hint(), which gives us the SB extsize
> for the RT inode and this alignment is guaranteed, no?

One can also set an extent size hint on realtime files that is a
multiple of the realtime extent size.  IOWs, I can decide that space on
the rt volume should be given out in 32k chunks, and then later decide
that a specific rt file should actually try for 64k chunks.

> > 
> > Indeed, if XFS_DIFLAG2_FORCEALIGN is not set, then shouldn't this
> > always return min/max = 0 because atomic alignments are not in us on
> > this inode?
> 
> As above, for RT I thought that extsize alignment was guaranteed and we
> don't need to bother with XFS_DIFLAG2_FORCEALIGN there.
> 
> > 
> > i.e. the first thing this code should do is:
> > 
> > 	*unit_min_fsb = 0;
> > 	*unit_max_fsb = 0;
> > 	if (!(ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN))
> > 		return;
> > 
> > Then we can check device support:
> > 
> > 	if (!buftarg->bt_atomic_write_max)
> > 		return;
> > 
> > Then we can check for extent size hints. If that's not set:
> > 
> > 	align = xfs_get_extsz_hint(ip);
> > 	if (align <= 1) {
> > 		unit_min_fsb = 1;
> > 		unit_max_fsb = 1;
> > 		return;
> > 	}
> > 
> > And finally, if there is an extent size hint, we can return that.
> > 
> > > +	if (atomic_write_unit_max == 0) {
> > > +		*unit_min_fsb = 0;
> > > +		*unit_max_fsb = 0;
> > > +	} else if (atomic_write_unit_min == 0) {
> > > +		*unit_min_fsb = 1;
> > > +		*unit_max_fsb = min_t(xfs_filblks_t, atomic_write_unit_max,
> > > +					align);
> > 
> > Why is it valid for a device to have a zero minimum size?
> 
> It's not valid. Local variables atomic_write_unit_max and
> atomic_write_unit_min unit here is FS blocks - maybe I should change names.

Yes, please, the variable names throughout are long enough to make for
ugly code.

	/* "awu" = atomic write unit */
	xfs_filblks_t	awu_min_fsb, align;
	u64		awu_min_bytes;

	awu_min_bytes = queue_atomic_write_unit_min_bytes(bdev->bd_queue);
	if (!awu_min_bytes) {
		/* Not supported at all. */
		*unit_min_fsb = 0;
		return;
	}

	awu_min_fsb = XFS_B_TO_FSBT(mp, awu_min_bytes);
	if (awu_min_fsb < 1) {
		/* Don't allow smaller than fsb atomic writes */
		*unit_min_fsb = 1;
		return;
	}

	*unit_min_fsb = min(awu_min_fsb, align);

--D

> The idea is that for simplicity we won't support atomic writes for XFS of
> size less than 1x FS block initially. So if the bdev has - for example -
> queue_atomic_write_unit_min_bytes() == 2K and
> queue_atomic_write_unit_max_bytes() == 64K, then (ignoring alignment) we say
> that unit_min_fsb = 1 and unit_max_fsb = 16 (for 4K FS blocks).
> 
> > If it can
> > set a maximum, it should -always- set a minimum size as logical
> > sector size is a valid lower bound, yes?
> > 
> > > +	} else {
> > > +		*unit_min_fsb = min_t(xfs_filblks_t, atomic_write_unit_min,
> > > +					align);
> > > +		*unit_max_fsb = min_t(xfs_filblks_t, atomic_write_unit_max,
> > > +					align);
> > > +	}
> > 
> > Nothing here guarantees the power-of-2 sizes that the RWF_ATOMIC
> > user interface requires....
> 
> atomic_write_unit_min and atomic_write_unit_max will be powers-of-2 (or 0).
> 
> But, you are right, we don't check align is a power-of-2 - that can be
> added.
> 
> > 
> > It also doesn't check that the extent size hint is aligned with
> > atomic write units.
> 
> If we add a check for align being a power-of-2 and atomic_write_unit_min and
> atomic_write_unit_max are already powers-of-2, then this can be relied on,
> right?
> 
> > 
> > It also doesn't check either against stripe unit alignment....
> 
> As mentioned in earlier response, this could be enforced.
> 
> > 
> > > +}
> > > +
> > >   STATIC int
> > >   xfs_vn_getattr(
> > >   	struct mnt_idmap	*idmap,
> > > @@ -614,6 +654,17 @@ xfs_vn_getattr(
> > >   			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> > >   			stat->dio_offset_align = bdev_logical_block_size(bdev);
> > >   		}
> > > +		if (request_mask & STATX_WRITE_ATOMIC) {
> > > +			xfs_filblks_t unit_min_fsb, unit_max_fsb;
> > > +
> > > +			xfs_ip_atomic_write_attr(ip, &unit_min_fsb,
> > > +				&unit_max_fsb);
> > > +			stat->atomic_write_unit_min = XFS_FSB_TO_B(mp, unit_min_fsb);
> > > +			stat->atomic_write_unit_max = XFS_FSB_TO_B(mp, unit_max_fsb);
> > 
> > That's just nasty. We pull byte units from the bdev, convert them to
> > fsb to round them, then convert them back to byte counts. We should
> > be doing all the work in one set of units....
> 
> ok, agreed. bytes is probably best.
> 
> > 
> > > +			stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
> > > +			stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
> > > +			stat->result_mask |= STATX_WRITE_ATOMIC;
> > 
> > If the min/max are zero, then atomic writes are not supported on
> > this inode, right? Why would we set any of the attributes or result
> > mask to say it is supported on this file?
> 
> ok, we won't set STATX_ATTR_WRITE_ATOMIC for min/max are zero
> 
> Thanks,
> John
