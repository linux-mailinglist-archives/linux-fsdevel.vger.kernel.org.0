Return-Path: <linux-fsdevel+bounces-20494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00BA8D40C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 00:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562A9284C92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8AF1C9ECE;
	Wed, 29 May 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYybujui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DFF16B745
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020004; cv=none; b=suR80RvuGEWqHZe3ZNDT+JLITZcMetwVUMt4qbVoyqYy4Cle0F1w67Q5WZzszSt+YnrUsjREmmuXdk/CjVJA/jXzEzuB3jI9bHfWIRNH5Me86CUw6jERuz0Ojvnf0QsIuaSqxwO/AeiX7VbILWvm9isA+a0oQJDEGPZEqhu9d/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020004; c=relaxed/simple;
	bh=QtwJSZMo504sm13wUH4IfTbe9C72PoV0SmXVWBKX924=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HdD0yMfhm7TRRkdXbB4P41icOJxvnFCxPNALPlyo4juS0YH8DTWeS5k8w4koPcMoTnffn7j8yrRieTcgbmtScILJ3GqXbaXZ8jvv7qt3lE5L2Go7/Jr7XmgqzM+Fh/iV7Vf+QzeczQuxnn/FYk+v/2Xm/DgK+zRC2FitD/yWEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYybujui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFF2C32789;
	Wed, 29 May 2024 22:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717020003;
	bh=QtwJSZMo504sm13wUH4IfTbe9C72PoV0SmXVWBKX924=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=fYybujuiDrRH0sl8+JClhFB0a5EOKIP8+68E/IDB7RDU5wSLUJiwnMVF7Kioz9EBX
	 ayUHW6368ANmMUoy1falryzsR3lWmKEKjsbVQxdxr54KmUTNzuUDq37ArVIdplL2mU
	 5UK2Vn4/pY9LMOQE0i6xk86ngmjg4nQHQHacmb18g1TbbF/7d5kfy68fTzzIKVAM8l
	 /2spw/e6k+8BAt6oioCP0eeh3zUIBLQ4Wd036Gz/9TKyjYFGWYVNxSBqR74D/jsO70
	 UDx/a7Kp1N4Y1G01R180+WBhxwKNwwjkKkn9djeeszg25zHnrGg8OqeW84L803n67L
	 2bRIZ/5JXe0TQ==
Message-ID: <13654c621ef1260dda0000edf1dc25f160563b9a.camel@kernel.org>
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
From: Jeff Layton <jlayton@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 brauner@kernel.org, viro@ZenIV.linux.org.uk, jack@suse.cz,
 david@fromorbit.com,  amir73il@gmail.com, hch@lst.de
Date: Wed, 29 May 2024 18:00:01 -0400
In-Reply-To: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
References: 
	<72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-29 at 16:41 -0400, Josef Bacik wrote:
> NOTE:
> This is compile tested only.=C2=A0 It's also based on an out of tree
> feature branch
> from Amir that I'm extending to add page fault content events to
> allow us to
> have on-demand binary loading at exec time.=C2=A0 If you need more contex=
t
> please let
> me know, I'll push my current branch somewhere and wire up how I plan
> to use
> this patch so you can see it in better context, but hopefully I've
> described
> what I'm trying to accomplish enough that this leads to useful
> discussion.
>=20
>=20
> Currently we have ->i_writecount to control write access to an inode.
> Callers may deny write access by calling deny_write_access(), which
> will
> cause ->i_writecount to go negative, and allow_write_access() to push
> it
> back up to 0.
>=20
> This is used in a few ways, the biggest user being exec.=C2=A0
> Historically
> we've blocked write access to files that are opened for executing.
> fsverity is the other notable user.
>=20
> With the upcoming fanotify feature that allows for on-demand
> population
> of files, this blanket policy of denying writes to files opened for
> executing creates a problem.=C2=A0 We have to issue events right before
> denying access, and the entire file must be populated before we can
> continue with the exec.
>=20
> This creates a problem for users who have large binaries they want to
> populate on demand.=C2=A0 Inside of Meta we often have multi-gigabyte
> binaries, even on the order of tens of gigabytes.=C2=A0 Pre-loading these
> large files is costly, especially when large portions of the binary
> may
> never be read (think debuginfo).
>=20
> In order to facilitate on-demand loading of binaries we need to have
> a
> way to punch a hole in this exec related write denial.
>=20
> This patch accomplishes this by doing something similar to the freeze
> levels on the super block.=C2=A0 We have two levels, one for all write
> denial, and one for exec.=C2=A0 People wishing to deny writes will specif=
y
> the level they're denying.=C2=A0 Users wishing to get write access must g=
o
> through all of the levels and increment each levels counter until it
> increments them all, or encounters a level that is currently denied,
> at
> which point they undo their increments and return an error.
>=20
> Future patches will use the get_write_access_level() helper in order
> to
> skip the level they wish to be allowed to access.=C2=A0 Any inode being
> populated via the pre-content fanotify mechanism will be marked with
> a
> special flag, and the open path will use get_write_access_level() in
> order to bypass the exec restriction.
>=20
> This is a significant behavior change, as it allows us to write to a
> file that is currently being exec'ed.=C2=A0 However this will be limited
> to a
> very narrow use case.
>
>

