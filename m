Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C27A275B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 21:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjIOTqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjIOTqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:46:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0AB1738;
        Fri, 15 Sep 2023 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y/fSdW0K1l1qEwxoAkr3ut7R4kvgq+96xhgOzZowLQE=; b=g6HHLtGAW2z+LmhyJlCjL9C/gX
        fIPMB4BW9Wi9o/LMqeRMuUiNz4ujTuj9F6IgYEt+eVO7GRnfJb3O0v0SDVdR+Amn6z2fg1lLtaWOt
        Ram/r3053lAZ7AOIxW7En+9EurwXX3VkS77aBBWIRbNSutvbDY87xcdW07nK32y7mELbqJe/jyJhg
        R48gG8ZrGFKp0CdoPzW/dHbrETbFJ7FNJkhj5G2i7Pgwhw4OejbWbzuPSJMeLM99+nctdlCM2CDPu
        27A22qTSq2j96CT9eqIz4w3JnX8TU7JzWN2LiouX1jD4OC5wphRf5FDdpQAan5qrjPFFMCO4T1Yey
        ZQ9SnUKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhElW-00Bg3F-Kz; Fri, 15 Sep 2023 19:46:10 +0000
Date:   Fri, 15 Sep 2023 20:46:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 06/23] mm: call xas_set_order() in
 replace_page_cache_folio()
Message-ID: <ZQS0gizJxwonqVC/@casper.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-7-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183848.1018717-7-kernel@pankajraghav.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:38:31PM +0200, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Call xas_set_order() in replace_page_cache_folio() for non hugetlb
> pages.

This function definitely should work without this patch.  What goes wrong?

> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/filemap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4dee24b5b61c..33de71bfa953 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -815,12 +815,14 @@ EXPORT_SYMBOL(file_write_and_wait_range);
>  void replace_page_cache_folio(struct folio *old, struct folio *new)
>  {
>  	struct address_space *mapping = old->mapping;
> +	unsigned int min_order = mapping_min_folio_order(mapping);
>  	void (*free_folio)(struct folio *) = mapping->a_ops->free_folio;
>  	pgoff_t offset = old->index;
>  	XA_STATE(xas, &mapping->i_pages, offset);
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
>  	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
> +	VM_BUG_ON_FOLIO(folio_order(new) != folio_order(old), new);
>  	VM_BUG_ON_FOLIO(new->mapping, new);
>  
>  	folio_get(new);
> @@ -829,6 +831,11 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
>  
>  	mem_cgroup_migrate(old, new);
>  
> +	if (!folio_test_hugetlb(new)) {
> +		VM_BUG_ON_FOLIO(folio_order(new) < min_order, new);
> +		xas_set_order(&xas, offset, folio_order(new));
> +	}
> +
>  	xas_lock_irq(&xas);
>  	xas_store(&xas, new);
>  
> -- 
> 2.40.1
> 
