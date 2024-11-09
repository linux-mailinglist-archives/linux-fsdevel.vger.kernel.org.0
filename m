Return-Path: <linux-fsdevel+bounces-34111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C689C28AB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D8F1C21BCF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35F23A9;
	Sat,  9 Nov 2024 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX602dtT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE638B
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111222; cv=none; b=P0DElMiDRk8bpkAMQqstXa9++yU+9J7IU5q3bx4AVwbborcmVJpYDDtdyRq2nkWqo/yMCpv5UbUjeUkDJblT+kgLlYjAzEdc4mBmvEJIKVzjLDgbweJtOmNHarO5mPMpqBV86hMSufpH6WkqzbMNIFnMzPsUaaLJR2y3C/rg/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111222; c=relaxed/simple;
	bh=oxBI96owzL+k/QWvEJZEpXpBIy1zja9uta3bFBBTYU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFMQBPlQ/6E6dxKP9gD9ZzYVqj6sW1Er8qMwtF479J3WPLIxwvQS4QIIw1G5zsCjY0iUAoxMslUyI9iH4gCebiJoj3i/FKqhEsZbqgGIPm6CpNpNk/y8qSsreRj4V3ryX3jEuM0iLQzMMnx+TsrzWg4FG/p1raoylcOlb06Pzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX602dtT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea339a41f1so24152537b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111219; x=1731716019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt8nHgDHQU+phYtX3o2SlCzMkHLlcfv+3OOmwThp2JY=;
        b=GX602dtT7Fai9BM3WXOs9heoyChJ6y73oX6rI2XVJvF83TTkspNyrl1Ac5M/jht1yH
         WN15iM0VxvIBolMF2b3hTRzTL8e3bbWR+C2ogT5kXSSTxpCsBDjjUpXx3Poq7hQ0QT7M
         UCcxIRmsFmBYusZgAAbknGbZ2GcR5Xm8IZazGFDw44EI1Xs3JggorGwmowfsD3cmqNZO
         /Xe1x0EBGxenz/76JuUn8R/W516+mwenXkBYcvoFhdDiNnsQ5ImRJMafGdWhldH9RLb8
         7aNo0jHMairvnajBiWx614vP/4+89/GBBMWTS3gtkSyYVgLuTVWlcET3seZI+e/kDx1k
         FAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111219; x=1731716019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt8nHgDHQU+phYtX3o2SlCzMkHLlcfv+3OOmwThp2JY=;
        b=ibQRZB3sGqehllbIz496pu3aCMfqTcB3ZUi8GBTbF0lDZqdb27hQ4GFhp40dCJv+E+
         PYzkPS/wFUEBdu6HtLTbdGFOAhMu+gzOy2a4z5dLXVdhbTV6fE3+hfzYeX1h5P6VrGmq
         IcgdGbt3xq+jq++x2khRyrEL+/a/cZp/+4/T3PPhPaezOmX9dTZSpnUT3gjFEMHmoMfz
         ROEL8n3M3bvuC1JhA/kLyxHyw5dTbU71xwndun8+Lb5wqaUqYaesI0LsLl+EUNy74NDp
         eT+7IInpajd8rEkJEQyl4+9wCTjwuoAM31jKhjHNxQM5DmNAG1BOUe9txOZ2lv5fYZzy
         LJpA==
X-Forwarded-Encrypted: i=1; AJvYcCUxMsjaab5ILF/gIQCtEmrXSmQclv8LxEI5QvsOVKGS1SCWYeX+GyJmfqf5JHuYhSMi0GwkEHuTCw4Lyrfk@vger.kernel.org
X-Gm-Message-State: AOJu0Yymu8wZIc3XJDXhkcGXxFSrGA/VTzdHWcBgbP3GIAsHgQP5lwVf
	wgzVZbdx07ul6K4mZXSKSdmUZfEngJpY+NhQkYd7C39fHrvXfX0h
X-Google-Smtp-Source: AGHT+IGFE/xglsDC0ucoGMdjR9osAIj39uPXMY5loRfUPwNaRMWFzo4rf3p0viY7zrqs+qionM/lOQ==
X-Received: by 2002:a05:690c:6902:b0:6e9:beda:5db6 with SMTP id 00721157ae682-6eadde50efamr61158887b3.29.1731111219394;
        Fri, 08 Nov 2024 16:13:39 -0800 (PST)
Received: from localhost (fwdproxy-nha-011.fbsv.net. [2a03:2880:25ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8f0c5dsm9474627b3.41.2024.11.08.16.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:39 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 01/12] fuse: support copying large folios
Date: Fri,  8 Nov 2024 16:12:47 -0800
Message-ID: <20241109001258.2216604-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
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
 fs/fuse/dev.c | 89 +++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 29fc61a072ba..9914cc1243f4 100644
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
 
@@ -970,20 +970,24 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
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
+	if (folio && zeroing && count < size) {
+		void *kaddr = kmap_local_folio(folio, 0);
+		memset(kaddr, 0, size);
+		kunmap_local(kaddr);
+	}
 
 	while (count) {
-		if (cs->write && cs->pipebufs && page) {
+		if (cs->write && cs->pipebufs && folio) {
 			/*
 			 * Can't control lifetime of pipe buffers, so always
 			 * copy user pages.
@@ -993,12 +997,12 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
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
@@ -1007,22 +1011,22 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
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
@@ -1032,23 +1036,12 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
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
@@ -1078,7 +1071,7 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
 		if (i == numargs - 1 && argpages)
-			err = fuse_copy_pages(cs, arg->size, zeroing);
+			err = fuse_copy_folios(cs, arg->size, zeroing);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1665,7 +1658,6 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	num = outarg.size;
 	while (num) {
 		struct folio *folio;
-		struct page *page;
 		unsigned int this_num;
 
 		folio = filemap_grab_folio(mapping, index);
@@ -1673,9 +1665,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		page = &folio->page;
 		this_num = min_t(unsigned, num, folio_size(folio) - offset);
-		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
 		    (this_num == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, this_num, folio_size(folio));
@@ -1902,8 +1893,8 @@ static int fuse_notify_resend(struct fuse_conn *fc)
 static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		       unsigned int size, struct fuse_copy_state *cs)
 {
-	/* Don't try to move pages (yet) */
-	cs->move_pages = 0;
+	/* Don't try to move folios (yet) */
+	cs->move_folios = 0;
 
 	switch (code) {
 	case FUSE_NOTIFY_POLL:
@@ -2044,7 +2035,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	spin_unlock(&fpq->lock);
 	cs->req = req;
 	if (!req->args->page_replace)
-		cs->move_pages = 0;
+		cs->move_folios = 0;
 
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
@@ -2163,7 +2154,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	cs.pipe = pipe;
 
 	if (flags & SPLICE_F_MOVE)
-		cs.move_pages = 1;
+		cs.move_folios = 1;
 
 	ret = fuse_dev_do_write(fud, &cs, len);
 
-- 
2.43.5


