Return-Path: <linux-fsdevel+bounces-34808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF899C8E22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A430283489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393C170A1B;
	Thu, 14 Nov 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="08YR1BRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209818CC02
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598093; cv=none; b=NCzWjWsUB5GuQ9NTH8bS+3/30ZX1EQypVfuGKthDZl+hBYWGxb8x1cjfHzILLwHqR6F8cA9TVI+nzAig9B7Z3Emh4PinwLtZddrmb1sElzSUMRpZk6aT/EiXXIsqjDkvsH2/puCv5KXcuLPsRKKFHHFgtXcJ7KairZYC5K0kG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598093; c=relaxed/simple;
	bh=LKB5qmpxodZQRc7Oxubcf3TF1jie3lO8rGiyoHOU3+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8tnZroVtVNptU+/E9jYiJDpTKkwldRoxpXP4+Ym8B62/kibHBqf7gnyB9xwZlRrXibL1WRgZIUpgQIS73UOIphG8LYWwu2aBHryEVz0niOWSXsWFlFpO5ukdfKYPfGUjE091Pnvyq5eTajIbN7wd8GLWlkV1lTwkVXbhrSvi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=08YR1BRR; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2951f3af3ceso447821fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598090; x=1732202890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZIb5wvnGXtO89gOBSt/Tk4W0KJQpsBnaIBuXsS72Rg=;
        b=08YR1BRR7yCBt1JJYbgVC0Xty4xFN6eia0wi6XcpXntnDr49Q62c4zon5Qm9DAHzkp
         GH5nGsFMV2/o/Dr5EmvrtbleFFHcyNlcQnOeiMC0dPGIaaU/QBVGVnH4e/oORhDX2Tgj
         ul/UCZsvJ4OZcnROWf62ZTUetn58AWeDaW3PV2/xKkdnGzLzusJKs8Pvj8pFh3ZtcQWh
         oWsLks3kGL4HzhIc11x0p+JzK+rLkHwotvXwYQtJm4rA1RcgKAqAJbx9xV7poC3gpIhx
         oLcQk0py4rLNRStRwPHETNnGMECSRL5KP0D+Rz2q8Xsmvt8x1+2pOVkGEsp3eVV0m+Xm
         h1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598090; x=1732202890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZIb5wvnGXtO89gOBSt/Tk4W0KJQpsBnaIBuXsS72Rg=;
        b=V/hGYQg2+T/t6csr9/qP25sH9UFU93upnoT2rgw5TTkN/YlCRSP0ozWi3o6L1SGi98
         FogZfAhiuS5F+gWFdyG9LWy7oEtgnUjRTh/bdLnxBiezRhiBPjmx7lOHdY4uudQqxOyi
         GRmUI5dCodDlIwkJ9gdoajxJ1h5MNmFa5gxvRoesZeAKPGnrp1Df+5yx/4p/xSXw6bQ1
         ID8FQfBo9GJqkn+jOcCyd34jzoA1XIh93uXzE6jKV7aOZGvT//LTQMEhb1r8+pD+J/3S
         h0PoH3Fr5SrwFV2A079ZweDsot5jfC2rTXd1Im4Bz5lZALOBy5DSh+Le4f/1K3FygA9/
         52iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2uiuzJ4+HZcWMIXrAU9RQ5rwj5o+Ka0zFcnAIwzs1zA83S/9X2nszsefsDkxyDJt/jT2pcH5FMoIhBbiL@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZTkwYrEvXQDwVC2ESmBsqu9RV2Y202M2rkT09bZGHBUM8zZg
	YiTpD2p9HWTw7UqgWS/0mNNPqv9kg1iKKMwwsxSZ571M72euV8crEJQX7kg7KgA=
X-Google-Smtp-Source: AGHT+IF0BwKZuS0hD2QtJaajxUzrtQ2SwlZch/PHXd4jMsGrqLjoDD1qWu/LCzOrVtrsjrS2cDAn1Q==
X-Received: by 2002:a05:6870:910d:b0:277:c027:1960 with SMTP id 586e51a60fabf-29610376b59mr2544315fac.25.1731598090064;
        Thu, 14 Nov 2024 07:28:10 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:09 -0800 (PST)
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
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/17] mm/truncate: add folio_unmap_invalidate() helper
Date: Thu, 14 Nov 2024 08:25:10 -0700
Message-ID: <20241114152743.2381672-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a folio_unmap_invalidate() helper, which unmaps and invalidates a
given folio. The caller must already have locked the folio. Use this
new helper in invalidate_inode_pages2_range(), rather than duplicate
the code there.

In preparation for using this elsewhere as well, have it take a gfp_t
mask rather than assume GFP_KERNEL is the right choice. This bubbles
back to invalidate_complete_folio2() as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h |  2 ++
 mm/truncate.c           | 35 ++++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8afacb7520d4..d55bf995bd9e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -34,6 +34,8 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count);
 void kiocb_invalidate_post_direct_write(struct kiocb *iocb, size_t count);
 int filemap_invalidate_pages(struct address_space *mapping,
 			     loff_t pos, loff_t end, bool nowait);
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp);
 
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd340a46..6ea16c537534 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -547,12 +547,12 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * sitting in the folio_add_lru() caches.
  */
 static int invalidate_complete_folio2(struct address_space *mapping,
-					struct folio *folio)
+				      struct folio *folio, gfp_t gfp_mask)
 {
 	if (folio->mapping != mapping)
 		return 0;
 
-	if (!filemap_release_folio(folio, GFP_KERNEL))
+	if (!filemap_release_folio(folio, gfp_mask))
 		return 0;
 
 	spin_lock(&mapping->host->i_lock);
@@ -584,6 +584,25 @@ static int folio_launder(struct address_space *mapping, struct folio *folio)
 	return mapping->a_ops->launder_folio(folio);
 }
 
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp)
+{
+	int ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (folio_test_dirty(folio))
+		return 0;
+	if (folio_mapped(folio))
+		unmap_mapping_folio(folio);
+	BUG_ON(folio_mapped(folio));
+
+	ret = folio_launder(mapping, folio);
+	if (!ret && !invalidate_complete_folio2(mapping, folio, gfp))
+		return -EBUSY;
+	return ret;
+}
+
 /**
  * invalidate_inode_pages2_range - remove range of pages from an address_space
  * @mapping: the address_space
@@ -641,18 +660,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				folio_unlock(folio);
 				continue;
 			}
-			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);
-
-			if (folio_mapped(folio))
-				unmap_mapping_folio(folio);
-			BUG_ON(folio_mapped(folio));
-
-			ret2 = folio_launder(mapping, folio);
-			if (ret2 == 0) {
-				if (!invalidate_complete_folio2(mapping, folio))
-					ret2 = -EBUSY;
-			}
+			ret2 = folio_unmap_invalidate(mapping, folio, GFP_KERNEL);
 			if (ret2 < 0)
 				ret = ret2;
 			folio_unlock(folio);
-- 
2.45.2


