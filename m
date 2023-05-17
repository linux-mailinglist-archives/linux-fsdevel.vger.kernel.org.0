Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C42707211
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 21:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjEQT02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 15:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjEQT0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 15:26:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6909BAD19;
        Wed, 17 May 2023 12:25:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f475366522so8182665e9.1;
        Wed, 17 May 2023 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684351542; x=1686943542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI0DKFHOgADCUjTm1gh+Y1O91LrE51ywiHLT1I9lXDA=;
        b=PPJXpdUXIcVpmQMhEHWRMFWnyiO/AkYwOg6Poy1s98Vqy6aKFCPRNnMy8d5v8bAFqc
         +8wMS9nv5WUwLJd9H32NxThhM4ouyxllOQHXQelpnO3YAVr9CE5Inpg3NGbsYd0EdaHg
         P4Q0b0He9mSNboyHrvYjM+Pwp0y5gDU0E73+HgDtLw+uu5mE9Fc1P56FJH/zXC/mv+VH
         9ocxC0K0R7QslQOD6ENe2+qMAG4qjmU1OKhZv/lFsUKtWIkqqukr0OkTSwe0tu28TeJv
         4bF7DB3Tg/tio9vZQgTWPK17aLJuDrMIMdf3+IUdOB7qBAwvqtqQnvZndtKlEK4hz9cN
         9PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351542; x=1686943542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI0DKFHOgADCUjTm1gh+Y1O91LrE51ywiHLT1I9lXDA=;
        b=DJu6CKCJM9kcGg95Uiy9QsCCjZCaPIqGhvemdLAMqS6V2pIxwMmwEAtIVi0q+RURC7
         DkdJ/OulG1T234DZe9D8vHMjQ5PlOnFbMu4KStvHDPQRAUZpqm5I9IJnZvSpdpHPgj/S
         AeUg5nSNymlzLVelL28T7YZGx/uE6Z0MIXIxEf3r06V5xiHrl3gxTviV9khDvjntNKZE
         Dyp+n9QnLnCDh2YrGVfqv6rM1he0REUiShemQNHkuYk5pxXtnZ4QEDW7u+Jq/WaCInY1
         CG8LnesohW6InJl9Xc8ZgjoXWbNWt/Z3spk9veDtwhiEmu+Q4z4zmo6yT3F2gxNQ1T2V
         T5rw==
X-Gm-Message-State: AC+VfDz4xthiFUmJMx4ZV74ELh/uYuHpKOJFMw58Gb55rhpKlKJNv/cv
        AA5mVYWZMDvT6FRiKIEYOcA=
X-Google-Smtp-Source: ACHHUZ5dLCxYeuwr8LZ0JYXMXTV//FAhHeUvNtFAAtLYy6+re7TyFBcErReKgD76Hv5TyZsWloYKgw==
X-Received: by 2002:a05:600c:2905:b0:3f4:e7c6:989a with SMTP id i5-20020a05600c290500b003f4e7c6989amr14580646wmd.32.1684351542106;
        Wed, 17 May 2023 12:25:42 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id m39-20020a05600c3b2700b003f07ef4e3e0sm5658805wms.0.2023.05.17.12.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:25:41 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 3/6] mm/gup: remove vmas parameter from get_user_pages_remote()
Date:   Wed, 17 May 2023 20:25:39 +0100
Message-Id: <d20128c849ecdbf4dd01cc828fcec32127ed939a.1684350871.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684350871.git.lstoakes@gmail.com>
References: <cover.1684350871.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only instances of get_user_pages_remote() invocations which used the
vmas parameter were for a single page which can instead simply look up the
VMA directly. In particular:-

- __update_ref_ctr() looked up the VMA but did nothing with it so we simply
  remove it.

- __access_remote_vm() was already using vma_lookup() when the original
  lookup failed so by doing the lookup directly this also de-duplicates the
  code.

We are able to perform these VMA operations as we already hold the
mmap_lock in order to be able to call get_user_pages_remote().

As part of this work we add get_user_page_vma_remote() which abstracts the
VMA lookup, error handling and decrementing the page reference count should
the VMA lookup fail.

