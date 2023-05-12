Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0B6FFDC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 02:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbjELAPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 20:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjELAPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 20:15:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9D818C
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 17:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683850480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSC7Tnvph26Aft1NSYUSaxJrqhw+ec92+810eNP5q1Q=;
        b=X5sxaH9Gl/reRfswjHqPItc5KWoQW+nSN43NMi02I/T5eCAOPtRp3IkhD3I0RMnyxpDiXN
        RTRwd9520h/G2Gxqq5RJgW9YWZAeZ63EbQf31JeKDD8fG4JKkJnRysbm8Ck78w6uJFDSpi
        j9sw0cUCi0+HhRo1lwUS3bEYxuj8roY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-M0dRGTRgNtG8cWEiXVqT0A-1; Thu, 11 May 2023 20:14:39 -0400
X-MC-Unique: M0dRGTRgNtG8cWEiXVqT0A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61b6f717b6eso9495736d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 17:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850478; x=1686442478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSC7Tnvph26Aft1NSYUSaxJrqhw+ec92+810eNP5q1Q=;
        b=FWM7eeojS1jD8Ydh7XSJGGGu5Hs+DSoinvILqvHoOtVIEkWpxNXerpngyCOlnTVspp
         nR68YTaq5Tk0JQvXQI52fWkBdda24b6aWl/P0U7pfeZQoRhZDiZFhrPjg3OElhyZLPMN
         QAGBKAG9RpmsD42aOn87dxaZ7su+jZj2fXIb2ALjaNJxUZnufubJ8PX9Cq6XCGFuGqgK
         MnEYuli6QIQqTe4Y4clZExz2FwIdWqeZ44SKT5AXLVyu7xh1X2lCpp6N2Dzo0ppBuni4
         VoJmgLk4WAWp0un7HUMlSU2EE+xA9TF65MX63EgifKPsOfGd4zeSqtCdiOSB0eprlnkV
         2QnA==
X-Gm-Message-State: AC+VfDxe9JzLNfWVh3mWZR/stlrPuytYLJl5lA2N6rofid086rY2e75y
        4lrV7bVJu7M3ZrLWtVRnKug/jUZPBfVOA8xUCx8Jj8+84/Pe/YWsv17FusnnCdEj1qaxyQQQ+QD
        +azHQP5mIBYfSE0zAeLR8jDac4cujNmMDOg==
X-Received: by 2002:a05:622a:1806:b0:3f4:e3d3:f907 with SMTP id t6-20020a05622a180600b003f4e3d3f907mr8163089qtc.5.1683850478032;
        Thu, 11 May 2023 17:14:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZvMO5iZq/qlQKQm4Mq6RPK8C3YI0LRJWVEia94HxjXx2AN1lJAFozjyDQ7T7jHFaQiPH7mQ==
X-Received: by 2002:a05:622a:1806:b0:3f4:e3d3:f907 with SMTP id t6-20020a05622a180600b003f4e3d3f907mr8163063qtc.5.1683850477709;
        Thu, 11 May 2023 17:14:37 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id y30-20020ac8705e000000b003ef6cfbbe6esm2649193qtm.51.2023.05.11.17.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:14:35 -0700 (PDT)
Date:   Thu, 11 May 2023 20:14:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
Message-ID: <ZF2E6i4pqJr7m436@x1n>
References: <20230506160415.2992089-1-willy@infradead.org>
 <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
 <20230509191918.GB18828@cmpxchg.org>
 <ZFv+M5egsMxE1rhF@x1n>
 <CAHk-=wjKVXt+BAh+Gk+Cs9u8s=XzbQyzHhZSW2bPFMX74gPuRw@mail.gmail.com>
 <CAHk-=wgnHtP2uNtnFdQ4Ou-TZynipVVU5Jow+Fr8nhRgewkXAA@mail.gmail.com>
 <ZFxy48TRh3m09oWB@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFxy48TRh3m09oWB@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 09:45:23PM -0700, Peter Xu wrote:
> On Wed, May 10, 2023 at 04:44:59PM -0500, Linus Torvalds wrote:
> > On Wed, May 10, 2023 at 4:33 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > We'd still keep the RETRY bit as a "this did not complete, you need to
> > > retry", but at least the whole secondary meaning of "oh, and if it
> > > isn't set, you need to release the lock you took" would go away.
> > 
> > "unless VM_FAULT_COMPLETED is set, in which case everything was fine,
> > and you shouldn't release the lock because we already released it".
> > 
> > I completely forgot about that wart that came in last year.
> > 
> > I think that if we made handle_mm_fault() always unlock, that thing
> > would go away entirely, since "0" would now just mean the same thing.
> > 
> > Is there really any case that *wants* to keep the mmap lock held, and
> > couldn't just always re-take it if it needs to do another page
> > (possibly retry, but the retry case obviously already has that issue)?
> 
> FAULT_FLAG_RETRY_NOWAIT?

