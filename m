Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB73D4419
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 02:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhGXANm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 20:13:42 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37922 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233337AbhGXANl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 20:13:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UgkuJRR_1627088050;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgkuJRR_1627088050)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 24 Jul 2021 08:54:12 +0800
Date:   Sat, 24 Jul 2021 08:54:10 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
        Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YPtksjmvVbcsKwlK@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
        Huang Jianan <huangjianan@oppo.com>
References: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <YPsbQzcNz+r4V7P2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPsbQzcNz+r4V7P2@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Fri, Jul 23, 2021 at 08:40:51PM +0100, Matthew Wilcox wrote:
> On Sat, Jul 24, 2021 at 01:41:31AM +0800, Gao Xiang wrote:
> > Add support for reading inline data content into the page cache from
> > nonzero page-aligned file offsets.  This enables the EROFS tailpacking
> > mode where the last few bytes of the file are stored right after the
> > inode.
> > 
> > The buffered write path remains untouched since EROFS cannot be used
> > for testing. It'd be better to be implemented if upcoming real users
> > care and provide a real pattern rather than leave untested dead code
> > around.
> 
> My one complaint with this version is the subject line.  It's a bit vague.
> I went with:
> 
> iomap: Support file tail packing
> 
> I also wrote a changelog entry that reads:
>     The existing inline data support only works for cases where the entire
>     file is stored as inline data.  For larger files, EROFS stores the
>     initial blocks separately and then can pack a small tail adjacent to
>     the inode.  Generalise inline data to allow for tail packing.  Tails
>     may not cross a page boundary in memory.
>

Yeah, we could complete the commit message like this.

Actually EROFS inode base is only 32-byte or 64-byte (so the maximum could
not be exactly small), compared to using another tail block or storing other
(maybe) irrelevant inodes. According to cache locality principle, a strategy
can be selected by mkfs to load tail block with the inode base itself to the
page cache by the tail-packing inline and so reduce I/O and fragmentation.

> ... but I'm not sure that's necessarily better than what you've written
> here.
> 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Many thanks for the review!

Thanks,
Gao Xiang

