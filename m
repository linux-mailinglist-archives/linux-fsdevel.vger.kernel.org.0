Return-Path: <linux-fsdevel+bounces-55443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E6B0A80E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024F416C29F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5352E5B11;
	Fri, 18 Jul 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsjdCdI0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94E29B8C2
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854287; cv=none; b=Oqi6cqXnnkUrrGIxfS8d9dxvJNk/el6CZFEH5f/eVm9C/5sHLboNgui0jkpztY5XJ9OjZVf8FvlUHMda+JY+CifgskLXS3hw0gyt3t59NyM1y+L2kgisv49akN6bS1fW8iltFPNajrYcUB2AUwV4YWfuStNp6Z0c6RMZRP85F2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854287; c=relaxed/simple;
	bh=bYAXmzuRHRHLEktxCJTK0fAnME9k7bpyzjEwleol5Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t28okrsH0BtgpnUsIwIyLGKEAaie98H1MHBSBevVZ22gCvok6rEupyK10RrXgLvTmNOqa3uimJJVSAYXMl91EChi+sowSYHg51JTDo88qYy3xSZRpq13UhyEONDfriIj7cbuAMPjFJZJbvEBTylsdHTcJF5QuUDydvfWNENKWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsjdCdI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779B4C4CEEB;
	Fri, 18 Jul 2025 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752854285;
	bh=bYAXmzuRHRHLEktxCJTK0fAnME9k7bpyzjEwleol5Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsjdCdI0XHGjSDcWdDucGaP7wYm/WxggNCRxUa4IZ2dequ2vPDoVP9mPOtlpSX3di
	 t+S/1+DN6+cfAafy4AG0Sxwf/wYguvYuwuZG4IxCfAfxuIAzVBUibmT4U3cDYlCHcB
	 RE/bis5EuBRmdPaVy6wETTnHdB0gETU9OyviLvKnELkWSoWZjeUxhbUpCg25eZPX8i
	 VxQpcg44a6MsDMuPHJ9LqxBZZIVpqJC++L1+hH2nIvKRyHVoY6ICG1HGb+2J4tH4gO
	 61Z/D/vMKiBvtUZtyX1nVettPFShHXUb5iq1ay0xCPWe5rMENanptCefBaasooGnmi
	 D1RFQ4o4s1eZQ==
Date: Fri, 18 Jul 2025 08:58:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev,
	miklos@szeredi.hu
Subject: Re: [PATCH 3/4] libfuse: add statx support to the lower level library
Message-ID: <20250718155804.GT2672029@frogsfrogsfrogs>
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

Heheheh ok I'll rebase then.  I see Joanne's version is more complete
than mine anyway. :)

That said, is there any interest in adding the newer statx fields
(subvol id, directio geometry, atomic write geometry) to the FUSE_STATX
UABI?  fuse+iomap could support atomic writes pretty easily AFAICT.

(But first things first, there's at least one or two lingering data
corruption bugs in non-iomap fuse2fs that I ought to squash :P)

--D

> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  include/fuse_lowlevel.h |   37 ++++++++++++++++++
> >  lib/fuse_lowlevel.c     |   97 +++++++++++++++++++++++++++++++++++++++++++++++
> >  lib/fuse_versionscript  |    2 +
> >  3 files changed, 136 insertions(+)
> >
> >
> > diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> > index 77685e433e4f7d..f4d62cee22870a 100644
> > --- a/include/fuse_lowlevel.h
> > +++ b/include/fuse_lowlevel.h
> > @@ -1416,6 +1416,26 @@ struct fuse_lowlevel_ops {
> >          * @param ino the inode number
> >          */
> >         void (*syncfs) (fuse_req_t req, fuse_ino_t ino);
> > +
> > +       /**
> > +        * Fetch extended stat information about a file
> > +        *
> > +        * If this request is answered with an error code of ENOSYS, this is
> > +        * treated as a permanent failure, i.e. all future statx() requests
> > +        * will fail with the same error code without being sent to the
> > +        * filesystem process.
> > +        *
> > +        * Valid replies:
> > +        *   fuse_reply_statx
> > +        *   fuse_reply_err
> > +        *
> > +        * @param req request handle
> > +        * @param statx_flags AT_STATX_* flags
> > +        * @param statx_mask desired STATX_* attribute mask
> > +        * @param fi file information
> > +        */
> > +       void (*statx) (fuse_req_t req, fuse_ino_t ino, uint32_t statx_flags,
> > +                      uint32_t statx_mask, struct fuse_file_info *fi);
> >  #endif /* FUSE_USE_VERSION >= 318 */
> >  };
> >
> > @@ -1897,6 +1917,23 @@ int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_iomap *read_iomap,
> >   * @return zero for success, -errno for failure to send reply
> >   */
> >  int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg);
> > +
> > +struct statx;
> > +
> > +/**
> > + * Reply with statx attributes
> > + *
> > + * Possible requests:
> > + *   statx
> > + *
> > + * @param req request handle
> > + * @param statx the attributes
> > + * @param size the size of the statx structure
> > + * @param attr_timeout validity timeout (in seconds) for the attributes
> > + * @return zero for success, -errno for failure to send reply
> > + */
> > +int fuse_reply_statx(fuse_req_t req, const struct statx *statx, size_t size,
> > +                    double attr_timeout);
> >  #endif /* FUSE_USE_VERSION >= 318 */
> >
> >  /* ----------------------------------------------------------- *
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
> 
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

