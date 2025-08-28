Return-Path: <linux-fsdevel+bounces-59457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FECB39026
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 02:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB89E9806CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE54207A;
	Thu, 28 Aug 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYZ1Q3gC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB0125A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341386; cv=none; b=NQA08Xkw2nWD7AheVkMhPka8Qd/m1AoqnmeRdtrAu+Hn212cfacxH4PVsCVTB5+s3TZcEn20JWTiY7pAxe/xQWm7epdeAsCLNjO2iek2/qsf32WxWF8503/nCppQKdcfuUWGAHnKRI76srIkmz9tFXx5v4qlrPpkCehPhYXhkkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341386; c=relaxed/simple;
	bh=iArTJsS1Iogq4lixMEPm8A2UUuh+ClEm7V89R7PJfiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF7b7DPDMckuLBcTHXSdoZzH0dUsh2kcxgpiWGw5nzsTiyMBtB/dkmO54imbsY8m4ScwxWRCRP0NDdJpKL+pYH2GHF6junMtWPdSuZNdAB+QMBggTWgOw7YLAhM9mWKGOcn2F15010GqaADimGIWxT+oj7QSzvbeGGDx2MrOcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYZ1Q3gC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD7AC4CEEB;
	Thu, 28 Aug 2025 00:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756341386;
	bh=iArTJsS1Iogq4lixMEPm8A2UUuh+ClEm7V89R7PJfiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYZ1Q3gCzpfxiiJFQMjeq9hlyxDzbhIJT1uPx7is9AF+mWC+L7lcwBxX0zhLSR8O4
	 FqyXQGmyTdkFsaNk360RCZeyCiEWfGaiMmJwNKY59J6CoKj+gItllja1Md+0Jf8Ivg
	 oAbtK729xxkdaqN3MkO/Oh0h1PPfdZi13WW8iVKCh4ZOliZIugUKI8xMN4MheOFXj2
	 NpYrTFTCns53K+/Kx7bfr5Xem+EjYjXnvc1vbNbaxqi6Yh9qKiw1O7CWzU6pzrqVYF
	 MPARtxUw5qiPSOvO3Y+8Ao4dHoStxJqbzP1p8YTmLN/4TJVIrdoj2SVzt9H4lAGOJb
	 vYfao9zy/JHNg==
Date: Wed, 27 Aug 2025 17:36:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2] fuse: allow synchronous FUSE_INIT
Message-ID: <20250828003625.GE8117@frogsfrogsfrogs>
References: <20250827110004.584582-1-mszeredi@redhat.com>
 <CAJnrk1b8FZC82oeWuynWk5oqiRe+04frUv-4w9=jg319KvUz0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1b8FZC82oeWuynWk5oqiRe+04frUv-4w9=jg319KvUz0A@mail.gmail.com>

On Wed, Aug 27, 2025 at 03:56:49PM -0700, Joanne Koong wrote:
> On Wed, Aug 27, 2025 at 4:00 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > FUSE_INIT has always been asynchronous with mount.  That means that the
> > server processed this request after the mount syscall returned.
> >
> > This means that FUSE_INIT can't supply the root inode's ID, hence it
> > currently has a hardcoded value.  There are other limitations such as not
> > being able to perform getxattr during mount, which is needed by selinux.
> >
> > To remove these limitations allow server to process FUSE_INIT while
> > initializing the in-core super block for the fuse filesystem.  This can
> > only be done if the server is prepared to handle this, so add
> > FUSE_DEV_IOC_SYNC_INIT ioctl, which
> >
> >  a) lets the server know whether this feature is supported, returning
> >  ENOTTY othewrwise.
> >
> >  b) lets the kernel know to perform a synchronous initialization
> >
> > The implementation is slightly tricky, since fuse_dev/fuse_conn are set up
> > only during super block creation.  This is solved by setting the private
> > data of the fuse device file to a special value ((struct fuse_dev *) 1) and
> > waiting for this to be turned into a proper fuse_dev before commecing with
> > operations on the device file.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> > v2:
> >
> >  - make fuse_send_init() perform sync/async sequence based on fc->sync_init
> >    (Joanne)
> >
> > fs/fuse/cuse.c            |  3 +-
> >  fs/fuse/dev.c             | 74 +++++++++++++++++++++++++++++----------
> >  fs/fuse/dev_uring.c       |  4 +--
> >  fs/fuse/fuse_dev_i.h      | 13 +++++--
> >  fs/fuse/fuse_i.h          |  5 ++-
> >  fs/fuse/inode.c           | 50 ++++++++++++++++++++------
> >  include/uapi/linux/fuse.h |  1 +
> >  7 files changed, 115 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 8ac074414897..948f45c6e0ef 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1530,14 +1530,34 @@ static int fuse_dev_open(struct inode *inode, struct file *file)
> >         return 0;
> >  }
> >
> > +struct fuse_dev *fuse_get_dev(struct file *file)
> > +{
> > +       struct fuse_dev *fud = __fuse_get_dev(file);
> > +       int err;
> > +
> > +       if (likely(fud))
> > +               return fud;
> > +
> > +       err = wait_event_interruptible(fuse_dev_waitq,
> > +                                      READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
> 
> I wonder if we should make the semantics the same for synchronous and
> non-synchronous inits here, i.e. doing a wait for
> "(READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT) &&
> READ_ONCE(file->private_data) != NULL", so that from the libfuse point
> of view, the flow can be unified between the two, eg
> i) send sync_init ioctl call if doing a synchronous init
> ii) kick off thread to read requests
> iii) do mount call
> otherwise for async inits, the mount call needs to happen first.

