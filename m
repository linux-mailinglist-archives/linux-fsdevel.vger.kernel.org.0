Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3B41F691
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 22:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhJAU6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355313AbhJAU6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:58:52 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97AC0613E4
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Oct 2021 13:57:07 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o9-20020ac80249000000b002a0c9fd54d5so15787914qtg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Oct 2021 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z8v1DZU38wPzEfaPMEQtWnD2dYyHJRJPqgiOSckBTzw=;
        b=PpTkjjcQNe1RxRDJRmZ1z4reN4nnk7PKKsM3AToSoI1yveU9TCiVXqeI9mc0IDsQIr
         s29QaDQb8l6W3gPt7ujgjW0xg+Ps/z4EiiBO4QgGObpv7kuwaDJLUletR2dlXFOhp5dD
         aE67EGha/yvLbTmwCFHKu9GEQQN/z8FBi4w/wRoPPlDKOm09VTCHjIWaxOuCartZ8MFz
         9dMZ4e9R2KVCMhM19EZSc/i7ZZLDV57C3K3u5TXtkeqPrz7RdQgRw1oSejMytMuGEBBm
         qhRXsd8tqAS/9B7BxIfK61kXbTS5cQrv+Rc8+kw7mKZuGLOCvgd+oP9YRFppZwUrcni0
         T1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z8v1DZU38wPzEfaPMEQtWnD2dYyHJRJPqgiOSckBTzw=;
        b=34GcyPacMxXnqkvV9X72yP39oHDFonb/+hlR+58GnvAtVydRSrLLWxayjWuXClrvB0
         SKWJNf5CyFQId5mu2VlgHLxv1Ljsm48Bd+/W6JJTu3yRsu2MbKL3FqmwByzInuMJ1VbZ
         zwSwDHxiWvYMMWoqo24i17F796rcT+kUdoIXFW28dmHamdNkn8hpPn2Oqj+09f8N7Sv4
         ZyigUSR6bAQ+Gm/ybfLIopM77RhrC+DO3dRET3KbGqAe1lV/yFtebUFtro21nWUj7Ge8
         lUL6F582hEX7DdWNJmeUK9WYdC2NgCcumJXUIuwP5zaCu53u7RYk6rC9rUpIgEUr9bb7
         qH8w==
X-Gm-Message-State: AOAM532VqBhDx8qzNBUVRhQ9y/0+1pqgvUvHxTBxk3GzLYjUT1Y42vQR
        FLb0YKipPZx1mf6/vWU4Slqx4kdE9m4=
X-Google-Smtp-Source: ABdhPJzDd8N1bY00kgE20gIg97ih/EjnLN1aGuSpz6shr/dqTpTgnoute4EW2CDkdqpumhG1M4W2lJKAqdY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:fbba:6ac8:d071:dcc])
 (user=surenb job=sendgmr) by 2002:a05:6214:151:: with SMTP id
 x17mr11096796qvs.38.1633121826593; Fri, 01 Oct 2021 13:57:06 -0700 (PDT)
Date:   Fri,  1 Oct 2021 13:56:57 -0700
In-Reply-To: <20211001205657.815551-1-surenb@google.com>
Message-Id: <20211001205657.815551-3-surenb@google.com>
Mime-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v10 3/3] mm: add anonymous vma name refcounting
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com, pavel@ucw.cz,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While forking a process with high number (64K) of named anonymous vmas the
overhead caused by strdup() is noticeable. Experiments with ARM64 Android
device show up to 40% performance regression when forking a process with
64k unpopulated anonymous vmas using the max name lengths vs the same
process with the same number of anonymous vmas having no name.
Introduce anon_vma_name refcounted structure to avoid the overhead of
copying vma names during fork() and when splitting named anonymous vmas.
When a vma is duplicated, instead of copying the name we increment the
refcount of this structure. Multiple vmas can point to the same
anon_vma_name as long as they increment the refcount. The name member of
anon_vma_name structure is assigned at structure allocation time and is
never changed. If vma name changes then the refcount of the original
structure is dropped, a new anon_vma_name structure is allocated
to hold the new name and the vma pointer is updated to point to the new
structure.
With this approach the fork() performance regressions is reduced 3-4x
times and with usecases using more reasonable number of VMAs (a few
thousand) the regressions is not measurable.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
previous version at:
https://lore.kernel.org/linux-mm/20210902231813.3597709-3-surenb@google.com/

