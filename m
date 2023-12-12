Return-Path: <linux-fsdevel+bounces-5732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73AC80F61A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F47281DFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 19:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527AD8005C;
	Tue, 12 Dec 2023 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khgiX6Kd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E71EA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 11:08:55 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5906df1d2adso2527939eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702408134; x=1703012934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rUE7pKrnOIxQx5S7SZFNs2Wa5Tl3bUr3B6PiXYrTnM=;
        b=khgiX6KdaR2dl70A9wTujsTNFxNvd/TtP1my5Gq15PciFa95vPilVAjKLoFotCeLG/
         UmEeLqfUFdQz2SDyWiKujiMJAhx2maiGRA90h9JUUAN8hRSX0/1Hezq1I7+HN3fVUWHa
         dw3bNPPGfWQ/fa6A4jlBPGShZKResuEjIxmT91moxC7+R5H55+yWOfsoaQgJKE1DYJGA
         Iq69tNULJtuG5sd67BAZ6NpPoBvTPhkfOc3yviUQfaiPCb++ziADU3eRdNnzfAorPTTn
         VNdc7wuAy555E5YpyJWkbh5r/yunjGm4w3sv2EuwAfjkb3hoD8mI2Zsw6zJuIjxLWQTW
         u+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702408134; x=1703012934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rUE7pKrnOIxQx5S7SZFNs2Wa5Tl3bUr3B6PiXYrTnM=;
        b=UUeKd/M3O6ucS0+cHFDj4dqVABbOkNNghl/YK6bQzt6Iy/8lCpLcS7ZQIjaWGCKnGg
         oeDhVX6hNQ6Skd+5VP9Tk+d/m08u+VoHfjro0K7B7+0umEwV7u0WuwOjlWWdodV14LX4
         vYuI92F+gWt5QsXRDrtWzsnMejv8TRc2vHlv1s4IcUnVt2Cxs2xv95m5OhzhIPlTp93P
         oSuKusUQ7AGk0j10VWYu4xSMBzZoUTa+EKHbpc7l3jXvl75LQI+QLMfrxIz3nn2nct95
         GCyhOzaKjeq+sedCmXtXYr870/3jRjJ6f94uk8EW+FtPonuiac8nFbFDt84dHTImSV3o
         Tobw==
X-Gm-Message-State: AOJu0YzfLvO6EfRaOI1j5C7qo/ev3JaPa4a2DHFAYrEbQnV6LRGoGff+
	nUFoR+b8XF3hLMJlohX+jSZZQpT2zj0sRcmps+Rk1A==
X-Google-Smtp-Source: AGHT+IGo6pgC3gqBBgC31XC6ONDH83K9lm+lgkRFNSVphJ4DvQu97KYd8nv6XkgLA1bsO9v5snNs2M6grUX2q4NQSIw=
X-Received: by 2002:a05:6820:47:b0:590:8cbd:5b39 with SMTP id
 v7-20020a056820004700b005908cbd5b39mr4045345oob.15.1702408134126; Tue, 12 Dec
 2023 11:08:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211193048.580691-1-avagin@google.com> <CAOQ4uxik0=0F-6CLRsuaOheFjwWF-B-Q5iEQ6qJbRszL52HeQQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxik0=0F-6CLRsuaOheFjwWF-B-Q5iEQ6qJbRszL52HeQQ@mail.gmail.com>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 12 Dec 2023 11:08:43 -0800
Message-ID: <CAEWA0a6Ow+BvrPm5O-4-tGRLQYr3+eahj45voF1gdmN3OfadGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/proc: show correct device and inode numbers in /proc/pid/maps
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amir,

On Mon, Dec 11, 2023 at 9:51=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> +fsdevel, +overlayfs, +brauner, +miklos
>
> On Mon, Dec 11, 2023 at 9:30=E2=80=AFPM Andrei Vagin <avagin@google.com> =
wrote:
> >
> > Device and inode numbers in /proc/pid/maps have to match numbers return=
ed by
> > statx for the same files.
>
> That statement may be true for regular files.
> It is not true for block/char as far as I know.
>
> I think that your fix will break that by displaying the ino/dev
> of the block/char reference inode and not their backing rdev inode.

