Return-Path: <linux-fsdevel+bounces-72230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7771DCE8E7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 08:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E717D30141EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25D2E091B;
	Tue, 30 Dec 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJewMB4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E0224244
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767080289; cv=none; b=PvXq6w5oGFHDcKbZV/KS2GjLa07MhBqQON4cslrfglsMUuwaAhLFsBrnXKjnVaIdqXrZF4PjTIUPV56X9CDNvifFcvyxCIe+a8lHHEdcflY4W+7xWQ5PU+OvGXUoAmTGwjr+xEfexgEj11dSHnn7/dJ+Ro+CLKsftx6i+dMY6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767080289; c=relaxed/simple;
	bh=SLkGujyyg40oZUI8h9KmuQbdjAJLAkgE4JDqZG0FvKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZKF3vony0Gw14EqIjpgel9SIU/BY4bMd9VO/wUTXUD1uVYSILOXWqnO/vUTIxDokdqCwjL3wd3vFHVgXeE3aHPKCwulWibw/6Fk7wpKWka/DODe79rpGcEpLVk8BzPTDOCxKtlkGpSu6iQd6DiOSotvkEUk05t6CIx1E6rblnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJewMB4y; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c7503c73b4so5115089a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 23:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767080286; x=1767685086; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtuLhiX1X4nLly6twHmuh4hqcDYxp1P5O538tZGArVA=;
        b=MJewMB4yDZPZmxFv4ZDced2/DjAi3h6bEmcGDwRl4QeQwQVx8t3A+h3kbr7+MYMoZZ
         lX8L1wihmgT6hB8n8lUxsifsKzlUdXJ1vTsZVRAPkrQNH3AD0KqNqe69kND+goRYYlca
         Heb8zsUZYMgO40bBq8qJPqKrJIMM7tovhAnTZ22H2ed0/ae/51Kijr5XyC2ln/T0xdgF
         TQe2Fo5mjYemnS2HvMOqVPkbZO+QN0KEOhDeE/C1sswbAyy43/aEhwbaLR8Hk9Xu6FDi
         bajLcGNWiXKOXd9aDF8rzUNAakUrS3q4+erOSaQ+jJG7StB4Rbk557X3HhvwIn8n+0iz
         m3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767080286; x=1767685086;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PtuLhiX1X4nLly6twHmuh4hqcDYxp1P5O538tZGArVA=;
        b=TLHX/GjtvvV6/N+HUc2fEP52h3X94ZgU8++oSKRUXX5Q03nMeu6crhtSG63wBkYJ6Q
         cGcxHmofaJOO/4l6jnb22cB4Y4LppO7qGu+xjE8eS20ww2R8SP2j3vWuyi0ARKIizUdA
         N0yCaDx+ViHjOkp7XKPoWE3HzoEeSXgrO2/t64XW2939ZbYXDKNkskXruHRfH6Lv92t2
         BvC108Mc7JILZ75TkUG7lyBpFkDW8x5MMQ87vSmUfF1LQAS8ysu1HyZQ7RxACK2QG3PH
         K/vaXVxuFkNYd+HDTTS5QOs+mW5G3+EZBc63JPU+EuI0jsZLrN74FrqM8stCf1knmzf5
         UXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu23p7A5wtSJdHeBUq01EGbHQZCQrp2aanZxBo+dpJED+WvExCaYI2Q244s1eREHeXmsSco/UV1S8eQeO1@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFD0T7sF/jXkShvep1KfO60Hv1uVCnkRvJphmCjxj3pEFuyp+
	9UJ6jWyTk6xlfp4kS9DCAKDgbWRY6NLlZ+do7scdRZ9jY+3HG767R5sSE0rRVoFNIpABMfYovcG
	uImQR0H0a+CS5Bi506iPQ7aUWYjibPimGpeit0i7geA==
X-Gm-Gg: AY/fxX6RGd2mCQCt8BmUmcmlLqzdnE/oSVNs3UCZ5RMPhrPh21I6G78Fe9P9ddSBcYN
	M0pDsWO1EomYQk3KIReMWAUNr9yKgdFOjxcf7O6A6unYNf9Rqeu04L5QS0l9ijtIvVwwhaAvdO+
	4L2B5aradIERQKygoDqLnFzUeF+38i2CjnV/Vy57MGfOvioAxOqj43jVNH1Du105rvTtXOLUWnD
	iJbIZfgeT7g4A+hCxN9NFfatww2aB+aW4nIgRZWP1v45189iMKJN9dlpzoyCyu1Rd6Gew==
X-Google-Smtp-Source: AGHT+IGW57MTvyRbD2XdqmR255L7IDXUgbUtXSX2allFjYfb/7Cfe7J8Wplp58j9+Byk0qK3qj5IJF1SaAx2aRYK59A=
X-Received: by 2002:a05:6830:4124:b0:771:5ae2:fcde with SMTP id
 46e09a7af769-7cc668a4b47mr15772989a34.2.1767080285660; Mon, 29 Dec 2025
 23:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALf2hKtp5SQCAzjkY8UvKU6Qqq4Qt=ZSjN18WK_BU==v4JOLuA@mail.gmail.com>
