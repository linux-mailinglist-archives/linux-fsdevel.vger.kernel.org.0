Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF9351D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbhDASYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbhDASPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15637C05BD11;
        Thu,  1 Apr 2021 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yw41C/LM/CLkV/f2jz3URlFrp1rmhB03Zhe1Y9zc6w8=; b=VReZDpDt5aNf6kSFMIIU9tiZ9p
        5jBuVEp/WF4EuLT2Hz8powvl9pghjOFAizPU5QqGxMcTSuk5AlVDG7Rzp7vHscBL2WL0TQuQJcoNB
        x0M3qRg4kpC0vTnXlJxgPn+72DK0T1eUYtuMoLu8e/A6IiEJjVLlfctuB6CPjCh5eyenHHWvzrU0L
        o0P6LZ0dsT4WJsi6JYfJt8nhNvLEzQAZpr4sOcMV4YaUBxdSKHBZhfHmOzrLSXhxZx45e1jrHyrBC
        AKzBk8cRUSNvLbtv2B6nLwhzd1qQAd5DocwjB1H1ixZjYvH5kwC1SLLmit+KJ9coSwn2UTs06N8Ya
        UZqijUyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRwnp-0068jn-3I; Thu, 01 Apr 2021 12:52:05 +0000
Date:   Thu, 1 Apr 2021 13:52:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Memory Folios
Message-ID: <20210401125201.GD351017@casper.infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210401070537.GB1363493@infradead.org>
 <20210401112656.GA351017@casper.infradead.org>
 <20210401122803.GB2710221@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401122803.GB2710221@ziepe.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 09:28:03AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 01, 2021 at 12:26:56PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 01, 2021 at 08:05:37AM +0100, Christoph Hellwig wrote:
> > > On Wed, Mar 31, 2021 at 07:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > > >  - Mirror members of struct page (for pagecache / anon) into struct folio,
> > > >    so (eg) you can use folio->mapping instead of folio->page.mapping
> > > 
> > > Eww, why?
> > 
> > So that eventually we can rename page->mapping to page->_mapping and
> > prevent the bugs from people doing page->mapping on a tail page.  eg
> > https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2103102214170.7159@eggly.anvils/
> 
> Is that gcc structure layout randomization stuff going to be a problem
> here?
> 
> Add some 
>   static_assert(offsetof(struct folio,..) == offsetof(struct page,..))
> 
> tests to force it?

You sound like the kind of person who hasn't read patch 1.

diff --git a/mm/util.c b/mm/util.c
index 0b6dd9d81da7..521a772f06eb 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -686,6 +686,25 @@ struct anon_vma *page_anon_vma(struct page *page)
 	return __page_rmapping(page);
 }
 
+static inline void folio_build_bug(void)
+{
+#define FOLIO_MATCH(pg, fl)						\
+BUILD_BUG_ON(offsetof(struct page, pg) != offsetof(struct folio, fl));
+
+	FOLIO_MATCH(flags, flags);
+	FOLIO_MATCH(lru, lru);
+	FOLIO_MATCH(mapping, mapping);
+	FOLIO_MATCH(index, index);
+	FOLIO_MATCH(private, private);
+	FOLIO_MATCH(_mapcount, _mapcount);
+	FOLIO_MATCH(_refcount, _refcount);
+#ifdef CONFIG_MEMCG
+	FOLIO_MATCH(memcg_data, memcg_data);
+#endif
+#undef FOLIO_MATCH
+	BUILD_BUG_ON(sizeof(struct page) != sizeof(struct folio));
+}
+
 struct address_space *page_mapping(struct page *page)
 {
 	struct address_space *mapping;

