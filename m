Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B091B3CAF21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhGOWb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhGOWb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:31:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEBC06175F;
        Thu, 15 Jul 2021 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pNcRIzV0WfWPp30XWVZN7R6wll8SWE/xO2pHaU3Fz5Q=; b=lWA/47usW8dcIhsdbVQReIK3Et
        0GpByjW+BnwwQh/GGIBKXu7vfa1UFXyt4ZUsvnXDDfyUaYkXh/1l3k4bKjut4He9RqR7BLGVMiM4K
        GiRPreg+YpBttafzA6SICrOqymN93mmXCwXW5G67AzGzTgrzlzGErq4THkT9o8mMPbI1/6f40GlsG
        +J9aFqgpFOASnEelIE/G5ICWvPQFw2nC1m8dUOLVyBhHA0GIvwXLdUVaV3BolYoBuxLsIiIUZHzVG
        i6xLypdklO0GQ0LIS1Q7AuBVtZ3ve8TgLE1NOtefqyZYws6Ifc2AfQCOI58pBTz456li9XEZrAmMB
        EJzZXvJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m49pW-003w3v-Kt; Thu, 15 Jul 2021 22:27:49 +0000
Date:   Thu, 15 Jul 2021 23:27:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 090/138] block: Add bio_add_folio()
Message-ID: <YPC2XmlBEQV03UWM@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-91-willy@infradead.org>
 <20210715205917.GC22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715205917.GC22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 01:59:17PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 04:36:16AM +0100, Matthew Wilcox (Oracle) wrote:
> > This is a thin wrapper around bio_add_page().  The main advantage here
> > is the documentation that the submitter can expect to see folios in the
> > completion handler, and that stupidly large folios are not supported.
> > It's not currently possible to allocate stupidly large folios, but if
> > it ever becomes possible, this function will fail gracefully instead of
> > doing I/O to the wrong bytes.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  block/bio.c         | 21 +++++++++++++++++++++
> >  include/linux/bio.h |  3 ++-
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 1fab762e079b..1b500611d25c 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -933,6 +933,27 @@ int bio_add_page(struct bio *bio, struct page *page,
> >  }
> >  EXPORT_SYMBOL(bio_add_page);
> >  
> > +/**
> > + * bio_add_folio - Attempt to add part of a folio to a bio.
> > + * @bio: Bio to add to.
> > + * @folio: Folio to add.
> > + * @len: How many bytes from the folio to add.
> > + * @off: First byte in this folio to add.
> > + *
> > + * Always uses the head page of the folio in the bio.  If a submitter
> > + * only uses bio_add_folio(), it can count on never seeing tail pages
> > + * in the completion routine.  BIOs do not support folios larger than 2GiB.
> > + *
> > + * Return: The number of bytes from this folio added to the bio.
> > + */
> > +size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> > +		size_t off)
> > +{
> > +	if (len > UINT_MAX || off > UINT_MAX)
> 
> Er... if bios don't support folios larger than 2GB, then why check @off
> and @len against UINT_MAX, which is ~4GB?

I suppose that's mostly a documentation problem.  The limit is:

struct bio_vec {
        struct page     *bv_page;
        unsigned int    bv_len;
        unsigned int    bv_offset;
};

so we can support folios which are 2GB in size (0x8000'0000) bytes, but
if (theoretically, some day) we had a 4GB folio, we wouldn't be able to
handle it in a single bio_vec.  So there isn't anything between a 2GB
folio and a 4GB folio; a 4GB folio isn't allowed and a 2GB one is.

I don't think anything's wrong here, but maybe things could be worded
better?
