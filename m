Return-Path: <linux-fsdevel+bounces-58231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB715B2B66F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665F93BA1F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801E27F19F;
	Tue, 19 Aug 2025 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcDBWQmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043B27FD64;
	Tue, 19 Aug 2025 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567935; cv=none; b=p7vI4VYkzc/ue8jYEzNrdo/6A3x3GJ7QxTTnHL6mJKziXv2JcxN0ypyxqWLTGZduSOmod/rgF+6Z9sC7ekUSCjIY12EzjbMLKOsdjonqBfPx+sVpAAKNH+zbKKv1S1FIihcE8sxQSObFt8am9W9y/cJ6sVLWiOUhg2QjxToiahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567935; c=relaxed/simple;
	bh=1KsVypTLDNM1qpD4WGU8wxo7f40aOCtqdSmuoshZXrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8VBApUjC/3w3CVSPrSfms11I3INJw39FCkvF476aiBu5jzxkxjJObW7DOG5MmQbJMO7035po1joFgDvVOm3Vn1eNZ1h1P6jht2vUgmsbIIwkC4EPa+7itiZim8W6ATpccPGCoLDxKQ9b1doViM9Z0xZCI86QYfakuO3iQuAGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcDBWQmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44705C4CEEB;
	Tue, 19 Aug 2025 01:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755567935;
	bh=1KsVypTLDNM1qpD4WGU8wxo7f40aOCtqdSmuoshZXrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RcDBWQmHkk/mILCZsOCiFYBd1Mro7OA1SMQAyO3XuRdHWLB9f427IRXZA8pOnj3+f
	 tWnHZcjUvgBUBfmMH9fS8rhyNnEwkWqIUomYgBCorQEQfBrM/6c/nvWvDVf4UBiPuR
	 lX+emADvCohwiKZ/tf/hTyM0HLtxGPJmlI9KEMQGoZlJEwNov/iOsTqVJwz/iQTwAi
	 cu3MRioL5gqHc6uENbHE1YN5E/vQw+DGHbO71P967c7jAQM1gyvzQBH5cwKg6QvYr7
	 igytf8ef3o0C0ZELExrNeF6Fy0ubub+1GqpYrjO3ycVjmrXmLZCrficw+O7reLeQse
	 Rneudqz5lhhYw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61a2a5b0689so3663092a12.1;
        Mon, 18 Aug 2025 18:45:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUva03fuPhXwqZFfYkpnI6hi+iCswY3a8H8xvuyhJ06qG97/cErNQnJ9Kffn8g3JWMZSnyBZZ+JBHIBs/7x@vger.kernel.org, AJvYcCXw2Gi4aUKOW3AakulyArXCedSpK1t3Krzx7Ol/zsACCf8uCzHfcz17jxB0G0SsqLyPKRIwFSQTpAjv8s4H@vger.kernel.org
X-Gm-Message-State: AOJu0YyuIXcOKQm0mNIVRThAc9YwaiEC+D4j3woBWw3DO7n8pz5Facwc
	WZTZxdyD/K+uuNZ9kx/ZQTaG+KemUBlDD+gnZ5BnEwxHOaXva/B4lU6UpNMkgKxMVSaYe3Pdcsj
	Cfy/1i4xrM9kaSkk/henFp60lubCVzVM=
X-Google-Smtp-Source: AGHT+IEjooJwD1L8N4595UKPwoGnCdDVKf7n1R9E5Sju52DByr3+JHOUp/9rkO353ornS2qWB4Nq0MSTvnD7Jtc8Rws=
X-Received: by 2002:a17:906:6a1f:b0:afd:d62f:939 with SMTP id
 a640c23a62f3a-afddcfb4b68mr67048366b.36.1755567933831; Mon, 18 Aug 2025
 18:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817003046.313497-1-ethan.ferguson@zetier.com> <20250817003046.313497-2-ethan.ferguson@zetier.com>
