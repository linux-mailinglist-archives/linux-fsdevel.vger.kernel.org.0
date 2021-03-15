Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE833AD98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 09:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhCOIei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 04:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:57426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhCOIeU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:34:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615797258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phRyt10+VL+z1gxzqJJqw/YH00WVPu/x2AOMGGvpvOw=;
        b=NRdQAMnyvBfbpXmJR81iZSCCoriJdNAw4M/ymiKmUekUZnUww1j/lr+SHvjo5fuKoVZV5F
        MNf/0uMiYIIE+K6OlarrKK2BDa1Y/sBusylisBLnf31IMoGExpGHAWs30xPKIj7P4BNEbN
        IgR6AaCcIwKwY0hQ6wyArU3dCcXKq+0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C60EFAC1D;
        Mon, 15 Mar 2021 08:34:18 +0000 (UTC)
Date:   Mon, 15 Mar 2021 09:34:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YE8cCslnGkgmKTsY@dhcp22.suse.cz>
References: <20210312205558.2947488-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312205558.2947488-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-03-21 12:55:58, Kees Cook wrote:
> The sysfs interface to seq_file continues to be rather fragile, as seen
> with some recent exploits[1]. Move the seq_file buffer to the vmap area
> (while retaining the accounting flag), since it has guard pages that
> will catch and stop linear overflows. This seems justified given that
> seq_file already uses kvmalloc(), that allocations are normally short
> lived, and that they are not normally performance critical.

What is the runtime effect of this change? The interface is widely used
for many other interfaces - e.g. in proc. While from the correctness POV
this should be OK (ish for 64b it is definitely problem for kernels with
lowmem and limited vmalloc space). Vmalloc is also to be expected to
regress in performance for small allocations which is the most usual
case.
 
> [1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/seq_file.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index cb11a34fb871..ad78577d4c2c 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -32,7 +32,7 @@ static void seq_set_overflow(struct seq_file *m)
>  
>  static void *seq_buf_alloc(unsigned long size)
>  {
> -	return kvmalloc(size, GFP_KERNEL_ACCOUNT);
> +	return __vmalloc(size, GFP_KERNEL_ACCOUNT);
>  }
>  
>  /**
> @@ -130,7 +130,7 @@ static int traverse(struct seq_file *m, loff_t offset)
>  
>  Eoverflow:
>  	m->op->stop(m, p);
> -	kvfree(m->buf);
> +	vfree(m->buf);
>  	m->count = 0;
>  	m->buf = seq_buf_alloc(m->size <<= 1);
>  	return !m->buf ? -ENOMEM : -EAGAIN;
> @@ -237,7 +237,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  			goto Fill;
>  		// need a bigger buffer
>  		m->op->stop(m, p);
> -		kvfree(m->buf);
> +		vfree(m->buf);
>  		m->count = 0;
>  		m->buf = seq_buf_alloc(m->size <<= 1);
>  		if (!m->buf)
> @@ -349,7 +349,7 @@ EXPORT_SYMBOL(seq_lseek);
>  int seq_release(struct inode *inode, struct file *file)
>  {
>  	struct seq_file *m = file->private_data;
> -	kvfree(m->buf);
> +	vfree(m->buf);
>  	kmem_cache_free(seq_file_cache, m);
>  	return 0;
>  }
> @@ -585,7 +585,7 @@ int single_open_size(struct file *file, int (*show)(struct seq_file *, void *),
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
