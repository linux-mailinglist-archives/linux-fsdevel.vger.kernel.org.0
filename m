Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31FD41E386
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 23:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344670AbhI3VzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbhI3VzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:55:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB05C06176D;
        Thu, 30 Sep 2021 14:53:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x4so4978845pln.5;
        Thu, 30 Sep 2021 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+26h9Sv4vHl46H8SxokcbKyYQ9NxeiIl/SfRJf9HZw=;
        b=Djy5drgdl22dEGglF63rH52PgcXQfNUhldeQ/QMjK3qtlY3T3LP8KFviIAyUTa7lIF
         VEt3AVn6B+Y6pQXf05pOz0Pk5lO3P9ci2211v0ZL1MbGqx7KYy+atFaNVOMoeYjF1rX7
         Wv/UDjijd/gUekQXIZFlG1aBcZsPwVrfBf2CR1NyT8Ffb1y0gaebBTgkXyyci0Zpl0qw
         7LmYoCC6768fKFYG3j7c3vOWUXobYSzp4jsTjWk8wLZ8Z1bQxJ0CSUiOJrDFHAfdInBp
         NcQ7FAnpmTmEw6sCeWCVx4Tx+BOVWhyfDvtqiKvTUwlkc/nBDfySTuLEfakDVcQ4hmfB
         bWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+26h9Sv4vHl46H8SxokcbKyYQ9NxeiIl/SfRJf9HZw=;
        b=qZ9Y+kMpRy3cbwkZ/ThwBe5bkVwijaH/rh0IdFDvlSDhwDSLUhUTzJxqjWD1V8ppn4
         JsrrmLJznNHzOaRuRnMYai9tbIP3UVERLxYoHMb8FBhsJt5GkEkykCH3P3UhU3UE8XeJ
         /sn2lfs3DNbYh4ggwFYxZzpE1V6WdwYSVoGeJJdpIk9TqBfxx9qJsdZHC2kaHqa3rR6q
         LU1nUN3sY3f3OwfM9KLlJveczY7MtFLCcEcvlonqMPXPBkDX+6XHu9SnTOXrRZyMp5P3
         AR0QYqr0arXDAt066RB7mr5ey7CjLvkjKsh+7i2u+y8V+/icVEjzSrNqpSWjUoyij/am
         5nGA==
X-Gm-Message-State: AOAM533y+SzVWfqnGcgG2eBrPnWZUWTdKQAhzLIot2ECzvyqa9x8g6Hi
        hovUSkhoTrexqPPVkMr1gFE=
X-Google-Smtp-Source: ABdhPJxmGL0nQKDZ15pCq04wQt05mZnD3pmd18L/LfPhVGMA+5VddqOZo4soEdXmWx6MUCZuuPL9iQ==
X-Received: by 2002:a17:902:8495:b0:13e:6a01:f5fb with SMTP id c21-20020a170902849500b0013e6a01f5fbmr5810851plo.61.1633038804435;
        Thu, 30 Sep 2021 14:53:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id p17sm5647535pjg.54.2021.09.30.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 14:53:23 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 4/5] mm: shmem: don't truncate page if memory failure happens
Date:   Thu, 30 Sep 2021 14:53:10 -0700
Message-Id: <20210930215311.240774-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210930215311.240774-1-shy828301@gmail.com>
References: <20210930215311.240774-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current behavior of memory failure is to truncate the page cache
regardless of dirty or clean.  If the page is dirty the later access
will get the obsolete data from disk without any notification to the
users.  This may cause silent data loss.  It is even worse for shmem
since shmem is in-memory filesystem, truncating page cache means
discarding data blocks.  The later read would return all zero.

The right approach is to keep the corrupted page in page cache, any
later access would return error for syscalls or SIGBUS for page fault,
until the file is truncated, hole punched or removed.  The regular
storage backed filesystems would be more complicated so this patch
is focused on shmem.  This also unblock the support for soft
offlining shmem THP.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 10 +++++++++-
 mm/shmem.c          | 31 +++++++++++++++++++++++++++++--
 mm/userfaultfd.c    |  5 +++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 562bcf335bd2..176883cd080f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -57,6 +57,7 @@
 #include <linux/ratelimit.h>
 #include <linux/page-isolation.h>
 #include <linux/pagewalk.h>
+#include <linux/shmem_fs.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -866,6 +867,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 {
 	int ret;
 	struct address_space *mapping;
+	bool dec;
 
 	delete_from_lru_cache(p);
 
@@ -894,6 +896,12 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 		goto out;
 	}
 
+	/*
+	 * The shmem page is kept in page cache instead of truncating
+	 * so need decrement the refcount from page cache.
+	 */
+	dec = shmem_mapping(mapping);
+
 	/*
 	 * Truncation is a bit tricky. Enable it per file system for now.
 	 *
@@ -903,7 +911,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 out:
 	unlock_page(p);
 
-	if (has_extra_refcount(ps, p, false))
+	if (has_extra_refcount(ps, p, dec))
 		ret = MF_FAILED;
 
 	return ret;
diff --git a/mm/shmem.c b/mm/shmem.c
index 88742953532c..75c36b6a405a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
+	int ret = 0;
 
 	/* i_rwsem is held by caller */
 	if (unlikely(info->seals & (F_SEAL_GROW |
@@ -2466,7 +2467,17 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
-	return shmem_getpage(inode, index, pagep, SGP_WRITE);
+	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
+
+	if (*pagep) {
+		if (PageHWPoison(*pagep)) {
+			unlock_page(*pagep);
+			put_page(*pagep);
+			ret = -EIO;
+		}
+	}
+
+	return ret;
 }
 
 static int
@@ -2555,6 +2566,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			unlock_page(page);
 		}
 
+		if (page && PageHWPoison(page)) {
+			error = -EIO;
+			break;
+		}
+
 		/*
 		 * We must evaluate after, since reads (unlike writes)
 		 * are called without i_rwsem protection against truncate
@@ -3772,6 +3788,13 @@ static void shmem_destroy_inodecache(void)
 	kmem_cache_destroy(shmem_inode_cachep);
 }
 
+/* Keep the page in page cache instead of truncating it */
+static int shmem_error_remove_page(struct address_space *mapping,
+				   struct page *page)
+{
+	return 0;
+}
+
 const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.set_page_dirty	= __set_page_dirty_no_writeback,
@@ -3782,7 +3805,7 @@ const struct address_space_operations shmem_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_page = shmem_error_remove_page,
 };
 EXPORT_SYMBOL(shmem_aops);
 
@@ -4193,6 +4216,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 		page = ERR_PTR(error);
 	else
 		unlock_page(page);
+
+	if (PageHWPoison(page))
+		page = ERR_PTR(-EIO);
+
 	return page;
 #else
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7a9008415534..b688d5327177 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -233,6 +233,11 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
 		goto out;
 	}
 
+	if (PageHWPoison(page)) {
+		ret = -EIO;
+		goto out_release;
+	}
+
 	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
 				       page, false, wp_copy);
 	if (ret)
-- 
2.26.2

