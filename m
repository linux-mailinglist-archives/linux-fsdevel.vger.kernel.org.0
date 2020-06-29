Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D720E41D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgF2VVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbgF2Swn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:43 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDEC031C79
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EzpP6/tXVbYmUjkIkwNB4TNbA0hvgYre2cHIlKy78VY=; b=a+hxoc/wudqJ8fuDdCjBXKmUN/
        tMZ+1aHfHQgSQi0zR0LrFrQccoIlxj4biTORp9xc7PJ13llbn3/XJUMvmqc1ljeSf8gFxnVAXXjL9
        bvLZyi6HF38DftSqlsQFJwe4yIp6BgWccG/E2jHuOETvda3TUT+4LSclubcfoBuQo6Xym768X1Yoy
        U+VHxOma/oKZxJvX6V+Lzx8bLckXtuh5GZLZGskHHL+w59C+IXt+Zi8GyacYDI51JYPvIZRdjNMri
        IyLUDKXjr8Vb/M+nPbzZR86RAnrCV8fczWbWbJafD+ULCiddFLL/CwzPqmB4xi8kScyFHCt8kO4yV
        TBQKOHzw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyIi-0005YS-40; Mon, 29 Jun 2020 18:14:40 +0000
Date:   Mon, 29 Jun 2020 19:14:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/7] mm: Replace hpage_nr_pages with thp_nr_pages
Message-ID: <20200629181440.GG25523@casper.infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
 <20200629151959.15779-6-willy@infradead.org>
 <8bf5ae79-eace-5345-1a77-69d9e2e083b3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf5ae79-eace-5345-1a77-69d9e2e083b3@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:40:12AM -0700, Mike Kravetz wrote:
> > +++ b/mm/hugetlb.c
> > @@ -1593,7 +1593,7 @@ static struct address_space *_get_hugetlb_page_mapping(struct page *hpage)
> >  
> >  	/* Use first found vma */
> >  	pgoff_start = page_to_pgoff(hpage);
> > -	pgoff_end = pgoff_start + hpage_nr_pages(hpage) - 1;
> > +	pgoff_end = pgoff_start + thp_nr_pages(hpage) - 1;
> >  	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
> >  					pgoff_start, pgoff_end) {
> >  		struct vm_area_struct *vma = avc->vma;
> 
> Naming consistency is a good idea!
> 
> I was wondering why hugetlb code would be calling a 'thp related' routine.
> The reason is that hpage_nr_pages was incorrectly added (by me) to get the
> number of pages in a hugetlb page.  If the name of the routine was thp_nr_pages
> as proposed, I would not have made this mistake.
> 
> I will provide a patch to change the above hpage_nr_pages call to
> pages_per_huge_page(page_hstate()).

Thank you!  Clearly I wasn't thinking about this patch and just did a
mindless search-and-replace!  I should evaluate the other places where
I did this and see if any of them are wrong too.
