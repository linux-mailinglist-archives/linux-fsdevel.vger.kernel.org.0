Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C97573F34E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjF0EXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjF0EXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:23:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4675210FF
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c22664c3df7so3579919276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687839811; x=1690431811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbyeBW7WIJNXjK7iu35fAbN/5yTuDJs52xpJl7xU1IY=;
        b=ugW+SG7YngNovW466Ob1qbMUa7QCgvQN2HYZdw69vEb2gnilYAyfBBDC9eIv0kJn5R
         K+Nth6CovXEzufoeufA2bBetWvrGzXQiUD8VhdoqNnFL16vRdxwfeZTWoLlNANAXPsaE
         4it7n5SCFHwAzJ+itDODzIf22wtA7wDa/2u16CAUMCgAj1Ez2yBmApbjIHS34bZr0QAs
         6CcMERtjjQw5qzSYxGAWzCQbLbu0UfN+0PYZKiPIpB8IIqWC1ndKoEhlLxsLL9cLvsPv
         v4BzBjfVXuH+PyuaE6GmW6rTE2x5EJClKScB3InhL/RUrH4gPNiYW0KVLBDn77KNMcAS
         0haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687839811; x=1690431811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbyeBW7WIJNXjK7iu35fAbN/5yTuDJs52xpJl7xU1IY=;
        b=DC4jEC0ETnlPQseTXz12yiQfEU3W4nuoJQEAwXAdM5iaZ1gS0jYZARRAL+E0JzCWMk
         n8kE/sA+5rdGdYN+Y7RybxxZF6yZaL0peY/Y+v2NLzhpyGtss1pEnJCOK4wesYyeF9ue
         SJtWLfXiHXdXfOPjPYHHs7XFRWWtT+Oj+N0lBHzW87vtwjUib2X5ZGGRmrepOzgdjW7G
         2Y8zxx7Pam5WqpDEFaX+1XY142yV09rXE0QgK5iRLZO+Kf+tqG7td6X5YI+C6MoahHOM
         9CqidVhOIw7XNjV/FSqUXiebWelo8Y5PfE7rsZsbO+0Lq7NcgiAItPBGS8CPXgHpkb0z
         FX9Q==
X-Gm-Message-State: AC+VfDy5/MVpYjgghHdIvN4hG0HSBOg6vhnB/EZYwfBpWeiJWfiD+BM5
        0zSX15kiSRYWW9BGdWZf4v2muyGm5Jc=
X-Google-Smtp-Source: ACHHUZ5PHgbnMPnEsTLa+W0vChTT29tB4jfEbEI5BqOjiRDx9zMqo94H5raeRb2+zfsUTcjeQvPxANoMY/M=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a25:ac92:0:b0:bc4:78ac:920f with SMTP id
 x18-20020a25ac92000000b00bc478ac920fmr13716099ybi.0.1687839811426; Mon, 26
 Jun 2023 21:23:31 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:23:16 -0700
In-Reply-To: <20230627042321.1763765-1-surenb@google.com>
Mime-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627042321.1763765-4-surenb@google.com>
Subject: [PATCH v3 3/8] mm: drop per-VMA lock in handle_mm_fault if retrying
 or when finished
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

handle_mm_fault returning VM_FAULT_RETRY or VM_FAULT_COMPLETED means
mmap_lock has been released. However with per-VMA locks behavior is
different and the caller should still release it. To make the
rules consistent for the caller, drop the per-VMA lock before returning
from handle_mm_fault when page fault should be retried or is completed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/mm/fault.c   |  3 ++-
 arch/powerpc/mm/fault.c |  3 ++-
 arch/s390/mm/fault.c    |  3 ++-
 arch/x86/mm/fault.c     |  3 ++-
 mm/memory.c             | 12 +++++++++++-
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 6045a5117ac1..89f84e9ea1ff 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -601,7 +601,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 531177a4ee08..4697c5dca31c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -494,7 +494,8 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index b65144c392b0..cccefe41038b 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -418,7 +418,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		goto out;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e4399983c50c..d69c85c1c04e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1347,7 +1347,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto lock_mmap;
 	}
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..9011ad63c41b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5086,7 +5086,17 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		}
 	}
 
-	return handle_pte_fault(&vmf);
+	ret = handle_pte_fault(&vmf);
+	if (ret & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)) {
+		/*
+		 * In case of VM_FAULT_RETRY or VM_FAULT_COMPLETED we might
+		 * be still holding per-VMA lock to keep the vma stable as long
+		 * as possible. Drop it before returning.
+		 */
+		if (vmf.flags & FAULT_FLAG_VMA_LOCK)
+			vma_end_read(vma);
+	}
+	return ret;
 }
 
 /**
-- 
2.41.0.178.g377b9f9a00-goog

