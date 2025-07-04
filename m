Return-Path: <linux-fsdevel+bounces-53917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8112AF8EFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408F3B61390
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A452F3644;
	Fri,  4 Jul 2025 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHJVX2h6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3C2EACEE;
	Fri,  4 Jul 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620400; cv=none; b=e/OwGbR7B0xSh2azDpF7DrhU5NlzrvBfWfQf9u+Efok0QxjGNA9F6MP8FPvvGwJlBt2sfs8x5suho9yk7ZO99UvIdZJPo0VFSbdrMbjWgiIRyzRR9oj1+oGscIIzceyP6kNdAX1m3PGl0jfDSO0ge+aVr474Up+ByeOvSbsxTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620400; c=relaxed/simple;
	bh=lkWAbXw9XrHTF1YSFzyGGGV/iywwkb7qRjkgCRr7qoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4tc9KBJqOo2p1MCALPN8yS0JsVABfaXdHEBHE8evVBIVwztE8D/6i8X8NOkaDyi9COxsWcdZIBgjNjruQdPJiUoq9Tek1I6McASREgZ/wYXNorq8L0Fh3Iu2OC5Yp21Z9y3wB105ny5SIAOApivJ/p5FCEky8CuaqgmucS62BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHJVX2h6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453749af004so3214245e9.1;
        Fri, 04 Jul 2025 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751620396; x=1752225196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfZYO4ycbayyFDmrnQEkk1cRUalL8o7u/oDIAURijNE=;
        b=kHJVX2h6CRLfvk5FQ5uq34sAogpiPA5QmuOhy5ewgioN0NW2CnQmprDfBBsHsB1Sxk
         vBNguQXjNOmWVZSRoHM23xjrCm8eFjGt1IfJqKBzXyWcO+P4vOwsFpDp+spRpnPBV6M4
         KOBc9FLag14cb1ncqd750kQCYiHOCCWu46iYBcWnTaC3qRAR8oznmryhNdncu2MywXbZ
         JRHSa4yu3Io/3/IWxt3Ptvoat3R+dN3aXzBnHWzxB6hjkgp4cfjXmGVYDtQ2mPSY8i7H
         exfujRD/U1l37EJc9QZztgdth9CEfgwrFIJDea553XBq6eB/1eB5S4f/coj/JWb5ZyG4
         gNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751620396; x=1752225196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfZYO4ycbayyFDmrnQEkk1cRUalL8o7u/oDIAURijNE=;
        b=m+/1ptXbQtzPYE/TSj02DNBBAgKHRf2UOE9PvVVjc7vOQWZo2Fw11BsSwyzQiEbVrq
         fzglRmKxGUsWuw9xngddQJD2ZznPZNKRrZGQhAcrt6xtGxTT5+hpkmVh/vy/vIvX97pM
         mZRaq5qmlKbSIEM7pEHMkhgl3u+91iqZI3KqaJQ9XKo/Qt8svdm09gV5XW0sDNXqG19S
         3Q14I81Pl1H1+eVURb9/bJFCu7d+crR+FyGLA+zpJRVjJVf8D6iqy1nkvy/6dQ7l5DpO
         qLNpY+nt3gEHvcObgeVLYvUjdC+b1sz5UKJoPhZ569OUTWqTxL4W79N1j7sjJN2a096S
         KN5w==
X-Forwarded-Encrypted: i=1; AJvYcCW4wtuKW8a5SkxaaG1dfimVWjnS2da43jXN/QA7CEQYGgRFUickjuwiMh/s4A8YIGhWSlZRrwbWPbCWtiB/6Q==@vger.kernel.org, AJvYcCWL4S7oGPBtLnuPuBlNcKZ5pkHAPliWuw2MGIXDm4gH8lXAdOz1SpMZ+FGgSI7ApH6kZSSqSVsm6Eo=@vger.kernel.org, AJvYcCXGlWK12YksFmBy/xRfBou+oTdRsnWj5UQomEKi03MpfAcNLe7GEEn8QRsZ1+VxsiU/TvjPmUlFjwdC@vger.kernel.org, AJvYcCXbEzIhM4xhUe+k9sD2MomJ802iGvewpJa+SeF8YlGdP+yVTY8qEIR1yD4G/J4tpjJcgFUhuqNDXm6FuZ2w@vger.kernel.org
X-Gm-Message-State: AOJu0YzHu64qOgFB8s+0TL4ESEbZ4XnATabOYNgvbLARnb5ILaRbfxsa
	mH4/PdzRfeI1qIin5LylpwNDS4FZink/2MGh0OIa0WAYBDpztz9A3B4TdJ7JdRi50wUVBd9jKMY
	CkOO7Bm8cOonm3mPCS+T9Q73bp3TQlaY=
