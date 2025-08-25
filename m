Return-Path: <linux-fsdevel+bounces-59049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939FB34031
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF37D206B4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384E242D76;
	Mon, 25 Aug 2025 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMj7prQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3497393DCA
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126677; cv=none; b=o6YVmDlL0AA1yWZiPTvqWYfFM0+vmlOfeb216Cdldr2Ld+RKBviDeNwR4SFrETzhVOwfwFjT4L57BUXWahKJ+7MTcjnoWAKyBoRaG14JQ+nwO1nk+/quR67EwVwfsfIQ2PfgDEA//RktDhlV5ojDCGUO+UzKnhdJgvsIs8vN1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126677; c=relaxed/simple;
	bh=CLpwQAlytW7AOMkwwWGrlB0oyEYXrv9uoLa2om2goBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C01HjVR+EfKMof4NZXi8yDR5VlQP/w0LXj1vV7C4f/VeFBlCO5gUJmMTenvWfyCdiwdRUVcOo08feGKBUteyGu5tuNQZ87npJCtws4AYj9MkguODWIdk77dNw9bgoDDijQK5N//nLXJpOXy1KfIJ/odbdCjyB/scDynAp0mBmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMj7prQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DD4C4CEED;
	Mon, 25 Aug 2025 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126677;
	bh=CLpwQAlytW7AOMkwwWGrlB0oyEYXrv9uoLa2om2goBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMj7prQXSIsLSxD7qrIyHug9HRPeAMlKt8lTvmfESr9NiQ8DMmbXRHFZaODJIAxay
	 u0EQ+l0Lo/x8mq3qHS1utJt1n0jCRWG/SQP8FiInkqgQoD+EB1VljqMKOelqnbTHCy
	 d6n/R3r7RLmvBw7LTxLii1qF8RoxMa5kAPnqaOwURHN7rX0Qc1DhzGJk7JlBTBER9X
	 r0izKnKGEUTN/xkyu3fu2TXffEOR+a089Z4l9ZpmDMSTdbmE4nwtjgDacn0XATrFvF
	 Wd7ZBLonMIVGBFwolNdh5zDE992mJNQib5MT2/7bVhor3v1ToqXILncZWB8xBMnU04
	 LrrTimSXRRfug==
Date: Mon, 25 Aug 2025 14:57:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 18/52] do_move_mount(): trim local variables
Message-ID: <20250825-herren-fassaden-b6327d0aa6ab@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-18-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-18-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:21AM +0100, Al Viro wrote:
> Both 'parent' and 'ns' are used at most once, no point precalculating those...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/namespace.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a8b586e635d8..1a076aac5d73 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3564,10 +3564,8 @@ static inline bool may_use_mount(struct mount *mnt)
>  static int do_move_mount(struct path *old_path,
>  			 struct path *new_path, enum mnt_tree_flags_t flags)
>  {
> -	struct mnt_namespace *ns;
>  	struct mount *p;
>  	struct mount *old;
> -	struct mount *parent;
>  	struct pinned_mountpoint mp;
>  	int err;
>  	bool beneath = flags & MNT_TREE_BENEATH;
> @@ -3578,8 +3576,6 @@ static int do_move_mount(struct path *old_path,
>  
>  	old = real_mount(old_path->mnt);
>  	p = real_mount(new_path->mnt);
> -	parent = old->mnt_parent;
> -	ns = old->mnt_ns;
>  
>  	err = -EINVAL;
>  
> @@ -3588,12 +3584,12 @@ static int do_move_mount(struct path *old_path,
>  		/* ... it should be detachable from parent */
>  		if (!mnt_has_parent(old) || IS_MNT_LOCKED(old))
>  			goto out;
> +		/* ... which should not be shared */
> +		if (IS_MNT_SHARED(old->mnt_parent))
> +			goto out;
>  		/* ... and the target should be in our namespace */
>  		if (!check_mnt(p))
>  			goto out;
> -		/* parent of the source should not be shared */
> -		if (IS_MNT_SHARED(parent))
> -			goto out;
>  	} else {
>  		/*
>  		 * otherwise the source must be the root of some anon namespace.
> @@ -3605,7 +3601,7 @@ static int do_move_mount(struct path *old_path,
>  		 * subsequent checks would've rejected that, but they lose
>  		 * some corner cases if we check it early.
>  		 */
> -		if (ns == p->mnt_ns)
> +		if (old->mnt_ns == p->mnt_ns)
>  			goto out;
>  		/*
>  		 * Target should be either in our namespace or in an acceptable
> -- 
> 2.47.2
> 

