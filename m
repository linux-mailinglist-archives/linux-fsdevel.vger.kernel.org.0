Return-Path: <linux-fsdevel+bounces-21660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6721A907989
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 19:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA1F2850BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0A149C6C;
	Thu, 13 Jun 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1Lf5nfg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822412D76D;
	Thu, 13 Jun 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299030; cv=none; b=doUaXUZzpOeED7hTI9vIz+NmPw+RyxdVpemo7GCV2kLjtlNO8pHBMfxyKC6F2y337GWrptD24A+4bIlixGjFY5/ubHaQHS9YUZKZ6qNRaNMVCohcCowccx1mdT8wHG4i77n6iLjH4J6Mk8iYJRgS0pyZxCWItgu9DaSjTQ12kUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299030; c=relaxed/simple;
	bh=jK3DxrrGpz2IB47xLds5Oq/aEYITWHK5WI+jV1YwRbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZyKZwyhf3UPRxivLhZZh1CRUzaDUllgtEhTRr+HF2WfqRW01SB/QHTt4/IhNUNtsNmdH3McO8zykmwemifPHQlikPj+KBQ/F2DojHiEi8RF+xQvubmuqw7SU+2WkdhXeWSr7ix0nnr+ZPiA2QppcE1PdhPgjHHssaFcdrAJ0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1Lf5nfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E8BC2BBFC;
	Thu, 13 Jun 2024 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718299030;
	bh=jK3DxrrGpz2IB47xLds5Oq/aEYITWHK5WI+jV1YwRbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1Lf5nfgb8sQWT8EzdmLsdpFsJGItenCxlbTT/m0VLEjLwu4dp++rIWrw7h4fsfDo
	 pMWOWzWrLC/W+VwIQbLvj0KccfXb0HpMpdGuqPP0rjU0kzVSv+rsY6RSwrAUd+POJg
	 334HlLXizYTFmywJp2f6qyCM3F6W8W63KEP6iI/PfT+4q05Yhb7+1Z9WsSoAqWjqf0
	 PACdY+OpbybgoCAiPpNvpLIHinEZUM1GJL501R4PHqZEQ3CgsulfAZw9sN5fYYrG1R
	 DwVhIKTRPDLuZIwAwnhrNsiIE1+oTxdztoXQGeTvf1juPzLvIzWClnmtK4UQeh5ynf
	 HN77vpCGidaQw==
Date: Thu, 13 Jun 2024 10:17:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	linux-block@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: Flaky test: generic/085
Message-ID: <20240613171709.GA3855044@frogsfrogsfrogs>
References: <20240611085210.GA1838544@mit.edu>
 <20240611163701.GK52977@frogsfrogsfrogs>
 <20240612-abdrehen-popkultur-80006c9e4c8d@brauner>
 <20240612144716.GB1906022@mit.edu>
 <20240613-lackmantel-einsehen-90f0d727358d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-lackmantel-einsehen-90f0d727358d@brauner>

