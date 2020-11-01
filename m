Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6348A2A1D93
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 12:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgKALXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 06:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgKALXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 06:23:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D4AC0617A6
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2020 03:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ac8KT2cdwqveY+k5EytssuoAKLCH2AuwCi2Gdc4lRqw=; b=Ve4OZqMA3Mp3j5qeOlq2XnxivQ
        ZQjmVMBuFWdwWumWgQfxd1lQxdJ4Bhsr461UIsZP5uyjqiloR8szxjRin2K414v4yjt0etkzvi2TQ
        MUMFO2U7+AHugR5zBUuh+7Gmzwf78a7AMG84xTnrEmMa3zkUuEyUqNPjrzU8hO4oiRTmhSvYQkRRe
        KxOJ91yDdNp+r+09GOxShu8s2fjTo7ERKavf72CZXETqp9FmgVIOKrt8z13DueBoVC0hcHm7eLWGD
        qXY4KC5cQ0ZE+Btp97mGjdoU5ZMaxaedZcLbYwCB/dFf7e/DWW8eRE0Sh3MIvFLNrYvaMeA5pMDgi
        YeIJ8SJg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZBSP-00045d-TZ; Sun, 01 Nov 2020 11:23:34 +0000
Date:   Sun, 1 Nov 2020 11:23:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/13] mm: streamline the partially uptodate checks in
 filemap_make_page_uptodate
Message-ID: <20201101112333.GY27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
 <20201031090004.452516-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031090004.452516-12-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 10:00:02AM +0100, Christoph Hellwig wrote:
> +	if (mapping->host->i_blkbits <= PAGE_SHIFT &&
> +	    mapping->a_ops->is_partially_uptodate &&
> +	    !iov_iter_is_pipe(iter) &&
> +	    trylock_page(page)) {
> +		loff_t pos = max(iocb->ki_pos, (loff_t)pg_index << PAGE_SHIFT);

I think the cure is worse than the disease here ;-)

Fortunately, I simplified this here:
https://git.infradead.org/users/willy/pagecache.git/commitdiff/c6b5b2540b6db91d3c8928c8ed1b5d72a402215a

by getting the page lock earlier (or dropping the reference to the page,
waiting for it to become unlocked and starting the lookup again)
