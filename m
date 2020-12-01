Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE92CA353
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 14:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgLANAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 08:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgLANAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:00:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79252C0613D4;
        Tue,  1 Dec 2020 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pV+7MSwoAnFEVulPlkClY+HmK/DMFSI9CZVvFfRVBno=; b=PLjxQI++g/sA4khkgH7YTVgrM4
        Zzyu2LLlXxUn4Y1MCTZAYBtZ5PNSDb4Y6+HScqIQDy3jD5Y6D3MqWof+ds2vX7PToI6xRDCkDdfaZ
        P/Wta7jnkWo9YfnUvzlPazPtUdkmAESyGzwIf2YVWjWvdtKRqrs0hoHjvhQNIpR2+r2yz9JzO07WY
        s6QVhYMycf+fVXB0RkfaoPRwnXnaMOuTQiCo0p8d4jp1LdW3yzM1oVILIl64SoL7Tes3l6T1oc/+8
        9OurIj1O/QbrFlJ8PphXHBzqMhONtgMa2SF/2YBbfXOkJXlhBK68sICeUVhVeZBxXN6tKbvjOUFuM
        nwLpmuZw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk5Fo-0006aj-Tf; Tue, 01 Dec 2020 12:59:36 +0000
Date:   Tue, 1 Dec 2020 12:59:36 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201201125936.GA25111@infradead.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201125251.GA11935@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:52:51PM +0000, Matthew Wilcox wrote:
> But the only reason we want to know 'nr_vecs' is so we can allocate a
> BIO which has that many vecs, right?  But we then don't actually use the
> vecs in the bio because we use the ones already present in the iter.
> That was why I had it return 1, not nr_vecs.
> 
> Did I miss something?

Right now __bio_iov_bvec_add_pages does not reuse the bvecs in the
iter.  That being said while we are optmizing this path we might a well
look into reusing them..
