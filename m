Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB36434B9B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhC0V5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 17:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230439AbhC0V5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 17:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616882229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bj/1bcBSUwlXPODMgK+7TR54EtYdkqxCKK5SCH5Eb+k=;
        b=XLvTBm0Nf2uQsVEG/xRWsz9KrubmRdjjXaGHwFrYRa8CiFsm5G9oo0vhRAJjdvWKvZv0z4
        0pIOUlz3q3XTk9ZYSvutWr6WYrIYy72kTZ8O6r0qGZhAkrLNF8ux4WJKUtprPHd02IpR8k
        vvqZfK8Zi3e2RlMgFcmkjS9gZawRUx0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-AQI4Cai3NXquq2tQK4RouA-1; Sat, 27 Mar 2021 17:57:08 -0400
X-MC-Unique: AQI4Cai3NXquq2tQK4RouA-1
Received: by mail-qv1-f69.google.com with SMTP id bt20so8398161qvb.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Mar 2021 14:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bj/1bcBSUwlXPODMgK+7TR54EtYdkqxCKK5SCH5Eb+k=;
        b=SVPN38P2iTTsd6eJdEvW69de24bQe5nSlXOyiACB71DHhLuNrfRyVEYgWiA04kItFM
         LZIwLTEGatdP9sjfwfMpll51waaWZTh3hafj2WqVgQDjn9kFNG6takkn8Kn3Mab11J22
         Ch2d8ajOyzLj2fdOo1olJCcPRn4g4gM2cSO+HdEbVlNQZAjBbt3TE+xIEUbcROzsOp9y
         bqj/dUAbpOOvWrzDlpPOs2s5EGl9IRCaOuO24OnEZyCBvzTM0B1wmNmcgUpT7nxqBmLs
         tXQ2mywM2h71AQH7YKV5cTwB9eZpTIEdMI9r99l30saHtb+KL+qJAzjz5BopIQLFXxDs
         IXHg==
X-Gm-Message-State: AOAM5329410Y2B/9XxSmwmuCVUmGFe/wHLDKlQLnZhmqCCv8+UH7F4aS
        GrNGd26Yc3Il4FQ4GoRRt9dw/UBER8CW5AsKUQvWAK/DOEJaQxHQTMdn4Dcx+C+N1mM6SkYKV8a
        DkccG7GADB7QUv06To+OF8+o86Q==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr19301673qkm.355.1616882227417;
        Sat, 27 Mar 2021 14:57:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCJKaSGSlzQNoXwiiYL1bXbPYCri/xP97a1UnyExgW9n9/TCZ5ehH0OYORnNJ3nuDDuOgj8A==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr19301653qkm.355.1616882227094;
        Sat, 27 Mar 2021 14:57:07 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id t24sm8185897qto.23.2021.03.27.14.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 14:57:06 -0700 (PDT)
Date:   Sat, 27 Mar 2021 17:57:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTNUE error
 handling + accounting
Message-ID: <20210327215703.GA429942@xz-x1>
References: <20210325231027.3402321-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325231027.3402321-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Axel,

On Thu, Mar 25, 2021 at 04:10:27PM -0700, Axel Rasmussen wrote:
> Previously, in the error path, we unconditionally removed the page from
> the page cache. But in the continue case, we didn't add it - it was
> already there because the page is used by a second (non-UFFD-registered)
> mapping. So, in that case, it's incorrect to remove it as the other
> mapping may still use it normally.
> 
> For this error handling failure, trivially exercise it in the
> userfaultfd selftest, to detect this kind of bug in the future.
> 
> Also, we previously were unconditionally calling shmem_inode_acct_block.
> In the continue case, however, this is incorrect, because we would have
> already accounted for the RAM usage when the page was originally
> allocated (since at this point it's already in the page cache). So,
> doing it in the continue case causes us to double-count.
> 
> Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/shmem.c                               | 15 ++++++++++-----
>  tools/testing/selftests/vm/userfaultfd.c | 12 ++++++++++++
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d2e0e81b7d2e..5ac8ea737004 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2379,9 +2379,11 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	int ret;
>  	pgoff_t offset, max_off;
>  
> -	ret = -ENOMEM;
> -	if (!shmem_inode_acct_block(inode, 1))

IMHO a better change here is to only touch this line into:

        if (!is_continue && !shmem_inode_acct_block(inode, 1))

Then you don't need to touch any other line, also you can drop line [1] below
too as a side benefit.

> -		goto out;
> +	if (!is_continue) {
> +		ret = -ENOMEM;
> +		if (!shmem_inode_acct_block(inode, 1))
> +			goto out;
> +	}
>  
>  	if (is_continue) {
>  		ret = -EFAULT;
> @@ -2389,6 +2391,7 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  		if (!page)
>  			goto out_unacct_blocks;
>  	} else if (!*pagep) {
> +		ret = -ENOMEM;

[1]

>  		page = shmem_alloc_page(gfp, info, pgoff);
>  		if (!page)
>  			goto out_unacct_blocks;
> @@ -2486,12 +2489,14 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  out_release_unlock:
>  	pte_unmap_unlock(dst_pte, ptl);
>  	ClearPageDirty(page);

Should this be conditional too?  IIUC this will clear dirty for the page cache
even if it was dirty.  I'm not sure whether it'll cause data loss.

> -	delete_from_page_cache(page);
> +	if (!is_continue)
> +		delete_from_page_cache(page);
>  out_release:
>  	unlock_page(page);
>  	put_page(page);
>  out_unacct_blocks:
> -	shmem_inode_unacct_blocks(inode, 1);
> +	if (!is_continue)
> +		shmem_inode_unacct_blocks(inode, 1);
>  	goto out;
>  }

Besides the error handling, I looked at the function again and I have another
two thoughts:

1. IMHO in shmem_mcopy_atomic_pte() we should also conditionally call
   pte_mkwrite() just like the hugetlb code too, so as to keep W bit clear when
   !VM_SHARED.

2. I see even more "if (!is_continue)" here.. I'm thinking whether we can
   simply jump to pte installation "if (is_continue)" instead, because
   uffdio-continue shoiuld really be a lightweight operation.

   E.g., most of the things at the middle of the function is not relevant to
   uffd-continue.  To be explicit:

	ret = -EFAULT;
	offset = linear_page_index(dst_vma, dst_addr);
	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
	if (unlikely(offset >= max_off))
		goto out_release;

   These chunk can be put into !is_continue too, then if you see you're
   bypassing mostly everything.  Then error handling of uffdio-continue would
   be simple too, since it could only fail if either page cache not exist, or
   pte changed.  Nothing else could happen.

For above point (1), I even start to doubt whether we should conditionally
grant the write bit for normal uffdio_copy case only if both WRITE|SHARED set
for the vma flags. E.g., shmem_mcopy_atomic_pte() of a normal uffdio-copy will
fill in the page cache into pte, however what if this mapping is privately
mapped?  IMHO we can't apply write bit otherwise the process will be writting
to the page cache directly.

However I think that question will be irrelevant to this patch.

Thanks,

-- 
Peter Xu

