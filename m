Return-Path: <linux-fsdevel+bounces-32608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8231D9AB651
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CAC1F242FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383E1CDA23;
	Tue, 22 Oct 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcL0180M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEF1CCEE0
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623299; cv=none; b=WwX3eLLis1uYR+MvZkwIQ/rJU9Sw3IyfP2xW0wWrJAUWMXQkNViebJpZy+YVjfgdHsUP0cX1wG1U1PvMneIbCvSyMDFjMvsjJOL4YW3ficYAJdPuwH9GRvBd6e/b3WOKoIWxQnfWHpyizF70Ck4y0p2B5mc2XB/q5qPe5G7vp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623299; c=relaxed/simple;
	bh=1HaPk6EzjG7VdCSKTLuQIOpXFdsINrd32PweVP9Fvd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhuTHYVYrx4E6IY+pi2GATfg3+xMSh3dNDDCg/6OITzEhE+MGKVhNAQdLSoTABzFnvjscTnaQCGM7TqDpPAltMAJZIx8g6L6Ug6IUXZFm14+HDp5Mj9U1OLYMj15b0asuvYi56v1aDWv9zaV/6Z10bksu0lMlo2pYAh/5q4vY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcL0180M; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28833f1c31so122489276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623296; x=1730228096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0KOt5uiDqhAKm2lG1E6tmLsQZkwQMxuXKLy3i7vj9g=;
        b=bcL0180MZj6fVfiZtRbKluyNlSN6WcruUy7tmF4mcNP1aBWcLi7/1KDZ+Vxok5GETl
         +JFrxuzFb8u22bYIyL+04hBIE7OeAiziR2l1lUTrE0AyZRmsKERPuQkzaPCcD/GwSTRZ
         mo+KAVlJyc55U2DpdpqHsIWZmmbmGSpjQiK4BYpHZfdKJ2VXTIe3P9Y+PA5G70SmFBb2
         HeXLp2/WxwJXs6EFa37XJ3l/BBzHSTdGpN4A4NpiFLpje+v2yEt7r9zEzK+AFpza7aGQ
         CKKiyFW0bRlSYN3kyIaMllhL0e3hizfklDckUHO8jcvTkbWd7Rb5aK6vzJydYphzfa6l
         QhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623296; x=1730228096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0KOt5uiDqhAKm2lG1E6tmLsQZkwQMxuXKLy3i7vj9g=;
        b=Y3DR84vZUW9OOyOqmNzZVgyicje6LDA6TetuGpZBLj0vk42wDXkPdHukm2jIxjDg3N
         l5u5q0h4B20GYiyd/bitlsZ+6rD46XCOZD9eN+fFL4EJtS6bZDTJ0i5h1ctdvBKjLb5B
         nb+pmmvWYl/J22jdHmXi7S7B85my6YueFMrNZpXdVezFA4dwOc+L+rza8uihRI9dDHw4
         p72xvjxLp4m0Snx3TvakoxX9G6fEzVSJCsFc73cgIHLhd3HO153s7EgIpOyccry++ryx
         f0u/hysBjcx2W/Uf/70Zn+bTC7I5lra3Fd1obRPlwkOidrJ6K7yMKIcxf7QoL2GRwJZz
         gGTg==
X-Forwarded-Encrypted: i=1; AJvYcCXrYwdDAdo3iw3yTU8VxPUvInasHn1NAKm+2w9X8GohfFuGvJcDNOeC0qdqNGkFA7qB/3b1ryQxz5rOVuVo@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGuWJ+Meo2R4pcQw3As36GqfvBHMUXvm2Qcp6Ezk4mOvqbVku
	zif9JgJFDaoLjt/gQVeg3rV3eZefD9PNn64hI8C0ufPxYG/UQxhl
X-Google-Smtp-Source: AGHT+IHQI/fuwQt0ZneB9es37d1QrD+Zj1irxRhXOlmJBk/BoUZy9pXQKM0N5tJBhmZygwdgUWsdhw==
X-Received: by 2002:a25:8388:0:b0:e29:11c6:3c16 with SMTP id 3f1490d57ef6-e2e2458460amr4324685276.11.1729623296419;
        Tue, 22 Oct 2024 11:54:56 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4d16dsm11839157b3.35.2024.10.22.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:56 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 10/13] fuse: convert writebacks to use folios
