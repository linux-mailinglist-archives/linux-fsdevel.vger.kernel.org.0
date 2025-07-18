Return-Path: <linux-fsdevel+bounces-55464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FAEB0AA49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611D44E3B4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE032E7F0A;
	Fri, 18 Jul 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzClFTmt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F841C5D53
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864153; cv=none; b=UT08y1hfBklQHX4CPM0KfPG8v3A7kpLwF8QuUWyiu38h5taRRn+tqXHu7R0RqW7d1U2CI2eMuCMoyDmKRZvMuaTtlnfagoAlUwjAPOD/HXywH6zswYoz5/iLUJ4Au6TLk9Uo58EF9lMnMsYeXhfIjHQ/T9Kvi/YVBYWSIuCsZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864153; c=relaxed/simple;
	bh=jw0xiHA46ByIoB6dAKe29ASoHROliuHbrSp/fH1RrMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzYuJaKhqPCpn0IHK3CrF55PDBBmGIjlximnrZhx/5aE5hg8LTAlwHvVJyTKVdZaHay9W1m9bRyqrekgSzwggktjLV1ZTPUzQSGaUWlGg2hrGO38kkcIK+6UJCiwFf/DQKs4Q+Trh0QSFjRpbuzaYUXHJGGBOeuax0Dd6O25Lts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzClFTmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B59C4CEEB;
	Fri, 18 Jul 2025 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864152;
	bh=jw0xiHA46ByIoB6dAKe29ASoHROliuHbrSp/fH1RrMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzClFTmtBuBmQ1HZJRDwfHH3ljDghit5g3fV5GmNRjqJq0B03rmN+X0R/SWofgXVd
	 j41Hs95F8b0V57iwjws6DWnADvFIR2L6bm/75JXVJd/+xknk8C2W0YXiK+EV0yr+dl
	 kJoIZryYB3VJWm/UGVuQ2yTNwbMxH3TFFh6ciVmrzq3vzRBen6FqIPAkMyPnqBP+wQ
	 KxZSJOBfTOOtcD00WEOVd+sNoUtC4X9P6ihVbErpjNRJjedZ1rO7+pjf1/j+zbHAJk
	 Wcrw+Hyv+pUwCTabT9hjrOxVWIBY4rfRVeK13PM43XaphRVIpsyttv2w0X2jd0GCue
	 gx18W9iKTDg2g==
Date: Fri, 18 Jul 2025 11:42:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>, John@groves.net,
	joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Subject: Re: [PATCH 3/4] libfuse: add statx support to the lower level library
Message-ID: <20250718184232.GA2672029@frogsfrogsfrogs>
References: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
 <175279460430.714831.6251867847811735740.stgit@frogsfrogsfrogs>
 <CAOQ4uxjzU7o9j9LE1cQjGsKMpfrH0S2DGsrd=xGAqHyWbGFwng@mail.gmail.com>
 <20250718162710.GU2672029@frogsfrogsfrogs>
 <86eec0dd-91dd-4b58-b753-5bc6a830114b@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86eec0dd-91dd-4b58-b753-5bc6a830114b@ddn.com>

