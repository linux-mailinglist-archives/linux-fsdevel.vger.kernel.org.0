Return-Path: <linux-fsdevel+bounces-16136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1566899063
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F977B26BA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D851313BC3B;
	Thu,  4 Apr 2024 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d1g8oWeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC813BACF;
	Thu,  4 Apr 2024 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266165; cv=none; b=B9uwEs7oU4nGLGx+6/JrdS/s+og0nPtC15ZFquFGz7/SIZiv3QB74TXFdguVsz67pCg36SKXzX21EKPHqEEmFJPigp/np0wqxO6om0D5+FfSkqF95w0CvVJkvsXvbPvhNyUB0UXqnWdiP1PmQtt9Ko9JU3Ox1WCqqG8uIt9dQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266165; c=relaxed/simple;
	bh=Utj8g5kSIY2oZzcEMi6QXW1D/5gc1CLBmlqTBBy6/AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUlgkdjk/HlF00OSdbkpWs3XMJxNbiAFUWUv2D8E+Q6zKljZNBcRpaXfv9UXckj2USTSNtmNeA0BMnDivzGXhypZUXFhf2rcxJGcjozU8wv0kAJ6vkEIP5txtc1s2JT67+upBK/d4l2SHUJ45BVacJVuIlNxV/UE3C4PLxXKy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d1g8oWeT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zyi7AEcYnfqB6wuIN5C5labJ5TkiPsioxAOKz/6Fbqs=; b=d1g8oWeT9rYHBlZuF9xsTFDFHG
	4lSJo/KGw64j3qekI4UzOPIXJ1k3xqp49kuQDsjI3KWu1PeNyrvAx32gduojBtJnubIYbpR8ATH9/
	iHi0XgwD4MRWgBREvdk6kwWIJMIJufuG2rvsYSbhZahYCtFlqfUHZoB/9OG3i+HKLm5pf24AQ/JN2
	9SFsSEsuALRsGWBL8WIAgLr6AWItvY3OcojGDkbhHZsDqZ1XuYyScYDs1+aUQs9aWl8qV9+jLJ+tV
	tJCk+/43dla/bl5lv45MJp+W8A/geOJcFQ8gjN3XZ0JwVqHcOjoTgz3o0Y9HJuAjDwX2Jd5ldJTru
	2h94r9pw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsUe5-00000008veN-2BP2;
	Thu, 04 Apr 2024 21:29:17 +0000
Date: Thu, 4 Apr 2024 22:29:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: Set file_handle::handle_bytes before referencing
 file_handle::f_handle
Message-ID: <Zg8brYRFHlS1qaJC@casper.infradead.org>
References: <20240404211212.it.297-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404211212.it.297-kees@kernel.org>

On Thu, Apr 04, 2024 at 02:12:15PM -0700, Kees Cook wrote:
> Since __counted_by(handle_bytes) was added to struct file_handle, we need
> to explicitly set it in the one place it wasn't yet happening prior to
> accessing the flex array "f_handle". For robustness also check for a
> negative value for handle_bytes, which is possible for an "int", but
> nothing appears to set.

Why not change handle_bytes from an int to a u32?

Also, what a grotty function.

        handle_dwords = f_handle.handle_bytes >> 2;
...
        handle_bytes = handle_dwords * sizeof(u32);

> Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Jan Kara <jack@suse.cz>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
>  v2: more bounds checking, add comments, dropped reviews since logic changed
>  v1: https://lore.kernel.org/all/20240403215358.work.365-kees@kernel.org/
> ---
>  fs/fhandle.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 8a7f86c2139a..854f866eaad2 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -40,6 +40,11 @@ static long do_sys_name_to_handle(const struct path *path,
>  			 GFP_KERNEL);
>  	if (!handle)
>  		return -ENOMEM;
> +	/*
> +	 * Since handle->f_handle is about to be written, make sure the
> +	 * associated __counted_by(handle_bytes) variable is correct.
> +	 */
> +	handle->handle_bytes = f_handle.handle_bytes;
>  
>  	/* convert handle size to multiple of sizeof(u32) */
>  	handle_dwords = f_handle.handle_bytes >> 2;
> @@ -51,8 +56,8 @@ static long do_sys_name_to_handle(const struct path *path,
>  	handle->handle_type = retval;
>  	/* convert handle size to bytes */
>  	handle_bytes = handle_dwords * sizeof(u32);
> -	handle->handle_bytes = handle_bytes;
> -	if ((handle->handle_bytes > f_handle.handle_bytes) ||
> +	/* check if handle_bytes would have exceeded the allocation */
> +	if ((handle_bytes < 0) || (handle_bytes > f_handle.handle_bytes) ||
>  	    (retval == FILEID_INVALID) || (retval < 0)) {
>  		/* As per old exportfs_encode_fh documentation
>  		 * we could return ENOSPC to indicate overflow
> @@ -68,6 +73,8 @@ static long do_sys_name_to_handle(const struct path *path,
>  		handle_bytes = 0;
>  	} else
>  		retval = 0;
> +	/* the "valid" number of bytes may fewer than originally allocated */
> +	handle->handle_bytes = handle_bytes;
>  	/* copy the mount id */
>  	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
>  	    copy_to_user(ufh, handle,
> -- 
> 2.34.1
> 
> 

