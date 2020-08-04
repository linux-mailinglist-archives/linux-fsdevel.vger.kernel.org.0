Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7056E23C145
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 23:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHDVQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 17:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHDVQK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:16:10 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F9C20792;
        Tue,  4 Aug 2020 21:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596575770;
        bh=6y7RE+hgDgrNRFsLnMe7+1bqyOR9ko768+Vm0y40/zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2dGU1wdwMijDDQjOhfIgAuo8XXz6zJkha4owe9yHW7H84Vw9FkNIGAfD5N+iOuPq
         2DhtL2Bn3pyGZZTgVRsrQ8g3DXPFqSpftVVfSGHjN24kNHIrFMwkPilNS4mrwEP4l0
         IOv43Qv7qCRti04OcpT9ta5lHI05EPA7eqtDWvjM=
Date:   Tue, 4 Aug 2020 14:16:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Subject: Re: [PATCH v5 3/3] Wire UFFD up to SELinux
Message-ID: <20200804211608.GC1992048@gmail.com>
References: <20200326200634.222009-1-dancol@google.com>
 <20200401213903.182112-1-dancol@google.com>
 <20200401213903.182112-4-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401213903.182112-4-dancol@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 02:39:03PM -0700, Daniel Colascione wrote:
> This change gives userfaultfd file descriptors a real security
> context, allowing policy to act on them.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>  fs/userfaultfd.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 37df7c9eedb1..78ff5d898733 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -76,6 +76,8 @@ struct userfaultfd_ctx {
>  	bool mmap_changing;
>  	/* mm with one ore more vmas attached to this userfaultfd_ctx */
>  	struct mm_struct *mm;
> +	/* The inode that owns this context --- not a strong reference.  */
> +	const struct inode *owner;
>  };

Adding this field seems wrong.  There's no reference held to it, so it can only
be used if the caller holds a reference to the inode anyway.  The only user of
this field is via userfafultfd_read(), so why not just use the inode of the
struct file passed to userfaultfd_read()?

>  SYSCALL_DEFINE1(userfaultfd, int, flags)
>  {
> +	struct file *file;
>  	struct userfaultfd_ctx *ctx;
>  	int fd;
>  
> @@ -1974,8 +1979,25 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	/* prevent the mm struct to be freed */
>  	mmgrab(ctx->mm);
>  
> -	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
> -			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
> +	file = anon_inode_getfile_secure(
> +		"[userfaultfd]", &userfaultfd_fops, ctx,
> +		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
> +		NULL);
> +	if (IS_ERR(file)) {
> +		fd = PTR_ERR(file);
> +		goto out;
> +	}
> +
> +	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
> +	if (fd < 0) {
> +		fput(file);
> +		goto out;
> +	}
> +
> +	ctx->owner = file_inode(file);
> +	fd_install(fd, file);
> +
> +out:
>  	if (fd < 0) {
>  		mmdrop(ctx->mm);
>  		kmem_cache_free(userfaultfd_ctx_cachep, ctx);

What's the point of anon_inode_getfile_secure()?  anon_inode_getfd_secure()
would work here too.

- Eric
