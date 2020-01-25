Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9617F149786
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 20:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgAYTou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 14:44:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAYTou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 14:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0ZMGv3oBke4qgEgEWLJ/O03PCwZbetUWl8MszuyJc3E=; b=iukevvX9wHFfu3JIg1tr6gVc/
        JwJE61o+VY7KxTDz9InYcyVcbamX1y02guAD3rWE2GMFBd6m2M560rZ9H3IdzZ7mREF8HfqjNOxF7
        HlJjW/HzTAr+MQDnqg4+ap4KCIzzg0CvE0iBtGvOYLNOiEVgKse1AFNaAcpAnsLdvzyQ+tS0PerbZ
        t5ty0p/lHmff1/2YUFwEYdYp9wzoQkDc38nEKsZ+jm2E8oJgAiMXjCButFfqjsPdn0CHgtX1TFbzu
        4tuijwgd1IjFP1Dl0+zEUez39wsvlMoBZL+xtptLXo4jcPUPXyt9UU4IzOBc+Dq2WViHshRY6wYB0
        R5QNBIB6A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivRMP-0004OA-SC; Sat, 25 Jan 2020 19:44:49 +0000
Date:   Sat, 25 Jan 2020 11:44:49 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 03/12] readahead: Put pages in cache earlier
Message-ID: <20200125194449.GO4675@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125013553.24899-4-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 05:35:44PM -0800, Matthew Wilcox wrote:
> @@ -192,8 +194,18 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
>  		page = __page_cache_alloc(gfp_mask);
>  		if (!page)
>  			break;
> -		page->index = page_offset;
> -		list_add(&page->lru, &page_pool);
> +		if (use_list) {
> +			page->index = page_offset;
> +			list_add(&page->lru, &page_pool);
> +		} else if (!add_to_page_cache_lru(page, mapping, page_offset,
> +					gfp_mask)) {
> +			if (nr_pages)
> +				read_pages(mapping, filp, &page_pool,
> +						page_offset - nr_pages,
> +						nr_pages);
> +			nr_pages = 0;

This is missing a call to put_page().

> +			continue;
> +		}
>  		if (page_idx == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
>  		nr_pages++;
