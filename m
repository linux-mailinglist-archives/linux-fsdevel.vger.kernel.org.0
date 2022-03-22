Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B44E3F33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 14:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiCVNNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 09:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiCVNNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:13:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EA383B0E;
        Tue, 22 Mar 2022 06:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B43AB81CEE;
        Tue, 22 Mar 2022 13:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF08DC340EC;
        Tue, 22 Mar 2022 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647954690;
        bh=TpBXM727e3ZHMIyuIdvw5htaVDQjvYk5u5ce6KzSoYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMKqubdyFgKxMcTinsoqliEFOQaupYQeE3VTp5BX1VENB6EVjPIZTXrNTkJQGf1yk
         sVt6AKT7v5FzvvwcEpYJ29C3iifMv0x0rc4vTFX4DnjNHBF+4rXv29NiOtUeRVLvFS
         ZnkOHRtSoZlU3JTyqXLIvwBDBkr75j2OPZ2nZ2zVHGSjttV5w1AwmjZIkJ1ZVKjmXV
         GOdNGe3EuSFRMk69F6qH8kvtOvUVsLLpoMOtJljNQihRH1ynMWd4YtQ5+J1BzZLwKc
         a8aZEf9FY7u8wPRmF/nngIgSb4Nsga1nA/dTBG/vlBeMc55t3oAA5V+Pp6uahBkMy0
         Rlab65XFQufPw==
Date:   Tue, 22 Mar 2022 13:11:27 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v2 2/4] btrfs: mark device addition as mnt_want_write_file
Message-ID: <YjnK/yHH4TdEzKmi@debian9.Home>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <4b8a439c276e774ab2402cbd5395061ea0bd3cde.1647436353.git.naohiro.aota@wdc.com>
 <YjILAo2ueZsnhza/@debian9.Home>
 <20220317073628.slh4iyexpen7lmjh@naota-xeon>
 <YjMSaLIhKNcKUuHM@debian9.Home>
 <20220322043056.3sgb75menaja4xex@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322043056.3sgb75menaja4xex@naota-xeon>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 04:30:56AM +0000, Naohiro Aota wrote:
