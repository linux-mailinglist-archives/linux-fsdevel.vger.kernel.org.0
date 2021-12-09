Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60846E97C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 14:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhLIN7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 08:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhLIN7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:59:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24C8C061746;
        Thu,  9 Dec 2021 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1+LEczdi59AY2/papldS92pldhESqdSy5rOO+LXFl/Y=; b=BN5zR4Fap4OgbbW6sVMj4jsSBW
        ilAnzN36cbHQO/TcIlS7AGgmaJEGWgjklvLL8UYTAqWAvaYX1k6e/+tlghjFURWAcOMIaNCIlTqrq
        EQxnogm7lkO6cKp4Xe7wWXN6kKowrwd8oLAmDfuxyre3ek1mvbUe7JaT/tgWY3JMhfx//48e82tMw
        NAfRHXggAMFolsWz/6cYamZIi/SxeNZ65Eg15PASz2d3U5Eor2e0S/cJPJFzZtdVrMiKFu1bmYjMQ
        aGaDxdoZ+l+UU86+SUjonqqsSlyV0/Gp6jHlCsc8Y9Vuxsq2sYFSP3CiFXaXqc0pkiGLzxGt/3vcy
        LcRiZktw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvJtf-009Oqj-PV; Thu, 09 Dec 2021 13:55:43 +0000
Date:   Thu, 9 Dec 2021 13:55:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: delete unsafe BUG from page_cache_add_speculative()
Message-ID: <YbIK3xTo0Pt1zOrh@casper.infradead.org>
References: <8b98fc6f-3439-8614-c3f3-945c659a1aba@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b98fc6f-3439-8614-c3f3-945c659a1aba@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:19:18PM -0800, Hugh Dickins wrote:
> It is not easily reproducible, but on 5.16-rc I have several times hit
> the VM_BUG_ON_PAGE(PageTail(page), page) in page_cache_add_speculative():
> usually from filemap_get_read_batch() for an ext4 read, yesterday from
> next_uptodate_page() from filemap_map_pages() for a shmem fault.
> 
> That BUG used to be placed where page_ref_add_unless() had succeeded,
> but now it is placed before folio_ref_add_unless() is attempted: that
> is not safe, since it is only the acquired reference which makes the
> page safe from racing THP collapse or split.
> 
> We could keep the BUG, checking PageTail only when folio_ref_try_add_rcu()
> has succeeded; but I don't think it adds much value - just delete it.

Whoops, that was careless of me.  I agree with your reasoning and patch.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Fixes: 020853b6f5ea ("mm: Add folio_try_get_rcu()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> 
>  include/linux/pagemap.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- 5.16-rc4/include/linux/pagemap.h
> +++ linux/include/linux/pagemap.h
> @@ -285,7 +285,6 @@ static inline struct inode *folio_inode(
>  
>  static inline bool page_cache_add_speculative(struct page *page, int count)
>  {
> -	VM_BUG_ON_PAGE(PageTail(page), page);
>  	return folio_ref_try_add_rcu((struct folio *)page, count);
>  }
>  
