Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FA02B1052
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgKLV1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgKLV1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:27:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E1C0613D1;
        Thu, 12 Nov 2020 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8GEXd5Ze60X4OYh6xIrRSvS9O7QAElyk7+6nVS10XRE=; b=qUppFtXXjLIsyxqhhhTIba7+5w
        Wz92hzrfGGRzwRAeLh3ftv3GoXSbkbKixG9PlAzzo8RHr+48BjLLPV2cqKTpcGHjDRHJWI9KPAxOR
        SEdNM7FB/9MtDEW9c+VO65VkfocuiZ0iSWIUJ/32eluFYoBwX8SFu3eQsHx0chO8aLITlbt6aWmzY
        x661/+vIxCVUckb2/uLhoVv9etRyhuz9g0UzgSd7V6kUcGvBsK8gkYhjVYc4JRzyPFxC2uTOWWUxl
        iu4NbxDXobKwDbrv50FSUPdAKCNR3RT9A3iONUCYwDmMkloUYojo+/iT09hLQfH01+oANSz2eHsZn
        oWIQ82UA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7A-0007G7-1Z; Thu, 12 Nov 2020 21:26:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 02/16] mm/shmem: Use pagevec_lookup in shmem_unlock_mapping
Date:   Thu, 12 Nov 2020 21:26:27 +0000
Message-Id: <20201112212641.27837-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
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
index 028f4596fc16..8076c171731c 100644
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

