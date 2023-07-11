Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129F674E268
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 02:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGKADY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 20:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGKADX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:03:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3DB1A7;
        Mon, 10 Jul 2023 17:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OIg1kp/WJnFV9ybEubDrpWD253u1Bk/0QbwWg5L22TE=; b=tfZMw1Y7zuAKa9PZBuEvrQuTw4
        oSEHAq90b0reHCdg6yTExotoh6By7oqZDhfUtx8OXiqAzvHtEE9ims/Eh0zTWIfeHr+9+laAMHodp
        SJ8GYYkNg6GSgBnJAbc8hXIXuXJ4Ia/N9BPQ2axYjv9OPmcSbrAkzlT5mmr1/It/zvdQEhwDIJ56R
        zP0mEgSUpfygA6iKLcw6BkaCZKuwKUCiF9F7+W16c+1zzAITrNEOOlKQJx6n5Y+U8ZdFDv7Vb3kpi
        ReNabC/ahbhyNGCvN4DB/fHhmpRG8xD4ZE8hLQvfp92WXPB1UG+RhfgioZJq6zrqwkjysnFAo75Uf
        q5uoyg0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJ0qc-00F3th-B7; Tue, 11 Jul 2023 00:03:18 +0000
Date:   Tue, 11 Jul 2023 01:03:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v4 1/9] iov_iter: Handle compound highmem pages in
 copy_page_from_iter_atomic()
Message-ID: <ZKycRh1ebCg+Yzue@casper.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-2-willy@infradead.org>
 <ZKyXp2NyoHy3K1qu@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKyXp2NyoHy3K1qu@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 04:43:35PM -0700, Luis Chamberlain wrote:
> > -	}
> > -	iterate_and_advance(i, bytes, base, len, off,
> > -		copyin(p + off, base, len),
> > -		memcpy_from_iter(i, p + off, base, len)
> > -	)
> > -	kunmap_atomic(kaddr);
> > -	return bytes;
> > +
> > +	do {
> > +		char *p;
> > +
> > +		n = bytes - copied;
> > +		if (PageHighMem(page)) {
> > +			page += offset / PAGE_SIZE;
> 
> I don't quite follow here how before the page was not modified
> to get to the first kmap_atomic(page) and now immediately if we're
> on a PageHighMem(page) we're doing some arithmetic to the page
> address to get the first kmap_atomic(). The only thing I could
> think of is seems like an implicit assumption here that if its a compound
> highmem page then we always start off with offset with a value of
> 0, is that right? But that seems to not be correct either.

The important thing to know is that it was buggy before.  If you called
copy_page_from_iter_atomic() with an offset larger than PAGE_SIZE, it
corrupted random memory!  I can only assume that nobody was doing that.
