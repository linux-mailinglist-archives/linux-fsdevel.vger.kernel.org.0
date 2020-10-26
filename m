Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12588298637
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422278AbgJZEln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:41:43 -0400
Received: from casper.infradead.org ([90.155.50.34]:60094 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421510AbgJZEln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=77sJtHQNYX1BOg5wgRb+5x5Ey0reVR4xYsh2AEFFWs0=; b=qZPapEVvLMGtwwMKEZdKqalBea
        fGV4x8P4djRsrOx3mNJZvcBgYPg7mNnZrIWZU99SlP5VJdUyYYS19diHZGGf3BeRSSI10jEDY1RpL
        Qe4GJy/AoXIsG8Xn/MVS6QggESPXQdgFmmhcxMEix+AQ1QMIktgxHpqURuUh7HIizZNRs5FH54Z52
        L9707duJAdRnye1BdWuqfd448PP0dJm3Ld/JeLSVXprY+EJFh82ug/HxbyUpI9dk1BF62TkiK0wDO
        HQHBk9LWD8JxWGrWYo8ZxlzWOjxaX6kqYTWYu+tco4HwQLlKG3Gzk5jA1RsKzgCnq1AH4oyQytXab
        yFzhYOyg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWtta-0006Zn-NA; Mon, 26 Oct 2020 04:14:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v3 02/12] mm/shmem: Use pagevec_lookup in shmem_unlock_mapping
Date:   Mon, 26 Oct 2020 04:13:58 +0000
Message-Id: <20201026041408.25230-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026041408.25230-1-willy@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The comment shows that the reason for using find_get_entries() is now
stale; find_get_pages() will not return 0 if it hits a consecutive run
of swap entries, and I don't believe it has since 2011.  pagevec_lookup()
is a simpler function to use than find_get_pages(), so use it instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/shmem.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..a33972126b60 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -842,7 +842,6 @@ unsigned long shmem_swap_usage(struct vm_area_struct *vma)
 void shmem_unlock_mapping(struct address_space *mapping)
 {
 	struct pagevec pvec;
-	pgoff_t indices[PAGEVEC_SIZE];
 	pgoff_t index = 0;
 
 	pagevec_init(&pvec);
@@ -850,16 +849,8 @@ void shmem_unlock_mapping(struct address_space *mapping)
 	 * Minor point, but we might as well stop if someone else SHM_LOCKs it.
 	 */
 	while (!mapping_unevictable(mapping)) {
-		/*
-		 * Avoid pagevec_lookup(): find_get_pages() returns 0 as if it
-		 * has finished, if it hits a row of PAGEVEC_SIZE swap entries.
-		 */
-		pvec.nr = find_get_entries(mapping, index,
-					   PAGEVEC_SIZE, pvec.pages, indices);
-		if (!pvec.nr)
+		if (!pagevec_lookup(&pvec, mapping, &index))
 			break;
-		index = indices[pvec.nr - 1] + 1;
-		pagevec_remove_exceptionals(&pvec);
 		check_move_unevictable_pages(&pvec);
 		pagevec_release(&pvec);
 		cond_resched();
-- 
2.28.0