In-Reply-To: <20250817003046.313497-2-ethan.ferguson@zetier.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 19 Aug 2025 10:45:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-o3TpAaBS65cZFzchCfPdJ8YrN9HHEn_ttr69QB+BFew@mail.gmail.com>
X-Gm-Features: Ac12FXwNO0EDZHtNFqgVSnbzoE7pt1b9tiI0Hg9HdgDzUH6GHa_W6Br6F8kon_8
Message-ID: <CAKYAXd-o3TpAaBS65cZFzchCfPdJ8YrN9HHEn_ttr69QB+BFew@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 9:31=E2=80=AFAM Ethan Ferguson
<ethan.ferguson@zetier.com> wrote:
>
> Add support for reading / writing to the exfat volume label from the
> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls
>
> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
>
> ---
>  fs/exfat/exfat_fs.h  |  2 +
>  fs/exfat/exfat_raw.h |  6 +++
>  fs/exfat/file.c      | 56 +++++++++++++++++++++++++
>  fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 163 insertions(+)
>
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index f8ead4d47ef0..a764e6362172 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -267,6 +267,7 @@ struct exfat_sb_info {
>         struct buffer_head **vol_amap; /* allocation bitmap */
>
>         unsigned short *vol_utbl; /* upcase table */
> +       unsigned short volume_label[EXFAT_VOLUME_LABEL_LEN]; /* volume na=
me */
There's no reason to have this in sbi. I think it's better to read the
volume name in ioctl fslabel and return it.

>
>         unsigned int clu_srch_ptr; /* cluster search pointer */
>         unsigned int used_clusters; /* number of used clusters */
> @@ -431,6 +432,7 @@ static inline loff_t exfat_ondisk_size(const struct i=
node *inode)
>  /* super.c */
>  int exfat_set_volume_dirty(struct super_block *sb);
>  int exfat_clear_volume_dirty(struct super_block *sb);
> +int exfat_write_volume_label(struct super_block *sb);
>
>  /* fatent.c */
>  #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu=
)
> diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
> index 971a1ccd0e89..af04cef81c0c 100644
> --- a/fs/exfat/exfat_raw.h
> +++ b/fs/exfat/exfat_raw.h
> @@ -80,6 +80,7 @@
>  #define BOOTSEC_OLDBPB_LEN             53
>
>  #define EXFAT_FILE_NAME_LEN            15
> +#define EXFAT_VOLUME_LABEL_LEN         11
>
>  #define EXFAT_MIN_SECT_SIZE_BITS               9
>  #define EXFAT_MAX_SECT_SIZE_BITS               12
> @@ -159,6 +160,11 @@ struct exfat_dentry {
>                         __le32 start_clu;
>                         __le64 size;
>                 } __packed upcase; /* up-case table directory entry */
> +               struct {
> +                       __u8 char_count;
> +                       __le16 volume_label[EXFAT_VOLUME_LABEL_LEN];
> +                       __u8 reserved[8];
> +               } __packed volume_label;
>                 struct {
>                         __u8 flags;
>                         __u8 vendor_guid[16];
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 538d2b6ac2ec..c57d266aae3d 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -12,6 +12,7 @@
>  #include <linux/security.h>
>  #include <linux/msdos_fs.h>
>  #include <linux/writeback.h>
> +#include "../nls/nls_ucs2_utils.h"
>
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -486,6 +487,57 @@ static int exfat_ioctl_shutdown(struct super_block *=
sb, unsigned long arg)
>         return exfat_force_shutdown(sb, flags);
>  }
>
> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned=
 long arg)
> +{
> +       int ret;
> +       char utf8[FSLABEL_MAX] =3D {0};
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> +       size_t len =3D UniStrnlen(sbi->volume_label, EXFAT_VOLUME_LABEL_L=
EN);
> +
> +       mutex_lock(&sbi->s_lock);
> +       ret =3D utf16s_to_utf8s(sbi->volume_label, len,
> +                               UTF16_HOST_ENDIAN, utf8, FSLABEL_MAX);
> +       mutex_unlock(&sbi->s_lock);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +static int exfat_ioctl_set_volume_label(struct super_block *sb, unsigned=
 long arg)
> +{
> +       int ret =3D 0;
> +       char utf8[FSLABEL_MAX];
> +       size_t len;
> +       unsigned short utf16[EXFAT_VOLUME_LABEL_LEN] =3D {0};
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX))
> +               return -EFAULT;
> +
> +       len =3D strnlen(utf8, FSLABEL_MAX);
> +       if (len > EXFAT_VOLUME_LABEL_LEN)
Is FSLABEL_MAX in bytes or the number of characters ?

