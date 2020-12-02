Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4742CB61F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 09:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgLBICp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 03:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBICp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:02:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E4C0613D6;
        Wed,  2 Dec 2020 00:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JxHJ+R1ANKJAKDX7Q5cnIeQ+a5TaYs4+Cc88jWe2k9s=; b=c9k1aD0OLPfTXdBQrxt57cNjL8
        JdCu7Oxex7K9BuyIUI/4kk7GDWSCe8Lriqi4P19KJSVnhFfCrP2qHPaWw69iV/tmZSFa9z3pZW329
        qh2KwxIkmmU4x39LQtGX80mIcOOXdW4WQOb4dVV/29GPlKe07V3haC/oQICikBouhvVJSZPFPVmpr
        1HPS2lk8ZakzkOYtMcTmJha6DBZHhV2qqUqBLhIuHhl00m1UqWI2q79i3LHgwlx6eS05khe100BfI
        2K5QvaqjPWbv6YzPY2lUaazyy3CnASkyyoi5vBzS0b4wCjPUzIGRP5Eezixo3aYJMXrcxZc8kDM6r
        r5mI/lXA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkN5M-0004AZ-RV; Wed, 02 Dec 2020 08:02:00 +0000
Date:   Wed, 2 Dec 2020 08:02:00 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201202080200.GA15726@infradead.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
 <20201201133226.GA26472@infradead.org>
 <6cbce034-b8c9-35d5-e805-f5ed0c169e2a@gmail.com>
 <20201201134542.GA2888@infradead.org>
 <20201202021021.GB494805@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202021021.GB494805@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:10:21AM +0800, Ming Lei wrote:
> > Yes, this will need a careful audit, I'm not too sure offhand.  For the
> > io_uring case which is sortof the fast path the caller won't free them
> > unless we allow the buffer unregistration to race with I/O.
> 
> Loop's aio usage is fine, just found fd_execute_rw_aio() isn't good.

Yes.  But that one is trivial to fix.
