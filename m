Return-Path: <linux-fsdevel+bounces-59313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6D6B3730A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 21:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDFE462F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CFF36CC88;
	Tue, 26 Aug 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwW7Dvk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC023AB95
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236379; cv=none; b=Q1nWCBDeAOJMTFh+HHyakzQ+6XEaSS2Ze5xTpbvfaO1hIheNrn/S4EU/kdS+FABPheyJ750UmNlcUoqfZYGPe53vEd0kb0Jeo9zHqWEqRrvc63g1ThPpjAhYv/MmnuJqgIFzxL6TtrgoZOS6t4JNOiqELLr1qxOlpX3rI9tHqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236379; c=relaxed/simple;
	bh=Gvw89Ul3TvjOUTj2D2tNXcJxqXvJmAVj35mAZnLjw8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLdSKRv2Ndm7HLnKVF7EbhnVJJ74okxQ6ITHfL+FFmWTZ1E/aQSBi2/TrtfoftrNLiSpg3Nj59J3IJwD8J/D9LgOeZlVoi2/XW8Md8UZK33NbC8vyND/ytE/4X8PKF3x/l1wzV214kOeCnRf61pEopgQiJpvXc/4Hbun1TDX7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwW7Dvk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5BCC4CEF1;
	Tue, 26 Aug 2025 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756236378;
	bh=Gvw89Ul3TvjOUTj2D2tNXcJxqXvJmAVj35mAZnLjw8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DwW7Dvk2ulUHBqAf/l8DnLpSx/tKayowGTB351WKdsM7xIa6LivZbTOQN48E4h+Kx
	 xh/JfpKa/ATKsveTVJ3T+zOTuE2QsyUZxK1hAQWohE0pp5z6CKJsQodmOlyzwjAPo+
	 AwmZ1VUtkzbAhvsVeogq79WprOY6uWTy9hOZpvjyM8QTUr98Pkl4Hl6xCzlILcpdY/
	 lcrraEzbAu+Tg32trcPL7zFyTQSqCK14qx46yKKdmjzqBEWmBWJa4sBAFDt2DTxkDP
	 /a01lp2kYW29iRB1KOteDavmMIlqjAN4HEx/d6Oz1hYN4gn5ctAlyogK1ctul0+Uyo
	 yPgOqr+ot1ATw==
Date: Tue, 26 Aug 2025 12:26:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH] fuse: allow synchronous FUSE_INIT
Message-ID: <20250826192618.GD19809@frogsfrogsfrogs>
References: <20250822114436.438844-1-mszeredi@redhat.com>
 <CAJnrk1ZbkwiWdZN9eaEQ8Acx1wXgy2i2y4-WsK3w+ocYuN6wwA@mail.gmail.com>
 <CAJnrk1avdErcTcOAMuVTof4J_csc-k1vtq2=9z5Jpqws=VCY+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1avdErcTcOAMuVTof4J_csc-k1vtq2=9z5Jpqws=VCY+g@mail.gmail.com>

