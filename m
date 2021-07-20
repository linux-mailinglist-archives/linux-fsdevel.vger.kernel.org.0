Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE53CF821
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhGTKCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237417AbhGTKBl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3542D61165;
        Tue, 20 Jul 2021 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777739;
        bh=xY34TkkfEyN2xJ5ULrS19fyp7oVXqEVk/9Z+3+xxUy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FM/j2mW74IqGOOGh9MIUoDUhoLC5N1x85PdGTnmFpja9hFAH6P8ns1KvdSh+je1bb
         P9KPia8HXe4vNuN60JRZrlILhA9Kx1VFdXIfRxvt8nx0j1KLg2aTqn3D8HbbvM7BlM
         jDPEwo8xAxmwhjrZxY/q7F86nwvdJp8JHcj6nYbjL+32B6MaBKQdzxhPgfQyoQjuL/
         NeNkMG//29cro9Cv1AqLVNDrcoF7sBNZowcs+6BpzG6BadYzbexza/jxcOIh9MXJRL
         JwwZL7D6olSb3oy30nQ/FRVs1Unl9pJZ+Z9xgELMatViPq8PI07CDg67J56xST1yng
         MBTAvtrkPTRvQ==
Date:   Tue, 20 Jul 2021 13:42:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 014/138] mm/filemap: Add folio_next_index()
Message-ID: <YPaog6FqCWY+JQLk@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-15-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:00AM +0100, Matthew Wilcox (Oracle) wrote:
> This helper returns the page index of the next folio in the file (ie
> the end of this folio, plus one).
> 
> No changes to generated code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/pagemap.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index f7c165b5991f..bd0e7e91bfd4 100644
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

Maybe note that index is in units of pages?

> +static inline pgoff_t folio_next_index(struct folio *folio)
> +{
> +	return folio->index + folio_nr_pages(folio);
> +}
> +
>  /**
>   * folio_file_page - The page for a particular index.
>   * @folio: The folio which contains this index.
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
