Return-Path: <linux-fsdevel+bounces-37380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B89F1908
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7D9188F26E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F71B0F1B;
	Fri, 13 Dec 2024 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd1HiKHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E81953A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128590; cv=none; b=A1EqbvhW/fd9aGF9KKP/naxnFxrBjI9egswDc3c4NuZ3qyesjGgTuyzhzdmzWuVkniZ4fdXNDAmZDtHh0gUYmRldgxRY/nkYPFi9ogQbU5nuwbDQgP6lo+7Z9qbvjwUzUSK9V5OQECAj+x/iO9NVf0PKsxgZvv5yf2b/S2bEwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128590; c=relaxed/simple;
	bh=zx45BIQkVQk1/O6TCm1Jpk8CRdeiY8MoRxjJ+OEqvrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKNabzGzvnIe7qVf9HiyXoJs1UVhqPlM5B3HIMfIZUU+uRCcdVmXEzDvsN6jCfj63XrfOSq7UVkg0oZRXepERuYH6JC6YFvKWqAVNKnBUUB0OqJy8CGTDBwVt/thplezYNOoYlQI+rzS8eCZbMyVo+AycVvzpvRh4qW3iUaV0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd1HiKHg; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e396c98af22so1587478276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128587; x=1734733387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXxkqFnHJKbRSPssBl9tJpEWCP0BewvqeZs2upPjeWs=;
        b=jd1HiKHgWhBXG2ad8yQ+2WjnpGefH3P8HTP+St11USlCV4FjWXDey7FkvlqhBHeVsb
         mPQiJ0Uc6WirUMkt9l0Tsdgm5Pk1Sn1ZWI3udV1W9pvew+j6MG2AFGrlubQ5eTkBTsCP
         hrtdJ8gt3VG2BzD+n1xSiOIqbcElSMfndbH20o6vSuZ/9nfTfxWujrSpmsQ+MFT3kcZw
         fI2/pC5ryj+oL7jTBTL1tNtGvw5lHNE8vsW89B6lwVcPrysZiPN1nzXsMylm+av3r3BI
         kemE4PF8EWevzsEEPUscjbHWCY+874XK1AjkMdBNFsUya09CUOrvtMLF6/+tXY8AeTCN
         ieGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128587; x=1734733387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXxkqFnHJKbRSPssBl9tJpEWCP0BewvqeZs2upPjeWs=;
        b=Uj/+ikZAkv6EVHf0xJ+IxbDdkiUs43h2lh60jXmGwcGpokGA6GVkpm3N1W6Tkr6a+W
         31ewLvrk4iTiWMURHONfG3bbq0o4pPjvIK5uRWWPQ+Du5Qlsj75EBOHjB+WHyNPEWztt
         gm9vgKNhvdfD939Z388VQati/KxDByJdpet4hAbyBC2KX7rcKZWzCrb+d563H0iq9DIJ
         IGAZ7uaIf9kngS78cm8xIVBrW9orFI7n5lTXL/+TNe7nUBfii7X2Eu3SxDVHhdAcPE+F
         O1AW1dxB9K9A1hPChJIAU+xHaiLaon2X83tJi5yiUBsuceXKVF5Wr3M2dTwvNVbwmfht
         JuDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlaURRp2yC5AbaUIBf5KARrcWe4ubdgzHsC3bCrssS0pb3k4xFrAs02gn2SMmtPq4tIomTiWbGgzhBsoxx@vger.kernel.org
X-Gm-Message-State: AOJu0YwQn+BRJfxGUYCxdGrJcZ9cZSedeaDi+xE0RMi3Vd71ZvHolG7T
	UClnp4n7uZFVi3v2Llh4Mu3803Xo56u4YPvPWUxlXeRWULDx/mHt
X-Gm-Gg: ASbGncvTo7xL+0XMcolZ4pFl4336QdozeJyg80G61GvDFmynPYYFfulJHLgbmvICDxN
	C/dErDkfw8QTxf2Con03dKbySBMC1giay+CMVfJn6yTh+wD8p9S3hLnN9FAsXbbER9fzzHX/3p3
	JhWaU19/3qWV5Zwu4Hp9NRJBKtyOCRGBunPJ63OS+e0duSD0yftiNAucD7Ol///xiprCQuFqu7N
	2GU0f2tQmhYqp59XPMG3QgIGqypBKda+l/Q3sUj9yYXPggnto+ZmEnpSQw0of8PBUys5pFbJ4Hx
	C9pe3YwGxFOW08M=
X-Google-Smtp-Source: AGHT+IFpWPLSCCmjtyU0TK4DVO2VaSPGTqM7Tn3hopD/lmXQnvgw7Ki/rTD6jojv+OLGWU/7Y/AVXg==
X-Received: by 2002:a05:6902:1ac3:b0:e38:9eca:e5d8 with SMTP id 3f1490d57ef6-e4351d10058mr3874211276.47.1734128587201;
        Fri, 13 Dec 2024 14:23:07 -0800 (PST)
Received: from localhost (fwdproxy-nha-005.fbsv.net. [2a03:2880:25ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e470e54d35esm106007276.54.2024.12.13.14.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:06 -0800 (PST)
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
Subject: [PATCH v3 01/12] fuse: support copying large folios
Date: Fri, 13 Dec 2024 14:18:07 -0800
Message-ID: <20241213221818.322371-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
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
index 27ccae63495d..0a3dfb66c7cd 100644
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


