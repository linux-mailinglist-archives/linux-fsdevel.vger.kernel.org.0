Return-Path: <linux-fsdevel+bounces-72833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7551CD038D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 865343005F1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C542B725;
	Thu,  8 Jan 2026 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjcuQVXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D5C41A05C
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876099; cv=none; b=h+wQQKK51/C0ACqNQUixPgWvDqLilcgNuBok4QTUrwWJXU3v5XK385nkYwMc6aoM+VuwfXOMfK9Yl55JoXsvxWDjLqW8o6fG0dxxEcYwQQROzmANOeyS3XThb/1ZNp2MwZHmqdtO0LQL/mhe4fAxTd5W3Jph8xNSLoi5w7Lp4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876099; c=relaxed/simple;
	bh=VS+/gAoKbos/G2h2ps++m25hUCMaeP2IET7fpDNECQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJouN7UnxbaqKsq2sp17S9oSRK/OjvDS6w4Ebcv/CuMXa0nXXKuBsyYb1mUZCzlYmyOQIV7Y1AQM5LoyOX6PeBZXUVsTGn19hsOeTCBVlV92BkPZJIPygcXxLtf8M4oJsXNLiQsCEqW8aPNcge2cUJjvMgtmnecxjYWseHp1bP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjcuQVXw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so1756061b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 04:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767876097; x=1768480897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxCHi6k3BTAzPt+DiJG3qCrr7/A1NponVT67aJszG2c=;
        b=BjcuQVXwOlomqvBflhiUiZ4h1pkqT1+JAo3VbiqKQD8PklKuy3U0w6p3b4J7bdRBZZ
         YOofUuMTK8+q0hi4Mx8J6kBe6dTqVS+v9XydGVPkiiPZ2YFFxTb1j07vYAS2Pz6VfDmA
         6/92rGSCuUfxKdmCMifxSP+7k76VPg2ZjHfRmDVEMcg0V1jPK1b9F2T1ikTFFiO/tyj0
         79nG3tO6ypWCCj25U5M830GJK8F1urhE75PWZ6iYzw6HzHsZaqaj/4MCHttRDsAZWQrB
         rTqiq8+5SD2Z/TNtry4RHGOHUp1kTPZUWDinqvu4bXJ40dgzf2NtwaQqQ6ATsMm/6zI2
         ajLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876097; x=1768480897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KxCHi6k3BTAzPt+DiJG3qCrr7/A1NponVT67aJszG2c=;
        b=cvPNYiRx63Ch+3+4CpMe07atdXz3aU4MF+2ju+svgo5nqmYxcqa5JcIBgZM+gz3E44
         blruaHu1sqlJ7tGfwPwrTwxi0w4CxwfR2VwlAdT/rnoOtq7b9Uq2EjIgQFzuVatOGZIB
         K/5L4PCIJOLJ23h3YMNiXiPZEsoTlH5oxoBODGVd9/8W84x0uHoKngiFYZvAWHWTY6Sx
         CFWu3HbKZPbGSdkBUpqR+8XZlRfF6cXSlbeuDIBYsHkXIARGXd7+/GaHG8/Sc+lIcqaO
         Cuu+7c8aX38TvRezZu5z+tdpn918O05Y5/BA6D2BFiY4Cbsqtbr333BeYRGmSlZrJcy7
         YtVg==
X-Forwarded-Encrypted: i=1; AJvYcCV0z4cVnu+Wz2/Kvf0hf+C74PYcqeA2TweUZf6Kfuaf4zF9sw28gF5vVvxK0k/0K6yiJsoz3g3an3d3Z9ex@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6fSByOOwlXEa+s4PWmlWViKETvFZXJeF0ShsPJjgBLFTKRijK
	fkzQ2FdkO/rehwCgUwEiFXLraVl2tkpClPi+wpLbz0n0uiJmFIRKnsa/cUBtnA==
X-Gm-Gg: AY/fxX4FMHWaqo+DuD/ulKEamrex5DmV0dM3MjGfXDwxO1uBcY55qllmaF0ibINPZKb
	XqajPJDUK4/09Sl6gEjYAOcaDgcs2BU8zjnzVxHOzamDmGlUT8lKwYRfFKWFBbsNMGfytwx6TUE
	fpHrXqy2iVe0fNhMFXUYjbiad9GVM/z7Z1yDQM9a2+7RHQ5Fb6mswf138yOjmdg9IsHWWhiNcZn
	eaw9kCsBie1BrVAMNj3M2ts6R5EaSPnHWyB7lV5ERgogDTfMzhQpSqlGrHCb2G87Co60z2nEURL
	JPMs7keGqClxnBOQeAs9tbBX4KxsoFV3UOkivGf+0SEgMy2jeQagdtB4ooTsfk9joMSLz42flFC
	aBgtPEPDOSIKNZxRVydyYLlVrlToMRsy1P+Qd4/75EW04mDWvK2+t2f9SVuY+rL8Q65V02ou+1q
	mxkOQ=
