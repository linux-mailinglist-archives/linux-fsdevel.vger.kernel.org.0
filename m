Return-Path: <linux-fsdevel+bounces-52665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B479FAE59E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA091B60A59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB971FDA94;
	Tue, 24 Jun 2025 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbIVEyYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F4225761;
	Tue, 24 Jun 2025 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731787; cv=none; b=Ys2QFITbjM02Tja49R/25z+0UQUZq2EGWj25anQgNKESvIZIXSEb2j78DkjjyKhIXq8jEFTplNlBlVLH5eSzxqU3Q8IP/a9rD8oWa0l4e6Vt2dUuDBrqvLD+BaB4/u2XPfcMSSRvuqZErXpkWYXzdu7XLjf8T4V6pGIk8jK5wRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731787; c=relaxed/simple;
	bh=w6oI4XdBkqLpqx8UEy0BO/l6PNovW+ILKa/y0YsvhEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWlU3j5YcXhKbh+HMq9TJfg1WsCuXa4GviMQvglxAOE8BL6Oos0Y2+2SYDwBXgUJRQWxoK0AxlmSw9D7gy1c2I/qKJe16MZgV2+g6FhicXPGUVQkyMtpBvCWVv8LhN5a+q+uc7AD9e9gJOOiZk1wd9O4vzep/wfq1lUUOlzwovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbIVEyYR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7494999de5cso847957b3a.3;
        Mon, 23 Jun 2025 19:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731785; x=1751336585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7qRwxTAh1XYIZNu1ybbTn2mD5r36mtDEb/ZOVNmqbg=;
        b=gbIVEyYR6ZcRq2HquDE4l2ixe958Asu6XZ2Nex6VrIo+Hen85rZaGZRRm9VRxgL8Cs
         ROMmzBKLTEHA7F8IDsId63wYJyjcBqUdm2YqlPaq1HpmdK13OD4gFS2Xza+l9uDIBhZz
         pSm1AVH2gNj8U+UVzGRb8LSurFhibo7n622pqjOXxum1tp8vHaGGV3FgEC+mquQXX4U8
         HTtA6UrN6hg7ufMlki8/rJOnSv+xlcXoLjszd1xfOmhKmp6quxhqaSXzGR41lmOOrRTE
         5FDvlT1qflqMaSyXOIcANPO7zb9uz9IsIlfhEKCSf8W2jHZy2NNJ6MPe9Rmr8p4Yg4TF
         IFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731785; x=1751336585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7qRwxTAh1XYIZNu1ybbTn2mD5r36mtDEb/ZOVNmqbg=;
        b=B9jaxDgTaAQwEHle2OYHBnAKhC3ydGlfHFAuwvv3xBcB1WOFPw+/HmglK194LR4KNg
         4nD+ywwyd2lVKnuYYKu2ul74q/ujCedzKjmL84wycYlQ072ZfZ49+LvRas07rXEoTYsR
         xln96AtulJPx2BXc6JKIdjPBtbVojHAus9dH8L5v2/5Nx9QJkNxV1lnh6AhHM4GksRZB
         3mAMCVTFyCOwBffqntObI4kaBFmDO2qXnJGZ7vzEH1EpIfm5JG3/XwG4X1j/+UeHFnXW
         ZB0Qb5M/pmKVmqzdnef0zzAK7R7WyvTaGyNSjjtrV8V1+/oIvlpmAB4EhAwIb6W1zvpc
         fxTw==
X-Forwarded-Encrypted: i=1; AJvYcCV79BmeRs8ZJDLJg2pwEOXOz2O5KNltHuvc0cuofNR7E18PRXKMYqMS5aYXQHG6NCpfBOC0SDsnMmPmaA==@vger.kernel.org, AJvYcCV7KjMe9Dj3/KzsWkOmoNfvdLA7ZYzJIHtL0lSi+0ZLDoJ/LB0DJazYelPttZGqRlKnJqZBVxxA1/eU@vger.kernel.org, AJvYcCXzIspbz/OD12n5sIxcZb58gYgO2MMqn1n25ulEOGAnyRpE5SGAdccetcy4fveRlB5VdprkHgZ2jDoY@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7pp4S2BoYZkVSQAF9FjzRXLiuQ1VH0bmxDOgZk9hwOFHjqbw
	d+cMG62cLWiFzvg0J5B4xp/bjx5cmF+mBdjT1V2F3rbzgrE3fgZgDuv5kvwqvg==
X-Gm-Gg: ASbGncttp0howj+Gj7xeDFDmmBcK4T5H9wZ53IgCHMbEherOU6dwAD04iwApaaSNra8
	XjfcHrs0E5l0fP0IHg7rOUFcdmPjtuUZ9ROhJWG64tfEPVeJpBp7DQdTCwUZMXvKIyfbvy8dyKa
	KY+lrBhSzeBhUOpgm4vBQsE0Tdwhab6R6e/bWCcjKoxIsAfBhzkfCRqJDrIOKGCarY9Vi7Rz/gW
	l8ofnX9UAZEXrMhIIqiJ06XeEylN9ubPGPJ0XxcLA9OcsUpnWMVx3rY2ptopQs1PknMhkWavp9A
	mzwF8oxJBmvHhQH6I9LkjPbp8jmByxesEzfHNI1hbq6rbSF4rP0TobA+eA==
X-Google-Smtp-Source: AGHT+IGel6o48zBxpcJuXVrZ4h8rIweeNj3Mra0caghqGYv6uPbzbvrWu2IBvYn2pP9m+sUAn+EBZg==
X-Received: by 2002:a05:6a00:8c04:b0:749:122f:5fe5 with SMTP id d2e1a72fcca58-749122f609bmr20118385b3a.18.1750731784748;
        Mon, 23 Jun 2025 19:23:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1241efbsm9057789a12.36.2025.06.23.19.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 05/16] iomap: add public helpers for uptodate state manipulation
Date: Mon, 23 Jun 2025 19:21:24 -0700
Message-ID: <20250624022135.832899-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new iomap_start_folio_write helper to abstract away the
write_bytes_pending handling, and export it and the existing
iomap_finish_folio_write for non-iomap writeback in fuse.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 20 +++++++++++++++-----
 include/linux/iomap.h  |  5 +++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 50cfddff1393..b4a8d2241d70 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1535,7 +1535,18 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+void iomap_start_folio_write(struct inode *inode, struct folio *folio,
+		size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
+	if (ifs)
+		atomic_add(len, &ifs->write_bytes_pending);
+}
+EXPORT_SYMBOL_GPL(iomap_start_folio_write);
+
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1546,6 +1557,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
 		folio_end_writeback(folio);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 /*
  * We're now finished for good with this ioend structure.  Update the page
@@ -1668,7 +1680,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len)
 {
 	struct iomap_ioend *ioend = wpc->wb_ctx;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	unsigned int ioend_flags = 0;
 	unsigned int map_len = min_t(u64, dirty_len,
@@ -1711,8 +1722,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
-	if (ifs)
-		atomic_add(map_len, &ifs->write_bytes_pending);
+	iomap_start_folio_write(wpc->inode, folio, map_len);
 
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
@@ -1880,7 +1890,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 * all blocks.
 		 */
 		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
-		atomic_inc(&ifs->write_bytes_pending);
+		iomap_start_folio_write(inode, folio, 1);
 	}
 
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 047100f94092..bfd178fb7cfc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -460,6 +460,11 @@ void iomap_sort_ioends(struct list_head *ioend_list);
 ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
+
+void iomap_start_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.1


