Return-Path: <linux-fsdevel+bounces-32579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77539A9D6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 10:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C1928318F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0582418859B;
	Tue, 22 Oct 2024 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBHu2Ks3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE514B088
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587003; cv=none; b=TBtgWMZUPNsB5X90q3BZy6+hcn/RlnHVBgLzHBTGGOuPyu7nQz/Kbyi9q4+1ye4a9ENXVuC4zOtrFKvQbbSIjnEpy/C1rzboeiIPPuY+/TeVTIxURvRwOfA86MJ4PVPZy6xVh+IRdTgDZpyjuM6YHMM0h66pB1AMmqRWPrBNFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587003; c=relaxed/simple;
	bh=oGNZu52oN5mghL3zYVVhCpV5AsD7p6V/nLOZF26B7Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGUWz0MvO3yRkQMLwpdFyIOMFnUAL+nXfqv5yXmF9TLIuX4SBv4ozxrgJSB6NeASM9AkEiuwpx3kUBavp5MerF7nPQ2oUsnwnfUZROSGPoWNCWGqvLRWY+VJxUwghUvYCL3phIDI0jr5UZ2Nsh6wKxGbokwIYgDWDTMmqkO9DlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBHu2Ks3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE8AC4CEC3;
	Tue, 22 Oct 2024 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729587002;
	bh=oGNZu52oN5mghL3zYVVhCpV5AsD7p6V/nLOZF26B7Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBHu2Ks3AkBTr5Xgu1qksOwpafES6w888tI/t/OkTGOF8CeUIC8Zh5L+4w1GErb6I
	 vcaUenpxF2jx2QDbn7piMcnGtiYHEa7kamDWz5OFo2iax2L0bkiQIL2S53gU5/z3u+
	 mgIl6EEAtiGGLmJWQjmNxAq5iQF4JsApDWKKhM70W2p9hUyo6qsnkLO1WE/XMdygd6
	 sABhAp0IhEhuOwKw0nMCNyN6E/QLKGPMTPSKNuT0wJu3b0seQQRb/k4T+2NetVFJtQ
	 GgpMmhtRWA2wk0xtE6ML6h/36TW3YHNbdfnK/Zmpqt0khhxiRzm+Nrsodyi6Rrjrgv
	 2E0Hj7ObITZRw==
Date: Tue, 22 Oct 2024 10:49:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241022-besten-beginnen-a2c5ffa6e7d7@brauner>
References: <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
 <20241019050322.GD1172273@ZenIV>
 <20241021-stornieren-knarren-df4ad3f4d7f5@brauner>
 <20241021170910.GB1350452@ZenIV>
 <20241021224313.GC1350452@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021224313.GC1350452@ZenIV>

On Mon, Oct 21, 2024 at 11:43:13PM +0100, Al Viro wrote:
> On Mon, Oct 21, 2024 at 06:09:10PM +0100, Al Viro wrote:
> > On Mon, Oct 21, 2024 at 02:39:58PM +0200, Christian Brauner wrote:
> > 
> > > > See #getname.fixup; on top of #base.getname and IMO worth folding into it.
> > > 
> > > Yes, please fold so I can rebase my series on top of it.
> > 
> > OK...  What I have is #base.getname-fixed, with two commits - trivial
> > "teach filename_lookup() to accept NULL" and introducing getname_maybe_null(),
> > with fix folded in.
> > 
> > #work.xattr2 and #work.statx2 are on top of that.
> 
> BTW, speaking of statx() - I would rather lift the call of cp_statx() out
> of do_statx() and do_statx_fd() into the callers.  Yes, that needs making
> it non-static, due to io_uring; not a problem, IMO - it fits into the
> "how do we copy internal objects to userland ones" family of helpers.
> 
> Another fun issue: for by-pathname case vfs_fstatat() ends up hitting
> the same vfs_statx_path() as statx(2); however, for by-descriptor case
> they do vfs_getattr() and vfs_statx_path() resp.
> 
> The difference is, vfs_statx_path() has
>         if (request_mask & STATX_MNT_ID_UNIQUE) {
>                 stat->mnt_id = real_mount(path->mnt)->mnt_id_unique;
>                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
>         } else {
>                 stat->mnt_id = real_mount(path->mnt)->mnt_id;
>                 stat->result_mask |= STATX_MNT_ID;
>         }
> 
>         if (path_mounted(path))
>                 stat->attributes |= STATX_ATTR_MOUNT_ROOT;
>         stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
> 
>         /*
>          * If this is a block device inode, override the filesystem
>          * attributes with the block device specific parameters that need to be
>          * obtained from the bdev backing inode.
>          */
>         if (S_ISBLK(stat->mode))
>                 bdev_statx(path, stat, request_mask);
> done after vfs_getattr().  Questions:
> 
> 1) why is STATX_MNT_ID set without checking if it's in the mask passed to
> the damn thing?

If you look at the history you'll find that STATX_MNT_ID has always been
set unconditionally, i.e., userspace didn't have to request it
explicitly. And that's fine. It's not like it's expensive.

> 
> 2) why, in the name of everything unholy, does statx() on /dev/weird_shite
> trigger modprobe on that thing?  Without even a permission check on it...

Block people should know. But afaict, that's a block device thing which
happens with CONFIG_BLOCK_LEGACY_AUTOLOAD enabled which is supposedly
deprecated.

