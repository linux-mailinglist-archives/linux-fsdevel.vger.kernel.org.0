Return-Path: <linux-fsdevel+bounces-58207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A5FB2B205
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 22:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE884E2883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F786348;
	Mon, 18 Aug 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZILG/ra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0263451D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547316; cv=none; b=higc3loZpypJq0hqMHmYn47hw9ilvFucZJB1wgCn9PQSD5ntMr9RnjoeK1+oO07dQwBMAJxJLRkShHOF+TRIFYi/hrJ9tWG2bsCnFNQkooPKnlmj3kSNObuwU/ehL85LdRa+YfhbqVQN8KNT+45KfXikGhn/EDZNbqPGp7fPITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547316; c=relaxed/simple;
	bh=VVh51L5fvQ51fN5bf93/WlxFHYADBNfSsCFhM468P28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qABpYmaFqNnOFGSx1Ss2W6B84pPKrNGaOgeBnGZzjwrkaq0xwtztXjy3fmvs9WNj0gkHuTTO2mCdCHmnXK92qz8jvoFwgDDht6gMNgKMGp2oa3uEdciZzofsPvfDA+W8nQIYp7s3VSn5rmjZPVsA9X+4JWREVuGBFWrDFQXRWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZILG/ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122BC4CEEB;
	Mon, 18 Aug 2025 20:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755547316;
	bh=VVh51L5fvQ51fN5bf93/WlxFHYADBNfSsCFhM468P28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZILG/raX4WMy/fkzOoImMAjZO9/frRgBV4W5SnI7ik//VMO+n71YSVvn/aQbag5e
	 rBwxJtPGf6zdCKdabif2eeCclq+oDaHyXD8vqy7RZjuIQiztpwnkZ+wk2UU3lougL+
	 I1arW5Uw519QVhvBDTlvUqpQg/EToJ5IvADyb57L4+CgTm2qLjDpePiK91SNI6tIdC
	 p1sNE+Wsza2xcbwcYLQWHHiKI0WHmgTIDKdorH5jV/jD4sB5kX5LSF18kUkld8HZt9
	 g2V6WmPv1iZ9HXzzkL+bco/+MJksf3T49RBlBrQoGyS9la70yZfhPYc/HT0I0J4/Uk
	 N/7sI5fH7m86Q==
Date: Mon, 18 Aug 2025 13:01:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250818200155.GA7942@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>

On Mon, Aug 18, 2025 at 05:11:07PM +0200, Miklos Szeredi wrote:
> On Fri, 18 Jul 2025 at 01:27, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Actually copy the attributes/attributes_mask from userspace.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/dir.c |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 45b4c3cc1396af..4d841869ba3d0a 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1285,6 +1285,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
> >                 stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
> >                 stat->btime.tv_sec = sx->btime.tv_sec;
> >                 stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
> > +               stat->attributes = sx->attributes;
> > +               stat->attributes_mask = sx->attributes_mask;
> 
> fuse_update_get_attr() has a cached and an uncached branch and these
> fields are only getting set in the uncached case.

Hrmm, do you want to cache all the various statx attributes in struct
fuse_inode?  Or would you rather that the kernel always call the fuse
server if any of the statx flags outside of (BASIC_STATS|BTIME) are set?

Right now the full version of kstat_from_fuse_statx contains:

	if (sx->mask & STATX_BTIME) {
		stat->btime.tv_sec = sx->btime.tv_sec;
		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
	}

	if (sx->mask & STATX_DIOALIGN) {
		stat->dio_mem_align = sx->dio_mem_align;
		stat->dio_offset_align = sx->dio_offset_align;
	}

	if (sx->mask & STATX_SUBVOL)
		stat->subvol = sx->subvol;

	if (sx->mask & STATX_WRITE_ATOMIC) {
		stat->atomic_write_unit_min = sx->atomic_write_unit_min;
		stat->atomic_write_unit_max = sx->atomic_write_unit_max;
		stat->atomic_write_unit_max_opt = sx->atomic_write_unit_max_opt;
		stat->atomic_write_segments_max = sx->atomic_write_segments_max;
	}

	if (sx->mask & STATX_DIO_READ_ALIGN)
		stat->dio_read_offset_align = sx->dio_read_offset_align;

In theory only specialty programs are going to be interested in directio
or atomic writes, and only userspace nfs servers and backup programs are
going to care about subvolumes, so I don't know if it's really worth the
trouble to cache all that.

The dio/atomic fields are 7x u32, and the subvol id is u64.  That's 40
bytes per inode, which is kind of a lot.

--D

> Thanks,
> Miklos
> 

