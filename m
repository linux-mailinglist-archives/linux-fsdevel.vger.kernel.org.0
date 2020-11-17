Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348AD2B68DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 16:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKQPj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 10:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKQPjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:39:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED73C0613CF;
        Tue, 17 Nov 2020 07:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QFlYdiYc0xmhkx8fR9s7buBYTCO5I402/gNcSckf2XE=; b=rMgmU2PghbmqKsBILzyfNyG/uK
        wtKPHb8W3lOiQ0jK3tEgZmJbD0uWyQhHqbkgOtXV1pfZk6VNhBEBFcFzgluA8lunGyA1PkUDIKNug
        u9r6TJx+T90hxL/6JcPMUVleD94i/5LlyUZNBRcrWU2FruLCQtXpeGMU+dpI0r+1rWb32v8Q25fP8
        569yO0zojtHq/kT0rA+ZIA7wZXBnr5gkPOFioUxBm5Cz/yYNc9iqogtCDGL4hm/k01KLdThm+gVZC
        BiP0DKLjsdsfb7aVmG2I52zS1UgU49AZtni9RKRtRJyfPIbuURoNAk2TJWLFXTBFHc/LgPPQMO+WA
        tvMCtQ+A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf359-0006RE-Cb; Tue, 17 Nov 2020 15:39:47 +0000
Date:   Tue, 17 Nov 2020 15:39:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-ID: <20201117153947.GL29991@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
 <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 02:34:34AM -0800, Hugh Dickins wrote:
> Fix to [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs.
> One machine ran fine, swapping and building in ext4 on loop0 on huge tmpfs;
> one machine got occasional pages of zeros in its .os; one machine couldn't
> get started because of ext4_find_dest_de errors on the newly mkfs'ed fs.
> The partial_end case was decided by PAGE_SIZE, when there might be a THP
> there.  The below patch has run well (for not very long), but I could
> easily have got it slightly wrong, off-by-one or whatever; and I have
> not looked into the similar code in mm/truncate.c, maybe that will need
> a similar fix or maybe not.

Thank you for the explanation in your later email!  There is indeed an
off-by-one, although in the safe direction.

> --- 5103w/mm/shmem.c	2020-11-12 15:46:21.075254036 -0800
> +++ 5103wh/mm/shmem.c	2020-11-16 01:09:35.431677308 -0800
> @@ -874,7 +874,7 @@ static void shmem_undo_range(struct inod
>  	long nr_swaps_freed = 0;
>  	pgoff_t index;
>  	int i;
> -	bool partial_end;
> +	bool same_page;
>  
>  	if (lend == -1)
>  		end = -1;	/* unsigned, so actually very big */
> @@ -907,16 +907,12 @@ static void shmem_undo_range(struct inod
>  		index++;
>  	}
>  
> -	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
> +	same_page = (lstart >> PAGE_SHIFT) == end;

'end' is exclusive, so this is always false.  Maybe something "obvious":

	same_page = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);

(lend is inclusive, so lend in 0-4095 are all on the same page)

>  	page = NULL;
>  	shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
>  	if (page) {
> -		bool same_page;
> -
>  		page = thp_head(page);
>  		same_page = lend < page_offset(page) + thp_size(page);
> -		if (same_page)
> -			partial_end = false;
>  		set_page_dirty(page);
>  		if (!truncate_inode_partial_page(page, lstart, lend)) {
>  			start = page->index + thp_nr_pages(page);
> @@ -928,7 +924,7 @@ static void shmem_undo_range(struct inod
>  		page = NULL;
>  	}
>  
> -	if (partial_end)
> +	if (!same_page)
>  		shmem_getpage(inode, end, &page, SGP_READ);
>  	if (page) {
>  		page = thp_head(page);
