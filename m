Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA811638E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 02:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgBSBCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 20:02:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBSBCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dmgQq76s5htd6QK1djoTrZsBDESqx9Po29KnZ84sMso=; b=eAZdgCeC8YnlA9szfqlWljjWDh
        UQdArvzLM0oiT5XqIC/Q7h5+HeHL9h7cGk8uQK7lBmcw6zYNiJPBANRy3Kwp44uDdtkV2GwprxPbm
        2qK75Ii01IRiWR/ENG9UpNAtQ6GGFmxoDicA6zhQykS1pxRxOwf5Iqo0m6NjHXkdBzku6LESIgg13
        MNO5VqW3ruk/ciL+0+OSHHUM0uvKmDauMYS1h6HQC5+eUgS66IZUqnL5ZBn4iPhOROjAMtOQnLmUp
        r0l8D5tGUQYLIWt9/cYhYmOOb/1dYr6JEJYp93FoEhbgXTOlcGKNkDzg1ltXOO9ME1PREkt7eWceP
        c68pLuUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Dkf-0005UF-KW; Wed, 19 Feb 2020 01:02:09 +0000
Date:   Tue, 18 Feb 2020 17:02:09 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
Message-ID: <20200219010209.GI24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-12-willy@infradead.org>
 <e3671faa-dfb3-ceba-3120-a445b2982a95@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3671faa-dfb3-ceba-3120-a445b2982a95@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:01:43PM -0800, John Hubbard wrote:
> How about this instead? It uses the "for" loop fully and more naturally,
> and is easier to read. And it does the same thing:
> 
> static inline struct page *readahead_page(struct readahead_control *rac)
> {
> 	struct page *page;
> 
> 	if (!rac->_nr_pages)
> 		return NULL;
> 
> 	page = xa_load(&rac->mapping->i_pages, rac->_start);
> 	VM_BUG_ON_PAGE(!PageLocked(page), page);
> 	rac->_batch_count = hpage_nr_pages(page);
> 
> 	return page;
> }
> 
> static inline struct page *readahead_next(struct readahead_control *rac)
> {
> 	rac->_nr_pages -= rac->_batch_count;
> 	rac->_start += rac->_batch_count;
> 
> 	return readahead_page(rac);
> }
> 
> #define readahead_for_each(rac, page)			\
> 	for (page = readahead_page(rac); page != NULL;	\
> 	     page = readahead_page(rac))

I'm assuming you mean 'page = readahead_next(rac)' on that second line.

If you keep reading all the way to the penultimate patch, it won't work
for iomap ... at least not in the same way.

