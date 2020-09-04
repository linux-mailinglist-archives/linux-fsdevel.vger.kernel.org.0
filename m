Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DE925CFDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 05:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgIDDhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 23:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgIDDhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:37:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77375C061244;
        Thu,  3 Sep 2020 20:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MlDL+jj1BjkOBZ5IVs63oT6JunXcTHCVT3fwzED6qgE=; b=Xm7dX6HOdM1ZcF6vj8L3Zs+L13
        0qweHQUoX5UXahkix1MNiHbfgTTQdI016/smaFmFmOcHjYEOHGry4h09fYA4oTqxcAk7iParpcCHR
        a6FsDjbquO0y9lcvtjy5IXoFqtRgidppIQsq38e3ew55Uc/6HiUTFMkEOKsjQbbcS0T5rTY9BnCZb
        UKV01wz2/iQjXFYRZ3TIVyMAENUtRUb5RrxqwBQWSr9MHtpofxbjmmxddSrs+Q32o5fc4WFxMJ+X8
        cyvIqaygpC+H+xivFnGIOKmLbbXvqgzwtDlPGj18pQDiXXUUXFAVpmkJijIksO0jYGcRcDRCCZHAv
        jPO4Xx5A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE2XU-0001Jc-Ut; Fri, 04 Sep 2020 03:37:24 +0000
Date:   Fri, 4 Sep 2020 04:37:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     darrick.wong@oracle.com, david@fromorbit.com, yukuai3@huawei.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: Splitting an iomap_page
Message-ID: <20200904033724.GH14765@casper.infradead.org>
References: <20200821144021.GV17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821144021.GV17456@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 03:40:21PM +0100, Matthew Wilcox wrote:
> Operations like holepunch or truncate call into
> truncate_inode_pages_range() which just remove THPs which are
> entirely within the punched range, but pages which contain one or both
> ends of the range need to be split.
> 
> What I have right now, and works, calls do_invalidatepage() from
> truncate_inode_pages_range().  The iomap implementation just calls
> iomap_page_release().  We have the page locked, and we've waited for
> writeback to finish, so there is no I/O outstanding against the page.
> We may then get into one of the writepage methods without an iomap being
> allocated, so we have to allocate it.  Patches here:
> 
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/167f81e880ef00d83ab7db50d56ed85bfbae2601
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/82fe90cde95420c3cf155b54ed66c74d5fb6ffc5
> 
> If the page is Uptodate, this works great.  But if it's not, then we're
> going to unnecessarily re-read data from storage -- indeed, we may as
> well just dump the entire page if it's !Uptodate.  Of course, right now
> the only way to get THPs is through readahead and that's going to always
> read the entire page, so we're never going to see a !Uptodate THP.  But
> in the future, maybe we shall?  I wouldn't like to rely on that without
> pasting some big warnings for anyone who tries to change it.
[first three bad solutions snipped]
> Alternative 4: Don't support partially-uptodate THPs.  We declare (and
> enforce with strategic assertions) that all THPs must always be Uptodate
> (or Error) once unlocked.  If your workload benefits from using THPs,
> you want to do big I/Os anyway, so these "write 512 bytes at a time
> using O_SYNC" workloads aren't going to use THPs.

This was the most popular alternative amongst those who cast a ballot.
Here's my response.  I'd really like to be able to callback from
split_huge_page() to the filesystem through ->is_partially_uptodate
in order to set each of the pages to uptodate (if indeed they are).
Unfortunately, we just disposed of the per-page data right before we
called split_huge_page(), so that doesn't work.

This solution allows PageError pages to stay in the cache (because
I/O completions run in contexts where we don't want to call
split_huge_page()).  The only way (I believe) to get a !Uptodate page
dirty is to perform a write to the page.  The patch below will split
the page in this case.  It also splits the page in the case where we
call ->readpage to attempt to bring the page uptodate (from, eg, the
filemap read path, or the pagefault path).

We lose the uptodate bits when we split the page, so there may be an
extra read.  That's not great.  But we do look up whether the current
subpage we're looking at is entirely uptodate, and if it is, we set the
page uptodate after it's split.

Kirill, do I have the handling of split_huge_page() failure correct?
It seems reasonable to me -- unlock the page and drop the reference,
hoping that somebody else will not have a reference to the page by the
next time we try to split it.  Or they will split it for us.  There's a
livelock opportunity here, but I'm not sure it's worse than the one in
a holepunch scenario.

