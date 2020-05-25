Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F161E063B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 06:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbgEYE7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 00:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgEYE7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 00:59:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84994C05BD43
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 21:59:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m18so19320048ljo.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 21:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+n9rUAP4H6+Zi0TTUL1JxYkv/zQYKpYIKNpCWjLtusE=;
        b=ZB2bMapTM0gZ3T/pJxS+tIAjDieTMBYojZ0mwW7XuuEWD+Fv+k1JtiyzD+ZqaBr9Tq
         lH8i3F7zAGGxPGXuTWnJm9Te/UUSV9cqtaEZZG7sQ1yVfu7pjqZXGmOZbQZ7YCEp6xBE
         4fm2u6hmW3kKMvvIu51nvAPRHQ46c4IKra087+r7Va256OtaGkLjwLkOorTUxEdBsAmr
         XnmXf6OmMz/WmDrnKLg6gDYFWdak47KotwHkuSZCX9HSmPFcHJci0FqyN7NN5ZdCVJP0
         hszBVumbnqx0pFYBFLzeidtDBQtf7eqEj0775nkJ1h0ho+RWfKdHcKpQ8ZBa7ee6WNl6
         rrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+n9rUAP4H6+Zi0TTUL1JxYkv/zQYKpYIKNpCWjLtusE=;
        b=Gkfxc+3GNAiT/EBQTFi1EGThWXxy6Oy9ior3qyFVfZcM9luHvD/3aPe8Jdl+/CrRhI
         5KsM0uWESA8J//FvtiQokLF0iXmMqXgmgq70me54/Fnr7ZwPaPKsJtVgdIK+Zbo5+eAa
         ZM0G4CV+4kB+5sQvNvOkXt+WGyIUuth9HjvfPAjf9JhEOjwpM4w4NR1nE5XDFGcNMVek
         Wgg1W86scruHLWMnFr0mcccH1seRyz5/YuDAONQsz0y0pwngBJAEHLVrmWyW1yhE55U0
         r2+M2GlUEOy9ltP8D/LqbKW1pSIIHzfV6p/vayrT4oTDlkteTM6thDZR7wYqT6sgxf7g
         iA3Q==
X-Gm-Message-State: AOAM533KAOXPwzjdwQrM19qAOA5hGm3Sn/A0uvdA2SWHsk9Tg4J5oPD1
        r3G0EN7+m0O1xWQOjMbceuwldA==
X-Google-Smtp-Source: ABdhPJyCwJ2sAx2IX4iHY4LLE2cNk9uJ0NgIZnJVby3cTBD/nQ12Uvgtsyf7i4RxGbVF7B8X5BKElQ==
X-Received: by 2002:a2e:9a41:: with SMTP id k1mr13615461ljj.143.1590382784839;
        Sun, 24 May 2020 21:59:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f5sm903566ljm.69.2020.05.24.21.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 21:59:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 367BE1012E6; Mon, 25 May 2020 07:59:45 +0300 (+03)
Date:   Mon, 25 May 2020 07:59:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 24/36] mm: Remove page fault assumption of compound
 page size
Message-ID: <20200525045945.lkw36jergxwg7bfj@box>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515131656.12890-25-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 06:16:44AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> A compound page in the page cache will not necessarily be of PMD size,
> so check explicitly.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/memory.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f703fe8c8346..d68ce428ddd2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3549,13 +3549,14 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>  	pmd_t entry;
>  	int i;
> -	vm_fault_t ret;
> +	vm_fault_t ret = VM_FAULT_FALLBACK;
>  
>  	if (!transhuge_vma_suitable(vma, haddr))
> -		return VM_FAULT_FALLBACK;
> +		return ret;
>  
> -	ret = VM_FAULT_FALLBACK;
>  	page = compound_head(page);
> +	if (page_order(page) != HPAGE_PMD_ORDER)
> +		return ret;

Maybe WARN() for page_order(page) > HPAGE_PMD_ORDER. It would be fun to
handle :P
>  
>  	/*
>  	 * Archs like ppc64 need additonal space to store information
> -- 
> 2.26.2
> 

-- 
 Kirill A. Shutemov
