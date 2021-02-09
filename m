Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616253149BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 08:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhBIHwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 02:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBIHwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:52:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45783C061788
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 23:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EM9ebD6T3YZ87BljQm1u4zKY1Qrjyi/gchis3HgKbnk=; b=YGzn4qrByn1VVeMq+/1eaeN9Bn
        uXSEv/OlTWPm/BeEW/Kdhl/HT4f3R2hEMOrm0KZbsVggbBQT2XTHY1LJJY/kgK/4Xge7Ix39IvtyE
        vtM7hvsEnqZyAqbQPQQxZ4SqWmZdd/X16PB4/Xvjsq4e6Ltx2kjixVl9TYr3KfGjz81Z5hYInRh66
        49gPC/oC4Cn8J1ommGY/szMCvKXH/We41B4v7Z2WqOPtR7aHkopBzuj6lvjUn6jdIkqZHWwt2dkPL
        ynISjv/1nWkjiPs1Xeo10zf0Ju/iiawOK2TOcGS7RwT7MWixnxJj2HfxwG7f1ko1kuwawzTf3j0Dk
        qu0TPG4g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9Nnr-0077sW-Us; Tue, 09 Feb 2021 07:51:21 +0000
Date:   Tue, 9 Feb 2021 07:51:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3/3] iomap: use filemap_range_needs_writeback() for
 O_DIRECT reads
Message-ID: <20210209075119.GC1696555@infradead.org>
References: <20210209023008.76263-1-axboe@kernel.dk>
 <20210209023008.76263-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209023008.76263-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 07:30:08PM -0700, Jens Axboe wrote:
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
> +			if (filemap_range_needs_writeback(mapping, pos, end)) {
> +				ret = -EAGAIN;
> +				goto out_free_dio;
> +			}
> +			flags |= IOMAP_NOWAIT;
> +		}
>  		if (iter_is_iovec(iter))
>  			dio->flags |= IOMAP_DIO_DIRTY;
>  	} else {
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
> +			if (filemap_range_has_page(mapping, pos, end)) {
> +				ret = -EAGAIN;
> +				goto out_free_dio;
> +			}
> +			flags |= IOMAP_NOWAIT;
> +		}
> +
>  		flags |= IOMAP_WRITE;
>  		dio->flags |= IOMAP_DIO_WRITE;
>  
> @@ -478,14 +493,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			dio->flags |= IOMAP_DIO_WRITE_FUA;
>  	}
>  
> -	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (filemap_range_has_page(mapping, pos, end)) {
> -			ret = -EAGAIN;
> -			goto out_free_dio;
> -		}
> -		flags |= IOMAP_NOWAIT;
> -	}

looking at this I really hate the scheme with the potential racyness
and duplicated page looksups.

Why can't we pass a nonblock flag to filemap_write_and_wait_range
and invalidate_inode_pages2_range that makes them return -EAGAIN
when they would block to clean this whole mess up?
