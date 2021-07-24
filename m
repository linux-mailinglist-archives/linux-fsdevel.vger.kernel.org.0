Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734BF3D4842
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhGXOeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 10:34:05 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50944 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhGXOdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 10:33:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ugohg-R_1627139662;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ugohg-R_1627139662)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 24 Jul 2021 23:14:23 +0800
Date:   Sat, 24 Jul 2021 23:14:22 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: Support inline data with block size < page
 size
Message-ID: <YPwuTsBAsUSSOIvo@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
References: <20210724034435.2854295-1-willy@infradead.org>
 <20210724034435.2854295-3-willy@infradead.org>
 <YPubNbDS0KgUALtt@B-P7TQMD6M-0146.local>
 <YPwdzD+nf9rStDI3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPwdzD+nf9rStDI3@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 03:03:56PM +0100, Matthew Wilcox wrote:
> On Sat, Jul 24, 2021 at 12:46:45PM +0800, Gao Xiang wrote:
> > Hi Matthew,
> > 
> > On Sat, Jul 24, 2021 at 04:44:35AM +0100, Matthew Wilcox (Oracle) wrote:
> > > Remove the restriction that inline data must start on a page boundary
> > > in a file.  This allows, for example, the first 2KiB to be stored out
> > > of line and the trailing 30 bytes to be stored inline.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  fs/iomap/buffered-io.c | 18 ++++++++----------
> > >  1 file changed, 8 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 7bd8e5de996d..d7d6af29af7f 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -209,25 +209,23 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
> > >  		struct iomap *iomap, loff_t pos)
> > >  {
> > >  	size_t size = iomap->length + iomap->offset - pos;
> > > +	size_t poff = offset_in_page(pos);
> > >  	void *addr;
> > >  
> > >  	if (PageUptodate(page))
> > > -		return PAGE_SIZE;
> > > +		return PAGE_SIZE - poff;
> > >  
> > > -	/* inline data must start page aligned in the file */
> > > -	if (WARN_ON_ONCE(offset_in_page(pos)))
> > > -		return -EIO;
> > >  	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
> > >  		return -EIO;
> > > -	if (WARN_ON_ONCE(page_has_private(page)))
> > > -		return -EIO;
> > > +	if (poff > 0)
> > > +		iomap_page_create(inode, page);
> > 
> > Thanks for the patch!
> > 
> > Previously I'd like to skip the leading uptodate blocks and update the
> > extent it covers that is due to already exist iop. If we get rid of the
> > offset_in_page(pos) restriction like this, I'm not sure if we (or some
> > other fs users) could face something like below (due to somewhat buggy
> > fs users likewise):
> > 
> >  [0 - 4096)    plain block
> > 
> >  [4096 - 4608)  tail INLINE 1 (e.g. by mistake or just splitted
> >                                     .iomap_begin() report.)
> >  [4608 - 5120]  tail INLINE 2
> 
> My assumption is that an INLINE extent is <= block_size.  Otherwise
> the first part of the extent would be not-inline.  So this would be
> a bug in the filesystem; [4096-4608) should not be an inline extent.

Yes, never mind. Sorry about again.

> 
> > with this code iomap_set_range_uptodate() wouldn't behave correctly.
> > 
> > In addition, currently EROFS cannot test such path (since EROFS is
> > page-sized block only for now) as Darrick said in the previous reply,
> > so I think it would be better together with the folio patchset and
> > targeted for the corresponding merge window, so I can test iomap
> > supported EROFS with the new folio support together (That also give
> > me some time to support sub-pagesized uncompressed blocks...)
> 
> Do you want to test erofs with multi-page folios?  That might be
> even more interesting than block size < page size.

Hmm.. I'm busy in developing for some new scenario. Will look into
that after the current busy period.

> 
> > > -	addr = kmap_atomic(page);
> > > +	addr = kmap_atomic(page) + poff;
> > >  	memcpy(addr, iomap_inline_buf(iomap, pos), size);
> > > -	memset(addr + size, 0, PAGE_SIZE - size);
> > > +	memset(addr + size, 0, PAGE_SIZE - poff - size);
> > >  	kunmap_atomic(addr);
> > 
> > As my limited understanding, this may need to be fixed, since it
> > doesn't match kmap_atomic(page)...
> 
> void kunmap_local_indexed(void *vaddr)
> {
>         unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
> 
> so it's fine to unmap any address in the page.

I already checked this (in practice it has no problem due to the
current implementation), yet I'm not quite sure if it matches the
API usage, and not quite sure how many in-kernel users use like this.

Thanks,
Gao Xiang
