Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3321B3D3D03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 17:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhGWPQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhGWPQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:16:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004CFC061757;
        Fri, 23 Jul 2021 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ovsyxI38eNvliEW3ps0I8aR1LXX7PaOVRwl/PkPRFDM=; b=Wxnyx+dw5dcaJEYk7A89PoveYG
        dA8Nw8DvgO2pjZqcy/y8tpZrV64svCyzBmRc/Gy4epobh41YlOfrukZvPFMZKaDuDgRSixj+x74+8
        00UAFBs1Z0nkdxFm5I1rUKVQOJnBb1GiIOIfe3rk7YOPWjLbhOLitR++IQOvGval1ceVQ8xMAOmD1
        vxEh5cCcxzU+c54cdxTVTtzz4Fz7zl1OwsM6MalIKvBJLh5nwtMzF3gueE10t+emldzVdMmHfpw6B
        QLyWdJV9mA0XiEtVWlpW3Y/3s1Z2rbjwDR1ZybmhJIHGnQ5ECIM/neeB7i0/iUlddaXiE1S+SHxbE
        rtiZ4Uyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6xXP-00BVcv-W7; Fri, 23 Jul 2021 15:56:43 +0000
Date:   Fri, 23 Jul 2021 16:56:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <YPrms0fWPwEZGNAL@casper.infradead.org>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de>
 <YPrauRjG7+vCw7f9@casper.infradead.org>
 <YPre+j906ywgRHEZ@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPre+j906ywgRHEZ@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:23:38PM +0800, Gao Xiang wrote:
> Hi Matthew,
> 
> On Fri, Jul 23, 2021 at 04:05:29PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 22, 2021 at 07:39:47AM +0200, Christoph Hellwig wrote:
> > > @@ -675,7 +676,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> > >  
> > >  	flush_dcache_page(page);
> > >  	addr = kmap_atomic(page);
> > > -	memcpy(iomap->inline_data + pos, addr + pos, copied);
> > > +	memcpy(iomap_inline_buf(iomap, pos), addr + pos, copied);
> > 
> > This is wrong; pos can be > PAGE_SIZE, so this needs to be
> > addr + offset_in_page(pos).
> 
> Yeah, thanks for pointing out. It seems so, since EROFS cannot test
> such write path, previously it was disabled explicitly. I could
> update it in the next version as above.

We're also missing a call to __set_page_dirty_nobuffers().  This
matters to nobody right now -- erofs is read-only and gfs2 only
supports inline data in the inode.  I presume what is happening
for gfs2 is that at inode writeback time, it copies the ~60 bytes
from the page cache into the inode and then schedules the inode
for writeback.

But logically, we should mark the page as dirty.  It'll be marked
as dirty by ->mkwrite, should the page be mmaped, so gfs2 must
already cope with a dirty page for inline data.
