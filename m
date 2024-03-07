Return-Path: <linux-fsdevel+bounces-13912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A5F875601
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F34C281AA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B5D1332AA;
	Thu,  7 Mar 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="diPaEMio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3212FB3E;
	Thu,  7 Mar 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835593; cv=none; b=Iys50yLIHiDq6jEVqMjvrhEn+Sm4Oam+ypRIooRS9fjc3DkDJab3jyGCbKsbPuJj1n8dAeu+UrH7c1UgFD4Xr4LjGEcvMgWey2iEqFmke1RPjpN1OafKg9JSjw8IUPR6O5No3ZTLPKyexxJ6Mz813U9pYp1lpg2dYa8fBXGuqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835593; c=relaxed/simple;
	bh=WA5Rxzhhx8a7zAo+/YHstenX60EqTAE3spGTukshUXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYSJ8bDElbjaWwOtho9YqNy5oBhUlJaGAIWwKk8doAtCNmk+BxhllJfZM/xdK8KKm6B7uW24LIidB6bkFPg7Rz8AVbRrQ8vinPa4TEXCM2Wi+y8C4Ph1UCm7fTHYPtXuFs2pAUrR8VupqUDfeyM7Kod+NXoypYYwVoDstJ5R7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=diPaEMio; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sQiGN4jIqTJ8/H2bJBWpCXvVI8NYM1BBTxMzEXi08HE=; b=diPaEMio9VQr0WFLWrPAabWE0k
	gH39iV++eI1NqopjmAeiOHHmwCqOaF8yIEWUvf5QgP7S/qzDUa0APY3OGW1AILP9HYy6DORCZe+MJ
	4ryNKGzxTDeR29DHTDmrxuoTxbByWbaXU79bauI0uYXzcBDvIYTAViY3kuGB4th+gjnvyRjL8pUXO
	ySN3Ls1sNwA5Yw5jIuatxSRo1sdITYi2iSLU+ex6O2lIwTYW8IYoERzZWW2/evXgrE7eNQ9G7+9QN
	vg/2tfUvjjiC31c77VGc24KKTG57qSx2BUHa52669RThzEftKE6bNjehdHY+O59UQc3Xpo+6aJx5O
	7IuG5YfA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riILL-00000009gfM-0K7j;
	Thu, 07 Mar 2024 18:19:47 +0000
Date: Thu, 7 Mar 2024 18:19:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Yin, Fengwei" <fengwei.yin@intel.com>, Yujie Liu <yujie.liu@intel.com>,
	Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Guo Xuenan <guoxuenan@huawei.com>, linux-fsdevel@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com
Subject: Re: [linus:master] [readahead] ab4443fe3c: vm-scalability.throughput
 -21.4% regression
Message-ID: <ZeoFQnVYLLBLNL6J@casper.infradead.org>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
 <20240222115032.u5h2phfxpn77lu5a@quack3>
 <20240222183756.td7avnk2srg4tydu@quack3>
 <ZeVVN75kh9Ey4M4G@yujie-X299>
 <dee823ca-7100-4289-8670-95047463c09d@intel.com>
 <20240307092308.u54fjngivmx23ty3@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307092308.u54fjngivmx23ty3@quack3>

On Thu, Mar 07, 2024 at 10:23:08AM +0100, Jan Kara wrote:
> Thanks for testing! This is an interesting result and certainly unexpected
> for me. The readahead code allocates naturally aligned pages so based on
> the distribution of allocations it seems that before commit ab4443fe3ca6
> readahead window was at least 32 pages (128KB) aligned and so we allocated
> order 5 pages. After the commit, the readahead window somehow ended up only
> aligned to 20 modulo 32. To follow natural alignment and fill 128KB
> readahead window we allocated order 2 page (got us to offset 24 modulo 32),
> then order 3 page (got us to offset 0 modulo 32), order 4 page (larger
> would not fit in 128KB readahead window now), and order 2 page to finish
> filling the readahead window.
> 
> Now I'm not 100% sure why the readahead window alignment changed with
> different rounding when placing readahead mark - probably that's some
> artifact when readahead window is tiny in the beginning before we scale it
> up (I'll verify by tracing whether everything ends up looking correctly
> with the current code). So I don't expect this is a problem in ab4443fe3ca6
> as such but it exposes the issue that readahead page insertion code should
> perhaps strive to achieve better readahead window alignment with logical
> file offset even at the cost of occasionally performing somewhat shorter
> readahead. I'll look into this once I dig out of the huge heap of email
> after vacation...

I was surprised by what you said here, so I went and re-read the code
and it doesn't work the way I thought it did.  So I had a good long think
about how it _should_ work, and I looked for some more corner conditions,
and this is what I came up with.

The first thing I've done is separate out the two limits.  The EOF is
a hard limit; we will not allocate pages beyond EOF.  The ra->size is
a soft limit; we will allocate pages beyond ra->size, but not too far.

The second thing I noticed is that index + ra_size could wrap.  So add
a check for that, and set it to ULONG_MAX.  index + ra_size - async_size
could also wrap, but this is harmless.  We certainly don't want to kick
off any more readahead in this circumstance, so leaving 'mark' outside
the range [index..ULONG_MAX] is just fine.

The third thing is that we could allocate a folio which contains a page
at ULONG_MAX.  We don't really want that in the page cache; it makes
filesystems more complicated if they have to check for that, and we
don't allow an order-0 folio at ULONG_MAX, so there's no need for it.
This _should_ already be prohibited by the "Don't allocate pages past EOF"
check, but let's explicitly prohibit it.

Compile tested only.

diff --git a/mm/readahead.c b/mm/readahead.c
index 130c0e7df99f..742e1f39035b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -488,7 +488,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 {
 	struct address_space *mapping = ractl->mapping;
 	pgoff_t index = readahead_index(ractl);
-	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
+	pgoff_t last = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
+	pgoff_t limit = index + ra->size;
 	pgoff_t mark = index + ra->size - ra->async_size;
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
@@ -496,23 +497,26 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	if (!mapping_large_folio_support(mapping) || ra->size < 4)
 		goto fallback;
 
-	limit = min(limit, index + ra->size - 1);
-
 	if (new_order < MAX_PAGECACHE_ORDER) {
 		new_order += 2;
 		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
 		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 	}
 
+	if (limit < index)
+		limit = ULONG_MAX;
 	filemap_invalidate_lock_shared(mapping);
-	while (index <= limit) {
+	while (index < limit) {
 		unsigned int order = new_order;
 
 		/* Align with smaller pages if needed */
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
+		/* Avoid wrap */
+		if (index + (1UL << order) == 0)
+			order--;
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit)
+		while (index + (1UL << order) - 1 > last)
 			order--;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)

