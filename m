Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A70380E99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhENRIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 13:08:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235049AbhENRIg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 13:08:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0DA23B061;
        Fri, 14 May 2021 17:07:24 +0000 (UTC)
Subject: Re: [PATCH v10 13/33] mm/filemap: Add folio_next_index
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-14-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <92518dfb-5624-62d7-9998-305587fc561c@suse.cz>
Date:   Fri, 14 May 2021 19:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-14-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> This helper returns the page index of the next folio in the file (ie
> the end of this folio, plus one).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/pagemap.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 8eaeffccfd38..3b82252d12fc 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -406,6 +406,17 @@ static inline pgoff_t folio_index(struct folio *folio)
>          return folio->index;
>  }
>  
> +/**
> + * folio_next_index - Get the index of the next folio.
> + * @folio: The current folio.
> + *
> + * Return: The index of the folio which follows this folio in the file.
> + */
> +static inline pgoff_t folio_next_index(struct folio *folio)
> +{
> +	return folio->index + folio_nr_pages(folio);
> +}
> +
>  /**
>   * folio_file_page - The page for a particular index.
>   * @folio: The folio which contains this index.
> 

