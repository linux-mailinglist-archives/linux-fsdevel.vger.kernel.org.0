Return-Path: <linux-fsdevel+bounces-58314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E80CB2C7A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF6D16807E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6827F160;
	Tue, 19 Aug 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8mBxZ9R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA23E27E7EB;
	Tue, 19 Aug 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615092; cv=none; b=siX57rJd06D2M070L3mJ1QYMUuoCJUjdxvgOtGh0nahJSXSHQI2zLRJXL2HwKCJBow1aJjJ3Zu7qgC8bVAMwbZVDovjYcrNwfsjJA3uS/zVbMlwhiw4qKDpZ6ATlrLpaiVbFAEKtWY/eb9fwHgNzl+YvikBd4/Gxzib+/hI/Lm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615092; c=relaxed/simple;
	bh=YdcKPm5S4lHHgY/PB+ox30BhQh06O7i2CwsRMaVydKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5fl67n9fRnlQze6xHz1vQRnfP/c+Cp9YOcCbbBYqhBc2JoPvq0qdzONVzZ5scV+TBsF9WglE4Lb0eLwdGGFOz0bCpU3egZ5xjoWQohI8DMmbvLFrG65+69BkaJV56QnfzaBFEZJesS2hJ6OLH+JnVNmg2v7KXqi/lDS4dD3A44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8mBxZ9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB9CC113D0;
	Tue, 19 Aug 2025 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755615092;
	bh=YdcKPm5S4lHHgY/PB+ox30BhQh06O7i2CwsRMaVydKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i8mBxZ9RKKjj9FXd9HnlzpScTSo6BDMunZDS2alaewrhlmvosu/Vd5/AJgfNpHoR6
	 ABJWvDtIh9ZVfrCfe0MgarY9s0xXrsY2zrkuWgtObN4OWTkx5+ec5DrrU+iBqmqepv
	 SN0vEylKIXXvEqeMjTf7Sr7fVDizEbebcgil+HvkNZSvYuPNiDlzYr4kjmVtGfolbu
	 515tZcztxAD2DlHvuRm0RuYfg7/cXMzpkhadWaps7uAkIq8FaKI/IiaY870VkTGxi7
	 LRzY/YvkOCSauNfMdyAbBl0gz/i0TTYp5h5iCkKCHMy/qzI7O5eglDMJaouW4x6UKA
	 KgfF+a++vMDKg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb79db329so736529166b.2;
        Tue, 19 Aug 2025 07:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXCIit9BxZxpWeMPbYgD+PF3GifDRxKG06wQTf8tFS0zR4+IM9yXutPqiISi6Jl1Q0J45vRW+d6rMNqjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaoUizD4aaDHnRyooxvRrmSCGtCrpQE+XScUm1IVI/sjriscPa
	XLDCMp5CuwhKvpf7i4+Q2dm4iIfDETMSJ1ERQx6mn2EPNgq9kCGJ2+kv/Hf9a5xWVUKWdgdKHwx
	adTyjeuaUtsBwV2PnlQacu+cAre7ByTA=
X-Google-Smtp-Source: AGHT+IFwCbgVoUXiqBPxLuGgje7NIJglPWGH2DegCbGfMxndQQOou3/eyYcwUqBs92EMt8OK/mx2J3RxHsKmvMatgIs=
X-Received: by 2002:a17:907:d8d:b0:af9:bdfd:c60c with SMTP id
 a640c23a62f3a-afddd0d32c5mr233295266b.47.1755615090806; Tue, 19 Aug 2025
 07:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd-o3TpAaBS65cZFzchCfPdJ8YrN9HHEn_ttr69QB+BFew@mail.gmail.com>
 <20250819132213.544920-1-ethan.ferguson@zetier.com>
