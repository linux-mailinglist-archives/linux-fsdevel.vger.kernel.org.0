Return-Path: <linux-fsdevel+bounces-27826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA269645C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682E21F26BD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A81AAE1A;
	Thu, 29 Aug 2024 13:06:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9D18E025;
	Thu, 29 Aug 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936814; cv=none; b=C+n/1QyewJsRqJv0w3zqz0BqZEN1RYTqXzob1MCE0oUO4anp+atzmGI6E8+oeP03F/2dlCoqr62whg8zA44rj0KUqAMx+ztLjblvWdfJizyA/oGaOehDqiPcQwzTJ84+CVjKQZURRPvSPX5MVL9Mtz3UHfvQan6D9+/z96WYV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936814; c=relaxed/simple;
	bh=sCExCUfHMdEGWx2OjrtVjO6q8U6FER4U1oOTYm/bWCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GROZVogEH9kOSyf8sTX91wk0NnGnrNjoE89Sk0c6o1M7YiOzt4s1ItWSUHxP4HHpeEn6Tw6YeT2tJFz0zeqFH9YX7K30q8JiFi/+eK1zyZCfwykynGulu/8eI/HrDGaKSKTovfaxVgboPpvNqs63WoMlHNKlVzjKhZSDEWAEhFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bac9469e8so5595095e9.3;
        Thu, 29 Aug 2024 06:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724936811; x=1725541611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na+pfHlILNHK+EXFKBw4Ty4J48ZbVmHFdbNMmjF4Iuk=;
        b=GBkbt+Uke1AlMc86OitjNrgQ53+lw1pghQt4uZnc89qW7fNG3glafGuIvfSBmHxg4Q
         wggB/y1w8YDreq4IGXoebeNP8uUlvi8s79pbbhRUr6ZF3MR7OqfxSfiTBaomL9J1IGoC
         dYee8fQC1bzbKF4b7x+hHeAkJGdH2iemLPONdAun/pGuXsQh5pjvatzxllz4DNtJGIe5
         xW2c4OELFJJpTq4FwJWzJvQysl8L326XrWOTlyxKjjaaNJjM/k5IN2zXzxR243za8xWV
         FEZOeuFm2fvHoTOPSVT9QwLRlDU1URLp/y0wjWsq2O7CGfpMsp3lLEj3SzNPygsVYd04
         lPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIUQaZtckiGh/AB7+C/OZCGODqdocgQm6JTxuv10c1FyKsw4ap5WHbaaI15DwGmby53FdHzw+BmWvs@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4V5Qn571WQDYm2vME18s8sDfso/rpiUNK7tyFHZfDLk/2z8L
	SHL752fbJOl5cQFVFs9dllP3DhFcdKlrUbWjvUbV5aLcw7uTBzei3HXv+A==
X-Google-Smtp-Source: AGHT+IGQmQ0uYKWJeLBuzzbNV7xa+1/fgPAfaaVLvtbeq7rB6vK7sXMofMLU7ErAroX/3dT4ZDN+mg==
X-Received: by 2002:a05:600c:474c:b0:426:61ef:ec36 with SMTP id 5b1f17b1804b1-42bb01ca00bmr23806595e9.0.1724936810229;
        Thu, 29 Aug 2024 06:06:50 -0700 (PDT)
Received: from localhost.localdomain (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baa08d9f9sm39006215e9.32.2024.08.29.06.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:06:49 -0700 (PDT)
From: Michal Hocko <mhocko@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-raid@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH] fs: drop GFP_NOFAIL mode from alloc_page_buffers
Date: Thu, 29 Aug 2024 15:06:40 +0200
Message-ID: <20240829130640.1397970-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Hocko <mhocko@suse.com>

There is only one called of alloc_page_buffers and it doesn't require
__GFP_NOFAIL so drop this allocation mode.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 drivers/md/md-bitmap.c      | 2 +-
 fs/buffer.c                 | 5 +----
 include/linux/buffer_head.h | 3 +--
 3 files changed, 3 insertions(+), 7 deletions(-)

while looking at GFP_NOFAIL users I have encountered this left over.

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 08232d8dc815..db5330d97348 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -360,7 +360,7 @@ static int read_file_page(struct file *file, unsigned long index,
 	pr_debug("read bitmap file (%dB @ %llu)\n", (int)PAGE_SIZE,
 		 (unsigned long long)index << PAGE_SHIFT);
 
-	bh = alloc_page_buffers(page, blocksize, false);
+	bh = alloc_page_buffers(page, blocksize);
 	if (!bh) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/fs/buffer.c b/fs/buffer.c
index e55ad471c530..f1381686d325 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -958,12 +958,9 @@ struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
 }
 EXPORT_SYMBOL_GPL(folio_alloc_buffers);
 
-struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
-				       bool retry)
+struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size)
 {
 	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
-	if (retry)
-		gfp |= __GFP_NOFAIL;
 
 	return folio_alloc_buffers(page_folio(page), size, gfp);
 }
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 14acf1bbe0ce..7e903457967a 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -199,8 +199,7 @@ void folio_set_bh(struct buffer_head *bh, struct folio *folio,
 		  unsigned long offset);
 struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
 					gfp_t gfp);
-struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
-		bool retry);
+struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size);
 struct buffer_head *create_empty_buffers(struct folio *folio,
 		unsigned long blocksize, unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
-- 
2.46.0


