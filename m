Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D34853C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 14:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiAENn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 08:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiAENn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:43:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C23C061761;
        Wed,  5 Jan 2022 05:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RNyqCrQ4mTdFeMG42Bk17LSViXkTcbH7Uoy2iHPtiRE=; b=AKYLzctrun7hdPKoN5yJl7KqnO
        shgmBsTfkd3HSjsPLgGx4wuhV/m/HkWWuNH5+RaFlp0Hd07i7kItwMdG6FXoZEZBa2EnDrOEYBNQ+
        384cd1lGN1puDKyj/3CT9FtdqWq0mbL8h602umpPGPMUkrS61n0EZfiGnfEdI61fXzA1T68Cp+7Ah
        XFCiXvWFvn/NfohRy7/hbxGqw1YxYqlRss8pmi3gX00LHkIV5RN0GbuNbikFmiBTUkkeX81eCkVW+
        7V/4YawfPPti3U/Hh3U8nfOjtamY3jbfY14fI8r4wXQRo/h9kk9JqPo3SnMH7vl58nID3aGvqlcEV
        48PmL4jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n56a2-00EtHr-8a; Wed, 05 Jan 2022 13:43:54 +0000
Date:   Wed, 5 Jan 2022 05:43:54 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <YdWgmlgrCTNMsB53@infradead.org>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <20220104211605.GI945095@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104211605.GI945095@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 08:16:05AM +1100, Dave Chinner wrote:
> > > +	if (ioend->io_inline_bio.bi_iter.bi_sector + (ioend->io_size >> 9) !=
> > 
> > This open codes bio_end_sector()
> 
> No, it doesn't. The ioend can have chained bios or have others merged
> and concatenated to the ioend->io_list, so ioend->io_size != length
> of the first bio in the chain....
> 
> > > +	    next->io_inline_bio.bi_iter.bi_sector)
> > 
> > But more importantly I don't think just using the inline_bio makes sense
> > here as the ioend can have multiple bios.  Fortunately we should always
> > have the last built bio available in ->io_bio.
> 
> Except merging chains ioends and modifies the head io_size to
> account for the chained ioends we add to ioend->io_list. Hence
> ioend->io_bio is not the last bio in a contiguous ioend chain.

Indeed.  We could use bio_end_sector on io_bio or this.