X-Google-Smtp-Source: AGHT+IGFPwjr7ZXnjyyaZYR82RM8pvdbLcnYiqzU0HmuuaMkGXIPbglQBcvVQCJYW+fo7AOVgmW9fg==
X-Received: by 2002:a05:6a00:440a:b0:819:4284:365b with SMTP id d2e1a72fcca58-81b7d95f67emr5867252b3a.7.1767876097266;
        Thu, 08 Jan 2026 04:41:37 -0800 (PST)
Received: from localhost ([2a12:a304:100::205b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81c96d762f8sm2423491b3a.64.2026.01.08.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:41:36 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com
Subject: [PATCH 2/2] Fix an AB-BA deadlock in hugetlbfs_punch_hole() involving page migration.
Date: Thu,  8 Jan 2026 20:39:25 +0800
Message-ID: <20260108123957.1123502-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108123957.1123502-1-wangjinchao600@gmail.com>
References: <20260108123957.1123502-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The deadlock occurs due to the following lock ordering:

Task A (punch_hole):             Task B (migration):
--------------------             -------------------
1. i_mmap_lock_write(mapping)    1. folio_lock(folio)
2. folio_lock(folio)             2. i_mmap_lock_read(mapping)
   (blocks waiting for B)           (blocks waiting for A)

Task A is blocked in the punch-hole path:
  hugetlbfs_fallocate
    hugetlbfs_punch_hole
      hugetlbfs_zero_partial_page
        filemap_lock_hugetlb_folio
          filemap_lock_folio
            __filemap_get_folio
              folio_lock

Task B is blocked in the migration path:
  migrate_pages
    migrate_hugetlbs
      unmap_and_move_huge_page
        remove_migration_ptes
          __rmap_walk_file
            i_mmap_lock_read

To break this circular dependency, use filemap_lock_folio_nowait() in
the punch-hole path. If the folio is already locked, Task A drops the
i_mmap_rwsem and retries. This allows Task B to finish its rmap walk
and release the folio lock.

Link: https://lore.kernel.org/all/68e9715a.050a0220.1186a4.000d.GAE@google.com

Reported-by: syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 fs/hugetlbfs/inode.c    | 34 +++++++++++++++++++++++-----------
 include/linux/hugetlb.h |  2 +-
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3b4c152c5c73..e903344aa0ec 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -653,17 +653,16 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
 
-static void hugetlbfs_zero_partial_page(struct hstate *h,
-					struct address_space *mapping,
-					loff_t start,
-					loff_t end)
+static int hugetlbfs_zero_partial_page(struct hstate *h,
+				       struct address_space *mapping,
+				       loff_t start, loff_t end)
 {
 	pgoff_t idx = start >> huge_page_shift(h);
 	struct folio *folio;
 
 	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio))
-		return;
+		return PTR_ERR(folio);
 
 	start = start & ~huge_page_mask(h);
 	end = end & ~huge_page_mask(h);
@@ -674,6 +673,7 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 
 	folio_unlock(folio);
 	folio_put(folio);
+	return 0;
 }
 
 static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
@@ -683,6 +683,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	struct hstate *h = hstate_inode(inode);
 	loff_t hpage_size = huge_page_size(h);
 	loff_t hole_start, hole_end;
+	int rc;
 
 	/*
 	 * hole_start and hole_end indicate the full pages within the hole.
@@ -698,12 +699,18 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		return -EPERM;
 	}
 
+repeat:
 	i_mmap_lock_write(mapping);
 
 	/* If range starts before first full page, zero partial page. */
-	if (offset < hole_start)
-		hugetlbfs_zero_partial_page(h, mapping,
-				offset, min(offset + len, hole_start));
+	if (offset < hole_start) {
+		rc = hugetlbfs_zero_partial_page(h, mapping, offset,
+						 min(offset + len, hole_start));
+		if (rc == -EAGAIN) {
+			i_mmap_unlock_write(mapping);
+			goto repeat;
+		}
+	}
 
 	/* Unmap users of full pages in the hole. */
 	if (hole_end > hole_start) {
@@ -714,9 +721,14 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	}
 
 	/* If range extends beyond last full page, zero partial page. */
-	if ((offset + len) > hole_end && (offset + len) > hole_start)
-		hugetlbfs_zero_partial_page(h, mapping,
-				hole_end, offset + len);
+	if ((offset + len) > hole_end && (offset + len) > hole_start) {
+		rc = hugetlbfs_zero_partial_page(h, mapping, hole_end,
+						 offset + len);
+		if (rc == -EAGAIN) {
+			i_mmap_unlock_write(mapping);
+			goto repeat;
+		}
+	}
 
 	i_mmap_unlock_write(mapping);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 019a1c5281e4..ad55b9dada0a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -814,7 +814,7 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
 				struct address_space *mapping, pgoff_t idx)
 {
-	return filemap_lock_folio(mapping, idx << huge_page_order(h));
+	return filemap_lock_folio_nowait(mapping, idx << huge_page_order(h));
 }
 
 #include <asm/hugetlb.h>
-- 
2.43.0