This is against my current head of the THP patchset, so you'll see some
earlier bad ideas being deleted (like using thp_size() in iomap_readpage()
and the VM_WARN_ON_ONCE(!PageUptodate) in iomap_invalidate())

This is all basically untested.  I have the xfstests suite running now,
but it never hit the VM_WARN_ON_ONCE in iomap_invalidate() so it's
probably not hitting any of this code.  Anybody want to write an
xfstest for me with unreliable storage for data, reliable storage
for metadata and runs fsx like generic/127 does?

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 156cbed1cd2c..03f477f785fe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -336,6 +336,39 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	return pos - orig_pos + plen;
 }
 
+static bool iomap_range_uptodate(struct inode *inode, struct page *page,
+		size_t start, size_t len)
+{
+	struct iomap_page *iop = to_iomap_page(page);
+	size_t i, first, last;
+
+	/* First and last blocks in range within page */
+	first = start >> inode->i_blkbits;
+	last = (start + len - 1) >> inode->i_blkbits;
+
+	if (!iop)
+		return false;
+
+	for (i = first; i <= last; i++)
+		if (!test_bit(i, iop->uptodate))
+			return false;
+	return true;
+}
+
+static bool iomap_split_page(struct inode *inode, struct page *page)
+{
+	struct page *head = thp_head(page);
+	bool uptodate = iomap_range_uptodate(inode, head,
+				(page - head) * PAGE_SIZE, PAGE_SIZE);
+
+	iomap_page_release(head);
+	if (split_huge_page(page) < 0)
+		return false;
+	if (uptodate)
+		SetPageUptodate(page);
+	return true;
+}
+
 int
 iomap_readpage(struct page *page, const struct iomap_ops *ops)
 {
@@ -344,11 +377,21 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	unsigned poff;
 	loff_t ret;
 
-	trace_iomap_readpage(page->mapping->host, 1);
+	if (PageTransCompound(page)) {
+		/*
+		 * The page wasn't exactly truncated, but we want to drop
+		 * our refcount so somebody else might be able to split it.
+		 */
+		if (!iomap_split_page(inode, page))
+			return AOP_TRUNCATED_PAGE;
+		if (PageUptodate(page))
+			return 0;
+	}
+	trace_iomap_readpage(inode, 1);
 
-	for (poff = 0; poff < thp_size(page); poff += ret) {
+	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
-				thp_size(page) - poff, 0, ops, &ctx,
+				PAGE_SIZE - poff, 0, ops, &ctx,
 				iomap_readpage_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
@@ -458,26 +501,15 @@ int
 iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count)
 {
-	struct iomap_page *iop = to_iomap_page(page);
-	struct inode *inode = page->mapping->host;
-	unsigned len, first, last;
-	unsigned i;
-
-	/* Limit range to one page */
-	len = min_t(unsigned, thp_size(page) - from, count);
+	struct page *head = thp_head(page);
+	size_t len;
 
-	/* First and last blocks in range within page */
-	first = from >> inode->i_blkbits;
-	last = (from + len - 1) >> inode->i_blkbits;
+	/* 'from' is relative to page, but the bitmap is relative to head */
+	from += (page - head) * PAGE_SIZE;
+	/* Limit range to this page */
+	len = min(thp_size(head) - from, count);
 
-	if (iop) {
-		for (i = first; i <= last; i++)
-			if (!test_bit(i, iop->uptodate))
-				return 0;
-		return 1;
-	}
-
-	return 0;
+	return iomap_range_uptodate(head->mapping->host, head, from, len);
 }
 EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 
@@ -517,7 +549,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 
 	/* Punching a hole in a THP requires releasing the iop */
 	if (PageTransHuge(page)) {
-		VM_WARN_ON_ONCE(!PageUptodate(page));
+		VM_BUG_ON_PAGE(PageDirty(page), page);
 		iomap_page_release(page);
 	}
 }
@@ -645,12 +677,20 @@ static ssize_t iomap_write_begin(struct inode *inode, loff_t pos, loff_t len,
 			return status;
 	}
 
+retry:
 	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
 			AOP_FLAG_NOFS);
 	if (!page) {
 		status = -ENOMEM;
 		goto out_no_page;
 	}
+	if (PageTransCompound(page) && !PageUptodate(page)) {
+		if (!iomap_split_page(inode, page)) {
+			unlock_page(page);
+			put_page(page);
+			goto retry;
+		}
+	}
 	page = thp_head(page);
 	offset = offset_in_thp(page, pos);
 	if (len > thp_size(page) - offset)
