Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C440C493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhIOLvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 07:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhIOLvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:51:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D219C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 04:49:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y28so5651004lfb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yo03e49CSM9e+sK2Ar3YFN6XJZsOWYWg58Boo0XuPOY=;
        b=EjiA6mw4cOgTCrsZ4wG5YPQVw0KdpgFKDidA3coOJ1TctrxAlsxb4bTKXkWhXW3bFI
         z93vhuPvtmANlqMzJ9Xlao4VpnQsiVIdXvVjSuweUxhvHsYiWQ/neKkNQvFBbfcsdXH4
         VhGZgQLK/QprQylx1ftGhTBlbEXVUHOkfEkat9GxVvLsh7rVyoMjTZWUKYCE1U2MPrpg
         tGQaqtCg1iEQZIlUAxToJATzU0vJEFvj23sAjtv/hlGTcLKw38i3InV9n3deIGUXGidG
         DZZwFW0WmfSkLcorhH/vuI8qpcT6QRsRD21uNZzUUefSum5BEbTKUfx6YOFMorVEbzBb
         jSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yo03e49CSM9e+sK2Ar3YFN6XJZsOWYWg58Boo0XuPOY=;
        b=RLUMeTQhtRZ1LNse2qu617gmUkqjgy1G9JA9mBFvQCC4cX4SbrUpmiKu3cmffR6mL0
         xsV6fn08sTWC26yJUyK7YScPL6tZhd8GbAKvmSU+yZXBiW7HYb4K8dQpkJzsxHjFId9o
         TZUQoYk75/lLnGO3U4HlQZooLdhQcFgqb++StD5I60ueCkaTwnYNCfBc2ZovbdIvp88p
         aAEbkx6ikybYzvcA4YugRh6dXL8WZrz9lZoWvTxY3xmIw43215f8dWB/NIeDb5apO2cH
         s1St5zLeeazmLVS19+D6mKCvHTJcydWT999UGBvcVZqcw124HuHVF0r4hasteqq3nAFf
         rWkw==
X-Gm-Message-State: AOAM531Y4/XImacaY11K8hIIHTtEz9RdoOxZftJ/ybROzy61BjCVcyFo
        wZy3HtMzvA3VdjWWimuUut6QwL9mGCVuNw==
X-Google-Smtp-Source: ABdhPJwJEJa29YCPvHcMHB5ACnZWwPdD9bhSmcU/6aodYg9lHsPZ93xQzZ5mfv3kz6pEGsgCg/Bu5A==
X-Received: by 2002:ac2:48bc:: with SMTP id u28mr17390054lfg.370.1631706584674;
        Wed, 15 Sep 2021 04:49:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z5sm1665264ljz.23.2021.09.15.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 04:49:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ADFE1102F4D; Wed, 15 Sep 2021 14:49:47 +0300 (+03)
Date:   Wed, 15 Sep 2021 14:49:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: khugepaged: check if file page is on LRU after
 locking page
Message-ID: <20210915114947.2zh7inouztenth6o@box.shutemov.name>
References: <20210914183718.4236-1-shy828301@gmail.com>
 <20210914183718.4236-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914183718.4236-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:37:16AM -0700, Yang Shi wrote:
> The khugepaged does check if the page is on LRU or not but it doesn't
> hold page lock.  And it doesn't check this again after holding page
> lock.  So it may race with some others, e.g. reclaimer, migration, etc.
> All of them isolates page from LRU then lock the page then do something.
> 
> But it could pass the refcount check done by khugepaged to proceed
> collapse.  Typically such race is not fatal.  But if the page has been
> isolated from LRU before khugepaged it likely means the page may be not
> suitable for collapse for now.
> 
> The other more fatal case is the following patch will keep the poisoned
> page in page cache for shmem, so khugepaged may collapse a poisoned page
> since the refcount check could pass.  3 refcounts come from:
>   - hwpoison
>   - page cache
>   - khugepaged
> 
> Since it is not on LRU so no refcount is incremented from LRU isolation.
> 
> This is definitely not expected.  Checking if it is on LRU or not after
> holding page lock could help serialize against hwpoison handler.
> 
> But there is still a small race window between setting hwpoison flag and
> bump refcount in hwpoison handler.  It could be closed by checking
> hwpoison flag in khugepaged, however this race seems unlikely to happen
> in real life workload.  So just check LRU flag for now to avoid
> over-engineering.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 045cc579f724..bdc161dc27dc 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1808,6 +1808,12 @@ static void collapse_file(struct mm_struct *mm,
>  			goto out_unlock;
>  		}
>  
> +		/* The hwpoisoned page is off LRU but in page cache */
> +		if (!PageLRU(page)) {
> +			result = SCAN_PAGE_LRU;
> +			goto out_unlock;
> +		}
> +
>  		if (isolate_lru_page(page)) {

isolate_lru_page() should catch the case, no? TestClearPageLRU would fail
and we get here.

>  			result = SCAN_DEL_PAGE_LRU;
>  			goto out_unlock;
> -- 
> 2.26.2
> 
> 

-- 
 Kirill A. Shutemov
