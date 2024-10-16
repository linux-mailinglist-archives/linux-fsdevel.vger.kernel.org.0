Return-Path: <linux-fsdevel+bounces-32076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A5E9A044D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790001C23C69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 08:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DD81F8185;
	Wed, 16 Oct 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8wjryEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33941D88D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067540; cv=none; b=Bfw9lA7i49C+9bdoFvB7VHR9FYCskov7elz0HSbBc8zy6HUcLiB/RTPEXN77pX15nr0ywQ7qyU8QlvN+EPXCoPdEySWECEUuEwXHom3M8lDqAH110sZ1UMECjK4JTNlElfvqB0q6y5kMr5mMmoAyTXQAYC2Xu5ZsumvqDU5DUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067540; c=relaxed/simple;
	bh=69PlKFgy9u9OHk+Bom6t3G3YqaC8U0LWFYd2MYs4WVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7p2BclhKH4EPr9i1tamkcYm8O88+9WTJzlNKNkCu1LMPJIjIouBEI9ZajVqSuco/6YnZTWNeYrDWBohyWIIxuP50YXX2hxLJ3AyzqTKJhkT/csXTwEdj8HTmWQIKMGSaMZQEU/uXWz4mpC1B8Nm2H3O+ZGuZ9E5W3dgEzxVb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8wjryEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768E5C4CEC5;
	Wed, 16 Oct 2024 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729067540;
	bh=69PlKFgy9u9OHk+Bom6t3G3YqaC8U0LWFYd2MYs4WVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8wjryEYX+mJbNto4h/gnXejwOkAHBOpzCAi17rrnxfLA/c3Ez0jdXa5b36WYfxvw
	 3UVHqpHBvYpHESH1gD8dHlB14sJgx2TjJNRmZh2ongwEo2sAPFGCF/MdgIAfyYRi00
	 xx4HBCxXtCeBcHtUCvLRN5zx3o4IYsQtY2MUeD2yb/cGPvjRHMymo1RylN0sKesl4q
	 dxG3tKk+74WisLNtXDTxifiek5T0EmxCBvNuaA+xQXhGJW8rENb8wlqEKlOVcc5rax
	 Oy5pXCotT8WL2kLhQfzgWMCxxGiN2xIHox2+rXpXYb646WayejsG9i/vsPTm0QyF02
	 HqC9aqTI91xfA==
Date: Wed, 16 Oct 2024 10:32:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241016-reingehen-glanz-809bd92bf4ab@brauner>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016050908.GH4017910@ZenIV>

On Wed, Oct 16, 2024 at 06:09:08AM +0100, Al Viro wrote:
> On Tue, Oct 15, 2024 at 04:05:15PM +0200, Christian Brauner wrote:
> > Looks good.
> > 
> > Fyi, I'm using your #base.getname as a base for some other work that I'm
> > currently doing. So please don't rebase #base.getname anymore. ;)
> > 
> > Since you have your #work.xattr and #work.stat using it as base it seems
> > pretty unlikely anyway but I just thought I mention explicitly that I'm
> > relying on that #base.getname branch.
> 
> FWIW, I see a problem with that sucker.  The trouble is in the
> combination AT_FDCWD, "", AT_EMPTY_PATH.  vfs_empty_path() returns

Yeah, we're aware.

> false on that, so fstatat() in mainline falls back to vfs_statx() and
> does the right thing.  This variant does _not_.
> 
> Note that your variant of xattr series also ended up failing on e.g.
> getxattrat() with such combination:
>         if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
>                 CLASS(fd, f)(dfd);
>                 if (!f.file)
>                         return -EBADF;
>                 audit_file(f.file);
>                 return getxattr(file_mnt_idmap(f.file), file_dentry(f.file),
>                                 name, value, size);
>         }
> 
>         lookup_flags = (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
> 
> retry:
>         error = user_path_at(dfd, pathname, lookup_flags, &path);
> 
> ended up calling user_path_at() with empty pathname and nothing like LOOKUP_EMPTY
> in lookup_flags.  Which bails out with -ENOENT, since getname() in there does
> so.  My variant bails out with -EBADF and I'd argue that neither is correct.
> 
> Not sure what's the sane solution here, need to think for a while...

Fwiw, in the other thread we concluded to just not care about AT_FDCWD with "".
And so far I agree with that.

