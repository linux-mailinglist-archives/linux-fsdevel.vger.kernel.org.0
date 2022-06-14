Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169DA54B768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbiFNRMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 13:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244672AbiFNRMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:12:38 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938A11160;
        Tue, 14 Jun 2022 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UnkcKB4NsDJ0e+mJiYWNx+eCTEwD4IDtNjFvnXDcokg=; b=JXA09RScBAaWksG9w8f1eTRDx4
        jPYffuxU/Oy99uzq/dqd//WYwokS38bI/QGvYknm8zFgS3vrQtkcoOX6qIO7tKKQRLFroHKgAkjSb
        /tvxwZw2q5CrF7NG3K0+O5rp7pIMysDT64NN6/ccTPvjXzCgRYF4ZXZWRGSgm/GTaAwh3ankYtsj2
        i1oLpSEKv0CjPVVjmPZkIIBFcgaJA+8/C78nDnACERWnKrtVFsFAjbuPdTHnA3fHbQqUY3QahA2TN
        IYY426fKPxYxFAz+mA4FdDG8SpuVxjKd2wLkgh7y/iu+e9O/fTibDiIVfWIcDfvjF3seVpliF0mH6
        h7djO54g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o1A5W-000L3R-Dg;
        Tue, 14 Jun 2022 17:12:22 +0000
Date:   Tue, 14 Jun 2022 18:12:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev, David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] fix short copy handling in copy_mc_pipe_to_iter()
Message-ID: <YqjBdtzXSKgwUi8f@ZenIV>
References: <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk>
 <CAHk-=wjmCzdNDCt6L8-N33WSRaYjnj0=yTc_JG8A_Pd7ZEtEJw@mail.gmail.com>
 <Yqe6EjGTpkvJUU28@ZenIV>
 <YqfcHiBldIqgbu7e@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqfcHiBldIqgbu7e@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 14, 2022 at 01:53:50AM +0100, Al Viro wrote:

> FWIW, I've got quite a bit of cleanups in the local tree; reordering and
> cleaning that queue up at the moment, will post tonight or tomorrow.
> 
> I've looked into doing allocations page-by-page (instead of single
> push_pipe(), followed by copying into those).  Doable, but it ends
> up being much messier.

Hmm...  Maybe not - a possible interface would be
	append_pipe(iter, size, &off)

that would either do kmap_local_page() on the last buffer (if it's
anonymous and has space in it) or allocated and mapped a page and
added a new buffer.  Returning the mapped address and offset from it.
Then these loops would looks like this:

	while (left) {
		p = append_pipe(iter, left, &off);
		if (!p)
			break;
		chunk = min(left, PAGE_SIZE - off);
		rem = copy(p + off, whatever, chunk);
		chunk -= rem;
		kunmap_local(p);

		copied += chunk;
		left -= chunk;

		if (unlikely(rem)) {
			pipe_revert(i, rem);
			break;
		}
	}
	return copied;

with no push_pipe() used at all.  For operations that can't fail,
the things are simplified in an obvious way (rem is always 0).

Or we could have append_pipe() return a struct page * and leave
kmap_local_page() to the caller...

struct page *append_pipe(struct iov_iter *i, size_t size, unsigned *off)
{
	struct pipe_inode_info *pipe = i->pipe;
	unsigned offset = i->iov_offset;
	struct page_buffer *buf;
	struct page *page;

	if (offset && offset < PAGE_SIZE) {
		// some space in the last buffer; can we add to it?
		buf = pipe_buf(pipe, pipe->head - 1);
		if (allocated(buf)) {
			size = min(size, PAGE_SIZE - offset);
			buf->len += size;
			i->iov_offset += size;
			i->count -= size;
			*off = offset;
			return buf->page;	// or kmap_local_page(...)
		}
	}
	// OK, we need a new buffer
	size = min(size, PAGE_SIZE);
	if (pipe_full(.....))
		return NULL;
	page = alloc_page(GFP_USER);
	if (!page)
		return NULL;
	// got it...
	buf = pipe_buf(pipe, pipe->head++);
	*buf = (struct pipe_buffer){.ops = &default_pipe_buf_ops,
				    .page = page, .len = size };
	i->head = pipe->head - 1;
	i->iov_offset = size;
	i->count -= size;
	*off = 0;
	return page;	 // or kmap_local_page(...)
}

(matter of fact, the last part could use another helper in my tree - there
the tail would be
	// OK, we need a new buffer
	size = min(size, PAGE_SIZE);
	page = push_anon(pipe, size);
	if (!page)
		return NULL;
	i->head = pipe->head - 1;
	i->iov_offset = size;
	i->count -= size;
	*off = 0;
	return page;
)

Would that be readable enough from your POV?  That way push_pipe()
loses almost all callers and after the "make iov_iter_get_pages()
advancing" part of the series it simply goes away...

It's obviously too intrusive for backports, though - there I'd very much
prefer the variant I posted.

Comments?

PS: re local helpers:

static inline struct pipe_buffer *pipe_buf(const struct pipe_inode_info *pipe,
                                           unsigned int slot)
{
	return &pipe->bufs[slot & (pipe->ring_size - 1)];
}

pretty much all places where we cache pipe->ring_size - 1 had been
absolutely pointless; there are several exceptions, but back in 2019
"pipe: Use head and tail pointers for the ring, not cursor and length"
went overboard with microoptimizations...
