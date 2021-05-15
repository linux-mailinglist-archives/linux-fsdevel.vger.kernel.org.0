Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484103819B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 May 2021 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhEOPxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 May 2021 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhEOPxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 May 2021 11:53:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD8C06174A;
        Sat, 15 May 2021 08:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IaWx73PoXKzw/QNbHeKdp9HvTY0/GoR4xc8LobmdnCc=; b=GhRi4lJHdfK6UCyrz8P5P7Vg7x
        L4emzVRzmleOj5EksAxcn5Hqd2HjLrNz0BDRjQxzk6q48DfVORoETkcy7yM7271JvxfO2hcbGp/eq
        yhh704cJ1DLbmxd46u+TLpvjbpaoARCiD1WgG5SL1H/PHsRARoF2jn5GBnLwusIHU4kyAeqF/P6UY
        xYR08XU7P6u9C5+5b5EWX5nyR834e8aQkTi+/3Jy3GDo/msiDNVZsOE2kMM8UOu+Je2wNVw8c9UOB
        nBKj1xRBxifK8X1G6Rd/vEp+XP3o70S+QAnadbht+cXtnQY6rmoSSy0CyO7L8PJ0+sBPR/41Vo+Sx
        LttRK2bg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhwZm-00BLCZ-R7; Sat, 15 May 2021 15:51:41 +0000
Date:   Sat, 15 May 2021 16:51:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 12/33] mm/filemap: Add folio_index, folio_file_page
 and folio_contains
Message-ID: <YJ/uCv8iwWYYXqVQ@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-13-willy@infradead.org>
 <77357d4f-5f56-6c12-7602-697773c2f125@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77357d4f-5f56-6c12-7602-697773c2f125@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 05:55:46PM +0200, Vlastimil Babka wrote:
> On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> > folio_index() is the equivalent of page_index() for folios.
> > folio_file_page() is the equivalent of find_subpage().
> 
> find_subpage() special cases hugetlbfs, folio_file_page() doesn't.
> 
> > folio_contains() is the equivalent of thp_contains().
> 
> Yet here, both thp_contains() and folio_contains() does.
> 
> This patch doesn't add users so maybe it becomes obvious later, but perhaps
> worth explaining in the changelog or comment?

No, you're right, this is a bug.

I originally had it in my mind that hugetlbfs wouldn't need to do this
any more because it can just use the folio interfaces and never try to
find the subpage.

But I don't understand all the cases well enough to be sure that
they're all gone, and they certainly don't all go as part of this
patch series.  So I think I need to reintroduce the check-for-hugetlb
to folio_file_page() and we can look at removing it later once we're
sure that nobody is using the interfaces that return pages from the page
cache any more.  Or we convert hugetlbfs to use the page cache the same
way as every other filesystem ;-)

Thanks for spotting that.
