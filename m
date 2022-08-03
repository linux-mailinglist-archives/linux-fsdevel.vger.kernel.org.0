Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402E558868D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 06:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiHCEdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 00:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:33:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA735720D;
        Tue,  2 Aug 2022 21:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BED5CB819F3;
        Wed,  3 Aug 2022 04:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82576C433C1;
        Wed,  3 Aug 2022 04:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659501224;
        bh=id9I8D3e7agQ56Vv5SWmx4sZLvoGWkQXWA23gW96Ja4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbV/ufCihC66Kn35+ChJqEGIJijhyFQ57MIgEHSTCYdFEL3Q7k5TRsYP+qeP/2+nQ
         vpHbhiCpSv8aWFM2ifPeNaOOWjNiscqWUBZ08mBmDlMJYP3bOVnhBViugVS3zubaAh
         HlXI6NeLL9okc6pNZHbBGwTJtx3QJ0EjrnVlgXkhYN8OAqDG8aI1DZcWNk6RCWHBUk
         6YB4W+D/4CaBGX4PzWjujhCQjKqrg5OroD4Ts2eOkWiMxxP/LhLXMtSBVxrsqe+L6W
         DNI+pggUqxvAbDSttn0wO0C1OnHbniD79oPgJkXbuwXWYbwkmsvVuB6pNMWdmspBoI
         ddd+MFDqOLldw==
Date:   Tue, 2 Aug 2022 21:33:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: Re: [RFC PATCH v6] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <Yun6qIonQbeqVvso@magnolia>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
 <20220714103421.1988696-1-ruansy.fnst@fujitsu.com>
 <62d05eb8e663c_1643dc294fa@dwillia2-xfh.jf.intel.com.notmuch>
 <YtXbD4e8mLHqWSwL@magnolia>
 <62d5e515de3a_929192941e@dwillia2-xfh.jf.intel.com.notmuch>
 <ef6fbc40-db59-eca5-e3e1-19f5809ec357@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef6fbc40-db59-eca5-e3e1-19f5809ec357@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 03, 2022 at 02:43:20AM +0000, ruansy.fnst@fujitsu.com wrote:
