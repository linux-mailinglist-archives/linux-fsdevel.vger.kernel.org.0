Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C964354F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 23:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhJTVKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhJTVK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:10:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA49C061768;
        Wed, 20 Oct 2021 14:08:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o133so4012196pfg.7;
        Wed, 20 Oct 2021 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhKiYV125XYYJ9Cqjf+na/y/uU4EzGqrjZFtLgGxOLI=;
        b=KVvaztXO6aH4dUV/+AVYfrJKBr310WbJPKg9aP4UAoKyLzbBAA/V7BUDpPoJ5DwVVU
         E9Oc2nXFJEBb0wptinixqkhTkDOHb07FUd6d3IlUMF452b9UX99n7SI9qdGBY8axem73
         wqOMbg2z1zxd6V3ZYyGWVz9+wmdFFCPM4uzHAkoJ61BUuhCMglMmPzU1U844W/HOpWIY
         xoQQmyPl4TF06WLj7dLCA+j4vjQfxIZwMVkefWJMF+b+0sIkum0uTampsUpxRGkpWNcn
         C7AA+kAtRq/w2wdfzY9FOf8WHxmqAJD7EV+eaSs1KlhfDETMqhPj0511Fr3LOWkW3eAu
         jxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhKiYV125XYYJ9Cqjf+na/y/uU4EzGqrjZFtLgGxOLI=;
        b=ZEzipGXrnGnY59P9vBtoQT1MFjbAY3ABtQb7ICUW6TWdkWN+CN4Ld1srTMVwNVWSDN
         kOv4YdKW7s9QC3+WGndmZlnyA1BG4wpVuNdRMckoxEoHT1bocjHQrfVi2Yz3I6AU0zA8
         +THvfgO+V4pKfixgFq79sj/Grmzs/Yp/4ALms6f8duYuVRaKDkSH+6BXiz44svXMTddP
         dKUN9KOigQf0dq3fx9ElUvA01+n5Oz/pIf2fTFj6tCIFZYsFo1HfABGVy7eQI8TkuYlQ
         lmI3ITxOzlbt7NG25Liu1Z+IIToZezGFO2my+fONupIlb3lVNRfBp+vfxPewdK/aVv9A
         EM7A==
X-Gm-Message-State: AOAM533MuKdRNJ6ph4hZaXksxhz6TktZUmBgy+1jcaG5tFfDgqM8jHAW
        IwyzJShRbhluePx0CYFScRI=
X-Google-Smtp-Source: ABdhPJzPAtb2hHvPGKVOLDaQI/51Q5nIlKC8rfpRs5WkHpv/lGnOr1rSdUFphUbHU0P0Pn6b3Qw3Ow==
X-Received: by 2002:a63:a744:: with SMTP id w4mr1242143pgo.456.1634764089146;
        Wed, 20 Oct 2021 14:08:09 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id i8sm3403143pfo.117.2021.10.20.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:08:08 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 5/6] mm: shmem: don't truncate page if memory failure happens
Date:   Wed, 20 Oct 2021 14:07:54 -0700
Message-Id: <20211020210755.23964-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211020210755.23964-1-shy828301@gmail.com>
References: <20211020210755.23964-1-shy828301@gmail.com>
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
 mm/shmem.c          | 38 +++++++++++++++++++++++++++++++++++---
 mm/userfaultfd.c    |  5 +++++
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index aaeda93d26fb..3603a3acf7b3 100644
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
+	bool extra_pins;
 
 	delete_from_lru_cache(p);
 
@@ -894,6 +896,12 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 		goto out;
 	}
 
+	/*
+	 * The shmem page is kept in page cache instead of truncating
+	 * so is expected to have an extra refcount after error-handling.
+	 */
+	extra_pins = shmem_mapping(mapping);
+
 	/*
 	 * Truncation is a bit tricky. Enable it per file system for now.
 	 *
@@ -903,7 +911,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 out:
 	unlock_page(p);
 
-	if (has_extra_refcount(ps, p, false))
+	if (has_extra_refcount(ps, p, extra_pins))
 		ret = MF_FAILED;
 
 	return ret;
diff --git a/mm/shmem.c b/mm/shmem.c
index b5860f4a2738..89062ce85db8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
+	int ret = 0;
 
 	/* i_rwsem is held by caller */
 	if (unlikely(info->seals & (F_SEAL_GROW |
@@ -2466,7 +2467,15 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
-	return shmem_getpage(inode, index, pagep, SGP_WRITE);
+	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
+
+	if (*pagep && PageHWPoison(*pagep)) {
+		unlock_page(*pagep);
+		put_page(*pagep);
+		ret = -EIO;
+	}
+
+	return ret;
 }
 
 static int
@@ -2553,6 +2562,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			if (sgp == SGP_CACHE)
 				set_page_dirty(page);
 			unlock_page(page);
+
+			if (PageHWPoison(page)) {
+				put_page(page);
+				error = -EIO;
+				break;
+			}
 		}
 
 		/*
@@ -3114,7 +3129,8 @@ static const char *shmem_get_link(struct dentry *dentry,
 		page = find_get_page(inode->i_mapping, 0);
 		if (!page)
 			return ERR_PTR(-ECHILD);
-		if (!PageUptodate(page)) {
+		if (PageHWPoison(page) ||
+		    !PageUptodate(page)) {
 			put_page(page);
 			return ERR_PTR(-ECHILD);
 		}
@@ -3122,6 +3138,11 @@ static const char *shmem_get_link(struct dentry *dentry,
 		error = shmem_getpage(inode, 0, &page, SGP_READ);
 		if (error)
 			return ERR_PTR(error);
+		if (page && PageHWPoison(page)) {
+			unlock_page(page);
+			put_page(page);
+			return ERR_PTR(-ECHILD);
+		}
 		unlock_page(page);
 	}
 	set_delayed_call(done, shmem_put_link, page);
@@ -3772,6 +3793,13 @@ static void shmem_destroy_inodecache(void)
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
@@ -3782,7 +3810,7 @@ const struct address_space_operations shmem_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_page = shmem_error_remove_page,
 };
 EXPORT_SYMBOL(shmem_aops);
 
@@ -4193,6 +4221,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
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

