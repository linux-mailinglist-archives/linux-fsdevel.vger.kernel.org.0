Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8E8247E55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHRGNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 02:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHRGNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:13:06 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98357C061344
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 23:13:05 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 1so12421996qki.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uEsosFURBjONd+/+zLGkVplNTPfQUMPsbnxJn8l+5vc=;
        b=ZwNZMdOmDrLPGKWoU7+xUPQWuT5oFIHuub4ejn1ekJsju5Wwy4BLyJBNVFY7s7BOld
         z3j7VbHfP0i4lVA1JENTx0vcSL03Ivy7dRS9ixIgK6o9EnEGMJMVSN27CQhbCwLUUGja
         g2kOE4ob+pHuuCV3lxWoW781kDluCgRGWDnAPhZxeaR/O94K6cNgRXgdK/AQ0tq08LM/
         HTnNGkc2Hr1LW06qlLL1igs/cd0cIwr/k5am8Yq+ZUlq2W/bZqQPuN/yvos43bmZzKui
         vGmfTNebqL+H4H3PJeXssHpUinSJ181aWS1QvdMT+BzOZLkJTgY+MgaAplPmApsiySYe
         alww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uEsosFURBjONd+/+zLGkVplNTPfQUMPsbnxJn8l+5vc=;
        b=uHL9PtYtNGb4/3QwHxEdgANHyF2GNhMaSxiqQ0Z7gv8DrwlHYCTwfeJzHHV6S6sqQ3
         eucpoElu5qoS6c94tFYzYHSwUVRF/HEpezczzao5VR1PFciIX7FgDrm/YO8g8WpA84kF
         XJT92tiT05qosRlneJGpe4Wyac0FY+qC6I0RNvH/0XjrwCONB8A5lFzudq9lomHrL2R3
         hX4PPk1iQ6Eexr8M5uAHHrkkD6TU02S/OXTMm3C3WAG/Qmuy8sBklldSwYO1NBZmDt3H
         Y93/RWBvl606ECO3s2hAqBN+7+EuyWo/y+lSbB9iy5ema8pHGncVqwkLrNQemOBr2CiC
         t35w==
X-Gm-Message-State: AOAM533OBuO7D6LFboeHCZLt6WgxiAyp57jM8BnvDHcsrzC7M66MaDW9
        eToS31N07kU45zFuj+hh6hzvsfmX7Q==
X-Google-Smtp-Source: ABdhPJxP3VNaCKztfKGOZRUkeGpGigQsg+G3JDfTvOzuksmwqiQeamW72iYG3Jd8rw3YImyyUmlMeGtIjQ==
X-Received: by 2002:ad4:40cb:: with SMTP id x11mr18084057qvp.176.1597731184753;
 Mon, 17 Aug 2020 23:13:04 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:12:39 +0200
In-Reply-To: <20200818061239.29091-1-jannh@google.com>
Message-Id: <20200818061239.29091-6-jannh@google.com>
Mime-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 5/5] mm/gup: Take mmap_lock in get_dump_page()
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
2.28.0.220.ged08abb693-goog

