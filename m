Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A635A2A4928
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgKCPNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgKCPMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F175C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aEj7VJo4jHCO8dIN63ejx7SuEQPe8te1s6UytFTRalo=; b=rORpTKuEzWg6zupj3sWK1SrP48
        1v8oEFE+khacoJ5lLqShxy7KzdjtAyLpWN0223WSgiZKGVRY5kro6ao42kpqfsTtohk99K1uUfnbj
        aVhhK4DIAz04YXvCejvCsyCdvrKcZySnA5EWxMBfUNm0awmwZgjhJj6EF4g44Z+qIUE9iHddO3SmB
        inpMl9SXGpj3MuC1tRVWBHE/Uy4EOH6VNBExgO4BOrdkv1WYeuY8Im1m7ZRq35uMN/qHG5+a41K4I
        CtmHtqYfFlw1isSjn/+43aN88zNnxgG6/g0+2+ZHJUMeiufH9cy1zHoehw3HEfhQuYuu2GMIhMG/7
        3kQbJjfg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZxyZ-0005OX-HS; Tue, 03 Nov 2020 15:11:59 +0000
Date:   Tue, 3 Nov 2020 15:11:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 07/17] mm/filemap: Change filemap_read_page calling
 conventions
Message-ID: <20201103151159.GY27442@casper.infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-8-willy@infradead.org>
 <20201103073427.GG8389@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103073427.GG8389@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 08:34:27AM +0100, Christoph Hellwig wrote:
> > +static int filemap_read_page(struct file *file, struct address_space *mapping,
> > +		struct page *page)
> 
> I still think we should drop the mapping argument as well.

Feels a little weird to have it in the caller and not pass it in.

> > +	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
> > +		unlock_page(page);
> > +		put_page(page);
> > +		return ERR_PTR(-EAGAIN);
> > +	}
> > +	error = filemap_read_page(iocb->ki_filp, mapping, page);
> > +	if (!error)
> > +		return page;
> 
> I think a goto error for the error cases would be much more useful.
> That would allow to also share the error put_page for the flag check
> above and the truncated case below, but most importantly make the code
> flow obvious vs the early return for the success case.

In this patch, I'm trying to be obvious about the code motion between
the two functions.  This gets straightened out eventually:

        if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
                unlock_page(page);
                error = -EAGAIN;
        } else {
                error = filemap_read_page(iocb->ki_filp, mapping, page);
                if (!error)
                        return 0;
        }
error:
        put_page(page);
        return error;

