Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61E4DC442
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 11:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiCQKvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 06:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiCQKvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:51:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41E117B882;
        Thu, 17 Mar 2022 03:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81207B81DA3;
        Thu, 17 Mar 2022 10:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0ADC340E9;
        Thu, 17 Mar 2022 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647514220;
        bh=YhM7/M9TLzNWHvTGsKDLxCjEutLgSOmyNzbWHxmjTCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ynz5/vpHmNKwY3Q7Z9GpRVRUxP63T/wnUOEH+sIpdsFwTsin+bMgpDx3UzPHLvU0U
         GZjjWeAEKXPgEv17wzen4qkQKXy5EEkTREvrwhm+DcBxeyPDaGPEqOXpcktDZ3oqP1
         Koh2R76BxNYZ8OnpnRAwe4C62HIArfvvisvKpiHVEUWnPa/V+ZIAPLQNnbMSzBDq5/
         fLu1jF4kOO47N8ekktTYIGgG4OGnpo+Wf5lhtlDGyH9KojzYtg3Uik+jrcFXBzgjAE
         htq6USY7KMvOGRNmFiEA61aVR7QNaX8cLvmeYN3aqmnM4B6oKXjI3GLERnUOo2XV8U
         GqzQm/tjfxAdw==
Date:   Thu, 17 Mar 2022 10:50:16 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v2 2/4] btrfs: mark device addition as mnt_want_write_file
Message-ID: <YjMSaLIhKNcKUuHM@debian9.Home>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
 <4b8a439c276e774ab2402cbd5395061ea0bd3cde.1647436353.git.naohiro.aota@wdc.com>
 <YjILAo2ueZsnhza/@debian9.Home>
 <20220317073628.slh4iyexpen7lmjh@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317073628.slh4iyexpen7lmjh@naota-xeon>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 07:36:29AM +0000, Naohiro Aota wrote:
> On Wed, Mar 16, 2022 at 04:06:26PM +0000, Filipe Manana wrote:
> > On Wed, Mar 16, 2022 at 10:22:38PM +0900, Naohiro Aota wrote:
> > > btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which incurs
> > > file-system internal writing. That writing can cause a deadlock with
> > > FS freezing like as described in like as described in commit
> > > 26559780b953 ("btrfs: zoned: mark relocation as writing").
> > > 
> > > Mark the device addition as mnt_want_write_file. This is also consistent
> > > with the removing device ioctl counterpart.
> > > 
> > > Cc: stable@vger.kernel.org # 4.9+
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  fs/btrfs/ioctl.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > index 60c907b14547..a6982a1fde65 100644
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -3474,8 +3474,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
> > >  	return ret;
> > >  }
> > >  
> > > -static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
> > > +static long btrfs_ioctl_add_dev(struct file *file, void __user *arg)
> > >  {
> > > +	struct inode *inode = file_inode(file);
> > > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > >  	struct btrfs_ioctl_vol_args *vol_args;
> > >  	bool restore_op = false;
> > >  	int ret;
> > > @@ -3488,6 +3490,10 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	ret = mnt_want_write_file(file);
> > > +	if (ret)
> > > +		return ret;
> > 
> > So, this now breaks all test cases that exercise device seeding, and I clearly
> > forgot about seeding when I asked about why not use mnt_want_write_file()
> > instead of a bare call to sb_start_write():
> 
> Ah, yes, I also confirmed they fail.
> 
> > 
> > $ ./check btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> ><snip>
> > Ran: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > Failures: btrfs/161 btrfs/162 btrfs/163 btrfs/164 btrfs/248
> > Failed 5 of 5 tests
> > 
> > So device seeding introduces a special case. If we mount a seeding
> > filesystem, it's RO, so the mnt_want_write_file() fails.
> 
> Yeah, so we are in a mixed state here. It's RO with a seeding
> device. Or, it must be RW otherwise (checked in
> btrfs_init_new_device()).
> 
> > Something like this deals with it and it makes the tests pass:
> > 
> ><snip>
> > 
> > We are also changing the semantics as we no longer allow for adding a device
> > to a RO filesystem. So the lack of a mnt_want_write_file() was intentional
> > to deal with the seeding filesystem case. But calling mnt_want_write_file()
> > if we are not seeding, changes the semantics - I'm not sure if anyone relies
> > on the ability to add a device to a fs mounted RO, I'm not seeing if it's an
> > useful use case.
> 
> Adding a device to RO FS anyway returns -EROFS from
> btrfs_init_new_device(). So, there is no change.
> 
> > So either we do that special casing like in that diff, or we always do the
> > sb_start_write() / sb_end_write() - in any case please add a comment explaining
> > why we do it like that, why we can't use mnt_want_write_file().
> 
> The conditional using of sb_start_write() or mnt_want_write_file()
> seems a bit dirty. And, I just thought, marking the FS "writing" when
> it's read-only also seems odd.
> 
> I'm now thinking we should have sb_start_write() around here where the
> FS is surely RW.
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 393fc7db99d3..50e02dc4e2b2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2731,6 +2731,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
> +	sb_start_write(fs_info->sb);
> +
>  	if (seeding_dev) {
>  		mutex_lock(&fs_info->chunk_mutex);
>  		ret = init_first_rw_device(trans);
> @@ -2786,6 +2788,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  		ret = btrfs_commit_transaction(trans);
>  	}
>  
> +	sb_end_write(fs_info->sb);
> +
>  	/*
>  	 * Now that we have written a new super block to this device, check all
>  	 * other fs_devices list if device_path alienates any other scanned
> @@ -2801,6 +2805,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	return ret;
>  
>  error_sysfs:
> +	sb_end_write(fs_info->sb);
> +
>  	btrfs_sysfs_remove_device(device);
>  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>  	mutex_lock(&fs_info->chunk_mutex);

Why not just reduce the scope to surround the btrfs_relocate_sys_chunks() call?
It's simpler, and I don't see why all the other code needs to be surround by
sb_start_write() and sb_end_write().

Actually, relocating system chunks does not create ordered extents - that only
happens for data block groups. So we could could get away with all this, and
have the relocation code do the assertion only if we are relocating a data
block group - so no need to touch anything in the device add path.

Thanks.

> 
> > Thanks.
> > 
> > 
> > > +
> > >  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
> > >  		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
> > >  			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> > > @@ -3520,6 +3526,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
> > >  		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
> > >  	else
> > >  		btrfs_exclop_finish(fs_info);
> > > +	mnt_drop_write_file(file);
> > >  	return ret;
> > >  }
> > >  
> > > @@ -5443,7 +5450,7 @@ long btrfs_ioctl(struct file *file, unsigned int
> > >  	case BTRFS_IOC_RESIZE:
> > >  		return btrfs_ioctl_resize(file, argp);
> > >  	case BTRFS_IOC_ADD_DEV:
> > > -		return btrfs_ioctl_add_dev(fs_info, argp);
> > > +		return btrfs_ioctl_add_dev(file, argp);
> > >  	case BTRFS_IOC_RM_DEV:
> > >  		return btrfs_ioctl_rm_dev(file, argp);
> > >  	case BTRFS_IOC_RM_DEV_V2:
> > > -- 
> > > 2.35.1
> > > 
