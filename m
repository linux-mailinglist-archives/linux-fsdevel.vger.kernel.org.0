Return-Path: <linux-fsdevel+bounces-55445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D6B0A868
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9D07B2D65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0530D2E5B39;
	Fri, 18 Jul 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QghpmAf5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CAF1C36
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856032; cv=none; b=UDTUVkd8hThawKXIaUSIxuCqOX/PmGYbHTg6O170QuEydJamZhxILY3ecxFPei0JjOjEzyxGhtcZJvLeVHZVRMn6C65OUxTsE/+stkXcuVxmt6fHs5eEHAuGV9oRYtG7qHtMoVdznYTnqR4SOeHB7K3Ao2pZivZzjwY5Xk76jPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856032; c=relaxed/simple;
	bh=dfaZmKtMzf4+/69pD9GvtqKvWVanAuCwdhVESh+FE4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwu/d4UZCHOQA9UW3KbBekKQVjwCeUZoXUPzNDNd2UdtIbJUefvYMif66k8yqI9/yNpXNBPjWvBwTtNQkV8mo7uI5064VGvuhij9dJTOOaJp8Vodk0rIoYMF7mmerQ55f+ov0M9m4Qrf3EAirk7eyad787NaKAQQItSdjc0Ra+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QghpmAf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0611EC4CEEB;
	Fri, 18 Jul 2025 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856031;
	bh=dfaZmKtMzf4+/69pD9GvtqKvWVanAuCwdhVESh+FE4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QghpmAf5DaX18tsDbyEa/LAleza3kVED3U335qLCf6vB6qhxoRc8PISyayKSCLl0+
	 Ir0+2g2tP3NeobCRceeaW1vVsnnVqmNpqZ+3ZYqEMWVEyahwrzH6UV83JIjjVZadA1
	 fvGhGuemJOOApymaMA5946B9kOAu+yQUhUg4VL4rfyaZjuD/gTvTOBYYFnc6cd0y+4
	 BP/smWU+ptiGKkfZJbQlhf2Y1yK/1ENRW+lniOhYP/gQwJvhDEQnN7Rbi8An5ijrIK
	 QOBGSucC0Gt3gmSlJTwuUO0g26r+2phVdMEb6niDxLMDFSssQpYJ2cZpP5hLPpv6d5
	 gE0gOmRP1BUsA==
Date: Fri, 18 Jul 2025 09:27:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev,
	miklos@szeredi.hu
Subject: Re: [PATCH 3/4] libfuse: add statx support to the lower level library
Message-ID: <20250718162710.GU2672029@frogsfrogsfrogs>
References: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
 <175279460430.714831.6251867847811735740.stgit@frogsfrogsfrogs>
 <CAOQ4uxjzU7o9j9LE1cQjGsKMpfrH0S2DGsrd=xGAqHyWbGFwng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjzU7o9j9LE1cQjGsKMpfrH0S2DGsrd=xGAqHyWbGFwng@mail.gmail.com>

On Fri, Jul 18, 2025 at 03:28:25PM +0200, Amir Goldstein wrote:
> On Fri, Jul 18, 2025 at 1:39 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Add statx support to the lower level fuse library.
> 
> This looked familiar.
> Merged 3 days ago:
> https://github.com/libfuse/libfuse/pull/1026
> 
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  include/fuse_lowlevel.h |   37 ++++++++++++++++++
> >  lib/fuse_lowlevel.c     |   97 +++++++++++++++++++++++++++++++++++++++++++++++
> >  lib/fuse_versionscript  |    2 +
> >  3 files changed, 136 insertions(+)

<snip>

> > diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> > index ec30ebc4cdd074..8eeb6a8547da91 100644
> > --- a/lib/fuse_lowlevel.c
> > +++ b/lib/fuse_lowlevel.c
> > @@ -144,6 +144,43 @@ static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
> >         ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
> >  }
> >
> > +#ifdef STATX_BASIC_STATS
> > +static int convert_statx(struct fuse_statx *stbuf, const struct statx *stx,
> > +                        size_t size)
> > +{
> > +       if (sizeof(struct statx) != size)
> > +               return EOPNOTSUPP;
> > +
> > +       stbuf->mask = stx->stx_mask & (STATX_BASIC_STATS | STATX_BTIME);
> > +       stbuf->blksize          = stx->stx_blksize;
> > +       stbuf->attributes       = stx->stx_attributes;
> > +       stbuf->nlink            = stx->stx_nlink;
> > +       stbuf->uid              = stx->stx_uid;
> > +       stbuf->gid              = stx->stx_gid;
> > +       stbuf->mode             = stx->stx_mode;
> > +       stbuf->ino              = stx->stx_ino;
> > +       stbuf->size             = stx->stx_size;
> > +       stbuf->blocks           = stx->stx_blocks;
> > +       stbuf->attributes_mask  = stx->stx_attributes_mask;
> > +       stbuf->rdev_major       = stx->stx_rdev_major;
> > +       stbuf->rdev_minor       = stx->stx_rdev_minor;
> > +       stbuf->dev_major        = stx->stx_dev_major;
> > +       stbuf->dev_minor        = stx->stx_dev_minor;
> > +
> > +       stbuf->atime.tv_sec     = stx->stx_atime.tv_sec;
> > +       stbuf->btime.tv_sec     = stx->stx_btime.tv_sec;
> > +       stbuf->ctime.tv_sec     = stx->stx_ctime.tv_sec;
> > +       stbuf->mtime.tv_sec     = stx->stx_mtime.tv_sec;
> > +
> > +       stbuf->atime.tv_nsec    = stx->stx_atime.tv_nsec;
> > +       stbuf->btime.tv_nsec    = stx->stx_btime.tv_nsec;
> > +       stbuf->ctime.tv_nsec    = stx->stx_ctime.tv_nsec;
> > +       stbuf->mtime.tv_nsec    = stx->stx_mtime.tv_nsec;
> > +
> > +       return 0;
> > +}
> > +#endif
> > +
> 
> Why is this conversion not needed in the merged version?
> What am I missing?

The patch in upstream memcpy's struct statx to struct fuse_statx:

	memset(&arg, 0, sizeof(arg));
	arg.flags = flags;
	arg.attr_valid = calc_timeout_sec(attr_timeout);
	arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
	memcpy(&arg.stat, statx, sizeof(arg.stat));

As long as the fields in the two are kept exactly in sync, this isn't a
problem and no explicit struct conversion is necessary.

I also noticed that the !HAVE_STATX variant of _do_statx doesn't call
fuse_reply_err(req, ENOSYS).  I think that means a new kernel calling
an old userspace would never receive a reply to a FUSE_STATX command
and ... time out?

My version also has explicit sizing of struct statx, but I concede that
if that struct ever gets bigger we're going to have to rev the whole
syscall anyway.  I was being perhaps a bit paranoid.

BTW, where are libfuse patches reviewed?  I guess all the review are
done via github PRs?

--D

