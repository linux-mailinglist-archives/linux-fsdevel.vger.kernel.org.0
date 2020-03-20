Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78718D632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCTRsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 13:48:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTRsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=REJDSQBSjlxGvUa9yFvVpoZkbE4uGtyMxtUffkDr/yg=; b=h1KzauchMVn1GcHidDQlLm4NDv
        aK4kqaKyat0c5S0apNaFmVi2M8lBpKqc6HcaPGEx+FFNw4NjYR32w5n0WAiLlaQiNyEfedB+7qoTL
        E/THmbYmMV4oouS6HA97h/6mPTqu5anVComDHxmPW4cHFSSyakaX+gQtXZhMNNfMHvVSjwaoJ0h2L
        OUdg+DUV4zfIM1jYNB9gSyndXuMPQpPpoePO6Xnc1zLjP/inzuV8mvsbNGEKjizrXkCo/5ONaqRd7
        SqjRvCtsua+M1JEUo9eCXIRJNJsizFMS59zha5v/io1cPAKUeptHjpuXzj4A/3UtnQK12YL/XylLS
        RApjCAiA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFLlI-0000w5-Ps; Fri, 20 Mar 2020 17:48:48 +0000
Date:   Fri, 20 Mar 2020 10:48:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v9 20/25] ext4: Convert from readpages to readahead
Message-ID: <20200320174848.GC4971@bombadil.infradead.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-21-willy@infradead.org>
 <20200320173734.GD851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320173734.GD851@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 10:37:34AM -0700, Eric Biggers wrote:
> On Fri, Mar 20, 2020 at 07:22:26AM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Use the new readahead operation in ext4
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> > ---
> >  fs/ext4/ext4.h     |  3 +--
> >  fs/ext4/inode.c    | 21 +++++++++------------
> >  fs/ext4/readpage.c | 22 ++++++++--------------
> >  3 files changed, 18 insertions(+), 28 deletions(-)
> > 
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> 
> > +		if (rac) {
> > +			page = readahead_page(rac);
> >  			prefetchw(&page->flags);
> > -			list_del(&page->lru);
> > -			if (add_to_page_cache_lru(page, mapping, page->index,
> > -				  readahead_gfp_mask(mapping)))
> > -				goto next_page;
> >  		}
> 
> Maybe the prefetchw(&page->flags) should be included in readahead_page()?
> Most of the callers do it.

I did notice that a lot of callers do that.  I wonder whether it (still)
helps or whether it's just cargo-cult programming.  It can't possibly
have helped before because we did list_del(&page->lru) as the very next
instruction after prefetchw(), and they're in the same cacheline.  It'd
be interesting to take it out and see what happens to performance.
