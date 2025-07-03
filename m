Return-Path: <linux-fsdevel+bounces-53817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3FAF7E2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF327585644
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C925A32E;
	Thu,  3 Jul 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBYlTp6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BD229B2E
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561241; cv=none; b=iZsBLu+0dro5pTNLa4PA6Dvr47OA1qQDsk+xyN5rRoYZUYir6F/9J/2x9k12kGrj72rBZrNVkvSRuC+L/qOZG18pgHJQPrA4qJEQzJC589UcdVrCH+hIS2haNJ0fXgF6R9mmoAy7faxpZNcbXHw1Ue7TcFoQXj2l/VjlJahPNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561241; c=relaxed/simple;
	bh=mkm8E2p7R3IzsqaAw7MnbQrlR/u8ARdo+4r2ABayAmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITMwnL9p2A9QVq4wDMTtv+40adh60wqsHhadQzW9lxalbEoRE1/nVVP1sNqMluz1OujEgfFZS7gcX8PHyjvI9QLhzJisdE+iSpX4vQR0T54zur7c5hLmgf4KgulLdLeFWqTSkPXxd6ClyhQKyNVQtP/mFvfKoHYGxywSGa7i49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBYlTp6p; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so106786a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751561239; x=1752166039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KUF9W1aMfxOl49LI4mdnr5jcMJGDfiWEvrCB2aqcB8=;
        b=OBYlTp6pZ+F7Qyjpa0V4r5jE4KpVcKVZbg4lLRZXXPgHSWJK7RbcNISOtZIG6Dw5Bh
         YOS2719Bk8ynePWtr52K0j4svgqd16A7gtAyH/WlsnYYcH4C4sHV/kDg9iBaTaWN07yb
         YutKjX7KoVcjyK7zQS2wlCBc9orNWv5NTbe2VupF+oeEcW2gSR99tcJpzx27cJAMUHLC
         ZzeXddEq+sAiirTt8iHkMyQ3uMJ8LQa4ZApCve0+A9SHyUXIlJ81l8+Cp3NxcKHQp/6J
         qomaj4x5rQQERCjBb5QhTuYxgtfiY1uK06GPg/QVUl4zSKPuGonHeoIEO3YgmNtPQYi5
         VTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561239; x=1752166039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KUF9W1aMfxOl49LI4mdnr5jcMJGDfiWEvrCB2aqcB8=;
        b=r+uUpApw8xuvSHX1oWaoZpD+4RCP4kAQ9YwJMFWR91VA1x/UG3Qh2ZK3QzqEtQz6oG
         KjpYqvUR6b4JgTUMmKj4FON8jJ1XF4iEYgRNKRsphMj3Y3fEqy7fYg1yBOXkHPBh9wcR
         yJbuQKI30OZBLn65kL4FUDEfsxkdwM50dLxCp1qfi/hUR+LsryDghFOyGJbKYm7X+t75
         /vCwO0wkemNy6zo1K9s/QCxyK2XZMJGRiNd0yTgma1FOr2Bsn2vHZNv7rFG5cEBZY1+y
         qBQGHNmi6IbyGEaqlim0XOJ6GPbKNfCAQoqEj4P4KKm/JgU1xI7rSJL8oVifxDHIV/R0
         HqAw==
X-Gm-Message-State: AOJu0YxHhTfoT5KdY1gosKYpgAWnq17ABA3j7mGYvAGZv8I34fbfzwJ/
	2ux4URlq7KXKWmpzYBeMkJKRMvyFZh0hTYid5RY9UseZzfIAwrhcKNhp
X-Gm-Gg: ASbGncsuBtIaqilC/t4m9evCyPNG+eeRo2+nvj+hEtcjZ87AHN0JDpUXaXFrQJBjzqr
	tznneyY7bjIiU9+Eh9uQDdOXdzeb9GNVTnEemxoRSIMx5r15wysjd/kijWtwT12FnFfjPrRXUkv
	OA2sf/P9819yoPyTo98/P7kp2Ibdy9ugBF1WYaXjl33w5RgV2OKO2nbgkWVq9OwVBJcQBWkiEmD
	+KtptdvEf5B7rxVmf5bHf4lfwrKqElbD9Tqyp6hoFjH6rfozbjwASWiatTipkLCw+bSScQnjnA8
	Z80G7Pf0qFS++japTkBIorK0pTJqEAEmlRvxqXvMF5y0Xu0t0Ms5c/OZZA==
X-Google-Smtp-Source: AGHT+IEMnV2oUSHrfRLVZzjJoW2h/2zbww2c2SuiLfs7Gloqz1DwNceB43b8y/fW/e+NuAdovgfXmA==
X-Received: by 2002:a05:6a20:7344:b0:220:eef:e8f0 with SMTP id adf61e73a8af0-2243e6a73e4mr5395561637.23.1751561238877;
        Thu, 03 Jul 2025 09:47:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5fb022sm80861a12.49.2025.07.03.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:47:18 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v1 1/2] fuse: use default writeback accounting
Date: Thu,  3 Jul 2025 09:45:55 -0700
Message-ID: <20250703164556.1576674-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal
rb tree") removed temp folios for dirty page writeback. Consequently,
fuse can now use the default writeback accounting.

With switching fuse to use default writeback accounting, there are some
added benefits. This updates wb->writeback_inodes tracking as well now
and updates writeback throughput estimates after writeback completion.

This commit also removes inc_wb_stat() and dec_wb_stat(). These have no
callers anymore now that fuse does not call them.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c              |  7 +------
 fs/fuse/inode.c             |  2 --
 include/linux/backing-dev.h | 10 ----------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index adc4aa6810f5..8b1902d3b52f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1787,16 +1787,13 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	int i;
 
-	for (i = 0; i < ap->num_folios; i++) {
+	for (i = 0; i < ap->num_folios; i++)
 		/*
 		 * Benchmarks showed that ending writeback within the
 		 * scope of the fi->lock alleviates xarray lock
 		 * contention and noticeably improves performance.
 		 */
 		folio_end_writeback(ap->folios[i]);
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		wb_writeout_inc(&bdi->wb);
-	}
 
 	wake_up(&fi->page_waitq);
 }
@@ -1988,8 +1985,6 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	ap->folios[folio_index] = folio;
 	ap->descs[folio_index].offset = 0;
 	ap->descs[folio_index].length = folio_size(folio);
-
-	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bfe8d8af46f3..a6c064eb7d08 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1557,8 +1557,6 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	if (err)
 		return err;
 
-	/* fuse does it's own writeback accounting */
-	sb->s_bdi->capabilities &= ~BDI_CAP_WRITEBACK_ACCT;
 	sb->s_bdi->capabilities |= BDI_CAP_STRICTLIMIT;
 
 	/*
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index e721148c95d0..9a1e895dd5df 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -66,16 +66,6 @@ static inline void wb_stat_mod(struct bdi_writeback *wb,
 	percpu_counter_add_batch(&wb->stat[item], amount, WB_STAT_BATCH);
 }
 
-static inline void inc_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
-{
-	wb_stat_mod(wb, item, 1);
-}
-
-static inline void dec_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
-{
-	wb_stat_mod(wb, item, -1);
-}
-
 static inline s64 wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
 {
 	return percpu_counter_read_positive(&wb->stat[item]);
-- 
2.47.1