> +               exfat_info(sb, "Volume label length too long, truncating"=
);
> +
> +       mutex_lock(&sbi->s_lock);
> +       ret =3D utf8s_to_utf16s(utf8, len, UTF16_HOST_ENDIAN, utf16, EXFA=
T_VOLUME_LABEL_LEN);
> +       mutex_unlock(&sbi->s_lock);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       memcpy(sbi->volume_label, utf16, sizeof(sbi->volume_label));
> +
> +       return exfat_write_volume_label(sb);
> +}
> +
>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>         struct inode *inode =3D file_inode(filp);
> @@ -500,6 +552,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd=
, unsigned long arg)
>                 return exfat_ioctl_shutdown(inode->i_sb, arg);
>         case FITRIM:
>                 return exfat_ioctl_fitrim(inode, arg);
> +       case FS_IOC_GETFSLABEL:
> +               return exfat_ioctl_get_volume_label(inode->i_sb, arg);
> +       case FS_IOC_SETFSLABEL:
> +               return exfat_ioctl_set_volume_label(inode->i_sb, arg);
>         default:
>                 return -ENOTTY;
>         }
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 8926e63f5bb7..96cd4bb7cb19 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -18,6 +18,7 @@
>  #include <linux/nls.h>
>  #include <linux/buffer_head.h>
>  #include <linux/magic.h>
> +#include "../nls/nls_ucs2_utils.h"
>
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -573,6 +574,98 @@ static int exfat_verify_boot_region(struct super_blo=
ck *sb)
>         return 0;
>  }
>
> +static int exfat_get_volume_label_ptrs(struct super_block *sb,
> +                                      struct buffer_head **out_bh,
> +                                      struct exfat_dentry **out_dentry)
> +{
> +       int i;
> +       unsigned int type;
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> +       struct exfat_chain clu;
> +       struct exfat_dentry *ep;
> +       struct buffer_head *bh;
> +
> +       clu.dir =3D sbi->root_dir;
> +       clu.flags =3D ALLOC_FAT_CHAIN;
> +
> +       while (clu.dir !=3D EXFAT_EOF_CLUSTER) {
> +               for (i =3D 0; i < sbi->dentries_per_clu; i++) {
> +                       ep =3D exfat_get_dentry(sb, &clu, i, &bh);
> +
> +                       if (!ep)
> +                               return -EIO;
> +
> +                       type =3D exfat_get_entry_type(ep);
> +                       if (type =3D=3D TYPE_UNUSED) {
> +                               brelse(bh);
> +                               return -EIO;
> +                       }
> +
> +                       if (type =3D=3D TYPE_VOLUME) {
> +                               *out_bh =3D bh;
> +                               *out_dentry =3D ep;
> +                               return 0;
> +                       }
> +
> +                       brelse(bh);
> +               }
> +
> +               if (exfat_get_next_cluster(sb, &(clu.dir)))
> +                       return -EIO;
> +       }
> +
> +       return -EIO;
> +}
> +
> +static int exfat_read_volume_label(struct super_block *sb)
> +{
> +       int ret, i;
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> +       struct buffer_head *bh;
> +       struct exfat_dentry *ep;
> +
> +       ret =3D exfat_get_volume_label_ptrs(sb, &bh, &ep);
> +       if (ret < 0)
> +               goto cleanup;
> +
> +       for (i =3D 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
> +               sbi->volume_label[i] =3D le16_to_cpu(ep->dentry.volume_la=
bel.volume_label[i]);
> +
> +cleanup:
> +       if (bh)
> +               brelse(bh);
> +
> +       return ret;
> +}
> +
> +int exfat_write_volume_label(struct super_block *sb)
> +{
> +       int ret, i;
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> +       struct buffer_head *bh;
> +       struct exfat_dentry *ep;
> +
> +       ret =3D exfat_get_volume_label_ptrs(sb, &bh, &ep);
> +       if (ret < 0)
> +               goto cleanup;
> +
> +       mutex_lock(&sbi->s_lock);
> +       for (i =3D 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
> +               ep->dentry.volume_label.volume_label[i] =3D cpu_to_le16(s=
bi->volume_label[i]);
> +
> +       ep->dentry.volume_label.char_count =3D
> +               UniStrnlen(sbi->volume_label, EXFAT_VOLUME_LABEL_LEN);
> +       mutex_unlock(&sbi->s_lock);
> +
> +cleanup:
> +       if (bh) {
> +               exfat_update_bh(bh, true);
> +               brelse(bh);
> +       }
> +
> +       return ret;
> +}
> +
>  /* mount the file system volume */
>  static int __exfat_fill_super(struct super_block *sb,
>                 struct exfat_chain *root_clu)
> @@ -616,6 +709,12 @@ static int __exfat_fill_super(struct super_block *sb=
,
>                 goto free_bh;
>         }
>
> +       ret =3D exfat_read_volume_label(sb);
It will affect mount time if volume label entry is located at the end.
So, we can read it in ioctl fslabel as I said above.
> +       if (ret) {
> +               exfat_err(sb, "failed to read volume label");
> +               goto free_bh;
> +       }
> +
>         ret =3D exfat_count_used_clusters(sb, &sbi->used_clusters);
>         if (ret) {
>                 exfat_err(sb, "failed to scan clusters");
> --
> 2.50.1
>

