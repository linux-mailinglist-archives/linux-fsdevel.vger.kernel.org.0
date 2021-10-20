Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4623F4354F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhJTVK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbhJTVKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:10:22 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81881C061749;
        Wed, 20 Oct 2021 14:08:07 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q187so228678pgq.2;
        Wed, 20 Oct 2021 14:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7O2jemVYe0cdkuCpXRsCTx09Gh0RPAfbpmg1m/i8Imk=;
        b=qgzRo9cTGlk9YDJCuVhg/rOQ5tvo0oepgrPcqRlLrzwGEWDG6hhjkZLkWaUTYecWUc
         zGovGv89xq6siwFDIUH15dWBH+vR+yF4x1Dc5jaz1XiB9sd4yQWCHzeRZnGufQoLQuDL
         gDemw7tufwdXcaSChFSOLqVciBnLUdVHRiGWTN8LPdYreag6ewu8x2MJPK/23VRRinqc
         5OFeLyB6NedfZxrmsfUJdJUBAbQZOUPfqhtccwifaoI0nxR11YYCZeraWxNTT8cPj3SS
         /szKISBseE64pjUWFPgcPAS5LkLtbM8kpD1O4lC4iOCKO4iQFHuGzZBWr00o7oFSRqfZ
         quZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7O2jemVYe0cdkuCpXRsCTx09Gh0RPAfbpmg1m/i8Imk=;
        b=AihENtuG7Sjk9oD3UuGE4jDt75fuOLXtaUScfpZzUfVB77ClEg7+Td9ntj3FHvFssR
         F3Wh5xCvVAO2ph0QpeBa8IOiLX5DThVf3fqEzoZ72vdCjKsuT3cS2TeBgH9Ob4UCX0oP
         k9lY+Gc+MNaVCKKPPbNrSqLLuE+nLZjnxkbBXVHLIMEM7ZIHotaqjU0qc4XPf/VOALFx
         BvC7IRvE4bvhz4jMB11tLq8I2/E4lZEfMTWe06VDTWlQ5KO1haU4qEfBIIUyKMEBmqJo
         qt8QswjQvCkLqt64/zh97jRqPLB2sk6RMc0tUsTlHAA1Wod6DGLMS+D+sG6e3OYcZGWK
         +ogA==
X-Gm-Message-State: AOAM532OAVX1lwZu9EOa0O2sOFzCHRbzPQztWXPOuU34QENVhmLn0lxg
        goqo3t21aPMOUEFm2jGjk8Y=
X-Google-Smtp-Source: ABdhPJxUCPR5Kgu+vcT+c3DRMEm0+BInCFJ2AU660nrM2JGkEjwBBrdIw+EBYmJIvla9nLs9G1EjNw==
X-Received: by 2002:a63:e216:: with SMTP id q22mr1218827pgh.3.1634764086956;
        Wed, 20 Oct 2021 14:08:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id i8sm3403143pfo.117.2021.10.20.14.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:08:05 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 4/6] mm: hwpoison: refactor refcount check handling
Date:   Wed, 20 Oct 2021 14:07:53 -0700
Message-Id: <20211020210755.23964-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211020210755.23964-1-shy828301@gmail.com>
References: <20211020210755.23964-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Memory failure will report failure if the page still has extra pinned
refcount other than from hwpoison after the handler is done.  Actually
the check is not necessary for all handlers, so move the check into
specific handlers.  This would make the following keeping shmem page in
page cache patch easier.

There may be expected extra pin for some cases, for example, when the
page is dirty and in swapcache.

Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 93 +++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bdbbb32211a5..aaeda93d26fb 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -806,12 +806,44 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
 	return ret;
 }
 
