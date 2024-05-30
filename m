Return-Path: <linux-fsdevel+bounces-20512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A898D49B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 12:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F4C1C2296A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BA176ACF;
	Thu, 30 May 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FULGEu2L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF6183965
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065132; cv=none; b=PPuwFKuxXS7rSYpeh1selPSWEXEQGalDsTx/U1UV7an7pKkyPCvgzlXHx+ChKvUhWh9udOvtDp/8wEnmF0SJcMKcP2R+LCvWEPzKrpHk7aFzi7Udo0PYWzgT7pb3/zK46iAKEPHyIHLuv/Indk2I5FaF/LGPoifmGCQsBo+TIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065132; c=relaxed/simple;
	bh=TDWsDtN/v60tQ1wrXsXeUZZbvUUQPemlR3aIul3WeSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNAEN6lK5uVV+o+gxQ4Dqa4wBLjy4hQ5lPFE2xHbaAsHfPuyZ4FrkpJoTmkcFJYWWiJiRmeBlvz7o90FaAXoBPF9EUqDhnrJk6VGKqMHEHi21tflTKPNl9CPfe1wot1O6UIbvANtYDZSvD8+hPk3fKgUtH+utiqMmHYTav4MXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FULGEu2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC44C2BBFC;
	Thu, 30 May 2024 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717065132;
	bh=TDWsDtN/v60tQ1wrXsXeUZZbvUUQPemlR3aIul3WeSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FULGEu2LvSJWl6HDox/jI7SeqVIXdsWFBTf6FDzbJVqF8ibTkF37Y0JCHE7svymPS
	 x9TlTHHD7Cq099dt6mMqgDyjss5uQsdUxGh1FOeUS8pUN9bsGfCr9xfD33Zq6ggtVw
	 ST49NJlOgm/2vv0/r15hbjWNkNDVColdTMj2LHnKMhEdayahLcJ5knk4A+rtS10xbW
	 l76hCVGVyTCSnXPG9bxofXcax7mbsjirfYcW3ksOQdx/NIvOmX8JgyCX4WyWdzDUu/
	 7ut4AS8ePfvBe7PjtUPD5hdQ5CAILQOcpb4zp2xPAYcjU9xc3v0QPWQDTA4jKp3mp/
	 bpDGwdMY0lpIQ==
Date: Thu, 30 May 2024 12:32:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	david@fromorbit.com, amir73il@gmail.com, hch@lst.de
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
Message-ID: <20240530-atheismus-festland-c11c1d3b7671@brauner>
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ai2j7cruvyb3xgtp"
Content-Disposition: inline
In-Reply-To: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>


--ai2j7cruvyb3xgtp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, May 29, 2024 at 04:41:32PM -0400, Josef Bacik wrote:
> NOTE:
> This is compile tested only.  It's also based on an out of tree feature branch
> from Amir that I'm extending to add page fault content events to allow us to
> have on-demand binary loading at exec time.  If you need more context please let
> me know, I'll push my current branch somewhere and wire up how I plan to use
> this patch so you can see it in better context, but hopefully I've described
> what I'm trying to accomplish enough that this leads to useful discussion.
> 
> 
> Currently we have ->i_writecount to control write access to an inode.
> Callers may deny write access by calling deny_write_access(), which will
> cause ->i_writecount to go negative, and allow_write_access() to push it
> back up to 0.
> 
> This is used in a few ways, the biggest user being exec.  Historically
> we've blocked write access to files that are opened for executing.
> fsverity is the other notable user.
> 
> With the upcoming fanotify feature that allows for on-demand population
> of files, this blanket policy of denying writes to files opened for
> executing creates a problem.  We have to issue events right before
> denying access, and the entire file must be populated before we can
> continue with the exec.
> 
> This creates a problem for users who have large binaries they want to
> populate on demand.  Inside of Meta we often have multi-gigabyte
> binaries, even on the order of tens of gigabytes.  Pre-loading these
> large files is costly, especially when large portions of the binary may
> never be read (think debuginfo).
> 
> In order to facilitate on-demand loading of binaries we need to have a
> way to punch a hole in this exec related write denial.

Hm. I suggest we try to tackle this in a completely different way. Maybe
I mentioned it during LSFMM but instead of doing this dance we should
try and remove the deny_write_access() mechanisms for exec completely.

