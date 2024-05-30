Return-Path: <linux-fsdevel+bounces-20530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C558D4EFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35610287AE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6BA18755E;
	Thu, 30 May 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or3Z4CAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14D1EA84
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082595; cv=none; b=CaSLHEU/FJwnY6RVDVPcQyMa+RPVHRSJ1tAPvpZP+9jifuLx1eRhp+1AI4wlHMKVWx0lnUFaK0FHwNjrOvKnCsFlh2khbAwdQKY7V/kIlG2CSstauiuEGYZb+bTw4Uwa5T65dDmqITaivBOZkhMDYrMLuPxrrFDheh24EqcBTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082595; c=relaxed/simple;
	bh=t/HAzQIBqGTB3rTxLnsyciPbR+sFeyAO+1O3O+lZECU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEET7os1fpV372E8OR/MzkSX81R4I9B94fTwbHLZWxszR1u/3KgdmGVvom4nYQ+vmnkE/jwc8U1Q+IDsU7ksvoHyYADF2Qp4SogETBUjKQx+w/nEQMO/ruK5CK4OYVs4/yWwYsqQHiHUcaBSkrn2MoKQTITiO0mOdYqKRg7l7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or3Z4CAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75BAC2BBFC;
	Thu, 30 May 2024 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717082594;
	bh=t/HAzQIBqGTB3rTxLnsyciPbR+sFeyAO+1O3O+lZECU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Or3Z4CAAaoDeQW+e1VAS8muTagyi0CkGizYl8b5aMuUYim/vM0tO/Jf8kIGZO9Wws
	 MojVh9zBcd0cAuEvhz2FZ2REWEiIDOjdnwskzmfk06T5kFNYPiOnGO7nbjcKNOaF6I
	 sBZ4pKP17JrtCgYQXGfVRWYn8u3+9ekc4/RgZc1+5/LRPw8OV7oj1oj9+9k0olteQi
	 87bjge8AJ/sU2MgLzHE10EmNZdio4bbfEFn/VJz0PkC8nBZFx6Hae8WxDFUhIOWHBs
	 Nflv0+kjTmodAzkoZyTR49Ky4rAYIckmAyu3kqo3u71gbJ5NW6AMSpsu2pzwdMdoT0
	 bzRpD11s8b9OQ==
Date: Thu, 30 May 2024 17:23:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	david@fromorbit.com, amir73il@gmail.com, hch@lst.de
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
Message-ID: <20240530-rangordnung-gepocht-57a36ab8d500@brauner>
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
 <20240530-atheismus-festland-c11c1d3b7671@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530-atheismus-festland-c11c1d3b7671@brauner>

On Thu, May 30, 2024 at 12:32:06PM +0200, Christian Brauner wrote:
> On Wed, May 29, 2024 at 04:41:32PM -0400, Josef Bacik wrote:
> > NOTE:
> > This is compile tested only.  It's also based on an out of tree feature branch
> > from Amir that I'm extending to add page fault content events to allow us to
> > have on-demand binary loading at exec time.  If you need more context please let
> > me know, I'll push my current branch somewhere and wire up how I plan to use
> > this patch so you can see it in better context, but hopefully I've described
> > what I'm trying to accomplish enough that this leads to useful discussion.
> > 
> > 
> > Currently we have ->i_writecount to control write access to an inode.
> > Callers may deny write access by calling deny_write_access(), which will
> > cause ->i_writecount to go negative, and allow_write_access() to push it
> > back up to 0.
> > 
> > This is used in a few ways, the biggest user being exec.  Historically
> > we've blocked write access to files that are opened for executing.
> > fsverity is the other notable user.
> > 
> > With the upcoming fanotify feature that allows for on-demand population
> > of files, this blanket policy of denying writes to files opened for
> > executing creates a problem.  We have to issue events right before
> > denying access, and the entire file must be populated before we can
> > continue with the exec.
> > 
> > This creates a problem for users who have large binaries they want to
> > populate on demand.  Inside of Meta we often have multi-gigabyte
> > binaries, even on the order of tens of gigabytes.  Pre-loading these
> > large files is costly, especially when large portions of the binary may
> > never be read (think debuginfo).
> > 
> > In order to facilitate on-demand loading of binaries we need to have a
> > way to punch a hole in this exec related write denial.
> 
> Hm. I suggest we try to tackle this in a completely different way. Maybe
> I mentioned it during LSFMM but instead of doing this dance we should
> try and remove the deny_write_access() mechanisms for exec completely.
> 
> Back in 2021 we removed the remaining VM_DENYWRITE bits but left in
> deny_write_access() for exec. Back then I had thought that this was a
> bit risky for not too much gain. But looking at this code here I think
> we now have an even stronger reason to try and get rid of this
> restriction. And I've since changed my mind. See my notes on the
> _completely untested_ RFC patch I appended.
> 
> Ofc depends on whether Linus still agrees that removing this might be
> something we could try.

