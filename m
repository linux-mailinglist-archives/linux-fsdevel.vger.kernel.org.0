Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77302A9105
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgKFILW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:11:22 -0500
Received: from verein.lst.de ([213.95.11.211]:50553 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgKFILW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:11:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B7B268B05; Fri,  6 Nov 2020 09:11:19 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:11:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 09/18] mm/filemap: Change filemap_read_page calling
 conventions
Message-ID: <20201106081119.GE31585@lst.de>
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104204219.23810-10-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 08:42:10PM +0000, Matthew Wilcox (Oracle) wrote:
> @@ -2288,7 +2270,18 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
>  	return page;
>  
>  readpage:
> +	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
> +		unlock_page(page);
> +		put_page(page);
> +		return ERR_PTR(-EAGAIN);
> +	}
> +	error = filemap_read_page(iocb->ki_filp, mapping, page);
> +	if (!error)

I still find the eraly return here weird..

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
