Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01273CF915
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 13:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhGTLGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbhGTLEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:04:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08536C0613E4;
        Tue, 20 Jul 2021 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ttlOaivC03YsJ7TBE/oQQyfqlAgy1q5eYHsgF1bddgA=; b=A+xbrWSa0Yw/Jyi3Q4wQSRpr68
        xPWPtNtyo1giAkrFLO2yAihOpnSmt1zB+koMdFPOqlVJz7NfV1MtLFLMzD1U47xtpyqrQ+q7NtLxl
        8Jv0aey8pPiRsyNv9vf3Yj5KDMyRATYIz3w6/x0djWMEZwe7BQc+Mktqu7oiGUYsY+rCuwE3wdpfK
        RCqHIUt6qp7/4fuCpWXA6JpcqUuDKgObTW2K925qORegWX6QB8uT82ehZEoEaLk1vaRZyKlWvV6g2
        gYuygYEH/wnMiD9o0FnBAk8cbuTtfde3JtDDYhbwNq2OWY1kibj2eFOyZha0hk9gCGyJv7K3soqFo
        EIPvouJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5o9C-0083gt-N3; Tue, 20 Jul 2021 11:43:07 +0000
Date:   Tue, 20 Jul 2021 12:42:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 09/17] iomap: Use folio offsets instead of page
 offsets
Message-ID: <YPa2ur9sZ3xl/dDw@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-10-willy@infradead.org>
 <YPZ0YYF/7F+HG1o+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPZ0YYF/7F+HG1o+@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 08:59:45AM +0200, Christoph Hellwig wrote:
> > +	size_t poff = offset_in_folio(folio, *pos);
> > +	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
> 
> These variables are a little misnamed now.  But I'm not sure what a
> better name would be.

Yes, foff and flen would be ambiguous -- is f folio or file?  I tend
to prefer 'offset' and 'length', but we already have a loff_t length
and having both a len and a length isn't conducive to understanding.
Maybe rename loff_t length to extent_len?

I'm going to leave it for now unless we have a really good suggestion.

> > +		size_t off = (page - &folio->page) * PAGE_SIZE +
> > +				bvec->bv_offset;
> 
> Another use case for the helper I suggested earlier.

Deleted in the very next patch, alas.
