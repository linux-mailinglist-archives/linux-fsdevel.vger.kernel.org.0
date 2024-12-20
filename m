Return-Path: <linux-fsdevel+bounces-37958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76779F95D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8EE1897FCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945121C19F;
	Fri, 20 Dec 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GFIoSUsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EA21A423
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709725; cv=none; b=g2hLoXBzuDJinjgVsdCP+XWfwtGlPbs8JvDxCeG0j/S63WLOBCokSQRcYf9M01NzoI1nfEhlyGxX+PnJasHkYe4437Q4gqRVhq3D6ueMLAJ7CZiYCLUPtYuDX+sU4G9o9Z5kzJgwiJhTrx6NYHgkjQkZr+5Q5G1PuEdg0FoF4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709725; c=relaxed/simple;
	bh=hlD654noMspdeqksOMGzv5hrDtGKzL2oiFa3eBWzT6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJXLSj5fxCtSgXUYrQRngtaEv7ATTrYDWrTp4E9SsUpui0PqtF/wxV9nXHEdxzetYMMe3oqRuGUHh2Pjyc7z0qKVsHsv5+3UBWHEt8br5ZNtPnl214l6GaS9IaosCgnzLKfM9bXTtMUDqLcS5czzmnGoMpG78kYYIIo4SN/1asc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GFIoSUsA; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844ef6275c5so70171839f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709723; x=1735314523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hj114LsQAeZlZx1JIhp9yNhhSBSN5VfiZ1DE7mn9M1E=;
        b=GFIoSUsAw7RekpRQilDffDad1KbwSZM1hR0LU4Qn3qd5kH4bD6IlPJu6ZYVTgRnnJO
         OD36Oyg0QQoAICyGD8yqeDiGamkRD5sejSyB3N7ghYOf6U3+xdFTWsQsaaLSbvLy81ZP
         voY5m/+wX5ztbehFd1nKvmfI1KZmWRRldniEXZ7VMqJNi/naRHFQ/atyibjfZ28I0dNC
         6fr0u4rVA/B1zBrnszuq4a1EIo+FyC/L/tS/p7QGhi/1IUPqlaAhdBQKZG55disGFjS7
         Pxsia5sj1pcqLkPWF39CBq1ZGip4hwod6++xWDn/ca8awvF9pIIW/AfTgtnGpVdu65Cz
         SOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709723; x=1735314523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hj114LsQAeZlZx1JIhp9yNhhSBSN5VfiZ1DE7mn9M1E=;
        b=PEsOFHY9r+hljGR1vj1zcqFXfVfK20tyvHBCOmmIMD1+TDWvepL9Xj+dcRY9btTojD
         LbRQA04Gv3VYolNePqavrVczPDH+cKwkDbz8qik5Lv0DjSQG88CjXNa1KAcy0F5drAFP
         MOCxQjtRmRXyTrFquWyw0sJrKfo4K+QDGgDXqKW9ezpTU0vfQueTfk/2SqrraUH91dIG
         Qz7sQA3fSyMqHagXj1jO3Dg2YZcIUEscHmbNVNGsKLuID3j8ckR158GdhqSq2Vw8Nr+9
         ES8vmCPGuQvzesUNczq/jJEV5hZe31pkLAsAr4VJ4AJVXdpFaxhOwCd5w42YsxuDG987
         LOig==
X-Forwarded-Encrypted: i=1; AJvYcCWTmpWUiqKo6AnDZFUfvTgoTFaSc7L+nBrq32qck3xsvntlqqUONiin6M1GHYl17dpH5eMwHwKnAsRAq9SY@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoVE6wH/39rCIT+xxIHQ/MArZOwMNEbszqe8rIYcFOeHElJFU
	5JvP+ZUknBwYLS3qcxkelPZSLKemxRZxHkGZqWOWfU/yhu4l1Ge+rn7cGLn0Ir8=
