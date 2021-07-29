Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DA83DAA14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhG2R0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 13:26:46 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38645 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232146AbhG2R0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:26:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UhMdJRn_1627579569;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UhMdJRn_1627579569)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Jul 2021 01:26:10 +0800
Date:   Fri, 30 Jul 2021 01:26:08 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] iomap: Support inline data with block size < page size
Message-ID: <YQLksEHixW+4RYqJ@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210729032344.3975412-1-willy@infradead.org>
 <CAHc6FU5E9AdiH7SnfADteOVdttNFGO1EN0PoiYYVyaftCJ1Mqw@mail.gmail.com>
 <YQKiekbn8wbKklzU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQKiekbn8wbKklzU@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Thu, Jul 29, 2021 at 01:43:38PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 29, 2021 at 05:54:56AM +0200, Andreas Gruenbacher wrote:
> > > -       /* inline data must start page aligned in the file */
> > > -       if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> > > -               return -EIO;
> > 
> > Maybe add a WARN_ON_ONCE(size > PAGE_SIZE - poff) here?
> 
> Sure!
> 
> > >         if (WARN_ON_ONCE(size > PAGE_SIZE -
> > >                          offset_in_page(iomap->inline_data)))
> > >                 return -EIO;
> > >         if (WARN_ON_ONCE(size > iomap->length))
> > >                 return -EIO;
> > > -       if (WARN_ON_ONCE(page_has_private(page)))
> > > -               return -EIO;
> > > +       if (poff > 0)
> > > +               iomap_page_create(inode, page);
> > >
> > > -       addr = kmap_atomic(page);
> > > +       addr = kmap_atomic(page) + poff;
> > 
> > Maybe kmap_local_page?
> 
> Heh, I do that later when I convert to folios (there is no
> kmap_atomic_folio(), only kmap_local_folio()).  But I can throw that
> in here too.

I don't find any critical point with this patch (and agree with Andreas'
suggestion), maybe some followup folio work could get more input about
this. I'll evaluate them all together later.

Thanks,
Gao Xiang