(Ignore point (4) on my notes list. I somehow forgot to remove this
as it's obviously nonsense.)

> 
> > This patch accomplishes this by doing something similar to the freeze
> > levels on the super block.  We have two levels, one for all write
> > denial, and one for exec.  People wishing to deny writes will specify
> > the level they're denying.  Users wishing to get write access must go
> > through all of the levels and increment each levels counter until it
> > increments them all, or encounters a level that is currently denied, at
> > which point they undo their increments and return an error.
> > 
> > Future patches will use the get_write_access_level() helper in order to
> > skip the level they wish to be allowed to access.  Any inode being
> > populated via the pre-content fanotify mechanism will be marked with a
> > special flag, and the open path will use get_write_access_level() in
> > order to bypass the exec restriction.
> > 
> > This is a significant behavior change, as it allows us to write to a
> > file that is currently being exec'ed.  However this will be limited to a
> > very narrow use case.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  drivers/md/md.c                   |  2 +-
> >  fs/binfmt_elf.c                   |  4 +-
> >  fs/exec.c                         |  6 +--
> >  fs/ext4/file.c                    |  4 +-
> >  fs/inode.c                        |  3 +-
> >  fs/kernel_read_file.c             |  4 +-
> >  fs/locks.c                        |  2 +-
> >  fs/quota/dquot.c                  |  2 +-
> >  fs/verity/enable.c                |  4 +-
> >  include/linux/fs.h                | 90 +++++++++++++++++++++++++++----
> >  include/trace/events/filelock.h   |  2 +-
> >  kernel/fork.c                     | 11 ++--
> >  security/integrity/evm/evm_main.c |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  14 files changed, 104 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index aff9118ff697..134cefbd7bef 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -7231,7 +7231,7 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
> >  			pr_warn("%s: error: bitmap file must open for write\n",
> >  				mdname(mddev));
> >  			err = -EBADF;
> > -		} else if (atomic_read(&inode->i_writecount) != 1) {
> > +		} else if (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) != 1) {
> >  			pr_warn("%s: error: bitmap file is already in use\n",
> >  				mdname(mddev));
> >  			err = -EBUSY;
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index a43897b03ce9..9a6fcf8ba17c 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1216,7 +1216,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  		}
> >  		reloc_func_desc = interp_load_addr;
> >  
> > -		allow_write_access(interpreter);
> > +		allow_write_access(interpreter, INODE_DENY_WRITE_EXEC);
> >  		fput(interpreter);
> >  
> >  		kfree(interp_elf_ex);
> > @@ -1308,7 +1308,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  	kfree(interp_elf_ex);
> >  	kfree(interp_elf_phdata);
> >  out_free_file:
> > -	allow_write_access(interpreter);
> > +	allow_write_access(interpreter, INODE_DENY_WRITE_EXEC);
> >  	if (interpreter)
> >  		fput(interpreter);
> >  out_free_ph:
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 18f057ba64a5..6b2900ee448d 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -971,7 +971,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> >  	if (err)
> >  		goto exit;
> >  
> > -	err = deny_write_access(file);
> > +	err = deny_write_access(file, INODE_DENY_WRITE_EXEC);
> >  	if (err)
> >  		goto exit;
> >  
> > @@ -1545,7 +1545,7 @@ static void do_close_execat(struct file *file)
> >  {
> >  	if (!file)
> >  		return;
> > -	allow_write_access(file);
> > +	allow_write_access(file, INODE_DENY_WRITE_EXEC);
> >  	fput(file);
> >  }
> >  
> > @@ -1865,7 +1865,7 @@ static int exec_binprm(struct linux_binprm *bprm)
> >  		bprm->file = bprm->interpreter;
> >  		bprm->interpreter = NULL;
> >  
> > -		allow_write_access(exec);
> > +		allow_write_access(exec, INODE_DENY_WRITE_EXEC);
> >  		if (unlikely(bprm->have_execfd)) {
> >  			if (bprm->executable) {
> >  				fput(exec);
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index c89e434db6b7..6196f449649c 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -171,8 +171,8 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
> >  	}
> >  	/* if we are the last writer on the inode, drop the block reservation */
> >  	if ((filp->f_mode & FMODE_WRITE) &&
> > -			(atomic_read(&inode->i_writecount) == 1) &&
> > -			!EXT4_I(inode)->i_reserved_data_blocks) {
> > +	    (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) == 1) &&
> > +	    !EXT4_I(inode)->i_reserved_data_blocks) {
> >  		down_write(&EXT4_I(inode)->i_data_sem);
> >  		ext4_discard_preallocations(inode);
> >  		up_write(&EXT4_I(inode)->i_data_sem);
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 3a41f83a4ba5..fb6155412252 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -173,7 +173,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
> >  		inode->i_opflags |= IOP_XATTR;
> >  	i_uid_write(inode, 0);
> >  	i_gid_write(inode, 0);
> > -	atomic_set(&inode->i_writecount, 0);
> > +	for (int i = 0; i < INODE_DENY_WRITE_LEVEL; i++)
> > +		atomic_set(&inode->i_writecount[i], 0);
> >  	inode->i_size = 0;
> >  	inode->i_write_hint = WRITE_LIFE_NOT_SET;
> >  	inode->i_blocks = 0;
> > diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> > index c429c42a6867..9af82d20aa1f 100644
> > --- a/fs/kernel_read_file.c
> > +++ b/fs/kernel_read_file.c
> > @@ -48,7 +48,7 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
> >  	if (!S_ISREG(file_inode(file)->i_mode))
> >  		return -EINVAL;
> >  
> > -	ret = deny_write_access(file);
> > +	ret = deny_write_access(file, INODE_DENY_WRITE_ALL);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -119,7 +119,7 @@ ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
> >  	}
> >  
> >  out:
> > -	allow_write_access(file);
> > +	allow_write_access(file, INODE_DENY_WRITE_ALL);
> >  	return ret == 0 ? copied : ret;
> >  }
> >  EXPORT_SYMBOL_GPL(kernel_read_file);
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 90c8746874de..3e6a62f56528 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -1763,7 +1763,7 @@ check_conflicting_open(struct file *filp, const int arg, int flags)
> >  	else if (filp->f_mode & FMODE_READ)
> >  		self_rcount = 1;
> >  
> > -	if (atomic_read(&inode->i_writecount) != self_wcount ||
> > +	if (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) != self_wcount ||
> >  	    atomic_read(&inode->i_readcount) != self_rcount)
> >  		return -EAGAIN;
> >  
> > diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> > index 627eb2f72ef3..fa470d76f0b3 100644
> > --- a/fs/quota/dquot.c
> > +++ b/fs/quota/dquot.c
> > @@ -1031,7 +1031,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
> >  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> >  		spin_lock(&inode->i_lock);
> >  		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> > -		    !atomic_read(&inode->i_writecount) ||
> > +		    !inode_is_open_for_write(inode) ||
> >  		    !dqinit_needed(inode, type)) {
> >  			spin_unlock(&inode->i_lock);
> >  			continue;
> > diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> > index c284f46d1b53..a0e0d49c6ccc 100644
> > --- a/fs/verity/enable.c
> > +++ b/fs/verity/enable.c
> > @@ -371,7 +371,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
> >  	if (err) /* -EROFS */
> >  		return err;
> >  
> > -	err = deny_write_access(filp);
> > +	err = deny_write_access(filp, INODE_DENY_WRITE_ALL);
> >  	if (err) /* -ETXTBSY */
> >  		goto out_drop_write;
> >  
> > @@ -397,7 +397,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
> >  	 * allow_write_access() is needed to pair with deny_write_access().
> >  	 * Regardless, the filesystem won't allow writing to verity files.
> >  	 */
> > -	allow_write_access(filp);
> > +	allow_write_access(filp, INODE_DENY_WRITE_ALL);
> >  out_drop_write:
> >  	mnt_drop_write_file(filp);
> >  	return err;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 0283cf366c2a..f0720cd0ab45 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -620,6 +620,22 @@ is_uncached_acl(struct posix_acl *acl)
> >  #define IOP_XATTR	0x0008
> >  #define IOP_DEFAULT_READLINK	0x0010
> >  
> > +/*
> > + * These are used with the *write_access helpers.
> > + *
> > + * INODE_DENY_WRITE_ALL		-	Do not allow writes at all.
> > + * INODE_DENY_WRITE_EXEC	-	Do not allow writes because we are
> > + *					exec'ing the file.  This can be bypassed
> > + *					in cases where the file needs to be
> > + *					filled in via the fanotify pre-content
> > + *					hooks.
> > + */
> > +enum inode_write_level {
> > +	INODE_DENY_WRITE_ALL,
> > +	INODE_DENY_WRITE_EXEC,
> > +	INODE_DENY_WRITE_LEVEL,
> > +};
> > +
> >  /*
> >   * Keep mostly read-only and often accessed (especially for
> >   * the RCU path lookup and 'stat' data) fields at the beginning
> > @@ -701,7 +717,7 @@ struct inode {
> >  	atomic64_t		i_sequence; /* see futex */
> >  	atomic_t		i_count;
> >  	atomic_t		i_dio_count;
> > -	atomic_t		i_writecount;
> > +	atomic_t		i_writecount[INODE_DENY_WRITE_LEVEL];
> >  #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> >  	atomic_t		i_readcount; /* struct files open RO */
> >  #endif
> > @@ -2920,38 +2936,90 @@ static inline void kiocb_end_write(struct kiocb *iocb)
> >   * put_write_access() releases this write permission.
> >   * deny_write_access() denies write access to a file.
> >   * allow_write_access() re-enables write access to a file.
> > + * __get_write_access_level() gets write permission for a file for the given
> > + *				level.
> > + * put_write_access_level() releases the level write permission.
> >   *
> > - * The i_writecount field of an inode can have the following values:
> > + * The level indicates which level we're denying writes for.  Some levels are
> > + * allowed to be bypassed in special circumstances.  In the cases that the write
> > + * level needs to be bypassed the user must use the
> > + * get_write_access_level()/put_write_access_level() pairs of the helpers, which
> > + * will allow the user to bypass the given level, but none of the others.
> > + *
> > + * The i_writecount[level] field of an inode can have the following values:
> >   * 0: no write access, no denied write access
> > - * < 0: (-i_writecount) users that denied write access to the file.
> > - * > 0: (i_writecount) users that have write access to the file.
> > + * < 0: (-i_writecount[level]) users that denied write access to the file.
> > + * > 0: (i_writecount[level]) users that have write access to the file.
> >   *
> >   * Normally we operate on that counter with atomic_{inc,dec} and it's safe
> >   * except for the cases where we don't hold i_writecount yet. Then we need to
> >   * use {get,deny}_write_access() - these functions check the sign and refuse
> >   * to do the change if sign is wrong.
> >   */
> > +static inline int __get_write_access(struct inode *inode,
> > +				     enum inode_write_level skip_level)
> > +{
> > +	int i;
> > +
> > +	/* We are not allowed to skip INODE_DENY_WRITE_ALL. */
> > +	WARN_ON_ONCE(skip_level == INODE_DENY_WRITE_ALL);
> > +
> > +	for (i = 0; i < INODE_DENY_WRITE_LEVEL; i++) {
> > +		if (i == skip_level)
> > +			continue;
> > +		if (!atomic_inc_unless_negative(&inode->i_writecount[i]))
> > +			goto fail;
> > +	}
> > +	return 0;
> > +fail:
> > +	while (--i >= 0) {
> > +		if (i == skip_level)
> > +			continue;
> > +		atomic_dec(&inode->i_writecount[i]);
> > +	}
> > +	return -ETXTBSY;
> > +}
> >  static inline int get_write_access(struct inode *inode)
> >  {
> > -	return atomic_inc_unless_negative(&inode->i_writecount) ? 0 : -ETXTBSY;
> > +	return __get_write_access(inode, INODE_DENY_WRITE_LEVEL);
> >  }
> > -static inline int deny_write_access(struct file *file)
> > +static inline int get_write_access_level(struct inode *inode,
> > +					 enum inode_write_level skip_level)
> > +{
> > +	return __get_write_access(inode, skip_level);
> > +}
> > +static inline int deny_write_access(struct file *file,
> > +				    enum inode_write_level level)
> >  {
> >  	struct inode *inode = file_inode(file);
> > -	return atomic_dec_unless_positive(&inode->i_writecount) ? 0 : -ETXTBSY;
> > +	return atomic_dec_unless_positive(&inode->i_writecount[level]) ? 0 : -ETXTBSY;
> > +}
> > +static inline void __put_write_access(struct inode *inode,
> > +				      enum inode_write_level skip_level)
> > +{
> > +	for (int i = 0; i < INODE_DENY_WRITE_LEVEL; i++) {
> > +		if (i == skip_level)
> > +			continue;
> > +		atomic_dec(&inode->i_writecount[i]);
> > +	}
> >  }
> >  static inline void put_write_access(struct inode * inode)
> >  {
> > -	atomic_dec(&inode->i_writecount);
> > +	__put_write_access(inode, INODE_DENY_WRITE_LEVEL);
> >  }
> > -static inline void allow_write_access(struct file *file)
> > +static inline void put_write_access_level(struct inode *inode,
> > +					  enum inode_write_level skip_level)
> > +{
> > +	__put_write_access(inode, skip_level);
> > +}
> > +static inline void allow_write_access(struct file *file, enum inode_write_level level)
> >  {
> >  	if (file)
> > -		atomic_inc(&file_inode(file)->i_writecount);
> > +		atomic_inc(&file_inode(file)->i_writecount[level]);
> >  }
> >  static inline bool inode_is_open_for_write(const struct inode *inode)
> >  {
> > -	return atomic_read(&inode->i_writecount) > 0;
> > +	return atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) > 0;
> >  }
> >  
> >  #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> > diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
> > index b8d1e00a7982..ad076e87a956 100644
> > --- a/include/trace/events/filelock.h
> > +++ b/include/trace/events/filelock.h
> > @@ -187,7 +187,7 @@ TRACE_EVENT(generic_add_lease,
> >  	TP_fast_assign(
> >  		__entry->s_dev = inode->i_sb->s_dev;
> >  		__entry->i_ino = inode->i_ino;
> > -		__entry->wcount = atomic_read(&inode->i_writecount);
> > +		__entry->wcount = atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]);
> >  		__entry->rcount = atomic_read(&inode->i_readcount);
> >  		__entry->icount = atomic_read(&inode->i_count);
> >  		__entry->owner = fl->c.flc_owner;
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 99076dbe27d8..b6dc7aed2ebf 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -620,7 +620,7 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
> >  	 * We depend on the oldmm having properly denied write access to the
> >  	 * exe_file already.
> >  	 */
> > -	if (exe_file && deny_write_access(exe_file))
> > +	if (exe_file && deny_write_access(exe_file, INODE_DENY_WRITE_EXEC))
> >  		pr_warn_once("deny_write_access() failed in %s\n", __func__);
> >  }
> >  
> > @@ -1417,13 +1417,14 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
> >  		 * We expect the caller (i.e., sys_execve) to already denied
> >  		 * write access, so this is unlikely to fail.
> >  		 */
> > -		if (unlikely(deny_write_access(new_exe_file)))
> > +		if (unlikely(deny_write_access(new_exe_file,
> > +					       INODE_DENY_WRITE_EXEC)))
> >  			return -EACCES;
> >  		get_file(new_exe_file);
> >  	}
> >  	rcu_assign_pointer(mm->exe_file, new_exe_file);
> >  	if (old_exe_file) {
> > -		allow_write_access(old_exe_file);
> > +		allow_write_access(old_exe_file, INODE_DENY_WRITE_EXEC);
> >  		fput(old_exe_file);
> >  	}
> >  	return 0;
> > @@ -1464,7 +1465,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
> >  			return ret;
> >  	}
> >  
> > -	ret = deny_write_access(new_exe_file);
> > +	ret = deny_write_access(new_exe_file, INODE_DENY_WRITE_EXEC);
> >  	if (ret)
> >  		return -EACCES;
> >  	get_file(new_exe_file);
> > @@ -1476,7 +1477,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
> >  	mmap_write_unlock(mm);
> >  
> >  	if (old_exe_file) {
> > -		allow_write_access(old_exe_file);
> > +		allow_write_access(old_exe_file, INODE_DENY_WRITE_EXEC);
> >  		fput(old_exe_file);
> >  	}
> >  	return 0;
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 62fe66dd53ce..b83dfb295d85 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -1084,7 +1084,7 @@ static void evm_file_release(struct file *file)
> >  	if (!S_ISREG(inode->i_mode) || !(mode & FMODE_WRITE))
> >  		return;
> >  
> > -	if (iint && atomic_read(&inode->i_writecount) == 1)
> > +	if (iint && atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) == 1)
> >  		iint->flags &= ~EVM_NEW_FILE;
> >  }
> >  
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index f04f43af651c..7aed80a70692 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -164,7 +164,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
> >  		return;
> >  
> >  	mutex_lock(&iint->mutex);
> > -	if (atomic_read(&inode->i_writecount) == 1) {
> > +	if (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) == 1) {
> >  		struct kstat stat;
> >  
> >  		update = test_and_clear_bit(IMA_UPDATE_XATTR,
> > -- 
> > 2.43.0
> > 



