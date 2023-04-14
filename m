Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B636E29C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 20:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDNSAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 14:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNSAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:00:48 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58CC7DB6
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:00:47 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id a72-20020a63904b000000b0051b7b925efeso718713pge.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681495247; x=1684087247;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vrpytJrQkeMnSBoK05n6C3PVwm0AhQVwCbqW6lOv8WI=;
        b=I0MSTyggzSSsOoQJjyGrso/7Ybeopii3TjXK3ukhg1ZB/4io6QzG1BwsA1C0yT/loh
         n6ClZYWNFbLZiRPRvChwZHfYVGAwte3VJpkRziPllFiBNERgJ9QRme+PVgf8DNh9u/yd
         DNXT8doZ70gPqMtfdeOXYsOFny71YkC8/JWP4JcJYyTxwEFsYDUnqLDTF26pORtCpguw
         +unNZBR8+bYQqvQCmRg8kRM4L9qEB9Sv06+FZxWl2LXZUxEA6jzQDCuuwRdLTdG6IDWg
         fIKwzH8ycwC2+9LPQmrvE1OIt53IiTrnddq6TvFhw0FCWMdQQ1D3ErYizr1wYFvTHCNp
         OzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681495247; x=1684087247;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrpytJrQkeMnSBoK05n6C3PVwm0AhQVwCbqW6lOv8WI=;
        b=k3r/sG4eNVIKFt6zrA2qQ43Zqm7w+Q5+Kte4TaW/miM0fmV6+77RH/d8P0NcJaPUog
         g6YgWbljOe7A+xvzmrAObP1scjM/wqtOd1CUq+OG/pUWNUJSvYZYLdYNBR6S6zWo53X2
         /DP9pHUiEraJyjwoG72OyDUwpxVhMEicrKNP1uJusHB3DTKVIg5iYsKR7JMbUvUXwpew
         KC7eFKK1BUSTWfrhf+JODjsO9s6XnlhaFpLU+gFxCdosn+MTSRRTjNed7A+L9kXS7PSs
         D3Uo4UVaGwaE/tE2oRXz5wSlrxVSpcGEmCZJLwkGAF/wDu92ru0/viqDL4rjjRk/O2Sv
         NZoQ==
X-Gm-Message-State: AAQBX9dP3mM0VmqIpcLLnAfH19UT0xkeVK/xFzMFV+Q/VrVXDNnVCJEP
        h0v9QPaWEY320Is6HQvu/1FeD6oQKmM=
X-Google-Smtp-Source: AKy350b7HRLz3uh0vBz0/Uzl8Z+fa6BzF8jLXkvpc+cVek+DZVtKLCgPYkVzSF5sDmnJyeu0FdtqA4SmhFg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:46c0:7584:f020:e09f])
 (user=surenb job=sendgmr) by 2002:a63:4818:0:b0:50b:188d:25bb with SMTP id
 v24-20020a634818000000b0050b188d25bbmr986965pga.5.1681495246966; Fri, 14 Apr
 2023 11:00:46 -0700 (PDT)
Date:   Fri, 14 Apr 2023 11:00:43 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414180043.1839745-1-surenb@google.com>
Subject: [PATCH 1/1] mm: handle swap page faults if the faulting page can be locked
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, surenb@google.com, linux-mm@kvack.org,
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

When page fault is handled under VMA lock protection, all swap page
faults are retried with mmap_lock because folio_lock_or_retry
implementation has to drop and reacquire mmap_lock if folio could
not be immediately locked.
Instead of retrying all swapped page faults, retry only when folio
locking fails.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Patch applies cleanly over linux-next and mm-unstable

 mm/filemap.c | 6 ++++++
 mm/memory.c  | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6f3a7e53fccf..67b937b0f436 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1706,6 +1706,8 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
  *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
  *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
  *     which case mmap_lock is still held.
+ *     If flags had FAULT_FLAG_VMA_LOCK set, meaning the operation is performed
+ *     with VMA lock only, the VMA lock is still held.
  *
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
  * with the folio locked and the mmap_lock unperturbed.
@@ -1713,6 +1715,10 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 			 unsigned int flags)
 {
+	/* Can't do this if not holding mmap_lock */
+	if (flags & FAULT_FLAG_VMA_LOCK)
+		return false;
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
diff --git a/mm/memory.c b/mm/memory.c
index d88f370eacd1..3301a8d01820 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3715,11 +3715,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		ret = VM_FAULT_RETRY;
-		goto out;
-	}
-
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
-- 
2.40.0.634.g4ca3ef3211-goog

