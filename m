Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84C9254494
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgH0LxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 07:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgH0Lu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:50:58 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FF7C0619C1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:50:03 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id v11so1827989edr.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7aZgefibZrTCs6XQP3SSXIsvAQ9RHGTwgc0UHLaNuJc=;
        b=qAl3aYBuljMXDgGHSGVDp+hgxe+gqGFmAWy4rRnhiga/eisuFw16UE3XkV1gF06/rw
         N49bdbuxV6EwXiDzAvesC/DoZmDX3L/5rN1/EUfXfknzL6Yq25+xirgAm6bTrx1qdzlg
         48kPTyb1jWCxPQ5QRpbpvOLyB4xMZj9SQ33HjhROU6Y4JbC/ffa6Ppz1ujabxx0i/W7p
         biZ/pGZTE2ifWHW9M2HQ1aj7T23aompUwxKttebsptCS0lMr62sq7+TFDJi0bPS0vKEs
         U0e7G5uYqwdIfHjhgM/r/9A/u1lUQ1eGs8hqvXJNCAjlDAVw1eHVdErrdoNQ6173LzqE
         ujeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7aZgefibZrTCs6XQP3SSXIsvAQ9RHGTwgc0UHLaNuJc=;
        b=c+7WvQ6D2DwQV9b5corbN/3nXtWQhc61N6HGTzvHdNlMcxrosAQ93GuGh4knzeqB8f
         1MzeFvhfLtI+U+GDSMLoxeViVFeGL6wBxrEWs8oGpKT/tnyvK2Kpl5j9nbd25T6RGIJh
         uf1gsMYGwPWVhrukRXUS4Gj5sfdGrHz5nU/ZTff+gNKR/jmxGY6ATQhHkvA0kD0GI2uB
         YZPG89j5vsC30OB4FOHOdTvctL9XS3vcl+6ac2Q5CLngv/X+rdChEzwsJo0rUKZzK7CK
         9RAkCf+ChBNBla98CuSweMLocoOV0Ont/FiOhAOv4F8+ouUirJgO3YNFJ3DGKA8JV01R
         BS0Q==
X-Gm-Message-State: AOAM530764lBIZc9EdC7VjNArl2+3Coy5+xX7ZcaRDymHYAQhqV5bhSD
        k5lu5bfJ/gJzb9CDjOEsF08l3ai5XQ==
X-Google-Smtp-Source: ABdhPJwhBCyiHrz/+IMDKbZ52GDgcHe+j5akrd2gdlCfhjevzWrep4IKiEZ8xF0Uw2rMa5in+uH4gw5rKg==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a17:906:c792:: with SMTP id
 cw18mr12340246ejb.285.1598529002516; Thu, 27 Aug 2020 04:50:02 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:31 +0200
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
Message-Id: <20200827114932.3572699-7-jannh@google.com>
Mime-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 6/7] mm/gup: Take mmap_lock in get_dump_page()
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

