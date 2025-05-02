Return-Path: <linux-fsdevel+bounces-47954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59621AA7AEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 22:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F627B188A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B220101F;
	Fri,  2 May 2025 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxbWOqqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546151FAC48;
	Fri,  2 May 2025 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746218148; cv=none; b=GEO8S/7qXdU9xisBCFVEPEyM6gcJTzRZJLe9KXihrPxDOEznMSIUUm0hQeiSB8v0ShE0tLzqFgq5XtVDn+06Pgvqx7PuRrQfAmKpYAoXXwCgWA/qk0E/NA6Jo5K2Xsl60kYHLaIiRiL7949FiuRMSGxTvWTzw5dsis0lvNtDPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746218148; c=relaxed/simple;
	bh=+N2AWwulLSeis8cx1YIsG72P0ZZ9C4nuty7wiozK8yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvdOwAAXq0uSQTwOAtDfT2bVqqMUEqG7JrUiBloxXaiFMK6ngQjQAXD36CCyV6EXNaYmXff3Ww70OzWPm+P9zf/KgVxFX4d6dYZCdtjT3H7ehC6F6lZ2yMxi+UOHYpQliMoOvNu2r4QPkSe5BaWW8x8Q38stI5c03fkTOhmqOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxbWOqqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B223BC4CEE4;
	Fri,  2 May 2025 20:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746218147;
	bh=+N2AWwulLSeis8cx1YIsG72P0ZZ9C4nuty7wiozK8yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LxbWOqqKbLFkZd9wXyr5yZ0I45GT33Ia7VwC9R+NKWNIqdGA3s/cv8/wlRbYoRyvs
	 zrKdjxwjzUkc8Zw3gl2qs7JnWXE9qEXPcXErExcDPCAVYbhfEFdqef/EEJsE+XAndr
	 k113XO+FahZinTORPhlV3Mndov+Zl4x9zS9D8LgeaH7JOaJiLZ5V9dbGuUmZrqC7ik
	 jUwqtUGXVI7L1iiaPqGhgaIKDMBNipKGlvfe7YwLmxHBhSWrYOKFNOKfOEiR5zxI4M
	 6d0x5gVve1poltaruVgoODiKA2kN7i/4XdcR1NhDpAFGJJE05hGpZZpyjl6Tqi54qf
	 LNAkG1J5CqeFQ==
Date: Fri, 2 May 2025 13:35:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 12/19] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <20250502203547.GF1035866@frogsfrogsfrogs>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-13-john@groves.net>
 <CAJnrk1ZRSoMN+jan5D9d3UYWnTVxc_5KVaBtP7JV2b+0skrBfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZRSoMN+jan5D9d3UYWnTVxc_5KVaBtP7JV2b+0skrBfg@mail.gmail.com>

