Return-Path: <linux-fsdevel+bounces-62253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE400B8AD32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 19:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C303A1CC631B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BAC322C9F;
	Fri, 19 Sep 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk5VqK6/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B754322A2F;
	Fri, 19 Sep 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304214; cv=none; b=Sdt8AlZ5WGnTvOf7szNwGTF87kZ+0V73qKScMl7PXC8WoctAdQKx0T9i6FtpYToZbeY4rfqifPUHyIW00+8z9hDLLSePTu6aUDnyl01LCRRIU7rI3/m9BQpALO4erNYJOU0koU+7yWZZshH+IMDuUb3sh3HCFJRG+bpy9jRvYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304214; c=relaxed/simple;
	bh=IEsx63hw+/ywO3aNtqUSlEzmD8l5SSYej+UujfBpxrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1PJtnVEDr+MJa2dAZnfDNUptZhC5rIgIMCcpqvzNPh3AeG/S/uO3n+mtr+fGWxrOUnbvesdua9lcWa2M2Fe5KZAJsuNzK3G69s3bBRjls9Blq1CX7dVuHK9WXnPbUdCb+vIGSYuTuHQk4P1rrUb60V/NQd9usb4gWGzt/uXK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk5VqK6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D152CC4CEF0;
	Fri, 19 Sep 2025 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758304213;
	bh=IEsx63hw+/ywO3aNtqUSlEzmD8l5SSYej+UujfBpxrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rk5VqK6/ueyvfU84ZycDjff4pHLOMbuBjtdh1Yhup5dLEvjBUabbX40anbaUjEZ2W
	 0EfXE42XE8zwjKjh4NLC/T9wmDEmbT7YyJ6zxtHFC6xXdQxYGhqM0Y7frdo6M6oyXL
	 6W0Fq2sPgjbVw1YDs2VLpNWT7VP1KUjCz6pMwrgJ5Fr6/xfBC6a7WQnpHkfxyUKUQX
	 vGN8MOPcP/ENDYICZPlFkqHoKHeKHFnB4H/nrLhpD8LpqkG9HZ7kocUtl8xJUnMTxX
	 L4nNhIgk6Fq7NQ+y7H7fXeT6eIqLmoDW45DBPXlz9H+v/J8p5jevg7J6CrZ8vUug8D
	 UKeAcsQ5wj4Iw==
Date: Fri, 19 Sep 2025 10:50:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com,
	linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev
Subject: Re: [PATCH 4/8] fuse: signal that a fuse filesystem should exhibit
 local fs behaviors
Message-ID: <20250919175011.GG8117@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150113.381990.4002893785000461185.stgit@frogsfrogsfrogs>
 <CAJnrk1YWtEJ2O90Z0+YH346c3FigVJz4e=H6qwRYv7xLdVg1PA@mail.gmail.com>
 <20250918165227.GX8117@frogsfrogsfrogs>
 <CAJfpegt6YzTSKBWSO8Va6bvf2-BA_9+Yo8g-X=fncZfZEbBZWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt6YzTSKBWSO8Va6bvf2-BA_9+Yo8g-X=fncZfZEbBZWw@mail.gmail.com>

On Fri, Sep 19, 2025 at 11:24:09AM +0200, Miklos Szeredi wrote:
> On Thu, 18 Sept 2025 at 18:52, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Sep 17, 2025 at 10:18:40AM -0700, Joanne Koong wrote:
> 
> > > If I'm understanding it correctly, fc->local_fs is set to true if it's
> > > a fuseblk device? Why do we need a new "ctx->local_fs" instead of
> > > reusing ctx->is_bdev?
> >
> > Eventually, enabling iomap will also set local_fs=1, as Miklos and I
> > sort of touched on a couple weeks ago:
> >
> > https://lore.kernel.org/linux-fsdevel/CAJfpegvmXnZc=nC4UGw5Gya2cAr-kR0s=WNecnMhdTM_mGyuUg@mail.gmail.com/
> 
> I think it might be worth making this property per-inode.   I.e. a
> distributed filesystem could allow one inode to be completely "owned"
> by one client.  This would be similar to NFSv4 delegations and could
> be refined to read-only (shared) and read-write (exclusive) ownership.
> A local filesystem would have all inodes excusively owned.
> 
> This's been long on my todo list and also have some prior experiments,
> so it's a good opportunity to start working on it again:)

Since I already have per-fs and per-inode iomap flags, I can add a
per-inode localfs flag pretty easily for v6.  ATM I see 2 existing flags
and 5 proposed (out of 32 possible):

/**
 * fuse_attr flags
 *
 * FUSE_ATTR_SUBMOUNT: Object is a submount root
 * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
 * FUSE_ATTR_IOMAP: Use iomap for this inode
 * FUSE_ATTR_ATOMIC: Enable untorn writes
 * FUSE_ATTR_SYNC: File writes are synchronous
 * FUSE_ATTR_IMMUTABLE: File is immutable
 * FUSE_ATTR_APPEND: File is append-only
 */

So we still have plenty of space.

Would you like to allow any server set the per-inode flag?  Or would you
rather keep the per-fs flag and require that it's set before setting the
per-inode flag?  That would be useful for privilege checking of the fuse
server.

--D

> Thanks,
> Miklos
> 
> 
> 
> 
> 
> 
> >
> > --D
> >
> > > Thanks,
> > > Joanne
> > >
> > > >         err = -ENOMEM;
> > > >         root = fuse_get_root_inode(sb, ctx->rootmode);
> > > > @@ -2029,6 +2030,7 @@ static int fuse_init_fs_context(struct fs_context *fsc)
> > > >         if (fsc->fs_type == &fuseblk_fs_type) {
> > > >                 ctx->is_bdev = true;
> > > >                 ctx->destroy = true;
> > > > +               ctx->local_fs = true;
> > > >         }
> > > >  #endif
> > > >
> > > >

