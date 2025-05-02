Return-Path: <linux-fsdevel+bounces-47894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA290AA6A56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 07:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DBA466C67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34841D90DF;
	Fri,  2 May 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOXfPbNr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8E2C18A;
	Fri,  2 May 2025 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164909; cv=none; b=J0bdUFWjmwmZKBB1UNrZR2eikxxpthL/R7Uj8GKIB28BuviG8VdS6CTfx6tOCPqTlnmC5i5hfJkaPk0GoXZBiKdlJK6+RgPOG0mDzhTNQq/z/wtDLCIQOhwHGyyOQMoj09jgvrwBe5pPUjKWPbxOngNn5PTD3bLqsa+OfVkIIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164909; c=relaxed/simple;
	bh=E4cIdm4Yk4NBPkZJAVi9mQOYnLYGAZE4OCKJJqJREa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htm1aqPzCfejAwsYH9+MwUvVa1UE3Ry4kg9o+VweKm0mCdXwWGyxFdrUpMxqi6UyeEP/RCuAH8jvyWpZzsOT/a5FHsGLGr4SYJb2hayKTeSw+Hnw5vvDKiG6AZPOaNWLh9xt/SVi5FN1RUoJJPXmJuR9mkkYX5w3dReK+X8o1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOXfPbNr; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47664364628so20433331cf.1;
        Thu, 01 May 2025 22:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746164906; x=1746769706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU7KDr3B+gxOZEqSJGy5fx6hw8wbeuV4k1q+HAcKKSM=;
        b=nOXfPbNrHVVNch24/Qe8mppxVeznLieatkqbDZFgJmq46atR8R3ZQQ+qCPqIPRgPX6
         rdXXk1un1lnXDpG/U4UL3H1BySnHT5kn9WIVrx01Db8hM8q/pGq/VZJWWGj6gjfWRZ8s
         b3Sb/JiY4kOTFEtXkquIvUfCDqSkO50975A3SwL37skJfAEq8aERKddltiTYQN/KMkFB
         K8VkClFZUP8K1Bc2KkLm2qS4FjvfH5N9g7jl09315ApDlv3Npwt/3zIPFY0CpX2M4BWR
         8Ob2k4UB8HhqO1bbJ9Mhwl5tz+f/Z2Iy9oVTNEZ+zfVe60RqZe9KqahxRrDQSmZUheKl
         pbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746164906; x=1746769706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU7KDr3B+gxOZEqSJGy5fx6hw8wbeuV4k1q+HAcKKSM=;
        b=hqB0nXVKbLwx/jymsfBhHGeH1ZdDZqiyKqejwpQ4lxbsH0lBaNlVkURxLKp2ktepxw
         7GpRX2QjTEFvl7NxuO+YQmLNs+qKLO/QzZUItN+1q6Cee+H2W1Rkbsq1bICoBSazVzS5
         /lqSit+j5Qg4wFYMavsx5OmN0hOAqTEs1ePcB/6caPq7Z1gxBcw+SOKAuN6YY/oWcX+Q
         sPpWx3QIk2pJ0gmUDfR/qFEcuFD/juLRvUHQk0kRkHrR+NPeBYyQrkZJ/ff0vkCuc+Z8
         JaYq/SXTzLE3StymjNmpWJRUk5DAagTyb3mjEXSKHAehWiwoh5JjeZ2ypznqjXWW3rcd
         wBEA==
X-Forwarded-Encrypted: i=1; AJvYcCUCaDeji9FkjEzZG2mIib315zCMAQHvewJCNKe2DGIyqGNfk1vsBRsYHRjp3yu2/78IIz1zCqib9iV4@vger.kernel.org, AJvYcCW1g6YhzSORxPdGMTXPSndMOeWiMUcZJA0cw5jggCbFuvTdgm5f9Y6D6gA0J/gBAOEeaLl6xqlrN1+Hqq8V@vger.kernel.org, AJvYcCW5wnNCyllH3Y4Lp8NTmtg6miB+bU7HioaXjhmS1fRm45pjfgXXhZi+svzkrOoDB30a+oZB2l0z8uA3JBAWNw==@vger.kernel.org, AJvYcCX4csyu7n0wzEaA+iQ7ds2vlckDMCjZ7goa39pfEGLFvNcaJ2TeWwA+u0hCCq/HpqrwpLuz8T+3OHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtx0ejufgaNLfqVpY7eCMtW0QDY7sEJ/cCa6f2n/VQ/uk20LO
	WUwti8FwMZH9g3F1GYF4pGQe2rfEd0Lzrg0tdXpB4fLq7R1usKhlXIHag+mHf63iybZteh1LiCD
	qbeuzSPI/HeZiNQXGSBOHSN4jJQY=