Back in 2021 we removed the remaining VM_DENYWRITE bits but left in
deny_write_access() for exec. Back then I had thought that this was a
bit risky for not too much gain. But looking at this code here I think
we now have an even stronger reason to try and get rid of this
restriction. And I've since changed my mind. See my notes on the
_completely untested_ RFC patch I appended.

Ofc depends on whether Linus still agrees that removing this might be
something we could try.

> This patch accomplishes this by doing something similar to the freeze
> levels on the super block.  We have two levels, one for all write
> denial, and one for exec.  People wishing to deny writes will specify
> the level they're denying.  Users wishing to get write access must go
> through all of the levels and increment each levels counter until it
> increments them all, or encounters a level that is currently denied, at
> which point they undo their increments and return an error.
> 
> Future patches will use the get_write_access_level() helper in order to
> skip the level they wish to be allowed to access.  Any inode being
> populated via the pre-content fanotify mechanism will be marked with a
> special flag, and the open path will use get_write_access_level() in
> order to bypass the exec restriction.
> 
> This is a significant behavior change, as it allows us to write to a
> file that is currently being exec'ed.  However this will be limited to a
> very narrow use case.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  drivers/md/md.c                   |  2 +-
>  fs/binfmt_elf.c                   |  4 +-
>  fs/exec.c                         |  6 +--
>  fs/ext4/file.c                    |  4 +-
>  fs/inode.c                        |  3 +-
>  fs/kernel_read_file.c             |  4 +-
>  fs/locks.c                        |  2 +-
>  fs/quota/dquot.c                  |  2 +-
>  fs/verity/enable.c                |  4 +-
>  include/linux/fs.h                | 90 +++++++++++++++++++++++++++----
>  include/trace/events/filelock.h   |  2 +-
>  kernel/fork.c                     | 11 ++--
>  security/integrity/evm/evm_main.c |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  14 files changed, 104 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index aff9118ff697..134cefbd7bef 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7231,7 +7231,7 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
>  			pr_warn("%s: error: bitmap file must open for write\n",
>  				mdname(mddev));
>  			err = -EBADF;
> -		} else if (atomic_read(&inode->i_writecount) != 1) {
> +		} else if (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) != 1) {
>  			pr_warn("%s: error: bitmap file is already in use\n",
>  				mdname(mddev));
>  			err = -EBUSY;
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index a43897b03ce9..9a6fcf8ba17c 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1216,7 +1216,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		}
>  		reloc_func_desc = interp_load_addr;
>  
> -		allow_write_access(interpreter);
> +		allow_write_access(interpreter, INODE_DENY_WRITE_EXEC);
>  		fput(interpreter);
>  
>  		kfree(interp_elf_ex);
> @@ -1308,7 +1308,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	kfree(interp_elf_ex);
>  	kfree(interp_elf_phdata);
>  out_free_file:
> -	allow_write_access(interpreter);
> +	allow_write_access(interpreter, INODE_DENY_WRITE_EXEC);
>  	if (interpreter)
>  		fput(interpreter);
>  out_free_ph:
> diff --git a/fs/exec.c b/fs/exec.c
> index 18f057ba64a5..6b2900ee448d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -971,7 +971,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>  	if (err)
>  		goto exit;
>  
> -	err = deny_write_access(file);
> +	err = deny_write_access(file, INODE_DENY_WRITE_EXEC);
>  	if (err)
>  		goto exit;
>  
> @@ -1545,7 +1545,7 @@ static void do_close_execat(struct file *file)
>  {
>  	if (!file)
>  		return;
> -	allow_write_access(file);
> +	allow_write_access(file, INODE_DENY_WRITE_EXEC);
>  	fput(file);
>  }
>  
> @@ -1865,7 +1865,7 @@ static int exec_binprm(struct linux_binprm *bprm)
>  		bprm->file = bprm->interpreter;
>  		bprm->interpreter = NULL;
>  
> -		allow_write_access(exec);
> +		allow_write_access(exec, INODE_DENY_WRITE_EXEC);
>  		if (unlikely(bprm->have_execfd)) {
>  			if (bprm->executable) {
>  				fput(exec);
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index c89e434db6b7..6196f449649c 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -171,8 +171,8 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
>  	}
>  	/* if we are the last writer on the inode, drop the block reservation */
>  	if ((filp->f_mode & FMODE_WRITE) &&
> -			(atomic_read(&inode->i_writecount) == 1) &&
> -			!EXT4_I(inode)->i_reserved_data_blocks) {
> +	    (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) == 1) &&
> +	    !EXT4_I(inode)->i_reserved_data_blocks) {
>  		down_write(&EXT4_I(inode)->i_data_sem);
>  		ext4_discard_preallocations(inode);
>  		up_write(&EXT4_I(inode)->i_data_sem);
> diff --git a/fs/inode.c b/fs/inode.c
> index 3a41f83a4ba5..fb6155412252 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -173,7 +173,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  		inode->i_opflags |= IOP_XATTR;
>  	i_uid_write(inode, 0);
>  	i_gid_write(inode, 0);
> -	atomic_set(&inode->i_writecount, 0);
> +	for (int i = 0; i < INODE_DENY_WRITE_LEVEL; i++)
> +		atomic_set(&inode->i_writecount[i], 0);
>  	inode->i_size = 0;
>  	inode->i_write_hint = WRITE_LIFE_NOT_SET;
>  	inode->i_blocks = 0;
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index c429c42a6867..9af82d20aa1f 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -48,7 +48,7 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return -EINVAL;
>  
> -	ret = deny_write_access(file);
> +	ret = deny_write_access(file, INODE_DENY_WRITE_ALL);
>  	if (ret)
>  		return ret;
>  
> @@ -119,7 +119,7 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
>  	}
>  
>  out:
> -	allow_write_access(file);
> +	allow_write_access(file, INODE_DENY_WRITE_ALL);
>  	return ret == 0 ? copied : ret;
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file);
> diff --git a/fs/locks.c b/fs/locks.c
> index 90c8746874de..3e6a62f56528 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1763,7 +1763,7 @@ check_conflicting_open(struct file *filp, const int arg, int flags)
>  	else if (filp->f_mode & FMODE_READ)
>  		self_rcount = 1;
>  
> -	if (atomic_read(&inode->i_writecount) != self_wcount ||
> +	if (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) != self_wcount ||
>  	    atomic_read(&inode->i_readcount) != self_rcount)
>  		return -EAGAIN;
>  
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 627eb2f72ef3..fa470d76f0b3 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1031,7 +1031,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		spin_lock(&inode->i_lock);
>  		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> -		    !atomic_read(&inode->i_writecount) ||
> +		    !inode_is_open_for_write(inode) ||
>  		    !dqinit_needed(inode, type)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
> diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> index c284f46d1b53..a0e0d49c6ccc 100644
> --- a/fs/verity/enable.c
> +++ b/fs/verity/enable.c
> @@ -371,7 +371,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
>  	if (err) /* -EROFS */
>  		return err;
>  
> -	err = deny_write_access(filp);
> +	err = deny_write_access(filp, INODE_DENY_WRITE_ALL);
>  	if (err) /* -ETXTBSY */
>  		goto out_drop_write;
>  
> @@ -397,7 +397,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
>  	 * allow_write_access() is needed to pair with deny_write_access().
>  	 * Regardless, the filesystem won't allow writing to verity files.
>  	 */
> -	allow_write_access(filp);
> +	allow_write_access(filp, INODE_DENY_WRITE_ALL);
>  out_drop_write:
>  	mnt_drop_write_file(filp);
>  	return err;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0283cf366c2a..f0720cd0ab45 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -620,6 +620,22 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_XATTR	0x0008
>  #define IOP_DEFAULT_READLINK	0x0010
>  
> +/*
> + * These are used with the *write_access helpers.
> + *
> + * INODE_DENY_WRITE_ALL		-	Do not allow writes at all.
> + * INODE_DENY_WRITE_EXEC	-	Do not allow writes because we are
> + *					exec'ing the file.  This can be bypassed
> + *					in cases where the file needs to be
> + *					filled in via the fanotify pre-content
> + *					hooks.
> + */
> +enum inode_write_level {
> +	INODE_DENY_WRITE_ALL,
> +	INODE_DENY_WRITE_EXEC,
> +	INODE_DENY_WRITE_LEVEL,
> +};
> +
>  /*
>   * Keep mostly read-only and often accessed (especially for
>   * the RCU path lookup and 'stat' data) fields at the beginning
> @@ -701,7 +717,7 @@ struct inode {
>  	atomic64_t		i_sequence; /* see futex */
>  	atomic_t		i_count;
>  	atomic_t		i_dio_count;
> -	atomic_t		i_writecount;
> +	atomic_t		i_writecount[INODE_DENY_WRITE_LEVEL];
>  #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
>  	atomic_t		i_readcount; /* struct files open RO */
>  #endif
> @@ -2920,38 +2936,90 @@ static inline void kiocb_end_write(struct kiocb *iocb)
>   * put_write_access() releases this write permission.
>   * deny_write_access() denies write access to a file.
>   * allow_write_access() re-enables write access to a file.
> + * __get_write_access_level() gets write permission for a file for the given
> + *				level.
> + * put_write_access_level() releases the level write permission.
>   *
> - * The i_writecount field of an inode can have the following values:
> + * The level indicates which level we're denying writes for.  Some levels are
> + * allowed to be bypassed in special circumstances.  In the cases that the write
> + * level needs to be bypassed the user must use the
> + * get_write_access_level()/put_write_access_level() pairs of the helpers, which
> + * will allow the user to bypass the given level, but none of the others.
> + *
> + * The i_writecount[level] field of an inode can have the following values:
>   * 0: no write access, no denied write access
> - * < 0: (-i_writecount) users that denied write access to the file.
> - * > 0: (i_writecount) users that have write access to the file.
> + * < 0: (-i_writecount[level]) users that denied write access to the file.
> + * > 0: (i_writecount[level]) users that have write access to the file.
>   *
>   * Normally we operate on that counter with atomic_{inc,dec} and it's safe
>   * except for the cases where we don't hold i_writecount yet. Then we need to
>   * use {get,deny}_write_access() - these functions check the sign and refuse
>   * to do the change if sign is wrong.
>   */
> +static inline int __get_write_access(struct inode *inode,
> +				     enum inode_write_level skip_level)
> +{
> +	int i;
> +
> +	/* We are not allowed to skip INODE_DENY_WRITE_ALL. */
> +	WARN_ON_ONCE(skip_level == INODE_DENY_WRITE_ALL);
> +
> +	for (i = 0; i < INODE_DENY_WRITE_LEVEL; i++) {
> +		if (i == skip_level)
> +			continue;
> +		if (!atomic_inc_unless_negative(&inode->i_writecount[i]))
> +			goto fail;
> +	}
> +	return 0;
> +fail:
> +	while (--i >= 0) {
> +		if (i == skip_level)
> +			continue;
> +		atomic_dec(&inode->i_writecount[i]);
> +	}
> +	return -ETXTBSY;
> +}
>  static inline int get_write_access(struct inode *inode)
>  {
> -	return atomic_inc_unless_negative(&inode->i_writecount) ? 0 : -ETXTBSY;
> +	return __get_write_access(inode, INODE_DENY_WRITE_LEVEL);
>  }
> -static inline int deny_write_access(struct file *file)
> +static inline int get_write_access_level(struct inode *inode,
> +					 enum inode_write_level skip_level)
> +{
> +	return __get_write_access(inode, skip_level);
> +}
> +static inline int deny_write_access(struct file *file,
> +				    enum inode_write_level level)
>  {
>  	struct inode *inode = file_inode(file);
> -	return atomic_dec_unless_positive(&inode->i_writecount) ? 0 : -ETXTBSY;
> +	return atomic_dec_unless_positive(&inode->i_writecount[level]) ? 0 : -ETXTBSY;
> +}
> +static inline void __put_write_access(struct inode *inode,
> +				      enum inode_write_level skip_level)
> +{
> +	for (int i = 0; i < INODE_DENY_WRITE_LEVEL; i++) {
> +		if (i == skip_level)
> +			continue;
> +		atomic_dec(&inode->i_writecount[i]);
> +	}
>  }
>  static inline void put_write_access(struct inode * inode)
>  {
> -	atomic_dec(&inode->i_writecount);
> +	__put_write_access(inode, INODE_DENY_WRITE_LEVEL);
>  }
> -static inline void allow_write_access(struct file *file)
> +static inline void put_write_access_level(struct inode *inode,
> +					  enum inode_write_level skip_level)
> +{
> +	__put_write_access(inode, skip_level);
> +}
> +static inline void allow_write_access(struct file *file, enum inode_write_level level)
>  {
>  	if (file)
> -		atomic_inc(&file_inode(file)->i_writecount);
> +		atomic_inc(&file_inode(file)->i_writecount[level]);
>  }
>  static inline bool inode_is_open_for_write(const struct inode *inode)
>  {
> -	return atomic_read(&inode->i_writecount) > 0;
> +	return atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) > 0;
>  }
>  
>  #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
> index b8d1e00a7982..ad076e87a956 100644
> --- a/include/trace/events/filelock.h
> +++ b/include/trace/events/filelock.h
> @@ -187,7 +187,7 @@ TRACE_EVENT(generic_add_lease,
>  	TP_fast_assign(
>  		__entry->s_dev = inode->i_sb->s_dev;
>  		__entry->i_ino = inode->i_ino;
> -		__entry->wcount = atomic_read(&inode->i_writecount);
> +		__entry->wcount = atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]);
>  		__entry->rcount = atomic_read(&inode->i_readcount);
>  		__entry->icount = atomic_read(&inode->i_count);
>  		__entry->owner = fl->c.flc_owner;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 99076dbe27d8..b6dc7aed2ebf 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -620,7 +620,7 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
>  	 * We depend on the oldmm having properly denied write access to the
>  	 * exe_file already.
>  	 */
> -	if (exe_file && deny_write_access(exe_file))
> +	if (exe_file && deny_write_access(exe_file, INODE_DENY_WRITE_EXEC))
>  		pr_warn_once("deny_write_access() failed in %s\n", __func__);
>  }
>  
> @@ -1417,13 +1417,14 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  		 * We expect the caller (i.e., sys_execve) to already denied
>  		 * write access, so this is unlikely to fail.
>  		 */
> -		if (unlikely(deny_write_access(new_exe_file)))
> +		if (unlikely(deny_write_access(new_exe_file,
> +					       INODE_DENY_WRITE_EXEC)))
>  			return -EACCES;
>  		get_file(new_exe_file);
>  	}
>  	rcu_assign_pointer(mm->exe_file, new_exe_file);
>  	if (old_exe_file) {
> -		allow_write_access(old_exe_file);
> +		allow_write_access(old_exe_file, INODE_DENY_WRITE_EXEC);
>  		fput(old_exe_file);
>  	}
>  	return 0;
> @@ -1464,7 +1465,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  			return ret;
>  	}
>  
> -	ret = deny_write_access(new_exe_file);
> +	ret = deny_write_access(new_exe_file, INODE_DENY_WRITE_EXEC);
>  	if (ret)
>  		return -EACCES;
>  	get_file(new_exe_file);
> @@ -1476,7 +1477,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  	mmap_write_unlock(mm);
>  
>  	if (old_exe_file) {
> -		allow_write_access(old_exe_file);
> +		allow_write_access(old_exe_file, INODE_DENY_WRITE_EXEC);
>  		fput(old_exe_file);
>  	}
>  	return 0;
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 62fe66dd53ce..b83dfb295d85 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1084,7 +1084,7 @@ static void evm_file_release(struct file *file)
>  	if (!S_ISREG(inode->i_mode) || !(mode & FMODE_WRITE))
>  		return;
>  
> -	if (iint && atomic_read(&inode->i_writecount) == 1)
> +	if (iint && atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) == 1)
>  		iint->flags &= ~EVM_NEW_FILE;
>  }
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f04f43af651c..7aed80a70692 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -164,7 +164,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
>  		return;
>  
>  	mutex_lock(&iint->mutex);
> -	if (atomic_read(&inode->i_writecount) == 1) {
> +	if (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) == 1) {
>  		struct kstat stat;
>  
>  		update = test_and_clear_bit(IMA_UPDATE_XATTR,
> -- 
> 2.43.0
> 

--ai2j7cruvyb3xgtp
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-RFC-UNTESTED-fs-don-t-deny-writes-to-executables.patch"

From ba4a40635236fef36663bcfeca13dd816f9de69a Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 May 2024 09:35:44 +0200
Subject: [PATCH] [RFC UNTESTED]: fs: don't deny writes to executables

Back in 2021 we already discussed removing deny_write_access() for
executables. Back then I was hesistant because I thought that this might
cause issues in userspace. But even back then I had started taking some
notes on what could potentially depend on this and I didn't come up with
a lot so I've changed my mind and I would like to try this.

Here are some of the notes that I took:

(1) The deny_write_access() mechanism is causing really pointless issues
    such as [1]. If a thread in a thread-group opens a file writable,
    then writes some stuff, then closing the file descriptor and then
    calling execve() they can fail the execve() with ETXTBUSY because
    another thread in the thread-group could have concurrently called
    fork(). Multi-threaded libraries such as go suffer from this.

(2) There are userspace attacks that rely on overwriting the binary of a
    running process. These attacks are _mitigated_ but _not at all
    prevented_ from ocurring by the deny_write_access() mechanism.

    I'll go over some details. The clearest example of such attacks was
    the attack against runC in CVE-2019-5736 (cf. [3]).

    An attack could compromise the runC host binary from inside a
    _privileged_ runC container. The malicious binary could then be used
    to take over the host.

    (It is crucial to note that this attack is _not_ possible with
     unprivileged containers. IOW, the setup here is already insecure.)

    The attack can be made when attaching to a running container or when
    starting a container running a specially crafted image. For example,
    when runC attaches to a container the attacker can trick it into
    executing itself.

    This could be done by replacing the target binary inside the
    container with a custom binary pointing back at the runC binary
    itself. As an example, if the target binary was /bin/bash, this
    could be replaced with an executable script specifying the
    interpreter path #!/proc/self/exe.

    As such when /bin/bash is executed inside the container, instead the
    target of /proc/self/exe will be executed. That magic link will
    point to the runc binary on the host. The attacker can then proceed
    to write to the target of /proc/self/exe to try and overwrite the
    runC binary on the host.

    However, this will not succeed because of deny_write_access(). Now,
    one might think that this would prevent the attack but it doesn't.

    To overcome this, the attacker has multiple ways:
    * Open a file descriptor to /proc/self/exe using the O_PATH flag and
      then proceed to reopen the binary as O_WRONLY through
      /proc/self/fd/<nr> and try to write to it in a busy loop from a
      separate process. Ultimately it will succeed when the runC binary
      exits. After this the runC binary is compromised and can be used
      to attack other containers or the host itself.
    * Use a malicious shared library annotating a function in there with
      the constructor attribute making the malicious function run as an
      initializor. The malicious library will then open /proc/self/exe
      for creating a new entry under /proc/self/fd/<nr>. It'll then call
      exec to a) force runC to exit and b) hand the file descriptor off
      to a program that then reopens /proc/self/fd/<nr> for writing
      (which is now possible because runC has exited) and overwriting
      that binary.

    To sum up: the deny_write_access() mechanism doesn't prevent such
    attacks in insecure setups. It just makes them minimally harder.
    That's all.

    The only way back then to prevent this is to create a temporary copy
    of the calling binary itself when it starts or attaches to
    containers. So what I did back then for LXC (and Aleksa for runC)
    was to create an anonymous, in-memory file using the memfd_create()
    system call and to copy itself into the temporary in-memory file,
    which is then sealed to prevent further modifications. This sealed,
    in-memory file copy is then executed instead of the original on-disk
    binary.

    Any compromising write operations from a privileged container to the
    host binary will then write to the temporary in-memory binary and
    not to the host binary on-disk, preserving the integrity of the host
    binary. Also as the temporary, in-memory binary is sealed, writes to
    this will also fail.

    The point is that deny_write_access() is uselss to prevent these
    attacks.

