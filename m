Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DEE7453CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 04:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjGCCNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 22:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGCCNV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 22:13:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CCEE49;
        Sun,  2 Jul 2023 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9J/g0VFy6q7xC/ouAKR0qMLrwzHMVyMoe2h/3jmtkiQ=; b=gO+bv3PIquyoknoVsnDh6hJlTV
        dsjpjiYEMMC0uH+o/A84nZoEmVoYrNig2dSILYTA6IRag2BqSEH6G16psuo7t8RjgSrIs5Xi34Bnf
        qBk0l6chAtcIzC1zCqwAN0yiT7ttbtwzROtE8gWvJg1vsDqCw0zHlAR6pOY7p1XS1ONv0ND7M/o/q
        5Q/gdEBKfLB2w0BOKOkz57ZhQ0uTMKqsXKno279NrWZMKJKFK0kACnyq0LZv2W2x28aYKY6v8WOPv
        cQu+2I8rAfPp7ItK0nqHbdxnAXAaewNOz3DOewRm3VVVu1akf2V1aNbvRLAW0wJKXwecaVHmXJjge
        0EYZ78Fw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qG93z-007pby-VW; Mon, 03 Jul 2023 02:13:16 +0000
Date:   Mon, 3 Jul 2023 03:13:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] writeback: Account the number of pages written back
Message-ID: <ZKIuu6uQQJIQE640@casper.infradead.org>
References: <20230628185548.981888-1-willy@infradead.org>
 <20230702130615.b72616d7f03b3ab4f6fc8dab@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702130615.b72616d7f03b3ab4f6fc8dab@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 02, 2023 at 01:06:15PM -0700, Andrew Morton wrote:
> On Wed, 28 Jun 2023 19:55:48 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > nr_to_write is a count of pages, so we need to decrease it by the number
> > of pages in the folio we just wrote, not by 1.  Most callers specify
> > either LONG_MAX or 1, so are unaffected, but writeback_sb_inodes()
> > might end up writing 512x as many pages as it asked for.
> 
> 512 is a big number,  Should we backport this?

I'm really not sure.  Maybe?  I'm hoping one of the bots comes up with a
meaningful performance change as a result of this patch and we find out.

> > Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> 
> I'm not seeing how a readahead change messed up writeback accounting?

That was the first patch which allowed large folios to be added to the
page cache.  Until that point, this was latent.  We could probably argue
for one of a dozen other commits around the same time.
