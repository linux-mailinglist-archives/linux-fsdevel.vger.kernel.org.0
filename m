Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4AB277819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 19:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgIXR4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 13:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgIXR4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:56:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494B2C0613CE;
        Thu, 24 Sep 2020 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rXnTpPeLayDi5vbT9auZkwpsP9S5IsSrD7JgND0hZbE=; b=MykyBlX4OcmCmUSUItDZ9A3Zks
        b33wQ4EGRF7pb3/K3B0a7S08HCttrNQLGPdUcqgqudDEqNVtgxaqrdUbt5MhRzo6xwocX1R4ViSBf
        F8Xd+Jidpp+wYaxhkPDwX2VtIkX/4sYfSzvG1k96JCf/gjQ2hma6oAnN2wvn0OreXZLNcwHbO/XLj
        JXJ8VEdMzWafodtejmAYjmwREA/+fO4YBgGbZ8/rgLC/GsHyqIHpkugb6MyjB4+4nQr5sU5E9OO0V
        szA27MjmiHO1vE3ZEtyTntQrApwOXCcYvVsAvAUVCqdZz7MvtGJ7wuI7OvIvEp9yFBPU/uxAkMKwp
        6d3YVF1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLVTy-0001cQ-JO; Thu, 24 Sep 2020 17:56:39 +0000
Date:   Thu, 24 Sep 2020 18:56:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200924175638.GA32101@casper.infradead.org>
References: <20200924125608.31231-1-willy@infradead.org>
 <20200924131235.GA2603692@bfoster>
 <20200924135900.GV32101@casper.infradead.org>
 <20200924151259.GB2603692@bfoster>
 <20200924152211.GX32101@casper.infradead.org>
 <20200924172653.GC2603692@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924172653.GC2603692@bfoster>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:26:53PM -0400, Brian Foster wrote:
> On Thu, Sep 24, 2020 at 04:22:11PM +0100, Matthew Wilcox wrote:
> > On Thu, Sep 24, 2020 at 11:12:59AM -0400, Brian Foster wrote:
> > > On Thu, Sep 24, 2020 at 02:59:00PM +0100, Matthew Wilcox wrote:
> > > > On Thu, Sep 24, 2020 at 09:12:35AM -0400, Brian Foster wrote:
> > > > > On Thu, Sep 24, 2020 at 01:56:08PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > > > For filesystems with block size < page size, we need to set all the
> > > > > > per-block uptodate bits if the page was already uptodate at the time
> > > > > > we create the per-block metadata.  This can happen if the page is
> > > > > > invalidated (eg by a write to drop_caches) but ultimately not removed
> > > > > > from the page cache.
> > > > > > 
> > > > > > This is a data corruption issue as page writeback skips blocks which
> > > > > > are marked !uptodate.
> > > > > 
> > > > > Thanks. Based on my testing of clearing PageUptodate here I suspect this
> > > > > will similarly prevent the problem, but I'll give this a test
> > > > > nonetheless. 
> > > > > 
> > > > > I am a little curious why we'd prefer to fill the iop here rather than
> > > > > just clear the page state if the iop data has been released. If the page
> > > > > is partially uptodate, then we end up having to re-read the page
> > > > > anyways, right? OTOH, I guess this behavior is more consistent with page
> > > > > size == block size filesystems where iop wouldn't exist and we just go
> > > > > by page state, so perhaps that makes more sense.
> > > > 
> > > > Well, it's _true_ ... the PageUptodate bit means that every byte in this
> > > > page is at least as new as every byte on storage.  There's no need to
> > > > re-read it, which is what we'll do if we ClearPageUptodate.
> > > 
> > > Yes, of course. I'm just noting the inconsistent behavior between a full
> > > and partially uptodate page.
> > 
> > Heh, well, we have no way of knowing.  We literally just threw away
> > the information about which blocks are uptodate.  So the best we can
> > do is work with the single bit we have.  We do know that there are no
> > dirty blocks left on the page at this point (... maybe we should add a
> > VM_BUG_ON(!PageUptodate && PageDirty)).
> > 
> 
> Right..
> 
> > Something we could do is summarise the block uptodate information in
> > the 32/64 bits of page_private without setting PagePrivate.  That would
> > cause us to still allocate an iop so we can track reads/writes, but we
> > might be able to avoid a few reads.
> > 
> > But I don't think it's worth it.  Partially uptodate pages are not what
> > we should be optimising for; we should try to get & keep pages uptodate.
> > After all, it's a page cache ;-)
> > 
> 
> Fair enough. I was thinking about whether we could ensure the page is
> released if releasepage() effectively invalidated the page content (or
> avoid the release if we know the mapping won't be removed), but that
> appears to be nontrivial given the refcount interdependencies between
> page private and removing the mapping. I.e., the private data can hold a
> reference on the page and remove_mapping() wants to assume that the
> caller and page cache hold the last references on the page.

We could fix that -- remove_mapping() could take into account
page_has_private() in its call to page_ref_freeze() -- ie:

-       refcount = 1 + compound_nr(page);
+	retcount = 1 + compound_nr(page) + page_has_private(page);

like some other parts of the VM do.  And then the filesystem could
detach_page_private() in its aops->freepage() (which XFS aops don't
currently use).

That change might be a little larger than would be appreciated for a
data corruption fix going back two years.  And there's already other
reasons for wanting to be able to create an iop for an Uptodate page
(ie the THP patchset).