Date: Tue, 22 Oct 2024 11:54:40 -0700
Message-ID: <20241022185443.1891563-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022185443.1891563-1-joannelkoong@gmail.com>
References: <20241022185443.1891563-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert writeback requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 126 +++++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 62 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b3d5b7b5da52..99af3c39e529 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -436,7 +436,7 @@ static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode *fi,
 		wpa = rb_entry(n, struct fuse_writepage_args, writepages_entry);
 		WARN_ON(get_fuse_inode(wpa->inode) != fi);
 		curr_index = wpa->ia.write.in.offset >> PAGE_SHIFT;
-		if (idx_from >= curr_index + wpa->ia.ap.num_pages)
+		if (idx_from >= curr_index + wpa->ia.ap.num_folios)
 			n = n->rb_right;
 		else if (idx_to < curr_index)
 			n = n->rb_left;
@@ -1837,12 +1837,12 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	if (wpa->bucket)
 		fuse_sync_bucket_dec(wpa->bucket);
 
-	for (i = 0; i < ap->num_pages; i++)
-		__free_page(ap->pages[i]);
+	for (i = 0; i < ap->num_folios; i++)
+		folio_put(ap->folios[i]);
 
 	fuse_file_put(wpa->ia.ff, false);
 
-	kfree(ap->pages);
+	kfree(ap->folios);
 	kfree(wpa);
 }
 
@@ -1862,8 +1862,8 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	int i;
 
-	for (i = 0; i < ap->num_pages; i++)
-		fuse_writepage_finish_stat(inode, page_folio(ap->pages[i]));
+	for (i = 0; i < ap->num_folios; i++)
+		fuse_writepage_finish_stat(inode, ap->folios[i]);
 
 	wake_up(&fi->page_waitq);
 }
@@ -1878,7 +1878,8 @@ __acquires(fi->lock)
 	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
 	struct fuse_write_in *inarg = &wpa->ia.write.in;
 	struct fuse_args *args = &wpa->ia.ap.args;
-	__u64 data_size = wpa->ia.ap.num_pages * PAGE_SIZE;
+	/* Currently, all folios in FUSE are one page */
+	__u64 data_size = wpa->ia.ap.num_folios * PAGE_SIZE;
 	int err;
 
 	fi->writectr++;
@@ -1919,7 +1920,7 @@ __acquires(fi->lock)
 		next = aux->next;
 		aux->next = NULL;
 		fuse_writepage_finish_stat(aux->inode,
-					   page_folio(aux->ia.ap.pages[0]));
+					   aux->ia.ap.folios[0]);
 		fuse_writepage_free(aux);
 	}
 
