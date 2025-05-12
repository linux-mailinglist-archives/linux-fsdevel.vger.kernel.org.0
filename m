Return-Path: <linux-fsdevel+bounces-48776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FEFAB47B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 00:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EF33AF375
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0929A336;
	Mon, 12 May 2025 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCvTVuhO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04B29992B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090770; cv=none; b=U/yLTNJQe4FNL2vuJfwdzn52mhJbqkqB5Sxi+Zrr2Iw5bmWFuAg4NJYhPtXLSTow8R59r7+bqaGz3LMU89ODH8XgPlcI4UVhpcBRQkfzqZ9m1x1HenBDqR5Mba01LGm1nuERHm/XXR+fHLb9LdtCtoUA7rrOmukR6XleGHYEuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090770; c=relaxed/simple;
	bh=ZFIs9TANO6txE7h3eTndqOmb58uTtuU6Pipv79xsK/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea0KW+9A74Yqrb0R9SU3N4I9ToJdlxAInVgTT6VAv/CJnrGnWk1CTLAA0MThVCKSpbRMY3fx9VPT3X3L9g4Ljc/lNf9X9n5+oL9E0tSUVfsUT5vZWYGQ5X4Z0LHbYyqUi+iiPRwhxov1lw/G1Apqq5CjIdx/yfmVNEqcd8ZRsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCvTVuhO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73712952e1cso4966217b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090768; x=1747695568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+Y8kSHlC929nU5hCO9UX3QniRQ0FKWZldzFODnsRb8=;
        b=mCvTVuhOj3Vj0fbP+qsin6IVjSnm1W873jvsRkRBuHhIIYRnW3+JFrnVsugJUZrVkE
         vabj+rUWk5xNV9iKeFQvdM8zyfLGZmGXOtAgKCJAPOJ0cnSVXHRvJsvslR+9fVZrJkG3
         5bUClVbwZIdfrn6S8VbZ6LxtyGF3xWI/MwFOSWf5Tecq9kEb9HFPF4Fv8D8fVGz+86Rb
         3jK5p1BkXK2vKEYqGkgOeFTL561VMo7P2O9M7Lmag5Ka64FJrezI/eOkGPd48JEk+EIE
         vF2y8oeiYlgzewmY7q6Yw301hlwjIrCuQiOLAR6ipsCcMT4eOz7yrnhICzBkM0BMUGpI
         4ZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090768; x=1747695568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+Y8kSHlC929nU5hCO9UX3QniRQ0FKWZldzFODnsRb8=;
        b=bS+MUYYIRH3l/mFL/Hsw4izuMY5+rmODFKvhqNEmifF9xT4ZQBns0B43oMuZythxl5
         +86BwmRIZCdp1x5V8x0UFAaVag1y5aU8z/vEcTHqKo7hPfY6hTRuqD5PoviL68cwUX9t
         cN7GXmPk2rzqiBL5XeWNcJ4RNiOEohOFsO+iuhJQfrCO6VbSMLnlcCXEfKyLGWk3gOKq
         q1T+vuygvbkWG09+SbPN3dBsnNTDNveNQhcN9ozs1EE9aEBadwx0X3QzwvVhsKsoezFj
         tiBymP2eSmDcDpJHAwK6PFQJ8ggLc47fQqvv1xgR6HezBTg1UoDkF2T1KqPjKNbuRrNN
         2/5A==
X-Gm-Message-State: AOJu0Ywxcy+QEBfwc40JT/qLtBKeCT9+fUM4ocY7Fq5QgvCGb9m95/pi
	jT88WtM+wInUrGMA8ndNeekqwvm7UacJlwfjG0l1s2mzrxwXTCjs
X-Gm-Gg: ASbGncsbBAZwl2VfC7h6nPp6SxSyrvF+R5tZl7tv+RR8LTKpo4yJDz9NT/0wdcxt+be
	q7hu+C09tDQwC78+PuSuAmHTGO3LnCJGcp/qQ+FsTCVdIDrO0g5CrrO5WP4WSCLib9UfuZGg1jM
	m6y9nAss7879eW1pG7ZvsypwcyQ0kO5ltZTA6OJWMr7ups+t/9HYgw/tWt7QTJsqOiOhCXJV7Mx
	pTi/kWQRs8GjUZWsEN7pmS0+NU91S1FHje3fr+9ARuXNTW6rYV9dpdyfJt6qalenR4rrvkxjEjg
	D+WFezwN0UixsmAKfd6PODfBIgtSaYmlWPQWUzhedIsnjBH5UZeORBWqEg==
