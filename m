Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87B359D4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 13:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhDIL1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDIL1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:27:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DAEC061760;
        Fri,  9 Apr 2021 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8vsQAWqPO257QZ14b6/67BsYk32ojx3EAVHaQFltyM=; b=ZqgBOOOVr8Xg5gLfjCGe8UTcyL
        VLHWVrkDWGsOAZvGBCi4v8R7+frMSg3kDV6atzgQdS7NNpzGiR2I2TDzdZ3Knat9ed2wUzhjsCpNh
        FJD0HeD7A6k5ik83urs9txoAuWXtj7Pj2VIoLObRahlAS3m6xtw64nBdwjyCskD5+kgPTER6b4e4w
        C8Ms8a2NHJ5vu8vaLJL9efvyWzIZE45C+Y23OLonG9BpTSIfkJkHBUApavG/uyd60BKQDn1h/h9k0
        xKaEE0zYerAUJCJfF+J6B3JoDsrnDALhW/tmeOA+8BJ2fvVnmUzxtR411IpAZXL3csMnvGbV6sza6
        Wbkz1ZyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUpFw-000HJN-Uc; Fri, 09 Apr 2021 11:25:05 +0000
Date:   Fri, 9 Apr 2021 12:24:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] mm: Split page_has_private() in two to better
 handle PG_private_2
Message-ID: <20210409112456.GS2531743@casper.infradead.org>
References: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com>
 <161796596902.350846.10297397888865722494.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161796596902.350846.10297397888865722494.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 11:59:29AM +0100, David Howells wrote:
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 414769a6ad11..9c89db033548 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -41,7 +41,7 @@ static inline struct iomap_page *to_iomap_page(struct page *page)
>  	 */
>  	VM_BUG_ON_PGFLAGS(PageTail(page), page);
>  
> -	if (page_has_private(page))
> +	if (page_needs_cleanup(page))

That should be PagePrivate(page)

>  		return (struct iomap_page *)page_private(page);
>  	return NULL;
>  }
> @@ -163,7 +163,7 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	if (PageError(page))
>  		return;
>  
> -	if (page_has_private(page))
> +	if (PagePrivate(page))
>  		iomap_iop_set_range_uptodate(page, off, len);
>  	else
>  		SetPageUptodate(page);
> @@ -502,7 +502,7 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
>  	if (ret != MIGRATEPAGE_SUCCESS)
>  		return ret;
>  
> -	if (page_has_private(page))
> +	if (PagePrivate(page))
>  		attach_page_private(newpage, detach_page_private(page));
>  
>  	if (mode != MIGRATE_SYNC_NO_COPY)