@@ -1954,11 +1955,11 @@ static struct fuse_writepage_args *fuse_insert_writeback(struct rb_root *root,
 						struct fuse_writepage_args *wpa)
 {
 	pgoff_t idx_from = wpa->ia.write.in.offset >> PAGE_SHIFT;
-	pgoff_t idx_to = idx_from + wpa->ia.ap.num_pages - 1;
+	pgoff_t idx_to = idx_from + wpa->ia.ap.num_folios - 1;
 	struct rb_node **p = &root->rb_node;
 	struct rb_node  *parent = NULL;
 
-	WARN_ON(!wpa->ia.ap.num_pages);
+	WARN_ON(!wpa->ia.ap.num_folios);
 	while (*p) {
 		struct fuse_writepage_args *curr;
 		pgoff_t curr_index;
@@ -1969,7 +1970,7 @@ static struct fuse_writepage_args *fuse_insert_writeback(struct rb_root *root,
 		WARN_ON(curr->inode != wpa->inode);
 		curr_index = curr->ia.write.in.offset >> PAGE_SHIFT;
 
-		if (idx_from >= curr_index + curr->ia.ap.num_pages)
+		if (idx_from >= curr_index + curr->ia.ap.num_folios)
 			p = &(*p)->rb_right;
 		else if (idx_to < curr_index)
 			p = &(*p)->rb_left;
@@ -2101,9 +2102,10 @@ static struct fuse_writepage_args *fuse_writepage_args_alloc(void)
 	wpa = kzalloc(sizeof(*wpa), GFP_NOFS);
 	if (wpa) {
 		ap = &wpa->ia.ap;
-		ap->num_pages = 0;
-		ap->pages = fuse_pages_alloc(1, GFP_NOFS, &ap->descs);
-		if (!ap->pages) {
+		ap->num_folios = 0;
+		ap->uses_folios = true;
+		ap->folios = fuse_folios_alloc(1, GFP_NOFS, &ap->folio_descs);
+		if (!ap->folios) {
 			kfree(wpa);
 			wpa = NULL;
 		}
@@ -2127,16 +2129,16 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
 }
 
 static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
-					  struct folio *tmp_folio, uint32_t page_index)
+					  struct folio *tmp_folio, uint32_t folio_index)
 {
 	struct inode *inode = folio->mapping->host;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 
 	folio_copy(tmp_folio, folio);
 
-	ap->pages[page_index] = &tmp_folio->page;
-	ap->descs[page_index].offset = 0;
-	ap->descs[page_index].length = PAGE_SIZE;
+	ap->folios[folio_index] = tmp_folio;
+	ap->folio_descs[folio_index].offset = 0;
+	ap->folio_descs[folio_index].length = PAGE_SIZE;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
@@ -2193,7 +2195,7 @@ static int fuse_writepage_locked(struct folio *folio)
 		goto err_writepage_args;
 
 	ap = &wpa->ia.ap;
-	ap->num_pages = 1;
+	ap->num_folios = 1;
 
 	folio_start_writeback(folio);
 	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, 0);
@@ -2221,32 +2223,32 @@ struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
 	struct inode *inode;
-	struct page **orig_pages;
-	unsigned int max_pages;
+	struct folio **orig_folios;
+	unsigned int max_folios;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
 {
 	struct fuse_args_pages *ap = &data->wpa->ia.ap;
 	struct fuse_conn *fc = get_fuse_conn(data->inode);
-	struct page **pages;
-	struct fuse_page_desc *descs;
-	unsigned int npages = min_t(unsigned int,
-				    max_t(unsigned int, data->max_pages * 2,
-					  FUSE_DEFAULT_MAX_PAGES_PER_REQ),
+	struct folio **folios;
+	struct fuse_folio_desc *descs;
+	unsigned int nfolios = min_t(unsigned int,
+				     max_t(unsigned int, data->max_folios * 2,
+					   FUSE_DEFAULT_MAX_PAGES_PER_REQ),
 				    fc->max_pages);
-	WARN_ON(npages <= data->max_pages);
+	WARN_ON(nfolios <= data->max_folios);
 
-	pages = fuse_pages_alloc(npages, GFP_NOFS, &descs);
-	if (!pages)
+	folios = fuse_folios_alloc(nfolios, GFP_NOFS, &descs);
+	if (!folios)
 		return false;
 
-	memcpy(pages, ap->pages, sizeof(struct page *) * ap->num_pages);
-	memcpy(descs, ap->descs, sizeof(struct fuse_page_desc) * ap->num_pages);
-	kfree(ap->pages);
-	ap->pages = pages;
-	ap->descs = descs;
-	data->max_pages = npages;
+	memcpy(folios, ap->folios, sizeof(struct folio *) * ap->num_folios);
+	memcpy(descs, ap->folio_descs, sizeof(struct fuse_folio_desc) * ap->num_folios);
+	kfree(ap->folios);
+	ap->folios = folios;
+	ap->folio_descs = descs;
+	data->max_folios = nfolios;
 
 	return true;
 }
@@ -2256,7 +2258,7 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	int num_pages = wpa->ia.ap.num_pages;
+	int num_folios = wpa->ia.ap.num_folios;
 	int i;
 
 	spin_lock(&fi->lock);
@@ -2264,8 +2266,8 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	fuse_flush_writepages(inode);
 	spin_unlock(&fi->lock);
 
-	for (i = 0; i < num_pages; i++)
-		end_page_writeback(data->orig_pages[i]);
+	for (i = 0; i < num_folios; i++)
+		folio_end_writeback(data->orig_folios[i]);
 }
 
 /*
@@ -2276,15 +2278,15 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
  * swapping the new temp page with the old one.
  */
 static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
-			       struct page *page)
+			       struct folio *folio)
 {
 	struct fuse_inode *fi = get_fuse_inode(new_wpa->inode);
 	struct fuse_writepage_args *tmp;
 	struct fuse_writepage_args *old_wpa;
 	struct fuse_args_pages *new_ap = &new_wpa->ia.ap;
 
-	WARN_ON(new_ap->num_pages != 0);
-	new_ap->num_pages = 1;
+	WARN_ON(new_ap->num_folios != 0);
+	new_ap->num_folios = 1;
 
 	spin_lock(&fi->lock);
 	old_wpa = fuse_insert_writeback(&fi->writepages, new_wpa);
@@ -2298,9 +2300,9 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 
 		WARN_ON(tmp->inode != new_wpa->inode);
 		curr_index = tmp->ia.write.in.offset >> PAGE_SHIFT;
-		if (curr_index == page->index) {
-			WARN_ON(tmp->ia.ap.num_pages != 1);
-			swap(tmp->ia.ap.pages[0], new_ap->pages[0]);
+		if (curr_index == folio->index) {
+			WARN_ON(tmp->ia.ap.num_folios != 1);
+			swap(tmp->ia.ap.folios[0], new_ap->folios[0]);
 			break;
 		}
 	}
@@ -2314,7 +2316,7 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 
 	if (tmp) {
 		fuse_writepage_finish_stat(new_wpa->inode,
-					   page_folio(new_ap->pages[0]));
+					   folio);
 		fuse_writepage_free(new_wpa);
 	}
 
