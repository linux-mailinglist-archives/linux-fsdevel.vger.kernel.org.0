Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C37380772
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhENKiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 06:38:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:48972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhENKiD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 06:38:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CE1BAF59;
        Fri, 14 May 2021 10:36:51 +0000 (UTC)
Subject: Re: [PATCH v10 03/33] mm/vmstat: Add functions to account folio
 statistics
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-4-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e0bb6713-67b6-e9cb-70c3-66b27aef72ed@suse.cz>
Date:   Fri, 14 May 2021 12:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-4-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> Allow page counters to be more readily modified by callers which have
> a folio.  Name these wrappers with 'stat' instead of 'state' as requested
> by Linus here:
> https://lore.kernel.org/linux-mm/CAHk-=wj847SudR-kt+46fT3+xFFgiwpgThvm7DJWGdi4cVrbnQ@mail.gmail.com/
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/vmstat.h | 107 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 3299cd69e4ca..d287d7c31b8f 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -402,6 +402,78 @@ static inline void drain_zonestat(struct zone *zone,
>  			struct per_cpu_pageset *pset) { }
>  #endif		/* CONFIG_SMP */
>  
> +static inline void __zone_stat_mod_folio(struct folio *folio,
> +		enum zone_stat_item item, long nr)
> +{
> +	__mod_zone_page_state(folio_zone(folio), item, nr);
> +}
> +
> +static inline void __zone_stat_add_folio(struct folio *folio,
> +		enum zone_stat_item item)
> +{
> +	__mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
> +}
> +
> +static inline void __zone_stat_sub_folio(struct folio *folio,
> +		enum zone_stat_item item)
> +{
> +	__mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
> +}
> +
> +static inline void zone_stat_mod_folio(struct folio *folio,
> +		enum zone_stat_item item, long nr)
> +{
> +	mod_zone_page_state(folio_zone(folio), item, nr);
> +}
> +
> +static inline void zone_stat_add_folio(struct folio *folio,
> +		enum zone_stat_item item)
> +{
> +	mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
> +}
> +
> +static inline void zone_stat_sub_folio(struct folio *folio,
> +		enum zone_stat_item item)
> +{
> +	mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
> +}
> +
> +static inline void __node_stat_mod_folio(struct folio *folio,
> +		enum node_stat_item item, long nr)
> +{
> +	__mod_node_page_state(folio_pgdat(folio), item, nr);
> +}
> +
> +static inline void __node_stat_add_folio(struct folio *folio,
> +		enum node_stat_item item)
> +{
> +	__mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
> +}
> +
> +static inline void __node_stat_sub_folio(struct folio *folio,
> +		enum node_stat_item item)
> +{
> +	__mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
> +}
> +
> +static inline void node_stat_mod_folio(struct folio *folio,
> +		enum node_stat_item item, long nr)
> +{
> +	mod_node_page_state(folio_pgdat(folio), item, nr);
> +}
> +
> +static inline void node_stat_add_folio(struct folio *folio,
> +		enum node_stat_item item)
> +{
> +	mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
> +}
> +
> +static inline void node_stat_sub_folio(struct folio *folio,
> +		enum node_stat_item item)
> +{
> +	mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
> +}
> +
>  static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
>  					     int migratetype)
>  {
> @@ -530,6 +602,24 @@ static inline void __dec_lruvec_page_state(struct page *page,
>  	__mod_lruvec_page_state(page, idx, -1);
>  }
>  
> +static inline void __lruvec_stat_mod_folio(struct folio *folio,
> +					   enum node_stat_item idx, int val)
> +{
> +	__mod_lruvec_page_state(&folio->page, idx, val);
> +}
> +
> +static inline void __lruvec_stat_add_folio(struct folio *folio,
> +					   enum node_stat_item idx)
> +{
> +	__lruvec_stat_mod_folio(folio, idx, folio_nr_pages(folio));
> +}
> +
> +static inline void __lruvec_stat_sub_folio(struct folio *folio,
> +					   enum node_stat_item idx)
> +{
> +	__lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
> +}
> +
>  static inline void inc_lruvec_page_state(struct page *page,
>  					 enum node_stat_item idx)
>  {
> @@ -542,4 +632,21 @@ static inline void dec_lruvec_page_state(struct page *page,
>  	mod_lruvec_page_state(page, idx, -1);
>  }
>  
> +static inline void lruvec_stat_mod_folio(struct folio *folio,
> +					 enum node_stat_item idx, int val)
> +{
> +	mod_lruvec_page_state(&folio->page, idx, val);
> +}
> +
> +static inline void lruvec_stat_add_folio(struct folio *folio,
> +					 enum node_stat_item idx)
> +{
> +	lruvec_stat_mod_folio(folio, idx, folio_nr_pages(folio));
> +}
> +
> +static inline void lruvec_stat_sub_folio(struct folio *folio,
> +					 enum node_stat_item idx)
> +{
> +	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
> +}
>  #endif /* _LINUX_VMSTAT_H */
> 

