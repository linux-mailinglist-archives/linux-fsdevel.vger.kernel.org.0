Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF31C3DB495
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhG3Hjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhG3Hjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:39:35 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E4C061765
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:39:29 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g11so5784513qts.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=iB3xdPLbnvzRXZ9pj7SdMcyOa2roZKbkLihlKFhALkM=;
        b=pEB5hNVNDT29rgSS0xSX6dOBbY1KcxCcqMvGY3gqkTMlD2qdO44nqN1eVywbejwkBi
         6wx/4WR4Jr1fWj893QfHi1LOJuaZGArAhQ1mhVHvQZ+ogc6B7C5Zk8gT/FZW95s7NBjn
         kFDfr2gVH2RmIy1sLtLYDuWZVm/kAcgNgZoad3LQb2en02krriC9y2zB3b+GMWM+MVtE
         /hOh7Hd6PxcmDQrtEQSzovyYoJJA4W5fIm/0MRKPb1CQwRWqp5lnz0UtvTQC7wS9s0rF
         6RWws3/ykqlke0QCR/iaA8RaZ8eSD78Wscco+ddUG1TPCRebInxkJiWEatdd1I1ZQ+Xd
         w4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=iB3xdPLbnvzRXZ9pj7SdMcyOa2roZKbkLihlKFhALkM=;
        b=RKHoJI/tdz3atPXtoZQRBkVk6QVNgqPz06s4Bc5SGUBoll3haBpUzOUjXJVSY0Oi1X
         ZeiMc4vTjP3ufV3PFHxJ5AfglMy5j/1o4sMBvl+3Ko7nUZuPZwsBLSfFnpvAe6j6gsjz
         P9j4/72xMYFwVd8nS3jJfa58n0Hd9GUutvgJLvTs9x2o+axPd9wfKhTPMvtCd+FeQXWK
         P4p0ebnxmMS0CJ0wSFjAZb9U9i6xSl9LIiAVyX0vIGXeIsKqt1/roiVLZHQOkSxqHd1q
         0ir5X7a2KcmOljf8iItIis8Yo5ovQtr+ogruuUPqaVLI7kZAFNs+mFYME1smjzz/cWX2
         MjBA==
X-Gm-Message-State: AOAM530AktOdIGGCyhCNplyPTcV1mZQZgEov080HjJN41PdFVZfYyzH2
        nK7lcgI9ckU+S1aipYl84cL/fg==
X-Google-Smtp-Source: ABdhPJxItQfjw0SaVTAqN5E1ENTrQa91frTNTj9nKOX3FeDN4EF84vkP5RmmpvWrdhMLgJxTvQ2moQ==
X-Received: by 2002:ac8:6b45:: with SMTP id x5mr1138606qts.249.1627630768926;
        Fri, 30 Jul 2021 00:39:28 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g24sm296473qtr.86.2021.07.30.00.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:39:28 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:39:24 -0700 (PDT)
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
Subject: [PATCH 05/16] huge tmpfs: move shmem_huge_enabled() upwards
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <a859bb7f-7978-7e3a-eb32-88224cfa50dc@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

shmem_huge_enabled() is about to be enhanced into shmem_is_huge(),
so that it can be used more widely throughout: before making functional
changes, shift it to its final position (to avoid forward declaration).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 72 ++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c6fa6f4f2db8..740d48ef1eb5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -476,6 +476,41 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly;
 
+bool shmem_huge_enabled(struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	loff_t i_size;
+	pgoff_t off;
+
+	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+		return false;
+	if (shmem_huge == SHMEM_HUGE_FORCE)
+		return true;
+	if (shmem_huge == SHMEM_HUGE_DENY)
+		return false;
+	switch (sbinfo->huge) {
+	case SHMEM_HUGE_NEVER:
+		return false;
+	case SHMEM_HUGE_ALWAYS:
+		return true;
+	case SHMEM_HUGE_WITHIN_SIZE:
+		off = round_up(vma->vm_pgoff, HPAGE_PMD_NR);
+		i_size = round_up(i_size_read(inode), PAGE_SIZE);
+		if (i_size >= HPAGE_PMD_SIZE &&
+				i_size >> PAGE_SHIFT >= off)
+			return true;
+		fallthrough;
+	case SHMEM_HUGE_ADVISE:
+		/* TODO: implement fadvise() hints */
+		return (vma->vm_flags & VM_HUGEPAGE);
+	default:
+		VM_BUG_ON(1);
+		return false;
+	}
+}
+
 #if defined(CONFIG_SYSFS)
 static int shmem_parse_huge(const char *str)
 {
@@ -3995,43 +4030,6 @@ struct kobj_attribute shmem_enabled_attr =
 	__ATTR(shmem_enabled, 0644, shmem_enabled_show, shmem_enabled_store);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-bool shmem_huge_enabled(struct vm_area_struct *vma)
-{
-	struct inode *inode = file_inode(vma->vm_file);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-	loff_t i_size;
-	pgoff_t off;
-
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return false;
-	if (shmem_huge == SHMEM_HUGE_FORCE)
-		return true;
-	if (shmem_huge == SHMEM_HUGE_DENY)
-		return false;
-	switch (sbinfo->huge) {
-		case SHMEM_HUGE_NEVER:
-			return false;
-		case SHMEM_HUGE_ALWAYS:
-			return true;
-		case SHMEM_HUGE_WITHIN_SIZE:
-			off = round_up(vma->vm_pgoff, HPAGE_PMD_NR);
-			i_size = round_up(i_size_read(inode), PAGE_SIZE);
-			if (i_size >= HPAGE_PMD_SIZE &&
-					i_size >> PAGE_SHIFT >= off)
-				return true;
-			fallthrough;
-		case SHMEM_HUGE_ADVISE:
-			/* TODO: implement fadvise() hints */
-			return (vma->vm_flags & VM_HUGEPAGE);
-		default:
-			VM_BUG_ON(1);
-			return false;
-	}
-}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-
 #else /* !CONFIG_SHMEM */
 
 /*
-- 
2.26.2

