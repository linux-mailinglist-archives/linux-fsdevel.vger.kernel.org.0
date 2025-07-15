Return-Path: <linux-fsdevel+bounces-55032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B88B067B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAD1563ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CC32727EC;
	Tue, 15 Jul 2025 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPJ0spVv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69527280F
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610976; cv=none; b=ge+p8sTeg2aHg9ajyzANv6ALm+vSFonsePxiAO4sinPmExpDKhFHpaG+0AiUcyaBCTxyFAfyfx9YxACEHHpGq2OAFZE/MLkuOqfQHxv61tkmfAEFn2M9FvqY8jZPBlzYLVz7oQLGv30V5IsLq+Ga3iBYu3LN/mWBajD9MC6EpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610976; c=relaxed/simple;
	bh=NRHeIqiKg3Yv5p7MRmAqOfKRk7HSUO+V6lqQSMqINsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRa9iNYR8bI3J/otbEqqU8q2fQaDCyRvvA9cGG+C43IX0mU1yG26b4pQQtoWcBrj0ce1sGXf4LHe3IkyuYDVrMgiRqcVrlh804HrFmgv1FT/LbSSsMjCQnnEtMN+ft0KFQSqIJfTvv/0kNUVIOYiqJTwHDhIVLrtqI71wCsRnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPJ0spVv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso5012737b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752610969; x=1753215769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs9yN9PGD1L1OEmPq++h55GCsJu9pG7dRg3ReubE/zg=;
        b=PPJ0spVvLusPGocbTzzilrnlCbCn9DsEpbzWpmTkdkZrTaWmkLs1ElEOLK0CUuWaKk
         sGGWTIheDa3+1qZC63mi7W0JAWDlf2+4Gi+9GdKjcke7HCnz/3McibYb8639RSjk9BZ8
         HSEg7ZAcD0woKI0iO3jINEpFHRT92xhp3U8aWMAIU6kG8/k/lFeF6xLltTbiEjRCHMSY
         20UvXTtcuZHFfsC7o2Vicy0t9yvEavQng11a+njM4UMnGWOlHoBe3cMDgc979Q1Wcg20
         8ybpj9KP2Fby6ht5nLYgP5Y6vrhC8//uirN9J5gGfO5wdicJ9r0OwCpuWedPqaHYu7XO
         cf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752610969; x=1753215769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cs9yN9PGD1L1OEmPq++h55GCsJu9pG7dRg3ReubE/zg=;
        b=VjUSy00TsHCRyew1p+Bi9XWtJrLp53H2AKY4XPA7fDi2YJIwMWULooKiPgx9pGeVLm
         GfpVoZXNnUh+hTZQuGvebdRIh2OBgJ35guf6qV5PnOB4X2AnYCIXL7RixtY4O728fPXo
         NM6zi9y4nHh+02hfoZgtxRRe4dDxLK2UZi3h3JdMwcNJNhmvBBgzN3hcgtfXY499iBLv
         nNW1uwZo5Gjpm0VVXv/8dzVZ+/W78/R/Ss7KAyfvuJVOyzpImd8szR3Hz4amVb+eHM6t
         SC5dUqS/qeZcSpwLdvqjyFQIt2UXpxf/rx2lmWvnBJATe4Jhvl9hAGnvp3wPiqTGT3Vy
         FNTw==
X-Gm-Message-State: AOJu0Yzh0eMAL6mxjDrI3cyTsngeofoYmbp4s0+0BzTy2w/ZYozFpw8U
	N4mNXL8j7Gs9By8b9LZfVC+ZDdN6tAmOHVjWlfxq9RO7jVKAzg6+FWmYz5+J3A==
X-Gm-Gg: ASbGnctnAUf6wkH45Q9rRcUvWpg1CB+nNi9yjdjpZBqPO61IAhep7Zr1xJVR+UayNM1
	12a+sZ8LLf9/pRE5n2qFVtH5Ql2ScaCPWPIV+UV1xnGXUgKcKLHdMGOMceTIafNhv1fDl8J7ubX
	4VdbPxzKw+YMVBt00GtREw6DLbLM8HJTAXydgxHzgaYPLVmiVDkGIDsZuegWo7n4lkGFuoFJ8Xe
	vLIw7+q1Uou9R6Zg1/WBm6yfpOr/wq4A0knk7nu3jdowutMohNoPynnqyt5k+PjgJDr+neTRmpF
	KrgEmXMXXFiwPy0C38YjU437bcy1eXfLiDvl/KKdSd+MXOpiBUL6cWIqptM5VDfpFaVEAah3xTd
	G1gnDJwtqYkHOj5sRTw==
X-Google-Smtp-Source: AGHT+IFYBMh/LH12+91fj9ANKjs5LTQg/ziZFuKpCXZCEt0ejULNLjVEInfbrT8UkgWR0oaAc1wVZA==
X-Received: by 2002:a05:6a00:170a:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-756ea0de0e8mr899797b3a.18.1752610969216;
        Tue, 15 Jul 2025 13:22:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9c75734sm12868157b3a.0.2025.07.15.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:22:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v5 3/5] fuse: use iomap for folio laundering
Date: Tue, 15 Jul 2025 13:21:20 -0700
Message-ID: <20250715202122.2282532-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250715202122.2282532-1-joannelkoong@gmail.com>
References: <20250715202122.2282532-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use iomap for folio laundering, which will do granular dirty
writeback when laundering a large folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 52 ++++++++++++--------------------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 93a96cdf56e1..0b57a7b0cd8e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2057,45 +2057,6 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 	return wpa;
 }
 
-static int fuse_writepage_locked(struct folio *folio)
-{
-	struct address_space *mapping = folio->mapping;
-	struct inode *inode = mapping->host;
-	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_writepage_args *wpa;
-	struct fuse_args_pages *ap;
-	struct fuse_file *ff;
-	int error = -EIO;
-
-	ff = fuse_write_file_get(fi);
-	if (!ff)
-		goto err;
-
-	wpa = fuse_writepage_args_setup(folio, 0, ff);
-	error = -ENOMEM;
-	if (!wpa)
-		goto err_writepage_args;
-
-	ap = &wpa->ia.ap;
-	ap->num_folios = 1;
-
-	folio_start_writeback(folio);
-	fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio));
-
-	spin_lock(&fi->lock);
-	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
-	fuse_flush_writepages(inode);
-	spin_unlock(&fi->lock);
-
-	return 0;
-
-err_writepage_args:
-	fuse_file_put(ff, false);
-err:
-	mapping_set_error(folio->mapping, error);
-	return error;
-}
-
 struct fuse_fill_wb_data {
 	struct fuse_writepage_args *wpa;
 	struct fuse_file *ff;
@@ -2281,8 +2242,19 @@ static int fuse_writepages(struct address_space *mapping,
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
+	struct fuse_fill_wb_data data = {
+		.inode = folio->mapping->host,
+	};
+	struct iomap_writepage_ctx wpc = {
+		.inode = folio->mapping->host,
+		.iomap.type = IOMAP_MAPPED,
+		.ops = &fuse_writeback_ops,
+		.wb_ctx	= &data,
+	};
+
 	if (folio_clear_dirty_for_io(folio)) {
-		err = fuse_writepage_locked(folio);
+		err = iomap_writeback_folio(&wpc, folio);
+		err = fuse_iomap_writeback_submit(&wpc, err);
 		if (!err)
 			folio_wait_writeback(folio);
 	}
-- 
2.47.1


