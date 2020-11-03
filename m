Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686562A3DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKCHea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:34:30 -0500
Received: from verein.lst.de ([213.95.11.211]:36014 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCHea (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:34:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE92367373; Tue,  3 Nov 2020 08:34:27 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:34:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 07/17] mm/filemap: Change filemap_read_page calling
 conventions
Message-ID: <20201103073427.GG8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-8-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static int filemap_read_page(struct file *file, struct address_space *mapping,
> +		struct page *page)

I still think we should drop the mapping argument as well.

> +	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
> +		unlock_page(page);
> +		put_page(page);
> +		return ERR_PTR(-EAGAIN);
> +	}
> +	error = filemap_read_page(iocb->ki_filp, mapping, page);
> +	if (!error)
> +		return page;

I think a goto error for the error cases would be much more useful.
That would allow to also share the error put_page for the flag check
above and the truncated case below, but most importantly make the code
flow obvious vs the early return for the success case.

> -	return filemap_read_page(iocb, filp, mapping, page);
> +	if (!error)
> +		error = filemap_read_page(iocb->ki_filp, mapping, page);
> +	if (!error)
> +		return page;
> +	put_page(page);
> +	if (error == -EEXIST || error == AOP_TRUNCATED_PAGE)
> +		return NULL;
> +	return ERR_PTR(error);

Same here.
