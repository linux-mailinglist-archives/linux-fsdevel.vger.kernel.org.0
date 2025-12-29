Return-Path: <linux-fsdevel+bounces-72197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E084FCE7442
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 574103018196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F032BF21;
	Mon, 29 Dec 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmgyBX/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33B261B9F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023742; cv=none; b=SGkZXiwEWfoEBda14cCokHk7K8fvBHByNJYyuRHIrcyqRK1KOka2o8LHVPvdzwTrqHTbhkHHogELvLlT/DQWNDDaG0ZwaEn/79bJMmNj9ThUEajddwx0qGsuWPg19YKyJ2XwJBtYvCQyLXjOpbN/oNr9WeFK3qBZMq+VMr2PxTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023742; c=relaxed/simple;
	bh=Hn4RE9vSee2e//aqxtNJWt29fEzMCncRCRLsABavSRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBGnIC6EEsPdZi06O59Uv2AscMnf98cE2qkGJT3p/M68qGet2XCmJ3QpNKULRjTjq/Chn1bi6X9aGVcjBorsqRGA3R8DeQ1MGK+cMgC9ErnDXmdu+SwzHMgL7spxBQoSCzBWZNby049fZcx1fbugosPGj/eHl3pl8Nk+OiAeR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmgyBX/j; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so10720978a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767023738; x=1767628538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFacW+aZgFaz3SNLMYBJDlTHoo+hCwA5RtBQsXcV6TU=;
        b=OmgyBX/j3KJU4PJkf8Y5dR+HzECjAlV5JP/TBcmmrUt4VPlKNSjEd7TRej/HL8qtyR
         rFeLomC8Ff63UeQhEOu/csHzDEauMJyd4H0prQX1E6xWcfSxfr9ovOTlN+++cEAStSNZ
         Fo8UOwPBFET9Zs2t+aNNwZCA2bLT9fUBAKH2GY2k2pfLNbD15ewb8F7PtwVexgnE8sFj
         hjWnoMDDzdjz+SCRidNBI+ql7PZOS9dWeZP+0C9xE0tLBDdqC6+X/5jInrJdiN19vz57
         iCsyy5ZUTgxA3UgwkzLdEfbi+dAfXwlvjkKjqduR3WT/bkqLZ6Nil/wXnfLwegXzu20w
         foOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767023738; x=1767628538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JFacW+aZgFaz3SNLMYBJDlTHoo+hCwA5RtBQsXcV6TU=;
        b=GybOJsTeR0nbXbeWOSliGSunhIe3krfQBvCXREsgLeva0qbx3Cmnm/t3S+DjISNn2h
         aqRk25m6mQQU/6VgmjvP1rHaoQReC02LhnIc8cf4z3i+PHnZPfxh8gpQ45HykbFoGbm+
         I9yW0+gSOXgYf/XEXh25s2Jn8a1HjIRsyREpz/sJVaZ65dHHHpzpT0bValVDjBRKq+M2
         F9QTEpog9UpfP7r2UFx6g5FQAELOKMA00GgZ4+pkVMOMcn4xXcTMWxD/qgfmTv6QJhdU
         HA3zUiEHcWDR0OQ7VdStbsmMjt4UNbtmEq6zBrPbPQswUtNihybTyBTrhBHThTjGh8tY
         YLsw==
X-Forwarded-Encrypted: i=1; AJvYcCUgkMb54iRWuumC2vcBzW2iipDlP7JIm1p+Pa35fJSbYsdzBYHX+tTA8vepSLpZfjWpIBuEIbH9H76J4MBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJr6KJ6yZJhfWd1z94Mn14dI1K3QEhLZW/eH9Ifb7x7rtECvr
	9TqkKZ5fCc6cTmZHoHDyYwM2oaNX/Vaefbsu9JkDACb1iuech8WQUOudKzTNbbj9MWYeIFBw4Yk
	n7XerHF6Tf38MG2sx1hF+5c+Dg8Ae714=
