Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC465741720
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjF1R0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjF1RZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:25:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0234E1FEB
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c118efd0c36so229725276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687973139; x=1690565139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Etjd7yIk6y8wpf6gNh6t/+qVgTHbYuzl98QGtof+wLo=;
        b=f/qWBsZGlwZ5P3Q7P10m/N0F147acALs/pNCcM/R0Pth04XyJd0edvT4fGoeFanU7i
         nprMaYJ57ZehrPFrJEWv3ay7af2qJ50IjmH60upDZ9HdpmFC8tlgMQahwdbr6hPxrcaH
         iOO6oMrTdA91rUvBSlj3mK5n37r8vBp1nCpkzIfw6tcfelQj9RfuyeoCq4XRyPGgxE2q
         dQMo/1n5ck9TGwQyYB/muJ7ImteNS4kZ9vd0EFUXwjlDgrqn/G4AIMcN3x+wt+TV2nOX
         SE48ZlUM2T4t9Cw7Ds2yMNxtlnhpPB6+PXqMHtIIOsUUg96SvUV200B4lfaag6Y6fl1F
         QOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973139; x=1690565139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Etjd7yIk6y8wpf6gNh6t/+qVgTHbYuzl98QGtof+wLo=;
        b=fUDo/pMJkohi2yTGWOBLqVeEUoUcaOzN7P6erFPY4xFMWvwOEnbxcgZyJ+vILrZ8ju
         Hln0LX1ny+qt8NXJck9tbpc34KcZNHRpycfj2CLXrkNBCTDNzBs16sYY7ZNvEnJPUmkc
         3Xswtv6olOu1M5Q3lzq/qkedb1JOmgkpRJ4jHF3Ff2ghoOrerFs0e8WFkMSotEMHRcow
         oDXEgq6/jJ1LraG2OSBQQWeecCorOfp4ViFbr7hcS059nDl5TMowgzySqReiVLUHNSX0
         o7bejJdNFASFtMgPdyCTF6e/ZTtPm4qaW9pQKwIBub97QwD5Takk49ymX+x2v7kJlq0+
         rBug==
X-Gm-Message-State: ABy/qLbh3bPvKeK6AoGU1gJ+vghubMNmB5E2pKTbsV4amhO2BDDEDoAu
        le6H1x1cA/aFS8KsrDgQ48PUVR4Okxk=
X-Google-Smtp-Source: APBJJlGsLGXNMWvz9SGYOgX+1/1dEWX9HTUaDi0WsEVrC4gPxKfPFDmgxWjZwZruzhN/4I0d7h/V6yPZrxg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:eea3:e898:7d7a:1125])
 (user=surenb job=sendgmr) by 2002:a25:f501:0:b0:ba8:1646:c15d with SMTP id
 a1-20020a25f501000000b00ba81646c15dmr21941ybe.1.1687973139195; Wed, 28 Jun
 2023 10:25:39 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:25:26 -0700
In-Reply-To: <20230628172529.744839-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628172529.744839-4-surenb@google.com>
Subject: [PATCH v5 3/6] mm: drop per-VMA lock when returning VM_FAULT_RETRY or VM_FAULT_COMPLETED
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
rules consistent for the caller, drop the per-VMA lock when returning
VM_FAULT_RETRY or VM_FAULT_COMPLETED. Currently the only path returning
VM_FAULT_RETRY under per-VMA locks is do_swap_page and no path returns
VM_FAULT_COMPLETED for now.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c   | 3 ++-
 arch/powerpc/mm/fault.c | 3 ++-
 arch/s390/mm/fault.c    | 3 ++-
 arch/x86/mm/fault.c     | 3 ++-
 mm/memory.c             | 1 +
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c85b6d70b222..9c06c53a9ff3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -612,7 +612,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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
index f69fbc251198..f14d45957b83 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3713,6 +3713,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 		ret = VM_FAULT_RETRY;
+		vma_end_read(vma);
 		goto out;
 	}
 
-- 
2.41.0.162.gfafddb0af9-goog

