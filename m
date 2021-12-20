Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7747B5CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 23:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhLTWKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 17:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhLTWKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:10:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3756DC061574;
        Mon, 20 Dec 2021 14:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tv+e0YzWj7EnlpLaFuicF+ep+GIPnCrnk5iHywil75Y=; b=fG+mYiUzwhdMYKpKlw6RitBL9U
        Dd60zq/eWe7QyCAe2DH7ZQktAP/xFZJbovS9+DrnhbZsZybIIbjqwSzhmmNCP8pvtmwrUIoYMRHi5
        pNxvEUrI9eaSEpe/m/D7ql9CfprRvYZbFG4iEw6iQuLu28X9di1F5FhdgUe3hORXOa8vHindWgtNa
        9ayzoh9mpCrGYAVpvH958cAxr4JeiPYG9M059O4Z5/bQlh2aOnf9+MYUzDXr9Cj0eG3CK3d8O30F2
        aao/zuLCI/u7nNVEKx96IaWANTrW0dzEFbbIDQ7dSxctMMf6G6QWBVJEFkxV2ysH4B2An9aIDS7gp
        UtX642UQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzQra-001xdx-FZ; Mon, 20 Dec 2021 22:10:34 +0000
Date:   Mon, 20 Dec 2021 22:10:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iomap: turn the byte variable in iomap_zero_iter into a
 ssize_t
Message-ID: <YcD/WjYXg9LKydhY@casper.infradead.org>
References: <20211208091203.2927754-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208091203.2927754-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan, why is this erroneous commit still in your tree?
iomap_write_end() cannot return an errno; if an error occurs, it
returns zero.  The code in iomap_zero_iter() should be:

                bytes = iomap_write_end(iter, pos, bytes, bytes, page);
                if (WARN_ON_ONCE(bytes == 0))
                        return -EIO;

On Wed, Dec 08, 2021 at 10:12:03AM +0100, Christoph Hellwig wrote:
> bytes also hold the return value from iomap_write_end, which can contain
> a negative error value.  As bytes is always less than the page size even
> the signed type can hold the entire possible range.
> 
> Fixes: c6f40468657d ("fsdax: decouple zeroing from the iomap buffered I/O code")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index b1511255b4df8..ac040d607f4fe 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -883,7 +883,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  
>  	do {
>  		unsigned offset = offset_in_page(pos);
> -		size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
> +		ssize_t bytes = min_t(u64, PAGE_SIZE - offset, length);
>  		struct page *page;
>  		int status;
>  
> -- 
> 2.30.2
> 
