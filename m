Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA841E6301
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 15:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390764AbgE1Nzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390716AbgE1Nz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 09:55:29 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7543C05BD1E;
        Thu, 28 May 2020 06:55:28 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w3so3105372qkb.6;
        Thu, 28 May 2020 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ISW/6WZX64f8daVPvqFY1okl3lTrypxE++ROsAseMc=;
        b=h4u0/E9SlBDy7zE004Yhxe8LFwdOtd/jFTly/4kG0sMKrxsLJsPoCxK54qreUYkgK0
         C7cJedYKAPzO3C9CgbPInsWb60fQVA87E8pw9r3OCXO6/RdKCiWz0P/I5ky0SXIoK6Np
         FgDjlPbtoIcn+pghJNAbepTGyjd439k78xyFR0UCJNyeKLtQ34HEVGUzpBT6SQIcXTxx
         SB6GW0ZCD8aukfdRP7gHYESpCupUZPqclUUE56uX1JeF01D5TlDgQoSBacTd+mNHWqrs
         X4aAD6XHrrLpVwXd0q0oefEXI3hWih+JKTC6LIMXUF+d4MC1P5dMj2sKms1rjVY264nS
         PKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ISW/6WZX64f8daVPvqFY1okl3lTrypxE++ROsAseMc=;
        b=Sjd8kAS4GHxd4rCA87K9EcWc1yEc7q0EZnf9NJ9mtcIcBohbKQfbVKfL91Qd4EXJEe
         46fR0J6w7P1QGnY2E8k2KPE114hagBJ+qBqBpkFctqYOrwTcdTFIgqWTK+5ww14V8B6b
         Y5kwctdOYzNKJu5zSG4RuNnXKG77isbckSPb1eSLjnr+jRI3Ea3mq7gTNkcd159wPtNg
         hSqWrQ3wT/dGZ+tSOtaqai3nNKtP8uqp3s9px7Hzjy6KpcLZLs6y5fS3LhgQkNgMrY45
         Li0+nYoLL1dOQCHuE4IXLvDSYU288fGe5KLY61zZe5vdUBxpBiA9sR/Dykm6BC0JIGRu
         uvUw==
X-Gm-Message-State: AOAM533mRdl4M74daWPAg4iS+3AqLOtsmoNNaeBPk7LOfBp7XRsOfe88
        5WtSXfURc5KkrIAIqDbNbJ8=
X-Google-Smtp-Source: ABdhPJzrlVywN4JlmAU2ZM/nC5B3Ll644kitWP/9qECB6fQhLzh4HwCgQpi3FHH9/Li3NZeoEl/LKA==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr2717709qkf.131.1590674127957;
        Thu, 28 May 2020 06:55:27 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:1cb7])
        by smtp.gmail.com with ESMTPSA id l186sm4890889qkf.89.2020.05.28.06.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:55:26 -0700 (PDT)
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 3/4] mm: Charge active memcg when no mm is set
Date:   Thu, 28 May 2020 09:54:38 -0400
Message-Id: <20200528135444.11508-4-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528135444.11508-1-schatzberg.dan@gmail.com>
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
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
index a3b97f103966..383d88c1c105 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6438,7 +6438,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
  * @compound: charge the page as compound or small page
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary.
+ * pages according to @gfp_mask if necessary. if @mm is NULL, try to
+ * charge to the active memcg.
  *
  * Returns 0 on success, with *@memcgp pointing to the charged memcg.
  * Otherwise, an error code is returned.
@@ -6482,8 +6483,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
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
index bd8840082c94..d2efa1a44311 100644
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