> Thanks,
> Amir.
> 
> >  static size_t iov_length(const struct iovec *iov, size_t count)
> >  {
> >         size_t seg;
> > @@ -2653,6 +2690,64 @@ static void do_syncfs(fuse_req_t req, const fuse_ino_t nodeid, const void *inarg
> >         _do_syncfs(req, nodeid, inarg, NULL);
> >  }
> >
> > +#ifdef STATX_BASIC_STATS
> > +int fuse_reply_statx(fuse_req_t req, const struct statx *statx, size_t size,
> > +                    double attr_timeout)
> > +{
> > +       struct fuse_statx_out arg = {
> > +               .attr_valid = calc_timeout_sec(attr_timeout),
> > +               .attr_valid_nsec = calc_timeout_nsec(attr_timeout),
> > +       };
> > +
> > +       int err = convert_statx(&arg.stat, statx, size);
> > +       if (err) {
> > +               fuse_reply_err(req, err);
> > +               return err;
> > +       }
> > +
> > +       return send_reply_ok(req, &arg, sizeof(arg));
> > +}
> > +
> > +static void _do_statx(fuse_req_t req, const fuse_ino_t nodeid,
> > +                     const void *op_in, const void *in_payload)
> > +{
> > +       (void)in_payload;
> > +       const struct fuse_statx_in *arg = op_in;
> > +       struct fuse_file_info *fip = NULL;
> > +       struct fuse_file_info fi;
> > +
> > +       if (arg->getattr_flags & FUSE_GETATTR_FH) {
> > +               memset(&fi, 0, sizeof(fi));
> > +               fi.fh = arg->fh;
> > +               fip = &fi;
> > +       }
> > +
> > +       if (req->se->op.statx)
> > +               req->se->op.statx(req, nodeid, arg->sx_flags, arg->sx_mask,
> > +                                 fip);
> > +       else
> > +               fuse_reply_err(req, ENOSYS);
> > +}
> > +#else
> > +int fuse_reply_statx(fuse_req_t req, const struct statx *statx,
> > +                    double attr_timeout)
> > +{
> > +       fuse_reply_err(req, ENOSYS);
> > +       return -ENOSYS;
> > +}
> > +
> > +static void _do_statx(fuse_req_t req, const fuse_ino_t nodeid,
> > +                     const void *op_in, const void *in_payload)
> > +{
> > +       fuse_reply_err(req, ENOSYS);
> > +}
> > +#endif /* STATX_BASIC_STATS */
> > +
> > +static void do_statx(fuse_req_t req, const fuse_ino_t nodeid, const void *inarg)
> > +{
> > +       _do_statx(req, nodeid, inarg, NULL);
> > +}
> > +
> >  static bool want_flags_valid(uint64_t capable, uint64_t want)
> >  {
> >         uint64_t unknown_flags = want & (~capable);
> > @@ -3627,6 +3722,7 @@ static struct {
> >         [FUSE_COPY_FILE_RANGE] = { do_copy_file_range, "COPY_FILE_RANGE" },
> >         [FUSE_LSEEK]       = { do_lseek,       "LSEEK"       },
> >         [FUSE_SYNCFS]      = { do_syncfs,       "SYNCFS"     },
> > +       [FUSE_STATX]       = { do_statx,       "STATX"       },
> >         [FUSE_IOMAP_CONFIG]= { do_iomap_config, "IOMAP_CONFIG" },
> >         [FUSE_IOMAP_BEGIN] = { do_iomap_begin,  "IOMAP_BEGIN" },
> >         [FUSE_IOMAP_END]   = { do_iomap_end,    "IOMAP_END" },
> > @@ -3686,6 +3782,7 @@ static struct {
> >         [FUSE_COPY_FILE_RANGE]  = { _do_copy_file_range, "COPY_FILE_RANGE" },
> >         [FUSE_LSEEK]            = { _do_lseek,          "LSEEK" },
> >         [FUSE_SYNCFS]           = { _do_syncfs,         "SYNCFS" },
> > +       [FUSE_STATX]            = { _do_statx,          "STATX" },
> >         [FUSE_IOMAP_CONFIG]     = { _do_iomap_config,   "IOMAP_CONFIG" },
> >         [FUSE_IOMAP_BEGIN]      = { _do_iomap_begin,    "IOMAP_BEGIN" },
> >         [FUSE_IOMAP_END]        = { _do_iomap_end,      "IOMAP_END" },
> > diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> > index dc9fa2428b5325..a67b1802770335 100644
> > --- a/lib/fuse_versionscript
> > +++ b/lib/fuse_versionscript
> > @@ -223,6 +223,8 @@ FUSE_3.18 {
> >                 fuse_reply_iomap_config;
> >                 fuse_lowlevel_notify_iomap_upsert;
> >                 fuse_lowlevel_notify_iomap_inval;
> > +
> > +               fuse_reply_statx;
> >  } FUSE_3.17;
> >
> >  # Local Variables:
> >
> >
> 

