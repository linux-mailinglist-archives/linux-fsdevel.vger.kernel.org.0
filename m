Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6E3CC39B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jul 2021 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhGQNlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 09:41:20 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:39770 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232974AbhGQNlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 09:41:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Ug2miKJ_1626529099;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ug2miKJ_1626529099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 17 Jul 2021 21:38:20 +0800
Date:   Sat, 17 Jul 2021 21:38:18 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andreas, Christoph, Matthew, and all,

On Fri, Jul 16, 2021 at 05:53:19PM +0200, Andreas Grünbacher wrote:
> Am Fr., 16. Juli 2021 um 17:03 Uhr schrieb Gao Xiang
> <hsiangkao@linux.alibaba.com>:
> > On Fri, Jul 16, 2021 at 03:44:04PM +0100, Matthew Wilcox wrote:
> > > On Fri, Jul 16, 2021 at 09:56:23PM +0800, Gao Xiang wrote:
> > > > Hi Matthew,
> > > >
> > > > On Fri, Jul 16, 2021 at 02:02:29PM +0100, Matthew Wilcox wrote:
> > > > > On Fri, Jul 16, 2021 at 01:07:23PM +0800, Gao Xiang wrote:
> > > > > > This tries to add tail packing inline read to iomap. Different from
> > > > > > the previous approach, it only marks the block range uptodate in the
> > > > > > page it covers.
> > > > >
> > > > > Why?  This path is called under two circumstances: readahead and readpage.
> > > > > In both cases, we're trying to bring the entire page uptodate.  The inline
> > > > > extent is always the tail of the file, so we may as well zero the part of
> > > > > the page past the end of file and mark the entire page uptodate instead
> > > > > and leaving the end of the page !uptodate.
> > > > >
> > > > > I see the case where, eg, we have the first 2048 bytes of the file
> > > > > out-of-inode and then 20 bytes in the inode.  So we'll create the iop
> > > > > for the head of the file, but then we may as well finish the entire
> > > > > PAGE_SIZE chunk as part of this iteration rather than update 2048-3071
> > > > > as being uptodate and leave the 3072-4095 block for a future iteration.
> > > >
> > > > Thanks for your comments. Hmm... If I understand the words above correctly,
> > > > what I'd like to do is to cover the inline extents (blocks) only
> > > > reported by iomap_begin() rather than handling other (maybe)
> > > > logical-not-strictly-relevant areas such as post-EOF (even pages
> > > > will be finally entirely uptodated), I think such zeroed area should
> > > > be handled by from the point of view of the extent itself
> > > >
> > > >          if (iomap_block_needs_zeroing(inode, iomap, pos)) {
> > > >                  zero_user(page, poff, plen);
> > > >                  iomap_set_range_uptodate(page, poff, plen);
> > > >                  goto done;
> > > >          }
> > >
> > > That does work.  But we already mapped the page to write to it, and
> > > we already have to zero to the end of the block.  Why not zero to
> > > the end of the page?  It saves an iteration around the loop, it saves
> > > a mapping of the page, and it saves a call to flush_dcache_page().
> >
> > I completely understand your concern, and that's also (sort of) why I
> > left iomap_read_inline_page() to make the old !pos behavior as before.
> >
> > Anyway, I could update Christoph's patch to behave like what you
> > suggested. Will do later since I'm now taking some rest...
> 
> Looking forward to that for some testing; Christoph's version was
> already looking pretty good.
> 
> This code is a bit brittle, hopefully less so with the recent iop
> fixes on iomap-for-next.
>

Sorry about some late. I've revised a version based on Christoph's
version and Matthew's thought above. I've preliminary checked with
EROFS, if it does make sense, please kindly help check on the gfs2
side as well..

Thanks,
Gao Xiang

From 62f367245492e389711bcebbf7da5adae586299f Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 16 Jul 2021 10:52:48 +0200
Subject: [PATCH] iomap: support tail packing inline read

This tries to add tail packing inline read to iomap, which can support
several inline tail blocks. Similar to the previous approach, it cleans
post-EOF in one iteration.

The write path remains untouched since EROFS cannot be used for testing.
It'd be better to be implemented if upcoming real users care rather than
leave untested dead code around.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/iomap/buffered-io.c | 59 ++++++++++++++++++++++++++++--------------
 fs/iomap/direct-io.c   |  6 +++--
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..95d4d0a76dbc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -207,23 +207,25 @@ struct iomap_readpage_ctx {
 
 static void
 iomap_read_inline_data(struct inode *inode, struct page *page,
-		struct iomap *iomap)
+		struct iomap *iomap, loff_t pos)
 {
-	size_t size = i_size_read(inode);
+	unsigned int size = iomap->length + pos - iomap->offset;
+	unsigned int poff = offset_in_page(pos);
 	void *addr;
 
-	if (PageUptodate(page))
-		return;
-
-	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline source data must be inside a single page */
+	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* handle tail-packing blocks cross the current page into the next */
+	if (size > PAGE_SIZE - poff)
+		size = PAGE_SIZE - poff;
 
 	addr = kmap_atomic(page);
-	memcpy(addr, iomap->inline_data, size);
-	memset(addr + size, 0, PAGE_SIZE - size);
+	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
+	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
 	kunmap_atomic(addr);
-	SetPageUptodate(page);
+	flush_dcache_page(page);
+
+	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -240,24 +242,29 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 {
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
-	struct iomap_page *iop;
+	struct iomap_page *iop = NULL;
 	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
 	sector_t sector;
 
-	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
-		return PAGE_SIZE;
-	}
+	if (iomap->type == IOMAP_INLINE && !pos)
+		WARN_ON_ONCE(to_iomap_page(page) != NULL);
+	else
+		iop = iomap_page_create(inode, page);
 
-	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(inode, page);
+	/* needs to skip some leading uptodated blocks */
 	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
+	if (iomap->type == IOMAP_INLINE) {
+		iomap_read_inline_data(inode, page, iomap, pos);
+		plen = PAGE_SIZE - poff;
+		goto done;
+	}
+
+	/* zero post-eof blocks as the page may be mapped */
 	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
 		zero_user(page, poff, plen);
 		iomap_set_range_uptodate(page, poff, plen);
@@ -589,6 +596,18 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
+static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
+		struct page *page, struct iomap *srcmap)
+{
+	/* needs more work for the tailpacking case, disable for now */
+	if (WARN_ON_ONCE(pos != 0))
+		return -EIO;
+	if (PageUptodate(page))
+		return 0;
+	iomap_read_inline_data(inode, page, srcmap, pos);
+	return 0;
+}
+
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
@@ -618,7 +637,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		status = iomap_write_begin_inline(inode, pos, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..a70a8632df22 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -380,7 +380,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 	struct iov_iter *iter = dio->submit.iter;
 	size_t copied;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline data must be inside a single page */
+	BUG_ON(length > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = inode->i_size;
@@ -394,7 +395,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 			mark_inode_dirty(inode);
 		}
 	} else {
-		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
+		copied = copy_to_iter(iomap->inline_data + pos - iomap->offset,
+				length, iter);
 	}
 	dio->size += copied;
 	return copied;
-- 
2.24.4

 
