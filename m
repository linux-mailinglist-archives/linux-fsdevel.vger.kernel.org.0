Return-Path: <linux-fsdevel+bounces-51636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741BAD97C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DD94A2B43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BC201255;
	Fri, 13 Jun 2025 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eil3Z9Z+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76528DEFF;
	Fri, 13 Jun 2025 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851475; cv=none; b=vAwjzXlex4bSzS6wbrXCoq9EUSz8fayPGnRi0StO6O97w49dS5CM2w+65EU7do6tKvLuFblW9gsOj0DdLZX9XhBaTqBSlbEnm7pN4sliIccD5+iO3A1Na+RvWELXIp8+GmP9hr8S0HJ/E8RmCQyjoMQPY1xYFuKOhmo5sLYS0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851475; c=relaxed/simple;
	bh=CRpO5HWslGVe1mVubUd1qpcyu1VdwwXfQc1q5ExiwOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGOJwPVi8601cFhq4JJaUzyro7IlwYN8aavbG6F50eaznj7+ismYqKtQ9GsvVvQNuvd6pc+VHzXGOVOYyO3Pb7Pt9HOW99tc+3rAuHvlGqYKuwxUMXIDnbovqbKSyQWRCjJGLqRSN3+T/QA2htOd6X9snCEzW1hzxhXqs46drjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eil3Z9Z+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso2790605b3a.1;
        Fri, 13 Jun 2025 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851473; x=1750456273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQIpYOYUuDzPbBZ+4abJiyIL6wXC8+VZSXLNy/WG+KQ=;
        b=Eil3Z9Z+YLixr8nIWOFkJjHDR3QdlO2SUFy7e0cjGEb/GGFhEHKMgLABE8TgQ5Qqei
         53fIcdXwaHO40vcWIcmV9gH1M6ygWOc3huKQKfEusLnx0YX+ObJDn6qm5nzlA1r+2qBP
         iV87HfV+wsWmK9O1yeZdw1TpcNWa3FIXkvmnOVn1A7q+mssVziGUfSxfNAmw984MBeBc
         lm9koWCQfvPsCLYKQA+FyqdwugAfQvNdEydkcG6INB7pEJtTfdCqHcNcViT43nXFYEph
         NSjtv5DxnPCv8OCppxyFyW13J8uOEwQFUREoJeLm0ptt7qvUm3VtoTbEeqnDR2++8WQS
         ZpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851473; x=1750456273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQIpYOYUuDzPbBZ+4abJiyIL6wXC8+VZSXLNy/WG+KQ=;
        b=C2UCSSTGRUnN7/zIm98ZQ6y0aQWYpV01eKgq4GnvDsu3G0H1ZUpT9dlbruM++AJBpB
         t6O8p14wu7ydzu8TzqWit9IJrujv+QHIm+sOkfZUZ9Gr866/vRFFQVwATPsHKTwT+AC6
         hlnoJPn3K1NKi0UNaUHPSpWypU4mf5NxNZx2taSsvhT89t0+0aG2Dl0jMGkArulah4Qi
         n5JbxzWlM04Gg/2x7tIuwG/LiMdNLbVeT0M6n6VEkZWKO6tjX8Wky5cS9HLxjZqWjGg5
         jWOnwdOx8IVumg4Un7Q9kL4eL9OLgYX1f7Jt8rGAo4xjmWZSmlndacKnvhkqovWKR+pU
         YcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrymaf32c24CfYNrLRw71Z8N/m3vMReQUc54QtD3GBgAkKKx3iSrmXWm9keY4zTAZAtfR+Vgs5/4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfnFwUB8/tUw4Cm93M6/zQxIZ9/4wUmHuiObI8cFjtyBu/P/S
	v6D9Ti2WkAb2ZfftacjOOM7TUQtaSG1giiAuZi6CIOYcwwBhUVGIlkeCxZdRNg==
X-Gm-Gg: ASbGnctFC822Vx3RREcu5uOpbgD8rGlnZjTAaJpqzEKYIHlHwumZxbhDkE+jrH4UXxE
	h13OO3X7m/Kz99ToXN/RM2lYVy2AV0M7HtdK77/T3JdhNHILLYToHqCIag5CGsNPFFuwu8vl9fZ
	vPRD0sKpRPGMoQw6PY0Jd0W4wn2Izb8eCYJ9lxbQjqUUueDjA5cK1l0vdGgVWatPvbewbmzCYZT
	ujFnbpZpPKObBf5bCejYq/4WQmPF6OaSNx1R/Wb5QsjxbNZhD99BWwluu6eBfEMF1C5OVBtU4MT
	Gpw7sDlEvGYQqwNWOSsn2mQbcbIlQUw6LJaXJyj+vqBBCst4akc+VAXxFEksSuU9Offg
X-Google-Smtp-Source: AGHT+IE5FH6MPB03JlRyw/GyIjG6lTnLz5wtSqcWLHke4xPvkTW5Gd0PE6oPh33aSt3dxYfBJSoo0Q==
X-Received: by 2002:a05:6a00:10c9:b0:73d:fdd9:a55 with SMTP id d2e1a72fcca58-7489c46d13amr1524220b3a.8.1749851473332;
        Fri, 13 Jun 2025 14:51:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b2af2sm2138754b3a.119.2025.06.13.14.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:51:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 16/16] fuse: use iomap for folio laundering
Date: Fri, 13 Jun 2025 14:46:41 -0700
Message-ID: <20250613214642.2903225-17-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
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
---
 fs/fuse/file.c | 49 +++++++++----------------------------------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index db6804f6cc1d..800f478ad683 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2060,45 +2060,6 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
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
-	wpa = fuse_writepage_args_setup(folio, ff);
-	error = -ENOMEM;
-	if (!wpa)
-		goto err_writepage_args;
-
-	ap = &wpa->ia.ap;
-	ap->num_folios = 1;
-
-	folio_start_writeback(folio);
-	fuse_writepage_args_page_fill(wpa, folio, 0);
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
@@ -2275,8 +2236,16 @@ static int fuse_writepages(struct address_space *mapping,
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
+	struct fuse_fill_wb_data data = {
+		.inode = folio->mapping->host,
+	};
+	struct iomap_writepage_ctx wpc = {
+		.iomap.type = IOMAP_MAPPED,
+		.private = &data,
+	};
+
 	if (folio_clear_dirty_for_io(folio)) {
-		err = fuse_writepage_locked(folio);
+		err = iomap_writeback_dirty_folio(folio, NULL, &wpc, &fuse_writeback_ops);
 		if (!err)
 			folio_wait_writeback(folio);
 	}
-- 
2.47.1


