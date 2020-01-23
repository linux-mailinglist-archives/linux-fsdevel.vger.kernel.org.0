Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F515146754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 12:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAWL4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 06:56:21 -0500
Received: from ozlabs.org ([203.11.71.1]:38191 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWL4V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:56:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 483LMf5wWGz9sRl;
        Thu, 23 Jan 2020 22:56:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579780577;
        bh=UovATE1i4RpVC/VrqLzFv3e4N/nnRhe7v5C5tuu556A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PsAOPoqnEkBhDZvT6xRmVeG1ZkgZd+qP9Jyv+LszgXRlTyk7MopH4Fnv/iq5IWdov
         QZzOwON1X9Jzz90ght1caGt2oNeFtBKwOE+4WgQJhx5o3IDQWb7Ugatw3ZYt2UFnZm
         UTSc5wuOHq2u4HWG6eIFf3EedbwVrq8xCQgiqa+UOlxForADFD33MC56cPcSeAvQlf
         8bnY+ta6n/k7rXXfL4dpMBuzYx8gHMpF+jlCs+tMCPIrtEBEr/75L+qXq9U4KtpSNJ
         y3vhPNxyNjh6ekeyzPAnyKsXqIajzD8FwBkZ+qCAwoG5mw2MSxuJDRrHsJHdVw8/H4
         jaypJxGjAOARg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
In-Reply-To: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
Date:   Thu, 23 Jan 2020 22:56:11 +1100
Message-ID: <87muaeidyc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christophe,

This patch is independent of the rest of the series AFAICS, and it looks
like Linus has modified it quite a bit down thread.

So I'll take patches 2-6 via powerpc and assume this patch will go via
Linus or Al or elsewhere.

Also a couple of minor spelling fixes below.

cheers

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Some architectures grand full access to userspace regardless of the
                     ^
                     grant
> address/len passed to user_access_begin(), but other architectures
> only grand access to the requested area.
       ^
       grant
>
> For exemple, on 32 bits powerpc (book3s/32), access is granted by
      ^
      example
> segments of 256 Mbytes.
>
> Modify filldir() and filldir64() to request the real area they need
> to get access to, i.e. the area covering the parent dirent (if any)
> and the contiguous current dirent.
>
> Fixes: 9f79b78ef744 ("Convert filldir[64]() from __put_user() to unsafe_put_user()")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v2: have user_access_begin() cover both parent dirent (if any) and current dirent
> ---
>  fs/readdir.c | 50 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/fs/readdir.c b/fs/readdir.c
> index d26d5ea4de7b..3f9b4488d9b7 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -214,7 +214,7 @@ struct getdents_callback {
>  static int filldir(struct dir_context *ctx, const char *name, int namlen,
>  		   loff_t offset, u64 ino, unsigned int d_type)
>  {
> -	struct linux_dirent __user * dirent;
> +	struct linux_dirent __user * dirent, *dirent0;
>  	struct getdents_callback *buf =
>  		container_of(ctx, struct getdents_callback, ctx);
>  	unsigned long d_ino;
> @@ -232,19 +232,22 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
>  		buf->error = -EOVERFLOW;
>  		return -EOVERFLOW;
>  	}
> -	dirent = buf->previous;
> -	if (dirent && signal_pending(current))
> +	dirent0 = buf->previous;
> +	if (dirent0 && signal_pending(current))
>  		return -EINTR;
>  
> -	/*
> -	 * Note! This range-checks 'previous' (which may be NULL).
> -	 * The real range was checked in getdents
> -	 */
> -	if (!user_access_begin(dirent, sizeof(*dirent)))
> -		goto efault;
> -	if (dirent)
> -		unsafe_put_user(offset, &dirent->d_off, efault_end);
>  	dirent = buf->current_dir;
> +	if (dirent0) {
> +		int sz = (void __user *)dirent + reclen -
> +			 (void __user *)dirent0;
> +
> +		if (!user_access_begin(dirent0, sz))
> +			goto efault;
> +		unsafe_put_user(offset, &dirent0->d_off, efault_end);
> +	} else {
> +		if (!user_access_begin(dirent, reclen))
> +			goto efault;
> +	}
>  	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
>  	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
>  	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
> @@ -307,7 +310,7 @@ struct getdents_callback64 {
>  static int filldir64(struct dir_context *ctx, const char *name, int namlen,
>  		     loff_t offset, u64 ino, unsigned int d_type)
>  {
> -	struct linux_dirent64 __user *dirent;
> +	struct linux_dirent64 __user *dirent, *dirent0;
>  	struct getdents_callback64 *buf =
>  		container_of(ctx, struct getdents_callback64, ctx);
>  	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
> @@ -319,19 +322,22 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
>  	buf->error = -EINVAL;	/* only used if we fail.. */
>  	if (reclen > buf->count)
>  		return -EINVAL;
> -	dirent = buf->previous;
> -	if (dirent && signal_pending(current))
> +	dirent0 = buf->previous;
> +	if (dirent0 && signal_pending(current))
>  		return -EINTR;
>  
> -	/*
> -	 * Note! This range-checks 'previous' (which may be NULL).
> -	 * The real range was checked in getdents
> -	 */
> -	if (!user_access_begin(dirent, sizeof(*dirent)))
> -		goto efault;
> -	if (dirent)
> -		unsafe_put_user(offset, &dirent->d_off, efault_end);
>  	dirent = buf->current_dir;
> +	if (dirent0) {
> +		int sz = (void __user *)dirent + reclen -
> +			 (void __user *)dirent0;
> +
> +		if (!user_access_begin(dirent0, sz))
> +			goto efault;
> +		unsafe_put_user(offset, &dirent0->d_off, efault_end);
> +	} else {
> +		if (!user_access_begin(dirent, reclen))
> +			goto efault;
> +	}
>  	unsafe_put_user(ino, &dirent->d_ino, efault_end);
>  	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
>  	unsafe_put_user(d_type, &dirent->d_type, efault_end);
> -- 
> 2.25.0
