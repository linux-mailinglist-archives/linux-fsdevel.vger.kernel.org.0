Return-Path: <linux-fsdevel+bounces-27650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A089633AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2CB1F23238
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC151AD40F;
	Wed, 28 Aug 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YEFavjjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD11AD402
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879687; cv=none; b=iOJqOHZUXRu9DtrBZWyMTVaUZ6yHViARj64r+R7DxPGh/0aRsk/gm25hUcPswC9EcGu9yWV9nWFPCq+5hEWSblvU66KxQudICKfQCizBgbKGYRS9lfPGXtIVe/hlzaLzlhtsh+5wJOEn/Q6OKRbJ2uxMgc80trEUwrAxIDy9KcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879687; c=relaxed/simple;
	bh=1IlRaUU6YcpA8dWPljiua34jBMrCzwhmWQyKhY2rhqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AI6V7N9StRNJgVErY7BK1rPH+YgxVukYMY2uJfVVFC6B5+AsFTdX5O7JDRaJkek1tLdFSHme3YnXdeR2bURcAN8o04NPpTiHPeGWd556/KelEc/E4dt0BdcP3oxyAta31c2OBFK1k8dbHojNUXnSGtpvhFwtE0d4vfNGiqfLgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YEFavjjF; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-273cf2dbf7dso4653457fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879685; x=1725484485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTT5Pov6rIax3M1vyZfKKYLHP5B8WWVKBD0Bb4kXBo4=;
        b=YEFavjjFbEKVyb88W6ksJkfAYBzqCVn7xEeNuNUOPaJzj5pegee2kDrPP4/jjfvZva
         6krXKvGFKqeE9sjY23A5ijKxsBIWMJ1IdJ9KyLd3Iaw3rKP9lB0Ci6e6NvZ4XTte+cPK
         MGGTuORIXClZ8A4dCPnzfCNfv/j9B/riSRED0cZUyF7jsIFxC35U43QMNW+xAa8QqM+e
         7TRqZBowyNViOcSIqDszrFCR6vtn5i42x1zwRcmHDMG+Tb9YHjiHQag5f+NwxYso9ZcD
         4os08K5sRMvFf0FQYlygvPWsQxkLDZQGFmwyStnmXKDQZVKPQzxUYtBDpnYbZjCbkle6
         VuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879685; x=1725484485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTT5Pov6rIax3M1vyZfKKYLHP5B8WWVKBD0Bb4kXBo4=;
        b=vs9sXI3MxibqJby2f39oPfHzlncJkmxHoup2W5cRlmDcl+yuozWGC/uCEeSIis0ZW/
         pTIKzmamISTQYrSTePhq3r1ndxLmpVLs0/AsTYl5Ey93eAUWY+BXEd/9AfkeV+IxG4//
         LmBZQ+MXSOCVQ+6bERcYhKbOmgfBnpCgzbPOd1dI2SQVUvgV6AX12CvtW6w3arBJhL3p
         30VFyJv38LhWeeIAUsEITXIfAMSTqGtff8BjJew4Jkko8hpRHw2A2Lqtw7+PvF9f3Wue
         Somyw9ftU58jIdug3Q/NhUUEHaPMseP/CT7UU5Nu+TZrplgr62HoDoMbYUNcFysoVR/I
         sCzw==
X-Gm-Message-State: AOJu0YwLpKhY5GCT+Cn28vq/OHcBEMM5b+yYbLdonyziL8ZPqkmr7FZd
	WwKZE6i7c5mPwHX1kt0CL3vs7LD8N7jVNjzSc6477JHoVQlWkTTHIXZh6iaIed329jDl/efJMro
	U
X-Google-Smtp-Source: AGHT+IFXvqEYi1OVAIibfeICBWrOJASjypLZy6DZHPsnpojRN3PDyhDFuapmJJX8KPIPU4UHJk5OwA==
X-Received: by 2002:a05:6870:8451:b0:270:3a68:cc08 with SMTP id 586e51a60fabf-277902c5662mr829393fac.40.1724879684914;
        Wed, 28 Aug 2024 14:14:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a8025a8b0bsm36381585a.75.2024.08.28.14.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 04/11] fuse: convert fuse_page_mkwrite to use folios
Date: Wed, 28 Aug 2024 17:13:54 -0400
Message-ID: <9e0199cbcdaab094ac839b82b01c43f479bf01f7.1724879414.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724879414.git.josef@toxicpanda.com>
References: <cover.1724879414.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert this to grab the folio directly, and update all the helpers to
use the folio related functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 08fc44419f01..830c09b024ae 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -483,6 +483,16 @@ static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
 	wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index));
 }
 
+static void fuse_wait_on_folio_writeback(struct inode *inode,
+					 struct folio *folio)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	pgoff_t last = folio_next_index(folio) - 1;
+
+	wait_event(fi->page_waitq,
+		   !fuse_range_is_writeback(inode, folio_index(folio), last));
+}
+
 /*
  * Wait for all pending writepages on the inode to finish.
  *
@@ -2525,17 +2535,17 @@ static void fuse_vma_close(struct vm_area_struct *vma)
  */
 static vm_fault_t fuse_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 
 	file_update_time(vmf->vma->vm_file);
-	lock_page(page);
-	if (page->mapping != inode->i_mapping) {
-		unlock_page(page);
+	folio_lock(folio);
+	if (folio->mapping != inode->i_mapping) {
+		folio_unlock(folio);
 		return VM_FAULT_NOPAGE;
 	}
 
-	fuse_wait_on_page_writeback(inode, page->index);
+	fuse_wait_on_folio_writeback(inode, folio);
 	return VM_FAULT_LOCKED;
 }
 
-- 
2.43.0