X-Gm-Gg: AY/fxX6B3H38mNsVcQJXWqOxYYe+6w7fQ/sq/I8561p5mxMac+oq1NzgbyBQDIXgzuE
	IMe4GcO0NXZ70lbJcogPb+XH5IYZdPeush4MP3mvHZdffQJ1lqEJ5ScBMY1aY1HHjN1/hyrg2Ea
	K3tdMXlL88+byi50jgJKn8vAiXzqorIcWk6rD/MTAqpZh4GbNlEG4NwCD6ceD5ifZ7aCiBIuK8/
	4MaN25T0lOpJYTNPXQ3z48EB5B0VJ1m5SgAyXZa5F6QbZO7dmNJ0G06B4PT9C23tjfmRCDS8vD9
	4+yIauwDe1oNH3SEVjZUZFbRU3jbrz4JTrgKWxoV
X-Google-Smtp-Source: AGHT+IFKeHEeJiPnGAftkvYi0Q2ZNI9zvkxqRcbsEQU3hkl9dyUZQhVTl+j4ayZSssVZ2z/2rak+tsEcH9mTJVJHwvI=
X-Received: by 2002:a05:6402:440c:b0:64e:f50d:ec9a with SMTP id
 4fb4d7f45d1cf-64ef50deebcmr1452412a12.30.1767023738191; Mon, 29 Dec 2025
 07:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-13-linkinjeon@kernel.org>
In-Reply-To: <20251229105932.11360-13-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Dec 2025 17:55:27 +0200
X-Gm-Features: AQt7F2rxT_PrrBT6xtizBQaV_zXrkrLGCEHZCBixOVeGlmqMJXp9Y0BRDMiwEGg
Message-ID: <CAOQ4uxiuPd-6WoE1mLwJ1vBsEVjRQ6oLA=HXQCZ9paOhaFnkoA@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] Revert: ntfs3: serve as alias for the legacy
 ntfs driver
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 1:02=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> ntfs filesystem has been remade and is returning as a new implementation.
> ntfs3 no longer needs to be an alias for ntfs.

This is not a clear revert of
74871791ffa95 ntfs3: serve as alias for the legacy ntfs driver

So what is it? please include the description in the commit message.

Thanks,
Amir.

