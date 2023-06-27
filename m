Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD20373F353
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjF0EYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjF0EXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:23:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC381999
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bfae0f532e4so5218819276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687839820; x=1690431820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S48dBfG0SWV0QU4tyl9ann+yNi8sxz8gZYLMNRkbGeY=;
        b=uyhBbu35AtD8uFc7lNVRhrhL9FZssNEc1U3YlNjnS6/vWb6a5ERBcwBMaYSPxjJ/Mk
         Qe5HTpNa5XqvLjiojjNbFmZN0xmWKkvRVR4N08jGcpfsLakGmZkxol+hWOUA2MEdPtG3
         CCWMkRdx3oFd6/Dcq2ziTDhiHH5hTD+8UeRRw0fdTOeqAixqf3jfdQ7B3ZgYpw+aT0x0
         7n1tbaJiroElOh+0zEGZhbUInAo3kZrsUt6r5yZG0ZhF8kLRGvyK6fttt1xmJKJlC+bc
         8aGAiRC7PO3v1V82sW0UO8XGuG6YrM7whEZUcc8FMaVdHAxabZ1AEzNvmsHlLQ8otu9G
         mugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687839820; x=1690431820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S48dBfG0SWV0QU4tyl9ann+yNi8sxz8gZYLMNRkbGeY=;
        b=OZgrDphJnLKGJcVwnBzdixIp4oMBLNWI2MFSnm4XlveC+cLlm4P0MeCHz9B4G3WmZT
         ozzmQN8tzZczw6qllYgPo/YM8Wjrkb2KBw2zlhN8QNIzgzRbiTWLTtaDf4aYlEMlkK4/
         +GGAix8RQ581zDqhizduY3wQzHr90uP4jSt+/LfWKxi6h9U3no/x2cXElwg3lJ75BEyN
         80ehyvMc17uYLcuDcfV9nelvmdHHgihC8ZMhftDBlkUixmibhd3OwlnubHzulmX3Tl2H
         Z7CEshZ7OobdZtZa9FsxnXViCb1/PFDQlx8DEfQX8tWq1GcoOVZMlPNq/nmhAL6E0S3U
         1fxw==
X-Gm-Message-State: AC+VfDzIXfjDkovms21nILmjVlJtaXLcPQwpFnDqm9wREzQlUYL26y0P
        cA8gRS3L/pSC9ilXtZIfJg4mTxTAymU=
X-Google-Smtp-Source: ACHHUZ7TRsCUwE2ZwvAugNjG47XxvELjQ1x8vS3tmisicM0hRabZmbuVIm5qRhxSsRS9QjFAyyEcLENdUAY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a25:e78a:0:b0:bc4:ef98:681c with SMTP id
 e132-20020a25e78a000000b00bc4ef98681cmr6584157ybh.13.1687839820015; Mon, 26
 Jun 2023 21:23:40 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:23:20 -0700
In-Reply-To: <20230627042321.1763765-1-surenb@google.com>
Mime-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627042321.1763765-8-surenb@google.com>
Subject: [PATCH v3 7/8] mm: drop VMA lock before waiting for migration
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

migration_entry_wait does not need VMA lock, therefore it can be
dropped before waiting.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memory.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5caaa4c66ea2..bdf46fdc58d6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3715,8 +3715,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
-			migration_entry_wait(vma->vm_mm, vmf->pmd,
-					     vmf->address);
+			/* Save mm in case VMA lock is dropped */
+			struct mm_struct *mm = vma->vm_mm;
+
+			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+				/*
+				 * No need to hold VMA lock for migration.
+				 * WARNING: vma can't be used after this!
+				 */
+				vma_end_read(vma);
+				ret |= VM_FAULT_COMPLETED;
+			}
+			migration_entry_wait(mm, vmf->pmd, vmf->address);
 		} else if (is_device_exclusive_entry(entry)) {
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
-- 
2.41.0.178.g377b9f9a00-goog

