Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5AE3CE713
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbhGSQUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352737AbhGSQOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:14:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70A3C05BD3D;
        Mon, 19 Jul 2021 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t0i+7tXFhVAJI+nlAjaCd7T6XGAQwmoipG3wOX3BNN4=; b=aukGzst6WKaOLTfMq0IMTJVP/W
        oW4ss9z0jiy2pgZaSBv/ZXarhM3VSBxdESUqy1kE7h1qXvBgiIdjbm1D5q+RQYj4PbqsL/t0+kqlh
        dy6KPznHqP5JpRsC8Xa6dnhQQapIQxbmuO7likzE6uh9ZP2tXjdzgXqWkCJ4c1q/Fai8CAtY7t6Ac
        t+jsX6iBmhYsMWUt6mBRrwDTTms5h2MroCNEe7CqBtzOy3GiC/Ba8I8TUexNnYJy7PGganCeqDRpn
        nmt7X3oDM8G4sFx6X+DCZ1DvbmiOAMgQs2eLqI2bNgkE2ElmUrjlqjBK82Y04+jrqh5xZE024sN6A
        tfAYcc4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5WAg-0075UR-UE; Mon, 19 Jul 2021 16:31:29 +0000
Date:   Mon, 19 Jul 2021 17:31:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
Message-ID: <YPWozhzNIljcC83R@casper.infradead.org>
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
 <YPWUBhxhoaEp8Frn@casper.infradead.org>
 <20210719151310.GA22355@lst.de>
 <YPWkRRzy5reIMu8u@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPWkRRzy5reIMu8u@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 12:11:49AM +0800, Gao Xiang wrote:
> On Mon, Jul 19, 2021 at 05:13:10PM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 19, 2021 at 04:02:30PM +0100, Matthew Wilcox wrote:
> > > > +	if (iomap->type == IOMAP_INLINE) {
> > > > +		iomap_read_inline_data(inode, page, iomap, pos);
> > > > +		plen = PAGE_SIZE - poff;
> > > > +		goto done;
> > > > +	}
> > > 
> > > This is going to break Andreas' case that he just patched to work.
> > > GFS2 needs for there to _not_ be an iop for inline data.  That's
> > > why I said we need to sort out when to create an iop before moving
> > > the IOMAP_INLINE case below the creation of the iop.
> > > 
> > > If we're not going to do that first, then I recommend leaving the
> > > IOMAP_INLINE case where it is and changing it to ...
> > > 
> > > 	if (iomap->type == IOMAP_INLINE)
> > > 		return iomap_read_inline_data(inode, page, iomap, pos);
> > > 
> > > ... and have iomap_read_inline_data() return the number of bytes that
> > > it copied + zeroed (ie PAGE_SIZE - poff).
> > 
> > Returning the bytes is much cleaner anyway.  But we still need to deal
> > with the sub-page uptodate status in one form or another.
> 
> There is another iomap_read_inline_data() caller as in:
> +static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
> +		struct page *page, struct iomap *srcmap)
> +{
> +	/* needs more work for the tailpacking case, disable for now */
> +	if (WARN_ON_ONCE(pos != 0))
> +		return -EIO;
> +	if (PageUptodate(page))
> +		return 0;
> +	iomap_read_inline_data(inode, page, srcmap, pos);
> +	return 0;
> +}
> 
> I'd like to avoid it as (void)iomap_read_inline_data(...). That's why it
> left as void return type.

You don't need to cast away the return value in C.

