Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573591B19B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 00:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgDTWls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgDTWlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:41:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E8DC061A0C;
        Mon, 20 Apr 2020 15:41:46 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 20so12594141qkl.10;
        Mon, 20 Apr 2020 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1xs7a52HdDCbAExnqSe5+2K/TyJ01Rp0raQ7acG2FHw=;
        b=LBEn7bneTlbqWBhqE2IIOuFPDU45rQRp1EY5buf++UFJUWy3jsS+81KMlghgb3LFBk
         hFj25ZFBr8VBuLNn4PaIzXR1hBoyXf8+sEdvG48kqGl3lQQ2wjQlb/XInPNC+BtMbt2S
         WN3T3aPyHlIH8WHoKeIizh0txrP2MwcLxuNRjsv2l2Bm9nQJjVamOygS4H4jd96tmWun
         kUiUxVrStl8llq4Quf4MN3w6oZmW/F7Dv9Gd1sAAUUprqFBlUmSHZ8DXteIGwybfWzG6
         TkMIZe/0wZgW4z3G5XJrnFbnOcP1/15w+yMkGWWmcmIjiaZEw0qijSD2sWEVZQg74bMm
         ezSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xs7a52HdDCbAExnqSe5+2K/TyJ01Rp0raQ7acG2FHw=;
        b=nJVDlmnyW8PFxeVoo+9ALr6dNqDigGBiiX0yOWY03AL0+jLKoG+Q7Kq9wcgA1TgJVr
         3RPhDxvzl6gE/zmSVANCtvV9zBTVtIX64WM8tUhRjpTWW0GyYD4RyrHQ0Rf9iSJlvUsG
         l10xp6ueShuiCPiW1rnKaQiWhBDl4qY0EoWNE/vnPqzW8l+O/Jc3jwMwaVR26jDweHtW
         gewvvoNXbZIgN9qFgVPqM7+eMMY9cVRu7ChWmuFBK0JLdOUyguE/9p9CovJKMdzzAgep
         fYUODP2zfba3rREgz/A9GJIvIN8Dz/kpvA8MlsVDkku8QDhTKd+mAvFlnbSJVk4WCSWI
         bT5Q==
X-Gm-Message-State: AGi0PuZ8fkG0C6JpA0pcL5lFq6Dd/SyTooN0GpsVGPRyE3walB2y4HFd
        +8AMjnTmss8m8PbqIzMAMZ8=
X-Google-Smtp-Source: APiQypL4UcYluQEWwxN6yDbDlj/pGdI0PL/O26k1R1mC5DVwhSgdhKf4O8pmqQGMjlFBHeB5aBBAFA==
X-Received: by 2002:a05:620a:2054:: with SMTP id d20mr17844738qka.496.1587422505955;
        Mon, 20 Apr 2020 15:41:45 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:b0d9])
        by smtp.gmail.com with ESMTPSA id j90sm511052qte.20.2020.04.20.15.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:41:45 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Shakeel Butt <shakeelb@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 3/4] mm: Charge active memcg when no mm is set
Date:   Mon, 20 Apr 2020 18:39:31 -0400
Message-Id: <20200420223936.6773-4-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420223936.6773-1-schatzberg.dan@gmail.com>
References: <20200420223936.6773-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memalloc_use_memcg() worked for kernel allocations but was silently
ignored for user pages.

This patch establishes a precedence order for who gets charged:

1. If there is a memcg associated with the page already, that memcg is
   charged. This happens during swapin.

2. If an explicit mm is passed, mm->memcg is charged. This happens
   during page faults, which can be triggered in remote VMs (eg gup).

3. Otherwise consult the current process context. If it has configured
   a current->active_memcg, use that. Otherwise, current->mm->memcg.

Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it
would always charge the root cgroup. Now it looks up the current
active_memcg first (falling back to charging the root cgroup if not
set).

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Chris Down <chris@chrisdown.name>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 11 ++++++++---
 mm/shmem.c      |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5beea03dd58a..af68d1d7b456 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6435,7 +6435,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
  * @compound: charge the page as compound or small page
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary.
+ * pages according to @gfp_mask if necessary. if @mm is NULL, try to
+ * charge to the active memcg.
  *
  * Returns 0 on success, with *@memcgp pointing to the charged memcg.
  * Otherwise, an error code is returned.
@@ -6479,8 +6480,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 		}
 	}
 
-	if (!memcg)
-		memcg = get_mem_cgroup_from_mm(mm);
+	if (!memcg) {
+		if (!mm)
+			memcg = get_mem_cgroup_from_current();
+		else
+			memcg = get_mem_cgroup_from_mm(mm);
+	}
 
 	ret = try_charge(memcg, gfp_mask, nr_pages);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index d722eb830317..8c8ffc35a957 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1618,7 +1618,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
+	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
 	struct mem_cgroup *memcg;
 	struct page *page;
 	swp_entry_t swap;
@@ -1753,7 +1753,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	sbinfo = SHMEM_SB(inode->i_sb);
-	charge_mm = vma ? vma->vm_mm : current->mm;
+	charge_mm = vma ? vma->vm_mm : NULL;
 
 	page = find_lock_entry(mapping, index);
 	if (xa_is_value(page)) {
-- 
2.24.1

