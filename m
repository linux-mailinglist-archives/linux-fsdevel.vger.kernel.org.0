Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8F3DA34E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhG2Mod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhG2Moc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 08:44:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B965C0613C1;
        Thu, 29 Jul 2021 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oXjfFtKgZLjjaAkzD2PYOYGbcbwNVkJ85WUcW9/1HD4=; b=RfbLkQxt9bCyHjwLuYtsMauUSs
        C+CniNsToHGBjSsNwlyhNVDil642ogszADSQfSv4ZvwBevCwcYKh7k6UlMg9YVq818h0Zwzx8YaFv
        Rv/sElD/Q/kvgtA1SX8WczlfQg2HmYinoL3vfM/WOWEFDpccPoN6cTqbDgz6Z8Kk8CHrA69DZ+bfm
        WbBh0S+WDzdv3Jd2EiIwuEjeCwEQOMiec+8NdM7Vz0gISeOZfF0d8woDoTefJmzdla5oBOU/ZW+e5
        inGzfg3Af+ODmxTk78F0DwU5cxoiAfb9Cvr5UNVhZKzAELQiGBrmTAeAlTsYmSm7oiW63g/z5EhaV
        quV2JE6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m95Ny-00H3ig-G4; Thu, 29 Jul 2021 12:43:47 +0000
Date:   Thu, 29 Jul 2021 13:43:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] iomap: Support inline data with block size < page size
Message-ID: <YQKiekbn8wbKklzU@casper.infradead.org>
References: <20210729032344.3975412-1-willy@infradead.org>
 <CAHc6FU5E9AdiH7SnfADteOVdttNFGO1EN0PoiYYVyaftCJ1Mqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5E9AdiH7SnfADteOVdttNFGO1EN0PoiYYVyaftCJ1Mqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 05:54:56AM +0200, Andreas Gruenbacher wrote:
> > -       /* inline data must start page aligned in the file */
> > -       if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> > -               return -EIO;
> 
> Maybe add a WARN_ON_ONCE(size > PAGE_SIZE - poff) here?

Sure!

> >         if (WARN_ON_ONCE(size > PAGE_SIZE -
> >                          offset_in_page(iomap->inline_data)))
> >                 return -EIO;
> >         if (WARN_ON_ONCE(size > iomap->length))
> >                 return -EIO;
> > -       if (WARN_ON_ONCE(page_has_private(page)))
> > -               return -EIO;
> > +       if (poff > 0)
> > +               iomap_page_create(inode, page);
> >
> > -       addr = kmap_atomic(page);
> > +       addr = kmap_atomic(page) + poff;
> 
> Maybe kmap_local_page?

Heh, I do that later when I convert to folios (there is no
kmap_atomic_folio(), only kmap_local_folio()).  But I can throw that
in here too.