X-Gm-Gg: ASbGncvLMwcLrmAjS6pjzfH/Y9qaBmbV/Ngcb3h7aOCnGQa7F2z12f5R0pXPEQgCOAY
	uy4HuBlyHNTm/ByIkl2wyRxEQoVxPIFKvkyaZTiOoWTJxCqEqrJcRqmA+qN/N9MMCdxXw6SiYC/
	GOYSMAHajd284Rcmkk6O9/bQ==
X-Google-Smtp-Source: AGHT+IFmZPnZkAauSaRSorFdBXAkR5lrLDFw+FkQteTTsO2Zxz32GnBXgPvfe/Zp0jl6JdpXBer38Pn0wkj4B+K88Lg=
X-Received: by 2002:a05:622a:a08e:b0:47b:3a2:ff1f with SMTP id
 d75a77b69052e-48c19509a55mr20781061cf.12.1746164906292; Thu, 01 May 2025
 22:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421013346.32530-1-john@groves.net> <20250421013346.32530-13-john@groves.net>
In-Reply-To: <20250421013346.32530-13-john@groves.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 1 May 2025 22:48:15 -0700
X-Gm-Features: ATxdqUFm07R3lMzBZ8ic4X3it7bTYwmvUC8aaVs3MjVQ4g_e5vUg3YA-iqe0JHg
Message-ID: <CAJnrk1ZRSoMN+jan5D9d3UYWnTVxc_5KVaBtP7JV2b+0skrBfg@mail.gmail.com>
Subject: Re: [RFC PATCH 12/19] famfs_fuse: Plumb the GET_FMAP message/response
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredb.hu>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>, 
	Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 6:34=E2=80=AFPM John Groves <John@groves.net> wrote=
:
>
> Upon completion of a LOOKUP, if we're in famfs-mode we do a GET_FMAP to
> retrieve and cache up the file-to-dax map in the kernel. If this
> succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/dir.c             | 69 +++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h          | 36 +++++++++++++++++++-
>  fs/fuse/inode.c           | 15 +++++++++
>  include/uapi/linux/fuse.h |  4 +++
>  4 files changed, 123 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index bc29db0117f4..ae135c55b9f6 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -359,6 +359,56 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
>         return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->siz=
e);
>  }
>
> +#define FMAP_BUFSIZE 4096
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +static void
> +fuse_get_fmap_init(
> +       struct fuse_conn *fc,
> +       struct fuse_args *args,
> +       u64 nodeid,
> +       void *outbuf,
> +       size_t outbuf_size)
> +{
> +       memset(outbuf, 0, outbuf_size);

I think we can skip the memset here since kcalloc will zero out the
memory automatically when the fmap_buf gets allocated

> +       args->opcode =3D FUSE_GET_FMAP;
> +       args->nodeid =3D nodeid;
> +
> +       args->in_numargs =3D 0;
> +
> +       args->out_numargs =3D 1;
> +       args->out_args[0].size =3D FMAP_BUFSIZE;
> +       args->out_args[0].value =3D outbuf;
> +}
> +
> +static int
> +fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
> +{
> +       size_t fmap_size;
> +       void *fmap_buf;
> +       int err;
> +
> +       pr_notice("%s: nodeid=3D%lld, inode=3D%llx\n", __func__,
> +                 nodeid, (u64)inode);
> +       fmap_buf =3D kcalloc(1, FMAP_BUFSIZE, GFP_KERNEL);
> +       FUSE_ARGS(args);
> +       fuse_get_fmap_init(fm->fc, &args, nodeid, fmap_buf, FMAP_BUFSIZE)=
;
> +
> +       /* Send GET_FMAP command */
> +       err =3D fuse_simple_request(fm, &args);

I'm assuming the fmap_buf gets freed in a later patch, but for this
one we'll probably need a kfree(fmap_buf) here in the meantime?

> +       if (err) {
> +               pr_err("%s: err=3D%d from fuse_simple_request()\n",
> +                      __func__, err);
> +               return err;
> +       }
> +
> +       fmap_size =3D args.out_args[0].size;
> +       pr_notice("%s: nodei=3D%lld fmap_size=3D%ld\n", __func__, nodeid,=
 fmap_size);
> +
> +       return 0;
> +}
> +#endif
> +
>  int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qs=
tr *name,
>                      struct fuse_entry_out *outarg, struct inode **inode)
>  {
> @@ -404,6 +454,25 @@ int fuse_lookup_name(struct super_block *sb, u64 nod=
eid, const struct qstr *name
>                 fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
>                 goto out;
>         }
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       if (fm->fc->famfs_iomap) {
> +               if (S_ISREG((*inode)->i_mode)) {
> +                       /* Note Lookup returns the looked-up inode in the=
 attr
> +                        * struct, but not in outarg->nodeid !
> +                        */
> +                       pr_notice("%s: outarg: size=3D%d nodeid=3D%lld at=
tr.ino=3D%lld\n",
> +                                __func__, args.out_args[0].size, outarg-=
>nodeid,
> +                                outarg->attr.ino);
> +                       /* Get the famfs fmap */
> +                       fuse_get_fmap(fm, *inode, outarg->attr.ino);

I agree with Darrick's comment about fetching the mappings only if the
file gets opened. I wonder though if we could bundle the open with the
get_fmap so that we don't have to do an additional request / incur 2
extra context switches. This seems feasible to me. When we send the
open request, we could check if fc->famfs_iomap is set and if so, set
inarg.open_flags to include FUSE_OPEN_GET_FMAP and set outarg.value to
an allocated buffer that holds both struct fuse_open_out and the
fmap_buf and adjust outarg.size accordingly. Then the server could
send both the open and corresponding fmap data in the reply.

> +               } else
> +                       pr_notice("%s: no get_fmap for non-regular file\n=
",
> +                                __func__);
> +       } else
> +               pr_notice("%s: fc->dax_iomap is not set\n", __func__);
> +#endif
> +
>         err =3D 0;
>
>   out_put_forget:
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 931613102d32..437177c2f092 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -193,6 +193,10 @@ struct fuse_inode {
>         /** Reference to backing file in passthrough mode */
>         struct fuse_backing *fb;
>  #endif
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       void *famfs_meta;
> +#endif
>  };
>
>  /** FUSE inode state bits */
> @@ -942,6 +946,8 @@ struct fuse_conn {
>  #endif
>
>  #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       struct rw_semaphore famfs_devlist_sem;
> +       struct famfs_dax_devlist *dax_devlist;
>         char *shadow;
>  #endif
>  };
> @@ -1432,11 +1438,14 @@ void fuse_free_conn(struct fuse_conn *fc);
>
>  /* dax.c */
>
> +static inline int fuse_file_famfs(struct fuse_inode *fi); /* forward */
> +
>  /* This macro is used by virtio_fs, but now it also needs to filter for
>   * "not famfs"
>   */
>  #define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)    \
> -                                       && IS_DAX(&fuse_inode->inode))
> +                                       && IS_DAX(&fuse_inode->inode)   \
> +                                       && !fuse_file_famfs(fuse_inode))
>
>  ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
>  ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
> @@ -1547,4 +1556,29 @@ extern void fuse_sysctl_unregister(void);
>  #define fuse_sysctl_unregister()       do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>
> +/* famfs.c */
> +static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
> +                                                      void *meta)
> +{
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       return xchg(&fi->famfs_meta, meta);
> +#else
> +       return NULL;
> +#endif
> +}
> +
> +static inline void famfs_meta_free(struct fuse_inode *fi)
> +{
> +       /* Stub wil be connected in a subsequent commit */
> +}
> +
> +static inline int fuse_file_famfs(struct fuse_inode *fi)
> +{
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       return (fi->famfs_meta !=3D NULL);

Does this need to be "return READ_ONCE(fi->famfs_meta) !=3D NULL"?

> +#else
> +       return 0;
> +#endif
> +}
> +
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 7f4b73e739cb..848c8818e6f7 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -117,6 +117,9 @@ static struct inode *fuse_alloc_inode(struct super_bl=
ock *sb)
>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 fuse_inode_backing_set(fi, NULL);
>
> +       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> +               famfs_meta_set(fi, NULL);

