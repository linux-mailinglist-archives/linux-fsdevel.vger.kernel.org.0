Return-Path: <linux-fsdevel+bounces-47333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7C7A9C333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC324A3D57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBE2343AF;
	Fri, 25 Apr 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs9eIrkz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB94235C1E;
	Fri, 25 Apr 2025 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572825; cv=none; b=lEGZirk6ULS3ahbrevliQ3fllVQ+fYwhwtcmqBr3HHsg0CHORtLF9CXuzj14tAZIQjlOUqX6Ia3s37KgLy/TeXCxhY/GtvBmM1PRDqwoe2Ev2VcMxaqFDf6jCRLk5W3RGc/vsAJM1Y6vnihN7yX8lp4Y3iTbWavXkinbWc37s5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572825; c=relaxed/simple;
	bh=H670AXytogW3BrNyI3zj2dCfgNBrgFaCF3Zvvd9T9Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML44JXnk9xI+rR0J+jLPtyK1NR+aErYLvYiDFh0QevYd6qHiVUPEqfZ3NWOgAxHmwg7ihJqxV2zv0xEK1z1AM9y53b11EyL+quJzUHLNjUPt6vMlhN5oXOYTHFQAmjMVlz6zd+wBi9e/udZVe27ORNeVHDyys7pU1o5KFoBjxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs9eIrkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD95C4CEEB;
	Fri, 25 Apr 2025 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745572824;
	bh=H670AXytogW3BrNyI3zj2dCfgNBrgFaCF3Zvvd9T9Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gs9eIrkz4k1iKTdXlkm8+x4io+XHkGrz39eiAB8zgKKW1IcN+/sEpBguKrN+pvYQS
	 d6peSzBGxQP6nHQtrpzgzRIyIRbWPcGymtfMTHUyqob2mvPLTtHh9QUoemrHUYjUpD
	 iD2B/AH4cSEcfcPCNvWOiHf+7FrTKNfArQI1QzfNk0v/aIW7st+PFsBFaKYwoT8fpv
	 0uNOxuvMv632mVT77r25PlYvFsbkq2Vq0UzTRjn6MdlRfRhAv04PglUZoiWocs7IHF
	 qLLMdgcmqFo+9jmIDHFHwPbY8/+Qx0fs384QESF6HANCf8XRLeCkWtqBjQj1RfThHF
	 uAt0+XCj873oQ==
Date: Fri, 25 Apr 2025 11:20:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list to always include
 security.* xattrs
Message-ID: <20250425-einspannen-wertarbeit-3f0c939525dc@brauner>
References: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424152822.2719-1-stephen.smalley.work@gmail.com>

On Thu, Apr 24, 2025 at 11:28:20AM -0400, Stephen Smalley wrote:
> The vfs has long had a fallback to obtain the security.* xattrs from the
> LSM when the filesystem does not implement its own listxattr, but
> shmem/tmpfs and kernfs later gained their own xattr handlers to support
> other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based

This change is from 2011. So no living soul has ever cared at all for
at least 14 years. Surprising that this is an issue now.

> filesystems like sysfs no longer return the synthetic security.* xattr
> names via listxattr unless they are explicitly set by userspace or
> initially set upon inode creation after policy load. coreutils has
> recently switched from unconditionally invoking getxattr for security.*
> for ls -Z via libselinux to only doing so if listxattr returns the xattr
> name, breaking ls -Z of such inodes.

So no xattrs have been set on a given inode and we lie to userspace by
listing them anyway. Well ok then.

> Before:
> $ getfattr -m.* /run/initramfs
> <no output>
> $ getfattr -m.* /sys/kernel/fscaps
> <no output>
> $ setfattr -n user.foo /run/initramfs
> $ getfattr -m.* /run/initramfs
> user.foo
> 
> After:
> $ getfattr -m.* /run/initramfs
> security.selinux
> $ getfattr -m.* /sys/kernel/fscaps
> security.selinux
> $ setfattr -n user.foo /run/initramfs
> $ getfattr -m.* /run/initramfs
> security.selinux
> user.foo
> 
> Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
> Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.smalley.work@gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/xattr.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 02bee149ad96..2fc314b27120 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1428,6 +1428,15 @@ static bool xattr_is_trusted(const char *name)
>  	return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
>  }
>  
> +static bool xattr_is_maclabel(const char *name)
> +{
> +	const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
> +
> +	return !strncmp(name, XATTR_SECURITY_PREFIX,
> +			XATTR_SECURITY_PREFIX_LEN) &&
> +		security_ismaclabel(suffix);
> +}
> +
>  /**
>   * simple_xattr_list - list all xattr objects
>   * @inode: inode from which to get the xattrs
> @@ -1460,6 +1469,17 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  	if (err)
>  		return err;
>  
> +	err = security_inode_listsecurity(inode, buffer, remaining_size);

Is that supposed to work with multiple LSMs?
Afaict, bpf is always active and has a hook for this.
So the LSMs trample over each other filling the buffer?

> +	if (err < 0)
> +		return err;
> +
> +	if (buffer) {
> +		if (remaining_size < err)
> +			return -ERANGE;
> +		buffer += err;
> +	}
> +	remaining_size -= err;

Really unpleasant code duplication in here. We have xattr_list_one() for
that. security_inode_listxattr() should probably receive a pointer to
&remaining_size?

> +
>  	read_lock(&xattrs->lock);
>  	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
>  		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> @@ -1468,6 +1488,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  		if (!trusted && xattr_is_trusted(xattr->name))
>  			continue;
>  
> +		/* skip MAC labels; these are provided by LSM above */
> +		if (xattr_is_maclabel(xattr->name))
> +			continue;
> +
>  		err = xattr_list_one(&buffer, &remaining_size, xattr->name);
>  		if (err)
>  			break;
> -- 
> 2.49.0
> 

