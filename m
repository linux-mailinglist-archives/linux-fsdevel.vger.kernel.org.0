Return-Path: <linux-fsdevel+bounces-26573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B5A95A827
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67631C220D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1317CA19;
	Wed, 21 Aug 2024 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvw9f7qd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769117DFF8
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282723; cv=none; b=i2Rk6AkQ+5vmogYlDtGSEvkz0DfAq3bDgPPawgP9ULDCYEGM0blWl4kTvAI1qFx0v1U/VDEedC3FiZYUeKZPnPJGeOR9i1CV0P1NdqickCsaUIvxpAoDySgKq27rPUloQlcGuq8AuMxvcXP44gkBrLe8fDhwmEjAgxCdHWbZrdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282723; c=relaxed/simple;
	bh=gKnJEZT11DQ06ikXb5oMR9t2opeJf+EppgH5eyD1ZRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H92wsrg4Tw7pLuOoayXY4SpZK0mTYGX5T2Qrm4Q1e8RyhBulzR8mH9llK3rWlXnVZY5IGGpc2lB7pEyxV3R4PQmxaVI8w98HpqhLtBDZyx4I77ifWj2gYbAKxsBtqIY/blq0RJMft2rkGxDI8XWBrfSx/G5gNxd0f/MGqDq77NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvw9f7qd; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1633202008so268166276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282720; x=1724887520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ak2ie9HoEpdJU0+WPVOgSdaEsgb/FpgyBUDlSUZ5YAE=;
        b=Qvw9f7qd9VadgtYu6uN7xHzcYCDHMYFk9n6tkAyVqqWe3LX5l7gaAX8skangWMtaLI
         2ba8TPcoqICLT2Q4uBdc3BOE/OArC8yVWXxe22Wv4metouWyTIV6+7pjdsobp9ri7a+A
         fxpElJiotCzsdfqQTK+6GbKNe2r5pwp5yTmUcsBDOS5RVmK+SuM8GbUo9Z6Ho6WgWhPg
         ThwmJ5YW/e0a6Bo//yxcB0Nx+HBrIgLSVrNAu4grDSkEryP1DMlSqKMXdRaB7/j+2CvW
         weSied9zIOgLXrdrCMzGuAyAlA2N94nztpu1RbEAKvAUshRAcpYn1Ry4hG2Q8aFuIRMe
         RTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282720; x=1724887520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak2ie9HoEpdJU0+WPVOgSdaEsgb/FpgyBUDlSUZ5YAE=;
        b=BlJuTpqjrj1gLVsIZ7HUTUJKBLAOn/TlWVNaJxkVD7m4Lu7nTsiIonu6R1wo/6VJiY
         iltNMkldemhuSYHXdmZbhC85zq4otT4640gwf8yup96NkEIxaYSzfgc8g7U9JB4SX+Oi
         YEs3FGXO0qpZ4qdlbQf0gsKqzx5ETGa4klPok94aKx2YJbD2ZrY5R1lemxmtDhz1qsg+
         GrS+wiVif4mv965BqKChWk4HrrazFiNs6dJoLVQA6e4eLqSbAg8Bv/cPHVJhIRQgrH5S
         R6tjPifTGT6QBDaGufePUXzeJpb5hUs2g1mA2u/UykFB/jsWk4ApZP8Tz+q+cY6qzeCC
         pa2A==
X-Forwarded-Encrypted: i=1; AJvYcCXoFrN/ZdK5ZtZJphC53cVl4yZGtgHUdE9/WpN4GAngUNWgcOMKZl7VpDOLzpqed+CayWZRocosiMhNjx1V@vger.kernel.org
X-Gm-Message-State: AOJu0YzhAoxqJR7SIY0qMXE0tFRLBmEn0fQmMvwWWKV8fcwT0UC/nFKJ
	qAdTOVqT5/5DoIriU9h3ilWF3oPlEl6/fjioVcJo0vCmRNSBjHCX
X-Google-Smtp-Source: AGHT+IHI3qyK+9Y9cScldatv7aKCjzXQuor0IohDwmD6ZLytNawzLCFZD0f8sIfSK4eS/eBmdxZY2A==
X-Received: by 2002:a05:6902:2013:b0:e16:4dc7:aad3 with SMTP id 3f1490d57ef6-e166548bf93mr4029464276.27.1724282720407;
        Wed, 21 Aug 2024 16:25:20 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e56a2adsm59324276.48.2024.08.21.16.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:20 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 8/9] fuse: refactor out shared logic in fuse_writepages_fill() and fuse_writepage_locked()
Date: Wed, 21 Aug 2024 16:22:40 -0700
Message-ID: <20240821232241.3573997-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240821232241.3573997-1-joannelkoong@gmail.com>
References: <20240821232241.3573997-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change refactors the shared logic in fuse_writepages_fill() and
fuse_writepages_locked() into two separate helper functions,
fuse_writepage_args_page_fill() and fuse_writepage_args_setup().

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 102 +++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 45 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 812b3d043b26..fe8ae19587fb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1936,7 +1936,6 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 
 		wpa->next = next->next;
 		next->next = NULL;
