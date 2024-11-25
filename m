Return-Path: <linux-fsdevel+bounces-35849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173D9D8E43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5DD289F8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498EA18F2D8;
	Mon, 25 Nov 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSaup8nv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB21CB53D
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572361; cv=none; b=SujD3z2a4BLsoIYbHMlyFG/g0iBTHGsTqLEvHldkv05jEQwigJb/s7t8tvNxcU5IgSM2JAA4coVbiSQ73jcfnOiAI2Fshg0VMbJ9jmmHaZY+jwCrP2izLhMWICCOKx2JzWJr/2sWwQGu6i0XyLqQRGVd67RtbRbRnWzxw06g6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572361; c=relaxed/simple;
	bh=gkXf2rxAgUWgLpG9YtYvwwSiwksZJPdaaUCjkT/OSX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXoDO3GE1+xw5C1sb0riT5k2+A5u/g1g+/uHYuL7TnhtCnBcK8hGQ5uSABDom6O95Wf5E5IO6rJMc+wLrSbY18css/xO/1WPvW3+04eFAfNG3Bib70A5xq03SIzWwyqe6ujt22ivsNq0OPfytk/3rbCy0m5ZO/IhtVJ7/xB1+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSaup8nv; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6eebc318242so46545387b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572358; x=1733177158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcqeZbj2IHRrLamWOAuVt7wG7NS7XnKDaZ6q5yDmoqQ=;
        b=iSaup8nvQZgHx9RqMJUyZZZNNKrC9MuJA8xlZBRzEFyBP26uS/p/E5vLR5E0n+ein2
         bGncIYGB0Jzy6tG3jgP6pd/xo7eLlMoAR4ehShvATCjw+pgS/v5Ysb8G75tX/8pnwDWe
         2w3gTOk3zO8vK6nUjNti/FXJb+JPt7aQNXLxbURukO0vJiSHNDdzxWL6WgwFPcPziIEW
         oK35DnVlSYHM89mPWdfh/g4YR73AXHOkHR62Hovlo+/MMp4H1+QycTInaYBvfdSjiwTk
         w1ROjSAVykqRdBuPnRAPcrSVkobLtTXyfR9ig3SGQjAURYAOtQ/R4U0mfzskcsyXKal1
         xyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572358; x=1733177158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcqeZbj2IHRrLamWOAuVt7wG7NS7XnKDaZ6q5yDmoqQ=;
        b=X9YepFs7BiCle5bapUcCRLaNMEEXLdwf+dvVLsqG9uQEDTEI80OZN9wBdkG6KsCb5k
         plSv89E5BRkb0HHew+NBa+F6AfTz1C+yPw4KKNXDwdPaBUtcsCojPCBLK9mlMdP/edbV
         ftaHZI7icMniHwiVge7/ZYdvinDViueZiSDKa7d//LG++kDZbU5E/CvbLAAMhQAX4VnG
         smcaz/+5SUq3kptaKoBqO5ygMOJfdJT6EWsA4W7aCi/I65NYj8q+qcE3aCuFWP7F23s5
         KS6XaaGb7vWDg030DGw8qL2miMNvtyXjfJWrOlM5CCnTV+R8EcXU+gU7v0r0otxxqPjH
         LjCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbIWBs2eKP1vRXgoi7hCLQPYdC5Ju0Qiy3FIHgHlLeG0QOQ1EsOJjQPbZgDJrsRu6bKqLD8JMfZQtocjCL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KvYLWENgkl9bgD71mgYb419XESbBT/f0PjofpwDHsH228U0E
	Kya8/uxuZ7Zt//wXc9evVx7d+UyIUHxRO5mMtrYSaSRHtR/e6wwJ
X-Gm-Gg: ASbGnct5LAVecHHhMtZUV2TeaLMCRkDDgUp5gmIRVYXYz2cs2zDvL5+B5P+7E5MCLuZ
	LUV9hV8RSiSy6nm/lbz18w+aVyaGVu775SzrxvDy+FWhmjoPjyN+/BKWaONjxyoSO+4K9XbFr0K
	33gb07g5JfXMTxYMFEOgeLOpJAbuZhfLuUN3D1njysF1aBQkRwgu7UdJaD+KB7ooX98HFUWJBPY
	i+l7rs0NncQY4TwnhtD/2fnvSOuRLQsL0p7uvhEA3Mha0BNVS/oPSdRK7EuUYOQy+wp9SHWs8i5
	eKYAvDGY
