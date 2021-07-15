Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888903CAF3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhGOWlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhGOWlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:41:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45BC06175F;
        Thu, 15 Jul 2021 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rqwv+/Mw6cZWzpgmEoo2CyIEE0qUzcO+Ut9DGb/HsXI=; b=tb9XoimIskcyhZCM4kV/yubjzv
        /UiD8uTSSKpunCgDKXzIvVXVvAaWjRNsOW+fZCXx1XAYpFcHj4OFdYKIVnkv7kvWGgwkiV7LtUn+f
        +iMTDL/9xJHCqY/H7KhKeLtsPUe7bTGFYHLlwUIy/03ErZYLZsBylRVx6xC9jETcA9//sBAu0pF5d
        lfOaxfQCQZmbvnpldkXqEpd4xt5V5FDfGHJzo8Mx6rg4CqKs6YYhDbQ0JXsDAWQ6ScVjSg3sbZyy4
        7SejW3rNo4zSjtRm2t/4rWiuM2WHda1BgrJt9Nlo/Z6Rl7bwX70Z2WTZF8QdzjFs6csLmAxupwQTx
        s5ZSjpOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m49zk-003wQ5-T3; Thu, 15 Jul 2021 22:38:31 +0000
Date:   Thu, 15 Jul 2021 23:38:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 091/138] block: Add bio_for_each_folio_all()
Message-ID: <YPC42HLsgmGB/o/+@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-92-willy@infradead.org>
 <20210715211254.GE22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715211254.GE22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 02:12:54PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 04:36:17AM +0100, Matthew Wilcox (Oracle) wrote:
> > +struct folio_iter {
> > +	struct folio *folio;
> > +	size_t offset;
> > +	size_t length;
> 
> Hm... so after every bio_{first,next}_folio call, we can access the
> folio, the offset, and the length (both in units of bytes) within the
> folio?

Correct.

> > +	size_t _seg_count;
> > +	int _i;
> 
> And these are private variables that the iteration code should not
> scribble over?

Indeed!

> > +/*
> > + * Iterate over each folio in a bio.
> > + */
> > +#define bio_for_each_folio_all(fi, bio)				\
> > +	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))
> 
> ...so I guess a sample iteration loop would be something like:
> 
> 	struct bio *bio = <get one from somewhere>;
> 	struct folio_iter fi;
> 
> 	bio_for_each_folio_all(fi, bio) {
> 		if (folio_test_dirty(fi.folio))
> 			printk("folio idx 0x%lx is dirty, i hates dirty data!",
> 					folio_index(fi.folio));
> 			panic();
> 	}
> 
> I'll go look through the rest of the patches, but this so far looks
> pretty straightforward to me.

Something very much like that!

+static void iomap_read_end_io(struct bio *bio)
 {
+       struct folio_iter fi;
+       bio_for_each_folio_all(fi, bio)
+               iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);

