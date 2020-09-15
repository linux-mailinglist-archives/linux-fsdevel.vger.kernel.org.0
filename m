Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE2F26B218
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgIOWl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbgIOP5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:57:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9EC061351;
        Tue, 15 Sep 2020 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9hpqrM0yq5Ww64iJO3HcA4+NwEdTQm35KV/P4mwZVJ8=; b=Ld8EqgoTHdhtpXDolfkH6H8955
        WruBG1aYD6Yzgd0KGMn5LG/XdiTjqpJayTXIZJPGsHoO2OlPUygq7PKR6gJflJxy6AAhgs+gwnrD4
        gwA4p82nbFgJxHk51dAZBJ3pomaao852oedeL5oJlv/N8ObKdMjc2T3MOu7eyjYQdjWU0Yrnkx9qB
        CGP7Kj91TJbLimXQ0puCBDNC0OxZGlIVJEvC9EFoIfiMMjlFX7gMOjBw+lO5Y20877/EWw4k2hgG6
        Asf3XkrMLaNfUI7U8J0+RAyqsP2J62ZETQcXEChi6hharp4fYKPNuqrKvVqCItl38spq9NmXSuOV1
        H2ZJ6fRw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIDDB-0002uB-5c; Tue, 15 Sep 2020 15:49:41 +0000
Date:   Tue, 15 Sep 2020 16:49:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 2/9] fs: Introduce i_blocks_per_page
Message-ID: <20200915154941.GJ5449@casper.infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-3-willy@infradead.org>
 <0c874f14499c4d819f3e8e09f5086d77@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c874f14499c4d819f3e8e09f5086d77@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 03:40:52PM +0000, David Laight wrote:
> > @@ -147,7 +147,7 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
> >  	unsigned int i;
> > 
> >  	spin_lock_irqsave(&iop->uptodate_lock, flags);
> > -	for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
> > +	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
> 
> You probably don't want to call the helper every time
> around the loop.

This is a classic example of focusing on the details and missing the
larger picture.  We don't want the loop at all, and if you'd kept reading
the patch series, you'd see it disappear later.
