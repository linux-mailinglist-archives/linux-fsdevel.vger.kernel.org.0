Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2394E3B3A62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 03:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhFYBJM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 21:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhFYBJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 21:09:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07795C061574;
        Thu, 24 Jun 2021 18:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=75x3o/LLpUmcnmMdiNuX/QqKwobp8pWOsJCf5zrhlJU=; b=V3NapWBDw5+ExN0SrnGlwzNJMp
        FvRPSyqytvp2zXlNo/qeWnX0y+4G4m2/Be/1J5TXmb+v/4175Jzfuy1jDaezkwb62TXHxdo1dE4K1
        BiQePoFmNsofJo1J6Vy65rliAa4wvbrz5M3M1NULBKM4xCkKRKUekXNJhdj6qkiFQ7nMMrZIKJM07
        DQVHrhT6cNqc6ywnsEwRZTtji/3vF9UwJ+PIGn2usuRg9w40/Cy9SA3u2RZdV25rqMrpAb7nWpUaY
        GU5MaFTBxmG0dTRe7PowRjiFO+ouVJNgXWagdgZse7t9/qe03nqEhyYKcejIVTgiVDz90h+koM66I
        7Us6Rorw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwaIP-00HBIq-Dq; Fri, 25 Jun 2021 01:06:23 +0000
Date:   Fri, 25 Jun 2021 02:06:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 41/46] mm/page_alloc: Add folio allocation functions
Message-ID: <YNUsBapCxhEr3/iL@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-42-willy@infradead.org>
 <YNMFqhRS+GK2YK8h@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMFqhRS+GK2YK8h@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:58:02AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:46PM +0100, Matthew Wilcox (Oracle) wrote:
> > +static inline
> > +struct folio *__alloc_folio_node(gfp_t gfp, unsigned int order, int nid)
> 
> Weirdo prototype formatting.
> 
> Otherwise looks good (assuming we grow callers):

The next patch adds filemap_alloc_folio() which uses these.  That then
gets used in "mm/filemap: Add filemap_get_folio", which is the patch
after that.

Now that I look at this patch again, I wonder if this shouldn't be
folio_alloc(), __folio_alloc() and __folio_alloc_node.  And even though
I have no users yet, completing the set with folio_alloc_node() might
be a good idea.

> Reviewed-by: Christoph Hellwig <hch@lst.de>
