Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD5E6E2FE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 11:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDOJIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 05:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDOJIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:08:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F50E6EA1;
        Sat, 15 Apr 2023 02:08:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f7a7f9667bso169420f8f.1;
        Sat, 15 Apr 2023 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681549719; x=1684141719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU5XBdBhZNlo0+3G/D0/kUTKBCmlg8gN20o0h9fnHXU=;
        b=ku3pBj0LZFTzpWzE2T7M2Fle9zjSMkPWeX/32sk89A1RSbYjMPlEGhQxMICGWk5SQi
         nR+g2yRd3vpG2cOlbvKce7ZJ9tsgUHh2mV5kwjfqUoQ6x65Obima1ac4D/nRUUH7uy8s
         oLZrAxikJ+/VvRJnKyhqRoDFfJoPW2HUPxoI1qXYSrkyDsj+j6xQExzqXZ6bSeS4bkyH
         yTGp6ILrhnzoJM5CtX6vjYxLGUM/4X/qQJG8Juh8sLhxyW/EgdztysGkRcAcG+Ouh8Ky
         +Izr89EdK5ZVRg+7vEtR6Od4LFaRAEWH0TD6HTTthlMqQZAo/Rpl9t5Cmnu1yrbpXR6b
         bSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681549719; x=1684141719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU5XBdBhZNlo0+3G/D0/kUTKBCmlg8gN20o0h9fnHXU=;
        b=LmlnQdgg4hEdo3FcTrExfCq9oLcpgX0iiOhr/AJej9mwA0aLmY3tbLZwtM5C61G/ZY
         dvMyserl8VgW1iyI96o7nSlU6OoZM3mpbEywAAGvTtHdTaShZGPXtEGD9bIcXsRLeCeg
         Dp5UQPkeYyBIlspSKVqpguWvzaMsDFKYtxs7xLjszMED1EjkbjoR7tPMRwEGqzN3v1dA
         amZTxbLXxUV3fK5mwOR8fUJPLMTJOpnN4BNC6czrg8YntcOyW2yWBJmWI0Q0spDTODXo
         fHTiqVh/4dPPKRiyBunj6S7mtZB5MhRui6XverY9CP1oXT+s+myCHuMFSur/IVxqyYJM
         By8w==
X-Gm-Message-State: AAQBX9dX7dI/HyBodNSWZFVqAorX9nkSD1NqtC3U88qfPmODesaSTR1y
        hsBWticxpnSsh//Hv0RUImA=
X-Google-Smtp-Source: AKy350YqhaHjGrrIWI6HtvoUC4q0CJmNJshJ4HMSKWRqtZHzRcru1rPhk/NMIu6RYyif+yR/1zyrVA==
X-Received: by 2002:adf:e0c3:0:b0:2cf:e747:b0d4 with SMTP id m3-20020adfe0c3000000b002cfe747b0d4mr1119861wri.40.1681549719045;
        Sat, 15 Apr 2023 02:08:39 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id v3-20020adfe4c3000000b002f459afc809sm5325162wrm.72.2023.04.15.02.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 02:08:38 -0700 (PDT)
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
Subject: [PATCH v2 3/7] mm/gup: remove vmas parameter from get_user_pages_remote()
Date:   Sat, 15 Apr 2023 10:08:34 +0100
Message-Id: <631001ecc556c5e348ff4f47719334c31f7bd592.1681547405.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681547405.git.lstoakes@gmail.com>
References: <cover.1681547405.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

This forms part of a broader set of patches intended to eliminate the vmas
parameter altogether.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 arch/arm64/kernel/mte.c   |  7 ++++---
 arch/s390/kvm/interrupt.c |  2 +-
 fs/exec.c                 |  2 +-
 include/linux/mm.h        |  2 +-
 kernel/events/uprobes.c   | 12 +++++++-----
 mm/gup.c                  | 12 ++++--------
 mm/memory.c               |  9 +++++----
 mm/rmap.c                 |  2 +-
 security/tomoyo/domain.c  |  2 +-
 virt/kvm/async_pf.c       |  3 +--
 10 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index f5bcb0dc6267..d43a744d7919 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -419,7 +419,6 @@ long get_mte_ctrl(struct task_struct *task)
 static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 				struct iovec *kiov, unsigned int gup_flags)
 {
-	struct vm_area_struct *vma;
 	void __user *buf = kiov->iov_base;
 	size_t len = kiov->iov_len;
 	int ret;
@@ -432,12 +431,13 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		return -EIO;
 
 	while (len) {
+		struct vm_area_struct *vma;
 		unsigned long tags, offset;
 		void *maddr;
 		struct page *page = NULL;
 
 		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
-					    &vma, NULL);
+					    NULL);
 		if (ret <= 0)
 			break;
 
@@ -448,7 +448,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		 * would cause the existing tags to be cleared if the page
 		 * was never mapped with PROT_MTE.
 		 */
-		if (!(vma->vm_flags & VM_MTE)) {
+		vma = vma_lookup(mm, addr);
+		if (!vma || !(vma->vm_flags & VM_MTE)) {
 			ret = -EOPNOTSUPP;
 			put_page(page);
 			break;
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
index ec9875c59f6d..1bfe73a2b6d3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2374,7 +2374,7 @@ extern int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 long get_user_pages_remote(struct mm_struct *mm,
 			    unsigned long start, unsigned long nr_pages,
 			    unsigned int gup_flags, struct page **pages,
-			    struct vm_area_struct **vmas, int *locked);
+			    int *locked);
 long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 59887c69d54c..b21993cd2dcc 100644
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
@@ -475,10 +474,14 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
 	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags,
-				    &old_page, &vma, NULL);
+				    &old_page, NULL);
 	if (ret <= 0)
 		return ret;
 
+	vma = vma_lookup(mm, vaddr);
+	if (!vma)
+		goto put_old;
+
 	ret = verify_opcode(old_page, vaddr, &opcode);
 	if (ret <= 0)
 		goto put_old;
@@ -2027,8 +2030,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
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
index 8ddb10199e8d..913e693322f2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5591,7 +5591,9 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 		struct page *page = NULL;
 
 		ret = get_user_pages_remote(mm, addr, 1,
-				gup_flags, &page, &vma, NULL);
+				gup_flags, &page, NULL);
+		vma = vma_lookup(mm, addr);
+
 		if (ret <= 0) {
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
@@ -5600,7 +5602,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
-			vma = vma_lookup(mm, addr);
 			if (!vma)
 				break;
 			if (vma->vm_ops && vma->vm_ops->access)
@@ -5617,11 +5618,11 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 				bytes = PAGE_SIZE-offset;
 
 			maddr = kmap(page);
-			if (write) {
+			if (write && vma) {
 				copy_to_user_page(vma, page, addr,
 						  maddr + offset, buf, bytes);
 				set_page_dirty_lock(page);
-			} else {
+			} else if (vma) {
 				copy_from_user_page(vma, page, addr,
 						    buf, maddr + offset, bytes);
 			}
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

