Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF213158FBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 14:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgBKNVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 08:21:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37876 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgBKNVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:21:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so6999610lfc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 05:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hr4RM1uoMUp4PqitGEd8DPH0BhvKXrOmDlEYhlDDK/I=;
        b=bFc+jsaX1bV6Bl3CuP+Cavm+epSok3Y8YuARU6618UpGWA+riHbOEsKSpMLVF0ZXnU
         bY7fqdQ0bEnWWZfLd6Oqd9qX1D757FrAYb+O8BaQ+LQhdXMTPs51Hy2WUXzJ4Ad24uj4
         cvUYk6SVn5+//nUOhXYL42dvCGwEwZFRn+X4g8zbG1FE0jal/OsaVU08xzOzzjWLIm0D
         8MwIcgxr3JmYIH/VoOmj8XDIQ6QhVzIhQMilukMtaXwupCH3WebHq6ULuGRH9rDVgw9o
         yY56NRlMCQ15lfK+PifbXajl/TM4KUteetaHmFwDIJm5VG8+ct0cSww9niJRGFLxEBTQ
         oHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hr4RM1uoMUp4PqitGEd8DPH0BhvKXrOmDlEYhlDDK/I=;
        b=PLocg2ZVAB5XnHcNkU7fo+janFw+e3WA2BZxq3FrjZi/ysou8p/ovvFZrj7z1m6xIF
         fyYqj52HbzTxRrtUE7eR2XhRaXti8caZqT2tbmGjqswpwhCiERh0yeUU3yWF4IuMpfOd
         qBK8jFZl7UqCs/r+xGhxnpwOrPDKEB4Nj1Lcnfjy10wFNKFfq5NDsn0uwbB4lqkW5yTy
         2FoJl9Yy3HZGubVLzfegAxJkqqPr21TBKB8iA7exCiiLHScSpdFKuhdaLzJ0zPADLx0I
         KzMVZW32tkD1aq8uAW/jbG9a+YwKKFxx7LGW3HF4Gvbsglw/h18X0iAbpeMK6pJNE9EV
         0Gxw==
X-Gm-Message-State: APjAAAUJb3JYVspT6lOobsn+xTPUmt/C3FBROZs8YxF0OuSlBhoAH8eU
        dlYw/ZbgOzwMqKUJse3UMYnKsA==
X-Google-Smtp-Source: APXvYqxV3rctot+0vYRe7IkamEeOz1L1i7WPyibLsi5dvBCjvN0112ivhIa5RgpfbLebu0hWGg8rAw==
X-Received: by 2002:a19:8c4d:: with SMTP id i13mr3655524lfj.42.1581427301828;
        Tue, 11 Feb 2020 05:21:41 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a8sm2166091ljn.74.2020.02.11.05.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:21:41 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id D76B5100AFB; Tue, 11 Feb 2020 16:21:59 +0300 (+03)
Date:   Tue, 11 Feb 2020 16:21:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 12/12] mm: dump_page(): additional diagnostics for
 huge pinned pages
Message-ID: <20200211132159.pii2x5pssifemgaz@box>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
 <20200211001536.1027652-13-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211001536.1027652-13-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:15:36PM -0800, John Hubbard wrote:
> As part of pin_user_pages() and related API calls, pages are
> "dma-pinned". For the case of compound pages of order > 1, the per-page
> accounting of dma pins is accomplished via the 3rd struct page in the
> compound page. In order to support debugging of any pin_user_pages()-
> related problems, enhance dump_page() so as to report the pin count
> in that case.
> 
> Documentation/core-api/pin_user_pages.rst is also updated accordingly.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  Documentation/core-api/pin_user_pages.rst |  7 +++++++
>  mm/debug.c                                | 21 ++++++++++++++++-----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
> index 5c8a5f89756b..2e939ff10b86 100644
> --- a/Documentation/core-api/pin_user_pages.rst
> +++ b/Documentation/core-api/pin_user_pages.rst
> @@ -238,6 +238,13 @@ long-term [R]DMA pins in place, or during pin/unpin transitions.
>  (...unless it was already out of balance due to a long-term RDMA pin being in
>  place.)
>  
> +Other diagnostics
> +=================
> +
> +dump_page() has been enhanced slightly, to handle these new counting fields, and
> +to better report on compound pages in general. Specifically, for compound pages
> +with order > 1, the exact (hpage_pinned_refcount) pincount is reported.
> +
>  References
>  ==========
>  
> diff --git a/mm/debug.c b/mm/debug.c
> index f5ffb0784559..2189357f0987 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -85,11 +85,22 @@ void __dump_page(struct page *page, const char *reason)
>  	mapcount = PageSlab(head) ? 0 : page_mapcount(page);
>  
>  	if (compound)
> -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
> -			"index:%#lx head:%px order:%u compound_mapcount:%d\n",
> -			page, page_ref_count(head), mapcount,
> -			mapping, page_to_pgoff(page), head,
> -			compound_order(head), compound_mapcount(page));
> +		if (hpage_pincount_available(page)) {
> +			pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
> +				"index:%#lx head:%px order:%u "
> +				"compound_mapcount:%d compound_pincount:%d\n",
> +				page, page_ref_count(head), mapcount,
> +				mapping, page_to_pgoff(page), head,
> +				compound_order(head), compound_mapcount(page),
> +				compound_pincount(page));
> +		} else {
> +			pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
> +				"index:%#lx head:%px order:%u "
> +				"compound_mapcount:%d\n",
> +				page, page_ref_count(head), mapcount,
> +				mapping, page_to_pgoff(page), head,
> +				compound_order(head), compound_mapcount(page));
> +		}

Have you considered using pr_cont() here. I guess it would be easier to
read.

You can use my Ack anyway.


>  	else
>  		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p index:%#lx\n",
>  			page, page_ref_count(page), mapcount,
> -- 
> 2.25.0
> 

-- 
 Kirill A. Shutemov
