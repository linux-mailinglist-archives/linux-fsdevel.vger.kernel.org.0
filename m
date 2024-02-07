Return-Path: <linux-fsdevel+bounces-10568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA884C513
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 07:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7F42849B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8261CD30;
	Wed,  7 Feb 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CATlJpE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0214A85;
	Wed,  7 Feb 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288094; cv=none; b=nC/5L8hbXsX4Y4+1FzpZXKW9XJ9NIsvLY/v2RwN+G/EvAqNQJ6PiPxuvnKjvkBd3g8H8AgAky4dortX7E3OwzeMNvPb/FwkQ3zjSdiU9qu8TGU0m0zBQ8MTyOinQXfCYAHTlZmevTk6JTDMqBJ78fbQyG7AivmAkfZfjEyBrpSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288094; c=relaxed/simple;
	bh=xRn/DhWNvjEAxJbEcMbkLvBH6IdKsaz49Axd2G8pHWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQ2p6JLFd6iS6XNL7SYTBW0Kzvb1r0mpbfpF+6pxs1f7pjqHnk79ECuyySiEdu7l4ZeKhQ9vjWfGGFNKnx4BCUoi61VVThrTFVpgvrkQPeH7kzEG6O1VTu7QRc8SkAtLqNFb/lqpdDZS8H0u5ZMGCQWWRXhm2N9dXssu3qXPXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CATlJpE8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68c8d3c445fso1447856d6.1;
        Tue, 06 Feb 2024 22:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707288091; x=1707892891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxxVVXToZdIUBGMbsph8ZPdjTKMow+DtFhTgLD0SlYU=;
        b=CATlJpE8m3S7qWRuVmNYUmBRNeJe1Tqz97b8QA3mdvZSHm9jhzoSwYqFgjtTKA8KbT
         KCkmuC/X10JZpBHCnY/s73chHC49RnTx53Xllw/u/VCIJGUjiam8hn0WDdbBy6VPBP/8
         FG4UYFYwpbsFs+9xLmjDvJvgWd2tXCfQJKsKOXnFJitKeoLLqRIWVTuewMNOBH14wjKO
         MB9CSdOj0rV5itEgKHPFrE3WknYgkPfvsdRtMwmN5AHFC1ytSX3JE8BN5IYzDDLFVcN6
         15cJN3Z4B3NCgu3WQYTUdI8MJHROuMjfMVFK8hpsPj56PSHb/PK9kxa8N5zryZHbKuZA
         YomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707288091; x=1707892891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxxVVXToZdIUBGMbsph8ZPdjTKMow+DtFhTgLD0SlYU=;
        b=UTzoVUp1jNM+J1twDbboVwXi8c5wVxonbqO03eDkZboBPuUQ+vPWheH66PnDMy3ZLK
         Qh3iSdUp7oJSgT0DgyhyraH8/y08eLwlAPVhYmBnl9xFyiJS72KlfjweuNiyS4Ek+lKy
         5QJ9F6mbDApEm8CuTXazNK4oKrQAxzHl1QGHfHM5ySXXKElk6Uwgefx7/Yf3s+6wYctE
         0ln6b9vKkWXRKnR9geEwjiHG8HVQQkuhpCZC8m2Tr5B3bO8dc87Wt1ZRM9AOgTTMdcCX
         vDDu3QEnqrzdCq7X/Ukwxdaeq16JwHPWcKH5RLEQu9JW+pUjcVHhGVyfhmyCeJ0EvcsA
         H4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUXreZSrOTfzYqCt6u34Zz1LHJPBrZKUwomNebfRAY1Q+cVD30pvgKiZrDTQtYTuno3PZRrhoVeg1U83qJCXEr/6/Z5+goF6bQs+jM=
X-Gm-Message-State: AOJu0YxeBpi1nZeNm1b1cL6PsyzAvpE3KPP/yaQnDiLC1PXAT/XmxqUo
	kd4eCmePY3MJT9agBy5ykjdvoM1H1Etpiae1N9DtrxV6kzOobigvy/0eo+EetdJtOPI1DWCDQ3g
	STSKYBvn2+pXWH2hmd7SkT01RlDUAbWmvu6w=
X-Google-Smtp-Source: AGHT+IFsem0B3EyR78CeUXhBbN1BIkh+p+UuQmClFMLrRb8i3XrdJQs/Ab1WwIggt8CDx/55VywuuMwUfqBHI7uwh50=
X-Received: by 2002:a05:6214:500a:b0:68c:ae6d:2959 with SMTP id
 jo10-20020a056214500a00b0068cae6d2959mr6138564qvb.26.1707288091604; Tue, 06
 Feb 2024 22:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207025624.1019754-1-kent.overstreet@linux.dev> <20240207025624.1019754-4-kent.overstreet@linux.dev>
