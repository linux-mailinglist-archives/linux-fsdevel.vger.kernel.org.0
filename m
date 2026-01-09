Return-Path: <linux-fsdevel+bounces-73070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BABED0B881
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1BCD3027E76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81481365A06;
	Fri,  9 Jan 2026 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag3SD+HD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E735CB85
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978447; cv=none; b=cGbS2fBPIq2e0WRqythh1bWvMo/06ufW+iv/8eJDHht7Ry4+aet4Kh06Xvtww30ZF/souwieAjST1Y1ZmvHR3vYmHtPZxlxyruN8UUvgWLXQk+XhOC2j153WnB87VJ3bMDAt5YmgOdVl8QgxGoF+pRDEn3Y4/+fA8xTV8qfNO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978447; c=relaxed/simple;
	bh=XVJb+spUsOXmk3Ka32Q/lXdIj7zL97Hajw+2/Bfk4is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfihycjECCDRJN2Qs7NeWj5AKJXFsR95n2Id60tEMj1GmKmjcaTaikDWKkVv1O2Knh76YyksuSM8sp4ZDpRwCGa3cuHem7L/IBrlTaDNKUt+U/jBD9pm0/NzcC9W6xL1ljshlCblcnj+6CKgOii5hSmOIbQVoxhKLnVis+N0I1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag3SD+HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE7FC19425
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767978447;
	bh=XVJb+spUsOXmk3Ka32Q/lXdIj7zL97Hajw+2/Bfk4is=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ag3SD+HDBfARfsjqGeXq9p7f74iRI/L63NcdHz7lxyBeJXMwTMQl+7VseqmWSC4FR
	 5vqI1tO8LMHjdUrmKEtnCg0K2L5TMXDuoiXhZbQl7prUlsFORJM0BKBQ+8uCy+LXbz
	 8JdRgj2B1i7dDIHpFUXEAO9rYKeHzjSWTSBOEho/Br4fkKZfa+2TxcM+awYQtNGxZ8
	 uTUKK9wAVMhdF7fIgHf1fL0IUMSHHK2vBM94tQSO4d3fRy7Gt+Zhu3vhDK6UDdQtWy
	 pxJeX3lwoZelYEbPWrmu9gQ7drPM6lumWLWzOr100Dfh1aQ7M378XvD2bnD4aE7z1n
	 ZM/NvPQkSnohg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b79ea617f55so893891566b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 09:07:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWC5N3TkUf6PpnvK/zS0TLdoXhJN9OrIuje+/PrL2xX7DKSlCBv4CpZgjwP9ngAl+0WUyjfTP7ogognVm9b@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8iGCjKUuMpS9yYJNrzp96/4Zqx7CrGX8lvHOIRBq5d5Q9Q265
	bDMb1DEp6yzqU1LebBpu7BuqcdupeUjUPgUiRJ0+TWw4S3tFOtUENSMSJh8jTPekGrK0TMpDaIg
	cLD7I2wER63Sn3dsiiR3uVYYoLYGtu8A=
X-Google-Smtp-Source: AGHT+IHFEd/Cji7DPzPk6Q0cBLN926Pva19PuOn+kn33FVn6/MaIdCy6zJRKw3cfNEMg7xUNGSJUX33GisYNnMtjBsg=
X-Received: by 2002:a17:907:9615:b0:b80:4119:2436 with SMTP id
 a640c23a62f3a-b8444d4ea89mr980899166b.7.1767978446098; Fri, 09 Jan 2026
 09:07:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767801889.git.fdmanana@suse.com> <46b13dc5c957deb72a7f085916757a20878a8e73.1767801889.git.fdmanana@suse.com>
 <20260108220505.GP21071@twin.jikos.cz>
