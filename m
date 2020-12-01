Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0212CA3E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 14:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbgLANdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 08:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbgLANdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:33:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDDC0613CF;
        Tue,  1 Dec 2020 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WA6TfbbvUNqISwb7mJNnzkxcYfFvk82PnVZUq8rvLNg=; b=sLO9WQNR9aNvAwV3blNs0aAJUm
        kqf8laWJmRyiHAD6P6lXn4TeU610XOrdR7DqG6qx23czsVAv7lyxLX7hLOexNIOzQFfvxPQHTLLhX
        C4l15ZS4r4mPQtpRztFw7kAQdZ391dT89RY/RkATJZP64oAf/JGFz9CqtU76wz8tf/7v1ABDmiqVp
        DbgnBMs9PiFaB0xnrbuka2BmqRHKST6x169zl/IVUE92w+jZ+VdxLeIKyk/s2jc1vR7VGomZIWCFF
        MPDtJnHHu8fCNvSKeHN0kl8New9n9bxImcT6yki2WR0LyYY18ksqPAZ9+DrmnOeT41X47BLLoyt9D
        MG+4s2Zg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk5la-0000BI-8w; Tue, 01 Dec 2020 13:32:26 +0000
Date:   Tue, 1 Dec 2020 13:32:26 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201201133226.GA26472@infradead.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:17:49PM +0000, Pavel Begunkov wrote:
> I was thinking about memcpy bvec instead of iterating as a first step,
> and then try to reuse passed in bvec.
> 
> A thing that doesn't play nice with that is setting BIO_WORKINGSET in
> __bio_add_page(), which requires to iterate all pages anyway. I have no
> clue what it is, so rather to ask if we can optimise it out somehow?
> Apart from pre-computing for specific cases...
> 
> E.g. can pages of a single bvec segment be both in and out of a working
> set? (i.e. PageWorkingset(page)).

Adding Johannes for the PageWorkingset logic, which keeps confusing me
everytime I look at it.  I think it is intended to deal with pages
being swapped out and in, and doesn't make much sense to look at in
any form for direct I/O, but as said I'm rather confused by this code.

If PageWorkingset is a non-issue we should be able to just point the
bio at the biovec array.  I think that be done by allocating the bio
with nr_iovecs == 0, and then just updating >bi_io_vec and ->bi_vcnt
using a little helper like this:

static inline void bio_assign_bvec(struct bio *bio, struct bio_vec *bvecs,
		unsigned short nr_bvecs)
{
	WARN_ON_ONCE(BVEC_POOL_IDX(bio) != 0);
	bio->bi_io_vec = bvecs;
	bio->bi_vcnt = nr_bvecs;
}
