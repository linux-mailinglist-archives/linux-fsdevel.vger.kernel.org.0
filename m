Return-Path: <linux-fsdevel+bounces-26940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D149D95D359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9091F23240
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E0F18E022;
	Fri, 23 Aug 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQGF0+Aa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BFE18B49C
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430471; cv=none; b=TFra9wSYWrf3EcRB/LiuuRfkP0rlCFyWkX2YnPRY/IPzXKKz+cvMQ/MIpsroOEHU/mQ65fKfoHxMxsX7Tqwu6mYtonYCt7a8bVwUb23uddJm305QF2kr6d+w9AHTLZSwDvQ21tJDz6Yu7QEIbaiWGDG8AGGfXaLyGtbPBzsby1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430471; c=relaxed/simple;
	bh=eb/8qpiT7j/DhU8t5pSUawoZtru9OVDFDwQx8cVOuv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=et1r9U7+qP0arCdQoz9htOuZAXPI66viEXTQB8xJd/PpLex82m/UelPMZY4zDmDDQvJfKmx9WocZ34t6tD90uxoven3TOKe+l2s01STzdcRANMTT2ehDujeSb//Z76psBt50BcEG5tXNKz2Ndpo2pM9sDwqrSJFkXurQCtZVBrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQGF0+Aa; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6b44dd520ceso22054847b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430469; x=1725035269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I217fz16cOnt5oEHhpWUdlzv47nxJBvXhKdCBirV+no=;
        b=XQGF0+Aa3DjYQT0PJpcrvKxIQG4J+ffWY2t4dHyP96jgwpO5Nq3H8GTkLf3zFaKaLa
         MMnut8s2AzXukjEHJAQrLzC9G57q7U+14EYzvJJRab4nSuu7InclYeqThBqXqvGv1qbx
         czuvQqty/kAcfilyvPVm32S64qlsgmAT3Afd3gp1IESwaYj3aCduQz8F0o+30yx9GpUv
         4rHr8K0WvP2z+S8U3hkZmNzmBWRnqaaxqXfQXFebysxd3kDeoqr4ZjuFYYJan//e2OaY
         CLow5dZ+VmDr1QTs5CewFHhtmP61faQINcG3ZMCFk7ki0/p1kLw+71Xz03moHIX36tS/
         zMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430469; x=1725035269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I217fz16cOnt5oEHhpWUdlzv47nxJBvXhKdCBirV+no=;
        b=sY3YSbeisVoxphG+GGcyGR+xIaS62wbI7PavvW4vvPNAy1n5Hu9WdoF+ZJfUDd7sF6
         AB136WA+7WHnwizcBEzXIcplvbD+5KG3P3pGrE3wNl9dcKu6z0ajYeGJUOs9noceEY3e
         YPsJOKT7wm6+yINbTKWLz983A5LaqjUcUk1znyvmdTuZ5bKEb9golji/h8mlWSHOYOR7
         2kQTQ0KmjOlMy+ATJ45DnTRQ0ILpjGqnRa3xTU3WyIqJ/TaD3rTpxqyiSOZxqqGHL6Od
         Pp1nfK9VL0PWDX42tDSyVqNUIGh0femOB5Fg2xIAKgjk2eE2ZjhBbIzWUHPy3wowODq/
         VlEw==
X-Forwarded-Encrypted: i=1; AJvYcCU+5HROn64w97C7utwfJag8JBM0/efMObfqyKz1KJnQCXUmnXID1oTP4urW7WiiCG2cWTk207HWYu+dR46h@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUjzG1FIU6aNljlx+z8tAUdDA9TozzE2PZRPaTjbZEu6iMuUE
	uq2Zyc1EXipGEUbecJRmniUxWjpYMKc42NGgRa1Eu2cEe5LEJnjMCvzVpA==
X-Google-Smtp-Source: AGHT+IHhdaKfwtyUoIAJINT1DlUaufdaxfmwinGtrbSzZz1cpKfww319rOg9jI+lBGcXMsW+F4j82A==
X-Received: by 2002:a05:690c:3303:b0:6b7:f467:e09d with SMTP id 00721157ae682-6c625a4c8d4mr26187577b3.22.1724430469156;
        Fri, 23 Aug 2024 09:27:49 -0700 (PDT)
Received: from localhost (fwdproxy-nha-009.fbsv.net. [2a03:2880:25ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b006490sm5970097b3.63.2024.08.23.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 9/9] fuse: refactor out shared logic in fuse_writepages_fill() and fuse_writepage_locked()
Date: Fri, 23 Aug 2024 09:27:30 -0700
Message-ID: <20240823162730.521499-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823162730.521499-1-joannelkoong@gmail.com>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 99 ++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2348baf2521c..88f872c02349 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2047,50 +2047,77 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
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
+	error = -ENOMEM;
+	if (!wpa)
+		goto err_writepage_args;
 
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
@@ -2102,10 +2129,10 @@ static int fuse_writepage_locked(struct folio *folio)
 
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
@@ -2285,36 +2312,20 @@ static int fuse_writepages_fill(struct folio *folio,
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
-		wpa->ia.ff = fuse_file_get(data->ff);
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
+	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, ap->num_pages);
 	data->orig_pages[ap->num_pages] = &folio->page;
 
-	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
-
 	err = 0;
 	if (data->wpa) {
 		/*
-- 
2.43.5


