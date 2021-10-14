Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38BE42E1EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 21:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhJNTSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 15:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhJNTSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:18:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C487C061753;
        Thu, 14 Oct 2021 12:16:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso5514455pjb.1;
        Thu, 14 Oct 2021 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3w2W8bf8fjDmVl/a2MTya23w6Ml3a37fmUhHSxCWSw=;
        b=RN8XOpaKozLpSRy62DfljKxSu4xgRL4YHek5rUXyRHn42zeCBPjwrsm9JhrNHhl7x9
         FtFHvs1XnE+gZB/WLoBaq/AOu5FDm2KMfT1vJ1fnLZ+07bO3MtuHGVaeeo0tYkKvJ+xu
         H2Jmq7qQwbwev/P3Zlyk4jHi6hWqxHz2VDjbbn6s/RsCL0m6IGlzTcYeR/VUKKn7mTK/
         iDeA/Zs8AryWYJgGDdSMeG9wnqdAAkHvToH0f1k2+fR7MlT11ogBj2MNxmPRAfYBSjWc
         whyUyi8YgRvW2hWzE0lDx+GQ9qqjrjY/OiIkBvWftAAn2XgYhsstEez3gpw8uoUzyih1
         B2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3w2W8bf8fjDmVl/a2MTya23w6Ml3a37fmUhHSxCWSw=;
        b=QPcixEoWRfRQaeyjUv11/nkwwWJNsKl9pbI3piLn+Ls+ZTXkHPS1D/6g+BW0OUx3kT
         GGSKzIKer9J7d6uugva40VO9TiC2031OMe2ZKwvp7QSz6WBMDprv1EmAd2NcNG0kbbKp
         hvr7y+0lh4zsLDuZX5bGvmdor61h6Kt4vOdOoqBpLziJM3QhqT0bT0GIwC1HpLb6Tehr
         bNpQcmzBDp4Y5T0x0Sv2Y6b92xQoRsWaRdP+dwHiDE+U6QQAZGvqchk/imgfohcB9zlE
         5F3QEYfHTUiPoXn7qac/kHwhcPrxM2W6SpwqRIF3IwojXZEZqRY/lTHDczoliJ0TV9jc
         YW3w==
X-Gm-Message-State: AOAM532+clW+3ifCEgNyyjekWPZZFtbhtpYD9nCSusijWxkve4d3dwQS
        kQse9s+HEcfF4EFrWc5IW+c=
X-Google-Smtp-Source: ABdhPJzyYUg+gMPtvrV9ydY5GePka1BMotVN1zD+rEHkSnivupp6VjU8VlqL5uvi+6a727k3NtNjhQ==
X-Received: by 2002:a17:90b:3ecc:: with SMTP id rm12mr8233928pjb.48.1634238992599;
        Thu, 14 Oct 2021 12:16:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x129sm3253922pfc.140.2021.10.14.12.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:16:31 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 5/6] mm: shmem: don't truncate page if memory failure happens
Date:   Thu, 14 Oct 2021 12:16:14 -0700
Message-Id: <20211014191615.6674-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211014191615.6674-1-shy828301@gmail.com>
References: <20211014191615.6674-1-shy828301@gmail.com>
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
 mm/shmem.c          | 37 ++++++++++++++++++++++++++++++++++---
 mm/userfaultfd.c    |  5 +++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index cdf8ccd0865f..f5eab593b2a7 100644
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
index b5860f4a2738..69eaf65409e6 100644
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
@@ -2555,6 +2564,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -3114,7 +3128,8 @@ static const char *shmem_get_link(struct dentry *dentry,
 		page = find_get_page(inode->i_mapping, 0);
 		if (!page)
 			return ERR_PTR(-ECHILD);
-		if (!PageUptodate(page)) {
+		if (PageHWPoison(page) ||
+		    !PageUptodate(page)) {
 			put_page(page);
 			return ERR_PTR(-ECHILD);
 		}
@@ -3122,6 +3137,11 @@ static const char *shmem_get_link(struct dentry *dentry,
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
@@ -3772,6 +3792,13 @@ static void shmem_destroy_inodecache(void)
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
@@ -3782,7 +3809,7 @@ const struct address_space_operations shmem_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_page = shmem_error_remove_page,
 };
 EXPORT_SYMBOL(shmem_aops);
 
@@ -4193,6 +4220,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
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