On Thu, Jun 13, 2024 at 11:55:37AM +0200, Christian Brauner wrote:
> On Wed, Jun 12, 2024 at 03:47:16PM GMT, Theodore Ts'o wrote:
> > On Wed, Jun 12, 2024 at 01:25:07PM +0200, Christian Brauner wrote:
> > > I've been trying to reproduce this with pmem yesterday and wasn't able to.
> > > 
> > > What's the kernel config and test config that's used?
> > >
> > 
> > The kernel config can be found here:
> > 
> > https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kernel-configs/config-6.1
> > 
> > Drop it into .config in the build directory of any kernel sources
> > newer than 6.1, and then run "make olddefconfig".  This is all
> > automated in the install-kconfig script which I use:
> > 
> > https://github.com/tytso/xfstests-bld/blob/master/kernel-build/install-kconfig
> > 
> > The VM has 4 CPU's, and 26GiB of memory, and kernel is booted with the
> > boot command line options "memmap=4G!9G memmap=9G!14G", which sets up
> > fake /dev/pmem0 and /dev/pmem1 devices backed by RAM.  This is my poor
> > engineer's way of testing DAX without needing to get access to
> > expensive VM's with pmem.  :-)
> > 
> > I'm assuming this is a timing-dependant bug which is easiest to
> > trigger on fast devices, so a ramdisk might also work.  FWIW, I also
> > can see failures relatively frequently using the ext4/nojournal
> > configuration on a SSD-backed cloud block device (GCE's Persistent
> > Disk SSD product).
> > 
> > As a result, if you grab my xfstests-bld repo from github, and then
> > run "qemu-xfstests -c ext4/nojournal C 20 generic/085" it should
> > also reproduce.  See the Documentation/kvm-quickstart.md for more details.
> 
> Thanks, Ted! Ok, I think I figured it out.
> 
> P1
> dm_resume()
> -> bdev_freeze()
>    mutex_lock(&bdev->bd_fsfreeze_mutex);
>    atomic_inc_return(&bdev->bd_fsfreeze_count); // == 1
>    mutex_unlock(&bdev->bd_fsfreeze_mutex);
> 
> P2						P3
> setup_bdev_super()
> bdev_file_open_by_dev();
> atomic_read(&bdev->bd_fsfreeze_count); // != 0
> 
> 						bdev_thaw()
> 						mutex_lock(&bdev->bd_fsfreeze_mutex);
> 						atomic_dec_return(&bdev->bd_fsfreeze_count); // == 0
> 						mutex_unlock(&bdev->bd_fsfreeze_mutex);
> 						bd_holder_lock();
> 						// grab passive reference on sb via sb->s_count
> 						bd_holder_unlock();
> 						// Sleep to be woken when superblock ready or dead
> bdev_fput()
> bd_holder_lock()
> // yield bdev
> bd_holder_unlock()
> 
> deactivate_locked_super()
> // notify that superblock is dead
> 
> 						// get woken and see that superblock is dead; fail
> 
> In words this basically means that P1 calls dm_suspend() which calls
> into bdev_freeze() before the block device has been claimed by the
> filesystem. This brings bdev->bd_fsfreeze_count to 1 and no call into
> fs_bdev_freeze() is required.
> 
> Now P2 tries to mount that frozen block device. It claims it and checks
> bdev->bd_fsfreeze_count. As it's elevated it aborts mounting holding
> sb->s_umount all the time ofc.
> 
> In the meantime P3 calls dm_resume() it sees that the block device is
> already claimed by a filesystem and calls into fs_bdev_thaw().
> 
> It takes a passive reference and realizes that the filesystem isn't
> ready yet. So P3 puts itself to sleep to wait for the filesystem to
> become ready.
> 
> P2 puts the last active reference to the filesystem and marks it as
> dying.
> 
> Now P3 gets woken, sees that the filesystem is dying and
> get_bdev_super() fails.
> 
> So Darrick is correct about the fix but the reasoning is a bit
> different. :)
> 
> Patch appended and on #vfs.fixes.

> From 35224b919d6778ca5dd11f76659ae849594bd2bf Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Thu, 13 Jun 2024 11:38:14 +0200
> Subject: [PATCH] fs: don't misleadingly warn during thaw operations
> 
> The block device may have been frozen before it was claimed by a
> filesystem. Concurrently another process might try to mount that
> frozen block device and has temporarily claimed the block device for
> that purpose causing a concurrent fs_bdev_thaw() to end up here. The
> mounter is already about to abort mounting because they still saw an
> elevanted bdev->bd_fsfreeze_count so get_bdev_super() will return
> NULL in that case.
> 
> For example, P1 calls dm_suspend() which calls into bdev_freeze() before
> the block device has been claimed by the filesystem. This brings
> bdev->bd_fsfreeze_count to 1 and no call into fs_bdev_freeze() is
> required.
> 
> Now P2 tries to mount that frozen block device. It claims it and checks
> bdev->bd_fsfreeze_count. As it's elevated it aborts mounting.
> 
> In the meantime P3 calls dm_resume() it sees that the block device is
> already claimed by a filesystem and calls into fs_bdev_thaw().
> 
> It takes a passive reference and realizes that the filesystem isn't
> ready yet. So P3 puts itself to sleep to wait for the filesystem to
> become ready.
> 
> P2 puts the last active reference to the filesystem and marks it as
> dying. Now P3 gets woken, sees that the filesystem is dying and
> get_bdev_super() fails.

Wow that's twisty.  But it makes sense to me, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Fixes: 49ef8832fb1a ("bdev: implement freeze and thaw holder operations")
> Cc: <stable@vger.kernel.org>
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://lore.kernel.org/r/20240611085210.GA1838544@mit.edu
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/super.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index b72f1d288e95..095ba793e10c 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1502,8 +1502,17 @@ static int fs_bdev_thaw(struct block_device *bdev)
>  
>  	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
>  
> +	/*
> +	 * The block device may have been frozen before it was claimed by a
> +	 * filesystem. Concurrently another process might try to mount that
> +	 * frozen block device and has temporarily claimed the block device for
> +	 * that purpose causing a concurrent fs_bdev_thaw() to end up here. The
> +	 * mounter is already about to abort mounting because they still saw an
> +	 * elevanted bdev->bd_fsfreeze_count so get_bdev_super() will return
> +	 * NULL in that case.
> +	 */
>  	sb = get_bdev_super(bdev);
> -	if (WARN_ON_ONCE(!sb))
> +	if (!sb)
>  		return -EINVAL;
>  
>  	if (sb->s_op->thaw_super)
> -- 
> 2.43.0
> 


