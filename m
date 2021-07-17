Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724643CC403
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jul 2021 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhGQPTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 11:19:09 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:20887 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhGQPTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:19:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Ug3MJx6_1626534958;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ug3MJx6_1626534958)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 17 Jul 2021 23:16:00 +0800
Date:   Sat, 17 Jul 2021 23:15:58 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPL0LqHzEbUY4zY/@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
 <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
 <YPLw0uc1jVKI8uKo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPLw0uc1jVKI8uKo@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Sat, Jul 17, 2021 at 04:01:38PM +0100, Matthew Wilcox wrote:
> On Sat, Jul 17, 2021 at 09:38:18PM +0800, Gao Xiang wrote:
> > Sorry about some late. I've revised a version based on Christoph's
> > version and Matthew's thought above. I've preliminary checked with
> > EROFS, if it does make sense, please kindly help check on the gfs2
> > side as well..
> 
> I don't understand how this bit works:

This part inherited from the Christoph version without change.
The following thoughts are just my own understanding...

> 
> >  	struct page *page = ctx->cur_page;
> > -	struct iomap_page *iop;
> > +	struct iomap_page *iop = NULL;
> >  	bool same_page = false, is_contig = false;
> >  	loff_t orig_pos = pos;
> >  	unsigned poff, plen;
> >  	sector_t sector;
> >  
> > -	if (iomap->type == IOMAP_INLINE) {
> > -		WARN_ON_ONCE(pos);
> > -		iomap_read_inline_data(inode, page, iomap);
> > -		return PAGE_SIZE;
> > -	}
> > +	if (iomap->type == IOMAP_INLINE && !pos)
> > +		WARN_ON_ONCE(to_iomap_page(page) != NULL);
> > +	else
> > +		iop = iomap_page_create(inode, page);
> 
> Imagine you have a file with bytes 0-2047 in an extent which is !INLINE
> and bytes 2048-2051 in the INLINE extent.  When you read the page, first
> you create an iop for the !INLINE extent.  Then this function is called

Yes, it first created an iop for the !INLINE extent.

> again for the INLINE extent and you'll hit the WARN_ON_ONCE.  No?

If it is called again with another INLINE extent, pos will be non-0?
so (!pos) == false. Am I missing something?

Thanks,
Gao Xiang

> 
