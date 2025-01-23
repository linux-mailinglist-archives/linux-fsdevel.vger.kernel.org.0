Return-Path: <linux-fsdevel+bounces-39890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BFDA19C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF1316A6E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE371DFDE;
	Thu, 23 Jan 2025 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgOeweaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300D179A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595689; cv=none; b=nmEbzgVIgU+K3d201gxxDEZY1V8Q78XyMzLzM0dbkLilaDY21m71sJgM3S6pP29kBRNBBhooFoz9sWUwXjucmAISWvc7vEZcUKvY9L6iH2JKUfJsQgT6mPtoLOjW7gHGwjxxQTzckDd28g9x9Nuk9oe5H467dNHdwHXbuea3ghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595689; c=relaxed/simple;
	bh=OWe64HfZ2ftARSHz6BUT+hjwEWKQD61ygR5fkgMwFoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkoW/7Ocz4I/d5lqitRXh1XOTnDX913TJQ6Q83oEWt0okMNaNwGWPSfzgFw/3Rb6MfM+32YzI+/BWsS5bQ0+StOrw8b2fTx3vGkhDkWevUKk5YoRj6GkF68uSNnv0rdYdEsWJFcoydLQKkn3Um8Q0JU3IOjItiPM1lC0hHPkv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgOeweaj; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so635349276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595686; x=1738200486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxCl8MojXvj3P2c4b2xfp90qWfRDrarz85KWuS2ZNCo=;
        b=YgOeweaji/DWU5mo/9SkgYsTbD0yoQOL+BSOn+Rq0WU1tGOB8LKqoN9tOaEseILWJK
         rGrb4DILznkGnK0ADrZUWNTwEpO+hfh6gfqE/Kj9io6eY0pGqLd1AyRIYxV9w4TJUYpY
         XjWT6qJof97z2kOg+Nk3LnUBE6lCkLxJHTaEHelC2l7b2uIcr5V91H7q3F9ZRKyjX/T3
         x5Y5BOzisL8csitw1a0PwriWuMcZ2fBXE0YMrbBlmNEgB1hBpXwcbqwXvVQ/df/O8F41
         vFZfQnlbCpybMUgsTgWun6VhwRxNcDVwiPRO3UVDJ3GJjbEB3ToMzvraIW5ZL60YwlbF
         4gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595686; x=1738200486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxCl8MojXvj3P2c4b2xfp90qWfRDrarz85KWuS2ZNCo=;
        b=Ko0y3e7mV/H3VdbYG2Hgu0GDhahaZqu5sVkgd9mLQgiLvUrhnGawFBvDZA5fLpRZAL
         2FFpjFKjPKH9h9YowVddSo+eSPcsCQPkFINXu447B9s/hb8KqGGkVOGOeAz/wquULOuP
         5vrqYvhEJECcqyzdb732a0MwGabZVhXknJaM/2zRBjF8jAm0qiZZfr5L7TgAEOGYJT6j
         VZ3JxEpVUQPQYxmdw8G6ukespz75q7oXoVWY/XJBriVdPtvGTMZMRJA6jBttmTl55l+s
         xAooK7We9FSkTlgtSVC+P8Y1O6Tjavmp/reVkIahk2ePryTwoYkin0JJiu3f9H1aFDd1
         layA==
X-Forwarded-Encrypted: i=1; AJvYcCWFD9R8xlRhKgc55s0Ft1pmgzA/t0gMCT/x1cggwkJJRrJFtkMm05GttrEiYlKLr4e8XG0kbGTuICpfTb6R@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdMTc4ugrrArg1brOUWquKDznnZnsVxnOh7/iM0oF3G2pRWa5
	HsmLFVPayw6jae0OZYjg3lqXeQttgEXoU1vc0ep91XYCexW7QI+t
X-Gm-Gg: ASbGncv3HVI9qyT4R9Gd3VS3CQEEh1SeWyuUy+bFzXch0MGJLX+zABAOs1dHCfHXsNu
	7Riy1SFoq+526l4wtzzE4CxruofZjF7ZK/5Blc/AIqvIw+tCRa6ubrxtaH552YCiKp9t6WrQtEv
	rsBn6iqmm6hbodT85aTdZswUzhmUTildZNtjfpyh9C43Zadfs7MtJ4Y+iyRWjCxvJlU/jKIebMo
	PMkIyD43WZ0y21//IY0qhwF1C4mFYWK9YV+PhzM/D4d8Bbwmgv6Kj595V5xPwmZHeJEwVLyduZE
	tUE=