(3) Denying write access to an inode because it's currently used in an
    exec path could easily be done on an LSM level. It might need an
    additional hook but that should be about it.

(4) deny_write_access() doesn't help with hardlinks.

(5) The MAP_DENYWRITE flag for mmap() has been deprecated a long time
    ago so while we do protect the main executable the bigger portion of
    the things you'd think need protecting such as the shared libraries
    aren't. IOW, we let anyone happily overwrite shared libraries.

(6) We removed all remaining uses of VM_DENYWRITE in [2]. That means:
    (6.1) We removed the legacy uselib() protection for preventing
          overwriting of shared libraries. Nobody cared in 3 years.
    (6.2) We allow write access to the elf interpreter after exec
          completed treating it on a par with shared libraries.

(7) Yes, someone in userspace could potentially be relying on this. It's
    not completely out of the realm of possibility but let's find out if
    that's actually the case and not guess.

Link: https://github.com/golang/go/issues/22315 [1]
Link: 49624efa65ac ("Merge tag 'denywrite-for-5.15' of git://github.com/davidhildenbrand/linux") [2]
Link: https://unit42.paloaltonetworks.com/breaking-docker-via-runc-explaining-cve-2019-5736 [3]
Link: https://lwn.net/Articles/866493
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/binfmt_elf.c       |  2 --
 fs/binfmt_elf_fdpic.c |  5 +----
 fs/binfmt_misc.c      |  7 ++-----
 fs/exec.c             | 14 +++-----------
 kernel/fork.c         | 26 +++-----------------------
 5 files changed, 9 insertions(+), 45 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a43897b03ce9..6fdec541f8bf 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1216,7 +1216,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 		reloc_func_desc = interp_load_addr;
 