I don't think you can compare it against NULL directly, because
FUSE_DEV_SYNC_INIT != NULL evaluates to true.

How about

	err = wait_event_interruptible(fuse_dev_waitq,
				       __fuse_get_dev(file) != NULL);

?

> > +       if (err)
> > +               return ERR_PTR(err);
> > +
> > +       fud = __fuse_get_dev(file);
> > +       if (!fud)
> > +               return ERR_PTR(-EPERM);
> > +
> > +       return fud;
> > +}
> > +
> >  static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
> >  {
> >         struct fuse_copy_state cs;
> >         struct file *file = iocb->ki_filp;
> >         struct fuse_dev *fud = fuse_get_dev(file);
> >
> > -       if (!fud)
> > -               return -EPERM;
> > +       if (IS_ERR(fud))
> > +               return PTR_ERR(fud);
> >
> >         if (!user_backed_iter(to))
> >                 return -EINVAL;
> > @@ -1557,8 +1577,8 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
> >         struct fuse_copy_state cs;
> >         struct fuse_dev *fud = fuse_get_dev(in);
> >
> > -       if (!fud)
> > -               return -EPERM;
> > +       if (IS_ERR(fud))
> > +               return PTR_ERR(fud);
> >
> >         bufs = kvmalloc_array(pipe->max_usage, sizeof(struct pipe_buffer),
> >                               GFP_KERNEL);
> > @@ -2233,8 +2253,8 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
> >         struct fuse_copy_state cs;
> >         struct fuse_dev *fud = fuse_get_dev(iocb->ki_filp);
> 
> Does this (and below in fuse_dev_splice_write()) need to be
> fuse_get_dev()? afaict, fuse_dev_write() only starts getting used
> after fud has already been initialized. i see why it's needed for
> fuse_dev_read() since otherwise the server doesn't know when it can
> start calling fuse_dev_read(), but for fuse_dev_write(), it seems like
> that only gets used after fud is already initialized.

I think most of these functions could just do:

	struct fuse_dev *fud = __fuse_get_dev(iocb->ki_filp);

	if (!fud)
		return -EPERM;

Just like the old days, but it's one churn (if test) vs. another
(callsite) type of churn.  Either way, we want to error out of all of
these functions if you haven't actually mounted the fuse server to
create the fud, right?

> >
> > -       if (!fud)
> > -               return -EPERM;
> > +       if (IS_ERR(fud))
> > +               return PTR_ERR(fud);
> >
> >         if (!user_backed_iter(from))
> >                 return -EINVAL;
> > @@ -2258,8 +2278,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
> >         ssize_t ret;
> >
> >         fud = fuse_get_dev(out);
> > -       if (!fud)
> > -               return -EPERM;
> > +       if (IS_ERR(fud))
> > +               return PTR_ERR(fud);
> >
> >         pipe_lock(pipe);
> >
> > @@ -2581,8 +2601,8 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
> >         struct fuse_dev *fud = fuse_get_dev(file);
> 
> Should this be __fuse_get_dev()?
> 
> >         struct fuse_backing_map map;
> >
> > -       if (!fud)
> > -               return -EPERM;
> > +       if (IS_ERR(fud))
> > +               return PTR_ERR(fud);
> >
> >         if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >                 return -EOPNOTSUPP;
> > @@ -2598,8 +2618,8 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
> >         struct fuse_dev *fud = fuse_get_dev(file);
> 
> Same question here.
> 
> >         int backing_id;
> >
> > -       if (!fud)
> > -               return -EPERM;
> > +       if (IS_ERR(fud))
> > +               return PTR_ERR(fud);
> >
> >         if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >                 return -EOPNOTSUPP;
> > @@ -2610,6 +2630,19 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
> >         return fuse_backing_close(fud->fc, backing_id);
> >  }
> >
> > +static long fuse_dev_ioctl_sync_init(struct file *file)
> > +{
> > +       int err = -EINVAL;
> > +
> > +       mutex_lock(&fuse_mutex);
> > +       if (!__fuse_get_dev(file)) {
> > +               WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
> 
> Does this still need a WRITE_ONCE if it's accessed within the scope of
> the mutex? My understanding (maybe wrong) is that a mutex implicitly
> serves as also a memory barrier. If not, then we probably also need a
> WRITE_ONCE() around the *ctx->fudptr assignment in
> fuse_fill_super_common()?

I agree with this, the (re)ordering before the mutex unlock doesn't
matter because the unlock is a write barrier.  But I don't think it
hurts to have redundant WRITE_ONCE.

--D

> 
> Thanks,
> Joanne
> 
> > +               err = 0;
> > +       }
> > +       mutex_unlock(&fuse_mutex);
> > +       return err;
> > +}
> > +
> > @@ -1876,8 +1901,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
> >
> >         list_add_tail(&fc->entry, &fuse_conn_list);
> >         sb->s_root = root_dentry;
> > -       if (ctx->fudptr)
> > +       if (ctx->fudptr) {
> >                 *ctx->fudptr = fud;
> > +               wake_up_all(&fuse_dev_waitq);
> > +       }
> >         mutex_unlock(&fuse_mutex);
> >         return 0;
> >

