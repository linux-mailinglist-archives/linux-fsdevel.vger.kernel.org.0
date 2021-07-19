Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8085A3CDA40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 17:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbhGSOfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 10:35:15 -0400
Received: from verein.lst.de ([213.95.11.211]:50020 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243437AbhGSOcj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:32:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1206568BFE; Mon, 19 Jul 2021 17:13:12 +0200 (CEST)
Date:   Mon, 19 Jul 2021 17:13:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
Message-ID: <20210719151310.GA22355@lst.de>
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com> <YPWUBhxhoaEp8Frn@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPWUBhxhoaEp8Frn@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 04:02:30PM +0100, Matthew Wilcox wrote:
> > +	if (iomap->type == IOMAP_INLINE) {
> > +		iomap_read_inline_data(inode, page, iomap, pos);
> > +		plen = PAGE_SIZE - poff;
> > +		goto done;
> > +	}
> 
> This is going to break Andreas' case that he just patched to work.
> GFS2 needs for there to _not_ be an iop for inline data.  That's
> why I said we need to sort out when to create an iop before moving
> the IOMAP_INLINE case below the creation of the iop.
> 
> If we're not going to do that first, then I recommend leaving the
> IOMAP_INLINE case where it is and changing it to ...
> 
> 	if (iomap->type == IOMAP_INLINE)
> 		return iomap_read_inline_data(inode, page, iomap, pos);
> 
> ... and have iomap_read_inline_data() return the number of bytes that
> it copied + zeroed (ie PAGE_SIZE - poff).

Returning the bytes is much cleaner anyway.  But we still need to deal
with the sub-page uptodate status in one form or another.
