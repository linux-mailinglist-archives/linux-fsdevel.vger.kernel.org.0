Return-Path: <linux-fsdevel+bounces-41504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F5A30474
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 08:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA031665FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 07:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CDC1EBFE6;
	Tue, 11 Feb 2025 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KAVy5F4q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A711EB9F6
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258894; cv=none; b=LntzZV62RJusWPn3mF1kkL+r/tf43PomNKdRxkfcnuFHP0nkKlsixxS9TqMnw2USCzWfgv9McgjpeRbZEPfbvglHWEbYP3mHxgEyZoWisVNOG3ytqiNX1CweMNYYD0reqHZYJLwJ9/htJKwbEipo4rZSLbxj1Kpqip3HaomOcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258894; c=relaxed/simple;
	bh=xDphkzp7YOwassCx3klJnQSoSwa0N8eY8DjCLu7euf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tkAr9iUNQKx93uG2Wz3mhJiPl/SQTtVMUNJcAKy49xDMfDMwHmtnqBSjK/TB4C14LKXkxAiCdt9/jigTX/pYRyaMZ/bSld8uqKORpHMUC1Mr/ewI7hzxBkJuLNdL56PXghdwWEb5DQkxJTJoaB7b1dq+8xjZA9xOsNuAvWO+KoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KAVy5F4q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa0f222530so9586462a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 23:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739258892; x=1739863692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8JvwZe222+nCD5D0NlDaqFgopE4s8QEJ665TCjR17Q=;
        b=KAVy5F4qSoiLjA+7OYEDq7MqwzJY7gIB72ynzU1CY1DcFkTAYzC/kX8KGPZ4GVjiFW
         7z5mYuPFyWdKsTLBD4pVsBrC/+0GvFUMq043BmjnaBPwuMrDzm23jsqQQo2eBj3LvhEi
         WRL39VjNnuXSErih5638WF0lFM/CWPj4h2sMCI4cFMEzYVLhyNNAUpYm6uVDou36ZZmx
         uy4myemNHB1NzCjeH5oxHorWvbUE8Y6iiaNgUJfYdcvq22d/6MwpxDAZcrZ6+PQZJXCP
         UcSNLgat75JZ3zPkTmFa46XKnkSui333Tiw1vy/epquGXZPYreHjQOsTNWB9Lr+TjD9i
         0uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258892; x=1739863692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8JvwZe222+nCD5D0NlDaqFgopE4s8QEJ665TCjR17Q=;
        b=JIZF6W4lLhRbRF8el+pYEciF9aZnlUwQj+rfTPx80YPN6nyFu/mn06i6ygAQcjkGtj
         Ma8eYiLpHOnO6Yk2CM85tcNg+S61V2N5CbW/AqoExVEKn15ekkyXvpcSleYZKCUpM+me
         rvU/a2iLa8kV3d1jllBpsPJ32cHrYRPdMV2kDFS6fEKYZYBkdlyNIEhRmAMKzIbcRj9I
         xLmYemDihJ4ltgla1hb8UCgn50YzwGE4OXqdv0DpoCei9p5BsK+vlQkP+UmQFOrEGTQp
         ATEFthwq6D40f2TCSJ7TZ3bmxffl5DB6MNOsPaOyOysjfzKpYJDjF3IFx1hqnqO6BzBe
         GhDw==
X-Forwarded-Encrypted: i=1; AJvYcCUjW/FMUOoZ9YPzZolBcrGzHPmCA1CVA8cdQ8TMahatL8iu5zhNtfzAZV1VwY020M5T9sFgkz+2rkdf0cVo@vger.kernel.org
X-Gm-Message-State: AOJu0YyTv6rZRZwH9ye2rXZw7uGU738JYixNp+6uPRrkp0SfiyXg4uOx
	F26r7og775DcrbjsfHKMuoh+fbeUnp7Nmy/G8kMI1zj6Kob3Twf9Q6CyqdEXboI=
