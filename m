Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0767544507C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 09:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhKDIl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDIl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:41:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370DBC061714;
        Thu,  4 Nov 2021 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Z3qZq5MUEoDWPLeBRHYP9o1KIVIGNuaMXfbOKsIkY4=; b=RxMrL7MH99hMKk6Gs5eYutueQO
        Ums+y+hY8WsLMDJl6GlpfIoPPmjhcKQhcpueY1GJSkIHRnJTCcnhH2SeeQWCFCN9bkIevL/5Y+EcO
        F/2mRbaWyJIOuA9wAZ1i03S5HtU+LM04rezQYbx28JpzNmLAB+5xtqmfaLyh/FH+xAJPg9byf3b4F
        eo2RmuEPmsWZYAz4eb34OsY3y4hgdcug7cCIxa85QLg3NsawuGhgmkM6R3yR9uB2oWqe2vHI0qWo6
        PfWBoRMwKG5twnQYzQqyQoRVEc3u6xAj6001td90k1L//2wJQvXPciuw31x9v6bzpZ4nt2+aLgHN/
        HQnIOIDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miYGm-008Ktc-6U; Thu, 04 Nov 2021 08:38:48 +0000
Date:   Thu, 4 Nov 2021 01:38:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 18/21] iomap: Convert iomap_add_to_ioend to take a folio
Message-ID: <YYOcGK43XbnumvHi@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-19-willy@infradead.org>
 <YYDoMltwjNKtJaWR@infradead.org>
 <YYGfUuItAyTNax5V@casper.infradead.org>
 <YYKwyudsHOmPthUP@infradead.org>
 <YYNUoONKjuo6Izfz@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYNUoONKjuo6Izfz@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 03:33:52AM +0000, Matthew Wilcox wrote:
> On Wed, Nov 03, 2021 at 08:54:50AM -0700, Christoph Hellwig wrote:
> > > -	 * Walk through the page to find areas to write back. If we run off the
> > > -	 * end of the current map or find the current map invalid, grab a new
> > > -	 * one.
> > > +	 * Walk through the folio to find areas to write back. If we
> > > +	 * run off the end of the current map or find the current map
> > > +	 * invalid, grab a new one.
> > 
> > No real need for reflowing the comment, it still fits just fine even
> > with the folio change.
> 
> Sure, but I don't like using column 79, unless it's better to.  We're on
> three lines anyway; may as well make better use of that third line.

Ok, tht's a little weird but a personal preference.  That being said
reflowing the whole comment just for that seems odd.

> 
> > > +	isize = i_size_read(inode);
> > > +	end_pos = page_offset(page) + PAGE_SIZE;
> > > +	if (end_pos - 1 >= isize) {
> > 
> > Wouldn't this check be more obvious as:
> > 
> > 	if (end_pos > i_size) {
> 
> I _think_ we restrict the maximum file size to 2^63 - 1 to avoid i_size
> ever being negative.  But that means that end_pos might be 2^63 (ie
> LONG_MIN), so we need to subtract one from it to get the right answer.
> Maybe worth a comment?

Yes, please.
