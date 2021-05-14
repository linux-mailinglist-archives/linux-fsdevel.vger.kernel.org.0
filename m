Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA37838075D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 12:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhENKgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 06:36:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:47324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233603AbhENKgU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 06:36:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4765AF4E;
        Fri, 14 May 2021 10:35:07 +0000 (UTC)
Subject: Re: [PATCH v10 02/33] mm: Add folio_pgdat and folio_zone
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-3-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <42582e63-ad03-8ae7-89d3-bbf2725acccd@suse.cz>
Date:   Fri, 14 May 2021 12:35:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-3-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> These are just convenience wrappers for callers with folios; pgdat and
> zone can be reached from tail pages as well as head pages.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b29c86824e6b..a55c2c0628b6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1560,6 +1560,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
>  	return NODE_DATA(page_to_nid(page));
>  }
>  
> +static inline struct zone *folio_zone(const struct folio *folio)
> +{
> +	return page_zone(&folio->page);
> +}
> +
> +static inline pg_data_t *folio_pgdat(const struct folio *folio)
> +{
> +	return page_pgdat(&folio->page);
> +}
> +
>  #ifdef SECTION_IN_PAGE_FLAGS
>  static inline void set_page_section(struct page *page, unsigned long section)
>  {
> 

