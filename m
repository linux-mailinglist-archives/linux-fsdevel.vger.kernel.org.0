Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD62164CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 05:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgGGDne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 23:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgGGDne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:43:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8331C061755
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 20:43:33 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w17so33102688oie.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2020 20:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=c+m2RoLjPYbLg9a72QYT/s6oG2otjr54TDQZEh71EpE=;
        b=qnS1m895NYY2bNeQVaC1D4VXzrCXekz9bz+6vnIapPapUbel9BRC5VyY2y287eM05g
         GNH+TmkqcJb/nlczwypD+oXyh8PgBDZz9ABoZ+U0D7FnMb9RGgsYd1hYSLAwDMcC9qTo
         BEiJzVacUzS9mS8rnXaZmlNze8AUTsePLkdxhN9JnFpdBfDJ1jnVoharoZGcO00gciUw
         zeTqLVV07S8SiYOutN4ECrtzeBBSLCNbP0kwPa8mAiDRxgcoBAs+r9tNckQ1JtfpoMom
         GoGdstdomn8yyR44yneNGzfhjANV10Moh9+IzVNraoaxKIgW15k+eEmtqvrGBNfTs3vW
         tyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=c+m2RoLjPYbLg9a72QYT/s6oG2otjr54TDQZEh71EpE=;
        b=mlPl3fAivihfVwOi38RBQNLkNh8htV6TjEMBJAYxu+Ng9VlYswUQdnulFNr/52jift
         QVS/RIiPduf7vOSQOCYtpdRdca7YPpJlt7WfMN9SYdV5XH/IyKTM5wkD3T6tLgdAggra
         3wSS77QGIuefkSSaYUJOeJ5tyJGnexbpjohabJbNZvHtrzz7zNpRphdfLiXoODzFOp4c
         wLVwNaTGWw0qRfKI1tow5RksSxuAPQ58/43gy5E6mL1SQ5P1aJUfS01y5N7yAEyW3Ro6
         KRO7RHKx/CHuKwRHDYnjgfZGYWZN56+cGJUwK0JIaI327x+PEq4fHwwUQQfcC8dIKMUg
         f+kw==
X-Gm-Message-State: AOAM531SWGGcJ/L0hXo1sXiNEZnPn7dIYSW9W6BuvHarQlzTvO71YFKc
        leMh3aRG99D4JCuyicWyRvPKzg==
X-Google-Smtp-Source: ABdhPJwRYTSEFY7Y46q8N3TkR9zuj81PcjEhB+2DZ4MNxmcML1V5raPiD+vzEnjydKBqs3kgorP6HQ==
X-Received: by 2002:aca:ec16:: with SMTP id k22mr1869455oih.28.1594093413026;
        Mon, 06 Jul 2020 20:43:33 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z14sm5712837ooz.17.2020.07.06.20.43.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2020 20:43:32 -0700 (PDT)
Date:   Mon, 6 Jul 2020 20:43:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] Use multi-index entries in the page cache
In-Reply-To: <20200706185000.GC25523@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2007062022130.2346@eggly.anvils>
References: <20200629152033.16175-1-willy@infradead.org> <alpine.LSU.2.11.2007041206270.1056@eggly.anvils> <20200706144320.GB25523@casper.infradead.org> <20200706185000.GC25523@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Jul 2020, Matthew Wilcox wrote:
> 
> @@ -841,6 +842,7 @@ static int __add_to_page_cache_locked(struct page *page,
>                 nr = thp_nr_pages(page);
>         }
>  
> +       VM_BUG_ON_PAGE(xa_load(&mapping->i_pages, offset + nr) == page, page);
>         page_ref_add(page, nr);
>         page->mapping = mapping;
>         page->index = offset;
> @@ -880,6 +882,7 @@ static int __add_to_page_cache_locked(struct page *page,
>                 goto error;
>         }
>  
> +       VM_BUG_ON_PAGE(xa_load(&mapping->i_pages, offset + nr) == page, page);
>         trace_mm_filemap_add_to_page_cache(page);
>         return 0;
>  error:
> 
> The second one triggers with generic/051 (running against xfs with the
> rest of my patches).  So I deduce that we have a shadow entry which
> takes up multiple indices, then when we store the page, we now have
> a multi-index entry which refers to a single page.  And this explains
> basically all the accounting problems.

I think you are jumping too far ahead by bringing in xfs and your
later patches.  Don't let me stop you from thinking ahead, but the
problem at hand is with tmpfs.

tmpfs doesn't use shadow entries, or not where we use the term "shadow"
for workingset business: it does save swap entries as xarray values,
but I don't suppose the five xfstests I was running get into swap
(without applying additional pressure); and (since a huge page
gets split before shmem swapout, at present anyway) I don't see
a philosophical problem about their multi-index entries.

Multi-index shadows, sorry, not a subject I can think about at present.

> 
> Now I'm musing how best to fix this.
> 
> 1. When removing a compound page from the cache, we could store only
> a single entry.  That seems bad because we cuold hit somewhere else in
> the compound page and we'd have the wrong information about workingset
> history (or worse believe that a shmem page isn't in swap!)
> 
> 2. When removing a compound page from the cache, we could split the
> entry and store the same entry N times.  Again, this seems bad for shmem
> because then all the swap entries would be the same, and we'd fetch the
> wrong data from swap.
> 
> 3 & 4. When adding a page to the cache, we delete any shadow entry which was
> previously there, or replicate the shadow entry.  Same drawbacks as the
> above two, I feel.
> 
> 5. Use the size of the shadow entry to allocate a page of the right size.
> We don't currently have an API to find the right size, so that would
> need to be written.  And what do we do if we can't allocate a page of
> sufficient size?
> 
> So that's five ideas with their drawbacks as I see them.  Maybe you have
> a better idea?
> 
