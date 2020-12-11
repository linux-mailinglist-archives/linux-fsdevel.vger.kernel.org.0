Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB82D6E84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 04:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405181AbgLKDY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 22:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgLKDYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:24:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85117C0613CF;
        Thu, 10 Dec 2020 19:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h1ItAtttIP+TZIyDmZIVcshxsJoglh7D0VrSYqu3emU=; b=J79o8T0VKUAYCZym9j4xK1EfE+
        ++ZctLDJKIjAt3C5ZBJfKlyo6p1ZNeb+OlDEmXsLX9GvJPhWy7C4JfpybCei+p+eTcBpVPy8LH5r4
        1zs0S4ZErIZx/o+Nsy9IUDrz69upWEHwbsDjoXHd1IHdWwjphDqZ3U/XVAEgM0kI9YDIJsY5OLugE
        e8EgYURKXkYwkFmGhvhWBgWKWGOgiX357PavvIRZ6EWBx4TxIuTy5LKP1iXJ8gcUUeRGA+72bpxCJ
        SBaKa3mo7ZvlUfRx+rjky8FcUxoackM6+4xWYKuNkjtDn4sF8ix/JNTqCajA4Ydl+nnYFOMYamxg4
        4Aw+Zc3A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knZ2G-00088z-AS; Fri, 11 Dec 2020 03:24:00 +0000
Date:   Fri, 11 Dec 2020 03:24:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/29] RFC: iov_iter: Switch to using an ops table
Message-ID: <20201211032400.GD7338@casper.infradead.org>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 21, 2020 at 02:13:21PM +0000, David Howells wrote:
> I had a go switching the iov_iter stuff away from using a type bitmask to
> using an ops table to get rid of the if-if-if-if chains that are all over
> the place.  After I pushed it, someone pointed me at Pavel's two patches.
> 
> I have another iterator class that I want to add - which would lengthen the
> if-if-if-if chains.  A lot of the time, there's a conditional clause at the
> beginning of a function that just jumps off to a type-specific handler or
> to reject the operation for that type.  An ops table can just point to that
> instead.

So, given the performance problem, how about turning this inside out?

struct iov_step {
	union {
		void *kaddr;
		void __user *uaddr;
	};
	unsigned int len;
	bool user_addr;
	bool kmap;
	struct page *page;
};

bool iov_iterate(struct iov_step *step, struct iov_iter *i, size_t max)
{
	if (step->page)
		kunmap(page)
	else if (step->kmap)
		kunmap_atomic(step->kaddr);

	if (max == 0)
		return false;

	if (i->type & ITER_IOVEC) {
		step->user_addr = true;
		step->uaddr = i->iov.iov_base + i->iov_offset;
		return true;
	}
	if (i->type & ITER_BVEC) {
		... get the page ...
	} else if (i->type & ITER_KVEC) {
		... get the page ...
	} else ...

	kmap or kmap_atomic as appropriate ...
	...set kaddr & len ...

	return true;
}

size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
{
	struct iov_step step = {};

	while (iov_iterate(&step, i, bytes)) {
		if (user_addr)
			copy_from_user(addr, step.uaddr, step.len);
		else
			memcpy(addr, step.kaddr, step.len);
		bytes -= step.len;
	}
}

