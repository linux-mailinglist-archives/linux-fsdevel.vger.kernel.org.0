Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F6B4348D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 12:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhJTKW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 06:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhJTKW5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:22:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97FB761004;
        Wed, 20 Oct 2021 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634725243;
        bh=ToTI2rY165RFMu+JGNDdrfJTc77awcVma/hprClzxwk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YiTTLo7FHRIGC5SI0BimIMnOFy4lDO7rGRhJ2LBYskUpXnJe109XRTSqZ6v1rNAky
         JKAP9ULv+Ppbt5IY2D2//ThMXfE8tDazy1fh96Jsw1KIYGK1PfP75EZc1Dy1Du9tqF
         rKTj/b4zkU2yqVF1Pbxtg0h4FbQazgMiPXx2/PT/dpRKIsxuHA4Glp4bf02RchCGdj
         xAcVmiEiI4ekAG+HhuYhnL6bfVLkpw35ckNrLunUqnS6W/DdbTzAH0+CFnlWT8jONq
         /ROw9Ltr5LlVBmkdTTApM15N+PR6MnrJO9ffsvmqPIO9zF/TDBUYHLiIInSI+jXHTU
         jkWD/vl1ZlG+w==
Message-ID: <6226035fc82495f7ba298659d9e658e0df7bcb47.camel@kernel.org>
Subject: Re: [PATCH v2] mm: Stop filemap_read() from grabbing a superfluous
 page
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, kent.overstreet@gmail.com,
        willy@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Oct 2021 06:20:41 -0400
In-Reply-To: <163472463105.3126792.7056099385135786492.stgit@warthog.procyon.org.uk>
References: <163472463105.3126792.7056099385135786492.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-10-20 at 11:10 +0100, David Howells wrote:
> Under some circumstances, filemap_read() will allocate sufficient pages to
> read to the end of the file, call readahead/readpages on them and copy the
> data over - and then it will allocate another page at the EOF and call
> readpage on that and then ignore it.  This is unnecessary and a waste of
> time and resources.
> 
> filemap_read() *does* check for this, but only after it has already done
> the allocation and I/O.  Fix this by checking before calling
> filemap_get_pages() also.
> 
> Changes:
>  v2) Break out of the loop immediately rather than going to put_pages (the
>      pvec is unoccupied).  Setting isize is then unnecessary.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Kent Overstreet <kent.overstreet@gmail.com>
> cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Jeff Layton <jlayton@redhat.com>
> cc: linux-mm@kvack.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/160588481358.3465195.16552616179674485179.stgit@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/163456863216.2614702.6384850026368833133.stgit@warthog.procyon.org.uk/
> ---
> 
>  mm/filemap.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index dae481293b5d..e50be519f6a4 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2625,6 +2625,9 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
>  			iocb->ki_flags |= IOCB_NOWAIT;
>  
> +		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
> +			break;
> +
>  		error = filemap_get_pages(iocb, iter, &pvec);
>  		if (error < 0)
>  			break;
> 
> 

Even better.

Acked-by: Jeff Layton <jlayton@kernel.org>

