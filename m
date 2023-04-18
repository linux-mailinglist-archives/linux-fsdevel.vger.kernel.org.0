Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9746E689D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjDRPt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 11:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjDRPtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:49:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A1812CB4;
        Tue, 18 Apr 2023 08:49:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f16fd9bc0dso21468825e9.2;
        Tue, 18 Apr 2023 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681832952; x=1684424952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpDTnbIF542CSHK255t29C0dsriOPjDrlIOTnq6VGhg=;
        b=dQ/UuKqsfe7uYvWeE5Pns5rtVd/0AdPad8c6UcyQo+zRskVc5bILEFh+J+6CCSO2kB
         EQFeaaF6avE2fcC6GNrRKY+SbeSrwYTTV+HgN1j0eSYVYP8/UkNn49BMZvplcC8SFFiJ
         kT68gM1qGUkiZoWqhPxmjveTuQXDah1AOW2VZX/EN4P9WCTE1SPbZtTO43LrVfB12rJf
         HyAHHKgmiIS9VMKrGTV3L5McvFJAzvLANCZzingrQGv819mJXKz10LaT85JPYPpzyFE4
         8YTBz1NpC4zpqv0L+IeiVh6WgfmFVhz+XnMhKpUP1RVuAoO9uQO+k8AEsFVgT0uaZXKy
         4lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832952; x=1684424952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpDTnbIF542CSHK255t29C0dsriOPjDrlIOTnq6VGhg=;
        b=TxOKB62d6qgfzEsZ2dwFqOnyKBFE40DkpYTXSBJjWdKnQOPRLFO/EuXCLdZ6XOfnRk
         f+bhPcJkLupTCYk1dRDl1pfbO2/Px0xIps97mlkDZ3SayLdtgShzhe1U27BVyLd2VDrF
         1cHkzIi7D0XYPa+snaIqNQsaquCpyeBlUCOULIwUezvlvOKyWnWN1bQ7og4u+pJxwGML
         n+CCOcEJw1j8btMFLYAtYFBfHwjEOw0QuSvZ7VbeRFy4aVhjGKqDfmY+l7nDYf35DVLv
         OAOxa1wRqRHi4Z+IZ7vf1IQEpyj744eRG/CU3I2VMA62+CdzxRQbpVu/rqGS0/6gGafm
         L6+Q==
X-Gm-Message-State: AAQBX9ewLSRf8b3hqTJO0gXfz4xNUxbVcN9dieHB1Z0CDXWDnYcpw+Bv
        OkeFBy4Gjo25ZVsdRVtNmQk=
X-Google-Smtp-Source: AKy350bVV4uQ8lR+SE5X/kHt9mn8be5pAW7rko/h8BvM6/W0i2CW942gZ/uHrHsWr5XB841GP2+ddg==
X-Received: by 2002:adf:f8d1:0:b0:2e6:3804:5be with SMTP id f17-20020adff8d1000000b002e6380405bemr2239587wrq.59.1681832951798;
        Tue, 18 Apr 2023 08:49:11 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id l12-20020a1c790c000000b003f179fc6d8esm2254274wme.44.2023.04.18.08.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:49:11 -0700 (PDT)
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
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 3/6] mm/gup: remove vmas parameter from get_user_pages_remote()
Date:   Tue, 18 Apr 2023 16:49:08 +0100
Message-Id: <7c6f1ae88320bf11d2f583178a3d9e653e06ac63.1681831798.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681831798.git.lstoakes@gmail.com>
References: <cover.1681831798.git.lstoakes@gmail.com>
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
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 arch/arm64/kernel/mte.c   | 17 +++++++++--------
 arch/s390/kvm/interrupt.c |  2 +-
 fs/exec.c                 |  2 +-
 include/linux/mm.h        | 34 +++++++++++++++++++++++++++++++---
 kernel/events/uprobes.c   | 13 +++++--------
 mm/gup.c                  | 12 ++++--------
 mm/memory.c               | 14 +++++++-------
 mm/rmap.c                 |  2 +-
 security/tomoyo/domain.c  |  2 +-
 virt/kvm/async_pf.c       |  3 +--
 10 files changed, 61 insertions(+), 40 deletions(-)

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
index 9250fde1f97d..c19d0cb7d2f2 100644
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
index 87cf3a2f0e9a..d8d48ee15aac 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -219,7 +219,7 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 	 */
 	mmap_read_lock(bprm->mm);
 	ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
-			&page, NULL, NULL);
+			&page, NULL);
 	mmap_read_unlock(bprm->mm);
 	if (ret <= 0)
 		return NULL;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ec9875c59f6d..0c236e2f25e2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2364,6 +2364,9 @@ static inline void unmap_shared_mapping_range(struct address_space *mapping,
 	unmap_mapping_range(mapping, holebegin, holelen, 0);
 }
 
+static inline struct vm_area_struct *vma_lookup(struct mm_struct *mm,
+						unsigned long addr);
+
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
@@ -2372,13 +2375,38 @@ extern int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
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
index 931c805bc32b..9440aa54c741 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2165,8 +2165,6 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
  * @pages:	array that receives pointers to the pages pinned.
  *		Should be at least nr_pages long. Or NULL, if caller
  *		only intends to ensure the pages are faulted in.
- * @vmas:	array of pointers to vmas corresponding to each page.
- *		Or NULL if the caller does not require them.
  * @locked:	pointer to lock flag indicating whether lock is held and
  *		subsequently whether VM_FAULT_RETRY functionality can be
  *		utilised. Lock must initially be held.
@@ -2181,8 +2179,6 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
  *
  * The caller is responsible for releasing returned @pages, via put_page().
  *
- * @vmas are valid only as long as mmap_lock is held.
- *
  * Must be called with mmap_lock held for read or write.
  *
  * get_user_pages_remote walks a process's page tables and takes a reference
@@ -2219,15 +2215,15 @@ static bool is_valid_gup_args(struct page **pages, struct vm_area_struct **vmas,
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
@@ -2237,7 +2233,7 @@ EXPORT_SYMBOL(get_user_pages_remote);
 long get_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
-			   struct vm_area_struct **vmas, int *locked)
+			   int *locked)
 {
 	return 0;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 8ddb10199e8d..61b7192acf98 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5577,7 +5577,6 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
 int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 		       int len, unsigned int gup_flags)
 {
-	struct vm_area_struct *vma;
 	void *old_buf = buf;
 	int write = gup_flags & FOLL_WRITE;
 
@@ -5586,13 +5585,15 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 
 	/* ignore errors, just check how much was successfully transferred */
 	while (len) {
-		int bytes, ret, offset;
+		int bytes, offset;
 		void *maddr;
-		struct page *page = NULL;
+		struct vm_area_struct *vma;
+		struct page *page = get_user_page_vma_remote(mm, addr,
+							     gup_flags, &vma);
+
+		if (IS_ERR_OR_NULL(page)) {
+			int ret = 0;
 
-		ret = get_user_pages_remote(mm, addr, 1,
-				gup_flags, &page, &vma, NULL);
-		if (ret <= 0) {
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
 #else
@@ -5600,7 +5601,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
-			vma = vma_lookup(mm, addr);
 			if (!vma)
 				break;
 			if (vma->vm_ops && vma->vm_ops->access)
diff --git a/mm/rmap.c b/mm/rmap.c
index ba901c416785..756ea8a9bb90 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2324,7 +2324,7 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 
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
2.40.0

