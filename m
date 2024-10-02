Return-Path: <linux-fsdevel+bounces-30659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3298CCF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 08:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F6F285391
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 06:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E783CD4;
	Wed,  2 Oct 2024 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4wFLKM5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7781F5FA;
	Wed,  2 Oct 2024 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849562; cv=none; b=BjKv3eqGt/+HFfI1Qw640bReZjB8RXhno4vZvhGXSxT1DfDZUFQO6xRPEbM564u/ZDTP2xrN6cbghNOzsT6Rp0J8B9NTvbmbRcvy7IwScP68bWoWA37vd2d2bGeRuU9abtRrTiHlCq8aalwFDMEniL3ARWayvAABSzaLpfLGe4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849562; c=relaxed/simple;
	bh=pGKERVyPR74+Q8MZwsGdFZFru+2EDbBPqiU5/ueq4FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RctMS9wGd7n9iuRzh1PDpTnncpK2GnV6rKtvwXgEwvnK/FVyLB1EBS9ZVjW23XkLU036rumetxRmhVUWa+HDQtfchnUz6T+y/cmtLJEjVOBSxNYTH90I/0spgNWvXcWzUOkchGOuL+88Y3eNUvK8g+czi52fowxFYppSiWQJ3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4wFLKM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DB1C4CEC5;
	Wed,  2 Oct 2024 06:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727849562;
	bh=pGKERVyPR74+Q8MZwsGdFZFru+2EDbBPqiU5/ueq4FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4wFLKM5x+3uXcwOP8u4qQntDvT0o5hbpqSjDaNJGMM7YG4Jb8R15LmJnu7T5r/Fq
	 3fmfwnRftim2k0fQj7mEE53xOXfcCq+sEx+Vp/5UPzykw2nMeAZfl+k5nJMFYd5oMQ
	 L4UWeadaxlQyupuRsZTMldDpoNU0i2Zq+A+FDcyeqhLTgsZVgeLoW2j/824ystckzn
	 826Ax7Y/pS080CnzRx42bZCi9bbgZN0iTGkI6LIbij55+8vyZQi0BEvLW3hpJo9fJi
	 iyJ7CQa/2X4o06K5OLFmrLO+kY1nUac/I1pcqmVs73TSzlaqsjNYMnLqub/JTAtFPI
	 jk5sPPTZcl/ww==
Date: Wed, 2 Oct 2024 08:12:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, 
	LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
Message-ID: <20241002-burgfrieden-nahen-079f64e243ad@brauner>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
 <20240930141819.tabcwa3nk5v2mkwu@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930141819.tabcwa3nk5v2mkwu@quack3>

On Mon, Sep 30, 2024 at 04:18:19PM GMT, Jan Kara wrote:
> Hi!
> 
> On Tue 24-09-24 11:21:59, Geert Uytterhoeven wrote:
> > On Fri, Aug 30, 2024 at 5:29 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > It actually has been around for years: For containers and other sandbox
> > > use cases, there will be thousands (and even more) of authenticated
> > > (sub)images running on the same host, unlike OS images.
> > >
> > > Of course, all scenarios can use the same EROFS on-disk format, but
> > > bdev-backed mounts just work well for OS images since golden data is
> > > dumped into real block devices.  However, it's somewhat hard for
> > > container runtimes to manage and isolate so many unnecessary virtual
> > > block devices safely and efficiently [1]: they just look like a burden
> > > to orchestrators and file-backed mounts are preferred indeed.  There
> > > were already enough attempts such as Incremental FS, the original
> > > ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> > > for current EROFS users, ComposeFS, containerd and Android APEXs will
> > > be directly benefited from it.
> > >
> > > On the other hand, previous experimental feature "erofs over fscache"
> > > was once also intended to provide a similar solution (inspired by
> > > Incremental FS discussion [2]), but the following facts show file-backed
> > > mounts will be a better approach:
> > >  - Fscache infrastructure has recently been moved into new Netfslib
> > >    which is an unexpected dependency to EROFS really, although it
> > >    originally claims "it could be used for caching other things such as
> > >    ISO9660 filesystems too." [3]
> > >
> > >  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
> > >    enhancements.  For example, the failover feature took more than
> > >    one year, and the deamonless feature is still far behind now;
> > >
> > >  - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
> > >    perfectly supersede "erofs over fscache" in a simpler way since
> > >    developers (mainly containerd folks) could leverage their existing
> > >    caching mechanism entirely in userspace instead of strictly following
> > >    the predefined in-kernel caching tree hierarchy.
> > >
> > > After "fanotify pre-content hooks" lands upstream to provide the same
> > > functionality, "erofs over fscache" will be removed then (as an EROFS
> > > internal improvement and EROFS will not have to bother with on-demand
> > > fetching and/or caching improvements anymore.)
> > >
> > > [1] https://github.com/containers/storage/pull/2039
> > > [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
> > > [3] https://docs.kernel.org/filesystems/caching/fscache.html
> > > [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
> > >
> > > Closes: https://github.com/containers/composefs/issues/144
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Thanks for your patch, which is now commit fb176750266a3d7f
> > ("erofs: add file-backed mount support").
> > 
> > > ---
> > > v2:
> > >  - should use kill_anon_super();
> > >  - add O_LARGEFILE to support large files.
> > >
> > >  fs/erofs/Kconfig    | 17 ++++++++++
> > >  fs/erofs/data.c     | 35 ++++++++++++---------
> > >  fs/erofs/inode.c    |  5 ++-
> > >  fs/erofs/internal.h | 11 +++++--
> > >  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
> > >  5 files changed, 100 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> > > index 7dcdce660cac..1428d0530e1c 100644
> > > --- a/fs/erofs/Kconfig
> > > +++ b/fs/erofs/Kconfig
> > > @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
> > >
> > >           If you are not using a security module, say N.
> > >
> > > +config EROFS_FS_BACKED_BY_FILE
> > > +       bool "File-backed EROFS filesystem support"
> > > +       depends on EROFS_FS
> > > +       default y
> > 
> > I am a bit reluctant to have this default to y, without an ack from
> > the VFS maintainers.
> 
> Well, we generally let filesystems do whatever they decide to do unless it
> is a affecting stability / security / maintainability of the whole system.
> In this case I don't see anything that would be substantially different
> than if we go through a loop device. So although the feature looks somewhat
> unusual I don't see a reason to nack it or otherwise interfere with
> whatever the fs maintainer wants to do. Are you concerned about a
> particular problem?

I see no reason to nak it either.

