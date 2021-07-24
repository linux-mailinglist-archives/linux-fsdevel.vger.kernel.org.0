Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F113D4805
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhGXNXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 09:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhGXNXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 09:23:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7B7C061575;
        Sat, 24 Jul 2021 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+0vnqmJKm+6zv+bJtJfE9x8n4Meokw7C35dQw9EyAok=; b=WIpb+PRSlE3BXqWYcFEoGrmpTG
        Hpi0pvtLmGmLaLioslauth8jcLyT/S1dKvt3vVG01R3bB+qmpdP4HYZWXr//7fqfKfH8kaMgEKRmY
        lIpJ9IXyzIvw4E2Ad09rKYFIKe38v9OpRpsijg6PXISO2/gu4UWii/yRstx/urDEHWjgu9zwbeNpn
        szvxCyuSEp0JTGg9SLfC7jDbj5KyMw0EWyRGSdCdthljOKj4dvQDDPFLYoB1SxXXMZaQHEfcneR1e
        fNA5Lh2xMIZ4CCNqV++fvxJMTcdaYRgml7WsCtzzI80CY/HdoHYa8hKLDyHpJL3Qn053A0UgPOZWn
        Q/JASxbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7IFw-00CJFp-NN; Sat, 24 Jul 2021 14:04:03 +0000
Date:   Sat, 24 Jul 2021 15:03:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: Support inline data with block size < page
 size
Message-ID: <YPwdzD+nf9rStDI3@casper.infradead.org>
References: <20210724034435.2854295-1-willy@infradead.org>
 <20210724034435.2854295-3-willy@infradead.org>
 <YPubNbDS0KgUALtt@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPubNbDS0KgUALtt@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 12:46:45PM +0800, Gao Xiang wrote:
> Hi Matthew,
> 
> On Sat, Jul 24, 2021 at 04:44:35AM +0100, Matthew Wilcox (Oracle) wrote:
> > Remove the restriction that inline data must start on a page boundary
> > in a file.  This allows, for example, the first 2KiB to be stored out
> > of line and the trailing 30 bytes to be stored inline.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/iomap/buffered-io.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 7bd8e5de996d..d7d6af29af7f 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -209,25 +209,23 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
> >  		struct iomap *iomap, loff_t pos)
> >  {
> >  	size_t size = iomap->length + iomap->offset - pos;
> > +	size_t poff = offset_in_page(pos);
> >  	void *addr;
> >  
> >  	if (PageUptodate(page))
> > -		return PAGE_SIZE;
> > +		return PAGE_SIZE - poff;
> >  
> > -	/* inline data must start page aligned in the file */
> > -	if (WARN_ON_ONCE(offset_in_page(pos)))
> > -		return -EIO;
> >  	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
> >  		return -EIO;
> > -	if (WARN_ON_ONCE(page_has_private(page)))
> > -		return -EIO;
> > +	if (poff > 0)
> > +		iomap_page_create(inode, page);
> 
> Thanks for the patch!
> 
> Previously I'd like to skip the leading uptodate blocks and update the
> extent it covers that is due to already exist iop. If we get rid of the
> offset_in_page(pos) restriction like this, I'm not sure if we (or some
> other fs users) could face something like below (due to somewhat buggy
> fs users likewise):
> 
>  [0 - 4096)    plain block
> 
>  [4096 - 4608)  tail INLINE 1 (e.g. by mistake or just splitted
>                                     .iomap_begin() report.)
>  [4608 - 5120]  tail INLINE 2

My assumption is that an INLINE extent is <= block_size.  Otherwise
the first part of the extent would be not-inline.  So this would be
a bug in the filesystem; [4096-4608) should not be an inline extent.

> with this code iomap_set_range_uptodate() wouldn't behave correctly.
> 
> In addition, currently EROFS cannot test such path (since EROFS is
> page-sized block only for now) as Darrick said in the previous reply,
> so I think it would be better together with the folio patchset and
> targeted for the corresponding merge window, so I can test iomap
> supported EROFS with the new folio support together (That also give
> me some time to support sub-pagesized uncompressed blocks...)

Do you want to test erofs with multi-page folios?  That might be
even more interesting than block size < page size.

> > -	addr = kmap_atomic(page);
> > +	addr = kmap_atomic(page) + poff;
> >  	memcpy(addr, iomap_inline_buf(iomap, pos), size);
> > -	memset(addr + size, 0, PAGE_SIZE - size);
> > +	memset(addr + size, 0, PAGE_SIZE - poff - size);
> >  	kunmap_atomic(addr);
> 
> As my limited understanding, this may need to be fixed, since it
> doesn't match kmap_atomic(page)...

void kunmap_local_indexed(void *vaddr)
{
        unsigned long addr = (unsigned long) vaddr & PAGE_MASK;

so it's fine to unmap any address in the page.
