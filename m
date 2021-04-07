Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C33575D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 22:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349387AbhDGUWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 16:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346468AbhDGUWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:22:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765BFC061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 13:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XJxjfpul1eNxNF+Mg0qXY4/QaDjRzgcozOLBBq/JMQ4=; b=NO1wZ0ng5My0UXMRmUZrF8qp3n
        XO3eIXlt3SgrgG0tN439rwnAiZRcmWD7d/UWEIxhzGip3u8E7uqX33r9Lc1mrx5L0/WPQOM3A73cA
        MPJta7+bnaD4cpnp9ldr/WBGoDlJh9VJTUJzuyy+t/2U4A9RpOkLlcjLBVFQuDWBVBuDRuzJ5FjUq
        w4LF0zpoe1zrwRSuJl942Em0rPpX7Llbjhsiz6Whnis5+FsTHEdc6Vn2NvE3jjS97qZ3ocq4MXBap
        4+iqojW/Plgc26kzypQRN4eqtR5q08SLsLqFGB0ahcxXrv1UfWpaasN4Hnydvwt2Y2xjFrItp+NqL
        wWnNSGvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUEfF-00F2CM-5b; Wed, 07 Apr 2021 20:20:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] mm/readahead: Adjust file_ra in readahead_expand
Date:   Wed,  7 Apr 2021 21:18:57 +0100
Message-Id: <20210407201857.3582797-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210407201857.3582797-1-willy@infradead.org>
References: <20210407201857.3582797-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we grow the readahead window, we should tell the ondemand algorithm
that we've grown it, so that the next readahead starts at the right place.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index e115b1174981..65215c48f25c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -661,6 +661,7 @@ void readahead_expand(struct readahead_control *ractl,
 		      loff_t new_start, size_t new_len)
 {
 	struct address_space *mapping = ractl->mapping;
+	struct file_ra_state *ra = ractl->ra;
 	pgoff_t new_index, new_nr_pages;
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 
@@ -705,6 +706,8 @@ void readahead_expand(struct readahead_control *ractl,
 			return;
 		}
 		ractl->_nr_pages++;
+		ra->size++;
+		ra->async_size++;
 	}
 }
 EXPORT_SYMBOL(readahead_expand);
-- 
2.30.2