-		allow_write_access(interpreter);
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
@@ -1308,7 +1307,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
 out_free_ph:
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index b799701454a9..28a3439f163a 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -394,7 +394,6 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			goto error;
 		}
 
-		allow_write_access(interpreter);
 		fput(interpreter);
 		interpreter = NULL;
 	}
@@ -466,10 +465,8 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	retval = 0;
 
 error:
-	if (interpreter) {
-		allow_write_access(interpreter);
+	if (interpreter)
 		fput(interpreter);
-	}
 	kfree(interpreter_name);
 	kfree(exec_params.phdrs);
 	kfree(exec_params.loadmap);
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 68fa225f89e5..21ce5ec1ea76 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -247,13 +247,10 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto ret;
 
-	if (fmt->flags & MISC_FMT_OPEN_FILE) {
+	if (fmt->flags & MISC_FMT_OPEN_FILE)
 		interp_file = file_clone_open(fmt->interp_file);
-		if (!IS_ERR(interp_file))
-			deny_write_access(interp_file);
-	} else {
+	else
 		interp_file = open_exec(fmt->interpreter);
-	}
 	retval = PTR_ERR(interp_file);
 	if (IS_ERR(interp_file))
 		goto ret;
diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..4dee205452e2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -952,10 +952,6 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 			 path_noexec(&file->f_path)))
 		goto exit;
 
