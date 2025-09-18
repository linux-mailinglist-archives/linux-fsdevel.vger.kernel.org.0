Return-Path: <linux-fsdevel+bounces-62156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04DB8620A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 18:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD007E26BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932125C6FF;
	Thu, 18 Sep 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQmjGM5Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B80248F57;
	Thu, 18 Sep 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214349; cv=none; b=hB3Q+8rjJpFDmH+9yWQufUBCKlXMHYHno5kiaMh5gFfTerOuORX15InfKF5/3DmrRjHtKghqG4icAq1wwWnTM8FPtwmiF7GS0Vlo3EjktYjuvLbybcFjUTYhfF11opfKfDeTNa4H21RQ7oJmZzVooLQHOVXJrMOmAV6MK8o8vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214349; c=relaxed/simple;
	bh=9fORnitY7ZI2TjH9uFpqE0qNhXm/u+HoTqtDe5oKrio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYpz7tZ/w8cZa5dtdhUNB+HfBXy9LVpGfjtRueaxndRUemwik8YhtcS+SIBwwgXwB03vNmQ8pyFsGzT0ImAgHNqRRiJBIQIjMQ/6VYEaPhWajIXv+KpMBZOacmZGrE94idI7X5xnyPHKZoL5z8Z9gyYCRaFsmssejpKIW/4H2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQmjGM5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3066C4CEE7;
	Thu, 18 Sep 2025 16:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758214347;
	bh=9fORnitY7ZI2TjH9uFpqE0qNhXm/u+HoTqtDe5oKrio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQmjGM5Yx8vLRkzLo8vqYPMoUDt93nt/XjJHRjo8sRMQq0F2iu6Kaz0HaJ4OqkFZy
	 jMxt5tcgxsJI5pq88E5F4PPAQm13gNPJEgDyFEOiWxQOhkbHoH4y+iTidPKCDHFk3M
	 wnDiL08av25tAKRfJ5nDemTd/sDltwwYMFusxrkKR3Wf5ca0gSdwZ/3dWv7+2hWk+h
	 hGlcUuvfQcTnSKWgzUXx/3SkE+xNKrsfnQN1BBvu1MVN/CPhYapYIuxneaz4xEDVPr
	 QLQfZdk0uXMcvWQuJpVJCip4U36ylE3VYxzGGpNPyYn2WEU6p645sPrQpm44OooPZB
	 nf+8Eul0dcquQ==
Date: Thu, 18 Sep 2025 09:52:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev
Subject: Re: [PATCH 4/8] fuse: signal that a fuse filesystem should exhibit
 local fs behaviors
Message-ID: <20250918165227.GX8117@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150113.381990.4002893785000461185.stgit@frogsfrogsfrogs>
 <CAJnrk1YWtEJ2O90Z0+YH346c3FigVJz4e=H6qwRYv7xLdVg1PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YWtEJ2O90Z0+YH346c3FigVJz4e=H6qwRYv7xLdVg1PA@mail.gmail.com>

On Wed, Sep 17, 2025 at 10:18:40AM -0700, Joanne Koong wrote:
> On Mon, Sep 15, 2025 at 5:25 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Create a new fuse context flag that indicates that the kernel should
> > implement various local filesystem behaviors instead of passing vfs
> > commands straight through to the fuse server and expecting the server to
> > do all the work.  For example, this means that we'll use the kernel to
> > transform some ACL updates into mode changes, and later to do
> > enforcement of the immutable and append iflags.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h |    4 ++++
> >  fs/fuse/inode.c  |    2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index e93a3c3f11d901..e13e8270f4f58d 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -603,6 +603,7 @@ struct fuse_fs_context {
> >         bool no_control:1;
> >         bool no_force_umount:1;
> >         bool legacy_opts_show:1;
> > +       bool local_fs:1;
> >         enum fuse_dax_mode dax_mode;
> >         unsigned int max_read;
> >         unsigned int blksize;
> > @@ -901,6 +902,9 @@ struct fuse_conn {
> >         /* Is link not implemented by fs? */
> >         unsigned int no_link:1;
> >
> > +       /* Should this filesystem behave like a local filesystem? */
> > +       unsigned int local_fs:1;
> > +
> >         /* Use io_uring for communication */
> >         unsigned int io_uring;
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index c94aba627a6f11..c8dd0bcb7e6f9f 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1862,6 +1862,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
> >         fc->destroy = ctx->destroy;
> >         fc->no_control = ctx->no_control;
> >         fc->no_force_umount = ctx->no_force_umount;
> > +       fc->local_fs = ctx->local_fs;
> >
> 
> If I'm understanding it correctly, fc->local_fs is set to true if it's
> a fuseblk device? Why do we need a new "ctx->local_fs" instead of
> reusing ctx->is_bdev?

Eventually, enabling iomap will also set local_fs=1, as Miklos and I
sort of touched on a couple weeks ago:

https://lore.kernel.org/linux-fsdevel/CAJfpegvmXnZc=nC4UGw5Gya2cAr-kR0s=WNecnMhdTM_mGyuUg@mail.gmail.com/

--D

> Thanks,
> Joanne
> 
> >         err = -ENOMEM;
> >         root = fuse_get_root_inode(sb, ctx->rootmode);
> > @@ -2029,6 +2030,7 @@ static int fuse_init_fs_context(struct fs_context *fsc)
> >         if (fsc->fs_type == &fuseblk_fs_type) {
> >                 ctx->is_bdev = true;
> >                 ctx->destroy = true;
> > +               ctx->local_fs = true;
> >         }
> >  #endif
> >
> >

