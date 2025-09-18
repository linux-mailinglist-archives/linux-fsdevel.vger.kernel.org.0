Return-Path: <linux-fsdevel+bounces-62164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B1B869BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB6D564B0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276F281375;
	Thu, 18 Sep 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwCNKwGe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14E34BA3C;
	Thu, 18 Sep 2025 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222214; cv=none; b=HlCMrC6QC8krwMTco1Ke9qWqoe8yZw4cHMps4ljGiphZ3L3zRm5kPKvTVBJsMSUKoVyWytvyCuF12k4g4Zu6Mq/teVBhRglJC6DR/skT/ZGI4jbON8LUimLD7LaoEDlxZu9xZZIvT3fP+uXLo0jHrSvUxJIrMdx6HtGqIksRLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222214; c=relaxed/simple;
	bh=gS3qm1C7+Z60UreF9IEOtpkQJITq+BNn9OvLtgRQI6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6lhxApn2vobecEOAmpT4zoSfdecA72xChzw66MPoH86pNpvT99JFmrgCp8SD/HsQLBF/JbKvcSy84O3Hkr/kKu8iatUVy05KxJr+Lnr/YmNg0sVgkuGqibJ7gjMUOefcHXt/Gj2LAto6SqqVyNNcEqjSP0NNXLBMgmy+EdV4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwCNKwGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C22CC4CEE7;
	Thu, 18 Sep 2025 19:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758222214;
	bh=gS3qm1C7+Z60UreF9IEOtpkQJITq+BNn9OvLtgRQI6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwCNKwGe77zzSXrrkGPTgcRtyer+/gH+QXIdDQaTnm12GVFEDuyoaXEl2vZ1nR0e8
	 zy2dXJriEluMR6HFpbiI/5wPs8tjv6qfFQQUBP/x+83X33x8XHg3Lxhz7hth+anvbD
	 49bnbt263k1AiYgDJcCOfgJJPpbvUpDQZ8E6T9qYye03Ku9AqiHj7FmixQ5phFTT+t
	 0EBOSeFqhIFTQrDJRAENM5d+p22Wi+UsF5V03S53nKnxgV9WjdlDCFyqSXUzi909QN
	 GJEBJ7AecMhlrWIZFy5TSkzICndDPwA1iZwmvDim+4sLbZKKDgxgamzxpgEJXuTs3i
	 kZqSkQK56ojGw==
Date: Thu, 18 Sep 2025 12:03:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 04/28] fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
Message-ID: <20250918190333.GB8117@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
 <175798151352.382724.799745519035147130.stgit@frogsfrogsfrogs>
 <CAOQ4uxibHLq7YVpjtXdrHk74rXrOLSc7sAW7s=RADc7OYN2ndA@mail.gmail.com>
 <20250918181703.GR1587915@frogsfrogsfrogs>
 <CAOQ4uxiH1d3fV0kgiO3-JjqGH4DKboXdtEpe=Z=gKooPgz7B8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiH1d3fV0kgiO3-JjqGH4DKboXdtEpe=Z=gKooPgz7B8g@mail.gmail.com>

