Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C67164747
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 15:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBSOlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 09:41:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgBSOlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8IjL+yb/Cvlwh+xltU0HFRJYWZSYd/0FIacDvgc30so=; b=Eo/FW4XK2MuSbkpKnJbuW9HCuj
        73f56TSPDRJWs9q1g09/mEtWKWQ18dLecvixOGx9CQrSJtukF5EkaFwD5s1ht+yOHUqESKEvXDwPh
        0v+9/vEPWpbgPitIQ0XolL/sviBTw/NadpXb0u4CKascGnRG+HiMvDnBy0Jkt6uvI5gFKz3giVYlB
        Ck/tmLQEiMP713+GIAGDUXFKV2BakBAcoFfN+jeMAlvrKRVftT0bs67UdlA5WD5YSSloWQRhWWsuF
        MXO0LNm1doYTcnPW+W+SjPVPp2BkpvBSZrMWKMZnHtRlYVoCghmzLJdCT71Da+z4QJbJE1SoGqiJT
        7R18A8DA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4QXN-00044x-SK; Wed, 19 Feb 2020 14:41:17 +0000
Date:   Wed, 19 Feb 2020 06:41:17 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
Message-ID: <20200219144117.GP24185@bombadil.infradead.org>
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

I'll go you one better ... how about we do this instead:

static inline struct page *readahead_page(struct readahead_control *rac)
{
        struct page *page;

        BUG_ON(rac->_batch_count > rac->_nr_pages);
        rac->_nr_pages -= rac->_batch_count;
        rac->_index += rac->_batch_count;
        rac->_batch_count = 0;

        if (!rac->_nr_pages)
                return NULL;

        page = xa_load(&rac->mapping->i_pages, rac->_index);
        VM_BUG_ON_PAGE(!PageLocked(page), page);
        rac->_batch_count = hpage_nr_pages(page);

        return page;
}

#define readahead_for_each(rac, page)                                   \
        while ((page = readahead_page(rac)))

No more readahead_next() to forget to add to filesystems which don't use
the readahead_for_each() iterator.  Ahem.
