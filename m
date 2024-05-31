Return-Path: <linux-fsdevel+bounces-20620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895258D6281
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0031C234FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE4158DC6;
	Fri, 31 May 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3YxeQ19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B1158A14;
	Fri, 31 May 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161087; cv=none; b=VqOou36dHPbiO7QLdhLxHvYXRo9FDqSG+1v4scSX/cTDVf0yf04AdmyNCiXdI0LEX20JmmLeCmj62kSphmbZLFL6N92Y9jWjC42H3hFs96xpb1yjyrtW2I5puR8Qf+pNM3u/NJvGR2OxzskyK90bfA24zovGkBn++qai+OGX68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161087; c=relaxed/simple;
	bh=dbVpcj6lEF7ZMOUwEixLA9Qbf6Mjg1Vgndp9rKsWPHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7OTjbccyJdanPLYEyezdOk0R3LTiZcLpkXWGCO7X2Y9ZzS3lK1FdH3tV9q0G6V/p8HwQtE3UZe7VJkvYRY1Aws8KTDPK+IcgKxfsPfRqVHJwrEqVKvswXym0MVXNQlXbc7f4kzE8/1HqmPiaY9vWrMYjgRNHg9Q7A5ArgXHcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f3YxeQ19; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B0njvbhUXTgT/K1JkeyWR7Yg/ve/W+DwUWJceKkwN2g=; b=f3YxeQ19IOyh8l3J31nByIOeej
	4Z+pFrYHpfWjuj3txCiq25wcdH2aNEyj5HAyJlGFrmPLsWCst1ARjljPusb0Tmb3x7gGkvtp6SNCV
	TE96z+8WsHW7thycrRIXPfQEJ59efHDnXIRrz64BIsX2DdJJzt/K9NtE7q2/dUAT1GOiw60Q6TDqt
	bFC01CttF2tBa9F8HxAZLpk7HdGacP0ea7XKSpnTPdPrD/hu1RImXftEenBSYUBhbdhmF7K0VPLea
	q5x/pvvWp4z55bMGeNfU6lTrrOJ7xR0vQWx5gbsSj6YNogNvhEttv00REiqrgEi2qQj04t+9Pyn73
	LesLWjhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD22X-0000000AIKs-3B9D;
	Fri, 31 May 2024 13:11:25 +0000
Date: Fri, 31 May 2024 06:11:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 1/8] iomap: zeroing needs to be pagecache aware
Message-ID: <ZlnMfSJcm5k6Dg_e@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-2-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 29, 2024 at 05:51:59PM +0800, Zhang Yi wrote:
> XXX: how do we detect a iomap containing a cow mapping over a hole
> in iomap_zero_iter()? The XFS code implies this case also needs to
> zero the page cache if there is data present, so trigger for page
> cache lookup only in iomap_zero_iter() needs to handle this case as
> well.

If there is no data in the page cache and either a whole or unwritten
extent it really should not matter what is in the COW fork, a there
obviously isn't any data we could zero.

If there is data in the page cache for something that is marked as
a hole in the srcmap, but we have data in the COW fork due to
COW extsize preallocation we'd need to zero it, but as the
xfs iomap ops don't return a separate srcmap for that case we
should be fine.  Or am I missing something?

