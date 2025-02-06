Return-Path: <linux-fsdevel+bounces-41068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB59A2A8B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135031686EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4310922E3FF;
	Thu,  6 Feb 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emmv28mW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02722DF99;
	Thu,  6 Feb 2025 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738845859; cv=none; b=lfpOk6gT4g7F2CBLJJ9cl65//pOiXHiDMle8Xs+Bu4OKc91PlQtwm6aH792g6IXTqQkXek2kLN0rnRxTL49+1pZx7TDH4VtM4UjzvUSWFMbFDX9Z04yEG7JENhxQFPSB3Pnhbt+bsaE68YFhFYl/5830wRsd434/uSkg5xJaCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738845859; c=relaxed/simple;
	bh=AI14gFOmTzGyATjTmSWsjNge/5pVrqKxGeFBT0xQKac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBZQLJ8nmN3cuRu3wboGDo+XmS5cbdC/7Odr/9UQitWMXlAkbukrQx2uevb7tpAtDL8755UcJ3Kzei5+Xkm2nCdw4nZNsXxJrX/so1hguYhZ/EFeEVQR1GFPlj2Yqs2SAtlNkCDgwcmrCz87q4vupSN2DbEaUZqGCqPLq0pHy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emmv28mW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B931BC4CEDD;
	Thu,  6 Feb 2025 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738845858;
	bh=AI14gFOmTzGyATjTmSWsjNge/5pVrqKxGeFBT0xQKac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Emmv28mWb6fV+T+Ro+GlrNq3CKTnAaicWv1UZay0wS2IngW/+bWCk7owMKT5XPPnZ
	 5PZENti/fpwHiTaQi/hpLMiCQIvyuIlXC+3zTagdnSFkdZJmytBsdcTKJQalTORHWB
	 2pOdi4FpKgSKQUv7/zrduRdBYdwusx0a8jgYRPlwYDDEz6cIRTNPIfJ2hiAP8WMyIq
	 e5kqEqGUAD01ViBSmQ2bI294QCmJnW3jH35t0z8dPzjthZy3TiYhBZfS3x0jPH9efI
	 TmAUL8tdl2524L6uO2JskN+PLjHOYcA6e1dbibMNDEfYeVt6W20Cfj9Zwd9oZZY5pm
	 lNp8DJL8mFSEA==
Date: Thu, 6 Feb 2025 13:44:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/19] VFS: repack LOOKUP_ bit flags.
Message-ID: <20250206-wirren-ausfiel-99acf5b0ace8@brauner>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-8-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-8-neilb@suse.de>

On Thu, Feb 06, 2025 at 04:42:44PM +1100, NeilBrown wrote:
> The LOOKUP_ bits are not in order, which can make it awkward when adding
> new bits.  Two bits have recently been added to the end which makes them
> look like "scoping flags", but in fact they aren't.
> 
> Also LOOKUP_PARENT is described as "internal use only" but is used in
> fs/nfs/
> 
> This patch:
>  - Moves these three flags into the "pathwalk mode" section
>  - changes all bits to use the BIT(n) macro
>  - Allocates bits in order leaving gaps between the sections,
>    and documents those gaps.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---

This is also a worthwhile cleanup independent of the rest of the series.
But you've added LOOKUP_INTENT_FLAGS prior to packing the flags. Imho,
this patch should've gone before the addition of LOOKUP_INTENT_FLAGS.

And btw, what does this series apply to?
Doesn't apply to next-20250206 nor to current mainline.
I get the usual

Patch failed at 0012 VFS: enhance d_splice_alias to accommodate shared-lock updates
error: sha1 information is lacking or useless (fs/dcache.c).
error: could not build fake ancestor

when trying to look at this locally.

>  include/linux/namei.h | 46 +++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 839a64d07f8c..0d81e571a159 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -18,38 +18,38 @@ enum { MAX_NESTED_LINKS = 8 };
>  enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  
>  /* pathwalk mode */
> -#define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
> -#define LOOKUP_DIRECTORY	0x0002	/* require a directory */
> -#define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
> -#define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
> -#define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
> -#define LOOKUP_MOUNTPOINT	0x0080	/* follow mounts in the end */
> -
> -#define LOOKUP_REVAL		0x0020	/* tell ->d_revalidate() to trust no cache */
> -#define LOOKUP_RCU		0x0040	/* RCU pathwalk mode; semi-internal */
> +#define LOOKUP_FOLLOW		BIT(0)	/* follow links at the end */
> +#define LOOKUP_DIRECTORY	BIT(1)	/* require a directory */
> +#define LOOKUP_AUTOMOUNT	BIT(2)  /* force terminal automount */
> +#define LOOKUP_EMPTY		BIT(3)	/* accept empty path [user_... only] */
> +#define LOOKUP_LINKAT_EMPTY	BIT(4) /* Linkat request with empty path. */
> +#define LOOKUP_DOWN		BIT(5)	/* follow mounts in the starting point */
> +#define LOOKUP_MOUNTPOINT	BIT(6)	/* follow mounts in the end */
> +#define LOOKUP_REVAL		BIT(7)	/* tell ->d_revalidate() to trust no cache */
> +#define LOOKUP_RCU		BIT(8)	/* RCU pathwalk mode; semi-internal */
> +#define LOOKUP_CACHED		BIT(9) /* Only do cached lookup */
> +#define LOOKUP_PARENT		BIT(10)	/* Looking up final parent in path */
> +/* 5 spare bits for pathwalk */
>  
>  /* These tell filesystem methods that we are dealing with the final component... */
> -#define LOOKUP_OPEN		0x0100	/* ... in open */
> -#define LOOKUP_CREATE		0x0200	/* ... in object creation */
> -#define LOOKUP_EXCL		0x0400	/* ... in target must not exist */
> -#define LOOKUP_RENAME_TARGET	0x0800	/* ... in destination of rename() */
> +#define LOOKUP_OPEN		BIT(16)	/* ... in open */
> +#define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
> +#define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
> +#define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
>  
>  #define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |	\
>  				 LOOKUP_RENAME_TARGET)
> -
> -/* internal use only */
> -#define LOOKUP_PARENT		0x0010
> +/* 4 spare bits for intent */
>  
>  /* Scoping flags for lookup. */
> -#define LOOKUP_NO_SYMLINKS	0x010000 /* No symlink crossing. */
> -#define LOOKUP_NO_MAGICLINKS	0x020000 /* No nd_jump_link() crossing. */
> -#define LOOKUP_NO_XDEV		0x040000 /* No mountpoint crossing. */
> -#define LOOKUP_BENEATH		0x080000 /* No escaping from starting point. */
> -#define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
> -#define LOOKUP_CACHED		0x200000 /* Only do cached lookup */
> -#define LOOKUP_LINKAT_EMPTY	0x400000 /* Linkat request with empty path. */
> +#define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
> +#define LOOKUP_NO_MAGICLINKS	BIT(25) /* No nd_jump_link() crossing. */
> +#define LOOKUP_NO_XDEV		BIT(26) /* No mountpoint crossing. */
> +#define LOOKUP_BENEATH		BIT(27) /* No escaping from starting point. */
> +#define LOOKUP_IN_ROOT		BIT(28) /* Treat dirfd as fs root. */
>  /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
>  #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
> +/* 3 spare bits for scoping */
>  
>  extern int path_pts(struct path *path);
>  
> -- 
> 2.47.1
> 

