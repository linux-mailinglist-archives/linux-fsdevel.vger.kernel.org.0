Return-Path: <linux-fsdevel+bounces-36920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB79EAFED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C2D1643AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D12080D2;
	Tue, 10 Dec 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MLfRIkxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E478F24;
	Tue, 10 Dec 2024 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830293; cv=none; b=rCPEFWpAfegCNZuyF17Cqdx9iHmK/akdVCZjSj8JeP0l//zT2jyXiS0yeDjnWGx3LXReURTj/O8sDSrX0gIfVcCxcM2vUoWN4QlkPCbLyhTjFd1cUY3mypcV8T3XML/3WuIDY9QIa5K/vuVIrOoWXOeiDf0wAU5t74ZU1LvMJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830293; c=relaxed/simple;
	bh=GSUye358gWFOvZ1gSTeQH/vASNgwPRjWO01L50+BkmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd0V59xKSTVHCKeendZ9sbtaULR+0DrLSQVPE9sI7NAqOXq2ZNEpJP7ua7DRuNe03ud+HN7jLo9LiF2ryPMgaB2eJ7alsniGlSqcCGP1gAROxA9XHBbDZbuJRumTZSkja8i+NSZBqqu19rT6RchL55DpIR+5N7pv6Fd0MZ63Las=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MLfRIkxm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Feb0jQOujGmxXR8PPkTXLVIfG9wGJNk4iUPyw0CUCJk=; b=MLfRIkxmC678SS76Jwg2qowzDG
	MVcEEk5oKwIV+Zo3/Xi1v8CIsS0OSNiWMxO90sJsOhj/PgH+nFLVcDPHx8BkD7a0X+BZRBPhFf/kh
	6wTmJzYom4GQC1UYADZmKHT42oXD+zVpiqC8EJpt5yKqGRZDNlBp625Hlt8Vupv7bY8GJUpVz2zvt
	OTXh8nxAvd2MzmIrCslZ6eyW3G3l/EMwZrPf+6+Ocq0FkkEXOHAGt0WynxEI1YebHD4wBFX6NooS0
	iYR9kFFGZ7ayxwI8ctp0my/fftrO6xL+nT3YZfckqJZhqNKoRNJ2xawBzdGrPiydCi0g/wXw2crLi
	6oTukqmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKySh-0000000BJy9-0FwJ;
	Tue, 10 Dec 2024 11:31:31 +0000
Date: Tue, 10 Dec 2024 03:31:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCH 11/12] mm/filemap: make buffered writes work with
 RWF_UNCACHED
Message-ID: <Z1gmk_X9RrG7O0Fi@infradead.org>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-13-axboe@kernel.dk>
 <20241206171740.GD7820@frogsfrogsfrogs>
 <39033717-2f6b-47ca-8288-3e9375d957cb@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39033717-2f6b-47ca-8288-3e9375d957cb@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 06, 2024 at 11:22:55AM -0700, Jens Axboe wrote:
> > Honestly, I'm not a fan of foliop_uncached or foliop_is_uncached.
> 
> It definitely is what I would elegantly refer to as somewhat of a
> hack... But it's not _that_ bad imho.

It's pretty horrible actually.

> > I think these two macros are only used for ext4 (or really, !iomap)
> > support, right?  And that's only to avoid messing with ->write_begin?
> 
> Indeed, ideally we'd change ->write_begin() instead. And that probably
> should still be done, I just did not want to deal with that nightmare in
> terms of managing the patchset. And honestly I think it'd be OK to defer
> that part until ->write_begin() needs to be changed for other reasons,
> it's a lot of churn just for this particular thing and dealing with the
> magic pointer value (at least to me) is liveable.

->write_begin() really should just go away, it is a horrible interface.
Note that in that past it actually had a flags argument, but that got
killed a while ago.

> > What if you dropped ext4 support instead? :D
> 
> Hah, yes obviously that'd be a solution, then I'd need to drop btrfs as
> well. And I would kind of prefer not doing that ;-)

Btrfs doesn't need it.  In fact the code would be cleaner and do less
work with out, see the patch below.  And for ext4 there already is an
iomap conversion patch series on the list that just needs more review,
so skipping it here and growing the uncached support through that sounds
sensible.

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 444bee219b4e..db3a3c7ecf77 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -894,20 +894,17 @@ static gfp_t get_prepare_gfp_flags(struct inode *inode, bool nowait)
  */
 static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_ret,
 				      loff_t pos, size_t write_bytes,
-				      bool force_uptodate, bool nowait)
+				      bool force_uptodate, fgf_t fgp_flags)
 {
 	unsigned long index = pos >> PAGE_SHIFT;
-	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
-	fgf_t fgp_flags = (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN);
+	gfp_t mask = get_prepare_gfp_flags(inode, fgp_flags & FGP_NOWAIT);
 	struct folio *folio;
 	int ret = 0;
 
-	if (foliop_is_uncached(folio_ret))
-		fgp_flags |= FGP_UNCACHED;
 again:
 	folio = __filemap_get_folio(inode->i_mapping, index, fgp_flags, mask);
 	if (IS_ERR(folio)) {
-		if (nowait)
+		if (fgp_flags & FGP_NOWAIT)
 			ret = -EAGAIN;
 		else
 			ret = PTR_ERR(folio);
@@ -925,7 +922,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 	if (ret) {
 		/* The folio is already unlocked. */
 		folio_put(folio);
-		if (!nowait && ret == -EAGAIN) {
+		if (!(fgp_flags & FGP_NOWAIT) && ret == -EAGAIN) {
 			ret = 0;
 			goto again;
 		}
@@ -1135,9 +1132,15 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
 	bool only_release_metadata = false;
+	fgf_t fgp_flags = FGP_WRITEBEGIN;
 
-	if (nowait)
+	if (nowait) {
 		ilock_flags |= BTRFS_ILOCK_TRY;
+		fgp_flags |= FGP_NOWAIT;
+	}
+
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		fgp_flags |= FGP_UNCACHED;
 
 	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
 	if (ret < 0)
@@ -1232,11 +1235,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		if (iocb->ki_flags & IOCB_UNCACHED)
-			folio = foliop_uncached;
-
 		ret = prepare_one_folio(inode, &folio, pos, write_bytes,
-					force_page_uptodate, false);
+					force_page_uptodate, fgp_flags);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);

