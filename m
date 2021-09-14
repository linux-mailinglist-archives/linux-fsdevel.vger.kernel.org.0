Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7A40B705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhINSiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhINSiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:38:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAA8C061574;
        Tue, 14 Sep 2021 11:37:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q22so245269pfu.0;
        Tue, 14 Sep 2021 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czAkFfe1mpXdw9DjxU44hTrmwIzU1RlZ33B1Yq/O+QA=;
        b=SpGtB4dQ2h7N0KeImNRd34t3WctAxXNt9m+PStBgb6Df0wowqg9AwiCdNjRFyDHjz6
         4QCfJr4tjmMSfAy/ibh8kMct1O/0//1j4HrLK3FLl3D8jeUyIepPvCl1sKYS7KqRWG+L
         3ZNxwpxvmv2Ry9WCJIx68yHGpg+6W28EzF9ZXPcgdGLIkF6ZGz5tCpL0N9JohCBSV/aC
         3m8qkYXhwMt2oojpPg+yy+ArHhHL2IGinpyAjJjRxILpQdcMgCe7MX5UtUBtIwmJZ9Qz
         KEPP7HKpVqVUhsazy+Be6g+Ri8N0pAGajBMPW5Y/8kA6Jwd/UAb5odcRpoTk69sBD+v3
         Uphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czAkFfe1mpXdw9DjxU44hTrmwIzU1RlZ33B1Yq/O+QA=;
        b=5P8kPA8Slq9Mz7KQC4WNL7tknZAccwjZLC1Ha8vztrfx2USIwOmj4nYo46inkprGoY
         6QwplUkfsQ5fdryO0sdADApDh8IBXIkVcx2VMFUxZDrVCK89KOfAxz/2c+L4FdYgR8bY
         n0VJvDevVqFtME6tSOntcXeMZYBPIurgFKqcdSYn3M466Kjke5pT9wJPaWR2Hr2NkW5x
         4AukE4mSav1JYZ0tvwIf4tFf/B12KNBDzXzpy+AHEJID9dBmb9XFsjgPNe++yzrVHZlz
         De8GicIqIVTABsc2khWN00Cf1oRY7MbXn1Jspx0SKVw67B2GWNwy60fXeycJZIdYOrkk
         UhSg==
X-Gm-Message-State: AOAM532e+T0D2MlE5KmpCNreS/F1u0h+aO3L2lUIdxAFtoSlhHJWRbuv
        C8DJCCNWffjYDjGuas9JhIA=
X-Google-Smtp-Source: ABdhPJx0nfeSQkT4y1cLquZT7sl2PsodSVN3cA2O8jZYC3O6mntx+Hvq5N95ug0Oe5Z3QSgKGKLllg==
X-Received: by 2002:a62:7dd3:0:b0:438:a22:a49c with SMTP id y202-20020a627dd3000000b004380a22a49cmr6119204pfc.44.1631644652890;
        Tue, 14 Sep 2021 11:37:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y3sm12003965pge.44.2021.09.14.11.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:37:32 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: filemap: check if any subpage is hwpoisoned for PMD page fault
Date:   Tue, 14 Sep 2021 11:37:15 -0700
Message-Id: <20210914183718.4236-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210914183718.4236-1-shy828301@gmail.com>
References: <20210914183718.4236-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When handling shmem page fault the THP with corrupted subpage could be PMD
mapped if certain conditions are satisfied.  But kernel is supposed to
send SIGBUS when trying to map hwpoisoned page.

There are two paths which may do PMD map: fault around and regular fault.

Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault()
codepaths") the thing was even worse in fault around path.  The THP could be
PMD mapped as long as the VMA fits regardless what subpage is accessed and
corrupted.  After this commit as long as head page is not corrupted the THP
could be PMD mapped.

In the regulat fault path the THP could be PMD mapped as long as the corrupted
page is not accessed and the VMA fits.

Fix the loophole by iterating all subpage to check hwpoisoned one when doing
PMD map, if any is found just fallback to PTE map.  Such THP just can be PTE
mapped.  Do the check in the icache flush loop in order to avoid iterating
all subpages twice and icache flush is actually noop for most architectures.

Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/filemap.c | 15 +++++++++------
 mm/memory.c  | 11 ++++++++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index dae481293b5d..740b7afe159a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3195,12 +3195,14 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	}
 
 	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
-	    vm_fault_t ret = do_set_pmd(vmf, page);
-	    if (!ret) {
-		    /* The page is mapped successfully, reference consumed. */
-		    unlock_page(page);
-		    return true;
-	    }
+		vm_fault_t ret = do_set_pmd(vmf, page);
+		if (ret == VM_FAULT_FALLBACK)
+			goto out;
+		if (!ret) {
+			/* The page is mapped successfully, reference consumed. */
+			unlock_page(page);
+			return true;
+		}
 	}
 
 	if (pmd_none(*vmf->pmd)) {
@@ -3220,6 +3222,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 		return true;
 	}
 
+out:
 	return false;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..1765bf72ed16 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3920,8 +3920,17 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (unlikely(!pmd_none(*vmf->pmd)))
 		goto out;
 
-	for (i = 0; i < HPAGE_PMD_NR; i++)
+	for (i = 0; i < HPAGE_PMD_NR; i++) {
+		/*
+		 * Just backoff if any subpage of a THP is corrupted otherwise
+		 * the corrupted page may mapped by PMD silently to escape the
+		 * check.  This kind of THP just can be PTE mapped.  Access to
+		 * the corrupted subpage should trigger SIGBUS as expected.
+		 */
+		if (PageHWPoison(page + i))
+			goto out;
 		flush_icache_page(vma, page + i);
+	}
 
 	entry = mk_huge_pmd(page, vma->vm_page_prot);
 	if (write)
-- 
2.26.2