X-Gm-Gg: ASbGncuHGwRbnjNOnG0s11ivBJ0NKemt0HnA3HLk7be1gPcm/OSH0Uf1oDjylORLS0y
	oTP0DTgFKimbO3+o1nSFCVN/lhYqthsG+DHSNiH2p7zIIKboSiTvye2hiyi0Bz2WNydkYUYnze+
	ciU60FvsH8aA0XgMjfLYYRnlT5LbMe3LyJnNaUv9HQj8u8aciNYhLKm4eoCVVPDKqa2y3I5UQU2
	FIT/eyiq3I01tuIPChAgtalrs7ONHhceYJMrgbYIlVWNww2izfcXkfAtB3F
X-Google-Smtp-Source: AGHT+IECOzR43hLv/D5wLt0YmDzKJdUpeT0f1YGhsBnnrmOZn/oym4rW0bRMY26iQGlNbtfBjUSBgg==
X-Received: by 2002:a05:6e02:3683:b0:3a7:8720:9de5 with SMTP id e9e14a558f8ab-3c2d1aa27e8mr34276355ab.1.1734709723099;
        Fri, 20 Dec 2024 07:48:43 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/12] mm/truncate: add folio_unmap_invalidate() helper
Date: Fri, 20 Dec 2024 08:47:44 -0700
Message-ID: <20241220154831.1086649-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a folio_unmap_invalidate() helper, which unmaps and invalidates a
given folio. The caller must already have locked the folio. Embed the
old invalidate_complete_folio2() helper in there as well, as nobody else
calls it.

Use this new helper in invalidate_inode_pages2_range(), rather than
duplicate the code there.

In preparation for using this elsewhere as well, have it take a gfp_t
mask rather than assume GFP_KERNEL is the right choice. This bubbles
back to invalidate_complete_folio2() as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/internal.h |  2 ++
 mm/truncate.c | 53 +++++++++++++++++++++++++++------------------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cb8d8e8e3ffa..ed3c3690eb03 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -392,6 +392,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp);
 
 void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
 		unsigned int order);
diff --git a/mm/truncate.c b/mm/truncate.c
index 7c304d2f0052..e2e115adfbc5 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -525,6 +525,15 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(invalidate_mapping_pages);
 
+static int folio_launder(struct address_space *mapping, struct folio *folio)
+{
+	if (!folio_test_dirty(folio))
+		return 0;
+	if (folio->mapping != mapping || mapping->a_ops->launder_folio == NULL)
+		return 0;
+	return mapping->a_ops->launder_folio(folio);
+}
+
 /*
  * This is like mapping_evict_folio(), except it ignores the folio's
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
@@ -532,14 +541,26 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * shrink_folio_list() has a temp ref on them, or because they're transiently
  * sitting in the folio_add_lru() caches.
  */
-static int invalidate_complete_folio2(struct address_space *mapping,
-					struct folio *folio)
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp)
 {
-	if (folio->mapping != mapping)
-		return 0;
+	int ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
-	if (!filemap_release_folio(folio, GFP_KERNEL))
+	if (folio_test_dirty(folio))
 		return 0;
+	if (folio_mapped(folio))
+		unmap_mapping_folio(folio);
+	BUG_ON(folio_mapped(folio));
+
+	ret = folio_launder(mapping, folio);
+	if (ret)
+		return ret;
+	if (folio->mapping != mapping)
+		return -EBUSY;
+	if (!filemap_release_folio(folio, gfp))
+		return -EBUSY;
 
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
@@ -558,16 +579,7 @@ static int invalidate_complete_folio2(struct address_space *mapping,
 failed:
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&mapping->host->i_lock);
-	return 0;
-}
-
-static int folio_launder(struct address_space *mapping, struct folio *folio)
-{
-	if (!folio_test_dirty(folio))
-		return 0;
-	if (folio->mapping != mapping || mapping->a_ops->launder_folio == NULL)
-		return 0;
-	return mapping->a_ops->launder_folio(folio);
+	return -EBUSY;
 }
 
 /**
@@ -631,16 +643,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 			}
 			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
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


