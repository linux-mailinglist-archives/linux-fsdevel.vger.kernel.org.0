Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3D81230F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 16:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfLQP5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 10:57:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfLQP5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kh7RLBrfhygIj160kYZXJWkRFoPIBHeSbyStC3HJvJA=; b=V5AYwx43CYoKdWAkFoagj9z9j
        KT5PF42pnBpcKDNWuxwEfbAYg8X8UL/oEirRtdRUd1VIOvo1qvzNRTbX+vzFuiV3pXcO9wYBziKnF
        FrjapRjP59+4oLpiDiRVZ5b94MTO2q0t7YOBqmsUI4qg8Q46V0XouwQfBr9pQAazCZc7tPyYugHLt
        nRgGQxrQyOuGKmN7qeFG7vkqvx44wE7vwven2Qjeeo/q9/rCjNjPT0wWP8RMGD++goFGag/2QVQbn
        EX3RO0sWQ5xHEuaJ4sd64fU0x+PQ0N7V9U1zAb3RdGs41r+5kRUrANBNAR/y5J5yigAK91IQNvefx
        kdCC5B2/A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihFEL-0000r3-8L; Tue, 17 Dec 2019 15:57:49 +0000
Date:   Tue, 17 Dec 2019 07:57:49 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
Subject: Re: [PATCH 1/6] fs: add read support for RWF_UNCACHED
Message-ID: <20191217155749.GC32169@bombadil.infradead.org>
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217143948.26380-2-axboe@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 07:39:43AM -0700, Jens Axboe wrote:
> +static void buffered_put_page(struct page *page, bool clear_mapping)
> +{
> +	if (clear_mapping)
> +		page->mapping = NULL;
> +	put_page(page);
> +}

I'm not a huge fan of the variable name 'clear_mapping'.  It describes
what it does rather than why it does it.  So maybe 'drop_immediate'?
Or 'uncached'?

>  		if (!page) {
>  			if (iocb->ki_flags & IOCB_NOWAIT)
>  				goto would_block;
> +			/* UNCACHED implies no read-ahead */
> +			if (iocb->ki_flags & IOCB_UNCACHED) {
> +				did_dio_begin = true;
> +				/* block truncate for UNCACHED reads */
> +				inode_dio_begin(inode);

I think this needs to be:

				if (!did_dio_begin)
					inode_dio_begin(inode);
				did_dio_begin = true;

otherwise inode->i_dio_count is going to be increased once per uncached
page.  Do you have a test in your test-suite that does I/O to more than
one page at a time?