Given that this is a change in behavior, should this be behind Kconfig
option or a sysctl or something?

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> =C2=A0drivers/md/md.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/binfmt_elf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
> =C2=A0fs/exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +--
> =C2=A0fs/ext4/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +=
-
> =C2=A0fs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 +-
> =C2=A0fs/kernel_read_file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
> =C2=A0fs/locks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/quota/dquot.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/verity/enable.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
> =C2=A0include/linux/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 90 +++++++++++++++++++++++++++=
--
> --
> =C2=A0include/trace/events/filelock.h=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0kernel/fork.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++-=
-
> =C2=A0security/integrity/evm/evm_main.c |=C2=A0 2 +-
> =C2=A0security/integrity/ima/ima_main.c |=C2=A0 2 +-
> =C2=A014 files changed, 104 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index aff9118ff697..134cefbd7bef 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7231,7 +7231,7 @@ static int set_bitmap_file(struct mddev *mddev,
> int fd)
> =C2=A0			pr_warn("%s: error: bitmap file must open
> for write\n",
> =C2=A0				mdname(mddev));
> =C2=A0			err =3D -EBADF;
> -		} else if (atomic_read(&inode->i_writecount) !=3D 1) {
> +		} else if (atomic_read(&inode-
> >i_writecount[INODE_DENY_WRITE_ALL]) !=3D 1) {
> =C2=A0			pr_warn("%s: error: bitmap file is already
> in use\n",
> =C2=A0				mdname(mddev));
> =C2=A0			err =3D -EBUSY;
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index a43897b03ce9..9a6fcf8ba17c 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1216,7 +1216,7 @@ static int load_elf_binary(struct linux_binprm
> *bprm)
> =C2=A0		}
> =C2=A0		reloc_func_desc =3D interp_load_addr;
> =C2=A0
> -		allow_write_access(interpreter);
> +		allow_write_access(interpreter,
> INODE_DENY_WRITE_EXEC);
> =C2=A0		fput(interpreter);
> =C2=A0
> =C2=A0		kfree(interp_elf_ex);
> @@ -1308,7 +1308,7 @@ static int load_elf_binary(struct linux_binprm
> *bprm)
> =C2=A0	kfree(interp_elf_ex);
> =C2=A0	kfree(interp_elf_phdata);
> =C2=A0out_free_file:
> -	allow_write_access(interpreter);
> +	allow_write_access(interpreter, INODE_DENY_WRITE_EXEC);
> =C2=A0	if (interpreter)
> =C2=A0		fput(interpreter);
> =C2=A0out_free_ph:
> diff --git a/fs/exec.c b/fs/exec.c
> index 18f057ba64a5..6b2900ee448d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -971,7 +971,7 @@ static struct file *do_open_execat(int fd, struct
> filename *name, int flags)
> =C2=A0	if (err)
> =C2=A0		goto exit;
> =C2=A0
> -	err =3D deny_write_access(file);
> +	err =3D deny_write_access(file, INODE_DENY_WRITE_EXEC);
> =C2=A0	if (err)
> =C2=A0		goto exit;
> =C2=A0
> @@ -1545,7 +1545,7 @@ static void do_close_execat(struct file *file)
> =C2=A0{
> =C2=A0	if (!file)
> =C2=A0		return;
> -	allow_write_access(file);
> +	allow_write_access(file, INODE_DENY_WRITE_EXEC);
> =C2=A0	fput(file);
> =C2=A0}
> =C2=A0
> @@ -1865,7 +1865,7 @@ static int exec_binprm(struct linux_binprm
> *bprm)
> =C2=A0		bprm->file =3D bprm->interpreter;
> =C2=A0		bprm->interpreter =3D NULL;
> =C2=A0
> -		allow_write_access(exec);
> +		allow_write_access(exec, INODE_DENY_WRITE_EXEC);
> =C2=A0		if (unlikely(bprm->have_execfd)) {
> =C2=A0			if (bprm->executable) {
> =C2=A0				fput(exec);
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index c89e434db6b7..6196f449649c 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -171,8 +171,8 @@ static int ext4_release_file(struct inode *inode,
> struct file *filp)
> =C2=A0	}
> =C2=A0	/* if we are the last writer on the inode, drop the block
> reservation */
> =C2=A0	if ((filp->f_mode & FMODE_WRITE) &&
> -			(atomic_read(&inode->i_writecount) =3D=3D 1) &&
> -			!EXT4_I(inode)->i_reserved_data_blocks) {
> +	=C2=A0=C2=A0=C2=A0 (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_A=
LL])
> =3D=3D 1) &&
> +	=C2=A0=C2=A0=C2=A0 !EXT4_I(inode)->i_reserved_data_blocks) {
> =C2=A0		down_write(&EXT4_I(inode)->i_data_sem);
> =C2=A0		ext4_discard_preallocations(inode);
> =C2=A0		up_write(&EXT4_I(inode)->i_data_sem);
> diff --git a/fs/inode.c b/fs/inode.c
> index 3a41f83a4ba5..fb6155412252 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -173,7 +173,8 @@ int inode_init_always(struct super_block *sb,
> struct inode *inode)
> =C2=A0		inode->i_opflags |=3D IOP_XATTR;
> =C2=A0	i_uid_write(inode, 0);
> =C2=A0	i_gid_write(inode, 0);
> -	atomic_set(&inode->i_writecount, 0);
> +	for (int i =3D 0; i < INODE_DENY_WRITE_LEVEL; i++)
> +		atomic_set(&inode->i_writecount[i], 0);
> =C2=A0	inode->i_size =3D 0;
> =C2=A0	inode->i_write_hint =3D WRITE_LIFE_NOT_SET;
> =C2=A0	inode->i_blocks =3D 0;
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index c429c42a6867..9af82d20aa1f 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -48,7 +48,7 @@ ssize_t kernel_read_file(struct file *file, loff_t
> offset, void **buf,
> =C2=A0	if (!S_ISREG(file_inode(file)->i_mode))
> =C2=A0		return -EINVAL;
> =C2=A0
> -	ret =3D deny_write_access(file);
> +	ret =3D deny_write_access(file, INODE_DENY_WRITE_ALL);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -119,7 +119,7 @@ ssize_t kernel_read_file(struct file *file,
> loff_t offset, void **buf,
> =C2=A0	}
> =C2=A0
> =C2=A0out:
> -	allow_write_access(file);
> +	allow_write_access(file, INODE_DENY_WRITE_ALL);
> =C2=A0	return ret =3D=3D 0 ? copied : ret;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(kernel_read_file);
> diff --git a/fs/locks.c b/fs/locks.c
> index 90c8746874de..3e6a62f56528 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1763,7 +1763,7 @@ check_conflicting_open(struct file *filp, const
> int arg, int flags)
> =C2=A0	else if (filp->f_mode & FMODE_READ)
> =C2=A0		self_rcount =3D 1;
> =C2=A0
> -	if (atomic_read(&inode->i_writecount) !=3D self_wcount ||
> +	if (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL])
> !=3D self_wcount ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 atomic_read(&inode->i_readcount) !=3D self_rcou=
nt)
> =C2=A0		return -EAGAIN;
> =C2=A0
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 627eb2f72ef3..fa470d76f0b3 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1031,7 +1031,7 @@ static int add_dquot_ref(struct super_block
> *sb, int type)
> =C2=A0	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> =C2=A0		spin_lock(&inode->i_lock);
> =C2=A0		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW))
> ||
> -		=C2=A0=C2=A0=C2=A0 !atomic_read(&inode->i_writecount) ||
> +		=C2=A0=C2=A0=C2=A0 !inode_is_open_for_write(inode) ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 !dqinit_needed(inode, type)) {
> =C2=A0			spin_unlock(&inode->i_lock);
> =C2=A0			continue;
> diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> index c284f46d1b53..a0e0d49c6ccc 100644
> --- a/fs/verity/enable.c
> +++ b/fs/verity/enable.c
> @@ -371,7 +371,7 @@ int fsverity_ioctl_enable(struct file *filp,
> const void __user *uarg)
> =C2=A0	if (err) /* -EROFS */
> =C2=A0		return err;
> =C2=A0
> -	err =3D deny_write_access(filp);
> +	err =3D deny_write_access(filp, INODE_DENY_WRITE_ALL);
> =C2=A0	if (err) /* -ETXTBSY */
> =C2=A0		goto out_drop_write;
> =C2=A0
> @@ -397,7 +397,7 @@ int fsverity_ioctl_enable(struct file *filp,
> const void __user *uarg)
> =C2=A0	 * allow_write_access() is needed to pair with
> deny_write_access().
> =C2=A0	 * Regardless, the filesystem won't allow writing to verity
> files.
> =C2=A0	 */
> -	allow_write_access(filp);
> +	allow_write_access(filp, INODE_DENY_WRITE_ALL);
> =C2=A0out_drop_write:
> =C2=A0	mnt_drop_write_file(filp);
> =C2=A0	return err;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0283cf366c2a..f0720cd0ab45 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -620,6 +620,22 @@ is_uncached_acl(struct posix_acl *acl)
> =C2=A0#define IOP_XATTR	0x0008
> =C2=A0#define IOP_DEFAULT_READLINK	0x0010
> =C2=A0
> +/*
> + * These are used with the *write_access helpers.
> + *
> + * INODE_DENY_WRITE_ALL		-	Do not allow writes
> at all.
> + * INODE_DENY_WRITE_EXEC	-	Do not allow writes because
> we are
> + *					exec'ing the file.=C2=A0 This can
> be bypassed
> + *					in cases where the file
> needs to be
> + *					filled in via the fanotify
> pre-content
> + *					hooks.
> + */
> +enum inode_write_level {
> +	INODE_DENY_WRITE_ALL,
> +	INODE_DENY_WRITE_EXEC,
> +	INODE_DENY_WRITE_LEVEL,
> +};
> +
> =C2=A0/*
> =C2=A0 * Keep mostly read-only and often accessed (especially for
> =C2=A0 * the RCU path lookup and 'stat' data) fields at the beginning
> @@ -701,7 +717,7 @@ struct inode {
> =C2=A0	atomic64_t		i_sequence; /* see futex */
> =C2=A0	atomic_t		i_count;
> =C2=A0	atomic_t		i_dio_count;
> -	atomic_t		i_writecount;
> +	atomic_t		i_writecount[INODE_DENY_WRITE_LEVEL]
> ;

Rather than turning this into an array, I think this would be easier to
reason about as i_execcount. Then you could add a new
allow/deny_exec_access(), and leave most of the existing write_access
helpers alone, etc.

> =C2=A0#if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> =C2=A0	atomic_t		i_readcount; /* struct files open RO
> */
> =C2=A0#endif
> @@ -2920,38 +2936,90 @@ static inline void kiocb_end_write(struct
> kiocb *iocb)
> =C2=A0 * put_write_access() releases this write permission.
> =C2=A0 * deny_write_access() denies write access to a file.
> =C2=A0 * allow_write_access() re-enables write access to a file.
> + * __get_write_access_level() gets write permission for a file for
> the given
> + *				level.
> + * put_write_access_level() releases the level write permission.
> =C2=A0 *
> - * The i_writecount field of an inode can have the following values:
> + * The level indicates which level we're denying writes for.=C2=A0 Some
> levels are
> + * allowed to be bypassed in special circumstances.=C2=A0 In the cases
> that the write
> + * level needs to be bypassed the user must use the
> + * get_write_access_level()/put_write_access_level() pairs of the
> helpers, which
> + * will allow the user to bypass the given level, but none of the
> others.
> + *
> + * The i_writecount[level] field of an inode can have the following
> values:
> =C2=A0 * 0: no write access, no denied write access
> - * < 0: (-i_writecount) users that denied write access to the file.
> - * > 0: (i_writecount) users that have write access to the file.
> + * < 0: (-i_writecount[level]) users that denied write access to the
> file.
> + * > 0: (i_writecount[level]) users that have write access to the
> file.
> =C2=A0 *
> =C2=A0 * Normally we operate on that counter with atomic_{inc,dec} and
> it's safe
> =C2=A0 * except for the cases where we don't hold i_writecount yet. Then
> we need to
> =C2=A0 * use {get,deny}_write_access() - these functions check the sign
> and refuse
> =C2=A0 * to do the change if sign is wrong.
> =C2=A0 */
> +static inline int __get_write_access(struct inode *inode,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 enum inode_write_level
> skip_level)
> +{
> +	int i;
> +
> +	/* We are not allowed to skip INODE_DENY_WRITE_ALL. */
> +	WARN_ON_ONCE(skip_level =3D=3D INODE_DENY_WRITE_ALL);
> +
> +	for (i =3D 0; i < INODE_DENY_WRITE_LEVEL; i++) {
> +		if (i =3D=3D skip_level)
> +			continue;
> +		if (!atomic_inc_unless_negative(&inode-
> >i_writecount[i]))
> +			goto fail;
> +	}
> +	return 0;
> +fail:
> +	while (--i >=3D 0) {
> +		if (i =3D=3D skip_level)
> +			continue;
> +		atomic_dec(&inode->i_writecount[i]);
> +	}
> +	return -ETXTBSY;
> +}
> =C2=A0static inline int get_write_access(struct inode *inode)
> =C2=A0{
> -	return atomic_inc_unless_negative(&inode->i_writecount) ? 0
> : -ETXTBSY;
> +	return __get_write_access(inode, INODE_DENY_WRITE_LEVEL);
> =C2=A0}
> -static inline int deny_write_access(struct file *file)
> +static inline int get_write_access_level(struct inode *inode,
> +					 enum inode_write_level
> skip_level)
> +{
> +	return __get_write_access(inode, skip_level);
> +}
> +static inline int deny_write_access(struct file *file,
> +				=C2=A0=C2=A0=C2=A0 enum inode_write_level level)
> =C2=A0{
> =C2=A0	struct inode *inode =3D file_inode(file);
> -	return atomic_dec_unless_positive(&inode->i_writecount) ? 0
> : -ETXTBSY;
> +	return atomic_dec_unless_positive(&inode-
> >i_writecount[level]) ? 0 : -ETXTBSY;
> +}
> +static inline void __put_write_access(struct inode *inode,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum inode_write_level
> skip_level)
> +{
> +	for (int i =3D 0; i < INODE_DENY_WRITE_LEVEL; i++) {
> +		if (i =3D=3D skip_level)
> +			continue;
> +		atomic_dec(&inode->i_writecount[i]);
> +	}
> =C2=A0}
> =C2=A0static inline void put_write_access(struct inode * inode)
> =C2=A0{
> -	atomic_dec(&inode->i_writecount);
> +	__put_write_access(inode, INODE_DENY_WRITE_LEVEL);
> =C2=A0}
> -static inline void allow_write_access(struct file *file)
> +static inline void put_write_access_level(struct inode *inode,
> +					=C2=A0 enum inode_write_level
> skip_level)
> +{
> +	__put_write_access(inode, skip_level);
> +}
> +static inline void allow_write_access(struct file *file, enum
> inode_write_level level)
> =C2=A0{
> =C2=A0	if (file)
> -		atomic_inc(&file_inode(file)->i_writecount);
> +		atomic_inc(&file_inode(file)->i_writecount[level]);
> =C2=A0}
> =C2=A0static inline bool inode_is_open_for_write(const struct inode
> *inode)
> =C2=A0{
> -	return atomic_read(&inode->i_writecount) > 0;
> +	return atomic_read(&inode-
> >i_writecount[INODE_DENY_WRITE_ALL]) > 0;
> =C2=A0}
> =C2=A0
> =C2=A0#if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> diff --git a/include/trace/events/filelock.h
> b/include/trace/events/filelock.h
> index b8d1e00a7982..ad076e87a956 100644
> --- a/include/trace/events/filelock.h
> +++ b/include/trace/events/filelock.h
> @@ -187,7 +187,7 @@ TRACE_EVENT(generic_add_lease,
> =C2=A0	TP_fast_assign(
> =C2=A0		__entry->s_dev =3D inode->i_sb->s_dev;
> =C2=A0		__entry->i_ino =3D inode->i_ino;
> -		__entry->wcount =3D atomic_read(&inode->i_writecount);
> +		__entry->wcount =3D atomic_read(&inode-
> >i_writecount[INODE_DENY_WRITE_ALL]);
> =C2=A0		__entry->rcount =3D atomic_read(&inode->i_readcount);
> =C2=A0		__entry->icount =3D atomic_read(&inode->i_count);
> =C2=A0		__entry->owner =3D fl->c.flc_owner;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 99076dbe27d8..b6dc7aed2ebf 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -620,7 +620,7 @@ static void dup_mm_exe_file(struct mm_struct *mm,
> struct mm_struct *oldmm)
> =C2=A0	 * We depend on the oldmm having properly denied write
> access to the
> =C2=A0	 * exe_file already.
> =C2=A0	 */
> -	if (exe_file && deny_write_access(exe_file))
> +	if (exe_file && deny_write_access(exe_file,
> INODE_DENY_WRITE_EXEC))
> =C2=A0		pr_warn_once("deny_write_access() failed in %s\n",
> __func__);
> =C2=A0}
> =C2=A0
> @@ -1417,13 +1417,14 @@ int set_mm_exe_file(struct mm_struct *mm,
> struct file *new_exe_file)
> =C2=A0		 * We expect the caller (i.e., sys_execve) to
> already denied
> =C2=A0		 * write access, so this is unlikely to fail.
> =C2=A0		 */
> -		if (unlikely(deny_write_access(new_exe_file)))
> +		if (unlikely(deny_write_access(new_exe_file,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> INODE_DENY_WRITE_EXEC)))
> =C2=A0			return -EACCES;
> =C2=A0		get_file(new_exe_file);
> =C2=A0	}
> =C2=A0	rcu_assign_pointer(mm->exe_file, new_exe_file);
> =C2=A0	if (old_exe_file) {
> -		allow_write_access(old_exe_file);
> +		allow_write_access(old_exe_file,
> INODE_DENY_WRITE_EXEC);
> =C2=A0		fput(old_exe_file);
> =C2=A0	}
> =C2=A0	return 0;
> @@ -1464,7 +1465,7 @@ int replace_mm_exe_file(struct mm_struct *mm,
> struct file *new_exe_file)
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> -	ret =3D deny_write_access(new_exe_file);
> +	ret =3D deny_write_access(new_exe_file,
> INODE_DENY_WRITE_EXEC);
> =C2=A0	if (ret)
> =C2=A0		return -EACCES;
> =C2=A0	get_file(new_exe_file);
> @@ -1476,7 +1477,7 @@ int replace_mm_exe_file(struct mm_struct *mm,
> struct file *new_exe_file)
> =C2=A0	mmap_write_unlock(mm);
> =C2=A0
> =C2=A0	if (old_exe_file) {
> -		allow_write_access(old_exe_file);
> +		allow_write_access(old_exe_file,
> INODE_DENY_WRITE_EXEC);
> =C2=A0		fput(old_exe_file);
> =C2=A0	}
> =C2=A0	return 0;
> diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> index 62fe66dd53ce..b83dfb295d85 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1084,7 +1084,7 @@ static void evm_file_release(struct file *file)
> =C2=A0	if (!S_ISREG(inode->i_mode) || !(mode & FMODE_WRITE))
> =C2=A0		return;
> =C2=A0
> -	if (iint && atomic_read(&inode->i_writecount) =3D=3D 1)
> +	if (iint && atomic_read(&inode-
> >i_writecount[INODE_DENY_WRITE_ALL]) =3D=3D 1)
> =C2=A0		iint->flags &=3D ~EVM_NEW_FILE;
> =C2=A0}
> =C2=A0
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index f04f43af651c..7aed80a70692 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -164,7 +164,7 @@ static void ima_check_last_writer(struct
> ima_iint_cache *iint,
> =C2=A0		return;
> =C2=A0
> =C2=A0	mutex_lock(&iint->mutex);
> -	if (atomic_read(&inode->i_writecount) =3D=3D 1) {
> +	if (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL])
> =3D=3D 1) {
> =C2=A0		struct kstat stat;
> =C2=A0
> =C2=A0		update =3D test_and_clear_bit(IMA_UPDATE_XATTR,

--=20
Jeff Layton <jlayton@kernel.org>

