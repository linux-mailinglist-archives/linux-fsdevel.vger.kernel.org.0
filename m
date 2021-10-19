Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A924340EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 23:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhJSV5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 17:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhJSV5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:57:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87120C06176A
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 14:55:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c65-20020a251c44000000b005ba81fe4944so27051931ybc.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BodHs/XedRE19LJ4L+Zjt+mkuZYN0DpgQJxfmWf8jTc=;
        b=e0uJfr4GQD92ZjVnar+xwhyaVDFYemk6QpwUu8uZQbQE5WIhDQCwGDOqklaxET0J9j
         8fZW8krnlUL11J+j8BB85/haX2KJTvaI+65QLA85WaP1dnJhRF45MHI+3eU+XqP/LUMo
         zxHNSu2buz6pEv3osleJOVi0SWfW6OSjz2Az3+5Firt191jXIn1fij7Te3man9yZzdUs
         eMO0DboA11qjvYx27k+4XlUdo2mXLg55c2fHUg6vS7PCGP1ic+G8n9UodFXnSX6j6uEg
         iTyBYgNf91CTqUNBjwC5zxFNx6hXIDIPlJkUTCF46UyPtuDY/ADI4UDTwFyNANc65UC/
         /wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BodHs/XedRE19LJ4L+Zjt+mkuZYN0DpgQJxfmWf8jTc=;
        b=Ee+lxzNjh+wp8AxT1h+D6voRlaabxhZTGs1MFnBPbTEbIQBxpohHHbiqyhqxG1HRND
         wT5LZvrEQ/Q46zRP1/11rhD/u5+tx/IeNzNDYfRu3GQeI7ecG5iFh91r6nGScogvzoNX
         1UmqSgBV3vax97NeQX0ZrgvwWRSV5JIDBnDdDH+ljbIxYSgB5cXAPej6fPDmupd3fzNS
         UCXPPAqjIl3aRpwJnvATLXcROSNYrgeawD9UmI4Y7qJ2UlO2Ouf/o7dMbTDvFcQgbmIk
         B5JZfRENyAzFrza6QE40P21WGz8LKpzCpaWjC/NryeaqvtK2uvrkqriGXcr2IUeSXkru
         GOfw==
X-Gm-Message-State: AOAM530EumY7KAmsQYyRV6hTpASUYFIT/+4F/7mm0jKYtVP/x0ek0nWd
        k1J83EGUw0VWSyf8Z6n6aeFjMR2MYRE=
X-Google-Smtp-Source: ABdhPJxEUIcjpniDdTyBul61Zfc2+i0eoOlX7QeONj8Ex5lL8EJuiBJVUaueYVMilSO/LI51lXVqpJOgDKo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:932c:247a:84c6:20f5])
 (user=surenb job=sendgmr) by 2002:a25:824e:: with SMTP id d14mr44648379ybn.155.1634680520719;
 Tue, 19 Oct 2021 14:55:20 -0700 (PDT)
Date:   Tue, 19 Oct 2021 14:55:11 -0700
In-Reply-To: <20211019215511.3771969-1-surenb@google.com>
Message-Id: <20211019215511.3771969-3-surenb@google.com>
Mime-Version: 1.0
References: <20211019215511.3771969-1-surenb@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v11 3/3] mm: add anonymous vma name refcounting
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
https://lore.kernel.org/all/20211001205657.815551-3-surenb@google.com/

 include/linux/mm_types.h |  9 ++++++++-
 mm/madvise.c             | 42 ++++++++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3ad85843e924..89cd74c891fa 100644
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
index 948fad92ba1b..a4e21bc56cab 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -64,6 +64,29 @@ static int madvise_need_mmap_write(int behavior)
 }
 
 #ifdef CONFIG_ANON_VMA_NAME
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
@@ -76,7 +99,7 @@ const char *vma_anon_name(struct vm_area_struct *vma)
 
 	mmap_assert_locked(vma->vm_mm);
 
-	return vma->anon_name;
+	return vma->anon_name->name;
 }
 
 void dup_vma_anon_name(struct vm_area_struct *orig_vma,
@@ -85,34 +108,41 @@ void dup_vma_anon_name(struct vm_area_struct *orig_vma,
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
2.33.0.1079.g6e70778dc9-goog

