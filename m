Return-Path: <linux-fsdevel+bounces-47424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B1A9D68D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B490924AB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0689189B8C;
	Sat, 26 Apr 2025 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFNcd/A8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F435185B4C
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626209; cv=none; b=sZYsV4B3+75kbTaS/O+FAngCAj77ov1XLN6FRewx9f452u0COpNdg9+u5jsn5JQW3fs6wLRVbzIX0OzgoG+Zx2+BDZc0V0WkdHRQHtaZES6UtEwZHD/bH6NQNRR0h/jaFDsskADmvOyXfGi5edAb2RdkRJMaVO4YzI1gswIbhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626209; c=relaxed/simple;
	bh=MUV6lxjHBuWpRR9ZyKVL1n46DrzmhnPol4YIlVrWEk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suDTuYncHho9aZ0OPczKrNe3NF4UPOY2ispA9GDM0w3BNKQxBcujc/XjRZOufnvRwC3ngtRW+YmAUOuXsfqIS1WUDndj4poV8AeAo3qDRZ30J5lXLXDj0BAg0rIdy/0hfeh50y+6w3DOQyv9SjOAOAmT03CzGQFWao/yZuK8OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFNcd/A8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22c33ac23edso28251485ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626206; x=1746231006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nD/Zdi98YhjrJMoWz7zEUuKlsqpbt1q6mEN/WcCF40=;
        b=DFNcd/A8jKbnXbEExbbFE6ocS4mH/pvygs6w3+8W+7krCjZ3c9mn8j+A7URMmFN3S1
         AQ559f0faUQcRvETMifQDaNAZeGpFOlirmGIVekM21XbqwT/SmhUjthxyPPxgbb3whPZ
         6sAURGMMfftfrLANZzHsu/EIBa8REOxXKpudbGcTPxydsl4EfoCeJFmqS/pXc2saROqA
         HGkzwAsu6fld90/oqmuwZt3gzt3IqohjyOgBbIREx5XthTc/7Q49HTseC9OsbxVTE8Xi
         r5p0BkHJVv0slciGMTKew0/tJGa+GUpPI2KKbVFlmeWI+aAsE1z62IoFxP18OOxV8HcI
         mmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626207; x=1746231007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nD/Zdi98YhjrJMoWz7zEUuKlsqpbt1q6mEN/WcCF40=;
        b=YuOdT3PvJ3StkkPJHcekJHWAMUz5Oj/0UTVYECUscbWkGQmQfR7u4BJMLzbOFxJLNw
         +DKqW9fjOF+qaZqxjD4OMjZl71edPDJcRPcQYKZvT03kGIKEOfUAn/lbrP5ma5aIO/SS
         0ZPEz4Tz0lK02DJsxB/F6wxXYJnDJZg1sOgqCwS77/MlN6sLyA4E1H3zbTaZg7VUtBaD
         EL7K3qDmJfv/kZrP9Z1/qi2RQ9D+4FNpMBv/9W927HozXCt9bHr9nHc/MASevgXP/WAZ
         jpeOMhaCeRfhiWgyJxb9ZTXk/daI/J7pd20VU/l4R4ck80IuErliQBBSvina2K3PJ97h
         DiKQ==
X-Gm-Message-State: AOJu0YxxJas7JOENh+1Xmghv2cY+OTc38Z8VJdbvGmKQpDSbiAK1YAXb
	4BsT0kGfl8ekhp4AH2JEdo/bgYygS9aY1HxghDH/hEBrdTdDQZ5F
X-Gm-Gg: ASbGncuag9jtaydLGRMCUD+8jKEelfx1KZoK4AC1YarwXFAzo6PpSsSYSDnw6p8nDyh
	6Kxj9lKViyu4VPj1aRy7QNsik6DjBGMNr4UPSvzrSS16M090If/0eBPeF5UvRwbQoCITXdv6WDN
	9nKcwN6nPDbNKKKKYWNNk6VkFUS86N5vIcBqlFDtNJUbw6qy8psOxE13a54DhxS9rx0xargD1yv
	fGk5jOE3InEu4Pw3h+bKaeQ6JvVU6EbNgk5PFfXBre2VXjSpqL2lTPmdgGLjhl6f3o2/8i1ssJd
	QfgtLIFHGgtnr1rFEpezEfiy7MIUb8yOUcac
X-Google-Smtp-Source: AGHT+IFQH8uBJJvVkvYq7nKyJRRoYIT1+9m9hyYiItVa2/WeO5nxwkgABDkZ4T+MAsPihXbIH1ALew==
X-Received: by 2002:a17:903:1a23:b0:223:5a6e:b20 with SMTP id d9443c01a7336-22dbf4db4b2mr54075795ad.7.1745626206536;
        Fri, 25 Apr 2025 17:10:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77ee3sm38974635ad.2.2025.04.25.17.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 01/11] fuse: support copying large folios
Date: Fri, 25 Apr 2025 17:08:18 -0700
Message-ID: <20250426000828.3216220-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
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


