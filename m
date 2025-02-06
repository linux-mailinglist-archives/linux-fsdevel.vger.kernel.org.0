Return-Path: <linux-fsdevel+bounces-41045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4244FA2A498
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E059D168BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2950B22B8AA;
	Thu,  6 Feb 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrx7+CUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E1226538;
	Thu,  6 Feb 2025 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834319; cv=none; b=bcDKo4hs+7HVFvXxTvkaVcLFYbAe53kANOwIrFG/G20N6uJX00W6ko4hmj/hkJEMUC2XJoopuML3YMeYWjtrokUNGjWG9gvZR8JXTAV0cj0BoEO51DZoOvEeRAzVZcCB1sizZ5mm0KzBT2LksByCoYz0dtencx5K5WcFl0U9bWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834319; c=relaxed/simple;
	bh=Tt+yDI5db92DPvgxkLoXDgaz4XRmykzWy85BDbRZ59w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHKsnqiWwKMsuGSwjvxOMRmvmnuNiSgGA7E+1J9o+5LMsmA6BkGu2n1zHzcCl96L+U3rtFnvIzZG0LybuNgPERGHPgUdLTtsUV5hOx17UZVFu1XXbbGLu1XTuB6w2x858lHhUoL+eSZvHFDQkc7iVV17QPlt2jabFILF1SMn6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrx7+CUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34153C4CEE0;
	Thu,  6 Feb 2025 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738834319;
	bh=Tt+yDI5db92DPvgxkLoXDgaz4XRmykzWy85BDbRZ59w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wrx7+CUvewS1AnJVqhdiy94m1I4bXqHc+kE/YZvG9LkFbAHSsrkyxsHb31Q9g0LED
	 lRdqw7nuDHecpGlERXiBbykQfhKl0NBmOPU25g8xWDqnyV+xmegCpr2Vxb2SZSAxmZ
	 xKL10egsCUsuqWn2rhbhBHTW28IiIwMGprrg9lu4V50QPqKJ0SOA4E5G7Qux9l65gv
	 ZMgpBcmcKDWycmLY0HneSgEghx3X6D1dCYPXvyQEVgFT/UTrWdsJdgHa1Va9ssLeGS
	 CrY4zwbHl1WcO5x8Jf8dTlJk6jC0L2wcTRizWq3z9TzTPwVgJCfVMymAhh1tmg1Iu1
	 Y2OWvt76DJDQg==
Date: Thu, 6 Feb 2025 10:31:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mike Yuan <me@yhndnzj.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: actually support O_PATH fds in *xattrat()
 syscalls
Message-ID: <20250206-uhrwerk-faultiere-7a308565e2d3@brauner>
References: <20250205204628.49607-1-me@yhndnzj.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250205204628.49607-1-me@yhndnzj.com>

On Wed, Feb 05, 2025 at 08:47:23PM +0000, Mike Yuan wrote:
> Cited from commit message of original patch [1]:
> 
> > One use case will be setfiles(8) setting SELinux file contexts
> > ("security.selinux") without race conditions and without a file
> > descriptor opened with read access requiring SELinux read permission.
> 
> Also, generally all *at() syscalls operate on O_PATH fds, unlike
> f*() ones. Yet the O_PATH fds are rejected by *xattrat() syscalls
> in the final version merged into tree. Instead, let's switch things
> to CLASS(fd_raw).
> 
> Note that there's one side effect: f*xattr() starts to work with
> O_PATH fds too. It's not clear to me whether this is desirable
> (e.g. fstat() accepts O_PATH fds as an outlier).
> 
> [1] https://lore.kernel.org/all/20240426162042.191916-1-cgoettsche@seltendoof.de/
> 
> Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> Signed-off-by: Mike Yuan <me@yhndnzj.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Göttsche <cgzones@googlemail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: <stable@vger.kernel.org>
> ---

I expanded on this before. O_PATH is intentionally limited in scope and
it should not allow to perform operations that are similar to a read or
write which getting and setting xattrs is.

Patches that further weaken or dilute the semantics of O_PATH are not
acceptable.

>  fs/xattr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 02bee149ad96..15df71e56187 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -704,7 +704,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
>  
>  	filename = getname_maybe_null(pathname, at_flags);
>  	if (!filename) {
> -		CLASS(fd, f)(dfd);
> +		CLASS(fd_raw, f)(dfd);
>  		if (fd_empty(f))
>  			error = -EBADF;
>  		else
> @@ -848,7 +848,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
>  
>  	filename = getname_maybe_null(pathname, at_flags);
>  	if (!filename) {
> -		CLASS(fd, f)(dfd);
> +		CLASS(fd_raw, f)(dfd);
>  		if (fd_empty(f))
>  			return -EBADF;
>  		return file_getxattr(fd_file(f), &ctx);
> @@ -978,7 +978,7 @@ static ssize_t path_listxattrat(int dfd, const char __user *pathname,
>  
>  	filename = getname_maybe_null(pathname, at_flags);
>  	if (!filename) {
> -		CLASS(fd, f)(dfd);
> +		CLASS(fd_raw, f)(dfd);
>  		if (fd_empty(f))
>  			return -EBADF;
>  		return file_listxattr(fd_file(f), list, size);
> @@ -1079,7 +1079,7 @@ static int path_removexattrat(int dfd, const char __user *pathname,
>  
>  	filename = getname_maybe_null(pathname, at_flags);
>  	if (!filename) {
> -		CLASS(fd, f)(dfd);
> +		CLASS(fd_raw, f)(dfd);
>  		if (fd_empty(f))
>  			return -EBADF;
>  		return file_removexattr(fd_file(f), &kname);
> 
> base-commit: a86bf2283d2c9769205407e2b54777c03d012939
> -- 
> 2.48.1
> 
> 

