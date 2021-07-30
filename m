Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34303DB49E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbhG3Hm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhG3Hm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:42:26 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6136DC0613C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:42:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x9so5794882qtw.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=xThcyhwVzbZ0QG3SJMzciKfOkK2D1+jiVLTEbX6+zFE=;
        b=HbUlXvFb5XYC3VEXO+6211+jPIKP5PobcFagWqFtBrvjjP+Cxr4VLM1qLw4GnGiHY4
         7xuX0hmza/QU+KT850MEpof+IzVXeTzrcjvMq53TXy+7TpybwnXgNnwKRewAVUyTaNo8
         5AY/s0nJXhrf79mI3dagZwDRkRpk+In3d0tMkqp/K5cVNQhYSpZKOhBstMUE4HeEvmy1
         VCd6nPqLn/S/7f884daFRqK6jXJxIu/vJWh60QT2BMOpgippk7xNzyotPf3gqYxvjeKV
         nKAa/Z5XYPoOxmdZpLtRJqo4iGjrg3G4x11CRSjPTn786elcgmIVZ7SobbMWJkaG2gwv
         twWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=xThcyhwVzbZ0QG3SJMzciKfOkK2D1+jiVLTEbX6+zFE=;
        b=f+q0s9+RjSaK/IyS+Um84kmTmn8suAyzgzxhF/KnVJya+TVvkgFRhrIL5ajH2ky35w
         eMaEa6sR9NXeoOeR8bHfS5wN9eDHs2jWdffodBvIyE7t/rnKFUkwBMm2/Zxu4Kc1RVQK
         pSl3mA4eZ5PYlmiN3jVOgTE5O7hWRJUDS9wPdW0k3ms67vl4st2t6D04l44bjLvvwdiX
         EZ5uYDC1TzterkiiqW37XKdpAka6+OmP18j84xYUmbsu0sD5+cvQQ85sd9m7/VHIR3f4
         ck9+IrEUlGmbBE5Y1cU3fd1oU3zHq5Q5vgeDjAgsot625XbgwaMLQPRdUJmUigvRGrpE
         y3XA==
X-Gm-Message-State: AOAM530B+k3sBGi+PHq+zqf3SwJo9u1yAVpffDVPhpQqsQ/uC4tx7m2X
        llqIuPg0qLtZlNTG75sba+M0fQ==
X-Google-Smtp-Source: ABdhPJzarucL0DNU7lVhbHFW8SWRQUj2t3cj9hw+0XuyUqg25IndM2TpaLf5DYuxw/fq6deq1ypAvg==
X-Received: by 2002:ac8:72d6:: with SMTP id o22mr1139596qtp.177.1627630941171;
        Fri, 30 Jul 2021 00:42:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d79sm547197qke.45.2021.07.30.00.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:42:20 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:42:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 06/16] huge tmpfs: shmem_is_huge(vma, inode, index)
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extend shmem_huge_enabled(vma) to shmem_is_huge(vma, inode, index), so
that a consistent set of checks can be applied, even when the inode is
accessed through read/write syscalls (with NULL vma) instead of mmaps
(the index argument is seldom of interest, but required by mount option
"huge=within_size").  Clean up and rearrange the checks a little.

This then replaces the checks which shmem_fault() and shmem_getpage_gfp()
were making, and eliminates the SGP_HUGE and SGP_NOHUGE modes: while it's
still true that khugepaged's collapse_file() at that point wants a small
page, the race that might allocate it a huge page is too unlikely to be
worth optimizing against (we are there *because* there was at least one
small page in the way), and handled by a later PageTransCompound check.

Replace a couple of 0s by explicit SHMEM_HUGE_NEVERs; and replace the
obscure !shmem_mapping() symlink check by explicit S_ISLNK() - nothing
else needs that symlink check, so leave it there in shmem_getpage_gfp().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/shmem_fs.h |  9 +++--
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               | 84 ++++++++++++----------------------------
 3 files changed, 32 insertions(+), 63 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 9b7f7ac52351..3b05a28e34c4 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -86,7 +86,12 @@ extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 extern int shmem_unuse(unsigned int type, bool frontswap,
 		       unsigned long *fs_pages_to_unuse);
 
-extern bool shmem_huge_enabled(struct vm_area_struct *vma);
+extern bool shmem_is_huge(struct vm_area_struct *vma,
+			  struct inode *inode, pgoff_t index);
+static inline bool shmem_huge_enabled(struct vm_area_struct *vma)
+{
+	return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff);
+}
 extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
 extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 						pgoff_t start, pgoff_t end);
