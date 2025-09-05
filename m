Return-Path: <linux-fsdevel+bounces-60366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45273B45C68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F923B3962
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64D2F7AD7;
	Fri,  5 Sep 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfXisM1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E323BF96;
	Fri,  5 Sep 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085679; cv=none; b=XiOhkDFtAt4ReCSlSfJu5ekqH6t2wL4zL8LXvJk1oXT27ml7ZNEThxWSWvMUPzbuzdBd4vLyPgn/Ig6ddrSnVpnUgrpAjExXrP5sHQS9pDcAFVVmuU3VPGWw2sEW4GCFWtaA8Sf17mutyhdtX8eZ3hvUaaREW9Hzmg0yraRLgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085679; c=relaxed/simple;
	bh=Mk9Lv36ZcC/2I3dmxfTwbbljmUfZJLGQEyonJ6cYg30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKY6kZ9iaJ++J7TxdEfpQ4sTTD5PpKN0DcEIW4YILzJSiEEYo4OPB4DJJ0Gmi6DHoRXlh8eoIZ1CvYcdC0qHe4XuiY7nwKQrp74VYkpS8Ltoj8pC7d8yuhEy7PZXWdfbUKog2IwB5Rbwq9u186gssHIebOTeDW77p2A8JTGRbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfXisM1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38116C4CEF1;
	Fri,  5 Sep 2025 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757085679;
	bh=Mk9Lv36ZcC/2I3dmxfTwbbljmUfZJLGQEyonJ6cYg30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfXisM1tX4nLrdzXxpXdR+g4pAROnPe6mAYGtSMkEpJKnlqQiVUNWZJ0PyavUPZ1a
	 X/gc08cp2BvHaVEbd/utpk9OU1xiqX8oWDw7sJARiIiEBUrvQjZKWCHDEgRRF786HB
	 PLew8ecnSfUtin+Hi5zFdlmsvH8U51gksH9rIOpYOEFYXYvdwo0bC2oBFK4u9Ev/bt
	 tQ59xyPblt6dNom7YqwE7+1PmswGNdzdpdhWpQ7JrnLX/O7S2ib6pGu4fO5pjYwp5q
	 9pMQ870pJOCBUtgxmYjBLMPb+2FCHx2OlFGGk8koCcRpEOPTM/cnMq2ZCDu+qZjvvl
	 /1x485jJTQWqQ==
Date: Fri, 5 Sep 2025 08:21:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	miklos@szeredi.hu, hch@infradead.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 13/16] iomap: add a private arg for read and readahead
Message-ID: <20250905152118.GE1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-14-joannelkoong@gmail.com>
 <aLJZv5L6q0FH5F8a@debian>
 <CAJnrk1af4-FG==X=4LzoBRaxL9N-hnh1i-zx89immQZMLKSzyQ@mail.gmail.com>
 <a44fd64d-e0b1-4131-9d71-2d36151c90f4@linux.alibaba.com>
 <CAJnrk1bBmA+VK6UK1n6DRnuLvX8UOMp-VgQGnn2rUrq0=mCyqA@mail.gmail.com>
 <d631c71f-9d0d-405f-862d-b881767b1945@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d631c71f-9d0d-405f-862d-b881767b1945@linux.alibaba.com>

