Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7947E64C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349149AbhLWQUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 11:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhLWQUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:20:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C92C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DGJvL8bUMB2uaId69Tgazf7a4NU+KVKfAjwBVfeZ/7s=; b=E/vIccKsYBOscl4TNK96w5S+F/
        n89yVdPoDDptRbfZ6ul9Wq7Jkxuyv12cKFp1GRLrpBLNpLxn72VlGfDzezrBlURo87XZjxEhPFKLn
        x6eP9pbRgDYo5n/oa30ylaFAUlhO//W+5c5HKmkqodLlZeQyx8qKOnxeSdqPEUfGNCPhD7eQF1zAt
        Rym6UUSMx9OarI1LEjgGIQctKNunpbeRhkKI4KPE1tqmotRqN5WfprDLdiv8xRhUynrNZZ8IVNflG
        VL1jWv2rRzmLNiaR2rnRWiRL7oihUT+L0a0OdeJh597FV/NwqQYXJAsa1R9pfSwQYQqqEMrHe4sL9
        t/NgUihw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0QpF-004PFY-Mm; Thu, 23 Dec 2021 16:20:17 +0000
Date:   Thu, 23 Dec 2021 16:20:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 25/48] filemap: Add read_cache_folio and
 read_mapping_folio
Message-ID: <YcShwQgTJYNRhdSy@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-26-willy@infradead.org>
 <YcQlbjBKzMlGOLI7@infradead.org>
 <YcSTSnTYINYgkMhJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcSTSnTYINYgkMhJ@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 03:18:34PM +0000, Matthew Wilcox wrote:
> > > +static struct page *do_read_cache_page(struct address_space *mapping,
> > > +		pgoff_t index, filler_t *filler, void *data, gfp_t gfp)
> > > +{
> > > +	struct folio *folio = read_cache_folio(mapping, index, filler, data);
> > > +	if (IS_ERR(folio))
> > > +		return &folio->page;
> > > +	return folio_file_page(folio, index);
> > > +}
> > 
> > This drops the gfp on the floor.
> 
> Oops.  Will fix.

For the record, this fix:

-       struct folio *folio = read_cache_folio(mapping, index, filler, data);
+       struct folio *folio;
+
+       folio = do_read_cache_folio(mapping, index, filler, data, gfp);

