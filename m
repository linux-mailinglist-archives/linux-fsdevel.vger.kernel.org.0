Return-Path: <linux-fsdevel+bounces-25413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9ED94BC77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCECF282B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73DC18A957;
	Thu,  8 Aug 2024 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyEG7Ztf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12023156220
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117655; cv=none; b=Q3fKxDzYXHX7kDtDB/Lf2HzI7BItZHLMuv9djNZAN1gl8ZJQNfbf4HZVuiTDvof99/Bzm9CDDLjobHS0buUcyf2+ROFl+zLjG2kSsn5qpwR2nTvmVWoo1oScKPX0GOwZ5XpweFwghBbOyn4dNyPDEFdkvVqrcZ5uVyg1HduRm+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117655; c=relaxed/simple;
	bh=d6g3Fir50Jq0x7j3xBuWq8JCGR7bJbf/TQAm9vARoPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjbKxv4/xS3supX5NUJu123APgZsqGmhrNR7eBfoHvv38/LiiunWM3ufEo+Z9AB2HrFAiNLI5Hc4ZhtXFS1gJ9sYK0h9hRgv7viD1jjNDenHsjKJ+KXxjanjCG7l2KjeyKgGudJYsjvlYLtSvRSeph0cPMGBDimpos7CUaDaero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyEG7Ztf; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1dd2004e1so47078885a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723117652; x=1723722452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0QBwBg1F1NWPJ8kaKV7qlA6CjG1KJjRtvWS87jXbQA=;
        b=LyEG7ZtfXXAX0h5Qdt6102yFCRMs6MEAeLtQsbUB8kSfeKdQcWniVj1ultIVZYJ4Bg
         JUKEXoKzRmN7s36A7YxXlxC75Lq0Jv4j7n0V9TnTDqcjJFE1V9QcgO3R4EL5vgT2WA1I
         ZrFIDFl59d/QDBKpE2pbs1LJ9CxLMyZn3HOAqYRSkZ5I5YgMzu/qon/4s8387/CK4h0w
         nqomSWpAU2Yf9mSxctLffLS0N3sJJKLlz8rkkRXBJPQJronHAEfkJ8wN3Ky7nLwpSGTo
         WEBFcLJcHfQWFRv7u8K0qCwbe71JFL4B2r93QjH53kY55UuQX6wG5fYMDgfkaRB0Xllz
         jlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723117652; x=1723722452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0QBwBg1F1NWPJ8kaKV7qlA6CjG1KJjRtvWS87jXbQA=;
        b=gcx0BDIs5OP4ujEVEqb0jtIB8Z4XXv0NlzB6zwc9qIAkzwqOnfKlWYq5fe+hBux+jJ
         2iBu8el07LCVOpShNkQEfXUcej3d43uuV0szWI7L4JPjODHfaOvEYAEEvkZX3lxykJXK
         sHBsFwoFZuXuZA8RufKm0mUI04NTQjXST9sbQSpVRYoX7wPkjo5GiFX2N5WEzibjwcgd
         kTyZSV0dXspNS6eAkoWpiozA9sqEBk+LFP1suBOrQ9jO/5M46AdM5NE0S/8zxzRKc3tT
         X5GId8Cs5KCYPf4lJGnVznFk567heqY+zQ+7fDjnOvNpHS/zuVp7ZK9/Qr13fsyoTBqA
         HD7Q==
X-Gm-Message-State: AOJu0Yx2l9nPIMMS6DiniTZNpWOenMO8gQDbxlq/ZZRCRAe4+WXvHI/l
	LKkSIliez8P84nJxWv4ZHmkhSwASL/b0ki590hX0MhPN/mbraiaN9zloit5ZulBw7lkBG/MPytd
	mFTlGBrlplg+C65jD4Kt2B4x1FY8=
X-Google-Smtp-Source: AGHT+IFKvMkbLMD7n/IRt8WWDDG9+L0SfC7cMpSw+8l0tDDfwvX2H/fKinqN3UEtP/V7KvzTigr236Wi853TaBNk1go=
X-Received: by 2002:a05:620a:4504:b0:7a2:d73:ae9d with SMTP id
 af79cd13be357-7a3818a3eb1mr163274185a.44.1723117651588; Thu, 08 Aug 2024
 04:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807180706.30713-1-jack@suse.cz> <20240807183003.23562-6-jack@suse.cz>
