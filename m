Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA77F425B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 21:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbhJGTSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 15:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhJGTSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:18:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ABCC061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 12:16:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u18so28946778lfd.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGrdZURdyyQHH4I6fQnJVysH/ia90SNkjihwgft55Yw=;
        b=E7OLqO5oGH3PxMmtZPsYgd/cTqyTh9mX8w1VAUI/FW2Rf7o1rbJl9qcoKCF9mKbD4V
         sjt15yNOsZ8jrRq4TsqaZGOElRKcGV9UZbL27JYDHZgddxkMg7kl6c4wtx1gKYZL5R7Q
         Ivjqh1OdEv82usQ7O+uCy9Jm9eUXk/eHuhanHL44HPAkxXDnoZrvs8sbO/mf7fBS3HJK
         VlpPDKLdQ8wUNiA60IPaV8xNZq+iBCbabesw56Ba8WFKCqPVl3rnTIbNzdm8tl9wTQ2P
         HCFSDI9GaDgMviDg57N9XlZg0CCoaskxSo5jx6d1uLR06Q3hFQQNcCewmXBwGJChk5JC
         tfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGrdZURdyyQHH4I6fQnJVysH/ia90SNkjihwgft55Yw=;
        b=p0eNpiLa/Yv4Lv3NfZpYUHt0BUSl9y1KIz4F/oq0P+6YPKk3G3G8JNVuhAgwu4rk6T
         gVcJQcx0QsI9AwvrkVNZX9VQrC2vjff3wQgJyfcrHs1b1rEhuICbprg7Tx0vGpQUU7l7
         h4vM5z1cALB3utI4qboTJ+wSoeS3Na1sXpW4MrCfwiP6ErXdYYCMrlKCRZ8RDwYHuvh9
         DlRZtrMJelxLaTESUhsFySWV0jL/6ZGh6auBUbdag6WVaZjIjCSnW9s9cb445lsj5UQI
         cCUmzITqtJxzsnuGymLnOuaY2Yh3Ozf5rQIlyQXP5g3JUOZ+3SVHQVzc0JTPiSpTn/2w
         IjlA==
X-Gm-Message-State: AOAM531DccjAgA7uUULzG5+/ExnRP4ifG9h0/Xdw/Wy4iLduGhjKESOG
        9WgB9hNGFKMeLFYSv4ww5BDywdipWDWEeA==
X-Google-Smtp-Source: ABdhPJyXquLOrBn6+QTjHWLvDO5anfAO1SNWpRAG71gk74S3ZE4CcBzAy5tB0s7IdVyeYw6ZJh56Pg==
X-Received: by 2002:a05:6512:3b90:: with SMTP id g16mr692856lfv.216.1633634198810;
        Thu, 07 Oct 2021 12:16:38 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id t17sm17599lfl.223.2021.10.07.12.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:16:38 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, viresh.kumar@linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [RFC PATCH] fs: proc: task_mmu: fix sparse warnings
Date:   Thu,  7 Oct 2021 21:16:36 +0200
Message-Id: <20211007191636.541041-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When building the kernel with sparse enabled 'C=1' the following
warnings can be seen:

fs/proc/task_mmu.c:587:17: warning: context imbalance in 'smaps_pte_range' - unexpected unlock
fs/proc/task_mmu.c:1145:28: warning: context imbalance in 'clear_refs_pte_range' - unexpected unlock
fs/proc/task_mmu.c:1473:28: warning: context imbalance in 'pagemap_pmd_range' - unexpected unlock
fs/proc/task_mmu.c:1811:28: warning: context imbalance in 'gather_pte_stats' - unexpected unlock

Rework to add __acquire() and __release() to tell sparse that it is all good.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 fs/proc/task_mmu.c | 31 +++++++++++++++++++++++++++++++
 mm/huge_memory.c   |  4 +++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5..6b702c030802 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -584,6 +584,13 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
+		/*
+		 * Fake out sparse.
+		 * The pmd_lock are held in pmd_trans_huge_lock() and if we
+		 * get in here we have to unlock. We tell sparse that
+		 * everyting is as it should with the __acquire() directive.
+		 */
+		__acquire(ptl);
 		smaps_pmd_entry(pmd, addr, walk);
 		spin_unlock(ptl);
 		goto out;
@@ -1127,6 +1134,14 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
+		/*
+		 * Fake out sparse.
+		 * The pmd_lock are held in pmd_trans_huge_lock() and if we
+		 * get in here we have to unlock. We tell sparse that
+		 * everyting is as it should with the __acquire() directive.
+		 */
+		__acquire(ptl);
+
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
 			clear_soft_dirty_pmd(vma, addr, pmd);
 			goto out;
@@ -1418,6 +1433,14 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		pmd_t pmd = *pmdp;
 		struct page *page = NULL;
 
+		/*
+		 * Fake out sparse.
+		 * The pmd_lock are held in pmd_trans_huge_lock() and if we
+		 * get in here we have to unlock. We tell sparse that
+		 * everyting is as it should with the __acquire() directive.
+		 */
+		__acquire(ptl);
+
 		if (vma->vm_flags & VM_SOFTDIRTY)
 			flags |= PM_SOFT_DIRTY;
 
@@ -1804,6 +1827,14 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	if (ptl) {
 		struct page *page;
 
+		/*
+		 * Fake out sparse.
+		 * The pmd_lock are held in pmd_trans_huge_lock() and if we
+		 * get in here we have to unlock. We tell sparse that
+		 * everyting is as it should with the __acquire() directive.
+		 */
+		__acquire(ptl);
+
 		page = can_gather_numa_stats_pmd(*pmd, vma, addr);
 		if (page)
 			gather_stats(page, md, pmd_dirty(*pmd),
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5ea5f775d5c..c873bf5947ae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1833,8 +1833,10 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
 	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+			pmd_devmap(*pmd))) {
+		__release(ptl); /* fake out sparse */
 		return ptl;
+	}
 	spin_unlock(ptl);
 	return NULL;
 }
-- 
2.33.0

