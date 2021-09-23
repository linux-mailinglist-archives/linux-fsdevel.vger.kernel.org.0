Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23F415606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 05:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbhIWDae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 23:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbhIWDa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:30:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830F8C06175F;
        Wed, 22 Sep 2021 20:28:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id dw14so3511959pjb.1;
        Wed, 22 Sep 2021 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yW3mImt34w9s0m+L7odHrGN0UQd73DqRlDM0Drbnbq0=;
        b=jxB3fQZNu+GeaHBv00hPLH4J/m8FuWBxq/v04Bod2S2KuKkUeYinzZKA33aJn4nV/0
         wSt+t1hRMs/h4kDb+9mdTwyuRRAD+ygz6UwNDb2YVRNaVIX0xYPauFfjupDOR7BkF1ft
         KKUrkPnL5zraJ2V0rKFf66I7fpV3KmP0u1ugczPuK70DnBTch04TH8idfgu0H0KM4QtX
         OOo/60N9FmBIlyxtlRRCOoNk5Mb9CdO8Hypzjw5z4OtRuWxW325Z+o6MMw8GJlHUgbLo
         WGpkDum8DJo8Pq7ihgq3wrNBy8ecrS7b27IQt5VTbTA9SI+437QpdIbSoeNSoa9DPOjG
         paWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yW3mImt34w9s0m+L7odHrGN0UQd73DqRlDM0Drbnbq0=;
        b=zMlUWeisnLtAfdvOk98qBAlvKoGZ7niMkXCHvNHKRgwXw76rbGicCbymhVzHqGPNEu
         7LTzzVOl3YxNZhOPe2va41jVBvCC84jw8b+xd+ehLKvGQKmvggcdqgIgwdAakM3s9FZq
         3RTUDL90Zk5qLYsWOOz1BSHJG/Fq0eEihLv/SIlvdxTllOvMwut7o4Qfldoaw0Uo9aYS
         MkQyiRG8hE2TtkZ1y8P2VFFWcJ/9YuDGPefU+H6oyb47/8oe3ofSnsXhNjd9A5PL8m8j
         cM065WKbgqUMbtYQZ/PhAoRJeWWIKRdl6wm8zSpPclqcDsVtNuiEXcBo3gT6dV8k0yox
         5/lQ==
X-Gm-Message-State: AOAM5310/i6EI0fsWcVTagU7jDtkGi0CeLHmxHDycutUFec+6JS/2UGd
        EjHw8rUA6SRN+nRCrZUt5HWJTYaofs8cog==
X-Google-Smtp-Source: ABdhPJw+bMrYlauFtFJ2kCM+HSaD4khflzoqdmQXG7VkN29NFSCdbk7y1zN5PWRYVxXfxUjEZApT5A==
X-Received: by 2002:a17:90a:1a19:: with SMTP id 25mr15242818pjk.34.1632367735079;
        Wed, 22 Sep 2021 20:28:55 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x8sm3699696pfq.131.2021.09.22.20.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 20:28:54 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 4/5] mm: shmem: don't truncate page if memory failure happens
Date:   Wed, 22 Sep 2021 20:28:29 -0700
Message-Id: <20210923032830.314328-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210923032830.314328-1-shy828301@gmail.com>
References: <20210923032830.314328-1-shy828301@gmail.com>
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
index 5c7f1c2aabd9..3824bc708e55 100644
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

