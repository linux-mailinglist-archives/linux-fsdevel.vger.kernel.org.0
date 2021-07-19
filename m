Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710CF3CD5FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 15:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbhGSNFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 09:05:17 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51621 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240279AbhGSNFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:05:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UgH5Ozl_1626702353;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgH5Ozl_1626702353)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Jul 2021 21:45:55 +0800
Date:   Mon, 19 Jul 2021 21:45:53 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andreas Gr?nbacher <andreas.gruenbacher@gmail.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPWCEW3wBx3nOahn@B-P7TQMD6M-0146.local>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gr?nbacher <andreas.gruenbacher@gmail.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
 <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
 <YPLw0uc1jVKI8uKo@casper.infradead.org>
 <YPL0LqHzEbUY4zY/@B-P7TQMD6M-0146.local>
 <YPMkKfegS+9KzEhK@casper.infradead.org>
 <YPVfxn6/oCPBZpKu@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPVfxn6/oCPBZpKu@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:19:34PM +0100, Christoph Hellwig wrote:
> On Sat, Jul 17, 2021 at 07:40:41PM +0100, Matthew Wilcox wrote:
> > Well, either sense of a WARN_ON is wrong.
> > 
> > For a file which is PAGE_SIZE + 3 bytes in size, to_iomap_page() will
> > be NULL.  For a file which is PAGE_SIZE/2 + 3 bytes in size,
> > to_iomap_page() will not be NULL.  (assuming the block size is <=
> > PAGE_SIZE / 2).
> > 
> > I think we need a prep patch that looks something like this:
> 
> Something like this is where we should eventually end up, but it
> also affects the read from disk case so we need to be careful.

I also think it'd be better to leave this hunk as it-is (don't
touch it in this patch), I mean just

iop = iomap_page_create(inode, page);

as
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/iomap/buffered-io.c?id=229adf3c64dbeae4e2f45fb561907ada9fcc0d0c#n256

since iomap_read_inline_data() now calls iomap_set_range_uptodate() to
set blocks uptodate rather than SetPageUptodate() directly and we also
have iomap_page_release() as well.

Some follow-up optimized patch can be raised up independently since
it's somewhat out of current topic for now.

Thanks,
Gao Xiang