On Fri, Jul 18, 2025 at 06:54:44PM +0200, Bernd Schubert wrote:
> 
> 
> On 7/18/25 18:27, Darrick J. Wong wrote:
> > On Fri, Jul 18, 2025 at 03:28:25PM +0200, Amir Goldstein wrote:
> >> On Fri, Jul 18, 2025 at 1:39 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >>>
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> Add statx support to the lower level fuse library.
> >>
> >> This looked familiar.
> >> Merged 3 days ago:
> >> https://github.com/libfuse/libfuse/pull/1026
> >>
> >>>
> >>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >>> ---
> >>>  include/fuse_lowlevel.h |   37 ++++++++++++++++++
> >>>  lib/fuse_lowlevel.c     |   97 +++++++++++++++++++++++++++++++++++++++++++++++
> >>>  lib/fuse_versionscript  |    2 +
> >>>  3 files changed, 136 insertions(+)
> > 
> > <snip>
> > 
> >>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> >>> index ec30ebc4cdd074..8eeb6a8547da91 100644
> >>> --- a/lib/fuse_lowlevel.c
> >>> +++ b/lib/fuse_lowlevel.c
> >>> @@ -144,6 +144,43 @@ static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
> >>>         ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
> >>>  }
> >>>
> >>> +#ifdef STATX_BASIC_STATS
> >>> +static int convert_statx(struct fuse_statx *stbuf, const struct statx *stx,
> >>> +                        size_t size)
> >>> +{
> >>> +       if (sizeof(struct statx) != size)
> >>> +               return EOPNOTSUPP;
> >>> +
> >>> +       stbuf->mask = stx->stx_mask & (STATX_BASIC_STATS | STATX_BTIME);
> >>> +       stbuf->blksize          = stx->stx_blksize;
> >>> +       stbuf->attributes       = stx->stx_attributes;
> >>> +       stbuf->nlink            = stx->stx_nlink;
> >>> +       stbuf->uid              = stx->stx_uid;
> >>> +       stbuf->gid              = stx->stx_gid;
> >>> +       stbuf->mode             = stx->stx_mode;
> >>> +       stbuf->ino              = stx->stx_ino;
> >>> +       stbuf->size             = stx->stx_size;
> >>> +       stbuf->blocks           = stx->stx_blocks;
> >>> +       stbuf->attributes_mask  = stx->stx_attributes_mask;
> >>> +       stbuf->rdev_major       = stx->stx_rdev_major;
> >>> +       stbuf->rdev_minor       = stx->stx_rdev_minor;
> >>> +       stbuf->dev_major        = stx->stx_dev_major;
> >>> +       stbuf->dev_minor        = stx->stx_dev_minor;
> >>> +
> >>> +       stbuf->atime.tv_sec     = stx->stx_atime.tv_sec;
> >>> +       stbuf->btime.tv_sec     = stx->stx_btime.tv_sec;
> >>> +       stbuf->ctime.tv_sec     = stx->stx_ctime.tv_sec;
> >>> +       stbuf->mtime.tv_sec     = stx->stx_mtime.tv_sec;
> >>> +
> >>> +       stbuf->atime.tv_nsec    = stx->stx_atime.tv_nsec;
> >>> +       stbuf->btime.tv_nsec    = stx->stx_btime.tv_nsec;
> >>> +       stbuf->ctime.tv_nsec    = stx->stx_ctime.tv_nsec;
> >>> +       stbuf->mtime.tv_nsec    = stx->stx_mtime.tv_nsec;
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +#endif
> >>> +
> >>
> >> Why is this conversion not needed in the merged version?
> >> What am I missing?
> > 
> > The patch in upstream memcpy's struct statx to struct fuse_statx:
> > 
> > 	memset(&arg, 0, sizeof(arg));
> > 	arg.flags = flags;
> > 	arg.attr_valid = calc_timeout_sec(attr_timeout);
> > 	arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
> > 	memcpy(&arg.stat, statx, sizeof(arg.stat));
> > 
> > As long as the fields in the two are kept exactly in sync, this isn't a
> > problem and no explicit struct conversion is necessary.
> > 
> > I also noticed that the !HAVE_STATX variant of _do_statx doesn't call
> > fuse_reply_err(req, ENOSYS).  I think that means a new kernel calling
> > an old userspace would never receive a reply to a FUSE_STATX command
> > and ... time out?
> > 
> > My version also has explicit sizing of struct statx, but I concede that
> > if that struct ever gets bigger we're going to have to rev the whole
> > syscall anyway.  I was being perhaps a bit paranoid.
> > 
> > BTW, where are libfuse patches reviewed?  I guess all the review are
> > done via github PRs?
> 
> Yeah, typical procedure is github PR. If preferred for these complex
> patches fine with me to post them here. Especially if others like Amir
> are going to review :)

Ok.  I prefer emailing fsdevel for the broader reach and the
LF-maintained permanent archives of the discussions.

(I really dislike email for actually sending things that are ready for
merging and would rather send PRs though.  In XFSland the PRs are more
or less a formality that comes _after_ months of arguing. :P)

--D

> 
> Thanks,
> Bernd
> 
> 
> 
> 

