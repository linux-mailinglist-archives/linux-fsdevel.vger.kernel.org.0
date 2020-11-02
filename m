Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3022A338F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKBTDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgKBTDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:03:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E342BC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iu/ELk0oTaWr4xo8QIwbD6ymrUOmLRRWxZ5jFz+Ejrs=; b=Wdd3QXKdMH77MIOCf67Vxy1WJM
        CO7erxPwKgcLLjg48twfx39Us8BhYeQTRaWxpBMsYj0XxIkqn7I1McQTxT7DqyaNiS5k7R+Aq0tRi
        Q5goGoCSDg+gFBKNSKvzCUL3h7qeeQEEXT+megkQrmeMTau2yUE35ZUXLpQ9akJcdyqmCFrVkS6BG
        U2ijw+9KSqywkdcur3aoNvsST1HDmtnR4QUxugu5KjkX5wFscvlNzIt8RBm37msjx6WTyWoC/4IsB
        X5B8Y324kteaKfXNbvvlVPyoxTx3GvcsgD9oY0XOGyoe0J7x7hXXsBOORov91ETxxTcrxMwK45Nzi
        1TMuXL7w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZf78-00088k-FO; Mon, 02 Nov 2020 19:03:34 +0000
Date:   Mon, 2 Nov 2020 19:03:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 04/17] mm/filemap: Support readpage splitting a page
Message-ID: <20201102190334.GQ27442@casper.infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-5-willy@infradead.org>
 <20201102190008.GG2123636@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102190008.GG2123636@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:00:08PM -0500, Kent Overstreet wrote:
(snipped the deleted lines for clarity)
> >  	if (iocb->ki_flags & IOCB_WAITQ) {
> > +		error = lock_page_async(page, iocb->ki_waitq);
> > +		if (error) {
> > +			put_page(page);
> > +			return ERR_PTR(error);
> > +		}
> >  	} else {
> > +		if (!trylock_page(page)) {
> > +			put_and_wait_on_page_locked(page, TASK_KILLABLE);
> > +			return NULL;
> > +		}
> >  	}
> >  
> > +	if (!page->mapping)
> > +		goto truncated;
> 
> Since we're dropping our ref to the page, it could potentially be truncated and
> then reused, no? So we should be checking page->mapping == mapping &&
> page->index == index (and stashing page->index before dropping our ref, or
> passing it in).

If we get to this point, then we _didn't_ drop our ref to the page.
All the paths above that call put_page() then return.

