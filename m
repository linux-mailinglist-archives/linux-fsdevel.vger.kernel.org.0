Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8845228C6CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 03:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgJMBeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 21:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgJMBeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:34:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510C3C0613D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p15so19257530wmi.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0dBjMGQZwr5fzpQZu0PyDC9RTW1+FomX32MrbIIN2c=;
        b=FGKDY4+X3JgwoUoN1C/3HtoPUDzAwaeKRnm9weDnUEBjEuPWSOeILJ5WitdE7ezOUP
         Z8h6z8QjmHrQkKSfvP/CqOKrMe2VeWaoWuM1DTGhWnLuZk1g88dKU5Im4GTOJwORpW2f
         UuV18UZCz944g3qypRZ2XQhlg6JzVZmLhMr5Bs/tnrm1RAUdEgB/WdGaLZGTdqqhIMgV
         pfG53+RblNOsJA22ZNjqtEkKPrKzJBc7Og2rE+hr0YIrlaORjXWV2alA7tDY1jhP1fno
         43O1Nu5NaFD+pRDCg3zxhKfu0Owyg1VkXKC8ZVHZFjGsiuAaTBtUv+EuEgHOsI8dOIdW
         j1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0dBjMGQZwr5fzpQZu0PyDC9RTW1+FomX32MrbIIN2c=;
        b=GPRLPSJ9ZvuM7NQyvWfsJ3isovzZB910x3wGi+40Hb6RMQhTmZbjrrpFJTVs+hxRZz
         TRph8hBQAGFd3tPTFLqu5kQOOfzTGJcq3NvmFb8rCxf/NTFCsHguwrYRgrkeNMxXm4H2
         LpmMElsc26Pv7VlEu0BLr7CnOR4I5PjodHKWu3HGtyGDRsK48g/Sz9iwVWo5igCEv7E4
         ZKRoEG2V8bAgvu4HEyXaSnz3RK2qUCg/b3ogIDzItCo7K2Elwv2ILHSOVE20roVQfu68
         cpTMCRQyOLYVdE8WjKbXvr5bEtcC+ZpHnl46dRV1xg8xSJJYJWyvtIKRwSD2R6JXkAjy
         TnvQ==
X-Gm-Message-State: AOAM5309QRrTP1UzKeJXetE5Gm423USW1jEaQWHIkza+2hJfTd1tCMVW
        ulQnrWbvIypkTzufK/uWAUbRYQ==
X-Google-Smtp-Source: ABdhPJzYLde4t7k258XJEoIwmIIg3SOE4QcEX3b/iLBAwsA51BD5ldG7hvxtYYzYqpyGbgSwcygcoQ==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr12752537wmh.78.1602552862013;
        Mon, 12 Oct 2020 18:34:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d23sm24825325wmb.6.2020.10.12.18.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 18:34:21 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/6] mm/mremap: For MREMAP_DONTUNMAP check security_vm_enough_memory_mm()
Date:   Tue, 13 Oct 2020 02:34:12 +0100
Message-Id: <20201013013416.390574-3-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013013416.390574-1-dima@arista.com>
References: <20201013013416.390574-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently memory is accounted post-mremap() with MREMAP_DONTUNMAP, which
may break overcommit policy. So, check if there's enough memory before
doing actual VMA copy.

Don't unset VM_ACCOUNT on MREMAP_DONTUNMAP. By semantics, such mremap()
is actually a memory allocation. That also simplifies the error-path a
little.

Also, as it's memory allocation on success don't reset hiwater_vm value.

Fixes: commit e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 mm/mremap.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 03d31a0d4c67..c248f9a52125 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -365,11 +365,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (err)
 		return err;
 
+	if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT)) {
+		if (security_vm_enough_memory_mm(mm, new_len >> PAGE_SHIFT))
+			return -ENOMEM;
+	}
+
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
 			   &need_rmap_locks);
-	if (!new_vma)
+	if (!new_vma) {
+		if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT))
+			vm_unacct_memory(new_len >> PAGE_SHIFT);
 		return -ENOMEM;
+	}
 
 	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
 				     need_rmap_locks);
@@ -398,7 +406,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
-	if (vm_flags & VM_ACCOUNT) {
+	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vma->vm_flags &= ~VM_ACCOUNT;
 		excess = vma->vm_end - vma->vm_start - old_len;
 		if (old_addr > vma->vm_start &&
@@ -423,34 +431,16 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		untrack_pfn_moved(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
-		if (vm_flags & VM_ACCOUNT) {
-			/* Always put back VM_ACCOUNT since we won't unmap */
-			vma->vm_flags |= VM_ACCOUNT;
-
-			vm_acct_memory(new_len >> PAGE_SHIFT);
-		}
-
-		/*
-		 * VMAs can actually be merged back together in copy_vma
-		 * calling merge_vma. This can happen with anonymous vmas
-		 * which have not yet been faulted, so if we were to consider
-		 * this VMA split we'll end up adding VM_ACCOUNT on the
-		 * next VMA, which is completely unrelated if this VMA
-		 * was re-merged.
-		 */
-		if (split && new_vma == vma)
-			split = 0;
-
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
 		vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 
 		/* Because we won't unmap we don't need to touch locked_vm */
-		goto out;
+		return new_addr;
 	}
 
 	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
-		if (vm_flags & VM_ACCOUNT)
+		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(new_len >> PAGE_SHIFT);
 		excess = 0;
 	}
@@ -459,7 +449,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		mm->locked_vm += new_len >> PAGE_SHIFT;
 		*locked = true;
 	}
-out:
+
 	mm->hiwater_vm = hiwater_vm;
 
 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
-- 
2.28.0