In-Reply-To: <20260108220505.GP21071@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 9 Jan 2026 17:06:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H67kO2LLDPSZQePkC6J-F5SPT45zjLg_Y4rBo7kAJqhtA@mail.gmail.com>
X-Gm-Features: AQt7F2qp9c9HYxqNlhVhsEIFw6qT9YzEVqAsgG2OIq2ycz_33z2wEPOq90T9_xI
Message-ID: <CAL3q7H67kO2LLDPSZQePkC6J-F5SPT45zjLg_Y4rBo7kAJqhtA@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: use may_delete_dentry() in btrfs_ioctl_snap_destroy()
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:05=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Thu, Jan 08, 2026 at 01:35:33PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There is no longer the need to use btrfs_may_delete(), which was a copy
> > of the VFS private function may_delete(), since now that functionality
> > is exported by the VFS as a function named may_delete_dentry(). In fact
> > our local copy of may_delete() lacks an update that happened to that
> > function which is point number 7 in that function's comment:
> >
> >   "7. If the victim has an unknown uid or gid we can't change the inode=
."
> >
> > which corresponds to this code:
> >
> >       /* Inode writeback is not safe when the uid or gid are invalid. *=
/
> >       if (!vfsuid_valid(i_uid_into_vfsuid(idmap, inode)) ||
> >           !vfsgid_valid(i_gid_into_vfsgid(idmap, inode)))
> >               return -EOVERFLOW;
> >
> > As long as we keep a separate copy, duplicating code, we are also prone
> > to updates to the VFS being missed in our local copy.
> >
> > So change btrfs_ioctl_snap_destroy() to use the VFS function and remove
> > btrfs_may_delete().
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/ioctl.c | 58 +-----------------------------------------------
> >  1 file changed, 1 insertion(+), 57 deletions(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index d9e7dd317670..0cb3cd3d05a5 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -815,62 +815,6 @@ static int create_snapshot(struct btrfs_root *root=
, struct inode *dir,
> >       return ret;
> >  }
> >
> > -/*  copy of may_delete in fs/namei.c()
> > - *   Check whether we can remove a link victim from directory dir, che=
ck
> > - *  whether the type of victim is right.
> > - *  1. We can't do it if dir is read-only (done in permission())
> > - *  2. We should have write and exec permissions on dir
> > - *  3. We can't remove anything from append-only dir
> > - *  4. We can't do anything with immutable dir (done in permission())
> > - *  5. If the sticky bit on dir is set we should either
> > - *   a. be owner of dir, or
> > - *   b. be owner of victim, or
> > - *   c. have CAP_FOWNER capability
> > - *  6. If the victim is append-only or immutable we can't do anything =
with
> > - *     links pointing to it.
> > - *  7. If we were asked to remove a directory and victim isn't one - E=
NOTDIR.
> > - *  8. If we were asked to remove a non-directory and victim isn't one=
 - EISDIR.
> > - *  9. We can't remove a root or mountpoint.
> > - * 10. We don't allow removal of NFS sillyrenamed files; it's handled =
by
> > - *     nfs_async_unlink().
> > - */
> > -
> > -static int btrfs_may_delete(struct mnt_idmap *idmap,
> > -                         struct inode *dir, struct dentry *victim, int=
 isdir)
> > -{
> > -     int ret;
>
> There are some differences in VFS may_delete that I don't know if are
> significant, they seem to be releated to stacked filesystems.
>
> For example the associated inode of the victim dentry is obtained as
> d_backing_inode() vs our simple d_inode().
>
> > -
> > -     if (d_really_is_negative(victim))
>
> VFS does d_is_negative() which does not check for NULL pointer but some
> other internal state.
>
> > -             return -ENOENT;
> > -
> > -     /* The @victim is not inside @dir. */
> > -     if (d_inode(victim->d_parent) !=3D dir)
> > -             return -EINVAL;
>
> We handle that properly, while VFS does BUG_ON, so this can be fixed
> separeately in the VFS version.

Yes, but it's one of those cases that should never happen.
In fact we used to have the BUG_ON in btrfs too, you converted it to
proper error handling in:

commit 1686570265559ebfa828c1b784a31407ec2877bd
Author: David Sterba <dsterba@suse.com>
Date:   Fri Jan 19 20:23:56 2024 +0100

    btrfs: handle directory and dentry mismatch in btrfs_may_delete()



>
> There are no changes in the rest of the function (other than the
> different way how inode is obtained).

Yes, small differences like that. Some of those things seem to be
because our btrfs copy was not updated.
fstests pass with this patchset.

>
> The original commit 4260f7c7516f4c ("Btrfs: allow subvol deletion by
> unprivileged user with -o user_subvol_rm_allowed") adding this helper
> says something about adding the write and exec checks and size checks
> but I don't see what it's referring to, neither in the current nor in
> the old code.

I noticed that, but the VFS may_delete() does those checks, which is this l=
ine:

error =3D inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);

Exactly the same as our btrfs copy.


>
> > -     audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
> > -
> > -     ret =3D inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
> > -     if (ret)
> > -             return ret;
> > -     if (IS_APPEND(dir))
> > -             return -EPERM;
> > -     if (check_sticky(idmap, dir, d_inode(victim)) ||
> > -         IS_APPEND(d_inode(victim)) || IS_IMMUTABLE(d_inode(victim)) |=
|
> > -         IS_SWAPFILE(d_inode(victim)))
> > -             return -EPERM;
> > -     if (isdir) {
> > -             if (!d_is_dir(victim))
> > -                     return -ENOTDIR;
> > -             if (IS_ROOT(victim))
> > -                     return -EBUSY;
> > -     } else if (d_is_dir(victim))
> > -             return -EISDIR;
> > -     if (IS_DEADDIR(dir))
> > -             return -ENOENT;
> > -     if (victim->d_flags & DCACHE_NFSFS_RENAMED)
> > -             return -EBUSY;
> > -     return 0;
> > -}