>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/ntfs3/Kconfig   |  9 --------
>  fs/ntfs3/dir.c     |  9 --------
>  fs/ntfs3/file.c    | 10 ---------
>  fs/ntfs3/inode.c   | 16 ++++----------
>  fs/ntfs3/ntfs_fs.h | 11 ----------
>  fs/ntfs3/super.c   | 52 ----------------------------------------------
>  6 files changed, 4 insertions(+), 103 deletions(-)
>
> diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> index 7bc31d69f680..cdfdf51e55d7 100644
> --- a/fs/ntfs3/Kconfig
> +++ b/fs/ntfs3/Kconfig
> @@ -46,12 +46,3 @@ config NTFS3_FS_POSIX_ACL
>           NOTE: this is linux only feature. Windows will ignore these ACL=
s.
>
>           If you don't know what Access Control Lists are, say N.
> -
> -config NTFS_FS
> -       tristate "NTFS file system support"
> -       select NTFS3_FS
> -       select BUFFER_HEAD
> -       select NLS
> -       help
> -         This config option is here only for backward compatibility. NTF=
S
> -         filesystem is now handled by the NTFS3 driver.
> diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
> index b98e95d6b4d9..fc39e7330365 100644
> --- a/fs/ntfs3/dir.c
> +++ b/fs/ntfs3/dir.c
> @@ -631,13 +631,4 @@ const struct file_operations ntfs_dir_operations =3D=
 {
>         .compat_ioctl   =3D ntfs_compat_ioctl,
>  #endif
>  };
> -
> -#if IS_ENABLED(CONFIG_NTFS_FS)
> -const struct file_operations ntfs_legacy_dir_operations =3D {
> -       .llseek         =3D generic_file_llseek,
> -       .read           =3D generic_read_dir,
> -       .iterate_shared =3D ntfs_readdir,
> -       .open           =3D ntfs_file_open,
> -};
> -#endif
>  // clang-format on
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 2e7b2e566ebe..0faa856fc470 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -1478,14 +1478,4 @@ const struct file_operations ntfs_file_operations =
=3D {
>         .fallocate      =3D ntfs_fallocate,
>         .release        =3D ntfs_file_release,
>  };
> -
> -#if IS_ENABLED(CONFIG_NTFS_FS)
> -const struct file_operations ntfs_legacy_file_operations =3D {
> -       .llseek         =3D generic_file_llseek,
> -       .read_iter      =3D ntfs_file_read_iter,
> -       .splice_read    =3D ntfs_file_splice_read,
> -       .open           =3D ntfs_file_open,
> -       .release        =3D ntfs_file_release,
> -};
> -#endif
>  // clang-format on
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 0a9ac5efeb67..826840c257d3 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -444,9 +444,7 @@ static struct inode *ntfs_read_mft(struct inode *inod=
e,
>                  * Usually a hard links to directories are disabled.
>                  */
>                 inode->i_op =3D &ntfs_dir_inode_operations;
> -               inode->i_fop =3D unlikely(is_legacy_ntfs(sb)) ?
> -                                      &ntfs_legacy_dir_operations :
> -                                      &ntfs_dir_operations;
> +               inode->i_fop =3D &ntfs_dir_operations;
>                 ni->i_valid =3D 0;
>         } else if (S_ISLNK(mode)) {
>                 ni->std_fa &=3D ~FILE_ATTRIBUTE_DIRECTORY;
> @@ -456,9 +454,7 @@ static struct inode *ntfs_read_mft(struct inode *inod=
e,
>         } else if (S_ISREG(mode)) {
>                 ni->std_fa &=3D ~FILE_ATTRIBUTE_DIRECTORY;
>                 inode->i_op =3D &ntfs_file_inode_operations;
> -               inode->i_fop =3D unlikely(is_legacy_ntfs(sb)) ?
> -                                      &ntfs_legacy_file_operations :
> -                                      &ntfs_file_operations;
> +               inode->i_fop =3D &ntfs_file_operations;
>                 inode->i_mapping->a_ops =3D is_compressed(ni) ? &ntfs_aop=
s_cmpr :
>                                                               &ntfs_aops;
>                 if (ino !=3D MFT_REC_MFT)
> @@ -1590,9 +1586,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, stru=
ct inode *dir,
>
>         if (S_ISDIR(mode)) {
>                 inode->i_op =3D &ntfs_dir_inode_operations;
> -               inode->i_fop =3D unlikely(is_legacy_ntfs(sb)) ?
> -                                      &ntfs_legacy_dir_operations :
> -                                      &ntfs_dir_operations;
> +               inode->i_fop =3D &ntfs_dir_operations;
>         } else if (S_ISLNK(mode)) {
>                 inode->i_op =3D &ntfs_link_inode_operations;
>                 inode->i_fop =3D NULL;
> @@ -1601,9 +1595,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, stru=
ct inode *dir,
>                 inode_nohighmem(inode);
>         } else if (S_ISREG(mode)) {
>                 inode->i_op =3D &ntfs_file_inode_operations;
> -               inode->i_fop =3D unlikely(is_legacy_ntfs(sb)) ?
> -                                      &ntfs_legacy_file_operations :
> -                                      &ntfs_file_operations;
> +               inode->i_fop =3D &ntfs_file_operations;
>                 inode->i_mapping->a_ops =3D is_compressed(ni) ? &ntfs_aop=
s_cmpr :
>                                                               &ntfs_aops;
>                 init_rwsem(&ni->file.run_lock);
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index a4559c9f64e6..326644d23110 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -501,7 +501,6 @@ struct inode *dir_search_u(struct inode *dir, const s=
truct cpu_str *uni,
>                            struct ntfs_fnd *fnd);
>  bool dir_is_empty(struct inode *dir);
>  extern const struct file_operations ntfs_dir_operations;
> -extern const struct file_operations ntfs_legacy_dir_operations;
>
>  /* Globals from file.c */
>  int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
> @@ -516,7 +515,6 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, un=
signed long arg);
>  extern const struct inode_operations ntfs_special_inode_operations;
>  extern const struct inode_operations ntfs_file_inode_operations;
>  extern const struct file_operations ntfs_file_operations;
> -extern const struct file_operations ntfs_legacy_file_operations;
>
>  /* Globals from frecord.c */
>  void ni_remove_mi(struct ntfs_inode *ni, struct mft_inode *mi);
> @@ -1160,13 +1158,4 @@ static inline void le64_sub_cpu(__le64 *var, u64 v=
al)
>         *var =3D cpu_to_le64(le64_to_cpu(*var) - val);
>  }
>
> -#if IS_ENABLED(CONFIG_NTFS_FS)
> -bool is_legacy_ntfs(struct super_block *sb);
> -#else
> -static inline bool is_legacy_ntfs(struct super_block *sb)
> -{
> -       return false;
> -}
> -#endif
> -
>  #endif /* _LINUX_NTFS3_NTFS_FS_H */
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 8b0cf0ed4f72..d6fd14c191a9 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -415,12 +415,6 @@ static int ntfs_fs_reconfigure(struct fs_context *fc=
)
>         struct ntfs_mount_options *new_opts =3D fc->fs_private;
>         int ro_rw;
>
> -       /* If ntfs3 is used as legacy ntfs enforce read-only mode. */
> -       if (is_legacy_ntfs(sb)) {
> -               fc->sb_flags |=3D SB_RDONLY;
> -               goto out;
> -       }
> -
>         ro_rw =3D sb_rdonly(sb) && !(fc->sb_flags & SB_RDONLY);
>         if (ro_rw && (sbi->flags & NTFS_FLAGS_NEED_REPLAY)) {
>                 errorf(fc,
> @@ -447,7 +441,6 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
>                 return -EINVAL;
>         }
>
> -out:
>         sync_filesystem(sb);
>         swap(sbi->options, fc->fs_private);
>
> @@ -1670,8 +1663,6 @@ static int ntfs_fill_super(struct super_block *sb, =
struct fs_context *fc)
>
>         ntfs_create_procdir(sb);
>
> -       if (is_legacy_ntfs(sb))
> -               sb->s_flags |=3D SB_RDONLY;
>         return 0;
>
>  put_inode_out:
> @@ -1876,47 +1867,6 @@ static struct file_system_type ntfs_fs_type =3D {
>         .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
>  };
>
> -#if IS_ENABLED(CONFIG_NTFS_FS)
> -static int ntfs_legacy_init_fs_context(struct fs_context *fc)
> -{
> -       int ret;
> -
> -       ret =3D __ntfs_init_fs_context(fc);
> -       /* If ntfs3 is used as legacy ntfs enforce read-only mode. */
> -       fc->sb_flags |=3D SB_RDONLY;
> -       return ret;
> -}
> -
> -static struct file_system_type ntfs_legacy_fs_type =3D {
> -       .owner                  =3D THIS_MODULE,
> -       .name                   =3D "ntfs",
> -       .init_fs_context        =3D ntfs_legacy_init_fs_context,
> -       .parameters             =3D ntfs_fs_parameters,
> -       .kill_sb                =3D ntfs3_kill_sb,
> -       .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> -};
> -MODULE_ALIAS_FS("ntfs");
> -
> -static inline void register_as_ntfs_legacy(void)
> -{
> -       int err =3D register_filesystem(&ntfs_legacy_fs_type);
> -       if (err)
> -               pr_warn("ntfs3: Failed to register legacy ntfs filesystem=
 driver: %d\n", err);
> -}
> -
> -static inline void unregister_as_ntfs_legacy(void)
> -{
> -       unregister_filesystem(&ntfs_legacy_fs_type);
> -}
> -bool is_legacy_ntfs(struct super_block *sb)
> -{
> -       return sb->s_type =3D=3D &ntfs_legacy_fs_type;
> -}
> -#else
> -static inline void register_as_ntfs_legacy(void) {}
> -static inline void unregister_as_ntfs_legacy(void) {}
> -#endif
> -
>  // clang-format on
>
>  static int __init init_ntfs_fs(void)
> @@ -1945,7 +1895,6 @@ static int __init init_ntfs_fs(void)
>                 goto out1;
>         }
>
> -       register_as_ntfs_legacy();
>         err =3D register_filesystem(&ntfs_fs_type);
>         if (err)
>                 goto out;
> @@ -1965,7 +1914,6 @@ static void __exit exit_ntfs_fs(void)
>         rcu_barrier();
>         kmem_cache_destroy(ntfs_inode_cachep);
>         unregister_filesystem(&ntfs_fs_type);
> -       unregister_as_ntfs_legacy();
>         ntfs3_exit_bitmap();
>         ntfs_remove_proc_root();
>  }
> --
> 2.25.1
>

