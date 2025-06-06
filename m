Return-Path: <linux-fsdevel+bounces-50881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE76AD0A62
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584C33B27D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1007241136;
	Fri,  6 Jun 2025 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxTascux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2C241103;
	Fri,  6 Jun 2025 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253374; cv=none; b=TYcV76zIMajvXZeucdxTZ28GdHeOoTK+bN+NmXmWqAZk5g3v5ljih1vVn6onU+4D9S1+PzXePIMhAouL0Adohw8TnQ8OuNRz3MwlQMvBbs9YskcPwY3qH2SlE/yixLQLssllpmii/Zpnf1Sa2rJQ8u8IXAG2SSwXeWuXIRjsoiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253374; c=relaxed/simple;
	bh=SiETsEX8tEg5QPB5hyj6KBeUkaqxVSzclZTUwHRfvZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sT+h3dJOgeEniSsNIJyB3nvL2HvqBJGBX2LEaDgPfP8mXroKJDPZokdfd50YuFTxZgd/k/PS6D9DLFbKxD4SyY6bVwR4fpdfMx7e8SDqUchRYVvsGHzNFyhYjbfRLOxkYftTMEkm1wMJDJQ92HO1vDOLg+Zlk+pZlQKhGphKq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxTascux; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so2147216a91.1;
        Fri, 06 Jun 2025 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253372; x=1749858172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keoGmjLJ1eCGITAefKbG0r5wq4ut/JqDr8ErugZ+G9o=;
        b=KxTascuxUSVaaXdM731Q9JybQ/AlImFwjuFtTrIwvFhRGJPcxSADnccXRmhbczvjtI
         cXnypJ4GZwqoadcWYWGg0i9oj+UCdbvJPwv4xcIQ/bwfRV/5siRqGHV+mDvIXOe1Ab+P
         ozKt5zXRY3dAEKnXFgpzeuoWEDiOCOABye6C5IsmfpJBozAM45gGrhFnEgDBV384O18X
         TxS98L2kgdIRCsTeeFLBC+/eRpdftKUTFe+oMhXO+/B35KK7A3NaNBFB5N3hxiazdJgy
         TBV+v7XUs3/1EXuhkKqA3O8TJaMJk5auxjEBB44eQz5xw6BmpaBXMl1xXX1mt3dXdgbe
         zyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253372; x=1749858172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keoGmjLJ1eCGITAefKbG0r5wq4ut/JqDr8ErugZ+G9o=;
        b=tEebpcDwUjLgMngw0wvSX+/uPh/078e8kMZyIueDHskaMj7+m8hna6EvkMOw3tWNCJ
         2tUo0yV9LcHnV/u94w5f+5M1pej9Kwcf7jYCU1CvN6J1UW/rhGQyqEux37EJGeKnHqSr
         k6Vm6FQhAtYxBphI4tjS7SUfD66Cd6pbBmNsCn3xGyptCT6aQTv62lYopidCoMwyoX84
         IeOmWlaxnR75T2lCvu97rzo2lVa+SlAvMGXRhdqPvV99OVccJzYcutPWMXajPv6Xq4Cw
         UJg1n5xl6z39hz33FOTD3GyGn2SiqhfB+Kr4/Sg77EWVZIEcaEdeXhXvNZwvABxwiqOJ
         Rh2w==
X-Forwarded-Encrypted: i=1; AJvYcCUtpn2PPXTf0ime/8YIHlYTd/64i7AROe7H4mMyFQf3oeWNFr0F+3GDlAippRDSPgWPCKRN0vYNKb8p@vger.kernel.org, AJvYcCVrSycfCtmQs8ySn+zIVKxCKnaOFoKW0NdqQVlJRnD5ddgxd2xQwSN1QPA2GgYk05wuiacQSgcjODLEJeCx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5XqvHVhWjsdLGODJRSQxOuZ2PlQAdbCaOMUo0EaHu/fHdHYa
	Dx21QKjCZbyFOj8ticKSrCScebh2FjATuJ0bfPLaaROEjvNemgwx+DkGldefaw==
