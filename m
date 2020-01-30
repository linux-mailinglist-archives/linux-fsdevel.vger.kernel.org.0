Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56FB14D74D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 09:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgA3IJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 03:09:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgA3IJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M5ZbHKICi2HCHWPo7NcspAReloIi1S4smHry3HeNIS8=; b=MnynihUMvJ8e6EA2HC9AKocUl
        WVMvKhATL/XZ9Aww/Q732xxEVkzWLDQlpsmOTBzwTlxTp0IFVTE5BDpPrBjs6VPkEWkS4g+aOzCYo
        0uL1VN5Z81VKhK0ZCYdiwLhp5kmIvTzjaGjOkNMShhDmj32fjcHUz5AdhAuCFJNZHtnBvdw9KZ2B0
        sGXdDNFdF7W50VYSfMQPILAIsW+yQie96s1KJIUAmfE2gForcKDPGSmFqu3DvUeoylEsA0CFv9lNC
        Bo78SV7g99Jgj4PYFJZKWsCCQ7co68TDK+bGs6NiQNGxwW1xijeFKW6PtRAFonVFigDFDY/sPFNSV
        1eHjOQ14w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ix4tQ-0007cd-0v; Thu, 30 Jan 2020 08:09:40 +0000
Date:   Thu, 30 Jan 2020 00:09:39 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/12] btrfs: Convert from readpages to readahead
Message-ID: <20200130080939.GL6615@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-7-willy@infradead.org>
 <20200129004609.GI18610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129004609.GI18610@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:46:09AM +1100, Dave Chinner wrote:
> On Fri, Jan 24, 2020 at 05:35:47PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Use the new readahead operation in btrfs
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: linux-btrfs@vger.kernel.org
> > ---
> >  fs/btrfs/extent_io.c | 15 ++++-----------
> >  fs/btrfs/extent_io.h |  2 +-
> >  fs/btrfs/inode.c     | 18 +++++++++---------
> >  3 files changed, 14 insertions(+), 21 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 2f4802f405a2..b1e2acbec165 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -4283,7 +4283,7 @@ int extent_writepages(struct address_space *mapping,
> >  	return ret;
> >  }
> >  
> > -int extent_readpages(struct address_space *mapping, struct list_head *pages,
> > +unsigned extent_readahead(struct address_space *mapping, pgoff_t start,
> >  		     unsigned nr_pages)
> >  {
> >  	struct bio *bio = NULL;
> > @@ -4294,20 +4294,13 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
> >  	int nr = 0;
> >  	u64 prev_em_start = (u64)-1;
> >  
> > -	while (!list_empty(pages)) {
> > +	while (nr_pages) {
> >  		u64 contig_end = 0;
> >  
> > -		for (nr = 0; nr < ARRAY_SIZE(pagepool) && !list_empty(pages);) {
> > -			struct page *page = lru_to_page(pages);
> > +		for (nr = 0; nr < ARRAY_SIZE(pagepool) && nr_pages--;) {
> 
> What is stopping nr_pages from going negative here, and then looping
> forever on the outer nr_pages loop? Perhaps "while(nr_pages > 0) {"
> would be better there?

Ugh, nr_pages is unsigned, so that's no good.  Maybe make this a more
conventional loop ...

        while (nr_pages) {
                u64 contig_end = 0;

                for (nr = 0; nr < ARRAY_SIZE(pagepool); nr++) {
                        struct page *page = readahead_page(mapping, start++);

                        prefetchw(&page->flags);
                        pagepool[nr] = page;
                        contig_end = page_offset(page) + PAGE_SIZE - 1;
                        if (--nr_pages == 0)
                                break;
                }