X-Google-Smtp-Source: AGHT+IEyBCNjY1o6WqaXfsN5POdEvlhmCojp0inhS/BnfP5dA0Xl19YaDhEFDavFsgpm+u4mHIYkpw==
X-Received: by 2002:a05:690c:45c6:b0:6e5:cb46:4641 with SMTP id 00721157ae682-6eee08d1dacmr131740587b3.13.1732572357888;
        Mon, 25 Nov 2024 14:05:57 -0800 (PST)
Received: from localhost (fwdproxy-nha-009.fbsv.net. [2a03:2880:25ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee308a25bsm19097397b3.110.2024.11.25.14.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:05:57 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 01/12] fuse: support copying large folios
Date: Mon, 25 Nov 2024 14:05:26 -0800
Message-ID: <20241125220537.3663725-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
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
---
 fs/fuse/dev.c | 86 ++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 49 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 29fc61a072ba..4a09c41910d7 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -703,7 +703,7 @@ struct fuse_copy_state {
 	struct page *pg;
 	unsigned len;
 	unsigned offset;
-	unsigned move_pages:1;
+	unsigned move_folios:1;
 };
 
 static void fuse_copy_init(struct fuse_copy_state *cs, int write,
@@ -836,10 +836,10 @@ static int fuse_check_folio(struct folio *folio)
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
 
@@ -860,7 +860,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	cs->pipebufs++;
 	cs->nr_segs--;
 
-	if (cs->len != PAGE_SIZE)
+	if (cs->len != folio_size(oldfolio))
 		goto out_fallback;
 
 	if (!pipe_buf_try_steal(cs->pipe, buf))
@@ -906,7 +906,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (test_bit(FR_ABORTED, &cs->req->flags))
 		err = -ENOENT;
 	else
-		*pagep = &newfolio->page;
+		*foliop = newfolio;
 	spin_unlock(&cs->req->waitq.lock);
 
 	if (err) {
@@ -939,8 +939,8 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	goto out_put_old;
 }
 
-static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
-			 unsigned offset, unsigned count)
+static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
+			  unsigned offset, unsigned count)
 {
 	struct pipe_buffer *buf;
 	int err;
@@ -948,17 +948,17 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
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
 
@@ -970,20 +970,21 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
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
@@ -993,12 +994,12 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
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
@@ -1007,22 +1008,22 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
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
@@ -1032,23 +1033,12 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
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
@@ -1078,7 +1068,7 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
 		if (i == numargs - 1 && argpages)
-			err = fuse_copy_pages(cs, arg->size, zeroing);
+			err = fuse_copy_folios(cs, arg->size, zeroing);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1665,7 +1655,6 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	num = outarg.size;
 	while (num) {
 		struct folio *folio;
-		struct page *page;
 		unsigned int this_num;
 
 		folio = filemap_grab_folio(mapping, index);
@@ -1673,9 +1662,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		page = &folio->page;
 		this_num = min_t(unsigned, num, folio_size(folio) - offset);
-		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
 		    (this_num == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, this_num, folio_size(folio));
@@ -1902,8 +1890,8 @@ static int fuse_notify_resend(struct fuse_conn *fc)
 static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		       unsigned int size, struct fuse_copy_state *cs)
 {
-	/* Don't try to move pages (yet) */
-	cs->move_pages = 0;
+	/* Don't try to move folios (yet) */
+	cs->move_folios = 0;
 
 	switch (code) {
 	case FUSE_NOTIFY_POLL:
@@ -2044,7 +2032,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	spin_unlock(&fpq->lock);
 	cs->req = req;
 	if (!req->args->page_replace)
-		cs->move_pages = 0;
+		cs->move_folios = 0;
 
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
@@ -2163,7 +2151,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	cs.pipe = pipe;
 
 	if (flags & SPLICE_F_MOVE)
-		cs.move_pages = 1;
+		cs.move_folios = 1;
 
 	ret = fuse_dev_do_write(fud, &cs, len);
 
-- 
2.43.5


