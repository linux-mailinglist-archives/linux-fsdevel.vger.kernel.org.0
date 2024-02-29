Return-Path: <linux-fsdevel+bounces-13163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38D386C0AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 07:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C14B24A96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 06:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8903FBBA;
	Thu, 29 Feb 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dq7qcKXv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211D36123
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188227; cv=none; b=eG020YlYXZ1cWKrULhzza/IZeeD2HVjhVS8g6IEeBmqpwYqxpKhpvx49rV98ZSRt51egkcm9p7nRm/CkBfP7JQbA07ma800HomiOCsoZD00VG2FKStljnOPBF2WQGB4Tdlgm21N0Ol/FkBTr4czoxceuLuS5mg4Ad86DDGmFfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188227; c=relaxed/simple;
	bh=BPzqn+d+lsYRYpjLVCaIRRf0/ndaIMpw8rTPaEZwmcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjJWVbV9wOXaL7sGgSS1ZJz1VyLuWUQ0xdcFVZKj04eHkSN6XasO7TL/MkXepOz2OTWl01B9Hdmk62BXV+aZymFSnHh1fPyEvtWQIqjN9m+u8tu1UITUPlquGxHulaYYdyBmpDy4DCg42mzK1GWfbyEh6Ui8/9yp5nZlX2B4/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dq7qcKXv; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709188222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYPSfPxcht/ebETsoi0J8ZwT/8VCoaH5tOzKLdUfld4=;
	b=dq7qcKXvz3u1e7WQryoOKWgWz7+Nugp768XpEtDLqr8VvAaVYSY3R+/k80VW4MDQIKnX28
	B9ZXap03Y0P6uo/OgZHidfPsvURF5f7aybdioc5ULp8eRG3/ToScPW/phq9vfpfpWzalCa
	UfTNKwintwp7ahe/Trq+VdUcBk8veIw=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	david@fromorbit.com,
	mcgrof@kernel.org,
	torvalds@linux-foundation.org,
	hch@lst.de,
	willy@infradead.org
Subject: [PATCH 2/2] bcachefs: Buffered write path now can avoid the inode lock
Date: Thu, 29 Feb 2024 01:30:08 -0500
Message-ID: <20240229063010.68754-3-kent.overstreet@linux.dev>
In-Reply-To: <20240229063010.68754-1-kent.overstreet@linux.dev>
References: <20240229063010.68754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Non append, non extending buffered writes can now avoid taking the inode
lock.

To ensure atomicity of writes w.r.t. other writes, we lock every folio
that we'll be writing to, and if this fails we fall back to taking the
inode lock.

Extensive comments are provided as to corner cases.

Link: https://lore.kernel.org/linux-fsdevel/Zdkxfspq3urnrM6I@bombadil.infradead.org/
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/errcode.h        |   3 +-
 fs/bcachefs/fs-io-buffered.c | 145 +++++++++++++++++++++++++----------
 2 files changed, 107 insertions(+), 41 deletions(-)

diff --git a/fs/bcachefs/errcode.h b/fs/bcachefs/errcode.h
index e960a6eae66a..2791d5127090 100644
--- a/fs/bcachefs/errcode.h
+++ b/fs/bcachefs/errcode.h
@@ -247,7 +247,8 @@
 	x(BCH_ERR_nopromote,		nopromote_congested)			\
 	x(BCH_ERR_nopromote,		nopromote_in_flight)			\
 	x(BCH_ERR_nopromote,		nopromote_no_writes)			\