+struct page_state {
+	unsigned long mask;
+	unsigned long res;
+	enum mf_action_page_type type;
+
+	/* Callback ->action() has to unlock the relevant page inside it. */
+	int (*action)(struct page_state *ps, struct page *p);
+};
+
+/*
+ * Return true if page is still referenced by others, otherwise return
+ * false.
+ *
+ * The extra_pins is true when one extra refcount is expected.
+ */
+static bool has_extra_refcount(struct page_state *ps, struct page *p,
+			       bool extra_pins)
+{
+	int count = page_count(p) - 1;
+
+	if (extra_pins)
+		count -= 1;
+
+	if (count > 0) {
+		pr_err("Memory failure: %#lx: %s still referenced by %d users\n",
+		       page_to_pfn(p), action_page_types[ps->type], count);
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Error hit kernel page.
  * Do nothing, try to be lucky and not touch this instead. For a few cases we
  * could be more sophisticated.
  */
-static int me_kernel(struct page *p, unsigned long pfn)
+static int me_kernel(struct page_state *ps, struct page *p)
 {
 	unlock_page(p);
 	return MF_IGNORED;
@@ -820,9 +852,9 @@ static int me_kernel(struct page *p, unsigned long pfn)
 /*
  * Page in unknown state. Do nothing.
  */
-static int me_unknown(struct page *p, unsigned long pfn)
+static int me_unknown(struct page_state *ps, struct page *p)
 {
-	pr_err("Memory failure: %#lx: Unknown page state\n", pfn);
+	pr_err("Memory failure: %#lx: Unknown page state\n", page_to_pfn(p));
 	unlock_page(p);
 	return MF_FAILED;
 }
@@ -830,7 +862,7 @@ static int me_unknown(struct page *p, unsigned long pfn)
 /*
  * Clean (or cleaned) page cache page.
  */
-static int me_pagecache_clean(struct page *p, unsigned long pfn)
+static int me_pagecache_clean(struct page_state *ps, struct page *p)
 {
 	int ret;
 	struct address_space *mapping;
@@ -867,9 +899,13 @@ static int me_pagecache_clean(struct page *p, unsigned long pfn)
 	 *
 	 * Open: to take i_rwsem or not for this? Right now we don't.
 	 */
-	ret = truncate_error_page(p, pfn, mapping);
+	ret = truncate_error_page(p, page_to_pfn(p), mapping);
 out:
 	unlock_page(p);
+
+	if (has_extra_refcount(ps, p, false))
+		ret = MF_FAILED;
+
 	return ret;
 }
 
@@ -878,7 +914,7 @@ static int me_pagecache_clean(struct page *p, unsigned long pfn)
  * Issues: when the error hit a hole page the error is not properly
  * propagated.
  */
-static int me_pagecache_dirty(struct page *p, unsigned long pfn)
+static int me_pagecache_dirty(struct page_state *ps, struct page *p)
 {
 	struct address_space *mapping = page_mapping(p);
 
@@ -922,7 +958,7 @@ static int me_pagecache_dirty(struct page *p, unsigned long pfn)
 		mapping_set_error(mapping, -EIO);
 	}
 
-	return me_pagecache_clean(p, pfn);
+	return me_pagecache_clean(ps, p);
 }
 
 /*
@@ -944,9 +980,10 @@ static int me_pagecache_dirty(struct page *p, unsigned long pfn)
  * Clean swap cache pages can be directly isolated. A later page fault will
  * bring in the known good data from disk.
  */
-static int me_swapcache_dirty(struct page *p, unsigned long pfn)
+static int me_swapcache_dirty(struct page_state *ps, struct page *p)
 {
 	int ret;
+	bool extra_pins = false;
 
 	ClearPageDirty(p);
 	/* Trigger EIO in shmem: */
@@ -954,10 +991,17 @@ static int me_swapcache_dirty(struct page *p, unsigned long pfn)
 
 	ret = delete_from_lru_cache(p) ? MF_FAILED : MF_DELAYED;
 	unlock_page(p);
+
+	if (ret == MF_DELAYED)
+		extra_pins = true;
+
+	if (has_extra_refcount(ps, p, extra_pins))
+		ret = MF_FAILED;
+
 	return ret;
 }
 
-static int me_swapcache_clean(struct page *p, unsigned long pfn)
+static int me_swapcache_clean(struct page_state *ps, struct page *p)
 {
 	int ret;
 
@@ -965,6 +1009,10 @@ static int me_swapcache_clean(struct page *p, unsigned long pfn)
 
 	ret = delete_from_lru_cache(p) ? MF_FAILED : MF_RECOVERED;
 	unlock_page(p);
+
+	if (has_extra_refcount(ps, p, false))
+		ret = MF_FAILED;
+
 	return ret;
 }
 
@@ -974,7 +1022,7 @@ static int me_swapcache_clean(struct page *p, unsigned long pfn)
  * - Error on hugepage is contained in hugepage unit (not in raw page unit.)
  *   To narrow down kill region to one page, we need to break up pmd.
  */
-static int me_huge_page(struct page *p, unsigned long pfn)
+static int me_huge_page(struct page_state *ps, struct page *p)
 {
 	int res;
 	struct page *hpage = compound_head(p);
@@ -985,7 +1033,7 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 
 	mapping = page_mapping(hpage);
 	if (mapping) {
-		res = truncate_error_page(hpage, pfn, mapping);
+		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
 		unlock_page(hpage);
 	} else {
 		res = MF_FAILED;
@@ -1003,6 +1051,9 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 		}
 	}
 
+	if (has_extra_refcount(ps, p, false))
+		res = MF_FAILED;
+
 	return res;
 }
 
@@ -1028,14 +1079,7 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 #define slab		(1UL << PG_slab)
 #define reserved	(1UL << PG_reserved)
 
-static struct page_state {
-	unsigned long mask;
-	unsigned long res;
-	enum mf_action_page_type type;
-
-	/* Callback ->action() has to unlock the relevant page inside it. */
-	int (*action)(struct page *p, unsigned long pfn);
-} error_states[] = {
+static struct page_state error_states[] = {
 	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },
 	/*
 	 * free pages are specially detected outside this table:
@@ -1095,19 +1139,10 @@ static int page_action(struct page_state *ps, struct page *p,
 			unsigned long pfn)
 {
 	int result;
-	int count;
 
 	/* page p should be unlocked after returning from ps->action().  */
-	result = ps->action(p, pfn);
+	result = ps->action(ps, p);
 
-	count = page_count(p) - 1;
-	if (ps->action == me_swapcache_dirty && result == MF_DELAYED)
-		count--;
-	if (count > 0) {
-		pr_err("Memory failure: %#lx: %s still referenced by %d users\n",
-		       pfn, action_page_types[ps->type], count);
-		result = MF_FAILED;
-	}
 	action_result(pfn, ps->type, result);
 
 	/* Could do more checks here if page looks ok */
-- 
2.26.2