X-Gm-Gg: ASbGncsOF3XPabL+fIdLmgqxnYdk78nS1PBn7Rru17Hi+3BYczslCCe2X4XNnMkxw4R
	KPZhy1ZpCpiF3bb9oMcRbCTAwHB0C1JaopIkoewcYHzjNAMc2cN2+H3H92GUMKqGPnIGUbNguVX
	HE3UykI2WKFcxX6gLE/7wxwip976B7JKZ/McwD9Cm1qok=
X-Google-Smtp-Source: AGHT+IEnrEQAh4ik8wXWI7DJJ2Dpomun2GN5NrTGMuOpghbsOQfpvgtARmEqC+L/qMwZGKO9xFrv3bfZnsnBbnMSmb0=
X-Received: by 2002:a05:600c:8506:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-454b306fabbmr17149545e9.3.1751620396089; Fri, 04 Jul 2025
 02:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-16-john@groves.net>
In-Reply-To: <20250703185032.46568-16-john@groves.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Jul 2025 11:13:04 +0200
X-Gm-Features: Ac12FXx8Fhl4lD8hEbxN0FLDrMVkaIWP1KemjpxuFoRhZqjfDAm90Oq3HbQSDD0
Message-ID: <CAOQ4uxgqXVX8uynEZduNEor0XhgVvch+WK2esiiSJ1G=iy_bcg@mail.gmail.com>
Subject: Re: [RFC V2 15/18] famfs_fuse: Plumb dax iomap and fuse read/write/mmap
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:51=E2=80=AFPM John Groves <John@groves.net> wrote:
>
> This commit fills in read/write/mmap handling for famfs files. The
> dev_dax_iomap interface is used - just like xfs in fs-dax mode.
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/famfs.c  | 436 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/file.c   |  14 ++
>  fs/fuse/fuse_i.h |   3 +
>  3 files changed, 453 insertions(+)
>
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index f5e01032b825..1973eb10b60b 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c
> @@ -585,3 +585,439 @@ famfs_file_init_dax(
>         return rc;
>  }
>
> +/*********************************************************************
> + * iomap_operations
> + *
> + * This stuff uses the iomap (dax-related) helpers to resolve file offse=
ts to
> + * offsets within a dax device.
> + */
> +
> +static ssize_t famfs_file_bad(struct inode *inode);
> +
> +static int
> +famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *io=
map,
> +                        loff_t file_offset, off_t len, unsigned int flag=
s)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct famfs_file_meta *meta =3D fi->famfs_meta;
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
> +       loff_t local_offset =3D file_offset;
> +       int i;
> +
> +       /* This function is only for extent_type INTERLEAVED_EXTENT */
> +       if (meta->fm_extent_type !=3D INTERLEAVED_EXTENT) {
> +               pr_err("%s: bad extent type\n", __func__);
> +               goto err_out;
> +       }
> +
> +       if (famfs_file_bad(inode))
> +               goto err_out;
> +
> +       iomap->offset =3D file_offset;
> +
> +       for (i =3D 0; i < meta->fm_niext; i++) {
> +               struct famfs_meta_interleaved_ext *fei =3D &meta->ie[i];
> +               u64 chunk_size =3D fei->fie_chunk_size;
> +               u64 nstrips =3D fei->fie_nstrips;
> +               u64 ext_size =3D fei->fie_nbytes;
> +
> +               ext_size =3D min_t(u64, ext_size, meta->file_size);
> +
> +               if (ext_size =3D=3D 0) {
> +                       pr_err("%s: ext_size=3D%lld file_size=3D%ld\n",
> +                              __func__, fei->fie_nbytes, meta->file_size=
);
> +                       goto err_out;
> +               }
> +
> +               /* Is the data is in this striped extent? */
> +               if (local_offset < ext_size) {
> +                       u64 chunk_num       =3D local_offset / chunk_size=
;
> +                       u64 chunk_offset    =3D local_offset % chunk_size=
;
> +                       u64 stripe_num      =3D chunk_num / nstrips;
> +                       u64 strip_num       =3D chunk_num % nstrips;
> +                       u64 chunk_remainder =3D chunk_size - chunk_offset=
;
> +                       u64 strip_offset    =3D chunk_offset + (stripe_nu=
m * chunk_size);
> +                       u64 strip_dax_ofs =3D fei->ie_strips[strip_num].e=
xt_offset;
> +                       u64 strip_devidx =3D fei->ie_strips[strip_num].de=
v_index;
> +
> +                       if (!fc->dax_devlist->devlist[strip_devidx].valid=
) {
> +                               pr_err("%s: daxdev=3D%lld invalid\n", __f=
unc__,
> +                                       strip_devidx);
> +                               goto err_out;
> +                       }
> +                       iomap->addr    =3D strip_dax_ofs + strip_offset;
> +                       iomap->offset  =3D file_offset;
> +                       iomap->length  =3D min_t(loff_t, len, chunk_remai=
nder);
> +
> +                       iomap->dax_dev =3D fc->dax_devlist->devlist[strip=
_devidx].devp;
> +
> +                       iomap->type    =3D IOMAP_MAPPED;
> +                       iomap->flags   =3D flags;
> +
> +                       return 0;
> +               }
> +               local_offset -=3D ext_size; /* offset is beyond this stri=
ped extent */
> +       }
> +
> + err_out:
> +       pr_err("%s: err_out\n", __func__);
> +
> +       /* We fell out the end of the extent list.
> +        * Set iomap to zero length in this case, and return 0
> +        * This just means that the r/w is past EOF
> +        */
> +       iomap->addr    =3D 0; /* there is no valid dax device offset */
> +       iomap->offset  =3D file_offset; /* file offset */
> +       iomap->length  =3D 0; /* this had better result in no access to d=
ax mem */
> +       iomap->dax_dev =3D NULL;
> +       iomap->type    =3D IOMAP_MAPPED;
> +       iomap->flags   =3D flags;
> +
> +       return 0;
> +}
> +
> +/**
> + * famfs_fileofs_to_daxofs() - Resolve (file, offset, len) to (daxdev, o=
ffset, len)
> + *
> + * This function is called by famfs_fuse_iomap_begin() to resolve an off=
set in a
> + * file to an offset in a dax device. This is upcalled from dax from cal=
ls to
> + * both  * dax_iomap_fault() and dax_iomap_rw(). Dax finishes the job re=
solving
> + * a fault to a specific physical page (the fault case) or doing a memcp=
y
> + * variant (the rw case)
> + *
> + * Pages can be PTE (4k), PMD (2MiB) or (theoretically) PuD (1GiB)
> + * (these sizes are for X86; may vary on other cpu architectures
> + *
> + * @inode:  The file where the fault occurred
> + * @iomap:       To be filled in to indicate where to find the right mem=
ory,
> + *               relative  to a dax device.
> + * @file_offset: Within the file where the fault occurred (will be page =
boundary)
> + * @len:         The length of the faulted mapping (will be a page multi=
ple)
> + *               (will be trimmed in *iomap if it's disjoint in the exte=
nt list)
> + * @flags:
> + *
> + * Return values: 0. (info is returned in a modified @iomap struct)
> + */
> +static int
> +famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
> +                        loff_t file_offset, off_t len, unsigned int flag=
s)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct famfs_file_meta *meta =3D fi->famfs_meta;
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
> +       loff_t local_offset =3D file_offset;
> +       int i;
> +
> +       if (!fc->dax_devlist) {
> +               pr_err("%s: null dax_devlist\n", __func__);
> +               goto err_out;
> +       }
> +
> +       if (famfs_file_bad(inode))
> +               goto err_out;
> +
> +       if (meta->fm_extent_type =3D=3D INTERLEAVED_EXTENT)
> +               return famfs_interleave_fileofs_to_daxofs(inode, iomap,
> +                                                         file_offset,
> +                                                         len, flags);
> +
> +       iomap->offset =3D file_offset;
> +
> +       for (i =3D 0; i < meta->fm_nextents; i++) {
> +               /* TODO: check devindex too */
> +               loff_t dax_ext_offset =3D meta->se[i].ext_offset;
> +               loff_t dax_ext_len    =3D meta->se[i].ext_len;
> +               u64 daxdev_idx =3D meta->se[i].dev_index;
> +
> +               if ((dax_ext_offset =3D=3D 0) &&
> +                   (meta->file_type !=3D FAMFS_SUPERBLOCK))
> +                       pr_warn("%s: zero offset on non-superblock file!!=
\n",
> +                               __func__);
> +
> +               /* local_offset is the offset minus the size of extents s=
kipped
> +                * so far; If local_offset < dax_ext_len, the data of int=
erest
> +                * starts in this extent
> +                */
> +               if (local_offset < dax_ext_len) {
> +                       loff_t ext_len_remainder =3D dax_ext_len - local_=
offset;
> +                       struct famfs_daxdev *dd;
> +
> +                       dd =3D &fc->dax_devlist->devlist[daxdev_idx];
> +
> +                       if (!dd->valid || dd->error) {
> +                               pr_err("%s: daxdev=3D%lld %s\n", __func__=
,
> +                                      daxdev_idx,
> +                                      dd->valid ? "error" : "invalid");
> +                               goto err_out;
> +                       }
> +
> +                       /*
> +                        * OK, we found the file metadata extent where th=
is
> +                        * data begins
> +                        * @local_offset      - The offset within the cur=
rent
> +                        *                      extent
> +                        * @ext_len_remainder - Remaining length of ext a=
fter
> +                        *                      skipping local_offset
> +                        * Outputs:
> +                        * iomap->addr:   the offset within the dax devic=
e where
> +                        *                the  data starts
> +                        * iomap->offset: the file offset
> +                        * iomap->length: the valid length resolved here
> +                        */
> +                       iomap->addr    =3D dax_ext_offset + local_offset;
> +                       iomap->offset  =3D file_offset;
> +                       iomap->length  =3D min_t(loff_t, len, ext_len_rem=
ainder);
> +
> +                       iomap->dax_dev =3D fc->dax_devlist->devlist[daxde=
v_idx].devp;
> +
> +                       iomap->type    =3D IOMAP_MAPPED;
> +                       iomap->flags   =3D flags;
> +                       return 0;
> +               }
> +               local_offset -=3D dax_ext_len; /* Get ready for the next =
extent */
> +       }
> +
> + err_out:
> +       pr_err("%s: err_out\n", __func__);
> +
> +       /* We fell out the end of the extent list.
> +        * Set iomap to zero length in this case, and return 0
> +        * This just means that the r/w is past EOF
> +        */
> +       iomap->addr    =3D 0; /* there is no valid dax device offset */
> +       iomap->offset  =3D file_offset; /* file offset */
> +       iomap->length  =3D 0; /* this had better result in no access to d=
ax mem */
> +       iomap->dax_dev =3D NULL;
> +       iomap->type    =3D IOMAP_MAPPED;
> +       iomap->flags   =3D flags;
> +
> +       return 0;
> +}
> +
> +/**
> + * famfs_fuse_iomap_begin() - Handler for iomap_begin upcall from dax
> + *
> + * This function is pretty simple because files are
> + * * never partially allocated
> + * * never have holes (never sparse)
> + * * never "allocate on write"
> + *
> + * @inode:  inode for the file being accessed
> + * @offset: offset within the file
> + * @length: Length being accessed at offset
> + * @flags:
> + * @iomap:  iomap struct to be filled in, resolving (offset, length) to
> + *          (daxdev, offset, len)
> + * @srcmap:
> + */
> +static int
> +famfs_fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length=
,
> +                 unsigned int flags, struct iomap *iomap, struct iomap *=
srcmap)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct famfs_file_meta *meta =3D fi->famfs_meta;
> +       size_t size;
> +
> +       size =3D i_size_read(inode);
> +
> +       WARN_ON(size !=3D meta->file_size);
> +
> +       return famfs_fileofs_to_daxofs(inode, iomap, offset, length, flag=
s);
> +}
> +
> +/* Note: We never need a special set of write_iomap_ops because famfs ne=
ver
> + * performs allocation on write.
> + */
> +const struct iomap_ops famfs_iomap_ops =3D {
> +       .iomap_begin            =3D famfs_fuse_iomap_begin,
> +};
> +
> +/*********************************************************************
> + * vm_operations
> + */
> +static vm_fault_t
> +__famfs_fuse_filemap_fault(struct vm_fault *vmf, unsigned int pe_size,
> +                     bool write_fault)
> +{
> +       struct inode *inode =3D file_inode(vmf->vma->vm_file);
> +       vm_fault_t ret;
> +       pfn_t pfn;
> +
> +       if (!IS_DAX(file_inode(vmf->vma->vm_file))) {
> +               pr_err("%s: file not marked IS_DAX!!\n", __func__);
> +               return VM_FAULT_SIGBUS;
> +       }
> +
> +       if (write_fault) {
> +               sb_start_pagefault(inode->i_sb);
> +               file_update_time(vmf->vma->vm_file);
> +       }
> +
> +       ret =3D dax_iomap_fault(vmf, pe_size, &pfn, NULL, &famfs_iomap_op=
s);
> +       if (ret & VM_FAULT_NEEDDSYNC)
> +               ret =3D dax_finish_sync_fault(vmf, pe_size, pfn);
> +
> +       if (write_fault)
> +               sb_end_pagefault(inode->i_sb);
> +
> +       return ret;
> +}
> +
> +static inline bool
> +famfs_is_write_fault(struct vm_fault *vmf)
> +{
> +       return (vmf->flags & FAULT_FLAG_WRITE) &&
> +              (vmf->vma->vm_flags & VM_SHARED);
> +}
> +
> +static vm_fault_t
> +famfs_filemap_fault(struct vm_fault *vmf)
> +{
> +       return __famfs_fuse_filemap_fault(vmf, 0, famfs_is_write_fault(vm=
f));
> +}
> +
> +static vm_fault_t
> +famfs_filemap_huge_fault(struct vm_fault *vmf, unsigned int pe_size)
> +{
> +       return __famfs_fuse_filemap_fault(vmf, pe_size, famfs_is_write_fa=
ult(vmf));
> +}
> +
> +static vm_fault_t
> +famfs_filemap_page_mkwrite(struct vm_fault *vmf)
> +{
> +       return __famfs_fuse_filemap_fault(vmf, 0, true);
> +}
> +
> +static vm_fault_t
> +famfs_filemap_pfn_mkwrite(struct vm_fault *vmf)
> +{
> +       return __famfs_fuse_filemap_fault(vmf, 0, true);
> +}
> +
> +static vm_fault_t
> +famfs_filemap_map_pages(struct vm_fault        *vmf, pgoff_t start_pgoff=
,
> +                       pgoff_t end_pgoff)
> +{
> +       return filemap_map_pages(vmf, start_pgoff, end_pgoff);
> +}
> +
> +const struct vm_operations_struct famfs_file_vm_ops =3D {
> +       .fault          =3D famfs_filemap_fault,
> +       .huge_fault     =3D famfs_filemap_huge_fault,
> +       .map_pages      =3D famfs_filemap_map_pages,
> +       .page_mkwrite   =3D famfs_filemap_page_mkwrite,
> +       .pfn_mkwrite    =3D famfs_filemap_pfn_mkwrite,
> +};
> +
> +/*********************************************************************
> + * file_operations
> + */
> +
> +/**
> + * famfs_file_bad() - Check for files that aren't in a valid state
> + *
> + * @inode - inode
> + *
> + * Returns: 0=3Dsuccess
> + *          -errno=3Dfailure
> + */
> +static ssize_t
> +famfs_file_bad(struct inode *inode)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct famfs_file_meta *meta =3D fi->famfs_meta;
> +       size_t i_size =3D i_size_read(inode);
> +
> +       if (!meta) {
> +               pr_err("%s: un-initialized famfs file\n", __func__);
> +               return -EIO;
> +       }
> +       if (meta->error) {
> +               pr_debug("%s: previously detected metadata errors\n", __f=
unc__);
> +               return -EIO;
> +       }
> +       if (i_size !=3D meta->file_size) {
> +               pr_warn("%s: i_size overwritten from %ld to %ld\n",
> +                      __func__, meta->file_size, i_size);
> +               meta->error =3D true;
> +               return -ENXIO;
> +       }
> +       if (!IS_DAX(inode)) {
> +               pr_debug("%s: inode %llx IS_DAX is false\n", __func__, (u=
64)inode);
> +               return -ENXIO;
> +       }
> +       return 0;
> +}
> +
> +static ssize_t
> +famfs_fuse_rw_prep(struct kiocb *iocb, struct iov_iter *ubuf)
> +{
> +       struct inode *inode =3D iocb->ki_filp->f_mapping->host;
> +       size_t i_size =3D i_size_read(inode);
> +       size_t count =3D iov_iter_count(ubuf);
> +       size_t max_count;
> +       ssize_t rc;
> +
> +       rc =3D famfs_file_bad(inode);
> +       if (rc)
> +               return rc;
> +
> +       max_count =3D max_t(size_t, 0, i_size - iocb->ki_pos);
> +
> +       if (count > max_count)
> +               iov_iter_truncate(ubuf, max_count);
> +
> +       if (!iov_iter_count(ubuf))
> +               return 0;
> +
> +       return rc;
> +}
> +
> +ssize_t
> +famfs_fuse_read_iter(struct kiocb *iocb, struct iov_iter       *to)
> +{
> +       ssize_t rc;
> +
> +       rc =3D famfs_fuse_rw_prep(iocb, to);
> +       if (rc)
> +               return rc;
> +
> +       if (!iov_iter_count(to))
> +               return 0;
> +
> +       rc =3D dax_iomap_rw(iocb, to, &famfs_iomap_ops);
> +
> +       file_accessed(iocb->ki_filp);
> +       return rc;
> +}
> +
> +ssize_t
> +famfs_fuse_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +       ssize_t rc;
> +
> +       rc =3D famfs_fuse_rw_prep(iocb, from);
> +       if (rc)
> +               return rc;
> +
> +       if (!iov_iter_count(from))
> +               return 0;
> +
> +       return dax_iomap_rw(iocb, from, &famfs_iomap_ops);
> +}
> +
> +int
> +famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct inode *inode =3D file_inode(file);
> +       ssize_t rc;
> +
> +       rc =3D famfs_file_bad(inode);
> +       if (rc)
> +               return (int)rc;
> +
> +       file_accessed(file);
> +       vma->vm_ops =3D &famfs_file_vm_ops;
> +       vm_flags_set(vma, VM_HUGEPAGE);
> +       return 0;
> +}
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 5d205eadb48f..24a14b176510 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1874,6 +1874,8 @@ static ssize_t fuse_file_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
>
>         if (FUSE_IS_VIRTIO_DAX(fi))
>                 return fuse_dax_read_iter(iocb, to);
> +       if (fuse_file_famfs(fi))
> +               return famfs_fuse_read_iter(iocb, to);
>
>         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
>         if (ff->open_flags & FOPEN_DIRECT_IO)
> @@ -1896,6 +1898,8 @@ static ssize_t fuse_file_write_iter(struct kiocb *i=
ocb, struct iov_iter *from)
>
>         if (FUSE_IS_VIRTIO_DAX(fi))
>                 return fuse_dax_write_iter(iocb, from);
> +       if (fuse_file_famfs(fi))
> +               return famfs_fuse_write_iter(iocb, from);
>
>         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
>         if (ff->open_flags & FOPEN_DIRECT_IO)
> @@ -1911,10 +1915,14 @@ static ssize_t fuse_splice_read(struct file *in, =
loff_t *ppos,
>                                 unsigned int flags)
>  {
>         struct fuse_file *ff =3D in->private_data;
> +       struct inode *inode =3D file_inode(in);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>
>         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
>         if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_=
IO))
>                 return fuse_passthrough_splice_read(in, ppos, pipe, len, =
flags);
> +       else if (fuse_file_famfs(fi))
> +               return -EIO; /* direct I/O doesn't make sense in dax_ioma=
p */
>         else
>                 return filemap_splice_read(in, ppos, pipe, len, flags);
>  }
> @@ -1923,10 +1931,14 @@ static ssize_t fuse_splice_write(struct pipe_inod=
e_info *pipe, struct file *out,
>                                  loff_t *ppos, size_t len, unsigned int f=
lags)
>  {
>         struct fuse_file *ff =3D out->private_data;
> +       struct inode *inode =3D file_inode(out);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>
>         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
>         if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_=
IO))
>                 return fuse_passthrough_splice_write(pipe, out, ppos, len=
, flags);
> +       else if (fuse_file_famfs(fi))
> +               return -EIO; /* direct I/O doesn't make sense in dax_ioma=
p */
>         else
>                 return iter_file_splice_write(pipe, out, ppos, len, flags=
);
>  }

This looks odd.

Usually, the methods first check for FUSE_IS_VIRTIO_DAX() and
fuse_file_famfs() to get this condition out of the way so I never needed
to think about whether or not the code verifies that fuse_file_passthrough(=
)
and fuse_file_famfs() cannot co-exist.

Is there a reason why you did not follow the same pattern here?

Also, your comment makes no sense.
splice is not the case of direct I/O - quite the contrary.

Thanks,
Amir.

