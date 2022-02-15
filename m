Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663204B6634
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 09:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiBOIdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 03:33:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiBOId0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:33:26 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58690C3312
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 00:33:16 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JyZ4Q1pqFzZfgC;
        Tue, 15 Feb 2022 16:28:54 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 16:33:14 +0800
Subject: Re: [PATCH 05/10] mm: Convert remove_mapping() to take a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-6-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1bdef0a9-7f76-1cc2-0a30-d2d90c6d6916@huawei.com>
Date:   Tue, 15 Feb 2022 16:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-6-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/2/15 4:00, Matthew Wilcox (Oracle) wrote:
> Add kernel-doc and return the number of pages removed in order to
> get the statistics right in __invalidate_mapping_pages().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  fs/splice.c          |  5 ++---
>  include/linux/swap.h |  2 +-
>  mm/truncate.c        |  2 +-
>  mm/vmscan.c          | 23 ++++++++++++++---------
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 23ff9c303abc..047b79db8eb5 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -46,8 +46,7 @@
>  static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
>  		struct pipe_buffer *buf)
>  {
> -	struct page *page = buf->page;
> -	struct folio *folio = page_folio(page);
> +	struct folio *folio = page_folio(buf->page);
>  	struct address_space *mapping;
>  
>  	folio_lock(folio);
> @@ -74,7 +73,7 @@ static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
>  		 * If we succeeded in removing the mapping, set LRU flag
>  		 * and return good.
>  		 */
> -		if (remove_mapping(mapping, page)) {
> +		if (remove_mapping(mapping, folio)) {
>  			buf->flags |= PIPE_BUF_FLAG_LRU;
>  			return true;
>  		}
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index e7cb7a1e6ceb..304f174b4d31 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -395,7 +395,7 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>  						unsigned long *nr_scanned);
>  extern unsigned long shrink_all_memory(unsigned long nr_pages);
>  extern int vm_swappiness;
> -extern int remove_mapping(struct address_space *mapping, struct page *page);
> +long remove_mapping(struct address_space *mapping, struct folio *folio);
>  
>  extern unsigned long reclaim_pages(struct list_head *page_list);
>  #ifdef CONFIG_NUMA
> diff --git a/mm/truncate.c b/mm/truncate.c
> index d67fa8871b75..8aa86e294775 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -292,7 +292,7 @@ int invalidate_inode_page(struct page *page)
>  	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
>  		return 0;
>  
> -	return remove_mapping(mapping, page);
> +	return remove_mapping(mapping, folio);
>  }
>  
>  /**
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2965be8df713..7959df4d611b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1335,23 +1335,28 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
>  	return 0;
>  }
>  
> -/*
> - * Attempt to detach a locked page from its ->mapping.  If it is dirty or if
> - * someone else has a ref on the page, abort and return 0.  If it was
> - * successfully detached, return 1.  Assumes the caller has a single ref on
> - * this page.
> +/**
> + * remove_mapping() - Attempt to remove a folio from its mapping.
> + * @mapping: The address space.
> + * @folio: The folio to remove.
> + *
> + * If the folio is dirty, under writeback or if someone else has a ref
> + * on it, removal will fail.
> + * Return: The number of pages removed from the mapping.  0 if the folio
> + * could not be removed.
> + * Context: The caller should have a single refcount on the folio and
> + * hold its lock.
>   */
> -int remove_mapping(struct address_space *mapping, struct page *page)
> +long remove_mapping(struct address_space *mapping, struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
>  	if (__remove_mapping(mapping, folio, false, NULL)) {
>  		/*
> -		 * Unfreezing the refcount with 1 rather than 2 effectively
> +		 * Unfreezing the refcount with 1 effectively
>  		 * drops the pagecache ref for us without requiring another
>  		 * atomic operation.
>  		 */
>  		folio_ref_unfreeze(folio, 1);
> -		return 1;
> +		return folio_nr_pages(folio);
>  	}
>  	return 0;
>  }
> 

