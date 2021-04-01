Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F013E350FED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 09:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhDAHOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 03:14:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhDAHO1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:14:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617261266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EdG19ICQsbKOwlsiDe5wakN2BrS2LIAGNa7VKGcjnVQ=;
        b=fv8kcptpBLAQc0tJiNubXbf0ugKJ2hvWgVLLMJZ/0LAHZ/H7hmdcW6UwavgsRRuc8UxgRK
        uVOojLtyIhxNKuBsOGYqMKNXgag1BwBpmIwahMUC+Gy8wFkQmmFCaBhr0G2p/Uf6VRWUZI
        jXwMtTfR7cz/IFgxCLmpSKRX8t+hfs8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61E08AF4F;
        Thu,  1 Apr 2021 07:14:26 +0000 (UTC)
Date:   Thu, 1 Apr 2021 09:14:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sysfs: Unconditionally use vmalloc for buffer
Message-ID: <YGVy0WUG1OEFfjhx@dhcp22.suse.cz>
References: <20210401022145.2019422-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401022145.2019422-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-03-21 19:21:45, Kees Cook wrote:
> The sysfs interface to seq_file continues to be rather fragile
> (seq_get_buf() should not be used outside of seq_file), as seen with
> some recent exploits[1]. Move the seq_file buffer to the vmap area
> (while retaining the accounting flag), since it has guard pages that
> will catch and stop linear overflows.

I thought the previous discussion has led to a conclusion that the
preferred way is to disallow direct seq_file buffer usage. But this is
obviously up to sysfs maintainers. I am happy you do not want to spread
this out to all seq_file users anymore.

> This seems justified given that
> sysfs's use of seq_file already uses kvmalloc(), is almost always using
> a PAGE_SIZE or larger allocation, has normally short-lived allocations,
> and is not normally on a performance critical path.

Let me clarify on this, because this is not quite right. kvmalloc vs
vmalloc (both with GFP_KERNEL) on PAGE_SIZE are two different beasts.
The first one is almost always going to use kmalloc because the page
allocator almost never fails those requests.

> Once seq_get_buf() has been removed (and all sysfs callbacks using
> seq_file directly), this change can also be removed.
> 
> [1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3:
> - Limit to only sysfs (instead of all of seq_file).
> v2: https://lore.kernel.org/lkml/20210315174851.622228-1-keescook@chromium.org/
> v1: https://lore.kernel.org/lkml/20210312205558.2947488-1-keescook@chromium.org/
> ---
>  fs/sysfs/file.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 9aefa7779b29..70e7a450e5d1 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -16,6 +16,7 @@
>  #include <linux/mutex.h>
>  #include <linux/seq_file.h>
>  #include <linux/mm.h>
> +#include <linux/vmalloc.h>
>  
>  #include "sysfs.h"
>  
> @@ -32,6 +33,25 @@ static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
>  	return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
>  }
>  
> +/*
> + * To be proactively defensive against sysfs show() handlers that do not
> + * correctly stay within their PAGE_SIZE buffer, use the vmap area to gain
> + * the trailing guard page which will stop linear buffer overflows.
> + */
> +static void *sysfs_kf_seq_start(struct seq_file *sf, loff_t *ppos)
> +{
> +	struct kernfs_open_file *of = sf->private;
> +	struct kernfs_node *kn = of->kn;
> +
> +	WARN_ON_ONCE(sf->buf);
> +	sf->buf = __vmalloc(kn->attr.size, GFP_KERNEL_ACCOUNT);
> +	if (!sf->buf)
> +		return ERR_PTR(-ENOMEM);
> +	sf->size = kn->attr.size;
> +
> +	return NULL + !*ppos;
> +}
> +
>  /*
>   * Reads on sysfs are handled through seq_file, which takes care of hairy
>   * details like buffering and seeking.  The following function pipes
> @@ -206,14 +226,17 @@ static const struct kernfs_ops sysfs_file_kfops_empty = {
>  };
>  
>  static const struct kernfs_ops sysfs_file_kfops_ro = {
> +	.seq_start	= sysfs_kf_seq_start,
>  	.seq_show	= sysfs_kf_seq_show,
>  };
>  
>  static const struct kernfs_ops sysfs_file_kfops_wo = {
> +	.seq_start	= sysfs_kf_seq_start,
>  	.write		= sysfs_kf_write,
>  };
>  
>  static const struct kernfs_ops sysfs_file_kfops_rw = {
> +	.seq_start	= sysfs_kf_seq_start,
>  	.seq_show	= sysfs_kf_seq_show,
>  	.write		= sysfs_kf_write,
>  };
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
