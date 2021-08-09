Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5E13E47EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhHIOv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHIOv1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:51:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD96C0613D3;
        Mon,  9 Aug 2021 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A5CJ5s/wZg25gVdQUYibxv9WUlHpW5z6QpBFDTGosjo=; b=NY/GCnmesmBhmwq7mNNxRMY7YO
        m6tGGitjoDJoZ8PlCMdSNDnE6MQKH2Pa80y0gmyV0YZNgc6re0kypx8tx+pgkNc94OU2jB2LYb1Uv
        Ttb5mNFnwA4LbLkCPH/zuDD8iKUwEVlm7zFXQxrrJGqxiN4VmrXUkMswbSdURfLptQ3XqVnh6ClDI
        sGt4GkuJeGXhDR761nQxQsZ8R4Zjv11X5dNq0sz0XqIjVzyrZPZvzRGP4NRGiNBVPixepaaxv7iz1
        cCIhKnG+X9TqoiyMT2sc/C1Drdqh9tbSzJhkxs0YsPGrUaj63jO2PDFn7v9HC3mCRUIf7dhGpvjvu
        8T7UhDFw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD6aG-00B5e5-9L; Mon, 09 Aug 2021 14:49:32 +0000
Date:   Mon, 9 Aug 2021 15:48:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Zhengyuan Liu <liuzhengyuang521@gmail.com>, yukuai3@huawei.com,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>, linux-xfs@vger.kernel.org
Subject: Re: Dirty bits and sync writes
Message-ID: <YRFAWPdMHp8Wpds/@infradead.org>
References: <YQlgjh2R8OzJkFoB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQlgjh2R8OzJkFoB@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:28:14PM +0100, Matthew Wilcox wrote:
> Solution 1: Add an array of dirty bits to the iomap_page
> data structure.  This patch already exists; would need
> to be adjusted slightly to apply to the current tree.
> https://lore.kernel.org/linux-xfs/7fb4bb5a-adc7-5914-3aae-179dd8f3adb1@huawei.com/

> Solution 2a: Replace the array of uptodate bits with an array of
> dirty bits.  It is not often useful to know which parts of the page are
> uptodate; usually the entire page is uptodate.  We can actually use the
> dirty bits for the same purpose as uptodate bits; if a block is dirty, it
> is definitely uptodate.  If a block is !dirty, and the page is !uptodate,
> the block may or may not be uptodate, but it can be safely re-read from
> storage without losing any data.

1 or 2a seems like something we should do once we have lage folio
support.


> Solution 2b: Lose the concept of partially uptodate pages.  If we're
> going to write to a partial page, just bring the entire page uptodate
> first, then write to it.  It's not clear to me that partially-uptodate
> pages are really useful.  I don't know of any network filesystems that
> support partially-uptodate pages, for example.  It seems to have been
> something we did for buffer_head based filesystems "because we could"
> rather than finding a workload that actually cares.

The uptodate bit is important for the use case of a smaller than page
size buffered write into a page that hasn't been read in already, which
is fairly common for things like log writes.  So I'd hate to lose this
optimization.

> (it occurs to me that solution 3 actually allows us to do IOs at storage
> block size instead of filesystem block size, potentially reducing write
> amplification even more, although we will need to be a bit careful if
> we're doing a CoW.)

number 3 might be nice optimization.  The even better version would
be a disk format change to just log those updates in the log and
otherwise use the normal dirty mechanism.  I once had a crude prototype
for that.