In-Reply-To: <20250819132213.544920-1-ethan.ferguson@zetier.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 19 Aug 2025 23:51:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8xTwY7SZb9OjiTF4yA127TjZMawzZRcFW7uZt8d3PPfw@mail.gmail.com>
X-Gm-Features: Ac12FXz2_YI7dZqThGO8eOqxC9AMEXk56hf7aBg8Q5OK5jwuPDT5tLQSKb6QCTs
Message-ID: <CAKYAXd8xTwY7SZb9OjiTF4yA127TjZMawzZRcFW7uZt8d3PPfw@mail.gmail.com>
Subject: Re: [PATCH] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:22=E2=80=AFPM Ethan Ferguson
<ethan.ferguson@zetier.com> wrote:
>
> On 8/18/25 21:45, Namjae Jeon wrote:
> > On Sun, Aug 17, 2025 at 9:31=E2=80=AFAM Ethan Ferguson
> > <ethan.ferguson@zetier.com> wrote:
> >>
> >> Add support for reading / writing to the exfat volume label from the
> >> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls
> >>
> >> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
> >>
> >> ---
> >>  fs/exfat/exfat_fs.h  |  2 +
> >>  fs/exfat/exfat_raw.h |  6 +++
> >>  fs/exfat/file.c      | 56 +++++++++++++++++++++++++
> >>  fs/exfat/super.c     | 99 +++++++++++++++++++++++++++++++++++++++++++=
+
> >>  4 files changed, 163 insertions(+)
> >>
> >> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> >> index f8ead4d47ef0..a764e6362172 100644
> >> --- a/fs/exfat/exfat_fs.h
> >> +++ b/fs/exfat/exfat_fs.h
> >> @@ -267,6 +267,7 @@ struct exfat_sb_info {
> >>         struct buffer_head **vol_amap; /* allocation bitmap */
> >>
> >>         unsigned short *vol_utbl; /* upcase table */
> >> +       unsigned short volume_label[EXFAT_VOLUME_LABEL_LEN]; /* volume=
 name */
> > There's no reason to have this in sbi. I think it's better to read the
> > volume name in ioctl fslabel and return it.
> >
> That's fair. I wrote it this way because the volume label is stored in
> the sbi in btrfs, but there it's (as far as I understand) part of the
> fs header on disk, and not (as is the case in exfat) a directory entry
> that could be arbitrarily far from the start of the disk. Maybe we could
> cache it in the sbi after the first read? I'm open to either.
I agree to cache it in sbi after the first read.
>
> >>
> >>         unsigned int clu_srch_ptr; /* cluster search pointer */
> >>         unsigned int used_clusters; /* number of used clusters */
> >> @@ -431,6 +432,7 @@ static inline loff_t exfat_ondisk_size(const struc=
t inode *inode)
> >>  /* super.c */
> >>  int exfat_set_volume_dirty(struct super_block *sb);
> >>  int exfat_clear_volume_dirty(struct super_block *sb);
> >> +int exfat_write_volume_label(struct super_block *sb);
> >>
> >>  /* fatent.c */
> >>  #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), p=
clu)
> >> diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
> >> index 971a1ccd0e89..af04cef81c0c 100644
> >> --- a/fs/exfat/exfat_raw.h
> >> +++ b/fs/exfat/exfat_raw.h
> >> @@ -80,6 +80,7 @@
> >>  #define BOOTSEC_OLDBPB_LEN             53
> >>
> >>  #define EXFAT_FILE_NAME_LEN            15
> >> +#define EXFAT_VOLUME_LABEL_LEN         11
> >>
> >>  #define EXFAT_MIN_SECT_SIZE_BITS               9
> >>  #define EXFAT_MAX_SECT_SIZE_BITS               12
> >> @@ -159,6 +160,11 @@ struct exfat_dentry {
> >>                         __le32 start_clu;
> >>                         __le64 size;
> >>                 } __packed upcase; /* up-case table directory entry */
> >> +               struct {
> >> +                       __u8 char_count;
> >> +                       __le16 volume_label[EXFAT_VOLUME_LABEL_LEN];
> >> +                       __u8 reserved[8];
> >> +               } __packed volume_label;
> >>                 struct {
> >>                         __u8 flags;
> >>                         __u8 vendor_guid[16];
> >> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> >> index 538d2b6ac2ec..c57d266aae3d 100644
> >> --- a/fs/exfat/file.c
> >> +++ b/fs/exfat/file.c
> >> @@ -12,6 +12,7 @@
> >>  #include <linux/security.h>
> >>  #include <linux/msdos_fs.h>
> >>  #include <linux/writeback.h>
> >> +#include "../nls/nls_ucs2_utils.h"
> >>
> >>  #include "exfat_raw.h"
> >>  #include "exfat_fs.h"
> >> @@ -486,6 +487,57 @@ static int exfat_ioctl_shutdown(struct super_bloc=
k *sb, unsigned long arg)
> >>         return exfat_force_shutdown(sb, flags);
> >>  }
> >>
> >> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsig=
ned long arg)
> >> +{
> >> +       int ret;
> >> +       char utf8[FSLABEL_MAX] =3D {0};
> >> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> >> +       size_t len =3D UniStrnlen(sbi->volume_label, EXFAT_VOLUME_LABE=
L_LEN);
> >> +
> >> +       mutex_lock(&sbi->s_lock);
> >> +       ret =3D utf16s_to_utf8s(sbi->volume_label, len,
> >> +                               UTF16_HOST_ENDIAN, utf8, FSLABEL_MAX);
> >> +       mutex_unlock(&sbi->s_lock);
> >> +
> >> +       if (ret < 0)
> >> +               return ret;
> >> +
> >> +       if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX))
> >> +               return -EFAULT;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int exfat_ioctl_set_volume_label(struct super_block *sb, unsig=
ned long arg)
> >> +{
> >> +       int ret =3D 0;
> >> +       char utf8[FSLABEL_MAX];
> >> +       size_t len;
> >> +       unsigned short utf16[EXFAT_VOLUME_LABEL_LEN] =3D {0};
> >> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> >> +
> >> +       if (!capable(CAP_SYS_ADMIN))
> >> +               return -EPERM;
> >> +
> >> +       if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX))
> >> +               return -EFAULT;
> >> +
> >> +       len =3D strnlen(utf8, FSLABEL_MAX);
> >> +       if (len > EXFAT_VOLUME_LABEL_LEN)
> > Is FSLABEL_MAX in bytes or the number of characters ?
> >
> the definition mentions chars, and everywhere else it's used it's in
> terms of chars, so I'd say it's in terms of bytes. The
> FS_IOC_{GET,SET}FSLABEL ioctls are in terms of char[FSLABEL_MAX], so
> I think it's reasonable to use it as a number of bytes.
Okay.
>
> >> +               exfat_info(sb, "Volume label length too long, truncati=
ng");
> >> +
> >> +       mutex_lock(&sbi->s_lock);
> >> +       ret =3D utf8s_to_utf16s(utf8, len, UTF16_HOST_ENDIAN, utf16, E=
XFAT_VOLUME_LABEL_LEN);
> >> +       mutex_unlock(&sbi->s_lock);
> >> +
> >> +       if (ret < 0)
> >> +               return ret;
> >> +
> >> +       memcpy(sbi->volume_label, utf16, sizeof(sbi->volume_label));
> >> +
> >> +       return exfat_write_volume_label(sb);
> >> +}
> >> +
> >>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long a=
rg)
> >>  {
> >>         struct inode *inode =3D file_inode(filp);
> >> @@ -500,6 +552,10 @@ long exfat_ioctl(struct file *filp, unsigned int =
cmd, unsigned long arg)
> >>                 return exfat_ioctl_shutdown(inode->i_sb, arg);
> >>         case FITRIM:
> >>                 return exfat_ioctl_fitrim(inode, arg);
> >> +       case FS_IOC_GETFSLABEL:
> >> +               return exfat_ioctl_get_volume_label(inode->i_sb, arg);
> >> +       case FS_IOC_SETFSLABEL:
> >> +               return exfat_ioctl_set_volume_label(inode->i_sb, arg);
> >>         default:
> >>                 return -ENOTTY;
> >>         }
> >> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> >> index 8926e63f5bb7..96cd4bb7cb19 100644
> >> --- a/fs/exfat/super.c
> >> +++ b/fs/exfat/super.c
> >> @@ -18,6 +18,7 @@
> >>  #include <linux/nls.h>
> >>  #include <linux/buffer_head.h>
> >>  #include <linux/magic.h>
> >> +#include "../nls/nls_ucs2_utils.h"
> >>
> >>  #include "exfat_raw.h"
> >>  #include "exfat_fs.h"
> >> @@ -573,6 +574,98 @@ static int exfat_verify_boot_region(struct super_=
block *sb)
> >>         return 0;
> >>  }
> >>
> >> +static int exfat_get_volume_label_ptrs(struct super_block *sb,
> >> +                                      struct buffer_head **out_bh,
> >> +                                      struct exfat_dentry **out_dentr=
y)
> >> +{
> >> +       int i;
> >> +       unsigned int type;
> >> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> >> +       struct exfat_chain clu;
> >> +       struct exfat_dentry *ep;
> >> +       struct buffer_head *bh;
> >> +
> >> +       clu.dir =3D sbi->root_dir;
> >> +       clu.flags =3D ALLOC_FAT_CHAIN;
> >> +
> >> +       while (clu.dir !=3D EXFAT_EOF_CLUSTER) {
> >> +               for (i =3D 0; i < sbi->dentries_per_clu; i++) {
> >> +                       ep =3D exfat_get_dentry(sb, &clu, i, &bh);
> >> +
> >> +                       if (!ep)
> >> +                               return -EIO;
> >> +
> >> +                       type =3D exfat_get_entry_type(ep);
> >> +                       if (type =3D=3D TYPE_UNUSED) {
> >> +                               brelse(bh);
> >> +                               return -EIO;
> >> +                       }
> >> +
> >> +                       if (type =3D=3D TYPE_VOLUME) {
> >> +                               *out_bh =3D bh;
> >> +                               *out_dentry =3D ep;
> >> +                               return 0;
> >> +                       }
> >> +
> >> +                       brelse(bh);
> >> +               }
> >> +
> >> +               if (exfat_get_next_cluster(sb, &(clu.dir)))
> >> +                       return -EIO;
> >> +       }
> >> +
> >> +       return -EIO;
> >> +}
> >> +
> >> +static int exfat_read_volume_label(struct super_block *sb)
> >> +{
> >> +       int ret, i;
> >> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> >> +       struct buffer_head *bh;
> >> +       struct exfat_dentry *ep;
> >> +
> >> +       ret =3D exfat_get_volume_label_ptrs(sb, &bh, &ep);
> >> +       if (ret < 0)
> >> +               goto cleanup;
> >> +
> >> +       for (i =3D 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
> >> +               sbi->volume_label[i] =3D le16_to_cpu(ep->dentry.volume=
_label.volume_label[i]);
> >> +
> >> +cleanup:
> >> +       if (bh)
> >> +               brelse(bh);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +int exfat_write_volume_label(struct super_block *sb)
> >> +{
> >> +       int ret, i;
> >> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> >> +       struct buffer_head *bh;
> >> +       struct exfat_dentry *ep;
> >> +
> >> +       ret =3D exfat_get_volume_label_ptrs(sb, &bh, &ep);
> >> +       if (ret < 0)
> >> +               goto cleanup;
> >> +
> >> +       mutex_lock(&sbi->s_lock);
> >> +       for (i =3D 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
> >> +               ep->dentry.volume_label.volume_label[i] =3D cpu_to_le1=
6(sbi->volume_label[i]);
> >> +
> >> +       ep->dentry.volume_label.char_count =3D
> >> +               UniStrnlen(sbi->volume_label, EXFAT_VOLUME_LABEL_LEN);
> >> +       mutex_unlock(&sbi->s_lock);
> >> +
> >> +cleanup:
> >> +       if (bh) {
> >> +               exfat_update_bh(bh, true);
> >> +               brelse(bh);
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >>  /* mount the file system volume */
> >>  static int __exfat_fill_super(struct super_block *sb,
> >>                 struct exfat_chain *root_clu)
> >> @@ -616,6 +709,12 @@ static int __exfat_fill_super(struct super_block =
*sb,
> >>                 goto free_bh;
> >>         }
> >>
> >> +       ret =3D exfat_read_volume_label(sb);
> > It will affect mount time if volume label entry is located at the end.
> > So, we can read it in ioctl fslabel as I said above.
> Sounds good. I'll incorporate your changes, and those of
> yuezhang.mo@sony.com, and submit version 3 of the patch soon.
As Yuezhang pointed out, You need to consider the case where there
is no volume label entry. Some mkfs implementations, though not
Windows, don't create a volume entry. So, if FS_IOC_SETFSLABEL
doesn't find a volume label entry, it should either look for an empty entry=
,
or, if that's not available, allocate a cluster to get a entry.

Thanks for your work!
>
> >> +       if (ret) {
> >> +               exfat_err(sb, "failed to read volume label");
> >> +               goto free_bh;
> >> +       }
> >> +
> >>         ret =3D exfat_count_used_clusters(sb, &sbi->used_clusters);
> >>         if (ret) {
> >>                 exfat_err(sb, "failed to scan clusters");
> >> --
> >> 2.50.1
> >>