This forms part of a broader set of patches intended to eliminate the vmas
parameter altogether.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com> (for arm64)
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com> (for s390)
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 arch/arm64/kernel/mte.c   | 17 +++++++++--------
 arch/s390/kvm/interrupt.c |  2 +-
 fs/exec.c                 |  2 +-
 include/linux/mm.h        | 34 +++++++++++++++++++++++++++++++---
 kernel/events/uprobes.c   | 13 +++++--------
 mm/gup.c                  | 12 ++++--------
 mm/memory.c               | 20 ++++++++++----------
 mm/rmap.c                 |  2 +-
 security/tomoyo/domain.c  |  2 +-
 virt/kvm/async_pf.c       |  3 +--
 10 files changed, 64 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index f5bcb0dc6267..cc793c246653 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -419,10 +419,9 @@ long get_mte_ctrl(struct task_struct *task)
 static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 				struct iovec *kiov, unsigned int gup_flags)
 {
-	struct vm_area_struct *vma;
 	void __user *buf = kiov->iov_base;
 	size_t len = kiov->iov_len;
-	int ret;
+	int err = 0;
 	int write = gup_flags & FOLL_WRITE;
 
 	if (!access_ok(buf, len))
@@ -432,14 +431,16 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		return -EIO;
 
 	while (len) {
+		struct vm_area_struct *vma;
 		unsigned long tags, offset;
 		void *maddr;
-		struct page *page = NULL;
+		struct page *page = get_user_page_vma_remote(mm, addr,
+							     gup_flags, &vma);
 
-		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
-					    &vma, NULL);
-		if (ret <= 0)
+		if (IS_ERR_OR_NULL(page)) {
+			err = page == NULL ? -EIO : PTR_ERR(page);
 			break;
+		}
 
 		/*
 		 * Only copy tags if the page has been mapped as PROT_MTE
@@ -449,7 +450,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		 * was never mapped with PROT_MTE.
 		 */
 		if (!(vma->vm_flags & VM_MTE)) {
-			ret = -EOPNOTSUPP;
+			err = -EOPNOTSUPP;
 			put_page(page);
 			break;
 		}
@@ -482,7 +483,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 	kiov->iov_len = buf - kiov->iov_base;
 	if (!kiov->iov_len) {
 		/* check for error accessing the tracee's address space */
-		if (ret <= 0)
+		if (err)
 			return -EIO;
 		else
 			return -EFAULT;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index da6dac36e959..9bd0a873f3b1 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2777,7 +2777,7 @@ static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
 
 	mmap_read_lock(kvm->mm);
 	get_user_pages_remote(kvm->mm, uaddr, 1, FOLL_WRITE,
-			      &page, NULL, NULL);
+			      &page, NULL);
 	mmap_read_unlock(kvm->mm);
 	return page;
 }
diff --git a/fs/exec.c b/fs/exec.c
index a466e797c8e2..25c65b64544b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -220,7 +220,7 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 	 */
 	mmap_read_lock(bprm->mm);
 	ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
-			&page, NULL, NULL);
+			&page, NULL);
 	mmap_read_unlock(bprm->mm);
 	if (ret <= 0)
 		return NULL;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ea82e9e7719..679b41ef7a6d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2366,6 +2366,9 @@ static inline void unmap_shared_mapping_range(struct address_space *mapping,
 	unmap_mapping_range(mapping, holebegin, holelen, 0);
 }
 
+static inline struct vm_area_struct *vma_lookup(struct mm_struct *mm,
+						unsigned long addr);
+
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
@@ -2374,13 +2377,38 @@ extern int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			      void *buf, int len, unsigned int gup_flags);
 
 long get_user_pages_remote(struct mm_struct *mm,
-			    unsigned long start, unsigned long nr_pages,
-			    unsigned int gup_flags, struct page **pages,
-			    struct vm_area_struct **vmas, int *locked);
+			   unsigned long start, unsigned long nr_pages,
+			   unsigned int gup_flags, struct page **pages,
+			   int *locked);
 long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
 			   int *locked);
+
+static inline struct page *get_user_page_vma_remote(struct mm_struct *mm,
+						    unsigned long addr,
+						    int gup_flags,
+						    struct vm_area_struct **vmap)
+{
+	struct page *page;
+	struct vm_area_struct *vma;
+	int got = get_user_pages_remote(mm, addr, 1, gup_flags, &page, NULL);
+
+	if (got < 0)
+		return ERR_PTR(got);
+	if (got == 0)
+		return NULL;
+
+	vma = vma_lookup(mm, addr);
+	if (WARN_ON_ONCE(!vma)) {
+		put_page(page);
+		return ERR_PTR(-EINVAL);
+	}
+
+	*vmap = vma;
+	return page;
+}
+
 long get_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages);
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 59887c69d54c..cac3aef7c6f7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -365,7 +365,6 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 {
 	void *kaddr;
 	struct page *page;
-	struct vm_area_struct *vma;
 	int ret;
 	short *ptr;
 
@@ -373,7 +372,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 		return -EINVAL;
 
 	ret = get_user_pages_remote(mm, vaddr, 1,
-			FOLL_WRITE, &page, &vma, NULL);
+				    FOLL_WRITE, &page, NULL);
 	if (unlikely(ret <= 0)) {
 		/*
 		 * We are asking for 1 page. If get_user_pages_remote() fails,
@@ -474,10 +473,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (is_register)
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
-	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags,
-				    &old_page, &vma, NULL);
-	if (ret <= 0)
-		return ret;
+	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
+	if (IS_ERR_OR_NULL(old_page))
+		return PTR_ERR(old_page);
 
 	ret = verify_opcode(old_page, vaddr, &opcode);
 	if (ret <= 0)
@@ -2027,8 +2025,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	 * but we treat this as a 'remote' access since it is
 	 * essentially a kernel access to the memory.
 	 */
-	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page,
-			NULL, NULL);
+	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);
 	if (result < 0)
 		return result;
 
