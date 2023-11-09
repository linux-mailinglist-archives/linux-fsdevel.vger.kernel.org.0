Return-Path: <linux-fsdevel+bounces-2509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0B7E6B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47A3B20C0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2B1DFEE;
	Thu,  9 Nov 2023 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z1EX1N63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A11DDDB
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:37:22 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299B1AE;
	Thu,  9 Nov 2023 05:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BQ2AY+uN3ZnIIjmw03kBHjiQnc8yyLzdD/dUaYnIoVE=; b=Z1EX1N63OShEf9aAAHitjt46Pw
	IkDlYoGwvvN5tJbtVLOhiYTtmBEH0MMTuKtfecoHcLzhA2FK/NeP5FVC8vGujS1s1f5oLi+/6HuQR
	f0zeFsdS9QhWJ8R5xWEgRGrlwRmJN9y6phQaYGygrtS9pDIQi799UD9X2I4uXIO9CA2EE5qTIIUB4
	x/vuQWRVTNM5uIcFreq9sKd7tbrAb2pB457SY69aLwmMOMD+NPM/yY9IXRkmTORrb+H3Pz2HPcDOY
	jmc0QF+Fw26W2JTe1YK9X0mRbwEzwQxTUwiX5PdAPWDk1jIBLzKZOxX0wHhaUZGW77DdYxFjC5sla
	ZrlK63Uw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r15Dj-007WsM-T3; Thu, 09 Nov 2023 13:37:19 +0000
Date: Thu, 9 Nov 2023 13:37:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/35] nilfs2: Convert nilfs_page_mkwrite() to use a folio
Message-ID: <ZUzgjxJoKYP9KIx0@casper.infradead.org>
References: <20231106173903.1734114-1-willy@infradead.org>
 <20231106173903.1734114-12-willy@infradead.org>
 <CAKFNMomYhk2D6F9=mee4=H_QtvrfWYYSsiXrKjCms8pz61xhAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKFNMomYhk2D6F9=mee4=H_QtvrfWYYSsiXrKjCms8pz61xhAQ@mail.gmail.com>

On Thu, Nov 09, 2023 at 10:11:27PM +0900, Ryusuke Konishi wrote:
> On Tue, Nov 7, 2023 at 2:39 AM Matthew Wilcox (Oracle) wrote:
> >
> > Using the new folio APIs saves seven hidden calls to compound_head().
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/nilfs2/file.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> I'm still in the middle of reviewing this series, but I had one
> question in a relevant part outside of this patch, so I'd like to ask
> you a question.
> 
> In block_page_mkwrite() that nilfs_page_mkwrite() calls,
> __block_write_begin_int() was called with the range using
> folio_size(), as shown below:
> 
>         end = folio_size(folio);
>         /* folio is wholly or partially inside EOF */
>         if (folio_pos(folio) + end > size)
>                 end = size - folio_pos(folio);
> 
>         ret = __block_write_begin_int(folio, 0, end, get_block, NULL);
>         ...
> 
> On the other hand, __block_write_begin_int() takes a folio as an
> argument, but uses a PAGE_SIZE-based remainder calculation and BUG_ON
> checks:
> 
> int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>                 get_block_t *get_block, const struct iomap *iomap)
> {
>         unsigned from = pos & (PAGE_SIZE - 1);
>         unsigned to = from + len;
>         ...
>         BUG_ON(from > PAGE_SIZE);
>         BUG_ON(to > PAGE_SIZE);
>         ...
> 
> So, it looks like this function causes a kernel BUG if it's called
> from block_page_mkwrite() and folio_size() exceeds PAGE_SIZE.
> 
> Is this constraint intentional or temporary in folio conversions ?

Good catch!

At the time I converted __block_write_begin_int() to take a folio
(over two years ago), the plan was that filesystems would convert to
the iomap infrastructure in order to take advantage of large folios.

The needs of the Large Block Size project mean that may not happen;
filesystems want to add support for, eg, 16kB hardware block sizes
without converting to iomap.  So we shoud fix up
__block_write_begin_int().  I'll submit a patch along these lines:

diff --git a/fs/buffer.c b/fs/buffer.c
index cd114110b27f..24a5694f9b41 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2080,25 +2080,24 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block, const struct iomap *iomap)
 {
-	unsigned from = pos & (PAGE_SIZE - 1);
-	unsigned to = from + len;
+	size_t from = offset_in_folio(folio, pos);
+	size_t to = from + len;
 	struct inode *inode = folio->mapping->host;
-	unsigned block_start, block_end;
+	size_t block_start, block_end;
 	sector_t block;
 	int err = 0;
 	unsigned blocksize, bbits;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
 
 	BUG_ON(!folio_test_locked(folio));
-	BUG_ON(from > PAGE_SIZE);
-	BUG_ON(to > PAGE_SIZE);
+	BUG_ON(to > folio_size(folio));
 	BUG_ON(from > to);
 
 	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
 
-	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
+	block = ((loff_t)folio->index * PAGE_SIZE) >> bbits;
 
 	for(bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start=block_end, bh = bh->b_this_page) {

