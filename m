Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B1770382D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 19:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbjEOR2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 13:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244084AbjEOR1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 13:27:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD9B1154E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 10:26:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b99ef860a40so23844698276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684171584; x=1686763584;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y97BQ7sR2LBYQN45EWEO4FJ6RSEUfFrbQxSXtC1eEEg=;
        b=lnrHEXI214x0JOHTaG19NvuKmqNZq8vfQFKdpU6IFL5CrGuJIGS18GJfVi7BwsHwLu
         z/19S9vAZW30pNF09qix5IlZ31ZEXIfoGPrblHX6Enf6KFUoXTTZnWap+ULYaVY8vhtU
         OkCdhS24qIkQeup6yuRZj7uh7CWNtThe5UGcraCNGfBBC5Hww348MxDxRagpAxcDVTgA
         AZ7h+zuAXJzQAH2BNFM6Zv0fa/yUNkqKLh+ZXEOhgjyLaqTiXJhjvNH8l0R1RPrqwNd7
         0RKoPgChapU4TerGr+ESr+HQzkCOntbXEi2Aj+4c6i7PG4f7i/oYDqbdgA2BE8qDfgLN
         /7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684171584; x=1686763584;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y97BQ7sR2LBYQN45EWEO4FJ6RSEUfFrbQxSXtC1eEEg=;
        b=mGpABQPrBunCmyG/irT5WcFW3/0hmqLualWOAQeGkw+qdgU85SGJD9LitAef4WikE5
         3JVSfJlot2X0bJEon0e3+edoFLDbV0bSehJBVYN/dJyMaLT0SzhONYabMHMAyg3IdO/g
         Yu3Zwe/41R8KQofIAlniIjTemoTmNPqIKrPbJ6qrjXkEBpzc8RHneTf5EqB8wBiEJ23Q
         PNyslYIkHmaPcDlv0nt6p0pgJWeP2gZ3jEgigurG3YYTCLQHsA6vPzd8oY7RGzwQu6BO
         tErMuCuQYoPZpWBQosg7ckNI6nPkgBhWXPD+ZYtfkCT6ATaIDeEK/aygFN31BAdisdH3
         1lDw==
X-Gm-Message-State: AC+VfDybJQXHgt1GSmTpaxXuzfFrUEXteliT4zq5Efq941tKgdXWODo1
        XutCzDtM6CG7TdZVNVS6UPu7YUKbicdR
X-Google-Smtp-Source: ACHHUZ5TeR03DncbFn2MDJZP9KzUWVPcJVpfEqM7CUznGNTSHd5/NHOxIZ8GKK9NiQzFZ/fPDVHY/iZDWiai
X-Received: from yuanchu.bej.corp.google.com ([2401:fa00:44:10:166c:6ee8:fb91:4744])
 (user=yuanchu job=sendgmr) by 2002:a5b:750:0:b0:ba7:75a8:e37d with SMTP id
 s16-20020a5b0750000000b00ba775a8e37dmr3199880ybq.4.1684171584365; Mon, 15 May
 2023 10:26:24 -0700 (PDT)
Date:   Tue, 16 May 2023 01:26:08 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230515172608.3558391-1-yuanchu@google.com>
Subject: [PATCH] mm: pagemap: restrict pagewalk to the requested range
From:   Yuanchu Xie <yuanchu@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        "Zach O'Keefe" <zokeefe@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Yuanchu Xie <yuanchu@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pagewalk in pagemap_read reads one PTE past the end of the requested
range, and stops when the buffer runs out of space. While it produces
the right result, the extra read is unnecessary and less performant.

I timed the following command before and after this patch:
	dd count=100000 if=/proc/self/pagemap of=/dev/null
The results are consistently within 0.001s across 5 runs.

Before:
100000+0 records in
100000+0 records out
51200000 bytes (51 MB) copied, 0.0763159 s, 671 MB/s

real    0m0.078s
user    0m0.012s
sys     0m0.065s

After:
100000+0 records in
100000+0 records out
51200000 bytes (51 MB) copied, 0.0487928 s, 1.0 GB/s

real    0m0.050s
user    0m0.011s
sys     0m0.039s

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 fs/proc/task_mmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 420510f6a545..6259dd432eeb 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1689,23 +1689,23 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	/* watch out for wraparound */
 	start_vaddr = end_vaddr;
 	if (svpfn <= (ULONG_MAX >> PAGE_SHIFT)) {
+		unsigned long end;
+
 		ret = mmap_read_lock_killable(mm);
 		if (ret)
 			goto out_free;
 		start_vaddr = untagged_addr_remote(mm, svpfn << PAGE_SHIFT);
 		mmap_read_unlock(mm);
+
+		end = start_vaddr + ((count / PM_ENTRY_BYTES) << PAGE_SHIFT);
+		if (end >= start_vaddr && end < mm->task_size)
+			end_vaddr = end;
 	}
 
 	/* Ensure the address is inside the task */
 	if (start_vaddr > mm->task_size)
 		start_vaddr = end_vaddr;
 
-	/*
-	 * The odds are that this will stop walking way
-	 * before end_vaddr, because the length of the
-	 * user buffer is tracked in "pm", and the walk
-	 * will stop when we hit the end of the buffer.
-	 */
 	ret = 0;
 	while (count && (start_vaddr < end_vaddr)) {
 		int len;
-- 
2.40.1.606.ga4b1b128d6-goog