X-Gm-Gg: ASbGncueh4vfvZ+XbnV8QFn5ZKmvD8fJ4W+/GE9bc+M3vjD3CdhvRdK8+7iyfgGqgF8
	T6RHV33GP+EJ4cMUx+SpICzJGpi0RxytmGbt6y7Zp9eZnxzU1Ub8XMDl7KyDBfzvYuyysDP4Mlu
	7Zem3qCy8jmNTDkFlrkfR3ezd0ScCli/EjXvDHvK5fo1HJ+GH7LgAFwsLyRWxICrknHMdy5Ag/G
	9XfRJd3zNJXd4VqE6U6jfBppVHi1U9iKO/O+DVww2+EfvNj9QOA3YZ44LfsfMBthPjnlkhYhagE
	qHVYClK6jYozoj5Fmm2eKx3hzqOa2LHUup0BZjI/4OH3PiHAvnwuNiVd
X-Google-Smtp-Source: AGHT+IEGFQNt5sPJaZzJIBOUWjXNir7ONpzC/zGumrQumqkRxYesmObQGhXHsFIIUFr5ys2Z+8JnCg==
X-Received: by 2002:a05:6a21:350d:b0:1ed:9e58:5195 with SMTP id adf61e73a8af0-1ee03a45ccdmr32137005637.13.1739258891851;
        Mon, 10 Feb 2025 23:28:11 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad54a066811sm3946778a12.8.2025.02.10.23.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 23:28:11 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: brauner@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	quwenruo.btrfs@gmx.com,
	david@redhat.com,
	jannh@google.com,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	djwong@kernel.org,
	muchun.song@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: pgtable: fix incorrect reclaim of non-empty PTE pages
Date: Tue, 11 Feb 2025 15:26:25 +0800
Message-Id: <20250211072625.89188-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In zap_pte_range(), if the pte lock was released midway, the pte entries
may be refilled with physical pages by another thread, which may cause a
non-empty PTE page to be reclaimed and eventually cause the system to
crash.

To fix it, fall back to the slow path in this case to recheck if all pte
entries are still none.

Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
Reported-by: Christian Brauner <brauner@kernel.org>
Closes: https://lore.kernel.org/all/20250207-anbot-bankfilialen-acce9d79a2c7@brauner/
Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Closes: https://lore.kernel.org/all/152296f3-5c81-4a94-97f3-004108fba7be@gmx.com/
Tested-by: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a8196ae72e9ae..7c7193cb21248 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1721,7 +1721,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pmd_t pmdval;
 	unsigned long start = addr;
 	bool can_reclaim_pt = reclaim_pt_is_enabled(start, end, details);
-	bool direct_reclaim = false;
+	bool direct_reclaim = true;
 	int nr;
 
 retry:
@@ -1736,8 +1736,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	do {
 		bool any_skipped = false;
 
-		if (need_resched())
+		if (need_resched()) {
+			direct_reclaim = false;
 			break;
+		}
 
 		nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, rss,
 				      &force_flush, &force_break, &any_skipped);
@@ -1745,11 +1747,20 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			can_reclaim_pt = false;
 		if (unlikely(force_break)) {
 			addr += nr * PAGE_SIZE;
+			direct_reclaim = false;
 			break;
 		}
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
-	if (can_reclaim_pt && addr == end)
+	/*
+	 * Fast path: try to hold the pmd lock and unmap the PTE page.
+	 *
+	 * If the pte lock was released midway (retry case), or if the attempt
+	 * to hold the pmd lock failed, then we need to recheck all pte entries
+	 * to ensure they are still none, thereby preventing the pte entries
+	 * from being repopulated by another thread.
+	 */
+	if (can_reclaim_pt && direct_reclaim && addr == end)
 		direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
 
 	add_mm_rss_vec(mm, rss);
-- 
2.20.1


