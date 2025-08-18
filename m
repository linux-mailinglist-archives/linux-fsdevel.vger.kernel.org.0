Return-Path: <linux-fsdevel+bounces-58208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF26DB2B208
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 22:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851B73B3042
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA391FC0ED;
	Mon, 18 Aug 2025 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0LywgqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736328695
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547495; cv=none; b=KO9dpHZuAvbb0lLL/K+zY+nI78y8GXYdRjvp1BQisyiDafeU6O3RotzZtqI3GMN4K5qtiARYJgUUQlZZ5sZE1hZ2SCyqWaTULeMyfXbDJBpSZuvPuqv1IScBtYRK/+Gk63EMdPFeo2uySp49DmMnlNApEJ8tcgn9e4GqMPEmpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547495; c=relaxed/simple;
	bh=32iWD3Hsi3U1yRw7q7RGZipR50SHfeV0JfqbawMMsag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZUB3L/BSiv+kEQ8gJOC/+bNqOaGfjLAunB6As4HZbBPo5TDx+fxutbGVyOAGUYq6CdsoB/5qEGbjL75OWR/kZGi21kLyLTvKbNdWzyiaf8Sn15v7pzCQn/mgNHqWp8enk+NZZq18tsspwyHFo4JtoFObeD3q9lOk46PIdAdHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0LywgqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40298C4CEEB;
	Mon, 18 Aug 2025 20:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755547495;
	bh=32iWD3Hsi3U1yRw7q7RGZipR50SHfeV0JfqbawMMsag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0LywgqTs2qZ6nye5pO0pPNsclvBiZdiznzf/kzb0xs6KdQBugfXcoahoRJgiQJ3g
	 1HJmf6NowEHb3q3U+IqhJxMp24FCTTlALeIfuwTLLkz8ae/+qoh4nrk0E6KRBZyDgb
	 R8jiZhe53Qypu/Bk0jpXrn7QIg4apN+5ZV42LmVtN/JiwQEn6XjqmnsGd0YMA5IC8t
	 L87d9VvgLdWzPr2AnwmEOYXNwC7ywdMqDwklaCYw/g7lvgdl3Spg9JfR2bMqeF6wdi
	 6jkIx3/qBx07RdzwuZbUIzl/SvP6JcPEuqZ04XqDp+uMKuQU96zC1zcpPOKeuSJNjE
	 Y5bBbHLRCC0fw==
Date: Mon, 18 Aug 2025 13:04:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250818200454.GB7942@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
 <20250818200155.GA7942@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818200155.GA7942@frogsfrogsfrogs>

On Mon, Aug 18, 2025 at 01:01:55PM -0700, Darrick J. Wong wrote:
> On Mon, Aug 18, 2025 at 05:11:07PM +0200, Miklos Szeredi wrote:
> > On Fri, 18 Jul 2025 at 01:27, Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Actually copy the attributes/attributes_mask from userspace.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/dir.c |    2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > >
> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > index 45b4c3cc1396af..4d841869ba3d0a 100644
> > > --- a/fs/fuse/dir.c
> > > +++ b/fs/fuse/dir.c
> > > @@ -1285,6 +1285,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
> > >                 stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
> > >                 stat->btime.tv_sec = sx->btime.tv_sec;
> > >                 stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
> > > +               stat->attributes = sx->attributes;
> > > +               stat->attributes_mask = sx->attributes_mask;
> > 
> > fuse_update_get_attr() has a cached and an uncached branch and these
> > fields are only getting set in the uncached case.
> 
> Hrmm, do you want to cache all the various statx attributes in struct
> fuse_inode?  Or would you rather that the kernel always call the fuse
> server if any of the statx flags outside of (BASIC_STATS|BTIME) are set?

I should have said explicitly that attributes/attributes_mask need to be
cached because there's no separate STATX_ request flag for the bitfield.

However, the *new* fields that have been added since BASIC_STATS are the
subject of my ramblings below.

--D

> Right now the full version of kstat_from_fuse_statx contains:
> 
> 	if (sx->mask & STATX_BTIME) {
> 		stat->btime.tv_sec = sx->btime.tv_sec;
> 		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
> 	}
> 
> 	if (sx->mask & STATX_DIOALIGN) {
> 		stat->dio_mem_align = sx->dio_mem_align;
> 		stat->dio_offset_align = sx->dio_offset_align;
> 	}
> 
> 	if (sx->mask & STATX_SUBVOL)
> 		stat->subvol = sx->subvol;
> 
> 	if (sx->mask & STATX_WRITE_ATOMIC) {
> 		stat->atomic_write_unit_min = sx->atomic_write_unit_min;
> 		stat->atomic_write_unit_max = sx->atomic_write_unit_max;
> 		stat->atomic_write_unit_max_opt = sx->atomic_write_unit_max_opt;
> 		stat->atomic_write_segments_max = sx->atomic_write_segments_max;
> 	}
> 
> 	if (sx->mask & STATX_DIO_READ_ALIGN)
> 		stat->dio_read_offset_align = sx->dio_read_offset_align;
> 
> In theory only specialty programs are going to be interested in directio
> or atomic writes, and only userspace nfs servers and backup programs are
> going to care about subvolumes, so I don't know if it's really worth the
> trouble to cache all that.
> 
> The dio/atomic fields are 7x u32, and the subvol id is u64.  That's 40
> bytes per inode, which is kind of a lot.
> 
> --D
> 
> > Thanks,
> > Miklos
> > 
> 

