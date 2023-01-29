Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9967FCCB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 06:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjA2FHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 00:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2FHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:07:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99E82311A
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jan 2023 21:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n+IdXcUnXR4S8DYzvLhJeQC0f/QoW2ZpFttM7uOBjZI=; b=ASOapgv3BHUZEw2SNKT9YSaICg
        SuYkJZHV0f2QSW94/FENWJsm7YTtbZzkg6BGsCzoCdOGBaBWBvPaZ/gzwK7IvDb0dIn3LkZFxxrBu
        nlAGmxDN0b/jfifdtB1Yd8QUsizJFogiQJwO7gGa+90oGXhrRdUrAvzpv7LkV8Ov4pYV1FnlkS6me
        gXaeOqZm3R6AtCP9cN6IykraFBJE12W88pPk6P9UVHYbbIIeswVx++xxiD1KO+pHLPCgXwRe2k+GG
        v4eaWilMk6te1jVYJOGkF9QYDvbrMqcr0VJW2a4SrxI5IH/anxw3BpLaD2H0LwuXcZXZTyeyk3spz
        sYoEDO0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLztw-009CEE-0K; Sun, 29 Jan 2023 05:06:48 +0000
Date:   Sun, 29 Jan 2023 05:06:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <Y9X+5wu8AjjPYxTC@casper.infradead.org>
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 28, 2023 at 08:46:45PM -0800, Luis Chamberlain wrote:
> I'm hoping this *might* be useful to some, but I fear it may leave quite
> a bit of folks with more questions than answers as it did for me. And
> hence I figured that *this aspect of this topic* perhaps might be a good
> topic for LSF.  The end goal would hopefully then be finally enabling us
> to document IOMAP API properly and helping with the whole conversion
> effort.

+1 from me.

I've made a couple of abortive efforts to try and convert a "trivial"
filesystem like ext2/ufs/sysv/jfs to iomap, and I always get hung up on
what the semantics are for get_block_t and iomap_begin().

> Perhaps fs/buffers.c could be converted to folios only, and be done
> with it. But would we be loosing out on something? What would that be?

buffer_heads are inefficient for multi-page folios because some of the
algorthims are O(n^2) for n being the number of buffers in a folio.
It's fine for 8x 512b buffers in a 4k page, but for 512x 4kb buffers in
a 2MB folio, it's pretty sticky.  Things like "Read I/O has completed on
this buffer, can I mark the folio as Uptodate now?"  For iomap, that's a
scan of a 64 byte bitmap up to 512 times; for BHs, it's a loop over 512
allocations, looking at one bit in each BH before moving on to the next.
Similarly for writeback, iirc.

So +1 from me for a "How do we convert 35-ish block based filesystems
from BHs to iomap for their buffered & direct IO paths".  There's maybe a
separate discussion to be had for "What should the API be for filesystems
to access metadata on the block device" because I don't believe the
page-cache based APIs are easy for fs authors to use.

Maybe some related topics are
"What testing should we require for some of these ancient filesystems?"
"Whose job is it to convert these 35 filesystems anyway, can we just
delete some of them?"
"Is there a lower-performance but easier-to-implement API than iomap
for old filesystems that only exist for compatibiity reasons?"