In-Reply-To: <CALf2hKtp5SQCAzjkY8UvKU6Qqq4Qt=ZSjN18WK_BU==v4JOLuA@mail.gmail.com>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Tue, 30 Dec 2025 15:37:53 +0800
X-Gm-Features: AQt7F2qReCUQiEel-r-gWl3TSU78sVDwJpAbhzrBhY6hvuv7Cso-yNZclSrXHa4
Message-ID: <CALf2hKsMc3o+mYg2xwNEFO+q2Z=XteOmCjd1=EHOR0Na3=201Q@mail.gmail.com>
Subject: Re: [Kernel Bug] WARNING in vfat_rmdir
To: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	hirofumi@mail.parknet.co.jp, linux-fsdevel@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux kernel developers and maintainers,

I=E2=80=99m sorry =E2=80=94 the root cause analysis in my previous report w=
as likely
incorrect, and the patch I suggested there does not alleviate the
issue after further testing, which means that the root cause is not on
the errno passing.

After adding debug prints in fat__get_entry(), I observed frequent
cases of err=3D0, phys=3D0 at pos =3D=3D i_size, which means the code is
taking a "normal EOF" path (as decided by fat_bmap()) rather than
hitting and swallowing a negative errno. As a result,
fat_get_short_entry() still returns -ENOENT, fat_dir_empty() still
returns 0, and the code path does not prevent drop_nlink(dir) from
being executed even when the parent directory's i_nlink is already
abnormal. In other words, the parent directory's i_nlink appears to be
wrong/corrupted in the first place. Subsequent vfat_rmdir() calls then
decrement the already-too-low link count, eventually reaching 0 and
triggering WARN_ON(inode->i_nlink =3D=3D 0) in drop_nlink() (and panicking
if panic_on_warn is enabled).

So please IGNORE my previous patch proposal. A conservative mitigation
that I tested EFFECTIVE is similar to the UDF fix for corrupted parent
link count handling (Jan Kara's WARNING in udf_rmdir fix:
"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Dc5566903af56dd1abb092f18dcb0c770d6cd8dcb").

static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
        err =3D fat_remove_entries(dir, &sinfo);  /* and releases bh */
        if (err)
                goto out;
-       drop_nlink(dir);
+       if (dir->i_nlink >=3D 3)
+               drop_nlink(dir);
+       else
+               fat_fs_error_ratelimit(sb, "parent dir link count too
low (%u)\n",
+                       dir->i_nlink);

        clear_nlink(inode);
        fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);

Given that the Syz reproducer (part) looks like:
syz_mount_image$vfat(&(0x7f0000000080), &(0x7f0000001240)=3D'./bus\x00',
0xa00400, &(0x7f0000000000)=3DANY=3D[@ANYRES64=3D0x0], 0x1, 0x1230,
&(0x7f00000024c0)=3D"$XXX...")
r1 =3D openat(0xffffffffffffff9c, &(0x7f0000000040)=3D'.\x00', 0x0, 0x0)
mkdirat(r1, &(0x7f0000000180)=3D'./bus\x00', 0x0)
mkdirat(r1, &(0x7f0000000100)=3D'./file0/file0\x00', 0x0) (rerun: 64)
unlinkat(r1, &(0x7f00000001c0)=3D'./bus/file0\x00', 0x200) (rerun: 64)

I'm still debugging why, with the corrupted image, creation of
./file0/file0 seems to end up writing into bus's directory data blocks
(cluster sharing), so bus's on-disk directory content appears to
contain a subdir entry while bus->i_nlink remains 2.

Best,
Zhiyu Zhang

