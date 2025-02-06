Return-Path: <linux-fsdevel+bounces-41052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1733DA2A575
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5B93A6CF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E7226549;
	Thu,  6 Feb 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDl/dtOW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B8213240;
	Thu,  6 Feb 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836191; cv=none; b=W8YqLBHicTrS0qzRzmkAasSWOR07+blrk9apJpO6bEEDJCykibFZ/slnaPfG4sjs9j08Z+D3Hrmzi8MUTAutJoy+ShTBB0HkXGk3A3EoSubIOQlH9Ax91oMFaOd0sdxYzVNRG4OOeWanJ1V3UiUJUoJ01ZB3G/g7PKkMwOfvXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836191; c=relaxed/simple;
	bh=YIEU0eXfQRX96+/kOpKht7xakFhRP3QUq6m3r9epiQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1F9UYof25EEZPIwSJpZIL8vL4AL+7oLUaZ9pIm/uPC9GFFGmZw8R7YGhFxACLpboHjGjmxAeCskm2Y4WVPYX9nUheFuuXArRgEpylw4byjHvCla2RkXIAYZsihVDDUvjB9fu2lwKGgx2brN2/f2zdFrRRDTr10AqEfplVsqbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDl/dtOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA7DC4CEE0;
	Thu,  6 Feb 2025 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738836190;
	bh=YIEU0eXfQRX96+/kOpKht7xakFhRP3QUq6m3r9epiQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDl/dtOWbm1A1hnAksc4gAiiBfF3wk/OC/p8fxgzB0/NOj0n0mzujsXHac34t0qSL
	 vUxLTCFyonBjDrRNZ4PCjcAXmOQzH8PBbKhO30maAhtJftEjEG2HebYXEwRU7UcZvu
	 DkYpqoGbyWBfUHNli00u5gs4AiLi7ohT2qWODXcL20VbLbaG8VNpWC/8/odxPZh1Bm
	 Zb8F2mQc31OSM8EungWpFkEout+eIjRy2iv8GQg9kNIPyTa7gqwtlCVTW/8Mm6846e
	 MmOm5qRW791maTnKVCRosL4ZHCEw0LU5lZt9ZAqW3laZ2ap+e5eEr6UnhEv6QJrJ+r
	 3/bO7HloyE2ag==
Date: Thu, 6 Feb 2025 11:03:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mike Yuan <me@yhndnzj.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"cgzones@googlemail.com" <cgzones@googlemail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] fs/xattr: actually support O_PATH fds in *xattrat()
 syscalls
Message-ID: <20250206-erbauen-ornament-26f338d98f13@brauner>
References: <20250205204628.49607-1-me@yhndnzj.com>
 <20250206-uhrwerk-faultiere-7a308565e2d3@brauner>
 <Kn-2tlpxN8YNmh0j0udjQ8YIFNZMVVJYJh-LyBoYNBfpax28PNUkXuH6gnod7if2eX3NRVs3Ey8uCHRpwg_S5hPX_ADtrgMZbDTWFpHd_uU=@yhndnzj.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Kn-2tlpxN8YNmh0j0udjQ8YIFNZMVVJYJh-LyBoYNBfpax28PNUkXuH6gnod7if2eX3NRVs3Ey8uCHRpwg_S5hPX_ADtrgMZbDTWFpHd_uU=@yhndnzj.com>

