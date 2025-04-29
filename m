Return-Path: <linux-fsdevel+bounces-47563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EE6AA0504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F503189E22D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3F52741B3;
	Tue, 29 Apr 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsyIMfVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BB24C098
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913144; cv=none; b=YqQkKQqmvlo88OYI/HHQ7MG/ELscYSQlcrKSQxvVtcqb90afwFn7a0uhdzM9PbWr4llHS0gtz3rRJH+0B0S9u4UJbz/Xods3MwNibreErP47Qqew5KXYxuoO1agZ6+bqZ+Iva6UiB8qk+DsF2o1+S0BwiopiWLW7LQBvgQFdjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913144; c=relaxed/simple;
	bh=ABbjENDLXoOIVpVmqHBVPAtryHjKtFOqwngrSJgE7po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdRFMtINnx4miF6rYY2sIvbxghKGdcB/iLiCKNkC2JQxih0fVqmPeSh4GmcNiCmg/4l5sQ4E+IxZ4/Zxc6oWUsKL7DFjPVdhRHAUP4hQqlU5SGAgJU/H43dwKHyxj2ccF8JhoYJNehkHBOTbevLJ4TFemnPffzJFAzFFiZsNhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsyIMfVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AC5C4CEEA;
	Tue, 29 Apr 2025 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745913143;
	bh=ABbjENDLXoOIVpVmqHBVPAtryHjKtFOqwngrSJgE7po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsyIMfVGaENWuvzEZITK8tBP1iyvfu/9pDISN/Pd20EK7o4uviawBA7T6dLxvU4KY
	 sSpZ4Ii3B7vbjYG2vDHxGdXoiNyoSlYLCHOXhQaEYOzNthhYqJmUx1eVsN+9/T/yw0
	 vZn9Yka4jmkqZRZF3f3ChCttSm+i8FAZ5EuLLTc5Xq/pKbZnLK+gVbl28/xrQhjve/
	 AsFLilaxY+HJPYF32UNL6Aq2SflqF4yosqlb6nwjFgQSSBrA3w/teqeFLrpcxAbH23
	 RDjHvkHI73K+OXuPn2WN7tdyEw/AZb5eP0tF2O3xNEN5c6v8rSBq9P+fkI7jgSQvtm
	 3RQL2QQgng7Ww==
Date: Tue, 29 Apr 2025 09:52:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250429-episoden-safran-3e609902d4d7@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428185318.GN2023217@ZenIV>

On Mon, Apr 28, 2025 at 07:53:18PM +0100, Al Viro wrote:
> On Mon, Apr 28, 2025 at 10:50:53AM +0200, Christian Brauner wrote:
> 
> > I'm not fond of the global variable. I would generally agree with you if
> > that were really performance sensitive but this really isn't.
> 
> Up to you; propagation calculations *are* hard-serialized (on namespace_sem)
> and changing that is too much pain to consider, so I have no problem with
> globals in that specific case (note several such in propagate_mnt()
> machinery; that was a deliberate decision to avoid shitloads of arguments
> that would have to be passed around otherwise), but...

I know, I know. I've seen Ram's code and touched it enough. The globals
have been very confusing at times though especially because they change
across multiple function calls. But anyway.

> 
> Anyway, minimal fix is to shift clearing the flag, as below.
> Longer term I'd rather shift setting and clearing it down into
> propagate_mnt() (and dropped check from propagation_would_overmount(),
> with corresponding change to can_move_mount_beneath()).
> 
> It's really "for the purposes of this mount propagation event treat all
> mounts in that namespace as 'new'", so the smaller scope that thing has
> the easier it is to reason about...

I had a similar thought but my reasoning has been that if it's as close
to the system call interface as possible then it's very very obvious
where this happens and how it's cleared. IOW, the bigger scope felt
actually easier in this case.

> 
> > I'll have more uses for the flags member very soon as I will make it
> > possible to list mounts in anonymous mount namespaces because it
> > confuses userspace to no end that they can't list detached mount trees.
> > 
> > So anonymous mount namespaces will simply get a mount namespace id just
> > like any other mount namespace and simply be discerned by a flag.
> > 
> > Thanks for going through this. I appreciate it.
> > 
> > The check_mnt() simplification is good though.
> 
> FWIW, I've a series of cleanups falling out of audit of struct mount

Seems good.

> handling; it's still growing, but I'll post the stable parts for review
> tonight or tomorrow...
> 
> --------
> [PATCH] do_move_mount(): don't leak MNTNS_PROPAGATING on failures
> 
> as it is, a failed move_mount(2) from anon namespace breaks
> all further propagation into that namespace, including normal
> mounts in non-anon namespaces that would otherwise propagate
> there.
> 
> Fixes: 064fe6e233e8 "mount: handle mount propagation for detached mount trees" v6.15+
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/namespace.c b/fs/namespace.c
> index eba4748388b1..8b8348ee5a55 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3714,15 +3714,14 @@ static int do_move_mount(struct path *old_path,
>  	if (err)
>  		goto out;
>  
> -	if (is_anon_ns(ns))
> -		ns->mntns_flags &= ~MNTNS_PROPAGATING;
> -
>  	/* if the mount is moved, it should no longer be expire
>  	 * automatically */
>  	list_del_init(&old->mnt_expire);
>  	if (attached)
>  		put_mountpoint(old_mp);
>  out:
> +	if (is_anon_ns(ns))
> +		ns->mntns_flags &= ~MNTNS_PROPAGATING;

Thanks!

