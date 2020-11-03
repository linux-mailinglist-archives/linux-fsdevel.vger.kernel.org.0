Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52872A3E3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 09:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgKCIAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 03:00:51 -0500
Received: from verein.lst.de ([213.95.11.211]:36121 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgKCIAu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:00:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A72868B05; Tue,  3 Nov 2020 09:00:46 +0100 (CET)
Date:   Tue, 3 Nov 2020 09:00:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 15/17] mm/filemap: Don't relock the page after calling
 readpage
Message-ID: <20201103080045.GN8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-16-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:10PM +0000, Matthew Wilcox (Oracle) wrote:
> We don't need to get the page lock again; we just need to wait for
> the I/O to finish, so use wait_on_page_locked_killable() like the
> other callers of ->readpage.

As that isn't entirely obvious, what about adding a comment next to
the wait_on_page_locked_killable call to document it?

>  
> +	error = wait_on_page_locked_killable(page);
>  	if (error)
>  		return error;
> +	if (PageUptodate(page))
> +		return 0;
> +	if (!page->mapping)	/* page truncated */
> +		return AOP_TRUNCATED_PAGE;
> +	shrink_readahead_size_eio(&file->f_ra);
> +	return -EIO;

You might notice a theme here, but I hate having the fast path exit
early without a good reason, so I'd be much happier with:

	if (!PageUptodate(page)) {
		if (!page->mapping)	/* page truncated */
			return AOP_TRUNCATED_PAGE;
		shrink_readahead_size_eio(&file->f_ra);
		return -EIO;
	}
	return 0;
