Return-Path: <linux-fsdevel+bounces-62160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77735B86597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7391CC478D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBCC28C860;
	Thu, 18 Sep 2025 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWN6i1s9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5428B3E2;
	Thu, 18 Sep 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218547; cv=none; b=B2JAj6wZcvd3XdOVmU9n/N3ndctQDVqNWsOqs2b5zsmBuI+7it139VTqFMtkq+bj1EGIg5rNvXux6x1RkCzHJ42KIORM6r6CNBJ9IethFpKtK32wU6IaU0zFYO46Byc6O/KFPNv7p0iTumxq0Tlhd+KWRtvTZEiDjMEeITiujho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218547; c=relaxed/simple;
	bh=e82aIZt1Reiu+WLwhM+bQ4KSAAViaAd5w0OyCeb+0aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSkRr+rk3Kd6/taPK0VqoKuwKiYF3e+IqFW7QySdRzg7wlKX61m1rM48QrPFlAybwjE9WoEhZZ6PHMcw8U/v8CDYzfs2UloXIfexQ/jURdfF01BNqcdlm0tPm0yRtRdombEsxfwOc7cSC5REHy5LbaXEcNeB4fsRaQ6D+2hiWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWN6i1s9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B16BC4CEE7;
	Thu, 18 Sep 2025 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758218547;
	bh=e82aIZt1Reiu+WLwhM+bQ4KSAAViaAd5w0OyCeb+0aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWN6i1s9GzOyDX+GWO8THe/UW/s4QnEQ1XQbCYimYByR7k8PlQ4QbjuYNd8ZszUVZ
	 UgaZc/r77GieX5LxNNRaWG3V20nK+rZuYIpmN4w1nCo6guEJTRcDIYk9vcqto5M8ul
	 6vLqfx6NIQaYvh5Yql0bEzH6m7aGISJHbIRKb6eB0BANgMi6A4/e/T/B2DrVWqh4Rh
	 tx0ZRs5udTzFR/oKAR/P7vsOY2vXI3mgquYRo3s9btSUsotCu7LKJRqmS2lWE8c6FA
	 k5IYrJagAAocZKwq3xzauYaCWd3x264Jbzt6suMcjR0VXqj8XgGX3kg6hj6JzILXuX
	 NchJO0boeBEbw==
Date: Thu, 18 Sep 2025 11:02:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 3/5] fuse: move the passthrough-specific code back to
 passthrough.c
Message-ID: <20250918180226.GZ8117@frogsfrogsfrogs>
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
 <175798150773.382479.13993075040890328659.stgit@frogsfrogsfrogs>
 <CAOQ4uxigBL4pCDXjRYX0ftCMyQibRPuRJP7+KhC7Jr=yEM=DUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxigBL4pCDXjRYX0ftCMyQibRPuRJP7+KhC7Jr=yEM=DUw@mail.gmail.com>