X-Google-Smtp-Source: AGHT+IEpyJVr9RGfLSHSctyq1c0KojZx35UeVhe7rSuTqAieubngoqQn6aCBos9mfCEFbimFpAr44A==
X-Received: by 2002:a05:690c:6383:b0:6f6:d01c:af1f with SMTP id 00721157ae682-6f6eb6645c6mr186005637b3.16.1737595686281;
        Wed, 22 Jan 2025 17:28:06 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63fd35asm22943257b3.38.2025.01.22.17.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:05 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 01/10] fuse: support copying large folios
Date: Wed, 22 Jan 2025 17:24:39 -0800
Message-ID: <20250123012448.2479372-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, all folios associated with fuse are one page size. As part of
the work to enable large folios, this commit adds support for copying
to/from folios larger than one page size.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dev.c        | 84 +++++++++++++++++++-------------------------
 fs/fuse/fuse_dev_i.h |  2 +-
 2 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5b5f789b37eb..61f8e7d0b8b1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -838,10 +838,10 @@ static int fuse_check_folio(struct folio *folio)
 	return 0;
 }
 
-static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
+static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop)
 {
 	int err;
-	struct folio *oldfolio = page_folio(*pagep);
+	struct folio *oldfolio = *foliop;
 	struct folio *newfolio;
 	struct pipe_buffer *buf = cs->pipebufs;
 
@@ -862,7 +862,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	cs->pipebufs++;
 	cs->nr_segs--;
 
-	if (cs->len != PAGE_SIZE)
+	if (cs->len != folio_size(oldfolio))
 		goto out_fallback;
 
 	if (!pipe_buf_try_steal(cs->pipe, buf))
@@ -908,7 +908,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (test_bit(FR_ABORTED, &cs->req->flags))
 		err = -ENOENT;
 	else
-		*pagep = &newfolio->page;
+		*foliop = newfolio;
 	spin_unlock(&cs->req->waitq.lock);
 
 	if (err) {
@@ -941,8 +941,8 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	goto out_put_old;
 }
 
-static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
-			 unsigned offset, unsigned count)
+static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
+			  unsigned offset, unsigned count)
 {
 	struct pipe_buffer *buf;
 	int err;
@@ -950,17 +950,17 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
 	if (cs->nr_segs >= cs->pipe->max_usage)
 		return -EIO;
 
-	get_page(page);
+	folio_get(folio);
 	err = unlock_request(cs->req);
 	if (err) {
-		put_page(page);
+		folio_put(folio);
 		return err;
 	}
 
 	fuse_copy_finish(cs);
 
 	buf = cs->pipebufs;
-	buf->page = page;
+	buf->page = &folio->page;
 	buf->offset = offset;
 	buf->len = count;
 
@@ -972,20 +972,21 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
 }
 
 /*
- * Copy a page in the request to/from the userspace buffer.  Must be
+ * Copy a folio in the request to/from the userspace buffer.  Must be
  * done atomically
  */