I think it doesn't break anything here. /proc/pid/maps shows dev of a
filesystem where the device file resides.

7f336b6c3000-7f336b6c4000 rw-p 00000000 00:05 7
  /dev/zero
$ stat /dev/zero
Device: 0,5 Inode: 7           Links: 1     Device type: 1,5

I checked that it works with and without my patch. It doesn't matter, look =
at
the following comments.

>
> >
> > /proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here i=
s
> > an issue. If a mapped file is on a stackable file system (e.g.,
> > overlayfs), vma->vm_file is a backing file whose f_inode is on the
> > underlying filesystem. To show correct numbers, we need to get a user
> > file and shows its numbers. The same trick is used to show file paths i=
n
> > /proc/pid/maps.
>
> For the *same* trick, see my patch below.

The patch looks good to me. Thanks! Will you send it?

>
> >
> > But it isn't the end of this story. A file system can manipulate inode =
numbers
> > within the getattr callback (e.g., ovl_getattr), so vfs_getattr must be=
 used to
> > get correct numbers.
>
> This explanation is inaccurate, because it mixes two different overlayfs
> traits which are unrelated.
> It is true that a filesystem *can* manipulate st_dev in a way that will n=
ot
> match i_ino and it is true that overlayfs may do that in some non-default
> configurations (see [1]), but this is not the reason that you are seeing
> mismatches ino/dev in /proc/<pid>/maps.
>
> [1] https://docs.kernel.org/filesystems/overlayfs.html#inode-properties
>
> The reason is that the vma->vm_file is a special internal backing file
> which is not otherwise exposed to userspace.
> Please see my suggested fix below.

I understand that this is the main root cause of issues that we have seen.

But when I was preparing this patch, I found that ovl_getattr manipulates
with inode numbers and decided that it can return a different inode number
than file_user_inode(vma->vm_file).i_ino. I am glad that I was wrong and we
don't need to use vfs_getattr here.

>
> >
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> > Signed-off-by: Andrei Vagin <avagin@google.com>

<snip>

>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ef2eb12906da..5328266be6b5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -273,7 +273,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struc=
t *vma)
>         const char *name =3D NULL;
>
>         if (file) {
> -               struct inode *inode =3D file_inode(vma->vm_file);
> +               struct inode *inode =3D file_user_inode(vma->vm_file);
> +
>                 dev =3D inode->i_sb->s_dev;
>                 ino =3D inode->i_ino;
>                 pgoff =3D ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 900d0cd55b50..d78412c6fd47 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2581,20 +2581,28 @@ struct file *backing_file_open(const struct
> path *user_path, int flags,
>  struct path *backing_file_user_path(struct file *f);
>
>  /*
> - * file_user_path - get the path to display for memory mapped file
> - *
>   * When mmapping a file on a stackable filesystem (e.g., overlayfs), the=
 file
>   * stored in ->vm_file is a backing file whose f_inode is on the underly=
ing
> - * filesystem.  When the mapped file path is displayed to user (e.g. via
> - * /proc/<pid>/maps), this helper should be used to get the path to disp=
lay
> - * to the user, which is the path of the fd that user has requested to m=
ap.
> + * filesystem.  When the mapped file path and inode number are displayed=
 to
> + * user (e.g. via /proc/<pid>/maps), these helper should be used to get =
the
> + * path and inode number to display to the user, which is the path of th=
e fd
> + * that user has requested to map and the inode number that would be ret=
urned
> + * by fstat() on that same fd.
>   */
> +/* Get the path to display in /proc/<pid>/maps */
>  static inline const struct path *file_user_path(struct file *f)
>  {
>         if (unlikely(f->f_mode & FMODE_BACKING))
>                 return backing_file_user_path(f);
>         return &f->f_path;
>  }
> +/* Get the inode whose inode number to display in /proc/<pid>/maps */
> +static inline const struct path *file_user_inode(struct file *f)

nit: struct inode *

> +{
> +       if (unlikely(f->f_mode & FMODE_BACKING))
> +               return d_inode(backing_file_user_path(f)->dentry);
> +       return file_inode(f);
> +}

Thanks,
Andrei