-	x(BCH_ERR_nopromote,		nopromote_enomem)
+	x(BCH_ERR_nopromote,		nopromote_enomem)			\
+	x(0,				need_inode_lock)
 
 enum bch_errcode {
 	BCH_ERR_START		= 2048,
diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 27710cdd5710..9ce92d1bc3ea 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -810,7 +810,8 @@ static noinline void folios_trunc(folios *fs, struct folio **fi)
 static int __bch2_buffered_write(struct bch_inode_info *inode,
 				 struct address_space *mapping,
 				 struct iov_iter *iter,
-				 loff_t pos, unsigned len)
+				 loff_t pos, unsigned len,
+				 bool inode_locked)
 {
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
 	struct bch2_folio_reservation res;
@@ -835,6 +836,15 @@ static int __bch2_buffered_write(struct bch_inode_info *inode,
 
 	BUG_ON(!fs.nr);
 
+	/*
+	 * If we're not using the inode lock, we need to lock all the folios for
+	 * atomiticity of writes vs. other writes:
+	 */
+	if (!inode_locked && folio_end_pos(darray_last(fs)) < end) {
+		ret = -BCH_ERR_need_inode_lock;
+		goto out;
+	}
+
 	f = darray_first(fs);
 	if (pos != folio_pos(f) && !folio_test_uptodate(f)) {
 		ret = bch2_read_single_folio(f, mapping);
@@ -929,8 +939,10 @@ static int __bch2_buffered_write(struct bch_inode_info *inode,
 	end = pos + copied;
 
 	spin_lock(&inode->v.i_lock);
-	if (end > inode->v.i_size)
+	if (end > inode->v.i_size) {
+		BUG_ON(!inode_locked);
 		i_size_write(&inode->v, end);
+	}
 	spin_unlock(&inode->v.i_lock);
 
 	f_pos = pos;
@@ -974,9 +986,61 @@ static ssize_t bch2_buffered_write(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct bch_inode_info *inode = file_bch_inode(file);
-	loff_t pos = iocb->ki_pos;
-	ssize_t written = 0;
-	int ret = 0;
+	loff_t pos;
+	bool inode_locked = false;
+	ssize_t written = 0, written2 = 0, ret = 0;
+
+	/*
+	 * We don't take the inode lock unless i_size will be changing. Folio
+	 * locks provide exclusion with other writes, and the pagecache add lock
+	 * provides exclusion with truncate and hole punching.
+	 *
+	 * There is one nasty corner case where atomicity would be broken
+	 * without great care: when copying data from userspace to the page
+	 * cache, we do that with faults disable - a page fault would recurse
+	 * back into the filesystem, taking filesystem locks again, and
+	 * deadlock; so it's done with faults disabled, and we fault in the user
+	 * buffer when we aren't holding locks.
+	 *
+	 * If we do part of the write, but we then race and in the userspace
+	 * buffer have been evicted and are no longer resident, then we have to
+	 * drop our folio locks to re-fault them in, breaking write atomicity.
+	 *
+	 * To fix this, we restart the write from the start, if we weren't
+	 * holding the inode lock.
+	 *
+	 * There is another wrinkle after that; if we restart the write from the
+	 * start, and then get an unrecoverable error, we _cannot_ claim to
+	 * userspace that we did not write data we actually did - so we must
+	 * track (written2) the most we ever wrote.
+	 */
+
+	if ((iocb->ki_flags & IOCB_APPEND) ||
+	    (iocb->ki_pos + iov_iter_count(iter) > i_size_read(&inode->v))) {
+		inode_lock(&inode->v);
+		inode_locked = true;
+	}
+
+	ret = generic_write_checks(iocb, iter);
+	if (ret <= 0)
+		goto unlock;
+
+	ret = file_remove_privs_flags(file, !inode_locked ? IOCB_NOWAIT : 0);
+	if (ret) {
+		if (!inode_locked) {
+			inode_lock(&inode->v);
+			inode_locked = true;
+			ret = file_remove_privs_flags(file, 0);
+		}
+		if (ret)
+			goto unlock;
+	}
+
+	ret = file_update_time(file);
+	if (ret)
+		goto unlock;
+
+	pos = iocb->ki_pos;
 
 	bch2_pagecache_add_get(inode);
 
@@ -1004,12 +1068,17 @@ static ssize_t bch2_buffered_write(struct kiocb *iocb, struct iov_iter *iter)
 			}
 		}
 
+		if (unlikely(bytes != iov_iter_count(iter) && !inode_locked))
+			goto get_inode_lock;
+
 		if (unlikely(fatal_signal_pending(current))) {
 			ret = -EINTR;
 			break;
 		}
 
-		ret = __bch2_buffered_write(inode, mapping, iter, pos, bytes);
+		ret = __bch2_buffered_write(inode, mapping, iter, pos, bytes, inode_locked);
+		if (ret == -BCH_ERR_need_inode_lock)
+			goto get_inode_lock;
 		if (unlikely(ret < 0))
 			break;
 
@@ -1030,50 +1099,46 @@ static ssize_t bch2_buffered_write(struct kiocb *iocb, struct iov_iter *iter)
 		}
 		pos += ret;
 		written += ret;
+		written2 = max(written, written2);
+
+		if (ret != bytes && !inode_locked)
+			goto get_inode_lock;
 		ret = 0;
 
 		balance_dirty_pages_ratelimited(mapping);
-	} while (iov_iter_count(iter));
 
+		if (0) {
+get_inode_lock:
+			bch2_pagecache_add_put(inode);
+			inode_lock(&inode->v);
+			inode_locked = true;
+			bch2_pagecache_add_get(inode);
+
+			iov_iter_revert(iter, written);
+			pos -= written;
+			written = 0;
+			ret = 0;
+		}
+	} while (iov_iter_count(iter));
 	bch2_pagecache_add_put(inode);
+unlock:
+	if (inode_locked)
+		inode_unlock(&inode->v);
+
+	iocb->ki_pos += written;
 
-	return written ? written : ret;
+	ret = max(written, written2) ?: ret;
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
 }
 
-ssize_t bch2_write_iter(struct kiocb *iocb, struct iov_iter *from)
+ssize_t bch2_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct file *file = iocb->ki_filp;
-	struct bch_inode_info *inode = file_bch_inode(file);
-	ssize_t ret;
-
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		ret = bch2_direct_write(iocb, from);
-		goto out;
-	}
-
-	inode_lock(&inode->v);
-
-	ret = generic_write_checks(iocb, from);
-	if (ret <= 0)
-		goto unlock;
-
-	ret = file_remove_privs(file);
-	if (ret)
-		goto unlock;
-
-	ret = file_update_time(file);
-	if (ret)
-		goto unlock;
-
-	ret = bch2_buffered_write(iocb, from);
-	if (likely(ret > 0))
-		iocb->ki_pos += ret;
-unlock:
-	inode_unlock(&inode->v);
+	ssize_t ret = iocb->ki_flags & IOCB_DIRECT
+		? bch2_direct_write(iocb, iter)
+		: bch2_buffered_write(iocb, iter);
 
-	if (ret > 0)
-		ret = generic_write_sync(iocb, ret);
-out:
 	return bch2_err_class(ret);
 }
 
-- 
2.43.0