-static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
-			  unsigned offset, unsigned count, int zeroing)
+static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
+			   unsigned offset, unsigned count, int zeroing)
 {
 	int err;
-	struct page *page = *pagep;
+	struct folio *folio = *foliop;
+	size_t size = folio_size(folio);
 
-	if (page && zeroing && count < PAGE_SIZE)
-		clear_highpage(page);
+	if (folio && zeroing && count < size)
+		folio_zero_range(folio, 0, size);
 
 	while (count) {
-		if (cs->write && cs->pipebufs && page) {
+		if (cs->write && cs->pipebufs && folio) {
 			/*
 			 * Can't control lifetime of pipe buffers, so always
 			 * copy user pages.
@@ -995,12 +996,12 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
 				if (err)
 					return err;
 			} else {
-				return fuse_ref_page(cs, page, offset, count);
+				return fuse_ref_folio(cs, folio, offset, count);
 			}
 		} else if (!cs->len) {
-			if (cs->move_pages && page &&
-			    offset == 0 && count == PAGE_SIZE) {
-				err = fuse_try_move_page(cs, pagep);
+			if (cs->move_folios && folio &&
+			    offset == 0 && count == folio_size(folio)) {
+				err = fuse_try_move_folio(cs, foliop);
 				if (err <= 0)
 					return err;
 			} else {
@@ -1009,22 +1010,22 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
 					return err;
 			}
 		}
-		if (page) {
-			void *mapaddr = kmap_local_page(page);
-			void *buf = mapaddr + offset;
+		if (folio) {
+			void *mapaddr = kmap_local_folio(folio, offset);
+			void *buf = mapaddr;
 			offset += fuse_copy_do(cs, &buf, &count);
 			kunmap_local(mapaddr);
 		} else
 			offset += fuse_copy_do(cs, NULL, &count);
 	}
-	if (page && !cs->write)
-		flush_dcache_page(page);
+	if (folio && !cs->write)
+		flush_dcache_folio(folio);
 	return 0;
 }
 
-/* Copy pages in the request to/from userspace buffer */
-static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
-			   int zeroing)
+/* Copy folios in the request to/from userspace buffer */
+static int fuse_copy_folios(struct fuse_copy_state *cs, unsigned nbytes,
+			    int zeroing)
 {
 	unsigned i;
 	struct fuse_req *req = cs->req;
@@ -1034,23 +1035,12 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
 		int err;
 		unsigned int offset = ap->descs[i].offset;
 		unsigned int count = min(nbytes, ap->descs[i].length);
-		struct page *orig, *pagep;
-
-		orig = pagep = &ap->folios[i]->page;
 
-		err = fuse_copy_page(cs, &pagep, offset, count, zeroing);
+		err = fuse_copy_folio(cs, &ap->folios[i], offset, count, zeroing);
 		if (err)
 			return err;
 
 		nbytes -= count;
-
-		/*
-		 *  fuse_copy_page may have moved a page from a pipe instead of
-		 *  copying into our given page, so update the folios if it was
-		 *  replaced.
-		 */
-		if (pagep != orig)
-			ap->folios[i] = page_folio(pagep);
 	}
 	return 0;
 }
@@ -1080,7 +1070,7 @@ int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
 		if (i == numargs - 1 && argpages)
-			err = fuse_copy_pages(cs, arg->size, zeroing);
+			err = fuse_copy_folios(cs, arg->size, zeroing);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1667,7 +1657,6 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	num = outarg.size;
 	while (num) {
 		struct folio *folio;
-		struct page *page;
 		unsigned int this_num;
 
 		folio = filemap_grab_folio(mapping, index);
@@ -1675,9 +1664,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		page = &folio->page;
 		this_num = min_t(unsigned, num, folio_size(folio) - offset);
-		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
 		    (this_num == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, this_num, folio_size(folio));
@@ -1905,8 +1893,8 @@ static int fuse_notify_resend(struct fuse_conn *fc)
 static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		       unsigned int size, struct fuse_copy_state *cs)
 {
-	/* Don't try to move pages (yet) */
-	cs->move_pages = 0;
+	/* Don't try to move folios (yet) */
+	cs->move_folios = 0;
 
 	switch (code) {
 	case FUSE_NOTIFY_POLL:
@@ -2054,7 +2042,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	spin_unlock(&fpq->lock);
 	cs->req = req;
 	if (!req->args->page_replace)
-		cs->move_pages = 0;
+		cs->move_folios = 0;
 
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
@@ -2173,7 +2161,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	cs.pipe = pipe;
 
 	if (flags & SPLICE_F_MOVE)
-		cs.move_pages = 1;
+		cs.move_folios = 1;
 
 	ret = fuse_dev_do_write(fud, &cs, len);
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 429661ae0654..1ddd109c2c0b 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -31,7 +31,7 @@ struct fuse_copy_state {
 	struct page *pg;
 	unsigned int len;
 	unsigned int offset;
-	unsigned int move_pages:1;
+	unsigned int move_folios:1;
 	unsigned int is_uring:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */
-- 
2.43.5


