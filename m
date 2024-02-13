Return-Path: <linux-fsdevel+bounces-11296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F4885285E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AC728618D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 05:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D413012B97;
	Tue, 13 Feb 2024 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xrZHcyPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AD11C8B;
	Tue, 13 Feb 2024 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803203; cv=none; b=E3mo1McldWfzkf/cVf+iWNXoESch/PlR+D8fPL59SCDcqXlWpgdRn3dxdS48zrTvCholeItVzhev1uQUh7UqicSXKNqUSTt7UKmAlQEgF7Vhyc4RckSOVnnafsNRlwi752e26w+/Sij0xaGkccST5zwoeDJ+UidG1r14dGYDOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803203; c=relaxed/simple;
	bh=OhoOvy2YQ1SbnEI1+kQKR/O2PW10e5EPQFYdwTDzNB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agJEh4IDSJsdsn68kSo6UDtgHvjFBTKzH8KpDZRBxeKPNRVHeShWrDsd8+GUmFIkrQxkVXHPV2+rLkm0hbCsnSIxHMIQQEN7gYD1FMEfFZIkPkS15+sXdU5LuLO842rthik2lSaiJ7iwk0JmoEGp/Lq9sIQ5uXfCOZFQ6zB2GW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xrZHcyPL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T3oaY7gdOOxrlvC+Ug5bN838TmkbxRk5QZ7DRKmSkjg=; b=xrZHcyPLkZHEDdjmrk+cnQA+xy
	0AkdwwRG+DaStdTpZtJRXi7YdqCsSSB5ScDf2AMPZ4rdY7/J7au0yFOM/aQkPRmcgxqoJJ2tg9Wq0
	PKp7d80Jdfa5rJnkIIx63gdIWW+wVREJQNfo+0TvK0njQDTR4M4fIVKrvqKdilYmcrHexy4f0W6GE
	6lTnp87fdtqVZNBFze1rXiMASKxZ8dvlOjd0qZHBXvb0klJyLxr76HMRZTxFSsodHcD5svV638mvl
	BelEMwroYY15e3rj/n4RpzqImMiL94y443lDFASin5rJEmMNWp0bY4j64qDzAzZWkMwtZ0sME2ACr
	ms6UMe9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZlct-000000081r5-2JOd;
	Tue, 13 Feb 2024 05:46:39 +0000
Date: Mon, 12 Feb 2024 21:46:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
Message-ID: <ZcsCP4h-ExNOcdD6@infradead.org>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Wouldn't it make more sense to just move the size manipulation to the
write-only code?  An untested version of that is below.  With this
the naming of the status variable becomes even more confusing than
it already is, maybe we need to do a cleanup of the *_write_end
calling conventions as it always returns the passed in copied value
or 0.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3dab060aed6d7b..8401a9ca702fc0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -876,34 +876,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t old_size = iter->inode->i_size;
-	size_t ret;
-
-	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(iter, folio, pos, copied);
-	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
-				copied, &folio->page, NULL);
-	} else {
-		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
-	}
-
-	/*
-	 * Update the in-memory inode size after copying the data into the page
-	 * cache.  It's up to the file system to write the updated size to disk,
-	 * preferably after I/O completion so that no stale data is exposed.
-	 */
-	if (pos + ret > old_size) {
-		i_size_write(iter->inode, pos + ret);
-		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
-	}
-	__iomap_put_folio(iter, pos, ret, folio);
 
-	if (old_size < pos)
-		pagecache_isize_extended(iter->inode, old_size, pos);
-	if (ret < len)
-		iomap_write_failed(iter->inode, pos + ret, len - ret);
-	return ret;
+	if (srcmap->type == IOMAP_INLINE)
+		return iomap_write_end_inline(iter, folio, pos, copied);
+	if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
+		return block_write_end(NULL, iter->inode->i_mapping, pos, len,
+					copied, &folio->page, NULL);
+	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
@@ -918,6 +897,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 	do {
 		struct folio *folio;
+		loff_t old_size;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
@@ -964,7 +944,24 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		status = iomap_write_end(iter, pos, bytes, copied, folio);
+		/*
+		 * Update the in-memory inode size after copying the data into
+		 * the page cache.  It's up to the file system to write the
+		 * updated size to disk, preferably after I/O completion so that
+		 * no stale data is exposed.
+		 */
+		old_size = iter->inode->i_size;
+		if (pos + status > old_size) {
+			i_size_write(iter->inode, pos + status);
+			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
+		}
+		__iomap_put_folio(iter, pos, status, folio);
 
+		if (old_size < pos)
+			pagecache_isize_extended(iter->inode, old_size, pos);
+		if (status < bytes)
+			iomap_write_failed(iter->inode, pos + status,
+						bytes - status);
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
 
@@ -1334,6 +1331,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 			bytes = folio_size(folio) - offset;
 
 		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
@@ -1398,6 +1396,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);
 
 		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		__iomap_put_folio(iter, pos, bytes, folio);
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 

