Return-Path: <linux-fsdevel+bounces-48417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D3BAAED0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 22:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30613A46DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DAB28EA66;
	Wed,  7 May 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL+UuEhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711623DE
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649742; cv=none; b=QIRnwF0/fDxBp8R+qUzjltVOoOel72iGBTeIpbOt+tS2mpW0TaI9vrLDzf8IO8c73juL1ytxfjzgckl50OU7I8KkVL2SHCRwOId1Ri8K8iKI+HN53gg2Iklct5i5t/uyHvIvIlXPMLEwT9AaD9auKXW50SYGtOgC4Gw6QkvXyBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649742; c=relaxed/simple;
	bh=E90TQCkKyMBMWWlJY1dsIQzsqbo7zISYo4FJWrAekP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXj76W9QtcbQtOT9UpeuURy2/RRNnuXgTQTqqM3h/vAbPaGlFYEF42OFNQwFLDlmb1j2KmPzO20p89ht7ZZZ/rWkfJ47ZSFIMcnpAv7b6PicjLQJXi+ZHnp/9pHM50nCTyiJW6oC35CSu+z/a5SnWTv/o2WOPztoCkfHvVOqtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL+UuEhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9025CC4CEE2;
	Wed,  7 May 2025 20:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746649741;
	bh=E90TQCkKyMBMWWlJY1dsIQzsqbo7zISYo4FJWrAekP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VL+UuEhfNFfad+5EOz9uElrrtfJHd1QV/gZMRB67p/swR7vCTujA6B3N66Xj+2EKF
	 YjRFZMspeo07NvwL4tXQUNyTvSkHlS4ONg4AbBsKNYATxpN8F6Onr7cyToZBdpFanF
	 sYxA0T47eCF3Irui2018WAE6OPQLkBIFS09YrHCcyLAY1iFReV1mVuU2Ex3QGsWc8m
	 DwKWUKbKJM00Q6HrIPkBeOziUgYqWBR7W5z9K+W/tn/zY0Nerkp3n2JN+ZZLwikRtu
	 RrsBEVinO7fa+PSuILhAjFqBSHS/EaxjzI+mDc8MAP8+gdJWGlzf+4DFvuH6VHjmaE
	 DfsU+wRPABk4w==
Date: Wed, 7 May 2025 20:28:59 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	chao@kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
Message-ID: <aBvCi9KplfQ_7Gsn@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <aBqq1fQd1YcMAJL6@google.com>
 <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
 <aBq2GrqV9hw5cTyJ@google.com>
 <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
 <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>
 <aBtyRFIrDU3IfQhV@google.com>
 <6528bdf7-3f8b-41c0-acfe-a293d68176a7@redhat.com>
 <aBu5CU7k0568RU6E@google.com>
 <e72e0693-6590-4c1e-8bb8-9d891e1bc5c0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72e0693-6590-4c1e-8bb8-9d891e1bc5c0@redhat.com>

On 05/07, Eric Sandeen wrote:
> On 5/7/25 2:48 PM, Jaegeuk Kim wrote:
> > On 05/07, Eric Sandeen wrote:
> >> On 5/7/25 9:46 AM, Jaegeuk Kim wrote:
> >>
> >>> I meant:
> >>>
> >>> # mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
> >>> # mount /dev/vdb mnt
> >>>
> >>> It's supposed to be successful, since extent_cache is enabled by default.
> >>
> >> I'm sorry, clearly I was too sleepy last night. This fixes it for me.
> >>
> >> We have to test the mask to see if the option was explisitly set (either
> >> extent_cache or noextent_cache) at mount time.
> >>
> >> If it was not specified at all, it will be set by the default f'n and
> >> remain in the sbi, and it will pass this consistency check.
> >>
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index d89b9ede221e..e178796ce9a7 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -1412,7 +1414,8 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
> >>  	}
> >>  
> >>  	if (f2fs_sb_has_device_alias(sbi) &&
> >> -			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
> >> +			(ctx->opt_mask & F2FS_MOUNT_READ_EXTENT_CACHE) &&
> >> +			 !ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
> >>  		f2fs_err(sbi, "device aliasing requires extent cache");
> >>  		return -EINVAL;
> >>  	}
> > 
> > I think that will cover the user-given options only, but we'd better check the
> > final options as well. Can we apply like this?
> 
> I'm sorry, I'm not sure I understand what situation this additional
> changes will cover...
> 
> It looks like this adds the f2fs_sanity_check_options() to the remount
> path to explicitly (re-)check a few things.
> 
> But as far as I can tell, at least for the extent cache, remount is handled
> properly already (with the hunk above):
> 
> # mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
> # mount /dev/vdb mnt
> # mount -o remount,noextent_cache mnt
> mount: /root/mnt: mount point not mounted or bad option.
>        dmesg(1) may have more information after failed mount system call.
> # dmesg | tail -n 1
> [60012.364941] F2FS-fs (vdb): device aliasing requires extent cache
> #
> 
> I haven't tested with i.e. blkzoned devices though, is there a testcase
> that fails for you?

