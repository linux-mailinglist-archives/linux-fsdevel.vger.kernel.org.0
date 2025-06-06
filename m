Return-Path: <linux-fsdevel+bounces-50818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE9BACFDD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 09:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8B2170438
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291F3284696;
	Fri,  6 Jun 2025 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjXvaXWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F217FD
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749196711; cv=none; b=oNJA9aEmB0WKbepsWV7SElFMRn9dOK/LG86AlDgtFnIEuLj59SAeLvjPfpvcC3Hzsya0PYS64JD/6UxXGAeO8ucZ0pT6zCxixjVOgerZnaj1PHN12KOnjgLvK/At+H4MkOdAQp5375MjzmoLTUkEyoEzyKV4gYijodLija3tXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749196711; c=relaxed/simple;
	bh=Awlh29UmVQ7CLitTdlF+fUNtTj9t7NlSyzkc4Grx8Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJVxgP4Re+EPddn/iaCnvXBBqF0UIHQlUdX3r2en6I4vSoiApx1UoIiAlDFde9MkcS1BsxZIyjlmF+eHA1CxNSvD9bgmIwIPXchi2YY644Szlef6aLFYVksRmou+sdK9eKqJAywM3GwQEayXhaNs8Bj5pwrKMVsoN84X1fgUGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjXvaXWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A64AC4CEEB;
	Fri,  6 Jun 2025 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749196711;
	bh=Awlh29UmVQ7CLitTdlF+fUNtTj9t7NlSyzkc4Grx8Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MjXvaXWyZg5IJ7jwWmbDzHoTLklxKIuVuWC9y81X75wip3t9ZjIj9DtVBp1I4bjX+
	 4I1jKUATpJzJd2ywFYu2rRwnxVeFqlNUwJKKb6tnZf8GoR6zyNPD3s2n8KZWUI58AM
	 cKPxu5RJx1ypFQUQ+CvrsvqbtQLGJskCgvntin2A1iBNNo2y+2geJmtH6SDRVjyUd1
	 gwbrHtV0Hww1kUAV9OE1vJ6/6RpMKmCYpb5cGS+afG1QtM08oysXJpqEY9zmAFma6U
	 +Pb7k0+VnE4ZpuntEbqi72umAAWwtWJ3z6ivDgcXAFGZ/YCNT9rS4J+DLGkHScekxc
	 omaI0Gh4/PLfg==
Date: Fri, 6 Jun 2025 09:58:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>, Allison Karlitskaya <lis@redhat.com>
Subject: Re: [PATCH 1/2] mount: fix detached mount regression
Message-ID: <20250606-neuformulierung-flohmarkt-42efdaa4bac5@brauner>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
 <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
 <20250606045441.GS299672@ZenIV>
 <20250606051428.GT299672@ZenIV>
 <20250606070127.GU299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250606070127.GU299672@ZenIV>

On Fri, Jun 06, 2025 at 08:01:27AM +0100, Al Viro wrote:
> 	Folks, could you check the following, on top of viro/vfs.git#fixes?
> 
> do_move_mount(): split the checks in subtree-of-our-ns and entire-anon cases
> 
> ... and fix the breakage in anon-to-anon case.  There are two cases
> acceptable for do_move_mount() and mixing checks for those is making
> things hard to follow.
> 
> One case is move of a subtree in caller's namespace.
> 	* source and destination must be in caller's namespace
> 	* source must be detachable from parent
> Another is moving the entire anon namespace elsewhere
> 	* source must be the root of anon namespace
> 	* target must either in caller's namespace or in a suitable
> 	  anon namespace (see may_use_mount() for details).
> 	* target must not be in the same namespace as source.
> 
> It's really easier to follow if tests are *not* mixed together...
> 
> [[
> This should be equivalent to what Christian has posted last night;
> please test on whatever tests you've got.
> ]]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Fwiw, check_mnt() is a useless name for this function that's been
bothering me forever. A few minor comments below. With those addressed:

Reviewed-by: Christian Brauner <brauner@kernel.org>

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 854099aafed5..59197109e6b9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3656,37 +3656,29 @@ static int do_move_mount(struct path *old_path,
>  	ns = old->mnt_ns;
>  
>  	err = -EINVAL;
> -	if (!may_use_mount(p))
> -		goto out;
> -
>  	/* The thing moved must be mounted... */
>  	if (!is_mounted(&old->mnt))
>  		goto out;
>  
>  	/* ... and either ours or the root of anon namespace */
> -	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
> -		goto out;
> -
> -	if (is_anon_ns(ns) && ns == p->mnt_ns) {
> -		/*
> -		 * Ending up with two files referring to the root of the
> -		 * same anonymous mount namespace would cause an error
> -		 * as this would mean trying to move the same mount
> -		 * twice into the mount tree which would be rejected
> -		 * later. But be explicit about it right here.
> -		 */
> -		goto out;
> -	} else if (is_anon_ns(p->mnt_ns)) {
> -		/*
> -		 * Don't allow moving an attached mount tree to an
> -		 * anonymous mount tree.
> -		 */
> -		goto out;
> +	if (check_mnt(old)) {
> +		/* should be detachable from parent */
> +		if (!mnt_has_parent(old) || IS_MNT_LOCKED(old))
> +			goto out;
> +		/* target should be ours */
> +		if (!check_mnt(p))
> +			goto out;
> +	} else {

This code has gotten more powerful with my recent changes to allow
assembling private mount trees so I think we should be more liberal with
comments to be kind to our future selves. Also I would really prefer if
we could move the checks to separate lines:

/* Only allow moving anonymous mounts... */
if (!is_anon_ns(ns))
	goto out;

/* ... that are the root of their anonymous mount namespace. */
if (mnt_has_parent(old))
	goto out;

if (ns == p->mnt_ns)
	goto out;

/*
 * Finally, make sure that the target is either a mount in our mount
 * namespace or in an acceptable anonymous mount namespace.
 */
target should be ours or in an acceptable anon ns */
if (!may_use_mount(p))
	goto out;


Other than that this looks good to me.

/* 
> +		if (!is_anon_ns(ns) || mnt_has_parent(old))
> +			goto out;
> +		/* not into the same anon ns - bail early in that case */

		/* Don't allow moving into the same mount namespace
> +		if (ns == p->mnt_ns)
> +			goto out;
> +		/* target should be ours or in an acceptable anon ns */
> +		if (!may_use_mount(p))
> +			goto out;
>  	}
>  
> -	if (old->mnt.mnt_flags & MNT_LOCKED)
> -		goto out;
> -
>  	if (!path_mounted(old_path))
>  		goto out;
>  