-	err = deny_write_access(file);
-	if (err)
-		goto exit;
-
 out:
 	return file;
 
@@ -971,8 +967,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
  *
  * Returns ERR_PTR on failure or allocated struct file on success.
  *
- * As this is a wrapper for the internal do_open_execat(), callers
- * must call allow_write_access() before fput() on release. Also see
+ * As this is a wrapper for the internal do_open_execat(). Also see
  * do_close_execat().
  */
 struct file *open_exec(const char *name)
@@ -1524,10 +1519,8 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 /* Matches do_open_execat() */
 static void do_close_execat(struct file *file)
 {
-	if (!file)
-		return;
-	allow_write_access(file);
-	fput(file);
+	if (file)
+		fput(file);
 }
 
 static void free_bprm(struct linux_binprm *bprm)
@@ -1846,7 +1839,6 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..763a042eef9c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -616,12 +616,6 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 
 	exe_file = get_mm_exe_file(oldmm);
 	RCU_INIT_POINTER(mm->exe_file, exe_file);
-	/*
-	 * We depend on the oldmm having properly denied write access to the
-	 * exe_file already.
-	 */
-	if (exe_file && deny_write_access(exe_file))
-		pr_warn_once("deny_write_access() failed in %s\n", __func__);
 }
 
 #ifdef CONFIG_MMU