On Fri, Aug 22, 2025 at 03:52:38PM -0700, Joanne Koong wrote:
> On Fri, Aug 22, 2025 at 3:46 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Fri, Aug 22, 2025 at 4:44 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> > >
> > > FUSE_INIT has always been asynchronous with mount.  That means that the
> > > server processed this request after the mount syscall returned.
> > >
> > > This means that FUSE_INIT can't supply the root inode's ID, hence it
> > > currently has a hardcoded value.  There are other limitations such as not
> > > being able to perform getxattr during mount, which is needed by selinux.
> > >
> > > To remove these limitations allow server to process FUSE_INIT while
> > > initializing the in-core super block for the fuse filesystem.  This can
> > > only be done if the server is prepared to handle this, so add
> > > FUSE_DEV_IOC_SYNC_INIT ioctl, which
> > >
> > >  a) lets the server know whether this feature is supported, returning
> > >  ENOTTY othewrwise.
> > >
> > >  b) lets the kernel know to perform a synchronous initialization
> > >
> > > The implementation is slightly tricky, since fuse_dev/fuse_conn are set up
> > > only during super block creation.  This is solved by setting the private
> > > data of the fuse device file to a special value ((struct fuse_dev *) 1) and
> > > waiting for this to be turned into a proper fuse_dev before commecing with
> > > operations on the device file.
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > > I tested this with my raw-interface tester, so no libfuse update yet.  Will
> > > work on that next.
> > >
> > >  fs/fuse/cuse.c            |  3 +-
> > >  fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++----------
> > >  fs/fuse/dev_uring.c       |  4 +--
> > >  fs/fuse/fuse_dev_i.h      | 13 +++++--
> > >  fs/fuse/fuse_i.h          |  3 ++
> > >  fs/fuse/inode.c           | 46 +++++++++++++++++++-----
> > >  include/uapi/linux/fuse.h |  1 +
> > >  7 files changed, 112 insertions(+), 32 deletions(-)
> > >
> >
> > Will read this more thoroughly next week but left some comments below for now.
> >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 8ac074414897..948f45c6e0ef 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -1530,14 +1530,34 @@ static int fuse_dev_open(struct inode *inode, struct file *file)
> > >         return 0;
> > >  }
> > >
> > > +struct fuse_dev *fuse_get_dev(struct file *file)
> > > +{
> > > +       struct fuse_dev *fud = __fuse_get_dev(file);
> > > +       int err;
> > > +
> > > +       if (likely(fud))
> > > +               return fud;
> > > +
> > > +       err = wait_event_interruptible(fuse_dev_waitq,
> > > +                                      READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
> > > +       if (err)
> > > +               return ERR_PTR(err);
> > > +
> > > +       fud = __fuse_get_dev(file);
> > > +       if (!fud)
> > > +               return ERR_PTR(-EPERM);
> > > +
> > > +       return fud;
> > > +}
> > > +
> > >
> > > +static long fuse_dev_ioctl_sync_init(struct file *file)
> > > +{
> > > +       int err = -EINVAL;
> > > +
> > > +       mutex_lock(&fuse_mutex);
> > > +       if (!__fuse_get_dev(file)) {
> > > +               WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
> > > +               err = 0;
> > > +       }
> > > +       mutex_unlock(&fuse_mutex);
> > > +       return err;
> >
> > Does this let an untrusted server deadlock fuse if they call
> > FUSE_DEV_IOC_SYNC_INIT twice? afaict, fuse_mutex is a global lock and
> > the 2nd FUSE_DEV_IOC_SYNC_INIT call can forever hold fuse_mutex
> > because of the __fuse_get_dev() -> wait_event_interruptible().
> 
> Never mind this comment, I got __fuse_get_dev() and fuse_get_dev()
> mixed up. fuse_get_dev() is the one that calls
> wait_event_interruptible(), not __fuse_get_dev().
> 
> >
> > > +}
> > > +
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 9d26a5bc394d..d5f9f2abc569 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -1898,6 +1913,7 @@ EXPORT_SYMBOL_GPL(fuse_fill_super_common);
> > >  static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
> > >  {
> > >         struct fuse_fs_context *ctx = fsc->fs_private;
> > > +       struct fuse_mount *fm;
> > >         int err;
> > >
> > >         if (!ctx->file || !ctx->rootmode_present ||
> > > @@ -1918,8 +1934,22 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
> > >                 return err;
> > >         /* file->private_data shall be visible on all CPUs after this */
> > >         smp_mb();
> > > -       fuse_send_init(get_fuse_mount_super(sb));
> > > -       return 0;
> > > +
> > > +       fm = get_fuse_mount_super(sb);
> > > +
> > > +       if (fm->fc->sync_init) {
> > > +               struct fuse_init_args *ia = fuse_new_init(fm);
> > > +
> > > +               err = fuse_simple_request(fm, &ia->args);
> > > +               if (err > 0)
> > > +                       err = 0;
> > > +               process_init_reply(fm, &ia->args, err);
> >
> > Do we need a fuse_dev_free() here if err < 0? If err < 0 then the

Er... are you asking if we should drop the newly created fud via
fuse_dev_release if err != 0?  (AFAICT there is no fuse_dev_free?)

> > mount fails, but fuse_fill_super_common() -> fuse_dev_alloc_install()
> > will have already been called which if i'm understanding it correctly
> > means otherwise the fc will get leaked in this case. Or I guess
> > another option is to retain original behavior with having the mount
> > succeed even if the init server reply returns back an error code?

<shrug> I was figuring that it was fine to leave the fud attached to the
device fd until the caller close()s it, but OTOH maybe the fuse server
would like to try to mount again?  Do fuse servers do that?

--D

> > > +       } else {
> > > +               fuse_send_init(fm);
> > > +               err = 0;
> > > +       }
> >
> > imo this logic looks cleaner if fuse_send_init() takes in a 'bool
> > async' arg and the bulk of this logic is handled there. Especially if
> > virtio is also meant to support synchronous init requests (which I'm
> > not seeing why it wouldn't?)
> >
> > Thanks,
> > Joanne
> >
> > > +
> > > +       return err;
> > >  }
> > >
> > >  /*
> > > @@ -1980,7 +2010,7 @@ static int fuse_get_tree(struct fs_context *fsc)
> > >          * Allow creating a fuse mount with an already initialized fuse
> > >          * connection
> > >          */
> > > -       fud = READ_ONCE(ctx->file->private_data);
> > > +       fud = __fuse_get_dev(ctx->file);
> > >         if (ctx->file->f_op == &fuse_dev_operations && fud) {
> > >                 fsc->sget_key = fud->fc;
> > >                 sb = sget_fc(fsc, fuse_test_super, fuse_set_no_super);
> 

