Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B66E2CD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 01:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDNX1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 19:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDNX1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:27:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF2D4ECB;
        Fri, 14 Apr 2023 16:27:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f0915c64a3so1143475e9.2;
        Fri, 14 Apr 2023 16:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681514860; x=1684106860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6w7qsUrIZVMYyezihKSOSDmFZP615zixrYx92E8QQo=;
        b=jKu8YD2mb2mdFw5P+t9eP3xWbWMdAKdVk6UFDj7Pls/BFK24F/zY5RkOEpV+Z/4SMO
         ATpkxXP+1gfJB2eLN/vM1CK2ktHBQ9PWdaPUeBhVqf9zkFuflSxYmofBTCGc1j1XyZbD
         VDoXzMW5DkvNSEQ35rLWUduulDQ5w8VOrz8xGtIuXLP96Lyb5Ax8SzSA9RE1D/QBOqPJ
         DAECQmJyaS6I/0ayg2Qf2pJxAMl3+REQevWrGHXtfsVqR90u9W68E02qQTWHTHWiTi2t
         0KWbirSzAXIMO9phmRLGd7Xrf1nX0hie2axqdFRrfShkkWvWpCkQqPWYgLJivic7D+ox
         osBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681514860; x=1684106860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6w7qsUrIZVMYyezihKSOSDmFZP615zixrYx92E8QQo=;
        b=duVFLvtlv0aDwd3apiPbALU+37kTjfzQFEe6+OZgwcbfufgAkrhaaXjExnbkbHQ+cf
         2o+Csq3ATxMioj+eXpPuqUjM2gZWEKyLLoYraLfHlkU9QsqFHkPkEHgbdftWKMABzQnp
         YJhSuA53I+vGtw5XsAkWBPLbtBd7s6rGRCPU/Xwu2TX1pR+5c51GPW5WOsHnRN6r8bNE
         pfwTZuVNVzxWqQMZENrqivSSzDsH5fH/C7N/w/sdUXc/3UL30eKe+/ReQvEPq36t8PXW
         5ibo40Ke9dC9TXIFXYw5TubPiSgwDs65R7E1jXp4en3CiwBIz3nD4ZUczW9q8klOXjFu
         Ti4Q==
X-Gm-Message-State: AAQBX9doK3SISBF2jyk5EFk7adqcBjQFu2DiBSDZVZ9IRbIx6jwxwMQE
        UpEnQTJ3iHwiWkbPcD7jShs=
X-Google-Smtp-Source: AKy350aJKmiwh3Ey8dieXSt891lDzJHNf1+WVI3JkLWuAx/38LDDVDHArdK7qm4JltNbYJDkMuJT5Q==
X-Received: by 2002:adf:df04:0:b0:2c7:df22:1184 with SMTP id y4-20020adfdf04000000b002c7df221184mr243611wrl.56.1681514860186;
        Fri, 14 Apr 2023 16:27:40 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id 8-20020a05600c22c800b003ef71d541cbsm5370017wmg.1.2023.04.14.16.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 16:27:39 -0700 (PDT)
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
Subject: [PATCH 3/7] mm/gup: remove vmas parameter from get_user_pages_remote()
Date:   Sat, 15 Apr 2023 00:27:31 +0100
Message-Id: <5a4cf1ebf1c6cdfabbf2f5209facb0180dd20006.1681508038.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681508038.git.lstoakes@gmail.com>
References: <cover.1681508038.git.lstoakes@gmail.com>
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

This forms part of a broader set of patches intended to eliminate the vmas
parameter altogether.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 arch/arm64/kernel/mte.c   |  5 +++--
 arch/s390/kvm/interrupt.c |  2 +-
 fs/exec.c                 |  2 +-
 include/linux/mm.h        |  2 +-
 kernel/events/uprobes.c   | 10 +++++-----
 mm/gup.c                  | 12 ++++--------
 mm/memory.c               |  9 +++++----
 mm/rmap.c                 |  2 +-
 security/tomoyo/domain.c  |  2 +-
 virt/kvm/async_pf.c       |  3 +--
 10 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index f5bcb0dc6267..74d8d4007dec 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -437,8 +437,9 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		struct page *page = NULL;
 
 		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
-					    &vma, NULL);
-		if (ret <= 0)
+					    NULL);
+		vma = vma_lookup(mm, addr);
+		if (ret <= 0 || !vma)
 			break;
 
 		/*
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
index 513d5fab02f1..8dfa236cfb58 100644
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
index 59887c69d54c..35e8a7ec884c 100644
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
@@ -475,8 +474,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
 	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags,
-				    &old_page, &vma, NULL);
-	if (ret <= 0)
+				    &old_page, NULL);
+	vma = vma_lookup(mm, vaddr);
+	if (ret <= 0 || !vma)
 		return ret;
 
 	ret = verify_opcode(old_page, vaddr, &opcode);
@@ -2028,7 +2028,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	 * essentially a kernel access to the memory.
 	 */
 	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page,
-			NULL, NULL);
+				       NULL);
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
index ea8fdca35df3..43426147f9f7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5596,7 +5596,11 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 		struct page *page = NULL;
 
 		ret = get_user_pages_remote(mm, addr, 1,
-				gup_flags, &page, &vma, NULL);
+				gup_flags, &page, NULL);
+		vma = vma_lookup(mm, addr);
+		if (!vma)
+			break;
+
 		if (ret <= 0) {
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
@@ -5605,9 +5609,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
-			vma = vma_lookup(mm, addr);
-			if (!vma)
-				break;
 			if (vma->vm_ops && vma->vm_ops->access)
 				ret = vma->vm_ops->access(vma, addr, buf,
 							  len, write);
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

