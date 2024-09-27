Return-Path: <linux-fsdevel+bounces-30277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4AF988B6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272D01C21637
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3F1C32E6;
	Fri, 27 Sep 2024 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rx81TOYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A561C2DD3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469949; cv=none; b=VAfy1ifsS6CA1R+SZeX2GmnSTGtTWC5upxT1meYZzImwRuiEgSYTELK3VQphH2rGfSQkaAd1unIeYq/w5zR8nxIZY2uqFRbu/cFY49K9UXINIEu6uQO5wP1lyWY6xZqJPBN++f2Ml17zNifEoalNgpRQ+m0N+v3gkyP2ocCfK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469949; c=relaxed/simple;
	bh=LVRmv1llM4N7tLUXsRjkTEOXviCsRQordYs6xmKABe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXz2xDQVQY+o23lPc8m043zrEYGgu2A1VqVgqCWKwY1QnyaaBcFtmfbqQ7ivbtV3oDoEMcGXv7qXygPyq5KhfI8aoE+PA4zCH04ssg1vl5szc10iS3/OASc0YdQS60XM5x4lqcCsQ7bcnTD1FwkCQwdaAbxLXpbwu4mqF6DTyls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rx81TOYf; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e25d11cc9f0so1930698276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469947; x=1728074747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DRhOsL64sEgZwzB9dQkJkYszAFNjSoT0NcfHOo1fAk=;
        b=rx81TOYfEGCnXXO+7CeywV2vRiRwDDnehYRMz9XSyjIlh/qt9s9O+2Fzd/9JPaX6T1
         h2SOH6HdT+ew1sbAyECjyvGP2PrJJE1kkbtox7QX5tyN66wZCKGY9A9YyQjowPo7qjal
         X8YalVwKtigIlxPKpmBd7R6nbV/5+91+kRqCOSCKw1o+1MH0UNdAX5suuyDBqD3BwOG9
         5zyAemDXukqYhFn7h+p3GoSyuctQoUtzbx0YcOzFV7DVAKGk9l6WjcLhzX1cZ3MczAl1
         u8sm2kV27BlozhEc5WZnRoc9pPGIKVif/V7Do/cjb+p18dphEaSDs9b8hedfUf/d+VXc
         XuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469947; x=1728074747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DRhOsL64sEgZwzB9dQkJkYszAFNjSoT0NcfHOo1fAk=;
        b=YUJ5N5P1RLjCUtT1bo9QOgSplKWsaLCYBJ6QpJF62NQVIX6A6aACNvgxXmmcUoFTqF
         IOULVundbSM2F2548+dFd/9feyBKwY3z9txwKJw89zIa7bASlYGZqaO2xx2fi/v0C5w7
         hCzL0YYIkfpoU/WAHSpE/3+OW8p3Bc/9RWmU3SjHofxjRNlx06G9UJU/MLLULMD9hT9Z
         v3EWnoxTtId8PSO4JoDayeaXgAHdHbDzgiJ/VqWrKmMPf514QUx4VWJIfwH8BYI/uwpx
         vCSvKQhPQubEU1Ax5VYyqmJAKlru4UQ0bRhltXGD+rTOdfyk1CKQUhota26BL+raQqSD
         cKlw==
X-Gm-Message-State: AOJu0YwciApaPz0JGJ0f35anWla2QPWdDkYFGeSOD4k0stM1cse7H4wE
	d8bkrA1JM2ajxq3byKtRY36SArF7gxD76oWVRKAAq7tJanUDgYeuacx93+ta+Z4UG5jHzyIH55q
	X
X-Google-Smtp-Source: AGHT+IG7T+B7ikAWq1jSzGzaIs8r7KTskdDG540j3YRahUKFHSW5y/kNCuZdGQNWPTo9+RBM8HSL0A==
X-Received: by 2002:a05:690c:f94:b0:6be:28ab:d874 with SMTP id 00721157ae682-6e2474d0d48mr42479477b3.2.1727469946678;
        Fri, 27 Sep 2024 13:45:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24530af08sm4162737b3.45.2024.09.27.13.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v3 04/10] fuse: convert fuse_page_mkwrite to use folios
Date: Fri, 27 Sep 2024 16:44:55 -0400
Message-ID: <1cb4f72d82dce708ca20ff90be622ac302ac2653.1727469663.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727469663.git.josef@toxicpanda.com>
References: <cover.1727469663.git.josef@toxicpanda.com>
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


