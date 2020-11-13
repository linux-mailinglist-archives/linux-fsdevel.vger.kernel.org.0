Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF61D2B152B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 05:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgKMEqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 23:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgKMEqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 23:46:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071BEC0613D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 20:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5XkRS8SQi9lZ8xBy4p7uZlvNXOyVuyNr1Qx3lDzm30s=; b=OIkfBs7EidbKhFO+6xVRa4W1ss
        ht7YRsIJ/fkKyxjdOxBNMlMqD8toUGAkWWsDD2k+nLoURjK65fDQLkjjNpWDnBjZzXXh/2J198a93
        rrMwBcE0CQKbZKJbO/UYSIsw6QfR6eGKPYNVf4p2b5QUeX5aMHkUQYKK3JwJ5D94WUA0IHR/KN4co
        nwS3q7DdbcLTPBpdEnHOTaFNZr231G6Wyh/IPLf26RYCNmQXgl7DmHcRX6vABdzx9gpZP0a+15KJE
        PxNpaYl+BlOVafynuLOin0uCQGTZ8W5kczD4L0oLDoRebs/3Un63QnBo49sMvUg/TxhXrXr5jqSrU
        51FOETjg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdQz6-0004Td-AM; Fri, 13 Nov 2020 04:46:52 +0000
Date:   Fri, 13 Nov 2020 04:46:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Are THPs the right model for the pagecache?
Message-ID: <20201113044652.GD17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When I started working on using larger pages in the page cache, I was
thinking about calling them large pages or lpages.  As I worked my way
through the code, I switched to simply adopting the transparent huge
page terminology that is used by anonymous and shmem.  I just changed
the definition so that a thp is a page of arbitrary order.

But now I'm wondering if that expediency has brought me to the right
place.  To enable THP, you have to select CONFIG_TRANSPARENT_HUGEPAGE,
which is only available on architectures which support using larger TLB
entries to map PMD-sized pages.  Fair enough, since that was the original
definition, but the point of suppoting larger page sizes in the page
cache is to reduce software overhead.  Why shouldn't Alpha or m68k use
large pages in the page cache, even if they can't use them in their TLBs?

I'm also thinking about the number of asserts about
PageHead/PageTail/PageCompound and the repeated invocations of
compound_head().  If we had a different type for large pages, we could use
the compiler to assert these things instead of putting in runtime asserts.

IOWs, something like this:

struct lpage {
	struct page subpages[4];
};

static inline struct lpage *page_lpage(struct page *page)
{
	unsigned long head = READ_ONCE(page->compound_head);

	if (unlikely(head & 1))
		return (struct lpage *)(head - 1);
	return (struct lpage *)page;
}

We can then work our way through the code, distinguishing between
functions which really want to get an lpage (ie ones which currently
assert that they see only a PageHead) and functions which want to get
a particular subpage.

Some functions are going to need to be split.  eg pagecache_get_page()
currently takes an FGP_HEAD flag which determines whether it returns
a head page or the subpage for the index.  FGP_HEAD will have to
go away in favour of having separate pagecache_get_subpage() and
pagecache_get_lpage().  Or preferably, all callers of pagecache_get_page()
get converted to use lpages and they can call find_subpage() all by
themselves, if they need it.

Feels like a lot of work, but it can be done gradually.  My fear with
the current code is that filesystem writers who want to convert to
supporting THPs are not going to understand which interfaces expect a
THP and which expect a subpage.  For example, vmf->page (in the mkwrite
handler) is a subpage.  But the page passed to ->readpage is a THP.
I don't think we're going to be able to switch either of those any time
soon, so distinguishing them with a type seems only fair to fs authors.
See, for example, Darrick's reasonable question here:
https://lore.kernel.org/linux-fsdevel/20201014161216.GE9832@magnolia/

I'm not volunteering to do any of this in time for the next merge window!
I have lots of patches to get approved by various maintainers in the
next two weeks!
