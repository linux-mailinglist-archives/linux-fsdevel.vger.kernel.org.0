Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A05A6944
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiH3RJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 13:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiH3RJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE2A9C13;
        Tue, 30 Aug 2022 10:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73CF86175A;
        Tue, 30 Aug 2022 17:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B90C433D6;
        Tue, 30 Aug 2022 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661879377;
        bh=KZMiODuekOkOe+Fpe6xhPNDtlcbn9BcI7iO9PS6cJv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTeZ+vmnAKE5037XIMXb/8g5TcOALJ6SyB3SdaZ5dF9HeHjgxvMnfFC3vLYoCzw/8
         ev9/la2FsZBpeYx+vK0PfFd4T1KP7X8/GnzQDNdSV1+LfM2r7nrhWN1dhXvtvYY6Y1
         tmWg2Cwf/faBg00Br40TXtM3cqOwYgV1p9qQEElteOCPDOwCgTvmzofauq5RORuL9R
         BLBKDrGYG/lcUodvb4Dcj4cYtltn04MWa3k3Srr/avKaP55Q0c9LSxlGutV5dux9RN
         oeznscoKlj1PdytHfv0RJC5k9KRAwyqw8yqc81709cyaAIZsAbFK0eT/SBDC3tT+kO
         2zK7ViTDJGNgw==
Date:   Tue, 30 Aug 2022 19:09:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs/xattr: add *at family syscalls
Message-ID: <20220830170933.lt437ba43w7nh4kb@wittgenstein>
References: <20220830152858.14866-1-cgzones@googlemail.com>
 <20220830152858.14866-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830152858.14866-2-cgzones@googlemail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 30, 2022 at 05:28:39PM +0200, Christian Göttsche wrote:
> Add the four syscalls setxattrat(), getxattrat(), listxattrat() and
> removexattrat() to enable extended attribute operations via file
> descriptors.  This can be used from userspace to avoid race conditions,
> especially on security related extended attributes, like SELinux labels
> ("security.selinux") via setfiles(8).
> 
> Use the do_{name}at() pattern from fs/open.c.
> Use a single flag parameter for extended attribute flags (currently
> XATTR_CREATE and XATTR_REPLACE) and *at() flags to not exceed six
> syscall arguments in setxattrat().
> 
> Previous discussion ("f*xattr: allow O_PATH descriptors"): https://lore.kernel.org/all/20220607153139.35588-1-cgzones@googlemail.com/
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

Having a way to operate via file descriptors on xattrs does make a lot
of sense to me in general. We've got code that changes ownership
recursively including using llistxattr(), getxattr(), and setxattr() any
xattrs that store ownership information and being able to passing in an
fd directly would be quite neat...

>  fs/xattr.c | 108 +++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 85 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index a1f4998bc6be..a4738e28be8c 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -27,6 +27,8 @@
>  
>  #include "internal.h"
>  
> +#define XATTR__FLAGS (XATTR_CREATE | XATTR_REPLACE)
> +
>  static const char *
>  strcmp_prefix(const char *a, const char *a_prefix)
>  {
> @@ -559,7 +561,7 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx)
>  {
>  	int error;
>  
> -	if (ctx->flags & ~(XATTR_CREATE|XATTR_REPLACE))
> +	if (ctx->flags & ~XATTR__FLAGS)
>  		return -EINVAL;
>  
>  	error = strncpy_from_user(ctx->kname->name, name,
> @@ -626,21 +628,31 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
>  	return error;
>  }
>  
> -static int path_setxattr(const char __user *pathname,
> +static int do_setxattrat(int dfd, const char __user *pathname,
>  			 const char __user *name, const void __user *value,
> -			 size_t size, int flags, unsigned int lookup_flags)
> +			 size_t size, int flags)
>  {
>  	struct path path;
>  	int error;
> +	int lookup_flags;
> +
> +	/* AT_ and XATTR_ flags must not overlap. */
> +	BUILD_BUG_ON(((AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH) & XATTR__FLAGS) != 0);
> +
> +	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | XATTR__FLAGS)) != 0)
> +		return -EINVAL;

It's a bit tasteless that we end up mixing AT_* and XATTR_* flags for sure.

>  
> +	lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
> +	if (flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
>  retry:
> -	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
> +	error = user_path_at(dfd, pathname, lookup_flags, &path);
>  	if (error)
>  		return error;
>  	error = mnt_want_write(path.mnt);
>  	if (!error) {
>  		error = setxattr(mnt_user_ns(path.mnt), path.dentry, name,
> -				 value, size, flags);
> +				 value, size, flags & XATTR__FLAGS);
>  		mnt_drop_write(path.mnt);
>  	}
>  	path_put(&path);
> @@ -651,18 +663,25 @@ static int path_setxattr(const char __user *pathname,
>  	return error;
>  }
>  
> +SYSCALL_DEFINE6(setxattrat, int, dfd, const char __user *, pathname,
> +		const char __user *, name, const void __user *, value,
> +		size_t, size, int, flags)
> +{
> +	return do_setxattrat(dfd, pathname, name, value, size, flags);
> +}

I'm not sure we need setxattrat()? Yes, it doesn't have a "pathname"
argument but imho it's not that big of a deal to first perform the
lookup via openat*() and then call fsetxattr() and have fsetxattr()
recognize AT_* flags. It's not that the xattr system calls are
lightweight in the first place.

But maybe the consistency is nicer. I have no strong feelings here.