@@ -95,8 +100,6 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 enum sgp_type {
 	SGP_READ,	/* don't exceed i_size, don't allocate page */
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
-	SGP_NOHUGE,	/* like SGP_CACHE, but no huge pages */
-	SGP_HUGE,	/* like SGP_CACHE, huge pages preferred */
 	SGP_WRITE,	/* may exceed i_size, may allocate !Uptodate page */
 	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
 };
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b0412be08fa2..cecb19c3e965 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1721,7 +1721,7 @@ static void collapse_file(struct mm_struct *mm,
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_getpage(mapping->host, index, &page,
-						  SGP_NOHUGE)) {
+						  SGP_CACHE)) {
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
diff --git a/mm/shmem.c b/mm/shmem.c
index 740d48ef1eb5..6def7391084c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -474,39 +474,35 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /* ifdef here to avoid bloating shmem.o when not necessary */
 
-static int shmem_huge __read_mostly;
+static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-bool shmem_huge_enabled(struct vm_area_struct *vma)
+bool shmem_is_huge(struct vm_area_struct *vma,
+		   struct inode *inode, pgoff_t index)
 {
-	struct inode *inode = file_inode(vma->vm_file);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	loff_t i_size;
-	pgoff_t off;
 
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return false;
-	if (shmem_huge == SHMEM_HUGE_FORCE)
-		return true;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return false;
-	switch (sbinfo->huge) {
-	case SHMEM_HUGE_NEVER:
+	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
 		return false;
+	if (shmem_huge == SHMEM_HUGE_FORCE)
+		return true;
+
+	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
 		return true;
 	case SHMEM_HUGE_WITHIN_SIZE:
-		off = round_up(vma->vm_pgoff, HPAGE_PMD_NR);
+		index = round_up(index, HPAGE_PMD_NR);
 		i_size = round_up(i_size_read(inode), PAGE_SIZE);
-		if (i_size >= HPAGE_PMD_SIZE &&
-				i_size >> PAGE_SHIFT >= off)
+		if (i_size >= HPAGE_PMD_SIZE && (i_size >> PAGE_SHIFT) >= index)
 			return true;
 		fallthrough;
 	case SHMEM_HUGE_ADVISE:
-		/* TODO: implement fadvise() hints */
-		return (vma->vm_flags & VM_HUGEPAGE);
+		if (vma && (vma->vm_flags & VM_HUGEPAGE))
+			return true;
+		fallthrough;
 	default:
-		VM_BUG_ON(1);
 		return false;
 	}
 }
@@ -680,6 +676,12 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
+bool shmem_is_huge(struct vm_area_struct *vma,
+		   struct inode *inode, pgoff_t index)
+{
+	return false;
+}
+
 static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		struct shrink_control *sc, unsigned long nr_to_split)
 {
@@ -1829,7 +1831,6 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	struct shmem_sb_info *sbinfo;
 	struct mm_struct *charge_mm;
 	struct page *page;
-	enum sgp_type sgp_huge = sgp;
 	pgoff_t hindex = index;
 	gfp_t huge_gfp;
 	int error;
@@ -1838,8 +1839,6 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
 		return -EFBIG;
-	if (sgp == SGP_NOHUGE || sgp == SGP_HUGE)
-		sgp = SGP_CACHE;
 repeat:
 	if (sgp <= SGP_CACHE &&
 	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode)) {
@@ -1898,36 +1897,12 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	/* shmem_symlink() */
-	if (!shmem_mapping(mapping))
-		goto alloc_nohuge;
-	if (shmem_huge == SHMEM_HUGE_DENY || sgp_huge == SGP_NOHUGE)
+	/* Never use a huge page for shmem_symlink() */
+	if (S_ISLNK(inode->i_mode))
 		goto alloc_nohuge;
-	if (shmem_huge == SHMEM_HUGE_FORCE)
-		goto alloc_huge;
-	switch (sbinfo->huge) {
-	case SHMEM_HUGE_NEVER:
+	if (!shmem_is_huge(vma, inode, index))
 		goto alloc_nohuge;
-	case SHMEM_HUGE_WITHIN_SIZE: {
-		loff_t i_size;
-		pgoff_t off;
-
-		off = round_up(index, HPAGE_PMD_NR);
-		i_size = round_up(i_size_read(inode), PAGE_SIZE);
-		if (i_size >= HPAGE_PMD_SIZE &&
-		    i_size >> PAGE_SHIFT >= off)
-			goto alloc_huge;
 
-		fallthrough;
-	}
-	case SHMEM_HUGE_ADVISE:
-		if (sgp_huge == SGP_HUGE)
-			goto alloc_huge;
-		/* TODO: implement fadvise() hints */
-		goto alloc_nohuge;
-	}
-
-alloc_huge:
 	huge_gfp = vma_thp_gfp_mask(vma);
 	huge_gfp = limit_gfp_mask(huge_gfp, gfp);
 	page = shmem_alloc_and_acct_page(huge_gfp, inode, index, true);
@@ -2083,7 +2058,6 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
 	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
-	enum sgp_type sgp;
 	int err;
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
@@ -2146,15 +2120,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 		spin_unlock(&inode->i_lock);
 	}
 
-	sgp = SGP_CACHE;
-
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		sgp = SGP_NOHUGE;
-	else if (vma->vm_flags & VM_HUGEPAGE)
-		sgp = SGP_HUGE;
-
-	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, sgp,
+	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, SGP_CACHE,
 				  gfp, vma, vmf, &ret);
 	if (err)
 		return vmf_error(err);
@@ -3961,7 +3927,7 @@ int __init shmem_init(void)
 	if (has_transparent_hugepage() && shmem_huge > SHMEM_HUGE_DENY)
 		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
 	else
-		shmem_huge = 0; /* just in case it was patched */
+		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
 #endif
 	return 0;
 
-- 
2.26.2

