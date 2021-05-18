Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF316387812
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbhERLxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 07:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241753AbhERLxO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 07:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF22CB01E;
        Tue, 18 May 2021 11:51:55 +0000 (UTC)
Subject: Re: [PATCH v10 28/33] mm/filemap: Add folio_wait_bit
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-29-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8afd6085-96d0-8219-2cbf-31a0c04d35fb@suse.cz>
Date:   Tue, 18 May 2021 13:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-29-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> Rename wait_on_page_bit() to folio_wait_bit().  We must always wait on
> the folio, otherwise we won't be woken up due to the tail page hashing
> to a different bucket from the head page.
> 
> This commit shrinks the kernel by 691 bytes, mostly due to moving
> the page waitqueue lookup into folio_wait_bit_common().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>


Acked-by: Vlastimil Babka <vbabka@suse.cz>


Nit below.

> ---
>  include/linux/pagemap.h | 10 +++---
>  mm/filemap.c            | 77 +++++++++++++++++++----------------------
>  mm/page-writeback.c     |  4 +--
>  3 files changed, 43 insertions(+), 48 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 06b69cd03da3..e524e1b7190a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -714,11 +714,11 @@ static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
>  }
>  
>  /*
> - * This is exported only for wait_on_page_locked/wait_on_page_writeback, etc.,
> + * This is exported only for folio_wait_locked/folio_wait_writeback, etc.,
>   * and should not be used directly.
>   */
> -extern void wait_on_page_bit(struct page *page, int bit_nr);
> -extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
> +extern void folio_wait_bit(struct folio *folio, int bit_nr);
> +extern int folio_wait_bit_killable(struct folio *folio, int bit_nr);

Nit: you remove these 'externs' in other patches, not here?