I'm worrying about any missing case to check options enabled by default_options.
For example, in the case of device_aliasing, we rely on enabling extent_cache
by default_options, which was not caught by f2fs_check_opt_consistency.

I was thinking that we'd need a post sanity check.

> 
> Thanks,
> -Eric
> 
> > ---
> >  fs/f2fs/super.c | 50 ++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 33 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index d89b9ede221e..270a9bf9773d 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1412,6 +1412,7 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
> >  	}
> >  
> >  	if (f2fs_sb_has_device_alias(sbi) &&
> > +			(ctx->opt_mask & F2FS_MOUNT_READ_EXTENT_CACHE) &&
> >  			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
> >  		f2fs_err(sbi, "device aliasing requires extent cache");
> >  		return -EINVAL;
> > @@ -1657,6 +1658,29 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
> >  	f2fs_apply_quota_options(fc, sb);
> >  }
> >  
> > +static int f2fs_sanity_check_options(struct f2fs_sb_info *sbi)
> > +{
> > +	if (f2fs_sb_has_device_alias(sbi) &&
> > +	    !test_opt(sbi, READ_EXTENT_CACHE)) {
> > +		f2fs_err(sbi, "device aliasing requires extent cache");
> > +		return -EINVAL;
> > +	}
> > +#ifdef CONFIG_BLK_DEV_ZONED
> > +	if (f2fs_sb_has_blkzoned(sbi) &&
> > +	    sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> > +		f2fs_err(sbi,
> > +			"zoned: max open zones %u is too small, need at least %u open zones",
> > +				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
> > +		return -EINVAL;
> > +	}
> > +#endif
> > +	if (f2fs_lfs_mode(sbi) && !IS_F2FS_IPU_DISABLE(sbi)) {
> > +		f2fs_warn(sbi, "LFS is not compatible with IPU");
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static struct inode *f2fs_alloc_inode(struct super_block *sb)
> >  {
> >  	struct f2fs_inode_info *fi;
> > @@ -2616,21 +2640,15 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
> >  	default_options(sbi, true);
> >  
> >  	err = f2fs_check_opt_consistency(fc, sb);
> > -	if (err < 0)
> > +	if (err)
> >  		goto restore_opts;
> >  
> >  	f2fs_apply_options(fc, sb);
> >  
> > -#ifdef CONFIG_BLK_DEV_ZONED
> > -	if (f2fs_sb_has_blkzoned(sbi) &&
> > -		sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> > -		f2fs_err(sbi,
> > -			"zoned: max open zones %u is too small, need at least %u open zones",
> > -				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
> > -		err = -EINVAL;
> > +	err = f2fs_sanity_check_options(sbi);
> > +	if (err)
> >  		goto restore_opts;
> > -	}
> > -#endif
> > +
> >  	/* flush outstanding errors before changing fs state */
> >  	flush_work(&sbi->s_error_work);
> >  
> > @@ -2663,12 +2681,6 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
> >  		}
> >  	}
> >  #endif
> > -	if (f2fs_lfs_mode(sbi) && !IS_F2FS_IPU_DISABLE(sbi)) {
> > -		err = -EINVAL;
> > -		f2fs_warn(sbi, "LFS is not compatible with IPU");
> > -		goto restore_opts;
> > -	}
> > -
> >  	/* disallow enable atgc dynamically */
> >  	if (no_atgc == !!test_opt(sbi, ATGC)) {
> >  		err = -EINVAL;
> > @@ -4808,11 +4820,15 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
> >  	default_options(sbi, false);
> >  
> >  	err = f2fs_check_opt_consistency(fc, sb);
> > -	if (err < 0)
> > +	if (err)
> >  		goto free_sb_buf;
> >  
> >  	f2fs_apply_options(fc, sb);
> >  
> > +	err = f2fs_sanity_check_options(sbi);
> > +	if (err)
> > +		goto free_options;
> > +
> >  	sb->s_maxbytes = max_file_blocks(NULL) <<
> >  				le32_to_cpu(raw_super->log_blocksize);
> >  	sb->s_max_links = F2FS_LINK_MAX;

