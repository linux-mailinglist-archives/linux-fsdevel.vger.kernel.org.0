Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0432BA02C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 03:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKTCGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 21:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTCGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:06:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47FDC0613CF;
        Thu, 19 Nov 2020 18:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ub65jIbnLZwJLU515Ri2kLFETMAxAqgmYpuGV9+3IAI=; b=hgYvpX4Sw/Ge1C3LcXHS2uiNnZ
        +0NmvLVnJuBiEXljH9nuf9xATNx08m4Ei21XHI8xLaCIOm/NMcu93C9GeUsnFIgQ9XpJMoAAobnDf
        cgR/9l8aeQ8g5yo9q4cSev/gbNBpXQW++Xoz33dpuJvPi273ArdfW3JT/id35pbvrpmcV2lB241J1
        zKzQtRtfAJrjLMlS4GzAz/FQJqUUYsedk/mCPGgbOciER9wlNl4Zq97wE0O4tNHDhPdKl3jVtQ4YJ
        8kqtv6aYK+NxcIMyt/ptKseG/NpWsczv1iKV4v3FajNLUz+foz2wY/cQrLB6M/96FF9UCGDLulVQG
        sMoVfLcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfvoQ-0007Js-B6; Fri, 20 Nov 2020 02:06:10 +0000
Date:   Fri, 20 Nov 2020 02:06:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Message-ID: <20201120020610.GL29991@casper.infradead.org>
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
 <20201120014904.GK29991@casper.infradead.org>
 <3dc0b17d-b907-d829-bfec-eab96a6f4c30@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc0b17d-b907-d829-bfec-eab96a6f4c30@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:22AM +0000, Pavel Begunkov wrote:
> On 20/11/2020 01:49, Matthew Wilcox wrote:
> > On Fri, Nov 20, 2020 at 01:39:05AM +0000, Pavel Begunkov wrote:
> >> On 20/11/2020 01:20, Matthew Wilcox wrote:
> >>> On Thu, Nov 19, 2020 at 11:24:38PM +0000, Pavel Begunkov wrote:
> >>>> The block layer spends quite a while in iov_iter_npages(), but for the
> >>>> bvec case the number of pages is already known and stored in
> >>>> iter->nr_segs, so it can be returned immediately as an optimisation
> >>>
> >>> Er ... no, it doesn't.  nr_segs is the number of bvecs.  Each bvec can
> >>> store up to 4GB of contiguous physical memory.
> >>
> >> Ah, really, missed min() with PAGE_SIZE in bvec_iter_len(), then it's a
> >> stupid statement. Thanks!
> >>
> >> Are there many users of that? All these iterators are a huge burden,
> >> just to count one 4KB page in bvec it takes 2% of CPU time for me.
> > 
> > __bio_try_merge_page() will create multipage BIOs, and that's
> > called from a number of places including
> > bio_try_merge_hw_seg(), bio_add_page(), and __bio_iov_iter_get_pages()
> 
> I get it that there are a lot of places, more interesting how often
> it's actually triggered and if that's performance critical for anybody.
> Not like I'm going to change it, just out of curiosity, but bvec.h
> can be nicely optimised without it.

Typically when you're allocating pages for the page cache, they'll get
allocated in order and then you'll read or write them in order, so yes,
it ends up triggering quite a lot.  There was once a bug in the page
allocator which caused them to get allocated in reverse order and it
was a noticable performance hit (this was 15-20 years ago).
