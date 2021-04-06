Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA1D355529
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhDFNbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhDFNbc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:31:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1482EC06174A;
        Tue,  6 Apr 2021 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wQuSgXvvayHccqDmkcsLOwlAkT4r6qTVRKvApKKeAHE=; b=QoXafGbjSMFSahCUJ4nxDTUD3P
        rFsvFlqB+0rSuJbWYoatudI9IGCUCB9MAdIO/kpAMmqcnvpQr0mYUYiOEP/wTPDrPE7pHDIzcijKh
        3kg34KvSZmbaCUZYjqbBeczXm8UhnmUIKBhTFBlpcre7Gzr1s9xAdANZ4TTQSeVCALpEhwkgWbn4d
        UFvuGBOMQ2rgjw6ojpgZOnhr55YMGyM7ouZwTT0F6NhoTSE7xHu99EgFt7MkkDzAJvkeVEri1r3X4
        TojqIhbKgIcV+3KX0z7dE7kh+iru41FOEK1yALk8j9cBpFFHjv1r7CZmNA0HPwqZkkai9627pM8ev
        +xXCHq5g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTln6-00CrXl-3O; Tue, 06 Apr 2021 13:30:53 +0000
Date:   Tue, 6 Apr 2021 14:30:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 05/27] mm: Add folio reference count functions
Message-ID: <20210406133048.GD3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:06PM +0100, Matthew Wilcox (Oracle) wrote:
> These functions mirror their page reference counterparts.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/core-api/mm-api.rst |  1 +
>  include/linux/page_ref.h          | 88 ++++++++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
> index 34f46df91a8b..1ead2570b217 100644
> --- a/Documentation/core-api/mm-api.rst
> +++ b/Documentation/core-api/mm-api.rst
> @@ -97,3 +97,4 @@ More Memory Management Functions
>     :internal:
>  .. kernel-doc:: include/linux/mm.h
>     :internal:
> +.. kernel-doc:: include/linux/page_ref.h
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index f3318f34fc54..f27005e760fd 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -69,7 +69,29 @@ static inline int page_ref_count(struct page *page)
>  
>  static inline int page_count(struct page *page)
>  {
> -	return atomic_read(&compound_head(page)->_refcount);
> +	return page_ref_count(compound_head(page));
> +}

I don't think this change belongs in here.  It seems useful though,
so maybe split it into a standalone patch?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