@@ -2325,7 +2327,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 				     struct fuse_args_pages *ap,
 				     struct fuse_fill_wb_data *data)
 {
-	WARN_ON(!ap->num_pages);
+	WARN_ON(!ap->num_folios);
 
 	/*
 	 * Being under writeback is unlikely but possible.  For example direct
@@ -2337,19 +2339,19 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 		return true;
 
 	/* Reached max pages */
-	if (ap->num_pages == fc->max_pages)
+	if (ap->num_folios == fc->max_pages)
 		return true;
 
 	/* Reached max write bytes */
-	if ((ap->num_pages + 1) * PAGE_SIZE > fc->max_write)
+	if ((ap->num_folios + 1) * PAGE_SIZE > fc->max_write)
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_pages[ap->num_pages - 1]->index + 1 != folio_index(folio))
+	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_pages == data->max_pages && !fuse_pages_realloc(data))
+	if (ap->num_folios == data->max_folios && !fuse_pages_realloc(data))
 		return true;
 
 	return false;
@@ -2393,7 +2395,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	 * This is ensured by holding the page lock in page_mkwrite() while
 	 * checking fuse_page_is_writeback().  We already hold the page lock
 	 * since clear_page_dirty_for_io() and keep it held until we add the
-	 * request to the fi->writepages list and increment ap->num_pages.
+	 * request to the fi->writepages list and increment ap->num_folios.
 	 * After this fuse_page_is_writeback() will indicate that the page is
 	 * under writeback, so we can release the page lock.
 	 */
@@ -2405,13 +2407,13 @@ static int fuse_writepages_fill(struct folio *folio,
 			goto out_unlock;
 		}
 		fuse_file_get(wpa->ia.ff);
-		data->max_pages = 1;
+		data->max_folios = 1;
 		ap = &wpa->ia.ap;
 	}
 	folio_start_writeback(folio);
 
-	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, ap->num_pages);
-	data->orig_pages[ap->num_pages] = &folio->page;
+	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, ap->num_folios);
+	data->orig_folios[ap->num_folios] = folio;
 
 	err = 0;
 	if (data->wpa) {
@@ -2420,9 +2422,9 @@ static int fuse_writepages_fill(struct folio *folio,
 		 * fuse_page_is_writeback().
 		 */
 		spin_lock(&fi->lock);
-		ap->num_pages++;
+		ap->num_folios++;
 		spin_unlock(&fi->lock);
-	} else if (fuse_writepage_add(wpa, &folio->page)) {
+	} else if (fuse_writepage_add(wpa, folio)) {
 		data->wpa = wpa;
 	} else {
 		folio_end_writeback(folio);
@@ -2454,21 +2456,21 @@ static int fuse_writepages(struct address_space *mapping,
 	data.ff = NULL;
 
 	err = -ENOMEM;
-	data.orig_pages = kcalloc(fc->max_pages,
-				  sizeof(struct page *),
-				  GFP_NOFS);
-	if (!data.orig_pages)
+	data.orig_folios = kcalloc(fc->max_pages,
+				   sizeof(struct folio *),
+				   GFP_NOFS);
+	if (!data.orig_folios)
 		goto out;
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
-		WARN_ON(!data.wpa->ia.ap.num_pages);
+		WARN_ON(!data.wpa->ia.ap.num_folios);
 		fuse_writepages_send(&data);
 	}
 	if (data.ff)
 		fuse_file_put(data.ff, false);
 
-	kfree(data.orig_pages);
+	kfree(data.orig_folios);
 out:
 	return err;
 }
-- 
2.43.5


