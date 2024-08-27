Return-Path: <linux-fsdevel+bounces-27423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC8961694
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486111C22CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9531D1F70;
	Tue, 27 Aug 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiHXc+fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED431CFEA4;
	Tue, 27 Aug 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782539; cv=none; b=P+0rNVzGPaXtx2OlhyHylyFy7GYCHDDD2lrEwQBCI+y4i/8mAxec4JrVo2VC25W7jNsfahIpfMkbv1LYdVyDbegH59uXb9LCYMNJ3iqcIsyfCBM78PgBuqZRfym79u5xiDf+dPCbukTl/pLN44ad8WrBbTJHTrFUIY+ifuHtJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782539; c=relaxed/simple;
	bh=pVcgVy77zQ4wQus05rb9bOVof4LW3fmLFvD+y6zxvXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyAG+TAr1PgIPYLaAcR3xZhkMQTnx7tNUyWYR3ZS86EmRhYK9gazGAE5piSFvObjeyMxm6SjEwoDd+HoVtDX5bwl+Ba3LImwxafxPcTDxRFL15SJ3T6UPipcceXTTMvi8XUQw0j+gx4+wDNSbjiGv2iQXi0LTe1J/tVJmVr974I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiHXc+fn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53436e04447so4921656e87.1;
        Tue, 27 Aug 2024 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782535; x=1725387335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlfGmOBnGqhl9bDyEbypN0UaVHevitrcJ0rKYwQl5/c=;
        b=AiHXc+fnO1qMbSjAfmiVgdHZy55jlFY8XOw0B78+vo+2jJjXlmu9NAUWXm8eyh/jlZ
         CrAaQcHL/omo7H3KAgbQB4rrjam3M/1ft0K7WKkn2o+eyjj26wQs+Bc8qi040IR3w+Mj
         h8dSGECgUjMoSqewkxvQD8YZb4sekuZq+IbvLITYRIGY7CMxeIhOcfzuBwePpEoRE6/H
         LGj+S0o5IEo3KenJx0wMEw/luhXGOyoocGvpbQzMnFg3evOuxkSiUFnXSYdpwPcuLRDF
         zLxG4vXs7Zlq7+h1vdT31viaviPWGzUZbbRdJTpLx4Op1JklJwnPE9sJbdqvbdhJy4v9
         eaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782535; x=1725387335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlfGmOBnGqhl9bDyEbypN0UaVHevitrcJ0rKYwQl5/c=;
        b=ZtJ39FyMKZlzy1bev13dM8yFo6eLKsHY/8VmpaF44TI4vfwb9cxIREHE098KQ3UP8m
         VEfns05LNUxpqshCgCT913Gefz7adp4JRP/+DQtysvgOmS+fAILbaZ3k5XRDlJFqtRC3
         pyp+TNwCSPLrzbKhk0RIK4scgQQYcOPg1qAQbvF3/nHgrAcVUDISQJ3G5Kiap3D+pfWP
         ge8iGOdm45f24x2qUGdLsqzV6hXwKZO/4LJM/EJXVo6kpghXKs/OHzkSw2vQgduiVnlw
         8CNEce0aaETg1yzxR5r4vrafW+7BUUAFpgsQiHH6dhMAEgMCz9YG23wr3CNf5+lhgRk3
         T+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX3wFEykBhrpAqG/b2bsSSHrJiZUn7vwRTk8daO2WYo4KX1ngHrc6IkO14DispyjwwnlUku5x1S6xUU4D9L@vger.kernel.org
X-Gm-Message-State: AOJu0YwqEPR0fErAPXwWX1iWocnG35vJhL/Axef51qvzvkDLTpVpeHxe
	OK8lUhzpeNWrO8YVF5QIScB98Pb++x5ataPEzCrUi43lcC3HWJx32vBIOLN1U7CjTKx8/AWyWt9
	n8hjP7Ac1y84BFve/QhFzGtbDPTMoeBW5
X-Google-Smtp-Source: AGHT+IEkjqrF4FP+oAa6lnud8Uip502gdhKTnzl2pIyhc6GpVhajGR80N1K7g3Po4H1LC8WOf86r5n5FBOTFUons4OA=
X-Received: by 2002:a05:6512:3f04:b0:533:415e:cd9a with SMTP id
 2adb3069b0e04-534555eff79mr6785e87.23.1724782534569; Tue, 27 Aug 2024
 11:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827015152.222983-1-lihongbo22@huawei.com>
In-Reply-To: <20240827015152.222983-1-lihongbo22@huawei.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 28 Aug 2024 03:15:17 +0900
Message-ID: <CAKFNMomMtJbEbZNRAzari3koP1eRHOrUDQ=rAxDbL6yfHHG=gg@mail.gmail.com>
Subject: Re: [PATCH -next] nilfs2: support STATX_DIOALIGN for statx file
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hongbo,

Thanks for the suggestion.

I checked the STATX_DIOALIGN specification while looking at the
implementation of other file systems, and I thought that if DIO
support is incomplete, the dio_xx_align member should be set to 0.

Due to the nature of NILFS2 as a log-structured file system, DIO
writes fall back to buffered io.  (DIO reads are supported)

This is similar to the journal data mode of ext4 and the blkzoned
device support of f2fs, but in such case, these file systems return a
value of 0 (direct I/O not supported).

So, it's fine to respond to a STATX_DIOALIGN request, but I think the
value of dio_xx_align should be set to 0 to match these file systems.