On Thu, May 01, 2025 at 10:48:15PM -0700, Joanne Koong wrote:
> On Sun, Apr 20, 2025 at 6:34 PM John Groves <John@groves.net> wrote:
> >
> > Upon completion of a LOOKUP, if we're in famfs-mode we do a GET_FMAP to
> > retrieve and cache up the file-to-dax map in the kernel. If this
> > succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/dir.c             | 69 +++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h          | 36 +++++++++++++++++++-
> >  fs/fuse/inode.c           | 15 +++++++++
> >  include/uapi/linux/fuse.h |  4 +++
> >  4 files changed, 123 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index bc29db0117f4..ae135c55b9f6 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -359,6 +359,56 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
> >         return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->size);
> >  }
> >
> > +#define FMAP_BUFSIZE 4096
> > +
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +static void
> > +fuse_get_fmap_init(
> > +       struct fuse_conn *fc,
> > +       struct fuse_args *args,
> > +       u64 nodeid,
> > +       void *outbuf,
> > +       size_t outbuf_size)
> > +{
> > +       memset(outbuf, 0, outbuf_size);
> 
> I think we can skip the memset here since kcalloc will zero out the
> memory automatically when the fmap_buf gets allocated
> 
> > +       args->opcode = FUSE_GET_FMAP;
> > +       args->nodeid = nodeid;
> > +
> > +       args->in_numargs = 0;
> > +
> > +       args->out_numargs = 1;
> > +       args->out_args[0].size = FMAP_BUFSIZE;
> > +       args->out_args[0].value = outbuf;
> > +}
> > +
> > +static int
> > +fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
> > +{
> > +       size_t fmap_size;
> > +       void *fmap_buf;
> > +       int err;
> > +
> > +       pr_notice("%s: nodeid=%lld, inode=%llx\n", __func__,
> > +                 nodeid, (u64)inode);
> > +       fmap_buf = kcalloc(1, FMAP_BUFSIZE, GFP_KERNEL);
> > +       FUSE_ARGS(args);
> > +       fuse_get_fmap_init(fm->fc, &args, nodeid, fmap_buf, FMAP_BUFSIZE);
> > +
> > +       /* Send GET_FMAP command */
> > +       err = fuse_simple_request(fm, &args);
> 
> I'm assuming the fmap_buf gets freed in a later patch, but for this
> one we'll probably need a kfree(fmap_buf) here in the meantime?
> 
> > +       if (err) {
> > +               pr_err("%s: err=%d from fuse_simple_request()\n",
> > +                      __func__, err);
> > +               return err;
> > +       }
> > +
> > +       fmap_size = args.out_args[0].size;
> > +       pr_notice("%s: nodei=%lld fmap_size=%ld\n", __func__, nodeid, fmap_size);
> > +
> > +       return 0;
> > +}
> > +#endif
> > +
> >  int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
> >                      struct fuse_entry_out *outarg, struct inode **inode)
> >  {
> > @@ -404,6 +454,25 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
> >                 fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
> >                 goto out;
> >         }
> > +
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       if (fm->fc->famfs_iomap) {
> > +               if (S_ISREG((*inode)->i_mode)) {
> > +                       /* Note Lookup returns the looked-up inode in the attr
> > +                        * struct, but not in outarg->nodeid !
> > +                        */
> > +                       pr_notice("%s: outarg: size=%d nodeid=%lld attr.ino=%lld\n",
> > +                                __func__, args.out_args[0].size, outarg->nodeid,
> > +                                outarg->attr.ino);
> > +                       /* Get the famfs fmap */
> > +                       fuse_get_fmap(fm, *inode, outarg->attr.ino);
> 
> I agree with Darrick's comment about fetching the mappings only if the
> file gets opened. I wonder though if we could bundle the open with the
> get_fmap so that we don't have to do an additional request / incur 2
> extra context switches.

What's the intended lifetime of these files?  If we only have to do this
once per file lifetime then perhaps that amortizes towards zero?  That
said, I don't know how aggressively fuse reclaims the inode structures,
so maybe the need to GET_FMAP is more frequent?  AFAICT the fuse code
seems to use the regular lru so maybe that's not so bad.  But maybe the
kernel shouldn't ask for mappings until someone tries a file IO
operation so that walking the directory tree doesn't bog down in a bunch
of GET_FMAP operations.

It also occurred to me just now that this is a LOOKUP operation, which
makes me wonder what happens for the other things like .  But maybe the
order of operations for creat() is that you tell the famfs management
layer to create a file, it preallocates space and the directory tree,
and later you can just resolve the pathname to open it, at which point
fuse+famfs creates the in-kernel abstractions?

> extra context switches. This seems feasible to me. When we send the
> open request, we could check if fc->famfs_iomap is set and if so, set
> inarg.open_flags to include FUSE_OPEN_GET_FMAP and set outarg.value to
> an allocated buffer that holds both struct fuse_open_out and the
> fmap_buf and adjust outarg.size accordingly. Then the server could
> send both the open and corresponding fmap data in the reply.

Alternately, we could create a fuse "notification" that really is just a
means for the famfs open function to send mappings to the kernel.  But I
don't know if it makes much difference for the kernel to demand-page in
mapping information as needed vs just using GET_FMAP here.

> 
> > +               } else
> > +                       pr_notice("%s: no get_fmap for non-regular file\n",
> > +                                __func__);
> > +       } else
> > +               pr_notice("%s: fc->dax_iomap is not set\n", __func__);
> > +#endif
> > +
> >         err = 0;
> >
> >   out_put_forget:
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 931613102d32..437177c2f092 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -193,6 +193,10 @@ struct fuse_inode {
> >         /** Reference to backing file in passthrough mode */
> >         struct fuse_backing *fb;
> >  #endif
> > +
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       void *famfs_meta;
> > +#endif
> >  };
> >
> >  /** FUSE inode state bits */
> > @@ -942,6 +946,8 @@ struct fuse_conn {
> >  #endif
> >
> >  #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       struct rw_semaphore famfs_devlist_sem;
> > +       struct famfs_dax_devlist *dax_devlist;
> >         char *shadow;
> >  #endif
> >  };
> > @@ -1432,11 +1438,14 @@ void fuse_free_conn(struct fuse_conn *fc);
> >
> >  /* dax.c */
> >
> > +static inline int fuse_file_famfs(struct fuse_inode *fi); /* forward */
> > +
> >  /* This macro is used by virtio_fs, but now it also needs to filter for
> >   * "not famfs"
> >   */
> >  #define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)    \
> > -                                       && IS_DAX(&fuse_inode->inode))
> > +                                       && IS_DAX(&fuse_inode->inode)   \
> > +                                       && !fuse_file_famfs(fuse_inode))
> >
> >  ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
> >  ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
> > @@ -1547,4 +1556,29 @@ extern void fuse_sysctl_unregister(void);
> >  #define fuse_sysctl_unregister()       do { } while (0)
> >  #endif /* CONFIG_SYSCTL */
> >
> > +/* famfs.c */
> > +static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
> > +                                                      void *meta)
> > +{
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       return xchg(&fi->famfs_meta, meta);
> > +#else
> > +       return NULL;
> > +#endif
> > +}
> > +
> > +static inline void famfs_meta_free(struct fuse_inode *fi)
> > +{
> > +       /* Stub wil be connected in a subsequent commit */
> > +}
> > +
> > +static inline int fuse_file_famfs(struct fuse_inode *fi)
> > +{
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       return (fi->famfs_meta != NULL);
> 
> Does this need to be "return READ_ONCE(fi->famfs_meta) != NULL"?
> 
> > +#else
> > +       return 0;
> > +#endif
> > +}
> > +
> >  #endif /* _FS_FUSE_I_H */
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 7f4b73e739cb..848c8818e6f7 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -117,6 +117,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
> >         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >                 fuse_inode_backing_set(fi, NULL);
> >
> > +       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> > +               famfs_meta_set(fi, NULL);
> 
> "fi->famfs_meta = NULL;" looks simpler here
> 
> > +
> >         return &fi->inode;
> >
> >  out_free_forget:
> > @@ -138,6 +141,13 @@ static void fuse_free_inode(struct inode *inode)
> >         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >                 fuse_backing_put(fuse_inode_backing(fi));
> >
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       if (S_ISREG(inode->i_mode) && fi->famfs_meta) {
> > +               famfs_meta_free(fi);
> > +               famfs_meta_set(fi, NULL);
> > +       }
> > +#endif
> > +
> >         kmem_cache_free(fuse_inode_cachep, fi);
> >  }
> >
> > @@ -1002,6 +1012,11 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
> >         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >                 fuse_backing_files_init(fc);
> >
> > +       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)) {
> > +               pr_notice("%s: Kernel is FUSE_FAMFS_DAX capable\n", __func__);
> > +               init_rwsem(&fc->famfs_devlist_sem);
> > +       }
> 
> Should we only init this if the server chooses to opt into famfs (eg
> if their init reply sets the FUSE_DAX_FMAP flag)? This imo seems to
> belong more in process_init_reply().

/me has no idea what this means, but has a sneaking suspicion it'll
become important for his science projects. ;)

Though I guess for general purpose files maybe we want to allow opting
into iomapping on a per-inode basis like the existing iomap allows.

--D

> 
> Thanks,
> Joanne
> > +
> >         INIT_LIST_HEAD(&fc->mounts);
> >         list_add(&fm->fc_entry, &fc->mounts);
> >         fm->fc = fc;
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index f9e14180367a..d85fb692cf3b 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -652,6 +652,10 @@ enum fuse_opcode {
> >         FUSE_TMPFILE            = 51,
> >         FUSE_STATX              = 52,
> >
> > +       /* Famfs / devdax opcodes */
> > +       FUSE_GET_FMAP           = 53,
> > +       FUSE_GET_DAXDEV         = 54,
> > +
> >         /* CUSE specific operations */
> >         CUSE_INIT               = 4096,
> >
> > --
> > 2.49.0
> >
> 

