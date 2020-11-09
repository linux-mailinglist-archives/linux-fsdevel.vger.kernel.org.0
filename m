Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254DE2ABBB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 14:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbgKIN3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 08:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbgKIN3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:29:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEE4C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 05:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NS2a1pD9Wqpg1Yiz1D4KYgVHI/WjaHvVakpdehgr1oE=; b=eUYnzm+rzLOYf+Fj8s9E1XdsHU
        2pArMGi8q6wCvN81EU0SK1kL/B5qnbL9yXX5xqrCX2P9lUuyslAQLnWrpMJc0139iXTMdaWQbebte
        T/GErrfnX9guPpaMBKWHfYVt5pnxGDqhHhqnkTUdWqNWN4E5hKZbliOV8v4i0Kt7fo9NSj7BisFLq
        tBO0FqDioJ0MAVuVP7EZqsj2WqiIt18EnLnhn/xwSMyglynUIgRrwGOo/MmuNC5RG+5zSCCkMsYNB
        Qj5O6ZHdcw/mdOsEe6vkNbJo0Ilwu6ADUQme98d/RLBYiad5EQRzC3u3nhWWtyavyX5cjbzb9Ob+c
        Tun+kldA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc7Es-0005ty-15; Mon, 09 Nov 2020 13:29:42 +0000
Date:   Mon, 9 Nov 2020 13:29:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 11/18] mm/filemap: Convert filemap_update_page to
 return an errno
Message-ID: <20201109132941.GA17076@casper.infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
 <20201104204219.23810-12-willy@infradead.org>
 <20201106081420.GF31585@lst.de>
 <20201106083746.GA720@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106083746.GA720@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:37:46AM +0100, Christoph Hellwig wrote:
>  
> -	error = AOP_TRUNCATED_PAGE;
> -	if (!page->mapping)
> -		goto unlock;
> -	if (filemap_range_uptodate(iocb, mapping, iter, page)) {
> +	if (!page->mapping) {
>  		unlock_page(page);
> -		return 0;
> +		put_page(page);
> +		return AOP_TRUNCATED_PAGE;
>  	}
>  
> -	error = -EAGAIN;
> -	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
> -		goto unlock;
> +	if (!filemap_range_uptodate(iocb, mapping, iter, page)) {
> +		error = -EAGAIN;
> +		if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
> +			goto unlock;
> +		return filemap_read_page(iocb->ki_filp, mapping, page);
> +	}
>  
> -	error = filemap_read_page(iocb->ki_filp, mapping, page);
> -	if (error)
> -		goto error;
> -	return 0;
>  unlock:
>  	unlock_page(page);
> -error:
> -	put_page(page);
>  	return error;
>  }

It works out to be a little more complicated than that because
filemap_read_page() can also return AOP_TRUNCATED_PAGE.  Here's what I
currently have:

        if (!page->mapping)
                goto truncated;

        error = 0;
        if (filemap_range_uptodate(iocb, mapping, iter, page))
                goto unlock;

        error = -EAGAIN;
        if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
                goto unlock;

        error = filemap_read_page(iocb->ki_filp, mapping, page);
        if (error == AOP_TRUNCATED_PAGE)
                put_page(page);
        return error;
truncated:
        error = AOP_TRUNCATED_PAGE;
        put_page(page);
unlock:
        unlock_page(page);
        return error;
}


