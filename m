Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28CA415602
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 05:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbhIWDaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 23:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbhIWDaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:30:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A287CC061756;
        Wed, 22 Sep 2021 20:28:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v19so3504010pjh.2;
        Wed, 22 Sep 2021 20:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqxrYRf/N3vvtTE2Bz0uDuFcXVTGzI9mHH/dOg3YkWg=;
        b=dGu8PwVvBH2tEtOY8PXE8lKZUxvymybflTtF1d3dMa57rTCzQSTRFkSN+VklTDczBj
         QoU7RTmWuZzc0jTgz5x9fdNtFz+cFpixSUSfvDxiOBxUisFI7+IT1msPD5maJj8YXI9a
         1CEWXtK6xK2ASKrbjM6xHNF5d+vgfHlHALxBR/KK9+VcJIAcHlEAQhQ6TOvPotK6tfJ4
         bPSU6J/4MG57+rNCnNpe4WaIcpDJjqgPxLOcKry2k7emhjW4rC/CIAQS6+jmzXTT7mRF
         YPhmDJzBbblOVvkzGwwO4kbqGQCDuhYn9VyuWJp+tcrP5zoZVfDzihRTPsF1cl11bAYO
         sndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqxrYRf/N3vvtTE2Bz0uDuFcXVTGzI9mHH/dOg3YkWg=;
        b=V78DiT8i8lnRMSW7hc3SYxApNy56ULyqfoYDOOR7WO136JSw0UFBGGZMWd9uwDEPXs
         A9U677ILg+MwY3KsYWU9OiC+hbxQmNgtUrOGZq5tKml0UjO9lIV8In6REfYpyAmNefM0
         jRhZ7jQg5QgJkM7JowtRk+hptCXx/9WNVmN1XShThZclag76KZUTWfk9lFyy9JTaauJ9
         Gv36XHtHlZZl4+IY/aWkPeJqJczh0M5hCv0nQ0UM7Sd1WRggU1HVVhDNAcKomSSNy3Cx
         8toFbqD5VTKYaTKe+fAVrIGNLNmVapqm/q36SP6iSRD3TDsl24VI2PZFV3c15w6vJIUp
         t+qg==
X-Gm-Message-State: AOAM5320gdT0hGs4bspa+7Yc8pJixwVseT5hHlRkyPq9Uvx0LC1dPZ3o
        m9y9xzicxjCR8HAeSYxa2LQ=
X-Google-Smtp-Source: ABdhPJzFyDBbcHliT5kpE7JCZXWfoNQbHTNIGhMRQTD2/UO6KcYAlSsyRRi5O9njGGrE21cOcx6x6Q==
X-Received: by 2002:a17:902:c443:b0:13c:a5e1:caf5 with SMTP id m3-20020a170902c44300b0013ca5e1caf5mr1960864plm.11.1632367731118;
        Wed, 22 Sep 2021 20:28:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x8sm3699696pfq.131.2021.09.22.20.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 20:28:50 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/5] mm: hwpoison: refactor refcount check handling
Date:   Wed, 22 Sep 2021 20:28:27 -0700
Message-Id: <20210923032830.314328-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210923032830.314328-1-shy828301@gmail.com>
References: <20210923032830.314328-1-shy828301@gmail.com>
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

Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 93 +++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 93ae0ce90ab8..7722197b2b9d 100644
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
+ * The dec is true when one extra refcount is expected.
+ */
+static bool has_extra_refcount(struct page_state *ps, struct page *p,
+			       bool dec)
+{
+	int count = page_count(p) - 1;
+
+	if (dec)
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
+	bool dec = false;
 
 	ClearPageDirty(p);
 	/* Trigger EIO in shmem: */
@@ -954,10 +991,17 @@ static int me_swapcache_dirty(struct page *p, unsigned long pfn)
 
 	ret = delete_from_lru_cache(p) ? MF_FAILED : MF_DELAYED;
 	unlock_page(p);
+
+	if (ret == MF_DELAYED)
+		dec = true;
+
+	if (has_extra_refcount(ps, p, dec))
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

