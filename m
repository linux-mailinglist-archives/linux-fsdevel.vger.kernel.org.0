Return-Path: <linux-fsdevel+bounces-72220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A0BCE8536
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 00:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87091300CCF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 23:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109272868A7;
	Mon, 29 Dec 2025 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/VwBpl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE5262FFC
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767050917; cv=none; b=P1fPRTLMmCVpRB5UYut8CN2k7Ufs1goaT6Zn78Dd9QLFUBlxVHcZokIaWWTvtdbIazme6RFRREf1OUbcecM5fG2tTRCjWGlMDYQq/ynzaMDyiiAHQSrtwgeNEEJ/K96/92FHYbKc7OpzfoNO3Q9+4QOJlGxFkY3L1eXI+W0PXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767050917; c=relaxed/simple;
	bh=O7P0/NiN2ez0gLQuoL/cSBSfKupfS4v94U/Yb9BVfDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfQazE5ohR8amjPumj/JjOfSgnVhLDSXpwqG+q9ZlzXaUDbz2aC1TWWGU4MWiXt7Rh9gujHnPiVak+ys96JN40maHRMZZfHMakcAvrJCl324la1/7k2HYDKJJJrXdwf3bhARcM6kquv+Kgu4USmXHREVLDqxc6EHBS1Z2sSM0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/VwBpl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429E5C2BC9E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 23:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767050917;
	bh=O7P0/NiN2ez0gLQuoL/cSBSfKupfS4v94U/Yb9BVfDo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q/VwBpl7FrVspn9GWD+JaweoLPWCRpzXliWsA5v2g4IkFcae9nvFSulosnNciql59
	 oGugIcOmCC+hpp5SHZKaqntPltoaV0qggdJBn4YUJHbXnj81SYK6I2HIbG+4hHkR8Z
	 63cm0DUXs9EdTmAfxbek5gPIlmpVKAXv1OqFHj0hl+uCL9gwne9Nq71wpx+yTW9vJ7
	 WHyxGM/AwZ8/TtpxTk4YrDHv8XQedJrx6TbAN4xT6TxYsdjoVZKh1MhN7zDhgrylzN
	 djSh+hX/Yv2tAn7CPu2jOl00RQIcafc4ZWIrHwDTqi7SzKHfoL4hCHYjGBIZluhtFE
	 wexC8oKK8/xsQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7697e8b01aso1746682766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:28:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaZjLXF4EQkYjg7P+EhzH0OOP6vqVUn7TrwJZ7BbBuP0+UcJYkyApN63X0udJr1PbLWiqA7M9Tiod87TVe@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVTb7Y+RCOkUBt+fcIi2t/RU+ccK6pvEtlx2Gaj1oyUA6Ji5q
	V4cT3RkYujm4qVM13zreEGD80WQRstr4gNCWFbu2Pmca9ljHxUh7Gd2iehelL5KyL761Cc/aF+F
	v8ySaRHIX9IR+PxgliFHIcEtFsoQV4Hk=
X-Google-Smtp-Source: AGHT+IFPXEEnJYjqmesOOsO/z1nPs7JXu/6TQc10vq1bsSHaSmSE/pQqOL+vFHbO0mUBzjJ39Tle2uvjmuqOWY+TDkM=
X-Received: by 2002:a17:907:7eaa:b0:b76:d89d:3710 with SMTP id
 a640c23a62f3a-b8036ebbe32mr3498128966b.8.1767050915733; Mon, 29 Dec 2025
 15:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-13-linkinjeon@kernel.org>
 <CAOQ4uxiuPd-6WoE1mLwJ1vBsEVjRQ6oLA=HXQCZ9paOhaFnkoA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiuPd-6WoE1mLwJ1vBsEVjRQ6oLA=HXQCZ9paOhaFnkoA@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Dec 2025 08:28:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8FcPhW=DFqmg657jh--NH0wCJnE_WPhnJ-PALKX9Og7w@mail.gmail.com>
