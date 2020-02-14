Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDB15EE8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 18:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390114AbgBNRl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 12:41:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389712AbgBNQDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vWvhCkmP10pOefEokptjf5gNpQByGXrHCLm2fjpQLRQ=; b=VCS5visrKpAL+Ru5FY/G0h94PF
        MRs9RZXEy+XhvvLBu4HzE+Ed33L6Z0f2KGHW7sJVb06H30RZt6ZdaFnl4TIHuT+93DBWIdiEkdl12
        VyGaJAUCFsfCeiNV0jSSN4Lz7qORyUBqbLb/AraVAK+XDJgVeTipoyvmuMDWCzqpmBLE1JAqt/HAc
        Y1hrahhKXOY3jcxwcCxFt9iofsSXg9l5AW6BNd/82HfepDdNRDi1Vtj3TioDDl+oenDnmaflYS4NT
        eN3yRu+nLR5BBbhfQryyJ7xcU9/53ByshYrmJL2RtsfJb6QOkdsVKfp2AvvokNsEL5MZd2vn5Qt/n
        V/xyxDOw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2dRO-00022S-7n; Fri, 14 Feb 2020 16:03:42 +0000
Date:   Fri, 14 Feb 2020 08:03:42 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/25] fs: Add zero_user_large
Message-ID: <20200214160342.GA7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-14-willy@infradead.org>
 <20200214135248.zqcqx3erb4pnlvmu@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214135248.zqcqx3erb4pnlvmu@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:52:48PM +0300, Kirill A. Shutemov wrote:
> On Tue, Feb 11, 2020 at 08:18:33PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > We can't kmap() a THP, so add a wrapper around zero_user() for large
> > pages.
> 
> I would rather address it closer to the root: make zero_user_segments()
> handle compound pages.

Hah.  I ended up doing that, but hadn't sent it out.  I don't like
how ugly it is:

@@ -219,18 +219,57 @@ static inline void zero_user_segments(struct page *page,
        unsigned start1, unsigned end1,
        unsigned start2, unsigned end2)
 {
-       void *kaddr = kmap_atomic(page);
-
-       BUG_ON(end1 > PAGE_SIZE || end2 > PAGE_SIZE);
-
-       if (end1 > start1)
-               memset(kaddr + start1, 0, end1 - start1);
-
-       if (end2 > start2)
-               memset(kaddr + start2, 0, end2 - start2);
-
-       kunmap_atomic(kaddr);
-       flush_dcache_page(page);
+       unsigned int i;
+
+       BUG_ON(end1 > thp_size(page) || end2 > thp_size(page));
+
+       for (i = 0; i < hpage_nr_pages(page); i++) {
+               void *kaddr;
+               unsigned this_end;
+
+               if (end1 == 0 && start2 >= PAGE_SIZE) {
+                       start2 -= PAGE_SIZE;
+                       end2 -= PAGE_SIZE;
+                       continue;
+               }
+
+               if (start1 >= PAGE_SIZE) {
+                       start1 -= PAGE_SIZE;
+                       end1 -= PAGE_SIZE;
+                       if (start2) {
+                               start2 -= PAGE_SIZE;
+                               end2 -= PAGE_SIZE;
+                       }
+                       continue;
+               }
+
+               kaddr = kmap_atomic(page + i);
+
+               this_end = min_t(unsigned, end1, PAGE_SIZE);
+               if (end1 > start1)
+                       memset(kaddr + start1, 0, this_end - start1);
+               end1 -= this_end;
+               start1 = 0;
+
+               if (start2 >= PAGE_SIZE) {
+                       start2 -= PAGE_SIZE;
+                       end2 -= PAGE_SIZE;
+               } else {
+                       this_end = min_t(unsigned, end2, PAGE_SIZE);
+                       if (end2 > start2)
+                               memset(kaddr + start2, 0, this_end - start2);
+                       end2 -= this_end;
+                       start2 = 0;
+               }
+
+               kunmap_atomic(kaddr);
+               flush_dcache_page(page + i);
+
+               if (!end1 && !end2)
+                       break;
+       }
+
+       BUG_ON((start1 | start2 | end1 | end2) != 0);
 }

I think at this point it has to move out-of-line too.

> > +static inline void zero_user_large(struct page *page,
> > +		unsigned start, unsigned size)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < thp_order(page); i++) {
> > +		if (start > PAGE_SIZE) {
> 
> Off-by-one? >= ?

Good catch; I'd also noticed that when I came to redo the zero_user_segments().

