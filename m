Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A61AFF33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 02:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDTAac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 20:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgDTAaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:30:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2B3C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 17:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qf7dVbULEt6mhOZrxqg5HOy9akndvYrNSDgOfIyUT1Q=; b=VmGruTiTDIQjareKbHDsrEO9OI
        J7e5VhEXjEq3521jSS0TKZvcje0A76p02ybSnK95RxM7aeRbgLQhzYpooauhjYZlntuYXWJ9ExVKv
        bgMXtygaX/OF8LHe48WoqyM3hgpSBhpmFr/f0Dd87dyNlDRYLIwFss2EQw8ARxeio/TZQ5DcOXew3
        NkMs0lUWLZzU2yMCJZAwFVJG8zDPAz1D7WwgFA2LD5ekYDIgwjJTghFaI/wGpPwkUdJ7NH9Rp/afu
        nJ3nf9enk/BUp/Up0il1MMPEXZpN2UmDktWN0XV6awrw7mj5J5BQP/pzX/Jiv4f3bOdzHdNIhQx3h
        lYB0irrA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQKKQ-0001Gy-1G; Mon, 20 Apr 2020 00:30:26 +0000
Date:   Sun, 19 Apr 2020 17:30:25 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
Message-ID: <20200420003025.GZ5820@bombadil.infradead.org>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200419031443.GT5820@bombadil.infradead.org>
 <20200419232046.GC9765@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419232046.GC9765@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:20:46AM +1000, Dave Chinner wrote:
> On Sat, Apr 18, 2020 at 08:14:43PM -0700, Matthew Wilcox wrote:
> > On Sun, Apr 19, 2020 at 12:51:18AM +0200, Guoqing Jiang wrote:
> > > When reading md code, I find md-bitmap.c copies __clear_page_buffers from
> > > buffer.c, and after more search, seems there are some places in fs could
> > > use this function directly. So this patchset tries to export the function
> > > and use it to cleanup code.
> > 
> > OK, I see why you did this, but there are a couple of problems with it.
> > 
> > One is just a sequencing problem; between exporting __clear_page_buffers()
> > and removing it from the md code, the md code won't build.
> > 
> > More seriously, most of this code has nothing to do with buffers.  It
> > uses page->private for its own purposes.
> > 
> > What I would do instead is add:
> > 
> > clear_page_private(struct page *page)
> > {
> > 	ClearPagePrivate(page);
> > 	set_page_private(page, 0);
> > 	put_page(page);
> > }
> > 
> > to include/linux/mm.h, then convert all callers of __clear_page_buffers()
> > to call that instead.
> 
> While I think this is the right direction, I don't like the lack of
> symmetry between set_page_private() and clear_page_private() this
> creates.  i.e. set_page_private() just assigned page->private, while
> clear_page_private clears both a page flag and page->private, and it
> also drops a page reference, too.
> 
> Anyone expecting to use set/clear_page_private as a matched pair (as
> the names suggest they are) is in for a horrible surprise...
> 
> This is a public service message brought to you by the Department
> of We Really Suck At API Design.

Oh, blast.  I hadn't noticed that.  And we're horribly inconsistent
with how we use set_page_private() too -- rb_alloc_aux_page() doesn't
increment the page's refcount, for example.

So, new (pair of) names:

set_fs_page_private()
clear_fs_page_private()

since it really seems like it's only page cache pages which need to
follow the rules about setting PagePrivate and incrementing the refcount.
Also, I think I'd like to see them take/return a void *:

void *set_fs_page_private(struct page *page, void *data)
{
	get_page(page);
	set_page_private(page, (unsigned long)data);
	SetPagePrivate(page);
	return data;
}

void *clear_fs_page_private(struct page *page)
{
	void *data = (void *)page_private(page);

	if (!PagePrivate(page))
		return NULL;
	ClearPagePrivate(page);
	set_page_private(page, 0);
	put_page(page);
	return data;
}

That makes iomap simpler:

 static void
 iomap_page_release(struct page *page)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct iomap_page *iop = clear_fs_page_private(page);

 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_count));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
 	kfree(iop);
 }