X-Gm-Features: AQt7F2pTY_AOVJbdRg9usgH_gyycoPR0ouz5gZiREirRcdptZsPEL4zg01V4jss
Message-ID: <CAKYAXd8FcPhW=DFqmg657jh--NH0wCJnE_WPhnJ-PALKX9Og7w@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] Revert: ntfs3: serve as alias for the legacy
 ntfs driver
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 12:55=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Mon, Dec 29, 2025 at 1:02=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > ntfs filesystem has been remade and is returning as a new implementatio=
n.
> > ntfs3 no longer needs to be an alias for ntfs.
>
> This is not a clear revert of
> 74871791ffa95 ntfs3: serve as alias for the legacy ntfs driver
Three other ntfs-related patches also needed to be reverted.

1ff2e956608c fs/ntfs3: Redesign legacy ntfs support
9b872cc50daa ntfs3: add legacy ntfs file operations
d55f90e9b243 ntfs3: enforce read-only when used as legacy ntfs driver

I wanted to remove ntfs legacy codes all at once.
>
> So what is it? please include the description in the commit message.
Okay, I will do that.
Thanks!
>
> Thanks,
> Amir.
>
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
> >  fs/ntfs3/Kconfig   |  9 --------
> >  fs/ntfs3/dir.c     |  9 --------
> >  fs/ntfs3/file.c    | 10 ---------
> >  fs/ntfs3/inode.c   | 16 ++++----------
> >  fs/ntfs3/ntfs_fs.h | 11 ----------
> >  fs/ntfs3/super.c   | 52 ----------------------------------------------
> >  6 files changed, 4 insertions(+), 103 deletions(-)
> >
> > diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> > index 7bc31d69f680..cdfdf51e55d7 100644
> > --- a/fs/ntfs3/Kconfig
> > +++ b/fs/ntfs3/Kconfig
> > @@ -46,12 +46,3 @@ config NTFS3_FS_POSIX_ACL
> >           NOTE: this is linux only feature. Windows will ignore these A=
CLs.
> >
> >           If you don't know what Access Control Lists are, say N.
> > -
> > -config NTFS_FS
> > -       tristate "NTFS file system support"
> > -       select NTFS3_FS
> > -       select BUFFER_HEAD
> > -       select NLS
> > -       help
> > -         This config option is here only for backward compatibility. N=
TFS
> > -         filesystem is now handled by the NTFS3 driver.
> > diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
> > index b98e95d6b4d9..fc39e7330365 100644
> > --- a/fs/ntfs3/dir.c
> > +++ b/fs/ntfs3/dir.c
> > @@ -631,13 +631,4 @@ const struct file_operations ntfs_dir_operations =
=3D {
> >         .compat_ioctl   =3D ntfs_compat_ioctl,
> >  #endif
> >  };
> > -
> > -#if IS_ENABLED(CONFIG_NTFS_FS)
> > -const struct file_operations ntfs_legacy_dir_operations =3D {
> > -       .llseek         =3D generic_file_llseek,
> > -       .read           =3D generic_read_dir,
> > -       .iterate_shared =3D ntfs_readdir,
> > -       .open           =3D ntfs_file_open,
> > -};
> > -#endif
> >  // clang-format on
> > diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> > index 2e7b2e566ebe..0faa856fc470 100644
> > --- a/fs/ntfs3/file.c
> > +++ b/fs/ntfs3/file.c
> > @@ -1478,14 +1478,4 @@ const struct file_operations ntfs_file_operation=
s =3D {
> >         .fallocate      =3D ntfs_fallocate,
> >         .release        =3D ntfs_file_release,
> >  };
> > -
> > -#if IS_ENABLED(CONFIG_NTFS_FS)
> > -const struct file_operations ntfs_legacy_file_operations =3D {
> > -       .llseek         =3D generic_file_llseek,
> > -       .read_iter      =3D ntfs_file_read_iter,
> > -       .splice_read    =3D ntfs_file_splice_read,
> > -       .open           =3D ntfs_file_open,
> > -       .release        =3D ntfs_file_release,
> > -};
> > -#endif
> >  // clang-format on
> > diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> > index 0a9ac5efeb67..826840c257d3 100644
> > --- a/fs/ntfs3/inode.c
> > +++ b/fs/ntfs3/inode.c
> > @@ -444,9 +444,7 @@ static struct inode *ntfs_read_mft(struct inode *in=
ode,
> >                  * Usually a hard links to directories are disabled.
> >                  */
> >                 inode->i_op =3D &ntfs_dir_inode_operations;
> > -               inode->i_fop =3D unlikely(is_legacy_ntfs(sb)) ?
> > -                                      &ntfs_legacy_dir_operations :
> > -                                      &ntfs_dir_operations;
> > +               inode->i_fop =3D &ntfs_dir_operations;
> >                 ni->i_valid =3D 0;
> >         } else if (S_ISLNK(mode)) {
> >                 ni->std_fa &=3D ~FILE_ATTRIBUTE_DIRECTORY;
> > @@ -456,9 +454,7 @@ static struct inode *ntfs_read_mft(struct inode *in=
ode,
> >         } else if (S_ISREG(mode)) {
> >                 ni->std_fa &=3D ~FILE_ATTRIBUTE_DIRECTORY;
> >                 inode->i_op =3D &ntfs_file_inode_operations;
> > -               inode->i_fop =3D unlikely(is_legacy_ntfs(sb)) ?
> > -                                      &ntfs_legacy_file_operations :
> > -                                      &ntfs_file_operations;
> > +               inode->i_fop =3D &ntfs_file_operations;
> >                 inode->i_mapping->a_ops =3D is_compressed(ni) ? &ntfs_a=
ops_cmpr :
> >                                                               &ntfs_aop=
s;
> >                 if (ino !=3D MFT_REC_MFT)
> > @@ -1590,9 +1586,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, st=
ruct inode *dir,
> >
> >         if (S_ISDIR(mode)) {
> >                 inode->i_op =3D &ntfs_dir_inode_operations;
> > -               inode->i_fop =3D unlikely(is_legacy_ntfs(sb)) ?
> > -                                      &ntfs_legacy_dir_operations :
> > -                                      &ntfs_dir_operations;
> > +               inode->i_fop =3D &ntfs_dir_operations;
> >         } else if (S_ISLNK(mode)) {
> >                 inode->i_op =3D &ntfs_link_inode_operations;
> >                 inode->i_fop =3D NULL;
> > @@ -1601,9 +1595,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, st=
ruct inode *dir,
> >                 inode_nohighmem(inode);
> >         } else if (S_ISREG(mode)) {
> >                 inode->i_op =3D &ntfs_file_inode_operations;
> > -               inode->i_fop =3D unlikely(is_legacy_ntfs(sb)) ?
> > -                                      &ntfs_legacy_file_operations :
> > -                                      &ntfs_file_operations;
> > +               inode->i_fop =3D &ntfs_file_operations;
> >                 inode->i_mapping->a_ops =3D is_compressed(ni) ? &ntfs_a=
ops_cmpr :
> >                                                               &ntfs_aop=
s;
> >                 init_rwsem(&ni->file.run_lock);
> > diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> > index a4559c9f64e6..326644d23110 100644
> > --- a/fs/ntfs3/ntfs_fs.h
> > +++ b/fs/ntfs3/ntfs_fs.h
> > @@ -501,7 +501,6 @@ struct inode *dir_search_u(struct inode *dir, const=
 struct cpu_str *uni,
> >                            struct ntfs_fnd *fnd);
> >  bool dir_is_empty(struct inode *dir);
> >  extern const struct file_operations ntfs_dir_operations;
> > -extern const struct file_operations ntfs_legacy_dir_operations;
> >
> >  /* Globals from file.c */
> >  int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
> > @@ -516,7 +515,6 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, =
unsigned long arg);
> >  extern const struct inode_operations ntfs_special_inode_operations;
> >  extern const struct inode_operations ntfs_file_inode_operations;
> >  extern const struct file_operations ntfs_file_operations;
> > -extern const struct file_operations ntfs_legacy_file_operations;
> >
> >  /* Globals from frecord.c */
> >  void ni_remove_mi(struct ntfs_inode *ni, struct mft_inode *mi);
> > @@ -1160,13 +1158,4 @@ static inline void le64_sub_cpu(__le64 *var, u64=
 val)
> >         *var =3D cpu_to_le64(le64_to_cpu(*var) - val);
> >  }
> >
> > -#if IS_ENABLED(CONFIG_NTFS_FS)
> > -bool is_legacy_ntfs(struct super_block *sb);
> > -#else
> > -static inline bool is_legacy_ntfs(struct super_block *sb)
> > -{
> > -       return false;
> > -}
> > -#endif
> > -
> >  #endif /* _LINUX_NTFS3_NTFS_FS_H */
> > diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> > index 8b0cf0ed4f72..d6fd14c191a9 100644
> > --- a/fs/ntfs3/super.c
> > +++ b/fs/ntfs3/super.c
> > @@ -415,12 +415,6 @@ static int ntfs_fs_reconfigure(struct fs_context *=
fc)
> >         struct ntfs_mount_options *new_opts =3D fc->fs_private;
> >         int ro_rw;
> >
> > -       /* If ntfs3 is used as legacy ntfs enforce read-only mode. */
> > -       if (is_legacy_ntfs(sb)) {
> > -               fc->sb_flags |=3D SB_RDONLY;
> > -               goto out;
> > -       }
> > -
> >         ro_rw =3D sb_rdonly(sb) && !(fc->sb_flags & SB_RDONLY);
> >         if (ro_rw && (sbi->flags & NTFS_FLAGS_NEED_REPLAY)) {
> >                 errorf(fc,
> > @@ -447,7 +441,6 @@ static int ntfs_fs_reconfigure(struct fs_context *f=
c)
> >                 return -EINVAL;
> >         }
> >
> > -out:
> >         sync_filesystem(sb);
> >         swap(sbi->options, fc->fs_private);
> >
> > @@ -1670,8 +1663,6 @@ static int ntfs_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >
> >         ntfs_create_procdir(sb);
> >
> > -       if (is_legacy_ntfs(sb))
> > -               sb->s_flags |=3D SB_RDONLY;
> >         return 0;
> >
> >  put_inode_out:
> > @@ -1876,47 +1867,6 @@ static struct file_system_type ntfs_fs_type =3D =
{
> >         .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> >  };
> >
> > -#if IS_ENABLED(CONFIG_NTFS_FS)
> > -static int ntfs_legacy_init_fs_context(struct fs_context *fc)
> > -{
> > -       int ret;
> > -
> > -       ret =3D __ntfs_init_fs_context(fc);
> > -       /* If ntfs3 is used as legacy ntfs enforce read-only mode. */
> > -       fc->sb_flags |=3D SB_RDONLY;
> > -       return ret;
> > -}
> > -
> > -static struct file_system_type ntfs_legacy_fs_type =3D {
> > -       .owner                  =3D THIS_MODULE,
> > -       .name                   =3D "ntfs",
> > -       .init_fs_context        =3D ntfs_legacy_init_fs_context,
> > -       .parameters             =3D ntfs_fs_parameters,
> > -       .kill_sb                =3D ntfs3_kill_sb,
> > -       .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> > -};
> > -MODULE_ALIAS_FS("ntfs");
> > -
> > -static inline void register_as_ntfs_legacy(void)
> > -{
> > -       int err =3D register_filesystem(&ntfs_legacy_fs_type);
> > -       if (err)
> > -               pr_warn("ntfs3: Failed to register legacy ntfs filesyst=
em driver: %d\n", err);
> > -}
> > -
> > -static inline void unregister_as_ntfs_legacy(void)
> > -{
> > -       unregister_filesystem(&ntfs_legacy_fs_type);
> > -}
> > -bool is_legacy_ntfs(struct super_block *sb)
> > -{
> > -       return sb->s_type =3D=3D &ntfs_legacy_fs_type;
> > -}
> > -#else
> > -static inline void register_as_ntfs_legacy(void) {}
> > -static inline void unregister_as_ntfs_legacy(void) {}
> > -#endif
> > -
> >  // clang-format on
> >
> >  static int __init init_ntfs_fs(void)
> > @@ -1945,7 +1895,6 @@ static int __init init_ntfs_fs(void)
> >                 goto out1;
> >         }
> >
> > -       register_as_ntfs_legacy();
> >         err =3D register_filesystem(&ntfs_fs_type);
> >         if (err)
> >                 goto out;
> > @@ -1965,7 +1914,6 @@ static void __exit exit_ntfs_fs(void)
> >         rcu_barrier();
> >         kmem_cache_destroy(ntfs_inode_cachep);
> >         unregister_filesystem(&ntfs_fs_type);
> > -       unregister_as_ntfs_legacy();
> >         ntfs3_exit_bitmap();
> >         ntfs_remove_proc_root();
> >  }
> > --
> > 2.25.1
> >