On Thu, Feb 06, 2025 at 09:51:33AM +0000, Mike Yuan wrote:
> On 2/6/25 10:31, Christian Brauner <brauner@kernel.org> wrote:
> 
> >  On Wed, Feb 05, 2025 at 08:47:23PM +0000, Mike Yuan wrote:
> >  > Cited from commit message of original patch [1]:
> >  >
> >  > > One use case will be setfiles(8) setting SELinux file contexts
> >  > > ("security.selinux") without race conditions and without a file
> >  > > descriptor opened with read access requiring SELinux read permission.
> >  >
> >  > Also, generally all *at() syscalls operate on O_PATH fds, unlike
> >  > f*() ones. Yet the O_PATH fds are rejected by *xattrat() syscalls
> >  > in the final version merged into tree. Instead, let's switch things
> >  > to CLASS(fd_raw).
> >  >
> >  > Note that there's one side effect: f*xattr() starts to work with
> >  > O_PATH fds too. It's not clear to me whether this is desirable
> >  > (e.g. fstat() accepts O_PATH fds as an outlier).
> >  >
> >  > [1] https://lore.kernel.org/all/20240426162042.191916-1-cgoettsche@seltendoof.de/
> >  >
> >  > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> >  > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> >  > Cc: Al Viro <viro@zeniv.linux.org.uk>
> >  > Cc: Christian Göttsche <cgzones@googlemail.com>
> >  > Cc: Christian Brauner <brauner@kernel.org>
> >  > Cc: <stable@vger.kernel.org>
> >  > ---
> >  
> >  I expanded on this before. O_PATH is intentionally limited in scope and
> >  it should not allow to perform operations that are similar to a read or
> >  write which getting and setting xattrs is.
> >  
> >  Patches that further weaken or dilute the semantics of O_PATH are not
> >  acceptable.
> 
> But the *at() variants really should be able to work with O_PATH fds, otherwise they're basically useless? I guess I just need to keep f*() as-is?

I'm confused. If you have:

        filename = getname_maybe_null(pathname, at_flags);
        if (!filename) {
                CLASS(fd, f)(dfd);
                if (fd_empty(f))
                        error = -EBADF;
                else
                        error = file_setxattr(fd_file(f), &ctx);

Then this branch ^^ cannot use fd_raw because you're allowing operations
directly on the O_PATH file descriptor.

Using the O_PATH file descriptor for lookup is obviously fine which is
why the other branch exists:

        } else {
                error = filename_setxattr(dfd, filename, lookup_flags, &ctx);
        }

IOW, your patch makes AT_EMPTY_PATH work with an O_PATH file descriptor
which isn't acceptable. However, it is already perfectly fine to use an
O_PATH file descriptor for lookup.

> 
> >  >  fs/xattr.c | 8 ++++----
> >  >  1 file changed, 4 insertions(+), 4 deletions(-)
> >  >
> >  > diff --git a/fs/xattr.c b/fs/xattr.c
> >  > index 02bee149ad96..15df71e56187 100644
> >  > --- a/fs/xattr.c
> >  > +++ b/fs/xattr.c
> >  > @@ -704,7 +704,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
> >  >
> >  >  	filename = getname_maybe_null(pathname, at_flags);
> >  >  	if (!filename) {
> >  > -		CLASS(fd, f)(dfd);
> >  > +		CLASS(fd_raw, f)(dfd);
> >  >  		if (fd_empty(f))
> >  >  			error = -EBADF;
> >  >  		else
> >  > @@ -848,7 +848,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
> >  >
> >  >  	filename = getname_maybe_null(pathname, at_flags);
> >  >  	if (!filename) {
> >  > -		CLASS(fd, f)(dfd);
> >  > +		CLASS(fd_raw, f)(dfd);
> >  >  		if (fd_empty(f))
> >  >  			return -EBADF;
> >  >  		return file_getxattr(fd_file(f), &ctx);
> >  > @@ -978,7 +978,7 @@ static ssize_t path_listxattrat(int dfd, const char __user *pathname,
> >  >
> >  >  	filename = getname_maybe_null(pathname, at_flags);
> >  >  	if (!filename) {
> >  > -		CLASS(fd, f)(dfd);
> >  > +		CLASS(fd_raw, f)(dfd);
> >  >  		if (fd_empty(f))
> >  >  			return -EBADF;
> >  >  		return file_listxattr(fd_file(f), list, size);
> >  > @@ -1079,7 +1079,7 @@ static int path_removexattrat(int dfd, const char __user *pathname,
> >  >
> >  >  	filename = getname_maybe_null(pathname, at_flags);
> >  >  	if (!filename) {
> >  > -		CLASS(fd, f)(dfd);
> >  > +		CLASS(fd_raw, f)(dfd);
> >  >  		if (fd_empty(f))
> >  >  			return -EBADF;
> >  >  		return file_removexattr(fd_file(f), &kname);
> >  >
> >  > base-commit: a86bf2283d2c9769205407e2b54777c03d012939
> >  > --
> >  > 2.48.1
> >  >
> >  >
> >