diff --git a/mm/gup.c b/mm/gup.c
index ce78a5186dbb..1493cc8dd526 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2208,8 +2208,6 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
  * @pages:	array that receives pointers to the pages pinned.
  *		Should be at least nr_pages long. Or NULL, if caller
  *		only intends to ensure the pages are faulted in.
- * @vmas:	array of pointers to vmas corresponding to each page.
- *		Or NULL if the caller does not require them.
  * @locked:	pointer to lock flag indicating whether lock is held and
  *		subsequently whether VM_FAULT_RETRY functionality can be
  *		utilised. Lock must initially be held.
@@ -2224,8 +2222,6 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
  *
  * The caller is responsible for releasing returned @pages, via put_page().
  *
- * @vmas are valid only as long as mmap_lock is held.
- *
  * Must be called with mmap_lock held for read or write.
  *
  * get_user_pages_remote walks a process's page tables and takes a reference
@@ -2262,15 +2258,15 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
 long get_user_pages_remote(struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
-		struct vm_area_struct **vmas, int *locked)
+		int *locked)
 {
 	int local_locked = 1;
 
-	if (!is_valid_gup_args(pages, vmas, locked, &gup_flags,
+	if (!is_valid_gup_args(pages, NULL, locked, &gup_flags,
 			       FOLL_TOUCH | FOLL_REMOTE))
 		return -EINVAL;
 
-	return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+	return __get_user_pages_locked(mm, start, nr_pages, pages, NULL,
 				       locked ? locked : &local_locked,
 				       gup_flags);
 }
@@ -2280,7 +2276,7 @@ EXPORT_SYMBOL(get_user_pages_remote);
 long get_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
-			   struct vm_area_struct **vmas, int *locked)
+			   int *locked)
 {
 	return 0;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 146bb94764f8..8358f3b853f2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5590,7 +5590,6 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
 int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 		       int len, unsigned int gup_flags)
 {
-	struct vm_area_struct *vma;
 	void *old_buf = buf;
 	int write = gup_flags & FOLL_WRITE;
 
@@ -5599,29 +5598,30 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 
 	/* ignore errors, just check how much was successfully transferred */
 	while (len) {
-		int bytes, ret, offset;
+		int bytes, offset;
 		void *maddr;
-		struct page *page = NULL;
+		struct vm_area_struct *vma = NULL;
+		struct page *page = get_user_page_vma_remote(mm, addr,
+							     gup_flags, &vma);
 
-		ret = get_user_pages_remote(mm, addr, 1,
-				gup_flags, &page, &vma, NULL);
-		if (ret <= 0) {
+		if (IS_ERR_OR_NULL(page)) {
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
 #else
+			int res = 0;
+
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
-			vma = vma_lookup(mm, addr);
 			if (!vma)
 				break;
 			if (vma->vm_ops && vma->vm_ops->access)
-				ret = vma->vm_ops->access(vma, addr, buf,
+				res = vma->vm_ops->access(vma, addr, buf,
 							  len, write);
-			if (ret <= 0)
+			if (res <= 0)
 				break;
-			bytes = ret;
+			bytes = res;
 #endif
 		} else {
 			bytes = len;
diff --git a/mm/rmap.c b/mm/rmap.c
index b42fc0389c24..ae127f60a4fb 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2328,7 +2328,7 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 
 	npages = get_user_pages_remote(mm, start, npages,
 				       FOLL_GET | FOLL_WRITE | FOLL_SPLIT_PMD,
-				       pages, NULL, NULL);
+				       pages, NULL);
 	if (npages < 0)
 		return npages;
 
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 31af29f669d2..ac20c0bdff9d 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -916,7 +916,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 	 */
 	mmap_read_lock(bprm->mm);
 	ret = get_user_pages_remote(bprm->mm, pos, 1,
-				    FOLL_FORCE, &page, NULL, NULL);
+				    FOLL_FORCE, &page, NULL);
 	mmap_read_unlock(bprm->mm);
 	if (ret <= 0)
 		return false;
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 9bfe1d6f6529..e033c79d528e 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -61,8 +61,7 @@ static void async_pf_execute(struct work_struct *work)
 	 * access remotely.
 	 */
 	mmap_read_lock(mm);
-	get_user_pages_remote(mm, addr, 1, FOLL_WRITE, NULL, NULL,
-			&locked);
+	get_user_pages_remote(mm, addr, 1, FOLL_WRITE, NULL, &locked);
 	if (locked)
 		mmap_read_unlock(mm);
 
-- 
2.40.1