I had a slightly closer look today on "releasing mmap read lock in
handle_mm_fault()", so I think it's also fine we just keep NOWAIT special
but release the mmap locks if !NOWAIT (NOWAIT is always special, say, when
with VM_FAULT_RETRY returned), but I'm not sure whether it's good enough.

A major issue of not releasing mmap lock always is gup can fault >1 pages
per call to handle_mm_fault(), so it's ideal if it's not major fault gup
can take mmap read lock once but fault in >1 pages without releasing it.

I've got three tiny patches attached where I added a wrapper for
handle_mm_fault() (I called it handle_mm_fault_one(), meaning it should be
used where we only want to fault in 1 page, aka, real hardware faults, so
it always make sense to release mmap lock there).  I tried to convert 4
archs (x86,arm,ppc,s390) to have a feeling of what it would clean up.  With
3 patches applied, one good thing is we can easily move all ERROR handling
above either RETRY|COMPLETE handling so it's much easier to review such a
change as what Johannes proposed, but not sure whether it's something
worthwhile to have.  Please let me know if anyone thinks I should post as a
formal patch.

Even with something like that, we'll still need per-arch code changes if we
want to handle ERROR+RETRY cases anyway, because we used to handle RETRY
first.  To make it less an effort in the future, we still need to
generalize the fault path.

> 
> > Certainly nothing wants the vma lock, so it's only the "mmap_sem" case
> > that would be an issue.
> 
> You're definitely right that the gup path is broken which I didn't notice
> when reading...  I know I shouldn't review such a still slightly involved
> patch during travel. :(
> 
> I still think maybe we have chance to generalize at least the fault path,
> I'd still start with something like having just 2-3 archs having a shared
> routine handle only some part of the fault path (I remember there was a
> previous discussion previously, but I didn't follow up much from there..).
> 
> So even if we still need duplicates over many archs, we'll start to have
> something we can use as a baseline in fault path.  Does it sound a sane
> thing to consider as a start, or maybe not?
> 
> The other question - considering RETRY_NOWAIT being there - do we still
> want to have something like what Johannes proposed first to fix the problem
> (with all arch and gup fixed)?  I'd think yes, but I could missed something.

Three patches attached:
=======================

From 95e968c75f9114cc4a2ef74f0108f09157f7dd15 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 11 May 2023 12:49:32 -0700
Subject: [PATCH 1/3] mm: handle_mm_fault_one()

Introduce a wrapper for handle_mm_fault() which will only resolve one page
fault at a time.  It means if there's no further fault to take care of, we
can safely unify the unlock of either mmap lock or vma lock in the wrapper.
It may help cleanup fault paths across archs.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 38 ++++++++++++++++++++++++++++++++++++++
 mm/memory.c        | 11 ++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1bd731a2972b..dfe6083c6953 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2360,6 +2360,44 @@ static inline void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows) { }
 #endif
 
+static inline bool
+mm_should_release_mmap(unsigned long flags, vm_fault_t retval)
+{
+	/* The caller explicitly requested to keep the mmap read lock */
+	if (flags & FAULT_FLAG_RETRY_NOWAIT)
+		return false;
+
+	/* If the mmap read lock is already released, we're all good */
+	if (fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED))
+		return false;
+
+	/* Otherwise always release it */
+	return true;
+}
+
+/*
+ * This is mostly handle_mm_fault(), but it also take care of releasing
+ * mmap or vma read lock as long as possible (e.g. when !RETRY_NOWAIT).
+ *
+ * Normally it's the case when we got a hardware page fault, where we want
+ * to release the lock right after the page fault. And it's not for case
+ * like GUP where it can fault a range of pages continuously with mmap lock
+ * being held during the process.
+ */
+static inline vm_fault_t
+handle_mm_fault_one(struct vm_area_struct *vma, unsigned long address,
+		    unsigned int flags, struct pt_regs *regs)
+{
+	vm_fault_t retval = handle_mm_fault(vma, address, flags, regs);
+
+	if (flags & FAULT_FLAG_VMA_LOCK)
+		vma_end_read(vma);
+	else if (mm_should_release_mmap(flags, retval))
+		mmap_read_unlock(mm);
+
+	return retval;
+}
+
 static inline void unmap_shared_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 146bb94764f8..c43e3410bf8f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5206,10 +5206,15 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 }
 
 /*
- * By the time we get here, we already hold the mm semaphore
+ * By the time we get here, we already hold relevant locks to make sure vma
+ * is rock solid:
  *
- * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __folio_lock_or_retry().
+ *   - When FAULT_FLAG_VMA_LOCK, it's the vma read lock
+ *   - When !FAULT_FLAG_VMA_LOCK, it's the mmap read lock
+ *
+ * For the 2nd case, it's possible that the mmap_lock may have been
+ * released during the fault procedure depending on the return value.  See
+ * filemap_fault(), __folio_lock_or_retry(), or fault_dirty_shared_page().
  */
 vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
