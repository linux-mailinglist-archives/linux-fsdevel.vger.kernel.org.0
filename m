Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4837A51B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjIRSJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRSJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:09:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8533FFD;
        Mon, 18 Sep 2023 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PSl3YIBcOMlI28KGljTBp5+6rpOLjzI4VlDZcO+V47g=; b=v51lvSCHJ27MH9SVEXRHAJB7qA
        w2bmT2C1j4sY40YT0/lBFqUnUQofZY/n9WBhFCJUODtoIRh1Yhi6dOTCfiid1DAA5T9ItyXXUffq4
        69/1uJ9eBsRomdm0UojreSlngN5GpIIKlXYZaHSmiyDSTmmkIMIiiVlFRkStsGO2zmdKi1zUQ1h2X
        UXxxarA3pXN01KQqteWffiqwvCtCnZZm4fyutmKct5sD9jNukJltAcKA6UGwwL/ZKljZR3P/wzI82
        KePlKSnNqxk7hiuBh+qjfn0mBcRw3fv4ieCqpCkY0JMkZM3bhv4I4UYRAZW/TlYeyKnXA6lPMOB0B
        2/05ZOPw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiIg8-00G33u-1d;
        Mon, 18 Sep 2023 18:09:00 +0000
Date:   Mon, 18 Sep 2023 11:09:00 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/6] filemap: make the folio order calculation shareable
Message-ID: <ZQiSPEKRJSkeh3Fe@bombadil.infradead.org>
References: <20230915095042.1320180-1-da.gomez@samsung.com>
 <CGME20230915095124eucas1p1eb0e0ef883f6316cf14c349404a51150@eucas1p1.samsung.com>
 <20230915095042.1320180-2-da.gomez@samsung.com>
 <ZQRet4w5VSbvKvKB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQRet4w5VSbvKvKB@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 02:40:07PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 09:51:23AM +0000, Daniel Gomez wrote:
> > To make the code that clamps the folio order in the __filemap_get_folio
> > routine reusable to others, move and merge it to the fgf_set_order
> > new subroutine (mapping_size_order), so when mapping the size at a
> > given index, the order calculated is already valid and ready to be
> > used when order is retrieved from fgp_flags with FGF_GET_ORDER.
> > 
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  fs/iomap/buffered-io.c  |  6 ++++--
> >  include/linux/pagemap.h | 42 ++++++++++++++++++++++++++++++++++++-----
> >  mm/filemap.c            |  8 --------
> >  3 files changed, 41 insertions(+), 15 deletions(-)
> 
> That seems like a lot of extra code to add in order to avoid copying
> six lines of code and one comment into the shmem code.
> 
> It's not wrong, but it seems like a bad tradeoff to me.

The suggestion to merge came from me, mostly based on later observations
that in the future we may want to extend this with a min order to ensure
the index is aligned the the order. This check would only be useful for
buffred IO for iomap, readahead. It has me wondering if buffer-heads
support for large order folios come around would we a similar check
there?

So Willy, you would know better if and when a shared piece of code would
be best with all these things in mind.

  Luis
