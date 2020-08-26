Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00AF25334F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHZPQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 11:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgHZPPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D59C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:53 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v16so1893894qka.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7aZgefibZrTCs6XQP3SSXIsvAQ9RHGTwgc0UHLaNuJc=;
        b=PZRtl3oEvcUqv3W5Kf6A433P7e2W3tl/mCCy3xK3DV/7P/aXv0u06wYmjDvvZEQWOT
         ec/yeyDjZzlkcqBgnSCJVm01y8rwgXg0XhozXR3K/Qt+NSPOvhHC8OdoYrSdOhv7TZjP
         mXNFSgjT8pyGVkBj5APT7WYyRtNTxMfIeHp+vXwRYaP0z6eee2VPXSr30DB6lbnor3YM
         18ZIzWMCS3dqI9hPlOsgn5kk4s2gN+rMvTtl9/3sT+zhcVisuexKfn5RTr/4IVWvn76D
         eiwl+5wyVMCTrHqG84CNQSdNJYTgnxdCwBdzLqSxPpQEE31nmdOkhMePpT4krSphqKqP
         xYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7aZgefibZrTCs6XQP3SSXIsvAQ9RHGTwgc0UHLaNuJc=;
        b=qkg4En1L2KTRtMOoVo/bOQqjKcrIYHi7C59MqZBMDwYDzPSuQo01UNi3SgRLrSQK99
         F8n/uHkTk1APGQtBr1R+JagT2OjmgZeIYFwE23AoVrmMTpVr0diFWD0V/MSlZniL8uUR
         EHKCDM3ESTlGm07DPqo8pv1y30YnYbO5z7SVxSywxaQ0kg4aDCz/t1pk4sGyHXwgk+ko
         PPT3nzJRXoUN0rE2cYJo4jmVOQmcIIwY+mEp6EssWcigI1yaxOOPMzzzwyqrSU9Wzayx
         dYjrbbkW9DZXLfNH1Ybf8XzFm56RhkSiFTsD6DMwy7yHDVVr52cpZ5UW4TAduIPdEQfs
         jkVA==
X-Gm-Message-State: AOAM533f9ql2uIVJcbMoHik5P/+1+Z2zlX8AUTqM1C58MDwzlwSLpCcq
        1UJPIJIUopZpiwEApGY3s2tVfeqMFg==
X-Google-Smtp-Source: ABdhPJzslNHRMbDlTLSVH+ySRuZDYmPvdWgqFZD9I7LbDYlgShjS4rqt60Xa4GlkiwlcHLvW6gI3Hs+U2A==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a0c:f4d0:: with SMTP id o16mr14300775qvm.225.1598454952452;
 Wed, 26 Aug 2020 08:15:52 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:14:48 +0200
In-Reply-To: <20200826151448.3404695-1-jannh@google.com>
Message-Id: <20200826151448.3404695-6-jannh@google.com>
Mime-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 5/5] mm/gup: Take mmap_lock in get_dump_page()
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Properly take the mmap_lock before calling into the GUP code from
get_dump_page(); and play nice, allowing the GUP code to drop the mmap_lock
if it has to sleep.

As Linus pointed out, we don't actually need the VMA because
__get_user_pages() will flush the dcache for us if necessary.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/gup.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 92519e5a44b3..bd0f7311c5c6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1552,19 +1552,23 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
  * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
  * allowing a hole to be left in the corefile to save diskspace.
  *
- * Called without mmap_lock, but after all other threads have been killed.
+ * Called without mmap_lock (takes and releases the mmap_lock by itself).
  */
 #ifdef CONFIG_ELF_CORE
 struct page *get_dump_page(unsigned long addr)
 {
-	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
 	struct page *page;
+	int locked = 1;
+	int ret;
 
-	if (__get_user_pages_locked(current->mm, addr, 1, &page, &vma, NULL,
-				    FOLL_FORCE | FOLL_DUMP | FOLL_GET) < 1)
+	if (mmap_read_lock_killable(mm))
 		return NULL;
-	flush_cache_page(vma, addr, page_to_pfn(page));
-	return page;
+	ret = __get_user_pages_locked(mm, addr, 1, &page, NULL, &locked,
+				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
+	if (locked)
+		mmap_read_unlock(mm);
+	return (ret == 1) ? page : NULL;
 }
 #endif /* CONFIG_ELF_CORE */
 
-- 
2.28.0.297.g1956fa8f8d-goog

