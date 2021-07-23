Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0713D3D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 18:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGWPng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 11:43:36 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53151 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhGWPnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:43:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgjV2MC_1627057445;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgjV2MC_1627057445)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 24 Jul 2021 00:24:06 +0800
Date:   Sat, 24 Jul 2021 00:24:04 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <YPrtJLLsjvvQm1sD@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de>
 <YPrauRjG7+vCw7f9@casper.infradead.org>
 <YPre+j906ywgRHEZ@B-P7TQMD6M-0146.local>
 <YPrms0fWPwEZGNAL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPrms0fWPwEZGNAL@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 23, 2021 at 04:56:35PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 23, 2021 at 11:23:38PM +0800, Gao Xiang wrote:
> > Hi Matthew,
> > 
> > On Fri, Jul 23, 2021 at 04:05:29PM +0100, Matthew Wilcox wrote:
> > > On Thu, Jul 22, 2021 at 07:39:47AM +0200, Christoph Hellwig wrote:
> > > > @@ -675,7 +676,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> > > >  
> > > >  	flush_dcache_page(page);
> > > >  	addr = kmap_atomic(page);
> > > > -	memcpy(iomap->inline_data + pos, addr + pos, copied);
> > > > +	memcpy(iomap_inline_buf(iomap, pos), addr + pos, copied);
> > > 
> > > This is wrong; pos can be > PAGE_SIZE, so this needs to be
> > > addr + offset_in_page(pos).
> > 
> > Yeah, thanks for pointing out. It seems so, since EROFS cannot test
> > such write path, previously it was disabled explicitly. I could
> > update it in the next version as above.
> 
> We're also missing a call to __set_page_dirty_nobuffers().  This
> matters to nobody right now -- erofs is read-only and gfs2 only
> supports inline data in the inode.  I presume what is happening
> for gfs2 is that at inode writeback time, it copies the ~60 bytes
> from the page cache into the inode and then schedules the inode
> for writeback.
> 
> But logically, we should mark the page as dirty.  It'll be marked
> as dirty by ->mkwrite, should the page be mmaped, so gfs2 must
> already cope with a dirty page for inline data.

I'd suggest we still disable tail-packing inline for buffered write
path until some real user for testing. I can see some (maybe) page
writeback, inode writeback and inline converting cases which is
somewhat complicated than just update like this.

I suggest it could be implemented with some real users, at least it can
provide the real write pattern and paths for testing. I will send the
next version like my previous version to disable it until some real fs
user cares and works out a real pattern.

Thanks,
Gao Xiang