-		next->ia.ff = fuse_file_get(wpa->ia.ff);
 		tree_insert(&fi->writepages, next);
 
 		/*
@@ -2049,50 +2048,78 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
 	rcu_read_unlock();
 }
 
+static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
+					  struct folio *tmp_folio, uint32_t page_index)
+{
+	struct inode *inode = folio->mapping->host;
+	struct fuse_args_pages *ap = &wpa->ia.ap;
+
+	folio_copy(tmp_folio, folio);
+
+	ap->pages[page_index] = &tmp_folio->page;
+	ap->descs[page_index].offset = 0;
+	ap->descs[page_index].length = PAGE_SIZE;
+
+	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
+	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
+}
+
+static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
+							     struct fuse_file *ff)
+{
+	struct inode *inode = folio->mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_writepage_args *wpa;
+	struct fuse_args_pages *ap;
+
+	wpa = fuse_writepage_args_alloc();
+	if (!wpa)
+	       return NULL;
+
+	fuse_writepage_add_to_bucket(fc, wpa);
+	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
+	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
+	wpa->inode = inode;
+	wpa->ia.ff = ff;
+
+	ap = &wpa->ia.ap;
+	ap->args.in_pages = true;
+	ap->args.end = fuse_writepage_end;
+
+	return wpa;
+}
+
 static int fuse_writepage_locked(struct folio *folio)
 {
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
-	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_writepage_args *wpa;
 	struct fuse_args_pages *ap;
 	struct folio *tmp_folio;
+	struct fuse_file *ff;
 	int error = -ENOMEM;
 
-	wpa = fuse_writepage_args_alloc();
-	if (!wpa)
-		goto err;
-
 	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
 	if (!tmp_folio)
-		goto err_free;
+		goto err;
 
 	error = -EIO;
-	wpa->ia.ff = fuse_write_file_get(fi);
-	if (!wpa->ia.ff)
+	ff = fuse_write_file_get(fi);
+	if (!ff)
 		goto err_nofile;
 
-	fuse_writepage_add_to_bucket(fc, wpa);
-	fuse_write_args_fill(&wpa->ia, wpa->ia.ff, folio_pos(folio), 0);
-
-	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
-	wpa->next = NULL;
-	wpa->inode = inode;
+	wpa = fuse_writepage_args_setup(folio, ff);
+	if (!wpa) {
+		error = -ENOMEM;
+		goto err_writepage_args;
+	}
 
 	ap = &wpa->ia.ap;
-	ap->args.in_pages = true;
 	ap->num_pages = 1;
-	ap->args.end = fuse_writepage_end;
 
 	folio_start_writeback(folio);
-	folio_copy(tmp_folio, folio);
-	ap->pages[0] = &tmp_folio->page;
-	ap->descs[0].offset = 0;
-	ap->descs[0].length = PAGE_SIZE;
-
-	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
+	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, 0);
 
 	spin_lock(&fi->lock);
 	tree_insert(&fi->writepages, wpa);
@@ -2104,10 +2131,10 @@ static int fuse_writepage_locked(struct folio *folio)
 
 	return 0;
 
+err_writepage_args:
+	fuse_file_put(ff, false);
 err_nofile:
 	folio_put(tmp_folio);
-err_free:
-	kfree(wpa);
 err:
 	mapping_set_error(folio->mapping, error);
 	return error;
@@ -2155,7 +2182,6 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	int num_pages = wpa->ia.ap.num_pages;
 	int i;
 
-	wpa->ia.ff = fuse_file_get(data->ff);
 	spin_lock(&fi->lock);
 	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
 	fuse_flush_writepages(inode);
@@ -2288,34 +2314,20 @@ static int fuse_writepages_fill(struct folio *folio,
 	 */
 	if (data->wpa == NULL) {
 		err = -ENOMEM;
-		wpa = fuse_writepage_args_alloc();
+		wpa = fuse_writepage_args_setup(folio, data->ff);
 		if (!wpa) {
 			folio_put(tmp_folio);
 			goto out_unlock;
 		}
-		fuse_writepage_add_to_bucket(fc, wpa);
-
+		fuse_file_get(wpa->ia.ff);
 		data->max_pages = 1;
-
 		ap = &wpa->ia.ap;
-		fuse_write_args_fill(&wpa->ia, data->ff, folio_pos(folio), 0);
-		wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
-		wpa->next = NULL;
-		ap->args.in_pages = true;
-		ap->args.end = fuse_writepage_end;
-		ap->num_pages = 0;
-		wpa->inode = inode;
 	}
 	folio_start_writeback(folio);
 
-	folio_copy(tmp_folio, folio);
-	ap->pages[ap->num_pages] = &tmp_folio->page;
-	ap->descs[ap->num_pages].offset = 0;
-	ap->descs[ap->num_pages].length = PAGE_SIZE;
-	data->orig_pages[ap->num_pages] = &folio->page;
+	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, ap->num_pages);
 
-	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
+	data->orig_pages[ap->num_pages] = &folio->page;
 
 	err = 0;
 	if (data->wpa) {
-- 
2.43.5