@@ -1412,20 +1406,11 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	 */
 	old_exe_file = rcu_dereference_raw(mm->exe_file);
 
-	if (new_exe_file) {
-		/*
-		 * We expect the caller (i.e., sys_execve) to already denied
-		 * write access, so this is unlikely to fail.
-		 */
-		if (unlikely(deny_write_access(new_exe_file)))
-			return -EACCES;
+	if (new_exe_file)
 		get_file(new_exe_file);
-	}
 	rcu_assign_pointer(mm->exe_file, new_exe_file);
-	if (old_exe_file) {
-		allow_write_access(old_exe_file);
+	if (old_exe_file)
 		fput(old_exe_file);
-	}
 	return 0;
 }
 
@@ -1464,9 +1449,6 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 			return ret;
 	}
 
-	ret = deny_write_access(new_exe_file);
-	if (ret)
-		return -EACCES;
 	get_file(new_exe_file);
 
 	/* set the new file */
@@ -1475,10 +1457,8 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	rcu_assign_pointer(mm->exe_file, new_exe_file);
 	mmap_write_unlock(mm);
 
-	if (old_exe_file) {
-		allow_write_access(old_exe_file);
+	if (old_exe_file)
 		fput(old_exe_file);
-	}
 	return 0;
 }
 
-- 
2.43.0


--ai2j7cruvyb3xgtp--