In-Reply-To: <20240807183003.23562-6-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 Aug 2024 13:47:20 +0200
Message-ID: <CAOQ4uxhhzFZy-QBrwhRWubRm75Uw_sx92OZv3gp1bV-MTWwYPA@mail.gmail.com>
Subject: Re: [PATCH 06/13] fs: Drop unnecessary underscore from _SB_I_ constants
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Now that old constants are gone, remove the unnecessary underscore from
> the new _SB_I_ constants. Pure mechanical replacement, no functional
> changes.
>

This is a potential backporting bomb.
It is true that code using the old constant names with new macros
will not build on stable kernels, but I think this is still asking for trou=
ble.

Also, it is a bit strange that SB_* flags are bit masks and SB_I_*
flags are bit numbers.
How about leaving the underscore and using  sb_*_iflag() macros to add
the underscore?

Thanks,
Amir.

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/bdev.c                          |  2 +-
>  drivers/android/binderfs.c            |  4 ++--
>  fs/aio.c                              |  2 +-
>  fs/btrfs/super.c                      |  2 +-
>  fs/devpts/inode.c                     |  2 +-
>  fs/exec.c                             |  2 +-
>  fs/ext2/super.c                       |  2 +-
>  fs/ext4/super.c                       |  2 +-
>  fs/f2fs/super.c                       |  2 +-
>  fs/fuse/inode.c                       |  4 ++--
>  fs/inode.c                            |  2 +-
>  fs/kernfs/mount.c                     |  4 ++--
>  fs/namei.c                            |  2 +-
>  fs/namespace.c                        |  8 ++++----
>  fs/nfs/fs_context.c                   |  2 +-
>  fs/nfs/super.c                        |  2 +-
>  fs/overlayfs/super.c                  |  6 +++---
>  fs/proc/root.c                        |  6 +++---
>  fs/super.c                            | 18 ++++++++---------
>  fs/sync.c                             |  2 +-
>  fs/sysfs/mount.c                      |  2 +-
>  fs/xfs/xfs_super.c                    |  2 +-
>  include/linux/backing-dev.h           |  2 +-
>  include/linux/fs.h                    | 28 +++++++++++++--------------
>  include/linux/namei.h                 |  2 +-
>  ipc/mqueue.c                          |  4 ++--
>  security/integrity/evm/evm_main.c     |  2 +-
>  security/integrity/ima/ima_appraise.c |  4 ++--
>  security/integrity/ima/ima_main.c     |  4 ++--
>  29 files changed, 63 insertions(+), 63 deletions(-)
>
> diff --git a/block/bdev.c b/block/bdev.c
> index c1ea2aeb93dd..6c13ba60c0b1 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -373,7 +373,7 @@ static int bd_init_fs_context(struct fs_context *fc)
>         struct pseudo_fs_context *ctx =3D init_pseudo(fc, BDEVFS_MAGIC);
>         if (!ctx)
>                 return -ENOMEM;
> -       fc->s_iflags |=3D 1 << _SB_I_CGROUPWB;
> +       fc->s_iflags |=3D 1 << SB_I_CGROUPWB;
>         ctx->ops =3D &bdev_sops;
>         return 0;
>  }
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index f9454b93c2f7..6070923fbfbd 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -672,8 +672,8 @@ static int binderfs_fill_super(struct super_block *sb=
, struct fs_context *fc)
>          * allowed to do. So removing the SB_I_NODEV flag from s_iflags i=
s both
>          * necessary and safe.
>          */
> -       sb_clear_iflag(sb, _SB_I_NODEV);
> -       sb_set_iflag(sb, _SB_I_NOEXEC);
> +       sb_clear_iflag(sb, SB_I_NODEV);
> +       sb_set_iflag(sb, SB_I_NOEXEC);
>         sb->s_magic =3D BINDERFS_SUPER_MAGIC;
>         sb->s_op =3D &binderfs_super_ops;
>         sb->s_time_gran =3D 1;
> diff --git a/fs/aio.c b/fs/aio.c
> index 63ce0736c3a3..48d99221ff57 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -279,7 +279,7 @@ static int aio_init_fs_context(struct fs_context *fc)
>  {
>         if (!init_pseudo(fc, AIO_RING_MAGIC))
>                 return -ENOMEM;
> -       fc->s_iflags |=3D 1 << _SB_I_NOEXEC;
> +       fc->s_iflags |=3D 1 << SB_I_NOEXEC;
>         return 0;
>  }
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 321696697279..fb3938ec127c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -950,7 +950,7 @@ static int btrfs_fill_super(struct super_block *sb,
>  #endif
>         sb->s_xattr =3D btrfs_xattr_handlers;
>         sb->s_time_gran =3D 1;
> -       sb_set_iflag(sb, _SB_I_CGROUPWB);
> +       sb_set_iflag(sb, SB_I_CGROUPWB);
>
>         err =3D super_setup_bdi(sb);
>         if (err) {
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index d473156d2791..6094cb7e1a16 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -428,7 +428,7 @@ devpts_fill_super(struct super_block *s, void *data, =
int silent)
>         struct inode *inode;
>         int error;
>
> -       sb_clear_iflag(s, _SB_I_NODEV);
> +       sb_clear_iflag(s, SB_I_NODEV);
>         s->s_blocksize =3D 1024;
>         s->s_blocksize_bits =3D 10;
>         s->s_magic =3D DEVPTS_SUPER_MAGIC;
> diff --git a/fs/exec.c b/fs/exec.c
> index b62b67bea10b..a8bd15aa6bd8 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -112,7 +112,7 @@ static inline void put_binfmt(struct linux_binfmt * f=
mt)
>  bool path_noexec(const struct path *path)
>  {
>         return (path->mnt->mnt_flags & MNT_NOEXEC) ||
> -              sb_test_iflag(path->mnt->mnt_sb, _SB_I_NOEXEC);
> +              sb_test_iflag(path->mnt->mnt_sb, SB_I_NOEXEC);
>  }
>
>  #ifdef CONFIG_USELIB
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 9da8652c10c5..cbe79fb7ac35 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -916,7 +916,7 @@ static int ext2_fill_super(struct super_block *sb, vo=
id *data, int silent)
>
>         sb->s_flags =3D (sb->s_flags & ~SB_POSIXACL) |
>                 (test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
> -       sb_set_iflag(sb, _SB_I_CGROUPWB);
> +       sb_set_iflag(sb, SB_I_CGROUPWB);
>
>         if (le32_to_cpu(es->s_rev_level) =3D=3D EXT2_GOOD_OLD_REV &&
>             (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a776d4e7ec66..b5b2f17f1b65 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4972,7 +4972,7 @@ static int ext4_check_journal_data_mode(struct supe=
r_block *sb)
>                 if (test_opt(sb, DELALLOC))
>                         clear_opt(sb, DELALLOC);
>         } else {
> -               sb_set_iflag(sb, _SB_I_CGROUPWB);
> +               sb_set_iflag(sb, SB_I_CGROUPWB);
>         }
>
>         return 0;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 041b7b7b0810..8437612bf64b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4472,7 +4472,7 @@ static int f2fs_fill_super(struct super_block *sb, =
void *data, int silent)
>                 (test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
>         super_set_uuid(sb, (void *) raw_super->uuid, sizeof(raw_super->uu=
id));
>         super_set_sysfs_name_bdev(sb);
> -       sb_set_iflag(sb, _SB_I_CGROUPWB);
> +       sb_set_iflag(sb, SB_I_CGROUPWB);
>
>         /* init f2fs-specific super block info */
>         sbi->valid_super_block =3D valid_super_block;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3602a578b7b3..5b6254481d5c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1566,9 +1566,9 @@ static void fuse_sb_defaults(struct super_block *sb=
)
>         sb->s_maxbytes =3D MAX_LFS_FILESIZE;
>         sb->s_time_gran =3D 1;
>         sb->s_export_op =3D &fuse_export_operations;
> -       sb_set_iflag(sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE);
> +       sb_set_iflag(sb, SB_I_IMA_UNVERIFIABLE_SIGNATURE);
>         if (sb->s_user_ns !=3D &init_user_ns)
> -               sb_set_iflag(sb, _SB_I_UNTRUSTED_MOUNTER);
> +               sb_set_iflag(sb, SB_I_UNTRUSTED_MOUNTER);
>         sb->s_flags &=3D ~(SB_NOSEC | SB_I_VERSION);
>  }
>
> diff --git a/fs/inode.c b/fs/inode.c
> index a8598a968940..3091385a4de1 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -216,7 +216,7 @@ int inode_init_always(struct super_block *sb, struct =
inode *inode)
>         lockdep_set_class_and_name(&mapping->invalidate_lock,
>                                    &sb->s_type->invalidate_lock_key,
>                                    "mapping.invalidate_lock");
> -       if (sb_test_iflag(sb, _SB_I_STABLE_WRITES))
> +       if (sb_test_iflag(sb, SB_I_STABLE_WRITES))
>                 mapping_set_stable_writes(mapping);
>         inode->i_private =3D NULL;
>         inode->i_mapping =3D mapping;
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index 762edcf5387e..f5331f2e0b2d 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -252,8 +252,8 @@ static int kernfs_fill_super(struct super_block *sb, =
struct kernfs_fs_context *k
>
>         info->sb =3D sb;
>         /* Userspace would break if executables or devices appear on sysf=
s */
> -       sb_set_iflag(sb, _SB_I_NOEXEC);
> -       sb_set_iflag(sb, _SB_I_NODEV);
> +       sb_set_iflag(sb, SB_I_NOEXEC);
> +       sb_set_iflag(sb, SB_I_NODEV);
>         sb->s_blocksize =3D PAGE_SIZE;
>         sb->s_blocksize_bits =3D PAGE_SHIFT;
>         sb->s_magic =3D kfc->magic;
> diff --git a/fs/namei.c b/fs/namei.c
> index de6936564298..9e9bca0566e9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3308,7 +3308,7 @@ EXPORT_SYMBOL(vfs_mkobj);
>  bool may_open_dev(const struct path *path)
>  {
>         return !(path->mnt->mnt_flags & MNT_NODEV) &&
> -               !sb_test_iflag(path->mnt->mnt_sb, _SB_I_NODEV);
> +               !sb_test_iflag(path->mnt->mnt_sb, SB_I_NODEV);
>  }
>
>  static int may_open(struct mnt_idmap *idmap, const struct path *path,
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 17126569b3c4..1c5591673f96 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2919,7 +2919,7 @@ static void mnt_warn_timestamp_expiry(struct path *=
mountpoint, struct vfsmount *
>         struct super_block *sb =3D mnt->mnt_sb;
>
>         if (!__mnt_is_readonly(mnt) &&
> -          !sb_test_iflag(sb, _SB_I_TS_EXPIRY_WARNED) &&
> +          !sb_test_iflag(sb, SB_I_TS_EXPIRY_WARNED) &&
>            (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_m=
ax)) {
>                 char *buf =3D (char *)__get_free_page(GFP_KERNEL);
>                 char *mntpath =3D buf ? d_path(mountpoint, buf, PAGE_SIZE=
) : ERR_PTR(-ENOMEM);
> @@ -2931,7 +2931,7 @@ static void mnt_warn_timestamp_expiry(struct path *=
mountpoint, struct vfsmount *
>                         (unsigned long long)sb->s_time_max);
>
>                 free_page((unsigned long)buf);
> -               sb_set_iflag(sb, _SB_I_TS_EXPIRY_WARNED);
> +               sb_set_iflag(sb, SB_I_TS_EXPIRY_WARNED);
>         }
>  }
>
> @@ -5629,10 +5629,10 @@ static bool mount_too_revealing(const struct supe=
r_block *sb, int *new_mnt_flags
>                 return false;
>
>         /* Can this filesystem be too revealing? */
> -       if (!sb_test_iflag(sb, _SB_I_USERNS_VISIBLE))
> +       if (!sb_test_iflag(sb, SB_I_USERNS_VISIBLE))
>                 return false;
>
> -       if (!sb_test_iflag(sb, _SB_I_NOEXEC) || !sb_test_iflag(sb, _SB_I_=
NODEV)) {
> +       if (!sb_test_iflag(sb, SB_I_NOEXEC) || !sb_test_iflag(sb, SB_I_NO=
DEV)) {
>                 WARN_ONCE(1, "Expected s_iflags to contain SB_I_NOEXEC an=
d "
>                           "SB_I_NODEV\n");
>                 return true;
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 2fbae7e2b6ce..52fc52b6350f 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -1643,7 +1643,7 @@ static int nfs_init_fs_context(struct fs_context *f=
c)
>                 ctx->xprtsec.cert_serial        =3D TLS_NO_CERT;
>                 ctx->xprtsec.privkey_serial     =3D TLS_NO_PRIVKEY;
>
> -               fc->s_iflags            |=3D 1 << _SB_I_STABLE_WRITES;
> +               fc->s_iflags            |=3D 1 << SB_I_STABLE_WRITES;
>         }
>         fc->fs_private =3D ctx;
>         fc->ops =3D &nfs_fs_context_ops;
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index b6b806fb6286..246ecceda7c8 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1094,7 +1094,7 @@ static void nfs_fill_super(struct super_block *sb, =
struct nfs_fs_context *ctx)
>                 sb->s_export_op =3D &nfs_export_ops;
>                 break;
>         case 4:
> -               sb_set_iflag(sb, _SB_I_NOUMASK);
> +               sb_set_iflag(sb, SB_I_NOUMASK);
>                 sb->s_time_gran =3D 1;
>                 sb->s_time_min =3D S64_MIN;
>                 sb->s_time_max =3D S64_MAX;
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index afa5263ff016..f5a60d0bcb1c 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1453,14 +1453,14 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>  #ifdef CONFIG_FS_POSIX_ACL
>         sb->s_flags |=3D SB_POSIXACL;
>  #endif
> -       sb_set_iflag(sb, _SB_I_SKIP_SYNC);
> +       sb_set_iflag(sb, SB_I_SKIP_SYNC);
>         /*
>          * Ensure that umask handling is done by the filesystems used
>          * for the the upper layer instead of overlayfs as that would
>          * lead to unexpected results.
>          */
> -       sb_set_iflag(sb, _SB_I_NOUMASK);
> -       sb_set_iflag(sb, _SB_I_EVM_HMAC_UNSUPPORTED);
> +       sb_set_iflag(sb, SB_I_NOUMASK);
> +       sb_set_iflag(sb, SB_I_EVM_HMAC_UNSUPPORTED);
>
>         err =3D -ENOMEM;
>         root_dentry =3D ovl_get_root(sb, ctx->upper.dentry, oe);
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index ac78ec69dde9..7acfa535b925 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -171,9 +171,9 @@ static int proc_fill_super(struct super_block *s, str=
uct fs_context *fc)
>         proc_apply_options(fs_info, fc, current_user_ns());
>
>         /* User space would break if executables or devices appear on pro=
c */
> -       sb_set_iflag(s, _SB_I_USERNS_VISIBLE);
> -       sb_set_iflag(s, _SB_I_NOEXEC);
> -       sb_set_iflag(s, _SB_I_NODEV);
> +       sb_set_iflag(s, SB_I_USERNS_VISIBLE);
> +       sb_set_iflag(s, SB_I_NOEXEC);
> +       sb_set_iflag(s, SB_I_NODEV);
>         s->s_flags |=3D SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
>         s->s_blocksize =3D 1024;
>         s->s_blocksize_bits =3D 10;
> diff --git a/fs/super.c b/fs/super.c
> index e3020b3db4f0..873808245d54 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -355,7 +355,7 @@ static struct super_block *alloc_super(struct file_sy=
stem_type *type, int flags,
>         s->s_bdi =3D &noop_backing_dev_info;
>         s->s_flags =3D flags;
>         if (s->s_user_ns !=3D &init_user_ns)
> -               sb_set_iflag(s, _SB_I_NODEV);
> +               sb_set_iflag(s, SB_I_NODEV);
>         INIT_HLIST_NODE(&s->s_instances);
>         INIT_HLIST_BL_HEAD(&s->s_roots);
>         mutex_init(&s->s_sync_lock);
> @@ -589,11 +589,11 @@ void retire_super(struct super_block *sb)
>  {
>         WARN_ON(!sb->s_bdev);
>         __super_lock_excl(sb);
> -       if (sb_test_iflag(sb, _SB_I_PERSB_BDI)) {
> +       if (sb_test_iflag(sb, SB_I_PERSB_BDI)) {
>                 bdi_unregister(sb->s_bdi);
> -               sb_clear_iflag(sb, _SB_I_PERSB_BDI);
> +               sb_clear_iflag(sb, SB_I_PERSB_BDI);
>         }
> -       sb_set_iflag(sb, _SB_I_RETIRED);
> +       sb_set_iflag(sb, SB_I_RETIRED);
>         super_unlock_excl(sb);
>  }
>  EXPORT_SYMBOL(retire_super);
> @@ -678,7 +678,7 @@ void generic_shutdown_super(struct super_block *sb)
>         super_wake(sb, SB_DYING);
>         super_unlock_excl(sb);
>         if (sb->s_bdi !=3D &noop_backing_dev_info) {
> -               if (sb_test_iflag(sb, _SB_I_PERSB_BDI))
> +               if (sb_test_iflag(sb, SB_I_PERSB_BDI))
>                         bdi_unregister(sb->s_bdi);
>                 bdi_put(sb->s_bdi);
>                 sb->s_bdi =3D &noop_backing_dev_info;
> @@ -1331,7 +1331,7 @@ static int super_s_dev_set(struct super_block *s, s=
truct fs_context *fc)
>
>  static int super_s_dev_test(struct super_block *s, struct fs_context *fc=
)
>  {
> -       return !sb_test_iflag(s, _SB_I_RETIRED) &&
> +       return !sb_test_iflag(s, SB_I_RETIRED) &&
>                 s->s_dev =3D=3D *(dev_t *)fc->sget_key;
>  }
>
> @@ -1584,7 +1584,7 @@ int setup_bdev_super(struct super_block *sb, int sb=
_flags,
>         sb->s_bdev =3D bdev;
>         sb->s_bdi =3D bdi_get(bdev->bd_disk->bdi);
>         if (bdev_stable_writes(bdev))
> -               sb_set_iflag(sb, _SB_I_STABLE_WRITES);
> +               sb_set_iflag(sb, SB_I_STABLE_WRITES);
>         spin_unlock(&sb_lock);
>
>         snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
> @@ -1648,7 +1648,7 @@ EXPORT_SYMBOL(get_tree_bdev);
>
>  static int test_bdev_super(struct super_block *s, void *data)
>  {
> -       return !sb_test_iflag(s, _SB_I_RETIRED) && s->s_dev =3D=3D *(dev_=
t *)data;
> +       return !sb_test_iflag(s, SB_I_RETIRED) && s->s_dev =3D=3D *(dev_t=
 *)data;
>  }
>
>  struct dentry *mount_bdev(struct file_system_type *fs_type,
> @@ -1864,7 +1864,7 @@ int super_setup_bdi_name(struct super_block *sb, ch=
ar *fmt, ...)
>         }
>         WARN_ON(sb->s_bdi !=3D &noop_backing_dev_info);
>         sb->s_bdi =3D bdi;
> -       sb_set_iflag(sb, _SB_I_PERSB_BDI);
> +       sb_set_iflag(sb, SB_I_PERSB_BDI);
>
>         return 0;
>  }
> diff --git a/fs/sync.c b/fs/sync.c
> index 4e5ad48316be..a7c0645aa9dc 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -79,7 +79,7 @@ static void sync_inodes_one_sb(struct super_block *sb, =
void *arg)
>
>  static void sync_fs_one_sb(struct super_block *sb, void *arg)
>  {
> -       if (!sb_rdonly(sb) && !sb_test_iflag(sb, _SB_I_SKIP_SYNC) &&
> +       if (!sb_rdonly(sb) && !sb_test_iflag(sb, SB_I_SKIP_SYNC) &&
>             sb->s_op->sync_fs)
>                 sb->s_op->sync_fs(sb, *(int *)arg);
>  }
> diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
> index 124385961da7..b461c216731a 100644
> --- a/fs/sysfs/mount.c
> +++ b/fs/sysfs/mount.c
> @@ -33,7 +33,7 @@ static int sysfs_get_tree(struct fs_context *fc)
>                 return ret;
>
>         if (kfc->new_sb_created)
> -               sb_set_iflag(fc->root->d_sb, _SB_I_USERNS_VISIBLE);
> +               sb_set_iflag(fc->root->d_sb, SB_I_USERNS_VISIBLE);
>         return 0;
>  }
>
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 7707f2a1a836..0020724e3b0a 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1701,7 +1701,7 @@ xfs_fs_fill_super(
>                 sb->s_time_max =3D XFS_LEGACY_TIME_MAX;
>         }
>         trace_xfs_inode_timestamp_range(mp, sb->s_time_min, sb->s_time_ma=
x);
> -       sb_set_iflag(sb, _SB_I_CGROUPWB);
> +       sb_set_iflag(sb, SB_I_CGROUPWB);
>
>         set_posix_acl_flag(sb);
>
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 54fdae7b1be4..bc5f96ba499e 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -176,7 +176,7 @@ static inline bool inode_cgwb_enabled(struct inode *i=
node)
>         return cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
>                 cgroup_subsys_on_dfl(io_cgrp_subsys) &&
>                 (bdi->capabilities & BDI_CAP_WRITEBACK) &&
> -               sb_test_iflag(inode->i_sb, _SB_I_CGROUPWB);
> +               sb_test_iflag(inode->i_sb, SB_I_CGROUPWB);
>  }
>
>  /**
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 65e70ceb335e..52841aab13fb 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1174,22 +1174,22 @@ extern int send_sigurg(struct fown_struct *fown);
>
>  /* sb->s_iflags */
>  enum {
> -       _SB_I_CGROUPWB,         /* cgroup-aware writeback enabled */
> -       _SB_I_NOEXEC,           /* Ignore executables on this fs */
> -       _SB_I_NODEV,            /* Ignore devices on this fs */
> -       _SB_I_STABLE_WRITES,    /* don't modify blks until WB is done */
> +       SB_I_CGROUPWB,          /* cgroup-aware writeback enabled */
> +       SB_I_NOEXEC,            /* Ignore executables on this fs */
> +       SB_I_NODEV,             /* Ignore devices on this fs */
> +       SB_I_STABLE_WRITES,     /* don't modify blks until WB is done */
>
>         /* sb->s_iflags to limit user namespace mounts */
> -       _SB_I_USERNS_VISIBLE,   /* fstype already mounted */
> -       _SB_I_IMA_UNVERIFIABLE_SIGNATURE,
> -       _SB_I_UNTRUSTED_MOUNTER,
> -       _SB_I_EVM_HMAC_UNSUPPORTED,
> -
> -       _SB_I_SKIP_SYNC,        /* Skip superblock at global sync */
> -       _SB_I_PERSB_BDI,        /* has a per-sb bdi */
> -       _SB_I_TS_EXPIRY_WARNED, /* warned about timestamp range expiry */
> -       _SB_I_RETIRED,          /* superblock shouldn't be reused */
> -       _SB_I_NOUMASK,          /* VFS does not apply umask */
> +       SB_I_USERNS_VISIBLE,    /* fstype already mounted */
> +       SB_I_IMA_UNVERIFIABLE_SIGNATURE,
> +       SB_I_UNTRUSTED_MOUNTER,
> +       SB_I_EVM_HMAC_UNSUPPORTED,
> +
> +       SB_I_SKIP_SYNC, /* Skip superblock at global sync */
> +       SB_I_PERSB_BDI, /* has a per-sb bdi */
> +       SB_I_TS_EXPIRY_WARNED,  /* warned about timestamp range expiry */
> +       SB_I_RETIRED,           /* superblock shouldn't be reused */
> +       SB_I_NOUMASK,           /* VFS does not apply umask */
>  };
>
>  /* Possible states of 'frozen' field */
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 3fbf340dac1a..0bd6db9adb7f 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -107,7 +107,7 @@ extern void unlock_rename(struct dentry *, struct den=
try *);
>   */
>  static inline umode_t __must_check mode_strip_umask(const struct inode *=
dir, umode_t mode)
>  {
> -       if (!IS_POSIXACL(dir) && !sb_test_iflag(dir->i_sb, _SB_I_NOUMASK)=
)
> +       if (!IS_POSIXACL(dir) && !sb_test_iflag(dir->i_sb, SB_I_NOUMASK))
>                 mode &=3D ~current_umask();
>         return mode;
>  }
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index e73fff4c2f12..abe4dfe4374c 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -406,8 +406,8 @@ static int mqueue_fill_super(struct super_block *sb, =
struct fs_context *fc)
>         struct inode *inode;
>         struct ipc_namespace *ns =3D sb->s_fs_info;
>
> -       sb_set_iflag(sb, _SB_I_NOEXEC);
> -       sb_set_iflag(sb, _SB_I_NODEV);
> +       sb_set_iflag(sb, SB_I_NOEXEC);
> +       sb_set_iflag(sb, SB_I_NODEV);
>         sb->s_blocksize =3D PAGE_SIZE;
>         sb->s_blocksize_bits =3D PAGE_SHIFT;
>         sb->s_magic =3D MQUEUE_MAGIC;
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 3ff29bf73f04..a15a87250d55 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -155,7 +155,7 @@ static int is_unsupported_hmac_fs(struct dentry *dent=
ry)
>  {
>         struct inode *inode =3D d_backing_inode(dentry);
>
> -       if (sb_test_iflag(inode->i_sb, _SB_I_EVM_HMAC_UNSUPPORTED)) {
> +       if (sb_test_iflag(inode->i_sb, SB_I_EVM_HMAC_UNSUPPORTED)) {
>                 pr_info_once("%s not supported\n", inode->i_sb->s_type->n=
ame);
>                 return 1;
>         }
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index 9c290dd8a4ac..dfa16dba5d89 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -564,8 +564,8 @@ int ima_appraise_measurement(enum ima_hooks func, str=
uct ima_iint_cache *iint,
>          * system not willing to accept such a risk, fail the file signat=
ure
>          * verification.
>          */
> -       if (sb_test_iflag(inode->i_sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE) =
&&
> -           (sb_test_iflag(inode->i_sb, _SB_I_UNTRUSTED_MOUNTER) ||
> +       if (sb_test_iflag(inode->i_sb, SB_I_IMA_UNVERIFIABLE_SIGNATURE) &=
&
> +           (sb_test_iflag(inode->i_sb, SB_I_UNTRUSTED_MOUNTER) ||
>              (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
>                 status =3D INTEGRITY_FAIL;
>                 cause =3D "unverifiable-signature";
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index b04eaa33eca4..27d446136c4f 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -280,8 +280,8 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>          * (Limited to privileged mounted filesystems.)
>          */
>         if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
> -           (sb_test_iflag(inode->i_sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE)=
 &&
> -            !sb_test_iflag(inode->i_sb, _SB_I_UNTRUSTED_MOUNTER) &&
> +           (sb_test_iflag(inode->i_sb, SB_I_IMA_UNVERIFIABLE_SIGNATURE) =
&&
> +            !sb_test_iflag(inode->i_sb, SB_I_UNTRUSTED_MOUNTER) &&
>              !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
>                 iint->flags &=3D ~IMA_DONE_MASK;
>                 iint->measured_pcrs =3D 0;
> --
> 2.35.3
>
>