Zhiyu Zhang <zhiyuzhang999@gmail.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=BA=8C 02:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Dear Linux kernel developers and maintainers,
>
> We would like to report a filesystem corruption triggered bug that
> causes a WARNING in drop_nlink() from the VFAT rmdir path, and leads
> to a kernel panic when panic_on_warn is enabled. The bug titled
> "WARNING in vfat_rmdir" was found on linux-6.17.1 and is also
> reproducible on the latest 6.19-rc3.
>
> The possible root cause is that the FAT directory iteration helpers
> conflate real errors with "end of directory" in a way that hides
> corruption from higher layers. Concretely, fat__get_entry() returns -1
> both when it reaches EOF (!phys) and when fat_bmap() fails due to a
> corrupted cluster chain (err !=3D 0). Then fat_get_short_entry() treats
> any < 0 from fat_get_entry() as "no more entries" and returns -ENOENT.
> As a result, callers such as fat_dir_empty() and fat_subdirs() cannot
> distinguish a genuinely empty directory from a directory walk that
> terminates early due to corruption. In this situation, fat_dir_empty()
> may incorrectly return success (empty), allowing vfat_rmdir() to
> proceed with metadata updates, including drop_nlink(dir). Separately,
> fat_subdirs() may silently "succeed" with an incorrect count (e.g., 0)
> when the walk is cut short, which can further poison in-memory link
> counts when inodes are built from corrupted on-disk state. Eventually,
> the VFAT rmdir path can reach drop_nlink() with an already-zero
> i_nlink, triggering WARN_ON(inode->i_nlink =3D=3D 0) and panicking under
> panic_on_warn.
>
> This bug may lead to denial-of-service on systems that enable
> panic_on_warn, and more broadly to inconsistent in-memory metadata
> updates when operating on corrupted VFAT images.
>
> We suggest the following potential patch:
> (1) Propagate real errors from the directory iteration path instead of
> folding them into -ENOENT and make fat_get_short_entry() translate
> only true EOF into -ENOENT while propagating other negative errors.
> (2) Update fat_dir_empty() / fat_subdirs() to treat propagated errors
> as failures rather than "empty" / a weird count, and handle negative
> returns at their call sites.
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 92b091783966..f4c5a6f0cc84 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -92,8 +92,10 @@ static int fat__get_entry(struct inode *dir, loff_t *p=
os,
>         *bh =3D NULL;
>         iblock =3D *pos >> sb->s_blocksize_bits;
>         err =3D fat_bmap(dir, iblock, &phys, &mapped_blocks, 0, false);
> -       if (err || !phys)
> -               return -1;      /* beyond EOF or error */
> +       if (err)
> +               return err;     /* real error (e.g., -EIO, -EUCLEAN) */
> +       if (!phys)
> +               return -1;      /* beyond EOF */
>
>         fat_dir_readahead(dir, iblock, phys);
>
> @@ -882,12 +884,14 @@ static int fat_get_short_entry(struct inode
> *dir, loff_t *pos,
>                                struct buffer_head **bh,
>                                struct msdos_dir_entry **de)
>  {
> -       while (fat_get_entry(dir, pos, bh, de) >=3D 0) {
> +       int err;
> +       while ((err =3D fat_get_entry(dir, pos, bh, de)) >=3D 0) {
>                 /* free entry or long name entry or volume label */
>                 if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME)=
)
>                         return 0;
>         }
> -       return -ENOENT;
> +       /* -1 is EOF sentinel; propagate other errors */
> +       return (err =3D=3D -1) ? -ENOENT : err;
>  }
>
>  /*
> @@ -919,11 +923,11 @@ int fat_dir_empty(struct inode *dir)
>         struct buffer_head *bh;
>         struct msdos_dir_entry *de;
>         loff_t cpos;
> -       int result =3D 0;
> +       int result =3D 0, err;
>
>         bh =3D NULL;
>         cpos =3D 0;
> -       while (fat_get_short_entry(dir, &cpos, &bh, &de) >=3D 0) {
> +       while ((err =3D fat_get_short_entry(dir, &cpos, &bh, &de)) >=3D 0=
) {
>                 if (strncmp(de->name, MSDOS_DOT   , MSDOS_NAME) &&
>                     strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
>                         result =3D -ENOTEMPTY;
> @@ -931,6 +935,8 @@ int fat_dir_empty(struct inode *dir)
>                 }
>         }
>         brelse(bh);
> +       if (err < 0 && err !=3D -ENOENT)
> +               return err;
>         return result;
>  }
>  EXPORT_SYMBOL_GPL(fat_dir_empty);
> @@ -944,15 +950,17 @@ int fat_subdirs(struct inode *dir)
>         struct buffer_head *bh;
>         struct msdos_dir_entry *de;
>         loff_t cpos;
> -       int count =3D 0;
> +       int count =3D 0, err;
>
>         bh =3D NULL;
>         cpos =3D 0;
> -       while (fat_get_short_entry(dir, &cpos, &bh, &de) >=3D 0) {
> +       while ((err =3D fat_get_short_entry(dir, &cpos, &bh, &de)) >=3D 0=
) {
>                 if (de->attr & ATTR_DIR)
>                         count++;
>         }
>         brelse(bh);
> +       if (err < 0 && err !=3D -ENOENT)
> +               return err;
>         return count;
>  }
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 0b6009cd1844..36ec8901253e 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -535,7 +535,10 @@ int fat_fill_inode(struct inode *inode, struct
> msdos_dir_entry *de)
>                         return error;
>                 MSDOS_I(inode)->mmu_private =3D inode->i_size;
>
> -               set_nlink(inode, fat_subdirs(inode));
> +               int nsubs =3D fat_subdirs(inode);
> +               if (nsubs < 0)
> +                       return nsubs;
> +               set_nlink(inode, nsubs);
>
>                 error =3D fat_validate_dir(inode);
>                 if (error < 0)
> @@ -1345,7 +1348,10 @@ static int fat_read_root(struct inode *inode)
>         fat_save_attrs(inode, ATTR_DIR);
>         inode_set_mtime_to_ts(inode,
>                               inode_set_atime_to_ts(inode,
> inode_set_ctime(inode, 0, 0)));
> -       set_nlink(inode, fat_subdirs(inode)+2);
> +       int nsubs =3D fat_subdirs(inode);
> +       if (nsubs < 0)
> +               return nsubs;
> +       set_nlink(inode, nsubs+2);
>
>         return 0;
>  }
>
> If the approach above is acceptable, we are willing to submit a proper
> patch immediately. Please let us know if any further information is
> required.
>
> Best regards,
> Zhiyu Zhang

