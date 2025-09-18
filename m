Return-Path: <linux-fsdevel+bounces-62161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A00B865E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 20:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B7A18819B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDEF291C07;
	Thu, 18 Sep 2025 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OudovQV7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665428489D;
	Thu, 18 Sep 2025 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218688; cv=none; b=pfLwgIyCRBwUBBdICkbG0CGdPla+FjCwCGDsDr4ofOQ5PN0LPbxrkV/auMoiLmp6GomUroPwcod1rnwY6Vg22zAQztogtADdj0Sk7c6XD+sjnjPq6NAUiWSObfDUyF+swn6QH8HY+2DDkyntogB/MNP0PailDqSDeUhGZyRRMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218688; c=relaxed/simple;
	bh=pCd7p0rja6dBtvPEMM2lsESFeZxI2dQZTlsrc0NmN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMhg3DKva4Yzdlse1XrcNrQCdrXEy423qEdZDVf/TkjP60ISI3x242hNXQX4hSkwYUMqAyYMZwxJZV2c0/4gh9E+jKA807II0KjQ+uSwKWM56m6jF+wEZKuhleA4XWx0mnn5Zxx5T6HhFHg/OY7+tOvXYaI+lvI9NnRuKIZ8lrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OudovQV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BF5C4CEE7;
	Thu, 18 Sep 2025 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758218688;
	bh=pCd7p0rja6dBtvPEMM2lsESFeZxI2dQZTlsrc0NmN+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OudovQV7OrozeHdP2b8zsG+qfbt2KcfdBM/Fa6NHmeqe2Uul6aJz/W2glrB0P6KUD
	 lz8bVRd0zrAsydUuLkvJBQF0ARwSipWL5Ox9FmytXJhjJjDIjAg0WM1qYERIG7lRyG
	 FmQnpmRgZERfwSPb20iR8gWD+E4O9Wxrpasj/nUfkStOSN2Ll+skgbyUKib3o3CEca
	 UMnEr+ijw57wj+87bk2k0+mfs70jVEE/xCB/EDVFSvgY+IcZ+KQGyYM9VXleb5wz+0
	 nNkLtEhe3Be+HG+WPG4V+B/oSwQx1Ah35/2FMOOwgFoeHPrOVidUaOZ8Nt59x9w2E/
	 eY4CK22bN0S1A==
Date: Thu, 18 Sep 2025 11:04:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, mszeredi@redhat.com, bernd@bsbernd.com,
	linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev
Subject: Re: [PATCH 1/5] fuse: allow synchronous FUSE_INIT
Message-ID: <20250918180447.GQ1587915@frogsfrogsfrogs>
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
 <175798150731.382479.12549018102254808407.stgit@frogsfrogsfrogs>
 <CAJnrk1ZhMnkEWqp4yhuAk6vC4xw1VcAXfYBsvLXNu7G1isWZpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZhMnkEWqp4yhuAk6vC4xw1VcAXfYBsvLXNu7G1isWZpg@mail.gmail.com>

On Wed, Sep 17, 2025 at 10:22:21AM -0700, Joanne Koong wrote:
> On Mon, Sep 15, 2025 at 5:26 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Miklos Szeredi <mszeredi@redhat.com>
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
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_dev_i.h      |   13 +++++++-
> >  fs/fuse/fuse_i.h          |    5 ++-
> >  include/uapi/linux/fuse.h |    1 +
> >  fs/fuse/cuse.c            |    3 +-
> >  fs/fuse/dev.c             |   74 +++++++++++++++++++++++++++++++++------------
> >  fs/fuse/dev_uring.c       |    4 +-
> >  fs/fuse/inode.c           |   50 ++++++++++++++++++++++++------
> >  7 files changed, 115 insertions(+), 35 deletions(-)
> 
> btw, I think an updated version of this has already been merged into
> the fuse for-next tree (commit dfb84c330794)

Thanks for letting me know!

(I don't develop against for-next. ;))

--D

> Thanks,
> Joanne
> 