X-Gm-Gg: ASbGncvC00pGfQHDfuIn0VK16MkXiLZsAndHHZMSZ49FWBzUXpP4q6uhPR5vOX4O74M
	Z14nnQlNgq5IIg+P+YV5lwnQ7K0zvSUXKBuv7rvULY1CMa2i0l0qfED/ZhJ+gJTaPJ6nzOrGDCl
	TKBTeMG45t/zmHEwQ21tT4eQGNvBC4TG8cgwDip6m6XO3PPwyhEMusA/s9Z9Eg9m3hV+tnPZGsw
	JBC6pl3mF0wH8oOewgEgQ2DqMCKFeqUJ10ttoOMJpTiKpwyqDSD3/V7wVVM+/XxonAI0Z+HgCjG
	smRvtwOsJPBuQYcx8WnKH37K58gmUxMGTJALkAhONlbeBw==
X-Google-Smtp-Source: AGHT+IFVfKkkAF5i6KAvVmbfHC8+eDz6d8DBu9dO0nqpfuTePljdb+gs8FRj6ZQBJ0CggXECRqFGaw==
X-Received: by 2002:a17:90a:d88d:b0:311:b0ec:1360 with SMTP id 98e67ed59e1d1-3134706d56bmr8176750a91.29.1749253371836;
        Fri, 06 Jun 2025 16:42:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405e7asm17698185ad.171.2025.06.06.16.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:42:51 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1 3/8] iomap: add buffered write support for IOMAP_IN_MEM iomaps
Date: Fri,  6 Jun 2025 16:37:58 -0700
Message-ID: <20250606233803.1421259-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add buffered write support for IOMAP_IN_MEM iomaps. This lets
IOMAP_IN_MEM iomaps use some of the internal features in iomaps
such as granular dirty tracking for large folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 24 +++++++++++++++++-------
 include/linux/iomap.h  | 10 ++++++++++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1caeb4921035..fd2ea1306d88 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -300,7 +300,7 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 
-	return srcmap->type != IOMAP_MAPPED ||
+	return (srcmap->type != IOMAP_MAPPED && srcmap->type != IOMAP_IN_MEM) ||
 		(srcmap->flags & IOMAP_F_NEW) ||
 		pos >= i_size_read(iter->inode);
 }
@@ -583,16 +583,26 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 					 pos + len - 1);
 }
 
-static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
-		size_t poff, size_t plen, const struct iomap *iomap)
+static int iomap_read_folio_sync(const struct iomap_iter *iter, loff_t block_start,
+				 struct folio *folio, size_t poff, size_t plen)
 {
-	return iomap_bio_read_folio_sync(block_start, folio, poff, plen, iomap);
+	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+
+	if (folio_ops && folio_ops->read_folio_sync)
+		return folio_ops->read_folio_sync(block_start, folio,
+						  poff, plen, srcmap,
+						  iter->private);
+
+	/* IOMAP_IN_MEM iomaps must always handle ->read_folio_sync() */
+	WARN_ON_ONCE(iter->iomap.type == IOMAP_IN_MEM);
+
+	return iomap_bio_read_folio_sync(block_start, folio, poff, plen, srcmap);
 }
 
 static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		size_t len, struct folio *folio)
 {
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_folio_state *ifs;
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
@@ -640,8 +650,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (iter->flags & IOMAP_NOWAIT)
 				return -EAGAIN;
 
-			status = iomap_read_folio_sync(block_start, folio,
-					poff, plen, srcmap);
+			status = iomap_read_folio_sync(iter, block_start, folio,
+						       poff, plen);
 			if (status)
 				return status;
 		}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index dbbf217eb03f..e748aeebe1a5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -175,6 +175,16 @@ struct iomap_folio_ops {
 	 * locked by the iomap code.
 	 */
 	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+
+	/*
+	 * Required for IOMAP_IN_MEM iomaps. Otherwise optional if the caller
+	 * wishes to handle reading in a folio.
+	 *
+	 * The read must be done synchronously.
+	 */
+	int (*read_folio_sync)(loff_t block_start, struct folio *folio,
+			       size_t off, size_t len, const struct iomap *iomap,
+			       void *private);
 };
 
 /*
-- 
2.47.1


