Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0A4210EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhJDOIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 10:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhJDOIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:08:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7208C061745
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Oct 2021 07:06:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g41so71878604lfv.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Oct 2021 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I5iiIUW34DuiTSF34m8K0qNYgofVcVIOCi6xjuMFs7U=;
        b=3kKfkFlAkxuo4h6f/0sKIcUascSJ1EjVtDaSc8mCz0mj2hiSUImHVOKBixi4ZXJ1Zh
         nf3oKrJdV0S6Pjxbj5UOnRW+JUK37P29cFNoWpwkY+ELXLvLY3QOPFyCiQplYH+7NyR/
         7KDIsN0v0grmhqRZG0V+albGTp7C+A6aWp7F/Q7Nmv1l3SbrOr/YadY2efvoa0d7RoN3
         l9YCobpIhuudY2yGYUZgUxKeH4qrJ5IZ66fthZ2U1uASotK3VM9ZQqVGVkAymap7Vt0v
         se3xf6LlY331tb9U4q7FskeOEe46Hq3Gc6YXaTeoHVyURSV5iY32K76etywNbvy/qCIv
         mQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I5iiIUW34DuiTSF34m8K0qNYgofVcVIOCi6xjuMFs7U=;
        b=5n9mlQvxv8ZzKkMr3EpXq5bq2E+pDFNHHH0xrkEvFfmnBr+6nw1gCMBnAEpz5+yJWr
         3N/WMPcNgONio+bZSLkQ9boyvG1OgCcjvBoqvjOTYBuq2VlDGzx/lJTbb63Zfd3e9m7M
         MLGZAKzrB4Pq0BzjL6IfIHYmzxK4W53sOVJLQgsKssiPrAleKpwnceIhE95smReIFa1X
         3us1d7x6vxeyTBvKXYb7J3rZ4U9EcQnM3gdq/ZC4G8LWczajbGfhYG7m//c4V/ma+BPq
         wWvHDPaxMWeYXeUEVszayZjF+iavb5vvIrWnMUDgt0iEeaxj/vTdn9hHXjIB4lr88HEm
         IYpg==
X-Gm-Message-State: AOAM532vcK6XWk/zUZ1dmx6JUAO8kLhYfk7rnykdkM3DGNKNJd8q5Iv+
        m/36s/1QbO60kEzGxLUCwuK+uEyPZOhmuw==
X-Google-Smtp-Source: ABdhPJykedCpqepvR4UG4/lr+U/Wj7wVzLKNTIYtri7nFzzWco7d85ytJzGv0IGm0ILetCdz5mkUEQ==
X-Received: by 2002:a19:dc5b:: with SMTP id f27mr15017676lfj.145.1633356399534;
        Mon, 04 Oct 2021 07:06:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v27sm1770788lfp.0.2021.10.04.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:06:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C563710306D; Mon,  4 Oct 2021 17:06:37 +0300 (+03)
Date:   Mon, 4 Oct 2021 17:06:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index dae481293b5d..2acc2b977f66 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
>  	}
>  
>  	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> -	    vm_fault_t ret = do_set_pmd(vmf, page);
> -	    if (!ret) {
> -		    /* The page is mapped successfully, reference consumed. */
> -		    unlock_page(page);
> -		    return true;
> -	    }
> +		vm_fault_t ret = do_set_pmd(vmf, page);
> +		if (!ret) {
> +			/* The page is mapped successfully, reference consumed. */
> +			unlock_page(page);
> +			return true;
> +		}
>  	}
>  
>  	if (pmd_none(*vmf->pmd)) {

Hm. Is it unrelated whitespace fix?

-- 
 Kirill A. Shutemov