On Fri, Sep 05, 2025 at 10:21:19AM +0800, Gao Xiang wrote:
> 
> 
> On 2025/9/5 07:29, Joanne Koong wrote:
> > On Tue, Sep 2, 2025 at 6:55 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > 
> 
> ...
> 
> 
> > > > > 
> > > > > >    int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> > > > > > -             const struct iomap_read_ops *read_ops)
> > > > > > +             const struct iomap_read_ops *read_ops, void *private)
> > > > > >    {
> > > > > >         struct iomap_iter iter = {
> > > > > >                 .inode          = folio->mapping->host,
> > > > > >                 .pos            = folio_pos(folio),
> > > > > >                 .len            = folio_size(folio),
> > > > > > +             .private        = private,
> > > > > >         };
> > > > > 
> > > > > Will this whole work be landed for v6.18?
> > > > > 
> > > > > If not, may I ask if this patch can be shifted advance in this
> > > > > patchset for applying separately (I tried but no luck).
> > > > > 
> > > > > Because I also need some similar approach for EROFS iomap page
> > > > > cache sharing feature since EROFS uncompressed I/Os go through
> > > > > iomap and extra information needs a proper way to pass down to
> > > > > iomap_{begin,end} with extra pointer `.private` too.
> > > > 
> > > > Hi Gao,
> > > > 
> > > > I'm not sure whether this will be landed for v6.18 but I'm happy to
> > > > shift this patch to the beginning of the patchset for applying
> > > > separately.
> > > 
> > > Yeah, thanks.  At least this common patch can be potentially applied
> > > easily (e.g. form a common commit id for both features if really
> > > needed) since other iomap/FUSE patches are not dependency of our new
> > > feature and shouldn't be coupled with our development branch later.
> > > 
> > 
> > Hi Gao,
> > 
> > I'll be dropping this patch in v2 since all the iomap read stuff is
> > going to go through a struct ctx arg instead of through iter->private.
> > Sorry this won't help your use case, but looking forward to seeing your patches.
> 
> Hi Joanne,
> 
> Thanks for your reminder.  Okay, I will check your v2 to know how
> you change then.
> 
> Also, one thing I really think it's helpful for our use cases is
> converting .iomap_begin() at least to pass struct iomap_iter *
> directly rather than (inode, pos, len, flags, iomap, srcmap)
> since:
>   - .iomap_{begin,end}() are introduced before iomap_iter()
>     and struct iomap_iter but those callbacks are basically
>     now passed down some fields of `struct iomap_iter` now;
> 
>   - struct iomap_iter->private then can contain a per-request
>     context so that .iomap_begin() can leverage too;
> 
>   - There are already too many arguments for .iomap_begin(),
>     pass down struct iomap_iter directly could avoid adding
>     another `private` argument to .iomap_begin()..
> 
> Therefore, I do wonder if this change (.iomap_begin() passes
> struct iomap_iter *) is a good idea for the iomap folks, in
> addition that filesystems can specify `struct iomap_iter->private`
> as in this patch.  Since this change is necessary to make our
> page cache sharing feature efficient, I will continue working on
> this soon.

From a source code perspective, I like the idea of cleaning up the
function signature to pass fewer things to ->iomap_begin.  I suspect
that we could simplify it to:

	int (*iomap_begin)(const struct iomap_iter *iter,
			   struct iomap *iomap,
			   struct iomap *srcmap);

That way we preserve the notion that the ->iomap_begin functions aren't
allowed to change the iterator contents except for the two iomaps.

That said, the nice thing about passing so many parameters is that it
probably leads to less pointer chasing in the implementation functions.
I wonder if that makes any difference because extent mapping lookups
likely involve a lot more pointer chasing anyway.  Another benefit is
that since the parameters aren't const, each implementation can (re)use
those variables if they need to.

I think you could simplify iomap_end too:

	int (*iomap_end)(const struct iomap_iter *iter,
			 loff_t pos, u64 length,
			 size_t written);

and make ->iomap_end implementations extract iter->flags and iter->iomap
themselves if they want to.  I don't like how xfs_iomap.c abuses
container_of to extract the iter from the iomap pointer.

(But not enough to have written patches fixing any of this. :P)

> Another thing I want to discuss (but it's less important for our
> recent features) is the whole callback hook model of iomap.
> 
> Basically the current model does mean if any filesystem doesn't
> fulfill the iomap standard flow, it has to add some customized
> callback hook somewhere to modify the code flow then (or introduce
> a new special flag and move their specific logic into iomap/
> itself even other fses may not need this), but the hook way will
> cause increased indirect calls for them, currently we have
> `struct iomap_ops`, `struct iomap_writeback_ops` and
> `struct iomap_dio_ops`, if some another filesystem (when converting
> buffer I/Os for example or adding {pre,post}-processing ) have
> specified timing, it needs to add new hooks then.
> 
> I do wonder if it's possible to convert iomap to get rid of the
> indirect-call model by just providing helper kAPIs instead,
> take .read_folio / .fiemap for example e.g.
> 
>    xxxfs_read_folio:
>       loop iomap_iter
>         xxxfs_iomap_begin();
> 	iomap_readpage_bio_advance(); [ or if a fs is non-bio
>              based, spliting more low-level helpers for them. ]
>         xxxfs_iomap_end();
> 
>    xxxfs_fiemap():
>       iomap_fiemap_begin
>       loop iomap_iter
>         xxxfs_iomap_begin();
>         iomap_readpage_fiemap_advance()
>         xxxfs_iomap_end();
>       iomap_fiemap_end
> So that each fs can use those helpers flexibly instead of diging
> into adding various new indirect call hooks or moving customized
> logic into iomap/ itself.

Yes, it's quite possible to push the iomap iteration control down into
the filesystems to avoid the indirect calls.  That might make things
faster, though I have no idea what sort of performance impact that will
have.

> I don't have a specific example  because currently we don't have
> direct issue against standard iomap flow on our uncompressed
> path, but after a quick glance of other potential users who try
> to convert their buffer I/Os to iomap, I had such impression in
> my head for a while.

OTOH making it easier for non-disk filesystems to use iomap but supply
their own IO mechanism (transformed bios, memcpy, etc) makes a far more
compelling argument for doing this painful(?) treewide change IMO.

--D

> Thanks,
> Gao Xiang
> 
> > 
> > 
> > Thanks,
> > Joanne
> > 
> > > Thanks,
> > > Gao Xiang
> > > 
> > > > 
> > > > Thanks,
> > > > Joanne
> > > > > 
> > > > > Thanks,
> > > > > Gao Xiang
> > > 
> 
> 