-- 
2.39.1

From 22bbf7fbabea4a75d1204eb9bb5be3ba7d035d97 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 11 May 2023 12:52:30 -0700
Subject: [PATCH 2/3] mm: Use handle_mm_fault_one() for per-vma faults

Use the new handle_mm_fault_one() across the current 4 archs that supports
per-vma lock.  Since it's fairly straightforward, do that in one shot.

Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c   | 5 ++---
 arch/powerpc/mm/fault.c | 3 +--
 arch/s390/mm/fault.c    | 3 +--
 arch/x86/mm/fault.c     | 4 +---
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9e0db5c387e3..31932f01a80e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -600,9 +600,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		vma_end_read(vma);
 		goto lock_mmap;
 	}
-	fault = handle_mm_fault(vma, addr & PAGE_MASK,
-				mm_flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	fault = handle_mm_fault_one(vma, addr & PAGE_MASK,
+				    mm_flags | FAULT_FLAG_VMA_LOCK, regs);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 531177a4ee08..d64a8c808545 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -493,8 +493,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 		goto lock_mmap;
 	}
 
-	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	fault = handle_mm_fault_one(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index b65144c392b0..40c1d4958670 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -417,8 +417,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 		vma_end_read(vma);
 		goto lock_mmap;
 	}
-	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	fault = handle_mm_fault_one(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		goto out;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e4399983c50c..d74481d64f6b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1346,9 +1346,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		vma_end_read(vma);
 		goto lock_mmap;
 	}
-	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
-
+	fault = handle_mm_fault_one(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		goto done;
-- 
2.39.1

From 5fd10f8c6eace6dcbb42530a1dfb83546d0b6fe5 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 11 May 2023 13:04:38 -0700
Subject: [PATCH 3/3] mm: Convert archs to use handle_mm_fault_one() in general
 path

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/mm/fault.c     | 4 +---
 arch/arm64/mm/fault.c   | 3 +--
 arch/powerpc/mm/fault.c | 4 +---
 arch/s390/mm/fault.c    | 4 ++--
 arch/x86/mm/fault.c     | 3 +--
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2418f1efabd8..ffcac4fd80b5 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -256,7 +256,7 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int flags,
 	if (!(vma->vm_flags & vma_flags))
 		return VM_FAULT_BADACCESS;
 
-	return handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
+	return handle_mm_fault_one(vma, addr & PAGE_MASK, flags, regs);
 }
 
 static int __kprobes
@@ -348,8 +348,6 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		}
 	}
 
-	mmap_read_unlock(mm);
-
 	/*
 	 * Handle the "normal" case first - VM_FAULT_MAJOR
 	 */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 31932f01a80e..eb806ad6dea2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -509,7 +509,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (!(vma->vm_flags & vm_flags))
 		return VM_FAULT_BADACCESS;
-	return handle_mm_fault(vma, addr, mm_flags, regs);
+	return handle_mm_fault_one(vma, addr, mm_flags, regs);
 }
 
 static bool is_el0_instruction_abort(unsigned long esr)
@@ -658,7 +658,6 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		mm_flags |= FAULT_FLAG_TRIED;
 		goto retry;
 	}
-	mmap_read_unlock(mm);
 
 #ifdef CONFIG_PER_VMA_LOCK
 done:
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index d64a8c808545..ba253f390ed9 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -561,7 +561,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, regs);
+	fault = handle_mm_fault_one(vma, address, flags, regs);
 
 	major |= fault & VM_FAULT_MAJOR;
 
@@ -581,8 +581,6 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 		goto retry;
 	}
 
-	mmap_read_unlock(current->mm);
-
 #ifdef CONFIG_PER_VMA_LOCK
 done:
 #endif
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 40c1d4958670..441300fa33aa 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -473,7 +473,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, regs);
+	fault = handle_mm_fault_one(vma, address, flags, regs);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
@@ -492,7 +492,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	}
 
 	if (unlikely(fault & VM_FAULT_ERROR))
-		goto out_up;
+		goto out;
 
 	if (fault & VM_FAULT_RETRY) {
 		if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d74481d64f6b..dc2548248eec 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1435,7 +1435,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * userland). The return to userland is identified whenever
 	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
 	 */
-	fault = handle_mm_fault(vma, address, flags, regs);
+	fault = handle_mm_fault_one(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs)) {
 		/*
@@ -1463,7 +1463,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto retry;
 	}
 
-	mmap_read_unlock(mm);
 #ifdef CONFIG_PER_VMA_LOCK
 done:
 #endif
-- 
2.39.1


-- 
Peter Xu

