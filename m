Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF92B33CFE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 09:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhCPIbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 04:31:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:52350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234850AbhCPIb0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:31:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615883484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pf+nc+lIl8kMGUiohYuj/WARbXesnkwspb9bTfbVJ5k=;
        b=fYCNUhM9G+jM/lC2L5iP8K5xwVZgD0e7S00eWqsagRV8vjV/eNF7/EreaylgS+j3v58FLk
        ZFoKRHFopLT2AoQ5/3F5eK4+CXvpp40b+R3w5snFN1cDy2vn2nLgUKo1TAIN4UMTZN328n
        ACb+akvRNm0HlEhhfSWrB6oHJo9cOxQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB7D9AE5C;
        Tue, 16 Mar 2021 08:31:24 +0000 (UTC)
Date:   Tue, 16 Mar 2021 09:31:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFBs202BqG9uqify@dhcp22.suse.cz>
References: <20210315174851.622228-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315174851.622228-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-03-21 10:48:51, Kees Cook wrote:
> The sysfs interface to seq_file continues to be rather fragile, as seen
> with some recent exploits[1]. Move the seq_file buffer to the vmap area
> (while retaining the accounting flag), since it has guard pages that
> will catch and stop linear overflows. This seems justified given that
> seq_file already uses kvmalloc(), is almost always using a PAGE_SIZE or
> larger allocation, has allocations are normally short lived, and is not
> normally on a performance critical path.

I have already objected without having my concerns really addressed.

Your observation that most of buffers are PAGE_SIZE in the vast majority
cases matches my experience and kmalloc should perform better than
vmalloc. You should check the most common /proc readers at least.

Also this cannot really be done for configurations with a very limited
vmalloc space (32b for example). Those systems are more and more rare
but you shouldn't really allow userspace to deplete the vmalloc space.

I would be also curious to see how vmalloc scales with huge number of
single page allocations which would be easy to trigger with this patch.

> [1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/seq_file.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index cb11a34fb871..16fb4a4e61e3 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -32,7 +32,12 @@ static void seq_set_overflow(struct seq_file *m)
>  
>  static void *seq_buf_alloc(unsigned long size)
>  {
> -	return kvmalloc(size, GFP_KERNEL_ACCOUNT);
> +	/*
> +	 * To be proactively defensive against buggy seq_get_buf() callers
> +	 * (i.e. sysfs handlers), use the vmap area to gain the trailing
> +	 * guard page which will protect against linear buffer overflows.
> +	 */
> +	return __vmalloc(size, GFP_KERNEL_ACCOUNT);
>  }
>  
>  /**
> @@ -130,7 +135,7 @@ static int traverse(struct seq_file *m, loff_t offset)
>  
>  Eoverflow:
>  	m->op->stop(m, p);
> -	kvfree(m->buf);
> +	vfree(m->buf);
>  	m->count = 0;
>  	m->buf = seq_buf_alloc(m->size <<= 1);
>  	return !m->buf ? -ENOMEM : -EAGAIN;
> @@ -237,7 +242,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  			goto Fill;
>  		// need a bigger buffer
>  		m->op->stop(m, p);
> -		kvfree(m->buf);
> +		vfree(m->buf);
>  		m->count = 0;
>  		m->buf = seq_buf_alloc(m->size <<= 1);
>  		if (!m->buf)
> @@ -349,7 +354,7 @@ EXPORT_SYMBOL(seq_lseek);
>  int seq_release(struct inode *inode, struct file *file)
>  {
>  	struct seq_file *m = file->private_data;
> -	kvfree(m->buf);
> +	vfree(m->buf);
>  	kmem_cache_free(seq_file_cache, m);
>  	return 0;
>  }
> @@ -585,7 +590,7 @@ int single_open_size(struct file *file, int (*show)(struct seq_file *, void *),
>  		return -ENOMEM;
>  	ret = single_open(file, show, data);
>  	if (ret) {
> -		kvfree(buf);
> +		vfree(buf);
>  		return ret;
>  	}
>  	((struct seq_file *)file->private_data)->buf = buf;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
