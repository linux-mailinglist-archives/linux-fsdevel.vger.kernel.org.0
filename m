Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B6711D696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 20:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfLLTBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 14:01:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35725 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbfLLTBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:01:45 -0500
Received: by mail-io1-f67.google.com with SMTP id v18so3969007iol.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 11:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PyWDbU4hG6P7d49y0tBCsMJGkotSmS2Uil+mwDXCj8U=;
        b=CX74bB3GC+bODKChj/UZLr49RRkK/BRzUqQpr7UNdI4ixnYnD9p68B7wqYWQpiNUK+
         DJyZ7jWgcLpucnz/U0kVe4FdsD7yshJtFRKFWRl1oNlMT/qmumXPsGcjNndrstTO8ZAD
         iGsfSiJCJBPp1LiEfojYW8dxljwT4T0eahvB/mSA7zAiq8HCV5pYT19b1rQZimBEgVI+
         OuNKT9MsbjuWRmPTQOhRT3HntDnQxOWLNRFhkF4O2wbWXpC4bOJBViFmSU/iI2fp2Pfz
         sIHP9RrVjF3R4KTcWYZUF8lRov4dJre34NOcka6pzktgpwh+mCdbDMiSy3KZi6dW6ltk
         9eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PyWDbU4hG6P7d49y0tBCsMJGkotSmS2Uil+mwDXCj8U=;
        b=o8jmr9D3dpFF+FhJKi9TiQ6cTj9pyRSMCTeqTx+aj12sSpY14PR40FUc6HnMhA0PwZ
         vKgBzgZwwn71RUT62gcrMignqmOP0l0nS2UbGGjcil+5emJmWjk3hiRH0+8s/AUxykcE
         AGX/s6FXtCYJJZ9t6FHq7cGsdCpmtp+axtOi9Zh8Nv4v3Yj+lpZTyiphUALEmevNwNTP
         f8eIiIogX9sf1MD64I0TUEiVTLTOTvay5aIouUhDZsfIv7ugYTy6BTkSdByY+jCRZ/ae
         GmA5ypf505qlYzCsSgG5SKBYJOn8gCQII6aqrJiaQj4p5yzO/eCQi/FIFJ7D7wy0/0bK
         0pjA==
X-Gm-Message-State: APjAAAU02R03N+niKro2hLU0VKyLyyP0J1NP0h6brUB4dYP7LaWUeibw
        u8NF4Q60XYxNqVAeLyS7a1+u2Q==
X-Google-Smtp-Source: APXvYqyTEhfpOZJyJHspgWaBBmrqw2bRDjdeXHnaI6yoJbG/i718bPPGb3OfyIwf67f/YRRRqwuRKw==
X-Received: by 2002:a02:3312:: with SMTP id c18mr9302995jae.24.1576177303301;
        Thu, 12 Dec 2019 11:01:43 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i22sm1957745ill.40.2019.12.12.11.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:01:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] iomap: add struct iomap_data
Date:   Thu, 12 Dec 2019 12:01:32 -0700
Message-Id: <20191212190133.18473-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212190133.18473-1-axboe@kernel.dk>
References: <20191212190133.18473-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We pass a lot of arguments to iomap_apply(), and subsequently to the
actors that it calls. In preparation for adding one more argument,
switch them to using a struct iomap_data instead. The actor gets a const
version of that, they are not supposed to change anything in it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/dax.c               |  25 +++--
 fs/iomap/apply.c       |  26 +++---
 fs/iomap/buffered-io.c | 202 +++++++++++++++++++++++++----------------
 fs/iomap/direct-io.c   |  57 +++++++-----
 fs/iomap/fiemap.c      |  48 ++++++----
 fs/iomap/seek.c        |  64 ++++++++-----
 fs/iomap/swapfile.c    |  27 +++---
 include/linux/iomap.h  |  15 ++-
 8 files changed, 278 insertions(+), 186 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..d1c32dbbdf24 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1090,13 +1090,16 @@ int __dax_zero_page_range(struct block_device *bdev,
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);
 
 static loff_t
-dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+dax_iomap_actor(const struct iomap_data *data, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct block_device *bdev = iomap->bdev;
 	struct dax_device *dax_dev = iomap->dax_dev;
-	struct iov_iter *iter = data;
+	struct iov_iter *iter = data->priv;
+	loff_t pos = data->pos;
+	loff_t length = pos + data->len;
 	loff_t end = pos + length, done = 0;
+	struct inode *inode = data->inode;
 	ssize_t ret = 0;
 	size_t xfer;
 	int id;
@@ -1197,22 +1200,26 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = mapping->host;
-	loff_t pos = iocb->ki_pos, ret = 0, done = 0;
-	unsigned flags = 0;
+	loff_t ret = 0, done = 0;
+	struct iomap_data data = {
+		.inode	= inode,
+		.pos	= iocb->ki_pos,
+		.priv	= iter,
+	};
 
 	if (iov_iter_rw(iter) == WRITE) {
 		lockdep_assert_held_write(&inode->i_rwsem);
-		flags |= IOMAP_WRITE;
+		data.flags |= IOMAP_WRITE;
 	} else {
 		lockdep_assert_held(&inode->i_rwsem);
 	}
 
 	while (iov_iter_count(iter)) {
-		ret = iomap_apply(inode, pos, iov_iter_count(iter), flags, ops,
-				iter, dax_iomap_actor);
+		data.len = iov_iter_count(iter);
+		ret = iomap_apply(&data, ops, dax_iomap_actor);
 		if (ret <= 0)
 			break;
-		pos += ret;
+		data.pos += ret;
 		done += ret;
 	}
 
diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 76925b40b5fd..e76148db03b8 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -21,15 +21,16 @@
  * iomap_end call.
  */
 loff_t
-iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
-		const struct iomap_ops *ops, void *data, iomap_actor_t actor)
+iomap_apply(struct iomap_data *data, const struct iomap_ops *ops,
+	    iomap_actor_t actor)
 {
 	struct iomap iomap = { .type = IOMAP_HOLE };
 	struct iomap srcmap = { .type = IOMAP_HOLE };
 	loff_t written = 0, ret;
 	u64 end;
 
-	trace_iomap_apply(inode, pos, length, flags, ops, actor, _RET_IP_);
+	trace_iomap_apply(data->inode, data->pos, data->len, data->flags, ops,
+				actor, _RET_IP_);
 
 	/*
 	 * Need to map a range from start position for length bytes. This can
@@ -43,17 +44,18 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	 * expose transient stale data. If the reserve fails, we can safely
 	 * back out at this point as there is nothing to undo.
 	 */
-	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
+	ret = ops->iomap_begin(data->inode, data->pos, data->len, data->flags,
+				&iomap, &srcmap);
 	if (ret)
 		return ret;
-	if (WARN_ON(iomap.offset > pos))
+	if (WARN_ON(iomap.offset > data->pos))
 		return -EIO;
 	if (WARN_ON(iomap.length == 0))
 		return -EIO;
 
-	trace_iomap_apply_dstmap(inode, &iomap);
+	trace_iomap_apply_dstmap(data->inode, &iomap);
 	if (srcmap.type != IOMAP_HOLE)
-		trace_iomap_apply_srcmap(inode, &srcmap);
+		trace_iomap_apply_srcmap(data->inode, &srcmap);
 
 	/*
 	 * Cut down the length to the one actually provided by the filesystem,
@@ -62,8 +64,8 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	end = iomap.offset + iomap.length;
 	if (srcmap.type != IOMAP_HOLE)
 		end = min(end, srcmap.offset + srcmap.length);
-	if (pos + length > end)
-		length = end - pos;
+	if (data->pos + data->len > end)
+		data->len = end - data->pos;
 
 	/*
 	 * Now that we have guaranteed that the space allocation will succeed,
@@ -77,7 +79,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	 * iomap into the actors so that they don't need to have special
 	 * handling for the two cases.
 	 */
-	written = actor(inode, pos, length, data, &iomap,
+	written = actor(data, &iomap,
 			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
 
 	/*
@@ -85,9 +87,9 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	 * should not fail unless the filesystem has had a fatal error.
 	 */
 	if (ops->iomap_end) {
-		ret = ops->iomap_end(inode, pos, length,
+		ret = ops->iomap_end(data->inode, data->pos, data->len,
 				     written > 0 ? written : 0,
-				     flags, &iomap);
+				     data->flags, &iomap);
 	}
 
 	return written ? written : ret;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 828444e14d09..0a1a195ed1cc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -248,14 +248,15 @@ static inline bool iomap_block_needs_zeroing(struct inode *inode,
 }
 
 static loff_t
-iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+iomap_readpage_actor(const struct iomap_data *data, struct iomap *iomap,
+		     struct iomap *srcmap)
 {
-	struct iomap_readpage_ctx *ctx = data;
+	struct iomap_readpage_ctx *ctx = data->priv;
+	struct inode *inode = data->inode;
 	struct page *page = ctx->cur_page;
 	struct iomap_page *iop = iomap_page_create(inode, page);
 	bool same_page = false, is_contig = false;
-	loff_t orig_pos = pos;
+	loff_t pos = data->pos, orig_pos = data->pos;
 	unsigned poff, plen;
 	sector_t sector;
 
@@ -266,7 +267,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
+	iomap_adjust_read_range(inode, iop, &pos, data->len, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
@@ -302,7 +303,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
-		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		int nr_vecs = (data->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 		if (ctx->bio)
 			submit_bio(ctx->bio);
@@ -333,16 +334,20 @@ int
 iomap_readpage(struct page *page, const struct iomap_ops *ops)
 {
 	struct iomap_readpage_ctx ctx = { .cur_page = page };
-	struct inode *inode = page->mapping->host;
+	struct iomap_data data = {
+		.inode	= page->mapping->host,
+		.priv	= &ctx,
+		.flags	= 0
+	};
 	unsigned poff;
 	loff_t ret;
 
 	trace_iomap_readpage(page->mapping->host, 1);
 
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
-		ret = iomap_apply(inode, page_offset(page) + poff,
-				PAGE_SIZE - poff, 0, ops, &ctx,
-				iomap_readpage_actor);
+		data.pos = page_offset(page) + poff;
+		data.len = PAGE_SIZE - poff;
+		ret = iomap_apply(&data, ops, iomap_readpage_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
 			SetPageError(page);
@@ -396,28 +401,34 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
 }
 
 static loff_t
-iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+iomap_readpages_actor(const struct iomap_data *data, struct iomap *iomap,
+		      struct iomap *srcmap)
 {
-	struct iomap_readpage_ctx *ctx = data;
+	struct iomap_readpage_ctx *ctx = data->priv;
 	loff_t done, ret;
 
-	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
+	for (done = 0; done < data->len; done += ret) {
+		struct iomap_data rp_data = {
+			.inode	= data->inode,
+			.pos	= data->pos + done,
+			.len	= data->len - done,
+			.priv	= ctx,
+		};
+
+		if (ctx->cur_page && offset_in_page(rp_data.pos) == 0) {
 			if (!ctx->cur_page_in_bio)
 				unlock_page(ctx->cur_page);
 			put_page(ctx->cur_page);
 			ctx->cur_page = NULL;
 		}
 		if (!ctx->cur_page) {
-			ctx->cur_page = iomap_next_page(inode, ctx->pages,
-					pos, length, &done);
+			ctx->cur_page = iomap_next_page(data->inode, ctx->pages,
+					data->pos, data->len, &done);
 			if (!ctx->cur_page)
 				break;
 			ctx->cur_page_in_bio = false;
 		}
-		ret = iomap_readpage_actor(inode, pos + done, length - done,
-				ctx, iomap, srcmap);
+		ret = iomap_readpage_actor(&rp_data, iomap, srcmap);
 	}
 
 	return done;
@@ -431,21 +442,27 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 		.pages		= pages,
 		.is_readahead	= true,
 	};
-	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
+	struct iomap_data data = {
+		.inode	= mapping->host,
+		.priv	= &ctx,
+		.flags	= 0
+	};
 	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
-	loff_t length = last - pos + PAGE_SIZE, ret = 0;
+	loff_t ret = 0;
+
+	data.pos = page_offset(list_entry(pages->prev, struct page, lru));
+	data.len = last - data.pos + PAGE_SIZE;
 
-	trace_iomap_readpages(mapping->host, nr_pages);
+	trace_iomap_readpages(data.inode, nr_pages);
 
-	while (length > 0) {
-		ret = iomap_apply(mapping->host, pos, length, 0, ops,
-				&ctx, iomap_readpages_actor);
+	while (data.len > 0) {
+		ret = iomap_apply(&data, ops, iomap_readpages_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
 			goto done;
 		}
-		pos += ret;
-		length -= ret;
+		data.pos += ret;
+		data.len -= ret;
 	}
 	ret = 0;
 done:
@@ -796,10 +813,13 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
 }
 
 static loff_t
-iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+iomap_write_actor(const struct iomap_data *data, struct iomap *iomap,
+		  struct iomap *srcmap)
 {
-	struct iov_iter *i = data;
+	struct inode *inode = data->inode;
+	struct iov_iter *i = data->priv;
+	loff_t length = data->len;
+	loff_t pos = data->pos;
 	long status = 0;
 	ssize_t written = 0;
 
@@ -879,15 +899,20 @@ ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops)
 {
-	struct inode *inode = iocb->ki_filp->f_mapping->host;
-	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
+	struct iomap_data data = {
+		.inode	= iocb->ki_filp->f_mapping->host,
+		.pos	= iocb->ki_pos,
+		.priv	= iter,
+		.flags	= IOMAP_WRITE
+	};
+	loff_t ret = 0, written = 0;
 
 	while (iov_iter_count(iter)) {
-		ret = iomap_apply(inode, pos, iov_iter_count(iter),
-				IOMAP_WRITE, ops, iter, iomap_write_actor);
+		data.len = iov_iter_count(iter);
+		ret = iomap_apply(&data, ops, iomap_write_actor);
 		if (ret <= 0)
 			break;
-		pos += ret;
+		data.pos += ret;
 		written += ret;
 	}
 
@@ -896,9 +921,11 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
 static loff_t
-iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+iomap_unshare_actor(const struct iomap_data *data, struct iomap *iomap,
+		    struct iomap *srcmap)
 {
+	loff_t pos = data->pos;
+	loff_t length = data->len;
 	long status = 0;
 	ssize_t written = 0;
 
@@ -914,13 +941,13 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct page *page;
 
-		status = iomap_write_begin(inode, pos, bytes,
+		status = iomap_write_begin(data->inode, pos, bytes,
 				IOMAP_WRITE_F_UNSHARE, &page, iomap, srcmap);
 		if (unlikely(status))
 			return status;
 
-		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
-				srcmap);
+		status = iomap_write_end(data->inode, pos, bytes, bytes, page,
+						iomap, srcmap);
 		if (unlikely(status <= 0)) {
 			if (WARN_ON_ONCE(status == 0))
 				return -EIO;
@@ -933,7 +960,7 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		written += status;
 		length -= status;
 
-		balance_dirty_pages_ratelimited(inode->i_mapping);
+		balance_dirty_pages_ratelimited(data->inode->i_mapping);
 	} while (length);
 
 	return written;
@@ -943,15 +970,20 @@ int
 iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops)
 {
+	struct iomap_data data = {
+		.inode	= inode,
+		.pos	= pos,
+		.len	= len,
+		.flags	= IOMAP_WRITE,
+	};
 	loff_t ret;
 
-	while (len) {
-		ret = iomap_apply(inode, pos, len, IOMAP_WRITE, ops, NULL,
-				iomap_unshare_actor);
+	while (data.len) {
+		ret = iomap_apply(&data, ops, iomap_unshare_actor);
 		if (ret <= 0)
 			return ret;
-		pos += ret;
-		len -= ret;
+		data.pos += ret;
+		data.len -= ret;
 	}
 
 	return 0;
@@ -982,16 +1014,18 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
 }
 
 static loff_t
-iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+iomap_zero_range_actor(const struct iomap_data *data, struct iomap *iomap,
+		       struct iomap *srcmap)
 {
-	bool *did_zero = data;
+	bool *did_zero = data->priv;
+	loff_t count = data->len;
+	loff_t pos = data->pos;
 	loff_t written = 0;
 	int status;
 
 	/* already zeroed?  we're done. */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
-		return count;
+		return data->len;
 
 	do {
 		unsigned offset, bytes;
@@ -999,11 +1033,11 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		offset = offset_in_page(pos);
 		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
 
-		if (IS_DAX(inode))
+		if (IS_DAX(data->inode))
 			status = iomap_dax_zero(pos, offset, bytes, iomap);
 		else
-			status = iomap_zero(inode, pos, offset, bytes, iomap,
-					srcmap);
+			status = iomap_zero(data->inode, pos, offset, bytes,
+						iomap, srcmap);
 		if (status < 0)
 			return status;
 
@@ -1021,16 +1055,22 @@ int
 iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		const struct iomap_ops *ops)
 {
+	struct iomap_data data = {
+		.inode	= inode,
+		.pos	= pos,
+		.len	= len,
+		.priv	= did_zero,
+		.flags	= IOMAP_ZERO
+	};
 	loff_t ret;
 
-	while (len > 0) {
-		ret = iomap_apply(inode, pos, len, IOMAP_ZERO,
-				ops, did_zero, iomap_zero_range_actor);
+	while (data.len > 0) {
+		ret = iomap_apply(&data, ops, iomap_zero_range_actor);
 		if (ret <= 0)
 			return ret;
 
-		pos += ret;
-		len -= ret;
+		data.pos += ret;
+		data.len -= ret;
 	}
 
 	return 0;
@@ -1052,57 +1092,59 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
 static loff_t
-iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+iomap_page_mkwrite_actor(const struct iomap_data *data,
+			 struct iomap *iomap, struct iomap *srcmap)
 {
-	struct page *page = data;
+	struct page *page = data->priv;
 	int ret;
 
 	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = __block_write_begin_int(page, pos, length, NULL, iomap);
+		ret = __block_write_begin_int(page, data->pos, data->len, NULL,
+						iomap);
 		if (ret)
 			return ret;
-		block_commit_write(page, 0, length);
+		block_commit_write(page, 0, data->len);
 	} else {
 		WARN_ON_ONCE(!PageUptodate(page));
-		iomap_page_create(inode, page);
+		iomap_page_create(data->inode, page);
 		set_page_dirty(page);
 	}
 
-	return length;
+	return data->len;
 }
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
-	unsigned long length;
-	loff_t offset, size;
+	struct iomap_data data = {
+		.inode	= file_inode(vmf->vma->vm_file),
+		.pos	= page_offset(page),
+		.flags	= IOMAP_WRITE | IOMAP_FAULT,
+		.priv	= page,
+	};
 	ssize_t ret;
+	loff_t size;
 
 	lock_page(page);
-	size = i_size_read(inode);
-	offset = page_offset(page);
-	if (page->mapping != inode->i_mapping || offset > size) {
+	size = i_size_read(data.inode);
+	if (page->mapping != data.inode->i_mapping || data.pos > size) {
 		/* We overload EFAULT to mean page got truncated */
 		ret = -EFAULT;
 		goto out_unlock;
 	}
 
 	/* page is wholly or partially inside EOF */
-	if (offset > size - PAGE_SIZE)
-		length = offset_in_page(size);
+	if (data.pos > size - PAGE_SIZE)
+		data.len = offset_in_page(size);
 	else
-		length = PAGE_SIZE;
+		data.len = PAGE_SIZE;
 
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length,
-				IOMAP_WRITE | IOMAP_FAULT, ops, page,
-				iomap_page_mkwrite_actor);
+	while (data.len > 0) {
+		ret = iomap_apply(&data, ops, iomap_page_mkwrite_actor);
 		if (unlikely(ret <= 0))
 			goto out_unlock;
-		offset += ret;
-		length -= ret;
+		data.pos += ret;
+		data.len -= ret;
 	}
 
 	wait_for_stable_page(page);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..e561ca9329ac 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -364,24 +364,27 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 }
 
 static loff_t
-iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+iomap_dio_actor(const struct iomap_data *data, struct iomap *iomap,
+		struct iomap *srcmap)
 {
-	struct iomap_dio *dio = data;
+	struct iomap_dio *dio = data->priv;
 
 	switch (iomap->type) {
 	case IOMAP_HOLE:
 		if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
 			return -EIO;
-		return iomap_dio_hole_actor(length, dio);
+		return iomap_dio_hole_actor(data->len, dio);
 	case IOMAP_UNWRITTEN:
 		if (!(dio->flags & IOMAP_DIO_WRITE))
-			return iomap_dio_hole_actor(length, dio);
-		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
+			return iomap_dio_hole_actor(data->len, dio);
+		return iomap_dio_bio_actor(data->inode, data->pos, data->len,
+						dio, iomap);
 	case IOMAP_MAPPED:
-		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
+		return iomap_dio_bio_actor(data->inode, data->pos, data->len,
+						dio, iomap);
 	case IOMAP_INLINE:
-		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
+		return iomap_dio_inline_actor(data->inode, data->pos, data->len,
+						dio, iomap);
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
@@ -404,16 +407,19 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
-	size_t count = iov_iter_count(iter);
-	loff_t pos = iocb->ki_pos;
-	loff_t end = iocb->ki_pos + count - 1, ret = 0;
-	unsigned int flags = IOMAP_DIRECT;
+	struct iomap_data data = {
+		.inode	= inode,
+		.pos	= iocb->ki_pos,
+		.len	= iov_iter_count(iter),
+		.flags	= IOMAP_DIRECT
+	};
+	loff_t end = data.pos + data.len - 1, ret = 0;
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
 	lockdep_assert_held(&inode->i_rwsem);
 
-	if (!count)
+	if (!data.len)
 		return 0;
 
 	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
@@ -436,14 +442,16 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->submit.cookie = BLK_QC_T_NONE;
 	dio->submit.last_queue = NULL;
 
+	data.priv = dio;
+
 	if (iov_iter_rw(iter) == READ) {
-		if (pos >= dio->i_size)
+		if (data.pos >= dio->i_size)
 			goto out_free_dio;
 
 		if (iter_is_iovec(iter))
 			dio->flags |= IOMAP_DIO_DIRTY;
 	} else {
-		flags |= IOMAP_WRITE;
+		data.flags |= IOMAP_WRITE;
 		dio->flags |= IOMAP_DIO_WRITE;
 
 		/* for data sync or sync, we need sync completion processing */
@@ -461,14 +469,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	}
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (filemap_range_has_page(mapping, pos, end)) {
+		if (filemap_range_has_page(mapping, data.pos, end)) {
 			ret = -EAGAIN;
 			goto out_free_dio;
 		}
-		flags |= IOMAP_NOWAIT;
+		data.flags |= IOMAP_NOWAIT;
 	}
 
-	ret = filemap_write_and_wait_range(mapping, pos, end);
+	ret = filemap_write_and_wait_range(mapping, data.pos, end);
 	if (ret)
 		goto out_free_dio;
 
@@ -479,7 +487,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 * pretty crazy thing to do, so we don't support it 100%.
 	 */
 	ret = invalidate_inode_pages2_range(mapping,
-			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
+			data.pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
 	if (ret)
 		dio_warn_stale_pagecache(iocb->ki_filp);
 	ret = 0;
@@ -495,8 +503,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	blk_start_plug(&plug);
 	do {
-		ret = iomap_apply(inode, pos, count, flags, ops, dio,
-				iomap_dio_actor);
+		ret = iomap_apply(&data, ops, iomap_dio_actor);
 		if (ret <= 0) {
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {
@@ -505,18 +512,18 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			}
 			break;
 		}
-		pos += ret;
+		data.pos += ret;
 
-		if (iov_iter_rw(iter) == READ && pos >= dio->i_size) {
+		if (iov_iter_rw(iter) == READ && data.pos >= dio->i_size) {
 			/*
 			 * We only report that we've read data up to i_size.
 			 * Revert iter to a state corresponding to that as
 			 * some callers (such as splice code) rely on it.
 			 */
-			iov_iter_revert(iter, pos - dio->i_size);
+			iov_iter_revert(iter, data.pos - dio->i_size);
 			break;
 		}
-	} while ((count = iov_iter_count(iter)) > 0);
+	} while ((data.len = iov_iter_count(iter)) > 0);
 	blk_finish_plug(&plug);
 
 	if (ret < 0)
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index bccf305ea9ce..4075fbe0e3f5 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -43,20 +43,20 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
 }
 
 static loff_t
-iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+iomap_fiemap_actor(const struct iomap_data *data, struct iomap *iomap,
+		   struct iomap *srcmap)
 {
-	struct fiemap_ctx *ctx = data;
-	loff_t ret = length;
+	struct fiemap_ctx *ctx = data->priv;
+	loff_t ret = data->len;
 
 	if (iomap->type == IOMAP_HOLE)
-		return length;
+		return data->len;
 
 	ret = iomap_to_fiemap(ctx->fi, &ctx->prev, 0);
 	ctx->prev = *iomap;
 	switch (ret) {
 	case 0:		/* success */
-		return length;
+		return data->len;
 	case 1:		/* extent array full */
 		return 0;
 	default:
@@ -68,6 +68,13 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 		loff_t start, loff_t len, const struct iomap_ops *ops)
 {
 	struct fiemap_ctx ctx;
+	struct iomap_data data = {
+		.inode	= inode,
+		.pos	= start,
+		.len	= len,
+		.flags	= IOMAP_REPORT,
+		.priv	= &ctx
+	};
 	loff_t ret;
 
 	memset(&ctx, 0, sizeof(ctx));
@@ -84,9 +91,8 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 			return ret;
 	}
 
-	while (len > 0) {
-		ret = iomap_apply(inode, start, len, IOMAP_REPORT, ops, &ctx,
-				iomap_fiemap_actor);
+	while (data.len > 0) {
+		ret = iomap_apply(&data, ops, iomap_fiemap_actor);
 		/* inode with no (attribute) mapping will give ENOENT */
 		if (ret == -ENOENT)
 			break;
@@ -95,8 +101,8 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 		if (ret == 0)
 			break;
 
-		start += ret;
-		len -= ret;
+		data.pos += ret;
+		data.len -= ret;
 	}
 
 	if (ctx.prev.type != IOMAP_HOLE) {
@@ -110,13 +116,14 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 EXPORT_SYMBOL_GPL(iomap_fiemap);
 
 static loff_t
-iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+iomap_bmap_actor(const struct iomap_data *data, struct iomap *iomap,
+		 struct iomap *srcmap)
 {
-	sector_t *bno = data, addr;
+	sector_t *bno = data->priv, addr;
 
 	if (iomap->type == IOMAP_MAPPED) {
-		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
+		addr = (data->pos - iomap->offset + iomap->addr) >>
+				data->inode->i_blkbits;
 		if (addr > INT_MAX)
 			WARN(1, "would truncate bmap result\n");
 		else
@@ -131,16 +138,19 @@ iomap_bmap(struct address_space *mapping, sector_t bno,
 		const struct iomap_ops *ops)
 {
 	struct inode *inode = mapping->host;
-	loff_t pos = bno << inode->i_blkbits;
-	unsigned blocksize = i_blocksize(inode);
+	struct iomap_data data = {
+		.inode	= inode,
+		.pos	= bno << inode->i_blkbits,
+		.len	= i_blocksize(inode),
+		.priv	= &bno
+	};
 	int ret;
 
 	if (filemap_write_and_wait(mapping))
 		return 0;
 
 	bno = 0;
-	ret = iomap_apply(inode, pos, blocksize, 0, ops, &bno,
-			  iomap_bmap_actor);
+	ret = iomap_apply(&data, ops, iomap_bmap_actor);
 	if (ret)
 		return 0;
 	return bno;
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 89f61d93c0bc..288bee0b5d9b 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -118,21 +118,23 @@ page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
 
 
 static loff_t
-iomap_seek_hole_actor(struct inode *inode, loff_t offset, loff_t length,
-		      void *data, struct iomap *iomap, struct iomap *srcmap)
+iomap_seek_hole_actor(const struct iomap_data *data, struct iomap *iomap,
+		      struct iomap *srcmap)
 {
+	loff_t offset = data->pos;
+
 	switch (iomap->type) {
 	case IOMAP_UNWRITTEN:
-		offset = page_cache_seek_hole_data(inode, offset, length,
-						   SEEK_HOLE);
+		offset = page_cache_seek_hole_data(data->inode, offset,
+						   data->len, SEEK_HOLE);
 		if (offset < 0)
-			return length;
+			return data->len;
 		/* fall through */
 	case IOMAP_HOLE:
-		*(loff_t *)data = offset;
+		*(loff_t *)data->priv = offset;
 		return 0;
 	default:
-		return length;
+		return data->len;
 	}
 }
 
@@ -140,23 +142,28 @@ loff_t
 iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
 	loff_t size = i_size_read(inode);
-	loff_t length = size - offset;
+	struct iomap_data data = {
+		.inode	= inode,
+		.len	= size - offset,
+		.priv	= &offset,
+		.flags	= IOMAP_REPORT
+	};
 	loff_t ret;
 
 	/* Nothing to be found before or beyond the end of the file. */
 	if (offset < 0 || offset >= size)
 		return -ENXIO;
 
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
-				  &offset, iomap_seek_hole_actor);
+	while (data.len > 0) {
+		data.pos = offset;
+		ret = iomap_apply(&data, ops, iomap_seek_hole_actor);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
 			break;
 
 		offset += ret;
-		length -= ret;
+		data.len -= ret;
 	}
 
 	return offset;
@@ -164,20 +171,22 @@ iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_seek_hole);
 
 static loff_t
-iomap_seek_data_actor(struct inode *inode, loff_t offset, loff_t length,
-		      void *data, struct iomap *iomap, struct iomap *srcmap)
+iomap_seek_data_actor(const struct iomap_data *data, struct iomap *iomap,
+		      struct iomap *srcmap)
 {
+	loff_t offset = data->pos;
+
 	switch (iomap->type) {
 	case IOMAP_HOLE:
-		return length;
+		return data->len;
 	case IOMAP_UNWRITTEN:
-		offset = page_cache_seek_hole_data(inode, offset, length,
-						   SEEK_DATA);
+		offset = page_cache_seek_hole_data(data->inode, offset,
+						   data->len, SEEK_DATA);
 		if (offset < 0)
-			return length;
+			return data->len;
 		/*FALLTHRU*/
 	default:
-		*(loff_t *)data = offset;
+		*(loff_t *)data->priv = offset;
 		return 0;
 	}
 }
@@ -186,26 +195,31 @@ loff_t
 iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
 	loff_t size = i_size_read(inode);
-	loff_t length = size - offset;
+	struct iomap_data data = {
+		.inode  = inode,
+		.len    = size - offset,
+		.priv   = &offset,
+		.flags  = IOMAP_REPORT
+	};
 	loff_t ret;
 
 	/* Nothing to be found before or beyond the end of the file. */
 	if (offset < 0 || offset >= size)
 		return -ENXIO;
 
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
-				  &offset, iomap_seek_data_actor);
+	while (data.len > 0) {
+		data.pos = offset;
+		ret = iomap_apply(&data, ops, iomap_seek_data_actor);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
 			break;
 
 		offset += ret;
-		length -= ret;
+		data.len -= ret;
 	}
 
-	if (length <= 0)
+	if (data.len <= 0)
 		return -ENXIO;
 	return offset;
 }
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index a648dbf6991e..d911ab4b69ea 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -75,11 +75,10 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
  * swap only cares about contiguous page-aligned physical extents and makes no
  * distinction between written and unwritten extents.
  */
-static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
-		loff_t count, void *data, struct iomap *iomap,
-		struct iomap *srcmap)
+static loff_t iomap_swapfile_activate_actor(const struct iomap_data *data,
+		struct iomap *iomap, struct iomap *srcmap)
 {
-	struct iomap_swapfile_info *isi = data;
+	struct iomap_swapfile_info *isi = data->priv;
 	int error;
 
 	switch (iomap->type) {
@@ -125,7 +124,7 @@ static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
 			return error;
 		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
 	}
-	return count;
+	return data->len;
 }
 
 /*
@@ -142,8 +141,13 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 	};
 	struct address_space *mapping = swap_file->f_mapping;
 	struct inode *inode = mapping->host;
-	loff_t pos = 0;
-	loff_t len = ALIGN_DOWN(i_size_read(inode), PAGE_SIZE);
+	struct iomap_data data = {
+		.inode	= inode,
+		.pos	= 0,
+		.len 	= ALIGN_DOWN(i_size_read(inode), PAGE_SIZE),
+		.priv	= &isi,
+		.flags	= IOMAP_REPORT
+	};
 	loff_t ret;
 
 	/*
@@ -154,14 +158,13 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 	if (ret)
 		return ret;
 
-	while (len > 0) {
-		ret = iomap_apply(inode, pos, len, IOMAP_REPORT,
-				ops, &isi, iomap_swapfile_activate_actor);
+	while (data.len > 0) {
+		ret = iomap_apply(&data, ops, iomap_swapfile_activate_actor);
 		if (ret <= 0)
 			return ret;
 
-		pos += ret;
-		len -= ret;
+		data.pos += ret;
+		data.len -= ret;
 	}
 
 	if (isi.iomap.length) {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..30f40145a9e9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -145,11 +145,18 @@ struct iomap_ops {
 /*
  * Main iomap iterator function.
  */
-typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
-		void *data, struct iomap *iomap, struct iomap *srcmap);
+struct iomap_data {
+	struct inode	*inode;
+	loff_t		pos;
+	loff_t		len;
+	void		*priv;
+	unsigned	flags;
+};
+
+typedef loff_t (*iomap_actor_t)(const struct iomap_data *data,
+		struct iomap *iomap, struct iomap *srcmap);
 
-loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
-		unsigned flags, const struct iomap_ops *ops, void *data,
+loff_t iomap_apply(struct iomap_data *data, const struct iomap_ops *ops,
 		iomap_actor_t actor);
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
-- 
2.24.1

