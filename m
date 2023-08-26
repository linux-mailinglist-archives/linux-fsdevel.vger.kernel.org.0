Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2D47892AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 02:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjHZASD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 20:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHZARp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDEB1FCB;
        Fri, 25 Aug 2023 17:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1515362CB6;
        Sat, 26 Aug 2023 00:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E25C433C7;
        Sat, 26 Aug 2023 00:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693009061;
        bh=AGu6wBkOhW95OeHYmNrxVETZfxKFgnDPANf2qdyOAi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCkOxjgUaPVrZ07WYtpRP33fLpD1EJAz2YMqYa4BpfUhCY62wuLrU4TOcIHirs521
         486ZgyMIcNOtt8ufFfhNU5hz+WE6DXgV0HOYFsFbG6qSFeqTJdYwmcCH6zoQrXaNUW
         a4nxA7C2RCMRLa6gZbz2cxGuv7/gPlOEFEar58GOKcAk9VyjzxAzW3fQekaCQq/x0I
         tXFm2oZNZrErmp0Tk5iv067IWpcqfV736BXp2F9A1fkD/FbmNEQaG59rCUbZfeBDUq
         CBbJtRKaDPUffCQ8hS1lbD8hBim2kywC5Z5MPF9MnVKGHIDx6HEaaQPcKmsmyqsLkn
         o/GtxYcSwC91g==
Date:   Fri, 25 Aug 2023 17:17:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, mcgrof@kernel.org
Subject: Re: [PATCH v13] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind
Message-ID: <20230826001740.GC17895@frogsfrogsfrogs>
References: <20230629081651.253626-3-ruansy.fnst@fujitsu.com>
 <20230823081706.2970430-1-ruansy.fnst@fujitsu.com>
 <20230823233601.GH11263@frogsfrogsfrogs>
 <999e83ca-df65-4a43-9d32-ff13a252c2d7@fujitsu.com>
 <20230824235709.GA17895@frogsfrogsfrogs>
 <8112ba47-9105-47b4-b070-72b44a7de4af@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8112ba47-9105-47b4-b070-72b44a7de4af@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:52:35AM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2023/8/25 7:57, Darrick J. Wong 写道:
> > On Thu, Aug 24, 2023 at 05:41:50PM +0800, Shiyang Ruan wrote:
> > > 
> > > 
> > > 在 2023/8/24 7:36, Darrick J. Wong 写道:
> > > > On Wed, Aug 23, 2023 at 04:17:06PM +0800, Shiyang Ruan wrote:
> > > > > ====
> > > > > Changes since v12:
> > > > >    1. correct flag name in subject (MF_MEM_REMOVE => MF_MEM_PRE_REMOVE)
> > > > >    2. complete the behavior when fs has already frozen by kernel call
> > > > >         NOTICE: Instead of "call notify_failure() again w/o PRE_REMOVE",
> > > > >                 I tried this proposal[0].
> > > > >    3. call xfs_dax_notify_failure_freeze() and _thaw() in same function
> > > > >    4. rebase on: xfs/xfs-linux.git vfs-for-next
> > > > > ====
> > > > > 
> > > > > Now, if we suddenly remove a PMEM device(by calling unbind) which
> > > > > contains FSDAX while programs are still accessing data in this device,
> > > > > e.g.:
> > > > > ```
> > > > >    $FSSTRESS_PROG -d $SCRATCH_MNT -n 99999 -p 4 &
> > > > >    # $FSX_PROG -N 1000000 -o 8192 -l 500000 $SCRATCH_MNT/t001 &
> > > > >    echo "pfn1.1" > /sys/bus/nd/drivers/nd_pmem/unbind
> > > > > ```
> > > > > it could come into an unacceptable state:
> > > > >     1. device has gone but mount point still exists, and umount will fail
> > > > >          with "target is busy"
> > > > >     2. programs will hang and cannot be killed
> > > > >     3. may crash with NULL pointer dereference
> > > > > 
> > > > > To fix this, we introduce a MF_MEM_PRE_REMOVE flag to let it know that we
> > > > > are going to remove the whole device, and make sure all related processes
> > > > > could be notified so that they could end up gracefully.
> > > > > 
> > > > > This patch is inspired by Dan's "mm, dax, pmem: Introduce
> > > > > dev_pagemap_failure()"[1].  With the help of dax_holder and
> > > > > ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> > > > > on it to unmap all files in use, and notify processes who are using
> > > > > those files.
> > > > > 
> > > > > Call trace:
> > > > > trigger unbind
> > > > >    -> unbind_store()
> > > > >     -> ... (skip)
> > > > >      -> devres_release_all()
> > > > >       -> kill_dax()
> > > > >        -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
> > > > >         -> xfs_dax_notify_failure()
> > > > >         `-> freeze_super()             // freeze (kernel call)
> > > > >         `-> do xfs rmap
> > > > >         ` -> mf_dax_kill_procs()
> > > > >         `  -> collect_procs_fsdax()    // all associated processes
> > > > >         `  -> unmap_and_kill()
> > > > >         ` -> invalidate_inode_pages2_range() // drop file's cache
> > > > >         `-> thaw_super()               // thaw (both kernel & user call)
> > > > > 
> > > > > Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> > > > > event.  Use the exclusive freeze/thaw[2] to lock the filesystem to prevent
> > > > > new dax mapping from being created.  Do not shutdown filesystem directly
> > > > > if configuration is not supported, or if failure range includes metadata
> > > > > area.  Make sure all files and processes(not only the current progress)
> > > > > are handled correctly.  Also drop the cache of associated files before
> > > > > pmem is removed.
> > > > > 
> > > > > [0]: https://lore.kernel.org/linux-xfs/25cf6700-4db0-a346-632c-ec9fc291793a@fujitsu.com/
> > > > > [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > > > [2]: https://lore.kernel.org/linux-xfs/169116275623.3187159.16862410128731457358.stg-ugh@frogsfrogsfrogs/
> > > > > 
> > > > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > > > ---
> > > > >    drivers/dax/super.c         |  3 +-
> > > > >    fs/xfs/xfs_notify_failure.c | 99 ++++++++++++++++++++++++++++++++++---
> > > > >    include/linux/mm.h          |  1 +
> > > > >    mm/memory-failure.c         | 17 +++++--
> > > > >    4 files changed, 109 insertions(+), 11 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > > > > index c4c4728a36e4..2e1a35e82fce 100644
> > > > > --- a/drivers/dax/super.c
> > > > > +++ b/drivers/dax/super.c
> > > > > @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
> > > > >    		return;
> > > > >    	if (dax_dev->holder_data != NULL)
> > > > > -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> > > > > +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
> > > > > +				MF_MEM_PRE_REMOVE);
> > > > >    	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> > > > >    	synchronize_srcu(&dax_srcu);
> > > > > diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> > > > > index 4a9bbd3fe120..6496c32a9172 100644
> > > > > --- a/fs/xfs/xfs_notify_failure.c
> > > > > +++ b/fs/xfs/xfs_notify_failure.c
> > > > > @@ -22,6 +22,7 @@
> > > > >    #include <linux/mm.h>
> > > > >    #include <linux/dax.h>
> > > > > +#include <linux/fs.h>
> > > > >    struct xfs_failure_info {
> > > > >    	xfs_agblock_t		startblock;
> > > > > @@ -73,10 +74,16 @@ xfs_dax_failure_fn(
> > > > >    	struct xfs_mount		*mp = cur->bc_mp;
> > > > >    	struct xfs_inode		*ip;
> > > > >    	struct xfs_failure_info		*notify = data;
> > > > > +	struct address_space		*mapping;
> > > > > +	pgoff_t				pgoff;
> > > > > +	unsigned long			pgcnt;
> > > > >    	int				error = 0;
> > > > >    	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> > > > >    	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> > > > > +		/* Continue the query because this isn't a failure. */
> > > > > +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> > > > > +			return 0;
> > > > >    		notify->want_shutdown = true;
> > > > >    		return 0;
> > > > >    	}
> > > > > @@ -92,14 +99,60 @@ xfs_dax_failure_fn(
> > > > >    		return 0;
> > > > >    	}
> > > > > -	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
> > > > > -				  xfs_failure_pgoff(mp, rec, notify),
> > > > > -				  xfs_failure_pgcnt(mp, rec, notify),
> > > > > -				  notify->mf_flags);
> > > > > +	mapping = VFS_I(ip)->i_mapping;
> > > > > +	pgoff = xfs_failure_pgoff(mp, rec, notify);
> > > > > +	pgcnt = xfs_failure_pgcnt(mp, rec, notify);
> > > > > +
> > > > > +	/* Continue the rmap query if the inode isn't a dax file. */
> > > > > +	if (dax_mapping(mapping))
> > > > > +		error = mf_dax_kill_procs(mapping, pgoff, pgcnt,
> > > > > +					  notify->mf_flags);
> > > > > +
> > > > > +	/* Invalidate the cache in dax pages. */
> > > > > +	if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> > > > > +		invalidate_inode_pages2_range(mapping, pgoff,
> > > > > +					      pgoff + pgcnt - 1);
> > > > > +
> > > > >    	xfs_irele(ip);
> > > > >    	return error;
> > > > >    }
> > > > > +static int
> > > > > +xfs_dax_notify_failure_freeze(
> > > > > +	struct xfs_mount	*mp)
> > > > > +{
> > > > > +	struct super_block	*sb = mp->m_super;
> > > > > +	int			error;
> > > > > +
> > > > > +	error = freeze_super(sb, FREEZE_HOLDER_KERNEL);
> > > > > +	if (error)
> > > > > +		xfs_emerg(mp, "already frozen by kernel, err=%d", error);
> > > > > +
> > > > > +	return error;
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +xfs_dax_notify_failure_thaw(
> > > > > +	struct xfs_mount	*mp,
> > > > > +	bool			kernel_frozen)
> > > > > +{
> > > > > +	struct super_block	*sb = mp->m_super;
> > > > > +	int			error;
> > > > > +
> > > > > +	if (!kernel_frozen) {
> > > > > +		error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
> > > > > +		if (error)
> > > > > +			xfs_emerg(mp, "still frozen after notify failure, err=%d",
> > > > > +				error);
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Also thaw userspace call anyway because the device is about to be
> > > > > +	 * removed immediately.
> > > > 
> > > > Does a userspace freeze inhibit or otherwise break device removal?
> > > 
> > > It doesn't.  Device can be removed.  But after that, the mount point still
> > > exists, and `umount /mnt/scratch` fails with "target is busy." `xfs_freeze
> > > -u /mnt/scratch` cannot work too.
> > 
> > Yes, that's true, but that's long been the case for removing block
> > devices.  Should block device removal (since we now have hooks for
> > that!) also be breaking freezes?
> 
> I think so.  But it may need more time to accomplish.  Shall we leave it for
> later optimization?

Yeah, I think patching the block layer is a separate patch.

> > 
> > > So, I think thaw_super() anyway here is needed.
> > > 
> > > 
> > > > 
> > > > > +	 */
> > > > > +	thaw_super(sb, FREEZE_HOLDER_USERSPACE);
> > > > > +}
> > > > > +
> > > > >    static int
> > > > >    xfs_dax_notify_ddev_failure(
> > > > >    	struct xfs_mount	*mp,
> > > > > @@ -112,15 +165,29 @@ xfs_dax_notify_ddev_failure(
> > > > >    	struct xfs_btree_cur	*cur = NULL;
> > > > >    	struct xfs_buf		*agf_bp = NULL;
> > > > >    	int			error = 0;
> > > > > +	bool			kernel_frozen = false;
> > > > >    	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
> > > > >    	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> > > > >    	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp,
> > > > >    							     daddr + bblen - 1);
> > > > >    	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
> > > > > +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> > > > > +		xfs_info(mp, "Device is about to be removed!");
> > > > > +		/* Freeze fs to prevent new mappings from being created. */
> > > > > +		error = xfs_dax_notify_failure_freeze(mp);
> > > > > +		if (error) {
> > > > > +			/* Keep going on if filesystem is frozen by kernel. */
> > > > > +			if (error == -EBUSY)
> > > > > +				kernel_frozen = true;
> > > > 
> > > > EBUSY means that xfs_dax_notify_failure_freeze did /not/ succeed in
> > > > kernel-freezing the fs.  Someone else did, and they're expecting that
> > > > thaw_super will undo that.
> > > > 
> > > > 	switch (error) {
> > > > 	case -EBUSY:
> > > > 		/* someone else froze the fs, keep going */
> > > > 		break;
> > > > 	case 0:
> > > > 		/* we froze the fs */
> > > > 		kernel_frozen = true;
> > > > 		break;
> > > > 	default:
> > > > 		/* something else broke, should we continue anyway? */
> > > > 		return error;
> > > > 	}
> > > > 
> > > > TBH I wonder why all that isn't just:
> > > > 
> > > > 	kernel_frozen = xfs_dax_notify_failure_freeze(mp) == 0;
> > > > 
> > > > Since we'd want to keep going even if (say) the pmem was already
> > > > starting to fail and the freeze actually failed due to EIO, right?
> > > 
> > > Yes.  So we can say it is a *try* to _freeze() here.  No matter what its
> > > result is, we continue.
> > > 
> > > Then I think the `kernel_frozen` becomes useless as well.  Because we should
> > > try to call both _thaw(KERNEL_CALL) and _thaw(USER_CALL) to make sure umount
> > > can work after device is gone.
> > 
> > I disagree -- unlike the mess that is userspace freezing, kernel code
> > that obtained a kernel freeze will get very confused and potentially do
> > Seriously Bad Things if the kernel freeze is yanked out from under them.
> > Kernel code is not supposed to release things that they did not
> > themselves obtain.
> > 
> > That might not ultimately matter for the narrow case of the device going
> > away, but the two other usecases (online fsck and suspend) will
> > malfunction if you drop a kernel freeze that they obtained.
> 
> Could online fsck and suspend keep working even after
> `xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);` being called?

It's likely to go down with the filesystem, but the point of the kernel
freeze is that the freeze should be brief and undone by the same
function on its way out.  Hence PREREMOVE shouldn't be releasing
something that was obtained by another (running) thread, just like any
other resource.

> > 
> > I don't mind if PREREMOVE can't get a freeze and keeps going with the
> > invalidations anyway.  We did our best, and when the pmem goes away we
> > can just kill -9 down the processes.
> 
> Ok, I agree.
> 
> Then, the last thing I want to be confirmed:
> On my host, if the freeze state wasn't _thaw() after device gone, the
> processes will keep on waiting and cannot be killed by `kill -9` manually.
> Is there another way to make the processes killed?

No, I don't think there is.  FWIW I'm ok with you moving on to the
invalidation part if something else has frozen the fs; and I'm also ok
with the unconditional thaw_super(sb, FREEZE_HOLDER_USERSPACE).

--D

> 
> 
> --
> Thanks,
> Ruan.
> 
> > 
> > --D
> > 
> > > Then, I think it's better to change them:
> > >    `static int xfs_dax_notify_failure_freeze()`,
> > >    `static void xfs_dax_notify_failure_thaw()`
> > > to
> > >    `static void xfs_dax_notify_failure_try_freeze()`,
> > >    `static void xfs_dax_notify_failure_try_thaw()`.
> > > 
> > > 
> > > --
> > > Thanks,
> > > Ruan.
> > > 
> > > > 
> > > > --D
> > > > 
> > > > > +			else
> > > > > +				return error;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > >    	error = xfs_trans_alloc_empty(mp, &tp);
> > > > >    	if (error)
> > > > > -		return error;
> > > > > +		goto out;
> > > > >    	for (; agno <= end_agno; agno++) {
> > > > >    		struct xfs_rmap_irec	ri_low = { };
> > > > > @@ -165,11 +232,23 @@ xfs_dax_notify_ddev_failure(
> > > > >    	}
> > > > >    	xfs_trans_cancel(tp);
> > > > > +
> > > > > +	/*
> > > > > +	 * Determine how to shutdown the filesystem according to the
> > > > > +	 * error code and flags.
> > > > > +	 */
> > > > >    	if (error || notify.want_shutdown) {
> > > > >    		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> > > > >    		if (!error)
> > > > >    			error = -EFSCORRUPTED;
> > > > > -	}
> > > > > +	} else if (mf_flags & MF_MEM_PRE_REMOVE)
> > > > > +		xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
> > > > > +
> > > > > +out:
> > > > > +	/* Thaw the fs if it is frozen before. */
> > > > > +	if (mf_flags & MF_MEM_PRE_REMOVE)
> > > > > +		xfs_dax_notify_failure_thaw(mp, kernel_frozen);
> > > > > +
> > > > >    	return error;
> > > > >    }
> > > > > @@ -197,6 +276,8 @@ xfs_dax_notify_failure(
> > > > >    	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
> > > > >    	    mp->m_logdev_targp != mp->m_ddev_targp) {
> > > > > +		if (mf_flags & MF_MEM_PRE_REMOVE)
> > > > > +			return 0;
> > > > >    		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
> > > > >    		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> > > > >    		return -EFSCORRUPTED;
> > > > > @@ -210,6 +291,12 @@ xfs_dax_notify_failure(
> > > > >    	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
> > > > >    	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
> > > > > +	/* Notify failure on the whole device. */
> > > > > +	if (offset == 0 && len == U64_MAX) {
> > > > > +		offset = ddev_start;
> > > > > +		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
> > > > > +	}
> > > > > +
> > > > >    	/* Ignore the range out of filesystem area */
> > > > >    	if (offset + len - 1 < ddev_start)
> > > > >    		return -ENXIO;
> > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > index 799836e84840..944a1165a321 100644
> > > > > --- a/include/linux/mm.h
> > > > > +++ b/include/linux/mm.h
> > > > > @@ -3577,6 +3577,7 @@ enum mf_flags {
> > > > >    	MF_UNPOISON = 1 << 4,
> > > > >    	MF_SW_SIMULATED = 1 << 5,
> > > > >    	MF_NO_RETRY = 1 << 6,
> > > > > +	MF_MEM_PRE_REMOVE = 1 << 7,
> > > > >    };
> > > > >    int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> > > > >    		      unsigned long count, int mf_flags);
> > > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > > index dc5ff7dd4e50..92f18c9e0aaf 100644
> > > > > --- a/mm/memory-failure.c
> > > > > +++ b/mm/memory-failure.c
> > > > > @@ -688,7 +688,7 @@ static void add_to_kill_fsdax(struct task_struct *tsk, struct page *p,
> > > > >     */
> > > > >    static void collect_procs_fsdax(struct page *page,
> > > > >    		struct address_space *mapping, pgoff_t pgoff,
> > > > > -		struct list_head *to_kill)
> > > > > +		struct list_head *to_kill, bool pre_remove)
> > > > >    {
> > > > >    	struct vm_area_struct *vma;
> > > > >    	struct task_struct *tsk;
> > > > > @@ -696,8 +696,15 @@ static void collect_procs_fsdax(struct page *page,
> > > > >    	i_mmap_lock_read(mapping);
> > > > >    	read_lock(&tasklist_lock);
> > > > >    	for_each_process(tsk) {
> > > > > -		struct task_struct *t = task_early_kill(tsk, true);
> > > > > +		struct task_struct *t = tsk;
> > > > > +		/*
> > > > > +		 * Search for all tasks while MF_MEM_PRE_REMOVE is set, because
> > > > > +		 * the current may not be the one accessing the fsdax page.
> > > > > +		 * Otherwise, search for the current task.
> > > > > +		 */
> > > > > +		if (!pre_remove)
> > > > > +			t = task_early_kill(tsk, true);
> > > > >    		if (!t)
> > > > >    			continue;
> > > > >    		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> > > > > @@ -1793,6 +1800,7 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> > > > >    	dax_entry_t cookie;
> > > > >    	struct page *page;
> > > > >    	size_t end = index + count;
> > > > > +	bool pre_remove = mf_flags & MF_MEM_PRE_REMOVE;
> > > > >    	mf_flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> > > > > @@ -1804,9 +1812,10 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
> > > > >    		if (!page)
> > > > >    			goto unlock;
> > > > > -		SetPageHWPoison(page);
> > > > > +		if (!pre_remove)
> > > > > +			SetPageHWPoison(page);
> > > > > -		collect_procs_fsdax(page, mapping, index, &to_kill);
> > > > > +		collect_procs_fsdax(page, mapping, index, &to_kill, pre_remove);
> > > > >    		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
> > > > >    				index, mf_flags);
> > > > >    unlock:
> > > > > -- 
> > > > > 2.41.0
> > > > > 