> + * Note: when zeroing unwritten extents, we might have data in the page cache
> + * over an unwritten extent. In this case, we want to do a pure lookup on the
> + * page cache and not create a new folio as we don't need to perform zeroing on
> + * unwritten extents if there is no cached data over the given range.
>   */
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>  {
>  	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
>  
> +	if (iter->flags & IOMAP_ZERO) {
> +		const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +
> +		if (srcmap->type == IOMAP_UNWRITTEN)
> +			fgp &= ~FGP_CREAT;
> +	}

Nit:  The comment would probably stand out a little better if it was
right next to the IOMAP_ZERO conditional instead of above the
function.

> +		if (status) {
> +			if (status == -ENOENT) {
> +				/*
> +				 * Unwritten extents need to have page cache
> +				 * lookups done to determine if they have data
> +				 * over them that needs zeroing. If there is no
> +				 * data, we'll get -ENOENT returned here, so we
> +				 * can just skip over this index.
> +				 */
> +				WARN_ON_ONCE(srcmap->type != IOMAP_UNWRITTEN);

I'd return -EIO if the WARN_ON triggers.

> +loop_continue:

While I'm no strange to gotos for loop control something trips me
up about jumping to the end of the loop.  Here is what I could come
up with instead.  Not arguing it's objectively better, but I somehow
like it a little better:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 700b22d6807783..81378f7cd8d7ff 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1412,49 +1412,56 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		bool ret;
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (status) {
-			if (status == -ENOENT) {
-				/*
-				 * Unwritten extents need to have page cache
-				 * lookups done to determine if they have data
-				 * over them that needs zeroing. If there is no
-				 * data, we'll get -ENOENT returned here, so we
-				 * can just skip over this index.
-				 */
-				WARN_ON_ONCE(srcmap->type != IOMAP_UNWRITTEN);
-				if (bytes > PAGE_SIZE - offset_in_page(pos))
-					bytes = PAGE_SIZE - offset_in_page(pos);
-				goto loop_continue;
-			}
+		if (status && status != -ENOENT)
 			return status;
-		}
-		if (iter->iomap.flags & IOMAP_F_STALE)
-			break;
 
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
+		if (status == -ENOENT) {
+			/*
+			 * If we end up here, we did not find a folio in the
+			 * page cache for an unwritten extent and thus can
+			 * skip over the range.
+			 */
+			if (WARN_ON_ONCE(srcmap->type != IOMAP_UNWRITTEN))
+				return -EIO;
 
-		/*
-		 * If the folio over an unwritten extent is clean (i.e. because
-		 * it has been read from), then it already contains zeros. Hence
-		 * we can just skip it.
-		 */
-		if (srcmap->type == IOMAP_UNWRITTEN &&
-		    !folio_test_dirty(folio)) {
-			folio_unlock(folio);
-			goto loop_continue;
+			/*
+			 * XXX: It would be nice if we could get the offset of
+			 * the next entry in the pagecache so that we don't have
+			 * to iterate one page at a time here.
+			 */
+			offset = offset_in_page(pos);
+			if (bytes > PAGE_SIZE - offset)
+				bytes = PAGE_SIZE - offset;
+		} else {
+			if (iter->iomap.flags & IOMAP_F_STALE)
+				break;
+
+			offset = offset_in_folio(folio, pos);
+			if (bytes > folio_size(folio) - offset)
+				bytes = folio_size(folio) - offset;
+		
+			/*
+			 * If the folio over an unwritten extent is clean (i.e.
+			 * because it has only been read from), then it already
+			 * contains zeros.  Hence we can just skip it.
+			 */
+			if (srcmap->type == IOMAP_UNWRITTEN &&
+			    !folio_test_dirty(folio)) {
+				folio_unlock(folio);
+				status = -ENOENT;
+			}
 		}
 
-		folio_zero_range(folio, offset, bytes);
-		folio_mark_accessed(folio);
+		if (status != -ENOENT) {
+			folio_zero_range(folio, offset, bytes);
+			folio_mark_accessed(folio);
 
-		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
-		__iomap_put_folio(iter, pos, bytes, folio);
-		if (WARN_ON_ONCE(!ret))
-			return -EIO;
+			ret = iomap_write_end(iter, pos, bytes, bytes, folio);
+			__iomap_put_folio(iter, pos, bytes, folio);
+			if (WARN_ON_ONCE(!ret))
+				return -EIO;
+		}
 
-loop_continue:
 		pos += bytes;
 		length -= bytes;
 		written += bytes;