In-Reply-To: <20240207025624.1019754-4-kent.overstreet@linux.dev>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 Feb 2024 08:41:20 +0200
Message-ID: <CAOQ4uxi-nBzm+h0MkF_P8Efe9tA1q72kBWPWZsrd+owHTf8enQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] fs: FS_IOC_GETUUID
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.or
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:57=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> Add a new generic ioctls for querying the filesystem UUID.
>
> These are lifted versions of the ext4 ioctls, with one change: we're not
> using a flexible array member, because UUIDs will never be more than 16
> bytes.
>
> This patch adds a generic implementation of FS_IOC_GETFSUUID, which
> reads from super_block->s_uuid. We're not lifting SETFSUUID from ext4 -
> that can be done on offline filesystems by the people who need it,
> trying to do it online is just asking for too much trouble.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: linux-fsdevel@vger.kernel.or
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst         |  3 ++-
>  fs/ioctl.c                                       | 16 ++++++++++++++++
>  include/uapi/linux/fs.h                          | 16 ++++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documen=
tation/userspace-api/ioctl/ioctl-number.rst
> index 457e16f06e04..3731ecf1e437 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -82,8 +82,9 @@ Code  Seq#    Include File                             =
              Comments
>  0x10  00-0F  drivers/char/s390/vmcp.h
>  0x10  10-1F  arch/s390/include/uapi/sclp_ctl.h
>  0x10  20-2F  arch/s390/include/uapi/asm/hypfs.h
> -0x12  all    linux/fs.h
> +0x12  all    linux/fs.h                                              BLK=
* ioctls
>               linux/blkpg.h
> +0x15  all    linux/fs.h                                              FS_=
IOC_* ioctls
>  0x1b  all                                                            Inf=
iniBand Subsystem
>                                                                       <ht=
tp://infiniband.sourceforge.net/>
>  0x20  all    drivers/cdrom/cm206.h
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 76cf22ac97d7..74eab9549383 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -763,6 +763,19 @@ static int ioctl_fssetxattr(struct file *file, void =
__user *argp)
>         return err;
>  }
>
> +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> +{
> +       struct super_block *sb =3D file_inode(file)->i_sb;
> +       struct fsuuid2 u =3D { .len =3D sb->s_uuid_len, };
> +
> +       if (!sb->s_uuid_len)
> +               return -ENOIOCTLCMD;
> +
> +       memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
> +
> +       return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> +}
> +
>  /*
>   * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBO=
L()'d.
>   * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
> @@ -845,6 +858,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned i=
nt fd,
>         case FS_IOC_FSSETXATTR:
>                 return ioctl_fssetxattr(filp, argp);
>
> +       case FS_IOC_GETFSUUID:
> +               return ioctl_getfsuuid(filp, argp);
> +
>         default:
>                 if (S_ISREG(inode->i_mode))
>                         return file_ioctl(filp, cmd, argp);
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 48ad69f7722e..d459f816cd50 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,19 @@ struct fstrim_range {
>         __u64 minlen;
>  };
>
> +/*
> + * We include a length field because some filesystems (vfat) have an ide=
ntifier
> + * that we do want to expose as a UUID, but doesn't have the standard le=
ngth.
> + *
> + * We use a fixed size buffer beacuse this interface will, by fiat, neve=
r
> + * support "UUIDs" longer than 16 bytes; we don't want to force all down=
stream
> + * users to have to deal with that.
> + */
> +struct fsuuid2 {
> +       __u8    len;
> +       __u8    uuid[16];
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definit=
ions */
>  #define FILE_DEDUPE_RANGE_SAME         0
>  #define FILE_DEDUPE_RANGE_DIFFERS      1
> @@ -190,6 +203,9 @@ struct fsxattr {
>   * (see uapi/linux/blkzoned.h)
>   */
>
> +/* Returns the external filesystem UUID, the same one blkid returns */
> +#define FS_IOC_GETFSUUID               _IOR(0x15, 0, struct fsuuid2)

Please move that to the end of FS_IOC_* ioctls block.
The fact that it started a new vfs ioctl namespace does not justify startin=
g
a different list IMO.

uapi readers don't care about the value of the ioctl.
locality to FS_IOC_GETFSLABEL is more important IMO.

Thanks,
Amir.


> +
>  #define BMAP_IOCTL 1           /* obsolete - kept for compatibility */
>  #define FIBMAP    _IO(0x00,1)  /* bmap access */
>  #define FIGETBSZ   _IO(0x00,2) /* get the block size used for bmap */
> --
> 2.43.0
>
>