On Wed, Sep 17, 2025 at 04:47:19AM +0200, Amir Goldstein wrote:
> On Tue, Sep 16, 2025 at 2:27 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > In preparation for iomap, move the passthrough-specific validation code
> > back to passthrough.c and create a new Kconfig item for conditional
> > compilation of backing.c.  In the next patch, iomap will share the
> > backing structures.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h          |   23 +++++++++--
> >  include/uapi/linux/fuse.h |    8 +++-
> >  fs/fuse/Kconfig           |    4 ++
> >  fs/fuse/Makefile          |    3 +
> >  fs/fuse/backing.c         |   95 ++++++++++++++++++++++++++++++++++-----------
> >  fs/fuse/dev.c             |    4 +-
> >  fs/fuse/inode.c           |    4 +-
> >  fs/fuse/passthrough.c     |   37 +++++++++++++++++-
> >  8 files changed, 144 insertions(+), 34 deletions(-)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 52db609e63eb54..4560687d619d76 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -96,10 +96,21 @@ struct fuse_submount_lookup {
> >         struct fuse_forget_link *forget;
> >  };
> >
> > +struct fuse_conn;
> > +
> > +/** Operations for subsystems that want to use a backing file */
> > +struct fuse_backing_ops {
> > +       int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
> > +       int (*may_open)(struct fuse_conn *fc, struct file *file);
> > +       int (*may_close)(struct fuse_conn *fc, struct file *file);
> > +       unsigned int type;
> > +};
> > +
> >  /** Container for data related to mapping to backing file */
> >  struct fuse_backing {
> >         struct file *file;
> >         struct cred *cred;
> > +       const struct fuse_backing_ops *ops;
> 
> Please argue why we need a mix of passthrough backing
> files and iomap backing bdev on the same filesystem.

I've no particular reason to allow both on the same filesystem.  I
simply didn't want to add restrictions to existing functionality.

> Same as my argument against passthrough/iomap on
> same fuse_backing:
> If you do not plan to test it, and nobody asked for it, please do
> not allow it - it's bad for code test coverage.
> 
> I think at this point in time FUSE_PASSTHROUGH and
> FUSE_IOMAP should be mutually exclusive and
> fuse_backing_ops could be set at fc level.
> If we want to move them for per fuse_backing later
> we can always do that when the use cases and tests arrive.

With Miklos' ok I'll constrain fuse not to allow passthrough and iomap
files on the same filesystem, but as it is now there's no technical
reason to make it so that they can't coexist.

--D

> Thanks,
> Amir.
> 
> >
> >         /** refcount */
> >         refcount_t count;
> > @@ -968,7 +979,7 @@ struct fuse_conn {
> >         /* New writepages go into this bucket */
> >         struct fuse_sync_bucket __rcu *curr_bucket;
> >
> > -#ifdef CONFIG_FUSE_PASSTHROUGH
> > +#ifdef CONFIG_FUSE_BACKING
> >         /** IDR for backing files ids */
> >         struct idr backing_files_map;
> >  #endif
> > @@ -1571,10 +1582,12 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
> >                        unsigned int open_flags, fl_owner_t id, bool isdir);
> >
> >  /* backing.c */
> > -#ifdef CONFIG_FUSE_PASSTHROUGH
> > +#ifdef CONFIG_FUSE_BACKING
> >  struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
> >  void fuse_backing_put(struct fuse_backing *fb);
> > -struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id);
> > +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
> > +                                        const struct fuse_backing_ops *ops,
> > +                                        int backing_id);
> >  #else
> >
> >  static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
> > @@ -1631,6 +1644,10 @@ static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
> >  #endif
> >  }
> >
> > +#ifdef CONFIG_FUSE_PASSTHROUGH
> > +extern const struct fuse_backing_ops fuse_passthrough_backing_ops;
> > +#endif
> > +
> >  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter);
> >  ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *iter);
> >  ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 1d76d0332f46f6..31b80f93211b81 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -1114,9 +1114,15 @@ struct fuse_notify_retrieve_in {
> >         uint64_t        dummy4;
> >  };
> >
> > +#define FUSE_BACKING_TYPE_MASK         (0xFF)
> > +#define FUSE_BACKING_TYPE_PASSTHROUGH  (0)
> > +#define FUSE_BACKING_MAX_TYPE          (FUSE_BACKING_TYPE_PASSTHROUGH)
> > +
> > +#define FUSE_BACKING_FLAGS_ALL         (FUSE_BACKING_TYPE_MASK)
> > +
> >  struct fuse_backing_map {
> >         int32_t         fd;
> > -       uint32_t        flags;
> > +       uint32_t        flags; /* FUSE_BACKING_* */
> >         uint64_t        padding;
> >  };
> >
> > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > index a774166264de69..9563fa5387a241 100644
> > --- a/fs/fuse/Kconfig
> > +++ b/fs/fuse/Kconfig
> > @@ -59,12 +59,16 @@ config FUSE_PASSTHROUGH
> >         default y
> >         depends on FUSE_FS
> >         select FS_STACK
> > +       select FUSE_BACKING
> >         help
> >           This allows bypassing FUSE server by mapping specific FUSE operations
> >           to be performed directly on a backing file.
> >
> >           If you want to allow passthrough operations, answer Y.
> >
> > +config FUSE_BACKING
> > +       bool
> > +
> >  config FUSE_IO_URING
> >         bool "FUSE communication over io-uring"
> >         default y
> > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > index 8ddd8f0b204ee5..36be6d715b111a 100644
> > --- a/fs/fuse/Makefile
> > +++ b/fs/fuse/Makefile
> > @@ -13,7 +13,8 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
> >  fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
> >  fuse-y += iomode.o
> >  fuse-$(CONFIG_FUSE_DAX) += dax.o
> > -fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
> > +fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
> > +fuse-$(CONFIG_FUSE_BACKING) += backing.o
> >  fuse-$(CONFIG_SYSCTL) += sysctl.o
> >  fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
> >
> > diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > index 4afda419dd1416..da0dff288396ed 100644
> > --- a/fs/fuse/backing.c
> > +++ b/fs/fuse/backing.c
> > @@ -6,6 +6,7 @@
> >   */
> >
> >  #include "fuse_i.h"
> > +#include "fuse_trace.h"
> >
> >  #include <linux/file.h>
> >
> > @@ -69,32 +70,53 @@ static int fuse_backing_id_free(int id, void *p, void *data)
> >         struct fuse_backing *fb = p;
> >
> >         WARN_ON_ONCE(refcount_read(&fb->count) != 1);
> > +
> >         fuse_backing_free(fb);
> >         return 0;
> >  }
> >
> >  void fuse_backing_files_free(struct fuse_conn *fc)
> >  {
> > -       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> > +       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, fc);
> >         idr_destroy(&fc->backing_files_map);
> >  }
> >
> > +static inline const struct fuse_backing_ops *
> > +fuse_backing_ops_from_map(const struct fuse_backing_map *map)
> > +{
> > +       switch (map->flags & FUSE_BACKING_TYPE_MASK) {
> > +#ifdef CONFIG_FUSE_PASSTHROUGH
> > +       case FUSE_BACKING_TYPE_PASSTHROUGH:
> > +               return &fuse_passthrough_backing_ops;
> > +#endif
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> >  int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
> >  {
> >         struct file *file;
> > -       struct super_block *backing_sb;
> >         struct fuse_backing *fb = NULL;
> > +       const struct fuse_backing_ops *ops = fuse_backing_ops_from_map(map);
> > +       uint32_t op_flags = map->flags & ~FUSE_BACKING_TYPE_MASK;
> >         int res;
> >
> >         pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
> >
> > -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > -       res = -EPERM;
> > -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > +       res = -EOPNOTSUPP;
> > +       if (!ops)
> > +               goto out;
> > +       WARN_ON(ops->type != (map->flags & FUSE_BACKING_TYPE_MASK));
> > +
> > +       res = ops->may_admin ? ops->may_admin(fc, op_flags) : 0;
> > +       if (res)
> >                 goto out;
> >
> >         res = -EINVAL;
> > -       if (map->flags || map->padding)
> > +       if (map->padding)
> >                 goto out;
> >
> >         file = fget_raw(map->fd);
> > @@ -102,14 +124,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
> >         if (!file)
> >                 goto out;
> >
> > -       /* read/write/splice/mmap passthrough only relevant for regular files */
> > -       res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
> > -       if (!d_is_reg(file->f_path.dentry))
> > -               goto out_fput;
> > -
> > -       backing_sb = file_inode(file)->i_sb;
> > -       res = -ELOOP;
> > -       if (backing_sb->s_stack_depth >= fc->max_stack_depth)
> > +       res = ops->may_open ? ops->may_open(fc, file) : 0;
> > +       if (res)
> >                 goto out_fput;
> >
> >         fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
> > @@ -119,14 +135,15 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
> >
> >         fb->file = file;
> >         fb->cred = prepare_creds();
> > +       fb->ops = ops;
> >         refcount_set(&fb->count, 1);
> >
> >         res = fuse_backing_id_alloc(fc, fb);
> >         if (res < 0) {
> >                 fuse_backing_free(fb);
> >                 fb = NULL;
> > +               goto out;
> >         }
> > -
> >  out:
> >         pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
> >
> > @@ -137,41 +154,71 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
> >         goto out;
> >  }
> >
> > +static struct fuse_backing *__fuse_backing_lookup(struct fuse_conn *fc,
> > +                                                 int backing_id)
> > +{
> > +       struct fuse_backing *fb;
> > +
> > +       rcu_read_lock();
> > +       fb = idr_find(&fc->backing_files_map, backing_id);
> > +       fb = fuse_backing_get(fb);
> > +       rcu_read_unlock();
> > +
> > +       return fb;
> > +}
> > +
> >  int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> >  {
> > -       struct fuse_backing *fb = NULL;
> > +       struct fuse_backing *fb, *test_fb;
> > +       const struct fuse_backing_ops *ops;
> >         int err;
> >
> >         pr_debug("%s: backing_id=%d\n", __func__, backing_id);
> >
> > -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > -       err = -EPERM;
> > -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > -               goto out;
> > -
> >         err = -EINVAL;
> >         if (backing_id <= 0)
> >                 goto out;
> >
> >         err = -ENOENT;
> > -       fb = fuse_backing_id_remove(fc, backing_id);
> > +       fb = __fuse_backing_lookup(fc, backing_id);
> >         if (!fb)
> >                 goto out;
> > +       ops = fb->ops;
> >
> > -       fuse_backing_put(fb);
> > +       err = ops->may_admin ? ops->may_admin(fc, 0) : 0;
> > +       if (err)
> > +               goto out_fb;
> > +
> > +       err = ops->may_close ? ops->may_close(fc, fb->file) : 0;
> > +       if (err)
> > +               goto out_fb;
> > +
> > +       err = -ENOENT;
> > +       test_fb = fuse_backing_id_remove(fc, backing_id);
> > +       if (!test_fb)
> > +               goto out_fb;
> > +
> > +       WARN_ON(fb != test_fb);
> >         err = 0;
> > +       fuse_backing_put(test_fb);
> > +out_fb:
> > +       fuse_backing_put(fb);
> >  out:
> >         pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
> >
> >         return err;
> >  }
> >
> > -struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
> > +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
> > +                                        const struct fuse_backing_ops *ops,
> > +                                        int backing_id)
> >  {
> >         struct fuse_backing *fb;
> >
> >         rcu_read_lock();
> >         fb = idr_find(&fc->backing_files_map, backing_id);
> > +       if (fb && fb->ops != ops)
> > +               fb = NULL;
> >         fb = fuse_backing_get(fb);
> >         rcu_read_unlock();
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index e5aaf0c668bc11..281bc81f3b448b 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2654,7 +2654,7 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
> >         if (IS_ERR(fud))
> >                 return PTR_ERR(fud);
> >
> > -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > +       if (!IS_ENABLED(CONFIG_FUSE_BACKING))
> >                 return -EOPNOTSUPP;
> >
> >         if (copy_from_user(&map, argp, sizeof(map)))
> > @@ -2671,7 +2671,7 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
> >         if (IS_ERR(fud))
> >                 return PTR_ERR(fud);
> >
> > -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > +       if (!IS_ENABLED(CONFIG_FUSE_BACKING))
> >                 return -EOPNOTSUPP;
> >
> >         if (get_user(backing_id, argp))
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 14c35ce12b87d6..1e7298b2b89b58 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -995,7 +995,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
> >         fc->name_max = FUSE_NAME_LOW_MAX;
> >         fc->timeout.req_timeout = 0;
> >
> > -       if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > +       if (IS_ENABLED(CONFIG_FUSE_BACKING))
> >                 fuse_backing_files_init(fc);
> >
> >         INIT_LIST_HEAD(&fc->mounts);
> > @@ -1032,7 +1032,7 @@ void fuse_conn_put(struct fuse_conn *fc)
> >                         WARN_ON(atomic_read(&bucket->count) != 1);
> >                         kfree(bucket);
> >                 }
> > -               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > +               if (IS_ENABLED(CONFIG_FUSE_BACKING))
> >                         fuse_backing_files_free(fc);
> >                 call_rcu(&fc->rcu, delayed_release);
> >         }
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > index e0b8d885bc81f3..9792d7b12a775b 100644
> > --- a/fs/fuse/passthrough.c
> > +++ b/fs/fuse/passthrough.c
> > @@ -164,7 +164,7 @@ struct fuse_backing *fuse_passthrough_open(struct file *file,
> >                 goto out;
> >
> >         err = -ENOENT;
> > -       fb = fuse_backing_lookup(fc, backing_id);
> > +       fb = fuse_backing_lookup(fc, &fuse_passthrough_backing_ops, backing_id);
> >         if (!fb)
> >                 goto out;
> >
> > @@ -197,3 +197,38 @@ void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb)
> >         put_cred(ff->cred);
> >         ff->cred = NULL;
> >  }
> > +
> > +static int fuse_passthrough_may_admin(struct fuse_conn *fc, unsigned int flags)
> > +{
> > +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > +               return -EPERM;
> > +
> > +       if (flags)
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> > +static int fuse_passthrough_may_open(struct fuse_conn *fc, struct file *file)
> > +{
> > +       struct super_block *backing_sb;
> > +       int res;
> > +
> > +       /* read/write/splice/mmap passthrough only relevant for regular files */
> > +       res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
> > +       if (!d_is_reg(file->f_path.dentry))
> > +               return res;
> > +
> > +       backing_sb = file_inode(file)->i_sb;
> > +       if (backing_sb->s_stack_depth >= fc->max_stack_depth)
> > +               return -ELOOP;
> > +
> > +       return 0;
> > +}
> > +
> > +const struct fuse_backing_ops fuse_passthrough_backing_ops = {
> > +       .type = FUSE_BACKING_TYPE_PASSTHROUGH,
> > +       .may_admin = fuse_passthrough_may_admin,
> > +       .may_open = fuse_passthrough_may_open,
> > +};
> >
> >

