Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338CD40B70B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 20:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhINSjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhINSi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:38:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE6C061574;
        Tue, 14 Sep 2021 11:37:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso2905266pjh.5;
        Tue, 14 Sep 2021 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QEr/go/GTpU7Rjfc4KC/IEXZ29vumfEE1Xw4ha+DtA=;
        b=hGIOmUo0dI9QRjWTNJ0++NGUaLs7m410h6aj1jfFYUwSQIndsHJqOG2IEB3U0jZQ2y
         BtZ0bX3w+jdCOyP48P8fz6pcr3NjeIHEtlBCKABnjmU/lgYMEUH3qLrFfjUkzxgUJlDj
         q5zHi1TzMoWGOypCtlMzg3XmIJyzsQijTr6p8/meHv0tbpENrRiI2A8msEQXD//mbS+w
         /RkZOqIjTJOb6UIidmw/CTSDIZ+sZUJkBzVSxjAT6yXIbzY4uVwsolmU5i4qu3NlDtpP
         MXJuRRMAFJsQ6pNyeMpOaD1js3/O6dLMRGsaXuUgCHShkLnuYZj+Fbxr+fkRofNwucUJ
         qzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QEr/go/GTpU7Rjfc4KC/IEXZ29vumfEE1Xw4ha+DtA=;
        b=gQXBnGnuS7SGLYqa+J/6kjsUUakhy+b7ZmN6XtJAzgqTmlum4JQ9NJT7yXLsLEdlsL
         LSR60/j671AdRHmloAbPsz1d8craShOp3qk7f1tBIrMc9OcwVLKXHdaaEomxt4MpIPGv
         rnN1dHi9wDOzKdTdWUwX1LkaHzRFwb2XnOwJM2oME4VTfcynPNgqUH+ly6biqxP+W/x7
         WdwxYUhsVkgVas+8NzJSY8WMj4xPiti++fX4Q1tUF2U1ldp59EeRfcQqZw4zhKRorJNp
         GnoyK868z6yQKKa9bfBFjlZz9872en3ofrTKoewo0TuCXTL5Roo8CCW0F1osnl0iHzbJ
         KWRg==
X-Gm-Message-State: AOAM530nvEI1yanVSalGR6CSFwUK6yRtQIy5zgEUSquFynfWkhRmCeEd
        4JkTui992s0BkFw64ekJmSw=
X-Google-Smtp-Source: ABdhPJwLHyNOLnJIL5N7uW7LsNkxaZra7i3+ERtT/jDHWXVzQaxvTyMOQaAc7gHhlP+YS/zE7S1ZQA==
X-Received: by 2002:a17:90a:1991:: with SMTP id 17mr3646240pji.149.1631644659271;
        Tue, 14 Sep 2021 11:37:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y3sm12003965pge.44.2021.09.14.11.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:37:38 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm: hwpoison: handle non-anonymous THP correctly
Date:   Tue, 14 Sep 2021 11:37:18 -0700
Message-Id: <20210914183718.4236-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210914183718.4236-1-shy828301@gmail.com>
References: <20210914183718.4236-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently hwpoison doesn't handle non-anonymous THP, but since v4.8 THP
support for tmpfs and read-only file cache has been added.  They could
be offlined by split THP, just like anonymous THP.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3e06cb9d5121..6f72aab8ec4a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1150,13 +1150,16 @@ static int __get_hwpoison_page(struct page *page)
 
 	if (PageTransHuge(head)) {
 		/*
-		 * Non anonymous thp exists only in allocation/free time. We
-		 * can't handle such a case correctly, so let's give it up.
-		 * This should be better than triggering BUG_ON when kernel
-		 * tries to touch the "partially handled" page.
+		 * We can't handle allocating or freeing THPs, so let's give
+		 * it up. This should be better than triggering BUG_ON when
+		 * kernel tries to touch the "partially handled" page.
+		 *
+		 * page->mapping won't be initialized until the page is added
+		 * to rmap or page cache.  Use this as an indicator for if
+		 * this is an instantiated page.
 		 */
-		if (!PageAnon(head)) {
-			pr_err("Memory failure: %#lx: non anonymous thp\n",
+		if (!head->mapping) {
+			pr_err("Memory failure: %#lx: non instantiated thp\n",
 				page_to_pfn(page));
 			return 0;
 		}
@@ -1415,12 +1418,12 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 static int try_to_split_thp_page(struct page *page, const char *msg)
 {
 	lock_page(page);
-	if (!PageAnon(page) || unlikely(split_huge_page(page))) {
+	if (!page->mapping || unlikely(split_huge_page(page))) {
 		unsigned long pfn = page_to_pfn(page);
 
 		unlock_page(page);
-		if (!PageAnon(page))
-			pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
+		if (!page->mapping)
+			pr_info("%s: %#lx: not instantiated thp\n", msg, pfn);
 		else
 			pr_info("%s: %#lx: thp split failed\n", msg, pfn);
 		put_page(page);
-- 
2.26.2

