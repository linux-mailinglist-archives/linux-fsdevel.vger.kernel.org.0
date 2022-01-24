Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76072497987
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 08:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiAXHeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 02:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiAXHes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:34:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492DBC06173D;
        Sun, 23 Jan 2022 23:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1pvzoBeDlgv3Vf0vSPk0Wh1fklNMks7nxVYOQUDWWho=; b=qGM1Gc4ap3abGbonuY/wXu+Ni/
        X+wFCAnrwIEUQPusRYrKqfOjffQHPz7x8WNoq8uJbPVkVkbE2AjBY6sl25jwlJbJaS5JeelT3lJUO
        MACc22La5O06u91r0RI/ZurexcPraklK3GyBWMILS2Xfu/Ku66FuI7KvUNQj6hicmm2y+4iF0H1Mr
        Jdzo734aKQWKZosj3cKnzp8obToYtJpYdDHfWU0t6BZoTgz0LxL4VIR8tTPLWzwXKURx33h7uOuBT
        FVy55b6y2LYLsnSnUHt04pWNMKL940VCtD1YCx8IpP4ymwntvch5ikoQNILwWO/mMl0gRw93EvnCK
        /xnn5S/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBts4-002V2P-Ev; Mon, 24 Jan 2022 07:34:36 +0000
Date:   Sun, 23 Jan 2022 23:34:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/5] dax: fix cache flush on PMD-mapped pages
Message-ID: <Ye5WjF6xOV3WMcvh@infradead.org>
References: <20220121075515.79311-1-songmuchun@bytedance.com>
 <20220121075515.79311-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121075515.79311-2-songmuchun@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:55:12PM +0800, Muchun Song wrote:
> The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
> However, it does not cover the full pages in a THP except a head page.
> Replace it with flush_cache_range() to fix this issue.
> 
> Fixes: f729c8c9b24f ("dax: wrprotect pmd_t in dax_mapping_entry_mkclean")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 88be1c02a151..2955ec65eb65 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -857,7 +857,7 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
>  			if (!pmd_dirty(*pmdp) && !pmd_write(*pmdp))
>  				goto unlock_pmd;
>  
> -			flush_cache_page(vma, address, pfn);
> +			flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);

Same comment as for the previous one.

