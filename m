Return-Path: <linux-fsdevel+bounces-34356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AACB9C4A96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC73B3026C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343001D0E22;
	Mon, 11 Nov 2024 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WGbnwRAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878B1CEEAE
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368950; cv=none; b=PSUpxBBTCxQrF70wZBP/QGe6GWjjFKfGKCSO562x2szJ0dEXZ4UwxdESRozTzqWZ+xMoaVMUxDD3qyULBMLmZbPvXKPNP38dVA+/6haOhgBFe1FELx+9BeKs/y9vQX5u2ZutJ/EBryhJLMykuQenDCuDDZxPn3e5pTaJB389+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368950; c=relaxed/simple;
	bh=3H9STUASulXCHklYsN+md87lfFFsAKUuDScGACrWthk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrk+MlA6jouIOQ3rm4fqDtKTE59kdXUxTf5dEDJKqj8fYjtvJoiNApm8LZeqLqWEFl+H6/RcsjoQ5BCnILljC+3Tfcyv6raNAp0WwnWSEBg36N3HjZDBnss637cwsRf1wX+ERQmwC/M/Q6QlQ3Y1TYp8JDVKcN92tLj80dXNM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WGbnwRAz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7240fa50694so3694854b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368948; x=1731973748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHHnA1NsQjr1van9cnJ+PQRWRXhY+a6ETIPA3kXFfjk=;
        b=WGbnwRAzgJm3+3+5ZZh9FBShx2KIOn2NTTzBoHktZzJOHXl3t4id/cPDN1e+rUQiBU
         14xIFWE3au5w4p74aS4ofWKaRtXVkO3/qJOYvxOa9DK7lXgKPVqOTvnvOTroUzTU4R9o
         yTc5LgquDoTMlNMq4sQNj0PoldwIuA1HDXJzVc2Eb0wxrOFOYmxWQabSPpcwgVVGVnSV
         YJocXfKgGi3Dok4YSDVx9AKXGsx5IcrltOEtwn40KK5746IONvoFHNFPePG6PdTEa/HY
         UweAPD7sA3aOe4BXT8VwEh0PWrjF22at1dimvtsVB04Wljk1rtpH9AplC5L3p2qoZqWw
         jHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368948; x=1731973748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHHnA1NsQjr1van9cnJ+PQRWRXhY+a6ETIPA3kXFfjk=;
        b=LBmxOyL+1eROex6Yk/kaJmoLHK+CCDupY/oAs7t/6nzoISxeNUjrb9DeZ51GVQyB/R
         12Jw3fyNsQ4SGG/DPxcvOevz1q/3Xetxtak4bswUo5UElJ1IKCLVEkTtCjnwLGCfglPC
         mzNNnRamuq/8XajTNeg+86wEJZ/IXCwJ6lRoOUf1lvh124MFoYXbGCdyKUCr78lypZDp
         860kVbaLQkYm+iDKJCM2RdxwgfpbQEXHcrK1OaMGcOGyl6bOXSDC/Q+b/2jt7lAr6tkB
         lqJiwmUhIcX139dphu2d2anJjqzUBDuyMM3obkKGAMRTDhoo1r3qPLsvaz/Q5wj6UnN5
         udUg==
X-Forwarded-Encrypted: i=1; AJvYcCWfT1800DIw/10H3Jk/+ViqJTGa19xR5vMV2qvBjNUNMnnzyDAMO/lAF8Z2MfSwsiB+8Z+F0W+dMaAgnQve@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkiYynS6LdQ2limSa2pgvNcnbdzeUeCM96Au6sOXmE4BboMO1
	atQYEg5ZRtvADq1EcpKU4o9uHhOWzGxP9ADfQH6OvNXiTuXr2THDxdKtNumvVrqUnGl/9leSeqM
	7ZbU=
X-Google-Smtp-Source: AGHT+IE+DUrjoGziw6EjyU9hF9MosU8fZ1F2/8qqkRJb8RqY6XTyhSKojrzpZHSNP9ce3wMHzfWwwA==
X-Received: by 2002:a05:6a00:181d:b0:720:aa27:2e45 with SMTP id d2e1a72fcca58-724132c535bmr19020120b3a.14.1731368948118;
        Mon, 11 Nov 2024 15:49:08 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:49:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/16] iomap: make buffered writes work with RWF_UNCACHED
Date: Mon, 11 Nov 2024 16:37:40 -0700
Message-ID: <20241111234842.2024180-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iomap buffered write support for RWF_UNCACHED. If RWF_UNCACHED is
set for a write, mark the folios being written with drop_writeback. Then
writeback completion will drop the pages. The write_iter handler simply
kicks off writeback for the pages, and writeback completion will take
care of the rest.

This still needs the user of the iomap buffered write helpers to call
iocb_uncached_write() upon successful issue of the writes.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap/buffered-io.c | 15 +++++++++++++--
 include/linux/iomap.h  |  4 +++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef0b68bccbb6..2f2a5db04a68 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -603,6 +603,8 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
+	if (iter->flags & IOMAP_UNCACHED)
+		fgp |= FGP_UNCACHED;
 	fgp |= fgf_set_order(len);
 
 	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
@@ -1023,8 +1025,9 @@ ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		const struct iomap_ops *ops, void *private)
 {
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct iomap_iter iter = {
-		.inode		= iocb->ki_filp->f_mapping->host,
+		.inode		= mapping->host,
 		.pos		= iocb->ki_pos,
 		.len		= iov_iter_count(i),
 		.flags		= IOMAP_WRITE,
@@ -1034,9 +1037,14 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		iter.flags |= IOMAP_UNCACHED;
 
-	while ((ret = iomap_iter(&iter, ops)) > 0)
+	while ((ret = iomap_iter(&iter, ops)) > 0) {
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			iter.iomap.flags |= IOMAP_F_UNCACHED;
 		iter.processed = iomap_write_iter(&iter, i);
+	}
 
 	if (unlikely(iter.pos == iocb->ki_pos))
 		return ret;
@@ -1770,6 +1778,9 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	size_t poff = offset_in_folio(folio, pos);
 	int error;
 
+	if (folio_test_uncached(folio))
+		wpc->iomap.flags |= IOMAP_F_UNCACHED;
+
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
 new_ioend:
 		error = iomap_submit_ioend(wpc, 0);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f61407e3b121..2efc72df19a2 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -64,6 +64,7 @@ struct vm_fault;
 #define IOMAP_F_BUFFER_HEAD	0
 #endif /* CONFIG_BUFFER_HEAD */
 #define IOMAP_F_XATTR		(1U << 5)
+#define IOMAP_F_UNCACHED	(1U << 6)
 
 /*
  * Flags set by the core iomap code during operations:
@@ -173,8 +174,9 @@ struct iomap_folio_ops {
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
 #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
 #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
+#define IOMAP_UNCACHED		(1 << 8) /* uncached IO */
 #ifdef CONFIG_FS_DAX
-#define IOMAP_DAX		(1 << 8) /* DAX mapping */
+#define IOMAP_DAX		(1 << 9) /* DAX mapping */
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-- 
2.45.2


