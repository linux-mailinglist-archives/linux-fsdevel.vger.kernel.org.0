Return-Path: <linux-fsdevel+bounces-27248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 001F495FB91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FE11C21D00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F619B3D7;
	Mon, 26 Aug 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2veYYNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF21991B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707212; cv=none; b=k+wlZHLSuXMRIK5bYXKdzNTBqM5UX4Kw/bIiqdvkqEcx92xyJTY7Ocn9fdrntxszkZ3Bh4tjF1paxsi+jLyRUFMc31A8SK5JUoaUCRTEwIB5WunUANNUvv3cnGQJolDibMab4Acb2qhq7t0da1ycaCUzToqrwrH6HIBZe8CpY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707212; c=relaxed/simple;
	bh=eChdZxLkTEJARF2qLbQQxa8NQysTDNDXSLhFdkso4dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gA3OYefba4hpcosfE6DpxzL6O7TXVekmLh0jARDIOAlIy4myBsYJPn9agJdP5uiTSznpFbt3bKlDaeq2j1rY+gcAwV5I5WKPC4VSjD69W6wLs1t0C/mhvs3xV98rTFxkRq7P/WoxWLs9bITLIx90S9sPWw1mIpZLM8ePFI3Znzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2veYYNN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b6b9867faaso43147477b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707210; x=1725312010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qcJuHgOljrUXDPlcVoeTMfTH5GYtw66c11J96JvW20=;
        b=i2veYYNNl+lJxGSfPpUIQxIzai8253wmKIT1rXLWOXZaYYkW/nq+VtDdHL15fmfgK1
         U+tyEbOrGrXMjaadinoddZBvxm7Wbvq/uaE5+viUnhgXZUznZpVCA7Xci9opEtD8Fhqo
         V6uCLnbGxLy7qlw9zn5Wn+l1Unmbo6SuHSLTlDSIpRUB2hO4OXdFOlbg/HLqACZarXME
         xCRGJY+SdBM5VsNCb+y/2GPUMrk9A8+hWS0Vg9XVkGdf0QsVHHc8J9CBL66OYTp1Wy0Y
         l4PSbT1PGY9BK16nIS3yS58ejznmGRlwIWtb6kJIvRZ+gqQ00MEu4uFvVKj1K81gJ/rv
         H2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707210; x=1725312010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qcJuHgOljrUXDPlcVoeTMfTH5GYtw66c11J96JvW20=;
        b=rMJCrX9I17FUSxjTSUJFGHqt/c2oj8oQW0seqPcrAmxQqYQaAx7nhkRAwiwuFfVyys
         Vfuxvie+oinJNozNZNs0OcRo2PfmR7vND1+1d02Pa8AoJL8hf0U2+mJuqX3GZMdJNwrN
         GflTvq4Ry5xNq6BuCA1yVIxkTNTzDpwyvFQKdcN0o2ug5ms/xuH3pJ31CVmp961PiwEq
         pMtWy43+y3czxZJnV6hqlgwrgRaHgnkj2EM4Jb0QYkOGVx05ajro78YVdb3+bOZ4O1JF
         i4qv3PfYHPvFf38BWFq75U/7VIh0MfMNeAgflW+jtl/WJj9+YcUZ6uXxjRgXw3iySl3J
         IFVA==
X-Forwarded-Encrypted: i=1; AJvYcCU91Xwk3iyvs67NN6QAT/2z/bPeR2jXYcTk23tsZJh++KLb46b6cliLQ+CWJlfvAs2wkJpJKmmHTAWFeyzb@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/yg0vQUgwLrye9R3zQqkJjUCmyPkft7Y8lRzIRr+gFVDVbjt
	ZAwhusAPyKxly4x02DrAX2juyGDbYte8vIOLInpITlyE6mmauMow
X-Google-Smtp-Source: AGHT+IHpH6Ec3X4W9B38Xu7L3Ps9O5jbBAzw1yBL4rzUM3mqvjeH5y8HMOGUang9qLvMzFPTiV5Xeg==
X-Received: by 2002:a05:690c:744a:b0:6bd:8b0a:98e8 with SMTP id 00721157ae682-6c625f1e929mr150644897b3.24.1724707210272;
        Mon, 26 Aug 2024 14:20:10 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39d3a9f9bsm16777687b3.78.2024.08.26.14.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:20:09 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 7/7] fuse: refactor out shared logic in fuse_writepages_fill() and fuse_writepage_locked()
Date: Mon, 26 Aug 2024 14:19:08 -0700
Message-ID: <20240826211908.75190-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>
References: <20240826211908.75190-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 103 +++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ef25dcfcac18..726743e33b7f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2047,49 +2047,77 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
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
 
-	folio_start_writeback(folio);
-
-	wpa = fuse_writepage_args_alloc();
-	if (!wpa)
-		goto err;
-	ap = &wpa->ia.ap;
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
+	wpa = fuse_writepage_args_setup(folio, ff);
+	error = -ENOMEM;
+	if (!wpa)
+		goto err_writepage_args;
 
-	folio_copy(tmp_folio, folio);
-	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
-	wpa->next = NULL;
-	ap->args.in_pages = true;
+	ap = &wpa->ia.ap;
 	ap->num_pages = 1;
-	ap->pages[0] = &tmp_folio->page;
-	ap->descs[0].offset = 0;
-	ap->descs[0].length = PAGE_SIZE;
-	ap->args.end = fuse_writepage_end;
-	wpa->inode = inode;
 
-	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
+	folio_start_writeback(folio);
+	fuse_writepage_args_page_fill(wpa, folio, tmp_folio, 0);
 
 	spin_lock(&fi->lock);
 	tree_insert(&fi->writepages, wpa);
@@ -2101,13 +2129,12 @@ static int fuse_writepage_locked(struct folio *folio)
 
 	return 0;
 
+err_writepage_args:
+	fuse_file_put(ff, false);
 err_nofile:
 	folio_put(tmp_folio);
-err_free:
-	kfree(wpa);
 err:
 	mapping_set_error(folio->mapping, error);
-	folio_end_writeback(folio);
 	return error;
 }
 
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