changes in v10
- Changed anon_vma_name_alloc() to use struct_size() and avoid strcpy(),
per Kees Cook

 include/linux/mm_types.h |  9 ++++++++-
 mm/madvise.c             | 42 ++++++++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index f1896c9b2da9..30c571b4f8d3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types_task.h>
 
 #include <linux/auxvec.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
@@ -310,6 +311,12 @@ struct vm_userfaultfd_ctx {
 struct vm_userfaultfd_ctx {};
 #endif /* CONFIG_USERFAULTFD */
 
+struct anon_vma_name {
+	struct kref kref;
+	/* The name needs to be at the end because it is dynamically sized. */
+	char name[];
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
@@ -361,7 +368,7 @@ struct vm_area_struct {
 			unsigned long rb_subtree_last;
 		} shared;
 		/* Serialized by mmap_sem. */
-		char *anon_name;
+		struct anon_vma_name *anon_name;
 	};
 
 	/*
diff --git a/mm/madvise.c b/mm/madvise.c
index 69729930dde1..2f1ec13faaaa 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -63,6 +63,29 @@ static int madvise_need_mmap_write(int behavior)
 	}
 }
 
+static struct anon_vma_name *anon_vma_name_alloc(const char *name)
+{
+	struct anon_vma_name *anon_name;
+	size_t count;
+
+	/* Add 1 for NUL terminator at the end of the anon_name->name */
+	count = strlen(name) + 1;
+	anon_name = kmalloc(struct_size(anon_name, name, count), GFP_KERNEL);
+	if (anon_name) {
+		kref_init(&anon_name->kref);
+		memcpy(anon_name->name, name, count);
+	}
+
+	return anon_name;
+}
+
+static void vma_anon_name_free(struct kref *kref)
+{
+	struct anon_vma_name *anon_name =
+			container_of(kref, struct anon_vma_name, kref);
+	kfree(anon_name);
+}
+
 static inline bool has_vma_anon_name(struct vm_area_struct *vma)
 {
 	return !vma->vm_file && vma->anon_name;
@@ -75,7 +98,7 @@ const char *vma_anon_name(struct vm_area_struct *vma)
 
 	mmap_assert_locked(vma->vm_mm);
 
-	return vma->anon_name;
+	return vma->anon_name->name;
 }
 
 void dup_vma_anon_name(struct vm_area_struct *orig_vma,
@@ -84,34 +107,41 @@ void dup_vma_anon_name(struct vm_area_struct *orig_vma,
 	if (!has_vma_anon_name(orig_vma))
 		return;
 
-	new_vma->anon_name = kstrdup(orig_vma->anon_name, GFP_KERNEL);
+	kref_get(&orig_vma->anon_name->kref);
+	new_vma->anon_name = orig_vma->anon_name;
 }
 
 void free_vma_anon_name(struct vm_area_struct *vma)
 {
+	struct anon_vma_name *anon_name;
+
 	if (!has_vma_anon_name(vma))
 		return;
 
-	kfree(vma->anon_name);
+	anon_name = vma->anon_name;
 	vma->anon_name = NULL;
+	kref_put(&anon_name->kref, vma_anon_name_free);
 }
 
 /* mmap_lock should be write-locked */
 static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
 {
+	const char *anon_name;
+
 	if (!name) {
 		free_vma_anon_name(vma);
 		return 0;
 	}
 
-	if (vma->anon_name) {
+	anon_name = vma_anon_name(vma);
+	if (anon_name) {
 		/* Same name, nothing to do here */
-		if (!strcmp(name, vma->anon_name))
+		if (!strcmp(name, anon_name))
 			return 0;
 
 		free_vma_anon_name(vma);
 	}
-	vma->anon_name = kstrdup(name, GFP_KERNEL);
+	vma->anon_name = anon_vma_name_alloc(name);
 	if (!vma->anon_name)
 		return -ENOMEM;
 
-- 
2.33.0.800.g4c38ced690-goog

