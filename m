Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3242726E7E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 00:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIQWDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 18:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIQWDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:03:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331EEC06174A;
        Thu, 17 Sep 2020 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ubJtVk08jzU3J8YPE2lJLRaYSsnYYHZKYdrpjiW6yU4=; b=ICDUnkL72CW96WATA+3jxM5vWb
        6oYT1enLOn3O4Ag28G+e5sc4FqNNUy2Ikgxnpx/LhvjaiBKvrZWAbYzkaYIkc/NjzWtAUaMsW8kTk
        Yue6qkZhlQb9iYXfoXv9v9sKs+He0hXzIgOzvhGW01abuVdlCsLu5ep5X71lnTxbrbq9ljbXhS2jN
        fZS2WZ9OlwwNROzSqPlT2fhEu7ifLnDLSIWkeEha9ouk+MkogWQ6Zy5o5FAh5nDVbZ7+o9C1tZcrW
        sIbCrABL5nerc0GAMK3sNquTExIDELUO/f3nddMDsbHnosACnqilx6WvwEtmQbtPzdCn8oS1kPCcM
        eCOrz5Qw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ1zf-0003eq-8d; Thu, 17 Sep 2020 22:03:07 +0000
Date:   Thu, 17 Sep 2020 23:03:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 01/13] mm: Add AOP_UPDATED_PAGE return value
Message-ID: <20200917220307.GX5449@casper.infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917151050.5363-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917151050.5363-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:10:38PM +0100, Matthew Wilcox (Oracle) wrote:
> +++ b/mm/filemap.c
> @@ -2254,8 +2254,10 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		 * PG_error will be set again if readpage fails.
>  		 */
>  		ClearPageError(page);
> -		/* Start the actual read. The read will unlock the page. */
> +		/* Start the actual read. The read may unlock the page. */
>  		error = mapping->a_ops->readpage(filp, page);
> +		if (error == AOP_UPDATED_PAGE)
> +			goto page_ok;
>  
>  		if (unlikely(error)) {
>  			if (error == AOP_TRUNCATED_PAGE) {

If anybody wants to actually test this, this hunk is wrong.

+++ b/mm/filemap.c
@@ -2256,8 +2256,11 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
                ClearPageError(page);
                /* Start the actual read. The read may unlock the page. */
                error = mapping->a_ops->readpage(filp, page);
-               if (error == AOP_UPDATED_PAGE)
+               if (error == AOP_UPDATED_PAGE) {
+                       unlock_page(page);
+                       error = 0;
                        goto page_ok;
+               }
 
                if (unlikely(error)) {
                        if (error == AOP_TRUNCATED_PAGE) {

> @@ -2619,7 +2621,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 */
>  	if (unlikely(!PageUptodate(page)))
>  		goto page_not_uptodate;
> -
> +page_ok:
>  	/*
>  	 * We've made it this far and we had to drop our mmap_lock, now is the
>  	 * time to return to the upper layer and have it re-find the vma and
> @@ -2654,6 +2656,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	ClearPageError(page);
>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  	error = mapping->a_ops->readpage(file, page);
> +	if (error == AOP_UPDATED_PAGE)
> +		goto page_ok;
>  	if (!error) {
>  		wait_on_page_locked(page);
>  		if (!PageUptodate(page))
> @@ -2867,6 +2871,10 @@ static struct page *do_read_cache_page(struct address_space *mapping,
>  			err = filler(data, page);
>  		else
>  			err = mapping->a_ops->readpage(data, page);
> +		if (err == AOP_UPDATED_PAGE) {
> +			unlock_page(page);
> +			goto out;
> +		}
>  
>  		if (err < 0) {
>  			put_page(page);
> -- 
> 2.28.0
> 