> On Thu, Mar 17, 2022 at 10:50:16AM +0000, Filipe Manana wrote:
> > On Thu, Mar 17, 2022 at 07:36:29AM +0000, Naohiro Aota wrote:
> > > On Wed, Mar 16, 2022 at 04:06:26PM +0000, Filipe Manana wrote:
> > > > On Wed, Mar 16, 2022 at 10:22:38PM +0900, Naohiro Aota wrote:
> > > > > btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which incurs
> > > > > file-system internal writing. That writing can cause a deadlock with
> > > > > FS freezing like as described in like as described in commit
> > > > > 26559780b953 ("btrfs: zoned: mark relocation as writing").
> > > > > 
> > > > > Mark the device addition as mnt_want_write_file. This is also consistent
> > > > > with the removing device ioctl counterpart.
> > > > > 
> > > > > Cc: stable@vger.kernel.org # 4.9+
> > > > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > > > ---
> > > > >  fs/btrfs/ioctl.c | 11 +++++++++--
> > > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > > index 60c907b14547..a6982a1fde65 100644
> > > > > --- a/fs/btrfs/ioctl.c
> > > > > +++ b/fs/btrfs/ioctl.c
> > > > > @@ -3474,8 +3474,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > -static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
> > > > > +static long btrfs_ioctl_add_dev(struct file *file, void __user *arg)
> > > > >  {
> > > > > +	struct inode *inode = file_inode(file);
> > > > > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > > > >  	struct btrfs_ioctl_vol_args *vol_args;
> > > > >  	bool restore_op = false;
> > > > >  	int ret;
> > > > > @@ -3488,6 +3490,10 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > >  
> > > > > +	ret = mnt_want_write_file(file);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > 
> > > > So, this now breaks all test cases that exercise device seeding, and I clearly
> > > > forgot about seeding when I asked about why not use mnt_want_write_file()
> > > > instead of a bare call to sb_start_write():
> > > 
> > > Ah, yes, I also confirmed they fail.
> > > 
> > > > 
> > > > $ ./check btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > > ><snip>
> > > > Ran: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > > > Failures: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > > > Failed 5 of 5 tests
> > > > 
> > > > So device seeding introduces a special case. If we mount a seeding
> > > > filesystem, it's RO, so the mnt_want_write_file() fails.
> > > 
> > > Yeah, so we are in a mixed state here. It's RO with a seeding
> > > device. Or, it must be RW otherwise (checked in
> > > btrfs_init_new_device()).
> > > 
> > > > Something like this deals with it and it makes the tests pass:
> > > > 
> > > ><snip>
> > > > 
> > > > We are also changing the semantics as we no longer allow for adding a device
> > > > to a RO filesystem. So the lack of a mnt_want_write_file() was intentional
> > > > to deal with the seeding filesystem case. But calling mnt_want_write_file()
> > > > if we are not seeding, changes the semantics - I'm not sure if anyone relies
> > > > on the ability to add a device to a fs mounted RO, I'm not seeing if it's an
> > > > useful use case.
> > > 
> > > Adding a device to RO FS anyway returns -EROFS from
> > > btrfs_init_new_device(). So, there is no change.
> > > 
> > > > So either we do that special casing like in that diff, or we always do the
> > > > sb_start_write() / sb_end_write() - in any case please add a comment explaining
> > > > why we do it like that, why we can't use mnt_want_write_file().
> > > 
> > > The conditional using of sb_start_write() or mnt_want_write_file()
> > > seems a bit dirty. And, I just thought, marking the FS "writing" when
> > > it's read-only also seems odd.
> > > 
> > > I'm now thinking we should have sb_start_write() around here where the
> > > FS is surely RW.
> > > 
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index 393fc7db99d3..50e02dc4e2b2 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -2731,6 +2731,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> > >  
> > >  	mutex_unlock(&fs_devices->device_list_mutex);
> > >  
> > > +	sb_start_write(fs_info->sb);
> > > +
> > >  	if (seeding_dev) {
> > >  		mutex_lock(&fs_info->chunk_mutex);
> > >  		ret = init_first_rw_device(trans);
> > > @@ -2786,6 +2788,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> > >  		ret = btrfs_commit_transaction(trans);
> > >  	}
> > >  
> > > +	sb_end_write(fs_info->sb);
> > > +
> > >  	/*
> > >  	 * Now that we have written a new super block to this device, check all
> > >  	 * other fs_devices list if device_path alienates any other scanned
> > > @@ -2801,6 +2805,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> > >  	return ret;
> > >  
> > >  error_sysfs:
> > > +	sb_end_write(fs_info->sb);
> > > +
> > >  	btrfs_sysfs_remove_device(device);
> > >  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> > >  	mutex_lock(&fs_info->chunk_mutex);
> > 
> > Why not just reduce the scope to surround the btrfs_relocate_sys_chunks() call?
> > It's simpler, and I don't see why all the other code needs to be surround by
> > sb_start_write() and sb_end_write().
> 
> Yep, it turned out my patch caused a lockdep issue. Because we call
> sb_start_intwrite in the transaction path, we can't call
> sb_start_write() while the transaction is committed. So, at least we
> need to narrow the region around btrfs_relocate_sys_chunks().

I don't understand. What do you mean with "while the transaction is committed"?

Do you mean having the following flow leads to a lockdep warning?

   sb_start_write()
   btrfs_[start|join]_transaction()
   btrfs_commit_transaction()
   sb_end_write()

If that's what you mean, than it's really odd, because we do that in many ioctls,
like the resize ioctl and snapshot creation for example:

  btrfs_ioctl_resize()
    mnt_want_write_file()
      -> calls sb_start_write()
    btrfs_start_transaction()
    btrfs_commit_transaction()
    mnt_end_write_file()
    mnt_drop_write_file()
      -> calls sb_end_write()

And it's been like that for many years, with no known lockdep complaints.

Also I don't see why surrounding only btrfs_relocate_sys_chunks() would make
lockdep happy. Because inside the relocation code we have several places that
start a transaction and then commit the transaction.

Can you be more explicit, perhaps show the warning/trace from lockdep?

> 
> > Actually, relocating system chunks does not create ordered extents - that only
> > happens for data block groups. So we could could get away with all this, and
> > have the relocation code do the assertion only if we are relocating a data
> > block group - so no need to touch anything in the device add path.
> 
> Hmm, that's true. And, such metadata update is protected with
> sb_start_intwrite()/sb_end_intwrite() in the transaction functions.
> 
> Maybe, we can just add sb_start_write_trylock() to
> relocate_file_extent_cluster() ?

Why not make it simple as I suggested? Drop this patch, and change the next
patch in the series to do the assertion like this:

  At btrfs_relocate_block_group() add:


    /*
     * Add some comment why we check this...
     */
    if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
        ASSERT(sb_write_started(fs_info->sb));

Wouldn't that work? Why not?

> 
> > Thanks.
> > 
> > > 
> > > > Thanks.
> > > > 
> > > > 
> > > > > +
> > > > >  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
> > > > >  		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
> > > > >  			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> > > > > @@ -3520,6 +3526,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
> > > > >  		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
> > > > >  	else
> > > > >  		btrfs_exclop_finish(fs_info);
> > > > > +	mnt_drop_write_file(file);
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > @@ -5443,7 +5450,7 @@ long btrfs_ioctl(struct file *file, unsigned int
> > > > >  	case BTRFS_IOC_RESIZE:
> > > > >  		return btrfs_ioctl_resize(file, argp);
> > > > >  	case BTRFS_IOC_ADD_DEV:
> > > > > -		return btrfs_ioctl_add_dev(fs_info, argp);
> > > > > +		return btrfs_ioctl_add_dev(file, argp);
> > > > >  	case BTRFS_IOC_RM_DEV:
> > > > >  		return btrfs_ioctl_rm_dev(file, argp);
> > > > >  	case BTRFS_IOC_RM_DEV_V2:
> > > > > -- 
> > > > > 2.35.1
> > > > > 
