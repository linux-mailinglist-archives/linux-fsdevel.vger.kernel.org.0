Return-Path: <linux-fsdevel+bounces-45059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B848A70F9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 04:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE6F18943BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 03:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221F15E5AE;
	Wed, 26 Mar 2025 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EyyeqoOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8A63CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742960265; cv=none; b=gQpXqEZRD+poS04W4vMUsQRzXios+N4nRckXWmdI8g+u81jC0eMYIYUOZQ/h57wGGFgv/XmsplNJNZciAE3XvpFjvZPiWMwvgMwjWC6/Z4/Uo7Z/Ow0FFAfXedYNH6aaJukXI6CK/TnmTHJAu8i4wOuFTtX/9Y1/lSguM7M3Tm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742960265; c=relaxed/simple;
	bh=d6jdR0tl0fMe/7cXAgiHVB8OL2b58GVY5cSlgz2f5Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJvhRU1n1yTdT2mmEitqNtCkcMZequhD0xQuEwSnQ4+x7va/AjHljs/PsT/iY9dvd0CzMOv29cW1LaxdjC6OqbB6nDl2iPvTRqLB2E9TJjIWVQUGo8UM84uSCUva2Nw4zidiplC9CjQd7g5BJqAb0ITiawRv+QwkdHP1IoDFo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EyyeqoOT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L9gY5XDPpqmKquXY3BqLMX31PuZvhv7/DdoNmhC/YwM=; b=EyyeqoOT/aKCoe22c/C8AZwzBV
	BMOOqQYPO4Q+WikKexayR7wVXQtMhmXZCtlVN4BLeAKXl6BP0ZZhiQdbH+A7kuIrDr8TTZxbf/Jec
	YhKzLQ1ouVvRhh1P3xFkqbqP1wSvAArqmnnTOnTpPHnbWm159TLGM4lIuWNQEnoth4XkAO1cNMe3W
	A6OQG2AXvcuxqS24m7YYKebVyYKhKlAdvos86MSguig2vvJbn3IcVnXBiYAvmkf0iZsX94NTdUerI
	Kp34/RRzR3K8a2LbTz+aDHK4EMPjQwwhqIuEV8pjWIsKHpbHxaF1W+rA9nIomCZTYbsLEXapdrXpS
	9xWH6LPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txHaI-0000000H1Rc-3FJA;
	Wed, 26 Mar 2025 03:37:42 +0000
Date: Wed, 26 Mar 2025 03:37:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
Message-ID: <Z-N2hsKd2NJeNiKN@casper.infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
 <Z9DSym8c9h53Xmr8@casper.infradead.org>
 <Z9Dh4UL7uTm3cQM3@google.com>
 <Z9RR2ubkS9CafUdE@casper.infradead.org>
 <Z9Shx72mSqnQxCh3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Shx72mSqnQxCh3@google.com>

On Fri, Mar 14, 2025 at 09:38:15PM +0000, Jaegeuk Kim wrote:
> On 03/14, Matthew Wilcox wrote:
> > Unfortunately, I thnk I have to abandon this effort.  It's only going
> > to make supporting large folios harder (ie there would then need to be
> > an equivalently disruptive series adding support for large folios).
> > 
> > The fundamental problem is that f2fs has no concept of block size !=
> > PAGE_SIZE.  So if you create a filesystem on a 4kB PAGE_SIZE kernel,
> > you can't mount it on a 16kB PAGE_SIZE kernel.  An example:
> > 
> > int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
> > {
> >         struct f2fs_inode *ri;
> >         ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
> >         ri = F2FS_INODE(page);
> > 
> > so an inode number is an index into the filesystem in PAGE_SIZE units,
> > not in filesystem block size units.  Fixing this is a major effort, and
> > I lack the confidence in my abilities to do it without breaking anything.
> > 
> > As an outline of what needs to happen, I think that rather than passing
> > around so many struct page pointers, we should be passing around either
> > folio + offset, or we should be passing around struct f2fs_inode pointers.
> > My preference is for the latter.  We can always convert back to the
> > folio containing the inode if we need to (eg to mark it dirty) and it
> > adds some typesafety by ensuring that we're passing around pointers that
> > we believe belong to an inode and not, say, a struct page which happens
> > to contain a directory entry.
> > 
> > This is a monster task, I think.  I'm going to have to disable f2fs
> > from testing with split page/folio.  This is going to be a big problem
> > for Android.
> 
> I see. fyi; in Android, I'm thinking to run 16KB page kernel with 16KB format
> natively to keep block_size = PAGE_SIZE. Wasn't large folio to support a set
> of pages while keeping block_size = PAGE_SIZE?

Oh, I think I do see a possible argument for continuing this work.

If we have an f2fs filesystem with a 16kB block size, we can use order-0
folios with a 16kB PAGE_SIZE kernel, and if we want to mount it on a
kernel with a 4kB PAGE_SIZE kernel, then we can use order-2 folios to
do that.

Is that a useful improvement to f2fs?  It's not really the intent of
large folios; it's supposed to be used to support arbitrary order folios.
But we have all the pieces in place such that we could tell the page
cache min-order = max-order = 2.

