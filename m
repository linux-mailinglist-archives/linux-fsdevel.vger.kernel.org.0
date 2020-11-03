Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1096D2A4830
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgKCOah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgKCO24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:28:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA9FC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KTTZDmcpQ4d9/HeznDn2I0WFscOoJ8hJXoewGktnwEA=; b=qN3KSIZCuLCHof6lILGUn3CPPU
        ajweGMem1wz2yeC58cdTFEyA1J5ZfHJu5BE8qx2f7NlU2Fs/9w3yD7iaqa32jk0l2gQQBxKqvZ+xR
        U7IbiwuP0VQ7RSJ2myaelq9bd9WQJlTvW4V/woN1IUO8Y/UyhFiSJBFqA9kou5SNaVtrfy5TjT4rW
        7VmLM2ryVwotHOv/AmBpx83NDfGhOs20UyrkKCDbIaBaXxlJECrR3WZJl93JjO4ZCaDxSELjDF+0B
        x+R3GtzR9LXczQlJ+NMIw7qYsKybyYGCcNuND34wqN4RhTgMtwRkFyF60qTxwuElWz4O8kZ8nUanb
        nXiKQljw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZxIs-0002FD-4i; Tue, 03 Nov 2020 14:28:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>
Subject: [PATCH] mm: Fix readahead_page_batch for retry entries
Date:   Tue,  3 Nov 2020 14:28:52 +0000
Message-Id: <20201103142852.8543-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both btrfs and fuse have reported faults caused by seeing a retry
entry instead of the page they were looking for.  This was caused
by a missing check in the iterator.

Reported-by: David Sterba <dsterba@suse.com>
Reported-by: Wonhyuk Yang <vvghjk1234@gmail.com>
Fixes: 042124cc64c3 ("mm: add new readahead_control API")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b921581a7dcf..2ea741c2bb16 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -751,6 +751,8 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 	xas_set(&xas, rac->_index);
 	rcu_read_lock();
 	xas_for_each(&xas, page, rac->_index + rac->_nr_pages - 1) {
+		if (xas_retry(&xas, page))
+			continue;
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(PageTail(page), page);
 		array[i++] = page;
