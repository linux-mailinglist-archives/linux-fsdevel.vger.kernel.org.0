Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8C3B172D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhFWJtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:49:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F7C061574;
        Wed, 23 Jun 2021 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Ywl5L2ZPG3F3nRTyNYLoYPvfOhwKYjLH9p9+WMM1lg=; b=k2MsE88ocdP3lEuvBTOIHl0Ml2
        IWrwgPNk4KHLuVZtA0QxLdtMHvxaYO1HEqTO8vVQGU6VXwPvdi+cdy40pu0GPR55ix3KimrCPz09V
        3OHNaYqUVHu8Zkar3e+XrxDTpYfrHx1K/OQE/woOLGVnUmWRA59wzSImBgqZqNh4g36hvWBLQnhZO
        aI9WA89Dn1lIO9v4LWsnlFCNpWrW9xvY6bJFQrk/IW8kfs/eB/YvfItl12TAmrFHt3PPhOcG/ylfU
        kwMtOffGvHWEqPIZMcknse7AfZajBJ/waONeCTLPxYUXJMadzOi2mXSFBrwegRPD5EnAzU1qKDMwJ
        Qfkm+B5A==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzSo-00FHPW-09; Wed, 23 Jun 2021 09:46:39 +0000
Date:   Wed, 23 Jun 2021 11:46:28 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 34/46] mm/filemap: Add i_blocks_per_folio()
Message-ID: <YNMC9BDVexAnnHaK@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-35-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-35-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:39PM +0100, Matthew Wilcox (Oracle) wrote:
> Reimplement i_blocks_per_page() as a wrapper around i_blocks_per_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 31edfa891987..c30db827b65d 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1149,19 +1149,25 @@ static inline int page_mkwrite_check_truncate(struct page *page,
>  }
>  
>  /**
> - * i_blocks_per_page - How many blocks fit in this page.
> + * i_blocks_per_folio - How many blocks fit in this folio.
>   * @inode: The inode which contains the blocks.
> - * @page: The page (head page if the page is a THP).
> + * @folio: The folio.
>   *
> - * If the block size is larger than the size of this page, return zero.
> + * If the block size is larger than the size of this folio, return zero.
>   *
> - * Context: The caller should hold a refcount on the page to prevent it
> + * Context: The caller should hold a refcount on the folio to prevent it
>   * from being split.
> - * Return: The number of filesystem blocks covered by this page.
> + * Return: The number of filesystem blocks covered by this folio.
>   */
> +static inline
> +unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)

Weirdo formatting (same as i_blocks_per_page, but I'd still rather avoid
it).

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
