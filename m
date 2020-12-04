Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E572F2CEE56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 13:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgLDMte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 07:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgLDMte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 07:49:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AEBC0613D1;
        Fri,  4 Dec 2020 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QCYDsdbruYLlGkC4FCVFrlrnab6XBVhVO98ZM7UlAeM=; b=iDpcfU9unXpujJhUoJor4SQ/fw
        fs3m7PurZ3py8EF7VgF2NqwfBc2xkLCpj9ISLLqdpAIeCkwvMHHyfgVA04sWOHaYphWdGVB8igVZ5
        EZYGT1b2NpiXN/OTJ1z8Nj8tUqbC+8fMaY11gREd4DahE/TwcjzkA5J0ve1m8zwnENEyfzAhoVtXa
        QaKuyeuDSmBR8tcep/2KY7prljtRs4FzQHhaVbU42ZvmUF0Kw/M5J2ayrdJslw4OI4oqRKFn5aLLz
        mvTi+NUE0xRvGKdHaTCMPTISsTtUC5unpHifuY40Eit58zZhMMcY/Up7/M13jDQ1KKQxyn0PjzjFw
        NHQAtw3A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klAW1-0002KE-N5; Fri, 04 Dec 2020 12:48:49 +0000
Date:   Fri, 4 Dec 2020 12:48:49 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201204124849.GA8768@infradead.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
 <20201201133226.GA26472@infradead.org>
 <20201203223607.GB53708@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203223607.GB53708@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 05:36:07PM -0500, Johannes Weiner wrote:
> Correct, it's only interesting for pages under LRU management - page
> cache and swap pages. It should not matter for direct IO.
> 
> The VM uses the page flag to tell the difference between cold faults
> (empty cache startup e.g.), and thrashing pages which are being read
> back not long after they have been reclaimed. This influences reclaim
> behavior, but can also indicate a general lack of memory.

I really wonder if we should move setting the flag out of bio_add_page
and into the writeback code, as it will do the wrong things for
non-writeback I/O, that is direct I/O or its in-kernel equivalents.
