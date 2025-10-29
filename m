Return-Path: <linux-fsdevel+bounces-66381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3CC1D954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE26F18970EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E0331AF18;
	Wed, 29 Oct 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+mUQNyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3E20010A;
	Wed, 29 Oct 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776710; cv=none; b=JePHbgiMuXwHMg1zZijjnKJ8awrSCtpqUJObcMYgEyo1CjVhGrJPkb2Rl1jph7EjruxuTxr4FZBsZ82aLWdsUMhzbmnlxCZB/FDIxlnKnjUcu5smDCC4iFu8PNsDUSrrnmt65YQUvTaGzX8S6fayd6u5FlKA9+CaYTaUGbI1XyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776710; c=relaxed/simple;
	bh=sqvfi/doKW71ktQYpInEihkU2K+gkdzBjz9/lAlE59k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmJYa1XcHGf8o+z1XRrV7KTm/pOJEoz3R6ilzVaKOpa22zryTCK4NrGb0Y4CZYcuf4ZP6lCoDNXctRJnAs3f1FU0fbcoofdzTOCy5HQHiLGLxg/UxINN9qI9PPE8G24jk2COqKvh8wVtMt4COBryt2cG5b2wqtevFV/bvVz69Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+mUQNyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12DCC4CEF7;
	Wed, 29 Oct 2025 22:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761776708;
	bh=sqvfi/doKW71ktQYpInEihkU2K+gkdzBjz9/lAlE59k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+mUQNyUwZcCuR4LY2Eb5uQYQsXxzWjtLpGeDw3/tvYm+N/N2B7O2AU7ev9fLXQNK
	 bozrXEA9n2lRo3ylRAzvFDNtrOIiVlCrU0YfyHzHgHIj7EnS6EVCsE8L2e5a2Fk8j/
	 RDsBLu3lheyolvbPIZTlMVGq11tKGa+m5QShVWiud6G31E6r2OQJ+7gMuD/z6HVm1e
	 NIiyY89aOtpHfNE0ohhiOabkvWkdsQOEjbzBlxGkrrt5C5vSORUNmdJdFedWneqpex
	 +DApzaU16P7eAExvj1Es2JQ4LQb1nJ5lhK1IVrElcnp3KT+2rbj9GWuneWjtFmfTd8
	 EGQawCQwRXoqA==
Date: Wed, 29 Oct 2025 23:25:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
Message-ID: <20251029-wobei-rezept-bd53e76bb05b@brauner>
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
 <20251029-redezeit-reitz-1fa3f3b4e171@brauner>
 <20251029173828.GA1669504@ax162>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029173828.GA1669504@ax162>

On Wed, Oct 29, 2025 at 10:38:28AM -0700, Nathan Chancellor wrote:
> Hi Christian,
> 
> On Wed, Oct 29, 2025 at 02:41:06PM +0100, Christian Brauner wrote:
> > On Thu, 23 Oct 2025 10:21:42 +0200, Rasmus Villemoes wrote:
> > > Now that we build with -fms-extensions, union pipe_index can be
> > > included as an anonymous member in struct pipe_inode_info, avoiding
> > > the duplication.
> > > 
> > > 
> > 
> > Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.19.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-6.19.misc
> > 
> > [1/1] fs/pipe: stop duplicating union pipe_index declaration
> >       https://git.kernel.org/vfs/vfs/c/ade24f8214fe
> 
> As you may have noticed since I do not actually see this pushed, this
> change requires the '-fms-extensions' change that we are carrying in the
> kbuild tree for 6.19.
> 
>   https://git.kernel.org/kbuild/c/778740ee2d00e5c04d0c8ffd9c3beea89b1ec554

Meh, I thought it was already enabled.
Are you pushing this as a new feature for v6.19 or is Linus ok with
enabling this still during v6.18?

