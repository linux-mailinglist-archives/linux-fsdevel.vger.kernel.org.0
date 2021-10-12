Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F85429B39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 03:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhJLB7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 21:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhJLB7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634003834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z1mp2JWM4YiVwlRlVLQCKfDNv4dQeC/M1PO4QIwth7g=;
        b=SaCL6njIzDO1nJLVVU3FS3qX1gbSjo3nRCNmX/KKmtSAchTVjFuCS0OI4XwwE/f3MreDLi
        Tz2cA1jAFypKV7r9dts8NuZlh7kRW8gEATC97UIo6uw+HG9fDBke1E86zfdYAIyffC6v3t
        nRfXnkMX+HrBFieup5tkb8CidYGXEfk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-SrjLrecMOzmBMPdi0eKL6Q-1; Mon, 11 Oct 2021 21:57:14 -0400
X-MC-Unique: SrjLrecMOzmBMPdi0eKL6Q-1
Received: by mail-pf1-f199.google.com with SMTP id v13-20020a056a00148d00b0044ccf66dbd1so5570381pfu.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 18:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z1mp2JWM4YiVwlRlVLQCKfDNv4dQeC/M1PO4QIwth7g=;
        b=DCcHutwjRY9CkcRrrzw9nCjQ6L/nDsjvqzEL0Z9FKK8PblUqBKYM7e/HCTgTURL9jr
         2hQoFFerisJnjj6BSt3imrvhToxm2UX0J/5q72kj4LMMtY7qO/ttq+V5HB+Nqya19vNp
         omc48NIfrmXe3OVcpojKIEUizpiFL7lIJototwTQ8ExOy6SgufXicJ4hJtdMD6MvaxoR
         xkS9h/iAHbI6Zr/OxaxkCpqgQMQ5KqCznjnJ6VsSaNBKsCnC5Cqg+l7izUkdYThKa7cv
         Q9eaZWjkUMXPAqbezdtDQUDjag6KIvl30CB5/7/wnubYnTDOkhosyGqExdEamLsXkase
         HhZg==
X-Gm-Message-State: AOAM530DrQqP2xnIXa73NKJSGvigpb6ZAqTeXE6kGftrJZXqAVZtYvYQ
        IBEDCgRQy8PrFzgexqYEN4XkEwszPFa6RQBbJdpYeFAxekL45DQmZ4alx1kKhMIgwR/myhEH/8b
        7epJd+z3L9ThWjqFIZYZDJYeJjw==
X-Received: by 2002:aa7:9884:0:b0:44c:4c1f:6e6 with SMTP id r4-20020aa79884000000b0044c4c1f06e6mr29290662pfl.57.1634003830910;
        Mon, 11 Oct 2021 18:57:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoY/Xa4Xw7ivczlmO9ms2t13BWtRuBIDKwNXoKSSChisi8+RUQEKHw9Ho6XNS5pE3+tIDo/g==
X-Received: by 2002:aa7:9884:0:b0:44c:4c1f:6e6 with SMTP id r4-20020aa79884000000b0044c4c1f06e6mr29290627pfl.57.1634003830485;
        Mon, 11 Oct 2021 18:57:10 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b23sm9193853pfi.135.2021.10.11.18.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 18:57:09 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:57:02 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 4/5] mm: shmem: don't truncate page if memory failure
 happens
Message-ID: <YWTrbgf0kpwayWHL@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-5-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-5-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:10PM -0700, Yang Shi wrote:
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 88742953532c..75c36b6a405a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  	struct inode *inode = mapping->host;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	pgoff_t index = pos >> PAGE_SHIFT;
> +	int ret = 0;
>  
>  	/* i_rwsem is held by caller */
>  	if (unlikely(info->seals & (F_SEAL_GROW |
> @@ -2466,7 +2467,17 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  			return -EPERM;
>  	}
>  
> -	return shmem_getpage(inode, index, pagep, SGP_WRITE);
> +	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> +
> +	if (*pagep) {
> +		if (PageHWPoison(*pagep)) {
> +			unlock_page(*pagep);
> +			put_page(*pagep);
> +			ret = -EIO;
> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  static int
> @@ -2555,6 +2566,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  			unlock_page(page);
>  		}
>  
> +		if (page && PageHWPoison(page)) {
> +			error = -EIO;
> +			break;
> +		}
> +
>  		/*
>  		 * We must evaluate after, since reads (unlike writes)
>  		 * are called without i_rwsem protection against truncate

[...]

> @@ -4193,6 +4216,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>  		page = ERR_PTR(error);
>  	else
>  		unlock_page(page);
> +
> +	if (PageHWPoison(page))
> +		page = ERR_PTR(-EIO);
> +
>  	return page;
>  #else
>  	/*
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 7a9008415534..b688d5327177 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -233,6 +233,11 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
>  		goto out;
>  	}
>  
> +	if (PageHWPoison(page)) {
> +		ret = -EIO;
> +		goto out_release;
> +	}
> +
>  	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
>  				       page, false, wp_copy);
>  	if (ret)
> -- 
> 2.26.2
> 

These are shmem_getpage_gfp() call sites:

  shmem_getpage[151]             return shmem_getpage_gfp(inode, index, pagep, sgp,
  shmem_fault[2112]              err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, SGP_CACHE,
  shmem_read_mapping_page_gfp[4188] error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,

These are further shmem_getpage() call sites:

  collapse_file[1735]            if (shmem_getpage(mapping->host, index, &page,
  shmem_undo_range[965]          shmem_getpage(inode, start - 1, &page, SGP_READ);
  shmem_undo_range[980]          shmem_getpage(inode, end, &page, SGP_READ);
  shmem_write_begin[2467]        return shmem_getpage(inode, index, pagep, SGP_WRITE);
  shmem_file_read_iter[2544]     error = shmem_getpage(inode, index, &page, sgp);
  shmem_fallocate[2733]          error = shmem_getpage(inode, index, &page, SGP_FALLOC);
  shmem_symlink[3079]            error = shmem_getpage(inode, 0, &page, SGP_WRITE);
  shmem_get_link[3120]           error = shmem_getpage(inode, 0, &page, SGP_READ);
  mcontinue_atomic_pte[235]      ret = shmem_getpage(inode, pgoff, &page, SGP_READ);

Wondering whether this patch covered all of them.

This also reminded me that whether we should simply fail shmem_getpage_gfp()
directly, then all above callers will get a proper failure, rather than we do
PageHWPoison() check everywhere?

-- 
Peter Xu

