Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495A43CDA6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbhGSOfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbhGSOfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:35:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93497C0613E3;
        Mon, 19 Jul 2021 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ELJ0z2aDXla8iuVKhbEh0uG66iZXIkBu/r64UbziHV8=; b=BYSV7NdoWNUqr1E4SGKE2LA2nX
        CMURjH+NbrSvI1kKwda4DItB17PJEdXwbrPXPvprFW8SzUZGMzOlHzBUqwK3R0soimpYF/pW6cphG
        3oKs7+0EEnmN16KZ4oa6KJdUmnP2H7XHwC2WUShMu7fQjID2ijfkME8tnBkSY57Z7zKAKD3G8ATUC
        L8xNsVlPCmHPmd8CrIjvbcQpOSWppIN0B6xgCupALXjo/IqXTj1ohVQKamJSB0AqztiO/aULV+UN5
        dZxf8CWXMZcPwWHYiI1Jf+e6bp/fJOFpXUaWLs9zIr0CIcZqCUo+LGXk3yOoMJqWQmWIA+tHf+0jE
        pamPMvPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Ums-006xWQ-IK; Mon, 19 Jul 2021 15:03:10 +0000
Date:   Mon, 19 Jul 2021 16:02:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
Message-ID: <YPWUBhxhoaEp8Frn@casper.infradead.org>
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 10:47:47PM +0800, Gao Xiang wrote:
> @@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	unsigned poff, plen;
>  	sector_t sector;
>  
> -	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, page, iomap);
> -		return PAGE_SIZE;
> -	}
> -
> -	/* zero post-eof blocks as the page may be mapped */
>  	iop = iomap_page_create(inode, page);
> +	/* needs to skip some leading uptodated blocks */
>  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>  	if (plen == 0)
>  		goto done;
>  
> +	if (iomap->type == IOMAP_INLINE) {
> +		iomap_read_inline_data(inode, page, iomap, pos);
> +		plen = PAGE_SIZE - poff;
> +		goto done;
> +	}

This is going to break Andreas' case that he just patched to work.
GFS2 needs for there to _not_ be an iop for inline data.  That's
why I said we need to sort out when to create an iop before moving
the IOMAP_INLINE case below the creation of the iop.

If we're not going to do that first, then I recommend leaving the
IOMAP_INLINE case where it is and changing it to ...

	if (iomap->type == IOMAP_INLINE)
		return iomap_read_inline_data(inode, page, iomap, pos);

... and have iomap_read_inline_data() return the number of bytes that
it copied + zeroed (ie PAGE_SIZE - poff).

