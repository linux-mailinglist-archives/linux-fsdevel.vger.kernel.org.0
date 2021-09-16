Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D4240D39D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 09:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhIPHOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 03:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhIPHOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:14:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361CCC061574;
        Thu, 16 Sep 2021 00:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VfwB0VmftNDQd6y4aXaAqhBjlfbTQ/OFHN+xTApc8gs=; b=DsoV0b3HNBIlGr+GxiEumtpSDq
        JiOkrBKaFQfhHLKqwzQs8mk8MkY4v+YlDMaFtzvPpoo7QnrTEBKh/9c7TKaavub88pASLyp9pZtHy
        YQeYen6mmgH6JS5h380iv1K9328nIe6NzWGX2SbF396xIVxG8m5IImv3dYEqSxsrhQEu+wWIJwngf
        Q0IA3T9WyEG8p3yQEGl5spbSnshUKhaOdZNF6PzORcSthAxGHMB9kxLj1MNftSCWj4PG/t0Y0ujF1
        X5TD88sqTAi5dwPU2Bn04oRqGW0RlJWjQuy59uiOI7TmqxoX8gNh1og9ZdDwOBaVxPXj26nTglaof
        s5zneXzA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQlYf-00GPH6-0D; Thu, 16 Sep 2021 07:11:51 +0000
Date:   Thu, 16 Sep 2021 08:11:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
Message-ID: <YULuMO86NrQAPcpf@infradead.org>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
 <20210915161510.GA34830@magnolia>
 <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 01:27:47PM -0700, Dan Williams wrote:
> > Yeah, Christoph suggested that we make the clearing operation explicit
> > in a related thread a few weeks ago:
> > https://lore.kernel.org/linux-fsdevel/YRtnlPERHfMZ23Tr@infradead.org/
> 
> That seemed to be tied to a proposal to plumb it all the way out to an
> explicit fallocate() mode, not make it a silent side effect of
> pwrite().

Yes.

> >
> > Each of the dm drivers has to add their own ->clear_poison operation
> > that remaps the incoming (sector, len) parameters as appropriate for
> > that device and then calls the lower device's ->clear_poison with the
> > translated parameters.
> >
> > This (AFAICT) has already been done for dax_zero_page_range, so I sense
> > that Dan is trying to save you a bunch of code plumbing work by nudging
> > you towards doing s/dax_clear_poison/dax_zero_page_range/ to this series
> > and then you only need patches 2-3.
> 
> Yes, but it sounds like Christoph was saying don't overload
> dax_zero_page_range(). I'd be ok splitting the difference and having a
> new fallocate clear poison mode map to dax_zero_page_range()
> internally.

That was my gut feeling.  If everyone feels 100% comfortable with
zeroingas the mechanism to clear poisoning I'll cave in.  The most
important bit is that we do that through a dedicated DAX path instead
of abusing the block layer even more.

> 
> >
> > > BTW, our customer doesn't care about creating dax volume thru DM, so.
> >
> > They might not care, but anything going upstream should work in the
> > general case.
> 
> Agree.

I'm really worried about both patartitions on DAX and DM passing through
DAX because they deeply bind DAX to the block layer, which is just a bad
idea.  I think we also need to sort that whole story out before removing
the EXPERIMENTAL tags.
