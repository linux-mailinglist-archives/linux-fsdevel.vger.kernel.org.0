Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14192CA439
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 14:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbgLANq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 08:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbgLANq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:46:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391AC0613CF;
        Tue,  1 Dec 2020 05:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pGRq4fWCnGFZIqZ9HycR8KxbAHBvcDU4YuOTbak6eIA=; b=nNh1jyE6ZMLcUXsdGJQZFK0f2y
        FAYHyaCKHzRkWc+9W7CowxK9oTH+5IvMNGGnnCyEIh6NVAnNzXenrg1wJiUMqoZYqM+q46OfJRr7t
        QGjTPjQKXxP3nKbWK3ZARN7QSJBOFsqE6J//17Exonzcz4EoJONJFr9KEUUMsAwvBqiHnH9qFEQPq
        XLYhxWDcPxnopOE0W7u3/Ifg8pJitgYl+3N/2FsBG7wp+GvZMiTuc5HkkNFlzO0D8lJZ2Xtbo6sFR
        6QU2Yo56oZOkl+thlLFmOy1V3PHNj6ZoO3CM0OseiHxVdoSnwAJ3IMm5d+X1nD+6rQzlV9AviwmrW
        xwLX7ctg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk5yQ-00010z-U0; Tue, 01 Dec 2020 13:45:42 +0000
Date:   Tue, 1 Dec 2020 13:45:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201201134542.GA2888@infradead.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
 <20201201133226.GA26472@infradead.org>
 <6cbce034-b8c9-35d5-e805-f5ed0c169e2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cbce034-b8c9-35d5-e805-f5ed0c169e2a@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:36:22PM +0000, Pavel Begunkov wrote:
> Yeah, that's the idea, but also wanted to verify that callers don't
> free it while in use, or if that's not the case to make it conditional
> by adding a flag in iov_iter.
> 
> Can anybody vow right off the bat that all callers behave well?

Yes, this will need a careful audit, I'm not too sure offhand.  For the
io_uring case which is sortof the fast path the caller won't free them
unless we allow the buffer unregistration to race with I/O.
