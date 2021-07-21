Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ABB3D060E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 02:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhGTXYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 19:24:51 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59920 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235067AbhGTXXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 19:23:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgSnpfC_1626825824;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgSnpfC_1626825824)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Jul 2021 08:03:45 +0800
Date:   Wed, 21 Jul 2021 08:03:44 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
Message-ID: <YPdkYFSjFHDOU4AV@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia>
 <YPc9viRAKm6cf2Ey@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPc9viRAKm6cf2Ey@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:18:54PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 20, 2021 at 01:42:24PM -0700, Darrick J. Wong wrote:
> > > -	BUG_ON(page_has_private(page));
> > > -	BUG_ON(page->index);
> > > -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > > +	/* inline source data must be inside a single page */
> > > +	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > 
> > Can we reduce the strength of these checks to a warning and an -EIO
> > return?
> 
> I'm not entirely sure that we need this check, tbh.

I'm fine to get rid of this check, it just inherited from:
 - BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));

It has no real effect, but when reading INLINE extent, its .iomap_begin()
does:
	iomap->private = erofs_get_meta_page()	/* get meta page */

and in the .iomap_end(), it does:
	struct page *ipage = iomap->private;
	if (ipage) {
		unlock_page(ipage);
		put_page(ipage);
	}

> 
> > > +	/* handle tail-packing blocks cross the current page into the next */
> > > +	size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> > > +		     PAGE_SIZE - poff);
> > >  
> > >  	addr = kmap_atomic(page);
> > > -	memcpy(addr, iomap->inline_data, size);
> > > -	memset(addr + size, 0, PAGE_SIZE - size);
> > > +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > > +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> > 
> > Hmm, so I guess the point of this is to support reading data from a
> > tail-packing block, where each file gets some arbitrary byte range
> > within the tp-block, and the range isn't aligned to an fs block?  Hence
> > you have to use the inline data code to read the relevant bytes and copy
> > them into the pagecache?
> 
> I think there are two distinct cases for IOMAP_INLINE.  One is
> where the tail of the file is literally embedded into the inode.
> Like ext4 fast symbolic links.  Taking the ext4 i_blocks layout
> as an example, you could have a 4kB block stored in i_block[0]
> and then store bytes 4096-4151 in i_block[1-14] (although reading
> https://www.kernel.org/doc/html/latest/filesystems/ext4/dynamic.html
> makes me think that ext4 only supports storing 0-59 in the i_blocks;
> it doesn't support 0-4095 in i_block[0] and then 4096-4151 in i_blocks)
> 
> The other is what I think erofs is doing where, for example, you'd
> specify in i_block[1] the block which contains the tail and then in
> i_block[2] what offset of the block the tail starts at.

Nope, EROFS inline data is embedded into the inode in order to save
I/O as well as space (maybe I didn't express clear before [1]). 

I understand the other one, but it can only save storage space but
cannot save I/O (we still need another independent I/O to read its
meta buffered page).

In the view of INLINE extent itself, I think both ways can be
supported with this approach.

[1] https://www.kernel.org/doc/html/latest/filesystems/erofs.html
    "On-disk details" section.

Thanks,
Gao Xiang
