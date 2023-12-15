Return-Path: <linux-fsdevel+bounces-6203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E88814EA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 18:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482651C2434F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C277A4174D;
	Fri, 15 Dec 2023 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vs1vPU/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509184174B
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4YCQvMG0eUDtwuTkaL0LOw4GWtORmbNlyvdqILRjo7o=; b=Vs1vPU/ZcIfze+EpeY7pxDcBMi
	6z0wR8lP9q+vAtp+byH/8J22u08TfRZJsB1T5B04Yq67xW1ylH5Mhl0WILVhOEwIxEnpXUrBOBdmU
	jVbLox/LBLqDOdgVmR56ziuWiee9E/A44i7PyGxsdzgCRt+KtZ7n8h/q8l8lEyzy9Fh/Sw34iOWVc
	86yWpuX24nQZ5ZCo6p5Y2obLnf50hZiIv4cpl6rz1TgQP6j4P4FQ0huvJhaB+kZrIpVlCcKRvoCup
	yrNIuQvHbRstSf9ySGh5tNvtEch/zKeeAhHso+PjiARywU6rjRDQL1HvRyxc890NuwZK5/Cx9JJCY
	2QijaK8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEBs8-001sxi-Dt; Fri, 15 Dec 2023 17:21:12 +0000
Date: Fri, 15 Dec 2023 17:21:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: Why does mpage_writepage() not handle locked buffers?
Message-ID: <ZXyLCJL1o+DFbHh4@casper.infradead.org>
References: <ZXvnmfXG4xN8BQxI@casper.infradead.org>
 <ZXwvU2CXEeqxSDgA@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXwvU2CXEeqxSDgA@infradead.org>

On Fri, Dec 15, 2023 at 02:49:55AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 15, 2023 at 05:43:53AM +0000, Matthew Wilcox wrote:
> > block_write_full_page() handles this fine, so why isn't this
> > 
> > 	if (buffer_locked(bh))
> > 		goto confused;
> > 
> > Is the thought that we hold the folio locked, therefore no buffers
> > should be locked at this time?  I don't know the rules.
> 
> That would be my guess.  For writeback on the fs mapping no one
> else should ever have locked the buffer.  For the bdev mapping
> buffer locking isn't completely controlled by the bdevfs, but also
> by any mounted fs using the buffer cache.  So from my POV your
> above change should be ok, but it'll need a big fat comment so
> that the next person seeing it in 20 years isn't as confused as
> you are now :)

Thanks!  Now I'm thinking that it's not OK to call mpage_writepages().
__block_write_full_folio() takes the buffer lock and holds it across the
I/O (it seems that we never split the buffer lock into buffer writeback
like we did the page lock?)  So filesystems may have an expectation that
locking the buffer synchronises with writeback.  Perhaps it's safest to
just call block_write_full_page() in a loop for blockdev?

I wrote up this before realising that I'd misread the code; adding it
here for posterity.

For filesystems, we know that the filesystem will not lock the buffer
since the writeback path holds the folio locked at this point.  For block
devices, the filesystem mounted on it may lock the buffer without locking
the folio first (observed with both ext2 and ext4).  If we find the
buffer locked, just fall back to block_write_full_page() which handles
potentially locked buffers correctly.  It's fine if we win the race and
the filesystem locks the buffer after this point; block_write_full_page()
doesn't hold the buffer locked across the I/O, so the filesystem has no
expectations that locking the buffer will wait for data writeback.

