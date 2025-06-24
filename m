Return-Path: <linux-fsdevel+bounces-52675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9EFAE5A11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205C71BC19B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66F26057A;
	Tue, 24 Jun 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWp4ewwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD0221DA8;
	Tue, 24 Jun 2025 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731803; cv=none; b=SmsaDXMTdoB+Z46GE0bhLqZx/O5te8VRYoaOkgU86IqOu1MyJcBwaoNtS0ER0oO5am1ec4A2c6hJpUPWRsVLCC4ivR6MUkDPHGMYc6Lqfp1DfObGCYKzXD+dWi6SjDl2maO9XvPYhyM2JdYslTZS41BC4E2GHwvGwJ4V/yIg6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731803; c=relaxed/simple;
	bh=MmTF11Eh53lyUsKigZr6Fn3JQ/uNC689oDShC9TGW7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hi3hxb/jGdvnCyX/IaQ1y4ZvMYF10l2mLd0RmSgWgG83NRl4rPke4TrwTlUdCuq0JEZMw+/NWEGH5BkQi2GVju3/RGVI4FIeMQ9QhDcIvozxXtFAzsEpZSn/1mfxHA50SjRXhB5IIZiPTq7juxSwEtsK+kgkACK6qmhAayYrQAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWp4ewwt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so3648280a12.3;
        Mon, 23 Jun 2025 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731798; x=1751336598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uC/d4QEJK/ybiLqfNK3ZCfjMshm+NbPOWFShLOrM9I=;
        b=dWp4ewwtUU19DWGRMgdzVJHiEITUCohq29EV9EzfodCMOWRRys1X/tQuX4gOgNx/7L
         oxF6gRsqrWE0bdYr6IqOkuzglEgl8Hvu2Z28gmeB+LkYNHlMU0oYR0jNKBBEOfwUYz8s
         +xR4jwKrf7Ko51kemFF++b3UhXpxsawHD07D4gczBt4gMZ4/n0BY3n4h/as6i0JCUzlN
         OsujPY6UhEcDPeZcsqVFxcCKkqTfj69bpwCHf/Br70Z1nuDFZnxEBZ673inFTSVr32r8
         n1Xj2KJoOpUUUZHZCVwVFyV9Ixfm3QRZvLDVSYhoI+b1ziqkJKx6i/XB8mO0Rcczo10w
         0QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731798; x=1751336598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uC/d4QEJK/ybiLqfNK3ZCfjMshm+NbPOWFShLOrM9I=;
        b=PDH28Q4QcFkmml2NYx7mGNnGxsrFc7+jt51TB2LYaev5eFRmnCSWMW03IgZb5s559U
         Siu84lx0Sb6Zr7/lprcnbluogxCZE+8P3INwGvVCJiuFUqaf2D2ZSsSL2vGpjqr1XRf2
         h6K0JrGqnBNTVfYlwEzpKycG5gFrJzffltrzvYSfAuOQsgKPCctDVr4S5w3F+nQ+AKNJ
         WAaC3G62+ThKIVIzVd2OJ7iJXjHtrp/CwWAdiR8B/4rX5wnK2aGowXjfRxY7NMKBWvIU
         NNc83yGQEI2Xii2YY/D7GiJ7ewJwv47pXfEqmAkJwCH9A5rRajxsMoIm9vmy+VjUfDNi
         5obw==
X-Forwarded-Encrypted: i=1; AJvYcCVH0j0qDXRionjHtftcv4I1Ga0l0PFF2WBN67paGf6m/xK0vv0TTCWYGRqzBMKZA+lxlp5Tf7k09gdvwQ==@vger.kernel.org, AJvYcCWqcrP/GDv0R2IYERriJF+YrzD5SbnmLHp06fwhwJjD5QL1NkbB/erruRhcsKqwjBi5vaetSmzNIUKx@vger.kernel.org, AJvYcCXj+th2gGFKZF0qsaMZTitTgHZklsJfiUtpL1OIwHvZvRs0A+dlOaMNrzdhM7BeIRAAllwpnuvtfsG4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2B8naDby8edsUh+3y3HoJC1Mi8plR+o72gBzX6GjJyYs+ndNX
	SVlcnl13B2xODQFtfiIVvppxkNneqGyagw54kRYDxeGuRu7R+dRxxbtX016+rg==
X-Gm-Gg: ASbGncsUH7QAxYBSKtlhkFvVFo97W/T072bnmgp6Bqb89tEYdQeH0ouk0i93FEdDtUh
	/iy/3b3svozeBVeD3d9AErmNwI4n2kj/kpis4pvKPD73tJL2qqgjPOVdgjyWGmiIvVjSIDICr24
	s3/1ktG1VWi+r5F0kJIzVSPrQr2rm7i1GSH9DanQqXw9e6WhGbvrODJYExrdgIeDCmAd0SQoB4x
	+IkkoMnD5NgkZXpOAI5ssT5KuKvg1JBWXGq/vFaZDeWMEoHebDtDm4aVxsc7WFRB6xeaWJRTGq1
	ozm7R8dzq1H87XywX/0GRcnCpeUOlquQK5HSHEee+TwbCLHwWTqpIznn
X-Google-Smtp-Source: AGHT+IE5q/BmXMe/ZkM4s7fJps6P7YPv0Tca4e+BXB9TjXlzT9WwpbxPPeo9qsYqSSWrVdQBTyG4Eg==
X-Received: by 2002:a17:90b:2c8d:b0:312:ffdc:42b2 with SMTP id 98e67ed59e1d1-3159d8d5910mr17771191a91.23.1750731797715;
        Mon, 23 Jun 2025 19:23:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860b8c9sm93534445ad.131.2025.06.23.19.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:17 -0700 (PDT)
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
Subject: [PATCH v3 14/16] fuse: use iomap for folio laundering
Date: Mon, 23 Jun 2025 19:21:33 -0700
Message-ID: <20250624022135.832899-15-joannelkoong@gmail.com>
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

Use iomap for folio laundering, which will do granular dirty
writeback when laundering a large folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 52 ++++++++++++--------------------------------------
 1 file changed, 12 insertions(+), 40 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2b4b950eaeed..35ecc03c0c48 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2062,45 +2062,6 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
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


