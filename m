Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9862D773B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391311AbgLKN7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 08:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731660AbgLKN6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:58:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0BC0613D3;
        Fri, 11 Dec 2020 05:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZihKsA22Et28L+VhHdtqUTD2BoH0RLZyZlt+xMMF8Ow=; b=IyKYrwls3wfp56Z7qFPwr0ue7Z
        Yprw6UCRdnGLdbOf1Sn2AaFRFwqr2StRLqZvlkEvVobIqWznxgPXiEHRDI3mGGeTILifiKRRq1MN6
        3PSkhZ8HzT9DmE5G6vbGrDHNEYKFYSHkD3szMs/kc0gBWk+BSWcJ14PJgSMisrDtxJ4kUR0GKCMJM
        M7qus/u6xx6J2pqCeasF54kAGlcrhWrYvQiUpoG7e5ZDP1Br6TDVaY9+Gpr8hO/A1VWTpVjPAx3pg
        pT/kxGOx4WV03ILPeHx+lt9XtjjII1g2ZKRTWebPTNtmlM0Jfj2fT85MbiH7YPAblbb7Nrd6bBFyn
        oRjQO0sQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knivS-0003uy-0i; Fri, 11 Dec 2020 13:57:38 +0000
Date:   Fri, 11 Dec 2020 13:57:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 3/7] mm: memcontrol: convert NR_FILE_THPS account to
 pages
Message-ID: <20201211135737.GA2443@casper.infradead.org>
References: <20201211041954.79543-1-songmuchun@bytedance.com>
 <20201211041954.79543-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211041954.79543-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:19:50PM +0800, Muchun Song wrote:
> +++ b/mm/filemap.c
> @@ -207,7 +207,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
>  		if (PageTransHuge(page))
>  			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
>  	} else if (PageTransHuge(page)) {
> -		__dec_lruvec_page_state(page, NR_FILE_THPS);
> +		__mod_lruvec_page_state(page, NR_FILE_THPS, -HPAGE_PMD_NR);

+               __mod_lruvec_page_state(page, NR_FILE_THPS, -nr);

> +++ b/mm/huge_memory.c
> @@ -2748,7 +2748,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  			if (PageSwapBacked(head))
>  				__dec_lruvec_page_state(head, NR_SHMEM_THPS);
>  			else
> -				__dec_lruvec_page_state(head, NR_FILE_THPS);
> +				__mod_lruvec_page_state(head, NR_FILE_THPS,
> +							-HPAGE_PMD_NR);

+                               __mod_lruvec_page_state(head, NR_FILE_THPS,
+                                               -thp_nr_pages(head));