In this sense, there may be no need to rush to support STATX_DIOALIGN
now.  Do you still think it would be better to have it?

The following are some minor comments:

On Tue, Aug 27, 2024 at 10:58=E2=80=AFAM Hongbo Li wrote:
>
> Add support for STATX_DIOALIGN to nilfs2, so that direct I/O alignment
> restrictions are exposed to userspace in a generic way.
>
> By default, nilfs2 uses the default getattr implemented at vfs layer,
> so we should implement getattr in nilfs2 to fill the dio_xx_align
> members. The nilfs2 does not have the special align requirements. So
> we use the default alignment setting from block layer.
> We have done the following test:
>
> [Before]
> ```
> ./statx_test /mnt/nilfs2/test
> statx(/mnt/nilfs2/test) =3D 0
> dio mem align:0
> dio offset align:0
> ```
>
> [After]
> ```
> ./statx_test /mnt/nilfs2/test
> statx(/mnt/nilfs2/test) =3D 0
> dio mem align:512
> dio offset align:512
> ```
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/nilfs2/file.c  |  1 +
>  fs/nilfs2/inode.c | 20 ++++++++++++++++++++
>  fs/nilfs2/namei.c |  2 ++
>  fs/nilfs2/nilfs.h |  2 ++
>  4 files changed, 25 insertions(+)
>
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index 0e3fc5ba33c7..5528918d4b96 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -154,6 +154,7 @@ const struct file_operations nilfs_file_operations =
=3D {
>
>  const struct inode_operations nilfs_file_inode_operations =3D {
>         .setattr        =3D nilfs_setattr,
> +       .getattr        =3D nilfs_getattr,
>         .permission     =3D nilfs_permission,
>         .fiemap         =3D nilfs_fiemap,
>         .fileattr_get   =3D nilfs_fileattr_get,
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 7340a01d80e1..b5bb2c2de32c 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -1001,6 +1001,26 @@ int nilfs_setattr(struct mnt_idmap *idmap, struct =
dentry *dentry,
>         return err;
>  }
>
> +int nilfs_getattr(struct mnt_idmap *idmap, const struct path *path,
> +                       struct kstat *stat, u32 request_mask, unsigned in=
t query_flags)
> +{
> +       struct inode *const inode =3D d_inode(path->dentry);
> +       struct block_device *bdev =3D inode->i_sb->s_bdev;
> +       unsigned int blksize =3D (1 << inode->i_blkbits);
> +
> +       if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
> +               stat->result_mask |=3D STATX_DIOALIGN;
> +

> +               if (bdev)
> +                       blksize =3D bdev_logical_block_size(bdev);

I don't think there's any need to check that bdev is NULL, but is
there a reason?

If sb->s_bdev can be NULL, I think that for such devices, a NULL
pointer dereference bug will occur in the mount path.
That's why I was concerned about this.

> +               stat->dio_mem_align =3D blksize;
> +               stat->dio_offset_align =3D blksize;
> +       }
> +
> +       generic_fillattr(idmap, request_mask, inode, stat);
> +       return 0;
> +}
> +
>  int nilfs_permission(struct mnt_idmap *idmap, struct inode *inode,
>                      int mask)
>  {
> diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
> index c950139db6ef..ad56f4f8be1f 100644
> --- a/fs/nilfs2/namei.c
> +++ b/fs/nilfs2/namei.c
> @@ -546,6 +546,7 @@ const struct inode_operations nilfs_dir_inode_operati=
ons =3D {
>         .mknod          =3D nilfs_mknod,
>         .rename         =3D nilfs_rename,
>         .setattr        =3D nilfs_setattr,
> +       .getattr        =3D nilfs_getattr,

In the case of directories, the STATX_DIOALIGN request is ignored, so
I don't think this is necessary for now. (It can be added in the
future when supporting other optional getattr requests/responses).

>         .permission     =3D nilfs_permission,
>         .fiemap         =3D nilfs_fiemap,
>         .fileattr_get   =3D nilfs_fileattr_get,
> @@ -554,6 +555,7 @@ const struct inode_operations nilfs_dir_inode_operati=
ons =3D {
>
>  const struct inode_operations nilfs_special_inode_operations =3D {
>         .setattr        =3D nilfs_setattr,
> +       .getattr        =3D nilfs_getattr,
>         .permission     =3D nilfs_permission,
>  };

Ditto.

>
> diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
> index 4017f7856440..98a8b28ca1db 100644
> --- a/fs/nilfs2/nilfs.h
> +++ b/fs/nilfs2/nilfs.h
> @@ -280,6 +280,8 @@ extern void nilfs_truncate(struct inode *);
>  extern void nilfs_evict_inode(struct inode *);
>  extern int nilfs_setattr(struct mnt_idmap *, struct dentry *,
>                          struct iattr *);
> +extern int nilfs_getattr(struct mnt_idmap *idmap, const struct path *pat=
h,
> +                       struct kstat *stat, u32 request_mask, unsigned in=
t query_flags);

Do not add the "extern" directive to new function declarations.
We are moving towards eliminating the extern declarator from function
declarations whenever possible.

>  extern void nilfs_write_failed(struct address_space *mapping, loff_t to)=
;
>  int nilfs_permission(struct mnt_idmap *idmap, struct inode *inode,
>                      int mask);
> --
> 2.34.1
>

That's all for my comments.

Thanks,
Ryusuke Konishi