> 
> 在 2022/7/19 6:56, Dan Williams 写道:
> > Darrick J. Wong wrote:
> >> On Thu, Jul 14, 2022 at 11:21:44AM -0700, Dan Williams wrote:
> >>> ruansy.fnst@fujitsu.com wrote:
> >>>> This patch is inspired by Dan's "mm, dax, pmem: Introduce
> >>>> dev_pagemap_failure()"[1].  With the help of dax_holder and
> >>>> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> >>>> (or mapped device) on it to unmap all files in use and notify processes
> >>>> who are using those files.
> >>>>
> >>>> Call trace:
> >>>> trigger unbind
> >>>>   -> unbind_store()
> >>>>    -> ... (skip)
> >>>>     -> devres_release_all()   # was pmem driver ->remove() in v1
> >>>>      -> kill_dax()
> >>>>       -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
> >>>>        -> xfs_dax_notify_failure()
> >>>>
> >>>> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> >>>> event.  So do not shutdown filesystem directly if something not
> >>>> supported, or if failure range includes metadata area.  Make sure all
> >>>> files and processes are handled correctly.
> >>>>
> >>>> ==
> >>>> Changes since v5:
> >>>>    1. Renamed MF_MEM_REMOVE to MF_MEM_PRE_REMOVE
> >>>>    2. hold s_umount before sync_filesystem()
> >>>>    3. move sync_filesystem() after SB_BORN check
> >>>>    4. Rebased on next-20220714
> >>>>
> >>>> Changes since v4:
> >>>>    1. sync_filesystem() at the beginning when MF_MEM_REMOVE
> >>>>    2. Rebased on next-20220706
> >>>>
> >>>> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> >>>>
> >>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> >>>> ---
> >>>>   drivers/dax/super.c         |  3 ++-
> >>>>   fs/xfs/xfs_notify_failure.c | 15 +++++++++++++++
> >>>>   include/linux/mm.h          |  1 +
> >>>>   3 files changed, 18 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> >>>> index 9b5e2a5eb0ae..cf9a64563fbe 100644
> >>>> --- a/drivers/dax/super.c
> >>>> +++ b/drivers/dax/super.c
> >>>> @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
> >>>>   		return;
> >>>>   
> >>>>   	if (dax_dev->holder_data != NULL)
> >>>> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> >>>> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
> >>>> +				MF_MEM_PRE_REMOVE);
> >>>>   
> >>>>   	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
> >>>>   	synchronize_srcu(&dax_srcu);
> >>>> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> >>>> index 69d9c83ea4b2..6da6747435eb 100644
> >>>> --- a/fs/xfs/xfs_notify_failure.c
> >>>> +++ b/fs/xfs/xfs_notify_failure.c
> >>>> @@ -76,6 +76,9 @@ xfs_dax_failure_fn(
> >>>>   
> >>>>   	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> >>>>   	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> >>>> +		/* Do not shutdown so early when device is to be removed */
> >>>> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> >>>> +			return 0;
> >>>>   		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> >>>>   		return -EFSCORRUPTED;
> >>>>   	}
> >>>> @@ -174,12 +177,22 @@ xfs_dax_notify_failure(
> >>>>   	struct xfs_mount	*mp = dax_holder(dax_dev);
> >>>>   	u64			ddev_start;
> >>>>   	u64			ddev_end;
> >>>> +	int			error;
> >>>>   
> >>>>   	if (!(mp->m_sb.sb_flags & SB_BORN)) {
> >>>>   		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
> >>>>   		return -EIO;
> >>>>   	}
> >>>>   
> >>>> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> >>>> +		xfs_info(mp, "device is about to be removed!");
> >>>> +		down_write(&mp->m_super->s_umount);
> >>>> +		error = sync_filesystem(mp->m_super);
> >>>> +		up_write(&mp->m_super->s_umount);
> >>>
> >>> Are all mappings invalidated after this point?
> >>
> >> No; all this step does is pushes dirty filesystem [meta]data to pmem
> >> before we lose DAXDEV_ALIVE...
> >>
> >>> The goal of the removal notification is to invalidate all DAX mappings
> >>> that are no pointing to pfns that do not exist anymore, so just syncing
> >>> does not seem like enough, and the shutdown is skipped above. What am I
> >>> missing?
> >>
> >> ...however, the shutdown above only applies to filesystem metadata.  In
> >> effect, we avoid the fs shutdown in MF_MEM_PRE_REMOVE mode, which
> >> enables the mf_dax_kill_procs calls to proceed against mapped file data.
> >> I have a nagging suspicion that in non-PREREMOVE mode, we can end up
> >> shutting down the filesytem on an xattr block and the 'return
> >> -EFSCORRUPTED' actually prevents us from reaching all the remaining file
> >> data mappings.
> >>
> >> IOWs, I think that clause above really ought to have returned zero so
> >> that we keep the filesystem up while we're tearing down mappings, and
> >> only call xfs_force_shutdown() after we've had a chance to let
> >> xfs_dax_notify_ddev_failure() tear down all the mappings.
> >>
> >> I missed that subtlety in the initial ~30 rounds of review, but I figure
> >> at this point let's just land it in 5.20 and clean up that quirk for
> >> -rc1.
> > 
> > Sure, this is a good baseline to incrementally improve.
> 
> Hi Dan, Darrick
> 
> Do I need to fix somewhere on this patch?  I'm not sure if it is looked good...

Eh, wait for me to send the xfs pull request and then I'll clean things
up and send you a patch. :)

--D

> 
> --
> Thanks,
> Ruan.
> 
> > 
> >>
> >>> Notice that kill_dev_dax() does unmap_mapping_range() after invalidating
> >>> the dax device and that ensures that all existing mappings are gone and
> >>> cannot be re-established. As far as I can see a process with an existing
> >>> dax mapping will still be able to use it after this runs, no?
> >>
> >> I'm not sure where in akpm's tree I find kill_dev_dax()?  I'm cribbing
> >> off of:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/fs/xfs/xfs_notify_failure.c?h=mm-stable
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/drivers/dax/bus.c?h=mm-stable#n381
> > 
> > Where the observation is that when device-dax is told that the device is
> > going away it invalidates all the active mappings to that single
> > character-device-inode. The hope being that in the fsdax case all the
> > dax-mapped filesystem inodes would experience the same irreversible
> > invalidation as the device is exiting.
