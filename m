Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF26682783
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 00:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfHEWUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 18:20:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43225 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbfHEWUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:20:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id r26so4479715pgl.10;
        Mon, 05 Aug 2019 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iyBF/TunLLNE9m64WGZW5xnvl+XVp1Tkb/4cWK4Q28U=;
        b=fznpo+A/CwxRLIpM6ZFeQpQfbkwnXpV6MuOXxJtZ2Ve009RQdttmK51WGcum5QprYM
         AZQ7iviUpS0sDa6G1kPFVIds247iKuX80oSi8PYrG+Pz5HqI59Mr3aKQtGX7pDi7o4RM
         RWmp5UtwQ1cDvdrDvxECL3XMDq4qYx1FWnuPOJcQNsZrf6hsFTq4Xs2nIFRial0iIn3j
         3r8qecmsdUZFU0thRgD2fb91wcvPi1mWP2+4yCICzHHq6R6yoN35mdoA+M+YlUBaQjwP
         07wXykKNUg8r+Z9HQlNi01R18SqGl82U9FDKRed0aaErkd94vNQLksFmYUD5sjigWhBQ
         0FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyBF/TunLLNE9m64WGZW5xnvl+XVp1Tkb/4cWK4Q28U=;
        b=jFxQjqUpjZ4pzmAxttdoVWnE9+MYQFNXuNgeSSVcQZuLSIVddwMIq3AJd5nSxt2yoS
         pc71juhLUJxOy7M0Y19wQWPzm8YPNgqsfnT+iBKypL/NJBja0JT72nhbF1+4Pwlw+CSP
         ZGLA4sQRwwAJLECMTO2s8DuljKz4+4fA/QQZOl5A9qqvJo2JhTcuThg1fOnnKsAk8d0v
         y176Szp8NTRkLAOMHPK5XiX0ORSUvjyCbKx+j6IELj3+Zjmp0ZqRTjscDu1hacMqc4gF
         n9DJRl/jnyszwLL3iIAc0YycBJJdEeyJdLGxgBPQgF9mFOtOucogzB9tZSmqJMb4yqwo
         xbSA==
X-Gm-Message-State: APjAAAV6MqcJuqNsDvtMZ7Pf1De2t1JFI0/nCNaiaKrIDljfRiPSDFpN
        KpPL0L9c/bgOSv48RgRZolQ=
X-Google-Smtp-Source: APXvYqzEcxttqkABL1O/lcCnkyPEMLulzfgv4nN04dLirBIxyXJLvEBAWtWhQxnW9RRVVqiC+jWtUA==
X-Received: by 2002:aa7:914e:: with SMTP id 14mr284735pfi.136.1565043624587;
        Mon, 05 Aug 2019 15:20:24 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 185sm85744057pfd.125.2019.08.05.15.20.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 15:20:24 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 3/3] mm/ksm: convert put_page() to put_user_page*()
Date:   Mon,  5 Aug 2019 15:20:19 -0700
Message-Id: <20190805222019.28592-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805222019.28592-1-jhubbard@nvidia.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Daniel Black <daniel@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/ksm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3dc4346411e4..e10ee4d5fdd8 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -456,7 +456,7 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
  * We use break_ksm to break COW on a ksm page: it's a stripped down
  *
  *	if (get_user_pages(addr, 1, 1, 1, &page, NULL) == 1)
- *		put_page(page);
+ *		put_user_page(page);
  *
  * but taking great care only to touch a ksm page, in a VM_MERGEABLE vma,
  * in case the application has unmapped and remapped mm,addr meanwhile.
@@ -483,7 +483,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 					FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE);
 		else
 			ret = VM_FAULT_WRITE;
-		put_page(page);
+		put_user_page(page);
 	} while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
 	/*
 	 * We must loop because handle_mm_fault() may back out if there's
@@ -568,7 +568,7 @@ static struct page *get_mergeable_page(struct rmap_item *rmap_item)
 		flush_anon_page(vma, page, addr);
 		flush_dcache_page(page);
 	} else {
-		put_page(page);
+		put_user_page(page);
 out:
 		page = NULL;
 	}
@@ -1974,10 +1974,10 @@ struct rmap_item *unstable_tree_search_insert(struct rmap_item *rmap_item,
 
 		parent = *new;
 		if (ret < 0) {
-			put_page(tree_page);
+			put_user_page(tree_page);
 			new = &parent->rb_left;
 		} else if (ret > 0) {
-			put_page(tree_page);
+			put_user_page(tree_page);
 			new = &parent->rb_right;
 		} else if (!ksm_merge_across_nodes &&
 			   page_to_nid(tree_page) != nid) {
@@ -1986,7 +1986,7 @@ struct rmap_item *unstable_tree_search_insert(struct rmap_item *rmap_item,
 			 * it will be flushed out and put in the right unstable
 			 * tree next time: only merge with it when across_nodes.
 			 */
-			put_page(tree_page);
+			put_user_page(tree_page);
 			return NULL;
 		} else {
 			*tree_pagep = tree_page;
@@ -2328,7 +2328,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 							&rmap_item->rmap_list;
 					ksm_scan.address += PAGE_SIZE;
 				} else
-					put_page(*page);
+					put_user_page(*page);
 				up_read(&mm->mmap_sem);
 				return rmap_item;
 			}
-- 
2.22.0

