Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CBE40B709
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhINSi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhINSiz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:38:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE03C061574;
        Tue, 14 Sep 2021 11:37:37 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q68so29413pga.9;
        Tue, 14 Sep 2021 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9w1AJqNMCNIhFQPh+gH1tqRIw8tAS1H2alD3h2KH4Tg=;
        b=oRAhLcrLE1KArfHiZtQaKminXxHF840kk+E0maovq8zjG3QXSlhDRsv+IIvNS3f2IZ
         uh+mjaJolNp5iBSA2yQ02eKiMLlMLFGsXavyXNlZK2p6LAvoLs6KIYhlwVCfghAeaAbV
         +/kImpPmCqR95zWyPEvKBZVRBx8/VaTtgvZSTryBf4nr3/t/fL0j5DK2VIoQWyXMu3YZ
         OoBplmeZYginHwX2+luO+/ApvHdpmPCJuzGaUoRzov+C4blw3B6FCYVUV/8t43spurG5
         8fUKSCJOMZ90yQpCxgCiMCEWM0jkumNjvJWyH3g1SIyzf5WTz0lyXs5JTXha8687MDtK
         /+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9w1AJqNMCNIhFQPh+gH1tqRIw8tAS1H2alD3h2KH4Tg=;
        b=WP/LoP35iD8ByBurBqZ8k83DKJVtkLIK/E8dRQHs6ASizoMnyx3aI7IAid1dDNmJP9
         bEtZfucVZ2JJTx6FvgBncSGx5mYaGOPSRxFbZRGfzcZM3XMVnGY41YDh+zL5MLZoHiic
         a36CTaZmTw4aJD+TZGFkftc/u0E1voMRDY4fuBHUYjWZb2vZdL5p+7rZpnfe0xmuZXM8
         C720GfUe9um29okkFYxCtZQoNlqoYh8jMktGzHvsVxHLgZJyS9JHSiZsGq+6/AGfKmRO
         dkFidS/6ArPG4Q2zwwymbHflKGkKcqH8oAPRUgUIHcT+U+Bwlb7PkkL+BYhLPS6TL+Yg
         gCsg==
X-Gm-Message-State: AOAM532qWdwuVVsV3cg5LhjjMXTRIVqwgaThpDsugwowEpBeIs2LcjD7
        S/vS/rpjFKVlF1gh3md1c/k=
X-Google-Smtp-Source: ABdhPJzRie1QwXC8O0LrqqqozMmN656c59ZLcc2IjJ2ZadEETUI1oV5G1qGPgR0/qVKQhYJhTwjVtA==
X-Received: by 2002:a63:62c7:: with SMTP id w190mr16518815pgb.105.1631644657522;
        Tue, 14 Sep 2021 11:37:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y3sm12003965pge.44.2021.09.14.11.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:37:36 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm: shmem: don't truncate page if memory failure happens
Date:   Tue, 14 Sep 2021 11:37:17 -0700
Message-Id: <20210914183718.4236-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210914183718.4236-1-shy828301@gmail.com>
References: <20210914183718.4236-1-shy828301@gmail.com>
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
 mm/memory-failure.c |  3 ++-
 mm/shmem.c          | 25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 54879c339024..3e06cb9d5121 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1101,7 +1101,8 @@ static int page_action(struct page_state *ps, struct page *p,
 	result = ps->action(p, pfn);
 
 	count = page_count(p) - 1;
-	if (ps->action == me_swapcache_dirty && result == MF_DELAYED)
+	if ((ps->action == me_swapcache_dirty && result == MF_DELAYED) ||
+	    (ps->action == me_pagecache_dirty && result == MF_FAILED))
 		count--;
 	if (count > 0) {
 		pr_err("Memory failure: %#lx: %s still referenced by %d users\n",
diff --git a/mm/shmem.c b/mm/shmem.c
index 88742953532c..ec33f4f7173d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
+	int ret = 0;
 
 	/* i_rwsem is held by caller */
 	if (unlikely(info->seals & (F_SEAL_GROW |
@@ -2466,7 +2467,19 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
-	return shmem_getpage(inode, index, pagep, SGP_WRITE);
+	ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
+
+	if (!ret) {
+		if (*pagep) {
+			if (PageHWPoison(*pagep)) {
+				unlock_page(*pagep);
+				put_page(*pagep);
+				ret = -EIO;
+			}
+		}
+	}
+
+	return ret;
 }
 
 static int
@@ -2555,6 +2568,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -3782,7 +3800,6 @@ const struct address_space_operations shmem_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif
-	.error_remove_page = generic_error_remove_page,
 };
 EXPORT_SYMBOL(shmem_aops);
 
@@ -4193,6 +4210,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 		page = ERR_PTR(error);
 	else
 		unlock_page(page);
+
+	if (PageHWPoison(page))
+		page = NULL;
+
 	return page;
 #else
 	/*
-- 
2.26.2

