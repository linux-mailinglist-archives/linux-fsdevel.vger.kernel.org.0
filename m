Return-Path: <linux-fsdevel+bounces-66856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B3C2DE67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 20:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC4F3B357E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A1631CA5A;
	Mon,  3 Nov 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCgIe0wW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C48128507E;
	Mon,  3 Nov 2025 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198082; cv=none; b=Gt10cva9JyuS9pZky899Unq4xhOu+5/4S/h1shs1dkHgg90cKuD0itt7fkY7Bhp9FqrDfAcdu2B+jvflFOM57E07C1Tfv+kY0AHFXXr91NxqPiiNPeBaK3NbKhS4HrAEyDxhlxyLnEsmSFVBaDZub+d8hsewRdBbJtcZby7QIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198082; c=relaxed/simple;
	bh=5KMnpLPtvjbvFVBho8EJRznqNn21Vj1NX/IuhlDW2i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYcTrCPfhNR9k+3JXzas+6FJYfIqYqDOghZf0FH3TcMScFmCQD4q2KkR8kYoHKfiaOw44cdRtysdaOg8RxsXpFMwb0blVnxvSHVyf0a2vCW+Ypv/7XSLFmUB9EsYpHCVkM8dHKTUQplMfq+gShEWzb3wVXMsffN8+TAD/txE6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCgIe0wW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B26C4CEE7;
	Mon,  3 Nov 2025 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762198081;
	bh=5KMnpLPtvjbvFVBho8EJRznqNn21Vj1NX/IuhlDW2i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCgIe0wWVRcvrVNcrhjgqDkGCJPDiOPQyRc56pG2T1kgXIipp0vEYdEWmhRW524Pl
	 LYmLlbz53DFm3P4Fj2UUNQeXVhApVbz9hfByPm1vNo3HnZmGMVUaAK0UAfouBJQvaO
	 XgrwJTdw2XRnLl9YNhb9BYUfoM6eYA2STYAiA2rZV7I9SsJ0gYRr6Gc+bHJTs2RTi9
	 maDZOXMRH2Y8wbezzEfB2lFkZMd2VJhP72aTYUq0PmI2R7OZjAmVxkomx0A81F+zP2
	 /B1BQpKnEfD0XMnCFYBn+STvk7FiJI8rJLNm8K2mnx40QajcgmpAFhANHaP6cGn/cO
	 LXzx2CZef5TBw==
Date: Mon, 3 Nov 2025 11:28:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] fuse: implement file attributes mask for statx
Message-ID: <20251103192801.GA196391@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809317.1424347.1031452366030061035.stgit@frogsfrogsfrogs>
 <CAJnrk1ZgQy7osiYfb6_Ra=a4-G4nxiiFJZgNLLZYnGtL=a7QBg@mail.gmail.com>
 <CAJnrk1b+0B5h4A4=5zRJ04Kdw-OxbGW_m9s+5U=HZpw+q1umqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1b+0B5h4A4=5zRJ04Kdw-OxbGW_m9s+5U=HZpw+q1umqg@mail.gmail.com>

On Mon, Nov 03, 2025 at 10:43:10AM -0800, Joanne Koong wrote:
> On Mon, Nov 3, 2025 at 10:30 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index a8068bee90af57..8c47d103c8ffa6 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -140,6 +140,10 @@ struct fuse_inode {
> > >         /** Version of last attribute change */
> > >         u64 attr_version;
> > >
> > > +       /** statx file attributes */
> > > +       u64 statx_attributes;
> > > +       u64 statx_attributes_mask;
> > > +
> > >         union {
> > >                 /* read/write io cache (regular file only) */
> > >                 struct {
> > > @@ -1235,6 +1239,39 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
> > >                                    u64 attr_valid, u32 cache_mask,
> > >                                    u64 evict_ctr);
> > >
> > > +/*
> > > + * These statx attribute flags are set by the VFS so mask them out of replies
> > > + * from the fuse server for local filesystems.  Nonlocal filesystems are
> > > + * responsible for enforcing and advertising these flags themselves.
> > > + */
> > > +#define FUSE_STATX_LOCAL_VFS_ATTRIBUTES (STATX_ATTR_IMMUTABLE | \
> > > +                                        STATX_ATTR_APPEND)
> >
> > for STATX_ATTR_IMMUTABLE and STATX_ATTR_APPEND, I see in
> > generic_fill_statx_attr() that they get set if the inode has the
> > S_IMMUTABLE flag and the S_APPEND flag set, but I'm not seeing how
> > this is relevant to fuse. I'm not seeing anywhere in the vfs layer
> > that sets S_APPEND or STATX_ATTR_IMMUTABLE, I only see specific
> > filesystems setting them, which fuse doesn't do. Is there something
> > I'm missing?
> 
> Ok, I see. In patchset 6/8 patch 3/9 [1],
> FUSE_ATTR_SYNC/FUSE_ATTR_IMMUTABLE/FUSE_ATTR_APPEND flags get added
> which signify that S_SYNC/S_IMMUTABLE/S_APPEND should get set on the

<nod>  Originally I was going to hide /all/ of this behind the
per-fuse_inode iomap flag, but the Miklos and I started talking about
having a separate "behaves like local fs" flag for a few things so that
non-iomap fuseblk servers could take advantage of them too.  Right now
it's limited to these vfs inode flags and the posix acl transformation
functions since the assumption is that a regular fuse server either does
the transformations on its own or forwards the request to a remote node
which (presumably if it cares) does the transformation on its own.

> inode.  Hmm I'm confused why we would want to mask them out for local
> filesystems. If FUSE_ATTR_SYNC/FUSE_ATTR_IMMUTABLE/FUSE_ATTR_APPEND
> are getting passed in by the fuse server and getting enforced, why
> don't we want them to show up in stax?

We do, but the VFS sets those statx flags for us:
https://elixir.bootlin.com/linux/v6.17.7/source/fs/stat.c#L124

--D

> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/176169811656.1426244.11474449087922753694.stgit@frogsfrogsfrogs/
> >
> > Thanks,
> > Joanne

