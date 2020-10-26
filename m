Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E12A299561
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789837AbgJZSbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:49 -0400
Received: from casper.infradead.org ([90.155.50.34]:47276 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789831AbgJZSbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jHLyIiDmxeGXLQCL76Xy90AvFA3vsDCNnmRUt/Ap55Y=; b=KPkJdabCvCiouVVwWZADVaDxtT
        QtXkiHVf4Fo+Lh2ULqRKFikslOihRo9GbzY7tmdv/EV1WF2yzqE90/XXZZbiYIzCVJnFYdemr5AES
        MT+E1/M6UFkaqsVhFCX/DcYBaZbuBWQrVR9Ik+0o4BvMarA+USkaRi+lL5shCv/gy+dQ79uBjxghU
        Rh7br//cL35PhZkz7r4XiTjLMyZb9xiNdQgwvD6+Xh5F0CoccrZJ6nusojPAG+m9KL98ux7qPAB6b
        3v32X0phAjQbT53q1ZEPLqPIKev4DV3niNXE2aHkT2f8wV74vTJZkH6m8LfjnzHkVKNkFPdwLgokU
        Bv9tW4BQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HT-0002jv-9N; Mon, 26 Oct 2020 18:31:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] mm/vmscan: Free non-shmem THPs without splitting them
Date:   Mon, 26 Oct 2020 18:31:34 +0000
Message-Id: <20201026183136.10404-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have to allocate memory in order to split a file-backed page,
so it's not a good idea to split them.  It also doesn't work for XFS
because pages have an extra reference count from page_has_private() and
split_huge_page() expects that reference to have already been removed.
Unfortunately, we still have to split shmem THPs because we can't handle
swapping out an entire THP yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1b8f0e059767..8e60ae2fabd1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1274,8 +1274,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
-		} else if (unlikely(PageTransHuge(page))) {
-			/* Split file THP */
+		} else if (PageSwapBacked(page) && PageTransHuge(page)) {
+			/* Split shmem THP */
 			if (split_huge_page_to_list(page, page_list))
 				goto keep_locked;
 		}
-- 
2.28.0