On Thu, Sep 18, 2025 at 08:42:08PM +0200, Amir Goldstein wrote:
> On Thu, Sep 18, 2025 at 8:17 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Sep 17, 2025 at 05:09:14AM +0200, Amir Goldstein wrote:
> > > On Tue, Sep 16, 2025 at 2:30 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > Enable the use of the backing file open/close ioctls so that fuse
> > > > servers can register block devices for use with iomap.
> > > >
> > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  fs/fuse/fuse_i.h          |    5 ++
> > > >  include/uapi/linux/fuse.h |    3 +
> > > >  fs/fuse/Kconfig           |    1
> > > >  fs/fuse/backing.c         |   12 +++++
> > > >  fs/fuse/file_iomap.c      |   99 +++++++++++++++++++++++++++++++++++++++++----
> > > >  fs/fuse/trace.c           |    1
> > > >  6 files changed, 111 insertions(+), 10 deletions(-)
> > > >
> > > >
> > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > index 389b123f0bf144..791f210c13a876 100644
> > > > --- a/fs/fuse/fuse_i.h
> > > > +++ b/fs/fuse/fuse_i.h
> > > > @@ -97,12 +97,14 @@ struct fuse_submount_lookup {
> > > >  };
> > > >
> > > >  struct fuse_conn;
> > > > +struct fuse_backing;
> > > >
> > > >  /** Operations for subsystems that want to use a backing file */
> > > >  struct fuse_backing_ops {
> > > >         int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
> > > >         int (*may_open)(struct fuse_conn *fc, struct file *file);
> > > >         int (*may_close)(struct fuse_conn *fc, struct file *file);
> > > > +       int (*post_open)(struct fuse_conn *fc, struct fuse_backing *fb);
> > > >         unsigned int type;
> > > >  };
> > > >
> > > > @@ -110,6 +112,7 @@ struct fuse_backing_ops {
> > > >  struct fuse_backing {
> > > >         struct file *file;
> > > >         struct cred *cred;
> > > > +       struct block_device *bdev;
> > > >         const struct fuse_backing_ops *ops;
> > > >
> > > >         /** refcount */
> > > > @@ -1704,6 +1707,8 @@ static inline bool fuse_has_iomap(const struct inode *inode)
> > > >  {
> > > >         return get_fuse_conn_c(inode)->iomap;
> > > >  }
> > > > +
> > > > +extern const struct fuse_backing_ops fuse_iomap_backing_ops;
> > > >  #else
> > > >  # define fuse_iomap_enabled(...)               (false)
> > > >  # define fuse_has_iomap(...)                   (false)
> > > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > > index 3634cbe602cd9c..3a367f387795ff 100644
> > > > --- a/include/uapi/linux/fuse.h
> > > > +++ b/include/uapi/linux/fuse.h
> > > > @@ -1124,7 +1124,8 @@ struct fuse_notify_retrieve_in {
> > > >
> > > >  #define FUSE_BACKING_TYPE_MASK         (0xFF)
> > > >  #define FUSE_BACKING_TYPE_PASSTHROUGH  (0)
> > > > -#define FUSE_BACKING_MAX_TYPE          (FUSE_BACKING_TYPE_PASSTHROUGH)
> > > > +#define FUSE_BACKING_TYPE_IOMAP                (1)
> > > > +#define FUSE_BACKING_MAX_TYPE          (FUSE_BACKING_TYPE_IOMAP)
> > > >
> > > >  #define FUSE_BACKING_FLAGS_ALL         (FUSE_BACKING_TYPE_MASK)
> > > >
> > > > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > > > index 52e1a04183e760..baa38cf0f295ff 100644
> > > > --- a/fs/fuse/Kconfig
> > > > +++ b/fs/fuse/Kconfig
> > > > @@ -75,6 +75,7 @@ config FUSE_IOMAP
> > > >         depends on FUSE_FS
> > > >         depends on BLOCK
> > > >         select FS_IOMAP
> > > > +       select FUSE_BACKING
> > > >         help
> > > >           Enable fuse servers to operate the regular file I/O path through
> > > >           the fs-iomap library in the kernel.  This enables higher performance
> > > > diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > > > index 229c101ab46b0e..fc58636ac78eaa 100644
> > > > --- a/fs/fuse/backing.c
> > > > +++ b/fs/fuse/backing.c
> > > > @@ -89,6 +89,10 @@ fuse_backing_ops_from_map(const struct fuse_backing_map *map)
> > > >  #ifdef CONFIG_FUSE_PASSTHROUGH
> > > >         case FUSE_BACKING_TYPE_PASSTHROUGH:
> > > >                 return &fuse_passthrough_backing_ops;
> > > > +#endif
> > > > +#ifdef CONFIG_FUSE_IOMAP
> > > > +       case FUSE_BACKING_TYPE_IOMAP:
> > > > +               return &fuse_iomap_backing_ops;
> > > >  #endif
> > > >         default:
> > > >                 break;
> > > > @@ -137,8 +141,16 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
> > > >         fb->file = file;
> > > >         fb->cred = prepare_creds();
> > > >         fb->ops = ops;
> > > > +       fb->bdev = NULL;
> > > >         refcount_set(&fb->count, 1);
> > > >
> > > > +       res = ops->post_open ? ops->post_open(fc, fb) : 0;
> > > > +       if (res) {
> > > > +               fuse_backing_free(fb);
> > > > +               fb = NULL;
> > > > +               goto out;
> > > > +       }
> > > > +
> > > >         res = fuse_backing_id_alloc(fc, fb);
> > > >         if (res < 0) {
> > > >                 fuse_backing_free(fb);
> > > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > > index e7d19e2aee4541..3a4161633add0e 100644
> > > > --- a/fs/fuse/file_iomap.c
> > > > +++ b/fs/fuse/file_iomap.c
> > > > @@ -319,10 +319,6 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
> > > >                 return false;
> > > >         }
> > > >
> > > > -       /* XXX: we don't support devices yet */
> > > > -       if (BAD_DATA(map->dev != FUSE_IOMAP_DEV_NULL))
> > > > -               return false;
> > > > -
> > > >         /* No overflows in the device range, if supplied */
> > > >         if (map->addr != FUSE_IOMAP_NULL_ADDR &&
> > > >             BAD_DATA(check_add_overflow(map->addr, map->length, &end)))
> > > > @@ -334,6 +330,7 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
> > > >  /* Convert a mapping from the server into something the kernel can use */
> > > >  static inline void fuse_iomap_from_server(struct inode *inode,
> > > >                                           struct iomap *iomap,
> > > > +                                         const struct fuse_backing *fb,
> > > >                                           const struct fuse_iomap_io *fmap)
> > > >  {
> > > >         iomap->addr = fmap->addr;
> > > > @@ -341,7 +338,9 @@ static inline void fuse_iomap_from_server(struct inode *inode,
> > > >         iomap->length = fmap->length;
> > > >         iomap->type = fuse_iomap_type_from_server(fmap->type);
> > > >         iomap->flags = fuse_iomap_flags_from_server(fmap->flags);
> > > > -       iomap->bdev = inode->i_sb->s_bdev; /* XXX */
> > > > +
> > > > +       iomap->bdev = fb ? fb->bdev : NULL;
> > > > +       iomap->dax_dev = NULL;
> > > >  }
> > > >
> > > >  /* Convert a mapping from the kernel into something the server can use */
> > > > @@ -392,6 +391,27 @@ static inline bool fuse_is_iomap_file_write(unsigned int opflags)
> > > >         return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
> > > >  }
> > > >
> > > > +static inline struct fuse_backing *
> > > > +fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
> > > > +{
> > > > +       struct fuse_backing *ret = NULL;
> > > > +
> > > > +       if (map->dev != FUSE_IOMAP_DEV_NULL && map->dev < INT_MAX)
> > > > +               ret = fuse_backing_lookup(fc, &fuse_iomap_backing_ops,
> > > > +                                         map->dev);
> > > > +
> > > > +       switch (map->type) {
> > > > +       case FUSE_IOMAP_TYPE_MAPPED:
> > > > +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> > > > +               /* Mappings backed by space must have a device/addr */
> > > > +               if (BAD_DATA(ret == NULL))
> > > > +                       return ERR_PTR(-EFSCORRUPTED);
> > > > +               break;
> > > > +       }
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > >  static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
> > > >                             unsigned opflags, struct iomap *iomap,
> > > >                             struct iomap *srcmap)
> > > > @@ -405,6 +425,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
> > > >         };
> > > >         struct fuse_iomap_begin_out outarg = { };
> > > >         struct fuse_mount *fm = get_fuse_mount(inode);
> > > > +       struct fuse_backing *read_dev = NULL;
> > > > +       struct fuse_backing *write_dev = NULL;
> > > >         FUSE_ARGS(args);
> > > >         int err;
> > > >
> > > > @@ -431,24 +453,44 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
> > > >         if (err)
> > > >                 return err;
> > > >
> > > > +       read_dev = fuse_iomap_find_dev(fm->fc, &outarg.read);
> > > > +       if (IS_ERR(read_dev))
> > > > +               return PTR_ERR(read_dev);
> > > > +
> > > >         if (fuse_is_iomap_file_write(opflags) &&
> > > >             outarg.write.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
> > > > +               /* open the write device */
> > > > +               write_dev = fuse_iomap_find_dev(fm->fc, &outarg.write);
> > > > +               if (IS_ERR(write_dev)) {
> > > > +                       err = PTR_ERR(write_dev);
> > > > +                       goto out_read_dev;
> > > > +               }
> > > > +
> > > >                 /*
> > > >                  * For an out of place write, we must supply the write mapping
> > > >                  * via @iomap, and the read mapping via @srcmap.
> > > >                  */
> > > > -               fuse_iomap_from_server(inode, iomap, &outarg.write);
> > > > -               fuse_iomap_from_server(inode, srcmap, &outarg.read);
> > > > +               fuse_iomap_from_server(inode, iomap, write_dev, &outarg.write);
> > > > +               fuse_iomap_from_server(inode, srcmap, read_dev, &outarg.read);
> > > >         } else {
> > > >                 /*
> > > >                  * For everything else (reads, reporting, and pure overwrites),
> > > >                  * we can return the sole mapping through @iomap and leave
> > > >                  * @srcmap unchanged from its default (HOLE).
> > > >                  */
> > > > -               fuse_iomap_from_server(inode, iomap, &outarg.read);
> > > > +               fuse_iomap_from_server(inode, iomap, read_dev, &outarg.read);
> > > >         }
> > > >
> > > > -       return 0;
> > > > +       /*
> > > > +        * XXX: if we ever want to support closing devices, we need a way to
> > > > +        * track the fuse_backing refcount all the way through bio endios.
> > > > +        * For now we put the refcount here because you can't remove an iomap
> > > > +        * device until unmount time.
> > > > +        */
> > > > +       fuse_backing_put(write_dev);
> > > > +out_read_dev:
> > > > +       fuse_backing_put(read_dev);
> > > > +       return err;
> > > >  }
> > > >
> > > >  /* Decide if we send FUSE_IOMAP_END to the fuse server */
> > > > @@ -523,3 +565,42 @@ const struct iomap_ops fuse_iomap_ops = {
> > > >         .iomap_begin            = fuse_iomap_begin,
> > > >         .iomap_end              = fuse_iomap_end,
> > > >  };
> > > > +
> > > > +static int fuse_iomap_may_admin(struct fuse_conn *fc, unsigned int flags)
> > > > +{
> > > > +       if (!fc->iomap)
> > > > +               return -EPERM;
> > > > +
> > >
> > > IIRC, on RFC I asked why is iomap exempt from CAP_SYS_ADMIN
> > > check. If there was a good reason, I forgot it.
> >
> > CAP_SYS_ADMIN means that the fuse server (or the fuservicemount helper)
> > can make quite a lot of other changes to the system that are not at all
> > related to being a filesystem.  I'd rather not use that one.
> >
> > Instead I require CAP_SYS_RAWIO to enable fc->iomap, so that the fuse
> > server has to have *some* privilege, but only enough to write to raw
> > block devices since that's what iomap does.
> >
> > > The problem is that while fuse-iomap fs is only expected to open
> > > a handful of backing devs, we would like to prevent abuse of this ioctl
> > > by a buggy or malicious user.
> > >
> > > I think that if you want to avoid CAP_SYS_ADMIN here you should
> > > enforce a limit on the number of backing bdevs.
> > >
> > > If you accept my suggestion to mutually exclude passthrough and
> > > iomap features per fs, then you'd just need to keep track on numbers
> > > of fuse_backing ids and place a limit for iomap fs.
> > >
> > > BTW, I think it is enough keep track of the number of backing ids
> > > and no need to keep track of the number of fuse_backing objects
> > > (which can outlive a backing id), because an "anonymous" fuse_backing
> > > object is always associated with an open fuse file - that's the same as
> > > an overlayfs backing file, which is not accounted for in ulimit.
> >
> > How about restricting the backing ids to RLIMIT_NOFILE?  The @end param
> > to idr_alloc_cyclic constrains them in exactly that way.
> 
> IDK. My impression was that Miklos didn't like having a large number
> of unaccounted files, but it's up to him.
> 
> Do you have an estimate on the worst case number of backing blockdev
> for fuse iomap?

It's the upper limit on the number of block devices that you can attach
to a multi-device filesystem for use with files.  For ext4 it's 1, for
XFS it would be 2, for btrfs I have no idea.

--D

> Thanks,
> Amir.

