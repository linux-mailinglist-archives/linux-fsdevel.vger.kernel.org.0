Return-Path: <linux-fsdevel+bounces-30369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AAF98A5B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26441C2260A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC0E190064;
	Mon, 30 Sep 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="eiION8L5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0218FDCD
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703946; cv=none; b=uYQbs4T/+7EWufnL903Kn9hXHhyptg9rFFhGtVxHkzlxU5Bx8X0LD2yeco50llIoLJxhKQUA+dz4bAVypHzWPUWltL66K98L/36EciHL0ITU2RqxgezOHDyNfz49D0vkdlFK6xZnDAzKMMMaji+M9Nm8jGSdJd1UOXOyCVQCYhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703946; c=relaxed/simple;
	bh=xxhxTHyFUzZc6W6EvO+2eV+lF9gnD8fALop23pcy+yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2+V9tJOj/3q1iXdls0YpU1CteGF8glUq0vTTf051Mg3VVpmfdbsjPVhtQ5/GDKLT++1WXI3vtu+WuWB63m3QvZt/YGIu0FmRdmBV/ynfSfBS3TwXIlaP8kLgl8kSDl3L0yIgKooMomZjZSQlMepX0YMR3hYxr141OTZZBuM9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=eiION8L5; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9ad8a7c63so459956085a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703943; x=1728308743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIKIdrD3iJmv0MkDAQAM/afUozWyhGSMgRruKAM/Ey8=;
        b=eiION8L5shmgln+PHaLlNG/BhAcSjxBpQR2H3oek0y7m6rGBJ6i3LMZGqYw0YrCu+t
         Pk+TDL1oIN24hSsFjS4b0TXAfixB6sn0qBFZu8TdSn88ARJ1HvcNBy5Csrdnb+NALhaX
         V9Ev1BxQZRwGZqTHHxKnJTSNYWCUEFCQEfXaPJSSWkjmMOR4x7UJTggykZfCpKd2Mdtj
         dVPA2L2O++7VsUr8+6e9sEyGDcOGGHN8GK7+WZZFwHPPfKcTXz2b5J/QZz8NEGLi0XzF
         eKOe4lVdScNGf5w6lDVsUsLe/Jr751Q09DcV/OPl31jxSpArZ4FUmC15pAEP7pDmyW5/
         IEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703943; x=1728308743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIKIdrD3iJmv0MkDAQAM/afUozWyhGSMgRruKAM/Ey8=;
        b=QaKrU6Z4nZVlOiwMsGbUFEZA4AiW4K2Tg0A0wpCIVUJV9pKHPxFvQYvEcQOcgX29ZR
         MFKXlvnmwcBhNkF4gqA36XaZFheXeLYMV6E3tU0Vr6YN0XLnAJwAw6igCgh8KgP7Pxak
         GYJfpZhKR21EvT22s/7jgU7yMI9W1NOJLPUsm18PwfFQ4lB3xSjTohFnAZ/r6fT4ZaM7
         TLM/odJLh/qmE0sr/IxQQ6ZhcVfh9kBRrmXDcl0Cn+EkzRqhNxA2jzzgcx4xUjG76VCg
         f4QjdWl2mhPDPHhtEzzqGaN/74aBZaEuGPiRcjFwgzoGjPa1+vjJhuXiA3keSKE90FGU
         s/Ig==
X-Gm-Message-State: AOJu0Yy4hR6NLl+hwUH9aV9hYLPKMv0XIQgCSgvrRemWfK8Cz9qRt8SW
	lehTu1uhaFwc6wNgkOPKTwsEbrN7t+g4udOj2Ks9l9F933DvHV4BpguMCarpYwT1swKPOX45Ac8
	b
X-Google-Smtp-Source: AGHT+IHgN4wW+vqIUMbUKJ0UzXkh6939GSoSSXOP/HeDs6j3mIy3V2Ob5CBZVDEvj4hLdv0x+iOfQw==
X-Received: by 2002:a05:620a:319f:b0:7a9:c0b8:9337 with SMTP id af79cd13be357-7ae37859ec4mr2091462885a.37.1727703943359;
        Mon, 30 Sep 2024 06:45:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2b6d4asm36339101cf.21.2024.09.30.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v4 04/10] fuse: convert fuse_page_mkwrite to use folios
Date: Mon, 30 Sep 2024 09:45:12 -0400
Message-ID: <abe7d8b01bf96339dd2994c1b1a6a3286452f914.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
References: <cover.1727703714.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert this to grab the folio directly, and update all the helpers to
use the folio related functions.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1f7fe5416139..c8a5fa579615 100644
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
@@ -2527,17 +2537,17 @@ static void fuse_vma_close(struct vm_area_struct *vma)
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


