Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424A73B39D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 01:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhFXXst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 19:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhFXXss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 19:48:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4A8C061574;
        Thu, 24 Jun 2021 16:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QRrsLI7GGtnqIpUE1NhSb681pP7OUT+FkfN9iRVIhgw=; b=GJ0asLtE8az/ZgBHMAI9w7Prf9
        L8WTI6fB1EWZRk/qyvEREMqkwJ8oywPKhvvgUyUDoAuQTHIrV8iDR4fYiUe1l9UoYKJRDkO5um6gh
        GUf86KTBuZhSqe0iSC8d6BUCqdKniy7grkD91FLG/Hef7gDnCXp3j8d2Ymc7iCaSKvVObDSHGIhls
        oHkxLDdhceP/dTqsszWlTnQ72hg0QMcJvR9TtJXio2dVUT0ys6IxASFmxoi2hWrfiZBlMsT70jhCt
        08Ey8o1J97NPj00WRZA9qWrmqiGSD/3dcovCMX1cPFwL58IDh9gR9GY8vW6w+xW1lSgDtsQfHv+Va
        834cJ0Hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwZ2v-00H7K5-3Q; Thu, 24 Jun 2021 23:46:12 +0000
Date:   Fri, 25 Jun 2021 00:46:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 36/46] mm/filemap: Add readahead_folio()
Message-ID: <YNUZQWvhSnVK0IUe@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-37-willy@infradead.org>
 <YNMDzHwIA4neIPDD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMDzHwIA4neIPDD@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:50:04AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:41PM +0100, Matthew Wilcox (Oracle) wrote:
> > The pointers stored in the page cache are folios, by definition.
> > This change comes with a behaviour change -- callers of readahead_folio()
> > are no longer required to put the page reference themselves.  This matches
> > how readpage works, rather than matching how readpages used to work.
> 
> The way this stores and retrieves different but compatible types from the
> same xarray is a little nasty.  But I guess we'll have to live with it for
> now, so:

I think that's mostly fixed up by the end of this series.  I think
there's still a few bits which are currently postponed to series 4
(eg uses of __page_cache_alloc followed by add_to_page_cache_lru).

> Reviewed-by: Christoph Hellwig <hch@lst.de>
