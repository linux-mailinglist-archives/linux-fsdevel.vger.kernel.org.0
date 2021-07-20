Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25883CF832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhGTKEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234146AbhGTKCO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:02:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AE51611CE;
        Tue, 20 Jul 2021 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777772;
        bh=z5E+2FUBOVAySTqfuxw0l4m0gqoXHnhMGtKhrkfnNGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBcCzgAMeR76urzgsIt6GN86Gsn0+YUmx2Rkts7GyOOXjlzV3DS1K23B4tYe6yn0l
         C8y7HrBH5FNLz/qGOK7dmlg33Or7M41RqEk1oddwuHMV4VchjlyvolOiSALA/i8iaP
         Tu1Btjs6YXpskMVAMbd3hBr4TSLyB1zwd0hYTL9A/1gzYfwkMgdQSa1B0SzGdN0wLq
         TQ3Kf+FDa4m/rZCv64vDl15nGy4cmCJoCheukehthAUnXRhEmT9Tq+HoDzkMg2NbEY
         by6zkebT0kxssXQwVDILeI2hNngt6g35d1PsmuB9yQQY88vZNHGnXQ/0QN5EQxHdRi
         ZyvnNdI+tZrHQ==
Date:   Tue, 20 Jul 2021 13:42:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 015/138] mm/filemap: Add folio_pos() and
 folio_file_pos()
Message-ID: <YPaopX3lFkECBJub@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-16-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:01AM +0100, Matthew Wilcox (Oracle) wrote:
> These are just wrappers around page_offset() and page_file_offset()
> respectively.  No change to generated code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/pagemap.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bd0e7e91bfd4..aa71fa82d6be 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -562,6 +562,27 @@ static inline loff_t page_file_offset(struct page *page)
>  	return ((loff_t)page_index(page)) << PAGE_SHIFT;
>  }
>  
> +/**
> + * folio_pos - Returns the byte position of this folio in its file.
> + * @folio: The folio.

kerneldoc will warn about missing description of return value.

> + */
> +static inline loff_t folio_pos(struct folio *folio)
> +{
> +	return page_offset(&folio->page);
> +}
> +
> +/**
> + * folio_file_pos - Returns the byte position of this folio in its file.
> + * @folio: The folio.
> + *
> + * This differs from folio_pos() for folios which belong to a swap file.
> + * NFS is the only filesystem today which needs to use folio_file_pos().

ditto

> + */
> +static inline loff_t folio_file_pos(struct folio *folio)
> +{
> +	return page_file_offset(&folio->page);
> +}
> +
>  extern pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
>  				     unsigned long address);
>  
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