X-Google-Smtp-Source: AGHT+IGmFS4J/JNoqmAqwfsF9urt1xkWr0qSU34wDk0S8CclndAJBJrZDIx6EPhdc+H+9YA5+f7hYw==
X-Received: by 2002:a05:6a00:4148:b0:736:6ac4:d204 with SMTP id d2e1a72fcca58-7423bfb6cf2mr21762629b3a.11.1747090768201;
        Mon, 12 May 2025 15:59:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237727a27sm6802379b3a.52.2025.05.12.15.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v6 01/11] fuse: support copying large folios
Date: Mon, 12 May 2025 15:58:30 -0700
Message-ID: <20250512225840.826249-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
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
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        | 84 +++++++++++++++++++-------------------------
 fs/fuse/fuse_dev_i.h |  2 +-
 2 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 155bb6aeaef5..7b0e3a394480 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -955,10 +955,10 @@ static int fuse_check_folio(struct folio *folio)
  * folio that was originally in @pagep will lose a reference and the new
  * folio returned in @pagep will carry a reference.
  */
-static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
+static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop)
 {
 	int err;
-	struct folio *oldfolio = page_folio(*pagep);
+	struct folio *oldfolio = *foliop;
 	struct folio *newfolio;
 	struct pipe_buffer *buf = cs->pipebufs;
 
@@ -979,7 +979,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	cs->pipebufs++;
 	cs->nr_segs--;
 
-	if (cs->len != PAGE_SIZE)
+	if (cs->len != folio_size(oldfolio))
 		goto out_fallback;
 
 	if (!pipe_buf_try_steal(cs->pipe, buf))
@@ -1025,7 +1025,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (test_bit(FR_ABORTED, &cs->req->flags))
 		err = -ENOENT;
 	else
-		*pagep = &newfolio->page;
+		*foliop = newfolio;
 	spin_unlock(&cs->req->waitq.lock);
 
 	if (err) {
@@ -1058,8 +1058,8 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	goto out_put_old;
 }
 
-static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
-			 unsigned offset, unsigned count)
+static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
+			  unsigned offset, unsigned count)
 {
 	struct pipe_buffer *buf;
 	int err;
@@ -1067,17 +1067,17 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
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
 
@@ -1089,20 +1089,21 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
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
@@ -1112,12 +1113,12 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
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
@@ -1126,22 +1127,22 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
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
@@ -1151,23 +1152,12 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
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
@@ -1197,7 +1187,7 @@ int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
 		if (i == numargs - 1 && argpages)
-			err = fuse_copy_pages(cs, arg->size, zeroing);
+			err = fuse_copy_folios(cs, arg->size, zeroing);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1786,7 +1776,6 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	num = outarg.size;
 	while (num) {
 		struct folio *folio;
-		struct page *page;
 		unsigned int this_num;
 
 		folio = filemap_grab_folio(mapping, index);
@@ -1794,9 +1783,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		page = &folio->page;
 		this_num = min_t(unsigned, num, folio_size(folio) - offset);
-		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
 		    (this_num == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, this_num, folio_size(folio));
@@ -2037,8 +2025,8 @@ static int fuse_notify_inc_epoch(struct fuse_conn *fc)
 static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		       unsigned int size, struct fuse_copy_state *cs)
 {
-	/* Don't try to move pages (yet) */
-	cs->move_pages = false;
+	/* Don't try to move folios (yet) */
+	cs->move_folios = false;
 
 	switch (code) {
 	case FUSE_NOTIFY_POLL:
@@ -2189,7 +2177,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	spin_unlock(&fpq->lock);
 	cs->req = req;
 	if (!req->args->page_replace)
-		cs->move_pages = false;
+		cs->move_folios = false;
 
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
@@ -2307,7 +2295,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	cs.pipe = pipe;
 
 	if (flags & SPLICE_F_MOVE)
-		cs.move_pages = true;
+		cs.move_folios = true;
 
 	ret = fuse_dev_do_write(fud, &cs, len);
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index db136e045925..5a9bd771a319 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -30,7 +30,7 @@ struct fuse_copy_state {
 	unsigned int len;
 	unsigned int offset;
 	bool write:1;
-	bool move_pages:1;
+	bool move_folios:1;
 	bool is_uring:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */
-- 
2.47.1


