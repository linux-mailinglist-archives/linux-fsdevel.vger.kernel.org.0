Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76DA2BA497
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKTIZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:25:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:41726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgKTIZy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:25:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605860753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/oTRUaXAkYZygv3UYXt9E76OSLD00b7IWkOMbS8VPYQ=;
        b=DcriLmSI4f5H4oP0GWaRgjSuOqA7oZrxcDDFHKyxbNxbzD8/TTcfgNdpMsQwzOIR2+ugd0
        Wgq/7T/NznJ7gUMNJqV4wT8JjqtoCqB92NnGby/owput568qoAf0diC/e+DphHSS+PSKW1
        BPFcOgn8cCRkQRK+WDmlhz5EOGwqDHw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C37C3AFDC;
        Fri, 20 Nov 2020 08:25:52 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:25:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 21/21] mm/hugetlb: Disable freeing vmemmap if struct
 page size is not power of two
Message-ID: <20201120082552.GI3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-22-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120064325.34492-22-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 14:43:25, Muchun Song wrote:
> We only can free the unused vmemmap to the buddy system when the
> size of struct page is a power of two.

Can we actually have !power_of_2 struct pages?

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index c3b3fc041903..7bb749a3eea2 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -671,7 +671,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	unsigned int order = huge_page_order(h);
>  	unsigned int vmemmap_pages;
>  
> -	if (hugetlb_free_vmemmap_disabled) {
> +	if (hugetlb_free_vmemmap_disabled ||
> +	    !is_power_of_2(sizeof(struct page))) {
>  		pr_info("disable free vmemmap pages for %s\n", h->name);
>  		return;
>  	}
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
