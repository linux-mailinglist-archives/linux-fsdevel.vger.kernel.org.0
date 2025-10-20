Return-Path: <linux-fsdevel+bounces-64681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D494BF0E7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B08D3B3403
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1E42065;
	Mon, 20 Oct 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ycvFCmNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5402E92B0;
	Mon, 20 Oct 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960737; cv=none; b=JHizPuAX02qvLElm7YcuUEZaZ8ATrvAZQ1F0OuX34Sz46K2cE8d3U07Kdv+qQHntn8omHrYFwtQGq53H+3D48sgvGfei6iHjOoT4YwM1LZOs6MbeAAc8DlqhEgrbr2AIZgnEd4exGKXUyKPbUGAHbdvu+POi9BAHAo+4vyK3SHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960737; c=relaxed/simple;
	bh=AUGMsd9cKx/M+T+YjVUXOcFPBafZJF+gn1IAU2BN8Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYdMxwB1V+S4F4Ssg+PS+N1HuPufpDYWLmJOs5OsPVQh+k/hi2ES0z+eceYam6c00MviBkTPakrgiGiknRi7eKwYJ0FcKEi51lfanxHgK/aqyg8pPxqKPFFMbsorpTITjHonO2Q4tURtithfEAZn3iQ8+pLicI859aqG1VGYmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ycvFCmNm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=MkweqAAJQplqVKFIiBARnqmdFwuOJtteqmLLYasVklw=; b=ycvFCmNmRu+BgF1ZNr0uRQYdVm
	zZ1VLqnpm90cz3ojZJZwOL/kce6A1db/H98JPaq0YefLH6jOdGS0ETm1E42h8FsHGf71QS9SVVzST
	N8YNOa1RtZUSUv1qXyPvrSx6/QKYvUnjHX06brKu+G2WKljvwMwbxEwgLmEhQULiyt9y9zNqFYxF2
	1y4yv9oR6YPHq1VVzIP57UzEQNaBBwQYQA9mhVH103S+sjhjk53192Dynd0bJ32CBcsDRSgmo1mAj
	CdcfIGXXtvkrI4ofzs4DGRpVkOjOaSoizA/DQY/4FSVRWHyjXStf8iZ9dNMmzT87YQgT0KqOxqu/S
	Y+u3ELCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAoKV-0000000D7CQ-1kGG;
	Mon, 20 Oct 2025 11:45:35 +0000
Date: Mon, 20 Oct 2025 04:45:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <aPYg31lAv8YKxJJJ@infradead.org>
References: <aPYIS5rDfXhNNDHP@infradead.org>
 <acbb5680-ef7d-4908-94f4-b4edb8b3c48e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acbb5680-ef7d-4908-94f4-b4edb8b3c48e@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 08:54:49PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/10/20 20:30, Christoph Hellwig 写道:
> > On Mon, Oct 20, 2025 at 07:49:50PM +1030, Qu Wenruo wrote:
> > > There is a bug report about that direct IO (and even concurrent buffered
> > > IO) can lead to different contents of md-raid.
> > 
> > What concurrent buffered I/O?
> 
> filemap_get_folio(), for address spaces with STABEL_WRITES, there will be a
> folio_wait_stable() call to wait for writeback.
> 
> But since almost no device (except md-raid56) set that flag, if a folio is
> still under writeback, XFS/EXT4 can still modify that folio (since it's not
> locked, just under writeback) for new incoming buffered writes.

All devices with protection information set it.  Now for raid1 without
the bitmap there is no expectation that anything is in sync.  Raid 1
with a bitmap should probably set the flag as well.

> 
> > 
> > > It's exactly the situation we fixed for direct IO in commit 968f19c5b1b7
> > > ("btrfs: always fallback to buffered write if the inode requires
> > > checksum"), however we still leave a hole for nodatasum cases.
> > > 
> > > For nodatasum cases we still reuse the bio from direct IO, making it to
> > > cause the same problem for RAID1*/5/6 profiles, and results
> > > unreliable data contents read from disk, depending on the load balance.
> > > 
> > > Just do not trust any bio from direct IO, and never reuse those bios even
> > > for nodatasum cases. Instead alloc our own bio with newly allocated
> > > pages.
> > > 
> > > For direct read, submit that new bio, and at end io time copy the
> > > contents to the dio bio.
> > > For direct write, copy the contents from the dio bio, then submit the
> > > new one.
> > 
> > This basically reinvents IOCB_DONTCACHE I/O with duplicate code?
> 
> This reminds me the problem that btrfs can not handle DONTCACHE due to its
> async extents...
> 
> I definitely need to address it one day.
> 
> > 
> > > Considering the zero-copy direct IO (and the fact XFS/EXT4 even allows
> > > modifying the page cache when it's still under writeback) can lead to
> > > raid mirror contents mismatch, the 23% performance drop should still be
> > > acceptable, and bcachefs is already doing this bouncing behavior.
> > 
> > XFS (and EXT4 as well, but I've not tested it) wait for I/O to
> > finish before allowing modifications when mapping_stable_writes returns
> > true, i.e., when the block device sets BLK_FEAT_STABLE_WRITES, so that
> > is fine.
> 
> But md-raid1 doesn't set STABLE_WRITES, thus XFS/EXT4 won't wait for write
> to finish.
> 
> Wouldn't that cause two mirrors to differ from each other due to timing
> difference?
> 
> >  Direct I/O is broken, and at least for XFS I have patches
> > to force DONTCACHE instead of DIRECT I/O by default in that case, but
> > allowing for an opt-out for known applications (e.g. file or storage
> > servers).
> > 
> > I'll need to rebase them, but I plan to send them out soon together
> > with other T10 PI enabling patches.  Sorry, juggling a few too many
> > things at the moment.
> > 
> > > But still, such performance drop can be very obvious, and performance
> > > oriented users (who are very happy running various benchmark tools) are
> > > going to notice or even complain.
> > 
> > I've unfortunately seen much bigger performance drops with direct I/O and
> > PI on fast SSDs, but we still should be safe by default.
> > 
> > > Another question is, should we push this behavior to iomap layer so that other
> > > fses can also benefit from it?
> > 
> > The right place is above iomap to pick the buffered I/O path instead.
> 
> But falling back to buffered IO performance is so miserable that wiped out
> almost one or more decades of storage performance improvement.
> 
> Thanks,
> Qu
> 
> > 
> > The real question is if we can finally get a version of pin_user_pages
> > that prevents user modifications entirely.
---end quoted text---