"fi->famfs_meta =3D NULL;" looks simpler here

> +
>         return &fi->inode;
>
>  out_free_forget:
> @@ -138,6 +141,13 @@ static void fuse_free_inode(struct inode *inode)
>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 fuse_backing_put(fuse_inode_backing(fi));
>
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       if (S_ISREG(inode->i_mode) && fi->famfs_meta) {
> +               famfs_meta_free(fi);
> +               famfs_meta_set(fi, NULL);
> +       }
> +#endif
> +
>         kmem_cache_free(fuse_inode_cachep, fi);
>  }
>
> @@ -1002,6 +1012,11 @@ void fuse_conn_init(struct fuse_conn *fc, struct f=
use_mount *fm,
>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 fuse_backing_files_init(fc);
>
> +       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)) {
> +               pr_notice("%s: Kernel is FUSE_FAMFS_DAX capable\n", __fun=
c__);
> +               init_rwsem(&fc->famfs_devlist_sem);
> +       }

Should we only init this if the server chooses to opt into famfs (eg
if their init reply sets the FUSE_DAX_FMAP flag)? This imo seems to
belong more in process_init_reply().


Thanks,
Joanne
> +
>         INIT_LIST_HEAD(&fc->mounts);
>         list_add(&fm->fc_entry, &fc->mounts);
>         fm->fc =3D fc;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index f9e14180367a..d85fb692cf3b 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -652,6 +652,10 @@ enum fuse_opcode {
>         FUSE_TMPFILE            =3D 51,
>         FUSE_STATX              =3D 52,
>
> +       /* Famfs / devdax opcodes */
> +       FUSE_GET_FMAP           =3D 53,
> +       FUSE_GET_DAXDEV         =3D 54,
> +
>         /* CUSE specific operations */
>         CUSE_INIT               =3D 4096,
>
> --
> 2.49.0
>

